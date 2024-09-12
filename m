Return-Path: <netdev+bounces-127879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FF976F0A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1337FB21ABD
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965271B9820;
	Thu, 12 Sep 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="b/+JTLk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534E185939;
	Thu, 12 Sep 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159664; cv=none; b=nlI/yugaLU2+X0Jr8+XgNuFxP0gAHRIHkqNxLLKdcYePgbotWKV+ys5PYFyKZB/BNobNKuCYvX82OgcXsZU3BVniJ3bdatfPSdhTAlCC6vWT4iIEeWyLbXV1VPTLFzmF0Ml4rnhVeLCEH5rdwuhGOhHP2Y0wtUSWEy5naHVPsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159664; c=relaxed/simple;
	bh=cKwzCUEYjKoPwIDNhCww9BvIKS25aLWnTmd4rd91Z4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nULClVva2rHJIfpgIigTGgol80mgz5kHzVJXpZaCpHzlSDFgtyoWDBxo2tAJV8d1OzpEG8WEysGzZ72M5q+71kmryA3P8QSKVjO66jhx+3MVQvm2/oe6rn3s/HnLC+RKyqQYxhYUwsoBsbIdq/4OMgjsQs2bzZrBiKrwsB+crpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=b/+JTLk/ reason="signature verification failed"; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtp83t1726159613to5d2kq4
X-QQ-Originating-IP: //8ojEWj5zyik+IDOVW2+Nz6vwRhEBJ1fP4hKMrx43w=
Received: from m16.mail.163.com ( [117.135.210.2])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 00:46:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8686062611762100577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rdcNj5uwJJEZjLv5Z3DsoThouba4FdiHltV8i8AMl18=; b=b
	/+JTLk/7/Wbyp+yJX70aplaEvV24gSZ8L7a/2QssKIO+dNBAzaZpTpvLH0L9feel
	YOt8WFbl6U61oy/7aIpQegBAFiufG5EToKJ/08KrD5Lk1x1xqVurwNfTf05GN9FY
	5UQJDOG/rnTj/pccr4bRMbZepEaHDWuVbtKEtF9Cp4=
