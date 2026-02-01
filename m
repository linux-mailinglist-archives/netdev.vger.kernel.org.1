Return-Path: <netdev+bounces-255632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MnxLwl4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE2C65E7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E573032067
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69491246BBA;
	Sun,  1 Feb 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jUHOcPoh"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA9243969;
	Sun,  1 Feb 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961313; cv=fail; b=hYoiKF2onH4eZFuR+EeikrxSsP5Rx0vkXCwGXYRtKKW7fGyO2BXFDyRFJvQlwcYsKvPg+/LLDa5XaFnGBUrfmbB+orPmyd1941MBPAbSpzYKJSVWohLDjxKwytLbWD9IyHxzs6cXXUvFLKoHDmp/ZtZGKbfOs4JZ7/B2MIgJtq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961313; c=relaxed/simple;
	bh=jOoY0SvGBLPP+4h5NUPPILovBQfVgbLulSM4VdGgwY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eihq4yWUHYYWAyD2COPaK2DzjXx1sRXpyOZOuNkTDmBCZPRoqE9zKLTVVySz6XslN31ZWduub2CgqmduTDT7oHcr0a5VWnazU+0Bx9n378gs7EP6HcoNS9nmeZSgyy/K4nwvQhs4ybMz1XWZOy15xuW8/9H88zV804qVel0pXpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jUHOcPoh; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoLQtzHqa8ofmoOGEyR5eAJeOaO4l+YckF3G6ydwYDZ3zLU4vCcqgJOYXR3g9NTpT3Y4rFyQc4b7laS+MMeX1TVXf35fiG5yd6QTQrwTC0IU6K7B3W9Y3NB6AuDKaF/Hj/OTIiNFJcZRCbXqa8rPdTEhLnkiwW3ZesG62Ze2DQzAiYpO/XAueV2fbS516zqeSHeylilAKJG/ouEcAMN5LKtb2ej1n2MG+SGF+onMoL6vRSxrQx4IhKberqrjhKc1fk5lqiIYSBhWOgM7SGk/tHN2lToL8R1HN/YDE7IURws1MS26okOiXH5bak95+NUnXfOFYXSHJ/maKXjU38XVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QppBp4PZk1F7PBqYSyejwoBU4xy0XEdP0w9ZKa3BpXc=;
 b=dIMELljTmRaRJp8xiQBDR77oNNYgXtZAV16LntIUmh7Qd4AgUTJ0RkciG9PF0CZc127dODV8+1cYBwRjoncwZCZ4x6KPYoNKCF7sypKfgs0Z+LxtlSopmPnXKgVdUlN0BD4khqJz7wTDsN0bkzfyW//eM+VQLohvunZz4rqN7J5qw9esNG60y8SpKgaNButDUzKMhzyqzEu0ahYVLnYRgZ40vA74azOSp/uH7aYc8nMABacD+sXNYJ6d0sIYDwDwpBNR6d/m6liZl7mcJMGYC++gYAxIOmDW3eV4W68ePXlhCTLZd95p5PKO4n75mQzz1aNl+vWZhWO3uGkT0LjQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QppBp4PZk1F7PBqYSyejwoBU4xy0XEdP0w9ZKa3BpXc=;
 b=jUHOcPohV2rdsxfcGirSe5AxsY8oCP4eIPQRcqDWoLv2InwCTVYwPdbTG8beaBDZ1STDlvk3T1GmL0ChUpnK/t39tuIRmQ0QyeSMxfWYCqmxgAAvTqYLBH0a1UCa1DZNKIFk3FcAdYyvcHMQ4Ihn7bFwWoX6c8DogIKekYBt80o=
Received: from CY8PR10CA0039.namprd10.prod.outlook.com (2603:10b6:930:4b::26)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sun, 1 Feb
 2026 15:55:02 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::e6) by CY8PR10CA0039.outlook.office365.com
 (2603:10b6:930:4b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:01 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:00 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 09/22] cxl: Add function for obtaining region range
