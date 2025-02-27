Return-Path: <netdev+bounces-170266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEAFA4803D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F453B5F8C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D42309AA;
	Thu, 27 Feb 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hdp/5hqw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2B22D7B6
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664750; cv=none; b=TbMbYMKm+RfKtuzd0rkGk27YE0EpM7VSOpChEuwHIslkBn/Z5p97y2dO3yAk8FiXO35jxlXs1kQnQIscOJM1MNxXelSDxMfoPbzVR7JYc2AVGdS1vCCVOUIggdKowNKiJq+7dQ2EIpYPCPDlD0WTj82HHZa2HDkgbZVCdX1MpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664750; c=relaxed/simple;
	bh=JDuqoonxCn0/JHWH/VPax66HLz+RL9AIFhlkqqn279I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPvaLpy/3/qT7dtHZqoemNlWJnagMEyAVAhf94bTpmsBYdgARp/TX+arQgJbE6nALvGYZnNH35VKYZajDPqHOU1+b2R+JnVyOwmIR6GlUg8eC89ZO4kMjhopi5aLRZTxaHQlFHAKtZ0YIyNSgQBA5CbnmRDcRgG9OVAvOY3oKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hdp/5hqw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IEhXVqg5fOukDHTelmKWiamiLuG6A2nrORt4Ug1x8/U=; b=hdp/5hqwFqsirt412Zla21aLCP
	+zYlD8FD7CuvxqGWuM9Fs/tmBHnQ81r0mShpoLYWWeGYbiQXzl0gySvGBaVANPFwtDoX5S/xnxWHy
	A1R8Wlr8dsaSg7Gn2MF0atfbuufAduGWksCC3qBcbO6upDVQ/ImTLYFhVuV/i4wTRL2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnePi-000br1-Rm; Thu, 27 Feb 2025 14:58:58 +0100
Date: Thu, 27 Feb 2025 14:58:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 03/11] net: stmmac: dwc-qos: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <f20b7f08-f2df-4c27-88d5-56c8fbbadf8c@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0P-0052se-Tv@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0P-0052se-Tv@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:33AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

