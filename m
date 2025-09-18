Return-Path: <netdev+bounces-212952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB1B22A85
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF671C210A4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676A2F0C54;
	Tue, 12 Aug 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NV/7niy8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808372F0C4B;
	Tue, 12 Aug 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007896; cv=none; b=pLjjmUOHmasaaEG6P660zwBTcnMUjr/n9+RCz0bR2jOop5ck9VI/DJEQgkr3+lkrp0zK8v9BBUYZYiV8Ek8I75425MQxLraNbuNgXmrTP5R0uqurFqY0Vi1tE8zLV0nJ2f219aH8rqVDQZBVnYLMaAG4I1VOVXdhiE8ZeymO8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007896; c=relaxed/simple;
	bh=bXcNtEP4o4RDuQsTZEERjJbNM56YLe5MSLeSgBRWyIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b/AbhWwKIR+MhBj3Mewq6zflBtUtN9lVgjKxvtfD2Ssc3lCe+NBP9UR1ZaK1JMB2OrBCCkdw8rGjG718n51GCI3EpOyMB02xPoPoPyUJ9igWWiV5GyGCqAp9SNtYeU5AIhWE/BvqMuiM214ZFur6tAeWMYb0F0jfAJ5n2enuJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NV/7niy8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAw8mt003014;
	Tue, 12 Aug 2025 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3okJq1drjFGRU3eEsQ8pk+4bEJVb444wj62kLPEJfM=; b=NV/7niy8Ov27EdXf
	qJEI9JqVO3+yK0SWKdSYO7SsPphCY02/9kePwBEBQurNujCqVCiEnpSwyuQj4Z3p
	0y6Fa/SeETru2XLtjvuxF70/LcW4hjAR+VheJcNJeO+vI4kgjrgnaoqjdu2Md1dn
	ngCEkvi1Zxt5aE9MI9lqqAZP8swxkKnL1qib2rajjSq893D3/+xfCv9WCrZ07Wzo
	kW6bg7SycRasZBKzdAaYyKnZpG0t71LFx+vYnTbv+9IzmbywOC/3LVUSLnWpcUf6
	jb9aDOS/TXxEwGdd3hmpZ6EzqmgKrPiTHrn3idCCIBgn6E5Bo1lQvejonvHhrdD1
	idYJiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj48d1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CEBMLj016633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:22 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 07:11:17 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 12 Aug 2025 22:10:31 +0800
Subject: [PATCH net-next v7 07/14] net: ethernet: qualcomm: Initialize PPE
 queue settings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-qcom_ipq_ppe-v7-7-789404bdbc9a@quicinc.com>
References: <20250812-qcom_ipq_ppe-v7-0-789404bdbc9a@quicinc.com>
In-Reply-To: <20250812-qcom_ipq_ppe-v7-0-789404bdbc9a@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal
	<quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>,
        "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook
	<kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755007841; l=16403;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=bXcNtEP4o4RDuQsTZEERjJbNM56YLe5MSLeSgBRWyIM=;
 b=j1MZxlli3Cw9bsCRGJZzPRnfTkUvLhtMXr6iuAi+rbZBCgmGEKuq8d11WPmYL/Axu0jv04W3I
 nk/n9s8O7BWDw5VCb5undcWmTwNduUUxWZLvRi0dfqSOk25nSKoD1FJ
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX42eLwcHuxMeb
 g81LdVKWJDYt1/nAzaAZfIIVAJZhxK7opEilVu2qUwInjdQb+UhLRH25uHI6a6gVXKKUJvkmj+b
 ZWjQaeSzAA6dQXPTLe3mzr6/2VFzmAbpO3hW6CQgoLNKvDxew+sxYlGxXLmwx0iJHWl26pNrIpt
 YgWUacCZt6PFlEfVepHMLqbOyVFHgADmYplXFvqJEKohO8WcDZcJON6ixXR6e8jk4JAn8BYREIc
 lRTl1tDein64uz1j9J1BYf1tCABVXiqIyUeKeeVaExU63lqgrQ/ZXYOS6T06XdB9lybTIvgBAIw
 rC3UCmNtxArXQzYiPUQdC0rEsOWWF71/MM3RkYUOJIc17FLhJ7qBTGYZImY+xhCiZ+/VA+RtVDo
 aBBKSMyD
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689b4b8b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=PNRkUbp5dbSH4Vkeo0cA:9 a=CNskAabLYMlJ57OS:21 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mzzbvuWUIOUaCPzb7sEs-To2miGhqkDV
X-Proofpoint-GUID: mzzbvuWUIOUaCPzb7sEs-To2miGhqkDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

