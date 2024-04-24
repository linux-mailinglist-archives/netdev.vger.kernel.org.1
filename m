Return-Path: <netdev+bounces-90718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9A8AFD3C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4053AB20E3B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F2634;
	Wed, 24 Apr 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SR0umrJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E8363
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917762; cv=none; b=iB+unDJdJHpF/JpeFQoNUQNlIy2SSTTUswoB96JU5KAf63blX6kZ+2rJyYdXvQ9y2HZh5V7hbPSB6bl0XcaFuyc/A0cyXR7JzMtodSfgiGhXi2BtAzwFdO90dBUCwxOQkzEGFgbqW5JdotxG3UVpt1CmjRB298J2oKk/nymyukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917762; c=relaxed/simple;
	bh=It0AYAsJUK9ezyXmmo0tI4A7IXhS8QyHTc1MWS37eJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTa3HN/+5apXNzZtMCr+4XZ27Kb42I7qbR5ox84Dvex7oa6vlbhrDIqMA7CeI21r4sBjoKUbC0EiaXR81OxWrTNLBObUDqjasyDzCdZsCKTavXAxamnYYLfX9YiozmDW0x3VurAy9/GphbDyQw6+ph083F2oQmysblbwmPFDM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SR0umrJC; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713917761; x=1745453761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20NpxXEbwFbS4oTynzxQpX9fxx+dPYqz7Pmk4ODpNm4=;
  b=SR0umrJCnKE9ukwuPdr6ECKk7a3OnzWNCUzeICrCJLnNymfZbN3Q8Xkd
   HVx9y2MZ/AusSJbegA5E3gPpVxvZijHi6ZY0pmNppclaMUcj+W8bU0fUr
   VC+edgUeemdL+yI++3szlHNmiRU3yX3vnCDojlxt3FnpT2tuBv9FC1mnT
   k=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="721675347"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:15:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:14424]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.187:2525] with esmtp (Farcaster)
 id 73fc974d-0330-4947-897c-f3cca06852a0; Wed, 24 Apr 2024 00:15:54 +0000 (UTC)
X-Farcaster-Flow-ID: 73fc974d-0330-4947-897c-f3cca06852a0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 00:15:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 00:15:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v3] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Tue, 23 Apr 2024 17:15:43 -0700
Message-ID: <20240424001543.7843-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422092503.1014699-1-Rao.Shoaib@oracle.com>
References: <20240422092503.1014699-1-Rao.Shoaib@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <Rao.Shoaib@oracle.com>
Date: Mon, 22 Apr 2024 02:25:03 -0700
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
>  net/unix/af_unix.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..ed5f70735435 100644
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

I added a comment about this case.


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
>  			}
>  		}
>  	}
> @@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  		if (skb) {
>  			skb = manage_oob(skb, sk, flags, copied);
> -			if (!skb && copied) {
> +			if (!skb) {
>  				unix_state_unlock(sk);
> -				break;
> +				if (copied || (flags & MSG_PEEK))
> +					break;
> +				goto redo;

Here, copied == 0 && !(flags & MSG_PEEK) && skb == NULL, so it means
skb_peek(&sk->sk_receive_queue) above returned NULL.  Then, we need
not jump to the redo label, where we call the same skb_peek().

Instead, we can just fall through the if (!skb) clause below.

Thanks!

>  			}
>  		}
>  #endif
> -- 
> 2.39.3

