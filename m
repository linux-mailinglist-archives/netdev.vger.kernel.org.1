Return-Path: <netdev+bounces-130353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF998A233
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E821C2262F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955619005E;
	Mon, 30 Sep 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D6ovWNo2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2818E35E;
	Mon, 30 Sep 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698720; cv=none; b=BPbEnLC6jt/tr/F9ktXZ57bjlnirYAVrafGs81snBor2L1zW9TU6oFbnHyt5fMkUsHTvTENHm6eOGLaBe0xGwxuDw/VdRZ7O1Rn5M0b421msMwWC65Yu2sXAyvBR55y4yTXaBtUp+eafYpGAni2hhih5iLkpl4Fw8pOLMTem7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698720; c=relaxed/simple;
	bh=guHMbWaEEdPVx0Pw4VLIbA5GQWnfmm1gXeQcnd5Z7zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrUDbL/++7mcJfhb1x5e8F26ZFHd766fRBmCyw41E0tVe1VjmU0YT2WM5C4VvGBw74t7vwVZIgGnl2vcx+E7B9RjumHpG5H3FGIF7YM+0koCes05Ht2w6UmW6ZpqVnC/js1kAQIh3t8EenVmd6K23evzoKXaflbO7CAu4cN25cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D6ovWNo2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=06QZSKwqhwLTUNoII8XtuXX1x9Gml0lTnBP3QfC7rd4=; b=D6ovWNo2Yekt8CCyNeE4+XpUJR
	ScMzyIaQubyccMoVMhYdRyjXlqulw7yrPFkssCHc6Ax6uMkSjlTRX0E42flfHFXxJx3jbpii8gdsz
	gNiTOWjT99XjIq79qX2SAvZmVLGdjj7UEHj9iC1Y2BnM6SkYv+L4zV+ShTAz/J4KSD4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svFMA-008cD8-S4; Mon, 30 Sep 2024 14:18:26 +0200
Date: Mon, 30 Sep 2024 14:18:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
Message-ID: <262e7702-68aa-40c9-aa2a-60a18b7f747d@lunn.ch>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
 <20240927010553.3557571-3-quic_abchauha@quicinc.com>
 <20240927183756.16d3c6a3@fedora.home>
 <048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
 <20240928105242.5fe7f0e1@fedora.home>
 <ZvfQw0adwC/Ldngk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvfQw0adwC/Ldngk@shell.armlinux.org.uk>

> I think this is getting overly complex, so let's rewind a bit.
> 
> I believe Abhishek mentioned in a previous review what the differences
> are between what the PHY reports when read, and what it actually
> supports, and the result was that there was not a single bit in the
> supported mask that was correct. I was hopeful that maybe Andrew would
> respond to that, but seems not to, so I'm putting this statement here.
> More on this below.

Yes, i did not really realise how wrong Marvell got this. As you point
out, it is more wrong than right.

My thinking with calling the usual feature discovery mechanism and
then fixing them up, is that we keep extending them. BaseT1 has been
added etc. If a PHY is mostly getting it right, we might in the future
get new features implemented for free, if the hardware correctly
declares them. But in this case, if it cannot get even the basics
mostly correct, there is little hope it will get more exotic features
correct.

So, i agree in Russell. Forget about asking the hardware, just hard
code the correct features.

Sorry for making you do extra work which you now need to discard.

However, please do keep it as two patches. It makes it easier to deal
with regressions on the device you cannot test if we can just revert
one patch.

	Andrew

