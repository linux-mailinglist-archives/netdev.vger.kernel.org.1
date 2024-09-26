Return-Path: <netdev+bounces-130029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331559879FA
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462551C221C4
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544417C9BE;
	Thu, 26 Sep 2024 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pTKV43Z6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFC1BC58
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381181; cv=none; b=d2oUHolDzogFXn4iwE8/BKfbJfHBAere2BxhF/34lUeCP3hQJZW4x4BPfTp8+yaHnlHdyHGj2bPsqFgthhevUifdkmUyhy7R6wUxwncAUXsTkKQZD/9GtL5xVbNSM6FHIS2zml7JehmLJUiYRMGpJIlIpSBi1jh//zH0Xeuw0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381181; c=relaxed/simple;
	bh=MEssX4yILVeAC1uIdEzbSRQ9UX3RR5r8PJ4EaArQxLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRuj/5SXtGBkXKhl5iixuVGNvhEFhQf2Kgzj4mAjs+9QgcAC6prVtt0AX/abjiY6QPRZdWnZWqUvfNS3TFJuaDr4SbmyccddTyNxkR9+1Yp4K6S/RjvtystyTUSdjQq7m3pirjWzVpW0z1N2+nzQpkZOGNoovzAIaUb6Nxk2CcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pTKV43Z6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6ba3f93fdso845756a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727381179; x=1727985979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swZlxmG6FKIOk0zxgp4oMKx1YRyCiEGhvO9Bt8p8EKg=;
        b=pTKV43Z6vl4297xdWUlkR3d3n6aP/F5O44r8Rzse5oBcljNT9dU44/QRTRrGD9D/8z
         XFcz9k+gEyAwRkK+7BSjuRVm2oQG1UDo6m+7RojajbJB0o18ehtSKGTtCMtsyQcUFFCc
         ftEyQG8lqXcZ8aOff5nrOnOevFh5DYVLOfWjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727381179; x=1727985979;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swZlxmG6FKIOk0zxgp4oMKx1YRyCiEGhvO9Bt8p8EKg=;
        b=YthilBIB79iNk03ZbVZ/IYqTZTCgS8KhOkqZJBUYgnF7dQEa1cmSRs6/mthRrQiVRm
         x8/Sp3dDN4Cm87mUhPCkPQOk2VVjEzrdLi06tUg9ejZ3yf+sGTEydShEriy13CZpYWTn
         QJZQD8maDYF9FkPD6H+Ez4iVkBNd5UfIf8JKAfjPRsZGZcNkKe06wwxxF7JhrbByDX0f
         1jqn7ab1l/zdcEG0xMkWQENqCMlHt5wT6RZJicM5pZk8Ve3T+Ozn+wzHeXh5YXwbHJeu
         8RfwMqGD3iG3pazPCbGeQ30eoZRS88wH0PcqwGMfNQuA1I84Ri2UNW5Dz2+efGlihNRu
         0NBg==
X-Forwarded-Encrypted: i=1; AJvYcCV2c+yhSsArW9sjbQd1AaPRMyO+dzrflusk2H+Kym8g54HTVt8M0GQ5a/V1XmFBR6jlUdLbCeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWoSVplRac9xTc6V6vHqtjrv+yFzh04HKS9u2zpEicH6UCAR6
	03KwjtNhelBJc0dZVLpoCXbFtCIeWujrOuWI5gId7rXciimhoJSzCC06a70vuaI=
X-Google-Smtp-Source: AGHT+IEP5wXYfk8fD9KatnYjoAjOMUuIV20iBOhYJRWUVeWJ4snxL7VJgJ+3iQWN2UvxXlTBlznT4A==
X-Received: by 2002:a05:6a21:a247:b0:1cf:4dc3:a89e with SMTP id adf61e73a8af0-1d4fa64d9d3mr817395637.9.1727381179484;
        Thu, 26 Sep 2024 13:06:19 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db617088sm283043a12.93.2024.09.26.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 13:06:18 -0700 (PDT)
Date: Thu, 26 Sep 2024 13:06:16 -0700
From: Joe Damato <jdamato@fastly.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	liuyonglong@huawei.com, fanghaiqing@huawei.com,
	zhangkun09@huawei.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkarsten@uwaterloo.ca
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
Message-ID: <ZvW-uEXITmZtncub@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, zhangkun09@huawei.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkarsten@uwaterloo.ca
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925075707.3970187-2-linyunsheng@huawei.com>

On Wed, Sep 25, 2024 at 03:57:06PM +0800, Yunsheng Lin wrote:
> page_pool page may be freed from skb_defer_free_flush() to
> softirq context, it may cause concurrent access problem for
> pool->alloc cache due to the below time window, as below,
> both CPU0 and CPU1 may access the pool->alloc cache
> concurrently in page_pool_empty_alloc_cache_once() and
> page_pool_recycle_in_cache():
> 
>           CPU 0                           CPU1
>     page_pool_destroy()          skb_defer_free_flush()
>            .                               .
>            .                   page_pool_put_unrefed_page()
>            .                               .
>            .               allow_direct = page_pool_napi_local()
>            .                               .
> page_pool_disable_direct_recycling()       .
>            .                               .
> page_pool_empty_alloc_cache_once() page_pool_recycle_in_cache()
> 
> Use rcu mechanism to avoid the above concurrent access problem.
> 
> Note, the above was found during code reviewing on how to fix
> the problem in [1].
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>

Sorry for the noise, but I hit an assert in page_pool_unref_netmem
and I am trying to figure out if it is related to what you all are
debugging? I thought it might be, but if not, my apologies.

Just in case it is, I've put the backtrace on github [1]. I
triggered this while testing an RFC [2] I've been working on. Please
note, the RFC posted publicly does not currently apply cleanly to
net-next and has some bugs I've fixed in my v4. I had planned to
send the v4 early next week and mention the page pool issue I am
hitting.

After triggering the assert in [1], I tried applying the patches of
this series and retesting the RFC v4 I have queued locally. When I
did that, I hit a new assertion page_pool_destroy [3].

There are a few possibilities:
   1. I am hitting the same issue you are hitting
   2. I am hitting a different issue caused by a bug I introduced
   3. I am hitting a different page pool issue entirely

In case of 2 and 3, my apologies for the noise.

In case of 1: If you think I am hitting the same issue as you are
trying to solve, I can reliably reproduce this with my RFC v4 and
would be happy to test any patches meant to fix the issue.

[1]: https://gist.githubusercontent.com/jdamato-fsly/eb628c8bf4e4d1c8158441644cdb7e52/raw/96dcf422303d9e64b5060f2fb0f1d71e04ab048e/warning1.txt
[2]: https://lore.kernel.org/all/20240912100738.16567-1-jdamato@fastly.com/#r
[3]: https://gist.githubusercontent.com/jdamato-fsly/eb628c8bf4e4d1c8158441644cdb7e52/raw/96dcf422303d9e64b5060f2fb0f1d71e04ab048e/warning2.txt

