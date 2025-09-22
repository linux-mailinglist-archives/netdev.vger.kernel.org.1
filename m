Return-Path: <netdev+bounces-225415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C9B938E9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126182A82C5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8626C3A8;
	Mon, 22 Sep 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWD+8F5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F71459FA
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583143; cv=none; b=Fi9KDH5f9LN4kwfRy82IQoH8IuoE7BVxJKbGQEkNH1tKtU//AzGIwsMsGkTDsYT62UKSro03BwUlvAoZ88KUcAfZKxBKyegU0OCcBwvvgUKIosghdiMabS9bioTvtubrYtjmxe2PsbflEqQrZ2Ga5LDmMVkBjXP/+/gmDt5fC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583143; c=relaxed/simple;
	bh=KqEqMAKIhJPtdLWgMfe0LB5cfwVUJaPZn8lFzic6MI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLzYem73+lelwe5qhSosbgEOIThxPeYnT4XkHLnJNun7zxDJh97btkY1KOTjV5igNQmGIwVl049lnKnyk+A2qUbvm1qbqGSKm8yY2okAZ3eQlfraqxBa6df87PQtPKhThdZ+l/MU/59CLRC5Qu5j4RjIwhVLh6hYatyrfy1XnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWD+8F5F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so32663295e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583139; x=1759187939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeWc8gHoK3W2hUITWF2qdxCKq3tA3fw2PCOaGYeCrZA=;
        b=JWD+8F5FSt6nlNkoqiPZCBh6MfWZ8ek9W/J0108l91TpyDCDGrhTZKs+AhOmF+05Zk
         HgkxEZ/uNHPmMsHbOOL6JdWHc3o2RMmgXwcpvfrYltQOQ5Bb62T3Ej822gVbpjmmXtw9
         GaRiSkn/FOlFbtsNMQFmhjcN+3V1cQzCFcl5oWzb/F+KT1UxjAfRZhzKwW7UwReHtmv8
         VH6BK5AQAC/nIKsoOIRWpcYHUHO3W3LtWIs+J0pHOQPcZ9Vl183C/bKeD6c/skMM4vfy
         nSHI4Owj8sPF4OM25geEfUm9NYY7C9/G+Ls3z3BLwnhqHKy5pCWQocHSVwOuI2zBqTGs
         Yf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583139; x=1759187939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeWc8gHoK3W2hUITWF2qdxCKq3tA3fw2PCOaGYeCrZA=;
        b=RcT/zVRja9hWi/laOfNoDaqNJUdCygS20igFk2tgM+E9Ke4e2YUpl9aDdpYAjHZKjg
         lRWg4BGWR4xFBmv22jliQwAV1VsB2utJ1ttr0zTHWNisAC+vRFDQEecE0PaclRcPwg8u
         ok0uFyVr+3F6Y2EBZEP9ogF8Qfs2SY4aCRlBAtHpJwRiQhXQfYWtqoObNUEn9vctJ97m
         GonMtv+1E2DG1uVgB/UjSYumgujt9f1B6JBfEbEs3wkmzcF56D4ynH3SeUEpOAS3Exn3
         A7zhn2jgzvVJFtcQCOFU/vlRlBqMqeJ0H/Cwk+MAyqYDX9ZfDx0+CSqHsoCjX09s9IFH
         mkPg==
X-Gm-Message-State: AOJu0YxUMkiljBDLNHtfVfHrV7l59Hr5rrWw0ay8BfWodikucOUnpCsf
	0iR4QJcu4aa/Inj74Xf1/PU7yRz1RZM2vqCef7TZ8hf4r7x3zpQwiToBMYGp/cVS
