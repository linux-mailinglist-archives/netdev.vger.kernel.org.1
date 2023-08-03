Return-Path: <netdev+bounces-24223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDE76F499
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0501C2167E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD5263BD;
	Thu,  3 Aug 2023 21:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66692591C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 21:25:48 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D0E43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691097947; x=1722633947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgigqa525z8iQ7yYmrvQSSTqdM0vKec+wn/MaTrFL5I=;
  b=YhiKIEoTXtVffTudWnbz04PUraG0g9QchKbKfmlPTnMXof1/FTs2xQUp
   FjbUHwycJde2PClaEWxKot+wLqbaNSqKlDY/86x4NKWU6mjZBSbA1r3Th
   iNQAzrGVh+VUPX7h3jiMpgi3n6sfph1fOfUT7PLrhBP3VvAA9mDLSFTDx
   w=;
X-IronPort-AV: E=Sophos;i="6.01,253,1684800000"; 
   d="scan'208";a="298509945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:25:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id D7813807E9;
	Thu,  3 Aug 2023 21:25:37 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 21:25:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 21:25:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH v2 net] tcp: Enable header prediction for active open connections with MD5.
Date: Thu, 3 Aug 2023 14:25:25 -0700
Message-ID: <20230803212525.59438-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
References: <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.100.14]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Aug 2023 08:44:14 +0200
> On Thu, Aug 3, 2023 at 6:22 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > TCP socket saves the minimum required header length in tcp_header_len
> > of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
> > to generate a part of TCP header in tcp_sock(sk)->pred_flags.
> >
> > In tcp_rcv_established(), if the incoming packet has the same pattern
> > with pred_flags, we enter the fast path and skip full option parsing.
> >
> > The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> > again later in tcp_rcv_established() unless other options exist.  Thus,
> > MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
> > slow path.
> >
> > For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> > to tcp_header_len in tcp_create_openreq_child() after 3WHS.
> >
> > On the other hand, we do it in tcp_connect_init() for active open
> > connections.  However, the value is overwritten while processing
> > SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
> >
> >   1) SYN+ACK
> >
> >     tcp_rcv_synsent_state_process
> >       tp->tcp_header_len = sizeof(struct tcphdr) or
> >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
> >       tcp_finish_connect
> >         __tcp_fast_path_on
> >       tcp_send_ack
> >
> >   2) Crossed SYN and the following ACK
> >
> >     tcp_rcv_synsent_state_process
> >       tp->tcp_header_len = sizeof(struct tcphdr) or
> >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
> >       tcp_set_state(sk, TCP_SYN_RECV)
> >       tcp_send_synack
> >
> >     -- ACK received --
> >     tcp_v4_rcv
> >       tcp_v4_do_rcv
> >         tcp_rcv_state_process
> >           tcp_fast_path_on
> >             __tcp_fast_path_on
> >
> > So these two cases will have the wrong value in pred_flags and never
> > go into the fast path.
> >
> > Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
> > to enable header prediction for active open connections.
> 
> I do not think we want to slow down fast path (no MD5), for 'header
> prediction' of MD5 flows,
> considering how slow MD5 is anyway (no GSO/GRO), and add yet another
> ugly #ifdef CONFIG_TCP_MD5SIG
> in already convoluted code base.
> 
> The case of cross-syn is kind of hilarious, if you ask me.
> 
> >
> > Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> 
> This would be net-next material anyway, unless you show a huge
> improvement after this patch,
> which I doubt very much.

I just noticed the MD5 does not add TCPOLEN_MD5SIG_ALIGNED and thought
it would benefit from the fast path, but sorry, you were correct.

I have tested with slightly modified netperf that uses MD5 for each
flow and found that the patch does not improve MD5 perf at all.  Rather,
without all TCPOLEN_MD5SIG_ALIGNED addition in tcp_connect_init() and
tcp_create_openreq_child(), the slow path became the faster path for MD5.

  On c5.4xlarge EC2 instance (16 vCPU, 32 GiB mem)

  $ for i in {1..10}; do
  ./super_netperf $(nproc) -H localhost -l 10 -- -m 256 -M 256 2>/dev/null;
  done

  - 36e68eadd303  : 10.376 Gbps
  - all fast path : 10.374 Gbps
  - all slow path : 10.394 Gbps

I'll post v3 that disable fast path for MD5 instead.

Thanks!

