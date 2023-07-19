Return-Path: <netdev+bounces-19261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6575A0AC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864151C20FB0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8D22F1B;
	Wed, 19 Jul 2023 21:39:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768714A8B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:39:20 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA551FCD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689802758; x=1721338758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDagl80bAgLG3sJrPSV39DW+F2EN1xNPIokLQQk7Sn0=;
  b=V8YgnuUWnr76xs81J5w7rXOyxSQ2V59S316Po5tPs+dRhoP4y5QF0NNg
   JkDc7vnnh9Oqo6ZmdAhXRIQVxJjDThFp8cbR8OK7Qaos/xPAqwLdsdMcH
   R4PUodpF8eR8WN5k8PArL+pN2AnZ/vEEUpewsBLEMSC50THGiSiAdBBSh
   U=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="17318659"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 21:39:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 3A87840D5C;
	Wed, 19 Jul 2023 21:39:16 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 21:39:15 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 21:39:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<keescook@chromium.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <leitao@debian.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: RE: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Wed, 19 Jul 2023 14:39:03 -0700
Message-ID: <20230719213903.65060-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <64b856d553b5b_2842f2294f0@willemb.c.googlers.com.notmuch>
References: <64b856d553b5b_2842f2294f0@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 19 Jul 2023 17:34:13 -0400
> > > > The write seems to overflow, but actually not since we use struct
> > > > sockaddr_storage defined in __sys_getsockname().
> > > 
> > > Which gives _K_SS_MAXSIZE == 128, minus offsetof(struct sockaddr_ll, sll_addr).
> > > 
> > > For fun, there is another caller. getsockopt SO_PEERNAME also calls
> > > sock->ops->getname, with a buffer hardcoded to 128. Should probably
> > > use sizeof(sockaddr_storage) for documentation, at least.
> > > 
> > > .. and I just noticed that that was attempted, but not completed
> > > https://lore.kernel.org/lkml/20140928135545.GA23220@type.youpi.perso.aquilenet.fr/
> > 
> > Yes, acutally my first draft had the diff below, but I dropped it
> > because packet_getname() does not call memcpy() for SO_PEERNAME at
> > least, and same for getpeername().
> > 
> > And interestingly there was a revival thread.
> > https://lore.kernel.org/netdev/20230719084415.1378696-1-leitao@debian.org/
> 
> Ah interesting :) Topical.
> 
> > I can include this in v2 if needed.
> > What do you think ?
> > 
> > ---8<---
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9370fd50aa2c..f1e887c3115f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1815,14 +1815,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> >  
> >  	case SO_PEERNAME:
> >  	{
> > -		char address[128];
> > +		struct sockaddr_storage address;
> >  
> > -		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
> > +		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
> >  		if (lv < 0)
> >  			return -ENOTCONN;
> >  		if (lv < len)
> >  			return -EINVAL;
> > -		if (copy_to_sockptr(optval, address, len))
> > +		if (copy_to_sockptr(optval, &address, len))
> >  			return -EFAULT;
> >  		goto lenout;
> >  	}
> > ---8<---
> 
> I agree that it's a worthwhile change. I think it should be an
> independent commit. And since it does not fix a bug, target net-next.

Sure, will post a patch to net-next later.

