Return-Path: <netdev+bounces-282298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDVDC3zB8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:29:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7394491302
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B7B03061B2C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FE3B7B71;
	Wed, 29 Apr 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TnWBV9ar"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717973B3899;
	Wed, 29 Apr 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451320; cv=fail; b=gX89u5B4BPFnrt7rofQwI6BcyrsIqGrxt9SlKA33TH2DYV14BkiIwv6bv9R3VLU83+DOuR5jyeiblKFoE2yXl9org/kSK0ZjbHXtWdRTzJhCtb+SunzN2y6pYVU09oR00t7UQIP4MB4Qi9arKZHZ8Oh9bba8Dbi1qoXgDJIHy9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451320; c=relaxed/simple;
	bh=ybpY/M1Mpv7UY+bhJZLxLwoeT6LcGzLlxQapuCTuIJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p+91i6jDpGKmAvsbHsYQOLznB8plipFtYBlpT0nzfTQmeeySKI4iKtDzPjFYNS1hqzDi6AifuRg/0crPYV+sflQMIHAi4vplRAiuuyuYVYzmEksgWZLpYeypHCNES8T357YhQ2zxZ1jgwMWGNt+Sedet6Lh4HjkCLaTqEzcrNT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TnWBV9ar; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysXZaIFM1sorK+BaZ0wvi5PX+aJcjvWYVFIbMshud7u92kVhbFEirPN8YqmIURDjVSO0zms6ko+OYgYaoggraHlAok2W8qAbTHEYboA48rthSqxQaKXp19bAewNtEreJR4gVSzjdV7P80I5iEEwsT44FAQi1ksVkOG5bWsFayjiePWi04FDlnO3sNQJ4SY7CSV/S+kNlu6fApyqXpn/qOrzr0lozlVL15ILZvC/k9jyI0RHBQN/yVLTrNFHgGjXkeuUhRC21BJwbVX1sg7WI9wt53/9Y0aoLnjjG7QEvQ77DEf90/fI4UDHn8JfLFJUQ7wOyrVjm9acYcih8K0ZTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msBptUIdxGAw7jrqRVycap3yVe4OMoz5lMv5woL/RIM=;
 b=x+EW2D+YRLlw3ZjDsx9eJme/udzKuEJyXVElAV7Hmk6xhpEmg/2UlHQTr6uDHYreZEUM9omG23iE3XNX96Wzui2hfgZVzqkvEiq/dJqsmne3tyi7K2WKxmkvElsV2oCl1J9uuNKDWf+SXwj0lF0pjKJZ3RRKTFC4OlKIZKA0OVk6r4Hc4i+0Ep+H5ej564IlmSgMpqxmlyN/NZVTGsKMTP6ZEnK0qzabKs0e4ePLy2GP63HmWQmRTmoi73N+2WWzb/AXNvsZWnyK3OrHxTaQWmZA0m284plICKbRBOnLD+TXfFJvynHeGZWU2tVWDHwDecfjLc/dxFC74hfKGpqiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msBptUIdxGAw7jrqRVycap3yVe4OMoz5lMv5woL/RIM=;
 b=TnWBV9arHXyF6Lvw4wuAzzW1lb3c4+jPk/QMV7y5SAfkvGUJys21iu2yZVl4yzKbhSFOXNJ0TaoiviD4z559/MA3UGivznEAgr+/dhiAsxE/ppl3fp5hrMPWcsDlhF479fnO03T0QXu2svHoAt+n5PKOLgdic9cxlKm/geJg5EA=
