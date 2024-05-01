Return-Path: <netdev+bounces-92751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D038B8937
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C72859AF
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804257F481;
	Wed,  1 May 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="P/tH9vRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1961664
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563026; cv=none; b=WH6V+eTdgj+DHp6k3vXHn0gywYmrlwzhcMB2iPakcFGi6vZQYDAQvkl/JhzPMj8oCQsktn3MUAWXG06CQIw8M66mbUKrdnalw0d+UjUrT/o20qBLDaUCKMp3Ai5QylYqUJ/X2A/tRSLw6QpY4O3DcLaz1yEJnWfvnN2jaFs9/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563026; c=relaxed/simple;
	bh=aXH/M3+/2Mw2cwKQutoBJmVfgEEdut0VHrhub639eTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyDo5bSFRR8P4FhbO+mBq+5gI52geVBTihVU/XIXYhFrtRmvpkr1uV7pqtCMjgRe2tRppYmnwfowImIAz0Pk9vfcyQZ+5po/X6as8WzrtGryQDwLpK3gsb8sF9kHJmsVHsenlpUUfKqcFYoTMhFNCKhSIpHmPgVRYhg1QP/SO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=P/tH9vRd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ff14f249so5528285ad.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1714563024; x=1715167824; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aXH/M3+/2Mw2cwKQutoBJmVfgEEdut0VHrhub639eTI=;
        b=P/tH9vRdQGZF4dioY7js3kb67lPiN1TzHkVZoVr3vYQbEWprrMlc01yN1KzNBEy1Ag
         40IYVBebECcznWTe5Zz2Dl/03/8kN8r0FOJe7uEAF+pLDR6C5QlKSJOQMw1fKPLVbTtd
         Qg4qo+69RdAQ5R1kDokj0KypxKIEA6sL1Nfyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714563024; x=1715167824;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXH/M3+/2Mw2cwKQutoBJmVfgEEdut0VHrhub639eTI=;
        b=T6tEpdOUTYxBOEaDDwm1UWvK9HlbJTI+YoQ9k4soN+meIDXd9ufGS513KIf+GCyixK
         Gt1ctglHY4LtETzPuhrOhn7x8eRahqCXbh316gc5RXpsJ9r2PC4kPsCmkFQZ/6vcvIhc
         /HIllHnQMD80hUhIWuY/Ts+kqPM44OMZAm0C7Z3pyg/r+9x/fOe3P2PsRNlRSJ2uvr+7
         XsfJkuWl4OQAQScaNrfWQJsL9tosorvhPFaVT1GS+tw/dPefAJcMn5BtRH9moKzHbCIB
         7k8TjBQ1Crf6SOYPQac+S0arExrS0Eur/EhG4YtD2R3sMhmAMhOjX3yaX+kYXsOIXrvk
         5w9Q==
X-Gm-Message-State: AOJu0YxHopZrzM8Qr5UfjC56rFl1eDMsCnjIHtRCu+zjn5eXI52+65Pb
	qbe0UGr81D7oTQXdBgMJA7zIwoxg0t1/CfCMLS3vXbq54RKVViFuoE14PJQZYrBYM1E5pUm/W2p
	wOh8=
X-Google-Smtp-Source: AGHT+IFNtdLJk8Eoo5GEoquT9jx6J1kIJEXDdZqt3A+utE3JKOc01Lo2I3Pu4an9a2WTUurmDfkf/Q==
X-Received: by 2002:a17:903:2301:b0:1dd:dcd3:662c with SMTP id d1-20020a170903230100b001dddcd3662cmr9060215plh.4.1714563023953;
        Wed, 01 May 2024 04:30:23 -0700 (PDT)
Received: from [192.168.1.2] ([191.178.115.215])
        by smtp.gmail.com with ESMTPSA id cb17-20020a056a02071100b0060063c4be3bsm14114159pgb.14.2024.05.01.04.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:30:23 -0700 (PDT)
