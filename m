Return-Path: <netdev+bounces-112276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C01937EC1
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 04:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A811C2109B
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1608830;
	Sat, 20 Jul 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="pMK4C2VN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5572F46;
	Sat, 20 Jul 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721442728; cv=none; b=lM2BFKtYZKQ6RG+TuXTmms5oGXBSxTLryH0Lj/F/AZ3YfZ0tdjoAV9uupG000mTUqxxP95+V3+aniOCF1t+SXnN74/R+Z5VN6dQKWUPgq2MCjMjJUrx81Tbbp1Z15VY/esWXO+Pn19EGgT1z+yN4CEFo1AtB0MNCwZUpjqPNsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721442728; c=relaxed/simple;
	bh=vi2goXNvXsVZR7iCnXdIy40cEHufPFWJc1hO5WLlOWs=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=WEwzxh9JrJ9myH71BzjeROwd9tcppeOVit7fCWtNMOepINIG2MHrLOxUK+FS2EQtYfPnekr2qWPE2A6lBdw8oLQQtDfI26tqq20bIBDI4wR0eKLLWg/fKBz/NGlSyOcYuSGdzW0HfG9M8CvXaAYrXx301dY+PPOwkEt2n/jkgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=pMK4C2VN; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 0BE78717A;
	Sat, 20 Jul 2024 04:24:35 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id LcgIJY3O_eYF; Sat, 20 Jul 2024 04:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1721442273;
	bh=71FB7OCv9kjuG9F19WnBRfjq4mqOoWPhbl8WY5jqla8=;
	h=Date:From:To:Subject:Cc:From;
	b=pMK4C2VNLNgDclK48xIzOikLQb23v6Ar530Lguinh/8p9nWWb6AIPBrsmtcLJp5xL
	 9k+cBwrH3udRbBiIQuiuXdpTdxaHuJBsq4kE+KBXCLR2MIzwPDAK/p1UJtZEfKP4gC
	 B7qUKuPt4kPMkOwMLDExgATBR5l3mJdI/P2L4ox0GBl89FFJqICyAz1hyvLmfW/a7t
	 ocYHqsmUMr7T/oFl8CxEqjq+iRNBKvhWEAD9L2daxj5lIboPRgAzOUKkijwtAjJIXH
	 Pthg6Aee8zpd0aHoDiYMniwLnDr0XVKJUr/J3n7m+UGVNbPWV24TfZZ9wzbqBYdR5Q
	 Lhm4Rr1uQRMUw==
