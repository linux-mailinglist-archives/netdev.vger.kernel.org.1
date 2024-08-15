Return-Path: <netdev+bounces-118855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A995342A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C659A28A160
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691B19DF5F;
	Thu, 15 Aug 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YE3nmUeb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD41A01D4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731780; cv=fail; b=pymptc27BISxJ8aexi5BkJtCrvz1u0EK0/ML6ku9npSz6Aovym0QE7Mfmoorjre7cBkd5XOoWfglItm/IMAIDfRSAZdnsqxIfxeXo6O/vQO4svI0cKs84ESiKO2Jsv6Gp6f0kR5CfMfpSf0ACv4w0ZLe/U7krj4JOhOY5DLSdi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731780; c=relaxed/simple;
	bh=tzh0imAeeyRCEN3YA5e1b3Vxew8xf55J78s0svMFEgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgAZbYGZcrt+iHXR+p0+QoMTrQEhpdeKZmbozfGLqtAvbfR+T8y7Wq/XU3LRfsOvAeskgGjvJCD4qPL08s8wPSfvg+jn7QCRES6J2DEelA7OQQUp51xNUfuOqEwLr3fejqEYWacND1SBW4OojBu2cbmwshNO9qC5wA0mCPac7PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YE3nmUeb; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBAUrP3NAM9yiHSMhTbNm/Ww28vMVEX0OV+oFDMdDVHqBuvbSBMhSMEeOtlqL4RYjs4rTHUqWseSaY1aUPgY1LvegMP6zGaD8DjGjQ3jEQc1PlpstP6eEX2iHKIyr4DhAXpBqVRTZAcZRs3Gz0BnpBtax2H9r4A4SLykNJaSMpyEaNH91KVdEmGysSHWzNds+OvHEyY6vF35L+bahg+7ldyaJoHW6X/DmaYjKDedbAuEAIbrq8oqH7AHb0+TCVhRYZNtBnIN2jxZPkYTG76jxZRibLK8B+Iil61rsSTfIUEpJzzjxu93Whcx6pWQrYQG+c6L72G3dk1r66Z/oOS+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTTxsQqBihZXw1FFPvdCmz4uiTZsXliurNPBZ6agwBI=;
 b=PAxlvcOudlgcdFzv2ep6Qp3KCJBaaEJLBAUQ5v0+D1CxXqj5KN1mwKrFSf0G68DETI3tsFajjlwvzGlilLSPEEqzH+0bbQ1Wh6BZnuSYNlL6G4kKpmA1tkUzzkjkFuzcwj2vr5WGPi4xmxZblEN/HrIqbNvLglRPtNpK6612xJVzkEW2aE1c2CXxn3lSn6d8rhUb4+gRjwn/iQw/IU75wnr92QY19+bBU85xr8v7/DQaj2mS2UT3nWcxIugIsV+UB6EFPt669aUIArYn9LSzjOq9pjQd2yqbNr7Tesg6dSMLoOUkN9LV/7D23w8on1k0k6RzsOItsSPZVbSbK/fxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTTxsQqBihZXw1FFPvdCmz4uiTZsXliurNPBZ6agwBI=;
 b=YE3nmUebicTKc1RFa7N2WXqIyGn3viBj4jE0hZhH3s+95nDrcsQeBKzl/rG/VLgu0tT+/XcqbYvokowr4qmocK+mHN9b8cUpEtdtk53vtiElZRBLxiJb8jG0clacncTwaB+Vnwg65FVkxC4KT3cCALFDBdSQzbJ9Tzc3o4ksekySATJvnN+23AUD2/ocTKGL5EpD3lhXOvGIgrON4IKNi07EccWZWfGuAFhiP6uLNShpb/XdwVuRMOx10xcX1hgvjszVtp6Br0RXOMeucuPFKuBacVvb9OSXDibaQUa3IP+2VrXJAQ1HvujsYbV5nJI9pSeMa6wq+XQRUuAJn/oZ0w==
Received: from SN6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:805:66::46)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 14:22:52 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::74) by SN6PR08CA0033.outlook.office365.com
 (2603:10b6:805:66::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 14:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 14:22:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 07:22:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V4 0/3] Fixes for IPsec over bonding
