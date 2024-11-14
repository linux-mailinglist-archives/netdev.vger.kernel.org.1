Return-Path: <netdev+bounces-144811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775109C8787
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF801F21F0E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831731FF600;
	Thu, 14 Nov 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ZxtRjLdW"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70241FF7A5;
	Thu, 14 Nov 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579604; cv=none; b=XxioMupGNrkmVHw8WnCyHj2U3DXl0hkjWQyzU23RgVjxCkAqmj0h9fsbkAHczLBQ7YhSNLtpblaAbl6mMD0tSBhBcAsYn5cjC1SE1FGp06F+nD1efWuiLZJhw3x+5kPriWpXC0vKUcJcORC/xMvj4aGWVEJLmKR6gGAiqEM2vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579604; c=relaxed/simple;
	bh=T9MOKMhMLZp9/wLwCovRSnGb/6bqj0NzuswbvjubVD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FeJx9UFCZ2tujo5L+hDu95Zs8JLNokWUqxKvj4pCcrNEXEsh3/7WUnUvueU54UCYX8f5rZASyk4ZvKT3Ub3Pb3rKJSarA3Jrz8Fq31WtuxDeP8LXww1xlEDlh/z2juKdfHxOR4PyqM44F/8RynE1dUcI4+Zj2CwO5IDmLH3Btpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ZxtRjLdW reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=imDIG354HXXyW9aAYPK92UMoL0TanLrHN8vw4Nrw9BU=; b=Z
	xtRjLdWRNdB1viPvt0clEYZzsnxaU0i6HHwFAdeKeGzyuXCNrPFl4XtkRBJ72boJ
	MByYLIKrKcEtXj6vwezOeOKMz079Ul+ESB9T3G9Aj6mdNdoZA3ec6LKJGxDAdiI+
	2zp4yffEH9x8s5T4GiyUZaVhUYgbAIqm9SJ+m1gLYM=
