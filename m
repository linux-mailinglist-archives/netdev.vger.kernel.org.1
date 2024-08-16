Return-Path: <netdev+bounces-119089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51F953FF9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EA51C20EC6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81A53804;
	Fri, 16 Aug 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUuDF/vl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8C26AC3
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777687; cv=none; b=ZxaR3qSP41YwxU0g58X2pg40wO7ACjmocHK3d6Ih4h3J87KbCVKHq9/YhL6qVYiQ0HpjNw8rGmSN3G6UU3a0ASpiwumL7NxHrtj3Nk7O75jd1pxcHonvePM8SB6RokJi3YvWhjqgOQSkJxJBF84W6qrfYQAGxePduVHeacPh7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777687; c=relaxed/simple;
	bh=iAbxl+0137wQFL873fJuvcqjnK1/i0pJgsjCezLJj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POq/NWDOn8tRWPR9PS9UqJLDFJlUMdT1CPqYbFDuZM/UFm6MUBtitfmvzV5/746TcSGcK7xf+kmheUh6tSJkQefCzHvQKNWK4kVRLRnd3hI0AXyn9xp6z8DIwLiidHr6H/2G8/75H/SUZPVIDwyHjItXJrGdNo3rMVNdvi3pg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUuDF/vl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1657c0fdso975189b6e.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723777685; x=1724382485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUkyboWcJEPG28bs7HVQi08gzMWoFmjbUxZZmnYJgts=;
        b=FUuDF/vlYfVJMskLe02MA6o2kW9ojcp50DjME+y0hfmrFTJwLYJ/MXXuoEV1vsCn6W
         Vcp6TrlrraBy3K5D3055tYLYlfZ9/5w4eyX5qWd/90BIfZxuYghVYQwpdLZCnqm6i8nI
         PWESKDJU+HG9uII/73F0HiXBz8oQWAMflIZTEjNp85kIA1xRTZZq46h4JDpUJy05Vu3y
         ocH5GWq01a+D21Ud6/4KdRekGQp/oNGyPSq9mTqSUWLaVPFZMDByhg1j00ESjoFQG0Md
         m9bT/b6iKcoeYytKDzPmd5O0OfhCUm6ZypqCWM2zykusqoWb5aCMHzg1LGZ8K+iiuThH
         VyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723777685; x=1724382485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUkyboWcJEPG28bs7HVQi08gzMWoFmjbUxZZmnYJgts=;
        b=Suru2hRWFvGjKMLtjGYWXxhsxjje2ozM/rw4Tr+k35PDae3pgAzquzo9TSbowtfMR0
         9Vs+3sF52bm/zGiUFQyFDKiH6gzPuVK7VN3L0ta9I0yXjQr77T7f+7PadeTBly/8f7XC
         z2kl6waIvKfTVsdHiGoUgu0EatlRZ5dVVIE3gZKnNnOHpK5Rf9VqqBXdotu20jGwhY5K
         hMxv0EjWBeb2JnrM62Un1RJeda8gVI2zut3OHDtUvj+RlSQRWeTwQJ1xbZP7OAQVaxnH
         MvHzOLZGydPqdIat3txO5hNeQV8BGFjWBNPbkwnJHh0yhATRMqQUt9lRDPqfK06f03fW
         fvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWOsfb6D5UiyfQf4HHJHmIcwo1ZSj+ENVVZIL8qh2osltQmX8O4uOfCEEgH2aHM4vXQYro59lUNpkpycamQMVQqxsHXPLwd
X-Gm-Message-State: AOJu0Yy/z7PyuD12DVUia1PmVHx34dzBrWaY5b3xlhIvC9vrJP8g+3XY
	HBA51QHUDJgOK2T5V7c4hg6d1xEiOI6B6st+8dEHjZtk8axkGFi93rSwBl+cqZ8=
X-Google-Smtp-Source: AGHT+IFt/6tN+9rBRdn979nQKbv5LnOXb8e/SSOGLLAFcbcisRYxDRTwaGYh5GHDBlUc22bEKa4fQw==
X-Received: by 2002:a05:6808:1783:b0:3d6:3450:7fed with SMTP id 5614622812f47-3dd3ae5660dmr1541455b6e.39.1723777684782;
        Thu, 15 Aug 2024 20:08:04 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c84sm1912290a12.74.2024.08.15.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:08:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net V4 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <Zr7CiE9Rw8cxvzPf@Laptop-X1>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
 <20240815142103.2253886-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815142103.2253886-2-tariqt@nvidia.com>

On Thu, Aug 15, 2024 at 05:21:01PM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add this implementation for bonding, so hardware resources can be
> freed from the active slave after xfrm state is deleted. The netdev
> used to invoke xdo_dev_state_free callback, is saved in the xfrm state
> (xs->xso.real_dev), which is also the bond's active slave.
> 
> And call it when deleting all SAs from old active real interface while
> switching current active slave.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 1cd92c12e782..eb5e43860670 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   __func__);
>  		} else {
>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
> +				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  		}
>  		ipsec->xs->xso.real_dev = NULL;
>  	}
> @@ -588,6 +590,35 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  	rcu_read_unlock();
>  }
>  
> +static void bond_ipsec_free_sa(struct xfrm_state *xs)
> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
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
> +	rcu_read_unlock();

As I replied in https://lore.kernel.org/netdev/ZrwgRaDc1Vo0Jhcj@Laptop-X1/,

> +
> +	if (!slave)
> +		return;
> +
> +	if (!xs->xso.real_dev)
> +		return;
> +
> +	WARN_ON(xs->xso.real_dev != real_dev);
> +
> +	if (real_dev && real_dev->xfrmdev_ops &&
> +	    real_dev->xfrmdev_ops->xdo_dev_state_free)
> +		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);

How do you make sure the slave not freed after rcu_read_unlock()?

Thanks
Hangbin

