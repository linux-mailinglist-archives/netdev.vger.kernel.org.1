Return-Path: <netdev+bounces-245100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D42CC6DB3
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AC9300DC84
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF712741AB;
	Wed, 17 Dec 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfEDqmwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A41336ED1
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964492; cv=none; b=mj+ptaUp8QxQQ9p5YQcOrd4bOHnET2XPu2Oi35YOqYehdgyRG5Ng1c+gXS73MvTmIESQbw2zZINQav9wQsOCiPL1ciN4K3KB5hmFGvmrlffXnphLEFDtAklgfeU8WiURUmHu0VaI0mDyo9stMf/gxvPwYeof6YUaFRWLDHwfe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964492; c=relaxed/simple;
	bh=UfPR8sXjQvFQVn3UEw2jBBoIhOV9p47fsKzxifjrN7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWGJQYS8PAkYae7CDOMw5xcT9BDmWK5yErQ/ZjHcDjkz38bcOhJQq7tnapj+Tz0FZusK2SKPhAUe9IA33ecno20qabHjUW+zYunOaqO4XUreemUZub1RiM4jCj+HFiD+NYBBKQCL5YhDBq6EMp7lsDfWGDOuoVnAFHTaEYiKiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfEDqmwd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso42104995e9.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765964488; x=1766569288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBoBjU2LMTMgQSfb3xqPfF8gn8h20W2b3ycoHNyVdCI=;
        b=jfEDqmwdIcjQ64Xf5czDO6Ny2c4VhLniiNypTiNeBGxqyDtzM4P+XYF+Gdg2x+mzkB
         tcC7cQwuKQrRgyL6c7oXXtA53W1aPruQqE7YtmXiXW15qy1L0Sz3D4rdj64v4zQ+yQMy
         FQMYEe3KG9TEoWFw0BbhaE9Ilh7PWTufdqDkNKqEl42OwkcgrubRd7ilrZ9lt5ggtSik
         OsWf81Hy0bQ4bJ5tRPZ2aP3uP3B9LKLrZHskQGKkmAxb071JgkyUkhBLLYWGj9jOva8o
         Jx6FknoQh/a0Fw5KIMmYoCwzbF3625g00fWMCpdHDXNhx6r26wFQ6FwOFvJyRQip1UhL
         T5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765964488; x=1766569288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBoBjU2LMTMgQSfb3xqPfF8gn8h20W2b3ycoHNyVdCI=;
        b=F/teuhXjmQ4mfkjR4goj4bTSeHi+AQpLPGhh2OxH9qCW+1IhH+Xpmh8wCR2sHeatXx
         CwfM7Ua1k7W/kolWM97pdNd9Ngkchonhw+L/KarVAtfcd4XD0hZtxaGdtMSqsZt02xHW
         jrWyp0WNsfw8Q7IqpXXhaLNhMQZ/HPkax8e+kPYC2Vpbb0lBT+G2vhVsI/OZrsjxmH1v
         2sdcPlx5wBZK3ROhmDcDi7Xsy9GvFMO0sCqOSOajdKehwMHV1c4zUmlE1kJHVm6+MTTN
         nIRrqeECENF4B4YMHmi+2uM+G6/7Hq9l1WFt426zEjUwjwLlZ0xyX+SqNKcnUsx3u3vj
         YH+w==
X-Forwarded-Encrypted: i=1; AJvYcCV7uvfiAZwvwbnSdTLpnl/Y6Eo+sJogDeWbqkbFj4wHMFSFaClqiWEQfJrorNZhm9rt3up3l4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRe6gwIY8gdlYfbXh8FO2zBs+JYBor1Ytcovk1u83vQrMIFqda
	ZmutL+qzpl0PVU3nYklYBg8X0ksXbiNkQp0HPBcb5E1dD2xnxc9kKNWv
