Return-Path: <netdev+bounces-255709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEvEMbo5gGlX4wIAu9opvQ
	(envelope-from <netdev+bounces-255709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:44:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062BC85C0
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9769930053F1
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E452BEFF5;
	Mon,  2 Feb 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mdWGjjPg"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111792749E6;
	Mon,  2 Feb 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011061; cv=fail; b=m9+1KQx82sfQvfgGN2yyomYkwOAydeTwsaUdW8+MiShagMQ7nJgUb53R7JJa/aEeSUjr7Vof7g6iTtm6DM4hBUoFOeh0GUWtWoWB8/tKaLBpwFjaGMShPwVKs787zOy5jAZ0IMGQ4LsEg679n2lp+nB+iow/NRLbWMINz55K6a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011061; c=relaxed/simple;
	bh=SZ5Omk+GXknHpNNz284foDTcM09GSBtqTjriYPf2z54=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JFEN6ULZriKnTjpKnm+Hq2wnQLQkWoeA5WyFcM9xbXSqDw7gPeZtPemRtoMyi+k51I3rgPRFrD4wd2nM0hw+3ajW02nrWHt424K2KhMYpJtisRHE9dfVpOZcngrr/IjisPpip5tjJ22YnJ444qzDDVQCLQPy+9c8LE07GKYtS9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mdWGjjPg; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC0MN3uDpVKMiVYac9wx8cmX+SUB7QMxS0Xb/QlpKwfftrQrbN2VNoyOhAaA2Gj3TT75FItlROf9Qsr0P11ERvbWYG7BPP4AML0U/YCFYTQ88MuEEKE2ZrlV40vYFP1Sb0kqJixZ/xkFYhvwFPduF74PhLX+gs9vQWYYLyt75XLa4oj7aXsTzC/cnmZyhaesQTAn4xN4qxBdOiEPlwEUID+GYV8okt8aPwZgLfS8pfqWopuLyS8aFmN1Wq//wgKDlIjiAUiZ8M4P0e6vNj/tGNmbn02UYX3XWA2N+NKDhdICS1Jrg7e1M0aTMCunW0an2jfP2SIZrbVDs+gYVxxXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRoEtyf5a/HSz3tUBVochonxFm1QHJ6qWmepqNP2Mqg=;
 b=gzP7tmPDZizO344SpOuRLskpHf9znDx1z7yhALLOi0gWoqx+opJy0ReNPt13Xk/lEfV65B+qJdyK6pOD/oRBeHCPZjzbs35ItIqCmNMH8t0yeVmUNOBPdl629XFdwYJ01bWdp4X+MpCa0r6gmj7Egr7UtL5o5xbaZat5XOKcQDrFrsx7okSp1Dkf+PxM55VnsPu+JzWyYdAQFvbGlffxGyMN9vW4YnLQTwaWnPKa4necWiJAGf6qQ/wH8EcVMuprCE831w5zzCKbFySmI6WqdyoPN47NGSIVDalQsj4sHy/24iWxTsifo4xeHTzBPHHT5txAF+MDJjMWlYawQ/vNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRoEtyf5a/HSz3tUBVochonxFm1QHJ6qWmepqNP2Mqg=;
 b=mdWGjjPgQklbw/Hv1v/TKD88FBYMAf4jRAcdTuIpnC+tkhyP/32jMqAs5lBq91YX5SBbe+/7nuHzQq4Y7OFe4pZ7q8OhMIqPPKfFK+qGsjnSqqN7fhiPmfmLc8zSoJVgQn6lvi8RXRURoUo8TeWblddd8yOnsCxNmA5D63E8U1fbDyg3JKVqm0yt9LGQURsLto4LLoVvEAucx4Y5PFiXH/92SukWV8QocnjGDla5fjzOZ9+/dm3nZOhJmVFxT7W7VWJXsBHwfHEOuoEW4Fn+j9Vj4saQ5nHrM0wPJHFOfM6lAaSp3zsuoYgnt9Ov+IeEDsrMbuAbFTqbz7O7HJ/vwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:44:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Mon, 2 Feb 2026
 05:44:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	xiaolei.wang@windriver.com,
	maxime.chevallier@bootlin.com,
	quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: phy: change devlink flag to AUTOREMOVE_SUPPLIER for non-SFP PHYs
Date: Mon,  2 Feb 2026 13:45:33 +0800
Message-Id: <20260202054533.539883-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3e90fc-bd25-4b45-83ba-08de621e1973
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4ANLevj2AbDQ5sQNr02XMoaWK0DvYt0su0wBH83UIDZCV3SJmZH1Z24CUixp?=
 =?us-ascii?Q?EeKDdvZeyJvumnWPmL2QuukHpdHsUFBQT3Le9G/6EgsHGV6SFUFT4nvivXUQ?=
 =?us-ascii?Q?hF4q5xsZCMZkJwX+h7XbveqJCgKRlRePbCkPF/dvl3UjYLc8akRZLHI0Ja3b?=
 =?us-ascii?Q?OnH7OBeAMc/ybxFA8hbvgtWQFoIJQAmNtakQ5LUx/TCEVJruJ2eaKFN82x9W?=
 =?us-ascii?Q?5+SbDyqXN/NUdxZjeyluFTqXRB3+/wJsUIJ9Zn5tclWYoR22AiPvvyFf4cJs?=
 =?us-ascii?Q?jAiWq9RC5/qATZn0GXssePlGleuVB/g6j/w737xPYdn7TWFQfU7DB6eWQtOU?=
 =?us-ascii?Q?zKQ/Bg1WbGxnhTI5XZFcPVt8oFQMGo7lPg8w1lznfQTAGseU6haMsCQwkUI0?=
 =?us-ascii?Q?0Hoq6QpLQmunRnHkbbSn4/IRSZdSTXuJgx+yHeJzlJYzxDOJu4LUuC3WMWOt?=
 =?us-ascii?Q?p8en89kf3IoZdoe426eValADageJnTfHcm/DjOOwC+YltvxvB9rpuDDFxv/b?=
 =?us-ascii?Q?TBoVMgI/9nAnUtn6LLRD9j7DT1ARZ371WCndG87pv1fSRbVmL6kq1Qn7DDGw?=
 =?us-ascii?Q?bDRSARSoNRcWGL7zkwmzNIrov+/TNlOGU74bu685cBIKW82CL/nZeFD/SouU?=
 =?us-ascii?Q?1WV3okqAi0y4tK/FhtdFTwoqEx+YdE1DYJ72t3taCQrTSL3uZ5Z7akM9ADEs?=
 =?us-ascii?Q?LzSnv0QO3AzL+l1Gbov+19AH7d4hOFXhnfNaGghF3ujU27Mfhjza/aV1z+mG?=
 =?us-ascii?Q?GwoKLMGXqAmyitxl3SDYlu0VMZ8DHWfhxQ7v9MwpemuuhNqdDvkjRGjqLB2N?=
 =?us-ascii?Q?LwraHQoq2QK7zOJkzn2NJYIZB+qEsVvL1+tHSeDsQN26tcTYqJQ5zQv36HJB?=
 =?us-ascii?Q?Lf3IgJOLduZcWurTx/doJewg6cdqHLcSbAaKinlwbVoHzfmalW2miOocJTwK?=
 =?us-ascii?Q?3gObe1GODrWad1bxbRSpqEzDLMMjCyWUsNT7z0icdRfao3Z0Qj6CX/Upfjyy?=
 =?us-ascii?Q?kv1BP6ceuJlMp+Snog+iyoiVqks8tR5wuaFNESKITm4EVg+fnSWytUv4o/0k?=
 =?us-ascii?Q?yMsM+0P63IIim9VtOaqHRsCBgdsDMij3vLtL2bp8PvqoyaX39njpuhdYzAGR?=
 =?us-ascii?Q?OZ9nRrZ3YLIoXO9N96j7KJu2hZ+b0/I1TWvPNgZ1Z0cVaCpovrm88FNAkMq5?=
 =?us-ascii?Q?JOXs0DJsM4+nL2IbBFns8yt4v/rEhhPvqWJc9KxW4ztjut1hVM0aNVCeRQaD?=
 =?us-ascii?Q?7TUUxk/bEI3eeuurZ4uXpBWCR36mZamYrH4L4XEoLg/tponx4h9KDCGCrqVS?=
 =?us-ascii?Q?nU4f7sWv4uEeN9QKRcnYwMQhgOJiUt4sV/6CdKGFfmV91ML7ltS2lMZynye/?=
 =?us-ascii?Q?8pDJ7xpiDIkiuLVJqj/a/qnNsVVC+EQnm83d468DcvZGayO7D65kXtYpCBCC?=
 =?us-ascii?Q?zY8SvEKYtFgNY8fYnq/rnwgrqK0G0zlSi6o5+ol4gHyYJj/9wi5lPPyQULz3?=
 =?us-ascii?Q?53i11vrwae04heaSm5B+7lFHoosNeVtzYV7gQqbd6qzwH9L60Tumr8EEfZ7Z?=
 =?us-ascii?Q?WaEthcZQXTvwUMynT2MV+MihmkkNrNiLHkKOXlUdCfeyz6rDRZR9KyYRb5Pc?=
 =?us-ascii?Q?6Ivw0K4zA/WfFQqT4Hr0JC5b2nnhRFPjfnrp2YdkjUCu?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?t7K3Todqi3b7u7Gt71vlpYf+ZIkGbjRiMVpZWDWXu0YWqKqomfItrWxId0tB?=
 =?us-ascii?Q?bniglKUuhRzTfecvHIJ3b9CHOo0kGkBbH/H6T5sLqjdc2y/3EGMrWHJvwQti?=
 =?us-ascii?Q?Z3WiRCXl1HrhMLXIVzP+vL8W3JY6aDFVtrCheUpiAzmpS3u4UaMiEHRhsroO?=
 =?us-ascii?Q?W6KfzHbYYWyfFsfhUSdaOeC3t4hXxze7CP3AwdJcDtBw3redjDZI5ORUFwsR?=
 =?us-ascii?Q?/9sz5ZUzAVA8EOle/RZ4L2S2c6K/pq/W7pS6MYZDIw657hfSmsv5OwdcALdK?=
 =?us-ascii?Q?6AbGdmjYOI4vhdknzAUz5jHlPrImeHCVtutWAWoVXXACHrhAwHXmz/SUFefU?=
 =?us-ascii?Q?8+uXhIaP9CbaD4n5gyu8eBUEULIoa+FcV0DQWY4f8I6LfncUMiclJzu2qeu2?=
 =?us-ascii?Q?rqkyy9CB5pV0NgPEhEoF2dP29GGlC8V0mpiFiX9yyfDd9YnQm+FdUbJ71Cz7?=
 =?us-ascii?Q?Z/jn1XGInkmWYtQQXUPriX0g/YtWAZkjNvMJR7UHwsTM79oPVEThRUdIs2B+?=
 =?us-ascii?Q?qvqqxG5lSpVdAX4dr0OsEhPdzpEQvYnW95y+QMlDaV5P1NjZ2cOqUlgqZ72t?=
 =?us-ascii?Q?WnIdnqlrqbaOmjq94CfeevrNeqklxd7IKUqcpRRtNhnj7TCwT/sadqIboMAU?=
 =?us-ascii?Q?eV8egNrjNCaZiOnWu2TizVGYT/K2IqHyKaaNo4/lnkJmbKzhqWbk3p0jvJUl?=
 =?us-ascii?Q?Sy11aRG0J3K3tKFqItk3hDSGVFn6VjHA4OPwQTGVDprMUMn+Nh9nT1jZFcOP?=
 =?us-ascii?Q?EqSJTJIX5tRDbLtAvXN5jSNljzk5MXXeVX3W0VLtca07O5mhdWnaD6r9UycG?=
 =?us-ascii?Q?NFMQEEFrpE7tmxVK1C1qP1D0KGTvwUyHuHgzTMOJiJG/g9jET1fOFarDnQLb?=
 =?us-ascii?Q?F2ArDMm6JVL5SgYUuZE3fLoYw0jR1T8Um+NnFFGdluWUmapevFbVzNi2Pw3m?=
 =?us-ascii?Q?4A/MAReesnPkwxbCqxHzR5KZyw2IUBjWtEAJmXxpYT1Tl1masLMAWq2+oduA?=
 =?us-ascii?Q?rhnUPhCgdTLSs+bQquyF4OXPHsMG/Gitd+2wjzQu/nAKJvI+DP8ju+lpJqBl?=
 =?us-ascii?Q?uRvPdHKpSdtkKW+a4WXD1lq5q4Jat8D6zpr+XeE7l8Onm1SKBeUUsQCDKGwX?=
 =?us-ascii?Q?xzEZFv4MkR7xR9ByDMm4ocdk0o4IaREAtNCSNcQEMsU12q08i8CNaoWwKC1j?=
 =?us-ascii?Q?DueyXtxlpztHW9ORRyF5okSNtdLvVH7SAM9h7fuhGMgwRi15bo8B+a5jsfoV?=
 =?us-ascii?Q?VR7ZF3hEA3sAbF+wjtIEFNqjXtv08zj9JyXganmqDAS93w1tA7xgY/EmslAz?=
 =?us-ascii?Q?RCx/TZetnWgKBovuV7j4HdIvpeV2G3mHImClcRjYf3e50zF0H4qNPbaMBVFo?=
 =?us-ascii?Q?vpYbeM1k5zEQ+1l0tHtPxFdZ+GVFwEJNOZY6Am35HttoMwDpj9Oe1WWgrGb4?=
 =?us-ascii?Q?C/dhPB4ErdbUKXFlaz3/kew8NN7F2E5w929Fr7DRvqHZFNX+AcUXg7ced/m8?=
 =?us-ascii?Q?5yUyhx3j8TJD9T69GlEBxhXuszL+aRNDMEBmRfdvumNrKa6yoNmInzcqkqKY?=
 =?us-ascii?Q?n5RjS5AdqdXjShLrhZupiLKe/u6mIWDtzHYWN0zVK2OgykgVy6vaiHMXDy9T?=
 =?us-ascii?Q?PB2hvKyDEhW1tMdUflG9cCgwPDquyfAccldLHAuCcBpX/d1IgR0ToJ4ZEDev?=
 =?us-ascii?Q?0U0eJxmB9LYZ7ofAgQvnmPKteH1SlC4nrmnCfq141JHgmgzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e90fc-bd25-4b45-83ba-08de621e1973
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:44:15.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7WvQDOjmIx74wPN67bKwfOiMggxu5iLqpeuRNF5obCP/fi4vQqq3mriI3AKJuuQkjNJtmvYY3/2Uoa9Ukd4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255709-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,bootlin.com,quicinc.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:email]
X-Rspamd-Queue-Id: 3062BC85C0
X-Rspamd-Action: no action

