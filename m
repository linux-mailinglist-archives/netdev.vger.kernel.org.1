Return-Path: <netdev+bounces-260699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JneGlFSnmmmUgQAu9opvQ
	(envelope-from <netdev+bounces-260699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:37:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D784018F2FD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D818D317D4CE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597E248886;
	Wed, 25 Feb 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kODmGJYa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331152BAF7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983039; cv=none; b=ERhX06tq+49VONPIV1hmcKRENkwGiqxvtqDQpBN6+b0pc9ZcWh0PcnLLykzp2jVupV+6RsBFDyLBX/wfX50MEX2X67dNaZ7z7oyBz3e3SAyxXllnxF7IlGOmJvFdhbvbeai/yj0+LA69GaAeXjyAQrsqmYaZX1Sof2+UhgwGduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983039; c=relaxed/simple;
	bh=FeIjheyt5MmH5rpuQ0+djNBSvwaQ02Enb/aIau7gkDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4mqwplUbN9HXGoBYIF/y1ueCFHWqikrOK/vI1Cvnjrw3bt6zZG6XrMIS2qWJRErLuGRI7lmHlW7ZMuAoYhigrUvSNfO7rY97MGGknYPAkoWd5y650xrokI4aOYG8T12Dkmeh18fv4fDQOkzUT0yOirgJYx1Mn4DRp7gPAbqWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kODmGJYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D8C116D0;
	Wed, 25 Feb 2026 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771983039;
	bh=FeIjheyt5MmH5rpuQ0+djNBSvwaQ02Enb/aIau7gkDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kODmGJYar3MTni9jjDWPzYHy/PytDnxrowEmORjHxlxhQX/6T3MC745La6yA0Efwm
	 2hXIruanyX6gNfpv+m+E19IgDs+utybH8SBL1Td3Gf2FO85RSU8dXYLvEYapKfNphW
	 Ozs9GzQDHy3SEdVOK1zWyX+3y/Lps46l+/y5aTMk9qW73zgpKHL81L35218usFnkEU
	 HOq2WNma3wYglNyaT+cxQ8QX463M4UZ1gNeOR3u1E5myGyXhmQ1fp3z4Q+YKhMOnAO
	 ctesddf4Lp+wDaY1KRGXVOXF1Eifm1lUVypxwBi+f1fb/f6k0rV5hKuqNWITmyV629
	 WuK9HN8JKxI9w==
Date: Tue, 24 Feb 2026 17:30:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix .ndo_fix_features()
Message-ID: <20260224173037.7871e5ac@kernel.org>
In-Reply-To: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
References: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260699-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: D784018F2FD
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 11:24:51 +0000 Russell King (Oracle) wrote:
> netdev features documentation requires that .ndo_fix_features() is
> stateless: it shouldn't modify driver state. Yet, stmmac_fix_features()
> does exactly that, changing whether GSO frames are processed by the
> driver.
> 
> Move this code to stmmac_set_features() instead, which is the correct
> place for it. We don't need to check whether TSO is supported; this
> is already handled via the setup of netdev->hw_features, and we are
> guaranteed that if netdev->hw_features indicates that a feature is
> not supported, .ndo_set_features() won't be called with it set.

No lies detected, but is this enough? The whole TSO enablement 
looks quite wobbly (as you mentioned in another email IIRC). 

Only stmmac_hw_setup() actually calls stmmac_enable_tso(). 
And stmmac_set_features() does not call stmmac_hw_setup().

IDK what the cost of having TSO enabled is for this IP, it's 
entirely possible that there is no cost. So maybe we should set
the TSO feature in features but not in hw_features which will
make it "fixed" to be always enabled? And not bother with handling 
the changes?

> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 82375d34ad57..a2a0985e8c37 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6105,14 +6105,6 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
>  	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
>  		features &= ~NETIF_F_CSUM_MASK;
>  
> -	/* Disable tso if asked by ethtool */
> -	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
> -		if (features & NETIF_F_TSO)
> -			priv->tso = true;
> -		else
> -			priv->tso = false;
> -	}
> -
>  	return features;
>  }
>  
> @@ -6144,6 +6136,8 @@ static int stmmac_set_features(struct net_device *netdev,
>  	else
>  		priv->hw->hw_vlan_en = false;
>  
> +	priv->tso = !!(features & NETIF_F_TSO);

extra nit, I think you're inserting this in the middle of a section of
code handling vlan config.

>  	phylink_rx_clk_stop_block(priv->phylink);
>  	stmmac_set_hw_vlan_mode(priv, priv->hw);
>  	phylink_rx_clk_stop_unblock(priv->phylink);
-- 
pw-bot: cr

