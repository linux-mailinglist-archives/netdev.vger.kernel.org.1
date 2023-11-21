Return-Path: <netdev+bounces-49772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25697F36B6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC255281E50
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892C5A113;
	Tue, 21 Nov 2023 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5uGKiNY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B90A91
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:15:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGTvRTTrQcCawAuW2+Iv7rhq2frdZ9GnlaYNicRau6j/hzXgzRvGJpZkcZ3gGPwvNgqoYSAzPP56TNcqvtUkgMv5w+tEZK1ewF61xlqRnZY9jhwBc+5JLsvNZjxLyAWocjuhBw4LefHZng4jagIopIiZxqxIShEPNRQfsOhnxvPMiW31cc2+wwv50ULoX9tUdR2IxzbWfOvMCzhMTqybSQcgiYwJLg0byaoHkE/hpQbJM7/W2fE1MZKAtHmzFqnTFp5HPG+DUUMESdPI0aL8Hsa6Mps+Ht/r4av8LYUjOQir/UoVki58xtph/lHWTTymVc6tmzHWRjRGfWrrXGJm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBr64ZilBOTLiMJbkHeR7JSiY3tDPBNzBYrz3fxz/AU=;
 b=R8bSBEHuTk6wTjkTpzfMLW2OBMgM9tBMt2Hmztd92Hc2yNEuHqYSwOITSp/C4csxhmhuzjy5mwjILBV4TbAbv9vYL+FfVCkp8+4r2OAjzqKuaZmtjhIw+HR16zFiCBelALROmlIPvuyKgcvfJ/yLnhi5VMJhp1Ta0k3OZgc4rkS0QTuWFjzK1w2uTt7qo+6o9vfWO1IJ81YmWLCFwWmjaU2AzcEhKvFI089E643HKXd4IIwnjL2cm0WttzwsUulsUah6zdRKPApaCQhdxRVi1RBDpSi6s1r42570U8DQOaq4ZF59AEhGvV5XgQbhYVTvO9ad+h7Q0kkfiUKQbMZO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBr64ZilBOTLiMJbkHeR7JSiY3tDPBNzBYrz3fxz/AU=;
 b=s5uGKiNYv6Veq5VFyDOy5kIXo6QT8tMNPYxiyvQ9EBo2+u4n0nuFYcRTckPBdE/pnykWfwaYEgI5VAppH9AY148tHZ2xFPVg2MMVJZ5UxGVIaj13TebV1hbs67Fe4mhCbYb92LH/57rQ3CTiU6p+dZ4Dll84Y8jZ7f6P7WLbaZc=
Received: from CY8P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::18)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 19:15:13 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::c0) by CY8P220CA0020.outlook.office365.com
 (2603:10b6:930:46::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 19:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 19:15:13 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 13:15:10 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 0/3] amd-xgbe: fixes to handle corner-cases
Date: Wed, 22 Nov 2023 00:44:32 +0530
Message-ID: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b44ce2-906b-42cd-1dea-08dbeac6301e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CjZRSYsaJXk01MCY52BSqO9lGpoiXNxd67R7CaM9l8Yx1AYcQqPjU4DbjqpgYe2kQbFcidfyB8CeifgIy51a+t0Ljg3+WFw9Aoxlu1WSkyi4XzgiH1OLi5Ff2D7swPqoyyVbF9ObiiZVeNxWslS/4A4wGBOTPcvkpzMr3FS3zIO9v/zMDkLkb07byhkVoG2787HDq6284liLfdum8jnZ78r4B8BbRQZkzmtZTz7gZYjpkgbR2zwlLwQTx3fYN4t11JA6xVrm9IHbGbHVWtB0QtH/6/qkNhs/Ux1fBAgYTO9pQYXkkoTvwMqpcg+gD4HgJCZutCZGvHsq+hcdqEr9L1CrUJBZZF7G0/85/n7y90BOSH6ZGMWR5Wfrn2wisMHZZf7t8QI0nFwxMVJ7WVjLyQroW1UPc77s+jTO5KU51O4rd0dZVRoN5B0MN93IDol/MaGiOPJJaFw/mlLQ4o6KhjvolDbi6dt/Zqf9xLfps6ScPvVJ8mAMxX2MBtJYGt0+qFibc7u5z3eNMNzE5LTP1DhzXvw2E+eRHB7DGTs+KenVMOw6XmE6gwBXv3CrITZC5zGkSZ/w8kwTt8u7R/baVKpkOoB7Kr2fzH1DzMPneyFsTGROhGmiLv6A4bgWrTqm646DNfwN7Bw9sQJIII8gN5r9GaFOBXoM53UIFCu6SUSh8NUPpzJ+0ZCD1VRFXl9DgGC1RyTg/gCVRhV+UXgpZyHO7Z8nzkIHb4tQu1JE0+DdJcx5jzv9cCNxviOmG0DR3UQvbfROlAW84OAhwq4pkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(316002)(6916009)(70206006)(54906003)(36756003)(70586007)(7696005)(336012)(426003)(2616005)(6666004)(26005)(1076003)(478600001)(16526019)(82740400003)(356005)(81166007)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(5660300002)(4744005)(2906002)(4326008)(8936002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 19:15:13.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b44ce2-906b-42cd-1dea-08dbeac6301e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

This series include bug fixes to amd-xgbe driver.

Raju Rangoju (3):
  amd-xgbe: handle corner-case during sfp hotplug
  amd-xgbe: handle the corner-case during tx completion
  amd-xgbe: propagate the correct speed and duplex status

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c     | 14 ++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 11 ++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c    | 14 +++++++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.25.1


