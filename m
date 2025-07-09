Return-Path: <netdev+bounces-205554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B8AFF3BE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5601C83CCC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310A23AE87;
	Wed,  9 Jul 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM9cRTsf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05B235BE8;
	Wed,  9 Jul 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095676; cv=none; b=FaDRHLUi2SorGA9ylnHJKht+GOD7yyIQu9yEpIdudFIbYHksqF9TCVVizniYAHJPyxyXBy0Icc8plH7ZM4YGGc4X5fkN9EV31y9UAAG69y3712Q3wfnxkfdo85/Gynir4dane/f9bgS1DbDVIuDmozYzVjSxCqROVWnxNuDYzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095676; c=relaxed/simple;
	bh=EsjRQS8w43XSyhz63hGv5/ch+OGRjyxFJx69rMe2Oww=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DVO49aVTDeLv9f0lLjM5kP8oaAtanERMhaLDlPtGKrLnI1q3JxAp7gbFz41AxDRJQQd9ER4BxH/RgYWi+oaqcdD1uXU+51ogErIhhbfnm0GEumk3gXJZ/GFSiiEHXidZQPvtSi+IVy/qw+URfD7HM0fy5AiYrphwOefomZ0b268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM9cRTsf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-708d90aa8f9so4017807b3.3;
        Wed, 09 Jul 2025 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752095674; x=1752700474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEKNFsDNrC2CmAc6od85g2hTldkEsJPLiX/ve54EcUY=;
        b=kM9cRTsfIPDcaw71ThWCZQCO5RHIlrDbNcxX7EGH8//9J18J3FTxRUDzqIUTB7jJqB
         gF6lxRObMUvAxxtDA8X3Y2WkgUOeMh2ieGV0wvZTeWE69l/TL5EV8FscXMhuY9rgtYBg
         7FYElLCFQCe5+bOWfV78rIpGzoaq9n+1X7GfB+VJu5m+20XSoF92ewuBUae4Cjm0RvFD
         sIooMv+NBPZ3RG/K17kuLk2Q+HbQZ2xISJTmC8BiR+qhbhHnl3sqiOf/Z+zydRQlNKwX
         892EZF+Ol787w8E+IZIm7NRgq0PDYLzGGRO6dcamuqlKymUJGUy5IX8phUfXbJ23Xn8C
         17sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752095674; x=1752700474;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEKNFsDNrC2CmAc6od85g2hTldkEsJPLiX/ve54EcUY=;
        b=LfRCnFFP/m97uEPxfUggD3LMeWgKhBpJ5IVK8wPrbhITWbPpnZoc92aBNYYYRjJB1r
         zJ/ARK+RmRJ3yBXPU6XkaxfdSM/OoXjWB8Eg1n4KwTzW1zWX+rshAEAgjI9mKKMKtnhY
         o/K5CG3OxfAw3D6pq991hIShi5JIJ1hlnvHJeq4a4MrNwYW0KERrXOsLUjVupn+FqvOL
         vG9URT0x3mrengW3wSHlyBTUjIJ4kSFZTsPHKnyOAr4EuCJjHutIGwFHCbhSFrQl7CpX
         K7YXKLAx/wX5eNK9JSQ6cGp36xN7KBdaxPtxV3+rXtZZBGMVzIZtnzAqYUbnJu8zXEPY
         7bWg==
X-Forwarded-Encrypted: i=1; AJvYcCXdccUVc2E7NEM3KMi+pHzWqwUzu9aBEEs+CyI7/N+ErEWUiuJ384uIc/+AyaMnqXL9bVM/E5tSC4Q7fp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypTNO7GdNQ7gcBwhP72q95lCmerAAW9l17jSKHqBNHYbcB0pJ7
	5ONUMf5BgCFc5j5dQU24KTZlsiJsmQp+o+NEhM9lvgaGroBtcdqB66fi