X-Gm-Gg: ASbGnctB0UcJrMfQN4K8Bj6DXZMENCQbXWf+EdrUF+xaaVyZa0ktzG3qW3Qti/XOaAL
	Ut2LIrHFzGZZiAhVKXKZWzh0GTEJZ4YXdvIYCVDg28v8sPkJiD1Lopdv/6CpFkJ/TJQxjBfNEtI
	uYfkUQCTx9MJW17kgTJ9N0V8cNeyA0UfiL1BzncSOYhf567HTWpN+QL0lA9UTFIbj7s+x6IrCJj
	+ushoHj/WhOCRDeJKEtmtfY+mzg3DmJHGOA/JqD649flCpfCwGSN8HQt5pKv2Illxs26rxCZLFK
	U79qIc/n5S/xIjlnXh+2P1FEp1/zP5/i6EKn0kX0OQad/zNca0WnW8WT5c7Oy9dh5vl4O7Z0aJZ
	3iLXveCPOSrkRHLWL5mPk
X-Google-Smtp-Source: AGHT+IGyud+crDs05Xpb+nWFXc6AqxoxH5osZl4bMoOQE9zRK8oEHBvUSIL/YnDfhZblj8QhGSUu2g==
X-Received: by 2002:a05:600c:1c03:b0:46d:fe0b:d55a with SMTP id 5b1f17b1804b1-46e1dac7b3emr4917035e9.33.1758583138834;
        Mon, 22 Sep 2025 16:18:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46de4d67625sm43732805e9.16.2025.09.22.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:18:58 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	gustavoars@kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com,
	suhui@nfschina.com,
	vadim.fedorenko@linux.dev,
	idosch@idosch.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next V2] eth: fbnic: Read module EEPROM
Date: Mon, 22 Sep 2025 16:18:55 -0700
Message-ID: <20250922231855.3717483-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to read module EEPROM for fbnic. Towards this, add required
support to issue a new command to the firmware and to receive the response
to the corresponding command.

Create a local copy of the data in the completion struct before writing to
ethtool_module_eeprom to avoid writing to data in case it is freed. Given
that EEPROM pages are small, the overhead of additional copy is
negligible.

Do not block API with explicit checks since API has appropriate checks in
place for length, offset, and page.

Explicitly check bank, page, offset, and length in
fbnic_fw_parse_qsfp_read_resp() to match EEPROM read responses to the
correct request. This is important because if the driver times out waiting
for an EEPROM read response, a subsequent read request with different
values is susceptible to receiving an erroneous response (i.e., the
response to the previous request).

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
Changelog:

V2:
 - Drop bank checking in fbnic_get_module_eeprom_by_page()
 - Update commit message

V1: https://lore.kernel.org/netdev/20250919191624.1239810-1-mohsin.bashr@gmail.com/
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  60 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
 3 files changed, 217 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index b4ff98ee2051..fecb8c602024 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1635,6 +1635,65 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
 	}
 }
 
