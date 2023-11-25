Return-Path: <netdev+bounces-50991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0757F8765
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 02:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6D1C20BE0
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2E631;
	Sat, 25 Nov 2023 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h1L3nWHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737F19A6
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700874312; x=1732410312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xDi2pPo540mrnBAhcSewcUy8mvPNqge0pJ5pnaN7qc=;
  b=h1L3nWHx8L4gBV7D1/BuDRI8PASHXgcPOM4dfQsZUGqAMVMbRavxXFUB
   37Yw54tyfJiITRZqbim97G3tkOVMzX4lEAnlVwtIDTb7hgHFt4cEJxc97
   ZXKGLmO6EjheP0gKYwB/lijNidxPdRAd76a1zgohYoAS0X4T/dNLSzWHz
   s=;
X-IronPort-AV: E=Sophos;i="6.04,224,1695686400"; 
   d="scan'208";a="254745663"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:05:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 2EFEB4944C;
	Sat, 25 Nov 2023 01:05:06 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:1549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id c24b662a-3f70-449d-9eac-d551464fa96b; Sat, 25 Nov 2023 01:05:06 +0000 (UTC)
X-Farcaster-Flow-ID: c24b662a-3f70-449d-9eac-d551464fa96b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:05:03 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:05:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 7/8] tcp: Factorise cookie-independent fields initialisation in cookie_v[46]_check().
Date: Fri, 24 Nov 2023 17:04:52 -0800
Message-ID: <20231125010452.70914-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124214418.GX50352@kernel.org>
References: <20231124214418.GX50352@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Simon Horman <horms@kernel.org>
Date: Fri, 24 Nov 2023 21:44:18 +0000
> On Wed, Nov 22, 2023 at 05:25:20PM -0800, Kuniyuki Iwashima wrote:
> > We will support arbitrary SYN Cookie with BPF, and then some reqsk fields
> > are initialised in kfunc, and others are done in cookie_v[46]_check().
> > 
> > This patch factorises the common part as cookie_tcp_reqsk_init() and
> > calls it in cookie_tcp_reqsk_alloc() to minimise the discrepancy between
> > cookie_v[46]_check().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/syncookies.c | 69 ++++++++++++++++++++++++-------------------
> >  net/ipv6/syncookies.c | 14 ---------
> >  2 files changed, 38 insertions(+), 45 deletions(-)
> > 
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 1e3783c97e28..9bca1c026525 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -285,10 +285,44 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
> >  }
> >  EXPORT_SYMBOL(cookie_ecn_ok);
> >  
> > +static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
> > +				 struct request_sock *req)
> > +{
> > +	struct inet_request_sock *ireq = inet_rsk(req);
> > +	struct tcp_request_sock *treq = tcp_rsk(req);
> > +	const struct tcphdr *th = tcp_hdr(skb);
> > +
> > +	req->num_retrans = 0;
> > +
> > +	ireq->ir_num = ntohs(th->dest);
> > +	ireq->ir_rmt_port = th->source;
> > +	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
> > +	ireq->ir_mark = inet_request_mark(sk, skb);
> > +
> > +	if (IS_ENABLED(CONFIG_SMC))
> > +		ireq->smc_ok = 0;
> > +
> > +	treq->snt_synack = 0;
> > +	treq->tfo_listener = false;
> > +	treq->txhash = net_tx_rndhash();
> > +	treq->rcv_isn = ntohl(th->seq) - 1;
> > +	treq->snt_isn = ntohl(th->ack_seq) - 1;
> > +	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
> > +	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
> 
> Hi Iwashima-san,
> 
> The line above seems to be duplicated.

Ah good catch.
I'll fix it in v2.

Thanks for your review!

pw-bot: cr


> 
> Other than that, this patch looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 
> > +	treq->req_usec_ts = false;
> > +
> > +#if IS_ENABLED(CONFIG_MPTCP)
> > +	treq->is_mptcp = sk_is_mptcp(sk);
> > +	if (treq->is_mptcp)
> > +		return mptcp_subflow_init_cookie_req(req, sk, skb);
> > +#endif
> > +
> > +	return 0;
> > +}
> 

