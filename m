Return-Path: <netdev+bounces-255129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id frZvFLmgfGlkOAIAu9opvQ
	(envelope-from <netdev+bounces-255129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:14:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DABA5E9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49304300A8EF
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324A36CE16;
	Fri, 30 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nPcmafig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d22heNOt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06A298CBC;
	Fri, 30 Jan 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775286; cv=none; b=muM6sejf+nZgMGyB+2oSLNEIotZtzXhy1AWbkxhzUpLC3qtExCSoS3MfyhQ4ySr7Uuufyd7y7RmDFnJKf435oj78U59twzVrKRDm0lJQxlIkfo9KWM8hdf1v+eX2UiFUmt9uFApEmg28QxX+7311pgarMG2dNsf/Z4aOcnghEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775286; c=relaxed/simple;
	bh=T2ynszaSPwee+0PtNkIvbz3yeVwvjqtKN8AXsKO/3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4M5stZaQCvXS5VgO+5SyBxjhOUc5/IpqwkAPQes61gtk696L+8Nj0BUMIV62j0HCzKfGplD7mCL5X4UAXKfEWLU9pqOWmOwJHTyiXy/G+DiJAg6yaKuxETEUGgxzxs1FWYPFTYW/DZ0dXqDHwUE993lwdnTJ7E6AIMb+LcgqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nPcmafig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d22heNOt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B27EA1400151;
	Fri, 30 Jan 2026 07:14:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 07:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769775282; x=
	1769861682; bh=MzLLPN6YtozLhJs3xB3wFOAPKWaat9nk7UAgnZhilC8=; b=n
	Pcmafig3MKALAZjwDUe/tDcfnS4gR7HzXjOgLZFd1oo+JJqffrDXK8aMjG1UUJ7h
	sa4776gtmWGgaUN1VQC+NgiiQl+MdMzKQ1+D7uLAxgEsvghe/sYxW7FcLZLP4/Zn
	BsXjEIP1B20CBCWrhQhCWFanE4i1VKsNhZENz/QO5P7nWxngdiyY85tJDCctD5iJ
	MEFrzgUIbzXQxVxntqMX46rekxsGx1f31hXFz85EWMIW+Jb/N6BBLOTqaX30Hfvn
	BNzHbVKa/8JKPuiwXIWFHPnZwxqk44Z9cYpjdP5CDBoVAzvIu0YdGjLcUkebvxWS
	q45y+OmtpjSPm5kBmL6wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769775282; x=1769861682; bh=MzLLPN6YtozLhJs3xB3wFOAPKWaat9nk7UA
	gnZhilC8=; b=d22heNOtVuaN9zz5Kcf6PBqhvKzIJDVmfY1nOF4sFd2ok41E4YP
	ZF3W2vPd5Uut9nsipZKHH2z1vMbiPnkt0V5u2SPpis1JrU3hKWnPpLjS91F+rCEy
	7jUKofKA3NOoTcK+EEXTOkFK50cjoeTmoOrIbNxG4URx3+Vuto8uph3gDoRStCTN
	Tz/POQT32aPVBfj7pn69ZTy2MfEXwjF1+rFsQfH4IxiaQv1nYrqh7A/HI3GKvuk+
	XPkL+tTMaIlxPxd0bJeVL7OkXehWGBBXviTij/kZQ4NZwwg2Ifznt6/JfeaD4rWG
	aekqRf1QFjLgJ+K8Hfh6DYWDpBVrAFgh4eg==
X-ME-Sender: <xms:saB8afrjgaA4k2aJHc01oGS0jbj8JQSeZRWWstGnCV9obhzU_fqbIg>
    <xme:saB8adWgXp6DPre5qo4wPJhyHJCK4QSl1BLYrz2guy8TN4ybQtviiWXWP5rr_v298
    zdo6W8OO2Nm4skDid_13gdhYhIE0MYfZxCOGf740zTLtSyXWu6r2l4>
X-ME-Received: <xmr:saB8aU0mnTSMoOaUb-TYCsDA2151iJBIYL2MGn7BXD5s7hcjbnPgyMV268C7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhihgrtghhrghnghifrghnghesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:saB8aUTEztxgg61w-RY8AHt5t5AobuPs8yw4566a-MNbFfRBPHylfg>
    <xmx:saB8aQQxec6VpmbtlBYu2QZx9ZOrM19W7rRzjcawqAG9t12RFCPxYw>
    <xmx:saB8adW1cRHDV4VcKasW8fbP2PdFAr3-btZlBECubFqMkOID30AeMw>
    <xmx:saB8aSJdn89iRB8sNCND8brrTda5v5d9J4NXVlO8OVf6-87j8CzL2Q>
    <xmx:sqB8aZ91oPffQgNBVDOQwtJGFlPKGv4u2g8tMCDPoq06oIQoXIXDxi_0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 07:14:40 -0500 (EST)
Date: Fri, 30 Jan 2026 13:14:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ipsec-next v5 7/8] xfrm: add error messages to state
 migration
Message-ID: <aXygrzQrsQxGdDG5@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255129-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: A44DABA5E9
X-Rspamd-Action: no action

2026-01-27, 11:43:42 +0100, Antony Antony wrote:
> Add descriptive(extack) error messages for all error paths
> in state migration. This improves diagnostics by
> providing clear feedback when migration fails.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v4->v5: - added this patch
> ---
>  net/xfrm/xfrm_state.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 88a362e46972..2e03871ae872 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2129,15 +2129,21 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
>  	struct xfrm_state *xc;
> 
>  	xc = xfrm_state_clone_and_setup(x, encap, m);
> -	if (!xc)
> +	if (!xc) {
> +		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");

When xfrm_state_clone_and_setup fails it's because some allocation
failed and the user won't be able to do much about this, right? I
don't feel extack in those situations is super helpful.

>  		return NULL;
> +	}
> 
> -	if (xfrm_init_state(xc) < 0)
> +	if (xfrm_init_state(xc) < 0) {
> +		NL_SET_ERR_MSG(extack, "Failed to initialize migrated state");

xfrm_init_state itself doesn't handle extack, but it's just a wrapper
around functions that do. Maybe better to make xfrm_init_state
propagate extack?

>  		goto error;
> +	}
> 
>  	/* configure the hardware if offload is requested */
> -	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
> +	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack)) {
> +		NL_SET_ERR_MSG(extack, "Failed to initialize state offload");

We already set an extack in xfrm_dev_state_add, this chunk should be
dropped to avoid overwriting the more specific info we got.

>  		goto error;
> +	}
> 
>  	return xc;
>  error:
> @@ -2161,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
>  		xfrm_state_insert(xc);
>  	} else {
>  		if (xfrm_state_add(xc) < 0) {
> +			NL_SET_ERR_MSG(extack, "Failed to add migrated state");

Not a strong objection, but this case would be the EEXIST situation
from xfrm_state_add, and there's not much the user can do about this?

>  			if (xuo)
>  				xfrm_dev_state_delete(xc);
>  			xc->km.state = XFRM_STATE_DEAD;

-- 
Sabrina

