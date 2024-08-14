Return-Path: <netdev+bounces-118514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEC951D77
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA72B27110
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175631B32D0;
	Wed, 14 Aug 2024 14:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDC1B32AD;
	Wed, 14 Aug 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645916; cv=none; b=EyAtTG+gPL416KdWmwckggikeA4hvnvFUi3xq9oH4U4GPqcNdhTxYGD8Zqqpiqc5vtEJEwVGAAYcAMrJuN+6fF22lI9YkKaCooXKSruESvZGRw5pm9eBZ8kdpIe30kvqLf362mkJOU1no0rnkAS2k+09fzTJN3tfzkmmG4Ch14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645916; c=relaxed/simple;
	bh=ZbHT3CXWqhwxnUa2n5p4MAm0yPnx/IPCcq9NqBOw4G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlslmjzJ1aNMLRqe0nxWzHYpVDd3Z6mHOwrIWy27W+s1OOMTYBQXizCtJeqjixc56zh2rD+fWYjyFKa0Y400YotUrhxFR/7p0m/zNtZtDJfhXGJGavVDlofE9BE4vBt5mKQbrDOiZsDaFK142A8J4RadmkoRkEEfSmpi7NyhIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW0l69csz9sPd;
	Wed, 14 Aug 2024 16:31:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jk7bKNAj_e6; Wed, 14 Aug 2024 16:31:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW0l5D7Xz9rvV;
	Wed, 14 Aug 2024 16:31:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E1988B775;
	Wed, 14 Aug 2024 16:31:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LQLWUFiASP3Y; Wed, 14 Aug 2024 16:31:51 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 753078B764;
	Wed, 14 Aug 2024 16:31:50 +0200 (CEST)
Message-ID: <096c1dfe-999d-4f37-ada4-1adbf56afaf7@csgroup.eu>
Date: Wed, 14 Aug 2024 16:31:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 10/14] net: ethtool: pse-pd: Target the
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
 <20240709063039.2909536-11-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-11-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> PSE and PD configuration is a PHY-specific command. Instead of targeting
> the command towards dev->phydev, use the request to pick the targeted
> PHY device.
> 
> As we don't get the PHY directly from the netdev's attached phydev, also
> adjust the error messages.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   net/ethtool/pse-pd.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index ba46c9c8b12d..0f37ff5de7f0 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -28,17 +28,15 @@ struct pse_reply_data {
>   /* PSE_GET */
>   
>   const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
> -	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   };
>   
> -static int pse_get_pse_attributes(struct net_device *dev,
> +static int pse_get_pse_attributes(struct phy_device *phydev,
>   				  struct netlink_ext_ack *extack,
>   				  struct pse_reply_data *data)
>   {
> -	struct phy_device *phydev = dev->phydev;
> -
>   	if (!phydev) {
> -		NL_SET_ERR_MSG(extack, "No PHY is attached");
> +		NL_SET_ERR_MSG(extack, "No PHY found");
>   		return -EOPNOTSUPP;
>   	}
>   
> @@ -58,13 +56,20 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
>   {
>   	struct pse_reply_data *data = PSE_REPDATA(reply_base);
>   	struct net_device *dev = reply_base->dev;
> +	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	int ret;
>   
>   	ret = ethnl_ops_begin(dev);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = pse_get_pse_attributes(dev, info->extack, data);
> +	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PSE_HEADER],
> +				      info->extack);
> +	if (IS_ERR(phydev))
> +		return -ENODEV;
> +
> +	ret = pse_get_pse_attributes(phydev, info->extack, data);
>   
>   	ethnl_ops_complete(dev);
>   
> @@ -206,7 +211,7 @@ static void pse_cleanup_data(struct ethnl_reply_data *reply_base)
>   /* PSE_SET */
>   
>   const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
> -	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] =
>   		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED,
>   				 ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED),
> @@ -219,12 +224,12 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
>   static int
>   ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>   {
> -	struct net_device *dev = req_info->dev;
>   	struct nlattr **tb = info->attrs;
>   	struct phy_device *phydev;
>   
> -	phydev = dev->phydev;
> -	if (!phydev) {
> +	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
> +				      info->extack);
> +	if (IS_ERR_OR_NULL(phydev)) {
>   		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
>   		return -EOPNOTSUPP;
>   	}
> @@ -255,12 +260,14 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>   static int
>   ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
>   {
> -	struct net_device *dev = req_info->dev;
>   	struct nlattr **tb = info->attrs;
>   	struct phy_device *phydev;
>   	int ret = 0;
>   
> -	phydev = dev->phydev;
> +	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
> +				      info->extack);
> +	if (IS_ERR_OR_NULL(phydev))
> +		return -ENODEV;
>   
>   	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
>   		unsigned int pw_limit;

