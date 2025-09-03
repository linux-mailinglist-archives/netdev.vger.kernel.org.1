Return-Path: <netdev+bounces-219558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FAB41F27
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B0C7AD657
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6B301006;
	Wed,  3 Sep 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JyTCEg4K"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739462FD1D0;
	Wed,  3 Sep 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902864; cv=fail; b=ibBaZL29WJddsCMC+bGLZKMCRzsct6Y1Vbfw1ak5dOUjoDL577MD3FQAOwVrgXTVbaTY4x4Pl+HtrPA9ZpYlZe1JeVkTSeJKXhkyN7f5Jg7OFFbLyGDj/bmk629mzK1Zy4ZikeJT/u5vRv2lgFEImEnW2Zt5eZAX/ZR5vOwqqo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902864; c=relaxed/simple;
	bh=9VpMP6ex7tbZwDTYc3XAGGMkGVGK9pg4pNYcrjSkVRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oaI83JxQ28Tyd3Xb+TjxhnVbSUyXblO8nieeoKwJVxahoGckcD5bqVv2LueBCQVjSfmN/t90p+Pe/stgaKLjzbhVmDv3UBrZ2k+0ikEOETj40vxjc/eLnH1TZ+Np7VQVxilQnNmFKUFNgbXcsGofiTBxE1FWmSOVK0n8DVTDko4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JyTCEg4K; arc=fail smtp.client-ip=40.107.44.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVXP3gMBkFZxrjhFAJ2MoV5lOyOOYhJiit98FFXEyYdUTh2vQO985hmGKNjZ8jL7shZVs9rj+a/TwGRTv8EllcQa6UAorbMjzpl7qu4HrWRAbHPmKVVSl0emAZn4J95Xr0/bsMaXPNx21JTcUz95TnUmuwrroxJ/uh74CXdDQxsW+g56aK4kGBI1Ji/I2rEfRRjYJ1dHJPgQn6e4InEzUGKkltoyztm4eeApd40nouIhMqG9m1vj4eh2S+GxaE75yeXlym0vA0rD4GPgACiLZ8Hd75BoS7ot0tarZXccqUkECxtWARHoSr8hBTQxHRgAvfPLviUM3bRfij9uLcX3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5AB4V5aRDk6Jmer9TOS8e86/wFFsv59UYhVb7Rdjqw=;
 b=LEWx27lc1GXh7BO8oW9t4ylLddXzLo0tAAB4vc2UGWbufiGEWsg5QQGomE+TdetVVFaNxgulsiaTFlSrk1qcXB4C/vTS9UpsMaGnj51VUfdOUDngB/ZV8mUL1V//INtzFUJH/9Dso6WQ/40n/sq1m9LWr0GiaoDKXqf8erzslaTaqjj29MbyuXnR+kD/tggPIkQpmKEYawBNaW1wokShaCdiSX5cgc8uBco8cJhmoHcdUHh9df9RJFalExEAQPizxPUH5ur//Yw7vLEqm/sCaR4mWjLD9+d10FTOTt/frXQr4dg+OG5/T+a+Pgev9edrZKD+L+A9/WmERrRcRTs1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5AB4V5aRDk6Jmer9TOS8e86/wFFsv59UYhVb7Rdjqw=;
 b=JyTCEg4KJhtAj57sKfRhTU2NRfPIQ/HrAx6rC//2iwC5p7wQHeJLIJmDnCYYzhkgRlcuXtEJEOHArofuBOk6FPYuNmvnnDGAQ34KWfBBXAfownOJu39fX0vKZQP01CqcVVdC91tiqOTu5k/sVNCm2f1UUB3yCSzAOOSEfta5rRIgQ6Pk7uZv1XQgIsHMRdJIdEHJR5El3Plm1r9EZ5MJgTx2wxp6bgdkW8Ws0hmeyHmYI7nyXYm/vP8Fe8tMWMGXNy4fr8UWKVS0vqHBzIcx6uc9x/BTVkDzTy0rzB/kQlCQsNZQNM/6yFDUO0CfWJRxBgw3qZfT4oqr8+42rxplQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5755.apcprd06.prod.outlook.com (2603:1096:400:27d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:18 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 12:34:18 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] net: dsa: dsa_loop: use int type to store negative error codes
