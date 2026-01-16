Return-Path: <netdev+bounces-250653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A4D38843
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC5173076911
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051023064AF;
	Fri, 16 Jan 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="jXQgYtjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTmsRuCS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5662F0C7A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598524; cv=none; b=gDnWpsfbFeb08AA/DHCZEGDJ/QtoyDWs4OnPc3QTl75qGd8RpB4+g3Ake21ixdrDZFBDD/YmSAMVDN2FHxvvuffuTdOjerJcz70AbVF/xTtTBxqTaG9kjbrzhLX2UMKP86WrWAPB6A/AqmhHTEW1XK+2ckl7TCi4kJW5ityAiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598524; c=relaxed/simple;
	bh=1b0DUyMcIwt5VMNpI8wzwDfR9HmffwDMsdxP8I1gU9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DAFkq6kitFBJCFDlL8lISU027fJ9Ywri5CuVRsr1/4VF5dbEUiDxcFcNhGxfcQwVYWjh1cfOtnsuXGE0u4aB63xHjg+IRA9zTKvDNJFxPa7f7ftgTx/yIOethY7LtbqMLfFEQeTnIaHfFqqv2SMRBEPpGyya0UWxZYRYKfYr37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=jXQgYtjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OTmsRuCS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B596EC00B3;
	Fri, 16 Jan 2026 16:22:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 16 Jan 2026 16:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1768598522; x=1768684922; bh=0Gil7pyKt6EjdVDcICYVe
	Xc5in3hpwpDLvzCXt6Zd+c=; b=jXQgYtjLlCfEC/NJCPFBXzddKztbGWyvWEZhh
	M4+xoOQrjPx6Xwf0ESFJ4s6aJJPV+lMbkmqAVo8EKTNGf55b8xyeUrPclTTE7lT5
	JLtWtl5Zg75fOqVFjxEPn4wEZF0u3r26jjjTq7RAZi1bzfF0MtAPWIv4wyuC8PwC
	dDTHsifmVYLCkLf5xSpznZFUvezEj0+PyYrvr8m0Lsgb6nH568RS5NKRnavTGqxS
	XJOewMOXU4jj+MNkNtksFZf/ZTPpqkfnKV05Z1ZPrN/b/1kOczJEYrekYDp0OKZI
	vxAktD+CWeBHR2/gr+w1UdB3FvdiwmibIVFGsUr0ATvSfwE6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768598522; x=
	1768684922; bh=0Gil7pyKt6EjdVDcICYVeXc5in3hpwpDLvzCXt6Zd+c=; b=O
	TmsRuCSqJqH65C7IDzmMRgWXEWpybNwbumkEQ89KU8UnH8QYfay+4JlfbCISPiG2
	DsChemUW6z55l89zhFuMioMkzqOiL2J9s9R2As9FvbeWlHYhYoObtn0gOMeA6s7x
	XNUjPNwsM7rxMYb5IW5SmbjH39XG15St9loaDEnmJPKsygIVi4s8JcU1mX3pnZae
	CClHQ1cuLnXwTFZGmOEf9DB35dAKO+H89ze975Kh1/oQ/IlyhbGNk06UMVSmGxSO
	PeVWvi6wnRRPQBqe45ss3P0ixSCF1IAjlG1NrYiG3V1mCrxpclWa5EGf5Z97TlVt
	miq2M2ZrUvVB7AVxuvfTQ==
X-ME-Sender: <xms:-qtqaQYJXKOmckb5nrTNW7MBjOJIym_dy6ebaA9HNgHJ6RvY4GUpZw>
    <xme:-qtqaRbbZpz_PQOC8eQc1JxdKC5in7Zk01-7E41uKjBMZyXFflopxkfYYaaq3xKK7
    Ttar96fY7bRMLiXzm_SXih1RMdRnX3neHbwBNji98VbUlD16Uo23EU>
X-ME-Received: <xmr:-qtqaYkCMkG__6AolyecURFjlfE30eLmkbor1vptn1rX1KWV2gtS8mgnHsbYUc7IExs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderredttd
    dvnecuhfhrohhmpefoihgthhgvlhcunfhinhguuceomhhitghhvghlsehmihgthhgvlhdq
    shhlmhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvleejhfeggfekvdevfedtgeeihf
    duvefgvdejheethfegfeeltdetjefgveevveenucffohhmrghinhepkhgvhihogihiuggv
    rdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhvghlsehmihgthhgvlhdqshhl
    mhdrnhgrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-qtqaVxzuPxMgFjNFIZdxXEqYkV7OSw3vF3HLGraIaEY6jcSBLBU7A>
    <xmx:-qtqaeNDxFw6BrnggbMZFMJUntCtuMvvz5z5X4CCvdviMLovJtEovA>
    <xmx:-qtqaRTFauHpyC3ZO1pgiR8E-2Ron3otpC7c8MbttOGasjeOUuy4Ow>
    <xmx:-qtqaUaUiskOwEy4fEKRsJKI0jmGEzob3C9V2-iynlALQ52T4ZrssA>
    <xmx:-qtqaWOcNQXcFbJp0E9AVyTeOPGy3uIuzi3G0WPGnQQSmV1KX5Oj8hT4>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 16:22:01 -0500 (EST)
Date: Fri, 16 Jan 2026 21:21:58 +0000
From: Michel Lind <michel@michel-slm.name>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2] tools/net/ynl: Makefile's install target now installs
 ynltool
Message-ID: <aWqr9gUT4hWZwwcI@mbp-m3-fedora.vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lei4rDzwh6RiqklW"
Content-Disposition: inline


--lei4rDzwh6RiqklW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This tool is built by default, but was not being installed by default
when running `make install`. Fix this by calling ynltool's install
target.

Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 tools/net/ynl/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index c2f3e8b3f2ac..9b692f368be7 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -41,7 +41,7 @@ clean distclean:
 	rm -rf pyynl.egg-info
 	rm -rf build
=20
-install: libynl.a lib/*.h
+install: libynl.a lib/*.h ynltool
 	@echo -e "\tINSTALL libynl.a"
 	@$(INSTALL) -d $(DESTDIR)$(libdir)
 	@$(INSTALL) -m 0644 libynl.a $(DESTDIR)$(libdir)/libynl.a
@@ -51,6 +51,7 @@ install: libynl.a lib/*.h
 	@echo -e "\tINSTALL pyynl"
 	@pip install --prefix=3D$(DESTDIR)$(prefix) .
 	@make -C generated install
+	@make -C ynltool install
=20
 run_tests:
 	@$(MAKE) -C tests run_tests
--=20
2.52.0


--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README

--lei4rDzwh6RiqklW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCaWqr9gAKCRCLIp0vfMwE
8lKJAP9Dhu+KRVS9K9c9NVbrhd2ZscrqAip5HuAZ8rjPuHaD2AD+IQ07TcXtfj6j
6ViZdD2+X2HW9Ej4DmyCbv8xMoxhPgs=
=n4Te
-----END PGP SIGNATURE-----

--lei4rDzwh6RiqklW--

