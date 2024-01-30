Return-Path: <netdev+bounces-66928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90384184B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5661F23871
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427CA3611D;
	Tue, 30 Jan 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJ8eDmdZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0FC364A4
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578268; cv=fail; b=i2g9aPyyxC3XTPAVPVTMmcGafKJNZDIP6J2ayhmb2uknuYeWQXPJoUXpvb8PJRzQFP6gJyCG7zewAQ6Kp0X+WA4Rf1By3OPHFiZheHiao4fBDb3q3UWo6shxz8aVSHXuv8Siu0R8K0kOMZTGl8glerfheujFiWcvV6C7xHrnPa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578268; c=relaxed/simple;
	bh=mTaojEFksAU8ymHFiy7TLC/inv1stAekG01WEIOL8x4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VxfXV9Ty3lIzR1yeCwAWTY204L1Vg/fROnRO1ZG2UkuH/pxh1nd699AOSxGpe5x8wW9LPFVC5fZ1XwJVAUNgQMWwFS6u582dO5LYFsqGxCwj1aY9Nn5oCkbPDGVY9f7wWRJ/GzC7xAD/Xqpytlwdoroiuw4VrNv4Gs9nlxLMito=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJ8eDmdZ; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTbc9JMPR+WAO+Lk45c6JpetKCZGr6CQP4W3aDm0udxmm6KiRh40Byz32Pzh7W2vnr0AsaXmBpLLdz0GHoiB4lWtgK71C4s6i2eNQ6ZFCx5Z1x4g6Cuta4EmjdZLTByM2Ml2pjrPavO+AYkMm8Q3oYRgxkh9tU1Ld+iFjmWqjpev0W3PZn6nftXALmGpfDt3rT6mNJ5rFnVUsfIiF398V2ISfcwsww5iSpy/dEd9HzVHHxRn1KRtYFf8n1sdMJENayL6Mg6q8sBdPbBf55RaEVVzAoTHES6xP6Htb7RLgN8tIJoZEnQx0lt2DNSr9TXO0eAR1znR7QIE+74+JRUltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAcmFa6282y9Q0NCxio5aPe/N0UEpAWStLZ4Rnmu0zc=;
 b=dwBcueyT93k4M03GodqkVYWYxwLpcnKlLDW28v4qWb/4bQpFjFTulhCwuBBYEaNfG+WrrqoKwWSGNda8EEKGMbZ3luLekX6axDQA3b8yOw+5Io/OLoi/5oxPE41zARwE3dIiYhUJTSE05UdXFBKrNIWCaSqcRA+lk9Me0hdfpVJjXtDnf0DhS9+D7KalUMCUzsvQfpQLlcivR0fYFGZh8ZQXq26ECDSaaFkRhtqUH4pKcii5PSImVorl3Duu/R8nFUkhZiGlTDP1Tlzd5hg9OS14hLTPc7uTrLRDSVvi89PVNGKp0QYtQKLcQfqnsQj8AjghkL4sIwB8grhpfw4uKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAcmFa6282y9Q0NCxio5aPe/N0UEpAWStLZ4Rnmu0zc=;
 b=pJ8eDmdZcZKHaRMyLpCgXH96vCdSVohqdoTzJmFn+6lf9wZ0MYpruuYa1+HT+TaU5Rrp3nBm1GBfOQYhGGwR5jgHlR9HJXF/ogD8BlaESZ7UV9c5SOt5vG4oD7L5KBHtKdiiSaXyaVXC9+GRMYs1v6oE6CIb4/RvjMKsKCNDLH0=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:31:02 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ec) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:00 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/9] ionic: add XDP support
Date: Mon, 29 Jan 2024 17:30:33 -0800
Message-ID: <20240130013042.11586-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 907d51dd-a83d-4a78-8e0e-08dc21331ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JaqLqS7kFyYXvC0hRu54MIs1ePxmkFB8QSaP8P2Qs+T8JAKnYVTFAcy8Qy/e1oxCdZWjJ2EaVm30iUuJxspXh/KSuy+Q7S/UXTslJDKPb9AuJzLSeQ27UTPJhHzOPmGg5G/mu6mSimecNFdllKwGUrqPcoXWU6NbWJAAWnke9WOv3NceqxXFW+biHzp2QwkPSoFV+jFZsmgtKx4tGv8Xw8i8NDxK6UBff6ZWrQbnMtsh9zsQYoYRqKKv0O4yBtjSnAUPiebJAy3S2CXJTClgP9POE5CP1rEYEn5INK4SFBri5wedlba74eySWo5J23NR6GHac+40GEbNRy3yTi9odAhgFMCvejQg/G9V6dEVKpa7eY45kTX/u9JvIh4HDvhdwce5RvOYLo/zueSUIlJqnZDTg0nblcBD4oDJYaW8KiiKQG54kNnn89/1icMypKQ3tGo8mN9TMcwDSNR/PIm6/Jd6Acu2tADQFck0EHPLYUzTC/e+u5hnlTkGZ5Asgdacki5Oq4+IWTligxtU9zCP3tUNM2tTPzUgsm6irOZhomSvk7wO2XuZRBevVQ4m05K0/g1C8AgNWuW7piSwkxVCQ7+pEfJB8uU3AWQGbgbO54022m5wEIyRaXHb0hOrpD2Yw3rsCqR/dSyXUn0prho+AHyoT+0b3geBawKj51JyELU7w/BAw9PqId9xSKMlEg0fAYv2+mGYjkZbu9TIF3SI4Hx2I46sP9tCXxLL402eKyW0B3PD14EXMfhnaT+Eo5aS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2906002)(6666004)(5660300002)(16526019)(110136005)(70586007)(70206006)(316002)(4326008)(44832011)(2616005)(1076003)(426003)(26005)(336012)(54906003)(966005)(8676002)(8936002)(47076005)(36860700001)(83380400001)(82740400003)(356005)(81166007)(478600001)(86362001)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:02.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 907d51dd-a83d-4a78-8e0e-08dc21331ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

This patchset is new support in ionic for XDP processing,
including basic XDP on Rx packets, TX and REDIRECT, and frags
for jumbo frames.  This is the same set that we posted earlier
as an RFC, but now refreshed on the current net-next.

Link: https://lore.kernel.org/netdev/20240118192500.58665-1-shannon.nelson@amd.com/

Since ionic has not yet been converted to use the page_pool APIs,
this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
to convert the driver in the near future.

Shannon Nelson (9):
  ionic: set adminq irq affinity
  ionic: add helpers for accessing buffer info
  ionic: use dma range APIs
  ionic: add initial framework for XDP support
  ionic: Add XDP packet headroom
  ionic: Add XDP_TX support
  ionic: Add XDP_REDIRECT support
  ionic: add ndo_xdp_xmit
  ionic: implement xdp frags support

 .../net/ethernet/pensando/ionic/ionic_dev.h   |  11 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   |   5 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 190 +++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  13 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |  18 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 454 ++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 +
 7 files changed, 654 insertions(+), 38 deletions(-)

-- 
2.17.1


