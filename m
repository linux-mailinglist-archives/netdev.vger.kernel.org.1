Return-Path: <netdev+bounces-118384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2AC95170D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BC1B26E33
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F975144D21;
	Wed, 14 Aug 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfPmLvH8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5D144D0A
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625637; cv=fail; b=C4mzIpG1THpiaS4jVxJbrN2YuawEZf1DVQMC+r9pnUV8kmb0mV7LztuQNZElWzg5wLgSVDOzX5O7oD0ug+w2VbKWq5gvUdwuYyk5KygSemGqPYfkBF6G7NQc0W0xFZ7qhedU/0fWBv+FCNcMTsYb4trzjpOXiT3yNzx2H2cHx8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625637; c=relaxed/simple;
	bh=sDrYER+cHqdgfMT1UCzlTlKBNspGp+woHBMJprdBVtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEoFJ6WMkgzWqU9uFrJLBvmVOOyqfHsEkQmw4VA/C05mc/iOMQlhfy9xKvPMXqyjpsUXr2KpG7k2ALusG5hlYNtjb1dLGKwxxbZfqZTfY+g/Hp/pB57rzrT96uVf5xUKdYsTHwoWkQr3o1FAPMJb5JwIKu2+9rfbooroqFkA0BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfPmLvH8; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yITI6xhnakJDo6qfm2819TeWmG49ZC4g+kc2Ae6JHOjfvaY1VARE6ETSZCOE5V6+GL2q0b4S7cvs45LeWkHKpaiV59NXCzyZJjT9bxfhtRKT9sHjYTquqAQ0VQezzOLA51sbAxHQgL9eR+W82uimfEJdJMwQa+qk/XzjzV4tfDkv8tD61WWmZyo4JIDTR01GFXmuIlXE0rGeGvFRe/3HAla+MCus8b3eY2avn6X0ILRdZsZv+gxgT66K+kPuJlb1HWp/zo/5QywC3J+gzR5XxUeunWe3iqV4TtycgUKWu1KTvz44TYfmvN4AzHWwbQhJvMi0/im4E1pmp7h86xSE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QexZhNSAl3oDcHkX7Qz9zWFc4GcYF9spoYsI4TDAIn8=;
 b=shgZYGJ4VJ5GeofV0R3LyksHUMFd4QXlayUTzCRiDRJQWlOHD9+tF3ZaG/MopjDJ6/pUyfWZZl6fTwlvxuYxC1Q3uT7w9inTX7Li3ZN0M+w632tt0l+ch3lyCwKm1P/f4ppxR+T2Odx+IN74GGaLA4WiycKgzf6pBnka6dvGK1M01fvGg2XIdbPt77tXaUW/NVP5X3MwyB60pCvj2T4PIg4MCcJhx1NpRCrufYtkTHhKTIevkQRHOPEw1TgrAmP9R1wo0QvGt1M4ZZoxifj7MsFQt9U6ajeZhALKj1F7IwcTy1WCDcAF+vH+YhzuCMfOzhn1g250qDyvelqfQcqnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QexZhNSAl3oDcHkX7Qz9zWFc4GcYF9spoYsI4TDAIn8=;
 b=AfPmLvH8k4MYVadh4TgvCO/Lapt+YoBkQJZXNVEjK8mNORR6lKxQBIpXEaFOcpak25RsmhV98NziKu1HGlfLCOt+GPGrpVplgl/7rpZ3qQgq2Go92SXadoLtUphIHap7/xKNUU9KG/p4e19PMz235ZxMWRlIRJvF7iq5kR5Bn/y1Rm0Ez4k4Q1kAtyetDMfdgglgJA+UnH/Jt8cnsccUj0bEH6dqrksh8qzJ7+AJ46fD4FXHNu0IC7Uci5rNEVFGpMdPZ8IxKDeEWtferD1AovzjfYo1w+tr43wqs1sTpsWkkAUJ7gD21ysyf8p8NNplzlw4w66Kzm2eZoCNxx7GPw==
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 08:53:51 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::bb) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Wed, 14 Aug 2024 08:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 08:53:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 01:53:38 -0700
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 01:53:35 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <cjubran@nvidia.com>, <cratiu@nvidia.com>, <tariqt@nvidia.com>,
	<saeedm@nvidia.com>, <yossiku@nvidia.com>, <gal@nvidia.com>,
	<jiri@nvidia.com>
