Return-Path: <netdev+bounces-93358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF18BB4C6
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0768286A71
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69352158DC5;
	Fri,  3 May 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sx9P45Zf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE51EEFC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767908; cv=fail; b=TVqkAavEdntMJgNJy5IaNSAzZFHTa+jga7gHRIg+shYxzq4G6OnVw4Temt4RcfggQuJVfibx8zZ4uiT7pPVwFNrYQc/5YIui6ydOlIP+egOVUXt8O1kgJ/GB0NEvijtnBtO5OdwzEe64SxbTztUtzN83Ar8nBj0PYwP7ViOpMf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767908; c=relaxed/simple;
	bh=Td13prUgvz4xAv3msocCacOrfW4AjkpHqUT34Fc+dsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XjoZjpANEB5gQ00s7I1+NNsS4NyUtBp3oHz0ogbJJqiD0LHZYZjHR3zc0y9pRkTc+tmTSXyL+3A3UJZFLtZnv1G7FmTgk/AqKKs8bbDml/l0urPmfqAy6ACyEZzVJydOdlTo6KFfTARPB7d3vstRFc78aSALnn2apCjVfVniLI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sx9P45Zf; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1bYTK0O1X5Vk2CwUXu/7/8KU2Mg3KwZ9BlTVSIo5JhndLU4bGna01QCSJqyAPTFjF6azENDCokitPk0iojWRF1XQ1KHX/6V/VKLk27og4c9t4v3iQyWdZqbJ44QjN1vF11+cbfpKW0roD8l6D+EsDjPMkXG6T/6dKHYc0biwlthRJ565wezKkY4UEcZcyVzy6aIAksq0p/wSigWPj2D03RS1jzXjvpd0qOct0R2rProvX8C+AKwOzBlwF2xBg7zE5CpR/Y4FM72tWNk3DEas96vPH0nM7mAzDlwzBjdkaKmGyHf8OB0PcPxiikJ7mRvStVPhcUl2qdvwffdiNrOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPAXneJIsX3eibgPdEx2iyuROh539260PsrnkSwUwyU=;
 b=Glx1dLfq6ttFZav5qnkez3ZPDQ7BbTtYj7aZSCh6Lw3zAq5u4GSf2X6XlZXfBLtTTqGy9b0u8PiJAuJEypXODWsFLl7Z+3w5W/sqWRjk/0DbClCXRKw7+Kq22s4IrRnJjPEp5OCKO0/AUtiAyGQFj5IcMzZtU1fXQJ7RFTAmSp5sy3tcwjYkHyQUQw6Hb17Rh9KQy8uIX0jfCTrwHZ1Sl6RbxXxRiQzK4L4y2TKC24MAZZ0IhV3XEV85XDfXO4ZNDLwtTgDtJxwqpE3zppLt+VBJ17PB5v7E59ywV8gci+RLI0RUYoaFeGbUcxKraUV1uilej6UgkxSMCfhTCIYHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPAXneJIsX3eibgPdEx2iyuROh539260PsrnkSwUwyU=;
 b=Sx9P45ZfJOqyb7A4FN8fslhXvNHb57QJLTra1x0ZSDVD4JHs8ohNmfS6h+7SQ5tYRdKfjX8lX+4fg6yY9a96A2Rh4r2t4xpbMHSVbtGzUgrLbiW/LjPd/EidfUTPYINfaqGZhVdVwSOp5k0Iw0R5p6EQwB4UArlSMW4lJD+M7f3JDdNaxOUvQvjv69S9+gy/vCDDHTilu3NG7RFRCDfUou30FYREPmFg+lZwYVoDPLuWiEznaTyncOkPv5CKOvbsRohc6GXxb05XJ6f8jix1ENkDn02CBHR1UTpdOgSMcnjFYA5GQuSy8slXEfOmrhc+iKD08CbsRZANDh9svM3f0A==
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 20:25:03 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::d2) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34 via Frontend
 Transport; Fri, 3 May 2024 20:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:49 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:49 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 0/6] Remove RTNL lock protection of CVQ
