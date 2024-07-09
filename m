Return-Path: <netdev+bounces-110390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DD92C288
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F081C23234
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8115217B05C;
	Tue,  9 Jul 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+sOZC5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D6188CC8
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546153; cv=none; b=Ykvppiq93WD0f65nVrRp4pFway71rcFL4raL6b/EcjDPPVus8egR7b7Ib2pgkyUF8Xu5KpkspLHWIeWNqvW/AcsMRVGFgbP6Bulaw8O0dmi8HaFKwdMx/zBk73nVjpdUxyS+DPBnuVWGUdOqhjbxCJh/qM4HYJ1SMtnAVoO86k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546153; c=relaxed/simple;
	bh=mabzIF2p2Vs+ZlPPh4mAFdrl4thbm8nwn78sd84d+2g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkcmENRBpEXEtjfnYD9VRd1S0L/LNdaiXQTY1Bpap4yWVVrzh552+sVLX66SCpe3pEmFSIesbQNtkwlkmCM7778jLW00zWCIm6ud1AJZDhfGRv/e0F3SO42gZXPS/nR6dyF5bFpzhODCisUZz3ZIGSqdeLB4K813Y6oA+PJiCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+sOZC5A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb05ac6b77so29090605ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546150; x=1721150950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fqJjJ61YCfnWEBL8c0zMKro7HPxigmI3CvUl/5yPirI=;
        b=m+sOZC5AhVM7nGwb/QPCx1RjogaRiE1mJa3Xx8goz4tNoxPuvF/ae5hE5nveCnQ0tl
         PeQ6I8j7ArYSfOy8+5dGAZck+rCJgwrlQmwqoUoR8Uo0z1IQLJWxu5McYWElznImomyv
         g0r19+/nlZlxKIOUAx1CDDjvjzeZZJwjQbhP08wvO85SeZkO+zBdlRveP4oXZobAZbnD
         3ewIKJ1zmxmRM8r6VPb2a+1V1Ygf+ENSmkWPstihsnUO/RO1sDpKn5H458pzghhnM6GZ
         sgbBcXMZ4GeFl/CR+SwzdFGmZAyfigOO37taBZFJl5FSL/52lutJb6qaG4gWqJEJ8/EE
         Gcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546150; x=1721150950;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqJjJ61YCfnWEBL8c0zMKro7HPxigmI3CvUl/5yPirI=;
        b=M1gXVRQ4uMgLwA5EcNNuSd8mKOGOkCu6ZA7/AJQfksC+t11Ab1yuGpho+Tuk80qnVb
         w7Hv4SUWSPreG3IIb4+YTPeSQyLmSAACmPUamBhmkaY4srnrr+7LmPyMiLD1dIvZfOEU
         2Gy5O3RUI1ZTDqpFS0p+6jBNSzvEBEov/Q4HHPVYCT0tdVkPoA3FVLCCpQbIkj9DlEhD
         Sgv13R0CA6lghHLWdAQXoOmBkWKUcCZFcmQD/sh9w3JY5p8aU3QStY3Z2yGpI2d389mf
         XfyLVumKSyKTQnDkS06QmUKnUD9DL0+6SDstCP2KcTTj7SALSP42PjikbHTVCQDJH7+f
         YV0A==
X-Gm-Message-State: AOJu0YxUGZ+Y+/seZsBtz7r7u1CNlMDcxJytrakndpIKrcMHvYX1C3pH
	JXDvqzjkkFRFWu+w6z6tojMwO0NyO+KzTs0XPAAjAaztNh+eBr4n
X-Google-Smtp-Source: AGHT+IEHeuInXIQ2KqFHFO5V7q+WJi3c2qd5f2o8i1aTDtSk6+ikKx7lL+wh/xUcYZuFJROOY6RfCw==
X-Received: by 2002:a17:902:da8c:b0:1fb:8c26:4b2a with SMTP id d9443c01a7336-1fbb6d251a5mr27321145ad.11.1720546150487;
        Tue, 09 Jul 2024 10:29:10 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122cfsm19311255ad.5.2024.07.09.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:29:10 -0700 (PDT)
Subject: [net-next PATCH v4 10/15] eth: fbnic: Add initial messaging to notify
 FW of our presence
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Tue, 09 Jul 2024 10:29:08 -0700
Message-ID: 
 <172054614895.1305884.4695089792762314053.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

