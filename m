Return-Path: <netdev+bounces-282641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOA9MpLN8mnOuQEAu9opvQ
	(envelope-from <netdev+bounces-282641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71A49CF5D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 105F030AC8D6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4837FF5F;
	Thu, 30 Apr 2026 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="maB0P+UK"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A33537EE;
	Thu, 30 Apr 2026 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519577; cv=none; b=Y+Z5H3lgL877jcFGKq7hBbOA4FIk3XxBdMOADhJcpxqphbQHLU2kW0YXf1ePPKEnDCfNQ4azyCWGRsTyN0l//pufLZjbfx9ILTjXclPreEJZQFTYfbpuD3DVjN6dfYEZWT/jE6Q8m9O7z3CmVdOD8LqERVLmDkzk3D8RNZjQNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519577; c=relaxed/simple;
	bh=40+iOzLXD3tWyS1IPfiti2phBhJXYA6klN23tZGxVcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR4drMx1c9fkJ2i5+Xob2g5PP4L79HLMuE5/HNhjxR6JiXbR6TBweB1S5SJt54d9xTPzTFaCUdcMl9xH+LDso+QPEsqOTX1bg5tB030lE8gEPC/PdQ4xlJngGoq5C33noxYXiskrTpDexkem69fyZjCnniS7qnQEGZ5aSccksFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=maB0P+UK; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777519576; x=1809055576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdQObmpWdMS62HawkPR43Dq1LTkIjudiZH+uNt0BEZ4=;
  b=maB0P+UKvKNz7470FZ/yqtLEo+ZA+OoIfRQiZg73ohQyKzW/sA34W4vH
   fZndhG2IXykBfde40skqmd7QB51p3+94oo/dq1XkHM73EWWqOCb8hKS+A
   IFUQonDr5SLy2V5pJBzyxD4W+pqBeiMrjANd2yW9/9pVBgi/PvoRSKfbK
   XXPjnyHe6dZXYZuPS/9db0mLKDOPuPTKwKmWmKcFJ1Hb4DOdmy4V7Om6p
   8+07eXFt2KgJ7uhJhxYKtMWlpvq/1Ib8py8KpYiQiuEiR1mEZkaGRrzzN
   VqA4eTZ3qGdCrGUJQj/nLERB7SC5GUuXDtgK/dEzpealCvtcrE99OLkh2
   Q==;
X-CSE-ConnectionGUID: VhRLu7vkRd2lwJnMLvZHiA==
X-CSE-MsgGUID: E97I0dVBSRyqr+2NuotVNA==
X-IronPort-AV: E=Sophos;i="6.23,207,1770595200"; 
   d="scan'208";a="18324232"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:26:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:22372]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.165:2525] with esmtp (Farcaster)
 id af88eeab-5b82-4eda-ba23-69b8a9d94cff; Thu, 30 Apr 2026 03:26:12 +0000 (UTC)
X-Farcaster-Flow-ID: af88eeab-5b82-4eda-ba23-69b8a9d94cff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:26:08 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:26:03 +0000
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
Subject: [PATCH v2 net-next 7/8] net: ena: Add error bound to PHC communication layer
Date: Thu, 30 Apr 2026 03:25:04 +0000
Message-ID: <20260430032507.11586-8-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430032507.11586-1-akiyano@amazon.com>
References: <20260430032507.11586-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 7B71A49CF5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282641-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Extend the ENA PHC communication layer to retrieve error bound from
the device.

Update ena_com_phc_get_timestamp() to retrieve error_bound alongside
timestamps.
Add error handling and statistics for error_bound retrieval failures.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  2 ++
 drivers/net/ethernet/amazon/ena/ena_com.c     | 36 ++++++++++++-------
 drivers/net/ethernet/amazon/ena/ena_com.h     |  5 ++-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  3 ++
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  3 +-
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 14784a0..ce9ba84 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -306,6 +306,8 @@ PHC errors must remain below 1% of all PHC requests to maintain the desired leve
 **phc_err_dv**      | Number of failed get time attempts due to device errors (entering into block state).
 **phc_err_ts**      | Number of failed get time attempts due to timestamp errors (entering into block state),
                     | This occurs if driver exceeded the request limit or device received an invalid timestamp.
+**phc_err_eb**      | Number of failed get time attempts due to error bound errors (entering into block state),
+                    | This occurs if device received an excessively high or invalid error bound.
 =================   ======================================================
 
 PHC timeouts:
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 1549d6e..981e8e4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -45,7 +45,8 @@
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
 #define ENA_PHC_REQ_ID_OFFSET 0xDEAD
-#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP)
+#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP | \
+			     ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND)
 
 /*****************************************************************************/
 /*****************************************************************************/
