Return-Path: <netdev+bounces-83190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8862F8914F5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAB2836ED
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC53BBDD;
	Fri, 29 Mar 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSAHhK2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52402405CD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699377; cv=none; b=HOPtsGxLCmL2z2ymlEzL9xMYxtVP2hPE8+P1SZ/TJ8GyxWa9T6+v+7QAAQud9/StQ9Ob8cNh2pfUDXlf1X/WPEGHkCiK7tYHc2Gex3yux0jd0ond1GvvbKoeJG51lvzBUNeqyEvzN8QQpcXJACHpvtdRTSeWIXoPuViAWBVy68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699377; c=relaxed/simple;
	bh=+Gcn3/NR6sZBGDOMKwpwlaRWVK8Mm/OaWdeWp3FevCs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tzGyt119Ygzboc7udvE+dz6zgi9uk2Kek4y+URZ2TERN4TyIJgqHUn1+k2ZvU88r8s7/iqXmosPnRzYCkWjv5+NrpCtrrOmP/DY6H7SaJJd1nNozF1bohu0/sTR0/qIKmZFSWwtBm1PXqMb70ZS+M89ae+TOs6urhy0TuPZJyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSAHhK2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711699374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Gcn3/NR6sZBGDOMKwpwlaRWVK8Mm/OaWdeWp3FevCs=;
	b=QSAHhK2LGRSYM4DKVKmnf2sEDE1zg1E7ZySSR+wh00B3Ec7TMuE4JTyMsqMtuVvTOKbUOU
	KGFo09wDEHEsc9/21G7jazyTnI/60A2r9fKtkAKxLj+qL3RZI0sjxveKmM3/kwt6a6uYOX
	7uTCnYPFdpXki5KnGOiuxiB/2XXO7ag=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-2fRoS0jjPdmkrKp8dOcYyw-1; Fri, 29 Mar 2024 04:02:52 -0400
X-MC-Unique: 2fRoS0jjPdmkrKp8dOcYyw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430ac211fbbso17779421cf.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711699372; x=1712304172;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Gcn3/NR6sZBGDOMKwpwlaRWVK8Mm/OaWdeWp3FevCs=;
        b=aN9HrccPh+enO4WXT0YBviIiara69RUf+NHG1oUyTTdxVrK9gdK09MnY99YRW8M0S2
         9gz9lrwzvOuigUSxzA2ybjfN0MTy0vbIcxqz+WJ7RGFsi5jMHOWfGuGa/wxNU+VXCVBI
         cjNH4aN5aRPwKU1MEyOc/wY8npa1AUw5eSC172ZdgTQEls89OzYBkQ3uX63BX3wPUvT6
         y74Fn1s0cwDrpKTs3UsLfCDpMFfA8Eblt3H2BiRCHBhFvx+WmJ7EEu+HfvcECf7pfGvz
         Y6aWHDyG6hf1zYCPkwbTlC8zUE8jq5EXKYcHKjSnoe7Yp7If0gFyTfi0qbV2VLM5p1dN
         6RmA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Ji2GoyAhSHGV8FG+agVKcxC5YVUi+cdujURUCa87j9JrLDSPb9FP/hdfRhLOwznwDiUhyWxH7F0lKIK2lBgB5Xkur3bY
X-Gm-Message-State: AOJu0YxvTPaiCcxli6WLKG2CRTg2WEOl3xPyGZcb1TbkMqHX0yOl+x5+
	P0wfx7PgF97Cd2xRXxPGKmq3zLQgF+MvZSp2ZsJ2UlsT77/Sao0KFfHuWDERiq7kTXgaQGOQxd6
	DKE3XQjVUj6Kmk6A3WfrDGAWRXi97l0SzLD7evwSTS+G0e0Xmc6vSgg==
X-Received: by 2002:a05:622a:138e:b0:431:404b:3df8 with SMTP id o14-20020a05622a138e00b00431404b3df8mr2041552qtk.15.1711699371940;
        Fri, 29 Mar 2024 01:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqV4UDM26MIzbDIk1QBP/pXDIMr25IbXjyFhkD4xE/X6RO/K5v7FwtzjI+zzN3HMqJJWR4BQ==