After the driver loads we need to get some initial capabilities from the
firmware to determine what the device is capable of and what functionality
needs to be enabled. Specifically we receive information about the current
state of the link and if a BMC is present.

After that when we bring the interface up we will need the ability to take
ownership from the FW. To do that we will need to notify it that we are
taking control before we start configuring the traffic classifier and MAC.

Once we have ownership we need to notify the firmware that we are still
present and active. To do that we will send a regular heartbeat to the FW.
If the FW doesn't receive the heartbeat in a timely fashion it will retake
control of the RPC and MAC and assume that the host has gone offline.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h        |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |    8 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c     |  411 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h     |   85 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |   28 ++
 6 files changed, 555 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 8abae3b8ef4d..44fe6bbf88a1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -26,9 +26,14 @@ struct fbnic_dev {
 	struct delayed_work service_task;
 
 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
+	struct fbnic_fw_cap fw_cap;
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;
 
+	unsigned long last_heartbeat_request;
+	unsigned long last_heartbeat_response;
+	u8 fw_heartbeat_enabled;
+
 	u64 dsn;
 	u32 mps;
 	u32 readrq;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index be682fa78b2b..fb64ad919d31 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -12,6 +12,14 @@
 #define DESC_BIT(nr)		BIT_ULL(nr)
 #define DESC_GENMASK(h, l)	GENMASK_ULL(h, l)
 
+/* Defines the minimum firmware version required by the driver */
+#define MIN_FW_MAJOR_VERSION    0
+#define MIN_FW_MINOR_VERSION    10
+#define MIN_FW_BUILD_VERSION    6
+#define MIN_FW_VERSION_CODE     (MIN_FW_MAJOR_VERSION * (1u << 24) + \
+				 MIN_FW_MINOR_VERSION * (1u << 16) + \
+				 MIN_FW_BUILD_VERSION)
+
 #define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013
 
 #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index feca833ee924..0c6e1b4c119b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bitfield.h>
+#include <linux/etherdevice.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
@@ -190,6 +191,22 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
 	return err;
 }
 
+static int fbnic_mbx_map_tlv_msg(struct fbnic_dev *fbd,
+				 struct fbnic_tlv_msg *msg)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+
+	err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_TX_IDX, msg,
+				le16_to_cpu(msg->hdr.len) * sizeof(u32), 1);
+
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+
+	return err;
+}
+
 static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
@@ -211,6 +228,61 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 	tx_mbx->head = head;
 }
 
+/**
+ * fbnic_fw_xmit_simple_msg - Transmit a simple single TLV message w/o data
+ * @fbd: FBNIC device structure
+ * @msg_type: ENUM value indicating message type to send
+ *
+ * Return:
+ *   One the following values:
+ *     -EOPNOTSUPP: Is not ASIC so mailbox is not supported
+ *     -ENODEV: Device I/O error
+ *     -ENOMEM: Failed to allocate message
+ *     -EBUSY: No space in mailbox
+ *     -ENOSPC: DMA mapping failed
+ *
+ * This function sends a single TLV header indicating the host wants to take
+ * some action. However there are no other side effects which means that any
+ * response will need to be caught via a completion if this action is
+ * expected to kick off a resultant action.
+ */
+static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
+{
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	msg = fbnic_tlv_msg_alloc(msg_type);
+	if (!msg)
+		return -ENOMEM;
+
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		free_page((unsigned long)msg);
+
+	return err;
+}
+
+/**
+ * fbnic_fw_xmit_cap_msg - Allocate and populate a FW capabilities message
+ * @fbd: FBNIC device structure
+ *
+ * Return: NULL on failure to allocate, error pointer on error, or pointer
+ * to new TLV test message.
+ *
+ * Sends a single TLV header indicating the host wants the firmware to
+ * confirm the capabilities and version.
+ **/
+static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
+{
+	int err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
+
+	/* Return 0 if we are not calling this on ASIC */
+	return (err == -EOPNOTSUPP) ? 0 : err;
+}
+
 static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
@@ -226,6 +298,16 @@ static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 		/* Make sure we have a page for the FW to write to */
 		fbnic_mbx_alloc_rx_msgs(fbd);
 		break;
