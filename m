Return-Path: <netdev+bounces-188266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFF0AABD3E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6041C223F5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73F257ACA;
	Tue,  6 May 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0KxUwfF"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BE23D293;
	Tue,  6 May 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520073; cv=fail; b=EpMz9JBLwzeYLZzruPrHfc4XvWuVQsifPgbp5Gtibqwss614+Vxoum6zT/nOkWQI786VW7oAddmom80ZRWwsKdSyzOUe5CNOG7bqBkI3LRG/22MI6EPeNGtspPq1aKyZN9dE4BNDkhTDDOYXPzfdswS0WJ/df5wx7zIgPSu7y7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520073; c=relaxed/simple;
	bh=QJARgmh2lHdAc2SNX7U79TugR70kUvacTvUClPlxMi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BnwvtL4tdKCpuh04tDdkCm31Uy9Yr77wTGm6xFaGeVeHI3DLRwvL915187uLdNiKuYWPgmN5KvgLeAxPtvnIl5m3DIAc6FpMdhnUilmTLnB6RfqENx9K1ipqRHLFXjy0hU/c5a9lOi67Id16LhBckbv9DK38K7EN9oOSzua6ZY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0KxUwfF; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKsN4tklAQxvUu+2AOYtpdiaWueSr3PBZzLGw4pRvJorr2WOm23W3lhCpw7hFbnGKJrcJFhrv5Iv6zz/HBNTHj+RgTBQG6oHHy3T3zui0ZUg3dUO3OGwgh2TD3p5zPvycr63bfZBi5nybtLYD9JVcKWnc88/zS1ITXtvSIRRZ7ZRywat4CtqtE1bYdId9xdnwfbdDfqi4A+tJyi4LlBukprT9LSmiodX4cJTxBN7PomNF7psLNsiaryZdAF9mUNXnVTddb+gU8SPIGq41P4Wu5cFXcTKKaZVIOmPDVGFtU99RzCx2abQ9DjX2RZ2QpJGnj579RMv0E3e4j0gkdf4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlDGiYsZSCDacAjxSee5qLk78HO6L10KnknBTnoj6Yc=;
 b=IRZ1V9/1BRst8a8ijHjsHgCgIv5WO+vtBUbc8xZppT9GyS+8qEIDrNB/w8K47sYCVKOryVFKx168QbORkYweGPUsHP5QjhRexDUQF1XkyuDoczcc5Qmds5SI7K8URASOf6mV6181tZuY3zpnBZ803HOyno9x9Zhz9XQdbicFm4v4MlMoOqtx/lyeBm6alKrBPwUF4PmlnE2v75A2z3Rc5CWPeeGFv+2rWVjyKOj0FfIFKWgRYtD/fCeK+YRFrKpbIF0tOZJjK2V2Vz0dIKcECPhDiEEcOalINNr1wUiM1RpY6lanwgCdFmzqsfUa0AKhjpHZcEySzswaeTdV/VnC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlDGiYsZSCDacAjxSee5qLk78HO6L10KnknBTnoj6Yc=;
 b=N0KxUwfFwzGZqhtxiKBwDnibuaJ+HDDCNMxh4xvdTEMlZSoLZhQ2lI/9jk0uTkjm0acL/NgBx7S3215vBY8q1mvkG2w7cl/bw81CNowrQGfl0WFEm704Th3VGYN1/SA9JAkuGhNTiqoZ/fQquG7LrOw/xZ2CkTHIltjJ4eOUb6E8UtEQDdWPEX0QCep20imd1gz7nnvy5wG9uZA7CvPoRbeE5fFhkPO7DdOBxQ6H4/N9Owt9j+Tw2px2bN82IZP1telk0B+1kCBfP7GzCCdEAKBV7VcFCKeitPAeJTSZLUDVPmKdKiFW58xQYkZ1UC/Mrz1rZ3zxONrtBNpI5M7UlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:27:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:27:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	timur@kernel.org
