Return-Path: <netdev+bounces-204661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F7AAFBA59
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D03189C2F8
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0922577E;
	Mon,  7 Jul 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3kDLldL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSaJvOni";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3kDLldL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSaJvOni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334251DE4CE
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911566; cv=none; b=c0ntV9Q5KDeVK2WS7cFpMXozvCMEQRZPbL/9uExDTTxWEjF/ce3tCZ5vvr6NCQwUbqQd/3Can06Wbt9h9uMpHFAoc7Mq2JazbGqEw11a9uCVbCYrogNJJ0AdX4xwSo4w/zvz2ZNnSHV7eFQfxiipZTJiHKqLew2Fk6sZoVfq7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911566; c=relaxed/simple;
	bh=EUWWMbUY9ateg96QhXRNUNfq0grkZdzUiVEFChiED8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+8K+fxpBSJfe+u+oYLSmP2vSOE1wPfZh0nhPo9E7k9oP/28HD2TcjrbNg6en/msM4G7bmt91iVLYO/Z83vHqPKugu87fEGv+/XhDJbCUVjr1KrJTs9edxt6rSdsxVKqvZ7nGsPRl0s9/+zPHGxclgXU0QImtU4sHedHobVMy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3kDLldL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSaJvOni; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3kDLldL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSaJvOni; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C6E62115E;
	Mon,  7 Jul 2025 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751911560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUWWMbUY9ateg96QhXRNUNfq0grkZdzUiVEFChiED8o=;
	b=T3kDLldL4ZPx2Vj8uGglfJzRxj3/zeMMzNqF4Q+4IaB3Dm+gBW68783/Z/xdkx/lL3l45b
	q+fL99V8TrxhdTktI9XzE0ByCDg4ibi0RXPnZKW3plhTvXdR+UEg/dNjXvJ533WVD7ffqR
	sD8TwSKGk4jvtmzu9z22hMvTxBoZBiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751911560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUWWMbUY9ateg96QhXRNUNfq0grkZdzUiVEFChiED8o=;
	b=lSaJvOniYX8Jbh2LYFyIo8KschfgpOym2z8YAx3yoDjXAQzp3Ly65v8GmaDsEv58OcL7em
	hkPthbRqf77/wdCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751911560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUWWMbUY9ateg96QhXRNUNfq0grkZdzUiVEFChiED8o=;
	b=T3kDLldL4ZPx2Vj8uGglfJzRxj3/zeMMzNqF4Q+4IaB3Dm+gBW68783/Z/xdkx/lL3l45b
	q+fL99V8TrxhdTktI9XzE0ByCDg4ibi0RXPnZKW3plhTvXdR+UEg/dNjXvJ533WVD7ffqR
	sD8TwSKGk4jvtmzu9z22hMvTxBoZBiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751911560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUWWMbUY9ateg96QhXRNUNfq0grkZdzUiVEFChiED8o=;
	b=lSaJvOniYX8Jbh2LYFyIo8KschfgpOym2z8YAx3yoDjXAQzp3Ly65v8GmaDsEv58OcL7em
	hkPthbRqf77/wdCg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id CD5AA20057; Mon, 07 Jul 2025 20:05:59 +0200 (CEST)
Date: Mon, 7 Jul 2025 20:05:59 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Chintan Vankar <c-vankar@ti.com>
Cc: s-vadapalli@ti.com, danishanwar@ti.com, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v3] pretty: Add support for TI K3 CPSW
 registers and ALE table dump
Message-ID: <amrdqao56qoonqvxxtsdufzib3pctiqumbsz2io2cz3uktkk4h@wxaxo2ozjxcp>
References: <20250705134807.3514891-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5prkyphzq5ter5ff"
Content-Disposition: inline
In-Reply-To: <20250705134807.3514891-1-c-vankar@ti.com>
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.90


--5prkyphzq5ter5ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2025 at 07:18:07PM GMT, Chintan Vankar wrote:
> Add support to dump CPSW registers and ALE table for the CPSW instances on
> K3 SoCs that are configured using the am65-cpsw-nuss.c device-driver in
> Linux.
>=20
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

The patch breaks compilation with gcc7 which doesn't like variable
declarations at the beginning of a case block in switch statement
(lines 423 and 432 in am65-cpsw-nuss.c). Newer versions (at least 11-15)
do not have a problem with this so it seems to be rather a bug in gcc7.
Thus I'm going to apply the patch anyway (unless I find a real issue
with it which is not likely).

That being said, putting variable declarations there is a bad habit
as such case block is not a scope in C (causing errors e.g. when you use
the same variable name in two different case blocks of the same switch
statement) even if it seems to be optically.

But that's rather a cosmetic issue which can be addressed later.
Standard cleanup is either declaring the variables earlier or, if you
really want the scope of such variable to be within one case block,
closing it into a { ... } block.

Michal

--5prkyphzq5ter5ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhsDIQACgkQ538sG/LR
dpXxYggAjuX6SYg+XOakZBvXxzoo3BCjJHRKYrPZxx1Cy01I0sP7WXtwH80zo76k
73sfNVZ+8LMQ3zo+z5UgC1U+NsHUlNVawwiQ8ddj0Vtg9cMDWVh/HruSwZgPZutp
Twb4kgehGveEq0iLSwkbAWWfHZ76Jf65YDW3bEiefFF7oj10+afEBrLzk7jySnSM
XV6Z1KJ0jDQYM/XlX4TI+SIb2kgTIKWiUmsbGR6fPAfNhj6jKV/ug+TmM1dQ2Qjx
bFlIT9MK4QOpDQl1dHyaMMx0N3wEIlnOsdbM8kX9CAucH+DWRLnoKgACGqgMwYHz
a16u6ZSAFp+ody6UVHVn7lCjVctxGg==
=prDF
-----END PGP SIGNATURE-----

--5prkyphzq5ter5ff--

