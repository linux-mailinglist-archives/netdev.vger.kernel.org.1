Return-Path: <netdev+bounces-185534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA49A9AD23
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE291B608AC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2122F3AB;
	Thu, 24 Apr 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5jV5NcUw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1322B595;
	Thu, 24 Apr 2025 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497214; cv=none; b=iEvoDqMNiL4huU/Dq0AQFIh0XBFWG2qk89MkZTilXmAygOG7DVyVuuK+4FDBtS9i60rx0HJp+/M66ONwOzOeHPHuyH4TVRgTikPyY/fvgNQO/+A4uVlbJlQ8/pj2b4y0Wpch6h6L/LIUgV1ruzVrM/4pvGMvPSFC7Qzl5eBzvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497214; c=relaxed/simple;
	bh=u8Mc0i/TppApevsGSFKevejDwzLPAMFwihcv9XLpm9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJWC+zpnHbYw2lomkEeyoyK7CdCnxe/olevMSllmmyxL2DcCxU7cTQUpkQMRYAs0uHunJFGhAFO3QtwG5J/jbZ36/5Lq2n397mdpp3+DHfbwUJjdl+rEmsvAZUSweyfw405goRBxPNTKQz1AugK0gC56NzvxRHiReDyKgXRbzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5jV5NcUw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mwdTuU65lhEc5zC83nLOBu+Xq+msnXdZ5WpwUOFK4oU=; b=5jV5NcUwVBjHDWX91xReA0JiQz
	QgXwN1lbzHZhPY6zkIqoyQ3S4AkJCekuPFZ8ih/R5DMb9FIeTKBhuX/eCDLDpkbtoK+FELL/uV83z
	nkQooUiBnNsjJbGv3uxZ9gQJdRMcyqkme5TRr0besJ78ziLPuo96K0Pe6OBQxotooiuY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7vYd-00ASWc-LM; Thu, 24 Apr 2025 14:19:59 +0200
Date: Thu, 24 Apr 2025 14:19:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yixun Lan <dlan@gentoo.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <6e9c003e-2a38-43a7-8474-286bdb6306a0@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
 <20250424014120.0d66bd85@minigeek.lan>
 <20250424100514-GYA48784@gentoo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424100514-GYA48784@gentoo>

> I'd not bother to try other combinations, and just stick to vendor's
> settings

Vendors get stuff wrong all the time. Just because it works does not
mean it is correct. And RGMII delays are very frequently wrong because
there are multiple ways to get a link which works, but don't follow
the DT binding.

	Andrew

