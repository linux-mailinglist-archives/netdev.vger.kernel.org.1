Return-Path: <netdev+bounces-199383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C923AE01C2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD43F17B666
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E6220F58;
	Thu, 19 Jun 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NAacZewP"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012031.outbound.protection.outlook.com [40.107.75.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837021FF33;
	Thu, 19 Jun 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325690; cv=fail; b=XGwERcL0o7Cni+1pWE8pkKWSREAQopzxKMCAmXLw9NJ7NY1M8okBU4+T3Ap3ehesWavMLt+MaGysyj80rCN2QzckezPFXrGAgQDKfk+TbeasOaE86dFI0BSCCMuFe2PYlN43Vd55FC4cmMlo9Bc8an0QExLgjX2JXQN+JDmwV/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325690; c=relaxed/simple;
	bh=6tQxlUMnNV4WeEzT9cdknHxxe0IbCWYAx0ehOE7pgzM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=W3V6/u+7mPILvyKthzNMCJOK/4N8xIlKSW5U2d6Mg5ZDAXISKf9g74kPVt2z9DCfY1ceIK0ah6cCgnNTpBxuF50TVY+IlZKaEhrbttBgzKLaPo+JtsckXeXHTAXWqYuSjLjDEH7b25AJersisyrR4WxUzCFPbqu/b+2W/X9tN4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NAacZewP; arc=fail smtp.client-ip=40.107.75.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk541QjyPts+OMlMiUrHmxU0sTesqLgx3dwyTj2UkWfgCykinZEeAHFiGfmw4tnKT4Ky6/fyKsOVv/vJDkXp9GfX3keC2jtMpkYHMvnON74/KuOsqrr2LtbJ6ZxAfD4w4T7FF+fTH7Fgt6K08OGmHXoPEaFX7/IJqawqCroyV1YiXcWVuigdSN83Ob3hHeetRCchHFf/pi42G5iifyK8+9+8kH1AdVMOnTaKyg+Ie0xa4tMNjju/ggYyCUlzopzswcpUdz5fUOKjD2f8tMtANH1InFLYlGrct34swzaRZwU9AD0SIGhvgjn0a9zc0jht5c492URppQ3IekpFajI29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IALTBW0yBdn7tZYpEpPNJ+zGkiorf8MLyK4sQEvvo/8=;
 b=alyvqp7p+qcX860MGbh69E+uKi4hlhmA29MIrKBjbZz5LxqO8w9VwyrL27onFzW4BvoQuD8OcBPy0ldxnPWUcMaR8sui8H3wNDo0HNBoQeh9JT+ppnEJ9p9IhUcBwLfUm8CYGMo2JekyGlbFxQOsyUDQp9aD0DiRVKkUkj6DfDaSmjz+9cJRquR535NUD47AZsEnCRcfbevNzGkP1VFaD0m0pg4kHd1D4F1yA5oif5gNX1Ob5b0Qx38MjM9O02VKPT6Ruwpcn0URp9yrkBJOXM/oeM7r8OgAUUiQhne0JH5wWaJR+lz2nc7xJ3w6Muh4mFIpz7zfTp6l/GxrQoPavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IALTBW0yBdn7tZYpEpPNJ+zGkiorf8MLyK4sQEvvo/8=;
 b=NAacZewPTPxjs+4hsjIqserBlXpFusIB8KapiKgj2bR2Fh3YytpqVXs6xcT41ImZeZS8sY1S5LprEgCwIeBXBoSyoI9lXgHOaFQNud8m/pUmM/3eWLoqTeBqnl6G2m8tacOqQB8Y1h345kNDhVie00BdDv7GZFYsYd6wwY8mNsgK9lOQ4dShV16Qw9H8hHgh+VeWzcH2dO80bNpcZKVIu4Y+6AuW+xVAMpzyYmbfsIKJgIIX8SFgYvvA8C2rYq1gh1yrCM9JZxEE5rYeNjbsBHp8MG5mpI5F2cLFKKXQNL60Dh/9nBbtwHO17KjdIuBwrwahgHoO6fvS/Q7HNYj5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KUXPR06MB8032.apcprd06.prod.outlook.com (2603:1096:d10:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 19 Jun 2025 09:34:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 09:34:41 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 0/2] nfc: Use str_yes_no() and str_low_high() helper
