Return-Path: <netdev+bounces-120782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB395AAB2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D527D1C21E1D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819411C69D;
	Thu, 22 Aug 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qo8GeQ/j"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B61CABA;
	Thu, 22 Aug 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291506; cv=fail; b=fiHEmvUuokfzRhZuJWokc4Dd9vGeQl6O5E9BJ6UPClNFx9RdysMb4H0yAvLcCnzv+fbfakrnB5Zy0YP2//RQGlJIVmOPQrkeXvQyPxA92AbFj1B8I7JfYN9Ud64YdXztdnUL49PXrO/YYNUw8T+VevC1UPFa+4tHlkTB64GMR5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291506; c=relaxed/simple;
	bh=krjabZrItxZuSpnJEHnNjYI4p46yvFnh8nRzoRuWKD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxZcSeR92BFwD5NxrjcJ7BWtoU24yUb/rqwejGoHbMdhdUwiBHdt856RXrbpVbHv8u2Z0XzgUqJMnRSqe4nXXYJWMI5BfLz9ePMpRRxY6zwX0tDE0LqN2FoFQIpQR5fiWQdE4WCblhEA+3JJx1+5Up2WimFUcJEKruJjwedTTFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qo8GeQ/j; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjKBCZ8cQUvn69BhqhDbifh1cUqY+p6RorNVs95VlzF4Q71/uLx2tCuwTCMrPHwdNupco1fkexlDoE0Tk2U/DupgEm/ZzSvQDxKTChrvhdtWmJ3gg1KXrvwiF3BlmT5Eb7f1gWU+ppkvX7R/T3hts9pA7bYHgadRJUXIFJUNTX79/Ux7TEiqD3AiyfuwVjcrWMUcGA9gYnOK/JgoJRrzfJWZRWAv/RxIjYHSgXgkD/sfOJZdtUBdYDHWQdKJ2vAbX+BDYobxugQaz4HBV20tpoLSuev8kW/fHeY6VgP/gZkM4MOwiOkRKLeSwgP1bQAmsFXTpOP5eEEtGCb22HxrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdla1s9zd+RqA6yqyRqxusvDJtK53eIoswKw73+45oY=;
 b=qtSrSf84Y1XsWLnYvFUTlOw4ZZkYQ6wZ75IMUo22owopbQzA6jSp7t7NNsDr2cDyacK4uLt7JUjNj5shKxb3+E8RkxgC2XfnegttqaY9i3nNeSh7XVjMyd0gkUjjVhaR5kfCesygS6NdDHHyVcsnDEG6C00hwheFIcr2GLFhfOTsAy8GUODiCGRAY9GPUVz45qFqmffF8wcf8M4BTG+IPH4H9ZciMMroctLwWp8HrskhGtb8oaErHm+JQ35mpd/uPVSU2UMFZEZQ1hMhLPPanmk2u1b28rfKXhQLsFfWeCGm7KS/Zw+q95l6OfWT3Zyn/2URPaEKuf5d54fJcd/rWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdla1s9zd+RqA6yqyRqxusvDJtK53eIoswKw73+45oY=;
 b=Qo8GeQ/jKaEB3LPQWel0JcziwThGeh3TNlpmtCauOVXXefn8TjA3FatEp9ThRvYcqn3RJ7vbhGOfF3jkwOvN0GkuGsrvcen4JvD8DfZFeTbM4BXLH2P+80cryH58h63frOgGFT9G7pM2m2S1sSEvAjlbV1rzuLs+H6LMEq4LjFNKjXsftVVMYMp5owHNnXm9rArE3dqobHiLpb5mNumLxPGrpJMGCExUYcw67gaLHZIOkxyL3yzVeciHzQOuWMpGMeQdLueari0oBbW7AawfqpArOySn5bQS/FBxDCCKPUe27Cs/UiVR8FbtDrR51bwLwlu3f4NNZHFvZEPN2W1QiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 01:51:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:51:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Date: Thu, 22 Aug 2024 09:37:20 +0800
