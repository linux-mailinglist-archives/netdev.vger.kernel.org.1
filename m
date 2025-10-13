Return-Path: <netdev+bounces-228964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E969ABD6A81
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C02A404084
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222E1FCF7C;
	Mon, 13 Oct 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3e+5SHF"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06079211F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395641; cv=none; b=oJsR067qpbIYbYsGCtfQzNEX44K9eFgs6nOgzmOVG0diBHdsNTiwxIFbiAQfcgjz7OgAw/GhWl447b/vg94ShJmOHinl/F8m071+zpR/L+AourbbLv/lm8QCsFR0tADEZpbBjwPmZRKYzh9Db86c1A+tPn5S+0XQvzx5tdOTr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395641; c=relaxed/simple;
	bh=YB6T+iksAdaFSybd1uus3MCfkm4akoiZhW6/MGSVQic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXKsRz3uZiacKCsZTDtd143FXRSqTXSG0Qy/wDV9HWe1L8CagcskdH1tsfNrjYtcnkYMDJ2QAms/ZeNkklrEsGpdVbBR8ZiVw/APav661uE4h/WP3vNZXV7q2HSjnUQ3K6otGKgkyB7ZjiO1hDpYqIVUx5ogxg/noqOG15OAlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3e+5SHF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760395625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvVrgqE5UCoUQhWcYn4T+nWyANRYtASSr9LcpzAHUuA=;
	b=I3e+5SHFTgUvTqFeG/5a1PCCaKzBtf7GtUS8bYY/Hk6NPHCv8U3BRHMHvuPl3cD9tHs/Dq
	tnESMYYeNWKpp7T+21L/NyVh0PIS0d7053jHpSE7IK9gPgA8kyZyI/PRHQxAxl84dUnqtZ
	KrS4TcSHu1uRIcx43kjX79znlQhPiDo=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>,  netdev@vger.kernel.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Jonathan Corbet <corbet@lwn.net>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Brendan Jackman <jackmanb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Zi Yan <ziy@nvidia.com>,  Yunsheng Lin
 <linyunsheng@huawei.com>,  Huacai Zhou <zhouhuacai@oppo.com>,  Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,  Harry Yoo
 <harry.yoo@oracle.com>,  David Hildenbrand <david@redhat.com>,  Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
In-Reply-To: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz> (Vlastimil Babka's
	message of "Mon, 13 Oct 2025 20:30:13 +0200")
References: <20251013101636.69220-1-21cnbao@gmail.com>
	<927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Date: Mon, 13 Oct 2025 15:46:54 -0700
Message-ID: <877bwyxvvl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Vlastimil Babka <vbabka@suse.cz> writes:

> On 10/13/25 12:16, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>> 
>> On phones, we have observed significant phone heating when running apps
>> with high network bandwidth. This is caused by the network stack frequently
>> waking kswapd for order-3 allocations. As a result, memory reclamation becomes
>> constantly active, even though plenty of memory is still available for network
>> allocations which can fall back to order-0.
>> 
>> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key")
>> introduced high_order_alloc_disable for the transmit (TX) path
>> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
>> allowing the TX path to fall back to order-0 immediately, while leaving the
>> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
>> generally unaware of the sysctl and cannot easily adjust it for specific use
>> cases. Enabling high_order_alloc_disable also completely disables the
>> benefit of order-3 allocations. Additionally, the sysctl does not apply to the
>> RX path.
>> 
>> An alternative approach is to disable kswapd for these frequent
>> allocations and provide best-effort order-3 service for both TX and RX paths,
>> while removing the sysctl entirely.

I'm not sure this is the right path long-term. There are significant
benefits associated with using larger pages, so making the kernel fall
back to order-0 pages easier and sooner feels wrong, tbh. Without kswapd
trying to defragment memory, the only other option is to force tasks
into the direct compaction and it's known to be problematic.

I wonder if instead we should look into optimizing kswapd to be less
power-hungry?

And if you still prefer to disable kswapd for this purpose, at least it
should be conditional to vm.laptop_mode. But again, I don't think it's
the right long-term approach.

Thanks!

