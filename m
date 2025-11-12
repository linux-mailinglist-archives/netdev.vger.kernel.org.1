Return-Path: <netdev+bounces-237918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBD3C517C1
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EAB5502D04
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A672FF148;
	Wed, 12 Nov 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="aoYO7KS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834002FD7D0;
	Wed, 12 Nov 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940409; cv=none; b=gLQTRMHVhXRlBB4ExdypYFQePAlJWD2BCzyl9wzKJpHa9k+2OL4ciQ6u5+Q9o+uzwC65ur5FlgdzpERchScSpWNHNvYkpqFe5/GB52d+QVCvkEXqI3wPPhvOx8je9SVqQgg1FxGAFcUDTxmI2ljSU5XlVqWvIxIGtaRwLD4J67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940409; c=relaxed/simple;
	bh=wtm/toPwhxcCPbrqIOj64VZsX+Qke2L0qOuUxbs48Zs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aqUVU/GWF95Y5XHUohliAWikQmLGothlFfFsIXrn6XnlD2q9ZLSL1kxnGiiGwm69BrQnZ9XigKlWO0ZUa2ZYSQA8SolE38sUF5PJ8nuuFW1KwvM2NFsLBbAjkSDanlDqBUvwJ2mtdqPV6a2TYLlpYURejzCiG11cdUh3MJtEH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=aoYO7KS1; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 5AC9L40H028943-5AC9L40J028943
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 12 Nov 2025 12:21:04 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 12 Nov
 2025 12:21:04 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 12 Nov 2025 12:21:04 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Venkata Duvvuru
	<VenkatKumar.Duvvuru@Emulex.Com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] be2net: check wrb_params for NULL value
Thread-Topic: [PATCH net] be2net: check wrb_params for NULL value
Thread-Index: AQHcU7WrbULp1sdKi0ef7fYLGowmsA==
Date: Wed, 12 Nov 2025 09:21:04 +0000
Message-ID: <20251112092051.851163-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/11/2025 10:59:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BDF0E96873DB94EBE800CD783423EB4@crpt.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaXkgJAgEcRgMACRgJGgwNKAoaBwkMCwcFRgsHBUhYSFpIWVpIWVFaRlleUEZeWEZcSFBIWEhYSFFIWEhYSFhIWl5ICQIBHEYDAAkYCRoMDSgKGgcJDAsHBUYLBwVIWEhaWUgJBgwaDR9DBg0cDA0eKAQdBgZGCwBIWEhZUUgMCR4NBSgMCR4NBQQHDhxGBg0cSFhIWVFIDQwdBQkSDRwoDwcHDwQNRgsHBUhYSFldSAMdCgkoAw0aBg0ERgcaD0hYSFpQSAQBBh0QRQMNGgYNBCgeDw0aRgMNGgYNBEYHGg9IWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIWV9IGAkKDQYBKBoNDAAJHEYLBwVIWEhbWEg+DQYDCRwjHQUJGkYsHR4eHRodKA0FHQQNEEYLBwVIWA==
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=wtm/toPwhxcCPbrqIOj64VZsX+Qke2L0qOuUxbs48Zs=;
 b=aoYO7KS1yOvF0gl86TPvox2fEDlU2oggnadThVRcHezOb+F5IeozPMtyw6Pu3YnZ7eiIhz0+clkJ
	ghUz106MUfDOIYH/L+BGtqNfK2L3UMWps0ASjsBf/2m1gSBSOurpMwrEqiedD7SKikC1A1qnGdUB
	LUfXurCGYqm6BJCENUEyNelnEyV3N4qhvNQFWAgb9PanwSE5DpdVBrgES1ekvxxgwhDNdWSEGIj6
	eTitBGj09tMc/8N7az/PiCIRvNbYmb1UpIJcdLJ8IKHYooFuYmk4kJZNrMrnL4CTXTNHPsh6Fvv+
	XWwhDj0RFW5+NK1/Lc5zBx7FqOjU/Sy1ZwBmaw==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KYmVfaW5zZXJ0
