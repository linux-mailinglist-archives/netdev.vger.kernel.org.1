Return-Path: <netdev+bounces-264047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bb0MJ+lqGkYwQAAu9opvQ
	(envelope-from <netdev+bounces-264047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:35:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD7208054
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1019300678E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957837189C;
	Wed,  4 Mar 2026 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSGBhxDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F413B284
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660125; cv=none; b=Nrv99KRVAcE79BMGaY9PEMyTIteBrsYONc7+zsbbgC9XRLol+8X6rSgtMuW8QqUFBszQ/Z67Qhzdwm336wsxLwWqhsbACGhH28HlE43ajoz+u8obrWvcisvU2YMJ/h8dwR6DWU15COWhWNEWjEqMB3aKVdQ96P7qGPSPjxrkWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660125; c=relaxed/simple;
	bh=g1jJ7+PvEzLNzCmg0/V/jfiEQVRG1P1r/WLSuAicBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/NCn3ulI16Pywi4O4aRh4CABjm7PymWypvsMq1zM0yCbgJjHSeewFkFRD79w9TO6WAiOuB7eLCt1VrHEzPSFic9UoF6kD4FVewFGhQ5WdQ0YDXnCLX9T+Y3aoJqE/nOGgENZ6b/uZM6olrDc8meEHt/2SMJHx0UH9/D33Lm6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSGBhxDw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso79108285e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660122; x=1773264922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHwh5kWRHiqXFYFXI/fqBKZ24JxWXaGYGlZJiOK+k2g=;
        b=cSGBhxDwW7q/N/ouGNWX0lERHC53uRTfFbS0vO8HmCGAN20cl17w2aIrcGJTgDx+uH
         KoCSk1RQLyvHC4HwS6onw4uIGMSv/dWQEEcdsXMI01mLw5JPsYQc+qkTZqQf7MH8Zywe
         GimnUn/mAvg3sTzAEE0LRsmy6kgVEkpTTG/TAM/l0tRD0ljEg0v8sYfYIqvDTbRXzNpY
         hs9+Cf/ErNH0nwa6AfHhHJZVF5l0Vl0QeCOZQ9Vpp5E3Lhu+56JB6xt5sLPb+0k5qoXg
         X1XM8DBj8EpEliml6VW1kfFz5U4oaRkIGYXuOyD6BR12AAPTSuI9XhJArS3GoN+cYP7a
         KJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660122; x=1773264922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHwh5kWRHiqXFYFXI/fqBKZ24JxWXaGYGlZJiOK+k2g=;
        b=gpT2Hymk6tEkFxGAi2uQsGNoIwl4LIU6wLnjBniYWvpvWuxLN7qTp+lRhSVT1Fh6Pm
         GjtbR77qrn3p8G7sOs6rknEKNqlflwZAZsse88wPGB6s2L/li9Iu/qU8xeuNK0AKiXB5
         oTb5k64/29G+x+34jPhsRUkiLWYLYmq825OPbsmuCncYx8XtU0SF52PXb8LDZAG3m/1p
         0tw7Z8czXlLrIyGxvbndhnOmmAbaityEITw8OKi3oqALl/9+BBfIford/4c3zuNN6c0N
         Q8nXxE5YlHLIppLBAUsIXLMelaIBqbkAi25j6oFKKvaStTpvnPHfqWNndM9S4mkTRQk1
         3Haw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfJPAVjP0siE4UrsBcgLCKebXCCNXY4GzDvSOiuHkDpR4fkNyiu33v/KFkztcy6A6SThtfBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4jrAz8hdqELeSZ8aHquZPMsG5OIl2XUJubIdzz47ui2W6rlt
	sBnIyLwW/ruXBFzbMCY1fMNrA4BrrXqV8JCNSBlw4AkcBrAeauex12Fr
X-Gm-Gg: ATEYQzxcShBIJgcFsjYSIML2TxoYdqBKC7bw5t8Xaan8w+cFcS2VQe9g1mTaECBIebH
	PLQeTh0OqmF9shOCVvCIRMVuOXC2Kuu0yv+XTwUScEmwHApiJvIQEiKymUuJZVhN20I7V8XZR7a
	pYmg4SgF8OYpwhaVWT6S2W9x+irhDjztkGbDw3oaIDhY33iVuCXO8Dae33wOdqn4SbG/0IQfzHO
	vXbHf6X02/Eseakt0RZukOuwTrgV0Y17Ro40DzGyG4a3mbMIEc0mDPNaSnARYdunL7LM1pTAnJq
	uJkqx3zqWHefVr/Gh9pudppvRbe8zjKhyZqplUd8TDU+zVkBXMxzXjPMI5pNIJncgxRQNnbtgv6
	Nj65nUCeazsrPhRxxNFvY/diXAnTIFifa0MOv8a69RXu39bCg3Gg4NC5hjPgUqHobmu1U+OMHyi
	ZOdY8oTjnF6e8c8uOPw0qPZDOfn01sl1GS0XCVLUP8Z9EnvXEzDZnsJciQeR6vryqGua8S2fJYU
	+8=
X-Received: by 2002:a05:600c:828d:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-4851983a7fcmr55969805e9.6.1772660122112;
        Wed, 04 Mar 2026 13:35:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a007sm80403085e9.2.2026.03.04.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:35:21 -0800 (PST)
Date: Wed, 4 Mar 2026 21:35:20 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Natalia Wochtman
 <natalia.wochtman@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 04/10] ixgbevf: branch prediction and
 cleanup
