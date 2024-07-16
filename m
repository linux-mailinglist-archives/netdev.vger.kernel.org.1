Return-Path: <netdev+bounces-111819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C29332F4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037C4281852
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D119E83D;
	Tue, 16 Jul 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Av8eeub8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E63B784
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161707; cv=none; b=iOMDbwgR9WLEdjwuyjgYei+eWdr6Ii0Kpo45bXfohD2NIbjoL/CYtrG0IlPvW3WCVgO3fHopO1dO7o+QGNxXp5y2ygvf8Y9yYRa5PvlqDQ0l/0JG4X16lfn29TkjMplqBo93eg7XKymlV3v2Ma/T9DBDee2LMNYiKHDw2dv+w1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161707; c=relaxed/simple;
	bh=YIqngGCUP2U/ct11MZQvZr1OHI/sbDLiU6peWwFqOPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edKQFpyJNVbDJX+qIYMvWIq8O/u+8O719ZpLV/Ddy/YvHoVV53TSb/wTyFj1bwpYo3N8m1ET21KztCHqu5YJRuD02Zi3lLNVFvlkQOYfUD9GTSNQlnfx9TwspCkBe9LOLg1GTOATH6fK3umW2KAu+8XCzg68o3n6N8D+XsB0UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Av8eeub8; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721161705; x=1752697705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=POPA03pPrJYF22gCrp+lCAg4hI+P0+T2DcBZtm77S+8=;
  b=Av8eeub8Mc9DfUmdyLuyTjZJa+PiIpuKg3fSxWC3rG1DSr6uFXoZ0MxF
   4pBHrx8cvaFpL3C5I6B1xRY7VvMOxPCPuYyw9hxa5MZPlWsF+83H0liqX
   BS+KvcNVAB5HFA5HzMSHQQDsAHvm5tazsAWqATve+e0jhbJPMz5g3CaKf
   g=;
X-IronPort-AV: E=Sophos;i="6.09,212,1716249600"; 
   d="scan'208";a="219281378"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:28:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:32607]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.141:2525] with esmtp (Farcaster)
 id fe152581-a049-4744-8fce-c79dcaf68c2a; Tue, 16 Jul 2024 20:28:22 +0000 (UTC)
