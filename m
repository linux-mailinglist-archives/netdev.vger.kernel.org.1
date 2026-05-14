Return-Path: <netdev+bounces-287983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKVFNlvXBWqacAIAu9opvQ
	(envelope-from <netdev+bounces-287983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F743542C7F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 403B13019B88
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5CF3DD869;
	Thu, 14 May 2026 14:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB33E274F;
	Thu, 14 May 2026 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767500; cv=none; b=WK39JnQsVueljGyezqbI7hA7c5gMJAWhZjIUWqXURLALCYHFQyllKpkUC6KIpFrnsJsYv8lPvNeazAph5yzjNY9DlWBI8ndlACJZhMxt7bY+wF8TeEODU8O7CKFw3+ZA2xphAdmOt5a/UaVAYnIPKmv248nobyLvwzVYX5VgiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767500; c=relaxed/simple;
	bh=msw+2dqkRGfaswFNEF8fRyQ+K6Voza/SOWKA5+NDjkg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc0yLDq1MZbusGmxdybyJxg5HNtErRo2M6bAlldYF0l006SpIvG604E8A9U0cdbdnUk8Xh9dvZbEivkRB1yRk/EpVOQMs/3i55AoMnwwf3y6eaf9SFWYmE/JIddgPvsMUsG8qBuxY89Qp+mxwoMRJs63m6FfSikPFTRSAlyQu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wNWgH-0000000045h-1jps;
	Thu, 14 May 2026 14:04:53 +0000
Date: Thu, 14 May 2026 15:04:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 3/5] net: dsa: mt7530: fix CPU port VLAN not being
 reset to unaware
Message-ID: <da8bdaf08b2427a9057e6cb33e26d41f8a8d5000.1778766629.git.daniel@makrotopia.org>
References: <cover.1778766629.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 2F743542C7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

After a VLAN-aware bridge is destroyed, creating any VLAN-unaware
bridge loses all connectivity. The VID 0 VLAN table entry used by
VLAN-unaware ports in FALLBACK mode gets corrupted during VLAN-aware
operation: mt7530_hw_vlan_add() overwrites its EG_CON flag with
VTAG_EN and bridge teardown removes ports from its PORT_MEM.

The cleanup code that should restore it never runs because the current
port's dp->vlan_filtering flag is still true when checked (DSA updates
it only after the driver callback returns). Even when restored, the
deferred VLAN deletion events from the switchdev workqueue can corrupt
VID 0 again after the restoration.

Skip the current port in the all_user_ports_removed check, call
mt7530_setup_vlan0() to restore the VID 0 entry, and protect VID 0
from being modified by bridge VLAN operations in port_vlan_add and
port_vlan_del since it is managed exclusively by mt7530_setup_vlan0().

Remove the CPU port PCR and PVC register writes which were clobbering
PORT_VLAN mode and VLAN_ATTR with wrong values.

