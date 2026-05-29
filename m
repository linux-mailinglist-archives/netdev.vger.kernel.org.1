Return-Path: <netdev+bounces-292920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EyfOGnoGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 663375FBE5F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE976303AF89
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40D351C2A;
	Fri, 29 May 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqVHeGL3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889D30F55F;
	Fri, 29 May 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017201; cv=none; b=e35/j+oX/sSsYdmXS4+Cp9TknUqKdOjhSUvcgRxDYRfhzC9oxhqqDkfgAxq0pKaiGu2LRt7JYgtXQy99qJWFdyJFdE0V8biOT3oHjTysSbf6IYEM06J02zR0FjcPbsHwYf8sfbgekCIAEgT4/HrQXCt3BstAG0rpz1N8WDg+71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017201; c=relaxed/simple;
	bh=wr1Umw443VXOyPXX6FB5uwurjVhIRmg73MLYsiD9a4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fsrp7EhmxNKP9d5YP8EYbMLO0Y5u5N/nPwC6wHCOIAtBzHvjCgnjBzVs7WXM/fSUC8gpISH7MpK1X1fmf09q+Rzpt2pIDhbCgi5HL5q1JSfuGcyfy3wp9KuTmHmIlvbT8go2PTnQR5W2FHpLdVrlCCOpXBSM337iyKSGD26l424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqVHeGL3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2E1F000E9;
	Fri, 29 May 2026 01:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780017200;
	bh=rkIpGF6Pi8bz6c4qR1OvOos+QpcR/buFFwsseLK9Kfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QqVHeGL3kaDFobMUiAVXszqXqTIEKXHI/40Hs+boQXNuAsWaHKq7iKkUTvI+TMQRx
	 9Dm1lvNX3tJwsBj7FMazAoXahAlfPuwUng6eCWn7HizSkGMRaNIVnC2TjFj0EOx3DF
	 L1rbUm1yu2rKA2noIaNtDgf6hvTuNVaB/NoaY3H8adyfUSZl0SXw9aashZHVFtrzNS
	 YhIDohKRad7nyMkCICcm2GaF4WSjt8f8wjFyH9QPq3lK1/bYtYWZ1aSnNXEOx0jFgk
	 bUS7H+79WGysPARdPeBMagZT/TC9B00AmP1KpWthjszLVln3blYvKQkwixxMbYRp0I
	 +3iehA7c1c5pA==
Date: Thu, 28 May 2026 18:13:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Pedro Tammela
 <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_api: use mutex in
 tcf_idr_check_alloc
Message-ID: <20260528181319.79aeb1b2@kernel.org>
In-Reply-To: <20260526220847.28365-1-kylebot@openai.com>
References: <20260526220847.28365-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292920-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 663375FBE5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 15:08:47 -0700 Kyle Zeng wrote:
> Currently, the NEWTFILTER path uses RCU to guard action idr accesses while
> the DELTFILTER path uses mutex to guard action accesses. This
> inconsistency leads to a race condition scenario, which can lead to
> erroneous operations on refcount, eventually leading to use-after-free
> situation.
> In this patch, we revert the introduction of RCU back to mutex in the
> NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> the race condition.

The commit message is quite inadequate here. Looks like a
run-of-the-mill UAF so you should explain the flow / race that leads 
to it properly.

Doing some extra digging with Jamal off-list we can't find the reason
why normal RCU protection wouldn't work here so maybe hold off reposting
until you hear from Jamal.

