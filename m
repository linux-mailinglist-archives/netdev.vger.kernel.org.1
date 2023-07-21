Return-Path: <netdev+bounces-20047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300375D79D
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB941C216E8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18673100A1;
	Fri, 21 Jul 2023 22:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F89DDC2
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 22:41:07 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D843A93
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:41:02 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qMyna-0004qC-13;
	Fri, 21 Jul 2023 22:40:34 +0000
Date: Fri, 21 Jul 2023 23:40:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>, John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next 0/4] Remove legacy phylink behaviour
Message-ID: <ZLsJWXyFJ0oKLkEq@makrotopia.org>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On Fri, Jul 21, 2023 at 12:33:52PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> This series removes the - as far as I can tell - unreachable code in
> mtk_eth_soc that relies upon legacy phylink behaviour, and then removes
> the support in phylink for this legacy behaviour.
> 
> Patch 1 removes the clocking configuration from mtk_eth_soc for non-
> TRGMII, non-serdes based interface modes, and disables those interface
> modes prior to phylink configuration.
> 
> Patch 2 removes the mac_pcs_get_state() method from mtk_eth_soc which
> I believe is also not used - mtk_eth_soc appears not to be used with
> SFPs (which would use a kind of in-band mode) nor does any DT appear
> to specify in-band mode for any non-serdes based interface mode.
> 
> With both of those dealt with, the kernel is now free of any driver
> relying on the phylink legacy mode. Therefore, patch 3 removes support
> for this.
> 
> Finally, with the advent of a new driver being submitted today that
> makes use of state->speed in the mac_config() path, patch 4 ensures that
> any phylink_link_state member that should not be used in mac_config is
> either cleared or set to an invalid value.

Thank you for taking care of this!

For the whole series:

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

Tested on BPi-R2 (MT7623N), BPi-R3 (MT7986A) and BPi-R64 (MT7622A).
All works fine as expected.

To apply the series I needed to resolve a minor conflict due to
net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
being applied in the meantime.


> 
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 94 +++++------------------------
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  1 +
>  drivers/net/phy/phylink.c                   | 48 ++++++---------
>  include/linux/phylink.h                     | 45 ++------------
>  4 files changed, 42 insertions(+), 146 deletions(-)
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

