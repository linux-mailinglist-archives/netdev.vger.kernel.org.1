Return-Path: <netdev+bounces-189553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B1AB299E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D6A16D096
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538F25C707;
	Sun, 11 May 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="phdDVKY1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8B22D7AA;
	Sun, 11 May 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981544; cv=none; b=PNmKm3sMVS7H1vYr6G1eVQE5hdA/rKyve1BAwicXvdRnEnBVmgi7pwrZvE4bpYZIXhLaoS7ohBtWkvXvXnUHOkSVqzUXsDwx62Qf9YRAlapDrAyTdn/F1h3KfMskANZJucYxTjhitn/iibgksl7ed22xyjrBUxRlQfoERdJ/h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981544; c=relaxed/simple;
	bh=7olxK4CQ4EQsn41OLqpnGPvMLjJXEuxxLhEJycYJ1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrTbv9Vgm/LNsvuvc83P9oJf9h7VNYNVlKTrwNFtCSlPeCQ/2crJNSW7lfTdoBucYg0mLl5cuiuOOCXfjr7/pz7ECjo1VD9FovVL7a94v/Qr5zSCpol8kKIx2cHgzTd2XCTmoONju8QPwrpZfGNccvfMlOLvf5V6BMC9YFlwht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=phdDVKY1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lWYabxWwN0rZXGIKRD1Q4hDChX23vVF0dJbDnHVfEtQ=; b=phdDVKY1LRBkC276g4viHoQG+O
	6j0Rv/ls5B+JImztcemHmjmp6yAcusSEL/17UKxArVwiECMbPqvi9QaxqR02X0noTVLdr6lPrBieM
	18t+IjHVffJrAUGYyNUtP2cIZsCy008XxJO4hUaXRzZuPG40hbAlmSuM8Ztsnjx95GbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9hR-00CGI2-88; Sun, 11 May 2025 18:38:49 +0200
Date: Sun, 11 May 2025 18:38:49 +0200
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
Subject: Re: [PATCH v1 08/14] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Message-ID: <78abbdb9-70d8-4e53-8593-91735cde73ec@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-9-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-9-linux@fw-web.de>

> +			gmac0: mac@0 {
> +				compatible = "mediatek,eth-mac";
> +				reg = <0>;
> +				phy-mode = "internal";
> +
> +				fixed-link {
> +					speed = <10000>;
> +					full-duplex;
> +					pause;
> +				};

Does phy-mode internal and fixed-link used together make any sense?
Please could you explain this.

	Andrew