Date: Wed,  3 Sep 2025 20:34:03 +0800
Message-Id: <20250903123404.395946-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0346.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0c1a5c-472e-4a63-f24e-08ddeae63369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oyLdfvZHLzxNJyxtnSDm515bWXUIcFUL3BadwD+EKuAqqHuj6RFiKug3COdm?=
 =?us-ascii?Q?mSqqlAutdWh2cZrcT02aJNeyN4X2rFFMVc2U2CR7IlVFNL+wVlC2weZ0wNTl?=
 =?us-ascii?Q?eemIVLZZ4s2xGoWioNhvLNdOGenTR9QX4OXzoMPaqntYonWNF0v8JU4S+4X7?=
 =?us-ascii?Q?I2uMMGzkGrrVMOisYdCQ8rCiwYzLP/87ExBdxQxkQY+QBCVLtOFUOaYruEWu?=
 =?us-ascii?Q?wICkU9hUjEHFVGGUShPgHuapBHXU5UbNBCaehDm0no9J4u144H7E4K9ZgH4Q?=
 =?us-ascii?Q?RrBOHaW0ap7brswo2XuVQJVDHdgidFuKuNrgOKuNZ/VX6qDZPi45kO4f1qvK?=
 =?us-ascii?Q?xm5hTyh/761C7Al2Y15d+vHuFksRp5nY2FAG+ZAu4hv1KWgv3YMNw37GutmD?=
 =?us-ascii?Q?lFaiKqKSekIca++yRxd5ycZz/rXrs6t2/Tq/kJ1hPHUKmsEhketxT4tsGjEt?=
 =?us-ascii?Q?fjaRs82ZyZKSbUTBezcsxsrik7h9Rxnxxa3uWe42TPgDo8zzDe2UNfDZKUTp?=
 =?us-ascii?Q?kSqS4DVSIYlX1CQvv5rQbG0t3qywxRWozXvJhuYvPjqD5ZoUccoLbzks1Hss?=
 =?us-ascii?Q?ZRRl51RkKlhIQXDK/wseI8KXd85jYYp+0Woj5doUGM11mEiRGvBqVEJSbD8C?=
 =?us-ascii?Q?99tP8ISdCfDoEfb7HWqEv6n3hFFkfkPzvV1JeWfiH6IqW0jiDK7pvxk2Lnj5?=
 =?us-ascii?Q?tO+PNT5V271m6/MLg9HPe+FffhMhJj1xgit+VsjrsCVp6xbj1Zst4LPJYnyL?=
 =?us-ascii?Q?iwy4xTsbajKehZWfaNYlIam9QGwOD+sAXvgBaBSJA5b5Wx5xar3w5w0ae2Rx?=
 =?us-ascii?Q?DjuFxQ8LuPuY4s/m6MuIwcd79gxLj95VulWJK4Nerd9mfTmYUidF0u+CY04x?=
 =?us-ascii?Q?kH4L28YRyUmeLjK39Gmv/8wp8uC9zRO4+FNWDnE/xtdZl/YsqrdGH/3r30SB?=
 =?us-ascii?Q?JBmxGnGODXfP080JD5W/1Pap4T4Ssf39/ipTkDaD3Tb6Qk5DHVfKMfNGOFpU?=
 =?us-ascii?Q?zJVcFkLcSPZGONEmhDDZWf7oApQWErLvZIHNu1X2xgiY6goPpBlAdikn5J5f?=
 =?us-ascii?Q?42AarX8jsyhw7mjlu21kfoZF/Y9D5ORd0pEa0AhAj94uVkLDZxRVGrrZKLme?=
 =?us-ascii?Q?WV33YmsIWlz2rCBLOW6rtRc3XKPTZrgtuv0y78VAEdm6505J/E1aUOaHRYAd?=
 =?us-ascii?Q?l4BYU2ND5/7ncgNKxFbRszI8j9VwPbENdNaBRkOcHX0EdB6dP+MptKufQRnT?=
 =?us-ascii?Q?Em9tDZMfrGXWZ8oduN4Jy6GDesVy5XlSymbOQS6RD3D17wGfHpHpd6sEA8F6?=
 =?us-ascii?Q?gt5L/jL4qlszTUjyUMWQbpDsrdTMpUZlar64leBd8BjdZAJ8IpyQsbBtuNnn?=
 =?us-ascii?Q?aNtXQEI8pd2Z6KwVb+FLRSiKtjOTrVi3yQ51sGT++eG3tWZ1FNt76WVwhtIP?=
 =?us-ascii?Q?OwXovLwCTJGOOhVJoo/L6NC/xggoWTtch/9WhCZ4IWKyj4bbmKiL+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zc1xjKTySK3PMNymHZ7QkCSGtZgXEQ1RsdTZPz5iMlmnXiz9fMcLN/1aKCT2?=
 =?us-ascii?Q?ujfVyHirSsdDHYn2vU6aD2Hvtw6KvHba3277MlOxwL9Gsw+nf9o5oUQxx6DN?=
 =?us-ascii?Q?pez8T6vh4yPbCqI6VwZDbj9wQg16qUmOM/3yOiVNVJTttnrxbco37/9lqeju?=
 =?us-ascii?Q?X2NYbLvFnbu4N6B6M70pZAmoUeGpH8ll+ak3jlgIN2JbTS3pjzTMb3fDemc8?=
 =?us-ascii?Q?VELE7nav7cSH+RlUx/iqmXajfg/h3lolDYxNBxFCZkTICmdTmc6n2SqCa/OT?=
 =?us-ascii?Q?9jR0iYfLD/AZyi/FjLLgVqOWxlpZ757pcPb54SlNkLFosw7u9uUFB4reJOCO?=
 =?us-ascii?Q?Awy4DA4VWjm+X4iStpJ0uFLxk0HvvJFB1qDv+kc31WYZS6CS2bweSqlyeoNY?=
 =?us-ascii?Q?QRScPqc/BPMzCorLk72kiq9ChiOSHBlsyaMPKnew65Bc2D10j3dCtgxgEXLM?=
 =?us-ascii?Q?ijYrrKx9Qgwg1vVXdOZ7Rh07JB++vnMSl9rbZ933zBFt7y0Tzbeto1bti342?=
 =?us-ascii?Q?NtKjMAsxpq+2j1DhkIphrbON//lGiWh1FiLqgCt2epocHWn7qLqMpzKkI+GP?=
 =?us-ascii?Q?LY8a8Ls8kFglaiGl9GkUJkCeb7qddPY99HOy7W1GVvRSUNfoBXQMVZ2KaHHs?=
 =?us-ascii?Q?zrO3J+E+UW2z56UqeQQMkbdihHTvXQuQpRGzAhaVmZZXbhlluAy5pzA2b1L6?=
 =?us-ascii?Q?71mKVhyDA4ZLPaJz5IS8YNvSHKWZZ6zyJArPhs5NSecqyumj4d1vfhTSn9Y0?=
 =?us-ascii?Q?HfXyw0cSKgyHxW+qX+DvwW+Fu0Z7jKjS/40S0WzAhyRnVcY1g8YXIgyKeVOE?=
 =?us-ascii?Q?7OLREC35aeyBZJGCMSBUq19KxYvFYiz0akK5E8G7JG6okFd3kUo6v+z7Z0Ee?=
 =?us-ascii?Q?blfnRVX5LsquPQiAaxHNLJe39A1uXQSPqVdMWzl08BcHjLycYE/pU/BVLzNc?=
 =?us-ascii?Q?jPBx2Mp+gpSP0kRQavu4kLADuvDjwSnk5LPPhk2JBRdVGNkcTpGuPEILvFN8?=
 =?us-ascii?Q?42YW9oObJsHxqXVhfv/RApYoZDjaCaGj6M+utE++/CUcgbk+YTMvs2FnMdCC?=
 =?us-ascii?Q?GsS9ES2eO3PBzZcK+688BSdpfvow0eCLaLv6o4Ouqvm1etm9tYkDk3wCiUjv?=
 =?us-ascii?Q?pES9q8EPvg3VQGaw5vMxwKX24qZiv94+kJOrhvR9xBKtQu8O09hMmTV+l1b5?=
 =?us-ascii?Q?4PcmyrV9dhvE71BOB6F0pOlQkw51Iq1Sd8NqzNf7ex7bsV8Ch1SHV6LqTcBo?=
 =?us-ascii?Q?ftZHz3pnOo3elOIAi99T4JgyWbWSB1jDgAwvbOJqPF2zA8hGn5oeRgsX6NtY?=
 =?us-ascii?Q?hcklnyj/90UCrHFSI9lTXm5E0XHCZkmyU+pktO92HvLKIz8bt/eJWWR4Bft9?=
 =?us-ascii?Q?P9jj/hkideePWJACYgQBeJmIO7/Ndb0fECbTpX5DNXciua2Jbo6moClz3JWi?=
 =?us-ascii?Q?QM9NfALaQ2a9BYhSDs9MdJn3hCQj49tuWGH9aqitvc0RSLLSYukdnCQc8Oiu?=
 =?us-ascii?Q?Jyed+CXQFyUN68t0x1D5HkkDwmA955BIrD2joLecO7eNgvILeVu8N9JhHDZ6?=
 =?us-ascii?Q?sInvvHzLRolZqx6fYMfM19pj4+7F4FYTEndw8Gt1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0c1a5c-472e-4a63-f24e-08ddeae63369
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:18.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnNNtqx6DOP+QxetSpUAes+3aGW7na7nRZAwbIAklqICz5uHpsGCUdCQaF4B3vY92v3F+hG0VwJfBov3cov3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5755

Change the 'ret' variable in dsa_loop_init() from unsigned int to int, as
it needs to store either negative error codes or zero returned by
mdio_driver_register().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing.  Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/dsa/dsa_loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index ad907287a853..8112515d545e 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -399,7 +399,8 @@ static int __init dsa_loop_init(void)
 		.speed = SPEED_100,
 		.duplex = DUPLEX_FULL,
 	};
-	unsigned int i, ret;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < NUM_FIXED_PHYS; i++)
 		phydevs[i] = fixed_phy_register(&status, NULL);
-- 
2.34.1


