Return-Path: <netdev+bounces-250501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB7D30059
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C08503051B71
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7735FF54;
	Fri, 16 Jan 2026 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="g5ioAoJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gt2lp2BR"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D16352FB6
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561120; cv=none; b=QMpDql/GMZuSBoYjeALyq+BOn2ENRPE0isWrcBWuKTrmTpt9lMO3QwYESaldsdL6z+qG1h+JKu/0evghr0kndGQKVVoUWr/mKqgyG1c+N/Dk9gUvDdjzvDKxX0itV1yIpVnKekhtaCbI0aQUfFUTETy1gNS5Pq8rgWNAhf+V2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561120; c=relaxed/simple;
	bh=uk2K7HPKwm9f++kEUuW5D35L9ydnNRQ/XR1Ih0spZvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVXdyt1kXRUjVI1cUkyW6+mEQMFZICfILnrcxb+BfFn9JkC80N8b77leS774ErpMyWwJ/TiOx/wDlDZqdAx2hQ/ORKJUR7tO6EsUI7r082eHyQ+FUP9Pb26yXf53jODHjpt9F5dT5buOdW+AJdvCjnCjxZqxfR/Q2egATOLxn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=g5ioAoJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gt2lp2BR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEF3714000F2;
	Fri, 16 Jan 2026 05:58:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 16 Jan 2026 05:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768561115; x=
	1768647515; bh=okSnIBi/OO3OXgQza7//prP/+YXryA+1RP7aRoo8rfQ=; b=g
	5ioAoJYKdDpHndN+eUB8nPe4IkQLMdc0Q2GolVqMeNprQuKfKfXbbKTKjBUK1qxw
	X7QruYllpCiyQRXiwHda2wekqVu8IEanV7xzaNtPAafTG6HW5VztJwJY02fy+6Ga
	Wj50m9/Xc5clFhTV2QvN8ahAqGjwPwkoEctcO3xWhb/4Yn/TbwZRB7m3RMdyRryd
	8Q5pHRce7mhST1KgTGiNnLhGcq1gfdwUc4goKTYmjzLmyRqJzCQ5mpHHA1acSkmi
	vyWv0s0kPOjvHOF8HQ1ebD1baY0DrdiCwT6nYFi24YCJLwSR0HJtFDY3tfFrp82Y
	puw8PvGSWFeLE2cMd2cWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768561115; x=1768647515; bh=okSnIBi/OO3OXgQza7//prP/+YXryA+1RP7
	aRoo8rfQ=; b=Gt2lp2BRg9fNAaQzCHtjs+2sryDjM7LFhErDsci+m6plwqOnvD5
	48KOZAOUjWVlUqitJEa6cLGSbgqcMd4Ufp+UDKBAV/bhCzlQ3gdTjJ8KIFcy4ZwQ
	QshnEqyeGHTWcSVAyp1BOVNx57aow8Z3FMps7cCQJbjOAelAy33kw1xIij58SMJP
	tqEKOKYWtzf06yUjLOCA+yrQyB6c3YDUaGbFQfDj0muiKU8KNPLGCnqnfctW6OdK
	ATMv6TuSdM5hrpOt5LOKC0Lkrl6UrY23gfMUxVo/RuIoqv7u9EclOOyYYQ6z7U2n
	14S1QrUc7CXCOH3Ldv3GsyWKVS+2/9+5C1Q==
X-ME-Sender: <xms:2xlqaYRYV3H2UHvclmU1A11y9ulTIQV_BkDR2Xyl6Rz5RtjQE52C0A>
    <xme:2xlqabzn-qWxvBQH5QY9gFZxN8h-G3Orqh16LMliJjmf2-g-1wEYrF51ju4hUwVlT
    VHn6qh6kxb85qV2qirBLrVH7AvxgtyU6DRdMZkZc3YnlqFMAJNLwBA>
X-ME-Received: <xmr:2xlqaTeJoPU-hyA7hFVFW647UXbDA_Pq7ljjmOt2XVBlz_LMqu_L_wMqznqM4CqK9v0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfevffgjfhgtfgggsehgtderre
    dtreejnecuhfhrohhmpefoihgthhgvlhcunfhinhguuceomhhitghhvghlsehmihgthhgv
    lhdqshhlmhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeelkeejvdeugfetheeuhfdule
    ffveeilefgueevveehfffhtdekjeeufedttdffgfenucffohhmrghinhepkhgvhihogihi
    uggvrdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhvghlsehmihgthhgvlhdq
    shhlmhdrnhgrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2xlqaXIfMCnMXgc6gVYwtX58lCEpBbbtBCWCGJmgZQ_tQQ-YnOnjLA>
    <xmx:2xlqaUFNnIiOCZaUi9WT-IPE5SVf6OXuCLmW8eCTVHOYzopcqYUdNA>
    <xmx:2xlqaRo2ecu8tPZgmkkDJeg9ljea1-UV1-DKolprfznrEi6tWHwnEQ>
    <xmx:2xlqadQXxNA2BeKkVMOF5usK3P6UwXNwo7jPbng0J1vxJmgqmbFKlQ>
    <xmx:2xlqafH-7f0q3KJq1wzkpmpjml4RJ7-2wi6OihaGa_rgjwUs2jGpa5SL>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 05:58:35 -0500 (EST)
Message-ID: <b117b2ad83ac73a69216b237b076b9811bd98a03.camel@michel-slm.name>
Subject: Re: [PATCH net] tools/net/ynl: Makefile's install target now
 installs ynltool
From: Michel Lind <michel@michel-slm.name>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 16 Jan 2026 10:58:33 +0000
In-Reply-To: <aWla562jr4q6cotH@mbp-m3-fedora.vm>
References: <aWla562jr4q6cotH@mbp-m3-fedora.vm>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Odo4mzd5RtoaxCC97/DV"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Odo4mzd5RtoaxCC97/DV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-15 at 21:23 +0000, Michel Lind wrote:
> This tool is built by default, but was not being installed by default
> when running `make install`. Fix this; it installs to $(prefix)/bin
> by
> default unless bindir is overridden.
>=20
Jakub pointed out ynltool has its own Makefile already, and it turns
out it even has an `install` target. Per the process documentation I'll
wait until 24 hours have passed, and then post a v2 that just delegates
to this; it works fine when tested on a local build for CentOS
Hyperscale.

Best regards,

--=20
=C2=A0_o) Michel Lind
_( ) https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
     README:    https://fedoraproject.org/wiki/User:Salimma#README

--=-Odo4mzd5RtoaxCC97/DV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCaWoZ2QAKCRCLIp0vfMwE
8sLhAP4mTev4PJK5BPcij16LrQ5rRvPA9ioAOWOT/1IzPJt1hAEA/pc6MuJTyPPX
2CFO0vPaU+OpwE1kWCqgQzbvEWbvTw0=
=3LdS
-----END PGP SIGNATURE-----

--=-Odo4mzd5RtoaxCC97/DV--

