Return-Path: <netdev+bounces-247204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3019CF5C12
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8352430B65EC
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD11311C07;
	Mon,  5 Jan 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="achfs43H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D961311C33
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650353; cv=none; b=cIuKJ+vaykb+0wxolcUJ3tLv0CWuJ9pEwokewW+AKuAuyGQ1xJS1islH7E+gchWu4maGdNGCdo/EJAP4gXo6B1txO+iD7ivcK25Wtal6biBoIM4w/wPUOi4cYcLfooeF9hnvEsT6eCv481lIZWju2fuOTUM8b2JMl5ke52imSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650353; c=relaxed/simple;
	bh=neTYV3F9ZJSpb0g2g0XVoYfc6t7ZE+5uPWXE7zIjKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZRYfXY6x0mLygZWmFMsht5dOPNkSHAQgFKBPsO10Ye+viOE0AipaotoLUJlLoNQ0FBTI9dTA5N/EzYNMa3KzOZaBEvPHuTwsh6nBlyEHQOf2AweWrS1P8h4aGUqiJzYKHCA4cW/JpWwYkW80Pxu/ftL1IoFUx6wc2uC+EXUt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=achfs43H; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so401367a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650350; x=1768255150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6vPZa6w8IXlNnHA2ggC4KViv8K6wHJ9mSMZQGqYXj4=;
        b=lCSPKtW+Wtud56WzETpviqUY6j9wj8waSwhPo9pFOExiId4KRstvmFgn6yy0nz8qm3
         QS/GDSsfM6MfTNFviy854GlBCTqDou4l14WTaRiG5aGeSpxBeQpE3gVwXsiWyq/06gW6
         CZUp8ZI/Vl57c0yYIOUUtKUuqdqNxYf6xwY0V2k9Rcv/UytU/jMs+F4oNNkggGxQ3mbu
         Xm3vksk+ovDFkUYMDIUdScHYZeBQjVgBuHQezLs1nzdNKzK1tX4xIPmIUzqOSkJwjOdP
         AgxxdJ+EgAHwOVHCEg55kTa6yN+i8d6D5fNuZpzQ99h2Se+QPKU+RYPWqxsiPebLPu5v
         z+FA==
X-Gm-Message-State: AOJu0Yxw1mI/f7jUl91V94wx0MWyOPFjsuC5WAerxPqCpyAqptcWa1FT
	xaa1jSSgaKiKk3E3HQgkP5KTOiuRshBHFLBXPIBSYU55xVRjyBeY5TutPlwi/z0T6vBzaAd7Hny
	eb+xXzQr3UcxipEym9w3LRNhZKj7kRAA1jC+YcCzAwp96WiispnJxzIVr4Q8+z14mNk9Wq0EelA
	RCLz+jBO1R+ul1ptSOYHmjUxwum0A6hLIsjN7vRu9XGlThexP3bQjaw0af3VHejNROsA4Dd+Riv
	DUSQAh6DfQ=
X-Gm-Gg: AY/fxX6ahP0J/K8GJ0GOt9dEZI502FRE3HKRVWdamRE+DvIREQ8rCrSRZwzOySWR/q7
	doXBTkwCwNMZIP0q9BgiRDHOnzKB2d/KsYia2S+JDucPUr9zzWsMKeNp9VrCl+giqMaZqSZ5NyU
	fUTT/l7jRyKWYpw8pjyUaXpWWljqwPdBFM+E0OhDw1ODuZE6FsQK2PqK02wlKK2QzZa6Gd3MBk+
	bZ7/+gwPruvQOCLNspvO1rVGY1+Dlv13dEJ0JvRGNRhob7PZwIN8asCJKdUds8wxpnXOhBlYs7b
	9sCEASawLl7zw7AnAKlXxUGnt/0C0RVmhn1J2QJ20m0NOjofhgc2CJadSE7dSJqQ3qTCrhqFy/N
	4+f/OzAGIP0pEbSqdQ0aGPXC3xVktrHcw/Y629ZT3bhudvlnEmhLKeTfK8F0ejOkdbekHU6qB5h
	W+d6fFcQikT1FjHgerll0X3y3NLqFWpexPtd2dYhsaHQ==
