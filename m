Return-Path: <netdev+bounces-216541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B22B3468D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3E2A47D9
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8E2FE065;
	Mon, 25 Aug 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="FHEKm+tL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9aqv0+X"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9A1E6DC5;
	Mon, 25 Aug 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137584; cv=none; b=r9672TgUta9b00yD1MoQ0X+bktcDWQRxAolcFb1JgFpesaUD6Enn8LYAoK9HAbBXP75tKMJSw4cxW/TC1pO696W8K/8eahGxIMHwLFknto2YSyIa/dBSTGaNhMuFVsxEsrU0hQX/koOunfabEwnUVLl5lLr1GdxKzK+Na6+T8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137584; c=relaxed/simple;
	bh=6AVyzHI2iFYDIZFegDLOeR2XzbkDZjqX9Z+YpuN4gbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilgxQbhMcODXZoM2/R765qFkRPFSRVFHp7JTRh5kQ3Mr3uyuKJ88fjt+XIw4NhrgDeJ11eD+4M+9HgqzfoHqlP+fSUANe49Tl7I0IedVFPukfW8pu7mS7eGFgsxSWMoOlkfnJzDFgiL02pVppUVjbo+DZCBWrHXy6NaGQQesims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=FHEKm+tL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9aqv0+X; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A6FD7A0155;
	Mon, 25 Aug 2025 11:59:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 11:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756137579; x=
	1756223979; bh=vq+5e3Yyps41AjCQBIP2V+Qv6mMRbzV5pkZiyZR0hbw=; b=F
	HEKm+tLvK5y33M96+a6GXefgaEMQSPOVG1mDYn4oqklyECFY2Ha6miWa/Gxv93b9
	c2URDyE2EhfF45PqAbnlmYU/vkjn+4oTsKvSaNnReUQiMBnxO6KVMiStJy0OB6/I
	Qz0UMjXeeVUMy21NKQ4X0B7TgYxmQ8oSrkzmOXYj/sfR17tb7OUFDIVqbjlbUnYp
	LOQo0DliENOxjyURbVWDlkkrebccr2HTW1KCXjtZsJJlNyi1GePfPrbBSbxTvLrd
	b5ElZmAnGriQvvnTT5ZoNigvno8Z+fnieu6wAVzQgPMsbJO4+UdDosEKDGA9AYu+
	u+sb+oyo76qvhOtLFot5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756137579; x=1756223979; bh=vq+5e3Yyps41AjCQBIP2V+Qv6mMRbzV5pkZ
	iyZR0hbw=; b=X9aqv0+XO1XvOcdk18qBgyXCrRr3cvRKYn+qCd5E28NB4Zr85ex
	iI8Cxv9WODIx3LdTQTCQmO60qJNyFTmBsjAfea9gE0lMfQrCNJIa2hB9arkNSb04
	kUWNt7H9/yu8pKa8DS3MdtjDRFQ9IWsV/h9kxqkfG6TSP3dM4E7ZVkiooM9px2yt
	VeD9oqIrQSseIRhk4yY33u9r2qLJH/Qh3MG8oF6MqCiETUrtC4W98oogATdZNgXa
	rDI4I0o/o0gD54Ka3NBu9lXJVMK+7tUTTki7tVAdWNjC0mXlrrjqzuuCAeXhs0H+
	LllknU31Rt8g+HO9zxWtOILzGL5gsWphgvw==
X-ME-Sender: <xms:aYisaAwXdbdP2YFhW1CJZSXJ6R9jQAenL2gno7t65L3kgJlKomDWKg>
    <xme:aYisaOWiiY8Bz1j60RLMcGe-pA4_VSh_siXJvyfCmi8Y25mKaJnYLLgIwIBV7DTGu
    Cj8gosYXWENN-lo93g>
X-ME-Received: <xmr:aYisaHRlupQeaJsMH2dWAtv2LTpYX6UbrmLUzd-IjzJrihd633bgBJO6RelO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhephffggeeivedthffgudffveegheegvedvteetvedvieffuddvleeuueeg
    ueeggeehnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehq
    uhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshihiigsohhtodgrvdehvggvleguvddtugefudgvgeek
    fegsrgejsgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtph
    htthhopehsrggrkhgrshhhkhhumhgrrhesmhgrrhhvvghllhdrtghomhdprhgtphhtthho
    pehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtth
    hopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aYisaGRNYWN8XUbRXSo1XLU7X01lUUf0R7E3kyPoTRUjfahUj8GH4Q>
    <xmx:aYisaPe-62lud-H2T-SO9ug5LwT5KG2Jx7GfVf50kzsZsoilJ2J6Iw>
    <xmx:aYisaMeGHeyn8rrNYKwr7wwGGRh6adZyLNGNhV5EfN76vhAcCKuFYA>
    <xmx:aYisaDZ0nRF8CMIUP9bm5s3z4C6mGaLs1CzxAuaDI4QzQVHbQsK4vw>
    <xmx:a4isaLCE5E5hNDhT-w_7qzDQ-ds1E3I67e2CFxrT0NgrQH9jJ2NWPMdj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 11:59:37 -0400 (EDT)
Date: Mon, 25 Aug 2025 17:59:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>,
	Aakash Kumar S <saakashkumar@marvell.com>,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 __xfrm_state_delete
Message-ID: <aKyIZhcJBH1WyKYQ@krikkit>
References: <68887370.a00a0220.b12ec.00cb.GAE@google.com>
 <68ab6633.050a0220.37038e.0079.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>

2025-08-24, 12:21:23 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1411b062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
> dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

This splat seems to be caused by commit 94f39804d891 ("xfrm: Duplicate
SPI Handling"), which removed the "newspi != 0" check before inserting
the state on the byspi list. But __xfrm_state_delete will only remove
states (in this case, when they expire) from the byspi list if
x->id.spi != 0.

So maybe something like this?

-------- 8< --------
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..d213ca3653a8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2583,6 +2583,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	for (h = 0; h < range; h++) {
 		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		if (spi == 0)
+			goto next;
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2598,6 +2600,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+next:
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			goto unlock;

-- 
Sabrina

