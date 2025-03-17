Return-Path: <netdev+bounces-175352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2FA6557D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4347718965CC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E52459D7;
	Mon, 17 Mar 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUwc0cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF7230BEB;
	Mon, 17 Mar 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225071; cv=none; b=TbFsyYPr/jrv1YNQ7ZuOiukc1QKbkuVu4zH0yYmPqL8lP28z44IXRlvVEskH1V5XkxyL7Lt4k1XxOrHVowiBxAX2HLA+mkxsSiBxD5nOgFXJfZ10kSqG7Qdqo+j7WXY7zbQ7rVTNZ9t2Q5yvnwraU7jGBefy7MBdICcpeO/7UCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225071; c=relaxed/simple;
	bh=3o8y+sF2cJuAyU0DtcMR+QnjfvSrFztUL3Purm0rulQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fgN4jkDuGI3oVHgBs4FXzZ8hxBM7VZ+gUuB+anrvh7xIJz6FmWG2MmxoIOS7XEsx/izYfSENLPoFPEue3zwi0R/Sij1ttxbs2JWgGTdzGvGakelnWERCBVrzMM12IIgD90TKfVTutidS9FENiEJj8lqo9X/UVfkeLszVGRNgziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUwc0cu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4208426f8f.2;
        Mon, 17 Mar 2025 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225068; x=1742829868; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3o8y+sF2cJuAyU0DtcMR+QnjfvSrFztUL3Purm0rulQ=;
        b=ZqUwc0cu0IwTT+2c3Qz76bqo7dF+jk5vtmt8MBZNXRMpsrlqxjxlWJoMzBHVevFri0
         jbMAfzOdqs2dkpM09buf3kkBaPxl6/D/q2iYg7ls3aUKsZu9sc/XyUCdaF5Es2bjOTUN
         snLNvd8j3j1FxcBZejMfP+RMSsIF8fSXOPt/HVZZxr4rfcW7Q52IqD9ZcTCTFcJNoiok
         A7npADzkhcA/AErr315DwZrQBlsXoFRaXJ6ocJsbVI5Vl9hK5WRJkoJAYsvs8GPKdqIP
         QrtixkZPUKIFtGSw64rllHtZ70XwC69z4BOmHuX76TFumwrIqXeUpTaQyVddmqq7ROjQ
         omkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225068; x=1742829868;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o8y+sF2cJuAyU0DtcMR+QnjfvSrFztUL3Purm0rulQ=;
        b=vGPcSq/6AS6BCvroo4TFKyu+e5mJT/8oj893c/8iapnNw38c49pTPa8UGT5FfkRNkP
         dr4nBOn2t58z7lrOVS/ZeyC2ZHELmzmrT7vCJXJyIP0noDoX+PTp49VK793orySSTrby
         pl7PcDyvNzZIkw5qyjeHyL+t0Ofs2iBxF0dRE86+C4Ul/m7Lujlwovw3Uqn9/Ad9KKjL
         KXOHezJZTsbwvsS/bHhMkOJYYXYhmZEcK3eR2p2fJmOBjVDKnzIRiqVcxf8HydhONytm
         D6JohE+2ezTQ4LmxL1Cg+S87G3q8PxNhRwTHkt1BkYuqv3CzvmaQ1LuOd57PmK0dNdOn
         VD2w==
X-Forwarded-Encrypted: i=1; AJvYcCUCs8+LMJJOW8lyUawitOYIEkjHomu825K00D9W7aaxkYz05FUbr3sXqpXS1lcx/OkjX+iFO1mPLsrHPe0=@vger.kernel.org, AJvYcCVz2QCqSl/XonKg3di3gFOphdl7Z9l3k9aTGkZ6UCzKaPRr8zhPhp0ZjMTgrUDumshERhs847jp@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaEamdKx8HoLIneVwuTYoDdiRwM5Fssv8Poh3q8LIFQ6t/6Jm
	u28hy3iXsSwA7QRF+QkGplMc8qjjVYbyhmFFInqJehuqn6OSuOw8
