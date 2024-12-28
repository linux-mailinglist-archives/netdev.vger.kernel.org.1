Return-Path: <netdev+bounces-154399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4859FD85D
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3EA1885769
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDF801;
	Sat, 28 Dec 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Kf4RdxtX"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA4635
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344660; cv=none; b=TfddygorUMPEoLCTHMAzsG94iV48vISA4x6/HWhsFBbAtSKeJV3dgX7ozJ3LWEDlHv4EGSqJoQ2rlgxlGXEhDZMnLwEV5lmPjNsEiajwJQTAwUead/SelnGyIN/YBXccdR63vqV2OduGXgvHsndfyESrEh1mTsKjJ65X6pAEyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344660; c=relaxed/simple;
	bh=qeTewmqwSrOs8bYjJ+5ITjSqi0F3qN8mJGmbLUGHrjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT4StGHUGv6XHgs9RT0VvZa9DB4hZgbJ2dUCgLZ79zZQ1lh+OLMlOZn8h8OvN5kPoBCy7YZS9SpCu2/FTQ0PdXGlsGJPncNPnGJ8zGdFW2bAl/k0wkITdH5SFS7KUUVLbVru+aNyim4Ft5wFRlDX2NJhbOOOFRm8OcodgT9xUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Kf4RdxtX; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3131; q=dns/txt; s=iport;
  t=1735344659; x=1736554259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GyX0+WH5s3r+DRb+YeqbtPUswHg2E8oZDXD3UkWxyqo=;
  b=Kf4RdxtXcTxodhQnHv9ntMmtxdTvrbPUVqn4+cbH8V/1cugK1Or9u2S9
   VPTBQWkWSlRid0EwgoTWktgYQLJTH/Y6+QaeLbBjWUwbIcWZwndRJRHRF
   /Fcmg3+H7kvE9DFrlpYZxfzlleT819YcDC1Ig3kyRyfds0xtXmy3zZUl7
   o=;
X-CSE-ConnectionGUID: +gWQ49EdQnmKxyR+p7IaQA==
X-CSE-MsgGUID: 5GdgQDYjRk+UGBxZpuJiaQ==
X-IPAS-Result: =?us-ascii?q?A0AkAQDJQG9nj47/Ja1aHgEBCxIMgggLhBpDSI1Rpw2BJ?=
 =?us-ascii?q?QNWDwEBAQ9EBAEBhQcCim4CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnCwFGEFErKwcSgwGCZQOxOYF5M?=
 =?us-ascii?q?4EB3jOBbYFIhWuHX3CEdycbgUlEgRWBO4ItiwcEgjaGX4dEhzOPe0iBIQNZL?=
 =?us-ascii?q?AFVEw0KCwcFgTk6AyIMCwwLFBwVAoEegQIUBhUEgQtFPYJKaUk3Ag0CNoIgJ?=
 =?us-ascii?q?FiCTYUXhF6EVoJJVYJ7ghd8gRqCJUADCxgNSBEsNwYOGwY+bgecX0aDcgGBD?=
 =?us-ascii?q?nyVFZIfi3KVEYQkgWOfYxozhASUBZJJmHwigjWhb4RmgWc6gVszGggbFYMiU?=
 =?us-ascii?q?hkPji0NCbUgJTI8AgcLAQEDCZEzAQE?=
IronPort-Data: A9a23:+Q5m9aqW5uHGDTvhW0Bx0kMUl55eBmL8ZRIvgKrLsJaIsI4StFCzt
 garIBmDafiJamD8eIp+OY6w8k9XvcPdm4VmTVRk+Xw9HiNB9ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/vZ8kw34JwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0qV4PlgSp
 NEUETYITQCSvaGun5Oyc8A506zPLOGzVG8ekmtrwTecCbMtRorOBv2Xo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUvrSn8/w7pX7Wz9fqFSZrK46y2PS1wd2lrPqNbI5f/TWHZ4MzhfE+
 z6uE2LRXz4WO+Wz+Di/8TGRqcXfrzvmeoMbLejtnhJtqAbOnjNIUkJ+uUGAifWwlEO7c95WN
 UER/i0gse40+VDDZtTxQhixsnOYlhEbXNVUHqsx7wTl4qnJ6Q+xBWUeSDNFLts8u6ceTDomz
 FKW3NXkGTBirpWRVHSbsLyUxRuqMCIYK24qfyIITQIZpdLkpekbiB/TQtt9OLC6g8ezGjzqx
 T2O6i8kiN0uYdUjza63+xXDxjmrvJWMFlNz7QTMVWXj5QR8DGK4W2C2wRvU0s8cfauVd1+En
 2gVoYuGs8EHNLjYwURhX94xNL2u4v+ENhjVjlhuA4Qt+lyRF5iLI9s4DNZWehsBDyoURQIFd
 nM/ru+42XOyAJdIRfItC25SI512pUQFKTgDfqyPBjapSsMqHDJrBAk0OSatM5nFySDAa50XN
 5aBatqLBn0HE6lhxzfeb75CiuJxnX9ulDiCGMiTI/GbPVy2Oif9pVAtbQvmUwzFxPnfyOko2
 48FbpLRmk83vBPWP3aLrtJ7wa82wYgTXs2u9JcNKYZv0yJtGXoqDLfK0Kg9dol+16VTnaGgw
 51OchEw9bYLvlWecV/iQik6MNvHBM8vxVplZnZEFQjzhBAejXOHsPx3m20fIeJ/rLQLID8dZ
 6VtRvhs9dwWGm6Zpm1DNMCixGGgHTzy7T+z0+OeSGBXV/Zdq8bhprcIoiOHGPEyMxeK
IronPort-HdrOrdr: A9a23:2TNryagUvq2gEbcxNuYCK8cEZHBQXt0ji2hC6mlwRA09TyVXra
 +TdZMgpHjJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7dZmnbUQKTRekIh7cKgQeQfhEWndQy6U
 4PScRD4aXLfDtHZQKQ2njALz7mq+P3lpyVuQ==
X-Talos-CUID: 9a23:R1ezk2wVz+BCNKYw6eMaBgVXFf8cLizwwE7WJmyoGFwqUOK0QGa5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AqA9ApQ5TyIyw+jBx6SCBHkyCxow1zKihMWw8k68?=
 =?us-ascii?q?F+PSrHzxCIyq/jT2OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="403189454"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id D0CFF1800022F;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 9004B20F2008; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 5/6] enic: Move RX coalescing set function
Date: Fri, 27 Dec 2024 16:10:54 -0800
Message-Id: <20241228001055.12707-6-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241228001055.12707-1-johndale@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

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
index 5bfd89749237..21cbd7ed7bda 100644
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
@@ -1816,36 +1846,6 @@ static void enic_synchronize_irqs(struct enic *enic)
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