+	case FBNIC_IPC_MBX_TX_IDX:
+		/* Force version to 1 if we successfully requested an update
+		 * from the firmware. This should be overwritten once we get
+		 * the actual version from the firmware in the capabilities
+		 * request message.
+		 */
+		if (!fbnic_fw_xmit_cap_msg(fbd) &&
+		    !fbd->fw_cap.running.mgmt.version)
+			fbd->fw_cap.running.mgmt.version = 1;
+		break;
 	}
 }
 
@@ -246,7 +328,336 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 		fbnic_mbx_postinit_desc_ring(fbd, i);
 }
 
+/**
+ * fbnic_fw_xmit_ownership_msg - Create and transmit a host ownership message
+ * to FW mailbox
+ *
+ * @fbd: FBNIC device structure
+ * @take_ownership: take/release the ownership
+ *
+ * Return: zero on success, negative value on failure
+ *
+ * Notifies the firmware that the driver either takes ownership of the NIC
+ * (when @take_ownership is true) or releases it.
+ */
+int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
+{
+	unsigned long req_time = jiffies;
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_OWNERSHIP_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	if (take_ownership) {
+		err = fbnic_tlv_attr_put_flag(msg, FBNIC_FW_OWNERSHIP_FLAG);
+		if (err)
+			goto free_message;
+	}
+
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		goto free_message;
+
+	/* Initialize heartbeat, set last response to 1 second in the past
+	 * so that we will trigger a timeout if the firmware doesn't respond
+	 */
+	fbd->last_heartbeat_response = req_time - HZ;
+
+	fbd->last_heartbeat_request = req_time;
+
+	/* Set heartbeat detection based on if we are taking ownership */
+	fbd->fw_heartbeat_enabled = take_ownership;
+
+	return err;
+
+free_message:
+	free_page((unsigned long)msg);
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_fw_cap_resp_index[] = {
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_VERSION),
+	FBNIC_TLV_ATTR_FLAG(FBNIC_FW_CAP_RESP_BMC_PRESENT),
+	FBNIC_TLV_ATTR_MAC_ADDR(FBNIC_FW_CAP_RESP_BMC_MAC_ADDR),
+	FBNIC_TLV_ATTR_ARRAY(FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_STORED_VERSION),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT),
+	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR,
+			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_BMC_ALL_MULTI),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_FW_LINK_SPEED),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_FW_LINK_FEC),
+	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_STORED_COMMIT_STR,
+			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_CMRT_VERSION),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_STORED_CMRT_VERSION),
+	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_CMRT_COMMIT_STR,
+			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR,
+			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_UEFI_VERSION),
+	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR,
+			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
+				    struct fbnic_tlv_msg *attr, int len)
+{
+	int attr_len = le16_to_cpu(attr->hdr.len) / sizeof(u32) - 1;
+	struct fbnic_tlv_msg *mac_results[8];
+	int err, i = 0;
+
+	/* Make sure we have enough room to process all the MAC addresses */
+	if (len > 8)
+		return -ENOSPC;
+
+	/* Parse the array */
+	err = fbnic_tlv_attr_parse_array(&attr[1], attr_len, mac_results,
+					 fbnic_fw_cap_resp_index,
+					 FBNIC_FW_CAP_RESP_BMC_MAC_ADDR, len);
+	if (err)
+		return err;
+
+	/* Copy results into MAC addr array */
+	for (i = 0; i < len && mac_results[i]; i++)
+		fbnic_tlv_attr_addr_copy(bmc_mac_addr[i], mac_results[i]);
+
+	/* Zero remaining unused addresses */
+	while (i < len)
+		eth_zero_addr(bmc_mac_addr[i++]);
+
+	return 0;
+}
+
+static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
+{
+	u32 active_slot = 0, all_multi = 0;
+	struct fbnic_dev *fbd = opaque;
+	u32 speed = 0, fec = 0;
+	size_t commit_size = 0;
+	bool bmc_present;
+	int err;
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_VERSION,
+			    fbd->fw_cap.running.mgmt.version);
+
+	if (!fbd->fw_cap.running.mgmt.version)
+		return -EINVAL;
+
+	if (fbd->fw_cap.running.mgmt.version < MIN_FW_VERSION_CODE) {
+		char running_ver[FBNIC_FW_VER_MAX_SIZE];
+
+		fbnic_mk_fw_ver_str(fbd->fw_cap.running.mgmt.version,
+				    running_ver);
+		dev_err(fbd->dev, "Device firmware version(%s) is older than minimum required version(%02d.%02d.%02d)\n",
+			running_ver,
+			MIN_FW_MAJOR_VERSION,
+			MIN_FW_MINOR_VERSION,
+			MIN_FW_BUILD_VERSION);
+		/* Disable TX mailbox to prevent card use until firmware is
+		 * updated.
+		 */
+		fbd->mbx[FBNIC_IPC_MBX_TX_IDX].ready = false;
+		return -EINVAL;
+	}
+
+	get_string_result(FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR, commit_size,
+			  fbd->fw_cap.running.mgmt.commit,
+			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+	if (!commit_size)
+		dev_warn(fbd->dev, "Firmware did not send mgmt commit!\n");
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_STORED_VERSION,
+			    fbd->fw_cap.stored.mgmt.version);
+	get_string_result(FBNIC_FW_CAP_RESP_STORED_COMMIT_STR, commit_size,
+			  fbd->fw_cap.stored.mgmt.commit,
+			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_CMRT_VERSION,
+			    fbd->fw_cap.running.bootloader.version);
+	get_string_result(FBNIC_FW_CAP_RESP_CMRT_COMMIT_STR, commit_size,
+			  fbd->fw_cap.running.bootloader.commit,
+			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_STORED_CMRT_VERSION,
+			    fbd->fw_cap.stored.bootloader.version);
+	get_string_result(FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR, commit_size,
+			  fbd->fw_cap.stored.bootloader.commit,
+			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_UEFI_VERSION,
+			    fbd->fw_cap.stored.undi.version);
+	get_string_result(FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR, commit_size,
+			  fbd->fw_cap.stored.undi.commit,
+			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT, active_slot);
+	fbd->fw_cap.active_slot = active_slot;
+
+	get_unsigned_result(FBNIC_FW_CAP_RESP_FW_LINK_SPEED, speed);
+	get_unsigned_result(FBNIC_FW_CAP_RESP_FW_LINK_FEC, fec);
+	fbd->fw_cap.link_speed = speed;
+	fbd->fw_cap.link_fec = fec;
+
+	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
+	if (bmc_present) {
+		struct fbnic_tlv_msg *attr;
+
+		attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
+		if (!attr)
+			return -EINVAL;
+
+		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
+					       attr, 4);
+		if (err)
+			return err;
+
+		get_unsigned_result(FBNIC_FW_CAP_RESP_BMC_ALL_MULTI, all_multi);
+	} else {
+		memset(fbd->fw_cap.bmc_mac_addr, 0,
+		       sizeof(fbd->fw_cap.bmc_mac_addr));
+	}
+
+	fbd->fw_cap.bmc_present = bmc_present;
+
+	if (results[FBNIC_FW_CAP_RESP_BMC_ALL_MULTI] || !bmc_present)
+		fbd->fw_cap.all_multi = all_multi;
+
+	return 0;
+}
+
+static const struct fbnic_tlv_index fbnic_ownership_resp_index[] = {
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_ownership_resp(void *opaque,
+					 struct fbnic_tlv_msg **results)
+{
+	struct fbnic_dev *fbd = (struct fbnic_dev *)opaque;
+
+	/* Count the ownership response as a heartbeat reply */
+	fbd->last_heartbeat_response = jiffies;
+
+	return 0;
+}
+
+static const struct fbnic_tlv_index fbnic_heartbeat_resp_index[] = {
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_heartbeat_resp(void *opaque,
+					 struct fbnic_tlv_msg **results)
+{
+	struct fbnic_dev *fbd = (struct fbnic_dev *)opaque;
+
+	fbd->last_heartbeat_response = jiffies;
+
+	return 0;
+}
+
+static int fbnic_fw_xmit_heartbeat_message(struct fbnic_dev *fbd)
+{
+	unsigned long req_time = jiffies;
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_HEARTBEAT_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		goto free_message;
+
+	fbd->last_heartbeat_request = req_time;
+
+	return err;
+
+free_message:
+	free_page((unsigned long)msg);
+	return err;
+}
+
+static bool fbnic_fw_heartbeat_current(struct fbnic_dev *fbd)
+{
+	unsigned long last_response = fbd->last_heartbeat_response;
+	unsigned long last_request = fbd->last_heartbeat_request;
+
+	return !time_before(last_response, last_request);
+}
+
+int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll)
+{
+	int err = -ETIMEDOUT;
+	int attempts = 50;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	while (attempts--) {
+		msleep(200);
+		if (poll)
+			fbnic_mbx_poll(fbd);
+
+		if (!fbnic_fw_heartbeat_current(fbd))
+			continue;
+
+		/* Place new message on mailbox to elicit a response */
+		err = fbnic_fw_xmit_heartbeat_message(fbd);
+		if (err)
+			dev_warn(fbd->dev,
+				 "Failed to send heartbeat message: %d\n",
+				 err);
+		break;
+	}
+
+	return err;
+}
+
+void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
+{
+	unsigned long last_request = fbd->last_heartbeat_request;
+	int err;
+
+	/* Do not check heartbeat or send another request until current
+	 * period has expired. Otherwise we might start spamming requests.
+	 */
+	if (time_is_after_jiffies(last_request + FW_HEARTBEAT_PERIOD))
+		return;
+
+	/* We already reported no mailbox. Wait for it to come back */
+	if (!fbd->fw_heartbeat_enabled)
+		return;
+
+	/* Was the last heartbeat response long time ago? */
+	if (!fbnic_fw_heartbeat_current(fbd)) {
+		dev_warn(fbd->dev,
+			 "Firmware did not respond to heartbeat message\n");
+		fbd->fw_heartbeat_enabled = false;
+	}
+
+	/* Place new message on mailbox to elicit a response */
+	err = fbnic_fw_xmit_heartbeat_message(fbd);
+	if (err)
+		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
+	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
+			 fbnic_fw_parse_cap_resp),
+	FBNIC_TLV_PARSER(OWNERSHIP_RESP, fbnic_ownership_resp_index,
+			 fbnic_fw_parse_ownership_resp),
+	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
+			 fbnic_fw_parse_heartbeat_resp),
 	FBNIC_TLV_MSG_ERROR
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index c143079f881c..40d314f963ea 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -4,6 +4,7 @@
 #ifndef _FBNIC_FW_H_
 #define _FBNIC_FW_H_
 
