Return-Path: <netdev+bounces-176736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DEA6BC19
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F493B80F4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4E1482F5;
	Fri, 21 Mar 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxY12khI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4fG0ik5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2C142659
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565181; cv=none; b=tr+fcpHE/tuhEGJFXW/kblrzqH2SQJliEHaJbr3fD3AIJ/0fiv6gd408zRiLK96/GX/y2WGCNzH0b8/r8GZuaqxXZGcozPRwvRIFpAYViCWwQolPalvGYxGh+axb4xjCAE2IFGr/YxZ+4XrZmFPREewipqesrOg4D8Ct9YUhrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565181; c=relaxed/simple;
	bh=OBqa7ZPlM/9BNeSZs0Zqe0m3DXXtZrpZd939GnwK/QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDn4c8wFMMt7c6qDz3+WfTaCoAU5WHZsM+lijWDbN/hppmNAmvSXON1leq7inV949Ypxs4aS/jDHR6Mel5geHNc+phvsbKG+IZ45b5IW2fjR/Tp9QgFKRBN3yL7p4fSfjeywU3GIs3y7JE1Q1uWK5xCURnWRYsADDnYpxZw4o+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxY12khI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4fG0ik5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742565177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m95qou3jMu2nip29BsHc7wsZbSBUImNGgt+uAyGTygs=;
	b=CxY12khI6Xy7J7amlSM3+k7ZAWdQpmfU+uQ7uhVG+TSOnx67TpgzaIOEBJSUf0AaQE9i+4
	mKFhrH/11IvmpvLbXQCKB0HhvYwAS3mhuVdH9OlQnCfwf2qGizIEVU59fgfIdbLOJ4o5zT
	OgYLvoi235E87B1N3idNNinWXS4MlFXnhvxliUdKBICjQSj2bn0LM33vIBk+In8QrYwYQI
	J6U8Q/cciHQHA3/GH1RygNP0gkSdHQAkD3dVot72q66/DY0OczF8/O6Lj8HavSlOIglPlA
	0++B25zR4FzcoZ9haKs2zxvpvy0RPq45D/TaMdqP7SCiqOqFiUOLOmc6MmEZiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742565177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m95qou3jMu2nip29BsHc7wsZbSBUImNGgt+uAyGTygs=;
	b=w4fG0ik5+tDhnv6lygvDwegPVjeAhQFvxPeSgaLJYvnAZXe0bDA62V/xprZg59BG71HN2O
	piNcvnjJYBLS0mCg==
Date: Fri, 21 Mar 2025 14:52:39 +0100
Subject: [PATCH iwl-next v4 2/2] igc: Change Tx mode for MQPRIO offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-igc_mqprio_tx_mode-v4-2-4571abb6714e@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=OBqa7ZPlM/9BNeSZs0Zqe0m3DXXtZrpZd939GnwK/QQ=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn3W82/KlIPAPJHGWdcOkqyLJjtq993YhXzz5ZG
 nSbMu7P49WJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ91vNgAKCRDBk9HyqkZz
 grZDEACT2LUVLVxbWnhyGeY9O5vlbJr48vsEpn7vkB37UQA6Ka1KFXFtCeAUzKp2XC8W3GEM37D
 DdZKryiL6WY8leQITIKnGBDXbbeQrfVsANl9+WWitn6WH3af/+H7oCDa4pQFm2O9nnNa7Wegiql
 TSX6e8XJHIgeX4iAQ/8PBOVpEcpgmv2Da5jQwsaBf4r5ZTu1Ji7a5Tt173eFOPKgZYQEzYlIGED
 zmPh/DSVNpixmlMXy3jqbP+S4Afhh9ug+J3loaSP2zkuTPjJM/m/3sNeMMlWSFwosg9W2GPr/3O
 qrZzDM9bkCP5jhVnQqHzbI/bvHqyx2WuWERYZ7/WsgtiBZsDk9Z9LsjPRb+BFZdLXPhdTVVvdny
 fQ5tZnmMu8/kuQpd84sdk/cquThaEniwOaxhV+NX9AGyUQpVGwD1bXwdDuB5azHkIZjLti84U/V
 dR4d5Q8EEJ2EIHnv4Eq0xTMsP+PT5kNQS8XeRLzR3RpNYmQaOssX9F4uMGWHG/Lo44zF3xyxHt3
 P9vlv5k3hHxHp73x3iXeuS/OO2erDQzkg7fUFgPLE/xDdNvx2oLDAYZtvdE0mI3iHzqwrD1nB/F
 9NOGZQ3DjyGaF2YszZwqFqOf5EQx4D5Op4OEqW7pugHW4Xl66SICnj3NXdMNN4/zwWXCk4sAiIP
 P1a8eYj1jcQGc0g==
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

Tested on i225 with real time application using high priority queue, iperf3
using low priority queue and network TAP device.

Acked-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc.h     |  4 +---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 20 ++------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 67632356083708f82a099141a4b68ba10e06f952..7c28f3e7bb576f0e6a21c883e934ede4d53096f4 100644
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
 
@@ -163,7 +158,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	igc_tsn_tx_arb(adapter, queue_per_tc);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
-	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
 
 	return 0;
 }
@@ -207,16 +201,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
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

-- 
2.39.5


