Return-Path: <netdev+bounces-233044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516DC0B851
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2187218A01A7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505331D5147;
	Mon, 27 Oct 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wKXFNreY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D081A8412;
	Mon, 27 Oct 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524183; cv=none; b=lmea079azs1r7QkJcEff9sXXCapi8wTS/Jy3oOMOl+mNCKXzy7bo4WtHbeZIimHzUJTrfOmRcOBnWY1eozrgHSN/V8RQ5Epezw307sVmVa/71YwBjFtno316+XYd1e0NPccY1E5uVJh7M1srlwe8N/rDCgqiJdKsrg0uq6NtslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524183; c=relaxed/simple;
	bh=MvxIqb08vtaPVJQcd+G4zeThHfYf8zRAtzZWMDrXRaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuAXPLsZHnPbybh8rjr+f6OAfaw28+Mey8db3ZOYckh05GQXvZ6DpG4cSdDe+ePFVfvtTrJ0EluqH0Iia4G7sXnvWGNtdhm+JOLc+6McVbKg+mD3GFcWZeKIM+WA/kfMLieKSn1IhmADpYmsIZZDEuzAcpd/tQiwjaE2cd0mDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wKXFNreY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=doOsOCCGyVbII0A8WSOdhf0gKKP0PqbpiZs6rvKkxhY=; b=wKXFNreYTB35c7gLsAkCnBty91
	xRjYrx69Z+0FSyeoXfCr9Vqtp+06ko6ljb5BSkU8qzV9ivmM/8UHahf/vi/zec7GUganbYK6X2Ivc
	rRuOOBInBB6W/6G0s+DSTwExLztlLNkJq5LCCDnB5BsS/uqZTKS6N1X+SYF7fxHzkZzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDAuC-00C8vM-52; Mon, 27 Oct 2025 01:16:12 +0100
Date: Mon, 27 Oct 2025 01:16:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Eckelmann <se@simonwunderlich.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sw@simonwunderlich.de, Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH] net: phy: realtek: Add RTL8224 cable testing support
Message-ID: <3b1d35d7-ed62-4351-9e94-28e614d7f763@lunn.ch>
References: <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>

> +#define RTL8224_SRAM_RTCT_FAULT_BUSY		BIT(0)
> +#define RTL8224_SRAM_RTCT_FAULT_OPEN		BIT(3)
> +#define RTL8224_SRAM_RTCT_FAULT_SAME_SHORT	BIT(4)
> +#define RTL8224_SRAM_RTCT_FAULT_OK		BIT(5)
> +#define RTL8224_SRAM_RTCT_FAULT_DONE		BIT(6)
> +#define RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT	BIT(7)

It is unusual these are bits. Does the datasheet say what happens if
the cable is both same short and cross short?

> +static int rtl8224_cable_test_result_trans(u32 result)
> +{
> +	if (result & RTL8224_SRAM_RTCT_FAULT_SAME_SHORT)
> +		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
> +
> +	if (result & RTL8224_SRAM_RTCT_FAULT_BUSY)
> +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
> +
> +	if (result & RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT)
> +		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;

I don't remember seeing a PHY able to report both same short and cross
short at the same time. Maybe there has been, but there is no code for
it. We could add such a code.

	Andrew

