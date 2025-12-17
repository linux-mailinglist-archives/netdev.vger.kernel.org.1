Return-Path: <netdev+bounces-245125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C5CC7731
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B8030F82F8
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B3345CB5;
	Wed, 17 Dec 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3gYfUxs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUK+/Vqh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBB33B6FC
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970748; cv=none; b=kuS9BKGwl5DgEEiE/aOG1jVrRxUMFh4o4f2AOWu0MTmPSmHOLYb+Q2HSHh++lBCMiannLOCaUu1SBF/xy7H+hwkzM/2QILplSD+y1KUAP/niNRf10ca/Sazw4iAqwtYpAD37tC2Evudi+M/o86GVGrojsGzcbG+l7aeO8wVRk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970748; c=relaxed/simple;
	bh=+5c5QdWwlcUVTjo7CBbRtTPVRnnXzd/7Oq94EWphCt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sw/zTDSk9oHICbXFe7EoHMgVP5eKUxe2Mq4pbkbzQPKBGeOff0wT+6cCXFlZpj/biVG5Wial1urqPmvSIRVIb5dJp0nRm1DYNIuIxSTXbny/OBSceoWt0POFlm8CBt+cpnQHClFazAhDlCDaDQv/xYoIM1e+AlRYlMwIgj+8kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3gYfUxs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUK+/Vqh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHA8kwU1872176
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+nAihVvEo0dup82KcICFgWSmU1dOmxNkvIX
	eDxCHr+k=; b=O3gYfUxsazVzVg6vI+bOD756CaR61dWS6tq3iB/RyW6+D/3OZJs
	xc6/j+MrGkCbqyxQc8z5RiQSGvVgN8/KRk5D85EfIzCthOsW8YxJyFcbHSrd9vz3
	m8DpDZcFW3/7u7mlPQguGEndcf9XsX1a84vlS79Btg7CCfPzThwLxXCmggBtA+Yb
	4aU1fcYXNCU8K8KasNfaDzjN++lst1DQbtH/aOcpL5dVGzzf9/UURmUUIWEnaeM0
	yjfABTJi24BRPSTJ+mJda90h7a3J+QQMmeoCLGdyvpSixmSwcJzdqfgOTsaYl7yD
	dRScTvuNN8006aVM36HKDp/Vycd/BeIrEMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3jgq9ruh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:25:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0d59f0198so52607245ad.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 03:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765970745; x=1766575545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nAihVvEo0dup82KcICFgWSmU1dOmxNkvIXeDxCHr+k=;
        b=LUK+/VqhRFN/m88rlZjtTiJMGg9lV1/C7FmCokYjUyMdM3dKd0Qc7XJ6Y0vR2POoja
         DQSWpqyJypUxPJ7SBmuREtpqFkzdH6+f+UcZWv2wmvdmsLsXSU+d7DDr2ckLrrkxAQgM
         jhvYKOQkkdhsf1d3ly+FHDXnpDorOq9xtnXNw25SP2+t2U43XaEmPy/rI6Vua+W4LXiM
         APEx25t/ZtjF0HP3mHYayfjQLkH4+f5yAIXyrxoe731BfKbOn1EYjvlqV95A1ILNlcRY
         +wOylL+EIrLTIUUxPBamrKPYDIICUj2O6QKG0htsEgWnBqK1qwJjfe2uotN88QFUD9b9
         1+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970745; x=1766575545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nAihVvEo0dup82KcICFgWSmU1dOmxNkvIXeDxCHr+k=;
        b=DEvtl2U9csaDvj6VQe2l1zZtKRCGn5Ct5el6USJ5edDcD3GNXltQvD8WhrMm2mXMqr
         MU7KqkCVU5EKY1hPTHLRlhAFQmCsEoQY00+Bu/2JjZy77UQgHZh4/bPTXjt3RBscVdwZ
         7cmsqjFAJVXNj3xBwdniDmwBV1Ws9PFsCH/e6d4jK69G3yFOTvnoU0cGX8dlsmqtI0Sm
         aJBA1mS/+CKjWvz0kLTuMRsRkrArn74TGwj7swhm4PgkGP0PzdTuS8yZUjkoA9IhbFmL
         ufA/53iwBoKbgJapELUpBBbquBYHOdb5d/p2tLpNJ25Bq34tGeWHXYt+6MsgzcuUdInz
         3wRg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzPRPoKak2BuAbHgi3wdNxwnUOgv4Kj4chx3tHy4HtwejLORIxU/LGI/5g13RclgSuKT3Yac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3+CyJJ+vyiQGBOAqZMgRDXRXrPOIrPpecjDG9HGuZMM+JUye
	QJ4LgWps0Ssa46AmjSS4qHZTt2S0xGJPm5Bbm41z5Sq2Ap/Zo2R9f5WYDoHk6BcMwQW3tM8e30j
	xPzW/4eatuxBgZ05AnodTSdN0Gof3iiDNZzo94yA4s6N8+JIZuT5tGAY5Pj0=
X-Gm-Gg: AY/fxX5WlsznZkNAq0joUL1SqdfQmF37zyZoabaUBGeWvj54BACSck7g+eVxoHP/fpq
	7jx8HCgINGZVIk3MyRloF4A8vDUxrNPKQjMqa+EM0hqkhPVmrLJYTjn/MMEnEOuNVzZaUCEwrxX
	OTTKtNsb54wq4vugE52foKW3GVB/ZgJjO2Ms3u8zIXvEz52QZsux/EQuNHR2gIXnRf8y8sVYPAr
	UfS8lQFjZDEifenvTRmyK/fmfB3dXielVDsMrAjBb5rlLxY6FJnPmtSnKXKD9E+BcpTe94SCXeP
	R5STy0wF3f+koyf5ZNg5TN/3cPW/3Xuz7HCJF+aK3GJiaxINcQLkMDPACLBcfQYVpSjjQy84C77
	tBjyEGZyDvDJdg+J3FCq14TvW+RP4OQy0Os0lTic=