X-Gm-Gg: AY/fxX5/eAt0t+ahHcJ45Jzhlzf3IjHtZO7JNVxKUhUBYEFnGzoKRE78Z262WDu6ij7
	WwjBYws0mg5z1QAiEhMZ0HyOpax8Xx0S+NxP9yFwDsQ8x0qcFsfXDJoqMNppe4+Imzkgx6I4s+A
	RqSmh341WaBrk22UGXhIi6SdLDGynXh3M3Q5hCiso7xTZbIujetXxpuCRw8TShOY0pc8hoIxd4s
	t86CkXMasdPphnDYXU+9uycfEz44KvCFe0N9Z6PCOm+O89+xLJ5758K1z62xJ52IvwO25UoT1KH
	7cCQL3C4AIcGLPb/g7ROIi9zIYULK+MRZcZ+lMA9cr3Proxcpz+qFInLtNWSR+VQ9ipPx0hzmK2
	FxwKHJwrFuPMVnWk73tik8rm7S5sM4up0idL243YAYGp8oHByim0yqyBs4czYE4IyO+6nvq6z33
	ynbI8TMRv65StoewKdGeZLAw==
X-Google-Smtp-Source: AGHT+IH8nBpi5wzKXerCHtAsxfVaJL3L4HhGVMHkoq4zBcpDxu0gQYF6xOfn/+Sg+j6VTKnCfNKQqg==
X-Received: by 2002:a05:600c:34c4:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47a8f8c11b9mr155401455e9.13.1765964487554;
        Wed, 17 Dec 2025 01:41:27 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:b288:1a0e:e6f7:d63a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1e6ca3sm28652775e9.12.2025.12.17.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:41:26 -0800 (PST)
Date: Wed, 17 Dec 2025 10:41:25 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 1/3] dt-bindings: net: micrel: Convert to
 YAML schema
Message-ID: <aUJ6xUmL5uCLrB9n@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-2-eichest@gmail.com>
 <20251215143734.GA2381301-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215143734.GA2381301-robh@kernel.org>

Hi Rob,

Thanks a lot for the feedback.

On Mon, Dec 15, 2025 at 08:37:34AM -0600, Rob Herring wrote:
> On Fri, Dec 12, 2025 at 09:46:16AM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Convert the devicetree bindings for the Micrel PHY to YAML schema. This
> > also combines the information from micrel.txt and micrel-ksz90x1.txt
> > into a single micrel.yaml file as this PHYs are from the same series.
> > Use yaml conditions to differentiate the properties that only apply to
> 
> yaml conditions? You mean json-schema conditionals. I think the whole 
> sentence can be dropped though.
> 

