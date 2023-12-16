Return-Path: <netdev+bounces-58228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FA815919
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806471C217D7
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3718EB1;
	Sat, 16 Dec 2023 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CsRYI3gk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707031A76
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OiWwil5JNsNFEb5NOoHyZqS3C4dnmBuFjcczGMXisus=; b=CsRYI3gkTlDTD4hFnEvG1+laBi
	U43z2w+p3mbNVl+mnVlXLCuvz7Qu128ADoAR/xH1q0fj3GNPFLUgpAgBe/3NVtXhtURHHztuW25I3
	53n13mJQyZhNRcNypCvvlyYU7bbymQnBjOzFRSMClez1pqvVweYMBFCUDmehInE+h2ug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEUAR-0036B9-R6; Sat, 16 Dec 2023 13:53:19 +0100
Date: Sat, 16 Dec 2023 13:53:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for LED's on RTL8168/RTL8101
Message-ID: <e897b56e-4f7b-4df0-9ac0-fe46a0558719@lunn.ch>
References: <bbae1576-63b2-4375-bfe6-f5fa255253ee@gmail.com>
 <5c67b0ae-439c-4da0-bb7a-c6b03149d42e@lunn.ch>
 <3b7c1d91-7784-49d6-af2c-631c47ceadbd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7c1d91-7784-49d6-af2c-631c47ceadbd@gmail.com>

On Sat, Dec 16, 2023 at 01:28:48PM +0100, Heiner Kallweit wrote:
> On 11.12.2023 17:05, Andrew Lunn wrote:
> > On Thu, Dec 07, 2023 at 03:34:08PM +0100, Heiner Kallweit wrote:
> >> This adds support for the LED's on most chip versions. Excluded are
> >> the old non-PCIe versions and RTL8125. RTL8125 has a different LED
> >> register layout, support for it will follow later.
> >>
> >> LED's can be controlled from userspace using the netdev LED trigger.
> > 
> > Since you cannot implement set_brightness, the hardware only supports
> > offload, it probably makes sense to add Kconfig to enable the building
> > of the netdev LED trigger. It seems pointless just having plain LEDs
> > which can then usable.
> > 
> Right, therefore I create the LED devices only if
> CONFIG_LEDS_TRIGGER_NETDEV is enabled:
> 
> #if IS_REACHABLE(CONFIG_LEDS_CLASS) && IS_ENABLED(CONFIG_LEDS_TRIGGER_NETDEV)
> 	[..]
> 	rtl8168_init_leds(dev);
> #endif
> 
> Is this what you're referring to?

No, but that is a good alternative. I'm happy with this.

    Andrew

