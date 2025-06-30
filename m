Return-Path: <netdev+bounces-202372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7885AED96C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0763D1774E0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77943253330;
	Mon, 30 Jun 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg4buWfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F834253922
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278193; cv=none; b=Bt9RMFFvg565VOg1aFi3YmnAQ0rglpJZ7kTNZXP9gMRBVjSj6GwlwMdnv/x2sNvAS2Eml5JeD3pLCgKoRb6fgQMqhLGM4COkb+H8EVTjV8u2WLGDeYUydEEH2fFQYglvPPj4Ehb3aHIWA1AxFHwrf5b+msPW4MBvCw+d6xEGOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278193; c=relaxed/simple;
	bh=UL/XAyw0QuhnzIt8LuwRJN9kbBXgH5q/Mlo0uawtAfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqyogVp+krl5E2PQzx7iHvV9OFdQfSHIP6sqe+bYxIGajDGHPK47rY9W77KPqhM9rn+3wtfVj2DhXHsQMb9cUuOzgPAUa3CEwmrdMx+guXcmNnnsD/zxWzRK6sYAnLNB4Zp0S1ANGieiY5t/96XtoLI8DO1/4Tb34yGKCePvOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg4buWfl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7494999de5cso3298392b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751278191; x=1751882991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSyY/Jv2NMvZHiDBWlrTzwbjsRXwAx8tY5ikvdI08Dc=;
        b=Rg4buWflcItVCnP2f4/bn6VX9jUogIqa+f3rA286b3IKmM09mXqc0CBdjWUfTswdyu
         glEb4DJQs842ceI3bpHU4BhIs+S6jHQ8UJF60Z+7XcZomFcaalTzHbrGnU1vZwX09iiK
         12yQ2HMJyduTIhXlu2K3ptA8awtXepil4F+dlvhT8BD03Kq8+SaiN5dSR3fUlZa8plgU
         gScGUsbstw8GpH3+AfPlWY3PZMd6+r4XjTdOyCsIQqcN/mwN0zdsbtvEP0Z6CwK8sp1R
         1h7Ws1E6LXMNF64NP+84jAvez7HKYMoALTaviCTkgRT2VZS8hw/Giob8XoNPyRQ5QHoK
         T7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278191; x=1751882991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSyY/Jv2NMvZHiDBWlrTzwbjsRXwAx8tY5ikvdI08Dc=;
        b=IN0TpzT8k22kAOw9TyLai6m/VUwQ4c6XoOoAQjnFRE0vldODwTalvTcTrX3i/VuYDF
         C5MyWQcLPDqKFHIW1fIN3hzETZ/N++or99Z1DeAUYmHVWXRdBmf5PiwIUgKfvyfZXBXf
         +ChApKHzd3bu2TPpTQAY3VLn6/eVHDyD40k8AnnmWS6Bgia63WbmtW908Co60kjAsaUz
         ZxLMRU+hzwD1OXq5YA4j+1SZ2ttrxCetjELQeX1pntMnvoAf1Kier7uv9hiv51i+OeIE
         4DbYxDRwfyiGJOpYA7HRKcVH//whSKus175Dx3cApaFg+Y10Y3TsqxL/rEIw1HQlwuz/
         GRHQ==
X-Gm-Message-State: AOJu0YwE/nD18ljX/8R0BP2ig1ZPeHudgNbCSc2XhQatzYvK7o9GPpnK
	IwWCoqil+OdGJ8QsXwG+AuaR5a10xKCznQQQqCGhT6cDYo7JlP3SnjRb
X-Gm-Gg: ASbGnctTLdJW04W5ZM/mLveal0TzHLFBPNxC1nJ9/RdBoU2jvsoqqq27VFKM1kG/U3I
	J7ULavcSBbTLDJtxGXKEmSvz31ALT6EFrk9+NpuHKEvTeuF6kzdA/22KHogiEbUCgpZ4UEUtMhr
	8u2S2Jq1lBNyZmOWK7YEFhmmfwQ2hXwt+5VyoEu9YC7qqSdGmpz7jd44Y2iU/6EzSdzHwlcpOFw
	JzfjU/ITc16GwUU8CPT/niENCfcNkdY5eU9adr6Z4RDUrTqP8jxACeB3o8kJanduQBZ34UJR7Mq
	3Zjbkevmc5+fF2uqkDIIAnUhbAPOtz3HdGHgbsslosbtF8dymXmCNegQ43WKTbVBOhk=
X-Google-Smtp-Source: AGHT+IH/GwWw57GZHXhgK63uDBROg5MdR0BhGDcyz11ErHKaQHh17AxiV8Sm4P+Fc+a7umEjLMK3jQ==
X-Received: by 2002:a05:6a00:2410:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-74af6e66311mr16291135b3a.4.1751278190543;
        Mon, 30 Jun 2025 03:09:50 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3009154sm7760722a12.1.2025.06.30.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 03:09:49 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:09:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Erwan Dufour <mrarmonius@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, jv@jvosburgh.net,
	saeedm@nvidia.com, tariqt@nvidia.com, erwan.dufour@withings.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Message-ID: <aGJiZrvRKXm74wd2@fedora>
