Return-Path: <netdev+bounces-41877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD677CC142
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDB91C20E35
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F841767;
	Tue, 17 Oct 2023 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="efWGTXmo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094541AA1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE6107
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqXt/9nAN+AdXEtDBGLCXvRU+OOC9YYU2ZQDfj5rRBT4VSLM95Vf2mBUv5KkIoYSMnxHmlNWaTgXU92oKVAiV8iNQLINJDPUHjuzlUq0x4lzGB/rESi6/NQ8tzp3WLVFKTlgVEZBPr0v6vUHPovzXMdg0DPFd+tAMi2eApbmi8lBO+GPZ7KUNOWBzvOe8Ara2dt4kw4CyIZKz9RBAMbcr8G92smsrfGFv3N8Pa+Hic9iJVgEaitaDtOvHzMo0TeFboikVk/sY4IKnA9skrj3YNdX49sVWwAfEhFSp0kInkvQu5y59BHh7m+2FFkuUXBGYnXOYRqZl4XaZ9r5qwPB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CQuPWy4s2VTsgnwF9N03aOaS+o2BXhr55Jt3JdVV1I=;
 b=HFa1pzbXTYFwADCSAI6671jlVECBv9NJL2jEod5eeFFIS5FagWV5AYwkyMkUWgBpRYK17nYshBN0d4z3Eeb08HwbkVf7HboIDWwRt6DPjn54lXYkKMWrONizzl42D3/FvAV4flR8z920Yy3oUgvFW9rbVLMXfT7YjZn7VfukVweY5p1A7jcA5daBUS7ctpi78xTJJtlX9/LcsQOlntedl92ptQy2Rx4x3p/zzHu8sJ9g70rrDCMdCRdTR+K3P6wnv8SgCM4NT1W7gytDTOjA1h3AnDIzuD5IoEPW+jfsrpU7P7SE5CHQ203rkYuWmCeqKNRZA8FRcEUVbbSSwWaGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CQuPWy4s2VTsgnwF9N03aOaS+o2BXhr55Jt3JdVV1I=;
 b=efWGTXmoDPIrZilueHN0RIT33uL+BkMMgAVjyDOhFMsNqf6hOYOyzvJ+Tn6b2DKlsD8Mat+LrsKFUC3cYyUhrse/QMMSxRYDe0e0al0BvDWFgPpP8lpbdqnt6jLmXRP3kF7v0lx2dQX/m+iW7dXOTmWTQQDTgssYy6rWHkXHkEujvjlnQxC1e14Nszb69E4pUA1ywLVeqCw36wY6MM4hjGG/iQjPXY6sWFNiP8wpHsD7hCeai7HjCvIO6m+T4VcOmvcWb/8lkG2mfRXWVdMuBxjzwb3DzbV/ooAPaSNe213dEmpP9l7v7XPaRBuUFp2UI5M5q6HCnDs9MZuemSkwPA==
Received: from BL0PR02CA0138.namprd02.prod.outlook.com (2603:10b6:208:35::43)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 10:56:19 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::90) by BL0PR02CA0138.outlook.office365.com
 (2603:10b6:208:35::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:56:04 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:56:02 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 7/8] bridge: fdb: support match on [no]router flag in flush command