+#include <linux/if_ether.h>
 #include <linux/types.h>
 
 struct fbnic_dev;
@@ -17,10 +18,94 @@ struct fbnic_fw_mbx {
 	} buf_info[FBNIC_IPC_MBX_DESC_LEN];
 };
 
+// FW_VER_MAX_SIZE must match ETHTOOL_FWVERS_LEN
+#define FBNIC_FW_VER_MAX_SIZE	                32
+// Formatted version is in the format XX.YY.ZZ_RRR_COMMIT
+#define FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE	(FBNIC_FW_VER_MAX_SIZE - 13)
+#define FBNIC_FW_LOG_MAX_SIZE	                256
+
+struct fbnic_fw_ver {
+	u32 version;
+	char commit[FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE];
+};
+
+struct fbnic_fw_cap {
+	struct {
+		struct fbnic_fw_ver mgmt, bootloader;
+	} running;
+	struct {
+		struct fbnic_fw_ver mgmt, bootloader, undi;
+	} stored;
+	u8	active_slot;
+	u8	bmc_mac_addr[4][ETH_ALEN];
+	u8	bmc_present	: 1;
+	u8	all_multi	: 1;
+	u8	link_speed;
+	u8	link_fec;
+};
+
 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
+int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
+void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+
+#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
+do {									\
+	const u32 __rev_id = _rev_id;					\
+	snprintf(_str, sizeof(_str), "%02lu.%02lu.%02lu-%03lu%s%s",	\
+		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MAJOR, __rev_id),	\
+		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MINOR, __rev_id),	\
+		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_PATCH, __rev_id),	\
+		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_BUILD, __rev_id),	\
+		 _delim, _commit);					\
+} while (0)
 