Yes, exactly. I will remove that sentence from future versions.

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
> > deleted file mode 100644
> > index 6f7b907d5a044..0000000000000
> > --- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> > +++ /dev/null
> > @@ -1,228 +0,0 @@
> > -Micrel KSZ9021/KSZ9031/KSZ9131 Gigabit Ethernet PHY
> > -
> > -Some boards require special tuning values, particularly when it comes
> > -to clock delays. You can specify clock delay values in the PHY OF
> > -device node. Deprecated, but still supported, these properties can
> > -also be added to an Ethernet OF device node.
> > -
> > -Note that these settings are applied after any phy-specific fixup from
> > -phy_fixup_list (see phy_init_hw() from drivers/net/phy/phy_device.c),
> > -and therefore may overwrite them.
> > -
> > -KSZ9021:
> > -
> > -  All skew control options are specified in picoseconds. The minimum
> > -  value is 0, the maximum value is 3000, and it can be specified in 200ps
> > -  steps, *but* these values are in no way what you get because this chip's
> > -  skew values actually increase in 120ps steps, starting from -840ps. The
> > -  incorrect values came from an error in the original KSZ9021 datasheet
> > -  before it was corrected in revision 1.2 (Feb 2014), but it is too late to
> > -  change the driver now because of the many existing device trees that have
> > -  been created using values that go up in increments of 200.
> > -
> > -  The following table shows the actual skew delay you will get for each of the
> > -  possible devicetree values, and the number that will be programmed into the
> > -  corresponding pad skew register:
> > -
> > -  Device Tree Value	Delay	Pad Skew Register Value
> > -  -----------------------------------------------------
> > -	0   		-840ps		0000
> > -	200 		-720ps		0001
> > -	400 		-600ps		0010
> > -	600 		-480ps		0011
> > -	800 		-360ps		0100
> > -	1000		-240ps		0101
> > -	1200		-120ps		0110
> > -	1400		   0ps		0111
> > -	1600		 120ps		1000
> > -	1800		 240ps		1001
> > -	2000		 360ps		1010
> > -	2200		 480ps		1011
> > -	2400		 600ps		1100
> > -	2600		 720ps		1101
> > -	2800		 840ps		1110
> > -	3000		 960ps		1111
> > -
> > -  Optional properties:
> > -
> > -    - rxc-skew-ps : Skew control of RXC pad
> > -    - rxdv-skew-ps : Skew control of RX CTL pad
> > -    - txc-skew-ps : Skew control of TXC pad
> > -    - txen-skew-ps : Skew control of TX CTL pad
> > -    - rxd0-skew-ps : Skew control of RX data 0 pad
> > -    - rxd1-skew-ps : Skew control of RX data 1 pad
> > -    - rxd2-skew-ps : Skew control of RX data 2 pad
> > -    - rxd3-skew-ps : Skew control of RX data 3 pad
> > -    - txd0-skew-ps : Skew control of TX data 0 pad
> > -    - txd1-skew-ps : Skew control of TX data 1 pad
> > -    - txd2-skew-ps : Skew control of TX data 2 pad
> > -    - txd3-skew-ps : Skew control of TX data 3 pad
> > -
> > -KSZ9031:
> > -
> > -  All skew control options are specified in picoseconds. The minimum
> > -  value is 0, and the maximum is property-dependent. The increment
> > -  step is 60ps. The default value is the neutral setting, so setting
> > -  rxc-skew-ps=<0> actually results in -900 picoseconds adjustment.
> > -
> > -  The KSZ9031 hardware supports a range of skew values from negative to
> > -  positive, where the specific range is property dependent. All values
> > -  specified in the devicetree are offset by the minimum value so they
> > -  can be represented as positive integers in the devicetree since it's
> > -  difficult to represent a negative number in the devictree.
> > -
> > -  The following 5-bit values table apply to rxc-skew-ps and txc-skew-ps.
> > -
> > -  Pad Skew Value	Delay (ps)	Devicetree Value
> > -  ------------------------------------------------------
> > -  0_0000		-900ps		0
> > -  0_0001		-840ps		60
> > -  0_0010		-780ps		120
> > -  0_0011		-720ps		180
> > -  0_0100		-660ps		240
> > -  0_0101		-600ps		300
> > -  0_0110		-540ps		360
> > -  0_0111		-480ps		420
> > -  0_1000		-420ps		480
> > -  0_1001		-360ps		540
> > -  0_1010		-300ps		600
> > -  0_1011		-240ps		660
> > -  0_1100		-180ps		720
> > -  0_1101		-120ps		780
> > -  0_1110		-60ps		840
> > -  0_1111		0ps		900
> > -  1_0000		60ps		960
> > -  1_0001		120ps		1020
> > -  1_0010		180ps		1080
> > -  1_0011		240ps		1140
> > -  1_0100		300ps		1200
> > -  1_0101		360ps		1260
> > -  1_0110		420ps		1320
> > -  1_0111		480ps		1380
> > -  1_1000		540ps		1440
> > -  1_1001		600ps		1500
> > -  1_1010		660ps		1560
> > -  1_1011		720ps		1620
> > -  1_1100		780ps		1680
> > -  1_1101		840ps		1740
> > -  1_1110		900ps		1800
> > -  1_1111		960ps		1860
> > -
> > -  The following 4-bit values table apply to the txdX-skew-ps, rxdX-skew-ps
> > -  data pads, and the rxdv-skew-ps, txen-skew-ps control pads.
> > -
> > -  Pad Skew Value	Delay (ps)	Devicetree Value
> > -  ------------------------------------------------------
> > -  0000			-420ps		0
> > -  0001			-360ps		60
> > -  0010			-300ps		120
> > -  0011			-240ps		180
> > -  0100			-180ps		240
> > -  0101			-120ps		300
> > -  0110			-60ps		360
> > -  0111			0ps		420
> > -  1000			60ps		480
> > -  1001			120ps		540
> > -  1010			180ps		600
> > -  1011			240ps		660
> > -  1100			300ps		720
> > -  1101			360ps		780
> > -  1110			420ps		840
> > -  1111			480ps		900
> > -
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
> > -
> > -KSZ9131:
> > -LAN8841:
> > -
> > -  All skew control options are specified in picoseconds. The increment
> > -  step is 100ps. Unlike KSZ9031, the values represent picoseccond delays.
> > -  A negative value can be assigned as rxc-skew-psec = <(-100)>;.
> > -
> > -  Optional properties:
> > -
> > -    Range of the value -700 to 2400, default value 0:
> > -
> > -      - rxc-skew-psec : Skew control of RX clock pad
> > -      - txc-skew-psec : Skew control of TX clock pad
> > -
> > -    Range of the value -700 to 800, default value 0:
> > -
> > -      - rxdv-skew-psec : Skew control of RX CTL pad
> > -      - txen-skew-psec : Skew control of TX CTL pad
> > -      - rxd0-skew-psec : Skew control of RX data 0 pad
> > -      - rxd1-skew-psec : Skew control of RX data 1 pad
> > -      - rxd2-skew-psec : Skew control of RX data 2 pad
> > -      - rxd3-skew-psec : Skew control of RX data 3 pad
> > -      - txd0-skew-psec : Skew control of TX data 0 pad
> > -      - txd1-skew-psec : Skew control of TX data 1 pad
> > -      - txd2-skew-psec : Skew control of TX data 2 pad
> > -      - txd3-skew-psec : Skew control of TX data 3 pad
> > -
> > -Examples:
> > -
> > -	/* Attach to an Ethernet device with autodetected PHY */
> > -	&enet {
> > -		rxc-skew-ps = <1800>;
> > -		rxdv-skew-ps = <0>;
> > -		txc-skew-ps = <1800>;
> > -		txen-skew-ps = <0>;
> > -		status = "okay";
> > -	};
> > -
> > -	/* Attach to an explicitly-specified PHY */
> > -	mdio {
> > -		phy0: ethernet-phy@0 {
> > -			rxc-skew-ps = <1800>;
> > -			rxdv-skew-ps = <0>;
> > -			txc-skew-ps = <1800>;
> > -			txen-skew-ps = <0>;
> > -			reg = <0>;
> > -		};
> > -	};
> > -	ethernet@70000 {
> > -		phy = <&phy0>;
> > -		phy-mode = "rgmii-id";
> > -	};
> > -
> > -References
> > -
> > -  Micrel ksz9021rl/rn Data Sheet, Revision 1.2. Dated 2/13/2014.
> > -  http://www.micrel.com/_PDF/Ethernet/datasheets/ksz9021rl-rn_ds.pdf
> > -
> > -  Micrel ksz9031rnx Data Sheet, Revision 2.1. Dated 11/20/2014.
> > -  http://www.micrel.com/_PDF/Ethernet/datasheets/KSZ9031RNX.pdf
> > -
> > -Notes:
> > -
> > -  Note that a previous version of the Micrel ksz9021rl/rn Data Sheet
> > -  was missing extended register 106 (transmit data pad skews), and
> > -  incorrectly specified the ps per step as 200ps/step instead of
> > -  120ps/step. The latest update to this document reflects the latest
> > -  revision of the Micrel specification even though usage in the kernel
> > -  still reflects that incorrect document.
> > diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> > deleted file mode 100644
> > index 01622ce58112e..0000000000000
> > --- a/Documentation/devicetree/bindings/net/micrel.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -Micrel PHY properties.
> > -
> > -These properties cover the base properties Micrel PHYs.
> > -
> > -Optional properties:
> > -
> > - - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
> > -
> > -	Configure the LED mode with single value. The list of PHYs and the
> > -	bits that are currently supported:
> > -
> > -	KSZ8001: register 0x1e, bits 15..14
> > -	KSZ8041: register 0x1e, bits 15..14
> > -	KSZ8021: register 0x1f, bits 5..4
> > -	KSZ8031: register 0x1f, bits 5..4
> > -	KSZ8051: register 0x1f, bits 5..4
> > -	KSZ8081: register 0x1f, bits 5..4
> > -	KSZ8091: register 0x1f, bits 5..4
> > -	LAN8814: register EP5.0, bit 6
> > -
> > -	See the respective PHY datasheet for the mode values.
> > -
> > - - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
> > -						bit selects 25 MHz mode
> > -
> > -	Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > -	than 50 MHz clock mode.
> > -
> > -	Note that this option is only needed for certain PHY revisions with a
> > -	non-standard, inverted function of this configuration bit.
> > -	Specifically, a clock reference ("rmii-ref" below) is always needed to
> > -	actually select a mode.
> > -
> > - - clocks, clock-names: contains clocks according to the common clock bindings.
> > -
> > -	supported clocks:
> > -	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
> > -	  input clock. Used to determine the XI input clock.
> > -
> > - - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
> > -
> > -	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
> > -	by the FXEN boot strapping pin. It can't be determined from the PHY
> > -	registers whether the PHY is in fiber mode, so this boolean device tree
> > -	property can be used to describe it.
> > -
> > -	In fiber mode, auto-negotiation is disabled and the PHY can only work in
> > -	100base-fx (full and half duplex) modes.
> > -
> > - - coma-mode-gpios: If present the given gpio will be deasserted when the
> > -		    PHY is probed.
> > -
> > -	Some PHYs have a COMA mode input pin which puts the PHY into
> > -	isolate and power-down mode. On some boards this input is connected
> > -	to a GPIO of the SoC.
> > -
> > -	Supported on the LAN8814.
> > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > new file mode 100644
> > index 0000000000000..f48e9b9120ca0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > @@ -0,0 +1,527 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/micrel.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Micrel KSZ series PHYs and switches
> > +
> > +maintainers:
> > +  - Andrew Lunn <andrew@lunn.ch>
> > +  - Stefan Eichenberger <eichest@gmail.com>
> > +
> > +description: |
> > +  The Micrel KSZ series contains different network phys and switches.
> > +
> > +  Some boards require special tuning values, particularly when it comes to
> > +  clock delays. You can specify clock delay values in the PHY OF device node.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ethernet-phy-id000e.7237 # KSZ8873MLL
> > +      - ethernet-phy-id0022.1430 # KSZ886X
> > +      - ethernet-phy-id0022.1435 # KSZ8863
> > +      - ethernet-phy-id0022.1510 # KSZ8041
> > +      - ethernet-phy-id0022.1537 # KSZ8041RNLI
> > +      - ethernet-phy-id0022.1550 # KSZ8051
> > +      - ethernet-phy-id0022.1555 # KSZ8021
> > +      - ethernet-phy-id0022.1556 # KSZ8031
> > +      - ethernet-phy-id0022.1560 # KSZ8081, KSZ8091
> > +      - ethernet-phy-id0022.1570 # KSZ8061
> > +      - ethernet-phy-id0022.1610 # KSZ9021
> > +      - ethernet-phy-id0022.1611 # KSZ9021RLRN
> > +      - ethernet-phy-id0022.161a # KSZ8001
> > +      - ethernet-phy-id0022.1620 # KSZ9031
> > +      - ethernet-phy-id0022.1631 # KSZ9477
> > +      - ethernet-phy-id0022.1640 # KSZ9131
> > +      - ethernet-phy-id0022.1650 # LAN8841
> > +      - ethernet-phy-id0022.1660 # LAN8814
> > +      - ethernet-phy-id0022.1670 # LAN8804
> > +      - ethernet-phy-id0022.1720 # KS8737
> > +
> > +allOf:
> > +  - $ref: ethernet-phy.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ethernet-phy-id0022.1510
> > +    then:
> > +      properties:
> > +        micrel,fiber-mode:
> > +          type: boolean
> > +          description: |
> > +            If present the PHY is configured to operate in fiber mode.
> > +
> > +            The KSZ8041FTL variant, supports fiber mode, enabled by the FXEN
> > +            boot strapping pin. It can't be determined from the PHY registers
> > +            whether the PHY is in fiber mode, so this boolean device tree
> > +            property can be used to describe it.
> > +
> > +            In fiber mode, auto-negotiation is disabled and the PHY can only work in
> 
> Wrap at 80.
> 

