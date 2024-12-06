Return-Path: <netdev+bounces-149715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083C9E6E6C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30542283D73
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA0202F6F;
	Fri,  6 Dec 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WK2FExw1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BD202F77;
	Fri,  6 Dec 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488860; cv=none; b=j2mIBlRK5u3NnMIi13PZ+onxHR/TKYZrD2Wfo/we+FjDTMudhH33JEYiDTqx6Rkvvs9y6msJ5K6l1tPxNy/X45RvFZc9aEFUumjsst+/GfkWm3kkCdZU7oIqvGgrmaGexfgI0rC+h7j1stHFHu6Hijt2cS/feyS+xjU0uYb5IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488860; c=relaxed/simple;
	bh=Bo1Ce5zrS12XQ8UB+VM+cT4Zz0Ahi9HZno4vkERIyfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/wNGE+O+Kv+txGmxvUCyvLzmyKPHRnOvlVjsoc20sTIVp9uumuysPYaO5CBxo+zov97YDCDMxwST3N1vXR/3T/bkPjif1b7Kz4O6HBRa/EN/1KjVx8AJzbpc55DtYVaYW7h9Br0rsOe9N/Q7BWNxTXb4JFS/hULODQt3cQ4L6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WK2FExw1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=60+QdJdxKs6rZA+mdAzlD6sjzLBFb35Y3PSnzo24tzk=; b=WK2FExw1uNyzInbCva0clg0JsG
	kZEr9EIkBLryuhClWgKxoTYYDN0lYpa9z8LIJeyGAS6eKvR9OmD3Ij4ifFmT0FKtLWlQbZWgOcGL5
	VUkyvzI/WUWxwBJ/deE4lUIzj8aU9xYELZnqEwkA4LGPCy8QAtE0piWWjs3RBRHOkDauu3hrhmPhr
	e+igfTThsB4ondJhfP7TEB+pyob6h27CKOvgcRz9L9Mmcpz7O5i8JR1UTHgEAaYDI7PVTz2E5Zc9G
	nqI8LvD+CRzGY+WxpZPzOHGHxK42VxIiHebEJCtq91lNvWTw7E15ZU0P/TCGZf+zrX9aC0TmAzzyq
	Zuj3CV+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54884)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJXdf-0006Fj-2g;
	Fri, 06 Dec 2024 12:40:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJXdc-0007YT-1B;
	Fri, 06 Dec 2024 12:40:52 +0000
Date: Fri, 6 Dec 2024 12:40:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for
 non-paged SKB data
Message-ID: <Z1Lw1LzgeAyHv2Bl@shell.armlinux.org.uk>
References: <20241205091830.3719609-1-0x1207@gmail.com>
 <Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
 <20241205085539.0258e5fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205085539.0258e5fb@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 08:55:39AM -0800, Jakub Kicinski wrote:
> On Thu, 5 Dec 2024 16:43:22 +0000 Russell King (Oracle) wrote:
> > I'm slightly disappointed to have my patch turned into a commit under
> > someone else's authorship before I've had a chance to do that myself.
> > Next time I won't send a patch out until I've done that.
> 
> Yes, this is definitely not okay. LMK if you dropped this from your
> TODO already, otherwise I'm tossing this patch and expecting the fix
> from the real author.

See https://lore.kernel.org/r/E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

