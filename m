Return-Path: <netdev+bounces-250004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72732D22494
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3387630124F3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE82550D4;
	Thu, 15 Jan 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj+jOaiB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB81E5207;
	Thu, 15 Jan 2026 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447233; cv=none; b=YuUhOR0SYpQeogtxvD+YMmJGKbMo9gadys6JWlnAQtSxl5L7upVYYeaxOSsx3aYN/Qfw6H/4mMCQ+XtmQlcELQL6tznS6LkAR7KdBLt3Q2pHlouh8CQXKOHNBpec1TCZcOrtpac5eF/peeyrSagLP1mT7Fs8lMlu8Od+c0luaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447233; c=relaxed/simple;
	bh=NZBpd9t2dldHK6s4UhFBzTXNvxgBqXHlaYvR/qr30rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmum3DHrbKevijo8ZcQ5XMWT0pSCaj+7z4nyx0x8v2Jr0HLWcf8pXBsL6nfzsLHNRiXN92aYu2JiVMnyyEx3vqObFmAmEOxUoP5vQK4d6NtH9QhY+r4EHsaeXUEVxykcspDq8kAzWzPQr7Okc/4m0EqqcDG4LleJFFo317fN/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj+jOaiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A0C4CEF7;
	Thu, 15 Jan 2026 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768447233;
	bh=NZBpd9t2dldHK6s4UhFBzTXNvxgBqXHlaYvR/qr30rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aj+jOaiB7zFl09qMBn2aj2Ned+uil/px7IejjD39h0g5I02X/RboOjclmd+RDbmwe
	 NmpA6fmbjMjr47OeguoANjamUlCczqurohFhWRDClOZYOOIoT3JKxHjnd9ZNlhNcJg
	 iOvZmEAGazei5Rv2DiRJ7NVyCVMsCTTC85d8G2d1la+TuMiqnlrfYExjz3Q7dWWIOK
	 agwrzvr/UNPzCePYlbO1JJKGDULq63pdtMlg4cpLwfEDJoS73Al9QZ2ZtNKhMF2Vk4
	 jHeJP4ekef8FBgyG8RVSybt6GqgD8U7wP3FlMOtQ/vin8soqNXi+s2F8RksZMG2ASd
	 kvrxJeCGTwulA==
From: Jakub Kicinski <kuba@kernel.org>
To: jibin.zhang@mediatek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	matthias.bgg@gmail.com,
	horms@kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	ncardwell@google.com,
	pabeni@redhat.com,
	edumazet@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [v2] net: fix segmentation of forwarding fraglist GRO
Date: Wed, 14 Jan 2026 19:20:30 -0800
Message-ID: <20260115032030.1539127-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111112355.21504-1-jibin.zhang@mediatek.com>
References: <20260111112355.21504-1-jibin.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fix segmentation of forwarding fraglist GRO

This patch adds checks for frag_list presence and protocol consistency
when handling SKB_GSO_FRAGLIST packets in GSO segmentation. This ensures
XLAT-converted packets fall back to skb_segment instead of skb_segment_list.

> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fdda18b1abda..6c2c10f37f87 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -107,7 +107,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
>  		struct tcphdr *th = tcp_hdr(skb);
>
> -		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
> +		    skb_has_frag_list(skb) &&
> +		    (skb->protocol == skb_shinfo(skb)->frag_list->protocol))
>  			return __tcp4_gso_segment_list(skb, features);

Should tcp6_gso_segment() in net/ipv6/tcpv6_offload.c receive the same
treatment? Looking at that function, it has the identical pattern before
this patch:

    if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
        struct tcphdr *th = tcp_hdr(skb);

        if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
            return __tcp6_gso_segment_list(skb, features);

        skb->ip_summed = CHECKSUM_NONE;
    }

If an IPv4 packet is GRO-aggregated with fraglist and then converted by
XLAT to IPv6, the same protocol mismatch could occur when it reaches
tcp6_gso_segment(). Paolo raised this point in the v1 review:
https://lore.kernel.org/all/aab6c515-12e4-48ca-8220-c0797dae781f@redhat.com/

[ ... ]
-- 
pw-bot: cr

