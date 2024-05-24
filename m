Return-Path: <netdev+bounces-97919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FAF8CE084
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 07:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65D8B21BC9
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484C383B0;
	Fri, 24 May 2024 05:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DB2E631;
	Fri, 24 May 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716527170; cv=fail; b=IF7dL66DI8T2P7a9MWMGf3M/4ID+4oabWYFfQI3GuVTDLE/z+77KJ1OwczTnqguCC8VH8Q2P6bTgyOFlYuUP/MT7WfE5ZH3c7Q5ZBCnY568XJXdKM4z0kpgn5mfWHs8bTTk0eP2jZvFecs3X3wqQKmQ4y79/nA+18mUv+TpQHFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716527170; c=relaxed/simple;
	bh=lZIESxlLImVSwzoOmTFNc+W7/Z0H1z00PXF97ToKqzc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IFrHTYNsy+Cvv4cMtfEOHv9TqcqLOBYUjluIbci5Ro4uiBD45C3CeXHSN5oJISMkCxN2iS56YiAu0/mskx4bQLggkhXRgyRp+DpHeVutl9nSnOX4O+G9n4tMQ8EOC69qaKqKWQY6zJ11Yc4MAba+UDiIBD0iHDCeuWuiMqB8r00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O4i780001342;
	Fri, 24 May 2024 05:05:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yaa9j0f9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 05:05:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmgsABLks8/RSwnftZQxAyhblbZXBQ0gDMSI3EbBkYbK/Vwby1wsQMS6m2Cnh0hY+CFTAedbpCtVBtRpik5WRtgZ+Ycbfhah+Rj8Ke7hKkmbvCED67SaLhxwqaRgbpMtAbxtfmCpdx53QKOngtERktz+VkBMxGeKBhPk2VHdtbwecZ/p1jj0A22C38Msb0vWupWQDVnY3uXWEF8Nu5ex+mg5jkN+5NTjTD540aj/u8ae1lH1rqKyACe8gGRB+WwbZ+/xkLmN7AHWOxsl27QST3s6GEwp05Nyxg4jrrGi2Npsy4kfWphwtjcIr7AYnj6ke4tMxPZN0h8pnHoP4IVTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqqWGmYQAUc/F8tkjCaGn/buIEAuX36hZkTDykdaGQY=;
 b=erRqDNRoVqF1exV0JLvZ9a+KQfDHJGaptDWwz5wH9ItZ9CByoGWlC3ocBnaDMheEZcpMeuJP65omPlhYjRLWv7S8rxPVzipbkRNJ4DXE384ZomL2GRlqEDq9/VQWOPHQm5NuT7+eGTvAyVIYIHbH+L6s4ahn3j0fPW9ut75ypg3pyQQ7wGBNfNQrUx2jUYa8sPFr3FK5egVJvHM2N1yrNEezQ3ijyotbEmZNa86uQ0lDMSIMmvTzo02CnaWUYtSpQOrNiwT9HcWTMe6tn28/8VwvKVXTjXeTuCnpawkwbU7qLsA9T+Qmqj5bfQj+Y3RmzJzDxcyE+LJ1LuqNilLb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 05:05:46 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 05:05:46 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: wei.fang@nxp.com, andrew@lunn.ch, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net v3 PATCH] net:fec: Add fec_enet_deinit()
