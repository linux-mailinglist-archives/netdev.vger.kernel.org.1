Return-Path: <netdev+bounces-131308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A498E0B7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E6F28435C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70951D1F4A;
	Wed,  2 Oct 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XGhklBW4"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E21D150B;
	Wed,  2 Oct 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886554; cv=none; b=fAT/qU3rJhubnSX5jeTv5iWkbOppgKqCWAwPXYTS5vrbPKtuJd0NrPCgxM1/eJsmWI4qmj4KVHLWdE8dAzKOE3LHqjTdk17zeChppNRGmwJtcJ8WPW0162/EK5RRgRVg6sWhIVYWoxxKf0R/Qq1kt2+gQRiMjWDoon9OXur0r/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886554; c=relaxed/simple;
	bh=dTcmCIDnixPq3eiYaqAldz0ta+57NaOU0QQ7rLhKxWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVGFL1pjuT8U1AD7tAzH3f1eZn7I4AH91dnhEYjrhJTfUknJCCi+/3tW/5ifi6VkZ65rg/qbVeaUiPKQU/EPbaXZQdz7FqLiipxfgPPmimU1h6nsFqsZbwCqyYapvFcT+d7mgoNEvlbNnEECiWrgnlK3OKx1jY3zqKlUJvEwcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XGhklBW4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9B8F1BF20A;
	Wed,  2 Oct 2024 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GYugEsF4debH7Ai01HrEd8SCP3h/AFenW6Msf+6A9Y=;
	b=XGhklBW4yzbgHTAmBSvenfR1D9kIQznIoxWX/scZbiKXRr+PB/YodHY/58OP8hdoH47tI2
	TPy4unKF5ATDigSolSVaV0oKYwYt9QKxTFUPsdstQ4eTZaZbgHGR7957JDG8JhAqnbYPAO
	GX3z4sSaTx5Uqjc68wd549Kvl/K00bTyTiRyLOwU5FTekwlcqd6z+/sFZNKuc45I/+4G2T
	X7LmF7S3o/cNFIR66AYNWg8JtVH2fgmGZYT6YQPxsU6CVevRjMx8KZDS8RhqfWBuyepXch
	XM8K2Lb5rwh1Ag7qvCZ596HRITG8IStPz3SLIqibBYzbeQdwfRjrtaiuY1XhVw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:02 +0200
Subject: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with current port priority and max port priority. It also adds a call to
pse_ethtool_set_prio() to configure the PSE port priority.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 16 ++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |  2 ++
 net/ethtool/pse-pd.c                         | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..15208429a973 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1763,6 +1763,10 @@ Kernel response contents:
                                                       limit of the PoE PSE.
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
+  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  priority maximum configurable
+                                                      on the PoE PSE
+  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  priority of the PoE PSE
+                                                      currently configured
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1836,6 +1840,12 @@ identifies the C33 PSE power limit ranges through
 If the controller works with fixed classes, the min and max values will be
 equal.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute identifies
+the C33 PSE maximum priority value.
+
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
+identifies the currently configured C33 PSE priority.
+
 PSE_SET
 =======
 
@@ -1849,6 +1859,8 @@ Request contents:
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
                                                   power limit
+  ``ETHTOOL_A_C33_PSE_PRIO``                 u32  Control priority of the
+                                                  PoE PSE
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1871,6 +1883,10 @@ various existing products that document power consumption in watts rather than
 classes. If power limit configuration based on classes is needed, the
 conversion can be done in user space, for example by ethtool.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
+control the C33 PSE priority. Allowed priority value are between zero
+and the value of ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute.
+
 RSS_GET
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..874a4bca2e19 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -970,6 +970,8 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
+	ETHTOOL_A_C33_PSE_PRIO_MAX,		/* u32 */
+	ETHTOOL_A_C33_PSE_PRIO,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a..439739eaf2ed 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -109,6 +109,9 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += st->c33_pw_limit_nb_ranges *
 		       (nla_total_size(0) +
 			nla_total_size(sizeof(u32)) * 2);
+	if (st->c33_prio_max)
+		/* _C33_PSE_PRIO_MAX + _C33_PSE_PRIO */
+		len += nla_total_size(sizeof(u32)) * 2;
 
 	return len;
 }
@@ -198,6 +201,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	    pse_put_pw_limit_ranges(skb, st))
 		return -EMSGSIZE;
 
+	if (st->c33_prio_max > 0 &&
+	    (nla_put_u32(skb, ETHTOOL_A_C33_PSE_PRIO_MAX, st->c33_prio_max) ||
+	     nla_put_u32(skb, ETHTOOL_A_C33_PSE_PRIO, st->c33_prio)))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -219,6 +227,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
+	[ETHTOOL_A_C33_PSE_PRIO] = { .type = NLA_U32 },
 };
 
 static int
@@ -267,6 +276,15 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
+	if (tb[ETHTOOL_A_C33_PSE_PRIO]) {
+		unsigned int prio;
+
+		prio = nla_get_u32(tb[ETHTOOL_A_C33_PSE_PRIO]);
+		ret = pse_ethtool_set_prio(phydev->psec, info->extack, prio);
+		if (ret)
+			return ret;
+	}
+
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
 

-- 
2.34.1