Subject: [RFC PATCH] devlink: Extend the devlink rate API to support DCB ETS
Date: Wed, 14 Aug 2024 11:51:45 +0300
Message-ID: <20240814085320.134075-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c8c83a-ae0b-42b3-8349-08dcbc3e9e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0JEcjZXUnRpajlyUXpEb1E0cTJiY0FpMHUrbDV0VU9ydG9YODYxV2V2RUVY?=
 =?utf-8?B?UjNsem9kTlpDSjNFU01oVWtmQ2RscUtEK2FHT3JhNTlRSjA5Qlp2UTZHVndK?=
 =?utf-8?B?ODc3bi8xc1RBTFovNmw3TGQ1MHZEcFNrTUJjRzltK2Z1UW5qMWdHM1hIbnNy?=
 =?utf-8?B?UzBkTmZucTkvR2R6c0VwL0xUSGIyZ1hHWjBiZHRWbUFNYjlXOXVCbjZ1d1Y4?=
 =?utf-8?B?RGVuR1A2SUQ5SGMzblFGbFZEckREeE1RWE1wRXdRM1hBTlFJZUJFV0hxM2gz?=
 =?utf-8?B?bVBEMU5MUHdxTzhpalFabURBM1pFcngydk1LbjBMQWpXM2pGQ2dqUXhjZ1NN?=
 =?utf-8?B?d2N6LytNNEZ1V1pSdWFrZytmV21RMkFmNGpNRmZGd3g4VW9sdUdMaStaaFVP?=
 =?utf-8?B?Y3hHaXVQZVdKcldxN0pRWGE0QzUzbG92R212a2dVYmxLM2d5YTFodzN5Z1lN?=
 =?utf-8?B?cncxY0xNcTBEZ3l1bE1ndzlpZXZkM3lyL09zbWgvc09TWFFYazBlY1VuVHU2?=
 =?utf-8?B?T01HcVN4M2s1aVk0ZzM1TEJHeXhQQXMvTnRLdEdXeGQrdE50ZkJJcDZaNjlm?=
 =?utf-8?B?d210UGpFd0pSbGt0d0N0MUYxYXN3RUhsZVVWTlNZUzFpcjRtUE5OdnpiZGRT?=
 =?utf-8?B?L2RzazUrNzZQMUN2U2VVWVdWdURSUzRnaXBmQlZKRFdUV05UQytYc25qTnFC?=
 =?utf-8?B?ZkxnT05zeFRyWkREWm9PallSS2xydGNmY3hMTXlHc3NCWUl6QmpTbStuVVJG?=
 =?utf-8?B?cUN0ell5L3VUV296aGZFSU80Wi9zZWJiU05PTmtVKzZQY1ltc3lGbk5mQmov?=
 =?utf-8?B?WkY1ODRlT0ZMK3BLVnZ1UXc3OFUwVkV5K3lsRFB0Vkp5cS9MelFja3ZGdnI2?=
 =?utf-8?B?d1lqL0IxWVdmRk5EQTA1eGs0Ni90TXZka2FuNVpYM0JldG1lS2ZGdklGMGp5?=
 =?utf-8?B?endoZFpGdXN4aDJucm01UkVGbytIYkorWFByN0dkL3NPV1FndVBiQ1B4YUwv?=
 =?utf-8?B?Q1ZwWlc1TGt5Y2lsdURyVEpSdm9RWjJ5SjhVRHlEU3ZETjcyTXlXaklmUnhz?=
 =?utf-8?B?dTJScEZaZW5QVENoT0F3Skl6SWxtbzlYRGJvRWpaLzVCS2J5NThPSzZUUnU3?=
 =?utf-8?B?YW1LWjBmSjZaVmFReUJYMlB0WFJ5THBZSlQxZ1dRTUNIemh2anJoNVdMbnF6?=
 =?utf-8?B?K2Q5U29SRU1SVzZ3S3pEWXlzQmhjUWEzQmNBaG9JaytDS2NNZk0zbXhkS1cr?=
 =?utf-8?B?eFhSd0dtbjBEWVVDZEtHd3AxTVN0MDRPUm1EYTc3bUlKVFp1a0NYM2xUNEdm?=
 =?utf-8?B?b3kydHpQeHdlbEU1OXRtVjdRc3dNRnFIZFFWZVVjQ1R4OGkzTG8xUXd6ZFRk?=
 =?utf-8?B?cmtHSFBqVEJpbnN2YUtEU1Mxck15NGY1UXhzTWFzVFZIeUdLYXhNc0MzaEZx?=
 =?utf-8?B?dlBHaTBzMURwMzNpeDdmVmdaK25WMEhTY1ZrYmZNR0ZORkkwQllTNFgwZVVS?=
 =?utf-8?B?a3dFaFo1MTlYMUF4bThYNXFnMU5pV3BjT3NjWjhOVDVwZzdvNnFtZk1qWWhS?=
 =?utf-8?B?VlBrakw2T2swaXNoQXlkUlJ3b3plK2Z5UjYvWElIdEo4QnVVQUZETm56dmJX?=
 =?utf-8?B?RW5uQWlIblBTUkVhRlVLZE1CRVpHWWNkNDNQZjJEWmEzSlBTa0dHTGg5UDRR?=
 =?utf-8?B?TG1WeUZxeDIzRUFrdFlhT1FHTXNhcGhIczByRE9lNisrUEg2a283N1IzZ0J2?=
 =?utf-8?B?QUFFWG1tYkdEaVQ5TmlhM1hpWHQ0RnhoMkh5b2IzaG03blVQVFhkNFZka2xG?=
 =?utf-8?B?RFRrQllhVlp1eThqTERaM29JRzhidHZMZUpzejY3d3ExekNVVitSSDB4L1Z2?=
 =?utf-8?B?NjlleWx4NDI4SlNhK0ViclllZFpIYzYxVzkyQ1Ezc0lwRW5od0tNclB1dy9Q?=
 =?utf-8?Q?WXJaz8CXOiKLe3pCfsfYErAfcMgXEUOK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:53:51.1381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c8c83a-ae0b-42b3-8349-08dcbc3e9e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Hi,

