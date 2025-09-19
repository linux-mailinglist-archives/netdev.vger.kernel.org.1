Return-Path: <netdev+bounces-224703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41792B88833
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359585A08A1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97252F7AB2;
	Fri, 19 Sep 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nhRxXXb1"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10832F616F;
	Fri, 19 Sep 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272825; cv=fail; b=TNXk5S0g4Wfi5dZt3CdThaLdkqqA5QfXHXZmHl+hHtzlNhUAMYWtkYlfr/vlwdUs6tIeOBjPwIdkJgm8VDrYioAsJa2TCviUdRC+N2cKt7xSvWxrxcP6ZPosiZdkda6nyrhl3QG39CG0DR4TOm7ABi9oL9mbuwjlE13deksb57U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272825; c=relaxed/simple;
	bh=cvru7PPTsznTacyurxkBFwi0Q6nHJdSaP7t06uTlCq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhU0DMtm1MDpi3AuHmNzjuCzz1FUlQgGp2y4x5dOb/iP+nijGcN9zNQdVHrgrDU/e331XA5Di9Mchm+AaecHGYWRItLxtMqwyb2DvbMrZIOUo+dUbR6GaOVCBekl+JEzUa6V1aWgnKupsOaemwxt4ERtb8dPE8h5WR3FED78C4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nhRxXXb1; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyVKo6l5TFtNcdud5DL8den9Hdaf2LVO6FeTgFQ20DDWu0m1XrfrdZSCPDgNa+dokpqe/paZ8hTas/fcuCq2EwUJq6V9SsTdBeLu8wjvZTnQfFRtvJ1YJJZlMYf4OLTs4KORqPbbg8pmvHKcJIn6yO3SehWCmO7Z09je/LCmQYjpPnRJc7bs5PL0gpKI3YRT0tDh4q/S1VOyAOAu8hW6h8AII7B74zO8+VZiULSzsFnV3ChiJbiNejG3GsACZMJ3KNwR5v8zIQE0KsFCu5ERiWVKBhp+uy6OI45XD4YEWalWNPuCgJ3QnX6hIYoogMdhFxWiBl1ww+I0KfvNZTd0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KExr4hh4cfW2ao1N4OlIDN1m99Yxbd8N1KbwC6htOl4=;
 b=i5vT2AMIzjY+s9f022sG/MCAvnTPPVtUyLnclX6vsgZS6Os4meg6AjWbhRwj5TcgiHbMtcO5iYbOcKUoRQU2n8QiKV9tz9JTALYPG9HCo5T8C0A9CVa/PAC//Ijbozma445oJbQ6BuXCUycITO3sbA0J3oBh7pZt3lQ0VUIS7PoaZKnbZ0TBJEiuOgjcGLFqkX8R5X+pGBNHtvIiFxY519nVVz3W/9/Kfvu5EtUwT/y1D4snJxfbciE+xOyScHj9C9SiqqS7rmIymO2obYmqyOtwB9HSCLYporcgY7LlXmRkpsso9oMl9Hv6MyOoiZGxFfCF6jBCA6QRD67kB3KufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KExr4hh4cfW2ao1N4OlIDN1m99Yxbd8N1KbwC6htOl4=;
 b=nhRxXXb1ECs2athhqIfP6Pj0vWVtYxTktY4UF9yjhyci2XOO2oMTcza62Pf4OIxYZvoza1s9g8GLcm23hqCJsGn6X7F0pO7mz32Gad5HKu5wAjiRTLooCbiVdxqHuVBKohsoGxWNIesQx1wSvlz9227dO+t+dGzD3hMWOjPMbvB0wctUozfCHf/FE9SpiccpwmAxov3debCJ/53ZW+mb7Gxcv90fmyGGsCAzwFMDBKNVY85Li+0dWCGfGksOvO4Kxu8JGcfUS04AJtIUbNn6BcbA1V2MDrvjI4dSTmKeoDk8K3TDKKR3RFvQBgw8L1ytUvNlb7/vdE+tyBboOybE4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9713.eurprd04.prod.outlook.com (2603:10a6:20b:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 09:07:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 09:07:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	yangbo.lu@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/2] net: enetc: fix sleeping function called from rcu_read_lock() context
