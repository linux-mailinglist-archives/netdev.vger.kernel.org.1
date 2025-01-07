Return-Path: <netdev+bounces-156039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2DA04B83
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8313A115D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1F1F3D47;
	Tue,  7 Jan 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="S8Uy9QXE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88C1802AB;
	Tue,  7 Jan 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285136; cv=none; b=WrZPBjlaXO10bxst1PimwSGfWgV/H0tjgsdc6pAZUyCFPY0q0jA03GSYOgEyDSs3O7SQdPvL1UzC1SdrQEpWfcLV38zrycr3drdkDp6r6Zo75HSzD+YeM5f/ZVRm5Xwul4eObxbQJElEh6Ue84AJ3GGK3VciXvN9q3GrY7HPen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285136; c=relaxed/simple;
	bh=7TWVcm5gj2YJKy6fSbKbxBnXOQzMrafq8/90Pf/jNKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nq2Mpcx68kwBWO9cZHsmeF4DTI87r0Sam/rdbGcNh+5TptbNM1MfCSxJupX33heir0nt4oQF+cyvBDQie5jnib8FGxTuZTXOTnQQi5LA9tty0NYxDo6Ta/2ipBoclmZIdhWOrpXVqq8eXB5HYbcek8uPi6IAAG6JjFgx96Z+9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=S8Uy9QXE; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1736285132; x=1736889932; i=parker@finest.io;
	bh=/brQQayzpusAC1S4Zx7Av705xAT7WNHQ+b64nsO7Lf4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S8Uy9QXEdeN6+G7BmIROkQRq2EIARCjiUBHVtk82oZ73hRuEg/u0yclMQOAoqOXA
	 cnlfluFtuPOUUXa1P2GUqP9NGuD0C44V8VzAIYGOnwdqWDXOjEbR6gglO/dQPLSCQ
	 XVtyymJToNJIbtEmZV4OvGxP/PwwOGs4FE7Evj+cFNn2zAa8WlpeCihmEuoJ5lX/a
	 6P84hKEcToSnBwXWTTyhotCKmhDRSEGJvF62OhXLRu3PCLoozXNVLpVndegtA+mpR
	 OszNqSrktovTRDtfVTjX+vG1C3QXRuyjOuNEjRTUDVtwrVV3MlthkIy9ZCsZOI14D
	 MrCfdw6IIx2SWLbj9A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPF2s-1tQrEa07CC-008E1i; Tue, 07 Jan
 2025 22:25:32 +0100
From: Parker Newman <parker@finest.io>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH net v2 1/1] net: stmmac: dwmac-tegra: Read iommu stream id from device tree
Date: Tue,  7 Jan 2025 16:24:59 -0500
Message-ID: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3cF6Lf2FPSJYeTOfnlwfnoLs8V65pV/CjFR0Bt2bRPBVWkZYpfC
 zoLEm36PcbLQod8MRyFZE2fTIdgBb5FHZh1bMd7SOK2JczwK++q/urPVKd91Cg4KxbMd/Mm
 xGEuKB0dSkv4Tgd8cYq1lCUii5B2zeNgKUNc9B18hzzSdRDCfNem8IHpDdA/BPc4kQT11oJ
 xptxXyDxRWCM8uhoO/nwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LT1OCKW1FRA=;SRulpHqOygDN/wHftgkfQJy+Dbg
 xSMt44C7PNd2NEq2WrPzdZlesaaMEsbEoNDzLTLiYrHTTsMEgI173iAFZJeeCtOAhoOpDAN3p
 dy6vTATSq5+xkFmeh9xRBkPqpgclLXmBy77sgLTytprsqI8wlA5fk+kTm7HdnLeymbnaMJyXO
 isdvMBNa9AZFcb6jvXzOJkk5dGOx5eQK6R4xhROvXhkvIVLLo2RdnqJmlKN27u7asfnVhrJJ5
 FLcN534tjWNG6Cf2DCaCy20uGMLS9EXx5/tQpl7oH4qnl3hnyoquX5Hn/VODBlquIH6tqq3aY
 V8jDZHe1wFmtCV94PIOLS3Ow7yTOHqBG9UscNVxWgVuuXhVNlw1Pa/s+ILz/OJS8Hfpm7F55I
 x1kxvNLhSwyQU0M9xtO8YvM5EJTmGwzUFuwgdgmwXdcipfFAfZ/i1FHho8Z91pBUuQtEyUBuG
 qBIC02KAcjwNjYFcCIFfcX702T/ldklGh37Bs1ReJBvQsyBNncLt5G6yFoBad8B/cAUkRzf2D
 jYCNqt86p+1IPdeuxKuMezK+U8sIn9QF2enowmH5/qPwOMwlbJjwXg+I7NtHN+Z9UDFpo+vG1
 FU9eXfH153Sr0nfcYNlRaRi9oboE1ckikVy/ubSfSQQFMoGNr/W053wYECrMtpDQEiPUqV4z0
 z/wluQD/BjwCeRLs3oK3nA+6fs/Y0B1mD54nvb2P7slGnVA16VFpKwu3qAisN6y2Yo5VsMBd8
 x1x3tb0bjRJOQbVzOFmdZJtUtpKTvhmHGlSCZ49Ji35ZO4MK5m++BxkIOxQw4h3j2iKKx9egy
 2MN6Y0jJtGpG7bm+Ez+Z4y+rHkg3eA2rOgc0vy+knMIfFXIw9Si7KWKdXngTDcw6ReOKUEEXo
 5AAO4lCHwVFzXNbdUeaxzT+62/qV3CcOdiIy+ZXlau6m1X67Gc9KJtin93kTldP20o7M1UUOg
 LqH5Y3OTiQtJsDaGk7npDoReJVNF5d8YeuhxrZWtcvvbDeKz3++aKDDlojzu8JO12KG3txHUF
 7Q0DV+LC08fDo/arsr8YhNuoleAjZCCG7pFTajU