Thanks, I will fix that.

> > +            100base-fx (full and half duplex) modes.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ethernet-phy-id0022.1555
> > +              - ethernet-phy-id0022.1556
> > +              - ethernet-phy-id0022.1560
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          const: rmii-ref
> > +          description: |
> > +            supported clocks:
> > +              - The RMII reference input clock. Used to determine the XI
> > +                input clock.
> > +        micrel,rmii-reference-clock-select-25-mhz:
> > +          type: boolean
> > +          description: |
> > +            RMII Reference Clock Select bit selects 25 MHz mode
> > +
> > +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > +            than 50 MHz clock mode.
> > +
> > +            Note that this option in only needed for certain PHY revisions with a
> > +            non-standard, inverted function of this configuration bit.
> > +            Specifically, a clock reference ("rmii-ref") is always needed to
> > +            actually select a mode.
> 
> Sounds like a dependency:
> 
> dependentRequired:
>   micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
> 

Thanks, I will add that.

> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ethernet-phy-id0022.1660
> > +    then:
> > +      properties:
> > +        coma-mode-gpios:
> > +          maxItems: 1
> > +          description: |
> > +            If present the given gpio will be deasserted when the PHY is probed.
> > +
> > +            Some PHYs have a COMA mode input pin which puts the PHY into
> > +            isolate and power-down mode. On some boards this input is connected
> > +            to a GPIO of the SoC.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ethernet-phy-id0022.1510
> > +              - ethernet-phy-id0022.1555
> > +              - ethernet-phy-id0022.1556
> > +              - ethernet-phy-id0022.1550
> > +              - ethernet-phy-id0022.1560
> > +              - ethernet-phy-id0022.161a
> > +              - ethernet-phy-id0022.1660
> > +    then:
> > +      properties:
> > +        micrel,led-mode:
> > +          description: |
> > +            LED mode value to set for PHYs with configurable LEDs.
> > +
> > +            Configure the LED mode with single value. The list of PHYs and the
> > +            bits that are currently supported:
> > +
> > +            KSZ8001: register 0x1e, bits 15..14
> > +            KSZ8041: register 0x1e, bits 15..14
> > +            KSZ8021: register 0x1f, bits 5..4
> > +            KSZ8031: register 0x1f, bits 5..4
> > +            KSZ8051: register 0x1f, bits 5..4
> > +            KSZ8081: register 0x1f, bits 5..4
> > +            KSZ8091: register 0x1f, bits 5..4
> > +            LAN8814: register EP5.0, bit 6
> > +
> > +            See the respective PHY datasheet for the mode values.
> > +          minimum: 0
> > +          maximum: 3
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ethernet-phy-id0022.1620
> > +    then:
> > +      properties:
> > +        enable-edpd:
> > +          type: boolean
> > +          description:
> > +            Enable Energy Detect Power Down mode. Reduces power consumption when the
> > +            link is down.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ethernet-phy-id0022.1555
> > +              - ethernet-phy-id0022.1556
> > +              - ethernet-phy-id0022.1560
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          const: rmii-ref
> > +          description: |
> > +            supported clocks:
> > +              - The RMII reference input clock. Used to determine the XI
> > +                input clock.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ethernet-phy-id0022.1610
> > +              - ethernet-phy-id0022.1611
> > +    then:
> > +      properties:
> > +        rxc-skew-ps:
> > +          description: |
> > +            Skew control of RXC pad (picoseconds). A value of 0 equals to a
> > +            skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txc-skew-ps:
> > +          description: |
> > +            Skew control of TXC pad (picoseconds). A value of 0 equals to a
> > +            skew of -840ps. Increments of 200ps are allowed.
> 
> multipleOf: 200

