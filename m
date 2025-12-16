Return-Path: <netdev+bounces-244921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6806CCC2F62
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976AC324EEEF
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BD346FAB;
	Tue, 16 Dec 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkLzKrM7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PycaOnZi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A334166A
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885101; cv=none; b=RqY3eJKhQbSim6Cn0uauBD10aei5IRgOM9D0v6LYpYG/bCUC5V5T1Fwad8Dkk1nx9zi3xHmx9ccnviD9bjdxQJkK6nXovXGQCpKTbY9EAwvBjCYNBI8C3ycMTEtsDzjVUTtamHhA4D2Pbi2RbZF7cRxRMIUEu8XRD9+Hg8k3CTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885101; c=relaxed/simple;
	bh=7nIVoKVThy65uPDZOkGoE/z4N51+dwDHf+GjY0+w28o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RE9jKkkVXFUoBSxHs/yDnS9uaTdDvFEAM9ri93jxQmQO5tLdAGZeZnMIfcjTscfChSxtJd5W7hOaVr6N5kQaTa0Ak2v1s7YdJSCYCMN3C5CIDd1kgi+dyktgg5ayn1MXgUE1WQAt5954JfweAocv1XBuGFMdX9A0Mj9G069V8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkLzKrM7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PycaOnZi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG9ZvHB3349375
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfP
	mbYe7oJk=; b=RkLzKrM7z07SCWiyseQdCZ8hsSDn1la7WHh06xcAThuBcjsg/gs
	f5Ic8Qy9x7BalpZT61GmbPkesgm9oXsk1sNisdQobjSjLSM86WEpme2hXZZgUn4D
	d0uB52Q+rVKbaVuaM5I7I8SwHhtBcygedV3KK1owlmTrmvQSbkFEErpnhAo+4x/d
	udF3JD8vNyoG1VC9aHhNqVGnTQyukmmhF3XinPf0bZmzHShqKSap86Le3UkkTqoE
	AzOKgaAvGwKQnG1+XZqIihMkpIrknzQqfxhI5ifEwl+s8dqDrDtKFg1J7rAamA0d
	lKW3wOtQRLMCPYznRu2rFM1p5jwxmC/M5/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b34xd0f61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so5273933a91.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765885098; x=1766489898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfPmbYe7oJk=;
        b=PycaOnZivwcLDZIno3AICK+f+r5J+ix6lz85/M+pymKKL7+5o390bbHGerSygWdZBU
         wxkZdbS6EHxrjRdH5fYPJeDNzxhrbOAhmNwJ8fZA+uigJBKVYtLK7AqfwVlXomvtH8AO
         qpYBJKEG5sJ8STrxvAvs4ow71bCcWoFRtpkyg0E4n3vKjBkENyLLDru1eNXd3NJvbz1E
         kZrftY3Q7lt37qwZ4rJ2vi3PJsJp5qB7ATAlFYJLjCk9NtSqSoANeE9mCUgdqsms+am1
         POeXg1IPLZ9SQqCsY/EJ+WyARmKXzOCBzC+IntgF8Ovs4DFjjyrlt1coe1BGVITTnC5U
         QoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885098; x=1766489898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfPmbYe7oJk=;
        b=eAz6aqGZweb1skHqZ+gqDyZlfh/iAqA9KsW8GcZ/ol2s161xjcK5TSZ+6zAtPep+PD
         ysV19KgjC5NwOchwRgFBCf+aif4uaE9jEww0ulQmWKKNFozAfxCA788EPpRr3USV99Kx
         rPj781oVUT3CV3ParCBy0/yivssRoFrp022A6MQ2FomY2ACssYueQhT5UlrLJc6LsW2t
         Pn5dWAqJGg/qneSWOk5l9uIa3Kjo1yHDm4kLUPHZrAF+XNgFZDznxFUwWVzVv0KtKtJ7
         G1337w2QZlT7qfpZaccgWXr4wOQSi07pyIJU1eT/FtlEMaWj7UyVZyQOT8AZ5zlBhLpI
         TLoA==