X-Received: by 2002:a17:903:3204:b0:29f:1bf:6424 with SMTP id d9443c01a7336-29f23b513c9mr168241875ad.18.1765970744482;
        Wed, 17 Dec 2025 03:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd+oPMn3IehR/bwCusj1EZhovu8fgRn66M/mxR+nhn0kQmyT+u2YAblNrUDvtgKs9VRLgKlA==
X-Received: by 2002:a17:903:3204:b0:29f:1bf:6424 with SMTP id d9443c01a7336-29f23b513c9mr168241575ad.18.1765970743882;
        Wed, 17 Dec 2025 03:25:43 -0800 (PST)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea03fa7bsm199097065ad.68.2025.12.17.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:25:43 -0800 (PST)
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
Subject: [PATCH v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures
Date: Wed, 17 Dec 2025 16:55:23 +0530
Message-Id: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VLjQXtPX c=1 sm=1 tr=0 ts=69429339 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9yJRpJph0W-_3QfB-SUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5MCBTYWx0ZWRfX02Kubnl/v6/X
 gr4gVsiO7Wp7v947a0MG26DKjcblvEsjNmIBJwarTDohRxuTZRh/QP81nmNhaVI6KbOsrI2O+mO
 3kEugwkImcYPYc2Y7GIXPzsiGQJLD2ml3Wu8eL8pBJw6Ry6NwTvC6l6grZmEQx5xb85dMLYEzhJ
 OLLXEGL7LHnR69PQqMlGf6sx9zrWizA4pFM7T9TXYo4VKXy6osUPdouOxeEsCee6ilOQFTb2vqF
 apZ6YyBHx1uQmCgyXyLu4TRcRDHiEQGiDm5JyW77ZbAfpECD2U4NuCuUj8SW4tlFJJulqCOcS2p
 ntEW/XW/Iq9b3uibqTLLYF7vVmqE0yiRiaCM/GqRNymdGVhhrG/3OUPNwm+Qo88Ek7hhKUprEvY
 f1zPPwLqAeNhBzeuNNLd8EVYqI2LHQ==
X-Proofpoint-ORIG-GUID: J3lAfzscGmfSf8uFcFCKtDEzNL4tcZeh
X-Proofpoint-GUID: J3lAfzscGmfSf8uFcFCKtDEzNL4tcZeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170090

1. Implement LE Event Mask to include events required for
   LE Channel Sounding
2. Enable Channel Sounding feature bit in the
   LE Host Supported Features command
3. Define HCI command and event structures necessary for
   LE Channel Sounding functionality

Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |   6 +
 net/bluetooth/hci_sync.c         |  15 ++
 3 files changed, 344 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a27cd3626b87..f860dc4545e8 100644
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
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP	0x208B
+struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
+	__le16	handle;
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
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_SEC_ENABLE			0x208C
+struct hci_cp_le_cs_sec_enable {
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS	0x208D
+struct hci_cp_le_cs_set_default_settings {
+	__le16	handle;
+	__u8	role_enable;
+	__u8	cs_sync_ant_sel;
+	__s8	max_tx_power;
+} __packed;
+
+struct hci_rp_le_cs_set_default_settings {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE		0x208E
+struct hci_cp_le_cs_rd_rmt_fae_table {
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE	0x208F
+struct hci_cp_le_cs_wr_rmt_cached_fae_table {
+	__le16	handle;
+	__u8	remote_fae_table[72];
+} __packed;
+
+struct hci_rp_le_cs_wr_rmt_cached_fae_table {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_CREATE_CONFIG		0x2090
+struct hci_cp_le_cs_create_config {
+	__le16	handle;
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
+	__le16	handle;
+	__u8	config_id;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION	0x2092
+struct hci_cp_le_cs_set_ch_classification {
+	__u8	ch_classification[10];
+} __packed;
+
+struct hci_rp_le_cs_set_ch_classification {
+	__u8	status;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_PARAM		0x2093
+struct hci_cp_le_cs_set_proc_param {
+	__le16	handle;
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
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_ENABLE		0x2094
+struct hci_cp_le_cs_set_proc_enable {
+	__le16	handle;
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
+	__u8	status;
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
+	__le16	handle;
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
+	__le16	handle;
+	__u8	remote_fae_table[72];
+} __packed;
+
+#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE		0x2E
+struct hci_evt_le_cs_security_enable_complete {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_EVT_LE_CS_CONFIG_COMPLETE			0x2F
+struct hci_evt_le_cs_config_complete {
+	__u8	status;
+	__le16	handle;
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
+	__le16	handle;
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
+	__le16	handle;
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
+	__le16	handle;
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
index 4263e71a23ef..df7375fda425 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define ll_ext_feature_capable(dev) \
 	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
 
+/* Channel sounding support */
+#define le_cs_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
+#define le_cs_host_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356..64e59d230d16 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
+	if (le_cs_capable(hdev)) {
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
+	cp.bit_value = le_cs_capable(hdev) ? 0x01 : 0x00;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
-- 

