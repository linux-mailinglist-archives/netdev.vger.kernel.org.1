Return-Path: <netdev+bounces-257058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF42BG1dhGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437CF0450
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03410301546E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE73921FC;
	Thu,  5 Feb 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQmhMGh6"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7037F11F;
	Thu,  5 Feb 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281804; cv=fail; b=RbruPxTa6qEIKjo8/QkWrYPk2pEeBJURkwzG+E6AMYzNySexUb9E9LBBFT4eAAIp6o7UaSCzOO1hINoGE2Rf3ucT30CfTAMhCb1jAtqVg3Ei6aO5er8DG/U9RkGEyq5LBCOSpp5XaCG9El+ZiFytkYeRX8zNldf38Rmnu0pnYvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281804; c=relaxed/simple;
	bh=g1tpGud9ARagXiTSxvxU0kUOZsdNCHT+0CKsbfiTcfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAUzTCcZXBpIZRhOJnJr79Zv9VpBOyLpk+Y7DKMVqoNR0edvOtsUSYMJ0El0RACR80Yu4kRvsuld8rz3St5IKxuy0dYQBRG5PRTTFbmQhK6iO7Fp2nP6ZId/j+nddFFQ54W1lANVitNr9FnQckHV+U8ihyP5tcfcOeizd9KkVzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CQmhMGh6; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfjHM0mxw1rB4k5ltPwD3UDzR7YiaMgK7dB9FKKPq0q3ZiuFXJf2c6cQzxaG+G7mnKCzhrjyTq6sorqf6XPlVrr03lNa70t9a2R2CcdKz5jal2ia1k5dtZ3y9PNR663QhU08gKMFcVn2KfOFQU2aeveTPWm1p7f/WDc1yGOHn2RZa1sDKG8grmODpY6tp4smBOffz9TKxhtMMW/CheE14LTqT2TiqHt214nH71r/g3PzJZ9huk+tRBDPobpHPkOlSXB79KZNnysUTjbBkkm6QfriWED7bbcDJylJu1Y+PVL7iBS1762QlGRUpOAQoP7LYRIYRKsnLhp8f0LR8msShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=N7ce+f81iH/uANMQIPTI+ZWjk4m3alj+kQeU7K8DdOnpCiQ372RIng5Nda4W75sYs611KO4CFU+OABO6ZHQnN1jBkJ+qnbezw4Ub4qkfl0u7PEt8eDqlXwzSN6/2A2pFUYuHNaVG/RRx/AYuXavRUSEcIAgzkjop3/bRcfF3UuOwf5upcy/j3sc69DtwuNRNTI4t5Fvxwrqvq7FplKrRFk/NqPV3uBXjuGpBQ2JyRRZOTpvKuyEY6hV9V1OqKdhS7p5RNru5j7sAJrIvpEGFFwIS6YZ4fiH/04O7QecO7097bk+UCR9AA7il3yvV5RF6HbUzl0rMPKBICLnMM+dj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=CQmhMGh6f2V/h5C96wOfhtqUz0X9MDKUeg0d9THbLhybn4inV/PK0s0abmpoPYIpFP+CbQqWOLjFbaA5gryijjSpp5hB8S7NJkfGyqLMIIEdT/utDqRnZcFRbkePDoQNyXdsc3G1ce56CW4jWzrCpRxbsUPYbLaw4PJZBCnxy+FNr1t1iVhdnlBISgO4photoe58arhMXsyEMOabpLfMgwWPFxZUZRrYwU3zJ8/Fnd8NmqowShMqy7dAq14E/LDlJFr23C8MKacNLyfJaCm/XOKmvkUyeuC5PEiCs1MEnGOFfu/9I3SuukJ/IGH5eJY7/atWwEcIHyAG6vHGivGKIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 05/15] net: fec: improve fec_enet_rx_queue()
