Return-Path: <netdev+bounces-99299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A508D4564
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B321F1F2303C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7431143741;
	Thu, 30 May 2024 06:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547E26AD3;
	Thu, 30 May 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049802; cv=fail; b=iFQQJNEl5/XV25FzQxUKxxO77dPsbWFSQFqyzoJEVf71Fh5HMINDneYkBFWQEzU39Aj57rgMnC0x0nSNfJVYIIfROXzstevxFvcs0iiPqhbHiFKUq3xTYaNJZNLx+iloAnRUjPXsNzxz8nRxcJo2NHDyVwWQwfsJstgngI2FVWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049802; c=relaxed/simple;
	bh=u59ykNpUr5CF0P5KLmz/JJPiwY92c/yk4VimOM8sA68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j8C6ggXVN0Ehttm6FmrdomEmWml9R0GIJCjN/7tfOQcxxqkeie+yJ9iLuEdqgBiDLjm5vV4MYUJVzsonIPEfTzufoix4l6PJfebvjRB9/mInshHQDtP2BTBI//FoC9a952GXrw8xdiIsaxKtwhoVLCvK05vXVSMkqnHPfUHh2SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U6Erf2000663;
	Wed, 29 May 2024 23:15:50 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yeg2xg4rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 23:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGovEscW9/PpiRgIWW4LkYJB4WWcY8sxOX3aCQ1Sw6PX2BnaaJypBqWAxQBtME6uyBZpZeWqSEOzfqKKY+Q46TaIQrMLg5I+BoYivSQWvngV5Vh8N3qJDsy1/oBBwm6o5rwpxm/qV0Zk1FC0vX57V4U9oKGVEwtHs4k5a9cJdmAxuiI8Br9DDVE1ywPU2XI4mq4IxHU3HrLVfYcjccV/EW/YLh5tGDx4yOvM5bnNbbwtIGJJlHZOH/Sk12vuQ6/ikjsv6wNiCJH46InQtB3AM7F6gxR/W1aFHN8YaaAMBJxRhis92X8dHITqdn9wVwH8dxFs+/ZMy8K4ktpVqo3i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAwiW0b3hehAuUCLsd+ZmpunUHEVLH3b6ge2lJUtRmg=;
 b=PLeZoQajvHuidu8MiW407gp/wGrajlOSSHIpjxb1cUz5Ei2pF3r2b0fkkobYMpBG0GLqiJ88BwvhEWWdK/0VrndSpjgVSSKlgcYqCPTdnvyrtEsfzrTfQY9HmdSwbc/I303u0Ny/H8QQKCouy7dLoUJ2heOYinIDdK+wbKvfjnEMCmiXPZos1QBR/c80v7DzofYaWsZqqTNDD7VbODyo7N08j2H06d6YfU+wBJjVA+3qTxcnEkCbkDQKhJjJoAvyF/lKR93YwqB+bjt+0W6UbrXfJIQuZbBUdVleua00zkj7h8JHAgny/2gw3UreaaAFI8uu98r03EgUdTEzA4maSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 06:15:47 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 06:15:47 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: linux@armlinux.org.uk, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net v2 PATCH] net: stmmac: Update CBS parameters when speed changes after linking up
