Return-Path: <netdev+bounces-303568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id swRyCf7mRGpW2woAu9opvQ
	(envelope-from <netdev+bounces-303568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:07:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E406EBE60
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:07:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303568-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303568-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 089FE308496A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F833FAE00;
	Wed,  1 Jul 2026 10:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D963FADFB
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:02:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900149; cv=none; b=mc4e79UgRdadZ96hn6WuMh1Zy8rF1iCqUKUyH0cua+wpKHkxMSU1Gi13EZ43Pi+rZ/KfG0q3LZsvkVvfMznrCEEel+t5qu7gB0qX73WifLjGTGelgwnqpsn0xSL4NTR21loW82GLDo/Ive5ZsuK+NicOFq/pCR/S4aSxb4GjPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900149; c=relaxed/simple;
	bh=0myb9FKPAIJVLIrwSX4/jWD81ATlH25vIkL/2cWGDik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejHk9ROpvPSI9jVForM04h8saNPFzge7ciQSrirTR08C9SOC4/kw8vrDSIKFecpXEUYi1HnGiMguhEtbi25WmEQh2VDUJibzaNCzDr3qhAO6gJD7kSuoHAgnvmTmnbN8vcmfBeYkC68y/TPqNohQXe/W6zJ66/93iUmjGO+w5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: zesmtpgz4t1782900119tde904cb1
X-QQ-Originating-IP: UoCcLARRbV2i9sllAoNiqb7FTjwtyJ/K5q4phkjXmEs=
Received: from localhost.localdomain ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 18:01:58 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1052235248742976615
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 3/3] net: libwx: support vf per-queue statistics via ethtool -S
Date: Wed,  1 Jul 2026 18:01:45 +0800
Message-Id: <20260701100145.23738-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260701100145.23738-1-mengyuanlou@net-swift.com>
References: <20260701100145.23738-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M9rkkqim1ZkGc3DXH0ROEkI/0BnLz18hT6NhB2cJfm1+70vcr62MCKGB
	rmjUO/fcfCUHP9Ai+wdqVYdgdU2GpYV24OqGw1brXeks6F7GMNdBcj8wG4bxcn0QTzVo1KX
	OtUPhTnDtNszYmA2QhFitzVCSMTqNuJ+i4xv+9DjW0ise3c1Vh0IlufpRnmYpu1JBCGMxuy
	00aJFgkJvCvZCgVp46sBBPRmPlIIykYRMVOa/6hWzPVb7oRTcPWWYWhdO7r1mzKcwGvxMQS
	2XFMAVgsUB8ibl4Agsbpfc/Zg3EBleEMoqdQ4KRLEavHWnAuozU0IZ0BLd10ZwAh5Vwjotl
	MmjISKICfeQai2Z7LofQRIaGnQUhjR9/gtagNIw9JBDNn/ojRoMWgw9D2gFP0kzEob3RoBS
	FLv0kg5VQFodJykfK32srg2N7hFV6CutT5cN/3o1E4ilVv9omHCd/DOiSk5enyqUCBTXS8T
	od6VI8gNgMJlhnF/30TdmJUYOJyC66FK7irj21rLcWNOPpBXS/pxH00ZHvuxEcwLkjnmy19
	K1VZ3AJ+iFVlzHQtMLSdJva8R7dddH2sgW61QMPo3FMFQZi26F7RLtXxjS5jC3FXgl1vZbU
	jxyCfN4p5XDEoc9d4ddbr8rvKRAxIYcvnVl9ahO141ePmL9+EI3LR4jSbv9ssj8GZ7IIcnE
	l4VKbPL/mHM8dhEstVZKy9r+ginski/CvdUuh7LoAi91He7YjH5MFfFdDnJPBF3+cLga7lZ
	RBYYVlIMUVHkLt+ZgybPrsKOYMRSEzloo5cfUOxN2qXOvngrEuEBvoD45+SZOZIRNoeYJmD
	xRWxspkwYZuOGTN129ySr94qyGpUePIf1DEFTciXKD72vP1XBrY05X77D3i6TEv/0fFNow2
	dyf+sTGV7m3FEjpC8hJLM4wE95P2cgKA30RFxhMPYSSddiocBybeucFk1wwxEDtrY4IfIqd
	aNzPDCN9jgxQQcj+0ApcjOYsAes8gD89mWkKkjjoxCUk1RI1wQvWVIQ2cNBOTU1S/agLTYg
	htz9UBo0uUs5fti5YMAk/3oSa83NVFQ2W7qtDH5rnqQxx6kEV6La/il6HiO6zuUhbrksOB4
	XtX5DAx0eG2A1wlE2rVwf0CPV+N6W7afhEDgDBHtURcaKdV5ee3EwxTMCsVoRDzhZqrhnXi
	HPFks8QgjHNVURA61bXhUzxCGJxL4HPXCWxJ8Mok5A3kJf+bt0JOfdes2Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303568-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,net-swift.com:email,net-swift.com:mid,net-swift.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93E406EBE60

