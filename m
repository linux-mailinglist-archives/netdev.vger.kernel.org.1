Return-Path: <netdev+bounces-216953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4AB366AC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB1F1BC7235
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853C34F475;
	Tue, 26 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qlxnk9bZ"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012051.outbound.protection.outlook.com [52.101.126.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13C352062;
	Tue, 26 Aug 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216239; cv=fail; b=R6lwuEltWw/ImS6ZIoE8NPna9e4yj7vLApiBscEpvunEAsw5iuCs31Aa4uzoLG2pHG7hHqYNDyz6e1MFFZEhLO5UJwtHAxRsMeF35/GeHaV2f+kBBbXKGEN3FZ8R6aPhEpy5wUV8CUZWRs5U9E5/IIYQF386FPpqcODPDJRNtaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216239; c=relaxed/simple;
	bh=Xap6ZkO+PAYAoUYT1Z/odoDayKvHXk1brRuvVoDCGxM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SyFQ5yoJ233XMsMG6qtY5LzLqrb/3BjhIPaeglk9+imhDJogxoHa4aEmrLuAIPUqk3ta50O/6eb2d8OYjvObEmLyMeM2h1TCpc3D2srHE5/iO2tmoBDQOloZireAwTXmEu2zYiYFZ2YV6d8zuPGXBOZ+E75M3otXE8ij2+In1Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qlxnk9bZ; arc=fail smtp.client-ip=52.101.126.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XseeUrNV5yTledHZixJwQtU8sogXGeEn/u/K32maPWorkj3gxY0AzY2QaBOzpfsBCZMqGKn6f2rSbOekdFaZNpJrK7hjuz1zXQ4l+WLRttB1nHBxY3C98a3OJt6l6BWpd1lMfB4Im0xq4KLEdpDt9Dm2DbTOnhtNJeVSpk1smoUzO7mMASjUR05npYqnCKLFloJwMyH7sYhu1yms/8/t9eIbORjmp5PWE5muOyGdz40/ix5sOTdF28JGyC3CBqrX95pMi5MVLbBO6zxGf922PwmPjH5qn9Krn/UQBWOdedFhkbnz36OG/zgmwuxQflscb2bUyuJNAKWWDifKSnmMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSOjqjfbaLteGqKlzeGrmQ1WToMl3vfVb3eSWYBhNp0=;
 b=wGjNlYU4WwyM74SfhD89Akyabbm6AYL2Tmakz36/oQzyy50LTn7+3Ph83cOZA6t4XNfY2U2Ytp73FvWAOYfnP5z1rJhO0/IiVCyKZxqLCRHx2lGaBzqObHySdIOCPLQlps5YEOWs1t+qXVNK2Yi4L5k0eUNgH2fa4EQJxSZ1ajScN374ABLmsBVUExRTHL3uef4kpu0l2inR3Oc0neMHWl4guQ/fFr0o6YWKubjsCd6xVKO1mZzIZkno7v3CMJjwX9A9a+3I6u5nOodkUErseNx0lmpUvshiegtxjQnYH7ruRTxvpxmMnQf1oiB+Ysst29ykeAcQAwh++b/i7yW+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSOjqjfbaLteGqKlzeGrmQ1WToMl3vfVb3eSWYBhNp0=;
 b=qlxnk9bZCsoWId8yt71ZY2k5l6oatbzeiWT4rH6clN2UQ1LCUMWcc9vsVIQLhE/DON+LkKkDiCCOBkjnCMQdAvxmZYr7lIZOYbA6kK5y7P/9RqYC5TofzURHrfms74cuDyJEif/VJu8qwIqLlz8bSF9tYiMCpCu0cv/7C4skelUjl/M3DZ6X0fCd8PnnOPn/ZVeJ1Cp6YCUV1eYOhKOB3ESSgOJj0wr16GSwvOC5X9NJ72EkZonYVdoFuFau/3IkhkSd9FlwYVhGQDq8B7Ji6f6o56j/h1SzIdqqYMIMC/L2E1X6JUrJUEFZtCt8Ep/4wAMP31qCPCfzQoruJ8+b0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9)
 by SEYPR06MB5914.apcprd06.prod.outlook.com (2603:1096:101:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:50:32 +0000
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84]) by TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:50:32 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] net: wwan: iosm: use int type to store negative error codes
Date: Tue, 26 Aug 2025 21:50:19 +0800
Message-Id: <20250826135021.510767-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::29) To TY0PR06MB5128.apcprd06.prod.outlook.com
 (2603:1096:400:1b3::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5128:EE_|SEYPR06MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d4be481c-c5a2-41b9-a60b-08dde4a78650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UI3tGZOZ7BxYSijlaHIevUfhgdQtQRne5urRaaCZLhdoIZRNIZVvqv64Dpa6?=
 =?us-ascii?Q?i36apqonUbenZzkdYYcGcdjrJ6z79dE80TJ1B4yO1WzH7qAKgLz299bhOTwp?=
 =?us-ascii?Q?WUR7wEudzskR0JZgUVuj1P0Dv47OL7oM6lTqZ2bYyGULYDKDqL3Jo0uh5kRb?=
 =?us-ascii?Q?tD3JJ+/OQstWZB0Gvvq0I5y0/LQUsRVKZGpE2fMQhVZC37DCCZdK30Zq2rCk?=
 =?us-ascii?Q?CqxswGDr0AJzA+BSwuA1ab9ixrIFVxM1MGDrnUr0TWJU8vEi2tEqCVB18WSd?=
 =?us-ascii?Q?wSKfT3z0jf8LG+vxDeGpUi1QwdX4aQ+LKj5FPTLhliQNnnkUhlxnw3eyd3tE?=
 =?us-ascii?Q?P9PcWqnuouNYyCEqYUSrvxhQRxoKBPBq9CJxhdfVDWaI8soGnxlXORKgo1ST?=
 =?us-ascii?Q?ld/hHirm6GRMSyjhsmbevbq9WIz9Jzn9DJPaEksO6AXHyAXwicQLqgpRJAxr?=
 =?us-ascii?Q?K5UQJa04gPmuiSHlycj13+l0tAt7YuodAYMRZxRNDkDnQFslMOUO30H7B/Fm?=
 =?us-ascii?Q?KabqxGtQLj6TAYVWTB+WHPi1prQLBoz728YROeNtLry/6tIbtCnR73p0ufzq?=
 =?us-ascii?Q?qMzce6ICr163/tFyPzKygY00ahRWt8XSdeTvJUIJrJsT8+LObVyZTkX5R2ry?=
 =?us-ascii?Q?3/PvlSJe88+8juDzXNxiTCwHMTd6Ej3H4/jDaS25gzk5EO2hzJjfZkRY3Lwl?=
 =?us-ascii?Q?l8XsemSvr6fd+3BtH9tUX3OO3JDIaAH5tACzUO2n5P0y7RxFTIcnmAzSHrdj?=
 =?us-ascii?Q?WAsR0cPgkjYLQMDW5TZ9gNlDaRqQwowVVLEa/tYK8hN+fu/BbtTMCkWpO4/Q?=
 =?us-ascii?Q?T0U9SSo/8ytnnIEIYdbM8SyoHbGNNvgOB3n/ab/XM9zo0Rv2egLMvmzhqZqH?=
 =?us-ascii?Q?q63rtHl83XTMspxkrU4+yjEKDrbge3/nCeo26WePrtu6ha9c+lgLzMqqtJpl?=
 =?us-ascii?Q?xFgmiClvAYjQ4OJUr2aeGk3KQj9Tx18lfcTA3PbL2PqJkpUWvG9jhnkcTBGW?=
 =?us-ascii?Q?rRpWX2wlp+ZsX9UIfnMy173DfDDGM/KdMiDUeuY9EDrgVvhQeQP0Ms+ShTpW?=
 =?us-ascii?Q?THKi3FvME9e8FZRaXgWgxhrmXI5uWE6LOedF8GXk/E48CcuGRxc+YHseaE6x?=
 =?us-ascii?Q?n+iVCopT5C+vG4Ptv445XB/yEZF1+wTX8yeJiVC3IdGlW0xix00ySAFmCmFT?=
 =?us-ascii?Q?haDG1MRBBSOZWKNUQAZ10xe5S58NGgFgMjVy2MYh/e4Qmm4DZwmrzPodV/PC?=
 =?us-ascii?Q?CWe7VRj3Jixi17GOwNfCxpJDMhNErfKFF9DqxZ+LZq1ESDMQois5kioDVay9?=
 =?us-ascii?Q?jcSCJ3AKTJPoW/QbF8hj5zS2MMOQTen0M0e7sSA9xagWIV2aNHYbWOZsk3rR?=
 =?us-ascii?Q?ig42CiET6xdzyuz/HmwcdDac4lno9ka0xYG9eJ6nA7BbM0dMjqWjHcU/xGgx?=
 =?us-ascii?Q?rfFubkecGM9Q7ZGrvTks+ttpV5yUGLGya6V3DxUpnWRjH1f5jmFaDp7AdMB/?=
 =?us-ascii?Q?gt6TYH8NqFBIlMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Oz+sTKZnZdSWbXKs6/VCon8eqp7nwz+88/liRbYpfjfrkCJzpORXqHEmKaA?=
 =?us-ascii?Q?G5M0jP5GfKZ1zVGNVqct1VdhRmt7rlkkB+UySL0LwUzKAt8o7uy/LoO+S07v?=
 =?us-ascii?Q?qHSkkgNLnrlTEWa+vHkPMDlER4kXAnF7uxLo2CQLDXqvEo6uJEjIqYgBSmuO?=
 =?us-ascii?Q?p6MPm5E8MQE1boWjxiD9dqnS8Y364Wk1PXCV7jMh6cKDBs2joo1hGq/0V1ov?=
 =?us-ascii?Q?UBmzGhhmEry4fnZOvLTr0GLMbycQxBxtQ3gcRNlwQtxTPce6ulka7EkadwNC?=
 =?us-ascii?Q?oiRQqu0CohNaROORQSVU/geNh45ktjuQ5Vth4aP4CKoPLyrosowceMk+QGBr?=
 =?us-ascii?Q?vUVOfGNzAcVUju+kn2DAUI52hHP9RLRX1xjPqCK/4nxU2UUvjnINyrKiL+jX?=
 =?us-ascii?Q?JUKdD1lVn4thYLaf156mpWkiTuuNZakgY6W6rk+pEySw+oVxttSDQ+3UX6j6?=
 =?us-ascii?Q?uswY/X30Rw/fY20PX7TgGCwzAW6rtEmuhtR3tQsKdL0+tXcYDCZmj0kbGtGl?=
 =?us-ascii?Q?rnd+BKJiSQGwRLDeZYiZeLWXu2rkxzaVXllqWoB9IfUpTZy3PDxqiNUUxZ5R?=
 =?us-ascii?Q?d14X2+EHDc4cIEuvYA2AOjvSJZkYKJJVDa+8ATafhuigo4zKV50qXloP13fr?=
 =?us-ascii?Q?OKIHb1sjImBhwR5QazGeBpnYMHYcQuzc5+wsT+7Akxf9TIYOzZEjvwE/c+xP?=
 =?us-ascii?Q?QdR+eJRsI9hj5esDyo9VGF/fyzbjBIEMwFvBotXL5FX0Um0ztjC0tEqybXEN?=
 =?us-ascii?Q?c3dXnkiBhKAhSG5tr4vNIm0YMeqxfFN70nGGprV5jOgvhq8kpuMLwAt40PZB?=
 =?us-ascii?Q?hCFhQXDPPVKfldNZTPWv2ka3J4JUX0BsE5JhBk11ACawhXzw224Os+UjvpOO?=
 =?us-ascii?Q?3E98qmx5tDyV9OiE3xlrFWMMJKn3AXTqbEJG96PEGuZUXkjwb4TXOMHtsGkU?=
 =?us-ascii?Q?rU2n6TKLN0TQhUMBFNw6MOengZ8VFim4IaC1+3Js1d2J09vPhActs9oHh6cz?=
 =?us-ascii?Q?2HYh7sEjPdR9in15BiDCoAGtAkglE3atYAgeIqZOH2r/O3o+00CYPRT7FTM/?=
 =?us-ascii?Q?laP6ffYBrKxH8KX/w0v0nulC3A49F/wOvqBp+nwi+/4zSXABU7PnKl+Ywvau?=
 =?us-ascii?Q?5RdKs8enYRBQurw7Is6PXstR0LKV0GAQ24Lt6zDTd9onvg0r83M08L/0fg/O?=
 =?us-ascii?Q?qFFqjzBsgzbwOJN1Jm5fguMpbDafb1wxyS9GivVvJ9mVdq2GxKiCmhF3trWt?=
 =?us-ascii?Q?DtnhX+yMuThrs2xAHDMdq90JtFgVG4iSoKsuIsTHciuW1Pt2KyEJPwvE2nz1?=
 =?us-ascii?Q?ZWOvDYKbt1XSCFqe3rXN0LYKfc3h9JvUlv+kwAP/X9MFnKnoPfR/UYwO6w9X?=
 =?us-ascii?Q?NysBDJBmPepBugrdGGZil+Wxcc7nuekaySYJXsBeqDKPxKytA8DR7skMT5aW?=
 =?us-ascii?Q?CuzVk59pPwTeSmXSUba/TTm+I9KFit0/g+lGkXwo/D2kPE1XtcJGZcq7WcrF?=
 =?us-ascii?Q?Z2ld+U1bST6D61nNE9AIlntCoVVb+zLCe33XbC1JU/s2fmIwC3y8fN0CiPyY?=
 =?us-ascii?Q?p42EWP7+aKcPBaL0KBY7wEZil+WupL54AQpJFC9b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4be481c-c5a2-41b9-a60b-08dde4a78650
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:50:32.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpBXyEkQLQdVKxnwTMXZ66tfI+lh2SdpV+iU2RivZpHhKS3+UTRi78/8cBZmrGCDy2pbGz7CNTJj93YVrCfOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5914

The 'ret' variable in ipc_pcie_resources_request() either stores '-EBUSY'
directly or holds returns from pci_request_regions() and ipc_acquire_irq().
Storing negative error codes in u32 causes no runtime issues but is
stylistically inconsistent and very ugly.  Change 'ret' from u32 to int
type - this has no runtime impact.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index a066977af0be..08ff0d6ccfab 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -69,7 +69,7 @@ static int ipc_pcie_resources_request(struct iosm_pcie *ipc_pcie)
 {
 	struct pci_dev *pci = ipc_pcie->pci;
 	u32 cap = 0;
-	u32 ret;
+	int ret;
 
 	/* Reserved PCI I/O and memory resources.
 	 * Mark all PCI regions associated with PCI device pci as
-- 
2.34.1


