Return-Path: <netdev+bounces-217059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92857B3735B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058B67A72B3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C02F7466;
	Tue, 26 Aug 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDfka6zE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46D2EE617
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237511; cv=none; b=rumxCDF3sv5VYYAGKnHv1JFDVwlMINVII7TTL+86aBMdISM9zHVs7iBSXvP3UZKxO19YnYEfpHKjIZ2ckKNbtw7wM6ufRqifRT1mWAQy+gQozKeIjxa16OJ9pge/fHLNdP7PkyKDtJ3fWi7nui4YaF0FmzOfelObWD4RmW/1+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237511; c=relaxed/simple;
	bh=ILYUeRyWBFEXgEtwDyf3VN2+nMm0IFiDhgzMNH7lDOg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeEyWMLOuOwmtL14U1SNZe67T4iZZ9Y68B5SYnYnNzyJKjLMnB9ZkEna5dgqpu6BYjHgd8/ISBHxsQ5iLp4ynNJF6PqlPgLsUeMvKl0oNOGYtiyiwVZdU+Qs0phCUfHSOih6PNVd+0lyogMn1X1R0JZYscwWJA/78AIGLjmleN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDfka6zE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-325393d0ddaso3028447a91.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237509; x=1756842309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7Mabgs28/rN5UV6uGG7JlR/JsEFTDubScM4qm/GgKI=;
        b=QDfka6zErEWy81yqUmH6podVxGOK2Gr/nmq4ewB7Mk4jYedk76zyt+feL5f8J8235T
         Ahjq5F4pvpLsFfvMqOWcHALhSGXsWXAblX1IsLEttsrpimFkzxZ9+5zdaNi7Ife0oxuX
         IaKi0CNZqCYy9Yz0bOoYEyeaUkpfgjROFZzYS6kPIv0zEfsS9uogcRtrLAqPVrdRs3+X
         XXsmhwVUgKbUE/i+NdzS4bx6eyB9CTELUmrHcj9AquU5JmimGQg7MBDREA3Y9yu20Bxo
         rPk4T1zjJl3NuRkuPQdsenM9ujU7L1YTnuv5r2IRLc0WevoKjErW9eCv397Xrchuq8QH
         HjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237509; x=1756842309;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7Mabgs28/rN5UV6uGG7JlR/JsEFTDubScM4qm/GgKI=;
        b=XOVldNplIDrJ5RolKfutWDclYmJBAb++v0vYYxJ4M9c6VEuatNXn3ZBN6oaIJ2aXHf
         wP4zPxAKLZEoAxM3qL/QfCHtJsVbuqyZNuvrdshcXKafDLKrW/fGIr9ipQfs5huTpV+O
         OInDJBLXGfyl6/ABfcDLqJePj44H7LBlqquc/YgjnzoHO0CkGF6KUYKnb13/vfZayIwh
         JLOT7G4OZnaVU0H04xVyZRGkQufzWzpoA/Mt8m3w4Cf6nc2wzjycnwiKBKW8t16TlENd
         N1ps2uazZQiVCmobmgPKU9bcVyx4HsvRx5LE2H/C4x1JAEgt2y24yHKLs9bTXoZw5d1n
         ihzg==
X-Gm-Message-State: AOJu0YzdCRRShQRwgKDerZlqHR53p3J1dAPIDlYNZUXBUljcxaFP6Tzt
	jUFTh2nj+Tff+0TeUIQnksiRT4NT48jSRdg9R6dElD0n++i3GA1BwusA
X-Gm-Gg: ASbGncshRGcaWMNg+MrjSh8XY8SM1dcS32E3iKkvB69Zw7W2x9QySkr0+diJolQgJsg
	CuZYg6sCY4ReE8wOHD0+jDkiYbYAi8x0DTPbvqlB/pDtQp/fv9W7XS+eq7EeDiRKRUnGEyu5NAT
	8u0tlRpnWUl8N0ZtBn9uABsgP+1jD+lPK51u86OywFqL1MYAbIz3k3CEnmjTbiAs0TwFJucCfUC
	L7R3z7OkhIuW60ETUszeA+bAirYFvnZR6fN9UK5+9w6hUGip/ypQ+O991vqcZ2fegC1JGvewepm
	+RnpGkid2YU+hnckeU40bfSgVj1qzhr7QtIxwbMHDJgCybwTkyBsD1idh6Xk7qVBwSjfURIDoOs
	LLNp1Kp2yHKO4KK4JGYNTaOAWLSybU8cWm3Vgjqm2/spEfYknofCB6R6elDTcXitish4=
