Return-Path: <netdev+bounces-161563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303EDA22583
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 22:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF6318862C5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CC1B040B;
	Wed, 29 Jan 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM0JBiq+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDC42A92;
	Wed, 29 Jan 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185153; cv=none; b=DD5Hb/95MFi7rXeUG33ZmDj/IJgrYgdKtJq+D5Qzo89vgu92pczBQCiOH0Ci9zbFyL4O1C/3g7wCEU9X9NHSzbKd2Ng8iHWw/GdjzSE7KHG8XGOZLd5BVPWPJXqZythLwAoDe+rquENFan4EHqLQk7rT86GOEBidNv46GDjF7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185153; c=relaxed/simple;
	bh=6LEF1AJkMH84I3vu+wLhFX2M7JerwMzZ3UrjAOucTyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moe5uJ91cRaDxUwc6al9maRIj+8ti8ybHnnGqE8CgfOiX0srF+P/eG6+UIRUkgs/ZJmfwIT5l27D4fGxoRPC8yqhzNx1ZS1IMr3EKOK5EAZNZUMnPBCrwBUMmWGAJmYs3K3SgSIZlS71lTMakRHDfrGEgM7YEve3MhNNNG/0Ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM0JBiq+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab6df743d26so2755566b.3;
        Wed, 29 Jan 2025 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738185150; x=1738789950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JE1nji90g/s5o2npQar0odXWKrHsJ65cuCr1cQINzO8=;
        b=nM0JBiq+DT20vY4SwJNcMHA7/Tam7z97tjMYKN40TBznbK9p+AfPvnhRg9gzGI43YM
         wuVDAjocOA0O+DB2JG8pDSnaf0xm9BAlxWq6jJ/vw01jGObIxrjJHkhWMBYOQEZ4a/6/
         4DI6CUF7GzQdf649vqJGm8Tp3MOu6hwEwVnRb8GKBjbNUJiJaZghxELecqTk+Uecj5d/
         Nt+nznfVDXt1MXcGHTn6k1vSzNFnploOoiPkJ3XFE4waiex6tD5WtaTHUPEp8KhhsEub
         G7DRXTxcrRfXEBB5tWUyantM6sd5DNofOgibw/nrZwSigjFbyxMOrkgiepcHHBL4idQ8
         HKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738185150; x=1738789950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE1nji90g/s5o2npQar0odXWKrHsJ65cuCr1cQINzO8=;
        b=iiirttH0dxbyWqyOEHsB/r+2hWSLzsU0Y/j9/aDhxJuMMnmZz48Qg8mzng7G39LV8B
         rdWYZEPC4AItivGVRD5fxENo7/m3GFfDzKszWqsfUlPCdY/n3LRyaWwVR9emL8Z3NDnn
         PAt6jd2fnpKol3jU773OYvqdtlASoLJJKDYU0MuTjcSIRXBXixI+fbMUNQGLwk3M2nzE
         KQOU2gCiBaA2BlWr/JgrH3mofn3gsLcT4rpyCAY2qEA2b/0xi3ueXFbLo5kNrHMzNfaR
         3nvinvvSsTqTDseu7Ny25Op8HALfHqZDC7FNmJE1qu7oyq8xyvnqk17pD9sI1qlT4s0f
         /J1A==
X-Forwarded-Encrypted: i=1; AJvYcCUSyaQsNcFQylyFX4cLRyTf7qQL2ZerkYOT/2WjLZR6nhyT80aucfcZGFAgn/y50YY3i1ah7NFRzZJ4SSA=@vger.kernel.org, AJvYcCX/Qes1e7h9YN0unXL9EpraGVnyiBhOq/icnsNVbCY7LeRWLIDENGAuhv8gLWL5ZiFSmbZXMzF7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9Y1eFgX6ZbDop43OtJZcdsD2qL4gqwGyOv1ufD0nQfNg2hqP
	4+AQoL5FrdgHzOplgUlWwICAqMBuM6xBuSo1PWrcPCwZc0bXZ6UV
X-Gm-Gg: ASbGncv6n7RzIkrxe55bT1JZdtnSroZzy95PciMWoWoKfpNAoawquFemHgl74gyD5IM
	ukBpHDzHm1ZyExNtY8jY9xZqW47Yt66hyHGPRLkIHe8lQVPnFF8xuX/HpyRyr55DiE+qgMxB8Gn
	zqSl+x12rNmmAXgUCGa0hGptqYzo731s2an9y0VWtdhtVUyabaqKS2fetHSLrZQsivsW7G20kZU
	8dUXxuNEhcx2MP+ogDlMewFiXCUHtiGNtNgHsEVFVGnk++UOHDGNqOSDR+IoLdvTDVw7OhEtz6f
	NNY=
X-Google-Smtp-Source: AGHT+IFXzKw5W98kSHx4Iqifsc/6ltBA/tjtJTm40yUb1ux3L97N3gskzNSfHKOXy2tR6pmnqJPzCw==
X-Received: by 2002:a17:907:8693:b0:ab6:dd24:3342 with SMTP id a640c23a62f3a-ab6dd243b72mr73836866b.8.1738185149713;
        Wed, 29 Jan 2025 13:12:29 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cfb98sm1632066b.61.2025.01.29.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:12:29 -0800 (PST)
