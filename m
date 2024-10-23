Return-Path: <netdev+bounces-138378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A719AD321
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052B3285A50
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4F1BCA07;
	Wed, 23 Oct 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm1rTyzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88481149E09;
	Wed, 23 Oct 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705547; cv=none; b=TofMef3WqMzaubtj2nm0SFQ2kJo5Ys7idECSdaYDlJltfNuMFfhrRMQRrboRVoM7HCoL4Y1kBnAbyQ5xRUwI9tmYiuQUXdoW6uWmIPRmtfUcIGPtrCER29z3iDxhyiNyQxDHI0g97q7hPEcubbsqUgm3zvP/L/FMysgiAi/NmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705547; c=relaxed/simple;
	bh=v0Z3QmhsLFML5Hvb/hT/FmA4RUl007es1W1tDpa4qt8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G43L3O8fanUykzUKiCeAiy/1Mk/4yDMI0wVZaX+tmGI6MH5hfWxpe1JJLNxNwqJoFyH82jPfQ7OWQxYqC7wgsK0h0jovW/F9B6RfFKaPGL10iovElMA3/faJJB2FlNTFOUS7J5JFmzGQ8a6ENv1Tlk/a4n6dK2/bdTMbmrb+VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm1rTyzR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso5665351f8f.3;
        Wed, 23 Oct 2024 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705544; x=1730310344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2VscTNdIlS5vsji2abiXF+8aeUy0jlwcvqlNVowB/g=;
        b=Fm1rTyzRy2IXxTq3AvCaeWbnVhaHEypGtRSkg2J1jBrWXVfWzluVp3LUcmT81XrUTR
         GImZps85nQpwRTiXkiwS+qlc/7x+VJpQUiwNrRODDl8omiTkQNARG3DzvcK09gtga+Yt
         +LEzV2nmjp1E3cb82pJ9a6nB/yVSv94XMmOmE0ypJqqro5MYJS+dxCDsfZpt2myPFVGA
         vyB5I6A9+FaXW3FkqtQFy73zKEAvCSCBGAbNZ1WKKIThVoRktpCITTldDZm6Br9Gi/Mr
         uNNBD5hGiSgIalW1VgZjb76skJKbmYTvqdHCiKR+8rYv2i0a4TErG1C3mBz3nyELQmxB
         DwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705544; x=1730310344;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2VscTNdIlS5vsji2abiXF+8aeUy0jlwcvqlNVowB/g=;
        b=LY2wmFAECApnYAIw4Es0ptx/AODisdepR6+Axv2Y1RLD/MpCY6IXsDG8+9PKvSzlM6
         vz0EwN59wEyG8pJV/KbKHBva78kTjpakmxuBMzDLk52xJ/quLcKujuTTVYBI7sdCqyHr
         1uDFdkSk/BAMcP5z8gEpXGaM+OkI5E8DWpkjKSxxzmRMyPAxjNRM6YhRsoqycf96yttv
         ZAEYObHyns+TI0y6nk8ZrZOtHHMUXWoGWe9sXmYVB5hjV3SBjYQdQqAlmDLqY9QaV3UO
         SYW/7rD3IP81r7v4sKNv6Dj+HQPyVJJVN9qhIUwTGQ6eKl5f+XgbtBBgQUywHM2+TnBp
         HppQ==
X-Forwarded-Encrypted: i=1; AJvYcCUylFw3qZslKZ7AmUhonvk+BZArYGaGWffVVVqTSAGmVY5mEsbjPDAh2grCsOM30HNWPRJE1SRD@vger.kernel.org, AJvYcCVufVfx+/EPgwzLY4KVm1NQSPZIB6Efi+POiIqo2uRh1Qb+nFgMKPTH6u56OMHRUsr6EuRREd77rwzcMwu4@vger.kernel.org, AJvYcCXtHJk2RM+otnBFkwRtzZ1mcowatsKV6rT4c7wmm3tPx1sGu1NPZ+eq/l7eDW3QyTbvIrA8l8zFjoe5@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGXNP95xIWf2pd/MR5P1WZ0neFMc4TpAjskH8bDfyQOJ4wsfs
	3Ejas4Nd+Ii3C93hsPRLPhYXMrLGADmCOfik4zipzB2ZQeKbvMPh
