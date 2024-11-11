Return-Path: <netdev+bounces-143645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B099C3782
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54242281661
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C813F9C5;
	Mon, 11 Nov 2024 04:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B11EC5;
	Mon, 11 Nov 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299547; cv=none; b=AD3E56Pl9uKso8iC4aOehuBxjHpKO4NVB5rdcNZXGAa9nG9tpIlcWba7pBYoPTPZOMrz8QYQ75tW2Y8YQwfKQqlHfjzK/qs7/8tHWTOqcyBm/J0xvEztWz5L/RL84mIzDtxnIqcTXwfbBwZ5f2qPIbJh8x9ghotmCSttpd2I3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299547; c=relaxed/simple;
	bh=+bEwcUGfC3Kt5K5pJyllFNbCpdJvsEcyVMhOF7XqMTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpxi/vHJKl7suTjp4GGQc3yfWk0AWr6wZtc7+cWVdzMqgVBXYuEWBH6A8S4pGnG7T2aIyB9NLyCOLbBtIQlXzCyhBYyXQmZOiIlAmJ+enUbEUv4+hcljVzybyp/59rkyR8dPRu7ewrI3wahy/bh65qTEFmMyeyA1iPs1gdqBL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1tAM67-0003Kg-7X; Mon, 11 Nov 2024 04:32:19 +0000
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
	Lee Trager <lee@trager.us>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] eth: fbnic: Add mailbox support for PLDM updates
Date: Sun, 10 Nov 2024 20:28:41 -0800
Message-ID: <20241111043058.1251632-2-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241111043058.1251632-1-lee@trager.us>
References: <20241111043058.1251632-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds driver support to utilize the kernel completion API. This allows
the driver to block on a response from firmware. Initially
fbnic_fw_completion only has support for updates, future patches will add
additional features.

Signed-off-by: Lee Trager <lee@trager.us>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 263 +++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  64 ++++-
 2 files changed, 323 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 8f7a2a19ddf8..d46afc38b4a5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -207,6 +207,38 @@ static int fbnic_mbx_map_tlv_msg(struct fbnic_dev *fbd,
 	return err;
 }

+static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
+				    struct fbnic_tlv_msg *msg,
+				    struct fbnic_fw_completion *cmpl_data)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+
+	/* If we are already waiting on a completion then abort */
+	if (cmpl_data && fbd->cmpl_data) {
+		err = -EBUSY;
+		goto unlock_mbx;
+	}
+
+	/* Record completion location and submit request */
+	if (cmpl_data)
+		fbd->cmpl_data = cmpl_data;
+
+	err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_TX_IDX, msg,
+				le16_to_cpu(msg->hdr.len) * sizeof(u32), 1);
+
+	/* If msg failed then clear completion data for next caller */
+	if (err && cmpl_data)
+		fbd->cmpl_data = NULL;
+
+unlock_mbx:
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+
+	return err;
+}
+
 static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
@@ -651,6 +683,225 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
 }

