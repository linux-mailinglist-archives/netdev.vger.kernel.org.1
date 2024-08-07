Return-Path: <netdev+bounces-116459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DA94A7A2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA93CB24DFF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A71E4F05;
	Wed,  7 Aug 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RKHVsAg7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F721C9DD6;
	Wed,  7 Aug 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033425; cv=none; b=MO1TpC/a8VJdhTqgXb1c7jqCn44lSxTseznx2B3XbBSCccoD/AqCNnoLmqB3ZM+fTzK4576hZZmDV7JqJQbb3tbu4fa/6OQ1PPOm/+2D+I/VI51P5kWCqhwdQymjOwXxng/EG0Z/QZ7jLDKlSRdu7LMRbrpDzawYsiYi3s4TMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033425; c=relaxed/simple;
	bh=Kd8ZYPHe25vG2eDzqFvrOHnmPDTkChniLiTdkVWbau8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCnFO0Q/EiXxNOdOE9slAsApZBPUDyG9zcK3VHxm3J9cSl4L9YPsZzwQK0uQ0mg3BpMAxdTRSk118ipMUq0A5JVwKQt+PzPRXzhvLfMSO//dFrVw++XRPOkPZsuryHsKuvFwYzAbnVVDZCFSbkZj7moZv3FMr5WUP5vIZHdMLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RKHVsAg7; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bfgVsJsx2KPqXbfgVsKM2e; Wed, 07 Aug 2024 14:22:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723033353;
	bh=P5S3EiUnzX8DlZ1LXJZ7HdgTZoR7+DwXQZ88EGRCynw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RKHVsAg7q85zqrxD81rEM2BuP0isjBUjHF7q/qWPIiphEqyPJapEiyy7d5ivj+JmS
	 KBtUKcjzIKhb/yeZbmWn7iXR7KL5O0eBMSzqFwiarzA4ncnN5oIYEOE3JX2y4WxSXU
	 dT70jZvYcn/DWXraL4cVGx/yUUCxNLM7T8lEzDbS3xysNwe25tlTK8PDC0FsrcD712
	 oILy5LOheHcKSotBtTKxF+qkAxV13M2r7pICb3SEgWRZjnr2xwtem7/2YDlDPkGQsT
	 PfIY2h4NAHkmPJyI0pECHFiNqdlcAvyJ+VSRRJ49rWDmIst9ZbtpM6MoMXXJAbaTj/
	 1zoYvVV//vTyA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Aug 2024 14:22:33 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: sungem_phy: Constify struct mii_phy_def
Date: Wed,  7 Aug 2024 14:22:26 +0200
Message-ID: <54c3b30930f80f4895e6fa2f4234714fdea4ef4e.1723033266.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mii_phy_def' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.

While at it fix the checkpatch warning related to this patch (some missing
newlines and spaces around *)

On a x86_64, with allmodconfig:
Before:
======
  27709	    928	      0	  28637	   6fdd	drivers/net/sungem_phy.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  28157	    476	      0	  28633	   6fd9	drivers/net/sungem_phy.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/net/sungem_phy.c   | 35 +++++++++++++++++++----------------
 include/linux/sungem_phy.h |  2 +-
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index d591e33268e5..55aa8d0c8e1f 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -893,7 +893,7 @@ static const struct mii_phy_ops bcm5201_phy_ops = {
 	.read_link	= genmii_read_link,
 };
 