X-Farcaster-Flow-ID: fe152581-a049-4744-8fce-c79dcaf68c2a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 16 Jul 2024 20:28:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 16 Jul 2024 20:28:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matttbe@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
Date: Tue, 16 Jul 2024 13:28:08 -0700
Message-ID: <20240716202808.6376-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <31eb13bf-7ea9-436f-92a9-a8745ed86f9e@kernel.org>
References: <31eb13bf-7ea9-436f-92a9-a8745ed86f9e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:04:25 +0200
> Hi Kuniyuki,
> 
> Thank you for your reply!
> 
> On 16/07/2024 21:23, Kuniyuki Iwashima wrote:
> > Hi Matthieu,
> > 
> > From: Matthieu Baerts <matttbe@kernel.org>
> > Date: Mon, 15 Jul 2024 17:58:49 +0200
> >> Hi Kuniyuki,
> >>
> >> On 10/07/2024 19:12, Kuniyuki Iwashima wrote:
> >>> RFC 9293 states that in the case of simultaneous connect(), the connection
> >>> gets established when SYN+ACK is received. [0]
> >>>
> >>>       TCP Peer A                                       TCP Peer B
> >>>
> >>>   1.  CLOSED                                           CLOSED
> >>>   2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...
> >>>   3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT
> >>>   4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED
> >>>   5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...
> >>>   6.  ESTABLISHED  <-- <SEQ=300><ACK=101><CTL=SYN,ACK> <-- SYN-RECEIVED
> >>>   7.               ... <SEQ=100><ACK=301><CTL=SYN,ACK> --> ESTABLISHED
> >>>
> >>> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such a
> >>> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challenge
> >>> ACK.
> >>>
> >>> For example, the write() syscall in the following packetdrill script fails
> >>> with -EAGAIN, and wrong SNMP stats get incremented.
> >>>
> >>>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
> >>>   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
> >>>
> >>>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> >>>   +0 < S  0:0(0) win 1000 <mss 1000>
> >>>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
> >>>   +0 < S. 0:0(0) ack 1 win 1000
> >>>
> >>>   +0 write(3, ..., 100) = 100
> >>>   +0 > P. 1:101(100) ack 1
> >>>
> >>>   --
> >>>
> >>>   # packetdrill cross-synack.pkt
> >>>   cross-synack.pkt:13: runtime error in write call: Expected result 100 but got -1 with errno 11 (Resource temporarily unavailable)
> >>>   # nstat
> >>>   ...
> >>>   TcpExtTCPChallengeACK           1                  0.0
> >>>   TcpExtTCPSYNChallenge           1                  0.0
> >>>
> >>> The problem is that bpf_skops_established() is triggered by the Challenge
> >>> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> >>> check if the peer supports a TCP option that is expected to be exchanged
> >>> in SYN and SYN+ACK.
> >>>
> >>> Let's accept a bare SYN+ACK for active-open TCP_SYN_RECV sockets to avoid
> >>> such a situation.
> >>>
> >>> Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not to
> >>> send an unnecessary ACK, but this could be a bit risky for net.git, so this
> >>> targets for net-next.
> >>>
> >>> Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> >>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >>
> >> Thank you for having worked on this patch!
> >>
> >>> ---
> >>>  net/ipv4/tcp_input.c | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>> index 47dacb575f74..1eddb6b9fb2a 100644
> >>> --- a/net/ipv4/tcp_input.c
> >>> +++ b/net/ipv4/tcp_input.c
> >>> @@ -5989,6 +5989,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
> >>>  	 * RFC 5961 4.2 : Send a challenge ack
> >>>  	 */
> >>>  	if (th->syn) {
> >>> +		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
> >>> +		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
> >>> +		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
> >>> +		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
> >>> +			goto pass;
> >>>  syn_challenge:
> >>>  		if (syn_inerr)
> >>>  			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> >>> @@ -5998,6 +6003,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
> >>>  		goto discard;
> >>>  	}
> >>>  
> >>> +pass:
> >>>  	bpf_skops_parse_hdr(sk, skb);
> >>>  
> >>>  	return true;
> >>> @@ -6804,6 +6810,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
> >>>  		tcp_fast_path_on(tp);
> >>>  		if (sk->sk_shutdown & SEND_SHUTDOWN)
> >>>  			tcp_shutdown(sk, SEND_SHUTDOWN);
> >>> +
> >>> +		if (sk->sk_socket)
> >>> +			goto consume;
> >>
> >> It looks like this modification changes the behaviour for MPTCP Join
> >> requests for listening sockets: when receiving the 3rd ACK of a request
> >> adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
> >> MPTCP sock that has been created when the MPTCP connection got created
> >> before with the first path.
> > 
> > Thanks for catching this!
> > 
> > I completely missed how MPTCP sets sk->sk_socket before the 3rd ACK is
> > processed.
> 
> No problem. That's a shame there was not a clear error in the selftests :)
> 
> > I debugged a bit and confirmed mptcp_stream_accept() sets
> > the inflight subflow's sk->sk_socket with newsk->sk_socket.
> 
> Yes, that's correct.
> 
> >> This new 'goto' here will then skip the
> >> process of the segment text (step 7) and not go through tcp_data_queue()
> >> where the MPTCP options are validated, and some actions are triggered,
> >> e.g. sending the MPJ 4th ACK [1].
> >>
> >> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> >> delayed,
> > 
> > Yes, the test failure depends on timing.  I only reproduced it by running
> > the test many times on non-kvm qemu.
> 
> Thank you for having checked!
> 
> >> but it looks like it affects the MPTFO feature as well --
> >> probably in case of retransmissions I suppose -- and being the reason
> >> why the selftests started to be unstable the last few days [2].
> >>
> >> [1] https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens
> >> [2]
> >> https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh
> >>
> >>
> >> Looking at what this patch here is trying to fix, I wonder if it would
> >> not be enough to apply this patch:
> >>
> >>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>> index ff9ab3d01ced..ff981d7776c3 100644
> >>> --- a/net/ipv4/tcp_input.c
> >>> +++ b/net/ipv4/tcp_input.c
> >>> @@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
> >>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
> >>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
> >>>  
> >>> -               if (sk->sk_socket)
> >>> +               if (sk->sk_socket && !sk_is_mptcp(sk))
> >>>                         goto consume;
> >>>                 break;
> >>>  
> >>
> >> But I still need to investigate how the issue that is being addressed by
> >> your patch can be translated to the MPTCP case. I guess we could add
> >> additional checks for MPTCP: new connection or additional path? etc. Or
> >> maybe that's not needed.
> > 
> > My first intention was not to drop SYN+ACK in tcp_validate_incoming(),
> > and the goto is added in v2, which is rather to be more compliant with
> > RFC not to send an unnecessary ACK for simultaneous connect().
> > 
> > So, we could rewrite the condition as this,
> > 
> >   if (sk->sk_socket && !th->syn)
> 
> (Just to be sure, do you mean the opposite with th->syn?)

Ah, yes :)


> 
>   if (sk->sk_socket && th->syn)
>       goto consume;
> 
> That's a good idea!
> 
> I sent my patch a couple of minutes ago [1], then I saw your suggestion
> here. It looks like it should work for the TFO case as well. Maybe your
> suggestion is more generic and will cover more cases?

Likely, I was just trying to avoid unnecessary change and make the effect
minimal.


> 
> [1]
> https://lore.kernel.org/all/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org/
> 
> > but I think your patch is better to give a hint that MPTCP has a
> > different logic.
> 
> Because TFO has also a different logic, it might be good to have a clear
> comment about that.

Exactly, TFO could be accept()ed before receiving ACK, and then
we must not drop ACK w/ data.


> 
> > Also, a similar check done before the goto, and this could be
> > improved ?
> > 
> >   if (sk->sk_socket)
> >     sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
> 
> It is a bit late for me, but I think it can be kept as it is: for MPTCP,
> it will not wake up the userspace as the subflow is managed by the
> kernel. I would need to check if we could avoid that. Also, will this
> wakeup not be useful for TFO?

Yes, I think it's not necessary for TFO.

