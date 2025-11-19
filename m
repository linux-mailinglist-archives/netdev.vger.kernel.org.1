Return-Path: <netdev+bounces-239929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A03A6C6E165
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57BCE4ECE67
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6C34DB70;
	Wed, 19 Nov 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXQ5SnGI"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77334D90C;
	Wed, 19 Nov 2025 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549343; cv=fail; b=TR7iXuyLBirA5NiKScgve9c6DuB4j2TlyIXWC8lP4Csm6BDIGpOvKYAow1kqZxkk6WfujDJ6i7ll2Oj3sLB/1kAmjjfMgsOn2yeMufF5D4caiC2a1K/aQ8arnu0eizKp6MLwGIUGJbmART49L+OFlm6woRWR+28UfIaxdkmqekU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549343; c=relaxed/simple;
	bh=lbEqDT0T4enXbZjG/QSbRPXknfrVPBKsHDi15mMqddk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIsZYhwoGp5hHEoOjIOky2YbOo2LMNCb+9FzYFVwsfWZOayca4Gl8uw5zcJ5Mq0foyIG+txPNdGjflXk9CcVF/SPxzRfsUyBWkX/HBXjDKyWOXeEGMBQOtVR9D/KJ7zgaHs0YbN8yakhduerwFjz0EQLBV4PBuyoJld8APsKFAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXQ5SnGI; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqrvVa2Vq9LJ6OZSsZVGJevV03CqO6ubAaVHPC2427Co96pUvulaEueB9rUCWyowN1ZsKKY1nP0j+eh2JHPK+r+BY5XO9ig86ZwTSVF+bpzrJRkmEDe9EWsfUDTrkPVw1dOxUiqamT8/x8sauM/cU65OS8i38MLUDvLCal1a6i2CcAi58KPWph/omFbWplTbrGyLISKA2eVjkRe/mxktQjZa+FOpm2ctwQDGkClFSFyQlgOv/gahNvxwVwgps1BVuyiOWS7zDfAM9gp92M9j56haFNoTYCEmq71h80XUm9ARXs4q6kK9KuME6TDhsrK4Tx/KmQuL/8ltoesLwU/jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcV1rRhfdUseOApFEBoYVkB2CXFl9b4qKjiv/cvVy+U=;
 b=gQVMykKhNy+MVLk5+19puJkK2opR5o4EMQLbKLwSqzjdLJ3IidcCQUZSnV9KP4/82t7XbgYp9JsSbz1d1/HMOekJuGFKVemVOQKQiqI9tUwv2P5x1G92nEKt1CXRXkvdzVgl/5iLPULctPgziu16eH2Hsu/q70PEjHwS4Kf8BwxkK50P9PDiSYvfCx7BCDn4+7mKekdgov6R9rlR5CsBt3fmBgA71djvdSmwMcFhAFgSO+wA2fJ/a7ATifilDMtWYBZitCgW9U0w6KSfnvGqk4wiKSyncE4SS9c8+r25duuOQMgDDhG/HJv55PBoVJfYXjQm1hJes4MLizaVn9WzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcV1rRhfdUseOApFEBoYVkB2CXFl9b4qKjiv/cvVy+U=;
 b=bXQ5SnGIaLcZVHEuPgAwrG1y6CK583EHkoekORpyF7QsOWbRHQsuNLcJ7KoyyR4MMCMZtXQoJS42/91EUcv38XdpXCTwCNBdIe9S/i6t4LQAZzrS1b2RPOA+O6R3S+WSIQE4DrIgR/vi0aMYI4yNDVk9kCH8qci9lu1jenAe2oSpxpoG1Pw7o2qZ00u8+F3XYcj6FsqzDoYWWZDL39651MQBTkR6Yj8oLrhn4FvN5jBkeKCHg4fNtCZW3Uh4zSmm4ZjDgkPh4Dj0k0lIEnhYfmbrCfKhZGNyZsZuxeM9CNrMZBpXeZKK5XbZbwOz44A2KoQ3ptPQNwS9IaRiGtnNSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:48:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:48:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 2/3] net: enetc: set external PHY address in IERB for i.MX94 ENETC
