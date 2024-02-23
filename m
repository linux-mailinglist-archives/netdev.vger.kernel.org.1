Return-Path: <netdev+bounces-74530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD3E861C67
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF561C22143
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA3143C40;
	Fri, 23 Feb 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BPlRhZnK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13F140362
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716113; cv=none; b=B+TYE3HzqppLuOLPA1S7BgrvdzlOotbCqsjnJSvjqNVLmp1trShaKHLqeEmdDawFk+Zb44jB5wwI4u+CG74P7K9KkOfqA53jISd4P6hHemd8AYBqcB9lJ+3AKR5P/OfRkvdSuUC5cTRQNfnrDZXUU3o0R4W5imdXmWWS18omK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716113; c=relaxed/simple;
	bh=AqZS8NnJdxm1lqWUhnn1aVRw9hxKXy3kgTZra6s2YYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJ1MMNbv8VgrgEZvTaH/aX8HM5y4ydYSnbT+XQJbi00adEboRh9LcxKGu4xUsdoQuMWi5S1jN6YiDwYciatgKHpr9OF9wFggYAoVfpGpKB9WhL3lpT29lXnY3wdAPJkEK2YmxjFAZGSH37R+WY8eKSRntvJTdqkWGa2NEA+0dIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BPlRhZnK; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716111; x=1740252111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8ONpM84Yp4y2K8HRm/b4OLFOFOnlifszPatXmBRDSA=;
  b=BPlRhZnK5GOiN1WCBJGdQ21sU/W8iN/FckLf6bQ0pojMT2VdeehSQhak
   PFwwZOWDF39z9k7CCnUtf/DzMvo6NeIYAE4pl7qiTinME70IxV6iKYegM
   570usbaEpsC7Ur8MrY4hCPsERN8vQRlZz+4KxSOkjaPCCWWplTSAHOZz+
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="68348794"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:21:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:9395]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.221:2525] with esmtp (Farcaster)
 id b8987f6f-4e40-479c-aff3-7b51546768b4; Fri, 23 Feb 2024 19:21:49 +0000 (UTC)
X-Farcaster-Flow-ID: b8987f6f-4e40-479c-aff3-7b51546768b4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:21:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 19:21:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kerneljasonxing@gmail.com>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 02/10] tcp: directly drop skb in cookie check for ipv4
Date: Fri, 23 Feb 2024 11:21:38 -0800
Message-ID: <20240223192138.4702-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223191736.4152-1-kuniyu@amazon.com>
References: <20240223191736.4152-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 23 Feb 2024 11:17:36 -0800
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 23 Feb 2024 18:28:43 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
> > no other changes made. It can help us refine the specific drop reasons
> > later.
> > 
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> > --
> > v9
> > Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> > 1. add reviewed-by tag (David)
> > 
> > v8
> > Link: https://lore.kernel.org/netdev/CANn89i+foA-AW3KCNw232eCC5GDi_3O0JG-mpvyiQJYuxKxnRA@mail.gmail.com/
> > 1. add reviewed-by tag (Eric)
> > 
> > v7
> > Link: https://lore.kernel.org/all/20240219041350.95304-1-kuniyu@amazon.com/
> > 1. add reviewed-by tag (Kuniyuki)
> > ---
> >  net/ipv4/syncookies.c | 4 ++++
> >  net/ipv4/tcp_ipv4.c   | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index be88bf586ff9..38f331da6677 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >  	struct rtable *rt;
> >  	__u8 rcv_wscale;
> >  	int full_space;
> > +	SKB_DR(reason);
> >  
> >  	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> >  	    !th->ack || th->rst)
> > @@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >  	 */
> >  	if (ret)
> >  		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> > +	else
> > +		goto out_drop;
> 
> nit: It would be nice to use the same style with IPv6 change.
> 
> 	if (!ret)
> 		goto out_drop;
> 
> 	inet_sk(ret)->cork.fl.u.ip4 = fl4;

I just noticed you changed so in the next patch, so please
ignore my comment.

