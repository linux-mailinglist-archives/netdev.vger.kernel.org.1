Return-Path: <netdev+bounces-241067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24099C7E595
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 19:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29403A4913
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F12C15A3;
	Sun, 23 Nov 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+6xZvpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404A1F181F
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923292; cv=none; b=TWHnFEoR6qxPV/xPABG+oAQwUGSn0mZagl8sBX6IjwvnuiHKkurftZXYWpNQ5+4MWLWdUxfbvTgeI1CuUUd0STeZ/Erz9AQkbcB6KWYHCaIn9+zL1uSbC3/ObPWaiQgYu1LNtgmYVTbmAwK7YYxhOdFvEwNU91SJMFRMD2aCGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923292; c=relaxed/simple;
	bh=/PNQfLV0ii+5KCQrTkIiqc7h27eTmNP0h2RgkZd/OCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpB/PO84Qlo41QoSSCUU4U1HkXqSMuWDr8jiF+sCOIx9KrepOISX3WrBaPfvl7gL04+PO2T3Abxg2Uw7grZwkxa8Y8NJGsZv4wIIlIkZ55FHJu1RdDk94l+rHd0boj4gsR7Na/1nTlkbgbO12TCTjkoXsM/fqihUNx877CXsBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+6xZvpP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3720e58eso2778366f8f.3
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763923289; x=1764528089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1xHDzT4djyLcgh+WAmNWD5JMkOMsweKMSDPqf2u50M=;
        b=e+6xZvpPcaHuQwJj//cs0z94LM8hjWbyReLd+s/GUFopq64qUetTgktc5ilvA2hmqq
         AILBGLhkOrbGilzjyDfF75a63GtmkUtcIRaYrT2nFKTQnP1mxpO8ivnG8P31dJawNrNI
         zL9/l8aq5CT5uQup8Sw43HjAtCx3EkewD2zTSq4Fze0tJw2EwjKQOmA8PrHlPEg2d+yz
         tFjmfvyn2jD/Zvek4ZVyS1iDuFQ9Lum2cpVaKL3fH0rbVFI4ydvZeKfVuP2pPsCUN+Hh
         XzSHJM1OrE3VE/n5WBASq52T09ik35mnh/fD2VSDBJeQtvRf1hmvRpsK3xQMSYI8EsbR
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763923289; x=1764528089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1xHDzT4djyLcgh+WAmNWD5JMkOMsweKMSDPqf2u50M=;
        b=rYHM7plPMEV4TjrlrV+R/tYKg5rIubf2s9wDjoQy1jAKjhvHGYq1P+QOlVRCusk6Fe
         pSnBw+e4PGwnJMEAXCj48+J2HaysHSFbKNI9P0BQ/GXD9ps5cKtWIsFEQsg7OeyoaBEx
         NV4kTWudJp8Zghf28PaXon2CEp33wnYI5xnqMLpORusO4VxRPUpV84SKRe7jZLsUOGbY
         F09P0pIyKOfxZLW41w3VYMwGtk8GeLNSZR/x4Dk9pwJvOHVm+7lRSFp6JaGo0QC8mZ0Y
         /lgssfICmwD44XIId8jV0uqZgDrWAOpoVFPqPSp6t1d8sZZD80OLT9BWIl1eIrH28GSl
         qCJw==
X-Forwarded-Encrypted: i=1; AJvYcCWitBdggmZHLpWeYHOSrqxeXhkFeUQi/3+/qzOid4HXt4nVNy1sjp7S9xtE0J/LWX8X0hN9oEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUrzrLH+2njVSSxf4n8AWs4Tk3rGmNCKgSyvHw5WAf+dOFzPv
	I28FoeNoS73riY+pr7C7mjaxlEu5NnGmzTiZxC8G6kDUX+lOmAFi1ScN