Received: from kxwang23$m.fudan.edu.cn ( [104.238.222.239] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Fri, 13 Sep 2024 00:46:15 +0800
 (CST)
Date: Fri, 13 Sep 2024 00:46:15 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: wtdeng24@m.fudan.edu.cn, 21210240012@m.fudan.edu.cn, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	davem@davemloft.net
Subject: Re: [PATCH] net: seeq: Fix use after free vulnerability in ether3
 Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <26614b92-4d24-4aff-8fc3-25aa8ed83cb6@intel.com>
References: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>
 <26614b92-4d24-4aff-8fc3-25aa8ed83cb6@intel.com>
X-NTES-SC: AL_Qu2ZBP2etk0s4yabYOkXn0kbjug3WcW0u/0k3oJUNps0sSbJxCIce1FGAHTrzv+TMyOvnjaRQClvyeFHTa9cY5iDGeXF3HowFERebwPIor1Q
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2BC065D799E6D23B+6fef9b03.c268.191e720da5e.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDnr6vYGuNmEJAFAA--.2873W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiwh5Y2GWXw6aYUAAFsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CkF0IDIwMjQtMDktMTEgMTc6Mjk6NDQsICJQcnplbWVrIEtpdHN6ZWwiIDxwcnplbXlzbGF3Lmtp
dHN6ZWxAaW50ZWwuY29tPiB3cm90ZToKPk9uIDkvOS8yNCAxOTo1OCwgS2FpeGluIFdhbmcgd3Jv
dGU6Cj4+IEluIHRoZSBldGhlcjNfcHJvYmUgZnVuY3Rpb24sIGEgdGltZXIgaXMgaW5pdGlhbGl6
ZWQgd2l0aCBhIGNhbGxiYWNrCj4+IGZ1bmN0aW9uIGV0aGVyM19sZWRvZmYsIGJvdW5kIHRvICZw
cmV2KGRldiktPnRpbWVyLiBPbmNlIHRoZSB0aW1lciBpcwo+PiBzdGFydGVkLCB0aGVyZSBpcyBh
IHJpc2sgb2YgYSByYWNlIGNvbmRpdGlvbiBpZiB0aGUgbW9kdWxlIG9yIGRldmljZQo+PiBpcyBy
ZW1vdmVkLCB0cmlnZ2VyaW5nIHRoZSBldGhlcjNfcmVtb3ZlIGZ1bmN0aW9uIHRvIHBlcmZvcm0g
Y2xlYW51cC4KPj4gVGhlIHNlcXVlbmNlIG9mIG9wZXJhdGlvbnMgdGhhdCBtYXkgbGVhZCB0byBh
IFVBRiBidWcgaXMgYXMgZm9sbG93czoKPj4gCj4+IENQVTAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBDUFUxCj4+IAo+PiAgICAgICAgICAgICAgICAgICAgICAgIHwgIGV0aGVy
M19sZWRvZmYKPj4gZXRoZXIzX3JlbW92ZSAgICAgICAgIHwKPj4gICAgZnJlZV9uZXRkZXYoZGV2
KTsgICB8Cj4+ICAgIHB1dF9kZXZpYyAgICAgICAgICAgfAo+PiAgICBrZnJlZShkZXYpOyAgICAg
ICAgIHwKPj4gICB8ICBldGhlcjNfb3V0dyhwcml2KGRldiktPnJlZ3MuY29uZmlnMiB8PSBDRkcy
X0NUUkxPLCBSRUdfQ09ORklHMik7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgfCAvLyB1c2Ug
ZGV2Cj4+IAo+PiBGaXggaXQgYnkgZW5zdXJpbmcgdGhhdCB0aGUgdGltZXIgaXMgY2FuY2VsZWQg
YmVmb3JlIHByb2NlZWRpbmcgd2l0aAo+PiB0aGUgY2xlYW51cCBpbiBldGhlcjNfcmVtb3ZlLgo+
Cj50aGlzIGNvZGUgY2hhbmdlIGluZGVlZCBwcmV2ZW50cyBVQUYgYnVnCj5idXQgYXMgaXMsIHRo
ZSBDRkcyX0NUUkxPIGZsYWcgb2YgUkVHX0NPTkZJRzIgd2lsbCBiZSBsZWZ0IGluIHN0YXRlICJP
TiIKPgo+aXQgd291bGQgYmUgYmV0dGVyIHRvIGZpcnN0IHR1cm4gdGhlIExFRCBvZmYgdW5jb25k
aXRpb25hbGx5Cj4KCkkgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaC4K
Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBLYWl4aW4gV2FuZyA8a3h3YW5nMjNAbS5mdWRhbi5lZHUu
Y24+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3NlZXEvZXRoZXIzLmMgfCAxICsK
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4gCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zZWVxL2V0aGVyMy5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
c2VlcS9ldGhlcjMuYwo+PiBpbmRleCBjNjcyZjkyZDY1ZTkuLmY5ZDI3YzlkNjgwOCAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc2VlcS9ldGhlcjMuYwo+PiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9zZWVxL2V0aGVyMy5jCj4+IEBAIC04NTAsNiArODUwLDcgQEAgc3Rh
dGljIHZvaWQgZXRoZXIzX3JlbW92ZShzdHJ1Y3QgZXhwYW5zaW9uX2NhcmQgKmVjKQo+PiAgIAll
Y2FyZF9zZXRfZHJ2ZGF0YShlYywgTlVMTCk7Cj4+ICAgCj4+ICAgCXVucmVnaXN0ZXJfbmV0ZGV2
KGRldik7Cj4+ICsJZGVsX3RpbWVyX3N5bmMoJnByaXYoZGV2KS0+dGltZXIpOwo+PiAgIAlmcmVl
X25ldGRldihkZXYpOwo+PiAgIAllY2FyZF9yZWxlYXNlX3Jlc291cmNlcyhlYyk7Cj4+ICAgfQo+
Cj4KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQoKQmVzdCByZWdhcmRzLApLYWl4aW4gV2FuZwoK

