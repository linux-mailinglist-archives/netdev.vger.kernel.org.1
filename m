Return-Path: <netdev+bounces-119238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23527954EDD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4DE1F2637B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FD1B3F0F;
	Fri, 16 Aug 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sixNicBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFE1BF31C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825939; cv=none; b=TSdyX8MEEOTInoBTTzl05/Ryq6OOgB1yVmZNRRyf6PZ4IKuRPc0IIjU6t+oSSeSRJ1oUnyXqR4MQRR01mduKx8AFliJDpAYbgZCBBNQtRbJ4yWvOw3FEL5DikIzz3jfZK3w9FN1xvQRacTImBt26aAOTBPGHJQGJwgnvnhWlEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825939; c=relaxed/simple;
	bh=Ie7nVYEWTo7r0+XpDZ/rjlMBZOtpNyGlSXZtKvdZXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt8MsJVGhANuvkezUxCHxHXA1hx2Zc7zgLahKqNOGLF5WR6F6Wis1zXpp77ssVbMoSgNTTKOJTAK9O5CnVNqn/tgZcg2U2nWZU/hhFURLnjhEoLeKCwcVeXr9C7aKCHSX30XjMIpBWlECEfLP1x9hlJwLYiSyBSMBxie07Emoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sixNicBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59417C4AF0F;
	Fri, 16 Aug 2024 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825939;
	bh=Ie7nVYEWTo7r0+XpDZ/rjlMBZOtpNyGlSXZtKvdZXr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sixNicBxGsCMnhKIaEKXtGevpJwixyPKRQG7s2iDnv6yuYe/QPwNlwEneQpZbpT5T
	 j8G3JCvqoUEbtVE2oRlgecQxQSNZP70MGNtcLSgcEVBA1xNAXHqIelTcXTKCuau9CO
	 ZG1p3cYZ/SnrOZU9Dew+i/MufOAL3qAoxIA1ckXsjEoh9xjJefIoyUIUNZeECkt8ta
	 NcidgHsiE6bMxpcFH0xnV7EI3LnzrJ6n54izP/zPK5M4r7JZPR8ecAPShlSSdPSVhI
	 yNQk8RUULsXO9ERtIFZLoMoHJKpWFW9I+bWwVCmOhnOX9a1bOy1G9wqkLU4vZBwCqr
	 5/IvDSnP982dw==
Date: Fri, 16 Aug 2024 17:32:15 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 1/2] bonding: Add ESN support to IPSec HW offload
Message-ID: <20240816163215.GW632411@kernel.org>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <20240816035518.203704-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816035518.203704-2-liuhangbin@gmail.com>

On Fri, Aug 16, 2024 at 11:55:17AM +0800, Hangbin Liu wrote:
> Currently, users can see that bonding supports IPSec HW offload via ethtool.
> However, this functionality does not work with NICs like Mellanox cards when
> ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
> supported. This patch adds ESN support to the bonding IPSec device offload,
> ensuring proper functionality with NICs that support ESN.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f9633a6f8571..4e3d7979fe01 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -629,10 +629,48 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	return err;
>  }
>  
> +/**
> + * bond_advance_esn_state - ESN support for IPSec HW offload
> + * @xs: pointer to transformer state struct
> + **/
> +static void bond_advance_esn_state(struct xfrm_state *xs)
> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct bond_ipsec *ipsec;

Hi Hangbin,

ipsec is unused in this function and should be removed.
Likewise in patch 2/2.

> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return;
> +
> +	rcu_read_lock();
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +
> +	if (!slave)
> +		goto out;
> +
> +	if (!xs->xso.real_dev)
> +		goto out;
> +
> +	WARN_ON(xs->xso.real_dev != slave->dev);
> +
> +	if (!slave->dev->xfrmdev_ops ||
> +	    !slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> +		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_advance_esn\n", __func__);
> +		goto out;
> +	}
> +
> +	slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
> +out:
> +	rcu_read_unlock();
> +}

...

-- 
pw-bot: cr

