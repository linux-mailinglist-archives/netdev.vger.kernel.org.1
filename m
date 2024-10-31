Return-Path: <netdev+bounces-140623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE29B7461
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638141F22BEA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08E13DB99;
	Thu, 31 Oct 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jztRA7JR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9104437;
	Thu, 31 Oct 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355480; cv=fail; b=MToTriJqbnogtwPTtqirfBpzZoZJUjGWvXN0V09g3/U/cpQYrbpYYzAV02WnFh28rfFdWY6fsjjrD4bL0eDboAW2LXNbmjHcmvJSuXOF067CEohFU8LaYMGqPwD25wY4x2Gx0HQpw8JsZIe/Z2irPhbhaqUYJrU5RCdFTukISDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355480; c=relaxed/simple;
	bh=wiNWSCithfquVwTHtB3YdiIZ1HEhdLL7P4M1uOI+a5c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=awQ1eYfcVqhpAFN+ZczSRaFDJHb1Av/RHhSxZAOVu5wKRMcikx/RcCkub/kxxFefvgqbGzV7bdyAbspHUxNxjN0eGMJpAtUpnzU3rF3vT5EAbsWqxzJf+cb+cLpcmh3lsY1B7S0SBy0iN876ZAtxjxuqsQGZ/ja6iLAmwWNfido=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jztRA7JR; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwCLqp2eKbQ6jvXDbuzsiczHP2ma8PCD6O+w/vHcZ5mtxmYgQfrQ+Ezf5+FjX7gkPHVlErq2CfQpsszXrp7tqSMFAUY0HPF4WKJcZ2mWzf0WCB9cGqwv14kE8iPpjqIwytARLCZPzggGxXaEVWG7A7eQOC4rfa8xAwDg3D5e3XkTj29qhZhZmnMtEgSk61OO2k5Xzd7R3xL+ns4KK35aO974fZYWZU/NqeMDPNloT8WcCfjDBCiNWgGwtYa/WaS0YlNNfoz6gWBM6V2RGOgSvHx+FNoKqRRvQyPlK+G8JCE9eXQeHQngS9Agb4ntBNb86SHxbqW6HLkGw57wJ7UcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz0QM9bvdBF9Uy4d2GAWroLbg1Q9Uf9iSLSk/MIxXPE=;
 b=Tk9TFceoJRJSm0m8P2jPh9soo7uwArZzsTIHWryUHhPsYmqcRZ/uVgi6foQlq9MUwndx2NwbL0iMzn+R4YZZjejiqOpShZDd6viPxHAZuwYCZ7Cj3m7OZyS5mNhxufA0ouEZON+e6eaKdJaGvilqZo0OzEO4nSNI0s8+6+1lnfRiwehwU4uWoI/5SQnq/bhVg4NPc+KKB+bWi28bTpXHVad/6YgT1D+wZJvNkysNlvftSofixlk00Brj2w5uRXvQ6W1kNzvRdtJz6uNLmAyWq4TY5hiHBEIZUrPZZ3TavUnLy9WuTVKGKyLsV7+XaVFACew+F6/5IMZlaGgAux2lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz0QM9bvdBF9Uy4d2GAWroLbg1Q9Uf9iSLSk/MIxXPE=;
 b=jztRA7JRiWbPZGOjGRhWbgRl29tPGcyP0sZQ0e3tFggQDRAA39f6b11pfdR+NUUYILvDP5a4PwmsyoOwQUu0VKGNCK7D4h1EM/kASJzSFay0T3O1Lc6cueZ03pB0wJlKG7qNrjBQRnSHzo2r45o9Ye/w9Wi7qJpBYjaq+epkft7DJ3APHCSZk/zf/lVTM00CAazk7X4muB+2Eg5+ZOVCcKd6kD12/gUFpW+++Jim8y8Mdrhc0W0Us6mXslhMcjCF5XhWDgpEZZ4sL5L+xcQNaKbks+t7+T1dniGNI3QUUzh3Z+rzZuG3I23bSRSWSrSoXCci94A/9b1IWQenHUSUaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 06:17:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:17:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 0/2] Fix issues when PF sets MAC address for VF
