Return-Path: <netdev+bounces-239015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D9C624BD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 05:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 51A21208A9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 04:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9E259CBF;
	Mon, 17 Nov 2025 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="VnwuSd4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA172264C7;
	Mon, 17 Nov 2025 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353359; cv=none; b=obhVSxJvhYPgdbHowUnN3eS7h0w1GqB3D5mdQVH8QPnzkGclOZCIrVUjllaU08ZOKh0gjZuBZ1X05R8w7Fhelnqp7AU9YNR0N8fhEzssJPtPU5Tt0sc7HEaAkkPdq6SaJx/gtZiv0LGq/evXKkiEh8d3nfOIdt8WLsVLgrZZEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353359; c=relaxed/simple;
	bh=nisJ4PL8McXPASRaFJTiRwIZk2v4VkPNUJFFULAnVgQ=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type; b=t6fFY8tncOI+31rXwGHqUQaKbicupgeiXIVSSGE2PtJPbr0oKt0snTf+8NGFUtpRyhZ+W7EVX3EmXsGockv1Rnro6LZzw5llvD1tx8JI3TcIhyfhh8iDzww1oILBCgt3zNKOtWGhCuGaEiA1H4ZLOh02GCbl5UUg+KswNUcXkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com; spf=pass smtp.mailfrom=tencent.com; dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b=VnwuSd4i; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1763353339;
	bh=nisJ4PL8McXPASRaFJTiRwIZk2v4VkPNUJFFULAnVgQ=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=VnwuSd4iKj/T1CqWGU4hTM08PF67tpihqNruAr5iLDLwMJ9ukZ6UAQW/tXUrbhfz+
	 gz+3xGpQs0fXtT4y4nkVqVl6j+JLwc3uSU2xghuszfnDQ0fDL2t16DgZ6PqoMefO0K
	 myo0xpIgrPDuqz/PgLSjgAZJ/lguo8NlvzGv9L9I=
