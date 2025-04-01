Return-Path: <netdev+bounces-178522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74AA776EF
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBA07A34E5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C211EB5F8;
	Tue,  1 Apr 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUojYi8Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BC1EB5F0
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497545; cv=none; b=Xxk4Qomu2VNa1+7HOKdS7I/30hsB4wXIGAZXZ/fASd2lOK7S9YZ3NR+Wu7HdPln/k5kCx4//rDCUYObs8C7P6WI8XHl2kKuHlBNmI6sOL2cqRH65atn9w61+N/RWCtniC5JSou9zO8Kkwpz50xxjsJmUSY1BC7rG9eJixwKykXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497545; c=relaxed/simple;
	bh=fNkQvYlNaa3cqbrVMNrNNj9EdtzcFO71fUGvPTgiinQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG3hBZeNbH9sx/i6fs2CiE5h8zg1wJQhcZF3ATuecnTcxy8oj5YfxFabWMDAxZgCoawg62av/l1a309WxPb1sPCd6QkrrZ2PQ0pQLOdgzAfy05r5l3eA0JGAh014Qjd9BqMBE1DHnATFvooB6Yv0qfywEMgnSkzgbckSQV+Xbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUojYi8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
	b=YUojYi8ZAMeXoo/HxJ0x0B/DNZk3CljCNCrB/uYtvSkTGDMptoyt/IAVmTS1K3kecys3JU
	akTUhE9MxJdzeznuoxLNwPpQowFoKlkOZ7LZSqBUmA/uL0GnSPqQDI9nfJODc1w8RoiMHH
	AqL1zoGvoiK5VXNNnjhA4xECPLUVH40=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-AG5roXmJPBSX-7vL_XraNg-1; Tue, 01 Apr 2025 04:52:21 -0400
X-MC-Unique: AG5roXmJPBSX-7vL_XraNg-1
X-Mimecast-MFC-AGG-ID: AG5roXmJPBSX-7vL_XraNg_1743497540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so37412135e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497540; x=1744102340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
        b=LWa3kdhxz5qZ5PRlXaKZ/k1VJkuaayTPxm8RVBtRSqIO5aoWZXIjIB7ICMSu2Cfy6M
         TRWrZbLxTwTcvec9xpjFZY39GO1ehuDn//5IObAhPwVckFrx0UEqbgIZbQSFp/CBwGeR
         v+CUBtOuL3kpdmDEPIURLIqq07GDmS7V68DZDgTDOfEAyPYBwoIz5uvLEyRR6lhk9n/1
         l+4Ipv/4iKTZ36eBFn7SXKJ8nNjghM3FCdgWlAXrmZKbhicEKGfwyJLSgEe3O6kqTmt1
         xx9WzjZs5iNqUYwf8ro0v+YbwN3zsdqku4Skf/q75LKJkJ9aBuxQDuqrkgjdI8CWHSQF
         7T7g==
X-Gm-Message-State: AOJu0Yx3WWBgf6Lq1FkKtgcorI1Rfav4K7U//gZgkQbtf9J6FGmUkT9+
	x6olUOgjTw6PoX8K18oVFDjaoXstAT8yIvHJTWDgrIQzHINEWhU1Cw/U5dsUhHOalfep3R47I9E
	8E4B0uYkzIq///ViEH8JzbmEg9XWMl5nT4wAeKNY3B/LQq47Xxfj/JA==
X-Gm-Gg: ASbGnctzK6T4vAzGwdVJbDB9oQb76/CTs/rWCelUhifOhh1myQ8StcbAdi4P3fKxqHp
	p9QoNY/3hJnN04p/xzgaJl8e2/NDSdZxKCWvh0bxOX3M2ZTGLesMoYhcHlUXvMKEdAsEteDA0pO
	NGA6KChYCV6TKK0eUqmN5Eu8QcBA7RZT2oaqokpegrID5vVuJK77Y+zWah9Y5E+Z+OnlUTiqBHa
	FTCO/skZLwsABlwpATfMVZDrpJVNA33dcv+uRX1KOSBY0lBOna1GIbY1HfG5dMxXuAVq7Tu6b8m
	oewdnMziFgNeD1d7PX5SBpepKPuEABuZLFcrwCcclyLxdg==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036376f8f.20.1743497539713;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFIwIsFXgnFgUnvUf7GiB0Qo92O2pFQl8WkobeyI6QhVmQ5/bHplaSDVAbQLHpuaV2qU/iLQ==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036337f8f.20.1743497539288;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4351sm13751264f8f.98.2025.04.01.01.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:52:18 -0700 (PDT)
Message-ID: <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
Date: Tue, 1 Apr 2025 10:52:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/28/25 1:19 PM, Toke Høiland-Jørgensen wrote:
> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {

Lacking a READ_ONCE() here, I think it's within compiler's right do some
unexpected optimization between this read and the next one. Also it will
make the double read more explicit.

Thanks,

Paolo


