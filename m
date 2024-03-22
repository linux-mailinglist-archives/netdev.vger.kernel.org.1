Return-Path: <netdev+bounces-81295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A73886ED1
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2899286570
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38154C61B;
	Fri, 22 Mar 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Rmrw3YlZ"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6B20DD2
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118451; cv=none; b=rpdLRRCe4czc90UnEBBnHINLmxHdAcOXssL9LdkXENN2zpfxx8n9delSuHcRc64V42Gg6gpopdlT3Cw0Thkpg236Ev8Xy64yBRGFPT3+d0d4LBnQsAXRJO1PCtdPe18DjH+GUyMaxPT9xujYoZuh7HQP+Z3rmO0oI2sIvnxe9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118451; c=relaxed/simple;
	bh=2FrpwLKEH9RJEu0QrBR+sesJaCus16CgK96wdHSW7Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LfJTSMAHCYkAVOlCGSL8uLDmdGln3yDQId9kJ1PTPZvkh+juOU4Juk1ovpzjvB2PdnfBOG8BaG/j4lETZC4HSPFW9ZyNGM7IIAGnbN4GJBCFrqwH8ld0OCi6zbHAcn2zlxOjglWKVFZUhX3+sovhcZDnOOrs41SPQDuOBYvMP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=Rmrw3YlZ; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 42MEeEwI502560
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1711118414; bh=fHeY00Zyzub+WQhymVe04REpfVCFWDWp3DsnxLZ4UOc=;
	h=From:To:Cc:Subject:Date:Message-Id:From;
	b=Rmrw3YlZ561o3AC33pZSeu+0zDVaHs70lfufcMGCipQCjSXbDj/7MN8+yo+ibMXG4
	 WzwTpbUjx/reAxA2+SfAFpkiP7WW66OjhyI7fTpp/j3n/B7/FY5/BE62kqLW2iUrPP
	 Kjt4uapr/0oDjnl5NO6MqIILK9jkpa7Ec9qU2XM4=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 42MEeDc73374579
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 15:40:13 +0100
Received: (nullmailer pid 1683836 invoked by uid 1000);
	Fri, 22 Mar 2024 14:40:13 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: Liviu Dudau <liviu@dudau.co.uk>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Haijun Liu <haijun.liu@mediatek.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net] net: wwan: t7xx: Split 64bit accesses to fix alignment issues
Date: Fri, 22 Mar 2024 15:40:00 +0100
Message-Id: <20240322144000.1683822-1-bjorn@mork.no>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Some of the registers are aligned on a 32bit boundary, causing
alignment faults on 64bit platforms.

 Unable to handle kernel paging request at virtual address ffffffc084a1d004
 Mem abort info:
 ESR =3D 0x0000000096000061
 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
 SET =3D 0, FnV =3D 0
 EA =3D 0, S1PTW =3D 0
 FSC =3D 0x21: alignment fault
 Data abort info:
 ISV =3D 0, ISS =3D 0x00000061, ISS2 =3D 0x00000000
 CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
 swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000046ad6000
 [ffffffc084a1d004] pgd=3D100000013ffff003, p4d=3D100000013ffff003, pud=3D1=
00000013ffff003, pmd=3D0068000020a00711
 Internal error: Oops: 0000000096000061 [#1] SMP
 Modules linked in: mtk_t7xx(+) qcserial pppoe ppp_async option nft_fib_ine=
t nf_flow_table_inet mt7921u(O) mt7921s(O) mt7921e(O) mt7921_common(O) iwlm=
vm(O) iwldvm(O) usb_wwan rndis_host qmi_wwan pppox ppp_generic nft_reject_i=
pv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numg=
en nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv=
6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table =
nf_conntrack mt7996e(O) mt792x_usb(O) mt792x_lib(O) mt7915e(O) mt76_usb(O) =
mt76_sdio(O) mt76_connac_lib(O) mt76(O) mac80211(O) iwlwifi(O) huawei_cdc_n=
cm cfg80211(O) cdc_ncm cdc_ether wwan usbserial usbnet slhc sfp rtc_pcf8563=
 nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_de=
frag_ipv4 mt6577_auxadc mdio_i2c libcrc32c compat(O) cdc_wdm cdc_acm at24 c=
rypto_safexcel pwm_fan i2c_gpio i2c_smbus industrialio i2c_algo_bit i2c_mux=
_reg i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio i2c_mux dummy oid_registr=
y tun sha512_arm64 sha1_ce sha1_generic seqiv
 md5 geniv des_generic libdes cbc authencesn authenc leds_gpio xhci_plat_hc=
d xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_hotplug(O) dm_m=
irror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_common ptp aqua=
ntia pps_core mii tpm encrypted_keys trusted
 CPU: 3 PID: 5266 Comm: kworker/u9:1 Tainted: G O 6.6.22 #0
 Hardware name: Bananapi BPI-R4 (DT)
 Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
 pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
 lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
 sp : ffffffc085d63d30
 x29: ffffffc085d63d30 x28: 0000000000000000 x27: 0000000000000000
 x26: 0000000000000000 x25: ffffff80c804f2c0 x24: ffffff80ca196c05
 x23: 0000000000000000 x22: ffffff80c814b9b8 x21: ffffff80c814b128
 x20: 0000000000000001 x19: ffffff80c814b080 x18: 0000000000000014
 x17: 0000000055c9806b x16: 000000007c5296d0 x15: 000000000f6bca68
 x14: 00000000dbdbdce4 x13: 000000001aeaf72a x12: 0000000000000001
 x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
 x8 : ffffff80ca1ef6b4 x7 : ffffff80c814b818 x6 : 0000000000000018
 x5 : 0000000000000870 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 000000010a947000 x1 : ffffffc084a1d004 x0 : ffffffc084a1d004
 Call trace:
 t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
 t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
 process_one_work+0x154/0x2a0
 worker_thread+0x2ac/0x488
 kthread+0xe0/0xec
 ret_from_fork+0x10/0x20
 Code: f9400800 91001000 8b214001 d50332bf (f9000022)
 ---[ end trace 0000000000000000 ]---

The inclusion of io-64-nonatomic-lo-hi.h indicates that all 64bit
accesses can be replaced by pairs of nonatomic 32bit access.  Fix
alignment by forcing all accesses to be 32bit on 64bit platforms.

Link: https://forum.openwrt.org/t/fibocom-fm350-gl-support/142682/72
Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/net/wwan/t7xx/t7xx_cldma.c     | 4 ++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 9 +++++----
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c  | 8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_cldma.c b/drivers/net/wwan/t7xx/t7x=
x_cldma.c
index 9f43f256db1d..f0a4783baf1f 100644
--- a/drivers/net/wwan/t7xx/t7xx_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_cldma.c
@@ -106,7 +106,7 @@ bool t7xx_cldma_tx_addr_is_set(struct t7xx_cldma_hw *hw=
_info, unsigned int qno)
 {
 	u32 offset =3D REG_CLDMA_UL_START_ADDRL_0 + qno * ADDR_SIZE;
=20
-	return ioread64(hw_info->ap_pdn_base + offset);
+	return ioread64_lo_hi(hw_info->ap_pdn_base + offset);
 }
=20
 void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw *hw_info, unsigned =
int qno, u64 address,
@@ -117,7 +117,7 @@ void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw =
*hw_info, unsigned int qn
=20
 	reg =3D tx_rx =3D=3D MTK_RX ? hw_info->ap_ao_base + REG_CLDMA_DL_START_AD=
DRL_0 :
 				hw_info->ap_pdn_base + REG_CLDMA_UL_START_ADDRL_0;
-	iowrite64(address, reg + offset);
+	iowrite64_lo_hi(address, reg + offset);
 }
