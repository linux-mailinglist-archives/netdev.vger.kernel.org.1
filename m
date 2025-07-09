Return-Path: <netdev+bounces-205229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265BAFDD5E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF84E4564
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585D1DF73C;
	Wed,  9 Jul 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f0kMM5id"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012027.outbound.protection.outlook.com [40.107.75.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5591D54F7;
	Wed,  9 Jul 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027798; cv=fail; b=Garnzozh0NNp96UmLkarmK6j/ts2A1oQL0NNMSiAW+TtzmDhEd/JpNkvxuhxvqUuPCUd80MFFxj8vNcWCiIrpma9QC33vkoM8RLvf6Q/HGYYGlMIDzX+WFkVl2T488xFMkDlgNcljHyL5o6Vx+dTXZM/L6PEksWdhE1Ke6tEEKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027798; c=relaxed/simple;
	bh=ow8Qm9HHLFU5MvXgbeURI+2Ys7/CsQhWEBBlflHju3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyMFH8h6c3cvU7uGMfZNNr6x7HqDl/EBVWekWeSJ0bpIZNRID+ZhqNla78RrrDfGP63k2RvRozMHmyY0LIT2pDiHUnGK2mEzaB9nwg0azXpkHoCYoiGWR78Wk6S5GP4PPwljD937iAbInPppQf3dg456+7ed7mO52Kh0/qvDV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f0kMM5id; arc=fail smtp.client-ip=40.107.75.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCvK2+uazQ5f8au+E7rNFdkZOb1OEYn7bC2x9xhjXjFLz8GCdVZKuhh4C7lLsyCPYL9LoZTqTJOqvzUrZ1WXv+dMzZsWpS+IZvr7suJEHdFtpZgQUch1okWgzyAVn7IfVzgnxYYBfjvIfWmDpENwY5ixqIpAAAILcLpTNZz+ups57rO99ldvA9PahWjmERoJDYD/nKAD6CADCz8urElLnAzjEeaLs4AkYuTVE3AliiqNTsMK2eGGU+aS1IN0+NxVlMfYReyYgBXQWuNrFFLlujdVUsjnVvm5j8nbYmYlOg1N9RkGeEVLZHj9obB8w7DczNxLD0yVRCVWbC6VkrGmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81sT630D/Wj7jkx79TkdajINwWG2wRKsbqKwivrX67k=;
 b=YUILHr3Ir4G7J5BbrVfFiq5f3NOyEGwUpVBKjsPD5PjhT3uuPC93vk46e0SzDDS96AvDQwtAZ9gcSwawb2BmJM10hsyhmFEdQ8ZKFPb7r6hvvpFJaNGYRDzW3Ng8R4DPBO02egiWNWpcPZprI7ajv119b5IdoHWpFjycCSuot5+7uPGSSsKUUTNdlfqrK4zPouJ7vMmszljezgAxWB+jwDV3o/I0UuLRAv+eKBBtXjyQh1xBxFA71WT+4rKHjfN2XSJppF5p0pWlGcHVEwPwlk6bi2Sox7U/hwkNFPNuK+cxfqnwiewYABbABHqLm6d2oD5E7W3ShxaNcf6RZQWyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81sT630D/Wj7jkx79TkdajINwWG2wRKsbqKwivrX67k=;
 b=f0kMM5idZ/m8G1DGGUQxReaRaJZWsMQ7RRyH2n4B64QmrNIcpWJ0khDwY3o0fP+885gUEydZvLWP3nJpdCrZPLvusisgTxSK9oCZcs+k/bF7QrjIwBf5HwEmo4KHMFzW4PLvrScuCiKrtcZOausiLb93ka3GlaEYyf73++F69vLnS9jCpZ7B2ej/fyAGBtGbpZXFaM3tDsTSiwdzzHvRrC24NYCBhWGzJxE8Vic5LSPuLF8egGH1WSyg6Pob9UIAHfWejNHmgTmY3aUWqyi+1yT5lLXs4cftElmMOTgRCPubIRv5PG+XxHrTEtBobkKEzEzRxQRFkCDwd668laTj7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:14 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:14 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:MARVELL OCTEON ENDPOINT DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 03/12] ethernet: octeon_ep: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:31 +0800
