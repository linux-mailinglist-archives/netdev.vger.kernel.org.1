Return-Path: <netdev+bounces-102638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5289040F8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1DD285F3E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32643BBF5;
	Tue, 11 Jun 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TABqq9Ew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00E3B192
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122514; cv=none; b=HZxusHddTxWyQn6yLOQFIKfMRUUZhb62Lnf0xRTop5syJyEonRgIYJXvxIS27jKOCB4uupT9ombFR1O+C2kONypiAw5oPAJF4bQ+LYyzcrXJFi69T/N7zHEdx+TwV2FFZJcThWW11l+rLj4c5uyBei/R2XbVpr3HHEXyJROGuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122514; c=relaxed/simple;
	bh=glQOjoBawIJcDc2jQr3OtFk6u03KK3YjhKP6JHNjXWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUh/FAasmPv2pnSzSz74Byc4CVprqlhhiRZ9iPglpI0BawfY62FBEMjnmOdYVUAY+uIOimhtsnW7BhgnbIpCx4XaiBMXT9V3TyTmqyhsqpcVbmDsOAFEqXEpB+HIAhCOfM+HF5KhCfRJiGrZjLKVvaa//7eIlHp9ygzzEmGBKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TABqq9Ew; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718122513; x=1749658513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hku4vF0q7JNZdPOGUsWbE9U8mAVqDyY9RXGfKEHu2yU=;
  b=TABqq9EwTCRIw9uxzwWxUoiI+iLKHZzdz/x2fA5bM2j67x4qdhAd/2MU
   sE5wmwrEnCqA0I1YLk8UtmWGAUDtWrTCxnjJC1nJQ2SEyeq11YqRjFiWD
   3vzLrl+IqHNgrdepfOMT4SE8i5RTX0gIcgU53yi7290R/u0OWUm+UmWge
   w=;
X-IronPort-AV: E=Sophos;i="6.08,230,1712620800"; 
   d="scan'208";a="211119288"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 16:15:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:37256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.168:2525] with esmtp (Farcaster)
 id 3fe6ede5-e458-4ba3-a75d-2fd4257a8221; Tue, 11 Jun 2024 16:15:09 +0000 (UTC)
X-Farcaster-Flow-ID: 3fe6ede5-e458-4ba3-a75d-2fd4257a8221
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 16:15:09 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 16:15:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v6] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Tue, 11 Jun 2024 09:14:56 -0700
Message-ID: <20240611161456.86102-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611084639.2248934-1-Rao.Shoaib@oracle.com>
References: <20240611084639.2248934-1-Rao.Shoaib@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <Rao.Shoaib@oracle.com>
Date: Tue, 11 Jun 2024 01:46:39 -0700
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
> >>> from socket import *
> >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> >>> c2.setsockopt(SOL_SOCKET, SO_OOBINLINE, 1)
> >>> c1.send(b'a', MSG_OOB)
> 1
> >>> c1.send(b'b')
> 1
> >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'a'
> >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'a'
> >>> c2.recv(1, MSG_DONTWAIT)
> b'a'
> >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'b'
> >>>
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>

No newline is needed here, but I think it isn't worth v7
and can be fixed during merge.


> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/unix/af_unix.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 80846279de9f..5e695a9a609c 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2625,18 +2625,18 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  		if (skb == u->oob_skb) {
>  			if (copied) {
>  				skb = NULL;
> -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
> -				if (!(flags & MSG_PEEK)) {
> +			} else if (!(flags & MSG_PEEK)) {
> +				if (sock_flag(sk, SOCK_URGINLINE)) {
>  					WRITE_ONCE(u->oob_skb, NULL);
>  					consume_skb(skb);
> +				} else {
> +					__skb_unlink(skb, &sk->sk_receive_queue);
> +					WRITE_ONCE(u->oob_skb, NULL);
> +					unlinked_skb = skb;
> +					skb = skb_peek(&sk->sk_receive_queue);
>  				}
> -			} else if (flags & MSG_PEEK) {
> -				skb = NULL;
> -			} else {
> -				__skb_unlink(skb, &sk->sk_receive_queue);
> -				WRITE_ONCE(u->oob_skb, NULL);
> -				unlinked_skb = skb;
> -				skb = skb_peek(&sk->sk_receive_queue);
> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> +				skb = skb_peek_next(skb, &sk->sk_receive_queue);
>  			}
>  		}
>  
> -- 
> 2.39.3

