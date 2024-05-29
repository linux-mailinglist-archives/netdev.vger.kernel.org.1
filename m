Return-Path: <netdev+bounces-99058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B888D38D0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FB1F23A2A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DDE3FBA5;
	Wed, 29 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CXF87g4R"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01931CFB5;
	Wed, 29 May 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991783; cv=none; b=HJJEbS0ntqW+4aKE97PLqHI1r33HhB8wqRgCLl/emAAH8Dw10SKbACCt2+5T+CsD60KYMtjxP3qttNg9AzU2LgQ7hLrdy/XTuDDinIEuHV7XAk/gCIKD3fStCo/7m5dd2HkkjIDRylfTIuSWTXAOROIpS2PkAe6sBoZRcOpfnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991783; c=relaxed/simple;
	bh=xpUhXEhcoca2QGyqpBy7O5xTNN6gyw0otyNvbZaQcIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SW+3PpByizdW3jgtRR3hujgHRpProkJc1O3odeGDkMRDItcuK1qBHeULyyZIuiUoGExwL4nuhU7nNnvf3dBp7mb79i8lbz4BWt1fHns/iMETE/zSuZU85Rp3m93/UD6iF02qINyciJoSnDdK68jC1PM6H0budQ/QHyfa+sXvq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CXF87g4R; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C320140008;
	Wed, 29 May 2024 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdbAf4AZmBj8LGreTkVusq+gcYY3lWgvN4pmFdEVT5w=;
	b=CXF87g4RvkxS+wBmXl79iN6BpD3sWkvE/8jYz9Iin7ThYTODW5C9Bc7zcvaswR1sx1UgVt
	r0HkmmKBuNYvuOPRGrp5fMGizahqc1m9D4thbPH5tcfey8pUEmaIDr0rj3xXRnQfhrkuIU
	mMAABQvCQOhCQfrCOL9LIW/tW1RvS2+bt7t69IWufFkKp845l8qwpSIe6Mr3xFuWeLvrrJ
	5ljhRp5fy3ALX4BySR7TKTL7P6kGn0dNtjlbQ/yCBAUpGS8JxOnSkVaF2q8BofJ5pZSrX+
	Q5hOgE8b8y6uqNuXq0QbVSNCSezBBr0XmySmzf+qI76OuzlbDHOrb5Nr5Jk+tg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:33 +0200
Subject: [PATCH 6/8] net: ethtool: Add new power limit get and set features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-6-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
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
 net/ethtool/pse-pd.c                 | 41 ++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index c3f288b737e6..2b8c76278b9f 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -918,6 +918,7 @@ enum {
 	ETHTOOL_A_C33_PSE_PW_STATUS_MSG,	/* binary */
 	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
 	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index faddc14efbea..dbd75eeae4eb 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -93,6 +93,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	if (st->c33_pw_status_msg)
 		/* _C33_PSE_PW_STATUS_MSG */
 		len += nla_total_size(strlen(st->c33_pw_status_msg) + 1);
+	if (st->c33_pw_limit > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_LIMIT */
 
 	return len;
 }
@@ -139,6 +141,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 			   st->c33_pw_status_msg))
 		return -EMSGSIZE;
 
+	if (st->c33_pw_limit > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_LIMIT,
+			st->c33_pw_limit))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -152,6 +159,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
+	[ETHTOOL_A_C33_PSE_PW_LIMIT] = { .type = NLA_U32 },
 };
 
 static int
@@ -194,19 +202,38 @@ static int
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


