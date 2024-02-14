Return-Path: <netdev+bounces-71786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BE855191
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981A2B2FEC1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340B129A97;
	Wed, 14 Feb 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLVWSqZM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA36127B51
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933570; cv=fail; b=YeOzJjU6uRuIWcrI5NhSI7MiF72c4Spe6Z0LcE86jFnFcApGn57Uus6qm1k5xleMhQwNrbAPJX7xzzsKOHHsbkqQRwcsL/6vElZ8mkulxU6sDcwt6tcNrVRFJb0Rujv0LXqtS/VijoyF19j3zwps5FDWBU0aEUXeYzH2ZxVfM94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933570; c=relaxed/simple;
	bh=CQQz4i6L9YcmAdPZN/uYS78w55Nd0bLZzwJJfkWJ0mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qqtGOw5mR1iil6REwY41aQC1ey+l8zYhDY4jOmMYB+xcajNrVkbHwTV96t2PBt3jAWkXWy4kPT//qOMm9NE4KEPoBZezcdHfjJRV4N9F8QDHAzK5sGdaN0IA+cFmMzINU0kMyrl9hmb/50mb1OLnnw4Kwy2BLiLJqiizvI2GCBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLVWSqZM; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB0nAWC454Dl1W1WwBU+BcYzkhEXPMXhE2TwacReISxJd+yZ3fct1YdVmbNKyXsy7I3daDjNTw7EzpjVYb7+kksMk6C/JDTkROVqClO1OQYRnVl95VIUcDEeOhcwnRYBfQaz1zsLuisf/2kX6Ek10Jzbrox2hjiv6vZj4D6tWo2069A5GK/nUoN806b+oqFddTJPCzfIdQxKgVDLD62kfVQng7MMHvQP39R5/fPXiXxq7QvuqpKwyAh97R7rusXJLk40YFxZuGEKXYZWRUqc29v+W2nC8yoosXr238aafzqp5bCOiOgm2Qfw90y5fpdKEPESa07U59mdkk5FWk0FgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4k/PIO5BfHc2oHN2TCYMpLzxbP4G7EtgwMP0UKMVFY=;
 b=AwisRhed4l8GRMy+kefcN+m/WHkjzA4ZH7vB31LS422fwgMmdpkFRUEQCqoPqz7ip0Sw9n+W4Jr/6QnJb8rZfP7pcwvDkkSt//st/TqmQ/sPLBajUuCfGs5AZJAKEoxdkMT3FG7HhwRoj5lb83159Y/9cHsvvLPdU+1dcHOftb5G0C6+wlpJaftjU5JKrGICvUxwVXwOjf5lcb3KKsmBVD0jS0t+9i06DNr6fnmzFx123jx5f03gTPF2ti6SflOMtyu5G8jgR8rU+dzmD1GKg5sDSlFEiF0V496UxR8sgD8Arp6O8YDRTAf8z3wi5UWZziFVcMXVrU43zZn8nh+55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4k/PIO5BfHc2oHN2TCYMpLzxbP4G7EtgwMP0UKMVFY=;
 b=wLVWSqZMRh1M7AxrjT5FrWuzuDjc6yY1dOQ+jdLgYhTNRB9bTMHeQqZNtJBhst0Xf6QIwSdvSmQ4cD2UH9fnx/Ze6fK7cCYQQhI+3ooFiNw5nynkchuddgWSdSzfRDdq43nRxxmc2mtE2Dn7eSNOayW4jUhQFYvVyMNqnvdFFBI=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 17:59:26 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::1b) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:25 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 0/9] ionic: add XDP support
Date: Wed, 14 Feb 2024 09:59:00 -0800
Message-ID: <20240214175909.68802-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dd433e-06ce-4f05-3a1f-08dc2d86aedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cD+KzlFIsmm7rIReaXeVN1ddM4sL8m8OoIuUO/o3w7CJNVRC4aBds5SwGBh6owWmq6Igeyr/493UUAOXjLN7iDFdU8MuT3LCvinbnvok2Sqv+LqKS3gKGbAlNSmIx702RDfV2ruMU3zTDUOIgv3kCtI6JJQCYi8r8DrLqxPc8HMoTrshlP1dlUEQt+Emfiu8G/SPjZgamPSl+kun8UduHAR8OMAO1NM3o5JHV8c/fH4MHC+F5QORTJN9SR1E7PHK9fMhMYkcXlB6PMDp8aAUH28JIQ/+5EFr8EwQrwin54rhopY5iDOGJ2P/mZr4/0JmqDe5A1IuwkJQ51J/JN8hRp3lalCuVnOxUxQ/Ihj3ENFtqH1ITtf657sx3IqmIVJUey1jLAH4rE9HCsSfuDvy/3d+VDJpWWrafWNx2NSXP5L+RAq/8u+P7dCmlEZvHSRTmoH96Leh/MbHG/H9Ezedbn+owLXQQIDqwyjGqyXDcJFlh+I6Z2ngXWZVtAc1XAYaPJRzyHpPt2W5dFwur0A1NjSS2HB8W/xHqV+1WI299WLNnsDxZWO5WVatxsUnQ7fD0AVBBjSj14ZWz57D38yJGkug5qQflwe5IqBKeaVzXeM7qxMBIq+0sQQWKZ7AXozj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(44832011)(2906002)(26005)(16526019)(41300700001)(478600001)(2616005)(1076003)(336012)(966005)(4326008)(8936002)(5660300002)(8676002)(83380400001)(70206006)(54906003)(6666004)(316002)(36756003)(110136005)(70586007)(426003)(86362001)(356005)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:26.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd433e-06ce-4f05-3a1f-08dc2d86aedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114

This patchset is new support in ionic for XDP processing,
including basic XDP on Rx packets, TX and REDIRECT, and frags
for jumbo frames.

Since ionic has not yet been converted to use the page_pool APIs,
this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
to convert the driver in the near future.

v4:
 - removed "inline" from short utility functions
 - changed to use "goto err_out" in ionic_xdp_register_rxq_info()
 - added "continue" to reduce nesting in ionic_xdp_queues_config()
 - used xdp_prog in ionic_rx_clean() to flag whether or not to sync
   the rx buffer after calling ionix_xdp_run()
 - swapped order of XDP_TX and XDP_REDIRECT cases in ionic_xdp_run()
   to make patch 6 a little cleaner

v3:
https://lore.kernel.org/netdev/20240210004827.53814-1-shannon.nelson@amd.com/
 - removed budget==0 patch, sent it separately to net

v2:
https://lore.kernel.org/netdev/20240208005725.65134-1-shannon.nelson@amd.com/
 - added calls to txq_trans_cond_update()
 - added a new patch to catch NAPI budget==0

v1:
https://lore.kernel.org/netdev/20240130013042.11586-1-shannon.nelson@amd.com/

RFC:
https://lore.kernel.org/netdev/20240118192500.58665-1-shannon.nelson@amd.com/

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
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 193 +++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  13 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |  18 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 460 ++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 +
 7 files changed, 663 insertions(+), 38 deletions(-)

-- 
2.17.1


