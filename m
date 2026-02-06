Return-Path: <netdev+bounces-257377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zY/pC71GhWkN/QMAu9opvQ
	(envelope-from <netdev+bounces-257377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 02:41:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3DF8FE4
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4539300F9E3
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0D223DE9;
	Fri,  6 Feb 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL69HGfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD41C84B8
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342074; cv=none; b=VhEbJMW9dIRauSBm6p1fQmnL/RVinFJtPIQfFbgut1NbrBKrMW0e3VaLSGrcXgIvZ+Vrs5jsc/65/Illgm41ia4gPM1RQrYn67vqJ1A/fhdp4Jzh0T/zirPXFL1eu+ktxQQUQlSCiiK2UEumOLFVGNbBycwUsNo0qNqPlC3hqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342074; c=relaxed/simple;
	bh=auq3YOW6Gc7GYmZn0/XGBUgGR+YC0M2tkeQ3yc1BTaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCfpZCSukOM2Dou8OoSIOlA+2p9AdEl8PyzO15jIjwZf0nXqnKSsrHWxLD6jhn/EWptPoeoOScpocETv+fP+GlfGGmHIg4BPHnC/WqNFioP7yQUjBoDPEBM8KciHP90Ph4F2KSfSZROUH5JLjo2Oqx7y1Rt4UssItHsRBIP/CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL69HGfy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8887d6d237fso3185156d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 17:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770342073; x=1770946873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auq3YOW6Gc7GYmZn0/XGBUgGR+YC0M2tkeQ3yc1BTaA=;
        b=CL69HGfyCNPftdJ/TxHJHQo5x39gjmb8WYJXPM57ut+mrHlsz5WFbT6HEuPpA+YHDU
         mCdJqJ/3JKtJN9f63DXVaqicbMkoroNUyrEwDcTPGY1lgp7ITBrFdPDE+UqPwDZlaFpe
         bTAK0g6K6RN245DEaaJNoW5zZE4Val1OMJ4msH8M7+9x1el8TrpwjKu4ejouSy/dG4Jn
         /DVGBmPXybt0u6wFOSWQjBD4u1JhsBa0NcWQ5l9UAtQs3kbBQYEZ9TbHf22bEgmnxeA7
         zVOLdpNUYuarEo2bZK8AdG6WtLSeg0v/zfLnCHnSS6KCXewz4hkgKHTuOWoZM4TQop8T
         C0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770342073; x=1770946873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auq3YOW6Gc7GYmZn0/XGBUgGR+YC0M2tkeQ3yc1BTaA=;
        b=qYWmq/EIfjhPoxWR1UC/Yu+IhjHHuvqxuXmbvK/krV0Aaj62q3h8RaJD1fUj3etCUz
         9hlDc0BJSSrnU+CrmVni3TyKeAqQJVu6qZCzgWE5yIhRznyYNmfRrk2GcFi2kpVeD+d4
         4qwQHXxt5sZeUqSrlUggDT19VjmJiRyz+hS/4ElGkpnQ7apiq9y7nS1D0yPfV9IO5GwP
         lSUTcY20NVZVXVTruzC8E77CYm0dVam5HW2u3XmvXKRgQiiQDxQ46MqwetVRX22n8ARZ
         AhjrqLG24AgqSIclOeW8NQQOFt71Y/srS5bq72noEsz3HXMm9VVIyedJQ3aTtLk/4XSu
         CZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrrkFgluOYcoa+bBsWM47aD1c7fyUkcDU4v7riB52r9J1iQsvGl7TYMmQwbXScoWapBVSpW+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xW3m3CFhYxqk1+RGn/DIAXm2RnaVAiSAYchTp7v+Y/dverAN
	m+ReS3UJ1g5Bo5+7tc59VJ4vuq3Jri5Yuzew5IJICtNBxtoZsaKSXaZD
X-Gm-Gg: AZuq6aIuevMiSpJ2+ytmlBStlQi8ga1roNooZyKQCiQNo8Mo296g9Iwix6d0u689TD5
	hl54dP2YSnEiRP7dC10IwVFjIXDrY3tUOi4+Rd3ad5Ruswhy7yfhI5oEE5OeyxL5UMcjixXcKkt
	wWR2xX67lzBUrGBQgjV8KZx88UkgaGuAbUpf6P4jDPav2X/yFM/xsFm5f7PGytDItv//SQ/fQom
	/PJqVHhTfT6OcStHMQLFabdKCtgdCmEiixqq/p3ehwmE0NGQVilchSq2FqRJRXd1TUTGrQ7z2fd
	3U5Mw5soUHdgOxQyOxiIViGVj34PDDtQMQ3KQx380vUkNyZhkprHxMAwzA2W8AWwLp3pnqmB3tz
	L0M/gmOxD4m62vhv/cSs9oVJ+dz1rN5ZlDMsYqZMqCL4mw4f9JKPhs+ZZPmikNgOPH8Wb+IbxNc
	I43MUo09uYMGYnOyC7g1oBXIjokPby2pXAv5/Aea+gKAfZMEogBhhs2Ts=
X-Received: by 2002:a0c:e019:0:b0:894:f706:a5f2 with SMTP id 6a1803df08f44-8953cd8f0dfmr11937866d6.3.1770342072826;
        Thu, 05 Feb 2026 17:41:12 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59? ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf38457sm8198896d6.4.2026.02.05.17.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 17:41:12 -0800 (PST)
Message-ID: <cc269d9f-9a06-6623-e412-d04ecb7b4f74@gmail.com>
Date: Thu, 5 Feb 2026 20:41:11 -0500
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
To: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactco.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org
References: <20260205.170959.89574674688839340.rene@exactco.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260205.170959.89574674688839340.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanga2@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exactco.de:email,0.0.0.2:email,1f:email]
X-Rspamd-Queue-Id: 79A3DF8FE4
X-Rspamd-Action: no action