Date: Thu, 30 May 2024 14:14:53 +0800
Message-Id: <20240530061453.561708-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH0PR11MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0407d7c2-3098-404a-29be-08dc806ff210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s3qaNGsYWh+DiN0+mZnCOGeYUQzWn1Xi5AX5bATAKKeJsJIALrGdHpkQkWgR?=
 =?us-ascii?Q?AE9T6yWt98JFjqxjZFqhTxqQ00+1AKrXB5DV0zsE4RSGqnq46CjOcveGIu5v?=
 =?us-ascii?Q?iwQlfCkYUDlnlhq/RT2tbNWMvENLnz4W6mLjWVvmIoRKS0oArg9xYk+IXkg8?=
 =?us-ascii?Q?GJG5Ns23T/MEKG7ivWuJyerHltmPeu062vPJfMBb/q3wQN8y+/YUp2vyj2su?=
 =?us-ascii?Q?o9Zu82A2v1f7xkK14lNgc3j29QdJvkhAxmWUo7dSKGwqKyk5kw8/BsQBLuhS?=
 =?us-ascii?Q?2zG29w95jCvHg7bVKc+M0lf579b8re2BzTOSPS9nMJihhMGgBFtNFU/Rrbqk?=
 =?us-ascii?Q?67PxLk7Ulaqj/47K1x+L/LaefUfkr6EDUbiQBwBcLu4ZfM0cWfgWp3ETvPFl?=
 =?us-ascii?Q?ExXqXFW+ubOzBWjE/fCqmnfKh3gCqoSWtWBkTzSJyefm+7dBHuiBDdCike0/?=
 =?us-ascii?Q?A7lLUT2yz9SOIRWJoNR8oLuajGVc9WL+JF4qfwM3v6/1ZKyISK6wpaHnh3UZ?=
 =?us-ascii?Q?gOSMPlBBl3Y7H3Qe3g2lOAu6glZlVnugEavxEOxlb6WglQU3lBpI6mAnCsPk?=
 =?us-ascii?Q?Vx1StkPpO6RYoPTBnx+ZgGR+XqIUBuUzZclTUHUgJwBqPomLkzfBkUoFNapr?=
 =?us-ascii?Q?PdB04nHLbJi7iAtiyjTvsiF5aKsmnS4G8g4MSHJ9dRr336O7LvK0bJokewFk?=
 =?us-ascii?Q?80/OpIo6eCHfnKdcM+OK1XsAgsbwl3MXEXqjM4e4dlsSsrzU02g98dKY7NNi?=
 =?us-ascii?Q?iunn6W8LPIqEQXj6XWb4gmQRYoGTtaJOgjGAAK5jmUmr07Unsr8aTmPzG4gS?=
 =?us-ascii?Q?OtzS2l4eDNytjFhjlugYtDB8ooAE722TyKzWI0PWr1oml7juN0Xp58Rq0XYT?=
 =?us-ascii?Q?sY26PmT2LBAbVUGpgn6GgOSAPuFLLNnQiQt8WLKW1tpoBVDbVU15DpwhDdEz?=
 =?us-ascii?Q?EPt8ZnIiokc/zLP5Y2X4K7ORMCS0GaWxlmOvp+d9bVvztNyOLarhjntr1KBl?=
 =?us-ascii?Q?LKBOPB8od5GX72Bu9vVMSIR0JLpfVYWNqsXKIwg3uFH90C7p3veM6vmjgu5C?=
 =?us-ascii?Q?D7kUmShqZ2J3p30syJTerrEKsMvFjAX81LHuY5bKX6tIxalgvC3YiRLmXcfl?=
 =?us-ascii?Q?ceUr4WbA2tEpIRIVWDqp+zGgpxCIa9+yorxopa1AgbT+olPx4BaqrzyztYwI?=
 =?us-ascii?Q?6JLvq7RSuTWF08K/t58r1g790S7BF2CwYw4sgCzO0qfVZlgMtV78Cm1Eh+aS?=
 =?us-ascii?Q?SsEUJVbJcE2TXMmKZ685CGxtOgbSh9nEdsBDyQ4P3+d1iXTfICPXPezjOtoR?=
 =?us-ascii?Q?9CdPMBSa+IKobLIKWFqL+r/p2j731pfPRMcum3clK8RU5w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hJ+ASNWQwDgNri43kNsoMMmicL0pk3iN+/ZXq8JN91jLbXkltc9HzDfyFA7K?=
 =?us-ascii?Q?Zn93/0lTunaOijA5V5Ds5d12vBmcGYsbtpDuncGCkZ+ivRqmxci4zd0zFPA5?=
 =?us-ascii?Q?Y/I1gCV3Ieqh3pa02t5F9V8Fh4VDeviB/Q9jUbEn9Y7EVxG1bN5SGp8DAd0b?=
 =?us-ascii?Q?Bpbf6mtzGBHzglJs8265hGJWOsFrSXhqdQdvcs5X9yDR9agCnGig2dCRGP35?=
 =?us-ascii?Q?rUtAti95v/ZathfQCyMeVv0egap7RakRmxhT2gInK+JIkCgszOAsE+v09DQH?=
 =?us-ascii?Q?3FmdzrGJIdCW9M2Q0OXcqlJuCTYSv77NUS6B27PTBO7NIs5SqQexIBHRaQbg?=
 =?us-ascii?Q?0SpUGWjq09qfeRBNMPjRQLxWuDZFiCMT02ecA8cS9HR9N/pp++DCdc+hJdY7?=
 =?us-ascii?Q?A6Sryr9dV4olSzPPSD/K9EcCkKaEf2Csb4RUV+D/gR3pTCIgr32FTcdA5Fz7?=
 =?us-ascii?Q?rwvZIT8332AbLo3mkhaiddypouyCs0MulSw7DZOAdr4l1TRG0aaIqSRwjGYJ?=
 =?us-ascii?Q?1daAkrnXvIxwiwlCnF8JoxbRRMrk9a+glizF8xBySl28aVH1+fu+xJW/srry?=
 =?us-ascii?Q?T1CxiFG9YblDHf2/rYFDDaFXzAcgmOnvAf0I2w1zovp71HmAZYFyvorQM8hL?=
 =?us-ascii?Q?XgNLl/ZlRb/Q50dnNAPbVms99YvfBFIM+vDK8bcJRnB1/7gjfUkBKiOBOhqU?=
 =?us-ascii?Q?hKThVriHIBpdiYJrwU6uVHIuATAbvbRpbTaru4y2DyEI5Bvb7Tqqz0Xxq5TI?=
 =?us-ascii?Q?kknzCADvGMR73K1aq/zDLhwPHl/MtkEaqwCoWBUjJJb3tngOTURNKPrrJbUk?=
 =?us-ascii?Q?qr76n8BM/ZIlYXQDHLcxHPDAG0hMYzgf05QgdExKxBY2JZKgvckHw9cahzLe?=
 =?us-ascii?Q?NyrwQhwPd2A2ncl9CYn0I5PJQtyflxJtLPxKY5uYBZZwR2fPer/HxOpAOd35?=
 =?us-ascii?Q?f5o6wKGEwIutod9GKhyWTzeFazrsiHzedkRkyR0rRjwZXdE2EM6D1SCihVwM?=
 =?us-ascii?Q?0zMWl2mi9EZc4GTtwx6jbpHtvC+9D948qTtblf99MRjULBIhEaT4mZUYN7er?=
 =?us-ascii?Q?3M/JzA2s0U1tdFDeBY8Ka6448ZzC68T0JFTbdbKJERFR3v2IuSg54ZN7hyVl?=
 =?us-ascii?Q?pFNb9lVxmUAI00CNZdEHFLn9oq7r1eFQv+cH4EklznR5j6yhzrt8TxwJ2e1y?=
 =?us-ascii?Q?rWjJ20ti4hQndA2lw0TRLduJRL9AIo/4tuDyoe0yWAuAkSpzNWSKhasOdWcP?=
 =?us-ascii?Q?IiBjikTrCp0OprjEGBuIyqE1TJ8SM9yut7Mam3wTCm4PSxl7RLixdWsos+Pv?=
 =?us-ascii?Q?13+znq0x8xxXYJzMYgj3Ye4FoObRAvkikHY80l+FOP4UCyCtwHqpaMFFO3QV?=
 =?us-ascii?Q?T4Zf72NsikHLpSC3ReJvFNx5rcKrV54Lj/DFbwZHVYiKGP8L5lCsOjBnmdI1?=
 =?us-ascii?Q?HP6D8WwIAXtfrT4/v9sBx9vNnxVdgIQ/AlSEz7wzg1gjYwtDOZVtqycOxZZ4?=
 =?us-ascii?Q?pDy9nvUWD/Dh8ZUNZhQuVcsGXhhE+2iRqsWdvajvJdxEYm6sbq5/3OD5/y6H?=
 =?us-ascii?Q?37MfxOyWyWPJHeY2qurCvomX27XrGSy/gOZAjGOYNbktqTpNiwYS3d+JZxOd?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0407d7c2-3098-404a-29be-08dc806ff210
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 06:15:47.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c4WRHQ7rTVEO7YUbPgk4rjH/qFA7RdP+QbbD9h41ANZOaflBg9kVR/BfeLFQBr7BdFhJdCDBQ187PEnAX9ku1fckqAVeTW5wsGJga82Sag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-Proofpoint-GUID: dii_APQbuQ9TAS5UKbHb2e_grPlE5ex8
X-Proofpoint-ORIG-GUID: dii_APQbuQ9TAS5UKbHb2e_grPlE5ex8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_03,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300044