Message-ID: <8922b6e4-1804-4d6a-b7e5-cd4fe1623ff1@allelesecurity.com>
Date: Wed, 1 May 2024 08:30:15 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: use-after-free warnings in tcp_v4_connect() due to
 inet_twsk_hashdance() inserting the object into ehash table without
 initializing its reference counter
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
References: <37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com>
 <20240501002212.20110-1-kuniyu@amazon.com>
 <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
Content-Language: en-US
From: Anderson Nascimento <anderson@allelesecurity.com>
Autocrypt: addr=anderson@allelesecurity.com; keydata=
 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
 KglE9pfKPqrm
In-Reply-To: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SPcBMZWDKlijJ4ARKfT7dLO1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SPcBMZWDKlijJ4ARKfT7dLO1
Content-Type: multipart/mixed; boundary="------------oG6cuhkdxDbyRfFjqlXaxhWR";
 protected-headers="v1"
From: Anderson Nascimento <anderson@allelesecurity.com>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
Message-ID: <8922b6e4-1804-4d6a-b7e5-cd4fe1623ff1@allelesecurity.com>
Subject: Re: use-after-free warnings in tcp_v4_connect() due to
 inet_twsk_hashdance() inserting the object into ehash table without
 initializing its reference counter
References: <37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com>
 <20240501002212.20110-1-kuniyu@amazon.com>
 <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
In-Reply-To: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>