Message-Id: <20240822013721.203161-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013721.203161-1-wei.fang@nxp.com>
References: <20240822013721.203161-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 232a03c7-000f-436e-ee89-08dcc24cf831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zVgFGbDSRD/tnn9s30PREYTdTqtObNuja40i9N4h6KR0Lw6irq3nTEgRZ8Jy?=
 =?us-ascii?Q?NDHb2tlLz2PeN0rDmawQumxTJ/t4faPuco9RpuLfIkLIcA+x7jxVGrjyUaRS?=
 =?us-ascii?Q?U68iM3A1Of2JoMes1T9i7Jy178KjXVeU3rK8Xh9h3rR5Mos8xcYyZBE+Qu6I?=
 =?us-ascii?Q?NGVcvhS/p5sZcAX6Jb2TSuADag+/1U94pUKwta3dYHO8tyPob+gy2fXrC9FV?=
 =?us-ascii?Q?cfb6y5ohacuIokQHFaYhme3r/3J8EcJ+3p1q73ntgR0aNjhh7pF92OiIdxQf?=
 =?us-ascii?Q?+0YIGAHE9Bd0UNWRANMvqnGxX3Kt9uLAbh/a98sfrneBGugEBIkRjocyf6E2?=
 =?us-ascii?Q?0VC5K7OOMSqUhEJf7oq6z678AY6EH0YhMdoFMdOZPzs3sTP2hGhugYF568jd?=
 =?us-ascii?Q?b0hDohJQ7hfLRVprbwHC+BvWUERswO+hEpkAxMjPb1PQ44Kat0qVwCa0B9bn?=
 =?us-ascii?Q?zOgw88QetVHHN8qx/oXD4Fy2pwch4AjREyqsnYdlizcU6Tv2RfIQ1x9nOkH5?=
 =?us-ascii?Q?RymG03OnMGuG2rXFn+9s2RDYgvv2wO9TXmrEA/a9gDGmTNaas5Gt7RyeKdyO?=
 =?us-ascii?Q?+TdVLB4CQ8SZx5cIBNq1VW3ct86W7uc+ccTJmErnF6SK0HHk4hbkzen+Yx9H?=
 =?us-ascii?Q?bYRSAUDv3giuVGvceAXEeKYFezFRaTqTEU1c7GuBvfIfmgG/uFMaRObK5MgG?=
 =?us-ascii?Q?1wEXjf3nOMQxZuYvL+piqhVbuadwYZNA2+OgDCSQnIPMNtppxW0iJFYH8Ogv?=
 =?us-ascii?Q?tbYVPJWwNZXD9e3VYRUb0y91bHOGwYqJkEOmvTcibD1YagH2G6oy5r9qIoSO?=
 =?us-ascii?Q?O3SumQCaRgXbEUkCbTRZOw0bcnAry+WajVmXwdDHPHy9azgNqxDEG98MHMyM?=
 =?us-ascii?Q?4AirH34HNxNX+F6OkMJ7t3vz2bz2McBagxFGtTUfDIFfABmQZEuva0wFgvE2?=
 =?us-ascii?Q?RIuBuRLTpukddZYUP5b+mOpWyj1/+owW93nEwVs9v5dKG/TmSu0zBUjJgIQA?=
 =?us-ascii?Q?HTbcJ/uH2EI2mZoeQXtngI8JEgv+pbeH2XC5HP0gG1EUh/9tE4TRWb658UVS?=
 =?us-ascii?Q?GzTbaIefrWGz7++h7T0UYi9e8pqiHXS++dDGduWCc4j4Qm/ScT25cntDRQAm?=
 =?us-ascii?Q?KOVym+Dd2jsyevjmhhWKd3/GMU0AJVyd4rVnAly3jexr9ydKR8FhHFlTOBSn?=
 =?us-ascii?Q?NMy6F4WOFcXnRQ3z9/RUUqHfNhVHlTocsGsJ0MsoV4BrqWsVCslVXyIcmirz?=
 =?us-ascii?Q?lJALPSqBlz2vdNU5yUU4bIyAGPkWvrhhIDty895OgzHFlVz+Y98mKrYId0VD?=
 =?us-ascii?Q?rR10V9nMaT7LmjGatPsHQ5SMptrvIEureyyTxnD4sCwJdMFfqUV9b6/mW5Cy?=
 =?us-ascii?Q?gKzfiF/DKD9usHlSJx+s6jcbDvnjUXl0thoZzV49npl/PfaPpSED+xwkdclw?=
 =?us-ascii?Q?5lx1ICFxmGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3aNtTexaDFH3e6x9nP2+EZqTht0WM0t3CcvKjMUBD+kScrazjldbWhyUgrO?=
 =?us-ascii?Q?GMrM3VFVC1T73mV8sQxUD9BHhNsFakzUxqFHRUGSbHNFt+HZ04Wlx0tcPe61?=
 =?us-ascii?Q?mBh8c9OB4T/LJzuz69K4WwVS2WtB9HuHDKhLniaUdS7j4FyB+cE1Cf/40lHG?=
 =?us-ascii?Q?8coXVG0xV5yvqyTchhnSbGZ5svAi1Nm0gsaqp0P7M10gSHjhg9e7JA4E/kez?=
 =?us-ascii?Q?Cgz9jr/N6Ug6ggubtbwdW50p84pRWjVpvBQy3YcADys2EeM6DfdYMGXQ1D0P?=
 =?us-ascii?Q?SBw8Fp1sUgrXqVR1bvgrILi/NUgvUOk2tIq8Jvp6tHX0DeNIdp1XPRTJg138?=
 =?us-ascii?Q?boSGQa48ljAHvz1QyST50k10SWS6xYSzXlC4bQX2ogooMF1kMjmi7BvOcwb6?=
 =?us-ascii?Q?Xa1vP3z40XSGxKs/CTgt6WufQeZalOPj22yd0hLu//wSAfQ2leMiWZRaVXLk?=
 =?us-ascii?Q?ku60ONCdieJW/BLdkHnCTyk4EGuuxmiNXwTvTKhMSsuzbFL15aKgF9Qr0kwf?=
 =?us-ascii?Q?TR0I7w96UX6mFjMWIQXLqdM7/PzXSCLDuLofxYfI6cx0XHvsOghJRGZSv1Q5?=
 =?us-ascii?Q?j93U79hx77pfRKGKsxj9r3KDhtRgmCHuis2wvVRL4FCBE6D0I77ZPqI9TueC?=
 =?us-ascii?Q?tseUIyygLazwCAPGHSf+actVEafFg/VKsvSKxbC21QgNXw++jW8laixhCj/2?=
 =?us-ascii?Q?4ZGYXFtjcc6TWdAdnBfnm6sUKxF4+gOE41ZgwV9tXnGrzUjf5WgByyeBn8MQ?=
 =?us-ascii?Q?trSU+mAZdm17gmUXV8owqnwefOG7ilFa4Mz5qCm2uq9jhBQCg+Oja1SefcCd?=
 =?us-ascii?Q?y8uMychwCKrHZkU0NKDgpWQwvA8Q/S58KpwEUntU+BWnxyFB+OxvmZnEtOBv?=
 =?us-ascii?Q?VtntXDJhZEpcd3/Ngif6e8fumc6TY0RMJ+/FXVyYtCyblInLwTCE05oBUvcR?=
 =?us-ascii?Q?lSK8+bC39+9Nr+I0NA5paRQYs+ByZEZPafN+q/pq7shZM+I64iZ1wMhStQ6C?=
 =?us-ascii?Q?aLgxJaVFMAaCtSzjJrbWq4gs0reX6GGfybRG6td2DStceCKQtvSYknb5/3z+?=
 =?us-ascii?Q?2eiXpBmzNbHwXVUqu5nvFETuDLWrwUDqyr8tx9/tX5gCHsfrQ1Jqp2cl7AKY?=
 =?us-ascii?Q?hjaVo+U6hyFuUWHwZrnsapnkGigL0V1jOSULmKc6ul/QlFZ9/aCFabGJkX6i?=
 =?us-ascii?Q?+RgiT4hbr3+WLQXT6S2+R+SuLbvMGXIoWT3YZT5uoD7xhX+9KCFh1UuNWUDx?=
 =?us-ascii?Q?5oUnR1re4+k0U6W5ucnNg5igXkREIKmTr13gDrVxy9Ops6XWbJdzz8B1LH+P?=
 =?us-ascii?Q?WA/YEah3WvfmqM/T6x/1ZBzof/BBQpSyCyoW078LCOIsiWOQ/4dzQfnKGZjR?=
 =?us-ascii?Q?NDi6OMaO4+Vub4nBkTmgU9JrTdfhOJt5XVqsvEgYzDpXCyu+ESc/nXQNE6Z3?=
 =?us-ascii?Q?TnoxWis32Eco4AqN+rY4NCRkYU+2zlwvP1jObjQ6OJd8NNoK+GU4Cl9DR6Lt?=
 =?us-ascii?Q?fEdu1TBgSTyOw8hKgv9nSgQnoiFFSXMwr2XZUDdwGbHE0U3VIuM3ucqwQjVR?=
 =?us-ascii?Q?Gr6gixG6CDym6fF64E5G28DQbaDq1GLR7OAsHG3M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232a03c7-000f-436e-ee89-08dcc24cf831
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:51:41.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRMRSefrNkX0nB9VSgtq+zo1q4mgtAFVVKlZD+Nk2zTX3LwCIqnvVRRqId0h41vUa8w0N+T8OusfzIjEP6sang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755