X-Forwarded-Encrypted: i=1; AJvYcCUa5+1JveOwd/E/IbLnsdkok/W/9q5jOq6I2VBG73M6BXaR5yT+Y+satnS18gt5GNU9cEFPUYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMHJ4CtSkRuDUO8YiAg3Zj3Z0xxQRKKVuC5SqvcqyViULxRTv
	QhWI3l79bWXmyMgZhyFnrUJwrmT50/OjECiSWkDMqKb+uewEb6SMK/3sJMHFOviCCBvrDsrDM0L
	qHVfXM45MSsOi1m19crlduk5V9mgSDRu2l4+7bnd4eKc3rCwSUTQLQSm/l8U=
X-Gm-Gg: AY/fxX4L4cq/+hmrWqbbz/Hmi7j3TSlgOF+i9JHBzz8BEZDG8JvcWkQy0QDhqd8qgPx
	lX3YQRHiDVS4f/F6jKF/rhm+Q9TY96X2+6DbRfSEz4ZrWJ9CWFZ7RsPCJcX/KJGCHmvm8/N4+E0
	kREWbXTv/Y3avsoCRpH3w1L0vgUG1z4vstoDH6zfOVGc6qAepz7atWXRfuRjnMtuPPV2+Bzaov9
	rI3CC9p7NBptBNvQ++mbMS1HxNW8UrW0+T147+wBD+NIKU2KYa5/LtphRieEmn01ySUc6RSEbFR
	dELfzbMJnw/FkuEzQQG7uFtt0DsRQCEYn0qDnhvG++/95+FghzDe/Rh9G06lnhZI9qPLPiOLzzv
	Oin7KtXk0YcmhgbZBeQxCY9f5GSwsj324FwMCCqk=
X-Received: by 2002:a17:90b:5548:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34abd76c9c3mr13237335a91.24.1765885098363;
        Tue, 16 Dec 2025 03:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcVJEPeG7P/u2oRZcEqqVrh4H9YnPnZW1cJy+TtF08gxo0XlstyOjV8povT0OJpkbw6i30+w==
X-Received: by 2002:a17:90b:5548:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34abd76c9c3mr13237313a91.24.1765885097844;
        Tue, 16 Dec 2025 03:38:17 -0800 (PST)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba5eesm11384625a91.6.2025.12.16.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:38:17 -0800 (PST)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
        hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding support by defining required HCI command/event structures.
Date: Tue, 16 Dec 2025 17:07:53 +0530
Message-Id: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA5OCBTYWx0ZWRfX5AFIE6Msk5U5
 W8+pdwved8vjssuVkHBRmYfjxS0irfz/RrQc8m+jd6rageuf5pK3jLg7zenZCS56Ya7LiUu3V7W
 5IfcD0ROsy8ujKygfA1iMOX6+Qb5Hdr2mSq6bCcrRvRRoyHD+QxNlkCTZY1SexyRJHSMepiLbvC
 5sPsEVXpNWlTAvIMqOXtBTUYDLHuU+/LSVwuofahoYSM5SK8eXjDYp86xXE/WcU4+E9RpqIDTEd
 mgkTTCGave037eNmir3FUyAuoY2BM8j7YKHUeKVSFZNhTSR5kwqUoKsJyuldiU/WZSGPWsWpOr5
 bINQf+i/2oMQ8cBQUeU8753sj5uuYIAa5l3XVl5168/sb0CdbB7EPRbwWDkY94ava126DKESUn1
 +VmdTzPDAYob6K8f6j2z3CbjdgA7qw==
X-Proofpoint-GUID: Vo2cTVg4s03qrayVYv4cPp_MXLuPucb8
X-Proofpoint-ORIG-GUID: Vo2cTVg4s03qrayVYv4cPp_MXLuPucb8
X-Authority-Analysis: v=2.4 cv=T7mBjvKQ c=1 sm=1 tr=0 ts=694144ab cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bzIxpeA4gcRnvUxJc7wA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160098

