Return-Path: <netdev+bounces-196664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9811AD5C89
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0AF3A2371
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC322040B0;
	Wed, 11 Jun 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="jSJEWJQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1C1F91C8
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.210.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660242; cv=none; b=tdNdcMhZ7oYowNMZPYZbWVbjpmRvVkrn6bVd5SRzsQxtIWfiJnOQx4hNbZ9CKOP+BvpHePd6PsuMxdUHJLmtv2YMpt45RTZ342dlFHVwdq89grHvK37sSZwJfqXG0g65pMSJjhbjbHiMLotKVElVB6SUSP6W2NyYYGZIE8BTr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660242; c=relaxed/simple;
	bh=3YXr9wgXUsFSuhHPd9WI4VArCCJ5s6LzpzP2MmesTL4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DP8W/tIPj7O4YmiJqUfGPsuaCP8Tv6Kb3oK0o729T4mYE8/evZ/rAkDUrGlDKBQEk3yc9/F1cQydZ2Y9GzvKJHj1MmD+4CzCY/6FE48A2EDVnwTxaqmhuM+cmTXjLaUqCW9CPKulwAyLPdUcSSWiNG135T6vFnRxmflT55hQExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=jSJEWJQv; arc=none smtp.client-ip=80.12.210.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1749660240; x=1781196240;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=3YXr9wgXUsFSuhHPd9WI4VArCCJ5s6LzpzP2MmesTL4=;
  b=jSJEWJQvIqOq0f3I1hgNixPXAF4hxbVeGf4HmJLb+osfmLNTFwl8WYwL
   JWxjNZDTMHw2ymoBeMOq/Vv5u9IBj0A1ywlZ83uZwl0Lkxafrj1EOdbh3
   w1cKaRGUnAkkt++iR2eyouHjd+pbudz4g2cqBXg8ZFimGt1t2jtsXiIxQ
   kjH4SH3HdZPEgxjLpoGnZlis/N3WlLnClcatpua6DtzjhNbDTOmaGrCuv
   Auqrd3Qmu6gMJM8nnh8dcj2W+R0pKCvVb83WDM+pIB1BGbFjyCzInWhID
   ioXKQKewvYTkBv0/ORToe3+B8SeY0DYNYWHqweIqeYqllQJnvj6KzX2l4
   Q==;
X-CSE-ConnectionGUID: Lg2HJaQNQsegeRWYMp/fEA==
X-CSE-MsgGUID: 2giMQT11TziVjp7mbn7rYQ==
Received: from unknown (HELO opfedv3rlp0e.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 18:42:50 +0200
Received: from test-mailhost.rd.francetelecom.fr (HELO l-mail-int) ([x.x.x.x]) by
 opfedv3rlp0e.nor.fr.ftgroup with ESMTP; 11 Jun 2025 18:42:50 +0200
Received: from lat6466.rd.francetelecom.fr ([x.x.x.x])	by l-mail-int with esmtp (Exim
 4.94.2)	(envelope-from <alexandre.ferrieux@orange.com>)	id 1uPOXJ-00447l-5w;
 Wed, 11 Jun 2025 18:42:49 +0200
From: alexandre.ferrieux@orange.com
X-CSE-ConnectionGUID: 3CZ2UY5TRJud1TGXfX/YvQ==
X-CSE-MsgGUID: q9C4VuaNQJaPctRHgA34JQ==
X-IronPort-AV: E=Sophos;i="6.16,228,1744063200"; 
   d="scan'208";a="299439109"
Message-ID: <9119ef86-b274-4ab0-b67c-c798314fbd12@orange.com>
Date: Wed, 11 Jun 2025 18:42:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG iproute2] Netkit unusable in batch mode
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <4c0389de-1e74-46f8-9ce8-4927241fd35c@orange.com>
 <1cfae3f3-d1cf-413e-8659-a6bd72b03a71@iogearbox.net>
