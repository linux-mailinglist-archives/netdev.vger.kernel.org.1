Return-Path: <netdev+bounces-155691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B678A0357C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DF43A45A2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C68155CB3;
	Tue,  7 Jan 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="MXCt+wIU"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C238155335
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218372; cv=none; b=lRpqwg4TMYOZ7bgyYw0g29nXtZR9hS2ueCD4+H2QgPO0PqfJw9rjF2qosDfQBkPIuXfyDP0oyQf5vrxjhFmfZF+k5Ke3ElvejWoHWkci+g64ulsCJ2iLQUHYxPOwY3L3NQPVyXVME8u9DUcGofYnFbmmAqh3E2qIdD1TYWD19ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218372; c=relaxed/simple;
	bh=kj3XAeBVudwD3vo/0EEH75kWe1rcErK6eALotHsNWn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3EODjWcGX+UrN7dMEmLnsksEt/8dhal3+xTelnvudjZmP/kYqOsJ33VthxK4FmCVqHC0xuq8CP32ILOfQgR8SfN82g+2MS/0n8nJQLLAv5Uz1re4C3MnL5G0IR5Rv98BwwBD2ebnR3h/jg57y8Q1v/MoXW+V5SE6gq/vkwqqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=MXCt+wIU; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3131; q=dns/txt; s=iport;
  t=1736218370; x=1737427970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPokXnowB9WV2FbOa7AooedmIXf8/hgdXZkkQ7irUCc=;
  b=MXCt+wIUmiiUzca1QvVcawGi0lFp7EDOiqc+TT7fPEl2Ga6yIDCKlhDe
   J9GXfG8JixREBdHZTfCUXjR435O+PGvGgJalcPGW1poUbFVmVUH7MmlUK
   fkY0qcf/idr9e2qcJkg4SPsibhLNCVK2GfuUQWN0mwBS7zf8CXct6j8Gm
   M=;
X-CSE-ConnectionGUID: 4+Q3FWGMT3mjMiCzWEe/hA==
X-CSE-MsgGUID: BihqDPxgQLabhY16IbKr7g==
X-IPAS-Result: =?us-ascii?q?A0A6AADjlXxn/5IQJK1aHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kqBT0NIjHJfpw2BJQNWDwEBAQ9EBAEBhQcCinQCJjQJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQUSsrBxKDAYJlA?=
 =?us-ascii?q?7A/gXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO4ItiwcEgjOFOYZmhx6Pc?=
 =?us-ascii?q?EiBIQNZLAFVEw0KCwcFgTk6AyILCwwLFBwVAhUfEgYVBHREOYJGaUk3Ag0CN?=
 =?us-ascii?q?YIeJFiCK4RchEeEVoJJVYJIghd8gRqCQS1AAwsYDUgRLDcGDhsGPm4HmmY8g?=
 =?us-ascii?q?20BgQ58lRWSH4tylRGEJYFjn2MaM4QElAaSSZh8IoI2oW+EZoFnPIFZMxoIG?=
 =?us-ascii?q?xWDIlIZD44tFrgHJTI8AgcLAQEDCZF0AQE?=
IronPort-Data: A9a23:9o2QUai20wwljWklZntGf5RaX161QxEKZh0ujC45NGQN5FlHY01je
 htvXDvUafePYmOkL4txO4rjpBsC78KEmtFrGlBorXg1RCxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD9Msvrd8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVEud8sL15h0
 MBDLTIobzuRuM+7h7KSH7wEasQLdKEHPasWvnVmiDWcBvE8TNWbEuPB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTZD/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJIIfaHZgIxBzwS
 mTu1WX5Gz0iJNOm7TOP8kP12M7FvjmkV9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhCE6g7NWiYsA0L+2uAiWxTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:QVEvLKHfx5pXz8SypLqE78eALOsnbusQ8zAXPo5KJiC9Ffbo8P
 xG88576faZslsssTQb6LK90cq7MBfhHOBOgbX5VI3KNGKNhILrFvAG0WKI+VPd8kPFmtK1rZ
 0QEJSXzLbLfCFHZQGQ2njfL+od
