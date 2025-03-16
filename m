Return-Path: <netdev+bounces-175107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138BA63551
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BBA3A4580
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FB19DFA7;
	Sun, 16 Mar 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBgnJ+wG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D48635E;
	Sun, 16 Mar 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124124; cv=none; b=tJe7jlrbVCfuEScAiVfUZm+xerzM+r1JMaCeA6ACSjs8kBbflbJmzO0E5DTlx/J/+kwU29CZxzJREHSyvcA8KyQNtbuP/Ad8OxlgO5NLW38cYr7LDp585kfsFcNm7/kYT4wz0VMGMQjf/4ViD16joEc+ieNFIxprAy8nqqtASvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124124; c=relaxed/simple;
	bh=SmU0h+d2L/ZnLPStnz6nB21B5/N2fkHE3+xO0Ydd7Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atLm2O1TmapA/y/s6aSRXySApRfz4xmMS3cC76p2XPLwhFqR/WtxvFnXBd/KwNZaK2inp+pfNwmWi+YBcJV21FKOX84aBc68iLUbzFCQQsEXN0zLj7gHvQeqjaRty0kHckSOMUh8ZD6bkh1tqjm2fLPm0EX2E4HS5a6p5YQ8mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBgnJ+wG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac27cb35309so570318766b.2;
        Sun, 16 Mar 2025 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742124121; x=1742728921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2FKujD/WDFzQXcV+BlOMXkIXZNzBUdKMFbX2p6VQMU=;
        b=lBgnJ+wGKoxVShopY/aPvhhpxilaXxkEwCiFO3oNUNLVtUT2yWpNvQgDPImSbn9CRt
         gL6Bjh/PwVkjyJjoTeNC2jPJELxC9uuNHbgAwTeYBAEzFDZdFvYqyhafG0+Xm6HZmDjN
         5fgXr+//nHKpqSbMNEV2MIN9pSsDe61quCN4x3sqY3ajA921nSM4Mdl/NcO75Wn5Bi7c
         0T5omVSQkD3yLC3YBu692UIko/jAsROkI1KR22b3xAO3tGU+05Aoq5jC5FxvdmO8okPt
         QpGSoeHVsOOiN1lRvdlcISZp2QRJkFE+FsguNNt51Bc4yH6XRmKByOjnF+Mfui3IDprB
         3BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742124121; x=1742728921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2FKujD/WDFzQXcV+BlOMXkIXZNzBUdKMFbX2p6VQMU=;
        b=SBKAHnuH1AzynGRwBNFLFSCtilou2Uela22ZO8xi9dLzAeLkyZQJtX9nfvhlip7XZn
         /nwScBoa5CgvMxaKy0qF7dgcNt2m2HwUksd97CjpHztyN8NK6FwT07Cid2YS6JLb5Chh
         3c0+UMNtYFfm8+HH7t5yxx6fXMjykfWGGzYyDKXg+0EWr3bHFYWlBYgTR3YHFbFfx5as
         Rjuhnxwi0MttgkMFVEM2Vb8T9Pn22HFOct4UQNb2wTuAKnnR3cViSWxfbp1WO8LpqSzT
         4VUjddTm79jFG6nSqdj1zccNx8t6+SROTV9PUcJDgxyM8CfO0FkvY5jEI/ObNIMDDFiU
         Tp9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqAL6mDSZW5G8P7cwUQbfl/UQ9gdFNbr9Y1f2FqEe27rGSOPAJeptleuLIZx2CXebG7bvJ5G1K@vger.kernel.org, AJvYcCXLf9tjtSREpqYeWBFqAvVqzNJjUrphIQr5mJu3adsuJw1UFa5c/9BlbTI91prnxMUnr4WQ2jlMHtvs0B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXy01gjeXdudtfBnwptsr2tzrg9TcEPHPd5uX4CtDXuiX69jZ
	PXZcX1svL8OhzXWNlWfPMinxKrSytkdHy11iVBBzaFCD3ataIloQ
X-Gm-Gg: ASbGncuBISdNJbXFUGMD+qHf0vX9eXTqti7ZKBNRW3Iac1tJQXDXiEbHSulLCOwNacI
	9uW0WUvFT4WNNTnySJU60XYnzn/DjtNykxxT84T34CuMepjY3rK5ECMLHjvCrabx4fqwUKZOOrw
	p5f+6tQ382oP/8LEx2I9VRpVIEwaqaLishGz5t9TUSoH8I11hzvIJuQyZwaMefDKTdy5GXcigEL
	dRkOJ6SHa/5POsh6isc78lNm/Wou3fQctIWdeNpMxXfnwse5f5a62p4+BFaw0sr7Df0w+BKDpnR
	2rSOF9Kn5iS2wI30n6SF3vttkk0PKujyJOKrtSI87A==
X-Google-Smtp-Source: AGHT+IH/GWjOJrpmeT0R78wt9LzZ4p7kUJayvibJT5ShbE6GtGJriC+yQqB9quwCCLoTtd6wqbVeQQ==
X-Received: by 2002:a17:907:d92:b0:ac2:d5e6:dea7 with SMTP id a640c23a62f3a-ac33017710cmr984890166b.13.1742124120501;
        Sun, 16 Mar 2025 04:22:00 -0700 (PDT)
Received: from debian ([2a00:79c0:612:2500:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa5a24sm488633866b.180.2025.03.16.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:22:00 -0700 (PDT)
Date: Sun, 16 Mar 2025 12:21:58 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: dimitri.fedrau@liebherr.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: phy: dp83822: fix transmit amplitude if
 CONFIG_OF_MDIO not defined
Message-ID: <20250316112158.GA4035@debian>
References: <20250312-dp83822-fix-transceiver-mdio-v1-1-7b69103c5ab0@liebherr.com>
 <b753c0e7-e055-4764-b558-68b7258a6b6f@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b753c0e7-e055-4764-b558-68b7258a6b6f@engleder-embedded.com>

Am Wed, Mar 12, 2025 at 08:53:29PM +0100 schrieb Gerhard Engleder:
> On 12.03.25 18:23, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > When CONFIG_OF_MDIO is not defined the index for selecting the transmit
> > amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
> > is no need to modify the transmit amplitude voltage. Add a flag to make
> > sure there is a need to modify it.
> > 
> > Fixes: 4f3735e82d8a ("net: phy: dp83822: Add support for changing the transmit amplitude voltage")
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >   drivers/net/phy/dp83822.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> > index 3662f3905d5ade8ad933608fcaeabb714a588418..d69000cb0ceff28e8288ba24e0af1c960ea9cc97 100644
> > --- a/drivers/net/phy/dp83822.c
> > +++ b/drivers/net/phy/dp83822.c
> > @@ -201,6 +201,7 @@ struct dp83822_private {
> >   	bool set_gpio2_clk_out;
> >   	u32 gpio2_clk_out;
> >   	bool led_pin_enable[DP83822_MAX_LED_PINS];
> > +	bool tx_amplitude_100base_tx_modify;
> >   	int tx_amplitude_100base_tx_index;
> >   };
> 
> You could instead init tx_amplitude_100base_tx_index in
> dp8382x_probe() to -1.
> 
> But functional it should be ok.
> 
> Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
>
Hi Gerhard,

will send out an V2 implementing your proposal. Thanks for reviewing.

Best regards,
Dimitri Fedrau

