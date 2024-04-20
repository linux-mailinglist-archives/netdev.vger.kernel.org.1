Return-Path: <netdev+bounces-89768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A677B8AB827
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 02:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA78EB2150B
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEC1113;
	Sat, 20 Apr 2024 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FZC2fMiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57018BE5
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573386; cv=none; b=TjMtNNMPWH136VlkLgvlXkl0KB6lU7pvSDECaqcqpNvooSo8hxT+3Q29bdtgioARI8f8uzaLBBaeb3GHdkO/LH5zeZI+gYu4r6e3m4e2aZH58jE2Gkqu6kXDYwTw7C7hzCWHy8pPzPxPcvL9W8ShX02Fu8tuvaZ3aUijGx39ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573386; c=relaxed/simple;
	bh=QgiWup8um0voOFJ3QrT3viTwgJwfLd1MgGNDMe1Qa1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVYM3kaGBJqr4NT96xn7w1KIixpRvEeXG4n8s/WphXPBjlB/nog3KAo56z1CWAQtEzahApYPrYnYVj0YfR0FVnHb829qYy9uXBJ55dz/fG+meCIvd39hwxIa/hhdowwo1Kzcsak0/mYhgT/5skaX31P5nnHxYCIp6GYTDQTJ1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FZC2fMiF; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713573384; x=1745109384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yC80yhWlkIqx12U7LW3IIV8pZKdEMfa2Kyhud8ShzuU=;
  b=FZC2fMiFHaYvshd1Lk+Z9at0DSU+Z1zDi9XQOtfEbN0pFmoeSmHfsb9J
   jWFmZ+pDAHpaVyKbWvZYHd1HmvTolBAO8t9Fp1dvKlGteiC09YZUJSuzi
   mI565amxrD3M4K7cB0jJaMlTm/BoNdUVfoKctoKOJeVFc6VJ/bZ77tpif
   0=;
X-IronPort-AV: E=Sophos;i="6.07,215,1708387200"; 
   d="scan'208";a="82768195"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 00:36:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:52400]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.123:2525] with esmtp (Farcaster)
 id d1c42423-cc03-44d8-b5d5-6c9f3db85a24; Sat, 20 Apr 2024 00:36:24 +0000 (UTC)
X-Farcaster-Flow-ID: d1c42423-cc03-44d8-b5d5-6c9f3db85a24
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 20 Apr 2024 00:36:23 +0000
Received: from 88665a182662.ant.amazon.com (10.119.231.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 20 Apr 2024 00:36:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Fri, 19 Apr 2024 17:36:13 -0700
Message-ID: <20240420003613.35749-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CH3PR10MB683386BD63824096BF86BA9DEF0D2@CH3PR10MB6833.namprd10.prod.outlook.com>
References: <CH3PR10MB683386BD63824096BF86BA9DEF0D2@CH3PR10MB6833.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Fri, 19 Apr 2024 04:46:32 +0000
> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
> addresses the loop issue but does not address the issue that no data
> beyond OOB byte can be read.
> 
> >>> from socket import *
> >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> >>> c1.send(b'a', MSG_OOB)
> 1
> >>> c1.send(b'b')
> 1
> >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'b'
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> ---
>  net/unix/af_unix.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..8928f1f496f4 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2658,19 +2658,20 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>                 if (skb == u->oob_skb) {
>                         if (copied) {
>                                 skb = NULL;
> -                       } else if (sock_flag(sk, SOCK_URGINLINE)) {

The patch does not apply cleanly on net.git probably because tab was
replaced by spaces ?

Could you check your mail client config and repost v2 to make patchwork
happy ?

https://patchwork.kernel.org/project/netdevbpf/patch/CH3PR10MB683386BD63824096BF86BA9DEF0D2@CH3PR10MB6833.namprd10.prod.outlook.com/



> -                               if (!(flags & MSG_PEEK)) {
> +                       } else if (!(flags & MSG_PEEK)) {
> +                               if (sock_flag(sk, SOCK_URGINLINE)) {
>                                         WRITE_ONCE(u->oob_skb, NULL);
>                                         consume_skb(skb);
> +                               } else {
> +                                       skb_unlink(skb, &sk->sk_receive_queue);
> +                                       WRITE_ONCE(u->oob_skb, NULL);
> +                                       if (!WARN_ON_ONCE(skb_unref(skb)))
> +                                               kfree_skb(skb);
> +                                       skb = skb_peek(&sk->sk_receive_queue);
>                                 }
> -                       } else if (flags & MSG_PEEK) {
> -                               skb = NULL;
>                         } else {
> -                               skb_unlink(skb, &sk->sk_receive_queue);
> -                               WRITE_ONCE(u->oob_skb, NULL);
> -                               if (!WARN_ON_ONCE(skb_unref(skb)))
> -                                       kfree_skb(skb);
> -                               skb = skb_peek(&sk->sk_receive_queue);
> +                               if (!sock_flag(sk, SOCK_URGINLINE))

This can be `else if` to avoid another nesting here.


> +                                       skb = skb_peek_next(skb, &sk->sk_receive_queue);
>                         }
>                 }
>         }
> @@ -2747,9 +2748,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>                 if (skb) {
>                         skb = manage_oob(skb, sk, flags, copied);
> -                       if (!skb && copied) {
> +                       if (!skb) {
>                                 unix_state_unlock(sk);
> -                               break;
> +                               if (copied || (flags & MSG_PEEK))
> +                                       break;
> +                               goto redo;
>                         }
>                 }
>  #endif
> -- 
> 2.39.3

