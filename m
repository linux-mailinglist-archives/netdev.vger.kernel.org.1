Return-Path: <netdev+bounces-174166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B016CA5DAF2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9ED3AF9B1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA223E344;
	Wed, 12 Mar 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKSQeX5W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEE23E329
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776991; cv=none; b=pmL039/tdO/TRhqy4UR2uDKY4AphyyEkF1qvvdjrCUbS15kzIe3+t0gevaCPBlaA1+OguDFdNerXJPpE4dIOgkRaHLnL7hN7JL2MFhBjv4pIN3lQf7X89QtUpoK4c/sPHoCZxNKuGlBUqDOit1HkfO/Gy/weyVNVFYyPPlUfVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776991; c=relaxed/simple;
	bh=2TZCJ9Xit1snwjJWhquYHBokd6M2Tv6b1pP86YG0/gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KlFLOKMjvlWHdLAO+MAOVbX3qInDnupbi4AvigPfeOOTDU+NyI0V+SxS5Gpr06yHp7UWnrWcSr3AuTQpAFn14y9tMcwv6t2AY/RDwCYMMiPF0rkftvqUK+wjICo7AZwASHVjayC93O4aFcoMrCCqRgeyfwZf0XFv8NhUkrgsCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKSQeX5W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741776989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAd/cXwxyMqiVkUiEpD8dE0WurSRe0l5Rsk+mCjPI0Q=;
	b=HKSQeX5W6sPXx8eSV4h/HtWeGAI7uJYCtyYHYfdWwWLCaXU+Kufhf83u1GtrGxuZiTO7ld
	gGOf4KHeCbHKJCzQQpDascFglZnc3fSLzUQ/gH1H+wOXcgnsI8IgVK9T8dPJ7ZDdZEAmRP
	vzvbJuc+oiksKFmhnVlZOvAZM1I4CvI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-9D6eDUXdPeKWprhU3fkr1Q-1; Wed, 12 Mar 2025 06:56:27 -0400
X-MC-Unique: 9D6eDUXdPeKWprhU3fkr1Q-1
X-Mimecast-MFC-AGG-ID: 9D6eDUXdPeKWprhU3fkr1Q_1741776986
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2815aba51so251112866b.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 03:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776986; x=1742381786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAd/cXwxyMqiVkUiEpD8dE0WurSRe0l5Rsk+mCjPI0Q=;
        b=lrQLMKa+xXIAEg4C5EG/QqycA793tAeJYj5DccqCrpthAinTDshGTMZgOBbS3Sw+os
         J4wgjVQRwsXiJH5F8BXFnDqLaOvfkuOk1FJItIWTaQ+qj4nohEvb9W91NFD4lk/+AReg
         UicHQQN43SEu9FvUrbwjoZUmPd4VRoMq49HFltYUzJj2k/63qt8kuVxHKxl/9khSX6cf
         Y2bXMseaDuInbJCPXu9eZN5gj3ElTOPcgiijoP4ccoKQjvBaujm63CE36+5gC/qpl0cp
         Ssv2hlj+y9z9Gq1U3BL6qYfQMbESTi84F/NtPYYaukBpiT90aRTI8nJLUEC1G6KIbfus
         ePRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHK+4CsnasTtYjublKCY44w4/0I8d8DL9ggfcs703IWDosuWgDUNDhZdVzej79pvb1XdJgQEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehhbCDeQXM2kqnQ6LbDMAjNX3gmJ0xKaGzMgc6F1VWUfo+rx1
	roMipGcxAvpzGePZ+L4o8zAgWBkAk1UPfuZpzeFV4mTBjOyEQklo+IPxjzBzf1d0vKhe3Z2362B
	PwZDLN1zRgKx1mqMohjTg+8o8GOB2Ep6abZbhnxj0etXWIg6QervtKw==
X-Gm-Gg: ASbGnctWz5115Uu2iXxMCi+hyDFGN3lkfh9lAwRkYcp+IteQ+XIpdHUJBCfn3Ei+wJR
	t45P1IhrxbT27CAacS7ZKrhUAdjAD8VqJtyyxaeEUFiU1alb38gCiaSlL3Ljg20FmFIIDVOjBQM
	WG8Bpcx9q7LOB6GRiiBtMPrmml8MgBhaEtPmfHXWu6WaXvU1qGUG3ZeUJK+JIBZetFm/SS16YLW
	0v5XEuQMTSWb7iMN6lqifJV1KXM9dyUTD0hLZDgxuHhWYhy9ZKJlLrY6uUgd4A+8nF29FXJ6s5d
	I5YFyezMTN7Y9I3Y9kZThqfjlbEmq+zw8eEBwWxG
X-Received: by 2002:a17:907:1ca3:b0:ac1:e332:b1fa with SMTP id a640c23a62f3a-ac2521168e0mr480182866b.0.1741776986032;
        Wed, 12 Mar 2025 03:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkURnWqYhQF9JaoiY4FtLIYu0hPXaMvQ0+ocRFrJgSMDvulCIhtwKVjhVg56mUDCeYDD0RgQ==
X-Received: by 2002:a17:907:1ca3:b0:ac1:e332:b1fa with SMTP id a640c23a62f3a-ac2521168e0mr480179766b.0.1741776985657;
        Wed, 12 Mar 2025 03:56:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm613942666b.132.2025.03.12.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:56:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3BF7D18FA670; Wed, 12 Mar 2025 11:56:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry
 <almasrymina@google.com>, David Wei <dw@davidwei.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <Z9Bo9osGdjTWct98@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk> <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
 <87tt7ziswg.fsf@toke.dk> <Z9Bo9osGdjTWct98@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Mar 2025 11:56:22 +0100
Message-ID: <877c4uikkp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Mar 11, 2025 at 02:44:15PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Pavel Begunkov <asml.silence@gmail.com> writes:
>> > If we're out of space in the page, why can't we use struct page *
>> > as indices into the xarray? Ala
>> >
>> > struct page *p =3D ...;
>> > xa_store(xarray, index=3D(unsigned long)p, p);
>> >
>> > Indices wouldn't be nicely packed, but it's still a map. Is there
>> > a problem with that I didn't consider?
>>=20
>> Huh. As I just replied to Yunsheng, I was under the impression that this
>> was not supported. But since you're now the second person to suggest
>> this, I looked again, and it looks like I was wrong. There does indeed
>> seem to be other places in the kernel that does this.
>>=20
>> As you say the indices won't be as densely packed, though. So I'm
>> wondering if using the bits in pp_magic would be better in any case to
>> get the better packing? I guess we can try benchmarking both approaches
>> and see if there's a measurable difference.
>
> This is an absolutely terrible idea, only proposed by those who have no
> understanding of how the XArray works.  It could not be more wasteful.

Alright, ACK, will stay with the xa_alloc() + stashing the id in
pp_magic (unless you come back and tell us there's some reason we can't
use those bits).

Do you mind if I send a patch to the xarray docs to explicitly spell out
that using pointers as keys is a bad idea? It's a bit implicit the way
it's phrased now, IMO.

-Toke


