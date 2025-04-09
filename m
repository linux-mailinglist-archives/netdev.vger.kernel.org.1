Return-Path: <netdev+bounces-180782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B01A827A1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C49C8A27A5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8C25A2CE;
	Wed,  9 Apr 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CCkFSkhm"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890C265CB5
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208425; cv=none; b=WCdqZddQW5ddXYeDq0Oi1QQl8eQC03x7uVNVWkbSZt1X0lRS+wrkcy1+zOiMutnim2QjCvn7Zul43mTGIXFt6HnU54yHeVdQWDUp04f6SCLCnk1lqWibCVMVinsSSUoa2uQkfMmsL0iNFvzz3HGCkxMhKycXxbbXB/bPMRYdVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208425; c=relaxed/simple;
	bh=NQqy/cjx9OyWoyDJhTBrZuVp1p/HEvWyVobPSNDaeLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=X4qkrqgAPTYNhF8tR3GxFjcgt0PcWVnT1r0jxq15BlsZyfj17nz1/QgbebCHD/56o5IsxNPZLxd9wZjbZnUkIm+sl/wtzJJx1pPI+NPXROjP/b90WyDRqnvesS10JHpEvd+Kka2JI5p+nkK6IEe2UI6+q9yIk5fX1sIwaJbLQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CCkFSkhm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250409142019euoutp0157c8ee396fa63e82d8e99e080b8fd35e~0rFEWMikK0962209622euoutp01P
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:20:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250409142019euoutp0157c8ee396fa63e82d8e99e080b8fd35e~0rFEWMikK0962209622euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744208420;
	bh=IxrZvb+bqm1wNomd6Au0BLypn+IJ8OzZGfnv5IKf4rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCkFSkhmBEtjrpbqdgH/fucNLT7FuQ/YCwH2UUi5FufT6io98JIcYmz5gFHh14IXm
	 xIz6VmXYRccs8LZxsXmVLD9pcFncvqhJej+Oej+ag9cDjU5KqIGtfpuYx7O1aq8mNs
	 t+V33fytmEPWMxFVJq6rWZhr6LZeVEtGarMeebg4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250409142019eucas1p26c2a822f06bb50d4e84b19fec1d80519~0rFENfR_l0509405094eucas1p2x;
	Wed,  9 Apr 2025 14:20:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.2A.20409.32286F76; Wed,  9
	Apr 2025 15:20:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250409142019eucas1p2e9fcd882f71cac08385cd7313a1dec90~0rFD34Dxk2502525025eucas1p2C;
	Wed,  9 Apr 2025 14:20:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409142019eusmtrp181b480d1cbe6467d222a9650ddebf491~0rFD3RRKN3073330733eusmtrp1U;
	Wed,  9 Apr 2025 14:20:19 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-6c-67f68223e60b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.7D.19654.32286F76; Wed,  9
	Apr 2025 15:20:19 +0100 (BST)
