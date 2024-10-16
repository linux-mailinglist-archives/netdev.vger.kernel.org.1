Return-Path: <netdev+bounces-136154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD599A0922
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCE11F2132A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D71206E71;
	Wed, 16 Oct 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPEiZgCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D27156E4;
	Wed, 16 Oct 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081019; cv=none; b=dwjEDVNSWlHTxEIjFNWBjFlaQ4VKgpvj5rBulmP9vlayBdyZraPgdowQ/Sxd82u0Rslfzl5pW04YaYZMQyyGViF9JR3uk3lqcaijeYT6nmvkSvb7HfLo7zYIFRVWuQlHsmEv0HD0f7YE/rc77ruKICpsbIz1Z+VMP6ZsUO9SWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081019; c=relaxed/simple;
	bh=VRbMtHGfLmz9IpUkFeNIapr7LLyr32SyBhaKq4Er/uc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzcGOYW8H8vTJlR3qsgiM/2/UnAxGgJBXOOAu0crA1WF1ZjK5d0blPrjMlpx4MQwo6fXsBnGBWT9QdBQ69gyUz7K5KIrl5ebOQnBhgT6kZuD5pn9EJvay2taMO8+0n8WG9dci4CkAB+Ael7F+rKtrRHt7Ka4gQkTiPQVwN0zAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPEiZgCa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so4633815e87.1;
        Wed, 16 Oct 2024 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729081016; x=1729685816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDov8APJOOY/cDWD+dhTm3Ac4uukJrdJwPWwPvWrkPw=;
        b=XPEiZgCa8SrESu31S49UkFIyFsqMf1x8mG7puxssXLRW8dp60xwpsZPLGjyv1MZynw
         sFTHs2MBZWgjnbfzwi4zXg3Ead8Y8BiqoO9f/SXdk0fVfe79kvZMdGjvsQivtSyHlN5r
         w4GPccoemGpH50NqYbOwaUlA4cTH/nwht40FIFI3RWyoeczO5Ihp9/g/ZE6N7u+Rjg2R
         nAhc/kRtvMXE/jwURlfNOcMmH/s4WzOD4pIbGca85S599uRnk61i17NzDwo9YZGhTbhQ
         8LJnUyy5rPkjl4ekAZ6/pQZaaJhlksB9MEsY/JtauaxR4azQlm23cb4QYWzWLhg/h8x3
         TiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081016; x=1729685816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDov8APJOOY/cDWD+dhTm3Ac4uukJrdJwPWwPvWrkPw=;
        b=jZoIzic8NN4TrLn0cWmLiUq2VYbXTVYxkHOx/RM5T+iQkmjafC81DvIZdysLu7uJ+2
         Sgs8Py9QxcyFcFpA1DQsrPdv6U1nFGAYYr85lTn9knQMgzqg/omQfuoF9kDOP9KlERw2
         KI+WiIYzeheF0KlkWQ/5c8Lpg7N4HNLJWPwxwIXsEFCsYY/LxxDh+bpGUws42sEHVg42
         3QKMB6tAUmeoYy1gYOdy4QeWJdXblSouwn8zvY15kXpM3RxcHwPDcEtKyijbgfSiJCl/
         YUDDdMInoPaYV+sUmJm2gmr9cImBDlETm2ZzHQ86Ypniu0ZP1gK8DqRhhpK8djQhJh6x
         d4fA==
X-Forwarded-Encrypted: i=1; AJvYcCUlWOSQ2f4taaV91nEz3GCQzyDxGYyYC65mJCxBg6PymiXHd+x6iWvj8nHZhlflfw/L1tfZdL1QCsiGuxdJ@vger.kernel.org, AJvYcCXSyFhW4779/AgJ7xWxJPEnlB97sGgt5Ganw5sFsFhIZXtdFA7TpzN3Tofglcg5z3EULR/sL1uY@vger.kernel.org, AJvYcCXXr7Km8tM0PsWTvMiDl7MIj4r8H0GbR8t/mtTPPRjYunVyEVX3q7bK6gzYIBB0M3/p41c5M9DOMLDtzEbD8Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGh1wvXqRdbvXIQ/G2uC//TIxa/PL3867xw0NV2yrtBSsvHzEF
	AxjPmI/PMipAtgaTlby2HtISdcRxjUyfbTH0rFe9C1FPTWcTewB9GMwd4kQN
X-Google-Smtp-Source: AGHT+IGWc8sGpjeR4SGgRsNAjAxNT/4+L5ndjrGR9jX2QnJ+dKZ49fOcS/bpP6UNUfKoq8DB8HsUiQ==
X-Received: by 2002:a05:6512:2804:b0:539:e110:4d72 with SMTP id 2adb3069b0e04-53a03f88d6fmr2443362e87.56.1729081015929;
        Wed, 16 Oct 2024 05:16:55 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff3a1fsm441780e87.127.2024.10.16.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:16:55 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 14:16:52 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>,
	"David S. Miller" <davem@davemloft.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] kcm: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <Zw-utC4rCCongW_N@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-15-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-15-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:17:01PM +0200, Julia Lawall wrote:
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
>  net/kcm/kcmsock.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index d4118c796290..24aec295a51c 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -1584,14 +1584,6 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	return err;
>  }
>  
> -static void free_mux(struct rcu_head *rcu)
> -{
> -	struct kcm_mux *mux = container_of(rcu,
> -	    struct kcm_mux, rcu);
> -
> -	kmem_cache_free(kcm_muxp, mux);
> -}
> -
>  static void release_mux(struct kcm_mux *mux)
>  {
>  	struct kcm_net *knet = mux->knet;
> @@ -1619,7 +1611,7 @@ static void release_mux(struct kcm_mux *mux)
>  	knet->count--;
>  	mutex_unlock(&knet->mutex);
>  
> -	call_rcu(&mux->rcu, free_mux);
> +	kfree_rcu(mux, rcu);
>  }
>  
>  static void kcm_done(struct kcm_sock *kcm)
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

