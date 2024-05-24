Return-Path: <netdev+bounces-98001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADD8CE850
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC611F22C32
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0A12E1F8;
	Fri, 24 May 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DmVUYB3H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1F12CD81;
	Fri, 24 May 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566130; cv=none; b=GSW9WVK2ShJpknGwiUE63N72hPv6TFzxQFGI2z6Ww9Sn+6+OvTvGV8z2JXz5ceqVvP+5gV0JsOenD8ILxOtIfD8YgdHMmQ1OSgxcmpsvj47AGgWl2GMNv8g3yxip7kTmAVl07wPui131rvDfZ2RS0aYMAHQA8jmImH66mXHczlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566130; c=relaxed/simple;
	bh=zbyfZX6Yga2Bf8bLCvb+bQFlpjWOy0MIq9OjBAmJOiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR0HKR7BxNLYLMtX149MVduH0XZKVEjC5yhdBVAvck9JIjvQyAntv9jH0+s4KLfu6/sx5CuD1wVLwIyuLFTj35oNxKMCX4bXLPHyi76EsJBm4XMV0iM3ewgVq94GMgTkrLI10iy4ttXr+O5QRqW4AAky0+u152/1mZkCTHTm3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DmVUYB3H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b0cNZSS7qsIL3jfLsIaauMYSwAyrlh2OnI7WJcM1lcs=; b=DmVUYB3HfEMWzTXJ4t9hv//EPh
	YL1lLJZtGKm0xmM/7/bRtHTVS+pJP5ndOYairHHtl2VJpLQnLb2kkl4Ztn4+6Hv8hVx3DqtS7JpCD
	neEgX4ADUmSOB8OgDt1FW/aALz7ffhWul/iZK1XknLbNvKeNEsAUPZLnuFxKgeN97Z64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAXGF-00FxoV-Cv; Fri, 24 May 2024 17:55:15 +0200
Date: Fri, 24 May 2024 17:55:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sumang@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: micrel: Fix lan8841_config_intr after
 getting out of sleep mode
Message-ID: <ed816a87-f4f2-4eff-b4c1-1175251d9eb1@lunn.ch>
References: <20240524085350.359812-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524085350.359812-1-horatiu.vultur@microchip.com>

On Fri, May 24, 2024 at 10:53:50AM +0200, Horatiu Vultur wrote:
> When the interrupt is enabled, the function lan8841_config_intr tries to
> clear any pending interrupts by reading the interrupt status, then
> checks the return value for errors and then continue to enable the
> interrupt. It has been seen that once the system gets out of sleep mode,
> the interrupt status has the value 0x400 meaning that the PHY detected
> that the link was in low power. That is correct value but the problem is
> that the check is wrong.  We try to check for errors but we return an
> error also in this case which is not an error. Therefore fix this by
> returning only when there is an error.
> 
> Fixes: a8f1a19d27ef ("net: micrel: Add support for lan8841 PHY")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

