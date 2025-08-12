Return-Path: <netdev+bounces-212780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C070B21E9A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CC33A6470
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85E2475C8;
	Tue, 12 Aug 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qbFUFQnp"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013069.outbound.protection.outlook.com [40.107.44.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EA311C18;
	Tue, 12 Aug 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981443; cv=fail; b=Kefad4asO2Qx1Eyefi/FQAtvlJsiESxg/LwKcs7kFoe2DmypBgL66eQ6x4rpC9miLUybjMcAiBZgf3/UDRs0LCfO1A8DuHWeSJID3ZZUEj0P1nsXFOdc/RV297IYrccMN5VMY6PRUaV4PyJ8+OF8M/PKFqw9wQOD70Rti4A/31E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981443; c=relaxed/simple;
	bh=JR4B/f3Eh9Q17wwX/hIQ90VGbF9FfJG23ag1IW7h6Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UqDYg/wcR1bEvAdO7bnYc4BA/JcuA5YRWGs3xcRGoHgU3cgklw1FLuZ749Z3b+PkLvylPGy+ogBj+BZjO3wlALPA/j3h6mGBzWhjFgKwGPtq7HkKTP9deNxeQbdPxU3d0nr6trnT+/rQ0a/Q6dp7PMxpbx9EE8YjmZCGXz/6XiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qbFUFQnp; arc=fail smtp.client-ip=40.107.44.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVp3oTsFvMEOVqi6hOIXAuDkRhO9IJ4fQijbHbYdp2VQhRZZD/8k9SGOXJbz/+O7tesXWzIrJcxHr/HuJ+YHX+A/SHr3orQVHAegN4vUvBaK2Xn8bpDJvwqNNLhh53NeABAvYY72+4QpSBGjUudYJhvyNHkYI4qVotmqsZxHDBD/lP8fl0EeZghtifsnkamhgkAwHP0iCmiV6J2Mi6BZ2XzX1kU6bBunY3I5SCfjZKLeavudTjrWA+vhoMCf9OHjy8q/JGYgyvDheMp3qZgqN9k/l0dRLU06ewHdCmvbLf+/hiTAZCWVh8CpEM4IWYTFFeFlkasseo2uBf02SxMT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f54c04inFwxPvUhFoz0ePgJC+8JfJ2rKQTyEASQOlEo=;
 b=hR55k62i1R9QHTOqA5OzkIzx1zM6B5vlmJUHDrCvRI6WYfsoUbaOonN6ayw8TWoApE1LWerrCsspjeMt8w9C3LZg6mDrOxJjibAJY/cxE9ua8hxlg5zm2r46UyEIBbfmM2baMOzVcwG5nm848SxinDXoqgjSxjniPlqBMCj8aWVMjPU+qaOA6sokpTshOikeCse7lEGgnjHOnuZiGZBYZbStt4fCZylMsXiRZf7nSF3Uu3Wy3ZnMH3hQgyP1HB9/N8oQDqqfwSw447DSsdP7PZ+gmtXD32f/vjj7i5CItWLCfYJgrFZsmgVeblIZx3WknSfVksIdU2GqASLuWAMIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f54c04inFwxPvUhFoz0ePgJC+8JfJ2rKQTyEASQOlEo=;
 b=qbFUFQnpwGeMlQstjuVXmeh8eBQ+8RnNDcsBwS2fjvDxF+RTW5oUOboSifR2b4z2Mwy2/cdU53hll7nis42sMHroPPtoS2je9faE5rRI9RVcKsWOv8hST0u24mh1VSdbOGKVag1vvyO37wxTxH5DAHwypxiAFjryJQsIxMC8TUdxiwNDtAf0RstWJssanhAQis/NOVZVQycFjR0Bq0LTHayvA4Oju3KG85ablSqTb+iH+kz59drI+ZyEkfof3ARzLDP9vUnSxh7TwC9+4xC0IvD3DzdDvo0uMRVQHqxVDMc9UO7itLOnr9qTdqHST/E16O0rsKHEpdPluG8PYfE2RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5625.apcprd06.prod.outlook.com (2603:1096:400:32d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:50:37 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 06:50:37 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] sfc: replace min/max nesting with clamp()