When the port is relinked, if the speed changes, the CBS parameters
should be updated, so saving the user transmission parameters so
that idle_slope and send_slope can be recalculated after the speed
changes after linking up can help reconfigure CBS after the speed
changes.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
v1 -> v2
 - Update CBS parameters when speed changes

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  4 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 45 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  6 +++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..7a386b43f117 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -356,6 +356,10 @@ struct stmmac_priv {
 	unsigned int rfs_entries_total;
 	struct stmmac_rfs_entry *rfs_entries;
 
+	/* Save CBS configuration to adjust parameters when port link up speed changes */
+	s32 old_idleslope[MTL_MAX_TX_QUEUES];
+	s32 old_sendslope[MTL_MAX_TX_QUEUES];
+
 	/* Pulse Per Second output */
 	struct stmmac_pps_cfg pps[STMMAC_PPS_MAX];
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..44db35a7ca6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -138,6 +138,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue);
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
+static void stmmac_configure_cbs(struct stmmac_priv *priv);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -1075,7 +1076,11 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		}
 	}
 
-	priv->speed = speed;
+	/* Update speed and CBS parameters when speed changes */
+	if (speed != priv->speed) {
+		priv->speed = speed;
+		stmmac_configure_cbs(priv);
+	}
 
 	if (priv->plat->fix_mac_speed)
 		priv->plat->fix_mac_speed(priv->plat->bsp_priv, speed, mode);
