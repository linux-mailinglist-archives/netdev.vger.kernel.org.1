Return-Path: <netdev+bounces-283037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOVxO33082nD9AEAu9opvQ
	(envelope-from <netdev+bounces-283037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 02:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E14A938A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32412300F52C
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ACA1E260C;
	Fri,  1 May 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCc2WnCz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702442770A;
	Fri,  1 May 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777595515; cv=none; b=SqtbNukJvu9A3hldsLUOy+6qbjkRmJThG3+3kkQspM2iK/I5jeQVmGO0wZDM6icr2trZgGrylPmyjokuLGR8FXTWrZO5iP8cxpM2yL5w9s+xsUURjDMcQZ5dimqAyBzBNYRKLyiwI4VqCODhuWFdxU5asZNPJCI6tFlQsLmuuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777595515; c=relaxed/simple;
	bh=YsbhzFCZ8r2kzDLdzun5DytE0uEepvTLkrIdp8LuMu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOrxeweESYUu8/wq2NZQ3ByNy/z2+80J0k4yaHYFO7Vuur59EOkYN0NHG+nHlMHKMDd0xTn1sm2KBniZsCZ19bJ746QhUct/2CB5D17lA5yTgzAoUsWWVVA0fgMkjxDvhfCFWWbm/ljLB+J114428p3Eq6gYPrKwf3OWWaxS1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCc2WnCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AA4C2BCB3;
	Fri,  1 May 2026 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777595515;
	bh=YsbhzFCZ8r2kzDLdzun5DytE0uEepvTLkrIdp8LuMu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oCc2WnCz+KoSJ/KtzGj4IjhwyngxqHGuFBiruuKdqOAUhYIk0DpGMSWfPJwQxHgkS
	 U3nVU6b5ytJagpuE2Icgf91Eta0s35XQJ8EIjsdz5pzYus7zBF4CBP52HPSqXdbZJs
	 FE7h2ZkLa5dmQdHzRmq1D7AzauJn636Xsm4QJzKViaEj7eVX8dzaFqIgV/w0nQED4Y
	 rF8p5k6giYHKYyBFC9KN/+kt9xWxNyciFRntH5tXyNXVD9Iy7tNGYWPc20ViyPAV53
	 qokPjCCosSlLFzyueE76o5aFG/i5/OpF5SnXNSF1BobmGt0SYtNYUexK0Zg6tM9A9V
	 b5Fb1rMRmDBxA==
Date: Thu, 30 Apr 2026 17:31:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
Message-ID: <20260430173153.5cd1d348@kernel.org>
In-Reply-To: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 895E14A938A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283037-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 21:44:37 +0200 Jakub Sitnicki wrote:
> skb metadata is meant for passing information between XDP and TC.
> LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.

netdev wasn't CCed on the sashiko reply but I think it now auto-marks
the patches as Changes Requested :| The Sashiko comments didn't seem
actionable to me. WDYT?

