Return-Path: <netdev+bounces-243605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AA5CA46ED
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910E830FC295
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5F2ED87F;
	Thu,  4 Dec 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvY5YyGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713012ED85F;
	Thu,  4 Dec 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864820; cv=none; b=IHNPI+XTcUU6UwVw8bef/WmcHodUQcgt+qkScF98FGMp3c+feEu60M8HFjFF57CKwzVxItkSW3S1MZG3kmLm0HHriuCOBC7h/T/s49DVgHu6p71uHDzaIOwmSunvwkkD/CFf5TGe6caX8dWj9yq5yT0AO1Jl7+LCMWXfeZY0EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864820; c=relaxed/simple;
	bh=G6tjXLsXI6Ra3ZBQPtPCBFR2m7OZSlhpuiykHbxlWLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hathg1sGynVGAevKVmzLVMYAgEeFdazqnWP8oHUpWLbHt1mOTwelTvC12tgDdZ//jkDvDEHd865tL31j+i7gpGw/s1cCFl787G63fC/tMC5KvyYm01rke46qNfXUVW0t6her0FIg32Xdn8EmCzlC06PbQXy4HajsRp6pahCuBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvY5YyGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3513C116C6;
	Thu,  4 Dec 2025 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864820;
	bh=G6tjXLsXI6Ra3ZBQPtPCBFR2m7OZSlhpuiykHbxlWLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvY5YyGLWoJ1UD14j17xypppwNb6yor4vMuIxOAnWGeYrPivqAY/q+1rXAnSiK0OI
	 5vsF8CXo2h6aP3v7ocODRoI7oaW2IeqPFctjWr9ONiigqXTp0qzAQ22bBnaH4lHJDX
	 aKsP0TH7bw+IJoI94hNk1N1mNZgJgdc2cKWTOMdJoDVBdm7uTZcozeGxImb1czuGHA
	 p86Dw2VqEEU/vnD93MjmCgWQ+6gfUUjBVAZnuMw3e8JAYhV+h1JAveW2G0Wnk4Xw0P
	 fgK6C191t/woAjv6tuHY8Nb2wKG2NVT0vFhhs9jsAa2mFeXclFKTHWUhiZgcUkibfG
	 mPRsrko9qOuog==
Date: Thu, 4 Dec 2025 10:13:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lee Jones <lee@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	linux-phy@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 9/9] dt-bindings: net: airoha,en8811h: deprecate
 "airoha,pnswap-rx" and "airoha,pnswap-tx"
Message-ID: <176486481672.1580073.2236762382059854935.robh@kernel.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-10-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-10-vladimir.oltean@nxp.com>


On Sat, 22 Nov 2025 21:33:41 +0200, Vladimir Oltean wrote:
> Reference the common PHY properties, and update the example to use them.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../devicetree/bindings/net/airoha,en8811h.yaml       | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


