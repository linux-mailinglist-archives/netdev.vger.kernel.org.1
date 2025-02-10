Return-Path: <netdev+bounces-164722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE17A2ED6C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EB8166F14
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29512221DA9;
	Mon, 10 Feb 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHhCp9MU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017117557
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193662; cv=none; b=Ju1A2jom0SzsfrZ/Wozz8Q/lNCmd0dKUsvP0aDpJ0Hs33ZOY+lBl+0w55rbUxkR0xmnljrxn2t6qngA49s+CbkOrHWtu9obWv/cNznEoNR4gd8rsYl4cOQoSfoTPPL80hAz9/VMM8PVmy2OYecIDy5qQ/LN0KYoFyxTJ1z/6DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193662; c=relaxed/simple;
	bh=Z/ZxQ9HB0LGdcnJMJMiCL+HTzBP4hRUHrxJuyTdc4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBvSormdQto8g4MZuc1XDCEjbs+VbrbnMlgwihNjZgQ8beqEwNHZ4o++SZ4lOIzPNUMA3oMHjmaKWe+3CTx6m+Qi0fL52eEt1Qt3fmVXXG8Cjj933ag+RDqgcCGKm0x3lTUVerXwudJFZTXBhwF/tddtYAzoUQXQt2ZXrpoW3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHhCp9MU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43938828d02so2554085e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739193658; x=1739798458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IR1STzBHWflyOdMHe8euRfwJ+fzKwFGSyoXduLUKaJw=;
        b=CHhCp9MUcVxXFqwerLSmG0u5US18visbAT1Cbfl6RwEDucCrPHjm18xHUPPK1JsZu8
         gdhQyk5tdyTKM62OUr0Fkr4gkDaXwL2xcTpNogiN2guBEGsZ7tREN7RPbby+T07r/pRR
         Ijaeqz40wik/zOctWCk9wAUaW/quVPTvPok59ustZn6H9d+uye2wizLaEgJB1w/iMhLI
         stzskM+s2aIotp4CwPoFA0biy+K+16D20v/EWqv8cCRPzbRzH5khzV7rmZsyn1XtSOV+
         J8Hrsyz0vNP5U8lqT9WotzppVzjn0WKg2W9uZYdHjrPQTbIple3H31JludXXKRUsgY0R
         OREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739193658; x=1739798458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR1STzBHWflyOdMHe8euRfwJ+fzKwFGSyoXduLUKaJw=;
        b=e+FAQww78MVgigsRAZ4Lta5j+R1dfiSXuDJ3RWT9RHaxki2m1FRkdbVu/NzkFaeI/i
         UwnYpN8Yum83Co6BLOPrrvAyQOvW3iuQPQmPPZzgq7yFzz1G6vOl8GJFKZHEc8TTDyAU
         RWjASHN9p/oLXUaS7s32LM/Uk9H7bOwDB9wDh/MT2ln391lNJzWiwfTmU0THVKA5dzB6
         eVezw+FoexnDqtzjPdKRsMoRuaTi9q2LfBnwTsmjzVFh31blA/5xaf0DN96H4AhFA8RZ
         GEiMUrIAGgwW8/Pv4zC50EUYn1lNVGEkrJnHAM0aW7pUbe6wjIKfDdZzuJtLWGibrWhb
         MaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZY39+2EbIfZuh2/hFuzxfEeEpcnMn+nYj0jKrNeQnxAHYI91G9a+I8o66YzILniJIDWcraSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxGPiYyELSRgZ3Jjqf7AD3LrQ4fx93WIl6LppwKxuaeqn0p84
	om/Z+4GF1F5Ok0rZy6g8SJay6T/n9lsyZD9rC22nB58GooFrU7fJ
X-Gm-Gg: ASbGncsMOYiabg91gHWmnaHTELYcEReZnzUo1wcU0pWC4uU2C6DgNi4u5MupN3QnNE3
	fkWMej8NxK2n1GpgEzqDeLYrRUbnTkoi1qmU0enu7QCBqHAcFjrrTYebmSx10ObDkaLPMBDIPyN
	HNVP1GVzHMn02Ibj7wuCC2YyBOQoYPoOmh7tFnlQzVyHq5cUsh3fQJXaqiCSuJO+vKV6RC6t828
	iZMjQ9gBSpWE8JVujUUxpRRirpcnNnNkuNw2HO4dm9gdEaZiE6/b9MTX07ph1XrcgTRg0aaqbwf
	qOY=
X-Google-Smtp-Source: AGHT+IHKAnx4OMOJyxd+FsV4Q2cMCuFMhriiOBiD/pKtcrVChJIsEdo0ysTRISiCt7SIXZmiHfdEkg==
X-Received: by 2002:a05:600c:444a:b0:439:4b67:555f with SMTP id 5b1f17b1804b1-4394b67585fmr4261405e9.6.1739193658476;
        Mon, 10 Feb 2025 05:20:58 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4764880sm6684638f8f.25.2025.02.10.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:20:57 -0800 (PST)
Date: Mon, 10 Feb 2025 15:20:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net: phylink: provide
 phylink_mac_implements_lpi()
Message-ID: <20250210132054.oaqb5mboh6qiixfv@skbuf>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
 <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>

On Mon, Feb 10, 2025 at 10:36:44AM +0000, Russell King (Oracle) wrote:
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 898b00451bbf..0de78673172d 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -737,6 +737,18 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
>  	}
>  }
>  
> +/**
> + * phylink_mac_implements_lpi() - determine if MAC implements LPI ops
> + * @ops: phylink_mac_ops structure
> + *
> + * Returns true if the phylink MAC operations structure indicates that the
> + * LPI operations have been implemented, false otherwise.

This is something that I only noticed for v3 because I wanted to leave a
review tag, so I first checked the status in patchwork, but there it says:

include/linux/phylink.h:749: warning: No description found for return value of 'phylink_mac_implements_lpi'

I am aware of this conversation from November where you raised the point
about tooling being able to accept the syntax without the colon as well:
https://lore.kernel.org/netdev/87v7wjffo6.fsf@trenco.lwn.net/

but it looks like it didn't go anywhere, with Jon still preferring the
strict syntax for now, and no follow-up that I can see. So, the current
conventions are not these, and you haven't specifically said anywhere
that you are deliberately ignoring them.

In the end it's not something for me to decide, but I thought maybe I'm
speeding things up a little bit by opening up the discussion now, rather
than wait for a maintainer to look at it.

> + */
> +static inline bool phylink_mac_implements_lpi(const struct phylink_mac_ops *ops)
> +{
> +	return ops && ops->mac_disable_tx_lpi && ops->mac_enable_tx_lpi;
> +}
> +
>  void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
>  				      unsigned int neg_mode, u16 bmsr, u16 lpa);
>  void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,

