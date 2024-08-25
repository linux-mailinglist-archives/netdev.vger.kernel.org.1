Return-Path: <netdev+bounces-121722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E395E34A
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBD328123E
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0754645;
	Sun, 25 Aug 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="DR54mGWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D14A2C
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.210.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724588772; cv=none; b=iyqR5Pm3h2NIMkbS7l2fux/luxg8guc8oGl5B3o641mZZbvWPMPC9mRIKmRqJG8ktotsldpURuPv2FVtcvpw0D1jgsOSX/MnE+Fzh36XSdn4LT9I9Ig3xJ1Lwikr0CII61C6CMldZ01nsZD5rpJ1MLIyEIDOMMsCGt9KOt89FkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724588772; c=relaxed/simple;
	bh=m9jjAY2iBnETtSqdYv+5YOf9Ivtpa0vT/HHW96mcQE0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qpYJbJO3mi2NLYJvpck7CUm7X5qGLUKHm3w57x/4095+jqeUh0fYSNR8U5DsLRcli9J827Kx3r6mb8ru7oPT67MgXDq9cL3/3XMjtIKhTaM53Dchw31eCHQNmAQoSdkg+46/2XWk+Bw8peuB+KD51l9gPO0tVYVsqhKdbpXO8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=DR54mGWa; arc=none smtp.client-ip=80.12.210.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1724588768; x=1756124768;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=m9jjAY2iBnETtSqdYv+5YOf9Ivtpa0vT/HHW96mcQE0=;
  b=DR54mGWaVQUrM96Od0Rl5dCNALZQvC2GvPTZhLwgrMRSjVY8wJDsmV2y
   Gi0NrUOR45ue8UClsDYDnw/WYRiq15NL6N8APnvSdyUaFg3+6B0oezYRW
   ygLuWxsIiqdgRCPsy/4SnZizidRxTIF/FJe4q4Cn+VyhLB9ellwWMhDvP
   wodHsdyzFY0BlkLOkYtkylMjys55MN/abYICC0WpcRRNh+OwDybyCqJB1
   x26ZD829UGiZemSlraCk7om13PhWOxBqggSvcYyqJiwfhgBwvp5RhIB3h
   S615vOSEylbjwv3uTm/9M9/PrnIwfgJR8olvzNRYwzGNi8MGuwt4EYAX0
   A==;
