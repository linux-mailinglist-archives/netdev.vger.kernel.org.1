Return-Path: <netdev+bounces-203819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D6AF7546
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1281C83F1B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853A2E2EEA;
	Thu,  3 Jul 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E99detvN"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17138142E7C;
	Thu,  3 Jul 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548688; cv=fail; b=ukeHN5nYeEc8MumHG8g1tmxAoe8vO1fYMlYYiSXVeM6W0W7CbVfrFHVCpQO2JaFyH7HoeWdnLftZbXLmBvdOmw4VbQpWwQHi7J01CLz+ICjaUDiPyOEYx8eaXwwczB3miNFPX5bRy4l5hEY2uK17SYl9is1L+GR5aQMuS91ifiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548688; c=relaxed/simple;
	bh=Gy0GfMoDatLYSNyt8glvzvHAsaQ2euV7hQDxEmZ2dNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJwDlFUoiVKdRm8tmlTwRYm+tQexRVnChUbj70xHAXCiZ7SXtZY2iWacasr7GRerRb2CgrzWusp8L9ZlMPWDNOhsvzD9YdXAU1wEdNpYOZcruCh/ejTsuoou3kyFlXvLwahI5C6N5nUV9AHam4afG2j2bwMXVeO/HsInQt2ov68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E99detvN; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0x2/kpVvHCOiiabPH1aaZX2uDxdzVvg1dHHsSANAh0znrjRymUDGQbTXVr7NXCj7CTYqgiMmJGLNfWSBMj7nQ4RaucWhYXY8ZSBuljo30fL3CwH7T0tJblv5wwEqOicQPIwiIcQgHwzOrnGARQKENX37tGPK8XH+qiHBqv4zTAuulWG6mjcK/SBonYTgkQS81afM5FewnMJsnGYehhE1wCIwcdX8Wq8CJTRXII8Emd3tsYxpaJOyG2xhJEBTxKhdX2vy6KU0Ce7Qhp3792axF24ifQ8U5HKqQskTiPvcjSvJBHqQumPu8hz0ZdAD8Q8/Z6Cl11IiXZ1DYxMkOsoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqm6ZQsXaq64MOQUiZNmJXKyRq+7JOb6EO3an1jJ78w=;
 b=uYjqq0VWjLikSllOkpqeH9xHLdD7/u2PO2QgC3g1VUbka7HGPX7OPCTgbv0IFZuAtp70FUlEiPQuM1fvfiH5F9yhCvU1KVzZpKsCJQ3nfY4wzbL6cOjFVhCq4YASyjkAg9bDrBaRGdowDD1FmQ+k9RV5TWkjwXEpfih9/Q8RphMkPpIPwYCS0f+GX9AvFS3zPc1Us4u4nUQdjsKpq7SrdqXmLlDuKG+XsFz+AGpL4vAy9knp4YIfS5Rm9wxPsk0uU2qZGOp0svqeHs7VQry3aTkY7yjPOAj2NOA+zb7jOcujjD5i6f3A6qbwXDgGKkFKt6KFHfpHg6b9o+QQLG1xZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqm6ZQsXaq64MOQUiZNmJXKyRq+7JOb6EO3an1jJ78w=;
 b=E99detvN8f7pO8bs/oScqsgqNVhs8tVh9CWTH8E7qLoMn40RRUCvCXcPRhazaduhR17hZZHl7FFxQOq3NbNNnDG3W8p1J1+xUJaGw0GU5yeum4sa+4uKrNx2ClsYfEnoBLkyzU4jGzw9RmdV3q/LUApV+gywrkpAFqqPKF7SLIgpuhUnIPr7bsA9KA1wTlOYtj5PD0dmUW4zPdH5mgx6dgJMKgp8+F8vdfM9MBnNY1P3S408/pTSjJCkS3xq6Uae8NOgl75Vh5/g+aksO/X6tqlHe4F1WZvz9bQmhZAfDBo+dPxl9QMaU9jmxrsOGNKhcWBJXze51z4Cf9BQdo5j6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 13:17:49 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:17:49 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Call hci_devcd_unregister() in driver exit
