Return-Path: <netdev+bounces-142432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A339BF16F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B71C2220F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693681DF738;
	Wed,  6 Nov 2024 15:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178731D07BA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906411; cv=none; b=qWFEybejunHIjqNxp0iNhtWUTk29GydnGNNb+0U1sBpe+4RPwwdM6K+iGDR0lFTDiATLYyz86c4azpi4Us5g2NQwaB4+XzyFj27u7tDsb4pfJH47jDfzkdWF8mQg2IAmwGJJM9aHu8PR9IvsXANIHQcg9ksIS+YDE3Xf/XPv7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906411; c=relaxed/simple;
	bh=kzx6wDmY9vWD+irk4/0NdnEJhF49gEd1yxERBUNRSOU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QHU6TACPjELX2VnBqnEcp5+9j4pxLBRaPWYC6ecd5ptNI5IU6SH4yjAswtIbIZtqRJP/ps8G0IR5NYOYX2YcXhAZTnhFfDK1D+dePVzKogeXszMH1UGlIj+IDzzNSNoIkVw+ltnBD80k6vMrbxEZxpEPs51oA6X0acB0hPIsxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1t8hYV-000Ay6-GU; Wed, 06 Nov 2024 16:02:47 +0100
Received: from [2a01:4f8:c2c:e87c::1] (helo=[IPV6:2003:f6:af08:8838:f6a8:dff:fe1e:4c1d])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1t8hYV-0004DP-1m;
	Wed, 06 Nov 2024 16:02:47 +0100
Message-ID: <a7452b36-11cd-41b8-a82a-9ec00ab01866@hetzner-cloud.de>
Date: Wed, 6 Nov 2024 16:02:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bnxt_en: XDP_REDIRECT DMA unmap warnings (bnxt_tx_int_xdp)
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org
References: <bd85c535-e823-4597-b064-c34b3346b131@hetzner-cloud.de>
Content-Language: en-US
Autocrypt: addr=tobias.boehm@hetzner-cloud.de; keydata=
 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
 p0ms75naziM=
Organization: Hetzner Cloud GmbH
In-Reply-To: <bd85c535-e823-4597-b064-c34b3346b131@hetzner-cloud.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------98v0Lifn0vMPwQhg1EULnjGV"
X-Authenticated-Sender: tobias.boehm@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27450/Wed Nov  6 10:40:07 2024)

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------98v0Lifn0vMPwQhg1EULnjGV
Content-Type: multipart/mixed; boundary="------------9jSV9i69a32HRbVTiEm3gyD8";
 protected-headers="v1"
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org
Message-ID: <a7452b36-11cd-41b8-a82a-9ec00ab01866@hetzner-cloud.de>
Subject: Re: bnxt_en: XDP_REDIRECT DMA unmap warnings (bnxt_tx_int_xdp)
References: <bd85c535-e823-4597-b064-c34b3346b131@hetzner-cloud.de>
In-Reply-To: <bd85c535-e823-4597-b064-c34b3346b131@hetzner-cloud.de>

--------------9jSV9i69a32HRbVTiEm3gyD8
Content-Type: multipart/mixed; boundary="------------yv1gPa8oe0itiEF0GfbS2Uii"

