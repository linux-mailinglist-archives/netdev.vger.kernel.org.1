Return-Path: <netdev+bounces-156631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD9A072D0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202EA7A20B3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794E21882C;
	Thu,  9 Jan 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aZM+HeKK"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9A21765F;
	Thu,  9 Jan 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417942; cv=none; b=Jb6sx/JDek9qO0WE6E7TdVG3x4a6canvg3lw52UMfAXm+BDu5K92d7EImn9Rv8ifZuEDwRVWySzSLfatu2nRUHO1cOxFNSlzbqkbXKhIzOT9f+dl5S0/0lYd5KsN4WuU+zS1x2kZsv+T15WegwWwCOlo3A6RlUuiTyqcU0nVm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417942; c=relaxed/simple;
	bh=KAAo33t+PFQjTSP+/AM9m1DpvmdhCrGL7hPndvBeVzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suOGLF/NL1Nw3JfZ1hiJLmPfDcrJQh9r2PxtYGSs7f6r8WzzejCRNRwi5uQibIue2XxMnOALjy5hHK3WlSsmqgVctsWas31fCi+GVd3Q6Dy7SOch4uJrMz26kVbLtY7/wTc1411PcRaEYzMkDUnSvpspNscKe+6XazlFs7ie8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aZM+HeKK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2433FE0006;
	Thu,  9 Jan 2025 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeX1HbrpUJS+W9YoIBoKr4wRFyS2jzsjjx9scrAVjDI=;
	b=aZM+HeKKK3UeoNg2CZ4MM1rwevJq9/TpjdGh6/JtyrbHvYoTFwbDtbPbYnO/4ImFiD6Pk1
	3fQh8wZIFu2VqScF6x1PUqkvQUhYSMi8hGNQ7o7CrFBGSgPv50YkMXwlA0mp5Mn36jpJ/Z
	fpAxacKhlhZWym6zKESNDfz3S15rblN8AozPmJbzOPMmWplfsDVogEk1kUBEOGxOQgxF1k
	bInFIKhc90S+8zLCuSCViSvaObWi3LxF0HKS2wx2Xwhk6lYoxnJ+b317ArFUXfmT5KI7pm
	BhDLobli1as5iBDiI043gB8skFH9XOaYVFg0tL6pQwuyTHPLotKzOtFeNTURnQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:06 +0100
Subject: [PATCH net-next v2 12/15] net: ethtool: Add support for new PSE
 device index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-12-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add functionality to report the newly introduced PSE device index to
the user, enabling better identification and management of PSE devices.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml       | 5 +++++
 Documentation/networking/ethtool-netlink.rst   | 4 ++++
 include/uapi/linux/ethtool_netlink.h           | 1 -
 include/uapi/linux/ethtool_netlink_generated.h | 1 +
 net/ethtool/pse-pd.c                           | 4 ++++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 60f85fbf4156..cc26a9dfa8f7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1357,6 +1357,10 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: c33-pse-pw-limit
+      -
+        name: pse-id
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attr-cnt-name: __ethtool-a-rss-cnt
@@ -2162,6 +2166,7 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - pse-id
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index a7ba6368a4d5..6f5a880d8df2 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1771,6 +1771,7 @@ Kernel response contents:
                                                       limit of the PoE PSE.
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
+  ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1844,6 +1845,9 @@ identifies the C33 PSE power limit ranges through
 If the controller works with fixed classes, the min and max values will be
 equal.
 
+The ``ETHTOOL_A_PSE_ID`` attribute identifies the index of the PSE
+controller.
+
 PSE_SET
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9c909ce733a5..335127b895fe 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -193,7 +193,6 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
-
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 43993a2d68e5..b3c928c71ca3 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -630,6 +630,7 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+	ETHTOOL_A_PSE_ID,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2819e2ba6be2..6cfdfaa47c1c 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -83,6 +83,7 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	const struct ethtool_pse_control_status *st = &data->status;
 	int len = 0;
 
+	len += nla_total_size(sizeof(u32)); /* _PSE_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -148,6 +149,9 @@ static int pse_fill_reply(struct sk_buff *skb,
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
 	const struct ethtool_pse_control_status *st = &data->status;
 
+	if (nla_put_u32(skb, ETHTOOL_A_PSE_ID, st->pse_id))
+		return -EMSGSIZE;
+
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,
 			st->podl_admin_state))

-- 
2.34.1