Date: Tue, 17 Oct 2023 13:55:31 +0300
Message-ID: <20231017105532.3563683-8-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017105532.3563683-1-amcohen@nvidia.com>
References: <20231017105532.3563683-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0090f1a0-ebe5-47c3-7b0e-08dbceffb13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sOydGwvfYwaE7e23kEEh5gSv4XaqGR/z2ejwA90RIDbVQlpQ3hJCg9uDJnO/IESDKPDKQJFdag7j4IdzvZBhLDIHnN1G32OLK4gVxMMeEtcnJCnr6OpO+vtsJCUSGl6feFCDCfw8jOhOcgOMMEkBckHohqWpKwLAdP2DhQXia5xNhZWFR6Z8ZVbKkVqnShdb2IlPs87oMM+cY2VRDnAT6r5vH423xE7HFqhtIvaMx2JvxntFC5hGvUKgMxdkJSC+Sfs/RVmLeQHlMZDkirvZy0uSmSRfQUSs+C/g/fRopw4WSWOgOIgNt6u1Wwsmj+W8AFia9V/3juRMqkD0sStqgb0RuP57BA+A4iEGO0AL7EtrtP/55cXkYmuWPvk+iIKTJhgopMz2lIAFU/U/U/BLRhn1Z5Rto7uHidWcWza64d8G2KnWmpidlP9srmSUoLjg/L5b7gj7wLgC0bYyjZt3M7KBRkwWMplbi7B6pYVMuAwBLgIZ6wnIRl3oyC1R1GLBuTiAxY1JozZ7TGA8nozW7TtaZ1srgKKpKI+NRXTOG66KSkrqYlR2Bjpd7Aj6b+o88GPZGdJUHrMFQDRg+Y+l3l2OIn0BHYqehi3u8limXrYiLpaZtN9IAubV1CBS+zXOaw3IVGsFxVWj2PrrQeRG0xbDr1CWEbvz4J6dVWshLqV1htcSHd09AI9VgwssAJFUSgtJR57cGJ1hvdHHRO43WjFwpbA7xWEoYbeBv5PrD6MMVN2XKoFtmKLskLHvg8gi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(356005)(7636003)(86362001)(478600001)(41300700001)(54906003)(36756003)(70206006)(70586007)(6916009)(36860700001)(6666004)(316002)(8936002)(8676002)(40460700003)(16526019)(66574015)(26005)(82740400003)(1076003)(336012)(426003)(107886003)(2616005)(83380400001)(4326008)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:18.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0090f1a0-ebe5-47c3-7b0e-08dbceffb13a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match entries with or without (if "no" is
prepended) router flag.

Examples:
$ bridge fdb flush dev vx10 router
This will delete all fdb entries pointing to vx10 with router flag.

$ bridge fdb flush dev vx10 norouter
This will delete all fdb entries pointing to vx10, except the ones with
router flag.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/fdb.c      | 8 +++++++-
 man/man8/bridge.8 | 9 ++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 8311fa08..7b444366 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -49,7 +49,7 @@ static void usage(void)
 		"              [ nhid NHID ] [ vni VNI ] [ port PORT ] [ dst IPADDR ] [ self ]\n"
 		"	       [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
-		"              [ [no]offloaded ]\n");
+		"              [ [no]offloaded ] [ [no]router ]\n");
 	exit(-1);
 }
 
@@ -759,6 +759,12 @@ static int fdb_flush(int argc, char **argv)
 		} else if (strcmp(*argv, "nooffloaded") == 0) {
 			ndm_flags &= ~NTF_OFFLOADED;
 			ndm_flags_mask |= NTF_OFFLOADED;
+		} else if (strcmp(*argv, "router") == 0) {
+			ndm_flags |= NTF_ROUTER;
+			ndm_flags_mask |= NTF_ROUTER;
+		} else if (strcmp(*argv, "norouter") == 0) {
+			ndm_flags &= ~NTF_ROUTER;
+			ndm_flags_mask |= NTF_ROUTER;
 		} else if (strcmp(*argv, "brport") == 0) {
 			if (brport)
 				duparg2("brport", *argv);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index e3051f89..e5c6064c 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -141,7 +141,7 @@ bridge \- show / manipulate bridge addresses and devices
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
-.BR [no]sticky " ] [ " [no]offloaded " ]"
+.BR [no]sticky " ] [ " [no]offloaded " ] [ " [no]router " ]"
 
 .ti -8
 .BR "bridge mdb" " { " add " | " del " | " replace " } "
@@ -980,6 +980,13 @@ if specified then only entries with offloaded flag will be deleted or respective
 if "no" is prepended then only entries without offloaded flag will be deleted.
 .sp
 
+.TP
+.B [no]router
+if specified then only entries with router flag will be deleted or respectively
+if "no" is prepended then only entries without router flag will be deleted. Valid
+if the referenced device is a VXLAN type device.
+.sp
+
 .SH bridge mdb - multicast group database management
 
 .B mdb
-- 
2.41.0


