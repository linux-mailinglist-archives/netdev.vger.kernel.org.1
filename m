Return-Path: <netdev+bounces-270494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBZ4DooqwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909112F17F4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940FA302D5FF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8B39B493;
	Mon, 23 Mar 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbwWUPIy"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C730392828;
	Mon, 23 Mar 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266647; cv=fail; b=jAkkGYn7ZagAG4oRHbaXqfAQk3Pj97N/S3CWHy5RLYhc7QPOoEaohlWavHvPfFfRY39Re+MXFyUt97KC4RUWdad3nN6Enz+6IM2LBQdpDK+thCGrZLTnDohlhX0LiZNYtjHaiJ2NtC4V/cY13VFqY15mecE7Qg1nZSF2/ll+AN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266647; c=relaxed/simple;
	bh=FmXgfN69zpAWdac9I28T+x3K8r96Lgtdx134o8kUQkM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nQJ5FfFlTajhKxwD2PN9cLyLdaeEb36Gqsy1VU3STIZmDuz5guZdssYyoadAOzNJ2FBrdpp7czyMfJWVeN2GPp0NkfLCjh5WAsId+r0pOFyqOhBsLX6Ulj1ehRQvMPCP5FPd+tn+OkfXPP69qBIdxHrQDBiezTca7xM+1ZLPnjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbwWUPIy; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy6gruMrNridLjVBgioJYXs1nqKsrAkO8+L8sW7sAnDv/9rcs8a3C8S3+dWtR6Yyg+XNVuN4RBRdUI1vh5DjKpjxOSls7EzVN+yYl/zrpAXGtdIbNWjStnj3Stx6SiTNCJIOvW7XeqgBsDiqge5tsq1aabUYkyplMHHQQQ3CiJMK5zwahnGWloZ/DoXSEAci4cpp5s8xgDbWl3PzrX90G1Frw7sUtrjdO6K5/GcSbx/xELQ4N61SliMqs6NT0RE+ASUKFaca+2Ce14l56dYP87RpsffJEiWnXzF0y44gAcV7qTonIQJi5qknot8cs2Zb/AnxYPO3FGcR8vHDmIMS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l526sEDoqLnYYmW7OWRiCjnztgHCYYFXjzdmVxksGMo=;
 b=ElcNU19ymOibfaZh2HYZ+h8HAG1OXaynYR3J1VAalCajsF/EBpvGUdqavJKtiydDw7ovZBbY1baCSkC4lfsYNxa7uxIfdu6ev92uOxHMyL/Gl7D1boP0uzsJiKbDe+7DCaYslOnOOGzam38DOmBGC0sDFu2Dos2AX/Cu2rDWk368aVzmHUIWrF9f3H972ryoKVhdNO8hALAJcFUMK+Y+8ucm2fMqW58mz2r3ErVyvga5URKOWyEJZyTnosiYXxNPberwwG/ZYlaUtWA0ymw8ueOuMZKiYWYksboYV7mOjVooRzFsi1HlB0am5jAiEfLCEG60WhCXdqCKG9Vh7K1I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l526sEDoqLnYYmW7OWRiCjnztgHCYYFXjzdmVxksGMo=;
 b=QbwWUPIytA7CpnaQUfBvauuExFHDQisHE7YYdeA3F8NPhdERBxxZk1Z4JIbr43H05BeuteewG//LNRAOkVR42zvTSgnL0VzJMz380Qu5cDC/TlO4zkBhHQGX5fNn6WJnU/JDuPwrvFtdjGSw3lc1AMy1ZGAKzavoIgaRtoSQKFe8xzWJ7fsYIuid9shfSSeni24JLU1HAhCr1ZahuTJ/xqOx5G/4HkxETewzq0dkIcFtB19mSpPdCo86WZNy2a9def04MzVFJVDh546cPYvCvMRctzYYfrsgjKVCRzklB8ib9K/KAoFVexDgCLg8ApCnSnmGqwPIzfS7f1mrVODRTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:50:37 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:50:42 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/3] net: dpaa2-mac: export standard statistics
