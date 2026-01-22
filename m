Return-Path: <netdev+bounces-252153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ApkgI6mUcWngJgAAu9opvQ
	(envelope-from <netdev+bounces-252153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:08:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F8B61277
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE3943E97B9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D363933EB;
	Thu, 22 Jan 2026 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Voi9F3fZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A512836BE;
	Thu, 22 Jan 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051299; cv=none; b=b0COua8BY7MkBi5EvWeSHy1gZ81m46oOgqD8ZJ2F/wXGISDFaHrgodZF54yCMslnTD+6swyChI1/rOGnniGDcsDyxFDK0mrHyCrenTvlEUaYSBwpPV38zCvK9BgJiUB7pgQ28DvDvCJyXtVLd5tAa6PyaGGpxR+eU0DkvBirKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051299; c=relaxed/simple;
	bh=dKdW9aMkW5hRQWcvZdIKCjeswgrLWbdRo5VVmxdqExo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rXPyNuZiIz1BXSwzj/ZTtUcFKhUJhq+wat87dVEzSQKa78DAOFuBYXJVFT6dbDGC733SskpMegTqW1bGHFmT4rwUocq0CuJ2QTh8q+Mg/ZlYxtZp6yXnoaIop3w+jbBkim87H9PFG+GsVYpxyWBYCyGjW7hqHkmWYUMboubXh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Voi9F3fZ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=dKdW9aMkW5hRQWcvZdIKCjeswgrLWbdRo5VVmxdqExo=; b=V
	oi9F3fZexRyKNCrDvOvY6Hc6K1YZJH2zbZikvWRn0tRlUZEVt3PHwLtarycpUtug
	q0qRwKupEruxlgotvtSslRcQse5Rd/cQJoxrhpasmQgmk4+XASdOsA/yQD/px7u4
	/uPb3nyk+C1jq3iIGrdOueoglzzWlbS3blPDqbvIaE=
Received: from slark_xiao$163.com (
 [2409:895b:3874:c9a2:e8a9:6c3d:52dc:d224] ) by ajax-webmail-wmsvr-40-135
 (Coremail) ; Thu, 22 Jan 2026 11:06:33 +0800 (CST)
Date: Thu, 22 Jan 2026 11:06:33 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>,
	"Sergey Ryazanov" <ryazanov.s.a@gmail.com>,
	"Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: quic_qianyu@quicinc.com, davem@davemloft.net,
	loic.poulain@oss.qualcomm.com, johannes@sipsolutions.net,
	netdev@vger.kernel.org, zaihan@unrealasia.net, johan@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	linux-kernel@vger.kernel.org, dnlplm@gmail.com,
	manivannan.sadhasivam@linaro.org, pabeni@redhat.com, mani@kernel.org,
	ryazanov.s.a@gmail.com
Subject: Re:Re: [net-next,v7,7/8] net: wwan: hwsim: support NMEA port
 emulation
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260116024441.347826-1-kuba@kernel.org>
References: <20260115114625.46991-8-slark_xiao@163.com>
 <20260116024441.347826-1-kuba@kernel.org>
X-NTES-SC: AL_Qu2dC/yevkki5SCaZekfmk8Sg+84W8K3v/0v1YVQOpF8jB7owS0ObV9oIlruycGEACW+qQmsdD9S5M5TbZBxQYUoKdtmJRiNoDYkS+jwtJCXlw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <273e24af.2e77.19be3aafec9.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3X4w5lHFpXGRcAA--.13212W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xnpTmlxlDnQgQAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-252153-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[quicinc.com,davemloft.net,oss.qualcomm.com,sipsolutions.net,vger.kernel.org,unrealasia.net,kernel.org,lunn.ch,google.com,gmail.com,linaro.org,redhat.com];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	DKIM_TRACE(0.00)[163.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 07F8B61277
X-Rspamd-Action: no action

CkF0IDIwMjYtMDEtMTYgMTA6NDQ6NDEsICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5UaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZpZXcgb2YgeW91ciBwYXRjaC4g
VGhlIGh1bWFuIHNlbmRpbmcgdGhpcwo+ZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmll
dyB2YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLgo+Cj5Gb3IgbG9jYWwgcmVwcm9kdWN0aW9u
IHN0ZXBzIHNlZSBodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9haS1sb2NhbC5odG1s
Cj4tLS0KPm5ldDogd3dhbjogaHdzaW06IHN1cHBvcnQgTk1FQSBwb3J0IGVtdWxhdGlvbgo+Cj5U
aGlzIGNvbW1pdCBhZGRzIE5NRUEgcG9ydCBlbXVsYXRpb24gdG8gdGhlIFdXQU4gaGFyZHdhcmUg
c2ltdWxhdG9yIGZvcgo+R05TUyBwb3J0IHRlc3RpbmcuIFRoZSBlbXVsYXRvciBnZW5lcmF0ZXMg
R0dBIGFuZCBSTUMgc2VudGVuY2VzIGV2ZXJ5Cj5zZWNvbmQgdmlhIGEgdGltZXIgY2FsbGJhY2su
Cj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jIGIvZHJpdmVy
cy9uZXQvd3dhbi93d2FuX2h3c2ltLmMKPj4gaW5kZXggMTFkMTVkYzM5MDQxLi5lNGIxYmJmZjlh
ZjIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jCj4+ICsrKyBi
L2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jCj4KPlsgLi4uIF0KPgo+PiArI2lmIElTX0VO
QUJMRUQoQ09ORklHX0dOU1MpCj4+ICsjZGVmaW5lIE5NRUFfTUFYX0xFTgkJODIJLyogTWF4IHNl
bnRlbmNlIGxlbmd0aCAqLwo+PiArI2RlZmluZSBOTUVBX1RSQUlMX0xFTgkJNQkvKiAnKicgKyBD
aGVja3N1bSArIDxDUj48TEY+ICovCj4+ICsjZGVmaW5lIE5NRUFfTUFYX0RBVEFfTEVOCShOTUVB
X01BWF9MRU4gLSBOTUVBX1RSQUlMX0xFTikKPj4gKwo+PiArc3RhdGljIF9fcHJpbnRmKDIsIDMp
Cj4+ICt2b2lkIHd3YW5faHdzaW1fbm1lYV9za2JfcHVzaF9zZW50ZW5jZShzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLAo+PiArCQkJCSAgICAgICBjb25zdCBjaGFyICpmbXQsIC4uLikKPj4gK3sKPj4gKwl1
bnNpZ25lZCBjaGFyICpzLCAqcDsKPj4gKwl2YV9saXN0IGFwOwo+PiArCXU4IGNzID0gMDsKPj4g
KwlpbnQgbGVuOwo+PiArCj4+ICsJcyA9IHNrYl9wdXQoc2tiLCBOTUVBX01BWF9MRU4gKyAxKTsJ
LyogKydcMCcgKi8KPgo+WyAuLi4gXQo+Cj4+ICtzdGF0aWMgdm9pZCB3d2FuX2h3c2ltX25tZWFf
ZW11bF90aW1lcihzdHJ1Y3QgdGltZXJfbGlzdCAqdCkKPj4gK3sKPj4gKwkvKiA0My43NDc1NDcy
MjI5ODkwOSBOIDExLjI1NzU5ODM1OTIyODc1IEUgaW4gRE1NIGZvcm1hdCAqLwo+PiArCXN0YXRp
YyBjb25zdCB1bnNpZ25lZCBpbnQgY29vcmRbNCAqIDJdID0geyA0MywgNDQsIDg1MjgsIDAsCj4+
ICsJCQkJCQkgICAxMSwgMTUsIDQ1NTksIDAgfTsKPj4gKwlzdHJ1Y3Qgd3dhbl9od3NpbV9wb3J0
ICpwb3J0ID0gdGltZXJfY29udGFpbmVyX29mKHBvcnQsIHQsIG5tZWFfZW11bC50aW1lcik7Cj4+
ICsJc3RydWN0IHNrX2J1ZmYgKnNrYjsKPj4gKwlzdHJ1Y3QgdG0gdG07Cj4+ICsKPj4gKwl0aW1l
NjRfdG9fdG0oa3RpbWVfZ2V0X3JlYWxfc2Vjb25kcygpLCAwLCAmdG0pOwo+PiArCj4+ICsJbW9k
X3RpbWVyKCZwb3J0LT5ubWVhX2VtdWwudGltZXIsIGppZmZpZXMgKyBIWik7CS8qIDEgc2Vjb25k
ICovCj4+ICsKPj4gKwlza2IgPSBhbGxvY19za2IoTk1FQV9NQVhfTEVOICogMiwgR0ZQX0tFUk5F
TCk7CS8qIEdHQSArIFJNQyAqLwo+ICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5e
XiAgICAgXl5eXl5eXl5eXgo+CkhpIFNlcmdleSwgTG9pYywKTGV0J3MgdXBkYXRlIGl0IGFzIDoK
Kwlza2IgPSBhbGxvY19za2IoTk1FQV9NQVhfTEVOICogMisyLCBHRlBfQVRPTUlDKTsJLyogR0dB
ICsgUk1DICovCgpIb3cgZG8geW91IHRoaW5rPwoKCj5Ud28gcXVlc3Rpb25zIGFib3V0IHRoaXMg
YWxsb2NhdGlvbjoKPgo+MS4gVGhlIGJ1ZmZlciBzaXplIGFwcGVhcnMgdG8gYmUgaW5zdWZmaWNp
ZW50LiBUaGUgYWxsb2NhdGlvbiByZXF1ZXN0cwo+Tk1FQV9NQVhfTEVOICogMiA9IDE2NCBieXRl
cywgYnV0IHd3YW5faHdzaW1fbm1lYV9za2JfcHVzaF9zZW50ZW5jZSgpCj5pcyBjYWxsZWQgdHdp
Y2UgYW5kIGVhY2ggY2FsbCB1c2VzIHNrYl9wdXQoc2tiLCBOTUVBX01BWF9MRU4gKyAxKSB3aGlj
aAo+cmVzZXJ2ZXMgODMgYnl0ZXMgcGVyIHNlbnRlbmNlLiBUaGUgdG90YWwgbmVlZGVkIGlzIDE2
NiBieXRlcywgd2hpY2gKPmV4Y2VlZHMgdGhlIDE2NCBieXRlcyBhbGxvY2F0ZWQuIFdvdWxkIHRo
aXMgY2F1c2Ugc2tiX292ZXJfcGFuaWMoKSB0bwo+dHJpZ2dlciBvbiB0aGUgc2Vjb25kIHNrYl9w
dXQoKSBjYWxsPwo+Cj4yLiBUaGlzIGZ1bmN0aW9uIGlzIGEgdGltZXIgY2FsbGJhY2sgcmVnaXN0
ZXJlZCB2aWEgdGltZXJfc2V0dXAoKSBpbgo+d3dhbl9od3NpbV9ubWVhX2VtdWxfc3RhcnQoKS4g
VGltZXIgY2FsbGJhY2tzIHJ1biBpbiBzb2Z0aXJxIGNvbnRleHQKPndoZXJlIHNsZWVwaW5nIGlz
IG5vdCBwZXJtaXR0ZWQuIEdGUF9LRVJORUwgYWxsb2NhdGlvbnMgY2FuIHNsZWVwIHdoZW4KPm1l
bW9yeSBwcmVzc3VyZSB0cmlnZ2VycyByZWNsYWltLiBTaG91bGQgdGhpcyBiZSBHRlBfQVRPTUlD
IGluc3RlYWQgdG8KPmF2b2lkICJzY2hlZHVsaW5nIHdoaWxlIGF0b21pYyIgd2FybmluZ3M/Cj4K
Pj4gKwlpZiAoIXNrYikKPj4gKwkJcmV0dXJuOwo+PiArCj4+ICsJd3dhbl9od3NpbV9ubWVhX3Nr
Yl9wdXNoX3NlbnRlbmNlKHNrYiwKPj4gKwkJCQkJICAiJEdQR0dBLCUwMnUlMDJ1JTAydS4wMDAs
JTAydSUwMnUuJTA0dSwlYywlMDN1JTAydS4lMDR1LCVjLDEsNywxLjAzLDE3Ni4yLE0sNTUuMixN
LCwiLAo+PiArCQkJCQkgIHRtLnRtX2hvdXIsIHRtLnRtX21pbiwgdG0udG1fc2VjLAo+PiArCQkJ
CQkgIGNvb3JkWzBdLCBjb29yZFsxXSwgY29vcmRbMl0sCj4+ICsJCQkJCSAgY29vcmRbM10gPyAn
UycgOiAnTicsCj4+ICsJCQkJCSAgY29vcmRbNF0sIGNvb3JkWzVdLCBjb29yZFs2XSwKPj4gKwkJ
CQkJICBjb29yZFs3XSA/ICdXJyA6ICdFJyk7Cj4+ICsKPj4gKwl3d2FuX2h3c2ltX25tZWFfc2ti
X3B1c2hfc2VudGVuY2Uoc2tiLAo+PiArCQkJCQkgICIkR1BSTUMsJTAydSUwMnUlMDJ1LjAwMCxB
LCUwMnUlMDJ1LiUwNHUsJWMsJTAzdSUwMnUuJTA0dSwlYywwLjAyLDMxLjY2LCUwMnUlMDJ1JTAy
dSwsLEEiLAo+PiArCQkJCQkgIHRtLnRtX2hvdXIsIHRtLnRtX21pbiwgdG0udG1fc2VjLAo+PiAr
CQkJCQkgIGNvb3JkWzBdLCBjb29yZFsxXSwgY29vcmRbMl0sCj4+ICsJCQkJCSAgY29vcmRbM10g
PyAnUycgOiAnTicsCj4+ICsJCQkJCSAgY29vcmRbNF0sIGNvb3JkWzVdLCBjb29yZFs2XSwKPj4g
KwkJCQkJICBjb29yZFs3XSA/ICdXJyA6ICdFJywKPj4gKwkJCQkJICB0bS50bV9tZGF5LCB0bS50
bV9tb24gKyAxLAo+PiArCQkJCQkgICh1bnNpZ25lZCBpbnQpdG0udG1feWVhciAtIDEwMCk7Cj4+
ICsKPj4gKwl3d2FuX3BvcnRfcngocG9ydC0+d3dhbiwgc2tiKTsKPj4gK30KPgo+WyAuLi4gXQo=


