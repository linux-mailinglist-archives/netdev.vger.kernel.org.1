Return-Path: <netdev+bounces-101708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A658FFD28
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7561F21470
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23A15575C;
	Fri,  7 Jun 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W1CJB+yM"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E115530F;
	Fri,  7 Jun 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745444; cv=none; b=FdQx/Wc4yIVL6wIV+ZSLrZL/igmNG9Vt9uHK40vjwukLiM6clBQe9hvn+7X4GGzBS+4ENFMb3ILFyQGrS9w2qR9UzhETqpDr/BSfj2Jkr9Sbf1ebZXWvJN+UYikIYt/n7pZJeL+YICAl7d5e3s5QMbQvoomUDDvloOlYc3CJAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745444; c=relaxed/simple;
	bh=L+ZQS6w50mPzNNU09e8nv4NAoqXE9SdHMuKog4rNWW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1nfUtiU5JS82p/mQ5R3yXHIEJkGTMPWCeQ/yWCBEHhGa2mnc6Qib/utQR8/P6jo7ORb+m1TPoNBmBUWuAZSmmfNkmtYdGUDlPSefZDP2OIneqmm1kZCsaUD+d25ShCx1LRsyFI80OQ02kB56wkTlPSpmH4Hao5nNNRNYwqzV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W1CJB+yM; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FB5B4000F;
	Fri,  7 Jun 2024 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkpOAyKbzUUqntYuBj/ZLM7EdvYb+d5LGE5Tip8ZYTU=;
	b=W1CJB+yML0dK69BE5uUu0y98k2tcBGUVEhArQLMDYU1NiOIkzhHNZRT+Z1Gphh79IdpYJC
	rE4/i7nN8qp9o3mWiTzTUclt8gnLV+W5y8bwfEtfr6RjW7PIkancQkdAmpj4AEeHaZym23
	NuFDz+0sOxIXRG14ftZJFYX4gIc7iOolKeCPWIKHzT++/6E3Pj8IlXVuND2lNR8DjGcTOR
	Jfinj+4d6ckoSjgYbIXnMR7zlzfk6j2je6BaAYohRYlNjG2PtLFb7zmJ4s682Ns3NhsDAT
	ehTe5wJeyTSOhjURZ5EnGy+W+vy0Yfo7G4qhMCeTJW+LQxd3ya9DagNmFJZaWw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:23 +0200
Subject: [PATCH net-next v2 6/8] net: ethtool: Add new power limit get and
 set features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-6-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
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

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with power limit. It also adds a call to pse_ethtool_set_pw_limit() to
configure the PSE control power limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/uapi/linux/ethtool_netlink.h |  1 +
 net/ethtool/pse-pd.c                 | 42 ++++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index ccbe8294dfd5..0a39aae8ccfd 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -919,6 +919,7 @@ enum {
 	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
 	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u8 */
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u8 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 3d74cfe7765b..b4462a51c006 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -94,6 +94,9 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_STATE */
 	if (st->c33_ext_state_info.__c33_pse_ext_substate)
 		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_SUBSTATE */
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


