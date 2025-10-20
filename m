Return-Path: <netdev+bounces-230993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C036BF35E6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 184AC343479
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32382BEFF6;
	Mon, 20 Oct 2025 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LoPgIZEq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B0286D63
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991551; cv=none; b=WpMjfM6jUCLe2z7gPvvuX9pYFUEEd09LjGG5ghCVu6qwep+ljDwifUsv2saKXol7cQMjHJa3ao20KTr5MrrUjJMr5EGMsO13+0yHVBmk/n9rpiEABySloIcblooFipU/0Q2+ojDHpGfPKN+eZ1Wa8CCl3rmFuMKsoE/l/QjFS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991551; c=relaxed/simple;
	bh=ECkD/COUdATOLfifOY0DBOlsF5GRmkj1zsRtxkiNMaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8AVynfVmQwDsYpzuoLTKFM2EG/MLLODUSuCQki5fvtBdv+9XVAFv0JwYzUXf5B0KCr71AzXabTipBO6WsdGfEhXTSZJvZvwdnYdIFOrkYA9XXaoQ0yKKXRZ/TNOSsGMeukdXhGhsAy5wxwTwnw4j+/d6SRXhe3eLdKiCnnbeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LoPgIZEq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lq33/SB9yszKZ/NnTc+bw3dXwj2tLUhEoeBkhpaRNmM=; b=LoPgIZEqx1mtnnRcOJlR+fysLH
	U+OrRpMdPla0zCzMQSrHgUH6gudP3khM2DUAIb2PLjWROFJqzWozL3nvNxffSasPywPgQlEVtnFjX
	pEE+w67DqXXFhlPjuO5lzSCBBsJgksHO3Qszl2iQ5rWCW4+V4hIuZpJts6NdV9GvJ1Sk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vAwL4-00BYTv-Uo; Mon, 20 Oct 2025 22:18:42 +0200
Date: Mon, 20 Oct 2025 22:18:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: remove stmmac_hw_setup() excess
 documentation parameter
Message-ID: <3356c601-f3e6-474c-81d4-96bea3e86659@lunn.ch>
References: <E1v38Y7-00000008UCQ-3w27@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1v38Y7-00000008UCQ-3w27@rmk-PC.armlinux.org.uk>

On Mon, Sep 29, 2025 at 08:43:55AM +0100, Russell King (Oracle) wrote:
> The kernel build bot reports:
> 
> Warning: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3438 Excess function parameter 'ptp_register' description in 'stmmac_hw_setup'
> 
> Fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 98d8ea566b85 ("net: stmmac: move timestamping/ptp init to stmmac_hw_setup() caller")
> Closes: https://lore.kernel.org/oe-kbuild-all/202509290927.svDd6xuw-lkp@intel.com/
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

