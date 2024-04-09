Return-Path: <netdev+bounces-86258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00C89E39C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE027B2219A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B70157A4F;
	Tue,  9 Apr 2024 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KSraSJDR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A1E566
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690982; cv=none; b=FUgYvCPaekE92ofHkOBeyxiVbAMa9+RQExXIpiuSDk/eWCPpgcRu7wkzVKxnmRkuMNhdnehRaaMt11ieN2wVc1t6oFijLY7tanOR6P8nFWGb9x6pv3dWjhznS2LF1y/9295JckknDhdRnFzaqHIPJVb5DA1vgqj2HIWrwhQPuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690982; c=relaxed/simple;
	bh=Nmce0s+q7CeFszkXUJv43TBjffrn7zBQr8AniNQGVEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RymI+iyRCeab4qWsv/eFJTsC6mPmgKGq2piN7hCuKVmUc1vMZyrZHFGxQnn5C/EKdohi7MR6uDVBmXnQtx9sTi53t+o7WmJCFgnWfHI6iDLQq8hlvl0ksvEym30JdRH2YaHGwdv+fG3/RVAKac9sIf8XLDGeFBeLpgWToK4+J7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KSraSJDR; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712690980; x=1744226980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vTCRuNTq1476EcXfIXyNBFpgRJA6AnUGjAL2MgsCsI=;
  b=KSraSJDRpUeZkkkxIRXhvx7yel/XGTbNxzDiC2w3jpOYrFO8E2pjKCe6
   QFAWepmZtwlR8JrHcwyJMGDACVTLxDx88sB4p8EQPk7Du4K40ItcUIRzR
   h7OImMK/+b+SPMXrsJL0Uh9XkC8Aksu6bfdjiT1XXtP1s+/avE3eoduZs
   0=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="388595529"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:02:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:60632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.49:2525] with esmtp (Farcaster)
 id 0330f748-2681-4a6e-921b-035af8680ea0; Tue, 9 Apr 2024 19:02:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0330f748-2681-4a6e-921b-035af8680ea0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 19:02:57 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 19:02:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] af_unix: Fix garbage collector racing against connect()
Date: Tue, 9 Apr 2024 12:02:44 -0700
Message-ID: <20240409190244.26402-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <30c3f9d4-bcc8-471e-b8d4-4dc2c044925a@rbox.co>
References: <30c3f9d4-bcc8-471e-b8d4-4dc2c044925a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 9 Apr 2024 11:16:35 +0200
> On 4/9/24 02:22, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Tue, 9 Apr 2024 01:25:23 +0200
> >> On 4/8/24 23:18, Kuniyuki Iwashima wrote:
> >>> From: Michal Luczaj <mhal@rbox.co>
> >>> Date: Mon,  8 Apr 2024 17:58:45 +0200
> >> ...
> >>>>  	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
> > 
> > Please move sk declaration here and
> > 
> >>>> -		long total_refs;
> >>>> -
> >>>> -		total_refs = file_count(u->sk.sk_socket->file);
> > 
> > keep these 3 lines for reverse xmax tree order.
> 
> Tricky to have them all 3 in reverse xmax. Did you mean
> 
> 	struct sock *sk = &u->sk;
> 	long total_refs;
> 
> 	total_refs = file_count(sk->sk_socket->file);
> 
> ?

Yes, it's netdev convention.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs


> 
> >>> connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
> >>> ----------------	-------------------------	-----------
> >>> NS = unix_create1()
> >>> skb1 = sock_wmalloc(NS)
> >>> L = unix_find_other(addr)
> >>> 						for u in gc_inflight_list:
> >>> 						  if (total_refs == inflight_refs)
> >>> 						    add u to gc_candidates
> >>> 						    // L was already traversed
> >>> 						    // in a previous iteration.
> >>> unix_state_lock(L)
> >>> unix_peer(S) = NS
> >>>
> >>> 						// gc_candidates={L, V}
> >>>
> >>> 						for u in gc_candidates:
> >>> 						  scan_children(u, dec_inflight)
> >>>
> >>> 						// embryo (skb1) was not
> >>> 						// reachable from L yet, so V's
> >>> 						// inflight remains unchanged
> >>> __skb_queue_tail(L, skb1)
> >>> unix_state_unlock(L)
> >>> 						for u in gc_candidates:
> >>> 						  if (u.inflight)
> >>> 						    scan_children(u, inc_inflight_move_tail)
> >>>
> >>> 						// V count=1 inflight=2 (!)
> >>
> >> If I understand your question, in this case L's queue technically does change
> >> between scan_children()s: embryo appears, but that's meaningless. __unix_gc()
> >> already holds unix_gc_lock, so the enqueued embryo can not carry any SCM_RIGHTS
> >> (i.e. it doesn't affect the inflight graph). Note that unix_inflight() takes the
> >> same unix_gc_lock.
> >>
> >> Is there something I'm missing?
> > 
> > Ah exactly, you are right.
> > 
> > Could you repost this patch only with my comment above addressed ?
> 
> Yeah, sure. One question though: what I wrote above is basically a rephrasing of
> the commit message:
> 
>     (...) After flipping the lock, a possibly SCM-laden embryo is already
>     enqueued. And if there is another connect() coming, its embryo won't
>     carry SCM_RIGHTS as we already took the unix_gc_lock.
> 
> As I understand, the important missing part was the clarification that embryo,
> even though enqueued after the lock flipping, won't affect the inflight graph,
> right? So how about:
> 
>     (...) After flipping the lock, a possibly SCM-laden embryo is already
>     enqueued. And if there is another embryo coming, it can not possibly carry
>     SCM_RIGHTS. At this point, unix_inflight() can not happen because
>     unix_gc_lock is already taken. Inflight graph remains unaffected.

Sounds good to me.

Thanks!

