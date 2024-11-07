Return-Path: <netdev+bounces-142665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D29BFECC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C251C22A65
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EC195B18;
	Thu,  7 Nov 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s+gAuhrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E1193070
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963492; cv=none; b=pRsHeQKAyBtWOKUEggV3CTf5iMVbeRm5rTo+rrMpana2xQhzJqBHrkrkL469bWM84/dngNaT37Gwc339b0CZccCBV8zcu+tp02m4l/dTbSic3d27UW0KP0CcLztP6urJfBCgRgtjZZXYq/wWsdd2F1p3I2fGlysof9TEPjQ9fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963492; c=relaxed/simple;
	bh=iMRZqmH8OsEOY4REQeT2XfVCvN8JVWYWAkT9gogs/TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+XDFqog+rE+GUp2sNDfM+AyBJnQ/LFdqVp330vh8XrFnOr0r3ShLYZtmrHpS3BwpVWdCaB57eK4NIPgjAQ+I1FfqcLnIvkrlmsUFjTm8SD7sHhJhSeeRS01Q2tLrfZbCim+kMl7dYaNemihDIYSFLYEN5aPbS4p/a5/2XWjmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s+gAuhrT; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730963490; x=1762499490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVejZDrAvAAFEUOkKutuHO/+aAkujnKNglE47apCix8=;
  b=s+gAuhrT4wdBTTFMyZuqJBZwqjWFlEjp1HLHC5uf2qILNEElHADlfWf1
   luAno02/iLo5j+KqGUg8B5B4LeF9kxn6HP+sslXywSbQwsL6178kgZbk9
   WayMuvNQZDiD1qVUCzRWM40TafkCsEUWYhs7hOEptTfoeR2Nef6pFwdZw
   g=;
X-IronPort-AV: E=Sophos;i="6.11,265,1725321600"; 
   d="scan'208";a="773466880"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:11:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6712]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.195:2525] with esmtp (Farcaster)
 id 6e25ea00-769b-40a9-a7cd-d7944eb5b384; Thu, 7 Nov 2024 07:11:23 +0000 (UTC)
