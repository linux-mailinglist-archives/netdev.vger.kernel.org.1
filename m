Return-Path: <netdev+bounces-80804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D5888120E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775EF281A04
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F140847;
	Wed, 20 Mar 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b="moWbLjUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out12.electric.net (smtp-out12.electric.net [89.104.206.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5011A38E6
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.104.206.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940071; cv=none; b=VGMapldSMcpOdmJqSGYphMeUbm43smCtsl6yIKLABPFCviYOiQSNnbbK1TCz5Vj9TzlYtRZK9aX0YK0CvN+R/KL051w4JftQEVIBo/mzgnCuJsMQYhyoKl+ZvLY8IHkBgAZUuUmc7f5awSYyS1XIEakMfiRx3i9rEmgS3fGM3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940071; c=relaxed/simple;
	bh=RQAn0ZMhq0kHjTTEjswIDH4Lr2VXmAhNdK3BGWZqg2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtmHNOoKNSyNEoZqcmhngUGYF3AVOQJztSBaW+OTV/xxVglKpyyfhicDJVcmoeliZhbA6q8iPcBu9fSggncrDpU45O5UJpEKZYUSI5vwZTEDsw+eJobsiUYEZV3JizpxPCEBxssZJexoIu3TdxJv4UI6DzT2f6uCgGdvWN8K9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com; spf=pass smtp.mailfrom=terma.com; dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b=moWbLjUj; arc=none smtp.client-ip=89.104.206.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=terma.com
Received: from 1rmvDQ-000307-TT by out12b.electric.net with emc1-ok (Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmvDT-0003TL-W0;
	Wed, 20 Mar 2024 05:38:47 -0700
Received: by emcmailer; Wed, 20 Mar 2024 05:38:47 -0700
Received: from [193.163.1.101] (helo=EXCH07.terma.com)
	by out12b.electric.net with esmtpsa  (TLS1.2) tls TLS_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmvDQ-000307-TT;
	Wed, 20 Mar 2024 05:38:44 -0700
Received: from EXCH09.terma.com (10.12.2.69) by EXCH07.terma.com (10.12.2.67)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Mar
 2024 13:38:43 +0100
Received: from EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da]) by
 EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da%17]) with mapi id
 15.01.2507.034; Wed, 20 Mar 2024 13:38:43 +0100
From: Claus Hansen Ries <chr@terma.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Alex Elder <elder@linaro.org>, Wei Fang
	<wei.fang@nxp.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>, Wang Hai <wanghai38@huawei.com>
Subject: RE: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Topic: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Index: Adp6NO47DhzC33LDRRqZX1YF4VLPmAAgA96AAAIsztA=
Date: Wed, 20 Mar 2024 12:38:43 +0000
Message-ID: <6ba038acc328407195fc8c4a1af7dce9@terma.com>
References: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
 <20240320115433.GT185808@kernel.org>
In-Reply-To: <20240320115433.GT185808@kernel.org>
Accept-Language: en-150, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated: smtp.out@terma.com
X-Outbound-IP: 193.163.1.101
X-Env-From: chr@terma.com
X-Proto: esmtpsa
X-Revdns: r2d2.lystrup.terma.com
X-HELO: EXCH07.terma.com
X-TLS: TLS1.2:AES256-GCM-SHA384:256
X-Authenticated_ID: smtp.out@terma.com
X-VIPRE-Scanners:virus_clamav;virus_bd;
X-PolicySMART: 6001202, 19049467
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=terma.com; s=mailanyone20180424;h=MIME-Version:In-Reply-To:References:Message-ID:Date:To:From; bh=RQAn0ZMhq0kHjTTEjswIDH4Lr2VXmAhNdK3BGWZqg2E=;b=moWbLjUjO2qUkYrxqgQv9EPo5yuC4mVTACpBwd/uGQGIju+R3C+MrA9xzvsE8US7xazBqvFAVuQGSw00iSosai9yu9fhVZfglgVzkvRjZKK7mX4X0uMeREs0R9b5jzu07quvrP08uWTiWc7iBvBtCHQvMKQJkacSpwKSLHHHJegq/XjYni+pFjL1Y37tJP7viievMfL57naObU1CMx/xDuY9dJ99HzGNB+HRac/gk0De93QMNgqSG3vxNtsBGloZ2iDfBPFIV+DG2qFEU44n8Da8MYdaQf3W6vywllEy4Mg0aREhNK5X78T0QExKAUGDS9DTQRtn8jnsfv9umreN3g==;
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467

