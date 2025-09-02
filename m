Return-Path: <netdev+bounces-219052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77023B3F92A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1079C189235D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7C2E36F4;
	Tue,  2 Sep 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="c95EjJfG"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370C32F742;
	Tue,  2 Sep 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803213; cv=none; b=CGtlOo/ssyADdRAn0nwiXbZIReQuHAdG9V8TODy/85e5anBSt4VNED2gFI9lJtakExdzBZ7lhzdAGoWxQTDTthgc63+y7SW5r+lXocFjCoJgSfhw9x2uccIgSNDouP1c1ZDbs+z6qkDbdRwYNbYyhmti+DPbu0Eckm5D8ggXx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803213; c=relaxed/simple;
	bh=XmoT4S4JdIVMZtr23c+aR8XcK5SMQ3jZoEi+XhIiW2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XeAPUxg487+olZpZdeQtIT8MRDiPGOJl2onlGDviuUwebVrbVvJ2z+7LotR7k53/RVDWjarAMlKEkReJCRmoH5l+XW3V7pSZ9cFsNnX+MfkWMsE7Dsp9O+LvHSByVHIxtXXioQ+zjqNBl/RVYYRMU/FbLEl2lG7rTP2VASCvMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=c95EjJfG reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=lDEnXlK0hLfT3ZyGBfj4o/lvTRfs6YKzzC3rIrFcW5Y=; b=c
	95EjJfGTQVHZd/RyYtltOpAj4uiN0/Sa84zrKVpdaCoHmBiaGaHizDU2fghJppTu
	Qi5Dv9Wtf8RrFGM1SVk9pOMXwzkmId+7toGu4q0dQTN0rsVB14WCda/V9F9Wkq4d
	FV5O3qTTE4m231juterC052EQAgSpuZJ93Vv/CEbgA=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Tue, 2 Sep 2025 16:53:02 +0800 (CST)
Date: Tue, 2 Sep 2025 16:53:02 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH] net: remove local_bh_enable during busy poll
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250901132330.589f4ac5@kernel.org>
References: <20250829030456.489405-1-lange_tang@163.com>
 <20250901132330.589f4ac5@kernel.org>
X-NTES-SC: AL_Qu2eBPSbvEkj5CSRZ+kfmUgRg+c/XsK4svUj24VVOJF8jDjp+iAMT39DD2nk2eyUMh22vBiXXBFu6dZQUJhoeoQQYkl/RDds6QPpk/x3NISRFg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2e29147c.8583.19909a12fa2.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bygvCgD3H7ZusLZopkkmAA--.2357W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXR28Lmi2q+ZfngADsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzIGZvciB5b3VyIHJlcGx5IQoKSSd2ZSBkb25lIHNvbWUgdGVzdGluZywgcHBzPTM1MDAw
MKOsbmV0LmNvcmUuYnVzeV9yZWFkPTUwLgoKQmVmb3JlIGFwcGx5IHRoaXMgcGF0Y2g6IHVuaGFu
ZGxlZCCh1iA2NDAwL3MKQWZ0ZXIgYXBwbHkgdGhpcyBwYXRjaDogdW5oYW5kbGVkIDwgMTAvcwoK
QXMgeW91IHNhaWQsIHRoZSBkcml2ZXIgbmVlZHMgdG8gZGlzY2VybiBzcHVyaW91cyBpbnRlcnJ1
cHRzIGluIGFib3ZlIGRlc2NyaWJpbmcgc2l0dWF0aW9uLCB3aGljaCBJIHN0cm9uZ2x5IGFncmVl
IHdpdGguIGFuZCBJIGFsc28gdGhpbmsgdGhhdCBpdCdzIG5lY2Vzc2FyeSB0byByZW1vdmUgbG9j
YWxfYmhfZW5hYmxlIGR1cmluZyBidXN5IHBvbGxpbmcsIGFzIGl0IGNhdXNlcyBpbnRlcnJ1cHRz
IHRvIGJlIGVuYWJsZWQgZHVyaW5nIHRoZSBidXN5IHBvbGwuCgpJIHRoaW5rIGZpeCB0aGlzIGlz
c3VlIHJlcXVpcmVzIHR3byBwYXRjaGVzLCBpbiBhZGRpdGlvbiB0byB0aGlzIHBhdGNoLCBhbm90
aGVyIHBhdGNoIGlzIG5lZWRlZCBmcm9tIHRoZSBkcml2ZXIgc2lkZSB0byBkaXNjZXJuIHNwdXJp
b3VzIGludGVycnVwdHMuCgoKCgoKCkF0IDIwMjUtMDktMDIgMDQ6MjM6MzAsICJKYWt1YiBLaWNp
bnNraSIgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBGcmksIDI5IEF1ZyAyMDI1IDExOjA0
OjU2ICswODAwIExvbmdqdW4gVGFuZyB3cm90ZToKPj4gV2hlbiBDT05GSUdfTkVUX1JYX0JVU1lf
UE9MTD09WSBhbmQgbmV0LmNvcmUuYnVzeV9yZWFkID4gMCwKPj4gdGhlIF9fbmFwaV9idXN5X2xv
b3AgZnVuY3Rpb24gY2FsbHMgbmFwaV9wb2xsIHRvIHBlcmZvcm0gYnVzeSBwb2xsaW5nLAo+PiBz
dWNoIGFzIGluIHRoZSBjYXNlIG9mIHZpcnRpb19uZXQncyB2aXJuZXRfcG9sbC4gSWYgaW50ZXJy
dXB0cyBhcmUgZW5hYmxlZAo+PiBkdXJpbmcgdGhlIGJ1c3kgcG9sbGluZyBwcm9jZXNzLCBpdCBp
cyBwb3NzaWJsZSB0aGF0IGRhdGEgaGFzIGFscmVhZHkgYmVlbgo+PiByZWNlaXZlZCBhbmQgdGhh
dCBsYXN0X3VzZWRfaWR4IGlzIHVwZGF0ZWQgYmVmb3JlIHRoZSBpbnRlcnJ1cHQgaXMgaGFuZGxl
ZC4KPj4gVGhpcyBjYW4gbGVhZCB0byB0aGUgdnJpbmdfaW50ZXJydXB0IHJldHVybmluZyBJUlFf
Tk9ORSBpbiByZXNwb25zZSB0byB0aGUKPj4gaW50ZXJydXB0IGJlY2F1c2UgdXNlZF9pZHggPT0g
bGFzdF91c2VkX2lkeCwgd2hpY2ggaXMgY29uc2lkZXJlZCBhIHNwdXJpb3VzCj4+IGludGVycnVw
dC5PbmNlIGNlcnRhaW4gY29uZGl0aW9ucyBhcmUgbWV0LCB0aGlzIGludGVycnVwdCBjYW4gYmUg
ZGlzYWJsZWQuCj4KPkknbSBub3Qgc3VyZSB0aGlzIHBhdGNoIGNvbXBsZXRlbHkgZml4ZXMgdGhl
IGlzc3VlIHlvdSdyZSBkZXNjcmliaW5nLgo+SXQganVzdCBtYWtlcyBpdCBsZXNzIGxpa2VseSB0
byBoYXBwZW4uIFJlYWxseSwgaXQgZmVlbHMgbGlrZSB0aGUgb251cwo+Zm9yIGZpeGluZyB0aGlz
IGlzIG9uIHRoZSBkcml2ZXIgdGhhdCBjYW4ndCBkaXNjZXJuIGl0cyBvd24gSVJRIHNvdXJjZXMu
Cj4tLSAKPnB3LWJvdDogY3IK

