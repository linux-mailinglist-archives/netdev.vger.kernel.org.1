Return-Path: <netdev+bounces-96568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D18C6772
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2272812F0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D238595F;
	Wed, 15 May 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tyKgRX/4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D315A110
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780171; cv=none; b=iI919Ojag9vXTZYbZ5mSsxAUcdEbAUOe0iAxNcJNDn5VErnBuoYxGiYaA4vLHD7n6ShCgzIsMJCwu0e8N4L/RK5Mhdc5HqGlyFVsOZxziXJEi7D4GDYA5K4GP4at5F4CAMQY6N0YQs3VqZHf1zeKU91lYmjAKHe6VyM3eTWBUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780171; c=relaxed/simple;
	bh=sef5vK0LMCflGKVaJm3xTW7h6jT++dnHLXS5KFmQbvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdHgXBEkx1IqhaZIFy/24anOHRxMh8mjRB46Q8oD/T5sLz4VCG/qlUg9tWSdIIJi+1LKVdaEkZuw7Fr/Y4peqKXYzK68f3GiGEuFu1uDc/bNzeRuP5DCU9kLmfeXXfwMcQu+zWNI5kPmT/1o13PIGtxyPwUoc4g1tF+m+N1Ovuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tyKgRX/4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715780170; x=1747316170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O605V4KtINYLu8sCwQPW2UTwnI5h7D0bBbuVGLcyfSk=;
  b=tyKgRX/4dJEJSusUFWLlY9YcM8JKu32TS+CD590Akxg7/Lk7HxgcyHmu
   sQirXvSYKCIcemqZ1tdFXJgsyMdy7/Ys6/sMOG1bsKyB/SwYrgXQXZ4Bu
   oBhfPJvKnYHNysph0mHnNRPLHbbBOYdqt19cTA4sVv2zKWSIKJ3Sb4MyA
   M=;
X-IronPort-AV: E=Sophos;i="6.08,161,1712620800"; 
   d="scan'208";a="89333537"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 13:36:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:11109]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.83:2525] with esmtp (Farcaster)
 id c90b5ec4-c71e-40cc-8767-2b2c0f1c95d0; Wed, 15 May 2024 13:36:07 +0000 (UTC)
X-Farcaster-Flow-ID: c90b5ec4-c71e-40cc-8767-2b2c0f1c95d0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 13:36:07 +0000
Received: from 88665a182662.ant.amazon.com (10.118.251.192) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 13:36:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v5 net 1/2] af_unix: Fix garbage collection of embryos carrying OOB/SCM_RIGHTS.
Date: Wed, 15 May 2024 22:35:47 +0900
Message-ID: <20240515133547.47276-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c6eb5987-4ffa-47cf-a0c7-dcc7b969d2ca@rbox.co>
References: <c6eb5987-4ffa-47cf-a0c7-dcc7b969d2ca@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 15 May 2024 11:34:51 +0200
> On 5/15/24 02:32, Kuniyuki Iwashima wrote:
> > ...
> > The python script below [0] sends a listener's fd to its embryo as OOB
> > data.  Then, GC does not iterates the embryo from the listener to drop
> > the OOB skb's refcount, and the skb in embryo's receive queue keeps the
> > listener's refcount.  As a result, the listener is leaked and the warning
> > [1] is hit.
> > ...
> 
> Sorry, this does not convey what I wrote. And I think your edit is
> incorrect.
> 
> GC starts from the in-flight listener and *does* iterate the embryo; see
> scan_children() where scan_inflight() is called for all the embryos.

I meant the current code does not call skb_unref() for embryos's OOB skb
because it's done _after_ scan_inflight(), not in scan_inflight().


> The skb in embryo's RQ *does not* keep the listener's refcount; skb from RQ
> ends up in the hit list and is purged.

unix_sk(sk)->oob_skb is a pointer to skb in recvq.  Perhaps I should
have written "the skb which was in embryo's receive queue stays as
unix_sk(sk)->oob_skb and keeps the listener's refcount".


> It is embryo's oob_skb that holds the refcount; see how __unix_gc() goes
> over gc_candidates attempting to kfree_skb(u->oob_skb), notice that `u`
> here is a listener, not an embryo.
> 
> I understand you're "in rush for the merge window", but would it be okay if
> I ask you not to edit my commit messages so heavily?

I noticed the new gc code was merged in Linus' tree.  It's still not
synced with net.git, but I guess it will be done soon and your patch
will not apply on net.git.  Then, I cannot include your patch as a
series, so please feel free to send it to each stable tree.

Thanks