X-Received: by 2002:a05:622a:138e:b0:431:404b:3df8 with SMTP id o14-20020a05622a138e00b00431404b3df8mr2041528qtk.15.1711699371534;
        Fri, 29 Mar 2024 01:02:51 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:7d25:e853:5f28:2681])
        by smtp.gmail.com with ESMTPSA id ex9-20020a05622a518900b00432b5c9b9ecsm1258388qtb.14.2024.03.29.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:02:51 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:02:47 +0900 (JST)
Message-Id: <20240329.170246.1825102369004338059.syoshida@redhat.com>
To: edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89i+uOWhSmgudL+84e-2wow0mNLKe0f_bn5qCVoEUf+dJ=Q@mail.gmail.com>
References: <CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
	<20240326.024626.67077498140213947.syoshida@redhat.com>
	<CANn89i+uOWhSmgudL+84e-2wow0mNLKe0f_bn5qCVoEUf+dJ=Q@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyNSBNYXIgMjAyNCAyMDo1Njo0MyArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBNb24sIE1hciAyNSwgMjAyNCBhdCA2OjQ24oCvUE0gU2hpZ2VydSBZb3NoaWRhIDxzeW9z
aGlkYUByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBNb24sIDI1IE1hciAyMDI0IDExOjA1
OjMzICswMTAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+PiA+IE9uIE1vbiwgTWFyIDI1LCAyMDI0
IGF0IDEwOjM44oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9zaGlkYUByZWRoYXQuY29tPiB3cm90
ZToNCj4+ID4+DQo+PiA+PiBPbiBNb24sIDI1IE1hciAyMDI0IDEwOjAxOjI1ICswMTAwLCBFcmlj
IER1bWF6ZXQgd3JvdGU6DQo+PiA+PiA+IE9uIFN1biwgTWFyIDI0LCAyMDI0IGF0IDY6MDbigK9B
TSBTaGlnZXJ1IFlvc2hpZGEgPHN5b3NoaWRhQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gPj4gPj4N
Cj4+ID4+ID4+IEtNU0FOIHJlcG9ydGVkIHVuaW5pdC12YWx1ZSBhY2Nlc3MgaW4gX19pcF9tYWtl
X3NrYigpIFsxXS4gIF9faXBfbWFrZV9za2IoKQ0KPj4gPj4gPj4gdGVzdHMgSERSSU5DTCB0byBr
bm93IGlmIHRoZSBza2IgaGFzIGljbXBoZHIuIEhvd2V2ZXIsIEhEUklOQ0wgY2FuIGNhdXNlIGEN
Cj4+ID4+ID4+IHJhY2UgY29uZGl0aW9uLiBJZiBjYWxsaW5nIHNldHNvY2tvcHQoMikgd2l0aCBJ
UF9IRFJJTkNMIGNoYW5nZXMgSERSSU5DTA0KPj4gPj4gPj4gd2hpbGUgX19pcF9tYWtlX3NrYigp
IGlzIHJ1bm5pbmcsIHRoZSBmdW5jdGlvbiB3aWxsIGFjY2VzcyBpY21waGRyIGluIHRoZQ0KPj4g
Pj4gPj4gc2tiIGV2ZW4gaWYgaXQgaXMgbm90IGluY2x1ZGVkLiBUaGlzIGNhdXNlcyB0aGUgaXNz
dWUgcmVwb3J0ZWQgYnkgS01TQU4uDQo+PiA+PiA+Pg0KPj4gPj4gPj4gQ2hlY2sgRkxPV0lfRkxB
R19LTk9XTl9OSCBvbiBmbDQtPmZsb3dpNF9mbGFncyBpbnN0ZWFkIG9mIHRlc3RpbmcgSERSSU5D
TA0KPj4gPj4gPj4gb24gdGhlIHNvY2tldC4NCj4+ID4+ID4+DQo+PiA+PiA+PiBbMV0NCj4+ID4+
ID4NCj4+ID4+ID4gV2hhdCBpcyB0aGUga2VybmVsIHZlcnNpb24gZm9yIHRoaXMgdHJhY2UgPw0K
Pj4gPj4NCj4+ID4+IFNvcnJ5LCBJIHVzZWQgdGhlIGZvbGxvd2luZyB2ZXJzaW9uOg0KPj4gPj4N
Cj4+ID4+IENQVTogMSBQSUQ6IDE1NzA5IENvbW06IHN5ei1leGVjdXRvci43IE5vdCB0YWludGVk
IDYuOC4wLTExNTY3LWdiMzYwM2ZjYjc5YjEgIzI1DQo+PiA+PiBIYXJkd2FyZSBuYW1lOiBRRU1V
IFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE2LjMtMS5mYzM5IDA0
LzAxLzIwMTQNCj4+ID4+DQo+PiA+PiA+PiBCVUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX19p
cF9tYWtlX3NrYisweDJiNzQvMHgyZDIwIG5ldC9pcHY0L2lwX291dHB1dC5jOjE0ODENCj4+ID4+
ID4+ICBfX2lwX21ha2Vfc2tiKzB4MmI3NC8weDJkMjAgbmV0L2lwdjQvaXBfb3V0cHV0LmM6MTQ4
MQ0KPj4gPj4gPj4gIGlwX2ZpbmlzaF9za2IgaW5jbHVkZS9uZXQvaXAuaDoyNDMgW2lubGluZV0N
Cj4+ID4+ID4+ICBpcF9wdXNoX3BlbmRpbmdfZnJhbWVzKzB4NGMvMHg1YzAgbmV0L2lwdjQvaXBf
b3V0cHV0LmM6MTUwOA0KPj4gPj4gPj4gIHJhd19zZW5kbXNnKzB4MjM4MS8weDI2OTAgbmV0L2lw
djQvcmF3LmM6NjU0DQo+PiA+PiA+PiAgaW5ldF9zZW5kbXNnKzB4MjdiLzB4MmEwIG5ldC9pcHY0
L2FmX2luZXQuYzo4NTENCj4+ID4+ID4+ICBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0L3NvY2tldC5j
OjczMCBbaW5saW5lXQ0KPj4gPj4gPj4gIF9fc29ja19zZW5kbXNnKzB4Mjc0LzB4M2MwIG5ldC9z
b2NrZXQuYzo3NDUNCj4+ID4+ID4+ICBfX3N5c19zZW5kdG8rMHg2MmMvMHg3YjAgbmV0L3NvY2tl
dC5jOjIxOTENCj4+ID4+ID4+ICBfX2RvX3N5c19zZW5kdG8gbmV0L3NvY2tldC5jOjIyMDMgW2lu
bGluZV0NCj4+ID4+ID4+ICBfX3NlX3N5c19zZW5kdG8gbmV0L3NvY2tldC5jOjIxOTkgW2lubGlu
ZV0NCj4+ID4+ID4+ICBfX3g2NF9zeXNfc2VuZHRvKzB4MTMwLzB4MjAwIG5ldC9zb2NrZXQuYzoy
MTk5DQo+PiA+PiA+PiAgZG9fc3lzY2FsbF82NCsweGQ4LzB4MWYwIGFyY2gveDg2L2VudHJ5L2Nv
bW1vbi5jOjgzDQo+PiA+PiA+PiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NmQv
MHg3NQ0KPj4gPj4gPj4NCj4+ID4+ID4+IFVuaW5pdCB3YXMgY3JlYXRlZCBhdDoNCj4+ID4+ID4+
ICBzbGFiX3Bvc3RfYWxsb2NfaG9vayBtbS9zbHViLmM6MzgwNCBbaW5saW5lXQ0KPj4gPj4gPj4g
IHNsYWJfYWxsb2Nfbm9kZSBtbS9zbHViLmM6Mzg0NSBbaW5saW5lXQ0KPj4gPj4gPj4gIGttZW1f
Y2FjaGVfYWxsb2Nfbm9kZSsweDVmNi8weGM1MCBtbS9zbHViLmM6Mzg4OA0KPj4gPj4gPj4gIGtt
YWxsb2NfcmVzZXJ2ZSsweDEzYy8weDRhMCBuZXQvY29yZS9za2J1ZmYuYzo1NzcNCj4+ID4+ID4+
ICBfX2FsbG9jX3NrYisweDM1YS8weDdjMCBuZXQvY29yZS9za2J1ZmYuYzo2NjgNCj4+ID4+ID4+
ICBhbGxvY19za2IgaW5jbHVkZS9saW51eC9za2J1ZmYuaDoxMzE4IFtpbmxpbmVdDQo+PiA+PiA+
PiAgX19pcF9hcHBlbmRfZGF0YSsweDQ5YWIvMHg2OGMwIG5ldC9pcHY0L2lwX291dHB1dC5jOjEx
MjgNCj4+ID4+ID4+ICBpcF9hcHBlbmRfZGF0YSsweDFlNy8weDI2MCBuZXQvaXB2NC9pcF9vdXRw
dXQuYzoxMzY1DQo+PiA+PiA+PiAgcmF3X3NlbmRtc2crMHgyMmIxLzB4MjY5MCBuZXQvaXB2NC9y
YXcuYzo2NDgNCj4+ID4+ID4+ICBpbmV0X3NlbmRtc2crMHgyN2IvMHgyYTAgbmV0L2lwdjQvYWZf
aW5ldC5jOjg1MQ0KPj4gPj4gPj4gIHNvY2tfc2VuZG1zZ19ub3NlYyBuZXQvc29ja2V0LmM6NzMw
IFtpbmxpbmVdDQo+PiA+PiA+PiAgX19zb2NrX3NlbmRtc2crMHgyNzQvMHgzYzAgbmV0L3NvY2tl
dC5jOjc0NQ0KPj4gPj4gPj4gIF9fc3lzX3NlbmR0bysweDYyYy8weDdiMCBuZXQvc29ja2V0LmM6
MjE5MQ0KPj4gPj4gPj4gIF9fZG9fc3lzX3NlbmR0byBuZXQvc29ja2V0LmM6MjIwMyBbaW5saW5l
XQ0KPj4gPj4gPj4gIF9fc2Vfc3lzX3NlbmR0byBuZXQvc29ja2V0LmM6MjE5OSBbaW5saW5lXQ0K
Pj4gPj4gPj4gIF9feDY0X3N5c19zZW5kdG8rMHgxMzAvMHgyMDAgbmV0L3NvY2tldC5jOjIxOTkN
Cj4+ID4+ID4+ICBkb19zeXNjYWxsXzY0KzB4ZDgvMHgxZjAgYXJjaC94ODYvZW50cnkvY29tbW9u
LmM6ODMNCj4+ID4+ID4+ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZC8weDc1
DQo+PiA+PiA+Pg0KPj4gPj4gPj4gRml4ZXM6IDk5ZTVhY2FlMTkzZSAoImlwdjQ6IEZpeCBwb3Rl
bnRpYWwgdW5pbml0IHZhcmlhYmxlIGFjY2VzcyBidWcgaW4gX19pcF9tYWtlX3NrYigpIikNCj4+
ID4+ID4+IFJlcG9ydGVkLWJ5OiBzeXprYWxsZXIgPHN5emthbGxlckBnb29nbGVncm91cHMuY29t
Pg0KPj4gPj4gPj4gU2lnbmVkLW9mZi1ieTogU2hpZ2VydSBZb3NoaWRhIDxzeW9zaGlkYUByZWRo
YXQuY29tPg0KPj4gPj4gPj4gLS0tDQo+PiA+PiA+PiBJIHRoaW5rIElQdjYgaGFzIGEgc2ltaWxh
ciBpc3N1ZS4gSWYgdGhpcyBwYXRjaCBpcyBhY2NlcHRlZCwgSSB3aWxsIHNlbmQNCj4+ID4+ID4+
IGEgcGF0Y2ggZm9yIElQdjYuDQo+PiA+PiA+PiAtLS0NCj4+ID4+ID4+ICBuZXQvaXB2NC9pcF9v
dXRwdXQuYyB8IDIgKy0NCj4+ID4+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4+ID4+ID4+DQo+PiA+PiA+PiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQv
aXBfb3V0cHV0LmMgYi9uZXQvaXB2NC9pcF9vdXRwdXQuYw0KPj4gPj4gPj4gaW5kZXggMWZlNzk0
OTY3MjExLi4zOTIyOWZkMDYwMWEgMTAwNjQ0DQo+PiA+PiA+PiAtLS0gYS9uZXQvaXB2NC9pcF9v
dXRwdXQuYw0KPj4gPj4gPj4gKysrIGIvbmV0L2lwdjQvaXBfb3V0cHV0LmMNCj4+ID4+ID4+IEBA
IC0xNDczLDcgKzE0NzMsNyBAQCBzdHJ1Y3Qgc2tfYnVmZiAqX19pcF9tYWtlX3NrYihzdHJ1Y3Qg
c29jayAqc2ssDQo+PiA+PiA+PiAgICAgICAgICAgICAgICAgICogYnkgaWNtcF9oZHIoc2tiKS0+
dHlwZS4NCj4+ID4+ID4+ICAgICAgICAgICAgICAgICAgKi8NCj4+ID4+ID4+ICAgICAgICAgICAg
ICAgICBpZiAoc2stPnNrX3R5cGUgPT0gU09DS19SQVcgJiYNCj4+ID4+ID4+IC0gICAgICAgICAg
ICAgICAgICAgIWluZXRfdGVzdF9iaXQoSERSSU5DTCwgc2spKQ0KPj4gPj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAhKGZsNC0+Zmxvd2k0X2ZsYWdzICYgRkxPV0lfRkxBR19LTk9XTl9OSCkpDQo+
PiA+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBpY21wX3R5cGUgPSBmbDQtPmZsNF9pY21w
X3R5cGU7DQo+PiA+PiA+PiAgICAgICAgICAgICAgICAgZWxzZQ0KPj4gPj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgaWNtcF90eXBlID0gaWNtcF9oZHIoc2tiKS0+dHlwZTsNCj4+ID4+ID4+
IC0tDQo+PiA+PiA+PiAyLjQ0LjANCj4+ID4+ID4+DQo+PiA+PiA+DQo+PiA+PiA+IFRoYW5rcyBm
b3IgeW91ciBwYXRjaC4NCj4+ID4+ID4NCj4+ID4+ID4gSSBkbyBub3QgdGhpbmsgdGhpcyBpcyBl
bm91Z2gsIGFzIGZhciBhcyBzeXprYWxsZXIgaXMgY29uY2VybmVkLg0KPj4gPj4gPg0KPj4gPj4g
PiByYXdfcHJvYmVfcHJvdG9fb3B0KCkgY2FuIGxlYXZlIGdhcmJhZ2UgaW4gZmw0X2ljbXBfdHlw
ZSAoYW5kIGZsNF9pY21wX2NvZGUpDQo+PiA+Pg0KPj4gPj4gVGhhbmsgeW91IGZvciB5b3VyIGNv
bW1lbnQuIEJ1dCBJIGRvbid0IHVuZGVyc3RhbmQgaXQgY2xlYXJseS4gV2hhdA0KPj4gPj4gZXhh
Y3RseSBkbyB5b3UgbWVhbiBieSAiZ2FyYmFnZSI/DQo+PiA+Pg0KPj4gPj4gcmF3X3Byb2JlX3By
b3RvX29wdCgpIGltbWVkaWF0ZWx5IHJldHVybnMgMCBpZiBmbDQtPmZsb3dpNF9wcm90byBpcw0K
Pj4gPj4gbm90IElQUFJPVE9fSUNNUDoNCj4+ID4+DQo+PiA+PiBzdGF0aWMgaW50IHJhd19wcm9i
ZV9wcm90b19vcHQoc3RydWN0IHJhd19mcmFnX3ZlYyAqcmZ2LCBzdHJ1Y3QgZmxvd2k0ICpmbDQp
DQo+PiA+PiB7DQo+PiA+PiAgICAgICAgIGludCBlcnI7DQo+PiA+Pg0KPj4gPj4gICAgICAgICBp
ZiAoZmw0LT5mbG93aTRfcHJvdG8gIT0gSVBQUk9UT19JQ01QKQ0KPj4gPj4gICAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPj4gPj4NCj4+ID4+IEluIHRoaXMgY2FzZSwgdGhlIGZ1bmN0aW9uIGRv
ZXNuJ3Qgc2V0IGZsNF9pY21wX3R5cGUuIERvIHlvdSBtZWFuIHRoaXMNCj4+ID4+IGNhc2U/DQo+
PiA+DQo+PiA+IFRoZXJlIGFyZSBtdWx0aXBsZSB3YXlzIHRvIHJldHVybiBlYXJseSBmcm9tIHRo
aXMgZnVuY3Rpb24uDQo+PiA+DQo+PiA+IEluIGFsbCBvZiB0aGVtLCBmbDQtPmZsNF9pY21wX3R5
cGUgaXMgbGVmdCB1bmluaXRpYWxpemVkLCBzbyBzeXpib3QNCj4+ID4gd2lsbCBmaW5kIHdheXMg
dG8gdHJpZ2dlciBhIHJlbGF0ZWQgYnVnLA0KPj4gPiBpZiB5b3UgYXNzdW1lIGxhdGVyIHRoYXQg
Zmw0LT5mbDRfaWNtcF90eXBlIGNvbnRhaW5zIHZhbGlkIChpbml0aWFsaXplZCkgZGF0YS4NCj4+
DQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIEkgc2VlIHlvdXIgcG9pbnQuDQo+Pg0KPj4g
Zmw0LT5mbDRfaWNtcF90eXBlIGlzIHBhcnQgb2YgZmxvd2lfdWxpIHVuaW9uIGluIGZsb3dpNCBz
dHJ1Y3R1cmUsIGFuZA0KPj4gZmxvd2k0X2luaXRfb3V0cHV0KCkgaW5pdGlhbGl6ZXMgZmw0X2Rw
b3J0IGFuZCBmbDRfc3BvcnQgdG8gemVyby4NCj4+DQo+PiBJIHRob3VnaHQgdGhpcyBhbHNvIGlu
aXRpYWxpemVzIGZsNF9pY21wX3R5cGUgYW5kIGZsNF9pY21wX2NvZGUuIERvDQo+PiB5b3UgdGhp
bmsgd2Ugc2hvdWxkIGluaXRpYWxpemUgZmw0X2ljbXBfdHlwZSBhbmQgZmw0X2ljbXBfY29kZQ0K
Pj4gZXhwbGljaXRseSwgb3RoZXJ3aXNlIGFtIEkgbWlzdW5kZXJzdGFuZGluZz8NCj4gDQo+IFll
cywgSSBhbSBwcmVjaXNlbHkgc2F5aW5nIHRoaXMgOiBkbyBub3QgcmVseSBvbiBzb21lIHVuaW9u
IGxheW91dCwNCj4gd2l0aG91dCBtZW50aW9uaW5nIGl0IGluIHRoZSBjaGFuZ2Vsb2cNCj4gb3Ig
ZXZlbiBiZXR0ZXIgaW4gYSBjb21tZW50Lg0KPiANCj4gSWYgeW91IHdhbnQgdG8gYXZvaWQgY2xl
YXJpbmcgdGhlc2UgZmllbGRzLCBwbGVhc2UgYWRkIGENCj4gQlVJTERfQlVHX09OKCkgdG8gbWFr
ZSBzdXJlDQo+IGEgdW5yZWxhdGVkIGZ1dHVyZSBjaGFuZ2UgaW4gaW5jbHVkZS9uZXQvZmxvdy5o
IGRvZXMgbm90IGJyZWFrIGENCj4gaGlkZGVuIGFzc3VtcHRpb24uDQo+IA0KPiAoaWUgOiBjbGVh
cmluZyBmbDRfZHBvcnQgYW5kIGZsNF9zcG9ydCBhbHNvIGNsZWFycyBmbDRfaWNtcF90eXBlIGFu
ZA0KPiBmbDRfaWNtcF9jb2RlLikNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLg0KDQpU
aGFuayB5b3UgRXJpYyEgSSBnb3QgaXQuIEkgd2lsbCB0cnkgdG8gbWFrZSB2MiBwYXRjaCB0aGlz
IHdlZWtlbmQuDQoNClRoYW5rcywNClNoaWdlcnUNCg==


