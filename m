Return-Path: <netdev+bounces-280923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOYqLITi6mnJFAAAu9opvQ
	(envelope-from <netdev+bounces-280923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:24:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAA4596FB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43425300462F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36497327BFC;
	Fri, 24 Apr 2026 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="akk1KSvs"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC247322533;
	Fri, 24 Apr 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000622; cv=none; b=tWnrP48wnuIl4kxlUPipQb4FDAuIG3oB5xM4fUyghmGG+Jf3ngCM66NYiDbX9B3xKr8/zMwSJdWeeuVEAG3y4ms09TyN39EW3pYW5KoJTIryW26+1+IUSyx1Q1VvbJ/ig4JGi3K6GcelX21H/SbAgE2dxuH6dqE+pGL/899Ce7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000622; c=relaxed/simple;
	bh=5d+aTvIARB81a2h/srUTNg30rWs8r0SAMbRnn1BwJaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ggHpG6EimHbHi3zfMNsxwT9WdOLjYiQ63TioAz4SaEo+4uIYudOM+xVhLooV9IMvl0cP87t3on5bLHCYNF+svcoPAM95WlRcM3qIIaoOMTlx2zLiighiFHAEdW6PyQViJi5RNjIFg673Scj2I4mfVKRdbdDBNndxDPiQL+RHnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=akk1KSvs reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=1bX4ogkkZT+w4GK5fk2iazUo5s/glwAUSDMJ
	0JNhIZ0=; b=akk1KSvs3Z/BdgiqW25Pk49v6CunPbcQ9mLCr3IG9GPYcS1B4rkV
	DzJ3h47Drj46hh7O4QktZgJgLoSjRjGj5GHj/WnL7d+8yO/MTo0EqMTMUzo2HL8a
	GKVOJTznuBLYmgvR7zIrTVN8cG+FfwlBZDFI7+BPL7zEJm8+wrPxh9Q=
Received: from 25181214217$stu.xidian.edu.cn ( [113.200.174.80] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Fri, 24 Apr 2026
 11:16:30 +0800 (GMT+08:00)
Date: Fri, 24 Apr 2026 11:16:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
Subject: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when
 queue is empty
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <willemdebruijn.kernel.28284ffff84dc@gmail.com>
References: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
 <willemdebruijn.kernel.28284ffff84dc@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ebe2714.7628.19dbd7d2b62.Coremail.25181214217@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkCWP7uO4OppfmW7AQ--.43534W
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUMEWno5lnjs
	QACs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 8BBAA4596FB
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.44 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280923-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,e5d6936b9f4545fd88ab];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email,appspotmail.com:email,xidian.edu.cn:email,davemloft.net:email]
X-Spam: Yes

