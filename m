Return-Path: <netdev+bounces-171812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3444A4EC77
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DDA1882CEF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41921D63F8;
	Tue,  4 Mar 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fyNQrOUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749A1F583E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114192; cv=none; b=t4LUzQ4NgCZsL9OZOkf2ORkX0RceTQ2CKTx5678g44Y/R7uJ1vxGUei31Hy9kvBs6156EPJ/p/2uGjK6OwwTfUFHXyp2ozQ89RV3p/wBpZOQ4ZaZU3KYAwNdvQpOTL8s1ZzZfqoamIEsme94aPmWEXiFAacPyc2ruh3cht3dTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114192; c=relaxed/simple;
	bh=jwlOKulsBSMuF4MDnFuU985NWfYShzTdreneh24Y0ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts2c3eIBMEO8Qcd2/DVLG8FFepVdVxvVUpKRgUGboeIEXqOK6sOeSTzHu1b2x6PuXOHRS3FolW8NgL/wmeKxkJav0FJRJbILdHkg0KTp6scgcM4fGx2iBIta/5sHpn4fTtsQidybNG1qnafPFticfnn/NAPKiIQWh/DDtyIl0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fyNQrOUU; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741114191; x=1772650191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25iuFOzGy0yAeSj+qO54x2p6UzgOf3KWTrAzRDVIoiA=;
  b=fyNQrOUUFY296ytP6v8ZF4afzR2W0klbmcItFNXdlHPqemBM6kPmwzY8
   7CGI1l/MwA0qRNdeHmfBmXu+gOyrz3hrRU3R+wSFdOgNdNpFNl3o5Btpw
   A9AuzhF5H4OyuT872j5/EcRjc/5P1A3xz5waFjjMi6K1afzvuiPb3Qv04
   0=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="477334730"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:49:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.102:2525] with esmtp (Farcaster)
 id 8015db65-e005-476b-90c8-8f62002c137e; Tue, 4 Mar 2025 18:49:45 +0000 (UTC)
X-Farcaster-Flow-ID: 8015db65-e005-476b-90c8-8f62002c137e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 18:49:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.149.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 18:49:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Tue, 4 Mar 2025 10:49:13 -0800
Message-ID: <20250304184919.13080-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304063928.48e43593@kernel.org>
References: <20250304063928.48e43593@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 4 Mar 2025 06:39:28 -0800
> On Thu, 27 Feb 2025 20:23:16 -0800 Kuniyuki Iwashima wrote:
> > Patch 1 is misc cleanup.
> > Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> > Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().
> 
> I think there's another leak. Not 100% reproducible but one of the runs
> of the device csum test hit:

Looks like v6 sk is also leaked...
Will try csum test.

Thanks!


> 
> unreferenced object 0xffff888005c35440 (size 1576):
>   comm "csum", pid 366, jiffies 4294693057
>   hex dump (first 32 bytes):
>     c0 00 02 01 c0 00 02 02 00 00 00 00 84 d0 ff 00  ................
>     02 00 01 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
>   backtrace (crc 3c3950b5):
>     kmem_cache_alloc_noprof+0x2ad/0x350
>     sk_prot_alloc.constprop.0+0x4e/0x1b0
>     sk_alloc+0x36/0x6c0
>     inet_create.part.0.constprop.0+0x289/0xea0
>     __sock_create+0x23c/0x6a0
>     __sys_socket+0x11c/0x1e0
>     __x64_sys_socket+0x72/0xb0
>     do_syscall_64+0xc1/0x1d0
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/17921/2-csum-py/stdout

