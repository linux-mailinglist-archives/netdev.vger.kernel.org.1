Return-Path: <netdev+bounces-144772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E009C86AD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2773428348E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172C1F76CD;
	Thu, 14 Nov 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="S4kke8GP"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FC1F76AA;
	Thu, 14 Nov 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578255; cv=none; b=TPiyVa1jXFm4d09tgAuhiOyfDWXd0dtJ/dyk0gg5JgevfzjYqSW1agym3hqJA7SQBLo4sFbJsv+ajsrxOV6ezIharDoC7YoGbuG6c1BHsf86jvogSY3hNHCoXtreCRxnH1SoXtzk4Ehg5QdWzceJyZp5/2g65SjYr8pcYb4LZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578255; c=relaxed/simple;
	bh=dl3f5V0GYfQ9H8usR6Gzm7s8YCR4Yk1aiQKw0lRR8Hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=LhlU+BBFC/29rHL1R0ec+teCL7UlfHzSh1WYKp2Gnl2whj0x6h/KePRySXLlW8UoboMadbXhSh2V7Y9YDvNWaD+nCjvKSna6ofT+9ciEWSYUGZIRmusoKu7cleZHMqOPt25jgZhCBu6/MkMvIbaiHjFGF2v3MbPks6x6HRov3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=S4kke8GP reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=k1S/3BU8Zb5jgvsFwcgiEGk5aCzAh4QhHc+14jg67x8=; b=S
	4kke8GPsTrrwTy6GOB3WU19VU7uRGFhTZNLdK9PDsWKaQE99G6ybxNY/PNFwDm+v
	+YmF3frFqtTZjpZ9J2GrVjWKcBunC2HWGAb7BP0Iy3yuTATQ+Q3AJk3CmLiCw6uw
	vp7JVGUC7PjJijpn9l0buFGgcq4hJ4kLFoQjF6wuRQ=
