Return-Path: <netdev+bounces-136136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904D9A0802
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045A9B22B71
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AFF207210;
	Wed, 16 Oct 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrWFJ6/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168A1CACDB;
	Wed, 16 Oct 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076754; cv=none; b=ckQWNu88fkHol67DECp4hylkMUwozRlO20d+wmAFzblJuvDUv5GrOB6wlfcAI192+snA+meMt/DFwqtjvrSbPWvQS+9zqELFmSKInxVoNaIYpwDwuGUGZuluySjn7DQkmUwqS6uhkfr2mDQNonMe87motF9bZb2PtJJt7EoAKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076754; c=relaxed/simple;
	bh=LGP8XR63nNO5ElCIu/02JsR6KlPMp9Bah7/In8e+CR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klCyDhnOGNNK7bgqTU+72CyUxVKl/wiahngPSm3VQvTVmgSXD6kvy3KJhRThAK7D0LpbajpSW3JGiqc/S+zCETMjBorEXu9l9LlM0sMqlYWH/t/ol1TbFvFJi6e7ktX0ZOLnrYBqiONJl/FVgNFDGN0YHWVZYTNmWP+U/irSKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrWFJ6/Z; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso32863611fa.0;
        Wed, 16 Oct 2024 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076751; x=1729681551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4LueB2KQgGxlu12dfcJNaqU0W/5O88/vcQ/21eniVw=;
        b=TrWFJ6/Z+Fu0IdUI7Du+sKW8No2SL5lWFZBZwV/HNv2YTYLV5cU9FS82feuG5fOymx
         oVLePCZUW2Hk+VG0lxixlkZwnyhQbYRvW5/Nnx7bKhThBrMhtpiBk5138GmP6/mOisM6
         lvUtniKNjpNWLblHHjj3CqMetwe1oKeZiDD7bPfm8DUufWv/gW6RPEjzesbLP7bZxPea
         wxP1ER8zxipol276Rt2e1UpMa8lQKps96qROH70kEbcfRwNNs6lOizRYL3NQsmpjEPUn
         ol8yrWG7syxjJN9BydyfVKLExv2cJSbsHlArex9VHF11d+oObhHZNlWi3+zU0UbjOfts
         5Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076751; x=1729681551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4LueB2KQgGxlu12dfcJNaqU0W/5O88/vcQ/21eniVw=;
        b=tWXq+qA33M35Ch7RKMEdDkTmu0u5veSVKP5aZJX//iFgp9zk2diwsqkjmFBSG82k0A
         TdMZBQY1cJZc9DxvXnnD6zVEOOkrB+XrNHPMh3V0FC6Ga/HFY4MLzb52gGtENnuaXiZ1
         eDrKF8yJucki43xRuU52VwrqDCZa+ipIerTbTpqBfwl7e1HcO0b6xNsTrsAAp1DM+fN0
         XEJZSYLflV5365XUg7ZkpXk6OIS9iZYvXmhMf9SHbHCEnJhqIKh0oMZy7sU8g0u5a9/u
         F6LVfVS2rKRR8CgtwAMweIQAa3UlwqNTz90r4m2sE8We8hg38Z7NaycusUzSbZRPXaz5
         tkzg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2CxHio63jL4QsHqxnzPCVTdi/nys6qhQGnb+Apn8R1q7P78k4i485+N3UbDiSGbK59kXaA4JyPGYZZsT@vger.kernel.org, AJvYcCWyB5HG4+0/WDxLQ4vxrlgAWzb9ncqejGSH9S4KKwoqJpZNn2KQvj3GP7M7MeX8pYBnb99NSZ4b4RQNlYoZqDg=@vger.kernel.org, AJvYcCXARFpT0CvOqG455+PwyAIweYxNnE+Z74YwEGqp0e7+j1hdLDwygeuR2KCHloSqkDUaqJsQXnKr@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwX/ZFHUGeM1BaVCWLD6JDbM6sR3Q40hzj6TyQWzVlL6dtXwo
	b43obZiAn9Ub2VRnE4n4wLrqp4l5fptWznskIT9v/4bh0yXZZKD6
X-Google-Smtp-Source: AGHT+IGrcfyamzd6ykzuN6rZt6YTTc+0CMnG2WFlNB4kpaQ+AjqM8Bd8qcm/g39XHvVQSx6ZeTf34w==
X-Received: by 2002:a2e:a990:0:b0:2fb:5a7e:504f with SMTP id 38308e7fff4ca-2fb5a7e5276mr37840231fa.35.1729076750886;
        Wed, 16 Oct 2024 04:05:50 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1a82c3sm3949501fa.116.2024.10.16.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:05:50 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 13:05:47 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] xfrm6_tunnel: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-ID: <Zw-eC42Wd33HDoad@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-6-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-6-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:52PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  net/ipv6/xfrm6_tunnel.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> index bf140ef781c1..c3c893ddb6ee 100644
> --- a/net/ipv6/xfrm6_tunnel.c
> +++ b/net/ipv6/xfrm6_tunnel.c
> @@ -178,12 +178,6 @@ __be32 xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
>  }
>  EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
>  
> -static void x6spi_destroy_rcu(struct rcu_head *head)
> -{
> -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> -}
> -
>  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
>  {
>  	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
> @@ -200,7 +194,7 @@ static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
>  			if (refcount_dec_and_test(&x6spi->refcnt)) {
>  				hlist_del_rcu(&x6spi->list_byaddr);
>  				hlist_del_rcu(&x6spi->list_byspi);
> -				call_rcu(&x6spi->rcu_head, x6spi_destroy_rcu);
> +				kfree_rcu(x6spi, rcu_head);
>  				break;
>  			}
>  		}
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