X-Google-Smtp-Source: AGHT+IEol2DmE40nP3FR8RZlu+hQGYOmX3VG3ZMA7kuNDK7MlNLMKJZTSLN7z5acjBc/frqEtwXj1g==
X-Received: by 2002:a17:90b:4cc9:b0:327:60d3:8178 with SMTP id 98e67ed59e1d1-32760d383dbmr1932552a91.3.1756237509336;
        Tue, 26 Aug 2025 12:45:09 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276af0686esm308035a91.26.2025.08.26.12.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:45:08 -0700 (PDT)
Subject: [net-next PATCH 4/4] fbnic: Push local unicast MAC addresses to FW to
 populate TCAMs
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 26 Aug 2025 12:45:07 -0700
Message-ID: 
 <175623750782.2246365.9178255870985916357.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
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

The MACDA TCAM can only be accessed by one entity at a time and as such we
cannot have simultaneous reads from the firmware to probe for changes from
the host. As such we have to send a message indicating what the state of
the MACDA is to the firmware when we updated it so that the firmware can
sync up the TCAMs it owns to route BMC packets to the host.

To support that we are adding a new message that is invoked when we write
the MACDA that will notify the firmware of updates from the host and allow
it to sync up the TCAM configuration to match the one on the host side.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |  103 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |   18 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   23 ++++++
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index c7d255a095f0..6e580654493c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1413,6 +1413,109 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 	} while (time_is_after_jiffies(timeout));
 }
 
+int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd)
+{
+	struct fbnic_tlv_msg *mac_array;
+	int i, addr_count = 0, err;
+	struct fbnic_tlv_msg *msg;
+	u32 rx_flags = 0;
+
+	/* Nothing to do if there is no FW to sync with */
+	if (!fbd->mbx[FBNIC_IPC_MBX_TX_IDX].ready)
+		return 0;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_RPC_MAC_SYNC_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	mac_array = fbnic_tlv_attr_nest_start(msg,
+					      FBNIC_FW_RPC_MAC_SYNC_UC_ARRAY);
+	if (!mac_array)
+		goto free_message_nospc;
+
+	/* Populate the unicast MAC addrs and capture PROMISC/ALLMULTI flags */
+	for (addr_count = 0, i = FBNIC_RPC_TCAM_MACDA_PROMISC_IDX;
+	     i >= fbd->mac_addr_boundary; i--) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (mac_addr->state != FBNIC_TCAM_S_VALID)
+			continue;
+		if (test_bit(FBNIC_MAC_ADDR_T_ALLMULTI, mac_addr->act_tcam))
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_ALLMULTI;
+		if (test_bit(FBNIC_MAC_ADDR_T_PROMISC, mac_addr->act_tcam))
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_PROMISC;
+		if (!test_bit(FBNIC_MAC_ADDR_T_UNICAST, mac_addr->act_tcam))
+			continue;
+		if (addr_count == FW_RPC_MAC_SYNC_UC_ARRAY_SIZE) {
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_PROMISC;
+			continue;
+		}
+
+		err = fbnic_tlv_attr_put_value(mac_array,
+					       FBNIC_FW_RPC_MAC_SYNC_MAC_ADDR,
+					       mac_addr->value.addr8,
+					       ETH_ALEN);
+		if (err)
+			goto free_message;
+		addr_count++;
+	}
+
+	/* Close array */
+	fbnic_tlv_attr_nest_stop(msg);
+
+	mac_array = fbnic_tlv_attr_nest_start(msg,
+					      FBNIC_FW_RPC_MAC_SYNC_MC_ARRAY);
+	if (!mac_array)
+		goto free_message_nospc;
+
+	/* Repeat for multicast addrs, record BROADCAST/ALLMULTI flags */
+	for (addr_count = 0, i = FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;
+	     i < fbd->mac_addr_boundary; i++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (mac_addr->state != FBNIC_TCAM_S_VALID)
+			continue;
+		if (test_bit(FBNIC_MAC_ADDR_T_BROADCAST, mac_addr->act_tcam))
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_BROADCAST;
+		if (test_bit(FBNIC_MAC_ADDR_T_ALLMULTI, mac_addr->act_tcam))
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_ALLMULTI;
+		if (!test_bit(FBNIC_MAC_ADDR_T_MULTICAST, mac_addr->act_tcam))
+			continue;
+		if (addr_count == FW_RPC_MAC_SYNC_MC_ARRAY_SIZE) {
+			rx_flags |= FW_RPC_MAC_SYNC_RX_FLAGS_ALLMULTI;
+			continue;
+		}
+
+		err = fbnic_tlv_attr_put_value(mac_array,
+					       FBNIC_FW_RPC_MAC_SYNC_MAC_ADDR,
+					       mac_addr->value.addr8,
+					       ETH_ALEN);
+		if (err)
+			goto free_message;
+		addr_count++;
+	}
+
+	/* Close array */
+	fbnic_tlv_attr_nest_stop(msg);
+
+	/* Report flags at end of list */
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_FW_RPC_MAC_SYNC_RX_FLAGS,
+				     rx_flags);
+	if (err)
+		goto free_message;
+
+	/* Send message of to FW notifying it of current RPC config */
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		goto free_message;
+	return 0;
+free_message_nospc:
+	err = -ENOSPC;
+free_message:
+	free_page((unsigned long)msg);
+	return err;
+}
+
 void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 const size_t str_sz)
 {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index e9a2bf489944..ec67b80809b0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -53,6 +53,7 @@ struct fbnic_fw_cap {
 	u8	bmc_mac_addr[4][ETH_ALEN];
 	u8	bmc_present		: 1;
 	u8	need_bmc_tcam_reinit	: 1;
+	u8	need_bmc_macda_sync	: 1;
 	u8	all_multi		: 1;
 	u8	link_speed;
 	u8	link_fec;
@@ -98,6 +99,7 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 				 struct fbnic_fw_completion *cmpl_data);
 int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
 			    bool send_log_history);
