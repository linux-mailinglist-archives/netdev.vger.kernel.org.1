Return-Path: <netdev+bounces-101356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7098FE3FB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533AD1F2353E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9AD1922D2;
	Thu,  6 Jun 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c64syZkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2911922C3;
	Thu,  6 Jun 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668899; cv=none; b=jW9XC1R2j2Cs0sO4a+91i4jXECIOBZBD9AkGae4ybMtzKE7d/e5UkEcFZHaYq8pNkmb6hCNng5w61bspM3rgY1h5lJGhqAYqgqezmVvyIzZ7D4PP8+MIWXI5sFvrlyEgTNldUKl5lPctDVAkjQtSZFxdmtSdaUX8Ok0Zjf60I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668899; c=relaxed/simple;
	bh=sRLl/T7sAUWjcjU9UYt7gfzdlUwbj7+4GSoQNc/K4UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiEUsztrrqLPWPhK9Le1k0kSv08PES07KltpFWWpgoyoTfn+8VPwdjJS+eWwHSseSDNlUvSl7PR71cm1FNgWP5Oqcn8Mn0u5h+jfpH06rmDPx/pMqCaDgLNtAfhysiZR/p2UgP0cP7DUIB0jLb02RbgM6jE1gRM/VLk0aAiazwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c64syZkQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso947982e87.0;
        Thu, 06 Jun 2024 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668896; x=1718273696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THykdbgFjTOi08AMjXYKGq55B3BCRHgQPMDRbnhqys4=;
        b=c64syZkQBwwArE2KmII1HykIDW4WcTg4jFS63SR3MbCOs3dywlmrhYYJB3Cyza+o+r
         C9z8gqhjlRkNtv8OZYkUoyBcuAbkyeknDa4jOWIFwtkfMYVaIR2Met71fJoceVcAmNRs
         IWdBkOY659ElRzzNz+6S4JLB+5H2Rj8p4va1eAyx7kuIFtbi5WQ0aJ9OwrytzaXSEsXk
         CnkgBPMmnJxRXH8/UgPbUFR7Y0rnr3CxX28UefoW8Nshaz7ibcJS52OSXDWw1dw5y10z
         f593eXjNUmpVa/90Uzn3sXWWXWfmta2l1AZQgXCIxzj4AXgQP2WdJhygzkfsFTtxQExx
         eGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668896; x=1718273696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THykdbgFjTOi08AMjXYKGq55B3BCRHgQPMDRbnhqys4=;
        b=vwGuSLPxPJCSZfHG8qsi1agBXQqFIlCJbk4saDbfYpiY8BL2farVgpIPwjcdpZyqjY
         6acyNfoatB5Ke0fbfACUhBsrEdJm9Jhn4X8yoPPVxEeoyUz24fUAWB0tQrpI24TQVEAy
         UydQwcG1DiiceTqbvojqurhB1NL2FmWCTus73Wr8AT/cnfhEkkCn9MvAV+iMNxE17RfV
         IHf3iNLRYBFQlSf3hFw7agrkTXq8WY5U2zuO8RILmUy88L6NLoQsTNDAQfidPD/Ub21L
         Oa8fXsf+pUKFxfU8dSSaetSj1J7c4bdNh138jGWMEiQjxJOAekd2a786lTVD4dSEUjgq
         HW+g==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y38Z1bRaPcnQ+HvENUYuvXnSG80FYfY8qhVd5PLhfZAICLzayWBzghdrLg85/xHA3ijD84ddE3IOdzktuCynvNoH9pakszRM3tk+WF9uqp9sFt7ibCmL8uRq8IkRzw2oaMuORmStwtVIWafPE+tT5onpElWpj/kX1qbebDoSiA==
X-Gm-Message-State: AOJu0YzCCCB1M21Xgamvgd9JXcCnyaYmFucfM5OE7kzwinTRczMkuiID
	o/E0fPnlEoT2g5UgATXXdgJHwQm/PlOTtZn3RzQNcEiIRtzGtQ4t
X-Google-Smtp-Source: AGHT+IHPfZiIymZUMudH+8iVFccu+amSG59W72z8/IwmTP98F15xmn+i0fwWfRZbTb88pA9/hEqgWg==
X-Received: by 2002:ac2:4282:0:b0:523:8c7a:5f6 with SMTP id 2adb3069b0e04-52bab4f5d39mr2790961e87.51.1717668896147;
        Thu, 06 Jun 2024 03:14:56 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb43327f1sm150215e87.226.2024.06.06.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:14:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:14:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] net: pcs: xpcs: Add Synopsys DW xPCS
 platform device driver
Message-ID: <uhswmnjhbu333kz5z4mbjtoao6grftfsn7aj4mcizmqgukn6be@6wc65fpsgkzu>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-8-fancer.lancer@gmail.com>
 <20240605174817.GQ791188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605174817.GQ791188@kernel.org>

Hi Simon

On Wed, Jun 05, 2024 at 06:48:17PM +0100, Simon Horman wrote:
> On Sun, Jun 02, 2024 at 05:36:21PM +0300, Serge Semin wrote:
> 
> ...
> 
> > diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
> 
> ...
> 
> > +const struct dev_pm_ops xpcs_plat_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(xpcs_plat_pm_runtime_suspend,
> > +			   xpcs_plat_pm_runtime_resume,
> > +			   NULL)
> > +};
> 

> nit: xpcs_plat_pm_ops only seems to be used in this file.
>      If so it should probably be static.
> 
>      Flagged by Sparse.

Right. I'll convert it to being static. Thanks.

-Serge(y)

> 
> ...
> 
> > +static struct platform_driver xpcs_plat_driver = {
> > +	.probe = xpcs_plat_probe,
> > +	.driver = {
> > +		.name = "dwxpcs",
> > +		.pm = &xpcs_plat_pm_ops,
> > +		.of_match_table = xpcs_of_ids,
> > +	},
> > +};
> > +module_platform_driver(xpcs_plat_driver);
> 
> ...

