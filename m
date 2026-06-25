Return-Path: <netdev+bounces-301818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6cI6FH2EPGoGpAgAu9opvQ
	(envelope-from <netdev+bounces-301818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:29:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7196C2255
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="U +6Z1LO";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 586C430194B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F336F903;
	Thu, 25 Jun 2026 01:29:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42772622
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:29:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350969; cv=none; b=ZpVe2UWvatoNXkxheVQ5UFfeMT0RCwJRJSWSEQHXfgq5ypGFX+Im4ke/Jj4ZvQ57GUPZVbIFnC+53lCzh4+JY81cEoDRcPRocrNEJj/ntso/+9uDK4roRRvn90lX56C+So6Ka2kcGENXG/AVF5pqNBiSCsl+AtqUjfxtetX7Ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350969; c=relaxed/simple;
	bh=UqZwpZ26Eb5HYrrXHU4/HDB7pkosw+GCzJ4X6GzSJCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pwBWzR3YMVfgd2bx7JX+l0z+dCxfs6Dazs70Z/MEilj4ueX+Be/cQa23dLf6YXxJ3/1HCCYXPt6pUS17mlJKOqeY1lSeHjucD36mvPDHQ2cz+Mkj90uiZ3yL9vLaS8QoLIbVBCCYgwCG29FoTWJSduwVG548bhzBZh+mptgCwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U+6Z1LOK; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=UqZwpZ26Eb5HYrrXHU4/HDB7pkosw+GCzJ4X6GzSJCM=; b=U
	+6Z1LOK/Hhhfgmia72QA9dGhFX+9r62oZxMhOgBzq5x3B+1PPwtH97cD1tt0mOhd
	WXaYu40bLc339QScpqOKlH2Ybm//sf4MX7qhWP1NnbiTqGdexHW9t3pdiwgJFG9n
	mEMhM+lItoOMPLYdZGHAPCzltCB9frsMuKWzQawICQ=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Thu, 25 Jun 2026 09:28:59 +0800
 (CST)
Date: Thu, 25 Jun 2026 09:28:59 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH v3] virtio_net: disable cb when NAPI is busy-polled
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260624030656-mutt-send-email-mst@kernel.org>
References: <20260624070206.85467-1-lange_tang@163.com>
 <20260624030656-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2TAP+ev0Eo7yifYukcn08QhOo9Wsu0v/0u1YRQc80EszHAxCE5YXhfA3Tk0s+tCT2UrRepTj1XzMZ2WapSzWbwq86oiN1BRV8zbLbn3w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <60045f90.11cf.19efc6506ed.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fSgvCgDnBz1chDxqLR8QAA--.344W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RzhEGo8hFwQlwAA3F
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD7196C2255

QXQgMjAyNi0wNi0yNCAxNTowODoyNCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPk9uIFdlZCwgSnVuIDI0LCAyMDI2IGF0IDAzOjAyOjA2UE0gKzA4MDAsIExv
bmdqdW4gVGFuZyB3cm90ZToKPj4gRnJvbTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBreWxp
bm9zLmNuPgo+PiAKPj4gV2hlbiBidXN5LXBvbGwgaXMgYWN0aXZlLCBuYXBpX3NjaGVkdWxlX3By
ZXAoKSByZXR1cm5zIGZhbHNlIGluCj4+IHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKCksIHNvIHZp
cnRxdWV1ZV9kaXNhYmxlX2NiKCkgaXMgc2tpcHBlZC4KPj4gVGhlIGRldmljZSBtYXkga2VlcCBm
aXJpbmcgaXJxcyB1bnRpbCByZWFjaGVzIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKCkuCj4+IFVu
ZGVyIGxvYWQgKHJlY2VpdmVkID09IGJ1ZGdldCksIGl0IHdpbGwgbGVhZCB0byBhIGxhcmdlIG51
bWJlcgo+PiBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+PiAKPj4gRml4IGl0IGJ5IGRpc2FibGlu
ZyB0aGUgY2FsbGJhY2sgYXQgdGhlIHZpcnRuZXRfcG9sbCgpIGVudHJ5LiBUaGlzIGtlZXBzCj4+
IHRoZSBjYWxsYmFjayBvZmYgd2hpbGUgd2UgcG9sbCBhbmQgcmUtZW5hYmxlCj4KPmFuZCBpdCBp
cyByZS1lbmFibGVkCj4KPj4gYnkgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoKQo+PiB3aGVuIGdv
aW5nIGlkbGUuCj4+IAo+PiBGaXhlczogY2VlZjQzOGQ2MTNmICgidmlydGlvX25ldDogcmVtb3Zl
IGN1c3RvbSBidXN5X3BvbGwiKQo+PiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBr
eWxpbm9zLmNuPgo+PiAKPj4gLS0tCj4+IFYxIC0+IFYyOiBSZW1haW4gYWdub3N0aWMgdG8gYnVz
eSBwb2xsaW5nCj4+IFYyIC0+IFYzOiBBZGQgZml4ZXMgdGFnCj4+IC0tLQo+PiAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgNSArKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+PiBpbmRleCBmNGFkY2ZlZTdhODAuLjBhMTFmMmIzMjUwMCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+PiBAQCAtMzAwOCw2ICszMDA4LDExIEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPj4gIAl1bnNp
Z25lZCBpbnQgeGRwX3htaXQgPSAwOwo+PiAgCWJvb2wgbmFwaV9jb21wbGV0ZTsKPj4gIAo+PiAr
CS8qIEtlZXAgY2FsbGJhY2tzIHN1cHByZXNzZWQgZm9yIHRoZSBkdXJhdGlvbiBvZiB0aGlzIHBv
bGwsCj4+ICsJICogYnVzeS1wb2xsIG5lZWQuCj4KPkkgZG9uJ3Qga25vdyB3aGF0ICJidXN5LXBv
bGwgbmVlZCIgbWVhbnMuIEp1c3QgZHJvcCB0aGlzIHBhcnQ/Cj5JbiBmYWN0LCB0aGUgd2hvbGUg
Y29tbWVudCBjYW4gZ28sIHdlIGtub3cgdmlydHF1ZXVlX2Rpc2FibGVfY2IKPmRpc2FibGVzIGNh
bGxiYWNrcy4KClRoYW5rcyBmb3IgeW91ciByZXBseS4gIEkgZ290IGl0LCBzZWUgeW91IG5leHQg
dmVyc2lvbi4KPgo+PiArCSAqLwo+PiArCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHJxLT52cSk7Cj4+
ICsKPj4gIAl2aXJ0bmV0X3BvbGxfY2xlYW50eChycSwgYnVkZ2V0KTsKPj4gIAo+PiAgCXJlY2Vp
dmVkID0gdmlydG5ldF9yZWNlaXZlKHJxLCBidWRnZXQsICZ4ZHBfeG1pdCk7Cj4+IC0tIAo+PiAy
LjQzLjAK