X-Gm-Gg: ASbGncu0V4OR3/5on/dRQMc4iwsEaLtGduXgn/OoMgFb/2XG1SCHVfMbZ6PbHJ3vV/o
	wyL3VB0i8SiZb3Nar49rpfSAY6EhVo46tC1BE6S/Bxj5/vePhpqZm3qGfCh9z+97Wlij3XKNZ6k
	JrIuLr0vYFWJMTXXcp7xttTK+oBt5F1ZPa0qTRh+9KsqkD9YOmyui0KJdIDzk8GwlcEmmioX1hg
	Sk6WrBzGDF4Pe3aGfBQNlvXj3AhmfpYOHoQOa425jAxzTwAc5oUznHf1puVtkTNX+5m5KBIZdus
	khpBA3bfRXkdWbE9zY5b8TzFZYhLGMyFrpfsBKyq/aJP3iOmf9HRNL0GSFK2x4QTdgSN3eQckM+
	XVXv62y8AlBMsSO9/2uV2qA8xEMgLckSQvRghrPOvdPkrI0+cBULcO2jEfggltlsF5L3kctr35n
	OLfqSc/661jwiMQSuve8ALmgOgZg==
X-Google-Smtp-Source: AGHT+IF1SpjNDPWAJYuXZSPQwQ/bLUCgvaXufYBwuNWA9Q1BqBGfTLWNb0cPDYzg9eLVl5FAwHnEpw==
X-Received: by 2002:a05:6000:2004:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-42cc1d3209amr9664628f8f.43.1763923288992;
        Sun, 23 Nov 2025 10:41:28 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa7affsm24014550f8f.23.2025.11.23.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 10:41:28 -0800 (PST)
Date: Sun, 23 Nov 2025 18:41:26 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
Message-ID: <aSNVVoAOQHbleZFF@google.com>
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>

Hi Heiner,

On Sun, Nov 23, 2025 at 04:58:23PM +0100, Heiner Kallweit wrote:
> This is a version with better integration with phylib, and with 10G support only.
> Maybe I simplified the PHY/Serdes initialization too much, we'll see.
> A difference to your version is that via ethtool you now can and have to set autoneg to off.
> 
> I'd appreciate if you could give it a try and provide a full dmesg log and output of "ethtool <if>".
> 
> Note: This patch applies on top of net-next and linux-next. However, if you apply it on top
> of some other recent kernel version, conflicts should be easy to resolve.

Thanks for the patch, ran some initial tests, I'm on Linus tree for
other reasons but applied 3dc2a17efc5f, 1479493c91fc, 28c0074fd4b7 and
the recent suspend fix, then your patch applies cleanly.

Here's ethtool output:

# ethtool eth1
Settings for eth1:
        Supported ports: [  ]
        Supported link modes:   10000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  10000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 10000Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: Unknown
        Supports Wake-on: pumbg
        Wake-on: d
        Link detected: yes

The phy is identified correctly:

[ 1563.678133] Realtek SFP PHY Mode r8169-1-500:00: attached PHY driver (mii_bus:phy_addr=r8169-1-500:00, irq=MAC)

That said I've observed two issues with the current patch:

1. the link on the other end is flapping, I've seen this while working
on the original patch and seems to be due to the EEE settings, it is
addressed by:

@@ -2439,7 +2439,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)

 static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
 {
-       r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
+       if (tp->sfp_mode)
+               r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
+       else
+               r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
 }

 static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)


2. the link is lost after a module reload or after an ip link down and
up, the driver logs "Link is Down" and stays there until the cable is
unplugged and re-plugged. This seems to be addressed by the code that
was in rtl8127_sds_phy_reset(), re-adding that code fixes it:

@@ -2477,6 +2480,13 @@ static void r8127_init_sfp_10g(struct rtl8169_private *tp)
 {
        int val;

+       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
+       udelay(1);
+
+       RTL_W16(tp, 0x233a, 0x801f);
+       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
+       udelay(10);
+
        RTL_W16(tp, 0x233a, 0x801a);
        RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x1000);

Guess the phy needs a reset after all.

With these two applied it seems to be working fine, tested suspend as
well.

Would you integrate these two or want to try me something different?

