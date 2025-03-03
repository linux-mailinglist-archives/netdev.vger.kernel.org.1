Return-Path: <netdev+bounces-171136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAAEA4BA95
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BE73A2F94
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297B13C8E8;
	Mon,  3 Mar 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQdnsN5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WmU2kn8/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8DAD27
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993401; cv=none; b=HXrTRnbi0Km5FEDKSij91EdF9mJeZSb/V6yw6gyWGVP7ntl+rVnXwW7x/98DMzelb5KcfG2Q1KotFA1c3i709Fa8sqjxHyfVu/obigbMVY3W9/hbLuUPziN0WgYJ4wiipn6j/Za/3W+MreO4WNfzCWE6DK0OtPik1011pGgVAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993401; c=relaxed/simple;
	bh=MzG4TVyqEvi5DpomSdXvymJ+WUsTmJ2767VVOpacfak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L8x4y+8zYW6tlVL9SRnNKHiFUQUWxBlVqeHBCH6dclFaq6MjBL30gvkg3UxrRyPiAHWN5AfQ1TsgFh2oWxHVLOH+vnxHkLaSfDSNnkTtHJCJeBH8AqudUaLVTrs7VA54hg8NmaxwAg/zeb7JLQ/uCoamqPYN5cjdEjoG/c2ykN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQdnsN5l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WmU2kn8/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740993397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V3a4PQvEXtf/n2HdsMoHR3koOcbaIiH0hs2oHGcy8a0=;
	b=PQdnsN5ll9x6j+7wvr7DnkpVNAiX5CI1YOsdg/V6Qn9LM+vxk1haM976Cn9J4e9kzAjVRk
	2v26AIaORDLK6qpNq9vaS0ht0hY/gHtR+Lm+cFUbqyyhfOMCL5LHmrIpDKwbpUklEgFgWp
	M1DL/IZH90H2ZaP+YgxIU9hKGhb9BbQGeZnW1EnF/KCZdy1ktwW6nMRLqOspqKyiSEmYvt
	zhAEoUH2belyDeuk+fV/A/h+KQFWIdgS9e3+8LPEh2Qcxkr48PgvgDDFSk1S1e9QfPxWXE
	EHmYk72eAk14QhORN82PaEyTln+6X2laG+E14BwHdjlU9+U56Xa/m6m4cVAwSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740993397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V3a4PQvEXtf/n2HdsMoHR3koOcbaIiH0hs2oHGcy8a0=;
	b=WmU2kn8/R1P6KURdvJPe4gKC3K+F8Gt7ZDEO8JfKu86z/F7aytnwmEeWx8JO10bcRgynMg
	ggahrp0YQdemeIAw==
Date: Mon, 03 Mar 2025 10:16:33 +0100
Subject: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHBzxWcC/23OQQqDMBAF0KtI1k0xo6a2q96jFJFk1AFNbGJTi
 3j3BumiFJefz7w/C/PoCD27JAtzGMiTNTFkh4SprjYtctIxM0ihSEHknFpVDY/Rka2muRqsRg6
 gxFkVMpdpweLh6LCheUNvjF49NzhP7B6bjvxk3XtbC2Lrv/BpDw6CC57VeQoNiiYDee3JPCdnD
 c1HjRsZ4IeB3f8CROYspdS1yFSpy39mXdcPjWSEZwkBAAA=
X-Change-ID: 20250214-igc_mqprio_tx_mode-22c19c564605
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6330; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=MzG4TVyqEvi5DpomSdXvymJ+WUsTmJ2767VVOpacfak=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnxXN08vYUifSOOyvLlWTv3gAI4dtC7rCxXwnGj
 G94G+O6bBaJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ8VzdAAKCRDBk9HyqkZz
 grjGD/sF9OIyM4/jlt36wsy7EoWjRdtFwy0cCtQRFqY6IZS+aMBjQRZXTWjfuV/ZABUfqvb2lhN
 EPgUR77xh7YGKSHsEtkZuVY7Uo7sXf/8yLukq9RhduFwbrdXy1zW0EoCxobmDy0Lq7CCCINDtHO
 6FbAjVc5BakoLZ1Z39X5fXqq2+STrt7YQwuEtaoYjw1ltpRMbgjZEYwpGAdaWUHfXpFwAs/LdKV
 U3n5DX0AWffxwuerhJDN/24mDfpOfE0Yop72fPhYfmjyC/0RiVaJnOX0Kj/gDstN56NlBeIX1+v
 BRndlCzDKQHlQFQ1XJsoLFiZZBNVnhafmyirQWmXqpkGq3pj51QLACWBh4a4Z9HThGmYYcADBcD
 jJBZeQy2QcER9YIs410W//9ny07q7A3Fv3XZ2lvOZMU6TzUggr0KiCwveZdXMX2GDxwFVnbPIVV
 6kElLLhKFONuA6C01Duv3x+4XfX6o/upZsLcg3cv+JEH4m3g+uJH5Kx7sfRcaTSjmuOKlEhiovw
 K5FR56tDLvuVnVDY7k99BZovBG3eQ0Da71ClDzANrV6aa8W/j8toGyeHJwBgVekhAp+6UfkVjzj
 pJRjpd/W563F5w8A9A84YeXtNis1aHxMDYbQeZC7Synke7RNcSqJhO+cwViDqbZ+tliShUHAxsp
 UdyynTTnKT/CMag==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
