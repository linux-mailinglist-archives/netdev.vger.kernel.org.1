Return-Path: <netdev+bounces-106471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A6916882
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B451F21142
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A31DDF8;
	Tue, 25 Jun 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l1ZmRvqb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4D1DDC9
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320412; cv=fail; b=WwalNETVq61zEgZwD1enzo7aXWeFuuvkBItg/J7faBqzQQH++zYMg0zNd6nNAMFNi/pXdHk6aWCR3RzFosgX40EbUNlx8CP5OVJU+Ma0+kElVBgrr2Ab16PmbVd83U8hEtv3TF+Lk8mg3W620yKYTVZIR276nJa/y/UtKXReIxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320412; c=relaxed/simple;
	bh=Hmk9aEQorkgVHmba8kfiqmhLZY0jyz01ToY4YyY2EEs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eIZowEF6nTOKFMijhR5ux90IJx7qIj4CSgwCfpu5W090nnkEHBL1YRsFsz/5faAfYM55lrI4HnojilybTku+niE6X90PFELRcMwA1pi/iUcJukgBrd6ATYloSYRmS4qCl63Xg4BMV9qq2/EBaxr9u+vam7TgwYJ1Ysmy5TWr0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l1ZmRvqb; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLkAno2CLIx9bQmxuIEZf5Vg4Q+4OTd/WFwHYbaodQG0Ryk8IfXkZ6Rwtfq4CqM7YnX+twQtrqE9xJjMZ9G1OMFeb695eGfe5FNatVU8zHdWZX751B2ezOLg3TL1XhG+10axGEq3V1Mior8ys1EYW5SQCx0rz2DNsqiaOChRNShkvnRTmBdpYAjBJq+q1eFgrYpao2dOXmNae2Cv7d2WV7/u9by/oIYVB3kJO9qxrgTqTehd3IasiD/DNnACLUxpNU+86RRoZpIRhv2bWXWaMs0KzCemVg359K9fm6i0xjEX1DpkuXV82E+uYWppdXf6QQDQry2w94SKXeXUp7nMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p2Gbu1Z+PXkgk9YAsx4UFQTo3Dq88VHplXOI7jb+u0=;
 b=AYGJHV+2TAm7fo6GUQsGakBlEVakPX45Mp6j/S+pm5zjMstbXZzHhOODLozBwMgXAOHG+kDzsrKJogyvyDnvzkRy890+2KRdEKxfrMBQQijHZPl06dbiX/k2SeuFCN6ROy2hVeNGmSiLa+tuU8BxAOxyf3c78jZ4LhF2Pc9upwRBI8QTo/gTQ33wlSqPcxt+3gWJI/bpL5GtzaJsxwiS8IWVfvQmvKaWtxgPt3sH/6vFk+qC1fEZh40/EphjHDsEl14rTf84HhkGeD35Bete8GUXwVTlH/gSgOEMsQ45RwaCAVxVHtBk4wqc0T4FIFPZXECL2eAMQfZMsSGvBCBUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p2Gbu1Z+PXkgk9YAsx4UFQTo3Dq88VHplXOI7jb+u0=;
 b=l1ZmRvqb3loj5elL86pK8VCSUn8Zj4eEoEj005UE0zYSm/80QvVo4a6Om1wTs75aex47thcSCTUBQ1L36Ro1P8W+QVuUN0VkddNAK/hfEYj6fK8edekW6v7/z8Ofc9odN4Y/jslSK7anxW+TAdE6YfT4+mdrNf8xpScxlkmaIv5oqBbNgZXsjJelxhyc03KIMJA702hssr2fJk9crvAV4xJds0sBkHiBqehkeQivUB0q3lKBW2CJ5EPbTrLVH61H9gg3RBA4Yb+TkJy/YYp3JMK/ni2nVtz/kRzFJMNHN2597W6hldQuksk5LwiHgV9crRo3afGxIghn60PisuU1HQ==
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 13:00:04 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::85) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Tue, 25 Jun 2024 13:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:00:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:59:49 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:59:44 -0700
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-5-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Date: Tue, 25 Jun 2024 12:42:22 +0200
In-Reply-To: <20240625010210.2002310-5-kuba@kernel.org>
Message-ID: <877cedb2ki.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6f4bb5-8e0c-4bed-b31a-08dc9516bb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agW+BM/D0kg1hW30hXBQTp2EaQAgLb1aPAPx+nZ+ytMcEs20NZpf13UQziVq?=
 =?us-ascii?Q?tpPUJ38nKqENTr62p42R8JhV4ucpzZljsCMpr0KBYvXatFileKt+eHlT79J6?=
 =?us-ascii?Q?pnsDx9u0lWyOCPDQFdckDWveqbi4KJ0YZZIYjPd8kJqVwAlQpstTTT0TAJ4B?=
 =?us-ascii?Q?Ke9Kl7XUVKdWczz765Di2QzvRILdS5825NHi/g9ZRBoC7IGzoh4aOpvQb5c4?=
 =?us-ascii?Q?w8t9cALlQzPnZX2B4yDjuUi2DNi5+FcLfzZj5Fvykm1lZAIwN9BYkqgsog+7?=
 =?us-ascii?Q?FUoEjw4YNy4XU7u5LLHQUT9p83s4FbBIHt90Tqt6hhQbTCG9xd1ETHiswTKW?=
 =?us-ascii?Q?ZXZAl8IkpAy1npE5GBoV5MU3/STYOmvnCbjJgDs1XZYwKU3SJEBk6QqBrTk8?=
 =?us-ascii?Q?GwIoINcmz7C4WlcAVRAtlIlQAcF9GeZy4J90CGMYP0SOmQsOTM27c1iIoF8i?=
 =?us-ascii?Q?Pf+DK5qorKvRlB3XoNUNkfmcyC+iFsYfnhTYFTX4YxXRP/ouc6PXPLINxJW4?=
 =?us-ascii?Q?Jtj6ePcG72oL1mhf36nGxd/l60sD0o4uoZDq0Rea0ryMfDZpFNAx/YUXNlkv?=
 =?us-ascii?Q?N3QVuE9PMaEkMMK5uB1gVzN9vtbfI0ihr1O/wsRnApCugpNb3uguyWCiRIMm?=
 =?us-ascii?Q?xI10EA9zbDwaXMlW4usjUmoFL5fs6eDUiyw1X6gZutExRSFzIVMUJFbwoAus?=
 =?us-ascii?Q?5+cK0oFA2QvjU4y7XarzBaNdadQX0yqr2+CsImFm9qGLJLYHoR4Cdm8W7t3t?=
 =?us-ascii?Q?IXnhOZiE8faiOR9+RS67ZuzShVn2rzqGDwq/aGJ1jXhUpyIc4g7vJXmDjx7H?=
 =?us-ascii?Q?5xAdzPjZnchOHM8FdQ4BKx9XSMk3J0WJvZF3+vH7TWzasQ5JsXGS7CvbT2Ba?=
 =?us-ascii?Q?FDu8QowKax9645zEoqLbntwOPewPagFJYutV/NpBO4RQryyg1kuESPfAWk6y?=
 =?us-ascii?Q?7bjuS1nSETid3enzP6uxH7txTiVZfavTMIeQ970RioRS0Fg9FWv/AA4OZnn/?=
 =?us-ascii?Q?KwDOgX6+L2wTBmNE8HA+5poDgBc6LReDJpKRkO0il1M+QdaiDDQRH2Foj6ps?=
 =?us-ascii?Q?/NgqfTK1ewuu4y6ThBzdDuXVH2HgLlcdlcq4Fza+24aFXgwwgAW2S+eYL422?=
 =?us-ascii?Q?bBv+HnGi1udpqrytQpxkCgEZNMCA5egYhXVkFKg9jk++BGSYKPtCK6fDt94f?=
 =?us-ascii?Q?486bR58f1SovLBOwMwLUF2NxHS0cs0u0/CF3+aSf9C+ttetmQ51c/1tSPb1o?=
 =?us-ascii?Q?ZYEcb4oSinfjFx6wSTBKZ8Q0PGELNSCKO3vaInH3ZZKvCpyOANK0gS1Zh9V4?=
 =?us-ascii?Q?E6yKGzB/xrM52hPbFu7XezuljRt2enT2CF0dqgpqG5Jz2ssJGN8u0PzQ4WhV?=
 =?us-ascii?Q?Qt/QSAAGh8ldmXNfrV2aVSxtje7BVjs2t+XlrHsIT7f/lrwcJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:00:04.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6f4bb5-8e0c-4bed-b31a-08dc9516bb6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689