Received: from localhost.localdomain (unknown [106.210.135.126]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409142019eusmtip2aa1b8045af6c73c58966996f6718d4b3~0rFDjHI9U1557915579eusmtip28;
	Wed,  9 Apr 2025 14:20:19 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: magnus.karlsson@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com
Subject: Re: Re: [PATCH] xsk: Fix race condition in AF_XDP generic RX path
Date: Wed,  9 Apr 2025 16:20:11 +0200
Message-Id: <20250409142011.82687-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CGME20250409125216eucas1p150b189cd13807197a233718302103a02@eucas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzneV3lpm/pBocn6Vhsfb+KxWLXupnM
	Fpd3zWGzuHn8OYvFikMn2C2OLRBzYPPYOesuu8fiPS+ZPDat6mTz+LxJLoAlissmJTUnsyy1
	SN8ugStj0ollLAXvxSqOnDzF1MD4T7CLkZNDQsBEoun/JKYuRi4OIYEVjBLL9zxlhHC+MEos
	W3eIBcL5zChxdMZ/NpiWRyunsEMkljNKdK18B9XylVHi98NfjCBVbALGEk3f97OA2CICshJ/
	1pwEK2IWaGGUePF2LRNIQljAS+L13P1AYzk4WARUJY6c5gQJ8wo4Szx6N5kZYpu8xP6DZ8Fs
	ToE4iTvzDrFD1AhKnJz5BGw+M1BN89bZzCDzJQRWckg039vADtHsIrGh7RrUIGGJV8e3QMVl
	JE5P7mGBaGhmlJg1s5MdwulhlFhz9QojyEUSAtYSa0/agpjMApoS63fpQ/Q6Shyd9ZAdooJP
	4sZbQYgb+CQmbZvODBHmlehoE4Ko1pG4cfE51FYpie8zN7NA2B4SW0/uYJvAqDgLyTezkHwz
	C2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFp5fS/4192MC5/9VHvECMTB+Mh
	RgkOZiUR3gl539KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8y7a35ouJJCeWJKanZpakFoEk2Xi
	4JRqYLLc+bgqUGK7Mc//Lo0Ak4qkF9wdcSzHy6L04kXeRXn7ti2+YfjgzMQfib1rG1X1jDjn
	H/mePoG9MY9j5UHbZY/nO4pdCuL422L3gfXkmtxYo4IFSv69zZHnkrszpEWzrry7/CvXhT+n
	5ezORdOFWCSfTpNSK3tUe2tJ8j1+Tu26b9Nniz5bfeTOO83gDz+dY97VvYqUe3riupdz35/T
	hx94hvP8Z7QtcNrwzVv3+qE58+cUnOXhvfY4bcGMcP/aQ098zCwKvx1KvP1urduOdZbH3R3O
	hZVVnlsZM/3t/hhRt4l3glt1VWKNO6tXGYm5HjL4a9lz/fve082n/HmEt13NKcu4eyH3rsm7
	EK8nj5VYijMSDbWYi4oTAUz9Bi+aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7rKTd/SDT4vlbDY+n4Vi8WudTOZ
	LS7vmsNmcfP4cxaLFYdOsFscWyDmwOaxc9Zddo/Fe14yeWxa1cnm8XmTXABLlJ5NUX5pSapC
	Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GpBPLWArei1UcOXmK
	qYHxn2AXIyeHhICJxKOVU9hBbCGBpYwSzYdzIeJSEn/W/WGGsIUl/lzrYuti5AKq+cwosa5v
	EhNIgk3AWKLp+34WEFtEQFbiz5qTjCBFzAJdjBIT3zSBTRUW8JJ4PXc/UDcHB4uAqsSR05wg
	YV4BZ4lH7yZDLZCX2H/wLJjNKRAncWfeIaiDYiU6uxawQNQLSpyc+QTMZgaqb946m3kCo8As
	JKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBAb/tmM/t+xgXPnqo94hRiYOxkOM
	EhzMSiK8E/K+pQvxpiRWVqUW5ccXleakFh9iNAU6eyKzlGhyPjD+8kriDc0MTA1NzCwNTC3N
	jJXEedmunE8TEkhPLEnNTk0tSC2C6WPi4JRqYHI6/Mvoh82ED/rm7Zavv37T75Cc0LnY+MAb
	H8mdaoenyl3u77qhvPjGDIeKj1eW+76bo7xtY/SRq4q6XAWhN//p9nH1/ZutK7fVU6dX+nY2
	H7+3cPXskyf97uvJGu1YY7Wz4J3KxR3Ktt1/CtKOCEUF9b3y+cgkm3lnp8XChT+63b+a2Yo2
	3v71q0/g+vpP4lnMM7j2/zRVlf1gdibkT/GUrDoX14MuM11F/9zp1GD+aDdZJd/Icb7fl4hF
	ySWnD36sWN/Ra/Ihcv+8I3cXhtSqz5m9QPjN9lxnta3xOrU/Yyse71gRIpK4oTt8Xr/P0Y81
	llcmLJt11tzQyfxW2c8GzzN/eXSbFvJmT7u6u0SJpTgj0VCLuag4EQDmZCwgBwMAAA==
X-CMS-MailID: 20250409142019eucas1p2e9fcd882f71cac08385cd7313a1dec90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409125216eucas1p150b189cd13807197a233718302103a02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409125216eucas1p150b189cd13807197a233718302103a02
References: <CGME20250409125216eucas1p150b189cd13807197a233718302103a02@eucas1p1.samsung.com>

> I do not fully understand what you are doing in user space. Could you
> please provide a user-space code example that will trigger this
> problem?

We want to scale single hardware queue AF_XDP setup to
receive packets on multiple threads through RPS mechanisms.
The problem arises when RPS is enabled in the kernel.
In this situation single hardware queue flow can scale across
multiple CPU cores. Then we perform XDP/eBPF load-balancing
to multiple sockets, by using CPU_ID of issued XDP call.

Every socket is binded to queue number 0, device has single queue.

User-space socket setup looks more-or-less like that (with libxdp):
```
xsk_ring_prod fq{};
xsk_ring_cons cq{};

xsk_umem_config umem_cfg{ ... };
xsk_umem* umem;
auto result = xsk_umem__create(&umem, umem_memory, pool_size_bytes, &fq, &cq, &umem_cfg);

...

xsk_socket_config xsk_cfg{
    ...
    .xdp_flags = XDP_FLAGS_SKB_MODE,
    ...
};

xsk_socket* sock1{nullptr};
xsk_ring_cons rq1{};
xsk_ring_prod tq1{};
auto result = xsk_socket__create_shared(
    &sock1,
    device_name,
    0,
    &rq1,
    &tq1,
    &fq,
    &cq,
    &cfg
);

xsk_socket* sock2{nullptr};
xsk_ring_cons rq2{};
xsk_ring_prod tq2{};
auto result = xsk_socket__create_shared(
    &sock2,
    device_name,
    0,
    &rq2,
    &tq2,
    &fq,
    &cq,
    &cfg
);

...
```

We're working on cloud native deploymetns, where
it's not possible to scale RX through RSS mechanism only.

That's why we wanted to use RPS to scale not only
user-space processing but also XDP processing.

This patch effectively allows us to use RPS to scale XDP
in Generic mode.

The same goes for RPS disabled, where we use MACVLAN

child device attached to parent device with multiple queues.
In this situation MACVLAN allows for multi-core kernel-side
processing, but xsk_buff_pool isn't protected.

We can't do any passthrough in this situation, we must rely
on MACVLAN with single RX/TX queue pair.

Of course this is not a problem in situation where every device
packet is processed on single core.

> Please note that if you share an Rx ring or the fill ring between
> processes/threads, then you have to take care about mutual exclusion
> in user space.

Of course, RX/TX/FILL/COMP are SPSC queues, we included mutual
exclusion for FILL/COMP because RX/TX are accessed by single thread.
Im doing single process deployment with multiple threads, where every
thread has it's own AF_XDP socket and pool is shared across threads.

> If you really want to do this, it is usually a better
> idea to use the other shared umem mode in which each process gets its
> own rx and fill ring, removing the need for mutual exclusion.

If I understand AF_XDP architecture correctly it's not possible for single
queue deployment, or maybe Im missing something? We need to maintain
single FILL/COMP pair per device queue.


