Return-Path: <netdev+bounces-92802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BF8B8E95
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D921F245EC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082FF11CBD;
	Wed,  1 May 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KGz9gy3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91106DDAB
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582557; cv=none; b=Ow9oWQqObhCM9YM2HE3xcdJMer+RKru8DJJhi6F1fw6ev1H5H4jTsMXKZ67GNdbYzQDzDNAzKwKYrgzaIwqwkIhbDe+tBY9P4OMEJG5V4SbhiMbM0qc0NQkePTD7wX2uUx3JTEVQCLIzLqxmVvIxIhVRo9HO+zgpsTSopSAtmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582557; c=relaxed/simple;
	bh=itp1ydTG4w4D3nb8/7bxb9wTam7D33gJ/Lbl1BVEAPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5esXTFs2IOgdRisPy3zRcNTPUh996QxuEc9OqFAJaLDMHLtGLWJjyjvKeyvBA6ZOEhRiJ3LpY/cfxZg+VG3rGxs9urrXNo+Ou8lSdXSzVWizIANgsQIsBOU2Xpoqp6wd8fi692uuXdbu+wXx+V8QYhDd6rtQ5OXMNW3P3+1q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KGz9gy3/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714582557; x=1746118557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhNljRPOzYvRX3XU7p76yj4fs7iYZ6efTlzLU4zgIRM=;
  b=KGz9gy3/QI0tg7jGi9J+noUDsfhqDrsE6v1xAtVz3F1biQnQ7FDIhXKH
   5KE2g2xL/zQksFJ/bwwYgUpDkYeDPX+wqJ0caEouCJz4VTugvjoMD1NHu
   qY6fx+tzy1uzwuT3L/V72srt3ACi8OCamD+Sgk5qdcLYOBWRD8VDHKZ1A
   A=;
X-IronPort-AV: E=Sophos;i="6.07,245,1708387200"; 
   d="scan'208";a="722791113"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:55:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:5903]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id 1c7bae78-f8c4-425b-88b9-06ca9a8bd5ae; Wed, 1 May 2024 16:55:49 +0000 (UTC)
X-Farcaster-Flow-ID: 1c7bae78-f8c4-425b-88b9-06ca9a8bd5ae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 16:55:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 16:55:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v4] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Wed, 1 May 2024 09:55:33 -0700
Message-ID: <20240501165533.24953-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZjCozXP/DBt/C8WZ@shoaib-laptop>
References: <ZjCozXP/DBt/C8WZ@shoaib-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <Rao.Shoaib@oracle.com>
Date: Tue, 30 Apr 2024 01:16:13 -0700
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
>  net/unix/af_unix.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..e88ec8744329 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
> +					skb_unlink(skb, &sk->sk_receive_queue);
> +					WRITE_ONCE(u->oob_skb, NULL);
> +					if (!WARN_ON_ONCE(skb_unref(skb)))
> +						kfree_skb(skb);
> +					skb = skb_peek(&sk->sk_receive_queue);
>  				}
> -			} else if (flags & MSG_PEEK) {
> -				skb = NULL;
> -			} else {
> -				skb_unlink(skb, &sk->sk_receive_queue);
> -				WRITE_ONCE(u->oob_skb, NULL);
> -				if (!WARN_ON_ONCE(skb_unref(skb)))
> -					kfree_skb(skb);
> -				skb = skb_peek(&sk->sk_receive_queue);
> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> +				skb = skb_peek_next(skb, &sk->sk_receive_queue);

My last comment for v3 was about this line.
https://lore.kernel.org/netdev/20240424013921.16819-1-kuniyu@amazon.com/

Here, (flags & MSG_PEEK) is true, and if skb_peek_next() returns NULL,


>  			}
>  		}
>  	}
> @@ -2747,9 +2747,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  		if (skb) {
>  			skb = manage_oob(skb, sk, flags, copied);
> -			if (!skb && copied) {
> +			if (!skb) {
>  				unix_state_unlock(sk);
> -				break;
> +				if (copied || (flags & MSG_PEEK))
> +					break;

we will bail out the loop due to this change.

However, no data is copied here, so whether we break or not
should depend on MSG_DONTWAIT, which is handled in the following
`if (skb == NULL)` block.

In the example below, TCP socket is blocked because there is
no data to receive and MSG_DONTWAIT is not specified.  And this
is unblocked when normal data arrives.

  ---8<---
  >>> from socket import *
  >>> 
  >>> s = socket()
  >>> s.listen()
  >>> 
  >>> c1 = socket()
  >>> c1.connect(s.getsockname())
  >>> 
  >>> c2, _ = s.accept()
  >>> 
  >>> c1.send(b'a', MSG_OOB)
  1
  >>> c2.recv(1, MSG_PEEK)
  ^C
  ---8<---

But with your patch, AF_UNIX socket is not blocked even without
MSG_DONTWAIT.

  ---8<---
  >>> from socket import *
  >>> 
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM, 0)
  >>> c1.send(b'a', MSG_OOB)
  1
  >>> c2.recv(1, MSG_PEEK)
  b''
  ---8<---

That's why I said the change in unix_stream_read_generic() is not
needed.

