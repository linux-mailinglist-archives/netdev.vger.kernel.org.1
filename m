Return-Path: <netdev+bounces-247434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F4CFA854
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183A93049C4C
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0EA364EA6;
	Tue,  6 Jan 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Xgogpg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1562362142;
	Tue,  6 Jan 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723889; cv=none; b=omqL7pq+85py64lpYMtBlnv51V0aDEq59HLSAeFelR4uQ815s7CwwfbB0XYa+HxThhtAHX8AMrMprHSIy9qzebGomOcZsCzqiFkGVJShW1Le1OkQ+3eiUSm4+5OXiAnNjcZ5NVvqll75rQi6qrZZW8FGnRVvtt5Fql5qOu9p/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723889; c=relaxed/simple;
	bh=IqwxW4H8IUPPZK3EaAi+GlNg4T3+lt8kFJ64tmM76u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpVr5LRaDpwT0puy3PESiSIwCxCS4/XqEwRv8TQNGOeUfDA1tQxEvECvjzRzmyS4H+T3l29pAkV9vX31cu/JkBqKWRt2tlpGRs99SeTLY6SN9tCsU+4sxtO8bmSjxvms/nyRtDVD6ByGtztApiIoE0eMIJ9qbkn3FRbbNKsM6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Xgogpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD87C116C6;
	Tue,  6 Jan 2026 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723889;
	bh=IqwxW4H8IUPPZK3EaAi+GlNg4T3+lt8kFJ64tmM76u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+Xgogpg1Wp7TNMKDYKrQq3HMboaKX3mPD5b0jFOsUnywRSPuBxhq4qccvqS0o1xN
	 wUCZoXfplvSXeenRq5c7QFFQmEA9AKKI/BEEJF3D/mDpmyNzFB9n9USSJ6+LR1KPr8
	 wu7h+enj9RwNOaayYb8myNwnpj21NFmLg98P4k5A1gjkyfenp6ee4H0m1k+USrfMuK
	 J9JGEmlSQS1j7mPBEx4YsvARguUbkL+oKME0LaTskxOpkP8xI2QL6YuXp3Ex8JbnT/
	 k2NkQ/tlH8k4TvRy+STaBzgbxodcFrWjxDgHm+LyB323coiRzprhtAVdpf4e0PAoum
	 3CMeg+bnz90MA==
Date: Tue, 6 Jan 2026 12:24:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	linux-mediatek@lists.infradead.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-phy@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH v2 net-next 08/10] dt-bindings: net: pcs:
 mediatek,sgmiisys: deprecate "mediatek,pnswap"
Message-ID: <176772388791.2506483.17745230367283833244.robh@kernel.org>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-9-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103210403.438687-9-vladimir.oltean@nxp.com>


On Sat, 03 Jan 2026 23:04:01 +0200, Vladimir Oltean wrote:
> Reference the common PHY properties, and update the example to use them.
> Note that a PCS subnode exists, and it seems a better container of the
> polarity description than the SGMIISYS node that hosts "mediatek,pnswap".
> So use that.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: none
> 
>  .../devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


