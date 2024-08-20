Return-Path: <netdev+bounces-120356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFC959085
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B94B219C4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2D15FA75;
	Tue, 20 Aug 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ5E5JEr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463153A8D2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193231; cv=none; b=b9DfTKqas7UV0n+vhjwvNieprEwxwS8WeG4yJx7rSfnRBKFeok8Xm86Yaz1QnuVk3sSYpGDCwn5vntd7d7UoheX/L2HCoTvG2S/liQHTA4RYcL1g0jpy4hl6oj/h6WjfG4Dnt5AJqqfpfAxcYGRC/2LElOAhaiJEchRjtX/oOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193231; c=relaxed/simple;
	bh=BHbIllKtNuVtHh9Ant8S7H/WA47lkz/44JR0SauUQ50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAMqDKPM6ueY3b1xMxUl2jAEFhtaBG+KPsa3qOQmKXQ6zVwHu4WP+CL7elaBRviocOKgjMgZRgmSLzQhqOtLU9eW47810Jumr21p/1rPwJ0y6WhEcYPyhuNbwX9Ri3BHBA+VSfLX/RFB1t5Swm1hCaF9MGylTFzktdlZxImPYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ5E5JEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEDEC4AF0E;
	Tue, 20 Aug 2024 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193230;
	bh=BHbIllKtNuVtHh9Ant8S7H/WA47lkz/44JR0SauUQ50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZ5E5JErUL76xOjwN2veBuDu13SoBwujHPxvXeX3hYYVLDlaCjRkD544yZKTyY+UE
	 8sS37eUM0fBOY/oZ8PpTwzdfCLzphIuyCdXIICWlWGx9KrOuIMp+4jYKWFJHVft8tv
	 QqbsqlR1T7dKIoF3LwKlQze08dWchIhLrPac7jU81A9i7fPgDVxf2fZJPNB6zZ+ad/
	 wW8ndqpQ5hSGJ4/uTmW7BhPrEUJ07cMICE+RNnFh3uWnij4ohH5yTE6tc+lifcnnLs
	 I8yDI8bgaQxeaIrhhf5XDqkJGoB/iYC9E5h+KNNo0ytRx8Uvyz7tXPBQx0FTr6cL6T
	 2b8xf7qVoECGw==
Date: Tue, 20 Aug 2024 15:33:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, lorenzo.bianconi83@gmail.com
Subject: Re: [PATCH net-next] net: airoha: configure hw mac address
 according to the port id
Message-ID: <20240820153349.2accb2fe@kernel.org>
In-Reply-To: <20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org>
References: <20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 13:10:09 +0200 Lorenzo Bianconi wrote:
> GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> GDM{2,3,4} can be used as wan port connected to an external
> phy module. Configure hw mac address registers according to the port id.
> 
> ---
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

nit: sign-off under ---

>  drivers/net/ethernet/mediatek/airoha_eth.c | 33 +++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index 1fb46db0c1e9..4914565c2fac 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -67,6 +67,10 @@
>  #define FE_RST_GDM3_MBI_ARB_MASK	BIT(2)
>  #define FE_RST_CORE_MASK		BIT(0)
>  
> +#define REG_FE_WAN_MAC_H		0x0030
> +#define REG_FE_WAN_MAC_LMIN		0x0034
> +#define REG_FE_WAN_MAC_LMAX		0x0038
> +
>  #define REG_FE_LAN_MAC_H		0x0040
>  #define REG_FE_LAN_MAC_LMIN		0x0044
>  #define REG_FE_LAN_MAC_LMAX		0x0048

Isn't it better to define the base address and offsets?

#define REG_FE_MAC_BASE_WAN	0x0030
#define REG_FE_MAC_BASE_LAN	0x0040
#define REG_FE_MAC_OFF_H		0x00
#define REG_FE_MAC_OFF_LMIN		0x04
#define REG_FE_MAC_OFF_LMAX		0x08

Then you only need to select the base and the rest of the code won't
have conditionals (marginally improving readability)
-- 
pw-bot: cr

