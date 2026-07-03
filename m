Return-Path: <netdev+bounces-304343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9WB9ImNNR2omVwAAu9opvQ
	(envelope-from <netdev+bounces-304343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9526FED50
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:49:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304343-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304343-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C56F302A7C1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724DB3655EA;
	Fri,  3 Jul 2026 05:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925736A37F
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057655; cv=none; b=ORJNAox7H5ZskXypiNR8PCtOtmK7azahzRFreAK6SA81nDPsA7oga7rQ35ATNxrCBF1/oxZUZfc/CRD56qG4adlYbQLlTKjfeDsttBXJ1I35NW71wb6YDvijRwz7+KsE3cpgK4YvUmikZXrtYr4KkaXm7ZZCC5r5C8afp8+KFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057655; c=relaxed/simple;
	bh=jxAEDOXDu90dcfT6Q0xSXK/pKc8Cnuh8gxIq8c7fVFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgBjzWc5u45Uq07ATfs05Qxq4DOFVuElF/+0HwnaL7pdqmgST/aNccgTsodp1JGadapYhqnfdnnvcVX4+BCSWYwyFTlWlrrnaEnbhzXxdBZUz1wupamwGLGumaDH7KBeWS/RUqUZI/XuCG5uLKiLr7bpXYjH3n/NnfKS/ySMqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1BF2160491; Fri, 03 Jul 2026 07:47:20 +0200 (CEST)
Date: Fri, 3 Jul 2026 07:47:19 +0200
From: Florian Westphal <fw@strlen.de>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before
 xfrm_hash_rebuild reinsert
Message-ID: <akdM501yK5_mk1th@strlen.de>
References: <20260703051932.966884-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703051932.966884-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-304343-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:from_mime,strlen.de:email,strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF9526FED50

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> xfrm_hash_rebuild()'s first loop preallocates the bins/chains the reinsert
> loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate or
> fail. But its guard is inverted: it skips policies with prefixlen <
> threshold and preallocates for the rest.
> 
> prefixlen < threshold is exactly when policy_hash_bysel() returns NULL and
> the reinsert takes the allocating xfrm_policy_inexact_insert() path. So the
> loop preallocates for the exact policies (which never allocate) and skips
> the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
> reinsert. On failure the error path only WARN_ONCE()s and continues,
> leaving a poisoned bydst node; the next rebuild's hlist_del_rcu()
> dereferences LIST_POISON2 and takes a GPF. Reachable under memory pressure,
> deterministic via failslab.
> 
> Invert the guard so preallocation covers exactly the reinserted policies;
> the reinsert then allocates nothing and cannot fail.
> 
> Crash:
>   Oops: general protection fault, probably for non-canonical address
>   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead...]
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
> Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhashtable")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Reviewed-by: Florian Westphal <fw@strlen.de>

