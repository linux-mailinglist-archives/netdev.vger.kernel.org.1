Return-Path: <netdev+bounces-207113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95AB05CFA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18513B99CC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF32EAB60;
	Tue, 15 Jul 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C076SPTj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B12E2EE7;
	Tue, 15 Jul 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586135; cv=fail; b=aoonXz6SmtVo/5O45FI3/aMrryikcjNeKdO2dE0SwWIw7tNF+n6izTwPdiif8n1wKqLK66WuZFeaOLfMMq4NnqPsUSi6rAQUXBZtfLDxbssHYjsIpaDgR9Ug5XgQiMKJU+g0Isap1+BX9ch3Br+i9or0+udUZ02dgCSPI+NoHMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586135; c=relaxed/simple;
	bh=VtfoxHCtXyOfvw4ubyb/YAQ4gMUPx/X8vwJT/T+o69o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0bOt+XEZtRAmSw2Vf428LENPLx6VH5fYPYX+AUtCJh7iz69VPKh/kpkuCPJJTvNm+vk+GvALdcy0sdBPlrR3mzI6vt/JMMKVt3eheIicN4V38RqWDJKMXf3DXvsO1E89P5SFTLY47/DvgRhe6ofISltwi8J5UxEk52hvQIJhPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C076SPTj; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okSh2GbziG82NI5a2kxjCa2TYDlfZTwTqFo7O60Tmv4XzDW8hWGcZXG6C5z64w8/VHiYpzNnALnI0ggV/GGGcGlIHjdWR1CZUkvm7wQe9+XvCmVOTukRBwZ7anVUojNMctzfQaMSwAZZO5qrn5jkTX11CsGZJyAMRqxuvbnjLXj7KzAhdppXW8hLQ/dTIs/K52q3a+79/B0RYjEaXNZ1UwdszqkzrJ2DRPEg7IPHFGSnfkjA4mMYBaOBNRjoj7Yll643xWlIhrAoInlUReX0XuH/ZQ/wZtu/hULbpF+NHwjVqqg/kSLN7rG9m8SPhzn4vgq0Q/dZQnI85vhV42inmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=RLVVjFvEJfgomgW526vSmHAqjPfCFppYy0AWcyxBcBfLnCJcv8WL2bh6XyHSVWAHuqyBFoG0g0vkJ9b4Pnpp0ru9lHobbV2N9vyJ/w7xAlw+MtQ5PvEUATb14cQJYPJlb7BG2Jh2ZuUQjuYkhD+EGBswAsAiomfmqdUBer9rx/0NlXhMeQMB6pee4u79Sw7d+v4lxYs68Gw37qle9mUO7892kvR7gzenZORBjz9kGBeptUIONqQ72f8Yal0EnOYsknA2V3RCB8pS9Z8kEf5SWU/4kC4DoctoksH8tpKN1QPReud2/oi8tH+VL+gm+1sS/8h3DHxFZYjwnGqosGdIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=C076SPTj84qoyE9MoeitVEiPsTjSg8fJwwJntmtqwPdSA8amjsDBFcKuclrN2g9Vv8DJm0uN7sy8SsRzQhlmfCTtqe2vu9uJe1uFXGtHKwWHe19xMLPXQMjFRy2YOzfGNpP+cSaO/dfUJGXGEDkYa2i1qrbbYgCD2g4UsMHV98iWKlI7DjDUGkonFJaJ9CTY1NgK9IFAXn/CMHvx5ALtRT0EYdN3Yv5RSclNiiG6cNmmpeeYoKjq/VkwFmUTpjt+kUAXpatceY4tuO5t29t/IBdSF87B81fkACz17RNbqxaFTNQHOJBbSXiZxwaaMMFNqDbcROYrYlKH82G4SWfMWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:28:49 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:49 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v30 09/20] Documentation: add ULP DDP offload documentation
