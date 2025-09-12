Return-Path: <netdev+bounces-222728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F65B557EE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169141896FCE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899630DEC5;
	Fri, 12 Sep 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N2P6xMfB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B612D47E0;
	Fri, 12 Sep 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710206; cv=none; b=lCenNQoPlou6+J7tt9LBBrhELQNThFJfOyZFdlkA0zwMEAvgyz6uvkJiaWiZnCtiaNMGiDc+xRbGMOmCOITON3PVdVw4idj3ih3owqYeccIahrmjiv43vNKf43NHgCbOdjdrRXUX40afJTXuswbJTndZfS8vvHNopwm4E7E4vuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710206; c=relaxed/simple;
	bh=QYleAoZewFliXUXCY9XoxI6PTGcIqha8laSnmxsuJoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uybqY8gqEbDazDfVKj18Z35FOBEDKcDmzqczwu7qdP27RJv4pM1oS3lx12OchcAZSxIjJzPWRQtO1vyKRC8ElSP+b43jtinsP1llFhYm075u9/mEg9K1/ZDuiMBvbOk1B5MVNC6gwhrcHLbVUXFM0N0K3i2QBF9zjur3Q7EOtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N2P6xMfB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BsDgpnLP/BjJT4aNa7Z5gzzlK373l8JvJuqHZ2R3Td8=; b=N2P6xMfBJFfv8Ho8/m3dH8Oyew
	s2BCcwl5bCaEtdDiXQk+hh60OVzUTHTUVAgLlwB4rgRJYZlFB9izB5r4NSgAf1FgLeT8o4ZUNkZWi
	LruFkR5O0K01neMIAzm9BDFQhRiE0wxCJCTScxXfjhMsf5v+T0+M4KowaGn6eF0dQ+/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAiS-008Fvz-MG; Fri, 12 Sep 2025 22:49:56 +0200
Date: Fri, 12 Sep 2025 22:49:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v5 6/6] arm64: dts: allwinner: t527:
 orangepi-4a: Enable Ethernet port
Message-ID: <98c03746-2b3a-4eec-863f-4024464dd9dd@lunn.ch>
References: <20250911174032.3147192-1-wens@kernel.org>
 <20250911174032.3147192-7-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911174032.3147192-7-wens@kernel.org>

On Fri, Sep 12, 2025 at 01:40:32AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> On the Orangepi 4A board, the second Ethernet controller, aka the GMAC200,
> is connected to an external Motorcomm YT8531 PHY. The PHY uses an external
> 25MHz crystal, has the SoC's PI15 pin connected to its reset pin, and
> the PI16 pin for its interrupt pin.
> 
> Enable it.
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

