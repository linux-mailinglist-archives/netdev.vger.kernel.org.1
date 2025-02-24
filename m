Return-Path: <netdev+bounces-169157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BECA42BCA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AEC179B78
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017926657E;
	Mon, 24 Feb 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tz7V9Gvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE481266184;
	Mon, 24 Feb 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422467; cv=none; b=iT7rZ3//Q2o7LdPTcItJDYUXsFADCkMyvqMXlG0EtRas3FIC7pBkqsON4FSofU/E6AGuuz6YKDC4fCyehVsMWpVOfsWbz9YwR4mMv1EnkdEZZp4y6PZo637sDBS21Od4ctiPlmYGKFqCLRcJBLSb1hTPButrQ3TB1eVYu26tcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422467; c=relaxed/simple;
	bh=cphWkFLix8d6i9Z1K5YLAhd8RuvGZJxPpG66vWFcP9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ma2GxsX90yDOSdFZnQGaFzJKp7VJsbdy3hETaMfuUkzrjtAEjA2AJlL5yV0A4WS/oNKyYU8mv/UxjMAsGciOUHZRLJWnw9+YM2nychmxw/69hoqZ7JnhrGeuQAkiGrgUEiKbTuZ4ZnI+/hAZIxxXKlE/cDNZ1tBOTAPZzkDdyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tz7V9Gvt; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740422465; x=1771958465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEFCqhcG8wpp885eIFR7TiqnC7q8YedBfxREnJ154Sw=;
  b=Tz7V9Gvtq+acp7yDcAaZaDUPN90lIxX0CvaVK+dRLXNNxH9+ShbD3Gwm
   iwFLjNq+/UpC2xD3nVwBdfHoBgKx5uQjltA5nNEgfiD6XQPHZ7coI2b2i
   dA+0E5yf34jWyD4S7qr8jda82gsxXUDb2H2nJ6mcl+s/tRXQh08RNKr+k
   o=;
X-IronPort-AV: E=Sophos;i="6.13,312,1732579200"; 
   d="scan'208";a="68815604"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:41:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:29075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id 329f09ea-1828-467a-b87d-a103d2ae36e4; Mon, 24 Feb 2025 18:41:00 +0000 (UTC)
X-Farcaster-Flow-ID: 329f09ea-1828-467a-b87d-a103d2ae36e4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 18:40:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.221.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 18:40:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <adrianhuang0701@gmail.com>
CC: <ahuang12@lenovo.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Date: Mon, 24 Feb 2025 10:40:45 -0800
Message-ID: <20250224184045.74801-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224152846.13650-1-ahuang12@lenovo.com>
References: <20250224152846.13650-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Adrian Huang <adrianhuang0701@gmail.com>
Date: Mon, 24 Feb 2025 23:28:46 +0800
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
> ---
>  net/unix/af_unix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1fb1f..cf37a1f92831 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2100,6 +2100,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  		if (!msg->msg_namelen) {
>  			err = -ECONNRESET;
>  			goto out_sock_put;
> +		} else {
> +			sock_put(other);
>  		}
>  
>  		goto lookup;

nit: else is not needed:

	if (!msg->msg_namelen) {
		err = -ECONNRESET;
		goto out_sock_put;
	}

	sock_put(other);
	goto lookup;

Thanks!

