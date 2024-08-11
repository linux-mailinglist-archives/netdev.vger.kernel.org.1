Return-Path: <netdev+bounces-117510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C994E243
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46911F2138E
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F51514E2;
	Sun, 11 Aug 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eDsbkGpn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD517552;
	Sun, 11 Aug 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723393964; cv=none; b=ePoReNtWW6CENujg7QQ4VssCYjIFEsNXEDzgVaBOL4lTNqdJiaD3elkuS3h9jyxkarwDYmINKlMUj610vshSJARyUUzPuVpr0mJaWPb1PZarR49o3cUBir+1y2YWt6JtPtqDV3+Rw+OZFOf8nCWsP0+OixPd0OaKjf9r7T5Cd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723393964; c=relaxed/simple;
	bh=x4YXLMphLDcbIA5cY+pXEwWpsa/bemTS5Ma4yzWMSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+nzJk174mVCyeSXVxbknscxrcU20N1VaQqROaoKsUgM+uxFdaKGVkb76iSGq6R/+2LEEcT/vJ7FYy37J3grI0FXD0FXCDj0LN/2knCejTihTFT04cVImi1UE+IoViVe/x3FpuRzvwF0JV+1elyqvZUkPCEIHCcYWZxJM3K1PlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eDsbkGpn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5ggn0KuBiFZ+YkxUXgYc1owEPbUgdAKbCVM6AilzxOM=; b=eDsbkGpn8Ptfpdbo3fFdJZ9qA2
	C6WwAIeXmcrx7pZ3PG5dR5FZYzQYR5xP7nejzeR2ux85C3stQElY6BMB2o62jV42ZfySPSztAi1YX
	O8IOThzhZomLfTbsmuffcMWbZnGf889a+1u9lRrzU4NykVVldYjFOvodnPpqfY5DDUPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdBUd-004ViW-Rg; Sun, 11 Aug 2024 18:32:31 +0200
Date: Sun, 11 Aug 2024 18:32:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Message-ID: <ede735e5-cbf1-48ea-a93e-1b4f21a48a4c@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-5-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809233840.59953-5-Tristram.Ha@microchip.com>

On Fri, Aug 09, 2024 at 04:38:40PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> 
> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> has to be explicitly set to 0 as driver cannot detect that
> configuration.

Is 1 actually 1000BaseX? An SFP module using fibre would typically
want 1000BaseX, and only support one speed. An SFP module using copper
typically has a PHY in it, it performs auto-neg on the media side, and
then uses SGMII inband signalling to tell the MAC what data rate,
symbol duplication to do. And maybe mode 0 has in-band signalling
turned off, in which case 1000BaseX and SGMII become identical,
because it is the signalling which is different.

	Andrew

