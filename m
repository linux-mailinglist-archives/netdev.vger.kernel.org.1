Return-Path: <netdev+bounces-95933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBE8C3E11
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37A0280DAD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E51487E1;
	Mon, 13 May 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="evz+C7lW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C314830A
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592288; cv=none; b=Ob1hlxVoH0FGuFuCxfYBtrjLMt6hV4gRg4CbIZdYPeJFQcHx9iMtO2/fpUZvczPSB5150dwq3SjErzoBFFZUDi8hJokqexcNDUvR1z+IkdCMN0I4xbLGmkSTS3ig5IOT357F04Z1GfDF6uHeh3iNE/wmCC1L4fcc30pDnExUoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592288; c=relaxed/simple;
	bh=OysAihspi2UK7uc8jUIHCSNsriC3XF64/MiR1Tihm9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYmT5B18vXYQuXu2ejqzqYonkc7VTwCm3gFOW5mfSWwD42hEo4edci5I2vUgvjQQLzQ8zLQPYh8WGkK0rX8GRKAB0t/L7Yc7N6Ff4Wb6pFH+x6aO24DkN6Fsub5vdXCuDnNLrB8iqikmffBUUwODtHnYpnX3O0UC82+4sB5Oqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=evz+C7lW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715592286; x=1747128286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnqVCCwaC/OHj9rexIdpK19E1zVwzHI69Mc61FDSOT4=;
  b=evz+C7lW6jAoWN+XMD8PRJqkLKSqAFDnGchFbyuyHRyXmNX2pvDXST50
   hXFxSJHe0N9hpLq/NcY3gAuupNn3v5OmFg3VWsZnGZIfNEykN+byrVfGO
   zOIGC1dvHFbKKikBbNMHkhNAWtOKPJ8BXLHxzKz1sQncylB+hsvXASS+n
   M=;
X-IronPort-AV: E=Sophos;i="6.08,158,1712620800"; 
   d="scan'208";a="88800938"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 09:24:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:8501]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.212:2525] with esmtp (Farcaster)
 id 7b1c7e63-9c8e-4984-b99a-cea0d0d4c726; Mon, 13 May 2024 09:24:43 +0000 (UTC)
X-Farcaster-Flow-ID: 7b1c7e63-9c8e-4984-b99a-cea0d0d4c726
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 09:24:39 +0000
Received: from 88665a182662.ant.amazon.com (10.118.241.118) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 09:24:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Mon, 13 May 2024 18:24:26 +0900
Message-ID: <20240513092426.12297-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3bbea91b-5b2b-4695-bb5d-793482f05e9f@rbox.co>
References: <3bbea91b-5b2b-4695-bb5d-793482f05e9f@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 13 May 2024 11:14:39 +0200
> On 5/13/24 09:44, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Mon, 13 May 2024 08:40:34 +0200
> >> What I'm talking about is the quoted above (unchanged) part in manage_oob():
> >>
> >> 	if (!WARN_ON_ONCE(skb_unref(skb)))
> >>   		kfree_skb(skb);
> > 
> > Ah, I got your point, good catch!
> > 
> > Somehow I was thinking of new GC where alive recvq is not touched
> > and lockdep would end up with false-positive.
> > 
> > We need to delay freeing oob_skb in that case like below.
> > ...
> 
> So this not a lockdep false positive after all?
> 
> Here's my understanding: the only way manage_oob() can lead to an inverted locking
> order is when the receiver socket is _not_ in gc_candidates. And when it's not
> there, no risk of deadlock. What do you think?

For the new GC, it's false positive, but for the old GC, it's not.

The old GC locks unix_gc_lock and could iterate alive sockets if
they are linked to gc_inflight_list, and then recvq is locked.

The new GC only touches recvq when it's detected as dead, meaning
there's no recv() call in progress for the socket.

This patch is for both GC impl, so we need to free skb after
unlocking recvq in manage_oob().

