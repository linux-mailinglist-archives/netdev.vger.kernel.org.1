Return-Path: <netdev+bounces-41707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05377CBBE2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FF28174F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7A15AE1;
	Tue, 17 Oct 2023 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hc0BhGNO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F985168A7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478B83
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8KZifIVbrdTSpYK4Eq1RZZdo6SNpo2108n/1IN/8P8Yvp9zxVmvq1CgyDG5kLvgINp6rlwZ/SZIkDeB8V63zbNLOC/UjLdZgtNmh/IoB7dORSK/oPEUjhCvuIHdUfxbHnN9Migj6UMmexDNPCCIaY3kcL3zft7RNheDYu4J0c87D1+87Z2X9kuQhA/Vo7YrorPA8aX4Nlx8xlKFEhtPxvzuI7viLFeHwBZ1z4mnNrkK0JICO+TWuw/L3ianjUtQ9koiWV+iCHv+vvXCIRWctuMHuQrq5aN5nAkVobyTDo7kCuHXchOy2ZRdXiwVQgREzVqwdH3TqpM8xiucY8d9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvkGxaYVWhuK5yywPQ0S8DNtSiNUh32Camz0Vwr/V84=;
 b=dIbozP57DxRarmOhe3Fv9LBE0gOYFwyB08Meqjwft+8lKvBxCNjRUp+6f6b39sbmohA6AReJ4i3LYJuhJ3ncTr5kQLHbWiN9G3xhzh8JngoMpeEAvDSQC+cMc92DkQZqMoTSJ8am8F2Ky+qVDoMnnyxuvNKMpscuYVCV/qirSnI8h2rfCRLEWS60OAumAiBUin8IB1Ynv1kTwBjvuSga980X3FDBIOa6uNwdL9o1NfhbLbdrFmOLFHcwxXpeJmJnn0t7bSuhPSAJJB/MfzcTHQH+Ge2qfZtSQv7NSWn+F/Y5W7CiXT9sup+z01l1TvAi6D0LdyipwLNmtpFccSkZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvkGxaYVWhuK5yywPQ0S8DNtSiNUh32Camz0Vwr/V84=;
 b=Hc0BhGNOsqXYkzTI0ntql9TwYeqDDwcrTbB2wJomhKUGRzEHG0QJ1m17r2I7lLHNzYPtpCUWNnWcGAV7c/rLHI8ffXIwcDUrSQwk7s8cZj1hWse9Sarm1zlWzSh1GUTZMzGsotAAFDqlmgGMwatSk2VM8Ypmfqf8QuN/e/yRiL7nC/pQWEzyCg/xueaHj1OVyzTpArbhdPj23oAFBn+DQDXgyHLb0JAtG7eW9kjQsQQ28ki01Tfc3z/vo0pQOwvhczyllJkF0j2w/HVygNbkfhKcaE3AVXppBtEVs07Lw9b0g8CEdlGYxFKmWyFzXbKujOP4KuXNiVJ9qbHC1QHbng==
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 07:03:05 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::ff) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:03:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:46 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:43 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 1/8] bridge: fdb: rename some variables to contain 'brport'
Date: Tue, 17 Oct 2023 10:02:20 +0300
Message-ID: <20231017070227.3560105-2-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017070227.3560105-1-amcohen@nvidia.com>
References: <20231017070227.3560105-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f033b8-2508-45f4-d43a-08dbcedf1c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h0e/f9n/q0DISU37gaV7lBDymGJYxBC8Y03cjL+PjYRghjYjean1h8CJNuk7QDop3qj1YWBpywzfNX1fWDxSH7YeIhS0JWnedNf8CBxIIKoritp8s2Ov36KdqMQXtGH9RBUhERIZuaHMDsta+w5oEStNlRqAdihoOBfiBVpUl4SqvpPRXGnBMCICX+Mmg9GSYcEiz8akcZY71yL33WF6v4O3+GB6LfR65msHgniICq5pT2qQ3bJKLTtEa/A560fI1F5zy/Y81JILWI4s0H9y1R7N16FeMBIWlhQdTN1H2GbS6xU4DePuGHB3uJnQkj+pznWyvrdm1u8sYXuM/1hETw8wUvBsyZLdHmhsCphiCisC7bKBDxzue/gA4OaA4hiTEpE7vOSjCH5kRP+6BpDj2X8JxfK6OW+DyIZyYxaz4PU0U6RiPr7BL+Qy+giAs152O7NSY6hzbits4w49kVRiZ9de4Sx1WV9fAoJrtSVl7hetl4/ZJBRkMaAUwLE34fzXWK3kTXa0Kdu34j5BQR+J5QKg+1lvF2+RlLopHvz5shdRVIAnvbcrVCRy6t23uCFjn/xv/bPB2+En/+NwlObSVuE3ESbFCiIFATthIFdBDxyofmJcINSldkwj30lnlhxSNJP0yUAkFtExy2yUdiiOLnYCFoji8GO5l6PbRsYomUEKowxaZb4RnpazZveee/pC8HXQ7JQ4nvXuGrs08COuQ6aT/uZUWIy9uhiQHzDyaUI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40480700001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(40460700003)(86362001)(36756003)(16526019)(82740400003)(1076003)(2616005)(356005)(107886003)(7636003)(26005)(83380400001)(6666004)(478600001)(426003)(36860700001)(336012)(47076005)(70586007)(316002)(54906003)(70206006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:04.7394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f033b8-2508-45f4-d43a-08dbcedf1c31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the flush command supports the keyword 'brport'. To handle
this argument the variables 'port_ifidx' and 'port' are used.

A following patch will add support for 'port' keyword in flush command,
rename the existing variables to include 'brport' prefix, so then it
will be clear that they are used to parse 'brport' argument.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d7ef26fd..e01e14f1 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -696,10 +696,10 @@ static int fdb_flush(int argc, char **argv)
 	};
 	unsigned short ndm_state_mask = 0;
 	unsigned short ndm_flags_mask = 0;
