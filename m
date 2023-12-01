Return-Path: <netdev+bounces-53110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A84801546
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17291F20FE6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93658ADA;
	Fri,  1 Dec 2023 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pWhxQwVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE110D0
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701465836; x=1733001836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cb5pnKIBWipBH04KnRN+JEClK7sATv3FlgnhNC423l8=;
  b=pWhxQwVd4tJ/UMW2mpKxgkj0Grw5ZGL8GmrrcRseeQDrXZicJgtvZPsi
   vBL0j8lHWWR6/dMGFwvOPOGWFvDipsTIJVlfP23Xx0/Mc2N/iNddPCQAR
   VbC69MUKiFa+KEVt1kKpmlfs8yvjW98JulkZDvwHQbhQZ2XzORg5gutkz
   w=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="622842237"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 21:23:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 66E1B80730;
	Fri,  1 Dec 2023 21:23:51 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:21567]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 31604753-fddd-4689-be68-731708eb7a87; Fri, 1 Dec 2023 21:23:50 +0000 (UTC)
X-Farcaster-Flow-ID: 31604753-fddd-4689-be68-731708eb7a87
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 1 Dec 2023 21:23:47 +0000
Received: from 88665a182662.ant.amazon.com (10.118.249.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 21:23:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mkubecek@suse.cz>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
Date: Fri, 1 Dec 2023 13:23:34 -0800
Message-ID: <20231201212334.28857-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>
References: <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 21:41:16 +0100
> On Fri, Dec 1, 2023 at 9:34 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Guillaume Nault <gnault@redhat.com>
> 
> > > +                                             goto next_bind;
> > > +
> > > +                                     if (sk->sk_state != TCP_CLOSE ||
> > > +                                         !inet->inet_num)
> >
> > Sorry for missing this in the previous version, but I think
> > inet_num is always non-zero because 0 selects a port automatically
> > and the min of ipv4_local_port_range is 1.
> >
> 
> This is not true, because it can be cleared by another thread, before
> unhashing happens in __inet_put_port()
> 
> Note the test should use READ_ONCE(inet->inet_num), but I did not
> mention this, as many reads of inet_num are racy.

Ah exactly, the order of __sk_del_bind_node() and the clearance was not
guaranteed.

Thanks!

