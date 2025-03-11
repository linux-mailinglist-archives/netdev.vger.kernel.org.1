Return-Path: <netdev+bounces-173950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA5A5C799
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7909E16517B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398B25EFB3;
	Tue, 11 Mar 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO6Ax5q5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C014BF89
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707145; cv=none; b=Wr73kqwwdGqq1c2UK4tnRfD3FKSgijDlHSfi71l8J/ZzZ/IjLyVgRJtAGBH5xH4jjS1ri9EB9L8rPzdlgYgZvMPvKlmebgOerM5ZhmjaSbNVkCA0i1NDkX8C34Bm9t+B9HDrAGDmqLNtHVky7vedc7LJEqKa0AWQdVWs+Cs8r/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707145; c=relaxed/simple;
	bh=k7kH6MbEo9C4scZdMfJ062BHuOKuPSFAiMTposDA4hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzbDMEcfAqIgChJz2NtsQ40OJR5u+my4BbyaxhGQfg2+aEaJKazcr5Ud0pJLn0zqJrRH17rNBxhj1UcskYLgD+s3L1HqCZscczy+w2WabpMh0h+Cr1LTuI6NrCvjtQuiC7hDd9vdUY2T3gMaUPh2BdqZs6ARaFSsdOTjxwJPOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO6Ax5q5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741707142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/aeAG4OEnJZfzD22pIVzeanaB0d9wDGvhn3exEQ+LY=;
	b=XO6Ax5q5fepMXD5dHItHzXKOel5V3oAu8+utxRinCG9nByc39GdLUewE92tDjuWNZz/J7T
	KPZj3pLexptSk4owvR8+CXoVYaFy95a832Q8YJlJhWerljOsMmDdcC5D4Gsw17KG6FGqfz
	ddHpm+f8hoEis9uVlRAJestcGSg714s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390--GMMRVsrMX-uIWVRbBpkwQ-1; Tue, 11 Mar 2025 11:32:21 -0400
X-MC-Unique: -GMMRVsrMX-uIWVRbBpkwQ-1
X-Mimecast-MFC-AGG-ID: -GMMRVsrMX-uIWVRbBpkwQ_1741707140
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf93818e3so17268251fa.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707139; x=1742311939;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/aeAG4OEnJZfzD22pIVzeanaB0d9wDGvhn3exEQ+LY=;
        b=MD/MeLMJV4F+74eyfmF+9gqRMUdta/VTiAh7U3xf6gHqPxm9Evp5SE0qzXEUECbyd0
         ElojXf1WwU49p4AJ0LArxfSfgGc/wwAbJp4C2DBgN57z09+Ys2b6zUH1hdS9mc2zWSmb
         qGpuGytAlShWL3Vw1XDMXSrL9v8FYhkg+VIkYS482XK1bqAySphhEs3wGrb6iVr9Q/tk
         XVdodC2RtwhoFhne80gRGj6zXpyyIkoKxE3O1KRpR2fjV/l6UnMlbelrS8YYLvqkWAaz
         hDEqFK8ws3oJTlFDCmOROzmsk4aZtuE/Stprvdba/YhVKaN7y9qWh4SdTdciDdhTSLbu
         Qb8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCbcYB44mD/spGepmY2jFptg8DkLBoaifvtauf6BlryfmRF/o39WQqbFrdD7VdrJZYQWxzDn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyllZxatWuJ/K/d4gnsPP85pq08PlnNetJYVdSXKahgY96pyLOH
	09x5pW0ElP5pmFfWAyQAwYHqOynBmN+rhCqxfmeoqK3K0K4nBfOM8ZIqnKjKWbM7BG2Xf1Gt/Ou
	xPaUk3Ms707LuIVHYknTXN5HQG9D9MIIuxasJWK7fCOKyZ2SoOHJh1DzCu1bBBw==