References: <20250629210623.43497-1-mramonius@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629210623.43497-1-mramonius@gmail.com>

Hi Erwan,

Cc Cosmin as he updated bond ipsec a lot.

Maybe the subject prefix could be [PATCH net-next].

On Sun, Jun 29, 2025 at 11:06:23PM +0200, Erwan Dufour wrote:
> From: Erwan Dufour <erwan.dufour@withings.com>
> 
> Implement XFRM policy offload functions for bond device in active-backup mode.
>  - xdo_dev_policy_add = bond_ipsec_add_sp
>  - xdo_dev_policy_delete = bond_ipsec_del_sp
>  _ xdo_deb_policy_free = bond_ipsec_free_sp
> 
> Modification of the function signature for copying on SA models.
> Also add netdevice pointer to avoid to use real_dev which is obsolete and deleted for policy.
> 
> Store the bond's xfrm policies in the struct bond_ipsec.
> Also rename these functions:
>  - bond_ipsec_del_sa_all -> bond_ipsec_del_sa_sp_all
>  - bond_ipsec_add_sa_all -> bond_ipsec_add_sa_sp_all
> Now bond_ipsec_{del,add}_sa_sp_all remove/add also the bond's policies stores in same struct as SA.
> 
> Tested on Mellanox ConnectX-6 Dx Crypto Enable Cards.
> ---
>  drivers/net/bonding/bond_main.c               | 279 +++++++++++++++---
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  10 +-
>  include/linux/netdevice.h                     |   6 +-
>  include/net/bonding.h                         |   1 +
>  include/net/xfrm.h                            |   4 +-
>  net/xfrm/xfrm_device.c                        |   2 +-
>  6 files changed, 246 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index c4d53e8e7c15..85017635f9b5 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -512,7 +512,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
>  	return err;
>  }
>  
> -static void bond_ipsec_add_sa_all(struct bonding *bond)
> +static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
>  {
>  	struct net_device *bond_dev = bond->dev;
>  	struct net_device *real_dev;
> @@ -536,29 +536,44 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	}
>  
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		/* If new state is added before ipsec_lock acquired */
> -		if (ipsec->xs->xso.real_dev == real_dev)
> -			continue;
> +		if (ipsec->xs) {
> +			/* If new state is added before ipsec_lock acquired */
> +			if (ipsec->xs->xso.real_dev == real_dev)
> +				continue;
>  
> -		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> -							     ipsec->xs, NULL)) {
> -			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> -			continue;
> -		}
> +			if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> +									ipsec->xs, NULL)) {

Please fix the code alignment. And all others in the code.

> +
> +/**
> + * bond_ipsec_del_sp - clear out this specific SP
> + * @bond_dev: pointer to net device
> + * @xs: pointer to transformer policy struct
> + **/
> +static void bond_ipsec_del_sp(struct net_device *bond_dev, struct xfrm_policy *xp)
> +{
> +	struct net_device *real_dev;
> +	netdevice_tracker tracker;
> +	struct bond_ipsec *ipsec;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return;
> +
> +	rcu_read_lock();
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> +	rcu_read_unlock();
> +
> +	if (!slave)
> +		goto out;
> +
> +	if (!xp->xdo.real_dev)
> +		goto out;
> +
> +	WARN_ON(xp->xdo.real_dev != real_dev);
> +
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_policy_delete ||
> +	    netif_is_bond_master(real_dev)) {
> +		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_policy_delete\n", __func__);
> +		goto out;
> +	}
> +
> +	real_dev->xfrmdev_ops->xdo_dev_policy_delete(real_dev, xp);
> +out:
> +	netdev_put(real_dev, &tracker);
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xp == xp) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
> +}

In xfrm_add_policy() err out, it calls xfrm_dev_policy_delete() first and
then xfrm_dev_policy_free(). So why we free ipsec->list in bond_ipsec_del_sp()
but no bond_ipsec_free_sp()?

BTW, if (ipsec->xp == xp), should we delete the whole ipsec_list? Is it
possible ipsec->xs still exist?

Thanks
Hangbin

