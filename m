Return-Path: <netdev+bounces-241025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A058C7DBC4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 06:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F6C3AB0C4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 05:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60841EA7EC;
	Sun, 23 Nov 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Khc2Hr79"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96E19F41C
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763876150; cv=none; b=BdjQPh2AcCHKhYNu/9iqaNZlzKW3bkcGXGZmZBJbZJkOW39qw062jT9FifBt3Zr36arDlcEbRWWEcf9//dXb1mSLK+5PYUVJuWVquY3qXobmxAnwh0OrvdaOeEbbGJTf9ZxxVinDYt1zjSlDyiONk61/70Z1lPTFaumcIOe/H/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763876150; c=relaxed/simple;
	bh=7R2J3UHNTGq7sW4OHvxo2SU6BqTfcIBAWds//ac/RlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+AzJucyUoRxrH5wOkXxx/SyEDl6ywXSP0mtaKNSo64jRVuX+Fwh7KwvgHMGTWGGm0RZfFtAhtK87T7+y3nbaHcASx5vzlob8iAxPSfZyRngDW1/tfuUD1RUabmOK9rOLD2Ee3LzDLMSPasjQ9c6J1MNeHwfZKfEHHnTuJR8Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Khc2Hr79; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (fs276ed015.tkyc509.ap.nuro.jp [39.110.208.21])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 81B70928;
	Sun, 23 Nov 2025 06:33:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1763876015;
	bh=7R2J3UHNTGq7sW4OHvxo2SU6BqTfcIBAWds//ac/RlY=;
	h=From:To:Cc:Subject:Date:From;
	b=Khc2Hr796jzUuEDdathLgOSrUaQv1sfQn24lnohpe07FWmQ9eIcIo6PqDP34E+dgL
	 OlEI0JSy93dS5Wk23Su+fNOSnIw/dI1M9vXgeZg45FRnKiV+g82a3FOv1zsrePhr3a
	 acosTqqBzQ8Z9+O+ZNE6Zam7QUo89CEI/2WWswsg=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org,
	imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Joy Zou <joy.zou@nxp.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Subject: [PATCH] net: stmmac: imx: Do not stop RX_CLK in Rx LPI state for i.MX8MP
Date: Sun, 23 Nov 2025 14:35:18 +0900
Message-ID: <20251123053518.8478-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8MP-based Debix Model A board experiences an interrupt storm
on the ENET_EQOS IRQ (135) when connected to an EEE-enabled peer.

Setting the eee-broken-1000t DT property in the PHY node solves the
problem, which confirms that the issue is related to EEE. Device trees
for 8 boards in the mainline kernel, including the i.MX8MP EVK, set the
property, which indicates the issue is likely not limited to the Debix
board, although some of those device trees may have blindly copied the
property from the EVK.

The IRQ is documented in the reference manual as the logical OR of 4
signals:

- ENET QOS TSN LPI RX Exit Interrupt
- ENET QOS TSN Host System Interrupt
- ENET QOS TSN Host System RX Channel Interrupts, Logical OR of
  channels[4:0]
- ENET QOS TSN Host System TX Channel Interrupts, Logical OR of
  channels[4:0]

Debugging the issue showed no unmasked interrupt sources from the Host
System Interrupt (GMAC_INT_STATUS), Host System RX Channel Interrupts or
Host System TX Channel Interrupts (MTL_INT_STATUS, MTL_CHAN_INT_CTRL and
DMA_CHAN_STATUS) that was flagged at an unexpected high rate. This
leaves the LPI RX Exit Interrupt as the most likely culprit.

The reference manual doesn't clearly indicate what the interrupt signal
is, but from its name we can reasonably infer that it would be connected
to the EQOS lpi_intr_o output. That interrupt is cleared when reading
the LPI control/status register. However, its deassertion is synchronous
to the RX clock domain, so it will take time to clear. It appears that
it could even fail to clear at all, as in the following sequence of
events:

- When the PHY exits LPI mode, it restarts generating the RX clock
  (clk_rx_i input signal to the GMAC).
- The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
  the ENET_EQOS interrupt.
- Before the CPU has time to process the interrupt, the PHY enters LPI
  mode again, and stops generating the RX clock.
- The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
  registers. This does not clear lpi_intr_o as there's no clk_rx_i.

The ENET_EQOS interrupt will keep firing until the PHY resumes
generating the RX clock when it eventually exits LPI mode again.

As LPI exit is reported by the LPIIS bit in GMAC_INT_STATUS, the
lpi_intr_o signal may not have been meant to be wired to a CPU
interrupt. It can't be masked in GMAC registers, and OR'ing it to the
other GMAC interrupt signals seems to be a design mistake as it makes it
impossible to selectively mask the interrupt in the GIC either.

Setting the STMMAC_FLAG_RX_CLK_RUNS_IN_LPI platform data flag gets rid
of the interrupt storm, which confirms the above theory.

The i.MX8DXL and i.MX93, which also integrate an EQOS, may also be
affected, as hinted by the eee-broken-1000t property being set in the
i.MX8DXL EVK and the i.MX93 Variscite SoM device trees. The reference
manual of the i.MX93 indicates that the ENET_EQOS interrupt also OR's
the "ENET QOS TSN LPI RX exit Interrupt", while the i.MX8DXL reference
manual doesn't provide details about the ENET_EQOS interrupt.

Additional testing is needed with the i.MX8DXL and i.MX93, so for now
set the flag for the i.MX8MP only. The eee-broken-1000t property could
possibly be removed from some of the i.MX8MP device trees, but that also
require per-board testing.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
I have CC'ed authors and maintainers of the i.MX8DXL, i.MX8MP and i.MX93
device trees that set the eee-broken-1000t property for awareness. To
test if the property can be dropped, you will need to

- Connect the EQOS interface to an EEE-enabled peer with a 1000T link.
- Drop the eee-broken-1000t property from the device tree.
- Boot the board and check with `ethtool --show-eee` that EEE is active.
- Check the number of interrupts received from the EQOS in
  /proc/interrupts. After boot on my system (with an NFS root) I have
  ~6000 interrupts when no interrupt storm occurs, and hundreds of
  thousands otherwise.
- Apply this patch and check that EEE works as expected without any
  interrupt storm. For i.MX8DXL and i.MX93, you will need to set the
  STMMAC_FLAG_RX_CLK_RUNS_IN_LPI in the corresponding imx_dwmac_ops
  instances in drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 4268b9987237..125bf435c281 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -362,8 +362,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
-		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
+	plat_dat->flags |= data->flags;
 
 	/* Default TX Q0 to use TSO and rest TXQ for TBS */
 	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
@@ -401,7 +400,8 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
 	.addr_width = 34,
 	.mac_rgmii_txclk_auto_adj = false,
 	.set_intf_mode = imx8mp_set_intf_mode,
-	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY,
+	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY
+	       | STMMAC_FLAG_RX_CLK_RUNS_IN_LPI,
 };
 
 static struct imx_dwmac_ops imx8dxl_dwmac_data = {

base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
Regards,

Laurent Pinchart


