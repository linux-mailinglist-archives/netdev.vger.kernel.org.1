Return-Path: <netdev+bounces-290347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDx+KiLoDmopDAYAu9opvQ
	(envelope-from <netdev+bounces-290347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F815A3C3F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA370319467A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF63B1EEF;
	Thu, 21 May 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GwYgdE8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkaStqJ8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68363AF672;
	Thu, 21 May 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360972; cv=none; b=jJnCVEv0SMabNrRUJ8B8vZDXLuRSiMymO6fORrPk163zyZYTsA9UoIshk5LYq4PCNb6o6CDgtz1IRgpVFgbFLpzbPMYjAqphjhXWNlaPavjOh4j9a3U4hYGMjA1p/pRUfmc5tP9ZGtOB2HnkkQwPgUxW+oWGmbMeKeOpTcYuH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360972; c=relaxed/simple;
	bh=HdgAufzMo61uM22rbw6faQGCVRySPPSFazrbbi2o/Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHtGqj5rrpOFa9zuqqPWBruI2hZq7/uwtytgR7e8ZiqQE7jl7iclVgzhSxXWr5O/1CuxiUMbl3ELho9NkJmmt9HN1zpoybWhQ/N3TL3NL8VvXo61OFIlfnMRxpyTcSJ1IxBrq3XeGWK2LT+eZ8UydOGLEH6P6kURAogqsdAGLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GwYgdE8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkaStqJ8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 781A11400083;
	Thu, 21 May 2026 06:56:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779360968; x=
	1779447368; bh=S3GyllGLRsLLXKYpBIHnKuG0i9VwuiCh/RrzcdNdBnk=; b=G
	wYgdE8mZgjFG7JSVa/IoxlHI5wwm1yVKWHYMyQIzANGB/heD9Fl7Nv5xSir6za8r
	4MUcANIKyQvdo4r9yh0QuNR5Lfhh91eMlFDPcjAiyAdax7gQH9Rp2FGtidoc+LWm
	YU/2Qs2a9gfBqtkL4OqbbQ2RYhNHzrogICeyGdYwsDuG6Nk3g+EEz2DiGpDmaXdX
	uNCk5shD1xnTruTGr/Uz+bVMybB1uFcwhPzmuQdZ9/ehJcHUFDtJTWh2NAAz9RtS
	KYwRsOLftT4C6j6Avhf1zW/FdU/XbAMwv8svqKaz5F+cB5ad/Qu1jBAnIQJMj6uD
	Cw161dLolZ0EuWA9qt9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779360968; x=1779447368; bh=S3GyllGLRsLLXKYpBIHnKuG0i9VwuiCh/Rr
	zcdNdBnk=; b=mkaStqJ8jAmxh2SE23JmRbp4aTJr5mdx8UR5hktKYFfLgGslg1S
	xMrkhYSCw8MRUAnCJwBvf4uH5G4l1KsPpYHjGc6de/Oi6CIHXpEynfCkWM4iMaRA
	+4+QAtarS9IzxAQSTLZ76VV3Nco/AtZkv7cmJpaOP9TFzu356S/Vx9H7HP9EwuHJ
	NDX2Iiv7dCzswKSskg9RQaSdnJNrsGf0jI6c48XptXQ/ETBMlG6l4z4Dw5pBnck1
	uiMy+xhnc7csUBRdEpZu4wrgOcX+G0O7xvoQcgZj4YwrEcLIGnEYuxO390USgJJS
	6UhwiXgFObcvm/+jrxMlyYqQ5JCwD0vUfjA==
X-ME-Sender: <xms:xuQOaqHP54tU21MvYftPaIpTRjMogNWn7-HrClpHtavVc_iWOiR1gw>
    <xme:xuQOaryAVBBo2UJZ_XJEHq9m18oqYSIyhCUzpjpek1R4OVpSf94oxPhcd8_2Rs5Rw
    L1LhNRdbb1dpc_jl-CLX6neeTf_cbJwPhHlxfTjYUoL7NbpOwY_plpN>
X-ME-Received: <xmr:xuQOaj4o1_VJaCZ0q4RVMJSwrhy1J2Ai836CnDJ_faO7yKLiOPuYGnN52Bn9ELxKeF6d_W82qRtaQuGb4lAU5O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrnhhjihhnghhguhhosehhuhgrfigvih
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhgvnhiihhgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehm
    rghlihhnkeelsehhuhgrfigvihdrtghomhdprhgtphhtthhopehmihgthhgvnhihuhgrnh
    eshhhurgifvghirdgtohhmpdhrtghpthhtoheptggvnhigihgrnhhlohhngheshhhurgif
    vghirdgtohhmpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuh
    hnvghtrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgr
    rdhorhhgrdgruh
X-ME-Proxy: <xmx:xuQOagemfS6GGEuKLgYpWhyutk3X0q23cX4Rk3U4F0VU6E9q4vhV9A>
    <xmx:xuQOaqEFyemaRpqi-xQgvfrBzr4TkMsSl8c2H2XhetN0B7INLL2tZw>
    <xmx:xuQOag5rxacAw-BRI3p52CqeBkPI_1TP7LAQBU57JwLDYmgkkyOU0A>
    <xmx:xuQOatuwdrYTlJq-yN3CV2px-ZEQyY8fEXPzbGRtZxTa5sJpbA6euw>
    <xmx:yOQOau-NbuutTtqPGBmduBHSTT2sT4cQSOm1vgSmu5SW-u8XzIjsHXYZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 06:56:06 -0400 (EDT)
Date: Thu, 21 May 2026 12:56:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: tanjingguo <tanjingguo@huawei.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chenzhe <chenzhe@huawei.com>, "malin (R)" <malin89@huawei.com>,
	michenyuan <michenyuan@huawei.com>,
	cenxianlong <cenxianlong@huawei.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] xfrm: esp: restore combined single-frag length gate
