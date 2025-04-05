Return-Path: <netdev+bounces-179422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B1A7C899
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 11:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8FC3B24F4
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59D1CEAA3;
	Sat,  5 Apr 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="qSchAhGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1443182BD
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743846166; cv=none; b=JxW11r03vsEWU+Gr3T84u6Jj2PMej0C3mCLlQoxd9bzMZLq3YuR9RnZ7vBX/p6ZMAxEcljzjRu/p4BdNjO29ohX/Kn1qM9p0Ak8iM73gmeTQiBUXQ8KYqS7Q/LCP1j2AAOZflfr8uC8QLLCwpgbvfxmFBYSm8XHPuHtuA2xTBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743846166; c=relaxed/simple;
	bh=myKyg44a+bK7krurUEhT3xCtmuqwyY81relxdAHi7S4=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=FdhDoZQCWQK4BrWFBadbnHZzngg59e2g7dPnutDo+wbGhQQA5qDfDzjGpGL0mD/jm7A4m3K1eLNl9CYkQimvApLDGjcftDuUv6CzuXhv7L7t5todEZ3haeb7FledKva/sVwdV+rNiK0O3q9l+LPMsRstDbPuKy32l6HDUKFs0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=qSchAhGo; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1743846144;
	bh=myKyg44a+bK7krurUEhT3xCtmuqwyY81relxdAHi7S4=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=qSchAhGo4vC8pV1gsA55weCDv5N97e/mRm8nudoFdKvXMxl4Hn4tmEar2DV2NaKQa
	 aTsaYeIANNSzWjmzZJAQ5rOnGl6QUBUJi2xnbZ6flzkdBDeyF+COjErdoyu4g5VVgy
	 rLhUhz6YWaADnoBE9Nwi42IfVevBDNDkh9ARyKOs=
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000020
X-QQ-FEAT: D4aqtcRDiqQFpFrNiEiZtotk1n6/lCfLiWO7v6wJmw0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: twyt6EXctAzSjlXeoUn2GQVW9b8KIHgnYuYG0dPssVg=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-3t1743846141t4361705
From: "=?utf-8?B?5p2O5a2Q5aWl?=" <23110240084@m.fudan.edu.cn>
To: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: [PATCH iproute2] nstat: Fix NULL Pointer Dereference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 5 Apr 2025 17:42:20 +0800
X-Priority: 3
Message-ID: <tencent_6D7BD943688C4B5A68509FED@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 291444768225239704
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 05 Apr 2025 17:42:22 +0800 (CST)
Feedback-ID: v:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: ORuEwgb9eurkygiX/12nK3JFaEOnU4W8nrbgSc5cyhB0ex5btEokqOUe
	DJ4oH31h4Tq8Eus6NiGdh/gbE+KKcqEG0/wsIfiBeOBJkhxQM0LzzDOdBmLnxGzrCGItNdO
	yWLSnt35zoA2un9CTDhcGRLIN6vobeZb0BWJD0Hg0A/fnfOn82vQvbPP2E6ffK2urvNZGOS
	KURwYZgk3YxHxUZG93/9zVwc81c3Gemi4ZGIkkqWH5c6fMkEWcP31csq2b6iXx78ZfXOnph
	TdteKZnTPjHS15qGgiuvzBnhb6QbLEhQFQiNL2bDyTJrX3DAMblZJ/WtxJVDOA2IAgYzJHw
	IrxbHT4y16udSoHC7C6sUtIos0o+fYh5/JnEXCsakGybMHluFQ49Fyj5IfFyqiFGR9yA1OI
	Nkzb/VrwsYfkwBmM5r7wObE39MetvRvbuenVBBEqggL4BqXOfmba+xZynYQjKjLfVRhw3Ae
	MxtwzzN/uB7eowJZ1c/rd1PWqDZaiwlxD39tvg9fp6aYYqWBVQBHyjbQaNGm7GleVliAvOk
	2ELrbKmB1xynQQOu3A/bH4ikNSTh9rWdwx9S7+VnvH+CMHc/acoaGRp6ssPuo7nWlgrnHmb
	GjQAWOPmd2PJHaJtvyRzgG2lPeY/kPchyUz7XYIHmhhSV9mmf8w48z9Qb1UkSs+fTh6YUuj
	8YC2p8nwkLfYHC5vIJq724fRuOY8WZOuCbjtwUsaj/Hgc2eb7eR0VPu+Lj0veP2bn1Lurzr
	qM3LsLkY7kcj1PcbUTuEKeb3XpNUZyJtX703ZvWIZxu+cWix7p9EzFwq1dKeBy19eAfXna5
	kTSOmNRJdzWg4JmWKIjx0pPmjTdlAYqSVUHc10/Ou6B46fm6flBJX/ZC5pJNOq1ep+khRtC
	OpLbgFSNJ1vA2KIf4T5GRK5HkRkJIyjVIvDUNdUAwOV3m8oBDYVrsaAsUYKCx49drfrMw1G
	AKz4fj/lAOUUUxw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

