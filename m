Return-Path: <netdev+bounces-184148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200ECA937E2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592173AA7EE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D767276034;
	Fri, 18 Apr 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWMxsFrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA726B95E;
	Fri, 18 Apr 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982718; cv=none; b=pS4fmgGhcUergXWkaz93mE7RmVVv5ThC94vQEHDL8BOdZPin0Hmg2jW4VH9GqtaMgPBjd/TPJSrijmR5e5VPhPuBqrjOj45WE+jCDxF6tlNr9haeWBnVLgN4+4UC4IVt+oOjYOR4rcmwZRBmibTIbG7krneWnk0nk/E+RvSf8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982718; c=relaxed/simple;
	bh=MuXimpFpwwqcTDObiqnJJmWYWHO19US5y6oXa8it9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORuUoe0Lyxwqrhpov5+vDfURhniJhu1vqUsewrEw0LEmkFHUIZmGiEc3wy5M5v7p8j/lqAc/PLURDB8d4S9OGo4A/Brzhy2TmMxf6ZsOM633NgzWHEleiE5gljzJh4U1M128clHSm4QoPdW1AH+obmxCaSMfZmxgInlc6cdkqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWMxsFrp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ebf57360b6so242117a12.3;
        Fri, 18 Apr 2025 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744982715; x=1745587515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVpxnI/29mpkrDRARmH1s8IOVcoXlXa8dMGnnZK1EKQ=;
        b=LWMxsFrpSiFxNMC11ku/TrjHL4fD4defmTrmrnAv6knoCbtzmCgZARneDIl8va5xFp
         iC7ts1Tv9W7rPUk/61w6ftLsm1Oi0Gs6De12I8a4ovrvwhl3fRZElzswUpbKqhfNPfuu
         zaAkc1GyVuYlr6ylrNspZLgpPSnis5uTV6E0pAakbWcufEBdTmQeOmgljfRbo6lTaqvj
         3HU7BwYjPg5/fSZjEohayL3Iko3SfjJXsKlBLfQTv31IzZJsdzsj/DoIBMF2l5MiZQQP
         pNgMAmbJSghiDXoRGqUnAIy+A99fNPCte9Eal67Xd9LYumur1vVzdLBBpQKtpLOa/zcp
         22Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744982715; x=1745587515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVpxnI/29mpkrDRARmH1s8IOVcoXlXa8dMGnnZK1EKQ=;
        b=hbkKX6zp7fQCVNVjjEyyXJPR4OGOyQImi7gSBXycjd390sJFjByhWDvxKt72LFlh/J
         gIHdZrPHU6M5bNtunAtSJFa0afHv6XbqupgrfeQdOzmHXsGeWucO+FzvIqA+qjfWHNfU
         kTPJT6IUgQtQuNr1RYSqetZYVc/7SWWxXqwxiXwrk5jPORmS/YZxhqFZ3uxo41tnwbgG
         WV2RXS1lDCZ1n5eLDZSeqYErXbythVgx6A+nwF8jfR8ukhGsJYV4raBuqmp6LROzlVFy
         NfvZ7rv9F81GLL9cMC2TE9KLtwEdPtapXCxrciZYNy/VNNZSSJSxRhKb1NR5Y19U4hbl
         42hA==
X-Forwarded-Encrypted: i=1; AJvYcCVkC1KgF1uM0PzRiWkEHdXemCJnJHqjVtQCV7Js6U5l1OeZXsMlfASNMZNdBDiglY335JtsZd1Y@vger.kernel.org, AJvYcCXqsBK6RutFsP2AEzHtRXPIdOx+U199VgXk34Gl3ofb2rK0dHly3N2HEYLvtyWfK4PpbHvxFvJpN4PlsvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTfCuKtK9ss5PrB57jS71FxfECE9AXhcQFlrEXFmfL7yeenFx
	O/oDYrrZpEFcfgwHii2exFXSciSEOCzNztNaZm3BjscRZSQPqcL9
X-Gm-Gg: ASbGnctKq2YlELQdqYavLlMkePtw4Mmqbl4VVsM0OGsAkoIIkZKe6RVAtwmQO5plQet
	VqXtsNpjZczheNxWPrBMqGg5oSHMtEamcBLNdca0hqftxdzmaiYn7JP+X715Ugdq9ujdd2tlHSA
	OlY3uADCnvnDVZiulXSfdlai4TDBGriu72ZnWjkCmuNig2Ls31jAJN6NaiqEmdsgK/zrSV7qEsJ
	wL/0FyhCNh2WuOqcssFkbjck+DEERramojXEj2588O6nJQxrDc+fDwIwbyvNBhUdM1xhe/OrUOk
	4/r/wrb2O4Pap/mx7UrqvUx0dUnv