Message-ID: <ag7kxJ39XQaVY1Mb@krikkit>
References: <48c8f59972cc407092834fb73e06ff2c@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48c8f59972cc407092834fb73e06ff2c@huawei.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290347-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 13F815A3C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

note: patches to xfrm should go through the "ipsec" tree, not "net"
(with the subject prefix [PATCH ipsec]).

2026-05-21, 07:52:50 +0000, tanjingguo wrote:
> From 1e6d45378b272fe2f1fce48ed89d6eaa415c00c2 Mon Sep 17 00:00:00 2001
> From: Jingguo Tan <tanjingguo@huawei.com>
> Date: Mon, 18 May 2026 17:06:48 +0800
> Subject: [PATCH net] xfrm: esp: restore combined single-frag length gate
> 
> The ESP out-of-place fast path still consumes the combined post-trailer
> skb->data_len as a single destination frag in esp_output_tail()/
> esp6_output_tail(). The head-side gate must therefore reject any case
> where ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) exceeds PAGE_SIZE,
> otherwise skb_page_frag_refill() may fall back to a single page and the
> destination sg will overrun it.

If I'm following correctly, the issue comes from the
skb_len_add(tailen)? So esp_output_tail() does skb_page_frag_refill()
with [what we checked in esp_output_head() + tailen]?

> Restore a combined-length page gate before entering the page-frag fast
> path for both IPv4 and IPv6.
> 
> Fixes: 5bd8baab087d ("esp: limit skb_page_frag_refill use to a single page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
> ---
> 
>  net/ipv4/esp4.c | 5 +++--
>  net/ipv6/esp6.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 6a5febbdbee49..2d7daca8516c2 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -410,6 +410,7 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  	struct page *page;
>  	struct sk_buff *trailer;
>  	int tailen = esp->tailen;
> +	unsigned int allocsize;

nit: there's already an allocsize variable in this function. no
shadowing please.

-- 
Sabrina

