Return-Path: <netdev+bounces-257566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCbUMcT/hWnUIwQAu9opvQ
	(envelope-from <netdev+bounces-257566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E7AFF2BC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE8D63002520
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923C636C0DC;
	Fri,  6 Feb 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSY/YnxP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4D296BB8
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389398; cv=none; b=Ypo0KggMyhVxyv9O9AJheHyv0XL3FWxYkujI9VgAJD4GzIYxdhNq1eU72toP8nUoEvoPowHtZlUQKq/ljpG4QaMS4uNss6jdCelYFwHO/t3eLwW7bXk0AD34Xf2KstyG4QIGMMv1wCI2sxyr6PAVROYBFobv+9APTQPeUaNFnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389398; c=relaxed/simple;
	bh=mDFKG1QTYSXTQ75qgXvXP5UTGx32pKbuhpyLoa5/Im4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psZzaacJII1R7oD/43i2AM/l6nVLuc9jA+yh0q16yPNvO0Ua9N3b4XxRH659VvVUo3UK//4ZTVma9nDFCiL+SttNud0We6gn+sqaI1sIFZIqG2pSppFVTXFDbJrbARgpERTlTZv/lSdauwIIhcAggRfhNDgY56vaesH9MMarXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSY/YnxP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c70cedff8dso19145585a.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770389397; x=1770994197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDFKG1QTYSXTQ75qgXvXP5UTGx32pKbuhpyLoa5/Im4=;
        b=YSY/YnxPx8fAb6120YgVa3IgISTYHhaJZNzTHf+niFe/aA0p5GvdnPGXR/+2wjXOet
         NseFfb1q3UsP7BIazhwxu0WN6VRs9yvht1mwzvZ+bAYuyncsNg8rgalEKaMp46gXkCd9
         MLq+bAFBJ0j3OzmqxaJfXd2ESyfKAZU7yY/nXy3J083ksviC2S1+sZiDbCgcdmk/XfKt
         szNMlIn0qDswwHT3ljjQ19eGMwNmzrI/kAlNVYLoDLppglTiQN44R11oyoF4JjGS9pjr
         M2qOGZOcF3IFSpOyJ0Y6ZLUbZLtcDZMbWzMlHcmXlFkz9zCYnualJ5hCLDnC9BRHdTeW
         st+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389397; x=1770994197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDFKG1QTYSXTQ75qgXvXP5UTGx32pKbuhpyLoa5/Im4=;
        b=hbrchrgt71sjpxzLoN1XndwTx4zc4RzLCzsoTMFirfF2xymogfBI1ppCA5gj947plQ
         OQAsAd5mpzBduarAf2sh2AvXYizqawdQW+5m9IZZwMSaicXh4VdTZ7mZO/oE/5gpH2sl
         JrA2jDOk0D7GkkFPKs9bna+11iy5LBBxIWK6eTAAETCKiRDaruPcNL6TeSYyTyX/O5QU
         ey4isFSwQuho+M1x45dW5GX6gBaloMB9NxCOIW7yUJ63UcbLL/Mkf1uqysfU1AS+CcW5
         WUHvDK+3RYxH0sr+06HSd5Mx9GvaGmgHYXsOjRAio4s/jPlZNsy15mEWk3HEyM5HzEZw
         x39g==
X-Forwarded-Encrypted: i=1; AJvYcCViT1c2ifFVRPRMxFjch/1McFq55fRUVGbDlMF51JN3nOzZemy+jgO8fhq64ONbMa1BVe9yZTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+v7bcg4/+A8UZ8UsPuTZEcQg4BqznWVZHDfRZPBtyV2sJa78
	2oeJqIngxVbeIMqqBz3b+gw9pQtAxb6HONvd3WQu7Nq0fhipLknHGdL+
X-Gm-Gg: AZuq6aKeYIpNGqPzyaVPh9PVbWdy91SDz4t5fwQ1haLWKZwkA5+OvFBMCV/1GFxDYM5
	gYjga7tZyzXmvjlx7OneMpG2khimFQ0IBlwcyX11WO/qQKsEwFnsL99uT5SHT/+9qxx6lAR+JGf
	Z7nk239FTpSqevylAlJkGj0Mm0gHNOHU4knbeI+DYJgRJ1bpBiwNkEH4Cc7i+bMoMzsgkKbEOaD
	Bp9LlpuM+2Zycq+vmqXguKQRh/eTDW/NeAbse6fuS4XyUhATm5Gf3ZWxzyaJfZllyIE/EGKrLMn
	MGOW4vb+/BvLSqO2KmYZOfZj0/d49JLrE9SoMhMylzUuSY7B2jWnyeXIvVwXMkVnHKzEoc+DJ1J
	/iQ3VzAesDKvnsi5sijzTb2Ba0tlv6C6oZi7E9sMIqxODhgd/BpyYrUSLbWyU1tPm/MVZQIJhDR
	0jToC4LOdlZS+k9cbQL4OSf8NAn4Z49vtBhbPB1H1wn5j5C8xXgb2s/m4=
X-Received: by 2002:a05:620a:d88:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8caf0d3d18emr303055185a.9.1770389396839;
        Fri, 06 Feb 2026 06:49:56 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59? ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cafa3bf628sm184574085a.48.2026.02.06.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 06:49:56 -0800 (PST)
Message-ID: <8d2fdbf6-abec-218e-1d07-fb08fb0772fe@gmail.com>
Date: Fri, 6 Feb 2026 09:49:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] net: sunhme: Fix sbus regression
Content-Language: en-US
To: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactco.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org
References: <20260205.170959.89574674688839340.rene@exactco.de>
 <cc269d9f-9a06-6623-e412-d04ecb7b4f74@gmail.com>
 <20260206.100514.85172532893288505.rene@exactco.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260206.100514.85172532893288505.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257566-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanga2@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exactco.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1f:email]
