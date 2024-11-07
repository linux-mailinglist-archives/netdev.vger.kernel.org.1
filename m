Return-Path: <netdev+bounces-142656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484819BFDDB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F942824DB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6FA155316;
	Thu,  7 Nov 2024 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A7phyTVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86331373
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958531; cv=none; b=Os+80Hkf2AVdLyeSqdhprNz2M8hauLmYRGdxy59p9JoDvaRNh2IMf8mM1KR73ACGlonF6kUkSup80q/EIL1ys5YA+Nyr8OYnUPsshjewvfQKWbfXdxkwD0hwuDJkGLrnX7L43QLWz8H8duZ2D+uU9/i77sKN0E+vgZgj/MuVDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958531; c=relaxed/simple;
	bh=+KcZU98rroca6VshJ8DZkeBPYfuhoi/V7WU/dcDLDss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK9DAzpAXPyPN+/5OxnAu7fnWpaFzpdHflyRSnSyUD0Lu0ivXRlo5yBLFSdB7t1HMh6gNAJximbuWTHlWTOZdPR90/+qgUHx5OQ4gtuoZbhpkCZ3yM+AS6A7QtilLK2DMhyXgPJ5klZBRpHSgnXru4Uv2jK0la7Kim+wqM+76io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A7phyTVn; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730958530; x=1762494530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7m419jNArPou3cjOU+7V+wOZ6yaWfKwgkl3jUghtUe4=;
  b=A7phyTVnFWXFN3rfymzdatxZuFIZhPq4IRsH37iAmf7TrnrPcMW4hqEu
   9cfQ8ista6wzJwuQbs/zrTGXD9+m0bhkrh0wzMrxfCMc5fb660SOXkfNV
   5cdU9PVJSaX9rbTWAktNy6Xg4nFHJgqkC53RZi+Gt8Kubzr6/durZIbIL
   0=;
X-IronPort-AV: E=Sophos;i="6.11,265,1725321600"; 
   d="scan'208";a="383093829"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:48:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id 437a2b31-aa2a-4ca5-b14d-5377034526e6; Thu, 7 Nov 2024 05:48:49 +0000 (UTC)
X-Farcaster-Flow-ID: 437a2b31-aa2a-4ca5-b14d-5377034526e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 05:48:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 05:48:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 4/6] neighbour: Convert iteration to use hlist+macro
Date: Wed, 6 Nov 2024 21:48:40 -0800
Message-ID: <20241107054840.91923-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107053946.1252382-1-gnaaman@drivenets.com>
References: <20241107053946.1252382-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Thu,  7 Nov 2024 05:39:46 +0000
> > > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> > > index 69aaacd1419f..68b1970d9045 100644
> > > --- a/include/net/neighbour.h
> > > +++ b/include/net/neighbour.h
> > > @@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
> > >  	u32 hash_val;
> > >  
> > >  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> > > -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> > > -	     n != NULL;
> > > -	     n = rcu_dereference(n->next)) {
> > > +	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])
> > 
> > Sorry, I missed this part needs to be _rcu version.
> > 
> > You can keep my Reviewed-by tag in v9.
> > 
> 
> No problem at all, will do.
> 
> Is it possible that the `_rcu` version will also be needed in `neigh_dump_table`?
> It is called from an `rcu_read_lock`ed section, and it doesn't hold the table-lock.

Right, there also should use _rcu one.

