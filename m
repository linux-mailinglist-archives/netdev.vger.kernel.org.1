Return-Path: <netdev+bounces-304327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DZ9kAIAzR2rIUAAAu9opvQ
	(envelope-from <netdev+bounces-304327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 869D26FE479
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304327-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304327-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECF613024E50
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39039314B66;
	Fri,  3 Jul 2026 03:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E430D3F2
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 03:58:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051126; cv=none; b=QMa+j9OkBwLaB9IGfLZk6gmfxsEv99tg/dY9NIZupLAeSNFtYRGAXs1GH+bS7ZggBtVqeHTX10YZ2GH9Xc1OEYtpMuJE2+4pkp/aBtcGiF0HHNgUEBK3AIIW6Ivtait7UABpes16+gnJ0PAYfCBleYlmFJ6Z5znSmd5a13naRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051126; c=relaxed/simple;
	bh=Ptmdr3m3TN0HVotuHSov19ADnJAk7vXm3Hbsa6mfsjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmt4My8X/To49Hkw9JEl/pNDeQxobOxwBnhbTE2eQrhEziX28jp8+42Omssd393MBlhXtaYXcjbvIS4HYehXVYHTLcYW6uHS68CXpiAQnSgmn2iOilbbYwV+GORF8ES1ZWfYt+aCBFXU9XNXo0GRdfOEo2N2jxhQiOgU/PruGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5D911602A9; Fri, 03 Jul 2026 05:58:28 +0200 (CEST)
Date: Fri, 3 Jul 2026 05:58:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
Message-ID: <akczZMzVg7l6tUnU@strlen.de>
References: <20260702185805.615241-1-xmei5@asu.edu>
 <aka5pwAGGI56QrrS@strlen.de>
 <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304327-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 869D26FE479

Xiang Mei <xmei5@asu.edu> wrote:
> Agreed, and my patch hides it instead of avoiding it. The problem is
> the prep loop's guard is inverted:
> 
>         if (policy->selector.prefixlen_d < dbits ||
>             policy->selector.prefixlen_s < sbits)
>                 continue;
> 
> That skips exactly the policies reinserted via the tree (prefixlen <
> threshold => policy_hash_bysel() NULL => xfrm_policy_inexact_insert()),

Indeed.

> locates for the exact ones instead, which never allocate and get
> pruned again at out_unlock. So the inexact bin/node is allocated GFP_ATOMIC
> after the hlist_del_rcu(), and that's the failure the WARN catches.
> 
> The reproducer lowers then raises the threshold so those bins are pruned
> and reallocated during reinsert; failslab just makes the failure
> deterministic, OOM would do the same.
> 
> v2 inverts the guard so prep prepares the set that's actually reinserted:
> 
>         -       if (policy->selector.prefixlen_d < dbits ||
>         -           policy->selector.prefixlen_s < sbits)
>         +       if (policy->selector.prefixlen_d >= dbits &&
>         +           policy->selector.prefixlen_s >= sbits)
>                         continue;

Much better!

> I checked the new patch on the reproducer, and the crash can't be triggered.
> If you agree with this new patch, I'll send this as v2.

Please do, thanks!

