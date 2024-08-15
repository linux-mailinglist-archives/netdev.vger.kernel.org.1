Return-Path: <netdev+bounces-118825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B16952E5B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4AC285363
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AEC1993BD;
	Thu, 15 Aug 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="YYeG19Ry"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0421714B9
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725289; cv=none; b=NneQB2D18GOeCpFFR6jsdTbKzQGBF4iU+/PcOnQ6LmTb8A3W8mGWfDDwzNEFcPGL7hb8jh2gHyQgk+WIYAD9PPptK2N2lqG8zSX0VVsWQGszEG9eHKHfGvjennaiPHykmWb/A2vEJMXLD/9JR13CpG4iksh0A/VcynEQThfRgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725289; c=relaxed/simple;
	bh=/TIeo+bG7sjgvMiPLNeA4/1aWjXq7WMPetIeuy7Gkfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HQWcnBA8pkWJZtfgqspH0hM9WQTEfCwN69ye6J8LiEt1TYOZdj3YU4Aqd3NoVZpDOnOFLsOezjc11WGbkC/pquRNyJ9mw6wL+sm6NqSeHMg0wYmbV9r3jZ/OZNmnBinq2TWXIY8AzC1sNTGmuY2zWRklGj1Na8pEr4CBkR8UKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=YYeG19Ry reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TW460Yv1ow6zntOqK5StPPgDtYFaHiahtYN74xhtNr8=; b=Y
	YeG19RywDTJT/aBc388pWW7XfG2QYSC2aaatYPIheETe8NzKCWOXWwC11Zk4RacJ
	87fwP0wbtiKSlKfmU0quD2tPhPYx8QsL4hFJjPy+pVBXP3PVHzz8EeFBGDdKj/HO
	GZbJD3EmVxJoomL+IK5s71oGYkCkUQ1U9wjEnJaWZs=
Received: from 13514081436$163.com ( [116.235.71.46] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Thu, 15 Aug 2024 20:33:21 +0800
 (CST)
Date: Thu, 15 Aug 2024 20:33:21 +0800 (CST)
From: wkx <13514081436@163.com>
To: "Florian Westphal" <fw@strlen.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, 21210240012@m.fudan.edu.cn
Subject: Re:Re: [BUG net] possible use after free bugs due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240812190057.GB21559@breakpoint.cc>
References: <49ee57f2.9a9d.191465ab362.Coremail.13514081436@163.com>
 <20240812190057.GB21559@breakpoint.cc>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25a912f1.9be7.19156073fad.Coremail.13514081436@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wC3_9iR9b1m8hIjAA--.36971W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiwhY52GWXwNt-YwAEsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx577yBCuWcqCAyMDI0LTA4LTEzIDAzOjAwOjU377yMIkZs
b3JpYW4gV2VzdHBoYWwiIDxmd0BzdHJsZW4uZGU+IOWGmemBk++8mgo+d2t4IDwxMzUxNDA4MTQz
NkAxNjMuY29tPiB3cm90ZToNCj4+IA0KPj4gDQo+PiBPdXLCoHRlYW3CoHJlY2VudGx5wqBkZXZl
bG9wZWTCoGHCoHZ1bG5lcmFiaWxpdHnCoGRldGVjdGlvbsKgdG9vbCzCoGFuZMKgd2XCoGhhdmXC
oGVtcGxveWVkwqBpdMKgdG/CoHNjYW7CoHRoZcKgTGludXjCoEtlcm5lbMKgKHZlcnNpb27CoDYu
OS42KS7CoEFmdGVywqBtYW51YWzCoHJldmlldyzCoHdlwqBmb3VuZMKgc29tZcKgcG90ZW50aWFs
bHnCoHZ1bG5lcmFibGXCoGNvZGXCoHNuaXBwZXRzLMKgd2hpY2jCoG1hecKgaGF2ZcKgdXNlLWFm
dGVyLWZyZWXCoGJ1Z3PCoGR1ZcKgdG/CoHJhY2XCoGNvbmRpdGlvbnMuwqBUaGVyZWZvcmUswqB3
ZcKgd291bGTCoGFwcHJlY2lhdGXCoHlvdXLCoGV4cGVydMKgaW5zaWdodMKgdG/CoGNvbmZpcm3C
oHdoZXRoZXLCoHRoZXNlwqB2dWxuZXJhYmlsaXRpZXPCoGNvdWxkwqBpbmRlZWTCoHBvc2XCoGHC
oHJpc2vCoHRvwqB0aGXCoHN5c3RlbS4NCj4+IA0KPj4gMS7CoC9kcml2ZXJzL25ldC9ldGhlcm5l
dC9icm9hZGNvbS9iY202M3h4X2VuZXQuYw0KPj4gDQo+PiBJbsKgYmNtX2VuZXRfcHJvYmUswqAm
cHJpdi0+bWliX3VwZGF0ZV90YXNrwqBpc8KgYm91bmRlZMKgd2l0aMKgYmNtX2VuZXRfdXBkYXRl
X21pYl9jb3VudGVyc19kZWZlci7CoGJjbV9lbmV0X2lzcl9tYWPCoHdpbGzCoGJlwqBjYWxsZWTC
oHRvwqBzdGFydMKgdGhlwqB3b3JrLg0KPj4gSWbCoHdlwqByZW1vdmXCoHRoZcKgZHJpdmVywqB3
aGljaMKgd2lsbMKgY2FsbMKgYmNtX2VuZXRfcmVtb3ZlwqB0b8KgbWFrZcKgYcKgY2xlYW51cCzC
oHRoZXJlwqBtYXnCoGJlwqB1bmZpbmlzaGVkwqB3b3JrLg0KPj4gVGhlwqBwb3NzaWJsZcKgc2Vx
dWVuY2XCoGlzwqBhc8KgZm9sbG93czoNCj4+IENQVTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBDUFUxDQo+PiDCoA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoGJjbV9lbmV0X3Vw
ZGF0ZV9taWJfY291bnRlcnNfZGVmZXINCj4+IGJjbV9lbmV0X3JlbW92ZcKgwqDCoMKgwqDCoMKg
wqB8DQo+DQo+ICB1bnJlZ2lzdGVyX25ldGRldihkZXYpOw0KPg0KPi4uLiB3aGljaCBzaG91bGQg
ZW5kIHVwIGNhbGxpbmcgYmNtX2VuZXRfc3RvcCgpICh2aWEgb3BzLT5uZG9fc3RvcCBpbg0KPl9f
ZGV2X2Nsb3NlX21hbnkoKSkuICBUaGlzIGNhbGxzIGNhbmNlbF93b3JrX3N5bmMoKS4NCj4NCj5E
aWQgbm90IGxvb2sgYXQgdGhlIG90aGVycy4NCg==

