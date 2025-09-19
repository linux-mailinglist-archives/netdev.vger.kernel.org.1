Return-Path: <netdev+bounces-224865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895EB8B10D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4495716754F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BFA25D1F5;
	Fri, 19 Sep 2025 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvV8yqsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225721F8BA6
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309391; cv=none; b=LS5BXOOJ3/4mMusOzod8zr2u5cLaGDZKOVHagcQUgmiYp4VimHMM16OEyT7m80STXIUYYpUEgbWPk6+0b5RYWu9n9h7PqufQHQ/knFI+EtKgYh5bO9aTUlAnFmCwboaAUmHk/8XKli3fGY7EU/+h4ziU0nEy/ErKoo00BTREfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309391; c=relaxed/simple;
	bh=tZOm0dRpbx6xHYV/E0GFOmp/LqMPrYBSauiO/B7UzXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZPLb8PMfPXhJEdAVx5BonCtkVd5opkoJFJSmPFL8cZDvjtCVJSUyeLGtkQi3ml2OOnSL3/XPW9+7ReZyLVw3qn6fjRtylJfsvyyVxCnfGieLAnU9IuvPFdhBSldCWtVhxWTPCvUq22Pc8MWGH1XVfvE/O4VRFUv9qsgqxPsL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvV8yqsv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so15644965e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758309387; x=1758914187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7RmbP8ju/9/Ypw84TemIhlO8JsrCzpOCxJhMqTblBU=;
        b=dvV8yqsvThAB5DaR5vxhEI5YUToY6RLXSiLYQQzPFyER05fZEjf+3At7GPPtR5ywPH
         IDH6j3uqZNAGIiVE5sQxzYAwhSTGAu+fju/U9dE3DGQR4E5CDB7GlP2UCyzI+NVE4lpY
         om9aEXQfjP7xv0UlgLuNzeoGiR2g8z5DVymza96OCa6oAGveujUrdPaJqnRB6LAvdilS
         xzOCoOf1k0ZWNBUQqtmNMx0q9atOhW6VQ58MQEI7urSySuk+NWb3OS6IaTXedtvTTmxE
         jeNKlpdBRhjNCpwJxu9FBfuoaLq76LHw9HEM1lCD+4VB0hTrUSVx8koIcS3Bw7UZcPb4
         9SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758309387; x=1758914187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7RmbP8ju/9/Ypw84TemIhlO8JsrCzpOCxJhMqTblBU=;
        b=Qd6PyQmB7i86vs5VquL8gDqTjZuFz+6ts7qE9kyCSRuO+w3Gzbfb9QYrDskJ+i+teL
         CDTcZ4oD8W+0QZrpC8ocUEmYdxPoW0oUfwGXZEAdE/zwiPf6hWQA0Wvaw7fpw2ED4IUj
         Bx0neEmtn0V8MPB/9IXXUWgcCeWG4UlgErSuvTJNBKmwKq4B/NtVqBm+TyUWCHA/mKGE
         T/6ELc1zg9C29slePv1V1n5lUtogOanbuxaggtomgNgQ8aho+3brdnGpMtfxCYzX/QUc
         qT7zmgGCNml4KitaJUjmOBCX5cnyUxmBebyZGhscMUrS6fPe2qXGv6EGofzq6H0/SLMD
         uujw==
X-Gm-Message-State: AOJu0Yze0c1DfzwdP+jQWZjLvxro/Oxl5LgKMVssjwwxPl1IAezOGrrC
	hQSpO+rksR4osye5OG4WqygxO5whAyeuAlZW1j7leR6yYiF4JJAxvaWddSBlnQAh
X-Gm-Gg: ASbGnct3G+sPghA2F6qWOlLm+Irc/oE0zuG7uJ3U731Vm0rGL3IFpnF+rYh7xrn92MZ
	kV7oJl/0qBKfyCSfZsD0OunuyUT6OalZhON3dDa60UBbet3bVKzSJg1cOeD+hJ2+qsWsdWnVLLL
	vzjl4rlQ5jmfMqivn0LYiPmlQbLzECoHq9A+tm4tPXAIbn9+kjxb87BIC+1aYCmJgYBbUVEHyIq
	+1rmVKn2Yx/fYBQe7x5yeBbOmV38wsiUqg2bR3cjvC0x+Y6P8KiyE8gvs0XAUTuZGCS9E9g5EPf
	5wXPSdMU1Rrpoa89X9CySITTMmOeCsjTNrvXBouiQFP09j7L0XRBjiemte8fgcskafWGAa2K0HP
	WTdS4B0eHV3/vu8ZRLakS
X-Google-Smtp-Source: AGHT+IEWBeWbj6lq6hoQxqG941MBcvUfW9Zv2/UQyeyUJTm4eIaX3RIzWCqXjx1lstTDX+LFi8zyQw==
X-Received: by 2002:a05:6000:1889:b0:3ea:4b52:af6f with SMTP id ffacd0b85a97d-3ee7c55296bmr2950035f8f.9.1758309386774;
        Fri, 19 Sep 2025 12:16:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:52::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d81sm9777205f8f.5.2025.09.19.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:16:26 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	gustavoars@kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	kernel-team@meta.com,
	lee@trager.us,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com,
	suhui@nfschina.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next] eth: fbnic: Read module EEPROM
Date: Fri, 19 Sep 2025 12:16:24 -0700
Message-ID: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
 3 files changed, 223 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index b4ff98ee2051..f6069cddffa5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1635,6 +1635,71 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
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
+	if (page_data->bank != 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid bank. Only 0 is supported");
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
@@ -1841,6 +1906,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
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