X-Gm-Gg: ASbGncvBpn0+XLCUiR2LnYbxkwKZKEC2tE3VfvTJU+++NMdwX8iYDXNCzjf3DH0wQR2
	Jq5yqdybfQ3ydZCjBNEFx37OLNzpLFRsHlv1XSliRxLsLqxnPBgvNi5JgkFe+rZ1rjx/oeTMdOv
	KknUn33cDmKD7ukPhLY8+DxA7E7yqMsXJSYZEL3RPoUNPf+lPY+3vdyEoqJjkGr3Fm0M+Ey/t2H
	n45f9PcCk9AtOV6dtbOBrdFUvH+XDyOyhjnSkjvJoNA0SRKNt8/OyRVF+DqWZA3M4INpPgdyQzB
	qKoAqd51R1pSDoCPb9W6iTjs01a35JHsgnk088Jj
X-Received: by 2002:a05:6512:33cb:b0:545:1082:918d with SMTP id 2adb3069b0e04-54990ea9415mr5414972e87.41.1741707139363;
        Tue, 11 Mar 2025 08:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtToLR48XY/sMDb/n0VeIObaGddW28sS6byawDqUxKkYJbllV+n3/4P2p6e6L3IoZTX2EIag==
X-Received: by 2002:a05:6512:33cb:b0:545:1082:918d with SMTP id 2adb3069b0e04-54990ea9415mr5414951e87.41.1741707138956;
        Tue, 11 Mar 2025 08:32:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549b126462csm20694e87.244.2025.03.11.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:32:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1CB5C18FA5DA; Tue, 11 Mar 2025 16:32:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Mina Almasry <almasrymina@google.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <Z9BQvgdAzvTriOj1@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org> <87v7sgkda8.fsf@toke.dk>
 <Z9BQvgdAzvTriOj1@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Mar 2025 16:32:17 +0100
Message-ID: <87ldtbinwe.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Mar 10, 2025 at 06:26:23PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > See https://kernelnewbies.org/MatthewWilcox/Memdescs
>> > and more immediately
>> > https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>> >
>> > pagepool is going to be renamed "bump" because it's a bump allocator a=
nd
>> > "pagepool" is a nonsense name.  I haven't looked into it in a lot of
>> > detail yet, but in the not-too-distant future, struct page will look
>> > like this (from your point of view):
>> >
>> > struct page {
>> > 	unsigned long flags;
>> > 	unsigned long memdesc;
>> > 	int _refcount;	// 0 for bump
>> > 	union {
>> > 		unsigned long private;
>> > 		atomic_t _mapcount; // maybe used by bump?  not sure
>> > 	};
>> > };
>> >
>> > 'memdesc' will be a pointer to struct bump with the bottom four bits of
>> > that pointer indicating that it's a struct bump pointer (and not, say,=
 a
>> > folio or a slab).
>> >
>> > So if you allocate a multi-page bump, you'll get N of these pages,
>> > and they'll all point to the same struct bump where you'll maintain
>> > your actual refcount.  And you'll be able to grow struct bump to your
>> > heart's content.  I don't know exactly what struct bump looks like,
>> > but the core mm will have no requirements on you.
>>=20
>> Ah, excellent, thanks for the pointer!
>>=20
>> Out of curiosity, why "bump"? Is that a term of art somewhere?
>
> https://en.wikipedia.org/wiki/Region-based_memory_management
>
> (and the term "bump allocator" has a number of hits in your favourite
> search engine)

Right, fair point, I was being lazy by just asking. Thanks for taking
the time to provide a link :)

>> And in the meantime (until those patches land), do you see any reason
>> why we can't squat on the middle bits of page->pp_magic (AKA page->lru)
>> like I'm doing in v2[0] of this patch?
>
> I haven't had time to dig into this series.  I'm trying to get a bunch
> of things finished before LSFMM.

Alright, well if/when you get a chance (before of after LSFMM), I'd
appreciate if you could take a look!

-Toke


