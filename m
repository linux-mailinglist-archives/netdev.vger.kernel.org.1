Return-Path: <netdev+bounces-246031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A493CDD319
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 03:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5469A3017EC2
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 02:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDCF2288D5;
	Thu, 25 Dec 2025 02:04:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135C2248A5;
	Thu, 25 Dec 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766628287; cv=none; b=FDd11pgPqO9lXQwM0FNjNhE6ffPr2velPldZdBdhCZfaori5seyV0PatSMkS34tPCV5TkTPiv64zDr8BlbDy1r00NJwsi4PZ9ZG4mET5E+V+uydjJDFHUdxNIRZbRP5sF9ZMV8nF8aazwE4AYyyyM2OYhnUvzbYvazPG0mAd3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766628287; c=relaxed/simple;
	bh=ytEtfJQ9V1cKs+COBBRfZEJTKB613VkFcA+IP3T5B2A=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=FZ0sjadgLoCbe4E9PENXZ2mDXqN+T+XrmXja4NsreketiDDBoQt7OMPkqg9hEj8XM+vMCh+N4yzGt7P4zOA2z+ArUmLe6/774MS1yUoiputdjeUbLcc71eF9jvdH67PGRDt48GjtzDNE2TRXzxyqfwO4pD8BCYYBVVRrYQSnHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xujiakai24$mails.ucas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-10 (Coremail) ; Thu, 25 Dec 2025 09:56:51 +0800
 (GMT+08:00)
Date: Thu, 25 Dec 2025 09:56:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jiakai Xu" <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net
Subject: [BUG] net: Bad page state in skb_pp_cow_data
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <338e2eb7.723e4.19b53391fa8.Coremail.xujiakai24@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowAA3T+LjmUxpz2wDAA--.20602W
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/1tbiBgsHE2lMkj0WkwA
	AsW
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgYWxsLAoKSSBoYXZlIGVuY291bnRlcmVkIGEgIkJhZCBwYWdlIHN0YXRlIiBidWcgd2hpbGUg
ZnV6emluZyB0aGUga2VybmVsLgoKVGhlIGlzc3VlIHdhcyBpbml0aWFsbHkgZm91bmQgb24gYSBS
SVNDLVYgYnJhbmNoLiBBZnRlciBhbmFseXppbmcgdGhlIGtlcm5lbCBsb2dzLCAKSSBzdXNwZWN0
ZWQgdGhlIGJ1ZyB3YXMgYXJjaGl0ZWN0dXJlLWluZGVwZW5kZW50LiBUbyB2ZXJpZnkgdGhpcywg
SSByZXByb2R1Y2VkIAppdCBvbiB0aGUgbGF0ZXN0IG1haW5saW5lIHg4NiBrZXJuZWwgKGNvbW1p
dDogY2NkMWNkY2E1Y2Q0MzNjOGE1ZGZmNzhiNjlhNzliMzFkOWI3N2VlMSksIAphbmQgaXQgcmVw
cm9kdWNlZCBzdWNjZXNzZnVsbHkuCgpUaGUgYnVnIGFwcGVhcnMgdG8gYmUgdHJpZ2dlcmVkIHdo
ZW4gYSBHZW5lcmljIFhEUCBwcm9ncmFtIGNhbGxzIGJwZl94ZHBfYWRqdXN0X3RhaWwgCnRvIHNo
cmluayBhIHBhY2tldCwgY2F1c2luZyBhIHBhZ2VfcG9vbCBtYW5hZ2VkIHBhZ2UgdG8gYmUgaW5j
b3JyZWN0bHkgZnJlZWQgdmlhIHRoZSAKc3RhbmRhcmQgcGFnZSBhbGxvY2F0b3IuCgpJIGhhdmUg
dXBsb2FkZWQgdGhlIGZvbGxvd2luZyBtYXRlcmlhbHMgdG8gR2l0SHViIGZvciByZWZlcmVuY2U6
Ci0gS2VybmVsIGNvbmZpZyBmaWxlcyAoeDg2KSAgCi0gQyByZXByb2R1Y2VyICAKLSBLZXJuZWwg
bG9ncyBmb3IgYm90aCB4ODYgYW5kIFJJU0MtViAgCiAKTGluazogaHR0cHM6Ly9naXRodWIuY29t
L2oxYWthaS90ZW1wL3RyZWUvbWFpbi8yMDI1MTIyNQoKRG9lcyBhbnlvbmUgaGF2ZSBzdWdnZXN0
aW9ucyBmb3IgYSBmaXg/IEkgd291bGQgYmUgdmVyeSBoYXBweSB0byBoZWxwIGZpeCBpdCBhbmQg
CnRlc3QgYW55IHBhdGNoZXMuCgpCZXN0IHJlZ2FyZHMsIEppYWthaQoKCg==

