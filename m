Return-Path: <netdev+bounces-16615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BF74E018
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A1228118B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DC156D6;
	Mon, 10 Jul 2023 21:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1A14AB4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:14:38 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8712E
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:14:34 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9F6B7209ED;
	Mon, 10 Jul 2023 23:14:30 +0200 (CEST)
Date: Mon, 10 Jul 2023 23:14:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, francesco.dolcini@toradex.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/4] net: phy: c45: add support for
 1000BASE-T1
Message-ID: <ZKx0sjNPWu3s4JdI@francesco-nb.int.toradex.com>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-4-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710205900.52894-4-eichest@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:58:59PM +0200, Stefan Eichenberger wrote:
> Add support for 1000BASE-T1 to the forced link setup.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> ---
>  drivers/net/phy/phy-c45.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 93ed072233779..ec1232066b914 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
...

> @@ -176,6 +176,12 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
>  		ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
>  		if (ret < 0)
>  			return ret;
> +
> +		bt1_ctrl = 0;
> +		if (phydev->speed == SPEED_1000)
> +			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
> +		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
> +			       MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);

check the return value here?


