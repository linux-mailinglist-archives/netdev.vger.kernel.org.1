Return-Path: <netdev+bounces-255641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICo5NpZ3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F420FC65A4
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8C5D30060B9
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6347248F47;
	Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qe9ptmPm"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7925783C;
	Sun,  1 Feb 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961330; cv=fail; b=Nakf4gvONlFgkDJoDX8eWuDMOhobIUVe8S1YxE/NoZQGGLk542lOfl+1rSVVXLFEYVlO6ztM7jPdJMWwEP0iIl16mz4N8fin7wvf7UwZu1fCwqBXltt9F4Y2GKjHcqQYH+4Z0zuUizghmC97PYBwknhNbBXXqflPZ2TWSzthJsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961330; c=relaxed/simple;
	bh=2TwgZhk9KrcfVZPbYhjVrxl7Wav9tQwJ4PRR1a7ALyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwYG2S9Yai7lvfiBv9gx3DFuzGi0shyu0oGzk6KBEUEOy5dL7ivG2JcT+JOh78ykXUr5kGJSqXgCrk3IGY3UVX9MfE2vYfkhqxlSW9Sju1JL808FuXayF0DaFs6agdNCPB1InxPf/maBqAoaoc8Lb2vs7tfg3/lsc9Uw4cDMEAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qe9ptmPm; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/WsawRo+yJHpYPr1zJpvELPU6a+3YI9qTfMFcPLZMe2BvLesBuj+vpvs/j/051jD4HJId45N+ldRcOQ4g7wKjHte3u4NI2pA/NnvlQq9mcLOYUt0DSU9i9fbXyUrVrnwqimwAkAmmloFSNmYHwXJ9gv2tYt9dSqPlEb04Vu2TeiBvtM9GqolW3J9jR9FSvs/ecBYSM2mDNmkwS9CXjkrhV7PjzgsqWNzocGSXGPMl8JSNuFczDngIdzLauiRl0jDnedPE2D2UqEdu0oOfk9ZiAE7IWORUgWMLg7gzvc4jgYfaR5xbD+tgL5gaWzKsc1o10mdjRnOQ5g1Qz3C4CPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT8lL5wLuixDjHwOxrg4RjQJVi9cXqU3zdrcXHuKH0g=;
 b=QnnWQUSu9rKd7IuEhkGQi+jwR1z+gbK9TiOGEt8o0a+uZFtt3uhERpE3rpuNVsOKAgJ28vzHzOIVh3wem+btPzI0jkbGGrGBdHdFKx8KB8RdEP5tDu0ZSZ00Mf1YsfnKrOvoScJa3cWD55lmV/0+ogEtxbvloBsHcYlDRWVhvCcAgzYk0IQuau1JUAwDDuuJhSO+YBbGbMyKX8ghCr23gN144IexAWKwfAq/1lGVnXCO/4XcJ+j4kUTnOSSLFaIyBbNDg7Zl+jZXsLRh1NMW01cSr8x4MWmzlVw/RbMpkryxcGKjE07s8DIV4e0hxMdeV0MELdfCEuSLHUpW2b3ONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT8lL5wLuixDjHwOxrg4RjQJVi9cXqU3zdrcXHuKH0g=;
 b=Qe9ptmPmsymbaG8hv6OaH2aZC6kz520CBKRS+z/65tu6/pzFTiW6FKCqbZaC4cCSoyxHEqkJhxckme3OkU0O2oEVVXf3bkJOzQy7NFclsOIqPRP35Y8k63hM8Llj6gidY6CzQZzWD215UhM2SZCeM2yvuk687E7zK/f+DRyfr2c=
Received: from BYAPR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:74::43)
 by BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:22 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::81) by BYAPR05CA0066.outlook.office365.com
 (2603:10b6:a03:74::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Sun, 1
 Feb 2026 15:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:10 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:08 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v23 15/22] sfc: get endpoint decoder
