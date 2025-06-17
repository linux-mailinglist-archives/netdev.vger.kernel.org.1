Return-Path: <netdev+bounces-198521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269FADC8F9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DA3A173D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEA291166;
	Tue, 17 Jun 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwbBDPBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBE2D12FF;
	Tue, 17 Jun 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157919; cv=none; b=RKxLdk0l+f19xG9sraWG1S0ITZ0fjZetoh/w6OKAFD67758xFHXdjMT0oOn6MNTpzBgQq87gJw6sNoT+9mIbSa/AnPo+AIyn5nfkTugPiWsew2jU1qhzdwHAdCgpeamCOjFJyWC4LruwkZLA4QAnR1m5xCRJ+W8xMuKL0S3L+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157919; c=relaxed/simple;
	bh=cla92jvm1Cwuozx7mWtYx8vbWTDoyAeepTnaUhwDRgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hU5vzYyU1bnGFJkY2+O7pwKEbzsDhaT/hy9AibSB6hvB+d4l86thbfQdA0OwOsAqATBEv14mWVTo+0xu01YAawmWAPXQ9YY4lBr9fcEnFF6/5fOMwie0FZ9Vd4zk6bk+8iy/c7cWzIzZpAdw1clUZmhbJdkM+hTfQVrkXiAvZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwbBDPBv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553644b8f56so5721695e87.1;
        Tue, 17 Jun 2025 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750157916; x=1750762716; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f00vxfR5azRN5MgFG0OPmk9gTlImdYRyrAJQJVS5rWU=;
        b=JwbBDPBvwQw1fehdhKNLEkzhw+w+EyaAqO5NKXCdwJuDb9TQnqQzWWFGO427HgRiSv
         D8CqnuYk6cbXUdfMGLFkom37XtW5o98O06K/wwYkxKcGNWwDqDL5+1RBGABWYUZ98fp2
         7Bps1xM3VRIEZ6vqufOUyFJR5qkeydLR63tvMeQv0jCpWptOFqODWpqWIqDByj8q9QVS
         fNMuLQMzMUTrOfESIoN5JX23fNhS/Ec8MiJcG7/sJ+cfmYROEAhlXvSpMlG9gv/Up4Aj
         iLE2Qht4Y9iayxDomwLiIsDz4LMTsku5cCFjCuX8r9bo0cUWHtoVgCqb8NjGHw7ygOuK
         dkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750157916; x=1750762716;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f00vxfR5azRN5MgFG0OPmk9gTlImdYRyrAJQJVS5rWU=;
        b=lSqGI9R1opQqwskF1T8taGHjmbtrWkEh70JkvCHCNPLjaSbkpeGj6eest2dYzDB6vS
         q3qV0ojpP6MkuiCsexzOJm2mGHyUUjYesdttWAaVAPEHI/exMaqVl0sBZLDij5LrC/du
         OwmRjF1isqHl5z2Hod8lK6nWmvfpzyT8PUjs1hjtXRYLLnFJuH6pdm6YEz7QUnOnQx6G
         GCFv+m71rdHP4V6djtQ+OM60y5Rrx/2qmuIpk14qT9SGhgcR7V2/jkieXmyJEXzuLtYD
         WWG84/6zWWhvOjajrP56FjP4T96PuNtY18BpuTFC/p896d17uoO5ZmdMHsjqfs4AXd0K
         rNwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ4spOT3oAH85+CTywMoiPTy07n7fMfeaKUXJajyWJseyBhnRjw8pj+rdWJP4tUj2ySOZ9KaG@vger.kernel.org, AJvYcCWenYqzV1Y2A255zjt4osRp/dNpI42TlWzZ8uiHO6jLkBZk3HmOb0/mbpHqisU4JwFqpw9guRSIIZ6yrqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSF+bcJK5dasq4tLj1OrFJ5v/TfiFuSLWFFSgMjcP8HedFb4dN
	eRey00Ty7/V5vFH4L2+wesqwxehEe/P/o4XKAglGUSirOcVg3JJTpGCiIqu7919E
