Return-Path: <netdev+bounces-98114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E68CF760
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 04:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECA1F21BFB
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AF65C;
	Mon, 27 May 2024 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekaRMcxg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55134653;
	Mon, 27 May 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775247; cv=none; b=KQnu+T12oDCS4MNcwNqm0W/4+4Pkg2P4YejureJfJWwPO5Cim3bhYJ89QEqlrV30qtCxp6mh5ZBmu9/FESJYFeSuPead9ishpzBybqrREISvX8fyrWdEsvzHq+qqKg0Uvrk+5mC7idABsWQ03+fpWVyUCihuq/IAPsf5lyHwfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775247; c=relaxed/simple;
	bh=ctWiv0pC9SqzWM/MujflPIZFnUTSkuqfQfgBDXVtC2U=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TD7eueNnez5em44Ot6LxFPJB1s9xohw10Iabxkgi2IGNG6ZpWIfXpL3D8HEf6HaGCQ1apZQfriWzFeyeDkWiEd71JRT204sf51mnmG6xnDIpl0uZ0uF+rq5OCVMEW/XXdz60NrDaOIp8gvgXDOTaF1TaPwl5G3AtpZejS+vHuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekaRMcxg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-64f12fc9661so482096a12.3;
        Sun, 26 May 2024 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716775244; x=1717380044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctWiv0pC9SqzWM/MujflPIZFnUTSkuqfQfgBDXVtC2U=;
        b=ekaRMcxgoE0YqR9kWb2MXRnkH5JdqezjvmIQGzGl9syXy2ifTOmuh2vpXVnkran2xR
         Xu5q/WhvZWYayQgVvr66ASJxzqAWsFmDdHum2PuEUn+CaYr2rdADUEbesuceLL1bzKbZ
         F453XmLRF3DsOKpj1RgYFvhYQN68/ZQifYYQgNnm2DYzIjAVS97DX7VBxlQktW4hQcpc
         VMIVJ+hBswKHIhsh6DYKpKjRdYlIuq9PNPj2N3BkMv6TJ0iUfRAB0AefJ0cMRkiqGf1d
         fLmnGp4YQs6xTA1fb+mTgom1KGH3mMd14lKrn686LYlF5gLDwKrgs/SzrjHH2G6XZBSG
         PC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716775244; x=1717380044;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ctWiv0pC9SqzWM/MujflPIZFnUTSkuqfQfgBDXVtC2U=;
        b=IM1zA3xy3oulBIxnWLY0vV9310QeseKDLcB51aMmTbAZEqbswdv4/e9Gg7p8SUdf3I
         Eu+sFMa+fSR1W0f51pLqnXwtAv6stWZLRZBj77mm9/6MQkXWtfloZhahqyKaTadZIxcX
         5fPPoKcdr9rPxiSTxIuzBn6ggknRoQDXQf9xqFjXYhmE9XwcfggU5q6SDu413Y5nazf6
         ddLnx7O1EUfpQJX189epGh71F+4hMV7a4ZNDsEnDmU3NIHf9hhhvaVS8tY/V5WRcO7lP
         wvSpD/dEqonb7JBzG6LAxYNCoqlT3qT+IjZk7qOX9yJ1iKDuLrfDiY1rFFYQXg95A1Xt
         5IZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3BRPzeCc0hZ88nyPhVnZLcrNn9xs/44qzfsDE19zx8+P1n8k0b+gnVwzce+wzED8ZhN6Lu07nEs4wJ4VIvOuXNCV90ltOTr2NSFsixhEvYvWtnbm8TOAwxpj+Jf1x8odUXlxxow=
X-Gm-Message-State: AOJu0Yye30tOPFB3XHc+t1GcPvlAugnaEzaKSizJ1Qr2EvhSoOZ1BSE0
	cNk6t0rpmSD+Qzo/TBWF0Fl6U1KNSS/icFsJIbEosm+kTE0Mi34I
