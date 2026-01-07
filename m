Return-Path: <netdev+bounces-247620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B65CFC597
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE613029C3E
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F2225A35;
	Wed,  7 Jan 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lp0B3+kU"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C91D6AA;
	Wed,  7 Jan 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771045; cv=none; b=aImwR624wL/6ppM2lVQCfFBoNfkjOvkVeRMKHdel1OOqTtIxEwLKc50KfHApldNJWw2xMAqCvOQ5lSwG5Z96n+jjPkdtMofgfdXeZYTvighxlj1g58zLl62GFSJXuuLtYlFEhzImBxPBR316Yc4Qtzsbp5BzLBUJpc9LTXByE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771045; c=relaxed/simple;
	bh=wLyagcN9auWDH0AMqrqEQdu5ZjLCXtjXEEOWvWCsyF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=e8XNYLqNO+7um0Oj0cbFw8kJBRaXzhgq/LvpIcSa38IXRmIPoz8Xlx/fr7P/V78jBzDbbj6eYgmrC3F9gy4TT0xi4mfUSv07hdmjKXqOWI/g8jwqu84Jc7J1bxoVrSgQecDt/SbDnDm7e9714rkaswYrTly9fB78jGnzirrAh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lp0B3+kU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=wLyagcN9auWDH0AMqrqEQdu5ZjLCXtjXEEOWvWCsyF0=; b=l
	p0B3+kUA2d8r0bOr2+CSMqDck9P4QA48NGynGxTeZi+k5efGCjiN2t1Q3LHTdPYc
	UOq3YK5tBsMglV5NB6uyxMnnlC97pVFGYyJ1TrKLdenipIEZEJp1qbxIk0NqKHIr
	wyB5Mg9LScSzNfipznbUYjQt2npyxRdAFQ4BKiq6to=
Received: from slark_xiao$163.com (
 [2408:8459:3860:79dc:e48d:3bf1:6788:3ccb] ) by ajax-webmail-wmsvr-40-127
 (Coremail) ; Wed, 7 Jan 2026 15:29:24 +0800 (CST)
Date: Wed, 7 Jan 2026 15:29:24 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, johannes@sipsolutions.net,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mani@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Daniele Palmas" <dnlplm@gmail.com>
Subject: Re:Re: [net-next v4 7/8] net: wwan: prevent premature device
 unregister when NMEA port is present
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <83c51a99-038d-4283-9a39-97129966a500@gmail.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
 <20260105102018.62731-8-slark_xiao@163.com>
 <83c51a99-038d-4283-9a39-97129966a500@gmail.com>