For the shared MDIO bus use case, multiple MACs will share the same MDIO
bus. Therefore, these MACs all depend on this MDIO bus. If this shared
MDIO bus is removed, all the PHY devices attached to this MDIO bus will
also be removed. Consequently, the MAC driver should not access the PHY
device, otherwise, it will lead to some potential crashes. Because the
corresponding phydev and the mii_bus have been freed, some pointers have
become invalid.

For example. Abhishek reported a crash issue that occurred if the MDIO
bus driver was removed first, followed by the MAC driver. The crash log
is as below.

Call trace:
 __list_del_entry_valid_or_report+0xa8/0xe0
 __device_link_del+0x40/0xf0
 device_link_put_kref+0xb4/0xc8
 device_link_del+0x38/0x58
 phy_detach+0x2c/0x170
 phy_disconnect+0x4c/0x70
 phylink_disconnect_phy+0x6c/0xc0 [phylink]
 stmmac_release+0x60/0x358 [stmmac]

Another example is the i.MX95-15x15 platform which has two ENETC ports.
When all the external PHYs are managed the EMDIO (the MDIO controller),
if the enetc driver is removed after the EMDIO driver. Users will see
the below crash log and the console is hanged.

Call trace:
 _phy_state_machine+0x230/0x36c (P)
 phy_stop+0x74/0x190
 phylink_stop+0x28/0xb8
 enetc_close+0x28/0x8c
 __dev_close_many+0xb4/0x1d8
 netif_close_many+0x8c/0x13c
 enetc4_pf_remove+0x2c/0x84
 pci_device_remove+0x44/0xe8