Received: from 00107082$163.com ( [111.35.191.191] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Thu, 14 Nov 2024 18:19:27 +0800
 (CST)
Date: Thu, 14 Nov 2024 18:19:27 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4/proc: Avoid usage for seq_printf() when
 reading /proc/net/snmp
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <406c545e-8c00-406a-98f0-0e545c427b25@redhat.com>
References: <20241111045623.10229-1-00107082@163.com>
 <406c545e-8c00-406a-98f0-0e545c427b25@redhat.com>
X-NTES-SC: AL_Qu2YA/mctk0t4SObZukXn0oTju85XMCzuv8j3YJeN500uCTo1SQ7cm9xHF/0+s6kCymhoAiRfBJQzsBob6pgeYn2JpyS9o8Hk/XIHGDAdbTn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5db8d6bc.9fe1.1932a2f5ce9.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3X6SwzjVnj_ImAA--.43762W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQmXqmc1u4ZyjgAKsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTEtMTQgMTc6MzA6MzQsICJQYW9sbyBBYmVuaSIgPHBhYmVuaUByZWRoYXQuY29t
PiB3cm90ZToKPk9uIDExLzExLzI0IDA1OjU2LCBEYXZpZCBXYW5nIHdyb3RlOgo+PiBzZXFfcHJp
bnRmKCkgaXMgY29zdHksIHdoZW4gcmVhZGluZyAvcHJvYy9uZXQvc25tcCwgcHJvZmlsaW5nIGlu
ZGljYXRlcwo+PiBzZXFfcHJpbnRmKCkgdGFrZXMgbW9yZSB0aGFuIDUwJSBzYW1wbGVzIG9mIHNu
bXBfc2VxX3Nob3coKToKPj4gCXNubXBfc2VxX3Nob3coOTcuNzUxJSAxNTg3MjIvMTYyMzczKQo+
PiAJICAgIHNubXBfc2VxX3Nob3dfdGNwX3VkcC5pc3JhLjAoNDAuMDE3JSA2MzUxNS8xNTg3MjIp
Cj4+IAkJc2VxX3ByaW50Zig4My40NTElIDUzMDA0LzYzNTE1KQo+PiAJCXNlcV93cml0ZSgxLjE3
MCUgNzQzLzYzNTE1KQo+PiAJCV9maW5kX25leHRfYml0KDAuNzI3JSA0NjIvNjM1MTUpCj4+IAkJ
Li4uCj4+IAkgICAgc2VxX3ByaW50ZigyNC43NjIlIDM5MzAzLzE1ODcyMikKPj4gCSAgICBzbm1w
X3NlcV9zaG93X2lwc3RhdHMuaXNyYS4wKDIxLjQ4NyUgMzQxMDQvMTU4NzIyKQo+PiAJCXNlcV9w
cmludGYoODUuNzg4JSAyOTI1Ny8zNDEwNCkKPj4gCQlfZmluZF9uZXh0X2JpdCgwLjMzMSUgMTEz
LzM0MTA0KQo+PiAJCXNlcV93cml0ZSgwLjIzNSUgODAvMzQxMDQpCj4+IAkJLi4uCj4+IAkgICAg
aWNtcG1zZ19wdXQoNy4yMzUlIDExNDgzLzE1ODcyMikKPj4gCQlzZXFfcHJpbnRmKDQxLjcxNCUg
NDc5MC8xMTQ4MykKPj4gCQlzZXFfd3JpdGUoMi42MzAlIDMwMi8xMTQ4MykKPj4gCQkuLi4KPj4g
VGltZSBmb3IgYSBtaWxsaW9uIHJvdW5kcyBvZiBzdHJlc3MgcmVhZGluZyAvcHJvYy9uZXQvc25t
cDoKPj4gCXJlYWwJMG0yNC4zMjNzCj4+IAl1c2VyCTBtMC4yOTNzCj4+IAlzeXMJMG0yMy42Nzlz
Cj4+IE9uIGF2ZXJhZ2UsIHJlYWRpbmcgL3Byb2MvbmV0L3NubXAgdGFrZXMgMC4wMjNtcy4KPj4g
V2l0aCB0aGlzIHBhdGNoLCBleHRyYSBjb3N0cyBvZiBzZXFfcHJpbnRmKCkgaXMgYXZvaWRlZCwg
YW5kIGEgbWlsbGlvbgo+PiByb3VuZHMgb2YgcmVhZGluZyAvcHJvYy9uZXQvc25tcCBub3cgdGFr
ZXMgb25seSB+MTUuODUzczoKPj4gCXJlYWwJMG0xNi4zODZzCj4+IAl1c2VyCTBtMC4yODBzCj4+
IAlzeXMJMG0xNS44NTNzCj4+IE9uIGF2ZXJhZ2UsIG9uZSByZWFkIHRha2VzIDAuMDE1bXMsIGEg
fjQwJSBpbXByb3ZlbWVudC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3
MDgyQDE2My5jb20+Cj4KPklmIHRoZSB1c2VyIHNwYWNlIGlzIHJlYWxseSBjb25jZXJuZWQgd2l0
aCBzbm1wIGFjY2VzcyBwZXJmb3JtYW5jZXMsIEkKPnRoaW5rIHN1Y2ggaW5mb3JtYXRpb24gc2hv
dWxkIGJlIGV4cG9zZWQgdmlhIG5ldGxpbmsuCj4KPlN0aWxsIHRoZSBnb2FsIG9mIHRoZSBvcHRp
bWl6YXRpb24gbG9va3MgZG91YnRmdWwuIFRoZSB0b3RhbCBudW1iZXIgb2YKPm1pYnMgZG9tYWlu
IGlzIGNvbnN0YW50IGFuZCBsaW1pdGVkIChkaWZmZXJlbnRseSBmcm9tIHRoZSBuZXR3b3JrCj5k
ZXZpY2VzIG51bWJlciB0aGF0IGluIHNwZWNpZmljIHNldHVwIGNhbiBncm93IGEgbG90KS4gU3Rh
dHMgcG9sbGluZwo+c2hvdWxkIGJlIGEgbG93IGZyZXF1ZW5jeSBvcGVyYXRpb24uIFdoeSB5b3Ug
bmVlZCB0byBvcHRpbWl6ZSBpdD8KCldlbGwsIG9uZSB0aGluZyBJIHRoaW5rIHdvcnRoIG1lbnRp
b24sIG9wdGltaXplIC9wcm9jIGVudHJpZXMgY2FuIGhlbHAKaW5jcmVhc2Ugc2FtcGxlIGZyZXF1
ZW5jeSwgaGVuY2UgbW9yZSBhY2N1cmF0ZSByYXRlIGFuYWx5c2lzLAogZm9yIG1vbml0b3Jpbmcg
dG9vbHMgd2l0aCBhIGZpeGVkL2xpbWl0ZWQgY3B1IHF1b3RhLgoKQW5kIGZvciAvcHJvYy9uZXQv
KiwgdGhlIG9wdGltaXphdGlvbiB3b3VsZCBiZSBhbXBsaWZpZWQgd2hlbiBjb25zaWRlcmluZyBu
ZXR3b3JrIG5hbWVzcGFjZXMuCgpJIHRoaW5rIGl0IHdvcnRoIHRvIG9wdGltaXplLiAgIAoKPgo+
SSBkb24ndCB0aGluayB3ZSBzaG91bGQgYWNjZXB0IHRoaXMgY2hhbmdlLCB0b28uIEFuZCBhIHNv
bGlkIGV4cGxhbmF0aW9uCj5zaG91bGQgYmUgbmVlZCB0byBpbnRyb2R1Y2UgYSBuZXRsaW5rIE1J
QiBpbnRlcmZhY2UuCj4KPj4gLS0tCj4+ICBuZXQvaXB2NC9wcm9jLmMgfCAxMTYgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPkZUUiB5b3UgbWlzc2Vk
IG1wdGNwLgo+Cj4vUAo=

