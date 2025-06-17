Return-Path: <netdev+bounces-198557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB05ADCAB5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6998B188DB30
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7C2E06FC;
	Tue, 17 Jun 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zd1N0Zzj"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EB2DA753;
	Tue, 17 Jun 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162344; cv=none; b=iVN7uSQY3q/9BX8g3JPkVVfCSPCyLoKWLjX7MOoSISeMWXbE9NTCuqeuk/E9E1wE5PJRU5AMheI5c8GMTh1cYxIxlrjpK9droPSQktrxd23SFQ0x5PgJEKvVfgQanCkqlnB4wYymmv8Xw4SBDOrRe2BiV495lPt3hoV01ep0ieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162344; c=relaxed/simple;
	bh=b2ramXA7WDiddwHvOyc2rdCp2HujwluILQb+xuD72nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHTwcfLN9wweZ+u07FWo1ZOlIMCOgE61yaubOCe5Jgsfs6IkLwYdxndb9x9qWTKHKh/tsuC0l8rBfpIyV/n8l1a2s0SPzmrPFVRD/bgVld7KsYu/U6iIR2Q+OoL/pW3BZuEmU6l5nSUyWMTCk33ovXqFudO+DS/RBK1TRn+AD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zd1N0Zzj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52CFF439F6;
	Tue, 17 Jun 2025 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750162340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9CG1jbgujwSWclC/ew/MoVPCcqpOJrBrX2yshzx8iI=;
	b=Zd1N0ZzjpukWzefeYP9Do10AVYt6QyTbgX+qjOedw/3nzWOP9t6GjnQvruJ4+lukVmzt6T
	7LUpNJAm3rFvQJsuHLh/6SM8YOmkuNomAGlAvSOpxFMkaZMMYfhXW6gD33Kcr6FTeCfiEV
	BhilcmiGyIFWwjCs/lHH6r2J6PE8VhaAe44HIxhOtoOzrRV+IRv0yE0RsAFEeDrRK8UvLC
	LOhmifHfZoxpYQiTcgWYSUxk3ky4sq53m/SSedpcMLMUHMaKaPz/C+hFiSZhIa1q+9istB
	uRmue8KVTm8QyQ1q1G5TGGrq4fZq02QTaFGVB/4M6hZmqRDTVLqfEcpH/aDL5w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Jun 2025 14:12:04 +0200
Subject: [PATCH net-next v14 05/13] net: ethtool: Add support for new power
 domains index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-feature_poe_port_prio-v14-5-78a1a645e2ee@bootlin.com>
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Report the index of the newly introduced PSE power domain to the user,
enabling improved management of the power budget for PSE devices.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---

Changes in v13:
- Small change, no need for >0 condition check for unsigned variables.

Changes in v3:
- Do not support power domain id = 0 because we can't differentiate with
  no PSE power domain.

Changes in v2:
- new patch.
---
 Documentation/netlink/specs/ethtool.yaml       | 5 +++++
 Documentation/networking/ethtool-netlink.rst   | 4 ++++
 drivers/net/pse-pd/pse_core.c                  | 3 +++
 include/linux/pse-pd/pse.h                     | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h | 1 +
 net/ethtool/pse-pd.c                           | 7 +++++++
 6 files changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 92b34a19f308..dfd9b842a4e7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1406,6 +1406,10 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: c33-pse-pw-limit
+      -
+        name: pse-pw-d-id
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attr-cnt-name: __ethtool-a-rss-cnt
@@ -2229,6 +2233,7 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - pse-pw-d-id
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 433737865bc2..e9af8e58564c 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1789,6 +1789,7 @@ Kernel response contents:
                                                       limit of the PoE PSE.
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
+  ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1862,6 +1863,9 @@ identifies the C33 PSE power limit ranges through
 If the controller works with fixed classes, the min and max values will be
 equal.
 
+The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
+domain.
+
 PSE_SET
 =======
 
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f2fb7ccbc4c2..7d424c22225e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1098,6 +1098,9 @@ int pse_ethtool_get_status(struct pse_control *psec,
 	pcdev = psec->pcdev;
 	ops = pcdev->ops;
 	mutex_lock(&pcdev->lock);
+	if (pcdev->pi[psec->id].pw_d)
+		status->pw_d_id = pcdev->pi[psec->id].pw_d->id;
+
 	ret = ops->pi_get_admin_state(pcdev, psec->id, &admin_state);
 	if (ret)
 		goto out;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index f736b1677ea5..2f8ecfd87d43 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -114,6 +114,7 @@ struct pse_pw_limit_ranges {
 /**
  * struct ethtool_pse_control_status - PSE control/channel status.
  *
+ * @pw_d_id: PSE power domain index.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -135,6 +136,7 @@ struct pse_pw_limit_ranges {
  *	ranges
  */
 struct ethtool_pse_control_status {
+	u32 pw_d_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 3864aa0de8c7..ed344c8533eb 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -652,6 +652,7 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+	ETHTOOL_A_PSE_PW_D_ID,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 5443b4e0065a..6a978a55959e 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -83,6 +83,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	const struct ethtool_pse_control_status *st = &data->status;
 	int len = 0;
 
+	if (st->pw_d_id)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -148,6 +150,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
 	const struct ethtool_pse_control_status *st = &data->status;
 
+	if (st->pw_d_id &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_PW_D_ID,
+			st->pw_d_id))
+		return -EMSGSIZE;
+
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,
 			st->podl_admin_state))

-- 
2.43.0


