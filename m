Return-Path: <netdev+bounces-126742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DB9725E3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BB71C2277F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033918F2E8;
	Mon,  9 Sep 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CiI3DgmG"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EE18EFD6
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925941; cv=none; b=CePrgTKS2eX3zcIlXBWrI6x3RQKpBMxjfMTL/nvs+i/cC5tmdmMB2Tc8hBBUBeSq70THMppcTIEo8tOKXRbiFZdGDPahcIuqjlxdhuwJaUzduWKMTMNOOx/G38TIKPg3LxRzQLJsF4b2vfJ7SOhzfUfMawJ6KTQ9yasI4w+Bv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925941; c=relaxed/simple;
	bh=Iqlf/AyudCCfFuqNk5ph3XX2S8fdKW3FjHlcnfahr4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teZU6/tiqY1qMKC8fEciQS6RJOX8vKu1b0UeY+PBaFPKO6nHAEndkPOJTDyDcD/DlK3bFTEiKkz7p7zYEepPjNdhs0wR0tvRri5gRXRga/kI4WEXbXrQyl+H5Qo/Z0RW8oVd+jdBWWt1YsFXv+RzIjLGxElpJK0ZyyNpScWdjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CiI3DgmG; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z7hMAYUJc0zmXWBPqYacY7Rnkdds/x2g+X1a1EEKWc=;
	b=CiI3DgmGYdI0RENTl31Uzr20M86Njzhc7NENiJIVtidhc/mMgY3sHUQeTDW4HlUaDIuPAE
	0snie915zpP5Ei+PefJLA6LJoYe/qNLua5igU/E37474z98amymu5XyfHORTFZL2D5xpBX
	CIN4Qvl9YMfOyScqpQjHtNvVypS9x3A=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC PATCH net-next v2 2/6] net: xilinx: axienet: Report an error for bad coalesce settings
Date: Mon,  9 Sep 2024 19:52:04 -0400
Message-Id: <20240909235208.1331065-3-sean.anderson@linux.dev>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of silently ignoring invalid/unsupported settings, report an
error. Additionally, relax the check for non-zero usecs to apply only
when it will be used (i.e. when frames != 1).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index cf67d455da48..bc987f7ca1ea 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2048,14 +2048,25 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EBUSY;
 	}
 
-	if (ecoalesce->rx_max_coalesced_frames)
-		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
-	if (ecoalesce->rx_coalesce_usecs)
-		lp->coalesce_usec_rx = ecoalesce->rx_coalesce_usecs;
-	if (ecoalesce->tx_max_coalesced_frames)
-		lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
-	if (ecoalesce->tx_coalesce_usecs)
-		lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
+	if (!ecoalesce->rx_max_coalesced_frames ||
+	    !ecoalesce->tx_max_coalesced_frames) {
+		NL_SET_ERR_MSG(extack, "frames must be non-zero");
+		return -EINVAL;
+	}
+
+	if ((ecoalesce->rx_max_coalesced_frames > 1 &&
+	     !ecoalesce->rx_coalesce_usecs) ||
+	    (ecoalesce->tx_max_coalesced_frames > 1 &&
+	     !ecoalesce->tx_coalesce_usecs)) {
+		NL_SET_ERR_MSG(extack,
+			       "usecs must be non-zero when frames is greater than one");
+		return -EINVAL;
+	}
+
+	lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
+	lp->coalesce_usec_rx = ecoalesce->rx_coalesce_usecs;
+	lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
+	lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty


