Return-Path: <netdev+bounces-88273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FB8A6849
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C531C20A60
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590C127B53;
	Tue, 16 Apr 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1cJmxBj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9385942
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263218; cv=fail; b=WIBTjMWPE5CNzFbr5zQEvxWHkyNo9HTl+aWKM7k4Yu5Npw6UCLw31ACYdt6XKTeycWsoSG+EBMgcQRtcC19F3qQvmW0oDAVV+/c4cDPnFW2MeGxyf6lOQAygiSZUbom89iag3Y7GWQ5v/lO+5A/L2EhpENIIeQ7XLb8SH4qsH18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263218; c=relaxed/simple;
	bh=Jh4FVwAQuGDw+xZ8N/dcjZk4sZZgMuCfn2Sft5FIqp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SSsAh8vc9kjOotUPSuC4RwttWmEp1zWqMkD1AEGIJmaVSaPMChvBoBktKWs+S0kGkVU5+wto7sSdDMlk8SdbJcNea9fi2ShwWEh3h4777fpMwj7KnWcPsDxGZyB/SeIVorqsZV/Z8Z39c7RWFnvtHv89H0eVzNbH89wa28p/mWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1cJmxBj; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ2qPWQE1IB51kC3A7gToPqpJjn0/RYqm2Dec7yHdChSqDY7FrbZMGposmOuLV0X6Op3evhsma3DOytNij3JE1nx+O5dc+pPrgF7OqFGyxwpBs7njEz2UoOqyjkgIN+4SZKKBTTiYaRPrc52qK4PYMosSlRJ5VWHs+wtjxihex8rQuRghkF9X9dMF8RenTJchzjjyB1QHIvlsfjE9fSXnNLHqSxfU7sub6ezeLXQ6+uo3rp0rfbXV2loIUA4JtsLsxVPrWTNlehzxpetiHSg3ylzFbQw12RmvlVL3aaQsIkVa5r0Wq2tJey5wuz3DmL3s636FWS0FNe4PsSONrnwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqAAvEMAXa3ljlngqCgblZi6lMfterEvp1g2kiNwnJI=;
 b=S/IeWK9dCxFZ1noK8Iis4dsmd0cKtOOSfiBFzwP4sTwRVuAU40mnA6JT1/nbm6kD7MD+LjVXwa/KOSyyk/LsuKRNWMODP1Y787A51HtZxQMvICKelIlK+a2PfsFggagX1Q2X+2vhjf12MQidKbzDD06Yo1mP58JYVqvWp6FJcMtD/LnWib9x41QxgwlwApo+5f2Kr1QRlfHStHsiDCfLEAcMmU1k1wWck3NMg5K5ao6JaONORaiFs/cQuuvkhWdTqthyta7XJVxitGkfVeXzZ+HWRQU6WdD6knnxGiTjEF7wOs1l+gk16GV8v1W16LlayMeQT7TjB3bLTYRuHPhKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqAAvEMAXa3ljlngqCgblZi6lMfterEvp1g2kiNwnJI=;
 b=S1cJmxBj/6sfELtftcyPxIIvClvDdJYHXYiVjF08y6Bu5JwkQA7JDaXlSSyCJaWpSKmH8Dh+nAaVryHG/ipoaObn4jXYwmEEOBpMGBcrar8EaiGubitj07Y/MoRP0+XMFlpz46+PpO6gvB7UBgsyRjGgnGAi9N4g7XGNIKu73CCRokY1K0vw0i9XxjlJep4sJr1mYzwU7Qpm3cTUhx2uwykaJG52dd5UPGbb1Iicj9ilGzWz8k0C6cUJ/2NghJ4/CSOGy+n8I7BecP98QtdcQZeimvv2yLtyKMq5Hd/4SCgc0yrRyvnrdhyuPsJqNJzvy8TmrZhy2/IS/ZMKCbXc/Q==
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:26:53 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::c7) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 10:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:26:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:26:37 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:26:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] mlxsw: Fixes
Date: Tue, 16 Apr 2024 12:24:13 +0200
Message-ID: <cover.1713262810.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: fe21fbdc-cb2a-4031-7233-08dc5dffbbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TozOjDj+kj/ZMVj5pwknP0+7QB+vqb+NV6szxcAEapjGZwCCv33/UgeyB+VOezD/2FLB57EAUKMEtoMIE+UB5Oy4RSSaYZrHAhilKqv7bOxoIrti+wx+acdhw7ntgT7GOKolznOEG01MHpobBJeYFgtTtXWXYFtV1rzLyPYyPAtu0uQ5PfhPPIopmZFT/ZvnSR9dBxbiBrx98Rp5RVwM0a3KnwqSvRl0FWyp0T52TBDPIcmNGI0iT0KIyMQAhP0yhfmpwD6bU0rVt5eDWlQ6LQyrkj7HeKqALMgwuwNXOljoaECsssmEp7HTqj37HCAse8ur4NYtZBSWInK91L/vBMHuYqSjWttJ9+GRp/hP6TOJ4lTDvCWxeLZjt6ZhmzJsVsfSyPhNGVBa5YuRqNelESddkFW2XKAR1hAPYypJdaO7njgVu37C2Jg+PFOJorN7Mwb/86W/p69GCnoXjzFeGPzEPeIqv21Fo47gWiqT95v6KFJapeMPiJr3adHg+rAoENqyXBxjzSOGFFzPGq1fhFuIkWZOnQoWxXBAqviHztGaWE0pvuCv7w0iPFAQujtDs9B4QB+Z0JexehPuKI1aa7XHr75NjJ/VJbJu6oBRiK0lTx6jLZL+QDxN81eviaMKSb8c5pdpVkmwu60X1Wgk1fVLNsPi2+LwiuxuYPvmICWCSKKkd7QTxRuHlX5MqaS9EyzJS2mbFKq8+4rgxie7jc6lntm4jCwEU8cR3SWky7QG4aPprkOOODUfCv/4qJEx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:26:52.9386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe21fbdc-cb2a-4031-7233-08dc5dffbbf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

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

Ido Schimmel (3):
  mlxsw: core: Unregister EMAD trap using FORWARD action
  mlxsw: core_env: Fix driver initialization with old firmware
  mlxsw: pci: Fix driver initialization with old firmware

 drivers/net/ethernet/mellanox/mlxsw/core.c     |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 10 ++++------
 drivers/net/ethernet/mellanox/mlxsw/pci.c      | 10 ++++------
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.43.0


