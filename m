Return-Path: <netdev+bounces-84155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADCB895C62
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5930B225BB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70FB15B573;
	Tue,  2 Apr 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QgfY3ZFC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825015B54E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085829; cv=none; b=TrX10zmlJC+JxZsf9sA/2ZntEOPMKlWGsTYPWj0y5uDeCnQWsRJ/+QkO8sxndVMp9D2AmvE1r6iLCYE+tWMIt8tbMw4RZFEkctCQMM6WH218JX+r1/XFP2kYCzUPH3RwgELn7sg/FqBB4Mwx5KShDETRprbIPI0637DrAfT/cr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085829; c=relaxed/simple;
	bh=YxJosB4S0++4UU3NlfXAs2Pqdw77rwTWpvzeG/ZQxe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkxriYAXuoa9x6jlcNS4hjNCbaQwlcJ5BVZMfzeMmEemSk09LzNbGgeXbFxXoe4A7BTnBI3QPcLs3ruq1QjiAvqwxHpPAv6h8aPGYpyA05wOugM95vsLEIgcmknHmOijVMq2ZWtpXVGZZdeAYxNp8MaN+Xtz5s32lKzjSklISfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QgfY3ZFC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IpNfVIUp4lnJGZCQH1Of09mdt9upsJ7g7bjuOhAgyNM=; b=QgfY3ZFCmvD8BtVw9pyTKGxsEq
	3Zy4ZyZ13SoRjfA2m3J/I8H0yhYmRXNdV7K+/isfW9IWv7oJJfPMt/yXv7SrJHjULKnP6EH83FMBg
	xiKvjPhqvYy8MlsYsn76R7yh0Inamhw7pZ/QL2otta/4zsPNAhW3NTAAtDCIxzD2vPcyMmu7FvzWE
	9AD8IfFQ1wrIOgbWrT3L49MUDv8CgyYD68X+kaEKfSEN8Lfpdnk4UBRWbP8XgeCvEq0UZ8QPlbV0P
	zXvouHAel3mq5P68dCM7IkOsVomFc+kBhdvL4Tv1sA66WjNj0/+lfSXdkpNlrr75AK6B+9SEPgiGT
	FeW0B8Bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrjjI-0007FT-2A;
	Tue, 02 Apr 2024 20:23:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrjjD-0007Bz-H7; Tue, 02 Apr 2024 20:23:27 +0100
Date: Tue, 2 Apr 2024 20:23:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH v3 net-next 1/6] net: phy: realtek: configure SerDes mode
 for rtl822xb PHYs
Message-ID: <ZgxbL03HMl41LHqb@shell.armlinux.org.uk>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402055848.177580-2-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 07:58:43AM +0200, Eric Woudstra wrote:
> From: Alexander Couzens <lynxis@fe80.eu>
> 
> The rtl8221b and rtl8226b series support switching SerDes mode between
> 2500base-x and sgmii based on the negotiated copper speed.
> 
> Configure this switching mode according to SerDes modes supported by
> host.
> 
> There is an additional datasheet for RTL8226B/RTL8221B called
> "SERDES MODE SETTING FLOW APPLICATION NOTE" where a sequence is
> described to setup interface and rate adapter mode.
> 
> However, there is no documentation about the meaning of registers
> and bits, it's literally just magic numbers and pseudo-code.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> [ refactored, dropped HiSGMII mode and changed commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ changed rtl822x_update_interface() to use vendor register ]
> [ always fill in possible interfaces ]
> [ only apply to rtl8221b and rtl8226b phy's ]
> [ set phydev->rate_matching in .config_init() ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

