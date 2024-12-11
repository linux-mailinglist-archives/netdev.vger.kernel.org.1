Return-Path: <netdev+bounces-151123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47439ECE71
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41941681F1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE363246322;
	Wed, 11 Dec 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="G7QF5fBJ"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip8a.ess.barracuda.com (outbound-ip8a.ess.barracuda.com [209.222.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FD246330
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926919; cv=fail; b=GdjLRWt4dksB3gVKynTd7WC8J7NlZ8ZjD+4PzGsrPycftyWqcU/Z6o+lQdpE3CPYybuCaHqcRzJgYxVtVzU0h+zrH1RcC7J5vYLKjgIEsYZzZvxw5PInAN9IDDJS1BlDVHK8VomxTNXT2Lsmtan+PnSx5KEmYDHnc2387Q2dWBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926919; c=relaxed/simple;
	bh=yJmuBfIP7XIEeBT9bCbraAbd2zVfG7IRH+BSUMHanAM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H6kd0QprTad4dG06B1C3aXrV/EH185PIGWM5Q9GBfarUO12ixio7k8pnu81xOch8VutxIDFS0wUJf90QLPGH1nyctG7tW1uFsE7nQMlKfgd2pGBv9xuMNt6lheTerZEcTlrk9I7nSvvI+zig5nUXUJKS1/TCnnRlE9RW8jU+DDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=G7QF5fBJ; arc=fail smtp.client-ip=209.222.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45]) by mx-outbound14-65.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jxe/zQovNM/vxLoRxhyBQbCYQXgtGj33gQuxBDdbBbPmBo8ftGFTTu6N5t0+O1HYpkEi4Mkp+QQR5E8CytBWjq3g6b3wckR1gecIEksLYQ+OyDiVSVMwHRuI2NAINt2BuUXbHpCk+1aC48j7PXbHCzjNWGT2JSYBX3R6MmWL6+giQh493bBAkX8LD5X77gEhNRWUEZdTiC5z1apF6CU37vPPHUZ4k9PJIAMnMT7On3MEovtJ0LSQX63Mfx49wgnEnGR+eI4smTFMYvAq8pcpE+bgxslfQXo4szttiau77Gee7h53u3tB3w2DOUNrTzKjQwrLXhpnzPL2vUDuetlL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbMR5Dxr2kYyVzgT3KyFsVJH7edTo38pJVwm6TVX6g0=;
 b=stR7ouKOVGEUKAaVy7LFG4H89F8tPOvCFuXiilsqlClLCtMvc2tv/x66A+XDqLzIn15Ipw3BpLNMF+bhUBeV+N2dACHynV2scxWrTfyWBUjRXabYz5O0xWA7+caygCpMiMvJ+p/i2DoCUxFWpP2QhMUQS1m6YlPf2BwStU2ZOnViKQozTR1Z0Pxz3EiP7mdMnI+eDidv2HeFGz6AbgiGDrWMctgdvXn2nC/XQxe2GWm84ZgeVy0YkdtLXu5CEBpbmzVmUb0kdusYhJp7JoyTqqabXDc8JbLYmcS8pd2Axej3BufewmUP92i9kQnwHRJyUPQQs2NC24498qujpyGRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbMR5Dxr2kYyVzgT3KyFsVJH7edTo38pJVwm6TVX6g0=;
 b=G7QF5fBJwZlKA5M83m8F7snURrTFpCLNaQYRJkPHBd+ZQGewNDB3seXFTIghUsLieSGPsjNKoqAz3wENnagsd2GmteMkoWh8o7TtIW3XRSooaVDANI6rCuHcl4WZnXsI9JtukXojugIe6NAEUvGT7rXhi4Hhar5hpXk5B3OHE9BD30hmGt16E/q6H2ukf3RQjbpjvphYkjnyeZ/qtQZ2TYhyrlj0yq7yFAfJIU0uf45NGWR5SRKrzdPYiXoXvh7oZkDqFU28bgD5NbpEwFRDRWUztnuqWoE+Rw1uspkq2aVA3SHusgI+XHbsGoKbyNg0i0sByXLLZnNvPmBpCElhMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SN7PR10MB6570.namprd10.prod.outlook.com (2603:10b6:806:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 11 Dec
 2024 12:48:31 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 12:48:30 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 13:46:56 +0100
Message-ID: <20241211124657.1357330-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SN7PR10MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5dbbae-8cd9-4a90-ac9e-08dd19e21d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?GmkZEQlE+PeE/YQ2W6RDcj1skmQwui1kun3EU4bYxJt+ZvqQrCHCuCEQkyWc?=
 =?us-ascii?Q?mIJiV/LGKm1oFj4pAwufiL8aqBp+OPe43VpTx/fLXBkTxdI6e3UiYJ9gPtqw?=
 =?us-ascii?Q?IOqiuDg+eXqHiVTNQ8o5JQmF5aqUqGxqkfI0G/DDbbCgSBVcIWL81EVhhxUN?=
 =?us-ascii?Q?P0XN0hSgQVrbvwkzDJbEEphL3Ew0KEwSbnb+/rvtb8SS0A0ueoxDA08xQLkx?=
 =?us-ascii?Q?wNiZiO7mQfldCNGL/sBEeoBd7Dc+CLK0+d81CYdDXYvr+vuZ9TapapForqPJ?=
 =?us-ascii?Q?aF7pgY3osxJ7kj6rhPHxyCr/KvSP7z0FR+T4iiPzl8Rw1oJVsA5MjerQt3T6?=
 =?us-ascii?Q?Eono6/U0JwDRc93cPQOi8PSERFiHkHY/RRlzCdwtWgh8Hh4led8K8BTM58L8?=
 =?us-ascii?Q?M46GRBB0ofePMwQJqkiUzuiUD8FAKPZhfzInYbHoulm4JJonfjR4SGpBOxiP?=
 =?us-ascii?Q?EihF5Zkdd4dNeV9IIt15aQrfkuVe0gKfbtaPPCgjFK0s7nM33fokn7dpTPIE?=
 =?us-ascii?Q?Rw+dTlkr+6ifbDZ7zRmyHok5kEyBz7GSZkgU0pGeW840npX+aLDJ2GypY3Ur?=
 =?us-ascii?Q?P2ROCKnMaEmOLSvw2luR5NwO5ixAcD9uBZ4yjWGPr9Pwx/Eq6SKvhyrkfecn?=
 =?us-ascii?Q?Us7ZoG+63Ot0dJTtVABvEFGS0QI1gPuWtrPs9L2AlefYMeEZRV0O25NsrxX6?=
 =?us-ascii?Q?ondYfddcaDN/EsOBKqfHDrJIwuP/8Oz9idUlCEVHAk9azOIatxsBCjy0a9XG?=
 =?us-ascii?Q?ejpDvzYr8YPtnN0WkFdOPaeCUeryXHdjaRmVOrw0qaJ5xMqEGpodcbA/ijIg?=
 =?us-ascii?Q?JN9kD2JrPHpilu6ZWuqX5UKavZgMz/nyha+PmUoTDsL/s2xABz7jdkQN7caD?=
 =?us-ascii?Q?ySNFhE1dNdvuAk0xlig73UPMwZwMnxEpaFPhr8bgv9hc1puDyfeIBf/g/3rg?=
 =?us-ascii?Q?1sCs3WM23Hum4xUvFmnWh6kO2JOJ4AplSDm/m97EguYJV70hNiPXPZkngUU5?=
 =?us-ascii?Q?PxnEhcgaLjLh+PJy5NAa5nXoS1LfqoG8/2zVI77A/pCeP3LJnYFUMWqBbFrg?=
 =?us-ascii?Q?68xKJVqR4p8m9en4U5e3qjKqfKosgFxn53YuJckdzxg7JDfVqvjtxa5troI7?=
 =?us-ascii?Q?4VtjAHJO5cHjfscDaIpqZxcPA8WjRb4v39OqyfwVWi/3fvrWAPe1AucztfL5?=
 =?us-ascii?Q?gm/hzXQTeXAVKe75zHBfGimODjA7o+hiIxUVKUuuAVs4oYIfRTjam1V58rc/?=
 =?us-ascii?Q?VrRIjtkWVrMGeqLf2gmu+tE2FDMIl4YAAZKSzVGkvCQ/rKtxuPZVIMIJ1wmY?=
 =?us-ascii?Q?+MbYVUTr0agVbEZOcnQYnaxI6JywaLW3TI4LhiLEbnVBXut3a+5CXlAyXj36?=
 =?us-ascii?Q?TdGBupgAmId7iAhzpRG6eEmDlmggoIUN30D7UgDlzB7pLHCyvEFPrXZ1KTRo?=
 =?us-ascii?Q?Zqr1oMdlZiU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6aJQmmwGLfZNPs3Qpm74DE1G4uZVYw0Rr3Y28bYfBHXL2Rb3/QTrf1aV2EFt?=
 =?us-ascii?Q?EQDyijXNMrEUQxKZILo+ALy4j3MCOnXC8VK2Xzd2Gyd1LZXC6aNztLGuz6pP?=
 =?us-ascii?Q?Srtd2QJFJB8FmdHRzZD+sAlJgbAH48B+Lnm1I7nbsO3TSHauCSu8cuwz01Gx?=
 =?us-ascii?Q?qvK/vZQHFjlxP0CdzR5aRL8SV6S3B+BGS/JJK6F9roxra/+VXfXR39f/dIND?=
 =?us-ascii?Q?abmHzZaTzrfkbZlWRiJNubnbqzj5nTntL/jtDrLjLVjzceqScTtrpg3s4TbW?=
 =?us-ascii?Q?MTfOVGo2Op0ygEZy8aRqAikJ6VNklMsp5I+pP5f8sy1BlhwooUC81HeicKIq?=
 =?us-ascii?Q?ZbFHDtDydaX9lOIsJSzotv+VIUTry9e0zWMbU17cOJT1sZdpcKhplo3t7npO?=
 =?us-ascii?Q?2AsS4ahZpyP/Xh9yQjPfKt3Gmgq1IQ3Nkzi1kdzrwr2P/pRdJ3CsxiSdgC8a?=
 =?us-ascii?Q?YwOE/CmjsEQzHfOpgdZDWGBdcEqRKwCFYCcKFtbWsj/974gKetzhAcaYrMzX?=
 =?us-ascii?Q?qTju/T9pKFhKNzYm44VJPrdtcO7pE+hhveSsv1x3HWse2pWjDNoSLHpXz93j?=
 =?us-ascii?Q?H/stH1kVAsxBlUa5eqqkjwFqTF7pAuR70YL22VGi/lXfuFNo4zlvkpeGu3lH?=
 =?us-ascii?Q?twnGhIBHv1p862/Vrb+J2EYbl4Sa/T3CRwiofyGdlP42VuDZW4XxqyBK0gO3?=
 =?us-ascii?Q?pA8Hca61gxuPFINh4kKDdSi3+/+m7f7MC9JpucrYHtcusrj+mnzSkbqyFFoX?=
 =?us-ascii?Q?MvuAnToQZPsfPO8F3VYbOKpj/9o8D23iIJgeXMsKk5j0P0djublcSeBcWDym?=
 =?us-ascii?Q?cV8D7L/kIgB6FoFBVwRV5FQ/4EXtASwXF89YEeAgAwbvBfAsjdVqy/f+HoHS?=
 =?us-ascii?Q?LgvHljkfpQnWiPxJXD0LPmc/8K46xzSHD8xyZkhUgI/qohB8ArO7TxMpoDMN?=
 =?us-ascii?Q?LmWYGkqiQHqWNd4LGLpyYichPItTFSW1EyUHsMOUyw4CMbLHALy79ha7W8xi?=
 =?us-ascii?Q?TAkJunMEmREnuv8sEujD7femyscALmuhsAPCSEOtno4I1NJzyCX+rlsS6se/?=
 =?us-ascii?Q?/OdylKHc0AyrsGU/rJmNQiBv2wYTQzjVxG3OpY+Ji+goIftm6cn08M6+3gJH?=
 =?us-ascii?Q?C8MYJuQ5jeUvUhnSjljZLBZp5Vn0ZtLFTyk5CiQUyJsX39ZQU8JbsB0aRo9m?=
 =?us-ascii?Q?W0BLz3Y9xR7iO9HdUFgAFq4P2bbgMbKVifCH1Q6AMziCT3Hw56z+7qkVw/yq?=
 =?us-ascii?Q?sNgqq0OJH2E/6EuSvP3hLS0d/xDooQOxWWP6S3e3DFnoCXHa0YjYSH25xWeU?=
 =?us-ascii?Q?VmdX2l+cEYl4TIJCGVYWF90loeljrXlk2/dfUtcK1wyNQuf95viB8Otb/Isi?=
 =?us-ascii?Q?2RtUG6XHbvM/7ZrUSTdn03NCQBLwOjVTVgzOVuva/zMSJBtH/HGykrNNRwij?=
 =?us-ascii?Q?6d5AqF7vxkyXKOhJHU8CBg8/I6yOJKJvEh4ToTZlmcgqDQAOmR0nfKz9YQ2Y?=
 =?us-ascii?Q?zwDJex02MuUXptqbQOoWjJQ3aOL1VXuayfCRWcjqpnEo8Q4ySnNRgWi83blS?=
 =?us-ascii?Q?y0Jbt4JVcd0Vb7iP1aIYmKyTGPnmtj9z2eh7NoE1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5dbbae-8cd9-4a90-ac9e-08dd19e21d9b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:48:30.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiRjscpAB8+QNPoTaCXVTFeYD03L3yK5Gddq0owrosvTVy1hvkbBdV0pdfQLEvU2n6Y/9+Wk8Uj188BgRTjSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6570
X-OriginatorOrg: digi.com
X-BESS-ID: 1733926911-103649-13361-10798-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGpiZAVgZQ0MLMOMks1cDYPN
	XA0MLEIjnRwtzUNDkxJTEtOS3RxMxIqTYWAPmWzgdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan14-131.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
absorb logic for not overwriting precise info into dsa_8021q_rcv()")
added support to let the DSA switch driver set source_port and
switch_id. tag_8021q's logic overrides the previously set source_port
and switch_id only if they are marked as "invalid" (-1). sja1105 and
vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
initialize those variables. That causes dsa_8021q_rcv() doesn't set
them, and they remain unassigned.

Initialize them as invalid to so dsa_8021q_rcv() can return with the
proper values.

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: stable@vger.kernel.org
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 8e8b1bef6af6..11ea8cfd6266 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 				  struct net_device *netdev)
 {
-	int src_port, switch_id;
+	int src_port = -1, switch_id = -1;
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
-- 
2.43.0


