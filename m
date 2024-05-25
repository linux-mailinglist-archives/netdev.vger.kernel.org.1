Return-Path: <netdev+bounces-98073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD78CF160
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 22:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9770CB20D4B
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7E127B5F;
	Sat, 25 May 2024 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="fQPuZEg/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.126.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFF4E1C3;
	Sat, 25 May 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.126.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716670640; cv=none; b=OaN2DV91nx4n5mecMNPtQKcu3QW5ChJt5iYDt+e2+GyejzOaZ+zD+9Y9B77Xh9WDwbMdtu7XjwuO5FdhnxVKGtp59SS301KyJw0icc83Mg0dEbYZhsn8cnq8/xWUGWnxsoQDXSeToezHqb9MTwxldC78mkv7uuR6u0sAOkOb/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716670640; c=relaxed/simple;
	bh=vXs1xsSuDvhbu9fGviw/sbbEK2nBU38gIw01lU2p3ks=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=mnbfB8PNoNtSWWRqAPHFsNC6Fah+DLNFD6IXBTpLYPAU+enOBbhEZr1UDIq6WaaXJMpFVX770kTH04E0S1sDQqeC2Gm1RqqIF5wJI/E38nVsVzCKGZSnWVn+8K9b52PCNZ5cfZImOGYaXwqtRwUFOtzFRi/2GSWZvRonlAPbKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=fQPuZEg/; arc=none smtp.client-ip=80.12.126.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1716670638; x=1748206638;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=vXs1xsSuDvhbu9fGviw/sbbEK2nBU38gIw01lU2p3ks=;
  b=fQPuZEg/tXxN3Red9f49NWZ7xglhI5VJuyoaba8gJlY4qcLd5BcNifiJ
   Y0uJLwhP8KHrVxjXttpI2b3BPz9vXqTs8mwLfwmg6TV2bYvlSS50HR3Ge
   1a8rcN/FOkNfebhEpxvMdisw+/tX3fwrDb+gP9VhC8T8KxWPJxaWrUDed
   440TyXWOaZbpFIMjm9M+C3K16co/hAEwka9nW68kUg8rq6JlvDXyL3LVc
   3MPgwDVSPli34TsYjZ2BtxxgXydPmejqyFFz8ml1AzFqXcar1gQIl1Cfw
   SoxLoJTZDvlOd4hmcJgBeoMGMtk0QQ/a2oGP+4jNxia9qQUFubJBtgcq1
   A==;
