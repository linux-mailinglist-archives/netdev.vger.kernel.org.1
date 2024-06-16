Return-Path: <netdev+bounces-103837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17470909C9D
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 10:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D42814DC
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AA60882;
	Sun, 16 Jun 2024 08:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E01EB36;
	Sun, 16 Jun 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718527189; cv=none; b=sxBknyy7Nq7LZ3lUeOh/YW5CghWQlNFi0buAaMsFOQvYj40J9buw4MIWaKG9fM7E4655thUOX8skog1VmEqxKjHU0jkyy9u2qQLfvh6LU7c+BzExsM61ixAESEFd5TOGKDfh1URG2KUN+CLtkoELFrFtudNCKkFoEJZgMwrAfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718527189; c=relaxed/simple;
	bh=uDBddo1b5H69sGPh5EQvuL2MUMwf3JQFG9tpHZX+bkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB4SVQCCn7jHVQzOv8v/B5cH4YAXa0GMR9Gqy6ENuhTHwvdLvYm61pcQhfaDOwaX+9WtQO5gsp+w/FZt88sZvFnxfvOYoPq+lG33skadM/nC9EwJSll4HCL/s7qhPPx1VjI5rRgbRMdy+tfUkrDzPrWPegybGyjS5pck2+rfwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from [IPV6:2001:19f0:6c01:100::2] (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id E14321F917;
	Sun, 16 Jun 2024 10:39:38 +0200 (CEST)
Message-ID: <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>
Date: Sun, 16 Jun 2024 10:39:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
Content-Language: en-US-large
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 xsFNBFLNIUUBEADtyPGKZY/BVjqAp68oV5xpY557+KDgXN4jDrdtANDDMjIDakbXAD1A1zqX
 LUREvXMsKA/vacGF2I4/0kwsQhNeOzhGPsBa8y785WFQjxq4LsBJpC4QfDvcheIl4BeKoHzf
 UYDp4hgPBrKcaRRoBODMwp1FZmJxhRVtiQ2m6piemksF1Wpx+6wZlcw4YhQdEnw7QZByYYgA
 Bv7ZoxSQZzyeR/Py0G5/zg9ABLcTF56UWq+ZkiLEMg/5K5hzUKLYC4h/xNV58mNHBho0k/D4
 jPmCjXy7bouDzKZjnu+CIsMoW9RjGH393GNCc+F3Xuo35g3L4lZ89AdNhZ0zeMLJCTx5uYOQ
 N5YZP2eHW2PlVZpwtDOR0zWoy1c0q6DniYtn0HGStVLuP+MQxuRe2RloJE7fDRfz7/OfOU6m
 BVkRyMCCPwWYXyEs2y8m4akXDvBCPTNMMEPRIy3qcAN4HnOrmnc24qfQzYp9ajFt1YrXMqQy
 SQgcTzuVYkYVnEMFBhN6P2EKoKU+6Mee01UFb7Ww8atiqG3U0oxsXbOIVLrrno6JONdYeAvy
 YuZbAxJivU3/RkGLSygZV53EUCfyoNldDuUL7Gujtn/R2/CsBPM+RH8oOVuh3od2Frf0PP8p
 9yYoa2RD7PfX4WXdNfYv0OWgFgpz0leup9xhoUNE9RknpbLlUwARAQABzTJNYXR0aGlhcyBT
 Y2hpZmZlciA8bXNjaGlmZmVyQHVuaXZlcnNlLWZhY3RvcnkubmV0PsLBlwQTAQoAQQIbAwUL
 CQgHAwUVCgkICwUWAwIBAAIeAQIXgAIZARYhBGZk572mtmmIHsUudRbvP2TLIB2cBQJk6wEu
 BQkV4EbpAAoJEBbvP2TLIB2cjTQQAOE1NZ9T2CCWLPwENeAgWCi+mTrwzz2iZFYm9kZYe13f
 ZmeGad30u6B57RW24w3hp6uFY764XTHo8J0pLveYSg9zxgrMZp1elWp4Pnmyw7tosJuxmb7V
 cE4zeW74TZmP653Li12OZGVZ863VDpDN5cTTdm/t1pOp0cnZlLHo3OtGemxdOFd0MSauYAqF
 htvM3TbWdnGonnMblKX8cSRwW5FUzOwJ+KuF7KsYxQCAEQkWwd1gmevPISpXpvIDicyPgK5w
 ToS3MKayMKf0iFIFCzRwLZAzVhVY987yPaUPwyY6pzozNYla4OTLnXQaXQlLeiP9EgMF2UXT
 kI345ZnCcyG66uY3eZv1taRWt+IfguPQo8eVdAZDWVh9LZ3nCw/gobfKFr+tk0c1bqCm0N3m
 pBWB+d+EmBVaW4YkZWGxgt0nje76791qI5s5xtr+IqaxBUmA1W6SIvz4kfzsvt6xeM6rgrrY
 M9R9mF2Vrc84cHbIRt69ScmvSo5da7Cpi/evQtG9rdSPb3ycCfFptxfaTnxrxSQw1i7Uw+O1
 OmsETE/ThAFRuqO5wp4Pf0D788bdWP/Pc5/n9nARmJ9xOV46UHiLV4KmMBVY+VE8TJbZoqc/
 EpLnpknTpNOteJ5+DVYQ/ZV+mWv56nwOpJS+5CV/g1GEGzRf6ZVZMDYl9lC4NcnWzsFNBFLN
 IUUBEADCFlCWLGQmnKkb1DvWbyIPcTuy7ml07G5VhCcRKrYD9GAasvGwb1FafSHxZ1k0JeWx
 FOT02TEMmjVUqals2rINUfu3YXaALq8R0aQ/TjZ8X+jI6Q6HsHwOdFTBL4zD4pKs43iRWd+g
 x8xYBb8aUBY+KiRKP70XCzQMdrEG1x6FABbUX9651hN20Qt/GKNixHVy3vaD3PzteH/jugqf
 tNu98XQ2h4BJBG4gZ0gwjpexu/LjP2t0IOULSsFSf6S8Nat6bPgMW3CrEdTOGklAP9sqjbby
 i8GAbsxZhjx7YDkl1MpFGxlC2g0kFC0MMLue9pSsT5nwDl230IxZgkS7joLSfmjTWj1tyEry
 kiWV7ta3rx27NtXYnHtGrHy+yubTsBygt2uZbL9l2OR4zsc9+hLftF6Up/2D09nFzmLKKcd5
 1bDrb+SMsWull0DjAv73IRF9zrHPJoaVesaTzUGfXlXGxsOqpQ9U2NjUUJg3B/9ijKGM3z9E
 6PF/0Xmc5gG3C4XzT0xJVfsKZcZoWuPl++QQA7nHJMbexyruKOMqzS273vAKnTzvOD0chIvU
 0DZ/FfJBqNdRfv3cUwgQwsBU6BGsGCnM0ofFMg7m0xnCAQeXe9hxAoH1vgGjX0M5U5sJarJA
 +E6o5Kmqtyo0g5R0NBiAxJnhUB0eHJPAElFrR7u1zQARAQABwsF8BBgBCgAmAhsMFiEEZmTn
 vaa2aYgexS51Fu8/ZMsgHZwFAmTrAV8FCRXgRxoACgkQFu8/ZMsgHZwE0A/+PCYHd4kl/oPK
 Kqv9qe89fEz4s8BSVmX+Aq/u52Fl373rcVWpGjokzYDr7jhUHMLEYJcAdmv5AXIbee6az6ip
 OgshW3/rVRRXTgh+DkQMyQZPTHDbB7o9JLcXQ1ehZeEzI8u+HxvWE+Anoquz8Ufsd/3RttgQ
 6HPHSiIogzDizVGxUEPhxFvcH/KlSTTtcmS126Kng2AWs5StE7BW53/cukTLfBR0IGBH1Uwv
 NqDMomXBOifAkv29LFf6qJJkgKA56eiMtUgVjYMgDm9KFOIwDV7J0tNHLqIc0zZEJF+BtxZM
 8tAhPi930wDK4Lcx3TkSNa5/yhmSSnOtLL+YU7R/Gqx24gEeZ0ceMW6A4I6qVrgd3X8pKSYr
 DzqfF/m+ODQeCiSUKtqUa1Kyx736txQ8/Y1DvfXqglIIcF2yiLYpxdHNrNsIC6Me0lEWrFel
 C/dkbUrddrlCOReulvhn1Qve+zh7UC9gLeN6ZkneRgTb6G9NZQhkssXV7ZKXGzn26tzwAgSy
 Ezh+M8kMylL84WE2TkQKo59oqMV7scWcrcY801Lhurb636ZJ/ebMd4bn+eAzwURaeqzScZ2b
 hg1eFj1e0ZkaSVyAu9gBCzuRUnbZ4TiC8/mFfg7HxTnbOSPYI6TrNPFzuzf1NDPLXRXV+rcY
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AVukOp7lG0kE9NWz304Hd2BX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AVukOp7lG0kE9NWz304Hd2BX
Content-Type: multipart/mixed; boundary="------------IUZXZUCZag6xaUhxoEDI1U9q";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Message-ID: <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
In-Reply-To: <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>

--------------IUZXZUCZag6xaUhxoEDI1U9q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYvMDYvMjAyNCAwODo1MiwgQXLEsW7DpyDDnE5BTCB3cm90ZToNCj4gT24gMTUvMDYv
MjAyNCAwMToyMSwgTWF0dGhpYXMgU2NoaWZmZXIgd3JvdGU6DQo+PiBSZW1vdmUgYSBwYWly
IG9mIHBvcnRzIGZyb20gdGhlIHBvcnQgbWF0cml4IHdoZW4gYm90aCBwb3J0cyBoYXZlIHRo
ZQ0KPj4gaXNvbGF0ZWQgZmxhZyBzZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWF0dGhp
YXMgU2NoaWZmZXIgPG1zY2hpZmZlckB1bml2ZXJzZS1mYWN0b3J5Lm5ldD4NCj4+IC0tLQ0K
Pj4gwqAgZHJpdmVycy9uZXQvZHNhL210NzUzMC5jIHwgMjEgKysrKysrKysrKysrKysrKysr
LS0tDQo+PiDCoCBkcml2ZXJzL25ldC9kc2EvbXQ3NTMwLmggfMKgIDEgKw0KPj4gwqAgMiBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbXQ3NTMwLmMgYi9kcml2ZXJzL25ldC9k
c2EvbXQ3NTMwLmMNCj4+IGluZGV4IGVjYWNhZWZkZDY5NC4uNDQ5MzkzNzlhYmE4IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL210NzUzMC5jDQo+PiArKysgYi9kcml2ZXJz
L25ldC9kc2EvbXQ3NTMwLmMNCj4+IEBAIC0xMzAzLDcgKzEzMDMsOCBAQCBtdDc1MzBfc3Rw
X3N0YXRlX3NldChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMsIGludCANCj4+IHBvcnQsIHU4IHN0
YXRlKQ0KPj4gwqAgfQ0KPj4gwqAgc3RhdGljIHZvaWQgbXQ3NTMwX3VwZGF0ZV9wb3J0X21l
bWJlcihzdHJ1Y3QgbXQ3NTMwX3ByaXYgKnByaXYsIGludCBwb3J0LA0KPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqYnJpZGdlX2RldiwgYm9vbCBqb2luKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZSAqYnJpZGdl
X2RldiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vbCBqb2luKQ0KPiANCj4gUnVuIGdpdCBjbGFuZy1mb3JtYXQgb24gdGhpcyBwYXRjaCBh
cyB3ZWxsIHBsZWFzZS4NCg0KT29wcywgd2lsbCBkby4NCg0KDQo+IA0KPj4gwqDCoMKgwqDC
oCBfX211c3RfaG9sZCgmcHJpdi0+cmVnX211dGV4KQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgZHNhX3BvcnQgKmRwID0gZHNhX3RvX3BvcnQocHJpdi0+ZHMsIHBvcnQpLCAq
b3RoZXJfZHA7DQo+PiBAQCAtMTMxMSw2ICsxMzEyLDcgQEAgc3RhdGljIHZvaWQgbXQ3NTMw
X3VwZGF0ZV9wb3J0X21lbWJlcihzdHJ1Y3QgDQo+PiBtdDc1MzBfcHJpdiAqcHJpdiwgaW50
IHBvcnQsDQo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkc2FfcG9ydCAqY3B1X2RwID0gZHAtPmNw
dV9kcDsNCj4+IMKgwqDCoMKgwqAgdTMyIHBvcnRfYml0bWFwID0gQklUKGNwdV9kcC0+aW5k
ZXgpOw0KPj4gwqDCoMKgwqDCoCBpbnQgb3RoZXJfcG9ydDsNCj4+ICvCoMKgwqAgYm9vbCBp
c29sYXRlZDsNCj4+IMKgwqDCoMKgwqAgZHNhX3N3aXRjaF9mb3JfZWFjaF91c2VyX3BvcnQo
b3RoZXJfZHAsIHByaXYtPmRzKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgb3RoZXJfcG9y
dCA9IG90aGVyX2RwLT5pbmRleDsNCj4+IEBAIC0xMzI3LDcgKzEzMjksOSBAQCBzdGF0aWMg
dm9pZCBtdDc1MzBfdXBkYXRlX3BvcnRfbWVtYmVyKHN0cnVjdCANCj4+IG10NzUzMF9wcml2
ICpwcml2LCBpbnQgcG9ydCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWRzYV9wb3J0
X29mZmxvYWRzX2JyaWRnZV9kZXYob3RoZXJfZHAsIGJyaWRnZV9kZXYpKQ0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYg
KGpvaW4pIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpc29sYXRlZCA9IHAtPmlzb2xhdGVkICYm
IG90aGVyX3AtPmlzb2xhdGVkOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChqb2lu
ICYmICFpc29sYXRlZCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3RoZXJf
cC0+cG0gfD0gUENSX01BVFJJWChCSVQocG9ydCkpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcG9ydF9iaXRtYXAgfD0gQklUKG90aGVyX3BvcnQpOw0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIH0gZWxzZSB7DQo+IA0KPiBXaHkgbXVzdCBvdGhlcl9wLT5pc29sYXRlZCBi
ZSB0cnVlIGFzIHdlbGw/IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHdoZW4NCj4gYSB1
c2VyIHBvcnQgaXMgaXNvbGF0ZWQsIG5vbiBpc29sYXRlZCBwb3J0cyBjYW4ndCBjb21tdW5p
Y2F0ZSB3aXRoIGl0DQo+IHdoaWxzdCB0aGUgQ1BVIHBvcnQgY2FuLiBJZiBJIHdlcmUgdG8g
aXNvbGF0ZSBhIHBvcnQgd2hpY2ggaXMgdGhlIG9ubHkNCj4gaXNvbGF0ZWQgb25lIGF0IHRo
ZSBtb21lbnQsIHRoZSBpc29sYXRlZCBmbGFnIHdvdWxkIG5vdCBiZSB0cnVlLiBUaGVyZWZv
cmUsDQo+IHRoZSBpc29sYXRlZCBwb3J0IHdvdWxkIG5vdCBiZSByZW1vdmVkIGZyb20gdGhl
IHBvcnQgbWF0cml4IG9mIG90aGVyIHVzZXINCj4gcG9ydHMuIFdoeSBub3Qgb25seSBjaGVj
ayBmb3IgcC0+aXNvbGF0ZWQ/DQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgcnVsZXMg
YXJlOg0KDQotIG5vbi1pc29sYXRlZCBwb3J0cyBjYW4gY29tbXVuaWNhdGUgd2l0aCBldmVy
eSBwb3J0DQotIGlzb2xhdGVkIHBvcnRzIGNhbid0IGNvbW11bmljYXRlIHdpdGggb3RoZXIg
aXNvbGF0ZWQgcG9ydHMNCi0gY29tbXVuaWNhdGlvbiBpcyBzeW1tZXRyaWMNCg0KWW91J2xs
IGZpbmQgdGhhdCB0aGUgbG9naWMgd29ya3MgdGhlIHNhbWUgZm9yIG5vbi1vZmZsb2FkZWQg
YnJpZGdlIA0KZm9yd2FyZGluZyAoc2VlIHNob3VsZF9kZWxpdmVyKCkgaW4gbmV0L2JyaWRn
ZS9icl9mb3J3YXJkLmMgYW5kIA0KYnJfc2tiX2lzb2xhdGVkKCkgaW4gbmV0L2JyaWRnZS9i
cl9wcml2YXRlLmgpLg0KDQpNYXR0aGlhcw0K

--------------IUZXZUCZag6xaUhxoEDI1U9q--

--------------AVukOp7lG0kE9NWz304Hd2BX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmZupMkFAwAAAAAACgkQFu8/ZMsgHZwf
nhAA0fH9TmWt75vG1YqfmakWTNn9ZINoNquYiHqmEXmNpo9YOoI3nfFnj/nNWsLhG5sJfMuHWSFd
xQuFqrWQKVie5dtNDrdDRolwCihn01DAa/BX1/uV3AlOe47PWVa3x9/nJCpEwAVlOK18rCUOZs/u
MhZeR+SwTxOPoCARRpAppgOBcKV1brZ9FoxsRQAaPcxDbUxhOe5XPfj8gE7LQ7DQSoGJqeKOUXIb
zYFmaaHsZKZJGiYGjkvDTIicm+SuqtCOJ2+sTMt6GikOOy3Jxxp57sLdSi9eS2W5b8yI25TtM0/U
g/+OcbhkjPng9UQkn5Vz+ZbocFxYk28FhR4X66r0iR1Kbq+YkWExnBiO2Qlz/HcyFrw7ebUoT7VM
XeSSO1gB2liCbchhAXsLDk6mTmDu9y44RMc9merntIYcZBnj56/SEMNDe3UqVvagRAEOwYgyBL3i
ZJ65qmp9JdVWDzSZqPBiSTGvFi+pSh4TzD4MG9nxFASx29v/bYP7lrAhZGqxGzZOlFSqJdjO30tY
uJ9ZgPiJzknX60Zk0xKirm5QamkohbC3pC43cIlMFpmtX45IMlxrF335edeQifdllbFiHs1HNO9j
2efBVDNL3xlh+wat0PjYpnHubwXQTqDLD8D1xGs7fjo/qhSiDcHOFgXw+5Bnd9qi3BL46nvv446b
Mow=
=b4Ip
-----END PGP SIGNATURE-----

--------------AVukOp7lG0kE9NWz304Hd2BX--

