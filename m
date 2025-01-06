Return-Path: <netdev+bounces-155544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C754CA02E9E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CEC3A1442
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B1142E7C;
	Mon,  6 Jan 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gD/nQUT9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC038F9C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183271; cv=none; b=h2HmidTm0ks4GMe5r+NvIeK35a70/5PQTlJ1dmc2VWwkHvMJ5LYVeFfEY2E1lEltiCHfMOlzK1ouN3PKaknaQU1bKZFBtzdonmLPfpwyTA9YJwrVZV/Tdzu34M1aaJC68x6iA4XEuV+NUGXdbABHNn90ckTJ7o+OqCgzDlEw65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183271; c=relaxed/simple;
	bh=bSRTCwdwFKg6P0JMRSttKJHuUOtAf4EFUUlWhOJ1GD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSKOTcfVQqGbTJ4kUyd7kMC1ulxTdZKE+LLe8twKs1NGLL8Lwj2kOrtH00AZKRGzF8OkFPCNIGL2hMSUo0OL4JrFsR0175VzmXI5XYKEn3ASZxgWSGBlMdf3GxOV9mDst31dFTdCZIyUOyv/q/i71iIUPdFhADt4zaPqP2GiGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gD/nQUT9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mADUhzsEC0DSAkZRvhyikjiPCGNGx2x++rnr2RtZ8RU=; b=gD/nQUT9zidMUdTqtsuAAaZiSP
	o2XuKNYkq4p/pygMLhje0ZsOy0KXzG29Yvdc40HiO1M0xxYKoC8WEbXIj4TPKT1i91gMSd8Fns9s5
	oGUlI2bw2ug63n0L0W3p8cTMDSX4GTt9a3jZ0y4x/jX6TjMoDBUy3DgtOgwc5gH61lt8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqZn-001wRk-Sg; Mon, 06 Jan 2025 18:07:39 +0100
Date: Mon, 6 Jan 2025 18:07:39 +0100
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
Subject: Re: [PATCH net-next v2 16/17] net: stmmac: split hardware LPI timer
 control
Message-ID: <ac4ca4ad-5c35-4842-855c-2b1a052660f6@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmBJ-007VYB-H2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmBJ-007VYB-H2@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:26:05PM +0000, Russell King (Oracle) wrote:
> Provide stmmac_disable_hw_lpi_timer() and stmmac_enable_hw_lpi_timer()
> to control the hardware transmit LPI timer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

