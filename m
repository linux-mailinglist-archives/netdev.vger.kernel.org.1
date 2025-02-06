Return-Path: <netdev+bounces-163580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B62A2AD2B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF4016C847
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C231F4191;
	Thu,  6 Feb 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pVxexP9I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAD1F4176
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857523; cv=none; b=AbkSXeXvLeMeDWc868ltXZUqIoLgdUY+F2sI5ijb1eKDgrOwx35fXUXZemqAUO+jSfIkoCZVjQbFCC798lAiYMJ1RIMT7X1YgSKhxY6U4+SgMClo8lxSNgVCOTETx8P83nThhYzw9iexA0u7GDIup394Cv8eydUUcGK2ICEGT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857523; c=relaxed/simple;
	bh=mqhqUV1rBXLBdOzegl0IpKB/MstejgGFoOz4PVeTmKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+E2zUw8m67Gq6VSGnDX9zhn+FPTV9/UQ7gKBittk9fnfr1IjfVxiw3sH4ZmEuTsufg/OGKqm6RLJwNEu30Rk30terrTskAma+7hGx6dOU+36+wA2rp4O2a8OQb94W5nmhd+sM3f78rPjtBReydQKvn6JdvMekrwk0rb3V71o3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pVxexP9I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kLROoyAHVOFkXVT7KlVb+bmp9j+P3DhuSKFlQ1xg7eo=; b=pVxexP9IgjUDKZkcKopBWmjyEr
	AMVcoOjnwx6N9cIH9VrVnxiIMmsk+FYngpAw4U3nYDl61fLOp/W7mSOlFSHELhPo01306ZCoX8aHz
	YC+gAldfo0O3LHKwMeHwWOV7wufnjJUrjRmjDDOVbmp2ypqFuFHL7r3WG/f0ChI6J+ZrUAMkx13qJ
	4r8t9ma5gYw3v0M94KqszSJrk5o04MgdejQ2SDP7rPpy9TNTnalbIAzkrXTOGREUUxdKyy+hCFI/I
	9tGBmMBCatGr2X2RBSjfJvFER/Oml2VA6OWvjtCntyNBf27EtAoONVPBUipzWk2pd61PlNbPUwu9h
	pdXo0B0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tg4Gm-0002gd-29;
	Thu, 06 Feb 2025 15:58:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tg4Gf-0003XZ-0p;
	Thu, 06 Feb 2025 15:58:17 +0000
Date: Thu, 6 Feb 2025 15:58:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: dsa: mt7530: convert to phylink
 managed EEE
Message-ID: <Z6TcGRaYV08IoFtC@shell.armlinux.org.uk>
References: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
 <E1tfh3R-003aRS-3M@rmk-PC.armlinux.org.uk>
 <10de11cf-a443-472e-aaec-df9e2ed54090@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10de11cf-a443-472e-aaec-df9e2ed54090@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 05, 2025 at 03:42:30PM +0000, Chester A. Unal wrote:
> Hello Russell.
> 
> On 05/02/2025 15:11, Russell King (Oracle) wrote:
> > Fixme: doesn't bit 25 and 26 also need to be set in the PMCR for
> > PMCR_FORCE_EEE100 and PMCR_FORCE_EEE1G to take effect?
> 
> Yes, but only for MT7531 and the switch component of the MT7988 SoC. For
> MT7530 and the switch component of the AN7581 SoC, bit 15
> (MT7530_FORCE_MODE) must be set. The MT753X DSA subdriver sets these bits
> accordingly at the setup function that pertains to the specific switch
> model.

I'll remove the comment in the commit message. I also note from
patchwork that I need to remove lpi_timer_limit_us... so v2 will be
posted in the next day or so.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

