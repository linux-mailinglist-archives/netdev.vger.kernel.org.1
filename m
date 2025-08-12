Return-Path: <netdev+bounces-212750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CCB21BF1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E546409D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3B23BCE3;
	Tue, 12 Aug 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hCogXiYj"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013053.outbound.protection.outlook.com [40.107.44.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C503169AE6;
	Tue, 12 Aug 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971327; cv=fail; b=ZLbSS0P/xwEibS+kArDABx/cujFHGYoqaKnAVEt2SWC87K0wmwrYRYBWiuaT3U6orgJQUhwUQAS0I0PpD3/NTcMU8bZuvFESjb0EhPzSyHDysb961RXIDabEA5mk/ATZAf0xF2MBa+vN1S+o/QoOOutpxAkF3G+iNvstb2RCiqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971327; c=relaxed/simple;
	bh=yqv0rBI2uc2RepYkyZXpsuCN44/Yn8UL1B5tAEY6CpI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XnWkU3UeDS1fOEuKxuAFq6vxz4ElX18Mvy1O/Z486RJLaGO5EOjeJkh6oNnZZGUpeHBHhuPoRHlTKpCIaD4CYD3yhzWJyVgZpbJkKg9q4juWMrBSc5906jNriGvfXtFx+vztUdHNt5+WS++UEJ9L1hUxkaDgWZeAYiLjP1BAkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hCogXiYj; arc=fail smtp.client-ip=40.107.44.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKfenbg2GIa2cPdVWJXfxpne1ZAMxi/pr56C74EWSB3z5XfnWbyJB6vkWA46HngNYR5OWDGIqVOE07KfyQ97afBq+7puMIa4Pwxz3Sp/+cenEfyktYIPaXFUGZBFiwWBORb+6/J6qQ43eoSHRcHeO2pAC3Kg8bNywWaLoh/yah7HBKfD0eWDoB3FyDKm47eKvpX5p7zMPxRxDiC9zHc3JH+KZE/A9UiNsR68WeFRnJI+jKuxY2WlM7A1uCePigcvuA//VklqWDq5qGHDHaWCkMnW6ZISogpnGr5QuhcDerCnHtydibdQ/6/AKD+Z5HlL/YU0SSHcYjU8xMLbU/IWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p1/lCS0mWRCcPZN7aNHtpeA7dl+yR/wsGf8cHhPtfo=;
 b=f9nI8IW8CorwHESThfSWEe87UEZeDA4ubM74dK5LlhM/kzTPLArmT9iARBk6yqlCdCBmDCeu+wrdlSU/Y6uXyxGdn6hH/WzmlqLefAJl3jWni6zqOQBAdHjPlg0mki3aPhL0eBg6Jwp5o24TW2c7/c3DcLnx5dsB4sIlGpWnSNWcE5jpCAYGbkwHEEsFRSnIVz6s53w8vev2or+l3bTlj8zpzwCWPnGwObWk+JGmyI9z3q5/9qvrTBzPMDWZU3JAAUW7jAN8aJc7m7PKTzJX0XB+rXNmqqCtLvxfCdXRlVpw10VuJewPqHRabUICqCbDZNlwy1xVWg7XlkS6SwTG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p1/lCS0mWRCcPZN7aNHtpeA7dl+yR/wsGf8cHhPtfo=;
 b=hCogXiYjwhN8iSUbRR6cq/885VPPrmIxNY4T7/shEx5dojlAJcesTq612jPNUXtJDQxuel2oJiaRGmuqPdy6i0KHBOx+WqvDboJZJor4P7fbGz186WAh3MSTvMMpfL1YwHAfZHgOhFKaAIShJPHp7Ro4BecxwE6Q6NL/THF+DioL5CM3NJ0PySJu8UT+7ssa9F47M1Md2WWJQrq3m78Y515bCy7tDC3r4hn1SGs8uWZFMPwCr+6OWU6w9yvvUHD0NytpC74Be7+QqNBmOJY0EMS/1w8xlZMzyLUQWfXzKfkN6RBkbTnYmBS3vbIUjtlhs7RppWN/4016uIM62AwMMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SI2PR06MB5362.apcprd06.prod.outlook.com (2603:1096:4:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 04:02:02 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 04:02:02 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK)),
	netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] vsock/test: Remove redundant semicolons