X-Google-Smtp-Source: AGHT+IHlUSp6G8RLCGagYr2J/YzXbDRlulaz8WvodPqiNLPKNAzTY9trRflSMovJsgRMs0tmRqZWfnfAqopD
X-Received: by 2002:a17:90b:2801:b0:343:a631:28b1 with SMTP id 98e67ed59e1d1-34f5f2820dfmr588789a91.16.1767650350435;
        Mon, 05 Jan 2026 13:59:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5fb2e0a2sm62057a91.6.2026.01.05.13.59.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-880501dcc67so17099126d6.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650349; x=1768255149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6vPZa6w8IXlNnHA2ggC4KViv8K6wHJ9mSMZQGqYXj4=;
        b=achfs43Hyf60xVJGF7E5IwtkQ7iAKP2mw7y6IRuQ/RA8aj2FSz3Z6joS9PYRpanOl3
         wNrjfcZJfslXVzGjVtH6p0JmtV46uoI5G0J84P9fdLOWU3B/fDJsTnVCsJfMeclkmclL
         obCkLpTF52I50VgwtFihbJvG9UIs1llNaUzeI=
X-Received: by 2002:a05:622a:5a94:b0:4ed:5ed:2527 with SMTP id d75a77b69052e-4ffa76d83edmr15254111cf.3.1767650349189;
        Mon, 05 Jan 2026 13:59:09 -0800 (PST)
X-Received: by 2002:a05:622a:5a94:b0:4ed:5ed:2527 with SMTP id d75a77b69052e-4ffa76d83edmr15253901cf.3.1767650348749;
        Mon, 05 Jan 2026 13:59:08 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:08 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 1/6] bnxt_en: Update FW interface to 1.10.3.151
Date: Mon,  5 Jan 2026 13:58:28 -0800
Message-ID: <20260105215833.46125-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The main changes are the new HWRM_PORT_PHY_FDRSTAT command to collect
FEC histogram bins and the new HWRM_NVM_DEFRAG command to defragment the
NVRAM.  There is also a minor name change in struct hwrm_vnic_cfg_input
that requires updating the bnxt_re driver's main.c.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c |   4 +-
 include/linux/bnxt/hsi.h             | 167 ++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..ee882456319d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -595,10 +595,10 @@ int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_CFG);
 
 	req.flags = cpu_to_le32(VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE);