VGhlIHZ1bG5lcmFiaWxpdHkgaGFwcGVucyBpbiBsb2FkX3VnbHlfdGFibGUoKSwgbWlzYy9u
c3RhdC5jLCBpbiB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgaXByb3V0ZTIuDQpUaGUgdnVsbmVy
YWJpbGl0eSBjYW4gYmUgdHJpZ2dlcmVkIGJ5Og0KMS4gZGIgaXMgc2V0IHRvIE5VTEwgYXQg
c3RydWN0IG5zdGF0X2VudCAqZGIgPSBOVUxMOw0KMi4gbiBpcyBzZXQgdG8gTlVMTCBhdCBu
ID0gZGI7DQozLiBOVUxMIGRlcmVmZXJlbmNlIG9mIHZhcmlhYmxlIG4gaGFwcGVucyBhdCBz
c2NhbmYocCsxLCAiJWxsdSIsICZuLT52YWwpICE9IDENCg0KU3ViamVjdDogW1BBVENIXSBG
aXggTnVsbCBEZXJlZmVyZW5jZSB3aGVuIG5vIGVudHJpZXMgYXJlIHNwZWNpZmllZA0KDQpT
aWduZWQtb2ZmLWJ5OiBaaWFvIExpIDxsZWV6aWFvMDMzMUBnbWFpbC5jb20+DQotLS0NCm1p
c2MvbnN0YXQuYyB8IDQgKysrKw0KMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvbWlzYy9uc3RhdC5jIGIvbWlzYy9uc3RhdC5jDQppbmRleCBmY2Uz
ZTljMS4uYjJlMTliZGUgMTAwNjQ0DQotLS0gYS9taXNjL25zdGF0LmMNCisrKyBiL21pc2Mv
bnN0YXQuYw0KQEAgLTIxOCw2ICsyMTgsMTAgQEAgc3RhdGljIHZvaWQgbG9hZF91Z2x5X3Rh
YmxlKEZJTEUgKmZwKQ0KICAgICAgICAgICBwID0gbmV4dDsNCiAgICAgICB9DQogICAgICAg
biA9IGRiOw0KKyAgICAgICBpZiAobiA9PSBOVUxMKSB7DQorICAgICAgICAgICBmcHJpbnRm
KHN0ZGVyciwgIkVycm9yOiBJbnZhbGlkIGlucHV0IOKAkyBsaW5lIGhhcyAnOicgYnV0IG5v
IGVudHJpZXMuIEFkZCB2YWx1ZXMgYWZ0ZXIgJzonLlxuIik7DQorICAgICAgICAgICBleGl0
KC0yKTsNCisgICAgICAgfQ0KICAgICAgIG5yZWFkID0gZ2V0bGluZSgmYnVmLCAmYnVmbGVu
LCBmcCk7DQogICAgICAgaWYgKG5yZWFkID09IC0xKSB7DQogICAgICAgICAgIGZwcmludGYo
c3RkZXJyLCAiJXM6JWQ6IGVycm9yIHBhcnNpbmcgaGlzdG9yeSBmaWxlXG4iLA0KLS0NCjIu
MzQuMQ==


