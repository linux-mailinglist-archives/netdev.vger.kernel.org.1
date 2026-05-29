Return-Path: <netdev+bounces-292946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id snNVC4H0GGqQpQgAu9opvQ
	(envelope-from <netdev+bounces-292946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A05FC43E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 118293017AE7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78C351C3D;
	Fri, 29 May 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENfqz6J8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292733ADA8
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020350; cv=none; b=DRGRrPS94TH7WAdDNTM3ecoOGhoT2dR4aUjm3SEEeqXuhpTamispEfpnn+8j6GHk/5ym3iqZetG5O/RNZPmkzphFfVAkwvgVBqSLtdsrPChf9eiB/kj9rQalF45013qeTgGwBBe7iRCbJKPdDIFPYBoe6UwzFoNVraPRH4T3PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020350; c=relaxed/simple;
	bh=S8jF+5xtE0kvYAge5w4YWFo9HvgjtnuqjnLd+ZoZFRI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MD6/SX4eBNLlJuZAVQHEsXRP5NIxjaUvr+Ce5Mbj1pJA5zOSwlGqJ/xjBBx+RYGGEZ7gq+00ocUVZuG+Xlkc83eF15OX48fnRiql22Lk/hfZmk29CienogIZQe3OSZ1/+P+EkRSFI4LF5xSv2/JCIzPRcsNkHe1OMgBLVaC9lZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENfqz6J8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dc67a5e102so12816727b3.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780020348; x=1780625148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eKxmPzIBmWYYYQ8Fbz07OQNOOCYYMjRNgpd0FtGS4c=;
        b=ENfqz6J8Z0gGHbBB42K/spYTQTn51+gnkd8se27bjuFkLJjv02KjkXRDvAX66dyzBm
         QJIap2FxFrBJURlM+Nd5XoznLi95/Ay7lRMtrHa3j6Jt3w4BPKeKapdBfdbaQvCE4BWS
         +lDRTG9AfM0w2Qp8ZNduRjLUZI1XIYI0O1Mjy76zcCzu9yY42xg9yrgbLiIIA6rli8Bm
         Gpr2MCKvdbzhSPsBbjq/vO1FgTI1Q7d3kp7TpBZi6ko6TTCm2Ho04N8653xto6RPAp+f
         rZVisM0afLsiX97yFNMWxYQ2Wn/n4Q6uCnPY7sZ6mrpORDuPwcgbAvgQbREOs8ckhkYc
         EUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780020348; x=1780625148;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eKxmPzIBmWYYYQ8Fbz07OQNOOCYYMjRNgpd0FtGS4c=;
        b=SHeXOdyJWKpbe7dZl0+cXEOucIiZIC168JAW8JxsmFGXqZEmi4a67O5WS0HOloBKu7
         fbibLSUQZcaC7CoSuh+P4wZI5PmjcRVlb+Jh+bvIQss265hJhDfSh2obL1nByS+A6VS2
         nmzmNtkEr6rIZiEKtpQdePd+9Lb/rOJGjQf7CBc161WAMDPNIUjlZsC/Yb1rPMEMAnaQ
         q85DHlx8oEKjvBUrhsL4ii3X4Vq5NvtQpMObrgLokIHDMVczP1bynADSYaXg031blae6
         /PUP+ChPgWxN/llAVDoh8O8M3loE2rDag/zDc3ODHTl7tQk5jdq45mJslpYC3NbidB++
         p71g==
X-Forwarded-Encrypted: i=1; AFNElJ/SDF/Y+YTIhyedZfLn7qMpTXf+SRJCObVHQWj3y1Q4CumW61EjzDxCZeOJQ4sYcAKCF4oEmUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uro4EcM6LJqh3NOJNnO9KOoNybwj8ngb96npQYmBZcXrCF8N
	x5RIRkFYxlnRaj8E3jlm53oPuL843BbB9VxbGG56ZBRhM1uHXK0Y5dTm
X-Gm-Gg: Acq92OEfsxXlXgsfpgRclgw1av32GBHI2Ql0PN0HQvCsPcWFeaOfEa/NZbsregReUxi
	gLceCZlMwj+H2wwTJeyGuTlhH3exl7c61cFu4HCjO0sucHT6KFh9miAfrRVUlC6ff0gASZxdqSc
	5EZFri4BHodPAs5jpEhnbkwVwzLRbHz55cY5E0sJGZQ5Q+pshHeiY9ZWHFq5ig1Q9Fu0R3UiCJD
	FBoV9l2H3BeLv6STWwo1ShdeSymFHQOkOsyQroMbi4O4jqQXijrSdg2AT5GKEZ3Y1Qk3pP8Ej0p
	M/eobN0u34KHCDCwXfvLvfWBmcFcsXbOu+oVPJ/+nu8rRCdMX0gAzGiw/QfWAELup6uwACuracc
	5MvwNPKTj8YX1mmZUKIoI6jR9BfS9ZO/q8jx1oacMdR7K2ahwLl4Lh2Pa5k7eTpOE25aDLb8G4I
	NU2H2bf2OjzZOcpl2+4Z4QreHoQ0f+MIPMCHw3ywR7naZLUwv6/WA1gwjf/ufiQtP4u87nYll2y
	ns82MaaG84kdmcrYg==
X-Received: by 2002:a05:690c:3582:b0:7bd:8752:cdbd with SMTP id 00721157ae682-7de4c1ef287mr7045187b3.41.1780020347801;
        Thu, 28 May 2026 19:05:47 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de687f1b7dsm1474487b3.17.2026.05.28.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 19:05:46 -0700 (PDT)
Date: Thu, 28 May 2026 22:05:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Minh Nguyen <minhnguyen.080505@gmail.com>, 
 asml.silence@gmail.com
Message-ID: <willemdebruijn.kernel.1b32eaa32d5ee@gmail.com>
In-Reply-To: <1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com>
References: <1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com>
Subject: Re: [PATCH net 1/1] net: skbuff: fix pskb_carve leaking zcopy pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292946-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B5A05FC43E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pavel Begunkov wrote:
> When SKBFL_MANAGED_FRAG_REFS is set, frag pages are not refcounted but
> their lifetime is controlled by the attached ubuf_info. To make a copy
> of the skb_shared_info, we either should clear the flag and reference
> the frags, or keep the flag and have frags unreferenced.
> 
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() don't
> follow the rule and thus can leak page references. Let's clear
> SKBFL_MANAGED_FRAG_REFS from the original skb to fix it. It's the
> simplest way to address it, but there are more performant ways to do
> that if it ever becomes a problem.
> 
> Link: https://lore.kernel.org/all/20260523085809.26331-1-nvminh232@clc.fitus.edu.vn/
> Fixes: 753f1ca4e1e50 ("net: introduce managed frags infrastructure")
> Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/core/skbuff.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0d3cc115f2e7..c02f0a507ba8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6823,6 +6823,11 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
>  	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
>  	skb->len -= off;
>  
> +	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
> +	 * while refcounting frags below.
> +	 */

FWIW the multi-line comments are not really needed. The function of
skb_zcopy_downgrade_managed is quite clear.