Received: from unknown (HELO opfedv1rlp0h.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2024 14:24:57 +0200
Received: from unknown (HELO OPE16NORMBX104.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv1rlp0h.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 14:24:57 +0200
Received: from [x.x.x.x] [x.x.x.x] by OPE16NORMBX104.corporate.adroot.infra.ftgroup
 [x.x.x.x] with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39;
 Sun, 25 Aug 2024 14:24:57 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.10,175,1719871200"; 
   d="scan'208";a="182570433"
Message-ID: <0f970f70-abea-4b79-bf62-852853b0137e@orange.com>
Date: Sun, 25 Aug 2024 14:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v2] Fix race for duplicate reqsk on identical SYN
To: luoxuanqiang <luoxuanqiang@kylinos.cn>, <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <fw@strlen.de>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
References: <20240614102628.446642-1-luoxuanqiang@kylinos.cn>
 <1718586352627144.1.seg@mailgw.kylinos.cn>
 <7b700f6e-3ad7-a358-8dd3-c5120a115344@kylinos.cn>
 <e3e34c63-d44b-4329-acef-a7adc7024b92@orange.com>
Content-Language: fr, en-US
In-Reply-To: <e3e34c63-d44b-4329-acef-a7adc7024b92@orange.com>
X-ClientProxiedBy: OPE16NORMBX104.corporate.adroot.infra.ftgroup (10.115.26.5)
 To OPE16NORMBX104.corporate.adroot.infra.ftgroup (10.115.26.5)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTcvMDYvMjAyNCAxNjo0NCwgQWxleGFuZHJlIEZlcnJpZXV4IHdyb3RlOg0KPiBPbiAxNy8w
Ni8yMDI0IDA0OjUzLCBsdW94dWFucWlhbmcgd3JvdGU6DQo+Pg0KPj4g5ZyoIDIwMjQvNi8xNyAw
Nzo0NSwgYWxleGFuZHJlLmZlcnJpZXV4QG9yYW5nZS5jb20g5YaZ6YGTOg0KPj4+IE9uIDE0LzA2
LzIwMjQgMTI6MjYsIGx1b3h1YW5xaWFuZyB3cm90ZToNCj4+Pj4gV2hlbiBib25kaW5nIGlzIGNv
bmZpZ3VyZWQgaW4gQk9ORF9NT0RFX0JST0FEQ0FTVCBtb2RlLCBpZiB0d28gaWRlbnRpY2FsDQo+
Pj4+IFNZTiBwYWNrZXRzIGFyZSByZWNlaXZlZCBhdCB0aGUgc2FtZSB0aW1lIGFuZCBwcm9jZXNz
ZWQgb24gZGlmZmVyZW50IENQVXMsDQo+Pj4+IGl0IGNhbiBwb3RlbnRpYWxseSBjcmVhdGUgdGhl
IHNhbWUgc2sgKHNvY2spIGJ1dCB0d28gZGlmZmVyZW50IHJlcXNrDQo+Pj4+IChyZXF1ZXN0X3Nv
Y2spIGluIHRjcF9jb25uX3JlcXVlc3QoKS4NCj4+Pj4NCj4+Pj4gVGhlc2UgdHdvIGRpZmZlcmVu
dCByZXFzayB3aWxsIHJlc3BvbmQgd2l0aCB0d28gU1lOQUNLIHBhY2tldHMsIGFuZCBzaW5jZQ0K
Pj4+PiB0aGUgZ2VuZXJhdGlvbiBvZiB0aGUgc2VxIChJU04pIGluY29ycG9yYXRlcyBhIHRpbWVz
dGFtcCwgdGhlIGZpbmFsIHR3bw0KPj4+PiBTWU5BQ0sgcGFja2V0cyB3aWxsIGhhdmUgZGlmZmVy
ZW50IHNlcSB2YWx1ZXMuDQo+Pj4+DQo+Pj4+IFRoZSBjb25zZXF1ZW5jZSBpcyB0aGF0IHdoZW4g
dGhlIENsaWVudCByZWNlaXZlcyBhbmQgcmVwbGllcyB3aXRoIGFuIEFDSw0KPj4+PiB0byB0aGUg
ZWFybGllciBTWU5BQ0sgcGFja2V0LCB3ZSB3aWxsIHJlc2V0KFJTVCkgaXQuDQo+Pj4+DQo+Pj4+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPj4+IFRoaXMgaXMgY2xvc2UsIGJ1dCBub3QgaWRlbnRpY2FsLCB0
byBhIHJhY2Ugd2Ugb2JzZXJ2ZWQgb24gYSAqc2luZ2xlKiBDUFUgd2l0aA0KPj4+IHRoZSBUUFJP
WFkgaXB0YWJsZXMgdGFyZ2V0LCBpbiB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbjoNCj4+Pg0KPj4+
IMKgLSB0d28gaWRlbnRpY2FsIFNZTnMsIHNlbnQgb25lIHNlY29uZCBhcGFydCBmcm9tIHRoZSBz
YW1lIGNsaWVudCBzb2NrZXQsDQo+Pj4gwqDCoCBhcnJpdmUgYmFjay10by1iYWNrIG9uIHRoZSBp
bnRlcmZhY2UgKGR1ZSB0byBuZXR3b3JrIGppdHRlcikNCj4+Pg0KPj4+IMKgLSB0aGV5IGhhcHBl
biB0byBiZSBoYW5kbGVkIGluIHRoZSBzYW1lIGJhdGNoIG9mIHBhY2tldCBmcm9tIG9uZSBzb2Z0
aXJxDQo+Pj4gwqDCoCBuYW1lX3lvdXJfbmljX3BvbGwoKQ0KPj4+DQo+Pj4gwqAtIHRoZXJlLCB0
d28gbG9vcHMgcnVuIHNlcXVlbnRpYWxseTogb25lIGZvciBuZXRmaWx0ZXIgKGRvaW5nIFRQUk9Y
WSksIG9uZQ0KPj4+IMKgwqAgZm9yIHRoZSBuZXR3b3JrIHN0YWNrIChkb2luZyBUQ1AgcHJvY2Vz
c2luZykNCj4+Pg0KPj4+IMKgLSB0aGUgZmlyc3QgZ2VuZXJhdGVzIHR3byBkaXN0aW5jdCBjb250
ZXh0cyBmb3IgdGhlIHR3byBTWU5zDQo+Pj4NCj4+PiDCoC0gdGhlIHNlY29uZCByZXNwZWN0cyB0
aGVzZSBjb250ZXh0cyBhbmQgbmV2ZXIgZ2V0cyBhIGNoYW5jZSB0byBtZXJnZSB0aGVtDQo+Pj4N
Cj4+PiBUaGUgcmVzdWx0IGlzIGV4YWN0bHkgYXMgeW91IGRlc2NyaWJlLCBidXQgaW4gdGhpcyBj
YXNlIHRoZXJlIGlzIG5vIG5lZWQgZm9yIA0KPj4+IGJvbmRpbmcsDQo+Pj4gYW5kIGV2ZXJ5dGhp
bmcgaGFwcGVucyBpbiBvbmUgc2luZ2xlIENQVSwgd2hpY2ggaXMgcHJldHR5IGlyb25pYyBmb3Ig
YSByYWNlLg0KPj4+IE15IHVuZWR1Y2F0ZWQgZmVlbGluZyBpcyB0aGF0IHRoZSB0d28gbG9vcHMg
YXJlIHRoZSBjYXVzZSBvZiBhIHNpbXVsYXRlZA0KPj4+IHBhcmFsbGVsaXNtLCB5aWVsZGluZyB0
aGUgcmFjZS4gSWYgZWFjaCBwYWNrZXQgb2YgdGhlIGJhdGNoIHdhcyBoYW5kbGVkDQo+Pj4gInRv
IGNvbXBsZXRpb24iIChmdWxsIG5ldGZpbHRlciBoYW5kbGluZyBmb2xsb3dlZCBpbW1lZGlhdGVs
eSBieSBmdWxsIG5ldHdvcmsNCj4+PiBzdGFjayBpbmdlc3Rpb24pLCB0aGUgcHJvYmxlbSB3b3Vs
ZCBub3QgZXhpc3QuDQo+Pg0KPj4gQmFzZWQgb24geW91ciBleHBsYW5hdGlvbiwgSSBiZWxpZXZl
IGENCj4+IHNpbWlsYXIgaXNzdWUgY2FuIG9jY3VyIG9uIGEgc2luZ2xlIENQVSBpZiB0d28gU1lO
IHBhY2tldHMgYXJlIHByb2Nlc3NlZA0KPj4gwqDCoGNsb3NlbHkgZW5vdWdoLiBIb3dldmVyLCBh
cGFydCBmcm9tIHVzaW5nIGJvbmQzIG1vZGUgYW5kIGhhdmluZyB0aGVtDQo+PiBwcm9jZXNzZWQg
b24gZGlmZmVyZW50IENQVXMgdG8gZmFjaWxpdGF0ZSByZXByb2R1Y2liaWxpdHksIEkgaGF2ZW4n
dA0KPj4gZm91bmQgYSBnb29kIHdheSB0byByZXBsaWNhdGUgaXQuDQo+Pg0KPj4gQ291bGQgeW91
IHBsZWFzZSBwcm92aWRlIGEgbW9yZSBwcmFjdGljYWwgZXhhbXBsZSBvciBkZXRhaWxlZCB0ZXN0
DQo+PiBzdGVwcyB0byBoZWxwIG1lIHVuZGVyc3RhbmQgdGhlIHJlcHJvZHVjdGlvbiBzY2VuYXJp
byB5b3UgbWVudGlvbmVkPw0KPj4gVGhhbmsgeW91IHZlcnkgbXVjaCENCj4gDQo+IFRvIHJlcHJv
ZHVjZSBpbiBteSBjYXNlLCBJIGp1c3QgbmVlZCB0aGUgdHdvIFNZTnMgdG8gYXJyaXZlIGJhY2st
dG8tYmFjayBpbiB0aGUgDQo+IGluZ3Jlc3MgYnVmZmVyIGFuZCBnZXQgaW4gdGhlIHNhbWUgc29m
dGlycSBydW4uIFRvIHJlYWNoIHRoaXMgZ29hbCBlYXNpbHksIHlvdSANCj4gY2FuIHNldCB0aGUg
aW50ZXJydXB0IGNvYWxlc2NlbmNlIHRvIGEgbGFyZ2UgdmFsdWUgKGxpa2Ugc2V2ZXJhbCBtaWxs
aXNlY29uZHMpLCANCj4gYW5kIG9uIHRoZSBlbWl0dGVyIHNpZGUsIHNlbmQgdGhlbSBpbiByYXBp
ZCBzZXF1ZW5jZSBmcm9tIHVzZXJsYW5kLiBJZiB0aGF0J3MgDQo+IG5vdCBlbm91Z2gsIHlvdSBj
YW4ganVzdCBzZW5kIG9uZSBhbmQgZHVwbGljYXRlIGl0IHdpdGggVEVFLg0KDQpHb29kIG5ld3M6
IGFzIEkgc3VzcGVjdGVkLCB5b3VyIGZpeCAoZmY0NmUzYjQ0MjE5IHNoaXBwZWQgaW4gNi4xMCkg
RE9FUyBzb2x2ZSBteSANCnByb2JsZW0gdG9vICENCg0KQXMgYSBjb25zZXF1ZW5jZSwgdGhpcyBt
ZWFucyB0aGUgc2luZ2xlLUNQVSBzY2VuYXJpbyB3YXMgZXhwb3NlZCB0b28sIHRocm91Z2ggDQpu
ZXRmaWx0ZXIncyBwZWN1bGlhciAiYnJlYWR0aC1maXJzdCIgaXRlcmF0aW9uIGFwcHJvYWNoLiBU
aGlzIGdpdmVzIGV4dHJhIHdlaWdodCANCnRvIHRoZSBpbXBvcnRhbmNlIG9mIHlvdXIgd29yay4N
Cg0KVEw7RFI6IHRoYW5rcywga3Vkb3MsIGNvbmdyYXRzLCBhbmQgdGhhbmtzICEhIQ0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpDZSBtZXNzYWdl
IGV0IHNlcyBwaWVjZXMgam9pbnRlcyBwZXV2ZW50IGNvbnRlbmlyIGRlcyBpbmZvcm1hdGlvbnMg
Y29uZmlkZW50aWVsbGVzIG91IHByaXZpbGVnaWVlcyBldCBuZSBkb2l2ZW50IGRvbmMNCnBhcyBl
dHJlIGRpZmZ1c2VzLCBleHBsb2l0ZXMgb3UgY29waWVzIHNhbnMgYXV0b3Jpc2F0aW9uLiBTaSB2
b3VzIGF2ZXogcmVjdSBjZSBtZXNzYWdlIHBhciBlcnJldXIsIHZldWlsbGV6IGxlIHNpZ25hbGVy
DQphIGwnZXhwZWRpdGV1ciBldCBsZSBkZXRydWlyZSBhaW5zaSBxdWUgbGVzIHBpZWNlcyBqb2lu
dGVzLiBMZXMgbWVzc2FnZXMgZWxlY3Ryb25pcXVlcyBldGFudCBzdXNjZXB0aWJsZXMgZCdhbHRl
cmF0aW9uLA0KT3JhbmdlIGRlY2xpbmUgdG91dGUgcmVzcG9uc2FiaWxpdGUgc2kgY2UgbWVzc2Fn
ZSBhIGV0ZSBhbHRlcmUsIGRlZm9ybWUgb3UgZmFsc2lmaWUuIE1lcmNpLg0KDQpUaGlzIG1lc3Nh
Z2UgYW5kIGl0cyBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmls
ZWdlZCBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBwcm90ZWN0ZWQgYnkgbGF3Ow0KdGhleSBzaG91
bGQgbm90IGJlIGRpc3RyaWJ1dGVkLCB1c2VkIG9yIGNvcGllZCB3aXRob3V0IGF1dGhvcmlzYXRp
b24uDQpJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGlzIG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2htZW50
cy4NCkFzIGVtYWlscyBtYXkgYmUgYWx0ZXJlZCwgT3JhbmdlIGlzIG5vdCBsaWFibGUgZm9yIG1l
c3NhZ2VzIHRoYXQgaGF2ZSBiZWVuIG1vZGlmaWVkLCBjaGFuZ2VkIG9yIGZhbHNpZmllZC4NClRo
YW5rIHlvdS4K


