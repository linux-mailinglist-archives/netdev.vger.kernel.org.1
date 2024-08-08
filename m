Return-Path: <netdev+bounces-116901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0094C041
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50767B2109C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3F1474DA;
	Thu,  8 Aug 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NIgl0qs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DDBE68
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128755; cv=none; b=CBVpo3Y7e7a/WUjLOGRznP/ZZLrcz8eoNEtOj4WFtpAasR418sTakhFDbN5VPFkQrKe4p9yk3w8hMTQyhttQ7iJjzWcbSWTY+Tv+rM4gBOyHiYf0/sy2IpAYAh/ZMo8QGrwpJY7wcurX63ca/Nq7qmNpbdHDOhz7EpKNJJxS2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128755; c=relaxed/simple;
	bh=Qy5Z4SYkf9RHrKn2qEsjo16mYApFeW0ZvPKJmlmDXns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaOO4xgK3jKMAufV4iejA0n5aLI3rmpaQ9+GagwGWYj9zL811pZZkCPbFrkc65HUcd2Tfe+7AeKqXtNEbeBn4z+S740yXqv9Azj28IviREUbQ5sBLC7rcrIXwvqxl/JDG7i0qD0mDg4Jbkmh0wWNtU13EFK9hf1c+Qp6U7AN+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NIgl0qs1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42808071810so8020335e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723128750; x=1723733550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJrfc5TCBvpzkCmchediYMn9fam4lNwTfZaqVWKC+Io=;
        b=NIgl0qs12t59KB7h+QpMj3ii3eB95ibctICnhdQZLhzkdoYo3B3cr9zfM3hQPdc/B7
         SWS5r4KUhzMybEr2AZPOHsnjJxHRECYahjxTaO/CqqXqveNG9tqAt4fQLE3INQE2uiXD
         Hz2vWRxpGAx87hMZPOyAj3Bi5UyDJnmwljIo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128750; x=1723733550;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJrfc5TCBvpzkCmchediYMn9fam4lNwTfZaqVWKC+Io=;
        b=CfihOMGC+4Aa9/jwkCvybAsYoj3KnwWIXLE0Mdr+dadLYHKgfJCSqoQAiRLwsCJuAt
         CvpLPLH7ULyfxt3A4WWaDsovsXWDeR+m9CdscGZ2Wpc3fAcRRcgdR9UXGPAI0LzDf8wo
         NyQEESAURk1WEbHffdDs4psoTTiJ2S7j9audDXEafW7KrHzQheNjxolwZSkATOiICl5z
         WpJ2ZYT18wOuxBT7fAqw5qGXb8T+FpzaezTkm8amiy4Ey4go98FKGCN4EUlXE5Dg9l+M
         iN9sVOFqtFVXEkcVmmAjB8k5XI1F7tH/CplzQOnVPwq8m7gkYSv6xd5Woc7QPd111PM7
         w5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm++/lXAkpuUiJ/Q8R/Z6bbw8jVgeKbL3XbrI1xZyqXW69UGIvU/Xh7+AdcJ9d66ogUGHGjK0WVZhtPKCiyFNI8+Yqq64Y
X-Gm-Message-State: AOJu0Yw1GyK99rxW/iy2d3B9QFrgxppwdiTzwUBX/FWJHTHrsPlzNBLX
	tJU/5dDxdQNd5TKAfGXxPlA98nQyeXsKrNWxJcEAlTJtzO9g70tFjZhrjUtbTacsIURbk+GoVpb
	x8Qk=
X-Google-Smtp-Source: AGHT+IFJqqhuoYsYqiLDwQwQauFpbbfY1WMKfGi1FA3omaY0db+Wq+lIlwdMZfOP4vE9Hx94IHXRkQ==
X-Received: by 2002:a05:600c:3ca8:b0:428:fb7f:c831 with SMTP id 5b1f17b1804b1-4290af46511mr19408185e9.32.1723128749638;
        Thu, 08 Aug 2024 07:52:29 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271576c1sm2131692f8f.21.2024.08.08.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:52:29 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:52:27 +0100
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net 5/5] net/mlx5e: Fix queue stats access to
 non-existing channels splat
Message-ID: <ZrTbqxRflu5HVMSY@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
 <20240808144107.2095424-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808144107.2095424-6-tariqt@nvidia.com>

On Thu, Aug 08, 2024 at 05:41:06PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> The queue stats API queries the queues according to the
> real_num_[tr]x_queues, in case the device is down and channels were not
> yet created, don't try to query their statistics.

[...]

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index f04decca39f2..5df904639b0c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5296,7 +5296,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
>  	struct mlx5e_rq_stats *rq_stats;
>  
>  	ASSERT_RTNL();
> -	if (mlx5e_is_uplink_rep(priv))
> +	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
>  		return;
>  
>  	channel_stats = priv->channel_stats[i];
> @@ -5316,6 +5316,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
>  	struct mlx5e_sq_stats *sq_stats;
>  
>  	ASSERT_RTNL();
> +	if (!priv->stats_nch)
> +		return;
> +
>  	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
>  	 * to date for active sq_stats, otherwise get_base_stats takes care of
>  	 * inactive sqs.
> -- 
> 2.44.0

Reviewed-by: Joe Damato <jdamato@fastly.com>

