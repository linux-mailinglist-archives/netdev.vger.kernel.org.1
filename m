Return-Path: <netdev+bounces-143448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9119C2738
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BCF1F21ABE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C820B7F6;
	Fri,  8 Nov 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HU1Liym6"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E71F26C3;
	Fri,  8 Nov 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102624; cv=none; b=Eiv0eD0HKP0tgan6BWxT9Dz0GcJhqIDwyXE/QfbLy9MJPJX3o5bKr6ETH8uOVxpjmXS3mX8rN1DFBqgzXPmjWg3IqJwchH56rCYYUfuS9NfUXdxMP9A1PZ21348Qm1vbf29FIEg6ym79mmcfAmfzkZFYKcN8yIvJDTfmVrVfQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102624; c=relaxed/simple;
	bh=xatTfDDvuha6eMR9JG9Hd2IzFzAHGTmF0QhSbBpuJrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFXWK50YpW7PG3LDrJK3fmCauKUPvR62VDegxGQ/1V9Dr7HLwvcEoXvh/+97wQFi72O3pfFxZIlPYJ5kFmF+bO0v3OPGtRgq82vJAgvwIWVhLxnPfUSYpOaLL4OonOBWWYGkwskAopF51wM4BtZP3w4QQ+3IVe8G7IaObot8Ea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HU1Liym6; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2260; q=dns/txt; s=iport;
  t=1731102622; x=1732312222;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tHLwdiP31Rtapi/mWtIkSPTBuH5ItPWzaydhVQl5G3Y=;
  b=HU1Liym6ltFXlIyPAK1lV8ysAlUhj0UqvQRaAJPnODNSyykMuvO6Wv9C
   vnU6Vy22T29+8DDXaUM5xpN6bBVFV8AVexEhlJbgVgZwk1wtbWbiv0FcR
   wcckCZbOiqHA8B/23lEdccCRgQJrKJirMCFkoeXL4m5kuYvdFIpYFzF5p
   U=;
X-CSE-ConnectionGUID: nOAVb4vCRomNsiUiTuDJvA==
X-CSE-MsgGUID: XGXdF/6kQfeeb3pHOIJyVg==
X-IPAS-Result: =?us-ascii?q?A0AUAACvhi5nj5P/Ja1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYQaQkiEVYgdhzCOFoxHhVyBJQNWDwEBAQ9EBAEBhQcCijoCJjQJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIh?=
 =?us-ascii?q?lsCAQMjBFIQJQImAgIrGxAGARKDAYJlAgGwXXp/M4EBhHvZOIFtgRouAYhLA?=
 =?us-ascii?q?YFsg2QZO4Q8JxuBSUSEfYgegmkEhDEDgy6JOphSCT+BBRwDWSERAVUTDQoLB?=
 =?us-ascii?q?wVjWD4DIm9pXHorgQ6BFzpDgTuBIi8bIQtcgTiBGhQGFQSBDkE/gkppSzcCD?=
 =?us-ascii?q?QI2giQkWYJPhR2Eb4RoghIdQAMLGA1IESw1Bg4bBj0BbgeeKUaDLQGBDZYOg?=
 =?us-ascii?q?2mNPaFrhCShWTOqTS6HZJBlIqQbhGaBZzqBWzMaCBsVgyJSGQ+OLQ0JkxYBt?=
 =?us-ascii?q?UBDNTsCBwsBAQMJkhkBAQ?=
