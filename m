Return-Path: <netdev+bounces-109297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1AC927C58
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616C71F21C20
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D13308A;
	Thu,  4 Jul 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cuWSb08J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849303D97A
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114599; cv=none; b=NrWVo5OWMMW1Yh5Vxih0+oQqYGfehDd2fdNTaMuhGrnOqic8zLGwCTTL4cZIWSj8B6YkdTA2c35FesBEZcuhf4xHVPYGmfoCk0UpqWSmWx2DBrEiKt5ipoTU7r16PUQJlTgdzHkmevuRMx9b9a9maznW+JpiXv3BTpx3/kuunt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114599; c=relaxed/simple;
	bh=xEZ4FsOBteTvLgVLizxJ46M1CLE3Om8o/4Otj04e+Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l65y+zdDnwkVthU8dIUWYc+dJu/Oecrss/9l4qTCd0yOhVxza2ZXZmb/MNSlMWp4BlkgMmp8Nv2abiMTxKGS5Ko7mvdTheqYCTALl+2UH5b5uumt3RU8eq/6gNzGaIpcQnZwizbrFFT12/oLIJ6bMnhroTVBF9PXtVLV43fmXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cuWSb08J; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720114598; x=1751650598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXMqt/DlIcR6O7s7JGZNhNttE6yYaKzYLGv+darLEWY=;
  b=cuWSb08J7pbwKgp4Ikl+LKKphwP+SJ3yJSJMz4UcWoHqR/cz3AGXgR8w
   v8355JyO/P0WCzTnssuxWYNN/I3DpAwjLcI6bEuxMo5o+lmZGu7vk1Hci
   7JQwG/hj0ZH//ySPcvoPVhPqEJm6Fw5AUhvILIM4bYmUyxJsq8GYeC7cJ
   s=;
X-IronPort-AV: E=Sophos;i="6.09,183,1716249600"; 
   d="scan'208";a="9495983"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:36:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:34514]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.196:2525] with esmtp (Farcaster)
 id 0a7335f5-3a0e-4f26-8875-15585b817250; Thu, 4 Jul 2024 17:36:33 +0000 (UTC)
X-Farcaster-Flow-ID: 0a7335f5-3a0e-4f26-8875-15585b817250
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 17:36:31 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 17:36:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brakmo@fb.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
Date: Thu, 4 Jul 2024 10:36:21 -0700
Message-ID: <20240704173621.1804-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJhX=ck_XD4Gu7B_1401e+y4NSE+8CAD_Yu4PMO4-H-eA@mail.gmail.com>
References: <CANn89iJhX=ck_XD4Gu7B_1401e+y4NSE+8CAD_Yu4PMO4-H-eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 10:44:55 +0200
> On Thu, Jul 4, 2024 at 5:57 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > RFC 9293 states that in the case of simultaneous connect(), the connection
> > gets established when SYN+ACK is received. [0]
> >
> >       TCP Peer A                                       TCP Peer B
> >
> >   1.  CLOSED                                           CLOSED
> >   2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...
> >   3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT
> >   4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED
> >   5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...
> >   6.  ESTABLISHED  <-- <SEQ=300><ACK=101><CTL=SYN,ACK> <-- SYN-RECEIVED
> >   7.               ... <SEQ=100><ACK=301><CTL=SYN,ACK> --> ESTABLISHED
> >
> > However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such a
> > SYN+ACK is dropped in tcp_validate_incoming() and responded with Challenge
> > ACK.
> >
> > For example, the write() syscall in the following packetdrill script fails
> > with -EAGAIN, and wrong SNMP stats get incremented.
> >
> >    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
> >   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
> >
> >   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> >   +0 < S  0:0(0) win 1000 <mss 1000>
> >   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
> >   +0 < S. 0:0(0) ack 1 win 1000
> >
> >   +0 write(3, ..., 100) = 100
> >   +0 > P. 1:101(100) ack 1
> >
> >   --
> >
> >   # packetdrill cross-synack.pkt
> >   cross-synack.pkt:13: runtime error in write call: Expected result 100 but got -1 with errno 11 (Resource temporarily unavailable)
> >   # nstat
> >   ...
> >   TcpExtTCPChallengeACK           1                  0.0
> >   TcpExtTCPSYNChallenge           1                  0.0
> >
> > That said, this is no big deal because the Challenge ACK finally let the
> > connection state transition to TCP_ESTABLISHED in both directions.  If the
> > peer is not using Linux, there might be a small latency before ACK though.
> 
> I suggest removing these 3 lines. Removing a not needed challenge ACK is good
> regardless of the 'other peer' behavior.

I see, then should Fixes point to 0c24604b68fc ?

Also I noticed it still sends ACK in tcp_ack_snd_check() as if it's a
response to the normal 3WHS, so we need:

---8<---
@@ -6788,6 +6793,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tcp_fast_path_on(tp);
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
+
+		if (!req)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
---8<---

and I have a question regarding the consume: label.  Why do we use
__kfree_skb() there instead of consume_skb() ?  I guess it's because
skb_unref() is unnecessary and expensive and tracing is also expensive ?


> 
> >
> > The problem is that bpf_skops_established() is triggered by the Challenge
> > ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> > check if the peer supports a TCP option that is expected to be exchanged
> > in SYN and SYN+ACK.
> >
> > Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid such
> > a situation.
> >
> > Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> > Fixes: 9872a4bde31b ("bpf: Add TCP connection BPF callbacks")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/tcp_input.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 77294fd5fd3e..70595009bb58 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5980,6 +5980,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
> >          * RFC 5961 4.2 : Send a challenge ack
> >          */
> >         if (th->syn) {
> > +               if (sk->sk_state == TCP_SYN_RECV && !tp->syn_fastopen && th->ack &&
> > +                   TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
> > +                   TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
> > +                   TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
> > +                       goto pass;
> >  syn_challenge:
> >                 if (syn_inerr)
> >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> > @@ -5990,7 +5995,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
> >         }
> >
> >         bpf_skops_parse_hdr(sk, skb);
> > -
> > +pass:
> 
> It is not clear to me why we do not call bpf_skops_parse_hdr(sk, skb)
> in this case ?

I skipped bpf_skops_parse_hdr() as it had this check.

        switch (sk->sk_state) {
        case TCP_SYN_RECV:
        case TCP_SYN_SENT:
        case TCP_LISTEN:
                return;
        }

Thanks!

> 
> 
> >         return true;
> >
> >  discard:
> > --
> > 2.30.2

