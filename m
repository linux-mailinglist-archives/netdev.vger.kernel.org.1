Return-Path: <netdev+bounces-159884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF733A17506
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2060A16A050
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7661BAED6;
	Mon, 20 Jan 2025 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ic8gdatT"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40180195F0D
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737415951; cv=none; b=rsWmlVhEv8ktDFRVQJGdXWoc3QpJnqosYzCLKq9pFSeVoWHbvj5osCl6oLaqBIe6DeuK1HVBGhqWVXQ0+C/rtMmYshPxPQBrd7mdnwSUl5pU9iuY4vmsSrNKxd73eduQaoqCw0AEzllJs0hRIjwUnY7mPfyfOv2Xq+kN/d2kd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737415951; c=relaxed/simple;
	bh=+HXSVKuZXpW/Ca/n9xQUI1xpnq0W8UptYlNUOzkwKVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BNcaqTkyg0iqHrKlpfXEDz8zAP1Sy4k8wJwDpHXRMC5J1k4VX+9PHkDlqLwhFb6heAEpsxYIu9wQCupDYxqhrFLnEmNHcKUKWBm8A6IxCs3/KSfHJa29yP3FnPNX6TbxnJUqkOSQzV/3H+SYC3lGf33IsamSEvYmyGQjERLkC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ic8gdatT; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CB8402C0D04;
	Tue, 21 Jan 2025 12:32:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737415945;
	bh=+HXSVKuZXpW/Ca/n9xQUI1xpnq0W8UptYlNUOzkwKVA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ic8gdatT58qZc51R3Hcy0LOoUkWjPhxWyg0xSTpn6rPKhO9a6R2LjMQnrqfKcA/J4
	 /IoF80GLiNNcI/hv6kEpbgquqiJC4MQstrGsV0XDnOR39Htzjiv6VROqLdCxyoXt+h
	 NB8pEkcDlHmyFQ9MSkwqOxwuxDz3x63jjQu6Tv8fe4+n2m1thAPNC+z9uZSJIqanrR
	 fju8UqGpyfALNqxS/ODgrHj0cFyA6ZzCiHCnUSDB73/J0Z9hrD7BLxRn4iT1ylZMkB
	 2GmDjiX4UEhRJIyzZzlJJyuDvW4tCvDXQgZO8BSJ6hVwF9HxVTA1IFunLt5Rf5MiQX
	 kyV2sXmsTZn/g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678edd090001>; Tue, 21 Jan 2025 12:32:25 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 12:32:25 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 21 Jan 2025 12:32:25 +1300
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "marcin.s.wojtas@gmail.com"
	<marcin.s.wojtas@gmail.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v0] net: mvpp2: Add parser configuration for DSA
 tags
Thread-Topic: [PATCH net-next v0] net: mvpp2: Add parser configuration for DSA
 tags
Thread-Index: AQHbGrc8dFZl9Z9XwEqp1Xl6qimhLrJ/LtSAgKDo7oA=
Date: Mon, 20 Jan 2025 23:32:25 +0000
Message-ID: <1ffba10f302ba6c0e3677a9e6c246ef40c415e3d.camel@alliedtelesis.co.nz>
References: <20241010015104.1888628-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20241010161711.114370ed@fedora.home>
In-Reply-To: <20241010161711.114370ed@fedora.home>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFD5C8EAFF2DAD47BE9D1A1DAB8951E5@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678edd09 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=SwxBxX-qAVdc2W418igA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgTWF4aW1lLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KT24gVGh1LCAyMDI0LTEw
LTEwIGF0IDE2OjE3ICswMjAwLCBNYXhpbWUgQ2hldmFsbGllciB3cm90ZToNCj4gaXAgbGluayBz
ZXQgZXRoWCB1cCA9PiB0cmlnZ2VycyBhIGNoYW5nZSBpbiB0aGUgRFNBIGhlYWRlciBzaXplDQo+
IHJlZ2lzdGVyDQo+IA0KPiBJbiB0aGF0IHNpdHVhdGlvbiwgdGhlIG9mZnNldCBmb3IgdGhlIFZM
QU4gaW50ZXJmYWNlIGV0aFguWSdzIGhlYWRlcg0KPiB3aWxsIGJlIGluY29ycmVjdCwgaWYgdGhl
IERTQSB0YWcgdHlwZSBnZXRzIHVwZGF0ZWQgYXQgLm9wZW4oKSB0aW1lLg0KPiANCj4gU28gSSB0
aGluayBhIHNvbHV0aW9uIHdvdWxkIGJlIHRvIHJlcGxhY2UgdGhlIHJlYWQgZnJvbSB0aGUNCj4g
TVZQUDJfTUhfUkVHIGluIHRoZSB2bGFuIGZpbHRlcmluZyBmdW5jdGlvbnMgd2l0aCBhIGNhbGwg
eW91cg0KPiBuZXdseS1pbnRyb2R1Y2VkIG12cHAyX2dldF90YWcsIG1ha2luZyBzdXJlIHRoYXQg
d2UgdXNlIHRoZSBjb3JyZWN0DQo+IHRhZw0KPiBsZW5ndGggZm9yIHRoZXNlIHBhcnNlciBlbnRy
aWVzIGFzIHdlbGwuDQo+IA0KPiBUaGFua3MsDQpZZXMgSSBhZ3JlZSB0aGlzIGNhbiBiZSBhIHBv
dGVudGlhbCBpc3N1ZSwgYW5kIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoDQphY2NvcmRpbmcgdG8g
eW91ciBzdWdnZXN0aW9uIGFib3ZlLg0KPiANCj4gTWF4aW1lDQoNClRoYW5rcywgQXJ5YW4gDQo=

