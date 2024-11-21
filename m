Return-Path: <netdev+bounces-146724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41989D54C4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF69B2152E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE81C232B;
	Thu, 21 Nov 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T8T0wYen"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1E1CB303
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224789; cv=none; b=c6csSzPoqArmFAsFPCf4ScRuOeQQ+992rEg/E06a+K9p88uCkX03UN2stvyp9v7/aIFVMdpfQzmnsDiGoFf12snNzNIhxBHwUrpS8kG/GDs6zz3+/iCAik84weXvbG4fOCHcEw8XACn4cAo9WVbCzqgsn8+3lua793fsjoCePIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224789; c=relaxed/simple;
	bh=WEvFzp5SH4QpWVEYdYyh46C9ZY1PXIggf4mG8vVMX4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BY8XFbK3gQQIeKQbYTuFGgO3rsoqZQPUZTh0290SAZgneD5o957oq83TCAgABHGgxL5a9qKtLHqOA7IV6M0P/Sw+UhRqM8L0OmwNVl/0bozc7nDuP791jRZqPGJwfATzPaWfO4K4+KzrVGLODCSgnQi63bnCdp7WwKJv0HBDlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T8T0wYen; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732224788; x=1763760788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AU+u7wmHDcjSiutO5DUCCodKLHz9f1fbXYhIBlkSCbE=;
  b=T8T0wYenYxNe0dn6ner/3YR+cm6l6zFFr2she1N71ETsiVFbvB6u0gz3
   hT23kNQwg5zKj5AsEXR5X9hFIdwtiSFpfucMuo/7OMy9OxWAk4lGKVMWu
   7i8tduQzlK8KWPgkeeowZKoPBlPghZry8VkZjRd4/VHfQT5VXhSLl4Dtm
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,173,1728950400"; 
   d="scan'208";a="146946030"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 21:33:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:46688]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 0b19634a-e8ba-4462-a5fa-e5ef5686d7e0; Thu, 21 Nov 2024 21:33:05 +0000 (UTC)
X-Farcaster-Flow-ID: 0b19634a-e8ba-4462-a5fa-e5ef5686d7e0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 21 Nov 2024 21:33:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 21 Nov 2024 21:33:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH net] rtnetlink: fix rtnl_dump_ifinfo() error path
Date: Thu, 21 Nov 2024 13:32:56 -0800
Message-ID: <20241121213256.35057-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241121194105.3632507-1-edumazet@google.com>
References: <20241121194105.3632507-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Nov 2024 19:41:05 +0000
> syzbot found that rtnl_dump_ifinfo() could return with a lock held [1]
> 
> Move code around so that rtnl_link_ops_put() and put_net()
> can be called at the end of this function.
> 
> [1]
> WARNING: lock held when returning to user space!
> 6.12.0-rc7-syzkaller-01681-g38f83a57aa8e #0 Not tainted
> syz-executor399/5841 is leaving the kernel with locks still held!
> 1 lock held by syz-executor399/5841:
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
> 
> Fixes: 43c7ce69d28e ("rtnetlink: Protect struct rtnl_link_ops with SRCU.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I missed the error paths, thanks!

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