IronPort-Data: A9a23:gPUPK6AJqjvVBBVW/9Pjw5YqxClBgxIJ4kV8jS/XYbTApGt3gWZTz
 DEZUGuCM/6KZGqhfohyPo2x80MOu5/RzNcyOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQb9i2YoWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TExdJHMktqI6Yi/eNRGmBz9
 MAFBBITR0XW7w626OrTpuhEnM8vKozveYgYoHwllGmfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYwBPjDS0Un1lM/Dp8zh+yvjHDXeDxDo1XTrq0yi4TW5FcujuKyaoqKIrRmQ+1lsXaUi
 CWY/F33DxwQb8S/7hun40yj07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcATA0Y85zgrZs1gxbnUNluCui2g8fzFDW2x
 CqFxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2CtbBLLZ2SSR+Ku
 31sd9WiAP4mC7akqibRXs43G7SP/Pe4MQHBrXxxNsx0n9iywEKLcYdV6TB4AU5mNMcYZDPkC
 HM/XysPufe/21P0McdKj5KNNig88UT3+T3YuhHogjhmPskZmOyvpX0GiausM4bFyxZEfUYXY
 snzTCpUJSxGYZmLNRLvLwvn7Zclxzol2UTYTo3hwhKs3NK2PSHOEO9dbAHfNrBhsctoRTk5F
 f4Bb6NmLD0CAIXDjtX/qNN7wa0idCJiXMun8aS7iMbZf1A8RQnN9MM9MZt6JtQ6xP4K/gs51
 nq8QURfgEHunmHKLB7Ca3ZoLtvSsWVX8xoG0dgXFQ/wgRALON/3hI9GLstfVed8roRLk6UrJ
 8Tpju3cWZyjvByboGxFNfEQbeVKKHyWuO55F3H1OmFjJsU4F1KhFx2NVlKHyRTixxGf7aMWy
 4BMHCuCKXbfb2yO1PrrVc8=
IronPort-HdrOrdr: A9a23:Bi5cFKyRciYeZNUg6hoWKrPw871zdoMgy1knxilNoNJuA6ulfq
 eV/MjztCWUtN9/Yh0dcLy7VZVoBEmskKKdgrN+AV7dZniEhILAFugLhuHfKn/bak/DH4Vmup
 uIHZIObOHYPBxWgdn35Q+gH81l4tWWmZrY/dv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJba
 Z0nvA3wQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A8TAtjWjX2gm9qjhLxyj9h7Up5jJudFr08n2MPWS?=
 =?us-ascii?q?CDmNPU7yoSGON1IF6up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AC35z3w5aJfslaqC5t6VxjhzExoxYzJSiJgdTkqw?=
 =?us-ascii?q?ItsSObjRQHBa/nQq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="376272870"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 896F218000274;
	Fri,  8 Nov 2024 21:49:13 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 26CE0CC12B6; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:53 +0000
Subject: [PATCH net-next v3 7/7] enic: Move kdump check into
 enic_adjust_resources()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-7-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=2292;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=xatTfDDvuha6eMR9JG9Hd2IzFzAHGTmF0QhSbBpuJrI=;
 b=+UaZwuNQtMzNVshj56EsIrPn3MWPIFxheCCcSJ5ascHIIKxWH+Krl98RTnWFa7zYf6Ifpt7wz
 /ajvRtsg1iPBIT/+zg9o2NAUQQFEdZvH3dp7gnqGnGVv9xZQ+9zQWhx
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=

Move the kdump check into enic_adjust_resources() so that everything
that modifies resources is in the same function.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 84e85c9e2bf52f0089c0a8d03fb6d22ada4d086c..9913952ccb42f2017037a81a8e2c42daa7b53ec3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2531,6 +2531,15 @@ static int enic_adjust_resources(struct enic *enic)
 		return -ENOSPC;
 	}
 
+	if (is_kdump_kernel()) {
+		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
+		enic->rq_avail = 1;
+		enic->wq_avail = 1;
+		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
+		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
+		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
+	}
+
 	/* if RSS isn't set, then we can only use one RQ */
 	if (!ENIC_SETTING(enic, RSS))
 		enic->rq_avail = 1;
@@ -2764,18 +2773,6 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_enic_resources(enic);
 }
 
-static void enic_kdump_kernel_config(struct enic *enic)
-{
-	if (is_kdump_kernel()) {
-		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
-		enic->rq_avail = 1;
-		enic->wq_avail = 1;
-		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
-		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
-		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
-	}
-}
-
 static int enic_dev_init(struct enic *enic)
 {
 	struct device *dev = enic_get_dev(enic);
@@ -2811,10 +2808,6 @@ static int enic_dev_init(struct enic *enic)
 		return err;
 	}
 
-	/* modify resource count if we are in kdump_kernel
-	 */
-	enic_kdump_kernel_config(enic);
-
 	/* Set interrupt mode based on system capabilities */
 
 	err = enic_set_intr_mode(enic);

-- 
2.35.6


