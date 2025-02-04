Return-Path: <netdev+bounces-162495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDAA27109
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71F1164626
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2790212F9A;
	Tue,  4 Feb 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F9LQMlvn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94248212F87;
	Tue,  4 Feb 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670710; cv=none; b=LIMk/oQUugdTwyjgPE42q8w65rFo/YPCOMYpSUFZWLkLERAB1zExsmGqIF24ypPp5pTq6druxk6r8ijTi0iTl6EZAHgF+vonRrWBgSL2I8llU3W1XKD0YL1xBDX4ttSM/YVQ0+XbMShGu0f0rEZDCiqu4KGzzPE0cxaRU2eizr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670710; c=relaxed/simple;
	bh=0OwzggrzIz8qMylr7QYGI9o9nt7oBL13kziaUND2hIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbFLb1BYQgHd17e6T2RYUYLTHaW5H5PjCA+SRvs3MSJHb+xrOgOxw3TAP0fyF8VPIb5yzsi24XMZMUUV1/69VXoEMX1vogvvg+qO7KqsAGdmhpQ/PQ8jYfiYh4Q0WYBEiAgjQq5SdjxwXBeEgDsCtm/Uyx2iBX5LirWgF7vOKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F9LQMlvn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gq2wazRAbrp185rruXLj3Ehs/Mugu8zBiYtybcRB/os=; b=F9LQMlvnrmGPgIpcbMjdaAj2UI
	XPQn5iaUyLpVHVd/20+T8l13CaXUuRN0vk2oksjffIvOfhAZFdkHQurpIeTI3L1S97CdLSdxOXBkT
	5LQZjbU7yZI0hqbJd12Vwf71Gs5ksVbNP/YIbSqAaQCCMC/QQNQz8TudeS7D6JvcZPEWBtcyev2fG
	O9/dlgBLBOYy9ZLNytH/0leqlnL239vU+9aKA9prP7hCk0x3TGHf5lJSfa6YCXk8sqVn/NkBJR2IP
	1oUff3Kv10m+TI/wUGVg3paABvvNiel+lxQ8Ia6beTuMwTrbl8UHDeEFULbfhco3cFbRvATviUyyU
	6ivrE2vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49344)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfHfA-0003Qg-2v;
	Tue, 04 Feb 2025 12:04:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfHf1-0001NA-1A;
	Tue, 04 Feb 2025 12:04:11 +0000
Date: Tue, 4 Feb 2025 12:04:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 1/7] net: phylink: use act_link_an_mode to
 determine PHY
Message-ID: <Z6ICO06RbJ1ulDh1@shell.armlinux.org.uk>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-2-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204061020.1199124-2-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 04, 2025 at 02:10:14PM +0800, Choong Yong Liang wrote:
> When the interface mode is SGMII and act_link_an_mode is MLO_AN_INBAND,
> switching to the 2500BASE-X interface mode will trigger
> phylink_major_config, and act_link_an_mode will be updated to MLO_AN_PHY
> in phylink_pcs_neg_mode when the PCS does not support in-band mode.
> The MAC and PCS will configure according to the interface mode
> and act_link_an_mode.

act_link_an_mode must only ever be updated by phylink_major_config()
since it defines state for the currently configured mode, and must
stay in sync with how the hardware has been programmed at all times.

> However, when the interface goes link down and then link up again, the MAC
> will attempt to attach the PHY.

Why is the MAC trying to disconnect and reconnect the PHY on link
changes? Do you really mean "link down" and "link up" as in "connection
with the link partner" or do you mean administratively taking the
interface down and up (which is a completely different thing.)

> The interface mode remains as 2500BASE-X,
> but cfg_link_an_mode still holds MLO_AN_INBAND. This causes a failure to
> attach the PHY.

Hmm.

pl->link_interface is the configured setting from firmware etc and doesn't
change.

pl->cfg_link_an_mode is the configured mode from firmware etc which was
passed to phylink_create(), and again doesn't change.

So there should be no difference unless something weird is going on,
which as you're talking about stmmac, could be the case.

More information needed, but as this patch currently stands, I deem it
to be incorrect, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

