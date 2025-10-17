Return-Path: <netdev+bounces-230590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C149BEBB5A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06DF04E2631
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2C1C5D55;
	Fri, 17 Oct 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jIx3YR/R"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD4354ADB
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733744; cv=none; b=XpGIUokGCPk/tjcJfqBpE8vICKgkj5YLCAD7JAsZcHifWrEFnq0IxFUo4HIuE9zUMW4AP4yogmAMqwiJaHnThnH+atLIBISaCiW7CnY5mwiKz3vl+EeCd4qr/iG2hxrWFMEo7C/sCF/EcGAsfb+4Af1ecmlDu3xkxUr6qsjLXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733744; c=relaxed/simple;
	bh=sFbZJQ3pTOxDhF5K2bdxOhPIigIqPb7j57gr1/MTorM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEV8MFhgJQXEaymgL7kjaNfHUah3TIJhtCuiVXkJQs4Ar5qNaQKG/W8lxbzI4QZRWkf+h+mDWNrG3MQ50dif7dIHanB20v9343s5rN+s16FITC0IrJCk5jSHBo0DvLLL9lZGD2BXKxHBrmDJbQZPIaRl2jfZXfW1ovevY9uiphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jIx3YR/R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KYTlym+fo1ucjYAj60r09t17SNhG7+8XDg8AZrdz7DI=; b=jIx3YR/Rd3js28Y0evF14NT22q
	4+RWWxa1w5pRxZmPGBBptjUGNT6V7VA3pTj4Nv2zdZrzhkI5vrTtB312GHSGUvjzADaAIPLWiemcg
	GKd3rPaidI2ffIHmeHshSNaUB96rf8kL5rqWGQYzz3IHjoHY92rndU0/blHUIbsqVPys=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9rHA-00BKJ0-TG; Fri, 17 Oct 2025 22:42:12 +0200
Date: Fri, 17 Oct 2025 22:42:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: simplify return in
 ksz9477_phy_errata()
Message-ID: <87a2e251-e0ad-431c-bc08-1c464d2868c0@lunn.ch>
References: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>

On Fri, Oct 17, 2025 at 12:35:20PM -0700, Alok Tiwari wrote:
> ksz9477_phy_errata function currently assigns the return value of
> genphy_restart_aneg() to a variable and then immediately returns it
> 
>     err = genphy_restart_aneg(phydev);
>     if (err)
>         return err;
> 
>     return err;
> 
> This can be simplified by directly returning the function call
> result, as the intermediate variable and conditional are redundant.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

