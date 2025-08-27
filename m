Return-Path: <netdev+bounces-217240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D0B37F92
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B81891FA4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034032F1FE6;
	Wed, 27 Aug 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AgWzH95i"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9828312E;
	Wed, 27 Aug 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289659; cv=fail; b=ejVwwIURPeBEmKS6xu9R+yZ4YmZ4TRHqnpDY6xnUb10/JZ13ObqV6kojrdSvKagoLgqEozf8vYo4JxqOchYpGWjNTRw2R7/K8fGtOnKnlmiWQ+zn77JJndvlhTpU17SRL3bXAmySHIaeKb8igxclRUCGy9VnmlWjARZq3o33FoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289659; c=relaxed/simple;
	bh=59jM0tj9PNGU+on0vb72vjWfJvD6xjP8aRfPDEizhrw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JpC/JCW0rzcemCHP66+lE7vawnJW+2M3cZjzEB3VcRq+Xc/oZL+ZIxi6FSNZENEuxfcHSFXjbkUbss1y+ucZuHAGP61ao4ZBy8rzR+m3Ym4owz1ktyGyvxVCznfX6pVcPNe1oJjj+YYm/fzQZHupLnD69SIIex48i3N4EjkXGpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AgWzH95i; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrGdvjYCBemwQST7Kz7cIaYnJt0f24VK9UAdUAbOxMQkwSsf58xR23fwK8Aw+jd5j9l8Rlf+oBF1r3TO4p93aSQBLMDZJJhL1L0Isrgf7RFRNsHz2I2CpvkS82+4hUwqS+lJOJFAlCy0KycYO9BvMKv+G/k27CpC0ZNZawI0F1d7Nsc1HzyFVyCnW02/jAQqrwKFz6RI+Rg71zQWEQsgV3cXPeSvX+kfNF0LVgBd/4PehDZuAzS49ceDXXtLCv5eUn9LzUc7aTPq7dlpYIKNoiL60+5wfgeR/oqLXjIhyDgmwZTRan3yK6oCkwstK4DnVHvswXUgSQcn8xWGp62D7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdAW7kPv/VkBxoYUR+M4fySWEFFOxXbd9+3+CjIGrWE=;
 b=Wu1zv7ZnCopjXBtkU1KJsQKbUdonEBheoeXuhyoh0U4PMX/nj8KkN28b+8YpOKxdiSgBIllygABfd7DFfACSjvkS0C7YgCVhsiwYhvp1rqrVN6KauH6prMpBB5bWAa4yEfiLSNBVZSIRhS1924Eg9ylCjFOC06UlwbXe7PvV8kD3pb/Xju2fhc8Qx5LWHIQtVJVfY5DUu96vQWI02RK2JyXoydBFS0rnS/NfAA2cS7/cTPdRScpY6oSSiQBX6VMS6/oVmH4PmLqsnGBW2vg1ms1F2X3+RqnHFMS44J3Hetef+XlDHyrrlyAjBEQsxt54Mwl9j+XIdR3Kkd/1IXBf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdAW7kPv/VkBxoYUR+M4fySWEFFOxXbd9+3+CjIGrWE=;
 b=AgWzH95isAxZK+rEb7SHVHzMDX4Vmoi7nD8MrCsCCwjqADzI8xjOiE197Vx50sViSq7pi8fVH8AYiOH8eGrckqI7399UfGdIs83sQJSRxBPMJc90WQKbR88+lCdhvAqEP1AYaOHDTYEZw7smIxw3V1OC5Aawz8PJeziFyey1SXTkRaxhNxtQeiDBlSysgvcE5bu6wTEMDdgwKf3JL6FMuN0SaBNpnK45At6UGr8agHQ/g0J5xdzMqRZ5oYX6gwayfU7VAJXLUjsKbyy2dhXND9lqMK7b0QQY9A9J9XEm09QE6TPJA6DZ3HuBZyvb0sbg9DNMkYX8/qLgSwRCIyC4Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SG2PR06MB5083.apcprd06.prod.outlook.com (2603:1096:4:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 10:14:15 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:14:15 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com (maintainer:BROCADE BNA 10 GIGABIT ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:BROCADE BNA 10 GIGABIT ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] bna: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 18:14:03 +0800
Message-Id: <20250827101403.443522-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SG2PR06MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: d6694c48-a5fa-4e90-2db9-08dde55279d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjwlv5wRLDl0UosLG36A5awKDAkyMrsGCcgmH88ReM++pwopNqzDDEwI4y0B?=
 =?us-ascii?Q?qJCQXqbESQRAP6fS4QfgsvCAoOoAziGEk3z9nA8FGN9TXgtYgpEVTLLt39n6?=
 =?us-ascii?Q?nDyXCWZmStW2GrmlhzDh7boa5N0V5dsUVKK4kDnNNqUpA8fV+DUJcNwBv7JY?=
 =?us-ascii?Q?jEfg6FxUSw2HZXeYXwct86a1/YZTWHGn/7/HF3Do/k95OsG7X4wCrLoOlpYj?=
 =?us-ascii?Q?TM6A170W5hPERpCfA3IosTOMSO4od5CJhfPz1fW94N/NA4jSHfDeJNDXwXUv?=
 =?us-ascii?Q?WICYFbiPdCf8J2jLZCzLXBO6q/le78vO2jyLA/71hjL/Ew3nJM7uRjedcI0T?=
 =?us-ascii?Q?h50O7OUyozjfqMn9ot60v4yMbAiipePMPj6wdLMU216KKlj/TXv8C5iVzqwg?=
 =?us-ascii?Q?bv10mib202oAPuGKX0BLnOp8AIts741Kp/xIB69YeMO8Zi5WsLHPt2w00bjk?=
 =?us-ascii?Q?3Q5RE7eH0moB/4J6HSLi5THpWvQlMhcKThOfqoSUBQD7ainLshrypn5BBDMh?=
 =?us-ascii?Q?SkX9yfyG5ZLsSXp/iFB1LCegzzFr9ch2AVVK2YApSW5JoUUGYtcthVKWcxJ5?=
 =?us-ascii?Q?4Z5Z3B7qvQg4pJ2nxj3qL+hG8Dn8xA2H2iAiGQzgM/8SPHBQjI6UxCM6/Mik?=
 =?us-ascii?Q?hKSZxbc6J9zHXp+v/9+RQKhEy4R3ubsl9cB/ZzA5NFPhUijxiRM5nN49Fil4?=
 =?us-ascii?Q?+6DSlju+mqsJE8bjfnkkmip9yr7keieVAtZM1ApK5/QQTpNMCHsvED1xjFv8?=
 =?us-ascii?Q?wmo00k299X5m87X119+NyKtnI2kL6KnPbUMdkDXJUP51gnS2fTNcrt2Bcksp?=
 =?us-ascii?Q?gla6LasNiEmgmG3qMTtQf2fMJoQ5pWr6aG1h3tt8hL4+ROaf64hHRqXIG/7t?=
 =?us-ascii?Q?MmoohxVHTBmpCbhEV5GEhEefB+/9K7N2EUrfwUSLy+OH5BjMzxHFB28LEHju?=
 =?us-ascii?Q?hP/dDa75GxJ1GxurABKwYVGi68uk0bEzripbCsyLqboKFjOlxDauTJhPYGOp?=
 =?us-ascii?Q?MBasa2np2UwTgSG6a6LUGL5KgLNJjX7ROCDgoD1mNh6DzgJS2Sh6NfdhmORE?=
 =?us-ascii?Q?buj8zD5NYQ/KI1WtDL2i4WZfh0u1aRtPUsXNPdWVBnhfvAFWlb6HqiOWcwUA?=
 =?us-ascii?Q?2nP0/nrqjbfeX4xyG1KgxTIEa0YU3AXBLXAPmZfINxeEB3GDPwyzmRPOaeYQ?=
 =?us-ascii?Q?biSVXha32ACDeYAQ7TafUKTc1M/A/FCNpKIOPS+Hb5hy5EzAqbYNlFNg2frv?=
 =?us-ascii?Q?GwNZa3VJUGTotE4Q+4VgfaJX18s6/Jag090YD+3Yh7F3bB/lsPTTbBnlKv56?=
 =?us-ascii?Q?v+ULuGz6aCp3pdxr5RBrqwB04zBjjs3QD2m2f8ZWYXGrkuf//cyYNhdWQbe8?=
 =?us-ascii?Q?KOt/4bDXEr44jM9OokFysq5z35T4lXcOD+gXd7dqYpEI58Mw3GdIpE805vt1?=
 =?us-ascii?Q?z7QrqC1oBlhN9io8sLHCfxrBUz+570SCAYixouBs0Jkki6h2TOqEfOgLzJ7p?=
 =?us-ascii?Q?CJRRRxyHayBMgR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYwMyIoNfcQu5qVy+YC+za8X/i8NXnWuUdTyWzlJB9gsbKE1VooAUuZ/2KEO?=
 =?us-ascii?Q?aGeUjFKxTf1KbUAmaU/H5L4fSxqjovWAjazsl+VQHfpKlSDOgftaw8yA47wH?=
 =?us-ascii?Q?A6YGwVYzY/2qzw6Lik1zmzwEOfEX2gvI8ZAMy2FqsfHVlPrJIvdTbYHFEJWV?=
 =?us-ascii?Q?7YNtHUvSjdT4L/5oe6Cbk98q2bDr3Y1gpUz+zIMaQVgjnkrjUjmB1GEZPUuu?=
 =?us-ascii?Q?yYn/Ilzr/IZB4M8Mc+uQ7KhL8GEuORS7z1433HOV8NY57Xu0/EBjxIsCEytT?=
 =?us-ascii?Q?OcNAcfnAf6z+44XwnIEMgoqtE7T1y/MNknn5B4OmFKumQPMn1H/cTISufWZI?=
 =?us-ascii?Q?8Z7+OCR48KYnctGRC+Uws07Jp+b7get1ezf9sKoAhnjKwwxRBQdumfRuq2n7?=
 =?us-ascii?Q?agZFk9RsK/h6kKjiWrKlwWM4XqbZ47UB5U0itxXeMvQguEO299JKbp0paOWv?=
 =?us-ascii?Q?3/kYl59KS4G5+JtkloK0/rvfYjossBHLEgctzcAIZ6m2/HfQbt6eVFN1zu53?=
 =?us-ascii?Q?BwugDaDiWHq5W5imNXbBoL8gbS/Ugs4IZRp6Dd9unu7ec+vebr61F/gCr+aF?=
 =?us-ascii?Q?AqaYSTMsGxV7bqzAei9U2ogI3b2WhOnUNnPXq+kMT2d753lGcbEuwCohdW3m?=
 =?us-ascii?Q?w0csHTAN7IQXuPlq2rNudZEkb2YGgnTwSAGMlmsO94NUXNHm2bPMyZUBxjP+?=
 =?us-ascii?Q?w1I/BPv4BCyuiPaMpn7dkyt4yFlE2B2al0G41JJET3FqAdDNWv34PkRbzl6Y?=
 =?us-ascii?Q?J8XILDHkIVdbLQ0tdgvjG8WaQVMRCWG7VCND7tKJSpakMz9ydjoOitQJRjjI?=
 =?us-ascii?Q?8W3jzj/KWTcVy751W+2J5GM92Q+Hr3vvgr8m6UwIBzQegAuuXFyiD2FKuGt+?=
 =?us-ascii?Q?SvqtJXp7SncuF2WAWyrAWLJ0LgCXHaWqE++/8NU7d/mXfkqYbiFi4zTmV6Bq?=
 =?us-ascii?Q?dHsKGPQlBLOpeznTJ8uxAxz3uBJisjKaA8sVA+UhvPPSHnJqLMudd8PVcqg5?=
 =?us-ascii?Q?owa377gh341Oj3rjc1jAxjxVSKbmiZRClqohji3V4T6Yo0+WYnVe9TaCqAB6?=
 =?us-ascii?Q?EydkyHZm7jm7uKYFXkX9C2+mCqJ29DCF3WVR7kKpE5wq/41AznK+vZySI6ck?=
 =?us-ascii?Q?Uy+oc8EvkdI1Saggz/k+roxKzMOi4In1E+0mv+21UT0pjsrO5ui/apxa5ykS?=
 =?us-ascii?Q?CN/8Kgip6lPGOLStiwMVKUB+t6OB6tjWitRahdjJ/Zbq9UCKeBaDaC3SIB/q?=
 =?us-ascii?Q?2y8o8RqPEshZGtLUY4FrVDQ8McT9BJbSy82fPiTZ9OpMj1HgKpBWU/2w3eqC?=
 =?us-ascii?Q?OFKrdgGYXZFdH66jF0OZ9+zZB6DZ3K9FNnFwKd5bK4avBWaHxO3zRPLkdq83?=
 =?us-ascii?Q?A0m0X3H0daGzzel/9wWi2c9JfBhqQ2Dv1o45SjXvyOxqY2z8bHqh96k/vxpo?=
 =?us-ascii?Q?EU/EpQV1R7epUnULVGD75FentCxrCpqU4omyLiee7gbHbJMfXH4xjni8EwWe?=
 =?us-ascii?Q?Wb0z6ewwhPxmhdq2kAxjoG3G96tiI8mrP+mN/TVl/nmDBClt8vGsNi56b6Ms?=
 =?us-ascii?Q?JgtOvpgTiYLrYvFiTySUEyUw8eIYRhnR03EVOKw6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6694c48-a5fa-4e90-2db9-08dde55279d1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:14:15.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT/lq7hsOmOyrEIKIgqxIARL9OxDM5qR157K7M2ow4xgMn/t90JsfV5zDncaniEsktYatemtY6CvspRtJNGeAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5083

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index 92c7639d1fc7..5bd99dec7490 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -1794,8 +1794,7 @@ bfa_nw_ioc_fwver_cmp(struct bfa_ioc *ioc, struct bfi_ioc_image_hdr *fwhdr)
 	else if (smem_flash_cmp == BFI_IOC_IMG_VER_SAME)
 		return true;
 	else
-		return (drv_smem_cmp == BFI_IOC_IMG_VER_SAME) ?
-			true : false;
+		return drv_smem_cmp == BFI_IOC_IMG_VER_SAME;
 }
 
 /* Return true if current running version is valid. Firmware signature and
-- 
2.34.1


