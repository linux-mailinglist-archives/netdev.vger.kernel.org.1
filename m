Return-Path: <netdev+bounces-103636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B77908D82
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2857F28BF1D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0793B1AB;
	Fri, 14 Jun 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bsAQDRC5"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9E125D6;
	Fri, 14 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375614; cv=none; b=Tn/OzuZyWagSZeJsmx5vhANPpPKVb8K88Tm6Ytf2ASNuv/OVOJjcvOBgd0puo7fdZUfbG4S4oehHwsaX3QxXUBcs001GwSa1fKEURdwhAnD2a2f/+nO6YcId9RBV/lONtLKVNUPPdYgW5LPnVqz43aF2WDaotKpFodn7BxBwpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375614; c=relaxed/simple;
	bh=f2foVGnDmtLNFLTWGaPAp0ELsaa/CDdmZlIz1Kyaq2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VybLmD3s9WTatXSLlVlZPWIeOOlw6mQTkzueXPh+cw9PSd9XUgZz2BNi8UgDj33JqK9TduIR1AwqnX7EFZnj9YhJm46ka/uisVpODt5M1aljM1sW846kfEISLdkf3UBx1vD5lFNXGa3BxbMMeMbQd+g2dS2MPsTHspQgKl38VKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bsAQDRC5; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE3181C0010;
	Fri, 14 Jun 2024 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNSoc0zeASEcpl+kuxr5gAcph89UDDOni8MPifxnry4=;
	b=bsAQDRC5AAVZAyOieHkukauKckImUl0+u39IM4EoZknPI4Fc0ZRxIF7pfLjdZisRupRjyf
	31/wzHduxvxCU07uFiEMoJgXlj6frkQhjONlgB8fiCj+h9+JhgBjFoTPMH3DQ91EtvhVbd
	/RdW72Jl0XkAnwD5mWh7/qnedksOZYaAC2L0OV2xmUtoTzWpTg8lVv7XTPwwnvk1aFzeKZ
	JpEMzVbdQJqO1wTdcrwxKtrY2oXbHsjgPOUrlYA/iO8YyjvHOuAV3vqKNj8n04JVtQF1hU
	LG9EvCFFcP00mw4ahgC6iGC+gN1L1F6MDJJum7A4HIZhFU+Fi7fXOe1K2LiZ3w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 14 Jun 2024 16:33:21 +0200
Subject: [PATCH net-next v3 5/7] net: ethtool: Add new power limit get and
 set features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
In-Reply-To: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with power limit. It also adds a call to pse_ethtool_set_pw_limit() to
configure the PSE control power limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Add ethtool netlink documentation.
---
 Documentation/networking/ethtool-netlink.rst |  8 ++++++
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/pse-pd.c                         | 42 +++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 7dbf2ef3ac0e..a78b6aea84af 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1737,6 +1737,7 @@ Kernel response contents:
                                                   PoE PSE.
   ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``         u32  power extended substatus of
                                                   the PoE PSE.
+  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  power limit of the PoE PSE.
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1799,6 +1800,9 @@ Possible values are:
 		  ethtool_c33_pse_ext_substate_power_not_available
 		  ethtool_c33_pse_ext_substate_short_detected
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute identifies
+the C33 PSE power limit in mW.
+
 PSE_SET
 =======
 
@@ -1810,6 +1814,7 @@ Request contents:
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
+  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  Control PoE PSE power limit
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1820,6 +1825,9 @@ to control PoDL PSE Admin functions. This option is implementing
 The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL`` implementing
 ``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute is used
+to control C33 PSE power limit in mW.
+
 RSS_GET
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 398a0aa8daad..62ac9e1001bf 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -919,6 +919,7 @@ enum {
 	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
 	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index fec56db557d3..5c5eccd5b32b 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -94,6 +94,9 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_STATE */
 	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0)
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_SUBSTATE */
+	if (st->c33_pw_limit > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_LIMIT */
+
 	return len;
 }
 
@@ -144,6 +147,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 			st->c33_ext_state_info.__c33_pse_ext_substate))
 		return -EMSGSIZE;
 
+	if (st->c33_pw_limit > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_LIMIT,
+			st->c33_pw_limit))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -157,6 +165,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
+	[ETHTOOL_A_C33_PSE_PW_LIMIT] = { .type = NLA_U32 },
 };
 
 static int
@@ -199,19 +208,38 @@ static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
-	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
+	int ret = 0;
 
 	phydev = dev->phydev;
+
+	if (tb[ETHTOOL_A_C33_PSE_PW_LIMIT]) {
+		unsigned int pw_limit = nla_get_u32(tb[ETHTOOL_A_C33_PSE_PW_LIMIT]);
+
+		ret = pse_ethtool_set_pw_limit(phydev->psec, info->extack,
+					       pw_limit);
+		if (ret)
+			return ret;
+	}
+
 	/* These values are already validated by the ethnl_pse_set_policy */
-	if (pse_has_podl(phydev->psec))
-		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
-	if (pse_has_c33(phydev->psec))
-		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
+	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] ||
+	    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]) {
+		struct pse_control_config config = {};
+
+		if (pse_has_podl(phydev->psec))
+			config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
+		if (pse_has_c33(phydev->psec))
+			config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
+
+		ret = pse_ethtool_set_config(phydev->psec, info->extack,
+					     &config);
+		if (ret)
+			return ret;
+	}
 
-	/* Return errno directly - PSE has no notification */
-	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
+	return ret;
 }
 
 const struct ethnl_request_ops ethnl_pse_request_ops = {

-- 
2.34.1


