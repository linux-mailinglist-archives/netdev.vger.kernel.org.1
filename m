Return-Path: <netdev+bounces-171827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE6A4EDF8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946761677FD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F9D24EAB2;
	Tue,  4 Mar 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojo6O3zJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0077102
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118302; cv=none; b=oNOXqal+CtLQxHd02heS7gKHZcPF7Pg0TCsKJtx61Vjntqc4IawrQ7xFSAXEGJemsevSSHC1hWYOFy2HnRhVUOIQh7asJds1W6MmfC0rAOuyGhezUraYr7K+aX1zd6/POnYE02iUVLTROCeapjl9Ht6GAGoyVK7L86jSFvMq8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118302; c=relaxed/simple;
	bh=kOmLrVRTD6rjepKNXxOXkbhJwHdR3Cf9Mdj65qBSkv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulfT5IapDeUcKFbFrg/xgbTddMUA3g+etKb6U61AcdYn1byESZ0iEmUlFTm+eF6i/c4WvaJk8Uca2MR/2zCRVfgNKtVNwQ6+UIU9rsWTjjdaK9Dm2Aba4NQr22awQlmBld3NOmeW7ClXg9JfSgoa23GE9kikgdx9pzQniDZFP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojo6O3zJ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so549675ab.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741118300; x=1741723100; darn=vger.kernel.org;
        h=mime-version:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjNOpVTYIWWgEjNeVJQxfrEly6C5D8YHcEBA4DVHTAQ=;
        b=Ojo6O3zJ5Krjk1Ysk7sTuoIy6DagW2xo1lpCZdHtSrH9FZRwb5SzUOlA9YDN+tyTmx
         od7sasHNwFUBtomxat/qEgjF29eFKmTDjplsFjfu1VGiRQLYuyDDoPrCQrOHw1MZxz6L
         d8/l8R5rDjkmK+nlWnrWTWYPL9iLNdhBRK6H3ogrey+TNZATTNcoyhQ9VGdFLR32AxlW
         0jZD5CDW+VtErNYpLIvOpiXy4dnv8l7jOQUBUtk39gGSVkQCYu95vZC6d0b/PqlOlhHW
         bhKSEtXiOZoEwBaGC4Y2iTyWkh8OTnpA9lCQpvsNfO6OTg9Zc6BEc1zEq2Ms0OBELeOB
         3YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741118300; x=1741723100;
        h=mime-version:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjNOpVTYIWWgEjNeVJQxfrEly6C5D8YHcEBA4DVHTAQ=;
        b=iyCmJTsjEE7lcWIemiW5f5/Yk65B0wAjFHvXf9KK0Qq9t40ZI2OiZxCwKHgq6ploXc
         +VziBRMBdHSiyA23fcdF648pIlIO15FBsSIFMHfCyvnyxzBXFnzEPo4HSuAUyYO5ZTOt
         Xa2afmhGIFYKfNA9IpC8qh8zdKokLnhTwsQV/E+eyluHywylv1EGuGTmh4ba1o11kFaZ
         lPgNLWWx+KjtDkuUlszGHPZbSgrhg1APW0jlSlBMZ3MeVAAgP+xbnVJhymmL5tNqkea3
         yPxi7fy6Rf/PSP5jgvBgdaQi5RLlNlGLnHNVee9mnC8f95cr93ekyDPT2ETlNCb9yDCH
         ZfWw==
X-Gm-Message-State: AOJu0Yz63yex/4T0hiCfnrVdNod5JV6QeHFY+Vfcavbq8GvGQU0D5Xle
	dM5uyh37FE/L8sdU1iC2JFl0E8lHAgq+VvYBttdWiWHD7YezGWEw
X-Gm-Gg: ASbGnct0k4l/aoNGasKhaOIQngy/q1A1Df50Gy5DrkYOxEJpcsOpyJQSPfU+S82o9LV
	wruPfcO8LmRvmQEt/KF4gQtUo8jznSsrxy0Ehk+Kk26i6Pts/Thzy22bh5ElgjwT9642Zi0RJ7z
	NaVbZLSxQ/7S7pUTriTLv62uDz9KyRRumB9Mw+uwyg4tT60vwWwZvVJXpnxP+iJN500z/0WxLtf
	90cjYh33rJMAva5OfMPerotHNZaBE/qkwf6GL8mqB6xgVWgMnRkmioTqji6f08GcjdQIya8oOG1
	qPD1DNBdhq1cgAcnsogGgSL2RVD7tMS4Q4DkEiNcPMZ2/ROOjkCGGDEJGx23QUcoacnmSmPczD+
	fXvnn7Yo4rNZNf8lB1DGZPSiAvcGWo7HV3JXc34Ge
X-Google-Smtp-Source: AGHT+IGFZ0NVfOfELwla6cKT07LQt8v2QYHs1Z0Z98pcEgxaM3KrmES6DSFyaNOtwydoX7WlJbMlUg==
X-Received: by 2002:a05:6e02:1b0a:b0:3d1:4a69:e58f with SMTP id e9e14a558f8ab-3d41db892camr47451955ab.2.1741118300329;
        Tue, 04 Mar 2025 11:58:20 -0800 (PST)
Received: from PU4P216MB1037.KORP216.PROD.OUTLOOK.COM ([2603:1046:c08:1004::5])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f095a3a768sm1546882173.36.2025.03.04.11.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:58:19 -0800 (PST)
From: Vinitha Vijayan <vinithamvijayan723@gmail.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] net: marvell: mvmdio: Add missing function argument name
Thread-Topic: [PATCH] net: marvell: mvmdio: Add missing function argument name
Thread-Index: AUFwQ2hkl1TOfuMgrPj9Q4bGTNADQ7Q59yL6
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 4 Mar 2025 19:58:14 +0000
Message-ID:
	<PU4P216MB103753B46AF6597DAB78A4CBA2C82@PU4P216MB1037.KORP216.PROD.OUTLOOK.COM>
