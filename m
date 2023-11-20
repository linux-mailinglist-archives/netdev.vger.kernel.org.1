Return-Path: <netdev+bounces-49412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC017F1F48
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670DEB210AF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A87374DC;
	Mon, 20 Nov 2023 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdNq4Agx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECA38F87;
	Mon, 20 Nov 2023 21:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AEDC433C7;
	Mon, 20 Nov 2023 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700516259;
	bh=R8d5DEDGigkNAFbk6cm05T5sdaFfbW9r9xeJSv+nEM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CdNq4Agx/5Lh12IrFa4SP/P1QMpBsjmDsuWTwI9ap1y4jYystf2HHApsKQhXiirfw
	 5wY3x1qwWbiKKIpCRvpGud1kG2ogyUQRrQL8Q6vvcrQoDGcBV3UFNjOxjyf25d/ft4
	 PfGOHq9VsS8cPA5DIck4yFwBqfOQs3UPdg6PqrlUbgOPpO7JCom4GiEqOApwI3MPUW
	 LFpAdCyDJ0WBxv9QPlPe6uVS9Sr1RhYdqc7L0WOWqUiRheguE7EI5nt3lbVZByXnFV
	 7F8s9kjj59a27dj6fU3Aub768mo2q2fqzMS6uwHl+HuzbJ+03R8KTgD4WC3WACLxBx
	 4uWi/Qt89VEfw==
Date: Mon, 20 Nov 2023 13:37:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120133737.70dde657@kernel.org>
In-Reply-To: <20231120211759.j5uvijsrgt2jqtwx@skbuf>
References: <20231118183433.30ca1d1a@kernel.org>
	<20231120104439.15bfdd09@kmaincent-XPS-13-7390>
	<20231120105255.cgbart5amkg4efaz@skbuf>
	<20231120121440.3274d44c@kmaincent-XPS-13-7390>
	<20231120120601.ondrhbkqpnaozl2q@skbuf>
	<20231120144929.3375317e@kmaincent-XPS-13-7390>
	<20231120142316.d2emoaqeej2pg4s3@skbuf>
	<20231120093723.4d88fb2a@kernel.org>
	<20231120190023.ymog4yb2hcydhmua@skbuf>
	<20231120115839.74ee5492@kernel.org>
	<20231120211759.j5uvijsrgt2jqtwx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 23:17:59 +0200 Vladimir Oltean wrote:
> Forget the concept of an active hwtstamp provider, just open up the
> knobs of _all_ possible hwtstamp providers for a NIC. Simultaneously!
> To make one active and all the others inactive, just use
> HWTSTAMP_FILTER_NONE/HWTSTAMP_TX_OFF for all except one, and the desired
> enum hwtstamp_rx_filters / enum hwtstamp_tx_types for the active one.
> Live with this expanded configuration model for a while, just restricted
> for a single active timestamping layer, and then, once user space is
> ready for an enhanced struct scm_timestamping which supports potentially
> multiple cmsgs with distinct hwtstamps, remove the restriction and let
> it all rip! Everybody gets their pony!
> 
> Additionally, SIOCSHWTSTAMP is kinda rusty, has a fixed binary format,
> and is not extensible to target a specific hwtstamp provider. So a
> netlink conversion of that, as a first step, would of course be great.
> 
> Is it an accurate summary?

Yes.

For now we can impose the requirement that only one can be active 
easily at the kernel level. But the uAPI should allow expressing more.

> You've partially answered above. The mix of timestamps coming from the
> PHY/MAC and those coming from the DMA is unrepresentable in today's
> UAPI, and is just fine-tuned to work for the existing use case of "PTP
> gets PHY/MAC, everything else gets DMA".
> 
> Still not 100% clear what would the proper UAPI (separate user-controllable
> RX filters for PHY, MAC and DMA) gain, in addition to what exists in mlx5.

Too late for mlx5 but I'm anticipating that more vendors will start
needing such configuration in the future. At which point it will be
good to have an API in place.

