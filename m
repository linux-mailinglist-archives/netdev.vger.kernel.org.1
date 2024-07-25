Return-Path: <netdev+bounces-113012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBB93C397
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990AD1C20F9A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A219B3D7;
	Thu, 25 Jul 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVusarto"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6E199396
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916356; cv=none; b=PYtbiY2hP89aRdqBZnkrmfNlsgbC5TAku2pkP2oKtbRZkgCJBlJDDK+wnQvwNOzT0eXFp/3a2XcgFxKDmR2QGf1VyLY2gxo+qRguzLlfXH66ZUYz9lOgzZgjXO4SiuShibF+I1HGjo8SojpemBwXxglRH/ts+QCCaoLpsTXW16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916356; c=relaxed/simple;
	bh=W5Kg4EFQZinX7XCNpi6FmDKVU1WsRm/OqV1Vif5vdR4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZOXco2Kf16fwpXuirhaY8c3ifjGEgOjoHgZWniaf/Xw+ekygrydQatqvaJsDpwkp87D4sbIgeElfmcZyMY0ttLlLZNbDaDzBYPBIem3JatzggR8vT8a3EEX1LjDQofMvVrxlwYQnEUWf3jQFm1BrRYm7cdjd3cr/MzYKQw6ZYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVusarto; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721916354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5Kg4EFQZinX7XCNpi6FmDKVU1WsRm/OqV1Vif5vdR4=;
	b=OVusartokCznUc3b6JexC4r0YOaGfveaYPN67V7Nf1E6KzWT9FNZz3TUTVfKaFNjTLwXyw
	IXRB214k+0At6UVsOG2h8G0M44SNYOMC4s5Wkah/0RTjeWsWQRwfdy6pTloMPdeRlS++zo
	1FdoSeWHo34xSpBuqp79mlOC2Pga95E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-mwRVtgf9PdCStBi5TIKGvQ-1; Thu, 25 Jul 2024 10:05:53 -0400
X-MC-Unique: mwRVtgf9PdCStBi5TIKGvQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc54c57a92so8770705ad.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916352; x=1722521152;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5Kg4EFQZinX7XCNpi6FmDKVU1WsRm/OqV1Vif5vdR4=;
        b=Q69L0B8tW4/AB5MziUujXVHOohCebN0ZFUueFDEOQvGuD8y88JxsJr2opmnpiC1Mm5
         YyYXYewTUyjY9vZMBdrN4YDoTxCPFfVpv3uXJ1omwK4DblzXE/uUed5EMexciZIBQ9dt
         xmKnN38tAwUebjBK2inslVrd0ZdSs4rwCTW8VtWSiX7BaD8i8+4Fc5lBVJbJ94edxtFk
         SGgq8J/FJsG3QM4P7b8EjPAO/ZVqyCU4yJYJ0jUbmO0i2p9BwLnBjm1Yay5+TesOigRG
         yy7H3I1AQx0sKEFNyFq+pyN55OneGGlm2nRG48El87/BPJrsr40Qeg1mOyYUVZSgQdrx
         2t9w==
X-Forwarded-Encrypted: i=1; AJvYcCWILwIxHU0UNfQnZ7myn+qqzAdtm1xFfv7RimOFP/Z5GeBpRDuOezaAlWCq75LUcj22tgahKw84Txkw7v5wJgDBYzYr8B08
X-Gm-Message-State: AOJu0Yx94yN9Rk0OncOfUdMsNZgkFfhTUASl9NTDyepOyhtcj2qeyExO
	I2nIo5Ckj07GbRyKHHPZgyYpIIU0rvWkgCCYVRjanWmJbxRw/SjxgRUjwOHO7mBF8fDsvPkp1va
	ln72pPRuFxRdyBFVeAz07Jz4yJIW4RLi9auAwHnK+2G46Jd7k+onz3etJjAYCiJlL
X-Received: by 2002:a17:903:2312:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-1fed3534a48mr33361515ad.8.1721916351716;
        Thu, 25 Jul 2024 07:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElVoZm54a9fJ1yDM0mW6PpMjMoDXuNhxR0YyLGmEhx/WIenlw9g6B1oAcWejn8kcmoZ6Yqiw==
X-Received: by 2002:a17:903:2312:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-1fed3534a48mr33359785ad.8.1721916349869;
        Thu, 25 Jul 2024 07:05:49 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffb53csm14454035ad.304.2024.07.25.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:05:49 -0700 (PDT)
Date: Thu, 25 Jul 2024 23:05:42 +0900 (JST)
Message-Id: <20240725.230542.2159475514876691347.syoshida@redhat.com>
To: pabeni@redhat.com, edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macvlan: Return error on
 register_netdevice_notifier() failure
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89iL_fyHeEh0ymxYuSEtNg10wnzPbaOo06xToejMmDxRHNA@mail.gmail.com>
References: <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
	<d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
	<CANn89iL_fyHeEh0ymxYuSEtNg10wnzPbaOo06xToejMmDxRHNA@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

