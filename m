Return-Path: <netdev+bounces-139385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A629B1D0A
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 11:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A07E1F211C6
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27457346D;
	Sun, 27 Oct 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ofkDbmiK"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7214CB36;
	Sun, 27 Oct 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023292; cv=none; b=ST7egdbqgtjGpJXl9t6zz3n/QUKBXXKzPqwZx25yriUXQsyCnoWi2H2x3PQddlhbkymI4cgom/nXdbmIhIMSs7BTI5S15vJlizmVX+4EMRDZuzbzlL9FaaXDAzTfEeBgxbN91J2jIebiMlG2hV2yTDYDHSTrTTOtO2WQQNpupCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023292; c=relaxed/simple;
	bh=VoFIJcBuBgAEOEaKXwGvmmWLBxvC8SC/wK44SFhy4Kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kM73L37HS8QuHiXd1TrgbQszoIUuo7RJ7IZca+HEZekXwCeonIdzEuhFIp8KdZtQOL04+MxNDbAd6CQQ4FsWAFvCGCG8pMLdT+CFaMIAeHiG2npBb3oBYvrwCk1b3BP4qtvS4b03yYJQSoXzr55+osQNYlLt39zG8S9L+uC/9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ofkDbmiK reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/Mb/MAbniH+iTLFgaPUPLoohugvKzOX3bCzKXiE8zSs=; b=o
	fkDbmiKz1M+MBFrLp8PnYIt85i4lzZdK2bLu7EFt8OsDFd9UsCvWDpaP2OVoXGxp
	SIR9yqCtq2UOxp50jPVlFPXOndvbcd935cUDqBoYy4iWTNJItraln3/wqCtqevf6
	i5IJBX5v9hwjBWEyHyiFkNJyMDHRndHudwdEJv2nXs=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Sun, 27 Oct 2024 17:58:57 +0800
 (CST)
Date: Sun, 27 Oct 2024 17:58:57 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	david.wu@rock-chips.com, andy.yan@rock-chips.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Subject: Re:[PATCH v1 2/2] net: arc: rockchip: fix emac mdio node support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
 <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
X-NTES-SC: AL_Qu2YAvyZvEko4SGbYelS/DNR+6hBMKv32aNaoMQOZ8UqqTHC6CwvbV1SBFDxyvpExDuGajt87KyUggf9a/E3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <250cdfef.1bfc.192cd6a1f72.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgD3E2zhDh5nyQgYAA--.58001W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0huFXmceAjpw-wADsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCkhlbGxvIEpvaGFuLAogICAgVGhhbmtzIGZvciB5b3VyIHBhdGNoLiAgTWF5
YmUgd2UgbmVlZCBhIEZpeGVzIHRhZyBoZXJlPwogICAgQW5kIGZvciB0aGUgcGF0Y2ggaXRzZWxm
OgogIAogICBUZXN0ZWQtYnk6IEFuZHkgWWFuIDxhbmR5c2hya0AxNjMuY29tPgoKQXQgMjAyNC0x
MC0yNyAxNzo0Mjo0NSwgIkpvaGFuIEpvbmtlciIgPGpieDYyNDRAZ21haWwuY29tPiB3cm90ZToK
PlRoZSBiaW5kaW5nIGVtYWNfcm9ja2NoaXAudHh0IGlzIGNvbnZlcnRlZCB0byBZQU1MLgo+Q2hh
bmdlZCBhZ2FpbnN0IHRoZSBvcmlnaW5hbCBiaW5kaW5nIGlzIGFuIGFkZGVkIE1ESU8gc3Vibm9k
ZS4KPkZpeCBlbWFjX21kaW8uYyBzbyB0aGF0IGl0IGNhbiBoYW5kbGUgYm90aCBvbGQgYW5kIG5l
dwo+ZGV2aWNlIHRyZWVzLgo+Cj5TaWduZWQtb2ZmLWJ5OiBKb2hhbiBKb25rZXIgPGpieDYyNDRA
Z21haWwuY29tPgo+LS0tCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYXJjL2VtYWNfbWRpby5jIHwg
OSArKysrKysrKy0KPiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcmMvZW1hY19tZGlvLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcmMvZW1hY19tZGlvLmMKPmluZGV4IDg3ZjQwYzJiYTkw
NC4uMDc4YjFhNzJjMTYxIDEwMDY0NAo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXJjL2Vt
YWNfbWRpby5jCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcmMvZW1hY19tZGlvLmMKPkBA
IC0xMzMsNiArMTMzLDcgQEAgaW50IGFyY19tZGlvX3Byb2JlKHN0cnVjdCBhcmNfZW1hY19wcml2
ICpwcml2KQo+IAlzdHJ1Y3QgYXJjX2VtYWNfbWRpb19idXNfZGF0YSAqZGF0YSA9ICZwcml2LT5i
dXNfZGF0YTsKPiAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHByaXYtPmRldi0+b2Zfbm9kZTsK
PiAJY29uc3QgY2hhciAqbmFtZSA9ICJTeW5vcHN5cyBNSUkgQnVzIjsKPisJc3RydWN0IGRldmlj
ZV9ub2RlICptZGlvX25vZGU7Cj4gCXN0cnVjdCBtaWlfYnVzICpidXM7Cj4gCWludCBlcnJvcjsK
Pgo+QEAgLTE2NCw3ICsxNjUsMTMgQEAgaW50IGFyY19tZGlvX3Byb2JlKHN0cnVjdCBhcmNfZW1h
Y19wcml2ICpwcml2KQo+Cj4gCXNucHJpbnRmKGJ1cy0+aWQsIE1JSV9CVVNfSURfU0laRSwgIiVz
IiwgYnVzLT5uYW1lKTsKPgo+LQllcnJvciA9IG9mX21kaW9idXNfcmVnaXN0ZXIoYnVzLCBwcml2
LT5kZXYtPm9mX25vZGUpOwo+KwkvKiBCYWNrd2FyZHMgY29tcGF0aWJpbGl0eSBmb3IgRU1BQyBu
b2RlcyB3aXRob3V0IE1ESU8gc3Vibm9kZS4gKi8KPisJbWRpb19ub2RlID0gb2ZfZ2V0X2NoaWxk
X2J5X25hbWUobnAsICJtZGlvIik7Cj4rCWlmICghbWRpb19ub2RlKQo+KwkJbWRpb19ub2RlID0g
b2Zfbm9kZV9nZXQobnApOwo+Kwo+KwllcnJvciA9IG9mX21kaW9idXNfcmVnaXN0ZXIoYnVzLCBt
ZGlvX25vZGUpOwo+KwlvZl9ub2RlX3B1dChtZGlvX25vZGUpOwo+IAlpZiAoZXJyb3IpIHsKPiAJ
CW1kaW9idXNfZnJlZShidXMpOwo+IAkJcmV0dXJuIGRldl9lcnJfcHJvYmUocHJpdi0+ZGV2LCBl
cnJvciwKPi0tCj4yLjM5LjIKPgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+TGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0Cj5MaW51eC1yb2NrY2hp
cEBsaXN0cy5pbmZyYWRlYWQub3JnCj5odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==

