Return-Path: <netdev+bounces-123262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA14964542
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D652B27EC2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB51B6522;
	Thu, 29 Aug 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3SiSgawQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4261AED48;
	Thu, 29 Aug 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935448; cv=none; b=KlFNtbI/w8YfAYmKb7lsGiSJ6bslFiYXBwk3cU+sBQZKlErIMO1rc5HvwYzuXLvC8kObkCwlWmf5nE2HyH/1rLjgnz5QWHW8Fs5qRb6pfukHVADQx5pVnodkTPe3VB3V06f80MWBoDm6kPQGnsv2XcDRLzy9bTtqQK1c3yUEN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935448; c=relaxed/simple;
	bh=kmQ5H8GpQ9AThZb7Z64Sq14B+iL6YKG8nt5xNCwt4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX7euNsODcCCrMN37gFgD1uJv9BkDNGGVeazde6QkWuo9G5+LyMUkvvq8e9FtfUL4X421loBQERtMro6IfOFITshDsEyOw6fLsYI4aq2w9qkMHBG5VbO6zOqG91JdJjsBTG2HrcIg9ajb0VAQYl8HPF09aUJogw4euZ7m1oGC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3SiSgawQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Of0pRpVC7r+22aF49u6u4Qqa9/5GKIrskiwj0PoVtq0=; b=3SiSgawQGgKE5NEvT3nyW6yPr/
	qXD685UmZvTZnoKmezrZk5PaGzZjNCcylw+U6i4+EyIwNNLzDSVwx3pj3njoXayglQS6XIiz0goES
	nMcOibjxm4qrlPtLTEreyiOdz2+vDn8b+6D57tvKnmbYap0iVGC4YfvjVXo0Fs1/Cm+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjeV0-00623A-8j; Thu, 29 Aug 2024 14:43:38 +0200
Date: Thu, 29 Aug 2024 14:43:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 00/13] net: Simplified with scoped function
Message-ID: <25cef928-6b26-447e-8106-77db0aa5954b@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-1-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 02:31:05PM +0800, Jinjie Ruan wrote:
> Simplify with scoped for each OF child loop and __free(), as well as
> dev_err_probe().

I said the for_each_child_of_node_scoped() parts are fine. The
__free() parts are ugly, and i would like to reject them. So please
post just the for_each_child_of_node_scoped() parts for merging, while
we discuss what to do about __free().

    Andrew

---
pw-bot: cr

