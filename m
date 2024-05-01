Return-Path: <netdev+bounces-92692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3B8B8438
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 04:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DBD284764
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAB10A03;
	Wed,  1 May 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A34HmbFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4438DD3
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529444; cv=none; b=eV78pbKeZdNOufLa+Hi38scDD+BofY6dN/zvJzuY29Mbn6NMzYrhHGn1RftWbiUqGAJ6tAIKPlL2JCozgotVl6PKJ95QZwzOweE7m4ZijP7680FyWf2NLtBZwCudxca2C1DkOcD0DVuedBgWT/fo1jGYp2XWSYlu4Rkvls+pF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529444; c=relaxed/simple;
	bh=Ahk5xym0u2zOCLikLFBL2aktr1uLKfLpZ84QPmjy+FA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aygWZExEWHOupRcHDMKf0YctPgMc1PyPY6AC/fRFHbnLnZMExuvBkl/e0wlnvnpkZ0KACpmjjbj3pp//uY4cFRnQ3edx3QpzCHNbzxecaZwF80AOvtnUNcyD/g/M/1JujTBncyveTcRUcUGwjmhWQfsBVITb6tq8b9yuS9oZYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A34HmbFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C57C2BBFC;
	Wed,  1 May 2024 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529444;
	bh=Ahk5xym0u2zOCLikLFBL2aktr1uLKfLpZ84QPmjy+FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A34HmbFRR15Sh4KSKyUXJOhF3CKgdGpy4efX7lZeYdSMMvK/MXe3eZusxXC8DevpB
	 fNUzO5/8vFXbsfEQnXKEthWNMLKhFJ92VamfH7sb/NL+hxSqFrTZTwDdLI1kMncKx6
	 /swg/anOHqnUng4d1GlA2qnGT31OgkAD6ZLhjeKcqLiVIIgHkCxxzZmIc7FvnHPBDI
	 ADbOp1Ut/XdJICT6gxs0SWpH3k5r0lRLCl1RnHXZdUmHAXTZa5AVHkBXw4caGbRetA
	 VoczlCDoghIrYRMAWmIXiUex6sUL8B87bf2O5YCBYN46KAe9AOTZv7+BYKHLeoEU4/
	 GKVWktqklZqKw==
Date: Tue, 30 Apr 2024 19:10:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Queue RX packets in IRQ handler
 instead of disabling BHs
Message-ID: <20240430191042.05aad656@kernel.org>
In-Reply-To: <20240430194401.118950-1-marex@denx.de>
References: <20240430194401.118950-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 21:43:34 +0200 Marek Vasut wrote:
> diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
> index 31f75b4a67fd7..f311074ea13bc 100644
> --- a/drivers/net/ethernet/micrel/ks8851.h
> +++ b/drivers/net/ethernet/micrel/ks8851.h
> @@ -399,6 +399,7 @@ struct ks8851_net {
>  
>  	struct work_struct	rxctrl_work;
>  
> +	struct sk_buff_head	rxq;
>  	struct sk_buff_head	txq;
>  	unsigned int		queued_len;

One more round, sorry, this structure has a kdoc, please fill in 
the description for the new member.


> @@ -408,7 +406,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>  	if (status & IRQ_LCI)
>  		mii_check_link(&ks->mii);
>  
> -	local_bh_enable();
> +	while (!skb_queue_empty(&ks->rxq))
> +		netif_rx(__skb_dequeue(&ks->rxq));

Personal preference and probably not worth retesting but FWIW I'd write 
this as:

	while ((skb = __skb_dequeue(&ks->rxq)))
		netif_rx(skb);
-- 
pw-bot: cr

