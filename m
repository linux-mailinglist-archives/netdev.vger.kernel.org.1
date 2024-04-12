Return-Path: <netdev+bounces-87524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3E8A368C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386528283C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ACC1509AB;
	Fri, 12 Apr 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlX8aflI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6214F9ED
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951621; cv=fail; b=JP4aviwoWyq2AqgmtEj+Q1Z8Fu6VlbYivWn28sDd+ELMcad9JcB3Jjy+DYqvJ8kItIehPwEis9svDMWGzqFaJ3ep/uI5bjif/l9kwol7vSZstF+0P6AlXl9bf05L8cRQmbRwA0cH2IaPjVyLQkpuRfaGiSEcI3m4EmCaz44xT+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951621; c=relaxed/simple;
	bh=aGVfri7/S//5s5rn8NA3ZfuB1Cq9QS5uNJjJ5bxzhEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhuERJn3OUCVm1mHEotAZQTGQTXbfmFQAptZ8ml0YWC4jvGg9Rke8L0Pi9JcoVcHHet/7wNoqV5KusIflqv/811utt8VVUXM1cin/kpi/u2/LUFwUUYahbLNjAKiJd2R6A4xZlnIU5svMG7mM60zOLsEoIhWgTH7dxsjmL6t28Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlX8aflI; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bReiym4pA8qIrr5qzsLOrRindOz5UvsQM2cEFZpDA8XcSd2tlg9czmhgqpBdiFq66CAzyHDYuIOCT1f9hV3EfnBgveCoUlTqG7t9GSr+Bc0enICvVB21X/8yYYCmHpG2fLxfhaGKryqYshrvQyr8s8DSZ7ydwAT7bXvgWZe3Nbsx8rU797sscKo1ZVrphyYxv7J5kBbHMKKP9L1H5T46Udplut7Qvx4d0RdlUfCCg/iwi9ytjKCIrLzL9qyjP32GUWVvM37FzYpcUu06fHJM6f/ZQ7/2PpKY76ZIhXSHUxTJ8zTCVbRrm8la86uXZTHyQygKNckaMo2vQBh1qI7iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzHC/61HeFH/4s+t64cdUqczOvPHs8jV0b/8OSWwAW4=;
 b=ZuffX9t8qXWOps6zPbcux1Piihy22CbjAdk0QH780bGvBS6MqrTbTnWXq/wRMsEhRs28Iw2aXx8YtPyX+dmjF+W+ySh/geilmoit5izf57bTZevXSR7dwTCvAKput3h7dzLZhCVsstLQc+/ABpIhjPk16gDZ4QUPcoumhbHLTrLOPmcy5o9ZPwqiQw3suqBdL2eJ+zKkPWjFDmHLhRzpTFYL2uAQj/QpkmBrCWfw+S/BRQFq/7YyD0TczkCZOnqGcuHIraVyrJgeZd3qNLUgDlqmj0hkJIU/93gmvR0retszFoy+Q3p2rYjGo1zxshzcPE5MI9QDhriqLMAY5YbfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzHC/61HeFH/4s+t64cdUqczOvPHs8jV0b/8OSWwAW4=;
 b=FlX8aflIYq0+9AyYy80aykYO2cFsk1tswTUlOHCgg2/AXOREgg6kRiVH/A/3knzgXbzQOFGc3e7bh5ouYNX9+b8LH10b4I4hHrNDooLwtLSSWS8IPWU/yEo5M1SGoW7xfAAuxdvvdojJWUsf8vIsgAvPE86TU8hcP9Q4Pu1G+hHLXbrh+untF5EKeLZQtEKNSI6GpzXwP3TBTlpOqL/N/MkxdKD/pnIW6S6c2myT6hqBltW2n+fzN7XGse9ZmnNIHwPZM/01LNjZ4JRBlmLkETTWDQP9v8IgYGw15695aKPwFkKH4aXZgcRx3fkp7hmbHbp3XXRHV1izFpzJo/xOqg==
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 19:53:37 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::83) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:19 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:18 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 0/6] Remove RTNL lock protection of CVQ
Date: Fri, 12 Apr 2024 14:53:03 -0500
Message-ID: <20240412195309.737781-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf66bf2-a44c-4d76-af11-08dc5b2a3e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HdK7smH8CIDuCdm8x2Dw07PQLNRm3xx3S0m6VhE6XMv18+kkt7qesHi7NJwQ43ZbJmoiOQZdGK+IK5RkvixYCIS5Sk6gu2X/E/3vOoltf/KKaSAWTJr1j77Rvz7XTteDF46pMQ2UUlnvSV2smsGYk22PYImqCNFRiSvYi7M0SXH0B460vy8HK5d1Oq4xDfrzv79BiHzu0jLhWrIu06rBObxlBk18GyUK3r/HxWme+pqf7xf9RBP3su3EGmWYdL9mpsKvqsPRdRKVa4KWJB7vX2PkKh4jkFs38H4SVJb6z5SGuy9JSMpnK2tUMaMozjMcOn96lzB4Z5guvdmUgEx8xao2rJBeLxASMXau0lxOoYrAWrot2drhC7UAkWwKqAypOYjBdj20xu5cfkaMcDW0iKdC8wAz/ZrgQD/yqd6T0+/Cz6swyWo+4Ng3j6+Kt39XcVpEu+XrF1esez8h4gs3s5HnwsVnmsJOm1aO+5HwB0+b8GLcyLpNT13XhEtrB47f8uspFIPdgtFHmSUDM6eHFZicmnV/yy69idPv7tNGB2dTC/TrY6Px1s9ZKV6M6CkaK0ZLRrVndu1zDGx6oUhHNIYNeWgxjplEJ4NoyQrX7w46ABfw3a7H+Q6RhGfLhjTYhgtXBearNHZ4nEsZHJHA7rCDd5llvt4XBQUHAzq1PC6SmNxHtdxwdkv2XaWOZjnMWa+kOKCuDulkkrFYFVxGAZ8HIS5QJogXGGPqKEJnJ3xX0hm2BsCItUndDt9Hy1op
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:36.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf66bf2-a44c-4d76-af11-08dc5b2a3e20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control
VQ was only used during device setup and user interaction. With the
recent addition of dynamic interrupt moderation the control VQ may be
used frequently during normal operation.

This series removes the RNTL lock dependency by introducing a spin lock
to protect the control buffer and writing SGs to the control VQ.

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

 drivers/net/virtio_net.c | 243 +++++++++++++++++++++------------------
 1 file changed, 134 insertions(+), 109 deletions(-)

-- 
2.42.0


