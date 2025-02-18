Return-Path: <netdev+bounces-167200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40938A39215
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1646F16AE98
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DF1A2554;
	Tue, 18 Feb 2025 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="juL/issS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD1198823;
	Tue, 18 Feb 2025 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852558; cv=none; b=JmEtOKONEyOZCYNRbsNIRK4gQVNHIgGWK5WGf/0VYimq/b94+bylAt+V1VzR0V0EafqftjYbTV9Sy9FNJw1qbRlYpiVYESI351DooatRYPkla1JSRopLYcmvaYPn3ghjHZkaeId8xHjr94vA6BHLxHgr1LT8cf0Z8/wSScRMSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852558; c=relaxed/simple;
	bh=pxH1nfbEv2RRWKjUnE9knf+tEmhK6ZwKRJBxBZjuKUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j95h4Ehpz44JwytWH/3Fn1yUm1fuIAZSaXWeWeerABhK1VY0x1Nf7RhFe31Xp2eEOB9Hq7oC3bVbGIfStWNXEm8o8ITUZyjY4Yq9G00pHtdFB7lBvPqhXdadw/KJ/ijOLAKHBuNldVcoEdmBohkxE8Ntbpl8xyotBhxgarv8HSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=juL/issS; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739852558; x=1771388558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0H8g2Ig0p4sOXdDEzUc4q6vUJHVYW75M1gNOnWK9kU=;
  b=juL/issSOHOXb9CTS2QAFCHOvU0yQQMUtkelPAgPiNDu80cZwUh1htVV
   CZ/fkErNHpDi+2KsBuAX3L9HGVY/xVQ7Z/yno6uFUQ/j1WWbqnB13fUr/
   Ilmsv4pA39v8KaK/FPPJi4OUZBvLd1ccHa4bZ2bppep4zQtT/I60OHuwP
   M=;
X-IronPort-AV: E=Sophos;i="6.13,294,1732579200"; 
   d="scan'208";a="272065216"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 04:22:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:53261]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id f87b2c59-5b8e-4b9a-8c18-524ac1273d36; Tue, 18 Feb 2025 04:22:32 +0000 (UTC)
X-Farcaster-Flow-ID: f87b2c59-5b8e-4b9a-8c18-524ac1273d36
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 04:22:31 +0000
Received: from b0be8375a521.amazon.com (10.119.14.201) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 04:22:25 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <vbabka@suse.cz>
CC: <42.hyeyoo@gmail.com>, <akpm@linux-foundation.org>, <cl@linux.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<gnaaman@drivenets.com>, <horms@kernel.org>, <iamjoonsoo.kim@lge.com>,
	<joel.granados@kernel.org>, <kohei.enju@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <penberg@kernel.org>,
	<rientjes@google.com>, <roman.gushchin@linux.dev>
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
Date: Tue, 18 Feb 2025 13:22:16 +0900
Message-ID: <20250218042216.30357-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <b4a2bf18-c1ec-4ccd-bed9-671a2fd543a9@suse.cz>
References: <b4a2bf18-c1ec-4ccd-bed9-671a2fd543a9@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

>>> > From: Kohei Enju <enjuk@amazon.com>
>>> > Date: Mon, 17 Feb 2025 01:30:16 +0900
>>> > > Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
>>> > > specified, since kvzalloc() doesn't support non-sleeping allocations such
>>> > > as GFP_ATOMIC.
>>> > >
>>> > > With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
>>> > > path and returns immediately after the kmalloc path fails.
>>> > > Therefore, using kzalloc() is sufficient in this case.
>>> > >
>>> > > Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
>>> >
>>> > This commit followed the old hash_buckets allocation, so I'd add
>>> >
>>> >   Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")
>>> >
>>> > too.
>>> >
>>> > Both commits were introduced in v6.13, so there's no difference in terms
>>> > of backporting though.
>>> >
>>> > Also, it would be nice to CC mm maintainers in case they have some
>>> > comments.
>>> 
>>> Oh well, we need to trigger neigh_hash_grow() from a process context,
>>> or convert net/core/neighbour.c to modern rhashtable.
>> 
>> Hi all, thanks for your comments.
>> 
>> kzalloc() uses page allocator when size is larger than 
>> KMALLOC_MAX_CACHE_SIZE, so I think what commit ab101c553bc1 ("neighbour: 
>> use kvzalloc()/kvfree()") intended could be achieved by using kzalloc().
>
>Indeed, kzalloc() should be equivalent to pre-ab101c553bc1 code. kvmalloc()
>would only be necessary if you need more than order-3 page worth of memory
>and don't want it to fail because of fragmentation (but indeed it's not
>supported in GFP_ATOMIC context). But since you didn't need such large
>allocations before, you probably don't need them now too?

Yes, from pre-ab101c553bc1 code, it looks like we don't need the vmalloc 
path for large allocations now too.

>> As mentioned, when using GFP_ATOMIC, kvzalloc() only tries the kmalloc 
>> path, since the vmalloc path doesn't support the flag.
>> In this case, kvzalloc() is equivalent to kzalloc() in that neither try 
>> the vmalloc path, so there is no functional change between this patch and 
>> either commit ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()") or 
>
>Agreed.
>
>> commit 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour").
>> 
>> Actually there's no real bug in the current code so the Fixes tag was not 
>> appropriate. I shall remove the tag.
>
>True, the code is just more clear.

Thank you for looking at the patches and providing your comments.

I'll send out v2 with the revised commit message, removing the Fixes tag.

Regards,
Kohei