Date: Tue, 12 Aug 2025 14:50:26 +0800
Message-Id: <20250812065026.620115-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::19) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6495157a-fccc-4be3-5d7f-08ddd96c8b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RClg1+YpZfJYxCnmrX3n0ZbAZqbzym+LgTiUB5WgiiqdCzv9gyUULYUehYpK?=
 =?us-ascii?Q?HiOkUFlOapdMLMIvVgUe/22ajVWWDcK2mBmP7xXitG7urgJmGw2eviQCSiXk?=
 =?us-ascii?Q?cItIqgoZrYiAMPP4peewmp4AvuUAYYl/WQj8IadTD6Z/f5TgrANDfvx2wp4/?=
 =?us-ascii?Q?W2wRlkcF3CDfAj37ppxOkegcvOzxfH/ahYQfrcqAB52+EiyV8Bal7IZTTwVO?=
 =?us-ascii?Q?fGdgHjJz4SBrIqPUIVg6wmA6TcqOPl3VkAq2R9919u8JVaBQUsvbntwf/5Sx?=
 =?us-ascii?Q?Gq+D2o+f3HBr7WqPtqPhbHjg0RRAPVOjwi8VRXscyNzJIi9ebTZ1yggC7QEJ?=
 =?us-ascii?Q?q7RBYvxM8AX30/1Jn5bjo1cKW0ukgEFfF1F0HDnweiAC0cTw6cNpJQ+qDZiT?=
 =?us-ascii?Q?rPCe5vWOXuAruI+lTTc0oLDTkuRov6d8ssrccNswglDS+goirWookOJlVxTT?=
 =?us-ascii?Q?PmCgHSmMQFP17fdaQc0r1VGR6VStamA1k6VRjs/NvEfjtiYhi5SuxrLJaz1f?=
 =?us-ascii?Q?T2ch/GPW6CmWs/ZYBpFx3BrnDYX5s12HrVFIfVo25tRk5ItevL+iaOsbNKG2?=
 =?us-ascii?Q?sgfDBPE+F8zb3iya4Xf5KgzqR1pd82VMdYxlV2+FlJRLvIJYVr2stvToMUWa?=
 =?us-ascii?Q?jyu0WYbXSub/ySHu1QZhDNlqgbM/g7x1FWPCO306mZkKS7dlL8ivIGOPkQ76?=
 =?us-ascii?Q?MytVuat2WJ5vNzIujY4PDrZzg1BxBpjT5M9SJNAMVH2ErxCN46LzxrUConJU?=
 =?us-ascii?Q?7lIG5j+bdn7KKQ/CJwyqEaQ0JVFVMetaLNt3bdO0iY/Sje4r7NBRdcZPhDfI?=
 =?us-ascii?Q?ZGKxAoTdmsPuBu/PifcSRnUHHeayRgZelfCPeKlzcTz0Vt3RBDKZk/ijz2+J?=
 =?us-ascii?Q?oTqurdcNvrhjWkgrRQC3yCnsErqb2eT+QPdj8ueb388B7BcLTgMTJiPZ49W9?=
 =?us-ascii?Q?kfXJ+ZbZMesIDtCPi3mBItLKkR+XpOIRd6jDivebLR2rHUupSIbrXXNsCLFD?=
 =?us-ascii?Q?zBrs1CCCe2pNBlEw8iTKRg3iSG911dC8o6WexOEr4RzMkv8SzHOWkiALecHm?=
 =?us-ascii?Q?ryV3tIj+WDhRyJTOSgUu7MsCSKGP0VNm6raOheczqdpVEFrw27c5wmWKafJj?=
 =?us-ascii?Q?7j+eWPciFsRaKnuTcyK/38YooTDGTlUx4BuRj5RnIj3s4+HrYtRSl0RZm4T4?=
 =?us-ascii?Q?S3nNdaQdmxbSPSuowChUsNHWlROp37KBXdBBmI1zHZLsph8QJOVWSkt7NO2c?=
 =?us-ascii?Q?AIhIQTDcbTkVNHvxUF9tPJ+47r1efz8plgMeGR8z8h5G/RmxwagBlNiGfHNa?=
 =?us-ascii?Q?hO9m6DCub1U4WUqy/CBC4abR9n2xKZiFbcX9vs0cd33894T6mzHh6LGbcu2y?=
 =?us-ascii?Q?NA0bJEpIzIk3cnB1zOeOOVxYzC4eZuypip0gDlCnv5rsYX4JrDGfdLwHt/zK?=
 =?us-ascii?Q?0cdD0SvYjMlIuvPCSQr1amBrJbViFquWpK/XT4OFcrTDyazWtewz1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pv2czrVSbTwAiO2yj0EYt9iakSXcoLS5WaLlaAUbZC5viKsaQz+N1Te9v4/?=
 =?us-ascii?Q?z4J19qU4HeNjtotZfrFHrja+WFeJePYP0tmFoTxf+XvRuKo6f9GEaTbwKD3B?=
 =?us-ascii?Q?y3By2nRhmkg7m5Ckc83WGsE+2kY2dw/Ro482Ajh1RfAWs+UfOviXCV0PtGn1?=
 =?us-ascii?Q?pxRcfwKNz2qxt15t7a5Xobe/nFQWKgBvy92esHRhhSPLtIr8LnWf0L5EeOEc?=
 =?us-ascii?Q?72Oz8U9TMLkmjX8y2lDZvX2D4Trwp/FshNpZ4MSCmnqXfvrDLMpojgKsTLvs?=
 =?us-ascii?Q?sHjSfhHd6ylCScXApq3SC2Lj/wWLn+/2CRMe7JpnW1E0l3POcBq/xyQpsNjT?=
 =?us-ascii?Q?1MjIt3dEUI0vK50j5jfS56OcuKnDohtcnTaCygbPva6xsEBofjPyuPYcAk4G?=
 =?us-ascii?Q?VlwuKQqdsySI2ALjehkDf0zjPqHhozwatnL8Myy4tLGlyGpScmuMMh/MHX4J?=
 =?us-ascii?Q?IANPMOEg5kMB7vVLktKpE2diWvsrCV1jPu1GX4tIFXkplSFBpW3ol6pX2Fz/?=
 =?us-ascii?Q?oM+BBtq2ddQVKiQQmJRmf7UXkNjUl3wtEomJ5EnsAcJKigkivbwGMFIpW8D1?=
 =?us-ascii?Q?Xz4WRxwYBloakquwOSNojJJE8I4dxjMYax970/LOLCKrA8n2WNrINTdX6/vh?=
 =?us-ascii?Q?knuivSjkx5BtdTOEUMGNYPAmWtG0ais7xM6uHCv9jNSrCFZOYzxPOTSg9Tfx?=
 =?us-ascii?Q?CooawAV7hgbhDCywTBoyXZVw5dI+1BxXmUx/6qYDCKwkE5AL8JWmBQfzEE2U?=
 =?us-ascii?Q?JSOMa/PF0tGoIOYSgM8NBliJWYEfw4OVS3W52pnbEiw2Bqb5ltpRn8Geio5m?=
 =?us-ascii?Q?+eCVdDuMHl5U7m924Nq+rrHC4aGqq1Ac5UCO+92b0cBl/qMVWauNf9tq94ia?=
 =?us-ascii?Q?+fFSoD6bpjWw3VF4lAOaogKnYjlp9WEbOfzF9PDF6tTx/0WFJ4q7r21+S87m?=
 =?us-ascii?Q?4YQn6RzmH1wiCeWVv3br3YSElv4e494WpYkeaKX0M1+sljA3DegVUej2w2iu?=
 =?us-ascii?Q?iI1wHACiIBolAxsf/T/n60h8p1EKCgESEMsAaYg0vxY7e3HkDsV9+pJ9mn41?=
 =?us-ascii?Q?j1qri51miCt1xGt3sqP8fyJJdP9GStj2U+1v3Bx1A6qlQTcU81CX7h0q1ZV/?=
 =?us-ascii?Q?+JxhzkVhnoGfIYH9GmT2JSiEWN2UUAqZp7ULuEMKbQdYWEgSrrBWWzMpl46f?=
 =?us-ascii?Q?qJc/MBzFUuqxEIs9gyBl6URaIDcv1LQPec1CnNcxMfkOVIeNkwVMCmsw1SrB?=
 =?us-ascii?Q?dD5jJzUwHtrMZuyvAaUK5qwK0cWtcCjG0dNxNPcQ1EgUgrFflA+4yZOCsrK4?=
 =?us-ascii?Q?vOOsEvglv+0+qgO62XnzX09MyyMhA/uzGtxgq4aU5LbS/hwrOPu3vckr76TK?=
 =?us-ascii?Q?G5aVXDymMdZXYDE9XMgoMAFbPXPSGIjrX9ydhxwWT5JWsx52W59sfRukGn4F?=
 =?us-ascii?Q?9H5vsEQrHPOl3Gm72NGxZxVxGpbwjm8/JSvTwm9Zb2FN7makKc9mldtuy9s+?=
 =?us-ascii?Q?cAQpN6Cnzz6hFd5LQYp2xetyt2FFK8KHwXgcekiIQs+U98vF3eoBMygJ8kCw?=
 =?us-ascii?Q?avzfFyZJY85PANVu8ZoHtzd8hwvcoELW40OfWho8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6495157a-fccc-4be3-5d7f-08ddd96c8b23
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:50:37.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6XmxEiZzwKSck3eNNRdIsDhBS09fkVhUlUhWIleiGis74Cfl5cpBtL9ASt+UKX46fu+cnQHa9HKhqs5nzH8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5625