--------------oG6cuhkdxDbyRfFjqlXaxhWR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDUvMS8yNCAwMzo1NiwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAxLCAyMDI0IGF0IDI6MjLigK9BTSBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGFtYXpv
bi5jb20+IHdyb3RlOg0KPj4NCj4+ICtjYyBFcmljDQo+Pg0KPj4gRnJvbTogQW5kZXJzb24g
TmFzY2ltZW50byA8YW5kZXJzb25AYWxsZWxlc2VjdXJpdHkuY29tPg0KPj4gRGF0ZTogVHVl
LCAzMCBBcHIgMjAyNCAxOTowMDozNCAtMDMwMA0KPj4+IEhlbGxvLA0KPj4NCj4+IEhpLA0K
Pj4NCj4+IFRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIHJlcG9ydC4NCj4+DQo+Pj4NCj4+PiBU
aGVyZSBpcyBhIGJ1ZyBpbiBpbmV0X3R3c2tfaGFzaGRhbmNlKCkuIFRoaXMgZnVuY3Rpb24g
aW5zZXJ0cyBhDQo+Pj4gdGltZS13YWl0IHNvY2tldCBpbiB0aGUgZXN0YWJsaXNoZWQgaGFz
aCB0YWJsZSB3aXRob3V0IGluaXRpYWxpemluZyB0aGUNCj4+PiBvYmplY3QncyByZWZlcmVu
Y2UgY291bnRlciwgYXMgc2VlbiBiZWxvdy4gVGhlIHJlZmVyZW5jZSBjb3VudGVyDQo+Pj4g
aW5pdGlhbGl6YXRpb24gaXMgZG9uZSBhZnRlciB0aGUgb2JqZWN0IGlzIGFkZGVkIHRvIHRo
ZSBlc3RhYmxpc2hlZCBoYXNoDQo+Pj4gdGFibGUgYW5kIHRoZSBsb2NrIGlzIHJlbGVhc2Vk
LiBCZWNhdXNlIG9mIHRoaXMsIGEgc29ja19ob2xkKCkgaW4NCj4+PiB0Y3BfdHdza191bmlx
dWUoKSBhbmQgb3RoZXIgb3BlcmF0aW9ucyBvbiB0aGUgb2JqZWN0IHRyaWdnZXIgd2Fybmlu
Z3MNCj4+PiBmcm9tIHRoZSByZWZlcmVuY2UgY291bnRlciBzYXR1cmF0aW9uIG1lY2hhbmlz
bS4gVGhlIHdhcm5pbmdzIGNhbiBhbHNvDQo+Pj4gYmUgc2VlbiBiZWxvdy4gVGhleSB3ZXJl
IHRyaWdnZXJlZCBvbiBGZWRvcmEgMzkgTGludXgga2VybmVsIHY2LjguDQo+Pj4NCj4+PiBU
aGUgYnVnIGlzIHRyaWdnZXJlZCB2aWEgYSBjb25uZWN0KCkgc3lzdGVtIGNhbGwgb24gYSBU
Q1Agc29ja2V0LA0KPj4+IHJlYWNoaW5nIF9faW5ldF9jaGVja19lc3RhYmxpc2hlZCgpIGFu
ZCB0aGVuIHBhc3NpbmcgdGhlIHRpbWUtd2FpdA0KPj4+IHNvY2tldCB0byB0Y3BfdHdza191
bmlxdWUoKS4gT3RoZXIgb3BlcmF0aW9ucyBhcmUgYWxzbyBwZXJmb3JtZWQgb24gdGhlDQo+
Pj4gdGltZS13YWl0IHNvY2tldCBpbiBfX2luZXRfY2hlY2tfZXN0YWJsaXNoZWQoKSBiZWZv
cmUgaXRzIHJlZmVyZW5jZQ0KPj4+IGNvdW50ZXIgaXMgaW5pdGlhbGl6ZWQgY29ycmVjdGx5
IGJ5IGluZXRfdHdza19oYXNoZGFuY2UoKS4gVGhlIGZpeCBzZWVtcw0KPj4+IHRvIGJlIHRv
IG1vdmUgdGhlIHJlZmVyZW5jZSBjb3VudGVyIGluaXRpYWxpemF0aW9uIGluc2lkZSB0aGUg
bG9jaywNCj4+DQo+PiBvciB1c2UgcmVmY291bnRfaW5jX25vdF96ZXJvKCkgYW5kIGdpdmUg
dXAgb24gcmV1c2luZyB0aGUgcG9ydA0KPj4gdW5kZXIgdGhlIHJhY2UgPw0KPj4NCj4+IC0t
LTg8LS0tDQo+PiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX2lwdjQuYyBiL25ldC9pcHY0
L3RjcF9pcHY0LmMNCj4+IGluZGV4IDA0MjdkZWNhM2UwZS4uNjM3ZjQ5NjUzMjZkIDEwMDY0
NA0KPj4gLS0tIGEvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPj4gKysrIGIvbmV0L2lwdjQvdGNw
X2lwdjQuYw0KPj4gQEAgLTE3NSw4ICsxNzUsMTMgQEAgaW50IHRjcF90d3NrX3VuaXF1ZShz
dHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBzb2NrICpza3R3LCB2b2lkICp0d3ApDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHAtPnJ4X29wdC50c19yZWNlbnQgICAgICAgPSB0Y3B0
dy0+dHdfdHNfcmVjZW50Ow0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHRwLT5yeF9v
cHQudHNfcmVjZW50X3N0YW1wID0gdGNwdHctPnR3X3RzX3JlY2VudF9zdGFtcDsNCj4+ICAg
ICAgICAgICAgICAgICAgfQ0KPj4gLSAgICAgICAgICAgICAgIHNvY2tfaG9sZChza3R3KTsN
Cj4+IC0gICAgICAgICAgICAgICByZXR1cm4gMTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAg
ICAvKiBIZXJlLCBza19yZWZjbnQgY291bGQgYmUgMCBiZWNhdXNlIGluZXRfdHdza19oYXNo
ZGFuY2UoKSBwdXRzDQo+PiArICAgICAgICAgICAgICAgICogdHdzayBpbnRvIGVoYXNoIGFu
ZCByZWxlYXNlcyB0aGUgYnVja2V0IGxvY2sgKmJlZm9yZSogc2V0dGluZw0KPj4gKyAgICAg
ICAgICAgICAgICAqIHNrX3JlZmNudC4gIFRoZW4sIGdpdmUgdXAgb24gcmV1c2luZyB0aGUg
cG9ydC4NCj4+ICsgICAgICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICBpZiAo
bGlrZWx5KHJlZmNvdW50X2luY19ub3RfemVybygmc2t0dy0+c2tfcmVmY250KSkpDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4+ICAgICAgICAgIH0NCj4+DQo+
IA0KPiBUaGFua3MgZm9yIENDIG1lLg0KPiANCj4gTmljZSBhbmFseXNpcyBmcm9tIEFuZGVy
c29uICEgSGF2ZSB5b3UgZm91bmQgdGhpcyB3aXRoIGEgZnV6emVyID8NCg0KSSByYW4gdGhl
IHJlcHJvZHVjZXIgb2YgYSBidWcgZm91bmQgYnkgc3l6a2FsbGVyIG9uIGFuIG9sZGVyIGtl
cm5lbCwgYW5kIA0KdGhpcyBpc3N1ZSB3YXMgdHJpZ2dlcmVkLiBBbmFseXppbmcgaXQsIEkg
ZGlzY292ZXJlZCBpdCBoYWQgbm90aGluZyB0byANCmRvIHdpdGggdGhlIHByb2JsZW0gdGhl
IHJlcHJvZHVjZXIgYWltZWQgdG8gdHJpZ2dlciwgYW5kIGl0IHdhcyBwcmVzZW50IA0KdXBz
dHJlYW0uIEkgcmV3cm90ZSB0aGUgcmVwcm9kdWNlciBhbmQgdHJpZ2dlcmVkIGl0IG9uIHY2
LjggdG8gY29uZmlybS4NCg0KaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4
dGlkPTI3ODI3OWVmZGQyNzMwZGQxNGJmDQoNCj4gDQo+IFRoaXMgcGF0Y2ggd291bGQgYXZv
aWQgdGhlIHJlZmNvdW50IHNwbGF0LCBidXQgd291bGQgbGVhdmUgc2lkZQ0KPiBlZmZlY3Rz
IG9uIHRwLCBJIGFtIHRvbyBsYXp5IHRvIGRvdWJsZSBjaGVjayB0aGVtLg0KPiANCj4gSW5j
aWRlbnRhbGx5LCBJIHRoaW5rIHdlIGhhdmUgdG8gYW5ub3RhdGUgZGF0YS1yYWNlcyBvbg0K
PiB0Y3B0dy0+dHdfdHNfcmVjZW50IGFuZCAgdGNwdHctPnR3X3RzX3JlY2VudF9zdGFtcA0K
PiANCj4gUGVyaGFwcyBzb21ldGhpbmcgbGlrZSB0aGlzIGluc3RlYWQgPw0KPiANCj4gZGlm
ZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9pcHY0LmMgYi9uZXQvaXB2NC90Y3BfaXB2NC5jDQo+
IGluZGV4IDA0MjdkZWNhM2UwZWI5MjM5NTU4YWExMjRhNDFhMTUyNWRmNjJhMDQuLmYxZTM3
MDdkMGIzMzE4MGEyNzBlNmQzNjYyZDRjZjE3YTRmNzJiYjgNCj4gMTAwNjQ0DQo+IC0tLSBh
L25ldC9pcHY0L3RjcF9pcHY0LmMNCj4gKysrIGIvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPiBA
QCAtMTU1LDYgKzE1NSwxMCBAQCBpbnQgdGNwX3R3c2tfdW5pcXVlKHN0cnVjdCBzb2NrICpz
aywgc3RydWN0IHNvY2sNCj4gKnNrdHcsIHZvaWQgKnR3cCkNCj4gICAgICAgICAgaWYgKHRj
cHR3LT50d190c19yZWNlbnRfc3RhbXAgJiYNCj4gICAgICAgICAgICAgICghdHdwIHx8IChy
ZXVzZSAmJiB0aW1lX2FmdGVyMzIoa3RpbWVfZ2V0X3NlY29uZHMoKSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNwdHctPnR3X3RzX3JlY2Vu
dF9zdGFtcCkpKSkgew0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoIXJlZmNvdW50X2lu
Y19ub3RfemVybygmc2t0dy0+c2tfcmVmY250KSkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+ICsNCj4gICAgICAgICAgICAgICAgICAvKiBJbiBjYXNlIG9mIHJl
cGFpciBhbmQgcmUtdXNpbmcgVElNRS1XQUlUIHNvY2tldHMgd2Ugc3RpbGwNCj4gICAgICAg
ICAgICAgICAgICAgKiB3YW50IHRvIGJlIHN1cmUgdGhhdCBpdCBpcyBzYWZlIGFzIGFib3Zl
IGJ1dCBob25vciB0aGUNCj4gICAgICAgICAgICAgICAgICAgKiBzZXF1ZW5jZSBudW1iZXJz
IGFuZCB0aW1lIHN0YW1wcyBzZXQgYXMgcGFydCBvZiB0aGUgcmVwYWlyDQo+IEBAIC0xNzUs
NyArMTc5LDYgQEAgaW50IHRjcF90d3NrX3VuaXF1ZShzdHJ1Y3Qgc29jayAqc2ssIHN0cnVj
dCBzb2NrDQo+ICpza3R3LCB2b2lkICp0d3ApDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICB0cC0+cnhfb3B0LnRzX3JlY2VudCAgICAgICA9IHRjcHR3LT50d190c19yZWNlbnQ7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICB0cC0+cnhfb3B0LnRzX3JlY2VudF9zdGFtcCA9
IHRjcHR3LT50d190c19yZWNlbnRfc3RhbXA7DQo+ICAgICAgICAgICAgICAgICAgfQ0KPiAt
ICAgICAgICAgICAgICAgc29ja19ob2xkKHNrdHcpOw0KPiAgICAgICAgICAgICAgICAgIHJl
dHVybiAxOw0KPiAgICAgICAgICB9DQo=

