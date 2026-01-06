Return-Path: <netdev+bounces-247432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C8CFA968
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A0B35138B7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB487362143;
	Tue,  6 Jan 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga0uyPT6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D5361DA4;
	Tue,  6 Jan 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723779; cv=none; b=nwzf2pkVq0qPN3WaRZrTGxBxljPcd5H+kCwu2M7rG50fvPG9Sr/0WXmjSC1pdxziCrcto5ZCoXh/hH2P8gX3ER9he9jX6znr+z4cBMtS/6s9Za+lPX3KO75uGiHcVSSU31ULSmCiGlYsG0/aLIVKfANtGsVK0mrKPtIy3CyQvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723779; c=relaxed/simple;
	bh=ZMHIVMxJvP0SqJXp+jI2tHR/1Nef4l7GGKt6yBgh3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQX526zZSzvUV+/WlI+5waWPFWQYgndf8wJSU4ICVhns/Fzih40bZcKjt27AyPwQfliPWS+bY59gIkbHBiYOFMwOtudBJhkCQQojWd7du9DxvzAtcBjCBknkd0Oir7ZUrDsHXtM7jLeCH/Q+pozAmfyNLIN40Ak8ETUse7oDvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga0uyPT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B6BC116C6;
	Tue,  6 Jan 2026 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723779;
	bh=ZMHIVMxJvP0SqJXp+jI2tHR/1Nef4l7GGKt6yBgh3HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ga0uyPT6NQN7Ta4jenmNcBrxk43grsKtrsOVSkQZFE46z5RgZcMT110WPd78kSA2s
	 3UTnNsUnsk02AGOrUzaBDvqzb/gYzXCQZ3JmQ0v8pXnRFKQm+tHT+RSkchrCvHsW1U
	 KfIUuCFkRnm9izYSbiWxdMnKWKPBROEWdqWgJtjN1P3ChIZQhlI79qgJg6CGrddt5Y
	 Ntdi3+K2/axG8qaHcnbhfQ64TNPxivq5Lu8X+TzmfrcML0O8zcYeUDRCPny7nkmBLH
	 stb+oz6/4/o8M94sZiL7w7gfy4wPVYT0cXlYSmGIi1GHl1oPUx3EVDhS2SxLcdN7b3
	 3YO9gdj3v/Slg==
Date: Tue, 6 Jan 2026 12:22:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Eric Woudstra <ericwouds@gmail.com>,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	linux-arm-kernel@lists.infradead.org,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next 03/10] dt-bindings: phy-common-props: ensure
 protocol-names are unique
Message-ID: <176772377743.2503618.2171230504388641306.robh@kernel.org>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103210403.438687-4-vladimir.oltean@nxp.com>


On Sat, 03 Jan 2026 23:03:56 +0200, Vladimir Oltean wrote:
> Rob Herring points out that "The default for .*-names is the entries
> don't have to be unique.":
> https://lore.kernel.org/linux-phy/20251204155219.GA1533839-robh@kernel.org/
> 
> Let's use uniqueItems: true to make sure the schema enforces this. It
> doesn't make sense in this case to have duplicate properties for the
> same SerDes protocol.
> 
> Note that this can only be done with the $defs + $ref pattern as
> established by the previous commit. When the tx-p2p-microvolt-names
> constraints were expressed directly under "properties", it would have
> been validated by the string-array meta-schema, which does not support
> the 'uniqueItems' keyword as can be seen below.
> 
> properties:tx-p2p-microvolt-names: Additional properties are not allowed ('uniqueItems' was unexpected)
>         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: patch is new
> 
>  Documentation/devicetree/bindings/phy/phy-common-props.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


