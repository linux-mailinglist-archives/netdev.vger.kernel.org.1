Return-Path: <netdev+bounces-143951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16729C4D51
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F98BB2AFC5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFF207A14;
	Tue, 12 Nov 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="STH5uxzc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3518207A03;
	Tue, 12 Nov 2024 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381563; cv=fail; b=CpO1UA+ZE5VByclwnu89tWy2+2PMMcUNOIBeV4dMNGGEVA9Mm6BdqPQervQO9k84gQUEZxzSjxVsWCB1aKJytX4AW1D40hlt5v70IYhTP2N7xnWOlkzxX1qlhsjcbjF46Aq29qr4IpfuhgT4GxCHrZPxh3GvSGlGboJzyCyB/m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381563; c=relaxed/simple;
	bh=/7CRDnOM6+0lMHKcBhD8JAAYUXv5wjOaStduAjcxHuw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nGwA2cdmC0nVxjRBsfGcvIUftmd51XbzMWQK6lzPDZbTg1a4ceZVUwb91u8Mj3tVK3jDft6ZT2qbM2riwJW+Dpf+9QU+d0V+oNQP21AE41RCSSObHUJy0goLWG7Hsux/6FOi697CmA6JmC2GzRVoMxnsN53m3T/uqj9I6TFWs68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=STH5uxzc; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBhDsnvbp8YVIL99WbIhLCgHY9jax8KenXjtzuXSN4l1dlM/qDCHeKjM/WAZa7U0Cn6n97NgE8YDGGZ3XieStkqUX3I6HTR4KtahKeDF7GipltbBVb7xmcxWiJ+aayA6gaYMDpk0Gs2Rky4GVZFvVxuzIGjsvrc7Xid8RlLRJFKktwG+Xqgm6jjC72+UPoHaPFQBEtj/7b1CyjlMKcCL6fRqrNEYMvtHmp7+mPKkSpV92Zvem9B+v4OSyO5wWK4tXS5rS6Ryyqryr4dMSLmdIS5u5P2617w9hsOpbD7w58/rEBGCxT8mAYIFeRTfYj08R1w8L1hH6KMxYW7aB2q8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHJqYGagc3b2r9zBqBX6UOf3i7eeoxZKmLmmFYksZvM=;
 b=rfaHapPq7Ntz9DFLM6sJmEko+9OpANzMN9fTqiD8RoK2fIwX9v9iy7OZ71NTqiP81kK4+oU7cAOhH7E92+EfcyEOKLTozy6ujf1zzBvmntX0R9v2Mm0YM/nn0jP8bqfVZiu855jQQGtB0Ijgf4UhgKnuR5IXYQTt/LuVxnHoTTwEuzfFHGRzxQKpFpO/BmVCqcBNln9a3p7/ymD4UDEhFm3d5rD3Ucc/4ATsn3LDR1atiMf6dnZt1ZmRBDvsCEG/uOd6Z/ix5Z+XjXDcLf4HzRhRsRr7Ls+jtxtJOlsK7Y8uaL2cxXf53O3RnVFeXnbRSI27EjmWZW9saHRTDsZpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHJqYGagc3b2r9zBqBX6UOf3i7eeoxZKmLmmFYksZvM=;
 b=STH5uxzcTm+gXrvAhu8MjrbMYcNelK5vy5O0Af8EZtqphzvtaYiDeB7MCkeo3kDHc1NOvXIdYtK4W24hCYH07/FvNS79wIKpXf856qw6ru96/BZsy1l+HL3hZIe7vlG9hAVETPNxu4HqNxPzhgkfVuOcGTF3MOhZb7HlNwT59I7zgSvU/177OmFTzhurdfk2JMZmz+3ueq+Lkk5Z0U9/RbUuXKfP9uwzi7iPujtrCLkDUnbwFFg/WSve3SFS1KG0YAACqxLHa5KyO7sdh5bPXrfeWOvBF/cbnv9fr0uyZb1fzdq/hDk8EdfrOsAsOO7LOENaUsiIZyA9YmLoyFM0ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 03:19:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:19:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] samples: pktgen: correct dev to DEV