Fixes: 83163f7dca56 ("net: dsa: mediatek: add VLAN support for MT7530")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/mt7530.c | 111 ++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4f657ef6aa65..752ba92b0851 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1623,6 +1623,49 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
+{
+	struct mt7530_dummy_poll p;
+	u32 val;
+	int ret;
+
+	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
+	mt7530_write(priv, MT7530_VTCR, val);
+
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_VTCR);
+	ret = readx_poll_timeout(_mt7530_read, &p, val,
+				 !(val & VTCR_BUSY), 20, 20000);
+	if (ret < 0) {
+		dev_err(priv->dev, "poll timeout\n");
+		return ret;
+	}
+
+	val = mt7530_read(priv, MT7530_VTCR);
+	if (val & VTCR_INVALID) {
+		dev_err(priv->dev, "read VTCR invalid\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+mt7530_setup_vlan0(struct mt7530_priv *priv)
+{
+	u32 val;
+
+	/* Validate the entry with independent learning, keep the original
+	 * ingress tag attribute.
+	 */
+	val = IVL_MAC | EG_CON | PORT_MEM(MT7530_ALL_MEMBERS) | FID(FID_BRIDGED) |
+	      VLAN_VALID;
+	mt7530_write(priv, MT7530_VAWD1, val);
+	mt7530_write(priv, MT7530_VAWD2, 0);
+
+	return mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, 0);
+}
+
 static void
 mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 {
@@ -1648,6 +1691,8 @@ mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 		   G0_PORT_VID_DEF);
 
 	for (i = 0; i < priv->ds->num_ports; i++) {
+		if (i == port)
+			continue;
 		if (dsa_is_user_port(ds, i) &&
 		    dsa_port_is_vlan_filtering(dsa_to_port(ds, i))) {
 			all_user_ports_removed = false;
@@ -1659,13 +1704,9 @@ mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 	 * the CPU port get out of VLAN filtering mode.
 	 */
 	if (all_user_ports_removed) {
-		struct dsa_port *dp = dsa_to_port(ds, port);
-		struct dsa_port *cpu_dp = dp->cpu_dp;
-
-		mt7530_write(priv, MT7530_PCR_P(cpu_dp->index),
-			     PCR_MATRIX(dsa_user_ports(priv->ds)));
-		mt7530_write(priv, MT7530_PVC_P(cpu_dp->index), PORT_SPEC_TAG
-			     | PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+		mutex_lock(&priv->reg_mutex);
+		mt7530_setup_vlan0(priv);
+		mutex_unlock(&priv->reg_mutex);
 	}
 }
 
@@ -1853,33 +1894,6 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	return ret;
 }
 
-static int
-mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
-{
-	struct mt7530_dummy_poll p;
-	u32 val;
-	int ret;
-
-	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
-	mt7530_write(priv, MT7530_VTCR, val);
-
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_VTCR);
-	ret = readx_poll_timeout(_mt7530_read, &p, val,
-				 !(val & VTCR_BUSY), 20, 20000);
-	if (ret < 0) {
-		dev_err(priv->dev, "poll timeout\n");
-		return ret;
-	}
-
-	val = mt7530_read(priv, MT7530_VTCR);
-	if (val & VTCR_INVALID) {
-		dev_err(priv->dev, "read VTCR invalid\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int
 mt7530_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 			   struct netlink_ext_ack *extack)
@@ -1984,21 +1998,6 @@ mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
 	mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, vid);
 }
 
-static int
-mt7530_setup_vlan0(struct mt7530_priv *priv)
-{
-	u32 val;
-
-	/* Validate the entry with independent learning, keep the original
-	 * ingress tag attribute.
-	 */
-	val = IVL_MAC | EG_CON | PORT_MEM(MT7530_ALL_MEMBERS) | FID(FID_BRIDGED) |
-	      VLAN_VALID;
-	mt7530_write(priv, MT7530_VAWD1, val);
-
-	return mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, 0);
-}
-
 static int
 mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan,
@@ -2011,9 +2010,18 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->reg_mutex);
 
+	/* VID 0 is managed exclusively by mt7530_setup_vlan0() for
+	 * VLAN-unaware bridge operation. Don't let the bridge overwrite
+	 * its EG_CON flag with VTAG_EN and corrupt PORT_MEM.
+	 */
+	if (vlan->vid == 0)
+		goto skip_vlan_table;
+
 	mt7530_hw_vlan_entry_init(&new_entry, port, untagged);
 	mt7530_hw_vlan_update(priv, vlan->vid, &new_entry, mt7530_hw_vlan_add);
 
+skip_vlan_table:
+
 	if (pvid) {
 		priv->ports[port].pvid = vlan->vid;
 
@@ -2053,10 +2061,15 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->reg_mutex);
 
+	/* VID 0 is managed exclusively by mt7530_setup_vlan0(). */
+	if (vlan->vid == 0)
+		goto skip_vlan_table;
+
 	mt7530_hw_vlan_entry_init(&target_entry, port, 0);
 	mt7530_hw_vlan_update(priv, vlan->vid, &target_entry,
 			      mt7530_hw_vlan_del);
 
+skip_vlan_table:
 	/* PVID is being restored to the default whenever the PVID port
 	 * is being removed from the VLAN.
 	 */
-- 
2.54.0

