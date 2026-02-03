Return-Path: <netdev+bounces-256140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONv1IxiHgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72488D4AB5
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A87F23015DA7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34D369225;
	Tue,  3 Feb 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m99OaNLr"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD1366DC1;
	Tue,  3 Feb 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096266; cv=fail; b=depuZ+xbB0leLOpqeztcco8b0U3ggve4O40mBNg0Pd2vrFrRbdX1Np99Q9x2i90MeYYWDs8GUr3xwqgtjK33Obkee89O9CtSG5FVOru5M/CyI6xnR3pR/0YFeg9k78hhnCs/MqtbF8VpKUJewULcbbKyIQmm07vkDT2S834gvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096266; c=relaxed/simple;
	bh=KDaxEEfROAgi2gzP5D3F3/2/EKsCCitYJzKioXtew6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiMOKbMb8B3vK2SOZAk/tFVU/uH+OTMo/7ic6U/9l4RQPdbfb85ewX37r0J9a9VKjWuEPDHId8PJZgxvgkNXuPx3kW2tkMAIF5Mx5tqBas5Y6sRKlTVApQvw1dBDidkMSmskj4MaeJsdNGdC11LzB4pib4SeqVcqrkqgb21kZrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m99OaNLr; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3Qb4xnA9X1Jn1o5/tTWpiEPQ6+xDdsIkSY1JsT+jbckwRdU4yDOG9v296ixiqBald9Dp+XICSXThYXR5c4adyTlZxVCO+P5lc2zDHqAaxtzDbUiiIkena5NyMqkk7lIZ/xmZaMGEBvkuFVFFQ0PjH0IAv7vurBzcd+eLV26hfM7xp5FWwJORSVgSDvPAceJHG7YXXAdtQAqBs3maBpsiT21NcJFe1h0NdEULeai1YQakLCpU3JC0gNb4aSVhMuz0CJcAeEQY6ZmMjyqIL5N70DJzqBI0KED02+D56pHOBqDnT7Jdm8/k33mEhaawQyxj6laK3ujo852ByrdM2Nb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCOxYVqncLOrkjkG9lRIelRM66yYdvRGUuaQCkjcCu4=;
 b=wVCq8/XNEIszphGejl1z2zn521jVakJ5jo8+oNDt4wqpg2p9ZMwxKUHV8t89IuK384We38RqvTf0JZhF6qCu5/I+HB1fpCOlYu1Q1TEynskqwDT+IZ2e11JjIXmAXUWtLJBrpUhmyK1whtInjfQdc+kBzQPpDY5zSygoa4HrKVLBXXnDHP4xNysYX8lcxKGzfMvd5VRIsnizFkd9iNVF6iq3/sMJCk9m717qbbxuKvEFzWU1OckOuhs2RgrUBNA81OFOvMVrXJtOuOiynWFwZqIE7j2t+vJRTqrL8TKQm11JHIRT9UZWbGYHiyRRIhnfeIiV6J02Z6u6whdVqnHr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCOxYVqncLOrkjkG9lRIelRM66yYdvRGUuaQCkjcCu4=;
 b=m99OaNLrBWTSL2fHbm17hkZDbyHQaxY/PtEquRjwyox+iJfzOot/vs9NEfAEybR42ZkJdaZadSE2dCcZxxrPD66dsU8eJdv+kj0i8jrmXZg3s0KROz/JqhuVNS3LgcOrM/QeZ8oeOU/Sn3fkgQ4vS+XQYtNcXPm8Im5RtfafljtTepCVXkpRPFGSCin9fKbP9OT9sPXHdNyJql46M4gBO+ukZ3cDl3Dm0pqzsRuBZXSzliJOYT1l9334a1Gc+g9fZY0Ku3F61DH97SQAhf8a4mbw7AIGAYTLsEMq0oIX6ECE2Xr41f6ITnf5C555yO2J+QPTMrnB0V7sxPXIcUJpMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:20 +0000
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
Subject: [PATCH v6 net-next 13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Tue,  3 Feb 2026 13:23:27 +0800
Message-Id: <20260203052329.1085444-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: b85e95aa-a621-4572-c4ba-08de62e457f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nabr9Isf1KcDz7klSJ1iBTYPfS8nDRkCpzqkh+pZOG+JAtGxUxULXoyn2PeW?=
 =?us-ascii?Q?x4Z6RSJxzbQMVPHMKDDOQDl6ZUBquGdWLb79s1CDqUz9mglwkunQVh/slLeY?=
 =?us-ascii?Q?g6S4b26UCsR8aQZOefxGNzrmh7x6eI15tQOVsBvukuMb3mG2SCvUHEujmio+?=
 =?us-ascii?Q?8o2wwun4DDQdL5MSyu7ElbAgsSH8nObAdwEujOWWJQUgAF667WdDVJzg7iKG?=
 =?us-ascii?Q?F6OAWV1Pw50BSa77sg7RN1KaC4oLDNJWSI5m1AiSPtjAMe4B4p7eURK3GCCG?=
 =?us-ascii?Q?oo+S4BqYzGFHUGYMraH7pKcn/skc37FFce40N97lILv+XScCXQqy9Syu8bfe?=
 =?us-ascii?Q?qbyarGwkXPEjeFz+wDvs29vq8A4DhcKdJwjRYSB2YeGhAENCqi81RAjH0HmF?=
 =?us-ascii?Q?89WzdDa52axbl2/qW59E6ec8aLhtO/4FNjx04nuMEBRs/c3Ce9bu69DTP00G?=
 =?us-ascii?Q?V3MHuvxMZju4RKrHiF9ZIzQy+YdaGJ+h4XMr+VXFP2APVJsq0Xog5gM20eG8?=
 =?us-ascii?Q?L5UxpOy+pcxTtaydADKJyEFY6QFJ5qOIu3lG926D5x/ckTB0ReLW5BojmYSA?=
 =?us-ascii?Q?r1nhbVqdJ4OiyWXD2ilK7xeVt7pFwI6mNHIFROw0/9pSI3jaFFhsYEBA9U97?=
 =?us-ascii?Q?6Uc4zDq6coqvsN4MHa4xsjE3embYwu3FP+YGNI2xgQt+LVNU+Mf2KAoFeh9/?=
 =?us-ascii?Q?C9Fz3oUMHjS2OB8/SghtYmYBqS+3vMAs6uMM/HzjlcnRiXvYVXGKjtdy5H7t?=
 =?us-ascii?Q?Ql/6jhSdQLjgyehExKQE7OiotTtO1jj7A9/XGHuOnecuJJQOc99YPZoVErMa?=
 =?us-ascii?Q?6xekqg2bAKWu1KQ0BCABqgM823TVMaLIoYGFfpNo9KFfl3v0JZTq+XBeoHGC?=
 =?us-ascii?Q?3/f53D3Diysuz2Y4FxyxoIDxusm3x8efaODs09NHvDwMem7ncPXIwT7BVR45?=
 =?us-ascii?Q?3TYo9t8vMpjGlJwemQqU7MePHTVgtQtOINsJ+u+x3+9mYPwaV0maBnZS+Suw?=
 =?us-ascii?Q?QPB7HalDFFoM7HQYzJKKx083u3wp7D9WEjMLj2pV88PXjlbCZomUOTXXU99k?=
 =?us-ascii?Q?AzveVZYhiiQ3devFgXa2jpeTfFtZco3uGIQ8+qRtZLex/Ue8C7TLw8N0z4ul?=
 =?us-ascii?Q?PGXHJBlYl7bj52w7Zb7jfgUOCCAIH4TPwRVsJBxX5fA48uN9D5RzLwn+XN3y?=
 =?us-ascii?Q?VnXpqmGd2gbHt1+DZh7ap+omuzu9Q6N2vhj/I+8PhFe6A3E5P7oJJOOXSUJI?=
 =?us-ascii?Q?JA7EFAY2uSRvYnKBJgM2E6gB2swooIrkSWvX9ifqeszwVeXWNrYPWSOvrbuW?=
 =?us-ascii?Q?wm3j7auUFCIPS4Q3x9XDIby1BJeC2EwJ+s2e0saJqz4yVBy4zVcClMHTBKAS?=
 =?us-ascii?Q?Kzc3ONtLyGqvz6d35DGNsAH06aqGGzy0zF2hr81Cw+Y8tw3H9ZnNNY06VFbp?=
 =?us-ascii?Q?+e6pcBG48LojdksKFUXejqWH9+cPYAS4QgxopKeP98WLxnO/epVlrUo9K8LG?=
 =?us-ascii?Q?yLLJBL6Kwq7rwLtbkpbSb991jrKkAtSrVgfg4/tAGG6Y89gbL4pzIn4SNwMi?=
 =?us-ascii?Q?/aa4A4brnxONMjYoEb+2bf/A5y/WN0+jVPk1AsAWf7rI62RNZhmovI8zCq75?=
 =?us-ascii?Q?AD1MhOy1nhuCqzppUyFhoYCByssbV/Myzk6vmyG7B0R0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9K5zT+Put9bMZpetfqRVAf1LPJ5SH/ChFsCXREKi/KRMCw7PDqxcm6mESKR?=
 =?us-ascii?Q?+HLgtfKdZ4DE6/C2IeF/fuUkQYsPBM4LbLuShu/qHqiqAzr41uPUe0sANqZp?=
 =?us-ascii?Q?h6YxWgwLc6LwyElvJaoSaAOu7JoaLn78msazBA+6s7Qujq3D0g0SnJgqwYyc?=
 =?us-ascii?Q?dBlScUQQWOESXJFieuPcm0AgvrJWpCDoWYidv084rPogwov756peZOLOkQA0?=
 =?us-ascii?Q?f6V2kcxrGVj6Ra7h+Wqs3CeCRuJn9LyavRMmAhlOhaudG9vTfexGckYF7KYo?=
 =?us-ascii?Q?aRWn3XjsYQgn5w07C5auGGj2hCMdEuBmHb8otnuO/UETjQNfFdfhg1xPdc7k?=
 =?us-ascii?Q?zfZNSKo5Bcj0RxT3YY7h6VA/95lWL8QixXdnD6O9MrG2tsL1B4VvhhlFnETp?=
 =?us-ascii?Q?qfj/CGCfNgP6hzYq2lqz2xYcOamjUx9JsYEP7RRo1Anbp706LxbltKC6ZUn6?=
 =?us-ascii?Q?MCZ3xAqoTwZV/AUYgr6HQjeBJaIwLBRYmF7o06MJzv4QAchAe0dJHqaxvrrA?=
 =?us-ascii?Q?gea7G7uCc1eJNgA8pbzk15v/MVe4HeBxyyrjw8AfZBARktbw8vjc7TAkycNv?=
 =?us-ascii?Q?4mx0C0bcTXH2xklN9iHhbS2JsBLlKEwX1TfEe6QvGzGr/byPb5DUNRXXXFZh?=
 =?us-ascii?Q?N7fUXxgESjst2Q2/WaOBBmTInDxTRQvmJ9dhe13jaspsAImfL3IjXio55lK1?=
 =?us-ascii?Q?81Q6vfpFWWE2Kc63flbKHfQPIynJfGHefDr/Dxooo105iCBC5DOeI2cqBFyn?=
 =?us-ascii?Q?m9cSaMGrfftgPV9RCkOFU5L8FELn8ygX74cWnkCtySoqT1UCoHKLeLqM8DZE?=
 =?us-ascii?Q?9QWm7ptAcMUJRTN6ZllhS00ICZB5VtqXQgFgbliAnYF4jugdxVwDwASZbwAb?=
 =?us-ascii?Q?4t1n2B1Fk2UNEZMdaF0oUL0v+jX0BtpTNNqpjeprGeoZAXCIgGG7PFC7us33?=
 =?us-ascii?Q?Mi8IwjYRbYWDY5ofTDcAvIkxe+zkCQngy4RyHXpjqmUnBrpFIWtuirYUfsmO?=
 =?us-ascii?Q?JRsCS4reCoWFqsaguvkrZEkmYTbveHD2SVu4upEt20bDDYDI9m2TBsU6gO+y?=
 =?us-ascii?Q?F92TCA0CeIKbbIFRoD5ZD+KoCNVsRRw9VwSqIReguXNC00H3fG2Rbfa0jVcK?=
 =?us-ascii?Q?udP1MCf3ueiwtuQq5JBJsWvzoOOUIfGHUQghE+4kQ9vrzntwnnFSZVxUtVER?=
 =?us-ascii?Q?xvpJDc8rRob2E/dESF1EhcXIT3BD5iFIWGyJL2p/owPhCCSMhvQvSlzF0Dps?=
 =?us-ascii?Q?Xhu8hR2it8QFi0cDhEeWZ64z0cJBJ3e7QtqRDpN20e4uz1Fz7/eVx/g3qar5?=
 =?us-ascii?Q?9OI0+EumA5GHH/bGm4X9ICW0a99LMusEbJEQy915KT10TZQfktrSQEGcEGGP?=
 =?us-ascii?Q?LvquN3okVLNN+9GrTmK+1dKDsevnj7J4FTR07U00uUk2qF1v+0jygqa9yXtP?=
 =?us-ascii?Q?oEZSxr9az7hzZF9aN0A4lkENIxTsirQUCmrpKSPAJgDDqprEU8lE2Pxfs1C5?=
 =?us-ascii?Q?Q3IjglE1AVhNDte5pg84KqTOwAYUn0gmT57U2iNZprJM2hjR/BmXgG/rNShI?=
 =?us-ascii?Q?U7+ESArI1uvlNF+zbBaSSOdogxkPvsOmzcKLFGgnEUxvmdHxn9vPKTTsAam3?=
 =?us-ascii?Q?KHIz0Tf6t+omVMBLdQ21o+Zw0yypKlJAj9tInRq17QPYrnOlGrIpBVhv67am?=
 =?us-ascii?Q?gHS+HKkFoqJEaeD4e8fTmrZjr8THrm35RKrmObPEaQIeGRavgHfhz1PUWk2j?=
 =?us-ascii?Q?ggHPwl2jVg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e95aa-a621-4572-c4ba-08de62e457f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:20.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dti92wdmijG8/Nh3UpRJYfhmwaGnL4yUHyRaL5CPaK3EuT0SwnhvJr4waCG0+UpRGSSp0+CjIP0bcl/zOQDa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256140-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72488D4AB5
X-Rspamd-Action: no action

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode. In addition,
fec_alloc_rxq_buffers_pp() only initializes bdp->bufaddr and does not
initialize other fields of bdp, because these will be initialized in
fec_enet_bd_init().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 90 +++++++++++++++--------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 31a27f1cbf39..cb03b45b7951 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -990,6 +990,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 				bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 			else
 				bdp->cbd_sc = cpu_to_fec16(0);
+
+			if (fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			}
+
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 		}
 
@@ -3435,6 +3442,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3448,16 +3473,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3556,22 +3575,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3590,36 +3605,47 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-
 		rxq->rx_buf[i] = page;
-		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
-
-		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
-		}
-
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
 
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
+	if (err)
+		goto free_buffers;
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err)
-		goto err_alloc;
+		goto free_buffers;
 
 	return 0;
 
- err_alloc:
+free_buffers:
 	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+
+	return err;
 }
 
 static int
-- 
2.34.1


