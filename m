Return-Path: <netdev+bounces-157924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEFCA0F562
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884607A31FA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FD17BCE;
	Tue, 14 Jan 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJCW0eTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7182C9A;
	Tue, 14 Jan 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813231; cv=none; b=QUXmpoZhvBQHazvU2V76L0tHssO8V15ZcEbbkla31oxc9sGjuBz2889EdUyRJzjrqNtATpCOj/W8NcoHh67/3ecRWUZbAcFQ+7RsJejLIyFUnVVwhkby1JeK7bHNiO22XepNJdPYmgP49i4Ecr3dAR9IsBgwqo3x/w/hUWfNfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813231; c=relaxed/simple;
	bh=Nor1WRck3wXAPi0VIO7sp1IPeuWYHCF8mQk1w2KsRxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=segTkfqSKYvKkAf47XGERqKFc/t/KkIhOkq9DX+dKEqDpJKOoSUpBOrpbXJseAbB2sJnVWYmvr77IDNLG+8f0SYPkJDxD10FcJc5DNv8QDTfG0jPbdk+dYTuZvN8qtoQJJgfR8P7IyWAjBxE9TAem/98Hxb3j5qFSmDvlJ5nshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJCW0eTK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2165cb60719so87383835ad.0;
        Mon, 13 Jan 2025 16:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736813229; x=1737418029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBxmq1t8/dhRnQdSNSLZESYohKM4MWtxVHXJFN7pUOI=;
        b=lJCW0eTK8tNaoteoZPfu98I24r2PKAu9IZEq964/DmYWEwQ31c98taX/fN6kYsSxCw
         WTYZDiWt1wSA90FWQF7aSdaEHZKmIWd0WsxVrzYqVa6y1UUaExNFEGRALa5gwnr5ZYuO
         exAGF5rof7vCTjELl028KoXdpJS/RR39oZjZIaOocUixq+wUn3WnLmco+5mgtDzjuHSi
         5/aicoEZ25eAEVB/ccz/dUuo8KzKh2fk6boHuKwwH0H1XqL8TAgtRBwRzT2i0EIuigv5
         Lp75TGs/eBEN49BWbEl9MOpZXrytqu3uIQwo4cNhNHhQwJTkhRXr/AXnCxvd90AXj0FF
         c4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813229; x=1737418029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBxmq1t8/dhRnQdSNSLZESYohKM4MWtxVHXJFN7pUOI=;
        b=N/NsmYBL67tY4keGAOrIb4xgxWaEbKgZMtcpIdKmhoqFK+Ozl8Ny8uDbXuOzSL8q0V
         VH5+NvTnysmNjJOdrdAw+l1hwbLtpWSacORivfqqJgkvRAb6EDvQJyDNJo9BmEoz0KKB
         la6b5WIMHVMvcorKcjrfNN0bn+mvtBpERZNOcyVpM6qig3Jh+uTL77zPANyPc+w7MZvj
         Lnb5R9TUYDuxGbhCpJF2p7psrN6NkRKR5RQzx/X8Owsl1l9tM8Logz/aWnZd9W4p6GDG
         V6AaFrtbBgkSfkLowX+6d5o+uQ2PneLjweg8qssaLDIJb/Q5YLVwdFgQdfcHKaUhn2Qf
         D/eg==
X-Forwarded-Encrypted: i=1; AJvYcCV6VFK3qmHYcjsDrMMhPlR938J+94aqMGw/hNubaGdORk69Gxeu+U376WV61a25cRVof1HX4gvQHT4Oxq8f@vger.kernel.org, AJvYcCXC/7UqCAI/q0vZ0dG8XfOlbQgLJWK6zgy7BDlJFj6nOze0Z8XB8wam2aMej/U9OchYo/8HklZfCe/dFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QUQOvo85iGAVgNyZ6/A63shVzHor1GJjxbcKC3or4cFQcJzv
	WS2lEHq8qVehwGBbKcySUqBhvkNZPmrkdHnJkRxXQKSjQY49DZF7IfJ69fW7rE8=
X-Gm-Gg: ASbGncvYe3+FV+t901B3gX7HWfs7GIGEQE7KOhe0jo24CfPQq5plOUnh8O0EGqTXxvi
	prdh6WFl2NmvFOvaRfjcxUDJgR2ExAE/sF6j79+kNusfaOPDY/Sjp+TbS1k44xcXGdlg5FcyTP/
	SgwuKCiJFiUtsLTf2sc1pan18GWnfHI0ZYWYhpBCyskWs48dWnAM6d4khw7Zoar421fBvY6otn+
	oLuS1Pa6ktXDj6hbxf0MxndH4C+a+zSqNEEEGz6z+KXqjG2TqUFyA==