Received: from 00107082$163.com ( [111.35.191.191] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Thu, 14 Nov 2024 17:56:57 +0800
 (CST)
Date: Thu, 14 Nov 2024 17:56:57 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/net-procfs: use seq_put_decimal_ull_width()
 for decimal values in /proc/net/dev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <9e64f1ca-844f-47ec-8555-4ac1e409ec16@redhat.com>
References: <20241110045221.4959-1-00107082@163.com>
 <9e64f1ca-844f-47ec-8555-4ac1e409ec16@redhat.com>
X-NTES-SC: AL_Qu2YA/mct0oq4SOfZekXn0oTju85XMCzuv8j3YJeN500uCTo1SQ7cm9xHF/0+s6kCymhoAiRfBJQzsBob6pgeYnyvp1u4mGArd3gN7727wAl
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <309370ca.9ca1.1932a1ac39d.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgAHYKFqyTVnFO4mAA--.55402W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQmXqmc1u4ZyjgAFsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTExLTE0IDE3OjE3OjMyLCAiUGFvbG8gQWJlbmkiIDxwYWJlbmlAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPgo+T24gMTEvMTAvMjQgMDU6NTIsIERhdmlkIFdhbmcgd3JvdGU6Cj4+IHNl
cV9wcmludGYoKSBpcyBjb3N0eSwgd2hlbiByZWFkaW5nIC9wcm9jL25ldC9kZXYsIHByb2ZpbGlu
ZyBpbmRpY2F0ZXMKPj4gYWJvdXQgMTMlIHNhbXBsZXMgb2Ygc2VxX3ByaW50ZigpOgo+PiAJZGV2
X3NlcV9zaG93KDk4LjM1MCUgNDI4MDQ2LzQzNTIyOSkKPj4gCSAgICBkZXZfc2VxX3ByaW50Zl9z
dGF0cyg5OS43NzclIDQyNzA5Mi80MjgwNDYpCj4+IAkJZGV2X2dldF9zdGF0cyg4Ni4xMjElIDM2
NzgxNC80MjcwOTIpCj4+IAkJICAgIHJ0bDgxNjlfZ2V0X3N0YXRzNjQoOTguNTE5JSAzNjIzNjUv
MzY3ODE0KQo+PiAJCSAgICBkZXZfZmV0Y2hfc3dfbmV0c3RhdHMoMC41NTQlIDIwMzgvMzY3ODE0
KQo+PiAJCSAgICBsb29wYmFja19nZXRfc3RhdHM2NCgwLjI1MCUgOTE5LzM2NzgxNCkKPj4gCQkg
ICAgZGV2X2dldF90c3RhdHM2NCgwLjA3NyUgMjg0LzM2NzgxNCkKPj4gCQkgICAgbmV0ZGV2X3N0
YXRzX3RvX3N0YXRzNjQoMC4wNTElIDE4OS8zNjc4MTQpCj4+IAkJICAgIF9maW5kX25leHRfYml0
KDAuMDI5JSAxMDYvMzY3ODE0KQo+PiAJCXNlcV9wcmludGYoMTMuNzE5JSA1ODU5NC80MjcwOTIp
Cj4+IEFuZCBvbiBhIHN5c3RlbSB3aXRoIG9uZSB3aXJlbGVzcyBpbnRlcmZhY2UsIHRpbWluZyBm
b3IgMSBtaWxsaW9uIHJvdW5kcyBvZgo+PiBzdHJlc3MgcmVhZGluZyAvcHJvYy9uZXQvZGV2Ogo+
PiAJcmVhbAkwbTUxLjgyOHMKPj4gCXVzZXIJMG0wLjIyNXMKPj4gCXN5cwkwbTUxLjY3MXMKPj4g
T24gYXZlcmFnZSwgcmVhZGluZyAvcHJvYy9uZXQvZGV2IHRha2VzIH4wLjA1MW1zCj4+IAo+PiBX
aXRoIHRoaXMgcGF0Y2gsIGV4dHJhIGNvc3RzIHBhcnNpbmcgZm9ybWF0IHN0cmluZyBieSBzZXFf
cHJpbnRmKCkgY2FuIGJlCj4+IG9wdGltaXplZCBvdXQsIGFuZCB0aGUgdGltaW5nIGZvciAxIG1p
bGxpb24gcm91bmRzIG9mIHJlYWQgaXM6Cj4+IAlyZWFsCTBtNDkuMTI3cwo+PiAJdXNlcgkwbTAu
Mjk1cwo+PiAJc3lzCTBtNDguNTUycwo+PiBPbiBhdmVyYWdlLCB+MC4wNDhtcyByZWFkaW5nIC9w
cm9jL25ldC9kZXYsIGEgfjYlIGltcHJvdmVtZW50Lgo+PiAKPj4gRXZlbiB0aG91Z2ggZGV2X2dl
dF9zdGF0cygpIHRha2VzIHVwIHRoZSBtYWpvcml0eSBvZiB0aGUgcmVhZGluZyBwcm9jZXNzLAo+
PiB0aGUgaW1wcm92ZW1lbnQgaXMgc3RpbGwgc2lnbmlmaWNhbnQ7Cj4+IEFuZCB0aGUgaW1wcm92
ZW1lbnQgbWF5IHZhcnkgd2l0aCB0aGUgcGh5c2ljYWwgaW50ZXJmYWNlIG9uIHRoZSBzeXN0ZW0u
Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPgo+Cj5J
ZiB0aGUgdXNlci1zcGFjZSBpcyBjb25jZXJuZWQgd2l0aCBwZXJmb3JtYW5jZXMsIGl0IG11c3Qg
dXNlIG5ldGxpbmsuCj5PcHRpbWl6aW5nIGEgbGVnYWN5IGludGVyZmFjZSBnaXZlcyBJTUhPIGEg
dmVyeSB3cm9uZyBtZXNzYWdlLgo+Cj5JJ20gc29ycnksIEkgdGhpbmsgd2Ugc2hvdWxkIG5vdCBh
Y2NlcHQgdGhpcyBjaGFuZ2UuCgpJdCdzIE9LLiAKSSBoYXZlIGJlZW4gdXNpbmcgL3Byb2MvbmV0
L2RldiB0byBnYXVnZSB0aGUgdHJhbnNtaXQvcmVjZWl2ZSByYXRlIGZvciBlYWNoIGludGVyZmFj
ZSwKIGFuZCAvcHJvYy9uZXQvbmV0c3RhdCBmb3IgYWJub3JtYWxpdGllcyBpbiBteSBtb25pdG9y
aW5nIHRvb2xzLiAgSSBndWVzcyBteSBrbm93bGVkZ2UgYXJlIHF1aXRlIG91dCBvZiBkYXRlIG5v
dywKSSB3aWxsIGxvb2sgaW50byBuZXRsaW5rOyBBbmQgdGhhbmtzIGZvciBpbmZvcm1hdGlvbi4K
Cj4KPi9QCgpUaGFua3MKRGF2aWQK

