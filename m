Return-Path: <netdev+bounces-103705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B790929D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E68B21215
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55EE1A01C5;
	Fri, 14 Jun 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NCpAroF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA449638
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391370; cv=none; b=Wok2jy3KtIYaY29SMoDz6cdXd9ln3pDJY3kNYA1ume6Es5xoAn3aJ7Izw4kXQSn4nFG46X9vqvjuPHVc13kn64CGAQV70Rh4ap6fLCqmXFJv2HPfFCmfMZO1fyAp178nQ9ZfGYlTBEfAtwyeY33U+5rBFa8p6T3zVtZ+UeEvEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391370; c=relaxed/simple;
	bh=jF3tiS1JEyL81Yf9rH0oOmLb9UlSLVwCGgfihnbpVpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3D7YLprnnN56WxLTrWOSaq71VCxTWLRrFoz9zQJy/XaM/WZCgkr+VGPGauhNo8YzI87r+lD1rHHiCc43IzNwB7xYR5n4VU1yKUCkC5/p8h8QZBozFvjbxdV+s/Q55y3plLefiyektGmIX7EU0h3TWqvpcr1eikPjaJ18C2E/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NCpAroF4; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718391370; x=1749927370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFs679RKFAbdi+jdCnZSGgy0BgBTxkYviv4qVaxB740=;
  b=NCpAroF4xLoDP5syTvRSLVN3FhmefY/U/ckdzYqO45QuHpzwApRaUnhN
   AoinRWB7vgKHaJuWhbfex4FSEp6wni2Hp2dHDoJvGpPg9tChZY3h5Clyw
   PCJDp3N3wBFTLQZR+9UAKBPArKBWXdn0qR/2uqxAY6SuBT4/7iLkiAlEQ
   o=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="639467678"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 18:56:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:7820]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id 5a18c6c4-11a5-4ec4-aa1d-0cbfd5a61d97; Fri, 14 Jun 2024 18:56:06 +0000 (UTC)
X-Farcaster-Flow-ID: 5a18c6c4-11a5-4ec4-aa1d-0cbfd5a61d97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 18:56:05 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 18:56:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kent.overstreet@linux.dev>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Date: Fri, 14 Jun 2024 11:55:54 -0700
Message-ID: <20240614185554.86292-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <fe71aefbd50babf1af7c4719f5581e46fce2b4fc.camel@redhat.com>
References: <fe71aefbd50babf1af7c4719f5581e46fce2b4fc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 14 Jun 2024 13:04:06 +0200
> On Tue, 2024-06-11 at 16:23 -0700, Kuniyuki Iwashima wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > Date: Tue, 11 Jun 2024 19:17:53 -0400
> > > On Tue, Jun 11, 2024 at 03:29:02PM GMT, Kuniyuki Iwashima wrote:
> > > > While GC is cleaning up cyclic references by SCM_RIGHTS,
> > > > unix_collect_skb() collects skb in the socket's recvq.
> > > > 
> > > > If the socket is TCP_LISTEN, we need to collect skb in the
> > > > embryo's queue.  Then, both the listener's recvq lock and
> > > > the embroy's one are held.
> > > > 
> > > > The locking is always done in the listener -> embryo order.
> > > > 
> > > > Let's define it as unix_recvq_lock_cmp_fn() instead of using
> > > > spin_lock_nested().
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/unix/af_unix.c | 17 +++++++++++++++++
> > > >  net/unix/garbage.c |  8 +-------
> > > >  2 files changed, 18 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index 8d03c5ef61df..8959ee8753d1 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > > @@ -170,6 +170,21 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
> > > >  	/* unix_state_double_lock(): ascending address order. */
> > > >  	return cmp_ptr(a, b);
> > > >  }
> > > > +
> > > > +static int unix_recvq_lock_cmp_fn(const struct lockdep_map *_a,
> > > > +				  const struct lockdep_map *_b)
> > > > +{
> > > > +	const struct sock *a, *b;
> > > > +
> > > > +	a = container_of(_a, struct sock, sk_receive_queue.lock.dep_map);
> > > > +	b = container_of(_b, struct sock, sk_receive_queue.lock.dep_map);
> > > > +
> > > > +	/* unix_collect_skb(): listener -> embryo order. */
> > > > +	if (a->sk_state == TCP_LISTEN && unix_sk(b)->listener == a)
> > > > +		return -1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > >  #endif
> > > 
> > > That's not symmetric.
> > 
> > I think we agreed this is allowed, no ?
> > 
> > https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo/
> 
> My understanding of such thread is that you should return 1 for the
> embryo -> listener order (for consistency). You can keep returning 0
> for all the other 'undefined' cases.

Ah, I understood.  Will do so in v3.

Thanks!

