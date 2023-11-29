Return-Path: <netdev+bounces-51947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108A7FCC95
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB71B2148D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC21854;
	Wed, 29 Nov 2023 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kdrc11qv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7819AB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701223888; x=1732759888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S22GXXiMOiKF+ft2aFZsy6VSm5KeQdoL0mFC1vMoTCc=;
  b=Kdrc11qvo75zfouVG3ENbKpB2W3ZNlP3S9GhX6Ao3OfSy1o8gJWOjfwR
   3/7djmq5Gpducrs6p+DTY0kmxNP9gdZOMfA74LSKV3CzDkvK01tFuZIAf
   lub9LD3lY3vzaw2lNF/vPMt/MlVcMCejLqsY/Uqckad2zo9cKBFLrYO6H
   I=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="256133177"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:11:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id E5D7EA0B81;
	Wed, 29 Nov 2023 02:11:24 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:3188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.37:2525] with esmtp (Farcaster)
 id acd1c3a6-75f3-42a0-ab43-c634bda07a72; Wed, 29 Nov 2023 02:11:24 +0000 (UTC)
X-Farcaster-Flow-ID: acd1c3a6-75f3-42a0-ab43-c634bda07a72
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:11:24 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:11:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 8/8] tcp: Factorise cookie-dependent fields initialisation in cookie_v[46]_check()
Date: Tue, 28 Nov 2023 18:11:12 -0800
Message-ID: <20231129021112.94372-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKBaD+4GyZfee58VikB+MPmOS4uUy4dh1taER9PgB7sdQ@mail.gmail.com>
References: <CANn89iKBaD+4GyZfee58VikB+MPmOS4uUy4dh1taER9PgB7sdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:42:38 +0100
> > @@ -337,40 +326,36 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
> >                 return NULL;
> >         }
> >
> > +       ireq = inet_rsk(req);
> > +       treq = tcp_rsk(req);
> > +
> > +       req->mss = mss;
> > +       req->ts_recent = tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
> > +
> > +       ireq->snd_wscale = tcp_opt->snd_wscale;
> > +       ireq->tstamp_ok = tcp_opt->saw_tstamp;
> > +       ireq->sack_ok = tcp_opt->sack_ok;
> > +       ireq->wscale_ok = tcp_opt->wscale_ok;
> > +       ireq->ecn_ok = tcp_opt->rcv_tsecr & TS_OPT_ECN;
> 
> I doubt this will do what you/we want, because ireq->ecn is not a
> bool, it is a one bit field
> and TS_OPT_ECN != 1.
> 
> I would have used instead :
> 
>  ireq->ecn_ok = !!(tcp_opt->rcv_tsecr & TS_OPT_ECN);

Ah exactly, it was buggy.  I'll fix it in v3.

Thanks for catching!

