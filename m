Return-Path: <netdev+bounces-52897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D88009C5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28931F20ED2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1D221345;
	Fri,  1 Dec 2023 11:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 03:18:33 PST
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DA2695
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 03:18:32 -0800 (PST)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.95])
	by sina.com (172.16.235.25) with ESMTP
	id 6569BFBF0000234E; Fri, 1 Dec 2023 19:13:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 17365334210190
X-SMAIL-UIID: 1EBE428C27F64FC68BE7DFEF2B933622-20231201-191306-1
From: Hillf Danton <hdanton@sina.com>
To: xingwei lee <xrivendell7@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
Date: Fri,  1 Dec 2023 19:12:53 +0800
Message-Id: <20231201111253.1029-1-hdanton@sina.com>
In-Reply-To: <CABOYnLzq7XwbFncos1p8FOnDyVes4VDkjWE277TngdJqSie14A@mail.gmail.com>
References: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 1 Dec 2023 08:39:32 +0800 xingwei lee <xrivendell7@gmail.com>
> I forgot to CC others, repeat mail.
> Sorry, Dumazet. I found this bug with my modified syzkaller in my
> local environment.
> You are right, I crashed this bug about 10 times and used some
> heuristic solutions to increase the chances of luck with modifying
> syz-repro during this process.
> I can confirm the reproduction can trigger the bug soon and I hope it helps you.
> I'll test your patch and give your feedback ASAP.
> 
> I apply your patch at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b47bc037bd44f142ac09848e8d3ecccc726be99
> with a little fix:
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fef349dd72fa..36d2871ac24f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)
> 
>         if (likely(sk->sk_net_refcnt))
>                 put_net_track(sock_net(sk), &sk->ns_tracker);
> -       else
> -               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
> 
>         sk_prot_free(sk->sk_prot_creator, sk);
>  }
> @@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
>                 use_call_rcu = true;
>         }
> 
> +       if (unlikely(!sk->sk_net_refcnt))
> +               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
> +
>         if (use_call_rcu)
>                 call_rcu(&sk->sk_rcu, __sk_destruct);
>         else
> 
> and It's also trigger the crash like below:

Looks like a refcount leak that could be cured with the diff below.
Only for thoughts.

--- x/include/net/net_namespace.h
+++ y/include/net/net_namespace.h
@@ -320,7 +320,7 @@ static inline int check_net(const struct
 	return 1;
 }
 
-#define net_drop_ns NULL
+static void net_drop_ns(void *w) { }
 #endif
 
 
@@ -355,7 +355,7 @@ static inline void __netns_tracker_free(
 static inline struct net *get_net_track(struct net *net,
 					netns_tracker *tracker, gfp_t gfp)
 {
-	get_net(net);
+	refcount_inc(&net->passive);
 	netns_tracker_alloc(net, tracker, gfp);
 	return net;
 }
@@ -363,7 +363,7 @@ static inline struct net *get_net_track(
 static inline void put_net_track(struct net *net, netns_tracker *tracker)
 {
 	__netns_tracker_free(net, tracker, true);
-	put_net(net);
+	net_drop_ns(net);
 }
 
 typedef struct {
--

