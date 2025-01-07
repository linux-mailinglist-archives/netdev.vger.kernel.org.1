Return-Path: <netdev+bounces-156043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5DA04BDE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D83A16377D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE61F63F4;
	Tue,  7 Jan 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Ei6Y3Qc7"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5F1E0084
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286128; cv=none; b=jIyjI5h78pkoSVLLihBnvFFAnOlod67qhqZEHVNt+Sq5lravimJ21TaruOqYhhf3U74Y+6aYHCPEBYCTFiofp1uzwHs+5bhda2hXF2tD7gsnqVs4PVQqkkQPgxJGwrHoRPk6HCw8FuHGJFWxEqe9m7LrqwL1F4J66JuFQeSYH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286128; c=relaxed/simple;
	bh=kj3XAeBVudwD3vo/0EEH75kWe1rcErK6eALotHsNWn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5BGdvzHhtgKlrXVV47X1Dc/6X0GYwxjePntml4N0Fmuydkxspf14x6FYt/RWhflPjoBRtjktjs9ZT9OzcLKQAKlt7bn2EuUjV++Jy5CNa+LuRA2tAu74d70kQvAp8KcHzAvZr1JpnHU+BLdzakA3RtcWoRwuZ6QM3pOffCpjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Ei6Y3Qc7; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3131; q=dns/txt; s=iport;
  t=1736286126; x=1737495726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPokXnowB9WV2FbOa7AooedmIXf8/hgdXZkkQ7irUCc=;
  b=Ei6Y3Qc7g2K6XwpnVfe5hp8jjklNG/ZhHRlLj30xH4/lm7L0fHH+79UO
   OayN7oxWi149lgcVYf1/y8MYH4CuotP8kUyWVyNDVYP1VJZL/YwvyxmQB
   OL0qVKvWuKkcEX25RiNSdBYJaI+gRsvV1HXk+y4yNvSNhur9zJ+G85x/r
   8=;
X-CSE-ConnectionGUID: mYhYkXiqSdWbpfhhTh4pfg==
X-CSE-MsgGUID: ZG8JkHBPRLaFskoY2TEa9Q==
X-IPAS-Result: =?us-ascii?q?A0AeAACVnn1nj5AQJK1aHQEBAQEJARIBBQUBggAHAQsBh?=
 =?us-ascii?q?BlDSI1Rpw2BJQNWDwEBAQ9EBAEBhQcCinQCJjUIDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnCwFGEFErKwcSg?=
 =?us-ascii?q?wGCZQOxQoF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIEVgTuCLYsHBIIzhTaGZ?=
 =?us-ascii?q?ocfkARIgSEDWSwBVRMNCgsHBYE5OgMiCwsMCxQcFQIVHxIGEQRuRDeCRmlLN?=
 =?us-ascii?q?wINAjWCHiRYgiuEXIRHhFiCS1WCSIIXfIEdgkFVQAMLGA1IESw3Bg4bBj5uB?=
 =?us-ascii?q?5p1PINuAYEOfJUVkh+LcpURhCWBY59jGjOEBJQGkkmYfCKCNqFvhGaBaAE4g?=
 =?us-ascii?q?VszGggbFYMiUhkPji0NCbknJTI8AgcLAQEDCZFVAQE?=
IronPort-Data: A9a23:xUKm4agoAEWwiO9LiuDXT/M2X161uhAKZh0ujC45NGQN5FlHY01je
 htvCmyFa/6INjf2c4sgaYvipxxXupLRyINlT1Zr/nwxFXljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD9Msvrc8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUdy+ZGAlFP7
 McUFzoVYBCDu+Lq2Ly0H7wEasQLdKEHPasWvnVmiDWcBvE8TNWbHOPB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTZj/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJIozbFJ4IwBnwS
 mTuzUupIBI6HuSl7TOr6XGrt7XzsCqqYddHfFG/3qU32ALInDN75ActfVeyv/S8okK3Rd9aL
 0sa5mwooLRa3EGnU9z0TRCkiHGDuREYVpxbFOhSwAKQwKP84AuDAGUACDlbZ7QOvck6XzE1l
 VmEg9/kGxRrrbuTD3mdnp+MpDm/Pyk9N2IOZSYYCwAC5rHLpowvgh/RZshsHbTzjdDvHzz0h
 TeQo0ADa647hMoP0eC/uFvAmT/p/sePRQ8u7QKRVWWghu9kWGK7T4mZ6WnY3fdZF4qmREGPv
 Hg4m5SG4u9bWPlhixexaOkKGbio4dOMPzvdnUNjEvEdG9KFpSfLkWd4vm0WGat5DvvobwMFd
 6M6hO+w2HOxFCbyBUOUS9vtYyjP8UQGPY+8PhwzRoEVCqWdjCfdoElTibe4hggBanQEn6AlI
 ou8es2xF3scAqkP5GPpHLlEge9wnnhhlT+7qXXHI/KPjOT2iJm9FOZtDbdyRrpihE95iFyPq
 o8Ba5viJ+t3D72mPnO/HXEvwaAidiVjWsus9KS7h8aIIxFtHyk6GuTNzLY6M41jlOI9qws71
 i/VZ6Os83Km3SevAVzTMhhLMeq/Nb4h9ihTFXJ3Yj6VN40LPd3HAFE3K8BvJeFPGS0K5aIcc
 sTpjO3ZW6sREmqbqmp1gFuUhNUKSSlHTDmmZ0KNCAXTtbY5L+AV0rcIpjfSyRQ=
IronPort-HdrOrdr: A9a23:+g8sQ6vmM+NS+kU0JeSp33cb7skDcdV00zEX/kB9WHVpmwKj+P
 xG+85rsiMc5wxxZJhNo7290ey7MBHhHP1OkO0s1MmZPDUO0VHAROoJ0WKh+UyEJ8SUzIBgPM
 lbH5SWcOeAbmSTSa3BkXCF+xFK+qjgzJyV
X-Talos-CUID: 9a23:vt8ClG8JAyz19XkMZAOVv0slGvEmQnzE93vvKVe2CWZVSOGNR1DFrQ==
X-Talos-MUID: 9a23:2Iwx6wUdrWAHl9Dq/A3D1BNhFO1Q2YCnJlsOlqRch+SNZBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="408993567"
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 21:42:05 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-07.cisco.com (Postfix) with ESMTP id 5AC2D180001D1;
	Tue,  7 Jan 2025 21:42:05 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 31A3220F2004; Tue,  7 Jan 2025 13:42:05 -0800 (PST)
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
Subject: [PATCH net-next v2 1/3] enic: Move RX coalescing set function
Date: Tue,  7 Jan 2025 13:41:57 -0800
Message-Id: <20250107214159.18807-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107214159.18807-1-johndale@cisco.com>
References: <20250107214159.18807-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com

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


