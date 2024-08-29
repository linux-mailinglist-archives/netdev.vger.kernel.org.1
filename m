Return-Path: <netdev+bounces-123036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B4963819
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D5B221E2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABCB26296;
	Thu, 29 Aug 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LMYErmA1"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2045.outbound.protection.outlook.com [40.107.117.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7C2AF1E;
	Thu, 29 Aug 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897647; cv=fail; b=hEbE0T++09ci8vtH0sS9DfCvw9I5mdPMd+GaAE+ycRkwwlIX1aajZRHy0y+E9F2RjfL3UufcuUEYlX1gfwFjzaoWu7Tm0VgTb1wR1cL8nDNIrRKSA+H1RWh3SZiruRvRE8G2TZIkdii8xs5VnFcDUmra4CS0OmU6gfDVr2PSsMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897647; c=relaxed/simple;
	bh=8ah65v29eAJ5xJquQ9zk5lXtgqHXrl80f86vpQIosvY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H786ddAqOBuCrBigNv8IZuHIthYv/w3JK4TxNioCYp7JYrSeEJvEwRE1O23sf1h8ozF1uz8Vt+nQivPHQ/p3zVCkl60JOn5XBz6pBQjx8pwpq3Pyqk/rQuRutw8y+L09GdoZjRojSyA5UH8VwA1ZFvqbXvo8AYLJQpUEVE32/Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LMYErmA1; arc=fail smtp.client-ip=40.107.117.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh7ayursjmDeilBFhFKQt4HpiDmXRvcrx8w/m3ZGJVVqey5TqEnhCQAxJ8zLv9I/zWExPoqCsPaVejT9/CF1SLCM02e1nQ10xeFU0tu8XYzL/TC+7JzjszoBYBvMGm5hScVc+yfVYjGkukmivOu+N+rYwlUiC4X530ds39vniNxrclEqMnkq1Q+w97YfBbERRnUKYissd8RJNf7AP+FiPovebCw/PRHltLofnbvjCsdd+j5g4kFI9vscEucjUNc5pkcERkx/inZVuUJ2piKUZBckw5yAnyhJNbnkKrTOKfAJ9/OUuAZLAtg1dWnVExNlKSZZL3RWtYf3aVjaxrtVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLsDNiTd9FkKpEJWuR/jcUcj9EwfOIcC6FNmBVpteUs=;
 b=WNTAo+BRJ80ljUtyqwfVFJ8IkZMZm1iYX0CSQ7+IzGs4HWcE9Ey8zsI+lI6cErz1nOOxUfk1Q6OOX7UA9lxRKGCbuyvcRN86jjYqqp7yW8KdM9RpB3K5B5g3ylwcMF1fAYdPR4wASeZldlcKmIQO2FNrrTNDseYcgucveoPRzZekF4QVy5eDTwVeugajz0ozz5ak7dmQTEN6NznsCg78bVdptMtd15baCW/8QY1GgxIDFqL1bUissgPfOPs0n8HFNP22ejknbD9qWocktwSDiyAAQ3GR2Galj1yMSdKfnefPxSRho8NbpioZlCD1UhW5vB4FuM5sMcyud7kZopiITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLsDNiTd9FkKpEJWuR/jcUcj9EwfOIcC6FNmBVpteUs=;
 b=LMYErmA1Lji2rCqZW8PDJU4NgbH+r6Ti3M+D5YUXYpglX2sSeSLEWKfNEQH/jKEhvYcYoN3KBru8EG1XBFvjgGBFgjgW0yRZxwKLx0Edr3148xP3QrZFiKb6oyhYrjdFisY0Fu9PQH4okLlxmDdk0fsqxkHiFHzsfsLAbelDpbrZRMZDbCv2Dah3fU9cBxzU64vVbQAT0sE74ryhqN/CVFgNVzgPq+YhbWJqRguDqDLtfmGyXYS8FEqZvfyxTK2ZPYMD4DGOk5h09RN5YExXRydaQampx5NOkvBoo1BxxSiAaAmZJDzcvxouROlSgkBcaW2XTTobiH8uTioUfXfx6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6880.apcprd06.prod.outlook.com (2603:1096:101:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 02:14:00 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 02:13:59 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v2] sfc: Convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 10:12:53 +0800