I will add that to all relevant entries.

> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        rxdv-skew-ps:
> > +          description: |
> > +            Skew control of RX CTL pad (picoseconds). A value of 0 equals to a
> > +            skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txen-skew-ps:
> > +          description: |
> > +            Skew control of TX CTL pad (picoseconds). A value of 0 equals to a
> > +            skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        rxd0-skew-ps:
> > +          description: |
> > +            Skew control of RX data 0 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        rxd1-skew-ps:
> > +          description: |
> > +            Skew control of RX data 1 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        rxd2-skew-ps:
> > +          description: |
> > +            Skew control of RX data 2 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        rxd3-skew-ps:
> > +          description: |
> > +            Skew control of RX data 3 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txd0-skew-ps:
> > +          description: |
> > +            Skew control of TX data 0 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txd1-skew-ps:
> > +          description: |
> > +            Skew control of TX data 1 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txd2-skew-ps:
> > +          description: |
> > +            Skew control of TX data 2 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> > +        txd3-skew-ps:
> > +          description: |
> > +            Skew control of TX data 3 pad (picoseconds). A value of 0 equals to
> > +            a skew of -840ps. Increments of 200ps are allowed.
> > +
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> > +          minimum: 0
> > +          maximum: 3000
> > +          default: 1400
> 
> Since it is the same constraints, you can shorten all these with a 
> pattern:
> 
> patternProperties:
>   '^([rt]xd[0-3]|[rt]xc|rxdv|txen)-skew-ps$':
> 

