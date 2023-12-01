Return-Path: <netdev+bounces-52731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9207FFFDA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08470B20D12
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96322620;
	Fri,  1 Dec 2023 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NQ73uW31"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC510E2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsMHhyFRppEo6j8eK6YQlEXvioRgoBuCZnvAUMn6bB9F0b5N5+2svbQKwUHcUXIPQvvRgSa3mZVIZ6PDUNsoQUcqWkramivnpIvcI0JA202bzabVnkPVPNtZhPfTkXAg7R87iVmzT1ToPXbld0XQqPObUAeRNgLzKA3Mxgn/iFey5br8RgZtKNZefk3bYMu3qsryvB4llHRkjuMvQ+5FswD8SMdnZ7Kfu4ucbYQ/MbYcorOaAlgkOk6rAgPk9uYGpsm37u02xaS1pIAQdQ9kkr5maInulufg4DkxTSnIcvWrHJELxGm5VhJ3beRI8AMTku8/d8HjyW8xqVqxT9Z34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm/lKxsMBBpPqMs9asHHo0On1Gf/2fcOv7okAYVecog=;
 b=NAXjB2xsXbbRDq+VR4Wp5fh0ImFbcDwYpo+w+SsEwY00oOvrhy10H/xJ4w62UxwS9rnzbDEzx0GOlvslEils8MoqfTtosYM9dRWw1URs9tkpfu2L7Q1+k89gtjW6guTXzGVZ+JWdOzh/IQNEwE2tPDJFJN4KK8GIp/hSbNVsoRY/UnK4CgMME8a3rTQhpGFQiD9IlNBYjaHCG9w4XIzSPbB8jMRWMWIZc1a0ZngNckkCMDEJCuKg3jqO2HGQn5M4imEeJVy3vqaIdBs/VHuWqr2CxpYWBivz+f9Ls1ktika4YKFyhOkJ8Pm+U+12rZ8pvjV1RglpELri8opQ7p+sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm/lKxsMBBpPqMs9asHHo0On1Gf/2fcOv7okAYVecog=;
 b=NQ73uW31BUA6HyS+VrT5lvcbq0Zv4x0fWmjn3ohfzMpzVEqf/zMpLhRv0kf06mIxGtl6QNR3xCw1P1IcLCWTUglTpJcbTdFXuue1yp2U9yZOOYZu3sMwPjPBVn6ANiArmsOgpeKK/TQrHLisg2Xowyk9T4uuXyWFrg2+DmI5h+U=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Fri, 1 Dec 2023 00:05:39 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::28) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:37 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 0/7] ionic: small driver fixes
Date: Thu, 30 Nov 2023 16:05:12 -0800
Message-ID: <20231201000519.13363-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfac67b-ece5-4ada-13df-08dbf2014057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tWiTcFvD3r5UmpWtNeTGmtFuniHwb9dBIO7tZ4Ud1FaxGfkoAGkWKU+18ObW6NUsfFTCFdpPf94b2qvx+Q3BBBzW5sJb/68qa9bFT3NGQ0hR7BGsqP+0BY9mdDfX3oFo+jxFGDRBb8IOiXsvDoLbnMVhXOjkMlXQfHYKI4wX7i6icuR5ytxJo9kAtirxn9pHkmOmsZkzFIIFBOsreZuNRUHajXdHiTadaFoolJR1lzQrtCTNzxXRumMIF7BfoXg7iubNKO7Jp0zhrKcr93Cmult8uxdsQmuHpCXg00kbp32KCvTxNA5bZwPsPulZewqJ74nEQgq/gpZ2jv0bbGbE6eo1RRY0UggT/vidvhl3RdyxjDkFCorP5g0c61AZ2vUp09SOVIkniNZwEsczFn0AjoPgUltAA8PrsgFSepoZGmvJ7W5KSsxNUj1/fPhGHqU9UhoA+yZq9q14TVy6dolEKfDEF9mtkRqQ2h0GsHwfNgelmi3u0kEyRUCL6swXck1Ayj2/JDKhu54gTlDdSqz6Wc6sqdzY6MA0NLHFvknGqeXsYpo0sCggMQRctWouxDaLqvl9v7p66Z5wnrJVh3+JYomVh3lEywciX9kA1nDCqEdnZw9runpwZhjsO75ng8haVVp8zzwCsEoXj0K/l9kyPMO93/CZaiRb7yl7e99Qks1fCIJMwj8FAsGkuYBMdd4+WMaiI+Pd9aDTm96OHCt/DYzcTgrTB+HbPTrK1x7WzEngL6Z4AgBlBKiw54nusveV2WxMcn8RLq54NLzpAGrzuAo74z1B2dke9ESBgEa6AI68ssHvxs155sB3MAYh87E5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(70206006)(70586007)(54906003)(336012)(40460700003)(426003)(316002)(478600001)(81166007)(36860700001)(82740400003)(83380400001)(36756003)(86362001)(2616005)(44832011)(1076003)(4326008)(40480700001)(5660300002)(8676002)(8936002)(41300700001)(47076005)(356005)(6666004)(110136005)(26005)(2906002)(16526019)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:39.0457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfac67b-ece5-4ada-13df-08dbf2014057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531

This is a collection of small fixes for the ionic driver,
mostly code cleanup items.

Brett Creeley (5):
  ionic: Use cached VF attributes
  ionic: Don't check null when calling vfree()
  ionic: Make the check for Tx HW timestamping more obvious
  ionic: Fix dim work handling in split interrupt mode
  ionic: Re-arrange ionic_intr_info struct for cache perf

Shannon Nelson (2):
  ionic: fix snprintf format length warning
  ionic: set ionic ptr before setting up ethtool ops

 drivers/net/ethernet/pensando/ionic/ionic.h   |   2 -
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  40 ------
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   9 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 123 ++++--------------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  22 ----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  10 +-
 7 files changed, 37 insertions(+), 174 deletions(-)

-- 
2.17.1