We have support for DCB-ETS for quite a while: mapping priorities to TC
(traffic class) and setting min-share per TC. The configuration is set on the
PF/uplink and affects all the traffic/queues including any VFs/SFs instantiated
from that PF.

We have a customer requirement to apply ETS for a group of VFs. For example,
TC0 and TC5 for TCP/UDP and RoCE, 20 / 80 respectively.

Two options we considered that didn’t meet the bar:

1. MQPRIO: the DSCP or VLAN-PCP values are set by the VM, one can use MQPRIO
qdisc from inside the VM to implement ETS, however, it is not possible to share a
qdisc across multiple net-devices.
2. TC police action: use TC filters (on the VF-representors) to classify packet
based on DSCP/PCP and apply a policer (a policer action can be shared across
multiple filters). However, this is policing and not traffic shaping (no
backpressure to the VM).

To this end, devlink-rate seems to be the most suitable interface – has support
for group of VFs. Following are two options to extend it:

1. In addition to leaf and node, expose a new type: TC.
Each VF will expose TC0 to TC7:
pci/0000:04:00.0/1/tc0
…
pci/0000:04:00.0/1/tc7

Example:
DEV=pci/0000:04:00.0
# Creating a group:
devlink port function rate add $DEV/vfs_group tx_share 10Gbit tx_max 50Gbit

# Creating two groups TC0 and TC5:
devlink port function rate add $DEV/group_tc0 tx_weight 20 parent vfs_group
devlink port function rate add $DEV/group_tc5 tx_weight 80 parent vfs_group

# Adding TCs
devlink port function rate set $DEV/1/tc0 parent group_tc0
devlink port function rate set $DEV/2/tc0 parent group_tc0

devlink port function rate set $DEV/1/tc5 parent group_tc5
devlink port function rate set $DEV/2/tc5 parent group_tc5

2. New option to specify the bandwidth proportions between the TCs:
devlink port function rate add $DEV/vfs_group \
  tx_share 10Gbit tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

All traffic (group of VFs) will be subjected to share (10), max (50) and adhere
to the specified TC weights.

Moreover, we need a mechanism to configure TC-priority mapping and selecting
the DSCP or PCP (trust state); this could be either using the existing tools
(e.g., dcb-ets/lldp) or by other means.

This patch is based on a previous attempt at extending devlink rate to support
per queue rate limiting ([1]). In that case, a different approach was chosen.
Here, we propose extending devlink rate with a new node type to represent
traffic classes, necessary because of the interactions with VF groups.

We’ll appreciate any feedback.

Cosmin.

[1] https://lore.kernel.org/netdev/20220915134239.1935604-3-michal.wilczynski@intel.com/


