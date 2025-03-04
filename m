Return-Path: <netdev+bounces-171673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A746A4E197
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE41819C1548
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAC207E09;
	Tue,  4 Mar 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j06vYLb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF9202C48
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099170; cv=none; b=pLE67dyhtXr2C3rzLgBeejcrWmHysTJFm/miXX7aTJa7tr3UnpRdxhVaomGgGKy7KS/DygnpNj7dRI9mtGZmsJnY6Rt/KYj8bmQBydaJPn8iA3CUnoIaRw2TcKNtjuBJk6ubMWD5nkKyliGyCmy+MMNTrR5fI5ZEnrRzkuEPWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099170; c=relaxed/simple;
	bh=bmINqsc6b3MMA1e3VlDRWRxMH+NaJAWN011cYU3fdWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRMTNcLKXU6VA8bD6Oady1yqJpCtUUt8Qg94NqMorJuQ2zg3/Z6IjsX/8jijc7kTWt18i8ebEIlxwPFhATnzh+EpqLV+Kr47DbdccLs8DCmxGpRQADU67KAwpE4Uixs3FYBjFtTDVTYFiefGCZMntkEetLH2UgG/x61mbHOOx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j06vYLb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D15C4CEE7;
	Tue,  4 Mar 2025 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099169;
	bh=bmINqsc6b3MMA1e3VlDRWRxMH+NaJAWN011cYU3fdWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j06vYLb2tLU8Wr4KIx94QOdHMy0M0E1di2ssVEIL/gPw1dADm33CZ+2Bnmax79Wyf
	 QIeBtA0W1k0BOYXVJY9NKuC/Xc676GRR5fp+s8z1UalnVn+IocZRdPfVXbmxwp1c9s
	 dcRgqY0TioXe/XFn9T8HcnKA/PGwqDpfXutnRBtBpmpUJ56nk4sVsf8ey4TsY1yUau
	 mAQ4Z4L0CtUAOt2mpMA3K+JuUhN1mo7R3nOo2njoQwDnRMlHbGKycUPyjm2zD76H5y
	 Yz0PvlckZMJi/d5B7vKAed/sE8aRlmJLaKmPhUKdyRKVG/zQpmf0iXVYs0QpMhoDKR
	 591WllA0rfiPw==
Date: Tue, 4 Mar 2025 06:39:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and
 RTM_DELROUTE to per-netns RTNL.
Message-ID: <20250304063928.48e43593@kernel.org>
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 20:23:16 -0800 Kuniyuki Iwashima wrote:
> Patch 1 is misc cleanup.
> Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().

I think there's another leak. Not 100% reproducible but one of the runs
of the device csum test hit:

unreferenced object 0xffff888005c35440 (size 1576):
  comm "csum", pid 366, jiffies 4294693057
  hex dump (first 32 bytes):
    c0 00 02 01 c0 00 02 02 00 00 00 00 84 d0 ff 00  ................
    02 00 01 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
  backtrace (crc 3c3950b5):
    kmem_cache_alloc_noprof+0x2ad/0x350
    sk_prot_alloc.constprop.0+0x4e/0x1b0
    sk_alloc+0x36/0x6c0
    inet_create.part.0.constprop.0+0x289/0xea0
    __sock_create+0x23c/0x6a0
    __sys_socket+0x11c/0x1e0
    __x64_sys_socket+0x72/0xb0
    do_syscall_64+0xc1/0x1d0
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/17921/2-csum-py/stdout