Content-Language: fr, en-US
In-Reply-To: <1cfae3f3-d1cf-413e-8659-a6bd72b03a71@iogearbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRGFuaWVsLAoKT24gNi8xMS8yNSAxNjowNywgRGFuaWVsIEJvcmttYW5uIHdyb3RlOgo+IAo+
PiBJcyB0aGVyZSBhIHNjZW5hcmlvIHdoZXJlCj4+IG5ldGtpdF9wYXJzZV9vcHQoKSBpcyBjYWxs
ZWQgc2V2ZXJhbCB0aW1lcyBpbiBhIHNpbmdsZSBjb21tYW5kLCBidXQgaW4gYQo+PiBzdGF0ZWZ1
bCBtYW5uZXIgPwo+IAo+IFRoaXMgd2FzIGJhc2ljYWxseSBiZWNhdXNlIHdlIGNhbGwgaW50byBp
cGxpbmtfcGFyc2UoKSBhZnRlciAicGVlciIgdG8gZ2F0aGVyIHNldHRpbmdzCj4gZm9yIHRoZSBw
ZWVyIHNpbWlsYXIgdG8gbGlua192ZXRoLmMgbW9kdWxvIHRoYXQgbmV0a2l0IGhhcyBtb2RlL3Bv
bGljeS9zY3J1YiBzZXR0aW5ncwo+IGFuZCB3ZSBvbmx5IHdhbnQgdGhlbSB0byBiZSBwcmVzZW50
IG9uY2UgZm9yIGEgc2luZ2xlICdsaW5rIGFkZCcgY2FsbC4gTWlnaHQgYmUgYmV0dGVyCj4gdG8g
anVzdCByZXNldCB0aGUgYWJvdmUgYmVmb3JlIHRoZSAnZ290byBvdXRfb2snIGFmdGVyIHBhcnNp
bmcgcGVlci4gQ291bGQgeW91IGNvb2sgYQo+IHBhdGNoIGZvciB0aGF0IGluc3RlYWQ/CgpBaCwg
SSBzZWUuLi4gUmVjdXJzaW9uIGluc3RlYWQgb2YgaXRlcmF0aW9uOyB0aGF0J3MgZWxlZ2FudCB1
bnRpbCB5b3UgbmVlZApzdGF0ZWZ1bCBjb2RlIDp9IFRvIGJlIGhvbmVzdCwgdG8gbWUgaXQncyBy
YXRoZXIgYW4gYW50aS1pZGlvbSAoY29taW5nIGZyb20KdmV0aCkgdG8gYmUgZml4ZWQgcmF0aGVy
IHRoYW4gcmVwZWF0ZWQuLi4KCkFueXdheSwgSSBkaWQgYXMgeW91IHN1Z2dlc3QsIGJ1dCBteSBo
YW5kIGlzIHVuc3RlYWR5IGFzIHRoZSBjb2RlIGxhY2tzIHN5bW1ldHJ5CmFuZCB0aG91Z2ggSSB0
cmllZCB0byByZXNldCAiZGF0YSIgcHJvcGVybHksIEknbSBub3Qgc3VyZSBJIGRpZC4gUGxlYXNl
IHJldmlldy4KCi0tLS0tCmRpZmYgLS1naXQgYS9pcC9pcGxpbmtfbmV0a2l0LmMgYi9pcC9pcGxp
bmtfbmV0a2l0LmMKaW5kZXggODE4ZGExMTkuLjI1OTU3MzE2IDEwMDY0NAotLS0gYS9pcC9pcGxp
bmtfbmV0a2l0LmMKKysrIGIvaXAvaXBsaW5rX25ldGtpdC5jCkBAIC0xMjUsNiArMTI1LDggQEAg
c3RhdGljIGludCBuZXRraXRfcGFyc2Vfb3B0KHN0cnVjdCBsaW5rX3V0aWwgKmx1LCBpbnQgYXJn
YywKY2hhciAqKmFyZ3YsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0eXBlKQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHVwYXJnKCJ0eXBlIiwgYXJndltl
cnJdKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWVuX3BlZXIgPSBmYWxzZTsK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWVuX21vZGUgPSBmYWxzZTsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9vazsKICAgICAgICAgICAgICAgICAg
ICAgICAgfQogICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIiVzOiB1bmtu
b3duIG9wdGlvbiBcIiVzXCI/XG4iLApAQCAtMTQ2LDYgKzE0OCw3IEBAIG91dF9vazoKICAgICAg
ICBpZm0tPmlmaV9mbGFncyA9IGlmaV9mbGFnczsKICAgICAgICBpZm0tPmlmaV9jaGFuZ2UgPSBp
ZmlfY2hhbmdlOwogICAgICAgIGlmbS0+aWZpX2luZGV4ID0gaWZpX2luZGV4OworICAgICAgIGRh
dGEgPSBOVUxMOwogICAgICAgIHJldHVybiAwOwogfQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpDZSBtZXNzYWdlIGV0IHNlcyBwaWVjZXMgam9p
bnRlcyBwZXV2ZW50IGNvbnRlbmlyIGRlcyBpbmZvcm1hdGlvbnMgY29uZmlkZW50aWVsbGVzIG91
IHByaXZpbGVnaWVlcyBldCBuZSBkb2l2ZW50IGRvbmMNCnBhcyBldHJlIGRpZmZ1c2VzLCBleHBs
b2l0ZXMgb3UgY29waWVzIHNhbnMgYXV0b3Jpc2F0aW9uLiBTaSB2b3VzIGF2ZXogcmVjdSBjZSBt
ZXNzYWdlIHBhciBlcnJldXIsIHZldWlsbGV6IGxlIHNpZ25hbGVyDQphIGwnZXhwZWRpdGV1ciBl
dCBsZSBkZXRydWlyZSBhaW5zaSBxdWUgbGVzIHBpZWNlcyBqb2ludGVzLiBMZXMgbWVzc2FnZXMg
ZWxlY3Ryb25pcXVlcyBldGFudCBzdXNjZXB0aWJsZXMgZCdhbHRlcmF0aW9uLA0KT3JhbmdlIGRl
Y2xpbmUgdG91dGUgcmVzcG9uc2FiaWxpdGUgc2kgY2UgbWVzc2FnZSBhIGV0ZSBhbHRlcmUsIGRl
Zm9ybWUgb3UgZmFsc2lmaWUuIE1lcmNpLg0KDQpUaGlzIG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiB0
aGF0IG1heSBiZSBwcm90ZWN0ZWQgYnkgbGF3Ow0KdGhleSBzaG91bGQgbm90IGJlIGRpc3RyaWJ1
dGVkLCB1c2VkIG9yIGNvcGllZCB3aXRob3V0IGF1dGhvcmlzYXRpb24uDQpJZiB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5k
IGRlbGV0ZSB0aGlzIG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2htZW50cy4NCkFzIGVtYWlscyBtYXkg
YmUgYWx0ZXJlZCwgT3JhbmdlIGlzIG5vdCBsaWFibGUgZm9yIG1lc3NhZ2VzIHRoYXQgaGF2ZSBi
ZWVuIG1vZGlmaWVkLCBjaGFuZ2VkIG9yIGZhbHNpZmllZC4NClRoYW5rIHlvdS4K


