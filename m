Return-Path: <netdev+bounces-255637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9hH2l4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6931C660D
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06D13045C2A
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17547246BBA;
	Sun,  1 Feb 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KKAve6OS"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC215665C;
	Sun,  1 Feb 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961328; cv=fail; b=YiEo3ThiIb0Ky2ZRfCvklp4N8RPiEQ7HU/yzspdo2PqEeLmTJKriI38HF0IH+hyoA0+lm+3L+E1htuoOd+zRKW9qJ9rv6KiZoF3oByiJCZ8gPW1YGJLxZeruFoQ4Grf0Y/Hg6OHpEN58ZUXBAAkg3wrpZJrZ9pi1xuZrdnpuLb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961328; c=relaxed/simple;
	bh=VEEjsGb08TwTqKtaZQYoM/2i9wTgKwNK3CRVQini2ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1X8ki/9AuoHYihoet1bTjEYWXdK2IBtRkpr4RWuyeSGPPmfbNTKjbiGwItJlGNTWDFs2I9QnfYikx1cnAxpZRqcLSbg/bVWwCuuwNO2pRmeB5zHT0NuIOOb5JrfZ9Rm25JQIUnDB6FJPjzYxHjHEI5B0mwBSxM28ygD2HxzMV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KKAve6OS; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P//ztYR67gIlmh7/qcABrdotUXmGk4GckQqq1a3xRvn9MKpoZy4Unlxz2BHOna5efs+S4yXU7izoZdCKzsqFTwuibQvjXI9BHTNo0iChDiTc47BXr+xxUd+X3bwkthoz5BqukWwIvKZ6ic2w7q3aN9QFJ69ATq545KxvhO5XSIt0bAaV7HgRPrwnVnVsCuoyDMHH4S9aDYdVWyhbNqzu9hbdg7PCp87GxWN/AYbiA1QULJB7vLWpO+Ft73seS1l8+Y7b4vONKB4eqUaVQfJHtm62gMPkGNjzkuWCiRp7BBm7ahZhhxbEkIllfWcIjuSYn2oP2sFIOJ+5dTD5AfEYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pOszlSikSFkVnij+lSgOvItu0b2iLVHTa96mH5y9Jw=;
 b=id3S7aZX0wpwxLYgqRgdPMltlMhXhnDhr5rT/4QaMKP237mouxUIVLdc/QHGX08rj8HPYM4B7RiVsdrqognIC2PjBwd5KFavtVWtUzrD66YPBroTKe0NTYCMmYPu622DOeKrKc2g174b65FzPb4wAByPdJsPGKD7ZJ38cALGaUHSVtn5YW9SHv9dpfc3ncMJKIhbG2bSOH3X9VbszrL2tDIKsSBh5y7fC3oOCZD8QaFK+QDpgQx2vebMj1YIodobn3Xm1koHZBDQDOEIVyQtGsy+kNEZ/6h2re0vrUSjM4ksE6g8eY4bQAI4Nm1qoknihoxx//i/QPbWGR4qbkDjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pOszlSikSFkVnij+lSgOvItu0b2iLVHTa96mH5y9Jw=;
 b=KKAve6OS+zPp+ic4NJSaFyc1KBAnMAxhxZW6fDLPRWpJc/2tAG54jUxSH4jbuHNfkU7SPlUO9JvrNtiygCJqKByQ9Pu6jlpjqP3h9cfJcBFsmY1npvBIFfyWehtEy2TCzpz9fsZ/deHiBbXBmkFMj+E7ujQcshfcLo1MDyevp7E=
Received: from PH8P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::8)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:21 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::bb) by PH8P221CA0019.outlook.office365.com
 (2603:10b6:510:2d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Sun,
 1 Feb 2026 15:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 07:55:20 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:18 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 21/22] sfc: create cxl region
