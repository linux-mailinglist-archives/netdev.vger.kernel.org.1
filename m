Return-Path: <netdev+bounces-207393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B3B06F9B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DD017EE4E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD12BE656;
	Wed, 16 Jul 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxA3Wtdp"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F92BFC7F;
	Wed, 16 Jul 2025 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652314; cv=fail; b=PXeLw3FPG0+NVfwi4nCuDJcEyqyCjl37OwXL8OMepGbLoZAHj9IF64wukpHqtVCBhIDu2G9NCeYbvw/TINb+OmRUswNSKiWlvVOF0vFgbY0EEp9QbaSJvL8F+Ee8i1l1DsKMQW4g3uKxIAw6mFMGsPqaXOFWWOKqL92tCVNi9GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652314; c=relaxed/simple;
	bh=Ban871rJOonZRXYVUFLR9yi9DqIe1D6KRKuFt9c/fiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4Wk4S2WooyQNQ4NAGCggGC+c8RH0JrPMt9S9j/FdK9XtJkeSaW4i+JNu3i9khsSlYyAafUVOCyeALW1/nXM7gIT+GLiMf0iGpHlKnY7FXOS8972pDLMmLPCIKmdabeFbQFtf4a14pN6M/R/c68vhgLg0g6eEJGD2E4IDs1LtVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XxA3Wtdp; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AecxGTH7pkVWB8ydDg/CMBFr3BVsJq/654G09mj3VUFm+Db89z4NIG38adsdQBAi/GqyYHJkgTC2QbnFA+XjyX0WBEus7A7q7AeWDYaVwdQMm6XTjdKsEh237NcxuCnGWQLuvGCd3//Rb5Vl1rHeXL3jsS9ff3/Yi7vU/DGmNbT46XkKDx82zFsBE9lTLnY3U5EOF3DXmifUt6I1UpKttFpBhBehMK3kGJ/sclZTq+u8IPeMAyZsOa+rT9uY1j0k28wR33Cfl0sI7OM3bCjn8K8MFTlNzugx/VnVdK7c0bUwenVw9+ux1YGJwbDpZd5fWDmU9kxF5iQlgH4/fhu+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s48lPOp13YlsO5zvysFjlOaHymUjlsL954mOmrO+Kn4=;
 b=fQfb+m+fVP+ECFXTT9sMat0sUWRpPwgPzbG1gocTaCEAmJreGgocnMW6en5ryF1e6zQx/OytEqolWm3JIEzrq2XYsSD4tXc71YppXbnvbbYBOe+QSSJ9O1H5zLEEP97jUS/e9sp3kAy9LkN2vWXpufcMnd7sJAtYjOM8t+keFfcCnz+zOqGUIYGKdO37upWwCZh+HyJSHMIHwj9xM+xHlFpq6mAK11mmXEkjKLd+qggSsa4vLxcI3PxIkRpctX1Kv5VdGlKk7QohW6Dn83X74R4gC3+RT4ce+Su2+ESZ2iCy3OzP/yw/RLvP797yzl++FlUeCJhjkXvZ2iPG1tv9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s48lPOp13YlsO5zvysFjlOaHymUjlsL954mOmrO+Kn4=;
 b=XxA3WtdpujjhkkIE0RPdOTCiii55Z73AiEw+HolPFShHiii2qkOrJfk8mz+4xJortg/LP1LyH5meLDwhBYwsa/wDWcQZGJAspSPhl2Q/L++4BbYnT5uctO/Hw8IKdHe/Qa781sGTRC3Mlg5tc8Xey2Pirl6KEWqzihd1TD2koaYfAP1dJkELVbbCQRYjkuI48+11RiwuN+vdgK6sxt7XqnuJ0fdX6j0Qt0kzrA9YqmGfXznKxRF+X0wp7aKITpXSVCi72zFx7lfK32F1Eb0fr0cYFblNa9Xebdt4F01LVkNbOdqQegucBf4Ec8pjpJTjzcyg+b3Gy+y/6ABXC19K3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:49 +0000
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
Subject: [PATCH v2 net-next 07/14] ptp: netc: add debugfs support to loop back pulse signal
Date: Wed, 16 Jul 2025 15:31:04 +0800
Message-Id: <20250716073111.367382-8-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a0ceab-d61e-4cd7-6e94-08ddc43d9e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4bwCTjdEjKjJrSWpoKLFYTqbytV3eeB3SzyGSTSoxH6KfwY/GWIymMQ5cUL?=
 =?us-ascii?Q?T835VZT/i+zGNYtCZUmEwyVRtKvJeV37nFWs161ueJka8syPFV3wOPDPsLpy?=
 =?us-ascii?Q?34gcfEH1HQdV76IBK6kK4/oM+sYoqeHDktv2bImpCZdaMoK8rM+/T2YvRAXE?=
 =?us-ascii?Q?WV9n1j1Em6LAeM9NhXWTqWpkdplZk4ZhyJ7708CYv4q9YwIfuNmrVH/rHyxc?=
 =?us-ascii?Q?20+mzPup48m1PGnH1ApK1w+wS0bWQ095TeSqDdtuRpJgGOCliw46+safLCqv?=
 =?us-ascii?Q?RGsYZXnl9YhDQ3K51L9mrHPzJQMkD0sbY2d/ZxMR3zROoDXdDellSb9aLG9M?=
 =?us-ascii?Q?o1vI5TXwRWueAHItEYt190r/sj5J/QWbjl3ZoKwXk4ILKIL2pfdNzmuJrzXD?=
 =?us-ascii?Q?u4i9UU1jv03SNK5sBxQjWpE817c+f85y5dBLbq1zUxDqpJce5qB5Eik3lZOp?=
 =?us-ascii?Q?gqCfRvratiS7P9SFrJE1qfBvygzlG88l2fksLztkJPdmnfUa5SReEXlOnBFJ?=
 =?us-ascii?Q?ne7uwLOPXsmn4FPPvPlX1S9oJEkQJ6eidW8dUdNyz0fEieJ4vcDz1JNKKdWX?=
 =?us-ascii?Q?RwIMfItj6dV1hN9okoWlMivo5HyVspFHNol34eFF2RJku/Fjlk3LfEJkG5Ia?=
 =?us-ascii?Q?oJiCSeXg2+i6ZFZ6BH+M81eUoYXcT7iPPkbbBBmwAYm9DdEs+mtz7oGQwQfv?=
 =?us-ascii?Q?9E4kwOIHGDV3ehkOqfI4p0KpZbhN8FGKf993ng/Bi1utb+f6THwWK5YOm8Hw?=
 =?us-ascii?Q?pNufzTdOby/apou/y6YlfWJdchIQYUg95dNoQdIFvv6vDbUGlgJzkRNnyfyf?=
 =?us-ascii?Q?NjB6R9Ecu7irl0Hb+Ft4YE76lI67c11qiRYnMqBYE9WYA+eHnQBq2TG8eZBf?=
 =?us-ascii?Q?TAP6TErNtWMGy7WCFfgC1a6/m+BoWyfKQRlIb+Ec2fER9F5UscaHf9g8QPj2?=
 =?us-ascii?Q?LSFWCZUUG8nvG3v2dZ6z7oHqXCatGgDWqBPPKnhL4cR0lHT2zvYbHxlhdXFG?=
 =?us-ascii?Q?WPf1CzbnVWROt9+l9xWJL6ioceaWPSeGjBA6+XppPKLIZcLF0CxsU7jBz4S7?=
 =?us-ascii?Q?j8hkJlrwwPtjogUhUfIi4cuxD11KpnM0JMkpcg9FOgqdAObSFz87FwmV1nfu?=
 =?us-ascii?Q?se9WUAtSv4QbnYR5nZ+CvmrORixmuLh+pdC1em2ql0oE0e8iJaXvs5ZLMAqO?=
 =?us-ascii?Q?5bzHp0Cq1HYZlS3tNXc1Z+RjZs4YMVF+ekkQgvF6J+Uapb5NTBqfrCflW2fW?=
 =?us-ascii?Q?NjGkVUNWF94nhWZEXnh1RGoxoav2BtOXoQFYviLDhcnzoHL2rlvM0LUMFkEw?=
 =?us-ascii?Q?RQCcRChgu9njUbYPc/0jODJKTXB4wbuc/YpNNmA5mskLmqHgLMYdEcC9cS7G?=
 =?us-ascii?Q?mYwHdF3Wb3FkwuYFjVnU9S5SZA/OriBGKIN5fFrhF1I1u+F4no9j4hSPgcfp?=
 =?us-ascii?Q?AEoyT+cGozuoYCdp6XeF4o4J49uzm5xa/c4WFar0C+dcVPt11hLjznoG2lvs?=
 =?us-ascii?Q?TPLOPNPHmTxT59k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nIKMbOZagx0yhvDxv04y2x8UCYwFtobxVjvymzBM1EElVfKa3tkXUk5eBH5D?=
 =?us-ascii?Q?GZfddqCxu13X9TNUL3xSmV0jSNJJ/nRvX13m3glAdnpRJwonqVJZnUpVNVCG?=
 =?us-ascii?Q?pNkAphEJAPh3cHoKVW5Aa7A8ZjOqO0iFQ8s3wi+S+6yoJZ8jEqArs7GGi9VS?=
 =?us-ascii?Q?w7iIFLYiExzi3VsyWIEXPpHmgmfwARRLF8pzeCOJz0S94S+ZJDEyLVj0e2Kh?=
 =?us-ascii?Q?xK+nxg0RFlPgQXb1wZu+ARQ4HXj5eMUG9Dz2UhKpBxXPLcB5QUg/R4FSDZAi?=
 =?us-ascii?Q?RR1Jd3xMBMt//ABGca3YYnEh2jJQX5szthPBtZowtcZJwv+VQGMOz/BgrzzJ?=
 =?us-ascii?Q?/ria5GAUyL9zx3LVeYXWDIT6NOwyIGK3kr0VuWGlpryFLob2l8uy59ANRTwa?=
 =?us-ascii?Q?eB+SV2DhisZEjIN8+N1hW5sikkvM1kcXHrfKUf+ctyYjGihfgOB2wpgtt6jM?=
 =?us-ascii?Q?ftWNvZ3zbPFNPmXXuh2exlbmbR6yo2RcnepDn8nldUY1jpU1Pd45oZWYyNkB?=
 =?us-ascii?Q?+VIhWQswYfOKIlBY56ArgHULBJaRc2bn8HWGB+B9bgNoRAiKVN2k9j2wHD4Z?=
 =?us-ascii?Q?J1OqCaoL6HHqkI5KyXNaZG2le4ApsivBorIct/jJFGP68VY+Sq0tC7C+oBNF?=
 =?us-ascii?Q?n1YSGbQYq7lUny1QZkSlPa5O18q0VVUrI/3w224/6GuwgoLWPgNJh7TtZUV6?=
 =?us-ascii?Q?eBJw6pxdJE5wwoIluQEhJIeeg1Z8CVDZpTVR2oNZpKPhTbJyBn+VJKh3ck++?=
 =?us-ascii?Q?kncKYBGJGQmNhTMTxtyqiVeIwELoyrJPFoFwxg5tHNVuELJPgltpJXxq3rDv?=
 =?us-ascii?Q?xpUfX8zBxtuc7+HYdx7kXSZK7L6UGwfDC4ryFddvKzA1JdPSMXULo29asv4L?=
 =?us-ascii?Q?9ax40KuiDNVBw/xayT5E0b3vBQg6pMujL5c59irdRlMrr0f8/jUmefNyKhk4?=
 =?us-ascii?Q?IgW4rv7j4hQenhl13pm68rdB6n1yiYNcSzB5b4FlaOMOG8NQRXyirUO9QAxE?=
 =?us-ascii?Q?8dUZAn7Kbb34f5Qskm8Tc++JGGYXRusQ31KXerBbDojcU1KBd8llXth5xgZz?=
 =?us-ascii?Q?cGTPvJmDZgblr+Zcl4L16wYjvOUp5BYu4fXyTM+u2koVq/rEB+dO70IsIEfw?=
 =?us-ascii?Q?Yy6OX70qYET8SVnAB5g05v3Zvwq1IOPjj10eHAh0G0MWKMT7CZ/jYyxsueF1?=
 =?us-ascii?Q?CktVQ4SFR6HowsaDmWDexedeKs+cMvNWywaqsGS8FjX98jt02XrkxcMvOupl?=
 =?us-ascii?Q?dAX6GeoU4jx7+F2NrvUCtZSrbB4DtgUeCUCp/xjnEUkpu3IYTSUo4HyLi6x1?=
 =?us-ascii?Q?szBPB/QGSR9GnjlxNXEHL9sn0KqFTboQbwIYDfMnZLamXF++UoCTMxXoa3Sd?=
 =?us-ascii?Q?jJnBvZ/DEJAZKPNDGNp4QegK3wlMmBB5cetKhyTUrreUiIWK1zSkQqPS8+kU?=
 =?us-ascii?Q?iQDnlvQWVf5ss3zDrfIxWmXeN2/JNmbeo7uXVn1oc6eFi9wbQ68UodMmAYpd?=
 =?us-ascii?Q?Tnh6WQPrrAT3GSEMnV2eyZ8597bVF0b5t9DQISqCaMv4JmjpHKnC3bQNeUHt?=
 =?us-ascii?Q?IDYZz3SpuVLqnqTRnjxn/vdBtkObl2WmkfLKo+Tp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a0ceab-d61e-4cd7-6e94-08ddc43d9e57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:49.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXozJeolCQJFE8vLIuDvZR6PeIxZX6sHT2hFEVKCyleWhGEqq8j4FK585DR+y6s34ve6CpvHVgEPAFnabNsssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input, so that we can leverage this feature to validate