Configure unicast and multicast hardware queues for the PPE ports to
enable packet forwarding between the ports.

Each PPE port is assigned with a range of queues. The queue ID selection
for the packet is decided by the queue base and queue offset that is
configured based on the internal priority and the RSS hash value of the
packet.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 356 ++++++++++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h |  63 +++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h   |  21 ++
 3 files changed, 439 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 3c45d0d1c560..9037702460b5 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -138,6 +138,34 @@ struct ppe_scheduler_port_config {
 	unsigned int drr_node_id;
 };
 
+/**
+ * struct ppe_port_schedule_resource - PPE port scheduler resource.
+ * @ucastq_start: Unicast queue start ID.
+ * @ucastq_end: Unicast queue end ID.
+ * @mcastq_start: Multicast queue start ID.
+ * @mcastq_end: Multicast queue end ID.
+ * @flow_id_start: Flow start ID.
+ * @flow_id_end: Flow end ID.
+ * @l0node_start: Scheduler node start ID for queue level.
+ * @l0node_end: Scheduler node end ID for queue level.
+ * @l1node_start: Scheduler node start ID for flow level.
+ * @l1node_end: Scheduler node end ID for flow level.
+ *
+ * PPE scheduler resource allocated among the PPE ports.
+ */
+struct ppe_port_schedule_resource {
+	unsigned int ucastq_start;
+	unsigned int ucastq_end;
+	unsigned int mcastq_start;
+	unsigned int mcastq_end;
+	unsigned int flow_id_start;
+	unsigned int flow_id_end;
+	unsigned int l0node_start;
+	unsigned int l0node_end;
+	unsigned int l1node_start;
+	unsigned int l1node_end;
+};
+
 /* There are total 2048 buffers available in PPE, out of which some
  * buffers are reserved for some specific purposes per PPE port. The
  * rest of the pool of 1550 buffers are assigned to the general 'group0'
@@ -701,6 +729,111 @@ static const struct ppe_scheduler_port_config ppe_port_sch_config[] = {
 	},
 };
 
+/* The scheduler resource is applied to each PPE port, The resource
+ * includes the unicast & multicast queues, flow nodes and DRR nodes.
+ */
+static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
+	{	.ucastq_start	= 0,
+		.ucastq_end	= 63,
+		.mcastq_start	= 256,
+		.mcastq_end	= 271,
+		.flow_id_start	= 0,
+		.flow_id_end	= 0,
+		.l0node_start	= 0,
+		.l0node_end	= 7,
+		.l1node_start	= 0,
+		.l1node_end	= 0,
+	},
+	{	.ucastq_start	= 144,
+		.ucastq_end	= 159,
+		.mcastq_start	= 272,
+		.mcastq_end	= 275,
+		.flow_id_start	= 36,
+		.flow_id_end	= 39,
+		.l0node_start	= 48,
+		.l0node_end	= 63,
+		.l1node_start	= 8,
+		.l1node_end	= 11,
+	},
+	{	.ucastq_start	= 160,
+		.ucastq_end	= 175,
+		.mcastq_start	= 276,
+		.mcastq_end	= 279,
+		.flow_id_start	= 40,
+		.flow_id_end	= 43,
+		.l0node_start	= 64,
+		.l0node_end	= 79,
+		.l1node_start	= 12,
+		.l1node_end	= 15,
+	},
+	{	.ucastq_start	= 176,
+		.ucastq_end	= 191,
+		.mcastq_start	= 280,
+		.mcastq_end	= 283,
+		.flow_id_start	= 44,
+		.flow_id_end	= 47,
+		.l0node_start	= 80,
+		.l0node_end	= 95,
+		.l1node_start	= 16,
+		.l1node_end	= 19,
+	},
+	{	.ucastq_start	= 192,
+		.ucastq_end	= 207,
+		.mcastq_start	= 284,
+		.mcastq_end	= 287,
+		.flow_id_start	= 48,
+		.flow_id_end	= 51,
+		.l0node_start	= 96,
+		.l0node_end	= 111,
+		.l1node_start	= 20,
+		.l1node_end	= 23,
+	},
+	{	.ucastq_start	= 208,
+		.ucastq_end	= 223,
+		.mcastq_start	= 288,
+		.mcastq_end	= 291,
+		.flow_id_start	= 52,
+		.flow_id_end	= 55,
+		.l0node_start	= 112,
+		.l0node_end	= 127,
+		.l1node_start	= 24,
+		.l1node_end	= 27,
+	},
+	{	.ucastq_start	= 224,
+		.ucastq_end	= 239,
+		.mcastq_start	= 292,
+		.mcastq_end	= 295,
+		.flow_id_start	= 56,
+		.flow_id_end	= 59,
+		.l0node_start	= 128,
+		.l0node_end	= 143,
+		.l1node_start	= 28,
+		.l1node_end	= 31,
+	},
+	{	.ucastq_start	= 240,
+		.ucastq_end	= 255,
+		.mcastq_start	= 296,
+		.mcastq_end	= 299,
+		.flow_id_start	= 60,
+		.flow_id_end	= 63,
+		.l0node_start	= 144,
+		.l0node_end	= 159,
+		.l1node_start	= 32,
+		.l1node_end	= 35,
+	},
+	{	.ucastq_start	= 64,
+		.ucastq_end	= 143,
+		.mcastq_start	= 0,
+		.mcastq_end	= 0,
+		.flow_id_start	= 1,
+		.flow_id_end	= 35,
+		.l0node_start	= 8,
+		.l0node_end	= 47,
+		.l1node_start	= 1,
+		.l1node_end	= 7,
+	},
+};
+
 /* Set the PPE queue level scheduler configuration. */
 static int ppe_scheduler_l0_queue_map_set(struct ppe_device *ppe_dev,
 					  int node_id, int port,
@@ -832,6 +965,149 @@ int ppe_queue_scheduler_set(struct ppe_device *ppe_dev,
 					      port, scheduler_cfg);
 }
 