From: Parker Newman <pnewman@connecttech.com>

Nvidia's Tegra MGBE controllers require the IOMMU "Stream ID" (SID) to be
written to the MGBE_WRAP_AXI_ASID0_CTRL register.

The current driver is hard coded to use MGBE0's SID for all controllers.
This causes softirq time outs and kernel panics when using controllers
other than MGBE0.

Example dmesg errors when an ethernet cable is connected to MGBE1:

[  116.133290] tegra-mgbe 6910000.ethernet eth1: Link is Up - 1Gbps/Full -=
 flow control rx/tx
[  121.851283] tegra-mgbe 6910000.ethernet eth1: NETDEV WATCHDOG: CPU: 5: =
transmit queue 0 timed out 5690 ms
[  121.851782] tegra-mgbe 6910000.ethernet eth1: Reset adapter.
[  121.892464] tegra-mgbe 6910000.ethernet eth1: Register MEM_TYPE_PAGE_PO=
OL RxQ-0
[  121.905920] tegra-mgbe 6910000.ethernet eth1: PHY [stmmac-1:00] driver =
[Aquantia AQR113] (irq=3D171)
[  121.907356] tegra-mgbe 6910000.ethernet eth1: Enabling Safety Features
[  121.907578] tegra-mgbe 6910000.ethernet eth1: IEEE 1588-2008 Advanced T=
imestamp supported
[  121.908399] tegra-mgbe 6910000.ethernet eth1: registered PTP clock
[  121.908582] tegra-mgbe 6910000.ethernet eth1: configuring for phy/10gba=
se-r link mode
[  125.961292] tegra-mgbe 6910000.ethernet eth1: Link is Up - 1Gbps/Full -=
 flow control rx/tx