SGksDQoNCldlIHJhbiBpbnRvIHRoZSBpc3N1ZSB3aGVuIHVwZ3JhZGluZyBmcm9tIGtlcm5lbCA1
LjQueCB0byA2LjEueC4gSSBkb24ndCB0aGluayBpdCBpcyBhIG11Y2ggdXNlZCBkcml2ZXIuDQoN
CkNhbid0IHNheSBpZiB0aGlzIHdvdWxkIHdvcmsgb24gZGlmZmVyZW50IGltcGxlbWVudGF0aW9u
cyBvZiBYaWxpbnggSERMLCBidXQgbG9va2luZyBhdCB0aGUgY29kZSwgSSBjYW4ndCBzZWUgZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZS9wbGF0Zm9ybV9nZXRfcmVzb3VyY2Vf
YnluYW1lIHN1Y2NlZWQgd2l0aG91dCBoaXR0aW5nIHN0cmNtcCwgYW55IG90aGVyIHBhdGggbWFr
ZXMgdGhlIHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUgcmV0dXJuIE5VTEwgYW5kIF9fZGV2
bV9pb3JlbWFwX3Jlc291cmNlIGZhaWwgd2l0aCAicmVzID09IE5VTEwiIChhcyBmYXIgSSBjYW4g
c2VlKS4gSXQgd291bGQgcmVxdWlyZSBzdHJjbXAgYmVpbmcgYWJsZSB0byBzdXJ2aXZlIHdpdGgg
dGhlIG5hbWUgcG9pbnRlciBiZWluZyBlcXVhbCB0byAwLg0KDQp2b2lkIF9faW9tZW0gKg0KZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LA0KCQkJCSAgICAgIGNvbnN0IGNoYXIgKm5hbWUpDQp7DQoJc3RydWN0IHJlc291cmNl
ICpyZXM7DQoNCglyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCBuYW1lKTsNCglyZXR1cm4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5k
ZXYsIHJlcyk7DQp9DQoNCg0KDQpzdHJ1Y3QgcmVzb3VyY2UgKnBsYXRmb3JtX2dldF9yZXNvdXJj
ZV9ieW5hbWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2LA0KCQkJCQkgICAgICB1bnNpZ25l
ZCBpbnQgdHlwZSwNCgkJCQkJICAgICAgY29uc3QgY2hhciAqbmFtZSkNCnsNCgl1MzIgaTsNCg0K
CWZvciAoaSA9IDA7IGkgPCBkZXYtPm51bV9yZXNvdXJjZXM7IGkrKykgew0KCQlzdHJ1Y3QgcmVz
b3VyY2UgKnIgPSAmZGV2LT5yZXNvdXJjZVtpXTsNCg0KCQlpZiAodW5saWtlbHkoIXItPm5hbWUp
KQ0KCQkJY29udGludWU7DQoNCgkJaWYgKHR5cGUgPT0gcmVzb3VyY2VfdHlwZShyKSAmJiAhc3Ry
Y21wKHItPm5hbWUsIG5hbWUpKQ0KCQkJcmV0dXJuIHI7DQoJfQ0KCXJldHVybiBOVUxMOw0KfQ0K
DQp2b2lkIF9faW9tZW0gKmRldm1faW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQoJCQkJICAgIGNvbnN0IHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0Kew0KCXJldHVybiBfX2Rldm1f
aW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcywgREVWTV9JT1JFTUFQKTsNCn0NCg0KX19kZXZtX2lv
cmVtYXBfcmVzb3VyY2Uoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgcmVzb3VyY2Ug
KnJlcywNCgkJCWVudW0gZGV2bV9pb3JlbWFwX3R5cGUgdHlwZSkNCnsNCglyZXNvdXJjZV9zaXpl
X3Qgc2l6ZTsNCgl2b2lkIF9faW9tZW0gKmRlc3RfcHRyOw0KCWNoYXIgKnByZXR0eV9uYW1lOw0K
DQoJQlVHX09OKCFkZXYpOw0KDQoJaWYgKCFyZXMgfHwgcmVzb3VyY2VfdHlwZShyZXMpICE9IElP
UkVTT1VSQ0VfTUVNKSB7DQoJCWRldl9lcnIoZGV2LCAiaW52YWxpZCByZXNvdXJjZSAlcFJcbiIs
IHJlcyk7DQoJCXJldHVybiBJT01FTV9FUlJfUFRSKC1FSU5WQUwpOw0KCX0NCi4uLi4NCg0KQ2xh
dXMgSGFuc2VuIFJpZXMNClNwZWNpYWxpc3QsIFNvZnR3YXJlIEVuZ2luZWVyaW5nDQpSYWRhciBB
cHBsaWNhdGlvbiBTb2Z0d2FyZQ0KVGVybWEgQS9TDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IA0KU2VudDogMjAuIG1h
cnRzIDIwMjQgMTI6NTUNClRvOiBDbGF1cyBIYW5zZW4gUmllcyA8Y2hyQHRlcm1hLmNvbT4NCkNj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9m
dC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgTWlj
aGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFsZXggRWxkZXIgPGVsZGVyQGxpbmFy
by5vcmc+OyBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+OyBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVu
dGVyQGxpbmFyby5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgV2FuZyBIYWkg
PHdhbmdoYWkzOEBodWF3ZWkuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0OiBsbF90ZW1h
YzogcGxhdGZvcm1fZ2V0X3Jlc291cmNlIHJlcGxhY2VkIGJ5IHdyb25nIGZ1bmN0aW9uDQoNCkNB
VVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgVGVybWEuIERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KKyBFcmljIER1bWF6ZXQs
IEpha3ViIEtpY2luc2tpLCBQYW9sbyBBYmVuaSwgTWljaGFsIFNpbWVrLCBBbGV4IEVsZGVyDQog
IFdlaSBGYW5nLCBVd2UgS2xlaW5lLUvDtm5pZywgRGFuIENhcnBlbnRlciwgUm9iIEhlcnJpbmcs
IFdhbmcgSGFpDQoNCk9uIFR1ZSwgTWFyIDE5LCAyMDI0IGF0IDA3OjQ1OjI2UE0gKzAwMDAsIENs
YXVzIEhhbnNlbiBSaWVzIHdyb3RlOg0KPiBGcm9tOiBDbGF1cyBIYW5zZW4gcmllcyA8Y2hyQHRl
cm1hLmNvbT4NCj4NCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSBpcyBj
YWxsZWQgdXNpbmcgMCBhcyBuYW1lLCB3aGljaCANCj4gZXZlbnR1YWxseSBlbmRzIHVwIGluIHBs
YXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUsIHdoZXJlIGl0IGNhdXNlcyBhIG51bGwgcG9pbnRl
ciBpbiBzdHJjbXAuDQo+DQo+ICAgICAgICAgICAgICAgICBpZiAodHlwZSA9PSByZXNvdXJjZV90
eXBlKHIpICYmICFzdHJjbXAoci0+bmFtZSwgDQo+IG5hbWUpKQ0KPg0KPiBUaGUgY29ycmVjdCBm
dW5jdGlvbiBpcyBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UuDQoNCkhpIENsYXVzLA0K
DQpJdCBpcyBjdXJpb3VzIHRoYXQgdGhpcyB3YXNuJ3Qgbm90aWNlZCBlYXJsaWVyIC0gZG9lcyB0
aGUgZHJpdmVyIGZ1bmN0aW9uIGluIHNvbWUgY2lyY3Vtc3RhbmNlcyB3aXRob3V0IHRoaXMgY2hh
bmdlPw0KDQo+DQo+IEZpeGVzOiBiZDY5MDU4ICgibmV0OiBsbF90ZW1hYzogVXNlIA0KPiBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCkiKQ0KDQpuaXQ6IEZpeGVzIHRhZ3Mg
c2hvdWxkIHVzZSAxMiBvciBtb3JlIGNoYXJhY3RlcnMgZm9yIHRoZSBoYXNoLg0KDQpGaXhlczog
YmQ2OTA1OGY1MGQ1ICgibmV0OiBsbF90ZW1hYzogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZV9ieW5hbWUoKSIpDQoNCj4gU2lnbmVkLW9mZi1ieTogQ2xhdXMgSC4gUmllcyA8Y2hy
QHRlcm1hLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KVW5mb3J0dW5hdGVs
eSB0aGUgcGF0Y2ggZG9lcyBub3QgYXBwbHkgLSBpdCBzZWVtcyB0aGF0IHRhYnMgaGF2ZSBiZWVu
IHJlcGxhY2VkIGJ5IHNwYWNlcyBzb21ld2hlcmUgYWxvbmcgdGhlIHdheS4gSXQgd291bGQgYmUg
YmVzdCB0byByZXBvc3Qgd2l0aCB0aGF0IGFkZHJlc3NlZC4gVXNpbmcgZ2l0IHNlbmQtZW1haWwg
dXN1YWxseSB3b3Jrcy4NCg0KQWxzbywgYXMgdGhpcyBpcyBhIGZpeCwgcGxlYXNlIHRhcmdldCBp
dCBhdCB0aGUgbmV0IHRyZWUuDQpUaGF0IG1lYW5zIGl0IHNob3VsZCBiZSBiYXNlZCBvbiB0aGF0
IHRyZWUgKHRoYXQgcGFydCBpcyBmaW5lIDopIGFuZCBkZXNpZ25hdGVkIGFzIGJlaW5nIGZvciBu
ZXQgaW4gdGhlIHN1YmplY3QuDQoNCiAgICAgICAgU3ViamVjdDogW1BBVENIIG5ldF0gLi4uDQoN
Ckxhc3RseSwgcGxlYXNlIHJ1biBnZXRfbWFpbnRhaW5lci5wbCBvbiB5b3VyIHBhdGNoIHRvIHBy
b3ZpZGUgdGhlIGxpc3Qgb2YgcGFydGllcyB0byBDQy4NCg0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5v
cmcvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sDQoNCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC94aWxpbngvbGxfdGVtYWNfbWFpbi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC94aWxpbngvbGxfdGVtYWNfbWFpbi5jIA0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L3hpbGlueC9sbF90ZW1hY19tYWluLmMNCj4gaW5kZXggOWRmMzljZjhiMDk3Li4x
MDcyZTIyMTBhZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC9s
bF90ZW1hY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L2xsX3Rl
bWFjX21haW4uYw0KPiBAQCAtMTQ0Myw3ICsxNDQzLDcgQEAgc3RhdGljIGludCB0ZW1hY19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIH0NCj4gICAgICAgICAg
IC8qIG1hcCBkZXZpY2UgcmVnaXN0ZXJzICovDQo+IC0gICAgICAgbHAtPnJlZ3MgPSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsIDApOw0KPiArICAgICAgIGxwLT5y
ZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgICAgICAg
IGlmIChJU19FUlIobHAtPnJlZ3MpKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2
LT5kZXYsICJjb3VsZCBub3QgbWFwIFRFTUFDIHJlZ2lzdGVyc1xuIik7DQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCj4NCj4gYmFzZS1jb21taXQ6IGQ5NWZjZGY0OTYxZDI3YTNk
MTdlNWM3NzI4MzY3MTk3YWRjODliOGQNCj4gLS0gIDIuMzkuMyAoQXBwbGUgR2l0LTE0NikNCj4N
Cj4NCj4NCg0KLS0NCnB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCg==