Date: Fri, 19 Sep 2025 16:45:08 +0800
Message-Id: <20250919084509.1846513-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919084509.1846513-1-wei.fang@nxp.com>
References: <20250919084509.1846513-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d82df1-ddc4-4ead-ae49-08ddf75be441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hloI40m2XV3OUYaFA0ST4+abOSTUMkQmPjTMSqUMe5yRqbhH/BrCanSRJwkx?=
 =?us-ascii?Q?DQpyTPFvsAMVd1JUpdUxYQDyMqzFBr/U6VGRb9MPaelEhtPwnUP4lIz5g2ha?=
 =?us-ascii?Q?RRtKrLlLMWQZ0U2RtALUJUBiAYsft2mWePWf5dZQ3iK0xc79CteTeJJoGwKJ?=
 =?us-ascii?Q?wasOd3JuEcp3lpD1IbvUXJnJrZYdaoIQ6KVqJrRuczm/DPf1NJT+isiIEXpj?=
 =?us-ascii?Q?sRMBCbmp3XqpDWl0n2hTm9weEdBUmKaB3C74p+cr4BtkA54kfhP/3KJo0vsr?=
 =?us-ascii?Q?wDnhI++2VK/MFsYoo9l6aO0Zpi/vpth+1ODYHrmCKUPNLqmTiQlDz9VzuuM+?=
 =?us-ascii?Q?rOXCkhewQ5U/afqPd6rgDqGOjeM+IawX9SfJLYz+XEpRJ4Dtfzga2BEw4ytz?=
 =?us-ascii?Q?x0VCMK29YZkvun36aLHBXgCT7CXz8n09kWU8SorSsWLAYi/5CJGGF7i2uRqw?=
 =?us-ascii?Q?dNlxuujMvbAHm8JYczup9hb2VG6vN98uCTSTjTPo5iwm6xh+7pjaVohKGQsy?=
 =?us-ascii?Q?2aoJuZqGdzBNw0TTCrTRJZXd97QWTS8wum9ls3WmKmEq+tx1k/FsqqYbeHtf?=
 =?us-ascii?Q?S4bkeXrQVxWwNo/IbvHDjlsc0GeWf8x8soEJB1AzfHJuXjLDTcyRO14dYZlK?=
 =?us-ascii?Q?uF2hOU1jRiRsYZmEdwYsNdpjkdr24y8Ml68ZXBT/p3XjPEdZ+WRZZnI4Qka6?=
 =?us-ascii?Q?BECLYAo/ke9cU5ln85LVK5vNWrjT2oeS0tTwPis2eHCAmUwpTFaLuiSJBquW?=
 =?us-ascii?Q?5JfiTrJHw2SpftT3aG0AIEY5P18I9PFqFloljD0cnc2+leHADH/2OvnH8YB8?=
 =?us-ascii?Q?Aeiz8y2VyIX11O46BC7r0kDFx+eSzBg2o7BkEK6SxrptShXvpu44SgxQpHib?=
 =?us-ascii?Q?4w4Yyo4JM/U9Y6N4cge0AFNuBJTadWiAFDVFySN2PWYDTfFYLN/7ITSaqJGk?=
 =?us-ascii?Q?v8k9yPsHTKvDbd4410lteuFKwiDv9jKEuGPOwytNsl8HLB/Vv0O60rvw8PeV?=
 =?us-ascii?Q?GbWKC59m9qyqU79epRvZ4Su6FQkqpZfHukIG3ail1QhAoGlBYedA5y9sPGRc?=
 =?us-ascii?Q?dee6Gk0Zbc8p+0MSwo8RGjffXIXTuJPZB/yFjEuD6NsuXuaLyaf65P6n1MnJ?=
 =?us-ascii?Q?BTMDxThJ1zZv8Fn5flkG3PwkQBcPVWs2veVpAy8KDGZlJK6YmaPmJwMovGn6?=
 =?us-ascii?Q?ui4avcPSZs28x0d9ED47iAbtQnc/649LtocDOXZhT5RCvWkwI2ZIWRs9TwQc?=
 =?us-ascii?Q?0jrvhS6ZWImjXctlBnSGyP92sZpTzL+YXlWjy8mbamHhLkh2ShrmAoP/g4uD?=
 =?us-ascii?Q?tJc9SkF0/vrYvTiHvm9egoVH1VXEaNXrocDLrOBJmWRyv5TkHezQndmLmYjY?=
 =?us-ascii?Q?IFYOvtAUzlrJ6QNPqeICo5U+E4Bc4oqpwRjg31IFH3Wo2W5CB4VorvtQup+/?=
 =?us-ascii?Q?t+0Cq/iji7XjHJug4lJ+OQbRJzlpUV7R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pAZ7oeJgstVMWhtzJf2EeZ3HHG6/LRxDfwKWIiuUMGATwR+gMVw7eFZ6LBPK?=
 =?us-ascii?Q?3HXiflb+XjPQISUERfKL+V8mJXQ/7L8VT+g4sgddgNoDaZToqA75zMZfKqDz?=
 =?us-ascii?Q?ffJRxTaRnltWJjUdxrZsjocEPT9u/47zhWrvpIUntMG6cTeMGi00wUknAUVB?=
 =?us-ascii?Q?t7/yqus9iigCAblpVKbmgl8Zgl1mLCPKDUBZg1DKLmEUYC8zhlovTJW2ucrk?=
 =?us-ascii?Q?auOvGkbT96/7/xdPYWoDh601C7d5EEpWFkgX63JiblC8+olPiSFc/Fh5NTkK?=
 =?us-ascii?Q?H3hNM1qy8ncf4flOO+ksufTmvINaN+EYx1MAozC4j0+eIV/p9wG/5jPfFYrE?=
 =?us-ascii?Q?TWj2CTWdidZkrFPA0w4xgUV2kOzExhKf+uJkbvYgZPN+NAGSKS/bD7ea69OM?=
 =?us-ascii?Q?KzJg1Tf6SX6LBnIALi3XrqCo0yhJS+QnmjPcC0ay/4cGxMachaXA4yTuUG+h?=
 =?us-ascii?Q?UJQ65w4FuUMavo7y+HJ4asLDS1OXnyb+Kf3pUFFe698hqG0WkKVtikGw+0gK?=
 =?us-ascii?Q?m0SQ7FLBestGtBXplLNgk2P9LTVYuIW61nxbFSRIkqg5jXkR8IkjEiVEYoN0?=
 =?us-ascii?Q?deCMHTOuGlC4r6iQQfseD4TJ21T3B9tIet1sX+dQFlndigyMPR1/JfPwiszx?=
 =?us-ascii?Q?E33r4Z7sTRJ0IRzcVBaMMt+iYPjMWu7Eae0D/GT5qYSPVnM6zKPGpEimhUe9?=
 =?us-ascii?Q?WJvgNWP5DqVxH+im64n/awIM/VHrpP0RHPdmvFZEdHtJmhyFEnAEn0ccXBPp?=
 =?us-ascii?Q?wVdf32plsjFZnqAAnFrQwrFZMoRrJDlRzGUDFktCOy7vPsoFObF6dkjsxTkR?=
 =?us-ascii?Q?3REAUIvHkEOmJzivIGB3o7tgaf/1TM0XN83RiEr2cUOm+UTzDsLJwkAC4Xhf?=
 =?us-ascii?Q?3QnUuG1mb9wiKCeG1REGK4LfLigz5RJ71iYWxjN4EP2F2pSRl9h265MX0GzM?=
 =?us-ascii?Q?OZQDIudtzqsuqaDzQjg72Re5XNO2EYoduylyTEvRtCtEMY6miLYW2WqJOHrr?=
 =?us-ascii?Q?CGA+pJHL5XzAFhf0bUQgqp1GOCq6vSewpOCtNTvgxT6rGIC4e4uuinNtoqRg?=
 =?us-ascii?Q?nreuQQ4cCaUO60cVKXN4vVPapmBmLQK/oSAlfpbZSs3u4cQTcnflikdQbhyH?=
 =?us-ascii?Q?ucNSWx7A7UCs8lbZnl1Jw2zs+yjD5XKtOdPfBED0xASxBrGIbMIU07U6IbXS?=
 =?us-ascii?Q?7sd679WbR+8V2QtCpR1wOsoo9J3kCKm1dHCJibku7DLX+lYDtkDVIW/bQ/nq?=
 =?us-ascii?Q?weHuSNIju9OdFKXhQ1Ci0VWq6TVoah1BS5ui6nvqvd/OnvaxBEhvn85Iuwc/?=
 =?us-ascii?Q?m4yoBR/6lo8vQeBISgLnBE7MCHZYYA9KbrfppmpBxsTg7SH45tFq+O3Sowm4?=
 =?us-ascii?Q?ookyuoMa3lcjlI+1U8YkRrOE632lTh9ywbY0ZQX0Fk48RGVc++RLtwIVbwrG?=
 =?us-ascii?Q?u0ajoqPHqNYAn82ZVc5H9ehIN1RzklpoGz6xypgKF23UpZyHV83ccYz3Of2L?=
 =?us-ascii?Q?ah2kFhcEa/ApoOR56Lbqp8hqwgqHO3+gI8psw1q/gozXX+FMZoIjvbzVUkgI?=
 =?us-ascii?Q?meZhEmN4LjOWe9EK/BZZgFdv0FKmu5uLYTDe6Bkt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d82df1-ddc4-4ead-ae49-08ddf75be441
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:07:00.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTGa8dxf1a6MoNu7cDhOph5WPotvErZPOpm0ALCGZ983gVbnbPRF9xKWFJfksHmWU1FUtBotipE3zJ7S4JZx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9713

The rcu_read_lock() has been introduced in __ethtool_get_ts_info() since
the commit 4c61d809cf60 ("net: ethtool: Fix suspicious rcu_dereference
usage"). Therefore, the device drivers cannot use any sleeping functions
when implementing the callback of ethtool_ops::get_ts_info(). Currently,
pci_get_slot() is used in enetc_get_ts_info(), but it calls down_read()
which might sleep, so this is a potential issue. Therefore, to fix this
issue, pci_get_domain_bus_and_slot() is used to replace pci_get_slot()
in enetc_get_ts_info().

Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Closes: https://lore.kernel.org/netdev/20250918124823.t3xlzn7w2glzkhnx@skbuf/
Fixes: f5b9a1cde0a2 ("net: enetc: add PTP synchronization support for ENETC v4")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 6215e9c68fc5..445bfd032e0f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -895,7 +895,8 @@ static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 		return -1;
 	}
 
-	timer_pdev = pci_get_slot(bus, devfn);
+	timer_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(bus),
+						 bus->number, devfn);
 	if (!timer_pdev)
 		return -1;
 
-- 
2.34.1


