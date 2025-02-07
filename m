Return-Path: <netdev+bounces-163852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24533A2BC97
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A16167499
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DF11A256E;
	Fri,  7 Feb 2025 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SghX7gxS"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B040187325;
	Fri,  7 Feb 2025 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914313; cv=none; b=mH1a4Px5v+pXxIOEw/f4YLqzQgtdR73cofNOIjgZH5AtyJ2Q5dLmIQSrog5AqCwEAxUAyG8V8If/Tc0R1pS4evvRjWEP7IHOlpO4zi4nNL6w7esSqNidX6wip5YmQmiFnetKfdDF8WyvupKr2K0TnTLiDTg/paApLc0EXn+qr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914313; c=relaxed/simple;
	bh=VCNdDJ5d7bTx8qymPSJoXXNnXy/61oFSBk9foV2cuf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1tSfgLEM/MG4SC3ybB15opmk1pDRH2mbk7+qKDeqydF5edQrfVOAyEM4SlAYWBmLEVbiTCm/3t2aPw/PNhFohWiGxIFXHDLOkFzFZ/axVXorL5TDcUjtlgi1Bb+LrBmBBRfHuu6RR04AfGLacoN+IibBXsm5vC257oaf44zdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SghX7gxS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738914303;
	bh=VCNdDJ5d7bTx8qymPSJoXXNnXy/61oFSBk9foV2cuf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SghX7gxSpaV9uz8WSCwHM8JuHoVak2FYzTHl+JHEDVEoMUWNdc15KysNr524Ibo9+
	 L1OXRP8q16DwvycLU84RVdVMVn1s4idOt0hU8fj+l3NqNI+auE5KyCVgZM3eHr2Xl0
	 ld6/sT3T9hWTnydGpgoD7tUj/wWNk9qauyuiERFKTXEFD/r3PyABEi6vRaZnEZLpYb
	 PyVhXY70C0gsLIlgSvy0DR2qzDfTh27oTt5Q9SV00o82wdu+Alyal3ArHVrP7jQKH6
	 dgBYExWoBHLWrr+YI+8pcKlW4SAB+5waBHakxFnz5sdajSMQ7Ww0kqFZeCKlJJFhYr
	 +ZsRu50+JALsw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AD398746BD;
	Fri,  7 Feb 2025 15:45:02 +0800 (AWST)
Message-ID: <16ff513ac43a23fb0abfeaf9ff139115d87dbf3a.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Oliver Neukum <oneukum@suse.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Santosh Puranik
	 <spuranik@nvidia.com>
Date: Fri, 07 Feb 2025 15:45:02 +0800
In-Reply-To: <b78d0e25-f8cc-43af-90d8-2c7344895d55@suse.com>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
	 <b78d0e25-f8cc-43af-90d8-2c7344895d55@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgT2xpdmVyLAoKVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLiBTb21lIHJlc3BvbnNlcyB0b28u
Cgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGhkciA9IHNrYl9wdWxsX2RhdGEo
c2tiLCBzaXplb2YoKmhkcikpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICghaGRyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBicmVhazsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoYmUx
Nl90b19jcHUoaGRyLT5pZCkgIT0gTUNUUF9VU0JfRE1URl9JRCkgewo+IAo+IEl0IHdvdWxkIGJl
IG1vcmUgZWZmaWNpZW50IHRvIGRvIHRoZSBjb252ZXJzaW9uIG9uIHRoZSBjb25zdGFudAoKQ29t
cGlsZXIgc2hvdWxkIGJlIGNsZXZlciBlbm91Z2ggZm9yIHRoYXQgbm90IHRvIG1ha2UgYSBkaWZm
ZXJlbmNlOgoKICAkIGRpZmYgLXUgXAogICAgPChhcm0tbGludXgtZ251ZWFiaWhmLW9iamR1bXAg
LWQgb2JqL2RyaXZlcnMvbmV0L21jdHAvbWN0cC11c2Iuby5vcmlnKSBcCiAgICA8KGFybS1saW51
eC1nbnVlYWJpaGYtb2JqZHVtcCAtZCBvYmovZHJpdmVycy9uZXQvbWN0cC9tY3RwLXVzYi5vKQog
IC0tLSAvZGV2L2ZkLzYzCTIwMjUtMDItMDcgMTU6MzI6NTMuODEzMDg0ODk0ICswODAwCiAgKysr
IC9kZXYvZmQvNjIJMjAyNS0wMi0wNyAxNTozMjo1My44MDkwODQ4MjYgKzA4MDAKICBAQCAtMSw1
ICsxLDUgQEAKICAgCiAgLW9iai9kcml2ZXJzL25ldC9tY3RwL21jdHAtdXNiLm8ub3JpZzogICAg
IGZpbGUgZm9ybWF0IGVsZjMyLWxpdHRsZWFybQogICtvYmovZHJpdmVycy9uZXQvbWN0cC9tY3Rw
LXVzYi5vOiAgICAgZmlsZSBmb3JtYXQgZWxmMzItbGl0dGxlYXJtCgogIERpc2Fzc2VtYmx5IG9m
IHNlY3Rpb24gLnRleHQ6CiAgJAoKQW5kIGVuZGlhbi1jb252ZXJ0aW5nIHRoZSBoZWFkZXIgZmll
bGQgKHJhdGhlciB0aGFuIHRoZSBjb25zdCkgc2VlbXMKbW9yZSByZWFkYWJsZSB0byBtZS4KCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBrdF9sZW4gPCBza2ItPmxlbikg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBt
b3JlIHBhY2tldHMgbWF5IGZvbGxvdyAtIGNsb25lIHRvIGEgbmV3Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHNrYiB0byB1c2Ugb24gdGhlIG5l
eHQgaXRlcmF0aW9uCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBza2IyID0gc2tiX2Nsb25lKHNrYiwgR0ZQX0FUT01JQyk7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChza2IyKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIXNrYl9wdWxsKHNrYjIsIHBrdF9sZW4pKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
a2ZyZWVfc2tiKHNrYjIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNrYjIgPSBOVUxMOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHNrYl90cmltKHNrYiwgcGt0X2xlbik7Cj4gCj4gVGhpcyBpcyBmdW5jdGlvbmFsLiBUaG91Z2gg
aW4gdGVybXMgb2YgYWxnb3JpdGhtIHlvdSBhcmUgY29weWluZwo+IHRoZSBzYW1lIGRhdGEgbXVs
dGlwbGUgdGltZXMuCgpUaGVyZSBzaG91bGQgYmUgbm8gY29weSBoZXJlOyB0aGV5J3JlIHNoYXJl
ZCBjbG9uZXMgb2YgdGhlIHNhbWUgYnVmZmVyLgpPciBhbSBJIG1pc3Npbmcgc29tZSBzaXR1YXRp
b24gd2hlcmUgdGhleSB3b3VsZCBnZXQgdW5zaGFyZWQ/Cgo+ID4gK3N0YXRpYyBpbnQgbWN0cF91
c2Jfb3BlbihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBtY3RwX3VzYiAqbWN0cF91c2IgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIG1jdHBfdXNiX3J4X3F1ZXVlKG1jdHBfdXNiKTsKPiAKPiBU
aGlzIHdpbGwgbmVlZGxlc3NseSB1c2UgR0ZQX0FUT01JQwoKSXQncyBvbmx5IHRoZSBvbmUgKGZp
cnN0KSBza2IgYW5kIHVyYiBzdWJtaXNzaW9uLCBidXQgZmFpciBlbm91Z2guIEknbGwKYWRkIGEg
Z2ZwX3QgYXJndW1lbnQgaW4gYSB2Mi4KCj4gPiArwqDCoMKgwqDCoMKgwqBTRVRfTkVUREVWX0RF
VihuZXRkZXYsICZpbnRmLT5kZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgZGV2ID0gbmV0ZGV2X3By
aXYobmV0ZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGRldi0+bmV0ZGV2ID0gbmV0ZGV2Owo+ID4g
K8KgwqDCoMKgwqDCoMKgZGV2LT51c2JkZXYgPSB1c2JfZ2V0X2RldihpbnRlcmZhY2VfdG9fdXNi
ZGV2KGludGYpKTsKPiAKPiBUYWtpbmcgYSByZWZlcmVuY2UuCj4gV2hlcmUgaXMgdGhlIGNvcnJl
c3BvbmRpbmcgcHV0PwoKR29vZCBjYXRjaCAtIHdlIHNob3VsZCBoYXZlIG9uZSBpbiBkaXNjb25u
ZWN0KCkuIENvbWluZyB1cCBpbiB2MiB0b28uCgpDaGVlcnMsCgoKSmVyZW15Cg==