Thanks, I will do that.

> > +    else:
> > +      if:
> 
> Avoid nested if/then schemas if possible. Doesn't look like it is 
> necessary here.

Yes you are right, it is not necessary.

> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: ethernet-phy-id0022.1620
> > +      then:
> > +        properties:
> > +          rxc-skew-ps:
> > +            description: |
> > +              Skew control of RXC pad (picoseconds). A value of 0 equals to a skew
> > +              of -900ps. Increments of 60ps are allowed.
> 
> multipleOf: 60
> 

I will add that for all relevant entries.

> > +            minimum: 0
> > +            maximum: 1860
> > +            default: 900
> > +          txc-skew-ps:
> > +            description: |
> > +              Skew control of TXC pad (picoseconds). A value of 0 equals to a skew
> > +              of -900ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 1860
> > +            default: 900
> > +          rxdv-skew-ps:
> > +            description: |
> > +              Skew control of RX CTL pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          txen-skew-ps:
> > +            description: |
> > +              Skew control of TX CTL pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          rxd0-skew-ps:
> > +            description: |
> > +              Skew control of RX data 0 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          rxd1-skew-ps:
> > +            description: |
> > +              Skew control of RX data 1 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          rxd2-skew-ps:
> > +            description: |
> > +              Skew control of RX data 2 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          rxd3-skew-ps:
> > +            description: |
> > +              Skew control of RX data 3 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          txd0-skew-ps:
> > +            description: |
> > +              Skew control of TX data 0 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          txd1-skew-ps:
> > +            description: |
> > +              Skew control of TX data 1 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          txd2-skew-ps:
> > +            description: |
> > +              Skew control of TX data 2 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +          txd3-skew-ps:
> > +            description: |
> > +              Skew control of TX data 3 pad (picoseconds). A value of 0 equals to a
> > +              skew of -420ps. Increments of 60ps are allowed.
> > +            minimum: 0
> > +            maximum: 900
> > +            default: 420
> > +      else:
> > +        if:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                enum:
> > +                  - ethernet-phy-id0022.1640
> > +                  - ethernet-phy-id0022.1660
> > +        then:
> > +          properties:
> > +            rxc-skew-psec:
> 
> These are not a standard unit-suffix, so they need a type $ref. That 
> should be a warning, but probably isn't since these are underneeth an 
> if/then schema.
> 

