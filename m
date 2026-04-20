Return-Path: <netdev+bounces-279923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGMGqiF5mnTxgEAu9opvQ
	(envelope-from <netdev+bounces-279923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:59:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B054F4337B9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F3F30036DB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C73B19C2;
	Mon, 20 Apr 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P74aiY5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D093AF653
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715140; cv=none; b=I4YfqzN6u9/+sHHee+Cvgjnf4JVLLGTgL97MAQMyulB54X0YCgJ4yUw1jCbeAPxPW8B7zU9MVT+RC06xPqyt22KKKUzbP20ugqOecKAzDlr2qiOXHV7J1eI2sFsn4iIYoCklpD1Hy7DoTKJwlRuyy4ICzYhUOXYiDc8Q3icvQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715140; c=relaxed/simple;
	bh=OqfcjPH2Fxdkfzmesm3GzxbAIVnkDk6RVYecl4hDHW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq+wUOwQ7CeJqzNlDdk9vnxdkOh1REt9MNG7pow6aG1el7sOzZHBl2gfGHR1L5nYCiMsP73TlNyf4KxarzZ+9PJTpTlxmi6xyRAKRNpdgnFsn/sZQVAQNlrnHiWwe7CowfCyFl6yyo7aVz84QhZTzVGUHWTjYKs4cNTUv3ZPP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P74aiY5k; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1656439a34.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776715138; x=1777319938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3IZOIb/3skvvHsXAgrxfqUKygtLsE7kkkf3vBFlT4Y=;
        b=P74aiY5kc9QMMwekPGGkDMh3ZuvnXEaAffRzAOuWgizQnSQAiHMfs/tBihQO9dxxox
         SXnOeljg1d2DQkn5dXhaud+UIO/BdAChSU/AAnfca8B8AgH0vCMqI+1TYeEpbzwORXqV
         V2HsoBYpG/YoONSq0uh0euGuWSCA/pK4yBuw/SXqIY2/EkAB4qg74O/R1JYTUrJcLhOR
         E++VrA/GhdJKqgkwSxCGNDPqhNpSeHW76YCAIPVDVMNYUklvMGG4w54Am+edkJAUN83Y
         uSEdgzKxv+a+d6P9nfwTQKVQFBgGedLlqAMw4lmCL89BUOhxNhe9vWZpkyvKyto7telZ
         UKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776715138; x=1777319938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3IZOIb/3skvvHsXAgrxfqUKygtLsE7kkkf3vBFlT4Y=;
        b=oBKpcojxz//sY9QgRdiPFcv5BDm/qc3EmzLOK2GAmqePWtoOHDCcv6TvPxb50sOTIe
         HPCxzl6uzdiUXms3AFazHykE+IwzxQibVXFaoOmeElmNRu3qLuHLKtlkoioI/Vq5+Zry
         Lr+LgdZc2hSO5oi2fsRVDgJy+Pjgpz363HeNqVNCWJkati7xudMRwDVRD0TtHsInolRO
         tOp8ZFD2cKj4dSEP62HYSLQ8RwXEpoRlRNNhE3lC5zluBJKVCJ7HVH6en+ju4e8TFZMe
         Bbk6VeundBUXjfdm3IcW5DxLeZYryRGl8HgQO+Bf63jH4AOsyWh8Qt9y94YmU34KjW4y
         YiQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VFs4CVPIRpttFkxvWoWFI9+58lFhpt+4U1MW57A66VVWGk5y8o+MZ7Ydqeg3tvRy9ZDMHl+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zUqyvwkECxuF0OO9rB1WN2j5mCk3PVFaVL/O9/fB0GftIuqa
	lrbC8Xn1fCvyksWx5fqueUBoQmyJbjm2z3qfnTRdmmyEBTx8W/hD+ASx
X-Gm-Gg: AeBDievYWs/j8A4OiRjk0n08q8TR+GHNLLfT6Tp/YJBn6QN7hRFREUu2Fumse4G68OT
	IwtFFSl5fzH+LlGNB78UvRSqhNkAwZocV/cvHMcHOW3yXrIgfYMkVdtQ3GhfVkAAaIzq3lD3Rte
	R0OrRJTkYznchbH6RIJsLXKfWE5B3IM0VfRV9t9bMmaxXuBZm672jPpn113MzUcv3Yvk6wLIhYK
	/fng74ALJ75xmPqVNpsD8kO1t7CrDTimTtopxKAjY1jgDfHAn9+lM2dNJriRx0v0XPALH7I4XxJ
	13wN0CxQUYX0MahI91HE4nDSWiQ2mo7yv1yEzDahLcHmTnk2UADb0TpmuUOHD86K/vo+dSE/KP8
	uOKOa50XL2oWDHkVxe3S19ew4vtHBmCBJVg1QXyZN2JCiSsCdGwV+bG2xH2OD5uPGs76DqFWhsb
	4CMR8pu4pvBvvvHX6QTossPWRfx/TRyqbbsVKV1w==
X-Received: by 2002:a05:6820:210f:b0:694:84e9:4a35 with SMTP id 006d021491bc7-69484e94b74mr2900269eaf.46.1776715137756;
        Mon, 20 Apr 2026 12:58:57 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6949127c1e2sm980623eaf.15.2026.04.20.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:58:57 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:58:56 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 7/8] xsk: fix xsk_addrs slab leak on multi-buffer
 error path
Message-ID: <aeaFeyOTtxgY2Kus@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-8-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420082805.14844-8-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279923-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: B054F4337B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When xsk_build_skb() / xsk_build_skb_zerocopy() sees the first
> continuation descriptor, it promotes destructor_arg from an inlined
> address to a freshly allocated xsk_addrs (num_descs = 1). The counter
> is bumped to >= 2 only at the very end of a successful build (by calling
> xsk_inc_num_desc()).
> 
> If the build fails in between (e.g. alloc_page() returns NULL with
> -EAGAIN, or the MAX_SKB_FRAGS overflow hits), we jump to free_err, skip
> calling xsk_inc_num_desc() to increment num_descs and leave the half-built
> skb attached to xs->skb for the app to retry. The skb now has
> 1) destructor_arg = a real xsk_addrs pointer,
> 2) num_descs = 1
> 
> If the app never retries and just close()s the socket, xsk_release()
> calls xsk_drop_skb() -> xsk_consume_skb(), which decides whether to
> free xsk_addrs by testing num_descs > 1:
> 
>     if (unlikely(num_descs > 1))
>         kmem_cache_free(xsk_tx_generic_cache, destructor_arg);
> 
> Because num_descs is exactly 1 the branch is skipped and the
> xsk_addrs object is leaked to the xsk_tx_generic_cache slab.
> 
> Fix it by directly testing if destructor_arg is still addr. Or else it
> is modified and used to store the newly allocated memory from
> xsk_tx_generic_cache regardless of increment of num_desc, which we
> need to handle.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9236ec32b54a..6b17974ca825 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -605,7 +605,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	spin_lock_irqsave(&pool->cq_prod_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
> -	if (unlikely(num_descs > 1)) {
> +	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
>  		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  
>  		for (i = 0; i < num_descs; i++) {
> @@ -660,7 +660,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
>  	u32 num_descs = xsk_get_num_desc(skb);
>  	struct xsk_addrs *xsk_addr;
>  
> -	if (unlikely(num_descs > 1)) {
> +	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
>  		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>  	}
> -- 
> 2.41.3
> 

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

