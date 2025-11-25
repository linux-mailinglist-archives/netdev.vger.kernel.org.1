Return-Path: <netdev+bounces-241556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1008C85CEE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A06234AA69
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A5328638;
	Tue, 25 Nov 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="HNMEdYCB"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1971329370;
	Tue, 25 Nov 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085156; cv=none; b=Cdih202nIC8r9sCfd+2EdodqFKdwb0oA8p1K11OXmjIis6bqRB9gi/Z28eYBEqQpJv6zd9EL2I24qlmELsf8CXurph/V3u/Vk6qhcUSkuLiy8o7VxK20hMrhN+w1bBO94KDuKzVQMHLiuiTXcH2ZwZDiyxkBXLESjsmnC/n+WHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085156; c=relaxed/simple;
	bh=XUMxd1sgN6nRPq7zZQF0oIRVVPGBqDqqNQDplmVFMpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yga6VYF3P0l7VGUcIvYNuOSNRptmXYVISLS9vni0OCkjimaifCpL6d2ek3wM9FzCpCr/YBny6aTetEKnA6j6hdMFfxb+YUFYgseKHpYZHjgQ3pCKl8ArxpWTsAGpQMSnQDx+v+r4qknG7YC4ZotyGae3F128Ci2tY1L3RoAA7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=HNMEdYCB; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764085154; x=1795621154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XUMxd1sgN6nRPq7zZQF0oIRVVPGBqDqqNQDplmVFMpY=;
  b=HNMEdYCB5/+1/tBA6eN6PSWElFBZycUrFeo3s9DH9gfGyjATZtlb4h6U
   h6CNJhZcpz2w3LN2zOqRxIrNJSyCa9sASnGSujl+kC4aF6Y6KNQwYKclf
   r8ZgPTsjE+6aR9zXIxNJxArpYrpMBzcJpw7WTHiNUU7hIAI9i2g74fJCg
   T+b2tAtU4YxO8Y1sOKKaQyzb+BDhJmF3FxuEkXJoNXzi9L5qp7rJiSq+/
   H3n16eEFjp0EGLyiCaLnPRvwj97VnSrj5heLUKVr1f8qXoV20E5s3wSrn
   glJVcDpKumYgOzi6Zn1WDu4Cy9gYI8yu97G1Cj6PwRpL2HcTYgvbW3MJp
   A==;
X-CSE-ConnectionGUID: tsrPnAToS66GUNVK74whlg==
X-CSE-MsgGUID: CivnpwQ9QQqA2KZptqGrAA==
X-IronPort-AV: E=Sophos;i="6.20,225,1758585600"; 
   d="scan'208";a="5674710"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 15:38:54 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:31634]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525] with esmtp (Farcaster)
 id 0a0762f7-c031-4a41-9d20-cdfa9e286805; Tue, 25 Nov 2025 15:38:54 +0000 (UTC)
