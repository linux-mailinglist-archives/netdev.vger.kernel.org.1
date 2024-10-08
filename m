Return-Path: <netdev+bounces-133161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E499521A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D6A1F24E3F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926621DFD9A;
	Tue,  8 Oct 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kV/o5PkH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471A1DF74F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398541; cv=none; b=cNIiwGb2HYoKeEMvWsyLGYh7l3/8kblkQjQHrP2NdyCwO/7qBpE9UouYW0wO7/YhWMf3+/Qp2ysJe4Ld5OVx+m/7w+cGfbFxMqsvyAPPqg9q88d3cAGoAnfnbWLjEpihbsHfLbWtOasMy4g/K/ZwNln89S4rlPr+fvcGn+YM4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398541; c=relaxed/simple;
	bh=b9PnDIWsh3mUiPzxm3WAwMUtcW8dCD9QQIEdncZmGjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBmTQKEW0X3K6Q5wZD4EiVQwVslzeZ2vOxxgZbvM9BJSwLzJHTdK4imsrclWjiiPMlpsXufCRgFVP38tC4X0xydcSQxmxTXRiOGZT8Z6IPiAZctjrbVuPKwkUPTYpXq1oIJyYvD644xATJinobrCNYeKByZfxfg56FKynpP9GFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kV/o5PkH; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728398540; x=1759934540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTP+9rkVcPjmlRgmmDLzsVdY1GpHqwIkJ6uXiPDE0F4=;
  b=kV/o5PkHZz2qiJnOB2X5e6I6J8b2VsGeFPHposxc5CigeDOPO8etXeaw
   ONdbT/aXNf1MhdAZ01pMmQ+YjFuc0JjAjcUztSojw4mq3zQkGKXnJsD8u
   +GnjVAXE5WP95qxKQN+kaKWKO4ZQ+DLPmqI02vybwwCQCOOpKM3sgpP07
   w=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="31548973"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 14:42:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:25622]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 16f07004-ef92-4877-a357-4534eed839b5; Tue, 8 Oct 2024 14:42:16 +0000 (UTC)
X-Farcaster-Flow-ID: 16f07004-ef92-4877-a357-4534eed839b5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 14:42:15 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 14:42:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Tue, 8 Oct 2024 07:42:05 -0700
Message-ID: <20241008144205.83199-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLUqJrO8VR2PTqNaZOb7Jn_CO1F792ec3cLNfXwgAdyrg@mail.gmail.com>
References: <CANn89iLUqJrO8VR2PTqNaZOb7Jn_CO1F792ec3cLNfXwgAdyrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 16:28:53 +0200
> On Tue, Oct 8, 2024 at 4:21 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Tue, 8 Oct 2024 11:54:21 +0200
> > > On Tue, Oct 8, 2024 at 1:53 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Date: Mon, 7 Oct 2024 16:26:10 -0700
> > > > > On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> > > > > > Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> > > > > >
> > > > > >   """
> > > > > >   We are seeing a use-after-free from a bpf prog attached to
> > > > > >   trace_tcp_retransmit_synack. The program passes the req->sk to the
> > > > > >   bpf_sk_storage_get_tracing kernel helper which does check for null
> > > > > >   before using it.
> > > > > >   """
> > > > >
> > > > > I think this crashes a bunch of selftests, example:
> > > > >
> > > > > https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queue-sh/stderr
> > > >
> > > > Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
> > > > for different reqsk.  I'll squash the diff below.
> > > >
> > > > ---8<---
> > > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > > > index 36f03d51356e..433c80dc57d5 100644
> > > > --- a/net/ipv4/inet_connection_sock.c
> > > > +++ b/net/ipv4/inet_connection_sock.c
> > > > @@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_list *t)
> > > >         }
> > > >
> > > >  drop:
> > > > -       __inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
> > > > +       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> > > >         reqsk_put(req);
> > > >  }
> > > >
> > > > ---8<---
> > > >
> > > > Thanks!
> > >
> > > Just to clarify. In the old times rsk_timer was pinned, right ?
> > >
> > > 83fccfc3940c4 ("inet: fix potential deadlock in reqsk_queue_unlink()")
> > > was fine I think.
> > >
> > > So the bug was added recently ?
> > >
> > > Can we give a precise Fixes: tag ?
> >
> > TIMER_PINNED was used in reqsk_queue_hash_req() in v6.4 mentioned
> > by Martin and still used in the latest net-next.
> >
> > $ git blame -L:reqsk_queue_hash_req net/ipv4/inet_connection_sock.c v6.4
> > 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1095) static void reqsk_queue_hash_req(struct request_sock *req,
> > 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1096)                                  unsigned long timeout)
> > fa76ce7328b28 (Eric Dumazet             2015-03-19 19:04:20 -0700 1097) {
> > 59f379f9046a9 (Kees Cook                2017-10-16 17:29:19 -0700 1098)         timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> >
> > Maybe the connection was localhost, or unlikely but RPS was
> > configured after SYN+ACK, or setup like ff46e3b44219 was used ??
> 
> I do not really understand the issue.
> How a sk can be 'closed' with outstanding request sock ?
> They hold a refcount on the listener.

My understanding is

1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
   but del_timer_sync() is missed

2. reqsk timer is executed and scheduled again

3. req->sk is accept()ed, but inet_csk_accept() does not clear
   req->sk for non-TFO sockets, and reqsk_put() decrements one
   refcnt, but still reqsk timer has another one

4. sk is close()d

5. reqsk timer is executed again, and BPF touches req->sk

reqsk timer will run for 63s by default, so I think it's possible
that sk is close()d earlier than the timer expiration.

