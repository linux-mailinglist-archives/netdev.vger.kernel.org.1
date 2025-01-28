Return-Path: <netdev+bounces-161351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BEEA20CF2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555DD188750B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388D1CD21C;
	Tue, 28 Jan 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOoFsVEH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E741CAA6A;
	Tue, 28 Jan 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077812; cv=none; b=EiFCnZMjJe/una3I25afbm6BULwUJs0OriP2/s6L4J/G108q/TgvOzxHSGxKIUHiiLjAfR2AHTeI4ovI1wsy/SzLRlm9vVHVZIGxEgZoJeHOwoApucFtW61DQPKM1ij+ie1sTyGU4+XXpCO2ggBj3KgvVvPEZxqhK0i4Gw3sTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077812; c=relaxed/simple;
	bh=55c2GKs8H3ph8pALNkaNjgCHLmD6HIcd334wFzA2wNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC0d2UZfDNkc2r2stCevUHTvdq8JF/Oohq2YEaPvMlXyRvjQN6gDzFG0yoy8cyG8zKKZhAydh8d1v6ghaeXgweB2P9v+LRtH6xFdPn+9RyWPGHp9xrODCn43O3bKRsQQ6LAoVm+Vy3vVHBJPT6TXjwVqNbe5gxqE6wBz7QzX920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOoFsVEH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436203f1203so4520905e9.2;
        Tue, 28 Jan 2025 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738077808; x=1738682608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QPUsmzjF7eMXsftgMwk1DSHq+eEH5KW/WISvsi+DO/o=;
        b=cOoFsVEHckbWNcrkcW7c36e84UREjeml6GdWWioU3xlYYAihEc6gAHEH4O+Uq3vGxn
         pSg9eEDZ3AuAzMZrP6E457ofZk5HU15TIuaON/xLZfiEmKqFCoRh+xBskgNnDNC+Agoe
         GQikDPsZqn3/5rYjvizK2iQtjuoiTkd1PKpdfV/pKbWqoMJXoXy7iKLY+ahPVse9Z7ya
         qmuV57qsY0DmPI/bQyu/TGg7VVqeegOPGcGmVHrpGyA3nRIiLRFtRJw+umD/vdRRISMl
         t3p24V8YqkBHsDCZSace/Qvu+4P4Do8rZBumushLfPYUN6R2iNBg9PnnJuHaAE2tvkEi
         TbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077808; x=1738682608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPUsmzjF7eMXsftgMwk1DSHq+eEH5KW/WISvsi+DO/o=;
        b=Rh6cSxmbm24gKQ1OynvlAvSJYXQDg8EO4awvf8Ils/M8QuxXYFkZHffASm+cliNLaq
         1nUIF7sLf+AtqWTVzKnAezYSKnAuKAqr9yJadaZspGQhCavN6iJOk2pbMkP8Jw30wG9S
         PZPLdktUG2OS/FDFgrzToEQU6ZRjRZvn1mo6tthYklG2hLzMyYBg5SUWnqmhLnNWe1YU
         5tY5fOPFervrwKGlYPbrhS0IaDGBXhKU4H6OLdCnClqcPtgNLrEWrYgME/BGxzDyj/Px
         wMU0mQNAwIAVyqWsRIf3RWUOdgrNjoD3C6pjH1RU4cvrepDBOYmYyukNya9ujKSnzobZ
         tjCw==
X-Forwarded-Encrypted: i=1; AJvYcCUm2J3oeYfg3WJ/jBJzMFz3fRkoZ5Kfl25CpAbS8ZpbkMOkOBjNE/NIlHIXCBGOsCqIIWVlnfMpb3fkork=@vger.kernel.org, AJvYcCX+zEnyFpzbLfofYSS/oJb3/pKkp+NyvKqZlCclrwvN7Q88x+PSwTxCpPafb5fzaLT85+o8nrzz@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLmdEK/Asnob9/xKrw5dTDEJe68HBFhdl76acw09/QXHOZqN8
	sFxpEY1hvsFUa1ZkY7E33z2R4g8zX57vcmbvNMj2Wo6jubHv6wxc
