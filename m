Return-Path: <netdev+bounces-101158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF08FD84F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FE1F20F71
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D615F321;
	Wed,  5 Jun 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E33V1WzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D619D895
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622495; cv=none; b=KbBt+pnrzgVvMek99j8cCjeLncvbZU2eunGQxPphoBtsVZZMFjl6pUdqjGnicYKPWOMPhZ1SF2pW0pAfo5j+snitbc4nXIh5tDIOy3CfWVLjfM9Ag7PYlvhCj6IuLCRF9CtPeoloFoshTfozrpp+WUY9Nvo+o+7CVLEGFn0vr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622495; c=relaxed/simple;
	bh=KITWVSHFHddl/iWAjYwtbJMpxT7DhdGrg4+BaV0CRwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJL8aQwtQJJ3Tv/yt4i9gC291QHKEgIEyhGa7vqkzle8sNbtnSVq46yygvHlYgWn3w4/k+stMaFtAkIbkNq7x4M9m3dGdNQ7kUPPquqdnL67kuacrpjJqDl6gFQ+xExqivHhAOzlYfs2UTXmrtXIXMUL3CXKbFsZoDrCU1I+jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E33V1WzS; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717622494; x=1749158494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UhPBXfbmCJsZZ2Gs471qzOThXqMajRa59y6VepwiGw=;
  b=E33V1WzS4LkJpXPuI+uFEdeiqZjXrWIyZRO0+urIgVDCa1r5SYNo1NyD
   0mCsBnByPEt5XtJxrX1sdbWXfS7LjUNFToc+oL8K/Gs2Ew3KOWO9MbH9i
   UVfAQXVppdf9F9mo/qkxNAsk055GMXJGJ3OVYL0RILydfcDwrfbqmu8KF
   s=;
X-IronPort-AV: E=Sophos;i="6.08,217,1712620800"; 
   d="scan'208";a="3082694"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 21:21:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:7755]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.124:2525] with esmtp (Farcaster)
 id 241c6e13-5eb7-4830-9aae-645257948455; Wed, 5 Jun 2024 21:21:30 +0000 (UTC)
X-Farcaster-Flow-ID: 241c6e13-5eb7-4830-9aae-645257948455
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 21:21:29 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 21:21:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <Rao.Shoaib@oracle.com>
CC: <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v5] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Wed, 5 Jun 2024 14:21:19 -0700
Message-ID: <20240605212119.55025-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <aa07bf0e1ad60520705ea4f51f77bf3faa83aed6.camel@redhat.com>
References: <aa07bf0e1ad60520705ea4f51f77bf3faa83aed6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 21 May 2024 13:11:52 +0200
> On Thu, 2024-05-16 at 16:16 -0700, Rao Shoaib wrote:
> > Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
> > commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
> > addresses the loop issue but does not address the issue that no data
> > beyond OOB byte can be read.
> > 
> > > > > from socket import *
> > > > > c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> > > > > c1.send(b'a', MSG_OOB)
> > 1
> > > > > c1.send(b'b')
> > 1
> > > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> > b'b'
> > 
> > > > > from socket import *
> > > > > c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> > > > > c2.setsockopt(SOL_SOCKET, SO_OOBINLINE, 1)
> > > > > c1.send(b'a', MSG_OOB)
> > 1
> > > > > c1.send(b'b')
> > 1
> > > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> > b'a'
> > > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> > b'a'
> > > > > c2.recv(1, MSG_DONTWAIT)
> > b'a'
> > > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> > b'b'
> > > > > 
> > 
> > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> > ---
> >  net/unix/af_unix.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index fa906ec5e657..6e5ef44640ea 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2612,19 +2612,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  		if (skb == u->oob_skb) {
> >  			if (copied) {
> >  				skb = NULL;
> > -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
> > -				if (!(flags & MSG_PEEK)) {
> > +			} else if (!(flags & MSG_PEEK)) {
> > +				if (sock_flag(sk, SOCK_URGINLINE)) {
> >  					WRITE_ONCE(u->oob_skb, NULL);
> >  					consume_skb(skb);
> > +				} else {
> > +					skb_unlink(skb, &sk->sk_receive_queue);
> > +					WRITE_ONCE(u->oob_skb, NULL);
> > +					if (!WARN_ON_ONCE(skb_unref(skb)))
> > +						kfree_skb(skb);
> > +					skb = skb_peek(&sk->sk_receive_queue);
> >  				}
> > -			} else if (flags & MSG_PEEK) {
> > -				skb = NULL;
> > -			} else {
> > -				skb_unlink(skb, &sk->sk_receive_queue);
> > -				WRITE_ONCE(u->oob_skb, NULL);
> > -				if (!WARN_ON_ONCE(skb_unref(skb)))
> > -					kfree_skb(skb);
> > -				skb = skb_peek(&sk->sk_receive_queue);
> > +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> > +				skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >  			}
> >  		}
> >  	}
> 
> Does not apply cleanly anymore after commit 9841991a446c ("af_unix:
> Update unix_sk(sk)->oob_skb under sk_receive_queue lock."), please
> rebase, thanks!

Hi Rao,

Do you have time to respin v6 or do you mind if I rebase it and post v6 ?
I have some patches for net-next on top of this fix.

Thanks

