Return-Path: <netdev+bounces-189420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E13AB2087
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7227524B02
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230D132103;
	Sat, 10 May 2025 00:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896F770FE;
	Sat, 10 May 2025 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837465; cv=none; b=qMGEbI8VqeCyGp5Al3i0atLYFmBKgXDL/uZrv4ZEq21Y3RhTf1kroExJ9cY7+KoneZHYmRMxSgdQ9Wg5dk07zgL649n1Y0u5ajAjLfEzYfkOz4OI4OoFvf1i9hbaj3czPiUV9tF6CMr/hgFPcvRvbMhuStaesrhxluO1ZGH2Rnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837465; c=relaxed/simple;
	bh=FKBvSqEuIPMi/j7x5ujJpwLCTvajPvDsaCnTTdQRYS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRsz6UcT5AZBUXpnBCObewe8DzUWCqOmrF7IgoClO/6XjGcIl+wPNj3ALS9IIUd0jm0HTWM61SCg89AWfa7CnaGlQjOBgtXEOy+MnpELLaP3FQhG/+tHFZ/R0WWWd5nf0vqXokXEIx7HcG+Nue+N5cNsqNtJHAkZn1zDUv0cVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uDYDd-0002Em-HB; Sat, 10 May 2025 00:37:33 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Lee Trager <lee@trager.us>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/5] eth: fbnic: Add support for multiple concurrent completion messages
Date: Fri,  9 May 2025 17:21:15 -0700
Message-ID: <20250510002851.3247880-4-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250510002851.3247880-1-lee@trager.us>
References: <20250510002851.3247880-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend fbnic mailbox to support multiple concurrent completion messages at
once. This enables fbnic to support running multiple operations at once
which depend on a response from firmware via the mailbox.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h     |  3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 99 +++++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |  5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |  2 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index ad01ed05d78b..65815d4f379e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -19,6 +19,7 @@
 struct fbnic_napi_vector;

 #define FBNIC_MAX_NAPI_VECTORS		128u
+#define FBNIC_MBX_CMPL_SLOTS		4

 struct fbnic_dev {
 	struct device *dev;
@@ -42,7 +43,7 @@ struct fbnic_dev {

 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
 	struct fbnic_fw_cap fw_cap;
-	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_fw_completion *cmpl_data[FBNIC_MBX_CMPL_SLOTS];
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index e4f72fb730a6..6fcba4e8c21e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -237,6 +237,44 @@ static int fbnic_mbx_map_tlv_msg(struct fbnic_dev *fbd,
 	return err;
 }

+static int fbnic_mbx_set_cmpl_slot(struct fbnic_dev *fbd,
+				   struct fbnic_fw_completion *cmpl_data)
+{
+	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+	int free = -EXFULL;
+	int i;
+
+	if (!tx_mbx->ready)
+		return -ENODEV;
+
+	for (i = 0; i < FBNIC_MBX_CMPL_SLOTS; i++) {
+		if (!fbd->cmpl_data[i])
+			free = i;
+		else if (fbd->cmpl_data[i]->msg_type == cmpl_data->msg_type)
+			return -EEXIST;
+	}
+
+	if (free == -EXFULL)
+		return -EXFULL;
+
+	fbd->cmpl_data[free] = cmpl_data;
+
+	return 0;
+}
+
+static void fbnic_mbx_clear_cmpl_slot(struct fbnic_dev *fbd,
+				      struct fbnic_fw_completion *cmpl_data)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_MBX_CMPL_SLOTS; i++) {
+		if (fbd->cmpl_data[i] == cmpl_data) {
+			fbd->cmpl_data[i] = NULL;
+			break;
+		}
+	}
+}
+
 static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
@@ -258,6 +296,19 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 	tx_mbx->head = head;
 }

+int fbnic_mbx_set_cmpl(struct fbnic_dev *fbd,
+		       struct fbnic_fw_completion *cmpl_data)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+	err = fbnic_mbx_set_cmpl_slot(fbd, cmpl_data);
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+
+	return err;
+}
+
 static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
 				    struct fbnic_tlv_msg *msg,
 				    struct fbnic_fw_completion *cmpl_data)
