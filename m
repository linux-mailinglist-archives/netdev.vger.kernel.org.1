Return-Path: <netdev+bounces-99071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31AB8D3991
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD5BB23BE0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9B15A84B;
	Wed, 29 May 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fss7rOL/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F5159594
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993857; cv=none; b=nE8arjAvMEHaXoajRCrfHuDHp8GWLTFe2lkmVkl5yEXZ6BbIrbC2T5KAk0RO89LAdaNOzWasBZcKvyo5C8PW2KbJ57AjbBtr51/y763BWfTJ02iZMqdgIU2MWqLhBH6e676qMCnL8FO7Tc1Fmo7AjH+KgW2x62R60SKQMt8lWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993857; c=relaxed/simple;
	bh=u6BlZswnI+eFm5Rn4v1wlZaF/FWgop6wKgsJpwgAl5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVrkq4NNvPfAORYv9Q2HkI34HUdl/ZKll+FF7ebyYrcFBR7OnMXaL6cQ70HI6f1RRTRXBnOMDjyuxDmOdj9tARupkIy5aB9LE9w8FuPqIQOGALMkKKAGslH599gc38liC15GinsL7pJIz2+zPBxy4WFOnIrrOrqNWbwZRBqS4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fss7rOL/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CHXsJhJCxVfvpAsB2kGX+Z2zRgag+Kz7lqGnRK8HKVg=; b=Fss7rOL/23eriR3CuQEafurmYZ
	NIRwL6lP/+bh+vOQg6GbNYimiNTHo2EnO/2jXb2uEzjyfMzWZICjLqvWrdt+oCi6Gdsvdw3evaHH8
	syR6aLIjCaQffdHA9/71WGih/ArKUlERqNeYX2eG4TwR3iFsDwBBY44+m107Cme7xguw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCKX7-00GGVo-Sn; Wed, 29 May 2024 16:44:05 +0200
Date: Wed, 29 May 2024 16:44:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: cortina: Implement
 .set_pauseparam()
Message-ID: <1f9963a0-7517-4067-b1eb-50b4dd6151f6@lunn.ch>
References: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
 <20240529-gemini-phylib-fixes-v4-3-16487ca4c2fe@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-gemini-phylib-fixes-v4-3-16487ca4c2fe@linaro.org>

On Wed, May 29, 2024 at 04:00:02PM +0200, Linus Walleij wrote:
> The Cortina Gemini ethernet can very well set up TX or RX
> pausing, so add this functionality to the driver in a
> .set_pauseparam() callback. Essentially just call down to
> phylib and let phylib deal with this, .adjust_link()
> will respect the setting from phylib.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


