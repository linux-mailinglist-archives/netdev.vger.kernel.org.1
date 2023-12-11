Return-Path: <netdev+bounces-56045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C83BA80DA0B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743121F219D8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72F1524AC;
	Mon, 11 Dec 2023 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gwj5HyWD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45209B4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g96evgp9KvQkALb2aLWU+HXRamkBXeJ8DYngqfPv//duJi6FdzzmSon0GHkxwijmDNxLX1YsodNmONcsyhTqDNU6aj3/QyCuHW2h1F8xzW8lCqXG7bOVm2Mfb/omhp+rWDwNv4QcHcIAu/z62LvGnVUToyLTr/ZZIH08t7QXmfczE1K+pJhuVRuiWNqK7msqTabQ4f1wMzLfqhFTJSngkfrZ80APIQ2VHsGW8gBl0Hk8VwW/fQJpwNNCMNigLQ9HlBuWP/bimnLCxjgqQntB3Od5nY7x/v5U/eo0LheVyEUykaRSuMNtBqNdom7CmJz7ZovZRKSfts/v0wtoxlwFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvJQ5Op+ilPkvQoLtOZ1Nu2FUQIXx0eHxN6zuUqifWs=;
 b=fAYHla9PBJIo/mvFo3fqaKQ4A87T0kxfmBxl+97hN8pV+YtCpNZhm9Tes3RAjt4Dcrd7zkCaUsEhbERXmsZqQ7Lfp68WSW1giKm6MAyRVvGOWcs9uCRBj/rNNOKH8Q/H15bH4yzse/gJIBHo5sT+Uwvg+bQgY1kAvecrgKdH0AZu9+ISfnP+pGPp5XEkdMglX9wEg1eU9YYhzGeLSsDG05mEDy7+qN9VTLCFf5AX93WBopnfog0g5jrcPdEZoh2HH/IS4sl5m6ulHh8oQ6tgBwQxkrBbeloeA+iwW6VWSLD/xxD4kJNjzvXS6u6tdts0eFZr0axgk2Fu/R2m7DeKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvJQ5Op+ilPkvQoLtOZ1Nu2FUQIXx0eHxN6zuUqifWs=;
 b=gwj5HyWD1o7j+2ST0SkTBWb7/FJXT0FcsZxISpwExBniZKLSUfDaT5KkzH55vH3JoLEQe2uAdnYVzFno/Y92sPpac59Dqf1Pawaf+3enRSCRULF1KcgDa+GZ0+Py18anDwBNYf7F4k70sx0/64wPiAOmcyBfuYkxL9TGswZQjE8=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:24 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7f) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:20 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/8] ionic: keep filters across FLR
Date: Mon, 11 Dec 2023 10:57:58 -0800
Message-ID: <20231211185804.18668-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
References: <20231211185804.18668-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c62927c-838d-4fb5-00ca-08dbfa7b26cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+A6UhDUHvXu4nCsiZaUO53bSRhTERaGoTehJnivVERTCkkERHHWxRKO6uUxrfQe+Ab1u1GAOj09bUWpym581opNXUWDCZsfMq4246rZ2dcPxvU+C606KSeT+/wlp8t2eb+NVWPEZcXLYLruv7syo7SMlnhwv6UkqIyeKpwy92eeI064szB3tyNsl0FdXJpMOikISaV2QuLcQs9/vPGmpSi2BFa07c+mfw1zB5KNl8mEZeWTXj1gP3f1rS8DNP7JSlStLFVeLEojSSM8rcOeOAVXYTwweCeo3Cymkr64u5xhSgLglCctGCgH744EwaoPBY4rn9UtA9+MbI39pPhZtMHbKKIj6POGEoYBfoKwAJdreRm+47NfNClnZgFGpg9WCyyhu6MZlnOwEqutIl01NB/HK3u6ezp7VuYZIEvTsAMsPzueiNrputL1A43dcY855nn3cEcus+GXA2Wnxxsv1Dg4h/RB/03ZQ8PFZXqw8cntYHUbrqeU6Ak6vljb7NkXMMZIircDxcJZj7AWptKurfIkozj4dqR0SRn44qBvRYuxEBzAbm2HrM0bn8D/6K8DxcdIrYkeVC7oqAz7dt1UgoQNWuLbtsIaQwRJe9Sc7RPXyAcF5xzmNeGcMrwbjgackbfoJKWYWrvr7XxTvNc03DbcYhzwpylhFDAvcj3vRKeANWMU7mYuvNnUGRLi3A1ZC1uVmx4ZRkYpCRCq6PF0jGG4BH9oVGLIj1cR6GZ3eMxVJLYkpNl/DACU+bD4JHvo9nqbq5vn7hFVD/0ndJxLuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(36860700001)(16526019)(1076003)(426003)(336012)(26005)(83380400001)(2616005)(47076005)(82740400003)(86362001)(36756003)(81166007)(356005)(5660300002)(316002)(8936002)(8676002)(4326008)(4744005)(2906002)(6666004)(44832011)(54906003)(110136005)(70206006)(478600001)(70586007)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:23.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c62927c-838d-4fb5-00ca-08dbfa7b26cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

Make sure we keep and replay the filters and RSS config across
an FLR by using our FW_RESET flag.  This gets checked on the
way down and on the way back up to help determine how much LIF
state to keep and restore across a reset action.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index d6ce113a4210..43e7967ad1c5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -416,6 +416,8 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 
 	dev_dbg(ionic->dev, "%s: device stopping\n", __func__);
 
+	set_bit(IONIC_LIF_F_FW_RESET, lif->state);
+
 	del_timer_sync(&ionic->watchdog_timer);
 	cancel_work_sync(&lif->deferred.work);
 
-- 
2.17.1