Date: Wed, 19 Nov 2025 18:25:56 +0800
Message-Id: <20251119102557.1041881-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119102557.1041881-1-wei.fang@nxp.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fa948f-8cac-4096-1527-08de27593e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?doshyWLa6E0bN2AbWj/JZKKjTKpjPUkhRWlIKu2OfZwYNJDTkdT2BxfaY4sJ?=
 =?us-ascii?Q?mrtgrIW4EeZERO2gV/fzbU86zQhEE6FAwrUIxa12j8mK3WplDQIN5gQqOfRw?=
 =?us-ascii?Q?S+kEU1z6RWAqGMQH5WGqR4ZKlc+GMc49CQNUoVWKzea5WzFUxDNFn4obkrSx?=
 =?us-ascii?Q?wdYko67oO0Wa1L+3P8Vt3Ap49yedZDFp5svkAMVGZVp89L3zwTdpyNjb7bly?=
 =?us-ascii?Q?39knJdhb+r1OXAZ4JOJRhfJZzS5WhyD18AFC/qw9U8QBJwQbpRZpMK5Thuak?=
 =?us-ascii?Q?FXXtp7rO2GowkCWP04gjSEgiKuRZFSypgu0U52L8F8SaGPtneMEoKQFHUV6+?=
 =?us-ascii?Q?9OpGsta8nKkeHH3HkKAx/3/9nPiWfOsdpBLSc+c2A59iYMAkO5rzqMox5WTR?=
 =?us-ascii?Q?XApZVAOst1guxejzUPChSixEG5Il72jyQrX7GA2xbALSWjX/EesSly3MglrL?=
 =?us-ascii?Q?2snJgMaQL/BpGFfDkO/9vMdRsAyj7+B7jiM8DYMcGOIi3vhg4pp+xOAgGHV/?=
 =?us-ascii?Q?8D7kO1klWO6aDIC9ewA9Iw7TxJtRi7+WCKingTmRmn4iyqDVLO6n3oJwMNAu?=
 =?us-ascii?Q?H0TnmPJs+DQWEBysIun89f4ZM93//YfNBO7Z4nIz36KCgh05v6nYClTSj28x?=
 =?us-ascii?Q?Z8Gd4PL1UWX4YA7X5O8+joH3q98vEoR4OKej6MGXCHAq4YD2L1NVz/jT7RsB?=
 =?us-ascii?Q?jOXQKRM1i+yR7prYCz16LHQ3w684ZDwOo77vUii9ke1DIPdz495PUP0Q0zzp?=
 =?us-ascii?Q?+0Khig6W/tetCq3F2tKIkrMWLkkjxoOkKFcIViOgDVRg/JH4mqQhdQo7KW7f?=
 =?us-ascii?Q?74Q7Finu/dNAhjtHv3dKammw6si6DJow8Tn2heG0imXJ18Eo79jtwuZbm5sQ?=
 =?us-ascii?Q?mp4OCj1LTf891XBIC7M7Jij10jKa+0gyK92k3/gvDN9eKZDQx4T/wIbHOHWA?=
 =?us-ascii?Q?9lSZw6Gk18k26cQPSLW91UVNBO/K+Gd9itII72V1+bPZsngaBj15cZa9EZEn?=
 =?us-ascii?Q?TYLiv/TlGo7mf44EHFUyGbfRgUcolgo7TZI2PfKDY6m0tC3BDpTH+5lcc0Ki?=
 =?us-ascii?Q?C5ncDzLLk3w8A85rCT6mGyaRoL05ebdrnV8c2nCsnUC6QFyyjHXd0bM4mJWM?=
 =?us-ascii?Q?XsgEc64LZoZtdFbQsLYJur+yABoe0govFw0h9Jp5LjrxcDEU+bepafXSKRMS?=
 =?us-ascii?Q?1z9HqVzpZEsMQjrpDq0Kfkv+goEMCK5yUQXKrhqGKW+m8LN+NH/Z60AFnCX7?=
 =?us-ascii?Q?61wLEYJy5lvQKgx3H+LBJpbWqtfHinV4/DJKdpAA8O3pJXXbZAsf7GEkqEfl?=
 =?us-ascii?Q?cH0JulbCLcKKy8BdV3iMd55lvUG4xmEGW5gEXRvpedKZVTMtgygryucy9oGH?=
 =?us-ascii?Q?XMjarQAaR4A/NY/PCGfYcAJZ5c+Kxusen5qQPGwg7XvkHuxUWZWW8nhiOPrl?=
 =?us-ascii?Q?OnhkhOLgIDA0QMRTnZyaJjPoaXfK17ZSNlAmrf5yUWHkTbsRm7SFm787XzaT?=
 =?us-ascii?Q?SRQgOTuwLOFUbyKQ4wUdO21LL9tNHVgdkWdy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kGOB5h9RWn13R8lyqTsRtCj6yyhxQKvsNIEYppZhFWHnXDB+1+q3/K9E8oF?=
 =?us-ascii?Q?LYHxRa9SsUmeziXJrC9l4pNCH5F2l4QIFW9s8kzf+DFu2l8mj+qmHvkeW6nt?=
 =?us-ascii?Q?J6BRnEqzS9QnDJac3oqP/LePylLQE3dXb7ihDaL911FDnpLQfVDECeyPkbvr?=
 =?us-ascii?Q?DkCVS3OlVlRONjMR6w+QRaV3hCgVmXgBQOscIauvuUrnEiuVHrafxteGpKdb?=
 =?us-ascii?Q?zpfU3ThFSo/nloREOLQdi4dEBPYIg0mOwkN9c8m/ZgwpAWiKq5FC0LtQwuTD?=
 =?us-ascii?Q?aPLnMfUtGchfnp2/H2r6+IvyxSX90EG/5NfHdtG5l6trePFMH8N1/GFUrlrx?=
 =?us-ascii?Q?1VrIccFvLi1xWFi01wlhVb7fYpJbbJ4iOYRsGpvR9VnBoVxilDzcq2dCPjet?=
 =?us-ascii?Q?RLaENV0SzK7O2r2DrBLBGKWDKd6PRfPR6eEm/3JwYDD3cvWgmjCUkKp3srA9?=
 =?us-ascii?Q?kYfaoCZh3apMsdqOHkLcDh+OzcKCcFhJsy2tx+AqdhNaZc9gpMS2CYD4cLMg?=
 =?us-ascii?Q?7WX/LQ+RlL471Y9EQP1EWk03loWC/aYqdrvuGHu7qDr2r3Z123RjQ06rHnmb?=
 =?us-ascii?Q?pkij0CaIc+cgTO2LWDmXU3NiyNPl01qIxZF0xJa64YyXp6h/yzyo9888kIyY?=
 =?us-ascii?Q?MZIISitKZkn9qkqzvAcUIxqvYszY/qXJ8mmPABk6Y3RqFS8Y3YsgzOmCDd2H?=
 =?us-ascii?Q?sMgfdC4bDiJ+AEZ8ei5B3b99wfq/IE8qFlhmkWdUHAFjXQmo1fKdJQcwEcrE?=
 =?us-ascii?Q?Kuc+tB+7JZqmR/ZtBVltnp51YzGyse/T5moRqhIbE7+H2VrFWGrVNHbveav5?=
 =?us-ascii?Q?LXLNUFI4OndAUFibRst2A0cExQY8DBVHGuzH/YwJYxjVPNBrK4CCu1CsI4s9?=
 =?us-ascii?Q?ZAIgwsKA0B7RCARoMWgm70DyVVKlvBUv94KhZXz7AlnX5RGrgzmZRSgzBp9Z?=
 =?us-ascii?Q?F0yg654UTVjznfWPewG7dtaDdMy9spCzshWhZbG6jxA8iomO6iAig476y+gU?=
 =?us-ascii?Q?u8uH4wYwivwzR8XYetQleUAmjA6nswvJvUPuTUG9vtngJZmqiI12aihYo96o?=
 =?us-ascii?Q?Jms1ubtlYtbJI4/sBzfoS+gEeJIgDSeR08iBihzXLv/NzbKJpyWiEa4Q/+tg?=
 =?us-ascii?Q?lNR7TaNC/8Dn1Sp+hcMHboE5kEPcIscr8p7Ji80+M9Qm2fVZtNwOPGmf1Q+W?=
 =?us-ascii?Q?KWCoZuPaxQYgjJeM8Wzzy1jBBVYdXIWHY3WI4pP/qiDuB6Yi8Nq3Qq3gc4vi?=
 =?us-ascii?Q?OAEoWlhbGFdly6Saxi8N8/HwySUi/b6FTyL1py3v4JqgZ4UG2Pt2H/126PhS?=
 =?us-ascii?Q?kJfmyng7MZm4ikGe8kJ8tVbvDlWBEh5nNR8ONX1p1cTkCYcjwc33C4ay5Lbw?=
 =?us-ascii?Q?H2rrVEqtHpuZdO5ua9Uit6w2AlX6DnkzJNVWktN8y/Akvvyy9ENC4s4YRybr?=
 =?us-ascii?Q?zzYxJE9L0jGXivoP/2cEpOTB9y+FCRbKsy2pA25ldo61yHqU5vPjgaWLz1f1?=
 =?us-ascii?Q?RxpntSDp5C4bfUHoEdl+rD44sagljm1uVB/mpUNijQsHqZ3GRsY7tC757NdN?=
 =?us-ascii?Q?kO9ZzG8E9OsxkZ79pYnr4l+ji05grSFG/IYp6Ura?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fa948f-8cac-4096-1527-08de27593e34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:48:58.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taimA6Vy6B7k4v1NLOTIhdb/jHbbKQXxnA7jXuEC5SKZtlq3EIZTL/vBUGcwzkbp4wypR0Z4/yukxI7/7YDEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