--------------yv1gPa8oe0itiEF0GfbS2Uii
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgbWFuYWdlZCB0byBmaW5kIGEgc29tZXdoYXQgc2ltcGxlIHdheSB0byByZXBy
b2R1Y2UgdGhlIHdhcm5pbmdzLg0KDQpJbiBteSBvcmlnaW5hbCBtYWlsIEkgZm9yZ290IHRv
IG1lbnRpb24gdGhhdCB0aGUgaXNzdWUgd2FzIG9ic2VydmVkIHdpdGggDQphIHRhcCBkZXZp
Y2UgdGhhdCBiZWxvbmdzIHRvIGEgUUVNVSBWTS4gSXQgd2FzIHJlcHJvZHVjaWJsZSB3aXRo
IHZpcnRpbyANCih3aXRoIGFuZCB3aXRob3V0IHZob3N0LW5ldCkgYW5kIGUxMDAwIGRyaXZl
ci4NCg0KVG8gc2ltcGxpZnkgdGhlIHNldHVwIEkgcmVwbGFjZWQgUUVNVSB3aXRoIGEgdmVy
eSBzaW1wbGUgZWNobyBwcm9ncmFtIA0KdGhhdCBzZW5kcyBwYWNrZXRzIG9uIGEgdGFwIGRl
dmljZS4gRmlyc3QsIEkganVzdCB1c2VkIHNpbXBsZSANCnN5bmNocm9ub3VzIElPLCBidXQg
Y291bGRuJ3QgcmVwcm9kdWNlIHRoZSBpc3N1ZS4gV2hlbiBJIHN3aXRjaGVkIHRvIA0KYXN5
bmNocm9ub3VzIElPIGJ5IHVzaW5nIGlvX3VyaW5nIEkgY291bGQgcmVwcm9kdWNlIHRoZSBp
c3N1ZSANCmltbWVkaWF0ZWx5LiBRRU1VIHNlZW1zIHRvIHVzZSBhaW8gZm9yIHRoZSB0YXAg
ZGV2aWNlcy4NCg0KTm8gb3RoZXIgdHJhZmZpYyBvbiB0aGUgYm54dF9lbiBpbnRlcmZhY2Ug
d2FzIG5lZWRlZCB0byByZXByb2R1Y2UgdGhlIA0KaXNzdWUuIEluc3RlYWQsIHRoZSB1cGRh
dGVkIHJlcXVpcmVtZW50cyBmb3IgcmVwcm9kdWNpbmcgdGhlIGlzc3VlIGFyZToNCi0gYXN5
bmNocm9ub3VzIElPIGlzIHVzZWQgdG8gd3JpdGUgdG8gdGFwIGRldmljZSBmaWxlIGRlc2Ny
aXB0b3INCi0gcGFja2V0cyBhcmUgbG9uZ2VyIHRoYW4gMTI4IGJ5dGUNCi0gWERQX1JFRElS
RUNUIGZyb20gdGFwIGludGVyZmFjZSB0byBibnh0X2VuIGludGVyZmFjZQ0KDQpBIGRldGFp
bGVkIHN0ZXAgYnkgc3RlcCBndWlkZSBmb3IgcmVwcm9kdWNpbmcgdGhlIGlzc3VlIGFuZCB0
aGUgc2ltcGxlIA0KdGFwIGVjaG8gcHJvZ3JhbSBjYW4gYmUgZm91bmQgaW4gYSBnaXRodWIg
cmVwbzoNCmh0dHBzOi8vZ2l0aHViLmNvbS9oZXR6bmVyY2xvdWQvYm54dF9lbl94ZHBfcmVk
aXJlY3RfcmVwcm9kdWNlci90cmVlL21haW4vdHgtZG1hLXVubWFwLWlzc3VlI2hvdy10by1y
ZXByb2R1Y2UNCg0KVGhlIGlzc3VlIHdhcyByZXByb2R1Y2VkIHdpdGggNi4xMSwgNi44IGFu
ZCA2LjYgaW4tdHJlZSBkcml2ZXIgYW5kIGFsc28gDQp3aXRoIGxhdGVzdCBibnh0X2VuIG91
dC1vZi10cmVlIGRyaXZlciBwcm92aWRlZCBieSB0aGUgdmVuZG9yLg0KDQpSZWdhcmRzLCBU
b2JpYXMNCg==
--------------yv1gPa8oe0itiEF0GfbS2Uii
Content-Type: application/pgp-keys; name="OpenPGP_0xAB80D76A44F7A4AA.asc"
Content-Disposition: attachment; filename="OpenPGP_0xAB80D76A44F7A4AA.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
GXg0EUTt3/hgg4+Cp0ms75naziM=3D
=3D7oC3
-----END PGP PUBLIC KEY BLOCK-----

--------------yv1gPa8oe0itiEF0GfbS2Uii--

--------------9jSV9i69a32HRbVTiEm3gyD8--

--------------98v0Lifn0vMPwQhg1EULnjGV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEEvXs8kNGp4Ny9+HQq4DXakT3pKoFAmcrhRYFAwAAAAAACgkQq4DXakT3pKri
EA//ZAP53PxvdD15VU/8jwtuYVHcENXR2zSrZLzEhgL1G1TRRPMFqb6w/PEI/iy9xaRevVqmCDwE
INNumJwqZ3ak7GhaZjes0HL9G7u0NcOeP14OHkwRVys3AbbzthzuxsltbzTq54UYFdchFWY31L3p
t1V5/1PHZ9YDRcJKOfZAEQXlE11RU4jPzWW7fl51vzsQZCToC9/Ol/nVByjOgSgFAbigecYD5pyt
Zj6xoOjAVDP/I0zNZeL4Hc6UICFlE+steLCs577aasb13DkJemD/7dvFsIxqYGtk1gRNQ9BkLj5U
egmWh5p/+TtwIkGK6XpMXFj0BeXKFzDWhcK8NCml/KtZil4I15Kpfyf3JxHFH3UgiEeZQKAcwLJW
TlzRxH/grquzuA1Gd4Yfq0VZGELGZ7uT0flUXOdy90xuT/aSA20kYFSd8A89EfzXF8xt6CvSuzH3
E9LQ8+A5Wfxi78MEE8/7twZJ0/Sq2kAkzykm1qswvizgWHzrmis1Gz5KdE+tvARuBe+Xnv88CJ3o
TP30FjRziK54MSBUbkV8kXB3Pd7BpyY+j4LjGdavPRTkeewQtBTbpfOosrz8YBYIZkEun5hLlAz/
FuigC+7tJRefwxgImmk2Ge8nC7ScV+HG/CdXE0rb3cHF9rjuNBybWBXuxyLvtyxw3SwN4XKD07t7
fM0=
=a4zn
-----END PGP SIGNATURE-----

--------------98v0Lifn0vMPwQhg1EULnjGV--

