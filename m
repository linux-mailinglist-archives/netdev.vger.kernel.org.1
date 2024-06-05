Return-Path: <netdev+bounces-100999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D58FCF28
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AD11C2163B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F32F1C2243;
	Wed,  5 Jun 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZWUgemwu"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD1BE858;
	Wed,  5 Jun 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591783; cv=none; b=hUd/Obw4y07rmR5FfptZks2aBDGs02M+ypvKEhR1lJ8fcqwzSDaylRIVp8Q5rFYfOeDnQwkhg/yeNeZDQYu8mH0fUblWqnQ0mqRLEf4X+4iyjPa892A0vHgHZKW8dDwhxURPA2rvnSiKmhte5mzZnorhjI7sIfr5xhUzqNMU/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591783; c=relaxed/simple;
	bh=Bvti8tUOJkTJd9qxRveOWe7B/kBSghbeRtPhRSb1F78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g125oAIlCGVQO3zrxgwAe5jlOHJL1UBEOl274Y9FHYrd8BT0Z7TgkxQ8N7IY/pkx8QKwIftNndSmGGhwr+LDeiYGaVfOE+4mC8K0Fx2OQYfRc4rpNYLdnjKPHPrGRnzHuXa4gV6VblDMNV8a9Bt4J36Vi0JiIT4175pAlp18xtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZWUgemwu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F6E52000F;
	Wed,  5 Jun 2024 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717591779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdHRxZdIVtQDmtg/7Szi9R9ppNOPI4/sMJdJvlp0D74=;
	b=ZWUgemwu6J2NEIyfRxyaU1WwsgKbShC0jxdf6/8QrrA5s+rCaLWg+r5JzqPOOKq+WhT+e+
	57ofaSMizDOwqw7gnwxhBnm0ej0dPPC9Fi1aQ6covGp66qwVZONe/N1tzP+w8Cmw+ADvGk
	MVSz+5dKQpfYRFzR02S37KhyAoPFCmr74kqmAlL9P7l5/8ol/yTbONDHwsFuE/RArmPjaP
	uxKHuSUQ2XqmQy0oO9OthAaHX1ojv1ja3XS9xVY6Rwy5JuHWrqu7PZBzfTZqOzonkO6jwk
	rogk2K+SV/qKGYh0X5O28T4o9il+D305pi1EAFWhg+WOkG3LffPvrvagHMz64g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v12 09/13] net: ethtool: plca: Target the command to the requested PHY
Date: Wed,  5 Jun 2024 14:49:14 +0200
Message-ID: <20240605124920.720690-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

PLCA is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ethtool/plca.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b1e2e3b5027f..43b31a4a164e 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -25,7 +25,7 @@ struct plca_reply_data {
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
@@ -61,7 +61,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (!req_base->phydev) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -80,7 +80,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_cfg, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_cfg));
 
-	ret = ops->get_plca_cfg(dev->phydev, &data->plca_cfg);
+	ret = ops->get_plca_cfg(req_base->phydev, &data->plca_cfg);
 	ethnl_ops_complete(dev);
 
 out:
@@ -129,7 +129,7 @@ static int plca_get_cfg_fill_reply(struct sk_buff *skb,
 
 const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_PLCA_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_PLCA_NODE_ID]	= NLA_POLICY_MAX(NLA_U32, 255),
 	[ETHTOOL_A_PLCA_NODE_CNT]	= NLA_POLICY_RANGE(NLA_U32, 1, 255),
@@ -141,7 +141,6 @@ const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 static int
 ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
 	struct phy_plca_cfg plca_cfg;
@@ -149,7 +148,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev)
+	if (!req_info->phydev)
 		return -EOPNOTSUPP;
 
 	ops = ethtool_phy_ops;
@@ -168,7 +167,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (!mod)
 		return 0;
 
-	ret = ops->set_plca_cfg(dev->phydev, &plca_cfg, info->extack);
+	ret = ops->set_plca_cfg(req_info->phydev, &plca_cfg, info->extack);
 	return ret < 0 ? ret : 1;
 }
 
@@ -191,7 +190,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 
 const struct nla_policy ethnl_plca_get_status_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
@@ -204,7 +203,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (!req_base->phydev) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -223,7 +222,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_st, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_st));
 
-	ret = ops->get_plca_status(dev->phydev, &data->plca_st);
+	ret = ops->get_plca_status(req_base->phydev, &data->plca_st);
 	ethnl_ops_complete(dev);
 out:
 	return ret;
-- 
2.45.1


