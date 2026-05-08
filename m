Return-Path: <netdev+bounces-285803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACnQM5ra/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FC4F6843
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B45F301A528
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AF3DF00B;
	Fri,  8 May 2026 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daOdKnMh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333793DEAC7
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244229; cv=none; b=LjZDjutCEx8iqz4k847ODw3IVHIoAzJgjaRDFRdZmsR+MtbJh5+Hy77vIFbwFGms35p4yI9+cfFu/pU/8e7GHPnKry0X+/iMhI0o87ZPGxFSx/xBEfLfT7p5srkvk+jHWQPLmRPU23XENSUwhNdoOPEyLTmJ/oOJME6gxbZmlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244229; c=relaxed/simple;
	bh=DLlT5gJ88mWG0cJW0N7+9cR72wBKSizYhJaXd2JhuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru8tEW4AMbz6oXu3omyPehJfe5DxgfhHwSv0dFCLR/1yvY66cj4yPGwlPLdatNoL4qjaJxCrrKpM1/g3WrhLkHf6YnXGX2tE0eCfusniVj0Q3nUnCTyYUWEYY4lucaAbHj+QyV2kZW+egmeef0qb5flpQ2gP68vOm0CTMgz3Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daOdKnMh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1270005f8f.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244226; x=1778849026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHaDVqGuSgw1dOeDgbNYynn5tMPklJkBwGnBT4ff2H8=;
        b=daOdKnMhKDGZ2ZdvDVF66U5X1wXpWsBeJ9ENeKgBkSB5Tad+sRLjgPSBTWudAj+uGD
         5uVWc6JPeaWQ2x1mF5sI2I7A+GAeIyLedwxoI+B1PcTKWJWe+KZ7dmrg/xB9nIDRWHPl
         x7sw5HetyIE4BWoqVnah0AX4bslcB1GRU+umzFZCfnmKIlfzNaQ728qcHAmFGlSHI/qT
         BghX70/6xfSxo8ZtulAhRjabRl0ILku16P+e3SF/vYFHBYfVipsyTiblt5n+DEaI61r0
         ftOTkcOisxhwpshDqJRjbyDIp8bIR3iVYARvcW5RXyTxF6agDH1o5q7HHQ3JGPupTVRK
         4tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244226; x=1778849026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHaDVqGuSgw1dOeDgbNYynn5tMPklJkBwGnBT4ff2H8=;
        b=Ni4lcM5BZCqRtmT8Wqho4OY7qcxJ58AzFx1NrWVcf+x2wkSLSPA3mG+9nVMh3bskTn
         eZ35EijR8lru92t7vzqes6jkXTTtUjuC82ykyjTQPj7F6v7rw5PanmOqSFmxl3Vtgs6N
         wWAKIjsWzvC6Rte6ydSogB/WsPgoB4/cxu/RbhbeJPGw8DXfyRCTL0w4KMOsGZ0DLDYa
         gMbaOQHOXDI6GqeMHF7XurB9Go0Yft3Q34DffXjlYfC1qBeF218kBu/xYBnGeLml3sN7
         ITSObHolF2KkAQo11BJZeXXuLeVM452xFkFSEUc/9hWuqsgZbF5l2LJwSzfP13PRaZSw
         ag2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8T5yhzicVrnHsEt4epqMP2h5ZV35al7ntYgWb3fZKij5IxazVbm4jWFxDTZIeDeNpVc7IMXwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70aUMjY8G+S5iv11ioADIpOXG0596lydv+GP0ccAlFLd4Bnu6
	pZAVwWmaIqPdzSkUJzpdA/Kzf4ytYL1CJGjtSr9YN9ZgUfFMVaEvR/Mk
X-Gm-Gg: Acq92OGMB+oUwNXsiZnrLYEGduySvXGxcifEnIbLrFrAqiH8RZypWw8qbfUjlctis7w
	dl18eeg3O4hQ2Fmp9YrXWrjVa3nAM+6tgiWvuL2HH6eCW4TPCVgaFcEe2aicwtHYCBmxL09Rx8y
	hjZ8UE36hH+fRprNhGO2Lgw5h0hRgLQzHOgAXXtIBnNjDhfQPJ65Y0hvHqX5fJBm4udTOcLzQGA
	dLex+O6b4md6kSC6Ox9BobU9+bi0DyaTQr4mmU67UlHn2n8xEWdl6KRavI8Hih6c2PcTCI+t2UX
	XcfA50fZhMhMpmT/a/VeD6ZEeRU1G4WkKR4wX+J4OVFaGmfk54HDKJAMG8cQOXuLn9NwNde4sG6
	0ErOHzFvzNg6Nxf8CmLZUjZXMPRU/fPBWyDhLd9+TKFzZENRC8+AFhUDWQ8RgB9MBxXWOnetB9k
	ZZ0EsRnKr0GGC3eytRkVYvIAXRWC8aFqi4z69ldNrCJf+X/zG1K2n/KzylthYRCLLI
X-Received: by 2002:a05:6000:4010:b0:44b:aca1:f480 with SMTP id ffacd0b85a97d-4515a6c3361mr19344538f8f.8.1778244226283;
        Fri, 08 May 2026 05:43:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm4514358f8f.9.2026.05.08.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:43:45 -0700 (PDT)
Date: Fri, 8 May 2026 13:43:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Amery
 Hung <ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
Message-ID: <20260508134343.6651d7c6@pumpkin>
In-Reply-To: <20260507095330.318892-3-tariqt@nvidia.com>
References: <20260507095330.318892-1-tariqt@nvidia.com>
	<20260507095330.318892-3-tariqt@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D20FC4F6843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285803-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openai.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, 7 May 2026 12:53:29 +0300
Tariq Toukan <tariqt@nvidia.com> wrote:

> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits of the
> skb's linear part.
> 
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
> 
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 75ccf40a7f17..301b33419207 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
...
> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  				pagep->frags++;
>  			while (++pagep < frag_page);
>  
> -			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
> -					skb->data_len);
> +			headlen = min_t(u16, headlen - len, skb->data_len);

That looks entirely broken.
skb->data_len can be larger than 65535 so (u16)skb->data_len can
discard significant bits.

I can't quite see why the subtract can't overflow either.
It is entirely non-obvious.

There seem to be far too many u16 local variables in this code.
Typically they just make the code larger because they require the
compiler mask arithmetic results to 16bits all the time.
(Only x86 and m68k have instructions for 8 and 16bit arithmetic.)
The same is true for function parameters and results.

I think all the min_t() in this file can easily be changed to min().

-- David

>  			__pskb_pull_tail(skb, headlen);
>  		}
>  	} else {


