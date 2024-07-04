Return-Path: <netdev+bounces-109184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9292745E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538F21C23450
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C131AC224;
	Thu,  4 Jul 2024 10:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8561ABC56;
	Thu,  4 Jul 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090139; cv=none; b=nqGUnqWmmiv2W4zCMghGNcSG5DZSOt8lcQn0XJpyQBifbZ5rb/VMdJAo/seeC+yaf7JSmMkSbvHZgqho/jW2moLUIUnChXJHQRwo2rgd6Lsqg01zKj81wR5Saqd07Vk1tqaRcMd3cVp+D2eoXmixoSvP0DlYgCd1OX+F6VQd/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090139; c=relaxed/simple;
	bh=mtHqDFTlBtadte2NCXM5kXHaYvGqZmcw7tbdCVEx7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACUiGe2c+FlJ9O6GksoTTghz7ye4qpoyRhV1NSxo7Xtd0OwUm8qospkAVAXOzsZKQLuvdDoB4mR2lkIpZPZH9YztsSAKETBCnb3sM5QXllGJW2lBOLlPk0b5JdOJA4aZoohWrTJlzNejoGkxz2aXOu5XlX0/YguHecKfpAewLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sPK18-000000008CZ-2DuW;
	Thu, 04 Jul 2024 10:48:46 +0000
Date: Thu, 4 Jul 2024 11:48:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <ZoZ-ClhHUWzAPB1D@makrotopia.org>
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
 <20240703191308.3703099c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703191308.3703099c@kernel.org>

On Wed, Jul 03, 2024 at 07:13:08PM -0700, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 00:44:28 +0100 Daniel Golle wrote:
> > +	/* The corrected address is calculated as stated below:
> > +	 * 0~6   -> 31
> > +	 * 8~14  -> 7
> > +	 * 16~22 -> 15
> > +	 * 24~30 -> 23
> > +	 */
> > +return ((((phy_addr - MT7530_NUM_PORTS) & ~MT7530_NUM_PORTS) % PHY_MAX_ADDR) +
> > +	MT7530_NUM_PORTS) & (PHY_MAX_ADDR - 1);
> 
> nit: the return statement lacks indentation

Yes, lacks an additional space to match the level of the first open parentheses.
I'll fix that in the next round.

> 
> but also based on the comment, isn't it:
> 
> 	return (round_down(phy_addr, MT7530_NUM_PORTS + 1) - 1)	& (PHY_MAX_ADDR - 1);

The original, more complicated statement covers also the correct addresses,
ie. 31 -> 31, 7 -> 7, 15 -> 15, 23 -> 23. However, the function is never
called if the address is deemed correct, so that doesn't actually matter.

It's kinda difficult to decide whether it is more important to return
correct results also for values never used with the current code, or
have a slightly more readable and shorter function but with expectations
regarding the input values given by the caller.

Opinions?

