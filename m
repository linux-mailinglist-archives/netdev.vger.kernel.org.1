Return-Path: <netdev+bounces-212125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13A8B1E18A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 07:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD2D3A39A4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB41A4F0A;
	Fri,  8 Aug 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NUVCZj58"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84A2E36E2;
	Fri,  8 Aug 2025 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629668; cv=none; b=JWTX1zWcbiIclzgw16eLxk2ATYpf2ddkg9jO5AlJiTcIrGKnfUHapPghAKi2ETYbowpieiPpzvbI5EDrGyF7PNJCdULSlDGa0XfbTeLzCv4NCbr9Ym5ty/Yiy+lJLT+jVZw51XOtHOU8s+VDjlDA6iXEoCPhZypDz29S1hqvib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629668; c=relaxed/simple;
	bh=F6fLKbm9r4rCivnHXjZiFWuJSTvhJ9oWcJCJJoy5myI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL7bLLqEItkNLZWwDqt8tb9rA22SVN86Kfz2MXFJykF6KZUj0Uv3lEemfzF43nGXKQ8s6nec8A028uTLHAwj0kNxqJHXbIGGvjfP8Wpm0YNRbx31kR2ZwaKNcEDxg9ul25W0o8dtF41g48YsECRWZM8gRVJuCfFCF9YZkVhjtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NUVCZj58; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WE
	guBV9Nj+AlQ84hzfe3or4aV3V5DdYCSGiUDvr1ZWM=; b=NUVCZj58DeeWwV9BeJ
	0aetTPkWfPjhkyaM7Op8bRLDiLEMQorfTXDZkO31qkdAb7bFxxpSXC3uUvQB9hXN
	o1CHdsI8rSHLWTFJXNdw/E1VwLfJkGw4WfnSifgaDAOneeRquPYeyt2XikrAaZ8F
	YaeOYNmPrq7Ozell3aLSHsYCU=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHnjXjhZVoPft6AQ--.55044S2;
	Fri, 08 Aug 2025 13:06:43 +0800 (CST)
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
Date: Fri,  8 Aug 2025 13:06:43 +0800
Message-Id: <20250808050643.107481-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHnjXjhZVoPft6AQ--.55044S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4rGry5Wr4kXrW3uFW8tFb_yoW8XF47pF
	Z8ZrnrKwnrJasrJrZ7A3WkXayIvr1rCr45Jrn5JF90ya9xCFyrtr4aqw4ruFZF9wsYv3ZI
	vw40yF4rCw1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnJ5rUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRxejCmiVfm2PowAAs7

On Wed, 2025-08-06 at 16:51 +0800, Ferenc wrote:

> I doubt we need another CONFIG option ?
> 
> Also this seems to be beneficial for HZ=100 or HZ=250 configuration,
> maybe worth mentioning in the changelog.
> 
> But more importantly, I think you should explain what difference this
> really makes,
> in which circumstances this timer needs to fire...
> 
> If real-time is a concern, maybe using a timer to perform GC-style operation
> is a no go anyway...

Dear Eric,

I've thought about it, and I really didn't foresee any obvious drawbacks
after switching to hrtimer, so in PATCH v1, I removed that config and directly
changed it to hrtimer.
As you mentioned, this issue is indeed more pronounced on systems with HZ=250
or HZ=100. Our testing environment was also based on a system with HZ=250, 
which is still quite common in embedded systems.

Regarding the benefits of using hrtimer, I already provided the test data and
testing environment in my previous reply to Ferenc, and the improvements are
quite significant.

As for when the retire timer expires, I've reviewed this logic. From my
perspective, the existing mechanism in AF_PACKET is complete. In the
prb_retire_rx_blk_timer_expired function, there is a check to see if there are
any packets in the current block. If there are packets, the status will be
reported to user space. By switching to hrtimer, I aimed to ensure that the
timeout handling in the prb_retire_rx_blk_timer_expired function can be
executed in a more timely manner.

Thanks
Xin Zhao


