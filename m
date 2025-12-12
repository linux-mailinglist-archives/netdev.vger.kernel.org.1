Return-Path: <netdev+bounces-244502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EBCB9022
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D62305995A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B92C0303;
	Fri, 12 Dec 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKpsIKcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD062749C9
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551180; cv=none; b=TObTAh+lJS/Gy1Ywte6YVUi09YvGRA0uA/lGZJgL8LMQn58f7TA7jF841igQrDcud9SCxUoRZnqaY0RP4BbypeLoq3ItQBe9Vs8jXslzTfY0EWgjrrXV1AO9MTcBoMHWe2mtFx/9pzTJ9nJtkPBK75N98d1H1uJFwmYS6GKLHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551180; c=relaxed/simple;
	bh=9aalN3iIt0shB1V1DyA25xbGmIC+TsiV1zGrnUlxzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJIJwps/AHHSEiv28ki4Gg1DQeTgpHxV2S7BWP9OJJI+VaG1lAOjCB6OYfzvZCpR5VGl1GZ7/RPH4VYjXpLz4czfEIG3quERDpz6jcIa2T9yQfPbPwqT10eMyCMwHATgVDqW52Vbr8CUst7V2hflSeAh10VVNOnx3a7HYeCMnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKpsIKcf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so268650566b.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765551177; x=1766155977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yUReieb1K2oOWPPY3JQGsnjSf6j5tVWjwKkNaii9NI=;
        b=aKpsIKcffXDyH3XFO86yfgN2fyjjvIcTLzQRHIfvkNwxbiQykPRQxJoArF91zsBDwk
         s/Yae01PT9oiFpA/gB8H6Pe+tTJxhkofeu9vyGN/nfviM4PeFuz/Uf2jCvrEarQFldfF
         viCHFM1T9+7B27i7lVeBh75x6DLCg7Gyh29OOIZXlgETjq2I5UEJV7/8ABDDKksOvbNz
         z8vUnmH56VlGz7O3GImZgBdUIbM1lQ7DZX/uSjvwEhtrW/P+D+6jwpW2lGjf4T+5x7al
         K8b9OeeE1ANRzRjfMrpFoEmqQOsNXE5ElZgYLRMQaUK2LYaaaMdMxa0EBW5T0Fr1nK+A
         vshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551177; x=1766155977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yUReieb1K2oOWPPY3JQGsnjSf6j5tVWjwKkNaii9NI=;
        b=cQlz9o65a+DQQ6w3Ulb60zhKk2+7+A8V2mr2oKNPEk3ndz7umHo+6la0ANfHsvpBIh
         EELJbbscir1Ze422ofROyOzPyvnqB2+BDK5xv0z+Ikld9ioAixIZ5kRhsmG5QAL1/OhP
         j5Lw3pxQwOA850jQHisu/scxhiBnmr7vB1+8qE1j8n6ivebJU4tUjEYOaCqZVmPhYbBL
         oCy7CkFTT+Hnc3dCZXsqR+72uzCKHnXBXDyy7q4OqkLmHKgNa3sDwsmfkcDynXIAN84m
         UM3/2q82GNyTn44YFN4DC1fsugqoy3bzqDY+AsYUcWWQAULu4bbckyPpNaU5rH8qDtV9
         e7YA==
X-Forwarded-Encrypted: i=1; AJvYcCXA0X9Zm19lg4epiU5Xi2MT2QGi6fytSnyafraRNeV9pPSYUdw2UwmnUpsjHz4ItRbOzG+8GGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQPsYIMJez+QGiM/CpZtIqRjqtND5HpxhaPmhfEvG1Jrb/wQz
	Zp8aVXX2eN5nr+DLIobXYRzzT4+u1aVvvQ98Y+5EFPXpqF/DXOdT0OzR
