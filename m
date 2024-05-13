Return-Path: <netdev+bounces-96032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B78C40F2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E981C21151
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCF14F9CF;
	Mon, 13 May 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Uno2pvvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758414F9C8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604288; cv=none; b=SgBRpULfYYexOg5XQvKTlsoI+d4ndpK7U8LqulQEnOwGlApq5PKBKFt8oULb0m+PU98SrnUrrl7yhLuRVRyuXHrQbqAIbxdjHT6Kx0NSck4gi/nt0TUQNfSKFbvBfjpg9qlsTmsqNe8ixcjK36cgVXTPd/niQo3YwydGtvjq5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604288; c=relaxed/simple;
	bh=C8roX0Ve8Suwq4QPUy6mUvZBvNzt8i7g5PNh3cFWGYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJZ5PJaV11qVRJMpCUULYvZZySpwTC/hwe8UlZSdTlcj9z3V3eJNswtAieYArXjKjTZ1fWYzgW2j20cAuWE4dkhbgUE/O/g0twdTQNnaG77ZqD9wP972VOjV+LBnbhYIRBppySgdTQjiD442M5Gixz6jNzQeGEK7ekcDxQfmjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Uno2pvvj; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715604287; x=1747140287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oaWT8E8Q1AeYYfrY8QoJb6cFjpSsAdYZc3OwQGi+1Kc=;
  b=Uno2pvvjBvL1KBQ++TeZy+NgBwH84+bOZlCJ5OGQCfJkAt16GOuRo0B5
   4+dABRpsWgrRE1nzKm2Xl4F8oqIJ3DUXnCKfRTCiQI+GL8ArfTy5UzdkC
   kRqd63fdfh5Bjkj06t/f5iofTT8KFBN9qVNZx92tp+7Tv4Vnc75uCcMi3
   4=;
X-IronPort-AV: E=Sophos;i="6.08,158,1712620800"; 
   d="scan'208";a="204736540"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 12:44:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:30694]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.62:2525] with esmtp (Farcaster)
 id aee8695d-72d4-4e3b-9088-1f6b066b0676; Mon, 13 May 2024 12:44:43 +0000 (UTC)
X-Farcaster-Flow-ID: aee8695d-72d4-4e3b-9088-1f6b066b0676
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 12:44:43 +0000
Received: from 88665a182662.ant.amazon.com (10.118.241.118) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 12:44:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Mon, 13 May 2024 21:44:23 +0900
Message-ID: <20240513124423.31637-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <30bb2dd9-f84e-4615-9217-fea3e656fa49@rbox.co>
References: <30bb2dd9-f84e-4615-9217-fea3e656fa49@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Date: Mon, 13 May 2024 12:15:57 +0200
From: Michal Luczaj <mhal@rbox.co>
> On 5/13/24 11:24, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Mon, 13 May 2024 11:14:39 +0200
> >> On 5/13/24 09:44, Kuniyuki Iwashima wrote:
> >>> From: Michal Luczaj <mhal@rbox.co>
> >>> Date: Mon, 13 May 2024 08:40:34 +0200
> >>>> What I'm talking about is the quoted above (unchanged) part in manage_oob():
> >>>>
> >>>> 	if (!WARN_ON_ONCE(skb_unref(skb)))
> >>>>   		kfree_skb(skb);
> >>>
> >>> Ah, I got your point, good catch!
> >>>
> >>> Somehow I was thinking of new GC where alive recvq is not touched
> >>> and lockdep would end up with false-positive.
> >>>
> >>> We need to delay freeing oob_skb in that case like below.
> >>> ...
> >>
> >> So this not a lockdep false positive after all?
> >>
> >> Here's my understanding: the only way manage_oob() can lead to an inverted locking
> >> order is when the receiver socket is _not_ in gc_candidates. And when it's not
> >> there, no risk of deadlock. What do you think?
> > 
> > For the new GC, it's false positive, but for the old GC, it's not.
> >
> > The old GC locks unix_gc_lock and could iterate alive sockets if
> > they are linked to gc_inflight_list, and then recvq is locked.
> > ...
> 
> The recvq is locked not for all sockets in gc_inflight_list, but only its
> subset, gc_candidates, i.e. sockets that fulfil the 'total_refs == u->inflight'
> condition, right? So doesn't this imply that our receiver is not user-reachable
> and manage_oob() cannot be called/raced?

Ah, yes, the splat was false-positive for the old GC too.

Instead of using a differenct class for the recvq in GC, it would
be better to unlock it earlier in manage_oob(), so I'll post v3.

Thanks!

