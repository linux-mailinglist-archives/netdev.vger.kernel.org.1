Return-Path: <netdev+bounces-102757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4CA9047A5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388B281B32
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59DC155A5D;
	Tue, 11 Jun 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SMgKaM6U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71B155726
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148218; cv=none; b=eg30XnMoIpXb70iK/HJmVjgiZcGQ9OAcTYOGd1xl2ntyBVFMzVkWdfFWzAsWk05Z7mGEVIztndx7LWiL2nl0JQyDh9A+MlHFn7fRK3c87fT+WARlSsapAfrn5l4saZJmngzr7ZZNI5TQCICrJ7B0Pa54UJr3i8i8IhfJ5IcAzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148218; c=relaxed/simple;
	bh=jXO9LKSkRUmXP4oc50ZIPRE3L2TxpCdx5su+RtG4zFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHQUfBjHST9PwDGfx4g5HZhdSLO/xBMjO+yKISjP2g0ze2ZL4/rqZGSQKjeXn+YWshSflsxSumNJpJyGdB5T6AwnFCCsymeV+sIeGBoByFF172Q+p6cel0P/ym0TtDlBrZlB5qGoxiPvb01whmx+n6x2nIBjiPvHrQ9DiGASgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SMgKaM6U; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718148218; x=1749684218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGBZ6PASnoas7JWsjoROPiq8rLN2XAVxG7zw8xSMMmI=;
  b=SMgKaM6U1tYCYEBQkqGoddJ4sDyW80gTkxoavrUUCA7SH7XrKg0wMnL6
   a0BOnOiOeI7R3/FW9MNiEbCb57EB6sLZCJg+DHl2Nxg6R4dwfeH3StoGX
   dJ95dAOP88xD5h8ia3e2XZG+I8zpCFFBu3U9MpEXkNf0wmbIBb2UOQtHS
   g=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="732269071"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:23:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:58441]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.123:2525] with esmtp (Farcaster)
 id cb9bdd64-c207-421b-b250-930a75de5a97; Tue, 11 Jun 2024 23:23:31 +0000 (UTC)
X-Farcaster-Flow-ID: cb9bdd64-c207-421b-b250-930a75de5a97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 23:23:30 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 23:23:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Date: Tue, 11 Jun 2024 16:23:20 -0700
Message-ID: <20240611232320.39523-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <vqp2bzsg2sr6iol4sfbay27trj2gss663yroygrhb6lolmsbqn@sqw732yecjsn>
References: <vqp2bzsg2sr6iol4sfbay27trj2gss663yroygrhb6lolmsbqn@sqw732yecjsn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Tue, 11 Jun 2024 19:17:53 -0400
> On Tue, Jun 11, 2024 at 03:29:02PM GMT, Kuniyuki Iwashima wrote:
> > While GC is cleaning up cyclic references by SCM_RIGHTS,
> > unix_collect_skb() collects skb in the socket's recvq.
> > 
> > If the socket is TCP_LISTEN, we need to collect skb in the
> > embryo's queue.  Then, both the listener's recvq lock and
> > the embroy's one are held.
> > 
> > The locking is always done in the listener -> embryo order.
> > 
> > Let's define it as unix_recvq_lock_cmp_fn() instead of using
> > spin_lock_nested().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 17 +++++++++++++++++
> >  net/unix/garbage.c |  8 +-------
> >  2 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 8d03c5ef61df..8959ee8753d1 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -170,6 +170,21 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
> >  	/* unix_state_double_lock(): ascending address order. */
> >  	return cmp_ptr(a, b);
> >  }
> > +
> > +static int unix_recvq_lock_cmp_fn(const struct lockdep_map *_a,
> > +				  const struct lockdep_map *_b)
> > +{
> > +	const struct sock *a, *b;
> > +
> > +	a = container_of(_a, struct sock, sk_receive_queue.lock.dep_map);
> > +	b = container_of(_b, struct sock, sk_receive_queue.lock.dep_map);
> > +
> > +	/* unix_collect_skb(): listener -> embryo order. */
> > +	if (a->sk_state == TCP_LISTEN && unix_sk(b)->listener == a)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> >  #endif
> 
> That's not symmetric.

I think we agreed this is allowed, no ?

https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo/

