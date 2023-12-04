Return-Path: <netdev+bounces-53610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F263803E49
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506731C20992
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF731738;
	Mon,  4 Dec 2023 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cW49V5lM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1A109
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWyQ9cJRJyzTqdM7Qk9nDnHqcHLhcZaZiGbqmfJyK0CCft8VUAzOwKYqNgrMUov0pn9vQhIoDqmzbd3DkYr6A6ZC541RMtIo6j1liyTsPkXnE5rDBJcXlqzWEuJz49kaH1bMVIWfOZNQ0BPv999OESmxLhIMiCWJ8pdkwTzRNYz9iTO+jPq//V1X3gHLL4nJieC3utW9E8fRL/05r7nFflYvBsWIzxdeLNkPUSH8T+8tVRAjXc9XaZNq8i50mdIiGhSheWPCVlF0jNoUvglkKj0b62gcvZEx3rSrNjMfX76Vgqa26v9G03HV1+TMvg7D6psQjvDn/e2gteC0/H02Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTlLdb7QqAUrmkDxfOifmUuYWId7YcptUuvMyv3L3G0=;
 b=WgvovhniplKPimagSM1xUtNBlOOFU2BzL3ifz+mN8zA83A8qkuu5wJ1NtxcrKpeYK2n0lQL2m0MH/hNbFBxghxMsmfS3hxOtggWiSnXr97oP9+EP/VoYCCe8SODruEpOdtn+se+vSQNIcJwpWV3mc0wZ/pFaKRG1K41PN2Nb4OB03Gj5He1OANl0157bJZ520TrqYXyOfmDUTLh22QG2COw6d5DRaNX5dxHM81xHesDCdoweaL1xKcKWsMDta2UKOSVxxikx1oBJ1Wu3mHsWka280SWsBFQjaEXixV2KY/RDIXG53F0t1STlE3XYePPiGlHGdt9VDfvZoLFUjNDy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTlLdb7QqAUrmkDxfOifmUuYWId7YcptUuvMyv3L3G0=;
 b=cW49V5lMeQPCquGT8G28bwdqH2ejE3czSuMPgPS3vTXgAp1uoIip2UgTA1li6izXKQJkNs4tpiSPo9osqbRIUdEMbDNiOJLFWmN8uzx06OYIuOq8Wwb52DDbEwPPRJ+Q8sboo+LS5AZRUQiQmOZniBeqjzNlGa+EnjVHRsObUCs=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:22:53 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::66) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 19:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 19:22:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 13:22:51 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 0/2] ionic: small driver fixes
Date: Mon, 4 Dec 2023 11:22:32 -0800
Message-ID: <20231204192234.21017-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: c710a643-8f04-4a64-4738-08dbf4fe690d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SPz4dKD2abZM9SHgWIQuH8t+0L1K3PwR11296jpEn/llwv2/tjIDmwpmAcdEDo10HtH3kOj+bADEFexn8FKpxrz22/fTjmuoMD0uaWSSNErDzw6zas6k8FwD09QV3EC9LuJS97Qa1nW7Ay76HTbYOhsjMB0UdnXJ9XHPPqiRcM/2AVGEWtiedRD/t3MGi7QbbmSI0KU+KxxNP2Hxw+BpMgncaA+nRFoo0fraJr3aoVXcBaSln0jtzu7Gud+shsch2YiLNeblHvnYPj2M4Kmw2CVJsdhreqluAt4fK0LyjtPQCYBDEHsPY9DwV6kw6+xTe5h5tbIaAlgyLz/aRxN59Wqlgx+hm5qJqGro37kHcEbhk0BV5o/sIRDznpEv2XXK8BDYTisShgLqYNRcpQtmYiqCBv1K6oMBObpmocdpIaESSYk31FOzDO37z3i74nTgXguLwv6U9FoBmxOD27bPIcpoy7qtX7mnZy5LaMbqYMRsKm3ohkwaVeoCS30J+RiZylXhsj4/x4k18Kjndpw9UUq8rOIuX5yXks0KVFSzsYP5twLHYd79SW2ru8qNs1Kpya7XvH742PX3jzOaA2pt1HNmuQSnv94q36S08xSgw+fRLhYcQSnWqPB+9qkJ6TSQiqKfS6mHqXJjY7idoRJudHMPR0USrKd5gAOJZOQO1VtFXkH0gKZCP+T1X4hSVGyOGa/PMunPgmd5gpFz1XiuNSbydx8PvDa6L+5WuA3OiHKwO7AkmR51dFliMXcmRbKathnEZJ4aMG9xknwAA0VT9n84hSJ8dgeScjXkcARb+rkDsyPbsCK6OAPSRzHngvZL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(2616005)(4326008)(8936002)(8676002)(47076005)(81166007)(40480700001)(356005)(83380400001)(36860700001)(16526019)(336012)(426003)(82740400003)(26005)(966005)(478600001)(40460700003)(6666004)(70206006)(54906003)(70586007)(110136005)(316002)(2906002)(36756003)(41300700001)(44832011)(86362001)(5660300002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:22:52.3624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c710a643-8f04-4a64-4738-08dbf4fe690d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195

This is a pair of fixes to address a DIM issue and a
kernel test robot complaint

v2:
 - dropped 5 patches, to be reposted for net-next
 - added Florian's Rb

v1:
https://lore.kernel.org/netdev/20231201000519.13363-1-shannon.nelson@amd.com/

Brett Creeley (1):
  ionic: Fix dim work handling in split interrupt mode

Shannon Nelson (1):
  ionic: fix snprintf format length warning

 drivers/net/ethernet/pensando/ionic/ionic_dev.h |  2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.17.1


