Return-Path: <netdev+bounces-41875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3267CC140
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8F51C20DD1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0B41A90;
	Tue, 17 Oct 2023 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePWd+GlO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C541762
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB86E112
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcOjeLCKZaJRZByJvHAsfK4pxmn5XsmUmi3reqsRz6gh9Fm6MI2qS/bYIRWo94Eyq9iLrRcgNUBMhryUwI4ud82pCphLPUVCIsVByI4+APfAWXK7Lm65OTH8cNZ/PIX9PllLyZeNbGLxvpEnPXVgxbtLeCKTC8PNXswUIdfO6It+eChStz/R7QxfgKw/u6+fI/GDuWQBxMSrB+bRP1J50KziCVLP1qBVsBrrUKqzCq5PGOO6psPDbxz54pfGvstQvaxjwtj8jQ+JADOXA695SD11OxidrXFojXtY4q07oVQxGeD0UmlThuXrL4Pbvu9NdHDlqiZc8hP//rv8I1j1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3P3OZ35DDLj4tuf3t7hX+EXo21iC/sY+m0awGb6Igk=;
 b=nik904dE+HfF7ml/bvcRUaM3GakI2GjOhF/fPvvfmCOxzc1YDM/J9YHeX7Z7WlWxux4ZPHOX+XZRCgxbRO+VnCM5zxv8UMoMnCrQBmD0aGcgqxxYXXRWthDNFAGcXzxTv1zTQ7GBdUChKDfRCnbKkKZHWcrtRCs99FC0+xldnUgIOX8wzbfWiMX7C9J6shAtVVXF/rpULgNM/54bihicYg4EpIyJUx5ZA5Os64QcggacvMzvZStPFGy2hfpSAAI38Re2Jc167i0MSBkoSxB5+46Ra9rEhq1jNCIPiGhkjYKibm7GDA3skN1x/2E2uvhQaQRIBdAyK7kQLtJ/xPwEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3P3OZ35DDLj4tuf3t7hX+EXo21iC/sY+m0awGb6Igk=;
 b=ePWd+GlOyd7q0nhlL7undnrSeJDDJdojsdOcMuAjQjnZjghAY8bl9lJnqaz7nC2ge97V+XMpGVniDwngEjsxSSyuy3+unCRQKJRMNT1JosckeTg3slAevM2BW0tuTucFyozi8KRdENRcNWAJHGxrpMNZv3BbOJBB3yDO9nc3dLAFz2Za01qu7iIHDtdwZXxUKoPwzpH+v2zuU5cGJe998DsJgDWCDiVXMngyVDJO1EjAS+uohiSPnTUuLVOOFU7AbjE2tJNF7B2SBPzToKm23mXK/e/BwbNZmTrKBQNMKDInXE+qlvNXzTpQQtJl6neEgy3szmTa6loS45Ldh6Hr2g==
Received: from MN2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:208:236::31)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 10:56:14 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::60) by MN2PR05CA0062.outlook.office365.com
 (2603:10b6:208:236::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:56:02 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:56:00 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 6/8] bridge: fdb: support match on destination IP in flush command