X-Gm-Gg: ASbGncvDqWDXhSvdJfmBGx/l5PZnJIWoiIWzd/vt7CaAsa94QakSQ1QCmS5dfkpdajH
	VOf9782Tmy4PKxY/t2RTZNPTSEtrYHnftWwi9nFGZiHTbDiCGTBO9k/BrT8ocwbhe8MgEaH+1np
	UWqFr1qrf7yQXlqtUxqQl6UJSX+kPskuGXqHS0B6M9l95YZFq5CVZViLzfpKw6oldHbaIsptks0
	BzndE7hVJgfggJqOEwhXr0osbPl+5xGiywAAWGaYCzhxevbcbRCG3dHxChCGTCt8oTU0k5x8waV
	AI0XsyxAczn26zIRjFQ/yrCwx94WcEqXUTY8J0LRrFU8ucAAD+vNhU02Z2lqT4+otWaO6DxVKZV
	A2S0QbeArygazd5Y2G+wTGIbFuVchlCXzcL+DRBM=
X-Google-Smtp-Source: AGHT+IHmo0j1RAmg7nptfwCLglB7I9Sw42VHYV+nrp60FcfZLRjgsRdXm8M70ZdAnMw6OABHMQ/fIw==
X-Received: by 2002:a05:690c:3349:b0:70c:c013:f2f with SMTP id 00721157ae682-717b1a2758amr66272547b3.35.1752095673507;
        Wed, 09 Jul 2025 14:14:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7166598b40dsm27804137b3.19.2025.07.09.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 14:14:33 -0700 (PDT)
Date: Wed, 09 Jul 2025 17:14:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <686edbb8943d2_a6f49294e2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250709095653.62469-3-luyun_611@163.com>
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-3-luyun_611@163.com>
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
> 
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL

This is a very specific edge case. And arguably the goal is to wait
for any pending skbs still, even if from a previous call.

skb is true for all but the first iterations of that loop. So your
earlier patch

-                       if (need_wait && skb) {
+                       if (need_wait && packet_read_pending(&po->tx_ring)) {

Is more concise and more obviously correct.

>, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run.

Interestingly, this is quite similar to the issue that caused adding
the completion in the first place. Commit 89ed5b519004 ("af_packet:
Block execution of tasks waiting for transmit to complete in
AF_PACKET") added the completion because a SCHED_FIFO task could delay
ksoftirqd indefinitely.

> As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
> 
> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
> wait_for_completion_interruptible_timeout() should be executed to yield
> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, move
> the penging_refcnt check to the start of the do-while loop, and reuse ph
> to continue for the next iteration.
> 
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
> Cc: stable@kernel.org
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> ---
> Changes in v3:
> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

If the fix alone is more obvious without this optimization, and
the extra packet_read_pending() is already present, not newly
introduced with the fix, then I would prefer to split the fix (to net,
and stable) from the optimization (to net-next).
 
> Changes in v2:
> - Add a Fixes tag.
> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
> ---
>  net/packet/af_packet.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7089b8c2a655..89a5d2a3a720 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2846,11 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		ph = packet_current_frame(po, &po->tx_ring,
>  					  TP_STATUS_SEND_REQUEST);
>  		if (unlikely(ph == NULL)) {
> -			if (need_wait && skb) {
> +			/* Note: packet_read_pending() might be slow if we
> +			 * have to call it as it's per_cpu variable, but in
> +			 * fast-path we don't have to call it, only when ph
> +			 * is NULL, we need to check pending_refcnt.
> +			 */
> +			if (need_wait && packet_read_pending(&po->tx_ring)) {
>  				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>  				if (timeo <= 0) {
>  					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
>  					goto out_put;
> +				} else {
> +					/* Just reuse ph to continue for the next iteration, and
> +					 * ph will be reassigned at the start of the next iteration.
> +					 */
> +					ph = (void *)1;
>  				}
>  			}
>  			/* check for additional frames */
> @@ -2943,14 +2953,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
>  		packet_increment_head(&po->tx_ring);
>  		len_sum += tp_len;
> -	} while (likely((ph != NULL) ||
> -		/* Note: packet_read_pending() might be slow if we have
> -		 * to call it as it's per_cpu variable, but in fast-path
> -		 * we already short-circuit the loop with the first
> -		 * condition, and luckily don't have to go that path
> -		 * anyway.
> -		 */
> -		 (need_wait && packet_read_pending(&po->tx_ring))));
> +	} while (likely(ph != NULL))
>  
>  	err = len_sum;
>  	goto out_put;
> -- 
> 2.43.0
> 



