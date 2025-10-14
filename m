Return-Path: <netdev+bounces-229293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E123FBDA513
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8A1D5078FA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A53002B9;
	Tue, 14 Oct 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZeXvKawD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331E2FE059
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454892; cv=none; b=GqbMHnw+vZBxLXDm39rHMlf/bzJUN96yUl9i7NNuP1KjTQiglL4TAVdDUl2sXtbctvX0hqP2liLLuaeJ1m1XJY2fuu7hN97PH05wuigW527BOrmA0F8ew/fPf95TqbqDlgc9I3yXabWIpCWs85o1nId9Qs3FU/F4tXPAez864PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454892; c=relaxed/simple;
	bh=PhjtL3HD6534h9vTcz70HRQ4Ghvd6KaR4lsu8s+WwWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBmm9Hcttu/urXfJCsj1Hp1/7C5U4JbarKzhHHbqNDxdhUhk8bY2KmOistX6p9BqDG2KRYOmgAADkwUbENNCKI0p17EwfjVTi2PjGlOiXqDZieaAtH/mpv9GN1p0Vjgghw1K8KAL7BV1zXsWQNYZZtkNouqkGWohSVhtgaOsf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZeXvKawD; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so30932315e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760454888; x=1761059688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQLfTHNnTKNjH+34TPL7Pi8OhXbeEQ0J4cWXx6jAeow=;
        b=ZeXvKawD1Tj/ucKm6ywTes/XRey9q5W9b146tXZlHWh3i8RMXKREAE6WQzD3JMbrLv
         CmBEKfgGnIVFQRYN8Tq06YaKVtZNvRqozEkPbW6FPKWZ3pLVOP9s7IjfSThQ9iT4Si4J
         fN+VbPJGoJgrhJyZDurPKz0AG+ol5cCNS0mnPqesXsN6Kz12exiOX1ugKLfQvppybecy
         gXfYKnP75sQnm5M+2s+ZzDbpAuHPkG1/d3Y06xPnonQr29FSN367krqdWuS4Uiu3lWsp
         LzNzdoKzaq4wrM5EQ3wEjflxJ7WLZqfUvTEGsDKuwvj2crreP0qgWzyaxm7arXLFgW3N
         nCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454888; x=1761059688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQLfTHNnTKNjH+34TPL7Pi8OhXbeEQ0J4cWXx6jAeow=;
        b=llzKO+wMZtw/frlxvz3RG4xG9N7+0EvWaEdVRpMiBgg1MZz1Kq4PEegvdUREKLehzK
         suLC3u983yc3I2DKFwBSkNZhBRPoRDT6uqrxalPiyvSz/lH8BeR8IGq2V/gqE/1qxsQX
         bu7fS96ZHDR6Ib8I41Wc1ATuXgRnLfgDfPHBze05aqE8rLXw2h2Rm9KMuz+btcVfaEEw
         RmNHDf5nkG2UR0tAvs0DtJzfFXArOe49Esa5O5+iehEg8cz7T6uT4V7bRixeKBW+j3c8
         Mk2rcI2c5J3nISMLR55dPOhkkasT6m2RxcCz+tXLDyFXy7i0DqT5yCU5wY+ENooG6tLx
         0+lg==
X-Forwarded-Encrypted: i=1; AJvYcCUbq14I+aZNXklzyVRKRkid41+ChLhDtXd7eOGcap5+Han1Q8jYcndNRU4eblzxe6iSGiBkOSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Su6kWEiJb2Q801qrMZM5UYNvW8EQuFdek2t9ihF+QtEPznE/
	PSyyScer+SUuNGVOSk2sGApqeYZ8VNTY5yuoCmPfDoFiqyqrD0X0p2mEDE/F6aht7Xs=
X-Gm-Gg: ASbGncvdoj55KabD9y1pTZpJolC7/6s3ZOVEmc00LwVnjgjXzExs6eXms37UrmGAdlu
	5aB0unq82MZ4WjHQA1TiY2VaZtaMHqzDxAEdlbWYEGw46pxbylldFAbpzH8vzKJzBHSwGf9Alwe
	qW74/XvPdlo/MHEZKAyrxbQZdrZ0fl3VqPPtKeRZ8UVwLkc8sFty65Jn5IhJ5KurUnAXpKjxuBq
	DEcfRVzbiPQkUERq8jyzuyZvzGi0Z6UGOdyZYRqHpLFczIWeePbrDEAXG7Xi95DnXWx1ZAYsePs
	xGigK2gXmwqwzqY/aQQPjWB5gYvUQxnYvhnSGkVSzGA0+5CosR5XmCniV3tZypL2wPYRIv3SiQq
	wJ4ISE0x+VOwl6T6e28pB0JiRXG7IdPw8bLnQonREsthMVrZUaZeav+cEJpsCc1hwZcarz8Z3SA
	==
X-Google-Smtp-Source: AGHT+IFTHGjFphXZexQjbUWRV0zNN1oAawyBZFjG8j79GJAZYI0e5RFLHEUzsaTaFKvHfVpvOLq1+w==
X-Received: by 2002:a05:600c:6818:b0:46e:36fa:6b40 with SMTP id 5b1f17b1804b1-46fa9af915emr172798525e9.24.1760454888343;
        Tue, 14 Oct 2025 08:14:48 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab500706sm157838725e9.3.2025.10.14.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:14:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:14:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO5o548uQAuBcw0P@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <aO37Od0VxOGmWCjm@tiehlicka>
 <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>

On Tue 14-10-25 07:27:06, Shakeel Butt wrote:
> On Tue, Oct 14, 2025 at 09:26:49AM +0200, Michal Hocko wrote:
> > On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > > On 10/13/25 12:16, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > [...]
> > > I wonder if we should either:
> > > 
> > > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > > determine it precisely.
> > 
> > As said in other reply I do not think this is a good fit for this
> > specific case as it is all or nothing approach. Soon enough we discover
> > that "no effort to reclaim/compact" hurts other usecases. So I do not
> > think we need a dedicated flag for this specific case. We need a way to
> > tell kswapd/kcompactd how much to try instead.
> 
> To me this new floag is to decouple two orthogonal requests i.e. no lock
> semantic and don't wakeup kswapd. At the moment the lack of kswapd gfp
> flag convey the semantics of no lock. This can lead to unintended usage
> of no lock semantics by users which for whatever reason don't want to
> wakeup kswapd.

I would argue that callers should have no business into saying whether
the MM should wake up kswapd or not. The flag name currently suggests
that but that is mostly for historic reasons. A random page allocator
user shouldn't really care about this low level detail, really.
-- 
Michal Hocko
SUSE Labs