Subject: [PATCH v7 net-next 13/14] net: enetc: add VLAN filtering support for i.MX95 ENETC PF
Date: Tue,  6 May 2025 16:07:34 +0800
Message-Id: <20250506080735.3444381-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506080735.3444381-1-wei.fang@nxp.com>
References: <20250506080735.3444381-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: c75a06b3-e236-4fbd-8e0d-08dd8c77e398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrnUO9qfZYmFL+Kljs3lTvU6nOVOFFvnm8+aGzlHrkOfF3NqdZ4e29h2TwYs?=
 =?us-ascii?Q?QIatHgVsQwb/QdjqZ5NW22MEt8dsqhaWbtVqMnpiYh+ZVrStmKKF0a3uVx7B?=
 =?us-ascii?Q?C7yHcyNk94eM2Gxj8nE4enAqFinnpOq7ssscDdU1CWuDj+3+UomSoGUc3tGE?=
 =?us-ascii?Q?e5A+akPlU+YLjpxUxVjKwpshx2lfkyVPLzihv/eiKd5HHFcofFej2qTLQ/iO?=
 =?us-ascii?Q?H8jUKdfhUdem3OJh5QEE3HbiBVEAQ5LjIM/cLzTRdu3MEtp0uuKQPmDrCUrl?=
 =?us-ascii?Q?xxtzzZJ6VYZq399ufj8LkhvBKiWZliPOs5VaN/sfzeQ7j1MIl+nPDfYacn9T?=
 =?us-ascii?Q?BegywVupaHs+HkvS6UwmUf0JJBvGBsliA7+wwVU7Lp/APPIZe06AgjUdZJbd?=
 =?us-ascii?Q?nNfdWvcEKx8LZZ6TwIQgBNz6Ov6hW1qYkfFRev/PB+tjy3XG/aDBahDGv+SS?=
 =?us-ascii?Q?f0NPXo6RpzaR91Kkn7SFroGugBQWHeiNHt55T/TM7wnb7S67Czt21vK4m5p/?=
 =?us-ascii?Q?6Y1FFdiCzl6bKTBQO4YpfwOJloYm/xkrUMFwvIceDSIJA/Q5CO3RECsei0eG?=
 =?us-ascii?Q?odxNfgX6Qz2XT8NpdAHtKcsKIOJVKqPjTfzdZMqcOsjf7xYinuuL9cROVJEr?=
 =?us-ascii?Q?3BKmANJG7ZsoaSySiWUUUUuyOQ7vytC6LOrhtdIWVhFg5KeatHZeOuVJNcCG?=
 =?us-ascii?Q?yo8bJGvvxPvBQG+b9mOIRwT7iPAbMBg5+zumn0bVPAg4e/cwUzBY4EwtMh4H?=
 =?us-ascii?Q?rhAiE/NDTUc6YD6O8R0zMeplfzdNxXJc1K77gCtArVBickyKaPNH5sSKZ8rn?=
 =?us-ascii?Q?5C7QJA5pRAeeSa7QuEyJC4s1R2vJQGUFFS+pTal/G4VUcv2PVx7vDneUXTtg?=
 =?us-ascii?Q?3h+yvCksxT+V/0nwekxSpkayX1oUC2hKQ7zAhPVOz6z43ckxqTGw3ZTvYK6P?=
 =?us-ascii?Q?kXAj5XD4G9mXEWm1XXQ6nNHVg3xlm8DbxHXY8tjBMAoQ/W4oaheb5EFthAeY?=
 =?us-ascii?Q?WsZDbgcDT2vLvqOhKpoGlSzfhfsKrmW0/62R2+bJOchSekqlOMnRLpXiHsks?=
 =?us-ascii?Q?kmPz5DhrUTIPvaA2HkoBUuO+AeBqH++m3CZcG+2O3CsgFHyW6j5LteGiWdB3?=
 =?us-ascii?Q?jIx6YqmAae6d8BNnNZ+Kaw9oSarv9Xi9bHVxAyC9cTv4Sx2540T+MNkK0XJz?=
 =?us-ascii?Q?OY/3d+VCgwQeSN4B4uAU7uDQwfp27QRQMAhFe23vnfol4fcY2S2/HvGhRmhS?=
 =?us-ascii?Q?2eLt9hiEjT2aCnbb8YfzlilUW0+iYlraL/kBWfr1Oen2SzwP/tA3Ldxfe3pi?=
 =?us-ascii?Q?k8mq9XqB3qc/DWRGr+Sd1y1he/xoA5v8SQVoLllZqOoEm5fHWMXIikIkNO4t?=
 =?us-ascii?Q?AOaLKDQHTzUU0sEyq6/Og0RCVRIdYk2DnLX7TQ10GgAqcj6Tu+SKm5bpFhvh?=
 =?us-ascii?Q?iJKj6Nf10SiYB20MJ6cmaILdQ6rGU5oxOGQNeHn0eHnvnGlkME+pEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwidIKnYH3gs4KpKhqtmPZi/CPmWkMvy9SyiKq1K0y292iKaPcH0o2XUzrcC?=
 =?us-ascii?Q?4aoYeTRaEuIGQvqag5EAQjJ0v9uRuCEmhphyk8MiZ2Hu08K6e4aX6viLcP0l?=
 =?us-ascii?Q?WtzvpTISqeHVMG1uR2NNiNBJ6aqLeWoQvvdw4aG92H/+5oP1YIqf8qipcppU?=
 =?us-ascii?Q?S7dnMR1QGIPQ7t65renv9Gp2jyhqBga5qNX9c9NtWM1mgwFxlKnXpAtEtx/J?=
 =?us-ascii?Q?wx6j6QEfk4jezdJN+IlTMiEZq4wlpgTvO/pFjvcpGtTiPTgrLS4QQ3r8ucy4?=
 =?us-ascii?Q?CDHYmkqx8rcVSjX+EXOD1dkmQu1nkkucGAdHyYaGT47F7m7Rh+wHgdSNKj97?=
 =?us-ascii?Q?Z5Rw7PrOwtAu+rpnwYkhBTHsXKZE2pnxvcZSxcxoercSS4F1nIOxLQJ5WMoG?=
 =?us-ascii?Q?6/bH5WMDxzYJUpPIhLaxXkACAu2N2tIk96MDaKLaGmD9wiAGRMprdW2TVQNd?=
 =?us-ascii?Q?a1cnDMfBEjZmmfo+w0QltaqnVCSrly/vmM6Nj3oLBUSBP/UvEyXQKRjQakS3?=
 =?us-ascii?Q?I8HjPziAYWE+GWR7ev2nwTynHHZKskzkviT1ay3iR/6q10fzPvhJmGCO9b+D?=
 =?us-ascii?Q?inHSuyKVdlzyKvW9c7U/B9rde5B6QI5CJyMQ7IGxVDFd5YsopzMrBWYnAmRm?=
 =?us-ascii?Q?3HF+XDNby8nztlDf0BrTuoaq6tr2G0lVr8aYqmbiGZVMOY1HxcmlZ1fGI9+t?=
 =?us-ascii?Q?Pj/LSQIii2jh5Ryws+o44qAyR5XrQSOaErmt7DOi+98HahGoW5+r5sDNmHA3?=
 =?us-ascii?Q?PIRsQAvm3efTNl0DkX7wc2wUedn9l6SCLhd75qZCWknCPbOaFRXTlDkUf2D/?=
 =?us-ascii?Q?IuA3WZkxx/0lZrgyHvvhe+lNnebj6HLukgxYrlxENz6EXYHCq4f3vC/JKFsA?=
 =?us-ascii?Q?80wHNJKkdtbLLt59re3DXTQafy9O00b3IsM9o59f3VXDUS8D/+NBHdkPKiSe?=
 =?us-ascii?Q?AJ3HryctCUbN20Lm0iG+LMlrRFwnAe7YpWaWSsxEIPaCXGjZGCHIyJpmwc4t?=
 =?us-ascii?Q?x6Dzjcl91K9vBqGCXEuM2hRcW9SkfFkFjfOQfyI/DGZREPZx7hJEh3lUQra+?=
 =?us-ascii?Q?gfn7i/7mnLf4r1/d0aUrIi90tijnUy5Q03Y2CFxS5gzDorJkhY1ob+1NY1Ln?=
 =?us-ascii?Q?90GYgnKt8vgDWvh41i++Df9EMdOj5iLRdUmT6JJdjR3cNSjH3ztTuqyOYjzc?=
 =?us-ascii?Q?fCaFRG2AKswBhZGtKfUdGnGQVfMBaQQnLDCcepNW2PI6Eexn+lKKHw8TNSpy?=
 =?us-ascii?Q?+GRoHvhGcWHU126nBFlI0Zj3bRAwswyM4pSfcoT18PBtrV0ujWqAOqBkVeBJ?=
 =?us-ascii?Q?DSb57PAziQcxgrYh9Yql0xJmfrK4UjHSBbj3FoCqQornmg1DlC5hQuvteeX+?=
 =?us-ascii?Q?GmxjdejpyUI5nzzfxUiF4OFsRxZk0THDEyRKnq7oCR7/dI8JoHMytHwmk8Ef?=
 =?us-ascii?Q?Vq0HcRkwRJrKUkhlsm82HAuam7mkQSf9yHbACJI33TRIu9gTmJ39aB03UHQH?=
 =?us-ascii?Q?GHmTd7jMKStyC/GcWarJiOj6y0ReXjK56YIm5Do4lb5S3TSVzg4ljhioeuap?=
 =?us-ascii?Q?pLWma+4TtXIla0+zQXhi1csYWuc4HZ+JOrhd/e3G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75a06b3-e236-4fbd-8e0d-08dd8c77e398
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:27:50.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuMpBE6JvZJgSPL92iMexcuiqiJxd8ZqxKFRsWrAci9XiuBOXmNrCVuHhRKVDd2wD69iNDkHrE7JQ5oS9iLxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

