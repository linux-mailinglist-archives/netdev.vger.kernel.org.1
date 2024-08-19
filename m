Return-Path: <netdev+bounces-119827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1AA957285
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614C61F224E3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C5188CAF;
	Mon, 19 Aug 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l6WCB9WV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120ED531
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090190; cv=none; b=mvZ18bn26+kXHmz/DuKpZNY2mXSBcvAfsyx1bjzBtekIfOKja5S6EDVua1RwoXvRovIGyvy3JURJ6NTv6HUcs92Bqoga8GR1aXZU5a37WJd5wAOwGvVmxrCy+BFTQgzRSgmTVYmP+IhZwQ1cI96j80j9lNE20tRgmWMsr/jV7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090190; c=relaxed/simple;
	bh=A5dqmf+JzsY5lIe/bF4FwczQYnCwYMaKfbIPB4m5FRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IafKyDx/GojIC/Bb9uzwGinw2V53rAaPiSg6xeRD30OY64IGuc79exXURd3H/jw+gyR7iQ0tQXoaX6/H2ZXvc1Bs69Hat3JEcHh9KKtyaFGoTDoqd5NtDE/TO9BtFpAJkIGXZVq4NPCUAI4rJ8ihmL5D7Dtv666C99bPj6z9DoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l6WCB9WV; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724090189; x=1755626189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGwWohLSwKVKr6pzBrhJ8U3Li307TEilkvq/0hVqaXg=;
  b=l6WCB9WV66oPICMJ9LDPEfuj2RRtNlFC9FGpHdxfROcaAhM9Pk887tOH
   +LoejjI7gwa5s5++GEoY8QqfAH6G0t6gdC86deXNK0cL9Zi35DUt/khEF
   a+JCvyX9aNhlEX4rP8uaNnwVxwburtST7GTt2tUZ3Mj9fxN+0RPHWvi2n
   4=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="116896922"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:56:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:23715]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.141:2525] with esmtp (Farcaster)
 id 38b00c36-8471-4eb7-a72b-edcce829956e; Mon, 19 Aug 2024 17:56:26 +0000 (UTC)
X-Farcaster-Flow-ID: 38b00c36-8471-4eb7-a72b-edcce829956e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 17:56:26 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 17:56:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <0x7f454c46@gmail.com>, <davem@davemloft.net>, <dima@arista.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <fw@strlen.de>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<pablo@netfilter.org>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple symmetry socket
Date: Mon, 19 Aug 2024 10:56:14 -0700
Message-ID: <20240819175614.14990-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoCZQdU5H3c88g3MMoBRxvMTC81HaVzKF4TL=mA53arwWw@mail.gmail.com>
References: <CAL+tcoCZQdU5H3c88g3MMoBRxvMTC81HaVzKF4TL=mA53arwWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 17:41:32 +0800
> On Mon, Aug 19, 2024 at 5:38 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 11:32 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > > After investigating such an issue more deeply in the customers'
> > > machines, the main reason why it can happen is the listener exits
> > > while another thread starts to connect, which can cause
> > > self-connection, even though the chance is slim. Later, the listener
> > > tries to listen and for sure it will fail due to that single
> > > self-connection.
> >
> > This would happen if the range of ephemeral ports include the listening port,
> > which is discouraged.
> 
> Yes.
> 
> >
> > ip_local_reserved_ports is supposed to help.
> 
> Sure, I workarounded it by using this and it worked.
> 
> >
> > This looks like a security issue to me, and netfilter can handle it.
> 
> I have to admit setting netfilter rules for each flow is not a very
> user-friendly way.

I think even netfilter is not needed.

It sounds like the server application needs to implement graceful shutdown.
The server should not release the port if there are on-going clients.  The
server should spin up a new process and use the following to transfer the
remaining connections:

  * FD passing
  * SO_REUSEPORT w/ (net.ipv4.tcp_migrate_req or BPF)

Then, no client can occupy the server's port even without
ip_local_reserved_ports.

But I still recommend using ip_local_reserved_ports unless the server port
is random.