--------------oG6cuhkdxDbyRfFjqlXaxhWR--

--------------SPcBMZWDKlijJ4ARKfT7dLO1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExMt8Z6US1+nNyjiLVfCgKyEc8BwFAmYyJ8gFAwAAAAAACgkQVfCgKyEc8Bxd
6Q//b1GbLpU8sO3SM0bQlRRF4wUfgoa5HPScjifxg1KRuI3J+HvMi6LsOECRdjXrVBWN7KXwEXuk
0qkzr7bSHegvTaTTtf2jBsg+xu/s7tEsXtLR3oOW+xUea7LqFdrSSM0czwYtMpk7RI+2XTWTRRpX
3ctl2/keLleYxQpG11WCxqn3eEcxgJJOw/SeAO9fYNvxzOdmSxCxDmqkWYYPSqmSM/WI3fbb7pqc
8RLNt1gjcvc+q49IGKYFXhYjBx/D3yG63w8ER7wO3QuHhMvySc0OviNslGGSpRqq59L3TCqNYSmL
BVewQquTzP1vmz3cJLL4QpWu6U5n4VF0V8kQTewsZCa+RDm13OSkJZy3hT4Tg8T22BlLoEDpQjDL
XMdbwiQMaM7LrMh0ZTiFyYYb439yhIVawFv2O5siDg351/a3AM1WpJAbS7A149bAh/Gm27GMZT/z
MeHcYI7xuJiUweBZS/h7u3M4vcWV0J+3o0obiHZI/P/noJNVYyt3dGNAXUo1F7JXG2Qkx2tNxUmC
vT4gP+bWbzTQRxQbh+2BdqQT3bMQg7+S7b/eAL+Onf62Y22sSVbO62AXlvIv3bh9a1opTNyo9w7t
Jj/KtUuL4ZQCAuIOAJmxUa7cMKK0DGG3VtPZuDzYXSsx8uxlGolAZGNmY8hEE2FroYhYAHmq+2T4
68I=
=7pN8
-----END PGP SIGNATURE-----

--------------SPcBMZWDKlijJ4ARKfT7dLO1--

