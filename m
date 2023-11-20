Return-Path: <netdev+bounces-49335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C42D7F1C57
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261F3281706
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9730D13;
	Mon, 20 Nov 2023 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byW2Vm5D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31894C8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:27:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXADv8otmZB57NjyhdZpq0WiEdJc/iQIu2Iy3sv4QNKEFCHfzDKIDiA71tbemv9L7Bg1Y35VgXogbcG4Y0ozFr3NWRyVkm10QidJ9DagcBYj+TCCOOmU+oY1w2mpv0NfEirSD6KT/hQUTCbKo6pZfE7fVFZX+v5JfsK1uGzQlbXJQCkQFsJWzDx9WV7bBns6ntWrZyWamZv29cFF8fWndkkFE2wNZ2XvMDU42cP7YcAy4bgSWPhn0ey6G7seXqXaYkKabloLm2DXQK/CxRu8wx0coQRep5DvHpreb++sx/6yvT9oQEUIPk4n+bDWAKC796/jEMCxYmBrHChu5NX5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcD1x0w+Y/37J6Hqp1J9lP9qEJN3W2tLoEnEfBR0Cds=;
 b=I1YEKXqfi5G3ojHU7gtSVSS4odIbUAM6bQv/cPI942RK9c13fiND7NtGeSDMpDRP1vNl8Cm5gjp3kwTnbMQaeSZsndlfJy8TkztOqVA2/mKcRqzGMDMLJod08QBP5nAsMOTnRHWPsAHZg2vvnJb+WFvi3PuGH515WIyqCFhsWa42cjLNncoJ0PzmzWYRBz0H76IDOirNx+JeGllas0ipifjTDWJM50yidVVEqkUFCWnAvXQA95vEx3YdIqgIX2FZvh1yMT0FmXPcEfvyOnEuPi1t4w6ciEykQCt7WYDfsF3Gx+j/hkal7DFCSomqSlpw1AtUJPsQqMfQoa8jawu3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcD1x0w+Y/37J6Hqp1J9lP9qEJN3W2tLoEnEfBR0Cds=;
 b=byW2Vm5D/WzmQpGXsCJ21ZQl0UP3ho+zuPww1vli9oyghTECgcG4s/PZ7wYznNs5Z3Q6BKqpSFaXD0slm6ajrFYbJWdgiNzfKX3RTgkt338nelpIyx0fD47tuLkx5N/a4ZcV0OfoU1xwIdzp8y1jqJIdBYZ0tFMadgk+/ADEG6YtuZ3SfZAHsYpAAE+shOn+tOYJbY8nT0MosciC4AZporo7ZXagYvi0EQ+bKsmDU7HJ4UYIreF4I24uENx0x+id9ELmIw/2rDY5Hlhp2nG+Y9LuxxUm/ALIjrz3y2+lILsyc26P/rJpxNfWJP3AnQGOSGufZYeCWcIvjGrfrXUqZA==
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:27:42 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:29 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:26 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/14] mlxsw: cmd: Add cmd_mbox.query_fw.cff_support
Date: Mon, 20 Nov 2023 19:25:18 +0100
Message-ID: <af727d0e1095e30fa45c7e60404637cdc491aeec.1700503643.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: f61d711d-f194-426d-7c83-08dbe9f66232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpbyHhjTUdZVQ0ItID95Sfwp9D0YG/vw/DiAsN2LLjx76iicfA8jEBwuwzpX0Q8HloHjlsyiyW+xEWHieMd7RIUgCmaZcQgHL+N+PzeVZZNZqmnw9u34XwFdNY9ZgVQrk+r3SFvTPzWdPTUaYP5jUcduVXSa49O4k5RCXpRe4kJJH19u0DyZeT8RAqeHGdAAtM3xo8SEt+rjSpDsmqP69tRlQCyamlcynV3RA3LhPwtOBouYCwp0vLMNTabic/2Ef2Urso7Mji7C5dtpeV7/a1fDtas+UH2qzQgNzoSeGEiXJqPAWhtLYl2bRIeU08Vuuy7OU0fA94zt6bzJ5ArJaQprwWorFrhCEqSsZNk0X7YgZSlU/NKBNOUSd8BDl0a1YLCAyl4UiAVP8Kk3E3TOIGmLlcI70E6Va8kWzXRp7hkaNzs1URj3lpPY+60m0+KcXaPo8gmW4s0YwyDkU0XQ+KvvwxoJwg7xZGHfQ6Vo6ndKtzjyiesfEE/vpzOX4NLURCmFYJdDuuSu6ymZFYR+J0TEvkrWyxKrt4SxPXr0yKvdJaY6UkxkvUWlff3Dw5B98QbVE/EQMS91uGWDIepLMGHIxK7fxMWF39UQu35ORDVibVVr+voQzLmcykNtKQu4WVu2Md2Bm1qWjIRhn+fBTefgltbISXWu+hBjw1TXHziDCeKEeNxoP/s+Gfs9sQqENNa+qSPJ1QTY+n97SiPElJB6XK20yMcynrk25l1ni9X2ExdLyJVjQbpg0fQw4flE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(16526019)(107886003)(6666004)(2616005)(36860700001)(5660300002)(8936002)(4326008)(8676002)(41300700001)(2906002)(47076005)(478600001)(336012)(426003)(26005)(316002)(110136005)(70206006)(54906003)(70586007)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:42.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61d711d-f194-426d-7c83-08dbe9f66232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

PGT, a port-group table is an in-HW block of specialized memory that holds
sets of ports. Allocated within the PGT are series of flood tables that
describe to which ports traffic of various types (unknown UC, BC, MC)
should be flooded from which FID. The hitherto-used layout of these flood
tables is being replaced with a more flexible scheme, called compressed FID
flooding (CFF). CFF can be configured through CONFIG_PROFILE.flood_mode.

cff_support determines whether CONFIG_PROFILE.flood_mode can be set to CFF.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/cmd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/cmd.h b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
index e827c78be114..b45c9a04fcc4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
@@ -282,6 +282,12 @@ MLXSW_ITEM32(cmd_mbox, query_fw, fw_day, 0x14, 0, 8);
  */
 MLXSW_ITEM32(cmd_mbox, query_fw, lag_mode_support, 0x18, 1, 1);
 
+/* cmd_mbox_query_fw_cff_support
+ * 0: CONFIG_PROFILE.flood_mode = 5 (CFF) is not supported by FW
+ * 1: CONFIG_PROFILE.flood_mode = 5 (CFF) is supported by FW
+ */
+MLXSW_ITEM32(cmd_mbox, query_fw, cff_support, 0x18, 2, 1);
+
 /* cmd_mbox_query_fw_clr_int_base_offset
  * Clear Interrupt register's offset from clr_int_bar register
  * in PCI address space.
-- 
2.41.0


