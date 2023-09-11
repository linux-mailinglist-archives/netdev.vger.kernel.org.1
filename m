Return-Path: <netdev+bounces-32922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A179AB25
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F390D28134A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BC15AE6;
	Mon, 11 Sep 2023 20:06:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01E156C3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:06:18 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE799CC
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694462777; x=1725998777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rlvDfjpAo/wPnER6RvRmh8oXtLNDP/gcO1+v9ZP931g=;
  b=n3WNQ9szo5KCuleZ2Xl+/vHca33SROHVqoKTHSBakh8ZxZDCP1/64dPo
   9acEvbu6UIVqyTZ4kSyQWGgKvSz11AeS60zzgnRapHuF72kBYy7rtrqEQ
   Yr90dJ4jBLqJlvxBY0gyv2u3XiC5Mr7usW5cN+D/gEUsEoIIYDAH6EOFu
   s=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="670851223"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:06:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 75A5F35C451;
	Mon, 11 Sep 2023 20:06:03 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 20:05:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 20:05:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <avagin@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<joannelkoong@gmail.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 1/5] tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
Date: Mon, 11 Sep 2023 13:05:43 -0700
Message-ID: <20230911200543.78783-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEWA0a5t+XfrP6BvWCVg2P8e05Bpu2hd7OpmKnB2NVYLwRmcAg@mail.gmail.com>
References: <CAEWA0a5t+XfrP6BvWCVg2P8e05Bpu2hd7OpmKnB2NVYLwRmcAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SORTED_RECIPS,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrei Vagin <avagin@google.com>
Date: Mon, 11 Sep 2023 13:00:19 -0700
> On Mon, Sep 11, 2023 at 9:52 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Andrei Vagin reported bind() regression with strace logs.
> >
> > If we bind() a TCPv6 socket to ::FFFF:0.0.0.0 and then bind() a TCPv4
> > socket to 127.0.0.1, the 2nd bind() should fail but now succeeds.
> >
> >   from socket import *
> >
> >   s1 = socket(AF_INET6, SOCK_STREAM)
> >   s1.bind(('::ffff:0.0.0.0', 0))
> >
> >   s2 = socket(AF_INET, SOCK_STREAM)
> >   s2.bind(('127.0.0.1', s1.getsockname()[1]))
> >
> > During the 2nd bind(), if tb->family is AF_INET6 and sk->sk_family is
> > AF_INET in inet_bind2_bucket_match_addr_any(), we still need to check
> > if tb has the v4-mapped-v6 wildcard address.
> >
> > The example above does not work after commit 5456262d2baa ("net: Fix
> > incorrect address comparison when searching for a bind2 bucket"), but
> > the blamed change is not the commit.
> >
> > Before the commit, the leading zeros of ::FFFF:0.0.0.0 were treated
> > as 0.0.0.0, and the sequence above worked by chance.  Technically, this
> > case has been broken since bhash2 was introduced.
> >
> > Note that if we bind() two sockets to 127.0.0.1 and then ::FFFF:0.0.0.0,
> > the 2nd bind() fails properly because we fall back to using bhash to
> > detect conflicts for the v4-mapped-v6 address.
> 
> I think we have one more issue here:
> 
> socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 3
> socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 4
> bind(3, {sa_family=AF_INET6, sin6_port=htons(9999),
> sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::ffff:127.0.0.1",
> &sin6_addr), sin6_scope_id=0}, 28) = 0
> bind(4, {sa_family=AF_INET, sin_port=htons(9999),
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0
> 
> I think the second bind has to return EADDRINUSE, doesn't it?

Correct, and the following patch fixes it separately.
Sorry, I forgot to add you in CC of the entire series.
https://lore.kernel.org/netdev/20230911183700.60878-4-kuniyu@amazon.com/