X3ZsYW5faW5fcGt0KCkgaXMgY2FsbGVkIHdpdGggdGhlIHdyYl9wYXJhbXMgYXJndW1lbnQgYmVp
bmcgTlVMTA0KYXQgYmVfc2VuZF9wa3RfdG9fYm1jKCkgY2FsbCBzaXRlLsKgIFRoaXMgbWF5IGxl
YWQgdG8gZGVyZWZlcmVuY2luZyBhIE5VTEwNCnBvaW50ZXIgd2hlbiBwcm9jZXNzaW5nIGEgd29y
a2Fyb3VuZCBmb3Igc3BlY2lmaWMgcGFja2V0LCBhcyBjb21taXQNCmJjMGMzNDA1YWJiYiAoImJl
Mm5ldDogZml4IGEgVHggc3RhbGwgYnVnIGNhdXNlZCBieSBhIHNwZWNpZmljIGlwdjYNCnBhY2tl
dCIpIHN0YXRlcy7CoCBBZGQgYSBjaGVjayBmb3IgdGhhdC4NCg0KQW5vdGhlciB3YXkgd291bGQg
YmUgdG8gcGFzcyBhIHZhbGlkIHdyYl9wYXJhbXMgZnJvbSBiZV94bWl0KCksIGJ1dCB0aGF0DQpz
ZWVtcyB0byBiZSByZWR1bmRhbnQgYXMgdGhlIGNvcnJlc3BvbmRpbmcgYml0IGluIHdyYl9wYXJh
bXMgc2hvdWxkIGhhdmUNCmJlZW4gYWxyZWFkeSBzZXQgdGhlcmUgaW4gYWR2YW5jZSB3aXRoIGEg
Y2FsbCB0byBiZV94bWl0X3dvcmthcm91bmRzKCkuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlmaWNh
dGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQogICAgICAgDQpGaXhl
czogNzYwYzI5NWUwZThkICgiYmUybmV0OiBTdXBwb3J0IGZvciBPUzJCTUMuIikuDQpTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgVmF0b3JvcGluIDxhLnZhdG9yb3BpbkBjcnB0LnJ1Pg0KLS0tDQogZHJp
dmVycy9uZXQvZXRoZXJuZXQvZW11bGV4L2JlbmV0L2JlX21haW4uYyB8IDYgKysrKy0tDQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxleC9iZW5ldC9iZV9tYWluLmMgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9lbXVsZXgvYmVuZXQvYmVfbWFpbi5jDQppbmRleCBjYjAwNGZkMTYyNTIu
LjQ2N2NjNDlmZTFkNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxleC9i
ZW5ldC9iZV9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxleC9iZW5ldC9i
ZV9tYWluLmMNCkBAIC0xMDYzLDcgKzEwNjMsOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmJl
X2luc2VydF92bGFuX2luX3BrdChzdHJ1Y3QgYmVfYWRhcHRlciAqYWRhcHRlciwNCiAJCS8qIGYv
dyB3b3JrYXJvdW5kIHRvIHNldCBza2lwX2h3X3ZsYW4gPSAxLCBpbmZvcm1zIHRoZSBGL1cgdG8N
CiAJCSAqIHNraXAgVkxBTiBpbnNlcnRpb24NCiAJCSAqLw0KLQkJQkVfV1JCX0ZfU0VUKHdyYl9w
YXJhbXMtPmZlYXR1cmVzLCBWTEFOX1NLSVBfSFcsIDEpOw0KKwkJaWYgKHdyYl9wYXJhbXMpDQor
CQkJQkVfV1JCX0ZfU0VUKHdyYl9wYXJhbXMtPmZlYXR1cmVzLCBWTEFOX1NLSVBfSFcsIDEpOw0K
IAl9DQogDQogCWlmIChpbnNlcnRfdmxhbikgew0KQEAgLTEwODEsNyArMTA4Miw4IEBAIHN0YXRp
YyBzdHJ1Y3Qgc2tfYnVmZiAqYmVfaW5zZXJ0X3ZsYW5faW5fcGt0KHN0cnVjdCBiZV9hZGFwdGVy
ICphZGFwdGVyLA0KIAkJCQkJCXZsYW5fdGFnKTsNCiAJCWlmICh1bmxpa2VseSghc2tiKSkNCiAJ
CQlyZXR1cm4gc2tiOw0KLQkJQkVfV1JCX0ZfU0VUKHdyYl9wYXJhbXMtPmZlYXR1cmVzLCBWTEFO
X1NLSVBfSFcsIDEpOw0KKwkJaWYgKHdyYl9wYXJhbXMpDQorCQkJQkVfV1JCX0ZfU0VUKHdyYl9w
YXJhbXMtPmZlYXR1cmVzLCBWTEFOX1NLSVBfSFcsIDEpOw0KIAl9DQogDQogCXJldHVybiBza2I7
DQotLSANCjIuNDMuMA0K

