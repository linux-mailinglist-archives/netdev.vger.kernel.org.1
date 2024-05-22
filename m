Return-Path: <netdev+bounces-97637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB68CC783
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D888A1C20A96
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BFF146A71;
	Wed, 22 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="mq3nvLZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.126.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9323CB;
	Wed, 22 May 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.126.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407691; cv=none; b=f0Kum0ej9H0wgYdiXJ4HOu1CoNSUridE78pvcSnDSajz3wD3Q+W1F9yfLcRlqdbvdRjAtv06dNWQpPeIOYuQ0vauLLYWfSA3Hd3yonjLKM1aqE/y3iyqZv8D6u/Neby9PKIGh4C4AvKv5tmAC/zSU+P4WwE0Hg55XlNTeIVIWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407691; c=relaxed/simple;
	bh=/H1/xp0OnLXFw9PSFNhkzZ5NE2daogZ7q1eOe2leqqY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FKcycE3JjNAj/9QIQRwrXOuzhlJ6aVRFkiA1VJ6te/KOQtTP3OfN7aup3Ahwhvtzc6KQdofRkwKA0q8ApdmTVlYpLQNm17JQdltAnFo5f4LarWU8T6UG4Llj7AsrJrLf3kTckhveGIp3U0ncftTdgQ7j3ICIvcXn5U4zwj+FuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=mq3nvLZB; arc=none smtp.client-ip=80.12.126.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1716407688; x=1747943688;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=/H1/xp0OnLXFw9PSFNhkzZ5NE2daogZ7q1eOe2leqqY=;
  b=mq3nvLZB89spL+nj+vycHRg46DOEYPcxmWKgm+r9MVucx1OadBH83qSy
   nv0k28Vs6MkkzpL5aAKVXFiqY0EVNLMa+iX7rAN0M1MM4WsZLvgygzu2x
   QXZI/Z7Ps2Om3HAuhHhcd2CVHl2IhLYRRsJ/nGz7UymZhQ1fU0FlbQOeO
   Mp2lkzvl+OuyhaSi4khIxWDO7E7snrKUX4u85nqHdYJawnOamw6z9Jb9x
   eXtAk1yozY4voDVlslrmckhUe2G5g9GtdDFatVCTJnTtPbvnNKGnH+kxt
   v2Rhu2HjWFAEb+KQQu06k/iPX235p+OUH6o7oxlfkwS+GE88qsiIJhI0s
   A==;
