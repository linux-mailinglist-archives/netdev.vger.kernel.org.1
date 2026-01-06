Return-Path: <netdev+bounces-247433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FECCFA573
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5C1330089BF
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5BC363C6A;
	Tue,  6 Jan 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlUhVLsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C77363C59;
	Tue,  6 Jan 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723813; cv=none; b=bqhlJEFwyZTPja9C/2K4MvQ6nVUtmYuc0ICpQmIiFz9lSPvUR1xJyh/rnSWdc8ACIbhIPSBF+339nQMFtBsSrXPdaOcilCl4ISIb0k1Fo6h6V3hNy9ZehGScxEkSaQLgkp5WiFBny9f5X27hVxmQu7RZbmFqfX4qqUynOY69KJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723813; c=relaxed/simple;
	bh=AhJ1lzOGYQf9Hfp3F9faEN/s8MDeBK5fnyeZLDXT7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3GE3Tf02bkQMFeATRpqW0RkJpISdYfKuc++g8MaMfDv57bWFpKPOkKvBrtaVvSUaw2tRPYwLHUsfR2A/k2EhvjyjId5eyywsvjm8b6x3cwvF+C0xkGtagiLU6SYCjny2d/UbxDXEKC9Opy6V4DVko0qUwbgwzwzFRpwP/KxDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlUhVLsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64299C116C6;
	Tue,  6 Jan 2026 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723812;
	bh=AhJ1lzOGYQf9Hfp3F9faEN/s8MDeBK5fnyeZLDXT7rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlUhVLsEmPAYT5hY7p1DsA5ueIVR9VHyt+IqJgSD/PH68Vbyyfz71zRJRqdQHkf5w
	 G38KnsUcV6mftOFazP5ELfmQVveXDmRMETJ30hWnqOgg1W+Ntp4ryrlRo8e8VzD7+C
	 NhnzEi+CcLTIpX87Y5k2jrcciJxJt/ifBrXT/OMGFl48kaDc9NkkD5GVyAjl2rN9Sg
	 4OImrlaFa3i1W7zaB5SYaLB6efeOQEYvrjF3RgF0uuTdlq3eBOxaHivrnAlPkVAQSJ
	 RxMR9H3XFgqwakskfmSU1II/s0V+KZxp2qoG+DExBEj+TpxkSpokCq897qXCbvumUe
	 VOC22ZvWRYfuQ==
Date: Tue, 6 Jan 2026 12:23:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-mediatek@lists.infradead.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 net-next 02/10] dt-bindings: phy-common-props: create
 a reusable "protocol-names" definition
Message-ID: <176772381112.2505111.12870885701162521979.robh@kernel.org>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103210403.438687-3-vladimir.oltean@nxp.com>


On Sat, 03 Jan 2026 23:03:55 +0200, Vladimir Oltean wrote:
> Other properties also need to be defined per protocol than just
> tx-p2p-microvolt-names. Create a common definition to avoid copying a 55
> line property.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: none
> 
>  .../bindings/phy/phy-common-props.yaml        | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


