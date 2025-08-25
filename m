Return-Path: <netdev+bounces-216637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E55B34B6C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0B6241F3A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7902C3274;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CunOHdid"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D272989BC
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152156; cv=none; b=Ao+zcoGIEfNhgxLTDi5nIHjk7Q6fuJ/UB52btcIGF1rr6fAvPM5M/QwkpkpKUfH7nmds+Es9fo7xFtTMt3c8Rn4n+oF+wA7QJTgSRb+fYbcmU1FxvwvPhI8hcJexu7htovWpoZ0F2G6HULSMnOD/6oxukeCgyAdPWEcy0JjNlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152156; c=relaxed/simple;
	bh=GQrx84Z91K28efwrE9jpwSxOwBnsobXPb1cKXl6/ECQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYp62QKpO4gOruymcVgOlNCcceMGYh96+ACRwx4HZyON29XA+8ZqyIlVw8YICOH9BTtwjIm6MOnDcfekdSn1DtiZXjovMwS/hvJTbuF4WTMGxyhs5EBz/3cK+gWq0fyv6KqTQ7dxYXEb+c3/fnct+4WXRVuO15hn0ejW2lyanLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CunOHdid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C369C116B1;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152156;
	bh=GQrx84Z91K28efwrE9jpwSxOwBnsobXPb1cKXl6/ECQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CunOHdidkLJ++LXNlI9NTclTmvz4ET3BiZ9oej0af9u6flZ3jyyGA08qKb46fZzcp
	 nX3V0lQKf7dEVZWfNoHe1Dtcki73n2mAEmVvP4hHgBVg2HdGjICibC4rpQ5Elleqn8
	 NwLb1ezRzgvnvgw1ZFbwQ4P6685/5KnTYX55MTAKJFP0nRka7bd2DIUJ+GMcXYqfLA
	 90dDMdIadgayfp1AlqoLBjWCVIPqVNfeUQQAflb8ujsAdK5Ah0zX1kjjC2o9Y27Akc
	 xh3zmKSMkpeaYXb/UrNI9F46fsGdMx4H+6WeHMvmWUg24PLSY7+cXbQaaIEqLDQmyM
	 MNhJqgVdlo6/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/6] eth: fbnic: Fetch PHY stats from device
Date: Mon, 25 Aug 2025 13:02:04 -0700
Message-ID: <20250825200206.2357713-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825200206.2357713-1-kuba@kernel.org>
References: <20250825200206.2357713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <mohsin.bashr@gmail.com>

Add support to fetch PHY stats consisting of PCS and FEC stats from the
device. When reading the stats counters, the lo part is read first, which
latches the hi part to ensure consistent reading of the stats counter.

