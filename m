Return-Path: <netdev+bounces-89225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA598A9B96
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C161F21D27
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938D1635D0;
	Thu, 18 Apr 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EP0WlymW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC957161939
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448131; cv=fail; b=UwOGqKTgwBSoT+YAiBD74tYGCPWnsK4DokDxZfluY3sUQPVoq8jAuMeWXu7yIEk4R8fOINtV51UGozh0Wp1GjAAUF2BN3+PaJVIgSKV/1Ifmk9V3pJmO11Fl5GNyGy4hcPBe/Tk1ArL4P3KPLxZFw4GqxGBwwuz65Zzj90Tidm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448131; c=relaxed/simple;
	bh=c2n+AnT7+bnlh/sraGX/VD0OCftlJdjHqvWTWrRi/VY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lA60GXvzv2FjBxfH+2v4+qv2KDGF0F3awLhovUHaDCtnJS0t7y4wBaJKaSNUxEGUurCGCcLnErjB3QleAAHs28R6HiZ9t7z43go9Gye9tZ6RFTSa+jBXfGbSDepOoG+tt8IJfy6118sFV+1AccinYOrRo1tffxtcjDO3JEu4IfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EP0WlymW; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcZfqk1dFDrVmyUaIiIplYRA7+6GBwgUMT48jtuvSsvOk4UTll/xufbO0DYy1JXK3fwh9qMtkLDtL1xQFi8L8MoJWbY845X8PA2xBONt9BhP+BQvM6rvrtysGPJHcUFBaVKCvZoJke+2iOmViBOQxWdbHQUiXq2/I5m38QyFb++9SPNnTDiK61KtBZVooTtzrps89iL+8kEsmlO8SIn3U/Mn39Cba/PSuvIbMSZr/tYx7rmLaamBkw7CujalsWtFRzIJBj3u5IrIQeg+fRLuWLytua9lU+X7LJpLiaB1AnBCr2r881DIzw0buhegc4CKPIt7HT3XMe13JOLPxR7LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OzGnL5M/gPOTt8ScDlLn+mSAaenLQ9NZ1dzbUF6hc8=;
 b=bVK/YB4C7J6RW4I+VBmeWIQ6n+b+Hjoer4u3ZRJDkAhA4BYVA/jVxXDrQXWaJ6GSLnUzKhUy0whP+BSaSBBDLMGjjq6cQrffo4kHWfBY5D7pPwxokeshJfO4jMKRTTt0FsPEt3gegrl/oOciwKskicQvv4Ee9p+vdnbIZJE4PbrjAydQlmG9fTeYv2r+PC7UGHOsLSZNn9gqvCyAHntyq6XSCIOrRoGGNNEZLKFijmq5XIRX+1RjUt3nGi1xgETmZszwhd7Zp2yGw67xn3MPbr71N48rfRxicRrpytnUt7F0CanaRnnXuvYT031rBPQ+WSQJZcFMGjHITcuSdPtW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OzGnL5M/gPOTt8ScDlLn+mSAaenLQ9NZ1dzbUF6hc8=;
 b=EP0WlymW0gqS6ju5n8e7gmIAAQezIOL5xWzJIJ16j/aW7EZ8ebHOVYopqXTA4dInde7elh/KKiCWfN3Oc1RZaPwVRQk9eXBgUlqksDO1uXPVGC33a1O6i/MM9Nh1LFH6eQZQlZfrXnBx/DFYUY9CXt0NKOrm339Yk7q8WWWylIluOzddLAf4aPh5oKW5DZkYA66v3H+YZggK7Xgjvp31nvGmouoIYUpmIWuKPVJcjkRToBSq0Htk5HbTpI3MeBgmiluLqE6+tZEtWqzjZsg6bL4MWDk4m2xEo7gtNMDaRoW0WAc8XUlb/qgx3G+jdJZpq0qy+1r89cihcpljdnuOfA==
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 13:48:45 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::e2) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12 via Frontend
 Transport; Thu, 18 Apr 2024 13:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:48:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:29 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net v2 0/3] mlxsw: Fixes
Date: Thu, 18 Apr 2024 15:46:05 +0200
Message-ID: <cover.1713446092.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf67e48-1eeb-4f71-ffc7-08dc5fae43d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zVamaa2SD/zev1AULamqvhZSJVmUS16ISs0PQtwIbN+BJMVko6AOe/N/9VydW2iZyMFP0qk1GjaFjLkVu77WYTHKCUaDBzYWlproZZeRvRssReVSHJ/LmMUAMApCeH5Nq+0q3wITLPZpcqobueqFXFCGkGyJaLTb8bIypx6Tju9w1qUW2Jykvqu23pqneLIMr6pa2/y9G4dzKy31uJ8BCR0cLlGy/faVbWk5MwyjIICoBA/O7jIAxPkX6PVQzRYvQMDFG2x8f+lPrlzGK1senjpwzulWXhNyLnPFIuxTE1Cn0xF5ohPAD3n2FkXb9qoPJFhrJkUZ8xnxE2ms0I9QZgy+Wlc1ZGsBN9bz8bQbPDabNhEeDke8LaN4GipltsyFwEVN45AesuqhYCUgfzi/dhPFLUwCKgwzyqUoBU1/hnHPfGMh5nt9uBBdKTkV4O4qojT3lHH8toYitm1RkTfJCZHGhqbCnuTd693xfM7nuAk4iZLcnF0rPxTbk34KJR54npp7JRPItELisrZlUbJai+EeAXHRwASo2A60v8JJ2JkYsD2gKpPbzNQWWE0NXNgZEAUb5JzbrD9xzN9UQhuQ3V4MHou8jjU2Y6j2nTrY3VG6ntnzv0WaHf/ILY/7UvXVhlWPuqGzuI9A0fMB7z4/gSvUBa7BLfJuQkc95jyU4m+pue02Od9TybfPGxGK4gJwGuxYTeZqMQy3+QA/p8O1m/eRYLykxmI/4mB/jZplM83J9McBuoIrj0TJZrQWUdVk
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:48:44.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf67e48-1eeb-4f71-ffc7-08dc5fae43d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682

This patchset fixes the following issues:

- During driver de-initialization the driver unregisters the EMAD
  response trap by setting its action to DISCARD. However the manual
  only permits TRAP and FORWARD, and future firmware versions will
  enforce this.

  In patch #1, suppress the error message by aligning the driver to the
  manual and use a FORWARD (NOP) action when unregistering the trap.

- The driver queries the Management Capabilities Mask (MCAM) register
  during initialization to understand if certain features are supported.

  However, not all firmware versions support this register, leading to
  the driver failing to load.

  Patches #2 and #3 fix this issue by treating an error in the register
  query as an indication that the feature is not supported.

v2:
- Patch #2:
    - Make mlxsw_env_max_module_eeprom_len_query() void

Ido Schimmel (3):
  mlxsw: core: Unregister EMAD trap using FORWARD action
  mlxsw: core_env: Fix driver initialization with old firmware
  mlxsw: pci: Fix driver initialization with old firmware

 drivers/net/ethernet/mellanox/mlxsw/core.c    |  2 +-
 .../net/ethernet/mellanox/mlxsw/core_env.c    | 20 ++++++-------------
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 10 ++++------
 3 files changed, 11 insertions(+), 21 deletions(-)

-- 
2.43.0


