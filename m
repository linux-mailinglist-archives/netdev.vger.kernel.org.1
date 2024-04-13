Return-Path: <netdev+bounces-87584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CC8A3A59
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9AAB21210
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA01078B;
	Sat, 13 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t5YPeo21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90ED442C
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974228; cv=none; b=TWDcYJjkC9O4mkwPEpkJFkfYJ6EktHlu5Hp2AgwBN0V97q79BS60ZgUS9IlVJCke4qXnuNdSmvvhHnfOGFZAhm9gWZnWKNnxyTpB5qUpHhcFU0Fg3L6t4+qLU7hYpFAevisBIfbpRzExW1A2D2gasGb6Rzjx69vdxOuPECFhQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974228; c=relaxed/simple;
	bh=0iLXhtLW26/e5heTwgJWwLms+XDpm2YNotm77yxejbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMD+IPlTpsGo5YBlX7BM3aL4x5Zps1KxZviTHDZ4Uc1xAacf98o3O5W/+yZr8QaKxfsFQzqH6AjghSrlbsue64SsyKfgQiNZss22lZTEKdvzB6ydg4llHgJUesZkcz43QS1hoAUdcyfe6JgqX9svKs6zurXWlXr4juALv69pR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t5YPeo21; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712974227; x=1744510227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uw+9KyojI5pL5/Ay7mUQX6t5TXu7FqN8+pZg9p6X+C8=;
  b=t5YPeo21TAxOwoXLEHv9qZdMomN+d6TS6P8kJWeHzj++Ln3NlSubs0jl
   Jml2W28MlicqDBYugyMm6MOwh0n9n9HpVyxRr+z35Y4sfWayeHENcQr3L
   GfhKQokW3EQyGdXamHAEVg25fhjesg4y3L561XM09ncwURCwJz3lugbi5
   0=;
X-IronPort-AV: E=Sophos;i="6.07,197,1708387200"; 
   d="scan'208";a="198256404"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 02:10:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:10906]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.162:2525] with esmtp (Farcaster)
 id 7ae02aaf-a145-4b61-b14d-23ab6a4bf199; Sat, 13 Apr 2024 02:10:23 +0000 (UTC)
X-Farcaster-Flow-ID: 7ae02aaf-a145-4b61-b14d-23ab6a4bf199
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 13 Apr 2024 02:10:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Sat, 13 Apr 2024 02:10:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next] af_unix: Try not to hold unix_gc_lock during accept().
Date: Fri, 12 Apr 2024 19:10:12 -0700
Message-ID: <20240413021012.20209-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240412190522.3a157f00@kernel.org>
References: <20240412190522.3a157f00@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 12 Apr 2024 19:05:22 -0700
> On Wed, 10 Apr 2024 13:19:29 -0700 Kuniyuki Iwashima wrote:
> >  void unix_update_edges(struct unix_sock *receiver)
> >  {
> > -	spin_lock(&unix_gc_lock);
> > -	unix_update_graph(unix_sk(receiver->listener)->vertex);
> > +	/* nr_unix_fds is only updated under unix_state_lock().
> > +	 * If it's 0 here, the embryo socket is not part of the
> > +	 * inflight graph, and GC will not see it.
> > +	 */
> > +	bool need_lock = !!receiver->scm_stat.nr_unix_fds;
> > +
> > +	if (need_lock) {
> > +		spin_lock(&unix_gc_lock);
> > +		unix_update_graph(unix_sk(receiver->listener)->vertex);
> > +	}
> > +
> >  	receiver->listener = NULL;
> > -	spin_unlock(&unix_gc_lock);
> > +
> > +	if (need_lock)
> > +		spin_unlock(&unix_gc_lock);
> >  }
> 
> Are you planning to add more code here? I feel like the sharing of 
> a single line is outweighted by the conditionals.. I mean:
> 
> 	/* ...
> 	 */
> 	if (!receiver->scm_stat.nr_unix_fd) {
> 		receiver->listener = NULL;
> 	} else {
> 		spin_lock(&unix_gc_lock);
> 		unix_update_graph(unix_sk(receiver->listener)->vertex);
> 		receiver->listener = NULL;
> 		spin_unlock(&unix_gc_lock);
> 	}
> 
> no?

Ah exactly, I'll repsin v2 with that style.

Thanks!

