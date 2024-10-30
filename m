Return-Path: <netdev+bounces-140489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A39B69F6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D744C1C23811
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94405229B3A;
	Wed, 30 Oct 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y9whLtQM"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7C228B5D;
	Wed, 30 Oct 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307255; cv=none; b=oz/2WG1tsFuv+Db9hLLl+5bJuMRzmzc8QP+OiPj09HuWfqS/itPLPNklWTlTpK2i+gfs3WBvIlRIK77Cs9GR0mcef9Tj2wgeg98nsPfhXb+CGs4+G28JLzD8LeNqNfzPOTc7Q9HN3ESggyMPmG4Fx3J58I2g5TZxbVgXAaTemm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307255; c=relaxed/simple;
	bh=OySWQItgkpNZCnLFdhIqOtG3NIEaxxgpHQmQdeD2Duk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/26bwX46v50jZbP00w3P/xf4vzfj+pgx3nW+PPPV3JPYsF2qcko9gl8VerpteTe0u7cHPqrhmz66vUM5qqYulD+FJUO7ykPRWlSq3QrEufjwUxol6wCW2SFFCZtqSV/ggqyLY2ns4zwEyr7/DJVqxtddBFGqWW1DtHNXiJNlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y9whLtQM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 763F2C0002;
	Wed, 30 Oct 2024 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dziNS10ELnVbTBvXG7mY7ScmIfQ75je25h84Kh8NZY=;
	b=Y9whLtQMTUlGaOil42Z9dzJlwNjLmNx/6vxHQjEvAnC8RvB9oOmxZpGVQGDUqwB7u0T60/
	HKEFyKRhsjPq6LAawMwBmZiws1honlATRmOVMKDGOMKASk4c56F8ON3vV+C+2vZ+qi5e1e
	KT3+TJAFT/UiMmLtwio+BXPW2dGjb4sInifdR2DGCLZ4VJ3+YzEk9JyN8TZwB0vYXlAHA0
	IZwOV2eAq/yVyOkGzjbK1QKy4l2/yZ4slox4H+wTpsljdBSJ3BGvzx+yIZG02zU7N8a9t9
	nmYacIOkOlP35ph16YwAJlyJHFcM6oi2jz8mm6GfFtyhzGWCxhOGLTtDDs/UCQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:16 +0100
Subject: [PATCH RFC net-next v2 14/18] net: ethtool: Add support for new
 power domains index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-14-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Report the index of the newly introduced PSE power domain to the user,
enabling improved management of the power budget for PSE devices.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- new patch.
---
 Documentation/networking/ethtool-netlink.rst | 4 ++++
 drivers/net/pse-pd/pse_core.c                | 1 +
 include/linux/pse-pd/pse.h                   | 2 ++
 include/uapi/linux/ethtool_netlink.h         | 1 +
 net/ethtool/pse-pd.c                         | 7 +++++++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index bd7173d1fa4d..3573543ae5ad 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1767,6 +1767,7 @@ Kernel response contents:
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
+  ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1843,6 +1844,9 @@ equal.
 The ``ETHTOOL_A_PSE_ID`` attribute identifies the index of the PSE
 controller.
 
+The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
+domain.
+
 PSE_SET
 =======
 
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 13f6ddcfca10..29374b1ce378 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1000,6 +1000,7 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 	}
 
 	status->pse_id = pcdev->id;
+	status->pw_d_id = pcdev->pi[id].pw_d->id;
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 3b35dc0f8dc3..e275ef7e1eb0 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -40,6 +40,7 @@ struct pse_control_config {
  * struct pse_control_status - PSE control/channel status.
  *
  * @pse_id: index number of the PSE. Set by PSE core.
+ * @pw_d_id: PSE power domain index. Set by PSE core.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -62,6 +63,7 @@ struct pse_control_config {
  */
 struct pse_control_status {
 	u32 pse_id;
+	u32 pw_d_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 526b8b099c0e..47784a165e8b 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -972,6 +972,7 @@ enum {
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
 	ETHTOOL_A_PSE_ID,			/* u32 */
+	ETHTOOL_A_PSE_PW_D_ID,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 52df956db0ba..1288e8a2c3a7 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -84,6 +84,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	int len = 0;
 
 	len += nla_total_size(sizeof(u32)); /* _PSE_ID */
+	if (st->pw_d_id > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -152,6 +154,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	if (nla_put_u32(skb, ETHTOOL_A_PSE_ID, st->pse_id))
 		return -EMSGSIZE;
 
+	if (st->pw_d_id > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_PW_D_ID,
+			st->pw_d_id))
+		return -EMSGSIZE;
+
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,
 			st->podl_admin_state))

-- 
2.34.1