+/**
+ * fbnic_fw_xmit_fw_start_upgrade - Create and transmit a start update message
+ * @fbd: FBNIC device structure
+ * @cmpl_data: Completion data for upgrade process
+ * @id: Component ID
+ * @len: Length of FW update package data
+ *
+ * Return: zero on success, negative value on failure
+ *
+ * Asks the FW to prepare for starting a firmware upgrade
+ */
+int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
+				   struct fbnic_fw_completion *cmpl_data,
+				   unsigned int id, unsigned int len)
+{
+	struct fbnic_tlv_msg *msg;
+	int err;
+
+	if (!len)
+		return -EINVAL;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_START_UPGRADE_SECTION, id);
+	if (err)
+		goto free_message;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_START_UPGRADE_IMAGE_LENGTH,
+				     len);
+	if (err)
+		goto free_message;
+
+	err = fbnic_mbx_map_req_w_cmpl(fbd, msg, cmpl_data);
+	if (err)
+		goto free_message;
+
+	return 0;
+
+free_message:
+	free_page((unsigned long)msg);
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_fw_start_upgrade_resp_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_START_UPGRADE_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_fw_start_upgrade_resp(void *opaque,
+						struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	int err = 0;
+
+	/* Verify we have a completion pointer */
+	cmpl_data = READ_ONCE(fbd->cmpl_data);
+	if (!cmpl_data ||
+	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ)
+		return -ENOSPC;
+
+	/* Check for errors */
+	get_signed_result(FBNIC_FW_START_UPGRADE_ERROR, err);
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+
+	return 0;
+}
+
+static const struct fbnic_tlv_index fbnic_fw_write_chunk_req_index[] = {
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_WRITE_CHUNK_OFFSET),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_WRITE_CHUNK_LENGTH),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_fw_write_chunk_req(void *opaque,
+					     struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	u32 length = 0, offset = 0;
+	struct fbnic_tlv_msg *msg;
+	int err;
+
+	/* Start by attempting to allocate a response to the message */
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Verify we have a completion pointer */
+	cmpl_data = READ_ONCE(fbd->cmpl_data);
+	if (!cmpl_data ||
+	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ) {
+		err = -ENOSPC;
+		goto msg_err;
+	}
+
+	/* Notify FW if the data link has been severed */
+	if (!cmpl_data->fw_update.data) {
+		err = -ECANCELED;
+		goto msg_err;
+	}
+
+	/* Pull length/offset pair and mark it as complete */
+	get_unsigned_result(FBNIC_FW_WRITE_CHUNK_OFFSET, offset);
+	get_unsigned_result(FBNIC_FW_WRITE_CHUNK_LENGTH, length);
+
+	/* Record offset and length for the response */
+	if (offset) {
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_OFFSET,
+					     offset);
+		if (err)
+			goto msg_err;
+	}
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_LENGTH,
+				     length);
+	if (err)
+		goto msg_err;
+
+	/* Verify length */
+	if (!length || length > TLV_MAX_DATA) {
+		err = -EINVAL;
+		goto msg_err;
+	}
+
+	/* Verify offset and length are within bounds */
+	if (offset >= cmpl_data->fw_update.size ||
+	    offset + length > cmpl_data->fw_update.size) {
+		err = -EFAULT;
+		goto msg_err;
+	}
+
+	/* Add outbound data to message */
+	err = fbnic_tlv_attr_put_value(msg, FBNIC_FW_WRITE_CHUNK_DATA,
+				       cmpl_data->fw_update.data + offset,
+				       length);
+
+	/* Notify the waiting thread that we processed a message */
+	if (!err)
+		cmpl_data->fw_update.last_offset = offset;
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+
+msg_err:
+	/* Report error to FW if one occurred */
+	if (err)
+		fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_ERROR, err);
+
+	/* Map and send the response */
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		free_page((unsigned long)msg);
+
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_fw_verify_image_resp_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_VERIFY_IMAGE_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_fw_verify_image_resp(void *opaque,
+					       struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	int err = 0;
+
+	/* Verify we have a completion pointer */
+	cmpl_data = READ_ONCE(fbd->cmpl_data);
+	if (!cmpl_data ||
+	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_RESP)
+		return -ENOSPC;
+
+	/* Check for errors */
+	get_signed_result(FBNIC_FW_VERIFY_IMAGE_ERROR, err);
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_fw_finish_upgrade_req_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_FINISH_UPGRADE_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_fw_finish_upgrade_req(void *opaque,
+						struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	int err = 0;
+
+	/* Verify we have a completion pointer */
+	cmpl_data = READ_ONCE(fbd->cmpl_data);
+	if (!cmpl_data ||
+	    cmpl_data->msg_type != FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ)
+		return -ENOSPC;
+
+	/* Check for errors */
+	get_signed_result(FBNIC_FW_FINISH_UPGRADE_ERROR, err);
+
+	/* Close out update by clearing data pointer */
+	cmpl_data->fw_update.last_offset = cmpl_data->fw_update.size;
+	cmpl_data->fw_update.data = NULL;
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+
+	return 0;
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
 			 fbnic_fw_parse_cap_resp),
@@ -658,6 +909,18 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 			 fbnic_fw_parse_ownership_resp),
 	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
 			 fbnic_fw_parse_heartbeat_resp),