Received: from BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::8)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 08:28:32 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::8b) by BL1P221CA0027.outlook.office365.com
 (2603:10b6:208:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Wed,
 29 Apr 2026 08:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:31 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 08:28:21 +0000
Subject: [PATCH net-next 5/6] pds_core: add host backed memory support for
 firmware
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-5-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b62812-43c7-41a4-df9e-08dea5c94c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f+sGfy5WNmZsqwPo8h0u38gR2DGBoDRu27MwQg5HXxhB/QFptwQFUH15w77Z/wbHsavwUgMi7inmUUxf+GhhRkdbjWL/hJ+693HNUo9qg1yiRqtCdnrxhD0/fvBChtn2Er/dXS+mLWkV9al+Eq8BJzQcAPeA2j6JABvsEq0eJVXeY1uWdDdazGUMpdTcnXFTSp9iDV31S6yBvxhv3ZkCDB5RbMtkRKb5jOhVAyOojVM888KQumVMLDq9hUfNZXvvfxspoVrv0cHQOs0jNY8MCXi77kCtGLvNunC0ZWdEZLPQz2fMEag5OyfkdGco+VmiFLLpcWimRVhy7cXDQzldstYClH8wRqVv23KXIKycqAZa1zjQ/NEgh17FdbNtPM1/XgG/MVf2RFqN3rhxYW8lwBknf3MaKMN1aUT1T2rM8qjsr2rw6tKWhMxYKfki+33faMrMf8NVkB9wWt3Rt+3/OjwcMU3kdrfPt27WahsyWwV9w1eOOxNryxpmUPzbsykiQnYs0c4Iax1X2CYtX39IUBsgqx+XlCY7d7mZEanA79ieIZo4Vmc/W1mb0SF5/BHu+GTx1M+saLYCadQWqLhiuDKeRcN6U5ayIJkGqBboRVXmqR/icaI41PRLVWs8KT5XIZN4jnU00+JrJbGGhaJuoqV+hxxTcktBFsx7lHFDr1+4ZH/BhDtSoeRNGOssiFdE9Vh6V92Es6BLjpkk/wuTx5f6F8hc1MrOCajd9b11VI1bupyPVVkAmqbiPkSUevCbz64SSiJMQc/RzofvTXCS+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dtM/ixmgO9CvOIsVSU3fN2u+mkCbUG7CcC1rEgm5yMV9jtIZL6ES1VGveMfGUFgtVVeFo9FKUx9+d6KWOKKBWsRE6u5jJYwt8dQBSu0M0Dgzrre+28bqbuMcuSKHSq/NlEHHoQZlpt7cW9lm/EDVsMdCqghUr9pD8Ic0/rU0NpTZKz+RJXyv3WOAZDbtzF4b+uPcdMZuSAXauZvmj3/7ZtqiWi7u4y7Vi4AhlMHZBFfM2r2pVBMpLRwyZN2LS2mjSI+KM4KC2hbBJRmt5sif9cfUzBUYBPSzYVA7w+hMu3Thi8ozTWjnFbFQytmcBJagUcbEwZ7DK8t0yJqfiGdNxm7CD3uVyeL8QcvHPmixqJLywrKrL2QuJRLZOVONVdcQopVZclHXgEqqkFn3AxavUomaOc2u7v7g6RDTSyC2tDH17aNlv+QQmmLAizNrxjCN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:32.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b62812-43c7-41a4-df9e-08dea5c94c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Rspamd-Queue-Id: B7394491302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282298-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Some newer AMD/Pensando cards have minimal memory and there are cases
where components, specifically in the control plane, need more memory.
This series adds support for host backed DMA memory that can be used
by the firmware for the previously mentioned cases.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 166 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h |  19 ++++
 drivers/net/ethernet/amd/pds_core/main.c |   1 +
 include/linux/pds/pds_adminq.h           | 132 ++++++++++++++++++++++++
 include/linux/pds/pds_core_if.h          |   2 +
 5 files changed, 320 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 705cab7b0727..e94fea06c6cc 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -487,6 +487,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -496,6 +497,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -658,3 +660,167 @@ void pdsc_health_thread(struct work_struct *work)
 out_unlock:
 	mutex_unlock(&pdsc->config_lock);
 }
