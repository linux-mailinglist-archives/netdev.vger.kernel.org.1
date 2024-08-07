Return-Path: <netdev+bounces-116399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AB94A531
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DD41F21559
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3A1D363F;
	Wed,  7 Aug 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahVb1Skb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEB1C9DD9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025592; cv=none; b=XAVUNf1W46oGFwEUInpPOCLn/JO0w7g8/GNKHc6CBwpXTXsw/Tld0J2dJ2IhwKDeS+ibrzlAXsMbvqlI5niv615/CQPYgcuev+4ZWs/exGwS6mU5z+EZaaSYGr10qBFC/nFhj0Mp8BQ6SjqfrHaXisakGUZ2XYzMAs4wAiK8K7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025592; c=relaxed/simple;
	bh=a9qstbZUdj4zerUtJy2zMK5LLFARfiES4SaVinULwow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt9qJ3l9N6VWbh0LL7AVL79ZQ5qo4H4lyueq6BJwqgrW5AokYSW+REwgBTbbEXYYzzpAaZjNxEOws9tbqEEO6ejy0+AXMoOdYw4AYDQPi2y8NWS893gxZmq14ef8Kwvs9M2+o/0nNq+CRgT8J9P7tm6aqAlxw/8bu1RoVIry+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahVb1Skb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710887a8083so1244470b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723025589; x=1723630389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOPV9L5mPl8b92uhm4s0IxChKZU6NOmSmxQbGdfgSJg=;
        b=ahVb1Skb9cFvvlwRxbI4lMqX/EU/MZf3vmIyHJ7LZ/6iCZGXWOFQhdeJI3m+keYTKP
         Uh2qe6QX6zAeSxzeNOxoBVoK2G/HbxhhxHwZZlPgnz3VDCMYWJ0T6RS6OCl7CsmRnijt
         ZZBvVMsEt8T7pVv9j6yeQJHyY0KnIrvSBplCISxq9QqUPIxWvgyYyB5S4Q8shX5CxTiB
         a4lXKliMMX2b1heRWiYu7qwvj1xJ9y92zJh8isnClf71BeCAjaAiDsMPfY10vdqfdXbS
         TFNhrv/n+vphYjePAZvLwQVwTQBW0clKEUw9RkpPvzfqaE4hM+MYagQ3v2mk6N45A+VX
         Mkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025589; x=1723630389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOPV9L5mPl8b92uhm4s0IxChKZU6NOmSmxQbGdfgSJg=;
        b=m28ZIBVu+7rnshFaZ8HpWSg7TH8YN/fAu4ych86vXuT2gCNUGTT03Bbup+FZT4aGW+
         9FyAu2hpRou57oIYmV6RbiDVKcbGFfrIgVjAwyQs8YN253zR3V+wJuvNKrM4WJUl2hnu
         2d/YCciu16XRhMtK5llJ+P+7IswV67kYostXtNsWm9jXAyeSomCtzEuegIZkYIgRv3mX
         V4dNIahH3PuU5oMWAE00PjfwDG62K5C0J5mgR9wZqjpYBITRQGtEn4ifz6h74GllEvOu
         q8OGZ/GYiwZBGJ0bieRFluozX+RNybPC2z+YZBf5ALfVHWiBE3Sjy6T6Xn7Iv5l53IZ2
         e0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqGal6+Km5BQCwaI+FXg2bcaiGtv/VaT23II/6BntJiyZxdV1S5wDmvV8usINfrQMGnbUoDOQ4T4jR3VMEaOdt5bvatKUY
X-Gm-Message-State: AOJu0YzZiQXb/nwHWN9YfXYVWNxxbWn8xvcu5spaW69QbLfMZZli6+4g
	S8SYM4EPbNRgZn0FgC7CyXBGOwCHCdJq6JUM9vEFzTXEjaH40ha8
X-Google-Smtp-Source: AGHT+IFuwNGyDEfoBjmG8yOlSJxMgvhE9uv+qmSFG4NgYvppNO1kaHfWBlj/wtZU+DkWD05i3hUo5A==
X-Received: by 2002:a05:6a00:240b:b0:70d:3938:f1a5 with SMTP id d2e1a72fcca58-7106d081fbamr18187129b3a.22.1723025588841;
        Wed, 07 Aug 2024 03:13:08 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710bd9064b5sm724386b3a.127.2024.08.07.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:13:08 -0700 (PDT)
