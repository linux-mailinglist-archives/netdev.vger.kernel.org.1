Return-Path: <netdev+bounces-39494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCDF7BF810
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092621C20AEF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82917754;
	Tue, 10 Oct 2023 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjXS4gFT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4661798E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:58:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2DA7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDPWczGA8n0GIL7r6caRCY7ietfiyfW46JN8dDwHRhB1YGtUGNnjkuljmV4L+wvEnsgbLMaAgUo4hzGJ+1YzxiwyCiWXbRnzFQiYtCqFTiki3n9Yqogm5HKA0OflWf9CW+VIIR1RondO/phRrCDrfzPP9TIzRGPN/O0lWkdLovLXuFa4oy9QUk6/ytmV0Vpn5E3swkb52IqeOqFVKPyOPqs09EqYjBG7do+2huXTDuMGfheBXlHYWJhuuPNdFK9q7bB7ursNM6P9gbSQpyUDUwTBL+Gcsxv5wdwsHyK+NPug007CV8ZJk5nBORI76jn81vXdi+VsWCoHAWL84LwwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta1ScyEwFXvjzlme6jDlYz7mwWhGvnyAIC0p5uQGsJk=;
 b=QW5efqi64eVU9vOHAxkUfxtScUMzm02sL5FALlic83EdT3gJ43k/v8IFJGHI92ZqOrfTsqy2TRNZQ6G9n54GshEPcZXRPdwriBePPE78MJDiMM19i+GcAq7EQEb9JpDz48xDZr0Mp6/eCiWeNkveNciyMLGeh9YXUsSCU+fawLHCimC34PlBT2cMfWAQiPjWmckHofRyKdr3eppMCJySRroDdiHFGezefl6E9MTLaItgxm1pxn4H3bLogxiHJm8v4ekct6I+nW9j39RULSgkePYih9CSN6MKh6uVZzoxe7tcfYMGlvGDsyTV39b9ylkvi9Db9+FKg3SqFFHPhNUdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta1ScyEwFXvjzlme6jDlYz7mwWhGvnyAIC0p5uQGsJk=;
 b=LjXS4gFTZnkbe2brzxKCyspkW1SfpchPc+A2ahMq6GtxWDTTYUJ/Og/y6iZdupPVvhbcDNSw03imLXcI5KbDtwF9ny++Z2xLUZO1J/JqiJ7idufnuHEKnEVa6mgSv2UGgyY4hI5GwzWiDFQRScJJbMd1BLGNPHhpEbWGBfGiFlLS/q2tHVCjer892XB0KMecLwCBJjZ1iwNrzRGaRIUwh7Ssp58l6kh3Z8BLlywMksoASYGqnnKdxj4qTwN01LthppEz0SPWzZPtuxN8ILK03a+hi+o++6teq52g9OLPwntlME0A6j+fKfxszjF/243pjhHtuoqNtudZGtuDSrrRnA==
Received: from SN7PR04CA0081.namprd04.prod.outlook.com (2603:10b6:806:121::26)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 10 Oct
 2023 09:58:17 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::90) by SN7PR04CA0081.outlook.office365.com
 (2603:10b6:806:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 09:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 09:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:58:07 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 10 Oct 2023 02:58:05 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mlxsw@nvidia.com>, <dsahern@gmail.com>, <stephen@networkplumber.org>,
	<razor@blackwall.org>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2] bridge: fdb: add an error print for unknown command
Date: Tue, 10 Oct 2023 12:57:50 +0300
Message-ID: <20231010095750.2975206-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: a1445fb9-73af-465a-e375-08dbc9776d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7N+WX2yqbDhQ9DaMT9xoJ2LMW9ZoPDdNVs5fW7PHDN/iNQV4VPf9PMpENw35pompBIGwKkj8jY5YijdKO+8ZsfL2ho9Lkn6Q/z078S6QgIhqekd0PZrvDj/gcqQgQt3fYxcwF+gNvezWFB4yjc6VMwS69QTcCoj7XfKrswqnHcVU7h8XkjuxT1ePxA0iHCg+tUGz1lZBHyf/LM80xukV8mWRbUYgTn8/C+zyD3HgDWZOR9/8C9bZlo5u/JH+Oxe51xJA+5FL6Ort6VhiR5ij3e3DFWgzw/Cl3VJ/gtNpNsTV+fTBSVvXEN8uK542af5tpHDWgnJjdOsubVW+JFC5jCEpARPRHn1lA+NjNkSjWoJpOeWrg/5QWGx194dOhBI/EH+vgWqHccz8xyS4Y5/NNwlT80is48FdlMiu8tJAkpTycq3UPqEurdkjHl+Z7lce+FDv+jkb0Rdx4UEuE1nCVIQ6lgW463hXMJLZGeifm4aoeeYnt/sqgE9Y/KKslXbEUpUu3Bu1/U9+Q+PfB962LvfShnZfSyw+9RbDzI6OpXNAACiuW7L56702naVtdNBMxsAPsxtYweKcCYX68JpRccEWBBTmMdhSmZ1q3phnra/vI5hDVzD398IaEkGDvcS5JxN9xqspTXTjG8B4yWNO+bPk1GjjtchBbbB9nC3Fs7IHsV5sI1fWXH/KAU3Hm6yYXrjxsgY/W2dD+pym8N6c54J1FeYp3ce0pVJrWgBClqGo7Mho6b21bnffbBgM//JH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(41300700001)(2616005)(83380400001)(356005)(7636003)(316002)(70206006)(6916009)(70586007)(54906003)(2906002)(5660300002)(40460700003)(8936002)(4326008)(8676002)(478600001)(47076005)(86362001)(40480700001)(16526019)(1076003)(336012)(426003)(26005)(6666004)(82740400003)(36756003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:58:17.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1445fb9-73af-465a-e375-08dbc9776d26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6e1ca489c5a2 ("bridge: fdb: add new flush command") added support
for "bridge fdb flush" command. This commit did not handle unsupported
keywords, they are just ignored.

Add an error print to notify the user when a keyword which is not supported
is used. The kernel will be extended to support flush with VXLAN device,
so new attributes will be supported (e.g., vni, port). When iproute-2 does
not warn for unsupported keyword, user might think that the flush command
works, although the iproute-2 version is too old and it does not send VXLAN
attributes to the kernel.

Fixes: 6e1ca489c5a2 ("bridge: fdb: add new flush command")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index ae8f7b46..d7ef26fd 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -761,9 +761,13 @@ static int fdb_flush(int argc, char **argv)
 				duparg2("vlan", *argv);
 			NEXT_ARG();
 			vid = atoi(*argv);
+		} else if (strcmp(*argv, "help") == 0) {
+			NEXT_ARG();
 		} else {
-			if (strcmp(*argv, "help") == 0)
-				NEXT_ARG();
+			fprintf(stderr, "bridge fdb: unknown command \"%s\"?\n",
+				*argv);
+			usage();
+			return -1;
 		}
 		argc--; argv++;
 	}
-- 
2.40.1


