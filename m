Return-Path: <netdev+bounces-158060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A643A104D4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BB53A20DD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4A20F980;
	Tue, 14 Jan 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjKhcHTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB420F97A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852352; cv=none; b=FOYghhaUrajsbGYbsw6bZ2DSfb0TISqQjoow9sxiY6YJfDxENCjXv71Us8tKjocJlKA365T/rUzMdcS5BnDgP2UBugk4xh1DwAO1S7UFeYRoMFxR47i2UaaWTbVSrqpS3DUokrb6n6DSV6tOPUpGw1PJqu61hbDGFsfxUSOWKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852352; c=relaxed/simple;
	bh=htQPumw+QagRJU4Yxw5NoAbguFUvojv83pYTUCDnnlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXbh737nFNDyqv5D3fBSBNHKkKICvdw4JMikuOA5hE+g3kS5d52RSo0HtHnqXwyan+9tCDfX3ICh1+/Qt7/wvaDuKrUuZ5UYMNF6kowjd/9sa4L3eZ7EgLW1vie9bLYdkM5lC3rLE4NmOS7DF3RkT//0S2qFGIP5QCB2KLpL3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjKhcHTp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeef97ff02so870030466b.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736852349; x=1737457149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+bvwgvu4CkJDHRlSzEsfX8EKftNhXZjfWiun+N9twI=;
        b=DjKhcHTphqhGKJ4aMSqlrqNosALWllPAqdM7u9JFqgEUPhXLt6l2UPqPXYYsWpEHEm
         ZclszSl6OJ8ZBy9MHJJSh6XqkGRR7dF1mQadEHpmUtvsSwlvckXULEbSjcNo1ybzchpO
         txQU29VdXKgWqXWx8WQPve8gHHCqi/RdkYx0BKe+HMNgiQ7Agl/M27p/tk8nwVTz9AdJ
         Ee1qxUMNcmknmAqmdZkdpRCfaW73GCdWl7i9d8ETdmB5K/zIaWTA3tnZZkvvv/GMSVX/
         jox6/ADWsAmX2mvRQRKXqwjhkcCMis/OLP4YGqMomcm6gTs8s+2l4uDeeSBo4DBzhzC+
         gB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852349; x=1737457149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+bvwgvu4CkJDHRlSzEsfX8EKftNhXZjfWiun+N9twI=;
        b=sgiMrsaD7PM9/CURcIO8mAJ494Q9lLltk+CicRqsaVKwimAmM+JLATSGRZq80aWaXS
         7nogggXZWJltrabZKLGFiChW4955v15XOkUfV95B/iJ24TF8Y8keepiXE+DFtTzPeMak
         f81a9YzNUhJrnWs9okLa5m3WO1I7gVPRq+heCOq2DxUOLBUsZN7ybPuQKCcnHFzVcDs9
         Boob3Bd15K1Efw8K1Lsjww/BdBJaVaEzLXVzaIQgMua+LdYkH8CFz8pDkCxQUaC2bXJp
         DPlnMOq9JxZ4+nOal5+zYrC3qCEH8SQFaNzSIPfRsiZXiSdpEtqFzqx+PYkJIPXamizQ
         i4fg==
X-Forwarded-Encrypted: i=1; AJvYcCWUgJGOJAlFuzbLAmz8HI64t7/3qLcKAf1iRmzkO/+lkNDXyD6QR/zo18Iyy6MaplWa2WIsY+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAq96p93D6EROnnwoWj/ChS/YyD9szt+4frC+7TLwu4khBzsL
	P5HJ0h6kmDbt93KnC7EU99XFynD7UhEvkWuWl+MgAKmQ+uL29Byg