T24gMi81LzI2IDExOjA5LCBSZW7DqSBSZWJlIHdyb3RlOg0KPiBDb21taXQgY2MyMTZlNGI0
NGNlICgibmV0OiBzdW5obWU6IFN3aXRjaCBTQlVTIHRvIGRldnJlcyIpIGNoYW5nZWQNCj4g
ZXhwbGljaXQgc2l6ZWQgb2ZfaW9yZW1hcCB3aXRoIEJNQUNfUkVHX1NJWkVzIHRvDQo+IGRl
dm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSBtYXBwaW5nIGFsbCB0aGUgcmVzb3VyY2Uu
IEhvd2V2ZXIsDQo+IHRoaXMgZG9lcyBub3Qgd29yayBvbiBteSBTdW4gVWx0cmEgMiB3aXRo
IFNCVVMgSE1FczoNCj4gDQo+IGhtZSBmMDA3MmYzODogZXJyb3IgLUVCVVNZOiBjYW4ndCBy
ZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2UgW21lbSAweDFmZmU4YzA3MDAwLTB4MWZmZThj
MDcwMWZdDQo+IGhtZSBmMDA3MmYzODogQ2Fubm90IG1hcCBUQ1ZSIHJlZ2lzdGVycy4NCj4g
aG1lIGYwMDcyZjM4OiBwcm9iZSB3aXRoIGRyaXZlciBobWUgZmFpbGVkIHdpdGggZXJyb3Ig
LTE2DQo+IGhtZSBmMDA3YWI0NDogZXJyb3IgLUVCVVNZOiBjYW4ndCByZXF1ZXN0IHJlZ2lv
biBmb3IgcmVzb3VyY2UgW21lbSAweDFmZjI4YzA3MDAwLTB4MWZmMjhjMDcwMWZdDQo+IGht
ZSBmMDA3YWI0NDogQ2Fubm90IG1hcCBUQ1ZSIHJlZ2lzdGVycy4NCj4gaG1lIGYwMDdhYjQ0
OiBwcm9iZSB3aXRoIGRyaXZlciBobWUgZmFpbGVkIHdpdGggZXJyb3IgLTE2DQo+IA0KPiBU
dXJucyBvdXQgdGhlIG9wZW4tZmlybXdhcmUgcmVzb3VyY2VzIG92ZXJsYXAsIGF0IGxlYXN0
IG9uIHRoaXMNCj4gbWFjaGluZXMgYW5kIFBST00gdmVyc2lvbjoNCj4gDQo+IGhleGR1bXAg
L3Byb2MvZGV2aWNlLXRyZWUvc2J1c0AxZiwwL1NVTlcsaG1lQDIsOGMwMDAwMC9yZWc6DQo+
IDAwIDAwIDAwIDAyIDA4IGMwIDAwIDAwICAwMCAwMCAwMSAwOA0KPiAwMCAwMCAwMCAwMiAw
OCBjMCAyMCAwMCAgMDAgMDAgMjAgMDANCj4gMDAgMDAgMDAgMDIgMDggYzAgNDAgMDAgIDAw
IDAwIDIwIDAwDQo+IDAwIDAwIDAwIDAyIDA4IGMwIDYwIDAwICAwMCAwMCAyMCAwMA0KPiAw
MCAwMCAwMCAwMiAwOCBjMCA3MCAwMCAgMDAgMDAgMDAgMjANCj4gDQo+IEFuZCB0aGUgZHJp
dmVyIHByZXZpb3VzbHkgZXhwbGljaXRseSBtYXBwZWQgd2F5IHNtYWxsZXIgbW1pbyByZWdp
b25zOg0KPiANCj4gL3Byb2MvaW9tZW06DQo+IDFmZjI4YzAwMDAwLTFmZjI4YzAwMTA3IDog
SE1FIEdsb2JhbCBSZWdzDQo+IDFmZjI4YzAyMDAwLTFmZjI4YzAyMDMzIDogSE1FIFRYIFJl
Z3MNCj4gMWZmMjhjMDQwMDAtMWZmMjhjMDQwMWYgOiBITUUgUlggUmVncw0KPiAxZmYyOGMw
NjAwMC0xZmYyOGMwNjM1ZiA6IEhNRSBCSUdNQUMgUmVncw0KPiAxZmYyOGMwNzAwMC0xZmYy
OGMwNzAxZiA6IEhNRSBUcmFuY2VpdmVyIFJlZ3MNCj4gDQo+IFF1aXJrIHRoaXMgc3BlY2lm
aWMgaXNzdWUgYnkgdHJ1bmNhdGluZyB0aGUgcHJldmlvdXMgcmVzb3VyY2UgdG8gbm90DQo+
IG92ZXJsYXAgaW50byB0aGUgVENWUiByZWdpc3RlcnMuDQo+IA0KPiBGaXhlczogY2MyMTZl
NGI0NGNlICgibmV0OiBzdW5obWU6IFN3aXRjaCBTQlVTIHRvIGRldnJlcyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFJlbsOpIFJlYmUgPHJlbmVAZXhhY3Rjby5kZT4NCj4gLS0tDQo+IFRlc3Rl
ZCBvbiBTdW4gVWx0cmEgMiBydW5uaW5nIFQyL0xpbnV4Lg0KPiBBbHRlcm5hdGl2ZWx5IHdl
IGNvdWxkIGV4cGxpY2l0bHkgc2l6ZSBhbGwgcmVnaW9ucywgb3IgY2hlY2sgb3ZlcmxhcA0K
PiBpbiBzdGFydHVwIGNvZGUgKEkgYWxzbyBhbHJlYWR5IGhhdmUgYSBwYXRjaCBmb3IgdGhh
dCwgdG9vKS4NCg0KV2hhdCBkb2VzIHRoaXMgbG9vayBsaWtlPw0KDQo+IC0tLQ0KPiANCj4g
LS0tIGxpbnV4LTYuMTgvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3VuL3N1bmhtZS5jLnZhbmls
bGEJMjAyNi0wMi0wNSAxMTo1MDozMy4yODg5MDYxMzQgKzAxMDANCj4gKysrIGxpbnV4LTYu
MTgvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3VuL3N1bmhtZS5jCTIwMjYtMDItMDUgMTE6NTU6
MjIuNTQxMzg0Mzc3ICswMTAwDQo+IEBAIC0yNTUxLDYgKzI1NTEsOSBAQA0KPiAgIAkJZ290
byBlcnJfb3V0X2NsZWFyX3F1YXR0cm87DQo+ICAgCX0NCj4gICANCj4gKwkvKiBCSUdNQUMg
bWF5IGhhdmUgYm9ndXMgc2l6ZXMgKi8NCj4gKwlpZiAoKG9wLT5yZXNvdXJjZVszXS5lbmQg
LSBvcC0+cmVzb3VyY2VbM10uc3RhcnQpID49IEJNQUNfUkVHX1NJWkUpDQo+ICsJCW9wLT5y
ZXNvdXJjZVszXS5lbmQgPSBvcC0+cmVzb3VyY2VbM10uc3RhcnQgKyBCTUFDX1JFR19TSVpF
IC0gMTsNCj4gICAJaHAtPmJpZ21hY3JlZ3MgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2Uob3AsIDMpOw0KPiAgIAlpZiAoSVNfRVJSKGhwLT5iaWdtYWNyZWdzKSkgew0KPiAg
IAkJZGV2X2Vycigmb3AtPmRldiwgIkNhbm5vdCBtYXAgQklHTUFDIHJlZ2lzdGVycy5cbiIp
Ow0KPiANCg0KUmV2aWV3ZWQtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29t
Pg0K

