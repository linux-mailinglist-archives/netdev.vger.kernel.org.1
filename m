Return-Path: <netdev+bounces-190949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212DAB96A6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6633B41C4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25AC228CB5;
	Fri, 16 May 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eKg5+FRq"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FCA227E8E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381041; cv=none; b=pg511Ms3bIaM+XkshuhdvbhaSQ5g3RJ1r/i9/nmil1WOHvbFh7vO4Mi76DBW4nmk1OSgUXsEWFyBim2oOgKUzaGLlkbt8OvhAhtJD/Saq0LE5x1UVThyAWWWOuWhisfN5xeL1g6ORtmhKHS+Pe3Uh3Dl5MFwLqLIbi9foZmr+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381041; c=relaxed/simple;
	bh=V3dpcHs1LrGsJpWnrfG3Fs94hpUjMw/6oDnbxY7nuOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=I0gYv+pVK87TrRPbdpe5/Crv0b/pP8qxkAHmQIXh7EAPK1XiKrDQ4p9ObExfvm31ccJJPZ2M2dF8FGp6yjT8IL9KwXJi3KkkJ3aswx1mNpGYyImWSivwQ1qA9GUyYiX70u/fDOaXnDhs3Six/J1dz6iUCl/LMwM3gkba2tAfURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=eKg5+FRq reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=x2BBtukZYvYARBXKGpzJXWGxpnAiVMOyWY2EnivpsjI=; b=e
	Kg5+FRqkSZrMnY9WMYXXwN5x5JLahtaHjU9am+mg4+7SPSdFAAY3nPa+aXvwIgel
	T6WWrMgSpo1R04Ygof5nCJgMDALglHzKYqH6iLPvFh6qqyfCZcTIKlbBoBYhgZ9i
	IdL1kNnKa8wwne0J9w3kq8kYstrKPMXbTC0bq8+DaE=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Fri, 16 May 2025 15:36:25 +0800
 (CST)
Date: Fri, 16 May 2025 15:36:25 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH] virtio_net: Fix duplicated return values in
 virtnet_get_hw_stats
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250515071042.5f668345@kernel.org>
References: <20250514054433.29709-1-lange_tang@163.com>
 <20250515071042.5f668345@kernel.org>
X-NTES-SC: AL_Qu2fBf+Tv0Ej4ySbYekfmUwag+07WcC2u/oh1YZXO5p6jC/r5wcvUXtMPkfm/d+ONRKykReYaSJi28dLcoZKc7AVba7Ab7Lfv7IBjFFquUSCkQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5e642aef.66ba.196d805de6a.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgAX9JX66iZo8CUGAA--.50563W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXQlPLmgmtXXhawAEs1
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTA1LTE1IDIyOjEwOjQyLCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5lbC5v
cmc+IHdyb3RlOgo+T24gV2VkLCAxNCBNYXkgMjAyNSAxMzo0NDozMyArMDgwMCBUYW5nIExvbmdq
dW4gd3JvdGU6Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gaW5kZXggZTUzYmE2MDA2MDVhLi5jOWE4NmYzMjU2MTkg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPj4gQEAgLTQ4OTcsNyArNDg5Nyw3IEBAIHN0YXRpYyBpbnQgX192
aXJ0bmV0X2dldF9od19zdGF0cyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPj4gIAkJCQkJJnNn
c19vdXQsICZzZ3NfaW4pOwo+PiAgCj4+ICAJaWYgKCFvaykKPj4gLQkJcmV0dXJuIG9rOwo+PiAr
CQlyZXR1cm4gMTsKPgo+VGhpcyBtYWtlcyBzZW5zZSwgbG9va3MgbGlrZSBhIHR5cG8gaW4gdGhl
IG9yaWdpbmFsIGNvZGUuCj5CdXQgd2UgYXJlIG5vdyByZXR1cm5pbmcgdGhlIHJldmVyc2UgcG9s
YXJpdHkgb2YgIm9rIiwgc28gd2Ugc2hvdWxkCj5wcm9iYWJseSByZW5hbWUgdGhlIHZhcmlhYmxl
IGluIHZpcnRuZXRfZ2V0X2h3X3N0YXRzKCkgb2sgLT4gZmFpbGVkCj5PciBpbnZlcnQgdGhlIHBv
bGFyaXR5IGhlcmUgYW5kIGluIHZpcnRuZXRfZ2V0X2h3X3N0YXRzKCkKPgo+PiAgCWZvciAocCA9
IHJlcGx5OyBwIC0gcmVwbHkgPCByZXNfc2l6ZTsgcCArPSBsZTE2X3RvX2NwdShoZHItPnNpemUp
KSB7Cj4+ICAJCWhkciA9IHA7Cj4+IEBAIC00OTM3LDcgKzQ5MzcsNyBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfZ2V0X2h3X3N0YXRzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+PiAgCWludCBvazsK
Pj4gIAo+PiAgCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0Zf
REVWSUNFX1NUQVRTKSkKPj4gLQkJcmV0dXJuIDA7Cj4+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsK
Pgo+SURLIGFib3V0IHRoaXMgcGFydC4gV2Ugc2hvdWxkIG5vdCBzcGFtIHRoZSBsb2dzIGlmIHRo
ZSBkZXZpY2UgZG9lcyBub3QKPnN1cHBvcnQgYSBmZWF0dXJlLiBXZSBzaG91bGQgaW5zdGVhZCBz
a2lwIHJlcG9ydGluZyB0aGUgcmVsZXZhbnQgc3RhdHMuCj5Vc2VyIGNhbiB0ZWxsIHRoYXQgdGhv
c2Ugc3RhdHMgYXJlIG5vdCBzdXBwb3J0ZWQgZnJvbSB0aGUgZmFjdCB0aGV5IGFyZQo+bm90IHBy
ZXNlbnQuCj4tLSAKCj5wdy1ib3Q6IGNyCgoKSSBmb3VuZCB0aGF0IERhbiBDYXJwZW50ZXIgaGFk
IGRpc2NvdmVyZWQgdGhlIHNhbWUgaXNzdWUgYmVmb3JlLCBhbmQgaGUgaGFkIGFscmVhZHkgc3Vi
bWl0dGVkIGEgcGF0Y2gsIHNvIEknbSBiYWNraW5nIG91dC4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjQwNTE1MTEwNjI2LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy8g
CgoKCnJlZ2FyZHMsClRhbmcgTG9uZ2p1bg==

