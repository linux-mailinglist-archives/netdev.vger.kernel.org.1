Return-Path: <netdev+bounces-301321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id liy9E49YOmqp6gcAu9opvQ
	(envelope-from <netdev+bounces-301321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A636B5FE9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=mails.tsinghua.edu.cn header.s=dkim header.b=nX9l4qUY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301321-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=mails.tsinghua.edu.cn (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4353531142A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F1369D59;
	Tue, 23 Jun 2026 09:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B38367B86;
	Tue, 23 Jun 2026 09:53:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208392; cv=none; b=Suki0gd8oj/+gGqaFsYuOEAyWwjkMBQANemoZzVDRAxVQn9NzJ/DS6UpMIiISssPQ3WEkIFCHHmPFoG8/yt2AvX3NZUy3eXPu/8vvqxSAKTsSDGH4EOgLsOV6fsD3QLblvq/l/iVWgZAB2IWrd0CHFsL7i/YEW2tvk1eSYI1Z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208392; c=relaxed/simple;
	bh=eNQlh6VTYUAKPQ97pC9x8ZewizrBKpooOvT6XjmDkN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Dnbs8Tnujg6zNQa0UjUDsTFsc3Xli6cvSvBBfjDYNFA2N4UHJKJoNpFDmCV9E7aMYwr/Sm4Tzz9mQBDdD7wIMQpJGbxzfZk4OgcSax9J4NixPYjYPX23no09Ew/fsD2bLKzmTnt1JIeqveIM5YCnSkzvZIlRJUO6WvPm7uejjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=nX9l4qUY reason="signature verification failed"; arc=none smtp.client-ip=162.243.161.220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=V6A2nlb9Nrrq7OFjAEP17y0
	JGlpwkRwFoeWr9x4c8k4=; b=nX9l4qUY+RelK+T6BAfYDwdVlS7rVY8UaQ8FM5w
	iH4QE3jweQuI94LtrEjx+BSBQduZhOYSn/RDB69gQD46dplpUS/6JXuNoex+ZJZt
	tDDCuVopFCwS5Gx5jU6DKPidU9Am7lehG6fJzWhdlQMTTbXYIlySx7fqkDvnHsw2
	77X0=
Received: from gnq25$mails.tsinghua.edu.cn ( [223.91.120.130] ) by
 ajax-webmail-web2 (Coremail) ; Tue, 23 Jun 2026 17:52:52 +0800 (GMT+08:00)
Date: Tue, 23 Jun 2026 17:52:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Andrea Mayer" <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stefano.salsano@uniroma2.it
Subject: Re: Re: [PATCH net] seg6: validate SRH length before reading fixed
 fields
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <20260622213317.52c8b5a38b88d4ccc3849e22@uniroma2.it>
References: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
 <20260622213317.52c8b5a38b88d4ccc3849e22@uniroma2.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5cd4ac55.850d6.19ef3e59eab.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQCXcZl0VzpqmpR8Ag--.26140W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgIHA2o6NDlGngA
	CsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[mails.tsinghua.edu.cn : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[mails.tsinghua.edu.cn:s=dkim];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stefano.salsano@uniroma2.it,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gnq25@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnq25@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:-];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,uniroma2.it:email,tsinghua.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97A636B5FE9

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW5kcmVhIE1heWVyIiA8
YW5kcmVhLm1heWVyQHVuaXJvbWEyLml0Pgo+IFNlbmQgdGltZTpUdWVzZGF5LCAyMy8wNi8yMDI2
IDAzOjMzOjE3Cj4gVG86ICJOdW9xaSBHdWkiIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUuY24+
Cj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0PiwgIkVyaWMgRHVt
YXpldCIgPGVkdW1hemV0QGdvb2dsZS5jb20+LCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5l
bC5vcmc+LCAiUGFvbG8gQWJlbmkiIDxwYWJlbmlAcmVkaGF0LmNvbT4sICJTaW1vbiBIb3JtYW4i
IDxob3Jtc0BrZXJuZWwub3JnPiwgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgYnBmQHZnZXIua2Vy
bmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgc3RlZmFuby5zYWxzYW5vQHVu
aXJvbWEyLml0LCAiQW5kcmVhIE1heWVyIiA8YW5kcmVhLm1heWVyQHVuaXJvbWEyLml0Pgo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBzZWc2OiB2YWxpZGF0ZSBTUkggbGVuZ3RoIGJlZm9yZSBy
ZWFkaW5nIGZpeGVkIGZpZWxkcwo+IAo+IE9uIFNhdCwgMjAgSnVuIDIwMjYgMjM6NTU6NTEgKzA4
MDAKPiBOdW9xaSBHdWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4gd3JvdGU6Cj4gCj4g
SGkgTnVvcWksCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guCj4gCj4gPiBzZWc2X3ZhbGlkYXRlX3Ny
aCgpIHJlYWRzIGZpeGVkIFNSSCBmaWVsZHMgc3VjaCBhcyBzcmgtPnR5cGUgYW5kCj4gPiBzcmgt
PmhkcmxlbiBiZWZvcmUgY2hlY2tpbmcgdGhhdCB0aGUgc3VwcGxpZWQgbGVuZ3RoIGNvdmVycyB0
aGUgZml4ZWQKPiA+IHN0cnVjdCBpcHY2X3NyX2hkciBmaWVsZHMuICBDYWxsZXJzIHRoYXQgcGFz
cyBhIGxlbmd0aCBzbWFsbGVyIHRoYW4KPiA+IHNpemVvZihzdHJ1Y3QgaXB2Nl9zcl9oZHIpIHRo
ZXJlZm9yZSBleHBvc2UgdGhvc2UgcmVhZHMgdG8gbWVtb3J5Cj4gPiBvdXRzaWRlIHRoZSB2YWxp
ZGF0ZWQgcmFuZ2UuCj4gPgo+ID4gVGhlIEJQRiBTRUc2IGVuY2FwIHBhdGggKGJwZl9sd3RfcHVz
aF9lbmNhcCgpIC0+IGJwZl9wdXNoX3NlZzZfZW5jYXAoKSkKPiA+IGlzIG9uZSBzdWNoIGNhbGxl
cjogaXQgZm9yd2FyZHMgYSBCUEYgcHJvZ3JhbS1zdXBwbGllZCBwb2ludGVyIGFuZAo+ID4gbGVu
Z3RoIHN0cmFpZ2h0IHRvIHNlZzZfdmFsaWRhdGVfc3JoKCkgd2l0aCBubyBtaW5pbXVtLXNpemUg
Z3VhcmQsIHNvIGEKPiA+IDItYnl0ZSBTRUc2IGVuY2FwIGhlYWRlciBsZXRzIHRoZSB2YWxpZGF0
b3IgcmVhZCBzcmgtPnR5cGUgYXQgb2Zmc2V0IDIKPiA+IGJleW9uZCB0aGUgY2FsbGVyLXN1cHBs
aWVkIGJ1ZmZlci4KPiAKPiBCZXNpZGVzIHRoZSBCUEYgdXNlIGNhc2UsIGlzIHRoZXJlIGEgY2Fs
bGVyIHRoYXQgY2FuIHJlYWNoIGl0IHdpdGgKPiBsZW4gPCBzaXplb2YoKnNyaCk/IFRoZSBvbmVz
IEkgZm91bmQgYWxsIHBhc3MgYXQgbGVhc3QgdGhlIGZpeGVkIGhlYWRlci4KPiAKTm8sIEkgZG9u
J3Qgc2VlIGFub3RoZXIgY3VycmVudCBjYWxsZXIgdGhhdCBjYW4gcmVhY2ggc2VnNl92YWxpZGF0
ZV9zcmgoKSAKd2l0aCBsZW4gPCBzaXplb2YoKnNyaCkuIEknbGwgbmFycm93IHRoZSBjb21taXQg
bWVzc2FnZSBhY2NvcmRpbmdseS4KCj4gPgo+ID4gUmVqZWN0IGxlbmd0aHMgc2hvcnRlciB0aGFu
IHRoZSBmaXhlZCBTUkggYXQgdGhlIHRvcCBvZgo+ID4gc2VnNl92YWxpZGF0ZV9zcmgoKSwgYmVm
b3JlIGFueSBmaWVsZCBpcyByZWFkLiAgVGhpcyBmaXhlcyB0aGUgQlBGIGhlbHBlcgo+ID4gcGF0
aCBhbmQgaGFyZGVucyB0aGUgY29tbW9uIHZhbGlkYXRvciBmb3IgYW55IG90aGVyIGNhbGxlciB0
aGF0IHJlYWNoZXMgaXQKPiA+IHdpdGggYSB0b28tc2hvcnQgU1JILgo+ID4KPiA+IEZpeGVzOiBm
ZTk0Y2MyOTBmNTMgKCJicGY6IEFkZCBJUHY2IFNlZ21lbnQgUm91dGluZyBoZWxwZXJzIikKPiA+
IFNpZ25lZC1vZmYtYnk6IE51b3FpIEd1aSA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPgo+
ID4gLS0tCj4gPiAgbmV0L2lwdjYvc2VnNi5jIHwgMyArKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L3NlZzYuYyBiL25l
dC9pcHY2L3NlZzYuYwo+ID4gaW5kZXggMWMzYWQyNTcwMGM0Yy4uZDJjYjMyYTEwNThhZiAxMDA2
NDQKPiA+IC0tLSBhL25ldC9pcHY2L3NlZzYuYwo+ID4gKysrIGIvbmV0L2lwdjYvc2VnNi5jCj4g
PiBAQCAtMjksNiArMjksOSBAQCBib29sIHNlZzZfdmFsaWRhdGVfc3JoKHN0cnVjdCBpcHY2X3Ny
X2hkciAqc3JoLCBpbnQgbGVuLCBib29sIHJlZHVjZWQpCj4gPiAgICAgICBpbnQgbWF4X2xhc3Rf
ZW50cnk7Cj4gPiAgICAgICBpbnQgdHJhaWxpbmc7Cj4gPgo+ID4gKyAgICAgaWYgKGxlbiA8IChp
bnQpc2l6ZW9mKCpzcmgpKQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiArCj4g
Cj4gVGhlIChpbnQpIGNhc3Qgb25seSBjaGFuZ2VzIHRoZSByZXN1bHQgd2hlbiBsZW4gPCAwLCB3
aGljaCBpcyBub3QgYSBtZWFuaW5nZnVsCj4gYnl0ZSBsZW5ndGguIFBsYWluICJsZW4gPCBzaXpl
b2YoKnNyaCkiIHdvdWxkIGJlIGVub3VnaC4KPiAKSSdsbCB1c2UgcGxhaW4gbGVuIDwgc2l6ZW9m
KCpzcmgpLgoKPiA+ICAgICAgIGlmIChzcmgtPnR5cGUgIT0gSVBWNl9TUkNSVF9UWVBFXzQpCj4g
PiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+Cj4gPgo+ID4gLS0tCj4gPiBiYXNlLWNv
bW1pdDogOTZlN2Y5MTIyYWFlMGVkMDAwZWUzMjFmMzI0YjgxMmE0NDc5MDZkOQo+ID4gY2hhbmdl
LWlkOiAyMDI2MDYxOS1mMDEtMTctc2VnNi1zcmgtbGVuLWE4NWYzNTQyN2UwYgo+ID4KPiA+IEJl
c3QgcmVnYXJkcywKPiA+IC0tCj4gPiBOdW9xaSBHdWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVk
dS5jbj4KPiA+Cj4gCj4gUmVnYXJkcywKPiBBbmRyZWEK

