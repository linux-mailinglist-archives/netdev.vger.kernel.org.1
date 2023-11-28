Return-Path: <netdev+bounces-51571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6C7FB325
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841801C20C99
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFAD110D;
	Tue, 28 Nov 2023 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4TgOSWo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TODftqr/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCEE183
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:49:12 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701157750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLgjvXOFkIe5TTXLiL99lv7XPJkgX/dWYZFltAdFpg4=;
	b=r4TgOSWoe1/SYPZrhr8fptmme1ehHE+4jF9Vks+zhdhOXjO/OePjHaVEK7P3nh6838wtZd
	L4cZLsfEUdISDsJUbpFRh5ig3QLNh4Gmv0xKsez0senSw+wPg/O2cwfgSxPAIJSMI9Pwru
	kOAXQKb/h4dkLGM60mgEltHkX5i236sPWbQR/JV3dJ1mOOkZNjV9j49RqIgnY0y5Lc2hSM
	kw8J1km1i4mW8/6xFDT8SwZf2jyuPSCYGF5Yk99PEwBNcIugWpT3I0IV35Y2Df2GFV+bjw
	uT1jGhMKLvwclRXnWlUyIhQLcVbvo2RirNttWXory7mI2NxwxhP67Ox1xpU0Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701157750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLgjvXOFkIe5TTXLiL99lv7XPJkgX/dWYZFltAdFpg4=;
	b=TODftqr/AMnOKXH1Nry0Ztdwm+ERUDrAJ0/I8F3kJQjHuY57gm2dNbd7QaX5VymaNCeEu/
	nnEz4m/rfRme08DQ==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 2/5] igc: Use netdev printing functions for flex filters
Date: Tue, 28 Nov 2023 08:48:46 +0100
Message-Id: <20231128074849.16863-3-kurt@linutronix.de>
In-Reply-To: <20231128074849.16863-1-kurt@linutronix.de>
References: <20231128074849.16863-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All igc filter implementations use netdev_*() printing functions except for the
flex filters. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d4150542a5c5..4c562df0527d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3385,7 +3385,7 @@ static int igc_flex_filter_select(struct igc_adapter *adapter,
 	u32 fhftsl;
 
 	if (input->index >= MAX_FLEX_FILTER) {
-		dev_err(&adapter->pdev->dev, "Wrong Flex Filter index selected!\n");
+		netdev_err(adapter->netdev, "Wrong Flex Filter index selected!\n");
 		return -EINVAL;
 	}
 
@@ -3420,7 +3420,6 @@ static int igc_flex_filter_select(struct igc_adapter *adapter,
 static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 				    struct igc_flex_filter *input)
 {
-	struct device *dev = &adapter->pdev->dev;
 	struct igc_hw *hw = &adapter->hw;
 	u8 *data = input->data;
 	u8 *mask = input->mask;
@@ -3434,7 +3433,7 @@ static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 	 * out early to avoid surprises later.
 	 */
 	if (input->length % 8 != 0) {
-		dev_err(dev, "The length of a flex filter has to be 8 byte aligned!\n");
+		netdev_err(adapter->netdev, "The length of a flex filter has to be 8 byte aligned!\n");
 		return -EINVAL;
 	}
 
@@ -3504,8 +3503,8 @@ static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 	}
 	wr32(IGC_WUFC, wufc);
 
-	dev_dbg(&adapter->pdev->dev, "Added flex filter %u to HW.\n",
-		input->index);
+	netdev_dbg(adapter->netdev, "Added flex filter %u to HW.\n",
+		   input->index);
 
 	return 0;
 }
-- 
2.39.2