Jakub Kicinski <kuba@kernel.org> writes:

> Add tests focusing on indirection table configuration and
> creating extra RSS contexts in drivers which support it.
>
>   $ export NETIF=eth0 REMOTE_...
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..8
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # .. sprays traffic like a headless chicken ..
>   not ok 7 rss_ctx.test_rss_context_out_of_order
>   ok 8 rss_ctx.test_rss_context4_create_with_cfg
>   # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0
>
> Note that rss_ctx.test_rss_context_out_of_order fails with the device
> I tested with, but it seems to be a device / driver bug.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - ensure right queue count for each test (David)
>  - check driver has ntuple filters before starting (Willem)
>  - add test for creating contexts with indir table specified (Ed)
>  - fix ksft_lt (Ed)
>  - query and validate indirection tables of non-first context (Ed)
>  - test traffic steering vs OOO context removal (Ed)
>  - make sure overlap test deletes all rules, 0 is a valid ntuple ID,
>    so we can't do "if ntuple: remove()"
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/rss_ctx.py       | 383 ++++++++++++++++++
>  .../selftests/drivers/net/lib/py/load.py      |   7 +-
>  tools/testing/selftests/net/lib/py/ksft.py    |   5 +
>  tools/testing/selftests/net/lib/py/utils.py   |   8 +-
>  5 files changed, 399 insertions(+), 5 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py
>
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 4933d045ab66..c9f2f48fc30f 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -11,6 +11,7 @@ TEST_PROGS = \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
>  	pp_alloc_fail.py \
> +	rss_ctx.py \
>  	#
>  
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> new file mode 100755
> index 000000000000..c9c864d5f7d1
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -0,0 +1,383 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import datetime
> +import random
> +from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ge, ksft_lt
> +from lib.py import NetDrvEpEnv
> +from lib.py import NetdevFamily
> +from lib.py import KsftSkipEx
> +from lib.py import rand_port
> +from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
> +
> +
> +def _rss_key_str(key):
> +    return ":".join(["{:02x}".format(x) for x in key])
> +
> +
> +def _rss_key_rand(length):
> +    return [random.randint(0, 255) for _ in range(length)]
> +
> +
> +def get_rss(cfg, context=0):
> +    return ethtool(f"-x {cfg.ifname} context {context}", json=True)[0]
> +
> +
> +def get_drop_err_sum(cfg):
> +    stats = ip("-s -s link show dev " + cfg.ifname, json=True)[0]
> +    cnt = 0
> +    for key in ['errors', 'dropped', 'over_errors', 'fifo_errors',
> +                'length_errors', 'crc_errors', 'missed_errors',
> +                'frame_errors']:
> +        cnt += stats["stats64"]["rx"][key]
> +    return cnt, stats["stats64"]["tx"]["carrier_changes"]
> +
> +
> +def ethtool_create(cfg, act, opts):
> +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> +    # Output will be something like: "New RSS context is 1" or
> +    # "Added rule with ID 7", we want the integer from the end
> +    return int(output.split()[-1])
> +
> +
> +def require_ntuple(cfg):
> +    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
> +    if not features["ntuple-filters"]["active"]:
> +        # ntuple is more of a capability than a config knob, don't bother
> +        # trying to enable it (until some driver actually needs it).
> +        raise KsftSkipEx("Ntuple filters not enabled on the device: " + str(features["ntuple-filters"]))
> +
> +
> +# Get Rx packet counts for all queues, as a simple list of integers
> +# if @prev is specified the prev counts will be subtracted
> +def _get_rx_cnts(cfg, prev=None):
> +    cfg.wait_hw_stats_settle()
> +    data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
> +    data = [x for x in data if x['queue-type'] == "rx"]
> +    max_q = max([x["queue-id"] for x in data])
> +    queue_stats = [0] * (max_q + 1)
> +    for q in data:
> +        queue_stats[q["queue-id"]] = q["rx-packets"]
> +        if prev and q["queue-id"] < len(prev):
> +            queue_stats[q["queue-id"]] -= prev[q["queue-id"]]
> +    return queue_stats
> +
> +
> +def test_rss_key_indir(cfg):
> +    """
> +    Test basics like updating the main RSS key and indirection table.
> +    """
> +    if len(_get_rx_cnts(cfg)) < 2:
> +        KsftSkipEx("Device has only one queue (or doesn't support queue stats)")

