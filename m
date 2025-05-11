Return-Path: <netdev+bounces-189552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E3AB2991
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA453B5FB0
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487351C8613;
	Sun, 11 May 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kjR51rpY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C1171CD;
	Sun, 11 May 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981293; cv=none; b=mjPk/KM02qSmFXT7hXeWEXx1el2PuM1dIMGNtiV6d78JQY+KPT7F7jFNgpH4EWmQrTzieoscZBmis3u1koVDn8Q22X52GHqxDfRK/sfc1BzOhSu3/HJaVybMSnMr6uzwb4b1ctkdbOrHWxZVgJ/zwzYA8t5XSfdC+njJ+T7Lkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981293; c=relaxed/simple;
	bh=TTK5hApmDktwxjtstn/gjd4zwlLM3Hk/2UuacF8qcR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/DBFDSlq6mFchT8c5CjKE/kGZlMu5Rahfe8p/6GFini86t3IduWUWSPctPPfV+nX3D9PB7w1IrIA8CQ6IP2glfQ53rmHhKapZJPYo0yrEHSRfBvg6vdpnruzGrDmPA5H2TEd3l8rx4+Xa2filfXnaQ8cNnd+FysQTEjIizJs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kjR51rpY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rTKtw5p9cRT6gfKtPcv5QRCZhaiO1JqQg2Jdb1SHkWI=; b=kjR51rpY2dh3I+eCPGZ7vHjCeC
	p0tO6yLVqBOpo2bnc/7frYv/SJfceT77OD57oqjAqKf7g54Bw0E0FHLLdpx4HWhKptEX7sZWHFm4G
	rgDlSDo0vY8/4BeT5LdBgRUVeciHoYo3UaMIzljNElKLhbJfZ9fr1fLBbK5faSMRC8ME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9dG-00CGGX-Fk; Sun, 11 May 2025 18:34:30 +0200
Date: Sun, 11 May 2025 18:34:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530: add
 dsa-port definition for mt7988
Message-ID: <043d1a0a-1932-42f3-bcd8-17fad10c5543@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-3-linux@fw-web.de>

On Sun, May 11, 2025 at 04:19:18PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add own dsa-port binding for SoC with internal switch where only phy-mode
> 'internal' is valid.

So these internal PHYs don't have LEDs?

	Andrew

