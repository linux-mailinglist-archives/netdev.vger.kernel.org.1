Return-Path: <netdev+bounces-288756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCcNN+7pCWpavAQAu9opvQ
	(envelope-from <netdev+bounces-288756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5975623D3
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202F13001CDD
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85652F3C0A;
	Sun, 17 May 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="mTnYTQRs"
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686072571B8
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034600; cv=none; b=taE8dCfah0gsaXw7DZe50MkqjOlWzsvVYFQme6iWExqeYz3LL2HK5HExXjq1deA1ETUDYdwGTJPc8u6m3jeAI4lM6s71gKDVinUKwiAOmU+gH+Hx0jlEpIbpWXTZcy44z06F6i79o7IbZdgh24Up7ZmWnwnaTs7j2YFOiFzjn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034600; c=relaxed/simple;
	bh=dbxksYE1JcNSrtLcxslT+yW9omA8+XFflRGtxuhlXQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XARruH+kC0IWJnKGfh1/+9xn8YM4wLoXE7SLHJj111wjjehAPmw5FwaD26Pg9ZFjuNfkO12L2gsqK3ndXymv4kIsgYVYvmuMGIQvAJhSTWySWKvtcn8OgnlordQF8tqgZgNi1kRRAWQI+aL/6QbUAhzZAx2PDuENVdwhoXYVR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=mTnYTQRs; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=11827; t=1779034548;
	x=1779639348; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2600=3A10
	17=3Ab8c3=3A6570=3A94e7=3A6938=3A51e7=3Ace8b]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md500100528238
	3.msg=3B=20Sun,=2017=20May=202026=2012=3A15=3A46=20-0400|Message
	-ID:=20<7a0b1e31-87cf-4b58-8759-af81ace36a4b@auristor.com>|Date:
	=20Sun,=2017=20May=202026=2012=3A16=3A14=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH]=20rxrpc=3A=20Fix=20the=20ACK=20parser=20to=20extract=20the=2
	0SACK=20table=20for=0D=0A=20parsing|To:=20David=20Howells=20<dho
	wells@redhat.com>,=20netdev@vger.kernel.org|Cc:=20Michael=20Bomm
	arito=20<michael.bommarito@gmail.com>,=0D=0A=20Marc=20Dionne=20<
	marc.dionne@auristor.com>,=20Eric=20Dumazet=20<edumazet@google.c
	om>,=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=20Ja
	kub=20Kicinski=20<kuba@kernel.org>,=0D=0A=20Paolo=20Abeni=20<pab
	eni@redhat.com>,=20Simon=20Horman=20<horms@kernel.org>,=0D=0A=20
	linux-afs@lists.infradead.org,=20stable@kernel.org,=20linux-kern
	el@kernel.org|References:=20<3794930.1779028030@warthog.procyon.
	org.uk>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Altman=2
	0<jaltman@auristor.com>|Organization:=20AuriStor,=20Inc.|Disposi
	tion-Notification-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor
	.com>|In-Reply-To:=20<3794930.1779028030@warthog.procyon.org.uk>
	|Content-Type:=20multipart/signed=3B=20protocol=3D"application/p
	kcs7-signature"=3B=20micalg=3Dsha-256=3B=20boundary=3D"---------
	---ms080708050200030401060401"; bh=dbxksYE1JcNSrtLcxslT+yW9omA8+
	XFflRGtxuhlXQY=; b=mTnYTQRsNXj2jbJj42Pjqncs6QZURQX63jLeD5NAUS+IP
	FecxFveJfX9lZdWRFGaSqP6Bqwq81CyBIQ4d+Rgt4U4t1JeZH8LcWWvv7csk3AuB
	ENYG4R5ZpdWLijjxnVCbA47dhJXUcSivT9B25pxIz5vJ+ltdPKrGryXa7KRIKk=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sun, 17 May 2026 12:15:48 -0400
