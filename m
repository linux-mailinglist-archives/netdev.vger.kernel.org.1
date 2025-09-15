Return-Path: <netdev+bounces-223164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24DB5814E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635CB3BDE0F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF2238178;
	Mon, 15 Sep 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZhEJgLR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFC2376F8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951598; cv=none; b=SU5+UFQ5pQkATZSK/jKUvr4jtJaYzJINpkl2/wd0oF89///wzN/cct7O7MS6CgScuWK/XzbZB+1flKow4Z6G9GrYwP7ovfsZDPdsvmOc6lNLpwE6RuqYqmtzUrRWqb39ELEekOyKE1cW44s6p7WLCa4FO3W0oRiSCnJOGmkHnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951598; c=relaxed/simple;
	bh=ABXsMyl+QoWRpW31qz7cK7KGHI4CNZzZbXhvEcluX3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5UlO8nfstr3MM7nB8hyOkCk5y6SdD3cpVzh5hdD4FWCzB+3H4KmeYmAmewZ6zNdETLGDoBrct8S+PsK99IBiINJH1OXaGudH2zEhkS9DqUbknxztMHE6sWBRJ74COoUb2ZGroEyvy+ZGCIWYkzC2EpPsBmFAf3a1B4v2vcw0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZhEJgLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09711C4CEF1;
	Mon, 15 Sep 2025 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951598;
	bh=ABXsMyl+QoWRpW31qz7cK7KGHI4CNZzZbXhvEcluX3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZhEJgLR4D0/1Q4McAu7G9dy+tJSud8qsPMIBCykq1X1HA1sAKNns51QM654seQbb
	 JODEEOANDcgquNEfXIGljURm/Xlln3ttfp9Va4ICj0eclAEEVMhgkFSKJPQz3zEoV2
	 K7riHeom5RmqPCU4u/m1lXIHdRctXBJU1DxPjcA4VGZS1KNgfTYbKRFLrnJO0eW6R/
	 JoyLcw7QQe/swaC6FbYsi9x0TKotiPZtrIA13HtnQcED0PlCR3N9Mt7Gq7DPMiQOzP
	 nP5pbhV9cYxjR6fHUx7b3OkewMFdSP0fGOcx5zCZgYAhh7U77jkEB1mqaMdhTElVC/
	 oign49Xs9CRVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 6/9] eth: fbnic: support FW communication for core dump
Date: Mon, 15 Sep 2025 08:53:09 -0700
Message-ID: <20250915155312.1083292-7-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To read FW core dump we need to issue two commands to FW:
 - first get the FW core dump info
 - second read the dump chunk by chunk

