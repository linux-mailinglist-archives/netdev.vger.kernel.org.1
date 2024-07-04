Return-Path: <netdev+bounces-109298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862A927C6B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE2F1C2295E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0286F09C;
	Thu,  4 Jul 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JBjis5HT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357D3C482
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114944; cv=none; b=g1DK9aXRxeyjCJNInwtJPX6oW+usW4t8uCmGBiiT8yTjEpHGNpR+RggJLyCzpskiEk8HVyjSVYO7SqhFsH+L2XgsD7d0fV8/1LrAtjFfefmsYvK8k8YmLUBbTkySOoWWIDV7jyKyOBJtOMRPg5Mr1ZFhoq8PJYUgZ7poPGJ2OUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114944; c=relaxed/simple;
	bh=beRZLNnntJN78BJEThpkbWf6b7X4QNk9hQV0xyfqpeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKnYahOmrIjaNyCqYUAyqYc2ZAqIO3X+an+t0Q1Gbuk2t+g1kh9bMzSivC0cBUhKESkEOa/XJXi7m0DW4XAm+zhbmSA9xenXwljgVhtSCG/FAqkUmvpMCdMn1l+ZmwK/SVKNN3w/HP2cvZvq8Il1NWFYawCBz0NS8gBzZkhWI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JBjis5HT; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720114943; x=1751650943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktEUqlP5KWbw8tJtj3p32uDM9JelRbnbOwX1TE53CnM=;
  b=JBjis5HTGlq/UFkpuquvR/cAd5ppNEtcPzdWoEsP6kVqDwqlwBy9PkGG
   ktlzLeDJ1USxbbe6JDs3SjEP9jgNWXzXGBfxeBCsoK6rQIZeePgtU2aMp
   FbfG/S/aBFnNOhvaLbeNMvXNPEq65TkwM46xB+Fwq7XZyXNlGz1wOyhTD
   I=;
X-IronPort-AV: E=Sophos;i="6.09,183,1716249600"; 
   d="scan'208";a="664974964"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:42:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:44247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.48:2525] with esmtp (Farcaster)
 id ef3a59b7-a1de-485c-978d-634bd825d02a; Thu, 4 Jul 2024 17:42:19 +0000 (UTC)
X-Farcaster-Flow-ID: ef3a59b7-a1de-485c-978d-634bd825d02a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 17:42:18 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 17:42:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <0x7f454c46@gmail.com>, <brakmo@fb.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
Date: Thu, 4 Jul 2024 10:42:08 -0700
Message-ID: <20240704174208.2182-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKO=Y8P_tms-nymhLF8QbWmOD-g_N33DLMfA6WcO+vhbg@mail.gmail.com>
References: <CANn89iKO=Y8P_tms-nymhLF8QbWmOD-g_N33DLMfA6WcO+vhbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 14:23:11 +0200
> On Thu, Jul 4, 2024 at 1:16 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On Wed, 2024-07-03 at 20:57 -0700, Kuniyuki Iwashima wrote:
> > > RFC 9293 states that in the case of simultaneous connect(), the connection
> > > gets established when SYN+ACK is received. [0]
> > >
> > >       TCP Peer A                                       TCP Peer B
> > >
> > >   1.  CLOSED                                           CLOSED
> > >   2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...
> > >   3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT
> > >   4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED
> > >   5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...
> > >   6.  ESTABLISHED  <-- <SEQ=300><ACK=101><CTL=SYN,ACK> <-- SYN-RECEIVED
> > >   7.               ... <SEQ=100><ACK=301><CTL=SYN,ACK> --> ESTABLISHED
> > >
> > > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such a
> > > SYN+ACK is dropped in tcp_validate_incoming() and responded with Challenge
> > > ACK.
> > >
> > > For example, the write() syscall in the following packetdrill script fails
> > > with -EAGAIN, and wrong SNMP stats get incremented.
> > >
> > >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
> > >   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
> > >
> > >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> > >   +0 < S  0:0(0) win 1000 <mss 1000>
> > >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
> > >   +0 < S. 0:0(0) ack 1 win 1000
> > >
> > >   +0 write(3, ..., 100) = 100
> > >   +0 > P. 1:101(100) ack 1
> > >
> > >   --
> > >
> > >   # packetdrill cross-synack.pkt
> > >   cross-synack.pkt:13: runtime error in write call: Expected result 100 but got -1 with errno 11 (Resource temporarily unavailable)
> > >   # nstat
> > >   ...
> > >   TcpExtTCPChallengeACK           1                  0.0
> > >   TcpExtTCPSYNChallenge           1                  0.0
> > >
> > > That said, this is no big deal because the Challenge ACK finally let the
> > > connection state transition to TCP_ESTABLISHED in both directions.  If the
> > > peer is not using Linux, there might be a small latency before ACK though.
> > >
> > > The problem is that bpf_skops_established() is triggered by the Challenge
> > > ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> > > check if the peer supports a TCP option that is expected to be exchanged
> > > in SYN and SYN+ACK.
> > >
> > > Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid such
> > > a situation.
> >
> > Apparently this behavior change is causing TCP AO self-tests failures:
> >
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2024-07-04--09-00
> > e.g.
> > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/668061/22-self-connect-ipv4/stdout
> >
> 
> These tests seem to have broken assumptions on a kernel behavior which
> are orthogonal to TCP AO.

Seems so...

> 
> > Could you please have a look?

Sure :)

Thanks!