+int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd);
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
@@ -144,6 +146,7 @@ enum {
 	FBNIC_TLV_MSG_ID_LOG_SEND_LOGS_REQ		= 0x43,
 	FBNIC_TLV_MSG_ID_LOG_MSG_REQ			= 0x44,
 	FBNIC_TLV_MSG_ID_LOG_MSG_RESP			= 0x45,
+	FBNIC_TLV_MSG_ID_RPC_MAC_SYNC_REQ		= 0x46,
 };
 
 #define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
@@ -236,4 +239,19 @@ enum {
 	FBNIC_FW_LOG_MSG_MAX
 };
 
+enum {
+	FBNIC_FW_RPC_MAC_SYNC_RX_FLAGS		= 0x0,
+	FBNIC_FW_RPC_MAC_SYNC_UC_ARRAY		= 0x1,
+	FBNIC_FW_RPC_MAC_SYNC_MC_ARRAY		= 0x2,
+	FBNIC_FW_RPC_MAC_SYNC_MAC_ADDR		= 0x3,
+	FBNIC_FW_RPC_MAC_SYNC_MSG_MAX
+};
+
+#define FW_RPC_MAC_SYNC_RX_FLAGS_PROMISC	1
+#define FW_RPC_MAC_SYNC_RX_FLAGS_ALLMULTI	2
+#define FW_RPC_MAC_SYNC_RX_FLAGS_BROADCAST	4
+
+#define FW_RPC_MAC_SYNC_UC_ARRAY_SIZE		8
+#define FW_RPC_MAC_SYNC_MC_ARRAY_SIZE		8
+
 #endif /* _FBNIC_FW_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index d821625d602c..4284b3cb7fcc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -240,11 +240,21 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 
 void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 {
+	int err;
+
 	if (fbd->fw_cap.need_bmc_tcam_reinit) {
 		fbnic_bmc_rpc_init(fbd);
 		__fbnic_set_rx_mode(fbd);
 		fbd->fw_cap.need_bmc_tcam_reinit = false;
 	}
+
+	if (fbd->fw_cap.need_bmc_macda_sync) {
+		err = fbnic_fw_xmit_rpc_macda_sync(fbd);
+		if (err)
+			dev_warn(fbd->dev,
+				 "Writing MACDA table to FW failed, err: %d\n", err);
+		fbd->fw_cap.need_bmc_macda_sync = false;
+	}
 }
 
 #define FBNIC_ACT1_INIT(_l4, _udp, _ip, _v6)		\
@@ -607,7 +617,7 @@ static void fbnic_write_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
 
 void fbnic_write_macda(struct fbnic_dev *fbd)
 {
-	int idx;
+	int idx, updates = 0;
 
 	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
 		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
@@ -616,6 +626,9 @@ void fbnic_write_macda(struct fbnic_dev *fbd)
 		if (!(mac_addr->state & FBNIC_TCAM_S_UPDATE))
 			continue;
 
+		/* Record update count */
+		updates++;
+
 		/* Clear by writing 0s. */
 		if (mac_addr->state == FBNIC_TCAM_S_DELETE) {
 			/* Invalidate entry and clear addr state info */
@@ -629,6 +642,14 @@ void fbnic_write_macda(struct fbnic_dev *fbd)
 
 		mac_addr->state = FBNIC_TCAM_S_VALID;
 	}
+
+	/* If reinitializing the BMC TCAM we are doing an initial update */
+	if (fbd->fw_cap.need_bmc_tcam_reinit)
+		updates++;
+
+	/* If needed notify firmware of changes to MACDA TCAM */
+	if (updates != 0 && fbnic_bmc_present(fbd))
+		fbd->fw_cap.need_bmc_macda_sync = true;
 }
 
 static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)



