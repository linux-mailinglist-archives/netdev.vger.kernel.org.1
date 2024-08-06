Return-Path: <netdev+bounces-116005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE4948C3C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C1D287786
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900DA1BD4E7;
	Tue,  6 Aug 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de6pn6Aj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5A5464E;
	Tue,  6 Aug 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937104; cv=none; b=CnGaZwGceTsk1P/8XMrb8IgSnTv+GSC2siGFV5/7iYMAnwN44KmqGCRrqU3ySRdU3MigjJQnQogqYOfKOM1ufLgdW6RS75GSGpvvqSyCDdAF6yk4jRH0L+lTOjl1HiDbZBcudapvv03QP9lATAEjHjsacoiQAx9jEtLs0OKeVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937104; c=relaxed/simple;
	bh=+CZrvZF9AsOMY/QciGzdbapwCV3JoModRyHZCE+zn2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYugbkG1XfZQXV+POrWv0Pe+3ew7U6lnuZjUW5whyNgozT7QPv8u7kRorNqzjZgHO5gw2U92nchjh2AEul7RfFow9RL9dBH0zl7iX3bxpYII5uquA3Xa/TBe7LnGpwUhosMFM/4cTvQeYQe+5kdRdejFjey+EthEmCpok7j3I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de6pn6Aj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so5851711fa.1;
        Tue, 06 Aug 2024 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722937101; x=1723541901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJhPkSNhDdfLFx2gYQV1ujLSQnU42/h3Hyy/L0QOLPU=;
        b=de6pn6AjqjU7EPg3fqlukGfH1cs8Zm7j1IEpm+o7xei6JovXE7zF9leZBoESgzPsOg
         RXY3Ha8FUMTlsugP4V2MDYhCYL5at5JatGKa90oOM8HQWaS5uVx50HDIaRzFTaChIXBE
         pbPVsTpg/cX1AUq0+3db54NhkAUiQp7dNaX17En+PA5ewGDDRGtmZ/8N07m5+oohSSpb
         WLe0u3xeW5DA2eWBynNfyf+uCZDC2tbKol02aypZThIlNlrX1RLMjU+m5R6pe+S6wEvk
         P8fpE7TwDWq6vcRtRHaUIKIa2nfHzfMC0928ue9/wmNVGSH4m4ALtx7IYe/tl/+/Ac6z
         8Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722937101; x=1723541901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJhPkSNhDdfLFx2gYQV1ujLSQnU42/h3Hyy/L0QOLPU=;
        b=vdGixwDj4p/osTU3G5ydBa15bERtPGthsMM7gqAOF3Rw6hk3ULFaulrWvPVL000vgv
         8acjw6w3dC9MCamHwKho7WSxDgH4rga9b5OV8O/6twW4FuufgMmkbNxZPvgfIMG3iEaO
         hDItUtqi5wNlK7m4n6aw1dlRrTIRbgR3ymRhk48fSrdSWRDlV8lBH6r3xh0dTPzSOCnZ
         HSKPexcUGxNEmTcko99QE4djrZ3ovgmxmwewhuhBzNYsygIbiyx7pjVXUhEOWC7Edv4v
         hW4IFPzzIXr2rtRSz2PQYGgRoWetRX6TuIrNtNvKzH6QrUnLOCNCz+9TGLn18z0oSIdi
         QDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVYq0/LzcPbHVb4/gmZwJSQbDk4y2B3FDw/ffo1CxQvMUkKPKfruBPUFGBpNKbAR2WVL8tcEY4pooIHXewF92MqXxZnn3GpNZDaTKq5a53xh20kWA+zvj0dPUjwZhpczzlP4Gdh
X-Gm-Message-State: AOJu0YznpfeKCuI2LLUNC0ucnkEpJcKxL9QvxUkkKp/grgXMyjC+fv3F
	pHBaei6yb8uKyhg3Wm6a40ZeLTf4ytJ2a4PU2/tIMmarexiRM9Wx
X-Google-Smtp-Source: AGHT+IFR0d9IbwmBLkFeFJ77ILOonBUYi8sHr7IcC+G13t/ZZueEUcGtc9YhZIfAx/55SH5oSzfzsw==
X-Received: by 2002:a2e:bc23:0:b0:2ef:2b70:5372 with SMTP id 38308e7fff4ca-2f157662670mr54682171fa.12.1722937100530;
        Tue, 06 Aug 2024 02:38:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e272eeesm14033861fa.128.2024.08.06.02.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:38:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:38:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Message-ID: <mn4c5yw3eodduysjaxvt5qpsfm55auumin3jabmu6zymeskdsb@7hvc4qrw6gsn>
References: <AM9PR04MB850628457377A486554D718AE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <8aa45bc5-b819-4979-80b5-6d90a772b117@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa45bc5-b819-4979-80b5-6d90a772b117@lunn.ch>

Hi Andrew

On Mon, Aug 05, 2024 at 01:11:16AM +0200, Andrew Lunn wrote:
> >  #define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_scr_i/16 */
> >  #define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
> >  #define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
> > -#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/122 */
> > +#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/124 */
> 
> That should probably be called out in the commit message. It is not a
> fix as such, since it is just a comment, but as a reviewer i had a
> double take when i noticed this.,

Yes, this seems like a typo. I've checked the divider semantic in the DW
GMAC 3.50a/3.73a and DW QoS Eth 5.10a HW databooks. Both of them expect the
clk_scr_i ref clock being divided by 124. So the 122 value was
incorrect.

-Serge(y)

> 
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

