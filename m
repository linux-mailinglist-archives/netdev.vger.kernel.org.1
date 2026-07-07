Return-Path: <netdev+bounces-305296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L+79JHqeTGqinAEAu9opvQ
	(envelope-from <netdev+bounces-305296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:36:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE206718050
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:36:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=OQD9Ll8E;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305296-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305296-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3983033505
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BE3A7F4C;
	Tue,  7 Jul 2026 06:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BF221546
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:35:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406121; cv=none; b=bUkjW09X+55Z98MqCOzY8oOcntFP1W5GHNB+QPEh4WMNML0YWJJ0znGlA2Zs26B8QecVtuObiBuDItyyQI1qGUOcSo2S+pBV3ljsUYTq0kl3nSwGkl35WETFrRGZvyNEOYq7d8xvcUG+CKuYDfWo4ZWNJGUzlKwjB4dadyo2YjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406121; c=relaxed/simple;
	bh=VDrBstBOFICQAgg+jbFgeBja/S2bIuBwqO6VoAQaGl0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKYvEUWSHdQgJCMcaajRn9Go1wb/P8cmBy734/iNREF1YVCDF8YI64RalF39z/co0hJOMqAEOVc1RkHD8p8fhimimHG9Cjm2P7/VaWB+gwhjMQfveFxMa+fuZ/iSAfCKn25NFUVS1Vut3qpbwbjDaXJZA77UkP+turiZ/CVumvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OQD9Ll8E; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 59F9220684;
	Tue,  7 Jul 2026 08:35:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dZA85wDudYW; Tue,  7 Jul 2026 08:35:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AA900201A7;
	Tue,  7 Jul 2026 08:35:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AA900201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783406116;
	bh=kzrzumhwSvWjHox7RF0py7oBmUZ7+wYva9qQEZ8GZBU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OQD9Ll8EEoMW5MdmqVSDGAkSyIzktp33+YK4OOoCxhcf5Ce4MyHkduD2QWABFDpAM
	 F5dLUyGerxiZbMUXG77MRl21AaAdk5f2Pkcp4Q+iES9cja8ZjfYEHHaAOl6fq1e3GA
	 Ixw5GPTQsAiifa6UGCfHf9LmbE3RZzmXjZRIFR8KpTCKrHffunCZ1ccH6hiibQWHqh
	 8ueel/f1qJ/fOISEFgAFxRgBC/fGoxubsATMwxAUAMG5p3bftRekaqOkY5f5xcjbLa
	 y+FpxTbJmGWmz0PbsIPWufqSvFVkUD2IgT2MPMXNrCHZaGyUSYPp/NElIzmWBc6JNd
	 kevODSIjpN0QA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:35:15 +0200
Received: (nullmailer pid 205581 invoked by uid 1000);
	Tue, 07 Jul 2026 06:35:14 -0000
Date: Tue, 7 Jul 2026 08:35:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: "Xiang Mei (Microsoft)" <xmei5@asu.edu>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <netdev@vger.kernel.org>, <horms@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<AutonomousCodeSecurity@microsoft.com>, <tgopinath@linux.microsoft.com>,
	<kys@microsoft.com>
Subject: Re: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before
 xfrm_hash_rebuild reinsert
Message-ID: <akyeIoKtMaRiQUI7@secunet.com>
References: <20260703051932.966884-1-xmei5@asu.edu>
 <akdM501yK5_mk1th@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akdM501yK5_mk1th@strlen.de>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305296-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:xmei5@asu.edu,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE206718050

On Fri, Jul 03, 2026 at 07:47:19AM +0200, Florian Westphal wrote:
> Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> > xfrm_hash_rebuild()'s first loop preallocates the bins/chains the reinsert
> > loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate or
> > fail. But its guard is inverted: it skips policies with prefixlen <
> > threshold and preallocates for the rest.
> > 
> > prefixlen < threshold is exactly when policy_hash_bysel() returns NULL and
> > the reinsert takes the allocating xfrm_policy_inexact_insert() path. So the
> > loop preallocates for the exact policies (which never allocate) and skips
> > the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
> > reinsert. On failure the error path only WARN_ONCE()s and continues,
> > leaving a poisoned bydst node; the next rebuild's hlist_del_rcu()
> > dereferences LIST_POISON2 and takes a GPF. Reachable under memory pressure,
> > deterministic via failslab.
> > 
> > Invert the guard so preallocation covers exactly the reinserted policies;
> > the reinsert then allocates nothing and cannot fail.
> > 
> > Crash:
> >   Oops: general protection fault, probably for non-canonical address
> >   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead...]
> >   ...
> >   Workqueue: events xfrm_hash_rebuild
> >   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
> >   RAX: dead000000000122   (LIST_POISON2 + offset)
> >   ...
> >   Call Trace:
> >    hlist_del_rcu (include/linux/rculist.h:599)
> >    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
> >    process_one_work (kernel/workqueue.c:3322)
> >    worker_thread (kernel/workqueue.c:3486)
> >    kthread (kernel/kthread.c:436)
> >    ret_from_fork (arch/x86/kernel/process.c:158)
> >    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >    ...
> >   Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhashtable")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>

Applied, thanks everyone!

