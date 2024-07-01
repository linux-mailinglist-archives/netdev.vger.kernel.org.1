Return-Path: <netdev+bounces-108202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582591E581
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1B28128C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468616D9BE;
	Mon,  1 Jul 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0rtPCNzx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751016D9AB;
	Mon,  1 Jul 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852035; cv=none; b=s57wvG9vQ2f4kizdws6oMbamC4Tt3e5WrSmU1SB9WrIcS/CNKOr474pEf+Sw7qF4HBfnSAjz3315DoXjPDRF3wDI4ZMlueEuUfTo0X5VTcADIRfluhV3Qt2T11ace+QiCPM8w9MzpHp7un6gOMwiUbEErJlOs/Y9xrxAoxygl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852035; c=relaxed/simple;
	bh=InQxmdhcbdfStQupraNJHb78LhJpdvpvopFz87PBFRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcbEGiLgBvE7tn8v6X8YdUXWeZzyFOhjAKgaprLXy0H1i+5Ne6ZS1OVnIRKhtnm8CgirKiUSCrh+IVX20FGVD+pHcBFwMsZacEO4WxoVRtMG3+Tkve50FUn5IyELJBb/e9o6O9E3yXK3CX2KzxU4cEzUX7g3MNKL6UaOXIytLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0rtPCNzx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9XVDAay2T0LhiNCcdccMadV7DGJ/vCEpdZXpqYEeP0s=; b=0rtPCNzxa/DXGjv0dhO/ArY4FJ
	EwXr8+pHClbKJgI5B8V6AXqD6OMDtEAhSZQm6G1kNkVdVwOXNe/SCK8WRmxqz297iHFPkchjXAraD
	VUqGGWs3kZqUnZvzAFZ7FufftydCZ8oZqZMtNM1pXXC1pjaojn2Fp0r8Jffeu2Oa0sfU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOK4m-001YxR-Ow; Mon, 01 Jul 2024 18:40:24 +0200
Date: Mon, 1 Jul 2024 18:40:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation
 in RGMII/1000Base-X mode
Message-ID: <a244ce05-28a1-47b7-9093-12899f2c447f@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-1-a71d6d0ad5f8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-dp83869-sfp-v1-1-a71d6d0ad5f8@bootlin.com>

On Mon, Jul 01, 2024 at 10:51:03AM +0200, Romain Gantois wrote:
> Currently, the DP83869 driver only disables autonegotiation in fiber
> configurations for 100Base-FX mode. However, the DP83869 PHY does not
> support autonegotiation in any of its fiber modes.
> 
> Disable autonegotiation for all fiber modes.

I'm assuming to does work in copper mode?

    Andrew

