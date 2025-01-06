Return-Path: <netdev+bounces-155538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6171A02E89
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9667D161311
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673681547D8;
	Mon,  6 Jan 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rvacBcgp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9B2AF06
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182987; cv=none; b=I2E9oj+OPf8XQEl1BpatmlheSr3+TH8VY3XhhAbZI+E/9Sgv1K5Je8FP8UCeaq1P6UVteSYbmglgfsncRaCbR2lh90vB4EKSaCHAAbh2tXf8vm0kNfaPtKCIruutnhL0YiNX09Q1B4EdEqoTQN4Jkt2esXxl+L/Jkou5MoKme9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182987; c=relaxed/simple;
	bh=TOjFxY45A5/M8HPnpf5kAJ0jA3NAbxG1ydeGSC4oOLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ/3Een7ZHkDZ2gCC09JBgFOOG66Pe0HdOFAs4YoOvtJDsVhUwOtAFgAvWfA6aBqgD/8RlS0yY/Fy6LVnH9ncD+bfV9eMV0y6ZTs/tnkyFpZrCQqDuV09LsocKu/m4QYITmoZ6ZSp4FAhYE6g/aOA2JylHZd7naYpzZhKjXwXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rvacBcgp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LGCnFlH8pbxIAGdz6IAVkgSGQui0ocCTD+X7bmrRdFA=; b=rvacBcgp3SHY7omBg26TDsGvpT
	bAyI6uQu/tRRL5YNrJMAyTClVw7j5FKNINiPvIIOLpAbHcnWrZ99StHqzYeQJw4/BbjBjeqLyQrzR
	PUifrZaSskOuyMuq2QOrgXgicNIWFYPkA5cuXsloa5ZChfgXOGohgxT7nrK0uRW0Q1aw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqVD-001wIc-LP; Mon, 06 Jan 2025 18:02:55 +0100
Date: Mon, 6 Jan 2025 18:02:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 10/17] net: stmmac: remove priv->eee_tw_timer
Message-ID: <463c0ebc-629c-4597-947e-57cab60fc45a@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAo-007VXb-Pg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAo-007VXb-Pg@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:34PM +0000, Russell King (Oracle) wrote:
> priv->eee_tw_timer is only assigned during initialisation to a
> constant value (STMMAC_DEFAULT_TWT_LS) and then never changed.
> 
> Remove priv->eee_tw_timer, and instead use STMMAC_DEFAULT_TWT_LS
> for both uses in stmmac_eee_init().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

