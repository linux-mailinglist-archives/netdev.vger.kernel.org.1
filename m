Return-Path: <netdev+bounces-200972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E415BAE793B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DA3165DAA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AE20966B;
	Wed, 25 Jun 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cdww2vS7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85F1F5851;
	Wed, 25 Jun 2025 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838272; cv=none; b=Yrcda4o/TNYWJ36BdPupkAEBJcV6y4Vbx/x87GbZZ4tCPJ5zePZWwFa5IpW7mz21hSEIV0GYyAhpXJMlXvmndJ2bbpAt0AO2Woq0mPZf6WZ1bROdtiF7cefbt8Gqz4KVL/g1hau9/RIxcOlCKvqKD8IC9Q4aijkU3rf6xqpIQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838272; c=relaxed/simple;
	bh=09AtiFIr+fuUK6nfyXUvhH1KvVA2zntImc8TX/7AFQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz2GYNBUhf6lB383gKb3QIDduYClgjZJ6vVju+TUEUEYaf0KcHdsM6JGrekO9smXeFS1of3e7riLesciywe+/RyE+g6c3ABS8Jk9XDjlPn/asRiiehlKju78JT8RZabWt2IfubNdCGdmXrDJQ9bDF5II24kd8RVJ9D1uQ9+KxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cdww2vS7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wVbQpktiyFZWyc19SEUTAXlz3NpuUski12l5wPZgQUc=; b=Cdww2vS7ecKxZ0LWBhlnjpeO0I
	rHJLJ4D2j9BhANP+4yMxnRamzHtsc+SotKutdkxKTf7aSs5v8igzwwaAN6QQxIhHmjes+IVCroYlV
	3K4wLGcrgfT/sUGQhAzBYk3G/pcGdIoxYmt1jUnMFxmZBp1lTc2YkoBe//5/GtRzeHzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUL0m-00GsxK-Ol; Wed, 25 Jun 2025 09:57:40 +0200
Date: Wed, 25 Jun 2025 09:57:40 +0200
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
Subject: Re: [PATCH net-next v2 2/2] ARM: dts: Fix up wrv54g device tree
Message-ID: <4dd86d4e-f399-4360-a8cb-4ac9941e0977@lunn.ch>
References: <20250625-ks8995-dsa-bindings-v2-0-ce71dce9be0b@linaro.org>
 <20250625-ks8995-dsa-bindings-v2-2-ce71dce9be0b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-ks8995-dsa-bindings-v2-2-ce71dce9be0b@linaro.org>

On Wed, Jun 25, 2025 at 08:51:25AM +0200, Linus Walleij wrote:
> Fix up the KS8995 switch and PHYs the way that is most likely:
> 
> - Phy 1-4 is certainly the PHYs of the KS8995 (mask 0x1e in
>   the outoftree code masks PHYs 1,2,3,4).
> - Phy 5 is the MII-P5 separate WAN phy of the KS8995 directly
>   connected to EthC.
> - The EthB MII is probably connected as CPU interface to the
>   KS8995.
> 
> Properly integrate the KS8995 switch using the new bindings.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

