Return-Path: <netdev+bounces-245892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD988CDA4E4
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2191D3085CEC
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE834A3D0;
	Tue, 23 Dec 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzVZCrYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8A30274B
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516477; cv=none; b=Ue10yVOKvAGkyHW47JE0EScCxUQDYI62UILyg6e5J9QM9z+ZnV3sg55AwNQmY0N5nQ3t18eAXa8lhXQOmBD12CHvDtghxBrSXI5H24LF6FjgtdG3e06R3G65tMmWxNRRUeAAxfEw8daDLJQsEdW7KbxJu4YsC8Dgp+37cV1Ic1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516477; c=relaxed/simple;
	bh=5sPCUucu+LKNC3DxCKK37kr4+kpDzrPROK9bTcUINDA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ux6wB/S0UK731ioOGSu1xFSdX7sEyZegT/KDJR8JuxeMCxv3ddre/8liD8tG30+Zx/3Gtmq/0hiV8FJNRs9go51pUFBet2tELDIUKtWeT9k4pDdBi3P8LMo7/TPyXlDxllfBCfvTPeBzMhTx6rx4iHloZRKqyZBDJ8PJtm3ugcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzVZCrYO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78ac9f30833so37399717b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766516473; x=1767121273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx0jOvF6tZS8pxKHJ8Mkyoco4/zguV4NZ9A2mS3WuCM=;
        b=MzVZCrYOtMZX0D0OjU7VlqEAYorMO9fA3iRsQ4wfRytCj5xy3CbQZSsOgg3RiNPKg2
         bdgogNw7bFIBUHrLVYOMNnDCNe5RgtHgCP9YIhYY8DCs2Bp2k7Xl9oaNGq3XM7P77jYu
         ozmXoWQ5WaRZUh2N5ITw2QcrhTCGo5qKNSEFIdJpi4tgk6thC2K1HncjjJXs42r+yWFa
         gncgVC3n0ahN5iRhwMeZYcoEbMZr8UwDOVjSE2f0FnNu0j1H6MiMaZuMBeUaMskFSuYr
         tOEz1UaQROFjp0WowFfeYO2Bjkje6MGgSgzfumRdmzpaO7SSx9GQdysK1BPBp6vWp5zV
         niQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766516473; x=1767121273;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx0jOvF6tZS8pxKHJ8Mkyoco4/zguV4NZ9A2mS3WuCM=;
        b=TKesebgTmDQwIm46a/j/BX6QmcXdL3hELXRGMzgE+RryY371Cl1AVkuNIBvB7OY2KL
         06kT1F0t6SVFn2LlMnO3AysrJR9s18pr/8N94R0tXE5OhRjGgq7O+tKZt+5s0a3zsWef
         hCJBH0uTVFI3/98Szij8hwIVe+LvrV/aUbpgjgD35O6Sb9A6EBEo2TjhkfnZbvYQs2sT
         zBuq8OtZotJmWueq0t2t6pYu1o0+a1qYjKf8/DIiD8EipKwQWTjwjy9vcASFEcewYxZq
         dbZuUuh+1ikE9dl0r6c89tzRSVX4ZBtMMlYPGx8Wge/NfT2T49/IWKBzhxsEl6mWqWq7
         DL9w==
X-Forwarded-Encrypted: i=1; AJvYcCXomimbGthBRvr8kZyTyXNyg1O0KZYlGS6fHtQg2WL6XX9hsqg3Cc1UTRbYwxXU6IndCD995Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnQcYxYrjE5av6R21GJoS/cYF+ei91cUGDM9NCMRWZ/mk8Udd
	Xn7BSVH0AHo/o1WOum1QYzSEqyrW95hO3zzgobzzbd3Lrbn/vKRUsgr/
X-Gm-Gg: AY/fxX5z1N8zCRsxY/2JTzUypAkEfioOUbC/XM3x4dgeQGk8AkrfTySzYNEC6pVz2p0
	gq0hWQ5dTaOyJFghoMFF29Ca/dGBgeynjpx+x5Dgwaf+KBXzIu3WexcnQ6Qc9tKbT+YUC/lgkft
	Qolzl4lWMnyVutCEYjzOnrTgWmTBTTp7ZKxonHjjHf919/W6JWgvUZUhhgYz64GeTFM+S9kxEJA
	4ajTqUQrHzigEHxzsb9TGfZ87adkgZpK9z05XJ3VQoo/hdmbIR9jkY5JLWhXVBZ8kWrjJ90EMl4
	YqwxotiJTcKCgWsj6M2KIoqmNIb+aotp8zsn7kqWO7vC+kJPEVP/zTHF7klXSVwF3O0+H2hmGai
	3gsbFiz1hrSekI3KsM1FIFObU/ulBFKKABYpFLOhC/rYQ8CPUc3qC4c9WeTK9Xau9SD4pIlBlfy
	ENe6+qcRhWDK3HFc7tzh2Bb9kmD4fJzj4eNr1dJCIffBFIRoy++f/YdAm+QZYP21osUmHzWBKP4
	LJmVw==