[  181.921198] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  181.921404] rcu: 	7-....: (1 GPs behind) idle=3D540c/1/0x40000000000000=
02 softirq=3D1748/1749 fqs=3D2337
[  181.921684] rcu: 	(detected by 4, t=3D6002 jiffies, g=3D1357, q=3D1254 =
ncpus=3D8)
[  181.921878] Sending NMI from CPU 4 to CPUs 7:
[  181.921886] NMI backtrace for cpu 7
[  181.922131] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Kdump: loaded Not tain=
ted 6.13.0-rc3+ #6
[  181.922390] Hardware name: NVIDIA CTI Forge + Orin AGX/Jetson, BIOS 202=
402.1-Unknown 10/28/2024
[  181.922658] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  181.922847] pc : handle_softirqs+0x98/0x368
[  181.922978] lr : __do_softirq+0x18/0x20
[  181.923095] sp : ffff80008003bf50
[  181.923189] x29: ffff80008003bf50 x28: 0000000000000008 x27: 0000000000=
000000
[  181.923379] x26: ffffce78ea277000 x25: 0000000000000000 x24: 0000001c61=
befda0
[  181.924486] x23: 0000000060400009 x22: ffffce78e99918bc x21: ffff800080=
18bd70
[  181.925568] x20: ffffce78e8bb00d8 x19: ffff80008018bc20 x18: 0000000000=
000000
[  181.926655] x17: ffff318ebe7d3000 x16: ffff800080038000 x15: 0000000000=
000000
[  181.931455] x14: ffff000080816680 x13: ffff318ebe7d3000 x12: 0000000034=
64d91d
[  181.938628] x11: 0000000000000040 x10: ffff000080165a70 x9 : ffffce78e8=
bb0160
[  181.945804] x8 : ffff8000827b3160 x7 : f9157b241586f343 x6 : eeb6502a01=
c81c74
[  181.953068] x5 : a4acfcdd2e8096bb x4 : ffffce78ea277340 x3 : 00000000ff=
ffd1e1
[  181.960329] x2 : 0000000000000101 x1 : ffffce78ea277340 x0 : ffff318ebe=
7d3000
[  181.967591] Call trace:
[  181.970043]  handle_softirqs+0x98/0x368 (P)
[  181.974240]  __do_softirq+0x18/0x20
[  181.977743]  ____do_softirq+0x14/0x28
[  181.981415]  call_on_irq_stack+0x24/0x30
[  181.985180]  do_softirq_own_stack+0x20/0x30
[  181.989379]  __irq_exit_rcu+0x114/0x140
[  181.993142]  irq_exit_rcu+0x14/0x28
[  181.996816]  el1_interrupt+0x44/0xb8
[  182.000316]  el1h_64_irq_handler+0x14/0x20
[  182.004343]  el1h_64_irq+0x80/0x88
[  182.007755]  cpuidle_enter_state+0xc4/0x4a8 (P)
[  182.012305]  cpuidle_enter+0x3c/0x58
[  182.015980]  cpuidle_idle_call+0x128/0x1c0
[  182.020005]  do_idle+0xe0/0xf0
[  182.023155]  cpu_startup_entry+0x3c/0x48
[  182.026917]  secondary_start_kernel+0xdc/0x120
[  182.031379]  __secondary_switched+0x74/0x78
[  212.971162] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/ta=
sks: { 7-.... } 6103 jiffies s: 417 root: 0x80/.
[  212.985935] rcu: blocking rcu_node structures (internal RCU debug):
[  212.992758] Sending NMI from CPU 0 to CPUs 7:
[  212.998539] NMI backtrace for cpu 7
[  213.004304] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Kdump: loaded Not tain=
ted 6.13.0-rc3+ #6
[  213.016116] Hardware name: NVIDIA CTI Forge + Orin AGX/Jetson, BIOS 202=
402.1-Unknown 10/28/2024
[  213.030817] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  213.040528] pc : handle_softirqs+0x98/0x368
[  213.046563] lr : __do_softirq+0x18/0x20
[  213.051293] sp : ffff80008003bf50
[  213.055839] x29: ffff80008003bf50 x28: 0000000000000008 x27: 0000000000=
000000
[  213.067304] x26: ffffce78ea277000 x25: 0000000000000000 x24: 0000001c61=
befda0
[  213.077014] x23: 0000000060400009 x22: ffffce78e99918bc x21: ffff800080=
18bd70
[  213.087339] x20: ffffce78e8bb00d8 x19: ffff80008018bc20 x18: 0000000000=
000000
[  213.097313] x17: ffff318ebe7d3000 x16: ffff800080038000 x15: 0000000000=
000000
[  213.107201] x14: ffff000080816680 x13: ffff318ebe7d3000 x12: 0000000034=
64d91d
[  213.116651] x11: 0000000000000040 x10: ffff000080165a70 x9 : ffffce78e8=
bb0160
[  213.127500] x8 : ffff8000827b3160 x7 : 0a37b344852820af x6 : 3f049caedd=
1ff608
[  213.138002] x5 : cff7cfdbfaf31291 x4 : ffffce78ea277340 x3 : 00000000ff=
ffde04
[  213.150428] x2 : 0000000000000101 x1 : ffffce78ea277340 x0 : ffff318ebe=
7d3000
[  213.162063] Call trace:
[  213.165494]  handle_softirqs+0x98/0x368 (P)
[  213.171256]  __do_softirq+0x18/0x20
[  213.177291]  ____do_softirq+0x14/0x28
[  213.182017]  call_on_irq_stack+0x24/0x30
[  213.186565]  do_softirq_own_stack+0x20/0x30
[  213.191815]  __irq_exit_rcu+0x114/0x140
[  213.196891]  irq_exit_rcu+0x14/0x28
[  213.202401]  el1_interrupt+0x44/0xb8
[  213.207741]  el1h_64_irq_handler+0x14/0x20
[  213.213519]  el1h_64_irq+0x80/0x88
[  213.217541]  cpuidle_enter_state+0xc4/0x4a8 (P)
[  213.224364]  cpuidle_enter+0x3c/0x58
[  213.228653]  cpuidle_idle_call+0x128/0x1c0
[  213.233993]  do_idle+0xe0/0xf0
[  213.237928]  cpu_startup_entry+0x3c/0x48
[  213.243791]  secondary_start_kernel+0xdc/0x120
[  213.249830]  __secondary_switched+0x74/0x78