Date: Thu, 15 Aug 2024 17:21:00 +0300
Message-ID: <20240815142103.2253886-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: b537adba-2e64-49c5-a445-08dcbd35bede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZO1wrJ4VlTCQl43uwqEjOy1eYUdQqlO6/8YuwbFg6w/TYtmcG2zkLq/Y3JY?=
 =?us-ascii?Q?S4O72+sjHtZqWhTfZf5Z6i2PbmynK7a3/FWpKEcsHqKCKl8CvWQ81YYNRosP?=
 =?us-ascii?Q?z3CdV9s2BudJaUORjMv8bmtcbxxzwYbico7eTaPNnbdIrWjn/t77/JLnMHDE?=
 =?us-ascii?Q?WIaKh7ugIFU3xfSFSzdiZL7t7ZpJa1IHAK0URJd41AoaUxNpdliQnT+zMmzS?=
 =?us-ascii?Q?0tX2YtYKiAFuqG6RkbFVB8kfuJC9BsNX0FRz1Bcu40SKCy8v/uR7qskfbHUj?=
 =?us-ascii?Q?/lzV0qD0T4juCqUh1mhB1MgAL1/+1z4G+i+OSWDBnZghRwJH9w/MOrkVHler?=
 =?us-ascii?Q?p8ocJJFNajg63MJbAbPLBpksec7YTZSXQFKYwb7o1MkTJOgeXd3GlnDESTvx?=
 =?us-ascii?Q?3yg8YrbcdyXQQZYkCYjIzAqVWbGd/vlaSz3oSx9r2IHQUkQ3oZAK8CzhffCf?=
 =?us-ascii?Q?ATGHlkZOiD/ohdgjpF+16+diHZDY8XP8UfpjEqGAMUWdviWLgzNx4G8omE3U?=
 =?us-ascii?Q?+tDHAKYwDqyDUlVe0xadjx0x0StzMQtVojktAuypgDLNXpZmMQY5njULu/JR?=
 =?us-ascii?Q?cjsx2BmX0+DKGqa32Mu4D9sVnQOYrZfwXeaLx2oLm3yjwXgfnZ7xum7rHRNM?=
 =?us-ascii?Q?BD/IjkVqBrx0xkJIfcHKiNkQDvA5ba9tdvGxLBSkAHb48RMrBQ/IE+K+WI7A?=
 =?us-ascii?Q?fH8tZ371n6PrhR7te8rPa9z+BBJgtCTwOMXclKrhYfjMMw2H1I4r02+Ga8LO?=
 =?us-ascii?Q?rkrJdybnLm2K/lOhdsNe7RXSC7lYjLDf8DuyvpZ1TT2c6Jobm3Jq8dbHg/mN?=
 =?us-ascii?Q?a/seT5lR8IvnaJD6tIjujDK6AGTXg74RpcAYmt1/y8vCGhD375w91jqc6++C?=
 =?us-ascii?Q?Ak5UFyB6Az7G4qhdzxrh7ngxzpoO06hX+tCFyMo68tyNXvB8sUtsBvkGHW4E?=
 =?us-ascii?Q?+0Gre5gNlqJkqusj0xT7dXn0tiCdzpOrcCCmlkchjmwMIU/nhcb5amB8OmbK?=
 =?us-ascii?Q?XcQi3Hj4I5ue+8P9Ow0aZHkFnTEbEl7RrjVyUUu0LOLFJcPbHNU1HKJlEZv1?=
 =?us-ascii?Q?gNAYeTVu3CoV8aOm6f3pWBshOK8Uymc/0OcWFKbYD8g0Zy4HxjDlUbaeQ4x0?=
 =?us-ascii?Q?Tu+r0rhdjFf8Qj5D0X4xiCFh5EypfiOkF7CqFMrfR8ZYrmstVyI5LR0y79sM?=
 =?us-ascii?Q?bqaFZiLflFMVROfvLbHEPG3oM3jRVLn0acpD8EecZq0vBojJaNB2875MO9/E?=
 =?us-ascii?Q?hni8ncWGKH/9n76DiXSyyiigljrJ4F5mKwsQD3J0d+LqPVgA6BYxOtLdQ0Ox?=
 =?us-ascii?Q?wQieHlInx1R9PdszVh1oSUXTlC82ZS1AuCAOr7RCdyhjyuDncuU/ghGXqEDF?=
 =?us-ascii?Q?W2SyBhAQRMfurF3JMTbkljOSwYJ1tzgR8zhZuluH6/mNUSzOFztIgcNeHFqC?=
 =?us-ascii?Q?v6wsCged/jcsEOFy2+wPVbM/JZfC4kTr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:22:51.1227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b537adba-2e64-49c5-a445-08dcbd35bede
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

Hi,

This patchset by Jianbo provides bug fixes for IPsec over bonding
driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit 9c5af2d7dfe1 ("Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf")

Regards,
Tariq

V4:
- Add to all patches: Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>.
- Update commit message in patch 1 (Jakub).

V3:
- Add RCU read lock/unlock for bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.

V2:
- Rebased on top of latest net branch.
- Squashed patch #2 into #1 per Hangbin comment.
- Addressed Hangbin's comments.
- Patch #3 (was #4): Addressed comments by Paolo.

Jianbo Liu (3):
  bonding: implement xdo_dev_state_free and call it after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 151 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +-
 2 files changed, 98 insertions(+), 55 deletions(-)

-- 
2.44.0


