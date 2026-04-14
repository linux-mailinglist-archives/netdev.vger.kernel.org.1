Return-Path: <netdev+bounces-278460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhoABdG3mnlpwkAu9opvQ
	(envelope-from <netdev+bounces-278460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AD3FAB9C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45613094090
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28B2C21C7;
	Tue, 14 Apr 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+mVmJ+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E99189B84
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174250; cv=none; b=XLETxZuKTEobnLRhJrYDqPxt5hKrNrbY/wh4chyoMzV4NU12DivtbuMxxGytdT3MPcSvrum+zplXzqmghyEUomFf91NZhWt3riP0DOp3JRd7+PFuCAqOOGHSqfH6HooU76zGYAc14zpKlhuk9tEk0a3rvFVyzTyqsz4OpJ9Rrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174250; c=relaxed/simple;
	bh=oSlGo+if/YqiWS7irCjWFugj0B6rkt+Vcf1Uf3PjkMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvrblZjBG86wzuJ5Rzrhg7VuE17CAqVS0S/e1pis9XEkTvN9UCNpDavEN3WTTocTau2oqMlbu9DlO9fqwKD6lkElKxe/iepYnPEyOgo1jOdtKZ9plwQvS/y3Dz198KIfdldO2I/keskO37OyG0YkwB4n//qGjQu8vCxytLSCrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+mVmJ+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C41BC2BCB0;
	Tue, 14 Apr 2026 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174250;
	bh=oSlGo+if/YqiWS7irCjWFugj0B6rkt+Vcf1Uf3PjkMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+mVmJ+r/RtBytiFyTZMal5RZ/xpQu9Hl3S9x6YgnHN+JGPgSOw4BB0lnB6JrtfO6
	 NNnVKU225nvkiS655CO2TXQh6ssrMdzbvXl5/SgltLV1h0HwivA5MBlMJo2Kc7BMM8
	 mvm8Dc+zFIEdmV7lo2Ek9DfCxFX9VNl9Yiqxyf6UkFb23diVOMevgDVqTJAj0zubCR
	 JKBD2Pn9csyvgU1eVEGU7nl70o0LAWXxJEnXgbqsNU1oRS9vdafBocoa4ZDwHgjj4J
	 DVULAIPqGYE4yfGuVazxY1nxIAs84DRi75qyJB4gzvr0Z0quGfRILalunWyYl62bam
	 wdyVjHR351maQ==
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	netdev@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH net] slip: reject VJ frames when no receive slots are allocated
Date: Tue, 14 Apr 2026 14:41:27 +0100
Message-ID: <20260414134126.758795-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412154252.2060940-2-bestswngs@gmail.com>
References: <20260412154252.2060940-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278460-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 974AD3FAB9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
slip: reject VJ frames when no receive slots are allocated

This commit prevents a null pointer dereference by adding checks for
a NULL comp->rstate in slhc_uncompress() and slhc_remember(). It ensures
frames are rejected when no receive slots are allocated.

> diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
> index e3c785da3eef3..e67052bcab57b 100644
> --- a/drivers/net/slip/slhc.c
> +++ b/drivers/net/slip/slhc.c
> @@ -502,6 +502,10 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
>  
>  	/* We've got a compressed packet; read the change byte */
>  	comp->sls_i_compressed++;
> +	if (!comp->rstate) {
> +		comp->sls_i_error++;
> +		return 0;
> +	}

While reviewing this code, a few pre-existing issues were noticed in and
around slhc_uncompress().

Can slhc_uncompress() cause a heap buffer overflow?

It expands compressed packets by prepending reconstructed IP and TCP
headers, which can total up to 120 bytes if options are maximized. The
caller in slip.c assumes a maximum expansion of 80 bytes:

    if (count + 80 > sl->buffsize)

If a compressed packet is sized at sl->buffsize - 80, slhc_uncompress()
shifts the payload and copies the 120-byte headers, writing up to 37 bytes
past the dynamically allocated sl->rbuff chunk. Does this corrupt memory?

Also, does the decode() function read variable-length deltas without
bounds checking against the packet length isize?

A malformed packet with multiple change flags set could cause decode()
to read up to 15 bytes past the end of the packet data. Because the packet
buffer sl->rbuff is allocated via kmalloc without zero-initialization,
could this read uninitialized kernel heap memory and inject it into the
reconstructed TCP/IP headers, leaking it back to the network?

Finally, do slhc_compress() and slhc_uncompress() read and write the
16-bit TCP checksum using direct pointer casts?

drivers/net/slip/slhc.c:slhc_uncompress() {
    ...
    thp->check = *(__sum16 *)cp;
    ...
}

Since the compressed header varies dynamically in size, the cp pointer
frequently lands on odd byte boundaries. On architectures with strict
alignment requirements, could this direct dereference trigger an alignment
fault and kernel panic? Should the code use get_unaligned() and
put_unaligned() instead?

[ ... ]

> @@ -651,8 +655,9 @@ slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
>  
>  	/* The packet is shorter than a legal IP header.
>  	 * Also make sure isize is positive.
> +	 * Reject if no receive slots are configured (rstate is NULL).
>  	 */
> -	if (isize < (int)sizeof(struct iphdr)) {
> +	if (!comp->rstate || isize < (int)sizeof(struct iphdr)) {
>  runt:
>  		comp->sls_i_runt++;
>  		return slhc_toss(comp);

When dropping a packet due to a lack of configured receive slots
(rslots == 0), should this increment comp->sls_i_error instead of
comp->sls_i_runt?

Dropping a packet because rstate is missing is an internal configuration
state, not a runt packet.

