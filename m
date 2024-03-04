Return-Path: <netdev+bounces-77194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADA870847
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B671C20B97
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11636025E;
	Mon,  4 Mar 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ns0ANRvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77591FA4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573479; cv=none; b=QzMtHsTKtn/HACHJ226QthfHyuCtSV+to4BqA/Vh4J0sBTBjLAu0DDPuC+S4h90H1CDl0S4IfPspfrVIbqstMf+1KAtAmFJ/nmvhNzD95o6q5B3hyBEzrPWdP5xAkm2cUO7uxjjB8MZfuikohPjYap4IhAwb99PfoRcNJm1O6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573479; c=relaxed/simple;
	bh=zjr8J4vQjVN/8JfEkXrLgOT0NVNHr4uUMKe0Z4iT/wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PK917nYIwwWE9mFV0KypJ2NZ1UI2qp7Kke/6EXevDC17Pgy4w8jVyT/t0rx4J04pzvqwdhk6pyEajI3WaX28PDNhJBhQ0uv1zz865uc/dhVLaYM78H8QKvkYDLVxKSrEXASplHjr5vy8p2+f2E92KPpoVQkWyx8SFVNkagjc06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ns0ANRvu; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709573478; x=1741109478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXabSKTJvuXn7saxfVVKI8kewWrBQjq4B1f+s1+vrM0=;
  b=ns0ANRvuwT1WGjYuY9AHk3nCkA6TETYmLj7fGA2s3AefVuXq2Yol4zT0
   7X+XbEquRi5WkNvBgPrVQrVSftfvTaEeKI+KPzxU94/WxkerNIwZgqFyC
   e0M95OAdg9M51kL1Q7LLYGPIZ0aFsg9kfmqW05ua8+J75owwww5KonlMO
   4=;
X-IronPort-AV: E=Sophos;i="6.06,203,1705363200"; 
   d="scan'208";a="642212234"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:31:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39883]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.105:2525] with esmtp (Farcaster)
 id 9e9c64f5-f22f-4eeb-856f-3b82a86c74a0; Mon, 4 Mar 2024 17:31:15 +0000 (UTC)
X-Farcaster-Flow-ID: 9e9c64f5-f22f-4eeb-856f-3b82a86c74a0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 17:31:14 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 4 Mar 2024 17:31:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 00/15] af_unix: Rework GC.
Date: Mon, 4 Mar 2024 09:31:04 -0800
Message-ID: <20240304173104.45591-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <04c02c854f030d3cb0591cd420f28c57994a0aaa.camel@redhat.com>
References: <04c02c854f030d3cb0591cd420f28c57994a0aaa.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 04 Mar 2024 17:18:32 +0100
> On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> > When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
> > the underlying struct file of the inflight fd gets its refcount bumped.
> > If the fd is of an AF_UNIX socket, we need to track it in case it forms
> > cyclic references.
> > 
> > Let's say we send a fd of AF_UNIX socket A to B and vice versa and
> > close() both sockets.
> > 
> > When created, each socket's struct file initially has one reference.
> > After the fd exchange, both refcounts are bumped up to 2.  Then, close()
> > decreases both to 1.  From this point on, no one can touch the file/socket.
> > 
> > However, the struct file has one refcount and thus never calls the
> > release() function of the AF_UNIX socket.
> > 
> > That's why we need to track all inflight AF_UNIX sockets and run garbage
> > collection.
> > 
> > This series replaces the current GC implementation that locks each inflight
> > socket's receive queue and requires trickiness in other places.
> > 
> > The new GC does not lock each socket's queue to minimise its effect and
> > tries to be lightweight if there is no cyclic reference or no update in
> > the shape of the inflight fd graph.
> > 
> > The new implementation is based on Tarjan's Strongly Connected Components
> > algorithm, and we will consider each inflight AF_UNIX socket as a vertex
> > and its file descriptor as an edge in a directed graph.
> > 
> > For the details, please see each patch.
> > 
> >   patch 1  -  3 : Add struct to express inflight socket graphs
> >   patch       4 : Optimse inflight fd counting
> >   patch 5  -  6 : Group SCC possibly forming a cycle
> >   patch 7  -  8 : Support embryo socket
> >   patch 9  - 11 : Make GC lightweight
> >   patch 12 - 13 : Detect dead cycle references
> >   patch      14 : Replace GC algorithm
> >   patch      15 : selftest
> > 
> > After this series is applied, we can remove the two ugly tricks for race,
> > scm_fp_dup() in unix_attach_fds() and spin_lock dance in unix_peek_fds()
> > as done in patch 14/15 of v1.
> 
> I plan to have a better look tomorrow.

Thanks for your time!

> 
> Generally speaking we have a timing problem. This looks great, but also
> quite complex, and thus the potential for untrivial regressions. 
> 
> We are very late in this cycle and likely there will not be rc8, would
> you be ok to eventually postpone this to the next cycle?

No problem at all, I was also thinking about that after reading the
announcement :)