Date: Tue, 12 Nov 2024 11:03:47 +0800
Message-Id: <20241112030347.1849335-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: dd25a666-5f6e-4719-c5f7-08dd02c8ca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qj4LWpotOssSSu11emOFluPejaF0amJ/Lr88cxULYyUjTyJM8fhqDxpAJN66?=
 =?us-ascii?Q?LUX6aknUCSTa7VrunrGh+MTMwwiezDzibSkcswlweMTmrMtzPEy08nc7NrIx?=
 =?us-ascii?Q?XFZwTKUezYQZk443dWICRYjoH3OLneowpu3RK3Td7pclnxtprNCaWJHR+RMa?=
 =?us-ascii?Q?PjexHhya0QQ0gIDttDNCNnwac3SQtJN4ubO9AFuPPV3FP1mXvve/4V7WUehG?=
 =?us-ascii?Q?LJ7oYVwksBAWYdG3z+29g7P9s0JTctGi2K4FTWnpWv23XWxnjjK/b+F1B9Tk?=
 =?us-ascii?Q?fCOis4fq4NPMVcGzTjwB6Y6qk+tuqOFVLh6VXsjPEsIpv/y0KcwhPiRfXvRC?=
 =?us-ascii?Q?7GXPHPnVvzlyX2eKR3OCg01CI9Ho74Rv43kD5bNAAHJljkpowC1NlYzTDcMQ?=
 =?us-ascii?Q?E5VJ7WiLSTKZtJNiPrfTWsufnLz5W3sF7WFN00ScwLeD/gpxJtMrSyHz6lly?=
 =?us-ascii?Q?5hJl1Epd4/99KtjjF1arrLHaH8tccGN1eMBhpvJP8xMer58NCof1Ev59yBrO?=
 =?us-ascii?Q?oavclO7EJFEK9UWgFZNFa/1Lb6I66gtdS2CTw6015C5cgxoJ5IG002ARKOpi?=
 =?us-ascii?Q?Fzkuw8ZSqYgne8jqwY4StIgX9i1TxbMnu04YvHcNKb32Xzvs/CeSFt6B1j/D?=
 =?us-ascii?Q?aslwsxEkzbJ2nMTJDrUPbtrF4NxpVN7FPgIQ1IUpnxKL4aTRODAtgNXp7XZM?=
 =?us-ascii?Q?KybE8r3BijIvuTsdRhkguKrwy1cMQMPuj6USmlGmo2nifw4UNvUVJuYM8mjE?=
 =?us-ascii?Q?tYehKQOAUoSzonBdLLovsonlUk4AKZaWHfU4BTfxN1NFZ7InYNLG4Js3ITYO?=
 =?us-ascii?Q?dxCGiP1oKjYZhP4kIqDI/vkH7SQsgR7+klaWtDQNqX3rttrtOmwIYhh1d5Y2?=
 =?us-ascii?Q?bEcWrNH8QkNWyEv25bOWQs3BNCD+VJieCLxljuVSYZFAmFykDtgec7Qpi8gm?=
 =?us-ascii?Q?eOJ/9Tf0SN3Lrd0KrMJ4dupmNue6lm9xBSrY0XkKGTJQmQXIS7yUPz7kNJ6j?=
 =?us-ascii?Q?znOCO6SVflDeItqF9M/H5V/Zydc9AWohqTP9MeBjAcPnDbKUyvgwQdkqpzDm?=
 =?us-ascii?Q?dby4HeQ6IeJ8QPq3YZgAHZqxSKpDKv45pnVEb7kPnI6k/HZrFcprAcE3Pep+?=
 =?us-ascii?Q?pNNxR3irBem5vJi4nezXFpT9z0FC7975+Iiv8sxbaEqbdJQVz+28b02aX1Pd?=
 =?us-ascii?Q?+jCtV9YwCiMkXevCXTwyAAnMJHtsevRFuVs+twbxyRXA7wOjQIt7VtaquwLr?=
 =?us-ascii?Q?pKsf5g24klLgd2e4iqjAFP8CAoTdnr5p64catg1QPuHKMw1ViDxj9jVIqI/s?=
 =?us-ascii?Q?Ir5XF8lpROOI+cN6P2WRur6ITOatMNKi2xIHNsehwx0+XdnuMNuN0IcwRgV5?=
 =?us-ascii?Q?ISlRgXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXTv6jmKcLmnVvWPaV0fzZyqwzk6BRmrMO+BRqei96s2Jh/o+nulvBs0qeyk?=
 =?us-ascii?Q?WL+WvJYCz4iOZtqOWQmIigL8kqt9Z39+7dG91mtVcLGh3X3uVsLPUQFzOA/L?=
 =?us-ascii?Q?JX7HOohGYSxL2I5vyc7J1ZrEGGx6b/NUr7NM9o0wieUf6ZCoJK9UXjs89KOj?=
 =?us-ascii?Q?rBYWNX2jkwhZMbDZVF1eGgjQKRDcFXzMnuiNr2n669vl9iyqHWKHMWobshvn?=
 =?us-ascii?Q?zKUJiSE3L8rBIWIIX7s8jQ0iKXIEU0Xh7SW2LM0s5NbB9EyX2rxgePRaCwE+?=
 =?us-ascii?Q?32DOswgekMQcMmaRDpcp2ZOwL6SDM7Mcu8ADMIwuzT9WzKV3r6uhx23wGECy?=
 =?us-ascii?Q?8SfmXbuwt+i0JMGADHyx6IWUjWhLDt4hnwg3ZrC/CqDkj2LjtJxYt/jf/3eH?=
 =?us-ascii?Q?ktSsjUqxEVWpWAXF8VSf+1zsE2iILavB02hHLqd9ITUAXEoed5rE+mZomcyW?=
 =?us-ascii?Q?/Ytc3jRg2cfbRQ0skR/C/JdHzleeSnLQbvDpfqbyfjgeYOG1gb0Qmf54yVwM?=
 =?us-ascii?Q?1aKqs6Ie5ysLvqC31bIb2axHzMP7nA7EcYiCK1Y3tTQ/agqic+zZCkiB7G88?=
 =?us-ascii?Q?F9pxXTIVWdBKGZtg5oq/M+ie10lxJsUZYXW1uLGTobs3k+tyZiSNgxQOiEHp?=
 =?us-ascii?Q?oJ58cpZN0MRol/w/m1yITENknrbhNqmZ+iS5VVsXlfkxYWyFfzMyT8gv4rWU?=
 =?us-ascii?Q?sAJVLLZMgP/r2dOtMRVAJactJb9jOW/rfSoIzQAWSS0tSQSldaz3EZlaYkBT?=
 =?us-ascii?Q?23ChI3pk+ilmXJjtXPjcmDXhtkbd2aCPR5ndzogKGC7NvCVWUwh9l4irgx+j?=
 =?us-ascii?Q?x5UyeQqh3WWJUF2tZb+h93OYBxTPjugJ1x9USbZ74UZFDp3OWFcaWgTV1JWh?=
 =?us-ascii?Q?KLADFscxah6MKVznOkKP5p78SgZMfRr8wH1raJK4IOIFrgwYILrbMEOXmvGz?=
 =?us-ascii?Q?BhO3dzZ36j7fC10r8LdV1I64ZKlICa3xI6gSygZCZIiQi49Q3smPsmmibDCF?=
 =?us-ascii?Q?MwNSRk4BEE6ReL9FjIyhOrWtuSK2W4OF0FhqMMPQoRFFMcmc11Yi6PyDVzkb?=
 =?us-ascii?Q?z78FyGHkShSIjlN/7REIbMwAiV/5KedoqtE62hitPKsNN5q4JY4QWAbtVyv1?=
 =?us-ascii?Q?SOIExY772j1cPH9vT/FHPHNnCDiuocgkAmkZt/su6n1oLIFqlLj+vgJGqAsZ?=
 =?us-ascii?Q?BtwlMd0eQLYpkSSa4RosHMcZzt3DseOdC5Q4qTazVvo7HAOQ3phGVeY13LZI?=
 =?us-ascii?Q?N4dE0kul2C8WYOur5tSqGM5Fm8VJibHjDuap/Jlm9CQm9TubqhGGn97IO2lc?=
 =?us-ascii?Q?6AcbgdFoukXkE3Og7s9WPrTUH+OvFy1njLWJv3iXelR6QJkG519VLqa0reyb?=
 =?us-ascii?Q?KPBykb/TrI8xGpkoALyPMRmUMoZtKMawVRjBClOWIPp9O0xPQ82IKzeMa87P?=
 =?us-ascii?Q?LXj1fgcOv/gMKfbVGrBon1qXv876kPvR2HnwYVfwPjwNERXkwnzICycUDSK0?=
 =?us-ascii?Q?FZ6C2CDJrarwo9Sb72QrRR5/tQdpiGUAe3VM+6YUw6JxPyaq1jS5CgmbBXq9?=
 =?us-ascii?Q?2/ywFJ38BsKLEiuN2H+hNbFVQ8aiZp49DcJFqgR7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd25a666-5f6e-4719-c5f7-08dd02c8ca50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:19:17.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIaje5ljcbNN+QuioYJas7aTsFiGV4AFsJPpC4iKfKLtUrkIjz2RFNPPmY/Lh1YM5PogR0s6bWfdUhPkomjREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

In the pktgen_sample01_simple.sh script, the device variable is uppercase
'DEV' instead of lowercase 'dev'. Because of this typo, the script cannot
enable UDP tx checksum.

Fixes: 460a9aa23de6 ("samples: pktgen: add UDP tx checksum support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 samples/pktgen/pktgen_sample01_simple.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/pktgen/pktgen_sample01_simple.sh b/samples/pktgen/pktgen_sample01_simple.sh
index cdb9f497f87d..66cb707479e6 100755
--- a/samples/pktgen/pktgen_sample01_simple.sh
+++ b/samples/pktgen/pktgen_sample01_simple.sh
@@ -76,7 +76,7 @@ if [ -n "$DST_PORT" ]; then
     pg_set $DEV "udp_dst_max $UDP_DST_MAX"
 fi
 
-[ ! -z "$UDP_CSUM" ] && pg_set $dev "flag UDPCSUM"
+[ ! -z "$UDP_CSUM" ] && pg_set $DEV "flag UDPCSUM"
 
 # Setup random UDP port src range
 pg_set $DEV "flag UDPSRC_RND"
-- 
2.34.1


