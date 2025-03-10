Return-Path: <netdev+bounces-173689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA5BA5A68B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 23:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB04172D68
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DB1D63DA;
	Mon, 10 Mar 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+18d/+L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0D20B22
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644037; cv=none; b=HarpqusIt2tUd343HZqdiSjnWHtC6nHg9nxBojWed4OUX56vAQ2ktadfFVPUvEmVtJOTiP5nhsbrHgN/mR7O08D/4haiLEtnnMphAeQtwotcDUBbD27UfabKSwaPPne27h2IhqhZvoFZOserNYbSyxBhQxvEz0iXKJSA0gYfN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644037; c=relaxed/simple;
	bh=5yVKhhU1Z5bfLJSv1S3zyNCRx8rw4aNLBcsluC3MbEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2+B1YiytjWHUg25X+awroJCCfsCSEfuKi24AQwDUnQTtlP2yw9W1AbhTbIL5YvNB9MZRNokutgCN2yUXThYVllHLS3CX35NmUwmQ21f68ucKGRgJmGI8zSYo9yOTl3uu4Vxe65DAoTptF0LyYzrugSqDa7oWxpPL8hEWyhVPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+18d/+L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741644034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CJdPnowOI8YmDQ3h17VXbzQRRXbDksv4PPsyAowEwY=;
	b=S+18d/+LKFsldZxW1aubVx9XNRJa5kEeR9X287yBMo1BcCOpgZf2NL3dCLKYh6ZD4sfW+j
	l2PGCxNWDmHjtEY2u+DmKUJl3mYrBGy12qh2blUcLx1pAtc5oX/pr+7DE/RT9pkiTJ0KOX
	mS/EJFlyTDD7PmDFLBZKuK5RHQ7C4wk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-gAIGDwbaP-eCfeCK3WiaxA-1; Mon, 10 Mar 2025 18:00:29 -0400
X-MC-Unique: gAIGDwbaP-eCfeCK3WiaxA-1
X-Mimecast-MFC-AGG-ID: gAIGDwbaP-eCfeCK3WiaxA_1741644028
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-54996792145so1553879e87.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644028; x=1742248828;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CJdPnowOI8YmDQ3h17VXbzQRRXbDksv4PPsyAowEwY=;
        b=BTkCdEhv1P4YegQTAnrIbHU8ohrOVSae23QCqpkhYN74JICi+nU1q/2g4fOm4reewS
         YsuTAzQElNdkR7SmENvIa8m995cNROLdb+GwArkRQxcRuK6z0AmMEWg8GM+dbtVEe0iH
         Ge6G4SVWN5lxyHLh5DlSYHUocRU149HIRaD/bLOS60YKewzam0imfXGjcxonvc728tld
         vzlc2NPiv11WfLJYO2M86aMqSeaaWlFdxOaejPdFepWi/6tuahDrRY81+BPImJORIL0b
         cAxb3tr4C++Wcea3atsHrO73ng4HxQw2y+RVh8sIwKbdbvppnFe4dCNgZzToazzm6ne5
         dkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1VLa+dEgEQ9NfRhMmEebk9iOe6w3wMEVT+pGJg4zWGLeXzWaA624XtjAuywIkiYkQ1zlG5yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLeFWBYWfGXWGE3IIeWrAj3jZ94UVzqFkA50m6UabvqM+dQkX
	n9d/A4xa/yPqyJCddUgw/e/shf5Cmx2bY+tL4bSOHI1pz23BewGbKZSCR6SgcNTFKIDpdN3USy7
	wyb7BigSGmlyKhdjuvSM74Esci3UAdRDahSV/ZCJLi/Y1E7sMEWv6Qg==
X-Gm-Gg: ASbGnct+szDAZ/KBz8UigggwUTE31wN8AEac4C+9gJxn7fhZ/AS0YPFNmOA1Uvong7I
	Tz/zy6sFSHfIg4H1tsdkZcAFOwoy16dKTNJdtA+bGWFBybIx6HQgBY5jVadMgDRneXA8z63CLfV
	gfVXc0nl6Z4TZr/PjflIfKltzzkhTn38AzVIqUdc5oWgZU14cUORwLU5Vxnd6N6ocPjmGpvSbMa
	QwNnov8Xax+tIRyfaCnaG+hCutFjbKAlAdouDDf8v2JgfyOk36Ngoqzlv6DbZoKJA1gLw9QikK6
	j4bMQ9rvTJ8X
X-Received: by 2002:ac2:53a3:0:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54990ead1d8mr3414202e87.42.1741644027975;
        Mon, 10 Mar 2025 15:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdNFgxOeNZOtS3nG+6oUcuZqBKM4a065DiazuwBgTZj10ngA0NBSWFQ9NBrJuqyh5TY5tRCA==
X-Received: by 2002:ac2:53a3:0:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54990ead1d8mr3414184e87.42.1741644027545;
        Mon, 10 Mar 2025 15:00:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd032sm1593817e87.142.2025.03.10.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:00:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 871DA18FA3F0; Mon, 10 Mar 2025 18:26:24 +0100 (CET)
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
In-Reply-To: <Z88IYPp_yVLEBFKx@casper.infradead.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Mar 2025 18:26:23 +0100
Message-ID: <87v7sgkda8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Mar 10, 2025 at 10:13:32AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>> > Also, Using the more space in 'struct page' for the page_pool seems to
>> > make page_pool more coupled to the mm subsystem, which seems to not
>> > align with the folios work that is trying to decouple non-mm subsystem
>> > from the mm subsystem by avoid other subsystem using more of the 'stru=
ct
>> > page' as metadata from the long term point of view.
>>=20
>> This seems a bit theoretical; any future changes of struct page would
>> have to shuffle things around so we still have the ID available,
>> obviously :)
>
> See https://kernelnewbies.org/MatthewWilcox/Memdescs
> and more immediately
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>
> pagepool is going to be renamed "bump" because it's a bump allocator and
> "pagepool" is a nonsense name.  I haven't looked into it in a lot of
> detail yet, but in the not-too-distant future, struct page will look
> like this (from your point of view):
>
> struct page {
> 	unsigned long flags;
> 	unsigned long memdesc;
> 	int _refcount;	// 0 for bump
> 	union {
> 		unsigned long private;
> 		atomic_t _mapcount; // maybe used by bump?  not sure
> 	};
> };
>
> 'memdesc' will be a pointer to struct bump with the bottom four bits of
> that pointer indicating that it's a struct bump pointer (and not, say, a
> folio or a slab).
>
> So if you allocate a multi-page bump, you'll get N of these pages,
> and they'll all point to the same struct bump where you'll maintain
> your actual refcount.  And you'll be able to grow struct bump to your
> heart's content.  I don't know exactly what struct bump looks like,
> but the core mm will have no requirements on you.

Ah, excellent, thanks for the pointer!

Out of curiosity, why "bump"? Is that a term of art somewhere?

And in the meantime (until those patches land), do you see any reason
why we can't squat on the middle bits of page->pp_magic (AKA page->lru)
like I'm doing in v2[0] of this patch?

-Toke

[0] https://lore.kernel.org/r/20250309124719.21285-1-toke@redhat.com