Message-ID: <20260304213520.17e16331@pumpkin>
In-Reply-To: <20260304160345.1340940-5-larysa.zaremba@intel.com>
References: <20260304160345.1340940-1-larysa.zaremba@intel.com>
	<20260304160345.1340940-5-larysa.zaremba@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2EFD7208054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264047-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 17:03:36 +0100
Larysa Zaremba <larysa.zaremba@intel.com> wrote:

> Add likely/unlikely markers for better branch prediction. While touching
> some functions, cleanup the code a little bit.
> 
> This patch is not supposed to make any logic changes aside from making
> total_rx_bytes and total_rx_packets more correlated.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 5a270dd2c7aa..4619f2bea1ab 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -570,7 +570,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
>  	u16 ntu = rx_ring->next_to_use;
>  
>  	/* nothing to do or no valid netdev defined */
> -	if (!cleaned_count || !rx_ring->netdev)
> +	if (unlikely(!cleaned_count || !rx_ring->netdev))
>  		return;
>  
>  	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
> @@ -586,7 +586,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
>  
>  		rx_desc++;
>  		ntu++;
> -		if (unlikely(ntu == rx_ring->count)) {
> +		if (unlikely(ntu == fq.count)) {
>  			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
>  			ntu = 0;
>  		}
> @@ -823,7 +823,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  
>  		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
>  		size = le16_to_cpu(rx_desc->wb.upper.length);
> -		if (!size)
> +		if (unlikely(!size))
>  			break;
>  
>  		/* This memory barrier is needed to keep us from reading
> @@ -855,7 +855,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		}
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!xdp_res && !skb) {
> +		if (unlikely(!xdp_res && !skb)) {

I'd check that generates something sensible.
Using unlikely on multi-term conditionals doesn't always do
something sensible.

	David

>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>  			break;
>  		}
> @@ -867,21 +867,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res ||
> +		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
>  			skb = NULL;
>  			continue;
>  		}
>  
> -		/* probably a little skewed due to removing CRC */
> -		total_rx_bytes += skb->len;
> -
>  		/* Workaround hardware that can't do proper VEPA multicast
>  		 * source pruning.
>  		 */
> -		if ((skb->pkt_type == PACKET_BROADCAST ||
> -		     skb->pkt_type == PACKET_MULTICAST) &&
> -		    ether_addr_equal(rx_ring->netdev->dev_addr,
> -				     eth_hdr(skb)->h_source)) {
> +		if (unlikely((skb->pkt_type == PACKET_BROADCAST ||
> +			      skb->pkt_type == PACKET_MULTICAST) &&
> +			     ether_addr_equal(rx_ring->netdev->dev_addr,
> +					      eth_hdr(skb)->h_source))) {
>  			dev_kfree_skb_irq(skb);
>  			continue;
>  		}
> @@ -889,13 +887,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		/* populate checksum, VLAN, and protocol */
>  		ixgbevf_process_skb_fields(rx_ring, rx_desc, skb);
>  
> +		/* probably a little skewed due to removing CRC */
> +		total_rx_bytes += skb->len;
> +		total_rx_packets++;
> +
>  		ixgbevf_rx_skb(q_vector, skb);
>  
>  		/* reset skb pointer */
>  		skb = NULL;
> -
> -		/* update budget accounting */
> -		total_rx_packets++;
>  	}
>  
>  	/* place incomplete frames back on ring for completion */