Received: from unknown (HELO opfedv1rlp0c.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2024 22:56:07 +0200
Received: from unknown (HELO OPE16NORMBX104.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv1rlp0c.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2024 22:56:06 +0200
Received: from [x.x.x.x] [x.x.x.x] by OPE16NORMBX104.corporate.adroot.infra.ftgroup
 [x.x.x.x] with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37;
 Sat, 25 May 2024 22:56:06 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.08,189,1712613600"; 
   d="scan'208";a="147185672"
Message-ID: <3acef339-cdeb-407c-b643-0481bfbe3c80@orange.com>
Date: Sat, 25 May 2024 22:55:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Chengen Du
	<chengen.du@canonical.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
 <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
 <66520906120ae_215a8029466@willemb.c.googlers.com.notmuch>
Content-Language: fr, en-US
In-Reply-To: <66520906120ae_215a8029466@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: OPE16NORMBX204.corporate.adroot.infra.ftgroup (10.115.26.9)
 To OPE16NORMBX104.corporate.adroot.infra.ftgroup (10.115.26.5)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMjUvMDUvMjAyNCAxNzo1MSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiAKPiBGaXJzdCwg
d2UgbmVlZCB0byBldmVuIHVuZGVyc3RhbmQgYmV0dGVyIHdoeSBhbnl0aGluZyBpcyB1c2luZwo+
IFNPQ0tfREdSQU0gd2hlbiBhY2Nlc3MgdG8gTDIuNSBoZWFkZXJzIGlzIGltcG9ydGFudCwgYW5k
IHdoZXRoZXIgdGhlCj4gcHJvY2VzcyBjYW4gY29udmVydCB0byB1c2luZyBTT0NLX1JBVyBpbnN0
ZWFkLgoKRm9yIGxpYnBjYXAsIGl0IHNlZW1zIHRvIGJlIGxpbmtlZCB0byB0aGUgZmFjdCB0aGF0
IHRoZSAiYW55IiBkZXZpY2UgY2FuIAphZ2dyZWdhdGUgbGlua3Mgd2l0aCB2YXJpZWQgTDIgaGVh
ZGVyIHNpemVzLCB3aGljaCBpbiB0dXJuIGNvbXBsaWNhdGVzIGZpbHRlcmluZyAKKHNlZSBHdXkg
SGFycmlzJyBjb21tZW50IG9uIHRoaXMgWzFdKS4KCkdpdmVuIHRoYXQgOTklIG9mIHVzZWZ1bCB0
cmFmZmljIGlzIEV0aGVybmV0LCBzdWNoIGNvbnNpZGVyYXRpb25zIGxvb2sgYXdrd2FyZCAKbm93
LiBJIGZvciBvbmUgd291bGQgbG92ZSB0byBzZWUgYW4gImFueTIiIGJhc2VkIG9uIFNPQ0tfUkFX
LiBBbmQgd2hpbGUgeW91J3JlIAphdCBpdCwgcGxlYXNlIGxldCB0aGUgbmV3IHZhcmlhbnQgb2Yg
U0xMIGNvbnRhaW4gdGhlIGZ1bGwgRXRoZXJuZXQgaGVhZGVyIGF0IHRoZSAKZW5kLCBzbyB0aGF0
IGEgc2ltcGxlIG9mZnNldCBnaXZlcyBhY2Nlc3MgdG8gdGhlIHdob2xlIGxpbmVhciB3aXJlIGlt
YWdlLi4uCgotQWxleAoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90aGUtdGNwZHVtcC1ncm91cC9s
aWJwY2FwL2lzc3Vlcy8xMTA1I2lzc3VlY29tbWVudC0xMDkyMjIxNzg1Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KQ2UgbWVzc2FnZSBldCBzZXMg
cGllY2VzIGpvaW50ZXMgcGV1dmVudCBjb250ZW5pciBkZXMgaW5mb3JtYXRpb25zIGNvbmZpZGVu
dGllbGxlcyBvdSBwcml2aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBkb25jDQpwYXMgZXRyZSBkaWZm
dXNlcywgZXhwbG9pdGVzIG91IGNvcGllcyBzYW5zIGF1dG9yaXNhdGlvbi4gU2kgdm91cyBhdmV6
IHJlY3UgY2UgbWVzc2FnZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBsZSBzaWduYWxlcg0KYSBsJ2V4
cGVkaXRldXIgZXQgbGUgZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBwaWVjZXMgam9pbnRlcy4gTGVz
IG1lc3NhZ2VzIGVsZWN0cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGlibGVzIGQnYWx0ZXJhdGlvbiwN
Ck9yYW5nZSBkZWNsaW5lIHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNpIGNlIG1lc3NhZ2UgYSBldGUg
YWx0ZXJlLCBkZWZvcm1lIG91IGZhbHNpZmllLiBNZXJjaS4NCg0KVGhpcyBtZXNzYWdlIGFuZCBp
dHMgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5m
b3JtYXRpb24gdGhhdCBtYXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsNCnRoZXkgc2hvdWxkIG5vdCBi
ZSBkaXN0cmlidXRlZCwgdXNlZCBvciBjb3BpZWQgd2l0aG91dCBhdXRob3Jpc2F0aW9uLg0KSWYg
eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMuDQpBcyBl
bWFpbHMgbWF5IGJlIGFsdGVyZWQsIE9yYW5nZSBpcyBub3QgbGlhYmxlIGZvciBtZXNzYWdlcyB0
aGF0IGhhdmUgYmVlbiBtb2RpZmllZCwgY2hhbmdlZCBvciBmYWxzaWZpZWQuDQpUaGFuayB5b3Uu
Cg==


