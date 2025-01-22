Return-Path: <netdev+bounces-160246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF0A18F98
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6B7A2248
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79ED21128A;
	Wed, 22 Jan 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DHDb2RDr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61B20F970
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541287; cv=none; b=JUpnfMuFLg1G92AfHTVMRZcekeBGcTZioA4ryhE27NTR7o6kqJALWy1VLeMeVKwRhaDHuqt9Nu4SUOMBNQY6/5KnRzo4apUUn+Pf9c7z3y9JXfjbJBMxzAtV51A9aoZ2UlZHhmfOAFii+d9UuQdy47IhX6ZE1F4YBdB6VvexVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541287; c=relaxed/simple;
	bh=ghm5N8r/3NFY3VhcvBSd9wCKwdbaoxidYfYf+OuLK0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXS5SW2j13M3bJHMVg3IzdJff5d/fY/Lw4i7N1W9uKiphXLGGF6xa+m86ZUBV1YXFDmYjsdjooUgXZyVqzp/wi3SVl0prJMHVdYbURcUzsP9ghit/orOAG9wUUquC1WFzo5nGsd7yT9BovKBTbyRKnN9WGofyKwHBgMPGNFCzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DHDb2RDr; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737541285; x=1769077285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJKqF5mOvHlnd2aM86X0/KYqMuPdq09hyHDBIDf8KWU=;
  b=DHDb2RDrs/q+gLT51B4qxgDu7Dcf1YQf+eRvJ3oVF+xiPsn4LPVG18FD
   FId7VIriog9ufwOYZ3rjh7qpZYlrLO6ip4vP4do0t54jhFjRYy4nlBFWF
   9nP7JtdUZquzax0Fd9v/f6SbFciMDGJPGqljWIn4QguQYKORjPB6pfkSW
   o=;
X-IronPort-AV: E=Sophos;i="6.13,224,1732579200"; 
   d="scan'208";a="465934554"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 10:21:22 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:17429]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.91.109:2525] with esmtp (Farcaster)
 id c81696e0-4133-4432-9eed-004b16d1fa9e; Wed, 22 Jan 2025 10:21:22 +0000 (UTC)
X-Farcaster-Flow-ID: c81696e0-4133-4432-9eed-004b16d1fa9e
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:14 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:14 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 10:21:14 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id DB6B9404A2;
	Wed, 22 Jan 2025 10:21:07 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v5 net-next 4/5] net: ena: PHC error bound/flags support
Date: Wed, 22 Jan 2025 12:20:39 +0200
Message-ID: <20250122102040.752-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>
References: <20250122102040.752-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

PHC algorithm is updated to support reading new PHC values.
Until this change, the driver retrieved PHC timestamp from the device's
PHC address, this change expands this API by adding 2 new values
to ena_admin_phc_resp:
1. PHC error bound:
   PTP HW clock error bound refers to the maximum allowable difference
   between the clock of the device and the reference clock.
   The error bound is used to ensure that the clock of the device
   remains within a certain level of accuracy relative to the reference
   clock. The error bound (expressed in nanoseconds) is calculated by
   the device, taking into account the accuracy of the PTA device,
   march hare network, TOR, Chrony, Pacemaker and ENA driver read delay.
   Error bound (u32) may contain values of 0-4294967295 (nsec) while
   driver may only report values of 0-4294967294 (nsec) because max
   error bound value (4294967295) will be used to represent error bound
   read error. The error bound value is retrieved from the device by the
   driver upon every get PHC timestamp request and is cached for future
   retrieval by the user.
2. PHC error flags:
   Indicates any PHC timestamp and error bound errors.
   The error flags value is retrieved from the device by the driver upon
   every get PHC timestamp request.
   Any PHC error type will:
   1. Enter the PHC into blocked state until passing blocking time
   2. Return device busy error to timestamp caller
   3. Return device busy error to error bound caller

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    | 15 +++-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  | 28 +++++--
 drivers/net/ethernet/amazon/ena/ena_com.c     | 83 +++++++++++++------
 drivers/net/ethernet/amazon/ena/ena_com.h     | 16 +++-
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  3 +-
 5 files changed, 107 insertions(+), 38 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 12b13da0..19697f63 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -279,6 +279,16 @@ The ENA device restricts the frequency of PHC get time requests to a maximum
 of 125 requests per second. If this limit is surpassed, the get time request
 will fail, leading to an increment in the phc_err statistic.
 
+**PHC error bound**
+
+PTP HW clock error bound refers to the maximum allowable difference
+between the clock of the device and the reference clock.
+The error bound is used to ensure that the clock of the device
+remains within a certain level of accuracy relative to the reference
+clock. The error bound (expressed in nanoseconds) is calculated by
+the device and is retrieved and cached by the driver upon every get PHC
+timestamp request.
+
 **PHC statistics**
 
 PHC can be monitored using :code:`ethtool -S` counters:
