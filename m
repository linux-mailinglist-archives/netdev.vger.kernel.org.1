Return-Path: <netdev+bounces-193081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC6EAC26FC
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80007B2AE0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF14296D26;
	Fri, 23 May 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nvI4EXjG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28461296731;
	Fri, 23 May 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015927; cv=none; b=O+v8/bmIODy9Go+MQEQPhBhfQVj3hKBuYM3FiscY/n/3PAvr2aqSyeTPs8p0fylANa6eg3z9GBcD9BWrDZXK0EE1ZUd/e7jtAnSGWUhorj5ntVOP492kBfa9rJt/tk5m7xisyGea/EyomfDNUdoAD7qKsC9vgJV78bb7rvXJSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015927; c=relaxed/simple;
	bh=LUCVKIdS0n9bNLl8Dg0uzWghiJUU/NfX+HSObBpg/sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuSxOwTtn60jFqaD2JzNVcLPOeaifKlyzRQ4p+Fqs51kpCgP+JIU4k7l0dhpPGQpRg8G9aAiAHACih76MP6QHBvqfnEy49L8R75mzUUV+DVKjtsGby3pci9T+uB4xCf7OunTZF6gsaxLo7hnjvpmR1om9jpJnD4BVbEO1ayQvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nvI4EXjG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XdvIcKQd1IkP3xa1CEkOeOoIL3VkDPilYeAIguAX1X8=; b=nvI4EXjGQKq4lgJBmY2tuKCEHS
	3p6ciK9IEqxQR3P/xPsz07KsZbvrwvvi1bqTdr+4ACGm9+0QhgS4dm0BJe7V+Q7xiMmXo8VwyVmkv
	I/BM0Y/Hz+m0ykysHCe/yN36972WYJp+ierJttO2XNn2I03SirZoYHZtftRx9xvhmA3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIUmq-00DcuR-2y; Fri, 23 May 2025 17:58:20 +0200
Date: Fri, 23 May 2025 17:58:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH 3/3] net: phy: mediatek: Add Airoha AN7583 PHY
 support
Message-ID: <879d0fed-37e7-43b0-9dab-4a20b65c6d75@lunn.ch>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
 <20250522165313.6411-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522165313.6411-4-ansuelsmth@gmail.com>

On Thu, May 22, 2025 at 06:53:11PM +0200, Christian Marangi wrote:
> Add Airoha AN7583 PHY support based on Airoha AN7581 with the small
> difference that BMCR_PDOWN is enabled by default and needs to be cleared
> to make the internal PHY correctly work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

