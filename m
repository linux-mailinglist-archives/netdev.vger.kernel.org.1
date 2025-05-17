Return-Path: <netdev+bounces-191263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C957DABA7EB
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD517C305
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E430144304;
	Sat, 17 May 2025 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="McJpQK12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F6347B4;
	Sat, 17 May 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747450342; cv=none; b=iiC/Su71NrlPn5x5xjUvJiRsixbC593GI1wOr5AOL9aVkX/uN6TpEOzFQYTCi6l0pNp6SBrXdhcwVzOkIeyaAjRO2yP9ID1zCehFc0xBwwqblo5KA5H89b2XOyzlrwX2DctBot5d7kJO325AKSP0RtJLAB9XlytLZ7PtFMo5Xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747450342; c=relaxed/simple;
	bh=n7AWFPWFWIjXZt0SHoLEFSzimZmTXpG29aNJIaSEyLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YArDmZFZannZPcLjxYoBDNqTBWG2Hj+bDG40aEbog7EbDYWJR8qHzhTYmEv1vm+j4/WmLh4A/mDL+vRTfAD14PgbCN25taTw13wW8KfFjuRFuEMibPNtAEIZRuGFe8OSr5bSAjsvmh++md+TeiZDfWaHXFe+e3ScVw/PEqGFoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=McJpQK12; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747450341; x=1778986341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GL/y5vcmXDXc1EWkQZOFfkTkQwsYOksD9WIAFqZhRJA=;
  b=McJpQK12BENg+ANemRNOyLOqCQd7Vi8xkuZJj9RzTY0IpuV88ZvTq4yK
   44rWR6ENoxLGTEr+7NPI8qvB/9k5f6GwyEAy0OwDUPjowT/Rl1wxpSvdo
   /r0+ti7XTrnJ1Aqi+byrlmmucr3eaZQ9BONh1TGybwtUbU/BL7BME3bD4
   X2z2G8QCldSU+eXfJMcnOE1ZJXhvhGINlIhPUxnQL54l+QpmPvtttumZ6
   J7fznm/Mqw6bOBJGN6un+5+92xLaRnEwrylx/3B9xJBu9SAAn20b6hMBK
   E4vlHfC/X40FgIZG+8Y7Fwa4L4iejgnApPr9sgsfjliPcxZObUuv7MxWO
   g==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="499617658"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 02:52:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:16376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 37a77022-cfb3-4f6e-ab60-a957f6e92a13; Sat, 17 May 2025 02:52:17 +0000 (UTC)
X-Farcaster-Flow-ID: 37a77022-cfb3-4f6e-ab60-a957f6e92a13
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 02:52:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 02:52:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ematsumiya@suse.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [RFC PATCH 0/1] net: socket: centralize netns refcounting
Date: Fri, 16 May 2025 19:51:03 -0700
Message-ID: <20250517025206.47762-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516220920.1142578-1-ematsumiya@suse.de>
References: <20250516220920.1142578-1-ematsumiya@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Enzo Matsumiya <ematsumiya@suse.de>
Date: Fri, 16 May 2025 19:09:18 -0300
> Hi,
> 
> I came up with this patch to centralize netns refcounting on kernel sockets,
> because `sk_net_refcnt = !kern' is not enough anymore.
> 
> The idea is simply to remove the responsibility of a module outside of net/
> to have to deal with sockets internals (cf. sk_net_refcnt_upgrade()).
> 
> It adds an anonymous enum (just for named values) SOCK_NETNS_REFCNT_* that
> can be passed to __sock_create() and sk_alloc() through the @kern arg.
> (this was much easier and shorter than e.g. adding another arg)
> 
> A sock_create_netns() wrapper is added, for callers who need such refcounting
> (e.g. current callers of sk_net_refcnt_upgrade()).
> 
> And then, the core change is quite simple in sk_alloc() -- sk_net_refcnt is
> set only if it's a user socket, or
> (@kern == SOCK_NETNS_REFCNT_KERN_ANY && @net != inet_net).
> 
> I have the patches that modifies current users of sk_net_refcnt_upgrade() to
> create their sockets with sock_create_netns(), if anyone wants to test or
> this gets merged.
> 
> I could confirm this works only on cifs, though, by using Kuniyuki's reproducer
> in [0], which is quite reliable.  Unfortunately, I don't know enough about the
> other modules and/or how to trigger this same bug on those, but I'll be happy
> to test it if I can get instructions.
> 

I was waiting for b013b817f32f to land on net-next to respin
this series [0] as propised in [1].

[0]: https://lore.kernel.org/netdev/20241213092152.14057-1-kuniyu@amazon.com/#t
[1]: https://lore.kernel.org/lkml/20250409190031.38942-1-kuniyu@amazon.com/

So, let me respin it.

FWIW, I posted the most identical patch before the series.
https://lore.kernel.org/netdev/20240227011041.97375-4-kuniyu@amazon.com/