Date: Thu,  5 Feb 2026 16:57:32 +0800
Message-Id: <20260205085742.2685134-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec0b8b6-b3c0-4f32-db52-08de64947aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WpyslCdllrw6iP8i6WJ8un13JT688Fvlvy4RLxxHjAfLGsUZSSDbQ764llvs?=
 =?us-ascii?Q?v6WWHmIuTtmYvwN9BuGs+lfp7IXzmzM/2oSfeX/GszxkSjjtZU7tJgUQQV+i?=
 =?us-ascii?Q?wb8vyyJtgQYdmM/G1RwkJPxPH32O/u3vnyRjVFYBKBqphSVkDoFhhFFZn0df?=
 =?us-ascii?Q?VSdumlQ5DAorFotikn1qMw6rPESap8xnBqhf1gFk286Hwtybztlz02AENOWn?=
 =?us-ascii?Q?k4yADq4BnNeimc4s8flek13i3Oi6oldsFkj+oyns4rckf0gbzV2hbzVoR5GC?=
 =?us-ascii?Q?5dAIYm2kfeXgyOsPTn/uTkOk+vv9RFTJPa6swAIyJAGVUYtHxbynI+RC0S23?=
 =?us-ascii?Q?Om3kxw8gXvz6Sa/sufe7Nmsc532h5EIwhfzQ1eBVeILxN2lWTRg/w5DZZreE?=
 =?us-ascii?Q?exgKr2TjgGACGS7Bwq2e+HMjeNj4G9ErJReWUDH8a/vvI/lkJo9yv67mmQWD?=
 =?us-ascii?Q?kwyXgKdqvuvfseJHDU0yW2Z5hbTX71wwa00iMNdGDjnBV3a0i9uymFMjxeMj?=
 =?us-ascii?Q?KmCO+88eSirXrW4LTA5efXBkFR6kEBnt25yV6q1PptPNIX5zGR2reuvJjqdR?=
 =?us-ascii?Q?SMKjLeE7FpNRnVbFyVhrQGED0V/rilPgBYx1cRQpJ6gHMZ0roH0V2PfAYAMF?=
 =?us-ascii?Q?s4jqOFMZcAR6iFbKajzl+A5M5Z2+fS4eFElL98L0AAooatLmcIUo6p7Ufx4q?=
 =?us-ascii?Q?8TQuIkcUgxdKPVdjz5m5WTftmThDxQqsDnWhaZVgvxCDV0PpcljWNYqFRQAh?=
 =?us-ascii?Q?y2KNCzsrYGuxr/yZlR+glqvSeo2eLYhv65p9WtDGzu3Gk8H5YQRzGRtYBPXS?=
 =?us-ascii?Q?l0uRU1tO/xmIpnUngu2+ohGKfr3OjCfkSjFsBqPcgJm7jaOdkvFIr8hRJKpS?=
 =?us-ascii?Q?ug2Q89vopUEvi/K0zcRHQBeSehJPjYjTarIh1QlsBQVz72fodjXGQPD+tORF?=
 =?us-ascii?Q?NaaIe3Ez8HKLuebK/6/npkomO3aWo1U+LKCQDX9Sw2QuOvsZqGaNcmvhuY0c?=
 =?us-ascii?Q?ury7mdDBuJSAT7RqFnqbKkeVnZ2VYq6rdggpUiY+m3cMp2Qu1kKsK7eJTdEq?=
 =?us-ascii?Q?RazQI2gAJUbMbGUlGpsDfrv/FCwgC6GuynKkMNvXGyoyvtwlmfjXZY8NYLsC?=
 =?us-ascii?Q?5TzFexM+HYwaPpMLyZnlENRHXblo9+Gs/DQQQT3Hm+mfd/G3RyRmcueSpgx7?=
 =?us-ascii?Q?akz0UJxUutkwxC+gTHt5VhBHxLbAv7gMktQgfdCp2t6tOGpsOfhSMmLfRX/K?=
 =?us-ascii?Q?7AHL0lz0gUzIiPkbkWa7SSSYGl1+df6RPEOjSZhjqFQHod2y4wGe+gGoLlK6?=
 =?us-ascii?Q?Kgoz/JAElePgmK/rJNQK45u4RKkgmArMmPW425XZeTWdr2vD34fSwobCs9ry?=
 =?us-ascii?Q?H7KKz7XFSsLtS7FUb4DSfBDbb/v8JK2w3dG6wEiT4Xv0yFlMIqQuAHu/exOC?=
 =?us-ascii?Q?TT4FPkETSfniKnR/NxhA+gJmNs1A3KH8mlmzwhuRZf4uLB5QWA7udJkIqqcP?=
 =?us-ascii?Q?3m11j1NvFdEHeGucmn9Rn5Jt2vlMYFNMZ7q5ktIVfYtWhp0hMZoh2eyTFlZ/?=
 =?us-ascii?Q?2JPuJ9K16hbp4Rf0RKSCAXa9EahaYU1ZXNKq9UtbUaLuaw0t5VqMmK/3klTf?=
 =?us-ascii?Q?mjYl6g/leuz0RNJXtnxMmMhAyV1MTualr8TlJ71TagV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/f4BxZdSAxnrhkGpegrIA/nPS76jRHsGLFCB5QiNT6kuKO34UtHXrdOCQpZ?=
 =?us-ascii?Q?6We8zgIJlNULuR1A4Pa3RTHdDuKGgDNRoGdVn2rxcEFqS4m1Db/kUk+9ORv7?=
 =?us-ascii?Q?bRAxlIvKHoc6A5fjQXK2fSSraoN/34GprPAck7zsj8xarBL+dJBq/2PUf29d?=
 =?us-ascii?Q?UYVtYc50IEm3HSMkj4VQOt5XjkOM7kmo8EkD6z1iHVRgQ92uyh5FNAY3ONkv?=
 =?us-ascii?Q?jszN8eFM1TgYVARJ8/dbvr0UKwFZQniFEjiHIRoB6qk1XDIIOtfcSOvDRF1m?=
 =?us-ascii?Q?RKJONMS9sczN1GhuuG0li2aHV96EPQ41VJg9tqAjDyYwetlvsGRWCXRILr8R?=
 =?us-ascii?Q?szOgRMhIlsykLbuFaZpSGxepsDP6lWO3Oued1SAtIBCF3H0f+DR658GSua1N?=
 =?us-ascii?Q?B6MUCuGszRYeS4lSAouv9x2wTGa5UaOmLZ+dNzjNs5OqsOGvTazJzL7TQQph?=
 =?us-ascii?Q?PYye+y0Vzzxse4Y8VYolTQCqtSi3c+bZ/bbOZpPH+yONmTGs8Oke8GXisH1L?=
 =?us-ascii?Q?sVro/+57luStGhCSPzrIdBJnrm0cxzUg3c+pLrGZCbb2qFd7M8z/Jh1V7ytC?=
 =?us-ascii?Q?m8PGnZqi+WxFRVGZ4EN+y+9PvELblX7ogEq0Us6WJUDdaTQr+DoXorlHKIl4?=
 =?us-ascii?Q?DLGI/Wlw32pds2gT66hOBokrxj+yTIpLz3WrTTJLMxIW6iynO4UMs13af5FU?=
 =?us-ascii?Q?sVAp7Zdp+aVmCNX6osfc0/rzD0Z8vUFDaz5cdiSoZTuUX/daEiHzu/3oY4wh?=
 =?us-ascii?Q?xEWIJj08HJxwIwPEZ9CwoccCzMPqoAjtWlhrH/UBL5+LV2mrF1XHQcfOJqxx?=
 =?us-ascii?Q?pSvB++4g8CyJ5qWzRHgJjwWODFMtuhjMY8hMbVVUFfPlQU0q+y0TRPcNNZqi?=
 =?us-ascii?Q?oJyWCIgcVm71tJwc/dxd9Tr38GRFmA8QwAx5En4mDaEc7S6siL2g7/dDrTgR?=
 =?us-ascii?Q?cPTv4WwsRcQhPrnYClV2XMzd7TjUh1pXEz03MnFEOlEjkDmx0Bvr6eC4MRPi?=
 =?us-ascii?Q?VDpz67vNtgrE7pZXyhTX6+lQx1XAGlrTuq3/TiCcO0ex9vawDA9I79ZlEeiA?=
 =?us-ascii?Q?SuNjpCLRdddIrnxxZ/5TnBCk9bwcRrSXggE6+YGL9GVmnwvsLD/cbBXzv8r3?=
 =?us-ascii?Q?mytzB6IiLo0M03/ssScbRyNa6c26+R7chVeEEZCkx0Bht611GrgkfIIeG1ZK?=
 =?us-ascii?Q?ybvuJ98nhHaKxdJcA95pGuo2aHPDYpVoPZwEysEWC3+jAFt0rHMN+S2bNC7g?=
 =?us-ascii?Q?PZYsmha8K5gFQ2fh5QAWqk3xyvz1pDyghb6Q8NnmbIPE6eOCguSFDpakdaI3?=
 =?us-ascii?Q?DO0MERWW0OmTxfKe/czwk3O6zQjPU4UCBzQxEfnNYaLlSMM85ZQ0BewYW3E2?=
 =?us-ascii?Q?HR5A3IaKAQfSI9/8otfNKBK1P719EcbjclcX+Ik3bvf1C56Y4HBCllIoyo07?=
 =?us-ascii?Q?2qE/yp0/2ejYtGm9I/gyYlB2zbOCyL6H730gpuKkP31P31XOtsiYkt2V8eAQ?=
 =?us-ascii?Q?ol7bJKGsDI00HIwUgmU5NDfxinukMlvmv2zESk9PeCUY+NgkfPUGOLHu5C2E?=
 =?us-ascii?Q?aFtGqMJ2I03kSC3puRkpquQzO9rMz+QHDtNta7MlPNsEXEeCccaJSbYVd1go?=
 =?us-ascii?Q?epft0TCRgd8OYx2At4dwxMAcX3uml9PZbW6NtD9vp47x86xOdDfAjcUSIDRK?=
 =?us-ascii?Q?yuUwosP3v/RF48n+O2cGI6otZGmKwJfF92DpIBvziz+427t9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec0b8b6-b3c0-4f32-db52-08de64947aaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:41.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33w4vneG7iJG/LiTG1P9l1D8Gbj6Kv3Eu67XdcE+GNk+DhIlNZCzkq0FSlQ+yIT2uoWNUQlcqnUYk0xa6OM3ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257058-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6437CF0450
X-Rspamd-Action: no action

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 851608d04084..7bc2eac01e6e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1840,26 +1840,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1868,12 +1867,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1882,7 +1879,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1896,15 +1893,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1980,7 +1975,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1


