Return-Path: <netdev+bounces-199050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F10DADEC2C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCDE400E1B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D72DFF2F;
	Wed, 18 Jun 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XukT4AiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE80F9CB;
	Wed, 18 Jun 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249335; cv=none; b=tGOTD6XRISn67KFbGsRAwMvIK26p1LPP/TTI2maA7n/Ro7UzOd2SjCZ1l1h3of6Q0LMc/aDmvrGBo6hjO61tfGMGdwELE6i6kV4rvPunrNc22VhL0+5ukFmSMXQs0STG0W+ZFcvfhdYJsCa4BfLb+XVWyezKC1d18yCQnfgVDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249335; c=relaxed/simple;
	bh=AkOJGHFfJ0D1Hi2CzC1gFV13rZ2OfQfKVC5qrPuOvQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nI4xBgn3673Vk85FdrZ+qoXyEebngQTKrAVWWA5sddUuHRTsvq0rQXxOEZVDBYyeQTAsRb1cxSv540lujmoOS5y3g6LqNNjhQwC+AUBxi9473ivv/oh0XiU3jCr2B1QXYWI8R8pZAGfQZjWsKR1r8dsMHjZypomXJUDH0+PVTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XukT4AiT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5533303070cso6551632e87.2;
        Wed, 18 Jun 2025 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750249332; x=1750854132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YX5uE2UWP9Ptw7Kk9zAitIAFib0/p57/vRRfmjUetJ4=;
        b=XukT4AiT05nir0bLDw3EghBZSLTkWIZ/AKeT3C6O6ApqXCFxcLSGU0Dbk0aCCDoPG3
         A5sUrQWges20sQLHTX0qCCq+K6VEukhy7fvSuGJ48reVFGRtsbqujRszcNtZm4lZREPF
         t1lhX05PYrqgaG088HeTJnGyZGRc/UQP1CGuzt+ZZijuqwIDeySd7hQ5rC6oE9po1rtJ
         EOMYOLZjhytn9cK9W75Yx7S45exIdt+MviauQRVlYHa7jgzGRQeekGR96gk77TtnI+wr
         uu/v6sd3n4G8P6jm6DGGC6imG/EnKhjh0jrHof6PvRikoTzgSJPVEg0VHtn4fDcIjQHd
         Gneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249332; x=1750854132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX5uE2UWP9Ptw7Kk9zAitIAFib0/p57/vRRfmjUetJ4=;
        b=Ib/mwyZ416XS/HrZZ4MM8swOQiyv3zDiOjZWp3431ymB7pgv1RIhfp/scJ5CV5wyst
         OUChHvURJuKq1Sm6x7e09Z8HFraBa/MqNvm3DLOCTUPovh3D32wR7us21Y3GGZjNNKPl
         95LL1qfidZo4PvyNIcUqFe7dBEFryABxHQM8CiVpJmWnL0EDjoDBNSmiuFNSKqVjXi/I
         SN/dEcufAn/xTGPX0p1ZUbr5BTWJnPBW3ZWawkd/mDW4fPkyWyVYhNPd5GxoAGdSEbG9
         nz5SBkg19AXdAhdN8JxsKDcf/91Mm91K6T+RJjhdKINWSWe36seEaePwhR7JHyfCF/hs
         emQA==
X-Forwarded-Encrypted: i=1; AJvYcCUQxbV0Koza8LUQW/1ATa5bWpyb4MyTOHmBRrO19zOf8IUS7yCmXu+Wd8InvBszb6HrM7mY4OAq@vger.kernel.org, AJvYcCWdWOrVKI7ke3bUicIA/YeRDsuDUrJEQ+CMCWD3NQfhGuQcGDngMJ13jxpg6Eggwy2QeeFw1yoNYhDvI/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAn6QhJIjIwGvPjBUhUPSwj8KGv8w3tbS48MBkHDU+0N3ko+3
	VkBmQsT3g6tHEn5y9VWaHzywrscfVThb68A8qAzZtDFvloDETE1HP2CP
X-Gm-Gg: ASbGncsQ4q/Se4SkYp/3KR7fymQYLJLDiB12kxwx1BVQrVcCedxI0GJLBEcqS9Efn3k
	vPpkGlh6PT/vM1kwyNwOSQt6UPXKlEAmpyrcCRta4lRPhmq2E4C3a/n8PV+W0RNnfy7/Ul5AgHQ
	w/NxLDktwAiHWm2xeKtf73OoFgU2W8WWxJW7zBcnKeLa2hjEPapQnucT0kCWv2d2GiMC+N+qdCc
	uV1rcffRD9iVmA8EqMfHNrlXmT1WzrbkIktegOjX2GA+O+Knlgprex4PM2uavzYD7vzDWwIcZlF
	T4m6s/E1HVX6UEqYXfpR0nY2HTwe6m53yZwUcPDCvJHDyJC/8pQ9voezPhKFkz0EmKoQi8S2aDp
	t9Bs=
X-Google-Smtp-Source: AGHT+IGJ1vZmmV2E3HMazrFPTb/BZIZ9ZVcruq8NwutkVwOcMvDD2EOlPnoGnZTqlnhGwGI9Cs9rNA==
X-Received: by 2002:a05:6512:15a4:b0:553:3178:2928 with SMTP id 2adb3069b0e04-553b6e8834bmr4675292e87.16.1750249331405;
        Wed, 18 Jun 2025 05:22:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1c1d1csm2235445e87.160.2025.06.18.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:22:10 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:22:02 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: gianfar: Use
 device_get_named_child_node_count()
Message-ID: <3a33988fc042588cb00a0bfc5ad64e749cb0eb1f.1750248902.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OEbY+A2xp9C7j9WX"
Content-Disposition: inline


--OEbY+A2xp9C7j9WX
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
---
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
--=20
2.49.0


--OEbY+A2xp9C7j9WX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmhSr2YACgkQeFA3/03a
ocWk4wf8DXM53+9i/agAaQTn7ykbmvYReY/KPywU0raYz6xuZdXPAl5YlMMQPIWj
1X1DyJzDuWWYx4CDUyQNJS035LVkIIpX3FVko1sQbeCpU+lB7yK1WiwRkF2Sy8ay
xQfnAqRwtEmV/gPNGEgLHyFKxEKx4XnNhJBwkgnNi6asJYE3+fm/y2O6FQDI67gP
ZjOoNOIWB8qJiUt7vjsPJSbyabHA0TwZfA0AMyIBJ12+tHkcYxh9/rYsDlOBDGAM
MdF4ontQmgp8UlFd/4P5dMR78y6VtH/9WYxwM0FXEDGVTynUv8HaNO0Baz+XJcaM
b3wyS6az21Q41ZqejPvsqtjPafu6lQ==
=7mu5
-----END PGP SIGNATURE-----

--OEbY+A2xp9C7j9WX--

