Return-Path: <netdev+bounces-177743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E923A71817
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CFF7A3AD0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CFE1EDA3F;
	Wed, 26 Mar 2025 14:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7161EDA34
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998115; cv=none; b=Ji+FOXkemJvOhddqmYl66SpF02ADg7mrBihjrLdyXfXXARgsCeoGQDy6mnzlekS0NHtpRAyWPBM53giPJtIOUUD9V8SaYhzZRG+4628XJ83t0WDu9R8Tcu+OKMtfDOopQuJl53MN+FHEXzmTwuxfLDaWwA2O4G3h89/V6scTQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998115; c=relaxed/simple;
	bh=7PJvNXeESnkT3I30lLhCqSCwgE7dEULIZmDJ2WTjop0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxLQpQwoyxdclhZAuR+gUXscfOk1KLQW2ZsIoww16Trt6VaOpEh4R5Dvr8cPFeydLQn2IEnIQiDaoKgiqRko8IgkTOwbPJpmDRhNOEvOBjNxllNfKNp3z5oxMGba9lea1H9umcyH68PQt2+cjJiW8lrASZjKBgJEXdKhg2K7DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRQk-00Aa6I-1p;
	Wed, 26 Mar 2025 14:08:30 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRQj-00000004jT1-0mHo;
	Wed, 26 Mar 2025 15:08:29 +0100
Date: Wed, 26 Mar 2025 15:08:29 +0100
From: Ben Hutchings <benh@debian.org>
To: netdev@vger.kernel.org
Cc: 1088739@bugs.debian.org
Subject: [PATCH iproute2 1/2] color: Assume background is dark if unknown
Message-ID: <Z-QKXdq2gFltMvnX@decadent.org.uk>
References: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8W0rGPcvgMVSvTtE"
Content-Disposition: inline
In-Reply-To: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--8W0rGPcvgMVSvTtE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We rely on the COLORFGBG environment variable to tell us whether the
background is dark.  This variable is set by Konsole and rxvt but not
by GNOME Terminal or xterm.  This means we use the wrong set of
colours when GNOME Terminal or xterm is configured with a dark
background.

It appears to me that the dark-background colour palette works better
on a light background than vice versa.  So it is better to assume a
dark background if we cannot find this out from $COLORFGBG.

- Change the initial value of is_dark_bg to 1.
- In set_color_palette(). conditinally set is_dark_bg to 0 with an
  inverted test of the colour.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 lib/color.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index 3c6db08d..88ba9b03 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -72,7 +72,11 @@ static enum color attr_colors_dark[] =3D {
 	C_CLEAR
 };
=20
-static int is_dark_bg;
+/*
+ * Assume dark background until we know otherwise. The dark-background
+ * colours work better on a light background than vice versa.
+ */
+static int is_dark_bg =3D 1;
 static int color_is_enabled;
=20
 static void enable_color(void)
@@ -138,12 +142,12 @@ static void set_color_palette(void)
 	/*
 	 * COLORFGBG environment variable usually contains either two or three
 	 * values separated by semicolons; we want the last value in either case.
-	 * If this value is 0-6 or 8, background is dark.
+	 * If this value is 0-6 or 8, background is dark; otherwise it's light.
 	 */
 	if (p && (p =3D strrchr(p, ';')) !=3D NULL
-		&& ((p[1] >=3D '0' && p[1] <=3D '6') || p[1] =3D=3D '8')
-		&& p[2] =3D=3D '\0')
-		is_dark_bg =3D 1;
+		&& !(((p[1] >=3D '0' && p[1] <=3D '6') || p[1] =3D=3D '8')
+		     && p[2] =3D=3D '\0'))
+		is_dark_bg =3D 0;
 }
=20
 __attribute__((format(printf, 3, 4)))


--8W0rGPcvgMVSvTtE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfkCl0ACgkQ57/I7JWG
EQkKYw/+Msg/KPtIPgvwalgIlBt4O19C4PwDxiIMIK3gq672vi22u28Tfie2nq5P
WY8YyxVEtqcBoIFSgdgXFmn/kLNo7FqCjtBkfyofKrnDSBDXxRtAKCXRGLT1ui3d
S+Ap5Z4fc+lqi8DqfNsPF76RK2MqeRZHh09V42QfgknJLRjHeZ66BZlGTh6EUb/i
sVwdd7Jw8DyoANdy0aQdTBl5C7GjB/iwdowL51H6MTKUSDRdONpRhm7LRnMCsALG
8BojDYKBvIiRzYJjuuHl//47Sb1bXVRFl9ToqQsjIYdUaiEGWkHqemJxf9Txoy+J
uiXySWB8AnmnoMiQk4Tm3T0GWSQ3engPUuCWJ+rmZTAaZ2KVMjWK6X2du9BTzLTa
EuUqUgPtdfMRsGShNDU22QYQZp8mrh30oT6RUga9/9whXnawLCrsClKly1+lKCXQ
covD/Of3dMB1g+4U+5Y2R2duMF1lGog3jlxRk6o3PlvlAHea/xlJlVE31iTSuuY8
mx6FD6Nm9zEUQDzBYiPgbUJVH1D2WVM+8kTd9DcImoFf+6qXe6U9infPQopa9vjY
tKYPG8c2Qkmf6stdAFpQTHfefqYFQM0u6Nad9OBfXZKYijKQbrP80/+ceCWo5JQy
Ne6VDDn0ZA2qLuQH9IlrxhgXQ0tBTjmXzwc48YJUCY7sATCMTzA=
=Jlbb
-----END PGP SIGNATURE-----

--8W0rGPcvgMVSvTtE--

