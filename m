Return-Path: <netdev+bounces-304263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dCJxDxm6RmpXcQsAu9opvQ
	(envelope-from <netdev+bounces-304263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5F6FC7FA
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304263-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304263-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A8B83008690
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE63357CE9;
	Thu,  2 Jul 2026 19:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A123386579
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 19:19:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019952; cv=none; b=CH7VEjksV82wiv6VEfp8qSW7+uwA11LXsb2+O3O8i6JzDJXx7iyXIqdIQQe+Rm7CYePhR5rIkj+EOPcm0PS6vzlMMQwlth8wroBVJ1zHu4RzLYCL9/IncVd2zwf98HjTMwP+0M23HSTb+VN2ZsqSxkaTO9EH9QS2HhA4Vy9cG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019952; c=relaxed/simple;
	bh=BXFEv4+ZyyVGIZZ2caJJocv825e7NCyvtXtm/toI+Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y64DtXgZ1ePEZTV3Y2siaJMKQLJ0+aKmE35IwTS5Pi0jA+ckP/0AzuGOU9lm7yh09bZSgg3/0ApvlBIRjWnCjzSUxV9OxGk1N0CG7utCqCLLVadbz8KkSz3y1ACpirlgd8hBLeVnlb2yOrS+v8hqDGGsQxp15FeYVzCG/hft0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 65D9460218; Thu, 02 Jul 2026 21:19:07 +0200 (CEST)
Date: Thu, 2 Jul 2026 21:19:03 +0200
From: Florian Westphal <fw@strlen.de>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
Message-ID: <aka5pwAGGI56QrrS@strlen.de>
References: <20260702185805.615241-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702185805.615241-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-304263-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33D5F6FC7FA

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> xfrm_hash_rebuild() unlinks each policy from its bydst chain with
> hlist_del_rcu() and re-inserts it. For an inexact policy the re-insert goes
> through xfrm_policy_inexact_insert(), which can fail on a GFP_ATOMIC
> allocation; on failure the error path only WARN_ONCE()s and continues, so the
> policy is left with a poisoned bydst node (LIST_POISON2). The next rebuild
> calls hlist_del_rcu() on that node again, dereferences the poison, and takes a
> general protection fault.
> 
> Use hlist_del_init_rcu() instead, so a failed-reinsert node is left unhashed
> (pprev == NULL) rather than poisoned. The next rebuild's hlist_del_init_rcu()
> is then a no-op for it, and the non-failing case is unchanged.
> 
> The reinsert allocation is GFP_ATOMIC (it runs under xfrm_policy_lock), so in
> practice this is only reached under memory pressure; the crash below was
> reproduced deterministically by forcing that allocation to fail with fault
> injection (failslab).
> 
> Crash:
>   Oops: general protection fault, probably for non-canonical address
>   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
>   ...
>   Workqueue: events xfrm_hash_rebuild
>   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
>   RAX: dead000000000122   (LIST_POISON2 + offset)
>   ...
>   Call Trace:
>    hlist_del_rcu (include/linux/rculist.h:599)
>    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 7ef861a0e823..2612a405542b 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -1362,7 +1362,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
>  		if (xfrm_policy_is_dead_or_sk(policy))
>  			continue;
>  
> -		hlist_del_rcu(&policy->bydst);
> +		hlist_del_init_rcu(&policy->bydst);

This patch is dubious.  I looks to me as if it papers over the
actual bug.

Why is there a memory allocation error?

The first loop -- before unlink -- is supposed to preallocate the new
bins and chain heads.

This is also why there is a WARN. No memory allocations are supposed to
occur after the hlist_del_rcu(), there is supposed to be a guarantee
that the insertion succeeds.