X-Gm-Gg: ASbGncsR8mcDmawiWYKUpOFE9FvUFucsZQ0ucY/DyqM+OVGDJ0vZWdiVNoYAh4x4an/
	7vHbAyabR7MpqVxYxvBumz7lUf4+3UWabcPD3XtqIcoX4ocJSTUIEk2ykI2w98iKpYDMmfT1bg3
	9Tf4mKm/Z93IIwU8Mkfwhgh9X+f6Rhdk81HKBZtniGpBt6cDhyAZTwMHH6UpV9H+XCO19lzP286
	SnZB0A5ZonA40CJyPT3ylbJt7XzTdehgZgS5ugZRZ8CKdfzxDfe1lttgxWmUHW9n9ebQSpXl3Pj
	CgP4JJ10ZGr0aBVmpwlZ7Uqi1bNRwiACG1hSdu8TL7Ho0KpGs6nuMQ==
X-Google-Smtp-Source: AGHT+IFxNyHd2elGdsiXtlwyqIChhOaDGEmGS67uMndk6oGZj+9LX+JLakb7zcRMKYCnsvTCPBR31A==
X-Received: by 2002:a05:6000:1562:b0:391:4bcb:828f with SMTP id ffacd0b85a97d-3971d6171f1mr13419839f8f.14.1742225067815;
        Mon, 17 Mar 2025 08:24:27 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.58])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe294b5sm108242315e9.21.2025.03.17.08.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:24:27 -0700 (PDT)
Message-ID: <e179abfc-542c-417d-8012-dbaf99ee55a7@gmail.com>
Date: Mon, 17 Mar 2025 15:23:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ice: make const read-only array dflt_rules static
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317144606.478431-1-colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <20250317144606.478431-1-colin.i.king@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZNFhGmX4lcFYNFRaEF7DK9gt"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZNFhGmX4lcFYNFRaEF7DK9gt
Content-Type: multipart/mixed; boundary="------------6TQZWX0MhXTNYHQ5gq0p7cLp";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <e179abfc-542c-417d-8012-dbaf99ee55a7@gmail.com>
Subject: Re: [PATCH][next] ice: make const read-only array dflt_rules static
References: <20250317144606.478431-1-colin.i.king@gmail.com>
In-Reply-To: <20250317144606.478431-1-colin.i.king@gmail.com>

--------------6TQZWX0MhXTNYHQ5gq0p7cLp
Content-Type: multipart/mixed; boundary="------------hRl0h9mCajm0NSHp4B6SnQ81"

