Return-Path: <netdev+bounces-112673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846693A8AC
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC381C228DD
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21261448CD;
	Tue, 23 Jul 2024 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qqr2Dvsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF4142E83;
	Tue, 23 Jul 2024 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770035; cv=none; b=K8kpjBjcYcU8qUJ8E8dq59ZrNSN/Ft2PLSQzqzavq0wn3IV3VJQ16oRl0ve7o6NhGGsYEv4+j/XVpL+hjprjTHQUM+ZW+7d4poSct26DBVpE8UG1O9k74ztFq2qiizbJTR1G/bW9kighPwUrZTdcNu/8+SQSY6XY8Va0MkimpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770035; c=relaxed/simple;
	bh=tuFWmiGk/I2Yi8+LTB49yUHSxSVFD1tz1PmYJWRFT3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEYBjYFwiam7m1LWZupfLzh5rSBFwfd02ma3mU+3EDkw8i75YZzEqZklXH28LeIqqQGLjR8xL3cE+hGNSOxgRrFcA1PH20tNqXaAPsy21okY36A4f5fKyZv6vs9X3rTSKFTAas0heoRe4f+8gj182oDZ5UOoU5zUqcAV3MiUXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qqr2Dvsq; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721770034; x=1753306034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cmq4hBWrNdZRnsjHT7Lr2kHH/xLLGpsyBTdbcfBBp4o=;
  b=qqr2Dvsqtfjun+c3wRsMsy+RCjyqMvAKx5Etj+T6tfqHxYeeJnLYu+S3
   011WNjXpLwOgd2IrD3pIgbuUE0foWOnpIOGmORljCFb6Fxak6iemzxJu3
   E6Wt5sPtSFoke3GOUtfC7x1RW+cpcGNfz/cO91Yq+4PuH/VMho/PKn21A
   s=;
X-IronPort-AV: E=Sophos;i="6.09,231,1716249600"; 
   d="scan'208";a="108913194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 21:27:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:40218]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.189:2525] with esmtp (Farcaster)
 id 4761187b-f00c-46b5-9d20-3413fab75dcd; Tue, 23 Jul 2024 21:27:11 +0000 (UTC)
X-Farcaster-Flow-ID: 4761187b-f00c-46b5-9d20-3413fab75dcd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 21:27:11 +0000
Received: from 88665a182662.ant.amazon.com (10.88.135.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 21:27:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
Date: Tue, 23 Jul 2024 14:27:00 -0700
Message-ID: <20240723212700.60244-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
References: <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 17:38:27 +0200
[...]
> > > //
> > > // Test the simultaneous open scenario that both end sends
> > > // SYN/data. Although we don't support that the connection should
> > > // still be established.
> > > //
> > > `../../common/defaults.sh
> > >  ../../common/set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
> > >
> > > // Cache warmup: send a Fast Open cookie request
> > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > >    +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> > >    +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS
> > > (Operation is now in progress)
> > >    +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
> > >  +.01 < S. 123:123(0) ack 1 win 14600 <mss
> > > 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
> > >    +0 > . 1:1(0) ack 1
> > >  +.01 close(3) = 0
> > >    +0 > F. 1:1(0) ack 1
> > >  +.01 < F. 1:1(0) ack 2 win 92
> > >    +0 > .  2:2(0) ack 2
> > >
> > >
> > > //
> > > // Test: simulatenous fast open
> > > //
> > >  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
> > >    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> > >    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
> > >    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> > > abcd1234,nop,nop>
> > > // Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
> > > +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
> > > 6,FO 87654321,nop,nop>
> > >    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> > >
> > > // SYN data is never retried.
> > > +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> > > 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> > >    +0 > . 1001:1001(0) ack 1
> >
> > I recently sent a PR -- already applied -- to Neal to remove this line:
> >
> >   https://github.com/google/packetdrill/pull/86
> >
> > I thought it was the intension of Kuniyuki's patch not to send this ACK
> > in this case to follow the RFC 9293's recommendation. This TFO test
> > looks a bit similar to the example from Kuniyuki's patch:
> >
> >
> > --------------- 8< ---------------
> >  0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
> > +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
> >
> > +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> > +0 < S  0:0(0) win 1000 <mss 1000>
> > +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
> > +0 < S. 0:0(0) ack 1 win 1000
> >
> >   /* No ACK here */
> >
> > +0 write(3, ..., 100) = 100
> > +0 > P. 1:101(100) ack 1
> > --------------- 8< ---------------
> >
> >
> >
> > But maybe here that should be different for TFO?
> >
> > For my case with MPTCP (and TFO), it is fine to drop this 'goto consume'
> > but I don't know how "strict" we want to be regarding the RFC and this
> > marginal case.
> 
> Problem of this 'goto consume' is that we are not properly sending a
> DUPACK in this case.
> 
>  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
>    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
>    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
>    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> abcd1234,nop,nop>
> // Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
> +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
> 6,FO 87654321,nop,nop>
>    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> 
> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
> 
> Not sending a dupack seems wrong and could hurt.

I think the situation where we should send ACK after simultaneous
SYN+ACK would be:

---8<---
 +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
   +0 > S 0:1000(1000) <mss 1440,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
// Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
+.005 < S 1234:1734(500) win 14400 <mss 1040,nop,nop,sackOK,nop,wscale 6,FO 87654321,nop,nop>
   +0 > S. 0:0(0) ack 1235 <mss 1440,nop,nop,sackOK,nop,wscale 8>

// SYN data is not ACKed too.
+.045 < S. 1234:1234(0) ack 1 win 14400 <mss 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>

   +0 > . 1:1001(1000) ack 1
---8<---

When the first data in SYN is not ACKed, it must be retransmitted,
and it can be done just after SYN+ACK is received, which is skipped
by 'goto consume'.

Retransmitting data in SYN is not supported though.

---8<---
sendto syscall: 1721769223.194675
outbound sniffed packet:  0.040288 S 833802090:833803090(1000) win 65535 <mss 1440,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
inbound injected packet:  0.045323 S 1234:1734(500) win 14400 <mss 1040,nop,nop,sackOK,nop,wscale 6,FO 87654321,nop,nop>
outbound sniffed packet:  0.045355 S. 833802090:833802090(0) ack 1235 win 65535 <mss 1440,nop,nop,sackOK,nop,wscale 8>
inbound injected packet:  0.090429 S. 1234:1234(0) ack 833802091 win 14400 <mss 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
outbound sniffed packet:  0.090460 . 833803091:833803091(0) ack 1235 win 1052 
outbound sniffed packet:  1.051776 S. 833802090:833802090(0) ack 1235 win 65535 <mss 1440,nop,nop,sackOK,nop,wscale 8>
simul2.pkt:38: error handling packet: live packet field tcp_data_offset: expected: 5 (0x5) vs actual: 8 (0x8)
   script packet:  0.090462 . 1:1001(1000) ack 1 
actual #0 packet:  0.090460 . 1001:1001(0) ack 1 win 1052 
actual #1 packet:  1.051776 S. 0:0(0) ack 1235 win 65535 <mss 1440,nop,nop,sackOK,nop,wscale 8>
---8<---

Except the case, I think the dupack is not needed in theory.

But I understand the dupack could help the other quickly retransmit the
not-yet-ACKed data in SYN instead of waiting for a timer as expected in
the comment.

---8<---
// The other end retries
  +.1 < P. 1:501(500) ack 1000 win 257
---8<---

