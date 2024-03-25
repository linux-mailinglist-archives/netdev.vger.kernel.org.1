Return-Path: <netdev+bounces-81698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91A88AD88
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507BB1C3D74D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BB1F5E4;
	Mon, 25 Mar 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO4aSGE2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F946AD7
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388799; cv=none; b=UtCIl0AXbvd7CelSaPhsL7Z0hGsIEXb/h5c8z/hc41BepCGCmZzNnbEL3VfOVZJ88runPAMRJHfpYCDJN0+PUNMQ305tKhrFr6wkXIr7kN2ffQRzVjpoAtjW4BZcxqX7JGW0GK/kbnaTUddQU6mnWTUWYimuU3n14JHr+ou2lAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388799; c=relaxed/simple;
	bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e6WJrra+KG3UoRxZoqi3YCZiWibpaP5d8TUcr8ndAfzZxhIG77hvgkFT5Oftx8N1tIULFigPcL7zEZpxO3eXCPBQ5fUAWlrXCy5pGb2eJWkXP2ViAFjyWjlDA6/tCv7Py8w5O6xZLQ9dcS1f1qopOeYCMRh83J07HRXNjOZCrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO4aSGE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711388796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
	b=MO4aSGE2zGIsBi8tC6/iLvsFkDABGDQkplJ9vkhV5rmw0bj2/D/XBZhLEMrWXy6NlOZBBP
	F5QEiXRGswqmtBtQwK5vQoQy5R60+PrfPpEg3BANoVwNRsDrDecxpPBKW4sAxRG+GCKV7H
	jlza8SpoN5ZBMlBEhi30o4bt71yvd4I=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-VUAohMzJNI6Y55OMlfUOxQ-1; Mon, 25 Mar 2024 13:46:35 -0400
X-MC-Unique: VUAohMzJNI6Y55OMlfUOxQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4765ffe34c8so1704354137.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388794; x=1711993594;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
        b=XM7Anrg66ckPF7D6mJp44vTf6PEK/20kHv6uyxrFgKM0E8qCx5L4qxkKX1a//pLoYq
         EiFWIaBBYvkKQUW3LaRPH+G6KV9Ek9V7OY+3pFFoqNp928R2yED637WuXMnCza8aZX79
         V4EYDj9iOizJimdr7OIGR2/vjPk419NBKL7PHm+oAP6pjRFbIr1xRjH4Fr4grUxDTwIH
         H9pd/+OJud76jNObudML9o8BDFbaXezAq5nPyVpyyHVG/1sBArlZnTnwOuc0zPwDUeq/
         MAWsrVpF0JFv/bU0sH7yMhN0t3gpyjNEqUUMKE2qsR6RzDy2moMT68FL9Aqx5nYLTRzW
         0uuw==
X-Forwarded-Encrypted: i=1; AJvYcCUFk3FG0j0gJ64f518fNC4MWt5sMSOV7Ty913LjMB/wquf5+PhMOYIdqOhxPVMsN9pu2rhuTm/4/JN0e8jKjImWcy1dUfYm
X-Gm-Message-State: AOJu0YzuHSETWTM8X4qw06NRxII96B/eiEztOqxvvDOJJJzSqWmCvHbk
	VWuRhrOhp1D3jbd8hY6lJUS7fH3bgAZ5SBkfv3NwJUuuhtrCWQFAod6X37AXzUB67D5Uc14v15R
	To5sL/NRLag/Ts970KiUAij/grFXHh3fbc2CFxT7IzpLZkygtlpdeeA==
X-Received: by 2002:a05:6102:24b8:b0:476:9ac0:e8c4 with SMTP id s24-20020a05610224b800b004769ac0e8c4mr6424215vse.34.1711388792995;
        Mon, 25 Mar 2024 10:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRAPyMUUN927QUcejE1283d1/sx417oRydtG1Ws7LvvoFsKo7zkANOvXQauHyj5s+uSj9o1Q==
X-Received: by 2002:a05:6102:24b8:b0:476:9ac0:e8c4 with SMTP id s24-20020a05610224b800b004769ac0e8c4mr6424145vse.34.1711388791353;
        Mon, 25 Mar 2024 10:46:31 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a214400b00789e49808ffsm2289432qkm.105.2024.03.25.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:46:31 -0700 (PDT)
