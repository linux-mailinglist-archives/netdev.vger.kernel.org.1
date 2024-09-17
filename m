Return-Path: <netdev+bounces-128699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00F97B171
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEC51C21C7D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690517BEB1;
	Tue, 17 Sep 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Of7yR8Jg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC92D045;
	Tue, 17 Sep 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583473; cv=none; b=cCYy1pxsUpVvgYDhZ170ctX+ghcsFjvJiqP0rlO+rX0QVmWEnkI8g8sIjwBzT++bLPL7Y8NzrV6tITJfwdm/06EHfAizpgJe4NIAQeqnXdDSNi1R6XKMQU2/9nCMhVAQaYC1zWPcC6Tsni7HKWtLAAOE5gijJ58X/qwDBZkAANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583473; c=relaxed/simple;
	bh=VMVSMHRhvQ//jxoJEy7uMeB+L9xvlZ2KEl2QDTjI+wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwA2Jj4qjTfcFDJy259sCd/6Eq+om9V7J+WMTTvxSN/HjAitRMtNDzSc2vhtCLimNb9FvRc7aY/NKpdGjQaO2XhKaW7pnYsONtLrbTXIcEOjhD28pD6HYh+wHb/9BQmrcl8NN0CDnO6vS9Bnj5orHnI3sn+FBqqZsj2+9JmVA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Of7yR8Jg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w6IvVu9+p7my0rLi2hz8x9RaDYdKgEtiSkEPRYHcrkA=; b=Of7yR8JgJmukosSr4YTLLLA9T/
	IFes/3WECyfMM8gJAxqqTYm7G2KeEfYvD6OOe8hcGScPHbKqtpLQkkhp+UUOx210HmJfCU088JNFL
	qXmmRK0TGgSZ56ili0NNfQyQnPCtAOJFPly7H1Cw5ThjKN/IQn/8coJAP9fS8VZEMb31/IWy0foTY
	VuWCF4Y0aSYpxMADNOasxP/w0QbfB7Kbro5yW52dke7CVFCbHh4MNw0FLNj4aXhtm13ng3Mt8KYoo
	5aCzCMTvOvnz78e9e+cUbSYIpspG5vt+TxiUNAz+TpyBMQVltX4cKV+YlBNsJqe1N6WEyLZboC1aR
	Kw41Cf9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqZEK-000714-10;
	Tue, 17 Sep 2024 15:31:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqZEI-00082q-1N;
	Tue, 17 Sep 2024 15:30:58 +0100
Date: Tue, 17 Sep 2024 15:30:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: phy: aquantia: fix setting active_low bit
Message-ID: <ZumSogQAMwN7Yd6N@shell.armlinux.org.uk>
References: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 17, 2024 at 02:49:40PM +0100, Daniel Golle wrote:
> phy_modify_mmd was used wrongly in aqr_phy_led_active_low_set() resulting
> in a no-op instead of setting the VEND1_GLOBAL_LED_DRIVE_VDD bit.
> Correctly set VEND1_GLOBAL_LED_DRIVE_VDD bit.
> 
> Fixes: 61578f679378 ("net: phy: aquantia: add support for PHY LEDs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