Since the offsets of the VLAN hash filter registers of ENETC v4 are
different from ENETC v1. Therefore, enetc_set_si_vlan_ht_filter() is
added to set the correct VLAN hash filter based on the SI ID and ENETC
revision, so that ENETC v4 PF driver can reuse enetc_vlan_rx_add_vid()
and enetc_vlan_rx_del_vid(). In addition, the VLAN promiscuous mode will
be enabled if VLAN filtering is disabled, which means that PF qualifies
for reception of all VLAN tags.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  4 +++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 12 +++++++++
 .../freescale/enetc/enetc_pf_common.c         | 25 +++++++++++++------
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 826359004850..aa25b445d301 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -107,6 +107,10 @@
 #define ENETC4_PSIMMHFR0(a)		((a) * 0x80 + 0x2058)
 #define ENETC4_PSIMMHFR1(a)		((a) * 0x80 + 0x205c)
 
+/* Port station interface a VLAN hash filter register 0/1 */
+#define ENETC4_PSIVHFR0(a)		((a) * 0x80 + 0x2060)
+#define ENETC4_PSIVHFR1(a)		((a) * 0x80 + 0x2064)
+
 #define ENETC4_PMCAPR			0x4004
 #define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 2d890f7bcc95..1f6500f12bbb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -526,6 +526,16 @@ static void enetc4_pf_set_rx_mode(struct net_device *ndev)
 static int enetc4_pf_set_features(struct net_device *ndev,
 				  netdev_features_t features)
 {
+	netdev_features_t changed = ndev->features ^ features;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_hw *hw = &priv->si->hw;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
+		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
+
+		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+	}
+
 	enetc_set_features(ndev, features);
 
 	return 0;
