Return-Path: <netdev+bounces-215940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6359B3107A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F23B83CA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9C2E8880;
	Fri, 22 Aug 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qU9uC44z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iw+fY5fA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570802E7BDE
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847704; cv=none; b=cz68632GeNY85vNl8RjD+0i+XpLnRWsKyXP9ekCovlTWICQUsPWEDq6q+XhlWndYWWpWuHtWwwW5ghFOouVap587zdNNQpKElJ86dXslbTUG9HHCGFtic/lwT4pCFgldELWmtrLw6JFJlsHpSHj0dlLlv9j10UintNEaPnqpJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847704; c=relaxed/simple;
	bh=f+QoYvXzougOyASJfl7wxuXlvN7/5QCRgMFfduB/M3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yqx08fhmWKabRw+Y89ZmSOJSlGqaQebnEOrgEB5KQ1DbRSUbdvlZIvdL6lRU0eEunB/FVljbnmVa0wC8t2hQb7Dqi7wV4uS9SiVxFvCrKpIxT20cRrMmX3dCz4vY+m9dnjVvvgKd4aAdmlHx367CRZfmT3F03qRhIEGiwUgEz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qU9uC44z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iw+fY5fA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755847700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ViQke3k+foxS5LjDjTJunY4tscMHFSrelJAdKTY6b/c=;
	b=qU9uC44zq7wVseaFACNBd/dv55V0eSyz/Crwmo3B8BnbBbf2FtR8pNMFusvHnbGfiykSAP
	5NCJUFZgNmtYp9qjqolngjl/3VWUcebvhvsQxYQ+4M7U+A9wiAkgcXJ44BcHJeTO/cQPha
	aqlqe5iU+jpzJ7hqccgFOxZKdE3s9CSqQaMfuuUaQD3nQOQVaeMZ6BUJpSmTm99LENhXdY
	vyjuBd1/yINc5uSkP8aM/SqPUYCXwIVG1YnF8VygrusfJRhoUxr53Z+5ee6vWswfLPNfg/
	LlH/2I736cNKxC3oFExz2tjEfcbwuFjVipXcdChgEnWugVSvqporkvrMZJEGnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755847700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ViQke3k+foxS5LjDjTJunY4tscMHFSrelJAdKTY6b/c=;
	b=Iw+fY5fAPmIlHTbtdpQTiSL2wG6ZHOLSMLrs0r5anHwIGryfI+4CKpOW7199c2ARfBZTkw
	fvHKFIYCmoi1vjAQ==
Date: Fri, 22 Aug 2025 09:28:10 +0200
Subject: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux worker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAocqGgC/02NQQqDMBBFryKz7pQkapWueo8ionHUAYltktoUy
 d0bpIsuH4///g6OLJODa7aDpY0dryaBOmWg585MhDwkBiVUKWqZI099y/bZeoey66pK66ovdA9
 p8LA0cjhid+D3goaChyaZmZ1f7ed42eThf8HyP7hJlFjry6hFXuaFUreFzcvb1XA4DwRNjPELD
 llQuLIAAAA=
X-Change-ID: 20250813-igb_irq_ts-1aa77cc7b4cb
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5960; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=f+QoYvXzougOyASJfl7wxuXlvN7/5QCRgMFfduB/M3M=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBoqBwTByI6aw64qJq0JqMWi++0xz244I2r+STq6
 M0r7HG5T7SJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaKgcEwAKCRDBk9HyqkZz
 gk6FD/9KtZIIVyphkxRq8fYirxxKzJMlY0MDXUSm5XDcaaLh1Pptn5Uq8OMspMqAkTYhnESt/GO
 H4tSfsEh/gh7XtViuirgQR/7ECJh3b+8viBHejhJ12tR2zSfNCZUikHP3XCX1Vc4430YM1AOcWN
 ThAe2q7P+0eM0Lip6O6r+WWizCuWP3Hz+LOyrQq5ZlxFHOY6Malf39M05dVygPRP1mgJEOAt6pO
 NxAtBwLJEbc871H35de+Nz6Gd40ZxwJ6Q/pDSPWd49Rxa1qyxbAE+qHAuGEMBimShFHWfjJcstd
 AgEuHW2WrENTpmT/BKy4EY3KgunGiZ53Fo45JqJnzZ118d4z5TTKoEV3VqL4bVBNKsrzexCiDto
 snfviK6Fvli34lNdBU9KS2Z6aTbXUSUGl15emqq7ro91g4DWWr9KHDdngSqmXsUFnRwLl2c40rT
 5D4swU/Y/csSxN5oe6i840oPYPFMS70T0cZz3VAXoqyeJ2n/7wODoyDRDir2cPkSCKmRXblRmQg
 jFlh0Y+lSa0E4NkApc7L9IO+TTmAcHpseqIWGaS+2k+QVGShyRCETLCvUks2WDznBxcYzChH+rZ
 0Wftca1P74E3M9yIMmKtZwDA23q0cS/qi1Kapfn2t0kdPPOePRG+69lhdOKE+dE9T1hXE0KvCff
 GwS4m0u5Dlils7A==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

