Return-Path: <netdev+bounces-79668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA387A800
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B168285C3A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8E225AD;
	Wed, 13 Mar 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RV2gzj+d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6NgVkPPJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741F41A81
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334997; cv=none; b=SlKAvZWnVMzcyX6yw2QOO4LfHgoRnhKztlktdIRhhTifRz6PZVulmfYefvBEyv2MuJaPvtPAPsHofYO1nkpOVFm4KNTJCL3sAsZPWADHz6WOkXZQceSdyjT8x+8H74b60Nh1JGKmaqKRyDtP6Q8s8gOECqXcjwPQcYDor/LLRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334997; c=relaxed/simple;
	bh=GrNnKDgkIMZeLbHmwfq5U1uNGlGFk+4T0DFZQ8Vk9go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PdEj3WG8fZXXQdyb4tYrPI+vIf2zDbtMRU/QxkLrakj60xhisxaR640SK3RceUiU7r4dO+eqScOfGi/01/uPr8H+uEt3CQRlRboGMc6UQJdecyD2qfcvGuBeu9pDlZoLKV4Y5LHAtmTUCYzq+y43hDQFEgymbcQXAiQCobGRXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RV2gzj+d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6NgVkPPJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710334993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5JMrvmDVNALmWdwq0fCgL0UHXuNvWW+anwgA6EwkPqc=;
	b=RV2gzj+dCW8xw37tVDj2YSLi7Nv90UaTOWCY3JB+vr3nHyhdrpfasjXbp+aKcrO1OPjdXE
	Qpvuvzx1zpa7Fs1mNCpJOlOuQAbcPQ2oWUA3XxcTzWShKZN6iIv4mglzhWiCsvKvoWs02/
	Ni55KS6MczGaD4W4wz2qt5Kftx42ezWpFPbldcBUnVxzl0siz5vT662vWY1SyTxzmoak5P
	AY01XxtWnwiwY3/Xb1dDdvyB1jtYlyy65yF9zECSi3Bta5EqBBbyoGTAvqWGVp1madLR2A
	NNcHyc80IBEuonaVoZWzhOdcnRBWvknsJah8Jkc0FmHSlBmrLYnPISeLrBFUSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710334993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5JMrvmDVNALmWdwq0fCgL0UHXuNvWW+anwgA6EwkPqc=;
	b=6NgVkPPJINeGy0Adfw9i7RnU9OCzxKqZOjWVza8+hMuIsEJrX8DhJxQZv+BC9iFN4eOZix
	TO/v2dl/1OhVvZBA==
Date: Wed, 13 Mar 2024 14:03:10 +0100
Subject: [PATCH iwl-net] igc: Remove stale comment about Tx timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAA2k8WUC/x2N0QqDMAwAf0XyvICtY3T7lTGkjVEDax1NcYL47
 6t7PI7jdlDOwgqPZofMq6gsqYK5NECzTxOjDJXBtvbadqZDmagvW9Gelhg5FXTmZu/DSC44DzU
 LXhlD9onmM4xeC+dTfDKPsv1fT5DvGxMXeB3HD8lXVSWEAAAA
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=GrNnKDgkIMZeLbHmwfq5U1uNGlGFk+4T0DFZQ8Vk9go=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBl8aQQArPq6T4wA6zJH+1VgFG4zSS7YIU5yt0r7
 /BPCQNQtQ6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZfGkEAAKCRDBk9HyqkZz
 gnATD/4qjnv7e0lk7C4Hw4IY/ikKKbBjy3+2DJAeM3HV1l/WwqZP/0+ZcxKj1chuI5JKcoP2YMw
 w9vP637Aw3UGbN+2gUpSQGBhP+++NwG20YhASVfZsOMrSuNh0Rjb7exwtrUkUWSUYJaUq9lxH1d
 2P78YoL1qbhMLv3lZJl6sNKo571H0nMhb0rPS5239Aw+h9vmccFQPxviiBa6wCn+QpLQkSVRcd0
 3IygfA03DFdH83MnwmjAVlXRja+N/UVXLWuEN6vZgV26C2GHkjwtcY3gjQjcmV+tYLRX1rNE4BO
 8QsO0/zxn/eVVGRThaqFsE0KNXYTTvnKTqLf8lYg/UbjgLTdLoisoDml12yAYkGXFRpg/Cg/ms1
 948aMlgvtINJAPel7L8pRlIiJQWLT7qqt+ydwSa7HS1juP4exhnFb8hOaDOZ2gaZXxRodEQA4KI
 8JAH5sJpUYN8BjN4jXSKLzfMgSrlM2HJ7OsJKR7BrxX4DcgviwcseHgoNcGl35akQX/Uh2yy0rh
 6NL6z+U8vONlSpc4qHJQLerqxWKlq84+Gw3ju8hCbMatfSRcXqJsZRBWlfrMMXEu+JwhEONPcCH
 3w/SneL9lCk0eY7DSgB0hy8zORHUTpKSo/0umhrPkndzYULZyKxRGmca6beKvBZIM9pDntjeRiL
 JrLa2JATiNUmzvg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

The initial igc Tx timestamping implementation used only one register for
retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
multiple in-flight TX timestamps") added support for utilizing all four of
them e.g., for multiple domain support. Remove the stale comment/FIXME.

Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e1cfbd82f4f..35ad40a803cb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1642,10 +1642,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		/* FIXME: add support for retrieving timestamps from
-		 * the other timer registers before skipping the
-		 * timestamping request.
-		 */
 		unsigned long flags;
 		u32 tstamp_flags;
 

---
base-commit: 67072c314f5f0ec12a7a51a19f7156eebb073654
change-id: 20240313-igc_txts_comment-81629dfc8b8a

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


