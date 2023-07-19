Return-Path: <netdev+bounces-19284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FEA75A2AE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0701C21213
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F122517A;
	Wed, 19 Jul 2023 23:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741422F03
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:15:41 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8861701
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689808540; x=1721344540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGGSJrIROELt4F+SrGAJ04dRX1klRE3DWy8mYDdIq0U=;
  b=Ftw5L5CK7fAjdW6tvIzeqAZpmg/FjUzqtShJJNHgTVZu+QQmJPou9whG
   O0+p0MP/rcyLvR1bBq5Q3qQiuSrYhHwGRG3j6IkAZj4n1WuILaoUAmTui
   +VS85QGRyu+wkQkea470wF+pBMjFfkzSl/t9jPBs1R/Itow0Y6ZTm5DoP
   U=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="17331908"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:15:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 0F47660F42;
	Wed, 19 Jul 2023 23:15:36 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 23:15:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 19 Jul 2023 23:15:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<keescook@chromium.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <leitao@debian.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
Date: Wed, 19 Jul 2023 16:15:23 -0700
Message-ID: <20230719231523.77224-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3DADE655-EE51-4DB0-8CEC-C3791AB12129@kernel.org>
References: <3DADE655-EE51-4DB0-8CEC-C3791AB12129@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kees Cook <kees@kernel.org>
Date: Wed, 19 Jul 2023 15:34:33 -0700
> On July 19, 2023 3:26:35 PM PDT, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >Kuniyuki Iwashima wrote:
> >The extensive comments are really helpful to understand what's
> >going on.
> >
> >An alternative would be to just cast sunaddr to a struct
> >sockaddr_storage *ss and use that both here and in unix_mkname_bsd?
> >It's not immediately trivial that the caller has always actually
> >allocated one of those. But the rest becomes self documenting.

Yeah, this is also my initial attempt, and I separted it because
unix_find_bsd() need not to call it and I tried to separate
unnecessary calls in this series (compilers might drop the unused
strlen() though).

https://lore.kernel.org/netdev/20211124021431.48956-7-kuniyu@amazon.co.jp/


> 
> I would much prefer the internal APIs actually passed around the true sockaddr_storage pointer. This is what I did recently for NFS, for example:
> https://git.kernel.org/linus/cf0d7e7f4520

We can convert struct proto_ops and struct proto later as such
if needed, but I think it's too invasive as a fix.

