Return-Path: <netdev+bounces-198324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682DADBDA8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815DC3A1945
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F701D88AC;
	Mon, 16 Jun 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HkhcwlJ2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF714C5B0
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116592; cv=none; b=CtriGc9ofXTWEXvwLK4qnasI7uVAJ2mfeG+zztkwSENWr8vBBiYnxd5v7Zd+PNMX0op487xqarH4s1GLIsZ8GLCN+LYWvkeXHBReoNNZMqZ1KS3nfw/PjQlpd5vYefrs32ykXt4EwkrtcD7twXbZmhbr45KNEuYWuHlK9lfLcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116592; c=relaxed/simple;
	bh=PemuZRAtyO2CbsktkjvOwdgi8yKF35M9LYQtA0ZFUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXWJGMrucGdWhFZZmAjYsBGlW0Ug+Uc0V7h+R7Vnt93IB0yigSyS1hoYHS3tzk8vYV9D6534vfTxZMR1+DiIQWUoZjGjcQo1SO42odQG/HOt7PD7jwCxCSJocBRjEZYlYZZfdk49JLVQxybkA2JCgwjWPVgQZfInLnhppNJZoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HkhcwlJ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FVcbYWYXxlHhyK0doa6PNKnr9E0V20/rYQFMEivhkRc=; b=HkhcwlJ2fE8wFtSTewIMv8l+sT
	JrYCdX4nE3BcpgLXAWZH7wvFic9KEPF+jcyr5Kk8huRJphEoqoctTHEMMeREoYFrA6R1FjdQISldY
	hy4MMkgHX2eOJEzHVPoMkZCTrkURHHAueSF3R/NtPcfNsQiKc8bzM+OYUbuLuLBzTMdc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJGb-00G6QV-Jt; Tue, 17 Jun 2025 01:29:29 +0200
Date: Tue, 17 Jun 2025 01:29:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/4] net: stmmac: visconti: re-arrange speed
 decode
Message-ID: <75bde139-9232-4fd2-9d64-92f8d65f5f1d@lunn.ch>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
 <E1uRH21-004UyG-50@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uRH21-004UyG-50@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 10:06:17PM +0100, Russell King (Oracle) wrote:
> Re-arrange the speed decode in visconti_eth_set_clk_tx_rate() to be
> more readable by first checking to see if we're using RGMII or RMII
> and then decoding the speed, rather than decoding the speed and then
> testing the interface mode.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

