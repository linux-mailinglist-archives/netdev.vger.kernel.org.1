Return-Path: <netdev+bounces-95867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71218C3B32
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3681F21126
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BE146595;
	Mon, 13 May 2024 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o8JGHN8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59354C81
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580785; cv=none; b=KvGbwpgfRI3hNptRd26le/8Eb2fjt/IVqBJSkG4f2ONUdIQF0S2/mIfNs81nQGw7PLh0nLgJfa2icMAmRwxm6YRxyPfkWuoPqhiI7AKD/QKee+0oFhnYlFpDVFsD8ihg8cKsCgSbD7V3BE0qma49CFiAbZvLeYplyndRqAp5iF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580785; c=relaxed/simple;
	bh=ZpBSWgX7S3Vy0VaKDHHUVKTqEODFQeRl/aOmN4v2thI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdoKLqtWGDeRu+fslgcDjjzUweTByv7qjs0ZBZ50ca2ffLLQaRsWFNQrRfUpcMv8lJ5A+xQvbLjRwnDNSPPplLm9bw41MJd5L8YUvWLTNhU+AHai4MmEFiefv8lH8ufMV82zfMdhReyMXbjJ8/bDLoiHI6REm9yOYWhyY9/YVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o8JGHN8d; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715580784; x=1747116784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6IccWyDz3BZ1i/emZwgxcgG+H1i2MIrz6b8w1Bbfxk=;
  b=o8JGHN8dKNSsCpK/sJ6hW4ubqSNOsG+csh+zTV/IMmxIi7M+0TxWZw/M
   +OaXTlqS1DxNzZjgzSEk0tLDxfdg/eDoQtqfpE4kZYhV3P9RMfsuW85fZ
   GF0cFeGjf/iWflODAgp5j62K8i5rRx7NZRtHjQSPUEa4ZtSUs07a7Dsdc
   A=;
X-IronPort-AV: E=Sophos;i="6.08,157,1712620800"; 
   d="scan'208";a="400728316"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:13:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:11983]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.40:2525] with esmtp (Farcaster)
 id 26b96598-34df-4419-82f9-bcf00d0a24f3; Mon, 13 May 2024 06:13:00 +0000 (UTC)
X-Farcaster-Flow-ID: 26b96598-34df-4419-82f9-bcf00d0a24f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 06:12:59 +0000
Received: from 88665a182662.ant.amazon.com.com (10.118.251.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 13 May 2024 06:12:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Mon, 13 May 2024 15:12:44 +0900
Message-ID: <20240513061244.12229-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5670c1c4-985d-4e87-9732-ad1cc59bc8db@rbox.co>
References: <5670c1c4-985d-4e87-9732-ad1cc59bc8db@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 12 May 2024 16:47:11 +0200
> On 5/10/24 11:39, Kuniyuki Iwashima wrote:
> > @@ -2655,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  		consume_skb(skb);
> >  		skb = NULL;
> >  	} else {
> > +		spin_lock(&sk->sk_receive_queue.lock);
> > +
> >  		if (skb == u->oob_skb) {
> >  			if (copied) {
> >  				skb = NULL;
> > @@ -2666,13 +2674,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  			} else if (flags & MSG_PEEK) {
> >  				skb = NULL;
> >  			} else {
> > -				skb_unlink(skb, &sk->sk_receive_queue);
> > +				__skb_unlink(skb, &sk->sk_receive_queue);
> >  				WRITE_ONCE(u->oob_skb, NULL);
> >  				if (!WARN_ON_ONCE(skb_unref(skb)))
> >  					kfree_skb(skb);
> >  				skb = skb_peek(&sk->sk_receive_queue);
> >  			}
> >  		}
> > +
> > +		spin_unlock(&sk->sk_receive_queue.lock);
> >  	}
> >  	return skb;
> >  }
> 
> Now it is
>   
>   spin_lock(&sk->sk_receive_queue.lock)
>   kfree_skb

This does not free skb actually and just drops a refcount by skb_get()
in queue_oob().


>     unix_destruct_scm

So, here we don't reach unix_destruct_scm().

That's why I changed kfree_skb() to skb_unref() in __unix_gc().

Thanks!


>       unix_notinflight
>         spin_lock(&unix_gc_lock)
> 
> I.e. sk_receive_queue.lock -> unix_gc_lock, inversion of what unix_gc() does.
> But that's benign, right?