As the new property "nxp,phy-output-refclk" is added to instead of
the "nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refclk-in"
property used in the driver with the "nxp,reverse-mode" property and
make slight modifications.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Changed the property name.
---
 drivers/net/phy/nxp-tja11xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 2c263ae44b4f..7aa0599c38c3 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -78,8 +78,7 @@
 #define MII_COMMCFG			27
 #define MII_COMMCFG_AUTO_OP		BIT(15)
 
-/* Configure REF_CLK as input in RMII mode */
-#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
+#define TJA11XX_REVERSE_MODE		BIT(0)
 
 struct tja11xx_priv {
 	char		*hwmon_name;
@@ -274,10 +273,10 @@ static int tja11xx_get_interface_mode(struct phy_device *phydev)
 		mii_mode = MII_CFG1_REVMII_MODE;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		if (priv->flags & TJA110X_RMII_MODE_REFCLK_IN)
-			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
-		else
+		if (priv->flags & TJA11XX_REVERSE_MODE)
 			mii_mode = MII_CFG1_RMII_MODE_REFCLK_OUT;
+		else
+			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
 		break;
 	default:
 		return -EINVAL;
@@ -517,8 +516,8 @@ static int tja11xx_parse_dt(struct phy_device *phydev)
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
 		return 0;
 
-	if (of_property_read_bool(node, "nxp,rmii-refclk-in"))
-		priv->flags |= TJA110X_RMII_MODE_REFCLK_IN;
+	if (of_property_read_bool(node, "nxp,phy-output-refclk"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
 
 	return 0;
 }
-- 
2.34.1