Received: from unknown (HELO opfedv1rlp0a.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 21:54:46 +0200
Received: from unknown (HELO OPE16NORMBX104.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv1rlp0a.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2024 21:54:46 +0200
Received: from [x.x.x.x] [x.x.x.x] by OPE16NORMBX104.corporate.adroot.infra.ftgroup
 [x.x.x.x] with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37;
 Wed, 22 May 2024 21:54:46 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.08,181,1712613600"; 
   d="scan'208";a="145879807"
Message-ID: <92edf27b-a2b9-4072-b8a4-0d7fde303151@orange.com>
Date: Wed, 22 May 2024 21:54:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Chengen Du
	<chengen.du@canonical.com>
CC: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
 <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
 <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
 <664e3be092d6a_184f2f29441@willemb.c.googlers.com.notmuch>
Content-Language: fr, en-US
In-Reply-To: <664e3be092d6a_184f2f29441@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: OPE16NORMBX403.corporate.adroot.infra.ftgroup
 (10.115.26.16) To OPE16NORMBX104.corporate.adroot.infra.ftgroup (10.115.26.5)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgV2lsbGVtLCBhbGwuCgpPbiAyMi8wNS8yMDI0IDIwOjM5LCBXaWxsZW0gZGUgQnJ1aWpuIHdy
b3RlOgo+IENoZW5nZW4gRHUgd3JvdGU6Cj4gPgo+ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90
aGUtdGNwZHVtcC1ncm91cC9saWJwY2FwL2lzc3Vlcy8xMTA1Cj4gPiBbMl0gaHR0cHM6Ly9tYXJj
LmluZm8vP2w9bGludXgtbmV0ZGV2Jm09MTY1MDc0NDY3NTE3MjAxJnc9NApGaXJzdCwgYSBodWdl
IHRoYW5rcyB0byB5b3UgZ3V5cyBmb3IgZGlnZ2luZyB0aGlzIG91dCwgYW5kIGZvciB0YWtpbmcg
aXQgb24gZm9yIApnb29kLgo+IFRoaXMgaXMgYWxsIHN1cGVyIGhlbHBmdWwgY29udGV4dCBhbmQg
d2lsbCBoYXZlIHRvIG1ha2UgaXQgaW50byB0aGUKPiBjb21taXQgbWVzc2FnZS4KPgo+IFNvIGlm
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhlIGlzc3VlIGlzIGluY29uc2lzdGVuY3kgYWJvdXQg
d2hldGhlcgo+IFZMQU4gdGFncyBhcmUgTDIgb3IgTDMsIGFuZCBpbmZvcm1hdGlvbiBnZXR0aW5n
IGxvc3QgYWxvbmcgdGhlIHdheS4KRXhhY3RseS4gQXMgeW91IHB1dCBpdCwgTDIuNSBpcyB0aGUg
aG90IHBvdGF0byBub2JvZHkgd2FudHMgdG8gaGFuZGxlOyBlYWNoIHNpZGUgCmFzc3VtZXMgdGhl
IG90aGVyIHdpbGwgdGFrZSBjYXJlIG9mIGl0IDopCj4gU09DS19ER1JBTSBtb2RlIHJlbW92ZXMg
ZXZlcnl0aGluZyB1cCB0byBza2JfbmV0d29ya19vZmZzZXQsIHdoaWNoCj4gYWxzbyByZW1vdmVz
IHRoZSBWTEFOIHRhZ3MuIEJ1dCBpdCBkb2VzIG5vdCB1cGRhdGUgc2tiLT5wcm90b2NvbC4KPgo+
IG1zZ19uYW1lIGluY2x1ZGVzIHNvY2thZGRyX2xsLnNsbF9wcm90b2NvbCB3aGljaCBpcyBzZXQg
dG8KPiBza2ItPnByb3RvY29sLgo+Cj4gU28gdGhlIHByb2Nlc3MgZ2V0cyBhIHBhY2tldCB3aXRo
IHB1cnBvcnRlZCBwcm90b2NvbCBFVEhfUF84MDIxUQo+IHN0YXJ0aW5nIGJlZ2lubmluZyBhdCBh
biBJUCBvciBJUHY2IGhlYWRlci4KPgo+IEEgZmV3IGFsdGVybmF0aXZlcyB0byBhZGRyZXNzIHRo
aXM6Cj4KPiAxLiBpbnNlcnQgdGhlIFZMQU4gdGFnIGJhY2sgaW50byB0aGUgcGFja2V0LCB3aXRo
IGFuIHNrYl9wdXNoLgo+IDIuIHByZXBhcmUgdGhlIGRhdGEgYXMgaWYgaXQgaXMgYSBWTEFOIG9m
ZmxvYWRlZCBwYWNrZXQ6Cj4gICAgIHBhc3MgdGhlIFZMQU4gaW5mb3JtYXRpb24gdGhyb3VnaCBQ
QUNLRVRfQVVYREFUQS4KPiAzLiBwdWxsIG5vdCB1cCB0byBza2JfbmV0d29ya19vZmZzZXQsIGJ1
dCBwdWxsIG1hY19sZW4uCj4KPiBZb3VyIHBhdGNoIGRvZXMgdGhlIHNlY29uZC4KPgo+IEkgdGhp
bmsgdGhlIGFwcHJvYWNoIGlzIGxhcmdlbHkgc291bmQsIHdpdGggYSBmZXcgaXNzdWVzIHRvIGNv
bnNpZGVyOgo+IC0gUWluUS4gVGhlIGN1cnJlbnQgc29sdXRpb24ganVzdCBwYXNzZXMgdGhlIHBy
b3RvY29sIGluIHRoZSBvdXRlciB0YWcKPiAtIE90aGVyIEwyLjUsIGxpa2UgTVBMUy4gVGhpcyBz
b2x1dGlvbiBkb2VzIG5vdCB3b3JrIGZvciB0aG9zZS4KPiAgICAoaWYgdGhleSBuZWVkIGEgZml4
LCBhbmQgdGhlIHNhbWUgbmV0d29ya19vZmZzZXQgaXNzdWUgYXBwbGllcy4pCj4KPiAzIHdvdWxk
IHNvbHZlIGFsbCB0aGVzZSBjYXNlcywgSSB0aGluay4gQnV0IGlzIGEgbGFyZ2VyIGRpdmVyc2lv
biBmcm9tCj4gZXN0YWJsaXNoZWQgYmVoYXZpb3IuCkkgaGFkIHNvbWVob3cgZm9ybWVkIHRoZSBz
YW1lIGFuYWx5c2lzIGFuZCBsaXN0IG9mIGF2YWlsYWJsZSBvcHRpb25zICh3aXRoIHRoZSAKZGlm
ZmVyZW5jZSB0aGF0LCBiZWluZyBhIGtlcm5lbCBuZXdiaWUsIEkgd2FzIDEwJSBzdXJlKS4KQSBm
ZXcgZXh0cmEgdGhpbmdzIHlvdSBtaWdodCBjb25zaWRlciBiZWZvcmUgbWFraW5nIHRoZSBkZWNp
c2lvbjoKCihhKSBJZiB0aGUgYWJzb2x1dGUgaGlnaGVzdCBwcmlvcml0eSBnb2VzIHRvIGJhY2t3
YXJkcyBjb21wYXRpYmlsaXR5LCB0aGVuIApDaGVuZ2VuJ3MgYXBwcm9hY2ggKHlvdXIgMi4pIGlz
IHRoZSBjbGVhciB3aW5uZXIuCgooYikgSG93ZXZlciwgZnJvbSBteSBzdGFuZHBvaW50IGFzIGEg
cHJvdG9jb2wtYWdub3N0aWMgcGFja2V0LWNydW5jaGVyIAooY2FwdHVyaW5nIGFsbCBzb3J0cyBv
ZiBlbmNhcHN1bGF0aW9ucyBhdCBtaWRwb2ludCBpbiBwcm9taXNjdW91cyBtb2RlIC0gbm9uZSBv
ZiAKdGhlIHBhY2tldHMgaXMgcmVhbGx5IG1lYW50IGZvciB0aGUgbG9jYWwgc3RhY2spLCB0aGUg
dmVyeSBpZGVhIG9mICJzcGVjaWFsIApjYXNpbmciICpvbmUqIGxldmVsIG9mIFZMQU4gYW5kIGJ1
cnlpbmcgaXQgaW5zaWRlIGFuIG9ic2N1cmUsIGxvc3N5IHBzZXVkby1MMiAKKFNMTCksIGlzIGNv
bXBsZXRlbHkgYWxpZW4uIFNvLCBhbnkgc2V0dGluZyAoYmUgaXQgbm90IHRoZSBkZWZhdWx0KSB0
aGF0IHdvdWxkIAphbGxvdyB0byB3aXBlIHRoaXMgd2FydCwgd291bGQgYmUgYSBodWdlIGJvbnVz
LiBTbyBJJ2QgaGFwcGlseSBnbyB3aXRoICgxLikgb3IgCigzLikgd2hpY2ggYm90aCBkbyB0aGF0
LiBJJ2xsIGRlZmVyIHRvIHlvdXIgYXBwcmVjaWF0aW9uIG9mIHdoaWNoIGlzIHRoZSBsZWFzdCAK
ZGlzcnVwdGl2ZS4KCihjKSBTcGVha2luZyBvZiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSwgSSB3
b3VsZCByZXNwZWN0ZnVsbHkgbGlrZSB0byBwb2ludCBvdXQgCnRoYXQgYSBiZWhhdmlvciB0aGF0
IGhhcyBiZWVuIHV0dGVybHkgYnJva2VuIGZvciBzbyBtYW55IHllYXJzLCBtaWdodCBxdWFsaWZ5
IApmb3IgYSByYXRoZXIgZGVjaXNpdmUgY29ycmVjdGlvbi4gWW91IHdvbid0IGJyZWFrIG11Y2gg
YW55d2F5IDopCgpUTDtEUjogYWxsIHRocmVlIG9wdGlvbnMgYXJlIGVub3Jtb3VzbHkgYmV0dGVy
IHRoYW4gdGhlIHN0YXR1IHF1byA9PiBieSBhbGwgCm1lYW5zLCBmaXggaXQgZWl0aGVyIHdheSA6
KQoKQmVzdCByZWdhcmRzLAoKLUFsZXgKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCkNlIG1lc3NhZ2UgZXQgc2VzIHBpZWNlcyBqb2ludGVzIHBl
dXZlbnQgY29udGVuaXIgZGVzIGluZm9ybWF0aW9ucyBjb25maWRlbnRpZWxsZXMgb3UgcHJpdmls
ZWdpZWVzIGV0IG5lIGRvaXZlbnQgZG9uYw0KcGFzIGV0cmUgZGlmZnVzZXMsIGV4cGxvaXRlcyBv
dSBjb3BpZXMgc2FucyBhdXRvcmlzYXRpb24uIFNpIHZvdXMgYXZleiByZWN1IGNlIG1lc3NhZ2Ug
cGFyIGVycmV1ciwgdmV1aWxsZXogbGUgc2lnbmFsZXINCmEgbCdleHBlZGl0ZXVyIGV0IGxlIGRl
dHJ1aXJlIGFpbnNpIHF1ZSBsZXMgcGllY2VzIGpvaW50ZXMuIExlcyBtZXNzYWdlcyBlbGVjdHJv
bmlxdWVzIGV0YW50IHN1c2NlcHRpYmxlcyBkJ2FsdGVyYXRpb24sDQpPcmFuZ2UgZGVjbGluZSB0
b3V0ZSByZXNwb25zYWJpbGl0ZSBzaSBjZSBtZXNzYWdlIGEgZXRlIGFsdGVyZSwgZGVmb3JtZSBv
dSBmYWxzaWZpZS4gTWVyY2kuDQoNClRoaXMgbWVzc2FnZSBhbmQgaXRzIGF0dGFjaG1lbnRzIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIHRoYXQgbWF5
IGJlIHByb3RlY3RlZCBieSBsYXc7DQp0aGV5IHNob3VsZCBub3QgYmUgZGlzdHJpYnV0ZWQsIHVz
ZWQgb3IgY29waWVkIHdpdGhvdXQgYXV0aG9yaXNhdGlvbi4NCklmIHlvdSBoYXZlIHJlY2VpdmVk
IHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBhbmQgZGVsZXRl
IHRoaXMgbWVzc2FnZSBhbmQgaXRzIGF0dGFjaG1lbnRzLg0KQXMgZW1haWxzIG1heSBiZSBhbHRl
cmVkLCBPcmFuZ2UgaXMgbm90IGxpYWJsZSBmb3IgbWVzc2FnZXMgdGhhdCBoYXZlIGJlZW4gbW9k
aWZpZWQsIGNoYW5nZWQgb3IgZmFsc2lmaWVkLg0KVGhhbmsgeW91Lgo=


