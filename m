Return-Path: <netdev+bounces-144677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27339C8170
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C31F22D77
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061821E3DD8;
	Thu, 14 Nov 2024 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Dy464IS5"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1546BF;
	Thu, 14 Nov 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554494; cv=none; b=sAV1hXKkd5VHTnA15aiOOYYcJVGCJYKzNK/eiA8kqGxbTqBiTl5HlMMcfpJdChSDQdqYF+UsGREZh/4VFezMQj/hjTWb9r2bFrLRErZBdfcGZ1AVHh8m65diFocWYTbehNYc3jKRw2CTxR90n5SnBD7abeGIUotwYuAOW4uInQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554494; c=relaxed/simple;
	bh=CnTuDgvlgK9u9BxyMLbf4x+3M9Uar15r1RKsdLSheXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQIUv/bU/xls157qCOOavIg4FgQxlhv8se7tZG+KcmmClGwpwQPf7v01JHtMussJEsI67jEILxrGZz/pX0AWfM+YLS10e1Xiljbs/ejNwcEAWJh0akZsaZyQWsPWW6Prs3AE27YktLW8AQTuXKJvQ26fnrAkziv2HrStMvw4Y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Dy464IS5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731554005;
	bh=CnTuDgvlgK9u9BxyMLbf4x+3M9Uar15r1RKsdLSheXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dy464IS5orQOiChM5fIJcm7w2celhG8pS9hFnBk9HFDhDP5Y25yZRgkZZUyoKVGTu
	 YnZWVuhvsbtMcHEHc399b0+VmpOdUDT0sPuEv0/9YiJZ9w4AiHwbYKmfykkFMA/ERR
	 E/HoxMkW34Ad4D8hdVLvKFq03e3tKPN9yhLznuLSNGEHDCWgjafDMrl33Qj7B73wKk
	 uplMlkxHAUGR4xPDZwT0YexK+8k9Qm4cDKuGIvpT+3tolxTLUeRMKKXNf5AtjFZF/7
	 UsJNHC2Mk677szV4+66jWel0Jf8y8mn97w083W5bQwX6N7J/5fy9+Vj2guymR+1n0F
	 hr6eqY//B1Vjw==
Received: from [172.16.160.229] (static-98.141.255.49.in-addr.VOCUS.net.au [49.255.141.98])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6E8F466745;
	Thu, 14 Nov 2024 11:13:24 +0800 (AWST)
Message-ID: <da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, Jian Zhang
 <zhangjian.3032@bytedance.com>
Cc: netdev@vger.kernel.org, openbmc@lists.ozlabs.org, Matt Johnston
	 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, open list
	 <linux-kernel@vger.kernel.org>
Date: Thu, 14 Nov 2024 11:13:33 +0800
In-Reply-To: <20241113190920.0ceaddf2@kernel.org>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
	 <20241113190920.0ceaddf2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSmFrdWIsCgo+ID4gQEAgLTU1MSw2ICs1NTIsMTQgQEAgc3RhdGljIHZvaWQgbWN0cF9pMmNf
eG1pdChzdHJ1Y3QgbWN0cF9pMmNfZGV2ICptaWRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X3dhcm5fcmF0ZWxpbWl0ZWQoJm1p
ZGV2LT5hZGFwdGVyLT5kZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIl9faTJjX3RyYW5zZmVyIGZh
aWxlZCAlZFxuIiwgcmMpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0
cy0+dHhfZXJyb3JzKys7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c2sgPSBza2ItPnNrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzaykg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzay0+
c2tfZXJyID0gLXJjOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoIXNvY2tfZmxhZyhzaywgU09DS19ERUFEKSkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNrX2Vycm9y
X3JlcG9ydChzayk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IAo+IG5v
dGlmeWluZyBzb2NrZXQgaW4gdGhlIHhtaXQgaGFuZGxlciBvZiBhIG5ldGRldiBpcyBhIGJpdCBz
dHJhbmdlLAo+IGNvdWxkIHlvdSBkbyBpdCBzb21ld2hlcmUgaGlnaGVyIGluIHRoZSBNQ1RQIHN0
YWNrPwoKU291bmRzIGxpa2UgdGhhdCB3b3VsZCBiZSB1c2VmdWwgaW4gZ2VuZXJhbCBmb3IgTUNU
UCwgYnV0IHdlIGRvbid0IGhhdmUKYSBmYWNpbGl0eSBmb3IgdGhhdCBhdCBwcmVzZW50LiAgQW55
IGV4aXN0aW5nIGltcGxlbWVudGF0aW9uIHlvdSB3b3VsZApzdWdnZXN0IG1vZGVsbGluZyB0aGlz
IG9uPwoKQ2hlZXJzLAoKCkplcmVteQo=


