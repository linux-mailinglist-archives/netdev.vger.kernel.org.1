Return-Path: <netdev+bounces-109080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181BE926D5C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774E3B2131D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470ECDDD9;
	Thu,  4 Jul 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH8a5j8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AD10A19;
	Thu,  4 Jul 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720059191; cv=none; b=ljGdVgrtmLXQu0u6PtZq39IWaRb4DfXo26Dh+XW4uvBzYCvWyJlC7EDLmK57YdFfmRjNL1UgiFVcPojdwvS8Bg2C5m9BglpovxRV1kMD5FXgE66+pRu/lj9T8njE3O1zO+3vA4v4llEmkUQYlO+GVonb17Z3iv9gw3JASfmYWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720059191; c=relaxed/simple;
	bh=7aPBsszqMYduEcu5a5wXNLYXdxnU8/yyohMqYvXO56c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlX9YaiMGhwf76g0LszQKjHiidpp7OUsvFjHukRNF7ltkRP7ErkVG5LUJhIEqoCtJt2sAKlVusMyLUtRaQAvNyqLcBdhiorWO+HihYclFWsqrt1LyUfqz5iBQBhRQnEoOoJ9BoWPqyzwGU9HxOAqdTBvTcKNqAeJdgARK3LeOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH8a5j8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7D4C2BD10;
	Thu,  4 Jul 2024 02:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720059190;
	bh=7aPBsszqMYduEcu5a5wXNLYXdxnU8/yyohMqYvXO56c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rH8a5j8FtGcFZikQ/khrBlA/nEUjRassUOXtiiwFAoL18Wak0TVJP+LGuumESiKEh
	 Kbs+ZSo5/m1AxakP01xHVU0pLFpoJ2oqsWRnUjDh1CGch3Pz0JRa+8Xk3QQsnRv0Cd
	 QmjaFB5XedvS4ykjbEPZcT4BtDpk+chwbTyW2VbNGYZZRioNgLzfJNi3lZQQhmmeyk
	 5kG1dGRitMwqwLgV6H102nBtdNawaBUmj2nMODjHr28MCSOCVfpfL/uMuezp4G/IX4
	 DO5XGcZSQlfXqs+Fh865Y2FOjnFtAeMrJc73HYKq94CJS5eCB2WCbQcuG2WX96wlqx
	 8MkVKPsgGNxig==
Date: Wed, 3 Jul 2024 19:13:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, DENG Qingfang
 <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Landen Chao
 <Landen.Chao@mediatek.com>, Frank Wunderlich <linux@fw-web.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address
 and issue warning
Message-ID: <20240703191308.3703099c@kernel.org>
In-Reply-To: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 00:44:28 +0100 Daniel Golle wrote:
> +	/* The corrected address is calculated as stated below:
> +	 * 0~6   -> 31
> +	 * 8~14  -> 7
> +	 * 16~22 -> 15
> +	 * 24~30 -> 23
> +	 */
> +return ((((phy_addr - MT7530_NUM_PORTS) & ~MT7530_NUM_PORTS) % PHY_MAX_ADDR) +
> +	MT7530_NUM_PORTS) & (PHY_MAX_ADDR - 1);

nit: the return statement lacks indentation

but also based on the comment, isn't it:

	return (round_down(phy_addr, MT7530_NUM_PORTS + 1) - 1)	& (PHY_MAX_ADDR - 1);

?
-- 
pw-bot: cr

