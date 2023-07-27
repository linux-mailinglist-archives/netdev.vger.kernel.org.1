Return-Path: <netdev+bounces-21707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371A764545
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4514281C56
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BF20F1;
	Thu, 27 Jul 2023 05:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70673D72
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3DC433C7;
	Thu, 27 Jul 2023 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690434452;
	bh=cu24BaSm7VP+M85cUQ+qtwEsAD/RBo9rNcVLe3xa3fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7MpNZdjK9fIYG2Pm23NLI7mZ3K/ANtsyc1c9bdh/SW1J9LKevMEUip+NbtDDOf//
	 D5f+QXcGPKpxao454lTjfOErll5zWqeONgsBqbWLoE5kk+asdbstSZfADqGFma+Huu
	 slsZjURasGfqLtK9Z+GdkrNK9pymB5jlRoRrbwHOZBJOvFl/7dr3crLLQnsEkJa68g
	 HlVB+M/xTdoUteD9iMKyNxAPrHSJnnEG0JXvjtV1AkGL/IU9YbdhxxNL45Xrj3DaJF
	 d4mpBfzc7TbyNNsyn2zVuJtuI5/G6uzhns67xPHWVP4hECjISAq/mGH65DnL8sxi+F
	 K9DlyBwGMn/og==
Date: Wed, 26 Jul 2023 22:07:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Greg Ungerer <gerg@kernel.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v6 0/8] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <20230726220730.6f78c790@kernel.org>
In-Reply-To: <cover.1690246066.git.daniel@makrotopia.org>
References: <cover.1690246066.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 01:51:00 +0100 Daniel Golle wrote:
> The MediaTek MT7988 SoC introduces a new version (3) of the NETSYS
> block and comes with three instead of two MACs.
> 
> The first MAC can be internally connected to a built-in Gigabit
> Ethernet switch with four 1000M/100M/10M twisted pair user ports.
> 
> The second MAC can be internally connected to a built-in 2500Base-T
> Ethernet PHY.
> 
> There are two SerDes units which can be operated in USXGMII, 10GBase-(K)R,
> 5GBase-R, 2500Base-X, 1000Base-X or SGMII interface mode.
> 
> This series adds initial support for NETSYS v3 and the first MAC of the
> MT7988 SoC connecting the built-in DSA switch.
> 
> The switch is supported since commit 110c18bfed414 ("net: dsa: mt7530:
> introduce driver for MT7988 built-in switch").
> 
> Basic support for the 1000M/100M/10M built-in PHYs connected to the
> switch ports is present since commit ("98c485eaf509b net: phy: add
> driver for MediaTek SoC built-in GE PHYs").

This was dangerously close to Russell's recent work.
Do double check that I haven't fumbled applying it..

