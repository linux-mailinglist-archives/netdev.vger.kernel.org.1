Return-Path: <netdev+bounces-209344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4BB0F4C5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB61580762
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887C1ADC93;
	Wed, 23 Jul 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gdY94EqZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA818DB01;
	Wed, 23 Jul 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279346; cv=none; b=AP1DuriDzHICzIra4GcjXfy+HHTWfso6T1sAYuxHtsYqpzuxz7G/0ZyxLr1+9PzSpmqrSP+qcldQep25AO+HM2Ou9KBPLHlPaJeMdvrONyjqFvnekZcOe8vitQZzLznAzj0WRfTmCqJy/4gIZY43bcRhKvfVs9YDxZGZ7v4RxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279346; c=relaxed/simple;
	bh=Qt23hKMWooTOPyxlrtzHMCM+w7Fw6lCMWeDsrrEAB4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiK+7Cjwb0ftzTpXEFA6bYOZZt6KsXNkw6WPdhWdTlDcQ/vFZFMbKhsbCCbv0h3tcHiV+kG1udDxF/XpuWdqgFArzBFN8722BtlNyoecqIS5fOZgdXIr7B6CJXz4Egzmy59tOaLuUVf9Rmeb6WDputX9QS49M3q5GojQj8ymxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gdY94EqZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hnXBrp6nZj1igjITrTimshdIDwjv73qcH+GOPbSCUXk=; b=gdY94EqZaE3KR5jXzRnewjo9j5
	dUhX3/ZwF3t7tQ4kLjRQ80zgcsHZwbSkawzNvRgELZGmeQNNoi48mr4P3YBz1mIcSQbeHy1MooEf2
	hRQNbLaUae0+pOCg6XV7N9BQQ9gLi593mxlmQeeNAuui0kCR8nF763Il9lhWAOPOhSZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uea2m-002aZn-6G; Wed, 23 Jul 2025 16:02:04 +0200
Date: Wed, 23 Jul 2025 16:02:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <dea45ecd-c183-426b-abae-12220a2b6827@lunn.ch>
References: <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
 <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
 <aIAKAlkdB5S8UiYx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAKAlkdB5S8UiYx@shell.armlinux.org.uk>

> I've just read a bit more of the RTL8211F datasheet, and looked at the
> code, and I'm now wondering whether WoL has even been tested with
> RTL8211F. What I'm about to state doesn't negate anything I've said
> in my previous reply.
> 
> 
> So, the RTL8211F doesn't have a separate PMEB pin. It has a pin that
> is shared between "interrupt" and "PMEB".
> 
> Register 22, page 0xd40, bit 5 determines whether this pin is used for
> PMEB (in which case it is pulsed on wake-up) or whether it is used as
> an interrupt. It's one or the other function, but can't be both.

This sounds familiar.

> rtl8211f_set_wol() manipulates this bit depending on whether
> WAKE_MAGIC is enabled or not.
> 
> The effect of this is...
> 
> If we're using PHY interrupts from the RTL8211F, and then userspace
> configures magic packet WoL on the PHY, then we reconfigure the
> interrupt pin to become a wakeup pin, disabling the interrupt
> function - we no longer receive interrupts from the RTL8211F !!!!!!!

Ah. I thought that switch happened in the PHY driver suspend() call,
and it gets restored in the resume() call? That does required that
suspend/resume actually gets called despite WoL being enabled...

	Andrew