X-Google-Smtp-Source: AGHT+IGhYyUa2EoaX/RgSQJjnYDPEbFmy4xcTjVzx48DU2ggRMkZuAlkum/jB2a2obLvFLRu2j8mNQ==
X-Received: by 2002:a05:6a00:3910:b0:72a:a9d9:5a82 with SMTP id d2e1a72fcca58-72d21deb996mr35454831b3a.0.1736813228809;
        Mon, 13 Jan 2025 16:07:08 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40549413sm6597703b3a.12.2025.01.13.16.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:07:08 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com,
	linux@roeck-us.net,
	mohsin.bashr@gmail.com,
	jdelvare@suse.com,
	horms@kernel.org,
	suhui@nfschina.com,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next 2/3] eth: fbnic: hwmon: Add support for reading temperature and voltage sensors
Date: Mon, 13 Jan 2025 16:07:04 -0800
Message-ID: <20250114000705.2081288-3-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114000705.2081288-1-sanman.p211993@gmail.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading temperature and voltage sensor data from firmware
by implementing a new TSENE message type and response parsing. This adds
message handler infrastructure to transmit sensor read requests and parse
responses. The sensor data will be exposed through the driver's hwmon interface.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 89 ++++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  | 15 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 72 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h |  7 ++
 4 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 320615a122e4..bbc7c1c0c37e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -228,9 +228,9 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 	tx_mbx->head = head;
 }

-static __maybe_unused int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
-						   struct fbnic_tlv_msg *msg,
-						   struct fbnic_fw_completion *cmpl_data)
+static int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
+				    struct fbnic_tlv_msg *msg,
+				    struct fbnic_fw_completion *cmpl_data)
 {
 	unsigned long flags;
 	int err;
@@ -269,7 +269,7 @@ static void fbnic_fw_release_cmpl_data(struct kref *kref)
 	kfree(cmpl_data);
 }

-static __maybe_unused struct fbnic_fw_completion *
+static struct fbnic_fw_completion *
 fbnic_fw_get_cmpl_by_type(struct fbnic_dev *fbd, u32 msg_type)
 {
 	struct fbnic_fw_completion *cmpl_data = NULL;
@@ -708,6 +708,84 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
 }

+/**
+ * fbnic_fw_xmit_tsene_read_msg - Create and transmit a sensor read request
+ * @fbd: FBNIC device structure
+ * @cmpl_data: Completion data structure to store sensor response
+ *
+ * Asks the firmware to provide an update with the latest sensor data.
+ * The response will contain temperature and voltage readings.
+ *
+ * Return: 0 on success, negative error value on failure
+ */
+int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
+				 struct fbnic_fw_completion *cmpl_data)
+{
+	struct fbnic_tlv_msg *msg;
+	int err;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_TSENE_READ_REQ);
+	if (!msg)
+		return -ENOMEM;
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
+static const struct fbnic_tlv_index fbnic_tsene_read_resp_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_THERM),
+	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_VOLT),
+	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_tsene_read_resp(void *opaque,
+					  struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl_data;
+	struct fbnic_dev *fbd = opaque;
+	int err = 0;
+
+	/* Verify we have a completion pointer to provide with data */
+	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd,
+					      FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
+	if (!cmpl_data)
+		return -EINVAL;
+
+	if (results[FBNIC_TSENE_ERROR]) {
+		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_TSENE_ERROR]);
+		if (err)
+			goto exit_complete;
+	}
+
+	if (!results[FBNIC_TSENE_THERM] || !results[FBNIC_TSENE_VOLT]) {
+		err = -EINVAL;
+		goto exit_complete;
+	}
+
+	cmpl_data->u.tsene.millidegrees =
+		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_THERM]);
+	cmpl_data->u.tsene.millivolts =
+		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_VOLT]);
+
+exit_complete:
+	cmpl_data->result = err;
+	complete(&cmpl_data->done);
+	fbnic_fw_put_cmpl(cmpl_data);
+
+	return err;
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
 			 fbnic_fw_parse_cap_resp),
@@ -715,6 +793,9 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 			 fbnic_fw_parse_ownership_resp),
 	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
 			 fbnic_fw_parse_heartbeat_resp),
