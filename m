Return-Path: <netdev+bounces-105905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBA9137CC
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 07:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4691C20EB0
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67332D530;
	Sun, 23 Jun 2024 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="egUQHnbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E951DFE3
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119964; cv=none; b=i7yvTV1x9kvAEUjJ8N1fG0Iblh6BEpQ+usezgVH2fa8uKYma6TBjEriWNyVEWIhlWfYm3HJISth12fKVdJlbm3tD6O2zS7TxpyZdEr8Ucbyg7QsZR5gjJeE/vJzsmIVgfRLYmFzaTZreWBhgJZ5BYqlgXv0Kvm79bDgEINURw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119964; c=relaxed/simple;
	bh=JKxe257slY2akgpfrgY3SogqhQAjUwyvG5Kn4fSXuc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvXjRSbUD6XbjmX7QXq/Q6VeivFDiyye+XtTcyO6tALJkcDUlJEZaGRGfOlqt1F7mkfYKFkazd/nfQwOt0G+DSrZP5y/MkGcvi5UQOyg2RqGqILWY7u7WKkw+V/LTv7/V7m9bFKAL32ssTI97ilidxz0u4+3KnUMrJRFzWhdggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=egUQHnbd; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719119963; x=1750655963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vou7+OzLuYsbvKT5qMRhzOH39k9YAh9IGL9CPQ6tUaU=;
  b=egUQHnbd4QgYBKpTOcsf1KB78wKZryGnaJQbpupP4T3Z2XCcK+3kOREQ
   6VrUsYquVAMscKo41TiH89VhC2d8q8XMgMEOnoHBLeRFVTxL5rwjmLDMO
   LsFzl9hjgtrsvLcIVzo83Inz/WT4EYPIDGuGg4vSJ7ZexwzfnbV7PaNDD
   A=;
X-IronPort-AV: E=Sophos;i="6.08,259,1712620800"; 
   d="scan'208";a="734815548"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 05:19:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:10846]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id a638cf36-5dbb-4130-8ecb-b31fb7fa6624; Sun, 23 Jun 2024 05:19:16 +0000 (UTC)
X-Farcaster-Flow-ID: a638cf36-5dbb-4130-8ecb-b31fb7fa6624
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 23 Jun 2024 05:19:16 +0000
Received: from 88665a182662.ant.amazon.com (10.142.209.217) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 23 Jun 2024 05:19:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Sat, 22 Jun 2024 22:19:06 -0700
Message-ID: <20240623051906.79744-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2d34e8df-cbb0-486a-976b-c5c72554e184@rbox.co>
References: <2d34e8df-cbb0-486a-976b-c5c72554e184@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 23 Jun 2024 00:43:27 +0200
> On 6/20/24 23:56, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Thu, 20 Jun 2024 22:35:55 +0200
> >> In fact, should I try to document those not-so-obvious OOB/sockmap
> >> interaction? And speaking of documentation, an astute reader noted that
> >> `man unix` is lying:
> > 
> > At least I wouldn't update man until we can say AF_UNIX MSG_OOB handling
> > is stable enough; the behaviour is not compliant with TCP now.
> 
> Sure, I get it.
> 
> > (...)
> > And we need
> > 
> > ---8<---
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 5e695a9a609c..2875a7ce1887 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2614,9 +2614,20 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  	struct unix_sock *u = unix_sk(sk);
> >  
> >  	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
> > -		skb_unlink(skb, &sk->sk_receive_queue);
> > -		consume_skb(skb);
> > -		skb = NULL;
> > +		struct sk_buff *unlinked_skb = skb;
> > +
> > +		spin_lock(&sk->sk_receive_queue.lock);
> > +
> > +		__skb_unlink(skb, &sk->sk_receive_queue);
> > +
> > +		if (copied)
> > +			skb = NULL;
> > +		else
> > +			skb = skb_peek(&sk->sk_receive_queue);
> > +
> > +		spin_unlock(&sk->sk_receive_queue.lock);
> > +
> > +		consume_skb(unlinked_skb);
> >  	} else {
> >  		struct sk_buff *unlinked_skb = NULL;
> >  
> > ---8<---
> 
> I gotta ask, is there a reason for unlinking an already consumed
> ('consumed' as in 'unix_skb_len(skb) == 0') skb so late, in manage_oob()?
> IOW, can't it be unlinked immediately once it's consumed in
> unix_stream_recv_urg()? I suppose that would simplify things.

I also thought that before, but we can't do that.

Even after reading OOB data, we need to remember the position
and break recv() at that point.  That's why the skb is unlinked
in manage_oob() rather than unix_stream_recv_urg().

