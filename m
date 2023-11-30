Return-Path: <netdev+bounces-52531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAA7FF102
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F05DB20E33
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6525482FC;
	Thu, 30 Nov 2023 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3tEDy3wf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF686B9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZM/WMfQoYErSQwph/qVl378YWjb4XSFjdX3CTsil6aUPvgyFbW/9xBNmJpit8O2IcpUY9drpIE1Ruy096OcTzmrFCmYNW/zX3ozD56cFGvYyr3UIWNyGsxPE93kxf7L5EuU2TipsniyLxfKmOPKopaN8RaeM5tQem5lQlRYpqHSRNMOm8h8OF/cstdYjS5J0wkQ6DXu4GQr3A24AnhUQzW0fxEZNsZjOk3ExqHHz8RJeCM84HHTdfdTwUeEGFD/e/YpDbVu1X4jkB74xRp4vlYvnylwS2nnEyfeI8+ws8tEUvlaEnHEft55E0AYbB/L0Eqc5AgbIMPiIJedep4L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5ikstlUZ9dFV1rFOmQx92yI9ALyAVvoKoLoLwbFGEo=;
 b=IbYZlm8l0AEgizt+B3JsTnH1kIC6JJEJG6b/41ony82QiMLTZPgRMzsV4bhVsykV+4HP3nXBP5veE0dvwCEPncWxRuVXpFj6Dn+dM0aQgUtL/xozCqzwqnifKq6yWsC9C1S3uBooQkTwgiqQtQuegbNEGMSv171RP3Mevq55an8wYtuJxFoaiguE0HAerdB6zjfKwsoA0U5JRLlLsSmcpkeNGkwcSEXeLDi7fcfKs2wTFrMBRIbrt38lVvlpukQUhEOHLNPVJF59PRfx1uNWuQKWAmW/5rITyq3rHPqYjrGaKDy71CGlnI83rccqSOq1xSETYpNk0O1MqcDiyo8+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5ikstlUZ9dFV1rFOmQx92yI9ALyAVvoKoLoLwbFGEo=;
 b=3tEDy3wfPrCOcXVpLFB+GckrQOXTDtpXEuJ1y9+oQNzvTTHfaY9Jke2DhxADnDSFlklMo6C9kmHkIApJjDMIBPtlJo3gwSQC+Fklg3cK9RwBH+Xk2JpHeD6kPlVoZ6mewPIyasoCOZoT8fxhwUJMvR0VqYu/dNGZxzHnJ3lDuQo=
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 13:58:36 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::f5) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
 Transport; Thu, 30 Nov 2023 13:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.21 via Frontend Transport; Thu, 30 Nov 2023 13:58:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 07:58:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 07:58:35 -0600
Received: from xcbalexaust40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 07:58:33 -0600
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <lorenzo@kernel.org>,
	<alex.austin@amd.com>, <memxor@gmail.com>, <alardam@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH net-next 0/2] sfc: Implement ndo_hwtstamp_(get|set)
Date: Thu, 30 Nov 2023 13:58:24 +0000
Message-ID: <20231130135826.19018-1-alex.austin@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7f0dcc-cebe-45a8-d318-08dbf1ac72a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uEBmRao9+P1R/SxJ5EcxvkkzIrWPwcrHlkAqZD3WTlwYPv+eh0/7+VWfsZDJPwGes4rRtPJ68aPWSijTz42YsVlfpWxjwQuCWxuZbxL4ppSXKeCMHCejb5BQoQfr/URTyGGptZrpKfRBYNuxD689JMUIZJ+QBdES5VyV8gP8Liru3aSJaYhRRgg2VbBQ6DEN27j3iCK9rKNs6J4sPwgr1pHgPo2duONCHe3Rb7yx8ZioOKmSEmFnSeeIYa2ym9IIh3FFW1vs9am/dKYoQR10YHZZmbTXq+LsM9YzkfW6gzOO8MnDeRqFOT/8vWKbCM78LT9dz0on4DOPvbaITuDlD1/iFG3Iw6ARUzM4ESiD9P7YJ2skOjFitF9FWQ4BCT+Rv1k5Twy46TSb1I3SpViFQ/AHXYl338CrLAzuC3KvGdAtcFLpjB33g1C7Bq4z/CLJcStX6cjIRvIb6ESlV82iTHNjYU2bdq9umFjJV3VFGLQJCtC+AoT3OIBdoyFBCZ6js+HjcVfNL7qRbRC+Ajg4fmWMZMy1J2rQTJKTu/y6MC1Ucl5FF3tED+HM9s4i86d/C9Xz1uqC6YWLV+F817pSdDjkl5TsAUIVMO7kNb6eu1LR6ZA67FgLbW0Hq8RA6I1i/MzL2XODab60Em/bIYaLyTaWAL+xXUD04H25tkuZZsHj5+eGjqZHnZg7Gwux9u4qT+hp+Up/kOEq1aP3s6RW+XvLU4iDLzrwQf6+rWtb6sX7WCxCEtdNUtie0baRSPL2VOzk3Nvc6Gbkp+8r2eMGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(47076005)(356005)(41300700001)(2616005)(44832011)(4326008)(86362001)(8676002)(1076003)(6666004)(8936002)(5660300002)(40480700001)(7416002)(2906002)(4744005)(26005)(110136005)(81166007)(478600001)(316002)(6636002)(70206006)(70586007)(426003)(40460700003)(54906003)(336012)(36860700001)(83380400001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:58:36.2530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7f0dcc-cebe-45a8-d318-08dbf1ac72a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

Implement ndo_hwtstamp_get and ndo_hwtstamp_set for sfc and sfc-siena.

Alex Austin (2):
  sfc: Implement ndo_hwtstamp_(get|set)
  sfc-siena: Implement ndo_hwtstamp_(get|set)

 drivers/net/ethernet/sfc/ef10.c             |  4 +--
 drivers/net/ethernet/sfc/efx.c              | 24 +++++++++++++----
 drivers/net/ethernet/sfc/net_driver.h       |  2 +-
 drivers/net/ethernet/sfc/ptp.c              | 30 ++++++++-------------
 drivers/net/ethernet/sfc/ptp.h              |  7 +++--
 drivers/net/ethernet/sfc/siena/efx.c        | 24 +++++++++++++----
 drivers/net/ethernet/sfc/siena/net_driver.h |  2 +-
 drivers/net/ethernet/sfc/siena/ptp.c        | 30 +++++++++------------
 drivers/net/ethernet/sfc/siena/ptp.h        |  7 +++--
 drivers/net/ethernet/sfc/siena/siena.c      |  2 +-
 10 files changed, 76 insertions(+), 56 deletions(-)

-- 
2.39.3


