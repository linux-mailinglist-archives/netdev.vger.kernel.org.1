Return-Path: <netdev+bounces-136696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592A9A2AF6
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973411F23122
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6D14C5BA;
	Thu, 17 Oct 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5aG5/la"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF153E15;
	Thu, 17 Oct 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186268; cv=none; b=HeRzE4y1aVPkrww/EVKlRM45kohTi18RspEnuU8KjBKSIjfV2N49uO1Og9QZKlFSeVrf2WWIWld5szeUPnyRmm+7iq1L61kVVnKi3dlvM3LIbOFAgY7+63WIum0g7svHDSh/RwkA/Cqxfi0Uuf/LaMCFEzS8DeLyZjVvZd+y3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186268; c=relaxed/simple;
	bh=wBtKKFCgOnNJ3JIehoclKXedaR94E1wS672uHF+DCR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt3S5NiFC4xxOXnjI9cH1Q2TyCJO6SuGuFvTfdNg5BleVFP3nWdsVxnQq4NUk3tzYr1z6OtrRw2/2PY3dkQotb6PmbUrUQvCJdP+qCyphJgPvxeQqz1em2Sq5r2c19gnvJj/9zr6qLXSHFbsLacaBPCYGCRFinQzRJ4Wg/KsW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5aG5/la; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso935715e9.0;
        Thu, 17 Oct 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729186265; x=1729791065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQhe5YTuIUzDPM9p0+DYkvny8q+P5qebGCGivJy9ZCM=;
        b=d5aG5/lad48hVHKP/yi/Nfk2WDpmG3hWOeRrVVFNQiy8lw6AYvZbFjuYN0/Y5C4kvE
         pWI6oA79MplI/PJeChYCLzL8jvFm3JUZ+uSFyTPnIy0wAEphtPfXq1ToFSe3Qw5EG9ZU
         phOJ/Bs8/KDklk9r0m048quOv5qfuCrM7BmGtbNZ6P60S1JQbdGekzvnyWEPCmn/nQxv
         RiT8pwZSxu1pUbdTox/19FI8FaokwllFIhEWfklkwOifLwKEj60yznCDbPv3Lo7XR3TP
         QEyMOLAGG6L3ZA9hqo+QCNb8ugbQQhquW1eUS4zqE3C5zeItJ9etAppo9Wnjz5TvoLh4
         EbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186265; x=1729791065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQhe5YTuIUzDPM9p0+DYkvny8q+P5qebGCGivJy9ZCM=;
        b=KmxfS2W/KeCb1Z1z3sXOv+6pDNxEy6oPivrzd22Tvmu/3WIi9GAWVwJWEyz2iSU9J/
         hoKt/7SHgNCMISl1Ve0Q3lm9gU1XhPF8EHfIRYhzpVqY9mFSwkvkoJ7AjNo7VG1u1PeC
         5GEZ6yX9a8/19YblAoghF+BbEYRhDCL5mxsa0ZHyJIxT2XsIH52z79fNeBOEp1zTZ/ie
         Q4MM46NCyssddiar0d5ameuCiHGXogNV0qFKyNhPM29A0SIitPcnFTPxcmf8ECwzH0Sf
         oMtbPQ07tJf5EUhDrQ10MruGMG75QoFwpMxxgsutXGJKvCoZdQ/vk6Sbvl7/sMkJh4gX
         KAPg==
X-Forwarded-Encrypted: i=1; AJvYcCXUpQO2+EVcouGBlyn76Smqj8Ev5+fFRluigWslaY2ZXAwxNoYNDEPRSyaANGZW+zAJK8/j1hQEHpmC16M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+dmf8fqaDGwLpe9mp9woOKn+q0FNfe8C+qT+CoPIqLe7jkah
	Y00Fru+Vn3fjWMPBYci49wPhq4RWH1DiYqZscj5MkYvxFgjcfdg1
X-Google-Smtp-Source: AGHT+IE27Q0RXwZxaGIC0/Z8xDnKDmjt7pfBnbOjjTsf8K19xvnS2BcDyVndGa3dsQPmgSt6uPJamw==
X-Received: by 2002:a05:600c:511c:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-431585f994dmr14823905e9.7.1729186265288;
        Thu, 17 Oct 2024 10:31:05 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316069e12dsm1898315e9.22.2024.10.17.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:31:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:31:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 5/5] net: stmmac: xgmac: Complete FPE support
Message-ID: <20241017173101.oby36jwek7tninsx@skbuf>
References: <cover.1728980110.git.0x1207@gmail.com>
 <7b244a9d6550bd856298150fb4c083ca95b41f38.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b244a9d6550bd856298150fb4c083ca95b41f38.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:26PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 6060a1d702c6..80f12b6e84e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -160,41 +160,54 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
>  	}
>  }
>  
> -static void dwmac5_fpe_configure(void __iomem *ioaddr,
> -				 struct stmmac_fpe_cfg *cfg,
> -				 u32 num_txq, u32 num_rxq,
> -				 bool tx_enable, bool pmac_enable)
> +static void common_fpe_configure(void __iomem *ioaddr,
> +				 struct stmmac_fpe_cfg *cfg, u32 rxq,
> +				 bool tx_enable, bool pmac_enable,
> +				 u32 rxq_addr, u32 fprq_mask, u32 fprq_shift,
> +				 u32 mac_fpe_addr, u32 int_en_addr,
> +				 u32 int_en_bit)

11 arguments to a function is a bit too much. Could you introduce a
structure with FPE constants per hardware IP, and just pass a pointer to
that?

>  {
>  	u32 value;
>  
> -		writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
> -		return;
> +	if (!num_tc) {
> +		/* Restore default TC:Queue mapping */
> +		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +		}
>  	}
>  
> -	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
> -	value &= ~XGMAC_FPRQ;
> -	value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
> -	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
> +	/* Synopsys Databook:
> +	 * "All Queues within a traffic class are selected in a round robin
> +	 * fashion (when packets are available) when the traffic class is
> +	 * selected by the scheduler for packet transmission. This is true for
> +	 * any of the scheduling algorithms."
> +	 */
> +	for (u32 tc = 0; tc < num_tc; tc++) {
> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (pclass & BIT(tc))
> +			preemptible_txqs |= GENMASK(offset + count - 1, offset);
>  
> -	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
> -	value |= STMMAC_MAC_FPE_CTRL_STS_EFPE;
> -	writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
> +		for (u32 i = 0; i < count; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +		}
> +	}

I agree with Simon that this patch is hard to review. The diff looks
like a jungle here, the portion with - has nothing to do with the
portion with +. Please try to do as suggested, first refactor existing
code into the common stuff, then call common stuff from new places.
Also try to keep an eye on how things look in git diff, and splitting
even further if it gets messy.