1. Implementing the LE Event Mask to include events required for
   LE Channel Sounding.
2. Enabling the Channel Sounding feature bit in the
   LE Host Supported Features command.
3. Defining HCI command and event structures necessary for
   LE Channel Sounding functionality.

Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |   6 +
 net/bluetooth/hci_sync.c         |  15 ++
 3 files changed, 344 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a27cd3626b87..33ec8ddd2119 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -654,6 +654,8 @@ enum {
 #define HCI_LE_ISO_BROADCASTER		0x40
 #define HCI_LE_ISO_SYNC_RECEIVER	0x80
 #define HCI_LE_LL_EXT_FEATURE		0x80
+#define HCI_LE_CHANNEL_SOUNDING		0x40
+#define HCI_LE_CHANNEL_SOUNDING_HOST	0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -2269,6 +2271,204 @@ struct hci_cp_le_read_all_remote_features {
 	__u8	 pages;
 } __packed;
 
+/* Channel Sounding Commands */
+#define HCI_OP_LE_CS_RD_LOCAL_SUPP_CAP	0x2089
+struct hci_rp_le_cs_rd_local_supp_cap {
+	__u8	status;
+	__u8	num_config_supported;
+	__le16	max_consecutive_procedures_supported;
+	__u8	num_antennas_supported;
+	__u8	max_antenna_paths_supported;
+	__u8	roles_supported;
+	__u8	modes_supported;
+	__u8	rtt_capability;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_random_payload_n;
+	__le16	nadm_sounding_capability;
+	__le16	nadm_random_capability;
+	__u8	cs_sync_phys_supported;
+	__le16	subfeatures_supported;
+	__le16	t_ip1_times_supported;
+	__le16	t_ip2_times_supported;
+	__le16	t_fcs_times_supported;
+	__le16	t_pm_times_supported;
+	__u8	t_sw_time_supported;
+	__u8	tx_snr_capability;
+} __packed;
+
+#define HCI_OP_LE_CS_RD_RMT_SUPP_CAP		0x208A
+struct hci_cp_le_cs_rd_local_supp_cap {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP	0x208B
+struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
+	__le16	conn_hdl;
+	__u8	num_config_supported;
+	__le16	max_consecutive_procedures_supported;
+	__u8	num_antennas_supported;
+	__u8	max_antenna_paths_supported;
+	__u8	roles_supported;
+	__u8	modes_supported;
+	__u8	rtt_capability;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_random_payload_n;
+	__le16	nadm_sounding_capability;
+	__le16	nadm_random_capability;
+	__u8	cs_sync_phys_supported;
+	__le16	subfeatures_supported;
+	__le16	t_ip1_times_supported;
+	__le16	t_ip2_times_supported;
+	__le16	t_fcs_times_supported;
+	__le16	t_pm_times_supported;
+	__u8	t_sw_time_supported;
+	__u8	tx_snr_capability;
+} __packed;
+
+struct hci_rp_le_cs_wr_cached_rmt_supp_cap {
+	__u8	status;
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SEC_ENABLE			0x208C
+struct hci_cp_le_cs_sec_enable {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS	0x208D
+struct hci_cp_le_cs_set_default_settings {
+	__le16  conn_hdl;
+	__u8    role_enable;
+	__u8    cs_sync_ant_sel;
+	__s8    max_tx_power;
+} __packed;
+
+struct hci_rp_le_cs_set_default_settings {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE		0x208E
+struct hci_cp_le_cs_rd_rmt_fae_table {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE	0x208F
+struct hci_cp_le_cs_wr_rmt_cached_fae_table {
+	__le16	conn_hdl;
+	__u8	remote_fae_table[72];
+} __packed;
+
+struct hci_rp_le_cs_wr_rmt_cached_fae_table {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_CREATE_CONFIG		0x2090
+struct hci_cp_le_cs_create_config {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	create_context;
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	min_main_mode_steps;
+	__u8	max_main_mode_steps;
+	__u8	main_mode_repetition;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	channel_map[10];
+	__u8	channel_map_repetition;
+	__u8	channel_selection_type;
+	__u8	ch3c_shape;
+	__u8	ch3c_jump;
+	__u8	reserved;
+} __packed;
+
+#define HCI_OP_LE_CS_REMOVE_CONFIG		0x2091
+struct hci_cp_le_cs_remove_config {
+	__le16	conn_hdl;
+	__u8	config_id;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION	0x2092
+struct hci_cp_le_cs_set_ch_classification {
+	__u8	ch_classification[10];
+} __packed;
+
+struct hci_rp_le_cs_set_ch_classification {
+	__u8    status;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_PARAM		0x2093
+struct hci_cp_le_cs_set_proc_param {
+	__le16  conn_hdl;
+	__u8	config_id;
+	__le16	max_procedure_len;
+	__le16	min_procedure_interval;
+	__le16	max_procedure_interval;
+	__le16	max_procedure_count;
+	__u8	min_subevent_len[3];
+	__u8	max_subevent_len[3];
+	__u8	tone_antenna_config_selection;
+	__u8	phy;
+	__u8	tx_power_delta;
+	__u8	preferred_peer_antenna;
+	__u8	snr_control_initiator;
+	__u8	snr_control_reflector;
+} __packed;
+
+struct hci_rp_le_cs_set_proc_param {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_ENABLE		0x2094
+struct hci_cp_le_cs_set_proc_param {
+	__le16  conn_hdl;
+	__u8	config_id;
+	__u8	enable;
+} __packed;
+
+#define HCI_OP_LE_CS_TEST			0x2095
+struct hci_cp_le_cs_test {
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	main_mode_repetition;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	cs_sync_antenna_selection;
+	__u8	subevent_len[3];
+	__le16	subevent_interval;
+	__u8	max_num_subevents;
+	__u8	transmit_power_level;
+	__u8	t_ip1_time;
+	__u8	t_ip2_time;
+	__u8	t_fcs_time;
+	__u8	t_pm_time;
+	__u8	t_sw_time;
+	__u8	tone_antenna_config_selection;
+	__u8	reserved;
+	__u8	snr_control_initiator;
+	__u8	snr_control_reflector;
+	__le16	drbg_nonce;
+	__u8	channel_map_repetition;
+	__le16	override_config;
+	__u8	override_parameters_length;
+	__u8	override_parameters_data[];
+} __packed;
+
+struct hci_rp_le_cs_test {
+	__u8    status;
+} __packed;
+
+#define HCI_OP_LE_CS_TEST_END			0x2096
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -2960,6 +3160,129 @@ struct hci_evt_le_read_all_remote_features_complete {
 	__u8    features[248];
 } __packed;
 
+/* Channel Sounding Events */
+#define HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE	0x2C
+struct hci_evt_le_cs_read_rmt_supp_cap_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	num_configs_supp;
+	__le16	max_consec_proc_supp;
+	__u8	num_ant_supp;
+	__u8	max_ant_path_supp;
+	__u8	roles_supp;
+	__u8	modes_supp;
+	__u8	rtt_cap;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_rand_payload_n;
+	__le16	nadm_sounding_cap;
+	__le16	nadm_rand_cap;
+	__u8	cs_sync_phys_supp;
+	__le16	sub_feat_supp;
+	__le16	t_ip1_times_supp;
+	__le16	t_ip2_times_supp;
+	__le16	t_fcs_times_supp;
+	__le16	t_pm_times_supp;
+	__u8	t_sw_times_supp;
+	__u8	tx_snr_cap;
+} __packed;
+
+#define HCI_EVT_LE_CS_READ_RMT_FAE_TABLE_COMPLETE	0x2D
+struct hci_evt_le_cs_read_rmt_fae_table_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	remote_fae_table[72];
+} __packed;
+
+#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE		0x2E
+struct hci_evt_le_cs_security_enable_complete {
+	__u8	status;
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_EVT_LE_CS_CONFIG_COMPLETE			0x2F
+struct hci_evt_le_cs_config_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	action;
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	min_main_mode_steps;
+	__u8	max_main_mode_steps;
+	__u8	main_mode_rep;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	channel_map[10];
+	__u8	channel_map_rep;
+	__u8	channel_sel_type;
+	__u8	ch3c_shape;
+	__u8	ch3c_jump;
+	__u8	reserved;
+	__u8	t_ip1_time;
+	__u8	t_ip2_time;
+	__u8	t_fcs_time;
+	__u8	t_pm_time;
+} __packed;
+
+#define HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE		0x30
+struct hci_evt_le_cs_procedure_enable_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	state;
+	__u8	tone_ant_config_sel;
+	__s8	sel_tx_pwr;
+	__u8	sub_evt_len[3];
+	__u8	sub_evts_per_evt;
+	__le16	sub_evt_intrvl;
+	__le16	evt_intrvl;
+	__le16	proc_intrvl;
+	__le16	proc_counter;
+	__le16	max_proc_len;
+} __packed;
+
+#define HCI_EVT_LE_CS_SUBEVENT_RESULT			0x31
+struct hci_evt_le_cs_subevent_result {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__le16	start_acl_conn_evt_counter;
+	__le16	proc_counter;
+	__le16	freq_comp;
+	__u8	ref_pwr_lvl;
+	__u8	proc_done_status;
+	__u8	subevt_done_status;
+	__u8	abort_reason;
+	__u8	num_ant_paths;
+	__u8	num_steps_reported;
+	__u8	step_mode[0]; /* depends on num_steps_reported */
+	__u8	step_channel[0]; /* depends on num_steps_reported */
+	__u8	step_data_length[0]; /* depends on num_steps_reported */
+	__u8	step_data[0]; /* depends on num_steps_reported */
+} __packed;
+
+#define HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE		0x32
+struct hci_evt_le_cs_subevent_result_continue {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	proc_done_status;
+	__u8	subevt_done_status;
+	__u8	abort_reason;
+	__u8	num_ant_paths;
+	__u8	num_steps_reported;
+	__u8	step_mode[0]; /* depends on num_steps_reported */
+	__u8	step_channel[0]; /* depends on num_steps_reported */
+	__u8	step_data_length[0]; /* depends on num_steps_reported */
+	__u8	step_data[0]; /* depends on num_steps_reported */
+} __packed;
+
+#define HCI_EVT_LE_CS_TEST_END_COMPLETE			0x33
+struct hci_evt_le_cs_test_end_complete {
+	__u8	status;
+} __packed;
+
 #define HCI_EV_VENDOR			0xff
 
 /* Internal events generated by Bluetooth stack */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4263e71a23ef..0152299a00b9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define ll_ext_feature_capable(dev) \
 	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
 
+/* Channel sounding support */
+#define chann_sounding_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
+#define chann_sounding_host_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356..67b2c55ec043 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
+	if (chann_sounding_capable(hdev)) {
+		/* Channel Sounding events */
+		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
+		events[5] |= 0x10;	/* LE CS Read Remote FAE Table Complete event */
+		events[5] |= 0x20;	/* LE CS Security Enable Complete event */
+		events[5] |= 0x40;	/* LE CS Config Complete event */
+		events[5] |= 0x80;	/* LE CS Procedure Enable Complete event */
+		events[6] |= 0x01;	/* LE CS Subevent Result event */
+		events[6] |= 0x02;	/* LE CS Subevent Result Continue event */
+		events[6] |= 0x04;	/* LE CS Test End Complete event */
+	}
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
 				     sizeof(events), events, HCI_CMD_TIMEOUT);
 }
@@ -4572,6 +4583,10 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 	cp.bit_number = 32;
 	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
 
+	/* Channel Sounding (Host Support) */
+	cp.bit_number = 47;
+	cp.bit_value = chann_sounding_capable(hdev) ? 0x01 : 0x00;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