+#define fbnic_mk_fw_ver_str(_rev_id, _str) \
+	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str)
+
+#define FW_HEARTBEAT_PERIOD		(10 * HZ)
+
+enum {
+	FBNIC_TLV_MSG_ID_HOST_CAP_REQ			= 0x10,
+	FBNIC_TLV_MSG_ID_FW_CAP_RESP			= 0x11,
+	FBNIC_TLV_MSG_ID_OWNERSHIP_REQ			= 0x12,
+	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
+	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
+	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+};
+
+#define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
+#define FBNIC_FW_CAP_RESP_VERSION_MINOR		CSR_GENMASK(23, 16)
+#define FBNIC_FW_CAP_RESP_VERSION_PATCH		CSR_GENMASK(15, 8)
+#define FBNIC_FW_CAP_RESP_VERSION_BUILD		CSR_GENMASK(7, 0)
+enum {
+	FBNIC_FW_CAP_RESP_VERSION			= 0x0,
+	FBNIC_FW_CAP_RESP_BMC_PRESENT			= 0x1,
+	FBNIC_FW_CAP_RESP_BMC_MAC_ADDR			= 0x2,
+	FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY			= 0x3,
+	FBNIC_FW_CAP_RESP_STORED_VERSION		= 0x4,
+	FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT		= 0x5,
+	FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR		= 0x6,
+	FBNIC_FW_CAP_RESP_BMC_ALL_MULTI			= 0x8,
+	FBNIC_FW_CAP_RESP_FW_STATE			= 0x9,
+	FBNIC_FW_CAP_RESP_FW_LINK_SPEED			= 0xa,
+	FBNIC_FW_CAP_RESP_FW_LINK_FEC			= 0xb,
+	FBNIC_FW_CAP_RESP_STORED_COMMIT_STR		= 0xc,
+	FBNIC_FW_CAP_RESP_CMRT_VERSION			= 0xd,
+	FBNIC_FW_CAP_RESP_STORED_CMRT_VERSION		= 0xe,
+	FBNIC_FW_CAP_RESP_CMRT_COMMIT_STR		= 0xf,
+	FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR	= 0x10,
+	FBNIC_FW_CAP_RESP_UEFI_VERSION			= 0x11,
+	FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR		= 0x12,
+	FBNIC_FW_CAP_RESP_MSG_MAX
+};
+
+enum {
+	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
+	FBNIC_FW_OWNERSHIP_MSG_MAX
+};
 #endif /* _FBNIC_FW_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index f5a5076d0f52..0dd955c7c7ff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -11,6 +11,7 @@
 
 int __fbnic_open(struct fbnic_net *fbn)
 {
+	struct fbnic_dev *fbd = fbn->fbd;
 	int err;
 
 	err = fbnic_alloc_napi_vectors(fbn);
@@ -31,7 +32,22 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto free_resources;
 
+	/* Send ownership message and flush to verify FW has seen it */
+	err = fbnic_fw_xmit_ownership_msg(fbd, true);
+	if (err) {
+		dev_warn(fbd->dev,
+			 "Error %d sending host ownership message to the firmware\n",
+			 err);
+		goto free_resources;
+	}
+
+	err = fbnic_fw_init_heartbeat(fbd, false);
+	if (err)
+		goto release_ownership;
+
 	return 0;
+release_ownership:
+	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 free_resources:
 	fbnic_free_resources(fbn);
 free_napi_vectors:
@@ -57,6 +73,8 @@ static int fbnic_stop(struct net_device *netdev)
 
 	fbnic_down(fbn);
 
+	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
+
 	fbnic_free_resources(fbn);
 	fbnic_free_napi_vectors(fbn);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 325b20b232eb..9eda65e04609 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -158,6 +158,30 @@ void fbnic_down(struct fbnic_net *fbn)
 	fbnic_flush(fbn);
 }
 
+static void fbnic_health_check(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+
+	/* As long as the heart is beating the FW is healty */
+	if (fbd->fw_heartbeat_enabled)
+		return;
+
+	/* If the Tx mailbox still has messages sitting in it then there likely
+	 * isn't anything we can do. We will wait until the mailbox is empty to
+	 * report the fault so we can collect the crashlog.
+	 */
+	if (tx_mbx->head != tx_mbx->tail)
+		return;
+
+	/* TBD: Need to add a more thorough recovery here.
+	 *	Specifically I need to verify what all the firmware will have
+	 *	changed since we had setup and it rebooted. May just need to
+	 *	perform a down/up. For now we will just reclaim ownership so
+	 *	the heartbeat can catch the next fault.
+	 */
+	fbnic_fw_xmit_ownership_msg(fbd, true);
+}
+
 static void fbnic_service_task(struct work_struct *work)
 {
 	struct fbnic_dev *fbd = container_of(to_delayed_work(work),
@@ -165,6 +189,10 @@ static void fbnic_service_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	fbnic_fw_check_heartbeat(fbd);
+
+	fbnic_health_check(fbd);
+
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
 



