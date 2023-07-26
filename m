Return-Path: <netdev+bounces-21661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C576423B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF91C21474
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1DA939;
	Wed, 26 Jul 2023 22:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2C1BF13
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D447C433C7;
	Wed, 26 Jul 2023 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690411257;
	bh=X5N9Zh6MaUPHNLMZWdB06S+j7ecYL2GpaqQAENG4zCU=;
	h=From:To:Cc:Subject:Date:From;
	b=n+FvtlLWvBoRsqlUZFRaIrimtUiAcitkWxPsWAPJvfOp3XU1U68l1Oe9oCrYQlI5x
	 lS9q3zutdhTc0cwPb8cNiZqAmFq0zZ7F0d33R/BgnChOwRYSro3jxv86/wrH0kLpcb
	 0JksbXg/MgPO5W1f/t3MmMMzS7wYciRVaOJpsayl3h7Co3rvf/SLpMsPLoQtTflIE8
	 01swp6BF+FNdBeYg5McDjwZ4HqqGxYISVd+xOj2s8Yca1yJpom+LQLYcT+EskpEmRs
	 5/Z9gTPSnX6PuQMgrpj9phKt0uLW23UCckxDYP2uv/OvEZqTJZp+pbimNbXQ3JMv+2
	 hvjRNzkBUKOug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	j.zink@pengutronix.de
Subject: [PATCH net-next] Revert "net: stmmac: correct MAC propagation delay"
Date: Wed, 26 Jul 2023 15:40:54 -0700
Message-ID: <20230726224054.3241127-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 20bf98c94146eb6fe62177817cb32f53e72dd2e8.

Richard raised concerns about correctness of the code on previous
generations of the HW.

Fixes: 20bf98c94146 ("net: stmmac: correct MAC propagation delay")
Link: https://lore.kernel.org/all/ZMGIuKVP7BEotbrn@hoboy.vegasvil.org/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: peppe.cavallaro@st.com
CC: alexandre.torgue@foss.st.com
CC: joabreu@synopsys.com
CC: mcoquelin.stm32@gmail.com
CC: richardcochran@gmail.com
CC: linux@armlinux.org.uk
CC: j.zink@pengutronix.de
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  3 --
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 43 -------------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 --
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  6 ---
 4 files changed, 56 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 40147ef24963..652af8f6e75f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -532,7 +532,6 @@ struct stmmac_hwtimestamp {
 	void (*get_systime) (void __iomem *ioaddr, u64 *systime);
 	void (*get_ptptime)(void __iomem *ioaddr, u64 *ptp_time);
 	void (*timestamp_interrupt)(struct stmmac_priv *priv);
-	void (*correct_latency)(struct stmmac_priv *priv);
 };
 
 #define stmmac_config_hw_tstamping(__priv, __args...) \
@@ -551,8 +550,6 @@ struct stmmac_hwtimestamp {
 	stmmac_do_void_callback(__priv, ptp, get_ptptime, __args)
 #define stmmac_timestamp_interrupt(__priv, __args...) \
 	stmmac_do_void_callback(__priv, ptp, timestamp_interrupt, __args)
-#define stmmac_correct_latency(__priv, __args...) \
-	stmmac_do_void_callback(__priv, ptp, correct_latency, __args)
 
 struct stmmac_tx_queue;
 struct stmmac_rx_queue;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 7e0fa024e0ad..fa2c3ba7e9fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -60,48 +60,6 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 		*ssinc = data;
 }
 
-static void correct_latency(struct stmmac_priv *priv)
-{
-	void __iomem *ioaddr = priv->ptpaddr;
-	u32 reg_tsic, reg_tsicsns;
-	u32 reg_tsec, reg_tsecsns;
-	u64 scaled_ns;
-	u32 val;
-
-	/* MAC-internal ingress latency */
-	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
-
-	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
-	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
-	 */
-	val = readl(ioaddr + PTP_TCR);
-	if (val & PTP_TCR_TSCTRLSSR)
-		/* nanoseconds field is in decimal format with granularity of 1ns/bit */
-		scaled_ns = ((u64)NSEC_PER_SEC << 16) - scaled_ns;
-	else
-		/* nanoseconds field is in binary format with granularity of ~0.466ns/bit */
-		scaled_ns = ((1ULL << 31) << 16) -
-			DIV_U64_ROUND_CLOSEST(scaled_ns * PSEC_PER_NSEC, 466U);
-
-	reg_tsic = scaled_ns >> 16;
-	reg_tsicsns = scaled_ns & 0xff00;
-
-	/* set bit 31 for 2's compliment */
-	reg_tsic |= BIT(31);
-
-	writel(reg_tsic, ioaddr + PTP_TS_INGR_CORR_NS);
-	writel(reg_tsicsns, ioaddr + PTP_TS_INGR_CORR_SNS);
-
-	/* MAC-internal egress latency */
-	scaled_ns = readl(ioaddr + PTP_TS_EGR_LAT);
-
-	reg_tsec = scaled_ns >> 16;
-	reg_tsecsns = scaled_ns & 0xff00;
-
-	writel(reg_tsec, ioaddr + PTP_TS_EGR_CORR_NS);
-	writel(reg_tsecsns, ioaddr + PTP_TS_EGR_CORR_SNS);
-}
-
 static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 {
 	u32 value;
@@ -263,5 +221,4 @@ const struct stmmac_hwtimestamp stmmac_ptp = {
 	.get_systime = get_systime,
 	.get_ptptime = get_ptptime,
 	.timestamp_interrupt = timestamp_interrupt,
-	.correct_latency = correct_latency,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 19e46e8f626a..e1f1c034d325 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -909,8 +909,6 @@ static int stmmac_init_ptp(struct stmmac_priv *priv)
 	priv->hwts_tx_en = 0;
 	priv->hwts_rx_en = 0;
 
-	stmmac_correct_latency(priv, priv);
-
 	return 0;
 }
 
@@ -1096,8 +1094,6 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->dma_cap.fpesel)
 		stmmac_fpe_link_state_handle(priv, true);
-
-	stmmac_correct_latency(priv, priv);
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index d1fe4b46f162..bf619295d079 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -26,12 +26,6 @@
 #define	PTP_ACR		0x40	/* Auxiliary Control Reg */
 #define	PTP_ATNR	0x48	/* Auxiliary Timestamp - Nanoseconds Reg */
 #define	PTP_ATSR	0x4c	/* Auxiliary Timestamp - Seconds Reg */
-#define	PTP_TS_INGR_CORR_NS	0x58	/* Ingress timestamp correction nanoseconds */
-#define	PTP_TS_EGR_CORR_NS	0x5C	/* Egress timestamp correction nanoseconds*/
-#define	PTP_TS_INGR_CORR_SNS	0x60	/* Ingress timestamp correction subnanoseconds */
-#define	PTP_TS_EGR_CORR_SNS	0x64	/* Egress timestamp correction subnanoseconds */
-#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
-#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
 
 #define	PTP_STNSUR_ADDSUB_SHIFT	31
 #define	PTP_DIGITAL_ROLLOVER_MODE	0x3B9ACA00	/* 10e9-1 ns */
-- 
2.41.0