X-Gm-Gg: ASbGncsstE3x3Ijjht2X9K8fxdC3bM7C+I8mUV5SqO8nnfIfkew4a22GWNfjxfatkhC
	QCffo9Qnl7fD1yNmP10pJSoxKtJ00I2S8jpiants5ug89i43296LTVVOXpC4Ln0MNC7HOQ3ETv6
	6CETt2Cx2c9bqLgzvzfb6VXVi8+rRSkfRAVpKmo7votjFGEDoQIsflnzed6Ub+fwROTQ0obcpGZ
	3ObHN3v5Ux7XmmqYKkDn0OjCF7QY04oqk9cZN7Dip+o6AzOOhPwII4gTnr5wbf7pnUV2Hb50h2K
	lsk0aIfqPGT26kF8RIUOJsWLZqvpDGOcTsSsGd2iJLhfNMdsZxS5QqUfBppoE9N2ks6sXYWWJKj
	xx2KcxVFxFRe9q/9/uJ739pG3AaYhkcA=
X-Google-Smtp-Source: AGHT+IGHKnCOMaakbmO+qlp9H2dpIL+fGfdF1aR9r2RdZWi0icXr2XaYrNo9rCMG1v1cc/9NlZ/sww==
X-Received: by 2002:a17:906:6a0e:b0:aae:e784:55c5 with SMTP id a640c23a62f3a-ab2ab7101eemr1730141766b.33.1736852348666;
        Tue, 14 Jan 2025 02:59:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm620531566b.93.2025.01.14.02.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:59:08 -0800 (PST)
Message-ID: <29240b2d-8a34-47d6-8b99-a371668b0bef@gmail.com>
Date: Tue, 14 Jan 2025 11:59:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Alexander Couzens <lynxis@fe80.eu>, Alexander Duyck <alexanderduyck@fb.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Daniel Golle <daniel@makrotopia.org>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
 Lars Povlsen <lars.povlsen@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni
 <pabeni@redhat.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Wang <sean.wang@mediatek.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/25 10:21 AM, Russell King (Oracle) wrote:
> Hi,
> 
> Eric Woudstra reported that a PCS attached using 2500base-X does not
> see link when phylink is using in-band mode, but autoneg is disabled,
> despite there being a valid 2500base-X signal being received. We have
> these settings:
> 
> 	act_link_an_mode = MLO_AN_INBAND
> 	pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED
> 
> Eric diagnosed it to phylink_decode_c37_word() setting state->link
> false because the full-duplex bit isn't set in the non-existent link
> partner advertisement word (which doesn't exist because in-band
> autoneg is disabled!)
> 
> The test in phylink_mii_c22_pcs_decode_state() is supposed to catch
> this state, but since we converted PCS to use neg_mode, testing the
> Autoneg in the local advertisement is no longer sufficient - we need
> to be looking at the neg_mode, which currently isn't provided.
> 
> We need to provide this via the .pcs_get_state() method, and this
> will require modifying all PCS implementations to add the extra
> argument to this method.
> 
> Patch 1 uses the PCS neg_mode in phylink_mac_pcs_get_state() to correct
> the now obsolute usage of the Autoneg bit in the advertisement.
> 
> Patch 2 passes neg_mode into the .pcs_get_state() method, and updates
> all users.
> 
> Patch 3 adds neg_mode as an argument to the various clause 22 state
> decoder functions in phylink, modifying drivers to pass the neg_mode
> through.
> 
> Patch 4 makes use of phylink_mii_c22_pcs_decode_state() rather than
> using the Autoneg bit in the advertising field.
> 
> Patch 5 may be required for Eric's case - it ensures that we report
> the correct state for interface types that we support only one set
> of modes for when autoneg is disabled.
> 
> Changes in v2:
> - Add test for NULL pcs in patch 1
> 
> I haven't added Eric's t-b because I used a different fix in patch 1.

So I tested this V2 patch and with the first link up command, I get the
link up which is functional end to end.

Tested-by: Eric Woudstra <ericwouds@gmail.com>

PS, FYI: I do however still have the difference in phylink_mac_config().

At first the link is up with (before phy attached):
phylink_mac_config: mode=inband/2500base-x

When the phy is attached, phylink_mac_config() is not called, but we
have functional link.

When I do: ethtool -s eth1 advertise 0x28, then:
phylink_mac_config: mode=inband/sgmii

And back again: ethtool -s eth1 advertise 0x800000000028, then:
phylink_mac_config: mode=phy/2500base-x

I can share more log entries if needed.


