Return-Path: <netdev+bounces-114382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D794250D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D8C1F21AD6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C917C8D;
	Wed, 31 Jul 2024 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhjC5KnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E41BC3C
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396438; cv=none; b=hy5LIhmKA97YZqRw5Yuz/Vb04p/cKMunDAt5o1o2aFoweBg081DJ0Sv8oNeoQfFianWp/irM2TYS/sbyu0fxx799CkEbAfANrsY3X26kK4nUHfepas042Vl/lixa+BM03+cfH0QLCtmnYCtCdBszfVcbyVxdtIOH4xX9seFbojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396438; c=relaxed/simple;
	bh=FUKOIAbYeuUWL0sYzBnGJam5Yz3w9Lyv0XAqwYGgmJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnbttvKfi6FMFArjHl38HkIhUpMLPyWZA+q/4yXzWidABOLfgCT7It4JEBkPBUku++1hbF59jIztr1ccTfGNfanBUnStk3OquLjbnHFtJeYu2xRJDUOJTwR2Ntzs9+8tSGTHPpF9eXr8PlENYJS9yIjgFGBgGkMSej5dsZVjmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhjC5KnQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d18112b60so431893b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722396436; x=1723001236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QabgAtOeQ/RMnqsQB4Xr8t9p3N9qPFqJEiA+tenI6gs=;
        b=AhjC5KnQFzd8oFlCPcezFFvJMUjk8QQkouUXdRBUsxekdAsymbCoMy9bN8wnQ8QpB8
         Vd/be7r+8OdhRqO+JFRQm89uj6TNWUU5+x0EQ4V296wmaj3hguOpxIrjlTk0TA0EpL3f
         xWbFWJuoCaBc4PtH1POVLPbBgQ8COPvg6rnjCD+fsyzFUsM7EZQbdz71dvavjzM/Mb3Q
         XBJkXU5w3NH1DY1fzFABUQXpWl+qZvkOSxMZ26NNTyQh7ok19t51nGHS4VhszFUx+oN8
         GYw4NAWmEFqe/TnMbDNwfJd02+2swszutKUFy7L6wHtxHNiJcOgDOhW2p83DNU1cVzWO
         ncig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396436; x=1723001236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QabgAtOeQ/RMnqsQB4Xr8t9p3N9qPFqJEiA+tenI6gs=;
        b=AN4KJgt90dOFrzpdmnBUywmf/H+OzhdMYKfCObDebChmt4Qk9vOtIV1pOe8AzY5Pm0
         V+kxDuBwaGGWllXJfPKK1Y7IM3N8qAh6lRZLDaeqiBzafqzpyv47Xgga9pOhU0x7KOEt
         jdGcHorlIioYGuWURykH5psgFAVbAQ/v02REt5xRtQY5tRhqPaINRWDrzGBoAPSHRRNx
         MQJCGrAJTwlWni8VdFnnLevZMjR/CR+m3j5hSyZNEDqKPVVjo+3Yx30WaE4qBDOEeIZC
         GmcUJuJfvxn6O0w0pKzUXpX6+XXddQCUmQXl0R5p9UQ4NuS6zYsIs3M0sbO28LIPVyKj
         jFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD0T371gzKtdAp43FTG40dG8+Mmg/wMc5+YETJEj+GW8ThOURWXxzT+FYjWcyu2I8so6MQL0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZYvN+NuHz4ZY4BcHWSHRX/ZuTogPZx2zIN1J7KLUY3q5yxQb
	NAHMrHwe74FEOk/G6zIPoEnxAJ0DAaW6aW4GzDyEQ7I7SV/DLquz
X-Google-Smtp-Source: AGHT+IGwbuJ8V2K/PwAdOczemmRP9QoeW163BJmq5eH5zHaaTMfyKa0omRRmLPBpZW3Qj779dTbw1g==
X-Received: by 2002:a05:6a20:430b:b0:1c4:87b2:e086 with SMTP id adf61e73a8af0-1c4e47772c6mr6508714637.13.1722396436465;
        Tue, 30 Jul 2024 20:27:16 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:bea0:2ba1:46ac:dba6:9de4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7aa9b184139sm9130107a12.75.2024.07.30.20.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:27:16 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:27:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 1/4] bonding: implement xfrm state xdo_dev_state_free
 API
Message-ID: <ZqmvD4gzdDILMHiI@Laptop-X1>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
 <20240729124406.1824592-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729124406.1824592-2-tariqt@nvidia.com>

On Mon, Jul 29, 2024 at 03:44:02PM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add this implementation for bonding, so hardware resources can be
> freed after xfrm state is deleted.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 1cd92c12e782..3b880ff2b82a 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -588,6 +588,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  	rcu_read_unlock();
>  }
>  
> +static void bond_ipsec_free_sa(struct xfrm_state *xs)
> +{
> +	struct net_device *real_dev = xs->xso.real_dev;

I think it's also good to check the bond/slave status like bond_ipsec_del_sa()
does, no?

> +
> +	if (real_dev && real_dev->xfrmdev_ops &&
> +	    real_dev->xfrmdev_ops->xdo_dev_state_free)
> +		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
> +}

And we should call this in bond_ipsec_del_sa_all() for each slave.

Thanks
Hangbin
> +
>  /**
>   * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
>   * @skb: current data packet
> @@ -632,6 +641,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_state_add = bond_ipsec_add_sa,
>  	.xdo_dev_state_delete = bond_ipsec_del_sa,
> +	.xdo_dev_state_free = bond_ipsec_free_sa,
>  	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
>  };
>  #endif /* CONFIG_XFRM_OFFLOAD */
> -- 
> 2.44.0
> 

