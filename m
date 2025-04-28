Return-Path: <netdev+bounces-186560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F1A9FA9A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E57167E28
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439811E282D;
	Mon, 28 Apr 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sygfhLrR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EA1E1DF9;
	Mon, 28 Apr 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872175; cv=none; b=eUz5rjClVbgUENBOx69RQBdvVn5hawpxeHzNN7er0hXiP+V9K5WQoMipUrzOJQVDkf0V8NyzWt/iLEcMfMO9ulN/2mKOLJlVeL0/89/hfIe5KMXPqJ4uCmFF3gFSj1jh7o8TN7xSyqcSq2Co6i51QTuDW4z1eUtI7r9yIcF/a8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872175; c=relaxed/simple;
	bh=JEKRoGYDYh7GpfLKStdeDdeGx4K/HvHNWFPdi0kDiGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9JitOmQkgyL80jMVhVKoFORZjLMhtglJCwQdWa8Aix89Rf9NfXur0U5Cz/EPqaqafXQEqtSFVeSK6M9SOfWoVWrRJIxsibURkWszIaFPzPxdIFdjuHCVJZXqzaADnZbuK9tXzSEGCCzhbZhsQ4AG/66xpIJ6sta6DukcW3GhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sygfhLrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED834C4CEE9;
	Mon, 28 Apr 2025 20:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745872173;
	bh=JEKRoGYDYh7GpfLKStdeDdeGx4K/HvHNWFPdi0kDiGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sygfhLrR2KlkmM8Ef+lvuMO/+7q+Gb9e1Wkr3oSZAb+rneLJg1kfHDgpNpdgZJtek
	 QFtSj3g9yjAGQkMIrhNmhNeysFDzGGUCcLkngMrJ1QMvHwFbJCa/CDtZhoG+C4zZFc
	 dtGXoilUEPAeRszU2JSGKjKyu7EdMf5dok5/FBLTDOOPIHeL72WmPPWOKiqqSZZZmo
	 WVr5x6KxpBnqDP/NBXBauIjm3tQLOGfDS8M3blQiED5Ty/puxt+C4icsk1MbIWVADj
	 1QcM0WuUIu0lvQGCO5RQahGZOCor0Flwa625vQdBXvS8Ky6xp+TogRvEKbZJ7bwJoM
	 MrfsV1L2iReFw==
Date: Mon, 28 Apr 2025 13:29:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v8 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250428132932.273fc568@kernel.org>
In-Reply-To: <20250428074424.3311978-5-lukma@denx.de>
References: <20250428074424.3311978-1-lukma@denx.de>
	<20250428074424.3311978-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 09:44:21 +0200 Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
> 
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
> 
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
> 
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Linking fails with allmodconfig

ERROR: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.o
ERROR: modpost: "mtip_forced_forward" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_port_learning_config" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_port_blocking_config" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_port_enable_config" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_port_broadcast_config" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_port_multicast_config" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_switch_en_port_separation" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_register_notifiers" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_unregister_notifiers" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined!
ERROR: modpost: "mtip_is_switch_netdev_port" [drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.ko] undefined!
WARNING: modpost: suppressed 3 unresolved symbol warnings because there were too many)

