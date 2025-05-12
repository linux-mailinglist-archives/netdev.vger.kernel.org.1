Return-Path: <netdev+bounces-189876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65643AB4468
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0C619E0C56
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2492550C7;
	Mon, 12 May 2025 19:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C529711A;
	Mon, 12 May 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076913; cv=none; b=NEfEReRAAQxq8/hEpyhfy7uyAS3FbUaKGx7vn8H0+KP1VwoLpW/f5ZjeuCG1mXRS8vvr0z6aYLlRouwruTAsyvghqhAUnA6Kj75M6xFaUg/e1ON7qi/9Kj91I1EBB47QHSz9ctdWytpbclOf9AIYMq02KhtiSvCqFWMAV2oycoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076913; c=relaxed/simple;
	bh=nRW9f+eigGPoKr6+6VpHEQOXmnb6xPqosWWWmR0XTOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3ISrIVxNg2GeUVdCAW2tEOWtD9rx9f1nkv06IFWHmwWEkPjd5Hv9CiKpawuqS+xsBQP8x62RpJi5S/Byoi4YPJ+pSYrCAHMVqjJDzPOJ9i98b2PaMjkH1BUbtuBieDbxd2K+nom82HHLnLL+53o0MgKWdO6pEaCJoYrDlNwKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from [163.114.132.130] (helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uEYVS-00072V-75; Mon, 12 May 2025 19:08:06 +0000
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
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/5] eth: fbnic: Add mailbox support for PLDM updates
Date: Mon, 12 May 2025 11:54:00 -0700
Message-ID: <20250512190109.2475614-5-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512190109.2475614-1-lee@trager.us>
References: <20250512190109.2475614-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new mailbox messages to support PLDM upgrades:

* FW_START_UPGRADE - Enables driver to request starting a firmware upgrade
                     by specifying the component to be upgraded and its
		     size.
* WRITE_CHUNK      - Allows firmware to request driver to send a chunk of
                     data at the specified offset.
* FINISH_UPGRADE   - Allows firmware to cancel the upgrade process and
                     return an error.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 191 +++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  37 ++++
 2 files changed, 228 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 6fcba4e8c21e..6a803a59dc25 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -766,6 +766,188 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
 }

+int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
+				   struct fbnic_fw_completion *cmpl_data,
+				   unsigned int id, unsigned int len)
+{
+	struct fbnic_tlv_msg *msg;
+	int err;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
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
+	u32 msg_type;
+	s32 err;
+
+	/* Verify we have a completion pointer */
+	msg_type = FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ;
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd, msg_type);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	/* Check for errors */
+	err = fta_get_sint(results, FBNIC_FW_START_UPGRADE_ERROR);
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return 0;
+}
+
+int fbnic_fw_xmit_fw_write_chunk(struct fbnic_dev *fbd,
+				 const u8 *data, u32 offset, u16 length,
+				 int cancel_error)
+{
+	struct fbnic_tlv_msg *msg;
+	int err;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Report error to FW to cancel upgrade */
+	if (cancel_error) {
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_ERROR,
+					     cancel_error);
+		if (err)
+			goto free_message;
+	}
+
+	if (data) {
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_OFFSET,
+					     offset);
+		if (err)
+			goto free_message;
+
+		err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_WRITE_CHUNK_LENGTH,
+					     length);
+		if (err)
+			goto free_message;
+
+		err = fbnic_tlv_attr_put_value(msg, FBNIC_FW_WRITE_CHUNK_DATA,
+					       data + offset, length);
+		if (err)
+			goto free_message;
+	}
+
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
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
+	u32 msg_type;
+	u32 offset;
+	u32 length;
+
+	/* Verify we have a completion pointer */
+	msg_type = FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ;
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd, msg_type);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	/* Pull length/offset pair and mark it as complete */
+	offset = fta_get_uint(results, FBNIC_FW_WRITE_CHUNK_OFFSET);
+	length = fta_get_uint(results, FBNIC_FW_WRITE_CHUNK_LENGTH);
+	cmpl_data->u.fw_update.offset = offset;
+	cmpl_data->u.fw_update.length = length;
+
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return 0;
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
+	u32 msg_type;
+	s32 err;
+
+	/* Verify we have a completion pointer */
+	msg_type = FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ;
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd, msg_type);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	/* Check for errors */
+	err = fta_get_sint(results, FBNIC_FW_FINISH_UPGRADE_ERROR);
+
+	/* Close out update by incrementing offset by length which should
+	 * match the total size of the component. Set length to 0 since no
+	 * new chunks will be requested.
+	 */
+	cmpl_data->u.fw_update.offset += cmpl_data->u.fw_update.length;
+	cmpl_data->u.fw_update.length = 0;
+
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return 0;
+}
+
 /**
  * fbnic_fw_xmit_tsene_read_msg - Create and transmit a sensor read request
  * @fbd: FBNIC device structure
@@ -850,6 +1032,15 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 			 fbnic_fw_parse_ownership_resp),
 	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
 			 fbnic_fw_parse_heartbeat_resp),
+	FBNIC_TLV_PARSER(FW_START_UPGRADE_RESP,
+			 fbnic_fw_start_upgrade_resp_index,
+			 fbnic_fw_parse_fw_start_upgrade_resp),
+	FBNIC_TLV_PARSER(FW_WRITE_CHUNK_REQ,
+			 fbnic_fw_write_chunk_req_index,
+			 fbnic_fw_parse_fw_write_chunk_req),
+	FBNIC_TLV_PARSER(FW_FINISH_UPGRADE_REQ,
+			 fbnic_fw_finish_upgrade_req_index,
+			 fbnic_fw_parse_fw_finish_upgrade_req),
 	FBNIC_TLV_PARSER(TSENE_READ_RESP,
 			 fbnic_tsene_read_resp_index,
 			 fbnic_fw_parse_tsene_read_resp),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 39dec0792090..0ab6ae3859e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -51,6 +51,10 @@ struct fbnic_fw_completion {
 	struct kref ref_count;
 	int result;
 	union {
+		struct {
+			u32 offset;
+			u32 length;
+		} fw_update;
 		struct {
 			s32 millivolts;
 			s32 millidegrees;
@@ -68,6 +72,12 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
+				   struct fbnic_fw_completion *cmpl_data,
+				   unsigned int id, unsigned int len);
+int fbnic_fw_xmit_fw_write_chunk(struct fbnic_dev *fbd,
+				 const u8 *data, u32 offset, u16 length,
+				 int cancel_error);
 int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
@@ -99,6 +109,12 @@ enum {
 	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ		= 0x22,
+	FBNIC_TLV_MSG_ID_FW_START_UPGRADE_RESP		= 0x23,
+	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ		= 0x24,
+	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP		= 0x25,
+	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_REQ		= 0x28,
+	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_RESP		= 0x29,
 	FBNIC_TLV_MSG_ID_TSENE_READ_REQ			= 0x3C,
 	FBNIC_TLV_MSG_ID_TSENE_READ_RESP		= 0x3D,
 };
@@ -154,4 +170,25 @@ enum {
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
+	FBNIC_FW_FINISH_UPGRADE_ERROR		= 0x0,
+	FBNIC_FW_FINISH_UPGRADE_MSG_MAX
+};
+
 #endif /* _FBNIC_FW_H_ */
--
2.47.1