X-Talos-CUID: 9a23:wfKaImOGFmAQkO5DBGper2ArNeUZKXjf6Xb7MXCVBCFpYejA
X-Talos-MUID: 9a23:47OZIgbeBur3GOBTnT7snR1aJMhRx62kCHFUz7QMmNPbOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,294,1728950400"; 
   d="scan'208";a="423805522"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 02:51:40 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-09.cisco.com (Postfix) with ESMTP id 96BE11800022D;
	Tue,  7 Jan 2025 02:51:40 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 6740820F2004; Mon,  6 Jan 2025 18:51:40 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 1/2] enic: Move RX coalescing set function
Date: Mon,  6 Jan 2025 18:51:34 -0800
Message-Id: <20250107025135.15167-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107025135.15167-1-johndale@cisco.com>
References: <20250107025135.15167-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-09.cisco.com

Move the function used for setting the RX coalescing range to before
the function that checks the link status. It needs to be called from
there instead of from the probe function.

There is no functional change.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 60 ++++++++++-----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 9913952ccb42..957efe73e41a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -428,6 +428,36 @@ static void enic_mtu_check(struct enic *enic)
 	}
 }
 
+static void enic_set_rx_coal_setting(struct enic *enic)
+{
+	unsigned int speed;
+	int index = -1;
+	struct enic_rx_coal *rx_coal = &enic->rx_coalesce_setting;
+
+	/* 1. Read the link speed from fw
+	 * 2. Pick the default range for the speed
+	 * 3. Update it in enic->rx_coalesce_setting
+	 */
+	speed = vnic_dev_port_speed(enic->vdev);
+	if (speed > ENIC_LINK_SPEED_10G)
+		index = ENIC_LINK_40G_INDEX;
+	else if (speed > ENIC_LINK_SPEED_4G)
+		index = ENIC_LINK_10G_INDEX;
+	else
+		index = ENIC_LINK_4G_INDEX;
+
+	rx_coal->small_pkt_range_start = mod_range[index].small_pkt_range_start;
+	rx_coal->large_pkt_range_start = mod_range[index].large_pkt_range_start;
+	rx_coal->range_end = ENIC_RX_COALESCE_RANGE_END;
+
+	/* Start with the value provided by UCSM */
+	for (index = 0; index < enic->rq_count; index++)
+		enic->cq[index].cur_rx_coal_timeval =
+				enic->config.intr_timer_usec;
+
+	rx_coal->use_adaptive_rx_coalesce = 1;
+}
+
 static void enic_link_check(struct enic *enic)
 {
 	int link_status = vnic_dev_link_status(enic->vdev);
@@ -1901,36 +1931,6 @@ static void enic_synchronize_irqs(struct enic *enic)
 	}
 }
 
-static void enic_set_rx_coal_setting(struct enic *enic)
-{
-	unsigned int speed;
-	int index = -1;
-	struct enic_rx_coal *rx_coal = &enic->rx_coalesce_setting;
-
-	/* 1. Read the link speed from fw
-	 * 2. Pick the default range for the speed
-	 * 3. Update it in enic->rx_coalesce_setting
-	 */
-	speed = vnic_dev_port_speed(enic->vdev);
-	if (ENIC_LINK_SPEED_10G < speed)
-		index = ENIC_LINK_40G_INDEX;
-	else if (ENIC_LINK_SPEED_4G < speed)
-		index = ENIC_LINK_10G_INDEX;
-	else
-		index = ENIC_LINK_4G_INDEX;
-
-	rx_coal->small_pkt_range_start = mod_range[index].small_pkt_range_start;
-	rx_coal->large_pkt_range_start = mod_range[index].large_pkt_range_start;
-	rx_coal->range_end = ENIC_RX_COALESCE_RANGE_END;
-
-	/* Start with the value provided by UCSM */
-	for (index = 0; index < enic->rq_count; index++)
-		enic->cq[index].cur_rx_coal_timeval =
-				enic->config.intr_timer_usec;
-
-	rx_coal->use_adaptive_rx_coalesce = 1;
-}
-
 static int enic_dev_notify_set(struct enic *enic)
 {
 	int err;
-- 
2.35.2