some other features without external hardware support. For example, we
can use it to test external trigger stamp (EXTTS). And we can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.

An example to test the generation time of PPS event.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 108.000000018
event index 0 at 109.000000018
event index 0 at 110.000000018

An example to test the generation time of the periodic output signal.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 260.000000016
event index 0 at 261.500000015
event index 0 at 263.000000016

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Remove the check of the return value of debugfs_create_dir()
---
 drivers/ptp/ptp_netc.c | 114 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index c2fc6351db5b..2a077eb2f0eb 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -22,6 +23,8 @@
 #define  TMR_ETEP2			BIT(9)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PP2L			BIT(26)
+#define  TMR_CTRL_PP1L			BIT(27)
 #define  TMR_CTRL_FS			BIT(28)
 #define  TMR_ALARM1P			BIT(31)
 
@@ -129,6 +132,7 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct dentry *debugfs_root;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -991,6 +995,114 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
 	return val & IPBRR0_IP_REV;
 }
 
+static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 *val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	switch (fiper) {
+	case 0:
+		*val = tmr_ctrl & TMR_CTRL_PP1L ? 1 : 0;
+		break;
+	case 1:
+		*val = tmr_ctrl & TMR_CTRL_PP2L ? 1 : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	switch (fiper) {
+	case 0:
+		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
+					    TMR_CTRL_PP1L);
+		break;
+	case 1:
+		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
+					    TMR_CTRL_PP2L);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (!err)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 0, val);
+}
+
+static int netc_timer_set_fiper1_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 0, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
+			 netc_timer_set_fiper1_loopback, "%llu\n");
+
+static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 1, val);
+}
+
+static int netc_timer_set_fiper2_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 1, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
+			 netc_timer_set_fiper2_loopback, "%llu\n");
+
+static void netc_timer_create_debugfs(struct netc_timer *priv)
+{
+	char debugfs_name[24];
+
+	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
+		 priv->phc_index);
+	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
+	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper1_fops);
+	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper2_fops);
+}
+
+static void netc_timer_remove_debugfs(struct netc_timer *priv)
+{
+	debugfs_remove(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -1038,6 +1150,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	}
 
 	priv->phc_index = ptp_clock_index(priv->clock);
+	netc_timer_create_debugfs(priv);
 
 	return 0;
 
@@ -1055,6 +1168,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_remove_debugfs(priv);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	clk_disable_unprepare(priv->src_clk);
-- 
2.34.1


