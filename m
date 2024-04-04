Return-Path: <netdev+bounces-84977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB15898D90
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E3A28A428
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC112F387;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UrUQk3hp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A0CA62
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253439; cv=none; b=Nc3IGyDYWqsatn+vts+gViHlWl6tmBvdbI+/nBOxQGOHEHIb2nwhfhIsDb86U+7AqjpOpWLtAsIjAIbl794vkEQbuMuDkR5U7B8i35cZxtOIpYPljc0y+2N2Wv6mwPVD5RtzrfpqeUjjeX6mpsL5djf25G8/ZgyI+wgGZAZ9jOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253439; c=relaxed/simple;
	bh=lUzwLyPQyWgkAhs2myAXy9TyzSHpUQLHUBGYXlPsuxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOgnr2Szv0/EMVN+3KRt/FaJxgtD1zfGhZf7YduqUshTqU+nNFgJdrviow4DdQ0EncP15fIoFRrgimkAMVa6Uiy6JGXsx6w/hqDbpefHHvdRcQe5THDhmjqw0AAobI0KmtiQ5vbXEOqmPniRp6Pg8G3bWxoFQmajSsukHZifQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UrUQk3hp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a550ce1a41so742450eaf.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712253437; x=1712858237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju7ZAzR28wQEBBWMoZM6YMGwGTqBkO770itO6OSbu44=;
        b=UrUQk3hpF678xuolvkksjC9OoS18vBcU1gq9Iq9LIq/BPx08jlAs2kAJfApNpvxCYX
         GduIG6r/Ivy+qmrTWECKJypdyiRNUhmC8EcfsNK6Afcl47pF6NafthQKcUZw6NGR6Dz5
         8TALgyJIObiwgbWTPi4HCcFy7mafDK11mOtFpl02csmnguEHy3t3eOkeKsxIbxb97Kd8
         ELpNAgnSZ+wV8G5knZrsPclODTV+I2o3RKcDY5068/YtJ/YLyBUUFM1YczewQfTGB+1t
         TqJbEPzC1XFmVo7zSF8RqfOXOGiIlSWJa/yUCL5xztP+rfbyWz2q/uqL4m6tsvlPhFbZ
         aXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253437; x=1712858237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju7ZAzR28wQEBBWMoZM6YMGwGTqBkO770itO6OSbu44=;
        b=lWipvBqlrRgbr3P4RnXUj5ffv2NfY6PGYrAb2L2lu+TvrJPUDcOkdu/CWXgHZ+LarA
         peh/m9juYmisCrSpgvt5a8pGEtRAQCHvOoiUq3olBCEuUPCyZemAlymgKbl81SXHeInq
         GHhs8eLBkH4rhHzhPIioEjwsbzf0k9Cykm818lwd6XaH4MRYboKB8s64wDqE46T1n5Z1
         oHMDU+CceUEIY5IrrYTLmbcRoWNk7Y9KTHJCqy2oaljgnCzpqqN0A9j8oPEzYzhbIw5C
         z2JVAy1BcMIXw8KSBee+cTcwNnrg5uQmuGj4kRg0liQlTZN8lC+DFSyJ/31iWc8Xrccz
         b95g==
X-Gm-Message-State: AOJu0YxeHCBM/fE1LmM6qfOAf27xOm0rXr+/vDjx/MJxPTiJxzuydVVi
	0HIPPejmACugmzXq7+IKH0ZyPqHQJlId6VvynbqTmdo4HmPwtjAfigUi2VMGz8c=
X-Google-Smtp-Source: AGHT+IGwzbGXErs+yRHKfSVECh1dtFSB/rzRRV2LvmVtQNdXoBiV3dRw1TLfnQFHfe3d1BkVjoErIw==
X-Received: by 2002:a05:6358:1206:b0:183:e72e:ce04 with SMTP id h6-20020a056358120600b00183e72ece04mr3074902rwi.16.1712253437474;
        Thu, 04 Apr 2024 10:57:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:7e1f])
        by smtp.gmail.com with ESMTPSA id s22-20020a656916000000b005bd980cca56sm12199250pgq.29.2024.04.04.10.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:57:17 -0700 (PDT)
Message-ID: <8ce74a4c-f20d-410d-ab15-818ea9205ef8@davidwei.uk>
Date: Thu, 4 Apr 2024 10:57:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dqs: use sysfs_emit() in favor of sprintf()
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Breno Leitao <leitao@debian.org>
References: <20240404164604.3055832-1-edumazet@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240404164604.3055832-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-04 09:46, Eric Dumazet wrote:
> Commit 6025b9135f7a ("net: dqs: add NIC stall detector based on BQL")
> added three sysfs files.
> 
> Use the recommended sysfs_emit() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> ---
>  net/core/net-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index e3d7a8cfa20b7d1052f2b6c54b7a9810c55f91fc..ff3ee45be64a6a91d1abdcac5cd04b4bdd03e39c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1419,7 +1419,7 @@ static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
>  {
>  	struct dql *dql = &queue->dql;
>  
> -	return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
> +	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
>  }
>  
>  static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
> @@ -1451,7 +1451,7 @@ static struct netdev_queue_attribute bql_stall_thrs_attribute __ro_after_init =
>  
>  static ssize_t bql_show_stall_max(struct netdev_queue *queue, char *buf)
>  {
> -	return sprintf(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
> +	return sysfs_emit(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
>  }
>  
>  static ssize_t bql_set_stall_max(struct netdev_queue *queue,
> @@ -1468,7 +1468,7 @@ static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
>  {
>  	struct dql *dql = &queue->dql;
>  
> -	return sprintf(buf, "%lu\n", dql->stall_cnt);
> +	return sysfs_emit(buf, "%lu\n", dql->stall_cnt);
>  }
>  
>  static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =

Checked that the above are the only 3 instances of sprintf() in
net-sysfs.c. Rest of the file uses sysfs_emit() which has the same args
as sprintf().

Interestingly the docs for sysfs_emit() claims it is an scnprintf()
equivalent, but has no size_t size param. So it's more like a sprintf()
equivalent.