Received: from [192.168.88.185] (cmpgw-27.felk.cvut.cz [147.32.84.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: peckama2)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 7D56E72B7;
	Sat, 20 Jul 2024 04:24:33 +0200 (CEST)
Message-ID: <def1073b-8997-48cd-adf3-e834662881de@fel.cvut.cz>
Date: Sat, 20 Jul 2024 04:24:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Pecka <peckama2@fel.cvut.cz>
Content-Language: en-US, cs-CZ
To: irusskikh@marvell.com, epomozov@marvell.com
Subject: net: atlantic: PHC time jumps ~4 seconds there and back on AQC107
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030800020305030606010608"

This is a cryptographically signed message in MIME format.

--------------ms030800020305030606010608
Content-Type: multipart/alternative;
 boundary="------------J6yDtaD88XUPB05b00i7MTuu"

--------------J6yDtaD88XUPB05b00i7MTuu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gYXRsYW50aWMgZHJpdmVyIG1haW50YWluZXJzLiBUaGlzIGlzIG15IGZpcnN0IGtl
cm5lbCBidWdyZXBvcnQsIHNvIHBsZWFzZSB0cnkgdG8gYmUgcGF0aWVudCA6KQ0KSG93ZXZl
ciwgSSd2ZSBzcGVudCBmdWxsIDMgd29ya2luZyBkYXlzIChhbmQgbmlnaHRzKSBkZWJ1Z2dp
bmcgdGhpcyBpc3N1ZSwgc28gSSBob3BlIHdlJ2xsIGZpbmQNCmEgd2F5IHRvIGZpeCBpdCBw
cm9wZXJseS4gU28gZmFyLCBJJ3ZlIGNvbWUgd2l0aCBhIHdvcmthcm91bmQsIGJ1dCBJJ20g
bm90IHN1cmUgYWJvdXQgaXRzIHNpZGUtZWZmZWN0cy4NCg0KU3VtbWFyeTogUEhDIHRpbWUg
anVtcHMgfjQgc2Vjb25kcyB0aGVyZSBhbmQgYmFjayBvbiBBUUMxMDcNCg0KSSdtIHRlc3Rp
bmcgb24gbXVsdGlwbGUgY29wcGVyLVBIWSBOSUNzIHdpdGggQVFDMTA3IGFuZCB0aGUgcHJv
YmxlbSBpcyBhbHdheXMgdGhlIHNhbWU6DQotIFFOQVAgUVhHLTEwRzJUQiwgUENJZSwgRlcg
My4xLjEyMQ0KLSBTYW5saW5rMyBOMSwgVGh1bmRlcmJvbHQsIEZXIDMuMS4xMjENCi0gT1dD
IE9XQ1RCM0FEUDEwR0JFLCBUaHVuZGVyYm9sdCwgRlcgMy4xLjEwNiAoaXQgY2Fubm90IHJ1
biAzLjEuMTIxKQ0KLSBTb25uZXR0ZWNoIFNvbG8xMEcgMTBHQkFTRS1ULCBUaHVuZGVyYm9s
dCwgRlcgMy4xLjEyMQ0KDQpJIHJ1biB0aGUgdGVzdHMgb24gbXVsdGlwbGUgUENzIHdpdGgg
ZGlmZmVyZW50IENQVSBhcmNocyBhbmQgdGhlIHByb2JsZW0gaXMgYWx3YXlzIHRoZSBzYW1l
Og0KLSBJbnRlbCBOVUMgKFRodW5kZXJib2x0LCB4ODYtNjQsIGtlcm5lbCA2LjgsIHVwc3Ry
ZWFtIGF0bGFudGljIGRyaXZlcikNCi0gTlZpZGlhIEpldHNvbiAoUENJZSwgYWFyY2g2NCwg
a2VybmVsIDQuOS4zMzcgKyBvdXQtb2YtdHJlZSBkcml2ZXJodHRwczovL2dpdGh1Yi5jb20v
QXF1YW50aWEvQVF0aW9uICApLg0KDQpXaGVuIEkgZW5hYmxlIFBUUCBvbiB0aGUgY2FyZCAo
ZS5nLiBgaHdzdGFtcF9jdGwgLWkgZXRoMiAtdCAxYCkgYW5kIHJ1biBwaGMyc3lzIGZyb20g
bGludXhwdHANCnRvIHN5bmMgdGhlIGNhcmQncyBQSEMgdG8gYW5vdGhlciBjbG9jayAoQVEx
MDcgaXMgdGltZSBzaW5rKSwgSSBnZXQgdGltZSBqdW1wcyBvZiB0aGUgUEhDIGNsb2NrDQpv
ZiB+NCBzZWNzIGluIHRoZSBmdXR1cmUgYW5kIHRoZW4gYmFjayAoYWZ0ZXIgfjUgc2Vjcyku
IFRoZXNlIGp1bXBzIGhhcHBlbiBpbiByYW5kb20gaW50ZXJ2YWxzDQphbmQgSSBoYXZlbid0
IGZvdW5kIGEgcGF0dGVybi4gVXN1YWxseSwgaXQgaGFwcGVucyBldmVyeSAyMC0xMDAgc2Vj
cywgYnV0IHRoZXJlIGhhdmUgYmVlbiBldmVuDQptdWNoIGxvbmdlciBpbnRlcnZhbHMuIFRo
ZXNlIHRpbWUganVtcHMgYXJlIGNvcnJlY3RlZCBieSBwaGMyc3lzIHF1aXRlIHF1aWNrbHkg
KHdpdGhpbiB+MTAgc2Vjb25kcyksDQpidXQgZHVyaW5nIHRoaXMgaW50ZXJ2YWwsIHRoZSB0
aW1lIGlzIHdyb25nLg0KDQpBbiBlYXN5IHdheSB0byB0cmlnZ2VyIHRoaXMgaXNzdWUgaXMg
dG8gY29ubmVjdCBhIGNhYmxlIHRvIHRoZSBwb3J0IChzYXkgZXRoMikgYW5kIHJ1bjoNCg0K
c3VkbyBod3N0YW1wX2N0bCAtaSBldGgyIC10IDEgLXIgNiAmJiBzdWRvIHBoYzJzeXMgLXMg
Q0xPQ0tfUkVBTFRJTUUgLWMgZXRoMiAtbSAtbDYgLS1zdGVwX3RocmVzaG9sZD0wLjAwMSAt
TzANCg0KT2JzZXJ2ZSB0aGUgbG9nLCBhbmQgYWZ0ZXIgc29tZSB0aW1lLCB5b3Ugc2hvdWxk
IG9ic2VydmU6DQoNCnBoYzJzeXNbMzQxLjAxMV06IGVuczUgc3lzIG9mZnNldCAgICAgICAg
OTcgczIgZnJlcSAgLTM5MTQyIGRlbGF5ICAxNTY2NA0KcGhjMnN5c1szNDIuMDI1XTogZW5z
NSBzeXMgb2Zmc2V0ICAgICAgICA3NyBzMiBmcmVxICAtMzkxMzMgZGVsYXkgIDE1ODEwDQpw
aGMyc3lzWzM0My4wMzldOiBlbnM1IHN5cyBvZmZzZXQgICAgICAgMTI3IHMyIGZyZXEgIC0z
OTA2MCBkZWxheSAgMTU2NTcNCnBoYzJzeXNbMzQ0LjA0MF06IGNsb2NrY2hlY2s6IGNsb2Nr
IGp1bXBlZCBmb3J3YXJkIG9yIHJ1bm5pbmcgZmFzdGVyIHRoYW4gZXhwZWN0ZWQhDQpwaGMy
c3lzWzM0NC4wNDBdOiBlbnM1IHN5cyBvZmZzZXQgNDI5NDk2NzM5OCBzMCBmcmVxICAtMzkw
NjAgZGVsYXkgIDE1NjQ3DQpwaGMyc3lzWzM0NS4wNTRdOiBlbnM1IHN5cyBvZmZzZXQgNDI5
NDk2NzQxOSBzMSBmcmVxICAtMzkxMjggZGVsYXkgIDE1NjM4DQpwaGMyc3lzWzM0Ni4wNTRd
OiBjbG9ja2NoZWNrOiBjbG9jayBqdW1wZWQgYmFja3dhcmQgb3IgcnVubmluZyBzbG93ZXIg
dGhhbiBleHBlY3RlZCENCnBoYzJzeXNbMzQ2LjA1NV06IGVuczUgc3lzIG9mZnNldCAtNDI5
NDk2NzE4MSBzMCBmcmVxICAtMzkxMjggZGVsYXkgIDE1NTc2DQpwaGMyc3lzWzM0Ny4wNjld
OiBlbnM1IHN5cyBvZmZzZXQgLTQyOTQ5NjcwNzkgczEgZnJlcSAgLTM5MDI2IGRlbGF5ICAx
NTYzOQ0KcGhjMnN5c1szNDguMDgzXTogZW5zNSBzeXMgb2Zmc2V0ICAgICAgICA1NCBzMiBm
cmVxICAtMzg5NzIgZGVsYXkgIDE1NjQxDQpwaGMyc3lzWzM0OS4wOTddOiBlbnM1IHN5cyBv
ZmZzZXQgICAgICAgIDgyIHMyIGZyZXEgIC0zODkyOCBkZWxheSAgMTU2ODANCnBoYzJzeXNb
MzUwLjExMV06IGVuczUgc3lzIG9mZnNldCAgICAgICAgOTkgczIgZnJlcSAgLTM4ODg2IGRl
bGF5ICAxNTYyNQ0KcGhjMnN5c1szNTEuMTI1XTogZW5zNSBzeXMgb2Zmc2V0ICAgICAgICA4
NCBzMiBmcmVxICAtMzg4NzEgZGVsYXkgIDE1NjY0DQoNCkl0J3MgYWx3YXlzIHRoaXMgcGFp
ciBvZiBmb3J3YXJkIGp1bXAgYW5kIGJhY2t3YXJkIGp1bXAgc2VwYXJhdGVkIGJ5IGEgZmV3
IHNlY29uZHMuDQpJbnNwZWN0aW5nIHRoZSBiZWhhdmlvciBvZiBwaGMyc3lzLCBJIGZvdW5k
IG91dCB0aGF0IHRoZSB0aW1lc3RhbXBzIHN0YXJ0IHRvIGJlIHdyb25nDQozIHNlY29uZHMg
ZWFybGllciB0aGFuIGNsb2NrY2hlY2sgcmVwb3J0cyB0aGUganVtcC4gcGhjMnN5cyB1c2Vz
IGNsb2NrX2dldHRpbWUoKSB0byByZWFkIHRoZSBzdGFtcHMuDQoNCkRpZ2dpbmcgZGVlcGVy
LCBJIGZvdW5kIHRoYXQgZXZlbiB0aGUgbG93ZXN0LWxldmVsIHJlYWQgYnkgYGdldF9wdHBf
dHNfdmFsX3U2NChzZWxmLCAwKWANCmNhbGxlZCBmcm9tIGh3X2F0bF9iMF9nZXRfcHRwX3Rz
IGlzIHdyb25nICh0aGlzIHZhbHVlIGlzIHRoZSBMU1cgb2YgdGhlIHRpbWVzdGFtcCBzZWNz
IHBhcnQpLg0KDQpIZXJlJ3MgYSBwYXJ0IG9mIG15IGluc3RydW1lbnRlZCBod19hdGxfYjAu
YyBsb2cgbG9nZ2luZyB0aGUgZG91YmxlIHZhbHVlIG9mIG5zL05TRUNfUEVSX1NFQyBjb21w
dXRlZCBpbiBod19hdGxfYjBfZ2V0X3B0cF90cygpLg0KSXQgYWxzbyBsb2dzIGNhbGxzIG9m
IGh3X2F0bF9iMF9hZGpfY2xvY2tfZnJlcSgpIGFuZCBwcmludHMgdGhlIGNvbnRlbnRzIG9m
IHRoZSBmd3JlcSBzZW50IHRvIHRoZSBjaGlwLg0KRmluYWxseSwgaXQgbG9ncyBjYWxscyBv
ZiBod19hdGxfYjBfYWRqX3N5c19jbG9jaygpIHRoYXQgaGFwcGVuIHdoZW4gcGhjMnN5cyBq
dW1wcyB0aGUgY2xvY2suDQoNCk5vdGljZSB0aGUgc2VxdWVuY2Ugb2YgaW5jcmVhc2luZyB0
aW1lc3RhbXBzIGFuZCB0aGUganVtcHMgMjExLT4yMTYgYW5kIDIxOS0+MjE2IC4gVGhlc2Ug
anVtcHMgaGFwcGVuIGJlZm9yZQ0KcGhjMnN5cyBkb2VzIHRoZSBjbG9jayBqdW1waW5nICh0
aGF0IGlzIG9ubHkgYSBjb25zZXF1ZW5jZSkuDQoNCg0KWzI1ODkzLjA3ODI4M10gZ2V0X3B0
cF90cyAyMDkuOTM1NTYwODAzDQpbMjU4OTMuMDc4NjI5XSBnZXRfcHRwX3RzIDIwOS45MzU5
NDg3MTcNClsyNTg5My4wNzg4OTFdIGdldF9wdHBfdHMgMjA5LjkzNjIyNjk0Nw0KWzI1ODkz
LjA3OTE4MV0gZ2V0X3B0cF90cyAyMDkuOTM2NTE1Mzg1DQpbMjU4OTMuMDc5NDM3XSBnZXRf
cHRwX3RzIDIwOS45MzY3NzI0NTYNClsyNTg5My4wNzk5MDhdIGdldF9wdHBfdHMgMjA5Ljkz
NzA0Mjg4NA0KWzI1ODkzLjA4MDk4OV0gZ2V0X3B0cF90cyAyMDkuOTM4MTAxODgyDQpbMjU4
OTMuMDkwNjcwXSBnZXRfcHRwX3RzIDIwOS45NDQxNTE2MDcNClsyNTg5My4xMDQ5MjVdIGdl
dF9wdHBfdHMgMjA5Ljk1NzcxNTI1Nw0KWzI1ODkzLjExOTM3Ml0gZ2V0X3B0cF90cyAyMDku
OTcxODk2NTExDQpbMjU4OTMuMTM5NTA5XSBhZGpfY2xvY2tfZnJlcSA4ODYxIE1BQyAzLjIw
MDAyODM1NSBQSFkgNi4yNTAwNTUzODAgQURKIDMuMjMyMDI4MzU0DQpbMjU4OTQuMTU5NTc2
XSBnZXRfcHRwX3RzIDIxMS4wMTY5MDgzNTkNClsyNTg5NC4xNTk4OTVdIGdldF9wdHBfdHMg
MjExLjAxNzI3MTA3Ng0KWzI1ODk0LjE2MDE4MF0gZ2V0X3B0cF90cyAyMTEuMDE3NTYzNzk1
DQpbMjU4OTQuMTYwNDQ5XSBnZXRfcHRwX3RzIDIxMS4wMTc4MzMxNTUNClsyNTg5NC4xNjA3
MjJdIGdldF9wdHBfdHMgMjExLjAxODEwNTk0NA0KWzI1ODk0LjE2MTc1NV0gZ2V0X3B0cF90
cyAyMTEuMDE5MTMxNjI0DQpbMjU4OTQuMTYyMDY1XSBnZXRfcHRwX3RzIDIxMS4wMTk0MTQy
NTcNClsyNTg5NC4xNzA1NjVdIGdldF9wdHBfdHMgMjExLjAyMzQyOTg3Ng0KWzI1ODk0LjE4
NDQ4Nl0gZ2V0X3B0cF90cyAyMTEuMDM3NjMyMzk2DQpbMjU4OTQuMTk4NDczXSBnZXRfcHRw
X3RzIDIxMS4wNTEzOTQyMjANClsyNTg5NC4yMTg1NTddIGFkal9jbG9ja19mcmVxIDg2OTIg
TUFDIDMuMjAwMDI3ODEzIFBIWSA2LjI1MDA1NDMyNCBBREogLTIuODA4MTMyNDY2DQpbMjU4
OTUuMjM4NTgxXSBnZXRfcHRwX3RzIDIxNi4zOTA5MTc0NDYNClsyNTg5NS4yMzg5MTldIGdl
dF9wdHBfdHMgMjE2LjM5MTI5NjMxMA0KWzI1ODk1LjIzOTIwNV0gZ2V0X3B0cF90cyAyMTYu
MzkxNjAzODIwDQpbMjU4OTUuMjM5NDc3XSBnZXRfcHRwX3RzIDIxNi4zOTE4NzY4MDgNClsy
NTg5NS4yMzk3MzNdIGdldF9wdHBfdHMgMjE2LjM5MjEzNDc2Mg0KWzI1ODk1LjI0MDEyOV0g
Z2V0X3B0cF90cyAyMTYuMzkyNDIxOTAxDQpbMjU4OTUuMjQyMDg2XSBnZXRfcHRwX3RzIDIx
Ni4zOTQ0NTA5MDQNClsyNTg5NS4yNTAyNjVdIGdldF9wdHBfdHMgMjE2LjM5ODE4OTc5Nw0K
WzI1ODk1LjI2NDE4NF0gZ2V0X3B0cF90cyAyMTYuNDEyMTkzNTY3DQpbMjU4OTUuMjc4NjE0
XSBnZXRfcHRwX3RzIDIxNi40MjY0NzQ5OTcNClsyNTg5Ni4yODgzMjVdIGdldF9wdHBfdHMg
MjE3LjQ0MDcxNjc2Ng0KWzI1ODk2LjI5MDQ0M10gZ2V0X3B0cF90cyAyMTcuNDQyODUxMTE0
DQpbMjU4OTYuMjkwNzQyXSBnZXRfcHRwX3RzIDIxNy40NDMxODY5NjMNClsyNTg5Ni4yOTEw
MTddIGdldF9wdHBfdHMgMjE3LjQ0MzQ2NjYyMA0KWzI1ODk2LjI5MTI3NV0gZ2V0X3B0cF90
cyAyMTcuNDQzNzIzNzM2DQpbMjU4OTYuMjkxNTcyXSBnZXRfcHRwX3RzIDIxNy40NDQwMjI0
MjcNClsyNTg5Ni4yOTE5NzRdIGdldF9wdHBfdHMgMjE3LjQ0NDI5MTYzOA0KWzI1ODk2LjMw
MDAxOF0gZ2V0X3B0cF90cyAyMTcuNDQ4OTYwMDMxDQpbMjU4OTYuMzEzOTMwXSBnZXRfcHRw
X3RzIDIxNy40NjE5ODY4NTgNClsyNTg5Ni4zMjgxMDBdIGdldF9wdHBfdHMgMjE3LjQ3NjI4
NDEwOQ0KWzI1ODk3LjMzODI2MF0gZ2V0X3B0cF90cyAyMTguNDkwNzAyMTgwDQpbMjU4OTcu
MzM4NTc0XSBnZXRfcHRwX3RzIDIxOC40OTEwNjg5OTMNClsyNTg5Ny4zMzg4NTddIGdldF9w
dHBfdHMgMjE4LjQ5MTM1NDY5MQ0KWzI1ODk3LjMzOTE0N10gZ2V0X3B0cF90cyAyMTguNDkx
NjI1ODM2DQpbMjU4OTcuMzM5NDAzXSBnZXRfcHRwX3RzIDIxOC40OTE5MDEwNDUNClsyNTg5
Ny4zMzk4MTddIGdldF9wdHBfdHMgMjE4LjQ5MjE2OTM4MA0KWzI1ODk3LjM0MTQzM10gZ2V0
X3B0cF90cyAyMTguNDkzOTA5Nzc5DQpbMjU4OTcuMzQ5ODYxXSBnZXRfcHRwX3RzIDIxOC40
OTc2MDA2NzINClsyNTg5Ny4zNjM3ODVdIGdldF9wdHBfdHMgMjE4LjUxMTk5NjQ3Nw0KWzI1
ODk3LjM3Nzk1MF0gZ2V0X3B0cF90cyAyMTguNTI1ODkxNTc0DQpbMjU4OTguMzg3ODE2XSBn
ZXRfcHRwX3RzIDIxOS41NDAzMDQ1MjUNClsyNTg5OC4zODgxMzBdIGdldF9wdHBfdHMgMjE5
LjU0MDY3NTA3Ng0KWzI1ODk4LjM4ODQyOV0gZ2V0X3B0cF90cyAyMTkuNTQwOTYwNjk3DQpb
MjU4OTguMzg5NjE4XSBnZXRfcHRwX3RzIDIxOS41NDIxMzg3MzANClsyNTg5OC4zODk4ODhd
IGdldF9wdHBfdHMgMjE5LjU0MjQyNDY0MA0KWzI1ODk4LjM5MDE3MF0gZ2V0X3B0cF90cyAy
MTkuNTQyNzA3NTI5DQpbMjU4OTguMzkwNDYwXSBnZXRfcHRwX3RzIDIxOS41NDI5OTI2MjUN
ClsyNTg5OC4zOTk0MjRdIGdldF9wdHBfdHMgMjE5LjU0NzY0NzU1Mg0KWzI1ODk4LjQxMzU5
NV0gZ2V0X3B0cF90cyAyMTkuNTYxNjQ2Nzg0DQpbMjU4OTguNDI3NzY5XSBnZXRfcHRwX3Rz
IDIxOS41NzU4MDM1MzUNClsyNTg5OC40MzczNDJdIFthcV9wdHBfYWRqdGltZTo0MzIoZXRo
MildQVEgUFRQIEFkaiBUaW1lIDB4ZmZmZmZmZmYwMDAwMDg5Nw0KWzI1ODk4LjQ0NDIwNV0g
YWRqX3N5c19jbG9jayBkZWx0YSAtNDI5NDk2NTA5NyBvbGQgb2ZmIDE3MjE0MzExOTkwOTI1
OTc3NDYgbmV3IG9mZiAxNzIxNDMxMTk0Nzk3NjMyNjQ5DQpbMjU4OTguNDY4MTAyXSBhZGpf
Y2xvY2tfZnJlcSA3NzYyIE1BQyAzLjIwMDAyNDgzNyBQSFkgNi4yNTAwNDg1MTEgQURKIDcu
MTM2MDI0ODM3DQpbMjU4OTkuNDg4NTI4XSBnZXRfcHRwX3RzIDIxNi4zNDYxMDM2MDANClsy
NTg5OS40ODk0NjNdIGdldF9wdHBfdHMgMjE2LjM0NzA1OTkwOA0KWzI1ODk5LjQ4OTcyNV0g
Z2V0X3B0cF90cyAyMTYuMzQ3MzUwMjU5DQpbMjU4OTkuNDkwMDAxXSBnZXRfcHRwX3RzIDIx
Ni4zNDc2MjgzODYNClsyNTg5OS40OTAyOTBdIGdldF9wdHBfdHMgMjE2LjM0NzkxOTA4Mw0K
WzI1ODk5LjQ5MDU3NV0gZ2V0X3B0cF90cyAyMTYuMzQ4MjAzODUzDQpbMjU4OTkuNDkxMDUy
XSBnZXRfcHRwX3RzIDIxNi4zNDg0NTk3NzINClsyNTg5OS40OTk4NzJdIGdldF9wdHBfdHMg
MjE2LjM1MzEyNzM3Mw0KWzI1ODk5LjUxMzk1NV0gZ2V0X3B0cF90cyAyMTYuMzY3MDQ3NTI2
DQpbMjU4OTkuNTI4Mzk0XSBnZXRfcHRwX3RzIDIxNi4zODE0ODQ0NDQNClsyNTkwMC41Mzgy
MzVdIGdldF9wdHBfdHMgMjE3LjM5NTg1NDU5Ng0KWzI1OTAwLjUzODU1MV0gZ2V0X3B0cF90
cyAyMTcuMzk2MjIwMTY3DQpbMjU5MDAuNTM4ODUxXSBnZXRfcHRwX3RzIDIxNy4zOTY1MjQ2
ODgNClsyNTkwMC41MzkxMjZdIGdldF9wdHBfdHMgMjE3LjM5Njc5OTE5Mg0KWzI1OTAwLjUz
OTM4MF0gZ2V0X3B0cF90cyAyMTcuMzk3MDU3NDIxDQpbMjU5MDAuNTM5ODA2XSBnZXRfcHRw
X3RzIDIxNy4zOTczMjQ4NjcNClsyNTkwMC41NDIxNjJdIGdldF9wdHBfdHMgMjE3LjM5OTgw
NjYwOA0KWzI1OTAwLjU0OTY3MF0gZ2V0X3B0cF90cyAyMTcuNDAyODIwMTAzDQpbMjU5MDAu
NTY0MDk5XSBnZXRfcHRwX3RzIDIxNy40MTcyMjg5NDQNClsyNTkwMC41NzgwMTBdIGdldF9w
dHBfdHMgMjE3LjQzMTQyODk3OA0KWzI1OTAxLjU4NzkwOF0gZ2V0X3B0cF90cyAyMTguNDQ1
NTgzMzcxDQpbMjU5MDEuNTg4MjQ0XSBnZXRfcHRwX3RzIDIxOC40NDU5NTgyNDgNClsyNTkw
MS41ODg4MjJdIGdldF9wdHBfdHMgMjE4LjQ0NjU0MDgxMg0KWzI1OTAxLjU4OTExNV0gZ2V0
X3B0cF90cyAyMTguNDQ2ODIwODU5DQpbMjU5MDEuNTg5Mzc0XSBnZXRfcHRwX3RzIDIxOC40
NDcwOTYwMjMNClsyNTkwMS41ODk2NTFdIGdldF9wdHBfdHMgMjE4LjQ0NzM3Mjc2Nw0KWzI1
OTAxLjU5MDQ5Ml0gZ2V0X3B0cF90cyAyMTguNDQ4MDE0MTEwDQpbMjU5MDEuNTk5NTE1XSBn
ZXRfcHRwX3RzIDIxOC40NTI2NzYyNTINClsyNTkwMS42MTM0MzNdIGdldF9wdHBfdHMgMjE4
LjQ2NzAwOTU5OA0KWzI1OTAxLjYyNzMzN10gZ2V0X3B0cF90cyAyMTguNDgwNTg1OTIxDQpb
MjU5MDIuNjM3NDc0XSBnZXRfcHRwX3RzIDIxOS40OTUyMTEyNzUNClsyNTkwMi42Mzc3ODZd
IGdldF9wdHBfdHMgMjE5LjQ5NTU1MzE5MQ0KWzI1OTAyLjYzODA2Nl0gZ2V0X3B0cF90cyAy
MTkuNDk1ODM0OTkyDQpbMjU5MDIuNjM4MzM0XSBnZXRfcHRwX3RzIDIxOS40OTYxMDQ1NjgN
ClsyNTkwMi42Mzg2MDFdIGdldF9wdHBfdHMgMjE5LjQ5NjM3MzEyMQ0KWzI1OTAyLjYzOTA1
M10gZ2V0X3B0cF90cyAyMTkuNDk2NjQwOTUwDQpbMjU5MDIuNjQwMTA3XSBnZXRfcHRwX3Rz
IDIxOS40OTc2NDUxNzUNClsyNTkwMi42NDg5MTZdIGdldF9wdHBfdHMgMjE5LjUwMzE5NjAy
OA0KWzI1OTAyLjY2MzM0OF0gZ2V0X3B0cF90cyAyMTkuNTE2NjUyNTc0DQpbMjU5MDIuNjc3
NTIxXSBnZXRfcHRwX3RzIDIxOS41MzA3OTA2NjENClsyNTkwMi42ODcyMTFdIFthcV9wdHBf
YWRqdGltZTo0MzIoZXRoMildQVEgUFRQIEFkaiBUaW1lIDB4ZmZmZmYzMDkNClsyNTkwMi42
OTI5NThdIGFkal9zeXNfY2xvY2sgZGVsdGEgNDI5NDk2Mzk3NyBvbGQgb2ZmIDE3MjE0MzEx
OTQ3OTc2MzI2NDkgbmV3IG9mZiAxNzIxNDMxMTk5MDkyNTk2NjI2DQpbMjU5MDIuNzE3MzQ3
XSBhZGpfY2xvY2tfZnJlcSA4NzcxIE1BQyAzLjIwMDAyODA2NiBQSFkgNi4yNTAwNTQ4MTcg
QURKIDAuMTY4MDI4MDY3DQpbMjU5MDMuNzM3MDUyXSBnZXRfcHRwX3RzIDIyMC41OTQ4MjQz
NTINClsyNTkwMy43MzczNTJdIGdldF9wdHBfdHMgMjIwLjU5NTE2Nzc2MA0KWzI1OTAzLjcz
NzYyOV0gZ2V0X3B0cF90cyAyMjAuNTk1NDQ2NjQ5DQpbMjU5MDMuNzM3OTA3XSBnZXRfcHRw
X3RzIDIyMC41OTU3MjQwODUNClsyNTkwMy43MzgxNjZdIGdldF9wdHBfdHMgMjIwLjU5NTk4
NDI0MQ0KWzI1OTAzLjczODYyNV0gZ2V0X3B0cF90cyAyMjAuNTk2MjU0NjI0DQpbMjU5MDMu
NzM5NjgzXSBnZXRfcHRwX3RzIDIyMC41OTcyODI5OTgNClsyNTkwMy43NDg3NDFdIGdldF9w
dHBfdHMgMjIwLjYwMjI4NjE1Mg0KWzI1OTAzLjc2MjkxNl0gZ2V0X3B0cF90cyAyMjAuNjE2
MjA3NzkxDQpbMjU5MDMuNzc3MDAzXSBnZXRfcHRwX3RzIDIyMC42MzAwNDg4NzkNClsyNTkw
My43OTY3MTddIGFkal9jbG9ja19mcmVxIDEwMDQzIE1BQyAzLjIwMDAzMjEzNiBQSFkgNi4y
NTAwNjI3NjcgQURKIDguMTI4MDMyMTM2DQpbMjU5MDQuODE2OTg2XSBnZXRfcHRwX3RzIDIy
MS42NzQ3OTMyNjcNClsyNTkwNC44MTczMDVdIGdldF9wdHBfdHMgMjIxLjY3NTE2OTQxMQ0K
WzI1OTA0LjgxNzU2Nl0gZ2V0X3B0cF90cyAyMjEuNjc1NDM2MzU4DQpbMjU5MDQuODE3ODQ1
XSBnZXRfcHRwX3RzIDIyMS42NzU3MTE3NjUNClsyNTkwNC44MTgxMThdIGdldF9wdHBfdHMg
MjIxLjY3NTk3NjU2OA0KWzI1OTA0LjgxODYzNF0gZ2V0X3B0cF90cyAyMjEuNjc2MzIyODYz
DQoNClJ1bm5pbmcgdGhlIGByZWFkbG9nYCB0b29sIGZyb20gTWFydmVsbCBkaWFnIHBhY2th
Z2UsIHRoZXJlIGlzIGFsc28gbm90aGluZyBzdXNwaWN1b3VzIGluIHRoZSBpbnRlcm5hbCBj
YXJkIGxvZw0KKGV4Y2VwdCB0aGUgYHNpZ25gIGZpZWxkIGluIGFkanVzdE1hY0Nsb2NrIHdo
aWNoIGlzIGFsd2F5cyArIGV2ZW4gdGhvdWdoIHRoZSBkcml2ZXIgc2VuZHMgb25lICsgYW5k
IG9uZSAtKS4NCg0K77+9UFRQIEFkaiBGcmVxOiAzLCAzMzM1NDg4MywgNiwgNDAwNDExYTUs
IDAsIGZiZjA1ZGE0Ow0K77+9UFRQIEFkaiBGcmVxOiAzLCAzMzM1NDI4MiwgNiwgNDAwNDA1
ZTcsIDUsIDcwYTVlNjU5Ow0K77+9UFRQIEFkaiBGcmVxOiAzLCAzMzM1NDFiMywgNiwgNDAw
NDA0NTMsIDYsIGM0YmM4ZGU7DQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzU0OTg5LCA2LCA0
MDA0MTNhNCwgZmZmZmZmZmYsIDgzMWI2MGI2Ow0K77+9UFRQIEFkaiBGcmVxOiAzLCAzMzM1
M2U5NSwgNiwgNDAwM2ZlNDAsIDAsIGFhMDRjZTk3Ow0K77+9UFRQIEFkaiBGcmVxOiAzLCAz
MzM1M2QzZCwgNiwgNDAwM2ZiYTIsIDMsIDgxMGYwYWFmOw0K77+9UFRQIEFkaiBGcmVxOiAz
LCAzMzM1M2FiOSwgNiwgNDAwM2Y2YjMsIDYsIDlmYzA3ZTRlOw0K77+9UFRQIEFkaiBGcmVx
OiAzLCAzMzM1M2QxNiwgNiwgNDAwM2ZiNTEsIDcsIDVjMmFmZmE1Ow0K77+9UFRQIEFkaiBG
cmVxOiAzLCAzMzM1NGU0NCwgNiwgNDAwNDFjZGYsIDcsIGFlMTY5NWYyOw0K77+9UFRQIEFk
aiBGcmVxOiAzLCAzMzM1NDQ4ZSwgNiwgNDAwNDA5ZTUsIDIsIDdlZmJlYzdlOw0K77+9UFRQ
IEFkaiBGcmVxOiAzLCAzMzM1NWEzYiwgNiwgNDAwNDM0NDIsIDMsIDRmZTgzZTM0Ow0K77+9
UFRQIEFkaiBGcmVxOiAzLCAzMzM1NGJmNCwgNiwgNDAwNDE4NWIsIDgsIDMxMjkwMjM5Ow0K
77+9UFRQIEFkaiBGcmVxOiAzLCAzMzM1NDFmOCwgNiwgNDAwNDA0ZGQsIGZmZmZmZmZmLCBl
ZDlhNTMwMDsNCu+/vTE0MjkzNiBhZGp1c3RNYWNDbG9jayBzaWduPSsgYWRqPTI5NDk2NzI5
NSBmcmFjPWVkOWE1MzAwDQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzUzN2ZkLCA2LCA0MDAz
ZjE1OSwgMCwgZGQzMTFmNmE7DQrvv70xNDMxNTAgYWRqdXN0TWFjQ2xvY2sgc2lnbj0rIGFk
aj0yOTQ5NjcyNDcgZnJhYz0wDQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzU2NDEwLCA2LCA0
MDA0NDc2ZiwgMiwgYjAyMmY1Nzk7DQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzc3NmZhLCA2
LCA0MDA4NTQ2MiwgNiwgYjg1NjJmNGI7DQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzY3ZDhj
LCA2LCA0MDA2NmQzNSwgMiwgNGRkNjNjMDM7DQrvv71QVFAgQWRqIEZyZXE6IDMsIDMzMzU2
MjJmLCA2LCA0MDA0NDNjNywgOSwgYzI5MThiMjQ7DQoNCldoZW4gSSBwb2tlZCBpbnRvIHZh
cmlvdXMgcGFydHMgb2YgdGhlIGNvZGUsIEkgZm91bmQgdGhlIGZvbGxvd2luZyBvYnNlcnZh
dGlvbnMgaW50ZXJlc3Rpbmc6DQoNCjEpIFdoZW4gUFRQIGlzIG5vdCBlbmFibGVkIChha2Eg
YGh3c3RhbXBfY3RsIC10IDAgLXIgMGApLCB0aGUgaXNzdWUgZG9lcyBub3QgaGFwcGVuLg0K
MikgV2hlbiBJIGZvcmJpZCBwaGMyc3lzIHRvIGNhbGwgY2xvY2tfYWRqdGltZSB3aXRoIEFE
Sl9GUkVRVUVOQ1ksIHRoZSBpc3N1ZSBkb2VzIG5vdCBoYXBwZW4gKGJ1dCB0aGUgY2xvY2sg
ZG9lc24ndCBzeW5jKS4NCjMpIFRoZSBiZXN0IHdvcmthcm91bmQgSSBmb3VuZCB0aGF0IGFs
bG93cyBtZSB0byBhY3R1YWxseSBzeW5jIHRoZSBQSEMgYW5kIHVzZSBpdCBmb3IgUFRQIGlz
IGVkaXRpbmcNCiAgICBod19hdGxfYjBfYWRqX2Nsb2NrX2ZyZXEoKSB0byB6ZXJvLW91dCBt
YWNfbnNfYWRqIGFuZCBtYWNfZm5zX2FkaiBmaWVsZHMgb2YgdGhlIGZ3cmVxIGJlZm9yZSBz
ZW5kaW5nDQogICAgaXQgdG8gdGhlIEZXLg0KMy4xKSBJIGRvbid0IGV2ZW4gbmVlZCB0byB6
ZXJvLW91dCB0aGUgdmFsdWVzLiBJdCBpcyBlbm91Z2ggdG8gemVyby1vdXQgYWxsIG5lZ2F0
aXZlIHZhbHVlcyBvZiB0aGUgYWRqdXN0bWVudC4NCjQpIFRoZSBpc3N1ZSBpcyBub3QgaW5m
bHVlbmNlZCBieSB0aGUgYW1vdW50IG9mIGRhdGEgZmxvd2luZyB0aHJvdWdoIHRoZSBOSUMu
DQo1KSBJdCBoYXBwZW5zIGJvdGggd2hlbiBJIHVzZSB0aGUgTklDIGFzIHB0cDRsIG1hc3Rl
ciBhbmQgd2hlbiBwdHA0bCBkb2Vzbid0IHVzZSB0aGUgY2FyZA0KICAgIChidXQgUFRQIGhh
cyB0byBiZSBlbmFibGVkIGJ5IHRoZSBod3N0YW1wX2N0bCBjYWxsKS4NCg0KQnV0IGhlcmUg
SSdtIHN0dWNrIGFuZCBJIGNhbid0IG1vdmUgZm9yd2FyZCB1bmRlcnN0YW5kaW5nIHdoYXQg
YXJlIHRoZSB1bmludGVuZGVkIGNvbnNlcXVlbmNlcyBvZiB0aGUNCndvcmthcm91bmRzIGZy
b20gcG9pbnRzIDMgb3IgMy4xLiBFdmVuIGhhdmluZyBhbiBOREEgd2l0aCBNYXJ2ZWxsIGFu
ZCBhY2Nlc3MgdG8gdGhlIEFRQzEwNyBjb2xsYXRlcmFscyBkb2Vzbid0IHByb3ZpZGUgYSBz
aW5nbGUNCmRvY3VtZW50IHRoYXQgd291bGQgZGVzY3JpYmUgdGhlIHJlZ2lzdGVycyBvZiB0
aGUgY2hpcCBvciBBUEkgb2YgdGhlIGZpcm13YXJlLiBTbyBJIGNhbiBqdXN0IGd1ZXNzLCBh
bmQgSQ0KcmVhbGx5IGRvbid0IGtub3cgd2hhdCB0aGlzIGFkanVzdG1lbnQgZmllbGQgc2hv
dWxkIGJlIGRvaW5nLiBod19hdGxfYjBfbWFjX2Fkal9wYXJhbV9jYWxjKCkgaGFzIGEgbm90
ZSBzYXlpbmcNCiJNQUMgTUNQIGNvdW50ZXIgZnJlcSBpcyBtYWNmcmVxIC8gNCIsIHRoZW4g
dGhlcmUgaXMgYSBzNjQgdmFyaWFibGUgY2FsbGVkIGRpZmZfaW5fbWNwX292ZXJmbG93IHdo
b3NlIHZhbHVlIGlzDQpzbGlnaHRseSBwcm9jZXNzZWQgYW5kIGNvbnZlcnRlZCB0byB1MzIg
KHNvIHRoZSBvdmVyZmxvdyBpcyBwcm9iYWJseSBpbnRlbmRlZD8pLiBObyBpZGVhIHdoYXQn
cyBNQ1AgY291bnRlcg0KYW5kIGhvdyBkb2VzIHRoZSBhZGp1c3RtZW50IGZpZWxkIGFkanVz
dCBpdC4NCg0KSSd2ZSBwbG90dGVkIHRoZSB2YWx1ZXMgb2YgdGhlIGFkanVzdG1lbnQgZmll
bGQgZm9yIHBwYiB2YWx1ZXMgZnJvbSAtMTAwMDAgdG8gMTAwMDAsIHdoaWNoIGFyZSB0aGUg
dmFsdWVzDQpJIHNlZSBwaGMyc3lzIHVzdWFsbHkgdXNlcyAoYWN0dWFsbHksIGl0IGlzIG1v
cmUgbGlrZSA4MDAwIC0gMTAwMDApLiBUaGUgdmFsdWVzIG9mIHRoaXMgYWRqdXN0bWVudCBv
c2NpbGxhdGUNCmJldHdlZW4gLTUgYW5kIDIwLiBBbmQgYXMgSSBzYWlkIGluIG9ic2VydmF0
aW9uIDMuMSwgd2hlbiBJIGNsYW1wIHRoZW0gdG8gMC0yMCwgdGhlIHByb2JsZW0gZGlzYXBw
ZWFycywNClBIQyBzeW5jIHJ1bnMgYW5kIEkgY2FuIHVzZSB0aGUgTklDIGFzIGEgUFRQIG1h
c3Rlci4NCg0KVGhhbmtzIGZvciBhbnkgaGludHMgd2hlcmUgdG8gZ28gbmV4dCwNCk1hcnRp
bg0KDQpNZ3IuIE1hcnRpbiBQZWNrYSwgUGguRC4NClJlc2VhcmNoZXIgYXQgVmlzaW9uIGZv
ciBSb2JvdGljcyBhbmQgQXV0b25vbW91cyBTeXN0ZW1zIGdyb3VwDQpGYWN1bHR5IG9mIEVs
ZWN0cmljYWwgRW5naW5lZXJpbmcNCkN6ZWNoIFRlY2huaWNhbCBVbml2ZXJzaXR5IGluIFBy
YWd1ZQ0KDQo=
--------------J6yDtaD88XUPB05b00i7MTuu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <pre>Hello atlantic driver maintainers. This is my first kernel bugre=
port, so please try to be patient :)
However, I've spent full 3 working days (and nights) debugging this issue=
, so I hope we'll find
a way to fix it properly. So far, I've come with a workaround, but I'm no=
t sure about its side-effects.