+	FBNIC_TLV_PARSER(FW_START_UPGRADE_RESP,
+			 fbnic_fw_start_upgrade_resp_index,
+			 fbnic_fw_parse_fw_start_upgrade_resp),
+	FBNIC_TLV_PARSER(FW_WRITE_CHUNK_REQ,
+			 fbnic_fw_write_chunk_req_index,
+			 fbnic_fw_parse_fw_write_chunk_req),
+	FBNIC_TLV_PARSER(FW_VERIFY_IMAGE_RESP,
+			 fbnic_fw_verify_image_resp_index,
+			 fbnic_fw_parse_fw_verify_image_resp),
+	FBNIC_TLV_PARSER(FW_FINISH_UPGRADE_REQ,
+			 fbnic_fw_finish_upgrade_req_index,
+			 fbnic_fw_parse_fw_finish_upgrade_req),
 	FBNIC_TLV_MSG_ERROR
 };

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 7cd8841920e4..347e60fee551 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -45,10 +45,20 @@ struct fbnic_fw_cap {
 };

 struct fbnic_fw_completion {
-	struct {
-		s32 millivolts;
-		s32 millidegrees;
-	} tsene;
+	u32 msg_type;
+	struct completion done;
+	int result;
+	union {
+		struct {
+			u32 size;
+			u32 last_offset;
+			const u8 *data;
+		} fw_update;
+		struct {
+			s32 millivolts;
+			s32 millidegrees;
+		} tsene;
+	};
 };

 void fbnic_mbx_init(struct fbnic_dev *fbd);
@@ -59,6 +69,9 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
+				   struct fbnic_fw_completion *cmpl_data,
+				   unsigned int id, unsigned int len);

 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
 do {									\
@@ -74,6 +87,15 @@ do {									\
 #define fbnic_mk_fw_ver_str(_rev_id, _str) \
 	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))

+enum {
+	QSPI_SECTION_CMRT			= 0,
+	QSPI_SECTION_CONTROL_FW			= 1,
+	QSPI_SECTION_UCODE			= 2,
+	QSPI_SECTION_OPTION_ROM			= 3,
+	QSPI_SECTION_USER			= 4,
+	QSPI_SECTION_INVALID,
+};
+
 #define FW_HEARTBEAT_PERIOD		(10 * HZ)

 enum {
@@ -83,6 +105,14 @@ enum {
 	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ		= 0x22,
+	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_RESP		= 0x23,
+	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ		= 0x24,
+	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP		= 0x25,
+	FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_REQ		= 0x26,
+	FBNIC_TLV_MSG_ID_FW_VERIFY_IMAGE_RESP		= 0x27,
+	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_REQ		= 0x28,
+	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_RESP		= 0x29,
 };

 #define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
@@ -128,4 +158,30 @@ enum {
 	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
 	FBNIC_FW_OWNERSHIP_MSG_MAX
 };
+
+enum {
+	FBNIC_FW_START_UPGRADE_ERROR		= 0x0,
+	FBNIC_FW_START_UPGRADE_SECTION		= 0x1,
+	FBNIC_FW_START_UPGRADE_IMAGE_LENGTH	= 0x2,
+	FBNIC_FW_START_UPGRADE_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_WRITE_CHUNK_OFFSET		= 0x0,
+	FBNIC_FW_WRITE_CHUNK_LENGTH		= 0x1,
+	FBNIC_FW_WRITE_CHUNK_DATA		= 0x2,
+	FBNIC_FW_WRITE_CHUNK_ERROR		= 0x3,
+	FBNIC_FW_WRITE_CHUNK_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_VERIFY_IMAGE_ERROR		= 0x0,
+	FBNIC_FW_VERIFY_IMAGE_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_FINISH_UPGRADE_ERROR		= 0x0,
+	FBNIC_FW_FINISH_UPGRADE_MSG_MAX
+};
+
 #endif /* _FBNIC_FW_H_ */
--
2.43.5