X-Google-Smtp-Source: AGHT+IEY8xxWoI65TbiESsWmXVoSDRzzgUk/ryShEl9kzMOLIChMg5LvevZzioCPurdVUr/AA453Kg==
X-Received: by 2002:a5d:4704:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37efcf051afmr2378914f8f.7.1729705543774;
        Wed, 23 Oct 2024 10:45:43 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37aecsm9431133f8f.8.2024.10.23.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:45:43 -0700 (PDT)
Message-ID: <67193647.5d0a0220.1b234f.2b09@mx.google.com>
X-Google-Original-Message-ID: <Zxk2Q35zMPUsC1RZ@Ansuel-XPS.>
Date: Wed, 23 Oct 2024 19:45:39 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 1/3] dt-bindings: net: dsa: Add Airoha
 AN8855 Gigabit Switch documentation
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-2-ansuelsmth@gmail.com>
 <5761bdc3-7224-4de6-b0f5-bedc066c09f6@lunn.ch>
 <67192f00.7b0a0220.343b2b.9836@mx.google.com>
 <77e99052-a14e-4495-9197-06d98257c590@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e99052-a14e-4495-9197-06d98257c590@lunn.ch>

On Wed, Oct 23, 2024 at 07:39:01PM +0200, Andrew Lunn wrote:
> > Well the first case that comes to mind is multiple switch and conflict.
> > I have no idea if there are hw strap to configure this so I assume if a
> > SoC have 2 switch (maybe of the same type), this permits to configure
> > them (with reset pin and deasserting them once the base address is
> > correctly configured)
> 
> Is this switch internal on an internal MDIO bus, or external?

External so it can be mounted on any SoC given correct mdio/mdc.

> 
> Most PHYs and switches i've seen have strapping pins to set the base
> address. It would be unusual if there was not strapping.

Same feeling, but I didn't found anything in the documentation.
(actually no mention of hw strap or pin)

> 
> For the Marvell switches, the strapping moves all the MDIO
> registers. This is why we have a reg at the top level in mv88e6xxx:
> 
>         ethernet-switch@0 {
>             compatible = "marvell,mv88e6085";
>             reg = <0>;
> 
> There is one family which use the values of 0 or 16, and each switch
> uses 16 addresses. So you can put two on the bus.
> 

Yes this is what that property does. Everything is shifted.

> > > > +  mdio:
> > > > +    $ref: /schemas/net/mdio.yaml#
> > > > +    unevaluatedProperties: false
> > > > +    description:
> > > > +      Define the relative address of the internal PHY for each port.
> > > > +
> > > > +      Each reg for the PHY is relative to the switch base PHY address.
> > > 
> > > Which is not the usual meaning of reg.
> > > 
> > > > +            mdio {
> > > > +                #address-cells = <1>;
> > > > +                #size-cells = <0>;
> > > > +
> > > > +                internal_phy0: phy@0 {
> > > > +                    reg = <0>;
> > > 
> > > So given that airoha,base_smi_address defaults to 1, this is actually
> > > address 1 on the MDIO bus?
> > >
> > 
> > Yes correct. One problem I had was that moving this outside the swich
> > cause panic as it does conflict with the switch PHY address...
> 
> I would make these addresses absolute, not relative. The example above
> from the marvell switch, the device using addresses 16-31 has its PHYs
> within that range, and we uses the absolute reg values.
>

They were relative with the base SMI implementation in mind (as we would
then offset) If the path is to drop that option then yes, these address
should be absolute.

Or do you think even with that option, these address should be absolute?

-- 
	Ansuel

