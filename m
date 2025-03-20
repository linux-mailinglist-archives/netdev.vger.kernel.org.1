Return-Path: <netdev+bounces-176460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BEBA6A6F7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1879F462319
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50219D067;
	Thu, 20 Mar 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kwN3Y5+/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056B1CA84;
	Thu, 20 Mar 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476761; cv=none; b=tp4EdNjt9D0LEGo1ywbP6V4Y+N6nFQlI4us7N2gmnuGSLgbaKpjOIJ5dZWkLPG6407jauMWPB50NVM2dbNR9ZaP6kqX0bEjDT4YX618u4wVm7Nmk+kJE/Im5Y5eXQPrY4srWv/cIdPJsia8i7Y1hXHK1QAaVaJFr4srdHg+Evts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476761; c=relaxed/simple;
	bh=ojrA8cCH32Z4d+6yoiq5GmltKZ5YoZXkthEq+d6jZOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZigwuF3SGl7zNghka4jWEYtoyLjQOcOr4g7HScNt7QdExbBCp7z5cLRyeOw0TiXtANjLiAN2EuTpoShE1tPqbOZkLc2XPRxtMkLiLwB4Suvy2DF6AaYosLkfXjCF+d42AMsyjCSLS4WZXho29g+4xEXZZf99J0QTd0m8a7Mg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kwN3Y5+/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hog5WJKdQRNrghmMt+l7WMrayTKcBJOBSMu352CQIkA=; b=kwN3Y5+/hORg3RCEpzRsvLWeYp
	znsHABKvqX9qgqmYYIcs8+ega7eNxTQDwRPTnTXYvsnoi2kKpxei5+l5Bs/IDP2T2FrueFLO9LTRd
	ybhwA8NUitzpPI+ANS7Ku3ckqynsenojU/5piN3aVqVTEIEC7mep/9K8DJDPhw5DmJ/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvFnY-006Tir-Tj; Thu, 20 Mar 2025 14:19:00 +0100
Date: Thu, 20 Mar 2025 14:19:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: dwmac-rk: Add
 integrated_phy_powerdown operation
Message-ID: <682212d9-becb-4325-9b0f-541c96a9270d@lunn.ch>
References: <20250319214415.3086027-1-jonas@kwiboo.se>
 <20250319214415.3086027-5-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319214415.3086027-5-jonas@kwiboo.se>

On Wed, Mar 19, 2025 at 09:44:08PM +0000, Jonas Karlman wrote:
> Rockchip RK3528 (and RV1106) has a different integrated PHY compared to
> the integrated PHY on RK3228/RK3328. Current powerup/down operation is
> not compatible with the integrated PHY found in these newer SoCs.
> 
> Add a new integrated_phy_powerdown operation and change the call chain
> for integrated_phy_powerup to prepare support for the integrated PHY
> found in these newer SoCs.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