X-Gm-Gg: AY/fxX7S5vMSunNBRRonYRmkB9aDaVix4xvsF8e///h7xhiNFq6mPV33fh7dzaPTOu2
	hNUaHagofC3/9LH4pBoQ6SqJ2WFyD0Nnk0dDJVLvEqhTn53I3Pp/iSigGzVQt7I+vfZxV2WQWRb
	pDTRcz4nFHB1C5iXe7TgR+B+ugQev6EafEMDRnHfyrhSsf70wg2guNRadvKxi4wp1G1Bri55X1A
	QO/QXPmajgLr6olUjecOvZ+l4Z9e7ZC9zlV+I3QTn6sD6wlMaD9rzwKIxU6sg3eDrcH4ln7sd5+
	906pka2bybJ6Y87PLYJ49mXUwbJ6rC9CkYSIEgnu5BYMWohLycVvQxQPPlbx3S8+ATuLclz4gp8
	OqBEnx+SUU6cDmQHDyoNYWTS2aeV21jLvpqcd+o0Z4kfYpL78G9nGqpt6OWfdr10R9LdmRSiEF4
	rd8uUQDzPy6QU=
X-Google-Smtp-Source: AGHT+IH1U1ZjwCLnYKQrAW/Sz650dZmjwbQH47Imb1e80uv9f56gsYLEudYaK6I8NhNOKSPfGtzoWQ==
X-Received: by 2002:a17:907:1c1d:b0:b70:be84:5186 with SMTP id a640c23a62f3a-b7d23a61d65mr208508566b.44.1765551176855;
        Fri, 12 Dec 2025 06:52:56 -0800 (PST)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570174sm573795666b.55.2025.12.12.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:52:56 -0800 (PST)
Date: Fri, 12 Dec 2025 15:52:54 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, geert+renesas@glider.be,
	ben.dooks@codethink.co.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com, rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 1/3] dt-bindings: net: micrel: Convert to
 YAML schema
Message-ID: <aTwsRiLJfHqjiLeh@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-2-eichest@gmail.com>
 <aTwjrqryY23OH_XE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTwjrqryY23OH_XE@horms.kernel.org>

On Fri, Dec 12, 2025 at 02:16:14PM +0000, Simon Horman wrote:
> On Fri, Dec 12, 2025 at 09:46:16AM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Convert the devicetree bindings for the Micrel PHY to YAML schema. This
> > also combines the information from micrel.txt and micrel-ksz90x1.txt
> > into a single micrel.yaml file as this PHYs are from the same series.
> > Use yaml conditions to differentiate the properties that only apply to
> > specific PHY models.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  .../bindings/net/micrel-ksz90x1.txt           | 228 --------
> >  .../devicetree/bindings/net/micrel.txt        |  57 --
> >  .../devicetree/bindings/net/micrel.yaml       | 527 ++++++++++++++++++
> >  3 files changed, 527 insertions(+), 285 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> 
> ...
> 
> > -  Optional properties:
> > -
> > -    Maximum value of 1860, default value 900:
> > -
> > -      - rxc-skew-ps : Skew control of RX clock pad
> > -      - txc-skew-ps : Skew control of TX clock pad
> > -
> > -    Maximum value of 900, default value 420:
> > -
> > -      - rxdv-skew-ps : Skew control of RX CTL pad
> > -      - txen-skew-ps : Skew control of TX CTL pad
> > -      - rxd0-skew-ps : Skew control of RX data 0 pad
> > -      - rxd1-skew-ps : Skew control of RX data 1 pad
> > -      - rxd2-skew-ps : Skew control of RX data 2 pad
> > -      - rxd3-skew-ps : Skew control of RX data 3 pad
> > -      - txd0-skew-ps : Skew control of TX data 0 pad
> > -      - txd1-skew-ps : Skew control of TX data 1 pad
> > -      - txd2-skew-ps : Skew control of TX data 2 pad
> > -      - txd3-skew-ps : Skew control of TX data 3 pad
> > -
> > -    - micrel,force-master:
> > -        Boolean, force phy to master mode. Only set this option if the phy
> > -        reference clock provided at CLK125_NDO pin is used as MAC reference
> > -        clock because the clock jitter in slave mode is too high (errata#2).
> > -        Attention: The link partner must be configurable as slave otherwise
> > -        no link will be established.
> 
> Hi Stefan,
> 
> Sorry if this is off the mark, but Claude Code with
> https://github.com/masoncl/review-prompts/ flags
> that micrel,force-master is not included in the new .yaml
> schema and yet it is used in the driver (and I would add,
> several dts/dtsi files).
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=2390d104-ff56-43f2-ba06-9650e8e5343b
> 

That's correct, I missed that one. I will fix that in the next version.
Thanks for pointing it out!

Regards,
Stefan

