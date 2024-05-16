Return-Path: <netdev+bounces-96726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5458C75E3
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C021C214DB
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F418145B24;
	Thu, 16 May 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WxU5nOo3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCC145B09
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862020; cv=none; b=BpMMKCb8iLAxS5iOO0iIP2TF3rjUMx04onwh+UuZkVLUdo9ecv7ux2zOZ5mXDmo/vyHcdsCS2doifaR6ZJUckDcY5BBTIl0yc9M1bUlncuRs8HSqiSmve80j+wm5OM1Brm3jlId1equoXBWK9TsJx0K7SVuvCd83ivbiWQBLDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862020; c=relaxed/simple;
	bh=5vHiIk7uL0TdSXUCuvmFO+NUa+Mi0Vlz366V87VxGmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS93n06EueWuqXgXYpq+K760qHYJQo7LHpy777EGhOWvKvenMIgwnbuoN3oluqSFr0kVBvieRsZQN9rGxEkVNgSdivCybmZGJTctym9fiSXI0LPS18VyLseEY3B17/l072KtNMQ7M4PxhhB3paUzUDyzarsporuwUJEB2Z4yR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WxU5nOo3; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715862020; x=1747398020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igejicofWzz7o1DwLWCJ+to8tUiBYZBDJYu7JUEDEvo=;
  b=WxU5nOo3CX1To2z2I0uR7uNH+ChbtQhIcy1e5oxNqLSMS7VNn0ZBsqqf
   ZftQ+oUWs0OjY6ewTyadQ1SMBWQDJKshnQT9oEmBAkZmryBVdLRPAsX6T
   T6HOfl5LpbmRQwrUcdAdHEG4WDC/nbriJfUJfFPeMczfaC5rw4TqcUJmW
   I=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; 
   d="scan'208";a="726817677"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:20:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:65122]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.62:2525] with esmtp (Farcaster)
 id b11fcbc3-3dd9-418b-8a91-b642401e70e8; Thu, 16 May 2024 12:20:13 +0000 (UTC)
X-Farcaster-Flow-ID: b11fcbc3-3dd9-418b-8a91-b642401e70e8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 12:20:12 +0000
Received: from 88665a182662.ant.amazon.com (10.118.251.223) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 12:20:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v5 net 1/2] af_unix: Fix garbage collection of embryos carrying OOB/SCM_RIGHTS.
Date: Thu, 16 May 2024 21:19:54 +0900
Message-ID: <20240516121954.98845-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0828c5fb-1e56-4bdf-b7dd-7ec4d7310c72@rbox.co>
References: <0828c5fb-1e56-4bdf-b7dd-7ec4d7310c72@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 16 May 2024 12:33:35 +0200
> On 5/15/24 15:35, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Wed, 15 May 2024 11:34:51 +0200
> >> On 5/15/24 02:32, Kuniyuki Iwashima wrote:
> >>> ...
> >>> The python script below [0] sends a listener's fd to its embryo as OOB
> >>> data.  Then, GC does not iterates the embryo from the listener to drop
> >>> the OOB skb's refcount, and the skb in embryo's receive queue keeps the
> >>> listener's refcount.  As a result, the listener is leaked and the warning
> >>> [1] is hit.
> >>> ...
> >>
> >> Sorry, this does not convey what I wrote. And I think your edit is
> >> incorrect.
> >>
> >> GC starts from the in-flight listener and *does* iterate the embryo; see
> >> scan_children() where scan_inflight() is called for all the embryos.
> > 
> > I meant the current code does not call skb_unref() for embryos's OOB skb
> > because it's done _after_ scan_inflight(), not in scan_inflight().
> 
> Right, I think I see what you mean.
> 
> >> The skb in embryo's RQ *does not* keep the listener's refcount; skb from RQ
> >> ends up in the hit list and is purged.
> > 
> > unix_sk(sk)->oob_skb is a pointer to skb in recvq.  Perhaps I should
> > have written "the skb which was in embryo's receive queue stays as
> > unix_sk(sk)->oob_skb and keeps the listener's refcount".
> 
> I wholeheartedly concur with you!
> 
> >> It is embryo's oob_skb that holds the refcount; see how __unix_gc() goes
> >> over gc_candidates attempting to kfree_skb(u->oob_skb), notice that `u`
> >> here is a listener, not an embryo.
> >>
> >> I understand you're "in rush for the merge window", but would it be okay if
> >> I ask you not to edit my commit messages so heavily?
> > 
> > I noticed the new gc code was merged in Linus' tree.  It's still not
> > synced with net.git, but I guess it will be done soon and your patch
> > will not apply on net.git.  Then, I cannot include your patch as a
> > series, so please feel free to send it to each stable tree.
> 
> All right, no problem. Does it mean you'll be posting PATCH 2/2 ("af_unix:
> Update unix_sk(sk)->oob_skb under sk_receive_queue lock") to stable(s)?

I'll post patch 2/2 to net.git and it will be sent to stable later
by netdev maintainers.  Then, with your patch, the issue is completely
fixed for the old gc.


> 
> Moving on to the New GC: Python test from this patch shows that the New GC
> is memleaking in pretty much the same fashion.

Good catch!

> 
> $ grep splat /proc/net/unix
> $ ./unix-oob-splat.py
> $ rm unix-oob-splat
> $ ./unix-oob-splat.py
> $ grep splat /proc/net/unix
> 0000000000000000: 00000002 00000000 00000000 0001 02     0 unix-oob-splat
> 0000000000000000: 00000002 00000000 00000000 0001 02     0 unix-oob-splat
> 0000000000000000: 00000002 00000000 00010000 0001 01  6643 unix-oob-splat
> 0000000000000000: 00000002 00000000 00010000 0001 01  2920 unix-oob-splat
> 
> I've posted a patch:
> https://lore.kernel.org/netdev/20240516103049.1132040-1-mhal@rbox.co/
> 
> I tried to align with your version of the commit message, but feel free to
> chime in. Also, I took the liberty to introduce a small sanity check. Would
> you prefer if I dropped this hunk or possibly made it a separate patch?

Will comment on the patch thread.

Thanks!