FEC and PCS stats can wrap depending on the access frequency. To prevent
wrapping, fetch these stats periodically under the service task. Also to
maintain consistency fetch these stats along with other 32b stats under
__fbnic_get_hw_stats32().

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 15 ++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 16 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  4 ++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 20 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 46 +++++++++++++++++++
 5 files changed, 101 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index a81db842aa53..69cb73ca8bca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -790,6 +790,21 @@ enum {
 #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
 
 #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+
+/* We have 4 RSFEC engines present in our part, however we are only using 1.
+ * As such only CCW(0) and NCCW(0) will never be non-zero and the other
+ * registers can be ignored.
+ */
+#define FBNIC_RSFEC_CCW_LO(n)	(0x10802 + 8 * (n))	/* 0x42008 + 32*n */
+#define FBNIC_RSFEC_CCW_HI(n)	(0x10803 + 8 * (n))	/* 0x4200c + 32*n */
+#define FBNIC_RSFEC_NCCW_LO(n)	(0x10804 + 8 * (n))	/* 0x42010 + 32*n */
+#define FBNIC_RSFEC_NCCW_HI(n)	(0x10805 + 8 * (n))	/* 0x42014 + 32*n */
+
+#define FBNIC_PCS_MAX_LANES			4
+#define FBNIC_PCS_SYMBLERR_LO(n) \
+				(0x10880 + 2 * (n))	/* 0x42200 + 8*n */
+#define FBNIC_PCS_SYMBLERR_HI(n) \
+				(0x10881 + 2 * (n))	/* 0x42204 + 8*n */
 #define FBNIC_CSR_END_RSFEC		0x108c8 /* CSR section delimiter */
 
 /* MAC MAC registers (ASIC only) */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 2fc25074a5e6..baffae1868a6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -23,6 +23,16 @@ struct fbnic_hw_stat {
 	struct fbnic_stat_counter bytes;
 };
 
+struct fbnic_fec_stats {
+	struct fbnic_stat_counter corrected_blocks, uncorrectable_blocks;
+};
+
+struct fbnic_pcs_stats {
+	struct {
+		struct fbnic_stat_counter lanes[FBNIC_PCS_MAX_LANES];
+	} SymbolErrorDuringCarrier;
+};
+
 /* Note: not updated by fbnic_get_hw_stats() */
 struct fbnic_eth_ctrl_stats {
 	struct fbnic_stat_counter MACControlFramesTransmitted;
@@ -56,6 +66,11 @@ struct fbnic_eth_mac_stats {
 	struct fbnic_stat_counter FrameTooLongErrors;
 };
 
+struct fbnic_phy_stats {
+	struct fbnic_fec_stats fec;
+	struct fbnic_pcs_stats pcs;
+};
+
 struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
 	struct fbnic_eth_ctrl_stats eth_ctrl;
@@ -116,6 +131,7 @@ struct fbnic_pcie_stats {
 };
 
 struct fbnic_hw_stats {
+	struct fbnic_phy_stats phy;
 	struct fbnic_mac_stats mac;
 	struct fbnic_tmi_stats tmi;
 	struct fbnic_tti_stats tti;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 86fa06da2b3e..92dd6efb920a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -79,6 +79,10 @@ struct fbnic_mac {
 	bool (*pcs_get_link)(struct fbnic_dev *fbd);
 	int (*pcs_get_link_event)(struct fbnic_dev *fbd);
 
+	void (*get_fec_stats)(struct fbnic_dev *fbd, bool reset,
+			      struct fbnic_fec_stats *fec_stats);
+	void (*get_pcs_stats)(struct fbnic_dev *fbd, bool reset,
+			      struct fbnic_pcs_stats *pcs_stats);
 	void (*get_eth_mac_stats)(struct fbnic_dev *fbd, bool reset,
 				  struct fbnic_eth_mac_stats *mac_stats);
 	void (*get_eth_ctrl_stats)(struct fbnic_dev *fbd, bool reset,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 8aa9a0e286bb..9e7becba7386 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -512,6 +512,24 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 			   &pcie->ob_rd_no_np_cred);
 }
 
+static void fbnic_reset_phy_stats(struct fbnic_dev *fbd,
+				  struct fbnic_phy_stats *phy_stats)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+
+	mac->get_fec_stats(fbd, true, &phy_stats->fec);
+	mac->get_pcs_stats(fbd, true, &phy_stats->pcs);
+}
+
+static void fbnic_get_phy_stats32(struct fbnic_dev *fbd,
+				  struct fbnic_phy_stats *phy_stats)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+
+	mac->get_fec_stats(fbd, false, &phy_stats->fec);
+	mac->get_pcs_stats(fbd, false, &phy_stats->pcs);
+}
+
 static void fbnic_reset_hw_mac_stats(struct fbnic_dev *fbd,
 				     struct fbnic_mac_stats *mac_stats)
 {
@@ -525,6 +543,7 @@ static void fbnic_reset_hw_mac_stats(struct fbnic_dev *fbd,
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats.lock);
+	fbnic_reset_phy_stats(fbd, &fbd->hw_stats.phy);
 	fbnic_reset_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_reset_tti_stats(fbd, &fbd->hw_stats.tti);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
@@ -553,6 +572,7 @@ void fbnic_init_hw_stats(struct fbnic_dev *fbd)
 
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
+	fbnic_get_phy_stats32(fbd, &fbd->hw_stats.phy);
 	fbnic_get_tmi_stats32(fbd, &fbd->hw_stats.tmi);
 	fbnic_get_tti_stats32(fbd, &fbd->hw_stats.tti);
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index fd8d67f9048e..ffdaebd4002a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -631,6 +631,50 @@ static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
 	wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
 }
 
+static void
+fbnic_pcs_rsfec_stat_rd32(struct fbnic_dev *fbd, u32 reg, bool reset,
+			  struct fbnic_stat_counter *stat)
+{
+	u32 pcs_rsfec_stat;
+
+	/* The PCS/RFSEC registers are only 16b wide each. So what we will
+	 * have after the 64b read is 0x0000xxxx0000xxxx. To make it usable
+	 * as a full stat we will shift the upper bits into the lower set of
+	 * 0s and then mask off the math at 32b.
+	 *
+	 * Read ordering must be lower reg followed by upper reg.
+	 */
+	pcs_rsfec_stat = rd32(fbd, reg) & 0xffff;
+	pcs_rsfec_stat |= rd32(fbd, reg + 1) << 16;
+
+	/* RFSEC registers clear themselves upon being read so there is no
+	 * need to store the old_reg_value.
+	 */
+	if (!reset)
+		stat->value += pcs_rsfec_stat;
+}
+
+static void
+fbnic_mac_get_fec_stats(struct fbnic_dev *fbd, bool reset,
+			struct fbnic_fec_stats *s)
+{
+	fbnic_pcs_rsfec_stat_rd32(fbd, FBNIC_RSFEC_CCW_LO(0), reset,
+				  &s->corrected_blocks);
+	fbnic_pcs_rsfec_stat_rd32(fbd, FBNIC_RSFEC_NCCW_LO(0), reset,
+				  &s->uncorrectable_blocks);
+}
+
+static void
+fbnic_mac_get_pcs_stats(struct fbnic_dev *fbd, bool reset,
+			struct fbnic_pcs_stats *s)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_PCS_MAX_LANES; i++)
+		fbnic_pcs_rsfec_stat_rd32(fbd, FBNIC_PCS_SYMBLERR_LO(i), reset,
+					  &s->SymbolErrorDuringCarrier.lanes[i]);
+}
+
 static void
 fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    struct fbnic_eth_mac_stats *mac_stats)
@@ -809,6 +853,8 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.pcs_disable = fbnic_pcs_disable_asic,
 	.pcs_get_link = fbnic_pcs_get_link_asic,
 	.pcs_get_link_event = fbnic_pcs_get_link_event_asic,
+	.get_fec_stats = fbnic_mac_get_fec_stats,
+	.get_pcs_stats = fbnic_mac_get_pcs_stats,
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
 	.get_eth_ctrl_stats = fbnic_mac_get_eth_ctrl_stats,
 	.get_rmon_stats = fbnic_mac_get_rmon_stats,
-- 
2.51.0


