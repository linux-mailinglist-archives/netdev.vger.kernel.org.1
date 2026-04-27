Return-Path: <netdev+bounces-281541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBJVO97v72nYMgEAu9opvQ
	(envelope-from <netdev+bounces-281541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E13F47BC87
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E34301DACE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA633A75AB;
	Mon, 27 Apr 2026 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay8SLq9g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E364E92;
	Mon, 27 Apr 2026 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332130; cv=none; b=tjgMh2BQ8X/tMO/RpdmjfL74vz36N+lDwen2tfZzqO6zAnH7V/D+n7FisLq6lUY217nlZfRuv3nqmBcTUqMu9JRgFB6b/hrccRZ0KMfuwzWx3iaL5W8MCFmSNWkQ7JuQzHhWWsgrzPePSELnNPkIKGtTjqVdJ3AfHXZsPPwlRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332130; c=relaxed/simple;
	bh=81IQ/eYd32l85bdWp0t/7BehSWwgwWIf1MHbUIqakJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGNSc8J0cdNjrI/E4GOXIy4uMZ8RCui2brNt+TiQI+2e3D36CiWa5WGO8Euzh7xIGdaAxq6rv5COdsdJrJlfvs+RJzVtOpCt8h4obpIcQk1EulqFUTzD71+L+400/pLgyJPPNTjYoTQNi8QUkJBDlEeSlD6s3rOPmJCwMFqPUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay8SLq9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED307C19425;
	Mon, 27 Apr 2026 23:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332130;
	bh=81IQ/eYd32l85bdWp0t/7BehSWwgwWIf1MHbUIqakJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay8SLq9g6MkldlXKvnRMFU99Vo8iswS1DrDib2XLG9qsL6qHOXZXGIaKcYxG40Uto
	 rvp3d2JItXDwS8t90gTKr11cFTIHECCqADiuld7cwvOQyVivREKIr3ohQ8EU8GOqKp
	 MnsG2wzgZ6JROXBxJDwnfJMvXI63I2ogcXnEDYt+Mu2GszGjsVW6T9TN+HeQEOP2jT
	 rSRmD6DfafHweOg5UsR6y6Ly8iZObBOtv70EK+XTtQWVllvU9P2Xm68tCGYlssgOL/
	 5EbuxWT2iXSo4hq7rY+zt0KwKC9GrSWmVSznfLcQ7/R+PSAziew8pOshkFrFP0RLGU
	 NUTaXtF6C2svw==
Date: Mon, 27 Apr 2026 16:20:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
Message-ID: <20260427232054.GA2700@sol>
References: <20260427172727.9310-1-ebiggers@kernel.org>
 <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
 <20260427200116.GA3454259@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427200116.GA3454259@google.com>
X-Rspamd-Queue-Id: 7E13F47BC87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281541-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url]

On Mon, Apr 27, 2026 at 08:01:16PM +0000, Eric Biggers wrote:
> > - Ronald P. Bonica (the original RFC5925 author), together with Tony
> > Li do have an active RFC draft to support the additional algorithms
[...]
> > [1] https://www.ietf.org/archive/id/draft-bonica-tcpm-tcp-ao-algs-00.html

For what it's worth, that draft makes very little sense.  For example,
it proposes three variants of HMAC-SHA3, instead of just making the
modern choice of KMAC256.  And it proposes both HMAC-SHA384 and
HMAC-SHA512, despite them being redundant with each other after the
specified truncation to 128 bits.

Thus, it's clear that draft needs some work.  That would include, for
example, input from people who may be more familiar with best practices
for choosing cryptographic algorithms in new designs.

So I don't think the Linux kernel's implementation should, or needs to,
already implement all the algorithms in that unofficial draft.

All that's needed is the flexibility to add new algorithms later,
whether from a fixed version of that draft or from somewhere else.

We'll still have that with the library.

And to emphasize again, the current code also isn't really generic.  So
the support for new MACs doesn't necessarily come for free currently.
It probably works for arbitrary HMACs.  But HMAC != MAC.  If
AES-256-CMAC, BLAKE2, KMAC256, Poly1305-AES, or just about any other MAC
is ever needed, the code would have to be changed to support it anyway.

- Eric