@@ -287,7 +297,10 @@ PHC can be monitored using :code:`ethtool -S` counters:
 **phc_cnt**         Number of successful retrieved timestamps (below expire timeout).
 **phc_exp**         Number of expired retrieved timestamps (above expire timeout).
 **phc_skp**         Number of skipped get time attempts (during block period).
-**phc_err**         Number of failed get time attempts (entering into block state).
+**phc_err**         Number of failed get time attempts due to timestamp/error bound errors
+                    (entering into block state).
+                    Must remain below 1% of all PHC requests to maintain the desired level of
+                    accuracy and reliability.
 =================   ======================================================
 
 PHC timeouts:
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 28770e60..de5c28f5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -128,8 +128,14 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
-enum ena_admin_phc_type {
-	ENA_ADMIN_PHC_TYPE_READLESS                 = 0,
+enum ena_admin_phc_feature_version {
+	/* Readless with error_bound */
+	ENA_ADMIN_PHC_FEATURE_VERSION_0             = 0,
+};
+
+enum ena_admin_phc_error_flags {
+	ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP   = BIT(0),
+	ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND = BIT(1),
 };
 
 /* ENA SRD configuration for ENI */
@@ -1031,10 +1037,10 @@ struct ena_admin_queue_ext_feature_desc {
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
@@ -1212,13 +1218,23 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 };
 
 struct ena_admin_phc_resp {
+	/* Request Id, received from DB register */
 	u16 req_id;
 
 	u8 reserved1[6];
 
+	/* PHC timestamp (nsec) */
 	u64 timestamp;
 
-	u8 reserved2[48];
+	u8 reserved2[8];
+
+	/* Timestamp error limit (nsec) */
+	u32 error_bound;
+
+	/* Bit field of enum ena_admin_phc_error_flags */
+	u32 error_flags;
+
+	u8 reserved3[32];
 };
 
 /* aq_common_desc */
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index c6b9939e..66b1ab92 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -44,8 +44,10 @@
 /* PHC definitions */
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
-#define ENA_PHC_TIMESTAMP_ERROR 0xFFFFFFFFFFFFFFFF
+#define ENA_PHC_MAX_ERROR_BOUND 0xFFFFFFFF
 #define ENA_PHC_REQ_ID_OFFSET 0xDEAD
+#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP | \
+			     ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND)
 
 /*****************************************************************************/
 /*****************************************************************************/
@@ -1682,11 +1684,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
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
@@ -1694,10 +1696,10 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 		return ret;
 	}
 
-	/* Supporting only readless PHC retrieval */
-	if (get_feat_resp.u.phc.type != ENA_ADMIN_PHC_TYPE_READLESS) {
-		netdev_err(ena_dev->net_device, "Unsupported PHC type, error: %d\n",
-			   -EOPNOTSUPP);
+	/* Supporting only PHC V0 (readless mode with error bound) */
+	if (get_feat_resp.u.phc.version != ENA_ADMIN_PHC_FEATURE_VERSION_0) {
+		netdev_err(ena_dev->net_device, "Unsupported PHC version (0x%X), error: %d\n",
+			   get_feat_resp.u.phc.version, -EOPNOTSUPP);
 		return -EOPNOTSUPP;
 	}
 
@@ -1720,7 +1722,7 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 				   get_feat_resp.u.phc.block_timeout_usec :
 				   ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC;
 
-	/* Sanity check - expire timeout must not be above skip timeout */
+	/* Sanity check - expire timeout must not exceed block timeout */
 	if (phc->expire_timeout_usec > phc->block_timeout_usec)
 		phc->expire_timeout_usec = phc->block_timeout_usec;
 
@@ -1778,7 +1780,7 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 	phc->virt_addr = NULL;
 }
 
-int ena_com_phc_get(struct ena_com_dev *ena_dev, u64 *timestamp)
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 {
 	volatile struct ena_admin_phc_resp *read_resp = ena_dev->phc.virt_addr;
 	const ktime_t zero_system_time = ktime_set(0, 0);
@@ -1806,14 +1808,13 @@ int ena_com_phc_get(struct ena_com_dev *ena_dev, u64 *timestamp)
 			goto skip;
 		}
 
-		/* PHC is in active state, update statistics according to
-		 * req_id and timestamp
+		/* PHC is in active state, update statistics according
+		 * to req_id and error_flags
 		 */
 		if ((READ_ONCE(read_resp->req_id) != phc->req_id) ||
-		    read_resp->timestamp == ENA_PHC_TIMESTAMP_ERROR)
-			/* Device didn't update req_id during blocking time
-			 * or timestamp is invalid, this indicates on a
-			 * device error
+		    (read_resp->error_flags & ENA_PHC_ERROR_FLAGS))
+			/* Device didn't update req_id during blocking time or
+			 * timestamp is invalid, this indicates on a device error
 			 */
 			phc->stats.phc_err++;
 		else