X-Google-Smtp-Source: AGHT+IEWRFlbhvq7/GCqpt+unPpPjWVNkObSkmzQVDUvyG3eowHw3ouJONLooJzvYG8sKv1QFMJ/Wg==
X-Received: by 2002:a05:690c:6a04:b0:78c:3007:dabf with SMTP id 00721157ae682-78fb3f2c893mr127569747b3.27.1766516473358;
        Tue, 23 Dec 2025 11:01:13 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb437380esm57704487b3.4.2025.12.23.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:01:12 -0800 (PST)
Date: Tue, 23 Dec 2025 14:01:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Jibin Zhang <jibin.zhang@mediatek.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 steffen.klassert@secunet.com
Cc: wsd_upstream@mediatek.com, 
 shiming.cheng@mediatek.com, 
 defa.li@mediatek.com
Message-ID: <willemdebruijn.kernel.2633c480125d5@gmail.com>
In-Reply-To: <aab6c515-12e4-48ca-8220-c0797dae781f@redhat.com>
References: <20251217035548.8104-1-jibin.zhang@mediatek.com>
 <aab6c515-12e4-48ca-8220-c0797dae781f@redhat.com>
Subject: Re: [PATCH] net: fix segmentation of forwarding fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 12/17/25 4:55 AM, Jibin Zhang wrote:
> > This patch enhances GSO segment checks by verifying the presence
> > of frag_list and protocol consistency, addressing low throughput
> > issues on IPv4 servers when used as hotspots
> > 
> > Specifically, it fixes a bug in GSO segmentation when forwarding
> > GRO packets with frag_list. The function skb_segment_list cannot
> > correctly process GRO skbs converted by XLAT, because XLAT only
> > converts the header of the head skb. As a result, skbs in the
> > frag_list may remain unconverted, leading to protocol
> > inconsistencies and reduced throughput.
> > 
> > To resolve this, the patch uses skb_segment to handle forwarded
> > packets converted by XLAT, ensuring that all fragments are
> > properly converted and segmented.
> > 
> > Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
> 
> This looks like a fix, it should target the 'net' tree and include a
> suitable Fixes tag.
> 
> > ---
> >  net/ipv4/tcp_offload.c | 3 ++-
> >  net/ipv4/udp_offload.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index fdda18b1abda..162a384a15bb 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -104,7 +104,8 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
> >  	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
> > +	if ((skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(skb) &&
> > +	    (skb->protocol == skb_shinfo(skb)->frag_list->protocol)) {
> >  		struct tcphdr *th = tcp_hdr(skb);

Using fraglist gso on a system that modifies packet headers is a known
bad idea. I guess this was not anticipated when the feature was added.
But we've seen plenty of examples with BPF already before.

This skb->protocol change is only one of a variety of ways that the
headers may end up mismatching.

It's not bad to bandaid it and fall back onto regular GSO.

But it seems like we'll continue to have to play whack-a-mole unless
we find a more fundamental solution. E.g., disabling fraglist GRO when
such a path is detected, or downgrade an skb to non-fraglist in paths
like this XLAT.


> >  
> >  		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 19d0b5b09ffa..704fb32d10d7 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -512,7 +512,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >  		return NULL;
> >  	}
> >  
> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> > +	if ((skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(gso_skb) &&
> > +	    (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol)) {
> >  		 /* Detect modified geometry and pass those to skb_segment. */
> >  		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> >  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> 
> I guess checks should be needed for ipv6.
> 
> Also it looks like this skips the CSUM_PARTIAL preparation, and possibly
> break csum offload.
> 
> Additionally I don't like the ever increasing stack of hacks needed to
> let GSO_FRAGLIST operate in the most diverse setups, the simpler fix
> would be disabling such aggregation.
> 
> /P
> 



