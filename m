Return-Path: <netdev+bounces-232785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D03C08DBB
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2CA24E1026
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833F1494C2;
	Sat, 25 Oct 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l1fpE7eN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B429405
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761379389; cv=none; b=ftVz+HFroM+xpcXoYUo7u036RLN1s85WpZRlGBcSGNc2YCPOMum77aTtkBv9dS/Rwz88CtSt59fQUx/X/EluXbRsp88FDqbxgpAeEik+DdEcrV2GnrNbGDQfMsnoIpEuldVbqlTflRw1t9IFZViL4R4xLRo29OyA7L1VYDlbhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761379389; c=relaxed/simple;
	bh=MB/qKKh6Y4N/T/0najGuKgJUvpEJkZDCaCk/VRhr+X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2G7Lwmi2FExcmYN96rgl3oqEkHl4e4Sn1zgY9Ofr6pcgaUeaJt0XUH2VLNjV6FPeOTkd5hqeL/UX4y+GUqRuga+eJ44Fp5we1V9e3jtDE+w2lDIV6fKRinENruMIRpAXjehTwRVNMMWQF7hYj+Hu/688gU/J+LtWTbN67Z8tiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l1fpE7eN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DiTcJgJML7VPWotE97Q4MxQQlpiwpQepFZOTkMMNb1w=; b=l1fpE7eNDN2Pio1MCdPSCLkAQq
	IqiddzouUUi+vK/4ATK6jSRXOuBhK4+IxdbhyjzslRPAOc5MrxM5kBBrK2IKdBJXX9CV1i58mxy0F
	mJQAddngLfempOQS1thJHdfCr3LPasqIvdT2EmI19meX+dMAd3Pm1xvLge6sg2LSjhmuEm+bGnAjc
	x5Q0IRoumx6GNBj6hJhIN6N9WAtch3jgY9jw0fGUtxYN4Gs3Av9NclVjzsPZytRW6AzbQKYIxvmGo
	JuIEDi4KXIKsKKK0o5ONByXkO/3Go4Kby0H5Gtqld5zDiqjDCMHh2tUDUSvWY0LeTP+NWwtlGODqr
	wU7Bo2Ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47732)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCZEh-000000008P1-2JUj;
	Sat, 25 Oct 2025 09:02:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCZEe-000000003Vi-1fyn;
	Sat, 25 Oct 2025 09:02:48 +0100
Date: Sat, 25 Oct 2025 09:02:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: add stmmac_mac_irq_modify()
Message-ID: <aPyEKGCeXwnsn4OC@shell.armlinux.org.uk>
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
 <E1vBrtk-0000000BMYm-3CV5@rmk-PC.armlinux.org.uk>
 <20251024190159.60f897e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024190159.60f897e5@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 07:01:59PM -0700, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 10:46:20 +0100 Russell King (Oracle) wrote:
> > Add a function to allow interrupts to be enabled and disabled in a
> > core independent manner.
> 
> Sorry for a general question but I'm curious why stick to the callback
> format this driver insists on. Looks like we could get away with
> parameterizing the code with the register offset via the priv structure.

Not quite - some cores, it's a mask (bits need to be set to be disabled).
Other cores, it's an enable (bits need to be set to enable). So one
can't get away with just "this is where the register is", it would need
three pieces of information - register offset, type of regster (mask or
enable) and then a core specific bitmask.

> Mostly curious. Personally, I'm always annoyed having to dig thru the
> indirections in this driver.

Me too, especially when it's not obvious what is an indirection and
what is not. There's the fun that a lot of the PTP-related indirection
actually has no difference. For example, at the bottom of
stmmac_hwtstamp.c, the struct stmmac_hwtimestamp initialisers have
almost all of the methods pointing at the same implementation
with the exeption of .get_ptptime, .timestamp_interrupt and
.hwtstamp_correct_latency.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