X-Gm-Gg: ASbGnctqtQJYupKx0yFt220uUDWEllnqY6dlQC1KuwheEugARfYuh0fjIEiSTjbkRH7
	Q/jnPZEnlzVMgsdNMGnrpuwxF8SHFAFkv/nvC/6P8SbYO7d+uVKymh0bah8y6svhmUGbL04yly4
	70ykNig+W8Cs568rmFVP1eFVz6FFuLSy/gosuCmd8Dch1P6jpYOESCBiqhcewUwzpRXZtwZ6epB
	BxMv4V6fYqsm+AcoVmVxZbfjGurLOZzT7kbZrk+VqR9ETyFFgu2YbFloeWWBUqXfs7aLGyUWhr2
	HTw=
X-Google-Smtp-Source: AGHT+IEFk6uj/BYSsVSlb+ezkNazWTyREPZWNDB1DqNcbyuKM2ymoQvVJW+tvYsiK/+60I4OhMSj6g==
X-Received: by 2002:a05:600c:5122:b0:435:192:63eb with SMTP id 5b1f17b1804b1-438b17b0e8emr98209415e9.3.1738077808038;
        Tue, 28 Jan 2025 07:23:28 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e0csm169523425e9.20.2025.01.28.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:23:27 -0800 (PST)
Date: Tue, 28 Jan 2025 17:23:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250128152324.3p2ccnxoz5xta7ct@skbuf>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>

On Tue, Jan 28, 2025 at 12:33:11PM +0000, Russell King (Oracle) wrote:
> I wonder what the original Synopsys documentation says about the AN
> control register.

My private XPCS databook 2017-12.pdf, the applicability of which I cannot
vouch for, has a section with programming guidelines for SGMII
Auto-Negotiation. I quote:

| Clause 37 auto-negotiation can be performed in the SGMII mode by
| programming various registers as follows:
| 
| 1. In configurations with both 10G and 1G mode speed mode, switch
|    DWC_xpcs to 1G speed mode by following the steps described in
|    "Switching to 1G or KX Mode and 10 or 100 Mbps SGMII Speed".
| 
| 2. In Backplane Ethernet PCS configurations, program bit[12] (AN_EN) of
|    SR_AN_CTRL Register to 0 and bit[12] (CL37_BP) of VR_XS_PCS_DIG_CTRL1
|    Register to 1.
| 
| 3. Disable Clause 37 auto-negotiation by programming bit [12]
|    (AN_ENABLE) of SR_MII_CTRL Register to 0 (in case it is already
|    enabled).
| 
| 4. Program various fields of VR_MII_AN_CTRL Register appropriately as
|    follows:
|    - Program PCS_MODE to 2’b10
|    - Program TX_CONFIG to 1 (PHY side SGMII) or 0 (MAC side SGMII) based
|      on your requirement
|    - Program MII_AN_INTR_EN to 1, to enable auto-negotiation complete
|      interrupt
|    - If TX_CONFIG is set to 1 and bit[0] of VR_MII_DIG_CTRL1 Register is
|      set to 0, program SGMII_LINK_STS to indicate the link status to the
|      MAC side SGMII.
|    - Program MII_CTRL to 0 or 1, as per your requirement.
| 
| 5. If DWC_xpcs is configured as PHY-side SGMII in the above step, you
|    can program bit [0] of VR_MII_DIG_CTRL1 Register to 1, if you wish to
|    use the values of the xpcs_sgmii_link_sts_i input ports.
|    xpcs_sgmii_full_duplex_i and xpcs_sgmii_link_speed_i as the
|    transmitted configuration word.
| 
| 6. If DWC_xpcs is configured as PHY-side SGMII and if bit[0] of
|    VR_MII_DIG_CTRL1 Register is set to 0,
|    - Program SS13 and SS6 bits of SR_MII_CTRL Register to the required
|      SGMII Speed
|    - Program bit [5] (FD) of SR_MII_AN_ADV to the desired mode. This
|      step is mandatory even if you wish to leave the FD register bit to
|      its default value.
| 
| 7. If DWC_xpcs is configured as MAC-side SGMII in step 4, program bit[9]
|    of VR_MII_DIG_CTRL1 Register to 1, for DWC_xpcs to automatically
|    switch to the negotiated link-speed, after the completion of
|    auto-negotiation.
| 
| 8. Enable CL37 Auto-negotiation, by programming bit[12] of the
|    SR_MII_CTRL Register to 1.

