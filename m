Return-Path: <netdev+bounces-103896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29C90A0DB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F121D282511
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB255339B;
	Sun, 16 Jun 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="WH1A/8gO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.126.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7C225D6
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.126.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718581565; cv=none; b=FOZT1BOLzaN8ef9zU6fe9zzimhZP6u9fyzAz2CKaCeJfJB7jLX5drPgAAUbiIfFMFxgbcM1GuRfMXz97aoDmxIG/b+h3LJYNnAJ6Dui4c6x/Zh6df9tbmcid7VhYDNeucbILX7MaSymWppwufsE6rKn8DEe+OCYXYI6wE+Cc4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718581565; c=relaxed/simple;
	bh=zcxiwp3D8zJXCOAtoRa05uSl9eG8151E4t29MsTWfl4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=u9kS+eHLEyFGS4HBEa5R9QIdmPnEpQcNtAynQdAVgJqgfCDsgjZjdBTr+pRP/YdSUXoRM0D8mxuRVDrW9hb1hBJBWqE89JvtL27K0q5Wl8Bwd37lrEY4fZTBlJJ8XF3icqA41YXfLXCG7e0U6/XnLC/h/CKNUTuZITjsWXyDl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=WH1A/8gO; arc=none smtp.client-ip=80.12.126.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1718581561; x=1750117561;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=zcxiwp3D8zJXCOAtoRa05uSl9eG8151E4t29MsTWfl4=;
  b=WH1A/8gOLj9lJMGmnhq69JnyTJmkjE05pOoMmpwFhFzUWkLZBygiO4Z8
   JYxpltRSW23L87YpIiHedFeqYLYRDprpa5hZJdBRQltRHUoPKX/fzuPTi
   sLfeSUW9AtO8Pjytx/j98hJrY4+8rlcdeS+xb7b3lPVvoMctqPK5wTCY4
   uhIPWXFqIRJKdaXX7fJ8JHGCUmFj4+idC7l2F2pnVIRBJi7fod4FMQD3J
   jj79gzTu8e+S35TEMsIH1JYsC4FngfprrvgtkXW1ic1xvr1NibLwZ8zg3
   q5BJtiMY9BmNy/Xv9F/9JYjP9IO3eMvciDs41sG9KqSijFz8SPxbt4tni
   g==;
