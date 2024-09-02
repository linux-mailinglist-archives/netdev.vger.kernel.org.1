Return-Path: <netdev+bounces-124312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA1968EE8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0571F23523
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65673185B5E;
	Mon,  2 Sep 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xNNL5Yrx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB614AD0A;
	Mon,  2 Sep 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309587; cv=none; b=uPLYHBRrgpOeTGVQdApVkMKKSmIDfeWcyggpQhU0d6A51pObr683eicfe3xFpd2/tmCQCx+GKND0d5Ypvm08S5YYGm0RoEcWJlPVGvQueEgU8qj0uEWFteWwerlLN/i999aXa9gqfzAT90SRa/E5/qUGJzKurQrPUrx46kpyE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309587; c=relaxed/simple;
	bh=trpqDhvvhC6HnrvqYYZkNccfa0XBeDrTCgFemPAbVfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx7DPJCB5wlw8carF+tBwUKi1no+UgyNjThvUiCsvcVJ3jx0i5V15NJxiVB1wzkK9nXZbiqyx/7VYa64KnBqcnEytVtMmnHwOIc8ag7+syoWCe1VcvUX0K7ZvJT9GdWuycmsb4wR+pUBU+nSo53FLv6O7tXYquxGWIon95tlEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xNNL5Yrx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/CD0X/9PVFg5y9BzQ+5ua7WJJ6YEngTP0n9rU/d3Qwc=; b=xNNL5YrxC24ZsZkwrngHQELbk+
	8Ffr1J6RULAO6F7VfWkrtMaF49oaXElaISC2FxDzGymF1XOS5YHfCGjl9yfxuCxQl5ukLEevSXWMl
	Gksi3Vw8gV3sPSd/B32Ks9Y8/mIBOVHfqhjWys3B0laGTiPxSrSA3SC5TsVsWFfUBm7w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slDpp-006Kxu-6W; Mon, 02 Sep 2024 22:39:37 +0200
Date: Mon, 2 Sep 2024 22:39:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCH 2/6] net: ibm: emac: manage emac_irq with devm
Message-ID: <1b4d53d9-b797-4a4b-bce5-227efedac451@lunn.ch>
References: <20240902181530.6852-1-rosenp@gmail.com>
 <20240902181530.6852-3-rosenp@gmail.com>
 <7812014c-a77f-441c-bcab-36846a3037cf@lunn.ch>
 <CAKxU2N8TsYHvM7a_Dhu34xHbvrWev9eL8VOa1JZcu_naW3fwjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N8TsYHvM7a_Dhu34xHbvrWev9eL8VOa1JZcu_naW3fwjg@mail.gmail.com>

> > Is this an internal interrupt, or a GPIO? It could be it is done in
> > open because there is a danger the GPIO controller has not probed
> > yet. So here you might get an EPROBE_DEFFER, where as the much older
> > kernel this was written for might not of done, if just gave an error
> > had gave up. So dev_err_probe() might be better.

> Good call on that. In my experience, I get these EPROBE_DEFER errors
> on OpenWrt's ath79 target (QCA MIPS) but not on PowerPC when trying to
> use GPIOs. Nevertheless it seems to be good practice to use
> dev_err_probe anyway. Will fix in v2.

You might want to look at

https://elixir.bootlin.com/linux/v6.10.7/source/drivers/net/ethernet/ibm/emac/core.c#L2418

and then replace it by correctly handling EPROBE_DEFER.

As you said, an old driver, needing some cleanup.

	Andrew

