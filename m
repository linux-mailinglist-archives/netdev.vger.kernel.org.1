Return-Path: <netdev+bounces-158737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2CEA131A5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D416543B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E578F59;
	Thu, 16 Jan 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1G7JLnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97D17C8B;
	Thu, 16 Jan 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996796; cv=none; b=R+PyGII18Y5nxdtWwxaLkwELnEvZDAUeflpd1+m/O5YC39wDTmbOdTKuPmHa2wgjCQXdORi4n7NjlLNZ9tu75w3KnhaJAnKK9durv0KsAcc4TDML4wZw+qIXfyyf7GvrCcA7LogVtB+WZluHAzVp49cmcNAFdLre0/FoK+1Dfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996796; c=relaxed/simple;
	bh=v2bFSkjdtfnCkNYGH7vEiJOa9fAHqO3ZwshoGezugBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0NdERLV8zSwXSPvgaTHx69FiEHEhj8FiCULMQZl43j4g+u/21YM2qXZUQyzt0TJ5gTCHX/OE5+0V5b4HzqqweMIw5V7TLSNtqGGU1DG7YAg8YFlSpzVJexvOtEszukJMQ4W+vw356JCn4hRG18W0iBU0kRyRXCYfTh7gyws4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1G7JLnZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21670dce0a7so8865715ad.1;
        Wed, 15 Jan 2025 19:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736996794; x=1737601594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ze2u6ogswUGLWexD9dL+Uvbmw1nnxbIQ0UCNZR5y2U=;
        b=U1G7JLnZcuWV3K3IixHQWn5r1YCQodec8SacaRaU2fQM9VsGPAGFdvFyJdwIucQ2hD
         pe2eYqtnyD9DK9qObt3A+sAt8DHrM2gnXriY339r43P+ebmjgnNSIovvBcNJY/8p9x99
         OfkyahKmSN/jKqjmChGkrTCDznAu+m5HDvChHUBAkkMxpVV3UPkJpVN3ExK1LDq3ub9H
         mgFbqG9JAMiEojThMWzcO00wN3APquKsE4UNlDMlc7JJlgenq4bGMFaxGXwf3iepexeJ
         1NfI3HVoLzjqZY6YGXhsHus+IuqHyHlXpulGBC5CzkNuBObNFEhDenANWGO3nsCzAgjj
         pjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736996794; x=1737601594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ze2u6ogswUGLWexD9dL+Uvbmw1nnxbIQ0UCNZR5y2U=;
        b=F+o1rg2Q+5dcT40CMKq7O+Bu1SUrhPoJ5XZ7mnqs/gCcmP4g6w9aADTqBwhKDzItQ1
         +Su70N+FpriR1FuwzIyvoaKRrfi8J8hWhZlrGi98JlhCKHLA51tkhWCEeD/BHkmGjg6v
         i2yHFQ+rA2s2W76i7Gq1b8bhiYRWWi39meX9aIdFpBqmdns33Nc2hsh14yas8CjV1689
         sARuB96SSLOLLob8+AN6EwpgcdAstUwgaYCdo494cdw6Vp88FEnnMro7GKr25XF9OZeQ
         tAVg36AVjn2daDrYeWMr+23WmaYtQIX8Rv4KZAOlTIMDlDQT09NBiE2uour9KH7BYno2
         OAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRM6LCp2jAG3Naz5v1FZc08XfqEQzysjDtU6+5F0BcZAN7d49RQFwo7y4omvqX/mp48p4d1w/RY3uEg8I=@vger.kernel.org, AJvYcCVWtdiM7Di7kgr8OBZA+KqtYbQvXaQEvy5i02bDNOjB8nkNP7I5o16H35XPrdsqUOHw8rAwxg9u@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNlQnnqZ+s/Vi5TUHMO70uNYiPONbl6k3OJvXyBZs2QULPiM/
	PAGA1PkoMbSk4vxjmIihHLtQ0Es7dL3HmdhMoCcB5Y1VkGxn02oT
X-Gm-Gg: ASbGnctyfnM9UAiB15i/fe1XayztkG3bNNACe2Aq94+ypMpbP5B/6V9/E+pdibwn4dS
	EoM79vJIiAJCobWWR/L+izC7ksIGb3LtWEAVbOZKxWesE9dFaUkPKfPNT9GuD2vZJBytx/4wjAy
	bRNl+5y9/A+KV/pGDnaHxexVfxsHn6SdUQ5doq0VsODxuNfg3D8KoKuE6OvAUtAeJzt1rL4pLyM
	WiTSuVYNAWN8Nlplr4A6Pzaz2t66tRlREyXxamZuraZmBn1ZF9h5w==
X-Google-Smtp-Source: AGHT+IG+gbuPhTugQjUyA8q5cqsivSTkcwRWWlQBn8xqPiJT5A4ujHeYMSSbV2ToO+BpK0JupiGTeQ==
X-Received: by 2002:a17:902:e544:b0:216:50c6:6b47 with SMTP id d9443c01a7336-21a8400038bmr503434195ad.46.1736996794005;
        Wed, 15 Jan 2025 19:06:34 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df6dsm89036585ad.5.2025.01.15.19.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:06:33 -0800 (PST)
Date: Thu, 16 Jan 2025 11:04:36 +0800
From: Furong Xu <0x1207@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware
 feature value
Message-ID: <20250116105011.00003206@gmail.com>
In-Reply-To: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 11:08:52 +0900, Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> the platform layer.
> 
> However, these values are constrained by upper limits determined by the
> capabilities of each hardware feature. There is a risk that the upper
> bits will be truncated due to the calculation, so it's appropriate to
> limit them to the upper limit values.
> 

Patch is fine, but the Fixes: tag is required here.

And if you like to group this patch and the another patch into one series,
it is better to add a cover letter.

> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7bf275f127c9..2d69c3c4b329 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2375,9 +2375,9 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  	u32 chan = 0;
>  	u8 qmode = 0;
>  
> -	if (rxfifosz == 0)
> +	if (!rxfifosz || rxfifosz > priv->dma_cap.rx_fifo_size)
>  		rxfifosz = priv->dma_cap.rx_fifo_size;
> -	if (txfifosz == 0)
> +	if (!txfifosz || txfifosz > priv->dma_cap.tx_fifo_size)
>  		txfifosz = priv->dma_cap.tx_fifo_size;
>  
>  	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
> @@ -2851,9 +2851,9 @@ static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
>  	int rxfifosz = priv->plat->rx_fifo_size;
>  	int txfifosz = priv->plat->tx_fifo_size;
>  
> -	if (rxfifosz == 0)
> +	if (!rxfifosz || rxfifosz > priv->dma_cap.rx_fifo_size)
>  		rxfifosz = priv->dma_cap.rx_fifo_size;
> -	if (txfifosz == 0)
> +	if (!txfifosz || txfifosz > priv->dma_cap.tx_fifo_size)
>  		txfifosz = priv->dma_cap.tx_fifo_size;
>  
>  	/* Adjust for real per queue fifo size */

