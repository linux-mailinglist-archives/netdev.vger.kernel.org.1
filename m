Return-Path: <netdev+bounces-118515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB3951D27
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C96289F51
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC91B32DC;
	Wed, 14 Aug 2024 14:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A81B32D0;
	Wed, 14 Aug 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645929; cv=none; b=ORG3MTiwBpb3rruMqi9Djr+0IYW0CYpG+kLx1pXOdbxZj9Mqtb5U20eWFgwtR1YeDWGlQqQQRsAyiYX12ED0/yftghUiK1oN28X/At38hHO8w9m+AYtKQ3KReZzuoU4of8mNt8r1T/HlP2VhkiCnBUYjwLKFm4UVC3mD3qc5aeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645929; c=relaxed/simple;
	bh=3duWXRIkilnmOob2zovbeBDKzY4qzSFXV7nN8vpsrW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEOYd34Ya0XFf02LplxZ1vzOpLQTdUI4hSMBCcaABRJ4qeXNRHMGbX/Y4nW5riF7w1fObDyEitQwzMD3pu+obip0lMyXAh2BbYCUDilf9ozh/J+isLM9hfB5kJI5mAWqZ9p28dhvKtisU6bhsw5IXScpvMVGMwgxM7TnvKIo6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW126Ghgz9sPd;
	Wed, 14 Aug 2024 16:32:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mL4mHTYjMqv; Wed, 14 Aug 2024 16:32:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW125HfPz9rvV;
	Wed, 14 Aug 2024 16:32:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A17B18B775;
	Wed, 14 Aug 2024 16:32:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id C-oyR-h6f6XQ; Wed, 14 Aug 2024 16:32:06 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 711FD8B764;
	Wed, 14 Aug 2024 16:32:05 +0200 (CEST)
Message-ID: <fee52e22-f0d3-432d-8672-b4e244f79268@csgroup.eu>
Date: Wed, 14 Aug 2024 16:32:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> Cable testing is a PHY-specific command. Instead of targeting the command
> towards dev->phydev, use the request to pick the targeted PHY.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   net/ethtool/cabletest.c | 35 ++++++++++++++++++++++-------------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
> index f6f136ec7ddf..01db8f394869 100644
> --- a/net/ethtool/cabletest.c
> +++ b/net/ethtool/cabletest.c
> @@ -13,7 +13,7 @@
>   
>   const struct nla_policy ethnl_cable_test_act_policy[] = {
>   	[ETHTOOL_A_CABLE_TEST_HEADER]		=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   };
>   
>   static int ethnl_cable_test_started(struct phy_device *phydev, u8 cmd)
> @@ -58,6 +58,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>   	struct ethnl_req_info req_info = {};
>   	const struct ethtool_phy_ops *ops;
>   	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	struct net_device *dev;
>   	int ret;
>   
> @@ -69,12 +70,16 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>   		return ret;
>   
>   	dev = req_info.dev;
> -	if (!dev->phydev) {
> +
> +	rtnl_lock();
> +	phydev = ethnl_req_get_phydev(&req_info,
> +				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
> +				      info->extack);
> +	if (IS_ERR_OR_NULL(phydev)) {
>   		ret = -EOPNOTSUPP;
>   		goto out_dev_put;
>   	}
>   
> -	rtnl_lock();
>   	ops = ethtool_phy_ops;
>   	if (!ops || !ops->start_cable_test) {
>   		ret = -EOPNOTSUPP;
> @@ -85,13 +90,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>   	if (ret < 0)
>   		goto out_rtnl;
>   
> -	ret = ops->start_cable_test(dev->phydev, info->extack);
> +	ret = ops->start_cable_test(phydev, info->extack);
>   
>   	ethnl_ops_complete(dev);
>   
>   	if (!ret)
> -		ethnl_cable_test_started(dev->phydev,
> -					 ETHTOOL_MSG_CABLE_TEST_NTF);
> +		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
>   
>   out_rtnl:
>   	rtnl_unlock();
> @@ -216,7 +220,7 @@ static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
>   
>   const struct nla_policy ethnl_cable_test_tdr_act_policy[] = {
>   	[ETHTOOL_A_CABLE_TEST_TDR_HEADER]	=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   	[ETHTOOL_A_CABLE_TEST_TDR_CFG]		= { .type = NLA_NESTED },
>   };
>   
> @@ -305,6 +309,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>   	struct ethnl_req_info req_info = {};
>   	const struct ethtool_phy_ops *ops;
>   	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	struct phy_tdr_config cfg;
>   	struct net_device *dev;
>   	int ret;
> @@ -317,10 +322,6 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>   		return ret;
>   
>   	dev = req_info.dev;
> -	if (!dev->phydev) {
> -		ret = -EOPNOTSUPP;
> -		goto out_dev_put;
> -	}
>   
>   	ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
>   					   info, &cfg);
> @@ -328,6 +329,14 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>   		goto out_dev_put;
>   
>   	rtnl_lock();
> +	phydev = ethnl_req_get_phydev(&req_info,
> +				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
> +				      info->extack);
> +	if (!IS_ERR_OR_NULL(phydev)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_dev_put;
> +	}
> +
>   	ops = ethtool_phy_ops;
>   	if (!ops || !ops->start_cable_test_tdr) {
>   		ret = -EOPNOTSUPP;
> @@ -338,12 +347,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>   	if (ret < 0)
>   		goto out_rtnl;
>   
> -	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
> +	ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
>   
>   	ethnl_ops_complete(dev);
>   
>   	if (!ret)
> -		ethnl_cable_test_started(dev->phydev,
> +		ethnl_cable_test_started(phydev,
>   					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
>   
>   out_rtnl:

