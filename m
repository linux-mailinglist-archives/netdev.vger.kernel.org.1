Return-Path: <netdev+bounces-200971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F7AE792A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652AA4A07A4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC120FA8B;
	Wed, 25 Jun 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nBr0bmBz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D21F4611;
	Wed, 25 Jun 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838137; cv=none; b=smQcE67+EhMRW3fclCDYq5MrGtty5AiY/MEKsoTxEJZ+ST+0IIb1hqSC7VxkXzphvfkMyQ7vEfQkVNznKcOmOHUEBXtrxh43iMB9eIqv28WBYRKS8hN7c2s/c4xf9sAPGNn418iL/csUqV7TGyeetkEOcgua2pM0BfBeWLELois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838137; c=relaxed/simple;
	bh=f3nAWbUhzSLgr2zCpfA3JxVG3XrGFKyYT8b8aXCxY5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHzAePmtsPHgFTP30WzpT30sTg/o0Rgczj172QWFAlWutMKC/Ov4htTXU+/dE4aRHLFZBYmkFrtWq3vvaMPcknRCRYVOeOJjFQEnKdnoQHOP9Sh1lrsVmFf445/XNnrk5LXoyoe4Z99RghoAUzhWB8VdEoCY0oknBa3do2BuKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nBr0bmBz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1RCHlDfmIYcpqGaWJ34C/dheqLJvi4wwH/mk2IZ8K/w=; b=nBr0bmBzRxRHU0N91/TJNhJSfM
	9JMlM384OMecJJe1fa5Pq2VRuPUFoa4BdC3ArWCbce4QQy6Dix0LHCbGL+cD+xq39+2N3N9GcB1l0
	qxJZKAtrqJ/2vGAjKplmp5EdaKNl9wXR4ijcbJorZyKiY4ULTb4zFTkc+fEEao4YzkL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUKyT-00Gsvt-Qm; Wed, 25 Jun 2025 09:55:17 +0200
Date: Wed, 25 Jun 2025 09:55:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Frederic Lambert <frdrc66@gmail.com>,
	Gabor Juhos <juhosg@openwrt.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: dsa: Rewrite Micrel KS8995
 in schema
Message-ID: <657d5801-5b4d-4a82-ae16-124d833dc393@lunn.ch>
References: <20250625-ks8995-dsa-bindings-v2-0-ce71dce9be0b@linaro.org>
 <20250625-ks8995-dsa-bindings-v2-1-ce71dce9be0b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-ks8995-dsa-bindings-v2-1-ce71dce9be0b@linaro.org>

On Wed, Jun 25, 2025 at 08:51:24AM +0200, Linus Walleij wrote:
> After studying the datasheets for some of the KS8995 variants
> it becomes pretty obvious that this is a straight-forward
> and simple MII DSA switch with one port in (CPU) and four outgoing
> ports, and it even supports custom tags by setting a bit in
> a special register, and elaborate VLAN handling as all DSA
> switches do.
> 
> What is a bit odd with KS8995 is that it uses an extra MII-P5
> port to access one of the PHYs separately, on the side of the
> switch fabric, such as when using a WAN port separately from
> a LAN switch in a home router.
> 
> Rewrite the terse bindings to YAML, and move to the proper
> subdirectory. Include a verbose example to make things clear.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

The way this 5th PHY is used is different to any other switch i have
seen. By following phandles, i think there is enough information to
work out how to configure it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