Message-Id: <20250709022210.304030-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fe82f7-c504-4499-0581-08ddbe8f8ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FhR49UAbaggwBPzejfU1IrtOJYKlp9Ysj3uO82ywrqkCfLiWBqE75ozjtDsR?=
 =?us-ascii?Q?aJLRz63EhC5GIYh9i/ziNxZuZG9lArwayZFZgH0jrH4nJIqKg0CR/7KygPi4?=
 =?us-ascii?Q?l81eVeOGKNuYfAhmz/QeSs/Lt6eN3IIjaNivCYw2uOdlZSp+iGFr7vb7m+9L?=
 =?us-ascii?Q?+mdWGOPic2Ym9Fa23ki69k3279ObYbDTgrUqvrvJJRFVxaBzsydzkKjaO44W?=
 =?us-ascii?Q?nJ9AoPzvmtJGrYDFCEqGgkD5ZW2FqSt6ayfHq83ytUDaTDNc3GmCpNB1xMDC?=
 =?us-ascii?Q?e6OZjd0lSucIgWSxNUSK7iUhFvqjtlhoIgF049dE94aMXYMyEuXfEo5fjd9I?=
 =?us-ascii?Q?jydSdFmMDCd/RBSVF+yu0NLojzy0B1VxmDMpu/iAUpTGSDnnfDJy2bgC4ngs?=
 =?us-ascii?Q?qb63svHS6bnPjQG7BmebTtsxMsIidPbK6XAa6XNVQLlOP7+EHITVmndaJLoX?=
 =?us-ascii?Q?wAjJoKz7DTVlKd3Qsr/j+uvC4mrtjRDX0x4Y1ogi7GMbyHLVLizsYxZ+Si/C?=
 =?us-ascii?Q?blkdabVsQxTAe4Z9rE8TFQsBOimKCwrDKr3lAbB4EIqx7CwOTlt00eGOA5T4?=
 =?us-ascii?Q?ngAg0MUrVQe1tocITc88q2FPIcUF1HX1etIgdb/MK65G5tDic7R9Ho2DR4zh?=
 =?us-ascii?Q?FwmSQC+fp8CR5rvQETCyFbGRVrAXqCUNl23pJZEYnXxzTD34fVpehUUsdcau?=
 =?us-ascii?Q?zN+TvHgTQYq+e3flBJPW9zzMIghjg2srgNqh7cgZcgSe3l1B0tM30/z5oFIW?=
 =?us-ascii?Q?ldKuLTxdbop7dBezIFx262+88AJ3tJYe/dz3W/yd5236fZ+SoAkmvPE8z+GC?=
 =?us-ascii?Q?D9Tr7MHa+IiNShbqM6kcTG6OIta8V3dfTMXIe8W8o8AfJ5Ytq0aYB6ynQAq5?=
 =?us-ascii?Q?WEJIgpDCrXMeiojm1Wzi7xMY7YkvgeYl0UmS1mR1O/G30veIwcTtbFPBsHI2?=
 =?us-ascii?Q?NlqhBcU4Es7dPq70YpZR0ra7sOAOjoZR3Tw8pdeSIxzwwk72ZKdgN7zpE1iv?=
 =?us-ascii?Q?yPbVt9kok2wERUUkZkVKitFU5r/WXG3bUzzlBVyaVBoN+AKC9BqhyOYrFZof?=
 =?us-ascii?Q?dHd2BP4gfaXW8W9GoabJbQWDu9UQGVURs3yp9r4TJxP5V4OVF3hF9ahxzLP9?=
 =?us-ascii?Q?VMP8dYVFp59XH5ArXVJEoBWDC+MQCbXV3gDj0xbNVfXlA4Hd+u8KhW9HYgBe?=
 =?us-ascii?Q?w1jfAXNGjV2/uv2rw0+KilRpXTsL0APYUhBE6JcqkI/1ZjeWTrgJQK8HFOUO?=
 =?us-ascii?Q?dnR3arn/lYZkfCmNNqQIqBC49J71WnK9wc/prR6woxJEAfHPgxbS0sEBvSM2?=
 =?us-ascii?Q?Il0S6neBRyXhntWO87lDM8liKvJ8fnRcLO7YP8yf4Nx5eYEjMU6fkxiD4Vs9?=
 =?us-ascii?Q?xtYq0JRjUwogWjwfNucTAwtm2UaFt+FXzX5lDI6gAVolQimdn6BLreK6231w?=
 =?us-ascii?Q?zhZEoVZY5gYAP8XSpTK5aEEVgm/wUelteW3h3fimpXJBHUGbwa3cnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQHcG9jX2iftIt5vxKzmxki8ZSqZ3n7oJYCz/wFmt5Q1+VeL9NBylGtXH6gN?=
 =?us-ascii?Q?IjBFRvtym5kctpi0HWwoXVgXy3Pk974CP8eb0ZhwTLlvLyxcKP9JSj98ijiB?=
 =?us-ascii?Q?btBnwTylcCWRux/6vqBRFxHwW8zi4s7NKVgSSQ646NXQ4fNeMQHkN/ZHcDRI?=
 =?us-ascii?Q?vbOe0WU1b3QaeNvt1mxmBt3MBXR9/X7CiHzGmS4IqDvvk/5goOP+uSNgbFsw?=
 =?us-ascii?Q?MaAQiKRsYdkUK6Y1nm1H/AlE6bww5pYKvahaceuxUpWbwJfSjA/qB5lcL9Zn?=
 =?us-ascii?Q?sSnOtp/PIqnPHVEWIp/1zyULCjMTDpSTTOvWyGTdYNkT6onY/tGNmXB8Up/b?=
 =?us-ascii?Q?BXfNC11rEcA/Mp3kwMZQsteuTzYRqu7BvaVm4SSAae/HuKpDwd8PCVkH0+wf?=
 =?us-ascii?Q?fBerxklYN+5mkUigVJxNx/P4dqE6Iv3Gs5eEk1+AS4qebARuiHM9smOtyhDH?=
 =?us-ascii?Q?IWuvMprxbiw6NbRkpLMXDSSTOWQ6NhVW1MQHQrX+D67JNFnGXQdF5QnKfJSg?=
 =?us-ascii?Q?3VXfXzoXnYa8S4al2MZCQH6Gv9IAlMgO5eOEEsvisir+7V67GLbym8g5JDsy?=
 =?us-ascii?Q?qDEZ2UQbLe2odVb8b9ukp7M26JHwMF83qskiwRmAQsKL1J5U3a+rPTdz0p54?=
 =?us-ascii?Q?MWd5rrq15VSXJr8NfDFGJM6+DISwzpbXJHH94S/SQmvKRcODtDod49JeZccJ?=
 =?us-ascii?Q?i1qDkhYhZWHOM9Sc0RqbNZTI3xPctQhzTp0Y5a46/iquIymLQakoNzP5ZBFU?=
 =?us-ascii?Q?qUJOpzci9KDz9xwGDshu1XEqteZHg5gWZBb7FNQ6mxcBwfNCOY9iZdT9/aCB?=
 =?us-ascii?Q?hn17n4C2YK7/vMTP4tVSOXdJCA63Q4bPwaq4SP+gI+z/wX0tRsfddwk3SHkv?=
 =?us-ascii?Q?Z7qUkgPNNOlYQAjjZ3SRg4JcsGgLFMmqFTNwzOSuR2kFXRuz5G0ZuEG+KEz4?=
 =?us-ascii?Q?KPG8pDT/Prum8maNv6ZJnAcbB8CrAfkv73s4HmCUThLy4hTAFusM+H6gIrOo?=
 =?us-ascii?Q?oh65SsupZpYzwoeN8FHDP/rl3f+52T/Bn3goEzu0kvVHkL6SAPGZP69SCrnr?=
 =?us-ascii?Q?F9fA6o0lGNFq3CjTLjmtTRII/TxEtUX0aq6LEEP8eLf19xszlp0TKdM9r3g4?=
 =?us-ascii?Q?lQgqZmREWDCPyEeh+8lG2lDSTvc397XvN6Id6legsq1mNs12PHXELOWwTC0T?=
 =?us-ascii?Q?FEniePd8q8ghNRDNKUq1t6KxZUvQunlFbU7hW6jhVeDye4by9oKlT06lad8a?=
 =?us-ascii?Q?EhO063qXJVrUNztlMOcnD6Lf3sYayjQh2aH3KMmiR3fRmGtpc27UGDBk27VO?=
 =?us-ascii?Q?LmvSuv/nvbmRMH01eYnMFqvv+AecEpbAutq9jwgcq7fVvQw6nzqxssd3UFYq?=
 =?us-ascii?Q?koqMr8JP3pt6Qr1mnC/yNLrFNkqM77H+ZMF64vBZ2aiAGdnKrse/juLyIzVv?=
 =?us-ascii?Q?sScFI3jczNPvvEajEY3BnMNhBqd8H4cq5y/6/9pk33IgeHze3s+FYauHFJBr?=
 =?us-ascii?Q?ngyiGPUABZJWOHWnogoOMxMaqG3kxttZdYPjDqRSwEsm/+NroJpE4nC7LGlI?=
 =?us-ascii?Q?qFKnh55bxcEz47aFQIfBFkeydZ7MnFiCSiI6CVwN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fe82f7-c504-4499-0581-08ddbe8f8ee7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:14.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4dOry41l+xGkaTCnZ4T5o78A/yfVYgmf2sEvYc4W83w44WS6XC4kgcJxBoORCUey+VbX4QYIqtzsALWy3UrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index ebecdd29f3bd..cfae09bf6fea 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -39,10 +39,7 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
 
 	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF version:%d\n",
 		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
-	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
-		rsp->s_version.version = vf_version;
-	else
-		rsp->s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
+	rsp->s_version.version = min(vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
 
 	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
 	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
-- 
2.34.1


