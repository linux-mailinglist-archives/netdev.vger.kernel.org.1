Return-Path: <netdev+bounces-229064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFFBD7DEE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444014F8632
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622902D8393;
	Tue, 14 Oct 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R/y325+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F941DFDA1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426661; cv=none; b=PPaxAqeWKuHrWGt5WyscorCJvEIY/sc8ROcA6bAdJUrGTSgt0vYjOSNt7w504YirDb6W5ipI2RDv5eT2mKlMm70tTQE0MZ1r2CVIUkDzigHLY4+Uuul/idA6gDmDWs0IKVRm/AQi9vkotFnl7UmIdMHbblzBBq6ka3CmVUjh5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426661; c=relaxed/simple;
	bh=XNpQiaoPmtubQWjx7HZt+FaoHtPtuE6h/eecJifiCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACD21bosL1L6e4Le6b2F82szm5l4INlVG0jevY2S3sq1UgEm1FC/fKUCBnGDmmE/hL73B1PorKmwX9RPaxdQm1SDl+v4l0UNzJhlQWs4FPjltjGWw6BTyQTsNu1TXRt6cyDdEC8sARUacmar5kRab/46jIPDe4ZxbnxfC9HzIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R/y325+A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e52279279so35268245e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760426658; x=1761031458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJsuSntfzmyGwBLDCIOK8zsxQdVVbjKkDRasCAUOBFU=;
        b=R/y325+A9c8MxvrcUQukZV+j96qhVzE2ziF8QrunjEewp5G9eqQsioXUUEwqBBtH1e
         S4vHR0knK68wKOmJppkqHeEoqP+qEriQU/Fg0aJMlzlooYsQg3Quax0Y1oirx5SeXPg3
         b/3i8ru3btHplF6Pwq2FBUYVE+ySUl3NqsqlhkTp6ovg7vJ3ZgM7R+rL2CFv1ft75oXr
         RN1cp2dRqIpudgFo1BZJ7y4hliUOrzpIfPEljpKFAb9QEJ/1TLDNy0srWOjY0MNmeYWv
         bnhYotosgLR1qcHEkK5wWFTSmUwvoiVkYxCl5evyHgeEHp/5s8L4Uu84U2F55nu1ahF7
         FMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426658; x=1761031458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJsuSntfzmyGwBLDCIOK8zsxQdVVbjKkDRasCAUOBFU=;
        b=CZ1X3Wf9MTHfiaUX6oA6p5p6hf2fwNd8udOQa/47NFrp1efs7VAKu+HKfeSL7DeQLt
         dTIAIZfG6KPYdFyJPrXtmMLLK6gnlIwSalxwvN1UxDLAcCymTGxPItxBI0mGIMr2PeXs
         7t32FvUS+W1nJ8ykJnokHvLIeYtV4UUJbghBdPeToGAOE1qRJN1tjKAdoHAQT845Cd7E
         hg/4mE+0ng+2MQNicrG4u0zJ5rZZcY7XwtOrqtx1NfmYjhB91kibyT4s3OztLvqTUTyG
         WgevF37Mmv+L1Ax1GTR1HBoIwJYWNBM8ycBEAh4NKyxMUZRBIgiMXKEVmWAEcin1CFIj
         dncw==
X-Forwarded-Encrypted: i=1; AJvYcCXoqsVlsujctqzfU+s25aCm0mGT08h74jpiUQOoy3KW3fzPGgclHmlAossFIraYS6qrejHdm4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZc9P2X6R5vA70hS2/fdQplEJqkY9Ki+r8QEkMVg0wu4DvOEjx
	S1tkMXKoUDrAYW7kN027wsG2UoEZGaM1MH4vq/bluB724Rz64zRFrrtGRYAZlADsRGY=
X-Gm-Gg: ASbGnct+OH7ks9bgvd3d71KgSBT1HF8Aa+g1VFh+goS21kQz6uyVEISPqMVjAFsNk13
	z7YJiNdpJHVTgB43GnCI6H5o+nIB15eF2WnpyOU0xC9qt7iqaBOXdvDBdz6KVKKqkjNAvY/nHbV
	yGHmzD30SkcnQmE01jadoC5GHE2qWAFwlrcUtrW8u4d7nPL8nc0a18TdBJjGmVHUjpHWY+qNIhw
	CJkPxB9SvSLCJ6WrJ2xowQkQ1oVmf2IINcqjOXTQPp9YGbF7ErYFhT6AYPLyBJpNwb8CvZvKupY
	lJLnlpejVzlY23qvb/0bhGwfKtB/m1FSLJOuE69U+8MYqpf8kH/+KFjgyoEva8Frbu1JzY6lKgF
	0r2WsrVqbQwos1DemoaBg8+uKEnVGorhR7GUdZ8Uk792hai3ebPljrCCrg/3ebqQ=
X-Google-Smtp-Source: AGHT+IFRg4GPmLD9q+m6Z1pGRfggv0OTz6EOdiAPNLgTJQcEwNtxGs3WA3GtVkRT34c+YV2Jq9/wAw==
X-Received: by 2002:a05:600c:8b24:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-46fb42eee44mr106715865e9.39.1760426657567;
        Tue, 14 Oct 2025 00:24:17 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb492e6ddsm250256765e9.0.2025.10.14.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:24:17 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:24:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
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
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO36oKRR3UliRFR5@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <877bwyxvvl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwyxvvl.fsf@linux.dev>

On Mon 13-10-25 15:46:54, Roman Gushchin wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
> > On 10/13/25 12:16, Barry Song wrote:
[...]
> >> An alternative approach is to disable kswapd for these frequent
> >> allocations and provide best-effort order-3 service for both TX and RX paths,
> >> while removing the sysctl entirely.
> 
> I'm not sure this is the right path long-term. There are significant
> benefits associated with using larger pages, so making the kernel fall
> back to order-0 pages easier and sooner feels wrong, tbh. Without kswapd
> trying to defragment memory, the only other option is to force tasks
> into the direct compaction and it's known to be problematic.
> 
> I wonder if instead we should look into optimizing kswapd to be less
> power-hungry?

Exactly. If your specific needs prefer low power consumption to higher
order pages availability then we should have more flixible way to say
that than a hardcoded allocation mode. We should be able to tell
kswapd/kcompactd how much to try for those allocations.
-- 
Michal Hocko
SUSE Labs