@@ -266,23 +317,20 @@ static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
 	int err;

 	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
-
-	/* If we are already waiting on a completion then abort */
-	if (cmpl_data && fbd->cmpl_data) {
-		err = -EBUSY;
-		goto unlock_mbx;
+	if (cmpl_data) {
+		err = fbnic_mbx_set_cmpl_slot(fbd, cmpl_data);
+		if (err)
+			goto unlock_mbx;
 	}

-	/* Record completion location and submit request */
-	if (cmpl_data)
-		fbd->cmpl_data = cmpl_data;
-
 	err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_TX_IDX, msg,
 				le16_to_cpu(msg->hdr.len) * sizeof(u32), 1);

-	/* If msg failed then clear completion data for next caller */
+	/* If we successfully reserved a completion and msg failed
+	 * then clear completion data for next caller
+	 */
 	if (err && cmpl_data)
-		fbd->cmpl_data = NULL;
+		fbnic_mbx_clear_cmpl_slot(fbd, cmpl_data);

 unlock_mbx:
 	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
@@ -304,12 +352,18 @@ fbnic_fw_get_cmpl_by_type(struct fbnic_dev *fbd, u32 msg_type)
 {
 	struct fbnic_fw_completion *cmpl_data = NULL;
 	unsigned long flags;
+	int i;

 	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
-	if (fbd->cmpl_data && fbd->cmpl_data->msg_type == msg_type) {
-		cmpl_data = fbd->cmpl_data;
-		kref_get(&fbd->cmpl_data->ref_count);
+	for (i = 0; i < FBNIC_MBX_CMPL_SLOTS; i++) {
+		if (fbd->cmpl_data[i] &&
+		    fbd->cmpl_data[i]->msg_type == msg_type) {
+			cmpl_data = fbd->cmpl_data[i];
+			kref_get(&cmpl_data->ref_count);
+			break;
+		}
 	}
+
 	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);

 	return cmpl_data;
@@ -925,10 +979,16 @@ static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)

 static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
 {
-	if (fbd->cmpl_data) {
-		__fbnic_fw_evict_cmpl(fbd->cmpl_data);
-		fbd->cmpl_data = NULL;
+	int i;
+
+	for (i = 0; i < FBNIC_MBX_CMPL_SLOTS; i++) {
+		struct fbnic_fw_completion *cmpl_data = fbd->cmpl_data[i];
+
+		if (cmpl_data)
+			__fbnic_fw_evict_cmpl(cmpl_data);
 	}
+
+	memset(fbd->cmpl_data, 0, sizeof(fbd->cmpl_data));
 }

 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
@@ -989,12 +1049,13 @@ void fbnic_fw_init_cmpl(struct fbnic_fw_completion *fw_cmpl,
 	kref_init(&fw_cmpl->ref_count);
 }

-void fbnic_fw_clear_compl(struct fbnic_dev *fbd)
+void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
+			 struct fbnic_fw_completion *fw_cmpl)
 {
 	unsigned long flags;

 	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
-	fbd->cmpl_data = NULL;
+	fbnic_mbx_clear_cmpl_slot(fbd, fw_cmpl);
 	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
 }

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 692dfd8746e7..39dec0792090 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -60,6 +60,8 @@ struct fbnic_fw_completion {

 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
+int fbnic_mbx_set_cmpl(struct fbnic_dev *fbd,
+		       struct fbnic_fw_completion *cmpl_data);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
@@ -70,7 +72,8 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
 			u32 msg_type);
-void fbnic_fw_clear_compl(struct fbnic_dev *fbd);
+void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd,
+			 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);

 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index dde4a37116e2..4ba6f8d10775 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -744,7 +744,7 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,

 	*val = *sensor;
 exit_cleanup:
-	fbnic_fw_clear_compl(fbd);
+	fbnic_fw_clear_cmpl(fbd, fw_cmpl);
 exit_free:
 	fbnic_fw_put_cmpl(fw_cmpl);

--
2.47.1

