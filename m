Return-Path: <netdev+bounces-294286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qvEwJEQCH2rHcwAAu9opvQ
	(envelope-from <netdev+bounces-294286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:18:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E219663023E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:18:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="IFeZQ/L3";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294286-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B33F5304A79E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA342F3C07;
	Tue,  2 Jun 2026 16:16:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC01607A4;
	Tue,  2 Jun 2026 16:16:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416980; cv=none; b=G7GDohFOm3mOA0gJy3mGR8gmAFhijJ6DFawZe0zIRgHiHdn0yRq5z/r5rpS4dw1CiJ7rN7gCBeLkvaTb8gJf/HhKKujm3VJkeponX+vDjuHE5kajkMpFfKU7KXV4GHwu9vYzlGxcy6li1PD3H2crLm1GZfbz4jrk+E1UIAM8iMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416980; c=relaxed/simple;
	bh=Zu28aI7QA8c6XLewqF5HcvoYkMd8dDjd+V7RmT4+WNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tl240QuVf7+qXqzVH/Bwm2HfAJuqjrfti9mXinPv2WN6CK/2gkAGWYyxbZTE7YzdNOtk2iO1SEK31mjTxTOZdrByJbP5n8kSNZnYzInq+WdaOjfRBGW7ktyoNxmhIej05xOSpLAnDW2m0TuncetjZVGGBJ4HBfv9/BDtSKXodoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFeZQ/L3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C55C1F00893;
	Tue,  2 Jun 2026 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416979;
	bh=vXrLIao4808epUWzIw/fCI05aS9DvD4NHtE5cmik49M=;
	h=Date:From:To:Cc:Subject;
	b=IFeZQ/L3KL17o+bKvxJYpDBU8c9PZxSpaJRfybIkSsWWPbPe2yTk1F0oGzrVRBWPI
	 Q5bLeeX8ZwVpmlStiiRtCQQg8MDNkxxJ98ipo4Ec+t345wIDzfKkqJWTBQx113A9oL
	 tH+86RKX6Ws+iqoJodqaFijt9/JBkqYmTCmbpLdM+chdo1cGs+3pj5ecce5TiPgYfF
	 fhpGF3eoLmcqe0VQlmjWjWo5PF+O7XyTP8wnPOzrrJY2DDEA3oqBnVULw77ZaIRVl4
	 m1ApSsI+8aWRlCQCUEmD4WniCQ6vbYsH562Hb1/KNTOnxV8KeAPK+Fjnkk1sQvnokh
	 v4hsLyI3ggwsg==
Date: Tue, 2 Jun 2026 17:16:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the security tree
Message-ID: <ah8BzqSmZO40xYhS@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHRHOxUMa9VnXSEq"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-294286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:bboscaccy@linux.microsoft.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E219663023E


--cHRHOxUMa9VnXSEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the security tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many argume=
nts to function call, expected 1, have 3
  212 |                         if (map->ops->map_get_hash(map, SHA256_DIGE=
ST_SIZE, hash))
      |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~=
~~~~~~~~~~~~~
/tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro 'SHA=
256_DIGEST_SIZE'
   14 | #define SHA256_DIGEST_SIZE      32
      |                                 ^


Caused by commit

  c62310df81899 (lsm: introduce the Hornet LSM)

interacting with

  c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operation)

=66rom the bpf-next tree.  I have reverted the latter commit, the new LSM
means that the assumption in the changelog that there is only one caller
isn't true and it seems like the most straightforward approach.

--cHRHOxUMa9VnXSEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmofAc0ACgkQJNaLcl1U
h9DM0Af/Vew4ezfteietydbHLqu5EfXmd+RzY2AvXvF7+Ngy8LvzxU07GbFvw8DC
08nQHq968QL+uaxkYqXr7qYBlUJpyTGZ+5tI1T+hVPndNwTaeJV1RLf/CSV1QVcH
xB/uBey64RAewTIiMXYGcON0gkmW7ewjS3msjycJkHweBh+x6WedNPgodYChCp0C
hhmK8yzRAkpTx0CwMucfzYAvFf1psIAVaN9Oa3zDCA9cn6Sd73EezJ18ANVweUbb
zXRGf059fEuas/JxNSiI/+Bm5AtVIGeslbKMrlIhAtRs6CcSNWNDfgbTwqAnByaI
GxP3sAufey09/HIBqe3ityIpEKjE8Q==
=9gGU
-----END PGP SIGNATURE-----

--cHRHOxUMa9VnXSEq--