@@ -1115,6 +1120,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
+
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
@@ -3182,13 +3188,42 @@ static void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
 /**
  *  stmmac_configure_cbs - Configure CBS in TX queue
  *  @priv: driver private structure
- *  Description: It is used for configuring CBS in AVB TX queues
+ *  Description: It is used for configuring CBS in AVB TX queues,
+ *  and when the speed changes, update CBS parameters to reconfigure
  */
 static void stmmac_configure_cbs(struct stmmac_priv *priv)
 {
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
 	u32 mode_to_use;
 	u32 queue;
+	u32 ptr, speed_div;
+	u64 value;
+
+	/* Port Transmit Rate and Speed Divider */
+	switch (priv->speed) {
+	case SPEED_10000:
+		ptr = 32;
+		speed_div = 10000000;
+		break;
+	case SPEED_5000:
+		ptr = 32;
+		speed_div = 5000000;
+		break;
+	case SPEED_2500:
+		ptr = 8;
+		speed_div = 2500000;
+		break;
+	case SPEED_1000:
+		ptr = 8;
+		speed_div = 1000000;
+		break;
+	case SPEED_100:
+		ptr = 4;
+		speed_div = 100000;
+		break;
+	default:
+		netdev_dbg(priv->dev, "link speed is not known\n");
+	}
 
 	/* queue 0 is reserved for legacy traffic */
 	for (queue = 1; queue < tx_queues_count; queue++) {
@@ -3196,6 +3231,12 @@ static void stmmac_configure_cbs(struct stmmac_priv *priv)
 		if (mode_to_use == MTL_QUEUE_DCB)
 			continue;
 
+		value = div_s64(priv->old_idleslope[queue] * 1024ll * ptr, speed_div);
+		priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
+
+		value = div_s64(-priv->old_sendslope[queue] * 1024ll * ptr, speed_div);
+		priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
+
 		stmmac_config_cbs(priv, priv->hw,
 				priv->plat->tx_queues_cfg[queue].send_slope,
 				priv->plat->tx_queues_cfg[queue].idle_slope,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 222540b55480..d3526ad91aff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -355,6 +355,9 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	if (!netif_carrier_ok(priv->dev))
+		return -ENETDOWN;
+
 	/* Port Transmit Rate and Speed Divider */
 	switch (priv->speed) {
 	case SPEED_10000:
@@ -397,6 +400,9 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 	}
 
+	priv->old_idleslope[queue] = qopt->idleslope;
+	priv->old_sendslope[queue] = qopt->sendslope;
+
 	/* Final adjustments for HW */
 	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
-- 
2.25.1


