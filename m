Return-Path: <netdev+bounces-278738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNWvOn1m32lSSgAAu9opvQ
	(envelope-from <netdev+bounces-278738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951540335A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5D2D3024451
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D09337BB5;
	Wed, 15 Apr 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GUbzKf9c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88E23A562;
	Wed, 15 Apr 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248406; cv=none; b=TsG+xXhK8W2I8YwrDggQ7XkzHN/GB8+M3R8WWeF2372vovrgMMlaG1FNYkLBkMgQtuEmL9ahC+QSZ5vRj237jwLHaWT+rpdxerNsKTJOor4kUrE3siF737BbDPYLqxGFHXwtkx7rlFiVJrCY0grq2yjPij6ZpNk9JCk3do+VIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248406; c=relaxed/simple;
	bh=3izd2EATtfso/P2Z+7mEjWOmmtqqvbzDvaLrc75Jw6Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ifzQoOgxDFvdGqD2yZshtOCeFa15gDEz2JbIC9q6D+GDKjgiDgAXunmimkUQrccJm7zjTlEU5S55i8y8OVnl28Fk3zzVxkBLnPTsqf+4p6oHHQdLJJLr6gtmmBbPBjCWMpeq56h6O9GrrZ3nyTQ4u9NAnYpbD352maevYRfpdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GUbzKf9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A0AC19424;
	Wed, 15 Apr 2026 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776248406;
	bh=3izd2EATtfso/P2Z+7mEjWOmmtqqvbzDvaLrc75Jw6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUbzKf9cPRgkM5Z6IA4Bi5gj7R/HRjhNK/tV8g1DPGTbEWeEDjstKsBD3HZJriBmW
	 Ltu/SLGrY9kdWEAacKRg1uEeNvqx0h7LrhabsFs+vncxvAJAFCOh41pRIPsPobzJig
	 Z11tHLMRRO/0PJo0Vz/Kb7c0m43WXVMuARCgABOI=
Date: Wed, 15 Apr 2026 03:19:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Konstantin Khorenko
 <khorenko@virtuozzo.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>,
 Nicolas Schier <nsc@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Vasileios Almpanis
 <vasileios.almpanis@virtuozzo.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] gcov: use atomic counter updates to fix concurrent
 access crashes
Message-Id: <20260415031957.bbb11155f82715490727e363@linux-foundation.org>
In-Reply-To: <9fba075d-9388-483f-818e-6ee3b168f18d@linux.ibm.com>
References: <20260402141831.1437357-1-khorenko@virtuozzo.com>
	<20260402141831.1437357-2-khorenko@virtuozzo.com>
	<20260406193707.GB1319599@ax162>
	<9fba075d-9388-483f-818e-6ee3b168f18d@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278738-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6951540335A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 10:11:24 +0200 Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> > would be to defer it to 7.2 at this point in the development cycle so
> > that it can have most of a cycle to sit in -next.
> 
> Adding Andrew since he typically integrates GCOV patches via his tree,
> and for input on how to handle this patch.
> 
> To summarize the situation, this patch:
> - is only effective with GCC + GCOV profiling enabled
> - fixes a run-time crash
> - improves overall GCOV coverage data consistency
> - triggers a number of build errors due to side-effects on GCC constant
>   folding and therefore depends on the associated series [1] that fixes
>   these build-errors
> - has a non-zero chance to trigger additional build-time errors, e.g.
>   in similar macros guarded by arch/config symbols not covered by
>   current testing
> 
> Given the last point, I agree with Nathan that this patch would benefit
> from additional test coverage to minimize regression risks, e.g. via a
> cycle in -next.

Great, thanks for preempting lots of dumb akpm questions ;)

Agree, I'll stash this in the post-rc1 pile.

