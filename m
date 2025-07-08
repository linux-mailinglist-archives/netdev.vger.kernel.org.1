Return-Path: <netdev+bounces-205001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E128FAFCD6E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75EB7A2984
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573292DFF0D;
	Tue,  8 Jul 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GfghWuQI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B462DAFD8;
	Tue,  8 Jul 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984557; cv=none; b=Z1nUi4CUhT7hr6dzJWFI9leyE0Ol1M+IlsT9zTe1b++wQGVOdX6E9TU5r5XVyl4nvwF8y/Xcp57/ANA/AUiDy1BqACpmCwxGjO3odLVbdc0/B8/A1z41XnZ8gBQrC+NcGuvhfQ2BpXYuAQrmRS4Ie/na4kJ3gm2W19dMzzgvoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984557; c=relaxed/simple;
	bh=V5k/JaXc8mpxvsmuIXrPpDH+unvMwkFQt98oPfHQlhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcQdKfcR02hMcG5Zsu7mo1lVx2Xlkh/CHaEny2+X/ceB6JibGGpMZXIVHyru2DsVPoKmx0HKm1lqhs5TRsunoSxSdgxbno4vqdRK9MQUHEKQaeIOKNVnEV8WOacLlvg9NQBbMIa830+A7r2gvxA4h1Yb5hU/CxZxlj33LAjuIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GfghWuQI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qEzEnv65Ia3FbPmkGo2RRtibcq5xmdlT4YJXZg1qp4U=; b=GfghWuQIREgXLIbeiW7+EztL62
	+7KcSY6ERjmgfC0PoBVZmbokTO3xuN+13IzE+cGsIyV/LhaOS9Clnj+wGd2+gFuoEdtEieihZZZg2
	gQ93DirvJkJBbioZogs3WuVO1WVWS0qISAzoo+TdOClY9j5w52BeFKBYuSTFQ+ZPEwBs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9DI-000pP6-51; Tue, 08 Jul 2025 16:22:28 +0200
Date: Tue, 8 Jul 2025 16:22:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Message-ID: <1c688ae1-5625-4598-a162-302e38dbe50e@lunn.ch>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
 <20250708031648.6703-7-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708031648.6703-7-Tristram.Ha@microchip.com>

On Mon, Jul 07, 2025 at 08:16:48PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The fiber ports in KSZ8463 cannot be detected internally, so it requires
> specifying that condition in the device tree.  Like the one used in
> Micrel PHY the port link can only be read and there is no write to the
> PHY.  The driver programs registers to operate fiber ports correctly.
> 
> The PTP function of the switch is also turned off as it may interfere the
> normal operation of the MAC.

Is this PTP problem anything to do with fibre?

It seems like this should be a patch of its own, unless it does have
something to do with fibre.

	Andrew

