Return-Path: <netdev+bounces-241454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A29C84119
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBBD04E3606
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F13016F6;
	Tue, 25 Nov 2025 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFjrc4W+"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C052FF663;
	Tue, 25 Nov 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060703; cv=fail; b=tmyRrxCty2eqC33XVdroafemKlv33Qoguj8pLvDVWyNG2wto82ac9WAf/oIEYo+OgGCK3gPqC0UK3Q5A4iYVCW/SGzPq8xCZ7R3UusGw7L1DW8mjcL10Q2bngyn43dLqKmyLFhIJSvCGgy0Q0GwAVnF7EzQmiHo3XK1ba4hCFX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060703; c=relaxed/simple;
	bh=+d7nsIWhnSl3KOIy6EXTE55IIAfxDYHicTiOsgIpyOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PogvVPlSn/xvAjWGCyOpm5TuKmRa+vrt31b6qWTx6JNAZcZ5g9s5MY/UknGxmlzA2dDWeRO/3xUwf7qdMZVdW/NeYIVOjePERvZbigC3kals5uauyyN94z8Wh29OO7GhHwgkS+/tSirjK4Bv151RTmEA1JmxXoW0eK6VExRRy8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFjrc4W+; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfvAahM0oL7RR9xIELVe2XmcW7WkGD2+zIMPR9lUoRTVlnMF55E2iehKX7kCBVt/2krYAdvVBwnmQN70U4EGLkwp1LQjXv257mExT4KfLsbPXxqW52e9/mqj7boSsj/mo/GeQEc36CG1/F4KHmDz59n6ZaEABk/4E18I3QYXcqTEapV/Ta30Ie9nUJ2ohig097MFIqHHlAMfFkX0lEwiROZyIZroxjNKZGPgMjUqNO0v1FNHGlMN2NWY9lELukFM44+IbNO1hZrVIXGHFPaX1S+BdWFNi5gwcUBpe9D6BqDS9JdNxPWUqSCynWY+KrciDuVFJT9CZumi4Z+diNi4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTrH9+jFzPTTNGmGAB03EiXFdNet7j53bmzzt+Ce7FY=;
 b=OsaHtmOep0YEfHV3Yz+rTUd2uh/9srZIdf0iAcuES5kAZ/aY/xYEpwQyamSrcnXLVtbzhioO15P3N/fOBSg+gbOOEUeTXZ1HcJStACT+f/Rtht1b5SgOq09mzcLraTRHPid3XbmsG/+kreabLrX2l7UGRYYFbcTgotHbwJ4JEYa4AW+fJP7DFmpaOJqDLqjDV9zhO/+OflZPrCgMbo3GK7NDLFTqKGTSwxfZN0X3t5cnuYRExbZGYAWL+LXuXsmDii5GTr2VlFMkUra5a7QP90Pztcdenl4pjJq4XC4TcWX5qf7cjmS+ulta4jMQVuyhueGWaJy1TWtq4PjIEzEl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTrH9+jFzPTTNGmGAB03EiXFdNet7j53bmzzt+Ce7FY=;
 b=MFjrc4W+TyK2mRCFU26ho1SqFpEdFvCKnSgK1zARLKPcRNlfMdoraSEDMQAYj5MSMF3WM1agVUnIzSw++Oz5GnCsdWtlvgyq/X6DqzUQTgLmOTWN4qoz3CU0NB1RgWP9EQyWF/K35gANWK9UEZ2iYi6U4s7RAKNgiS0DKgZIQFbEz6d3aGKazc6SITJQvoqJDvookA5WvzHOD1OF/K4sPQE1vrXbgLLgjmKusUqt4/0qz0m2pub/ZUqFiKU+M6BKKXZQJicBC8DOrFd/5FUh4kpk7g9c/owPP7I8aVNnw37/NsdsCR6IGSIbIQE3YEfcknNo5ZY+1Up1OnNk1p00Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:51:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:51:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] net: fec: do not allow enabling PPS and PEROUT simultaneously
