Return-Path: <netdev+bounces-86429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7724E89EC4E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7981F21DAF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686D13D289;
	Wed, 10 Apr 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6uTaqtS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EE13D280
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734789; cv=fail; b=WLWwQuVaH/VV0iSr5T2UhANApsPGNq6rGlM26XiT3oLnhyQoxgHgRidcyBCnqr59atNhOGUbSTfoKoLsiH3pMJFs9ZCaj/tMCS0OIoqqPouWSkZ5prIb7wZWOax/4caZyRXSEZHZpU7iEVl9KzG226cVPy/doZMoWEAyedLmF+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734789; c=relaxed/simple;
	bh=CX5rMngV7ndOI04nKcILs0Esu7z227xfRLTbk2dWm6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QrK33Cam60X/qiyjHMLu7lw+B0BtXpTky1abqKxiV02JzgqKnCZJeVKKnXzo9mfdKQO/V4bZVS2VgkuUDsBHbAmANyP8csbqwbN1vAeMXnycg3w2mFaBQiKVcwCKqgB6BPu2j+DRQAqgSg3ZvAeTbtCVPWEkTmHIKEy44YGzZn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6uTaqtS; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+yHk8OuZXKlgKWqXeffP+WoD3E/7nXgWqfVO/fWovDU/E3baBUhi4wm+bB7fwLsCb1cAxjKGGLdOI7oBAKvIhFD2cq/dkLls+Zx2Kr/4VARAai1coIM9qUQHVZkYafVbBB5A8x98RqV05QIWaQAOAd7JgEVTP2yPKKVNYLsQeLucJ0ojAeBZiFNjAT2dPHxtHFIBiFSf2VaPuPoGWsIvsv6rRm/qnvWPVRz+JPu94u/jCrEka4kPf4DQ6t5p0jtUOxU0HgVawpP8edU/GFtj2FB1ojQF9s5dcixFt5k3gOaPTGnVmuo68BqzGCTa4ECFVxD46wc/mDN5JWvm8qnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1ZRNoo/0Z+sTaiCnIiYsrFLYJWsSwtcMBrcpVeBaZs=;
 b=SWZGHTeam5DWuVesj6gI0JJ6RDadGwDfjdYyqFdoyBZst/8M/BASpPTuyrdoRQivsPo2GAHpsO/8fGAnJzuLMkA+g2s4aaZEtxVWkctzVXoO17se1AqZAPewIolGHFDqVSAFyQNfwL6+MeMUI5NgJahhVOC4+9tSpLYgi0Bm66L8OrXn6tWLzbwS9nRLeo2nzE86sN1Ks1DvabzbBanvp4ZAx7kCLxjqf4gGlNVWjuZWPXDH9k4w9QTkxYOiVUPN/gTbxIP0/pUZBPccsJ+VAUNQge161hG4eKasKqYAQQdEplCuVcXrmQHDYRLtHdw2MnsgXk/lHl5AgAfzXTpnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ZRNoo/0Z+sTaiCnIiYsrFLYJWsSwtcMBrcpVeBaZs=;
 b=E6uTaqtSLl/REl/TSIRu9jggR91lNzRXlAQ3K4WjTEOPcd91rD0b2QXOvIILJVrLkoLsfoS1G2cQDaJCAOzHz3AxPPxtc/siDQvwIk31rkzaCR051HDf7Sp6tn0XtbkeGnFGncsNNYo82yyPdv3bz03vzfun1XQWbXiypAwDyzwVkAQiyEEccE7YN3X9hfWvDkK3/eoQesDSWNLdkNzog94IxtizK66s3R93fpTtBUu9ShzUrqsJzYAcplVALwBNUqx0U/M/dYWj87IJr5WsWfA00xXZg53IfutOxjfKaR3+BOkQjwrvWRTHJ+h7OuTS8QhCwT0s+CP48RCbeD3hJg==
Received: from MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:39:43 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::dc) by MN2PR11CA0013.outlook.office365.com
 (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 07:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 07:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 00:39:19 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 00:39:18 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH 0/2] devlink: Support setting max_io_eqs
Date: Wed, 10 Apr 2024 10:39:01 +0300
Message-ID: <20240410073903.7913-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d96273-472d-4eb4-8c23-08dc593162df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9tm4jM0pSi7edej6ZR+Yzdkti9Vj2ic8c6bVAd3jEVlwbkfzTABTUpuozgECMQcWNKYr5IEbIRBdCeobyKovPiWdEq4YHZplYOJHM9J4nqXGS22Dfergzw2e/F1Lnt2OOQ1qkK9lnB0JvMd25BrMC6s4M/1NncK/z2r0g4tldKVV6tJIvzd/3llFGQQiYfdFhopJo+MSTFaU05r1hYWxBd5UIrwy1iohsiPpOp3+/n3jEGcvy6L14IU3XeTfD6KwYVsteuD+l/v6i4N8H4W9lFJHZR3zLn+3Ehe6ctUzUWlijx/4+/FLIr5gahrWZWjdu0zL1wvpZz/EIFqNxyF7ihdW4DxauIhvJBQr2GBRDpzsTltIEel6dm0gBx1m8a+0zCiZuekeF4/qY+UigDHSjLSWNUODyEFXFzIPBWOWbPasjDhDwZ08vsRXyAkCGT+0aBiFBe+SZidiPRvx3hqWjh0YccAlDDAUyCj6APCmkhMoxHPrcu5pd5rBciswLeDh4j3Qr/smi6Fy3984ZrQqtE4h/y2/Bt0MfxuceCHpUDVssw7fptfRs7rS6FoQvL+E4qYrNXhTcrGRETu6cM1QTFW4T2xUYhlSAQyTA9M07u4nWF+W+Poba135lnG7fNb2S88b8T3qddjQlPmkWDVYWg4p8vN0pXhQMyGNG5gFfP8vn0Kx0uBWd+ID6ipaIy2Q3J4zNjEPxX6vP1ZJkvyoUzHdG4VJ/VBGuIgS9fSqX0oIx5mZQA6pH7JYedeVmLjo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:39:42.4979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d96273-472d-4eb4-8c23-08dc593162df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

Devices send event notifications for the IO queues,
such as tx and rx queues, through event queues.

Enable a privileged owner, such as a hypervisor PF, to set the number
of IO event queues for the VF and SF during the provisioning stage.

example:
Get maximum IO event queues of the VF device::

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10

Set maximum IO event queues of the VF device::

  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32


patch summary:
patch-1 updates devlink uapi
patch-2 adds print, get and set routines for max_io_eqs field

Parav Pandit (2):
  uapi: Update devlink kernel headers
  devlink: Support setting max_io_eqs

 devlink/devlink.c            | 29 ++++++++++++++++++++++++++++-
 include/uapi/linux/devlink.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.26.2


