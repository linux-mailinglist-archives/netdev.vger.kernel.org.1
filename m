Return-Path: <netdev+bounces-207394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF8B06FA0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B417F3A5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B6293B7F;
	Wed, 16 Jul 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N7kfYoKL"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AE28F92E;
	Wed, 16 Jul 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652321; cv=fail; b=hnbO+x/kUWHtYw8Mjh/tivDAmf+l6dAfBpq24vGCpKgxCPrDIIhZBjxGBLdMqBSZLGt3QuJltzWiEwgu6cWVKR59Xnz7My4XTMwI+GYF7UKCig+COC/t9TXCZof8PU0mz2rtD+K3yDlQq4K5w+ZxExez52zBdAjma5fmm/epXAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652321; c=relaxed/simple;
	bh=wQ09XO+5HT54vDAV1KulzGo9SFkIJ8RqyxgMYV0TaQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfclynGiMs4WaPF7ht2lpULpMG6RCP2+TdFWkRqocML8n+FtfHZFWKszR5nu6n6K0mPttwww+QDo7sJYmb2FRmBPke1IgGw/j3Z0ZBZ8kZRxDIQmj+lepd+M8M0jRkYFkuZWVDk4f2JiE2bdLSH2hBc/REDBf1R0j/ISfoZJKHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N7kfYoKL; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv1Pnj2mhQH4GFARXEibRlUEGtTfZTYIn/DU4CnQfnRmYHw2JOLcuJ/6AMYZUt9FXYL7M3WFm58Q9jS7CCkASbj4T/OdQ964gmBEOPLKpmQNPMWEYQzcWchV5PfnLk0Qy5oLfWfQFFqtRPDBF7Mm2g9U1hqgR7gsFPgPSG2OXR9PYn3S1bLHhFfKSF7nQRSyWmS76WQUkfDMMK5U5WjjfnOyLyDRWnlQkLa37yKnZITKO8mGibOEPrGryOUpYdO51J1bjqYuFgpB3JqPznaY49T3uUIkOW+U3uVFEtN1Jd2YwcOSDVqdDS4gSLC2Pxh6KHJs7B9Tc4dLn6XX6l8Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUFc8ayVBkQRLS5BB2rtikJU+Tle5Ovzrw3xvB3asnw=;
 b=PcE8CivZB8D/vzF3TQBC75lVoS8KkXMvnmwqWtWImJsJEpLhYpKvWTO/1+gOATYe6tzi548aNEPbOs2FFp3SfmFvkY25B3Z7SlU1LFywZdgAE/ibyqDwCEKFZjP2UEoS/3Xc8DJIb58n5Yn/zeAax5qMNFEfuUO4ej0rrLrjLDEIu0Q6s4blekMlZYsndDA/il8ZEVDrmEd8qaOI0LAVVO6qCwd5fyCzp8QhayJitGGlLrl5wxMMVdB0QyBGK1rhksR8yLuvwp2JCHadMiwyL2OeLJ/MBcbXohUA3NkYtRTMMU7l0/++ayvYBzWFoXz/tx8sREZt2CrSJOLZJ2vtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUFc8ayVBkQRLS5BB2rtikJU+Tle5Ovzrw3xvB3asnw=;
 b=N7kfYoKLMA4Jqcz3IKRdgJaUrNEtlEuwfsMzI/uEOrXDWRTHvKr1kdkBVh+dx/VosQQuqA+oEGxPZfBvU5Os738CeZeoFYN8YbA49MmAwlqnQlZZOqnrNsh7NP+/ju0vYIUlCHfQiOvo1vumegYnp5Q6PdLXHI+yIpg/S0Yoa5EECbpZEmoIOYlv+AjKXUafpmA/Zqvv+RncQ7A1VN/2lkTaMsxUSVn1BzgXJoNPvZmpnPlRm0Hjq0/LT6IVmzyOVV77mtwRjlfj9hOEgZdE+yiAPaBD0TZfNGNak7IO6SXogdzcaH1xV36Ii0H8AoLh9r/Fp0qYJwqkZ5Za7huZhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 08/14] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Wed, 16 Jul 2025 15:31:05 +0800