Date: Tue, 17 Oct 2023 13:55:30 +0300
Message-ID: <20231017105532.3563683-7-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdc3300-960a-4263-e2ea-08dbceffae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CLgn8DjreidKqj0ZqQRoi17j+uIf3JANyydnzAvn1ZTAdcD9ZmplvSx/NyJhu/fW/a0hdgilKWyOoJHd44PUYr24jNbyrxmA2rGxRr2Ee+GeDe8o3XskGdu1eGHnD8PtltIpO4hdy12wdKkbA3tYHtDmoZqvrTul21FhTx3Z1baHJCIGmPlotwRd9LvSTrb/qSUKEzhHTtoldRr/pgEy7z2IC0ojBOCGs4FdAtEnr41d+k6RbWPiZZUpaga1rZ+MF3KbJvUPkDZk9oXhoXnF62RDOETVjnzKHDUj56lDLlpQbOTdeKO5HtVG+t8uFHl6RCIsgubwWU/6clSLNzJWrmOx2R3IbrKyVFwaPmyNdWJ3URyfins8ADE/OP9rJSj6Y5fGZ95L+rWXRq73u6GIes0vM+FrH1qTQ4cyOEH1LUAsFBN5S6dQdRBsLR1k6rrbi1BDucB6Keuu5sXkNNjTu9R1js2gac3kECsJ0wYaiUixrbIGnfaTDZeOAl9GCNACjTFrO9f2Egef4+P6njD3MMgn/wTufeClp8iPIrCZfyQFD8+JBK6v6cx5PTVIzsRLnYjZkMr+9F6d1GPd/ErpQrYS3vKJJoaMdFZ5xRs7SBzxdNq6h4+AN3alx0FSsZGTCOf/gCDqQok2YnghdnutdDdXhh/yCrk6EiIfNK/bQEygyer8WqG1DEcke4/p4/YLZzIo9sq0jEOVRKRAnnKRXx72H9B/wqhkesiTye1deE5dSSbUV8oSECp+ZgryH4Cf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(40460700003)(40480700001)(478600001)(70206006)(47076005)(54906003)(70586007)(6916009)(6666004)(7636003)(36860700001)(83380400001)(86362001)(356005)(82740400003)(316002)(426003)(107886003)(26005)(16526019)(1076003)(41300700001)(336012)(5660300002)(36756003)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:14.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdc3300-960a-4263-e2ea-08dbceffae86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific destination
IP.

Example:
$ bridge fdb flush dev vx10 dst 192.1.1.1
This will flush all fdb entries pointing to vx10 with destination IP
192.1.1.1

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/fdb.c      | 14 ++++++++++++--
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index f2d882ed..8311fa08 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -46,8 +46,8 @@ static void usage(void)
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
 		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
 		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
-		"              [ nhid NHID ] [ vni VNI ] [ port PORT ] [ self ] [ master ]\n"
-		"	       [ [no]permanent | [no]static | [no]dynamic ]\n"
+		"              [ nhid NHID ] [ vni VNI ] [ port PORT ] [ dst IPADDR ] [ self ]\n"
+		"	       [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ]\n");
 	exit(-1);
@@ -704,6 +704,8 @@ static int fdb_flush(int argc, char **argv)
 	unsigned long src_vni = ~0;
 	unsigned long vni = ~0;
 	unsigned long port = 0;
+	inet_prefix dst;
+	int dst_ok = 0;
 	__u32 nhid = 0;
 	char *endptr;
 
@@ -795,6 +797,12 @@ static int fdb_flush(int argc, char **argv)
 				port = ntohs(pse->s_port);
 			} else if (port > 0xffff)
 				invarg("invalid port\n", *argv);
+		} else if (strcmp(*argv, "dst") == 0) {
+			NEXT_ARG();
+			if (dst_ok)
+				duparg2("dst", *argv);
+			get_addr(&dst, *argv, preferred_family);
+			dst_ok = 1;
 		} else if (strcmp(*argv, "help") == 0) {
 			NEXT_ARG();
 		} else {
@@ -853,6 +861,8 @@ static int fdb_flush(int argc, char **argv)
 		dport = htons((unsigned short)port);
 		addattr16(&req.n, sizeof(req), NDA_PORT, dport);
 	}
+	if (dst_ok)
+		addattr_l(&req.n, sizeof(req), NDA_DST, &dst.data, dst.bytelen);
 	if (ndm_flags_mask)
 		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
 			 ndm_flags_mask);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index cf23094c..e3051f89 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -136,6 +136,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR VNI " ] [ "
 .B port
 .IR PORT " ] ["
+.B dst
+.IR IPADDR " ] [ "
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
@@ -923,6 +925,12 @@ the UDP destination PORT number for the operation. Match forwarding table
 entries only with the specified PORT. Valid if the referenced device is a VXLAN
 type device.
 
+.TP
+.BI dst " IPADDR"
+the IP address of the destination VXLAN tunnel endpoint for the operation. Match
+forwarding table entries only with the specified IPADDR. Valid if the referenced
+device is a VXLAN type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


