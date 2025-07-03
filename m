Return-Path: <netdev+bounces-203631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F8AF68FF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 06:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491401C249BF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B7289375;
	Thu,  3 Jul 2025 04:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00760272E4A;
	Thu,  3 Jul 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515585; cv=none; b=m3iPI8O7CNVPIItG7cjx4+lFjfDjLjXJcNyJP8IsXJVcGJJyWYTufqY/rVqe10/qPNgfw/D5Xcnww8HXddwrIdmc1TJb0rJ+l9CUOLj215RINwpcG8xeVF2u7DZ+X4DWNfCqmav6yobTNXUs1ktqoNiLFlm6N4duwaUW2BdyvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515585; c=relaxed/simple;
	bh=70sgCDrpf2Ch+2jl83A2ilMe10M/C7Wera8/aLEjkgI=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HjxYDO0pcBkhRt0N4Tc4tUxMgkBamzo1RGwiu4KWGFSiDU8vx/x5/xbDzQt1iStwlJpRMA2zPH9YT6xe4NTwAp4O/0MvBn0glyEkGdwMqfPylOtcvdWa5R9z+qwZK3tNxt3u3HZruz0wa7aer65z6I/bQSj6wT334/IPL/5bJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wDXN3ygAWZoLLDZAw--.7864S3;
	Thu, 03 Jul 2025 12:05:53 +0800 (CST)
Received: from linma$zju.edu.cn ( [115.197.243.13] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 3 Jul 2025 12:05:52 +0800
 (GMT+08:00)
Date: Thu, 3 Jul 2025 12:05:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mingo@kernel.org,
	tglx@linutronix.de, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atm: Fix incorrect net_device lec check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <20250703023416.97641-1-linma@zju.edu.cn>
References: <20250703023416.97641-1-linma@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <34a6dc2e.8f73.197ce7659b8.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgBXSYGgAWZo41lZAA--.8181W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwAPEmhjuY4KnQAKs-
X-CM-DELIVERINFO: =?B?oiOYlgXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHjeUlN/wNeQBhT9FIlu3pf6oyLjuoTf6z+lqvBIvQfa8ZpR3plsqbCx0C0tkvZqU375E
	shS97zN+qEokR/CgHUgVZHv87wqNY3HgyweVm/d1xFp5o+myX+BbxuL5WJl3TA==
X-Coremail-Antispam: 1Uk129KBj9xXoWrur1UKw1rKryfAr15Wr45urX_yoWkXrXE9w
	1Iv3s7Gr43ZFW0yanxuryfXFyjqw4DX348XFnrGrW3X34kJFy5WrZ5WFyqyrWagrW7AFW3
	GFs8uF9Ik3W5ZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbPkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k042
	43AbIYCTnIWIevJa73UjIFyTuYvjxU7GYpUUUUU

SGkgdGhlcmUsCgpTb3JyeSBhZ2FpbiBmb3IgdGhlIGNhcmVsZXNzIG1pc3Rha2VzLi4uIHRoZSBg
bGVjX25ldGRldl9vcHNgIGlzIGEgc3RhdGljIG9wcyB2YXJpYWJsZSBkZWZpbmVkCmVsc2V3aGVy
ZSwgaGVuY2UgdGhlIHBhdGNoIGNhbm5vdCBjb21waWxlIGNvcnJlY3RseS4KClByZXBhcmluZyB0
aGUgdjMgcGF0Y2guCgpSZWdhcmRzCkxpbgoKPiBWMSAtPiBWMjogYWRkIG51bGwgY2hlY2sgc3Vn
Z2VzdGVkIGJ5IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4sCj4gICAgICAgICAg
IG90aGVyd2lzZSB3aWxsIGNyYXNoCj4gCj4gIG5ldC9hdG0vbXBjLmMgfCA1ICsrKystCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvbmV0L2F0bS9tcGMuYyBiL25ldC9hdG0vbXBjLmMKPiBpbmRleCBmNmI0NDdiYmEzMjku
LmFmNDA5ZDZmYTJkZCAxMDA2NDQKPiAtLS0gYS9uZXQvYXRtL21wYy5jCj4gKysrIGIvbmV0L2F0
bS9tcGMuYwo+IEBAIC0yNzUsNiArMjc1LDkgQEAgc3RhdGljIHN0cnVjdCBuZXRfZGV2aWNlICpm
aW5kX2xlY19ieV9pdGZudW0oaW50IGl0ZikKPiAgCXNwcmludGYobmFtZSwgImxlYyVkIiwgaXRm
KTsKPiAgCWRldiA9IGRldl9nZXRfYnlfbmFtZSgmaW5pdF9uZXQsIG5hbWUpOwo+ICAKPiArCWlm
ICghZGV2IHx8IGRldi0+bmV0ZGV2X29wcyAhPSBsZWNfbmV0ZGV2X29wcykKPiArCQlyZXR1cm4g
TlVMTDsKPiArCj4gIAlyZXR1cm4gZGV2Owo+ICB9Cj4gIAo+IEBAIC0xMDA2LDcgKzEwMDksNyBA
QCBzdGF0aWMgaW50IG1wb2FfZXZlbnRfbGlzdGVuZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpt
cG9hX25vdGlmaWVyLAo+ICAJaWYgKCFuZXRfZXEoZGV2X25ldChkZXYpLCAmaW5pdF9uZXQpKQo+
ICAJCXJldHVybiBOT1RJRllfRE9ORTsKPiAgCj4gLQlpZiAoc3RybmNtcChkZXYtPm5hbWUsICJs
ZWMiLCAzKSkKPiArCWlmIChkZXYtPm5ldGRldl9vcHMgIT0gbGVjX25ldGRldl9vcHMpCj4gIAkJ
cmV0dXJuIE5PVElGWV9ET05FOyAvKiB3ZSBhcmUgb25seSBpbnRlcmVzdGVkIGluIGxlYzpzICov
Cj4gIAo+ICAJc3dpdGNoIChldmVudCkgewo+IC0tIAo+IDIuMTcuMQo=


