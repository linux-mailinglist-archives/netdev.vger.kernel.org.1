Return-Path: <netdev+bounces-269679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xrWQHI50vGnYywIAu9opvQ
	(envelope-from <netdev+bounces-269679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:11:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D407A2D2E4B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA02B302836B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F46C3FF8BF;
	Thu, 19 Mar 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mljWtymt"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43239B97D;
	Thu, 19 Mar 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958280; cv=none; b=kWKGdaUrQ8Hk544egmcZY4G9s26dKjWsAqYriaakCFMKGybB3fQwG8FfgMmI+GEaxiepQlWMe/7tRC58MAbvaZ+QhQFXQrtMdGjl6KD2btPES3SZUySCL2rcEb5hP0bZ8V7H2agqCiToIn8QlBInZjcvrYCeSNxy4DcBtiP8lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958280; c=relaxed/simple;
	bh=9SEPiWDtYK915dM/C6koVFsZw+XgKzFlGBbVBs7PxtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzEjXS5gzZrZkZGAmcYXqg6ggZw+FTbJkmA62SBe40+IACfVIxzKTC8oU1VIJOB8SQshKX+uUpTILAG/pgvaBu8s3JW0u/AdcadaKqJ5SB+b5BVAE62eK+Up3EwaR1guPsc+EYVsGF4WUqQMGAFQRMpQEg4GnBM4GjCQJCokHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mljWtymt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 67A8041209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773958272; bh=pMssSaY3o+6SS7PX7iNNHD9bSiFr2yXyJvC2G9sajBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mljWtymtW29QF0H6t3+rbQc9YPQR49BsqrPMLyyFIshT5SpcYDZpbG3hfx3zEa+2B
	 DIy1R3nrrX13dniiEpKa4qoHRqJ1xuzG4M3/7U0621Um6WLKxAoZtySyyn8s1DUWaH
	 5VkMJLibBjFeXjJSyrg751f9M7+/rzEi/YgKDubiWlPflAh23i/07ez2O4FaVezYc/
	 KojiIJWUbDIo1jjZoj/xSIMTbrdaPOkQsRsChjW7IWzMTjiHUdqQZcq7pLZJssTRpg
	 4trJfpaAgh68brPeN0q7f6+68hd5F5tf+DKHib6A3f5cNInhgsXKnWSnfZGQjdonig
	 R0LphD1pLmivQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 67A8041209;
	Thu, 19 Mar 2026 22:11:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ralf Lici <ralf@mandelbit.com>, netdev@vger.kernel.org
Cc: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>, Antonio Quartulli
 <antonio@mandelbit.com>, Ralf Lici <ralf@mandelbit.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 15/15] Documentation: networking: add ipxlat
 translator guide
In-Reply-To: <20260319151230.655687-16-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
 <20260319151230.655687-16-ralf@mandelbit.com>
Date: Thu, 19 Mar 2026 16:11:11 -0600
Message-ID: <87se9vh3ls.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lwn.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trenco.lwn.net:mid,lwn.net:dkim]
X-Rspamd-Queue-Id: D407A2D2E4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ralf Lici <ralf@mandelbit.com> writes:

> From: Daniel Gr=C3=B6ber <dxld@darkboxed.org>
>
> Add user and reviewer documentation for the ipxlat virtual netdevice in
> Documentation/networking/ipxlat.rst.
>
> The document describes the datapath model, stateless IPv4/IPv6 address
> translation rules, ICMP handling, control-plane configuration, and test
> topology assumptions. It also records the intended runtime configuration
> contract and current behavior limits so deployment expectations are
> clear.
>
> Signed-off-by: Daniel Gr=C3=B6ber <dxld@darkboxed.org>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
>  Documentation/networking/ipxlat.rst | 190 ++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/networking/ipxlat.rst

You need to add this new file to Documentation/networking/index.rst or
it won't be included in the build (and you'll get a warning).

Thanks,

jon