Message-Id: <20250716073111.367382-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 78be02c5-946b-473f-048d-08ddc43da2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROD6+HxNQUuDFjzSa0NS1+uvzHHTfaWAPXkW1jpHKMZ404ydV4SQzcMrl6T+?=
 =?us-ascii?Q?oXwc4f0G/LEKxURU/G0VNHk5QFTCMjZXWBk0Cx00bMmJK8X4vGgtzfY0iy/5?=
 =?us-ascii?Q?qfdNipCwJwVjy6jtWd35HSseBSQXYVnPI0+KMGzc2mcArsD0apTxQzZ+6gjT?=
 =?us-ascii?Q?Q2aEMdk7ESDV4PFy41xUAX51EZE0eeLk+khR4mApz5cDAKJnqiXN/wf81CYs?=
 =?us-ascii?Q?Zrpc76tmJZgbaIZSnNZj6swDxhKhVS6x9jlBAMpnGeuTiBjlECW9purc0sZb?=
 =?us-ascii?Q?Tce/nhl+PLzUf+Ju2VeLBC8VXXC+qfzpP43/a8f3ystWlIRkNMiqnM6OhHGA?=
 =?us-ascii?Q?QZPmZSZB96DzOWz9Ae1A9wvfrdIiC3houHjvfBCNJbDFxrGYo8DdsUZv3pvt?=
 =?us-ascii?Q?yWMCeUcVeEMAkXTgiPqzD3P+R3/uaub4lmdbiiYPbTek7vzpGdLs/BDJnAo8?=
 =?us-ascii?Q?QX9bCETletg4D+zwM1SDUtFtwfX7s2szcuZGtrWIBf4CO6p/swI3r5vJO0uW?=
 =?us-ascii?Q?NkzmpIr80T7fKshvok2IcPvhvwfWXcFWdA2ePXS9SgOxX8FMv7xzQKmQxhEN?=
 =?us-ascii?Q?MNiTli5+1lueq/5szXxfa6yJqkdj6yQG28tY5pGgJ95++egWrGV6bTIBh0J1?=
 =?us-ascii?Q?7BNpS7eDN86CIxHXfoWpDfHQtBzNBw/PscnNkJ5nfn8NHfCJyIbomdJnAIjA?=
 =?us-ascii?Q?o6pVr0Dt2M9AUKb79jwQ6ww8ASkGaUUHi816QYH93VKSCia8BsRek/UBj1wt?=
 =?us-ascii?Q?WrAIHcFywOuFRnh16iwyo7u3pCqVxW6CkimKgJE3gqiyxIhU5V8W5TZElzib?=
 =?us-ascii?Q?9rn6ROcoW2QLDLxei3nO8xCb8jnpEiNE2hlV42QTCx1wg8MYLdEAS8OJC5Ab?=
 =?us-ascii?Q?OM1qVWfwLrPdNxbfq7wrrWy8xxmicpU1OReKgcwFDwsmGSmgPd/qR4ULJWfJ?=
 =?us-ascii?Q?Ztuze1yjLrjNO5hL3mMq4qPS8KxFovLUJxouZt/dVsqAmsOaH/6iVxII+nTN?=
 =?us-ascii?Q?Vo44W1CAGw7R7wDOohEt8T0a/dE8Jv+0wgjBhj+IuywgGV4jT1KiS1Q8Nwg1?=
 =?us-ascii?Q?OysSStb/+B6KLmldsV19FyjaQ+wx2s+Aa7YDOw5BLReR10tMdlIQpykVNcm4?=
 =?us-ascii?Q?vDnLq0BLk7TnIXq6Xar6paA6x4MZxeXoJX4wzJm4K3w4uLILmM88s+WzQsKm?=
 =?us-ascii?Q?ZyVRTFQj1m0Iws8dkZAntzB9XutZR5LiWAF3Kqpl/IUJSEgzR1+h75/dJOY1?=
 =?us-ascii?Q?mwAoF4OfHegzPSypz9+yj3chjhUO2zkat8xfz2XGZtRIujX5rx+LCQKBcFtS?=
 =?us-ascii?Q?7uPGfFjFpfyxeo3Yn0CbSMJZcS2pgDco6XriX/gzVvIqEdQkkOBWNjR7ZHEx?=
 =?us-ascii?Q?jIqWo+/56QqCWAVtUfSTpi1nMY4fUtpBbLEUzIQRhGttT0zfcUNM3dVO+UJk?=
 =?us-ascii?Q?xoq6e5dI4DAEitShdjEeBjfx+96Y7e3K2R6k88xI1tYsaVWw0WCsQ5tvQkLX?=
 =?us-ascii?Q?qOxU4/17+hi/yGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VDsq0sVDcnKgJOVZU4gZurD07IkAgbKja0WDBMmvBd3LenIXSQ44oTQVbSYd?=
 =?us-ascii?Q?Y9iHnIqb/dhS9JKdESwBJAvIjgdXMB6m/7yW5IyjP8zxCbOraT+3KSRJdVlq?=
 =?us-ascii?Q?GUfKUvcCyMQx+udHHLhJfbYlrd4/4597IfPJ587AJTZIHbDCoI0ZYElrDo0E?=
 =?us-ascii?Q?b6a6PydVIyhj39yaJqxAf9JCCG+8HSXFwWgtxyK9HWFqCZUz0AELJrYHiM30?=
 =?us-ascii?Q?xMkugS9E5wWtbOgIK+hXs2Qm8w/ccLFAIN2UJZHLBQ5544rK1WbHVHwOglxt?=
 =?us-ascii?Q?nXz+Ezmq0ufhejfbIVEIoy9FgZ8ia0om/gqKXTzgml7P0+Z/VoYWFwrR6C6O?=
 =?us-ascii?Q?qOe/Tu/3+SDhHnoCvw5TNwImYb2O/IAa+am32iZgLHA+2h343196/enpx7Ai?=
 =?us-ascii?Q?Xt7alskgkEXKI1XZ1t9BkYBhdPjVcL71Tx5K84dlrN58eVii4j+e1as49yzs?=
 =?us-ascii?Q?4hVrXjoFXm/U7CPH4i9HwZV03we000GBbWYE80PSaY1H9VoJFUdv61XJy8wM?=
 =?us-ascii?Q?FXeUA3ZlUNqZd7fkytJDjHFAm+Fu2gpX6oq4vDE5gxmYM+LyqqzZGm/DmDtN?=
 =?us-ascii?Q?L0O/cKFbcTUpp5DhMI+yd05VFApdoqFeUnqtxy+SlobC49xm2wLp3jNhycFA?=
 =?us-ascii?Q?HxyhGDnYLVmqJ6BrJ8NYW7Dkn3sKIcmJhNRHiSEMtfuqHIVP5gHnOtN6O51r?=
 =?us-ascii?Q?aPr/99AAWWBW6Yl4NXV9B1130r3cdjTryPLGUSB+rEKIEIgAALelAjN3m6Ne?=
 =?us-ascii?Q?e+UvAr5kXYj/ELXESHox5fToPbtyBb+rJpQwNbL6WjT7qcPlmQRaQaMqdkxo?=
 =?us-ascii?Q?SMiu51JV4my8LEKfwIqWESPDuaTUYYvFGhqBygSEkjbNsYgQ1oAKE/hv+Mw6?=
 =?us-ascii?Q?kEGaEzF7pxJOuoNhp3mpeOH8hoUh697uKXmkugQxcoK2Hq2KNg5+8vuAMPIE?=
 =?us-ascii?Q?Q6GnZyPjFPw65WBT1m52I5me7xDmbQ73dqUfAWv4yvg/i288pYrtoL9GbdOE?=
 =?us-ascii?Q?Bmcc/OLJ3rntw5gUyRgDZC8W1Cydb+KdFfp7C9EN9mjn6agZPXRMf25njLfy?=
 =?us-ascii?Q?7ju1A4SGuy02BqW+iEbakIelUkdu1KkIAzdEK+TW53P82oD2A2L2IP+zWcNT?=
 =?us-ascii?Q?VLjawzEGKfp4XDrRPFkDiVb+lJfwhv6a+NlsEepowVgU866yi/kRF/MJaBY9?=
 =?us-ascii?Q?J5GnNB8+04GT96aMBAwRU3HpxZZRAoS11PuR4gRcw6G8ugGyzSX3LPbAJnCu?=
 =?us-ascii?Q?47NoCOnhS/6YqBAUsRUqK51GU4DH2OjjCG41o5sDSdUYT62E8nXO3zEQUSS/?=
 =?us-ascii?Q?vPoI3FoO430Vr7gIO+1+rSaRHMkyuPcdEqMkBa/v0D2JusCb2alGPHIXXMv+?=
 =?us-ascii?Q?542+oSk31y+3OOqV7RQ9wMRwU+rSQGqv+R2T0bo25o4HFWTGMc2qQUkkVSAh?=
 =?us-ascii?Q?MfvpukWFgwTUAjF+ToCE/hXTSeZaguxuKSWbtbKHLp6ke6z4EJNbMGaENZan?=
 =?us-ascii?Q?QDjGxG8c4orHpIPQCdw/hn0NHlgbBtUNyWSakxsnPFaL2g2mjk2W4RogiJpy?=
 =?us-ascii?Q?5e7l9+8T98llz29yChWq11E0ZB2ekksItEe3m40m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78be02c5-946b-473f-048d-08ddc43da2e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:56.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olccEFCwWXIct/9wo7ZA77i6JrPg7NooWPclKkhZOKpqA9ifqpFi/65v+uneQk/Hhqcvw4xbPFnOpd+moat9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1554f33d0ac..dacc5824dca6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18005,6 +18005,15 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