+static int
+fbnic_get_module_eeprom_by_page(struct net_device *netdev,
+				const struct ethtool_module_eeprom *page_data,
+				struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_fw_completion *fw_cmpl;
+	struct fbnic_dev *fbd = fbn->fbd;
+	int err;
+
+	if (page_data->i2c_address != 0x50) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid i2c address. Only 0x50 is supported");
+		return -EINVAL;
+	}
+
+	fw_cmpl = __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,
+					page_data->length);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	/* Initialize completion and queue it for FW to process */
+	fw_cmpl->u.qsfp.length = page_data->length;
+	fw_cmpl->u.qsfp.offset = page_data->offset;
+	fw_cmpl->u.qsfp.page = page_data->page;
+	fw_cmpl->u.qsfp.bank = page_data->bank;
+
+	err = fbnic_fw_xmit_qsfp_read_msg(fbd, fw_cmpl, page_data->page,
+					  page_data->bank, page_data->offset,
+					  page_data->length);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to transmit EEPROM read request");
+		goto exit_free;
+	}
+
+	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+		err = -ETIMEDOUT;
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Timed out waiting for firmware response");
+		goto exit_cleanup;
+	}
+
+	if (fw_cmpl->result) {
+		err = fw_cmpl->result;
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read EEPROM");
+		goto exit_cleanup;
+	}
+
+	memcpy(page_data->data, fw_cmpl->u.qsfp.data, page_data->length);
+
+exit_cleanup:
+	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
+exit_free:
+	fbnic_fw_put_cmpl(fw_cmpl);
+
+	return err ? : page_data->length;
+}
+
 static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 {
 	if (counter->reported)
@@ -1841,6 +1900,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_link_ksettings		= fbnic_phylink_ethtool_ksettings_get,
 	.get_fec_stats			= fbnic_get_fec_stats,
 	.get_fecparam			= fbnic_phylink_get_fecparam,
+	.get_module_eeprom_by_page	= fbnic_get_module_eeprom_by_page,
 	.get_eth_phy_stats		= fbnic_get_eth_phy_stats,
 	.get_eth_mac_stats		= fbnic_get_eth_mac_stats,
 	.get_eth_ctrl_stats		= fbnic_get_eth_ctrl_stats,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 6c3e7f81a2ed..c87cb9ed09e7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1184,6 +1184,138 @@ static int fbnic_fw_parse_fw_finish_upgrade_req(void *opaque,
 	return 0;
 }
 
+/**
+ * fbnic_fw_xmit_qsfp_read_msg - Transmit a QSFP read request
+ * @fbd: FBNIC device structure
+ * @cmpl_data: Structure to store EEPROM response in
+ * @page: Refers to page number on page enabled QSFP modules
+ * @bank: Refers to a collection of pages
+ * @offset: Offset into QSFP EEPROM requested
+ * @length: Length of section of QSFP EEPROM to fetch
+ *
+ * Return: zero on success, negative value on failure
+ *
+ * Asks the firmware to provide a section of the QSFP EEPROM back in a
+ * message. The response will have an offset and size matching the values
+ * provided.
+ */
+int fbnic_fw_xmit_qsfp_read_msg(struct fbnic_dev *fbd,
+				struct fbnic_fw_completion *cmpl_data,
+				u32 page, u32 bank, u32 offset, u32 length)
+{
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	if (!length || length > TLV_MAX_DATA)
+		return -EINVAL;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_QSFP_READ_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_QSFP_BANK, bank);
+	if (err)
+		goto free_message;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_QSFP_PAGE, page);
+	if (err)
+		goto free_message;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_QSFP_OFFSET, offset);
+	if (err)
+		goto free_message;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_QSFP_LENGTH, length);
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
+static const struct fbnic_tlv_index fbnic_qsfp_read_resp_index[] = {
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_QSFP_BANK),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_QSFP_PAGE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_QSFP_OFFSET),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_QSFP_LENGTH),
+	FBNIC_TLV_ATTR_RAW_DATA(FBNIC_FW_QSFP_DATA),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_QSFP_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_qsfp_read_resp(void *opaque,
+					 struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	struct fbnic_tlv_msg *data_hdr;
+	u32 length, offset, page, bank;
+	u8 *data;
+	s32 err;
+
+	/* Verify we have a completion pointer to provide with data */
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd,
+					      FBNIC_TLV_MSG_ID_QSFP_READ_RESP);
+	if (!cmpl_data)
+		return -ENOSPC;
+
+	bank = fta_get_uint(results, FBNIC_FW_QSFP_BANK);
+	if (bank != cmpl_data->u.qsfp.bank) {
+		dev_warn(fbd->dev, "bank not equal to bank requested: %d vs %d\n",
+			 bank, cmpl_data->u.qsfp.bank);
+		err = -EINVAL;
+		goto msg_err;
+	}
+
+	page = fta_get_uint(results, FBNIC_FW_QSFP_PAGE);
+	if (page != cmpl_data->u.qsfp.page) {
+		dev_warn(fbd->dev, "page not equal to page requested: %d vs %d\n",
+			 page, cmpl_data->u.qsfp.page);
+		err = -EINVAL;
+		goto msg_err;
+	}
+
+	offset = fta_get_uint(results, FBNIC_FW_QSFP_OFFSET);
+	length = fta_get_uint(results, FBNIC_FW_QSFP_LENGTH);
+
+	if (length != cmpl_data->u.qsfp.length ||
+	    offset != cmpl_data->u.qsfp.offset) {
+		dev_warn(fbd->dev,
+			 "offset/length not equal to size requested: %d/%d vs %d/%d\n",
+			 offset, length,
+			 cmpl_data->u.qsfp.offset, cmpl_data->u.qsfp.length);
+		err = -EINVAL;
+		goto msg_err;
+	}
+
+	err = fta_get_sint(results, FBNIC_FW_QSFP_ERROR);
+	if (err)
+		goto msg_err;
+
+	data_hdr = results[FBNIC_FW_QSFP_DATA];
+	if (!data_hdr) {
+		err = -ENODATA;
+		goto msg_err;
+	}
+
+	/* Copy data */
+	data = fbnic_tlv_attr_get_value_ptr(data_hdr);
+	memcpy(cmpl_data->u.qsfp.data, data, length);
+msg_err:
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return err;
+}
+
 /**
  * fbnic_fw_xmit_tsene_read_msg - Create and transmit a sensor read request
  * @fbd: FBNIC device structure
@@ -1445,6 +1577,9 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(FW_FINISH_UPGRADE_REQ,
 			 fbnic_fw_finish_upgrade_req_index,
 			 fbnic_fw_parse_fw_finish_upgrade_req),
+	FBNIC_TLV_PARSER(QSFP_READ_RESP,
+			 fbnic_qsfp_read_resp_index,
+			 fbnic_fw_parse_qsfp_read_resp),
 	FBNIC_TLV_PARSER(TSENE_READ_RESP,
 			 fbnic_tsene_read_resp_index,
 			 fbnic_fw_parse_tsene_read_resp),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index d776be9fc7f7..1ecd777aaada 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -78,6 +78,13 @@ struct fbnic_fw_completion {
 			u32 offset;
 			u32 length;
 		} fw_update;
+		struct {
+			u16 length;
+			u8 offset;
+			u8 page;
+			u8 bank;
+			u8 data[] __aligned(sizeof(u32)) __counted_by(length);
+		} qsfp;
 		struct {
 			s32 millivolts;
 			s32 millidegrees;
@@ -109,6 +116,9 @@ int fbnic_fw_xmit_fw_start_upgrade(struct fbnic_dev *fbd,
 int fbnic_fw_xmit_fw_write_chunk(struct fbnic_dev *fbd,
 				 const u8 *data, u32 offset, u16 length,
 				 int cancel_error);
+int fbnic_fw_xmit_qsfp_read_msg(struct fbnic_dev *fbd,
+				struct fbnic_fw_completion *cmpl_data,
+				u32 page, u32 bank, u32 offset, u32 length);
 int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
@@ -161,6 +171,8 @@ enum {
 	FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_RESP		= 0x25,
 	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_REQ		= 0x28,
 	FBNIC_TLV_MSG_ID_FW_FINISH_UPGRADE_RESP		= 0x29,
+	FBNIC_TLV_MSG_ID_QSFP_READ_REQ			= 0x38,
+	FBNIC_TLV_MSG_ID_QSFP_READ_RESP			= 0x39,
 	FBNIC_TLV_MSG_ID_TSENE_READ_REQ			= 0x3C,
 	FBNIC_TLV_MSG_ID_TSENE_READ_RESP		= 0x3D,
 	FBNIC_TLV_MSG_ID_LOG_SEND_LOGS_REQ		= 0x43,
@@ -209,6 +221,16 @@ enum {
 	FBNIC_FW_LINK_FEC_BASER			= 3,
 };
 
+enum {
+	FBNIC_FW_QSFP_BANK			= 0x0,
+	FBNIC_FW_QSFP_PAGE			= 0x1,
+	FBNIC_FW_QSFP_OFFSET			= 0x2,
+	FBNIC_FW_QSFP_LENGTH			= 0x3,
+	FBNIC_FW_QSFP_ERROR			= 0x4,
+	FBNIC_FW_QSFP_DATA			= 0x5,
+	FBNIC_FW_QSFP_MSG_MAX
+};
+
 enum {
 	FBNIC_FW_TSENE_THERM			= 0x0,
 	FBNIC_FW_TSENE_VOLT			= 0x1,
-- 
2.47.3


