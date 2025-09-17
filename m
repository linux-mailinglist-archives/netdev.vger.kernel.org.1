Return-Path: <netdev+bounces-223856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179CB7C8A8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0369E520AE8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09726B2AD;
	Wed, 17 Sep 2025 04:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DA2367AC;
	Wed, 17 Sep 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085182; cv=none; b=AnH4wgT1+00xqzmymmj2hFP2vrDVB+w35HHBEHjV1CP9FKfkNbPE65HFyh3raRI0QdTMvkvcdKi9uhe3IWYhgL4mBbU2Y5V2PRQ4VHMT/TgXOV9CSA/011ryKsvZ1T1JCjWMH7lMciymONneIHObr2Ij1b8mor0qOt3NPabp3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085182; c=relaxed/simple;
	bh=xkA6wZgKsXKRGndcmhrcGrRKpM4Brxpl84gHv/Zw7j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=flOJVwxavZw0lnahzJz3a4EGNnWBXIDmSoyPQ9l9cP4L6KptKefv+0iE41U7E2Xp2M8KuBYcE3sBx7SHVaGN7ZWqZX73KruWnFSBDG6AHg8bcDlrIBegm/D4zOZwdOlZ6YJ7khO0pJrzGq9+BVAJxMnsCfDE84h/sjJQYwJ5qzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.98.100])
	by mtasvr (Coremail) with SMTP id _____wD34GoeQMpoVmpCAg--.11506S3;
	Wed, 17 Sep 2025 12:59:11 +0800 (CST)
Received: from duoming$zju.edu.cn ( [106.117.98.100] ) by
 ajax-webmail-mail-app3 (Coremail) ; Wed, 17 Sep 2025 12:59:10 +0800
 (GMT+08:00)
Date: Wed, 17 Sep 2025 12:59:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	bbhushan2@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Fix use-after-free bugs in
 otx2_sync_tstamp()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <20250916163643.36dd866a@kernel.org>
References: <20250915130136.42586-1-duoming@zju.edu.cn>
 <20250916163643.36dd866a@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <564ad9c5.8bb9.199560a7661.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zS_KCgAnJ2oeQMpoADGrAg--.59716W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQMAWjJvXsG9gAAsd
X-CM-DELIVERINFO: =?B?SXSRGAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR131FE3wBtlILXmPZxD8pDyD/yWQ0Q2ektRbG9ON7jma6UkNjHoVbwjKChRsPfdRZy6vf
	IiamH4K0mU4dDBtRwT2BGkAGFw8R/UopGNMkGBoKxsKyXLdfSZ96xjQaLMcoqA==
X-Coremail-Antispam: 1Uk129KBj93XoW7uF15tw4DCw1rAFWfGrWDKFX_yoW8JF4kpr
	Wru34UJFZ7AF4xGrWftw4Fq3WIgr4kt345CF45Xr4xC395JFy29FWfKayF93Wjgrs7Zry2
	v3srZa95ZF90kFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAC
	I402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07j8GYJUUUUU=

T24gVHVlLCAxNiBTZXAgMjAyNSAxNjozNjo0MyAtMDcwMCBKYWt1YiBLaWNpbnNraSB3cm90ZToK
PiA+IFJlcGxhY2UgY2FuY2VsX2RlbGF5ZWRfd29yaygpIHdpdGggY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCkgdG8gZW5zdXJlCj4gPiB0aGF0IHRoZSBkZWxheWVkIHdvcmsgaXRlbSBpcyBwcm9w
ZXJseSBjYW5jZWxlZCBiZWZvcmUgdGhlIG90eDJfcHRwIGlzCj4gPiBkZWFsbG9jYXRlZC4KPiAK
PiBQbGVhc2UgYWRkIGluZm8gYWJvdXQgaG93IHRoZSBidWcgd2FzIGRpc2NvdmVyZWQgYW5kIGZp
eCB0ZXN0ZWQsIHNhbWUKPiBhcyB0aGUgY25pYyBwYXRjaC4KClRoYW5rIHlvdSBmb3IgeW91ciBz
dWdnZXN0aW9ucy4gVGhpcyBidWcgd2FzIGluaXRpYWxseSBpZGVudGlmaWVkIHRocm91Z2gKc3Rh
dGljIGFuYWx5c2lzLiBUbyByZXByb2R1Y2UgYW5kIHRlc3QgaXQsIEkgc2ltdWxhdGVkIHRoZSBP
Y3Rlb25UWDIgUENJCmRldmljZSBpbiBRRU1VIGFuZCBpbnRyb2R1Y2VkIGFydGlmaWNpYWwgZGVs
YXlzIOKAlCBzdWNoIGFzIGFkZGluZyBjYWxscyB0bwpzc2xlZXAoKcKgd2l0aGluIHRoZcKgb3R4
Ml9zeW5jX3RzdGFtcCgpwqBmdW5jdGlvbiDigJQgdG8gaW5jcmVhc2UgdGhlIHByb2JhYmlsaXR5
Cm9mIHRyaWdnZXJpbmcgdGhlIGlzc3VlLgoKVGhlwqBvdHgyX3N5bmNfdHN0YW1wKCnCoGZ1bmN0
aW9uIG9wZXJhdGVzIGFzIGEgY3ljbGljIHdvcmsgaXRlbS4gClRoZcKgY2FuY2VsX2RlbGF5ZWRf
d29ya19zeW5jKCnCoGZ1bmN0aW9uIHdvcmtzIGJ5IGNhbGxpbmfCoApfX2NhbmNlbF93b3JrKHdv
cmssIC4uLiB8IFdPUktfQ0FOQ0VMX0RJU0FCTEUpLCB3aGljaCBhdHRlbXB0cyB0byAKcmVtb3Zl
IHRoZSB3b3JrIGl0ZW0gZnJvbSB0aGUgcXVldWUgYW5kIHNldHMgdGhlwqBXT1JLX0NBTkNFTF9E
SVNBQkxFwqAKZmxhZyB0byBwcmV2ZW50IHRoZSB3b3JrIGl0ZW0gZnJvbSBiZWluZyBleGVjdXRl
ZCBhZ2Fpbi4gQXQgdGhlIHNhbWUgCnRpbWUsIGl0IHVzZXPCoF9fZmx1c2hfd29yayh3b3JrLCB0
cnVlKcKgdG8gcGVyZm9ybSBhIHN5bmNocm9ub3VzIHdhaXQgCmZvciBhbnkgY3VycmVudGx5IGV4
ZWN1dGluZyBpbnN0YW5jZSBvZiB0aGUgd29yayBpdGVtIHRvIGZpbmlzaCBydW5uaW5nLgoKSSB3
aWxsIGFkZCBpbmZvIGFib3V0IGhvdyB0aGUgYnVnIHdhcyBkaXNjb3ZlcmVkIGFuZCBmaXggdGVz
dGVkIGluIHBhdGNoIHYyLgoKQmVzdCByZWdhcmRzLApEdW9taW5nIFpob3UK


