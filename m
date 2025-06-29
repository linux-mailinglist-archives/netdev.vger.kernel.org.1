Return-Path: <netdev+bounces-202285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC9FAED12F
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0146D3B1727
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15E23B622;
	Sun, 29 Jun 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eccaXeAA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADD3D6F;
	Sun, 29 Jun 2025 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751231277; cv=none; b=OSl3NqmGDHcv6onuPQidBlqG5mO6m7ZeEgrvfdoxGJmjJBIR023YDQy8F4KETCCNwt8HA//NXf3bt+xg358qydI6dpQ+stvIayOC5n5x574Q3JeQvXByPzJqGls3iuwX7+/hmaPWHJ8d+bHfpsLp/nca2EHOCCgAtj35t73Wvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751231277; c=relaxed/simple;
	bh=IKofi0z/34lvlEXdPoxgt/LEYmwJ0XbFBt1OJO1u/08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hv2KNGIEOc8Hzooqo9XkW2pRt/QHF1d63CnlTqiZA7oCOv3tQ2sbuhB4+OdHvzwvfqrymPHLDBwsGQrGh98mHrs3TeHYDXC6V8qeMS8JPhzqHL8/phKNNuHQ6vtrErQ71WnZn1ET4x7C4HmTxuKI8uP3dsbfrbHIgIwfHU980zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eccaXeAA; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id VzEYuDauZBAWEVzEYuViuU; Sun, 29 Jun 2025 23:06:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751231205;
	bh=oN1+0ceBwvNVnPdeWRjShc9rKMxoodAlltZcZme4N18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eccaXeAAiLaY+pmMDTZaKcrNIvicOfe0/j9jQFzMYuHY9WMXeWEyeTMAeiUZdAcge
	 xSmm1jzHA/WombCIYKDHQWpipXUK9dm94u/bDgvEISkZ2r/kgZ/KpLoAubBcJ/VWGM
	 AF6JA94PvBVhruofSxQ0aV/17W7hMdDuMU7vZkVNTa733tc3H3QTbtsA6RguXkx2sz
	 yAju20voimcU1dgioH4++0qliEWEnqdfJvgdFUTMiNstWBKftbXMNOPi3RZw2uvxZT
	 OLyZeAGiuqoonJVnYDm6wsdXo+4LtDWdYTo+LYX5kG/MEELgdgo1ZppGUqM01OEl5y
	 AwZriaREJ7fnw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 23:06:45 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kurt Kanzenbach <kurt@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] net: dsa: hellcreek: Constify struct devlink_region_ops and struct hellcreek_fdb_entry
Date: Sun, 29 Jun 2025 23:06:38 +0200
Message-ID: <2f7e8dc30db18bade94999ac7ce79f333342e979.1751231174.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct devlink_region_ops' and 'struct hellcreek_fdb_entry' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  55320	  19216	    320	  74856	  12468	drivers/net/dsa/hirschmann/hellcreek.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  55960	  18576	    320	  74856	  12468	drivers/net/dsa/hirschmann/hellcreek.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/dsa/hirschmann/hellcreek.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 283ec5a6e23c..e0b4758ca583 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1061,7 +1061,7 @@ static void hellcreek_setup_tc_identity_mapping(struct hellcreek *hellcreek)
 
 static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 {
-	static struct hellcreek_fdb_entry l2_ptp = {
+	static const struct hellcreek_fdb_entry l2_ptp = {
 		/* MAC: 01-1B-19-00-00-00 */
 		.mac	      = { 0x01, 0x1b, 0x19, 0x00, 0x00, 0x00 },
 		.portmask     = 0x03,	/* Management ports */
@@ -1072,7 +1072,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,	/* TC: 6 as per IEEE 802.1AS */
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry udp4_ptp = {
+	static const struct hellcreek_fdb_entry udp4_ptp = {
 		/* MAC: 01-00-5E-00-01-81 */
 		.mac	      = { 0x01, 0x00, 0x5e, 0x00, 0x01, 0x81 },
 		.portmask     = 0x03,	/* Management ports */
@@ -1083,7 +1083,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry udp6_ptp = {
+	static const struct hellcreek_fdb_entry udp6_ptp = {
 		/* MAC: 33-33-00-00-01-81 */
 		.mac	      = { 0x33, 0x33, 0x00, 0x00, 0x01, 0x81 },
 		.portmask     = 0x03,	/* Management ports */
@@ -1094,7 +1094,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry l2_p2p = {
+	static const struct hellcreek_fdb_entry l2_p2p = {
 		/* MAC: 01-80-C2-00-00-0E */
 		.mac	      = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e },
 		.portmask     = 0x03,	/* Management ports */
@@ -1105,7 +1105,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,	/* TC: 6 as per IEEE 802.1AS */
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry udp4_p2p = {
+	static const struct hellcreek_fdb_entry udp4_p2p = {
 		/* MAC: 01-00-5E-00-00-6B */
 		.mac	      = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x6b },
 		.portmask     = 0x03,	/* Management ports */
@@ -1116,7 +1116,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry udp6_p2p = {
+	static const struct hellcreek_fdb_entry udp6_p2p = {
 		/* MAC: 33-33-00-00-00-6B */
 		.mac	      = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x6b },
 		.portmask     = 0x03,	/* Management ports */
@@ -1127,7 +1127,7 @@ static int hellcreek_setup_fdb(struct hellcreek *hellcreek)
 		.reprio_tc    = 6,
 		.reprio_en    = 1,
 	};
-	static struct hellcreek_fdb_entry stp = {
+	static const struct hellcreek_fdb_entry stp = {
 		/* MAC: 01-80-C2-00-00-00 */
 		.mac	      = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 },
 		.portmask     = 0x03,	/* Management ports */
@@ -1320,13 +1320,13 @@ static int hellcreek_devlink_region_fdb_snapshot(struct devlink *dl,
 	return 0;
 }
 
-static struct devlink_region_ops hellcreek_region_vlan_ops = {
+static const struct devlink_region_ops hellcreek_region_vlan_ops = {
 	.name	    = "vlan",
 	.snapshot   = hellcreek_devlink_region_vlan_snapshot,
 	.destructor = kfree,
 };
 
-static struct devlink_region_ops hellcreek_region_fdb_ops = {
+static const struct devlink_region_ops hellcreek_region_fdb_ops = {
 	.name	    = "fdb",
 	.snapshot   = hellcreek_devlink_region_fdb_snapshot,
 	.destructor = kfree,
@@ -1335,7 +1335,7 @@ static struct devlink_region_ops hellcreek_region_fdb_ops = {
 static int hellcreek_setup_devlink_regions(struct dsa_switch *ds)
 {
 	struct hellcreek *hellcreek = ds->priv;
-	struct devlink_region_ops *ops;
+	const struct devlink_region_ops *ops;
 	struct devlink_region *region;
 	u64 size;
 	int ret;
-- 
2.50.0


