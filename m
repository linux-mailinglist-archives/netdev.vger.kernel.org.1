Return-Path: <netdev+bounces-213991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D7B27970
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA16587754
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9D29ACC4;
	Fri, 15 Aug 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0kJuxRY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVUrrkhS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2B1B960
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240631; cv=none; b=A0PIAM1QSjQ0vyXVgcx0Ukla1B64aVX3rJQhJyZNVgbQ0ExaA/JqWZD/q4oNLqRUda+UbD6Myr8uFs39nNLZRBBkAw5bJgo/tApsJ0khlE40ZFyShXDxnvFy1tMvjodrV5/oBuaYKsW4OXhac2RULFkmzbc2v5ExQ6CqH5QfQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240631; c=relaxed/simple;
	bh=PrXEDS8/uzHwEwvl6/Kj6kFWZuRN2rZ1nmcvxjkyAS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AZ1lJfW0JcCjcGeq9jRUofktqM0iJgFRGMh6j3HMue9Ax/cwPMm0PFqw3o442FFqoNTUgiCBLAc399XRS0aVQSTvB7GlwAdLEibwoYKSdthKb7dkff1bEtYJVIMxIntFW1FxO5k0suOtpvRoMCWh4+cnem53GPHpAm1p79b78GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0kJuxRY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVUrrkhS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755240628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bhQDFyx2xxyQ3AyFhlkoYWUtlYkBhR8TmVhgjGJjp7c=;
	b=b0kJuxRY0YhUOubtxda/FqjTO6uqK0ekjvNh3u6qlLY10ovnMgmJMh0+PBCvnIS4ePSGVv
	2HZ8xNqaIXkhTwnh/Z0iC1HMJ4XorUZnrlKpFW3Yg38ZgtjGGSbtJd9+JCuZXUZ41cuwzO
	pleM9jxglEwoGtHKbAZJAtSIy/qM6UTRLwx+L4oM0ojJdtRDWATLrmG8h5hldOzqX1I52z
	h9AhbJ+KSmIcqd9pC1TT0iiyPeeBLOtcCJ56sbCVPqkmXG3UXRv0zx6WSwF5zfRT6d/50q
	ZbxNfu8iNteSyJETUJSurswiYmJbzzT2CUJ8vULi7cw+P2pZ+004NP0TPIksSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755240628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bhQDFyx2xxyQ3AyFhlkoYWUtlYkBhR8TmVhgjGJjp7c=;
	b=vVUrrkhSXmzI3QlO18q8wsnf78cBP8SROKK6e044MJRTCFa29PNkAMTXfEJRSY+a7ZvZUK
	pO0WzgGkJuwfv+BA==
Date: Fri, 15 Aug 2025 08:50:23 +0200
Subject: [PATCH iwl-next] igb: Retrieve Tx timestamp directly from
 interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAK/YnmgC/x3MTQqAIBBA4avErBOyH4yuEhFqkw2ElUYJ4t2Tl
 t/ivQgeHaGHoYjg8CFPh83gZQF6k9YgoyUb6qruqp43jIyayV3z7RmXUgithWq1ghycDlcK/2w
 EendmMdwwpfQBrn9A42YAAAA=
X-Change-ID: 20250813-igb_irq_ts-1aa77cc7b4cb
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=PrXEDS8/uzHwEwvl6/Kj6kFWZuRN2rZ1nmcvxjkyAS0=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBontizNGyCG8hJljkOeBBFKdsRAme3+H4V4P8eW
 /IAnELpNK6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaJ7YswAKCRDBk9HyqkZz
 gvDlEACBhKBQ1S699lj3HugVb1Xc2cGK6163LVqcK7tEwSkit8xMxQCTgpmZ/7ol1Icw5jX7Vo4
 slzQibc+05LoJJ+FRp1ckSvcE2NxjAwr8NnBijpvgFxG4TNOWldiv1EWZtD+tMApVwfkknAXk2V
 75wL2JSU1sUmu2ByZLkQojbfk6wUbn4wuFCUB6ZwnoRZtugshtPYfs5IXpO/+VTniVZBq/x8FAv
 nEH625hTXtPVr/ac0T65ignYuEb7dEjfTL42N+wttUQhgCmyC0Bsa5lKN+SMU698lm3i7Gk513B
 Ko2k3nOKSGnqGYwO9UkUyU0L3pqNgdZlzV0CCDbZFSm7SBn7xWxu2MYa/kOlelVlZ12dRZd3JBm
 VRJ94Zc0jiVegcv+vmyocPp+bIR/EVvSYRVc1K9yDPVvemRdtlh6boF0sk2USM7at6/TP/WLnbm
 v2xIvzs+5xVYgZPZtXGoNB3U2ZezfziiJw0a14GwosIOqTGXB3EO7+kspv4L0L1B9NOXdoQZY3p
 kambLFk1v13slaakeOYtgSsEHFS6vVCwDopCENc4ndQo8Srm4aJtyQnHOgMTUdF3cWqXso3gvWy
 iOrLOxMVVYAJgfOJvIDFnRp7tVr7w6jc5RUSIRJ4xotNWCX9vsPUElWdHUNKgiwJ7Y1w3W1K/m0
 iV1Hcs/gu4kRkfA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Retrieve Tx timestamp directly from interrupt handler.

The current implementation uses schedule_work() which is executed by the
system work queue to retrieve Tx timestamps. This increases latency and can
lead to timeouts in case of heavy system load.

Therefore, fetch the timestamp directly from the interrupt handler.

The work queue code stays for the Intel 82576. Tested on Intel i210.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c3f4f7cd264e9b2ff70f03b580f95b15b528028c..102ca32e8979fa3203fc2ea36eac456f1943cfca 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -776,6 +776,7 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
 int igb_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack);
+void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter);
 void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
 unsigned int igb_get_max_rss_queues(struct igb_adapter *);
 #ifdef CONFIG_IGB_HWMON
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae61e93aa737b0103e00580e73601d62b..8ab6e52cb839bbb698007a74462798faaaab0071 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7080,7 +7080,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		igb_ptp_tx_tstamp_event(adapter);
 	}
 
 	if (tsicr & TSINTR_TT0)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index a7876882aeaf2b2a7fb9ec6ff5c83d8a1b06008a..20ecafecc60557353f8cc5ab505030246687c8e4 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 	return 0;
 }
 
+/**
+ * igb_ptp_tx_tstamp_event
+ * @adapter: pointer to igb adapter
+ *
+ * This function checks the TSYNCTXCTL valid bit and stores the Tx hardware
+ * timestamp at the current skb.
+ **/
+void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 tsynctxctl;
+
+	if (!adapter->ptp_tx_skb)
+		return;
+
+	tsynctxctl = rd32(E1000_TSYNCTXCTL);
+	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
+		return;
+
+	igb_ptp_tx_hwtstamp(adapter);
+}
+
 /**
  * igb_ptp_tx_work
  * @work: pointer to work struct

---
base-commit: 88250d40ed59d2b3c2dff788e9065caa7eb4dba0
change-id: 20250813-igb_irq_ts-1aa77cc7b4cb

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