@@ -1845,36 +1846,46 @@ int ena_com_phc_get(struct ena_com_dev *ena_dev, u64 *timestamp)
 	while (1) {
 		if (unlikely(ktime_after(ktime_get(), expire_time))) {
 			/* Gave up waiting for updated req_id,
-			 * PHC enters into blocked state until passing
-			 * blocking time
+			 * PHC enters into blocked state until passing blocking time,
+			 * during this time any get PHC timestamp or error bound
+			 * requests will fail with device busy error
 			 */
+			phc->error_bound = ENA_PHC_MAX_ERROR_BOUND;
 			ret = -EBUSY;
 			break;
 		}
 
 		/* Check if req_id was updated by the device */
 		if (READ_ONCE(read_resp->req_id) != phc->req_id) {
-			/* req_id was not updated by the device,
+			/* req_id was not updated by the device yet,
 			 * check again on next loop
 			 */
 			continue;
 		}
 
-		/* req_id was updated which indicates that PHC timestamp
-		 * was updated too
+		/* req_id was updated by the device which indicates that
+		 * PHC timestamp, error_bound and error_flags are updated too,
+		 * checking errors before retrieving timestamp and
+		 * error_bound values
 		 */
-		*timestamp = read_resp->timestamp;
-
-		/* PHC timestamp validty check */
-		if (unlikely(*timestamp == ENA_PHC_TIMESTAMP_ERROR)) {
-			/* Retrieved invalid PHC timestamp, PHC enters into
-			 * blocked state until passing blocking time
+		if (unlikely(read_resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
+			/* Retrieved timestamp or error bound errors,
+			 * PHC enters into blocked state until passing blocking time,
+			 * during this time any get PHC timestamp or error bound
+			 * requests will fail with device busy error
 			 */
+			phc->error_bound = ENA_PHC_MAX_ERROR_BOUND;
 			ret = -EBUSY;
 			break;
 		}
 
-		/* Retrieved valid PHC timestamp */
+		/* PHC timestamp value is returned to the caller */
+		*timestamp = read_resp->timestamp;
+
+		/* Error bound value is cached for future retrieval by caller */
+		phc->error_bound = read_resp->error_bound;
+
+		/* Update statistic on valid PHC timestamp retrieval */
 		phc->stats.phc_cnt++;
 
 		/* This indicates PHC state is active */
@@ -1888,6 +1899,24 @@ skip:
 	return ret;
 }
 
+int ena_com_phc_get_error_bound(struct ena_com_dev *ena_dev, u32 *error_bound)
+{
+	struct ena_com_phc_info *phc = &ena_dev->phc;
+	u32 local_error_bound = phc->error_bound;
+
+	if (!phc->active) {
+		netdev_err(ena_dev->net_device, "PHC feature is not active in the device\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (local_error_bound == ENA_PHC_MAX_ERROR_BOUND)
+		return -EBUSY;
+
+	*error_bound = local_error_bound;
+
+	return 0;
+}
+
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 3905d348..8df63eef 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -299,6 +299,9 @@ struct ena_com_phc_info {
 	/* PHC shared memory - physical address */
 	dma_addr_t phys_addr;
 
+	/* Cached error bound per timestamp sample */
+	u32 error_bound;
+
 	/* Request id sent to the device */
 	u16 req_id;
 
@@ -458,12 +461,19 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev);
  */
 void ena_com_phc_destroy(struct ena_com_dev *ena_dev);
 
-/* ena_com_phc_get - Retrieve PHC timestamp
+/* ena_com_phc_get_timestamp - Retrieve PHC timestamp
+ * @ena_dev: ENA communication layer struct
+ * @timestamp: Retrieved PHC timestamp
+ * @return - 0 on success, negative value on failure
+ */
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp);
+
+/* ena_com_phc_get_error_bound - Retrieve cached PHC error bound
  * @ena_dev: ENA communication layer struct
- * @timestamp: Retrieve PHC timestamp
+ * @error_bound: Cached PHC error bound
  * @return - 0 on success, negative value on failure
  */
-int ena_com_phc_get(struct ena_com_dev *ena_dev, u64 *timestamp);
+int ena_com_phc_get_error_bound(struct ena_com_dev *ena_dev, u32 *error_bound);
 
 /* ena_com_set_mmio_read_mode - Enable/disable the indirect mmio reg read mechanism
  * @ena_dev: ENA communication layer struct
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 5c1acd88..5ce9a32d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -38,7 +38,8 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 
 	ptp_read_system_prets(sts);
 
-	rc = ena_com_phc_get(phc_info->adapter->ena_dev, &timestamp_nsec);
+	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev,
+				       &timestamp_nsec);
 
 	ptp_read_system_postts(sts);
 
-- 
2.40.1