I'm not sure, is this admin-correctible configuration issue? It looks
like this and some others should rather be XFAIL.

> +    data = get_rss(cfg)
> +    want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
> +    for k in want_keys:
> +        if k not in data:
> +            raise KsftFailEx("ethtool results missing key: " + k)
> +        if not data[k]:
> +            raise KsftFailEx(f"ethtool results empty for '{k}': {data[k]}")
> +
> +    key_len = len(data['rss-hash-key'])
> +
> +    # Set the key
> +    key = _rss_key_rand(key_len)
> +    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
> +
> +    data = get_rss(cfg)
> +    ksft_eq(key, data['rss-hash-key'])
> +
> +    # Set the indirection table
> +    ethtool(f"-X {cfg.ifname} equal 2")
> +    data = get_rss(cfg)
> +    ksft_eq(0, min(data['rss-indirection-table']))
> +    ksft_eq(1, max(data['rss-indirection-table']))
> +
> +    # Check we only get traffic on the first 2 queues
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +    # 2 queues, 20k packets, must be at least 5k per queue
> +    ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts))
> +    ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts))
> +    # The other queues should be unused
> +    ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
> +
> +    # Restore, and check traffic gets spread again
> +    ethtool(f"-X {cfg.ifname} default")
> +
> +    cnts = _get_rx_cnts(cfg)
> +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +    cnts = _get_rx_cnts(cfg, prev=cnts)
> +    # First two queues get less traffic than all the rest
> +    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))

