Return-Path: <netdev+bounces-256852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEQTFO3Kg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D629AED083
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C978301A523
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E15393DD2;
	Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f6dkWxpo"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A7389452
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244823; cv=fail; b=q0UXCmzAcDfBRiWwNTGAJ7h0rGQ/YZzLCvl7HX++IeqmEnVAtTFjaJOR3yRCYlkurjJFF1oYje1nD/rI9DCwxSlSBZ2tfHSn6WcM7qbjWRjRb/c7SFMmNyNRUhSf//UPbmBp9nBrDIIQobOR+7DFSme0d4QO2Fm4yGo1U5NgoiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244823; c=relaxed/simple;
	bh=+FrtVUTG0x9V1qUKjOjs4LeMxY7QGdychtyxzWqzKEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGqjZKOTf9rsgUBOzqPEjuKDMdNj7SHVFBmf6vn9fcx5hawyerbPK2t8g8GDYSiwKnz6zfR0yr7cEaIb88t2XfJ8hKdtTXtMuymJWliS/meWbJ73klGdXQuHIu6jeYFpkVwyDNRhvHKRYv8a+7ZlzsTA6nw+MWLkf9yojzpwG5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f6dkWxpo; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXjmyYUhgqkUPrNf0fKS7E4qi3S6XZ8CqGzGWuARuc0CW+jMctaHH3OZR2IqmVmbIS/ROt0pbYAhsbar7fB5cCn5Mn0KYECsq21DH3r7tUPv1BswKt9iiDFLVQCkUKv42ecIY0IDXduJ4XQE3Ef9MKwIrdOPfba2gnq4U79TwRR2yLg3ShVirrdrzwlN0ZFZBi3CjbVH19ko1S+WMtUnJD79sRRcUwovyt8uq5GbipfAdY/E2HUtHqu/UQ48RQMUnkPF03GDU1xhcQBxbfv9rSkpMlCZ1Wsw0nvf1vugULuin8pKVQd3Gh+LHi+Tdu8LN1NlIRzqVSzV33TYb2/b+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=AOL40kL3WUeOmJ545Tgs3v4ReCFJsTUUxSVPhhILW+Wqd28k3YxXf+Qntm7JHfDZ6gt2Gp184d68Aq66yyIn0Sk53yyE47ZUu8CLy/C4svSM3UUdececBEMy5FH6cAk1p9XRcLKwF1KTnyZ05z9Rx7OAaytSfcXU2duylGZjvyYSiYC3iLo+bGc7DC9LxhaVRHX7nr/avC2+8YhXXnkWYeaR7sU+g5N9pMWfOdmin8HTjioOUdFYQVzSYAY7dWoTun5vBj+CHl4aWW0riMa6IujzPS+2qbanE7WpmRF1s2c+oTkClkKrjGShTpFqoUxHBk4t8+7anQqmp1/RbZoSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=f6dkWxpoHCaC4cnJqCjKUd/14QI+D6/5/MD+n+eZ7ftPgegWwUqKdsAtCIP9t1qkqQDN4em/zkJYhKCFoMiWTkFEMktZAyWy9vcfNUvvjYVvJLn+IM7qcrxzmx3tEfE1e5hw3iUM6tWhqSZEKI1maR0D2pd2N2r3KlwbYhZ3qKV5sxlAzbnur6KAERpgb6gEisYcylE90Sc8uf8uY5L6AaOwDuO3dyGr77+xEIP0fnxMxXpkf0BDMSUunKJijJaZyOR92VGoBbj8YGGGtF1d9TBE4J5k70NN358+OwG5cSnf0DNO7MRpWwNyBLjeEv7xeNLsAHwmzMMoYztnKHJE9w==
