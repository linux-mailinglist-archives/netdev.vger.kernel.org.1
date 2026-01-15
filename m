Return-Path: <netdev+bounces-250323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8ED28B44
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31F2300286B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE13242AD;
	Thu, 15 Jan 2026 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="ogTMcWUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBtf92Zc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613A31D371
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512238; cv=none; b=sTzaPXBtL7S5RjAfInULesqRM6YHjffq/uzcmjLNcQ4eFMFjPG+6mJbpHYVFO2ZX8fL3U++X0eY6BdYS3Ek69GYUqZaQuNpKco0hBUbJ5vwSSErri3hOPeQR31UUtmPrCjI0Fb3eUJDqxk24lnFtJAljqH/v7TdK/0kGS53+Yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512238; c=relaxed/simple;
	bh=GhtJfPF+X1By75ADqTaaI3ZQFO1Ij0CLtH7sBdT436M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Knuw3tK7GJ4c/YC97kkawDDB6ZvHajLf8RLqjP8Xss2QlMOirUYcYR5Pt6Jw3TQBdPbHQDlHgIRUV3Fngv9PLbCMAHaTUdxSxAXv7xCQvWElkXq4xwwhNT1cYsdKHnqqL1g0t16h8tC1ErvElfF5K8OaJTnwH0j6nXUvkInlgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=ogTMcWUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBtf92Zc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B334EC028C;
	Thu, 15 Jan 2026 16:23:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 16:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1768512235; x=1768598635; bh=+b3dzSGR4e1+ZHZRw+BKR
	mP68ylKconjAcDWqFCZfM8=; b=ogTMcWUN8DrsjRgEtB95D0f+1tRgqkKIup+1N
	ACLDGJJO7RnDL+j5XPbeXt3NbBuassb/G2MWBB46KfJLLZNEZPR2fwstSbb7g6k1
	EHnhL78NiFs4ZJQY2hPE9pzrJ6plDmRqwa33d1n84mKORoNHl0i0tvQGrD7cM1om
	QACaFkVnRj5TcE8JuS3XfKNWYKSen18ftOXo1hmlzMQEYbfM97rXAfN6IrD0weFJ
	C0NXLWWhBL39DXsdCRZelOszjQoqL2Y1nmItU3rPKG5+jocGPsvluxw4DlKZ0fQE
	6lIzOz7hpUnTT5CVg8hQGUT/lt8nRNhJN/lyscMOQ7mDvDr6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768512235; x=
	1768598635; bh=+b3dzSGR4e1+ZHZRw+BKRmP68ylKconjAcDWqFCZfM8=; b=c
	Btf92ZcQDTD3OLQiKgsLeOG2kx80U6rU+Gif/gFQWSGmXly+FB85d7ZhFDxys0mA
	yajs0R8ei/rPVb+wspPvYR0UyZX5y/h5Bev8Ogl3fZvFMiPI+7KrAyyiPmGrw3kf
	BdIsNWm+wBQuzhcDy0vkPZ7BdVXa/I4TrqoJS4H7UTT2gCISTNCUfqPQpzfnvpcP
	RRUtmuRg635PUPuPwIM5MPby9gjdgIUMa4hoziND0Ri2mKmQdMAXfJPxzdRxX24l
	OOxN7dY0c1Qk+E89PRXljNrvDB1Npuc7kbvfMRWM2jx6U042llsgto44wyzznHoM
	xVZvVs+eHdYGyHtFuyQiw==
X-ME-Sender: <xms:61ppaQZxWcI_BjboBB8IJCbs-Kr1uuKiOGS28bDbxm6myJDq7AIj6Q>
    <xme:61ppaRYjvFmFcRT6roC7Zx7Zdo4atOrc8gKRKf4yh1SWbe2ArH_xtLJV_ljSm4S7v
    4yr9ukmdbvKyKq90ANeKueJ_2_Gtb3uZVAzMnKnH3s2ko3jzFw9n7U>
X-ME-Received: <xmr:61ppaYmqMd3-MWaGzcmwwzmM5fv3LHL00pX3gESvu6DnGRf9nqOk6iwLeXJx1m0AQeSO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:61ppaVz7gvlTRxm1Ww_Xf3AGpQnVjFZiUHuQ2Y6toWZRHV4MigRTSA>
    <xmx:61ppaeMrMFXZCOE5wth1rmn1ey5t9fNpUP9R1wnLAZI15DhjMSXLoQ>
    <xmx:61ppaRSNzHnqMoWqGaLJXx9_j-gpFAw3gO4GFVWcZzq7dSeRUTgKJg>
    <xmx:61ppaUa83OThlpWCNzEh_wVLjbqwXh3bFE_q8MwC_W6Pre2M6mQ-sQ>
    <xmx:61ppaWPEuzx7X6M_dzT6gt49G6NMW9ooY9FzQKEFxh9Uj54fYV4frBxZ>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 16:23:54 -0500 (EST)
Date: Thu, 15 Jan 2026 21:23:51 +0000
From: Michel Lind <michel@michel-slm.name>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] tools/net/ynl: Makefile's install target now installs
 ynltool
Message-ID: <aWla562jr4q6cotH@mbp-m3-fedora.vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GWLqCfI0WXqL9HqS"
Content-Disposition: inline


--GWLqCfI0WXqL9HqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This tool is built by default, but was not being installed by default
when running `make install`. Fix this; it installs to $(prefix)/bin by
default unless bindir is overridden.

Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 tools/net/ynl/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index c2f3e8b3f2ac..bf3f8b16170d 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -4,6 +4,7 @@ include ../../scripts/Makefile.arch
=20
 INSTALL	?=3D install
 prefix  ?=3D /usr
+bindir  ?=3D $(prefix)/bin
 ifeq ($(LP64), 1)
   libdir_relative =3D lib64
 else
@@ -41,13 +42,16 @@ clean distclean:
 	rm -rf pyynl.egg-info
 	rm -rf build
=20
-install: libynl.a lib/*.h
+install: libynl.a lib/*.h ynltool
 	@echo -e "\tINSTALL libynl.a"
 	@$(INSTALL) -d $(DESTDIR)$(libdir)
 	@$(INSTALL) -m 0644 libynl.a $(DESTDIR)$(libdir)/libynl.a
 	@echo -e "\tINSTALL libynl headers"
 	@$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
 	@$(INSTALL) -m 0644 lib/*.h $(DESTDIR)$(includedir)/ynl/
+	@echo -e "\tINSTALL ynltool"
+	@$(INSTALL) -d $(DESTDIR)$(bindir)
+	@$(INSTALL) -m 0755 ynltool/ynltool $(DESTDIR)$(bindir)/
 	@echo -e "\tINSTALL pyynl"
 	@pip install --prefix=3D$(DESTDIR)$(prefix) .
 	@make -C generated install
--=20
2.52.0


--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README

--GWLqCfI0WXqL9HqS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCaWla5wAKCRCLIp0vfMwE
8lqyAQDYDitPvQICcwYo1ikmboWd5idXHGIqhlol3fk2W3X3GQEA1S9j5Ak2ZYVZ
gV9Ta7xOk8avNEyMU9Nl5Q86Js71rQg=
=dmoK
-----END PGP SIGNATURE-----

--GWLqCfI0WXqL9HqS--