-	req.enables = cpu_to_le32(VNIC_CFG_REQ_ENABLES_RAW_QP_ID |
+	req.enables = cpu_to_le32(VNIC_CFG_REQ_ENABLES_QP_ID |
 				  VNIC_CFG_REQ_ENABLES_MRU);
 	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
-	req.raw_qp_id = cpu_to_le32(qp_id);
+	req.qp_id = cpu_to_le32(qp_id);
 	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
 
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 47c34990cf23..74a6bf278d88 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -187,6 +187,8 @@ struct cmd_nums {
 	#define HWRM_RING_QCFG                            0x63UL
 	#define HWRM_RESERVED5                            0x64UL
 	#define HWRM_RESERVED6                            0x65UL
+	#define HWRM_PORT_ADSM_QSTATES                    0x66UL
+	#define HWRM_PORT_EVENTS_LOG                      0x67UL
 	#define HWRM_VNIC_RSS_COS_LB_CTX_ALLOC            0x70UL
 	#define HWRM_VNIC_RSS_COS_LB_CTX_FREE             0x71UL
 	#define HWRM_QUEUE_MPLS_QCAPS                     0x80UL
@@ -235,7 +237,7 @@ struct cmd_nums {
 	#define HWRM_PORT_PHY_MDIO_BUS_ACQUIRE            0xb7UL
 	#define HWRM_PORT_PHY_MDIO_BUS_RELEASE            0xb8UL
 	#define HWRM_PORT_QSTATS_EXT_PFC_WD               0xb9UL
-	#define HWRM_RESERVED7                            0xbaUL
+	#define HWRM_PORT_QSTATS_EXT_PFC_ADV              0xbaUL
 	#define HWRM_PORT_TX_FIR_CFG                      0xbbUL
 	#define HWRM_PORT_TX_FIR_QCFG                     0xbcUL
 	#define HWRM_PORT_ECN_QSTATS                      0xbdUL
@@ -271,6 +273,7 @@ struct cmd_nums {
 	#define HWRM_PORT_EP_TX_CFG                       0xdbUL
 	#define HWRM_PORT_CFG                             0xdcUL
 	#define HWRM_PORT_QCFG                            0xddUL
+	#define HWRM_PORT_DSC_COLLECTION                  0xdeUL
 	#define HWRM_PORT_MAC_QCAPS                       0xdfUL
 	#define HWRM_TEMP_MONITOR_QUERY                   0xe0UL
 	#define HWRM_REG_POWER_QUERY                      0xe1UL
@@ -280,6 +283,7 @@ struct cmd_nums {
 	#define HWRM_MONITOR_PAX_HISTOGRAM_COLLECT        0xe5UL
 	#define HWRM_STAT_QUERY_ROCE_STATS                0xe6UL
 	#define HWRM_STAT_QUERY_ROCE_STATS_EXT            0xe7UL
+	#define HWRM_MONITOR_DEVICE_HEALTH                0xe8UL
 	#define HWRM_WOL_FILTER_ALLOC                     0xf0UL
 	#define HWRM_WOL_FILTER_FREE                      0xf1UL
 	#define HWRM_WOL_FILTER_QCFG                      0xf2UL
@@ -640,8 +644,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 133
-#define HWRM_VERSION_STR "1.10.3.133"
+#define HWRM_VERSION_RSVD 151
+#define HWRM_VERSION_STR "1.10.3.151"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -1416,7 +1420,8 @@ struct hwrm_async_event_cmpl_error_report_base {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DB_DROP                       0x8UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MD_TEMP                       0x9UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR                      0xaUL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_L2_TX_RING                    0xbUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_L2_TX_RING
 };
 
 /* hwrm_async_event_cmpl_error_report_pause_storm (size:128b/16B) */
@@ -1934,7 +1939,9 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_COMPLIANCE_SUPPORTED         0x100UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED             0x200UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_SECURE_ATS_SUPPORTED         0x400UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MBUF_STATS_SUPPORTED              0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MBUF_DATA_SUPPORTED               0x800UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_CMPL_TS_SUPPORTED            0x1000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_ST_SUPPORTED                 0x2000UL
 	__le16	max_roce_vfs;
 	__le16	max_crypto_rx_flow_filters;
 	u8	unused_3[3];
@@ -4441,7 +4448,10 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
-	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_224 0x7d3UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_224 0xfa3UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_224 0x1f43UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_224
 	__le16	auto_link_speeds2_mask;
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_1GB                0x1UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_10GB               0x2UL
@@ -4457,7 +4467,11 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_112     0x800UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_112     0x1000UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_800GB_PAM4_112     0x2000UL
-	u8	unused_2[6];
+	__le16	auto_link_speeds2_ext_mask;
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_EXT_MASK_200GB_PAM4_224     0x1UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_EXT_MASK_400GB_PAM4_224     0x2UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_EXT_MASK_800GB_PAM4_224     0x4UL
+	u8	unused_2[4];
 };
 
 /* hwrm_port_phy_cfg_output (size:128b/16B) */
@@ -4491,7 +4505,7 @@ struct hwrm_port_phy_qcfg_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_port_phy_qcfg_output (size:832b/104B) */
+/* hwrm_port_phy_qcfg_output (size:896b/112B) */
 struct hwrm_port_phy_qcfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -4501,14 +4515,17 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_LINK_NO_LINK 0x0UL
 	#define PORT_PHY_QCFG_RESP_LINK_SIGNAL  0x1UL
 	#define PORT_PHY_QCFG_RESP_LINK_LINK    0x2UL
-	#define PORT_PHY_QCFG_RESP_LINK_LAST   PORT_PHY_QCFG_RESP_LINK_LINK
+	#define PORT_PHY_QCFG_RESP_LINK_NO_SD   0x3UL
+	#define PORT_PHY_QCFG_RESP_LINK_NO_LOCK 0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_LAST   PORT_PHY_QCFG_RESP_LINK_NO_LOCK
 	u8	active_fec_signal_mode;
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK                0xfUL
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_SFT                 0
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ                   0x0UL
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4                  0x1UL
 	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112              0x2UL
-	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST                 PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_224              0x3UL
+	#define PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST                 PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_224
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK                 0xf0UL
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_SFT                  4
 	#define PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE        (0x0UL << 4)
@@ -4699,7 +4716,9 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEER8     0x3bUL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEFR8     0x3cUL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8     0x3dUL
-	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEDR4     0x3eUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEFR4     0x3fUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEFR4
 	u8	media_type;
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN   0x0UL
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP        0x1UL
@@ -4859,7 +4878,10 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
 	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
 	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
-	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_200GB_PAM4_224 0x7d3UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_400GB_PAM4_224 0xfa3UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_224 0x1f43UL
+	#define PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_QCFG_RESP_FORCE_LINK_SPEEDS2_800GB_PAM4_224
 	__le16	auto_link_speeds2;
 	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_1GB                0x1UL
 	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_10GB               0x2UL
@@ -4876,6 +4898,16 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_400GB_PAM4_112     0x1000UL
 	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_800GB_PAM4_112     0x2000UL
 	u8	active_lanes;
+	u8	rsvd1;
+	__le16	support_speeds2_ext;
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_EXT_200GB_PAM4_224     0x1UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_EXT_400GB_PAM4_224     0x2UL
+	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_EXT_800GB_PAM4_224     0x4UL
+	__le16	auto_link_speeds2_ext;
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_EXT_200GB_PAM4_224     0x1UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_EXT_400GB_PAM4_224     0x2UL
+	#define PORT_PHY_QCFG_RESP_AUTO_LINK_SPEEDS2_EXT_800GB_PAM4_224     0x4UL
+	u8	rsvd2[3];
 	u8	valid;
 };
 
@@ -5478,7 +5510,7 @@ struct hwrm_port_phy_qcaps_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_port_phy_qcaps_output (size:320b/40B) */
+/* hwrm_port_phy_qcaps_output (size:384b/48B) */
 struct hwrm_port_phy_qcaps_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -5563,6 +5595,10 @@ struct hwrm_port_phy_qcaps_output {
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED         0x4UL
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED           0x8UL
 	#define PORT_PHY_QCAPS_RESP_FLAGS2_REMOTE_LPBK_UNSUPPORTED     0x10UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_ADV_STATS_SUPPORTED     0x20UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_ADSM_REPORT_SUPPORTED       0x40UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PM_EVENT_LOG_SUPPORTED      0x80UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_FDRSTAT_CMD_SUPPORTED       0x100UL
 	u8	internal_port_cnt;
 	u8	unused_0;
 	__le16	supported_speeds2_force_mode;
@@ -5595,7 +5631,15 @@ struct hwrm_port_phy_qcaps_output {
 	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_200GB_PAM4_112     0x800UL
 	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_400GB_PAM4_112     0x1000UL
 	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_AUTO_MODE_800GB_PAM4_112     0x2000UL
-	u8	unused_1[3];
+	__le16	supported_speeds2_ext_force_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_FORCE_MODE_200GB_PAM4_224     0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_FORCE_MODE_400GB_PAM4_224     0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_FORCE_MODE_800GB_PAM4_224     0x4UL
+	__le16	supported_speeds2_ext_auto_mode;
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_AUTO_MODE_200GB_PAM4_224     0x1UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_AUTO_MODE_400GB_PAM4_224     0x2UL
+	#define PORT_PHY_QCAPS_RESP_SUPPORTED_SPEEDS2_EXT_AUTO_MODE_800GB_PAM4_224     0x4UL
+	u8	unused_1[7];
 	u8	valid;
 };
 
@@ -6051,6 +6095,58 @@ struct hwrm_port_led_qcaps_output {
 	u8	valid;
 };
 
+/* hwrm_port_phy_fdrstat_input (size:192b/24B) */
+struct hwrm_port_phy_fdrstat_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	port_id;
+	__le16	rsvd[2];
+	__le16	ops;
+	#define PORT_PHY_FDRSTAT_REQ_OPS_START   0x0UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_STOP    0x1UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_CLEAR   0x2UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_COUNTER 0x3UL
+	#define PORT_PHY_FDRSTAT_REQ_OPS_LAST   PORT_PHY_FDRSTAT_REQ_OPS_COUNTER
+};
+
+/* hwrm_port_phy_fdrstat_output (size:3072b/384B) */
+struct hwrm_port_phy_fdrstat_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le64	start_time;
+	__le64	end_time;
+	__le64	cmic_start_time;
+	__le64	cmic_end_time;
+	__le64	accumulated_uncorrected_codewords;
+	__le64	accumulated_corrected_codewords;
+	__le64	accumulated_total_codewords;
+	__le64	accumulated_symbol_errors;
+	__le64	accumulated_codewords_err_s[17];
+	__le64	uncorrected_codewords;
+	__le64	corrected_codewords;
+	__le64	total_codewords;
+	__le64	symbol_errors;
+	__le64	codewords_err_s[17];
+	__le32	window_size;
+	__le16	unused_0[1];
+	u8	unused_1;
+	u8	valid;
+};
+
+/* hwrm_port_phy_fdrstat_cmd_err (size:64b/8B) */
+struct hwrm_port_phy_fdrstat_cmd_err {
+	u8	code;
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_UNKNOWN     0x0UL
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_NOT_STARTED 0x1UL
+	#define PORT_PHY_FDRSTAT_CMD_ERR_CODE_LAST       PORT_PHY_FDRSTAT_CMD_ERR_CODE_NOT_STARTED
+	u8	unused_0[7];
+};
+
 /* hwrm_port_mac_qcaps_input (size:192b/24B) */
 struct hwrm_port_mac_qcaps_input {
 	__le16	req_type;
@@ -6912,6 +7008,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_FLAGS_RSS_DFLT_CR_MODE                     0x20UL
 	#define VNIC_CFG_REQ_FLAGS_ROCE_MIRRORING_CAPABLE_VNIC_MODE     0x40UL
 	#define VNIC_CFG_REQ_FLAGS_PORTCOS_MAPPING_MODE                 0x80UL
+	#define VNIC_CFG_REQ_FLAGS_DEST_QP                              0x100UL
 	__le32	enables;
 	#define VNIC_CFG_REQ_ENABLES_DFLT_RING_GRP            0x1UL
 	#define VNIC_CFG_REQ_ENABLES_RSS_RULE                 0x2UL
@@ -6923,7 +7020,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_ENABLES_QUEUE_ID                 0x80UL
 	#define VNIC_CFG_REQ_ENABLES_RX_CSUM_V2_MODE          0x100UL
 	#define VNIC_CFG_REQ_ENABLES_L2_CQE_MODE              0x200UL
-	#define VNIC_CFG_REQ_ENABLES_RAW_QP_ID                0x400UL
+	#define VNIC_CFG_REQ_ENABLES_QP_ID                    0x400UL
 	__le16	vnic_id;
 	__le16	dflt_ring_grp;
 	__le16	rss_rule;
@@ -6943,7 +7040,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_L2_CQE_MODE_COMPRESSED 0x1UL
 	#define VNIC_CFG_REQ_L2_CQE_MODE_MIXED      0x2UL
 	#define VNIC_CFG_REQ_L2_CQE_MODE_LAST      VNIC_CFG_REQ_L2_CQE_MODE_MIXED
-	__le32	raw_qp_id;
+	__le32	qp_id;
 };
 
 /* hwrm_vnic_cfg_output (size:128b/16B) */
@@ -7409,6 +7506,8 @@ struct hwrm_ring_alloc_input {
 	#define RING_ALLOC_REQ_FLAGS_DISABLE_CQ_OVERFLOW_DETECTION     0x2UL
 	#define RING_ALLOC_REQ_FLAGS_NQ_DBR_PACING                     0x4UL
 	#define RING_ALLOC_REQ_FLAGS_TX_PKT_TS_CMPL_ENABLE             0x8UL
+	#define RING_ALLOC_REQ_FLAGS_DPI_ROCE_MANAGED                  0x10UL
+	#define RING_ALLOC_REQ_FLAGS_TIMER_RESET                       0x20UL
 	__le64	page_tbl_addr;
 	__le32	fbo;
 	u8	page_size;
@@ -7583,6 +7682,7 @@ struct hwrm_ring_aggint_qcaps_output {
 	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_CMPL_AGGR_DMA_TMR                0x40UL
 	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_CMPL_AGGR_DMA_TMR_DURING_INT     0x80UL
 	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_NUM_CMPL_AGGR_INT                0x100UL
+	#define RING_AGGINT_QCAPS_RESP_CMPL_PARAMS_TMR_RESET_ON_ALLOC               0x200UL
 	__le32	nq_params;
 	#define RING_AGGINT_QCAPS_RESP_NQ_PARAMS_INT_LAT_TMR_MIN     0x1UL
 	__le16	num_cmpl_dma_aggr_min;
@@ -10325,6 +10425,9 @@ struct hwrm_dbg_coredump_retrieve_input {
 	__le16	instance;
 	__le16	unused_1;
 	u8	seg_flags;
+	#define DBG_COREDUMP_RETRIEVE_REQ_SFLAG_LIVE_DATA        0x1UL
+	#define DBG_COREDUMP_RETRIEVE_REQ_SFLAG_CRASHED_DATA     0x2UL
+	#define DBG_COREDUMP_RETRIEVE_REQ_SFLAG_NO_COMPRESS      0x4UL
 	u8	unused_2;
 	__le16	unused_3;
 	__le32	unused_4;
@@ -10926,6 +11029,38 @@ struct hwrm_nvm_set_variable_cmd_err {
 	u8	unused_0[7];
 };
 
+/* hwrm_nvm_defrag_input (size:192b/24B) */
+struct hwrm_nvm_defrag_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define NVM_DEFRAG_REQ_FLAGS_DEFRAG     0x1UL
+	u8	unused_0[4];
+};
+
+/* hwrm_nvm_defrag_output (size:128b/16B) */
+struct hwrm_nvm_defrag_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
+/* hwrm_nvm_defrag_cmd_err (size:64b/8B) */
+struct hwrm_nvm_defrag_cmd_err {
+	u8	code;
+	#define NVM_DEFRAG_CMD_ERR_CODE_UNKNOWN    0x0UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_FAIL       0x1UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_CHECK_FAIL 0x2UL
+	#define NVM_DEFRAG_CMD_ERR_CODE_LAST      NVM_DEFRAG_CMD_ERR_CODE_CHECK_FAIL
+	u8	unused_0[7];
+};
+
 /* hwrm_selftest_qlist_input (size:128b/16B) */
 struct hwrm_selftest_qlist_input {
 	__le16	req_type;
-- 
2.51.0