Date: Tue, 25 Nov 2025 16:52:09 +0800
Message-Id: <20251125085210.1094306-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125085210.1094306-1-wei.fang@nxp.com>
References: <20251125085210.1094306-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fb6832-baa0-451c-b994-08de2bffd941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tiy0PYERsRPhsmpoR3Rx+O9YZHcrpB9gUZGrxBr3yQkKTViUjsvaQDwFbX/0?=
 =?us-ascii?Q?7diGxj4uCu9wM16s5K9P6FxjiGuCvRHhnsIKpbFloDOX+CyEqZtJ5MF1ks1h?=
 =?us-ascii?Q?Abpg6FVnU4Tmy/CM6CfyU+OUcw0U2mcdYbEkjpNFbP5520zZI0QlkwyVzUex?=
 =?us-ascii?Q?yZBZeq1brJxADgT/Xp5m4Swl/EVb4Jtp3g3naERNDXsJd+DStW9cvTYacQvw?=
 =?us-ascii?Q?lImqEyOG+GusBLV3vVIATobozB0kOqGl9Tk6dCcNpmW56Y+xAOdC/EOMAIZ4?=
 =?us-ascii?Q?5Qw6djGK2MoNKuCMTn2MD9rIfXTjd5z9TSxvOwwSaym6pN2Sf1yTpEC9t3GH?=
 =?us-ascii?Q?WYQGP4Y4xYbFGhRWZX5VuW1Tgk+VgrAmWMh0G5HG4vBWH8Su4/A5GrHhqFXO?=
 =?us-ascii?Q?tLEeI8o/qxuE3eE9ewSvCCqS/XFiNRnlMyYiIVRWFczLv6tBhSNW+VCYxfwD?=
 =?us-ascii?Q?mRe9Y3p6RG/dXH2xAbEECb7R+2S8dJf05ETkmA+QVdX7OcgVidYb/p5BaRUJ?=
 =?us-ascii?Q?l9nwgUY2P9BnRQqka6x3KoNRqzYEB0+vytzYd+NevB1KQzgZu8fVg5OwwyYI?=
 =?us-ascii?Q?M/ryDIIKeXb/A3XPynN+F8FSnGofc8SwvOFyLZZYXpt5URuZosTbatxKfMtr?=
 =?us-ascii?Q?q2/JjbLdwM962MApWw0oYRQizIV1fZUWC3xl3bqFlddc+YDbEE+mysZ+pGBX?=
 =?us-ascii?Q?cr7h3P37hxWrrseKCAnq2/eh6+hU5VXXktS0grKZ9Ny44mvEMvr21c95E8/Y?=
 =?us-ascii?Q?Wk6pyHQH36/IPyeEA6/PG7K++xq1J07/NTnvjuMoBj+UfTfUokrmdA8yCo86?=
 =?us-ascii?Q?ulXDInzkK4nH0R1D2By3f7T2oQDa4oL++jbUMrDeWbrbsLS9Lr45zaggz6My?=
 =?us-ascii?Q?xdo/ZLwtZyrRq9tAnD4+Y/vNsCt7DjUJyspxSlXQia5lWe/HAuKSYIrLWfvz?=
 =?us-ascii?Q?BeNdkytrMw5bFrwjJeRKOt2e27WQFZ7V+jKe1jffNMnbHpYTSZUsIqJuzXfN?=
 =?us-ascii?Q?Dx0QNwkzyXgOYoQ2ereSC3qmaSewYQK9mPyV0TMn987cJXrJh/J4iZ3m6yU1?=
 =?us-ascii?Q?Oa8Hj3MzMzH9AiBXblVuJyFbK9LCSmk98mBXAB9C3gXSgFBJW8VDNwEyHY6y?=
 =?us-ascii?Q?a4clrrU8EBTa3elYEWK7JgtTat5dY101uU+r1CZOu0dC7e7N9VtJGKEaEoxo?=
 =?us-ascii?Q?wOxE1wORejD6UplARyjIJUl8zXfYbRLuYwS8JvMRI7dmRFmrUNrEc6jS2UlM?=
 =?us-ascii?Q?X5E/SzAoMvZglGHWwip0Tmog2NFFC5v8kgxgMoWFh1OKwNmDjE1oc17HSui4?=
 =?us-ascii?Q?hYhI8gf0NcM/KD0GtmpX7ou1SH5JaidKc+WnqXeFda6T2D1vfUMacBr1/x+e?=
 =?us-ascii?Q?SEWSnZhh+S/1+rGwockm8g8EdD1TuLyh4Ub7VW+C8Kh69BOptQanN4YUUoVS?=
 =?us-ascii?Q?fIfGVnRMBTNMdXaoDs256+CLY5Pwk/fC+mWDqjhjOfNRF0GsRPLOmtZfcjG9?=
 =?us-ascii?Q?Sg2qcl0p1cT3yeaiJsfCJgLKktEFOSgrH0AH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omH8Y2Kj9TwE4wWWBuM2/2xtX8OUrPEYtDUS1NXo0mZ77wmowrcXEibTOTP4?=
 =?us-ascii?Q?b3NxFNeQ8gKgCTPwyAMAs7cYK3+/TPYouRS8j9aoMfUZtXrNrZPAqZSqtnrV?=
 =?us-ascii?Q?Enbx9ikPoRAhWqjQwfERcNmXbnG5mgZVdm32JLALVKKit8N9cjp1808iMLZk?=
 =?us-ascii?Q?lzHORQGWRLOTZf4GWVLSh1UhicYwAY8EyHxeRRamuFCsOQ5GrnfPNjBFQprH?=
 =?us-ascii?Q?TagdYlpbRY3otoCVuEqK/C+B7mesmT3MK50NYnczRwYKDxDQgmX3yZufrnlI?=
 =?us-ascii?Q?58sRPmhVWQ1unP4zrCWKRHBgUXzIOtQOarYCTBkIrsJZPmbSqioH6ARVF2dB?=
 =?us-ascii?Q?eqYD1Gizo7rn3yQ2URoliKgKq5jqRbO7or4bB5oFQhBkLxi4/AN1cHZj+Hcb?=
 =?us-ascii?Q?XJ3q8lHVDdD3xrjs3lDMkzNuLkIrFuA8VU+ZfqIQYUAueuIWfMyuTKuKJCGc?=
 =?us-ascii?Q?hTEF1WwJicfZN0bx0kHqDh8w7O8t4eYTtH/pIzJGU5JyMpQqIzWXMKOFBuCk?=
 =?us-ascii?Q?PcqnDpIQrYwJQ0zuJCojLE4DE3WOR3b0YBY1YjpMJMhBtZfYAXYuFnSZR0Lr?=
 =?us-ascii?Q?T7pr3ZyubjzQQgQi1RtRuxbUcVUzixtE2/QwOGhQuv1u5L2UFfllYwvNTOLS?=
 =?us-ascii?Q?bnABiLE53FUHc4el4IPLMhEppDt6T1ZyBv3iZ8UuEr+tp0euFsPMtH/MTAWD?=
 =?us-ascii?Q?MRX0Sxb22HytQ16c7AH1oMJW6AU+v31FXUofz1rfpeE5na3ER3QWvR4RgcWm?=
 =?us-ascii?Q?4EVWJRxFFYoc03h/qvCNPyQn0k7aKa6zvHy4qDJm9m27GJ2+KPIXrrlZMkkq?=
 =?us-ascii?Q?wZSGr17IjPNx373jGEBTO/hNdk6TzkXmgJeKHVSB8LBWJQGM6w/QrRiRWCbG?=
 =?us-ascii?Q?FMsrFjlA+XxXOcr2Kuhqk+jVYFp+tCGOLKMPaMlmX0/7wslsiiAtopD3qr1e?=
 =?us-ascii?Q?tRYx2VdM+WXjVyewGfXca08nSCwy7pf5wrSc8x2m/Jj9wi/j2yKxLpDv5M13?=
 =?us-ascii?Q?JE1PWjDaO4HnwPQMfmWazmsVNtXlQ5P+YVX1ShtsYTiCdPyv29qTGe8Vz022?=
 =?us-ascii?Q?L15hV2dujQpc/p3izlOXN8fM7jDvxt+gCVlfqqCA39WMecikCk5CzBXuiSqA?=
 =?us-ascii?Q?NOSGlPzEsrTsLEzvESztsDLlHkqhFOZoMlQvzB2MKEd0a1QN6fDQ1fCMkNdL?=
 =?us-ascii?Q?yTcn+XUlJ0Mt8hmbA9SP9WXi/0IDQc46wReMhphPIAF5QcxbeTuUIrSb7SaG?=
 =?us-ascii?Q?msbLEVI0Grn13WqXi+sezGJTqZHVaVuEg6UH6yJDT8/BScslPK8Xu9JzOeWQ?=
 =?us-ascii?Q?D+1F6hBeGqjCGbNPjWlZQ8bRPYaA0S7DIU//9ZYe/Sx0wKwllLaa0uWq2Wf7?=
 =?us-ascii?Q?tqyiF3ow7XFQntMmXScIoEBFHXRVE7oBeC2dKrDHfH4udWsf3R/57TXcpBWT?=
 =?us-ascii?Q?9fpDrteypYjO5cddAYbbA83ODLLhVb2ZVJrpXcPacyShaTCWfzlPHJYpjau5?=
 =?us-ascii?Q?EW0hcsviNnjCnthPutYV/sFAs47xyEE7u0rG/1OHSAbg8iJX0VCSnVV0MmFi?=
 =?us-ascii?Q?eX+61E7DuywCRRl++Owq1byStm+IjEEfA/UPH5z8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fb6832-baa0-451c-b994-08de2bffd941
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:51:39.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNVwoADKPlfhTfGBXZxBtp3PKDd3r8jLsmZ0fLaMJ+rIR+Oh2m7C5ANYMXhMnrtKfG4qQa0h5EZKHjP6Lfvwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

In the current driver, PPS and PEROUT use the same channel to generate
the events, so they cannot be enabled at the same time. Otherwise, the
later configuration will overwrite the earlier configuration. Therefore,
when configuring PPS, the driver will check whether PEROUT is enabled.
Similarly, when configuring PEROUT, the driver will check whether PPS
is enabled.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index f31b1626c12f..ed5d59abeb53 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -128,6 +128,12 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->perout_enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		dev_err(&fep->pdev->dev, "PEROUT is running");
+		return -EBUSY;
+	}
+
 	if (fep->pps_enable == enable) {
 		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return 0;
@@ -571,6 +577,12 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 			}
 			spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+			if (fep->pps_enable) {
+				dev_err(&fep->pdev->dev, "PPS is running");
+				ret = -EBUSY;
+				goto unlock;
+			}
+
 			if (fep->perout_enable) {
 				dev_err(&fep->pdev->dev,
 					"PEROUT has been enabled\n");
-- 
2.34.1


