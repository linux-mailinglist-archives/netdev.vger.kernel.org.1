Return-Path: <netdev+bounces-25306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC500773B5A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086E81C21034
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D114AAC;
	Tue,  8 Aug 2023 15:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6F14AAB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADA1FD2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U025Sk+wABoqGlJHoi6Iu7mLBxLVxQkhVijpS6UqoPj5xo6oGPxag2f8QiGM7cr1lPLtu37SoAb9FDJ5cDu68ujZpfaHvdYH1bkY3PrX2WcCjLS21PQgc39f8if8X1xfPrIrtEAedvJ3vXxaUglbYceYqvSGEZV49yh4Pj+DtOul5NVPDDHZljQ9xaZ7GmiKVKgpzBP1i3/drvkA4ZpMJTNtpEHWO5VkiF1P4RKIa6/GEV2EtXJd19haxxHnRancgqOxiZwOtu1macolaJjFK/HNXpxD6+fYPNofvN0SHcah2FVDBc7uuWygWZ8hbY4vL1YImK9zCbRI/rHO/IxG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY4LdH3HUJjXdfHMOCXvQlivPPQzWf2Vzu6e96uaQ48=;
 b=JewKV8dBu45v5hByJnRiCl7Fxi+EGf35xSDZASoYnhZWm7paBkfkuuVPeehOjt2CcXxuw5EyYvWQ+Zia58OZ5P9/nkz1RD6ufrKPuFmWFyIHEhkK8X99ytnrJK6GUtpeVKJo5LqXZ0F9Oqxw513fgOLKfmFDV7SDIrKuCy6croyUnK71p2z1peYTsFxzFy07GHJzM7Ce7/xXXoK+T5Fo5Ecp3vcpfuUZB7aKPrK+tpsLcsMwFbhaFHmY9mO9Cft8ZafmTrNpJ+SgSILUaeMS15qQDDBfYuWXoICp31e0OLthEqBfcOtXKnSUZ+T1z/FsQ1utez8bPdcB6gnfVW02NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4LdH3HUJjXdfHMOCXvQlivPPQzWf2Vzu6e96uaQ48=;
 b=eCa/htmDqvubF0gcgM3wADZRhFPIrDnSZaTcV1PyejMGLQ4zaViBYrF4XUp9ErSE6EUHFQd6fGat8TCN8vkKCO85NyN64qKbhlQAMJ6kd3pJCuamRI0iI+JsRJE7z69ZXvh/1x1tWPRAKfcnNjcwnCH0L4yo7GjENQepiUQ+K+JH/xlXcckFaPHIM/Lf0WBYJP8hl77tvvuzaaLyMvSkRI4sUDlVgo7DeLb4wxdNJ5Yx+gkwBaWcj69zVWJU2JrWYWz1NfK96a7WUYvdYVY6gROLpc+lGif/toNay7vR4LWUcMpYMxewS7GfYFuUcrDr9ooqL84NLPm/3EdpyhfXtw==
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:34 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::a4) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:21 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:18 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 17/17] selftests: forwarding: bridge_mdb: Make test more robust
Date: Tue, 8 Aug 2023 17:15:03 +0300
Message-ID: <20230808141503.4060661-18-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: b01a41b2-ef83-4787-4ad2-08db981a1236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hkMumO5Tzm+MmdFCO5FlANVk6Q5KA+kt+xBlOtalerMh2uM7nx1fvuAnqAPoCKZS5zlG/OkAwwSEmQBNAxwDfiy8cLRzsRRQHyGTOtuSRW/R99eRX4MvPco4W8WhP8h0vg+duNusZ5RV4+idaLda7mrlUS8OpbgiBWkZu2FxCmJqJtsyHL5APiym19XahIzqVZrjfR7pDG/h42Jgzp5Xxa8xk+sLtOV+Kgb8S0RsvaThJ9JLs1s30p6NuYtCznshrWj9fowjaN2z9yChttSRAlnHkXInDd+whNHHIOhLaOKe4iESc80RJgx4VblZuHGr2w3QSPxXEf349u6sG2dCUD3bi7btAicOul5rt7C3eEI0MMcG9LMGfDJKQM2MP+NFPA+SnjKJWXzZEZQFTwFYUknG1rbqz3U5JeTNXGvATBuEdKZ1GItVCILa7P3KP4QdJErjZkKcqCxH6lzfzslzU2bksEBwKN6d9vd8/24toFNwfXqhCRg+XYLxGRwUd3M4+4Auf0uZSNGEFT6llrrxo0IMUmLXbWPVXKckFzgSb8bkMhd857yNUfAUOSbMw/J7a4FKis5hnsthSvX9mARB9yE+Zs2aOjzSp7RI3CwZHvA4cRFE/QLwub2kJG+P6qZQ5JA8fTLbwlh1M/sy/hpdgD9712oFUFavz7zTw5lRhnrqGuT8qomp/Lryc1Mi45nltalMfYvN3/Du+HZIgGh6/iHZ10HC8MsCRLSNnYKLaAqI1x+ZmmsfD95b5aVLKF5ddRLAdvplhTPNrTCcbXvQYl43zP1LCS3Br3Q9VQygris=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(1800799003)(186006)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(86362001)(83380400001)(356005)(7636003)(82740400003)(40460700003)(40480700001)(6666004)(2906002)(966005)(336012)(1076003)(107886003)(26005)(16526019)(4326008)(41300700001)(316002)(70206006)(478600001)(6916009)(54906003)(5660300002)(47076005)(426003)(2616005)(8676002)(8936002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:34.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a41b2-ef83-4787-4ad2-08db981a1236
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some test cases check that the group timer is (or isn't) 0. Instead of
grepping for "0.00" grep for " 0.00" as the former can also match
"260.00" which is the default group membership interval.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 4853b8e4f8d3..d0c6c499d5da 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -617,7 +617,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not added as \"permanent\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "\"permanent\" entry has a pending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -626,7 +626,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not added as \"temp\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "\"temp\" entry has an unpending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -659,7 +659,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not marked as \"permanent\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "Entry has a pending group timer after replace"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
@@ -667,7 +667,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not marked as \"temp\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "Entry has an unpending group timer after replace"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
-- 
2.40.1


