Return-Path: <netdev+bounces-185767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4BA9BB0B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E753A62DA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA81F8BA6;
	Thu, 24 Apr 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qDCXnrhj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903727F74E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535848; cv=none; b=Ppm5YjZto0NksycpN3l4IiWEvvzk4TG1ywKiP7umEm8eVEKUL3FkcP/zlZKLX4VX829zIQHQhKxtyIIE0+/nXDgOlNGe68tCOaK/E+QNHBRZbBvFwOp/wOkTpda3fnqxw0z6Vw8/Ar+tkxBA02YEbugeYETke6PK24K4lNbbjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535848; c=relaxed/simple;
	bh=ljJ9wRNOLiOX17sDE8H21ADs08DWCRVToM0kN+5Kw0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzJYzmFqTsqJ8CQuJy07DNoegQyjZ3S41XLRwa1G6ECMHGkZZ8mJgLrnXu/M+O6mZVUKoElhWMvpm2IqgLdMrygZ6AP+oRhRSUIDYOCyZtiH+IXVcH5t2cd1O/nomVGy1edK0Vpf91Q7zzycrcHHp2xzhNJ/2p/VoM8yxv7bT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qDCXnrhj; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745535846; x=1777071846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcZ1MfrZ5f+/ia9ZZVpLpLa5DhDwlwcF/4/J97SPA04=;
  b=qDCXnrhjN9vFjDZMTBgvRa90iD4k4feLP23rr0wgbWFPBsae7dokxQTR
   +nVsLXoRnqCRckPXBMWIRAZhu4vI9uHGenLsDgXH4HURL3XsMgjBgTBQD
   RX3bD1gVmepBQi5Nn8bqv7sPSNfrHukcuVwg1zgvDX1I78aObNMAQ32nv
   U=;
X-IronPort-AV: E=Sophos;i="6.15,237,1739836800"; 
   d="scan'208";a="194192462"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:04:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:50789]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id ef374fa8-69d4-4016-b1e7-5984b6ce3090; Thu, 24 Apr 2025 23:04:03 +0000 (UTC)
X-Farcaster-Flow-ID: ef374fa8-69d4-4016-b1e7-5984b6ce3090
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:04:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:04:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 6/7] neighbour: Convert RTM_GETNEIGHTBL to RCU.
Date: Thu, 24 Apr 2025 16:03:44 -0700
Message-ID: <20250424230352.69852-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <bc67444d-3311-43b0-8f68-131e1ef490c7@redhat.com>
References: <bc67444d-3311-43b0-8f68-131e1ef490c7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 24 Apr 2025 10:19:17 +0200
> On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> > neightbl_dump_info() calls neightbl_fill_info() and
> 
> AFAICS neightbl_fill_info() is only invoked from neightbl_dump_info()
> and acquires/releases the RCU internally. Such lock pair should be dropped.

Maybe I got lost, which lock do you mean ??


> 
> > neightbl_fill_param_info() for each neigh_tables[] entry.
> > 
> > Both functions rely on the table lock (read_lock_bh(&tbl->lock)),
> > so RTNL is not needed.
> > 
> > Let's fetch the table under RCU and convert RTM_GETNEIGHTBL to RCU.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/core/neighbour.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index ccfef86bb044..38732d8f0ed7 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -2467,10 +2467,12 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
> >  
> >  	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
> >  
> > +	rcu_read_lock();
> > +
> >  	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
> >  		struct neigh_parms *p;
> >  
> > -		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
> > +		tbl = rcu_dereference(neigh_tables[tidx]);
> >  		if (!tbl)
> >  			continue;
> 
> Later statements:
> 
> 		p = list_next_entry(&tbl->parms, list);
> 		list_for_each_entry_from(p, &tbl->parms_list, list) {
> 
> are now without any protection, and AFAICS parms_list is write protected
> by tbl->lock. I think it's necessary to move the
> read_lock_bh(&tbl->lock) from neightbl_fill_param_info() to
> neightbl_dump_info() ?!?

Oh, thanks for catching this!

Maybe we should use list_add/del_rcu() instead ?
given neigh_parms_release() frees it after RCU.

> 
> Side note: I guess it would be to follow-up replacing R/W lock with
> plain spinlock/rcu?!?

Yes, it's on my todo list ;)

