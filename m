Return-Path: <netdev+bounces-103878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C8909E97
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4231F2110D
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2D1B960;
	Sun, 16 Jun 2024 16:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4F8F5E;
	Sun, 16 Jun 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555730; cv=none; b=PBxZIq7fjH21cWB5Fsv93wobILOMpSHXtrt3Zh3ZIvqEZAw2A6Vr66VeOLkTM688Yr0ValiNARzXX+Ri7wvrkHjdxuT/6mPcft9rOQpOX//FiG4WISWcne1WIIu85IwpVgtBDrMq2jVj3KSldKQljH/GeOgsp+QqCaT8R6UdVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555730; c=relaxed/simple;
	bh=LtyzEud6XukUJzRqIcU3lmJM2u9ieaxJGV/4XZY1MmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNHl2HK7FlCpaw7267TA5Sl9gkIt6A4gcDC5ftDkdNTgRXwHPCcqurlFzfVN9GEFv56jblhR5m5bts3x7DZuzgc5HuUtSviwlBFHJF4EELhR7AI83TLkNhhWO/w5PUA3RwoIwA1jTfjeSyDUZida3BGLdscBGlKEmvgpAnrLlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from [IPV6:2001:19f0:6c01:100::2] (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 3B4DD1F917;
	Sun, 16 Jun 2024 18:35:26 +0200 (CEST)
Message-ID: <910c3734-193f-4292-8f99-634aa4d1ea85@universe-factory.net>
Date: Sun, 16 Jun 2024 18:35:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
Content-Language: en-US-large
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
 <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>
 <0dcdf71c-8b47-4490-bee2-8551c75f19e0@lunn.ch>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <0dcdf71c-8b47-4490-bee2-8551c75f19e0@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UyhI3O1usPAqqkchgRSb9Nr6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UyhI3O1usPAqqkchgRSb9Nr6
Content-Type: multipart/mixed; boundary="------------hZ1qDW6fGN65Y6uVeaWrWTrh";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Message-ID: <910c3734-193f-4292-8f99-634aa4d1ea85@universe-factory.net>
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
 <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>
 <0dcdf71c-8b47-4490-bee2-8551c75f19e0@lunn.ch>
In-Reply-To: <0dcdf71c-8b47-4490-bee2-8551c75f19e0@lunn.ch>

--------------hZ1qDW6fGN65Y6uVeaWrWTrh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYvMDYvMjAyNCAxNzozNSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBBcyBmYXIgYXMg
SSBjYW4gdGVsbCwgdGhlIHJ1bGVzIGFyZToNCj4+DQo+PiAtIG5vbi1pc29sYXRlZCBwb3J0
cyBjYW4gY29tbXVuaWNhdGUgd2l0aCBldmVyeSBwb3J0DQo+PiAtIGlzb2xhdGVkIHBvcnRz
IGNhbid0IGNvbW11bmljYXRlIHdpdGggb3RoZXIgaXNvbGF0ZWQgcG9ydHMNCj4+IC0gY29t
bXVuaWNhdGlvbiBpcyBzeW1tZXRyaWMNCj4gDQo+IEl0IGlzIGEgYml0IG1vcmUgc3VidGxl
IHRoYW4gdGhhdC4NCj4gDQo+IEJ5IGRlZmF1bHQsIGFsbCBwb3J0cyBzaG91bGQgYmUgaXNv
bGF0ZWQuIFRoZXkgY2FuIGV4Y2hhbmdlIHBhY2tldHMNCj4gd2l0aCB0aGUgQ1BVIHBvcnQs
IGJ1dCBub3RoaW5nIGVsc2UuIFRoaXMgZ29lcyBiYWNrIHRvIHRoZSBtb2RlbCBvZg0KPiBz
d2l0Y2hlcyBqdXN0IGxvb2sgbGlrZSBhIGJ1bmNoIG9mIG5ldGRldiBpbnRlcmZhY2VzLiBC
eSBkZWZhdWx0LA0KPiBsaW51eCBuZXRkZXYgaW50ZXJmYWNlcyBhcmUgc3RhbmRhbG9uZS4g
WW91IG5lZWQgdG8gYWRkIGEgYnJpZGdlDQo+IGJlZm9yZSBwYWNrZXRzIGNhbiBmbG93IGJl
dHdlZW4gcG9ydHMuDQo+IA0KPiBPbmNlIHlvdSBhZGQgYSBicmlkZ2UsIHBvcnRzIHdpdGhp
biB0aGF0IGJyaWRnZSBjYW4gZXhjaGFuZ2UNCj4gcGFja2V0cy4gSG93ZXZlciwgdGhlcmUg
Y2FuIGJlIG11bHRpcGxlIGJyaWRnZXMuIFNvIGEgcG9ydCBuZWVkcyB0byBiZQ0KPiBpc29s
YXRlZCBmcm9tIHBvcnRzIGluIGFub3RoZXIgYnJpZGdlLCBidXQgbm9uLWlzb2xhdGVkIHRv
IHBvcnRzDQo+IHdpdGhpbiB0aGUgc2FtZSBicmlkZ2UuDQo+IA0KPiAgICAgICAgIEFuZHJl
dw0KDQpSaWdodCwgSSB3YXMgdGFsa2luZyBhYm91dCBwb3J0cyBpbiB0aGUgc2FtZSBicmlk
Z2UgKHdoaWNoIGlzIGFscmVhZHkgDQpoYW5kbGVkIGFzIGV4cGVjdGVkIGJ5IHRoZSBtdDc1
MzAgZHJpdmVyLCBqdXN0IHRoZSBvcHRpb24gdG8gc2V0IHRoZSANCmlzb2xhdGlvbiBmbGFn
IGZvciBpbmRpdmlkdWFsIGJyaWRnZSBwb3J0cyB3YXMgdW5zdXBwb3J0ZWQpLg0KDQpNYXR0
aGlhcw0K

--------------hZ1qDW6fGN65Y6uVeaWrWTrh--

--------------UyhI3O1usPAqqkchgRSb9Nr6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmZvFE0FAwAAAAAACgkQFu8/ZMsgHZxr
PRAAq4uuOC1kIbLciQTW+bo3pDJzWRrsdOn+4Em9oaTLPPXtEStEsoDPFU3m5HKUuiG/PAA82kmw
TgSlIHRab4P2+gdnFgKpRY27AY9g/LZsIatOnA9VIjqdMq4FExlsuEZi61kzCRUB6ibgfJf66lRL
6SMjs6Fg0B2bmcUmUkTJ2ZDx4u6BC350Qute0r0eB6406K/BTrDeRXVx0dI8H2zBB4V824xWLQBq
nqXNesSlS6RVvjA5Ku6AkOi+Z5ZPeacOTwmLmzxGGrRzBR5zc6nPtdefqwsW3G3LuMcr6sqjd6KN
FCfMEjJRyzurxWeDbGwOeYZp7ux4jOZMzgMHuNVWbRiym8iiTkglq3bNI7e+EoWW31M9HilWq8oK
TGKw/d1Oomb8f/qRTEYGijQEpFbmKBBsdYCqxoFN5WR+GuacxJTb7wzOhkECdLseIxJa7PoPfm1j
nsZq3yq+v8i8RKmkIHw99H8GgHjS0gCqmQrSR9GiVgNZRUwTYVpd+te1hBTwAN5sRTwEBNniuIzx
YvlAjBodxhf1m/4pW2gbRgPbcePmAd2oI1vOVorP7Q0Es0xoSOT0VQd7Lm2mmF4Natibx9yMXnvv
1fjiJE9mP5X0Fvaif/bSCYWasisCfN4B8TmtJYgYjksGH+Adt+PryZPA/Q9HI4A/yD/UfiW1bp5k
4VE=
=981Z
-----END PGP SIGNATURE-----

--------------UyhI3O1usPAqqkchgRSb9Nr6--

