Return-Path: <netdev+bounces-113983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC2940829
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476E7B211E0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DA14A08E;
	Tue, 30 Jul 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jm019tDM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA21854
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320307; cv=fail; b=c8n3f3yACVK69FkxaPjgL+v/xZWf713/qzjwwrR174GVr81Hc/E1RiWtpQF2ddK9bMk02WLxfaUQUFpbQYY/jHvh7AKm1frDHjQ/XzfBSlBcgq3fj+t8XB6KWND/yYgl+vybI92EyIVjZ3s/clnbQTc7GBbn0GejZPMdemF42c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320307; c=relaxed/simple;
	bh=FknaVklSiVFEQw/8yRfrr8f1Kio44n1o6kHgplaAORY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tg5ZGIfqDdKHXKmI5RTkruke9qOLqzvbdducqtjC/hYifw0/kZJYyjHfSWR1hIjLNd1FmVyXC5z7ygpTjD93AacmGXOp9fQO1XL09SHD/aI/WPtJPwFrgjWbOoBcsi2fs3s+hvFVVcc9/VI+iJ8nkoMmmYtEDYr/9bELYjk/Rik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jm019tDM; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6uh9/bZFqBRnzTOKmHO1vUOMB0u4DJrsXk/gg5RJrLH2AVOHo7pBpTsF0OLF289JCjhJbY7JOTpTFKlJ1+AOY4flU41MPmrCcK+/RO8cjkungOh6lbHLlrOv2z5mnkZdHLt1sN68cpL10XZJPikAVXTym/YKvae9DyMjqForc0x8kfE7VbbFzm34bZhtw4wqqJfR3Fgvn64VHGGB/bIVWXtm8Sih2WSVY99iUprohDMbRmQh1KtW/IENk8Jjd0OEYYit+BqhmDgES3pSplA1c+ltY5yb7T1IEzZnB6YGj2pqscUNvJBGrmtay2389E0i55akKrt8QxcbEewSFoJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5z0yKT3SqcyMBJy65SxWutMMfyx9peaiFn8hIs9dxg=;
 b=xgkCP/r7WdO0c4fymCLkimZ1wLqHwBjNbRcSur2N6W3f5c1k90ACeH0YY1xkVWnXK+FXjyK02b1qCiJ9VgyMyrh08QozMCVQJjP/nfpdbeWdFeFAf6SCghF0CsPVNdvdYcAy0051/S//hdwr0quZgRVotARzJYPWbX9Oc+Bez+R5eel2w77fs0Xo/dIWmOTUv/4Vw1qmrqWQMH2D5HDU8FuinxH1eGS00sTK7HsFCvbsEDMNsAu+Dc/mbSLMhAUav68VNcDmr4JJpoDbCS520hU87bb7POLWpBx0IEgn8jY7RQsgt1rc72MgNEk0/jhDkyk8WQDn9BlFDQD7amlm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5z0yKT3SqcyMBJy65SxWutMMfyx9peaiFn8hIs9dxg=;
 b=Jm019tDM1ewNThc6MNtVdlmgtuQ7WVO0e2uZ131mIt7dHHJ8qWTcxa+uEC2QrrGR87MQreE+XC5RnuTjQ7GYAjLeRYIdOYSmQ89NTm2olgKSq0BjazuOQkvn6WEDqQfCQicgYIdXM6YnKq/2hK1YNlEyNaO/X7umcdXr3FcGF3gieN3NOMcwjRZPusllxyVFfUQ89HLllnrOZebqtYkaEl2yyT/UyYzFbL32H11FNg9JoIcZ6eFtaB87KyXlRg3jmgRMj9vs8IZQsftui1wo2t+SQZA3+j4rJVDgzxzsCTgsMNh+BuUnDgeEdf5/M6vi7Mt+is8/GYd5EJs4AvhXww==
Received: from CH0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:610:e4::24)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:18:22 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::c3) by CH0PR03CA0199.outlook.office365.com
 (2603:10b6:610:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Tue, 30 Jul 2024 06:18:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/8] mlx5 misc fixes 2024-07-30