Date: Thu, 19 Jun 2025 17:34:19 +0800
Message-Id: <20250619093426.121154-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KUXPR06MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 530c1e63-ca1c-4a14-1947-08ddaf148487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gEx9SdM0hV33Zr4CydK6WepGlZ7xZgenOaZTcJBkIn5YIu9VIDfYHpSQD9k?=
 =?us-ascii?Q?hHLOAQlOSoZoTw6OuUBwKcsNy/eoKqMJ0uyIqJAcOqGC5fhTmcMShvKN8Tpw?=
 =?us-ascii?Q?jyPIDrkpcGeUIOL2ivJKqMHcrOrQahErFuKSEWSHA8iSivH7zB7pLRSNV0Ys?=
 =?us-ascii?Q?iPw82DfZxE4L1RZ8YpJ5bRHE5xTKd6WtzO3kszRzADjTxDGtBBho6U2Xsuaw?=
 =?us-ascii?Q?PPjEkWlpyVlniQZ3k5zijnAfMYRsPeWQwWDACNyV7fQrv2ItV6QJrWOm0BfA?=
 =?us-ascii?Q?rQd5t7ezP/v4Cqd/jsc0xIA1VTTgu9F8Eq0xYiAIrSUvWn7FuZRmydW7EWD9?=
 =?us-ascii?Q?sc/DrGCGZL86RODhzRZHrqTrZvkBk4Pb1r6/CN9oRXy3q4TgSO0lzmUqFAvE?=
 =?us-ascii?Q?tEQVkasd3ZIIfipoYQoAQsAuyK5JgKj2vUzYSLpA6lmpaovbkwaUonWO1ff5?=
 =?us-ascii?Q?CdhNaomHoRl6bkTf+/PsKZAhQTG3A64W74rs6f+ONWtKCvwCFHUTuEuUprJa?=
 =?us-ascii?Q?h8IojCpT5KGmdUe6FMUHPnwQMt91fjcg6l+nGzvf6+T7HO0Y9igaiCvwASYb?=
 =?us-ascii?Q?sSLJTxb7tdpL5Li0QdehkJPYCOqbRftSyxy78z9jeTukAUwMK7uMTlpPH5Jd?=
 =?us-ascii?Q?46eJwJR64Pva98qMadOiNgqCxu+bZVHCk0tZjeqZNF/65+11Q9hS6aDgwLZZ?=
 =?us-ascii?Q?ZM6aEroeFlP/7T0n/EgR50ay3tJqz+CJXWgtQnB0UeZFhdA0umiA+fNHICRA?=
 =?us-ascii?Q?6l47zgnF894ZWTSPfEewZVN3a+D8bPg3wt03cZ77GGSlbv06oN7JtpEy07Rq?=
 =?us-ascii?Q?61wVyszx5mzal1C93jMiT7f5yLkl7URV5+sunF93HPX1s1tQoGc5ldpqoO5v?=
 =?us-ascii?Q?OGTQjoNi4Vti2QhJIOK3YXMFR5aSfjlFamuTo3QPWOWZHw6D3EyMvshOu/ao?=
 =?us-ascii?Q?p6XVvTxjrPU23oMDRsB+Br80KDHvhgO8s+SCjwM5ItIr/iJUj8auW3EwQEow?=
 =?us-ascii?Q?ErqI0E98R5SQWtCgapHQKWk97/WRxkdrcmYrXoM62a61aihTzTulDw8rD7o4?=
 =?us-ascii?Q?EiqDjGhuVgX41kHW/GIk3Ow3g8PjBKGgnJa6osSgmCNJgvgI21Mq1JE7lO3H?=
 =?us-ascii?Q?SYoI3/AVVOEj5jrMqO0Ian/2QGNGN+uhqIV4xLQM1RFzNREDw8gXf23uk0xu?=
 =?us-ascii?Q?0d8Q9x5EoCrIl1t6QkMaaVrEXgAM9XSup9xt7bmwXHu1YZ/fq19QxkspNwpK?=
 =?us-ascii?Q?eeNsBXBKpCJcunT1PtykOV1jBYsv/JnJkI/tufyfUD4MEM8IXfIeV1VrUHyU?=
 =?us-ascii?Q?Obg1yOyCuOqp4T/EjtasNr/GQ/M0MCnUs5aC1UcUSbFD9WJ51dVrUxRMZDDr?=
 =?us-ascii?Q?G8qxUBJM81Z1a+LVcvKpqA/LB2lhAyH3E/+6UbMDzCxJK0jequxdkvOiODSZ?=
 =?us-ascii?Q?JiO3Z4UWaZ3iIhNP0pYmWs/Hp92ByYAp71AgRjpluob7U0yo4vC26g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21GHS5cSrcW6vAReRNbCRKLlfuq8UBM6lACgQu7nU8VY7MKR8HksD/pNO3Zk?=
 =?us-ascii?Q?5LesD6H48vBnp0AKzqYZpXsTjoeyR7XPnPn0cQ4nlslEF3oDYuh9x/OKhqJC?=
 =?us-ascii?Q?qDCHXRtCGBM7Ii9CR138VDz6Nh2EMhyqCaHEZ3O2HTjWDOQI7RVUCyds3kjP?=
 =?us-ascii?Q?4u5xOTePz2+G+gNpZsL8co+WybRWHORaFDmFHRWNaeUFO8Ve5s+wYI6yH7uq?=
 =?us-ascii?Q?fkNZqurYZ6/d/ul5s4cVzLa+bZFwm9sQLMxAD/pCPvOz5GeE5EofPej6eCfv?=
 =?us-ascii?Q?iKIJPXMjbAmeNnqiB0cG3cOJ/dBvXSpMij9NnD7yRJ2Ti10WzM3rIHIrLW3I?=
 =?us-ascii?Q?+n7jz3igZEG/7OhO49k6yNLs5GnuLS4pIP8XimW9PJZBxIM+KfVrYQTfjxep?=
 =?us-ascii?Q?9r8TqCFDZze+cOGyxGc3qHbmusKMjfotiXvn4taou/yULhWLtukPj+uzYGML?=
 =?us-ascii?Q?M8x5Sa5TF91mq/0KiWvQXo1DsTcxhAcYaxGtf+Jb2nKcXiKKkdXYZk7cOiga?=
 =?us-ascii?Q?+532uK2DPd9e/i2Qulxn0knsAiIPURbV2hh4sm9zjp7OHUNR66rQr0UfCJH6?=
 =?us-ascii?Q?4v6tc9KLM3qqMOG7vU4thouWs3CftLonoE3SDDoSoOOxWvHiN21ixiYvKRKk?=
 =?us-ascii?Q?VSLZ/jBEEQSaAP42l7dwrxrgTrNaXycZY6ILFqGEwoa4BiN2zAGZLbq2gRcv?=
 =?us-ascii?Q?VLNB1BWSuOCnsi72pVLHBOyTk6qlh+aM1Uad+4j25gzXJ2h9+HKN4FD+6vIT?=
 =?us-ascii?Q?dv9ZaVqnlOdlX6nBXZT8R+4V9VjHp1M/DzncXreD4EzGEuET9igmXRr3Yjr3?=
 =?us-ascii?Q?pbcaVoD3RtTzwb8RT4H7uAaf9uRuMqlVwuA9A0QQBlP63YPI/CYdLdgyqhiV?=
 =?us-ascii?Q?cMYO4FF0/Wu5L7ugeM02GnhsqkVis8tyFlMF8QnCl2jV4EYWlac4BKJahMlI?=
 =?us-ascii?Q?7iMV4mpIcoEyJvSNh0X2EXlyAJMUVI8ETMKqtG4F5s90hwp/OW5Xfz+4wej9?=
 =?us-ascii?Q?H3YLYXxRtA9/E4gyxH2YSSpJ3xTdWGpD7VL3IQnLCRng88jUnVsXQgBbIkxF?=
 =?us-ascii?Q?W6TeJUVRnAW9YjKQ7rBcvl1OQB+s8k5TLYgZYQsztQ/PHsaIF0gC7/AgDa4U?=
 =?us-ascii?Q?xWqnEGi+oWHqcYB73SJbxdmB7UN3yf9fXMYz5H7GwBTPMc6IE0cievyEprdc?=
 =?us-ascii?Q?9DrbQicDi/ypGwY2UAmuJZn5t9r44pwtBOTqi2TwNmqzJtOo+OFy6m+p/peu?=
 =?us-ascii?Q?q9BXdYlDHy4Wkp/JPK9/dweA5dQq9Z3BMABzbwVSxE84kVMQTIMY+BUgryeP?=
 =?us-ascii?Q?Q2nelM2bwzM3GYdV3p7yxeei6ha6upkDVEceJkp/knyUgeero1fy2VfBhxuy?=
 =?us-ascii?Q?VdeXDKCEcRHyq4EL+czblehmWRmsgvelgwA8kOH7tm5DIJnLLcyvibeuwLxW?=
 =?us-ascii?Q?TzlnSnmGCAfNd5R9Tl7rWgK1Uvd9lA/GRFuLvwmA/p7mpk5oROOa4VJ5KPiO?=
 =?us-ascii?Q?klRzSImqCmVdfe7SUxRMuAbyJFCXxeTXRBb94K7oozwe0bPLSgKq7+aXUm+B?=
 =?us-ascii?Q?frNyxIwN71G6ylFAnp5ddo7eVczlnrnAO1T0+sfB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530c1e63-ca1c-4a14-1947-08ddaf148487
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:34:41.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgzA+HiLPBxSmkxJZgji+qhJ9f3ssMsE6YoHuMvbc8AdXGWgXrTUJtSI8wiX13+9Y3wlwfQ5gtrgQ8lldbB0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8032

Remove hard-coded strings by using the str_yes_no() and str_low_high()
helper functions.

Qianfeng Rong (2):
  nfc: fdp: Use str_yes_no() helper
  nfc: pn544: Use str_low_high() helper

 drivers/nfc/fdp/i2c.c   | 3 ++-
 drivers/nfc/pn544/i2c.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1