+/**
+ * ppe_queue_ucast_base_set - Set PPE unicast queue base ID and profile ID
+ * @ppe_dev: PPE device
+ * @queue_dst: PPE queue destination configuration
+ * @queue_base: PPE queue base ID
+ * @profile_id: Profile ID
+ *
+ * The PPE unicast queue base ID and profile ID are configured based on the
+ * destination port information that can be service code or CPU code or the
+ * destination port.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ppe_queue_ucast_base_set(struct ppe_device *ppe_dev,
+			     struct ppe_queue_ucast_dest queue_dst,
+			     int queue_base, int profile_id)
+{
+	int index, profile_size;
+	u32 val, reg;
+
+	profile_size = queue_dst.src_profile << 8;
+	if (queue_dst.service_code_en)
+		index = PPE_QUEUE_BASE_SERVICE_CODE + profile_size +
+			queue_dst.service_code;
+	else if (queue_dst.cpu_code_en)
+		index = PPE_QUEUE_BASE_CPU_CODE + profile_size +
+			queue_dst.cpu_code;
+	else
+		index = profile_size + queue_dst.dest_port;
+
+	val = FIELD_PREP(PPE_UCAST_QUEUE_MAP_TBL_PROFILE_ID, profile_id);
+	val |= FIELD_PREP(PPE_UCAST_QUEUE_MAP_TBL_QUEUE_ID, queue_base);
+	reg = PPE_UCAST_QUEUE_MAP_TBL_ADDR + index * PPE_UCAST_QUEUE_MAP_TBL_INC;
+
+	return regmap_write(ppe_dev->regmap, reg, val);
+}
+
+/**
+ * ppe_queue_ucast_offset_pri_set - Set PPE unicast queue offset based on priority
+ * @ppe_dev: PPE device
+ * @profile_id: Profile ID
+ * @priority: PPE internal priority to be used to set queue offset
+ * @queue_offset: Queue offset used for calculating the destination queue ID
+ *
+ * The PPE unicast queue offset is configured based on the PPE
+ * internal priority.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ppe_queue_ucast_offset_pri_set(struct ppe_device *ppe_dev,
+				   int profile_id,
+				   int priority,
+				   int queue_offset)
+{
+	u32 val, reg;
+	int index;
+
+	index = (profile_id << 4) + priority;
+	val = FIELD_PREP(PPE_UCAST_PRIORITY_MAP_TBL_CLASS, queue_offset);
+	reg = PPE_UCAST_PRIORITY_MAP_TBL_ADDR + index * PPE_UCAST_PRIORITY_MAP_TBL_INC;
+
+	return regmap_write(ppe_dev->regmap, reg, val);
+}
+
+/**
+ * ppe_queue_ucast_offset_hash_set - Set PPE unicast queue offset based on hash
+ * @ppe_dev: PPE device
+ * @profile_id: Profile ID
+ * @rss_hash: Packet hash value to be used to set queue offset
+ * @queue_offset: Queue offset used for calculating the destination queue ID
+ *
+ * The PPE unicast queue offset is configured based on the RSS hash value.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ppe_queue_ucast_offset_hash_set(struct ppe_device *ppe_dev,
+				    int profile_id,
+				    int rss_hash,
+				    int queue_offset)
+{
+	u32 val, reg;
+	int index;
+
+	index = (profile_id << 8) + rss_hash;
+	val = FIELD_PREP(PPE_UCAST_HASH_MAP_TBL_HASH, queue_offset);
+	reg = PPE_UCAST_HASH_MAP_TBL_ADDR + index * PPE_UCAST_HASH_MAP_TBL_INC;
+
+	return regmap_write(ppe_dev->regmap, reg, val);
+}
+
+/**
+ * ppe_port_resource_get - Get PPE resource per port
+ * @ppe_dev: PPE device
+ * @port: PPE port
+ * @type: Resource type
+ * @res_start: Resource start ID returned
+ * @res_end: Resource end ID returned
+ *
+ * PPE resource is assigned per PPE port, which is acquired for QoS scheduler.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ppe_port_resource_get(struct ppe_device *ppe_dev, int port,
+			  enum ppe_resource_type type,
+			  int *res_start, int *res_end)
+{
+	struct ppe_port_schedule_resource res;
+
+	/* The reserved resource with the maximum port ID of PPE is
+	 * also allowed to be acquired.
+	 */
+	if (port > ppe_dev->num_ports)
+		return -EINVAL;
+
+	res = ppe_scheduler_res[port];
+	switch (type) {
+	case PPE_RES_UCAST:
+		*res_start = res.ucastq_start;
+		*res_end = res.ucastq_end;
+		break;
+	case PPE_RES_MCAST:
+		*res_start = res.mcastq_start;
+		*res_end = res.mcastq_end;
+		break;
+	case PPE_RES_FLOW_ID:
+		*res_start = res.flow_id_start;
+		*res_end = res.flow_id_end;
+		break;
+	case PPE_RES_L0_NODE:
+		*res_start = res.l0node_start;
+		*res_end = res.l0node_end;
+		break;
+	case PPE_RES_L1_NODE:
+		*res_start = res.l1node_start;
+		*res_end = res.l1node_end;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ppe_config_bm_threshold(struct ppe_device *ppe_dev, int bm_port_id,
 				   const struct ppe_bm_port_config port_cfg)
 {
@@ -1167,6 +1443,80 @@ static int ppe_config_scheduler(struct ppe_device *ppe_dev)
 	return ret;
 };
 
+/* Configure PPE queue destination of each PPE port. */
+static int ppe_queue_dest_init(struct ppe_device *ppe_dev)
+{
+	int ret, port_id, index, q_base, q_offset, res_start, res_end, pri_max;
+	struct ppe_queue_ucast_dest queue_dst;
+
+	for (port_id = 0; port_id < ppe_dev->num_ports; port_id++) {
+		memset(&queue_dst, 0, sizeof(queue_dst));
+
+		ret = ppe_port_resource_get(ppe_dev, port_id, PPE_RES_UCAST,
+					    &res_start, &res_end);
+		if (ret)
+			return ret;
+
+		q_base = res_start;
+		queue_dst.dest_port = port_id;
+
+		/* Configure queue base ID and profile ID that is same as
+		 * physical port ID.
+		 */
+		ret = ppe_queue_ucast_base_set(ppe_dev, queue_dst,
+					       q_base, port_id);
+		if (ret)
+			return ret;
+
+		/* Queue priority range supported by each PPE port */
+		ret = ppe_port_resource_get(ppe_dev, port_id, PPE_RES_L0_NODE,
+					    &res_start, &res_end);
+		if (ret)
+			return ret;
+
+		pri_max = res_end - res_start;
+
+		/* Redirect ARP reply packet with the max priority on CPU port,
+		 * which keeps the ARP reply directed to CPU (CPU code is 101)
+		 * with highest priority queue of EDMA.
+		 */
+		if (port_id == 0) {
+			memset(&queue_dst, 0, sizeof(queue_dst));
+
+			queue_dst.cpu_code_en = true;
+			queue_dst.cpu_code = 101;
+			ret = ppe_queue_ucast_base_set(ppe_dev, queue_dst,
+						       q_base + pri_max,
+						       0);
+			if (ret)
+				return ret;
+		}
+
+		/* Initialize the queue offset of internal priority. */
+		for (index = 0; index < PPE_QUEUE_INTER_PRI_NUM; index++) {
+			q_offset = index > pri_max ? pri_max : index;
+
+			ret = ppe_queue_ucast_offset_pri_set(ppe_dev, port_id,
+							     index, q_offset);
+			if (ret)
+				return ret;
+		}
+
+		/* Initialize the queue offset of RSS hash as 0 to avoid the
+		 * random hardware value that will lead to the unexpected
+		 * destination queue generated.
+		 */
+		for (index = 0; index < PPE_QUEUE_HASH_NUM; index++) {
+			ret = ppe_queue_ucast_offset_hash_set(ppe_dev, port_id,
+							      index, 0);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ppe_hw_config(struct ppe_device *ppe_dev)
 {
 	int ret;
@@ -1179,5 +1529,9 @@ int ppe_hw_config(struct ppe_device *ppe_dev)
 	if (ret)
 		return ret;
 
-	return ppe_config_scheduler(ppe_dev);
+	ret = ppe_config_scheduler(ppe_dev);
+	if (ret)
+		return ret;
+
+	return ppe_queue_dest_init(ppe_dev);
 }
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
index e2c703c0b99d..b4fd5f833bac 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -8,6 +8,16 @@
 
 #include "ppe.h"
 
+/* There are different table index ranges for configuring queue base ID of
+ * the destination port, CPU code and service code.
+ */
+#define PPE_QUEUE_BASE_DEST_PORT		0
+#define PPE_QUEUE_BASE_CPU_CODE			1024
+#define PPE_QUEUE_BASE_SERVICE_CODE		2048
+
+#define PPE_QUEUE_INTER_PRI_NUM			16
+#define PPE_QUEUE_HASH_NUM			256
+
 /**
  * enum ppe_scheduler_frame_mode - PPE scheduler frame mode.
  * @PPE_SCH_WITH_IPG_PREAMBLE_FRAME_CRC: The scheduled frame includes IPG,
@@ -42,8 +52,61 @@ struct ppe_scheduler_cfg {
 	enum ppe_scheduler_frame_mode frame_mode;
 };
 
+/**
+ * enum ppe_resource_type - PPE resource type.
+ * @PPE_RES_UCAST: Unicast queue resource.
+ * @PPE_RES_MCAST: Multicast queue resource.
+ * @PPE_RES_L0_NODE: Level 0 for queue based node resource.
+ * @PPE_RES_L1_NODE: Level 1 for flow based node resource.
+ * @PPE_RES_FLOW_ID: Flow based node resource.
+ */
+enum ppe_resource_type {
+	PPE_RES_UCAST,
+	PPE_RES_MCAST,
+	PPE_RES_L0_NODE,
+	PPE_RES_L1_NODE,
+	PPE_RES_FLOW_ID,
+};
+
+/**
+ * struct ppe_queue_ucast_dest - PPE unicast queue destination.
+ * @src_profile: Source profile.
+ * @service_code_en: Enable service code to map the queue base ID.
+ * @service_code: Service code.
+ * @cpu_code_en: Enable CPU code to map the queue base ID.
+ * @cpu_code: CPU code.
+ * @dest_port: destination port.
+ *
+ * PPE egress queue ID is decided by the service code if enabled, otherwise
+ * by the CPU code if enabled, or by destination port if both service code
+ * and CPU code are disabled.
+ */
+struct ppe_queue_ucast_dest {
+	int src_profile;
+	bool service_code_en;
+	int service_code;
+	bool cpu_code_en;
+	int cpu_code;
+	int dest_port;
+};
+
 int ppe_hw_config(struct ppe_device *ppe_dev);
 int ppe_queue_scheduler_set(struct ppe_device *ppe_dev,
 			    int node_id, bool flow_level, int port,
 			    struct ppe_scheduler_cfg scheduler_cfg);
+int ppe_queue_ucast_base_set(struct ppe_device *ppe_dev,
+			     struct ppe_queue_ucast_dest queue_dst,
+			     int queue_base,
+			     int profile_id);
+int ppe_queue_ucast_offset_pri_set(struct ppe_device *ppe_dev,
+				   int profile_id,
+				   int priority,
+				   int queue_offset);
+int ppe_queue_ucast_offset_hash_set(struct ppe_device *ppe_dev,
+				    int profile_id,
+				    int rss_hash,
+				    int queue_offset);
+int ppe_port_resource_get(struct ppe_device *ppe_dev, int port,
+			  enum ppe_resource_type type,
+			  int *res_start, int *res_end);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 2e43fbc56845..3776e619e70f 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -164,6 +164,27 @@
 #define PPE_BM_PORT_FC_SET_PRE_ALLOC(tbl_cfg, value)	\
 	FIELD_MODIFY(PPE_BM_PORT_FC_W1_PRE_ALLOC, (tbl_cfg) + 0x1, value)
 
+/* The queue base configurations based on destination port,
+ * service code or CPU code.
+ */
+#define PPE_UCAST_QUEUE_MAP_TBL_ADDR		0x810000
+#define PPE_UCAST_QUEUE_MAP_TBL_ENTRIES		3072
+#define PPE_UCAST_QUEUE_MAP_TBL_INC		0x10
+#define PPE_UCAST_QUEUE_MAP_TBL_PROFILE_ID	GENMASK(3, 0)
+#define PPE_UCAST_QUEUE_MAP_TBL_QUEUE_ID	GENMASK(11, 4)
+
+/* The queue offset configurations based on RSS hash value. */
+#define PPE_UCAST_HASH_MAP_TBL_ADDR		0x830000
+#define PPE_UCAST_HASH_MAP_TBL_ENTRIES		4096
+#define PPE_UCAST_HASH_MAP_TBL_INC		0x10
+#define PPE_UCAST_HASH_MAP_TBL_HASH		GENMASK(7, 0)
+
+/* The queue offset configurations based on PPE internal priority. */
+#define PPE_UCAST_PRIORITY_MAP_TBL_ADDR		0x842000
+#define PPE_UCAST_PRIORITY_MAP_TBL_ENTRIES	256
+#define PPE_UCAST_PRIORITY_MAP_TBL_INC		0x10
+#define PPE_UCAST_PRIORITY_MAP_TBL_CLASS	GENMASK(3, 0)
+
 /* PPE unicast queue (0-255) configurations. */
 #define PPE_AC_UNICAST_QUEUE_CFG_TBL_ADDR	0x848000
 #define PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES	256

-- 
2.34.1