Now that you added ksft_lt, this can be made to actually match the comment:

    ksft_lt(sum(cnts[:2]), sum(cnts[2:]), "traffic distributed: " + str(cnts))

> +
> +
> +def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
> +    """
> +    Test separating traffic into RSS contexts.
> +    The queues will be allocated 2 for each context:
> +     ctx0  ctx1  ctx2  ctx3
> +    [0 1] [2 3] [4 5] [6 7] ...
> +    """
> +
> +    require_ntuple(cfg)
> +
> +    requested_ctx_cnt = ctx_cnt
> +
> +    # Try to allocate more queues when necessary
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt >= 2 + 2 * ctx_cnt:
> +        qcnt = None
> +    else:
> +        try:
> +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
> +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ntuple = []
> +    ctx_id = []
> +    ports = []
> +    try:
> +        # Use queues 0 and 1 for normal traffic
> +        ethtool(f"-X {cfg.ifname} equal 2")
> +
> +        for i in range(ctx_cnt):
> +            want_cfg = f"start {2 + i * 2} equal 2"
> +            create_cfg = want_cfg if create_with_cfg else ""
> +
> +            try:
> +                ctx_id.append(ethtool_create(cfg, "-X", f"context new {create_cfg}"))
> +            except CmdExitFailure:
> +                # try to carry on and skip at the end
> +                if i == 0:
> +                    raise
> +                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
> +                ctx_cnt = i
> +                break
> +
> +            if not create_with_cfg:
> +                ethtool(f"-X {cfg.ifname} context {ctx_id[i]} {want_cfg}")
> +
> +            # Sanity check the context we just created
> +            data = get_rss(cfg, ctx_id[i])
> +            ksft_eq(min(data['rss-indirection-table']), 2 + i * 2, "Unexpected context cfg: " + str(data))
> +            ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
> +
> +            ports.append(rand_port())
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
> +            ntuple.append(ethtool_create(cfg, "-N", flow))
> +
> +        for i in range(ctx_cnt):
> +            cnts = _get_rx_cnts(cfg)
> +            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
> +            cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
> +            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
> +            ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
> +    finally:
> +        for nid in ntuple:
> +            ethtool(f"-N {cfg.ifname} delete {nid}")
> +        for cid in ctx_id:
> +            ethtool(f"-X {cfg.ifname} context {cid} delete")
> +        ethtool(f"-X {cfg.ifname} default")
> +        if qcnt:
> +            ethtool(f"-L {cfg.ifname} combined {qcnt}")
> +
> +    if requested_ctx_cnt != ctx_cnt:
> +        raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
> +
> +
> +def test_rss_context4(cfg):
> +    test_rss_context(cfg, 4)
> +
> +
> +def test_rss_context32(cfg):
> +    test_rss_context(cfg, 32)
> +
> +
> +def test_rss_context4_create_with_cfg(cfg):
> +    test_rss_context(cfg, 4, create_with_cfg=True)
> +
> +
> +def test_rss_context_out_of_order(cfg, ctx_cnt=4):
> +    """
> +    Test separating traffic into RSS contexts.
> +    Contexts are removed in semi-random order, and steering re-tested
> +    to make sure removal doesn't break steering to surviving contexts.
> +    Test requires 3 contexts to work.
> +    """
> +
> +    require_ntuple(cfg)
> +
> +    requested_ctx_cnt = ctx_cnt
> +
> +    # Try to allocate more queues when necessary
> +    qcnt = len(_get_rx_cnts(cfg))
> +    if qcnt >= 2 + 2 * ctx_cnt:
> +        qcnt = None
> +    else:
> +        try:
> +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
> +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")

