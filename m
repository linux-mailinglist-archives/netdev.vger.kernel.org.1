Return-Path: <netdev+bounces-17536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A8751ED1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D171C21272
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A0107A8;
	Thu, 13 Jul 2023 10:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61788101FC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:27:48 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18E119
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:27:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qJtXu-0000xP-O8; Thu, 13 Jul 2023 12:27:38 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qJtXs-0003q8-0S; Thu, 13 Jul 2023 12:27:36 +0200
Date: Thu, 13 Jul 2023 12:27:35 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: linux-imx@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: i.MX8MP EQOS + 10/100MBit RMII Phy Issue
Message-ID: <20230713102735.qd3ispdabpdpxawt@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

I currently debug an issue regarding the i.MX8MP EQOS in combination
with an 10/100Mbit RMII phy. The phy supplies the 50MHz rmii-refclk and
is working in 100Mbit but stops working in 10Mbit mode.

While my debugging session I found a great IP core signal overview from
STM [1]. The ETH signals matches the ones also listed in the i.MX8MP
refernce manual, therefore I think that the NXP used IP core version
does match the STM one very well.

As seen in the overview [1] the SoC has to provide the correct rx/tx
clocks to the EQOS core which depends on the speed (10/100/1000) and the
interface (mii, rmii, rgmii). The clock selection can be done by the
mac_speed_o[1:0] signals or have to be done separatly via software _but_
it have to be done outside the EQOS IP core.

The NXP i.MX8MP RM has some integration registers layed within the
IOMUXC_GPR1 register to select the interface (MII/RGMII/MII) but no bits
to select correct speed.

Since the RMII 100Mbit case is working I now assume:
 1) NXP has a /2 predivider but no /20 predivder nor a mux to select
    between both. Is this correct?
 2) NXP has all dividers and muxes but did not document these. If so can
    you provide us the registers and bits?

I look forward to here from NXP :)

Regards,
  Marco

PS: - I also checked the Rockchip refernce manual and they do have
      proper clock dividers and muxes like STM.
    - I did test the 10Mbit case on the i.MX8MP-EVK as well which does
      work because they use a RGMII interface which does have a
      different clock handling.

[1] https://community.st.com/t5/stm32-mpus/faq-stm32mp1-how-to-configure-ethernet-phy-clocks/ta-p/49266; figure 83

