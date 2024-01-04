Return-Path: <netdev+bounces-61399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C28239E1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7608B24550
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DB367;
	Thu,  4 Jan 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsGrwoxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42B184F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so12876f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 16:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704329610; x=1704934410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz8iel3T6qkNfl5yJsY/ms+cAfpsXqpzhREw1cueuwk=;
        b=RsGrwoxVC2GzVgzjegR4OvSpgW7Qysk3paWq8hdg3P5HKXndiwNMCs9u9Mur+jcgj5
         3JB0f2dAn6D83w3PgHGQmhnUS3AqlyNfP7gGaH0iO1Sdsq1rjfSkvLARHB4JuV1S5FHo
         Cfa8mvI9pJz2tZqcWi8kxEeBp9LQa9sXUjvnXOsZaEySdgirHU117Si1WZoLdavF/hW9
         TkDNztVKT/6TNp1qnd/qSI7N38TIQir+EjQwTHjgFsa+bx50cZ0yKt2sIULfaILl7PIo
         G2/zC4nP441wFxAOuAxHcLsbkyTNnR6yVjCqIZzUoVcjfl0rraIBc7U8/VyywrMveDNT
         IVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329610; x=1704934410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz8iel3T6qkNfl5yJsY/ms+cAfpsXqpzhREw1cueuwk=;
        b=eg/azHR5Bbux5OwebTYOEd3OSTYCWd373B+XWeR7j1jZso0nCiWUXKSHIoyC6rSO5q
         slmamrZyCCzbENyCo09tBs1uv998o/O+Xh9z+Z1ZIMbeKFYsZUQgN9f2S0yDmfolwlhI
         C23LeC2A4wcP7CGHwT5uEK4LLfOvBtEhopxt/J7JUGW7bfs21ZfNrMm9NUCkokMBhIUC
         da77UeS+2c7qQXAYRRu3m2bSpUd/KuKB9jugS9mviDjIsu7BPjgE3yR9ljKmE3Q9Wqrh
         3jGHsXBsJu5KuvoV42dzXFAhWpY9Fxv7igsH3jiTb38NAh3IBKuYNFev3qiNDH2TkwAY
         um5g==
X-Gm-Message-State: AOJu0YyvdsY6QZ0AAiBH0/78GLssnHWmmQlhXQ5uqPvUbH1//z/PG3Fx
	F/qoVjSxM2K2FjsIZaK2Ha4=
X-Google-Smtp-Source: AGHT+IHUpIxAS3ZuHPw/TUqIqehE60jBRm8TaDSGEX+ps0dt69+VO2j1w0vID80hL11nkd65pprbPg==
X-Received: by 2002:adf:f58a:0:b0:336:c434:5c1c with SMTP id f10-20020adff58a000000b00336c4345c1cmr8846806wro.34.1704329609780;
        Wed, 03 Jan 2024 16:53:29 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id t15-20020a056402020f00b005534057c72dsm17892011edv.18.2024.01.03.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 16:53:29 -0800 (PST)
Date: Thu, 4 Jan 2024 02:53:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Household Cang <canghousehold@aol.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Message-ID: <20240104005327.a6747bpbqt24xlbo@skbuf>
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-2-cf61ab3aa8cd@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-2-cf61ab3aa8cd@linaro.org>

On Tue, Jan 02, 2024 at 09:34:26PM +0100, Linus Walleij wrote:
> We had workarounds were the ethernet checksumming engine would be bypassed

s/were/where/

> for larger frames, this fixed devices using DSA, but regressed devices
> where the ethernet was connected directly to a PHY.
> 
> The devices with a PHY connected directly can't handle large frames
> either way, with or without bypass. Looking at the size of the frame
> is probably just wrong.

"Looking at the size of the frame is probably just wrong." yet you keep it.

Not only is this confusing for you to say this, but I believe that the
skb->len check is the _only_ thing that is needed. Explanation below.