-static struct mii_phy_def bcm5201_phy_def = {
+static const struct mii_phy_def bcm5201_phy_def = {
 	.phy_id		= 0x00406210,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5201",
@@ -912,7 +912,7 @@ static const struct mii_phy_ops bcm5221_phy_ops = {
 	.read_link	= genmii_read_link,
 };
 
-static struct mii_phy_def bcm5221_phy_def = {
+static const struct mii_phy_def bcm5221_phy_def = {
 	.phy_id		= 0x004061e0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5221",
@@ -930,7 +930,8 @@ static const struct mii_phy_ops bcm5241_phy_ops = {
 	.poll_link	= genmii_poll_link,
 	.read_link	= genmii_read_link,
 };
-static struct mii_phy_def bcm5241_phy_def = {
+
+static const struct mii_phy_def bcm5241_phy_def = {
 	.phy_id		= 0x0143bc30,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5241",
@@ -949,7 +950,7 @@ static const struct mii_phy_ops bcm5400_phy_ops = {
 	.read_link	= bcm54xx_read_link,
 };
 
-static struct mii_phy_def bcm5400_phy_def = {
+static const struct mii_phy_def bcm5400_phy_def = {
 	.phy_id		= 0x00206040,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5400",
@@ -968,7 +969,7 @@ static const struct mii_phy_ops bcm5401_phy_ops = {
 	.read_link	= bcm54xx_read_link,
 };
 
-static struct mii_phy_def bcm5401_phy_def = {
+static const struct mii_phy_def bcm5401_phy_def = {
 	.phy_id		= 0x00206050,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5401",
@@ -987,7 +988,7 @@ static const struct mii_phy_ops bcm5411_phy_ops = {
 	.read_link	= bcm54xx_read_link,
 };
 
-static struct mii_phy_def bcm5411_phy_def = {
+static const struct mii_phy_def bcm5411_phy_def = {
 	.phy_id		= 0x00206070,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5411",
@@ -1007,7 +1008,7 @@ static const struct mii_phy_ops bcm5421_phy_ops = {
 	.enable_fiber   = bcm5421_enable_fiber,
 };
 
-static struct mii_phy_def bcm5421_phy_def = {
+static const struct mii_phy_def bcm5421_phy_def = {
 	.phy_id		= 0x002060e0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5421",
@@ -1026,7 +1027,7 @@ static const struct mii_phy_ops bcm5421k2_phy_ops = {
 	.read_link	= bcm54xx_read_link,
 };
 
-static struct mii_phy_def bcm5421k2_phy_def = {
+static const struct mii_phy_def bcm5421k2_phy_def = {
 	.phy_id		= 0x002062e0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5421-K2",
@@ -1045,7 +1046,7 @@ static const struct mii_phy_ops bcm5461_phy_ops = {
 	.enable_fiber   = bcm5461_enable_fiber,
 };
 
-static struct mii_phy_def bcm5461_phy_def = {
+static const struct mii_phy_def bcm5461_phy_def = {
 	.phy_id		= 0x002060c0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5461",
@@ -1064,7 +1065,7 @@ static const struct mii_phy_ops bcm5462V_phy_ops = {
 	.read_link	= bcm54xx_read_link,
 };
 
-static struct mii_phy_def bcm5462V_phy_def = {
+static const struct mii_phy_def bcm5462V_phy_def = {
 	.phy_id		= 0x002060d0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5462-Vesta",
@@ -1094,7 +1095,7 @@ static const struct mii_phy_ops marvell88e1111_phy_ops = {
 /* two revs in darwin for the 88e1101 ... I could use a datasheet
  * to get the proper names...
  */
-static struct mii_phy_def marvell88e1101v1_phy_def = {
+static const struct mii_phy_def marvell88e1101v1_phy_def = {
 	.phy_id		= 0x01410c20,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Marvell 88E1101v1",
@@ -1102,7 +1103,8 @@ static struct mii_phy_def marvell88e1101v1_phy_def = {
 	.magic_aneg	= 1,
 	.ops		= &marvell88e1101_phy_ops
 };
-static struct mii_phy_def marvell88e1101v2_phy_def = {
+
+static const struct mii_phy_def marvell88e1101v2_phy_def = {
 	.phy_id		= 0x01410c60,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Marvell 88E1101v2",
@@ -1110,7 +1112,8 @@ static struct mii_phy_def marvell88e1101v2_phy_def = {
 	.magic_aneg	= 1,
 	.ops		= &marvell88e1101_phy_ops
 };
-static struct mii_phy_def marvell88e1111_phy_def = {
+
+static const struct mii_phy_def marvell88e1111_phy_def = {
 	.phy_id		= 0x01410cc0,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Marvell 88E1111",
@@ -1127,7 +1130,7 @@ static const struct mii_phy_ops generic_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def genmii_phy_def = {
+static const struct mii_phy_def genmii_phy_def = {
 	.phy_id		= 0x00000000,
 	.phy_id_mask	= 0x00000000,
 	.name		= "Generic MII",
@@ -1136,7 +1139,7 @@ static struct mii_phy_def genmii_phy_def = {
 	.ops		= &generic_phy_ops
 };
 
-static struct mii_phy_def* mii_phy_table[] = {
+static const struct mii_phy_def *mii_phy_table[] = {
 	&bcm5201_phy_def,
 	&bcm5221_phy_def,
 	&bcm5241_phy_def,
@@ -1156,9 +1159,9 @@ static struct mii_phy_def* mii_phy_table[] = {
 
 int sungem_phy_probe(struct mii_phy *phy, int mii_id)
 {
+	const struct mii_phy_def *def;
 	int rc;
 	u32 id;
-	struct mii_phy_def* def;
 	int i;
 
 	/* We do not reset the mii_phy structure as the driver
diff --git a/include/linux/sungem_phy.h b/include/linux/sungem_phy.h
index c505f30e8b68..eecc7eb63bfb 100644
--- a/include/linux/sungem_phy.h
+++ b/include/linux/sungem_phy.h
@@ -40,7 +40,7 @@ enum {
 /* An instance of a PHY, partially borrowed from mii_if_info */
 struct mii_phy
 {
-	struct mii_phy_def*	def;
+	const struct mii_phy_def *def;
 	u32			advertising;
 	int			mii_id;
 
-- 
2.45.2


