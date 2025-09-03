Return-Path: <netdev+bounces-219581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61833B42092
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17613687716
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BB303C87;
	Wed,  3 Sep 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KF/s6joq"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D630275E;
	Wed,  3 Sep 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904888; cv=fail; b=aZq9YN7tokYi25invPr4deINwsXFWSpfptaiOTGSRpUoh9hbmzJ+yc9kH3xN7HJoc0FyZtohucN/wMFfcTOO4acv/jPPnFkTo/CFx90E7k4PtIddebMcnMX/o9SwCIog8VQyb2mr1jB9I3UkoO3F6gOtmruOK++L0WHdwjXLSdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904888; c=relaxed/simple;
	bh=4tbTpnrvBATwhmfZU8v8gjxI0wUx9hBP763j3p9kVoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHUQB8Xj9eKxFiZ1M1GfVJO7Ue3tkuvRH143Eief3K6DABPTOmlJjZHhSLP2uVeJirNhD25xt/8+9gDHqeT6Ek/9AavIa28liCi7LfjtEtljRNq7vqb4fXezG2gObeYAXotw521McmiiHAp7qkyKTkm4AEIqaNnRORNEPlLV+Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KF/s6joq; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGYLalNf6rpXEPYfe8n8Hj0GC5j/KNnTYbBT3QTxjBHnjLMHc6GiIXA0CiOhha1RgT+x4awckvKnj8y3KPkRsp5vLt6tu5zlOqxHfYPzPJomeP4U0P2FF41BGy5RwPLA3yLJJeQ9qG4x4FLQ3SDXoInAOAmJ/9dt3NXWu4us/WWJXtKB+l6cYRDzzj+14aABDzgpp/qHlWCLVgCRNle0cNA3at2M5U1X9Zhqh5dYYlIr9ogKg+N6PhaEY1hgxeAVoBwf++6CeuEGnU3O3ci1FUU/uUTcd7scTHv5ifaND6RbczyFSU620nAX6VmVFmFvnsrTdKrjjkgZj5b+TKx72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpYVjZvE6qEXT86OT04zV9gSW5yIiQWvI8qePHfgTTQ=;
 b=HpN+2EyY3UxlpWJPC+17houZrMLjhMror6GFDg+uOKVRMEiR+3jBJ4365LIlk+xNN9w86Z2BRndBwjEw22doBoZtFsPEsqq7fUyhgCJNrjiTzkKqO2NPzvwtTDOYQMkRaBDqGcRO40TnGB7Mz9u9AUb9fJ+ajzyLRu8Au6nCjp8fOhWnkr+HGoW+Ppsks5NDA6QzFm3LyDgnaqIGvyu4YzoFWiyvHKW/AcrmpnIk3cFXAKBioe5j69Wg/H8PjdFbBgluB6aIuVZg0o1uH34UqH85W5/byZU71x6cosE1o9lNuI+eqGpgkCcHWMj81bRSA8gE6KcjVA1KnGR170dyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpYVjZvE6qEXT86OT04zV9gSW5yIiQWvI8qePHfgTTQ=;
 b=KF/s6joqKBAdwRJL9Cv2XiXoevSCh35Yh9wYeu2mYc7Hm6zfe8IscAd+N7V6TWcznzn4Xk2i/dSL4LKuIbvgFtUAM/ODpstK3h2+RCX9DlHwFrelZyIgJA5+6/bI8ludY4OU0tHlhEKGmeCgvQytDtONkM1Fvb1dKFmqprzM4Ktg3V7MCJVntchZHdexl/y71i/wkWTh+r+6EdkKosHw9qXY5EVZXkc0PGtPPr8i7UXftKSKW88bNfipjTKio3QeFRl/2m3VPAU7fZiN0xEHuXCGgS6XbKHYkc7SQ8J8WdShb0SIqeTvPSu5VQGf7bN+BCz/vqMixPF3KqIDNbkJaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:07:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:07:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: phy: aquantia: print global syscfg registers