+
+static void pdsc_host_mem_del_one(struct pdsc *pdsc, u16 tag, u8 reason)
+{
+	union pds_core_adminq_comp comp = {};
+	union pds_core_adminq_cmd cmd = {
+		.mem_del.opcode = PDS_AQ_CMD_MEM_DEL,
+		.mem_del.tag = cpu_to_le16(tag),
+		.mem_del.reason = reason,
+	};
+
+	dev_dbg(pdsc->dev, "Sending aq cmd for mem del tag %d\n", tag);
+	pdsc_adminq_post(pdsc, &cmd, &comp, false);
+}
+
+static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
+{
+	struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
+	union pds_core_adminq_comp comp = {};
+	union pds_core_adminq_cmd cmd = {};
+	int err;
+
+	memset(hm, 0, sizeof(*hm));
+	cmd.mem_query.opcode = PDS_AQ_CMD_MEM_QUERY;
+	dev_dbg(pdsc->dev, "Sending aq cmd for mem query index %d\n", index);
+	err = pdsc_adminq_post(pdsc, &cmd, &comp, false);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem query failed err %d status %d\n",
+			err, comp.status);
+		return err ? err : -EIO;
+	}
+	hm->size = le32_to_cpu(comp.mem_query.size);
+	hm->tag = le16_to_cpu(comp.mem_query.tag);
+	dev_dbg(pdsc->dev, "mem query returned size %d tag %d\n",
+		hm->size, hm->tag);
+
+	if (!hm->size || hm->size > PDSC_HOST_MEM_MAX_CONTIG) {
+		dev_err(pdsc->dev, "invalid size %d for tag %d\n",
+			hm->size, hm->tag);
+		err = -EINVAL;
+		goto err_del;
+	}
+
+	hm->order = max(ilog2(hm->size), PAGE_SHIFT) - PAGE_SHIFT;
+	hm->pg = alloc_pages(GFP_KERNEL, hm->order);
+	if (!hm->pg) {
+		dev_err(pdsc->dev, "alloc order %d failed for tag %d\n",
+			hm->order, hm->tag);
+		err = -ENOMEM;
+		goto err_del;
+	}
+
+	hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(pdsc->dev, hm->pa)) {
+		dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
+			hm->tag, hm->size);
+		err = -EIO;
+		goto err_del;
+	}
+
+	memset(&cmd, 0, sizeof(cmd));
+	memset(&comp, 0, sizeof(comp));
+	cmd.mem_add.opcode = PDS_AQ_CMD_MEM_ADD;
+	cmd.mem_add.tag = cpu_to_le16(hm->tag);
+	cmd.mem_add.size = cpu_to_le32(hm->size);
+	cmd.mem_add.buf_pa = cpu_to_le64(hm->pa);
+
+	dev_dbg(pdsc->dev, "Sending aq cmd for mem add tag %d size %d pa 0x%llx\n",
+		hm->tag, hm->size, hm->pa);
+	err = pdsc_adminq_post(pdsc, &cmd, &comp, false);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
+			err, comp.status, hm->tag);
+		err = err ? err : -EIO;
+		goto err_del;
+	}
+	dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
+
+	return 0;
+
+err_del:
+	/* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
+	pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
+	if (hm->pg) {
+		if (!dma_mapping_error(pdsc->dev, hm->pa))
+			dma_unmap_page(pdsc->dev, hm->pa, hm->size, DMA_BIDIRECTIONAL);
+		__free_pages(hm->pg, hm->order);
+		hm->pg = NULL;
+	}
+	return err;
+}
+
+void pdsc_host_mem_add(struct pdsc *pdsc)
+{
+	union pds_core_adminq_comp comp = {};
+	union pds_core_adminq_cmd cmd = {};
+	u16 count;
+	int err;
+	int i;
+
+	if (!(pdsc->dev_ident.capabilities & cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	cmd.mem_get_count.opcode = PDS_AQ_CMD_MEM_GET_COUNT;
+	cmd.mem_get_count.max_contig = cpu_to_le32(PDSC_HOST_MEM_MAX_CONTIG);
+	dev_dbg(pdsc->dev, "Sending aq cmd for mem get count max_contig %lu\n",
+		PDSC_HOST_MEM_MAX_CONTIG);
+	err = pdsc_adminq_post(pdsc, &cmd, &comp, false);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem get count failed err %d status %d\n",
+			err, comp.status);
+		return;
+	}
+
+	count = le16_to_cpu(comp.mem_get_count.count);
+	dev_dbg(pdsc->dev, "mem get count returned count %d\n", count);
+	if (count == 0)
+		return;
+
+	pdsc->host_mem_reqs = kzalloc_objs(*pdsc->host_mem_reqs, count,
+					   GFP_KERNEL);
+	if (!pdsc->host_mem_reqs) {
+		dev_err(pdsc->dev, "failed to alloc host_mem_reqs array\n");
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		err = pdsc_host_mem_add_one(pdsc, i);
+		if (err)
+			break;
+	}
+
+	pdsc->num_host_mem_reqs = i;
+}
+
+void pdsc_host_mem_del(struct pdsc *pdsc)
+{
+	int i;
+
+	if (!pdsc->host_mem_reqs)
+		return;
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++)
+		pdsc_host_mem_del_one(pdsc, pdsc->host_mem_reqs[i].tag,
+				      PDS_RC_SUCCESS);
+}
+
+void pdsc_host_mem_free(struct pdsc *pdsc)
+{
+	int i;
+
+	if (!pdsc->host_mem_reqs)
+		return;
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
+			       pdsc->host_mem_reqs[i].size,
+			       DMA_BIDIRECTIONAL);
+		__free_pages(pdsc->host_mem_reqs[i].pg, pdsc->host_mem_reqs[i].order);
+	}
+
+	kfree(pdsc->host_mem_reqs);
+	pdsc->host_mem_reqs = NULL;
+	pdsc->num_host_mem_reqs = 0;
+}
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index c9ba63878927..e53edf72a5d5 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -5,6 +5,7 @@
 #define _PDSC_H_
 
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <net/devlink.h>
 
 #include <linux/pds/pds_common.h>
@@ -23,6 +24,8 @@
 #define PDSC_SETUP_RECOVERY	false
 #define PDSC_SETUP_INIT		true
 
+#define PDSC_HOST_MEM_MAX_CONTIG ((PAGE_SIZE) << (MAX_PAGE_ORDER))
+
 struct pdsc_dev_bar {
 	void __iomem *vaddr;
 	phys_addr_t bus_addr;
@@ -141,6 +144,14 @@ struct pdsc_viftype {
 	struct pds_auxiliary_dev *padev;
 };
 
+struct pdsc_host_mem {
+	u32 size;
+	u16 tag;
+	u8 order;
+	struct page *pg;
+	dma_addr_t pa;
+};
+
 /* No state flags set means we are in a steady running state */
 enum pdsc_state_flags {
 	PDSC_S_FW_DEAD,		    /* stopped, wait on startup or recovery */
@@ -200,6 +211,9 @@ struct pdsc {
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
 
+	struct pdsc_host_mem *host_mem_reqs;
+	u16 num_host_mem_reqs;
+
 	struct pds_core_component_list_info fw_components;
 };
 
@@ -277,6 +291,7 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
 void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
@@ -334,4 +349,8 @@ void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
 void pdsc_pci_reset_thread(struct work_struct *work);
 
+void pdsc_host_mem_add(struct pdsc *pdsc);
+void pdsc_host_mem_del(struct pdsc *pdsc);
+void pdsc_host_mem_free(struct pdsc *pdsc);
+
 #endif /* _PDSC_H_ */
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index f0d0993f9d91..0a0542bf7cbb 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -437,6 +437,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
+		pdsc_host_mem_del(pdsc);
 		if (pdsc->wq)
 			destroy_workqueue(pdsc->wq);
 
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 40ff0ec2b879..ef46415ab9fd 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -34,6 +34,12 @@ enum pds_core_adminq_opcode {
 	PDS_AQ_CMD_RX_FILTER_ADD	= 31,
 	PDS_AQ_CMD_RX_FILTER_DEL	= 32,
 
+	/* MEM commands */
+	PDS_AQ_CMD_MEM_GET_COUNT	= 10,
+	PDS_AQ_CMD_MEM_QUERY		= 11,
+	PDS_AQ_CMD_MEM_ADD		= 12,
+	PDS_AQ_CMD_MEM_DEL		= 13,
+
 	/* Queue commands */
 	PDS_AQ_CMD_Q_IDENTIFY		= 39,
 	PDS_AQ_CMD_Q_INIT		= 40,
@@ -207,6 +213,122 @@ struct pds_core_client_request_cmd {
 	u8     client_cmd[60];
 };
 
+/**
+ * struct pds_core_mem_get_count_cmd - MEM_GET_COUNT command
+ * @opcode:     opcode PDS_AQ_CMD_MEM_GET_COUNT
+ * @rsvd:       Word boundary padding
+ * @max_contig: Maximum contiguous memory size in bytes
+ *
+ * Query the number of host memory requests needed by firmware.
+ */
+struct pds_core_mem_get_count_cmd {
+	u8     opcode;
+	u8     rsvd[3];
+	__le32 max_contig;
+} __packed;
+
+/**
+ * struct pds_core_mem_get_count_comp - MEM_GET_COUNT completion
+ * @status:     Status of the command (enum pds_core_status_code)
+ * @rsvd:       Word boundary padding
+ * @comp_index: Index in the descriptor ring for which this is the completion
+ * @count:      Number of host memory requests
+ * @rsvd2:      Word boundary padding
+ * @color:      Color bit
+ */
+struct pds_core_mem_get_count_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	__le16 count;
+	u8     rsvd2[9];
+	u8     color;
+} __packed;
+
+/**
+ * struct pds_core_mem_query_cmd - MEM_QUERY command
+ * @opcode: opcode PDS_AQ_CMD_MEM_QUERY
+ * @rsvd:   Word boundary padding
+ * @index:  Memory request index
+ */
+struct pds_core_mem_query_cmd {
+	u8     opcode;
+	u8     rsvd;
+	__le16 index;
+} __packed;
+
+/**
+ * struct pds_core_mem_query_comp - MEM_QUERY completion
+ * @status:     Status of the command (enum pds_core_status_code)
+ * @rsvd:       Word boundary padding
+ * @comp_index: Index in the descriptor ring for which this is the completion
+ * @size:       Size of memory request in bytes
+ * @tag:        Tag for this memory request
+ */
+struct pds_core_mem_query_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	__le32 size;
+	__le16 tag;
+} __packed;
+
+/**
+ * struct pds_core_mem_add_cmd - MEM_ADD command
+ * @opcode: opcode PDS_AQ_CMD_MEM_ADD
+ * @rsvd:   Word boundary padding
+ * @tag:    Tag for this memory request
+ * @size:   Size of memory in bytes
+ * @buf_pa: DMA address of memory
+ */
+struct pds_core_mem_add_cmd {
+	u8     opcode;
+	u8     rsvd;
+	__le16 tag;
+	__le32 size;
+	__le64 buf_pa;
+} __packed;
+
+/**
+ * struct pds_core_mem_add_comp - MEM_ADD command completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @rsvd: padding for natural alignment
+ * @comp_index: Index in the desc ring for which this is the completion
+ */
+struct pds_core_mem_add_comp {
+	u8 status;
+	u8 rsvd;
+	__le16 comp_index;
+} __packed;
+
+/**
+ * struct pds_core_mem_del_cmd - MEM_DEL command
+ * @opcode: opcode PDS_AQ_CMD_MEM_DEL
+ * @rsvd:   Word boundary padding
+ * @tag:    Tag for this memory request
+ * @reason: Reason for deletion
+ */
+struct pds_core_mem_del_cmd {
+	u8     opcode;
+	u8     rsvd;
+	__le16 tag;
+	u8     reason;
+} __packed;
+
+/**
+ * struct pds_core_mem_del_comp - MEM_DEL command completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @rsvd: Word boundary padding
+ * @comp_index: Index in the desc ring for which this is the completion
+ * @tag: Tag for the memory request
+ */
+struct pds_core_mem_del_comp {
+	u8 status;
+	u8 rsvd;
+	__le16 comp_index;
+	__le16 tag;
+} __packed;
+
 #define PDS_CORE_MAX_FRAGS		16
 
 #define PDS_CORE_QCQ_F_INITED		BIT(0)
