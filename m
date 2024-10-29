Return-Path: <netdev+bounces-140074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B710C9B52CD
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E63C1F23276
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E71FF5F3;
	Tue, 29 Oct 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sUAB/mXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C3197A93
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230456; cv=none; b=PYAls8z18HU72DU40nzWkIbokhd4/ET0Kekz1Bh6/Pfz+fiS6lmwmlYLm2/U53a3gu9lroq4457Fp4SodaXjYlf+laEY4PIYzhhj08EvpsaSuJKK0YUyVzyxU5hYasXw4AG0EG9jou8vr3FrAA8vfol9ugRFgQtfuNsAEW4kkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230456; c=relaxed/simple;
	bh=P1tTgThqsFt8vz3y1hINdezDy9kQs/Hjazrj1pHsIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba80+ZRysC3908zzDDDrYc2xIdWFigVRgEcdo2wErnIwgmDfw3uGnaqtEmiQ2O2Z5Ow4Pi+tNfo/RmvYj8i5i6u7UGFaGf0ybGmAjeLaGVIgCdlTCswQGHnXQEuJj6M4sDIkTaAhHueBbk0fPV3Wtr1OTErKAiKFQz4DwyFyXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sUAB/mXc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c714cd9c8so61466975ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730230453; x=1730835253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4y/Kbg2zk2qv1FAw8TAeS+rHVEscF8RSLkGI3p/h6A=;
        b=sUAB/mXcA2UYkHuxknTb57qjcGQFCktuZB/Ey5Mn8rXt81bK38STyAgWKFTWT/wp2w
         TxdRRQkavTrHy8FUmwRpWtIpdPLVGcLGcDzrvYJdkIB5xLgWD5nv1AbEbfE1w7v6aMVD
         RJbLzym1Tbku3WSzLL2HVm01liNnDcFwBxLKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230453; x=1730835253;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4y/Kbg2zk2qv1FAw8TAeS+rHVEscF8RSLkGI3p/h6A=;
        b=N8Fk841qTch2o5+6Cl+dJsphQJ5Wd8NhpBBPk119eQUBFQy2uSepL3Qh1znQdnvxW3
         ir1oLY9lKjJ6spU8BTN8w1qwfJ69kfkjmkDAH6Y7UNfwQA+YaWhrVnjHWLEx27RGefBb
         Qv4fuVtXdSDvhtv/J5YaKAfZQqqoG8NK8+unTwK56RtQuCKXZcBzY4gXIcBJgKxhgpRj
         s3VHXISWsaNnbmGHZqYIM73IyaT2pybqa008nY4BnyNPMQMGijtyu+Bv7sV7ElIGaIkp
         q4Ofq3qjMKGb6zuWrkSgt85a8U5bEigTdxyUfw+1Aby2TYd+bNpziBQ+kR9WyVE6neBj
         K1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUnhyqFi4xBBBEs6fqtyLrb53YTTwuTEcbGKIa4JyaZW0rHaLCzQjdQnuzLf6QKe2WRWHA7WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEr2DSfxVlD5uMDzhkdq3URTMS4YiLnar0kaNJ5/Ivk4gfZNF
	tQH+qZlO6BqR0kAqb/FsDVu08JdlbM4zvOox8QR4ZiLxQBHyZn8xaLxh6uW1uMc=
X-Google-Smtp-Source: AGHT+IFuXX0/BRVn3mHp56P2x5uaD9pSJn37K6qs8/t/0oJ5dVn8ecbgaKt+s8G6X1fiYkvZsSgPIg==
X-Received: by 2002:a17:902:e84f:b0:20b:6d82:acb with SMTP id d9443c01a7336-210c68cec13mr186903775ad.23.1730230453508;
        Tue, 29 Oct 2024 12:34:13 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013477sm69811895ad.175.2024.10.29.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:34:12 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:34:10 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] dql: annotate data-races around
 dql->last_obj_cnt
Message-ID: <ZyE4sn-F0ed9YQFQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241029191425.2519085-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029191425.2519085-1-edumazet@google.com>

On Tue, Oct 29, 2024 at 07:14:25PM +0000, Eric Dumazet wrote:
> dql->last_obj_cnt is read/written from different contexts,
> without any lock synchronization.
> 
> Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/dynamic_queue_limits.h | 2 +-
>  lib/dynamic_queue_limits.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
> index 281298e77a1579cba1f92a3b3f03b8be089fd38f..808b1a5102e7c0bbbcd9676b0dacadad2f0ee49a 100644
> --- a/include/linux/dynamic_queue_limits.h
> +++ b/include/linux/dynamic_queue_limits.h
> @@ -127,7 +127,7 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
>  	if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
>  		return;
>  
> -	dql->last_obj_cnt = count;
> +	WRITE_ONCE(dql->last_obj_cnt, count);
>  
>  	/* We want to force a write first, so that cpu do not attempt
>  	 * to get cache line containing last_obj_cnt, num_queued, adj_limit
> diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> index e49deddd3de9fe9e98d6712559cf48d12a0a2537..c1b7638a594ac43f947e00decabbd3468dcb53de 100644
> --- a/lib/dynamic_queue_limits.c
> +++ b/lib/dynamic_queue_limits.c
> @@ -179,7 +179,7 @@ void dql_completed(struct dql *dql, unsigned int count)
>  
>  	dql->adj_limit = limit + completed;
>  	dql->prev_ovlimit = ovlimit;
> -	dql->prev_last_obj_cnt = dql->last_obj_cnt;
> +	dql->prev_last_obj_cnt = READ_ONCE(dql->last_obj_cnt);
>  	dql->num_completed = completed;
>  	dql->prev_num_queued = num_queued;
>  

This looks fine to me. I noted that dql_reset writes last_obj_cnt,
but AFAIU that write is not a problem (from the 1 driver I looked
at).

Reviewed-by: Joe Damato <jdamato@fastly.com>

