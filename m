Return-Path: <netdev+bounces-178822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2BA790BE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4473616339D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2572397BE;
	Wed,  2 Apr 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+eY+Qqy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8091F0E2C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603048; cv=none; b=WdQFvUiQxkrt3S8pqh9ubC26T5fNQEoUPG/iDQaRXQDvKVpjqPILfLfx4btv+0jRfQQC597clcJr39wv6R4qjMTC6PvymiCyyHhYIW4vCAJnj48U2opG2a+8FKT7JH8TaiifLI+3snBRxHQrzIE0VLwNCuC080zMRCGzIoyzuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603048; c=relaxed/simple;
	bh=4sVBulip3fTqdwge65Je6X4en2Uqs3ted+bv/OrEtiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7NKatRHCnCAOXJKUvKA0c5q8NnT64nH3/yzF5Y8zsBGF5X0F2U0fQP71xaT4wgZ1Fjs/FEYyVt3Z8VvIBEkQMFzHvewSolKQiQQaoB37ZzrH0XyD1aVyJ6PY3NWYCsMLquKXFIse+DK07u563/QK+LZOXy8ihh+lAdzmxL1YQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+eY+Qqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743603045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
	b=i+eY+QqyogIx1TvZC3VPXUggnb5YPlARE0By8id4xpZDjCuY61XzQ2mf3wsVVzNnZTEpe8
	Pa2woN//KSIwTN1ZwA7VibToxbMGAST3AUK4tw5rTuuMFjW+TQTo8BPIORUsXSWrVhfwCr
	x5loVcN5g9kcv0nglTiKRIZasrmqQdI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-7EYZVf-0PM64fPflICCxsQ-1; Wed, 02 Apr 2025 10:10:43 -0400
X-MC-Unique: 7EYZVf-0PM64fPflICCxsQ-1
X-Mimecast-MFC-AGG-ID: 7EYZVf-0PM64fPflICCxsQ_1743603042
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5498d2a8b88so3640583e87.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603041; x=1744207841;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
        b=MOu1YAAb3lIz+6yeipb8vGuWRfa8EDn65QoUn39p2tdmxlSZjMYzjP5U4MHbhGeiWa
         3c4B4b5w8TrJE8ZA8ki7C1Mez9TCNqb55gUfD3JEGausqpx3BVA8RYq4CCFN1VNVg0qP
         HUhsM4wcnxjGUvXEBAs6z+DVa4OxkiCpJyZYPyKQP2sT4sLsfbB1Q2wrIXfrXh/KurJC
         mU8OZKrvSioFEP7RjxtvNqSkzFLCnnsbigbjne87pQX2x6D+Y9womsD0tAmU7jNrz8vu
         adE6DXQgiWPe8eO2JXV5PxRggaMHGxbgivazzZ/ua3Ji+Gb90Li4YotK62ltSoGd9t0M
         sytg==
X-Gm-Message-State: AOJu0YyIzZlJzIvtLL8Fsaj2ju5cEVT7Qs8Cb8I8Fq3sNJhjxoB5XR6V
	gEqQshr1Hl59IdS8/P2jSaPyjVm86KpeKCHYHftrw58gGsFuevWSA+2IUeo8BzXKwW0Y2+9wdkA
	i/cbfGrvIn3nu+jdkzsMylkmng1g+MQ0NrokAlyT3cf/Q4pmf7zwH3g==
X-Gm-Gg: ASbGncvqsxOiu+b/ZoTjnvY6/N5btxms186+KrXTSNJeItgBLPJp8YzGQIhqUSeao2f
	nynOI5XF7/cqquT77K2bqcuOBbpWbQWWIySw0h6Qge4q3m2OuHHlbMKNZfVYf51tBirqTvC95ZG
	z9n/jiC4qMzV7np8nZ8aFkQvxyZb4q9L0tm2VCJ4n9P13vTUGTGt/ZYT90WuiY8oZzBqRu98Qd9
	oE3qbYdEWUXGCJ1dQhbg/mXwObaFx8iYs8IRGA+7rN4U5IwKPDwzKbaFJjorCAWcAYn17uKdFoE
	sp2DBq8hOnf9
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823787e87.43.1743603041557;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMxC2U1r1cpFgYr/EJLzybppo1QongF+LooghSXPmyLtE3Ffn5xOTN3LHvx9mbOxE4Ua83cw==
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823766e87.43.1743603041173;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0e703fa4sm1433452e87.169.2025.04.02.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:10:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8BCB118FD3EA; Wed, 02 Apr 2025 16:10:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com> <87jz82n7j3.fsf@toke.dk>
 <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Apr 2025 16:10:39 +0200
Message-ID: <87ecyamz6o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Begunkov <asml.silence@gmail.com> writes:

>>>> +	if (err) {
>>>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>>>
>>> That can happen with enough memory pressure, I don't think
>>> it should be a warning. Maybe some pr_info?
>> 
>> So my reasoning here was that this code is only called in the alloc
>> path, so if we're under memory pressure, the page allocation itself
>> should fail before the xarray alloc does. And if it doesn't (i.e., if
>> the use of xarray itself causes allocation failures), we really want to
>> know about it so we can change things. Hence the loud warning.
>
> There is a gap between allocations, one doesn't guarantee
> another. I'd say the mental test here is whether we can reasonably
> cause it from user space (including by abusive users), because crash
> on warning setups exist, and it'll let you know about itself too
> loudly, when it could've been tolerated just fine. Not going to
> insist though.

Right, I do see what you mean - it's not guaranteed to be coupled.
However, my feeling is nonetheless that it's better for this to be loud
to weed out any new issues that may arise from this, so I'm inclined to
keep it as-is.

-Toke


