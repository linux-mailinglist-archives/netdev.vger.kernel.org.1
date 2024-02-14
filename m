Return-Path: <netdev+bounces-71719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D44854D4B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C392D1F27DCE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC65D901;
	Wed, 14 Feb 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JVLfPtbC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F75D918
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925752; cv=fail; b=Tlg7aq38c28ddACHyhKB6uKXjE7o5g9TcvNs+sWZAJk8I+2vgV+tWbPeCDhHoHAUBqp8Bnbs93OmZauq6oGwx7kc+GxnS70qfSblqbPGU50mjxfvJkXGY2GgTi4eRJRA2TwWBbKs5UiIrebFvAdiCHZAYcA93A7s6fBp5h8bUHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925752; c=relaxed/simple;
	bh=xpRn+QtLjVXcjiT/kR0RNJi37RkEupd7b7Acj6+kZeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oe+uEK3gMK+/aMrayzW5fxosAsLeXOV4oW74xT88OQPg7flEmz8n/huQFHlZfk0Wkq41XFrKVcylJ2tO83jWOq2gShZ8DZGGGqzH0F+QSznt5V02dPVvleyPI6kSo8KXNNvbLRl+Vzehid94AIc/3PgnEBJ4OYiORx6yvwiynVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JVLfPtbC; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfiuy6YZJ8kWSkZruuCgrxIUm1X7OgX/7QLYhtlESTIZS4IjV8BLEZgX2QwYuFMP4LC8VtF+K1+YJdn0Yl/PRm3EgveEn28qP3CP0GVE1DG4WjvdoMsE76nQuGn7jsnYF5OpjoOeOSJuMsF4mF04p7J835w8BAAQQcc6I5i9H1inrzKVrFfLiaSMktAWxe/dB6uh2U+ntU1mDjNmAlkzSZ+7hSUr+SMs+SH3tjzDD1S+Da28GsTzm3F6SBuheFYjQAGDHZwxPik38pFfyhGwdCrJ9hD7gIxgQ8MAyB18fyscGeH72b2JN3QZU3eRh08b+detfgwN1ttR8NimbBI10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/Z70FoKX30KgiLiCUn7y67xoDQwoklIw/1ZtpXA100=;
 b=H3YXm9UAL3ToLRyGIu5fCJ743VPPAlEok/cPOyyVOxeGMt+ds4de24jZWNVCbEA39CNWyFIlNnS4p+Nv3YsTTL/siH2D3ouScd5A1emis1gCkZEDl9I0VDZB9uAV4+6aeik5T0b1gjg2dhO5Memc8igz0o+3TRt/eKSzE2uIBHSdLxWlWalgultAWBOOLp9rE9oHFFDh4gLKWY8cjvwtUbrGmOdrIdgDfRtaFMtCDZTKX/5XwxP2WY2/gG46lpBvZHkwtJqpMwZwGFRLEWY2IVgvBMwiMH/vmxBIFubtmG2VrMGHFrqtL7oFEIx9i5PZ0Pyoqfubgl9x4Ua9LRWPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/Z70FoKX30KgiLiCUn7y67xoDQwoklIw/1ZtpXA100=;
 b=JVLfPtbCWOJRDSBV67GG1pVcKMiVQNrHGTkj7v7VgFrXqNFOPMnalsDQ4/97DQhZLGXAAvjZo2q6iy47awQkGXwomt9Yf+yfBP+cdtvS1eU1AFDmpC2MpXqo6iAikrZJvY8C/64lY8jZZN05yFSb14btoiIRtAl2eFuGvMZnYQI=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 15:49:08 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f9) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:08 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:05 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v5 net-next 0/5] amd-xgbe: add support for AMD Crater
Date: Wed, 14 Feb 2024 21:18:37 +0530
Message-ID: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f75740c-eb26-4d01-d578-08dc2d747b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fTz3kSDMZQYV1Si0pyM575Yl8KqDm+9Xor7N66C+slpX6CkUMHKvw4v+XYYkjAPPJs5hWF3GFBeTToKXs/hW0WiYB5XVgmOjg53bwRtXBDGstV7srQO8gc2rVI4DyTccmlIszWZgMGGhHpbQt10BiaJY7BYLnGk9ASI3+jftCH6ag71Uc16WJbpEDvqDGbwTTqfrr6k5a8ph369h9gAL4SPLbFOulOo+sYC47h1/Y1SfFIyRH/HB+fLvXLKkgeT32dfZCRDmwh3clHc1OuYvnFSnACj+nQn/EYlVAUPh8bUfORkP7hN4iG+Vm+n2TXT+/HCfFhUQnvp+nhl9NtmCWPq2byoMlWsKzE2XrveV87gEg+2jDt44x5NlQz/MMl8baelsJn9z0BM1BeW1uGwYlNEB4tIMqbIC6tHhGN91wdx1BHIoaHUAK0jXNd6cVv2EbgVhouhpVlyvtxeKfe5HZ+8Lxiy1ks4ScYzJz0rSGw9V2qDXlELRRoMVEZBSCwhxLg86m24ogSbqC+ec3oHpVydsjA/L/9ZdLjQltJMWrJGO3m3+jwhkToZ9QC4khDUJXCgtSHde7c67Mnr336NDDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(4326008)(8676002)(6666004)(426003)(336012)(81166007)(2616005)(70206006)(356005)(8936002)(316002)(2906002)(82740400003)(54906003)(5660300002)(36756003)(6916009)(70586007)(16526019)(86362001)(26005)(83380400001)(7696005)(1076003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:08.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75740c-eb26-4d01-d578-08dc2d747b02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Changes since v4:
- split the patches as per Simon's suggestion
 
Changes since v3:
- Club patches 2 and 3 to avoid bisect issues.
- Modified license in xgbe-smn.h to match the license in all the other files.
- Modified the function get_pcs_index_and_offset() to reflect the name.

Raju Rangoju (5):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: reorganize the xgbe_pci_probe() code path
  amd-xgbe: add support for new XPCS routines
  amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
  amd-xgbe: add support for new pci device id 0x1641

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 124 ++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  83 +++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  11 ++
 5 files changed, 305 insertions(+), 57 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

-- 
2.34.1