In my reading of these steps, writing to DW_VR_MII_AN_CTRL does not
depend on a subsequent write to SR_MII_AN_ADV to take effect.
But there is this additional note in the databook:

| If TX_CONFIG=1 and Bit[0] (SGMII_PHY_MODE_CTRL) of VR_MII_DIG_CTRL1 = 0,
| program the SR_MII_AN_ADV only after programming 'SGMII_LINK_STS' bit
| (of VR_MII_AN_CTRL) and SS13 and SS6 bits (of SR_MII_CTRL)

So my understanding is that SR_MII_AN_ADV needs to be written only if
TX_CONFIG=1 (SJA1105 calls this AUTONEG_CONTROL[PHY_MODE]). That's quite
different, and that will make sense when you consider that there's also
a table with the places the autoneg code word gets its info from:

Config_Reg Bits in the 1000BASE-X and SGMII Mode

 +----------------+-------------------+--------------------+--------------------------------------------+
 | Config_Reg bit | 1000Base-X mode   | SGMII mode value   | SGMII mode value                           |
 |                |                   | when TX_CONFIG = 0 | when TX_CONFIG = 1                         |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 15             | Next page support | 0                  | Link up or down.                           |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
 |                |                   |                    | this bit is derived from Bit 4             |
 |                |                   |                    | (SGMII_LINK_STS) of the VR_MII_AN_CTRL.    |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
 |                |                   |                    | this bit is derived from the input port    |
 |                |                   |                    | 'xpcs_sgmii_link_sts_i'                    |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 14             | ACK               | 1                  | 1                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 13             | RF[1]             | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 12             | RF[0]             | 0                  | FULL_DUPLEX                                |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
 |                |                   |                    | this bit is derived from Bit 5 (FD) of     |
 |                |                   |                    | the SR_MII_AN_ADV.                         |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
 |                |                   |                    | this bit is derived from the input port    |
 |                |                   |                    | 'xpcs_sgmii_full_duplex_i'                 |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 11:10          | Reserved          | 0                  | SPEED                                      |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
 |                |                   |                    | these bits are derived from Bit 13 (SS13)  |
 |                |                   |                    | and Bit 6 (SS6) of the SR_MII_CTRL.        |
 |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
 |                |                   |                    | this bit is derived from the input port    |
 |                |                   |                    | 'xpcs_sgmii_link_speed_i[1:0]'             |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 9              | Reserved          | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 8:7            | PAUSE[1:0]        | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 6              | HALF_DUPLEX       | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 5              | FULL_DUPLEX       | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 4:1            | Reserved          | 0                  | 0                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+
 | 0              | Reserved          | 1                  | 1                                          |
 +----------------+-------------------+--------------------+--------------------------------------------+

I haven't figured out either what might be going on with the KSZ9477
integration, I just made a quick refresher and I thought this might be
useful for you as well, Russell. I do notice Tristram does force
TX_CONFIG=1 (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII), but I don't understand
what's truly behind that. Hopefully just a misunderstanding.

Tristram, why do you set this field to 1? Linux only supports the
configuration where a MAC behaves like a MAC. There needs to be an
entire discussion if you want to configure a MAC to be a SGMII autoneg
master (like a PHY), how to model that.

Could you confirm that the requirement to program the SGMII
Auto-Negotiation Advertisement Register only exists if the Transmit
Configuration Master field is programmed to 1, like you are doing?

