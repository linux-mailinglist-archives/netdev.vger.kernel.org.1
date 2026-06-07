Return-Path: <netdev+bounces-296127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJbZBD9nJGoO6AEAu9opvQ
	(envelope-from <netdev+bounces-296127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022364E062
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:30:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296127-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 543D93008635
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439903B47FC;
	Sat,  6 Jun 2026 18:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05D3B42C9
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:21:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770078; cv=none; b=ruDGS5lFHKH9a2fIGKZJUIPUgI7MDMpzvDFl8MrtNMWRMWqbp9r7TvOv+oPUksQzYJ95U76yTzfj/2mSG+cCb7ncajlOTnP/z2klXH/CYVLbTg2i2xu3+tWkaNt3kYEnl8Hh9IqulehCGOHlwGefMDvAs53JXzBWmEq2001Je1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770078; c=relaxed/simple;
	bh=GAm8VOxH04WNR8q4Fh9UTt86kcigd7LtIkabcaGeNwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLLrkG6qBpkhPvVspTukDbA3pkJQ8xiG966HU7jqi+YH/X11k5Ym5MXdkXJpu6ZjUvruBtvsdk10YPP+4BgG67UOUJxMtJJ1laP/V1YwCCLU6B6MyHWdPFQqGkET0XxSxlHaSPOh9MpsEgKss+bC0239FFwBkpKKwYe6BDx9FN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGH029679;
	Sat, 6 Jun 2026 11:21:00 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 07/10] cxgb4: Extend hardware abstraction layer for T7 logs
Date: Sat,  6 Jun 2026 23:52:17 -0400
Message-Id: <20260607035220.528439-8-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.54 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296127-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,i2c.data:url];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6022364E062
X-Spam: Yes

Update the core hardware abstraction layer within t4_hw.c to implement
full register dispatching, multi-core memory mapping, and interface
diagnostics for T7 adapters.

Expand the driver low-level access routines to support T7 layouts:
 - Implement 64-bit PCIe memory window address tracking using offset
   shifts, and route flash geometry queries via a dynamic per-adapter
   mapping table.
 - Update chip identification logic to decode T7 silicon revisions using
   the PL_REV register, sizing structural limits to accommodate 256
   VFs and wider TCAM layouts.
 - Upgrade the firmware developer log parser devlog to automatically
   shard tracking buffers across the expanded microprocessor cores.
 - Introduce multi-core debugging interfaces for CIM, enabling explicit
   host-group and host-core target reads and writes for internal queues
   and LA buffers.
 - Integrate TP channel routing, SGE queues-per-page QPP mappings, PM
   RX cache metrics, and interrupt handler pathways unique to T7.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2484 ++++++++++++++++----
 1 file changed, 2048 insertions(+), 436 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 171750fad44f..d161bc56f2eb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -234,9 +234,8 @@ static void fw_asrt(struct adapter *adap, u32 mbox_addr)
  *	@access: the time (ms) needed to access the Firmware Mailbox
  *	@execute: the time (ms) the command spent being executed
  */
-static void t4_record_mbox(struct adapter *adapter,
-			   const __be64 *cmd, unsigned int size,
-			   int access, int execute)
+void t4_record_mbox(struct adapter *adapter, const __be64 *cmd,
+		    unsigned int size, int access, int execute)
 {
 	struct mbox_cmd_log *log = adapter->mbox_log;
 	struct mbox_cmd *entry;
@@ -305,7 +304,9 @@ int t4_wr_mbox_meat_timeout(struct adapter *adap, int mbox, const void *cmd,
 	 * If the device is off-line, as in EEH, commands will time out.
 	 * Fail them early so we don't waste time waiting.
 	 */
-	if (adap->pdev->error_state != pci_channel_io_normal)
+	struct pci_dev *pdev = adap->pdev;
+
+	if (pdev->error_state != pci_channel_io_normal)
 		return -EIO;
 
 	/* If we have a negative timeout, that implies that we can't sleep. */
@@ -483,6 +484,39 @@ static int t4_edc_err_read(struct adapter *adap, int idx)
 	return 0;
 }
 
+unsigned int t4_pcie_mem_access_base_win_reg(struct adapter *adap, int win)
+{
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		return T7_PCIE_MEM_ACCESS_REG(T7_PCIE_MEM_ACCESS_BASE_WIN_A,
+				win);
+	return PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A, win);
+}
+
+unsigned int t4_pcie_mem_access_offset_reg(struct adapter *adap, int win)
+{
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		return T7_PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET0_A,
+				win);
+
+	return PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, win);
+}
+
+void t4_pcie_mem_access_offset_write(struct adapter *adap, u32 off, int win,
+				     u32 pf)
+{
+	u32 reg = t4_pcie_mem_access_offset_reg(adap, win);
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		off >>= T7_MEMOFST_SHIFT_X;
+		t4_write_reg64(adap, reg, off | pf);
+		t4_read_reg64(adap, reg); /* Flush */
+		return;
+	}
+
+	t4_write_reg(adap, reg, off | pf);
+	t4_read_reg(adap, reg); /* Flush */
+}
+
 /**
  * t4_memory_rw_init - Get memory window relative offset, base, and size.
  * @adap: the adapter
@@ -497,7 +531,7 @@ static int t4_edc_err_read(struct adapter *adap, int idx)
 int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 		      u32 *mem_base, u32 *mem_aperture)
 {
-	u32 edc_size, mc_size, mem_reg;
+	u64 edc_size, mc_size, mem_reg;
 
 	/* Offset into the region of memory which is being accessed
 	 * MEM_EDC0 = 0
@@ -506,15 +540,14 @@ int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 	 * MEM_MC1  = 3 -- for chips with 2 memory controllers (e.g. T5)
 	 * MEM_HMA  = 4
 	 */
-	edc_size  = EDRAM0_SIZE_G(t4_read_reg(adap, MA_EDRAM0_BAR_A));
+	edc_size  = T7_EDRAM0_SIZE_G(t4_read_reg(adap, MA_EDRAM0_BAR_A));
 	if (mtype == MEM_HMA) {
 		*mem_off = 2 * (edc_size * 1024 * 1024);
 	} else if (mtype != MEM_MC1) {
 		*mem_off = (mtype * (edc_size * 1024 * 1024));
 	} else {
-		mc_size = EXT_MEM0_SIZE_G(t4_read_reg(adap,
-						      MA_EXT_MEMORY0_BAR_A));
-		*mem_off = (MEM_MC0 * edc_size + mc_size) * 1024 * 1024;
+		mc_size = T7_EXT_MEM0_SIZE_G(t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A));
+		*mem_off = ((u64)(MEM_MC0 * edc_size + mc_size)) * 1024 * 1024;
 	}
 
 	/* Each PCI-E Memory Window is programmed with a window size -- or
@@ -525,14 +558,13 @@ int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 	 * space.  For T4 this is an absolute PCI-E Bus Address.  For T5
 	 * the address is relative to BAR0.
 	 */
-	mem_reg = t4_read_reg(adap,
-			      PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A,
-						  win));
+	mem_reg = t4_read_reg(adap, t4_pcie_mem_access_base_win_reg(adap, win));
+
 	/* a dead adapter will return 0xffffffff for PIO reads */
 	if (mem_reg == 0xffffffff)
 		return -ENXIO;
 
-	*mem_aperture = 1 << (WINDOW_G(mem_reg) + WINDOW_SHIFT_X);
+	*mem_aperture = 1ULL << (WINDOW_G(mem_reg) + WINDOW_SHIFT_X);
 	*mem_base = PCIEOFST_G(mem_reg) << PCIEOFST_SHIFT_X;
 	if (is_t4(adap->params.chip))
 		*mem_base -= adap->t4_bar0;
@@ -540,26 +572,6 @@ int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 	return 0;
 }
 
-/**
- * t4_memory_update_win - Move memory window to specified address.
- * @adap: the adapter
- * @win: PCI-E Memory Window to use
- * @addr: location to move.
- *
- * Move memory window to specified address.
- */
-void t4_memory_update_win(struct adapter *adap, int win, u32 addr)
-{
-	t4_write_reg(adap,
-		     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, win),
-		     addr);
-	/* Read it back to ensure that changes propagate before we
-	 * attempt to use the new value.
-	 */
-	t4_read_reg(adap,
-		    PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, win));
-}
-
 /**
  * t4_memory_rw_residual - Read/Write residual data.
  * @adap: the adapter
@@ -652,7 +664,7 @@ int t4_memory_rw(struct adapter *adap, int win, int mtype, u32 addr,
 	/* Set up initial PCI-E Memory Window to cover the start of our
 	 * transfer.
 	 */
