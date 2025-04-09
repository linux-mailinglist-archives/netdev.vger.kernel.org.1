Return-Path: <netdev+bounces-180940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9AA832FA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D00189A585
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E5202979;
	Wed,  9 Apr 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qba/6MvM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FE1D5ADE;
	Wed,  9 Apr 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232806; cv=none; b=iFLiqIEUdjrZQx2Y8ktEvdiRHIhwQGWnM8zkWh3SIi3LH2KUqAEFOyHPCii3M+6r9TUmb1EsULUl01UuykP0hVgTIW2HdcMB4zX2b4dbm7Lwm+ZyN1Id2yagyADH9vI8feh75F1LvhMsSPPtLWq3Da4+vtOajQju5ksGlGyfViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232806; c=relaxed/simple;
	bh=A5tiqZuk19Z9E9HTBmsdD/Utrq5L4fPz7jKOjnNEIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0wNMJs4GaG7P2PmAk49WOM9u1T7Un7m2WkJKbGbhtz+0iFuZ8iwy7zjtDCWewnbaBxatImkfo3FPPNOhjpSFUs6czej6Je3YNHDALBxtmnYBU2jEu0OXrIKma4bBdNs7gmk+VSYJmkIb+5kFExQTgYFRztwv0Drt5m28EZ7wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qba/6MvM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iay7Qa9sHNdJmcKXfDHG/I+AIXVYDO+D/QQZnAThWT4=; b=qba/6MvMpUVqbjjCqTUqeAW+ne
	H+o9Nsni77/pVeMjpWzHLi5WCNgJevjaPJ8xhwIIpr0YtybM40VTypQ3eX82igMkWUYgClhYpK1w5
	UEcDIHOHgdzBuEgbIJ3FO7uvz6bRITBehc+JonQGPEZLyr8vyyJCzuTZSWiOfRfo992w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2ccw-008azr-2R; Wed, 09 Apr 2025 23:06:30 +0200
Date: Wed, 9 Apr 2025 23:06:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [net-next v4 3/5] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
Message-ID: <b380c764-5a46-49e8-9241-675a6b9d85b6@lunn.ch>
References: <20250407145157.3626463-1-lukma@denx.de>
 <20250407145157.3626463-4-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407145157.3626463-4-lukma@denx.de>

On Mon, Apr 07, 2025 at 04:51:55PM +0200, Lukasz Majewski wrote:
> The description is similar to the one used with the new CPSW driver.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

