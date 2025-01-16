Return-Path: <netdev+bounces-159101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF7A14672
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276663A3DC4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4752451D9;
	Thu, 16 Jan 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="db6XkV1m"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B02244F89
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070210; cv=none; b=WgVEhAO5iuPEQWgW7Si/eb03hm6SYEcZxQ/IXV5obECVZKi6BqU/Re4ypRIJT+3uOFIwzryHZdALoQQ7sWtfAhtnIEpywSKN23+kI7tUYfBTI6Zo6TV7EUc1gOtc/qaJ+xRwqT/oMthpHhavhQ2PD/33UCU4DG1fDpdZTKp0jWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070210; c=relaxed/simple;
	bh=Y7YKle50adsEZBFHfxDM55VoUjsRltCGNCOWC0HcpYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIz3wsDbkirtCXhg3ExjxRzs1a1SWipzgPu7Bam4sPV+yvAOjvRru5W97p//akuWkH2VWymXjgCGdN3FjAu0VnjIArpxM1bFn5Lw8xEB6eXumQHKXaL1nJzzTuNZmB3lOMNeKpZKsxrVSN0HrNelUyyRQddn7GdmkDmaIr1fKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=db6XkV1m; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737070205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAMLm6yea8HkssgtGd3J3JCpe9oPgNIXAXNQ53QiS30=;
	b=db6XkV1mGJkBP4oT5jQHxa2uP5KACvfKmttyX13jQ0/E3niZuEkFkWf8JXXzmshfEqbzVW
	b9ej8UFLumPT8fpKZVE4IzUwn43sdlTs7rhsh5gOzod7GfR1Qk7f4l893ahy0mB6RoaccF
	A5GT5BRT17OwzN1jt0iAGavIxptHA9s=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 2/6] net: xilinx: axienet: Report an error for bad coalesce settings
Date: Thu, 16 Jan 2025 18:29:50 -0500
Message-Id: <20250116232954.2696930-3-sean.anderson@linux.dev>
In-Reply-To: <20250116232954.2696930-1-sean.anderson@linux.dev>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
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
index 0532dc94ee93..9e7fa012e4fa 100644
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


