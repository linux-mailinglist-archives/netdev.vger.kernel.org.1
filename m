Return-Path: <netdev+bounces-117675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5094EBD6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DBA1C20D9E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4617108B;
	Mon, 12 Aug 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jSjI66FJ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9993C0B
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462310; cv=none; b=EdxRr6eEz9s7ZqNE3suezRn/HB2wI547uPnwzgGpxpcb6JL6R4/byNruDmxew6tNx0+HjhxZdNxqsvpLDGzjyVFsFLsNT2fJ9oOgcYxdZE4AVCGqqWRGWZ+S7n2LF1qTEA6/pZR6NPT+VnZMb7ZUPfi0okcxij0qJwM4ZVIRHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462310; c=relaxed/simple;
	bh=J1K/CO+YoSRda8N2Gd2Zz4HXBVAO8DNWNd1A44jz8Mk=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=ftWBJaMS/GwmclhHyuhCqoghyH2DUnpTVHYgO3xx60DJKhrf008ahaawYn/FRbWe+TPeE5Kj5y+iWxVVBCzeyrRRR7V4Mpk8dtxwb6ybho17JVaaqxfgYM485UpFOjDT/muzLzRTV4NVP+AG864nM9WqQY3gSFk1mxpfTb7t6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jSjI66FJ reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vomZK4sLRBKIUdmuHwYv5g2qtRY9jXtzWowwKz7RGwU=; b=j
	SjI66FJ4mqBGtn1QA5y1RbVVz+7oKm70nii9wKIiaBQaXkH3dx5cjYmG6G5SXvFa
	FW2uNNIjr+fWpyS4QDCg/OXEe1YsTfhcwwW3CkAH2HgVRTWRPbUx+f0SC/O8dGrN
	9NsRiFM6JpRbMpUCjSPcypJW/Luxo5sIsFsTLIB3z0=
Received: from 13514081436$163.com ( [202.120.235.4] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Mon, 12 Aug 2024 19:30:34 +0800
 (CST)
Date: Mon, 12 Aug 2024 19:30:34 +0800 (CST)
From: wkx  <13514081436@163.com>
To: davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, 21210240012@m.fudan.edu.cn
Subject: [BUG net] possible use after free bugs due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZAfidvUoo4imfZOkXn0kbjug3WcW0u/0k3oJUNps0uibC8RsdY2JCJXvP/O2uAAO8rQWregB3zuJnYIBAeK1VbwEeHLa1+W53NY2VbD4u
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49ee57f2.9a9d.191465ab362.Coremail.13514081436@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n61b8rlmaK0ZAA--.4588W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiZRU52GXAnsMNNgAIsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpPdXLCoHRlYW3CoHJlY2VudGx5wqBkZXZlbG9wZWTCoGHCoHZ1bG5lcmFiaWxpdHnCoGRldGVj
dGlvbsKgdG9vbCzCoGFuZMKgd2XCoGhhdmXCoGVtcGxveWVkwqBpdMKgdG/CoHNjYW7CoHRoZcKg
TGludXjCoEtlcm5lbMKgKHZlcnNpb27CoDYuOS42KS7CoEFmdGVywqBtYW51YWzCoHJldmlldyzC
oHdlwqBmb3VuZMKgc29tZcKgcG90ZW50aWFsbHnCoHZ1bG5lcmFibGXCoGNvZGXCoHNuaXBwZXRz
LMKgd2hpY2jCoG1hecKgaGF2ZcKgdXNlLWFmdGVyLWZyZWXCoGJ1Z3PCoGR1ZcKgdG/CoHJhY2XC
oGNvbmRpdGlvbnMuwqBUaGVyZWZvcmUswqB3ZcKgd291bGTCoGFwcHJlY2lhdGXCoHlvdXLCoGV4
cGVydMKgaW5zaWdodMKgdG/CoGNvbmZpcm3CoHdoZXRoZXLCoHRoZXNlwqB2dWxuZXJhYmlsaXRp
ZXPCoGNvdWxkwqBpbmRlZWTCoHBvc2XCoGHCoHJpc2vCoHRvwqB0aGXCoHN5c3RlbS4KCjEuwqAv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYmNtNjN4eF9lbmV0LmMKCkluwqBiY21fZW5l
dF9wcm9iZSzCoCZwcml2LT5taWJfdXBkYXRlX3Rhc2vCoGlzwqBib3VuZGVkwqB3aXRowqBiY21f
ZW5ldF91cGRhdGVfbWliX2NvdW50ZXJzX2RlZmVyLsKgYmNtX2VuZXRfaXNyX21hY8Kgd2lsbMKg
YmXCoGNhbGxlZMKgdG/CoHN0YXJ0wqB0aGXCoHdvcmsuCklmwqB3ZcKgcmVtb3ZlwqB0aGXCoGRy
aXZlcsKgd2hpY2jCoHdpbGzCoGNhbGzCoGJjbV9lbmV0X3JlbW92ZcKgdG/CoG1ha2XCoGHCoGNs
ZWFudXAswqB0aGVyZcKgbWF5wqBiZcKgdW5maW5pc2hlZMKgd29yay4KVGhlwqBwb3NzaWJsZcKg
c2VxdWVuY2XCoGlzwqBhc8KgZm9sbG93czoKQ1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoENQVTEKwqAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoGJjbV9lbmV0X3VwZGF0ZV9taWJf
Y291bnRlcnNfZGVmZXIKYmNtX2VuZXRfcmVtb3ZlwqDCoMKgwqDCoMKgwqDCoHwKZnJlZV9uZXRk
ZXbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8CmtmcmVlKG5ldGRldik7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgbmV0aWZfcnVubmlu
ZwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB8wqAvL3VzZcKgbmV0ZGV2CgoyLsKgL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2Jyb2FkY29tL2dlbmV0L2JjbWdlbmV0LmMKCkluwqBiY21nZW5ldF9wcm9iZSzCoCZwcml2
LT5iY21nZW5ldF9pcnFfd29ya8KgaXPCoGJvdW5kZWTCoHdpdGjCoGJjbWdlbmV0X2lycV90YXNr
LsKgYmNtZ2VuZXRfaXNyMMKgd2lsbMKgYmXCoGNhbGxlZMKgdG/CoHN0YXJ0wqB0aGXCoHdvcmsu
CklmwqB3ZcKgcmVtb3ZlwqB0aGXCoGRyaXZlcsKgd2hpY2jCoHdpbGzCoGNhbGzCoGJjbWdlbmV0
X3JlbW92ZcKgdG/CoG1ha2XCoGHCoGNsZWFudXAswqB0aGVyZcKgbWF5wqBiZcKgdW5maW5pc2hl
ZMKgd29yay4KVGhlwqBwb3NzaWJsZcKgc2VxdWVuY2XCoGlzwqBhc8KgZm9sbG93czoKQ1BVMMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoENQVTEKwqAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoGJjbWdlbmV0
X2lycV90YXNrCmJjbWdlbmV0X3JlbW92ZcKgwqDCoMKgwqDCoMKgwqDCoHwKZnJlZV9uZXRkZXbC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwKa2ZyZWUobmV0ZGV2KTvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgcGh5X2luaXRf
aHcocHJpdi0+ZGV2LT5waHlkZXYpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoC8vdXNlwqBuZXRkZXYK
CjMuwqAvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2dpYW5mYXIuYwoKSW7CoGdmYXJf
cHJvYmUswqAmcHJpdi0+cmVzZXRfdGFza8KgaXPCoGJvdW5kZWTCoHdpdGjCoGdmYXJfcmVzZXRf
dGFzay7CoGdmYXJfZXJyb3LCoG9ywqBnZmFyX3RpbWVvdXTCoHdpbGzCoGJlwqBjYWxsZWTCoHRv
wqBzdGFydMKgdGhlwqB3b3JrLgpJZsKgd2XCoHJlbW92ZcKgdGhlwqBkcml2ZXLCoHdoaWNowqB3
aWxswqBjYWxswqBnZmFyX3JlbW92ZcKgdG/CoG1ha2XCoGHCoGNsZWFudXAswqB0aGVyZcKgbWF5
wqBiZcKgdW5maW5pc2hlZMKgd29yay4KVGhlwqBwb3NzaWJsZcKgc2VxdWVuY2XCoGlzwqBhc8Kg
Zm9sbG93czoKQ1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQ1BVMQrCoArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoGdmYXJf
cmVzZXRfdGFzawpnZmFyX3JlbW92ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfApm
cmVlX2dmYXJfZGV2wqDCoMKgwqB8CmZyZWVfbmV0ZGV2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHwKa2ZyZWUobmV0ZGV2KTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwKwqDC
oMKgwqDCoMKgwqDCoCAgICAgICAgICAgICAgICAgICAgICAgICAgwqB8wqByZXNldF9nZmFyCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHzCoHN0b3BfZ2ZhcgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqAvL3VzZcKgbmV0ZGV2
CsKgCkJlbG93wqBhcmXCoHNvbWXCoGtub3duwqBDVkVzwqBhbmTCoHRoZWlywqBwYXRjaMKgY29t
bWl0c8KgY29ycmVzcG9uZGluZ8KgdG/CoGHCoHNpbWlsYXLCoHZ1bG5lcmFiaWxpdHkuCkNWRS0y
MDIzLTMzMjAzCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTZiNmJjNWI4YmQyZDRjYTllMWVmYTlhZTBm
OThhMGIwNjg3YWNlNzUswqAKQ1ZFLTIwMjMtMTY3MApodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzAzMTYxNjE1MjYuMTU2ODk4Mi0xLXp5eXRsei53ekAxNjMuY29tLwrCoApUaGFua8Kg
eW91wqBmb3LCoHlvdXLCoHRpbWXCoGFuZMKgY29uc2lkZXJhdGlvbi4KCsKg