To address this issue, Sarosh Hasan tried to change the devlink flag to
DL_FLAG_AUTOREMOVE_SUPPLIER [1], so that the MAC driver will be removed
along with the PHY driver. However, the solution does not take into
account the hot-swappable PHY devices (SFP PHYs), so when the PHY device
is unplugged, the MAC driver will automatically be removed, which is not
the expected behavior. This issue should not exist for SFP PHYs, so based
on the Sarosh's patch, the flag is changed to DL_FLAG_AUTOREMOVE_SUPPLIER
for non-SFP PHYs.

Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
Closes: https://lore.kernel.org/all/d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com/
Link: https://lore.kernel.org/imx/20250703090041.23137-1-quic_sarohasa@quicinc.com/ # [1]
Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2:
1. Change the subject and update the commit message
2. Based on Maxime's suggestion, only set DL_FLAG_AUTOREMOVE_SUPPLIER
flag for non-SFP PHYs.
v1 link: https://lore.kernel.org/imx/20260126104409.1070403-1-wei.fang@nxp.com/
---
 drivers/net/phy/phy_device.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..0494ab58ceaf 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1771,9 +1771,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * another mac interface, so we should create a device link between
 	 * phy dev and mac dev.
 	 */
-	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
-		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
-						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (dev && bus->parent && dev->dev.parent != bus->parent) {
+		if (phy_on_sfp(phydev))
+			phydev->devlink = device_link_add(dev->dev.parent,
+							  &phydev->mdio.dev,
+							  DL_FLAG_PM_RUNTIME |
+							  DL_FLAG_STATELESS);
+		else
+			device_link_add(dev->dev.parent, &phydev->mdio.dev,
+					DL_FLAG_PM_RUNTIME |
+					DL_FLAG_AUTOREMOVE_SUPPLIER);
+	}
 
 	return err;
 
-- 
2.34.1


