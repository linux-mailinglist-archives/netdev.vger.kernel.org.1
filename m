Return-Path: <netdev+bounces-251058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5ADD3A7B9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2C8730049FB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69318358D3B;
	Mon, 19 Jan 2026 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhw7hgNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4396314A62
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824215; cv=none; b=JF4SfJL0DER9in919f8jq0dd8xuWAmL/+ik3r+hmhRWerUdOl9DEQSOHpHd+DQrQhHXxE7FO9rAto/eNAUyKCaJfkpjI9vfVo0EAoanw0zn7tlBRSy87qoeDSeh8DZ7jpJS8LdC3tBEURiz4AUws/RUwklAMSXzVNylSzBjN0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824215; c=relaxed/simple;
	bh=8I29BCfIKiLgtdEVGUIyfgW5ObtzvtJM9btdY9aaQXE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tspNc4f8MXY9nxSg1qVPdQj3P90QILNEMq3pJ4tsXt17A7w9VwmBn+losO0GznfAAf5Xrq/TgjVrdIBzFtHIf843WTEB9DCzMMiBpJTyiGpSdQ3+s3AqdvtrzRyRdZbWXc95ac+COlsLxTqJ13StRUl9yzjQa4KDH0IMmG5a3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhw7hgNP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so20333555e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768824212; x=1769429012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzaz1i9qc6G7xsP+1FC5njEiUedEPzYKnb9i6e2a56w=;
        b=Dhw7hgNPaDHaDD1COvglU9JeUdScoVHUI72cio5sxGyByUXJTHoDLt7hQtJpLTjiZ+
         B7eYt4vPaNBsB0d9M5+eE7x5Rdj9hnsXIYDQW2PSg3ivYMYUE/0aHtHGWiKCwXbD4I9+
         pOezuh3tG+jhBLXtlg3jXOOqju7zW0ayu3bSSHGm52gDOuy/kT78SUjcsm+jCRpCF/ja
         AcFcgJSufA5HSybR3hLgGTDPEQOFmQlxukFFYdhB7RHtzLqltZV88KRflVEqPTOVVM9I
         IlSmhTMKUDELsH1Wjc1tJPIygYGrUh1kEY2Qg6EnSsBQVlQWazOd9bN1iuS5l5E31E+t
         U1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824212; x=1769429012;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzaz1i9qc6G7xsP+1FC5njEiUedEPzYKnb9i6e2a56w=;
        b=T9LVoArlssNei6j2E8btn1AKFZLElb8m0kz9KzP8K7Uf9TiW+UmQHftJva6b1EPmeK
         Ju82DgBnuXeCNhqm0A9DUf61EMzQOaIsNo3lhj5xEL2rT6Q9lAd3z4477rt1so6bt3nO
         +W8LZvIFt8O0B83j8wDyPXV+P5aGPA7r0N70Y7kLrhNexaA+AjKtvFnGTY/22qwwccZ7
         zQ287HMDP74DzNql7hxAc1Y1djmjXJd86SWOH0oNypRjoWxXB1olVwViwXUIiI2y4wOY
         a+YqqXaj0vxnrk6hc7gNkAKsWSNrHizr581ibc+NB4hGW6XLd8k43P28ZnyqajmgtFIU
         zueQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCC0PPvvUMQSGXXlFpjDAUEu/yNtYXnDj0N49ayF7hZh6qD6rQ/wYRSsKOI2rvrujPwwDMQwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8ET+6/09zkx0icYsQ17x3hE0xdgt0H2l1ZrsUGZaez4U4xkM
	GFsU49v2yESmrbZt7FnSyM+A8qr1dIxkVTatOJ0Uv9Pmafvopw0bfx2l
X-Gm-Gg: AY/fxX7Kgr+Yrkbj7eFKVVcdlSFzqnSp00uvK8ShUypZUf8zPsarsaAwAieZQ1ofJB2
	biuq0cpueoY1MVBfZBxzwQeuNauSZoZTYJDPfvC1U9qBk3di4wKwlTDxZnSxL3KNkS+SY1XP11e
	vbtjVA6d/jVhh+ZiTRdbzFfa9OL+vROxW7t/GwiTZTCD7vqWsANY6IWS20GyP2jB+sxc493phbP
	vaHyBEMxPiIzu9VX0DtrmK/djC8R6VryD7rVVkhAJPEZe03xCmfBA6shaYrU/siW5ya62rVz4yZ
	uxzJ+br984CUNPlCr5jXosNobM5eKAJWyaNIbqqCXJ9ls7/qHdluZXCGnmxR+ALRHH3fCfG2BhX
	sn+NeGcIQ2+igwGMBgOYcgwrBmboALoDTu3+xst2xGKt+kvW1LYvJm9d5+eSFsOR2lS1f9Sunvh
	XlKFbG77vSbPkbwDY1vS9Kyot5sH1SQGG/F3nEezg=
X-Received: by 2002:a05:600c:1f12:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4801e2fc37bmr117353555e9.3.1768824211594;
        Mon, 19 Jan 2026 04:03:31 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe3b01csm83250955e9.5.2026.01.19.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:03:31 -0800 (PST)
