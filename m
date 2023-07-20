Return-Path: <netdev+bounces-19625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0686075B77A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374281C214D7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771E1BB29;
	Thu, 20 Jul 2023 19:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3A19BD6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:08:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CCA10E5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Mp1uv0fVzHysEMq6O7WjcFDM8w6nIE4xQ2V0icR0B+qtq90KBomuuiJvTBqEsIl7dEW4QCkbZoedM1DuDsWCmDxGhvxmkn5WOj14vXfxwcKD3W4yYSQ2lS6IqAz+LJFIyeKBJf9xIOUhS68kAHsoLdeuJB93rMW3L4E5Sa5gv5nshaQcpI/EjtZ3uncdxmv19Uh1KEkxpJQjqSu0F3n7aRI+u4JNq4jN63dFgSz8k10sHeYsyYVpKMKdvnQJ2LmnFF521oTdILuIDt3WaI2uPy7AufjZZ91M0SurgS+xjfd1zpd/woPgBjS6sktaPEcYxXwMEAfEEkQry8oJ0P+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2qEJw9j7tk22KSqs6RHX8UQUxOyyEYzJe88fkhRodY=;
 b=nNGIC178vLQsN7/eUDn80v8fG6ncDCFKbjMmRVpGVMPsQZg1st/oTk/mKrnZeOed6ZJG7OUgLzFZBAOnF/bVoa0DUMOKexRTKBBIYY5buHZUkblSiFnhxYFXp5/DVIt86Bt4D0WViCseqgJWlJ6EyLlSl2ihHcBGvYOwt+1lqmuCX81afjzA/PJWjD00amRiIBaPC5KpJlD03hPmSSKOAGfkQ9o1j8cpU6Mkn4dmS1c63tVafI/K9DzVxiFWsPhrIcZqt8/6LN3m0Y27QCYkXU//csj9gh4JzC4GHja5OGllMWFs0WMgp0y6Lc3I7ZR77GjDxNV0wp33Rc8dn1pcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2qEJw9j7tk22KSqs6RHX8UQUxOyyEYzJe88fkhRodY=;
 b=0I3aoI9Ic8ms7GX+2MBHqOIHPvSFM78bpr6G1fPxtp1AaEupczOKO4jWRlpl/v7KVDJFYg9/T82Fh/0DxA8gZrttpi4IeUxgJLThLShQDGFtdUG6ktkuwry+Wr1o0G0xB46CcSCMitsH7R9TSoJddklgL6zNoVrhhzZLp1ZbPbs=
Received: from DM6PR02CA0053.namprd02.prod.outlook.com (2603:10b6:5:177::30)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:08:37 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::9d) by DM6PR02CA0053.outlook.office365.com
 (2603:10b6:5:177::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 19:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:08:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 14:08:35 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<simon.horman@corigine.com>, <idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 0/4] ionic: add FLR support
Date: Thu, 20 Jul 2023 12:08:12 -0700
Message-ID: <20230720190816.15577-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 604f48e8-d50e-4bc6-3054-08db8954b8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4+UjZff64j02V0jMILr58n7gxieSs62kP0EQow9qg4D9HQGoOrC0qI+gOXuHeCpjQZPSY8BG3NMaPkRFqRVdn3hk6lHD4IFDhUbZDXjU9PR0jBoS8xiWxFK+6SHreKINfI/U+gU+u2kS0Z0nOxlSuovd9pio2aAzHPceUVLQLvNpRKhQvAFnXFbBWP1F2ZLC68ddw95dT2+iLGXmydW+mKldtRZCWD+0PgveeotGEUGbPe6UwxiiOmS43/H1qkm7sqMzdLg33sRy7Gn3ilFcaYI+77n1qc89Lvk7E0EnWFDsRRQDH9pzgu3XlfqeupdjAsb3a/rNioRjiIp5z85ZsGyHv0lsE1WnQOKEUrrGKYXdccqDljgvN56BxPDfWMI33rRX7JEct/XU6aSS3gU6jU79XvHfPzXtnTVSzlFR8HfS0aCZ3pAGAmenwJuZv3PLv8Pf5dN/Q3I9TrSaGeLNMETINw2AtZ/968yHPNEAyMgphf7irwHRPYG2gBVuqqndon3xidEYKfmC9ch4WHJYGiBFAqn4GniPVig54/7//KjYBsBHQAD355t/6CIhtnLIr3g9q4zLbNXY8ZNQm1EAd5ClwP07pGWRtlupsaiWyjq/rg5i01t1KXpJBjfTikZ/4J6Y4S76RJrtte1cuV6tRIUFkl5G5nA+sJjC6/mCgYuBoT3xHplJBEUYh7TDhVAMmmLlv4/iDVrRIqFkaoltacN2AFw+UWXxWpkDe+6OnzoolvhE9n6163f0nyl9sdsvV0GQh4R8P2ed4tWUTCDiFOvSyeDKiRiEfV/4OhGxD1o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(426003)(47076005)(16526019)(26005)(1076003)(41300700001)(336012)(2616005)(186003)(83380400001)(8936002)(36860700001)(44832011)(5660300002)(4326008)(70206006)(8676002)(70586007)(54906003)(316002)(2906002)(966005)(6666004)(110136005)(478600001)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:08:37.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604f48e8-d50e-4bc6-3054-08db8954b8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for handing and recovering from a PCI FLR event.
This patchset first moves some code around to make it usable
from multiple paths, then adds the PCI error handler callbacks
for reset_prepare and reset_done.

Example test:
    echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset

v4:
 - don't remove ionic_dev_teardown() in ionic_probe() in patch 2/4
 - remove clear_bit() change from patch 3/4

v3:
Link: https://lore.kernel.org/netdev/20230717170001.30539-1-shannon.nelson@amd.com/
 - removed first patch, it is already merged into net

v2:
Link: https://lore.kernel.org/netdev/20230713192936.45152-1-shannon.nelson@amd.com/
 - removed redundant pci_save/restore_state() calls

Shannon Nelson (4):
  ionic: extract common bits from ionic_remove
  ionic: extract common bits from ionic_probe
  ionic: pull out common bits from fw_up
  ionic: add FLR recovery support

 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 160 +++++++++++++-----
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  70 +++++---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 3 files changed, 164 insertions(+), 71 deletions(-)

-- 
2.17.1


