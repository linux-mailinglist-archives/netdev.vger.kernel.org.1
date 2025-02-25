Return-Path: <netdev+bounces-169600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183C6A44B18
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D4C7ACDD1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A61A7045;
	Tue, 25 Feb 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E3wvSy/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415901993A3;
	Tue, 25 Feb 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510598; cv=none; b=Tx7ScLhV7tfWh76Z9090nj1lOvagowFD+WKaqLBbuV9vhflMcBN8PCdPoff2AthNEETqSnCX7viFPX3xyvUUlLwOD2gwvITQjlQSvFxF4PF+TlIStmf8Gxzq41k3DQ62LQ+vhKGzhkxKgWrna4sf34kjYZii0/4F77LKCxx1vUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510598; c=relaxed/simple;
	bh=D0R0gOP7f1rXDtUFelNCY9sIdTlCLQB5EjHfxs5aKI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2/1NXltKwupdFRW4HsQd/zlOcxcHiUvIP6R0x6CvLqJS7cUruEgQ3vurtFXVYBWCKZQIA1c5lIrGvl2RZwZ0J2N+Cx8ziXYWI+1+yB4WgMM1gIqZ9v0fNofluVKgKgdOVj2A2EzOwScrx+ZgdWNK1BgIVRpy7Ls6j6UUgyXGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E3wvSy/z; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740510597; x=1772046597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fAaDGD2JHhDlK7rhyevHUPzqoJBaFoz+baMHVW/dWFc=;
  b=E3wvSy/z6eFUrp1P9lNplRmoITyPDVkpFGWAvlRzQwLQ2dlwhUDGoQmS
   bxw1fG11+cXjLN2LQnjUAWwAjc7FDXNOh8SpPVts+uOESJCQOqrRfDDpA
   Z8Nk1l1ck4qm3bFRqDEZjEm0YbS4xX6S+2qNXPMpQnMtwlNxVJ0x227ov
   E=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="175875990"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 19:09:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:46435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id ef180c6f-5d64-4289-ac8a-d957de4ea901; Tue, 25 Feb 2025 19:09:55 +0000 (UTC)
X-Farcaster-Flow-ID: ef180c6f-5d64-4289-ac8a-d957de4ea901
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 19:09:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 19:09:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <adrianhuang0701@gmail.com>
CC: <ahuang12@lenovo.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Date: Tue, 25 Feb 2025 11:09:42 -0800
Message-ID: <20250225190942.79227-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225021457.1824-1-ahuang12@lenovo.com>
References: <20250225021457.1824-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Adrian Huang <adrianhuang0701@gmail.com>
Date: Tue, 25 Feb 2025 10:14:57 +0800
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> After running the 'sendmsg02' program of Linux Test Project (LTP),
> kmemleak reports the following memory leak:
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff888243866800 (size 2048):
>     comm "sendmsg02", pid 67, jiffies 4294903166
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
>       01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>     backtrace (crc 7e96a3f2):
>       kmemleak_alloc+0x56/0x90
>       kmem_cache_alloc_noprof+0x209/0x450
>       sk_prot_alloc.constprop.0+0x60/0x160
>       sk_alloc+0x32/0xc0
>       unix_create1+0x67/0x2b0
>       unix_create+0x47/0xa0
>       __sock_create+0x12e/0x200
>       __sys_socket+0x6d/0x100
>       __x64_sys_socket+0x1b/0x30
>       x64_sys_call+0x7e1/0x2140
>       do_syscall_64+0x54/0x110
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Commit 689c398885cc ("af_unix: Defer sock_put() to clean up path in
> unix_dgram_sendmsg().") defers sock_put() in the error handling path.
> However, it fails to account for the condition 'msg->msg_namelen != 0',
> resulting in a memory leak when the code jumps to the 'lookup' label.
> 
> Fix issue by calling sock_put() if 'msg->msg_namelen != 0' is met.
> 
> Fixes: 689c398885cc ("af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

