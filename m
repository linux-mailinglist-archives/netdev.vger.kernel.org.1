Return-Path: <netdev+bounces-211014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D26B162EC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22446161962
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37082D7813;
	Wed, 30 Jul 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="feokFQuQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242B2343C7
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886156; cv=none; b=NvctOq1cpRKPLOTu/01iHwUlOhKEUa2G4+YP9AKqkEuJTb2eHaH9F5cNKVoUYK3PWseqIkCPIC+nuGSEDD76C+dWYw2ccVOHLlH1jm6InWOdBvuGMQXWuO9ZrdUYBDYlnchCYZDQs2g9bxPF+qphgJc7l1JHVMdl6rtiZ6c6ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886156; c=relaxed/simple;
	bh=QCfI579vXgmsLsovnxTwy4ICTGw845EkTn4ujDVmg4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz3u1jNXnhQ3s4l5zhv5bGnMtI67GvPbmmMzJrZhnTdQ95pEEcxczixBWcVKeT/Yfcw7UIZSyCZL5YJmXV+dffZ5zoWUlVbpb27Ys6Yyd5rP8jfczyqW0uV4VeVCW06qxGTdi85+9av7sQjMya0wJXdwhh0EInapTfjyBoFCRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=feokFQuQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gvwem4OPdZ12zN6c6IL3eljJpwNtdmlW7hltxtncrFY=; b=feokFQuQEnY+wPoL5jizQkKtLp
	BGeytC6xNSBcr+PJBi59fYXk979Xtv1z0FMi8xGVy611ocCjmyTOZmeF31tS3rSH/J/B732ZPo/f1
	mRHubpgjo4fvh37ACj+s5cI6KoZT6wUI+4SIWuTkjpow+NAzOp5ted7gxop6+2ndi4vw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh7uD-003HqR-On; Wed, 30 Jul 2025 16:35:45 +0200
Date: Wed, 30 Jul 2025 16:35:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Message-ID: <2842a6b1-ba65-4f7c-8699-aa2fd3de85b0@lunn.ch>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
 <aIoqvaRk3lL1Zeig@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIoqvaRk3lL1Zeig@shell.armlinux.org.uk>

> Not all interrupts are capable of waking the system up, and there is
> no way for a PHY to know whether it's connected to an interrupt that
> has that ability.

I was wondering about that. And maybe that enable_irq_wake() returns
-EOPNOTSUPP if it cannot actually wake the system? But there is no
documentation about that.

So we cannot trust it, and "wakeup-source" is needed.

   Andrew

