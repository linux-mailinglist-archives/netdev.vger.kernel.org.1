Return-Path: <netdev+bounces-140934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD49B8B33
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9214628251B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE314B97E;
	Fri,  1 Nov 2024 06:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C12AD20;
	Fri,  1 Nov 2024 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730442301; cv=none; b=WsyQq5p+rp5j55dPrV+8iZoA0SMA/tHzlGHQ8c2OX8uNdD4k2y+ltvuM9Szxy4dhrjU8ikx8oGA1LApWJL1lrZXjZx8GK6azezEzNAVMvzP5DyWhPELffsSbO/G7pWovvcQNt9DRnbQCQLyh2vyBilAPHLH0r3FW4dP9fi3SSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730442301; c=relaxed/simple;
	bh=g2hRf7mnB2xJ3tmxFSkGiernG4bpg+/LT5R0E4trLtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=juecyKBFIFU7gbiR0UV/hBfqcPbG9yE+FsCxXUcIqrmSY68ri12XZywQijagRKwVhwiZvo64I3gpdsl9GznWXNNFH7gttQTbrd1gxRYbCxL0FCFg0LglFWcaw0ju94DnFZ5kMSiUVxNKxQGVUIEzYYCXATfPqFmg/zNIcBSMnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XfrPp054qz1T9Qw;
	Fri,  1 Nov 2024 14:22:38 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 366F71800A5;
	Fri,  1 Nov 2024 14:24:51 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 14:24:50 +0800
Message-ID: <0913d4ba-7298-4295-8ce0-8c38ddb9d5b6@huawei.com>
Date: Fri, 1 Nov 2024 14:24:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net] net: fix data-races around sk->sk_forward_alloc
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <dsahern@kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241031122344.2148586-1-wangliang74@huawei.com>
 <CANn89i+KL0=p2mchoZCOsZ1YoF9xhoUoubkub6YyLOY2wpSJtg@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CANn89i+KL0=p2mchoZCOsZ1YoF9xhoUoubkub6YyLOY2wpSJtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2024/10/31 22:08, Eric Dumazet 写道:
> On Thu, Oct 31, 2024 at 1:06 PM Wang Liang <wangliang74@huawei.com> wrote:
>> Syzkaller reported this warning:
> Was this a public report ?
Yes，I find the report here (the C repo in the url is useful):

https://syzkaller.appspot.com/bug?id=3e9b62ff331dcc3a6c28c41207f3b9911828a46b
>> [   65.568203][    C0] ------------[ cut here ]------------
>> [   65.569339][    C0] WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>> [   65.575017][    C0] Modules linked in:
>> [   65.575699][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>> [   ...]
> Oh the horror, this is completely wrong and unsafe anyway.
>
> TCP listen path MUST be lockless, and stay lockless.
>
> Ask yourself : Why would a listener even hold a pktoptions in the first place ?
>
> Normally, each request socket can hold an ireq->pktopts (see in
> tcp_v6_init_req())
>
> The skb_clone_and_charge_r() happen later in tcp_v6_syn_recv_sock()
>
> The correct fix is to _not_ call skb_clone_and_charge_r() for a
> listener socket, of course, this never made _any_ sense.
>
> The following patch should fix both TCP  and DCCP, and as a bonus make
> TCP SYN processing faster
> for listeners requesting these IPV6_PKTOPTIONS things.
Thank you very much for your suggestion and patch!

However, the problem remains unsolved when I use the following patch to 
test.

Because skb_clone_and_charge_r() is still called when sk_state is 
TCP_LISTEN in discard tag.

So I modify the patch like this (it works after local test):

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index da5dba120bc9..2d07f7385783 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -618,7 +618,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct 
sk_buff *skb)
            by tcp. Feel free to propose better solution.
                                                --ANK (980728)
          */
-       if (np->rxopt.all)
+       if (np->rxopt.all && (sk->sk_state != DCCP_LISTEN))
                 opt_skb = skb_clone_and_charge_r(skb, sk);

         if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d71ab4e1efe1..0ab06ed78cac 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1618,7 +1618,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff 
*skb)
            by tcp. Feel free to propose better solution.
                                                --ANK (980728)
          */
-       if (np->rxopt.all)
+       if (np->rxopt.all && (sk->sk_state != TCP_LISTEN))
                 opt_skb = skb_clone_and_charge_r(skb, sk);

         if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
@@ -1656,8 +1656,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff 
*skb)
                                 if (reason)
                                         goto reset;
                         }
-                       if (opt_skb)
-                               __kfree_skb(opt_skb);
                         return 0;
                 }
         } else


> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index da5dba120bc9a55c5fd9d6feda791b0ffc887423..d6649246188d72b3df6c74750779b7aa5910dcb7
> 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -618,7 +618,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct
> sk_buff *skb)
>             by tcp. Feel free to propose better solution.
>                                                 --ANK (980728)
>           */
> -       if (np->rxopt.all)
> +       if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
>                  opt_skb = skb_clone_and_charge_r(skb, sk);
>
>          if (sk->sk_state == DCCP_OPEN) { /* Fast path */
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d71ab4e1efe1c6598cf3d3e4334adf0881064ce9..e643dbaec9ccc92eb2d9103baf185c957ad1dd2e
> 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1605,25 +1605,12 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>           *      is currently called with bh processing disabled.
>           */
>
> -       /* Do Stevens' IPV6_PKTOPTIONS.
> -
> -          Yes, guys, it is the only place in our code, where we
> -          may make it not affecting IPv4.
> -          The rest of code is protocol independent,
> -          and I do not like idea to uglify IPv4.
> -
> -          Actually, all the idea behind IPV6_PKTOPTIONS
> -          looks not very well thought. For now we latch
> -          options, received in the last packet, enqueued
> -          by tcp. Feel free to propose better solution.
> -                                              --ANK (980728)
> -        */
> -       if (np->rxopt.all)
> -               opt_skb = skb_clone_and_charge_r(skb, sk);
>
>          if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
>                  struct dst_entry *dst;
>
> +               if (np->rxopt.all)
> +                       opt_skb = skb_clone_and_charge_r(skb, sk);
>                  dst = rcu_dereference_protected(sk->sk_rx_dst,
>                                                  lockdep_sock_is_held(sk));
>
> @@ -1656,13 +1643,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>                                  if (reason)
>                                          goto reset;
>                          }
> -                       if (opt_skb)
> -                               __kfree_skb(opt_skb);
>                          return 0;
>                  }
>          } else
>                  sock_rps_save_rxhash(sk, skb);
>
> +       if (np->rxopt.all)
> +               opt_skb = skb_clone_and_charge_r(skb, sk);
>          reason = tcp_rcv_state_process(sk, skb);
>          if (reason)
>                  goto reset;