X-Farcaster-Flow-ID: 0a0762f7-c031-4a41-9d20-cdfa9e286805
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:54 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:53 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 25 Nov 2025 15:38:53 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 2/2] ptp: vmclock: support device notifications
Thread-Topic: [RFC PATCH 2/2] ptp: vmclock: support device notifications
Thread-Index: AQHcXiGaXBXgjv2OV0ypWqKuhz60Pw==
Date: Tue, 25 Nov 2025 15:38:53 +0000
Message-ID: <20251125153830.11487-3-bchalios@amazon.es>
References: <20251125153830.11487-1-bchalios@amazon.es>
In-Reply-To: <20251125153830.11487-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <61206EE014051B41BE587496E77C2D79@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Vk1DbG9jayBub3cgZXhwZWN0cyB0aGUgaHlwZXJ2aXNvciB0byBzZW5kIGEgZGV2aWNlIG5vdGlm
aWNhdGlvbiBldmVyeQp0aW1lIHRoZSBzZXFjb3VudCBsb2NrIGNoYW5nZXMgdG8gYSBuZXcgKGV2
ZW4pIHZhbHVlLgoKTW9yZW92ZXIsIGFkZCBzdXBwb3J0IGZvciBwb2xsKCkgaW4gVk1DbG9jayBh
cyBhIG1lYW5zIHRvIHByb3BhZ2F0ZSB0aGlzCm5vdGlmaWNhdGlvbiB0byB1c2VyIHNwYWNlLiBw
b2xsKCkgd2lsbCBub3RpZnkgbGlzdGVuZXJzIGV2ZXJ5IHRpbWUKc2VxX2NvdW50IGhhcyBjaGFu
Z2VkIHRvIGEgbmV3IChldmVuKSB2YWx1ZSBzaW5jZSB0aGUgbGFzdCB0aW1lIHJlYWQoKQoob3Ig
b3BlbigpKSB3YXMgY2FsbGVkIG9uIHRoZSBkZXZpY2UuIFRoaXMgbWVhbnMgdGhhdCB3aGVuIHBv
bGwoKQpyZXR1cm5zIGEgKFBPTExJTikgZXZlbnQsIGxpc3RlbmVycyBuZWVkIHRvIHVzZSByZWFk
KCkgdG8gb2JzZXJ2ZSB3aGF0CmhhcyBjaGFuZ2VkIGFuZCB1cGRhdGUgdGhlIHJlYWRlcidzIHZp
ZXcgb2Ygc2VxX2NvdW50LiBJbiBvdGhlciB3b3JkcywKYWZ0ZXIgYSBwb2xsKCkgcmV0dXJuZWQg
YWxsIHN1YnNlcXVlbnQgY2FsbHMgdG8gcG9sbCgpIHdpbGwgaW1tZWRpYXRlbHkKcmV0dXJuIHdp
dGggYSBQT0xMSU4gZXZlbnQgdW50aWwgdGhlIGxpc3RlbmVyIGNhbGxzIHJlYWQoKS4KClNpZ25l
ZC1vZmYtYnk6IEJhYmlzIENoYWxpb3MgPGJjaGFsaW9zQGFtYXpvbi5lcz4KLS0tCiBkcml2ZXJz
L3B0cC9wdHBfdm1jbG9jay5jIHwgODUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3B0cC9wdHBfdm1jbG9jay5jIGIvZHJpdmVycy9wdHAvcHRw
X3ZtY2xvY2suYwppbmRleCBiM2E4M2IwM2Q5YzEuLmVmY2RjYzVjNDBjZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9wdHAvcHRwX3ZtY2xvY2suYworKysgYi9kcml2ZXJzL3B0cC9wdHBfdm1jbG9jay5j
CkBAIC01LDYgKzUsOSBAQAogICogQ29weXJpZ2h0IMKpIDIwMjQgQW1hem9uLmNvbSwgSW5jLiBv
ciBpdHMgYWZmaWxpYXRlcy4KICAqLwogCisjaW5jbHVkZSAibGludXgvcG9sbC5oIgorI2luY2x1
ZGUgImxpbnV4L3R5cGVzLmgiCisjaW5jbHVkZSAibGludXgvd2FpdC5oIgogI2luY2x1ZGUgPGxp
bnV4L2FjcGkuaD4KICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KICNpbmNsdWRlIDxsaW51eC9l
cnIuaD4KQEAgLTM5LDYgKzQyLDcgQEAgc3RydWN0IHZtY2xvY2tfc3RhdGUgewogCXN0cnVjdCBy
ZXNvdXJjZSByZXM7CiAJc3RydWN0IHZtY2xvY2tfYWJpICpjbGs7CiAJc3RydWN0IG1pc2NkZXZp
Y2UgbWlzY2RldjsKKwl3YWl0X3F1ZXVlX2hlYWRfdCBkaXNydXB0X3dhaXQ7CiAJc3RydWN0IHB0
cF9jbG9ja19pbmZvIHB0cF9jbG9ja19pbmZvOwogCXN0cnVjdCBwdHBfY2xvY2sgKnB0cF9jbG9j
azsKIAllbnVtIGNsb2Nrc291cmNlX2lkcyBjc19pZCwgc3lzX2NzX2lkOwpAQCAtMzU3LDEwICsz
NjEsMTUgQEAgc3RhdGljIHN0cnVjdCBwdHBfY2xvY2sgKnZtY2xvY2tfcHRwX3JlZ2lzdGVyKHN0
cnVjdCBkZXZpY2UgKmRldiwKIAlyZXR1cm4gcHRwX2Nsb2NrX3JlZ2lzdGVyKCZzdC0+cHRwX2Ns
b2NrX2luZm8sIGRldik7CiB9CiAKK3N0cnVjdCB2bWNsb2NrX2ZpbGVfc3RhdGUgeworCXN0cnVj
dCB2bWNsb2NrX3N0YXRlICpzdDsKKwl1aW50MzJfdCBzZXE7Cit9OworCiBzdGF0aWMgaW50IHZt
Y2xvY2tfbWlzY2Rldl9tbWFwKHN0cnVjdCBmaWxlICpmcCwgc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEpCiB7Ci0Jc3RydWN0IHZtY2xvY2tfc3RhdGUgKnN0ID0gY29udGFpbmVyX29mKGZwLT5w
cml2YXRlX2RhdGEsCi0JCQkJCQlzdHJ1Y3Qgdm1jbG9ja19zdGF0ZSwgbWlzY2Rldik7CisJc3Ry
dWN0IHZtY2xvY2tfZmlsZV9zdGF0ZSAqZnN0ID0gZnAtPnByaXZhdGVfZGF0YTsKKwlzdHJ1Y3Qg
dm1jbG9ja19zdGF0ZSAqc3QgPSBmc3QtPnN0OwogCiAJaWYgKCh2bWEtPnZtX2ZsYWdzICYgKFZN
X1JFQUR8Vk1fV1JJVEUpKSAhPSBWTV9SRUFEKQogCQlyZXR1cm4gLUVST0ZTOwpAQCAtMzc5LDgg
KzM4OCw5IEBAIHN0YXRpYyBpbnQgdm1jbG9ja19taXNjZGV2X21tYXAoc3RydWN0IGZpbGUgKmZw
LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIHN0YXRpYyBzc2l6ZV90IHZtY2xvY2tfbWlz
Y2Rldl9yZWFkKHN0cnVjdCBmaWxlICpmcCwgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJCQkgICAgc2l6
ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCiB7Ci0Jc3RydWN0IHZtY2xvY2tfc3RhdGUgKnN0ID0g
Y29udGFpbmVyX29mKGZwLT5wcml2YXRlX2RhdGEsCi0JCQkJCQlzdHJ1Y3Qgdm1jbG9ja19zdGF0
ZSwgbWlzY2Rldik7CisJc3RydWN0IHZtY2xvY2tfZmlsZV9zdGF0ZSAqZnN0ID0gZnAtPnByaXZh
dGVfZGF0YTsKKwlzdHJ1Y3Qgdm1jbG9ja19zdGF0ZSAqc3QgPSBmc3QtPnN0OworCiAJa3RpbWVf
dCBkZWFkbGluZSA9IGt0aW1lX2FkZChrdGltZV9nZXQoKSwgVk1DTE9DS19NQVhfV0FJVCk7CiAJ
c2l6ZV90IG1heF9jb3VudDsKIAl1aW50MzJfdCBzZXE7CkBAIC00MDIsOCArNDEyLDEwIEBAIHN0
YXRpYyBzc2l6ZV90IHZtY2xvY2tfbWlzY2Rldl9yZWFkKHN0cnVjdCBmaWxlICpmcCwgY2hhciBf
X3VzZXIgKmJ1ZiwKIAogCQkvKiBQYWlycyB3aXRoIGh5cGVydmlzb3Igd21iICovCiAJCXZpcnRf
cm1iKCk7Ci0JCWlmIChzZXEgPT0gbGUzMl90b19jcHUoc3QtPmNsay0+c2VxX2NvdW50KSkKKwkJ
aWYgKHNlcSA9PSBsZTMyX3RvX2NwdShzdC0+Y2xrLT5zZXFfY291bnQpKSB7CisJCQlmc3QtPnNl
cSA9IHNlcTsKIAkJCWJyZWFrOworCQl9CiAKIAkJaWYgKGt0aW1lX2FmdGVyKGt0aW1lX2dldCgp
LCBkZWFkbGluZSkpCiAJCQlyZXR1cm4gLUVUSU1FRE9VVDsKQEAgLTQxMywxMCArNDI1LDUxIEBA
IHN0YXRpYyBzc2l6ZV90IHZtY2xvY2tfbWlzY2Rldl9yZWFkKHN0cnVjdCBmaWxlICpmcCwgY2hh
ciBfX3VzZXIgKmJ1ZiwKIAlyZXR1cm4gY291bnQ7CiB9CiAKK3N0YXRpYyBfX3BvbGxfdCB2bWNs
b2NrX21pc2NkZXZfcG9sbChzdHJ1Y3QgZmlsZSAqZnAsIHBvbGxfdGFibGUgKndhaXQpCit7CisJ
c3RydWN0IHZtY2xvY2tfZmlsZV9zdGF0ZSAqZnN0ID0gZnAtPnByaXZhdGVfZGF0YTsKKwlzdHJ1
Y3Qgdm1jbG9ja19zdGF0ZSAqc3QgPSBmc3QtPnN0OworCXVpbnQzMl90IHNlcTsKKworCXBvbGxf
d2FpdChmcCwgJnN0LT5kaXNydXB0X3dhaXQsIHdhaXQpOworCisJc2VxID0gbGUzMl90b19jcHUo
c3QtPmNsay0+c2VxX2NvdW50KTsKKwlpZiAoZnN0LT5zZXEgIT0gc2VxKQorCQlyZXR1cm4gUE9M
TElOIHwgUE9MTFJETk9STTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHZtY2xvY2tf
bWlzY2Rldl9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmcCkKK3sKKwlz
dHJ1Y3Qgdm1jbG9ja19zdGF0ZSAqc3QgPSBjb250YWluZXJfb2YoZnAtPnByaXZhdGVfZGF0YSwK
KwkJCQkJCXN0cnVjdCB2bWNsb2NrX3N0YXRlLCBtaXNjZGV2KTsKKwlzdHJ1Y3Qgdm1jbG9ja19m
aWxlX3N0YXRlICpmc3QgPSBremFsbG9jKHNpemVvZigqZnN0KSwgR0ZQX0tFUk5FTCk7CisKKwlp
ZiAoIWZzdCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlmc3QtPnN0ID0gc3Q7CisJZnN0LT5zZXEg
PSBsZTMyX3RvX2NwdShzdC0+Y2xrLT5zZXFfY291bnQpOworCisJZnAtPnByaXZhdGVfZGF0YSA9
IGZzdDsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHZtY2xvY2tfbWlzY2Rldl9yZWxl
YXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmcCkKK3sKKwlrZnJlZShmcC0+
cHJpdmF0ZV9kYXRhKTsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxl
X29wZXJhdGlvbnMgdm1jbG9ja19taXNjZGV2X2ZvcHMgPSB7CiAJLm93bmVyID0gVEhJU19NT0RV
TEUsCisJLm9wZW4gPSB2bWNsb2NrX21pc2NkZXZfb3BlbiwKKwkucmVsZWFzZSA9IHZtY2xvY2tf
bWlzY2Rldl9yZWxlYXNlLAogCS5tbWFwID0gdm1jbG9ja19taXNjZGV2X21tYXAsCiAJLnJlYWQg
PSB2bWNsb2NrX21pc2NkZXZfcmVhZCwKKwkucG9sbCA9IHZtY2xvY2tfbWlzY2Rldl9wb2xsLAog
fTsKIAogLyogbW9kdWxlIG9wZXJhdGlvbnMgKi8KQEAgLTQ1OSw2ICs1MTIsMTYgQEAgc3RhdGlj
IGFjcGlfc3RhdHVzIHZtY2xvY2tfYWNwaV9yZXNvdXJjZXMoc3RydWN0IGFjcGlfcmVzb3VyY2Ug
KmFyZXMsIHZvaWQgKmRhdGEKIAlyZXR1cm4gQUVfRVJST1I7CiB9CiAKK3N0YXRpYyB2b2lkCit2
bWNsb2NrX2FjcGlfbm90aWZpY2F0aW9uX2hhbmRsZXIoYWNwaV9oYW5kbGUgX19hbHdheXNfdW51
c2VkIGhhbmRsZSwKKwkJCQkgIHUzMiBfX2Fsd2F5c191bnVzZWQgZXZlbnQsIHZvaWQgKmRldikK
K3sKKwlzdHJ1Y3QgZGV2aWNlICpkZXZpY2UgPSBkZXY7CisJc3RydWN0IHZtY2xvY2tfc3RhdGUg
KnN0ID0gZGV2aWNlLT5kcml2ZXJfZGF0YTsKKworCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmc3Qt
PmRpc3J1cHRfd2FpdCk7Cit9CisKIHN0YXRpYyBpbnQgdm1jbG9ja19wcm9iZV9hY3BpKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IHZtY2xvY2tfc3RhdGUgKnN0KQogewogCXN0cnVjdCBhY3Bp
X2RldmljZSAqYWRldiA9IEFDUElfQ09NUEFOSU9OKGRldik7CkBAIC00NzksNiArNTQyLDE0IEBA
IHN0YXRpYyBpbnQgdm1jbG9ja19wcm9iZV9hY3BpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IHZtY2xvY2tfc3RhdGUgKnN0KQogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKKwlzdGF0dXMgPSBh
Y3BpX2luc3RhbGxfbm90aWZ5X2hhbmRsZXIoYWRldi0+aGFuZGxlLCBBQ1BJX0RFVklDRV9OT1RJ
RlksCisJCQkJCSAgICAgdm1jbG9ja19hY3BpX25vdGlmaWNhdGlvbl9oYW5kbGVyLAorCQkJCQkg
ICAgIGRldik7CisJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7CisJCWRldl9lcnIoZGV2LCAi
ZmFpbGVkIHRvIGluc3RhbGwgbm90aWZpY2F0aW9uIGhhbmRsZXIiKTsKKwkJcmV0dXJuIC1FTk9E
RVY7CisJfQorCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTU0OSw2ICs2MjAsOCBAQCBzdGF0aWMgaW50
IHZtY2xvY2tfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlpZiAocmV0KQog
CQlyZXR1cm4gcmV0OwogCisJaW5pdF93YWl0cXVldWVfaGVhZCgmc3QtPmRpc3J1cHRfd2FpdCk7
CisKIAkvKgogCSAqIElmIHRoZSBzdHJ1Y3R1cmUgaXMgYmlnIGVub3VnaCwgaXQgY2FuIGJlIG1h
cHBlZCB0byB1c2Vyc3BhY2UuCiAJICogVGhlb3JldGljYWxseSBhIGd1ZXN0IE9TIGV2ZW4gdXNp
bmcgbGFyZ2VyIHBhZ2VzIGNvdWxkIHN0aWxsCkBAIC01ODEsNiArNjU0LDggQEAgc3RhdGljIGlu
dCB2bWNsb2NrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCXJldHVybiAt
RU5PREVWOwogCX0KIAorCWRldi0+ZHJpdmVyX2RhdGEgPSBzdDsKKwogCWRldl9pbmZvKGRldiwg
IiVzOiByZWdpc3RlcmVkICVzJXMlc1xuIiwgc3QtPm5hbWUsCiAJCSBzdC0+bWlzY2Rldi5taW5v
ciA/ICJtaXNjZGV2IiA6ICIiLAogCQkgKHN0LT5taXNjZGV2Lm1pbm9yICYmIHN0LT5wdHBfY2xv
Y2spID8gIiwgIiA6ICIiLAotLSAKMi4zNC4xCgo=