@@ -1726,7 +1727,7 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	if (phc->expire_timeout_usec > phc->block_timeout_usec)
 		phc->expire_timeout_usec = phc->block_timeout_usec;
 
-	/* Prepare PHC feature command */
+	/* Prepare PHC config feature command */
 	memset(&set_feat_cmd, 0x0, sizeof(set_feat_cmd));
 	set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
 	set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
@@ -1781,7 +1782,8 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 	phc->virt_addr = NULL;
 }
 
-int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp,
+			      u32 *error_bound)
 {
 	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ktime_t zero_system_time = ktime_set(0, 0);
@@ -1825,6 +1827,8 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			 * a PHC error, this occurs if device:
 			 * - exceeded the get time request limit
 			 * - received an invalid timestamp
+			 * - received an excessively high error bound
+			 * - received an invalid error bound
 			 */
 			netdev_err(ena_dev->net_device,
 				   "PHC get time request 0x%x failed (error 0x%x)\n",
@@ -1832,9 +1836,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 				   resp->error_flags);
 			phc->stats.phc_err_ts += !!(resp->error_flags &
 				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+			phc->stats.phc_err_eb += !!(resp->error_flags &
+				ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND);
 		} else {
 			/* Device updated req_id during blocking time
-			 * with valid timestamp
+			 * with valid timestamp and error bound
 			 */
 			phc->stats.phc_exp++;
 		}
@@ -1861,9 +1867,9 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 	/* Stalling until the device updates req_id */
 	while (1) {
 		if (unlikely(ktime_after(ktime_get(), expire_time))) {
-			/* Gave up waiting for updated req_id, PHC enters into
-			 * blocked state until passing blocking time,
-			 * during this time any get PHC timestamp will fail with
+			/* Gave up waiting for updated req_id,
+			 * PHC enters into blocked state until passing blocking
+			 * time, during this time, any request will fail with
 			 * device busy error
 			 */
 			ret = -EBUSY;
@@ -1879,14 +1885,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 		}
 
 		/* req_id was updated by the device which indicates that
-		 * PHC timestamp and error_flags are updated too,
-		 * checking errors before retrieving timestamp
+		 * PHC timestamp, error_bound and error_flags are updated too,
+		 * checking error flags before retrieving timestamp and
+		 * error_bound values
 		 */
 		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
-			/* Retrieved invalid PHC timestamp, PHC enters into
-			 * blocked state until passing blocking time,
-			 * during this time any get PHC timestamp requests
-			 * will fail with device busy error
+			/* Retrieved timestamp or error bound errors,
+			 * PHC enters into blocked state until passing blocking
+			 * time, during this time, any request will fail with
+			 * device busy error
 			 */
 			ret = -EBUSY;
 			break;
@@ -1894,12 +1901,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 
 		/* PHC timestamp value is returned to the caller */
 		*timestamp = resp->timestamp;
+		if (error_bound)
+			*error_bound = resp->error_bound;
 
 		/* Update statistic on valid PHC timestamp retrieval */
 		phc->stats.phc_cnt++;
 
 		/* This indicates PHC state is active */
 		phc->system_time = zero_system_time;
+
 		break;
 	}
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 64df2c4..fcbff1a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -216,6 +216,7 @@ struct ena_com_stats_phc {
 	u64 phc_skp;
 	u64 phc_err_dv;
 	u64 phc_err_ts;
+	u64 phc_err_eb;
 };
 
 struct ena_com_admin_queue {
@@ -462,9 +463,11 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev);
 /* ena_com_phc_get_timestamp - Retrieve PHC timestamp
  * @ena_dev: ENA communication layer struct
  * @timestamp: Retrieved PHC timestamp
+ * @error_bound: maximum possible deviation of the timestamp (nanosecond)
  * @return - 0 on success, negative value on failure
  */
-int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp);
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp,
+			      u32 *error_bound);
 
 /* ena_com_set_mmio_read_mode - Enable/disable the indirect mmio reg read mechanism
  * @ena_dev: ENA communication layer struct
diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.c b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
index 46ed809..db9d184 100644
--- a/drivers/net/ethernet/amazon/ena/ena_debugfs.c
+++ b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
@@ -32,6 +32,9 @@ static int phc_stats_show(struct seq_file *file, void *priv)
 	seq_printf(file,
 		   "phc_err_ts: %llu\n",
 		   adapter->ena_dev->phc.stats.phc_err_ts);
+	seq_printf(file,
+		   "phc_err_eb: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_err_eb);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index c2a3ff1..2bcb5af 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -40,7 +40,8 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 	ptp_read_system_prets(sts);
 
 	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev,
-				       &timestamp_nsec);
+				       &timestamp_nsec,
+				       NULL);
 
 	ptp_read_system_postts(sts);
 
-- 
2.47.3


