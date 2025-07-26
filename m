Return-Path: <netdev+bounces-210329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17BB12C36
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D486B176208
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2721A44C;
	Sat, 26 Jul 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNU60zaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BD155C97;
	Sat, 26 Jul 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562317; cv=none; b=qEdSYvgFEUuzJKNh3uGWQ5FnWUfMRJK4wS4TwlY/wJX+3i3LZyiDpry/mm6Tz+dcwtb7hEzkV06LQxWUzxpQ0hylsgbxMEH2e8NNs1jWqiDr2cukNOQYEZkc1ymlVxnK10qiADy6tKcuDflFat1nXfu3KveoVjTNhRZJpBFb5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562317; c=relaxed/simple;
	bh=TM1X9dVzWt5HlEVegL3MeEeWKrIa4mosSp2FQM2bPWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzdXB1XG5AIZL4jHcjW48oHlATUJwOq2EjR1iVS9WXd7QkefWtOXafe1Tc2VxDL6hABr0kjvYIbzMiwW6BgjLr4uh6ij3HP8YOwk4r4g6k6Rnl8IGVZl6WQZgkEOWcmAiEbuBSBw/aeTcxJR+43mwXY2uzSGDefLzCC2JBbRW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNU60zaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28052C4CEED;
	Sat, 26 Jul 2025 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562317;
	bh=TM1X9dVzWt5HlEVegL3MeEeWKrIa4mosSp2FQM2bPWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNU60zaSue3QS/YiAPQeSr1K1UrY/FTwKyMWopez4AwEFrglQwUtZX14ihVBZDeDV
	 eJXm4ybi5yFq3LoY0kshG3ZIqcyDhXPIJc9Fb+p6yWZPk+JWEGIE2aGYHzBVN0azT5
	 20cWIEzpmdQfq+P6P8jnFJdPgl5Hm9I2KAHfSsMtdRVfpuC4S52ax3PLkm0PzvJoO4
	 wXgN6SR2ks9F2S5mvKkJJfS98EQop2hD1XI53rSQmiHkeLaz3RlyZOL4LTt+9E3eve
	 AmVaI/UBGu+i4xHpD7xYyF2o/br8k7EBtSZZd062T5sLiiEri19Dn931ZcWcVzh4pw
	 /9rStvr3EIppg==
Date: Sat, 26 Jul 2025 13:38:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v16 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250726133835.6e28a717@kernel.org>
In-Reply-To: <20250726221323.0754f3cd@wsk>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-5-lukma@denx.de>
	<20250725151829.40bd5f4e@kernel.org>
	<20250726221323.0754f3cd@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Jul 2025 22:13:23 +0200 Lukasz Majewski wrote:
> > > +		ret = register_netdev(fep->ndev[i]);
> > > +		if (ret) {
> > > +			dev_err(&fep->ndev[i]->dev,
> > > +				"%s: ndev %s register err: %d\n",
> > > __func__,
> > > +				fep->ndev[i]->name, ret);
> > > +			break;
> > > +		}    
> > 
> > Error handling in case of register_netdev() still buggy, AFAICT.  
> 
> I've added the code to set fep->ndev[i] = NULL to mtip_ndev_cleanup().
> IMHO this is the correct place to add it.

If register_netdev() fails you will try to unregister it and hit 
a BUG_ON().

