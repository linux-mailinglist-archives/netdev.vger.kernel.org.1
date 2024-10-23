Return-Path: <netdev+bounces-138278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E79ACC16
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EFF1F22E06
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91C1AD9F9;
	Wed, 23 Oct 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0I+TtPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4321A76AC;
	Wed, 23 Oct 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693027; cv=none; b=dNE87FvcioHjt+5juWQfROdau5dZDSi7wtnPImA3OQh8CPQVBuscnn/Y/h9sf617i4woGKtfPE5EFrPwwFfnpC0/Uq4uLf8OQDkbsi+PXe73Gz+pIEXCmksTFUTJvHq1vUegLrl+0WDKc29tkqxQ+puQ832lBRW6kXr7hh1SENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693027; c=relaxed/simple;
	bh=8kfS2R9YVsD/Q8hk9vBS9eQcXea1qRK9J4J4v2s0390=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZHsNoq8P3fqRcxeMPHTb3d9cmajan5f7sLVdFaVLpawRf6WutPvQX02lW0qaavaU3gmP4nd0nvYNv1B/B5c+IR3kWno3+A/Gi/ER7e57VXryjNnfcD5GEf7+/jzVVqHHcki6QsTM8RQDkiEZJ+grLeOFuNm6lZch/SxT6x02ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0I+TtPs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a123f2eb3so71579966b.2;
        Wed, 23 Oct 2024 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729693024; x=1730297824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgEr86OeLs+qLPckKWtoHddsgWSl6fk02nvmP20gJ1s=;
        b=X0I+TtPsXybANHuEMhBWObupqMo3lCWU0I6xV8VpQvJ0lAC6Pt2npTq7ECPRsyQN1f
         UC0Gzw0nOcjd5ejZvhP3h0bYefZzVd+ycwkaRn0HVTpWtup8XErADpUeLcQbNxQdWgg5
         9f7UMbmKJ/mCwRSgtu4YVNYHDwnk54gWyf/o6BYoF9zxgjVcNFtSYhNKv1+nhVC8Ls1T
         S69n8VTTihkDyBNXa6PQIlfUMdu1F0fW/lKqdwACp262YO0h3+t1ulzr/emhQF41lM6+
         a7S/UuX1FLbgMLQIEYcVubvUgwhHZqCClt+N+hzMrPRYqcntOLuh3IKpyExRYAGypGs4
         TtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693024; x=1730297824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgEr86OeLs+qLPckKWtoHddsgWSl6fk02nvmP20gJ1s=;
        b=tzTmXL972BEAgtEFzxdIcwCmB6RFhXQoXPpOleMuvmXWdWH89t2LigFCemSEMLxBjw
         WYC7qiEkeMzSkG535MJf3fNKQbCfGFwOGkm16RyTzIBbqP01xekrlePtmDzYx6UaffiX
         bawLF1k7TNuxixphq57jMJiS/uG+Hhe41SpRYa/y/Qqe6W9asTM+xpU+QDsMInt3qVHe
         E2vRao9I8vplXtRvTh+ac1gdKsUdiqUs6R36T+MM5KoY8pK3PyCPD/iXtRZDJUQAptav
         Yrw+Aisgg5XqvEelXhNxR9wFVshs8UyYYRJG9Zi9Ym1M7JmTuLQtebNl6ts7xvLJ6bxA
         SDyw==
X-Forwarded-Encrypted: i=1; AJvYcCUSn28k6ktb64gqoAWPH41R0Cl8PhhH9NKUKAM960LKbaoyKGZdNJk3H/vItjVJ+VdA8qUwNfJbbENLc0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJ7KcXWMHeuIlybh7bpPmxv2RdyzUxiUyYeJuyEx0/QGGsPX+
	ecQeFElcn/il0lD/AP5OuRRZ25yku9QzzVIQlFmtss23SFAMTSW0
X-Google-Smtp-Source: AGHT+IEV0YikMikXJEsk3rCrnY1FH/p9IQzfHmP4dSCxt90dLsVCtjcMi6dhpcSlH+cOBzDnw0R7Bw==
X-Received: by 2002:a17:906:f5a7:b0:a9a:5b78:cee5 with SMTP id a640c23a62f3a-a9abf92b233mr112552866b.9.1729693024025;
        Wed, 23 Oct 2024 07:17:04 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9137053csm481018066b.115.2024.10.23.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:17:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:17:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v3 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241023141700.niz3ow2xu6pbgbg4@skbuf>
References: <cover.1729663066.git.0x1207@gmail.com>
 <4949cb6845b8a4e7c79af4165814fad270459f7b.1729663066.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4949cb6845b8a4e7c79af4165814fad270459f7b.1729663066.git.0x1207@gmail.com>

On Wed, Oct 23, 2024 at 03:05:23PM +0800, Furong Xu wrote:
> -void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> -			  u32 num_txq, u32 num_rxq,
> +void stmmac_fpe_configure(struct stmmac_priv *priv, u32 num_txq, u32 num_rxq,
>  			  bool tx_enable, bool pmac_enable)
>  {
> +	struct stmmac_fpe_cfg *cfg = &priv->fpe_cfg;
> +	const struct stmmac_fpe_reg *reg = cfg->reg;
> +	void __iomem *ioaddr = priv->ioaddr;
>  	u32 value;
>  
> +	if (!reg)
> +		return;

What are all these "if (!reg) return" checks protecting against?
At all call sites you ensure that priv->dma_cap.fpesel is true.
If defense against driver writers is necessary, check only once at boot
time that if priv->dma_cap.fpesel is true, we have a way to handle it
(priv->fpe_cfg.reg is set). Or are there still supported DWMAC variants
with the FPE hardware capability but without driver support?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ab547430a717..7874a955ab60 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5944,8 +5944,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
>  				      &priv->xstats, tx_cnt);
>  
>  	if (priv->dma_cap.fpesel) {
> -		int status = stmmac_fpe_irq_status(priv, priv->ioaddr,
> -						   priv->dev);
> +		int status = stmmac_fpe_irq_status(priv);
>  
>  		stmmac_fpe_event_status(priv, status);
>  	}

I think this coding pattern is illogical, and the code refactoring makes
it more apparent. stmmac_common_interrupt() does nothing with "status",
it just takes it as a return code from stmmac_fpe_irq_status(), and
passes it to stmmac_fpe_event_status(), both of which are in
stmmac_fpe.c. Why isn't there a direct tail call from one function to
the other, to simplify the external API exposed by stmmac_fpe.h?

> -- 
> 2.34.1
> 