Received: from unknown (HELO opfedv1rlp0g.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2024 01:45:53 +0200
Received: from unknown (HELO OPE16NORMBX104.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv1rlp0g.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 01:45:53 +0200
Received: from [x.x.x.x] [x.x.x.x] by OPE16NORMBX104.corporate.adroot.infra.ftgroup
 [x.x.x.x] with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39;
 Mon, 17 Jun 2024 01:45:52 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.08,243,1712613600"; 
   d="scan'208";a="154808975"
Message-ID: <22b3012d-3d70-492a-8786-d6c6beef2eb4@orange.com>
Date: Mon, 17 Jun 2024 01:45:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v2] Fix race for duplicate reqsk on identical SYN
To: luoxuanqiang <luoxuanqiang@kylinos.cn>, <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <fw@strlen.de>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
References: <20240614102628.446642-1-luoxuanqiang@kylinos.cn>
Content-Language: fr, en-US
In-Reply-To: <20240614102628.446642-1-luoxuanqiang@kylinos.cn>
X-ClientProxiedBy: OPE16NORMBX204.corporate.adroot.infra.ftgroup (10.115.26.9)
 To OPE16NORMBX104.corporate.adroot.infra.ftgroup (10.115.26.5)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTQvMDYvMjAyNCAxMjoyNiwgbHVveHVhbnFpYW5nIHdyb3RlOg0KPiBXaGVuIGJvbmRpbmcg
aXMgY29uZmlndXJlZCBpbiBCT05EX01PREVfQlJPQURDQVNUIG1vZGUsIGlmIHR3byBpZGVudGlj
YWwNCj4gU1lOIHBhY2tldHMgYXJlIHJlY2VpdmVkIGF0IHRoZSBzYW1lIHRpbWUgYW5kIHByb2Nl
c3NlZCBvbiBkaWZmZXJlbnQgQ1BVcywNCj4gaXQgY2FuIHBvdGVudGlhbGx5IGNyZWF0ZSB0aGUg
c2FtZSBzayAoc29jaykgYnV0IHR3byBkaWZmZXJlbnQgcmVxc2sNCj4gKHJlcXVlc3Rfc29jaykg
aW4gdGNwX2Nvbm5fcmVxdWVzdCgpLg0KPg0KPiBUaGVzZSB0d28gZGlmZmVyZW50IHJlcXNrIHdp
bGwgcmVzcG9uZCB3aXRoIHR3byBTWU5BQ0sgcGFja2V0cywgYW5kIHNpbmNlDQo+IHRoZSBnZW5l
cmF0aW9uIG9mIHRoZSBzZXEgKElTTikgaW5jb3Jwb3JhdGVzIGEgdGltZXN0YW1wLCB0aGUgZmlu
YWwgdHdvDQo+IFNZTkFDSyBwYWNrZXRzIHdpbGwgaGF2ZSBkaWZmZXJlbnQgc2VxIHZhbHVlcy4N
Cj4NCj4gVGhlIGNvbnNlcXVlbmNlIGlzIHRoYXQgd2hlbiB0aGUgQ2xpZW50IHJlY2VpdmVzIGFu
ZCByZXBsaWVzIHdpdGggYW4gQUNLDQo+IHRvIHRoZSBlYXJsaWVyIFNZTkFDSyBwYWNrZXQsIHdl
IHdpbGwgcmVzZXQoUlNUKSBpdC4NCj4NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIGlzIGNsb3Nl
LCBidXQgbm90IGlkZW50aWNhbCwgdG8gYSByYWNlIHdlIG9ic2VydmVkIG9uIGEgKnNpbmdsZSog
Q1BVIHdpdGgNCnRoZSBUUFJPWFkgaXB0YWJsZXMgdGFyZ2V0LCBpbiB0aGUgZm9sbG93aW5nIHNp
dHVhdGlvbjoNCg0KIMKgLSB0d28gaWRlbnRpY2FsIFNZTnMsIHNlbnQgb25lIHNlY29uZCBhcGFy
dCBmcm9tIHRoZSBzYW1lIGNsaWVudCBzb2NrZXQsDQogwqDCoCBhcnJpdmUgYmFjay10by1iYWNr
IG9uIHRoZSBpbnRlcmZhY2UgKGR1ZSB0byBuZXR3b3JrIGppdHRlcikNCg0KIMKgLSB0aGV5IGhh
cHBlbiB0byBiZSBoYW5kbGVkIGluIHRoZSBzYW1lIGJhdGNoIG9mIHBhY2tldCBmcm9tIG9uZSBz
b2Z0aXJxDQogwqDCoCBuYW1lX3lvdXJfbmljX3BvbGwoKQ0KDQogwqAtIHRoZXJlLCB0d28gbG9v
cHMgcnVuIHNlcXVlbnRpYWxseTogb25lIGZvciBuZXRmaWx0ZXIgKGRvaW5nIFRQUk9YWSksIG9u
ZQ0KIMKgwqAgZm9yIHRoZSBuZXR3b3JrIHN0YWNrIChkb2luZyBUQ1AgcHJvY2Vzc2luZykNCg0K
IMKgLSB0aGUgZmlyc3QgZ2VuZXJhdGVzIHR3byBkaXN0aW5jdCBjb250ZXh0cyBmb3IgdGhlIHR3
byBTWU5zDQoNCiDCoC0gdGhlIHNlY29uZCByZXNwZWN0cyB0aGVzZSBjb250ZXh0cyBhbmQgbmV2
ZXIgZ2V0cyBhIGNoYW5jZSB0byBtZXJnZSB0aGVtDQoNClRoZSByZXN1bHQgaXMgZXhhY3RseSBh
cyB5b3UgZGVzY3JpYmUsIGJ1dCBpbiB0aGlzIGNhc2UgdGhlcmUgaXMgbm8gbmVlZCBmb3IgDQpi
b25kaW5nLA0KYW5kIGV2ZXJ5dGhpbmcgaGFwcGVucyBpbiBvbmUgc2luZ2xlIENQVSwgd2hpY2gg
aXMgcHJldHR5IGlyb25pYyBmb3IgYSByYWNlLg0KTXkgdW5lZHVjYXRlZCBmZWVsaW5nIGlzIHRo
YXQgdGhlIHR3byBsb29wcyBhcmUgdGhlIGNhdXNlIG9mIGEgc2ltdWxhdGVkDQpwYXJhbGxlbGlz
bSwgeWllbGRpbmcgdGhlIHJhY2UuIElmIGVhY2ggcGFja2V0IG9mIHRoZSBiYXRjaCB3YXMgaGFu
ZGxlZA0KInRvIGNvbXBsZXRpb24iIChmdWxsIG5ldGZpbHRlciBoYW5kbGluZyBmb2xsb3dlZCBp
bW1lZGlhdGVseSBieSBmdWxsIG5ldHdvcmsNCnN0YWNrIGluZ2VzdGlvbiksIHRoZSBwcm9ibGVt
IHdvdWxkIG5vdCBleGlzdC4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpDZSBtZXNzYWdlIGV0IHNlcyBwaWVjZXMgam9pbnRlcyBwZXV2ZW50
IGNvbnRlbmlyIGRlcyBpbmZvcm1hdGlvbnMgY29uZmlkZW50aWVsbGVzIG91IHByaXZpbGVnaWVl
cyBldCBuZSBkb2l2ZW50IGRvbmMNCnBhcyBldHJlIGRpZmZ1c2VzLCBleHBsb2l0ZXMgb3UgY29w
aWVzIHNhbnMgYXV0b3Jpc2F0aW9uLiBTaSB2b3VzIGF2ZXogcmVjdSBjZSBtZXNzYWdlIHBhciBl
cnJldXIsIHZldWlsbGV6IGxlIHNpZ25hbGVyDQphIGwnZXhwZWRpdGV1ciBldCBsZSBkZXRydWly
ZSBhaW5zaSBxdWUgbGVzIHBpZWNlcyBqb2ludGVzLiBMZXMgbWVzc2FnZXMgZWxlY3Ryb25pcXVl
cyBldGFudCBzdXNjZXB0aWJsZXMgZCdhbHRlcmF0aW9uLA0KT3JhbmdlIGRlY2xpbmUgdG91dGUg
cmVzcG9uc2FiaWxpdGUgc2kgY2UgbWVzc2FnZSBhIGV0ZSBhbHRlcmUsIGRlZm9ybWUgb3UgZmFs
c2lmaWUuIE1lcmNpLg0KDQpUaGlzIG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2htZW50cyBtYXkgY29u
dGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBw
cm90ZWN0ZWQgYnkgbGF3Ow0KdGhleSBzaG91bGQgbm90IGJlIGRpc3RyaWJ1dGVkLCB1c2VkIG9y
IGNvcGllZCB3aXRob3V0IGF1dGhvcmlzYXRpb24uDQpJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlz
IGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGlz
IG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2htZW50cy4NCkFzIGVtYWlscyBtYXkgYmUgYWx0ZXJlZCwg
T3JhbmdlIGlzIG5vdCBsaWFibGUgZm9yIG1lc3NhZ2VzIHRoYXQgaGF2ZSBiZWVuIG1vZGlmaWVk
LCBjaGFuZ2VkIG9yIGZhbHNpZmllZC4NClRoYW5rIHlvdS4K