@@ -1454,6 +1576,11 @@ union pds_core_adminq_cmd {
 	struct pds_core_client_unreg_cmd   client_unreg;
 	struct pds_core_client_request_cmd client_request;
 
+	struct pds_core_mem_get_count_cmd mem_get_count;
+	struct pds_core_mem_query_cmd     mem_query;
+	struct pds_core_mem_add_cmd       mem_add;
+	struct pds_core_mem_del_cmd       mem_del;
+
 	struct pds_core_lif_identify_cmd  lif_ident;
 	struct pds_core_lif_init_cmd      lif_init;
 	struct pds_core_lif_reset_cmd     lif_reset;
@@ -1502,6 +1629,11 @@ union pds_core_adminq_comp {
 
 	struct pds_core_client_reg_comp   client_reg;
 
+	struct pds_core_mem_get_count_comp mem_get_count;
+	struct pds_core_mem_query_comp     mem_query;
+	struct pds_core_mem_add_comp       mem_add;
+	struct pds_core_mem_del_comp       mem_del;
+
 	struct pds_core_lif_identify_comp lif_ident;
 	struct pds_core_lif_init_comp     lif_init;
 	struct pds_core_lif_setattr_comp  lif_setattr;
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index b8052985dddf..fb489e8d54ef 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -110,9 +110,11 @@ struct pds_core_drv_identity {
 /**
  * enum pds_core_dev_capability - Device capabilities
  * @PDS_CORE_DEV_CAP_PLDM_FW_UPDATE: Device only supports FW update via PLDM
+ * @PDS_CORE_DEV_CAP_HOST_MEM: Device supports host memory for fw use
  */
 enum pds_core_dev_capability {
 	PDS_CORE_DEV_CAP_PLDM_FW_UPDATE = BIT(0),
+	PDS_CORE_DEV_CAP_HOST_MEM = BIT(1),
 };
 
 #define PDS_DEV_TYPE_MAX	16

-- 
2.43.0


