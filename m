Return-Path: <netdev+bounces-135648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B602599EA76
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84A01C22617
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2EA1AF0AF;
	Tue, 15 Oct 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iVDHgLOS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BC1C07FA;
	Tue, 15 Oct 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996880; cv=none; b=CSVJ/SuvBqpqev/6AGBKssV+tnAgrpSF9WV05uvpaobo5fTn7RptE4KIt0M9gRg+2CHbeChdulstj/SosomkjncO5B0om2OAF0ecTX8eZYebO2AJ62S5DZt9lpcIjKFVXVQ6eMwt6lPIAwCY3i7ZEPcAK0qYHvArmRyKg9ydky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996880; c=relaxed/simple;
	bh=oK+G8a33qABtf0hMSDI5iwKCPFm59lWpc2Ii4qH5YkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg99SoowraWRd9b2/yEZxwm6JEtl3iYsVvMbm4m32AjjbV9CpBVZwn2qQgJ+xNxkoJLC2fmZm4j3f3rDfRB3Ly+V0rDPdYuAKlpUht9DiwRyznNC5t++/Yb/BZyY7w/Ah8PNXxLtykwQiwApamlIyEpBrBiqPplma4/n5cCQQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iVDHgLOS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9KMHHH9wy1NkUhK8b6gjz467PXF6XivpVm4tvJmq5Ss=; b=iVDHgLOSYJkK/J+OmYpLWRhUgs
	EKzrISJF7Kzsr3wd/12kzYPhhV/ia6n2/QPws/keUF4rlWitV0pZPjqJZNR6sufToFSO3EijPCA9z
	LvNLRPDl3njhHyg43KYW6Acc/Nv4btEeoJyESXaL0ehtOmz7uAadT4w7ZSK1j3ZPHIBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0h4B-00A228-RQ; Tue, 15 Oct 2024 14:54:23 +0200
Date: Tue, 15 Oct 2024 14:54:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 4/4] net: ethernet: mtk_eth_soc: optimize dma
 ring address/index calculation
Message-ID: <e67883e3-b278-4052-849c-8a9a8ef145f0@lunn.ch>
References: <20241015110940.63702-1-nbd@nbd.name>
 <20241015110940.63702-4-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015110940.63702-4-nbd@nbd.name>

On Tue, Oct 15, 2024 at 01:09:38PM +0200, Felix Fietkau wrote:
> Since DMA descriptor sizes are all power of 2, we can avoid costly integer
> division in favor or simple shifts.

Could a BUILD_BUG_ON() be added to validate this?

Do you have some benchmark data for this series? It would be good to
add to a patch 0/4.

Thanks
	Andrew