The problem is that I get this error when I try to set the ref. That's
also why I added the additonal example. I think they disappear if I
would set the properties at the top level though as suggested by you.

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/micrel.yaml
make[1]: Entering directory '...'
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ../Documentation/devicetree/bindings
  LINT    ../Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/micrel.example.dts
  DTC [C] Documentation/devicetree/bindings/net/micrel.example.dtb
Documentation/devicetree/bindings/net/micrel.example.dtb: ethernet-phy@9 (ethernet-phy-id0022.1640): rxc-skew-psec: [4294967196] is not of type 'integer'
        from schema $id: http://devicetree.org/schemas/net/micrel.yaml
Documentation/devicetree/bindings/net/micrel.example.dtb: ethernet-phy@9 (ethernet-phy-id0022.1640): Unevaluated properties are not allowed ('rxc-skew-psec', 'txc-skew-psec' were unexpected)
        from schema $id: http://devicetree.org/schemas/net/micrel.yaml

> In general, the rule is don't define properties in if/then schemas. 
> Define them at the top level and then disallow them in if/then schemas 
> for specific compatibles. There's also a judgement call of when to split 
> bindings to separate files based on how long the if/then schemas are 
> compared to the top-level. I think this is well past that though using 
> patternProperties helps a lot. I think at least the 1640 and 1660 should 
> be split given the custom skew props.

I think for most properties it should be doable to define them at the
top level and disallow them for all other compatibles. However, I was
struggling with the -ps properties, because they have different
constratints and descriptions based on the compatible. I will see what I
can do there.

I will also try to split the micrel.yaml again into multiple files in
the next version.

Regards,
Stefan

