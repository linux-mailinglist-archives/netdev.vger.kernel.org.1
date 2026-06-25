Return-Path: <netdev+bounces-302010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWJBFFxMPWro0wgAu9opvQ
	(envelope-from <netdev+bounces-302010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896F6C723A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:42:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZunocGE4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302010-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C54230148DA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BD2727E2;
	Thu, 25 Jun 2026 15:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBF26E173
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:42:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402135; cv=none; b=jE45wZk1PhAZ2RtekdE/ajaC78S6vWzBY8Ml18x9k6r5oh217VUoesP0mjbd4PzJYjr2IfZUv01LZRv+Ilx876mvocz3nwImTDWPsGbVxEk4ma0SVcsulk3nkSpF1F59Xi2wjaDWjDcngiqgp5rUc4OWCmoV4wR3U8fNsIo6sNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402135; c=relaxed/simple;
	bh=vRCn8PGM+0EMQ9aGp4GJOp1RcgvwkNxMaclt43hr/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwDTWP+p34YWHgAYtruBzEjp0vyXsTtlx04q6Hi8kSWXaImxx5FwSuOBs5Cl7Q/buaP+Mi73ccMwlrHh2OqYrbqNotK0GYGb/34BXT6FPloKtDUpkXT6heNaKT+clEzHKkuGHt/UaEVOlDKphsbCstBlTCeGtfmiWeNG3jgNKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZunocGE4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCF21F000E9;
	Thu, 25 Jun 2026 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782402134;
	bh=uw2n2/Tj8fbz+4qmyiLnFQZn8q1hFI6sK7fn11ncxbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZunocGE4RCgLT5gJjgl67orbwFbwouftLFusUQWmsKntHoQw1l7rI4YXiehj2eNFm
	 1LNy8bIP9YO2ieaG/+RnBBuQtYL0E8qEOSSxhD7taJw6CV1u++LQjqxDfjD0wbq+pu
	 lF0XgqMp7qfjPUTRJaV7OBIg4DHyLchQGGF6FoEBPWnCqh1MvxrJ3dGoF/DXX2Q8iM
	 ht0ObuG4NRkJQt5mHmxIIrygL1mkNl2QlyRwtr5kXgFjETp6NqkYW/lzcBDlFmA3mT
	 vee5v5yrNgfdqhLksm0I78os9U7aUndkoItEY+iDYK/qEb+EkpS7IP1C7NWDBj5rd4
	 LSba5PvuwNRwg==
Date: Thu, 25 Jun 2026 08:42:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, edumazet@google.com,
 vimal.agrawal@sophos.com
Subject: Re: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
Message-ID: <20260625084213.4e0b70c4@kernel.org>
In-Reply-To: <20260625102020.92814-1-vimal.agrawal@sophos.com>
References: <CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com>
	<20260625102020.92814-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avimalin@gmail.com,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:edumazet@google.com,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4896F6C723A

On Thu, 25 Jun 2026 10:20:20 +0000 Vimal Agrawal wrote:
> Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
> on every allocation attempt with no rate limiting. In workloads with mostly
> active/reachable entries, the GC walk traverses a large portion of the
> neighbour table without reclaiming entries, holding tbl->lock for an
> extended period. This causes severe lock contention and allocation
> latencies exceeding 16ms under sustained neighbour creation.
> 
> Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> performed within the last second, avoiding repeated full table scans and
> lock acquisitions on the hot allocation path.
> 
> Profiling of neigh_create() shows ~3 orders of magnitude latency
> improvement with this change.

I'm not an expert on neigh but 1 second seems a little aggressive.
Can you see if 10msec doesn't give us a similar win?

>  net/core/neighbour.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..078842db3c5f 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  	int shrunk = 0;
>  	int loop = 0;
>  
> +	if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> +		return 0;
> +
>  	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>  
>  	spin_lock_bh(&tbl->lock);


