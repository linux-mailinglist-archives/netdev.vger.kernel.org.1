Return-Path: <netdev+bounces-65386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4564D83A4A8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE81283E38
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490717C77;
	Wed, 24 Jan 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SODs8+U1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnwoQDZF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888717BB6
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086567; cv=none; b=lIhkdIKxDP2FZcco4ToUemarTAR6gbNUr/g+uIB9/zOIpHDe9GDKWR6C8Dir7D/J7b5INrd2L5sNPTmBOwV5HvYGyhBEFY3ICUMAAqlPgrcbBcVJM8pAmprMuBFtCMyo3PVIMkpjJRkS3JVRNpY6m3hAyVu83FS+sBwqS1cZg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086567; c=relaxed/simple;
	bh=IOdKibBQ+8O2RWmV4910fyuP4GcLrceVx6ah6XzDV2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6lxPrgls/LNoI1hdXJHS+oC6RmmucQ3U/ySo5Xrp13QFS7RY/vIoiPtOpchqMwxmP5F+LUdrVn7uPSt8CGH4qXFw10N5PToJ4er+0Ge3ZZrSUxAt+2hgKRRJC5MXLqQ/g/KZRf9ctZKgo+IevtQk5/t9RZzAOEULlmjbfmbwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SODs8+U1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnwoQDZF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706086562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3HgGTMv08xeDMeml7R7w42+BDzLJstFhSWbIhGezfY=;
	b=SODs8+U1XnNNUCJf54MPvol50AGE64Rq55Au6H3r98xLeOTeNOwf7vUKW+uHKOduXoN735
	sQK7bkAUBLVTGbd71vnhumYLmv8GWH3moh6OSryMuuzVzzrJWSMOU6H6NOon5zqxCOGJgK
	/FZWGakGGp+/uqKegJ3fl64N4n6uO21BIAzUnYko6p+JtKw5OQ7ijIYGhDdmGNhw81u9lu
	ZlvLPD6knca3sa+1f5GblvUzLQQjRbq752gg2bARTH3af7P6OfZUgSkS6BQdamDPXFQvVI
	bgU/6UPsEm7UCzPnjJ5OkNchMvHznIkiKXRWxLxex2cfkNOuNtTWd2giz6uv+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706086562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3HgGTMv08xeDMeml7R7w42+BDzLJstFhSWbIhGezfY=;
	b=BnwoQDZFoiM6N6Lox0rMRqu5K1QxRjEjJZKH+ebiNAdbRba4DCH8RjidNm+wtXa/BpenoN
	sMktwdJoZPs65jCw==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 iwl-next 2/3] igc: Use netdev printing functions for flex filters
Date: Wed, 24 Jan 2024 09:55:31 +0100
Message-Id: <20240124085532.58841-3-kurt@linutronix.de>
In-Reply-To: <20240124085532.58841-1-kurt@linutronix.de>
References: <20240124085532.58841-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All igc filter implementations use netdev_*() printing functions except for
the flex filters. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4b3faa9a667f..91297b561519 100644
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


