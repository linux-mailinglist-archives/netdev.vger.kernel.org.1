Return-Path: <netdev+bounces-167056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C0CA38A13
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BE23AFFD9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2027B226164;
	Mon, 17 Feb 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gx4Sc2h4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26986225A5E;
	Mon, 17 Feb 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811172; cv=none; b=hETayvUJLN9zlts8xrT89g9EtQ0+n/AkgCpiN3XmT7h/Aa/Sl5d6enGRJarPsb84OBX2nocX1x0u4NdGi8i2o5tvDfUfeMGZKENRY4LoGnfAev3rfpEER7wioNMr5aiZGW66s8j8JKiSiZfYMWgapKWvbjbLiKQQZCny/nuakjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811172; c=relaxed/simple;
	bh=X4cvVIWVhux9AouNtmKi1B1TTu5K6YBiJUq7zv/wHlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElYidw3HV8mvYJAQ3luIqXxkNbc88k4cfWzo0P/MmA908nSYLKyTZRZIRJOFOl9qemFGEQ5vrBE8xFNKyMk31lVJAPfmku6H/JFwtf/diL5YDPY8We1a9DitEqMGG3yfrRd4K70UfCwqHgK0Q9twpP79LKEmSAi9UCoIZ2SoHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gx4Sc2h4; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739811170; x=1771347170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIklRPm2/sNZHi8okh/gRXXTiabhqQojur/3BF22Cgs=;
  b=Gx4Sc2h4dT7L23r4G7Ah+ngUYIK2QDGF+YRnvUVzNwYqSKwO0IscnpXs
   SXH1UVMZbge+PfCIrG8hXzgiup1yGKcPo+0aU9EHYbbjoaeKOaGUFsqWY
   pTyro0IU/65THUWFA5zJxLFgV1ehUV0clFCP5VgxkQVBb/wn2cyFq57pw
   I=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="467592388"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:52:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:29541]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.186:2525] with esmtp (Farcaster)
 id cee1e0c6-a83f-487c-88e5-59e67027c934; Mon, 17 Feb 2025 16:52:44 +0000 (UTC)
X-Farcaster-Flow-ID: cee1e0c6-a83f-487c-88e5-59e67027c934
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 16:52:44 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 16:52:38 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <enjuk@amazon.com>, <gnaaman@drivenets.com>,
	<horms@kernel.org>, <joel.granados@kernel.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<lizetao1@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
	<iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<roman.gushchin@linux.dev>, <42.hyeyoo@gmail.com>
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
Date: Tue, 18 Feb 2025 01:52:29 +0900
Message-ID: <20250217165229.87240-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89i+ap-8BB_XKfcjMnXLR0ae+XV+6s_jacPLUd8rqSgyayA@mail.gmail.com>
References: <CANn89i+ap-8BB_XKfcjMnXLR0ae+XV+6s_jacPLUd8rqSgyayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

+ SLAB ALLOCATOR maintainers and reviewers

> > From: Kohei Enju <enjuk@amazon.com>
> > Date: Mon, 17 Feb 2025 01:30:16 +0900
> > > Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
> > > specified, since kvzalloc() doesn't support non-sleeping allocations such
> > > as GFP_ATOMIC.
> > >
> > > With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
> > > path and returns immediately after the kmalloc path fails.
> > > Therefore, using kzalloc() is sufficient in this case.
> > >
> > > Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
> >
> > This commit followed the old hash_buckets allocation, so I'd add
> >
> >   Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")
> >
> > too.
> >
> > Both commits were introduced in v6.13, so there's no difference in terms
> > of backporting though.
> >
> > Also, it would be nice to CC mm maintainers in case they have some
> > comments.
> 
> Oh well, we need to trigger neigh_hash_grow() from a process context,
> or convert net/core/neighbour.c to modern rhashtable.

Hi all, thanks for your comments.

kzalloc() uses page allocator when size is larger than 
KMALLOC_MAX_CACHE_SIZE, so I think what commit ab101c553bc1 ("neighbour: 
use kvzalloc()/kvfree()") intended could be achieved by using kzalloc().

As mentioned, when using GFP_ATOMIC, kvzalloc() only tries the kmalloc 
path, since the vmalloc path doesn't support the flag.
In this case, kvzalloc() is equivalent to kzalloc() in that neither try 
the vmalloc path, so there is no functional change between this patch and 
either commit ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()") or 
commit 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour").

Actually there's no real bug in the current code so the Fixes tag was not 
appropriate. I shall remove the tag.

Regards,
Kohei