Message-ID: <696e1d93.050a0220.7cbaa.5b25@mx.google.com>
X-Google-Original-Message-ID: <aW4dkcDb8LikqH-y@Ansuel-XPS.>
Date: Mon, 19 Jan 2026 13:03:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
References: <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
 <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch>
 <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk>
 <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
 <aW4QixwAJHaHWBBc@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW4QixwAJHaHWBBc@lore-desk>

On Mon, Jan 19, 2026 at 12:07:55PM +0100, Lorenzo Bianconi wrote:
> > > Airoha folks reported the NPU hw can't provide the PCIe Vendor/Device ID info
> > > of the connected WiFi chip.
> > > I guess we have the following options here:
> > > - Rely on the firmware-name property as proposed in v1
> > > - Access the PCIe bus from the NPU driver during probe in order to enumerate
> > >   the PCIe devices and verify WiFi chip PCIe Vendor/Device ID
> > > - During mt76 probe trigger the NPU fw reload if required. This approach would
> > >   require adding a new callback in airoha_npu ops struct (please note I have
> > >   not tested this approach and I not sure this is really doable).
> > 
> > What i'm wondering about is if the PCIe slots are hard coded in the
> > firmware.  If somebody builds a board using different slots, they
> > would then have different firmware? Or if they used the same slots,
> > but swapped around the Ethernet and the WiFi, would it need different
> > firmware?
> 
> As pointed out by Benjamin, the NPU is a generic Risc-V cpu cluster and it is
> used to move packets from/to ethernet DMA rings to/from WiFi DMA rings without
> involving the host cpu (similar to what we have for MTK with WED module).
> I think the PCIe slot info is not necessary for the NPU to work since it is
> configured by ethernet (airoha-eth) and wireless drivers (mt76) with DMA ring
> addresses to use via the airoha npu ops APIs, NPU just moves data between the
> DMA rings according to my understanding.
> 
> > 
> > So is the firmware name a property of the board?
> 
> We need to run different binaries on the NPU based on the MT76 WiFi chip
> available on the board since the MT76 DMA rings layout changes between MT76 SoC
> revisions (e.g. Egle MT7996 vs Kite MT7992). In this sense, I agree, the
> firmware name is a board property.
> 
> > 
> > If the PCIe slots are actually hard coded in the NPU silicon, cannot
> > be changed, then we might have a different solution, the firmware name
> > might be placed into a .dtsi file, or even hard coded in the driver?
> 
> IIUC what you mean here, it seems the solution I proposed in v1 (using
> firmware-name property), right?
> In this case we can't hard code the firmware name in the NPU driver since
> we can't understand the MT76 WiFi chip revision running on the board at
> the moment (MT76 would need to provide this info during MT76 probe,
> please take a look to the option 3 in my previous email).
> 
> > 
> > > What do you think? Which one do you prefer?
> > 
> > I prefer to try to extract more information for the Airoha folks. What
> > actually defines the firmware? Does the slots used matter? Does it
> > matter what device goes in what slots? Is it all hard coded in
> > silicon? Is there only one true hardware design and if you do anything
> > else your board design is FUBAR, never to be supported?
> 
> I think the firmware is defined by the board hw configuration (e.g. MT76
> SoC revision) and not by the specific PCIe slot used.
> I do not think we have these info hardcoded in the silicon since NPU is a
> generic RiscV cpu (this has been confirmed by airoha folks).
> 

Just to make sure everything is clear and talking on this in very
simple words, there isn't anything ""hardcoded"" or strange.

For """""""reasons""""""" (I assume space constraints or NPU CPU
limitation) it's not possible to have a single NPU firmware to support
both WiFi card.

The NPU do simple task like configuring WED registers and handling DMA
descriptor/some WiFi offload. Such configuration is specific to the WiFi
card and it's not the same between MT7996 and MT7992.

This is why specific firmware is needed. The specific NPU firmware have
support for only ONE of the 2 WiFi card and doesn't support configuring
and handling stuff for the other. (the code is not built in the
firmware)

From the kernel side (in the MT76 code) we just instruct the NPU to
start offloading stuff (if present) and all the SoC feature for WiFi
offload are used. (WED, special DMA path, ...)

The possible combination that NPU can be used currently are the
following:
- Ethernet offload (all NPU firmware)
- Ethernet offload + WiFi MT7996 (NPU firmware with MT7996 support)
- Ethernet offload + WiFi MT7992 (NPU firmware with MT7992 support)

The NPU makes use of feature already present in the SoC and makes use of
reserved space in RAM for DMA handling so it really don't care of where
the WiFi card is present (this is what I mean with nothing is hardcoded)

I hope we are not getting annoying with insisting on the firmware-names
solution.

My personal taste on this is that hardcoding the name in the driver
seems a bit wrong and creating a way to dynamically select the firmware
based on what is present in the hardware would be great but would
introduce LOTS of COMPLEXITY for WiFi router that ship with a single
WiFi card and would have their own dedicated .dts

To make this generic enough an idea might be to have simple .dtsi with
prefilled firmware names.

- en7581-npu-mt7992.dtsi
- en7581-npu-mt7996.dtsi

But they would only contain a single node with a single string.

Hope this more practical explaination clears any doubt of the
implementation.

-- 
	Ansuel

