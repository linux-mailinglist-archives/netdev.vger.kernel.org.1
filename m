Return-Path: <netdev+bounces-85918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA589CD5E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D3F1F21B21
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345801487F7;
	Mon,  8 Apr 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CmF8XPiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9D1487F5
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611131; cv=none; b=PeBqXLk9PInmCy/+8u5i1jaVr7gEO7WUtqcG0cnj6l3k8dwUf4HY6KidyallJhSeVmy5a7T/Vd/6m6SERc3IaU1rFpPo4wTUnHqxfnKKKr/PbgdBELDR6W6SdIKd00WxLNKrdyeMiNO+K6kBG6YQxlST5j+d4Xdk1NGqnEWWcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611131; c=relaxed/simple;
	bh=eK5WUWCNf6Mf/IHlEFpa89tl0quDFijpt+7Zvm1+0/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoUVZ095pOajQ+NCfe0xHh+He4EcGV2C6IMkRTy0ddW6LWrS8DozME0NdNmSrFS9OZOw5iM74nek7z+4D0a960mCG8Bf5LGxjo7fwRlCHyI8v513ilMIjLykgJiYqD85fLp9MRlhywBYPCRK3u8rJcoxwdezGgZhZwlpPrNqxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CmF8XPiY; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712611130; x=1744147130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LlrC9qWagV7kz0TWRqScH6ODBiuzdlUfJnnirk2YJrs=;
  b=CmF8XPiYuvqrCOQvj6Wx3ZxiZpB6BroAbZcnAZrGkNK6ZWa2DrxT/cyG
   bzCdDEQ3soqLJUk5jipplrE7+6AqYbZ5X5Oek0tXBH5A+220wPeKxo3bA
   ktXym+jax+cN1uCBsyJq5nZqpnYc9SXxT/z0M5xWUjXwTaJ5+nkou0uQY
   s=;
X-IronPort-AV: E=Sophos;i="6.07,187,1708387200"; 
   d="scan'208";a="398950461"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:18:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:55009]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.41:2525] with esmtp (Farcaster)
 id ef6101cd-b153-4a23-9731-6e65d732e26a; Mon, 8 Apr 2024 21:18:45 +0000 (UTC)
X-Farcaster-Flow-ID: ef6101cd-b153-4a23-9731-6e65d732e26a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 21:18:41 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 8 Apr 2024 21:18:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] af_unix: Fix garbage collector racing against connect()
Date: Mon, 8 Apr 2024 14:18:30 -0700
Message-ID: <20240408211830.99829-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240408161336.612064-2-mhal@rbox.co>
References: <20240408161336.612064-2-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Mon,  8 Apr 2024 17:58:45 +0200
> Garbage collector does not take into account the risk of embryo getting
> enqueued during the garbage collection. If such embryo has a peer that
> carries SCM_RIGHTS, two consecutive passes of scan_children() may see a
> different set of children. Leading to an incorrectly elevated inflight
> count, and then a dangling pointer within the gc_inflight_list.
> 
> sockets are AF_UNIX/SOCK_STREAM
> S is an unconnected socket
> L is a listening in-flight socket bound to addr, not in fdtable
> V's fd will be passed via sendmsg(), gets inflight count bumped
> 
> connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
> ----------------	-------------------------	-----------
> 
> NS = unix_create1()
> skb1 = sock_wmalloc(NS)
> L = unix_find_other(addr)
> unix_state_lock(L)
> unix_peer(S) = NS
> 			// V count=1 inflight=0
> 
>  			NS = unix_peer(S)
>  			skb2 = sock_alloc()
> 			skb_queue_tail(NS, skb2[V])
> 
> 			// V became in-flight
> 			// V count=2 inflight=1
> 
> 			close(V)
> 
> 			// V count=1 inflight=1
> 			// GC candidate condition met
> 
> 						for u in gc_inflight_list:
> 						  if (total_refs == inflight_refs)
> 						    add u to gc_candidates
> 
> 						// gc_candidates={L, V}
> 
> 						for u in gc_candidates:
> 						  scan_children(u, dec_inflight)
> 
> 						// embryo (skb1) was not
> 						// reachable from L yet, so V's
> 						// inflight remains unchanged
> __skb_queue_tail(L, skb1)
> unix_state_unlock(L)
> 						for u in gc_candidates:
> 						  if (u.inflight)
> 						    scan_children(u, inc_inflight_move_tail)
> 
> 						// V count=1 inflight=2 (!)
> 
> If there is a GC-candidate listening socket, lock/unlock its state. This
> makes GC wait until the end of any ongoing connect() to that socket. After
> flipping the lock, a possibly SCM-laden embryo is already enqueued. And if
> there is another connect() coming, its embryo won't carry SCM_RIGHTS as we
> already took the unix_gc_lock.
> 
> Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/unix/garbage.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index fa39b6265238..cd3e8585ceb2 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -274,11 +274,20 @@ static void __unix_gc(struct work_struct *work)
>  	 * receive queues.  Other, non candidate sockets _can_ be
>  	 * added to queue, so we must make sure only to touch
>  	 * candidates.
> +	 *
> +	 * Embryos, though never candidates themselves, affect which
> +	 * candidates are reachable by the garbage collector.  Before
> +	 * being added to a listener's queue, an embryo may already
> +	 * receive data carrying SCM_RIGHTS, potentially making the
> +	 * passed socket a candidate that is not yet reachable by the
> +	 * collector.  It becomes reachable once the embryo is
> +	 * enqueued.  Therefore, we must ensure that no SCM-laden
> +	 * embryo appears in a (candidate) listener's queue between
> +	 * consecutive scan_children() calls.
>  	 */
>  	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
> -		long total_refs;
> -
> -		total_refs = file_count(u->sk.sk_socket->file);
> +		struct sock *sk = &u->sk;
> +		long total_refs = file_count(sk->sk_socket->file);
>  
>  		WARN_ON_ONCE(!u->inflight);
>  		WARN_ON_ONCE(total_refs < u->inflight);
> @@ -286,6 +295,11 @@ static void __unix_gc(struct work_struct *work)
>  			list_move_tail(&u->link, &gc_candidates);
>  			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
>  			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
> +
> +			if (sk->sk_state == TCP_LISTEN) {
> +				unix_state_lock(sk);
> +				unix_state_unlock(sk);

Less likely though, what if the same connect() happens after this ?

connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
----------------	-------------------------	-----------
NS = unix_create1()
skb1 = sock_wmalloc(NS)
L = unix_find_other(addr)
						for u in gc_inflight_list:
						  if (total_refs == inflight_refs)
						    add u to gc_candidates
						    // L was already traversed
						    // in a previous iteration.
unix_state_lock(L)
unix_peer(S) = NS

						// gc_candidates={L, V}

						for u in gc_candidates:
						  scan_children(u, dec_inflight)

						// embryo (skb1) was not
						// reachable from L yet, so V's
						// inflight remains unchanged
__skb_queue_tail(L, skb1)
unix_state_unlock(L)
						for u in gc_candidates:
						  if (u.inflight)
						    scan_children(u, inc_inflight_move_tail)

						// V count=1 inflight=2 (!)


As you pointed out, this GC's assumption is basically wrong; the GC
works correctly only when the set of traversed sockets does not change
over 3 scan_children() calls.

That's why I reworked the GC not to rely on receive queue.
https://lore.kernel.org/netdev/20240325202425.60930-1-kuniyu@amazon.com/


> +			}
>  		}
>  	}
>  
> -- 
> 2.44.0
> 

