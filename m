Return-Path: <netdev+bounces-212134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E533B1E3BB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB07B18854AE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE92367B2;
	Fri,  8 Aug 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DyVW751r"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA9622DF9E;
	Fri,  8 Aug 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639073; cv=none; b=QbNh2Wl57C+14HLVm7yZSwvzTczLbp2/pt5w+R/WNwXsz3WMw8YUPRNwLfAd3pD/cusPpMyvF4do8luauOUf2kOZ0u/EopIXosmUPbkcIOwAFgzN/dyMl7DcWX4dXPO0PghPR61Iqjxq314kkTrfU8ce9LvSsZgoE5oJ60yuQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639073; c=relaxed/simple;
	bh=aqbJSD5uPsRATMEhLviWhCSwg8EdqYf4HiYTBXn3bWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNNx5XMNH5782BQzssL7mR9D4z/83sxZ9CZnxgA3H4cysM9ZfhRn6smL/pSw4J0gSNwJZ+NHnNU85gwl0ZyOuXFyQXV2IklkQqDEIDOiWpiFJfFg+edFRz0dYUJ629aIx5OpexzLI1qUYNK4+jUjpMeADHrFwRpTp37zhTiKyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DyVW751r; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DZ
	7lUaDvHaSRVj5FuCawGYNv4e6vG5axdnCc7tscKzA=; b=DyVW751rfnUmtXXETA
	hEL+9XtMS3mHMm+A/utc/qqfuWAMSrX1tut3ZRMkNOlna41bVgixfVTtcieaNPxV
	cYCscPCm0IpXDhfzGNMuRQGr18nxblAMinq+xb/314kV3sKLAj/BeExds+Psu8MV
	71Aej9WcE2hOHhB06IPle87w8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3p9IBp5VoXc4RAg--.6733S2;
	Fri, 08 Aug 2025 15:28:03 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
Date: Fri,  8 Aug 2025 15:28:01 +0800
Message-Id: <20250808072801.229036-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3p9IBp5VoXc4RAg--.6733S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF18Gr1xXrWftryxWr4DArb_yoW8Ar4xpF
	WUtr9Ivw1kXa48JFs7Aan7ua4Uur4vyrWDJ34agr1UAw15uFZrA3y3KF1Y9a4avw47A3ZI
	q3yIkwn8Aw1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UF0PhUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxmjCmiVpIw72wAAsm

On Wed, 2025-08-08 at 14:01 +0800, Eric wrote:

> I have some doubts why AF_PACKET timer would be involved in the performance
> of an application.
> 
> Are you sure about your requirements ?
> 
> I do not know what application you are running, but I wonder if using
> TX timestamps,
> and EDT model to deliver your packets in a more accurate way would be better.
> 
> Some qdiscs already use hrtimer and get sub 50 usec latency out of the box,
> or whatever time a cpu sleeping in deep state takes to wake up.


Dear Eric,

Let me explain our requirements. Initially, we used regular UDP reception
function to process LiDAR data packets, and at that time, the packet latency
was acceptable. However, due to insufficient CPU resources on our system, we
needed to optimize the CPU consumption of various tasks, including the task
of processing LiDAR data packets.

Therefore, our original requirement was to reduce the CPU consumption and
context switching overhead of the program that processes LiDAR data. To 
achieve this, we employed the AF_PACKET + MMAP programming model and found
that it indeed resulted in significant improvements. However, we noticed a
side effect: even with a 2-millisecond retire timeout set, the processing
latency for received packets still fluctuated to over 8 milliseconds.

Nevertheless, we still wanted to continue using the AF_PACKET + MMAP
programming model to improve CPU utilization. Therefore, we modified the
implementation of AF_PACKET and switched to using hrtimer, which resulted
in keeping the processing latency within 2 milliseconds. In this way, we
can continue to use the AF_PACKET + MMAP programming model to optimize
the LiDAR processing tasks.


Thanks
Xin Zhao


