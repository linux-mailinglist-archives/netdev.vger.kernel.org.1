Return-Path: <netdev+bounces-187473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30EAA74A0
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA351896E8E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC62566E1;
	Fri,  2 May 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEJCUjNA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1A255F50;
	Fri,  2 May 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195210; cv=none; b=QKOI8N2dpZry/l//ico5lLbM2ln/DMz0t+6Kiecq+a90XMtNtdrVO5qsxueVxoRzYj3THgx3R4jK3x4s6B5Pw0U7fVd0d5OduqIGnNxGnhqM5SUDq/DZAc4q6xYBtV/D+uZJoLvLTzNVaWbSQKd/fk/XeiIL8qP3KK73obGnwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195210; c=relaxed/simple;
	bh=yx8MFH01X2N39XwTWzq6+ATHZglg/J+RztBenNzgst4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxGLTplq7Goyczap+QBaT/RBSlM4xNSINPm+87JjpEtqsOnkkjs3pYDQYdzbGIiDyaGuc3vgl10g/FkBDm7yePxy5ev2q3K0iAiCVldy7vMDfWVu2BKGFoDsZiiEAGXZQbQigtWopW+Rt8SiWTaMg4GdiZ5zZK/tYqJBoYj8n0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEJCUjNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FFC4CEE4;
	Fri,  2 May 2025 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746195209;
	bh=yx8MFH01X2N39XwTWzq6+ATHZglg/J+RztBenNzgst4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HEJCUjNAg/oXF9wvqym9vnorYBbBg6HAk8rKG4heSNpO90IPRIhdrchKRHxuV5Yia
	 FDObzWatACdFKKIjNTGgziRG8XDnlbX3tTHP5pumonsFOuTe5HXLxvUDbpg8QKr1eU
	 u1S3Qb29+tkYAE5kDYb7itLzsZNPRnFmJGqErxsK2DkTO6Eeg/pafXwJG1eV2fwAUO
	 p4jQdZPZrqfAIhQLrsD3cQvilI+D/ngIya0x+i95Ynr2jv646qdUHjywWLzec/8oPk
	 7znjw5WTNKwzxZBjNxCbspkFRExq+NZ7bz5DVg39YkN7nV/01JHWgffaeRdIuI1Cii
	 QDzMKHL1LUpDQ==
Date: Fri, 2 May 2025 07:13:28 -0700
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
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250502071328.069d0933@kernel.org>
In-Reply-To: <20250502074447.2153837-5-lukma@denx.de>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 May 2025 09:44:44 +0200 Lukasz Majewski wrote:
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

Now that basic build is green the series has advanced to full testing,
where coccicheck says:

drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1961:1-6: WARNING: invalid free of devm_ allocated data
drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1237:16-19: ERROR: bus is NULL but dereferenced.
-- 
pw-bot: cr