-	t4_memory_update_win(adap, win, pos | win_pf);
+	t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 
 	/* Transfer data to/from the adapter as long as there's an integral
 	 * number of 32-bit transfers to complete.
@@ -707,7 +719,7 @@ int t4_memory_rw(struct adapter *adap, int win, int mtype, u32 addr,
 		if (offset == mem_aperture) {
 			pos += mem_aperture;
 			offset = 0;
-			t4_memory_update_win(adap, win, pos | win_pf);
+			t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 		}
 	}
 
@@ -811,12 +823,10 @@ u32 t4_get_util_window(struct adapter *adap)
  */
 void t4_setup_memwin(struct adapter *adap, u32 memwin_base, u32 window)
 {
-	t4_write_reg(adap,
-		     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A, window),
+	t4_write_reg(adap, t4_pcie_mem_access_base_win_reg(adap, window),
 		     memwin_base | BIR_V(0) |
 		     WINDOW_V(ilog2(MEMWIN0_APERTURE) - WINDOW_SHIFT_X));
-	t4_read_reg(adap,
-		    PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A, window));
+	t4_read_reg(adap, t4_pcie_mem_access_base_win_reg(adap, window));
 }
 
 /**
@@ -835,6 +845,7 @@ unsigned int t4_get_regs_len(struct adapter *adapter)
 
 	case CHELSIO_T5:
 	case CHELSIO_T6:
+	case CHELSIO_T7:
 		return T5_REGMAP_SIZE;
 	}
 
@@ -2637,6 +2648,648 @@ void t4_get_regs(struct adapter *adap, void *buf, size_t buf_size)
 		0x51300, 0x51324,
 	};
 
+	static const unsigned int t7_reg_ranges[] = {
+		0x1008, 0x101c,
+		0x1024, 0x10a8,
+		0x10b4, 0x10f8,
+		0x1100, 0x1114,
+		0x111c, 0x112c,
+		0x1138, 0x113c,
+		0x1144, 0x115c,
+		0x1180, 0x1184,
+		0x1190, 0x1194,
+		0x11a0, 0x11a4,
+		0x11b0, 0x11d0,
+		0x11fc, 0x1278,
+		0x1280, 0x1368,
+		0x1700, 0x172c,
+		0x173c, 0x1760,
+		0x1800, 0x18fc,
+		0x3000, 0x3044,
+		0x30a4, 0x30b0,
+		0x30b8, 0x30d8,
+		0x30e0, 0x30e8,
+		0x3140, 0x357c,
+		0x35a8, 0x35cc,
+		0x35e0, 0x35ec,
+		0x3600, 0x37fc,
+		0x3804, 0x3818,
+		0x3880, 0x388c,
+		0x3900, 0x3904,
+		0x3910, 0x3978,
+		0x3980, 0x399c,
+		0x4700, 0x4720,
+		0x4728, 0x475c,
+		0x480c, 0x4814,
+		0x4890, 0x489c,
+		0x48a4, 0x48ac,
+		0x48b8, 0x48bc,
+		0x4900, 0x4924,
+		0x4ffc, 0x4ffc,
+		0x5500, 0x5624,
+		0x56c4, 0x56ec,
+		0x56f4, 0x5720,
+		0x5728, 0x575c,
+		0x580c, 0x5814,
+		0x5890, 0x589c,
+		0x58a4, 0x58ac,
+		0x58b8, 0x58bc,
+		0x5940, 0x598c,
+		0x59b0, 0x59c8,
+		0x59d0, 0x59dc,
+		0x59fc, 0x5a18,
+		0x5a60, 0x5a6c,
+		0x5a80, 0x5a8c,
+		0x5a94, 0x5a9c,
+		0x5b94, 0x5bec,
+		0x5bf8, 0x5bfc,
+		0x5c10, 0x5c40,
+		0x5c4c, 0x5e48,
+		0x5e50, 0x5e94,
+		0x5ea0, 0x5eb0,
+		0x5ec0, 0x5ec0,
+		0x5ec8, 0x5ed0,
+		0x5ee0, 0x5ee0,
+		0x5ef0, 0x5ef0,
+		0x5f00, 0x5f04,
+		0x5f0c, 0x5f10,
+		0x5f20, 0x5f78,
+		0x5f84, 0x5f88,
+		0x5f90, 0x5fd8,
+		0x6000, 0x6020,
+		0x6028, 0x6030,
+		0x6044, 0x609c,
+		0x60a8, 0x60ac,
+		0x60b8, 0x60ec,
+		0x6100, 0x6104,
+		0x6118, 0x611c,
+		0x6150, 0x6150,
+		0x6180, 0x61b8,
+		0x7700, 0x77a8,
+		0x77b0, 0x7888,
+		0x78cc, 0x7970,
+		0x7b00, 0x7b00,
+		0x7b08, 0x7b0c,
+		0x7b24, 0x7b84,
+		0x7b8c, 0x7c2c,
+		0x7c34, 0x7c40,
+		0x7c48, 0x7c68,
+		0x7c70, 0x7c7c,
+		0x7d00, 0x7ddc,
+		0x7de4, 0x7e38,
+		0x7e40, 0x7e44,
+		0x7e4c, 0x7e74,
+		0x7e80, 0x7ee0,
+		0x7ee8, 0x7f0c,
+		0x7f20, 0x7f5c,
+		0x8dc0, 0x8de8,
+		0x8df8, 0x8e04,
+		0x8e10, 0x8e30,
+		0x8e7c, 0x8ee8,
+		0x8f88, 0x8f88,
+		0x8f90, 0x8fb0,
+		0x8fb8, 0x9058,
+		0x9074, 0x90f8,
+		0x9100, 0x912c,
+		0x9138, 0x9188,
+		0x9400, 0x9414,
+		0x9430, 0x9440,
+		0x9454, 0x9454,
+		0x945c, 0x947c,
+		0x9498, 0x94b8,
+		0x9600, 0x9600,
+		0x9608, 0x9638,
+		0x9640, 0x9704,
+		0x9710, 0x971c,
+		0x9800, 0x9804,
+		0x9854, 0x9854,
+		0x9c00, 0x9c6c,
+		0x9c80, 0x9cec,
+		0x9d00, 0x9d6c,
+		0x9d80, 0x9dec,
+		0x9e00, 0x9e6c,
+		0x9e80, 0x9eec,
+		0x9f00, 0x9f6c,
+		0x9f80, 0x9fec,
+		0xa000, 0xa06c,
+		0xa080, 0xa0ec,
+		0xa100, 0xa16c,
+		0xa180, 0xa1ec,
+		0xa200, 0xa26c,
+		0xa280, 0xa2ec,
+		0xa300, 0xa36c,
+		0xa380, 0xa458,
+		0xa460, 0xa4f8,
+		0xd000, 0xd03c,
+		0xd100, 0xd134,
+		0xd200, 0xd214,
+		0xd220, 0xd234,
+		0xd240, 0xd254,
+		0xd260, 0xd274,
+		0xd280, 0xd294,
+		0xd2a0, 0xd2b4,
+		0xd2c0, 0xd2d4,
+		0xd2e0, 0xd2f4,
+		0xd300, 0xd31c,
+		0xdfc0, 0xdfe0,
+		0xe000, 0xe00c,
+		0xf000, 0xf008,
+		0xf010, 0xf06c,
+		0x11000, 0x11014,
+		0x11048, 0x11120,
+		0x11130, 0x11144,
+		0x11174, 0x11178,
+		0x11190, 0x111a0,
+		0x111e4, 0x112f0,
+		0x11300, 0x1133c,
+		0x11408, 0x1146c,
+		0x12000, 0x12004,
+		0x12060, 0x122c4,
+		0x19040, 0x1906c,
+		0x19078, 0x19080,
+		0x1908c, 0x190e8,
+		0x190f0, 0x190f8,
+		0x19100, 0x19110,
+		0x19120, 0x19124,
+		0x19150, 0x19194,
+		0x1919c, 0x191a0,
+		0x191ac, 0x191c8,
+		0x191d0, 0x191e4,
+		0x19250, 0x19250,
+		0x19258, 0x19268,
+		0x19278, 0x19278,
+		0x19280, 0x192b0,
+		0x192bc, 0x192f0,
+		0x19300, 0x19308,
+		0x19310, 0x19318,
+		0x19320, 0x19328,
+		0x19330, 0x19330,
+		0x19348, 0x1934c,
+		0x193f8, 0x19428,
+		0x19430, 0x19444,
+		0x1944c, 0x1946c,
+		0x19474, 0x1947c,
+		0x19488, 0x194cc,
+		0x194f0, 0x194f8,
+		0x19c00, 0x19c48,
+		0x19c50, 0x19c80,
+		0x19c94, 0x19c98,
+		0x19ca0, 0x19cdc,
+		0x19ce4, 0x19cf8,
+		0x19d00, 0x19d30,
+		0x19d50, 0x19d80,
+		0x19d94, 0x19d98,
+		0x19da0, 0x19de0,
+		0x19df0, 0x19e10,
+		0x19e50, 0x19e6c,
+		0x19ea0, 0x19ebc,
+		0x19ec4, 0x19ef4,
+		0x19f04, 0x19f2c,
+		0x19f34, 0x19f34,
+		0x19f40, 0x19f50,
+		0x19f90, 0x19fb4,
+		0x19fbc, 0x19fbc,
+		0x19fc4, 0x19fc8,
+		0x19fd0, 0x19fe4,
+		0x1a000, 0x1a004,
+		0x1a010, 0x1a06c,
+		0x1a0b0, 0x1a0e4,
+		0x1a0ec, 0x1a108,
+		0x1a114, 0x1a130,
+		0x1a138, 0x1a1c4,
+		0x1a1fc, 0x1a29c,
+		0x1a2a8, 0x1a2b8,
+		0x1a2c0, 0x1a388,
+		0x1a398, 0x1a3ac,
+		0x1e008, 0x1e00c,
+		0x1e040, 0x1e044,
+		0x1e04c, 0x1e04c,
+		0x1e284, 0x1e290,
+		0x1e2c0, 0x1e2c0,
+		0x1e2e0, 0x1e2e4,
+		0x1e300, 0x1e384,
+		0x1e3c0, 0x1e3c8,
+		0x1e408, 0x1e40c,
+		0x1e440, 0x1e444,
+		0x1e44c, 0x1e44c,
+		0x1e684, 0x1e690,
+		0x1e6c0, 0x1e6c0,
+		0x1e6e0, 0x1e6e4,
+		0x1e700, 0x1e784,
+		0x1e7c0, 0x1e7c8,
+		0x1e808, 0x1e80c,
+		0x1e840, 0x1e844,
+		0x1e84c, 0x1e84c,
+		0x1ea84, 0x1ea90,
+		0x1eac0, 0x1eac0,
+		0x1eae0, 0x1eae4,
+		0x1eb00, 0x1eb84,
+		0x1ebc0, 0x1ebc8,
+		0x1ec08, 0x1ec0c,
+		0x1ec40, 0x1ec44,
+		0x1ec4c, 0x1ec4c,
+		0x1ee84, 0x1ee90,
+		0x1eec0, 0x1eec0,
+		0x1eee0, 0x1eee4,
+		0x1ef00, 0x1ef84,
+		0x1efc0, 0x1efc8,
+		0x1f008, 0x1f00c,
+		0x1f040, 0x1f044,
+		0x1f04c, 0x1f04c,
+		0x1f284, 0x1f290,
+		0x1f2c0, 0x1f2c0,
+		0x1f2e0, 0x1f2e4,
+		0x1f300, 0x1f384,
+		0x1f3c0, 0x1f3c8,
+		0x1f408, 0x1f40c,
+		0x1f440, 0x1f444,
+		0x1f44c, 0x1f44c,
+		0x1f684, 0x1f690,
+		0x1f6c0, 0x1f6c0,
+		0x1f6e0, 0x1f6e4,
+		0x1f700, 0x1f784,
+		0x1f7c0, 0x1f7c8,
+		0x1f808, 0x1f80c,
+		0x1f840, 0x1f844,
+		0x1f84c, 0x1f84c,
+		0x1fa84, 0x1fa90,
+		0x1fac0, 0x1fac0,
+		0x1fae0, 0x1fae4,
+		0x1fb00, 0x1fb84,
+		0x1fbc0, 0x1fbc8,
+		0x1fc08, 0x1fc0c,
+		0x1fc40, 0x1fc44,
+		0x1fc4c, 0x1fc4c,
+		0x1fe84, 0x1fe90,
+		0x1fec0, 0x1fec0,
+		0x1fee0, 0x1fee4,
+		0x1ff00, 0x1ff84,
+		0x1ffc0, 0x1ffc8,
+		0x30000, 0x30038,
+		0x30100, 0x3017c,
+		0x30190, 0x301a0,
+		0x301a8, 0x301b8,
+		0x301c4, 0x301c8,
+		0x301d0, 0x301e0,
+		0x30200, 0x30344,
+		0x30400, 0x304b4,
+		0x304c0, 0x3052c,
+		0x30540, 0x3065c,
+		0x30800, 0x30848,
+		0x30850, 0x308a8,
+		0x308b8, 0x308c0,
+		0x308cc, 0x308dc,
+		0x30900, 0x30904,
+		0x3090c, 0x30914,
+		0x3091c, 0x30928,
+		0x30930, 0x3093c,
+		0x30944, 0x30948,
+		0x30954, 0x30974,
+		0x3097c, 0x30980,
+		0x30a00, 0x30a20,
+		0x30a38, 0x30a3c,
+		0x30a50, 0x30a50,
+		0x30a80, 0x30a80,
+		0x30a88, 0x30aa8,
+		0x30ab0, 0x30ab4,
+		0x30ac8, 0x30ad4,
+		0x30b28, 0x30b84,
+		0x30b98, 0x30bb8,
+		0x30c98, 0x30d14,
+		0x31000, 0x31020,
+		0x31038, 0x3103c,
+		0x31050, 0x31050,
+		0x31080, 0x31080,
+		0x31088, 0x310a8,
+		0x310b0, 0x310b4,
+		0x310c8, 0x310d4,
+		0x31128, 0x31184,
+		0x31198, 0x311b8,
+		0x32000, 0x32038,
+		0x32100, 0x3217c,
+		0x32190, 0x321a0,
+		0x321a8, 0x321b8,
+		0x321c4, 0x321c8,
+		0x321d0, 0x321e0,
+		0x32200, 0x32344,
+		0x32400, 0x324b4,
+		0x324c0, 0x3252c,
+		0x32540, 0x3265c,
+		0x32800, 0x32848,
+		0x32850, 0x328a8,
+		0x328b8, 0x328c0,
+		0x328cc, 0x328dc,
+		0x32900, 0x32904,
+		0x3290c, 0x32914,
+		0x3291c, 0x32928,
+		0x32930, 0x3293c,
+		0x32944, 0x32948,
+		0x32954, 0x32974,
+		0x3297c, 0x32980,
+		0x32a00, 0x32a20,
+		0x32a38, 0x32a3c,
+		0x32a50, 0x32a50,
+		0x32a80, 0x32a80,
+		0x32a88, 0x32aa8,
+		0x32ab0, 0x32ab4,
+		0x32ac8, 0x32ad4,
+		0x32b28, 0x32b84,
+		0x32b98, 0x32bb8,
+		0x32c98, 0x32d14,
+		0x33000, 0x33020,
+		0x33038, 0x3303c,
+		0x33050, 0x33050,
+		0x33080, 0x33080,
+		0x33088, 0x330a8,
+		0x330b0, 0x330b4,
+		0x330c8, 0x330d4,
+		0x33128, 0x33184,
+		0x33198, 0x331b8,
+		0x34000, 0x34038,
+		0x34100, 0x3417c,
+		0x34190, 0x341a0,
+		0x341a8, 0x341b8,
+		0x341c4, 0x341c8,
+		0x341d0, 0x341e0,
+		0x34200, 0x34344,
+		0x34400, 0x344b4,
+		0x344c0, 0x3452c,
+		0x34540, 0x3465c,
+		0x34800, 0x34848,
+		0x34850, 0x348a8,
+		0x348b8, 0x348c0,
+		0x348cc, 0x348dc,
+		0x34900, 0x34904,
+		0x3490c, 0x34914,
+		0x3491c, 0x34928,
+		0x34930, 0x3493c,
+		0x34944, 0x34948,
+		0x34954, 0x34974,
+		0x3497c, 0x34980,
+		0x34a00, 0x34a20,
+		0x34a38, 0x34a3c,
+		0x34a50, 0x34a50,
+		0x34a80, 0x34a80,
+		0x34a88, 0x34aa8,
+		0x34ab0, 0x34ab4,
+		0x34ac8, 0x34ad4,
+		0x34b28, 0x34b84,
+		0x34b98, 0x34bb8,
+		0x34c98, 0x34d14,
+		0x35000, 0x35020,
+		0x35038, 0x3503c,
+		0x35050, 0x35050,
+		0x35080, 0x35080,
+		0x35088, 0x350a8,
+		0x350b0, 0x350b4,
+		0x350c8, 0x350d4,
+		0x35128, 0x35184,
+		0x35198, 0x351b8,
+		0x36000, 0x36038,
+		0x36100, 0x3617c,
+		0x36190, 0x361a0,
+		0x361a8, 0x361b8,
+		0x361c4, 0x361c8,
+		0x361d0, 0x361e0,
+		0x36200, 0x36344,
+		0x36400, 0x364b4,
+		0x364c0, 0x3652c,
+		0x36540, 0x3665c,
+		0x36800, 0x36848,
+		0x36850, 0x368a8,
+		0x368b8, 0x368c0,
+		0x368cc, 0x368dc,
+		0x36900, 0x36904,
+		0x3690c, 0x36914,
+		0x3691c, 0x36928,
+		0x36930, 0x3693c,
+		0x36944, 0x36948,
+		0x36954, 0x36974,
+		0x3697c, 0x36980,
+		0x36a00, 0x36a20,
+		0x36a38, 0x36a3c,
+		0x36a50, 0x36a50,
+		0x36a80, 0x36a80,
+		0x36a88, 0x36aa8,
+		0x36ab0, 0x36ab4,
+		0x36ac8, 0x36ad4,
+		0x36b28, 0x36b84,
+		0x36b98, 0x36bb8,
+		0x36c98, 0x36d14,
+		0x37000, 0x37020,
+		0x37038, 0x3703c,
+		0x37050, 0x37050,
+		0x37080, 0x37080,
+		0x37088, 0x370a8,
+		0x370b0, 0x370b4,
+		0x370c8, 0x370d4,
+		0x37128, 0x37184,
+		0x37198, 0x371b8,
+		0x38000, 0x380b0,
+		0x380b8, 0x38130,
+		0x38140, 0x38140,
+		0x38150, 0x38154,
+		0x38160, 0x381c4,
+		0x381d0, 0x38204,
+		0x3820c, 0x38214,
+		0x3821c, 0x3822c,
+		0x38244, 0x38244,
+		0x38254, 0x38274,
+		0x3827c, 0x38280,
+		0x38300, 0x38304,
+		0x3830c, 0x38314,
+		0x3831c, 0x3832c,
+		0x38344, 0x38344,
+		0x38354, 0x38374,
+		0x3837c, 0x38380,
+		0x38400, 0x38424,
+		0x38438, 0x3843c,
+		0x38480, 0x38480,
+		0x384a8, 0x384a8,
+		0x384b0, 0x384b4,
+		0x384c8, 0x38514,
+		0x38600, 0x3860c,
+		0x3861c, 0x38624,
+		0x38900, 0x38924,
+		0x38938, 0x3893c,
+		0x38980, 0x38980,
+		0x389a8, 0x389a8,
+		0x389b0, 0x389b4,
+		0x389c8, 0x38a14,
+		0x38b00, 0x38b0c,
+		0x38b1c, 0x38b24,
+		0x38e00, 0x38e00,
+		0x38e18, 0x38e20,
+		0x38e38, 0x38e40,
+		0x38e58, 0x38e60,
+		0x38e78, 0x38e80,
+		0x38e98, 0x38ea0,
+		0x38eb8, 0x38ec0,
+		0x38ed8, 0x38ee0,
+		0x38ef8, 0x38f08,
+		0x38f10, 0x38f2c,
+		0x38f80, 0x38ffc,
+		0x39080, 0x39080,
+		0x39088, 0x39090,
+		0x39100, 0x39108,
+		0x39120, 0x39128,
+		0x39140, 0x39148,
+		0x39160, 0x39168,
+		0x39180, 0x39188,
+		0x391a0, 0x391a8,
+		0x391c0, 0x391c8,
+		0x391e0, 0x391e8,
+		0x39200, 0x39200,
+		0x39208, 0x39240,
+		0x39300, 0x39300,
+		0x39308, 0x39340,
+		0x39400, 0x39400,
+		0x39408, 0x39440,
+		0x39500, 0x39500,
+		0x39508, 0x39540,
+		0x39600, 0x39600,
+		0x39608, 0x39640,
+		0x39700, 0x39700,
+		0x39708, 0x39740,
+		0x39800, 0x39800,
+		0x39808, 0x39840,
+		0x39900, 0x39900,
+		0x39908, 0x39940,
+		0x39a00, 0x39a04,
+		0x39a10, 0x39a14,
+		0x39a1c, 0x39aa8,
+		0x39b00, 0x39ecc,
+		0x3a000, 0x3a004,
+		0x3a050, 0x3a084,
+		0x3a090, 0x3a09c,
+		0x3a93c, 0x3a93c,
+		0x3b93c, 0x3b93c,
+		0x3c93c, 0x3c93c,
+		0x3d93c, 0x3d93c,
+		0x3e000, 0x3e020,
+		0x3e03c, 0x3e05c,
+		0x3e100, 0x3e120,
+		0x3e13c, 0x3e15c,
+		0x3e200, 0x3e220,
+		0x3e23c, 0x3e25c,
+		0x3e300, 0x3e320,
+		0x3e33c, 0x3e35c,
+		0x3f000, 0x3f034,
+		0x3f100, 0x3f130,
+		0x3f200, 0x3f218,
+		0x44000, 0x44014,
+		0x44020, 0x44028,
+		0x44030, 0x44030,
+		0x44100, 0x44114,
+		0x44120, 0x44128,
+		0x44130, 0x44130,
+		0x44200, 0x44214,
+		0x44220, 0x44228,
+		0x44230, 0x44230,
+		0x44300, 0x44314,
+		0x44320, 0x44328,
+		0x44330, 0x44330,
+		0x44400, 0x44414,
+		0x44420, 0x44428,
+		0x44430, 0x44430,
+		0x44500, 0x44514,
+		0x44520, 0x44528,
+		0x44530, 0x44530,
+		0x44714, 0x44718,
+		0x44730, 0x44730,
+		0x447c0, 0x447c0,
+		0x447f0, 0x447f0,
+		0x447f8, 0x447fc,
+		0x45000, 0x45014,
+		0x45020, 0x45028,
+		0x45030, 0x45030,
+		0x45100, 0x45114,
+		0x45120, 0x45128,
+		0x45130, 0x45130,
+		0x45200, 0x45214,
+		0x45220, 0x45228,
+		0x45230, 0x45230,
+		0x45300, 0x45314,
+		0x45320, 0x45328,
+		0x45330, 0x45330,
+		0x45400, 0x45414,
+		0x45420, 0x45428,
+		0x45430, 0x45430,
+		0x45500, 0x45514,
+		0x45520, 0x45528,
+		0x45530, 0x45530,
+		0x45714, 0x45718,
+		0x45730, 0x45730,
+		0x457c0, 0x457c0,
+		0x457f0, 0x457f0,
+		0x457f8, 0x457fc,
+		0x46000, 0x46010,
+		0x46020, 0x46034,
+		0x46040, 0x46050,
+		0x46060, 0x46088,
+		0x47000, 0x4709c,
+		0x470c0, 0x470d4,
+		0x47100, 0x471a8,
+		0x471b0, 0x471e8,
+		0x47200, 0x47210,
+		0x4721c, 0x47230,
+		0x47238, 0x47238,
+		0x47240, 0x472ac,
+		0x472d0, 0x472f4,
+		0x47300, 0x47310,
+		0x47318, 0x47348,
+		0x47350, 0x47354,
+		0x47380, 0x47388,
+		0x47390, 0x47394,
+		0x47400, 0x47448,
+		0x47450, 0x47458,
+		0x47500, 0x4751c,
+		0x47530, 0x4754c,
+		0x47560, 0x4757c,
+		0x47590, 0x475ac,
+		0x47600, 0x47630,
+		0x47640, 0x47644,
+		0x47660, 0x4769c,
+		0x47700, 0x47710,
+		0x47740, 0x47750,
+		0x4775c, 0x4779c,
+		0x477b0, 0x477bc,
+		0x477c4, 0x477c8,
+		0x477d4, 0x477fc,
+		0x48000, 0x48004,
+		0x48018, 0x4801c,
+		0x49304, 0x49320,
+		0x4932c, 0x4932c,
+		0x49334, 0x493f0,
+		0x49400, 0x49410,
+		0x49460, 0x494f4,
+		0x50000, 0x50084,
+		0x50090, 0x500cc,
+		0x50300, 0x50384,
+		0x50400, 0x50404,
+		0x50800, 0x50884,
+		0x50890, 0x508cc,
+		0x50b00, 0x50b84,
+		0x50c00, 0x50c04,
+		0x51000, 0x51020,
+		0x51028, 0x510c4,
+		0x51104, 0x51108,
+		0x51200, 0x51274,
+		0x51300, 0x51324,
+		0x51400, 0x51548,
+		0x51550, 0x51554,
+		0x5155c, 0x51584,
+		0x5158c, 0x515c8,
+		0x515f0, 0x515f4,
+		0x58000, 0x58004,
+		0x58018, 0x5801c,
+		0x59304, 0x59320,
+		0x5932c, 0x5932c,
+		0x59334, 0x593f0,
+		0x59400, 0x59410,
+		0x59460, 0x594f4,
+	};
+
 	u32 *buf_end = (u32 *)((char *)buf + buf_size);
 	const unsigned int *reg_ranges;
 	int reg_ranges_size, range;
@@ -2661,6 +3314,11 @@ void t4_get_regs(struct adapter *adap, void *buf, size_t buf_size)
 		reg_ranges_size = ARRAY_SIZE(t6_reg_ranges);
 		break;
 
+	case CHELSIO_T7:
+		reg_ranges = t7_reg_ranges;
+		reg_ranges_size = ARRAY_SIZE(t7_reg_ranges);
+		break;
+
 	default:
 		dev_err(adap->pdev_dev,
 			"Unsupported chip version %d\n", chip_version);
@@ -2730,7 +3388,8 @@ int t4_eeprom_ptov(unsigned int phys_addr, unsigned int fn, unsigned int sz)
 int t4_seeprom_wp(struct adapter *adapter, bool enable)
 {
 	unsigned int v = enable ? 0xc : 0;
-	int ret = pci_write_vpd(adapter->pdev, EEPROM_STAT_ADDR, 4, &v);
+
+	int ret = cxgb4_pci_write_vpd(adapter, EEPROM_STAT_ADDR, 4, &v);
 	return ret < 0 ? ret : 0;
 }
 
@@ -2754,13 +3413,13 @@ int t4_get_raw_vpd_params(struct adapter *adapter, struct vpd_params *p)
 	/* Card information normally starts at VPD_BASE but early cards had
 	 * it at 0.
 	 */
-	ret = pci_read_vpd(adapter->pdev, VPD_BASE, 1, &base_val);
+	ret = cxgb4_pci_read_vpd(adapter, VPD_BASE, 1, &base_val);
 	if (ret < 0)
 		goto out;
 
 	addr = base_val == PCI_VPD_LRDT_ID_STRING ? VPD_BASE : VPD_BASE_OLD;
 
-	ret = pci_read_vpd(adapter->pdev, addr, VPD_LEN, vpd);
+	ret = cxgb4_pci_read_vpd(adapter, addr, VPD_LEN, vpd);
 	if (ret < 0)
 		goto out;
 
@@ -2898,6 +3557,121 @@ int t4_get_pfres(struct adapter *adapter)
 	return 0;
 }
 
