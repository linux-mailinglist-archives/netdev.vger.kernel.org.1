Return-Path: <netdev+bounces-294740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YQ5TBNwjIGqLwwAAu9opvQ
	(envelope-from <netdev+bounces-294740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57597637B79
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AEBwaoEZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15BDB3181879
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75C643E9D6;
	Wed,  3 Jun 2026 12:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F2D0625;
	Wed,  3 Jun 2026 12:42:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490561; cv=none; b=iHq1TAVvTztI4C1BGf74LmXepCaBnPFvOSjUWXXn4ym3GD8ss3DdkL9isnlZ0vINWUg4o0AccmJHa0C+q04UVcKmd8GIQvayLM2ExmP1PKzy7aVhNzwUBuhADhfpdPqYHXujqr8nR3NA8GogA38DtdG7nCTDNNZLw4ctsD9O2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490561; c=relaxed/simple;
	bh=BqqbVz39eZcGieDH4S9GcWuFlvyiwFN5lfWUHYEmdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsLKqUCcVWXbPwqDPJokszFdVeHfPHoQEon82SzEf8D6PT43ObwE/RtFr9EYma/q9pwUrQNqTGOC/4ETQXrDyz3jBIKwOvHhxTJGw8AK37DLh1BI60NR11zGIAjXNjmRPwZwFlnxU3weZvLazNsF53f2c+/zCRjbzWwPZj5i5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEBwaoEZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45451F00893;
	Wed,  3 Jun 2026 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780490560;
	bh=BqqbVz39eZcGieDH4S9GcWuFlvyiwFN5lfWUHYEmdEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEBwaoEZsTb5MZH1vuW+kAdocIAVYIjbNZgcutswOTN4EcvEClG214+XjFo0q3wa9
	 WIv4DqL+k/7EmI4Ff5jmIscIFWfCWxKhEImcvlCzdDIJKRwbhMsee9As7truZAqmLg
	 Qag8mHYP6UCWuwAtoJdTPyZI4UJGPvwP2Eq7w35dx8SKgjQG4zBw1D+BY3tBonzs8w
	 zzpMTJuC2lY/Tdj5s3Rfr6YFUJtEDBdlnsQPhgwpFZEYyhKTgmrZ/dM58MIhDEzFoa
	 cm/hookOcu5EH1WuQLIQt98sH91Wv9WHwfCEyR2o7WAPMp9kbl+XxDWmx/iVaIf+jy
	 AtHAtaLt6yoeg==
Date: Wed, 3 Jun 2026 13:42:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the security tree
Message-ID: <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
References: <ah8BzqSmZO40xYhS@sirena.org.uk>
 <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
 <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
 <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nGNcFUm9tdwcZ7nJ"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
X-Cookie: micro:
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-294740-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:bboscaccy@linux.microsoft.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57597637B79


--nGNcFUm9tdwcZ7nJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 05:45:04PM -0400, Paul Moore wrote:
> On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > Can you ping me when that goes in (or things are otherwise resolved)
> > please so I know to drop the revert from -next?

> You shouldn't see a conflict with lsm/next now, but if you do let me know.

It's still there today, but seeing Linus' comment about not merging
hornet I marked it as BROKEN instead.

--nGNcFUm9tdwcZ7nJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmogITkACgkQJNaLcl1U
h9DVGwf+NVc0XMabqCVzDIqGd1+DP3DzTxEm+ofenacTy8/+If3rEcR2qZtfmzWW
rcTGpT61iaArHexoWu0FmI9qJ6ValIZwwC9ZCGQJg4VtwKnwSqHejO2zFQbkXR4C
dRX2j1opZD6otwv5LT6t1ePqr9c+/wXW2U/5DjuQKZyKNG8wfUBIO0zkzTRFbNwp
vvMCeF7GinBvONyTuqPNun4N1czjHY3n8q4vGvfeA7BR7D5uqRjO9n86aS96Tkb5
i9olAglQdKrGVOUUc82ibYxYOs2xSP2f2nZR3i7X2ccuf6hmp80Gyd9VYKKlqOao
LvXaqDQ4Rx2ujXnE8bnyohG8zk8UJQ==
=AYFE
-----END PGP SIGNATURE-----

--nGNcFUm9tdwcZ7nJ--