Date: Wed, 29 Jan 2025 23:12:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250129211226.cfrhv4nn3jomooxc@skbuf>
References: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>

On Wed, Jan 29, 2025 at 12:31:09AM +0000, Tristram.Ha@microchip.com wrote:
> The default value of DW_VR_MII_AN_CTRL is DW_VR_MII_PCS_MODE_C37_SGMII
> (0x04).  When a SGMII SFP is used the SGMII port works without any
> programming.  So for example network communication can be done in U-Boot
> through the SGMII port.  When a 1000BaseX SFP is used that register needs
> to be programmed (DW_VR_MII_SGMII_LINK_STS |
> DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII | DW_VR_MII_PCS_MODE_C37_1000BASEX)
> (0x18) for it to work.

Can it be that DW_VR_MII_PCS_MODE_C37_1000BASEX is the important setting
when writing 0x18, and the rest is just irrelevant and bogus? If not,
could you please explain what is the role of DW_VR_MII_SGMII_LINK_STS |
DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII for 1000Base-X? The XPCS data book
does not suggest they would be considered for 1000Base-X operation. Are
you suggesting for KSZ9477 that is different? If so, please back that
statement up.

> (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII has to be used together with
> DW_VR_MII_TX_CONFIG_MASK to mean 0x08.  Likewise for
> DW_VR_MII_PCS_MODE_C37_SGMII and DW_VR_MII_PCS_MODE_MASK to mean 0x04.
> It is a little difficult to just use those names to indicate the actual
> value.)
> 
> DW_VR_MII_DIG_CTRL1 is never touched.  DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW
> does not exist in KSZ9477 implementation.  As setting that bit does not
> have any effect I did not do anything about it.

Never touched by whom? xpcs_config_aneg_c37_sgmii() surely tries to
touch it... Don't you think that the absence of this bit from the
KSZ9477 implementation might have something to do with KSZ9477's unique
need to force the link speed when in in-band mode?

Here's a paragraph about this from the data book:

DWC_xpcs supports automatic reconfiguration of SGMII speed/duplex mode
based on the outcome of auto-negotiation. This feature can be enabled by
programming bit[9] (MAC_AUTO_SW) of VR_MII_DIG_CTRL1 when operating in
SGMII MAC mode. DWC_xpcs is initially configured in the speed/duplex
mode as programmed in the SR_MII_CTRL. If MAC_AUTO_SW bit is enabled,
DWC_xpcs automatically switches to the negotiated speed mode after the
completion of CL37 Auto-negotiation. This eliminates the software
overhead of reading CL37 AN SGMII Status from VR_MII_AN_INTR_STS and
then programming SS13 and SS6 speed-selection bits of SR_MII_CTRL
appropriately.

> It does have the intended effect of separating SGMII and 1000BaseX modes
> in later versions.  And DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is used along
> with it.  They are mutually exclusive.  For SGMII SFP
> DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW is set; for 1000BaseX SFP
> DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is set.

It's difficult for me to understand what you are trying to communicate here.

> KSZ9477 errata module 7 indicates the MII_ADVERTISE register needs to be
> set 0x01A0.  This is done with phylink_mii_c22_pcs_encode_advertisement()
> but only for 1000BaseX mode.  I probably need to add that code in SGMII
> configuration.  The default value of this register is 0x20.  This update
> depends on SFP.  So far I did not find a SGMII SFP that requires this
> setting.  This issue is more like the hardware did not set the default
> value properly.  As I said, the SGMII port works with SGMII SFP after
> power up without programming anything.
> 
> I am always confused by the master/slave - phy/mac nature of the SFP.
> The hardware designers seem to think the SGMII module is acting as a
> master then the slave is on the other side, like physically outside the
> chip.  I generally think of the slave is inside the SFP, as every board
> is programmed that way.
> 
> The original instruction was to set 0x18 for SerDes mode, which is used
> for 1000BaseX.  Even though the bits have SGMII names they do not mean
> SGMII operation, although I do not know the exact definition of SGMII.

It sounds like you should run "sgmii spec" by your favorite search
engine and give it a read, it's a freely available PDF only several
pages long, and it will be worth spending your time.

> Note the evaluation board never has SFP cage logic so I never knew there
> is a PHY inside the SGMII SFP.

What kind of SFP cage logic does the evaluation board have?

> For SFPs with label 10/100/1000Base-T
> they start in SGMII mode.  For SFPs with just 1000Base-T they start in
> 1000BaseX mode and needs 0x18 value to work.  In Linux the PHY inside the
> SFP can switch back to SGMII mode and so the SGMII setting is used
> because the EEPROM says SGMII mode is supported.  There are some SFPs
> that will use only 1000BaseX mode.  I wonder why the SFP manufacturers do
> that.  It seems the PHY access is also not reliable as some registers
> always have 0xff value in lower part of the 16-bit value.  That may be
> the reason that there is a special Marvell PHY id just for Finisar.