X-Google-Smtp-Source: AGHT+IHY8YYl+gLe7z4XbImJlTJtfNKJ64WGJaDAJCdf8mISh7qKy9awk9jjoRAY+BWRqWp8cGMOBA==
X-Received: by 2002:a05:6402:350f:b0:5f4:5dfa:992c with SMTP id 4fb4d7f45d1cf-5f628536df7mr802836a12.3.1744982714460;
        Fri, 18 Apr 2025 06:25:14 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef45779sm118202566b.127.2025.04.18.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:25:13 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:25:11 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 net-next 02/14] net: enetc: add command BD ring
 support for i.MX95 ENETC
Message-ID: <20250418132511.azibvntwzh6odqvx@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-3-wei.fang@nxp.com>
 <20250411095752.3072696-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411095752.3072696-3-wei.fang@nxp.com>
 <20250411095752.3072696-3-wei.fang@nxp.com>

On Fri, Apr 11, 2025 at 05:57:40PM +0800, Wei Fang wrote:
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> index 20bfdf7fb4b4..ecb571e5ea50 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> @@ -60,6 +60,45 @@ void enetc_teardown_cbdr(struct enetc_cbdr *cbdr)
>  }
>  EXPORT_SYMBOL_GPL(enetc_teardown_cbdr);
>  
> +int enetc4_setup_cbdr(struct enetc_si *si)
> +{
> +	struct ntmp_user *user = &si->ntmp_user;
> +	struct device *dev = &si->pdev->dev;
> +	struct enetc_hw *hw = &si->hw;
> +	struct netc_cbdr_regs regs;
> +
> +	user->cbdr_num = 1;
> +	user->cbdr_size = NETC_CBDR_BD_NUM;
> +	user->dev = dev;
> +	user->ring = devm_kcalloc(dev, user->cbdr_num,
> +				  sizeof(struct netc_cbdr), GFP_KERNEL);
> +	if (!user->ring)
> +		return -ENOMEM;
> +
> +	/* set CBDR cache attributes */
> +	enetc_wr(hw, ENETC_SICAR2,
> +		 ENETC_SICAR_RD_COHERENT | ENETC_SICAR_WR_COHERENT);
> +
> +	regs.pir = hw->reg + ENETC_SICBDRPIR;
> +	regs.cir = hw->reg + ENETC_SICBDRCIR;
> +	regs.mr = hw->reg + ENETC_SICBDRMR;
> +	regs.bar0 = hw->reg + ENETC_SICBDRBAR0;
> +	regs.bar1 = hw->reg + ENETC_SICBDRBAR1;
> +	regs.lenr = hw->reg + ENETC_SICBDRLENR;
> +
> +	return netc_setup_cbdr(dev, user->cbdr_size, &regs, user->ring);
> +}
> +EXPORT_SYMBOL_GPL(enetc4_setup_cbdr);
> +
> +void enetc4_teardown_cbdr(struct enetc_si *si)
> +{
> +	struct ntmp_user *user = &si->ntmp_user;
> +
> +	netc_teardown_cbdr(user->dev, user->ring);
> +	user->dev = NULL;
> +}
> +EXPORT_SYMBOL_GPL(enetc4_teardown_cbdr);

I wanted to ask why isn't netc_setup_cbdr() merged into enetc4_setup_cbdr()
(and likewise for teardown_cbdr), because they sound very similar, and
they operate on the same data - one is literally a continuation of the
other. Then I looked downstream where the netc_switch is another API
user of netc_setup_cbdr() and netc_teardown_cbdr().

Do you think you could rename netc_setup_cbdr() into something like below:

struct ntmp_user *ntmp_user_create(struct device *dev, size_t num_cbdr,
				   const struct netc_cbdr_regs *regs);
void ntmp_user_destroy(struct ntmp_user *user);

From a data encapsulation perspective, it would be great if the outside
world only worked with an opaque struct ntmp_user * pointer.

Hide NETC_CBDR_BD_NUM from include/linux/fsl/ntmp.h if API users don't
need to customize it, and let ntmp_user_create() set it.

Move even more initialization into ntmp_user_create(), like the
allocation of "user->ring", and reduce the number of arguments.

In my opinion this would be a more natural organization of the code.

