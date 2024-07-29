Return-Path: <netdev+bounces-113760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7E93FCFD
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A328322E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B416F0E7;
	Mon, 29 Jul 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rX15RmzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62A83A09;
	Mon, 29 Jul 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276110; cv=none; b=eLJ9Iw7WUV6qBlku2rUd81XUtWIgqW8kWjsXFFA+1SfZ1MzZgNpXWTCOnCctD5wRQJooOLJeLW6leCrhUWqWhoGhSlpNK8JQW4k/qf7av23BiRiwWAwoHnYQynF+U2yyvx9ix18vuMtpurtcgs5ZZXM1fJSOfgz3vbayRLJo95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276110; c=relaxed/simple;
	bh=OlaJ4GQZRWxaFzdiAoNYSvxQh2Vi6hhvXcbPIHhuQSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXops7Ys568i6SkfbI/4K3WVZUC8bVaPH6Gz72HROEJGCbEH9pLtTixDw6XaXcwNcuS7LFYTj4M9aOfTeGNGHNNs2OWwjGix051h1T50QCWgJQMREgjThuwrlbVxc6ZI+QPa+hSYo/jMZlw9HA/X5uR9+Srkhedt0JK4GZSSkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rX15RmzZ; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722276109; x=1753812109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4QN7NgX3jCkknAIQAa+PRo8C1a02teQl7Gn3pR18DA=;
  b=rX15RmzZKxsW3EjbtQ6ic5/psA9y2sQouCR+TBmG7/5/eTb9UKRGBTt7
   JPleFvsERhBGkxVCb3kQ3QBaRKmbWdfqb4/72mA5o/KB5uxbtbgqwe3qf
   +ghqscuz2MVixJuAl5M4lw7Rt4z6fNnNKp5iOTMdq1/dzgRgFWRyicmub
   c=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="746140924"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:01:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:44390]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.228:2525] with esmtp (Farcaster)
 id bd754b9f-88c2-4965-9cf6-b1b464fb8991; Mon, 29 Jul 2024 18:01:42 +0000 (UTC)
X-Farcaster-Flow-ID: bd754b9f-88c2-4965-9cf6-b1b464fb8991
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 18:01:35 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 18:01:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lucien.xin@gmail.com>,
	<netdev@vger.kernel.org>, <nhorman@tuxdriver.com>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] general protection fault in reuseport_add_sock (3)
Date: Mon, 29 Jul 2024 11:01:22 -0700
Message-ID: <20240729180122.87990-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000ed7445061e65591f@google.com>
References: <000000000000ed7445061e65591f@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
Date: Mon, 29 Jul 2024 09:28:29 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    301927d2d2eb Merge tag 'for-net-2024-07-26' of git://git.k..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=17332fad980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0a623980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1538ac55980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cb9ce2729d35/disk-301927d2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/644eaaef61a5/vmlinux-301927d2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2f92322485c3/bzImage-301927d2.xz
> 
> The issue was bisected to:
> 
> commit 6ba84574026792ce33a40c7da721dea36d0f3973
> Author: Xin Long <lucien.xin@gmail.com>
> Date:   Mon Nov 12 10:27:17 2018 +0000
> 
>     sctp: process sk_reuseport in sctp_get_port_local
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ad25bd980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ad25bd980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ad25bd980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
> Fixes: 6ba845740267 ("sctp: process sk_reuseport in sctp_get_port_local")
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 UID: 0 PID: 10230 Comm: syz-executor119 Not tainted 6.10.0-syzkaller-12585-g301927d2d2eb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
> Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
> RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
> RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
> R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __sctp_hash_endpoint net/sctp/input.c:762 [inline]

Here we need to protect the other sk in the hash table as we do so for
TCP/UDP by taking the hash bucket lock.


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 1722389b0d863056d78287a120a1d6cadb8d4f7b

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 5a165286e4d8..b1614da1e41c 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -347,6 +347,8 @@ int reuseport_add_sock(struct sock *sk, struct sock *sk2, bool bind_inany)
 		return -EBUSY;
 	}
 
+	WARN_ON(!reuse);
+
 	if (reuse->num_socks + reuse->num_closed_socks == reuse->max_socks) {
 		reuse = reuseport_grow(reuse);
 		if (!reuse) {
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 17fcaa9b0df9..a8a254a5008e 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -735,15 +735,19 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
+	int err = 0;
 
 	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (sk->sk_reuseport) {
 		bool any = sctp_is_ep_boundall(sk);
 		struct sctp_endpoint *ep2;
 		struct list_head *list;
-		int cnt = 0, err = 1;
+		int cnt = 0;
+
+		err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
@@ -761,24 +765,24 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 			if (!err) {
 				err = reuseport_add_sock(sk, sk2, any);
 				if (err)
-					return err;
+					goto out;
 				break;
 			} else if (err < 0) {
-				return err;
+				goto out;
 			}
 		}
 
 		if (err) {
 			err = reuseport_alloc(sk, any);
 			if (err)
-				return err;
+				goto out;
 		}
 	}
 
-	write_lock(&head->lock);
 	hlist_add_head(&ep->node, &head->chain);
+out:
 	write_unlock(&head->lock);
-	return 0;
+	return err;
 }
 
 /* Add an endpoint to the hash. Local BH-safe. */
@@ -803,10 +807,9 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
-
-	write_lock(&head->lock);
 	hlist_del_init(&ep->node);
 	write_unlock(&head->lock);
 }

