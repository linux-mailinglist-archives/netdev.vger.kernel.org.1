Return-Path: <netdev+bounces-170265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548EA48041
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38055188CBF5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219B230988;
	Thu, 27 Feb 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c1LkWkNK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8422E3F4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664715; cv=none; b=uA9ZoSHDQ4t+tK3zBiWXQgI/tgtfOLbaQHpeDBJDoSYCLx+6AuUtKiAFn1ELLzht6uc6LlAqkPB/vkXEz8yiayffrPTSeDzGyrA+9ZGAPtxjv1rc5FgzEaqu95OMmqG5h6Cticx6MUKs7AlvTDsxY25eQLX/KVNBLLyZcwU+AiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664715; c=relaxed/simple;
	bh=aI3NZZH8f0C3hIdXdsw4sZf/E/cpCWrPjbNG7K0zB3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4oFu9vAxDRVpPISEuo+j4QVCsfZh4xjiHJ6xOOMlhpLhgvcI4Pu47/SuztCzTpsUlRNlcW3PS/64+HU9Nj5jM/VAKRLD3w0Wbm1KkpVOqBv6IjzfpG35qrqCYCfbut9OqbrlZKwj6ei5B+q6ZTL02JGqdGLoxYMtH4REmdRL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c1LkWkNK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c34I4x6KkJp5PTehFXusG5u5mZnXC6pLusYONeJoxNs=; b=c1LkWkNKrs5QLSgU0Pf1NLvWaP
	5CEyQM1wIblIl/VcC85lTY1hoxlX1K25K70tO5aCh1Cy68wisbgjaDebk9B4i+hU7kXRo8fZwJXQ9
	ZVYf+5shMj0+UUowT4/AUJ00h9B34CBOxfZHe6mtXKn+3r8g7sdUsePGrFZNGUViocmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnePB-000bpv-SW; Thu, 27 Feb 2025 14:58:25 +0100
Date: Thu, 27 Feb 2025 14:58:25 +0100
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
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 02/11] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
Message-ID: <f7dcf21c-c43a-4474-868a-85dfec30b7d8@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0K-0052sY-QF@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0K-0052sY-QF@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:28AM +0000, Russell King (Oracle) wrote:
> Provide a generic implementation for the set_clk_tx_rate method
> introduced by the previous patch, which is capable of configuring the
> MAC transmit clock for 10M, 100M and 1000M speeds for at least MII,
> GMII, RGMII and RMII interface modes.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

