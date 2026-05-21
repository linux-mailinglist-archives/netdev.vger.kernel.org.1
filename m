Return-Path: <netdev+bounces-290429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA8GFiQOD2qSEgYAu9opvQ
	(envelope-from <netdev+bounces-290429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:52:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4715A663F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8AA131602B0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118F63E5ECF;
	Thu, 21 May 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ExgiZAUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UE7If3g3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A53E558C;
	Thu, 21 May 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369313; cv=none; b=CZEeoKc+I1NQDec6N6ZZGGfTNSi+IMHFsprNTByY7Lb5/wcB7fq2TGHJUeO6AeKS5Jrfsdxnx45KWz9pwyXreYSxpCau1XvM9Y5DJPSfqBg09NNJ2I7qoFdg5RCWQUPSUm7RU5KlUykA/evrnuMcbxEvsHSxTI3oj2iMz6qUOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369313; c=relaxed/simple;
	bh=rxY/yWq4U2RXo/R7SfUdSQiZH8gygYqFnFbCdYGWyG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6tuTEaptNiGz6P739dQMDROTK5AHMPUZRqRJJEZIBJgvV9/yBOadZeZlFGx5iF/oXTWrj4otjVnAGMlyvTw0w7xlxBp2C3TUV5sHkk8aGRzl4kjHAn2pk+xBZuT47hXdeNcUNecGIgXoRjYouqEEwlu1VpIqRRqqXLq7vwP744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ExgiZAUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UE7If3g3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4609B7A0079;
	Thu, 21 May 2026 09:15:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 09:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779369308; x=
	1779455708; bh=c959cyZ0i45KPviPyyVWOMD2q+QfD+rOSCKFLoaZ5PQ=; b=E
	xgiZAUqtKQ52mo+yZGjQmY9GoGQKC0Uj3mJLmW7hSh7w7AunrnjO03xLctfkdzZu
	76odmj60dH1R98RxFQXFlJvv9IaYYw98YXFtjm7CRkHzK3C5M7KD33djr2LGlSVr
	BsQPG9dRlnCSjZdQny+S+NbwOgWiSuX1nsc3gbu/BLkb0hZp3J/VdTmm4kcsH3xX
	NMn06tM6DbOGwuLBq4T4Emwu83Yml/N5Ow5MHhVYLoecy+QekqWeYjM9IHbh50Ev
	aW+7/Ru5/KciQPUFjjsF3a5nWbAj9v38ITWgsj8N/ePmxkqEOJIjV3N2DPDMisbS
	2u2e+TPNyAn8JohJxlTVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779369308; x=1779455708; bh=c959cyZ0i45KPviPyyVWOMD2q+QfD+rOSCK
	FLoaZ5PQ=; b=UE7If3g37x9HsUF9/DhEEeFhLhd0ggHGZlI4Oj67byTzdHczabS
	4fTJ9VVD1J/ACvSUyNNG1gHGbuLLhnwvSrpSmGL0fH/IjloSo0ak//urNoQjFBfN
	fpF7jqPU0U/1rGKu5FwUzxHgFtNp9l6iYa1ywNGHmTfjkA+XsXD3BvrUHcy2u0Hy
	TxmMMGzzkJwYROzsxqiDmdEkdfHmIRmRwHf3ijkQ0BFjAPunJMmTnvn9OKhY90Dl
	u2nFlmV9SAfNv4EWVgAcvyTZDhCwsrQOzZMcEAMo8CVJI1HjzQOb7VC9owfdvtRV
	TQznYd/sa67Dtk1PCw5IPE38tBahyuG5oNw==
X-ME-Sender: <xms:WgUPaozq9J5wzHPlR-01U_vj2XxbNVp3WE8w4d4oFNuPgpl2kCsCzw>
    <xme:WgUPassYvI1hscYA-2ePEtIKoIfgbAeaxDdnrGINwiY5Myb5HWVquNiVr0mAIiVrA
    VcY7FIZ0MYCKaf9JxoTb_JkeW1mcfs8tMDSVgZzKkmzYt9BBi6QmDE>
X-ME-Received: <xmr:WgUPaqFgZJ1D-Gijw6p_e1iQXlWY8GQXnn10zzhPf9me96y1eMI-Y0DjV7o7ROZbutvFWsEdBIp2gL8KiXQGD2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtrghnjhhinhhgghhuoheshhhurgifvghirdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhvghniihhvges
    hhhurgifvghirdgtohhmpdhrtghpthhtohepmhgrlhhinhekleeshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepmhhitghhvghnhihurghnsehhuhgrfigvihdrtghomhdprhgtphht
    thhopegtvghngihirghnlhhonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehsth
    gvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehh
    vghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:WgUPai6aizvfFdprjKX9G4M0k7wGvXzZYr54IYQP2DxulRyU1JC9Wg>
    <xmx:WgUPajwECeh6K8A1YgFQ_G0BE_Wh22ss6efPQUDTVcFaQI6MCjLchw>
    <xmx:WgUPag0VqIj0e8ENfeHtVKrZYAOA7qqfPhgui2UMoBibrcV20NgoUg>
    <xmx:WgUPam4syPSoCT1v5cOSZM3qahsKoVWCansK539vLTdFI57L-HQSqA>
    <xmx:XAUPanqCoEixzjWXi2X9zRWtvMPQvjLA_vPBw2eV9dEJGmg19p564ShO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 09:15:05 -0400 (EDT)
Date: Thu, 21 May 2026 15:15:02 +0200
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
Subject: Re: [PATCH ipsec v2] xfrm: esp: restore combined single-frag length
 gate
Message-ID: <ag8FVjyh2ZoYuSbR@krikkit>
References: <ab4c5808478d48978292c318d85c4484@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab4c5808478d48978292c318d85c4484@huawei.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290429-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: CE4715A663F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Note that you must respect a 24-hour delay between reposts of the same
patch:
https://docs.kernel.org/process/maintainer-netdev.html#tl-dr

2026-05-21, 12:00:55 +0000, tanjingguo wrote:
> Changes in v2:
>   - Use the ipsec tree subject prefix.
>   - Clarify that esp_output_tail() allocates after esp_output_head() appends
>     tailen.

Thanks for the clarification.

>   - Avoid shadowing the existing allocsize variable.
>   - v1: https://lore.kernel.org/netdev/ag7kxJ39XQaVY1Mb@krikkit/T/#t
> 
>  net/ipv4/esp4.c | 4 ++--
>  net/ipv6/esp6.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 6a5febbdbee49..c62dfe049ee7 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -419,8 +419,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  			return err;
>  	}
>  
> -	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
> -	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
> +	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
> +	    PAGE_SIZE)
>  		goto cow;

nit: you didn't need to wrap here, the total length of this line is
under 80 columns.

But other than that, the fix looks correct to me:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

I don't know if Steffen will require a repost or apply this directly,
so please wait at least the standard 24 hours.

Thanks,

-- 
Sabrina

