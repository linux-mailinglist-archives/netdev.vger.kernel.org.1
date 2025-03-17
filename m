Return-Path: <netdev+bounces-175278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92EA64C13
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9859165D09
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8ED21C166;
	Mon, 17 Mar 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EXk7e5cC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE0366;
	Mon, 17 Mar 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210122; cv=none; b=LTRYNw9yzGDmZLWxNQwigQZqSFhEk49VucH08dCcjeAcniL0IM71sDUeN0C2fbWtUqi8qhaDFiV2rfOw1f+eYHNrxe3xEmsOZP7K8Gyi9uqAYAgdcE9hr6p5/OvEo92uNXAklr8NdP4wwHcpIYe/DKcxGdLOav6tbkLc5Cmnzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210122; c=relaxed/simple;
	bh=eNTPcJSiWc/MzJSny1IbHlNyuwWxhulQntYMxksDwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naSeDSSX8HUl0BtaV+At+E/RqGofUZraBaTihpl2KZIyn9UaW5VD/nH0at49qzH9XmVJ+fdyzdTkR1P0zUlpyLqx1B6wkLuZhGwt/J4S/Oc95C39qwL1cmCtFIgbaWs17DsuPVRmXieYlxtbnxr1wYTjkokZlqCjBL17u7im5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EXk7e5cC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mZq8jgI6QykZOlO5S6BA2uTbJ1kmNJri47i8SvX5HVc=; b=EXk7e5cC+vRdsbVAe0qNjiSYMy
	QiBLLGwMH+Izq3tc2oeLUJ2aZ1OEtYAHQVS9I5MuJd18+8WgPu4B5V0XnyczeQLzWYNnXeXlnij7U
	PlhJ+b8618p5G1a0wmH1k6sgnRTpb6sA+9koml62wnTbOnKpwCcefFvsgI836G3JgJVtciyroEzJD
	aqVCODVxWttebGVquF9SOAXfx0IDdz1ebR1ewYWI4Z5qtUPSrF3czy+wm3B1sWfzbj9nB5W0P+OE5
	hYIJT1o9WfCyqGZBu938exwuxQUSUAEmVcCY71iEZOHAL6+S8IhHDZ9XYrnlVM80x++lgwmYcUlFh
	NxNN/zyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu8R7-0003QY-35;
	Mon, 17 Mar 2025 11:15:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu8R6-0003WS-0A;
	Mon, 17 Mar 2025 11:15:12 +0000
Date: Mon, 17 Mar 2025 11:15:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,2/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <Z9gEP_w6WvuCC_ge@shell.armlinux.org.uk>
References: <20250316121424.82511-1-michael@fossekall.de>
 <20250316121424.82511-3-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316121424.82511-3-michael@fossekall.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 16, 2025 at 01:14:23PM +0100, Michael Klein wrote:
> +static int rtl8211e_read_ext_page(struct phy_device *phydev, u16 ext_page,
> +				  u32 regnum)
> +{
> +	int oldpage, ret = 0;
> +
> +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
> +	if (oldpage >= 0) {
> +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
> +		if (!ret)

Same nit as patch 1.

> +static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	int ret;
> +	u16 cr1, cr2;
> +
> +	if (index >= RTL8211x_LED_COUNT)
> +		return -EINVAL;
> +
> +	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
> +				     RTL8211E_LEDCR1);
> +	if (ret < 0)
> +		return ret;
> +
> +	cr1 = ret >> RTL8211E_LEDCR1_SHIFT * index;
> +	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
> +		set_bit(TRIGGER_NETDEV_RX, rules);
> +		set_bit(TRIGGER_NETDEV_TX, rules);
> +	}
> +
> +	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
> +				     RTL8211E_LEDCR2);
> +	if (ret < 0)
> +		return ret;
> +
> +	cr2 = ret >> RTL8211E_LEDCR2_SHIFT * index;
> +	if (cr2 & RTL8211E_LEDCR2_LINK_10)
> +		set_bit(TRIGGER_NETDEV_LINK_10, rules);
> +
> +	if (cr2 & RTL8211E_LEDCR2_LINK_100)
> +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
> +
> +	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
> +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);

Do you need these set_bit()s to be a heavy-weight atomic operation, or
will __set_bit() being its lighter-weight non-atomic version be better?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

