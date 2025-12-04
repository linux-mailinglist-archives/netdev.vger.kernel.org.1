Return-Path: <netdev+bounces-243602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12CCA46AA
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD0003006DA6
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E92ED165;
	Thu,  4 Dec 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld63lALu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52D2EC559;
	Thu,  4 Dec 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864713; cv=none; b=ohS2vaQM3vRVOZ08WI9JcZQGjPBfFP871P2f7NfAoquKh5r9Ld84tm5Cc8A64XY/ND6VOL19ifXj8i9V+hlPQB5QpHBPZjPMQpVu8TcYf5GfQXHgJXyF4d1HwtITVyZlEbUU2IxRfasu5qy6cLyxLVcTHSqDC6hXkJoG/CnBt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864713; c=relaxed/simple;
	bh=U0t93rz+6G8qhpgOPXWae5373AeBmPFR5c2pQwy9SXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNEcIFhvlxTHZfNtZzaUAQ7hKY9xwmUIfWiuk5V72h2fOkE7Pb5LUYjCgdqZXdn30o7fFf6Qj+Q2oD44k4+QN560DJ0lxYN75mXBuwUnPNNfXeGwY50AdDQ+fHmqmudlKT/IC6PmLAxiOkVI0IsozPdvNxpMO6Nu2LGv/J5tYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld63lALu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8223C116B1;
	Thu,  4 Dec 2025 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864713;
	bh=U0t93rz+6G8qhpgOPXWae5373AeBmPFR5c2pQwy9SXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ld63lALuvgXx8fZzifbNcMSzbIMPW2BcijioVkdJ4WkcVMNeevmNW63Kzyruqi9lf
	 A1x5boTYluSqq13zE6hGNeo2VmFrO2jIglxpq2+MIgbkwFQZyLXBHXiEAlF4A807KB
	 YFgdurFWQDxiC9xMp07DLKDVrHu1STX4DlOTNYKKrJuAI5P1i0BrjTKOkogb7GsktD
	 HN1wQFnhdRhtaY59udHqSRc7FmBF73gfPK9Tg7N1GoPZdzYbEmMtpxuL3JlcZHhfp3
	 KfUX15OhDHAIV8HLDhYvs21T/pgqveLMU8gaRLchjtWbbDiO0ZthmwE4QsVEUbfInU
	 yHcfwBkOSz/0A==
Date: Thu, 4 Dec 2025 10:11:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <176486470918.1577839.2388132003794152045.robh@kernel.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-2-vladimir.oltean@nxp.com>


On Sat, 22 Nov 2025 21:33:33 +0200, Vladimir Oltean wrote:
> I would like to add more properties similar to tx-p2p-microvolt, and I
> don't think it makes sense to create one schema for each such property
> (transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
> etc).
> 
> Instead, let's rename to phy-common-props.yaml, which makes it a more
> adequate host schema for all the above properties.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (90%)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


