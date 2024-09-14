Return-Path: <netdev+bounces-128372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D49793B2
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 00:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15061F21D26
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9513AA2B;
	Sat, 14 Sep 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="tEv2FcJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3541754B
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.210.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726353319; cv=none; b=c0Hny6HJEYc3ylrJUps4SL8R6k/2lHagp9Y59VDtZxguKmeF+nt5fyW2BbV2vtjPMiK7vRvT81xsPy3kDvv5K4cNuzWmVsNH6ileRYBRpZLjjswycI9ZynewLcMZa714DLEu8D8TDMkoY68zSEC3VBJvNEQpurgzMsWH6UCFAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726353319; c=relaxed/simple;
	bh=jPNLiL2IkNOJNQ2xyaEkkwccTOvj9BrAhT1Tju+z8EU=;
	h=From:Message-ID:Date:MIME-Version:To:Subject:Cc:Content-Type; b=C8CnR4XY/9utt3NGgkYeJaT5VrO9jKn/hppXsvQbccD00rKv+BT6pCusPMCMEYzBZHkhP0aOQ3cHGErg1GpgLGj4w7w80ZUg0T/wkIX67LwPhwVKZDS9wXTJkMhSVwaUx37MnmwFkUlfDUeOqeKvft1eICi0WvjVv9emsJS04sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=tEv2FcJV; arc=none smtp.client-ip=80.12.210.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1726353316; x=1757889316;
  h=message-id:date:mime-version:to:subject:cc:
   content-transfer-encoding:from;
  bh=jPNLiL2IkNOJNQ2xyaEkkwccTOvj9BrAhT1Tju+z8EU=;
  b=tEv2FcJVaNt5nIr2dfYKVBfZJGNnf6ecB2UGzHSIjBZZPUsDGGh5dHUW
   THtKLVROTxzGrbL1/BGrdRM2sSlCH1gNxFmnPjeYbNU9uqReBVjzy/ZcC
   jat+wFGciqSpWicIhsKah+iFnm0H0nPovZOEjUMI0zbON7SOtf3fqs6xE
   mBvKUZFTF0r38B/RpHpDDu6CPQzGCiTq0621ArNwKV+NwPEEooGH+cGPf
   Khc3sZsFQY6d8+CEAXbkGBnBRZsLFqF6SSOcRC2BgQZGnirYB4Y0xwMb5
   6ltIIAEXPltMpTlWzlFZpuma9O6Iku/phxh7f/GzQLefHSxjz0y18RUdp
   A==;