Summary: PHC time jumps ~4 seconds there and back on AQC107

I'm testing on multiple copper-PHY NICs with AQC107 and the problem is al=
ways the same:
- QNAP QXG-10G2TB, PCIe, FW 3.1.121
- Sanlink3 N1, Thunderbolt, FW 3.1.121
- OWC OWCTB3ADP10GBE, Thunderbolt, FW 3.1.106 (it cannot run 3.1.121)
- Sonnettech Solo10G 10GBASE-T, Thunderbolt, FW 3.1.121

I run the tests on multiple PCs with different CPU archs and the problem =
is always the same:
- Intel NUC (Thunderbolt, x86-64, kernel 6.8, upstream atlantic driver)
- NVidia Jetson (PCIe, aarch64, kernel 4.9.337 + out-of-tree driver <a cl=
ass=3D"moz-txt-link-freetext" href=3D"https://github.com/Aquantia/AQtion"=
>https://github.com/Aquantia/AQtion</a> ).

When I enable PTP on the card (e.g. `hwstamp_ctl -i eth2 -t 1`) and run p=
hc2sys from linuxptp
to sync the card's PHC to another clock (AQ107 is time sink), I get time =
jumps of the PHC clock
of ~4 secs in the future and then back (after ~5 secs). These jumps happe=
n in random intervals
and I haven't found a pattern. Usually, it happens every 20-100 secs, but=
 there have been even
much longer intervals. These time jumps are corrected by phc2sys quite qu=
ickly (within ~10 seconds),
but during this interval, the time is wrong.

An easy way to trigger this issue is to connect a cable to the port (say =
eth2) and run:

sudo hwstamp_ctl -i eth2 -t 1 -r 6 &amp;&amp; sudo phc2sys -s CLOCK_REALT=
IME -c eth2 -m -l6 --step_threshold=3D0.001 -O0

Observe the log, and after some time, you should observe:

phc2sys[341.011]: ens5 sys offset        97 s2 freq  -39142 delay  15664
phc2sys[342.025]: ens5 sys offset        77 s2 freq  -39133 delay  15810
phc2sys[343.039]: ens5 sys offset       127 s2 freq  -39060 delay  15657
phc2sys[344.040]: clockcheck: clock jumped forward or running faster than=
 expected!
phc2sys[344.040]: ens5 sys offset 4294967398 s0 freq  -39060 delay  15647=

phc2sys[345.054]: ens5 sys offset 4294967419 s1 freq  -39128 delay  15638=

phc2sys[346.054]: clockcheck: clock jumped backward or running slower tha=
n expected!
phc2sys[346.055]: ens5 sys offset -4294967181 s0 freq  -39128 delay  1557=
6
phc2sys[347.069]: ens5 sys offset -4294967079 s1 freq  -39026 delay  1563=
9
phc2sys[348.083]: ens5 sys offset        54 s2 freq  -38972 delay  15641
phc2sys[349.097]: ens5 sys offset        82 s2 freq  -38928 delay  15680
phc2sys[350.111]: ens5 sys offset        99 s2 freq  -38886 delay  15625
phc2sys[351.125]: ens5 sys offset        84 s2 freq  -38871 delay  15664

It's always this pair of forward jump and backward jump separated by a fe=
w seconds.
Inspecting the behavior of phc2sys, I found out that the timestamps start=
 to be wrong
3 seconds earlier than clockcheck reports the jump. phc2sys uses clock_ge=
ttime() to read the stamps.

Digging deeper, I found that even the lowest-level read by `get_ptp_ts_va=
l_u64(self, 0)`
called from hw_atl_b0_get_ptp_ts is wrong (this value is the LSW of the t=
imestamp secs part).

Here's a part of my instrumented hw_atl_b0.c log logging the double value=
 of ns/NSEC_PER_SEC computed in hw_atl_b0_get_ptp_ts().
It also logs calls of hw_atl_b0_adj_clock_freq() and prints the contents =
of the fwreq sent to the chip.
Finally, it logs calls of hw_atl_b0_adj_sys_clock() that happen when phc2=
sys jumps the clock.

Notice the sequence of increasing timestamps and the jumps 211-&gt;216 an=
d 219-&gt;216 . These jumps happen before
phc2sys does the clock jumping (that is only a consequence).


[25893.078283] get_ptp_ts 209.935560803
[25893.078629] get_ptp_ts 209.935948717
[25893.078891] get_ptp_ts 209.936226947
[25893.079181] get_ptp_ts 209.936515385
[25893.079437] get_ptp_ts 209.936772456
[25893.079908] get_ptp_ts 209.937042884
[25893.080989] get_ptp_ts 209.938101882
[25893.090670] get_ptp_ts 209.944151607
[25893.104925] get_ptp_ts 209.957715257
[25893.119372] get_ptp_ts 209.971896511
[25893.139509] adj_clock_freq 8861 MAC 3.200028355 PHY 6.250055380 ADJ 3.=
232028354
[25894.159576] get_ptp_ts 211.016908359
[25894.159895] get_ptp_ts 211.017271076
[25894.160180] get_ptp_ts 211.017563795
[25894.160449] get_ptp_ts 211.017833155
[25894.160722] get_ptp_ts 211.018105944
[25894.161755] get_ptp_ts 211.019131624
[25894.162065] get_ptp_ts 211.019414257
[25894.170565] get_ptp_ts 211.023429876
[25894.184486] get_ptp_ts 211.037632396
[25894.198473] get_ptp_ts 211.051394220
[25894.218557] adj_clock_freq 8692 MAC 3.200027813 PHY 6.250054324 ADJ -2=
=2E808132466
[25895.238581] get_ptp_ts 216.390917446
[25895.238919] get_ptp_ts 216.391296310
[25895.239205] get_ptp_ts 216.391603820
[25895.239477] get_ptp_ts 216.391876808
[25895.239733] get_ptp_ts 216.392134762
[25895.240129] get_ptp_ts 216.392421901
[25895.242086] get_ptp_ts 216.394450904
[25895.250265] get_ptp_ts 216.398189797
[25895.264184] get_ptp_ts 216.412193567
[25895.278614] get_ptp_ts 216.426474997
[25896.288325] get_ptp_ts 217.440716766
[25896.290443] get_ptp_ts 217.442851114
[25896.290742] get_ptp_ts 217.443186963
[25896.291017] get_ptp_ts 217.443466620
[25896.291275] get_ptp_ts 217.443723736
[25896.291572] get_ptp_ts 217.444022427
[25896.291974] get_ptp_ts 217.444291638
[25896.300018] get_ptp_ts 217.448960031
[25896.313930] get_ptp_ts 217.461986858
[25896.328100] get_ptp_ts 217.476284109
[25897.338260] get_ptp_ts 218.490702180
[25897.338574] get_ptp_ts 218.491068993
[25897.338857] get_ptp_ts 218.491354691
[25897.339147] get_ptp_ts 218.491625836
[25897.339403] get_ptp_ts 218.491901045
[25897.339817] get_ptp_ts 218.492169380
[25897.341433] get_ptp_ts 218.493909779
[25897.349861] get_ptp_ts 218.497600672
[25897.363785] get_ptp_ts 218.511996477
[25897.377950] get_ptp_ts 218.525891574
[25898.387816] get_ptp_ts 219.540304525
[25898.388130] get_ptp_ts 219.540675076
[25898.388429] get_ptp_ts 219.540960697
[25898.389618] get_ptp_ts 219.542138730
[25898.389888] get_ptp_ts 219.542424640
[25898.390170] get_ptp_ts 219.542707529
[25898.390460] get_ptp_ts 219.542992625
[25898.399424] get_ptp_ts 219.547647552
[25898.413595] get_ptp_ts 219.561646784
[25898.427769] get_ptp_ts 219.575803535
[25898.437342] [aq_ptp_adjtime:432(eth2)]AQ PTP Adj Time 0xffffffff000008=
97
[25898.444205] adj_sys_clock delta -4294965097 old off 172143119909259774=
6 new off 1721431194797632649
[25898.468102] adj_clock_freq 7762 MAC 3.200024837 PHY 6.250048511 ADJ 7.=
136024837
[25899.488528] get_ptp_ts 216.346103600
[25899.489463] get_ptp_ts 216.347059908
[25899.489725] get_ptp_ts 216.347350259
[25899.490001] get_ptp_ts 216.347628386
[25899.490290] get_ptp_ts 216.347919083
[25899.490575] get_ptp_ts 216.348203853
[25899.491052] get_ptp_ts 216.348459772
[25899.499872] get_ptp_ts 216.353127373
[25899.513955] get_ptp_ts 216.367047526
[25899.528394] get_ptp_ts 216.381484444
[25900.538235] get_ptp_ts 217.395854596
[25900.538551] get_ptp_ts 217.396220167
[25900.538851] get_ptp_ts 217.396524688
[25900.539126] get_ptp_ts 217.396799192
[25900.539380] get_ptp_ts 217.397057421
[25900.539806] get_ptp_ts 217.397324867
[25900.542162] get_ptp_ts 217.399806608
[25900.549670] get_ptp_ts 217.402820103
[25900.564099] get_ptp_ts 217.417228944
[25900.578010] get_ptp_ts 217.431428978
[25901.587908] get_ptp_ts 218.445583371
[25901.588244] get_ptp_ts 218.445958248
[25901.588822] get_ptp_ts 218.446540812
[25901.589115] get_ptp_ts 218.446820859
[25901.589374] get_ptp_ts 218.447096023
[25901.589651] get_ptp_ts 218.447372767
[25901.590492] get_ptp_ts 218.448014110
[25901.599515] get_ptp_ts 218.452676252
[25901.613433] get_ptp_ts 218.467009598
[25901.627337] get_ptp_ts 218.480585921
[25902.637474] get_ptp_ts 219.495211275
[25902.637786] get_ptp_ts 219.495553191
[25902.638066] get_ptp_ts 219.495834992
[25902.638334] get_ptp_ts 219.496104568
[25902.638601] get_ptp_ts 219.496373121
[25902.639053] get_ptp_ts 219.496640950
[25902.640107] get_ptp_ts 219.497645175
[25902.648916] get_ptp_ts 219.503196028
[25902.663348] get_ptp_ts 219.516652574
[25902.677521] get_ptp_ts 219.530790661
[25902.687211] [aq_ptp_adjtime:432(eth2)]AQ PTP Adj Time 0xfffff309
[25902.692958] adj_sys_clock delta 4294963977 old off 1721431194797632649=
 new off 1721431199092596626
[25902.717347] adj_clock_freq 8771 MAC 3.200028066 PHY 6.250054817 ADJ 0.=
168028067
[25903.737052] get_ptp_ts 220.594824352
[25903.737352] get_ptp_ts 220.595167760
[25903.737629] get_ptp_ts 220.595446649
[25903.737907] get_ptp_ts 220.595724085
[25903.738166] get_ptp_ts 220.595984241
[25903.738625] get_ptp_ts 220.596254624
[25903.739683] get_ptp_ts 220.597282998
[25903.748741] get_ptp_ts 220.602286152
[25903.762916] get_ptp_ts 220.616207791
[25903.777003] get_ptp_ts 220.630048879
[25903.796717] adj_clock_freq 10043 MAC 3.200032136 PHY 6.250062767 ADJ 8=
=2E128032136
[25904.816986] get_ptp_ts 221.674793267
[25904.817305] get_ptp_ts 221.675169411
[25904.817566] get_ptp_ts 221.675436358
[25904.817845] get_ptp_ts 221.675711765
[25904.818118] get_ptp_ts 221.675976568
[25904.818634] get_ptp_ts 221.676322863

Running the `readlog` tool from Marvell diag package, there is also nothi=
ng suspicuous in the internal card log
(except the `sign` field in adjustMacClock which is always + even though =
the driver sends one + and one -).

=EF=BF=BDPTP Adj Freq: 3, 33354883, 6, 400411a5, 0, fbf05da4;
=EF=BF=BDPTP Adj Freq: 3, 33354282, 6, 400405e7, 5, 70a5e659;
=EF=BF=BDPTP Adj Freq: 3, 333541b3, 6, 40040453, 6, c4bc8de;
=EF=BF=BDPTP Adj Freq: 3, 33354989, 6, 400413a4, ffffffff, 831b60b6;
=EF=BF=BDPTP Adj Freq: 3, 33353e95, 6, 4003fe40, 0, aa04ce97;
=EF=BF=BDPTP Adj Freq: 3, 33353d3d, 6, 4003fba2, 3, 810f0aaf;
=EF=BF=BDPTP Adj Freq: 3, 33353ab9, 6, 4003f6b3, 6, 9fc07e4e;
=EF=BF=BDPTP Adj Freq: 3, 33353d16, 6, 4003fb51, 7, 5c2affa5;
=EF=BF=BDPTP Adj Freq: 3, 33354e44, 6, 40041cdf, 7, ae1695f2;
=EF=BF=BDPTP Adj Freq: 3, 3335448e, 6, 400409e5, 2, 7efbec7e;
=EF=BF=BDPTP Adj Freq: 3, 33355a3b, 6, 40043442, 3, 4fe83e34;
=EF=BF=BDPTP Adj Freq: 3, 33354bf4, 6, 4004185b, 8, 31290239;
=EF=BF=BDPTP Adj Freq: 3, 333541f8, 6, 400404dd, ffffffff, ed9a5300;
=EF=BF=BD142936 adjustMacClock sign=3D+ adj=3D294967295 frac=3Ded9a5300
=EF=BF=BDPTP Adj Freq: 3, 333537fd, 6, 4003f159, 0, dd311f6a;
=EF=BF=BD143150 adjustMacClock sign=3D+ adj=3D294967247 frac=3D0
=EF=BF=BDPTP Adj Freq: 3, 33356410, 6, 4004476f, 2, b022f579;
=EF=BF=BDPTP Adj Freq: 3, 333776fa, 6, 40085462, 6, b8562f4b;
=EF=BF=BDPTP Adj Freq: 3, 33367d8c, 6, 40066d35, 2, 4dd63c03;
=EF=BF=BDPTP Adj Freq: 3, 3335622f, 6, 400443c7, 9, c2918b24;

When I poked into various parts of the code, I found the following observ=
ations interesting:

1) When PTP is not enabled (aka `hwstamp_ctl -t 0 -r 0`), the issue does =
not happen.
2) When I forbid phc2sys to call clock_adjtime with ADJ_FREQUENCY, the is=
sue does not happen (but the clock doesn't sync).
3) The best workaround I found that allows me to actually sync the PHC an=
d use it for PTP is editing
   hw_atl_b0_adj_clock_freq() to zero-out mac_ns_adj and mac_fns_adj fiel=
