Return-Path: <netdev+bounces-85943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F270689CF4C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1F1F21F12
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7F370;
	Tue,  9 Apr 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cmEryJQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30419A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622170; cv=none; b=RldTJ2n3pLjY6O5EXCnehMFk/1sCtsen7/i1ZLPigttAbn3qFf/maP5XMPx8kRt3CWSi0aigZ6EP8fiuXM/yO/uRjbscpdks0rQ594jSxg2RsAil2sk9j3TCArT5UNXPFqLnP/aS33VabPEnLKF31ag/JaSKt9/2KCQGmydCvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622170; c=relaxed/simple;
	bh=OIvk4Miu7UQJUvMI/us+NC2UDk0IfM2CN5ZCQUnBjRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dH7ia+DPjNbfcOW9k/2M+Kangx399DRJV5yp2VQp9UBL/ViEoFjbfg5XmNs2IK+tQMI4dinPXXtKoVzwGsXUb7v6wllmRVaX2DT3I8LR9jXaghWwHIR5+LIDv+/1Zgzvnl/MA0Hg5MnyCRFXqL9PCMCASx/IOI2jR9OOR6v/eeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cmEryJQV; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712622169; x=1744158169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQCEfpZvUK5DBnL3Jr/2pOJ/sGyFw6VAOPmDdSzVRD4=;
  b=cmEryJQVuKNsuu42nl0L5Y5qO+9Ycp7qpGn5DJjs6TmF6NMSga3CvZTc
   RWVtTHMKCKmJ/dJSpmxBs5kaZNTkytpjiidr8d2ZocSTxQplxgogyL07l
   b4OQp+tQcsQU6H0FDd9l+dRyxUNRfH5TV7Bb1mGTjwWegRkoSLfArwlLn
   4=;
X-IronPort-AV: E=Sophos;i="6.07,188,1708387200"; 
   d="scan'208";a="197294136"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:22:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:52732]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.3:2525] with esmtp (Farcaster)
 id ebda6b30-426b-48af-a24c-2fdec5644d51; Tue, 9 Apr 2024 00:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: ebda6b30-426b-48af-a24c-2fdec5644d51
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 00:22:42 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 00:22:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] af_unix: Fix garbage collector racing against connect()
Date: Mon, 8 Apr 2024 17:22:31 -0700
Message-ID: <20240409002231.17900-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c3f212f8-01a5-4037-af76-39170aa6a6ce@rbox.co>
References: <c3f212f8-01a5-4037-af76-39170aa6a6ce@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 9 Apr 2024 01:25:23 +0200
> On 4/8/24 23:18, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Mon,  8 Apr 2024 17:58:45 +0200
> ...
> >>  	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {

Please move sk declaration here and


> >> -		long total_refs;
> >> -
> >> -		total_refs = file_count(u->sk.sk_socket->file);

keep these 3 lines for reverse xmax tree order.


> >> +		struct sock *sk = &u->sk;
> >> +		long total_refs = file_count(sk->sk_socket->file);
> >>  
> >>  		WARN_ON_ONCE(!u->inflight);
> >>  		WARN_ON_ONCE(total_refs < u->inflight);
> >> @@ -286,6 +295,11 @@ static void __unix_gc(struct work_struct *work)
> >>  			list_move_tail(&u->link, &gc_candidates);
> >>  			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
> >>  			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
> >> +
> >> +			if (sk->sk_state == TCP_LISTEN) {
> >> +				unix_state_lock(sk);
> >> +				unix_state_unlock(sk);
> > 
> > Less likely though, what if the same connect() happens after this ?
> > 
> > connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
> > ----------------	-------------------------	-----------
> > NS = unix_create1()
> > skb1 = sock_wmalloc(NS)
> > L = unix_find_other(addr)
> > 						for u in gc_inflight_list:
> > 						  if (total_refs == inflight_refs)
> > 						    add u to gc_candidates
> > 						    // L was already traversed
> > 						    // in a previous iteration.
> > unix_state_lock(L)
> > unix_peer(S) = NS
> > 
> > 						// gc_candidates={L, V}
> > 
> > 						for u in gc_candidates:
> > 						  scan_children(u, dec_inflight)
> > 
> > 						// embryo (skb1) was not
> > 						// reachable from L yet, so V's
> > 						// inflight remains unchanged
> > __skb_queue_tail(L, skb1)
> > unix_state_unlock(L)
> > 						for u in gc_candidates:
> > 						  if (u.inflight)
> > 						    scan_children(u, inc_inflight_move_tail)
> > 
> > 						// V count=1 inflight=2 (!)
> 
> If I understand your question, in this case L's queue technically does change
> between scan_children()s: embryo appears, but that's meaningless. __unix_gc()
> already holds unix_gc_lock, so the enqueued embryo can not carry any SCM_RIGHTS
> (i.e. it doesn't affect the inflight graph). Note that unix_inflight() takes the
> same unix_gc_lock.
> 
> Is there something I'm missing?

Ah exactly, you are right.

Could you repost this patch only with my comment above addressed ?

Thanks!