Date: Mon, 23 Mar 2026 13:50:36 +0200
Message-Id: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 913c5b32-dbe3-445c-fb4a-08de88d2694b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PFwFCMxGCBXPoh8Q9ER4nj2S1rRfvZLOizk6QX3kUYo/x46/yq18IZwAwqUg2seEuKGvEDWREI4h2W9mGK/ynFpYlw0CRVOGpkhEoKZAJBldB1eleRyI8Q5W45hJkMGdW5oq0HpFcHXDKFtIGLGVYIhYJnKXvgtHLRhP3SZdXo6Nb/EZJlB1/qERii9v7JOoOcCi4lgu4mvx4J97bNMClf+0Lxl/HbhvZktYXj8m0eeuKGsA1TMkM0nyX0MgfVhZb1oPm5tn27ip7Bx/AHRjsFySbMH6AKmdL5lbGWperB67UU61+Sb/UfdnpCNwCzmhr/2Lh6Y5YkapcODvDC8u67g+jJ3AMNvglqHGmXsbsM/QgaeUughqRVmcAO0eUrEILwISCdoQ29hbV1n5R2HaHLBC/xCrdR+kiUPs5dvPI8OayGztlliIOqKHjPzl3srPGEG1sYu0mm7FnKrRxhksF8bV95VPhoMFfgCUR4sL+DLaS3leV5JO0DK/z/xSqCJSvd5bFMm8pDwkmqM4al9McgeMGggqqErIO0OBb0XOdS3DbD96gDdZP5rK5JR3aFbiNoszJ0frmBWsTd6GjHWdyu4GhTW6nDNkFal8yv+icOfGfoy2raSLAc5ZAP1vK3xykVwvQKc36/ee6WbMTQcJ9LG9GsYUeOQ4qiJDzoa++ElIZ30kAx7MJlUwvgrGZeQumZU+2RKvH9i50Q/UgtcANdoYKyyGFsgP+8UcA9pNSa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFw0GucBZHYbuYTRuPf1VcTGfqPj3fYOfQwiImw6LLb/VhRslbazfb2uBz9D?=
 =?us-ascii?Q?4qkQOsXpIwsvnY9AgApqBMMMqNxpTRXXsmoqfUqjk2H7ITLQeRyGwwh+EorD?=
 =?us-ascii?Q?ku2/Y2YvbTdeKh70NouStNIvLJhieQM7AgIGe6IBa3zZbYP0NrkGaO3Yy0Wx?=
 =?us-ascii?Q?d7SvbzDS38Y/3wh03wU1L/MaO85UzsGDUcSmapH11FrEqzOuEQVuluQ8scHI?=
 =?us-ascii?Q?qtuMH1TyoPXOIhKQkOX/Mnyeb56JkMuLK/FTbZpI3ZEom509RL/iZvCeQYZi?=
 =?us-ascii?Q?6Fu+kEyK9QRddsaOwuKZJzsmOrVT7X7nnKlts6lbixq86JgN6LxWYqvcYD+t?=
 =?us-ascii?Q?g2ib7aG2DM19snJoYf/n63URABz1Af6mX2jlpKhfK/cqqq5cBQKvS2me71HU?=
 =?us-ascii?Q?hyxvvA4FphxLW7ueFoCUacvb6tmhfrFVDbfEurK8ennxA+YROzHShFpWZRlN?=
 =?us-ascii?Q?xyR6c4H+52nKeBxNRPecfsVf48BttO6DxVOpT6Ab/a1FSIaNYqyy2neyI4iV?=
 =?us-ascii?Q?G0zu7ABnkDcZraa4UPKgG/xQ2YH0UHUDAmMqsKVKknV0fgADFtJg44I0Hvkp?=
 =?us-ascii?Q?Y1v2usM7Ht5RoqDX48F7XAVVWo0eSHZtg8Q5mYb4TdRNux/ECbi7mR/kIDXg?=
 =?us-ascii?Q?gGu1GahdU+jtNAlAWtLu2GG1v1D6vc+q+UzHrPJ+h9Cj6eFvYEZ1kiOLDyZ3?=
 =?us-ascii?Q?evuLJ47+kbfutAO+UoHnLrPi8PBjYWgGAC9t7J6DSIgiWia6km+iTHMO5iL0?=
 =?us-ascii?Q?mc4gq6Hkosu7dMVjhdREdPPzIvXfs1EHCuM/jT8hp5YK9gshYfdc/brtBogg?=
 =?us-ascii?Q?GwZbfudgoXmN318hdMhiBSg6ZrMbCNVKctyB0UDVmdMiKpG6SwpwwFJkLL6o?=
 =?us-ascii?Q?Pw00OhF9u+psSglodq/wkM6mdU+vrwAXjgSp9Pp97ydjXWujzebuWD2MD/Gi?=
 =?us-ascii?Q?h1JAjWqODyiIIK0WDRDDFfITSaRT39m3ESbjtC/RYeOm+BLwr7uqXQ/0MhBG?=
 =?us-ascii?Q?SAfQt942gH4bHstLE1bMmNH8kgEc9QBofN2ncy1XHpTM1toiO2/rygUr9ZP8?=
 =?us-ascii?Q?kFCSTeEaLsmg8lia5Gjm5unrPAbSN99ERGV7vZ9NWNOvMHAAkFaBEZWjzb/p?=
 =?us-ascii?Q?t4wbyuI+uJY/0eTQwmisvuKR/nA1WDXc15NmFt0k+0D1BnqcnFVbCh/TjoNu?=
 =?us-ascii?Q?K66gbRsM+dEWdzlmWsG1dLBiF5vzAiHzfYXshvnfLr+Fndr3G66l20OFoVL+?=
 =?us-ascii?Q?3kcpoJleh6cq4RRVRTUBLcjs9ipwvuhrMjiMXQfh7+qasOuH57c27sKs87ET?=
 =?us-ascii?Q?RVkaN2jppf+wUObaQCCavgl0QOPNci/Z2sjK6hWXCTNE2WqjZXwiYhDkANp0?=
 =?us-ascii?Q?anfqtDPHbdaDrRXXIqp/sITIi0IYVNcaFTzPxA+wq+lS7i5S5YkNR3QzJQte?=
 =?us-ascii?Q?XZzba05jszJ1pmlVOXM8ixQXyGDaR5Gj7SKH7P+ERZXkaug2VLIXFdZOOyWk?=
 =?us-ascii?Q?Eh8vUukVBm8QrvvMd4pujsnea0JsN1PsXn9FXuGdG/VAoNqykavpmMo4WauX?=
 =?us-ascii?Q?GVIox5ODc6Pj/c63DZaLOhYuiS/+VArUA6Bi4oiqJm88bNijU/Yv5D2YI2Mc?=
 =?us-ascii?Q?wNVDJzAEWuhBcgFbk82nPhPICYrbjVs/r4rt0WdEmnlFaQJMR3aAA6fTXQ7z?=
 =?us-ascii?Q?zIYcdfCR1oFPU943M1tp4TfB5Fh7Q8LOJ7md0P+K7c+IxO1MJ7b7yG2yy1Ka?=
 =?us-ascii?Q?cvP4hudttw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913c5b32-dbe3-445c-fb4a-08de88d2694b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:50:42.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojnZLsHqqPskwrGjd45UmcHDLPozMlI93w6Q64qWhGjivM4FqwMp8RYmntczpIEqwhXlpLFGzXYSeZDM5CVEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270494-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 909112F17F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set adds support for standard ethtool statistics - rmon,
eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
dpaa2-switch.

The first patch extends the firmware APIs related to MAC counters and
adds dpmac_get_statistics() which can be used to retrieve multiple counter
values through a single firmware call.

This new API is put in use in the second patch by gathering all
previously exported ethtool statistics through a single MC firmware
call. In this patch we are also adding the setup and cleanup
infrastructure which will be also used for the standard ethtool
counters.

The third patch adds the actual suppord for rmon, eth-ctrl, eth-mac and
pause statistics in dpaa2-mac and its users.

Changes in v5:
- 3/3: use DPMAC_CNT_ING_UNDERSIZED for the rmon etherStatsUndersizePkts
  counter

Changes in v4:
- 2/3: fix dma_sync call and memory leak in the cleanup
- 3/3: add dma_sync_single_for_device before calling the MC API

Changes in v3:
- 1/3: limit the documentation entries to 80 chars
- 2/3: use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- 2/3, 3/3: reduce the number of lines that have more than 80 chars

Changes in v2:
- 2/3: fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- 2/3: use the __le32/__le64 types for cnt_idx, cnt_values etc

Ioana Ciornei (3):
  net: dpaa2-mac: extend APIs related to statistics
  net: dpaa2-mac: retrieve MAC statistics in one firmware command
  net: dpaa2-mac: export standard statistics

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 409 ++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  27 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 +-
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  |  11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  31 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  |  94 +++-
 7 files changed, 638 insertions(+), 43 deletions(-)

-- 
2.25.1