Date: Fri, 24 May 2024 13:05:28 +0800
Message-Id: <20240524050528.4115581-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: f84406a1-bf11-4af6-2a0e-08dc7baf2b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?esehY2ZYsAdbWTlhYnPL8XRm876c8oFeU+DFd02FjhrJ3i14QReBACyF0o0s?=
 =?us-ascii?Q?S/SwzW1/n+YGrKVWvtYBzhVYDwB7Kg+uw6KX/goa21vM8UEKnRCivBjfEwbA?=
 =?us-ascii?Q?dakV2iUENofe2ta4zPclvcINGCzGV0js5Ch8TYvZre0bUULyZJLsgofgWNJC?=
 =?us-ascii?Q?MbsF/cDcVparnYOdd2rwq+BLt11uPpgCogzt0drZNgd5yqlGbv8uk0vSmNNh?=
 =?us-ascii?Q?+bQJnBhHBX1GhGTLoEJRIBFhddJJihl/s3lkbuoNUTmhDC9I+MgGFfzpA3Zx?=
 =?us-ascii?Q?ewRODbwSTRzWkMy7Wu00JR39t80G0s1qL0O66OuqsweQU9FkiUaDFUU7dbz2?=
 =?us-ascii?Q?3MsKEBVVm0ls4ecKrHT6j8XkkjFGbq+N5croZlo9VG9jtCNemmX/Qj6as5FC?=
 =?us-ascii?Q?x2+QfB4cyTeq6pRrLYWUF3fwj5dH19lKMnDqG44JDrmncEnq2nBJ1j7DryIq?=
 =?us-ascii?Q?e49rGJBDHmG2F5jB5yDBpZfhAQ/U0NvSWyCdFPvLsagUmkBooFUolX5OqqXL?=
 =?us-ascii?Q?y3qhiR+Ber7lg/o8ntdug/3YeHn5O9HUdTxsSEogleRTwc7hwEdoWQvwnHSb?=
 =?us-ascii?Q?vK2arRn0o2pzktdcyACQA8QTVktV3hOA7GDLEGpu/6Qm+d40zwk0UzDNzXct?=
 =?us-ascii?Q?6V8fyGCkrYL/F+nJqdPtYXVh1+K1Nb0LDWjlrLJuOBHASEWD5yCU+MTdrZIW?=
 =?us-ascii?Q?dW/y1Lncnq2DWApgGFYHlwTVvInxCSYXkxnupHEfDn5M9UllkVb8j1lLlD44?=
 =?us-ascii?Q?BIHvsARoplN3Ck4zMFnh8I3I3fLZavChrMxHq3y3HilUQ6h3fLvLL2kMIIGV?=
 =?us-ascii?Q?VJyXAwNQDraFgqaoM7le6rDUnMwwc9q8t2MWNAlgvdahOAkYbiqKxGP9FSlm?=
 =?us-ascii?Q?8/cwisvl9Y/kB+K5/SJ0PbCBfuTYURvLyRFmV7qoC0cOywnTPZrazMuIyBvv?=
 =?us-ascii?Q?j3xQGZJOXojPb32GBlbP/gimbjTypUnlXQnzIxnVF1qX4GfkM3oXRjg3Hkmw?=
 =?us-ascii?Q?YuFe6Ln6WNjdM9cby1UtY1MLzz6OfP+jYMHBi3FvRQfe5N6/jsoX8i2ZC7AD?=
 =?us-ascii?Q?yhULTjT3DErsqlhWucdgowW4EIGAwC7ERUeAcq9lRYtHYvCRTtfI9WAy2ybg?=
 =?us-ascii?Q?CzIq9EAt2A+ndy6mGt+T0lcB1TLXm4RneU9vNUcEZtbl4Kyv94GOj8fuxAXg?=
 =?us-ascii?Q?sltw7EH6TQN/LwwTGyyqBr9G6DBHuja37P9KhbrfPeU1gyOfZRgozFNZ14Ty?=
 =?us-ascii?Q?2ExhB07UltESwNJuNzK/G3GF7odSyS++/1voJpkWFSbhrKo8ERZGnAfmnhQg?=
 =?us-ascii?Q?PEsgDi8LpW28YSAYXFmj5LNP63YclmbtsqxmYsOzvcIBVg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yNgAafwAg5CuadmTwnnjDnGTQM6zkImTgYnaIVTg/YB2ab0ACJANdCg9w4NV?=
 =?us-ascii?Q?CqpcmljKWmPw8IiWvTFyvfu3klSWk6gwcCNo4kjBdS6LykPm9hfeWfiH1VZp?=
 =?us-ascii?Q?qLu5jarM543aQ1uyJRfNxO8+FkXCbGti4J7nPmu5tfNeYtzAtgGUay21dycK?=
 =?us-ascii?Q?yuz5JJBZMXonIoxt7iZiPS+tUQOk1fu80/qQlHwVCzUX+fPL9cKdt2FWQNaM?=
 =?us-ascii?Q?xl34d/1lt/BPIVFIstuie4NF4wHqLq1PPogV5T2l4/n3TeGGAK6xE7e3qmLW?=
 =?us-ascii?Q?+w/lArARPlp6HntJ0EAQ5kYJZOwldXlv9U/EfOJoJfOjanx9XgKvFFBOPtWo?=
 =?us-ascii?Q?9oVMqi5+NOa67A8c6Z7W8esGclbGHBaBWBSOIevUP+JXMhzDw5LN1O7NPJWW?=
 =?us-ascii?Q?MEqfEZ3yKK+49HhRAOPNNVtt3MJ4aV5ctarafghUMF8M8s1VDKH/7aScX5tA?=
 =?us-ascii?Q?oa6Yj5N3MAha4pLmY52OYUk/bSTri6VINzbG7ez8Jf5pXqZVLVTL9TwPfvaU?=
 =?us-ascii?Q?H605n6w4OQer4WwNEUaVeB8XOs40JwHg+IATp3vdeGdjQ/ALYW8qNg6Y/5kn?=
 =?us-ascii?Q?UPjXocxUi6Clhc9MgLegcgfRK0eEieKEnSNcSGIo40fjZshd4zvumY0NsDeN?=
 =?us-ascii?Q?uIz4qTsGsciGfYdNc8b9S8jHbSetbntw1hjIbyHoKcqGg+L2TQaE8xeO15Ml?=
 =?us-ascii?Q?OMOalz3jZMsKogEbbsksftstU9EkhXTwNdzAMRQniVME2sRAzpqoSr6EDIGC?=
 =?us-ascii?Q?p0j1BDuuyADkWrytyAxp/4t9tAq5eP54leMJoFTzV/ZHZd95w1Nx0PeTBq09?=
 =?us-ascii?Q?f5+UYM5marsfIXTjyWo+i8ahep9F9IhsUgv1PojNIhh5pd+Qy+aDW3aND3qW?=
 =?us-ascii?Q?IrqDRDmL/PQaQ5lt2KB3V9AuqAfEK56JTBKDEnYXA5c9T3Hy9ujaf4iM2N1Z?=
 =?us-ascii?Q?/63v8G+Ezbq5TF6fxNmu3rrK5vSGnB0+Xa55sh9iYAyMbhDQGyZe3zNg35AD?=
 =?us-ascii?Q?FR9rysshV+USKX1kRzS49EwMRGMcgL/RwxTFibqnO1JQljFFmsAkYfgXQfB/?=
 =?us-ascii?Q?TNqRRacwhgJn85dlTz2pR3BI4ficxFy/L1O0+24EqLi5IVcqEnIqpPcW5RWC?=
 =?us-ascii?Q?qOn9eYHJDnCPwu3LcuEQ0M7P6rwSNWUEbXNVJSqpin1lVH4KHJT7dSJ58/dm?=
 =?us-ascii?Q?hM+ZkEvrigxZj1JU4WGp4OtH3MZ1kVXo17FLdht2lFOuqab976Pt4piRIclb?=
 =?us-ascii?Q?4MAB/9cLj8oVi2jVzvPyy/Si8dSqDllSxeUCkHQu4/0tBNgxsNVRRoqvefWE?=
 =?us-ascii?Q?IVz3oVLSKmQL94LlQMxeZHs7LZ5SHzP3szqeIrFMmuXGK8NzsSQBQKKxQeHt?=
 =?us-ascii?Q?9NDbz3qGe5kJjhmu2OYdXGVS6PV9soOk7VvFjGuzCitzQgffQ9+j1ilbAUnw?=
 =?us-ascii?Q?Fd7vLV/AfmWbP5S4fREg8ryvbORj9c4/lr37VZgbDENtXbNMBfx4l5oHdkbq?=
 =?us-ascii?Q?9PYZAtHcfwJ1SK752WwTBs/Rt0wNVHfTDx1o7Cs27VHRTjBFYcBMV2lN/OB7?=
 =?us-ascii?Q?Z2TKurT6fQpY6oy6qbFXLfl+Vwq7snN8yjeVzXZRNbUmOFhEY1p9sPX4EJz4?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84406a1-bf11-4af6-2a0e-08dc7baf2b77
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 05:05:45.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq4x0vZApVw6WcsmRSq198U4sZkeqy+I1SDOosRl/B0b8gduddXQxT0EYYhlGfMYz9adYPM11VzWGer0Jhcs4esvjq0wpLZsHxEYYMnaizc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-Proofpoint-ORIG-GUID: 3bA614thkzzmOuoSZxqnEn_Ppq9icmUL
X-Proofpoint-GUID: 3bA614thkzzmOuoSZxqnEn_Ppq9icmUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240033

When fec_probe() fails or fec_drv_remove() needs to release the
fec queue and remove a NAPI context, therefore add a function
corresponding to fec_enet_init() and call fec_enet_deinit() which
does the opposite to release memory and remove a NAPI context.

Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
v1 -> v2
 - Add fec_enet_free_queue() in fec_drv_remove()
v2 -> v3
 - Add fec_enet_deinit()

 drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a72d8a2eb0b3..881ece735dcf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4130,6 +4130,14 @@ static int fec_enet_init(struct net_device *ndev)
 	return ret;
 }
 
+static void fec_enet_deinit(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	netif_napi_del(&fep->napi);
+	fec_enet_free_queue(ndev);
+}
+
 #ifdef CONFIG_OF
 static int fec_reset_phy(struct platform_device *pdev)
 {
@@ -4524,6 +4532,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -4587,6 +4596,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 }
 
-- 
2.25.1


