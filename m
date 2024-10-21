Return-Path: <netdev+bounces-137632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895C9A900B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D4D1F236F5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73351FCC52;
	Mon, 21 Oct 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="osKsBJyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C061FBCBB
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539660; cv=none; b=jGOS2tPV4CxA6a0xjiOezBt0E8L1gX9AOiu9wzXh5p8oT1VdWP0sGlqKz78iq2eT1m/wgaiavc0kunQTmGuJujlNEw4Nb84eAbGeLOmJR1QnwFa34wfanTD/gH7xcsjsAPMF1HlTyZSl+VyZySoaA6o9iXVkUnwLXay/5Jkuxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539660; c=relaxed/simple;
	bh=mLdZr7U24zfkSIxv8fHHh+YVQ74zbfqOVAiyn9aDpTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3gmi12SYLXXocC9T2JY9ypKIAls1xds2WIDe/Arm+HwH/PIwUrdIbdeExHxQyi5zElpCNHtT0glPpIdhyXmqLc/W6mO2aOWeAJMNYLex8smRad5Wa0UrHbaeDHrX8L80qXPzEs8y8Fr/aKA6DjVOYbbtoVQyIhRRL6ds36c5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=osKsBJyP; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729539659; x=1761075659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2x0h9cRrIJgNBoaEQsjTVyxbC3y/IiC7W/v+3Q15hDg=;
  b=osKsBJyPflg5dR00w+RJfsuT3CkPN5qbjEKh2LxQZyT03qJ4gTeFoyTF
   kuaz6kfyGr+9uOFkCegNxU4b9M/zWGoGMV8QAMiR3yVCv1L6ka5VYEL9m
   FlZDtZGj8DPsfnY/NFB5YXF/in5DnpdTcC9K4zCve4TES9duIOPBUUKiu
   c=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="442715740"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:40:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:34622]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.189:2525] with esmtp (Farcaster)
 id f37302fb-5e88-44cc-8a7f-7eb5b3d50190; Mon, 21 Oct 2024 19:40:53 +0000 (UTC)
X-Farcaster-Flow-ID: f37302fb-5e88-44cc-8a7f-7eb5b3d50190
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 19:40:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 19:40:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] neighbour: Add hlist_node to struct neighbour
Date: Mon, 21 Oct 2024 12:40:48 -0700
Message-ID: <20241021194048.88666-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021193623.2830318-1-gnaaman@drivenets.com>
References: <20241021193623.2830318-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon, 21 Oct 2024 19:36:22 +0000
> > > @@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
> > >  
> > >  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
> > >  {
> > > +	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
> > >  	size_t size = (1 << shift) * sizeof(struct neighbour *);
> > > -	struct neigh_hash_table *ret;
> > >  	struct neighbour __rcu **buckets;
> > > +	struct hlist_head *hash_heads;
> > > +	struct neigh_hash_table *ret;
> > >  	int i;
> > >  
> > > +	hash_heads = NULL;
> > 
> > nit: This init is not needed.
> 
> This is needed in order to prevent unitialized memory access if we failed to
> allocate `buckets`.

Ah, you are right.

> 
> If possible I'd prefer to leave this as-is, given that this is rewritten later,
> in commit 5.

Sounds good.  Let's remove that in patch 5.