+	FBNIC_TLV_PARSER(TSENE_READ_RESP,
+			 fbnic_tsene_read_resp_index,
+			 fbnic_fw_parse_tsene_read_resp),
 	FBNIC_TLV_MSG_ERROR
 };

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index ff304baade91..fe68333d51b1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -50,6 +50,10 @@ struct fbnic_fw_completion {
 	struct kref ref_count;
 	int result;
 	union {
+		struct {
+			s32 millivolts;
+			s32 millidegrees;
+		} tsene;
 	} u;
 };

@@ -61,6 +65,8 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
+				 struct fbnic_fw_completion *cmpl_data);
 void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
 			u32 msg_type);
 void fbnic_fw_clear_compl(struct fbnic_dev *fbd);
@@ -89,6 +95,8 @@ enum {
 	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+	FBNIC_TLV_MSG_ID_TSENE_READ_REQ			= 0x3C,
+	FBNIC_TLV_MSG_ID_TSENE_READ_RESP		= 0x3D,
 };

 #define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
@@ -130,6 +138,13 @@ enum {
 	FBNIC_FW_LINK_FEC_BASER			= 3,
 };

+enum {
+	FBNIC_TSENE_THERM			= 0x0,
+	FBNIC_TSENE_VOLT			= 0x1,
+	FBNIC_TSENE_ERROR			= 0x2,
+	FBNIC_TSENE_MSG_MAX
+};
+
 enum {
 	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
 	FBNIC_FW_OWNERSHIP_MSG_MAX
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 7b654d0a6dac..14291401f463 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -686,6 +686,77 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_BROADCAST);
 }

+static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
+				     long *val)
+{
+	struct fbnic_fw_completion *fw_cmpl;
+	int err = 0, retries = 5;
+	s32 *sensor;
+
+	fw_cmpl = kzalloc(sizeof(*fw_cmpl), GFP_KERNEL);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	/* Initialize completion and queue it for FW to process */
+	fbnic_fw_init_cmpl(fw_cmpl, FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
+
+	switch (id) {
+	case FBNIC_SENSOR_TEMP:
+		sensor = &fw_cmpl->u.tsene.millidegrees;
+		break;
+	case FBNIC_SENSOR_VOLTAGE:
+		sensor = &fw_cmpl->u.tsene.millivolts;
+		break;
+	default:
+		err = -EINVAL;
+		goto exit_free;
+	}
+
+	err = fbnic_fw_xmit_tsene_read_msg(fbd, fw_cmpl);
+	if (err) {
+		dev_err(fbd->dev,
+			"Failed to transmit TSENE read msg, err %d\n",
+			err);
+		goto exit_free;
+	}
+
+	/* Allow 2 seconds for reply, resend and try up to 5 times */
+	while (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+		retries--;
+
+		if (retries == 0) {
+			dev_err(fbd->dev,
+				"Timed out waiting for TSENE read\n");
+			err = -ETIMEDOUT;
+			goto exit_cleanup;
+		}
+
+		err = fbnic_fw_xmit_tsene_read_msg(fbd, NULL);
+		if (err) {
+			dev_err(fbd->dev,
+				"Failed to transmit TSENE read msg, err %d\n",
+				err);
+			goto exit_cleanup;
+		}
+	}
+
+	/* Handle error returned by firmware */
+	if (fw_cmpl->result) {
+		err = fw_cmpl->result;
+		dev_err(fbd->dev, "%s: Firmware returned error %d\n",
+			__func__, err);
+		goto exit_cleanup;
+	}
+
+	*val = *sensor;
+exit_cleanup:
+	fbnic_fw_clear_compl(fbd);
+exit_free:
+	fbnic_fw_put_cmpl(fw_cmpl);
+
+	return err;
+}
+
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.pcs_enable = fbnic_pcs_enable_asic,
@@ -695,6 +766,7 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
+	.get_sensor = fbnic_mac_get_sensor_asic,
 };

 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 476239a9d381..05a591653e09 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -47,6 +47,11 @@ enum {
 #define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
 #define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)

+enum fbnic_sensor_id {
+	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
+	FBNIC_SENSOR_VOLTAGE,		/* Voltage in millivolts */
+};
+
 /* This structure defines the interface hooks for the MAC. The MAC hooks
  * will be configured as a const struct provided with a set of function
  * pointers.
@@ -83,6 +88,8 @@ struct fbnic_mac {

 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
+
+	int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
 };

 int fbnic_mac_init(struct fbnic_dev *fbd);
--
2.43.5