NETC IP has only one external master MDIO interface (eMDIO) for managing
the external PHYs. ENETC can use the interfaces provided by the EMDIO
function or its port MDIO to access and manage its external PHY. Both
the EMDIO function and the port MDIO are all virtual ports of the eMDIO.

The difference is that the EMDIO function is a 'global port', it can
access all the PHYs on the eMDIO, but port MDIO can only access its own
PHY. To ensure that ENETC can only access its own PHY through port MDIO,
LaBCR[MDIO_PHYAD_PRTAD] needs to be set, which represents the address of
the external PHY connected to ENETC. If the accessed PHY address is not
consistent with LaBCR[MDIO_PHYAD_PRTAD], then the MDIO access initiated
by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 6dd54b0d9616..443983fdecd9 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -563,12 +563,64 @@ static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					   struct device_node *np,
+					   u32 phy_mask)
+{
+	struct device *dev = &priv->pdev->dev;
+	int bus_devfn, addr;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0) {
+		dev_err(dev, "Failed to get BDF number\n");
+		return bus_devfn;
+	}
+
+	addr = netc_get_phy_addr(np);
+	if (addr <= 0) {
+		dev_err(dev, "Failed to get PHY address\n");
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(dev,
+			"Find same PHY address in EMDIO and ENETC node\n");
+		return -EINVAL;
+	}
+
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC0_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC1_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC1_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC2_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC2_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	u32 phy_mask = 0;
 	int err;
 
+	err = netc_get_emdio_phy_mask(np, &phy_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get PHY address mask\n");
+		return err;
+	}
+
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
 			if (!of_device_is_compatible(gchild, "pci1131,e101"))
@@ -577,6 +629,11 @@ static int imx94_ierb_init(struct platform_device *pdev)
 			err = imx94_enetc_update_tid(priv, gchild);
 			if (err)
 				return err;
+
+			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
+							      phy_mask);
+			if (err)
+				return err;
 		}
 	}
 
-- 
2.34.1


