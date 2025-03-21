Return-Path: <netdev+bounces-176735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9EA6BC18
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FEF3B71A8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D087DA6D;
	Fri, 21 Mar 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVMYUaG7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytO7aKlW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050880034
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565180; cv=none; b=tsSTZY/kzIRA6hfcdRwl5rYz0vTV5ILfTHJXi4PoT9oozszn0r2RuTChKk+XrGQNF+unPzVrlxoPUr7fFA7Q1nGd7WB90MvGWQik1/11p1d2DlPLxJK+72pkafwosdf4rgCzjKoHPq4/3cN4ztKwSeBFClJe9HWK99gvdl3vCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565180; c=relaxed/simple;
	bh=Mi0rryupyIg+Ek+caxe+dUWD65hl0wPxeJInFp2E39g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGIMtozLCL6fWyiidw0aRMjrQNC0bv/1ASR7RfBUL6134Gfq6PMibe8SDJeC+ESqyzD5N/wVlTHmAgWASmxFSDH569KQKdysxjiImuvgdW+14N1R7T5gTeOwnPNJlD0YSz4Z2cZ7QQppnzCdmhY1azhZVvNqJPhKTrhsZzr+jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVMYUaG7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytO7aKlW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742565176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwLPL7+wu7qtFoyl7UjkKjJVR4f77AtlojDOBKhpHg=;
	b=MVMYUaG7ovDtLDQVdBOkLxmQs6nw2NOg0Qt9xOnxOv4Jo97AomPHNAQJmM7mIpq5KOGHTv
	1MEW+JfjV2Lw0cdzXFE6O0Br7K7BjlUTiu2EgWiuQWIDZnvuiTl+CSiEyEC6K2jDpY5QVn
	l8PpE3PuYUe54Hn6YaHM3MPG7T2bnUYGrqCCpAUavwhK5VOoStsFZRCt9XVKG795LhUt1C
	9iOp6kakojG7+BhGS2t/zbw2LvLkDV+sisBGF4im+fY4kLwRFaqqLg7RR6jSnovjkQZ+6k
	dAE1nDulGluvr8N2O42d6Qg1ynfEdpOgAOciQteG6fBEdqG7+bwkbFyXm6/hkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742565176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwLPL7+wu7qtFoyl7UjkKjJVR4f77AtlojDOBKhpHg=;
	b=ytO7aKlWvkQoPeidzKNNyLIsmTUJk7Mqkd1UvmjQm35OAhUFl6j4IZ0w3ejsHvgsu5k3Ju
	PNrC3Ny3U8WT5uDQ==
Date: Fri, 21 Mar 2025 14:52:38 +0100
Subject: [PATCH iwl-next v4 1/2] igc: Limit netdev_tc calls to MQPRIO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-igc_mqprio_tx_mode-v4-1-4571abb6714e@linutronix.de>
References: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
In-Reply-To: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3188; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=Mi0rryupyIg+Ek+caxe+dUWD65hl0wPxeJInFp2E39g=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn3W82Srb2yvsW2qVbZOXOh6fo+xxGhME4zlDjR
 9XngiFbbNWJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ91vNgAKCRDBk9HyqkZz
 ggu1D/9F4USsSAQ4W9TYb88+dOw+NcpCv9xfJqWTNn23HrfKg2eEDDp6KO05Akk9HdHYc1kNbVG
 pp6l8Q4klOpVZgrV9j2fjzsj9YtqSBP0o/IkqaiQNeg2QRVxFO/oGi9c/eQChlTgunhvCRS40jZ
 /Q2Z2+deBJfqBRko/isuSnpYgcc0Sa0MBwT2TuF62Yq7siUzJVm4ErnrCqIldw+61kTMmFEYiar
 YOa08EzJQdqStEllm89SWoHCOvVE9cWA19RdbwTKX1dBaiaajYnZu7BpZNleVXlF4sksI1+7k8s
 h6dRsa29AHuG7HGez6PUcvLz3T2ICojPmtTDHb6Q1OP3xg+v34/XUSFPlgJHi3vLx8pyDBTk7Xy
 z4nlGtv0FX40KR0JqGKAJsjntUr6PzDgzPFjysBD2j0wKZ6eG75XSkOOyjSFkwu2ods0PzBI9m5
 iXJwMN14Ng1s72Zw6Lwy5j4KQoFOnq58CqYHwE0RQdjrNZlZTpNx9g+BiP3r48eBePyPISeVVaT
 wgqgwv50S2JtX0OTJvJcWzQWYvnwaNf3/sBPrF/u7JU1l6HXfHtbzHYg3LGPY/jEqnOnWYFuqpE
 Myy4NwvGbRTSoYk0eOq6WFIcx6P2y+92Sta6UCFouw3TGKVeHWa65oYn3kuHE9+lMIX4QS8pWMd
 3Wer0UIKri9qzBQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Limit netdev_tc calls to MQPRIO. Currently these calls are made in
igc_tsn_enable_offload() and igc_tsn_disable_offload() which are used by
TAPRIO and ETF as well. However, these are only required for MQPRIO.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 20 --------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

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
index 1e44374ca1ffbb86e9893266c590f318984ef574..67632356083708f82a099141a4b68ba10e06f952 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -157,9 +157,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_QBVCYCLET_S, 0);
 	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
 
-	/* Reset mqprio TC configuration. */
-	netdev_reset_tc(adapter->netdev);
-
 	/* Restore the default Tx arbitration: Priority 0 has the highest
 	 * priority and is assigned to queue 0 and so on and so forth.
 	 */
@@ -206,23 +203,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
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

-- 
2.39.5