> Rework the workaround such that we don't activate the checksumming engine if
> the ethertype inside the actual frame is something else than 0x0800
> (IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engine
> can actually handle. VLAN framing (0x8100) also works fine.

Premise:

This driver does not set NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM (or anything)
in dev->vlan_features. Upper interface drivers which look at dev->vlan_features
in order to determine their own features are 8021q and DSA.

Packets transmitted through stacked interfaces have 3 checksumming points.
Two in software, during validate_xmit_skb() on the respective netdev,
depending on its features and skb->ip_summed, and one in the xmit
procedure of the hardware driver - gmac_start_xmit().

In short, I believe that the code which you have added to inspect the
ethertype - and based on that to avoid the "if (skb->ip_summed == CHECKSUM_PARTIAL)"
test - is bogus (a cost you are paying for nothing).

I'm saying this because I think that those
"(ethertype != ETH_P_IP && ethertype != ETH_P_IPV6)" frames wouldn't
have entered the "skb->ip_summed == CHECKSUM_PARTIAL" test anyway.

DSA-tagged frames should come with CHECKSUM_NONE, having been checksummed
in software already, by the first validate_xmit_skb() - DSA not having
inherited the checksum offload feature, because it's not in dev->vlan_features.

Coincidentally, this is also the reason why in your tests, DSA-tagged
TCP/UDP traffic still has a proper checksum, despite you bypassing the
hardware offload, and no longer calling skb_checksum_help() from the
driver. It was never needed, because the checksum was always already
calculated.

And VLAN traffic should also come with CHECKSUM_NONE, for the same reason.

The one difference between DSA and VLAN is that for DSA, you sometimes
set TSS_BYPASS_BIT (for large frames) and for VLAN you never do.

> 
> We can't inspect skb->protocol because DSA frames will sometimes have a
> custom ethertype despite skb->protocol is e.g. 0x0800.
> 
> If the frame is ALSO over the size of an ordinary ethernet frame,
> we will actively bypass the checksumming engine. (Always doing this
> makes the hardware unstable.)
> 
> After this both devices with direct ethernet attached such as D-Link
> DNS-313 and devices with a DSA switch with a custom ethertype such as
> D-Link DIR-685 work fine.
> 
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 5e399c6e095b..68da4ae26248 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1142,22 +1143,38 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  	struct gmac_txdesc *txd;
>  	skb_frag_t *skb_frag;
>  	dma_addr_t mapping;
> +	u16 ethertype;
>  	void *buffer;
>  
>  	/* TODO: implement proper TSO using MTU in word3 */
>  	word1 = skb->len;
>  	word3 = SOF_BIT | skb->len;
>  
> -	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +	/* Dig out the the ethertype actually in the buffer and not what the
> +	 * protocol claims to be. This is the raw data that the checksumming
> +	 * offload engine will have to deal with.
> +	 */
> +	ethertype = ntohs(eth_header_parse_protocol(skb));
> +	/* This is the only VLAN type supported by this hardware so check for
> +	 * that: the checksumming engine can handle IP and IPv6 inside 802.1Q.
> +	 */
> +	if (ethertype == ETH_P_8021Q)
> +		ethertype = ntohs(__vlan_get_protocol(skb, htons(ethertype), NULL));

Random fact: if you store "ethertype" as __be16 and perform htons() on the
constant value instead, the htons() operation will be performed at compile
time and should result in fewer instructions per packet in the fast path.

> +
> +	if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
> +		/* Hardware offloaded checksumming isn't working on non-IP frames.
> +		 * This happens for example on some DSA switches using a custom
> +		 * ethertype. When a frame gets bigger than a standard ethernet
> +		 * frame, it also needs to actively bypass the checksumming engine.
> +		 * There is no clear explanation to why it is like this, the
> +		 * reference manual has left the TSS completely undocumented.
> +		 */
> +		if (skb->len > ETH_FRAME_LEN)
> +			word1 |= TSS_BYPASS_BIT;

Do you know what "TSS_BYPASS_BIT" does, exactly?

> +	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		int tcp = 0;
>  
> -		/* We do not switch off the checksumming on non TCP/UDP
> -		 * frames: as is shown from tests, the checksumming engine
> -		 * is smart enough to see that a frame is not actually TCP
> -		 * or UDP and then just pass it through without any changes
> -		 * to the frame.
> -		 */
> -		if (skb->protocol == htons(ETH_P_IP)) {
> +		if (ethertype == ETH_P_IP) {
>  			word1 |= TSS_IP_CHKSUM_BIT;
>  			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
>  		} else { /* IPv6 */
> 
> -- 
> 2.34.1
> 