Date: Sun, 1 Feb 2026 15:54:31 +0000
Message-ID: <20260201155438.2664640-16-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4aa67d-e5c5-4282-6afb-08de61aa4e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jhc1fRaHCdQh7QUIAYEkzpvLJZ/lExw/yT/a1/RSEIEB7n++aSw+F5SVHW1t?=
 =?us-ascii?Q?smMVGVJ7FA4xASaJItdZMEYtUN5hFnA2vyttFYvRfi1LVVIzxBirrcxcy9P5?=
 =?us-ascii?Q?VwQjXfq8X4zmnyWYUxUukQZLjlWtz34BemSDjIEbHOZBlx1+FBxsn/K4nEok?=
 =?us-ascii?Q?fW94DfIyLjmeTm5L6ELPenjGzvjSFvUbQkSBZshIn23z/123zN2KqFoQSnFF?=
 =?us-ascii?Q?DkPqUHHh+zBLTUcLMd3xdkHDx8MNN/5jSLAvD9YdvcLBQLuRgNT9/BS8gTmX?=
 =?us-ascii?Q?jhoEY85926geqt0VZYhdK/e5otIwzqvqOMwppYAkP9PI2mIkn2DihPjPiNxp?=
 =?us-ascii?Q?efDprs1XYHnB527stu0NW8Dj6NfMURJev6X1QR5Sh6tJ4OchuTcHk+7NdpAB?=
 =?us-ascii?Q?zZPKlLQbAkMBL7JAQj07e7e+lO2NuGH6pGunhhmrGKeE5LQP14Tag04KMseg?=
 =?us-ascii?Q?/be/mCvgD7IwLsOk+dFqqLX18iljyNooe/35iRSOSP5aazvvdXL6i7be7wWo?=
 =?us-ascii?Q?KcjlB9eKHaMEX2OLjCAaOBxKhYQ6r2AdySVmijFqf3ir/knzDglp8BR4TU/C?=
 =?us-ascii?Q?3BPFQ3LBZmpF0gb2Q2NPGS7ApDS9WU1ltByV966QvNYrqItZxJl/UFFA+AD4?=
 =?us-ascii?Q?yjmMCLIHluC8Yg5yOT7KF6X81BJn2Yk80rJjO6kzx2udUMwpsaZGUVMWyX2Q?=
 =?us-ascii?Q?Vsr92LDtvS6I4RqkgaEAYatAO21Ug5Kx05on57NWf4bll7VZ552YLlAcroqZ?=
 =?us-ascii?Q?0JDAi0x+9riQOpnB/16OD9GBz2mnOW8kJarMxlA4H+eq+xiw3LvV+6DbefGA?=
 =?us-ascii?Q?+sEDdj88Sd8kN5R9mIK1FqkaPankrGXQ1452OMREmwTQc9b0KorIyvJNFE4w?=
 =?us-ascii?Q?pZlivaJUHBKZtOSlGMxqg/ro05bL2aOol1RA9BsxwdlxkKg2NpddPo5j0ZTn?=
 =?us-ascii?Q?Rd1h0aEBVRnLN9f1CkvAakOA0r5YoJMwCG5n9caySa+F/UcbmQzHMQSqtfNt?=
 =?us-ascii?Q?3mQKggZ8WqN5Ii02+VsHfLfLXRw1VCFL7/DjSjiaZFuaFqtqKjb1MjiffK+r?=
 =?us-ascii?Q?Ea5mGpFisISe1a4j+AgqOivUk7yTZfeWksAWDcZ5tIZiYeaD/P0LSf4wX35X?=
 =?us-ascii?Q?7vUSclBAw0oxtH3Lc8/Sjkvt76slatZefeir+NuAqFI88fmuYzP0mqjy0Y0I?=
 =?us-ascii?Q?4zkHq/jGQKK2wNeFiwg6uhaDbh0+UWWq6Zqu9DxwHL47TdUhgRTcOrDA1jZH?=
 =?us-ascii?Q?3Z+vJVHYOMyRvlwZFDTugyhxy9m6wiB09QO+u1i+4p1rgbNgFachF5Rl9uUB?=
 =?us-ascii?Q?ui4U6bik5QiTK7UQ6klPZwTdFTGwVZiyWVihnN2Dre/yc5zcOc2sfo8Rrhuy?=
 =?us-ascii?Q?+Sl8b05iLo1REEu/738/SsSEIPNQEYmA3GP28dmohvC8dqd2hPBkzT4y4AZx?=
 =?us-ascii?Q?Zody7c/xJW1MFnEoPCXszxDZLC6plOwDsTbdBr9mUMduVF6VUaEe/JASzXXC?=
 =?us-ascii?Q?0g3nt+5kNCQwUFKzp9xEC0RoBQ/sw7rGNwBIcgByR9wWXov1m1JmcQbU6OVb?=
 =?us-ascii?Q?9D1378paTvyn97EZ1a2Pii0di0A7GDzH2VNO22zuaIIhkWmGIPkeso6ACMIE?=
 =?us-ascii?Q?js1CTA1lRjb/lM+Pv9AuF63rBz6NjNEidajcZ9JhLRcr+24wStLdiIOor8Ws?=
 =?us-ascii?Q?vWHAeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XBUeOG2e6psWU/nyyU+6zY4Rhwv9XdU2wrKejIH29Rnf1Payr03YiuXbi9mpGe4pLXH/HuMKBfkIr53xGVz7JdvBhSe6Q5i8mQkjM600Pa3VBsCpbx4LxlmSSbWOQv4yU/93itMeS3ci3Cuz8ukDwB3/JaZoEZLPVs0I7bK9iYwg0aEm/c0On6DhT9VVFp8WjWHT3PjdIbiCmrYJ51kFclULpVTDCG+QoUFRGVQ9Jmdqj0jJpEwxHrIP8aidOIJ2vYPkz+CTwUCRALfJ8ohU5BeEnRob0gHQa+8Bc8jaYICm5V/xbF+G+w5vuaAuT0ZnJEhA5iYXqOQb1MlvcgF92R9C/g72ZUcxWY/aFaDdZsm7tWm0ul3WdHwK2YOUYcJmmEIERAchY3xK/gCmExN1YY2gIArs5DyXbwoEH64tgZ5shosUhZcnrdzifWtnsR8N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:22.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4aa67d-e5c5-4282-6afb-08de61aa4e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255641-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F420FC65A4
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 1a4c1097c315..2cfd0a46225f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -126,6 +126,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			cxl_put_root_decoder(cxl->cxlrd);
 			return -ENOSPC;
 		}
+
+		cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+					     EFX_CTPIO_BUFFER_SIZE);
+		if (IS_ERR(cxl->cxled)) {
+			pci_err(pci_dev, "CXL accel request DPA failed");
+			cxl_put_root_decoder(cxl->cxlrd);
+			return PTR_ERR(cxl->cxled);
+		}
 	}
 
 	probe_data->cxl = cxl;
@@ -141,6 +149,7 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_unregister_region(probe_data->cxl->efx_region);
 	} else {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
 }
-- 
2.34.1