This bug has existed since the dwmac-tegra driver was added in Dec 2022
(See Fixes tag below for commit hash).

The Tegra234 SOC has 4 MGBE controllers, however Nvidia's Developer Kit
only uses MGBE0 which is why the bug was not found previously. Connect Tec=
h
has many products that use 2 (or more) MGBE controllers.

The solution is to read the controller's SID from the existing "iommus"
device tree property. The 2nd field of the "iommus" device tree property
is the controller's SID.

Device tree snippet from tegra234.dtsi showing MGBE1's "iommus" property:

smmu_niso0: iommu@12000000 {
        compatible =3D "nvidia,tegra234-smmu", "nvidia,smmu-500";
...
}

/* MGBE1 */
ethernet@6900000 {
	compatible =3D "nvidia,tegra234-mgbe";
...
	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE_VF1>;
...
}

Nvidia's arm-smmu driver reads the "iommus" property and stores the SID in
the MGBE device's "fwspec" struct. The dwmac-tegra driver can access the
SID using the tegra_dev_iommu_get_stream_id() helper function found in
linux/iommu.h.

Calling tegra_dev_iommu_get_stream_id() should not fail unless the "iommus=
"
property is removed from the device tree or the IOMMU is disabled.

While the Tegra234 SOC technically supports bypassing the IOMMU, it is not
supported by the current firmware, has not been tested and not recommended=
.
More detailed discussion with Thierry Reding from Nvidia linked below.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Link: https://lore.kernel.org/netdev/cover.1731685185.git.pnewman@connectt=
ech.com
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--

Changes v2:
- dropped cover letter
- added more detail to commit message
- rebased to latest netdev tree

 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac-tegra.c
index 3827997d2132..dc903b846b1b 100644
=2D-- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/module.h>
@@ -19,6 +20,8 @@ struct tegra_mgbe {
 	struct reset_control *rst_mac;
 	struct reset_control *rst_pcs;

+	u32 iommu_sid;
+
 	void __iomem *hv;
 	void __iomem *regs;
 	void __iomem *xpcs;
@@ -50,7 +53,6 @@ struct tegra_mgbe {
 #define MGBE_WRAP_COMMON_INTR_ENABLE	0x8704
 #define MAC_SBD_INTR			BIT(2)
 #define MGBE_WRAP_AXI_ASID0_CTRL	0x8400
-#define MGBE_SID			0x6

 static int __maybe_unused tegra_mgbe_suspend(struct device *dev)
 {
@@ -84,7 +86,7 @@ static int __maybe_unused tegra_mgbe_resume(struct devic=
e *dev)
 	writel(MAC_SBD_INTR, mgbe->regs + MGBE_WRAP_COMMON_INTR_ENABLE);

 	/* Program SID */
-	writel(MGBE_SID, mgbe->hv + MGBE_WRAP_AXI_ASID0_CTRL);
+	writel(mgbe->iommu_sid, mgbe->hv + MGBE_WRAP_AXI_ASID0_CTRL);

 	value =3D readl(mgbe->xpcs + XPCS_WRAP_UPHY_STATUS);
 	if ((value & XPCS_WRAP_UPHY_STATUS_TX_P_UP) =3D=3D 0) {
@@ -241,6 +243,12 @@ static int tegra_mgbe_probe(struct platform_device *p=
dev)
 	if (IS_ERR(mgbe->xpcs))
 		return PTR_ERR(mgbe->xpcs);

+	/* get controller's stream id from iommu property in device tree */
+	if (!tegra_dev_iommu_get_stream_id(mgbe->dev, &mgbe->iommu_sid)) {
+		dev_err(mgbe->dev, "failed to get iommu stream id\n");
+		return -EINVAL;
+	}
+
 	res.addr =3D mgbe->regs;
 	res.irq =3D irq;

@@ -346,7 +354,7 @@ static int tegra_mgbe_probe(struct platform_device *pd=
ev)
 	writel(MAC_SBD_INTR, mgbe->regs + MGBE_WRAP_COMMON_INTR_ENABLE);

 	/* Program SID */
-	writel(MGBE_SID, mgbe->hv + MGBE_WRAP_AXI_ASID0_CTRL);
+	writel(mgbe->iommu_sid, mgbe->hv + MGBE_WRAP_AXI_ASID0_CTRL);

 	plat->flags |=3D STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP;


base-commit: 8ce4f287524c74a118b0af1eebd4b24a8efca57a
=2D-
2.47.0


