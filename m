Return-Path: <netdev+bounces-183305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB7A904D5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1120C8A4853
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D01212FA5;
	Wed, 16 Apr 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DCm09WYy"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EA2101BD;
	Wed, 16 Apr 2025 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811096; cv=none; b=meJH+DFJSsoWgmPYDJ4nG4Povmt/wyVs4MJUZi6BsmsUw3GIzelMK3yu740tB7d6B0W8uUjBdor1et2pI+dba7SApVgNTwoI8F6czVP8IwJcS0+ni9ABQUc7GWPVFr0VYJR6Wb/oSPcvCiLZUKU98zRqbijjgxy1hTyjS+M1rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811096; c=relaxed/simple;
	bh=PMiXXxN+KCLwUlSLL5q+YZfQDmTWvlObWvPkQUfkYOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyLiI+oSvZAFUVM8YXQFX0v+UoVJ4sPACtrAKoInN7nSrt/SUlJTfS084deIs4aTDXaq0NUGLDF1SVQFYssL1UkWVhPncFySLuEphE/1bkaURCKc2cKZO78mLLAtTAX/aZhMqeE/riCZQUopwCZweLaGyNw25uFphvv8anuMNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DCm09WYy; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB93F43923;
	Wed, 16 Apr 2025 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744811092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D9XhtteHmfTSF7g908k1ykukQx2F/anEAL1+dV+CME=;
	b=DCm09WYyExNtQWzQpeDVHdtYsNXJ76cbSAoo9xAeRtqL5xhQvuAdK06OW2r+LPC5BgI3w5
	p6vzcSr9n5Vcieox77FgKuddvoqNF9bjANuR/eQ4+J4T+bW/+QxY95xIlEhLzvhNanZMeq
	9p7UN582H7XyVc+fMwvl6HbSU6vXgmraLP5Kr9/W8AknG5LqoBu3gQ7e1UZml77e94al2Q
	VTwPOZ1hkVxA92/vYJ1CEERqgFpoiRC04m1zKZAGYA2xsKk9tUeOQzA3JK8O62uFCxh9RY
	/p9EH6JnMyrZDfG5mLIIK6Q+B0NJGw7VGsmvxDO6mEGs5CaO8+OEJvzAvKFAJA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Apr 2025 15:44:20 +0200
Subject: [PATCH net-next v8 05/13] net: ethtool: Add support for new power
 domains index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-feature_poe_port_prio-v8-5-446c39dc3738@bootlin.com>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
In-Reply-To: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehhohhrmhhssehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Report the index of the newly introduced PSE power domain to the user,
enabling improved management of the power budget for PSE devices.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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
 include/linux/pse-pd/pse.h                     | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h | 1 +
 net/ethtool/pse-pd.c                           | 7 +++++++
 6 files changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9f39a94671d9..e78dde7340ae 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1372,6 +1372,10 @@ attribute-sets:
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
@@ -2192,6 +2196,7 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - pse-pw-d-id
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 60f5ec7b80dd..49c9a0e79af5 100644
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
index 30d043af5b3f..e6b3c47d9892 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1072,6 +1072,9 @@ int pse_ethtool_get_status(struct pse_control *psec,
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
index 5201a0fb3d74..ffa6cf9a0072 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -112,6 +112,7 @@ struct pse_pw_limit_ranges {
 /**
  * struct ethtool_pse_control_status - PSE control/channel status.
  *
+ * @pw_d_id: PSE power domain index.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -133,6 +134,7 @@ struct pse_pw_limit_ranges {
  *	ranges
  */
 struct ethtool_pse_control_status {
+	u32 pw_d_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 549f01ea7a10..ccd7ab3bf1b1 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -633,6 +633,7 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+	ETHTOOL_A_PSE_PW_D_ID,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index dd377f9326fd..f73d4fbe82e6 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -84,6 +84,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	const struct ethtool_pse_control_status *st = &data->status;
 	int len = 0;
 
+	if (st->pw_d_id > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -149,6 +151,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
 	const struct ethtool_pse_control_status *st = &data->status;
 
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