=20
 void t7xx_cldma_hw_resume_queue(struct t7xx_cldma_hw *hw_info, unsigned in=
t qno,
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx=
/t7xx_hif_cldma.c
index abc41a7089fa..97163e1e5783 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -137,8 +137,9 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queue =
*queue, int budget, bool
 				return -ENODEV;
 			}
=20
-			gpd_addr =3D ioread64(hw_info->ap_pdn_base + REG_CLDMA_DL_CURRENT_ADDRL=
_0 +
-					    queue->index * sizeof(u64));
+			gpd_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base +
+						  REG_CLDMA_DL_CURRENT_ADDRL_0 +
+						  queue->index * sizeof(u64));
 			if (req->gpd_addr =3D=3D gpd_addr || hwo_polling_count++ >=3D 100)
 				return 0;
=20
@@ -316,8 +317,8 @@ static void t7xx_cldma_txq_empty_hndl(struct cldma_queu=
e *queue)
 		struct t7xx_cldma_hw *hw_info =3D &md_ctrl->hw_info;
=20
 		/* Check current processing TGPD, 64-bit address is in a table by Q inde=
x */
-		ul_curr_addr =3D ioread64(hw_info->ap_pdn_base + REG_CLDMA_UL_CURRENT_AD=
DRL_0 +
-					queue->index * sizeof(u64));
+		ul_curr_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base + REG_CLDMA_UL_CURR=
ENT_ADDRL_0 +
+					      queue->index * sizeof(u64));
 		if (req->gpd_addr !=3D ul_curr_addr) {
 			spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
 			dev_err(md_ctrl->dev, "CLDMA%d queue %d is not empty\n",
diff --git a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c b/drivers/net/wwan/t7xx/=
t7xx_pcie_mac.c
index 76da4c15e3de..f071ec7ff23d 100644
--- a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
+++ b/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
@@ -75,7 +75,7 @@ static void t7xx_pcie_mac_atr_tables_dis(void __iomem *pb=
ase, enum t7xx_atr_src_
 	for (i =3D 0; i < ATR_TABLE_NUM_PER_ATR; i++) {
 		offset =3D ATR_PORT_OFFSET * port + ATR_TABLE_OFFSET * i;
 		reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
-		iowrite64(0, reg);
+		iowrite64_lo_hi(0, reg);
 	}
 }
=20
@@ -112,17 +112,17 @@ static int t7xx_pcie_mac_atr_cfg(struct t7xx_pci_dev =
*t7xx_dev, struct t7xx_atr_
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_ADDR + offset;
 	value =3D cfg->trsl_addr & ATR_PCIE_WIN0_ADDR_ALGMT;
-	iowrite64(value, reg);
+	iowrite64_lo_hi(value, reg);
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
 	iowrite32(cfg->trsl_id, reg);
=20
 	reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
 	value =3D (cfg->src_addr & ATR_PCIE_WIN0_ADDR_ALGMT) | (atr_size << 1) | =
BIT(0);
-	iowrite64(value, reg);
+	iowrite64_lo_hi(value, reg);
=20
 	/* Ensure ATR is set */
-	ioread64(reg);
+	ioread64_lo_hi(reg);
 	return 0;
 }
=20
--=20
2.39.2