The current implementation uses schedule_work() which is executed by the
system work queue to retrieve Tx timestamps. This increases latency and can
lead to timeouts in case of heavy system load.

Therefore, switch to the PTP aux worker which can be prioritized and pinned
according to use case. Tested on Intel i210.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v2:
- Switch from IRQ to PTP aux worker due to NTP performance regression (Miroslav)
- Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de
---
 drivers/net/ethernet/intel/igb/igb.h      |  1 -
 drivers/net/ethernet/intel/igb/igb_main.c |  6 +++---
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 28 +++++++++++++++-------------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c3f4f7cd264e9b2ff70f03b580f95b15b528028c..f285def61f7a778f66944d6c52bb31f11ff803cf 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -624,7 +624,6 @@ struct igb_adapter {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
 	struct delayed_work ptp_overflow_work;
-	struct work_struct ptp_tx_work;
 	struct sk_buff *ptp_tx_skb;
 	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae61e93aa737b0103e00580e73601d62b..76467f0e53305188fcbbff27e21e478e764ca552 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6576,7 +6576,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 			adapter->ptp_tx_skb = skb_get(skb);
 			adapter->ptp_tx_start = jiffies;
 			if (adapter->hw.mac.type == e1000_82576)
-				schedule_work(&adapter->ptp_tx_work);
+				ptp_schedule_worker(adapter->ptp_clock, 0);
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
@@ -6612,7 +6612,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		dev_kfree_skb_any(adapter->ptp_tx_skb);
 		adapter->ptp_tx_skb = NULL;
 		if (adapter->hw.mac.type == e1000_82576)
-			cancel_work_sync(&adapter->ptp_tx_work);
+			ptp_cancel_worker_sync(adapter->ptp_clock);
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 	}
 
@@ -7080,7 +7080,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		ptp_schedule_worker(adapter->ptp_clock, 0);
 	}
 
 	if (tsicr & TSINTR_TT0)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index a7876882aeaf2b2a7fb9ec6ff5c83d8a1b06008a..8dabde01d09dcacc13e19fa4ce7ad0327077190a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -798,20 +798,20 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 
 /**
  * igb_ptp_tx_work
- * @work: pointer to work struct
+ * @ptp: pointer to ptp clock information
  *
  * This work function polls the TSYNCTXCTL valid bit to determine when a
  * timestamp has been taken for the current stored skb.
  **/
-static void igb_ptp_tx_work(struct work_struct *work)
+static long igb_ptp_tx_work(struct ptp_clock_info *ptp)
 {
-	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
-						   ptp_tx_work);
+	struct igb_adapter *adapter = container_of(ptp, struct igb_adapter,
+						   ptp_caps);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsynctxctl;
 
 	if (!adapter->ptp_tx_skb)
-		return;
+		return -1;
 
 	if (time_is_before_jiffies(adapter->ptp_tx_start +
 				   IGB_PTP_TX_TIMEOUT)) {
@@ -824,15 +824,17 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		 */
 		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
-		return;
+		return -1;
 	}
 
 	tsynctxctl = rd32(E1000_TSYNCTXCTL);
-	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
+	if (tsynctxctl & E1000_TSYNCTXCTL_VALID) {
 		igb_ptp_tx_hwtstamp(adapter);
-	else
-		/* reschedule to check later */
-		schedule_work(&adapter->ptp_tx_work);
+		return -1;
+	}
+
+	/* reschedule to check later */
+	return 1;
 }
 
 static void igb_ptp_overflow_check(struct work_struct *work)
@@ -915,7 +917,7 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 	 * timestamp bit when this occurs.
 	 */
 	if (timeout) {
-		cancel_work_sync(&adapter->ptp_tx_work);
+		ptp_cancel_worker_sync(adapter->ptp_clock);
 		dev_kfree_skb_any(adapter->ptp_tx_skb);
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
@@ -1381,6 +1383,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	adapter->ptp_caps.do_aux_work = igb_ptp_tx_work;
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1392,7 +1395,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
 
 		spin_lock_init(&adapter->tmreg_lock);
-		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
 
 		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
@@ -1437,7 +1439,7 @@ void igb_ptp_suspend(struct igb_adapter *adapter)
 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
-	cancel_work_sync(&adapter->ptp_tx_work);
+	ptp_cancel_worker_sync(adapter->ptp_clock);
 	if (adapter->ptp_tx_skb) {
 		dev_kfree_skb_any(adapter->ptp_tx_skb);
 		adapter->ptp_tx_skb = NULL;

---
base-commit: a7bd72158063740212344fad5d99dcef45bc70d6
change-id: 20250813-igb_irq_ts-1aa77cc7b4cb

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