SGksCgpUaGFuayB5b3Ugc28gbXVjaCBmb3IgdGhlIHJldmlldyBhbmQgZm9yIHBvaW50aW5nIG1l
IHRvIHRoZSBjb3JyZWN0IEZpeGVzIHRhZyEKCllvdSBoaXQgdGhlIG5haWwgb24gdGhlIGhlYWQg
cmVnYXJkaW5nIGBfX2lwNl9hcHBlbmRfZGF0YSgpYC4gQWZ0ZXIgcmUtZXZhbHVhdGluZyB0aGUg
Y29kZSBwYXRoIGJhc2VkIG9uIHlvdXIgcXVlc3Rpb24sIEkgcmVhbGl6ZSBteSBhc3N1bXB0aW9u
IGluIHYyIHdhcyBpbmNvcnJlY3QuIGBfX2lwNl9hcHBlbmRfZGF0YSgpYCBkb2VzIGluZGVlZCBn
dWFyYW50ZWUgdGhhdCBhbiBza2IgaXMgcXVldWVkIHVwb24gc3VjY2VzcywgbWFraW5nIHRoZSBg
c2tiID09IE5VTExgIHBhdGggZGVhZCBjb2RlIGluIHRoaXMgY29udGV4dC4KCkkgdHJhY2VkIHRo
ZSBgZmFpbHNsYWJgIG1lbW9yeSBsZWFrIGJhY2sgdG8gaXRzIHRydWUgb3JpZ2luOiB0aGUgbG9j
a2xlc3MgZmFzdCBwYXRoIHdyYXBwZXIgYGlwNl9tYWtlX3NrYigpYC4KClNhYnJpbmEgcHJldmlv
dXNseSBub3RlZCB0aGF0IGBpcDZfc2V0dXBfY29yaygpYCBmYWlsdXJlcyBjb3JyZWN0bHkgcmVs
ZWFzZSB0aGUgZHN0LiBUaGF0IGlzIGFic29sdXRlbHkgdHJ1ZSBmb3IgdGhlIHNsb3cgcGF0aCwg
d2hlcmUgYHVkcF92Nl9mbHVzaF9wZW5kaW5nX2ZyYW1lcygpYCBldmVudHVhbGx5IGhhbmRsZXMg
dGhlIGNsZWFudXAuIAoKSG93ZXZlciwgaW4gdGhlIGZhc3QgcGF0aCwgYGlwNl9tYWtlX3NrYigp
YCBjYWxscyBgaXA2X3NldHVwX2NvcmsoKWAuIEluc2lkZSBgaXA2X3NldHVwX2NvcmsoKWAsIGBj
b3JrLT5iYXNlLmRzdGAgaXMgYXNzaWduZWQgZWFybHkuIElmIGEgc3Vic2VxdWVudCBtZW1vcnkg
YWxsb2NhdGlvbiBmYWlscyAoZS5nLiwgYHY2X2NvcmstPm9wdCA9IGt6YWxsb2MoLi4uKWAgZmFp
bGluZyBkdWUgdG8gZmFpbHNsYWIpLCBpdCByZXR1cm5zIGFuIGVycm9yLiBgaXA2X21ha2Vfc2ti
KClgIHRoZW4gZGlyZWN0bHkgcmV0dXJucyBgRVJSX1BUUihlcnIpYCBXSVRIT1VUIGNhbGxpbmcg
YGlwNl9jb3JrX3JlbGVhc2UoY29yaylgLgoKU2luY2UgYHVkcHY2X3NlbmRtc2coKWAgYXNzdW1l
cyB0aGUgYGRzdGAgcmVmZXJlbmNlIGlzIHN0b2xlbiBieSBgaXA2X21ha2Vfc2tiKClgIGFuZCB1
bmNvbmRpdGlvbmFsbHkganVtcHMgdG8gYG91dF9ub19kc3RgLCB0aGUgYGRzdGAgaXMgY29tcGxl
dGVseSBsZWFrZWQuCgpUaGUgZml4IGlzIHNpbXBseSB0byBhZGQgYGlwNl9jb3JrX3JlbGVhc2Uo
Y29yaylgIGluIHRoZSBgaXA2X3NldHVwX2NvcmsoKWAgZXJyb3IgcGF0aCBpbnNpZGUgYGlwNl9t
YWtlX3NrYigpYC4KCkkgd2lsbCBzdWJtaXQgYSB2MyBwYXRjaCBzaG9ydGx5IGFkZHJlc3Npbmcg
dGhpcyB0cnVlIHJvb3QgY2F1c2UgYW5kIHVzaW5nIHlvdXIgc3VnZ2VzdGVkIEZpeGVzIHRhZy4g
VGhhbmsgeW91IGFnYWluIGZvciBzdGVlcmluZyBtZSBpbiB0aGUgZXhhY3QgcmlnaHQgZGlyZWN0
aW9uIQoKQmVzdCByZWdhcmRzLApNaW5neXUgV2FuZwoKCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0t
LQo+IOWPkeS7tuS6ujogIldpbGxlbSBkZSBCcnVpam4iIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxA
Z21haWwuY29tPgo+IOWPkemAgeaXtumXtDoyMDI2LTA0LTIzIDIyOjU5OjQ1ICjmmJ/mnJ/lm5sp
Cj4g5pS25Lu25Lq6OiAiTWluZ3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5j
bj4sIHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20sIGRhdmVtQGRhdmVtbG9mdC5uZXQs
IGRzYWhlcm5Aa2VybmVsLm9yZywgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3Jn
LCBwYWJlbmlAcmVkaGF0LmNvbQo+IOaKhOmAgTogc2RAcXVlYXN5c25haWwubmV0LCBob3Jtc0Br
ZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnLCAiTWluZ3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4sIHN5
emJvdCtlNWQ2OTM2YjlmNDU0NWZkODhhYkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4g5Li7
6aKYOiBSZTogW1BBVENIIHYyXSBpcHY2OiBmaXggbWVtb3J5IGxlYWsgaW4gX19pcDZfbWFrZV9z
a2IoKSB3aGVuIHF1ZXVlIGlzIGVtcHR5Cj4gCj4gTWluZ3l1IFdhbmcgd3JvdGU6Cj4gPiBEdXJp
bmcgZnV6emluZyB3aXRoIGZhaWxzbGFiIGVuYWJsZWQsIGEgbWVtb3J5IGxlYWsgd2FzIG9ic2Vy
dmVkIGluIHRoZQo+ID4gSVB2NiBVRFAgc2VuZCBwYXRoLgo+ID4gCj4gPiBUaGUgcm9vdCBjYXVz
ZSByZXNpZGVzIGluIF9faXA2X21ha2Vfc2tiKCkuIEluIGV4dHJlbWVseSByYXJlIGNhc2VzCj4g
PiAoc3VjaCBhcyBmYXVsdCBpbmplY3Rpb24gb3Igc3BlY2lmaWMgZW1wdHkgcGF5bG9hZCBjb25k
aXRpb25zKSwKPiAKPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB0aGlzPyBXaGljaCBmYXVsdCBpbmpl
Y3Rpb24gbGV0cwo+IF9faXA2X2FwcGVuZF9kYXRhIHN1Y2NlZWQgd2l0aG91dCB3cml0aW5nIGRh
dGE/Cj4gCj4gPiBfX2lwNl9hcHBlbmRfZGF0YSgpIG1heSBzdWNjZWVkIGJ1dCBsZWF2ZSB0aGUg
c29ja2V0J3Mgd3JpdGUgcXVldWUKPiA+IGVtcHR5Lgo+ID4gCj4gPiBXaGVuIF9faXA2X21ha2Vf
c2tiKCkgaXMgc3Vic2VxdWVudGx5IGNhbGxlZCwgX19za2JfZGVxdWV1ZShxdWV1ZSkKPiA+IHJl
dHVybnMgTlVMTC4gVGhlIHByZXZpb3VzIGxvZ2ljIGhhbmRsZWQgdGhpcyBieSBleGVjdXRpbmcg
YSAnZ290byBvdXQ7JywKPiA+IHdoaWNoIGNvbXBsZXRlbHkgYnlwYXNzZWQgdGhlIGNhbGwgdG8g
aXA2X2NvcmtfcmVsZWFzZShjb3JrKS4KPiA+IAo+ID4gU2luY2UgdGhlICdjb3JrJyBzdHJ1Y3R1
cmUgYWN0aXZlbHkgaG9sZHMgYSByZWZlcmVuY2UgdG8gdGhlIHJvdXRpbmcKPiA+IGVudHJ5IChk
c3RfZW50cnkpIGFuZCBwb3RlbnRpYWxseSBvdGhlciBhbGxvY2F0ZWQgb3B0aW9ucywgc2tpcHBp
bmcKPiA+IHRoZSByZWxlYXNlIGNsZWFubHkgbGVha3MgdGhlc2UgcmVzb3VyY2VzLgo+ID4gCj4g
PiBGaXggdGhpcyBieSBpbnRyb2R1Y2luZyBhbiAnb3V0X2NvcmtfcmVsZWFzZScgbGFiZWwgYW5k
IGp1bXBpbmcgdG8gaXQKPiA+IHdoZW4gc2tiIGlzIE5VTEwsIGVuc3VyaW5nIHRoZSBjb3JrIHN0
YXRlIGlzIGFsd2F5cyBwcm9wZXJseSBjbGVhbmVkIHVwLgo+ID4gVGhlIG5vdy11bnVzZWQgJ291
dCcgbGFiZWwgaXMgYWxzbyByZW1vdmVkIHRvIHByZXZlbnQgY29tcGlsZXIgd2FybmluZ3MuCj4g
PiAKPiA+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikKPiAKPiBJIHRo
aW5rIHRoaXMgaXMgCj4gCj4gRml4ZXM6IDY0MjIzOThjMmFiMCAoImlwdjY6IGludHJvZHVjZSBp
cHY2X21ha2Vfc2tiIikKPiAKPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrZTVkNjkzNmI5ZjQ1NDVm
ZDg4YWJAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZ3l1
IFdhbmcgPDI1MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuPgo=