The clamp() macro explicitly expresses the intent of constraining
a value within bounds.Therefore, replacing min(max(a, b), c) with
clamp(val, lo, hi) can improve code readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 4 ++--
 drivers/net/ethernet/sfc/falcon/efx.c         | 5 ++---
 drivers/net/ethernet/sfc/siena/efx_channels.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 06b4f52713ef..0f66324ed351 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -216,8 +216,8 @@ static int efx_allocate_msix_channels(struct efx_nic *efx,
 
 	if (efx_separate_tx_channels) {
 		efx->n_tx_channels =
-			min(max(n_channels / 2, 1U),
-			    efx->max_tx_channels);
+			clamp(n_channels / 2, 1U,
+			      efx->max_tx_channels);
 		efx->tx_channel_offset =
 			n_channels - efx->n_tx_channels;
 		efx->n_rx_channels =
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index b07f7e4e2877..d19fbf8732ff 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1394,9 +1394,8 @@ static int ef4_probe_interrupts(struct ef4_nic *efx)
 			if (n_channels > extra_channels)
 				n_channels -= extra_channels;
 			if (ef4_separate_tx_channels) {
-				efx->n_tx_channels = min(max(n_channels / 2,
-							     1U),
-							 efx->max_tx_channels);
+				efx->n_tx_channels = clamp(n_channels / 2, 1U,
+							   efx->max_tx_channels);
 				efx->n_rx_channels = max(n_channels -
 							 efx->n_tx_channels,
 							 1U);
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index d120b3c83ac0..703419866d18 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -217,8 +217,8 @@ static int efx_allocate_msix_channels(struct efx_nic *efx,
 
 	if (efx_siena_separate_tx_channels) {
 		efx->n_tx_channels =
-			min(max(n_channels / 2, 1U),
-			    efx->max_tx_channels);
+			clamp(n_channels / 2, 1U,
+			      efx->max_tx_channels);
 		efx->tx_channel_offset =
 			n_channels - efx->n_tx_channels;
 		efx->n_rx_channels =
-- 
2.34.1


