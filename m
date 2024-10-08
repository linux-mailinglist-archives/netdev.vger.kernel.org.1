Return-Path: <netdev+bounces-133134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBA9951AE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0590BB2CCC7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9121DF75F;
	Tue,  8 Oct 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aMuFcWU2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4921DE3AE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397303; cv=none; b=NrpLA2MhUHBcei0Wuqd7XvtUfpWJdRZ+aumEvY3QA1nzRDUIHTRF9rtbly63nS27juu92aDi8pyEM+a9NGHN5EmRvnwLwbG0FR5edv0oUODri5I0OaY0UDILaRYYhxNvBO1Bd5PB6NFJv4q/IWIlqFw7THqzPjzHWM2Edv6Wmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397303; c=relaxed/simple;
	bh=In7WXsgjQBc9dexBxHfTfAPsgkijMCT+HBakAykdXHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ehiva//qM0lkiIqEqFJEwhW3GBiJCL+vndkpSOkjGaGGa67tysscMeHxkAWs+PeHejBAu6f93FeVZ8cIlzgAoDhgl2BSklLyOjl0dOaMkFR7usEpfem25qg5CbDqIN6sNqOPAxADHlfyRWgxhF0PuFmEKRmVEtFEsJovJOnJRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aMuFcWU2; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728397302; x=1759933302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDDo5k56+GAd4rDdncKic8knKAoF0yMY1WHC04UKepk=;
  b=aMuFcWU2D9BK6fa4gipIxPMC0D3zByUmOCQTf3PdZOoOX5AEMB8d6BD7
   YA7JxxDUZexWU9Feu9Mg5kfyWqnNy5S829XYLm0meVpM/4DeEjPyn7ddk
   6AaoVVZOEqIWRqh2raN1GZ3XJLAaq5Rn5+VzGSn5p0XPX9MAhcy7h8MrG
   g=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="664573386"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 14:21:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:15686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id de4be9f7-4d0a-4cc6-89f5-1407d4d397d5; Tue, 8 Oct 2024 14:21:36 +0000 (UTC)
X-Farcaster-Flow-ID: de4be9f7-4d0a-4cc6-89f5-1407d4d397d5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 14:21:36 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 14:21:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Tue, 8 Oct 2024 07:21:25 -0700
Message-ID: <20241008142125.81471-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKWPDs8UXTu8NU+18DM4XE4wHz=CKeSY2AMoxB7tvLyKw@mail.gmail.com>
References: <CANn89iKWPDs8UXTu8NU+18DM4XE4wHz=CKeSY2AMoxB7tvLyKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 11:54:21 +0200
> On Tue, Oct 8, 2024 at 1:53 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Mon, 7 Oct 2024 16:26:10 -0700
> > > On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> > > > Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> > > >
> > > >   """
> > > >   We are seeing a use-after-free from a bpf prog attached to
> > > >   trace_tcp_retransmit_synack. The program passes the req->sk to the
> > > >   bpf_sk_storage_get_tracing kernel helper which does check for null
> > > >   before using it.
> > > >   """
> > >
> > > I think this crashes a bunch of selftests, example:
> > >
> > > https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queue-sh/stderr
> >
> > Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
> > for different reqsk.  I'll squash the diff below.
> >
> > ---8<---
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 36f03d51356e..433c80dc57d5 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_list *t)
> >         }
> >
> >  drop:
> > -       __inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
> > +       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> >         reqsk_put(req);
> >  }
> >
> > ---8<---
> >
> > Thanks!
> 
> Just to clarify. In the old times rsk_timer was pinned, right ?
> 
> 83fccfc3940c4 ("inet: fix potential deadlock in reqsk_queue_unlink()")
> was fine I think.
> 
> So the bug was added recently ?
> 
> Can we give a precise Fixes: tag ?

TIMER_PINNED was used in reqsk_queue_hash_req() in v6.4 mentioned
by Martin and still used in the latest net-next.

$ git blame -L:reqsk_queue_hash_req net/ipv4/inet_connection_sock.c v6.4
079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1095) static void reqsk_queue_hash_req(struct request_sock *req,
079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1096)                                  unsigned long timeout)
fa76ce7328b28 (Eric Dumazet             2015-03-19 19:04:20 -0700 1097) {
59f379f9046a9 (Kees Cook                2017-10-16 17:29:19 -0700 1098)         timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);

Maybe the connection was localhost, or unlikely but RPS was
configured after SYN+ACK, or setup like ff46e3b44219 was used ??

