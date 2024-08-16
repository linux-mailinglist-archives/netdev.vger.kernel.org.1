Return-Path: <netdev+bounces-119094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B295401C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8C1C21350
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2942AAF;
	Fri, 16 Aug 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P1yl17//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFD36C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780026; cv=none; b=B6vDwlwA4MbD2YvNBLbw0Ng9VgosAUiSS/jNP5+eQgj97HBBpExCNAnxkSXkSBOqFGYvRB6JtclZZBSCkadl2GJ+tvOVjyrOS+Xkgg+/NCG+3fNdTS8/GqMkJhG2vu6JtaZzvtWPDi+y5dfezDka6RMBq+3MX6HNFnk6WNsD0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780026; c=relaxed/simple;
	bh=TpjvYpbN/6WxE7mgxUwsCxYKJxkGkNhRAcTU2CGLrys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLFWJSjwArbBpJDYUTCkML1iCCXkiyBJhZJ3RFD/Uja+S/OAk9gIKzFZfcv+0kNIaCF0p1qgtIdYKWgsDVhokBq6Kl6YFR9Rz3r3WVQ1CYgZ49J261dcGojAbx2dXjza7O+3JARYl18iKVg/PoDk7GLdT3xyE+qkBBIBIo7o2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P1yl17//; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723780026; x=1755316026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/6Ho/a9k90ffurM3wiujuuWIkUQJx2LkTpeI7SaJoQ=;
  b=P1yl17//CGe1yCsX8hN4vW3+/kAy2vSGRbhTTT9WgMIbvxSceduprp92
   ynKvgyTQ3cvNLelUGJ/L5TBmCdjEuhrCsSDTWW9g3k+LqU8HO4oy1H1PI
   lK427xAskx/WoWVzYzTTJHfxn6Zdv8yyJ0h3Q6P756jpwKUyerZjqIhe7
   I=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="750564787"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 03:46:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:6757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.18:2525] with esmtp (Farcaster)
 id e3dbf15f-11c0-424c-b768-fbae70ac6fa9; Fri, 16 Aug 2024 03:46:58 +0000 (UTC)
X-Farcaster-Flow-ID: e3dbf15f-11c0-424c-b768-fbae70ac6fa9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:46:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:46:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>,
	<tom@herbertland.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
Date: Thu, 15 Aug 2024 20:46:46 -0700
Message-ID: <20240816034646.18670-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoCX2Si0q7HwvGspwqUeN8F1fPxocbb+BB8psQ++_2O_kg@mail.gmail.com>
References: <CAL+tcoCX2Si0q7HwvGspwqUeN8F1fPxocbb+BB8psQ++_2O_kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Aug 2024 11:36:35 +0800
> On Fri, Aug 16, 2024 at 11:05 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Fri, 16 Aug 2024 10:56:19 +0800
> > > Hello Kuniyuki,
> > >
> > > On Fri, Aug 16, 2024 at 6:05 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > syzkaller reported UAF in kcm_release(). [0]
> > > >
> > > > The scenario is
> > > >
> > > >   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> > > >
> > > >   2. Thread A resumes building skb from kcm->seq_skb but is blocked
> > > >      by sk_stream_wait_memory()
> > > >
> > > >   3. Thread B calls sendmsg() concurrently, finishes building kcm->seq_skb
> > > >      and puts the skb to the write queue
> > > >
> > > >   4. Thread A faces an error and finally frees skb that is already in the
> > > >      write queue
> > > >
> > > >   5. kcm_release() does double-free the skb in the write queue
> > > >
> > > > When a thread is building a MSG_MORE skb, another thread must not touch it.
> > >
> > > Thanks for the analysis.
> > >
> > > Since the empty skb (without payload) could cause such race and
> > > double-free issue, I wonder if we can clear the empty skb before
> > > waiting for memory,
> >
> > kcm->seq_skb is set when a part of data is copied to skb, so it's not
> > empty.  Also, seq_skb is cleared when queued to the write queue.
> >
> > The problem is one thread referencing kcm->seq_skb goes to sleep and
> > another thread queues the skb to the write queue.
> >
> > ---8<---
> >         if (eor) {
> >                 bool not_busy = skb_queue_empty(&sk->sk_write_queue);
> >
> >                 if (head) {
> >                         /* Message complete, queue it on send buffer */
> >                         __skb_queue_tail(&sk->sk_write_queue, head);
> >                         kcm->seq_skb = NULL;
> >                         KCM_STATS_INCR(kcm->stats.tx_msgs);
> >                 }
> > ...
> >         } else {
> >                 /* Message not complete, save state */
> > partial_message:
> >                 if (head) {
> >                         kcm->seq_skb = head;
> >                         kcm_tx_msg(head)->last_skb = skb;
> >                 }
> > ---8<---
> 
> Oh, I see the difference of handling error part after waiting for
> memory between tcp_sendmsg_locked and kcm_sendmsg:
> In kcm_sendmsg, it could kfree the skb which causes the issue while tcp doesn't.
> 
> But I cannot help asking if that lock is a little bit heavy, please
> don't get me wrong, I'm not against it. In the meantime, I decided to
> take a deep look at the 'out_error' label part.

I don't think the mutex is heavy because kcm_sendmsg() is already
serialised with lock_sock().

