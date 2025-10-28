Return-Path: <netdev+bounces-233482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62EC141F8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04401983E62
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA413A244;
	Tue, 28 Oct 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gJi84TZA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB421D3F8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647731; cv=none; b=e8ErmS3I9BHgtYyGaLCwMnUrZ3Hao7Voo1okQQ5GFU0hNDsiec+p7aBTravE18gudRgrU1k00x8riFUImO0+GpU80t1kDYkFuHclilJ9v62RCFvpy/gNM8ConEwccsiAb2W+FWa99rdn7ksKbPFnZ+3+S32fins8rNzs9c+1D0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647731; c=relaxed/simple;
	bh=37j6Sr/ADCNKJ2W9ZTuM+vo/clhFfG0EN0rSE2Lhd/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU5d2d5adCsDoxWU/hd85N6r2726gWNvrRhgjR36mrVAiTNL/++IZP3KnNsANICbnLyBY+VjPJEgV7EsKDSruR2TNzZ/hNSHxNetQZfZ4TP+q6mMihhzFGMAdqajwX0zBAgUDZkgEg6fj7SeINtGLGx2Via53+rrxB+MmYIo5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gJi84TZA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7HIcXgRn4F/ZV4CqVmuIzaxh6G+n/mevlVZ22fTlXFc=; b=gJi84TZAGLfLo0NYavISvKgFUX
	Qv30sQmkW3RmiPp+TlkX9LjRD7O9xBorYxG8MfLh+6L0bmCKgpIgKxlCX8+1UeXuud9NzAz1+6I1p
	1vpRv84Dv2MCo2NmnREhrDSelsTpEAk2JRpRuJ8KzY3z2EIprzeag8An4O3Nzt+8WoMpirVrBKz6e
	zGxX/OYOgnHPjV5g8Ap8ic0ubT8iX0NNl5ophPzAxs5zKaf1rNy5zFmQZk61WnBWfMA3whi9aEfJW
	CrZo8/4G4YTk68Kjw54uHCDQhM5e2upsg+dg7y1nITG0flqjGU5ldiw7cFY/XgsaygykhVRunSVkf
	8zi9L2YQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41302)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDh2f-0000000033x-2aUs;
	Tue, 28 Oct 2025 10:35:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDh2a-000000006U0-1mOG;
	Tue, 28 Oct 2025 10:35:00 +0000
Date: Tue, 28 Oct 2025 10:35:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis Lothor__ <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: add support specifying PCS
 supported interfaces
Message-ID: <aQCcVOYV15SeHAMU@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
 <604b68ce-595f-4d50-92ad-3d1d5a1b4989@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604b68ce-595f-4d50-92ad-3d1d5a1b4989@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 11:16:00AM +0100, Maxime Chevallier wrote:
> Hello Russell,
> 
> On 25/10/2025 22:48, Russell King (Oracle) wrote:
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Maybe this needs a commit log, even a small one ? :(

Thanks for giving Jakub a reason to mark this "changes required." :D
I'm not really expecting this to be merged as-is. So why didn't I
post it as RFC? Too many people see "RFC" as a sign to ignore the
patch series. Some people claim that "RFC" means it isn't ready and
thus isn't worth reviewing/testing/etc. I say to those people... I
can learn their game and work around their behaviour.

Yes, it will need a better commit log, but what I'm much much more
interested in is having people who are using the integrated PCS (in
SGMII mode as that's all we support) to test this, especially
dwmac-qcom-ethqos folk.

The 2.5G support was submitted by Sneh Shah, and my attempts to make
contact have resulted in no response.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

