Return-Path: <netdev+bounces-107325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99691A90E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9791F26FDD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72EE19580A;
	Thu, 27 Jun 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHFXO7wB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0C14A636;
	Thu, 27 Jun 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498083; cv=none; b=CwTzWBfgezO472iL22FqhtJAEnqQL1dYZBZDkuZNk6AQCUE7fe8WLkEK4nSmsTBQmm8NSvWeIk7t3Hb1RhLc7B1KlXKOfGAaADhgEp7rstQGw4SipE6osvcGeVWYC/EYaUQnhQ2gCMjaDiPxCFEitD38BbrxJMK6dN0oCq+uw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498083; c=relaxed/simple;
	bh=wFM5Kmk4PKgbdICFDwOvHvFB60JZ4ferC2yqrgNHkQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCqhBKAuJkMqrx1ZSNfZ/NJtGAZLSoSbdzrOLLJLiB7WoyxcedogpshyK4A0ISHwvDJS5ZU4lH6kdDA2909TjW71ifqKSmrQDCCaT7Hlfnc7HruMNUyBPT7AqY/uUkNRyvbF7/6/GlE94jG+yF+jSsVyf+lVf6PQtcHnOZ+3FPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHFXO7wB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec1620a956so94986901fa.1;
        Thu, 27 Jun 2024 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719498080; x=1720102880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNKoH4rzJ344zkKbrOWrYDXvT+iIE/hfmaxUTk56nJM=;
        b=nHFXO7wB3dq7QCCzmzkByek2umlrQGAnKj8VW5s78wnrFAQJJd46xZc3IqDtX8w5fw
         INgj0ExpUpc2yqX/eqjOC4ZFH3a1kl3+tLn5p2TKoW+Ojlmoh+nc6UNiIWQ3HZG2OIFb
         ijTUPM3R7Rg5gMUzOQlf/slBe6iVeE8kjtLSMxE4aOu/c5i/FtqBAwKnWCnvnMoa68GH
         PXxjQs6zMOq9pzcDcp+tlubiweou/TFD5Qfpk8K0UbJTE6DdXFpExpEyzM5vTwLw2C5A
         sk6H2OSdwTiSR/E6d/I42H7AmqixoQyOX7PDFoWMhwzL4TxS4jPX5MhJm0DEpXPIsUF6
         4cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719498080; x=1720102880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNKoH4rzJ344zkKbrOWrYDXvT+iIE/hfmaxUTk56nJM=;
        b=Tkt7uoSfi3Q4Wrj/NXHFf1qf/yqxs5OS1kT/hkEC+QVat3cyvJ+9VCjhvUgBZzPRkz
         LYNr8rWWssbWlaSWYWVWwYfLd1DOZlsfZK4gEIOYYTSWugOtkLxG43g/LxYZIhkN2a2d
         voYuxq5d61H24z+MKleHIQ86a2VXQndSn+aEfVwtRyjDeKppx86DfCuVeWL2CJcYerXv
         /OPiE3R/3RjYjEz8++VZP7TLkYaxXOhPa+OzjCA1a1C82yigjdIAc7qlirXi4IJao6ff
         npDpJCrLedwbABdezzNQe0HD5Gsr1DPegEWx+7wRqdGgobing7L01XOdCbManP/5MMN9
         ZkOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQMgyyiv9ux8wncnRsNNmhYEye8vKUtu9+PwaY5AO37iBJwaMaB8gc+qYMtc/UzqdSinumQt445NAVZ5BL5xUmNzRcJ7Nfu/7v3lLU4bLje7bwsIruRAylADmBWT/sh9gpFKZk0zthfsBc2xC97ARXHlADwr3UIT09M81c3xYFGg==
X-Gm-Message-State: AOJu0Yw6hEtg+SzJzpBUARZl0QaCbel0+l9o5zMVbkD48oOJ1ELEo54F
	fD7MCeQLkqEnF7P1XQe3ePMOZZ8hEZjoZ6BaHeVNGmkM+z8GfCXo
X-Google-Smtp-Source: AGHT+IEHVOZ10FR3wZmTdwRxdIJLg1s0iN53vUF5fAbGXdSCMOMhDB4n8Z8vdnbYCxSJ4aGmRz1Ybw==
X-Received: by 2002:ac2:5e79:0:b0:52c:dc0b:42cf with SMTP id 2adb3069b0e04-52ce18324e0mr7752453e87.9.1719498079833;
        Thu, 27 Jun 2024 07:21:19 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7676dd0esm50342e87.87.2024.06.27.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:21:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 17:21:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
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
Subject: Re: [PATCH net-next v3 03/10] net: pcs: xpcs: Convert xpcs_id to
 dw_xpcs_desc
Message-ID: <2iwe4r3lgx3peufwuzdjhpqdxlbupwant72smia3fir2u5va64@ofbylcmizolx>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-4-fancer.lancer@gmail.com>
 <15754e63-be47-4847-8b61-af7f8a818a3c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15754e63-be47-4847-8b61-af7f8a818a3c@lunn.ch>

On Thu, Jun 27, 2024 at 03:10:18PM +0200, Andrew Lunn wrote:
> > -	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
> > -		const struct xpcs_id *entry = &xpcs_id_list[i];
> > +	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
> > +		const struct dw_xpcs_desc *entry = &xpcs_desc_list[i];
> >  
> >  		if ((xpcs_id & entry->mask) != entry->id)
> >  			continue;
> >  
> > -		xpcs->id = entry;
> > +		xpcs->desc = entry;
> 
> Maybe rename entry to desc here?

Curiously to note that originally I had the same idea in mind and even
implemented it in the first v2 version. But then decided to preserve
the original name to signify that the pointer is a temporary
variable pointing to the desc list entry.

Anyway I don't mind changing the name to desc especially seeing I need
to resubmit the series anyway. Using the desc name here won't make
thing less readable here, but will also provide a notion about the
variable content.

I'll change the name to "desc" in v4.

> 
> Otherwise
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks.

-Serge(y)

> 
>     Andrew