Implement these two FW commands. Subsequent commits will use them
to expose FW dump via devlink heath.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  38 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 214 +++++++++++++++++++++
 2 files changed, 252 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index d4c0fb4c94cc..d776be9fc7f7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -66,6 +66,14 @@ struct fbnic_fw_completion {
 	struct kref ref_count;
 	int result;
 	union {
+		struct {
+			u32 size;
+		} coredump_info;
+		struct {
+			u32 size;
+			u16 stride;
+			u8 *data[];
+		} coredump;
 		struct {
 			u32 offset;
 			u32 length;
@@ -89,6 +97,12 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_coredump_info_msg(struct fbnic_dev *fbd,
+				    struct fbnic_fw_completion *cmpl_data,
+				    bool force);
+int fbnic_fw_xmit_coredump_read_msg(struct fbnic_dev *fbd,
+				    struct fbnic_fw_completion *cmpl_data,
+				    u32 offset, u32 length);
 int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
 				   struct fbnic_fw_completion *cmpl_data,
 				   unsigned int id, unsigned int len);
@@ -137,6 +151,10 @@ enum {
 	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+	FBNIC_TLV_MSG_ID_COREDUMP_GET_INFO_REQ		= 0x18,
+	FBNIC_TLV_MSG_ID_COREDUMP_GET_INFO_RESP		= 0x19,
+	FBNIC_TLV_MSG_ID_COREDUMP_READ_REQ		= 0x20,
+	FBNIC_TLV_MSG_ID_COREDUMP_READ_RESP		= 0x21,
 	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ		= 0x22,
 	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_RESP		= 0x23,
 	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ		= 0x24,
@@ -210,6 +228,26 @@ enum {
 	FBNIC_FW_HEARTBEAT_MSG_MAX
 };
 
+enum {
+	FBNIC_FW_COREDUMP_REQ_INFO_CREATE	= 0x0,
+	FBNIC_FW_COREDUMP_REQ_INFO_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_COREDUMP_INFO_AVAILABLE	= 0x0,
+	FBNIC_FW_COREDUMP_INFO_SIZE		= 0x1,
+	FBNIC_FW_COREDUMP_INFO_ERROR		= 0x2,
+	FBNIC_FW_COREDUMP_INFO_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_COREDUMP_READ_OFFSET		= 0x0,
+	FBNIC_FW_COREDUMP_READ_LENGTH		= 0x1,
+	FBNIC_FW_COREDUMP_READ_DATA		= 0x2,
+	FBNIC_FW_COREDUMP_READ_ERROR		= 0x3,
+	FBNIC_FW_COREDUMP_READ_MSG_MAX
+};
+
 enum {
 	FBNIC_FW_START_UPGRADE_ERROR		= 0x0,
 	FBNIC_FW_START_UPGRADE_SECTION		= 0x1,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 621a574e0b0d..831b6ad6517d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -791,6 +791,215 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
 }
 
+/**
+ * fbnic_fw_xmit_coredump_info_msg - Create and transmit a coredump info message
+ * @fbd: FBNIC device structure
+ * @cmpl_data: Structure to store info in
+ * @force: Force coredump event if one hasn't already occurred
+ *
+ * Return: zero on success, negative errno on failure
+ *
+ * Asks the FW for info related to coredump. If a coredump doesn't exist it
+ * can optionally force one if force is true.
+ */
+int fbnic_fw_xmit_coredump_info_msg(struct fbnic_dev *fbd,
+				    struct fbnic_fw_completion *cmpl_data,
+				    bool force)
+{
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_COREDUMP_GET_INFO_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	if (force) {
+		err = fbnic_tlv_attr_put_flag(msg, FBNIC_FW_COREDUMP_REQ_INFO_CREATE);
+		if (err)
+			goto free_msg;
+	}
+
+	err = fbnic_mbx_map_req_w_cmpl(fbd, msg, cmpl_data);
+	if (err)
+		goto free_msg;
+
+	return 0;
+
+free_msg:
+	free_page((unsigned long)msg);
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_coredump_info_resp_index[] = {
+	FBNIC_TLV_ATTR_FLAG(FBNIC_FW_COREDUMP_INFO_AVAILABLE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_COREDUMP_INFO_SIZE),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_COREDUMP_INFO_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int
+fbnic_fw_parse_coredump_info_resp(void *opaque, struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	u32 msg_type;
+	s32 err;
+
+	/* Verify we have a completion pointer to provide with data */
+	msg_type = FBNIC_TLV_MSG_ID_COREDUMP_GET_INFO_RESP;
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd, msg_type);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	err = fta_get_sint(results, FBNIC_FW_COREDUMP_INFO_ERROR);
+	if (err)
+		goto msg_err;
+
+	if (!results[FBNIC_FW_COREDUMP_INFO_AVAILABLE]) {
+		err = -ENOENT;
+		goto msg_err;
+	}
+
+	cmpl_data->u.coredump_info.size =
+		fta_get_uint(results, FBNIC_FW_COREDUMP_INFO_SIZE);
+
+msg_err:
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return err;
+}
+
+/**
+ * fbnic_fw_xmit_coredump_read_msg - Create and transmit a coredump read request
+ * @fbd: FBNIC device structure
+ * @cmpl_data: Completion struct to store coredump
+ * @offset: Offset into coredump requested
+ * @length: Length of section of cordeump to fetch
+ *
+ * Return: zero on success, negative errno on failure
+ *
+ * Asks the firmware to provide a section of the cordeump back in a message.
+ * The response will have an offset and size matching the values provided.
+ */
+int fbnic_fw_xmit_coredump_read_msg(struct fbnic_dev *fbd,
+				    struct fbnic_fw_completion *cmpl_data,
+				    u32 offset, u32 length)
+{
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_COREDUMP_READ_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	if (offset) {
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_COREDUMP_READ_OFFSET,
+					     offset);
+		if (err)
+			goto free_message;
+	}
+
+	if (length) {
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_COREDUMP_READ_LENGTH,
+					     length);
+		if (err)
+			goto free_message;
+	}
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
+static const struct fbnic_tlv_index fbnic_coredump_resp_index[] = {
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_COREDUMP_READ_OFFSET),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_COREDUMP_READ_LENGTH),
+	FBNIC_TLV_ATTR_RAW_DATA(FBNIC_FW_COREDUMP_READ_DATA),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_COREDUMP_READ_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_coredump_resp(void *opaque,
+					struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	u32 index, last_offset, last_length;
+	struct fbnic_dev *fbd = opaque;
+	struct fbnic_tlv_msg *data_hdr;
+	u32 length, offset;
+	u32 msg_type;
+	s32 err;
+
+	/* Verify we have a completion pointer to provide with data */
+	msg_type = FBNIC_TLV_MSG_ID_COREDUMP_READ_RESP;
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd, msg_type);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	err = fta_get_sint(results, FBNIC_FW_COREDUMP_READ_ERROR);
+	if (err)
+		goto msg_err;
+
+	data_hdr = results[FBNIC_FW_COREDUMP_READ_DATA];
+	if (!data_hdr) {
+		err = -ENODATA;
+		goto msg_err;
+	}
+
+	offset = fta_get_uint(results, FBNIC_FW_COREDUMP_READ_OFFSET);
+	length = fta_get_uint(results, FBNIC_FW_COREDUMP_READ_LENGTH);
+
+	if (length > le16_to_cpu(data_hdr->hdr.len) - sizeof(u32)) {
+		dev_err(fbd->dev, "length greater than size of message\n");
+		err = -EINVAL;
+		goto msg_err;
+	}
+
+	/* Only the last offset can have a length != stride */
+	last_length =
+		(cmpl_data->u.coredump.size % cmpl_data->u.coredump.stride) ? :
+		cmpl_data->u.coredump.stride;
+	last_offset = cmpl_data->u.coredump.size - last_length;
+
+	/* Verify offset and length */
+	if (offset % cmpl_data->u.coredump.stride || offset > last_offset) {
+		dev_err(fbd->dev, "offset %d out of range\n", offset);
+		err = -EINVAL;
+	} else if (length != ((offset == last_offset) ?
+			      last_length : cmpl_data->u.coredump.stride)) {
+		dev_err(fbd->dev, "length %d out of range for offset %d\n",
+			length, offset);
+		err = -EINVAL;
+	}
+	if (err)
+		goto msg_err;
+
+	/* If data pointer is NULL it is already filled, just skip the copy */
+	index = offset / cmpl_data->u.coredump.stride;
+	if (!cmpl_data->u.coredump.data[index])
+		goto msg_err;
+
+	/* Copy data and mark index filled by setting pointer to NULL */
+	memcpy(cmpl_data->u.coredump.data[index],
+	       fbnic_tlv_attr_get_value_ptr(data_hdr), length);
+	cmpl_data->u.coredump.data[index] = NULL;
+
+msg_err:
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return err;
+}
+
 int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
 				   struct fbnic_fw_completion *cmpl_data,
 				   unsigned int id, unsigned int len)
@@ -1220,6 +1429,11 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 			 fbnic_fw_parse_ownership_resp),
 	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
 			 fbnic_fw_parse_heartbeat_resp),
+	FBNIC_TLV_PARSER(COREDUMP_GET_INFO_RESP,
+			 fbnic_coredump_info_resp_index,
+			 fbnic_fw_parse_coredump_info_resp),
+	FBNIC_TLV_PARSER(COREDUMP_READ_RESP, fbnic_coredump_resp_index,
+			 fbnic_fw_parse_coredump_resp),
 	FBNIC_TLV_PARSER(FW_START_UPGRADE_RESP,
 			 fbnic_fw_start_upgrade_resp_index,
 			 fbnic_fw_parse_fw_start_upgrade_resp),
-- 
2.51.0