X-NTES-SC: AL_Qu2dBfucv0Et4iGRYekfmk8Sg+84W8K3v/0v1YVQOpF8jA/p8D8rXnZKEETb8uSdCjyerB63dQJQxMhbR6tAWYkJXRrvxDGQzXjOWRxKChVO9g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgBXlypUC15pNeJRAA--.17370W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxTJLmleC1RQ-QAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTA3IDA5OjA2OjA1LCAiU2VyZ2V5IFJ5YXphbm92IiA8cnlhemFub3Yucy5h
QGdtYWlsLmNvbT4gd3JvdGU6Cj5IaSBTbGFyaywgTG9pYywKPgo+c29ycnkgZm9yIGxhdGUgam9p
bmluZyB0aGUgZGlzY3Vzc2lvbiwgcGxlYXNlIGZpbmQgYSBkZXNpZ24gcXVlc3Rpb24gYmVsb3cu
Cj4KPk9uIDEvNS8yNiAxMjoyMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gRnJvbTogTG9pYyBQb3Vs
YWluIDxsb2ljLnBvdWxhaW5Ab3NzLnF1YWxjb21tLmNvbT4KPj4gCj4+IFRoZSBXV0FOIGNvcmUg
dW5yZWdpc3RlcnMgdGhlIGRldmljZSB3aGVuIGl0IGhhcyBubyByZW1haW5pbmcgV1dBTiBvcHMK
Pj4gb3IgY2hpbGQgZGV2aWNlcy4gRm9yIE5NRUEgcG9ydCB0eXBlcywgdGhlIGNoaWxkIGlzIHJl
Z2lzdGVyZWQgdW5kZXIKPj4gdGhlIEdOU1MgY2xhc3MgaW5zdGVhZCBvZiBXV0FOLCBzbyB0aGUg
Y29yZSBpbmNvcnJlY3RseSBhc3N1bWVzIHRoZXJlCj4+IGFyZSBubyBjaGlsZHJlbiBhbmQgdW5y
ZWdpc3RlcnMgdGhlIFdXQU4gZGV2aWNlIHRvbyBlYXJseS4gVGhpcyBsZWFkcwo+PiB0byBhIHNl
Y29uZCB1bnJlZ2lzdGVyIGF0dGVtcHQgYWZ0ZXIgdGhlIE5NRUEgZGV2aWNlIGlzIHJlbW92ZWQu
Cj4+IAo+PiBUbyBmaXggdGhpcyBpc3N1ZSwgd2UgcmVnaXN0ZXIgYSB2aXJ0dWFsIFdXQU4gcG9y
dCBkZXZpY2UgYWxvbmcgdGhlCj4+IEdOU1MgZGV2aWNlLCB0aGlzIGVuc3VyZXMgdGhlIFdXQU4g
ZGV2aWNlIHJlbWFpbnMgcmVnaXN0ZXJlZCB1bnRpbAo+PiBhbGwgYXNzb2NpYXRlZCBwb3J0cywg
aW5jbHVkaW5nIE5NRUEsIGFyZSBwcm9wZXJseSByZW1vdmVkLgo+Cj53d2FuIGNvcmUgYXNzdW1l
cyB3aG9sZSByZXNwb25zaWJpbGl0eSBmb3IgbWFuYWdpbmcgYSBXV0FOIGRldmljZS4gV2UgCj5h
bHJlYWR5IHVzZSB3d2FuX2NyZWF0ZV9kZXYoKS93d2FuX3JlbW92ZV9kZXYoKSBldmVyeXdoZXJl
LiBCdXQsIHdlIGFyZSAKPmNoZWNraW5nIHRoZSByZW1pbmRpbmcgcmVmZXJlbmNlcyBpbiBhbiBp
bXBsaWNpdCB3YXkgdXNpbmcgCj5kZXZpY2VfZm9yX2VhY2hfY2hpbGQoKSBhbmQgcmVnaXN0ZXJl
ZCBPUFMgZXhpc3RlbmNlLiBUaHVzLCB3ZSBuZWVkIHRoaXMgCj50cmljayB3aXRoIGEgdmlydHVh
bCBjaGlsZCBwb3J0Lgo+Cj5Eb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gc3dpdGNoIHRvIGFuIGV4cGxp
Y2l0IHJlZmVyZW5jZSBjb3VudGluZz8gV2UgY2FuIAo+aW50cm9kdWNlIHN1Y2ggY291bnRlciB0
byB0aGUgd3dhbl9kZXZpY2Ugc3RydWN0dXJlLCBhbmQgCj5pbmNyZW1lbnQvZGVjcmVtZW50IGl0
IG9uIGV2ZXJ5IHd3YW5fY3JlYXRlX2RldigpL3d3YW5fcmVtb3ZlX2RldigpIAo+Y2FsbC4gU28s
IHdlIHdpbGwgZG8gZGV2aWNlX3VucmVnaXN0ZXIoKSB1cG9uIHJlZmVyZW5jZSBudW1iZXIgYmVj
b21pbmcgCj56ZXJvLgo+Cj5JZiBpdCBzb3VuZHMgcHJvbWlzaW5nLCBJIGNhbiBzZW5kIGEgUkZD
LCBsZXQncyBzYXksIHRvbW9ycm93LgoKVGhlIFJGQyBvbmx5IGZvciB0aGlzIHBhdGNoIG9yIHRo
ZSBleGlzdGluZyBkZXNpZ24/IFNpbmNlIHRoZXJlIGlzIHByb2JsZW0KcmVwb3J0ZWQgaW7CoGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvcGF0Y2gvMjAyNjAx
MDUxMDIwMTguNjI3MzEtMy1zbGFya194aWFvQDE2My5jb20vIzI2NzIwODI4LgoKQ3VycmVudGx5
IGRlc2lnbjoKwqDCoMKgIG1pbm9yID0gaWRhX2FsbG9jX3JhbmdlKCZtaW5vcnMsIDAsIFdXQU5f
TUFYX01JTk9SUyAtIDEsIEdGUF9LRVJORUwpOwrCoMKgwqAgaWYgKG1pbm9yIDwgMCkKwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIG1pbm9yOwoKwqDCoMKgIHBvcnQtPmRldi5jbGFzcyA9ICZ3d2FuX2Ns
YXNzOwovLyB3aGVuIGNkZXYgaXMgZmFsc2UsIG5vIGRldnQgd2FzIGFzc2lnbmVkLiBCdXQgd3dh
bl9wb3J0X2Rlc3Ryb3koKSB1c2UgZGV2dCB0byBmcmVlCsKgwqDCoCBpZiAoY2RldikKwqDCoMKg
wqDCoMKgwqAgcG9ydC0+ZGV2LmRldnQgPSBNS0RFVih3d2FuX21ham9yLCBtaW5vcik7CgpXZSBu
ZWVkIHRvIGhhdmUgYSB1cGRhdGUgYmFzZWQgb24gdGhpcyBwYXRjaCBpZiB3ZSB3YW50IHRvIHVz
ZSB0aGlzIG9uZSBpbiB0aGlzIHNlcmlhbC4KwqAK