Date: Tue, 15 Jul 2025 13:27:38 +0000
Message-Id: <20250715132750.9619-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0172429d-a584-41cb-8312-08ddc3a388b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyggODRfRs6bOyE/cuCT2fxeu5r06vJDpkRRIudJqlgmR9mF8Bxmx+AZZWko?=
 =?us-ascii?Q?h7sx1dHkIgMhmtIXjnaNI74t+vqY2fj3SNOcw2KAtxs5ZyTuQNm5meAj3JIq?=
 =?us-ascii?Q?oPQONMczua6yFv8TEPh6QdeXfVTtgk849u7UtJPb0GBSpOMnZCbDoXjHqWQ+?=
 =?us-ascii?Q?R836FM0rHzPNclCMDdbhY9ZkJLl6SAlWsvBrbLtUw1a/VJJa4MbqbZuukZfr?=
 =?us-ascii?Q?XhI2hQo/zPd0/qPfr0qNowZagyWqWk3aeIjc5gDg0gA/G2cjelEZQendGAjO?=
 =?us-ascii?Q?kbVwslYDTCpqKxOf1TMFHeqKngJv5vLUTH4AMQYG/W36uAqRtIlxTJlxgDgX?=
 =?us-ascii?Q?jAYcJSuELpCUVOmGCZ3KArvv+5LO2cxQCwxMRaZb5Sax4GESmxeo10W9CcY2?=
 =?us-ascii?Q?2EtjEDutDS8Qr7vz0ue2zE7dIe/XCLm7UWEJJNJp6zyLtC41sAkdOqgYk7qr?=
 =?us-ascii?Q?W0HKTI6hotWUMa+5WbWhW0Uf3cwiREdFUCUs/MaCBRExk5oZFZfoAq9iRcq4?=
 =?us-ascii?Q?1+AYPqwVHdz8OSPdLXTniQFLoSs8cddlSGyZPgizioON47gm/q4fk3rLYBYK?=
 =?us-ascii?Q?sCgh81O2L+WdkXtwR7Tza+0pgusks37c2xQ+OoatlSshweT4RPeBcmhWq/nt?=
 =?us-ascii?Q?ZDAu8oiKccg7lMMy4xRN6ugrEUdG9F3xoN8qsWxOxfngHn2QacLuR8duPNnm?=
 =?us-ascii?Q?nbFD479byP7ogTW0+KZnTXzwwiVzOoq3sYSqgupXxipn2m0xW91hI/KjeLeo?=
 =?us-ascii?Q?JpWEINQdOP7qg2mQ1nu76cPa1OszoesA5LVmz9Sv6ypksbh6WKhPRr/tbw4G?=
 =?us-ascii?Q?loocn1lejr47OLirbc5INZpdWIaZoADB5mkLiso2qQn5GyQN+U9xz16YFWtt?=
 =?us-ascii?Q?lOsG0UaDnQ/wDYN6z4JHYw9b17vHek5NxiOoTidoyVfLMX/K74aZZggLP2Pb?=
 =?us-ascii?Q?pR0wbCX+2DBcLnF8TsjmYnRUEoNEqaajLeo8wA1pXMTvrFpcTDfna542oNdg?=
 =?us-ascii?Q?8WvGwx+ZStsWsP5ImQiX3ccHxzI4YVE283rboO6fdFscBHr5ym+Y7asdiG27?=
 =?us-ascii?Q?WCeEULf7cAJkJPuGvWh0d9lifQHzvdYwCYkn/4H9R8UyZun1ro3h/SRP9QUL?=
 =?us-ascii?Q?R9VbOYIzx7steWBHW0n6lCgGEFAXMdtj0jalV9ZOidSvgYK4IhPy2P9MieYW?=
 =?us-ascii?Q?kdtg41z4FUAAASQtpr+dW3PoRgp2pixzm0WONosLt16nLBtt2VTmXWSVSBJ/?=
 =?us-ascii?Q?Agr3r7lzCMqMxcZt/d/3nbvbCcalDyYMmr7UboQj6c8UEN4G/Q1qxSD+dq1e?=
 =?us-ascii?Q?ISs5E7T3gRbH9tXNoMDB+xxgkGlHIdGj7kAPMhTlhJxYBoUp3NS3ir2HsGE7?=
 =?us-ascii?Q?lCfUX3brWDuPJLhkKveWIaxdTtzfdTdC1j3aRlWfVQZeIKyR117lAiijgApw?=
 =?us-ascii?Q?Q0wTY3kP43M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3oDG+cWa++cc5BgOmYoe9MTyzpYRWBtbqR5EAGf5MEqijC/mVjdPKYWzTSF?=
 =?us-ascii?Q?3+ES+/6+bnJ+qkWgGSbc15AVtAsDe6gY62c+ACg0YYXk+hPjjLog3ZtlgNMJ?=
 =?us-ascii?Q?l89ikFnhHNHrAT0wTSXsIP4HOdyuskvbPl/MwBOoHx46zJvR9lihHjc2f23T?=
 =?us-ascii?Q?OAGm/LyrM3XGLehYcXuw6CABr+6EYW4f10xfXaaPZc5LAeRNt6H5G7AKlQS7?=
 =?us-ascii?Q?Rs3IreEK9eKkgpION341hja6IRGimtN/YqAuiLURkUFjo1q4p2HCofTCecwb?=
 =?us-ascii?Q?xCJaes/06+cKNF4JC49EP0CjyRiCSesVWn2ZtvDPVZerKdHJoXG6v+Cgmui3?=
 =?us-ascii?Q?yYuKaTYVstVsMxJ+tI4ryBiRMFLiMAAIVA9gkpXao9EMncjT7qwdPBzfZqyg?=
 =?us-ascii?Q?h/5RsYf69dWj6IOSvoTpIPWs3Q4ph6bhVk1pHhzPm4rUk9zoTwF4rvvgEHim?=
 =?us-ascii?Q?bA/zA1T6ONPt23Pd+vGTRJMpBj2eBXi1LWTkmQTdzWUYh4IIIkRpM2+tOc7Y?=
 =?us-ascii?Q?RY7Wit+BnD90kXY7BXU7ixqiTXwAIVJHAHUmPBbwLBlEjik37IZNi0XVGd2X?=
 =?us-ascii?Q?DtjZuidQgJ0M0ogZWfLCRymAbG+7ltLHYbLSKoEK70o1c2ASYvKyOPTV81Fl?=
 =?us-ascii?Q?WfF7X5Sc7GT2v3LKUfaeTLXzM3I3T/C+NUQ56Po5MqD/HqmrBjUsL3GQp/t/?=
 =?us-ascii?Q?YDBvB3eMNRVhFmXS2e8I5siBrgCmum/Hp70L3W276SD2C36Vd5Os+7hqL2TZ?=
 =?us-ascii?Q?Eeu0iBLFEvmObcgO/ET721CbDdVUi4OCKpaclPEiAFGTsCDrWGCOJkyMwRTB?=
 =?us-ascii?Q?cGzscBmNd/B99dCNeVpXgFpfE4H7sfPo1f5pevT3OO1rZCiEmRFnbmhY63IX?=
 =?us-ascii?Q?3pR5vXNEPggstQYU7Kb1ZZ9jeBRGP3xRtxBB9JjJuPhrzxsacXlpAR3SqM3z?=
 =?us-ascii?Q?zyW7FLaodOUP6LDpsfBtVRoqaO6IUQsJbsHQebidh1lSQyRwyKD8V/8DKjq7?=
 =?us-ascii?Q?TLF39LgZfadl0SVqzQx4NfvIAFn9JcyUjjF41utG8S1qG4Vr1NjFaXyyX+DT?=
 =?us-ascii?Q?5O/IiY16XwOdsx2ovwKbMIemHd43XhPTY34ggMJ4NXadPmu+Nl/fVuMxVvCr?=
 =?us-ascii?Q?58wX/6JBpYf6vZq8PeT22wXP3nWfJMJsEke8NCGjRhU3w6rjmg5/j0UVOzEW?=
 =?us-ascii?Q?lUt2PdK49kLe3+EH6YUKiBnsuIUKBQ6ZUDY25E7vK4jR9z4NhVHycR4gLa/M?=
 =?us-ascii?Q?XsXJolsCptSlBaN9w3OM4OZEtF1lBnSGFPcuYGKFPDJzzUDniNZZAKP1rWle?=
 =?us-ascii?Q?SAoKEFqpUIMWfpm6EDYFbxKJT2ZY7bomIkIawC/cX1p2kjz7yxstm4QVugKX?=
 =?us-ascii?Q?So7KDJSJedQ48I4IkKi4rbAc7shn1KSzzr2l9mZ+IlOIqaTI0Hg2GlG0ag25?=
 =?us-ascii?Q?zjB9IG1xWvzw5b4qr0BKgtxOAGsFf0MRBAH6YBGy5VPulI4AO54wB6LZE6Em?=
 =?us-ascii?Q?RL9fqj702+bTfdM7Fd+EbrEufX+U7AA2+Trk9wP4KLMtQqYMI38SXOC0kX4i?=
 =?us-ascii?Q?LRcSxKMEHjGaVSu6+ixSus2jRRFzOL+sUd6v+kwU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0172429d-a584-41cb-8312-08ddc3a388b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:49.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6khtDYeoKv3HhG8AgzmXZPFcYSJSnvLLcqFQTlAwq3USG586fFOHxqetjiYZU00nSWxK72cEGJOve4cK8udUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..41ab7d1f9c0e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -120,6 +120,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


