Return-Path: <netdev+bounces-173432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC70A58C99
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0EB16A2B2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C311CAA6F;
	Mon, 10 Mar 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW53oeos"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965261A841C
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590971; cv=none; b=Y4hHfCRfIbPXPX0n9g+JX+X9LxV9d1Dp8OchVh9/524rSFLw+DZI9P8JVeipv+GOzDTfzpxcykvD9RuARXwnVEv0a9DldhfkMRliWq4+DyCutqpb6eq4EMDsTLl2ULtbjilOhnInrz1aqcub5feqhyzHA/59dBqW40TN2cKgEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590971; c=relaxed/simple;
	bh=csuBSn5lVl8f70Mnaij/6ynbz5qy9pIz5GQEE0jSiyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bc872qg0ds9WPLPmNsWEsXoegTQrCYiX+JmXVwpZuTYMntTuF6p+kfY3UwaPfXWoTEeE++k2h/CmrHoMBmqbWbuhtaFuEiutFlqkkLQo4eoaNbxpDtcjehFRnRFHbdT/gQ32zZmuce/1RT8HFkEoCfHpIfXSHQYOOXR1hKgwyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW53oeos; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so679007366b.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741590968; x=1742195768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwgVTEUn37oZNIQEypFt+W7Qy+BNbRvPshfrc1JXbF8=;
        b=OW53oeos1dtuXqgtQLxuqR8qFZ/NXBLxwQZwl3M1bqmU2EtEyL4c80DyjJfOnB+7v9
         qTlS3tG8d8c0eLclR2u4JHI6KBPpRfqlHmJYXVn4NcHvb6rLGVd1IxFU4aeTmg5R/PQL
         g/NNCzcgJ+f9VCzihLvFYSncL0R0maJ5brUAQazWX2pQlMQfzmen94+Lpom75HBw3cEv
         wxZhRi8q3SqX4T1HB8W4BpcPi13MRYJsSuEMSRCdlX5KkgOefDQ0NPk18FyPsEreV0Es
         CDVJ9Cbls2DqgO275vMi1bg/ICXutZ2ssUuHSod9fy8q36bQVx4OieiUxVxJvGTzHext
         lb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590968; x=1742195768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwgVTEUn37oZNIQEypFt+W7Qy+BNbRvPshfrc1JXbF8=;
        b=QfzKzGDADSPazYNeSbvFO9O3tyivdi+a2yk/zYwhrEH/YS3T7veLa7k8x1MgUCW3EL
         WTDYYUNxmxho6Rtok3vG3ATVgHDWh1C6sitfZX0JFiHp10DiItbcSChowsMYswW/8rBq
         1VzUJvlY1gri7/oA91lEWAiHL7Eqm7fivvb13oHZ+xD+vayAfoTW7z3Iv4mxLX+dMQYQ
         qs0oGxeFGfb7HNE1iRnnutcGlKkl7b+FrSBu4lsaghU+RlOJS8qL5Ja6rOtT5Db/fZRv
         l2YL9pXVLaCnkh3UAKxyd6ZAJXlOY30W95OxndAIYgOZYV1xGEDbZ+97PeipUS6FomV5
         XXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzQuTnEijBsJvvQ5HKnlBhYBIEVK4BAg1DCNKtFXZigSyJnvvoHbSN4GfoVPYGwAECMdEqecw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xZhX61hHc+60rufcvYve5DLIdOlmSVQEUpHomwJSySxpOnPg
	yYXwnzYN3xXT1t6K9+rjav80p2qkO7OztDt+LaPQa7rhS3hhU4Ez
X-Gm-Gg: ASbGncu1lf/t6ffq4IWw5h695KIzrQMVDcL/qu0S3mogPXih/yaOknRNiH7AUEeZLlk
	/l74c1Rpio6BmOhNFx52F4sHxMleLareNKulTh59kuPeK1frGuT+bt28yMEMWyGB3hcwm2w18Od
	xQ4BmnipRMpV3BWHHmYjapwNPT/6OdTy6yQ+0nFQM95wbSEK+OvcMCr/6l/vgxwM6/vfOnHAELq
	H55kW3yW3JuHmCgXatfDbP8EGV5nINrePWw68ShP8gOQ3B1wa11XVnPHHZTt4hCdgMyz1mdSt6A
	pTdR9XmMwE//7P1qC1QmYThwD1oD/ergaSDylfgjuEO1gxdf5sjUcDT9TQ==
X-Google-Smtp-Source: AGHT+IFtQ9pvUKWQLLgKrRGjITDEfqwtZspmeMaNuf381jRmybbOqXpgP4KxMT6jEMOSHh+Nh4Qmew==
X-Received: by 2002:a17:907:9452:b0:ab6:362b:a83a with SMTP id a640c23a62f3a-ac25274acf4mr1229295866b.8.1741590967593;
        Mon, 10 Mar 2025 00:16:07 -0700 (PDT)
Received: from [192.168.116.141] ([148.252.129.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fca8sm6329698a12.4.2025.03.10.00.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:16:06 -0700 (PDT)
Message-ID: <765c84e0-1e4d-4e34-aa46-30a385ca8050@gmail.com>
Date: Mon, 10 Mar 2025 07:17:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Mina Almasry <almasrymina@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/8/25 19:22, Mina Almasry wrote:
> On Sat, Mar 8, 2025 at 6:55 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes problems when a device is
>> torn down, because the page pool can't unmap the pages until they are
>> returned to the pool. This causes resource leaks and/or crashes when
>> there are pages still outstanding while the device is torn down, because
>> page_pool will attempt an unmap of a non-existent DMA device on the
>> subsequent page return.
>>
>> To fix this, implement a simple tracking of outstanding dma-mapped pages
>> in page pool using an xarray. This was first suggested by Mina[0], and
>> turns out to be fairly straight forward: We simply store pointers to
>> pages directly in the xarray with xa_alloc() when they are first DMA
>> mapped, and remove them from the array on unmap. Then, when a page pool
>> is torn down, it can simply walk the xarray and unmap all pages still
>> present there before returning, which also allows us to get rid of the
>> get/put_device() calls in page_pool.
> 
>> Using xa_cmpxchg(), no additional
>> synchronisation is needed, as a page will only ever be unmapped once.
>>
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, in the field previously called '_pp_mapping_pad' in
>> the page_pool struct inside struct page. This field overlaps with the
>> page->mapping pointer, which may turn out to be problematic, so an
>> alternative is probably needed. Sticking the ID into some of the upper
>> bits of page->pp_magic may work as an alternative, but that requires
>> further investigation. Using the 'mapping' field works well enough as
>> a demonstration for this RFC, though.
>>
>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. The extra memory needed to track the pages is
>> neatly encapsulated inside xarray, which uses the 'struct xa_node'
>> structure to track items. This structure is 576 bytes long, with slots
>> for 64 items, meaning that a full node occurs only 9 bytes of overhead
>> per slot it tracks (in practice, it probably won't be this efficient,
>> but in any case it should be an acceptable overhead).
...
> 
> Pavel, David, as an aside, I think we need to propagate this fix to
> memory providers as a follow up. We probably need a new op in the
> provider to unmap. Then, in page_pool_scrub, where this patch does an
> xa_for_each, we need to call that unmap op.

Sounds like it, which is the easy part since mps already hold the
full list of pages available. We just need to be careful unmapping
all netmems in presense of multiple pools, but that should be fine.

-- 
Pavel Begunkov


