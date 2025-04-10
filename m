Return-Path: <netdev+bounces-181190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DFA84076
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A97C1894ACE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A4280CD2;
	Thu, 10 Apr 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2HEP5S7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5C280CC6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280468; cv=none; b=YYBY73RS3YEXctz8NRTAbHIyiD2byQK+Z+NWPMnY5m91XE7U5NS/VgyPDxB9Xz7y1SJBFlSAUa5R0S2cGP07YRXOFnmeJyY2mSyvpgCcNk2efg0Uxfa94Ovj0fvH2Jr0NV2BiDpVLFlHymH7wyHuXiKgGgK9wvxBsvaJ/r8Angg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280468; c=relaxed/simple;
	bh=92JUKxqvz4DOLXtgZ9JCA4V7OtLOo0pA+kZxODRygU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dUt26/sxOvW2TAqgLGOUnKcmNB6HVSitmxa57dnbUU7RdMOaWQn8tORrmF8EDPdLAimWlrWRordaWdV0sd5H+lporPpw+fcIJsuCUDQzD9UANOZu+mPkjl0Xcmooxt1SWK66YRG4suSyPH/v1OaoMoOIGIfb3BDFllLte1Ysm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2HEP5S7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
	b=X2HEP5S79mRFkizkDG1skujBBxafhGjqJB/7fFaDShefDDRv84NoScd0ynDHT5t3v9dXze
	DvyZBPesdKZBl9EL8NwNQZcZtPMtiqdJrEeeZ2YoXE0VsooKmxSk52/4bVMLXxcdZIKR7H
	bsg3wUW5HKSUZqhP/Xt/DtW6CpCl98A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-6WPgqYB6PGKGOMNFuSacwQ-1; Thu, 10 Apr 2025 06:21:04 -0400
X-MC-Unique: 6WPgqYB6PGKGOMNFuSacwQ-1
X-Mimecast-MFC-AGG-ID: 6WPgqYB6PGKGOMNFuSacwQ_1744280463
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bf4297559so5243041fa.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 03:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280463; x=1744885263;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
        b=AUI5uZ7t/xXBd8SbTBtbGQeT6yRYFulx9IFeqsQ5Jz7NAbZllLTqPGvt52U0bpjhwg
         g9d0SiqOJVM6uwkfmxipy4NjAh89ckjMV4O05I2/sYzfKAIPTyr8X788KwYCyC6Y2GZf
         QTpGB5/RU2HoazxDdwJxQF4yM9P1xX78/AeQusAntdQIG5GgiciFK4y18e+F4jfDWGOz
         fW1j+V4lsxM5jXc5qf1e/Ad4ouzJwJeDDCiazD4sViGlQIf8Pb6sWhhXTFCRG1vZ07xm
         yrny8sQnm7Bam2UJxJ/0nWMsm+c2JIFXOx5NOghyatf+NrjuRMpVn3TnRSsfuwu0kOlX
         0ljQ==
X-Gm-Message-State: AOJu0YysOwD4hltIRHIjOBS4LXXAatkh0GtQcXT44kULFuuPubgjAJ4O
	hzMny1Vh8sZY+Y4Splkgl97VWbcNBR/aU9qLpCm5hfNMYA0f2pipi8jqM1kzVhE9Hz3Vf97VgjT
	7Y1nlu/AWfwO2PejYq6zSaPDMzM4Rkl+DAjzepIS4Tju/0DVjIXjjqA==
X-Gm-Gg: ASbGncvHbiA3nJvsVDMv+0gehS0INktTG+ZNZ/oKI1abD+SvczH9PS0NbuCUltuwihq
	poO7ukHbKKU3DTPUpBBUuzc1zCR/NZHcpgi9vwH/I0bahQH4XICJQINLX9rfc8kD9+dTpUj4qgc
	PznwKFoB9nTi8cKOPtGYRXsObyPVmA6xIIFkXM0sqlY8p/86B5G+de0YN0TQEwXxEa/2x1fgtX7
	jZCCvxM2ec88yoyL6Yf1UNJ73kXSuh9eYo24BGs+4MHSkLAr96huBHCyTckkew5ebjfjmm1nRXJ
	MnCi3jFDQi0bDRLxg3YNSuofuGBNyYb3hoaR
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955621fa.34.1744280462771;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE17WxZoyH3rbLK0N6NfIbsSGtSK/hr9dYY0iDg1GJ6hNCoga/XB9dPSda2f4ZShTnw6cWIwg==
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955491fa.34.1744280462404;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f46623c2bsm4318581fa.111.2025.04.10.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:21:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7F5E21992272; Thu, 10 Apr 2025 12:21:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v9 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
 <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Apr 2025 12:21:00 +0200
Message-ID: <877c3suxkj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Zi Yan" <ziy@nvidia.com> writes:

> On Wed Apr 9, 2025 at 6:41 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Since we are about to stash some more information into the pp_magic
>> field, let's move the magic signature checks into a pair of helper
>> functions so it can be changed in one place.
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>  include/linux/mm.h                               | 20 +++++++++++++++++=
+++
>>  mm/page_alloc.c                                  |  8 ++------
>>  net/core/netmem_priv.h                           |  5 +++++
>>  net/core/skbuff.c                                | 16 ++--------------
>>  net/core/xdp.c                                   |  4 ++--
>>  6 files changed, 33 insertions(+), 24 deletions(-)
>>
>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Great, thanks!

-Toke