Date: Tue, 26 Mar 2024 02:46:26 +0900 (JST)
Message-Id: <20240326.024626.67077498140213947.syoshida@redhat.com>
To: edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
References: <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
	<20240325.183800.473265130872711273.syoshida@redhat.com>
	<CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyNSBNYXIgMjAyNCAxMTowNTozMyArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBNb24sIE1hciAyNSwgMjAyNCBhdCAxMDozOOKAr0FNIFNoaWdlcnUgWW9zaGlkYSA8c3lv
c2hpZGFAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gTW9uLCAyNSBNYXIgMjAyNCAxMDow
MToyNSArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPj4gPiBPbiBTdW4sIE1hciAyNCwgMjAy
NCBhdCA2OjA24oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9zaGlkYUByZWRoYXQuY29tPiB3cm90
ZToNCj4+ID4+DQo+PiA+PiBLTVNBTiByZXBvcnRlZCB1bmluaXQtdmFsdWUgYWNjZXNzIGluIF9f
aXBfbWFrZV9za2IoKSBbMV0uICBfX2lwX21ha2Vfc2tiKCkNCj4+ID4+IHRlc3RzIEhEUklOQ0wg
dG8ga25vdyBpZiB0aGUgc2tiIGhhcyBpY21waGRyLiBIb3dldmVyLCBIRFJJTkNMIGNhbiBjYXVz
ZSBhDQo+PiA+PiByYWNlIGNvbmRpdGlvbi4gSWYgY2FsbGluZyBzZXRzb2Nrb3B0KDIpIHdpdGgg
SVBfSERSSU5DTCBjaGFuZ2VzIEhEUklOQ0wNCj4+ID4+IHdoaWxlIF9faXBfbWFrZV9za2IoKSBp
cyBydW5uaW5nLCB0aGUgZnVuY3Rpb24gd2lsbCBhY2Nlc3MgaWNtcGhkciBpbiB0aGUNCj4+ID4+
IHNrYiBldmVuIGlmIGl0IGlzIG5vdCBpbmNsdWRlZC4gVGhpcyBjYXVzZXMgdGhlIGlzc3VlIHJl
cG9ydGVkIGJ5IEtNU0FOLg0KPj4gPj4NCj4+ID4+IENoZWNrIEZMT1dJX0ZMQUdfS05PV05fTkgg
b24gZmw0LT5mbG93aTRfZmxhZ3MgaW5zdGVhZCBvZiB0ZXN0aW5nIEhEUklOQ0wNCj4+ID4+IG9u
IHRoZSBzb2NrZXQuDQo+PiA+Pg0KPj4gPj4gWzFdDQo+PiA+DQo+PiA+IFdoYXQgaXMgdGhlIGtl
cm5lbCB2ZXJzaW9uIGZvciB0aGlzIHRyYWNlID8NCj4+DQo+PiBTb3JyeSwgSSB1c2VkIHRoZSBm
b2xsb3dpbmcgdmVyc2lvbjoNCj4+DQo+PiBDUFU6IDEgUElEOiAxNTcwOSBDb21tOiBzeXotZXhl
Y3V0b3IuNyBOb3QgdGFpbnRlZCA2LjguMC0xMTU2Ny1nYjM2MDNmY2I3OWIxICMyNQ0KPj4gSGFy
ZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1Mg
MS4xNi4zLTEuZmMzOSAwNC8wMS8yMDE0DQo+Pg0KPj4gPj4gQlVHOiBLTVNBTjogdW5pbml0LXZh
bHVlIGluIF9faXBfbWFrZV9za2IrMHgyYjc0LzB4MmQyMCBuZXQvaXB2NC9pcF9vdXRwdXQuYzox
NDgxDQo+PiA+PiAgX19pcF9tYWtlX3NrYisweDJiNzQvMHgyZDIwIG5ldC9pcHY0L2lwX291dHB1
dC5jOjE0ODENCj4+ID4+ICBpcF9maW5pc2hfc2tiIGluY2x1ZGUvbmV0L2lwLmg6MjQzIFtpbmxp
bmVdDQo+PiA+PiAgaXBfcHVzaF9wZW5kaW5nX2ZyYW1lcysweDRjLzB4NWMwIG5ldC9pcHY0L2lw
X291dHB1dC5jOjE1MDgNCj4+ID4+ICByYXdfc2VuZG1zZysweDIzODEvMHgyNjkwIG5ldC9pcHY0
L3Jhdy5jOjY1NA0KPj4gPj4gIGluZXRfc2VuZG1zZysweDI3Yi8weDJhMCBuZXQvaXB2NC9hZl9p
bmV0LmM6ODUxDQo+PiA+PiAgc29ja19zZW5kbXNnX25vc2VjIG5ldC9zb2NrZXQuYzo3MzAgW2lu
bGluZV0NCj4+ID4+ICBfX3NvY2tfc2VuZG1zZysweDI3NC8weDNjMCBuZXQvc29ja2V0LmM6NzQ1
DQo+PiA+PiAgX19zeXNfc2VuZHRvKzB4NjJjLzB4N2IwIG5ldC9zb2NrZXQuYzoyMTkxDQo+PiA+
PiAgX19kb19zeXNfc2VuZHRvIG5ldC9zb2NrZXQuYzoyMjAzIFtpbmxpbmVdDQo+PiA+PiAgX19z
ZV9zeXNfc2VuZHRvIG5ldC9zb2NrZXQuYzoyMTk5IFtpbmxpbmVdDQo+PiA+PiAgX194NjRfc3lz
X3NlbmR0bysweDEzMC8weDIwMCBuZXQvc29ja2V0LmM6MjE5OQ0KPj4gPj4gIGRvX3N5c2NhbGxf
NjQrMHhkOC8weDFmMCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo4Mw0KPj4gPj4gIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDZkLzB4NzUNCj4+ID4+DQo+PiA+PiBVbmluaXQgd2Fz
IGNyZWF0ZWQgYXQ6DQo+PiA+PiAgc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2x1Yi5jOjM4MDQg
W2lubGluZV0NCj4+ID4+ICBzbGFiX2FsbG9jX25vZGUgbW0vc2x1Yi5jOjM4NDUgW2lubGluZV0N
Cj4+ID4+ICBrbWVtX2NhY2hlX2FsbG9jX25vZGUrMHg1ZjYvMHhjNTAgbW0vc2x1Yi5jOjM4ODgN
Cj4+ID4+ICBrbWFsbG9jX3Jlc2VydmUrMHgxM2MvMHg0YTAgbmV0L2NvcmUvc2tidWZmLmM6NTc3
DQo+PiA+PiAgX19hbGxvY19za2IrMHgzNWEvMHg3YzAgbmV0L2NvcmUvc2tidWZmLmM6NjY4DQo+
PiA+PiAgYWxsb2Nfc2tiIGluY2x1ZGUvbGludXgvc2tidWZmLmg6MTMxOCBbaW5saW5lXQ0KPj4g
Pj4gIF9faXBfYXBwZW5kX2RhdGErMHg0OWFiLzB4NjhjMCBuZXQvaXB2NC9pcF9vdXRwdXQuYzox
MTI4DQo+PiA+PiAgaXBfYXBwZW5kX2RhdGErMHgxZTcvMHgyNjAgbmV0L2lwdjQvaXBfb3V0cHV0
LmM6MTM2NQ0KPj4gPj4gIHJhd19zZW5kbXNnKzB4MjJiMS8weDI2OTAgbmV0L2lwdjQvcmF3LmM6
NjQ4DQo+PiA+PiAgaW5ldF9zZW5kbXNnKzB4MjdiLzB4MmEwIG5ldC9pcHY0L2FmX2luZXQuYzo4
NTENCj4+ID4+ICBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0L3NvY2tldC5jOjczMCBbaW5saW5lXQ0K
Pj4gPj4gIF9fc29ja19zZW5kbXNnKzB4Mjc0LzB4M2MwIG5ldC9zb2NrZXQuYzo3NDUNCj4+ID4+
ICBfX3N5c19zZW5kdG8rMHg2MmMvMHg3YjAgbmV0L3NvY2tldC5jOjIxOTENCj4+ID4+ICBfX2Rv
X3N5c19zZW5kdG8gbmV0L3NvY2tldC5jOjIyMDMgW2lubGluZV0NCj4+ID4+ICBfX3NlX3N5c19z
ZW5kdG8gbmV0L3NvY2tldC5jOjIxOTkgW2lubGluZV0NCj4+ID4+ICBfX3g2NF9zeXNfc2VuZHRv
KzB4MTMwLzB4MjAwIG5ldC9zb2NrZXQuYzoyMTk5DQo+PiA+PiAgZG9fc3lzY2FsbF82NCsweGQ4
LzB4MWYwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjgzDQo+PiA+PiAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NmQvMHg3NQ0KPj4gPj4NCj4+ID4+IEZpeGVzOiA5OWU1YWNhZTE5
M2UgKCJpcHY0OiBGaXggcG90ZW50aWFsIHVuaW5pdCB2YXJpYWJsZSBhY2Nlc3MgYnVnIGluIF9f
aXBfbWFrZV9za2IoKSIpDQo+PiA+PiBSZXBvcnRlZC1ieTogc3l6a2FsbGVyIDxzeXprYWxsZXJA
Z29vZ2xlZ3JvdXBzLmNvbT4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFNoaWdlcnUgWW9zaGlkYSA8
c3lvc2hpZGFAcmVkaGF0LmNvbT4NCj4+ID4+IC0tLQ0KPj4gPj4gSSB0aGluayBJUHY2IGhhcyBh
IHNpbWlsYXIgaXNzdWUuIElmIHRoaXMgcGF0Y2ggaXMgYWNjZXB0ZWQsIEkgd2lsbCBzZW5kDQo+
PiA+PiBhIHBhdGNoIGZvciBJUHY2Lg0KPj4gPj4gLS0tDQo+PiA+PiAgbmV0L2lwdjQvaXBfb3V0
cHV0LmMgfCAyICstDQo+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+PiA+Pg0KPj4gPj4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L2lwX291dHB1dC5j
IGIvbmV0L2lwdjQvaXBfb3V0cHV0LmMNCj4+ID4+IGluZGV4IDFmZTc5NDk2NzIxMS4uMzkyMjlm
ZDA2MDFhIDEwMDY0NA0KPj4gPj4gLS0tIGEvbmV0L2lwdjQvaXBfb3V0cHV0LmMNCj4+ID4+ICsr
KyBiL25ldC9pcHY0L2lwX291dHB1dC5jDQo+PiA+PiBAQCAtMTQ3Myw3ICsxNDczLDcgQEAgc3Ry
dWN0IHNrX2J1ZmYgKl9faXBfbWFrZV9za2Ioc3RydWN0IHNvY2sgKnNrLA0KPj4gPj4gICAgICAg
ICAgICAgICAgICAqIGJ5IGljbXBfaGRyKHNrYiktPnR5cGUuDQo+PiA+PiAgICAgICAgICAgICAg
ICAgICovDQo+PiA+PiAgICAgICAgICAgICAgICAgaWYgKHNrLT5za190eXBlID09IFNPQ0tfUkFX
ICYmDQo+PiA+PiAtICAgICAgICAgICAgICAgICAgICFpbmV0X3Rlc3RfYml0KEhEUklOQ0wsIHNr
KSkNCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgIShmbDQtPmZsb3dpNF9mbGFncyAmIEZMT1dJ
X0ZMQUdfS05PV05fTkgpKQ0KPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgaWNtcF90eXBl
ID0gZmw0LT5mbDRfaWNtcF90eXBlOw0KPj4gPj4gICAgICAgICAgICAgICAgIGVsc2UNCj4+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgIGljbXBfdHlwZSA9IGljbXBfaGRyKHNrYiktPnR5cGU7
DQo+PiA+PiAtLQ0KPj4gPj4gMi40NC4wDQo+PiA+Pg0KPj4gPg0KPj4gPiBUaGFua3MgZm9yIHlv
dXIgcGF0Y2guDQo+PiA+DQo+PiA+IEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgZW5vdWdoLCBhcyBm
YXIgYXMgc3l6a2FsbGVyIGlzIGNvbmNlcm5lZC4NCj4+ID4NCj4+ID4gcmF3X3Byb2JlX3Byb3Rv
X29wdCgpIGNhbiBsZWF2ZSBnYXJiYWdlIGluIGZsNF9pY21wX3R5cGUgKGFuZCBmbDRfaWNtcF9j
b2RlKQ0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LiBCdXQgSSBkb24ndCB1bmRl
cnN0YW5kIGl0IGNsZWFybHkuIFdoYXQNCj4+IGV4YWN0bHkgZG8geW91IG1lYW4gYnkgImdhcmJh
Z2UiPw0KPj4NCj4+IHJhd19wcm9iZV9wcm90b19vcHQoKSBpbW1lZGlhdGVseSByZXR1cm5zIDAg
aWYgZmw0LT5mbG93aTRfcHJvdG8gaXMNCj4+IG5vdCBJUFBST1RPX0lDTVA6DQo+Pg0KPj4gc3Rh
dGljIGludCByYXdfcHJvYmVfcHJvdG9fb3B0KHN0cnVjdCByYXdfZnJhZ192ZWMgKnJmdiwgc3Ry
dWN0IGZsb3dpNCAqZmw0KQ0KPj4gew0KPj4gICAgICAgICBpbnQgZXJyOw0KPj4NCj4+ICAgICAg
ICAgaWYgKGZsNC0+Zmxvd2k0X3Byb3RvICE9IElQUFJPVE9fSUNNUCkNCj4+ICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4+DQo+PiBJbiB0aGlzIGNhc2UsIHRoZSBmdW5jdGlvbiBkb2Vzbid0
IHNldCBmbDRfaWNtcF90eXBlLiBEbyB5b3UgbWVhbiB0aGlzDQo+PiBjYXNlPw0KPiANCj4gVGhl
cmUgYXJlIG11bHRpcGxlIHdheXMgdG8gcmV0dXJuIGVhcmx5IGZyb20gdGhpcyBmdW5jdGlvbi4N
Cj4gDQo+IEluIGFsbCBvZiB0aGVtLCBmbDQtPmZsNF9pY21wX3R5cGUgaXMgbGVmdCB1bmluaXRp
YWxpemVkLCBzbyBzeXpib3QNCj4gd2lsbCBmaW5kIHdheXMgdG8gdHJpZ2dlciBhIHJlbGF0ZWQg
YnVnLA0KPiBpZiB5b3UgYXNzdW1lIGxhdGVyIHRoYXQgZmw0LT5mbDRfaWNtcF90eXBlIGNvbnRh
aW5zIHZhbGlkIChpbml0aWFsaXplZCkgZGF0YS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5
LiBJIHNlZSB5b3VyIHBvaW50Lg0KDQpmbDQtPmZsNF9pY21wX3R5cGUgaXMgcGFydCBvZiBmbG93
aV91bGkgdW5pb24gaW4gZmxvd2k0IHN0cnVjdHVyZSwgYW5kDQpmbG93aTRfaW5pdF9vdXRwdXQo
KSBpbml0aWFsaXplcyBmbDRfZHBvcnQgYW5kIGZsNF9zcG9ydCB0byB6ZXJvLg0KDQpJIHRob3Vn
aHQgdGhpcyBhbHNvIGluaXRpYWxpemVzIGZsNF9pY21wX3R5cGUgYW5kIGZsNF9pY21wX2NvZGUu
IERvDQp5b3UgdGhpbmsgd2Ugc2hvdWxkIGluaXRpYWxpemUgZmw0X2ljbXBfdHlwZSBhbmQgZmw0
X2ljbXBfY29kZQ0KZXhwbGljaXRseSwgb3RoZXJ3aXNlIGFtIEkgbWlzdW5kZXJzdGFuZGluZz8N
Cg0KVGhhbmtzLA0KU2hpZ2VydQ0K