+/* Flash Layout {start sector, # of sectors} for T4/T5/T6 adapters */
+static const struct t4_flash_loc_entry t4_flash_loc_arr[] = {
+	[FLASH_LOC_EXP_ROM] = { 0, 6 },
+	[FLASH_LOC_IBFT] = { 6, 1 },
+	[FLASH_LOC_BOOTCFG] = { 7, 1 },
+	[FLASH_LOC_FW] = { 8, 16 },
+	[FLASH_LOC_FWBOOTSTRAP] = { 27, 1 },
+	[FLASH_LOC_ISCSI_CRASH] = { 29, 1 },
+	[FLASH_LOC_FCOE_CRASH] = { 30, 1 },
+	[FLASH_LOC_CFG] = { 31, 1 },
+	[FLASH_LOC_CUDBG] = { 32, 32 },
+	[FLASH_LOC_BOOT_AREA] = { 0, 8 }, /* Spans complete Boot Area */
+	[FLASH_LOC_MIN_SIZE] = { 0, 32 }, /* Spans minimum required sections */
+	[FLASH_LOC_END] = { 0, 64 }, /* Spans the entire Serial Flash*/
+};
+
+/* Flash Layout {start sector, # of sectors} for T7 adapters */
+static const struct t4_flash_loc_entry t7_flash_loc_arr[] = {
+	[FLASH_LOC_VPD] = { 0, 1 },
+	[FLASH_LOC_FWBOOTSTRAP] = { 1, 1 },
+	[FLASH_LOC_FW] = { 2, 29 },
+	[FLASH_LOC_CFG] = { 31, 1 },
+	[FLASH_LOC_EXP_ROM] = { 32, 15 },
+	[FLASH_LOC_IBFT] = { 47, 1 },
+	[FLASH_LOC_BOOTCFG] = { 48, 1 },
+	[FLASH_LOC_ISCSI_CRASH] = { 62, 1 },
+	[FLASH_LOC_FCOE_CRASH] = { 63, 1 },
+	[FLASH_LOC_VPD_BACKUP] = { 64, 1 },
+	[FLASH_LOC_FWBOOTSTRAP_BACKUP] = { 65, 1 },
+	[FLASH_LOC_FW_BACKUP] = { 66, 29 },
+	[FLASH_LOC_CFG_BACK] = { 95, 1 },
+	[FLASH_LOC_CUDBG] = { 96, 48 },
+	[FLASH_LOC_CHIP_DUMP] = { 144, 48 },
+	[FLASH_LOC_BOOT_AREA] = { 32,
+				  17 }, /* Spans complete UEFI/PXE Boot Area */
+	[FLASH_LOC_MIN_SIZE] = { 0, 32 }, /* Spans minimum required sections */
+	[FLASH_LOC_END] = { 0, 256 }, /* Spans the entire Serial Flash*/
+};
+
+static const struct t4_flash_loc_entry *
+t4_flash_location_entry_get(struct adapter *adap, enum t4_flash_loc loc)
+{
+	const struct t4_flash_loc_entry *arr;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		arr = t7_flash_loc_arr;
+	else
+		arr = t4_flash_loc_arr;
+
+	return arr[loc].nsecs ? &arr[loc] : NULL;
+}
+
+int t4_flash_location_start_sec(struct adapter *adap, enum t4_flash_loc loc)
+{
+	const struct t4_flash_loc_entry *entry;
+
+	entry = t4_flash_location_entry_get(adap, loc);
+	if (!entry)
+		return -ENOENT;
+
+	return entry->start_sec;
+}
+
+int t4_flash_location_nsecs(struct adapter *adap, enum t4_flash_loc loc)
+{
+	const struct t4_flash_loc_entry *entry;
+
+	entry = t4_flash_location_entry_get(adap, loc);
+	if (!entry)
+		return -ENOENT;
+
+	return entry->nsecs;
+}
+
+int t4_flash_location_start(struct adapter *adap, enum t4_flash_loc loc)
+{
+	int ret = t4_flash_location_start_sec(adap, loc);
+
+	if (ret < 0)
+		return ret;
+
+	return FLASH_START(ret);
+}
+
+int t4_flash_location_size(struct adapter *adap, enum t4_flash_loc loc)
+{
+	int ret = t4_flash_location_nsecs(adap, loc);
+
+	if (ret < 0)
+		return ret;
+
+	return FLASH_MAX_SIZE(ret);
+}
+
+static int t4_flash_location_end(struct adapter *adap, enum t4_flash_loc loc)
+{
+	int ret = t4_flash_location_size(adap, loc);
+
+	if (ret < 0)
+		return ret;
+
+	return t4_flash_location_start(adap, loc) + ret;
+}
+
+static bool t4_flash_location_in_range(struct adapter *adap,
+				       enum t4_flash_loc loc, u32 addr)
+{
+	int ret = t4_flash_location_end(adap, loc);
+
+	if (ret < 0)
+		return false;
+
+	return addr >= t4_flash_location_start(adap, loc) && addr < ret;
+}
+
 /* serial flash and firmware constants */
 enum {
 	SF_ATTEMPTS = 10,             /* max retries for SF operations */
@@ -2933,8 +3707,15 @@ static int sf1_read(struct adapter *adapter, unsigned int byte_cnt, int cont,
 		return -EINVAL;
 	if (t4_read_reg(adapter, SF_OP_A) & SF_BUSY_F)
 		return -EBUSY;
-	t4_write_reg(adapter, SF_OP_A, SF_LOCK_V(lock) |
-		     SF_CONT_V(cont) | BYTECNT_V(byte_cnt - 1));
+	if (is_t7(adapter->params.chip))
+		t4_write_reg(adapter, SF_OP_A, QUADREADDISABLE_F |
+				SF_LOCK_V(lock) | SF_CONT_V(cont) |
+				BYTECNT_V(byte_cnt - 1));
+	else
+		t4_write_reg(adapter, SF_OP_A,
+			     SF_LOCK_V(lock) | SF_CONT_V(cont) |
+				     BYTECNT_V(byte_cnt - 1));
+
 	ret = t4_wait_op_done(adapter, SF_OP_A, SF_BUSY_F, 0, SF_ATTEMPTS, 5);
 	if (!ret)
 		*valp = t4_read_reg(adapter, SF_DATA_A);
@@ -3107,8 +3888,12 @@ static int t4_write_flash(struct adapter *adapter, unsigned int addr,
  */
 int t4_get_fw_version(struct adapter *adapter, u32 *vers)
 {
-	return t4_read_flash(adapter, FLASH_FW_START +
-			     offsetof(struct fw_hdr, fw_ver), 1,
+	int ret = t4_flash_location_start(adapter, FLASH_LOC_FW);
+
+	if (ret < 0)
+		return ret;
+
+	return t4_read_flash(adapter, ret + offsetof(struct fw_hdr, fw_ver), 1,
 			     vers, 0);
 }
 
@@ -3121,8 +3906,12 @@ int t4_get_fw_version(struct adapter *adapter, u32 *vers)
  */
 int t4_get_bs_version(struct adapter *adapter, u32 *vers)
 {
-	return t4_read_flash(adapter, FLASH_FWBOOTSTRAP_START +
-			     offsetof(struct fw_hdr, fw_ver), 1,
+	int ret = t4_flash_location_start(adapter, FLASH_LOC_FWBOOTSTRAP);
+
+	if (ret < 0)
+		return ret;
+
+	return t4_read_flash(adapter, ret + offsetof(struct fw_hdr, fw_ver), 1,
 			     vers, 0);
 }
 
@@ -3135,12 +3924,17 @@ int t4_get_bs_version(struct adapter *adapter, u32 *vers)
  */
 int t4_get_tp_version(struct adapter *adapter, u32 *vers)
 {
-	return t4_read_flash(adapter, FLASH_FW_START +
-			     offsetof(struct fw_hdr, tp_microcode_ver),
-			     1, vers, 0);
-}
+	int ret = t4_flash_location_start(adapter, FLASH_LOC_FW);
 
-/**
+	if (ret < 0)
+		return ret;
+
+	return t4_read_flash(adapter,
+			     ret + offsetof(struct fw_hdr, tp_microcode_ver), 1,
+			     vers, 0);
+}
+
+/**
  *	t4_get_exprom_version - return the Expansion ROM version (if any)
  *	@adap: the adapter
  *	@vers: where to place the version
@@ -3160,9 +3954,13 @@ int t4_get_exprom_version(struct adapter *adap, u32 *vers)
 					   sizeof(u32))];
 	int ret;
 
-	ret = t4_read_flash(adap, FLASH_EXP_ROM_START,
-			    ARRAY_SIZE(exprom_header_buf), exprom_header_buf,
-			    0);
+	ret = t4_flash_location_start(adap, FLASH_LOC_EXP_ROM);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_read_flash(adap, ret, ARRAY_SIZE(exprom_header_buf),
+			    exprom_header_buf, 0);
+
 	if (ret)
 		return ret;
 
@@ -3360,9 +4158,9 @@ void t4_dump_version_info(struct adapter *adapter)
  */
 int t4_check_fw_version(struct adapter *adap)
 {
-	int i, ret, major, minor, micro;
-	int exp_major, exp_minor, exp_micro;
 	unsigned int chip_version = CHELSIO_CHIP_VERSION(adap->params.chip);
+	int exp_major, exp_minor, exp_micro;
+	int i, ret, major, minor, micro;
 
 	ret = t4_get_fw_version(adap, &adap->params.fw_vers);
 	/* Try multiple times before returning error */
@@ -3392,6 +4190,11 @@ int t4_check_fw_version(struct adapter *adap)
 		exp_minor = T6FW_MIN_VERSION_MINOR;
 		exp_micro = T6FW_MIN_VERSION_MICRO;
 		break;
+	case CHELSIO_T7:
+		exp_major = T7FW_MIN_VERSION_MAJOR;
+		exp_minor = T7FW_MIN_VERSION_MINOR;
+		exp_micro = T7FW_MIN_VERSION_MICRO;
+		break;
 	default:
 		dev_err(adap->pdev_dev, "Unsupported chip type, %x\n",
 			adap->chip);
@@ -3470,10 +4273,12 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 	const struct fw_hdr *drv_fw;
 
 	drv_fw = &fw_info->fw_hdr;
+	ret = t4_flash_location_start(adap, FLASH_LOC_FW);
+	if (ret < 0)
+		return ret;
 
 	/* Read the header of the firmware on the card */
-	ret = t4_read_flash(adap, FLASH_FW_START,
-			    sizeof(*card_fw) / sizeof(uint32_t),
+	ret = t4_read_flash(adap, ret, sizeof(*card_fw) / sizeof(uint32_t),
 			    (uint32_t *)card_fw, 1);
 	if (ret == 0) {
 		card_fw_usable = fw_compatible(drv_fw, (const void *)card_fw);
@@ -3585,10 +4390,16 @@ static int t4_flash_erase_sectors(struct adapter *adapter, int start, int end)
  */
 unsigned int t4_flash_cfg_addr(struct adapter *adapter)
 {
-	if (adapter->params.sf_size == 0x100000)
-		return FLASH_FPGA_CFG_START;
+	int ret = t4_flash_location_end(adapter, FLASH_LOC_CFG);
+
+	/*
+	 * If the device FLASH isn't large enough to hold a Firmware
+	 * Configuration File, return an error.
+	 */
+	if (ret < 0 || adapter->params.sf_size < ret)
+		return -ENOSPC;
 	else
-		return FLASH_CFG_START;
+		return t4_flash_location_start(adapter, FLASH_LOC_CFG);
 }
 
 /* Return TRUE if the specified firmware matches the adapter.  I.e. T4
@@ -3604,7 +4415,9 @@ static bool t4_fw_matches_chip(const struct adapter *adap,
 	 */
 	if ((is_t4(adap->params.chip) && hdr->chip == FW_HDR_CHIP_T4) ||
 	    (is_t5(adap->params.chip) && hdr->chip == FW_HDR_CHIP_T5) ||
-	    (is_t6(adap->params.chip) && hdr->chip == FW_HDR_CHIP_T6))
+	    (is_t6(adap->params.chip) && hdr->chip == FW_HDR_CHIP_T6) ||
+	    (is_t7(adap->params.chip) && hdr->chip == FW_HDR_CHIP_T7))
+
 		return true;
 
 	dev_err(adap->pdev_dev,
@@ -3623,16 +4436,17 @@ static bool t4_fw_matches_chip(const struct adapter *adap,
  */
 int t4_load_fw(struct adapter *adap, const u8 *fw_data, unsigned int size)
 {
-	u32 csum;
-	int ret, addr;
-	unsigned int i;
-	u8 first_page[SF_PAGE_SIZE];
-	const __be32 *p = (const __be32 *)fw_data;
-	const struct fw_hdr *hdr = (const struct fw_hdr *)fw_data;
 	unsigned int sf_sec_size = adap->params.sf_size / adap->params.sf_nsec;
-	unsigned int fw_start_sec = FLASH_FW_START_SEC;
-	unsigned int fw_size = FLASH_FW_MAX_SIZE;
-	unsigned int fw_start = FLASH_FW_START;
+	const struct fw_hdr *hdr = (const struct fw_hdr *)fw_data;
+	const __be32 *p = (const __be32 *)fw_data;
+	u8 first_page[SF_PAGE_SIZE];
+	unsigned int fw_start_sec;
+	enum t4_flash_loc loc;
+	unsigned int fw_start;
+	unsigned int fw_size;
+	unsigned int i;
+	int ret, addr;
+	u32 csum;
 
 	if (!size) {
 		dev_err(adap->pdev_dev, "FW image has no data\n");
@@ -3648,6 +4462,20 @@ int t4_load_fw(struct adapter *adap, const u8 *fw_data, unsigned int size)
 			"FW image size differs from size in FW header\n");
 		return -EINVAL;
 	}
+
+	loc = FLASH_LOC_FW;
+	ret = t4_flash_location_size(adap, loc);
+	if (ret < 0) {
+		dev_err(adap->pdev_dev,
+			"Error finding Flash location (%u). ret: %d\n", loc,
+			ret);
+		return ret;
+	}
+
+	fw_size = ret;
+	fw_start_sec = t4_flash_location_start_sec(adap, loc);
+	fw_start = t4_flash_location_start(adap, loc);
+
 	if (size > fw_size) {
 		dev_err(adap->pdev_dev, "FW image too large, max is %u bytes\n",
 			fw_size);
@@ -4289,7 +5117,6 @@ static int t4_handle_intr_status(struct adapter *adapter, unsigned int reg,
 	int fatal = 0;
 	unsigned int mask = 0;
 	unsigned int status = t4_read_reg(adapter, reg);
-
 	for ( ; acts->mask; ++acts) {
 		if (!(status & acts->mask))
 			continue;
@@ -4305,7 +5132,7 @@ static int t4_handle_intr_status(struct adapter *adapter, unsigned int reg,
 		mask |= acts->mask;
 	}
 	status &= mask;
-	if (status)                           /* clear processed interrupts */
+	if (status)         /* clear processed interrupts */
 		t4_write_reg(adapter, reg, status);
 	return fatal;
 }
@@ -4440,7 +5267,17 @@ static void tp_intr_handler(struct adapter *adapter)
 		{ 0 }
 	};
 
-	if (t4_handle_intr_status(adapter, TP_INT_CAUSE_A, tp_intr_info))
+	static const struct intr_info t7_tp_intr_info[] = {
+		{ 0xbfffffff, "TP parity error", -1, 1 },
+		{ FLMTXFLSTEMPTY_F, "TP out of Tx pages", -1, 1 },
+		{ 0 }
+	};
+	u32 chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
+	if (t4_handle_intr_status(adapter, TP_INT_CAUSE_A,
+				  chip_ver >= CHELSIO_T7 ? t7_tp_intr_info :
+							   tp_intr_info))
+
 		t4_fatal_err(adapter);
 }
 
@@ -4484,6 +5321,53 @@ static void sge_intr_handler(struct adapter *adapter)
 		{ 0 }
 	};
 
+	static struct intr_info cause_sge_intr_info[] = {
+		{ ERR_FLM_DBP_F,
+		  "DBP pointer delivery for invalid context or QID", -1, 0, 0 },
+		{ ERR_FLM_IDMA1_F | ERR_FLM_IDMA0_F,
+		  "Invalid QID or header request by IDMA", -1, 0, 0 },
+		{ ERR_FLM_HINT_F, "FLM hint is for invalid context or QID", -1,
+		  0, 0 },
+		{ ERR_PCIE_ERROR3_F, "SGE PCIe error for DBP thread 3", -1, 0,
+		  0 },
+		{ ERR_PCIE_ERROR2_F, "SGE PCIe error for DBP thread 2", -1, 0,
+		  0 },
+		{ ERR_PCIE_ERROR1_F, "SGE PCIe error for DBP thread 1", -1, 0,
+		  0 },
+		{ ERR_PCIE_ERROR0_F, "SGE PCIe error for DBP thread 0", -1, 0,
+		  0 },
+		{ ERR_TIMER_ABOVE_MAX_QID_F,
+		  "SGE GTS with timer 0-5 for IQID > 1023", -1, 0, 0 },
+		{ ERR_CPL_EXCEED_IQE_SIZE_F,
+		  "SGE received CPL exceeding IQE size", -1, 0, 0 },
+		{ ERR_INVALID_CIDX_INC_F, "SGE GTS CIDX increment too large",
+		  -1, 0, 0 },
+		{ ERR_ITP_TIME_PAUSED_F, "SGE ITP error", -1, 0, 0 },
+		{ ERR_CPL_OPCODE_0_F, "SGE received 0-length CPL", -1, 0, 0 },
+		{ ERR_DROPPED_DB_F, "SGE DB dropped", -1, 0, 0 },
+		{ ERR_DATA_CPL_ON_HIGH_QID1_F | ERR_DATA_CPL_ON_HIGH_QID0_F,
+		  "SGE IQID > 1023 received CPL for FL", -1, 0, 0 },
+		{ ERR_BAD_DB_PIDX3_F | ERR_BAD_DB_PIDX2_F | ERR_BAD_DB_PIDX1_F |
+			  ERR_BAD_DB_PIDX0_F,
+		  "SGE DBP pidx increment too large", -1, 0, 0 },
+		{ ERR_ING_PCIE_CHAN_F, "SGE Ingress PCIe channel mismatch", -1,
+		  0, 0 },
+		{ ERR_ING_CTXT_PRIO_F,
+		  "Ingress context manager priority user error", -1, 0, 0 },
+		{ ERR_EGR_CTXT_PRIO_F,
+		  "Egress context manager priority user error", -1, 0, 0 },
+		{ DBP_TBUF_FULL_F, "SGE DBP tbuf full", -1, 0, 0 },
+		{ FATAL_WRE_LEN_F, "SGE WRE packet less than advertized length",
+		  -1, 0, 0 },
+		{ REG_ADDRESS_ERR_F, "Undefined SGE register accessed", -1, 0,
+		  0 },
+		{ INGRESS_SIZE_ERR_F, "SGE illegal ingress QID", -1, 0, 0 },
+		{ EGRESS_SIZE_ERR_F, "SGE illegal egress QID", -1, 0, 0 },
+		{ 0x0000000f, "SGE context access for invalid queue", -1, 0,
+		  0 },
+		{ 0 }
+	};
+
 	perr = t4_read_reg(adapter, SGE_INT_CAUSE1_A);
 	if (perr) {
 		v |= perr;
@@ -4498,6 +5382,18 @@ static void sge_intr_handler(struct adapter *adapter)
 			  perr);
 	}
 
+	perr = t4_read_reg(adapter, SGE_INT_CAUSE4_A);
+	if (perr) {
+		v |= perr;
+		dev_alert(adapter->pdev_dev, "SGE Cause4 Parity Error %#x\n",
+			  perr);
+	}
+
+	v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A, sge_intr_info);
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
+		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A,
+					   t4t5_sge_intr_info);
+
 	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T5) {
 		perr = t4_read_reg(adapter, SGE_INT_CAUSE5_A);
 		/* Parity error (CRC) for err_T_RxCRC is trivial, ignore it */
@@ -4509,10 +5405,13 @@ static void sge_intr_handler(struct adapter *adapter)
 		}
 	}
 
-	v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A, sge_intr_info);
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
-		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A,
-					   t4t5_sge_intr_info);
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T6)
+		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE6_A, cause_sge_intr_info);
+
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7) {
+		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE7_A, cause_sge_intr_info);
+		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE8_A, cause_sge_intr_info);
+	}
 
 	err = t4_read_reg(adapter, SGE_ERROR_STATS_A);
 	if (err & ERROR_QID_VALID_F) {
@@ -4710,6 +5609,11 @@ static void cplsw_intr_handler(struct adapter *adapter)
 		t4_fatal_err(adapter);
 }
 