X-Rspamd-Queue-Id: 53E7AFF2BC
X-Rspamd-Action: no action

T24gMi82LzI2IDA0OjA1LCBSZW7DqSBSZWJlIHdyb3RlOg0KPiBPbiBUaHUsIDUgRmViIDIw
MjYgMjA6NDE6MTEgLTA1MDAsIFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPiB3
cm90ZToNCj4gDQo+PiBPbiAyLzUvMjYgMTE6MDksIFJlbsOpIFJlYmUgd3JvdGU6DQo+Pj4g
Q29tbWl0IGNjMjE2ZTRiNDRjZSAoIm5ldDogc3VuaG1lOiBTd2l0Y2ggU0JVUyB0byBkZXZy
ZXMiKSBjaGFuZ2VkDQo+Pj4gZXhwbGljaXQgc2l6ZWQgb2ZfaW9yZW1hcCB3aXRoIEJNQUNf
UkVHX1NJWkVzIHRvDQo+Pj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIG1hcHBp
bmcgYWxsIHRoZSByZXNvdXJjZS4gSG93ZXZlciwNCj4+PiB0aGlzIGRvZXMgbm90IHdvcmsg
b24gbXkgU3VuIFVsdHJhIDIgd2l0aCBTQlVTIEhNRXM6DQo+Pj4gaG1lIGYwMDcyZjM4OiBl
cnJvciAtRUJVU1k6IGNhbid0IHJlcXVlc3QgcmVnaW9uIGZvciByZXNvdXJjZSBbbWVtDQo+
Pj4gMHgxZmZlOGMwNzAwMC0weDFmZmU4YzA3MDFmXQ0KPj4+IGhtZSBmMDA3MmYzODogQ2Fu
bm90IG1hcCBUQ1ZSIHJlZ2lzdGVycy4NCj4+PiBobWUgZjAwNzJmMzg6IHByb2JlIHdpdGgg
ZHJpdmVyIGhtZSBmYWlsZWQgd2l0aCBlcnJvciAtMTYNCj4+PiBobWUgZjAwN2FiNDQ6IGVy
cm9yIC1FQlVTWTogY2FuJ3QgcmVxdWVzdCByZWdpb24gZm9yIHJlc291cmNlIFttZW0NCj4+
PiAweDFmZjI4YzA3MDAwLTB4MWZmMjhjMDcwMWZdDQo+Pj4gaG1lIGYwMDdhYjQ0OiBDYW5u
b3QgbWFwIFRDVlIgcmVnaXN0ZXJzLg0KPj4+IGhtZSBmMDA3YWI0NDogcHJvYmUgd2l0aCBk
cml2ZXIgaG1lIGZhaWxlZCB3aXRoIGVycm9yIC0xNg0KPj4+IFR1cm5zIG91dCB0aGUgb3Bl
bi1maXJtd2FyZSByZXNvdXJjZXMgb3ZlcmxhcCwgYXQgbGVhc3Qgb24gdGhpcw0KPj4+IG1h
Y2hpbmVzIGFuZCBQUk9NIHZlcnNpb246DQo+Pj4gaGV4ZHVtcCAvcHJvYy9kZXZpY2UtdHJl
ZS9zYnVzQDFmLDAvU1VOVyxobWVAMiw4YzAwMDAwL3JlZzoNCj4+PiAwMCAwMCAwMCAwMiAw
OCBjMCAwMCAwMCAgMDAgMDAgMDEgMDgNCj4+PiAwMCAwMCAwMCAwMiAwOCBjMCAyMCAwMCAg
MDAgMDAgMjAgMDANCj4+PiAwMCAwMCAwMCAwMiAwOCBjMCA0MCAwMCAgMDAgMDAgMjAgMDAN
Cj4+PiAwMCAwMCAwMCAwMiAwOCBjMCA2MCAwMCAgMDAgMDAgMjAgMDANCj4+PiAwMCAwMCAw
MCAwMiAwOCBjMCA3MCAwMCAgMDAgMDAgMDAgMjANCj4+PiBBbmQgdGhlIGRyaXZlciBwcmV2
aW91c2x5IGV4cGxpY2l0bHkgbWFwcGVkIHdheSBzbWFsbGVyIG1taW8gcmVnaW9uczoNCj4+
PiAvcHJvYy9pb21lbToNCj4+PiAxZmYyOGMwMDAwMC0xZmYyOGMwMDEwNyA6IEhNRSBHbG9i
YWwgUmVncw0KPj4+IDFmZjI4YzAyMDAwLTFmZjI4YzAyMDMzIDogSE1FIFRYIFJlZ3MNCj4+
PiAxZmYyOGMwNDAwMC0xZmYyOGMwNDAxZiA6IEhNRSBSWCBSZWdzDQo+Pj4gMWZmMjhjMDYw
MDAtMWZmMjhjMDYzNWYgOiBITUUgQklHTUFDIFJlZ3MNCj4+PiAxZmYyOGMwNzAwMC0xZmYy
OGMwNzAxZiA6IEhNRSBUcmFuY2VpdmVyIFJlZ3MNCj4+PiBRdWlyayB0aGlzIHNwZWNpZmlj
IGlzc3VlIGJ5IHRydW5jYXRpbmcgdGhlIHByZXZpb3VzIHJlc291cmNlIHRvIG5vdA0KPj4+
IG92ZXJsYXAgaW50byB0aGUgVENWUiByZWdpc3RlcnMuDQo+Pj4gRml4ZXM6IGNjMjE2ZTRi
NDRjZSAoIm5ldDogc3VuaG1lOiBTd2l0Y2ggU0JVUyB0byBkZXZyZXMiKQ0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFJlbsOpIFJlYmUgPHJlbmVAZXhhY3Rjby5kZT4NCj4+PiAtLS0NCj4+PiBU
ZXN0ZWQgb24gU3VuIFVsdHJhIDIgcnVubmluZyBUMi9MaW51eC4NCj4+PiBBbHRlcm5hdGl2
ZWx5IHdlIGNvdWxkIGV4cGxpY2l0bHkgc2l6ZSBhbGwgcmVnaW9ucywgb3IgY2hlY2sgb3Zl
cmxhcA0KPj4+IGluIHN0YXJ0dXAgY29kZSAoSSBhbHNvIGFscmVhZHkgaGF2ZSBhIHBhdGNo
IGZvciB0aGF0LCB0b28pLg0KPj4NCj4+IFdoYXQgZG9lcyB0aGlzIGxvb2sgbGlrZT8NCj4g
DQo+IFRoaXMgb25seSBjaGVja3MgZm9yICJzb3J0ZWQiIG92ZXJsYXBzIHcvIHRoZSBwcmV2
aW91cyByZXMsIGJ1dCBnaXZlbg0KPiB0aGV5IHByb2JhYmx5IHVzdWFsbHkgYXJlIGFuZCBp
dCBjYXRjaGVzIHRoaXMgY2FzZSwgLi4uDQo+IA0KPiBUaGUgZG93bnNpZGUgaXMsIGl0IG1h
eSBicmVhayBvdGhlciBkZXZpY2VzLCBJIG9ubHkgdGVzdCBib290ZWQgdGhpcw0KPiBvbiBh
biBVbHRyYSAyIGFuZCBVbHRyYSAzMC4gT24gdGhlIFUyIGl0IGZpeGVzIHRoZSBobWUgZXRo
ZXJuZXQsDQo+IHRvby4gT24gdGhlIFUzMCBpdCBjYXVzZXMgYW4gZXByb20gcmVnaW9uIHRv
IGJlIHRydW5jYXRlZC4gSSBwcm9iYWJseQ0KPiBzaG91bGQgaW52ZXN0aWFnZSB0aGF0IGFu
ZCB0ZXN0IGJvb3Qgb24gYWxsIG15IFNQQVJDIHN5c3RlbXMgYmVmb3JlIHdlDQo+IGNvbnNp
ZGVyIHRoaXMuIFRoYXQncyB3aHkgSSBzZW50IHRoZSB0cml2aWFsIGhtZSBkcml2ZXIgaG90
Zml4IGZpcnN0Lg0KPiBBbHRlcm5hdGl2ZWx5IHdlIGNvdWxkIGFsc28gb3ZlcndyaXRlIGFs
bCBzYnVzIHJlcyBpbiB0aGUgaG1lIGRyaXZlcg0KPiB3aXRoIHRoZSBwcmV2aW91c2x5IHVz
ZWQga25vd24gZ29vZCBzaXplcy4gSSBjYW4gc2VuZCBhIHBhdGNoIGZvcg0KPiB0aGF0LCB0
b28gaWYgeW91IGxpa2U6DQoNCkknbSBub3QgcmVhbGx5IGZhbWlsaWFyIGVub3VnaCB3aXRo
IFNQQVJDIHRvIHNheSB3aGV0aGVyIHRoaXMgaXMgcmVhc29uYWJsZQ0Kb3Igbm90LiBJJ3Zl
IGFkZGVkIHRoZSBTUEFSQyBtYWludGFpbmVycyB0byBDQyBzbyBtYXliZSB0aGV5IGNhbiBj
b21tZW50Lg0KDQo+IGRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2Vf
NjQuYyBiL2FyY2gvc3BhcmMva2VybmVsL29mX2RldmljZV82NC5jDQo+IGluZGV4IGY1MzA5
MmIwN2I5ZS4uOGJkNDA1Y2JjMDRmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3NwYXJjL2tlcm5l
bC9vZl9kZXZpY2VfNjQuYw0KPiArKysgYi9hcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2Vf
NjQuYw0KPiBAQCAtNDEyLDYgKzQxMiwxNSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYnVpbGRf
ZGV2aWNlX3Jlc291cmNlcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvcCwNCj4gICAJCQly
LT5zdGFydCA9IHJlc3VsdDsNCj4gICAJCQlyLT5lbmQgPSByZXN1bHQgKyBzaXplIC0gMTsN
Cj4gICAJCQlyLT5mbGFncyA9IGZsYWdzOw0KPiArDQo+ICsJCQkvKiBjaGVjayBmb3IgYW5k
IGNvcnJlY3Qgc2ltcGxlIGJvZ3VzbHkgb3ZlcmxhcHBpbmcgcmVzb3VyY2VzICovDQo+ICsJ
CQlpZiAoaW5kZXggPiAwICYmDQo+ICsJCQkgICAgb3AtPnJlc291cmNlW2luZGV4LTFdLnN0
YXJ0IDw9IHItPmVuZCAmJg0KPiArCQkJICAgIG9wLT5yZXNvdXJjZVtpbmRleC0xXS5lbmQg
PiByLT5zdGFydCkgew0KPiArCQkJCXByaW50ayhLRVJOX1dBUk5JTkcgIiVwT0Y6IHByZXYg
cmVncyBvdmVybGFwICgleCksIGxpbWl0aW5nICV4LlxuIiwNCj4gKwkJCQkgICAgICAgb3At
PmRldi5vZl9ub2RlLCBvcC0+cmVzb3VyY2VbaW5kZXgtMV0uZW5kLCByLT5zdGFydCAtIDEp
Ow0KPiArCQkJCW9wLT5yZXNvdXJjZVtpbmRleC0xXS5lbmQgPSByLT5zdGFydCAtIDE7DQo+
ICsJCQl9DQo+ICAgCQl9DQo+ICAgCQlyLT5uYW1lID0gb3AtPmRldi5vZl9ub2RlLT5mdWxs
X25hbWU7DQo+ICAgCX0NCj4gDQo+IA0KPj4+IC0tLQ0KPj4+IC0tLSBsaW51eC02LjE4L2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3N1bi9zdW5obWUuYy52YW5pbGxhIDIwMjYtMDItMDUNCj4+
PiAtLS0gMTE6NTA6MzMuMjg4OTA2MTM0ICswMTAwDQo+Pj4gKysrIGxpbnV4LTYuMTgvZHJp
dmVycy9uZXQvZXRoZXJuZXQvc3VuL3N1bmhtZS5jIDIwMjYtMDItMDUNCj4+PiAxMTo1NToy
Mi41NDEzODQzNzcgKzAxMDANCj4+PiBAQCAtMjU1MSw2ICsyNTUxLDkgQEANCj4+PiAgICAJ
CWdvdG8gZXJyX291dF9jbGVhcl9xdWF0dHJvOw0KPj4+ICAgIAl9DQo+Pj4gICAgKwkvKiBC
SUdNQUMgbWF5IGhhdmUgYm9ndXMgc2l6ZXMgKi8NCj4+PiArIGlmICgob3AtPnJlc291cmNl
WzNdLmVuZCAtIG9wLT5yZXNvdXJjZVszXS5zdGFydCkgPj0gQk1BQ19SRUdfU0laRSkNCj4+
PiArIG9wLT5yZXNvdXJjZVszXS5lbmQgPSBvcC0+cmVzb3VyY2VbM10uc3RhcnQgKyBCTUFD
X1JFR19TSVpFIC0gMTsNCj4+PiAgICAJaHAtPmJpZ21hY3JlZ3MgPSBkZXZtX3BsYXRmb3Jt
X2lvcmVtYXBfcmVzb3VyY2Uob3AsIDMpOw0KPj4+ICAgIAlpZiAoSVNfRVJSKGhwLT5iaWdt
YWNyZWdzKSkgew0KPj4+ICAgIAkJZGV2X2Vycigmb3AtPmRldiwgIkNhbm5vdCBtYXAgQklH
TUFDIHJlZ2lzdGVycy5cbiIpOw0KPj4+DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFNlYW4gQW5k
ZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPg0KPiANCg0K

