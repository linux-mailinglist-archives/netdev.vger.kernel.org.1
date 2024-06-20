Return-Path: <netdev+bounces-105115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABB90FC12
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928D72812B0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835BF2033E;
	Thu, 20 Jun 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LV8LZfx7"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41915381AD
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859430; cv=none; b=h5TVItS+efHJbKZWn6M15UsJkY21K3bds47Xf+XiYyGGiqqzRNHG7BccJ6I5Mznj2TMX3eijaBaG7IsgYa6ga4qEqfccrqi/nsDoX5d3CJFm3FRrHARhgEb0bjifIEPXVchyhTb0BDJIPLUlFbT7mhIQoufuvtBH+WGaiuqDYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859430; c=relaxed/simple;
	bh=Gs9Hhj85dtpjC9Z68UX/s72sQFsHJWTAG5Wv01q5Ax4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrMQpKLlyFl8i2QUYjdVYSmnCv3JvtdDVglJB3jnDlw6fVz4xuOM8rQz2UDlSIKaG1ds3Yv4/OF5x2ZotSCt9KbV+Sz7o8p6sbpSvNHEzX0tI0/ME22Y8od2ZK6kXseik6abyWMRJnNyP29RwGcvewqFk3g2CPyqmahyDQxhELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=LV8LZfx7; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0EF072C0BA5;
	Thu, 20 Jun 2024 16:57:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718859426;
	bh=Gs9Hhj85dtpjC9Z68UX/s72sQFsHJWTAG5Wv01q5Ax4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LV8LZfx7mlPbuw4u7RxXduIyY+8KHTnrvALcTXu0Hte41/6ShgFSK2Ldkj/QDNPwO
	 zGY3pstecQbmID0BhYX7qZ2dI5ylDgW+4wKGf7C5FPSzSbkiT7Hu8ykvdnmYVZ29Ny
	 O/YOeCya1KBEcDgnvVe3HG7XRJDXfC3+5aNHtFbW0GqnSpuRJOInjRNS/4TSJTG2LP
	 A3bRjPVVzFJWYS00l+Rak0VQ/DIS8qoHjDWEvE76Vjn1fuN+MG26Uny1RHEk1wQc46
	 TE8ct9AAx4r1tRfI9De1Ho2z0fqpo12gPDWaOCvZ0u8venTN3Umls+GVThzYjHErsq
	 DiQwbkfqEuuBw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6673b6a20000>; Thu, 20 Jun 2024 16:57:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 16:57:05 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jun 2024 16:57:05 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 20 Jun 2024 16:57:05 +1200
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kabel@kernel.org" <kabel@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
Thread-Topic: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
Thread-Index: AQHawqjJCoLCup8mLki/aO5oskWPDLHPF1iAgAA2w4A=
Date: Thu, 20 Jun 2024 04:57:05 +0000
Message-ID: <0dcbc80f5e92e8e6f62a2f34f5ba4af8bc78f44c.camel@alliedtelesis.co.nz>
References: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20240619184105.05d8e925@kernel.org>
In-Reply-To: <20240619184105.05d8e925@kernel.org>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6784F563159D4645A4D7FDDC5DC4B86B@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=6673b6a2 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=x6h6SwU4EEBpS8rbUbAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDE4OjQxIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAyMCBKdW4gMjAyNCAxMjoyODoyNiArMTIwMCBBcnlhbiBTcml2YXN0YXZhIHdy
b3RlOg0KPiA+ICtzdGF0aWMgaW50IG12ODhlNnh4eF9hdHVfbmV3KHN0cnVjdCBtdjg4ZTZ4eHhf
Y2hpcCAqY2hpcCwgdTE2DQo+ID4gKmZpZCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoGlu
dCBlcnI7DQo+IA0KPiBlcnIgaXMgdW51c2VkIGluIHRoaXMgZnVuY3Rpb24uIFBsZWFzZSBtYWtl
IHN1cmUgeW91IGxvb2sgYXQ6DQo+IGh0dHBzOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0y
MDk4OCZkPXRvano1b05wa0x3c3BVVnc3aWpWTFJ4cTZrcHJYcXI1bXFTSHN6ci1ZUSZ1PWh0dHBz
JTNhJTJmJTJmd3d3JTJla2VybmVsJTJlb3JnJTJmZG9jJTJmaHRtbCUyZm5leHQlMmZwcm9jZXNz
JTJmbWFpbnRhaW5lci1uZXRkZXYlMmVodG1sDQo+IGJlZm9yZSByZXBvc3RpbmcNCkFwb2xvZ2ll
cywgbWlzc2VkIHRoaXMgZHVyaW5nIG15IGNvbXBpbGUuIFdpbGwgcmUtdXBsb2FkIHdpdGggZml4
IGluDQpuZXh0IHNlcmllcy4NCg0KVGhhbmtzLA0KQXJ5YW4NCg==