X-Farcaster-Flow-ID: 6e25ea00-769b-40a9-a7cd-d7944eb5b384
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 07:11:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 07:11:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to failure in tcp_timewait_state_process
Date: Wed, 6 Nov 2024 23:11:17 -0800
Message-ID: <20241107071117.1022-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoCzJWBN9-0F32a37Ljbx9XbA-in55K8sRjfSicZBGtqbA@mail.gmail.com>
References: <CAL+tcoCzJWBN9-0F32a37Ljbx9XbA-in55K8sRjfSicZBGtqbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 14:51:35 +0800
> On Thu, Nov 7, 2024 at 1:43 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Thu, 7 Nov 2024 13:23:50 +0800
> > > On Thu, Nov 7, 2024 at 12:15 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > Date: Thu, 7 Nov 2024 11:16:04 +0800
> > > > > > Here is how things happen in production:
> > > > > > Time        Client(A)        Server(B)
> > > > > > 0s          SYN-->
> > > > > > ...
> > > > > > 132s                         <-- FIN
> > > > > > ...
> > > > > > 169s        FIN-->
> > > > > > 169s                         <-- ACK
> > > > > > 169s        SYN-->
> > > > > > 169s                         <-- ACK
> > > > >
> > > > > I noticed the above ACK doesn't adhere to RFC 6191. It says:
> > > > > "If the previous incarnation of the connection used Timestamps, then:
> > > > >      if ...
> > > > >      ...
> > > > >      * Otherwise, silently drop the incoming SYN segment, thus leaving
> > > > >          the previous incarnation of the connection in the TIME-WAIT
> > > > >          state.
> > > > > "
> > > > > But the timewait socket sends an ACK because of this code snippet:
> > > > > tcp_timewait_state_process()
> > > > >     -> // the checks of SYN packet failed.
> > > > >     -> if (!th->rst) {
> > > > >         -> return TCP_TW_ACK; // this line can be traced back to 2005
> > > >
> > > > This is a challenge ACK following RFC 5961.
> > >
> > > Please note the idea of challenge ack was proposed in 2010. But this
> > > code snippet has already existed before 2005. If it is a challenge
> > > ack, then at least we need to count it (by using NET_INC_STATS(net,
> > > LINUX_MIB_TCPCHALLENGEACK);).
> >
> > The word was not accurate, the behaviour is compliant with RFC 5961.
> > RFC is often formalised based on real implementations.
> >
> > Incrementing the count makes sense to me.
> >
> > >
> > > >
> > > > If SYN is returned here, the client may lose the chance to RST the
> > > > previous connection in TIME_WAIT.
> > > >
> > > > https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4-2.4.1
> > > > ---8<---
> > > >       -  TIME-WAIT STATE
> > > >
> > > >          o  If the SYN bit is set in these synchronized states, it may
> > > >             be either a legitimate new connection attempt (e.g., in the
> > > >             case of TIME-WAIT), an error where the connection should be
> > > >             reset, or the result of an attack attempt, as described in
> > > >             RFC 5961 [9].  For the TIME-WAIT state, new connections can
> > > >             be accepted if the Timestamp Option is used and meets
> > > >             expectations (per [40]).  For all other cases, RFC 5961
> > > >             provides a mitigation with applicability to some situations,
> > > >             though there are also alternatives that offer cryptographic
> > > >             protection (see Section 7).  RFC 5961 recommends that in
> > > >             these synchronized states, if the SYN bit is set,
> > > >             irrespective of the sequence number, TCP endpoints MUST send
> > > >             a "challenge ACK" to the remote peer:
> > > >
> > > >             <SEQ=SND.NXT><ACK=RCV.NXT><CTL=ACK>
> > > > ---8<---
> > > >
> > > > https://datatracker.ietf.org/doc/html/rfc5961#section-4
> > > > ---8<---
> > > >    1) If the SYN bit is set, irrespective of the sequence number, TCP
> > > >       MUST send an ACK (also referred to as challenge ACK) to the remote
> > > >       peer:
> > > >
> > > >       <SEQ=SND.NXT><ACK=RCV.NXT><CTL=ACK>
> > > >
> > > >       After sending the acknowledgment, TCP MUST drop the unacceptable
> > > >       segment and stop processing further.
> > > > ---8<---
> > >
> > > The RFC 5961 4.2 was implemented in tcp_validate_incoming():
> > >         /* step 4: Check for a SYN
> > >          * RFC 5961 4.2 : Send a challenge ack
> > >          */
> > >         if (th->syn) {
> > >                 if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
> > >                     TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
> > >                     TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
> > >                     TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
> > >                         goto pass;
> > > syn_challenge:
> > >                 if (syn_inerr)
> > >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> > >                 NET_INC_STATS(sock_net(sk),
> > > LINUX_MIB_TCPSYNCHALLENGE);
> > >                 tcp_send_challenge_ack(sk);
> > >                 SKB_DR_SET(reason, TCP_INVALID_SYN);
> > >                 goto discard;
> > >         }
> > >
> > > Also, this quotation you mentioned obviously doesn't match the kernel
> > > implementation:
> > > "If the SYN bit is set, irrespective of the sequence number, TCP MUST
> > > send an ACK"
> > > The tcp_timewait_state_process() does care about the seq number, or
> > > else timewait socket would refuse every SYN packet.
> >
> > That's why I pasted RFC 9293 first that clearly states that we
> > should check seq number and then return ACK for all other cases.
> 
> I don't think so.
> 
> RFC 9293 only states that RFC 5691 provides an approach that mitigates
> the risk by rejecting all the SYN packets if the socket stays in
> synchronized state. It's "For all other cases" in RFC 9293.

RFC 9293 states which RFC to prioritise.  You will find the
link [40] is RFC 6191.

---8<---
For the TIME-WAIT state, new connections can
be accepted if the Timestamp Option is used and meets
expectations (per [40]).  For all other cases, RFC 5961
...
---8<---

> Please loot at "irrespective of the sequence number" in RFC 5691 4.2
> [1]. It means no matter what the seq is we MUST send back an ACK
> instead of establishing a new connection.

RFC 9293 mentions accepatble cases first, so this is only applied
to "all other cases"


> Actually the tcp_timewait_state_process() checks the seq or timestamp
> in the SYN packet.

and this part takes precedence than "all other cases".

Also, you missed that the pasted part is the 4th step of incoming
segment processing.

https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4
---8<---
First, check sequence number: ...
Second, check the RST bit: ...
Third, check security: ...
Fourth, check the SYN bit:
...
  TIME-WAIT STATE
    If the SYN bit is set in these synchronized states...
---8<---

So, RFC 9293 says "check seq number, RST, security, then
if the connection is still accepatable for TIME_WAIT based on
RFC 6191, accept it, otherwise, return ACK based on RFC 5691".

