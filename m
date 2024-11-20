Return-Path: <netdev+bounces-146372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F77B9D3242
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82251F24778
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3A2EAEA;
	Wed, 20 Nov 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="epsGOD7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B1193;
	Wed, 20 Nov 2024 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070324; cv=none; b=FLv/S2huXTfgSi/xiESImYe4vAMNQigTKaOfQfy52riaveqYjgFEPJeW8F+1K8u+4rd7A1jmI2OThzYkHyW/536YrlJhDQnJF49XUGNfKv6ReuHTiAeCHQkwkN4iUY8OExB4Fi9gO5/XnkL3zAEKkd5UBhP5B1IBdWOYaSgPoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070324; c=relaxed/simple;
	bh=XkT3o/i+NwiMJ1655TnGy+Dtho9myHtNkEHiHcVhO7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIduFPp4k/+XW6lMCeWaWG3XkxhWA1C8yWpxIPAFFuxKL6OBhPI+AoMgB1wgBMnWRrG05CAzB0NxT1WAAFSoSeJA6zwbNRMx4Rgx5OL6miPpjMz1T7euX5NuOYUWN/HzunFLvDn+NiylUG2xis0RID/rzcuGBLzmdi/1KcHmr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=epsGOD7A; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732070323; x=1763606323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=teKkpS7Y1Tw9w8clUF79MJIV3A5m/Qb9nzaptFzGyzo=;
  b=epsGOD7A8t71Xout8ZJX9D7pKcOqL5Ma7b5CEpO5PEjBP/zLQSUCQbKB
   LG8bXXFfQPPgzBa9SsoxTqcO6phlEQKPwycCi9Eh+6weIpWmuCwxES3ST
   WOL9yqgOmf2MRQK34mpzgPaPPRqjf+gUYn5O8fe6iX8yg3bAMoxRc9qYO
   8=;
X-IronPort-AV: E=Sophos;i="6.12,168,1728950400"; 
   d="scan'208";a="777087469"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 02:38:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:12421]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 08d44827-056b-4fa3-8ef7-6ec67820fb81; Wed, 20 Nov 2024 02:38:34 +0000 (UTC)
X-Farcaster-Flow-ID: 08d44827-056b-4fa3-8ef7-6ec67820fb81
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 20 Nov 2024 02:38:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.75.102) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 20 Nov 2024 02:38:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mengkanglai2@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<fengtao40@huawei.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <yanan@huawei.com>
Subject: Re: kernel tcp sockets stuck in FIN_WAIT1 after call tcp_close
Date: Tue, 19 Nov 2024 18:38:28 -0800
Message-ID: <20241120023828.907-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <d46151818b694dc79b488061817d3d73@huawei.com>
References: <d46151818b694dc79b488061817d3d73@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: mengkanglai <mengkanglai2@huawei.com>
Date: Tue, 19 Nov 2024 08:38:26 +0000
> > 
> > From: mengkanglai <mengkanglai2@huawei.com>
> > Date: Wed, 13 Nov 2024 12:40:34 +0000
> > > Hello, Eric:
> > > Commit 151c9c724d05 (tcp: properly terminate timers for kernel 
> > > sockets) introduce inet_csk_clear_xmit_timers_sync in tcp_close.
> > > For kernel sockets it does not hold sk->sk_net_refcnt, if this is 
> > > kernel tcp socket it will call tcp_send_fin in __tcp_close to send FIN 
> > > packet to remotes server,
> > 
> > Just curious which subsystem the kernel socket is created by.
> > 
> > Recently, CIFS and sunrpc are (being) converted to hold net refcnt.
> > 
> > CIFS: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef7134c7fc48e1441b398e55a862232868a6f0a7
> > sunrpc: https://lore.kernel.org/netdev/20241112135434.803890-1-liujian56@huawei.com/
> > 
> > I remember RDS's listener does not hold refcnt but other client sockets (SMC, RDS, MPTCP, CIFS, sunrpc) do.
> > 
> > I think all TCP kernel sockets should hold netns refcnt except for one created at pernet_operations.init() hook like RDS.
> > 
> > > if this fin packet lost due to network faults, tcp should retransmit 
> > > this fin packet, but tcp_timer stopped by inet_csk_clear_xmit_timers_sync.
> > > tcp sockets state will stuck in FIN_WAIT1 and never go away. I think 
> > > it's not right.
> 
> 
> I found this problem when testing nfs. sunrpc: https://lore.kernel.org/netdev/20241112135434.803890-1-liujian56@huawei.com/ will solve this problem. 
> I agree with that all TCP kernel sockets should hold netns refcnt.
> However, for kernel tcp sockets created by other kernel modules through
> sock_create_kern or sk_alloc(kern=0),

In the next cycle, I'll rename sock_create_kern() to sock_create_net_noref()
and add sock_create_net() so that out-of-tree module will fail to build and
such users will notice sock_create_net_noref() would trigger an issue.

https://github.com/q2ven/linux/commits/427_2


> it means that they must now hold
> sk_net_refcnf, otherwise fin will only be sent once and will not be
> retransmitted when the socket is released.But other use tcp modules may
> not be aware of hold sk_net_refcnt. should we add a check in tcp_close？

The check doesn't fix the issue for in-netns users.

I'd rather print the allocator and change it to use
sock_create_net() instead.

---8<---
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..7d6a1faa05a3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3220,8 +3220,12 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
 	if (!sk->sk_net_refcnt)
-		inet_csk_clear_xmit_timers_sync(sk);
+		stack_depot_print(sk->ns_tracker);
+#endif
+
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
---8<---

> 
> ---
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fb920369c..6b92026a4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2804,7 +2804,7 @@ void tcp_close(struct sock *sk, long timeout)
>         lock_sock(sk);
>         __tcp_close(sk, timeout);
>         release_sock(sk);
> -       if (!sk->sk_net_refcnt)
> +       if (sk->net != &init_net && !sk->sk_net_refcnt)
>                 inet_csk_clear_xmit_timers_sync(sk);
>         sock_put(sk);
>  }

