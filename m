Return-Path: <netdev+bounces-98537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6D8D1B3C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC861C20D9D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF416DEC3;
	Tue, 28 May 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg2cpnth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400616D4C8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899175; cv=none; b=lBFFV0I9IaAWPM0b951EwFh6MK226rpxKJ6TB1NC5wTVGNoZf/ZOTFIGmfTyMOky8PftSwr49LsZ5uOa+GxQxjETUN5zDmXKTruktMRXiTwqVWwOZbD6dDrLi6QOMOmXT0/m+EU1C2icbm3IRU5ydADpHALkvMYfqrpLBQ+C9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899175; c=relaxed/simple;
	bh=PK56Qx9nFYEXVKJPL0H4tWEak73i7ANQSuMM+TIk7GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoGmeQ6db3XrySUOMgGN67RcLfiDeccETnYdO6wHWVTKHfMzdHyTrjtpNyC5MqrI8e9vzMbg/zBVIrF1kjeoi74ypVEeIIVHxPOR25HVczLMeUD+JVE8A7AbMyox7mCkzsN4ulZpYGtLF4kq+ZL5OYKQjUCeSc6k10yY0qprhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg2cpnth; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso7532761fa.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899172; x=1717503972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGw+oqvGA7DgwvDoc/gqjp79A8MF1QwuRHvTe8A8wW8=;
        b=Xg2cpnthAb8ucBeX7i063nDUABcjc+UEpFrwq6ebo68GH7KBQ81IMNjgc4COOdu3Nh
         rqKXCc9biykfrOy5ZyOy5HWcxdwfTwKBoMb/77SWariNaADMsHnabRp7DOyOUwr/eMOO
         6zzq/DMcxTuy3higeWroorr0fAkl3JiUyEYIczUOecHl9WkYdwcUkxEPaYKjvwCxA8qE
         SSkIlbblJqCZxwg4PWJ4PgH3p5PYR/ZwuHT4YRznVvjF2BXjJoPZxUSPdwABbbBEwp3p
         sgT9/zVtkt6RUbDcAjkFIFzIso+YpEWOz+9foqoJFsM15msYwcyRSDfLrtE1gMf32MfE
         xOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899172; x=1717503972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGw+oqvGA7DgwvDoc/gqjp79A8MF1QwuRHvTe8A8wW8=;
        b=L5lAKZxH6iuZ6C5M0kxXE9CeZQP8Iz6EztibR7CUFxAyKgkDR8qjr9y+gZ842perIa
         +PgBH9rRO2RMJRfXXOmdZM9gI4nloaJJ2WUL+SoJnf/NSCJB545Kwqdk4YtJ0r98C+Gv
         7aqFnuxKaf3aZQTpBmXcMcbBVr0BUTy8sU1DSbPW7axUAqt7MEYDBXlm8E4HgL8+09G3
         4dD7b/QoFTmvWnjGyyAuDAcUeY1FiY4SMPkKnCLQn0+Kx6Cz+4o2Vuc5lFNhxZQ0iPzW
         0+eUbdzbELAZUmb3Wdnv39fJA3uUzT1MujPMTm/4G5HCIWOjFKgcS4IbvHNVCSSFPlnt
         /vpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1rDqCTWXsscPhKyblBcMhAnAJPFNcM1emgEu+ALSe0ap+W44LAigaM0EbEGPzJtaTRzwOFmbRAY2uraCDFijbosxtceQ8
X-Gm-Message-State: AOJu0Yxx4PfUCzyKEKK6cVteBiXKV4CV88FG1VIi/gBBC4EAyywjmkE6
	lLxEyQrcTg/OP5tjDXo5Niz+kG6hCRIAlSOyLQvdCY3uWaUK/Mhv
X-Google-Smtp-Source: AGHT+IFHhKRh0WWtc4lf70RdyhZhbDdcVpCQy0mzBvQhx9NxjCQlG/xaC53N0d7jdVVcK3FF5NERRQ==
X-Received: by 2002:a05:651c:234:b0:2e9:84ee:ae7a with SMTP id 38308e7fff4ca-2e984eeb084mr14546011fa.48.1716899172224;
        Tue, 28 May 2024 05:26:12 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcfe722sm22466211fa.70.2024.05.28.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:26:11 -0700 (PDT)
Date: Tue, 28 May 2024 15:26:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/5] net: stmmac: Drop TBI/RTBI PCS flags
Message-ID: <66lbyxnuhqhng2j2bmnw4ke6bqeknpeb476b2wjhr3xdstr5jw@vlgbxf3ni7nt>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvJl-00EHyQ-QG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBvJl-00EHyQ-QG@rmk-PC.armlinux.org.uk>

On Tue, May 28, 2024 at 12:48:37PM +0100, Russell King wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> First of all the flags are never set by any of the driver parts. If nobody
> have them set then the respective statements will always have the same
> result. Thus the statements can be simplified or even dropped with no risk
> to break things.
> 
> Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> registration will be bypassed. Why? It really seems weird. It's perfectly
> fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> interface.
> 
> Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> simplifying the driver code.

Likely by mistake the vast majority of the original patch content has
been missing here:
https://lore.kernel.org/netdev/20240524210304.9164-3-fancer.lancer@gmail.com/

-Serge(y)

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b3afc7cb7d72..e01340034d50 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7833,10 +7833,7 @@ void stmmac_dvr_remove(struct device *dev)
>  	reset_control_assert(priv->plat->stmmac_ahb_rst);
>  
>  	stmmac_pcs_clean(ndev);
> -
> -	if (priv->hw->pcs != STMMAC_PCS_TBI &&
> -	    priv->hw->pcs != STMMAC_PCS_RTBI)
> -		stmmac_mdio_unregister(ndev);
> +	stmmac_mdio_unregister(ndev);
>  	destroy_workqueue(priv->wq);
>  	mutex_destroy(&priv->lock);
>  	bitmap_free(priv->af_xdp_zc_qps);
> -- 
> 2.30.2
> 