X-Google-Smtp-Source: AGHT+IH7uATPGo5J3aTuTT6u6sgX24Pe5Wvj4QbKJ3mNR6pTXaIq76ucFsy8wzD3LWBs45E9126kLw==
X-Received: by 2002:a05:6a21:81a7:b0:1ad:8f18:8621 with SMTP id adf61e73a8af0-1b212f7af7cmr7629417637.6.1716775244525;
        Sun, 26 May 2024 19:00:44 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481c24d13sm17910495ad.202.2024.05.26.19.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 19:00:44 -0700 (PDT)
Date: Mon, 27 May 2024 11:00:31 +0900 (JST)
Message-Id: <20240527.110031.1543730602683806299.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47t0FDS59xckUV0QkozbX-RAs8U3woN_sBc0TVm8d=dKNA@mail.gmail.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
	<20240415104701.4772-3-fujita.tomonori@gmail.com>
	<CALNs47t0FDS59xckUV0QkozbX-RAs8U3woN_sBc0TVm8d=dKNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQpTb3JyeSBhYm91dCB0aGUgbG9uZyBkZWxheSwNCg0KT24gTW9uLCAxNSBBcHIgMjAyNCAy
MzoyNToyMiAtMDQwMA0KVHJldm9yIEdyb3NzIDx0bWdyb3NzQHVtaWNoLmVkdT4gd3JvdGU6DQoN
Cj4gT24gTW9uLCBBcHIgMTUsIDIwMjQgYXQgNjo0N+KAr0FNIEZVSklUQSBUb21vbm9yaQ0KPiA8
ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiArICAgIC8vLyBSZWFkcyBhIGdp
dmVuIEM0NSBQSFkgcmVnaXN0ZXIuDQo+PiArICAgIC8vLyBUaGlzIGZ1bmN0aW9uIHJlYWRzIGEg
aGFyZHdhcmUgcmVnaXN0ZXIgYW5kIHVwZGF0ZXMgdGhlIHN0YXRzIHNvIHRha2VzIGAmbXV0IHNl
bGZgLg0KPj4gKyAgICBwdWIgZm4gYzQ1X3JlYWQoJm11dCBzZWxmLCBkZXZhZDogdTgsIHJlZ251
bTogdTE2KSAtPiBSZXN1bHQ8dTE2PiB7DQo+PiArICAgICAgICBsZXQgcGh5ZGV2ID0gc2VsZi4w
LmdldCgpOw0KPj4gKyAgICAgICAgLy8gU0FGRVRZOiBgcGh5ZGV2YCBpcyBwb2ludGluZyB0byBh
IHZhbGlkIG9iamVjdCBieSB0aGUgdHlwZSBpbnZhcmlhbnQgb2YgYFNlbGZgLg0KPj4gKyAgICAg
ICAgLy8gU28gaXQncyBqdXN0IGFuIEZGSSBjYWxsLg0KPiANCj4gRGVwZW5kaW5nIG9uIHRoZSBy
ZXNwb25zZSB0byBBbmRyZXcncyBub3RlcywgdGhlc2UgU0FGRVRZIGNvbW1lbnRzDQo+IHdpbGwg
cHJvYmFibHkgbmVlZCB0byBiZSB1cGRhdGVkIHRvIHNheSB3aHkgd2Uga25vdyBDNDUgaXMgc3Vw
cG9ydGVkLg0KDQpJZiBhIGRyaXZlciB1c2VzIG9ubHktYzQ1IEFQSSAoUmVnQzQ1RGlyZWN0IGlu
IHRoZSBuZXcgcGF0Y2gpLCBpdCByZXR1cm5zDQphbiBlcnJvci4gV2UgbmVlZCB0byB3cml0ZSBz
b21ldGhpbmcgaW4gU0FGRVRZPw0KDQoNCj4+ICsgICAgICAgIGxldCByZXQgPSB1bnNhZmUgew0K
Pj4gKyAgICAgICAgICAgIGJpbmRpbmdzOjptZGlvYnVzX2M0NV9yZWFkKA0KPj4gKyAgICAgICAg
ICAgICAgICAoKnBoeWRldikubWRpby5idXMsDQo+PiArICAgICAgICAgICAgICAgICgqcGh5ZGV2
KS5tZGlvLmFkZHIsDQo+PiArICAgICAgICAgICAgICAgIGRldmFkIGFzIGkzMiwNCj4gDQo+IFRo
aXMgY291bGQgcHJvYmFibHkgYWxzbyBiZSBmcm9tLy5pbnRvKCkNCg0KRml4ZWQuDQoNCj4+ICsg
ICAgICAgICAgICAgICAgcmVnbnVtLmludG8oKSwNCj4+ICsgICAgICAgICAgICApDQo+PiArICAg
ICAgICB9Ow0KPj4gKyAgICAgICAgaWYgcmV0IDwgMCB7DQo+PiArICAgICAgICAgICAgRXJyKEVy
cm9yOjpmcm9tX2Vycm5vKHJldCkpDQo+PiArICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAg
ICAgIE9rKHJldCBhcyB1MTYpDQo+PiArICAgICAgICB9DQo+IA0KPiBDb3VsZCB0aGlzIGJlIHNp
bXBsaWZpZWQgd2l0aCB0b19yZXN1bHQ/DQoNCnRvX3Jlc3VsdCByZXR1cm5zIE9rKCgpKS4gU28g
SSB0aGluayB0aGF0IHdlIG5lZWQgc29tZXRoaW5nDQp0b19yZXN1bHRfd2l0aF92YWx1ZSgpLg0K
DQpJIHRoaW5rIHRoYXQgd2UgZGlzY3Vzc2VkIHNvbWV0aGluZyBsaWtlIHRoYXQgYWdvOg0KDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FOaXE3Mj1WYU50Wl9CMGppOTR4RmZ0YjRQY3Rm
ZXArNGMyY05Xa21DY0tocFpZMmtRQG1haWwuZ21haWwuY29tLw0KDQpBIG5ldyBmdW5jdGlvbiB3
YXMgaW50cm9kdWNlZCwgd2hpY2ggSSBtaXNzZWQ/DQoNCg0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIC8vLyBXcml0ZXMgYSBnaXZlbiBDNDUgUEhZIHJlZ2lzdGVyLg0KPj4gKyAgICBwdWIgZm4g
YzQ1X3dyaXRlKCZtdXQgc2VsZiwgZGV2YWQ6IHU4LCByZWdudW06IHUxNiwgdmFsOiB1MTYpIC0+
IFJlc3VsdCB7DQo+PiArICAgICAgICBsZXQgcGh5ZGV2ID0gc2VsZi4wLmdldCgpOw0KPj4gKyAg
ICAgICAgLy8gU0FGRVRZOiBgcGh5ZGV2YCBpcyBwb2ludGluZyB0byBhIHZhbGlkIG9iamVjdCBi
eSB0aGUgdHlwZSBpbnZhcmlhbnQgb2YgYFNlbGZgLg0KPj4gKyAgICAgICAgLy8gU28gaXQncyBq
dXN0IGFuIEZGSSBjYWxsLg0KPj4gKyAgICAgICAgdG9fcmVzdWx0KHVuc2FmZSB7DQo+PiArICAg
ICAgICAgICAgYmluZGluZ3M6Om1kaW9idXNfYzQ1X3dyaXRlKA0KPj4gKyAgICAgICAgICAgICAg
ICAoKnBoeWRldikubWRpby5idXMsDQo+PiArICAgICAgICAgICAgICAgICgqcGh5ZGV2KS5tZGlv
LmFkZHIsDQo+PiArICAgICAgICAgICAgICAgIGRldmFkIGFzIGkzMiwNCj4gDQo+IFNhbWUgYXMg
YWJvdmUNCg0KRml4ZWQuDQo=