Date: Tue, 30 Jul 2024 09:16:29 +0300
Message-ID: <20240730061638.1831002-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fabc84-eb10-4c83-37bc-08dcb05f698c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2txWEtJKzBKQzJzZ2s0bFdlSjZnVHJrN2pkc3ozMEZuWndXRWhtMFZ4eE92?=
 =?utf-8?B?U0p0dG9rL1BmOGV1N2t0ZjFBZWU3UHQ3TS9tNUxMeG1zNnliYUFESFRDNkJG?=
 =?utf-8?B?UU45c0JkS3lxSnFOSURSZGg4YWhJK2w1QlMwdk1PTE5rUFdrTmNsOFZIUWZR?=
 =?utf-8?B?WXc3Y1ZER1hmb3pYMUIxM0RqaG0xUENVcGVkV1NraVJ3aUtFZjc1eFl6TFNm?=
 =?utf-8?B?cHgxK3FSc0VEK3ByY3NLcTA4MEpiWlRGai9XaUZmdDYzN0dxQmsvN1B3Mk1L?=
 =?utf-8?B?QXdCZ0g2UTJjZkJ1SndqUHdDaWxzcFFDR0lVSENpRkJmWFV6QzlpbXZSWm1z?=
 =?utf-8?B?YjlwVnJndHFIUDdEeWpmWG5EeCtaS1k4L1FHRGxMZjdkY3dMWDg0Q3Eya2t2?=
 =?utf-8?B?NE5sL2dLRXRMTE5oaE9jdWVEeG5iS2MxTmNETXNxOUMwRjcvQnRYN1VVdCsw?=
 =?utf-8?B?UzFFK0hDRG5JVHBJSmJRaU9YQzBHRWV0UjNzSGJYT2ZzWlFZZG5CdmRLaFF6?=
 =?utf-8?B?VjlhbHhkZkZxZ3Ruc2NsdUc1L1dRb1EwRDRxM1Y1RnJyUlFSMUdUMStKb2Qv?=
 =?utf-8?B?T1c5RmsxazgxbE5KMmg4RFJtTEk5RE5UbjhTbVBzd0s3bXlHWkw5UkdCVjg0?=
 =?utf-8?B?eTBRNElzUG5UcXQ1Z2h4bXZ2NGxjVXJ0TzZNRTdCc0ZOU0hHT1RhT0NaTnZt?=
 =?utf-8?B?U1hzTkZZNVhVNFJZakRyVXJhS1Z1bExKMTJ6Nm8wVnpkcWlxV0Z4Zm5XL0Vh?=
 =?utf-8?B?b25DSUZYYkRQOGMrTFFabmY4a01XOVZzMUZFSE1Td1JKUTYyb0M4cjdaSWZw?=
 =?utf-8?B?b24wOE82ZE5RSlR5bWt5aUNmQlZRTlE0SXhseXpJMElFaDlUbGRyeTM1SGQv?=
 =?utf-8?B?QlFLRU0rRlNLVU9hOEJjVkZCYlY3ejFIKzRqaWpROWJBRDFSK0lMT0E0ZUh5?=
 =?utf-8?B?SkZqQmhuU1UwL3ZHTFNhNm95K2tqZUhROU9kYWoyeVdkc2swWWRZbVdSK21s?=
 =?utf-8?B?TU9MMHh0Qko3YnRWS3JuNzhZa3lJcVd3cHVvTEdBd2FHWm5JL0RRVWM0N2FX?=
 =?utf-8?B?VGRCQS92QWpGa25ZL0pBdVBZZ2wzQldIaXZCenVpWWRIYWVnNzdrNXRodjB5?=
 =?utf-8?B?VU0zVG1KRWVHSlpUdWp5UWJhSjY5L3VmVFp2a2lhWlFzbXJsN0pWdXVuWTc5?=
 =?utf-8?B?Z29qdUNmbmhnWEZLL3RpMkJQbEljdGFUbTNBdlVxTnF4YmtkaFJaT2g4aTNT?=
 =?utf-8?B?R3IyOFpxd0ZnZnczYTlsa1BjcnBCKzYwdVNtRis3Rm9pWm5LVXdYSmJ2eUd4?=
 =?utf-8?B?Z0NidHdHTDd5bVRDdW9XVSs3Y0RYeVE1UVJCNE9qTWgrVXVDN24zZTF4SVF2?=
 =?utf-8?B?UmRGZm15eDdsdkVFeWtpRFl5dkE4UHVPNmY3RjNnaWhLWnd0WGhPVlp0YTRn?=
 =?utf-8?B?dEZwZWNyUEpNY0E5Mjl5SGtRWjlXekEySFg0YXdBcXdGNXkydmJ0Y1RTUFVL?=
 =?utf-8?B?Wi91V045Vi9KQWh4ZEU4TFYyb0Z0K0ZHMnRMbkZlbGVZSEVQKzFMWkxHWjVI?=
 =?utf-8?B?a2xMbEd6OHpZMUhkb3A0eEd4T0xWRW00TWVuYTN6NVJ4OVdXeGJvZ1NTWjJk?=
 =?utf-8?B?QTh2akZxK1hzbDM2cmh5V2JhYk9zUDVNRVBYNkRxbXNMKzY3cDIrYWpmSTVZ?=
 =?utf-8?B?V2FINlFtR2ZDMDJUcUtpNlNOOGt4elVlNE83TjlvS1BzRHRadGh1OVAyNXIv?=
 =?utf-8?B?RWRlUWhER3NrUHplczRINW84d0k1TlhjYWsvSWZaSmttOHhzQmRMaWtLQ2Fj?=
 =?utf-8?B?VHF5dmZ3ZkJaSEVuMnRYMHg5bDR0VWcxdm94SlgxVVdBdmVjSjduS1ZFUk9r?=
 =?utf-8?B?QXc0ak4yRUI3YnVqSURiMmFXTU4xUVRUVDczTzVFS1F4T0JhczBLMm1sTjFr?=
 =?utf-8?Q?qLuIzqsC/NT86dnFWw+ZIm6ZPskSugzs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:21.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fabc84-eb10-4c83-37bc-08dcb05f698c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Series generated against:
commit 301927d2d2eb ("Merge tag 'for-net-2024-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth")

Thanks,
Tariq.

Chris Mi (1):
  net/mlx5e: Fix CT entry update leaks of modify header context

Mark Bloch (1):
  net/mlx5: Lag, don't use the hardcoded value of the first port

Moshe Shemesh (1):
  net/mlx5: Fix missing lock on sync reset reload

Rahul Rameshbabu (1):
  net/mlx5e: Require mlx5 tc classifier action support for IPsec prio
    capability

Shahar Shitrit (1):
  net/mlx5e: Add a check for the return value from
    mlx5_port_set_eth_ptys

Shay Drory (2):
  net/mlx5: Always drain health in shutdown callback
  net/mlx5: Fix error handling in irq_pool_request_irq

Yevgeny Kliteynik (1):
  net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule

 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c     |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c        |  7 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  7 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c     |  5 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 10 +++++++---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  1 +
 .../net/ethernet/mellanox/mlx5/core/steering/dr_rule.c |  2 +-
 9 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.44.0