Date: Sun, 1 Feb 2026 15:54:37 +0000
Message-ID: <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d1a378-48b2-48fc-73bb-08de61aa4db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nuf3IqQJtlbP6iGIf2W6SDkW+LI31ZAlcfOfmwLN2DonHLa4hg1661Sp7+T9?=
 =?us-ascii?Q?Y8I7PL8Wn8LJSL6XhQCkRey99I57PXgMVW2L0cLEsBu9imMAJmQ+VlZq7ojt?=
 =?us-ascii?Q?CxklEO0Qatf2bOkNfp3Oj/AC0UkqP/7vOOHNwS33ljJnwa7yDK+9BwlCn+gP?=
 =?us-ascii?Q?7XCEWAS8fONI3+LRXb/aheG1Rdc0YAClWDvZG0tua/oJXaHLPisF+RwmHfAh?=
 =?us-ascii?Q?Kwlg69ThaN55v0lqRACen7jc4rlq+PM/mRH3vG967/I/SVRas41UhhmvurTw?=
 =?us-ascii?Q?pbrWnWK004HGNPgjSAziGm0YHmpVinz6yByVWvzfCvyBtXxjyCGYmx5PPZE3?=
 =?us-ascii?Q?N4PWRdmmD9Z07wkL7iSIfsfOJxRV4PW3akMuglzB5QudP1JSIdalWb7P2w2r?=
 =?us-ascii?Q?mN5TJy5udhSox6L+OHbY0bjMVg7kZxkKyEBBrnNipNOSAdGWhyJHtrWfQAlb?=
 =?us-ascii?Q?gyWetJrqh1wRWoWza/pUdRuqS5uDYd5D5xtngCE/3pRZxzhuUsekz18tx44G?=
 =?us-ascii?Q?1Ecd6K1bDdYRJLuGkOGNv5jh7kx/Gjh7QwBAG9OKnG8NBzriufdSo/vazxd3?=
 =?us-ascii?Q?10H9T/2kpxEY/7LeloFvkZTK8cOdpXHoLoWnSVVHo/KamoGRWq0qZbWsANKu?=
 =?us-ascii?Q?3YFBNzTyo6EaA3/1wRf1AQZsUR8LhJ8gBcZ2HJvl+ebFFtGABIO0fBHMM2zS?=
 =?us-ascii?Q?anczET63Ckjb7P3e6H1dpAeaDrOxz8OYm1QxSaQ6/ywYtCI677//v/b0t+Kr?=
 =?us-ascii?Q?I+xJmfuR8W8jdKEk+/R2LYZ7r7qZMqvvTyc1wx470eeWQZWxaAWnH+odpPac?=
 =?us-ascii?Q?/5BCpOcSutq0HAUEQ5Fqa+4p5zyvNwEdI7doIIdau4SBteGpHSVTIrunSziw?=
 =?us-ascii?Q?A/2RytQZTOth5j12bCoRTP5KFgk5M5IzvwlhpwfTsA66cH0gRe5+mPd3uzbY?=
 =?us-ascii?Q?Ic946BoD19LFCwHfp6jK9odpHYl2RkcOh/RbaP3QaYaEAixPou6gYWQN5Yir?=
 =?us-ascii?Q?7xcWMcodvz1osnRoHCSrM7iKpRv8kXTz+X5izsFNVQojtMj5QKxtHWUw7jBE?=
 =?us-ascii?Q?CIa07VYbqIQeIh6HYXlBLiTQAep7EjT8Wp06tHIu0kBRg7CMFiDYR1xgOZ3/?=
 =?us-ascii?Q?ZdZZbzyOhj7lur5cDFeso3p86+A50nHdHUz3dcWsd6CzRT7Gsa8EGu7gEbm/?=
 =?us-ascii?Q?1DBIv4cLqlvRBNY4IGrSUCVx0Hll2a9BJKxQVoLA7OIa3DHb772V7jHTBPw9?=
 =?us-ascii?Q?flmkfFnIBjS+FZNM45XU05fVmR22FnLTnIFWJ2uosZRCfGIdHK0ewNxP9iwh?=
 =?us-ascii?Q?e9dB0mp54b3ehp6hTrjZ+D+ux3fcImKcF3zx3oFnW5ipH82uo/s9dyvJ+cmW?=
 =?us-ascii?Q?vbgyuIqMYRd4mVZG3M2bwZ245aYeuBfCAG1k+hXe9+TRftjH/drmc+38gNJ6?=
 =?us-ascii?Q?CumuyJ2gH+fLaLH5Dmy+S26Sb6YZ20J8ZNERT4tGKo1XJ4vpcdKlQl2I+t9J?=
 =?us-ascii?Q?0s/klBOuIz0xJeCffoCeMDcIylzb8XdLsfqt/ODSJwt8Jg9oHxtwa6I6m5iv?=
 =?us-ascii?Q?EsH63CB6yoQE12WIC9hFMA5VMnNCpz5HjSL1k8D+NeL4XOkFu+wFyZoSpcPX?=
 =?us-ascii?Q?5PnElvYg7uzYNL+4CZD8pflPMcvQ1SzwZexUwfDE/OYZnLZX6j8vqKQeGK2L?=
 =?us-ascii?Q?yLcMUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qpRQaJOtfjvGsiIyvPqUbKPZfs5ffb/gK4nc/Yizq5IjqTJ/g91B6WTWQJ5NvoPkOBggCaDVHhFMAwaF3TFvKI6T6OrAyAkYzsNy9lpvQnDHBaIps7+tMTfqB5+J3gVNohYVLQd8YMjqmvQUKKmyc6ZzjQma/d2JuC1nEp82TbVP0/QGSJmWA3NFJZBlrcfZEwnMaAJMg6LAfUozUvmqynxDew7C8u9qOPRYPZX8K0HgcqzeP4+pStUtOrVEOpZXTqmY6Gdt3Ak32DGvWjAe8jM9k0QBvwhQOZyFBXcmchGrL+X0S6Qs1N3f6maA8zXA5YQjvMd36EQiimJAx9h3hSQ5yWvDHXAC7ri9ukhtp70lFv5YsRNR3ZR2qCDpniIxrJBI4con/yyY7Np3tC2m2ayi/LHQlkp4lTXFqiZWJyFel5PQhiv4gjPI2vBdLlLg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:20.8753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1a378-48b2-48fc-73bb-08de61aa4db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255637-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D6931C660D
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 2cfd0a46225f..4d5f3974e51d 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -134,6 +134,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			cxl_put_root_decoder(cxl->cxlrd);
 			return PTR_ERR(cxl->cxled);
 		}
+
+		cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+		if (IS_ERR(cxl->efx_region)) {
+			pci_err(pci_dev, "CXL accel create region failed");
+			cxl_put_root_decoder(cxl->cxlrd);
+			cxl_dpa_free(cxl->cxled);
+			return PTR_ERR(cxl->efx_region);
+		}
 	}
 
 	probe_data->cxl = cxl;
@@ -147,11 +155,11 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 
 	if (probe_data->cxl->hdm_was_committed) {
 		iounmap(probe_data->cxl->ctpio_cxl);
-		cxl_unregister_region(probe_data->cxl->efx_region);
 	} else {
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
+	cxl_unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