SGkgRXJpYywgUGFvbG8sDQoNCk9uIFRodSwgMjUgSnVsIDIwMjQgMTM6NTM6MjcgKzAyMDAsIEVy
aWMgRHVtYXpldCB3cm90ZToNCj4gT24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMTI6MTPigK9QTSBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gT24g
Ny8yNS8yNCAxMTo0NCwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPj4gPiBPbiBXZWQsIEp1bCAyNCwg
MjAyNCBhdCAzOjU24oCvUE0gU2hpZ2VydSBZb3NoaWRhIDxzeW9zaGlkYUByZWRoYXQuY29tPiB3
cm90ZToNCj4+ID4+DQo+PiA+PiByZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXIoKSBtYXkgZmFp
bCwgYnV0IG1hY3ZsYW5faW5pdF9tb2R1bGUoKSBkb2VzDQo+PiA+PiBub3QgaGFuZGxlIHRoZSBm
YWlsdXJlLiAgSGFuZGxlIHRoZSBmYWlsdXJlIGJ5IHJldHVybmluZyBhbiBlcnJvci4NCj4+ID4N
Cj4+ID4gSG93IGNvdWxkIHRoaXMgZmFpbCBleGFjdGx5ID8gUGxlYXNlIHByb3ZpZGUgZGV0YWls
cywgYmVjYXVzZSBJIGRvIG5vdA0KPj4gPiB0aGluayBpdCBjYW4uDQo+Pg0KPj4gWXVwLCBpdCBs
b29rcyBsaWtlIHRoZSByZWdpc3RyYXRpb24gY2FuJ3QgZmFpbCBmb3IgbWFjdmxhbi4NCj4+DQo+
PiBJdCdzIGJldHRlciB0byBhdm9pZCBhZGRpbmcgdW5uZWVkZWQgY2hlY2tzLCB0byByZWR1Y2Ug
bm9pc2Ugb24gdGhlDQo+PiB0cmVlLCBrZWVwIHN0YWJsZSBiYWNrcG9ydCBlYXN5LCBldGMuDQoN
ClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cywgYW5kIGl0J3MgbXkgYmFkLCBzb3JyeS4NCg0K
SSBoYXBwZW5lZCB0byBsb29rIGF0IG1hY3ZsYW4ncyBjb2RlIGFuZCBmb3VuZCB0aGlzLiAgSSBj
b21wYXJlZCB0aGlzDQp3aXRoIG90aGVycyBsaWtlIG1hY3Z0YXAgYW5kIEkgYXNzdW1lZCB0aGF0
IHJlZ2lzdGVyaW5nIGZvciBub3RpZmllcg0KbmVlZHMgZXJyb3IgaGFuZGxpbmcgd2l0aG91dCBj
aGVja2luZyBjYXJlZnVsbHkuDQoNCj4gU2hpZ2VydSwgeW91IGNvdWxkIHNlbmQgYSBkZWJ1ZyBw
YXRjaCB3aGVuIG5ldC1uZXh0IHJlb3BlbnMgbmV4dCB3ZWVrLA0KPiBzbyB0aGF0IHdlIGRvIG5v
dCBnZXQgYW5vdGhlciBhdHRlbXB0DQo+IG9uIGZpeGluZyBhIG5vbi1leGlzdGVudCBidWcuDQoN
CkkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0aGlzIERFQlVHX05FVF9XQVJOX09OX09OQ0UoKSBiZWNh
dXNlIGl0IG1ha2VzDQp0aGUgc291cmNlIGNvZGUgYSBsaXR0bGUgbWVzc3kuDQoNCk5leHQgdGlt
ZSBJIGZpbmQgc29tZXRoaW5nLCBJJ2xsIGJlIG1vcmUgY2FyZWZ1bC4NCg0KVGhhbmtzLA0KU2hp
Z2VydQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9tYWN2bGFuLmMgYi9kcml2ZXJzL25l
dC9tYWN2bGFuLmMNCj4gaW5kZXggMjQyOThhMzNlMGU5NDg1MWViZjljNzA0YzcyM2YyNWFjN2Jm
NWVlYy4uMDgwM2ZjZjhkZjRjNTZlZGUxMDU5N2M4NjIyODhjN2FhODg3MTYwZQ0KPiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvbWFjdmxhbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L21hY3Zs
YW4uYw0KPiBAQCAtMTg0OSw3ICsxODQ5LDggQEAgc3RhdGljIGludCBfX2luaXQgbWFjdmxhbl9p
bml0X21vZHVsZSh2b2lkKQ0KPiAgew0KPiAgICAgICAgIGludCBlcnI7DQo+IA0KPiAtICAgICAg
IHJlZ2lzdGVyX25ldGRldmljZV9ub3RpZmllcigmbWFjdmxhbl9ub3RpZmllcl9ibG9jayk7DQo+
ICsgICAgICAgZXJyID0gcmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVyKCZtYWN2bGFuX25vdGlm
aWVyX2Jsb2NrKTsNCj4gKyAgICAgICBERUJVR19ORVRfV0FSTl9PTl9PTkNFKGVyciA8IDApOw0K
PiANCj4gICAgICAgICBlcnIgPSBtYWN2bGFuX2xpbmtfcmVnaXN0ZXIoJm1hY3ZsYW5fbGlua19v
cHMpOw0KPiAgICAgICAgIGlmIChlcnIgPCAwKQ0KPiANCg==