ds of the fwreq before sending
   it to the FW.
3.1) I don't even need to zero-out the values. It is enough to zero-out a=
ll negative values of the adjustment.
4) The issue is not influenced by the amount of data flowing through the =
NIC.
5) It happens both when I use the NIC as ptp4l master and when ptp4l does=
n't use the card
   (but PTP has to be enabled by the hwstamp_ctl call).

But here I'm stuck and I can't move forward understanding what are the un=
intended consequences of the
workarounds from points 3 or 3.1. Even having an NDA with Marvell and acc=
ess to the AQC107 collaterals doesn't provide a single
document that would describe the registers of the chip or API of the firm=
ware. So I can just guess, and I
really don't know what this adjustment field should be doing. hw_atl_b0_m=
ac_adj_param_calc() has a note saying
"MAC MCP counter freq is macfreq / 4", then there is a s64 variable calle=
d diff_in_mcp_overflow whose value is
slightly processed and converted to u32 (so the overflow is probably inte=
nded?). No idea what's MCP counter=20
and how does the adjustment field adjust it.

I've plotted the values of the adjustment field for ppb values from -1000=
0 to 10000, which are the values
I see phc2sys usually uses (actually, it is more like 8000 - 10000). The =
values of this adjustment oscillate
between -5 and 20. And as I said in observation 3.1, when I clamp them to=
 0-20, the problem disappears,
