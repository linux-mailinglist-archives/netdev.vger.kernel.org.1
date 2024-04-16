Return-Path: <netdev+bounces-88451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393B8A74B4
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53DCB216A3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82971138493;
	Tue, 16 Apr 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mc+XO0+J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB6137C59
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295876; cv=fail; b=mRhIRqZu2iztJm0rNvM+4tUvDGJSNhZr1Aa/jXOX3wCU7sP7Rg1y6oF9bLRBVTjrco2ScPW+hnuB8Z/rdbHoSboAzpw5UqfzTvRV+el6u7Avwl8m9nppzZmw4usWFXmmuMeRCgVF2zTvk1jPvgatIMuoKr04J7eJIH0xM6aSpTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295876; c=relaxed/simple;
	bh=7bNkLVZJxB+nZOlnjbMTmjxQEOICsVu7KotIEAI4bL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhMdad7XFIT3ahrwLyD/kQgWpgLhYH26k1+sJU8Aca3qpGVpThoS5kvo/00uUGH4dGxx/JqAJu6+2lNluDtML4/knzVArHFOYbAU/4PDoKCM6TmIJ2YHVEpX9tHFPfyzMs8RW1ePz89F4Xzx88gbc0IT2y4kPNyf5OZDvasKedQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mc+XO0+J; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKOHMN+LNuY4bh+RJCpNZMYam1W2yavpwvAyORc2XV2pFBztBJTBZhZM0b+oYDWKMRHdpl2z/KoeF1MXb9VFfSK2XbIDlsJk39EGBW5ba3DmU3FIQ6zwDBbQ9N2hxJMtbFt5hAUtlGs9TD03bfqbEmNXQ9uZSy+vXd0+IgomeLG3MD3m6IcRb7m3FTsJeE08WR7rUp+GNJJAztgkDsuRNxM354h5eR/mFalIXIw9yRDYDI8hOeSeqPFCdF47x2KxYRAJeHu/k6w+KuTWzbcSKHNnHtetc5lv/kJuGjXHUjRa2vaHMZiMrMJ85Lbm6UyqXgT+ihwlgVuVr/42WvKqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCoe4hJzGxTHgjHI7D4TDyk7E6y3cCrHPSPePwdCHXA=;
 b=RZsll/IosWIjGE46hr5VXnpvnmI4zGnLM+ElNI+AAKSO/kG69cTkmlUiq8VVYDpjd/NTSnT1k6abNYCasKYERS1bGoXjraQoj44KH0szBN3WzeAEHE3F6zSrPrOVuk6w6GaOmW9TtCCEVzRc8dJb/E/usPFCcclx7e345gGFMTqh8YW11Rz9YFKVZr8fdHc0Iij2CfSoqvSzW4jwhJrg4CE3c9vnx4N2s3F1cg2a9EuuI+rkUsQiCEUUjmt89nl3UTNMEvthZmtfbJv858Bx6Bokumbnex02bRt93XVhCY6FhFOZ+d6fNIH10G2jXCvF6w+OKeTga0JToaDPerucTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCoe4hJzGxTHgjHI7D4TDyk7E6y3cCrHPSPePwdCHXA=;
 b=mc+XO0+JRGBe7FNePsd+ZfcUath5V3/6LH+IYYlWdAhE8pE57GLs6GSnEv3zgFPSYYocxlQxdnx7bfC9XZHFs1ZOKbmfg0wLZ3Me28Y/y1gqHXw5jE6QGwcEhYo61e3YGx7FvH0SU3FHp8C2h/nTZhDFVfuGwRHDFBaWQR3fPyZv0IolQkK9OStekHDZ7CSdVkHLkHNHMnfZclj9kPE+oEUG0jTpb0IW3PV+DfEpkEhzUbSh/w5mP6/YsFu+EpgntnnpJ1DP9dTWLi+CCR1citP7kHhX1p1uu9dsofnd40rOAY91BRZlcpwq+0GRT+SnqH8Rx5dAZgXA4d8Jd3xchQ==
Received: from BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) by DM6PR12MB4091.namprd12.prod.outlook.com
 (2603:10b6:5:222::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:31:12 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::65) by BL0PR1501CA0034.outlook.office365.com
 (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:47 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:46 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 0/6] Remove RTNL lock protection of CVQ
Date: Tue, 16 Apr 2024 22:30:33 +0300
Message-ID: <20240416193039.272997-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb4a178-5e35-44f8-be7c-08dc5e4bc640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zYD6OowbxHvO2dbYjVoT3KmFB6FByNWKEPHbBMQtpgX7BY1Tw5au0oJ+lCLSYL+OiC8PsFKjeyD5DrY9KD6gOyPZz9FkmuvxSOxtU4dvSDsSjJwd4R3YuUCNuX1NEWN7Z0NIpgQzcujkTq/s+ALZjXMfk1ZucrC43H9GMl2xMB1imM+lj8Slgv+PFPGKdXUY9c8qFsry63YaEcMetOI0f89/OxyFt9Hd8JXvpFul755zRqp6YehyrKRfncX+cE2lBkSjx/8phnB/0tj/PsqDEBUemeAUAf7e/TSCZQTEmTZr9wrzfLAHblxp3tOhMxtI4zACWN/JghtbyWaDVA1vi7J46OT2y/Ldrf1KsmNtsfsAZIMYMErRj36qMXU0uXWcixKsld34z+QaWoWvtbf0edjsQmUuIgb8ULss4Elc8Ohz28yoXngh5kbRinU3e6pQgmlA5kiqrLBLcY2WeHk+9xl43FGUB7Raoi3zTp/vAkZb4rlecJcXAQ3gcMXYzJunGvvKXngDk8H2Ebnb5K7EE6zZZNTGSMFwGiq3OuI97JYfqR4w+fSmpROxFIP5WFGG5kG0AqULGjHT72VvR8+JHsTTPvnEE32qqABZL0/u6DIdCTTCIz3EdYhih9CcgepiraCIeu3s7VDYoo5reoAml4a/aGwilNpQ8T7sNe937s9Serl9GglUzoYjH+SNpAh4tNYWM6JFj9Og2NJ0DRXkCIdGFhMq31VunCO2wwxcBAZeeOcLvth6nFoOQBjXzWQz
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:11.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb4a178-5e35-44f8-be7c-08dc5e4bc640
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control
VQ was only used during device setup and user interaction. With the
recent addition of dynamic interrupt moderation the control VQ may be
used frequently during normal operation.

This series removes the RNTL lock dependency by introducing a spin lock
to protect the control buffer and writing SGs to the control VQ.

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

 drivers/net/virtio_net.c | 256 +++++++++++++++++++++++----------------
 1 file changed, 149 insertions(+), 107 deletions(-)

-- 
2.34.1