+#define T6_LE_PERRCRC_MASK (PIPELINEERR_F | CLIPTCAMACCFAIL_F | \
+	SRVSRAMACCFAIL_F | CLCAMCRCPARERR_F | CLCAMINTPERR_F | SSRAMINTPERR_F | \
+	SRVSRAMPERR_F | VFSRAMPERR_F | TCAMINTPERR_F | TCAMCRCERR_F | \
+	HASHTBLMEMACCERR_F | MAIFWRINTPERR_F | HASHTBLMEMCRCERR_F)
+
 /*
  * LE interrupt handler.
  */
@@ -4725,20 +5629,33 @@ static void le_intr_handler(struct adapter *adap)
 		{ 0 }
 	};
 
-	static struct intr_info t6_le_intr_info[] = {
-		{ T6_LIPMISS_F, "LE LIP miss", -1, 0 },
-		{ T6_LIP0_F, "LE 0 LIP error", -1, 0 },
-		{ CMDTIDERR_F, "LE cmd tid error", -1, 1 },
-		{ TCAMINTPERR_F, "LE parity error", -1, 1 },
+	static const struct intr_info t6_le_intr_details[] = {
+		{ CACHEINTPERR_F, "Parity error in cache module", -1, 1 },
+		{ CACHESRAMPERR_F, "Parity error in data sram ", -1, 1 },
+		{ CLIPSUBERR_F, "LE CLIP CAM reverse substitution error", -1, 1 },
+		{ CLCAMFIFOERR_F, "LE CLIP CAM internal FIFO error", -1, 1 },
+		{ CTCAMINVLDENT_F, "Invalid IPv6 CLIP TCAM entry", -1, 0 },
+		{ TCAMINVLDENT_F, "Invalid IPv6 TCAM entry", -1, 0 },
+		{ TOTCNTERR_F, "LE total active < TCAM count", -1, 1 },
+		{ CMDPRSRINTERR_F, "LE internal error in parser", -1, 1 },
+		{ CMDTIDERR_F, "Incorrect tid in LE command", -1, 1 },
+		{ T6_ACTRGNFULL_F, "LE active region full", -1, 0 },
+		{ T6_ACTCNTIPV6TZERO_F, "LE IPv6 active open TCAM counter -ve", -1, 0 },
+		{ T6_ACTCNTIPV4TZERO_F, "LE IPv4 active open TCAM counter -ve", -1, 0 },
+		{ T6_ACTCNTIPV6ZERO_F, "LE IPv6 active open counter -ve", -1, 0 },
+		{ T6_ACTCNTIPV4ZERO_F, "LE IPv4 active open counter -ve", -1, 0 },
+		{ HASHTBLACCFAIL_F, "Hash table read error (proto conflict)", -1, 1 },
+		{ TCAMACCFAIL_F, "LE TCAM access failure", -1, 1 },
 		{ T6_UNKNOWNCMD_F, "LE unknown command", -1, 1 },
-		{ SSRAMINTPERR_F, "LE request queue parity error", -1, 1 },
-		{ HASHTBLMEMCRCERR_F, "LE hash table mem crc error", -1, 0 },
+		{ T6_LIP0_F, "LE found 0 LIP during CLIP substitution", -1, 0 },
+		{ T6_LIPMISS_F, "LE CLIP lookup miss", -1, 0 },
+		{ T6_LE_PERRCRC_MASK, "LE parity/CRC error", -1, 1 },
 		{ 0 }
 	};
 
 	if (t4_handle_intr_status(adap, LE_DB_INT_CAUSE_A,
 				  (chip <= CHELSIO_T5) ?
-				  le_intr_info : t6_le_intr_info))
+				  le_intr_info : t6_le_intr_details))
 		t4_fatal_err(adap);
 }
 
@@ -4801,15 +5718,18 @@ static void mps_intr_handler(struct adapter *adapter)
 		{ 0 }
 	};
 
+	int chip = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	int fat;
 
 	fat = t4_handle_intr_status(adapter, MPS_RX_PERR_INT_CAUSE_A,
 				    mps_rx_intr_info) +
 	      t4_handle_intr_status(adapter, MPS_TX_INT_CAUSE_A,
-				    is_t6(adapter->params.chip)
-				    ? t6_mps_tx_intr_info
-				    : mps_tx_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_TRC_INT_CAUSE_A,
+				    chip > CHELSIO_T5 ? t6_mps_tx_intr_info :
+							mps_tx_intr_info) +
+	      t4_handle_intr_status(adapter,
+				    chip >= CHELSIO_T7 ?
+					    T7_MPS_TRC_INT_CAUSE_A :
+					    MPS_TRC_INT_CAUSE_A,
 				    mps_trc_intr_info) +
 	      t4_handle_intr_status(adapter, MPS_STAT_PERR_INT_CAUSE_SRAM_A,
 				    mps_stat_sram_intr_info) +
@@ -4845,13 +5765,21 @@ static void mem_intr_handler(struct adapter *adapter, int idx)
 		if (is_t4(adapter->params.chip)) {
 			addr = MC_INT_CAUSE_A;
 			cnt_addr = MC_ECC_STATUS_A;
+		} else if (is_t7(adapter->params.chip)) {
+			addr = T7_MC_P_INT_CAUSE_A;
+			cnt_addr = T7_MC_P_ECC_STATUS_A;
 		} else {
 			addr = MC_P_INT_CAUSE_A;
 			cnt_addr = MC_P_ECC_STATUS_A;
 		}
 	} else {
-		addr = MC_REG(MC_P_INT_CAUSE_A, 1);
-		cnt_addr = MC_REG(MC_P_ECC_STATUS_A, 1);
+		if (is_t7(adapter->params.chip)) {
+			addr = MC_REG(T7_MC_P_INT_CAUSE_A, 1);
+			cnt_addr = MC_REG(T7_MC_P_ECC_STATUS_A, 1);
+		} else {
+			addr = MC_REG(MC_P_INT_CAUSE_A, 1);
+			cnt_addr = MC_REG(MC_P_ECC_STATUS_A, 1);
+		}
 	}
 
 	v = t4_read_reg(adapter, addr) & MEM_INT_MASK;
@@ -4939,6 +5867,17 @@ static void ncsi_intr_handler(struct adapter *adap)
 		t4_fatal_err(adap);
 }
 
+static u32 t4_port_reg(struct adapter *adap, u8 port, u32 reg)
+{
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		return T7_PORT_REG(port, reg);
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T4)
+		return T5_PORT_REG(port, reg);
+
+	return PORT_REG(port, reg);
+}
+
 /*
  * XGMAC interrupt handler.
  */
@@ -4946,10 +5885,13 @@ static void xgmac_intr_handler(struct adapter *adap, int port)
 {
 	u32 v, int_cause_reg;
 
-	if (is_t4(adap->params.chip))
-		int_cause_reg = PORT_REG(port, XGMAC_PORT_INT_CAUSE_A);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		int_cause_reg =
+			t4_port_reg(adap, port, T7_MAC_PORT_INT_CAUSE_A);
+	else if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T4)
+		int_cause_reg = t4_port_reg(adap, port, MAC_PORT_INT_CAUSE_A);
 	else
-		int_cause_reg = T5_PORT_REG(port, MAC_PORT_INT_CAUSE_A);
+		int_cause_reg = PORT_REG(port, XGMAC_PORT_INT_CAUSE_A);
 
 	v = t4_read_reg(adap, int_cause_reg);
 
@@ -4973,6 +5915,7 @@ static void xgmac_intr_handler(struct adapter *adap, int port)
 static void pl_intr_handler(struct adapter *adap)
 {
 	static const struct intr_info pl_intr_info[] = {
+		{ INVALIDACCESS_F, "Invalid Access", -1, 0 },
 		{ FATALPERR_F, "T4 fatal parity error", -1, 1 },
 		{ PERRVFID_F, "PL VFID_MAP parity error", -1, 1 },
 		{ 0 }
@@ -4984,9 +5927,13 @@ static void pl_intr_handler(struct adapter *adap)
 
 #define PF_INTR_MASK (PFSW_F)
 #define GLBL_INTR_MASK (CIM_F | MPS_F | PL_F | PCIE_F | MC_F | EDC0_F | \
-		EDC1_F | LE_F | TP_F | MA_F | PM_TX_F | PM_RX_F | ULP_RX_F | \
-		CPL_SWITCH_F | SGE_F | ULP_TX_F | SF_F)
+			EDC1_F | LE_F | TP_F | MA_F | PM_TX_F | PM_RX_F | ULP_RX_F | \
+			CPL_SWITCH_F | SGE_F | ULP_TX_F | SF_F)
 
+#define GLBL_T7_INTR_MASK                                                      \
+	(CIM_F | MPS_F | PL_F | T7_PCIE_F | T7_MC0_F | T7_EDC0_F | T7_EDC1_F | \
+	 T7_LE_F | T7_TP_F | T7_MA_F | T7_PM_TX_F | T7_PM_RX_F | T7_ULP_RX_F | \
+	 T7_CPL_SWITCH_F | T7_SGE_F | T7_ULP_TX_F | SF_F)
 /**
  *	t4_slow_intr_handler - control path interrupt handler
  *	@adapter: the adapter
@@ -5001,12 +5948,17 @@ int t4_slow_intr_handler(struct adapter *adapter)
 	 * set when the corresponding PL_INT_ENABLE bit isn't set.  It's
 	 * easiest just to mask that case here.
 	 */
+	u32 chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	u32 raw_cause = t4_read_reg(adapter, PL_INT_CAUSE_A);
 	u32 enable = t4_read_reg(adapter, PL_INT_ENABLE_A);
 	u32 cause = raw_cause & enable;
+	u32 mask;
+
+	mask = chip_ver >= CHELSIO_T7 ? GLBL_T7_INTR_MASK : GLBL_INTR_MASK;
 
-	if (!(cause & GLBL_INTR_MASK))
+	if (!(cause & mask))
 		return 0;
+
 	if (cause & CIM_F)
 		cim_intr_handler(adapter);
 	if (cause & MPS_F)
@@ -5025,37 +5977,67 @@ int t4_slow_intr_handler(struct adapter *adapter)
 		xgmac_intr_handler(adapter, 2);
 	if (cause & XGMAC_KR1_F)
 		xgmac_intr_handler(adapter, 3);
