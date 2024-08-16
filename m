Return-Path: <netdev+bounces-119087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A483953FF3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0E41C20D20
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1989482D8;
	Fri, 16 Aug 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rkHslRsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A326AC3
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777561; cv=none; b=n0KtaPw1jswe0AmTXs53HjoVkwYzeJTOnEUQDFbG1tgkxVq4Hl/oUZotrJbJmJDR5ew0lxrKo18oo6bN5khXUp14RxV2a7l2HGCNaCW+gHsfMiuCwPQ9B+QIh2SKlbYIn57iU9PkFxauoiQI8iHGydaLNeup8GzuTmQxdX/k4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777561; c=relaxed/simple;
	bh=oYdxJXTOWbTdODAd47DBoMRZzVeN2cJyIYyD8YfiBGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg+UaofdpQ1GaqvNaHn+3hg6JHEj95QT/tyz2Ckxbg9j/09+HzEd9JrT7qwgxnR+ZTVzA5bYKzNNTs2VKTxN7faGRVb1gwRsmnJ4C5C7eaTq8lPoFyjoYfEjnpeelwhmlKEOXz290nwWbP3Sg2d1UrKqkXmd143oqaJbVfAsPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rkHslRsS; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723777560; x=1755313560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OsAkrDD7w/qfBX9Ls0GDxDVgnDE5l9wqmBit1z0AtQ=;
  b=rkHslRsSCgDbTS8W+ggEkOdKcxkIhuO8du8NlraB9gWQ2bezXhUnL6g1
   jdsV6bWqWcNdOG/OeZLlJBWeGo8M5UPHtt0uCb2c4NErI4ciiJA426yrF
   mVfQOCYbn69b4wQEQhxLs4fBKa2gXna4iwVkqa9f0W5IcrHsbbs02ORto
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="652862839"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 03:05:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:2095]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.29:2525] with esmtp (Farcaster)
 id 7d2c54dc-059f-4d37-bd60-6b5969412c60; Fri, 16 Aug 2024 03:05:55 +0000 (UTC)
X-Farcaster-Flow-ID: 7d2c54dc-059f-4d37-bd60-6b5969412c60
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:05:55 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:05:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>,
	<tom@herbertland.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
Date: Thu, 15 Aug 2024 20:05:43 -0700
Message-ID: <20240816030543.15051-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoCc7Nm7KgaJxYr4arRxnB+62WrTSoSD79i5X-mkHBiO6g@mail.gmail.com>
References: <CAL+tcoCc7Nm7KgaJxYr4arRxnB+62WrTSoSD79i5X-mkHBiO6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Aug 2024 10:56:19 +0800
> Hello Kuniyuki,
> 
> On Fri, Aug 16, 2024 at 6:05 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported UAF in kcm_release(). [0]
> >
> > The scenario is
> >
> >   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> >
> >   2. Thread A resumes building skb from kcm->seq_skb but is blocked
> >      by sk_stream_wait_memory()
> >
> >   3. Thread B calls sendmsg() concurrently, finishes building kcm->seq_skb
> >      and puts the skb to the write queue
> >
> >   4. Thread A faces an error and finally frees skb that is already in the
> >      write queue
> >
> >   5. kcm_release() does double-free the skb in the write queue
> >
> > When a thread is building a MSG_MORE skb, another thread must not touch it.
> 
> Thanks for the analysis.
> 
> Since the empty skb (without payload) could cause such race and
> double-free issue, I wonder if we can clear the empty skb before
> waiting for memory,

kcm->seq_skb is set when a part of data is copied to skb, so it's not
empty.  Also, seq_skb is cleared when queued to the write queue.

The problem is one thread referencing kcm->seq_skb goes to sleep and
another thread queues the skb to the write queue.

---8<---
        if (eor) {
                bool not_busy = skb_queue_empty(&sk->sk_write_queue);

                if (head) {
                        /* Message complete, queue it on send buffer */
                        __skb_queue_tail(&sk->sk_write_queue, head);
                        kcm->seq_skb = NULL;
                        KCM_STATS_INCR(kcm->stats.tx_msgs);
                }
...
        } else {
                /* Message not complete, save state */
partial_message:
                if (head) {
                        kcm->seq_skb = head;
                        kcm_tx_msg(head)->last_skb = skb;
                }
---8<---

