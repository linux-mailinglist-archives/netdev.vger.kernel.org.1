Return-Path: <netdev+bounces-20367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EF75F2AF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAC02815AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC88C05;
	Mon, 24 Jul 2023 10:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8E18C03
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:17:02 +0000 (UTC)
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 03:17:00 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CBFE49DB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:17:00 -0700 (PDT)
Received: from hq-00595.holoplot.net (unknown [62.214.9.170])
	by mail.bugwerft.de (Postfix) with ESMTPSA id 4149B280454;
	Mon, 24 Jul 2023 10:11:06 +0000 (UTC)
From: Daniel Mack <daniel.mack@holoplot.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	Daniel Mack <daniel.mack@holoplot.com>
Subject: [PATCH] net: dsa: mv88e6xxx: use distinct FIDs for each bridge
Date: Mon, 24 Jul 2023 12:10:59 +0200
Message-ID: <20230724101059.2228381-1-daniel.mack@holoplot.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow setups with overlapping VLAN IDs in different bridges by settting
the FID of all bridge ports to the index of the bridge.

Read the FID back when detecting overlaps.

Signed-off-by: Daniel Mack <daniel.mack@holoplot.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7d51a539451..dff271981c69 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2028,6 +2028,7 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_vtu_entry vlan;
 	int err;
+	u16 fid;
 
 	/* DSA and CPU ports have to be members of multiple vlans */
 	if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp))
@@ -2037,11 +2038,16 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = mv88e6xxx_port_get_fid(chip, port, &fid);
+	if (err)
+		return err;
+
 	if (!vlan.valid)
 		return 0;
 
 	dsa_switch_for_each_user_port(other_dp, ds) {
 		struct net_device *other_br;
+		u16 other_fid;
 
 		if (vlan.member[other_dp->index] ==
 		    MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_NON_MEMBER)
@@ -2054,6 +2060,10 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
 		if (!other_br)
 			continue;
 
+		err = mv88e6xxx_port_get_fid(chip, other_dp->index, &other_fid);
+		if (err == 0 && fid != other_fid)
+			continue;
+
 		dev_err(ds->dev, "p%d: hw VLAN %d already used by port %d in %s\n",
 			port, vlan.vid, other_dp->index, netdev_name(other_br));
 		return -EOPNOTSUPP;
@@ -2948,6 +2958,11 @@ static int mv88e6xxx_port_bridge_join(struct dsa_switch *ds, int port,
 		*tx_fwd_offload = true;
 	}
 
+	/* Set the port's FID to the bridge index so bridges can have
+	 * overlapping VLANs.
+	 */
+	err = mv88e6xxx_port_set_fid(chip, port, bridge.num);
+
 unlock:
 	mv88e6xxx_reg_unlock(chip);
 
-- 
2.41.0