Message-Id: <20240829021253.3066-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b6132b-ee2a-4b4a-f6cb-08dcc7d03e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JY5Nam7ip5yx5b3b52ftwq6VDEty48N5ZWNr5mTSOPxQxTuGnkyvVhga65UG?=
 =?us-ascii?Q?CedBpy/e8iPsLs3SlFSfZxspNqIS1SvAEBemA4i3xfxKzKoncGILNA+U8kaw?=
 =?us-ascii?Q?UPSXWsnmN4tyGZdMLJiBuHaf7LbWdKvDN8zhgeI/3YfY2r6CO01fYV2GVDyU?=
 =?us-ascii?Q?QTAJQbnWWhOaL5yz7e5hfrxrGAiEdo8pAJMGZwUTKaumnKJirO2tMKEN9/V1?=
 =?us-ascii?Q?JYf+DEwy+yyvP3hROf5brdLy8HfOIUNfEuLkjFATkW6GBOBLLbjiK+zs3IF6?=
 =?us-ascii?Q?VL9pwTe3Qmz3mNioMdOFYK+H7ufkr3o0bEMmPK89Ffc0QRWiAoODHAo9Jpu8?=
 =?us-ascii?Q?zlhlVzCtIamJybkepRjSanbxI6ExyXNxcOpjFZhVAna7mYYYHiM5Hv385TnF?=
 =?us-ascii?Q?A/EgA+wk8QJjoEcKB0YckG3KBBA+w9S0fYhg8c/xF827ShrYGIlkLduM67PM?=
 =?us-ascii?Q?uFa6OFgKcCiqLQeCXMVgZwS27rZ+aJB2dzP+fDTwghNC9KDiAR3Uu8VxtUHj?=
 =?us-ascii?Q?S/ZuskVanrbXlAIFllu25AEQMZZztlrkmhPN5aDSioBTG4M6VQtQU1DZFKOD?=
 =?us-ascii?Q?1xu17MQAc/fOcdr8oQARW3uek4FhZ6Z0x6UoPfhUhblSbjd25RPdkQjrMdxm?=
 =?us-ascii?Q?jujVZW1yW2oCd5fkATBZmOaMFG2GaC+d905XXk0AH3JdZpjwRkIFzDU94UG3?=
 =?us-ascii?Q?sZduX7sw/aDId3weRA9f8f+aQNjvGd9XKHPnwmG77Urt9php7lRLIlNQ13ry?=
 =?us-ascii?Q?BvqdsGYifE2Ul8tKcxniBpKCz+aTGHjVvMORsG7RgGdbA2/zfraZILOvEBvh?=
 =?us-ascii?Q?isQIwH6XGra58X+s6ahECUt9Bd8C3UIhi5hNyiCnh0rY5zSGCTGuWFeDuyK3?=
 =?us-ascii?Q?vxTs4RYGhwSxOtg7U0drgTODgNuKiGR5YxNbpbi0BcYJBijFAe1K07B/PDME?=
 =?us-ascii?Q?3lSs0QudkaG6R6daAOUvai5nLVOGPCPoEYbc3uwkyzYL45lNTrXDhTVBQBtc?=
 =?us-ascii?Q?zLNqSRVw0Bpg+qrwGJZBiPD+M4W00qbg2CwajZaOAu3TrxvQ/q/oOwTlX+hY?=
 =?us-ascii?Q?IkJ+smZ2te3lvGfNqVqvM8jeBmvw54fCnIlAlMSmG7feqMKqxVmhlU373QBI?=
 =?us-ascii?Q?0KIsi/sDBpirmjZ5Hrjg/gSxsePvcxIpTJD6pAZBZ/1DG9qxF9jiIjQKFDNN?=
 =?us-ascii?Q?N+U6Tx2tpfvr8xld84X0jCC7+fOeLXk6XG59ZB//VuuIBqnhjOOM1eGUon+E?=
 =?us-ascii?Q?ElTwEiptbYpLLe2L6Qu9gAyBH4T3ydZ+NmKDAYn9eCUI7Yvsr/i2T13qg+Kv?=
 =?us-ascii?Q?NHXJEPANMgVvz0LnJ47+dEkXp9dwOaEtXcYfbE+WPjYmRPpBelcvZXXIJ7I1?=
 =?us-ascii?Q?uBkq9hg4NNSDcYmPoF0FKnyUEOXgHGG1oYVR16QPNHsIx4iaaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0BcX6qDOovYAZTZIk0GlRlbUV8YEAL0GR23v4k0JTnioewft5uAL1fnMIZo?=
 =?us-ascii?Q?hP0BdgOj96COIrMKEG82kcBLHiEuwQIoLeO7Yb6Ye6O3X1V7CczAerFdWuEF?=
 =?us-ascii?Q?NhHRJgFTj6fEGf5IUgmTxdPqDzvHvJkEleFQNsmjClpLa2vqtUWgRLtd6Gse?=
 =?us-ascii?Q?IGWCrEYcu7/aA6b4KemzMfli+wHCSljYpZcbQhli0fARtiqTwfZ6vE8tu5xr?=
 =?us-ascii?Q?y9Kt3ICJsj2281wlxxuS1fENt+IP1kI7bCU2m1eIpqWWOkNEQb1AtZf7IpaZ?=
 =?us-ascii?Q?u2JnJEC+7/PVXPajZdeI7R+d0XRokQ4dp09fmLHKkmQ1P7wLV2mpnxk+fms3?=
 =?us-ascii?Q?+RtwnddHm9ErIEQI0eMCZyXOZbEk1Bs4mQf3BAjtQ8rqhzZyvpSfcao1dmHN?=
 =?us-ascii?Q?k9upx56OlCWsTIpWGcKIKbTf/eRc6G+zVkb+KflHQWZr6oof/sJ+by5zQFOI?=
 =?us-ascii?Q?slGcDXQJpQeLB82J0FA/wgTkRSJPIhsDgO5mrIi9QCNDTqBmxUPmd10yHTHl?=
 =?us-ascii?Q?FFuwLPCOTzdn8/kJ2XiqB0Y4Of9POeFcaxHacJWvkWv1R0qviwCdjGzlhvhB?=
 =?us-ascii?Q?o4cZbdsvLfZdg7w0WoGEoxnYNeeOpgxlDcXwhV97lKalXcUvjuSOf5IOOiTw?=
 =?us-ascii?Q?llBqXma75EMnETRrDz0psd0ODXhqx9ZMCisGnqt7WBAXkMEYjRveI/fopOuK?=
 =?us-ascii?Q?iCsr2Pb6PGZ8j088PUjCyNEoBlHCgd7qDhiYYhQo8afNNMMAWANmI7YJwfrW?=
 =?us-ascii?Q?lQlxUXjrBZ02W/Z2JUUMltqayvAMKxJLWRGbd75jpJ7i5cFOfDYq445f8Jr1?=
 =?us-ascii?Q?5VQkmtv+9Ydu+VI3RUSIe2unGzcghPjFem+8WLc+DVVV2Br/l0pWlsgI1MHt?=
 =?us-ascii?Q?RaWethPktkqRXYea7uROwr5PWaz8FaxvU7yPhH5OMKdelzLoPIQsyT/bqmG6?=
 =?us-ascii?Q?Z2ou4QWj/mRzj0/oLwNQ07LaOb4vj4Y1rJc7zMYDsNO5ovd3bnHmFPfWkvw/?=
 =?us-ascii?Q?H4Y1tJlvJUxbOEkvP6byCyNk5s5t6s5n6KdZ8TcNmVhA7lSyKUskMWD9Pyj/?=
 =?us-ascii?Q?dVmRTEZC7VqQkkWNPD/Ydcsrdi8zOTO0Vl6C7doFf6dmHUesJMeLOiwROx4G?=
 =?us-ascii?Q?WxWkpwFiyAVSBrWdRgVN5qATukv+KrLK+IyEgpG8fefSxtkzOhZk1rX127Tm?=
 =?us-ascii?Q?f7FMo0LBwqsNkIqGQBoloGqAP51vyw43rB7otuM2GDC+7bRkU9nliDwWjNEc?=
 =?us-ascii?Q?jvB4Efg+t/RdPAlL2bE17caUQ5QPLwF3yoZzROOzoERJx74yeb161R16+JUC?=
 =?us-ascii?Q?dHmPdFzJkyN940sHicdz2iMdZUcpGUZj3uo34COzE11zVEfm2CuK4ZLK9F5h?=
 =?us-ascii?Q?TcfiC0mIWGUvwH1xQxn2h+FRgVGceNiyVMIs0J00W+QpWrE++HvlsYV4hwRd?=
 =?us-ascii?Q?kSduaiM8BaiyDoCDrDlU4OJrJrPOUQ8kMEgPpWXUKOmiyaHW/sEvAW2YXBI1?=
 =?us-ascii?Q?fXzn9jB5oxtpe7yu+9QMwcEyqBql07ObKVe5VGnig2gZZ0LJwG2upHA4+7K/?=
 =?us-ascii?Q?fMsdvhkCccZ6TcjSepu/5KGiD+tzSLKWtV31DVGT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b6132b-ee2a-4b4a-f6cb-08dcc7d03e71
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 02:13:59.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/k1fa1+71WtWhz/XXiThBHofeVgQuzuUMecgl+QGiMyspMd4BxXkoLegiSIJnhDVgKVctgmRMnbNG5khTA6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6880

As opposed to open-code, using the ERR_CAST macro clearly indicates that
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v1 -> v2: Removed the superfluous comment.

 drivers/net/ethernet/sfc/tc_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index c44088424323..a421b0123506 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
 					       &ctr->linkage,
 					       efx_tc_counter_id_ht_params);
 			kfree(ctr);
-			return (void *)cnt; /* it's an ERR_PTR */
+			return ERR_CAST(cnt);
 		}
 		ctr->cnt = cnt;
 		refcount_set(&ctr->ref, 1);
-- 
2.17.1