PHC sync runs and I can use the NIC as a PTP master.

Thanks for any hints where to go next,
Martin
</pre>
    <p></p>
    <pre class=3D"moz-signature"
    signature-switch-id=3D"bf173305-7233-405d-a93b-bfd622c96ca9" cols=3D"=
72">Mgr. Martin Pecka, Ph.D.
Researcher at Vision for Robotics and Autonomous Systems group
Faculty of Electrical Engineering
Czech Technical University in Prague</pre>
  </body>
</html>

--------------J6yDtaD88XUPB05b00i7MTuu--

--------------ms030800020305030606010608
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Elektronicky podpis S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DWowggZ8MIIEZKADAgECAhA1FhKMdvyRtr66auhNiD5DMA0GCSqGSIb3DQEBDAUAMEYxCzAJ
BgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQ
ZXJzb25hbCBDQSA0MB4XDTIzMTAwNTAwMDAwMFoXDTI1MTAwNDIzNTk1OVowgc8xCzAJBgNV
BAYTAkNaMR4wHAYDVQQIDBVQcmFoYSwgSGxhdm7DrSBtxJtzdG8xMzAxBgNVBAoMKsSMZXNr
w6kgdnlzb2vDqSB1xI1lbsOtIHRlY2huaWNrw6kgdiBQcmF6ZTEOMAwGA1UEYRMFR09WQ1ox
IzAhBgkqhkiG9w0BCQEWFHBlY2thbWEyQGZlbC5jdnV0LmN6MQ4wDAYDVQQEEwVQZWNrYTEP
MA0GA1UEKhMGTWFydGluMRUwEwYDVQQDEwxNYXJ0aW4gUGVja2EwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCSz//o3JSH0n6z70Zd49C7PGUOo9Q7JzDjg9cX5XxSW77TVcn3
KwsTxGuqKHs7IQdIK10240CvpGTPZeA9oKR4J/h0qPcE0AYfr4Ik3Zfc/XT3ewx50yRpeUC6
hXQmHshDnAKIWIi3RDWR8Vq8iPYIr0XiT7Vmbe6rQXqcTRHpYq9WuW4JPS30O8mCWT7L5HaV
/sLBqITh8axn39vm3UlMcYiPOXi3kp25MIesT6fANo89JkMU0TDTMQrX0LNfkx1m0A0z7YWa
n6UeKnO1Km5/5jbJLnV7ZnnDklk/wgcp5a8UfUDfVhXUrNVzURwX1A7043jCDc2F4ueQzCNN
e6+hAgMBAAGjggHaMIIB1jAfBgNVHSMEGDAWgBRpAKHHIVj44MUbILAK3adRvxPZ5DAdBgNV
HQ4EFgQU7XtGoEr5iEI04VXMKXwDgk/EbcAwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQC
MAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMFAGA1UdIARJMEcwOgYMKwYBBAGy
MQECAQoEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYH
Z4EMAQUDAjBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vR0VBTlQuY3JsLnNlY3RpZ28uY29t
L0dFQU5UUGVyc29uYWxDQTQuY3JsMHgGCCsGAQUFBwEBBGwwajA9BggrBgEFBQcwAoYxaHR0
cDovL0dFQU5ULmNydC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0LmNydDApBggrBgEF
BQcwAYYdaHR0cDovL0dFQU5ULm9jc3Auc2VjdGlnby5jb20wRwYDVR0RBEAwPoEUTWFydGlu
LlBlY2thQGN2dXQuY3qBEHBlY2thbWEyQGN2dXQuY3qBFHBlY2thbWEyQGZlbC5jdnV0LmN6
MA0GCSqGSIb3DQEBDAUAA4ICAQAOTtnV864+VORsMVLrp6EoNuPpM6SWuGF1a3ToVY8hVaZa
xGCls26PlaZ1e1xOUsl6AA7hGQAoC7skWFotnJc1+LpRlsylWvfRYQwhly0rqCjXqfkYUZtm
s2Y2t+0QZe6vZMg3GGo3nB1Nx7yGQRJV6MJI67wP4IFUEOrqzhCf1SQhwKkS1nq5KUILq53S
E+oQMh1lq1bdo9DBWjSxgIBXPEgEzxcClbqFRfXL4ZiZtlUprB8sBHYFJbPpPw+UbA+1tHV6
kt/Ds61AxQxwJMbN07tstf+8zEqTY7lBJx0o4btHG21aH/uOVR0ElughH+CvOzESmVJ1n9O9
OkXrxhXOCdZyOH1mNTLeljhhE89ESa8oGULUGwCeoBCdCEu8t2jHhoFz7ItSQDO4Gdo0QHy8
HIqMHNbqQRL2MtjRJ2AfLVQD94A9tLVpVgWL/DnhQ6W5hAk6B/2Qao95GkJaPw32IY002rwj
KIPAi5ZtAhr245sE9M7ficsC3Nc6VWZbwEtOxp9X67EGusdGpX+s8EGAUbTnaGZE/9kYx4pl
pzudPrpnGG7gCxjlUVxtij745QFJkoIGCbL61R2M7tEI4W9X0b8cgVeZuD28rvyDpove2ZQl
qEuey1oCnQ48VAvH7+Ux1RBRokOYqnktRUgYyF1Z8B9RPvcsInQoFjm4cXynPjCCBuYwggTO
oAMCAQICEDECcNQ1vpskmvhW0OHihUkwDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVT
MRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMV
VGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5MB4XDTIwMDIxODAwMDAwMFoXDTMzMDUwMTIzNTk1OVowRjELMAkG
A1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5UIFBl
cnNvbmFsIENBIDQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCzSuIiXidb6QRb
FAQ1MiAUrrTSMUDGzVDAHqFEyq+eSmF/LZDeYpszai2kQsqWATz/cBA9gGjunvJ45G48ycC4
D6gwZFvbBt5JotxlunBeB8K+crGar3v+RCQ4VfvToX07v+HTJ6EeEONR3IzJPTMyzgAwENGs
AWf9va9HePQFJiChCzXqhKpp0zen53S+8f9itEy06GS8aku7Mvyb4tMBBa9An3Y3ALIqIeym
g/iYs8m9WkSkMyekNtFRB1+1KlnNUpM05G8+sY9EucnQQRUIdHzYsvqjP3XlaSuB4Jj0ia66
UGfi5Wx31mm5sKAz8Re9UGVWIqq6wKFKxkSfuO4iwYiIPJoiGEux3dqabwFLduAroDF1IxE4
0PqGIdPXzYuZ/wL6BEfFAb0xy8bfm5S9G7y/ts9mIlFpPtkLZ/nQ/iVOWdsu9ale/nK/uGF4
7xsxeW2LIvB4sH5U2+D4ad8vpNbcCrXIXXKtkBnNHgxumNNZ0R1Isq/Pz7TALCxxDzWdsM7A
O32/Jn7R4ldtGRZmKpJyfACDn8HU1QPhOtiWsjifrMWnanJhQ6K7M/5qz8BmfPrca+MUrr1Y
4NHZb9MrgPtWKQQyGDXy+G5F/iHGdZk7LS+F8NH+Ddolt2wZpz52JqGMTDPIH5Qok4LLO95w
bxtn+79Tw+wQxmDTuIg+LwIDAQABo4IBizCCAYcwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHY
m8Cd8rIDZsswHQYDVR0OBBYEFGkAocchWPjgxRsgsArdp1G/E9nkMA4GA1UdDwEB/wQEAwIB
hjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDA4
BgNVHSAEMTAvMC0GBFUdIAAwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVz
dFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEF
BQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0Eu
Y3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEB
DAUAA4ICAQAKBU57DY8fEzkA/W/sYsbD7e0XquMBzHjcP0eXXXRD4EAEAGCWSs+QRL9XIxmx
+52zx9wMa8YTejlR+NKejiyKPTF0q63zMxrO/z/hUwo8IDcRRLS0NSgvTW6AN2rCXJe5iLN5
fIfYgIBB9cy1L6trPuZ/vjUJm87nQ7ExQzGqWN5F9U8MlAk0c5iLanG7GCMoNjHiF1n0baj6
guUeG7n5qcwOQTyDS19+NEqfwjUPUGasN1ZH8h1sE6PrzvRpti+rKzWpiU+i2/k3l2b5fFDy
+Wu9jv6R9BoBh47es/UMzwEZ2kSrIVVr4jSukk+FpmR5ZbtwiYNAV6sdb1srMGsILzXlrdas
SE2nGHvZklk2zUdgn7b01MHq67g0mNozGmT6Dam41Kbhv25WMFs871XqwVIb4gGoT1yRf/Ve
PMm1jwauqijhKJFvrNweGnebGPeipaLxIo2iEA4qdRztEg/qyzWGogXK/TFdmivg322fMPQW
jQkMhRGMM8SCjlZN22L8x0ZOYoVA2rHJm5P25IjZe+HPyn7ikJiSJmqlqFmUeowXF3D1dFlC
Cs/5yC06RYRqI2REFu+28t2nswIvY6xCFAR0RtS8Mz2yXNld0js2MmiRUGrc7imWzdUPbPcv
9sdUF7SsERGPIzYL8dIiHzit+YCoGCSXMg6peF37hHNp1TGCAzgwggM0AgEBMFowRjELMAkG
A1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5UIFBl
cnNvbmFsIENBIDQCEDUWEox2/JG2vrpq6E2IPkMwDQYJYIZIAWUDBAIBBQCgggGvMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcyMDAyMjQzM1owLwYJ
KoZIhvcNAQkEMSIEIKy3NGOI0SeLruQvHMlofqVo0UDwsgJ9Mxv4W4K/vlCdMGkGCSsGAQQB
gjcQBDFcMFowRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAa
BgNVBAMTE0dFQU5UIFBlcnNvbmFsIENBIDQCEDUWEox2/JG2vrpq6E2IPkMwawYLKoZIhvcN
AQkQAgsxXKBaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRww
GgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhA1FhKMdvyRtr66auhNiD5DMGwGCSqGSIb3
DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZI
hvcNAQEBBQAEggEAYLYjb53F+qRAG+7a/59NDxJES5i754h6mFQhZ50EJ5etgtwV+7o1nXLS
OxodxyOWaWJGGMIVsQqIrTx4gxvXBtbRZV2OcttTKq/gc8rJNfWIBGqJmzLfihfA/bEQ0sMD
3rbZSrwnvFVkmneS6cUqMd8+IL6ojL1aFO8dsDVTqRXz4eH+s99Y3X7NFlQwBIW/XPzmQ2/9
P3saSeUdji/aXMfr7nmGPv/6D9lb/SyjwxbfRt12wuzJFeQbDv7KfZJ5WpSUY7DDme2ZDd/l
QShcsIsc2Idrwfs1uZ1FyqB8bpvl32CZtmbAIS+g2mWGB2QdUhFD8iHbMlNYQUTPHKYhyAAA
AAAAAA==
--------------ms030800020305030606010608--