-	if (cause & PCIE_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_PCIE_F : PCIE_F;
+	if (cause & mask)
 		pcie_intr_handler(adapter);
-	if (cause & MC_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_MC0_F : MC_F;
+	if (cause & mask)
 		mem_intr_handler(adapter, MEM_MC);
-	if (is_t5(adapter->params.chip) && (cause & MC1_F))
-		mem_intr_handler(adapter, MEM_MC1);
-	if (cause & EDC0_F)
+	if (chip_ver != CHELSIO_T4 && chip_ver != CHELSIO_T6) {
+		mask = chip_ver >= CHELSIO_T7 ? T7_MC1_F : MC1_F;
+		if (cause & mask)
+			mem_intr_handler(adapter, MEM_MC1);
+	}
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_EDC0_F : EDC0_F;
+	if (cause & mask)
 		mem_intr_handler(adapter, MEM_EDC0);
-	if (cause & EDC1_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_EDC1_F : EDC1_F;
+	if (cause & mask)
 		mem_intr_handler(adapter, MEM_EDC1);
-	if (cause & LE_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_LE_F : LE_F;
+	if (cause & mask)
 		le_intr_handler(adapter);
-	if (cause & TP_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_TP_F : TP_F;
+	if (cause & mask)
 		tp_intr_handler(adapter);
-	if (cause & MA_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_MA_F : MA_F;
+	if (cause & mask)
 		ma_intr_handler(adapter);
-	if (cause & PM_TX_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_PM_TX_F : PM_TX_F;
+	if (cause & mask)
 		pmtx_intr_handler(adapter);
-	if (cause & PM_RX_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_PM_RX_F : PM_RX_F;
+	if (cause & mask)
 		pmrx_intr_handler(adapter);
-	if (cause & ULP_RX_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_ULP_RX_F : ULP_RX_F;
+	if (cause & mask)
 		ulprx_intr_handler(adapter);
-	if (cause & CPL_SWITCH_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_CPL_SWITCH_F : CPL_SWITCH_F;
+	if (cause & mask)
 		cplsw_intr_handler(adapter);
-	if (cause & SGE_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_SGE_F : SGE_F;
+	if (cause & mask)
 		sge_intr_handler(adapter);
-	if (cause & ULP_TX_F)
+
+	mask = chip_ver >= CHELSIO_T7 ? T7_ULP_TX_F : ULP_TX_F;
+	if (cause & mask)
 		ulptx_intr_handler(adapter);
 
 	/* Clear the interrupts just processed for which we are the master. */
-	t4_write_reg(adapter, PL_INT_CAUSE_A, raw_cause & GLBL_INTR_MASK);
+	mask = chip_ver >= CHELSIO_T7 ? GLBL_T7_INTR_MASK : GLBL_INTR_MASK;
+	t4_write_reg(adapter, PL_INT_CAUSE_A, raw_cause & mask);
 	(void)t4_read_reg(adapter, PL_INT_CAUSE_A); /* flush */
 	return 1;
 }
@@ -5082,6 +6064,8 @@ void t4_intr_enable(struct adapter *adapter)
 
 	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
 		val = ERR_DROPPED_DB_F | ERR_EGR_CTXT_PRIO_F | DBFIFO_HP_INT_F;
+	else
+		val = ERR_PCIE_ERROR0_F | ERR_PCIE_ERROR1_F | FATAL_WRE_LEN_F;
 	t4_write_reg(adapter, SGE_INT_ENABLE3_A, ERR_CPL_EXCEED_IQE_SIZE_F |
 		     ERR_INVALID_CIDX_INC_F | ERR_CPL_OPCODE_0_F |
 		     ERR_DATA_CPL_ON_HIGH_QID1_F | INGRESS_SIZE_ERR_F |
@@ -5105,9 +6089,6 @@ void t4_intr_disable(struct adapter *adapter)
 {
 	u32 whoami, pf;
 
-	if (pci_channel_offline(adapter->pdev))
-		return;
-
 	whoami = t4_read_reg(adapter, PL_WHOAMI_A);
 	pf = CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5 ?
 			SOURCEPF_G(whoami) : T6_SOURCEPF_G(whoami);
@@ -5245,12 +6226,55 @@ int t4_config_vi_rss(struct adapter *adapter, int mbox, unsigned int viid,
 	return t4_wr_mbox(adapter, mbox, &c, sizeof(c), NULL);
 }
 
+/*
+ * t7_wait_sram_done - wait until an operation is completed
+ * @adapter: the adapter performing the operation
+ * @reg: the register to check for completion
+ * @result_reg: register that holds the result value
+ * @attempts: number of check iterations
+ * @delay: delay in usecs between iterations
+ * @valp: where to store the value of the result register at completion time
+ *
+ * Waits until a specific bit in @reg is cleared, checking up to
+ * @attempts times.Once the bit is cleared, reads from @result_reg
+ * and stores the value in @valp if it is not NULL. Returns 0 if the
+ * operation completes successfully and -EAGAIN if it times out.
+ */
+static int t7_wait_sram_done(struct adapter *adap, int reg, int result_reg,
+			     int attempts, int delay, u32 *valp)
+{
+	while (1) {
+		u32 val = t4_read_reg(adap, reg);
+
+		/* Check if SramStart (bit 19) is cleared */
+		if (!(val & (1 << 19))) {
+			if (valp)
+				*valp = t4_read_reg(adap, result_reg);
+			return 0;
+		}
+
+		if (--attempts == 0)
+			return -EAGAIN;
+
+		if (delay)
+			udelay(delay);
+	}
+}
+
 /* Read an RSS table row */
 static int rd_rss_row(struct adapter *adap, int row, u32 *val)
 {
-	t4_write_reg(adap, TP_RSS_LKP_TABLE_A, 0xfff00000 | row);
-	return t4_wait_op_done_val(adap, TP_RSS_LKP_TABLE_A, LKPTBLROWVLD_F, 1,
-				   5, 0, val);
+	int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	if (chip_ver < CHELSIO_T7) {
+		t4_write_reg(adap, TP_RSS_LKP_TABLE_A, 0xfff00000 | row);
+		return t4_wait_op_done_val(adap, TP_RSS_LKP_TABLE_A,
+				LKPTBLROWVLD_F, 1, 5, 0, val);
+	} else {
+		t4_write_reg(adap, TP_RSS_CONFIG_SRAM_A, 0xB0000 | row);
+		return t7_wait_sram_done(adap, TP_RSS_CONFIG_SRAM_A,
+				TP_RSS_LKP_TABLE_A, 5, 0, val);
+	}
 }
 
 /**
@@ -5680,6 +6704,7 @@ void t4_tp_get_rdma_stats(struct adapter *adap, struct tp_rdma_stats *st,
 {
 	t4_tp_mib_read(adap, &st->rqe_dfr_pkt, 2, TP_MIB_RQE_DFR_PKT_A,
 		       sleep_ok);
+
 }
 
 /**
@@ -5939,11 +6964,21 @@ void t4_get_chan_txrate(struct adapter *adap, u64 *nic_rate, u64 *ofld_rate)
 int t4_set_trace_filter(struct adapter *adap, const struct trace_params *tp,
 			int idx, int enable)
 {
-	int i, ofst = idx * 4;
+	int chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+	u32 match_ctl_a, match_ctl_b;
 	u32 data_reg, mask_reg, cfg;
+	int i, ofst = idx;
+
+	if (chip >= CHELSIO_T7) {
+		match_ctl_a = T7_MPS_TRC_FILTER_MATCH_CTL_A_A + ofst * 4;
+		match_ctl_b = T7_MPS_TRC_FILTER_MATCH_CTL_B_A + ofst * 4;
+	} else {
+		match_ctl_a = MPS_TRC_FILTER_MATCH_CTL_A_A + ofst * 4;
+		match_ctl_b = MPS_TRC_FILTER_MATCH_CTL_B_A + ofst * 4;
+	}
 
 	if (!enable) {
-		t4_write_reg(adap, MPS_TRC_FILTER_MATCH_CTL_A_A + ofst, 0);
+		t4_write_reg(adap, match_ctl_a, 0);
 		return 0;
 	}
 
@@ -5970,20 +7005,20 @@ int t4_set_trace_filter(struct adapter *adap, const struct trace_params *tp,
 		return -EINVAL;
 
 	/* stop the tracer we'll be changing */
-	t4_write_reg(adap, MPS_TRC_FILTER_MATCH_CTL_A_A + ofst, 0);
+	t4_write_reg(adap, match_ctl_a, 0);
 
-	idx *= (MPS_TRC_FILTER1_MATCH_A - MPS_TRC_FILTER0_MATCH_A);
-	data_reg = MPS_TRC_FILTER0_MATCH_A + idx;
-	mask_reg = MPS_TRC_FILTER0_DONT_CARE_A + idx;
+	ofst *= (MPS_TRC_FILTER1_MATCH_A - MPS_TRC_FILTER0_MATCH_A);
+	data_reg = MPS_TRC_FILTER0_MATCH_A + ofst;
+	mask_reg = MPS_TRC_FILTER0_DONT_CARE_A + ofst;
 
 	for (i = 0; i < TRACE_LEN / 4; i++, data_reg += 4, mask_reg += 4) {
 		t4_write_reg(adap, data_reg, tp->data[i]);
 		t4_write_reg(adap, mask_reg, ~tp->mask[i]);
 	}
-	t4_write_reg(adap, MPS_TRC_FILTER_MATCH_CTL_B_A + ofst,
+	t4_write_reg(adap, match_ctl_b,
 		     TFCAPTUREMAX_V(tp->snap_len) |
 		     TFMINPKTSIZE_V(tp->min_len));
-	t4_write_reg(adap, MPS_TRC_FILTER_MATCH_CTL_A_A + ofst,
+	t4_write_reg(adap,  match_ctl_b,
 		     TFOFFSET_V(tp->skip_ofst) | TFLENGTH_V(tp->skip_len) |
 		     (is_t4(adap->params.chip) ?
 		     TFPORT_V(tp->port) | TFEN_F | TFINVERTMATCH_V(tp->invert) :
@@ -6005,12 +7040,21 @@ int t4_set_trace_filter(struct adapter *adap, const struct trace_params *tp,
 void t4_get_trace_filter(struct adapter *adap, struct trace_params *tp, int idx,
 			 int *enabled)
 {
-	u32 ctla, ctlb;
-	int i, ofst = idx * 4;
+	int chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+	u32 match_ctl_a, match_ctl_b, ctla, ctlb;
 	u32 data_reg, mask_reg;
+	int i, ofst = idx;
+
+	if (chip >= CHELSIO_T7) {
+		match_ctl_a = T7_MPS_TRC_FILTER_MATCH_CTL_A_A + ofst * 4;
+		match_ctl_b = T7_MPS_TRC_FILTER_MATCH_CTL_B_A + ofst * 4;
+	} else {
+		match_ctl_a = MPS_TRC_FILTER_MATCH_CTL_A_A + ofst * 4;
+		match_ctl_b = MPS_TRC_FILTER_MATCH_CTL_B_A + ofst * 4;
+	}
 
-	ctla = t4_read_reg(adap, MPS_TRC_FILTER_MATCH_CTL_A_A + ofst);
-	ctlb = t4_read_reg(adap, MPS_TRC_FILTER_MATCH_CTL_B_A + ofst);
+	ctla = t4_read_reg(adap, match_ctl_a);
+	ctlb = t4_read_reg(adap, match_ctl_b);
 
 	if (is_t4(adap->params.chip)) {
 		*enabled = !!(ctla & TFEN_F);
@@ -6026,7 +7070,7 @@ void t4_get_trace_filter(struct adapter *adap, struct trace_params *tp, int idx,
 	tp->skip_ofst = TFOFFSET_G(ctla);
 	tp->skip_len = TFLENGTH_G(ctla);
 
-	ofst = (MPS_TRC_FILTER1_MATCH_A - MPS_TRC_FILTER0_MATCH_A) * idx;
+	ofst *= (MPS_TRC_FILTER1_MATCH_A - MPS_TRC_FILTER0_MATCH_A);
 	data_reg = MPS_TRC_FILTER0_MATCH_A + ofst;
 	mask_reg = MPS_TRC_FILTER0_DONT_CARE_A + ofst;
 
@@ -6036,6 +7080,37 @@ void t4_get_trace_filter(struct adapter *adap, struct trace_params *tp, int idx,
 	}
 }
 
+/**
+ *     t4_set_trace_rss_control - configure the trace rss control register
+ *     @adap: the adapter
+ *     @chan: the channel number for RSS control
+ *     @qid: queue number
+ *
+ *     Configures the MPS tracing RSS control parameter for specified
+ *     @chan channel and @qid queue number.
+ */
+void t4_set_trace_rss_control(struct adapter *adap, u8 chan, u16 qid)
+{
+	int chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+	u32 mps_trc_rss_control;
+
+	switch (chip) {
+	case CHELSIO_T4:
+		mps_trc_rss_control = MPS_TRC_RSS_CONTROL_A;
+		break;
+	case CHELSIO_T5:
+	case CHELSIO_T6:
+		mps_trc_rss_control = MPS_T5_TRC_RSS_CONTROL_A;
+		break;
+	case CHELSIO_T7:
+		mps_trc_rss_control = T7_MPS_T5_TRC_RSS_CONTROL_A;
+		break;
+	}
+
+	t4_write_reg(adap, mps_trc_rss_control,
+		     RSSCONTROL_V(chan) | QUEUENUMBER_V(qid));
+}
+
 /**
  *	t4_pmtx_get_stats - returns the HW stats from PMTX
  *	@adap: the adapter
@@ -6046,8 +7121,9 @@ void t4_get_trace_filter(struct adapter *adap, struct trace_params *tp, int idx,
  */
 void t4_pmtx_get_stats(struct adapter *adap, u32 cnt[], u64 cycles[])
 {
-	int i;
+	int chip = CHELSIO_CHIP_VERSION(adap->params.chip);
 	u32 data[2];
+	int i;
 
 	for (i = 0; i < adap->params.arch.pm_stats_cnt; i++) {
 		t4_write_reg(adap, PM_TX_STAT_CONFIG_A, i + 1);
@@ -6057,7 +7133,9 @@ void t4_pmtx_get_stats(struct adapter *adap, u32 cnt[], u64 cycles[])
 		} else {
 			t4_read_indirect(adap, PM_TX_DBG_CTRL_A,
 					 PM_TX_DBG_DATA_A, data, 2,
-					 PM_TX_DBG_STAT_MSB_A);
+					 chip >= CHELSIO_T7 ?
+						 T7_PM_TX_DBG_STAT_MSB_A :
+						 PM_TX_DBG_STAT_MSB_A);
 			cycles[i] = (((u64)data[0] << 32) | data[1]);
 		}
 	}
@@ -6090,6 +7168,25 @@ void t4_pmrx_get_stats(struct adapter *adap, u32 cnt[], u64 cycles[])
 	}
 }
 
+/**
+ * t4_pmrx_cache_get_stats - returns the HW PMRX cache stats
+ * @adap: the adapter
+ * @stats: where to store the statistics
+ *
+ * Returns performance statistics of PMRX cache.
+ */
+void t4_pmrx_cache_get_stats(struct adapter *adap, u32 stats[])
+{
+	u8 i, j;
+
+	for (i = 0, j = 0; i < T7_PM_RX_CACHE_NSTATS / 3; i++, j += 3) {
+		t4_write_reg(adap, PM_RX_STAT_CONFIG_A, 0x100 + i);
+		stats[j] = t4_read_reg(adap, PM_RX_STAT_COUNT_A);
+		t4_read_indirect(adap, PM_RX_DBG_CTRL_A, PM_RX_DBG_DATA_A,
+				 &stats[j + 1], 2, PM_RX_DBG_STAT_MSB_A);
+	}
+}
+
 /**
  *	compute_mps_bg_map - compute the MPS Buffer Group Map for a Port
  *	@adapter: the adapter
@@ -6112,8 +7209,10 @@ static inline unsigned int compute_mps_bg_map(struct adapter *adapter,
 	case CHELSIO_T5:
 		switch (nports) {
 		case 1: return 0xf;
-		case 2: return 3 << (2 * pidx);
-		case 4: return 1 << pidx;
+		case 2:
+			return 3 << (2 * pidx);
+		case 4:
+			return 1 << pidx;
 		}
 		break;
 
@@ -6122,6 +7221,14 @@ static inline unsigned int compute_mps_bg_map(struct adapter *adapter,
 		case 2: return 1 << (2 * pidx);
 		}
 		break;
+	case CHELSIO_T7:
+		switch (nports) {
+		case 1:
+		case 2:
+		case 4:
+			return 1 << pidx;
+		}
+		break;
 	}
 
 	dev_err(adapter->pdev_dev, "Need MPS Buffer Group Map for Chip %0x, Nports %d\n",
@@ -6197,36 +7304,87 @@ unsigned int t4_get_mps_bg_map(struct adapter *adapter, int pidx)
 }
 
 /**
- *      t4_get_tp_e2c_map - return the E2C channel map associated with a port
- *      @adapter: the adapter
- *      @pidx: the port index
+* t4_get_num_ports - Save the FW initialized # of active ports from registers.
+* @adap: the adapter
+*
+* Save the number of FW initialized active ports from hardware registers.
+* For <= T6, the number of active ports is same as available from MPS.
+* For > T6, the number of active ports is based on configured TP Load
+* Balancer Mode. This function must be called after FW is initialized
+* to ensure the TP Load Balancer Mode had been configured for > T6.
+*/
+static void t4_get_tp_num_ports(struct adapter *adap)
+{
+	u32 val = 0;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		t4_tp_pio_read(adap, &val, 1, TP_CHANNEL_MAP_A, false);
+		adap->params.tp.lb_mode = T7_LB_MODE_G(val);
+
+		switch (adap->params.tp.lb_mode) {
+		case 0:
+			adap->params.tp.nports = 4;
+			break;
+		case 2:
+			adap->params.tp.nports = 2;
+			break;
+		default:
+			adap->params.tp.nports = 1;
+			break;
+		}
+	} else {
+		val = t4_read_reg(adap, MPS_CMN_CTL_A);
+		adap->params.tp.lb_mode = 0;
+		adap->params.tp.nports = 1 << NUMPORTS_G(val);
+	}
+}
+
+/*
+ * t4_get_tp_channel_map - fetch and save the configured TP Channel Map
+ * @adap: the adapter
+ *
+ * Fetch and save the configured TP Channel Map.
  */
-static unsigned int t4_get_tp_e2c_map(struct adapter *adapter, int pidx)
+static void t4_get_tp_channel_map(struct adapter *adap)
 {
-	unsigned int nports;
 	u32 param, val = 0;
 	int ret;
+	u8 i;
 
-	nports = 1 << NUMPORTS_G(t4_read_reg(adapter, MPS_CMN_CTL_A));
-	if (pidx >= nports) {
-		CH_WARN(adapter, "TP E2C Channel Port Index %d >= Nports %d\n",
-			pidx, nports);
-		return 0;
-	}
-
-	/* FW version >= 1.16.44.0 can determine E2C channel map using
-	 * FW_PARAMS_PARAM_DEV_TPCHMAP API.
-	 */
-	param = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
-		 FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_TPCHMAP));
-	ret = t4_query_params_ns(adapter, adapter->mbox, adapter->pf,
-				 0, 1, &param, &val);
+	param = FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
+		FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_TPCHMAP);
+	ret = t4_query_params_ns(adap, adap->mbox, adap->pf, 0, 1, &param,
+				 &val);
 	if (!ret)
-		return (val >> (8 * pidx)) & 0xff;
+		for (i = 0; i < NCHAN; i++)
+			adap->params.tp.channel_map[i] = (val >> (8 * i)) &
+							 0xff;
+}
 
-	return 0;
+/*
+ * t4_get_tp_port_chan - Get the associated TP channel for the port
+ * @adap: the adapter
+ * @pidx: the port ID for which to get the TP channel
+ *
+ * Get the associated TP channel for the port.
+ */
+u8 t4_get_tp_port_chan(struct adapter *adap, u8 pidx)
+{
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T6)
+		return pidx;
+
+	return adap->params.tp.channel_map[pidx];
 }
 
+/**
+ *      t4_get_tp_e2c_map - return the E2C channel map associated with a port
+ *      @adapter: the adapter
+ *      @pidx: the port index
+ */
+static unsigned int t4_get_tp_e2c_map(struct adapter *adapter, int pidx)
+{
+	return adapter->params.tp.channel_map[pidx];
+}
 /**
  *	t4_get_tp_ch_map - return TP ingress channels associated with a port
  *	@adap: the adapter
@@ -6239,13 +7397,7 @@ static unsigned int t4_get_tp_e2c_map(struct adapter *adapter, int pidx)
 unsigned int t4_get_tp_ch_map(struct adapter *adap, int pidx)
 {
 	unsigned int chip_version = CHELSIO_CHIP_VERSION(adap->params.chip);
-	unsigned int nports = 1 << NUMPORTS_G(t4_read_reg(adap, MPS_CMN_CTL_A));
-
-	if (pidx >= nports) {
-		dev_warn(adap->pdev_dev, "TP Port Index %d >= Nports %d\n",
-			 pidx, nports);
-		return 0;
-	}
+	u8 nports = adap->params.tp.nports;
 
 	switch (chip_version) {
 	case CHELSIO_T4:
@@ -6256,8 +7408,10 @@ unsigned int t4_get_tp_ch_map(struct adapter *adap, int pidx)
 		 */
 		switch (nports) {
 		case 1: return 0xf;
-		case 2: return 3 << (2 * pidx);
-		case 4: return 1 << pidx;
+		case 2:
+			return 3 << (2 * pidx);
+		case 4:
+			return 1 << pidx;
 		}
 		break;
 
@@ -6267,6 +7421,14 @@ unsigned int t4_get_tp_ch_map(struct adapter *adap, int pidx)
 		case 2: return 1 << pidx;
 		}
 		break;
+	case CHELSIO_T7:
+		switch (nports) {
+		case 1:
+		case 2:
+		case 4:
+			return 1 << pidx;
+		}
+		break;
 	}
 
 	dev_err(adap->pdev_dev, "Need TP Channel Map for Chip %0x, Nports %d\n",
@@ -6280,37 +7442,76 @@ unsigned int t4_get_tp_ch_map(struct adapter *adap, int pidx)
  */
 const char *t4_get_port_type_description(enum fw_port_type port_type)
 {
-	static const char *const port_type_description[] = {
-		"Fiber_XFI",
-		"Fiber_XAUI",
-		"BT_SGMII",
-		"BT_XFI",
-		"BT_XAUI",
-		"KX4",
-		"CX4",
-		"KX",
-		"KR",
-		"SFP",
-		"BP_AP",
-		"BP4_AP",
-		"QSFP_10G",
-		"QSA",
-		"QSFP",
-		"BP40_BA",
-		"KR4_100G",
-		"CR4_QSFP",
-		"CR_QSFP",
-		"CR2_QSFP",
-		"SFP28",
-		"KR_SFP28",
-		"KR_XLAUI"
-	};
+	static const char *const port_type_description[] = { "Fiber_XFI",
+							     "Fiber_XAUI",
+							     "BT_SGMII",
+							     "BT_XFI",
+							     "BT_XAUI",
+							     "KX4",
+							     "CX4",
+							     "KX",
+							     "KR",
+							     "SFP",
+							     "BP_AP",
+							     "BP4_AP",
+							     "QSFP_10G",
+							     "QSA",
+							     "QSFP",
+							     "BP40_BA",
+							     "KR4_100G",
+							     "CR4_QSFP",
+							     "CR_QSFP",
+							     "CR2_QSFP",
+							     "SFP28",
+							     "KR_SFP28",
+							     "KR_XLAUI",
+							     "BARE_LINK_50G",
+							     "BARE_LINK_100G",
+							     "BARE_LINK_200G",
+							     "SFP56",
+							     "QSFP56",
+							     "QSFP56_4_50G",
+							     "KR_50G",
+							     "KR2_100G",
+							     "KR4_200G",
+							     "QSFP56_2_50G",
+							     "OSFP",
+							     "QSFPDD",
+							     "OSFP_2_200G",
+							     "QSFP_4_100G",
+							     "QSFPDD_2_200G",
+							     "KR8_400G" };
 
 	if (port_type < ARRAY_SIZE(port_type_description))
 		return port_type_description[port_type];
 	return "UNKNOWN";
 }
 
+static u64 t4_get_port_stats_lb_mode(struct adapter *adap, int idx, u32 reg)
+{
+	u8 i, n, start;
+	u64 s = 0;
+
+	start = t4_get_tp_port_chan(adap, idx);
+
+	switch (adap->params.tp.lb_mode) {
+	case 0:
+		n = 1;
+		break;
+	case 2:
+		n = 2;
+		break;
+	default:
+		n = 4;
+		break;
+	}
+
+	for (i = 0; i < n; i++)
+		s += t4_read_reg64(adap, t4_port_reg(adap, start + i, reg));
+
+	return s;
+}
+
 /**
  *      t4_get_port_stats_offset - collect port stats relative to a previous
  *                                 snapshot
@@ -6343,13 +7544,11 @@ void t4_get_port_stats_offset(struct adapter *adap, int idx,
  */
 void t4_get_port_stats(struct adapter *adap, int idx, struct port_stats *p)
 {
-	u32 bgmap = t4_get_mps_bg_map(adap, idx);
 	u32 stat_ctl = t4_read_reg(adap, MPS_STAT_CTL_A);
+	u32 bgmap = t4_get_mps_bg_map(adap, idx);
 
 #define GET_STAT(name) \
-	t4_read_reg64(adap, \
-	(is_t4(adap->params.chip) ? PORT_REG(idx, MPS_PORT_STAT_##name##_L) : \
-	T5_PORT_REG(idx, MPS_PORT_STAT_##name##_L)))
+	t4_get_port_stats_lb_mode(adap, idx, MPS_PORT_STAT_##name##_L);
 #define GET_STAT_COM(name) t4_read_reg64(adap, MPS_STAT_##name##_L)
 
 	p->tx_octets           = GET_STAT(TX_PORT_BYTES);
@@ -6443,10 +7642,7 @@ void t4_get_lb_stats(struct adapter *adap, int idx, struct lb_port_stats *p)
 	u32 bgmap = t4_get_mps_bg_map(adap, idx);
 
 #define GET_STAT(name) \
-	t4_read_reg64(adap, \
-	(is_t4(adap->params.chip) ? \
-	PORT_REG(idx, MPS_PORT_STAT_LB_PORT_##name##_L) : \
-	T5_PORT_REG(idx, MPS_PORT_STAT_LB_PORT_##name##_L)))
+	t4_get_port_stats_lb_mode(adap, idx, MPS_PORT_STAT_LB_PORT_##name##_L);
 #define GET_STAT_COM(name) t4_read_reg64(adap, MPS_STAT_##name##_L)
 
 	p->octets           = GET_STAT(BYTES);
@@ -6727,6 +7923,7 @@ void t4_sge_decode_idma_state(struct adapter *adapter, int state)
 		break;
 
 	case CHELSIO_T6:
+	case CHELSIO_T7:
 		sge_idma_decode = (const char **)t6_decode;
 		sge_idma_decode_nstates = ARRAY_SIZE(t6_decode);
 		break;
@@ -8054,18 +9251,23 @@ int t4_alloc_mac_filt(struct adapter *adap, unsigned int mbox,
  *
  *	Returns a negative error number or the number of filters freed.
  */
-int t4_free_mac_filt(struct adapter *adap, unsigned int mbox,
-		     unsigned int viid, unsigned int naddr,
-		     const u8 **addr, bool sleep_ok)
+int t4_free_mac_filt(struct adapter *adap, unsigned int mbox, unsigned int viid,
+		     unsigned int naddr, const u8 **addr, bool sleep_ok)
 {
 	int offset, ret = 0;
 	struct fw_vi_mac_cmd c;
 	unsigned int nfilters = 0;
-	unsigned int max_naddr = is_t4(adap->params.chip) ?
-				       NUM_MPS_CLS_SRAM_L_INSTANCES :
-				       NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
+	unsigned int max_naddr = 0;
 	unsigned int rem = naddr;
 
+	if (is_t4(adap->params.chip))
+		max_naddr = NUM_MPS_CLS_SRAM_L_INSTANCES;
+	else if (is_t7(adap->params.chip))
+		/* In T7 there 3 TCAM each of 512 size*/
+		max_naddr = NUM_MPS_T5_CLS_SRAM_L_INSTANCES * 3;
+	else
+		max_naddr = NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
+
 	if (naddr > max_naddr)
 		return -EINVAL;
 
@@ -8681,7 +9883,7 @@ void t4_handle_get_port_info(struct port_info *pi, const __be64 *rpl)
 			lc->link_down_rc = linkdnrc;
 			dev_warn_ratelimited(adapter->pdev_dev,
 					     "Port %d link down, reason: %s\n",
-					     pi->tx_chan,
+					     pi->lport,
 					     t4_link_down_rc_str(linkdnrc));
 		}
 		lc->link_ok = link_ok;
@@ -8757,7 +9959,7 @@ int t4_update_port_info(struct port_info *pi)
 	memset(&port_cmd, 0, sizeof(port_cmd));
 	port_cmd.op_to_portid = cpu_to_be32(FW_CMD_OP_V(FW_PORT_CMD) |
 					    FW_CMD_REQUEST_F | FW_CMD_READ_F |
-					    FW_PORT_CMD_PORTID_V(pi->tx_chan));
+					    FW_PORT_CMD_PORTID_V(pi->lport));
 	port_cmd.action_to_len16 = cpu_to_be32(
 		FW_PORT_CMD_ACTION_V(fw_caps == FW_CAPS16
 				     ? FW_PORT_ACTION_GET_PORT_INFO
@@ -8795,7 +9997,7 @@ int t4_get_link_params(struct port_info *pi, unsigned int *link_okp,
 	memset(&port_cmd, 0, sizeof(port_cmd));
 	port_cmd.op_to_portid = cpu_to_be32(FW_CMD_OP_V(FW_PORT_CMD) |
 					    FW_CMD_REQUEST_F | FW_CMD_READ_F |
-					    FW_PORT_CMD_PORTID_V(pi->tx_chan));
+					    FW_PORT_CMD_PORTID_V(pi->lport));
 	action = (fw_caps == FW_CAPS16
 		  ? FW_PORT_ACTION_GET_PORT_INFO
 		  : FW_PORT_ACTION_GET_PORT_INFO32);
@@ -8955,14 +10157,17 @@ static int t4_get_flash_params(struct adapter *adap)
 	 * to the preexisting code.  All flash parts have 64KB sectors.
 	 */
 	static struct flash_desc supported_flash[] = {
-		{ 0x150201, 4 << 20 },       /* Spansion 4MB S25FL032P */
+		{ 0x150201, 4 << 20 }, /* Spansion 4MB S25FL032P */
 	};
 
 	unsigned int part, manufacturer;
 	unsigned int density, size = 0;
+	int ret, min_size;
 	u32 flashid = 0;
-	int ret;
 
+	min_size = t4_flash_location_end(adap, FLASH_LOC_MIN_SIZE);
+	if (min_size < 0)
+		return min_size;
 	/* Issue a Read ID Command to the Flash part.  We decode supported
 	 * Flash parts and their sizes from this.  There's a newer Query
 	 * Command which can retrieve detailed geometry information but many
@@ -9096,43 +10301,64 @@ static int t4_get_flash_params(struct adapter *adap)
 	adap->params.sf_nsec = size / SF_SEC_SIZE;
 
 found:
-	if (adap->params.sf_size < FLASH_MIN_SIZE)
+	if (adap->params.sf_size < min_size)
 		dev_warn(adap->pdev_dev, "WARNING: Flash Part ID %#x, size %#x < %#x\n",
-			 flashid, adap->params.sf_size, FLASH_MIN_SIZE);
+			 flashid, adap->params.sf_size, min_size);
 	return 0;
 }
 
 /**
- *	t4_prep_adapter - prepare SW and HW for operation
- *	@adapter: the adapter
- *
- *	Initialize adapter SW state for the various HW modules, set initial
- *	values for some adapter tunables, take PHYs out of reset, and
- *	initialize the MDIO interface.
+ *      t4_get_chip_type - Determine chip type from device ID
+ *      @adap: the adapter
+ *      @ver: adapter version
+ */
+enum chip_type t4_get_chip_type(struct adapter *adap, int ver)
+{
+	u32 pl_rev = REV_G(t4_read_reg(adap, PL_REV_A));
+
+	switch (ver) {
+	case CHELSIO_T4:
+		return CHELSIO_CHIP_CODE(CHELSIO_T4, pl_rev);
+	case CHELSIO_T5:
+		return CHELSIO_CHIP_CODE(CHELSIO_T5, pl_rev);
+	case CHELSIO_T6:
+		return CHELSIO_CHIP_CODE(CHELSIO_T6, pl_rev);
+	case CHELSIO_T7:
+		return CHELSIO_CHIP_CODE(CHELSIO_T7, pl_rev);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+/**
+ *	t4_prep_adapter - prepare SW and HW for operation
+ *	@adapter: the adapter
+ *
+ *	Initialize adapter SW state for the various HW modules, set initial
+ *	values for some adapter tunables, take PHYs out of reset, and
+ *	initialize the MDIO interface.
  */
 int t4_prep_adapter(struct adapter *adapter)
 {
 	int ret, ver;
-	uint16_t device_id;
-	u32 pl_rev;
+	u16 device_id;
 
 	get_pci_mode(adapter, &adapter->params.pci);
-	pl_rev = REV_G(t4_read_reg(adapter, PL_REV_A));
-
 	ret = t4_get_flash_params(adapter);
 	if (ret < 0) {
 		dev_err(adapter->pdev_dev, "error %d identifying flash\n", ret);
 		return ret;
 	}
-
 	/* Retrieve adapter's device ID
 	 */
-	pci_read_config_word(adapter->pdev, PCI_DEVICE_ID, &device_id);
-	ver = device_id >> 12;
-	adapter->params.chip = 0;
+	pci_read_config_word(adapter->pdev, PCI_DEVICE_ID,
+			     &adapter->params.pci.device_id);
+	pci_read_config_word(adapter->pdev, PCI_VENDOR_ID,
+			     &adapter->params.pci.vendor_id);
+	ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	switch (ver) {
 	case CHELSIO_T4:
-		adapter->params.chip |= CHELSIO_CHIP_CODE(CHELSIO_T4, pl_rev);
 		adapter->params.arch.sge_fl_db = DBPRIO_F;
 		adapter->params.arch.mps_tcam_size =
 				 NUM_MPS_CLS_SRAM_L_INSTANCES;
@@ -9144,9 +10370,9 @@ int t4_prep_adapter(struct adapter *adapter)
 		 * MPS can have 4 priority per port.
 		 */
 		adapter->params.arch.cng_ch_bits_log = 2;
+		adapter->params.cim_la_size = CIMLA_SIZE;
 		break;
 	case CHELSIO_T5:
-		adapter->params.chip |= CHELSIO_CHIP_CODE(CHELSIO_T5, pl_rev);
 		adapter->params.arch.sge_fl_db = DBPRIO_F | DBTYPE_F;
 		adapter->params.arch.mps_tcam_size =
 				 NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
@@ -9155,9 +10381,9 @@ int t4_prep_adapter(struct adapter *adapter)
 		adapter->params.arch.pm_stats_cnt = PM_NSTATS;
 		adapter->params.arch.vfcount = 128;
 		adapter->params.arch.cng_ch_bits_log = 2;
+		adapter->params.cim_la_size = CIMLA_SIZE;
 		break;
 	case CHELSIO_T6:
-		adapter->params.chip |= CHELSIO_CHIP_CODE(CHELSIO_T6, pl_rev);
 		adapter->params.arch.sge_fl_db = 0;
 		adapter->params.arch.mps_tcam_size =
 				 NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
@@ -9169,6 +10395,25 @@ int t4_prep_adapter(struct adapter *adapter)
 		 * MPS can have 8 priority per port.
 		 */
 		adapter->params.arch.cng_ch_bits_log = 3;
+		adapter->params.cim_la_size = CIMLA_SIZE_T6;
+		break;
+	case CHELSIO_T7:
+		adapter->params.arch.sge_fl_db = 0;
+		adapter->params.arch.mps_tcam_size =
+			is_t7(adapter->params.chip)
+				/* In T7 there 3 TCAM each of 512 size*/
+				?
+				NUM_MPS_T5_CLS_SRAM_L_INSTANCES * 3 :
+				NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
+		adapter->params.arch.mps_rplc_size = 256;
+		adapter->params.arch.nchan = NCHAN;
+		adapter->params.arch.pm_stats_cnt = T6_PM_NSTATS;
+		adapter->params.arch.vfcount = 256;
+		/* Congestion map will be for 4 channels so that
+		 * MPS can have 4 priority per port.
+		 */
+		adapter->params.arch.cng_ch_bits_log = 2;
+		adapter->params.cim_la_size = CIMLA_SIZE_T6;
 		break;
 	default:
 		dev_err(adapter->pdev_dev, "Device %d is not supported\n",
@@ -9186,9 +10431,11 @@ int t4_prep_adapter(struct adapter *adapter)
 	adapter->params.portvec = 1;
 	adapter->params.vpd.cclk = 50000;
 
-	/* Set PCIe completion timeout to 4 seconds. */
-	pcie_capability_clear_and_set_word(adapter->pdev, PCI_EXP_DEVCTL2,
-					   PCI_EXP_DEVCTL2_COMP_TIMEOUT, 0xd);
+	ret = t4_get_flash_params(adapter);
+	if (ret < 0) {
+		dev_err(adapter->pdev_dev, "error %d identifying flash\n", ret);
+		return ret;
+	}
 	return 0;
 }
 
@@ -9211,9 +10458,12 @@ int t4_shutdown_adapter(struct adapter *adapter)
 	t4_intr_disable(adapter);
 	t4_write_reg(adapter, DBG_GPIO_EN_A, 0);
 	for_each_port(adapter, port) {
-		u32 a_port_cfg = is_t4(adapter->params.chip) ?
-				       PORT_REG(port, XGMAC_PORT_CFG_A) :
-				       T5_PORT_REG(port, MAC_PORT_CFG_A);
+		u32 a_port_cfg;
+
+		if (CHELSIO_CHIP_VERSION(adapter->params.chip) > CHELSIO_T4)
+			a_port_cfg = t4_port_reg(adapter, port, MAC_PORT_CFG_A);
+		else
+			a_port_cfg = PORT_REG(port, XGMAC_PORT_CFG_A);
 
 		t4_write_reg(adapter, a_port_cfg,
 			     t4_read_reg(adapter, a_port_cfg)
@@ -9323,10 +10573,10 @@ int t4_bar2_sge_qregs(struct adapter *adapter,
  */
 int t4_init_devlog_params(struct adapter *adap)
 {
-	struct devlog_params *dparams = &adap->params.devlog;
-	u32 pf_dparams;
-	unsigned int devlog_meminfo;
+	struct devlog_params *dparams = adap->params.devlog;
+	u32 nentries128, size, start, pf_dparams;
 	struct fw_devlog_cmd devlog_cmd;
+	u8 i, memtype, ncount;
 	int ret;
 
 	/* If we're dealing with newer firmware, the Device Log Parameters
@@ -9336,16 +10586,13 @@ int t4_init_devlog_params(struct adapter *adap)
 	pf_dparams =
 		t4_read_reg(adap, PCIE_FW_REG(PCIE_FW_PF_A, PCIE_FW_PF_DEVLOG));
 	if (pf_dparams) {
-		unsigned int nentries, nentries128;
-
-		dparams->memtype = PCIE_FW_PF_DEVLOG_MEMTYPE_G(pf_dparams);
-		dparams->start = PCIE_FW_PF_DEVLOG_ADDR16_G(pf_dparams) << 4;
-
+		ncount = ((PCIE_FW_PF_DEVLOG_COUNT_MSB_G(pf_dparams) << 1) |
+			   PCIE_FW_PF_DEVLOG_COUNT_LSB_G(pf_dparams));
+		memtype = PCIE_FW_PF_DEVLOG_MEMTYPE_G(pf_dparams);
+		start = PCIE_FW_PF_DEVLOG_ADDR16_G(pf_dparams) << 4;
 		nentries128 = PCIE_FW_PF_DEVLOG_NENTRIES128_G(pf_dparams);
-		nentries = (nentries128 + 1) * 128;
-		dparams->size = nentries * sizeof(struct fw_devlog_e);
-
-		return 0;
+		size = (nentries128 + 1) * 128 * sizeof(struct fw_devlog_e);
+		goto out_copy;
 	}
 
 	/* Otherwise, ask the firmware for its Device Log Parameters.
@@ -9359,15 +10606,41 @@ int t4_init_devlog_params(struct adapter *adap)
 	if (ret)
 		return ret;
 
-	devlog_meminfo =
-		be32_to_cpu(devlog_cmd.memtype_devlog_memaddr16_devlog);
-	dparams->memtype = FW_DEVLOG_CMD_MEMTYPE_DEVLOG_G(devlog_meminfo);
-	dparams->start = FW_DEVLOG_CMD_MEMADDR16_DEVLOG_G(devlog_meminfo) << 4;
-	dparams->size = be32_to_cpu(devlog_cmd.memsize_devlog);
+	pf_dparams = be32_to_cpu(devlog_cmd.memtype_devlog_memaddr16_devlog);
+	memtype = FW_DEVLOG_CMD_MEMTYPE_DEVLOG_G(pf_dparams);
+	start = FW_DEVLOG_CMD_MEMADDR16_DEVLOG_G(pf_dparams) << 4;
+	size = be32_to_cpu(devlog_cmd.memsize_devlog);
+	ncount = 0;
+
+out_copy:
+	adap->params.num_up_cores = 1 << ncount;
+	for (i = 0; i < adap->params.num_up_cores; i++) {
+		dparams[i].memtype = memtype;
+		dparams[i].start = start;
+		dparams[i].size = size / adap->params.num_up_cores;
+		start += dparams[i].size;
+	}
 
 	return 0;
 }
 
+/*
+ * t4_sge_get_qpp - get the number of Egress or Ingress queues per page
+ * @adap: the adapter
+ * @qtype: Egress or Ingress queue map register to read
+ *
+ * Fetches the number of Egress or Ingress queues per page.
+ */
+unsigned int t4_sge_get_qpp(struct adapter *adap, unsigned int qtype)
+{
+	unsigned int s_qpp, qpp;
+
+	s_qpp = (QUEUESPERPAGEPF0_S +
+		 (QUEUESPERPAGEPF1_S - QUEUESPERPAGEPF0_S) * adap->pf);
+	qpp = t4_read_reg(adap, qtype);
+	return ((qpp >> s_qpp) & QUEUESPERPAGEPF0_M);
+}
+
 /**
  *	t4_init_sge_params - initialize adap->params.sge
  *	@adapter: the adapter
@@ -9377,8 +10650,7 @@ int t4_init_devlog_params(struct adapter *adap)
 int t4_init_sge_params(struct adapter *adapter)
 {
 	struct sge_params *sge_params = &adapter->params.sge;
-	u32 hps, qpp;
-	unsigned int s_hps, s_qpp;
+	u32 hps, s_hps;
 
 	/* Extract the SGE Page Size for our PF.
 	 */
@@ -9389,13 +10661,10 @@ int t4_init_sge_params(struct adapter *adapter)
 
 	/* Extract the SGE Egress and Ingess Queues Per Page for our PF.
 	 */
-	s_qpp = (QUEUESPERPAGEPF0_S +
-		(QUEUESPERPAGEPF1_S - QUEUESPERPAGEPF0_S) * adapter->pf);
-	qpp = t4_read_reg(adapter, SGE_EGRESS_QUEUES_PER_PAGE_PF_A);
-	sge_params->eq_qpp = ((qpp >> s_qpp) & QUEUESPERPAGEPF0_M);
-	qpp = t4_read_reg(adapter, SGE_INGRESS_QUEUES_PER_PAGE_PF_A);
-	sge_params->iq_qpp = ((qpp >> s_qpp) & QUEUESPERPAGEPF0_M);
-
+	sge_params->eq_qpp =
+		t4_sge_get_qpp(adapter, SGE_EGRESS_QUEUES_PER_PAGE_PF_A);
+	sge_params->iq_qpp =
+		t4_sge_get_qpp(adapter, SGE_INGRESS_QUEUES_PER_PAGE_PF_A);
 	return 0;
 }
 
@@ -9411,7 +10680,6 @@ int t4_init_tp_params(struct adapter *adap, bool sleep_ok)
 	u32 param, val, v;
 	int chan, ret;
 
-
 	v = t4_read_reg(adap, TP_TIMER_RESOLUTION_A);
 	adap->params.tp.tre = TIMERRESOLUTION_G(v);
 	adap->params.tp.dack_re = DELAYEDACKRESOLUTION_G(v);
@@ -9420,6 +10688,12 @@ int t4_init_tp_params(struct adapter *adap, bool sleep_ok)
 	for (chan = 0; chan < NCHAN; chan++)
 		adap->params.tp.tx_modq[chan] = chan;
 
+	/* Save the number of ports activated by FW */
+	t4_get_tp_num_ports(adap);
+
+	/* Save the TP Channel Map from FW */
+	t4_get_tp_channel_map(adap);
+
 	/* Cache the adapter's Compressed Filter Mode/Mask and global Ingress
 	 * Configuration.
 	 */
@@ -9476,21 +10750,62 @@ int t4_init_tp_params(struct adapter *adap, bool sleep_ok)
 	 * shift positions of several elements of the Compressed Filter Tuple
 	 * for this adapter which we need frequently ...
 	 */
-	adap->params.tp.fcoe_shift = t4_filter_field_shift(adap, FCOE_F);
-	adap->params.tp.port_shift = t4_filter_field_shift(adap, PORT_F);
-	adap->params.tp.vnic_shift = t4_filter_field_shift(adap, VNIC_ID_F);
-	adap->params.tp.vlan_shift = t4_filter_field_shift(adap, VLAN_F);
-	adap->params.tp.tos_shift = t4_filter_field_shift(adap, TOS_F);
-	adap->params.tp.protocol_shift = t4_filter_field_shift(adap,
-							       PROTOCOL_F);
-	adap->params.tp.ethertype_shift = t4_filter_field_shift(adap,
-								ETHERTYPE_F);
-	adap->params.tp.macmatch_shift = t4_filter_field_shift(adap,
-							       MACMATCH_F);
-	adap->params.tp.matchtype_shift = t4_filter_field_shift(adap,
-								MPSHITTYPE_F);
-	adap->params.tp.frag_shift = t4_filter_field_shift(adap,
-							   FRAGMENTATION_F);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		adap->params.tp.ipsecidx_shift =
+			t4_filter_field_shift(adap, IPSECIDX_F);
+		adap->params.tp.fcoe_shift =
+			t4_filter_field_shift(adap, T7_FCOE_F);
+		adap->params.tp.port_shift =
+			t4_filter_field_shift(adap, T7_PORT_F);
+		adap->params.tp.vnic_shift =
+			t4_filter_field_shift(adap, T7_VNIC_ID_F);
+		adap->params.tp.vlan_shift =
+			t4_filter_field_shift(adap, T7_VLAN_F);
+		adap->params.tp.tos_shift =
+			t4_filter_field_shift(adap, T7_TOS_F);
+		adap->params.tp.protocol_shift =
+			t4_filter_field_shift(adap, T7_PROTOCOL_F);
+		adap->params.tp.ethertype_shift =
+			t4_filter_field_shift(adap, T7_ETHERTYPE_F);
+		adap->params.tp.macmatch_shift =
+			t4_filter_field_shift(adap, T7_MACMATCH_F);
+		adap->params.tp.matchtype_shift =
+			t4_filter_field_shift(adap, T7_MPSHITTYPE_F);
+		adap->params.tp.frag_shift =
+			t4_filter_field_shift(adap, T7_FRAGMENTATION_F);
+		adap->params.tp.synonly_shift =
+			t4_filter_field_shift(adap, SYNONLY_F);
+		adap->params.tp.tcpflags_shift =
+			t4_filter_field_shift(adap, TCPFLAGS_F);
+	} else {
+		adap->params.tp.fcoe_shift =
+			t4_filter_field_shift(adap, FCOE_F);
+		adap->params.tp.port_shift =
+			t4_filter_field_shift(adap, PORT_F);
+		adap->params.tp.vnic_shift =
+			t4_filter_field_shift(adap, VNIC_ID_F);
+		adap->params.tp.vlan_shift =
+			t4_filter_field_shift(adap, VLAN_F);
+		adap->params.tp.tos_shift = t4_filter_field_shift(adap, TOS_F);
+		adap->params.tp.protocol_shift =
+			t4_filter_field_shift(adap, PROTOCOL_F);
+		adap->params.tp.ethertype_shift =
+			t4_filter_field_shift(adap, ETHERTYPE_F);
+		adap->params.tp.macmatch_shift =
+			t4_filter_field_shift(adap, MACMATCH_F);
+		adap->params.tp.matchtype_shift =
+			t4_filter_field_shift(adap, MPSHITTYPE_F);
+		adap->params.tp.frag_shift =
+			t4_filter_field_shift(adap, FRAGMENTATION_F);
+
+		/* Following fields are not supported in T6 and older
+		 * NICs.
+		 */
+		adap->params.tp.ipsecidx_shift = -1;
+		adap->params.tp.roce_shift = -1;
+		adap->params.tp.synonly_shift = -1;
+		adap->params.tp.tcpflags_shift = -1;
+	}
 
 	/* If TP_INGRESS_CONFIG.VNID == 0, then TP_VLAN_PRI_MAP.VNIC_ID
 	 * represents the presence of an Outer VLAN instead of a VNIC ID.
@@ -9512,7 +10827,7 @@ int t4_init_tp_params(struct adapter *adap, bool sleep_ok)
  *
  *      Return the shift position of a filter field within the Compressed
  *      Filter Tuple.  The filter field is specified via its selection bit
- *      within TP_VLAN_PRI_MAL (filter mode).  E.g. F_VLAN.
+ *      within TP_VLAN_PRI_MAL (filter mode).  E.g. VLAN_F.
  */
 int t4_filter_field_shift(const struct adapter *adap, int filter_sel)
 {
@@ -9523,6 +10838,54 @@ int t4_filter_field_shift(const struct adapter *adap, int filter_sel)
 	if ((filter_mode & filter_sel) == 0)
 		return -1;
 
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		for (sel = 1, field_shift = 0; sel < filter_sel; sel <<= 1) {
+			switch (filter_mode & sel) {
+			case IPSECIDX_F:
+				field_shift += FT_IPSECIDX_W;
+				break;
+			case T7_FCOE_F:
+				field_shift += FT_FCOE_W;
+				break;
+			case T7_PORT_F:
+				field_shift += FT_PORT_W;
+				break;
+			case T7_VNIC_ID_F:
+				field_shift += FT_VNIC_ID_W;
+				break;
+			case T7_VLAN_F:
+				field_shift += FT_VLAN_W;
+				break;
+			case T7_TOS_F:
+				field_shift += FT_TOS_W;
+				break;
+			case T7_PROTOCOL_F:
+				field_shift += FT_PROTOCOL_W;
+				break;
+			case T7_ETHERTYPE_F:
+				field_shift += FT_ETHERTYPE_W;
+				break;
+			case T7_MACMATCH_F:
+				field_shift += FT_MACMATCH_W;
+				break;
+			case T7_MPSHITTYPE_F:
+				field_shift += FT_MPSHITTYPE_W;
+				break;
+			case T7_FRAGMENTATION_F:
+				field_shift += FT_FRAGMENTATION_W;
+				break;
+			case SYNONLY_F:
+				field_shift += FT_SYNONLY_W;
+				break;
+			case TCPFLAGS_F:
+				field_shift += FT_TCPFLAGS_W;
+				break;
+			}
+		}
+
+		goto out;
+	}
+
 	for (sel = 1, field_shift = 0; sel < filter_sel; sel <<= 1) {
 		switch (filter_mode & sel) {
 		case FCOE_F:
@@ -9557,6 +10920,8 @@ int t4_filter_field_shift(const struct adapter *adap, int filter_sel)
 			break;
 		}
 	}
+
+out:
 	return field_shift;
 }
 
@@ -9668,7 +11033,7 @@ int t4_init_portinfo(struct port_info *pi, int mbox,
 		return ret;
 
 	pi->viid = ret;
-	pi->tx_chan = port;
+	pi->tx_chan = t4_get_tp_port_chan(pi->adapter, port);
 	pi->lport = port;
 	pi->rss_size = rss_size;
 	pi->rx_cchan = t4_get_tp_e2c_map(pi->adapter, port);
@@ -9714,6 +11079,101 @@ int t4_port_init(struct adapter *adap, int mbox, int pf, int vf)
 	return 0;
 }
 
+u8 t4_cim_num_ibq(struct adapter *adap)
+{
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	return chip_ver >= CHELSIO_T7 ? CIM_NUM_IBQ_T7 : CIM_NUM_IBQ;
+}
+
+u8 t4_cim_num_obq(struct adapter *adap)
+{
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	if (chip_ver >= CHELSIO_T7)
+		return CIM_NUM_OBQ_T7;
+
+	if (chip_ver > CHELSIO_T4)
+		return CIM_NUM_OBQ_T5;
+
+	return CIM_NUM_OBQ;
+}
+
+static void t4_read_cimq_cfg_ibq_core(struct adapter *adap, u8 coreid, u32 qid,
+				      u16 *base, u16 *size, u16 *thres)
+{
+	unsigned int v, m;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		v = T7_IBQSELECT_F | T7_QUENUMSELECT_V(qid) |
+		    CORESELECT_V(coreid);
+		/* value is in 512-byte units */
+		m = 512;
+	} else {
+		v = IBQSELECT_F | QUENUMSELECT_V(qid);
+		/* value is in 256-byte units */
+		m = 256;
+	}
+
+	t4_write_reg(adap, CIM_QUEUE_CONFIG_REF_A, v);
+	v = t4_read_reg(adap, CIM_QUEUE_CONFIG_CTRL_A);
+	if (base)
+		*base = CIMQBASE_G(v) * m;
+	if (size)
+		*size = CIMQSIZE_G(v) * m;
+	if (thres)
+		*thres = QUEFULLTHRSH_G(v) * 8; /* 8-byte unit */
+}
+
+static void t4_read_cimq_cfg_obq_core(struct adapter *adap, u8 coreid, u32 qid,
+				      u16 *base, u16 *size)
+{
+	unsigned int v, m;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		v = T7_OBQSELECT_F | T7_QUENUMSELECT_V(qid) |
+		    CORESELECT_V(coreid);
+		/* value is in 512-byte units */
+		m = 512;
+	} else {
+		v = OBQSELECT_F | QUENUMSELECT_V(qid);
+		/* value is in 256-byte units */
+		m = 256;
+	}
+
+	t4_write_reg(adap, CIM_QUEUE_CONFIG_REF_A, v);
+	v = t4_read_reg(adap, CIM_QUEUE_CONFIG_CTRL_A);
+	if (base)
+		*base = CIMQBASE_G(v) * m;
+	if (size)
+		*size = CIMQSIZE_G(v) * m;
+}
+
+/**
+ *     t4_read_cimq_cfg_core - read CIM queue configuration on specific core
+ *     @adap: the adapter
+ *     @coreid: the uP coreid
+ *     @base: holds the queue base addresses in bytes
+ *     @size: holds the queue sizes in bytes
+ *     @thres: holds the queue full thresholds in bytes
+ *
+ *     Returns the current configuration of the CIM queues, starting with
+ *     the IBQs, then the OBQs, on a specific @coreid.
+ */
+void t4_read_cimq_cfg_core(struct adapter *adap, u8 coreid, u16 *base,
+			   u16 *size, u16 *thres)
+{
+	unsigned int cim_num_ibq = t4_cim_num_ibq(adap);
+	unsigned int cim_num_obq = t4_cim_num_obq(adap);
+	unsigned int i;
+
+	for (i = 0; i < cim_num_ibq; i++, base++, size++, thres++)
+		t4_read_cimq_cfg_ibq_core(adap, coreid, i, base, size, thres);
+
+	for (i = 0; i < cim_num_obq; i++, base++, size++)
+		t4_read_cimq_cfg_obq_core(adap, coreid, i, base, size);
+}
+
 int t4_init_port_mirror(struct port_info *pi, u8 mbox, u8 port, u8 pf, u8 vf,
 			u16 *mirror_viid)
 {
@@ -9742,114 +11202,206 @@ int t4_init_port_mirror(struct port_info *pi, u8 mbox, u8 port, u8 pf, u8 vf,
  */
 void t4_read_cimq_cfg(struct adapter *adap, u16 *base, u16 *size, u16 *thres)
 {
-	unsigned int i, v;
-	int cim_num_obq = is_t4(adap->params.chip) ?
-				CIM_NUM_OBQ : CIM_NUM_OBQ_T5;
+	t4_read_cimq_cfg_core(adap, 0, base, size, thres);
+}
 
-	for (i = 0; i < CIM_NUM_IBQ; i++) {
-		t4_write_reg(adap, CIM_QUEUE_CONFIG_REF_A, IBQSELECT_F |
-			     QUENUMSELECT_V(i));
-		v = t4_read_reg(adap, CIM_QUEUE_CONFIG_CTRL_A);
-		/* value is in 256-byte units */
-		*base++ = CIMQBASE_G(v) * 256;
-		*size++ = CIMQSIZE_G(v) * 256;
-		*thres++ = QUEFULLTHRSH_G(v) * 8; /* 8-byte unit */
-	}
-	for (i = 0; i < cim_num_obq; i++) {
-		t4_write_reg(adap, CIM_QUEUE_CONFIG_REF_A, OBQSELECT_F |
-			     QUENUMSELECT_V(i));
-		v = t4_read_reg(adap, CIM_QUEUE_CONFIG_CTRL_A);
-		/* value is in 256-byte units */
-		*base++ = CIMQBASE_G(v) * 256;
-		*size++ = CIMQSIZE_G(v) * 256;
-	}
+static int t4_read_cim_ibq_data_core(struct adapter *adap, u8 coreid, u32 addr,
+				     u32 *data)
+{
+	int ret, attempts;
+	unsigned int v;
+
+	/* It might take 3-10ms before the IBQ debug read access is allowed.
+	 * Wait for 1 Sec with a delay of 1 usec.
+	 */
+	attempts = 1000000;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		v = T7_IBQDBGADDR_V(addr) | IBQDBGCORE_V(coreid);
+	else
+		v = IBQDBGADDR_V(addr);
+
+	t4_write_reg(adap, CIM_IBQ_DBG_CFG_A, v | IBQDBGEN_F);
+	ret = t4_wait_op_done(adap, CIM_IBQ_DBG_CFG_A, IBQDBGBUSY_F, 0,
+			      attempts, 1);
+	if (ret)
+		return ret;
+
+	*data = t4_read_reg(adap, CIM_IBQ_DBG_DATA_A);
+	return 0;
 }
 
 /**
- *	t4_read_cim_ibq - read the contents of a CIM inbound queue
- *	@adap: the adapter
- *	@qid: the queue index
- *	@data: where to store the queue contents
- *	@n: capacity of @data in 32-bit words
+ *     t4_read_cim_ibq_core - read the contents of a CIM inbound queue on
+ *     specific core
+ *     @adap: the adapter
+ *     @coreid: the uP coreid
+ *     @qid: the queue index
+ *     @data: where to store the queue contents
+ *     @n: capacity of @data in 32-bit words
  *
- *	Reads the contents of the selected CIM queue starting at address 0 up
- *	to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
- *	error and the number of 32-bit words actually read on success.
+ *     Reads the contents of the selected CIM queue starting at address 0 up
+ *     to the capacity of @data on a specific @coreid.  @n must be a multiple
+ *     of 4.  Returns < 0 on error and the number of 32-bit words actually
+ *     read on success.
  */
-int t4_read_cim_ibq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
+int t4_read_cim_ibq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
+			 size_t n)
 {
-	int i, err, attempts;
-	unsigned int addr;
-	const unsigned int nwords = CIM_IBQ_SIZE * 4;
+	unsigned int cim_num_ibq = t4_cim_num_ibq(adap);
+	u16 i, addr, nwords;
+	int ret;
 
-	if (qid > 5 || (n & 3))
+	if (qid > (cim_num_ibq - 1) || (n & 3))
 		return -EINVAL;
 
-	addr = qid * nwords;
+	t4_read_cimq_cfg_ibq_core(adap, coreid, qid, &addr, &nwords, NULL);
+	addr >>= sizeof(u16);
+	nwords >>= sizeof(u16);
 	if (n > nwords)
 		n = nwords;
 
-	/* It might take 3-10ms before the IBQ debug read access is allowed.
-	 * Wait for 1 Sec with a delay of 1 usec.
-	 */
-	attempts = 1000000;
-
-	for (i = 0; i < n; i++, addr++) {
-		t4_write_reg(adap, CIM_IBQ_DBG_CFG_A, IBQDBGADDR_V(addr) |
-			     IBQDBGEN_F);
-		err = t4_wait_op_done(adap, CIM_IBQ_DBG_CFG_A, IBQDBGBUSY_F, 0,
-				      attempts, 1);
-		if (err)
-			return err;
-		*data++ = t4_read_reg(adap, CIM_IBQ_DBG_DATA_A);
+	for (i = 0; i < n; i++, addr++, data++) {
+		ret = t4_read_cim_ibq_data_core(adap, coreid, addr, data);
+		if (ret < 0)
+			return ret;
 	}
+
 	t4_write_reg(adap, CIM_IBQ_DBG_CFG_A, 0);
 	return i;
 }
 
-/**
- *	t4_read_cim_obq - read the contents of a CIM outbound queue
- *	@adap: the adapter
- *	@qid: the queue index
- *	@data: where to store the queue contents
- *	@n: capacity of @data in 32-bit words
+/*
+ * t4_read_cim_ibq - read the contents of a CIM inbound queue
+ * @adap: the adapter
+ * @qid: the queue index
+ * @data: where to store the queue contents
+ * @n: capacity of @data in 32-bit words
  *
- *	Reads the contents of the selected CIM queue starting at address 0 up
- *	to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
- *	error and the number of 32-bit words actually read on success.
+ * Reads the contents of the selected CIM queue starting at address 0 up
+ * to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
+ * error and the number of 32-bit words actually read on success.
  */
-int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
+int t4_read_cim_ibq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
+{
+	return t4_read_cim_ibq_core(adap, 0, qid, data, n);
+}
+
+static int t4_read_cim_obq_data_core(struct adapter *adap, u8 coreid, u32 addr,
+				     u32 *data)
+{
+	unsigned int v;
+	int ret;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		v = T7_OBQDBGADDR_V(addr) | OBQDBGCORE_V(coreid);
+	else
+		v = OBQDBGADDR_V(addr);
+
+	t4_write_reg(adap, CIM_OBQ_DBG_CFG_A, v | OBQDBGEN_F);
+	ret = t4_wait_op_done(adap, CIM_OBQ_DBG_CFG_A, OBQDBGBUSY_F, 0, 2, 1);
+	if (ret)
+		return ret;
+
+	*data = t4_read_reg(adap, CIM_OBQ_DBG_DATA_A);
+	return 0;
+}
+
+/*
+ * t4_read_cim_obq_core - read the contents of a CIM outbound queue on
+ * specific core
+ * @adap: the adapter
+ * @coreid: the uP coreid
+ * @qid: the queue index
+ * @data: where to store the queue contents
+ * @n: capacity of @data in 32-bit words
+ *
+ * Reads the contents of the selected CIM queue starting at address 0 up
+ * to the capacity of @data on specific @coreid.  @n must be a multiple
+ * of 4.  Returns < 0 on error and the number of 32-bit words actually
+ * read on success.
+ */
+int t4_read_cim_obq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
+			 size_t n)
 {
-	int i, err;
-	unsigned int addr, v, nwords;
-	int cim_num_obq = is_t4(adap->params.chip) ?
-				CIM_NUM_OBQ : CIM_NUM_OBQ_T5;
+	unsigned int cim_num_obq = t4_cim_num_obq(adap);
+	u16 i, addr, nwords;
+	int ret;
 
 	if ((qid > (cim_num_obq - 1)) || (n & 3))
 		return -EINVAL;
 
-	t4_write_reg(adap, CIM_QUEUE_CONFIG_REF_A, OBQSELECT_F |
-		     QUENUMSELECT_V(qid));
-	v = t4_read_reg(adap, CIM_QUEUE_CONFIG_CTRL_A);
-
-	addr = CIMQBASE_G(v) * 64;    /* muliple of 256 -> muliple of 4 */
-	nwords = CIMQSIZE_G(v) * 64;  /* same */
+	t4_read_cimq_cfg_obq_core(adap, coreid, qid, &addr, &nwords);
+	addr >>= sizeof(u16);
+	nwords >>= sizeof(u16);
 	if (n > nwords)
 		n = nwords;
-
-	for (i = 0; i < n; i++, addr++) {
-		t4_write_reg(adap, CIM_OBQ_DBG_CFG_A, OBQDBGADDR_V(addr) |
-			     OBQDBGEN_F);
-		err = t4_wait_op_done(adap, CIM_OBQ_DBG_CFG_A, OBQDBGBUSY_F, 0,
-				      2, 1);
-		if (err)
-			return err;
-		*data++ = t4_read_reg(adap, CIM_OBQ_DBG_DATA_A);
+	for (i = 0; i < n; i++, addr++, data++) {
+		ret = t4_read_cim_obq_data_core(adap, coreid, addr, data);
+		if (ret < 0)
+			return ret;
 	}
+
 	t4_write_reg(adap, CIM_OBQ_DBG_CFG_A, 0);
 	return i;
 }
 
+/*
+ * t4_read_cim_obq - read the contents of a CIM outbound queue
+ * @adap: the adapter
+ * @qid: the queue index
+ * @data: where to store the queue contents
+ * @n: capacity of @data in 32-bit words
+ *
+ * Reads the contents of the selected CIM queue starting at address 0 up
+ * to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
+ * error and the number of 32-bit words actually read on success.
+ */
+int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
+{
+	return t4_read_cim_obq_core(adap, 0, qid, data, n);
+}
+
+/*
+ * t4_cim_read_core - read a block from CIM internal address space
+ * of a control register group on specific core.
+ * @adap: the adapter
+ * @group: the control register group to select for read
+ * @coreid: the uP coreid
+ * @addr: the start address within the CIM address space
+ * @n: number of words to read
+ * @valp: where to store the result
+ *
+ * Reads a block of 4-byte words from the CIM intenal address space
+ * of a control register @group on a specific @coreid.
+ */
+int t4_cim_read_core(struct adapter *adap, u8 group, u8 coreid,
+		     unsigned int addr, unsigned int n, unsigned int *valp)
+{
+	unsigned int hostbusy, v = 0;
+	int ret = 0;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		hostbusy = T7_HOSTBUSY_F;
+		v = HOSTGRPSEL_V(group) | HOSTCORESEL_V(coreid);
+	} else {
+		hostbusy = HOSTBUSY_F;
+	}
+
+	if (t4_read_reg(adap, CIM_HOST_ACC_CTRL_A) & hostbusy)
+		return -EBUSY;
+
+	for (; !ret && n--; addr += 4) {
+		t4_write_reg(adap, CIM_HOST_ACC_CTRL_A, addr | v);
+		ret = t4_wait_op_done(adap, CIM_HOST_ACC_CTRL_A, hostbusy, 0, 5,
+				      2);
+		if (!ret)
+			*valp++ = t4_read_reg(adap, CIM_HOST_ACC_DATA_A);
+	}
+
+	return ret;
+}
+
 /**
  *	t4_cim_read - read a block from CIM internal address space
  *	@adap: the adapter
@@ -9862,18 +11414,48 @@ int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
 int t4_cim_read(struct adapter *adap, unsigned int addr, unsigned int n,
 		unsigned int *valp)
 {
+	return t4_cim_read_core(adap, 0, 0, addr, n, valp);
+}
+
+/**
+ *      t4_cim_write_core - write a block into CIM internal address space
+ *      of a control register group on specific core.
+ *      @adap: the adapter
+ *      @group: the control register group to select for write
+ *      @coreid: the uP coreid
+ *      @addr: the start address within the CIM address space
+ *      @n: number of words to write
+ *      @valp: set of values to write
+ *
+ *      Writes a block of 4-byte words into the CIM intenal address space
+ *      of a control register @group on a specific @coreid.
+ */
+int t4_cim_write_core(struct adapter *adap, u8 group, u8 coreid,
+		      unsigned int addr, unsigned int n,
+		      const unsigned int *valp)
+{
+	unsigned int hostbusy, v;
 	int ret = 0;
 
-	if (t4_read_reg(adap, CIM_HOST_ACC_CTRL_A) & HOSTBUSY_F)
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		hostbusy = T7_HOSTBUSY_F;
+		v = T7_HOSTWRITE_F | HOSTGRPSEL_V(group) |
+		    HOSTCORESEL_V(coreid);
+	} else {
+		hostbusy = HOSTBUSY_F;
+		v = HOSTWRITE_F;
+	}
+
+	if (t4_read_reg(adap, CIM_HOST_ACC_CTRL_A) & hostbusy)
 		return -EBUSY;
 
 	for ( ; !ret && n--; addr += 4) {
-		t4_write_reg(adap, CIM_HOST_ACC_CTRL_A, addr);
-		ret = t4_wait_op_done(adap, CIM_HOST_ACC_CTRL_A, HOSTBUSY_F,
-				      0, 5, 2);
-		if (!ret)
-			*valp++ = t4_read_reg(adap, CIM_HOST_ACC_DATA_A);
+		t4_write_reg(adap, CIM_HOST_ACC_DATA_A, *valp++);
+		t4_write_reg(adap, CIM_HOST_ACC_CTRL_A, addr | v);
+		ret = t4_wait_op_done(adap, CIM_HOST_ACC_CTRL_A, hostbusy, 0, 5,
+				      2);
 	}
+
 	return ret;
 }
 
@@ -9889,52 +11471,40 @@ int t4_cim_read(struct adapter *adap, unsigned int addr, unsigned int n,
 int t4_cim_write(struct adapter *adap, unsigned int addr, unsigned int n,
 		 const unsigned int *valp)
 {
-	int ret = 0;
-
-	if (t4_read_reg(adap, CIM_HOST_ACC_CTRL_A) & HOSTBUSY_F)
-		return -EBUSY;
-
-	for ( ; !ret && n--; addr += 4) {
-		t4_write_reg(adap, CIM_HOST_ACC_DATA_A, *valp++);
-		t4_write_reg(adap, CIM_HOST_ACC_CTRL_A, addr | HOSTWRITE_F);
-		ret = t4_wait_op_done(adap, CIM_HOST_ACC_CTRL_A, HOSTBUSY_F,
-				      0, 5, 2);
-	}
-	return ret;
-}
-
-static int t4_cim_write1(struct adapter *adap, unsigned int addr,
-			 unsigned int val)
-{
-	return t4_cim_write(adap, addr, 1, &val);
+	return t4_cim_write_core(adap, 0, 0, addr, n, valp);
 }
 
 /**
- *	t4_cim_read_la - read CIM LA capture buffer
- *	@adap: the adapter
- *	@la_buf: where to store the LA data
- *	@wrptr: the HW write pointer within the capture buffer
+ *      t4_cim_read_la_core - read CIM LA capture buffer on specific core
+ *      @adap: the adapter
+ *      @coreid: uP coreid
+ *      @la_buf: where to store the LA data
+ *      @wrptr: the HW write pointer within the capture buffet4_init_portinfor
  *
- *	Reads the contents of the CIM LA buffer with the most recent entry at
- *	the end	of the returned data and with the entry at @wrptr first.
- *	We try to leave the LA in the running state we find it in.
+ *      Reads the contents of the CIM LA buffer on a specific @coreid
+ *      with the most recent entry at the end of the returned data
+ *      and with the entry at @wrptr first. We try to leave the LA
+ *      in the running state we find it in.
  */
-int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr)
+int t4_cim_read_la_core(struct adapter *adap, u8 coreid, u32 *la_buf,
+			u32 *wrptr)
 {
-	int i, ret;
 	unsigned int cfg, val, idx;
+	int i, ret;
 
-	ret = t4_cim_read(adap, UP_UP_DBG_LA_CFG_A, 1, &cfg);
+	ret = t4_cim_read_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1, &cfg);
 	if (ret)
 		return ret;
 
-	if (cfg & UPDBGLAEN_F) {	/* LA is running, freeze it */
-		ret = t4_cim_write1(adap, UP_UP_DBG_LA_CFG_A, 0);
+	if (cfg & UPDBGLAEN_F) { /* LA is running, freeze it */
+		val = 0;
+		ret = t4_cim_write_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1,
+					&val);
 		if (ret)
 			return ret;
 	}
 
-	ret = t4_cim_read(adap, UP_UP_DBG_LA_CFG_A, 1, &val);
+	ret = t4_cim_read_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1, &val);
 	if (ret)
 		goto restart;
 
@@ -9943,25 +11513,29 @@ int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr)
 		*wrptr = idx;
 
 	for (i = 0; i < adap->params.cim_la_size; i++) {
-		ret = t4_cim_write1(adap, UP_UP_DBG_LA_CFG_A,
-				    UPDBGLARDPTR_V(idx) | UPDBGLARDEN_F);
+		val = UPDBGLARDPTR_V(idx) | UPDBGLARDEN_F;
+		ret = t4_cim_write_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1,
+					&val);
 		if (ret)
 			break;
-		ret = t4_cim_read(adap, UP_UP_DBG_LA_CFG_A, 1, &val);
+		ret = t4_cim_read_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1,
+				       &val);
 		if (ret)
 			break;
 		if (val & UPDBGLARDEN_F) {
 			ret = -ETIMEDOUT;
 			break;
 		}
-		ret = t4_cim_read(adap, UP_UP_DBG_LA_DATA_A, 1, &la_buf[i]);
+		ret = t4_cim_read_core(adap, 1, coreid, UP_UP_DBG_LA_DATA_A, 1,
+				       &la_buf[i]);
 		if (ret)
 			break;
 
 		/* Bits 0-3 of UpDbgLaRdPtr can be between 0000 to 1001 to
 		 * identify the 32-bit portion of the full 312-bit data
 		 */
-		if (is_t6(adap->params.chip) && (idx & 0xf) >= 9)
+		if ((CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T5) &&
+		    (idx & 0xf) >= 9)
 			idx = (idx & 0xff0) + 0x10;
 		else
 			idx++;
@@ -9970,14 +11544,33 @@ int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr)
 	}
 restart:
 	if (cfg & UPDBGLAEN_F) {
-		int r = t4_cim_write1(adap, UP_UP_DBG_LA_CFG_A,
-				      cfg & ~UPDBGLARDEN_F);
+		int r;
+
+		val = cfg & ~UPDBGLARDEN_F;
+		r = t4_cim_write_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1,
+				      &val);
 		if (!ret)
 			ret = r;
 	}
+
 	return ret;
 }
 
+/**
+ *	t4_cim_read_la - read CIM LA capture buffer
+ *	@adap: the adapter
+ *	@la_buf: where to store the LA data
+ *	@wrptr: the HW write pointer within the capture buffer
+ *
+ *	Reads the contents of the CIM LA buffer with the most recent entry at
+ *	the end	of the returned data and with the entry at @wrptr first.
+ *	We try to leave the LA in the running state we find it in.
+ */
+int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr)
+{
+	return t4_cim_read_la_core(adap, 0, la_buf, wrptr);
+}
+
 /**
  *	t4_tp_read_la - read TP LA capture buffer
  *	@adap: the adapter
@@ -10162,10 +11755,10 @@ void t4_idma_monitor(struct adapter *adapter,
  */
 int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
 {
+	unsigned int sf_sec_size = adap->params.sf_size / adap->params.sf_nsec;
+	unsigned int flash_cfg_start_sec, flash_cfg_size;
 	int ret, i, n, cfg_addr;
 	unsigned int addr;
-	unsigned int flash_cfg_start_sec;
-	unsigned int sf_sec_size = adap->params.sf_size / adap->params.sf_nsec;
 
 	cfg_addr = t4_flash_cfg_addr(adap);
 	if (cfg_addr < 0)
@@ -10174,14 +11767,15 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
 	addr = cfg_addr;
 	flash_cfg_start_sec = addr / SF_SEC_SIZE;
 
-	if (size > FLASH_CFG_MAX_SIZE) {
+	flash_cfg_size = t4_flash_location_size(adap, FLASH_LOC_CFG);
+
+	if (size > flash_cfg_size) {
 		dev_err(adap->pdev_dev, "cfg file too large, max is %u bytes\n",
-			FLASH_CFG_MAX_SIZE);
+			flash_cfg_size);
 		return -EFBIG;
 	}
 
-	i = DIV_ROUND_UP(FLASH_CFG_MAX_SIZE,	/* # of sectors spanned */
-			 sf_sec_size);
+	i = DIV_ROUND_UP(flash_cfg_size, sf_sec_size);	/* # of sectors spanned */
 	ret = t4_flash_erase_sectors(adap, flash_cfg_start_sec,
 				     flash_cfg_start_sec + i - 1);
 	/* If size == 0 then we're simply erasing the FLASH sectors associated
@@ -10345,6 +11939,8 @@ int t4_sge_ctxt_rd(struct adapter *adap, unsigned int mbox, unsigned int cid,
 		data[3] = be32_to_cpu(c.u.idctxt.ctxt_data3);
 		data[4] = be32_to_cpu(c.u.idctxt.ctxt_data4);
 		data[5] = be32_to_cpu(c.u.idctxt.ctxt_data5);
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+			data[6] = be32_to_cpu(c.u.idctxt.ctxt_data6);
 	}
 	return ret;
 }
@@ -10363,13 +11959,21 @@ int t4_sge_ctxt_rd_bd(struct adapter *adap, unsigned int cid,
 		      enum ctxt_type ctype, u32 *data)
 {
 	int i, ret;
+	u32 end;
 
 	t4_write_reg(adap, SGE_CTXT_CMD_A, CTXTQID_V(cid) | CTXTTYPE_V(ctype));
 	ret = t4_wait_op_done(adap, SGE_CTXT_CMD_A, BUSY_F, 0, 3, 1);
-	if (!ret)
-		for (i = SGE_CTXT_DATA0_A; i <= SGE_CTXT_DATA5_A; i += 4)
-			*data++ = t4_read_reg(adap, i);
-	return ret;
+	if (ret)
+		return ret;
+
+	end = CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7 ?
+		      SGE_CTXT_DATA6_A :
+		      SGE_CTXT_DATA5_A;
+
+	for (i = SGE_CTXT_DATA0_A; i <= end; i += 4)
+		*data++ = t4_read_reg(adap, i);
+
+	return 0;
 }
 
 int t4_sched_params(struct adapter *adapter, u8 type, u8 level, u8 mode,
@@ -10416,19 +12020,23 @@ int t4_sched_params(struct adapter *adapter, u8 type, u8 level, u8 mode,
  *	Reads the I2C data from the indicated device and location.
  */
 int t4_i2c_rd(struct adapter *adap, unsigned int mbox, int port,
-	      unsigned int devid, unsigned int offset,
-	      unsigned int len, u8 *buf)
+	      unsigned int devid, unsigned int offset, unsigned int len,
+	      u8 *buf)
 {
 	struct fw_ldst_cmd ldst_cmd, ldst_rpl;
 	unsigned int i2c_max = sizeof(ldst_cmd.u.i2c.data);
 	int ret = 0;
 
-	if (len > I2C_PAGE_SIZE)
+	if (len > I2C_PAGE_SIZE) {
+		dev_err(adap->pdev_dev, "Incorrect page size len %d\n", len);
 		return -EINVAL;
+	}
 
 	/* Dont allow reads that spans multiple pages */
-	if (offset < I2C_PAGE_SIZE && offset + len > I2C_PAGE_SIZE)
+	if (offset < I2C_PAGE_SIZE && offset + len > I2C_PAGE_SIZE) {
+		dev_err(adap->pdev_dev, "Read across the page\n");
 		return -EINVAL;
+	}
 
 	memset(&ldst_cmd, 0, sizeof(ldst_cmd));
 	ldst_cmd.op_to_addrspace =
@@ -10581,16 +12189,17 @@ int t4_load_boot(struct adapter *adap, u8 *boot_data,
 	unsigned int boot_sector = (boot_addr * 1024);
 	struct cxgb4_pci_exp_rom_header *header;
 	struct cxgb4_pcir_data *pcir_header;
-	int pcir_offset;
+	int pcir_offset, ret, addr;
 	unsigned int i;
 	u16 device_id;
-	int ret, addr;
 
-	/**
-	 * Make sure the boot image does not encroach on the firmware region
+	/*
+	 * Make sure the boot image does not exceed its available space.
 	 */
-	if ((boot_sector + size) >> 16 > FLASH_FW_START_SEC) {
-		dev_err(adap->pdev_dev, "boot image encroaching on firmware region\n");
+	if (!t4_flash_location_in_range(adap, FLASH_LOC_BOOT_AREA,
+					boot_sector + size)) {
+		dev_err(adap->pdev_dev,
+			"boot data is larger than available BOOT area\n");
 		return -EFBIG;
 	}
 
@@ -10632,7 +12241,9 @@ int t4_load_boot(struct adapter *adap, u8 *boot_data,
 	 * and Boot configuration data sections. These 3 boot sections span
 	 * sectors 0 to 7 in flash and live right before the FW image location.
 	 */
-	i = DIV_ROUND_UP(size ? size : FLASH_FW_START,  sf_sec_size);
+	i = DIV_ROUND_UP(size ? size :
+			 t4_flash_location_size(adap, FLASH_LOC_BOOT_AREA),
+			 sf_sec_size);
 	ret = t4_flash_erase_sectors(adap, boot_sector >> 16,
 				     (boot_sector >> 16) + i - 1);
 
@@ -10693,35 +12304,37 @@ int t4_load_boot(struct adapter *adap, u8 *boot_data,
  */
 static int t4_flash_bootcfg_addr(struct adapter *adapter)
 {
+	int ret = t4_flash_location_end(adapter, FLASH_LOC_BOOTCFG);
 	/**
 	 * If the device FLASH isn't large enough to hold a Firmware
 	 * Configuration File, return an error.
 	 */
-	if (adapter->params.sf_size <
-	    FLASH_BOOTCFG_START + FLASH_BOOTCFG_MAX_SIZE)
+	if (ret < 0 || adapter->params.sf_size < ret)
 		return -ENOSPC;
 
-	return FLASH_BOOTCFG_START;
+	return t4_flash_location_start(adapter, FLASH_LOC_BOOTCFG);
 }
 
 int t4_load_bootcfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
 {
 	unsigned int sf_sec_size = adap->params.sf_size / adap->params.sf_nsec;
+	unsigned int boot_cfg_start_sec, boot_cfg_size;
 	struct cxgb4_bootcfg_data *header;
-	unsigned int flash_cfg_start_sec;
-	unsigned int addr, npad;
 	int ret, i, n, cfg_addr;
+	unsigned int addr, npad;
 
 	cfg_addr = t4_flash_bootcfg_addr(adap);
 	if (cfg_addr < 0)
 		return cfg_addr;
 
 	addr = cfg_addr;
-	flash_cfg_start_sec = addr / SF_SEC_SIZE;
+	boot_cfg_start_sec = addr / SF_SEC_SIZE;
+	boot_cfg_size = t4_flash_location_size(adap, FLASH_LOC_BOOTCFG);
 
-	if (size > FLASH_BOOTCFG_MAX_SIZE) {
-		dev_err(adap->pdev_dev, "bootcfg file too large, max is %u bytes\n",
-			FLASH_BOOTCFG_MAX_SIZE);
+	if (size > boot_cfg_size) {
+		dev_err(adap->pdev_dev,
+			"bootcfg file too large, max is %u bytes\n",
+			boot_cfg_size);
 		return -EFBIG;
 	}
 
@@ -10732,10 +12345,9 @@ int t4_load_bootcfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
 		goto out;
 	}
 
-	i = DIV_ROUND_UP(FLASH_BOOTCFG_MAX_SIZE,
-			 sf_sec_size);
-	ret = t4_flash_erase_sectors(adap, flash_cfg_start_sec,
-				     flash_cfg_start_sec + i - 1);
+	i = DIV_ROUND_UP(boot_cfg_size, sf_sec_size); /* # of sectors spanned */
+	ret = t4_flash_erase_sectors(adap, boot_cfg_start_sec,
+				     boot_cfg_start_sec + i - 1);
 
 	/**
 	 * If size == 0 then we're simply erasing the FLASH sectors associated
-- 
2.39.1


