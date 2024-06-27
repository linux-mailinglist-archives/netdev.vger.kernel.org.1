Return-Path: <netdev+bounces-107258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2931791A73C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C80283C8D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA916130C;
	Thu, 27 Jun 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WdW1jgAe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0124B5B;
	Thu, 27 Jun 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493327; cv=none; b=j4TMzYVNDJLlroktH++7UCLegQaXgFsIhAdeMCouNCH0qRUqJuwu3+nPba70bICBQzmePtkBP0nspJMau4as2FyqqkLsUd8yhvx5/LslX4M63TvqWr9u6VGbsiTLXYOzNj9AsYxMg0dKUDEwwMPFWjK26tYVM84EHy/j70BDn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493327; c=relaxed/simple;
	bh=BnaFJ9PuibNsv2J22a8dMR+5lkY1U1oZBCLE1ZsP3Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHowO/dr0gj2XCky0xfmkQIc+xCgzSncRYKvdH8m4HU1jgpf52ChvjKuKFZ+WU0b2gVK7cqfBOLzhuNP0PndakFE7kaVB1G6eFleaNzLUSv2HxmlGciwhe5H/B8vQAmWe+aJ9COvk/CJh+gUWH/tx2b6jAn4tFnjIjbfk3syBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WdW1jgAe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HfR/+79iWfSvV8+4azx6qv20sgn77zJaiv702nJ/PCQ=; b=WdW1jgAe29WrthBgh8pbrpm4Yk
	vSu534aEDE8Akhbf0UJAX+eyWuSXWVsUHEiQbNcQFU7916L/HfiAyJny+6mba0earbTPabprR2tkk
	C9Ynm21rcXch55cIh+HImF6UNspP5RMR4WUv64ZnnbvXDQRAoTPmFleTxVLmccKZMFXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMokm-0019tY-RM; Thu, 27 Jun 2024 15:01:32 +0200
Date: Thu, 27 Jun 2024 15:01:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/10] net: pcs: xpcs: Move native device ID
 macro to linux/pcs/pcs-xpcs.h
Message-ID: <c1678560-08ea-430e-9558-0b9b84b4c823@lunn.ch>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-2-fancer.lancer@gmail.com>

On Thu, Jun 27, 2024 at 03:41:21AM +0300, Serge Semin wrote:
> One of the next commits will alter the DW XPCS driver to support setting a
> custom device ID for the particular MDIO-device detected on the platform.
> The generic DW XPCS ID can be used as a custom ID as well in case if the
> DW XPCS-device was erroneously synthesized with no or some undefined ID.
> In addition to that having all supported DW XPCS device IDs defined in a
> single place will improve the code maintainability and readability.
> 
> Note while at it rename the macros to being shorter and looking alike to
> the already defined NXP XPCS ID macro.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

