Return-Path: <netdev+bounces-172951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB2A569E0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D03B3733
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39821ABC3;
	Fri,  7 Mar 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YC2hEVy4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FF21ABBD;
	Fri,  7 Mar 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356188; cv=none; b=IURIFs9lLTDTnts855vjz81b2eGQKhBbAle5H0Z9MJh/WAMrsm0YcGcZpxLJuX2Jw99TaM18FGroFwoEkDBkZVZU3IvE8G85ljYV0YP2YzUubwc+d61mqrDfcaZh3nHNkmIyOXmVX4dxJcP7oFT9Pz3qCDRGbT0Bm248kyl4DGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356188; c=relaxed/simple;
	bh=CrhhOIMTVL+IZJGVGxgGzbJTCVnnSVtzlH5FBaVUETw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uumqnixpwAPRLUCc3rKp4cVY7JCyJUk+VfNWx3a+GG5HshnQf1MoKkXA8pl79VhxnWRZk9dT71nT1WAt1aBJY6MnrdTwVAXp9B3W3BrHp9dFYFs1sOGKYaqN9uR9Wqv56NbEQUxwFKtmUqNTS7ieCPGHBCFe71Z+ktzDG5UlkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YC2hEVy4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nB1Ff94gX6hUEiR4vaLcBQczfcyrPErlm6RF/exj1rY=; b=YC2hEVy4NZANVuitqKYVpsTfLw
	Vq53fYjnsZ/1ipxexmYUW+xwwvwoTr6C2S4WvrqLu/Wx/vj7Bfejk8gxeXpGpMi9v41K7xmJNq4KH
	294pI4i61HdG3JE6B7pDvyY8tUpME3f5/uDtjCZDQwO1PVRguDqOkUFJoi5SAEEV5xbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqYHs-0039gt-1L; Fri, 07 Mar 2025 15:02:52 +0100
Date: Fri, 7 Mar 2025 15:02:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add GMAC nodes for RK3528
Message-ID: <f6c6aeb5-bdec-4283-87c8-e870f59008c8@lunn.ch>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-4-jonas@kwiboo.se>
 <a827e7e9-882a-40c6-9f2c-03d8181dff88@lunn.ch>
 <003d3726-680a-4e91-89cd-d127bc3b5609@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003d3726-680a-4e91-89cd-d127bc3b5609@kwiboo.se>

So this is a bit more complicated than i first guessed...

> 	phy-mode = "rmii";
> 	clock_in_out = "input";

Probably will not get passed the DT maintainers. The clocking needs
investigating.

> 	phy-handle = <&rmii0_phy>;
> 
> 	mdio0: mdio {
> 		compatible = "snps,dwmac-mdio";
> 		#address-cells = <0x1>;
> 		#size-cells = <0x0>;
> 
> 		rmii0_phy: ethernet-phy@2 {
> 			compatible = "ethernet-phy-id0044.1400", "ethernet-phy-ieee802.3-c22";
> 			reg = <2>;
> 			clocks = <&cru CLK_MACPHY>;
> 			resets = <&cru SRST_MACPHY>;

Using the ID suggests there might be a chicken/egg with the reset and
clock. The ID registers cannot be read from the PHY?

> 			phy-is-integrated;

This suggests the possibility exists to route the RMII interface to the
outside world:

  phy-is-integrated:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      If set, indicates that the PHY is integrated into the same
      physical package as the Ethernet MAC. If needed, muxers
      should be configured to ensure the integrated PHY is
      used. The absence of this property indicates the muxers
      should be configured so that the external PHY is used.

Given these issues, i suggest you keep with the DT as you have it
now. Adding the PHY node will require access to hardware and some
investigations.

	Andrew

