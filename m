Return-Path: <netdev+bounces-294046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE78Mtp8HmrnjgkAu9opvQ
	(envelope-from <netdev+bounces-294046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F503629277
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99CA83015E1C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB41392C39;
	Tue,  2 Jun 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h26xc12x"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DB3A5E9F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382667; cv=none; b=tLd2BjKOBCfTJUXBuiwU64Jkzfc/+tEVxIb+DyjE1dw1TwhKCSOoGduVpyPe3cfOxZCyqTuVanseQhhkwVpUyUCSVCt0bp25nQf/nKNn3O51oNuvXmwDtyslh1XqG480FYLpKqbPLMtWFmejWV7iC+ho8c1h3ULc4szBn6suy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382667; c=relaxed/simple;
	bh=P5QFLVHqsWJ9RIqgAFo/fgucqYkyOvzv6HwxyGy2U48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPXuzoKhuO0kkSdrnTCzEg0EmJG7kLrCNzJm3vIP+JbksWX+dVvPzCOMPGlHwWfgdWWgPexRwT1WsLpP/Jc68a7WAbR3VbwspqnjL0yTdHDrUi73Ok1L/ymS08TodRgT6y3QT0HTzN3U3YTp53tW0Fnzuc4Ym1oZNd61JaU4nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=h26xc12x; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780382662;
	bh=FNKXtTaJGTxhCOEiv4Zix5ECFGGeYyG8sItBjPmcfAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h26xc12xfAXU7f+HlOxRZKFUA7bRgvbk0Xb31mCNopsIbDK/3/sBf/BhcDuiRJiFT
	 GrBAcID7WnUpu29C+kx8ZEYBZV7MSV90tfHI2vI/o6ScjAAseRDN+55iuV+TTs/DpX
	 SU01wnNL2zsyHstMY7/apeXpHyxFAoxrLSRJ1d0wY+OIIVcc39Fub3K3qOWkF8kC4u
	 cHKZVy020gR+N3kU9xjsDzk3YZ3GK7zHFHa6EUl1s279niAG7fgeXeFEFArzsECGSq
	 8G3N7E2/Ug8Z+kbHaAaSuOrbp1dIzp4BKsVtWh7LsEEgFwcHn+Hc2GyQg2V6FDysZq
	 EZLdMqOMvdC8w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gV1X66J3zz4wLK; Tue, 02 Jun 2026 16:44:22 +1000 (AEST)
Date: Tue, 2 Jun 2026 16:44:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
	yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: IPv6 address insertion order (was Re: [PATCH net v2] Revert "ipv6:
 preserve insertion order for same-scope addresses")
Message-ID: <ah57wxGjL7JBORR1@zatzit>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SYmMoP7Mi2VNEMht"
Content-Disposition: inline
In-Reply-To: <20260529134045.56330243@elisabeth>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[dropbear.id.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294046-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F503629277
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--SYmMoP7Mi2VNEMht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I get the impression there's a rough consensus that the best we can do
now is revert this change (already done), and make a new patch which
changes the insertion order to the "correct" one conditional on a new
flag.

Stefano has enough other fires to fight, so I'm taking a look at
implementing that.  Some initial thoughts, that I'm soliciting
feedback on:

1) I'm assuming the idea here is to add the new flag to nlmsg_flags in
   nlmsghdr

ifa_flags in ifaddrmsg would be the other candidate, but it looks like
it's encoding properties of the address itself, not about the action
of inserting it.  Plus all its bits are allocated, anyway.

2) Could we re-use NLM_F_APPEND?

The short description of this existing flag in linux/uapi/netlink.h is
"Add to end of list" which sounds like the right thing.  Looking
closer, however, it seems like what is' used for so far is things
where the entity added with the NEW<whatever> operation is itself a
list, and NLM_F_APPEND causes it to be added to rather than replaced.
It's not used for addresses at present, AFAICT the list of addresses
is a semantic level above the address entity itself.

So maybe re-using it for the thing I tentatively called
NLM_F_INSERT_LAST would be confusing?

On the other hand, it's not used for addresses at the moment, so
AFAICT there's nothing actually preventing us reusing it for this
purpose. That would save a bit - we only have 2 general and 4 NEW
specific bits left, by the looks of it.

3) What other things might need changing to take advantage of the
   kernel change

My innitial testing suggests that unknown nlmsg_flags bits are
currently ignored by the kernel.  That means that tools for which the
new behviour is desirable, but not essential may be able to avoid
probing - they can set the bit and hope.  I think that includes
passt/pasta and also iproute's save/restore functionality.

That said, things which might want updating:
 - iproute2 to use this for save/restore
 - netlink(7) man page to detail the new flag / new flag semantics
 - passt/pasta
 - network-manager, here we require the exact behaviour be maintained,
   so it would have to attempt the new flag, then apply the existing
   workaround (reversing the order itself) if that fails.  Maybe more
   trouble that it's worth?

Any others people can think of?

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--SYmMoP7Mi2VNEMht
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmoee7UACgkQzQJF27ox
2GeRIw//Tra3A/IZQ3+OWYtggCStJow1oPkMgg2ONZV3KgdkgqQBU8QinGYBNetv
IQSLDQ9XHcqjYKuZ71ofnwxSLMMBSsLcvlNzOjpwPSfVbV3dwv1mEEV2dDG8WHPi
eNvShHdJDlu1axfO5xhxaKD93zotfTUebAi8tKZedzLnsnyob3z9SxrVFswcgN78
FQy5h5Bc4CsJvsODNTExXbbY4ofpl8rshoO6L9r+EgVtJrjtgnL2KD/Vm0fAUupF
4KWfoLqc3w9RlOogZUrsWooglilPFGbl/yWLWYFvgIrcLVuv7Kr9D0LTMO8YCcr7
Adu9/7qDZbavhrtKClpmUEHAAkqK+IhoY1FGXi79A3bsv9gCImi1xhNLzO9A9cTk
EOdoE52PDKQuL6m57FuYpKnTM901zF/tdPgKKCxXuQykWruMTU8v4KhSGNiVLCS5
waFQIODHUbDHhFasLZ5B42nn/gdp0IyDj3cBc3k9cpIKY9nm91ZCotwywMeoz/go
opbdXwGcXxgpLmRkBWosVTOvWo1PfIyrAGo8co7NatVs2HoktbuCQAYNzhr0YAkW
yW9xvTlSadUBfR0m5ef2PVQAlQKTA8x/fxO+zfu75C1kIgYHz4Ex9H7wj+ftDX2G
zUb+tlxginRg7aTdQ0LoHVH7K9Pk4h0sKbCPVt5hX70gJZ96/Lc=
=rYTu
-----END PGP SIGNATURE-----

--SYmMoP7Mi2VNEMht--