Add per-queue TX/RX packet and byte counters to the VF ethtool stats
table.
Convert WX_NUM_{RX,TX}_QUEUES macros to take explicit netdev parameter.
Then replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with
type-safe static helpers wx_global_stats_len() and wx_stats_len().
The stats length is now dynamically determined based on whether the
device is a VF or PF via wx_stats_len().
Add ring access protection in wx_update_stats.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 71 +++++++++++++------
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  8 +++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
 3 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 22037f015ded..f72908630ea4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
+static const struct wx_stats wx_gstrings_stats_vf[] = {
+	WX_STAT("non_eop_descs", non_eop_descs),
+};
+
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_match", stats.fdirmatch),
 	WX_STAT("fdir_miss", stats.fdirmiss),
@@ -63,21 +67,33 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
  * used because we do not have a good way to get the max number of
  * rx queues with CONFIG_RPS disabled.
  */
-#define WX_NUM_RX_QUEUES netdev->num_tx_queues
-#define WX_NUM_TX_QUEUES netdev->num_tx_queues
-
-#define WX_QUEUE_STATS_LEN ( \
-		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
-		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_NUM_RX_QUEUES(netdev) ((netdev)->num_tx_queues)
+#define WX_NUM_TX_QUEUES(netdev) ((netdev)->num_tx_queues)
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
-#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
+
+static unsigned int wx_global_stats_len(const struct wx *wx)
+{
+	return wx->pdev->is_virtfn ?
+	       ARRAY_SIZE(wx_gstrings_stats_vf) : ARRAY_SIZE(wx_gstrings_stats);
+}
+
+static unsigned int wx_stats_len(const struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	unsigned int queue_stats_len;
+
+	queue_stats_len = (WX_NUM_TX_QUEUES(netdev) +
+			   WX_NUM_RX_QUEUES(netdev)) *
+			  (sizeof(struct wx_queue_stats) / sizeof(u64));
+
+	return wx_global_stats_len(wx) + queue_stats_len;
+}
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
 	struct wx *wx = netdev_priv(netdev);
-	int len = WX_STATS_LEN;
+	int len = wx_stats_len(wx);
 
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -100,8 +116,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+		for (i = 0; i < wx_global_stats_len(wx); i++)
+			if (wx->pdev->is_virtfn)
+				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
+			else
+				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
@@ -114,7 +133,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
 		}
-		for (i = 0; i < WX_NUM_RX_QUEUES; i++) {
+		for (i = 0; i < WX_NUM_RX_QUEUES(netdev); i++) {
 			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
 		}
@@ -134,10 +153,16 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 
 	wx_update_stats(wx);
 
-	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
-		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
-		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+	for (i = 0; i < wx_global_stats_len(wx); i++) {
+		if (wx->pdev->is_virtfn) {
+			p = (char *)wx + wx_gstrings_stats_vf[i].stat_offset;
+			data[i] = (wx_gstrings_stats_vf[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		} else {
+			p = (char *)wx + wx_gstrings_stats[i].stat_offset;
+			data[i] = (wx_gstrings_stats[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
 	}
 
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
@@ -169,7 +194,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
-	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
+	for (j = 0; j < WX_NUM_RX_QUEUES(netdev); j++) {
 		ring = wx->rx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
@@ -219,19 +244,20 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = wx_stats_len(wx);
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
-	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES) {
+	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES(netdev)) {
 		info->n_stats = stats_len -
-				   (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
-				   (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
+				(WX_NUM_TX_QUEUES(netdev) - wx->num_tx_queues) *
+				(sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
 	} else {
 		info->n_stats = stats_len;
 	}
@@ -852,6 +878,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..349afbe60132 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2886,6 +2886,8 @@ void wx_update_stats(struct wx *wx)
 	for (i = 0; i < wx->num_rx_queues; i++) {
 		struct wx_ring *rx_ring = wx->rx_ring[i];
 
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
 		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
@@ -2911,12 +2913,17 @@ void wx_update_stats(struct wx *wx)
 	for (i = 0; i < wx->num_tx_queues; i++) {
 		struct wx_ring *tx_ring = wx->tx_ring[i];
 
+		if (!tx_ring)
+			continue;
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
 	}
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	if (wx->pdev->is_virtfn)
+		goto skip_hw_stats;
+
 	wx_update_xoff_rx_lfc(wx);
 
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
@@ -2956,6 +2963,7 @@ void wx_update_stats(struct wx *wx)
 		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
 					    &wx->last_stats.qmprc[i]);
 
+skip_hw_stats:
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..1d84fe35d7d9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -409,6 +410,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
-- 
2.30.1