X-Gm-Gg: ASbGncs2OtZ9pg7GOiPYhfS7myUO9TLoiIf9yurYWST+X47OQrcFEsJzX7XZlb2kRUt
	PiPSiGEVyyqTC7/0Ce/2Zhsg1Z71xx5lN5ZWFqGi9hnW6L8q03O+NOV4fQlQglp9NxOsXIdBCyJ
	5zlo+YZlSSIMMRPwKhgEefxJW4y0zlgK7jmLtVX1P0vgw9bGSuXyTMxcmVEuGeghHmyigcvdHMr
	uncp6mbBgYtO2sfIvCwyQHk3OBEGK2Z+pUvvynISI4z8Sb2lWImmtzis8Swln2ZMwf8Z93vy+do
	wabMF3NH7l46bkp0fWSU3DAfehfVUSkH/CDD2sKWwMPcRE1ADSR6gV0DmzJdqTZBMiMw
X-Google-Smtp-Source: AGHT+IHofxWWVvpe6E5VEDM9g0yBG7JR22j85Z37XXgBQiD12VLlckAL9siOePTr1A6QC0vf/NacVQ==
X-Received: by 2002:a05:6512:1595:b0:553:3621:efd5 with SMTP id 2adb3069b0e04-553b6e8b41amr3421825e87.16.1750157915362;
        Tue, 17 Jun 2025 03:58:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1a9fbesm1868999e87.139.2025.06.17.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:58:34 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:58:26 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net-next: gianfar: Use device_get_named_child_node_count()
Message-ID: <22ded703f447ecda728ec6d03e6ec5e7ae68019f.1750157720.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TP0eRBLzEhJAcDHu"
Content-Disposition: inline


--TP0eRBLzEhJAcDHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We can avoid open-coding the loop construct which counts firmware child
nodes with a specific name by using the newly added
device_get_named_child_node_count().

The gianfar driver has such open-coded loop. Replace it with the
device_get_child_node_count_named().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Previously sent as part of the BD79124 ADC series:
https://lore.kernel.org/all/95b6015cd5f6fcce535982118543d47504ed609f.174222=
5817.git.mazziesaccount@gmail.com/

All dependencies should be in net-next now.

Compile tested only!

 drivers/net/ethernet/freescale/gianfar.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/etherne=
t/freescale/gianfar.c
index bcbcad613512..7c0f049f0938 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -97,6 +97,7 @@
 #include <linux/phy_fixed.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/property.h>
=20
 #include "gianfar.h"
=20
@@ -571,18 +572,6 @@ static int gfar_parse_group(struct device_node *np,
 	return 0;
 }
=20
-static int gfar_of_group_count(struct device_node *np)
-{
-	struct device_node *child;
-	int num =3D 0;
-
-	for_each_available_child_of_node(np, child)
-		if (of_node_name_eq(child, "queue-group"))
-			num++;
-
-	return num;
-}
-
 /* Reads the controller's registers to determine what interface
  * connects it to the PHY.
  */
@@ -654,8 +643,10 @@ static int gfar_of_init(struct platform_device *ofdev,=
 struct net_device **pdev)
 		num_rx_qs =3D 1;
 	} else { /* MQ_MG_MODE */
 		/* get the actual number of supported groups */
-		unsigned int num_grps =3D gfar_of_group_count(np);
+		unsigned int num_grps;
=20
+		num_grps =3D device_get_named_child_node_count(&ofdev->dev,
+							     "queue-group");
 		if (num_grps =3D=3D 0 || num_grps > MAXGROUPS) {
 			dev_err(&ofdev->dev, "Invalid # of int groups(%d)\n",
 				num_grps);

base-commit: 3b5b1c428260152e47c9584bc176f358b87ca82d
--=20
2.49.0


--TP0eRBLzEhJAcDHu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmhRSk8ACgkQeFA3/03a
ocUSBwgAxW6dsFT4FnxaY1olOjpeXMrBbzKFFzSRrYGHeidCb4evKlLdnZpsHcZy
2pluMcpn4VAAdvPxg36PyNnLZ4mrHiNXMRJ9OC6m1H85hjsM5MlVUmDCB9dbfiXA
yQlEbALYPW8tDdbAYfB9muGh3K3+zH+0ejCIahbNQmavgQ7kZ6KzAYafSnysbOKI
xiC34w0mDvWPQ4oNIgbnIW0lUDwWa759+1bwrj/qlWDrCB8+yKAZva2PrdDW2Kpi
amFFzY3dyJZS1RymJG8G8rDKlmFGLhwlLd6mVf477vglzK0IbikksB/8pHVJvudY
Go1dHD8uu/oQ+i3NAoeyZ0Bj0Q/3Lw==
=DV6h
-----END PGP SIGNATURE-----

--TP0eRBLzEhJAcDHu--

