Return-Path: <netdev+bounces-86315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546189E610
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEE31F21F82
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A8158D6E;
	Tue,  9 Apr 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I/RaT1BF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AD1E491
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705237; cv=none; b=tZgdnis/fkCv13O7hiv2qHCbBnWq2x/hBaKMHlC974PXciYY04QeCPsVdtiklpobyOEpp52RHpbU9uk8O5gek9lhF4pzMM0q6ju/skBKDM0AYzoRY4r2DSOvPKShE1ytQ/zpSlR7NZ8E2MJBN79CU+Aw7gxr6b7S5u9JPmFObEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705237; c=relaxed/simple;
	bh=fNeqRVOwZzV5wHs2j9Xy9PDbixHuZsXUsJ5e6TZhr3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcBiGa5LHyPm7CEipdlJIhou82W1HAD993k5vBts/PKmR93OOO3IYPburDwJB7/cJ/pGWsoOX21yWvr55SGALpd2wCH1KPVsmCXBDMJWZs6ZsLC2oTpetCwfajHW3940ITNbo/y/YdD48/wNmGNwpClqpiSd8Cjcd8bXyKUMXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I/RaT1BF; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712705235; x=1744241235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzVKdqAXFeFy9aFjTXv7nAszT2GydUGeixqWy+oWZ+o=;
  b=I/RaT1BFWJMMc8jHggaA8DzXL25aEYlkX4tfpThVT6jz6xAdGDrma58T
   ppervDCHS3+Vue8nlyuUVc0mOWMgrGYODflKQzK0B0ioACFb0XegfJkbD
   uOYuq3IL7neLzO/cSPFdE4J5E1LdKO45Fsuod8BxzqNKz8o9RATsHs1Ag
   M=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="79946757"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:27:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:20003]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.40:2525] with esmtp (Farcaster)
 id faf7531f-a1a5-4c8d-a1b8-533782f4be8b; Tue, 9 Apr 2024 23:27:13 +0000 (UTC)
X-Farcaster-Flow-ID: faf7531f-a1a5-4c8d-a1b8-533782f4be8b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 23:27:13 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 23:27:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v2] af_unix: Fix garbage collector racing against connect()
Date: Tue, 9 Apr 2024 16:26:59 -0700
Message-ID: <20240409232700.61277-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240409201047.1032217-1-mhal@rbox.co>
References: <20240409201047.1032217-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Tue,  9 Apr 2024 22:09:39 +0200
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
> there is another embryo coming, it can not possibly carry SCM_RIGHTS. At
> this point, unix_inflight() can not happen because unix_gc_lock is already
> taken. Inflight graph remains unaffected.
> 
> Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
> v2:
>   - Adhere to reverse xmas tree variable ordering
>   - Expand commit message
>   - Drop the reproducer
> 
> v1: https://lore.kernel.org/netdev/20240408161336.612064-1-mhal@rbox.co/
> 
>  net/unix/garbage.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index fa39b6265238..6433a414acf8 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -274,11 +274,22 @@ static void __unix_gc(struct work_struct *work)
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
> +		struct sock *sk = &u->sk;
>  		long total_refs;
>  
> -		total_refs = file_count(u->sk.sk_socket->file);
> +		total_refs = file_count(sk->sk_socket->file);
>  
>  		WARN_ON_ONCE(!u->inflight);
>  		WARN_ON_ONCE(total_refs < u->inflight);
> @@ -286,6 +297,11 @@ static void __unix_gc(struct work_struct *work)
>  			list_move_tail(&u->link, &gc_candidates);
>  			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
>  			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
> +
> +			if (sk->sk_state == TCP_LISTEN) {
> +				unix_state_lock(sk);
> +				unix_state_unlock(sk);
> +			}
>  		}
>  	}
>  
> -- 
> 2.44.0
> 