Date: Fri, 3 May 2024 23:24:39 +0300
Message-ID: <20240503202445.1415560-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 9addbea6-be2b-4b67-d650-08dc6baf1d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mj3dH1XyXYhRAoeSCCxsHgRG/k7H81+1EIjhqTHwKs1TwkT2zp141x39g6F2?=
 =?us-ascii?Q?c8z5eb1tDlT7rWpL3SERj8pXDtQ9JkbKNpgXrUpR4ftzPta13A1VALJMg/G8?=
 =?us-ascii?Q?yg4YhQAQO4m+1BAbZVdRQbPyfIC2oxHPtQxYfBimPPGR1jJ2I0RFQE2I2BL3?=
 =?us-ascii?Q?m1HGXG+e04B6i4mw3+ji5xqHhSntCzLdGIhzMN0RVGrr8iFYKt3fsrB6YMrN?=
 =?us-ascii?Q?gW750esE9ZRNdIU7mOnO0LLwxziMXsf6g5dA4CfsQgrhmvNTwsqbSw/3tPG+?=
 =?us-ascii?Q?ThRPi+d3ahDeXAfUjLXJrrS7LZomjXcys3XLYySrWyefq1+sy+LUGTxQ/A5z?=
 =?us-ascii?Q?rYp160rFjPxY71WDNVja1v7ke1G3cQfuIR2fACzf4doMbY7foBz6+lVEG/pi?=
 =?us-ascii?Q?MEb+znYObRVGzpZJMpv5O5Q/OI/PmZnKircNCQjbPgHeuyGEq4i5yNcUK0Sx?=
 =?us-ascii?Q?HbWwLrHX9XvwP/hkf/4wUxSbTAuTFDTJ9ew1NI7UdQTfBvnBk6R5WfJ1AOJa?=
 =?us-ascii?Q?VexKSFQESdxoTaQBMtSyByN2i3DWsudQJ4CtZTvi9ZaH5PpoU3fWuApvMV4r?=
 =?us-ascii?Q?LI197+fdkSM8MyfyQzqrSOmvcQVkgBIdD1P3GDYeYNAt/q1pd+cVvQ3l9+Y5?=
 =?us-ascii?Q?fs/BB9lsd4Kx+dOsi/O6gIIR+Cxqp2OW3vqulFYqtu4D5FMKAbW/Ny6TsZAZ?=
 =?us-ascii?Q?Mpf9dl+DJbI8yaWvvIhG00CfEyrLwgX6Z2WcbawnOHBFryhs/2ilTspT1I2P?=
 =?us-ascii?Q?pi/c6uUvMnTWp4vOdkCqrsbSfMbW4MIDA6gyg557nX0qwF1JaKkdrAf+DT1Z?=
 =?us-ascii?Q?lpfEKoYbSZK5lgG+/7sjS8cEXd9RbMJ5TBX2IJGD2EmqLN3cK85yjLNbQKG4?=
 =?us-ascii?Q?weqmgWbDcsTzLqQfbjkM+tTqx1peu51VfjtCKJwKa7wJ5X2HWUZnD+3BbF/n?=
 =?us-ascii?Q?TAsHkOa//KD6t/br7Y4olqASApQveFy7K7AUWxWjnYWmx5WMQG1TftVT/MkK?=
 =?us-ascii?Q?eF+PDnXK2WNvAkB/k/VCm+q6EpuEevue270mt3YkYZ1cOy1thaDkK4tsY2VZ?=
 =?us-ascii?Q?hBBtTW1Rv2wnL8OsoSw5JsLZOn/akp/kZjiD7/NZ4GqZqKhRnA1dwpM145Zh?=
 =?us-ascii?Q?IyJCbzjO2YvX3cjXkmlfyU1jnZaOZI/0v3DTG3uVmyFF1JaDW9nFXkR46fai?=
 =?us-ascii?Q?4XkvwQUKqPOyVsfxt+KwVjajtnLIKJ+kgEy10x+gewttF3wBJ0PaEkf4F0mA?=
 =?us-ascii?Q?948wLBL6TG3CZ5B6pPZmZYH3Sp5PpMqTQbc86B7Ifb0EGf4THEcsr/fmiGIf?=
 =?us-ascii?Q?Rf7w1Jh4NGopbwHwHvSBeVfm2sXETJVZ3T0FRSF0+hO0liP+lRpcEchOjsZs?=
 =?us-ascii?Q?+EZLv0FPPip682qKmjFzLySQzRHD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:03.3002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9addbea6-be2b-4b67-d650-08dc6baf1d3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control VQ
was only used during device setup and user interaction. With the recent
addition of dynamic interrupt moderation the control VQ may be used
frequently during normal operation.

This series removes the RNTL lock dependency by introducing a mutex
to protect the control buffer and writing SGs to the control VQ.

v6:
	- Rebased over new stats code.
	- Added comment to cvq_lock, init the mutex unconditionally,
	  and replaced some duplicate code with a goto.
	- Fixed minor grammer errors, checkpatch warnings, and clarified
	  a comment.
v5:
	- Changed cvq_lock to a mutex.
	- Changed dim_lock to mutex, because it's held taking
	  the cvq_lock.
	- Use spin/mutex_lock/unlock vs guard macros.
v4:
	- Protect dim_enabled with same lock as well intr_coal.
	- Rename intr_coal_lock to dim_lock.
	- Remove some scoped_guard where the error path doesn't
	  have to be in the lock.
v3:
	- Changed type of _offloads to __virtio16 to fix static
	  analysis warning.
	- Moved a misplaced hunk to the correct patch.
v2:
	- New patch to only process the provided queue in
	  virtnet_dim_work
	- New patch to lock per queue rx coalescing structure.

Daniel Jurgens (6):
  virtio_net: Store RSS setting in virtnet_info
  virtio_net: Remove command data from control_buf
  virtio_net: Add a lock for the command VQ.
  virtio_net: Do DIM update for specified queue only
  virtio_net: Add a lock for per queue RX coalesce
  virtio_net: Remove rtnl lock protection of command buffers

 drivers/net/virtio_net.c | 288 +++++++++++++++++++++++----------------
 1 file changed, 173 insertions(+), 115 deletions(-)

-- 
2.44.0


