Return-Path: <netdev+bounces-273223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE3uNvaMymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:47:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159735D207
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 081693086E3B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A642E8B64;
	Mon, 30 Mar 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m50lQ1A0"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B532E1F11;
	Mon, 30 Mar 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881530; cv=fail; b=mEK7OzO8xeOtewlGoVsfuw9+hc7d5vFu+jtbXmxEx5VKtzcl+x5z9HkyQNSJUsmiP7PYQUmu7ot9WTH702sY75SdScqb2/Bexz0A/1g0W4WRjgE3s5hQE/l7pxsugktymP1hyN3pN95jq41Ux2F6JgmlWU81bIxW4PhE+TN8ZeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881530; c=relaxed/simple;
	bh=bKvjyPwHD9FDF4zxaCgRxaJxFaDE8BBBv7sA4LYgloQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e79kE62Oc6WLkTt/uRsNYt2FfmcXInvDK2pO+GgjtAAbiYEOXq6ncHK+nq8Wt2ESwp/oAk7PPx2lpTry+ky1vIrFul1IK7hYubm4CwOTL9nuzqHlloYRDzaBUwBZ1Q1rUnSNSH20JXjABrH5YXkRKE+3UQonXjnU8OKLdWFp/Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m50lQ1A0; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcjSuPAW9zYhepIsH7icjXT+DDfF9cx9wva5MUmoEZ0NVcfvebs8p5jYQgmVzkYYApm8JKOVqRz5vw3m40VbspTr+fivZMP7ELgwseENJtb7JlEuyEKlyfbjRzbSXX1EPWyBorRTKn349jDCOPjjoD5mhyeMdZemTkqSBr3btsvcVPPCYVo/ueR/EVtO7DIbqTRjlc6ooJkG5uLYqn7bjvxkvrBhud2pd04sxdC2+6S9EW5Cok59wFxTcuqi2QrkAPR/iKXluuDLdXyDKSOCqZiLQUZjMpo5K+deZcf2T6sJ5nTqWQ9cqbi2xcyqBU4AnmANADqp38SV+5wwhduWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxlxP1uZCGHbxiRlElMYlqwurbdPCyWOk53lCJTfM9o=;
 b=IFakDwIWXBMRQPoXVapPD1IPeWIUWkYlSZMbnQynmaSHdHJH5wKIwQJhj3+Dt6GGMGbDEH8NJnSYpN398YYklg6qCVgRMKgJAy0NhQy+mYrb0W+jbYE7BthP+8L81SSM4mDA0SyWvyeZjQ73Gm+dvPFYPwpVf7HTy+4/8p3hk/32AIrLZCBSqeZAXm8gzNtXFWQ+TvP1rFPlmDvhApdQCwSPohHR+dSc2AszPSBlo/sclZoGjW0asr8Zkvr9e2kkE0hBK40H+mYtQXWk8xvAIVWmeZoH12Q4SP68qtgDfyIePAYkWMQHuUUF44PVPHpwb2VYTCD37CSPJ3d+Ap/MhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxlxP1uZCGHbxiRlElMYlqwurbdPCyWOk53lCJTfM9o=;
 b=m50lQ1A00S1Wb/Lah+wolMkSqErvYoM8z5LImOz4qWcu0cOp2hCm7w8/uBtL6l/RN+MoZmy6tT/IAbKq0Lx77Cj1N7PBU1ZnC2YpBQIncoXpo97f9ddPsAyR2WfN4CqfS/9OYLpFBSsMeVHW5kHCF13aoAe4qOoK34BkURQb25E=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:45 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::fb) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 09:38:43 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v25 05/11] sfc: create type2 cxl memdev
Date: Mon, 30 Mar 2026 15:38:21 +0100
Message-ID: <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 167e5e37-4a61-4468-ce06-08de8e6a0c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LqZRYohrA0ZXrcQrw99Q5oaIs05WvW6PfiXioStdapuK8VQGcT45y/QhEnRzGW0dnBrDLWktXQVvN8GbKkiJhw2TkUNTVv2kUbgmq5iSKt0Iddm0Dfel966njhXGdqzvARt/hrsJWHGyWCwT+44Fysg9SarxUBvJVrB1dWLiRtWuRya5cAhoEkmig2Due5bEqH+vyFvSC+9QfvPV8g/bb7/xglrXJMEqwoiIpE4Hhq56bjunRlvzGLD63BJYf60L6zD4zmM775ormQ5i6vjb8uCbG+9Ys6GqjRZcGS7C6BYyww2+3twR59VbTKdERK7T+IpXeUVWQYIMZ+xNUBEcLlSQC/FA1w4UTo+5/f+jTMjfMZ8UPuy6XgzTF+vKrYQAit3khGFqKQWBbfB2w1HHPl1Gk4Lfv/vSiFlrJ8YyaSYHT2uqr7AlYcOrEuA0ApU6df0Uyvrtv6S295i1ECB1EWmdIOr+owKE7hPD3NhjflPLL6JRrqTmFdk7diWVKC3xDWuh6mr4TGPXfu85G1QgvMpztFjg536Ig1M4uF1dhjIEBMFEMiPeMgjv3oCOjPT6LSeeviz5kHHpBQDYIFMo9uNejhfLCr5uEbsuj98po5JhbARqv8i6j2Bw0/U1x7jXXl0ezIch2oGtivALBhjWod5CRfLdHuKcS+0BIaUkfoAvtrSWjgxit9tuS+k62WoWonC0q0fKBm2y/v2ZzBV6H21T3VZMWfeR4RMwGVsI1u3CeX5kaCbdm/phJgw3DQhjeieKWwWntPX8L8O14kFF9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aqlMKm/2dnSN57wbffCEM2h90f//L5N0xEyopbKl0l3UgYp9ZI5nteKACS/w+KlyILULjnp3TE4uOmQHuYllwGuopdEEoH5Dkx+l53h5ztEPO/baGfOvwfLPyaM5UCA97vFKb3FLcc4zq/Nd5FjmR8/df7t9nPrPxjy+5qT3WkT5AT+SzvVnrC4bz+ey7/aew4mxNDPHUDsUTHXJOv6Ie5S6rD7oJPZy8e4C/jBscY/fU0VB8dRVWs/Ffb5ogbdAShJudcAJf+4LC/XFNiakolTS5/JoIsD32nQFjKsl7TlUSBCUR8mJULMd7/6GmzE1ShhOL3MatKk/lo9tMfCBCaFdNe/YCleDAKiRBcQ5uWEPUT1p9DlOO59TNUQKr8xJzU8ajsfYXkWp1G6gtY7ipfPnPRzyXGyjCCDcXZbxB+Pg2qFDferuklOuyoKXOaf7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:45.3909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167e5e37-4a61-4468-ce06-08de8e6a0c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,samsung.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273223-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,samsung.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8159735D207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 6619084a77d8..63e6f277ae9f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


