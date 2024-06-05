Return-Path: <netdev+bounces-101000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536E8FCF2F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9D297D37
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E81C371B;
	Wed,  5 Jun 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TQlMkS7J"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE41C2239;
	Wed,  5 Jun 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591784; cv=none; b=rdv4AwvtrGzvogRhnLfqDLgdRwCGYkoxmDAAtVOK1pvqRo6v4YlismHKSXimbq4OZJB6/LkZLhIfRNBkG1yBCPEfFRi5lNPWw/l43QzTg2w1Lhqq+/Vk5jvhA/MrxiNvxuz9fffrE1jOtZeJbE1Eeo++SBG6MBpao639UUasNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591784; c=relaxed/simple;
	bh=6dCKzuwcrvzWZ9L5Rryp4oGK4s2wmt2liPXu2zuMCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7C2uF4kjZfwhzgndkwn1yx3ZYfE9TiQMwjLK1VOPqrfNDPqFhnA25uxPnPW6DQNTm87OCimeDYE4Q0Ejm1gIqFUgIsPLcUiADyByp98CY0IKZyd+A7v0Uuuhnm6k8QG9mpsBBuS6oV6tfzm4DXMVBtZOLpQMDxtXkCDnBBok2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TQlMkS7J; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B75D820008;
	Wed,  5 Jun 2024 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717591781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CotgYs02uf/0wLKOWeMUxwU4HX8u5MD+ztIV8+depA=;
	b=TQlMkS7JdEMjj7kuSKtecQ8KJ284jYe764CToGunXQVa7zv67wYEUSlROhAhGKWN9MPMDW
	jbWXzifA910opI+zd8nkWAGHRx4m82hVQsUDugJdsgLfLKyAD3TuXOlavIZjityEIhw/nR
	FWAuXblCxQFk8+YzTraQOGGIyy44A5C9x59cEw3sq8CTT77g6bsg6yId6GJ7F669KFhQaG
	mMOcW1exYLuN40PBXerwtQQdVP5h3GMc7E/pWzwBWMfJKGGJ6dtVw92nZE6xtEWxJrGEuU
	wQp6jt+tYtHqg/r0OKhGe2wA9s+DpFhbNtJ8aIERrzM46kXrSylqj5EeOOhDNg==
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
Subject: [PATCH net-next v12 10/13] net: ethtool: pse-pd: Target the command to the requested PHY
Date: Wed,  5 Jun 2024 14:49:15 +0200
Message-ID: <20240605124920.720690-11-maxime.chevallier@bootlin.com>
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

PSE and PD configuration is a PHY-specific command. Instead of targeting
the command towards dev->phydev, use the request to pick the targeted
PHY device.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/pse-pd.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..3289a3631215 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -28,15 +28,13 @@ struct pse_reply_data {
 /* PSE_GET */
 
 const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
-	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
-static int pse_get_pse_attributes(struct net_device *dev,
+static int pse_get_pse_attributes(struct phy_device *phydev,
 				  struct netlink_ext_ack *extack,
 				  struct pse_reply_data *data)
 {
-	struct phy_device *phydev = dev->phydev;
-
 	if (!phydev) {
 		NL_SET_ERR_MSG(extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -64,7 +62,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = pse_get_pse_attributes(dev, info->extack, data);
+	ret = pse_get_pse_attributes(req_base->phydev, info->extack, data);
 
 	ethnl_ops_complete(dev);
 
@@ -123,7 +121,7 @@ static int pse_fill_reply(struct sk_buff *skb,
 /* PSE_SET */
 
 const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
-	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED),
@@ -135,11 +133,10 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 static int
 ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
 
-	phydev = dev->phydev;
+	phydev = req_info->phydev;
 	if (!phydev) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -171,12 +168,11 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
 
-	phydev = dev->phydev;
+	phydev = req_info->phydev;
 	/* These values are already validated by the ethnl_pse_set_policy */
 	if (pse_has_podl(phydev->psec))
 		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
-- 
2.45.1