Date: Thu,  3 Jul 2025 18:29:41 +0530
Message-Id: <20250703125941.1659700-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
References: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM9PR04MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2aa233-4943-429c-9c74-08ddba3401c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8bIvRS0BNVVnNvlVByIFDTINMEveqH0njWOszU5OeO4GBgpacpjCsCgrOX1q?=
 =?us-ascii?Q?lVrjRiGcdGpJm/PSMycLizFTJTdVGX5jjZKOZW5byffX3V0eRYXmFV5+8IXQ?=
 =?us-ascii?Q?aN5l25AoUgKT4Ig9qTvl3H/Yx8cMgjVaWtFkx4vqt2SE+NiZYeJ5F43L8Yym?=
 =?us-ascii?Q?OLKDy/AIzRtmyglHM8iLM9SW536KmLbqlNay2ekvvV7bjhCsFP5U3KYDDfTt?=
 =?us-ascii?Q?udO0PkiDGx2Lx+j2Spp6PkSLXm+4UVajnPFCW6UrdBpXqqCdqlDV+uWXgl9t?=
 =?us-ascii?Q?APL/pMKZQErUoe+0HI3i8riwkZZcolo6LBqlCygjMSL4DZtlXJqgpnMu5xzg?=
 =?us-ascii?Q?b/3mvcAR1XmHbryloRezlOid4z4GDIS4k2EIZpERaD5YgOjJ/tr0RGolEstC?=
 =?us-ascii?Q?3zMF10nMvn8JAZH9R61zHgGsTbYKOH532UJtP7lLSTQ5DLAVvs68Z2ZVSW7W?=
 =?us-ascii?Q?igbFV8bfWrOCSEOWqW6OfW1DnyMAR0HCdg5fAWRNgMmEDJZfJz8VGzEaUp8R?=
 =?us-ascii?Q?sqcAmQF+6OnS5bu5VMaiQkZUW1qd8HpkRiqpiIZbo44XMXgxAh2hhsnrSJb/?=
 =?us-ascii?Q?MzVp6XWEJKC6KJ8ed7lJR9YddzWLB6KVW6D5Z0MxIBeQUwSj9Pm7pLE0xEE1?=
 =?us-ascii?Q?9IhZvd6sDO03v/DLuBOHxu5VWr46tQDPXu4xrEPnYAdBx+tocLCB3ulfc8G5?=
 =?us-ascii?Q?drX5lHYebSvM6nxGdx0PAph1jvnSQR4atOLYzAHpTcpfFyjsDTYZhxcUEUS5?=
 =?us-ascii?Q?txVV0RjwKMBJyX6oaBwNqdXwcYTiMWiuBwaqfMFsMVKts9syVaVIi8kPpr3Z?=
 =?us-ascii?Q?JGqy5tJ+wXOGb2Mkf0usaS8dsmB2BCF7+B5GS0sCDHN1hBVijM7SVP+bK2+n?=
 =?us-ascii?Q?4JZkKSCLTGZswOhSoCnCSDl23Mzyaydi7K60QKwrFmT+5MbelafjBS1zfGa1?=
 =?us-ascii?Q?R4Gh35PfsIu8k1mZTrUHnMI97XT/CBb9Kns14zts66YS83mRBIJVMvGzPDVQ?=
 =?us-ascii?Q?03AIqQU5lvQKhxHSRV9+zuP/mcD4V8t+FU7tFrJsYibYaAqeNN3kepbEV+U2?=
 =?us-ascii?Q?Z4fo8FeMvoInvxIjh8JyRsATw+YTHyV9/n0lKGZCkrpa0YUOPyiPlgvvJHet?=
 =?us-ascii?Q?BBBfcNFMC43e+7O7PwqKJy/Wl/pwp4jv9mJl3HmhWE3fxmMphfLtCzdTlZmr?=
 =?us-ascii?Q?91kRVc36wnqXZw21OvEgww9KmG1vvO1J/yRRuNv2kmTpuNJokvG/VOQ7GyqK?=
 =?us-ascii?Q?UUuzxZO22uR32tNMAIZcFlH28F8uX2Wa+qXr84woVytIAlXQ9a7pgeq7Ad13?=
 =?us-ascii?Q?rkb9PI/dqj+PmDJLyEFyziexvViMdQ2N5G66DkUc3XaC9dhqQhfAGLfFAiS2?=
 =?us-ascii?Q?B7htNBEpszO97SqTHGlU7frjsTtMwu8JXb97ApIuEEww57xEvp+UmWzeurfa?=
 =?us-ascii?Q?tBOKa9xBys+4xCZUCrS6zIRrepUot3IsBKQdrrnZRiLMDtXz4F4JCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVB1w/PUsc0brLkFlybhB6J8H+8AulnmTeRiX7lbCy8DQMaEipsmdqpqUf+/?=
 =?us-ascii?Q?7l9eOp0Smrut7Sn5UAX8GPwCLaEaLDB+vbJALoQ7EBdaBVA1wDEr8pBLRWus?=
 =?us-ascii?Q?zchQFjmCC7qx24pEF8VcE7QL3MG9BAvBhsyIgFuRGK/T9sB5YAyIv/oZXdKb?=
 =?us-ascii?Q?MLgy9OfHB1jWb56uayUgH4t9ihGuy4VQ/V6/j6WH8p40A3+GNbu07VugM2EI?=
 =?us-ascii?Q?6J7q3+l6h4xSk6tr2VPnlH0rKZtzFOCF3OIoXktlKhtRTwCgx+HIvlurAHeK?=
 =?us-ascii?Q?UZp4QVVpYw2yjBHFzkBSi5lMS4QZUtHM0BGCUy+GM1yOLMIeO561xCbLV78x?=
 =?us-ascii?Q?4Tw3pC2R+Ig7si3XDdM3p9wNDiS5eCmQDSJb3gprJteXq76hIzgFP3Ja04Ou?=
 =?us-ascii?Q?Oz/UYYH+aJscTiq/zP0hrlwgOeZRNSE67dK1ZW8TDaHcnsLEE9WooIAaMZqb?=
 =?us-ascii?Q?xWI4a1gqB5MQTwPidn2g7bek+SndvoGBEEeOVadAmq1fl7RcqYWVJEC9IoFc?=
 =?us-ascii?Q?gqsL55eNMCzT7ZNZ4BRJPYwYLItzZH2CxbhtNuPMbCktHV+aHhV9PSMftLUJ?=
 =?us-ascii?Q?WEK+0a41w/5a6Rv/BQZqeK7X08S/nPIGS9QEisowL/IoNtoh0IyK9am/O1P5?=
 =?us-ascii?Q?pCO1p7Ybpbp09xzvNJncQ8Cb+8G29lkeBkS7twVLh6Oa+XPQcGQw/s0cEPTG?=
 =?us-ascii?Q?f/Kx28AwYfdeKdLM+YWj6NiDyKn34B/xaH1+wFH/m3dhYgy3N/18xoslst96?=
 =?us-ascii?Q?nLsvpSEWlI/pwvHaGz5a8yKSsrCNKp4mAJSJT9qsHkhKaDnDL9dFUiYs3as5?=
 =?us-ascii?Q?J06rZPSrCfCMC4jPKmbQ0m7pMCm4TAS0GNKXat2k74FHr46Bu4BPu/CnPtbh?=
 =?us-ascii?Q?6YnRytQqa5+HOy5XB5trvdKhf3QIUtPTjIdMMlNjCqGXX/+IgXmRc84GP4Bz?=
 =?us-ascii?Q?NAvIU1YVTGXMEFL1x+8agML0ztdOr3rWDbpo26fvFwBVrNFy6dGYyozlCAD3?=
 =?us-ascii?Q?Y7M7wWI+PShRU6UyYIxsX8okCHxn5jiaDqnMLxQRHOolVuA0QO90HNOI/FuF?=
 =?us-ascii?Q?Fc6+jJqvHcrN6S0YUtPBLwNIQdy5ZjHdR+bAvjXl/XDStjJ+cQBNrcKFra/w?=
 =?us-ascii?Q?8vMHOMPmiAnYGhYgxwys/nCXU6V5ea9Q1dDk1gxHRj6D1XJpdhYRvET8sNLb?=
 =?us-ascii?Q?XNYyoGfs/tGZwco8mUIbhVGq6jeyh4zP7QHqOMJA3Z1Kj4WiHLpdgSSNEj8L?=
 =?us-ascii?Q?67ooy6EruoHJ5qf8+/chkLM1E0pOdsaFVZlZFVMXWf2EcVwcfhdMR05+K0J+?=
 =?us-ascii?Q?PuRZJHQNf44MeTes73BkHDTGsXQwlaTQuBDh4Zmk6KU8cyLwKbg/D0S4YIvw?=
 =?us-ascii?Q?vE9Y+POkyg3qsyO8s0B3XyN3X9qZuIESI/zg5tdo23kpqtz5ciPUN/9BK3wC?=
 =?us-ascii?Q?zs27C0GmbC2aGliK1AvsGkYoBfVhAGlIUYdaxaWSRHibR5YyGfGFz6R8t/tF?=
 =?us-ascii?Q?eMuVNLMNnvP22jBYo0jLSNTTVGKYNNaKfWF+aGI02/eJDftMUSmcX1wVpyKW?=
 =?us-ascii?Q?iAzQ7tXE0RFIEUHwmSV5qHIFjPnFxHWxZbjlLXYZ08Sd/8URXfz08MhvNe7a?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2aa233-4943-429c-9c74-08ddba3401c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:17:49.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke/hjHJj+TWolB3feKSnmZLeH7+17PK6zmGKsmWQF/K5i+V3aHjgz7SywqEIUy6dI+IJL5aJVVWCPwhlLBTMfA7GxnEqVHJ8XeUgdxkpX2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211

This adds a call to the new hci_devcd_unregister() API during driver
exit to cleanup devcoredump data and cancel delayed work, allowing hci
interface to be unregistered properly.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index c56b52bd8d98..91bf9812c8df 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1866,6 +1866,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	}
 
 	ps_cleanup(nxpdev);
+	hci_devcd_unregister(hdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
-- 
2.34.1