this mode the hardware uses four packet buffers and considers queue
priorities.

In order to harmonize the TAPRIO implementation with MQPRIO, switch to the
regular TSN Tx mode. This mode also uses four packet buffers and considers
queue priorities. In addition to the legacy mode, transmission is always
coupled to Qbv. The driver already has mechanisms to use a dummy schedule
of 1 second with all gates open for ETF. Simply use this for MQPRIO too.

This reduces code and makes it easier to add support for frame preemption
later.

While at it limit the netdev_tc calls to MQPRIO only.

Tested on i225 with real time application using high priority queue, iperf3
using low priority queue and network TAP device.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Commit message (Paul)
- Link to v2: https://lore.kernel.org/r/20250224-igc_mqprio_tx_mode-v2-1-9666da13c8d8@linutronix.de

Changes in v2:
- Add comma to commit message (Faizal)
- Simplify if condition (Faizal)
- Link to v1: https://lore.kernel.org/r/20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de
---
 drivers/net/ethernet/intel/igc/igc.h      |  4 +---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 40 ++-----------------------------
 3 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cd1d7b6c1782352094f6867a31b6958c929bbbf4..16d85bdf55a7e9c412c47acf727bca6bc7154c61 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -388,11 +388,9 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RX_LEGACY		BIT(16)
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
-#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
 
 #define IGC_FLAG_TSN_ANY_ENABLED				\
-	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
-	 IGC_FLAG_TSN_LEGACY_ENABLED)
+	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)
 
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 472f009630c98e60c7166ceb8d05cb094f6c837b..240b6075197fb1e61077a736ddf8f9e67c1ed5cd 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6679,13 +6679,14 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 				 struct tc_mqprio_qopt_offload *mqprio)
 {
 	struct igc_hw *hw = &adapter->hw;
-	int i;
+	int err, i;
 
 	if (hw->mac.type != igc_i225)
 		return -EOPNOTSUPP;
 
 	if (!mqprio->qopt.num_tc) {
 		adapter->strict_priority_enable = false;
+		netdev_reset_tc(adapter->netdev);
 		goto apply;
 	}
 
@@ -6716,6 +6717,21 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
 			       mqprio->qopt.offset);
 
+	err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
+	if (err)
+		return err;
+
+	for (i = 0; i < adapter->num_tc; i++) {
+		err = netdev_set_tc_queue(adapter->netdev, i, 1,
+					  adapter->queue_per_tc[i]);
+		if (err)
+			return err;
+	}
+
+	/* In case the card is configured with less than four queues. */
+	for (; i < IGC_MAX_TX_QUEUES; i++)
+		adapter->queue_per_tc[i] = i;
+
 	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 
 apply:
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 1e44374ca1ffbb86e9893266c590f318984ef574..7c28f3e7bb576f0e6a21c883e934ede4d53096f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -37,18 +37,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 {
 	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
 
-	if (adapter->taprio_offload_enable)
-		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
-
-	if (is_any_launchtime(adapter))
+	if (adapter->taprio_offload_enable || is_any_launchtime(adapter) ||
+	    adapter->strict_priority_enable)
 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
 
 	if (is_cbs_enabled(adapter))
 		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
 
-	if (adapter->strict_priority_enable)
-		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
-
 	return new_flags;
 }
 
@@ -157,16 +152,12 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_QBVCYCLET_S, 0);
 	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
 
-	/* Reset mqprio TC configuration. */
-	netdev_reset_tc(adapter->netdev);
-
 	/* Restore the default Tx arbitration: Priority 0 has the highest
 	 * priority and is assigned to queue 0 and so on and so forth.
 	 */
 	igc_tsn_tx_arb(adapter, queue_per_tc);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
-	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
 
 	return 0;
 }
@@ -206,37 +197,10 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
 	if (adapter->strict_priority_enable) {
-		int err;
-
-		err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
-		if (err)
-			return err;
-
-		for (i = 0; i < adapter->num_tc; i++) {
-			err = netdev_set_tc_queue(adapter->netdev, i, 1,
-						  adapter->queue_per_tc[i]);
-			if (err)
-				return err;
-		}
-
-		/* In case the card is configured with less than four queues. */
-		for (; i < IGC_MAX_TX_QUEUES; i++)
-			adapter->queue_per_tc[i] = i;
-
 		/* Configure queue priorities according to the user provided
 		 * mapping.
 		 */
 		igc_tsn_tx_arb(adapter, adapter->queue_per_tc);
-
-		/* Enable legacy TSN mode which will do strict priority without
-		 * any other TSN features.
-		 */
-		tqavctrl = rd32(IGC_TQAVCTRL);
-		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN;
-		tqavctrl &= ~IGC_TQAVCTRL_ENHANCED_QAV;
-		wr32(IGC_TQAVCTRL, tqavctrl);
-
-		return 0;
 	}
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {

---
base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
change-id: 20250214-igc_mqprio_tx_mode-22c19c564605

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


