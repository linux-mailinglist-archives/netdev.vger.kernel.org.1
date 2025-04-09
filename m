Return-Path: <netdev+bounces-180694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425FA82261
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF637B77B9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9F25D8F2;
	Wed,  9 Apr 2025 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEynIQql"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28E25522B
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194979; cv=none; b=bLdiZPWRRZLjOZVec8VRYVlCxkhEopICW13VPJDCGDN6Vtl2zmLP77ayN/MEUBQQIorei4kajlmc6oN94MOGIqe1WM88QvpdnUkQ18mtWsxkgDZSGzhaQ1aw16PKtwtUuPrIztaV82B+kU7G6dUCqfiAd0k2aSB69pE6CzuXuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194979; c=relaxed/simple;
	bh=i4ww+FDuhBq9K89tHk8yHaDJA0LXhNvp9fAushoG6jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=efAVh+kLBiFwEu9AIixeG5WHUD/o9oTlf/4wRD6AHYra2P2C9butnMjd2btPPmDdDWtushjmiS9ylByGbLLbdFN+znCGWDv5Kds0UQfOkDtA/iphFLeKuNiXVhR08PX629MQOGte0sJhlLM+EsGDWJVDqg/D2zLiat/WmllLa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEynIQql; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5kKiovjW0ZhkYwq0PKT65H3P9L8h+uzV491ftb4psU=;
	b=dEynIQql6sA9ab6nLmZxi7ERSqLbCiMSlmcODiFU0ZvJ7ZrikmTt1edzIX01Fo8c24G5GB
	7nGeOVaQMb8hwlMjpzkkWPFLZXB8Al5PNsQ++xjYyeWC1EkED3hfxCPFHSWeo8dYSPA0AC
	q5nf32BW67JWarMoZtXV87hKJOhqYkQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-06S_5rkPPvierQeG_DTbgA-1; Wed, 09 Apr 2025 06:36:15 -0400
X-MC-Unique: 06S_5rkPPvierQeG_DTbgA-1
X-Mimecast-MFC-AGG-ID: 06S_5rkPPvierQeG_DTbgA_1744194974
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac6ef2d1b7dso550528666b.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 03:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194974; x=1744799774;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5kKiovjW0ZhkYwq0PKT65H3P9L8h+uzV491ftb4psU=;
        b=PkdMuMLC3jR4QncUaCbh47dHMqPm/ahZ3lFRcu4Nm7G6zBIfRJuugrjkknFcAbKk6r
         7ktpo6Pg7x778V/9VSHkswNDhiHArOXnSKn/gjKkMrLcBCFvi2Q9Efsc58ZZO/BDpN9I
         t1JlQjuvPJPKmdqIhPVPefM1zn0MHPRxDv/HehsaR/ZP0fYxrGWwl7d4lddkdbIgdUOu
         vW9PblLIv1BfClzcpqDekrpRuL0ugOiBWP1hFqL8C/WmTRbmZOvxM4MMbN8ZjRhl4deg
         Tl7ZSjfvJt94x6ETMETlrRDruF0OgoyYabyQiXA78P0a1Ukc4H1hR8XYokatNi4TyHpH
         R7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXtS6FVbY8xdDcTFRg/8tQIrCFlqU6rKwDnPllhCvmgzjwcXxyqvQGcn2YYNgjCLat9hdaPmbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cUcw+2lAq6sdnX0G8c0KrnACqK5PQ/Hoaku/4HgwQxPn87p8
	cKQnNTeLubAo6ksCRQPUrxFEdyaTWviFGr3VgB7i9dEhtF655Gy+/VrkuhzHCo4edWKKf83MTzF
	WatC0kJCfJnrlo2nAYDCZo/k9IBkOFV6oAgtS0a892c53CMyzsNlWqw==
X-Gm-Gg: ASbGncvoJY8h3o9RF6DvZK53rdGVAJdqBkCbuHpavou3YPv6g8N5SN98x30lPFLPMqS
	ViZhObNDmStziBLINy9zXMEL67o3y2rQRMvzpaoeTIkAlJlGCCHZXDSKWxtv1+LBZ+kglP2w24/
	HSU25cNIcXd/rSGq1Et3tXgdA1uu8DcTswQazZrxktBFo7yNQlUgs8Ns+htdWkIxd87CPJFPfuk
	iuubiwGs58SfNslb4/bkQs3/iE5yC/w/hG3HbYHBYP/uyY3Gy69Fh7bkW09rEyjl/AaN6GyEDlv
	b0Q8zCvS
X-Received: by 2002:a17:907:7ea6:b0:ac2:dfcf:3e09 with SMTP id a640c23a62f3a-aca9b719b0cmr234858866b.43.1744194974077;
        Wed, 09 Apr 2025 03:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQCZRAFJMcL3NkxF41e8trgIRpTjzQOtQoBDKD5Ijj+qm+kAuHuUYYu1XdMXJhDmFnpSmJJA==
X-Received: by 2002:a17:907:7ea6:b0:ac2:dfcf:3e09 with SMTP id a640c23a62f3a-aca9b719b0cmr234857166b.43.1744194973699;
        Wed, 09 Apr 2025 03:36:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb43b6sm74653666b.93.2025.04.09.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:36:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCF4B19920AD; Wed, 09 Apr 2025 12:36:11 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v8 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <20250408121352.6a2349a9@kernel.org>
References: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
 <20250407-page-pool-track-dma-v8-1-da9500d4ba21@redhat.com>
 <20250408121352.6a2349a9@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 09 Apr 2025 12:36:11 +0200
Message-ID: <87o6x5vcys.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 07 Apr 2025 18:53:28 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b7f13f087954bdccfe1e263d39a59bfd1d738ab6..6f9ef1634f75701ae0be146a=
dd1ea2c11beb6e48 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4248,4 +4248,25 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long=20
>
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>> +
>
> extra empty line here
>
>>  #endif /* _LINUX_MM_H */
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types=
.h
>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..31e6c5c6724b1cffbf5ad253=
5b3eaee5dec54d9d 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -264,6 +264,7 @@ void page_pool_destroy(struct page_pool *pool);
>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(v=
oid *),
>>  			   const struct xdp_mem_info *mem);
>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>> +
>
> and here

Ugh, got sloppy when moving things around; sorry about that. Will
respin.

-Toke