Date: Tue, 12 Aug 2025 12:01:15 +0800
Message-Id: <20250812040115.502956-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SI2PR06MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: ce494442-92d5-437d-5536-08ddd954fe44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKfeUUR+9vTPaY+Ykj0X9o3hByRcXTc45lgW4kv7Gw8aqvGy5ULbUv3DwPwo?=
 =?us-ascii?Q?jS34EfqFyirNZm1iVDrUJl3Z1UKi3Q2RJQBjSTJd7OOMuq9tcELOFxwYBcmK?=
 =?us-ascii?Q?Sm5HT9GQnT3QKZ+zu+rExvD/IeElHvIdRgHwO9H+JtzRxVGqobMbdta3E1/C?=
 =?us-ascii?Q?tB7wUzRhXnUGmul3gJxyQUaD5/ucgkJkGpMG/DWCehYId4FmPzGW5TSFDZzE?=
 =?us-ascii?Q?94UFuvoWbMvPGArvGTiP1Qfkn2ehNlaALlacGtG2DbdDexpToCuEoR62i3cl?=
 =?us-ascii?Q?RNaWA0KaeO3G7Lsc12jezu2eNyv5h+4POgxQnbsVbiuFV0ft6KA+zBBl32kh?=
 =?us-ascii?Q?5DHokddCIDt1zmlov7VoV6u4Ht+Ad3PFSw6nsYIFK/ClXmGQBJ2N1qMuiHlK?=
 =?us-ascii?Q?Djh9mdj5L6KUOnkpIxbTVau5SVGyIq3V2soxbh0/Af4cSUFiRmmVlzq5oSH7?=
 =?us-ascii?Q?txIouNAalHQcSKbIxBmwVMWDnMrSp962ynBJLAqDHISIMRNYkVTaWWhEUjnW?=
 =?us-ascii?Q?B/4XcKnaJTIrh3dhe1ARH+mfQPqDD5I95VKw5fkKBlLEjqq5OmKW5wA0XqWd?=
 =?us-ascii?Q?ecjDRQSw+AA8XtLGdZbZdh807twN8UyktOrIOpGPvkeuYBYnbHHv+0Qh07Sb?=
 =?us-ascii?Q?QA8ROtJg8PE9ZHUAx68P3WMJTbfFp9r9iB73RrdHZmJZVjdoQoJ77X8gJXCA?=
 =?us-ascii?Q?OCtBXQAITXfk3L28m4iE9KkGLMXsAKId9EITxcXp/QMB3kJCmT1JMsnBxDey?=
 =?us-ascii?Q?1k0+29ZFJrQKepFgysk815QCThtfpnxqwk1dCnpmxxgcVjJ1o1U4uCiiAmbc?=
 =?us-ascii?Q?i+9pqE1E5kuXZ9wBybdYFHY2hyfjh9+xhYOLD5AxwNXAUaS14KT/ciUsGipc?=
 =?us-ascii?Q?v35xfUSFzHw9Jq9SIgZAPyd7NwU37JTP6sbnCntBUipN8r2rIDGQRDRmsJKF?=
 =?us-ascii?Q?HmMfVGbH1DgPM1etlwYGujfQ3JJjpPkSQ/5MfZAkf95BboBiixM6e77k/arg?=
 =?us-ascii?Q?fTclZ6MVYIoxO7pQP2lEPW1NiH9iMZw/yffI09TcsxCS5kCdcZwmoP8RL0J0?=
 =?us-ascii?Q?5SQ9CEyjpzzyDpvIw8b8v2iVKVy/QEZFhg5C5W2p41ybNXaHm3iUteDKEL2D?=
 =?us-ascii?Q?00bma34KMLN3OiHr03j+VfCmvC2Gv/1YrhLUvSESv4KtV8CGFeyCEUiPQj82?=
 =?us-ascii?Q?qg5pTROMHwRILjgnIaZUalSGlYoK4KFtR2irt4mke0FaT+N3d22U9it3Gia4?=
 =?us-ascii?Q?3pirt1Np4UyzQeKWPYzPO30X7mP2zU/w67f8ojWiIt9o7PRlqC1tPw6MyB+o?=
 =?us-ascii?Q?5ZV0VecVg5vhow2Fskiq/X/FYtDgafpNTEDN5GUhPEN3zOyTwcDlqcLebfha?=
 =?us-ascii?Q?PHyH9+i944VIMmC8wZPN1yAypUbP12Ge92m/tCo4nMf3m8ZpQUJYurtNji3U?=
 =?us-ascii?Q?sBWxedeDyZepIGKFKJHsX5cYNmwvl0n9Yq5ZIGelEc1BOrkwFGJBeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGQCSpmSbtRk6+rx8lkuTZV6+/5EuzJzZtGqyS5EyHAuR2HQCGv1Zba7cm6K?=
 =?us-ascii?Q?KRuhvLgVUC87yH4KA/fwO7JltZiI24ye5NgFUOFe5xvw81zsS/OjHSSOY7hL?=
 =?us-ascii?Q?392KCIOHk+W/f2YqVG6Q5lxp7Dk4F8LjuO82HJ5gvdAS17NHTv+seVcq0BsF?=
 =?us-ascii?Q?k9Xn/6mFfPJXCmERdnglcrRKLUIYspnF03VGUF0+FE2BZoOhPmpobJ+dlxGr?=
 =?us-ascii?Q?tAndkG+mqSBDED4OlMDXEeKLoL5RRkp1fLFH2YolvQic4q0v7LCLRLNEv14B?=
 =?us-ascii?Q?L1qYZEBJR+AqcmPRwtyhN/tpwRyh1QFaSIzVeuGxqz9Kw06CuzEGJGE296AU?=
 =?us-ascii?Q?bK/A8CVXVHBdChtHCixtqUIVDoBDu1ZxfRXNU7qIKWAPHa1pKVvlHW+P9M0C?=
 =?us-ascii?Q?Xpry4k1U9DeIH31WLDuU3Hl2v58BOFhg/3P0zMPyRl3JjSM0V2vxJcvFmSzq?=
 =?us-ascii?Q?086efmFLn51ql9yOZgp+grYUtD2WQ86FFwGYyGavPnlssMnWW1PMT2RZy4B+?=
 =?us-ascii?Q?f+EWfMyFPX36xFJPCOcsHEU8v698S4CPnxqP/ABukC4D1n5j93wNKdWW5RBw?=
 =?us-ascii?Q?cjLc6Xm3PxBA8E0L3PIYcnsz+VR6j04mE+/JhcgtkIcOx/yiwXguwnbS0uie?=
 =?us-ascii?Q?wx9ijoioXRT2+n0zDCYGQaEQAlLtcONA0VvAapFiJBAY/iMUeTLIZP/JMGB+?=
 =?us-ascii?Q?2Zjd6r680eud4U1njc+SeDMSMEV1kW6s33ieMZBsj5I6BECVmIa4dKg0G/Ur?=
 =?us-ascii?Q?4+HnlTu0cLF7zIhq1DLEpz/Ss+jTuCbnzln8rVUvB86EzJPZBTUR2jcSccmz?=
 =?us-ascii?Q?5ajRv/uBH0ZzjCsORESQ+jgXUbfrJZOHH5JP+eH0mNMwKGpac0HXZyF+iCRW?=
 =?us-ascii?Q?ZFZ9a5FjrIuP/p7lWYKDLAOMdqljpsC+l+00y2i+KLtm5/k7Ty95pnpm2U/q?=
 =?us-ascii?Q?OhJy7fAoPum1r/13pspwRmcERYu2t0Jc8LwHe+83Qi8heo1qx2QKE9hoe2tc?=
 =?us-ascii?Q?9iQlq6LiGBzcLlzlO73D2LigwPR8LOu48tSusuZptS76ovZ3bvzx+phU0UkQ?=
 =?us-ascii?Q?uunYbZCMlHyEtuO+KYujQIF50EBB+eA1rKzJuwpqjajaeoh/2keE4RmagxzS?=
 =?us-ascii?Q?p9HvCcIaVZKAy9QJXQJCdxT2apNbveZ60ff4v2ETSLTi40mdjtYr5miVHGG5?=
 =?us-ascii?Q?wl4XewPUeL6WF+q4y4Mo39zYhtDdYGeDBJ+Vt+hYKMf8GGTEzSXFZimWfsNB?=
 =?us-ascii?Q?yoTMl6fxJ/tojPwWR5rtalOOV4zA6aAvBh0vv4sO8ZrFjCTO9RklEITN+89Y?=
 =?us-ascii?Q?KLsEHj+6s3hBitSLZ++RE5cdl+8PduNuOkf49EhgyDJ6jvCje594F1X6Qc/T?=
 =?us-ascii?Q?aH9uGE41Ua7g8NzRzNarV0yji0HMiDLZ00q5zZXDHzGtq8kczKw8+9IJXu3A?=
 =?us-ascii?Q?NZPZx3XG/Z6jxF9IXUjqwIfM7v0D2P8yH5ZgXpQ+RyDp7+8nQLBWXmiO02/m?=
 =?us-ascii?Q?4RLkWCeWeTwdOi/MrvU+oTK/BjQMG5xuIS/upu/avOG1TPbJYJHel+ojK3w8?=
 =?us-ascii?Q?FZUG/EJ+9SkGfPhPra+P63QsBPp9jJ4bJpqZ2Vmn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce494442-92d5-437d-5536-08ddd954fe44
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 04:02:02.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 005kpDx7IJVA+wNAT5H7Owc0O5KK1NBtGueQJj1o67Ktn6VIoSP7n+l3JjVIyu6PZFwiONVjJ4ZGGIMI1ZTB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5362

Remove unnecessary semicolons.

Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 tools/testing/vsock/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 7b861a8e997a..d843643ced6b 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
 fail:
 	fprintf(stderr, "%s  val %llu\n", errmsg, val);
 	exit(EXIT_FAILURE);
-;
 }
 
 /* Set "int" socket option and check that it's indeed set */
-- 
2.34.1