Received: from [IPV6:2600:1017:b8c3:6570:94e7:6938:51e7:ce8b] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005282383.msg; Sun, 17 May 2026 12:15:46 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sun, 17 May 2026 12:15:46 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2600:1017:b8c3:6570:94e7:6938:51e7:ce8b
X-MDHelo: [IPV6:2600:1017:b8c3:6570:94e7:6938:51e7:ce8b]
X-MDArrival-Date: Sun, 17 May 2026 12:15:46 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1597383cb1=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <7a0b1e31-87cf-4b58-8759-af81ace36a4b@auristor.com>
Date: Sun, 17 May 2026 12:16:14 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rxrpc: Fix the ACK parser to extract the SACK table for
 parsing
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, stable@kernel.org, linux-kernel@kernel.org
References: <3794930.1779028030@warthog.procyon.org.uk>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <3794930.1779028030@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080708050200030401060401"
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 9C5975623D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SIGNED_SMIME(-2.00)[];
	HEADER_FORGED_MDN(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_X_AS(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-288756-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[auristor.com:+];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,auristor.com,google.com,davemloft.net,kernel.org,redhat.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auristor.com:email,auristor.com:mid,auristor.com:dkim]
X-Rspamd-Action: no action

--------------ms080708050200030401060401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xNy8yMDI2IDEwOjI3IEFNLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0KDQo+ICAgICAg
DQo+IEZpeCBtb2RpZmljYXRpb24gb2YgdGhlIHJlY2VpdmVkIHNrYnVmZiBpbiByeHJwY19p
bnB1dF9zb2Z0X2Fja3MoKSBhbmQgYQ0KPiBwb3RlbnRpYWwgaW5jb3JyZWN0IGFjY2VzcyBv
ZiB0aGUgYnVmZmVyIGluIGEgZnJhZ21lbnRlZCBVRFAgcGFja2V0ICh0aGUNCj4gcGFja2V0
IHdvdWxkIHByb2JhYmx5IGhhdmUgdG8gYmUgZGVsaWJlcmF0ZWx5IHByZS1nZW5lcmF0ZWQg
YXMgZnJhZ21lbnRlZCkNCj4gd2hlbiBBRl9SWFJQQyB0cmllcyB0byBleHRyYWN0IHRoZSBj
b250ZW50cyBvZiB0aGUgU0FDSyB0YWJsZSBieSBjb3B5aW5nDQo+IG91dCB0aGUgY29udGVu
dHMgb2YgdGhlIFNBQ0sgdGFibGUgaW50byBhIGJ1ZmZlciBiZWZvcmUgYXR0ZW1wdGluZyB0
byBwYXJzZQ0KPiBpdC4NCj4NCj4gQUZfUlhSUEMgYXNzdW1lcyB0aGF0IGl0IGNhbiBqdXN0
IGNhbGwgc2tiX2NvbmRlbnNlKCkgYW5kIHRoZW4gdmFsaWRseQ0KPiBhY2Nlc3MgdGhlIFNB
Q0sgdGFibGUgZnJvbSBza2ItPmRhdGEgYW5kIHRoYXQgaXQgd2lsbCBiZSBhIGZsYXQgYnVm
ZmVyIC0NCj4gYnV0IHNrYl9jb25kZW5zZSgpIGNhbiBzaWxlbnRseSBmYWlsIHRvIGRvIGFu
eXRoaW5nIHVuZGVyIHNvbWUNCj4gY2lyY3Vtc3RhbmNlcy4NCj4NCj4gTm90ZSB0aGF0IHdo
aWxzdCByeHJwY19pbnB1dF9zb2Z0X2Fja3MoKSBzaG91bGQgYmUgYWJsZSB0byBwYXJzZSBl
eHRlbmRlZA0KPiBBQ0tzLCB0aGUgcmVzdCBvZiBBRl9SWFJQQyBkb2Vzbid0IGN1cnJlbnRs
eSBzdXBwb3J0IHRoYXQuDQo+DQo+IEZ1cnRoZXIsIHRoZXJlJ3MgdGhlbiBubyBuZWVkIHRv
IGNhbGwgc2tiX2NvbmRlbnNlKCkgaW4gcnhycGNfaW5wdXRfYWNrKCksDQo+IHNvIGRvbid0
Lg0KPg0KPiBGaXhlczogZDU3YTNhMTUxNjYwICgicnhycGM6IFNhdmUgbGFzdCBBQ0sncyBT
QUNLIHRhYmxlIHJhdGhlciB0aGFuIG1hcmtpbmcgdHhidWZzIikNCj4gUmVwb3J0ZWQtYnk6
IE1pY2hhZWwgQm9tbWFyaXRvIDxtaWNoYWVsLmJvbW1hcml0b0BnbWFpbC5jb20+DQo+IExp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MTMxODA5MDcuMjA2MTk3Mi0x
LW1pY2hhZWwuYm9tbWFyaXRvQGdtYWlsLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBI
b3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiBjYzogTWFyYyBEaW9ubmUgPG1hcmMu
ZGlvbm5lQGF1cmlzdG9yLmNvbT4NCj4gY2M6IEplZmZyZXkgQWx0bWFuIDxqYWx0bWFuQGF1
cmlzdG9yLmNvbT4NCj4gY2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4N
Cj4gY2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBjYzog
SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gY2M6IFBhb2xvIEFiZW5pIDxw
YWJlbmlAcmVkaGF0LmNvbT4NCj4gY2M6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz4NCj4gY2M6IGxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGNjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnDQo+IGNjOiBzdGFibGVAa2VybmVsLm9yZw0KPiAtLS0NCj4gICBp
bnB1dC5jIHwgICAyMiArKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9uZXQvcnhycGMvaW5wdXQuYyBiL25ldC9yeHJwYy9pbnB1dC5jDQo+IGluZGV4IDI0YWNl
YjE4M2MyYy4uMGMxNWViZjE5ZWFlIDEwMDY0NA0KPiAtLS0gYS9uZXQvcnhycGMvaW5wdXQu
Yw0KPiArKysgYi9uZXQvcnhycGMvaW5wdXQuYw0KPiBAQCAtOTYzLDIxICs5NjMsMzQgQEAg
c3RhdGljIHZvaWQgcnhycGNfaW5wdXRfc29mdF9hY2tzKHN0cnVjdCByeHJwY19jYWxsICpj
YWxsLA0KPiAgIAlzdHJ1Y3QgcnhycGNfc2tiX3ByaXYgKnNwID0gcnhycGNfc2tiKHNrYik7
DQo+ICAgCXN0cnVjdCByeHJwY190eHF1ZXVlICp0cSA9IGNhbGwtPnR4X3F1ZXVlOw0KPiAg
IAl1bnNpZ25lZCBsb25nIGV4dHJhY3RlZCA9IH4wVUw7DQo+IC0JdW5zaWduZWQgaW50IG5y
ID0gMDsNCj4gKwl1bnNpZ25lZCBpbnQgbnIgPSAwLCBuc2FjazsNCj4gICAJcnhycGNfc2Vx
X3Qgc2VxID0gY2FsbC0+YWNrc19oYXJkX2FjayArIDE7DQo+ICAgCXJ4cnBjX3NlcV90IGxv
d2VzdF9uYWsgPSBzZXEgKyBzcC0+YWNrLm5yX2Fja3M7DQo+IC0JdTggKmFja3MgPSBza2It
PmRhdGEgKyBzaXplb2Yoc3RydWN0IHJ4cnBjX3dpcmVfaGVhZGVyKSArIHNpemVvZihzdHJ1
Y3QgcnhycGNfYWNrcGFja2V0KTsNCj4gKwl1OCBzYWNrWzI1Nl0gX19hbGlnbmVkKHNpemVv
Zih1bnNpZ25lZCBsb25nKSk7DQo+ICsJdTggKmFja3MgPSBzYWNrOw0KPiAgIA0KPiAgIAlf
ZW50ZXIoIiV4LCV4LCV1IiwgdHEtPnFiYXNlLCBzZXEsIHNwLT5hY2subnJfYWNrcyk7DQo+
ICAgDQo+ICAgCXdoaWxlIChhZnRlcihzZXEsIHRxLT5xYmFzZSArIFJYUlBDX05SX1RYUVVF
VUUgLSAxKSkNCj4gICAJCXRxID0gdHEtPm5leHQ7DQo+ICAgDQo+ICsJLyogRXh0cmFjdCBh
biBpbmRpdmlkdWFsIFNBQ0sgdGFibGUuICBBIG5vcm1hbCBTQUNLIHRhYmxlIGlzIHVwIHRv
IDI1NQ0KPiArCSAqIGJ5dGVzIHdpdGggMSBBQ0sgZmxhZyBwZXIgYnl0ZSwgYnV0IGFuIGV4
dGVuZGVkIFNBQ0sgdGFibGUgY2FuIGJlIHVwDQo+ICsJICogdG8gMjU2IGJ5dGVzIHdpdGgg
dXAgdG8gOCBBQ0svTkFDSyBmbGFncyBwZXIgYnl0ZS4gIFRoZSBBQ0sgZmxhZ3MgZ28NCj4g
KwkgKiBhY3Jvc3MgYWxsIGJpdCAwJ3MgdGhlbiBhbGwgYml0IDEncywgdGhlbiBhbGwgYml0
IDIncywgLi4uDQo+ICsJICovDQo+ICsJbWVtc2V0KHNhY2ssIDAsIHNpemVvZihzYWNrKSk7
DQo+ICsJbnNhY2sgPSB1bWluKHNwLT5hY2subnJfYWNrcywgMjU2KTsNCj4gKwlpZiAoc2ti
X2NvcHlfYml0cyhza2IsDQo+ICsJCQkgIHNpemVvZihzdHJ1Y3QgcnhycGNfd2lyZV9oZWFk
ZXIpICsgc2l6ZW9mKHN0cnVjdCByeHJwY19hY2twYWNrZXQpLA0KPiArCQkJICBzYWNrLCBu
c2FjaykgPCAwKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gICAJZm9yICh1bnNpZ25lZCBpbnQg
aSA9IDA7IGkgPCBzcC0+YWNrLm5yX2Fja3M7IGkrKykgew0KPiAgIAkJLyogRGVjYW50IEFD
S3MgdW50aWwgd2UgaGl0IGEgdHhxdWV1ZSBib3VuZGFyeS4gKi8NCj4gICAJCXNoaWZ0cl9h
ZHZfcm90cihhY2tzLCBleHRyYWN0ZWQpOw0KPiAgIAkJaWYgKGkgPT0gMjU2KSB7DQo+IC0J
CQlhY2tzIC09IGk7DQo+ICsJCQlhY2tzID0gc2FjazsNCj4gICAJCQlpID0gMDsNCj4gICAJ
CX0NCj4gICAJCXNlcSsrOw0KPiBAQCAtMTExNyw5ICsxMTMwLDYgQEAgc3RhdGljIHZvaWQg
cnhycGNfaW5wdXRfYWNrKHN0cnVjdCByeHJwY19jYWxsICpjYWxsLCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KPiAgIAkgICAgc2tiX2NvcHlfYml0cyhza2IsIGlvZmZzZXQsICZ0cmFpbGVy
LCBzaXplb2YodHJhaWxlcikpIDwgMCkNCj4gICAJCXJldHVybiByeHJwY19wcm90b19hYm9y
dChjYWxsLCAwLCByeHJwY19iYWRtc2dfc2hvcnRfYWNrX3RyYWlsZXIpOw0KPiAgIA0KPiAt
CWlmIChucl9hY2tzID4gMCkNCj4gLQkJc2tiX2NvbmRlbnNlKHNrYik7DQo+IC0NCj4gICAJ
Y2FsbC0+YWNrc19sYXRlc3RfdHMgPSBrdGltZV9nZXRfcmVhbCgpOw0KPiAgIAljYWxsLT5h
Y2tzX2hhcmRfYWNrID0gaGFyZF9hY2s7DQo+ICAgCWNhbGwtPmFja3NfcHJldl9zZXEgPSBw
cmV2X3BrdDsNCj4NClJldmlld2VkLWJ5OiBKZWZmcmV5IEFsdG1hbiA8amFsdG1hbkBhdXJp
c3Rvci5jb20+DQoNCg0K

--------------ms080708050200030401060401
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DTAwggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0
MB4XDTI1MDgxNDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMw
MDAwMDE5OEE2MDQwMjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTAT
BgNVBAoTDEF1cmlTdG9yIEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UE
BBMGQWx0bWFuMRAwDgYDVQQqEwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1
cmlzdG9yLmNvbTELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKtXD1tqgXxlJvgI10FM0ZvyWukq2IeXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6R
hoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bEdWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7Rh
KWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZczLU4JUjbTF0ukM0DbDk55ItDB4dXnW/u
RfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5LonX3oNLdXituSHXLKvq+uChgFN/veD
HKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuzee78ZePfBAgMBAAGjggGhMIIB
nTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYBBQUHAQEEeDB2MDAGCCsG
AQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5jb20wQgYIKwYBBQUH
MAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1c3RpZGNhYTE0
LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAaMAkGB2eB
DAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlkYXRp
b24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0l
BCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4IC
AQCeOjCscMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9d
adUv4o1/F23s0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8f
HRSKFK7DIdWcMMNbS6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhL
df6749jGqSWXpyTMjXzrPMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4
Qj9met/RUvCHPWr68Zlirgx48W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFk
QDmWBH4bMqUcbQWxarMxdQ/jHKTsJIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQ
mb41N1PLZytu8pCGBJufyqjzNU0eyWkHJCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TP
Kkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1BddBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7E
mQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczWS5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6
fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQwggTcoAMCAQICEEABif/SaQvad8Lp
1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBDQSAxMB4XDTIzMDgxNjE5
Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDccsGFBhCb
8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0BvongGBin
xoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjY
V9Au73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSV
QLFbeH9vxFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l
6idZkS4NeHAsrAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBda
K2PSvH7aANZQfyEhNNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpG
UUNqKSjxIpUJ6sDIIgGIqSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9Yp
psHld3OojXhoOsLdCji+be0mAgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcw
AYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjto
dHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2Ex
LnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djBfBgNVHSAEWDBWMFQGBFUd
IAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZp
Y2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3Zh
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
--------------ms080708050200030401060401--


