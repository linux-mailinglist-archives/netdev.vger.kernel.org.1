Return-Path: <netdev+bounces-159942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E047A17754
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 07:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198C7188A03C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22201A724C;
	Tue, 21 Jan 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQB1d+Fa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37D85931;
	Tue, 21 Jan 2025 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737440736; cv=none; b=Bi4OFs7hF5uadBSPcS29IXYqFyMdMzRok3diEoDdXRJQjRGtJ1QsTGJQE4+biYplDY4Ac2dqO7xdbIUZMeLJalyt1Ikr0Mn3mXgm/qjkv+mvM+W+/9SiBxmefOE9i8JUdPR+TljkzYcl7Pv92wX+TTcZR+E/QGAZcmIdRTAfoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737440736; c=relaxed/simple;
	bh=BtpJQcEXCN8EzG7yfX9cF+1PwO5B9OaI3Jvju4N1w9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCrLFYmNgc5c3Z7MjJnQiG1YcrB0cVBejhv0G80Ts7xMV/rUiz+zbF+aGBAPfan0vfcjEv9Br2SpMVqnNv1yO7BBSSKTMrupBxoBH3JzrNinKx0bcDt5g3TlTBq1uupNbw8wZriWdb4Hjgb0VeOEcJa96EcbHnsH6tf/Ydhtpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQB1d+Fa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so85029555ad.2;
        Mon, 20 Jan 2025 22:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737440733; x=1738045533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI+Bcbtp+L0lptpp/ZEocQcR61FttKONsA5FcfRE/MI=;
        b=HQB1d+Fam+xVqPvcWGVG/4UYmdecMPhGLpG+wAb1ncOf/C9pWrMGI82OC1GyGuZRzC
         6WRutYkyzRGqXP+lqYW00xQiaaQeAq8FDiimZfxiNhp9f40DM8VSzT3Gntc4wWzUXFnd
         ySYb0ydd0OUMAnQigNO0eX0Lc1H3rkdePFMig3K2um6btc5iFSSVX+TRn5s7Zbt4nhkF
         19TPrjH+J+mrr00nbk3gvM48/Gpohm2Czt4fGmL4STkTjla+lXMfyZ3NO//2x9jUXUt5
         KXGHrLvprRY4cjUGeorvwEYx4eLlVQ7AcI+ytcuch+z+lEqSYFmspUTtZwlfD344FEkm
         4tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737440733; x=1738045533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI+Bcbtp+L0lptpp/ZEocQcR61FttKONsA5FcfRE/MI=;
        b=OBaOJekZCXtB1Vv1S/2m445poAB3gWsMWP070oPFlHAkMZuWzQNmq0XPuPbkjbaBTA
         LPv+MQjCPewxTPpVnE+CDk4KvNxQAGNm3Rwpoh2vtUdyYwzkVyKr7M7j6IEnf2340jqg
         ysnXccqd1OzIZz6yuyl3fwCLZifN4dnoCMighq72KhIttzea/CcJUfWEL5YSlDKx0GD+
         shNaeZfcljJOgjuqWeZ554ztFUu0netem4N0tIOnxDrJT0BsBQP0fcXT8JIbE06mTumk
         4Q61MMkAEcF3/I5+mXr2tIFSGFo6vcuuf7+0q1A1PIiBTMM8tV08dOCq9q5H/AjHT6DU
         LBmA==
X-Forwarded-Encrypted: i=1; AJvYcCWNBBT8zJF4oS0U7oVBx5cVhyGdZniT42W8JYsv8sv2Hu4+gkoQShFR4AXKozmR6QePZg3WY4AOLhtk80Q=@vger.kernel.org, AJvYcCXL1U25UAzoyF2SYA53JuLStGfMaKCM8qc5ckucStBiIb0rnJB9I6RbjwA1vfGktEtifOgVAdBL@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQt04QQc0RTxRX79Nd/aI0QARE9B7UzfcypFm/TWhahYFXxvb
	DpiOGLVTj8kDhnYqITmSmPbJl/3yMXmwhIpBMsCnmtdM5yOO8Q42
X-Gm-Gg: ASbGncvRlBNVzTP3CIKrBFaIyoEzCGuAtxm5u+jL4Rw4uQ6BEATRGCmOOgz1YN8CJgd
	VzuL2AyvjPhnT9kE0JMjNSdwlqRnRPRAfGWk3BF2ZQQhQED68leWfdRLgsporYpBd05U6qEr3F3
	hZtNQCEEdCT6lZuPxrgfshfB79zT0RUU5WxDSdOOxUdBYIw/sDIdJdRYRxvHhOsSn2n8yvTlFf7
	HsAmYUJ25OAc6vPEtfUxSVwHzoU1wSbajSDNx7aqw+db+Qf7d/hFFnAtSaGdJdd/XI=
X-Google-Smtp-Source: AGHT+IGEqFFcFptOhYieThLnVRw8v/b9RJDK9OgDpEyPyoFWeg55gV+CqOjA626TahjU8BmR0AsirQ==
X-Received: by 2002:a05:6a00:4c94:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72dafa800c4mr23351770b3a.16.1737440732288;
        Mon, 20 Jan 2025 22:25:32 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabacdbd5sm8280003b3a.180.2025.01.20.22.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 22:25:32 -0800 (PST)
Date: Tue, 21 Jan 2025 14:25:20 +0800
From: Furong Xu <0x1207@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Vince Bridgers <vbridger@opensource.altera.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: stmmac: Limit the number of MTL queues
 to hardware capability
Message-ID: <20250121142520.0000702e@gmail.com>
In-Reply-To: <20250121044138.2883912-2-hayashi.kunihiko@socionext.com>
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
	<20250121044138.2883912-2-hayashi.kunihiko@socionext.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 13:41:36 +0900, Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> The number of MTL queues to use is specified by the parameter
> "snps,{tx,rx}-queues-to-use" from stmmac_platform layer.
> 
> However, the maximum numbers of queues are constrained by upper limits
> determined by the capability of each hardware feature. It's appropriate
> to limit the values not to exceed the upper limit values and display
> a warning message.
> 
> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7bf275f127c9..251a8c15637f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7232,6 +7232,19 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	if (priv->dma_cap.tsoen)
>  		dev_info(priv->device, "TSO supported\n");
>  
> +	if (priv->plat->rx_queues_to_use > priv->dma_cap.number_rx_queues) {
> +		dev_warn(priv->device,
> +			 "Number of Rx queues exceeds dma capability (%d)\n",
> +			 priv->plat->rx_queues_to_use);
> +		priv->plat->rx_queues_to_use = priv->dma_cap.number_rx_queues;
> +	}
> +	if (priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
> +		dev_warn(priv->device,
> +			 "Number of Tx queues exceeds dma capability (%d)\n",
> +			 priv->plat->tx_queues_to_use);

I would prefer print these warnings like this:

dev_warn(priv->device, "Number of Tx queues (%u) exceeds dma capability (%u)\n",
priv->plat->tx_queues_to_use, priv->dma_cap.number_tx_queues);

And number_tx_queues, number_rx_queues are u32, so %u would be better.

This print format change is quite minor. Probably not worth a re-roll since one
can always view DMA capabilities by reading a debugfs entry.

