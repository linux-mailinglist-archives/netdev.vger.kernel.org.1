Return-Path: <netdev+bounces-155524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C4A02E37
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD941885F48
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9881990C7;
	Mon,  6 Jan 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gzbu6GTh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A573176
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182174; cv=none; b=RUeoBMWU3Y3EOstRSnlZHWNSP/Rn88AH+AQf36LsLqY6arcNImE+ISperrDrp8ukg7o4nwzcsMc935LHEkdZewGEZHqJGc/9814tSngL5OUN8kQkzEaEnsbtXXTgnQQaDIGHIM31HjkdOk7kaJiwj0xnDcy1dzVNCh71IkYpniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182174; c=relaxed/simple;
	bh=y4+rtQeiCQUM6oCN5yrzXoGsZUUukrO0p7JSJRmtTY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSQqAxiHj7p0cKCAky4MOfjfc1AUQ+AfJVZCo7QBK97qT/g4rk6RWqRClSxoK2L+3slnOL/oqg2UFHSh+QimugGT7kkQbpvBlkSII3W22DPizNhVt6fkkALABfv3EgkUCKeJr0XpIrQydNPXoZbZODk8ufrxF5UvFYAkox3/ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gzbu6GTh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qna5S093nBbRkl20/MOVRPodP8BDCikiUJuROyhXVgI=; b=gzbu6GThbiT1OZ4tfL4yvjvSKf
	mTUjX5xfuWPGLoSDw4ewW8YQDy4XTPD5JVHgboHzTQdO73hMlgpiXwh/oNGN4gSAYDFBqUL1bliOl
	6Iobp8uc+VOR8Bh/zjVK64ZDPdhF8Z2YiVvB06QFtk8kAHiuOfcBhW825t3oTEsZ87+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqI5-001vyd-ME; Mon, 06 Jan 2025 17:49:21 +0100
Date: Mon, 6 Jan 2025 17:49:21 +0100
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
Subject: Re: [PATCH net-next v2 05/17] net: stmmac: remove redundant code
 from ethtool EEE ops
Message-ID: <1b9bf0ad-a929-45b2-901a-b997d7686dec@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAP-007VX7-5s@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAP-007VX7-5s@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:09PM +0000, Russell King (Oracle) wrote:
> Setting edata->tx_lpi_enabled in stmmac_ethtool_op_get_eee() gets
> overwritten by phylib, so there's no point setting this.
> 
> In stmmac_ethtool_op_set_eee(), now that stmmac is using the result of
> phylib's evaluation of EEE, there is no need to handle anything in the
> ethtool EEE ops other than calling through to the appropriate phylink
> function, which will pass on to phylib the users request.
> 
> As stmmac_disable_eee_mode() is now no longer called from outside
> stmmac_main.c, make it static.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