Date: Wed,  3 Sep 2025 16:07:27 +0300
Message-Id: <20250903130730.2836022-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: ea361ee6-b818-46a8-8f8f-08ddeaeae6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfXid0Xut1Nx8pwLPLkiL6vbatwG2lxQoQlICsA8rGx7r3gFLy+/kzYXr7Wd?=
 =?us-ascii?Q?Jt9jv+TrZeFmqvuCBr6cYQoaJJeuC1np15wm+Hx/Kqc4kwUwaXA7641CKbsB?=
 =?us-ascii?Q?Ct0J/F8c1f89KdvxrfAikv/gGm5D5CmbG7B8zuF5gZ72Rdl8BW12cnHXfkbX?=
 =?us-ascii?Q?GT8JJ5FIaszUM7ARoMjP8tLt2jKVKtuhPKReqimBeeo29STQvGkypZxzMLq3?=
 =?us-ascii?Q?Q26vHGztITed166h32t7/vHYxlgib11m9WMQYMt47OpLV/6G+seWBO9cxPrL?=
 =?us-ascii?Q?tZvxZ+pNcocAMpmOCb2gVQnOYhv5cysMBC5BduNPF6a2rbVHL2fPH9dPiqEB?=
 =?us-ascii?Q?G5laiPx0fyTsG6cNrLqryXcRYxJVtKTw7qEV3RleoQwUaZFZTygb9P/zuCqE?=
 =?us-ascii?Q?Jl85a7KJqBJpsm+VWbG9r41v9pgv09f5aDei5hJBjaRvIXcT/3ZVJbTkk0UG?=
 =?us-ascii?Q?BqAYVmP817Va2dbOVd2HRtAAnvhiIW1dOw/gnNaq7+qAf4WalJl/OsO485Oe?=
 =?us-ascii?Q?+ain7k1/sjFeccgbb1QY4+8/99jgkuF/jduOZ9WjbsLVY9hB7NXqzl0bdmI9?=
 =?us-ascii?Q?dIb/rf/fq9jlU6GHyhFlK0EFX2IR7WCqchfI49Ezw7WF5WfFKisCziFB/A3z?=
 =?us-ascii?Q?6n7HxWj3mo+SNjrTxH57ko7Gyf6NBM1vHYHq90M0GdJ12hFdo9B3ened4lQm?=
 =?us-ascii?Q?/lNFa6403K1DfsPCPfFYLMcWfP0n8Ff6sreciFguFusg54F8kQacITRyeOrA?=
 =?us-ascii?Q?l7TL9z2M0ZaLvEB4IGAaXXfzTeynsE+auQGMX60ZnhlyRpkoHvD4a73BTYcy?=
 =?us-ascii?Q?FDEA6DwqOt+VoeLptr7Q84nNTGA3I/URzkAsCfBVsA1Fw3dfYTslHvtcaqdN?=
 =?us-ascii?Q?ARvVBQKXiA4lPb0dLQPdUru63TWZTCMf8i0pew5GTK9D+qrFRpa4vUlr8rfc?=
 =?us-ascii?Q?3Kx5mSCwZbKH+5mmjtULMTXUUpvFnSpxzr0iEihbLwayqiQWJFnecaAcAS3w?=
 =?us-ascii?Q?ZZn5p+SKQNVcCplxmUPNe33ggic836xz4SyijqVgtUZtiTTSTr+/kLIE+T+3?=
 =?us-ascii?Q?zMo6ElYCJGl5FzMgY7maaZq6CCGYswrlqSfKSbfNQNDVIVp59gqJ5ytmXUUR?=
 =?us-ascii?Q?GqUL+D9aHsj9bcCCSKGZSf9gaWkZ/Dncx8/R4QldIhJ5qlhKLlSp/HztZRZ2?=
 =?us-ascii?Q?UH62XJhidZDZr0PTO+u42q09wfNGNYRa6U/kEi/1cx39T1x/PRppt62lQ8Fh?=
 =?us-ascii?Q?URnZ3wErmrGeCMtVk23OP7zpt4SBJJoIBmXX1NIgzKiboiR8EU1y1rtKSrjb?=
 =?us-ascii?Q?fZBkT35YXHfpWO/LmFr1tRotWkskXkr2fUtN0vsf+TJtgQxLjaT+Sl8NZd3M?=
 =?us-ascii?Q?J8oHCgIh3XheGUAfurF9UkMF0MGW7Td4biUBh9fDEXd2bm1XluKMPEelLc2t?=
 =?us-ascii?Q?jU85O5zz/uh9RFVkQoc5/Ma6tcJ9LXenUA+P0hZyVN9lijfbTPewWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4i49E+kuq9xG7gu1jqF87bLPv+X/8lkIr1O+ux8svQJvypMxvuXbSoLx35X/?=
 =?us-ascii?Q?LiCzdYVml4xnQjzCQkf/dIqE2H4SGg/Lrast/FZd1R8P+kqroPOdhn1fFKCN?=
 =?us-ascii?Q?LpPV3kgyCILWtfb+xFx+xawYXEZK4Ir9zLa/0AhLPKrbovVoAW1PuEoG7HU0?=
 =?us-ascii?Q?6zRfzSPMbQhihVK3ooD92S41xysTy9O3GXfWXhEe9ihXoKRJy18hBq9au/Xr?=
 =?us-ascii?Q?fSAqe/+OZJkDwSCzYbK//nfvj8/oHFUH4prxVaIOVYPNPR5qn8DfF8McVvhq?=
 =?us-ascii?Q?rCsTsAHAE83UiZfRXJoLrXCXLHR8eNxSraXNre8C7ZZlv0W4USbjU5PpK6uB?=
 =?us-ascii?Q?3WyZWDwXE9I/MBSBSOHZZ2f+zvW578lMKGhV6zPW4ZdrMtiahcoaExrXIp4y?=
 =?us-ascii?Q?HmMmaNZOdl5PUVOXP/57ohPwC1H9zvOVWvRAEH7Vib898tqkC4fzdefx9azp?=
 =?us-ascii?Q?RgTh8SSpVzr3N5LqtPgYuig+vecCKOiIK0BPNuL2uwBbhwKrOJtYIaGJE/K+?=
 =?us-ascii?Q?zRRQBdXTHEFvofSkyQQBqUIPyAfd8H/VEbdsaFYxPgCF2jHA+lwTuW57MbRg?=
 =?us-ascii?Q?00I/5ZdYfvXZalnLEi8kVFkBYaso8/ildYyi0N5r65JuvpJyTep8Lllp517k?=
 =?us-ascii?Q?phEldCFcnSY0E03Yt6dIB1YqTROfCuLTNQ1S+zNSC1YoZLj6wFhoW1JDvfz9?=
 =?us-ascii?Q?0vdXF3c6uFPgGlH0NR3XeMVcNsOPn5RvcGTgMBzTBJAOU9TfAVJxIcWOQMOP?=
 =?us-ascii?Q?7FRTNYtpzKTrO2O1H1K+yHEVWwCDGn9UIhO4ZeRpEjRTXmYW8UOZ0UlN9Dx8?=
 =?us-ascii?Q?2GcdMJkZy9Px3Qrh6CCKQSTwH41g3fSMCV0vTGpv07kYPYDmSxNuQDCLJBYw?=
 =?us-ascii?Q?ShJEc1h1Lm5ZxvRjDXOZrCxSH6OnZ1r0L+cnLzC+FEg6/nMQDfIJm72S9UnJ?=
 =?us-ascii?Q?4INEW3Bk+akeRR6YL3ahZenGuuK0Snq/I/Qbef6Z4J+mGZXXB6ENseoamJK2?=
 =?us-ascii?Q?sq4EKqPAm5ufMd5qGBxu/zce+p6rDbMQT2fJAoBs1tVEHvgPWwEs98JfEeTT?=
 =?us-ascii?Q?pdANmEVuHRf9IZbtCGhUXjZXStUHRLEZTAEwtoqXZKueCAP82B+d2M1SksMP?=
 =?us-ascii?Q?m053mg8ZskQKyriwt6UyodP2MiumxDzAwd5lchhAE5CTG4e07JAs4lLtaeT9?=
 =?us-ascii?Q?6Fcrlo5dNX6hXVK6eyfX1IOZtz/cn/a1WG3RgxgEjZejHHRO5TWkpgg2HBBl?=
 =?us-ascii?Q?JQ1xacjoHOxkcsD9224sPlG3kqpK4Anf2b3X/ho1PD2IdEdhnqjVaHz65IOb?=
 =?us-ascii?Q?o58dhoGCieMJRglf/aT0CSRsW55iVfN+Ja4qGsYEO+exF6/6yrg/XLm6o7UI?=
 =?us-ascii?Q?21HFaWrPrR3FQEnbGf9XIrYN0IVxL7hTd1KjLxLNGb4tiqSxnp/rqqJnLtT5?=
 =?us-ascii?Q?adR+Y/qWbYApK16P1+k3nIqFpXmeGHutljmvpgBXkS3l2ns9SNsrDb4xt/QJ?=
 =?us-ascii?Q?r5uhxzIl5gASXTwNHrLSAavIe+pALqOrG7epMD0CBPDCqx0tzD+ffo+XC/Qu?=
 =?us-ascii?Q?kDp78Ttlf50SVP73tFeYxWk+a/UV6PhmTEJHFwBi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea361ee6-b818-46a8-8f8f-08ddeaeae6b2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:07:57.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2LI/75/F69nU6QTDZogeKvxjGU/JN2AIscTao0vwPb+UOJ0cROMxDsOA4tKiRd0F2Tk+Xr5SHY2R3TUiPuqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

Sometimes people with unknown firmware provisioning post on the mailing
lists asking for support. The information collected by
aqr_gen2_read_global_syscfg() is sufficiently important to warrant a
phydev_dbg() that can easily be turned into a verbose print by the
system owner in case some debugging is needed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 8516690e34db..309eecbf71f1 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -837,6 +837,14 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 				    rate_adapt);
 			break;
 		}
+
+		phydev_dbg(phydev,
+			   "Media speed %d uses host interface %s with %s\n",
+			   syscfg->speed, phy_modes(syscfg->interface),
+			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
+			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
+			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
+			   "unrecognized rate adaptation type");
 	}
 
 	return 0;
-- 
2.34.1