> +
> +static void bond_ipsec_free_sp(struct net_device *bond_dev, struct xfrm_policy *xp)
> +{
> +	struct net_device *real_dev;
> +	netdevice_tracker tracker;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return;
> +
> +	rcu_read_lock();
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> +	rcu_read_unlock();
> +
> +	if (!slave)
> +		goto out;
> +
> +	if (!xp->xdo.real_dev)
> +		goto out;
> +
> +	WARN_ON(xp->xdo.real_dev != real_dev);
> +
> +	if (real_dev && real_dev->xfrmdev_ops &&
> +	    real_dev->xfrmdev_ops->xdo_dev_policy_free)
> +		real_dev->xfrmdev_ops->xdo_dev_policy_free(real_dev, xp);
> +out:
> +	netdev_put(real_dev, &tracker);
> +}
> +
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_state_add = bond_ipsec_add_sa,
>  	.xdo_dev_state_delete = bond_ipsec_del_sa,
> @@ -738,6 +924,9 @@ static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
>  	.xdo_dev_state_advance_esn = bond_advance_esn_state,
>  	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
> +	.xdo_dev_policy_add = bond_ipsec_add_sp,
> +	.xdo_dev_policy_delete = bond_ipsec_del_sp,
> +	.xdo_dev_policy_free = bond_ipsec_free_sp,
>  };
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  
> @@ -1277,7 +1466,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  		return;
>  
>  #ifdef CONFIG_XFRM_OFFLOAD
> -	bond_ipsec_del_sa_all(bond);
> +	bond_ipsec_del_sa_sp_all(bond);
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  
>  	if (new_active) {
> @@ -1352,7 +1541,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  	}
>  
>  #ifdef CONFIG_XFRM_OFFLOAD
> -	bond_ipsec_add_sa_all(bond);
> +	bond_ipsec_add_sa_sp_all(bond);
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  
>  	/* resend IGMP joins since active slave has changed or
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index 77f61cd28a79..f5e3fc054f41 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -1161,15 +1161,15 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
>  	attrs->prio = x->priority;
>  }
>  
> -static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
> +static int mlx5e_xfrm_add_policy(struct net_device *dev,
> +				 struct xfrm_policy *x,
>  				 struct netlink_ext_ack *extack)
>  {
> -	struct net_device *netdev = x->xdo.dev;
>  	struct mlx5e_ipsec_pol_entry *pol_entry;
>  	struct mlx5e_priv *priv;
>  	int err;
>  
> -	priv = netdev_priv(netdev);
> +	priv = netdev_priv(dev);
>  	if (!priv->ipsec) {
>  		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet offload");
>  		return -EOPNOTSUPP;
> @@ -1207,7 +1207,7 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
>  	return err;
>  }
>  
> -static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
> +static void mlx5e_xfrm_del_policy(struct net_device *dev, struct xfrm_policy *x)
>  {
>  	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
>  
> @@ -1215,7 +1215,7 @@ static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
>  	mlx5_eswitch_unblock_ipsec(pol_entry->ipsec->mdev);
>  }
>  
> -static void mlx5e_xfrm_free_policy(struct xfrm_policy *x)
> +static void mlx5e_xfrm_free_policy(struct net_device *dev, struct xfrm_policy *x)
>  {
>  	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
>  
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index adb14db25798..7c3d74d28ef4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1024,9 +1024,9 @@ struct xfrmdev_ops {
>  				       struct xfrm_state *x);
>  	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
>  	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
> -	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
> -	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
> -	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
> +	int	(*xdo_dev_policy_add) (struct net_device *dev, struct xfrm_policy *x, struct netlink_ext_ack *extack);
> +	void	(*xdo_dev_policy_delete) (struct net_device *dev, struct xfrm_policy *x);
> +	void	(*xdo_dev_policy_free) (struct net_device *dev, struct xfrm_policy *x);
>  };
>  #endif
>  
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 95f67b308c19..6ac079673f87 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -207,6 +207,7 @@ struct bond_up_slave {
>  struct bond_ipsec {
>  	struct list_head list;
>  	struct xfrm_state *xs;
> +	struct xfrm_policy *xp;
>  };
>  
>  /*
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a21e276dbe44..ffae7cc1f989 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2116,7 +2116,7 @@ static inline void xfrm_dev_policy_delete(struct xfrm_policy *x)
>  	struct net_device *dev = xdo->dev;
>  
>  	if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_policy_delete)
> -		dev->xfrmdev_ops->xdo_dev_policy_delete(x);
> +		dev->xfrmdev_ops->xdo_dev_policy_delete(dev, x);
>  }
>  
>  static inline void xfrm_dev_policy_free(struct xfrm_policy *x)
> @@ -2126,7 +2126,7 @@ static inline void xfrm_dev_policy_free(struct xfrm_policy *x)
>  
>  	if (dev && dev->xfrmdev_ops) {
>  		if (dev->xfrmdev_ops->xdo_dev_policy_free)
> -			dev->xfrmdev_ops->xdo_dev_policy_free(x);
> +			dev->xfrmdev_ops->xdo_dev_policy_free(dev, x);
>  		xdo->dev = NULL;
>  		netdev_put(dev, &xdo->dev_tracker);
>  	}
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 81fd486b5e56..643679b8d13c 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -394,7 +394,7 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
>  		return -EINVAL;
>  	}
>  
> -	err = dev->xfrmdev_ops->xdo_dev_policy_add(xp, extack);
> +	err = dev->xfrmdev_ops->xdo_dev_policy_add(dev, xp, extack);
>  	if (err) {
>  		xdo->dev = NULL;
>  		xdo->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
> -- 
> 2.43.0
> 

