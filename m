Return-Path: <netdev+bounces-243827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB4CA8363
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6463D32CCE1A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BC357735;
	Fri,  5 Dec 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I/au80bu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30435771D;
	Fri,  5 Dec 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947882; cv=none; b=oOql9pxnkP2VcVtu10j/db0kygHEeogqJSkBV/teB026Z3xTFG7P+LX0V6Nb6vQToy7eGXFcWQzoXxsTjSvd5DSr3mEohVDT8z7pY9SyWajCsCMzr4PDDzUTOzaxhzmLLpXd47YVI9sfcmzbbla9JEyn7TarfceIVffRp4NM2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947882; c=relaxed/simple;
	bh=NpVU/zKKDmD1Y1Sgo8F2AIDoFxcRIYui67Wsv1F9Zxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvoBv2a0174r3WkxpJh6FjDS5Ko5s6i8yV/NetsDQfdg/jheiYLdixaanapChD0cEYErztO0oxmTQGlW9kCMbC8k0DuaDVkrRDngHR5jRVckK0P7OW/MpoaFtJAJGrpAr69u7i5gOw/PjJzfvWZyEXCUg4ashqvP/x5VxVY1CfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I/au80bu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aZPGFcTfZwX3shaY+dtgLFmmWoU9zYhXbIJG4r/K8so=; b=I/au80buY2RKqRSbvVGoiL/FwG
	sYlcah6QZwC77C2Wq7EAuLaWUjg4g+zyGGMFEi54Y3fDV4lxnE3iIUzpFFNzU1jyhMW+mQVdG+KqK
	GiW+/X9ytY7e0v+BIIWVaGG9yUutOOVcf6RfaiXI13CXQnyZ/xBaEUMmdZkX1RTTuq0E4DPlU4JYr
	cAtcVVryXchL+khDZK3yT9G9Es87RVmSYI7BxFSXEwvcYRdl/JI36hp/84n9Avi3I7OoK7l6rlKP4
	4vj0YvmEuzCIkf2oQNAPPxNzXONRz74Pn1vfAvODq3D1xL5+EdARoUAXR9/dGuVp7u51KiEGxa+y2
	BKj1Jkgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRXZ1-000000004m5-0WDS;
	Fri, 05 Dec 2025 15:17:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRXYv-000000002DA-1ink;
	Fri, 05 Dec 2025 15:17:37 +0000
Date: Fri, 5 Dec 2025 15:17:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTLkl0Zey4u4P8x6@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > remains set, preventing auto-negotiation from happening.
> > > 
> > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > delayed_work emulating the asynchronous self-clearing behavior.
> > 
> > Maybe add some text why the complexity of delayed work is used, rather
> > than just a msleep(10)?
> > 
> > Calling regmap_read_poll_timeout() to see if it clears itself could
> > optimise this, and still be simpler.
> 
> Is the restart_an() operation allowed to sleep? Looking at other
> drivers I only ever see that it sets a self-clearing AN RESTART bit,
> never waiting for that bit to clear. Hence I wanted to immitate
> that behavior by clearing the bit asynchronously. If that's not needed
> and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
> be much easier, of course.

Sleeping is permitted in this code path, but bear in mind that it
will be called from ethtool ops, and thus the RTNL will be held,
please keep sleep durations to a minimum.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