References:
	<CAPSa425Ntd36P3DHMGNhRN_GJ6g1JCMW1t2gMYFppJYSXqetoA@mail.gmail.com>
In-Reply-To:
	<CAPSa425Ntd36P3DHMGNhRN_GJ6g1JCMW1t2gMYFppJYSXqetoA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: multipart/mixed;
	boundary="_004_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_004_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_
Content-Type: multipart/alternative;
	boundary="_000_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_"

--_000_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Fix a coding style issue in mvmdio.c where a function definition argument `=
struct orion_mdio_dev *` was missing an identifier name. This aligns with L=
inux kernel coding standards.

Signed-off-by: Vinitha <vinithamvijayan723@gmail.com<mailto:vinithamvijayan=
723@gmail.com>>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/m=
arvell/mvmdio.c
index 3f4447e68888..91b7881ead03 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -86,7 +86,7 @@ enum orion_mdio_bus_type {
 };

 struct orion_mdio_ops {
-       int (*is_done)(struct orion_mdio_dev *);
+       int (*is_done)(struct orion_mdio_dev *dev);
 };

 /* Wait for the SMI unit to be ready for another operation
--
2.25.1




--_000_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Fix a coding style issue in&nbsp;mvmdio.c where&nbsp;a function&nbsp;defini=
tion argument `struct orion_mdio_dev *` was missing an identifier name. Thi=
s aligns with&nbsp;Linux kernel coding standards.&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Vinitha &lt;<a href=3D"mailto:vinithamvijayan723@gmail.com" =
id=3D"OWAb74ab7fb-9121-df4a-adc6-65b4f27fb757" class=3D"OWAAutoLink">vinith=
amvijayan723@gmail.com</a>&gt;<br>
---<br>
&nbsp;drivers/net/ethernet/marvell/mvmdio.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/m=
arvell/mvmdio.c<br>
index 3f4447e68888..91b7881ead03 100644<br>
--- a/drivers/net/ethernet/marvell/mvmdio.c<br>
+++ b/drivers/net/ethernet/marvell/mvmdio.c<br>
@@ -86,7 +86,7 @@ enum orion_mdio_bus_type {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct orion_mdio_ops {<br>
- &nbsp; &nbsp; &nbsp; int (*is_done)(struct orion_mdio_dev *);<br>
+ &nbsp; &nbsp; &nbsp; int (*is_done)(struct orion_mdio_dev *dev);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/* Wait for the SMI unit to be ready for another operation<br>
--<br>
2.25.1<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_--

--_004_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_
Content-Type: application/octet-stream;
	name="0001-net-marvell-mvmdio-Fix-function-argument-warning.patch"
Content-Description:
	0001-net-marvell-mvmdio-Fix-function-argument-warning.patch
Content-Disposition: attachment;
	filename="0001-net-marvell-mvmdio-Fix-function-argument-warning.patch";
	size=1413; creation-date="Tue, 04 Mar 2025 19:57:37 GMT";
	modification-date="Tue, 04 Mar 2025 19:58:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3YzliZTRkZTA4MmVlNTY3ZWFiYjEzY2U0YzlhYjdmZTU0YmNmNGVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaW5pdGhhIDx2aW5pdGhhbXZpamF5YW43MjNAZ21haWwuY29t
PgpEYXRlOiBTdW4sIDIgTWFyIDIwMjUgMTc6MTA6MTMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBu
ZXQ6IG1hcnZlbGw6IG12bWRpbzogRml4IGZ1bmN0aW9uIGFyZ3VtZW50IHdhcm5pbmcKCkZpeCBj
b2Rpbmcgc3R5bGUgaXNzdWUgaW4gbXZtZGlvLmMgd2hlcmUgYSBmdW5jdGlvbiBkZWZpbml0aW9u
CmFyZ3VtZW50IGBzdHJ1Y3Qgb3Jpb25fbWRpb19kZXYgKmAgd2FzIG1pc3NpbmcgYW4gaWRlbnRp
ZmllciBuYW1lLgoKVGhpcyBwYXRjaCBlbnN1cmVzIGNvbXBsaWFuY2Ugd2l0aCBrZXJuZWwgY29u
ZmlnIHN0YW5kYXJkcyBhbmQKaW1wcm92ZXMgY29kZSByZWFkYWJpbGl0eS4KClNpZ25lZC1vZmYt
Ynk6IFZpbml0aGEgPHZpbml0aGFtdmlqYXlhbjcyM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWFydmVsbC9tdm1kaW8uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvbXZtZGlvLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212bWRp
by5jCmluZGV4IDNmNDQ0N2U2ODg4OC4uOTFiNzg4MWVhZDAzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212bWRpby5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvbXZtZGlvLmMKQEAgLTg2LDcgKzg2LDcgQEAgZW51bSBvcmlvbl9tZGlvX2J1c190
eXBlIHsKIH07CiAKIHN0cnVjdCBvcmlvbl9tZGlvX29wcyB7Ci0JaW50ICgqaXNfZG9uZSkoc3Ry
dWN0IG9yaW9uX21kaW9fZGV2ICopOworCWludCAoKmlzX2RvbmUpKHN0cnVjdCBvcmlvbl9tZGlv
X2RldiAqZGV2KTsKIH07CiAKIC8qIFdhaXQgZm9yIHRoZSBTTUkgdW5pdCB0byBiZSByZWFkeSBm
b3IgYW5vdGhlciBvcGVyYXRpb24KLS0gCjIuMjUuMQoK

--_004_PU4P216MB103753B46AF6597DAB78A4CBA2C82PU4P216MB1037KORP_--

