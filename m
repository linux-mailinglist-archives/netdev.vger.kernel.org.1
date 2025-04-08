Return-Path: <netdev+bounces-180439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A91CA81526
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D877A7B624C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9256623E359;
	Tue,  8 Apr 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dzeR6h+D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD24230BF9
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138610; cv=none; b=T0ANEyx5cK/RwydoJuLnnlWfly2+xftWsoIXOFw+dSfEJW9gXhj8RH78/mKNoTQDUROpjUXAIXC4Cw8Yit93nrY0fofM1fc5sFAb8nTFbRDfjKN/HOfSZzqD5uQKFdUIIGsmlXajIIjPXyTFOsYzO5UJVoY4OCp7Re/dZCoMMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138610; c=relaxed/simple;
	bh=1yxidxolRSL9zXpBgO5mLgne0BzlCyoF4goxXritEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK6zXV5xpkgxXk0DglJ/2a+/SMj/Cm2zMmbjUrH3xtM6MiKDtF7wPIynYa6Hqnsr8OtM7iedwZmygQgY+yhRzCiVTmFjYxwxs34RnqcycGQV2hRY1thizW/+CCzdNB2KiM+9ZJ0yZf0JAgIXGv2AHZyXSDSJ4P4vjo2l78ZaWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dzeR6h+D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8crQoGFjLWEj4q6o0Bneeo4CWNa5+XlpQvMdv/3ao0o=; b=dzeR6h+DY+XQ9DTSdxCfcDApK+
	4bHLC677M7yfG3UnQ4g/AjsdnNpfT/9uatPZwSSIYIqHKiXWorIqYt6xzaxGXDvZx26BnqDl/T0WF
	S45k2uJ9xZGB5gt2sdMnvw5iWs/xzEWWS1JbiQXqvGaiDDt7XN641exj5Pc+R2uL500I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2E7c-008RFE-Qy; Tue, 08 Apr 2025 20:56:32 +0200
Date: Tue, 8 Apr 2025 20:56:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 1/5] net: stmmac: dwc-qos: remove
 tegra_eqos_init()
Message-ID: <c28aaa03-b2f7-44a5-9025-dfbfa0925ede@lunn.ch>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
 <E1u1rgJ-0013gd-2q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rgJ-0013gd-2q@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:58:51PM +0100, Russell King (Oracle) wrote:
> tegra_eqos_init() initialises the 1US TIC counter for the EEE timers.
> However, the DWGMAC core is reset after this write, which clears
> this register to its default.
> 
> However, dwmac4_core_init() configures this register using the same
> clock, which happens after reset - thus this is the write which
> ensures that the register is correctly configured.
> 
> Therefore, tegra_eqos_init() is not required and is removed. This also
> means eqos->clk_slave can also be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

