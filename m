Return-Path: <netdev+bounces-16987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1A74FC0D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07651C20DE7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183D362;
	Wed, 12 Jul 2023 00:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB477190
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C118FB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnjxSdLvP9Absnfv0YfpIOkJN5BE/5X938+0NWcfPdXEWGcmzeGXLFIGSGksQeyO8Tgp4v9z0zPR8ehOcnqm0TznOdIAcEo99pXuHQeN+9qbEXZ97vbJzf/wNWbKKFEjjI3z3lFDvR9z3ePhyfTskRDgAjbaiWyLGGnNkne8NHrA9nhpFVZBN0d7FSxU3JcU7rbLjE1NA3lBtvLZQm/Y4KAp/9MMi8DLd7vbROpYNCTQmOS04d+bREBO6EHdJGcGedFrvYymQ9B5wif1Zb5wJ3o9swYkYNA0RleXCe2gIyngl9PEK5C7idDtVYVaw8NrwRXRRgmcSYjOdxRTTdvzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf0NHsfBELuNvMGWmWgwx8w2Br/tlGPzmWObCT71p98=;
 b=h0CmsrTq0RTMt37frStrmj1j2ihjUNpk1XbbPb/0rKHmclSxCmnqCgCwIZLScWCztR5HtAomTrBWyhJjtfPQQSLM/U1ARXjqv99o/+aW3TKuNmhGEuUCSFfSTituGAzQXEv6uEbLWDZqB0nJBen5gsqsfZoSa/VUfxKBKR3lLy21/h+qV6syp6cp2kaQmvDNkBMGToheKm/2rXRPvIuXlq9i/lzu1Mebla8cdb8Fli248bjN86lhAEKEH8LZ78PGFjMoV6vgqAd686hkfKy1p6FhG0GEZA8UwmbHELgWzQwgovwnLQZj3QwJCZIn4aKlAZl7NTaODvISvSi7Bt0PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf0NHsfBELuNvMGWmWgwx8w2Br/tlGPzmWObCT71p98=;
 b=Y0/Sp1jv2wpR5U/W6Gmv52LCg3TT2KN1db1awBx8bcn8AYH/FCgZw2UJyAF/Yi1OzoqXFq9eIizF7ljXMub42h0U8m4hy99NEUFOZWJ4a7Yqf0F7gs7jtUIteM/QB+1gWiLbpt7WGhWOpI7CgxsOM8rj0yxuByYyZu7WrvWdb2A=
Received: from BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::11)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 00:20:46 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::c) by BN9P222CA0006.outlook.office365.com
 (2603:10b6:408:10c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:44 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/5] ionic: add FLR support
Date: Tue, 11 Jul 2023 17:20:20 -0700
Message-ID: <20230712002025.24444-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: db37c749-a273-4f17-f69c-08db826dd636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1O7pZ6mQzdbGv+0Nq5+W0rhnZaMR6jYDP0T1PWBPWa2GxsGkHrQVps09GdsNc7vEj0Iu+cVUrh1YAdb+imjpuYyqJpLVB+4Uo64DZQNkSnIJ/8xscDSPNLp704SUsoTFfOSOigA78x4OZgqY6clGOPTLgv0toCsfxR/T5KAy2J+CT4+tpci1VF05QwUjlSQPHvIPLPM91xSK+l9O/QNyLfvJmgk16OCgjH4kbKTijcxVJ/I4W686A0OFHRlM8OENfBgMcvzA+EtpxSc+Uu11NSrPsiWic4u2r5k9pJiaThsUviZ0pFtoDOqRKGHYk/A594fay8G4CtdYu9KlwMS7o6hWb/PTtoyM0D4cSwKY1cV5PeJ3WzEf6T05QwlVI0GpDZISQ9btagFkhBvZCc3jcHhsCl+vpbSWVjYO5ewYfjcAySmrk9RoKEAmdIqZN4zYOl5JsZh1u8ENO5zvqG2OZFqjk/JEGS74aYYUqUbNSz56fbSFTmQn4ihZL+mdjUSLXaATd6DdkuXdEUDMrOELxTQxh4oeFTKQTE8dHyZ5gc1hlwnBhqC7ghk44J2tJMlIc7K2OW9G+RCjlO4af8evbHzn8tsw5BIzyukuMd5SXpT1oIKzWQcSW62VZbXSFGDQclWbyHxHem5RAIacm0HYO/NYO/kCLQkMv+vEnkvNjcIdZ2L1hqznwall91379FETBHET4VH/Bv+4rC8lD8+/qV6D1H3suLTQOHZAcp2VDpQajqb8MPgOmpCtWPRGFIxu6fyXBoiTWOOYU1FpB+gxYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(70206006)(70586007)(478600001)(82740400003)(6666004)(81166007)(356005)(26005)(1076003)(40480700001)(54906003)(110136005)(41300700001)(316002)(82310400005)(8936002)(8676002)(86362001)(40460700003)(5660300002)(44832011)(186003)(16526019)(83380400001)(2616005)(2906002)(36756003)(4744005)(36860700001)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:45.9560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db37c749-a273-4f17-f69c-08db826dd636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for handing and recovering from a PCI FLR event.
This patchset first moves some code around to make it usable
in multiple paths, then adds the PCI error handler callbacks
for reset_prepare and reset_done.

Example test:
    echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset

Note: The first patch is cherry-picked from commit 3a7af34fb6e
      because it hasn't made it into net-next as of today and
      the remaining patches depend on this change.  This patch
      can be dropped from this series once net-next is updated.

Shannon Nelson (5):
  ionic: remove dead device fail path
  ionic: extract common bits from ionic_remove
  ionic: extract common bits from ionic_probe
  ionic: pull out common bits from fw_up
  ionic: add FLR recovery support

 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 172 ++++++++++++------
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  72 +++++---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 3 files changed, 170 insertions(+), 79 deletions(-)

-- 
2.17.1