There are variations on this in each of the three tests. It would make
sense to extract to a helper, or perhaps even write as a context
manager. Untested:

class require_contexts:
    def __init__(self, cfg, count):
        self._cfg = cfg
        self._count = count
        self._qcnt = None

    def __enter__(self):
        qcnt = len(_get_rx_cnts(self._cfg))
        if qcnt >= self._count:
            return
        try:
            ksft_pr(f"Increasing queue count {qcnt} -> {self._count}")
            ethtool(f"-L {self._cfg.ifname} combined {self._count}")
            self._qcnt = qcnt
        except:
            raise KsftSkipEx("Not enough queues for the test")

    def __exit__(self, exc_type, exc_value, traceback):
        if self._qcnt is not None:
            ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")

Then:

    with require_contexts(cfg, 2 + 2 * ctx_cnt):
        ...

> +
> +    removed = [False] * ctx_cnt
> +    ntuple = []
> +    ctx_id = []
> +    ports = []
> +
> +    def remove_ctx(idx):
> +        ethtool(f"-N {cfg.ifname} delete {ntuple[idx]}")
> +        del ntuple[idx]
> +        ethtool(f"-X {cfg.ifname} context {ctx_id[idx]} delete")
> +        del ctx_id[idx]
> +        removed[idx] = True
> +
> +    def check_traffic():
> +        for i in range(ctx_cnt):
> +            cnts = _get_rx_cnts(cfg)
> +            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
> +            cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +            if not removed[i]:
> +                ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
> +                ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
> +                ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
> +            else:
> +                ksft_ge(sum(cnts[ :2]), 20000, "traffic on main context:" + str(cnts))
> +                ksft_eq(sum(cnts[2: ]),     0, "traffic on other contexts: " + str(cnts))
> +
> +    try:
> +        # Use queues 0 and 1 for normal traffic
> +        ethtool(f"-X {cfg.ifname} equal 2")
> +
> +        for i in range(ctx_cnt):
> +            ctx_id.append(ethtool_create(cfg, "-X", f"context new start {2 + i * 2} equal 2"))
> +
> +            ports.append(rand_port())
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
> +            ntuple.append(ethtool_create(cfg, "-N", flow))
> +
> +        check_traffic()
> +
> +        # Remove middle context
> +        remove_ctx(ctx_cnt // 2)
> +        check_traffic()
> +
> +        # Remove first context
> +        remove_ctx(0)
> +        check_traffic()
> +
> +        # Remove last context
> +        remove_ctx(-1)
> +        check_traffic()

I feel like this works by luck, the removed[] indices are straight,
whereas the ntuple[] and ctx_id[] ones shift around as elements are
removed from the array. I don't mind terribly much, it's not very likely
that somebody adds more legs into this test, but IMHO it would be
cleaner instead of deleting, to replace the deleted element with a None.
And then deleted[] is not even needed. (But then the loops below need an
extra condition.)

> +
> +    finally:
> +        for nid in ntuple:
> +            ethtool(f"-N {cfg.ifname} delete {nid}")
> +        for cid in ctx_id:
> +            ethtool(f"-X {cfg.ifname} context {cid} delete")
> +        ethtool(f"-X {cfg.ifname} default")
> +        if qcnt:
> +            ethtool(f"-L {cfg.ifname} combined {qcnt}")
> +
> +    if requested_ctx_cnt != ctx_cnt:
> +        raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
> +
> +
> +def test_rss_context_overlap(cfg, other_ctx=0):
> +    """
> +    Test contexts overlapping with each other.
> +    Use 4 queues for the main context, but only queues 2 and 3 for context 1.
> +    """
> +
> +    require_ntuple(cfg)
> +
> +    queue_cnt = len(_get_rx_cnts(cfg))
> +    if queue_cnt >= 4:
> +        queue_cnt = None
> +    else:
> +        try:
> +            ksft_pr(f"Increasing queue count {queue_cnt} -> 4")
> +            ethtool(f"-L {cfg.ifname} combined 4")
> +        except:
> +            raise KsftSkipEx("Not enough queues for the test")
> +
> +    ctx_id = None
> +    ntuple = None
> +    if other_ctx == 0:
> +        ethtool(f"-X {cfg.ifname} equal 4")
> +    else:
> +        other_ctx = ethtool_create(cfg, "-X", "context new")
> +        ethtool(f"-X {cfg.ifname} context {other_ctx} equal 4")
> +
> +    try:
> +        ctx_id = ethtool_create(cfg, "-X", "context new")
> +        ethtool(f"-X {cfg.ifname} context {ctx_id} start 2 equal 2")
> +
> +        port = rand_port()
> +        if other_ctx:
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
> +            ntuple = ethtool_create(cfg, "-N", flow)
> +
> +        # Test the main context
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +        ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
> +        ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
> +        ksft_ge(sum(cnts[2:4]),  7000, "traffic on main context (2/2): " + str(cnts))
> +        if other_ctx == 0:
> +            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
> +
> +        # Now create a rule for context 1 and make sure traffic goes to a subset
> +        if other_ctx:
> +            ethtool(f"-N {cfg.ifname} delete {ntuple}")
> +            ntuple = None
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +        ntuple = ethtool_create(cfg, "-N", flow)
> +
> +        cnts = _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
> +        cnts = _get_rx_cnts(cfg, prev=cnts)
> +
> +        ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
> +        ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
> +        if other_ctx == 0:
> +            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
> +    finally:
> +        if ntuple is not None:
> +            ethtool(f"-N {cfg.ifname} delete {ntuple}")
> +        if ctx_id:
> +            ethtool(f"-X {cfg.ifname} context {ctx_id} delete")
> +        if other_ctx == 0:
> +            ethtool(f"-X {cfg.ifname} default")
> +        else:
> +            ethtool(f"-X {cfg.ifname} context {other_ctx} delete")
> +        if queue_cnt:
> +            ethtool(f"-L {cfg.ifname} combined {queue_cnt}")
> +
> +
> +def test_rss_context_overlap2(cfg):
> +    test_rss_context_overlap(cfg, True)
> +
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.netdevnl = NetdevFamily()
> +
> +        ksft_run([test_rss_key_indir,
> +                  test_rss_context, test_rss_context4, test_rss_context32,
> +                  test_rss_context_overlap, test_rss_context_overlap2,
> +                  test_rss_context_out_of_order, test_rss_context4_create_with_cfg],
> +                 args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index 31f82f1e32c1..0f40a13926d0 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -5,13 +5,14 @@ import time
>  from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>  
>  class GenerateTraffic:
> -    def __init__(self, env):
> +    def __init__(self, env, port=None):
>          env.require_cmd("iperf3", remote=True)
>  
>          self.env = env
>  
> -        port = rand_port()
> -        self._iperf_server = cmd(f"iperf3 -s -p {port}", background=True)
> +        if port is None:
> +            port = rand_port()
> +        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
>          wait_port_listen(port)
>          time.sleep(0.1)
>          self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 4769b4eb1ea1..45ffe277d94a 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
>          _fail("Check failed", a, "<", b, comment)
>  
>  
> +def ksft_lt(a, b, comment=""):
> +    if a >= b:
> +        _fail("Check failed", a, ">", b, comment)
> +
> +
>  class ksft_raises:
>      def __init__(self, expected_type):
>          self.exception = None
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 11dbdd3b7612..231e4a2f0252 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -8,6 +8,10 @@ import subprocess
>  import time
>  
>  
> +class CmdExitFailure(Exception):
> +    pass
> +
> +
>  class cmd:
>      def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
>          if ns:
> @@ -42,8 +46,8 @@ import time
>          if self.proc.returncode != 0 and fail:
>              if len(stderr) > 0 and stderr[-1] == "\n":
>                  stderr = stderr[:-1]
> -            raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
> -                            (self.proc.args, stdout, stderr))
> +            raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
> +                                 (self.proc.args, stdout, stderr))
>  
>  
>  class bkg(cmd):


