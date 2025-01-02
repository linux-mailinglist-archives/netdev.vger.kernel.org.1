Return-Path: <netdev+bounces-154849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0197A0012C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE13A3A37
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDB1BD9C9;
	Thu,  2 Jan 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NcAkMSnz"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC21A8F9A
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856723; cv=none; b=oky5Fykbxs84/nyQWrFnindBqksp04oP3m1x2ILiEWDKgodPeV5GVn7p3BrDYcpd98RzB5VeBND9Oa8OoErhM3NIMTn4Gh1yJ09M/iPtpOvdw7YAV9CnFZg3G7Zh4O2jqfKeeWSM3MilklBr03abg/1PzRzSGv5CDfhPDBRT7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856723; c=relaxed/simple;
	bh=qeTewmqwSrOs8bYjJ+5ITjSqi0F3qN8mJGmbLUGHrjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oytbEtw9DD2sSicdYMFdRYiVZiHEuo4Jp6Lrf9v0o21E83v4oZ0a5X2rnnYuMt/1tE0ED1YlMAFMsKq5JjHkh93oMImFOlerAilFwwxn3edDxjp7JHQlX5xKc67Er2obNszsN91JYuihe0DOVQ5q+9aZ59k2BDrHpC8NVtzlzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=NcAkMSnz; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3131; q=dns/txt; s=iport;
  t=1735856721; x=1737066321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GyX0+WH5s3r+DRb+YeqbtPUswHg2E8oZDXD3UkWxyqo=;
  b=NcAkMSnze3jwcyJefdSMX86M5QMRwdPKIrBmaJBYfq7JrBszDhM0/GcY
   LYANoNWZbzBRprTfyqaDZeFrUWBQ5r2it8WqZUa2ZgLj6gdhzv2l506RN
   MKRghtfI8jBxJh6KjD101JEQ4oJX96cuIExB2YsohX+9hOnm09oOv4C8c
   4=;
X-CSE-ConnectionGUID: Bdfvx99/QMKcSggux2+lyA==
X-CSE-MsgGUID: CPfjqbaORcqmZpCLiqNlBg==
X-IPAS-Result: =?us-ascii?q?A0ATAADxEHdnj4oQJK1aHQEBAQEJARIBBQUBgX8IAQsBh?=
 =?us-ascii?q?BlDSIxyX6cNgSUDVg8BAQEPRAQBAYUHAopvAiY0CQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BUmGCIZbAgEDJwsBRhBRKysHE?=
 =?us-ascii?q?oMBgmUDsxaBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSBFYE7gi2LBwSCM4ZVh?=
 =?us-ascii?q?m6HH49KSIEhA1ksAVUTDQoLBwWBOToDIgsLDAsUHBUCgRqBAhQGFQSBC0U9g?=
 =?us-ascii?q?khpSTcCDQI2giAkWIIrhF2ER4RWgklVgkiCF3yBGoIqQAMLGA1IESw3Bg4bB?=
 =?us-ascii?q?j5uB5t5PINtAYEOfJUVkh+LcpURhCSBY59jGjOEBJQFkkmYfCKCNaFvhGaBZ?=
 =?us-ascii?q?zqBWzMaCBsVgyJSGQ+OLQ0JsHIlMjwCBwsBAQMJkVYBAQ?=
IronPort-Data: A9a23:YeVoZKkN/uEPN6IN9hQnd4Do5gxkJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcDGyBO6neZ2f8Ko8kPIrg9B8DsMXRytFhS1A+/i88QltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubzpNs/jb83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FacU9PhnUDAJz
 Nk7IwsCYQ2T3aGy0ZvuH4GAhux7RCXqFIobvnclyXTSCuwrBMiaBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkYfUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaNJY3VGZ8Mwy50o
 Ertx2r7GxsTE+aU0D+36lmIh/bpmQn0Ddd6+LqQraMy3wbJmQT/EiY+WVKlrPyRhkegVtdbL
 EIIvCwjscAa+UC2S9DvUgGQr3mDsRoRHdFXFoUS6xyHw4LX7hyfC2xCSSROAPQvssMsSCNp0
 FKVk973LThytrvTQnL13q+dpz60OAAPIGMCbDNCRgwAi/HlrZ0/gwznUNluCui2g8fzFDW2x
 CqFxBXSnJ0aicoNkqH+9lfdjnf0/97CTxU+4UPcWWfNAh5FiJCNTYCm90iKvLF5CaWSdVaOo
 Whe2MyPxbVbZX2SrxClTOIIFbCvwv+KNjzAnFJid6XNERzzoBZPmqgOvFlDyFdVDyoSRdP+j
 KbuVeJtCH17YSLCgUxfOt7Z5yEWIU7IToSNuhf8NYEmX3SJXFXblByCnGbJt4wXrGAikLskJ
 bCQetu2AHARBMxPlWXtGrhAj+R3nXFhnws/oKwXKTz6gNJyg1bIGN843KemNLtRAF6s+V+Mq
 o0ObaNmNT0CD7GgOkE7DrL/3XhRcCBkXsqpwyCmXuWCOQFhUHowEOPcxKhpeopu2cxoehTgo
 BmAtrtj4AOn3xXvcFzSAlg6MeOHdcgk9xoTY3dzVWtELlB/Ou5DGo9DLMNvJdHKNYVLkZZJc
 hXyU5zZU6QSE2WeoWR1gFuUhNUKSSlHTDmmZ0KNCAXTtbY5L+AV0rcIpjfSyRQ=
IronPort-HdrOrdr: A9a23:qQrbzqNaCbILH8BcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:1XDeB2FK8mD7tQpyqmJN+EAKCpF0NUT473zrLEClGTwqTKy8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A7rJsMwzQrCqtdQV0olNiu8Qkt3OaqI+WBkIUm5w?=
 =?us-ascii?q?hgcKdMB5oEBOclRKzaIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="407974215"
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-01.cisco.com (Postfix) with ESMTP id 869581800019B;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 35AA720F2008; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
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
Subject: [PATCH net-next v4 5/6] enic: Move RX coalescing set function
Date: Thu,  2 Jan 2025 14:24:26 -0800
Message-Id: <20250102222427.28370-6-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250102222427.28370-1-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

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


