Return-Path: <netdev+bounces-157257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E4A09BD6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF0F16B355
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBB21576E;
	Fri, 10 Jan 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d9VHJliJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010B214810
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537190; cv=none; b=Aqg15K8Z8LvZeY9bhBEkA6CGTTnQHlLGNwmqeIBeh687EHHzxF/+1ExQ7z6q9e1WLw5+5Xtif+KP+FOZpZVlI29pI9hdkLwqidrZeDIkH0V0t0skTc4T/rVrAioXB3NbNchUq1LAf8YnOuBi4u81y6RBDIsiis/YM+menb8ZhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537190; c=relaxed/simple;
	bh=4PpHvmCgnrBoDW4gSyp1L5CkyOTXtrS6DfFyn2aIU4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECtYpnILOUgMKhpdkzTwHW/YC203rsRD54riwuVtPmr2RPo3Czc7Svrzvx67asOghkLZCeGAEkHELEroUyxrHnv+YVWTOtu7u+2Ey0/Kl0C+z1vsXObg4khDF9yZuG7YQSvVZHfJ5OKzjx14VDgM9/I/pPP0ck6upsB3AQE9AzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d9VHJliJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736537186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVsFHs3qP+DP2safQz7Gvj7+Xv1tZ9kq80hiFL5KwOU=;
	b=d9VHJliJysr3BgF96L92TeT8PV8DCQK/9SR4YtZJUVug3g+9IlWDRPXUvVmo7gV3TcttI1
	LWPdDIlfCFzZjZt61kIwN5+MINL0iwJBSy2MjEwSKhERsABaJb7+aX0gpJ3a3plyWHjpQE
	LIVp2yvBUwzid6TnLUUMs5Lhk6iQzFY=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 2/6] net: xilinx: axienet: Report an error for bad coalesce settings
Date: Fri, 10 Jan 2025 14:26:12 -0500
Message-Id: <20250110192616.2075055-3-sean.anderson@linux.dev>
In-Reply-To: <20250110192616.2075055-1-sean.anderson@linux.dev>
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
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
Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
---

(no changes since v2)

Changes in v2:
- New

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 62638e2a086e..ccc4a1620015 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2059,14 +2059,25 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
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