Date: Wed, 7 Aug 2024 18:13:02 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net V3 2/3] bonding: extract the use of real_device into
 local variable
Message-ID: <ZrNIrpIytVv8AV0-@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805050357.2004888-3-tariqt@nvidia.com>

On Mon, Aug 05, 2024 at 08:03:56AM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add a local variable for slave->dev, to prepare for the lock change in
> the next patch. There is no functionality change.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index eb5e43860670..e550b1c08fdb 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -427,6 +427,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>  			     struct netlink_ext_ack *extack)
>  {
>  	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
> @@ -443,9 +444,10 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>  		return -ENODEV;
>  	}
>  
> -	if (!slave->dev->xfrmdev_ops ||
> -	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
> -	    netif_is_bond_master(slave->dev)) {
> +	real_dev = slave->dev;
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> +	    netif_is_bond_master(real_dev)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
>  		rcu_read_unlock();
>  		return -EINVAL;
> @@ -456,9 +458,9 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>  		rcu_read_unlock();
>  		return -ENOMEM;
>  	}
> -	xs->xso.real_dev = slave->dev;
>  
> -	err = slave->dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
> +	xs->xso.real_dev = real_dev;
> +	err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
>  	if (!err) {
>  		ipsec->xs = xs;
>  		INIT_LIST_HEAD(&ipsec->list);
> @@ -475,6 +477,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>  static void bond_ipsec_add_sa_all(struct bonding *bond)
>  {
>  	struct net_device *bond_dev = bond->dev;
> +	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
>  
> @@ -483,12 +486,13 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	if (!slave)
>  		goto out;
>  
> -	if (!slave->dev->xfrmdev_ops ||
> -	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
> -	    netif_is_bond_master(slave->dev)) {
> +	real_dev = slave->dev;
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> +	    netif_is_bond_master(real_dev)) {
>  		spin_lock_bh(&bond->ipsec_lock);
>  		if (!list_empty(&bond->ipsec_list))
> -			slave_warn(bond_dev, slave->dev,
> +			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_add\n",
>  				   __func__);
>  		spin_unlock_bh(&bond->ipsec_lock);
> @@ -497,9 +501,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  
>  	spin_lock_bh(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		ipsec->xs->xso.real_dev = slave->dev;
> -		if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> -			slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
> +		ipsec->xs->xso.real_dev = real_dev;
> +		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> +			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
>  		}
>  	}
> @@ -515,6 +519,7 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  {
>  	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
> @@ -532,16 +537,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	if (!xs->xso.real_dev)
>  		goto out;
>  
> -	WARN_ON(xs->xso.real_dev != slave->dev);
> +	real_dev = slave->dev;
> +	WARN_ON(xs->xso.real_dev != real_dev);
>  
> -	if (!slave->dev->xfrmdev_ops ||
> -	    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
> -	    netif_is_bond_master(slave->dev)) {
> -		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_delete\n", __func__);
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> +	    netif_is_bond_master(real_dev)) {
> +		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
>  		goto out;
>  	}
>  
> -	slave->dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> +	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	spin_lock_bh(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> @@ -558,6 +564,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  static void bond_ipsec_del_sa_all(struct bonding *bond)
>  {
>  	struct net_device *bond_dev = bond->dev;
> +	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
>  
> @@ -568,21 +575,22 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  		return;
>  	}
>  
> +	real_dev = slave->dev;
>  	spin_lock_bh(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>  		if (!ipsec->xs->xso.real_dev)
>  			continue;
>  
> -		if (!slave->dev->xfrmdev_ops ||
> -		    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
> -		    netif_is_bond_master(slave->dev)) {
> -			slave_warn(bond_dev, slave->dev,
> +		if (!real_dev->xfrmdev_ops ||
> +		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> +		    netif_is_bond_master(real_dev)) {
> +			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_delete\n",
>  				   __func__);
>  		} else {
> -			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> -			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
> -				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> +			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  		}
>  		ipsec->xs->xso.real_dev = NULL;
>  	}
> -- 
> 2.44.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

