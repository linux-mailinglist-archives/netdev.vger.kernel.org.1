Return-Path: <netdev+bounces-51395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089117FA86A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69055B20F4E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0F3BB36;
	Mon, 27 Nov 2023 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UfbNmY3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4A12C
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701107823; x=1732643823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45mU2Zxm9HBcAp8gHlB5IiaQJ9jodamTV+PylKigDDU=;
  b=UfbNmY3DsFtVv5t/bKbJL2nlLmKhE6Z12KL3YctKQLtjzMV8wOX2g5y2
   mwg6wgeM7O/5JQjwfUDbsFRC7wTIvQ0hqR3WRmW0yTZ2vIZiUUzK/oPly
   dkC6KX9wB4Eq8DgUzIjrw5Ykfiw+I8yClOmCacH3RG1oEsHRnamCxo/Ia
   o=;
X-IronPort-AV: E=Sophos;i="6.04,231,1695686400"; 
   d="scan'208";a="168569045"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 17:57:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 66202A0FEC;
	Mon, 27 Nov 2023 17:56:58 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:46833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id ba5a46ef-d0c2-4aed-8c2a-f7822352985b; Mon, 27 Nov 2023 17:56:57 +0000 (UTC)
X-Farcaster-Flow-ID: ba5a46ef-d0c2-4aed-8c2a-f7822352985b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 17:56:57 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 27 Nov 2023 17:56:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnault@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mkubecek@suse.cz>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Date: Mon, 27 Nov 2023 09:56:43 -0800
Message-ID: <20231127175643.28505-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZWTRLVuFF+575qrI@debian>
References: <ZWTRLVuFF+575qrI@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Guillaume Nault <gnault@redhat.com>
Date: Mon, 27 Nov 2023 18:26:05 +0100
> On Fri, Nov 24, 2023 at 05:39:42PM -0800, Kuniyuki Iwashima wrote:
> > > +			spin_lock_bh(&ibb->lock);
> > > +			inet_bind_bucket_for_each(tb2, &ibb->chain) {
> > > +				if (!net_eq(ib2_net(tb2), net))
> > > +					continue;
> > > +
> > > +				sk_for_each_bound_bhash2(sk, &tb2->owners) {
> > > +					struct inet_sock *inet = inet_sk(sk);
> > > +
> > > +					if (num < s_num)
> > > +						goto next_bind;
> > > +
> > > +					if (sk->sk_state != TCP_CLOSE ||
> > > +					    !inet->inet_num)
> > > +						goto next_bind;
> > > +
> > > +					if (r->sdiag_family != AF_UNSPEC &&
> > > +					    r->sdiag_family != sk->sk_family)
> > > +						goto next_bind;
> > > +
> > > +					if (!inet_diag_bc_sk(bc, sk))
> > > +						goto next_bind;
> > > +
> > > +					if (!refcount_inc_not_zero(&sk->sk_refcnt))
> > > +						goto next_bind;
> > 
> > I guess this is copied from the ehash code below, but could
> > refcount_inc_not_zero() fail for bhash2 under spin_lock_bh() ?
> 
> My understanding is that it can't fail, but I prefered to keep the test
> to be on the safe side.
> 
> I can post a v3 using a plain sock_hold(), if you prefer.

I prefer sock_hold() because refcount_inc_not_zero() implies that it could
fail and is confusing if it never fails.