--------------hRl0h9mCajm0NSHp4B6SnQ81
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SWdub3JlLCBtYW5hZ2VkIHRvIG1hbmdsZSB0d28gY29tbWl0cyBpbnRvIG9uZS4NCg0KDQoN
Ck9uIDE3LzAzLzIwMjUgMTQ6NDYsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPiBEb24ndCBw
b3B1bGF0ZSB0aGUgY29uc3QgcmVhZC1vbmx5IGFycmF5IGRmbHRfcnVsZXMgb24gdGhlIHN0
YWNrIGF0IHJ1bg0KPiB0aW1lLCBpbnN0ZWFkIG1ha2UgaXQgc3RhdGljLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX21lbW9yeV9yZWdpb24uYyAg
ICAgICAgfCAyICstDQo+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9l
dGh0b29sX2ZkaXIuYyB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9pbnRlbF9tZW1vcnlfcmVnaW9uLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9p
bnRlbF9tZW1vcnlfcmVnaW9uLmMNCj4gaW5kZXggZDQwZWUxYjQyMTEwLi43ZjQxMDJlZGM3
NWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX21lbW9yeV9y
ZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9tZW1vcnlfcmVn
aW9uLmMNCj4gQEAgLTYyLDcgKzYyLDcgQEAgc3RhdGljIGludCBpb3BhZ2V0ZXN0KHN0cnVj
dCBpbnRlbF9tZW1vcnlfcmVnaW9uICptZW0sDQo+ICAgCQkgICAgICByZXNvdXJjZV9zaXpl
X3Qgb2Zmc2V0LA0KPiAgIAkJICAgICAgY29uc3Qgdm9pZCAqY2FsbGVyKQ0KPiAgIHsNCj4g
LQljb25zdCB1OCB2YWxbXSA9IHsgMHgwLCAweGE1LCAweGMzLCAweGYwIH07DQo+ICsJc3Rh
dGljIGNvbnN0IHU4IHZhbFtdID0geyAweDAsIDB4YTUsIDB4YzMsIDB4ZjAgfTsNCj4gICAJ
dm9pZCBfX2lvbWVtICp2YTsNCj4gICAJaW50IGVycjsNCj4gICAJaW50IGk7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2xfZmRp
ci5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sX2ZkaXIu
Yw0KPiBpbmRleCAxZDExODE3MWRlMzcuLmFjZWVjMTg0ZTg5YiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sX2ZkaXIuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2xfZmRpci5j
DQo+IEBAIC0xNjA1LDcgKzE2MDUsNyBAQCB2b2lkIGljZV9mZGlyX3JlcGxheV9mbHRycyhz
dHJ1Y3QgaWNlX3BmICpwZikNCj4gICAgKi8NCj4gICBpbnQgaWNlX2ZkaXJfY3JlYXRlX2Rm
bHRfcnVsZXMoc3RydWN0IGljZV9wZiAqcGYpDQo+ICAgew0KPiAtCWNvbnN0IGVudW0gaWNl
X2ZsdHJfcHR5cGUgZGZsdF9ydWxlc1tdID0gew0KPiArCXN0YXRpYyBjb25zdCBlbnVtIGlj
ZV9mbHRyX3B0eXBlIGRmbHRfcnVsZXNbXSA9IHsNCj4gICAJCUlDRV9GTFRSX1BUWVBFX05P
TkZfSVBWNF9UQ1AsIElDRV9GTFRSX1BUWVBFX05PTkZfSVBWNF9VRFAsDQo+ICAgCQlJQ0Vf
RkxUUl9QVFlQRV9OT05GX0lQVjZfVENQLCBJQ0VfRkxUUl9QVFlQRV9OT05GX0lQVjZfVURQ
LA0KPiAgIAl9Ow0KDQo=
--------------hRl0h9mCajm0NSHp4B6SnQ81
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------hRl0h9mCajm0NSHp4B6SnQ81--

--------------6TQZWX0MhXTNYHQ5gq0p7cLp--

--------------ZNFhGmX4lcFYNFRaEF7DK9gt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmfYPoYFAwAAAAAACgkQaMKH38aoAib1
xQ/+LnlMzz/dQ0RD3lNGym8vopuswxN64QZlAmcQAi9qnw6srIpr7OALSJ37XWLXwDEQvY1uhwaj
kB46083w2Jt2ukkPiWa4MS97qWeruuRuBZg8/kzERKovFTA8mIx86wkbxVB4RnI7uw050BoMYlRj
cCvJJWlFmtWqHBj7WUOtSJWF17BmF5+Z7+q0y8xEbH/znnUoTJHhu/rCIkWp5JfHVLgMc6rVhOOM
v5ebZFirJr5hYcp5hdYI3LGXQZPGz4Mc49VXTInhcTYEdY12cIDdX/O0FeWjE4xVCilvua8yqo+Y
U6oTXXDjI1o/l1y6CE5Oe8kN3vrrOLBHXxhgArbaMrJCSfAq5IWTThV5cMoEHpdnJNm4Sj5u4EaK
gguZNpT3u1Lz9d62GLIKTPC0Xla9uoEgLM6jwoExC2AIDxSSArsBwYoIf2/c7my8kbJaR3dWW26+
d9XCvl3HoFJXvpr92EI6Br+Du8ObxEiMLlqALEkWs1hR01uzqKh5DZZsJCRFRZi1lFPf8F7cYIBQ
gbm8KnS3dCeIVDdtvl51vHWoIRE0szLWwSoZNhrM6vG98txrtyIKRRIJ9d81NHD8NSZ96bkieIXl
MFLW8Zte0PXJvzjQ+wRiFkSiXcxS7z7e6oesoUAC/1fXEP5jUjvcH/k0RQ6FG7ZHPPGGg8u/vVP6
bcE=
=rEOP
-----END PGP SIGNATURE-----

--------------ZNFhGmX4lcFYNFRaEF7DK9gt--