Received: from CH0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:610:e7::31)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:40:14 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::b0) by CH0PR03CA0236.outlook.office365.com
 (2603:10b6:610:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend
 Transport; Wed, 4 Feb 2026 22:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:58 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:57 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 4 Feb 2026 16:39:36 -0600
Message-ID: <20260204223940.39581-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260204223940.39581-1-danielj@nvidia.com>
References: <20260204223940.39581-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: f030b36c-54a2-47f4-b68d-08de643e5d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pRogT4q/l21+1GG5dLbcn9WZ0tuV+ajQEIJlWb4azjHeek4frl/ALzOgl9ZZ?=
 =?us-ascii?Q?1PAViGjYCAsIfcMoeXx6ioO/dc4fekftcTYslbt4T2Suu4tRyniZVSWoPf51?=
 =?us-ascii?Q?EB3atLrjEda5tBqHkpwEi7Obv+OKOG66GymwwPzAnaQ43/k37uUX3CoYnVJp?=
 =?us-ascii?Q?VGnfvJkleY6QytzutD1HscIp4Vpdy3EpQS8qTSPzl7QSwkOcsS6Rwphojw0P?=
 =?us-ascii?Q?5WsrL08Yi4C9x49yuYjitLQ7DANjKdc7JCnR1NORjMtf096lbtRAH1PHoMbs?=
 =?us-ascii?Q?pXhBRjDuAk8D0VkEexuT5wI4QsuIytk5I9IMCp6qV3y4CsD8uzapOxPxBL9y?=
 =?us-ascii?Q?NBJpwO6zG9KnjzQojyw6s9kXG/pRDou3yfzJOCV8pH4X8dvmYvCfzFBSizPc?=
 =?us-ascii?Q?daPe3kRr0JnGCCfMYwt+yM37Ml0P5UTiee1MEuqgNutPULPZ7T9kCq0DalXF?=
 =?us-ascii?Q?NKLtQziJWGeAEmjra1sLXhmfjqY/nY66C+d47eqw3nigt9mO3rV7N4chCLzB?=
 =?us-ascii?Q?maCPs3k6Ej1TDFkEXKaxmayCTiCI4odsRh9epw0Qv3ggh5CXx026ezVGFm26?=
 =?us-ascii?Q?sqD/rax2c8AxE6OQLLHw82caIiEcbBgSWnkFzkv/dPYHVkGs/cxct9K9AP9X?=
 =?us-ascii?Q?NjMwSNRlx0QRxbu0Qsk98kr8cnsM6/X2KOfed6z7/s7DX7jILemgs3i+XS/R?=
 =?us-ascii?Q?nD70r6i9GQ7p0xE7ngrDO4gdois6K1NEXobewLgfuIUsudox5hR72h9z9ThF?=
 =?us-ascii?Q?wWlqNw/SgkEdmdWp72HMpg4keGkd8jM5T51ILct92LZi4ytq07OztOUNkaxM?=
 =?us-ascii?Q?ZD6+5KgxXDsETy5mN86Ym5QJybK8J+aVfVT4VMZsYXbUsenI+tSLJ9tBLU9C?=
 =?us-ascii?Q?eFrs9ec0dhsgITN5fFIRPyWQRFrQOYLODi2y/gxOll4QxvVv1tWx9DvOnZUl?=
 =?us-ascii?Q?6xQxpKBzBR3/uPaJgl37/pRD6eKO+ZDgEHP0aWu4OtMpTWOsZ+vUMrC5q5JK?=
 =?us-ascii?Q?xeVAl1Np+TFozaMkpa44VlONMICku2oS5dGUY7KNXzavWzN0yFDJuW2iQRrV?=
 =?us-ascii?Q?Hxb9V4YOKgG/RM3o8nOVaB+BxXgDPF1R27Ib9dpgsvm20oDK/sM/tgOSKden?=
 =?us-ascii?Q?dTbiHSEledDcXXpI0AxeZvpAnFIwlIRIGEjGFGdo+T3/O0q95jDpXjpvsKCP?=
 =?us-ascii?Q?AVkEI6LL/UxhPqiLgz2IS8xB7iNlaZLxWvlvY0zYcdVbsBeYqksh1DK+Q5dn?=
 =?us-ascii?Q?6LSlC4GnJszJ4FDTFCN2p0af6u4K7n6S/K/pP/mfGCQ964xZU8tvG5fMf0ke?=
 =?us-ascii?Q?m1PIz4I9EMmo9hfNGQwNnEXlj/OdD9VnFIby+BKT2bzHVOdHVe0xaPX3UdFT?=
 =?us-ascii?Q?QYT5j7xZEVqRQH44WE7rambQWd1RUaOoRZYrQpTyd1I0NJdmhjoXGgws+9rY?=
 =?us-ascii?Q?T8s1fQ380bbJRVAjmejJ44MAQlbB00tiSGsQGzE4r6p+gUCl5r38m+QA58SU?=
 =?us-ascii?Q?i95dhdyvSJ6CxOvv8Mz0a93i8RVufQgYF2Ishgm5Tiq3KpIiBa1jne7AKDHK?=
 =?us-ascii?Q?e154/pC8jGj+Ckjzd+HFtayfxfEQmnkhJd3NZrpw3syn05XvDsR+8I6Vaoxp?=
 =?us-ascii?Q?N0gPn+MJgT8uVQCYEfGdk/BwQVt/s6sfjrzf9eNAEKog8Oa8LxfHzVAg/mXg?=
 =?us-ascii?Q?/sUjQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XT6s1be1Q3EXu3yBARePTGX9RfZ22pI2M1xH5rSQAlx7u6mgCdKZWNm/FDfUga9LKqc46rhAeDarxgkRF8LagG8uqDWIekClbPDvTiPhu0wNw3eft/sFvLErH0Mye2z/6hiFM9gPcts7QoyZt7NI+CchS9CZ4HtoShnvqP4W0Bixje202UPVE+0k4xlyAQM7N8vZYs6i11ZKQUwtqhPw6p05vkCo1FLM9INBEcMgqrDuTI1+XzW6dZv1oU+F620VNMgsdUufcmCS8tacxFu0PKEM4noulo8RTCeXzdO+Xo7pupZKH17q1AgXsAynZU+zKvf70hlViGRtZpYmML5WcvyYjJsbkTueLf4ys/D6ar8BxYuaLNDlxI7a6N7UF6Ud7qxvmIgiH/N+KjaooxzaSeP1+sthaGIwn2/yHCRfvAPuy5Fdnan2fwmFx64FttHi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:14.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f030b36c-54a2-47f4-b68d-08de643e5d00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256852-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D629AED083
X-Rspamd-Action: no action

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (

v8:
    - Removed unused num_classifiers. Jason Wang

v12:
    - Clarified comment about destroy_classifier freeing. MST
    - Renamed the classifier field of virtnet_classifier to obj. MST
    - Explained why in commit message. MST

v13:
    - Fixed comment about try_destroy_classifier. MST
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 27833ba1abee..5cbf26d8f7ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -302,7 +303,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5740,12 +5740,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5833,11 +5834,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5845,29 +5859,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5891,7 +5906,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6063,7 +6078,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6073,14 +6088,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_classifier;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


