Return-Path: <netdev+bounces-155089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD4A00F8F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6C218854FC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053741FF5EF;
	Fri,  3 Jan 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jBTFmLj2"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC21FF1B7;
	Fri,  3 Jan 2025 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938876; cv=none; b=l93i0LHeshCfpcByYe+qLytXWo7fUQ7UOz/CdKUQWMLD0kdQUR0FJ2F7HW+XN/NKCEwYGrKC/LPPRFcTcYeOFKQfsFVx1Oc5EaopJjoAN3MtUCvcuwgOxpDsNjmW4dOe9yIJx3Etj+bCbZCvBx1vbYIVDM90FfNidO16i7YKDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938876; c=relaxed/simple;
	bh=L2MWAt/4dhOPc/HBzTnswNvrOmsbVZbLJTrK24xAdW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hW9m54OHrfwp39MmqrmAffdgZkMpNoaA4Qv5axw+H5pQzP0OL1fIuksrR5yrxdUIF+Z+9QRS7QYFg6VbK2h3plqc7BbiQIQsyGx4e+SM1UQvyPAPsTWw585z7tC61pehnbBGKod+QrwPzfi+PxywyjZUpjTkEO/xKGt80TyJwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jBTFmLj2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28E31FF803;
	Fri,  3 Jan 2025 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjzG2nfn2vbxFn1AHHZjvp7Q8T656xgbHd/YECVz1z4=;
	b=jBTFmLj2i09vrrexvP4ktWSt+leSbBcDB26DF3HzUei6aG0/aYnt67Stj3TBSNzmuJY9y8
	wu0/O04ZLQ6ikOp4aCjx4JxnaQFiOXp8WDOQDcIt+e0DSiTeMZ2PCXN8TMSkSYe4dVtVjF
	qXozH43myK4ql5b32Mxq9z3tGwi7/AMjnOatKjhdBTWq/lAhtTTDdpY6UcaJt1JjW2Qotv
	9a0Ih9FRiohkelP3BX5Gc6Wv2oYMjwII6X7zO2u6NDZjg1zyB+f+7b7iN4Gg0lFuzieIFt
	rH9Se+Jrs9U7QcRPo7hnkRm+GeX1WAp9PH7JqififfaF9qDSyg7tpUEtRtfgKw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:10 +0100
Subject: [PATCH net-next v4 21/27] net: ethtool: Add support for new power
 domains index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-21-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Report the index of the newly introduced PSE power domain to the user,
enabling improved management of the power budget for PSE devices.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Do not support power domain id = 0 because we can't differentiate with
  no PSE power domain.

Changes in v2:
- new patch.
---
 Documentation/netlink/specs/ethtool.yaml       | 5 +++++
 Documentation/networking/ethtool-netlink.rst   | 4 ++++
 drivers/net/pse-pd/pse_core.c                  | 3 +++
 include/linux/ethtool.h                        | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h | 1 +
 net/ethtool/pse-pd.c                           | 7 +++++++
 6 files changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9aa62137166a..686181440d58 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1361,6 +1361,10 @@ attribute-sets:
         name: pse-id
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: pse-pw-d-id
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attr-cnt-name: __ethtool-a-rss-cnt
@@ -2183,6 +2187,7 @@ operations:
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
             - pse-id
+            - pse-pw-d-id
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 9d836fa670df..68c0cfcea127 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1773,6 +1773,7 @@ Kernel response contents:
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
+  ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1849,6 +1850,9 @@ equal.
 The ``ETHTOOL_A_PSE_ID`` attribute identifies the index of the PSE
 controller.
 
+The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
+domain.
+
 PSE_SET
 =======
 
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 6bfe0fca90b4..9c482d341b9c 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1052,6 +1052,9 @@ int pse_ethtool_get_status(struct pse_control *psec,
 	status->pse_id = pcdev->id;
 
 	mutex_lock(&pcdev->lock);
+	if (pcdev->pi[psec->id].pw_d)
+		status->pw_d_id = pcdev->pi[psec->id].pw_d->id;
+
 	ret = ops->pi_get_admin_state(pcdev, psec->id, &admin_state);
 	if (ret)
 		goto out;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d5d13a3d4447..1ae0651b2ebd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1328,6 +1328,7 @@ struct ethtool_c33_pse_pw_limit_range {
  * struct ethtool_pse_control_status - PSE control/channel status.
  *
  * @pse_id: index number of the PSE.
+ * @pw_d_id: PSE power domain index.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -1350,6 +1351,7 @@ struct ethtool_c33_pse_pw_limit_range {
  */
 struct ethtool_pse_control_status {
 	u32 pse_id;
+	u32 pw_d_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 7293592fd689..1ec5a0838f50 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -631,6 +631,7 @@ enum {
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
 	ETHTOOL_A_PSE_ID,
+	ETHTOOL_A_PSE_PW_D_ID,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index bbc9ae910e02..00b97712767d 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -85,6 +85,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	int len = 0;
 
 	len += nla_total_size(sizeof(u32)); /* _PSE_ID */
+	if (st->pw_d_id > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -153,6 +155,11 @@ static int pse_fill_reply(struct sk_buff *skb,
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


