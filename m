Return-Path: <netdev+bounces-230253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBEBE5C88
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34783A72B2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E62E54A8;
	Thu, 16 Oct 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUFJ9UAX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05462405E8;
	Thu, 16 Oct 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657005; cv=none; b=fylNYSEp7kG5j/UHSROrou/y0awtISgrV4fAyVTrcQRiBTlGNDIg6z78TpTM4EIHsviJxD/jda30awWZ/mAGXyOz7GjfJCoyoO9FaroNnPH4VdAFEibrpHNHJC6KmKZY52WaZ06MuQKhszI74RS31Odw+R/3ja/7fJz6EzNGMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657005; c=relaxed/simple;
	bh=AoOr6NzAAERUS6WMCz640DwHNaOlipYNbvxIeaLPK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQnAAmojmLkAmQvi0b7/6HLfQXXG6T9UeMCl8Mt95vDQVM3W7MIrIp8cL9gith555Alg0aNvKz1Pph0NqQc5rBFDIbwC+ZBjKwahuKcnzkDzwRhYVvrOHeDM2Q5nRiM0a9Uzz3EOscQr8yAMmWFB/64v8eVpTAyXKT7QiZIfdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUFJ9UAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79B0C4CEF1;
	Thu, 16 Oct 2025 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760657005;
	bh=AoOr6NzAAERUS6WMCz640DwHNaOlipYNbvxIeaLPK2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZUFJ9UAXp1v5Idy/X+tlbirueHIm1S9bVyj3YC9uodEUSTVQ+RFRz2adyXxHnUDU+
	 TiAF2zFPYV5/ClDoSAX363LrZr63/ZljaLmzi9cLXjrNBExZLXSRBGqCcLVEJRRcZS
	 hA3rTPKPg2O9Wil92qdxo945DOOTyhL4tljn9iGfNdqZ+kGfy8LnKwKR9AEX6vBPgm
	 tA5w0LCCy/WOsYLrtayuQMCF8o2P4GklOsjln6eyNB8kn2Rpbovc6yoMMewvjg+4Oc
	 RJSoKynnEaM1Fz6P5esuqtgnlenR5Pzw7zJcIndpuhNiFpOY9N5spKyLYPfo0eHySF
	 gbzPA8S+YSWkw==
Date: Thu, 16 Oct 2025 16:23:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net v3] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <20251016162323.176561bd@kernel.org>
In-Reply-To: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
References: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 09:37:50 -0700 Breno Leitao wrote:
> +	while (1) {
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			goto unlock;
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);

No need for the lock here:

	if (READ_ONCE(..) >= MAX_SKBS)

>  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
>  		if (!skb)
> -			break;
> +			return;
>  
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			/* Discard if len got increased (TOCTOU) */
> +			goto discard;

Not sure this is strictly needed, the number 32 (MAX_SKBS) was not
chosen super scientifically anyway, doesn't matter if we go over a
little. But if we care I think we can:

	if (skb_pool->qlen < MAX_SKBS)
		__skb_queue_tail(skb_pool, skb);
	else
		dev_kfree_skb_any(skb);

and there's no need for the gotos

>  		__skb_queue_tail(skb_pool, skb);
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
>  	}
-- 
pw-bot: cr