-	short vid = -1, port_ifidx = -1;
+	short vid = -1, brport_ifidx = -1;
+	char *d = NULL, *brport = NULL;
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
-	char *d = NULL, *port = NULL;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -752,10 +752,10 @@ static int fdb_flush(int argc, char **argv)
 			ndm_flags &= ~NTF_OFFLOADED;
 			ndm_flags_mask |= NTF_OFFLOADED;
 		} else if (strcmp(*argv, "brport") == 0) {
-			if (port)
+			if (brport)
 				duparg2("brport", *argv);
 			NEXT_ARG();
-			port = *argv;
+			brport = *argv;
 		} else if (strcmp(*argv, "vlan") == 0) {
 			if (vid >= 0)
 				duparg2("vlan", *argv);
@@ -783,11 +783,11 @@ static int fdb_flush(int argc, char **argv)
 		return -1;
 	}
 
-	if (port) {
-		port_ifidx = ll_name_to_index(port);
-		if (port_ifidx == 0) {
+	if (brport) {
+		brport_ifidx = ll_name_to_index(brport);
+		if (brport_ifidx == 0) {
 			fprintf(stderr, "Cannot find bridge port device \"%s\"\n",
-				port);
+				brport);
 			return -1;
 		}
 	}
@@ -803,8 +803,8 @@ static int fdb_flush(int argc, char **argv)
 
 	req.ndm.ndm_flags = ndm_flags;
 	req.ndm.ndm_state = ndm_state;
-	if (port_ifidx > -1)
-		addattr32(&req.n, sizeof(req), NDA_IFINDEX, port_ifidx);
+	if (brport_ifidx > -1)
+		addattr32(&req.n, sizeof(req), NDA_IFINDEX, brport_ifidx);
 	if (vid > -1)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (ndm_flags_mask)
-- 
2.41.0


