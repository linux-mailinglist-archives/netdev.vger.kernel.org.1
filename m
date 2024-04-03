Return-Path: <netdev+bounces-84606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24E89799C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C698F1F27151
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4856155738;
	Wed,  3 Apr 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUK05O+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013715574B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174951; cv=none; b=CoEj8UPol3VP2L/6A3kU4M04LaHR8IzL7tayZiCcACZXBNfwI+y5a4/mDz59xDcZgxDeN46DBvFnkRgouIXwzvctivJ+Q2ysysYBQMPthqUS0Q78AQE/RwGfolU2KUwSMM4sK44stcQssLiKL6kEY0QFMvAW1Je+LThOZu6cdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174951; c=relaxed/simple;
	bh=23KmmaYiqQkr0tj+OAHLJ0KuHfoP+Ff3x59fVhsQQIs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTIseRsvyRI04ppAxvX7CWUozENafF0m3Kfb8qGmhjKP7apJbrKdGFFJr5BjrAo3i4X7uuYozvnrvUyMYAniZZUo+vEuYZfB8uGMKnvx483CSM6kJEMtD/iyYx5len3uY6XpJCUCR97i1opjvdbpx6IrO/H8v/Rbkgi131wXnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUK05O+c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0411c0a52so1964075ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174949; x=1712779749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iu0hQ67fs24G1ZXplfD2ETIFWbhf1FY58TfffN4VD/Q=;
        b=UUK05O+cgS16iCfBXJnlSi7aNp7Se/3UycVUBMQ1iopnsyB9wg1oK5eMtjR648Yjv6
         achuI/SoyZYff2RPF2zHtbeR6B7rS397SVVvAkueBgS1fSB+VQnK8YkrviVBVyxiD8I0
         9A8gihfe4cuTRHUlyGrYb72Q+drbu1L9S65ZrDuGVB2v1BmgsGCnyAuDRff9KgOiFmEg
         wvfaTqU7XPaNKhV23mIvPXBwX4fx8iqnXOk0jDQ0jhBfPVjGv2JgSVBVWzURXuKivEpp
         oicaAoGW0rX3AZ8/OpKAVMswXKsSz1ID16/yqdmbpbzZ8oIY8l4hpIg3u969Mnd9dzFB
         ZKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174949; x=1712779749;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iu0hQ67fs24G1ZXplfD2ETIFWbhf1FY58TfffN4VD/Q=;
        b=fsL/HgAT69WHLqKjLETg7gcmyee65n8YwZWSmjPwYgGdwu+NV3+tFCEJPjelklGEnN
         1SVw90m3HqZvWt1oLlkUt4HRSyarkvc0J/PLKyTNnz9Yrvh2d1D4Zw/0AM1bIdv44tX2
         7bACYv5IOv6bt/I4xpKXq2ibIVG6cP2c2OJnJx1cmT7zrVnig98BqnBb/TGJ9Bmwj1YD
         qSXP8KysTLKKdCOjF0Q3gEKwM4I9LIZc6UhsiUWECW6UnL9zp7HGNekK+J+ThjDV/Heo
         7NKM1U7SaVHghxNC/XK8dkBBLR1QavvMGjsG3hBJ6NnPzqmok6TARWbgoyGgpBwtFpeO
         gAsA==
X-Gm-Message-State: AOJu0YxO6PrwmBS/WOKELrUNpLOxqJc2XDYJPRlh5bqit3tvdV1lCWGM
	zt9fbMUu+BrjI2wBIlNEaijVJJGCT4TZpFM7nWh/SKdNTFgjBPeI
X-Google-Smtp-Source: AGHT+IGo7DW7QnLAj3TZaL4niwfxNVQ2D+ywyUBY5AqD1sdn3czZdWjqQlA4HAmoTtBu3ldMgOyChg==
X-Received: by 2002:a17:902:d54e:b0:1dd:de1a:bd02 with SMTP id z14-20020a170902d54e00b001ddde1abd02mr314220plf.41.1712174948794;
        Wed, 03 Apr 2024 13:09:08 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001e0b2851db7sm13745899plb.105.2024.04.03.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:09:08 -0700 (PDT)
Subject: [net-next PATCH 10/15] eth: fbnic: Add initial messaging to notify FW
 of our presence
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:09:07 -0700
Message-ID: 
 <171217494704.1598374.3204376739007363054.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
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

After the driver loads we need to get some intitial capabilities from the
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
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c     |  409 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h     |   85 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |   28 ++
 6 files changed, 553 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 92a36959547c..4f18d703dae8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -25,9 +25,14 @@ struct fbnic_dev {
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
index 33832a4f78ea..8b035c4e068e 100644
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
index 71647044aa23..4c3098364fed 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bitfield.h>
+#include <linux/etherdevice.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
@@ -184,6 +185,22 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
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
@@ -205,6 +222,60 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 	tx_mbx->head = head;
 }
 
+/**
+ * fbnic_fw_xmit_simple_msg - Transmit a simple single TLV message w/o data
+ * @fbd: FBNIC device structure
+ * @msg_type: ENUM value indicating message type to send
+ *
+ * Returns the following values:
+ * -EOPNOTSUPP: Is not ASIC so mailbox is not supported
+ * -ENODEV: Device I/O error
+ * -ENOMEM: Failed to allocate message
+ * -EBUSY: No space in mailbox
+ * -ENOSPC: DMA mapping failed
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
+ * Returns NULL on failure to allocate, error pointer on error, or pointer
+ * to new TLV test message.
+ *
+ * Sends a single TLV header indicating the host wants the firmware to
+ * confirm the capabilities and version.
+ **/
+static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
+{
+	int err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
+
+	/* return 0 if we are not calling this on ASIC */
+	return (err == -EOPNOTSUPP) ? 0 : err;
+}
+
 static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
@@ -220,6 +291,16 @@ static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
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
 
@@ -240,7 +321,335 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 		fbnic_mbx_postinit_desc_ring(fbd, i);
 }
 
+/**
+ * fbnic_fw_xmit_ownership_msg - Create and transmit a host ownership message
+ * to FW mailbox
+ *
+ * @fbd: FBNIC device structure
+ * @take_ownership: take/release the ownership
+ *
+ * Returns 0 on success, negative value on failure
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
+	/* set heartbeat detection based on if we are taking ownership */
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
+	/* make sure we have enough room to process all the MAC addresses */
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
+				 "Failed to send heartbeat message\n");
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
index 171b159cc006..bbc2f21060dc 100644
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
index d6598c81a5f9..8408f0d5f54a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -160,6 +160,30 @@ void fbnic_down(struct fbnic_net *fbn)
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
@@ -167,6 +191,10 @@ static void fbnic_service_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	fbnic_fw_check_heartbeat(fbd);
+
+	fbnic_health_check(fbd);
+
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
 