Received: from unknown (HELO opfedv3rlp0a.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2024 00:34:06 +0200
Received: from mailhost.rd.francetelecom.fr (HELO l-mail-int) ([x.x.x.x]) by
 opfedv3rlp0a.nor.fr.ftgroup with ESMTP; 15 Sep 2024 00:34:07 +0200
Received: from lat6466.rd.francetelecom.fr ([x.x.x.x])	by l-mail-int with esmtp (Exim
 4.94.2)	(envelope-from <alexandre.ferrieux@orange.com>)	id 1spbL0-002dnT-SM;
 Sun, 15 Sep 2024 00:34:05 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.10,229,1719871200"; 
   d="scan'208";a="198034414"
Message-ID: <c35a227c-6a3d-47c8-95f0-6fd6d41454c5@orange.com>
Date: Sun, 15 Sep 2024 00:34:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: fr, en-US
To: netdev@vger.kernel.org
Subject: RFC: Should net namespaces scale up (>10k) ?
Cc: Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGksCgpDdXJyZW50bHksIG5ldG5zIGRvbid0IHJlYWxseSBzY2FsZSBiZXlvbmQgYSBmZXcgdGhv
dXNhbmRzLCBmb3IgbXVuZGFuZSByZWFzb25zIAooc2VlIGJlbG93KS4gQnV0IHNob3VsZCB0aGV5
ID8gSXMgdGhlcmUsIGluIHRoZSBkZXNpZ24sIGFuIGFzc3VtcHRpb24gdGhhdCB0ZW5zIApvZiB0
aG91c2FuZHMgb2YgbmV0d29yayBuYW1lc3BhY2VzIGFyZSBjb25zaWRlcmVkICJ1bnJlYXNvbmFi
bGUiID8KCkEgdHlwaWNhbCB1c2UgY2FzZSBmb3Igc3VjaCByaWRpY3Vsb3VzIG51bWJlcnMgaXMg
YSB0ZXN0ZXIgZm9yIGZpcmV3YWxscyBvciAKY2Fycmllci1ncmFkZSBOQVRzLiBJbiB0aGVzZSwg
eW91IHR5cGljYWxseSB3YW50IHRlbnMgb2YgdGhvdXNhbmRzIG9mIHR1bm5lbHMsIAplYWNoIG9m
IHdoaWNoIGlzIHBlcmZlY3RseSBpbnN0YW50aWF0ZWQgYXMgYW4gaW50ZXJmYWNlLiBBbmQsIHRv
IGF2b2lkIGFuIApleHBsb3Npb24gaW4gc291cmNlIHJvdXRpbmcgcnVsZXMsIHlvdSB3YW50IHRo
ZW0gaW4gc2VwYXJhdGUgbmFtZXNwYWNlcy4KCk5vdyB3aHkgZG9uJ3QgdGhleSBzY2FsZSAqdG9k
YXkqID8gRm9yIHR3byBpbmRlcGVuZGVudCwgc2VlbWluZ2x5IGFjY2lkZW50YWwsIApPKE4pIHNj
YW5zIG9mIHRoZSBuZXRucyBsaXN0LgoKMS4gVGhlICJuZXRkZXZpY2Ugbm90aWZpZXIiIGZyb20g
dGhlIFdpcmVsZXNzIEV4dGVuc2lvbnMgc3Vic3lzdGVtIGluc2lzdHMgb24gCnNjYW5uaW5nIHRo
ZSB3aG9sZSBsaXN0IHJlZ2FyZGxlc3Mgb2YgdGhlIG5hdHVyZSBvZiB0aGUgY2hhbmdlLCBub3Ig
d29uZGVyaW5nIAp3aGV0aGVyIGFsbCB0aGVzZSBuYW1lc3BhY2VzIGhvbGQgYW55IHdpcmVsZXNz
IGludGVyZmFjZSwgbm9yIGV2ZW4gd2hldGhlciB0aGUgCnN5c3RlbSBoYXMgX2FueV8gd2lyZWxl
c3MgaGFyZHdhcmUuLi4KCiAgICAgICAgIGZvcl9lYWNoX25ldChuZXQpIHsKICAgICAgICAgICAg
ICAgICB3aGlsZSAoKHNrYiA9IHNrYl9kZXF1ZXVlKCZuZXQtPndleHRfbmxldmVudHMpKSkKICAg
ICAgICAgICAgICAgICAgICAgICAgIHJ0bmxfbm90aWZ5KHNrYiwgbmV0LCAwLCBSVE5MR1JQX0xJ
TkssIE5VTEwsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVM
KTsKICAgICAgICAgfQoKMi4gV2hlbiBtb3ZpbmcgYW4gaW50ZXJmYWNlIChlZyBhbiBJUFZMQU4g
c2xhdmUpIHRvIGFub3RoZXIgbmV0bnMsIApfX2Rldl9jaGFuZ2VfbmV0X25hbWVzcGFjZSgpIGNh
bGxzIHBlZXJuZXQyaWRfYWxsb2MoKSBpbiBvcmRlciB0byBnZXQgYW4gSUQgZm9yIAp0aGUgdGFy
Z2V0IG5hbWVzcGFjZS4gVGhpcyBhZ2FpbiBpbmN1cnMgYSBmdWxsIHNjYW4gb2YgdGhlIG5ldG5z
IGxpc3Q6CgogICAgICAgICBpbnQgaWQgPSBpZHJfZm9yX2VhY2goJm5ldC0+bmV0bnNfaWRzLCBu
ZXRfZXFfaWRyLCBwZWVyKTsKCk5vdGUgdGhhdCwgd2hpbGUgSURSIGlzIHZlcnkgZmFzdCB3aGVu
IGdvaW5nIGZyb20gSUQgdG8gcG9pbnRlciwgdGhlIHJldmVyc2UgCnBhdGggaXMgYXdmdWxseSBz
bG93Li4uIEJ1dCB3aHkgYXJlIElEcyBuZWVkZWQgaW4gdGhlIGZpcnN0IHBsYWNlLCBpbnN0ZWFk
IG9mIAp0aGUgc2ltcGxlIG5ldG5zIHBvaW50ZXJzID8KCkFueSBpbnNpZ2h0IG9uIHRoZSAocG9z
c2libHkgdmVyeSBnb29kKSByZWFzb25zIHRob3NlIHR3byBhcHBhcmVudCB3YXJ0cyBzdGFuZCAK
aW4gdGhlIHdheSBvZiBuZXRucyBzY2FsaW5nIHVwID8KCi1BbGV4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KQ2UgbWVzc2FnZSBldCBzZXMgcGll
Y2VzIGpvaW50ZXMgcGV1dmVudCBjb250ZW5pciBkZXMgaW5mb3JtYXRpb25zIGNvbmZpZGVudGll
bGxlcyBvdSBwcml2aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBkb25jDQpwYXMgZXRyZSBkaWZmdXNl
cywgZXhwbG9pdGVzIG91IGNvcGllcyBzYW5zIGF1dG9yaXNhdGlvbi4gU2kgdm91cyBhdmV6IHJl
Y3UgY2UgbWVzc2FnZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBsZSBzaWduYWxlcg0KYSBsJ2V4cGVk
aXRldXIgZXQgbGUgZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBwaWVjZXMgam9pbnRlcy4gTGVzIG1l
c3NhZ2VzIGVsZWN0cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGlibGVzIGQnYWx0ZXJhdGlvbiwNCk9y
YW5nZSBkZWNsaW5lIHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNpIGNlIG1lc3NhZ2UgYSBldGUgYWx0
ZXJlLCBkZWZvcm1lIG91IGZhbHNpZmllLiBNZXJjaS4NCg0KVGhpcyBtZXNzYWdlIGFuZCBpdHMg
YXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5mb3Jt
YXRpb24gdGhhdCBtYXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsNCnRoZXkgc2hvdWxkIG5vdCBiZSBk
aXN0cmlidXRlZCwgdXNlZCBvciBjb3BpZWQgd2l0aG91dCBhdXRob3Jpc2F0aW9uLg0KSWYgeW91
IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMuDQpBcyBlbWFp
bHMgbWF5IGJlIGFsdGVyZWQsIE9yYW5nZSBpcyBub3QgbGlhYmxlIGZvciBtZXNzYWdlcyB0aGF0
IGhhdmUgYmVlbiBtb2RpZmllZCwgY2hhbmdlZCBvciBmYWxzaWZpZWQuDQpUaGFuayB5b3UuCg==


