Return-Path: <netdev+bounces-51312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2D7FA110
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF81F20CD5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CCA2EAF9;
	Mon, 27 Nov 2023 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4091D4B
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:27:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1r7beF-0001b0-KC; Mon, 27 Nov 2023 14:27:39 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1r7beE-00BxH9-MI; Mon, 27 Nov 2023 14:27:38 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1r7beE-000DEU-1v;
	Mon, 27 Nov 2023 14:27:38 +0100
Message-ID: <9b3cdf0da11d59579cbf3ffe959c2a4ebba5672d.camel@pengutronix.de>
Subject: Re: [RFC PATCH 8/8] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Golle <daniel@makrotopia.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 John Crispin <john@phrozen.org>,  Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,  Russell King
 <linux@armlinux.org.uk>, Alexander Couzens <lynxis@fe80.eu>,
 netdev@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,  linux-phy@lists.infradead.org
Date: Mon, 27 Nov 2023 14:27:38 +0100
In-Reply-To: <cad139116f916ae4f63d3df9900835af3f6b5cd2.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
	 <cad139116f916ae4f63d3df9900835af3f6b5cd2.1699565880.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Do, 2023-11-09 at 21:52 +0000, Daniel Golle wrote:
> MT7988 comes with a built-in 2.5G PHY as well as SerDes lanes to
> connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
> 2500Base-X, 1000Base-X and Cisco SGMII interface modes.
>=20
> Implement support for configuring for the new paths to SerDes interfaces
> and the internal 2.5G PHY.
>=20
> Add USXGMII PCS driver for 10GBase-R, 5GBase-R and USXGMII mode, and
> setup the new PHYA on MT7988 to access the also still existing old
> LynxI PCS for 1000Base-X, 2500Base-X and Cisco SGMII PCS interface
> modes.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
[...]
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.h
> index 9ae3b8a71d0e6..ba5998ef7965e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -15,6 +15,7 @@
>  #include <linux/u64_stats_sync.h>
>  #include <linux/refcount.h>
>  #include <linux/phylink.h>
> +#include <linux/reset.h>

I can't see what this is required for?

regards
Philipp

