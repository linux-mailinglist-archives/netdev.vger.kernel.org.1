Return-Path: <netdev+bounces-24011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1676E717
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F81C21553
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5018C09;
	Thu,  3 Aug 2023 11:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1718B13
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA2C433C8;
	Thu,  3 Aug 2023 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691062770;
	bh=+K+JAySmTUowlnbVqwziUzl1bReyozbO+guU69SBB34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlYDs6lFk2yG8HjpZ+tB0KD7LsTCBbRdO5X913YeGZAw29/Ll4XDRdKd67yEHeySo
	 2iri4L99AmVgfL9ksUqXWmReepqQcmD3efTrPAVK/iEXrniQkNPfxrt8jmPRyXo+jd
	 ApetWp+/RnZD7U7n//UNQVeg9V2L+z1+rviLwKM2ZtsVf+sxrOvnHm++AhN5T+rcN3
	 uSOBcnV+Z2LNeowhLurCC/yahz0xh+UAYL09oK54M3pL18q5g9REQOoWowm/hBd0gX
	 TedKkdEzQhjtS6pTsxvdrkPlFxSKakZe3XywqEuXi89KCN409oFgliIa/AFqzHozpw
	 NwpP8487pzJMg==
Date: Thu, 3 Aug 2023 13:39:25 +0200
From: Simon Horman <horms@kernel.org>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <ZMuR7XKm9Jelh0Sq@kernel.org>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-3-nick.hawkins@hpe.com>

On Wed, Aug 02, 2023 at 03:18:21PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Universal Ethernet MACs that can be
> connected externally to several physical devices. From an external
> interface perspective the BMC provides two SERDES interface connections
> capable of either SGMII or 1000Base-X operation. The BMC also provides
> a RMII interface for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration. The MDIO(mdio1) interface from
> the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
> on the two SERDES interface connections.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

...

> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 5a274b99f299..b4921b84be51 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -80,6 +80,7 @@ source "drivers/net/ethernet/fujitsu/Kconfig"
>  source "drivers/net/ethernet/fungible/Kconfig"
>  source "drivers/net/ethernet/google/Kconfig"
>  source "drivers/net/ethernet/hisilicon/Kconfig"
> +source "drivers/net/ethernet/hpe/Kconfig"
>  source "drivers/net/ethernet/huawei/Kconfig"
>  source "drivers/net/ethernet/i825xx/Kconfig"
>  source "drivers/net/ethernet/ibm/Kconfig"

Hi Nick,

I think this hunk belongs in [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver.
As it is that patch where drivers/net/ethernet/hpe/Kconfig is added.
And as things stands, the above caused a build failure.

