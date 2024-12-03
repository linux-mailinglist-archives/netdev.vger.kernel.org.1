Return-Path: <netdev+bounces-148535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 028AB9E1FFE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE65B82DC1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31C1EF082;
	Tue,  3 Dec 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TIai6xz0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836ED13B5B6;
	Tue,  3 Dec 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237129; cv=none; b=GZtwZrGSOX2DRtTvij0T6mX541guiekVFqH+g0KXHxL7Dhk5BInWQQ0izKjlR6CNosR84NJMZkFwaInBZEHeXuaKcXuxprA4e+7TA/FFlV+MBMhHdBXUn9wSHPXeRLtm0kLG+L9/gL0h3pFIvbRpC+Z7P6Qv2JYMXdaCUESVzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237129; c=relaxed/simple;
	bh=s70dZjnxOR/Viyl1o26MHuhoRyjT/UuPusJ74A47LWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVmA5EiiduElLih9WITxOvCf9axDuiUHm2ouC+C0IdgcJJQyeKJkyq4ANIGveKsjjHdXybpP4L90VvOIGeQr8iOeIPXMcXoz7UmT7+nOWM/0ROF0H9zaZgyhFiWMccLJGldmMZXGAMbRorOt1jdeahesrjavRDoamarod28Px9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TIai6xz0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=blBteVWpp5GLG/dhaZyUrh1QEumbYVjnKpfdzoL1dHA=; b=TIai6xz0RoigsftCvxKZudV4Gs
	xHClZ1bIABhmxUH6PW5XnL17GBgRUWxe+APZC9DoFk8GNBy/d3+1j1nUAkt7a5vSioM+kyUC/cjCK
	+k5g4REntOz2A8+fYP2QjR0Pao182QLDCSNI7uhgQVc+a6YxQzuONmZpkTsQuqoL/VlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIU9F-00F6Hp-OL; Tue, 03 Dec 2024 15:45:09 +0100
Date: Tue, 3 Dec 2024 15:45:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dennis Ostermann <dennis.ostermann@renesas.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"nikita.yoush" <nikita.yoush@cogentembedded.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <1ff52755-ef24-4e4b-a671-803db37b58fc@lunn.ch>
References: <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
 <TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>

On Tue, Dec 03, 2024 at 02:05:07PM +0000, Dennis Ostermann wrote:
> Hi,
> 
> according to IEE 802.3-2022, ch. 125.2.4.3, Auto-Negotiation is optional for 2.5GBASE-T1
> 
> > 125.2.4.3 Auto-Negotiation, type single differential-pair media
> > Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and 5GBASE-T1 devices to detect the
> > abilities (modes of operation) supported by the device at the other end of a link segment, determine common
> > abilities, and configure for joint operation. Auto-Negotiation is performed upon link startup through the use
> > of half-duplex differential Manchester encoding.
> > The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1 and 5GBASE-T1 PHYs
> 
> So, purposed change could make sense for T1 PHYs.

The proposed change it too liberal. We need the PHY to say it supports
2.5GBASE-T1, not 2.5GBASE-T. We can then allow 2.5GBASE-T1 to not use
autoneg, but 2.5GBASE-T has to use autoneg.

	Andrew

