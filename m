Return-Path: <netdev+bounces-114383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B036894251F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F171C2037F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710517BA9;
	Wed, 31 Jul 2024 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/0JWWDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6818030
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397015; cv=none; b=f259le4DqaqPM8QQ6xM4Hr6gWnZhR2pb5DaG4hty7S3aThY1nwistb/mQff1vAwPYwMyvCDp0azODJVZq+zBy2NQYKds/5vMQj85Zcy9pJWIfZ48rF+F/sWoFdbbFRDkWY9YYjnloEroz8zfRGJUQq9S1eYr5WLiYU3IMiXiYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397015; c=relaxed/simple;
	bh=6KEnruK2RfNqPpI+6NZkg9uOvsBX2pxU/xo+NXD90dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4LZhblkpAuPAJMDiBBl6E7pis22XJ3g6yE7ss0WEwxOoZ80R9MXopxY98pgz8kYavcfQhQi5jfbqT9+ucvcrybMVkEIKaFjUu5uJshyHNhjnwRfbHV9cnapeH4p6V//cGdGVoV2hrX0HTVnnqAamhu3j3IvR2JZjBFnOwTarl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/0JWWDb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd6ed7688cso39327695ad.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722397013; x=1723001813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlgWSaW8Er6VRSfc7sweYIrBix9aW+PndMWKYqczAog=;
        b=F/0JWWDbjZPWJe8RR60HXz2wLx8H9CgFUDmf7pCuikjk0BtjAh71zp6Hr2I+Xp2IOH
         gRk2QwqVOTh4Nx/aoAw9w3pFUOqrObFjqJp3VOX3q/+m5ZpjxK5qKuIizY0FZQHh0lKx
         bdW1JEFS1LCsfacmgM5UD5KiifDGRFBBnyBmOYPomesuRyqpFEtmR0MCNOv+DiDCD4Qo
         8KfM+0pw8GovMdLtpxWhWlNrgtGueXs//AiYmnp5O9t0Hg+fw6LDAzyfyFgGjylfBxIy
         6KC/ZvrIeboIKOgC5u6lHiZKSZyGbcbwnjrkGPngDz38xkfos2vekd40aBLdQVqPavmu
         Cmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722397013; x=1723001813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlgWSaW8Er6VRSfc7sweYIrBix9aW+PndMWKYqczAog=;
        b=khk538WOIexcRg/yVH7RaHIx/Q2s7O1263thqGjYbnCCDyHeV85Jg38emNoxsDo3Ig
         clIJLymbhAJvfzFC+zSQn4euTbH5HtbFbUF5HYsvVb/mm5RP4+d0kZAwMw93cAHanPYA
         0ZvpWA6rAzfyVPJQXrFYKiHWf3dQrMDgHww0nkjt8kLXahNUyU980HxqvSnMk+X6tZvk
         xETLVh0o4aD7NE2s0ZT87BCFMGzlpFwLoDH8znMxOjzw83U42bV1EM26aRcTW0KRyo72
         OlpbSN41k5NH57n1A0dyjUwijfIsu8OC3h0jVhTW8ofzI4XTgeSJ2IbKzvd2rWOqxEvZ
         5A3w==
X-Forwarded-Encrypted: i=1; AJvYcCVIthcZo3o8vaRY3L6YbQ/PEVs+xbf/pRIpGBzybJw5uu4f2L6JQKv5iAtVDLO7OqlBGuwcMtftWKUhF24VL4HHVkva2C95
X-Gm-Message-State: AOJu0Yx2V+b5eB7fFUkC+ovGUDVwurNC3rBhlOLkfkOfTwcKJYhhJ4Z4
	d5ieqT3fyvg4qo66LBHnAGS6EtjPoeocLAEGZjO3bIIyWgRHn6SV
X-Google-Smtp-Source: AGHT+IGOxzhmN73CXcIIln0qSRzs7VS0nZfiA4kJV90VsGSTpWKQ1PzE9A0pMUVjQdGhlApmyqKwCw==
X-Received: by 2002:a17:902:ecd1:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-1ff04805b9fmr139262815ad.7.1722397013485;
        Tue, 30 Jul 2024 20:36:53 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:bea0:2ba1:46ac:dba6:9de4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd813sm109712115ad.170.2024.07.30.20.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:36:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:36:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 2/4] bonding: call xfrm state xdo_dev_state_free
 after deletion
Message-ID: <ZqmxUD29yIVHTaQb@Laptop-X1>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
 <20240729124406.1824592-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729124406.1824592-3-tariqt@nvidia.com>

On Mon, Jul 29, 2024 at 03:44:03PM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Need to call xdo_dev_state_free API to avoid hardware resource leakage
> when deleting all SAs from old active real interface.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 3b880ff2b82a..551cebfa3261 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   __func__);
>  		} else {
>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
> +				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);

OH, you do it here. 

>  		}
>  		ipsec->xs->xso.real_dev = NULL;

I'm not sure if we should make xdo_dev_state_free() rely on
xdo_dev_state_delete(). In xfrm_state_find() the xfrm_dev_state_free()
is called whatever xfrm_dev_state_delete() is support or not. Although
usually the NIC driver will support the _delete() if the _free() supported.

BTW, For me this patch should merge with Patch 1/4

Thanks
Hangbin

