Return-Path: <netdev+bounces-176313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F761A69B3C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DA219C10AF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D21215171;
	Wed, 19 Mar 2025 21:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31722135C1
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421072; cv=none; b=YZ6Wy9EYQpNbeu8Ax+7BwEVBcoc/CgMXb4QBalCueKqKEQ2Sdbw1StGLeorV0v0ZHl5q1hMja+DuBRiTRwvMJuVVzQ0vgxX/4M6P10tWtSa4TQaELdQJsNzuybygnsLbiJToV913TehxK4lM28bb1SwKNDzCpzZ/aBQ7qBokoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421072; c=relaxed/simple;
	bh=tzIoAGCH1Y1W7YZr8XV1x/E0ijK83jlaKqCdA8ijs98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NNYiC1tMgUAPJvxR3dYIItHlaqMKCM0evrKsrRjUCsR5kSl0OWpvV9RTVN2o36M8PuDdS6eN4fPLkTYaFSL4AJX/MwNjfY1QaDK5UbqSzb6vdEZbLtDqJZueGfcExmIcDhTc5inXu5FFf6NC/Fynf57fSnlWk1vpVvD7ysUl6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tv1JW-009oef-1X;
	Wed, 19 Mar 2025 21:51:02 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tv1JV-00000002bKa-0ivC;
	Wed, 19 Mar 2025 22:51:01 +0100
Date: Wed, 19 Mar 2025 22:51:01 +0100
From: Ben Hutchings <benh@debian.org>
To: netdev@vger.kernel.org
Cc: 1088739@bugs.debian.org
Subject: [PATCH iproute2 1/2] color: Introduce and use default_color_opt()
 function
Message-ID: <Z9s8RSix3wtE8QPf@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IGA8HJnxP42oWw4V"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--IGA8HJnxP42oWw4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As a preparatory step for supporting the NO_COLOR environment
variable, replace the direct use of CONF_COLOR with a
default_color_opt() function which initially returns CONF_COLOR.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 bridge/bridge.c | 2 +-
 include/color.h | 1 +
 ip/ip.c         | 2 +-
 lib/color.c     | 5 +++++
 tc/tc.c         | 2 +-
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index f8b5646a..d993ba19 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -103,7 +103,7 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
-	int color =3D CONF_COLOR;
+	int color =3D default_color_opt();
=20
 	while (argc > 1) {
 		const char *opt =3D argv[1];
diff --git a/include/color.h b/include/color.h
index 17ec56f3..b543c267 100644
--- a/include/color.h
+++ b/include/color.h
@@ -20,6 +20,7 @@ enum color_opt {
 	COLOR_OPT_ALWAYS =3D 2
 };
=20
+int default_color_opt(void);
 bool check_enable_color(int color, int json);
 bool matches_color(const char *arg, int *val);
 int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
diff --git a/ip/ip.c b/ip/ip.c
index c7151fbd..e4b71bde 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -166,7 +166,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file =3D NULL;
 	char *basename;
-	int color =3D CONF_COLOR;
+	int color =3D default_color_opt();
=20
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/lib/color.c b/lib/color.c
index cd0f9f75..5c4cc329 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -81,6 +81,11 @@ static void enable_color(void)
 	set_color_palette();
 }
=20
+int default_color_opt(void)
+{
+	return CONF_COLOR;
+}
+
 bool check_enable_color(int color, int json)
 {
 	if (json || color =3D=3D COLOR_OPT_NEVER)
diff --git a/tc/tc.c b/tc/tc.c
index beb88111..0fc658c8 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -254,7 +254,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file =3D NULL;
-	int color =3D CONF_COLOR;
+	int color =3D default_color_opt();
 	int ret;
=20
 	while (argc > 1) {


--IGA8HJnxP42oWw4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfbPEAACgkQ57/I7JWG
EQkkrBAAoo9d7QqJWKzLHUY7MW2dbqH6PMkQn9RxVhL+kwcRxJFOw6aSCB/wwz/T
66s9PCEmST0fJakN4NPhNllkhGe/g71RRLs5k9WroRNPuKLOQKkDflyYnxDerWbm
iKy9CZAtyqZ6BueYCqKYZ9QyWwAvxnc3juLzd21te1b71ZS+jwRr56fdnITjIf9f
1YaMIOpBsrjEy5MRtoQ3HztCMRxdZXPs6Xkv4+6hhPulz06RUUW4TjTT/unPhxzm
3xDkHNeFbkkJ++B/a3uXxY6PyH03DewaHNpIGtIwCYDmndzsZFX1vdGkGI8LvhD8
KkMl++sEzw8TzqgjFs4aBTwrwdZ+q814M5l6NzMyCj2VHRNpMladmRbVDs8piAmF
3drtbWOvCRYj+ukbjzGG69FSyt+LCM6JTmV2W+LQz0U+7AwkShCpmclKEMOPut+t
lUtg8AZnYHfsADtvHr0Tc21McJ9WRLClSU4YTCohL/8usBsPB3m9wRWUyGoi2KR2
4GxiVJ35eiyAI4eD76WaCj6m9HQVDWNa5SXA+15l0cw6qloIStrl1kIwK0SBoHJO
3Na1c5P4YlPGzjoc/tfJjxtUUlR29DyRnGQ0s7RmsILiuiwXEuPmk3aBpQUQCtwz
Gar3FkWl/92/YzKzgPOjqI5QQMJQj1byoiMTmgJhvc+1roTe6QY=
=UrRu
-----END PGP SIGNATURE-----

--IGA8HJnxP42oWw4V--