Date: Thu, 31 Oct 2024 14:02:45 +0800
Message-Id: <20241031060247.1290941-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 99493c9e-45e4-4503-e360-08dcf973c118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJLUZoc79IGsm8CGDmDZQ2BmqbLhjl/Odw+qWhbDVaxdaPykd7b+4HNWPPpM?=
 =?us-ascii?Q?rqdx5xEuz8vHKw/d+avR6rMqOqKXXo6bj9GM+YHkLpEbyo2mfJkgGQtVghln?=
 =?us-ascii?Q?rLHIDeeBV46HLSBZ4FSMTfpCn39YHg1L4gfwOX5cupDwYhkxkxxxJ0hJPhrv?=
 =?us-ascii?Q?8y6XnQsQyGBb7Qjc8B3TjRjYu2y7tMH3YNnfNrD8Y9y/vyNIPXmSW5Wv6Pwl?=
 =?us-ascii?Q?hlR0JLJobVjuFX49e7bFAo1NEUAi5M0WQfDXFUhsIR4M6eKvKD+lhKn0qaD0?=
 =?us-ascii?Q?U7DEm/x77V9Av3dsblE+ixLD7xLgRlIvQwJFTA9aH/h2UGPYxwlEegj2wl0A?=
 =?us-ascii?Q?dqoccDwfW/sJV7ZqPUSG/qRwFm40v7dX2OOMY28G8K78vHVc/TxIyLL9H0RB?=
 =?us-ascii?Q?nPDda5iW5BT6koHnkptpDmZR3BU4RB2/RD/K7FSPJVU/N6NMW9zICLam0QO1?=
 =?us-ascii?Q?jYCAu+cHzzisJCaQ32rShCcclT+TGQ5YU/RVpVRl37CjcA4Ig+XwitOsHn9F?=
 =?us-ascii?Q?Is8r5GJSUKZ0pTh6ktVwPFz8MikDdee0c0QkJzpU/4LaUgoFkU70sDjPD8M7?=
 =?us-ascii?Q?v4tErXkFeywQxIXzivn1VvVVUr9YC73A7IngjOXiJEB4wD9PZ2dkvZIUPaCy?=
 =?us-ascii?Q?5cyaqX8B0T7Oylz+fAk9jjq6siqrbWHt1KKnRm8JxPYrnT96CPjYpjbzQ/eC?=
 =?us-ascii?Q?BscAXEReDS5QQWAiaFp3DATr1NSsVHO7DBDXdpwvHmhBhItGLRjkQ37w/b9n?=
 =?us-ascii?Q?urn9a2uzhoQv0TL6DMaoDdxd018+SmNEw2hy1h4Mz1QLDe+dPN3ve8CrjL3b?=
 =?us-ascii?Q?JpIaY6oo994BMp4DnXBJlBpke3xEkgPVFV9tFBODY2V43LOS4TI0X7+1whdt?=
 =?us-ascii?Q?J4xDq0g9l5iTto55w56gxhAoHTSSCff9hf37n1G5jDHzAB5Buuq4JHFqBWHD?=
 =?us-ascii?Q?pHqjFAqCL4ipaL9+J3LXo0yeapjF9gJcFhJBndsC2e3xXN1D53JPkvZqBGmC?=
 =?us-ascii?Q?zrh6dtG358EKoLWyKf+L+hISu4TLpZVdkSTN57wMoMylDRJbm33P3VqA0/P9?=
 =?us-ascii?Q?4yhOtUvwpRymDWKh3jL+6Ec5Hh4YylfNI8rQMgOJ73UNQT46vXb7dNcY3Six?=
 =?us-ascii?Q?JdMN6RZ1+EiTZfqTL63PanBQ6i0Qkxk+Mk6UFol0N0+I3DvMlMOCEO0mmBQO?=
 =?us-ascii?Q?9TWXeVFuBrZc3HB0hMUsXoGbOpLJ1PeGHybc0YLHeU5+aLo4jLw4o+knZ6Zr?=
 =?us-ascii?Q?vVWB4ILA1iDMjVHqjuP3Yib0NTmdd4A+6Tewu8EhJKrp9s8WzrUmemZWfFLt?=
 =?us-ascii?Q?PYY/m5xjZPsDcMvI8s8ugQRaoDtdeE8MDWgIN/qRJ5RoQR41843SKhLOC8UV?=
 =?us-ascii?Q?qiPNgFA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2de5R1A9vn+xiVL3JlELCB6vb5VZkn5Fp/Int6C2eUTje3rJBVwVuX5czfz?=
 =?us-ascii?Q?rAcRgYmU7MftFTv2Qm+s53iAFegmRQDjek4THKsdxBcv5ojyIGp9uHI+TtNv?=
 =?us-ascii?Q?aUGYL+E/SumRNM+Go3VR6QxAL3/WYv5ti+IkS9HQSS0k3/iWaVuxeZCIepwZ?=
 =?us-ascii?Q?pBeDp6rNG/1agL2xNu+16xEIQTCB+k0stmieAc53IhTCsJlZF0JSSq7tdtNo?=
 =?us-ascii?Q?KZMqav0JSY6ySaWlER8HVGqNQ3aHe324oalqyMLEfowVeV3FhAP3tvG02fz+?=
 =?us-ascii?Q?63WxDg2ZiiZOto3O7Ffd3msNQr/dQT8VRKl4vVRRbt/jO1vjiQUCOrnXHpyB?=
 =?us-ascii?Q?VRCiAdOyGYdyMJLT78m29g2TtyJw8lQGRMokHiyEkrgY3PMhExIjCxEWSn/4?=
 =?us-ascii?Q?6FMg2GdyYicC+A24lTJxHcp8bC1NC39pzFeJ5EkGpwoCtKeiGC+9bWefbiOI?=
 =?us-ascii?Q?6TBFlzruHgBKis0vFaTM7Ta3KYLYhrSJStMFIj4jsCekJjggGZwn4KX8N8Ri?=
 =?us-ascii?Q?+f9UR6QIZtzruOvvmplF3+D2pS9zHgRmpNfwztAj7N5bXR1B+ibHuyeT2VXV?=
 =?us-ascii?Q?NdMgI6btg/1MyJf1JMClXhZqmFksmJA5IHQMsxIzQXnzO5q/BPI5GtG/2dne?=
 =?us-ascii?Q?lgHie2Jl9NugjGGSRvP3e/OP+bUYDlje0ZqamhXIWCkrpPEpMkw3lr74X/O3?=
 =?us-ascii?Q?RnlDg+E23b+GLEdbuvIeRQpgErgXC5spaS3OXJ5KEXdaHDjefG+RsQixElLL?=
 =?us-ascii?Q?EtQBINZg07FkF7vmjkzDdDvUrElx9aOGhDrNtHumZtnCxfABDYXETn3tWlSy?=
 =?us-ascii?Q?EDZcAgXgVk64agKfRKasj6sEEqKjqYnuNcUdUapsV8br7qTqOFl+oYLDzc/7?=
 =?us-ascii?Q?8IsmvUYo2+g663Y9YpWWg9Bx9TwoCvezS5Zvl2JRLGUBJY5S81uGXDLWBGNu?=
 =?us-ascii?Q?iwP/3cpwFIOkJ1Mi+3uXGbysivfd7wPwIWfv1HRg4WWD2r2a+SZ11EFJuhaj?=
 =?us-ascii?Q?y7D7eSj9wYqo7dbfrm27+GRNt91xDsEkVztSLw1U6zVen3C2EqJPO+BZd0MB?=
 =?us-ascii?Q?RXiv2xuK3AQ4UG0geZkm+hlUE5WXuqg5+m28Dq3KgqTSAujkxQo53kLM/AWq?=
 =?us-ascii?Q?pCTcVS1E+SrZ6LuX/5TkfFCn5lnVY10B+3Fv0XknWMdfT38MQhJhsJs3tL/y?=
 =?us-ascii?Q?8zgsSMIp1s8WJxP1fbrmemI05/FvPHD3qMlcxJC/BoEakmjn20oeKbe0Y1Kh?=
 =?us-ascii?Q?PBxMGWYlI8lWKwfnPlbdSiCNsr4+mCzsukGaZ7ppkr89b2iTjKXtuz6Puv05?=
 =?us-ascii?Q?Xih18qRYlbjC3zKqIhc8IFmcPOn/vD9DgMdUTDVGSs6b7P5hDrDL5aqV5Jcb?=
 =?us-ascii?Q?VnkDpH3O+rP9T8v3ihIxQr4eWRTUFTOrtkY4cnI28BkrR8DZi16BtHcP4+aU?=
 =?us-ascii?Q?v+7TmorRr8RB6uCFaSK1XyatIjWyr/XAG6+pyINSG4XgTU+7BGLoCrAPeU+T?=
 =?us-ascii?Q?vT7Sy2oHKfv33P0Dnltzf8VVEGsT1cmdqId6m6zomMbGdHY1v2gSF4t1086V?=
 =?us-ascii?Q?itJ5+UbOamK8jGtl75JIg8bNqJWsT/G2ad7uQY9e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99493c9e-45e4-4503-e360-08dcf973c118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 06:17:53.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZbhtlqwKA4N4/MiKUAB5saOknSbOZBFtXbfvIgt/sBEvBlJNqVR1mB4pUF7W2PGnigDq1Ee0FrO7q5zEFNWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742

The ENETC PF driver provides enetc_pf_set_vf_mac() to configure the MAC
address for the ENETC VF, but there are two issues when configuring the
MAC address of the VF through this interface. For specific issues, please
refer to the commit message of the following two patches. Therefore, this
patch set is used to fix these two issues.

Wei Fang (2):
  net: enetc: allocate vf_state during PF probes
  net: enetc: prevent PF from configuring MAC address for an enabled VF

 .../net/ethernet/freescale/enetc/enetc_pf.c   | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.34.1


