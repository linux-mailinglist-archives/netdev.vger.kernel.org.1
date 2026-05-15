Return-Path: <netdev+bounces-288376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCoHNZFTB2pIygIAu9opvQ
	(envelope-from <netdev+bounces-288376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D75548D4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCFAF348FDDE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320433F9290;
	Fri, 15 May 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NwnNaZYI"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D353E7BDE;
	Fri, 15 May 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863297; cv=none; b=XGLqQuaOVnsCCx5NdJL7VMsUfqVzoaC1BG9vTOsUfiJF5NEVGa0WINeG6ZpHpitF/VFk8bmCPCP9hB6wPONbqkPY/pp7fgt0Vcg7U0v6/kE52bib0ixJk3cWeGR1NfeJUKNHmUnAWSVZe+MVRP87DqIrdbOkZoa+T9Efo30UQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863297; c=relaxed/simple;
	bh=zBfdw/tme5bvqIXAw+y/JWHBYhpWT5D8glKaES/P0MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO3xcSbKHUKpA+t+9n59SSv8dLpnYWdCOBFo56tv3kTUXW/+uQQl+EPO9tHjjzyL8reNllR6mAF3CqnlkbGZ8q0+xJsV73ZCARZRoWe/B5WYlfQfW8BFn8UijS8176xfOGwDwq8ADr8TIIbsTd5KUl6ewCRhZsKAORMXDt0n0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NwnNaZYI; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778863295; x=1810399295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMiuxyikS6m6XJDg2FvoDpXAe6A1bkcqerPKmeY60aY=;
  b=NwnNaZYIrAfq/CNHnnmI7+2UpMEwq93Rcto6KTeCaVIb5elocG9Iv9jO
   3eM02JQv7+kujvSvRoFwKyxc5w43eLfpnbyMGtgNjIaKbkP7FeaYNAsDC
   M5gQVPB9hPJtBTzWgnzSRfcKFO34eoXHPF0KFcGhKpk3+wjAWDMCKrf3l
   3TAQd+ETvjLjjLJHCuHRvQlOGPNihwDGkcPcuotxNayTwUFcemVB8bsCM
   0fB8ldm7d2lS/pD1pWFCyYodywMD8upoQsjR2J35hVlMKaleCxmYH9xIJ
   CXnkU9KMHbZ6QN88tdxjLKa6V0LlS182sithcW8MQ9claaWyjgZb/1Fua
   w==;
X-CSE-ConnectionGUID: koOFyg+hS8+hTpg1rpCOWQ==
X-CSE-MsgGUID: Scf6ijvSQeSVmgQiyNjV/w==
X-IronPort-AV: E=Sophos;i="6.23,236,1770595200"; 
   d="scan'208";a="19524441"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:41:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:16769]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.132:2525] with esmtp (Farcaster)
 id 64f57d1a-46e3-4990-8b45-92de84f2a08e; Fri, 15 May 2026 16:41:34 +0000 (UTC)
X-Farcaster-Flow-ID: 64f57d1a-46e3-4990-8b45-92de84f2a08e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:41:33 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:41:28 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v3 net-next 5/7] net: ena: Update PHC admin interface for error bound support
Date: Fri, 15 May 2026 16:40:25 +0000
Message-ID: <20260515164033.6403-6-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515164033.6403-1-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 993D75548D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288376-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Extend the ENA admin interface to support error bound.

Add error_bound to the PHC response structure.
Introduce a feature version mechanism to indicate device supports
error_bound, and add an error flag for error_bound retrieval failures.

This enables the driver to retrieve error_bound information from the
device alongside timestamps.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../net/ethernet/amazon/ena/ena_admin_defs.h    | 17 +++++++++++------
 drivers/net/ethernet/amazon/ena/ena_com.c       | 11 ++++++-----
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 898ecd9..2d132c4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -128,12 +128,14 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
-enum ena_admin_phc_type {
-	ENA_ADMIN_PHC_TYPE_READLESS                 = 0,
+enum ena_admin_phc_feature_version {
+	/* Readless with error_bound */
+	ENA_ADMIN_PHC_FEATURE_VERSION_0             = 0,
 };
 
 enum ena_admin_phc_error_flags {
 	ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP   = BIT(0),
+	ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND = BIT(1),
 };
 
 /* ENA SRD configuration for ENI */
@@ -1035,10 +1037,10 @@ struct ena_admin_queue_ext_feature_desc {
 };
 
 struct ena_admin_feature_phc_desc {
-	/* PHC type as defined in enum ena_admin_get_phc_type,
-	 * used only for GET command.
+	/* PHC version as defined in enum ena_admin_phc_feature_version,
+	 * used only for GET command as max supported PHC version by the device.
 	 */
-	u8 type;
+	u8 version;
 
 	/* Reserved - MBZ */
 	u8 reserved1[3];
@@ -1224,7 +1226,10 @@ struct ena_admin_phc_resp {
 	/* PHC timestamp (nsec) */
 	u64 timestamp;
 
-	u8 reserved2[12];
+	u8 reserved2[8];
+
+	/* Timestamp error limit (nsec) */
+	u32 error_bound;
 
 	/* Bit field of enum ena_admin_phc_error_flags */
 	u32 error_flags;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 8c86789..2579104 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1682,11 +1682,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_cmd set_feat_cmd;
 	int ret = 0;
 
-	/* Get device PHC default configuration */
+	/* Get default device PHC configuration */
 	ret = ena_com_get_feature(ena_dev,
 				  &get_feat_resp,
 				  ENA_ADMIN_PHC_CONFIG,
-				  0);
+				  ENA_ADMIN_PHC_FEATURE_VERSION_0);
 	if (unlikely(ret)) {
 		netdev_err(ena_dev->net_device,
 			   "Failed to get PHC feature configuration, error: %d\n",
@@ -1694,10 +1694,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 		return ret;
 	}
 
-	/* Supporting only readless PHC retrieval */
-	if (get_feat_resp.u.phc.type != ENA_ADMIN_PHC_TYPE_READLESS) {
+	/* Supporting only PHC V0 (readless mode with error bound) */
+	if (get_feat_resp.u.phc.version != ENA_ADMIN_PHC_FEATURE_VERSION_0) {
 		netdev_err(ena_dev->net_device,
-			   "Unsupported PHC type, error: %d\n",
+			   "Unsupported PHC version (0x%X), error: %d\n",
+			   get_feat_resp.u.phc.version,
 			   -EOPNOTSUPP);
 		return -EOPNOTSUPP;
 	}
-- 
2.47.3