@@ -539,6 +549,8 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
 	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
+	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index ed8afd174c9e..8c563e552021 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -135,7 +135,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
-		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
+		ndev->hw_features &= ~NETIF_F_LOOPBACK;
 		goto end;
 	}
 
@@ -376,11 +376,22 @@ static void enetc_refresh_vlan_ht_filter(struct enetc_pf *pf)
 	}
 }
 
-static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx,
-				     unsigned long hash)
+static void enetc_set_si_vlan_ht_filter(struct enetc_si *si,
+					int si_id, u64 hash)
 {
-	enetc_port_wr(hw, ENETC_PSIVHFR0(si_idx), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC_PSIVHFR1(si_idx), upper_32_bits(hash));
+	struct enetc_hw *hw = &si->hw;
+	int high_reg_off, low_reg_off;
+
+	if (is_enetc_rev1(si)) {
+		low_reg_off = ENETC_PSIVHFR0(si_id);
+		high_reg_off = ENETC_PSIVHFR1(si_id);
+	} else {
+		low_reg_off = ENETC4_PSIVHFR0(si_id);
+		high_reg_off = ENETC4_PSIVHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, low_reg_off, lower_32_bits(hash));
+	enetc_port_wr(hw, high_reg_off, upper_32_bits(hash));
 }
 
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
@@ -393,7 +404,7 @@ int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
 
 	idx = enetc_vid_hash_idx(vid);
 	if (!__test_and_set_bit(idx, pf->vlan_ht_filter))
-		enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
+		enetc_set_si_vlan_ht_filter(pf->si, 0, *pf->vlan_ht_filter);
 
 	return 0;
 }
@@ -406,7 +417,7 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
 
 	if (__test_and_clear_bit(vid, pf->active_vlans)) {
 		enetc_refresh_vlan_ht_filter(pf);
-		enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
+		enetc_set_si_vlan_ht_filter(pf->si, 0, *pf->vlan_ht_filter);
 	}
 
 	return 0;
-- 
2.34.1


