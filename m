Return-Path: <netdev+bounces-288340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE5JLYU5B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41027552082
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D8B306D175
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314D3C8C43;
	Fri, 15 May 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SpE0mLi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f90z6Mcw"
X-Original-To: netdev@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628F37187F;
	Fri, 15 May 2026 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858171; cv=none; b=DUmZfW0WcFnwpG4Eer9jtOq8guH6opzmu1zRHMdOleC1ZgVSk+RDvqjfQDiW9180DDZ/8HxWQvKAa4ONOcX5GkI4X3FU1ub+ElBaW3xMwf2LqV0CrTBs6gExGLhyaTRmy9IDyM5dHRpN6wxnwYHTSGzpNMquHEqqvU1YG5zsyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858171; c=relaxed/simple;
	bh=D/xuaDGwPLUBL036bk0uJhbi2HUM849uBA1N2mT6730=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rb28ymKRzEdXn2+8qfZbps14Z7pmes4vcmV5UwVfpiITbYigPpQvubWawWwsPytr2S25kC7A33NCa15GrZ24B49KHJ7LNDxJOvhyhbkFCiKKJHXOJVzjxOtH1H6fPUumXyeAqrFRU1difk4BEYrZyYyBeDuqCws3j1IrlpRoFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SpE0mLi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f90z6Mcw; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 94470138040D;
	Fri, 15 May 2026 11:16:08 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778858168;
	 x=1778865368; bh=J4ckqZIWQV1ocroUGeQi74weQoQtp7XwfxKqP7cAhnc=; b=
	SpE0mLi/5H5t8/WiJrScmiVEJCZmZNzFAJos7clC7t6G27l/wyd2aqsVwo2FK0gw
	J9Fh71EwH5lufhK9vUnafVNfr4CF99AaVFsxhvKZgvB2rwzcU/qfX1YvMhumCyk4
	VrdmQhbI9bh7g+W94cKzmphOIfxBHEEXuBj3MP/3nS/5P+WaJRr1W8avAKbow/H0
	5QFf4GGGToPc4y8waaBvDFBTWvaHNnl+MOgbu3gIJg+q48aXBEs3yhOADJJU60fx
	Drf6I++li/cVmxWV4PCMSle8YxRwaFHz2upM/eTvzfaLeco3JzoT90kOjI9LztN3
	suAEvtVjwviraRgmquQi1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778858168; x=
	1778865368; bh=J4ckqZIWQV1ocroUGeQi74weQoQtp7XwfxKqP7cAhnc=; b=f
	90z6McwpyXyWDKrW7P4DK8geuJNe05eo2VbfdMnZ9lZK5jy0djD6ZoQTMCni5u3X
	Ti7ghwZD4B/L/3mM6nKmz0lTLGdlRDZAmTowppCOwcAX3q85XfnGPRvr+0TOVGFd
	uo7r294Bsi1Qs6Ce754ec5DN/R5zFnAuPLbXrqf5xN8iLCKtaBICmS8vzctwiV1E
	e52dZR6FYUdYUHeVAGDHGxZqunVlBAF8ksCiSWqMGynC6bXdOKbyrmuO1XrV751/
	1uv2AIhOZPNhNAZspDwgd14kjq64c5LyDp5+tujSevbu0Wos4hkozuYe7HbZCiNr
	h/nHZK2F/nJfpRYHFCtXg==
X-ME-Sender: <xms:uDgHajcnNS8FlzUOJpNstBevDI20ei5RGCkCDgyFOmteSCFmVDH9hA>
    <xme:uDgHakDwH48TweiH5v964ItQQKIvHm62QsF2TriRy4z3BsJrUnrLchJM8AToXp4cs
    9NRfWWxInPksG0O0kN75rdWB7MobsuZPlsojF2qeSE_ldPKK2lqiMmy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epkhgrfhgrihesfhgsrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhm
    vgdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvmh
    igohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:uDgHav0grKTUvRJbwKOOu55TTY2TcYsTA_e-i-amNCPMFw5u2mb5aw>
    <xmx:uDgHaiChU2CXfS3FM8cs_uK54BIVVnVAaFb3iTZ9r20HS49y0L5fmw>
    <xmx:uDgHaoaam7id5OiJw90OuIdz956nq0j1-PwU3bO8w1L1Bfy_CwV4gQ>
    <xmx:uDgHauY_eYD48nz1hHut4PYvsnBsnmsqRnrL3mudrFdrZHQkS9Jt3g>
    <xmx:uDgHagCHfw_iqF2buV0AbVq1dWjVW--bWaXkkTFt_OgwEKl0a2eP5V9I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 032091060065; Fri, 15 May 2026 11:16:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Avg9O9r9re3Z
Date: Fri, 15 May 2026 17:15:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <kafai@fb.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
In-Reply-To: 
 <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
References: <20260515113102.2389020-1-arnd@kernel.org>
 <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 41027552082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-288340-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote:
> On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
> 1k?
> pahole -C xdp_test_data
> /* size: 192, cachelines: 3, members: 9 */
> /* sum members: 120, holes: 1, sum holes: 56 */
> /* padding: 16 */
> /* paddings: 1, sum paddings: 36 */
>
> what s390 doing to make it huge?

I think it's a combination of cacheline alignment (256 byte
lines) that leads to padding before 'rxq' and at the end of
xdp_test_data, as well as CONFIG_KASAN_STACK that increases
the stack usage further.

> Probably better to rearrange the field and fix the root cause.

It looks like this change reduces the stack usage by 256
bytes, and keeps it under the warning limit for all the
configurations I was testing:

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -98,8 +98,8 @@ struct xdp_page_head {
 };
=20
 struct xdp_test_data {
-       struct xdp_buff *orig_ctx;
        struct xdp_rxq_info rxq;
+       struct xdp_buff *orig_ctx;
        struct net_device *dev;
        struct page_pool *pp;
        struct xdp_frame **frames;

I still get 1368 bytes stack frame in one config (with KASAN_STACK)
here, compared to 392 with my patch. In another config without
KASAN, the mainline version has 1344, the rearranged xdp_test_data
has 1088 bytes and the dynamic allocation variant uses 200.

The one-line change is probably enough to stay off my radar since
it stays below the arbitrary warning limit I test with to find
regressions, but 1368 bytes is still a lot, so there is a good
chance someone else will hit this again.

Another alternative would be to allocate xdp_test_data statically
instead of on the stack.

Let me know which variant you prefer.

       Arnd