X-QQ-mid: zesmtpsz9t1763353336t0a1965bb
X-QQ-Originating-IP: 6ev65us0ewMcQKnCPraUDhEsqXI78m187qgv7AUa3gs=
Received: from FLYNNNCHEN-PC1 ( [11.176.19.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Nov 2025 12:22:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3243746328339727491
Date: Mon, 17 Nov 2025 12:22:15 +0800
From: "=?gb18030?B?Zmx5bm5uY2hlbiizwszss/4p?=" <flynnnchen@tencent.com>
To: krzk <krzk@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfc: port100: guard against incomplete USB frames
X-Priority: 3
X-GUID: 8E9B0D3C-9B86-40C6-AA90-D3B4EB08A938
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.492[en]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <D9E78B690F07660A+202511171222138721171@tencent.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Obfty5iaetlmydmOVXyfQXmKZJru30U1XQFdvt2OnJlwW2I+ThYEx7js
	MeFxmtjADC2Xt6T8P2m5XxTeVqMNPbdiOduwrndEOLXL20zrd8V1wt5KdIH1Uy+o4Or8B/Q
	sh5uIdcAfVkAyLBSyKHwkZKL9SlYnThdacGmbWoxWh7bMDMjBr11tqvNeMtCgY0K7uQM6yj
	NvKQsVlNv7m9KhtHzehLJGmFp5oegkWV+c1qbXpB1x/thWWHAK7AdcX3DwwnAbcgPGjEnF+
	e3mIbJouF+4CTTOOaQJe8ogrCHezdZRdXnnWw+9giqorqnFF/Sj26wvHMClfEyjUPi1zkpD
	H7W7FfaECjHWBlL3Ek3zzNsVyaVVN4W1mOxT6M33HupW1Fl45Sj2ixXrLy609ED8pMyQ6gK
	ikM82JJXS13wYUB3rSMB1Ba4oLCBQzPpayk6xvcR1SLDbqtluPozap3DPzJvEVEomJ8E0VY
	HtYaEayi4IFPd/7miKHNLLDBS6vrfPLxja8LyLtG508pZrxwc00ozaLF5wb81+MGg9xohDU
	5gEq1qLm2GF2khxTpqV/MpYam4vAl8Fjmv/PAQ7DPXzDnPuc+Ly4bUxMsVl/yTbhq9dQiXD
	7vhtK2MIu9oW3K/fFwKSQnEd7ZeVQ4HkOUokXEaEaWItYsUiz37FQ7KwVj89A5Hd+sI2E9V
	hH0i4sxCvCk81FvZpatvW1O7sIfOPfNypnPXGPjf7NWjpW6E2JYULfPOuhUrC+1auoBP69X
	3oXRK/KuZARe5ndK+iDKGIziYlfha31w4y8tvle/RLGkSIQdNazXZvEOXCRaToWugQu/5X0
	QnWFRYYhFnhXXgi2PQPVKe8MMv0RvbWLbVXOscDLgg/g0hGVaozLdQmo6mFk4sgWa3YMjcl
	T971try1XbenA84nqZgXVbl/no+8tJn3eKMtT6MKy3fRinivhXVKlAHlrclshOBHD1cL6RW
	njZaW4V4Zm66kwxu2yAtwCrQ7
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

RGlzY292ZXJlZCBieSBBdHVpbiAtIEF1dG9tYXRlZCBWdWxuZXJhYmlsaXR5IERpc2NvdmVyeSBF
bmdpbmUuCgpWYWxpZGF0ZSB0aGF0IHRoZSBVUkIgcGF5bG9hZCBpcyBsb25nIGVub3VnaCBmb3Ig
dGhlIGZyYW1lIGhlYWRlciBhbmQgdGhlCmFkdmVydGlzZWQgZGF0YSBsZW5ndGggYmVmb3JlIGFj
Y2Vzc2luZyBpdCwgc28gdHJ1bmNhdGVkIHRyYW5zZmVycyBhcmUKcmVqZWN0ZWQgd2l0aCAtRUlP
LCBwcmV2ZW50aW5nIHRoZSBkcml2ZXIgZnJvbSByZWFkaW5nIG91dC1vZi1ib3VuZHMgYW5kCmxl
YWtpbmcga2VybmVsIG1lbW9yeSB0byBVU0IgZGV2aWNlcy4KClNpZ25lZC1vZmYtYnk6IFRpYW5j
aHUgQ2hlbiA8Zmx5bm5uY2hlbkB0ZW5jZW50LmNvbT4KLS0tCiBkcml2ZXJzL25mYy9wb3J0MTAw
LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmZjL3BvcnQxMDAuYyBiL2RyaXZlcnMv
bmZjL3BvcnQxMDAuYwppbmRleCAwMGQ4ZWE2ZGMuLjdjZDQzOWY2NiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9uZmMvcG9ydDEwMC5jCisrKyBiL2RyaXZlcnMvbmZjL3BvcnQxMDAuYwpAQCAtNTY4LDEx
ICs1NjgsMTcgQEAgc3RhdGljIHZvaWQgcG9ydDEwMF90eF91cGRhdGVfcGF5bG9hZF9sZW4odm9p
ZCAqX2ZyYW1lLCBpbnQgbGVuKQogCWxlMTZfYWRkX2NwdSgmZnJhbWUtPmRhdGFsZW4sIGxlbik7
CiB9CiAKLXN0YXRpYyBib29sIHBvcnQxMDBfcnhfZnJhbWVfaXNfdmFsaWQoY29uc3Qgdm9pZCAq
X2ZyYW1lKQorc3RhdGljIGJvb2wgcG9ydDEwMF9yeF9mcmFtZV9pc192YWxpZChjb25zdCB2b2lk
ICpfZnJhbWUsIHNpemVfdCBsZW4pCiB7CiAJdTggY2hlY2tzdW07CiAJY29uc3Qgc3RydWN0IHBv
cnQxMDBfZnJhbWUgKmZyYW1lID0gX2ZyYW1lOwogCisJaWYgKGxlbiA8IHNpemVvZigqZnJhbWUp
KQorCQlyZXR1cm4gZmFsc2U7CisKKwlpZiAobGVuIDwgKHNpemVfdCkobGUxNl90b19jcHUoZnJh
bWUtPmRhdGFsZW4pKSArIHNpemVvZigqZnJhbWUpKQorCQlyZXR1cm4gZmFsc2U7CisKIAlpZiAo
ZnJhbWUtPnN0YXJ0X2ZyYW1lICE9IGNwdV90b19iZTE2KFBPUlQxMDBfRlJBTUVfU09GKSB8fAog
CSAgICBmcmFtZS0+ZXh0ZW5kZWRfZnJhbWUgIT0gY3B1X3RvX2JlMTYoUE9SVDEwMF9GUkFNRV9F
WFQpKQogCQlyZXR1cm4gZmFsc2U7CkBAIC02MzYsNyArNjQyLDcgQEAgc3RhdGljIHZvaWQgcG9y
dDEwMF9yZWN2X3Jlc3BvbnNlKHN0cnVjdCB1cmIgKnVyYikKIAogCWluX2ZyYW1lID0gZGV2LT5p
bl91cmItPnRyYW5zZmVyX2J1ZmZlcjsKIAotCWlmICghcG9ydDEwMF9yeF9mcmFtZV9pc192YWxp
ZChpbl9mcmFtZSkpIHsKKwlpZiAoIXBvcnQxMDBfcnhfZnJhbWVfaXNfdmFsaWQoaW5fZnJhbWUs
IHVyYi0+YWN0dWFsX2xlbmd0aCkpIHsKIAkJbmZjX2VycigmZGV2LT5pbnRlcmZhY2UtPmRldiwg
IlJlY2VpdmVkIGFuIGludmFsaWQgZnJhbWVcbiIpOwogCQljbWQtPnN0YXR1cyA9IC1FSU87CiAJ
CWdvdG8gc2NoZWRfd3E7Ci0tIAoyLjM5LjUKCgo=