Date: Sun, 1 Feb 2026 15:54:25 +0000
Message-ID: <20260201155438.2664640-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c40b1f-9da3-438e-d3c2-08de61aa4293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u1EKimlRPRrtWaKFj7afx5iliGzcyhJddMNFrICT6hij6gfPO/lPSb2mpKFv?=
 =?us-ascii?Q?g0h3iiG8V3uDRmk0O5h8hqpgMxyk1qn0V+fe8Y+9JdY6ZCibbR9RtVeHUq47?=
 =?us-ascii?Q?MiEv9xWRJmg6WBIK8nYszy9yQIJSkqccjIvDNqtw93avLl0g4UqSHs/VAh7R?=
 =?us-ascii?Q?poDs5RQWAWsF5IqJxiNoEzoixM26QuLV2wJ+UzD1J/HHhXVQvHtsyuK+3R39?=
 =?us-ascii?Q?6yTmpTDDhfj95AgCzHq9Tt1TDtClmtmzdz5510nJyr7jwEKToCSIOy144Aco?=
 =?us-ascii?Q?15pNWBLZrKOauZ+VONkILhzCxMQcQiB+cqQ0u036+JDYqmTaWwmwyQgoyrQO?=
 =?us-ascii?Q?SgvmiXCMXjx30/NMwGPVDCQLqCjuGZ58WAWJNaNSbDmmRjc97iP13b+SpypL?=
 =?us-ascii?Q?sIVQZ4ouRoW7jYktyHpcihw6rbkzib/udW9zS+KqQA5qJd20sN2gpeKY/YEi?=
 =?us-ascii?Q?wO97Lhym92nBYJVbGCfjo0MUUZWnRwdF+uIBrbaY3iaDj0hK/xH2dkwnma8z?=
 =?us-ascii?Q?ex+MHiIoMvrdpkdR6QLF0O/dNYSx0YZDc3DZ5byQB03v1bR4QXFz2CeQf+dP?=
 =?us-ascii?Q?X9RHKl0SyvFOLhts1y2VotZlHa2yPDSRVA/pA2mTcfBVHcmgZGTKd/h7ncGB?=
 =?us-ascii?Q?yAUF+thW/VaugskznfARvJk2Uy1wr//+XxwTYBBU3xpro5d4Zc/51PObznxS?=
 =?us-ascii?Q?c2olu8wuJ92vA0uzBtadrwNX7ZQvKHKqD3SDvyVO++GUOuOBTpzAJAq3Oiru?=
 =?us-ascii?Q?2PWPVCONFlpHxR2o5wCdi9zHHAWjaLQo/SYwH8WZHF7e4an2WN38Etbcyldp?=
 =?us-ascii?Q?5Cfzf+RxRsycNM1PRj22F5XGZSLM4FSb/GoO8llZcI8g44qJovOukdjczWps?=
 =?us-ascii?Q?VKTDDVJnCYK/JKGgFSaTbKW+m1h7aUIali7kb2zYtjKJbPc+2PyE7bChb7Yz?=
 =?us-ascii?Q?1fqDOUd4XioxR39BLEvEEWoU+GU7gb4LJZerN2xn4CRCh427VAxLOF1895Ee?=
 =?us-ascii?Q?giwx3x4gK2o0giAFr+faXShV/iVr/hUtoK7VTHXKZfrjC7BXQTYqlgQxqWqH?=
 =?us-ascii?Q?6tZafXXu9AeIiC7+IIdwNso21U0q0QxaiZ237+RvszWxvOeEh0KFj2s4dvQs?=
 =?us-ascii?Q?9Iu/QJ4MDUnIACXXZUt/KTHnvonZqsF0O2CCuv+tNWwjaWXquvTpQj1d9Klw?=
 =?us-ascii?Q?c5c2ioUXMYXZAicvd78YfXlIJa6PDDVyT1OdWfzL5GR/JaRK569FiW/8EEfM?=
 =?us-ascii?Q?N+q25hyaPDZvxduUKV/C6+ulMKxyGwrheBpRNavUeq9TEJu4pNaTIAP0oNPV?=
 =?us-ascii?Q?BQ8vtN2k28v7ep4EzGFAOFMi//EtSNBVmnxlY9wfu6kG3sjyPP4VIjukrUAM?=
 =?us-ascii?Q?27xBoY0GxmMXQ6wD/nm9rGl14zIoD/N5Plx62fFJf5l3IM8nA5QyQ3pmjMlB?=
 =?us-ascii?Q?u6zcsH7QqokZdnrvPhuOulKn+qWdnQDN83dtGB2Bb7G+8a+cQHIIBFNGFixV?=
 =?us-ascii?Q?YQtq0zvN1PfQbQHl4p5Q51864Ee1zaGnC90pG4y7p/2WGOf7bJqTKTqQZIGu?=
 =?us-ascii?Q?x9Pff7BPiS82Yji8xr6kAtS0yGVgsc90BbmuJL2nMRa7Edq5uWpus4QeM305?=
 =?us-ascii?Q?8nNf+lfgIdcPknC/Ee+gtFPb+l7FMboMN8a/KMhsfkaUw9C3GnewKAXzSsN1?=
 =?us-ascii?Q?BWuxJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KeA2MV7yPEufxfy52l3d3S/IFGab/whdWgeQTAhXbk3zEqlpfNCZipCQDYsKxXfdX1l/Cx4Bu/hrxTBPvzWbuOOuK1oEEWukT/C8shi9ODeZk+cCjoo89Ju5+j2dQHNZQpHCBOjDDuAfhPmBNw7Tf65NjXxdscFdhBRVErODF4NM8GIcNr75sMnfLBALBAxAk/4xBUKkg+gwLjS4WPw6xuUJY5cOqKd3bFrJO/copdezUWW8xYQ+eI4zyh1d7UsdetK7Dq31xpzl+ieZyC2KEosGNsjM6Pe7/svts2DoixaxD1QAWzX6m7UzSNHV9MOjb2O3azIG+Xj4rx4EriGimiSmoASoUeySdLgFBjmp9FNTPlM4CEg+LvGTLHOzzZ0Afj8ZhaAqP2i1Y6FW3b8F/aj702dad2ZtbmlMmqIVx/0r3BfkG3fWrPwT1JsS9AJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:02.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c40b1f-9da3-438e-d3c2-08de61aa4293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 41CE2C65E7
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 96888d87a8df..acf29ba3b205 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2621,6 +2621,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 928276dba952..906065e0d2a6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -252,4 +252,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 struct cxl_region;
 struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


