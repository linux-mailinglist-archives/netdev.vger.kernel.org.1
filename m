Return-Path: <netdev+bounces-41713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F77CBBE7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935441C209F0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51018026;
	Tue, 17 Oct 2023 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARw6wgP/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0E168A9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607729F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFqz2+MewbU9xu7UQsBQOKgA0Y2ZsTlxQM/nNKSWOxJaNp77DTYEgcH2kKBeqfzhFfdPSUD6RaBAdrlyfF6fJeF18FB1SfnWmqFCmF4V4QTbvdX6ffTf/U+ZIfXP5ff8RlCDWkk8Tg8TSyKDC5jowsR8oFh9CFAS/wLC9dE5uBtXjwCDiNPlpapgN7TwOWLCNkoyOPBA1smBa/pDdYWEqbFP+PYxS8kgLkw3hTqg+lFB6SGKF94an2dGSxWogEpVSbMHKML1q/MO8bqmItZSrXfCyBZwir81BcXo+rN9rTbwamTuYZiCC6S5pPAbNwtWJETtsS3q/T+gs/MM0NSpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJeSRFMCy2J9nrxU0qcnoKIvYZz0a+JmtGAGourmjBw=;
 b=iLRWik55NNE008/znzMLKLRLSyFERoyJ6prAiGMaDzCkMbDkGLCwznczrgEZpx9zcqKV/TXSrybz4K2PB1YbBBmOD6j3GLOBlt4LDGdjTXQCo3DXqoVMElQVnmKoP9LXEEHt4HFavBT33vLg5t1pigiZiyt/1+69V+gR27+mRH9/kwZv8cvS9h7f3X4itoES4U2AkZA38id0sX7p8L3+w11NZ8E9kq7fWU9+YtEqI0FP/q0/YkoJo++7ixl3Q42x8eayS+B82MfpgxNv2i/91QEealBSnZpoweSG/SmJVfKNsdbiBE1QM97l98qTsFet1Ew/PcT+bGeYc4/NcfBBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJeSRFMCy2J9nrxU0qcnoKIvYZz0a+JmtGAGourmjBw=;
 b=ARw6wgP/+2mDrtiEJ7LCRFFIswdAV1p+Zt5TGvb/xeAgFUk3t6Sq1EW4Vhra6f8ovCMKbkT0uloJMqwu+0+OOl8Qe6HdVjXWDnDNjXudPHbk4WPC3YCTPiOOTaZlRWh3/G8zJZldICahzXfjR3rNhr9amc1TYZ0j8lW4oTDsy89G+5MhkFHlkegOnikdNQsy1ZC/WXYhzQMOslrYRkHs73d038HSEuVIg9D/vA1hB0aBLgfiyvEiTWn0Spa6lV9p279gWxMbKr/20+3xeYIjWfiB4ATRr8oOWrRWlrfgcCWmy4h+iePFS0jv/MolUB2eGsg5ykEIFXMdSch0oZ7ocQ==
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 07:03:13 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::b8) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:03:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:58 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:56 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 6/8] bridge: fdb: support match on destination IP in flush command
Date: Tue, 17 Oct 2023 10:02:25 +0300
Message-ID: <20231017070227.3560105-7-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba1a221-8e40-4db5-fcc7-08dbcedf210b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MVeVbmHQ+e/wZwzp0rd1jv7FYOWu9iKW0cc8KfPKf7IcsspxKNUIU2rFbqK2Nrzi58PTm/9nBtPDvj05iNxlp6Ss8YYrMTuottBuN+yA/NHTMXI10s5XnHwGzUn0uQgqSuVACwkBlSif7y/+azCdo+hqUT7RNfU0GLVNrBcBYHJNZnuFhtWa7rxmsYy5Vs4unOq/BqaXsDHgOvOQHHXEiqJH+kyI7XSvOFRWBcZD48VP82ptisHK7NBe7pFx/qspe4/tEj0nwDM2Z2eTZDtk1YQSbKFonb2fIpNIkP/YWCJwI0VRAQplrrX5Xrik5CQf1WBBTiQKEG/eD6it4MGP/VXFxeqWoo7B2YmsjHNof2oK0jpxiph/8a7P4ST2oTeWblGDtooRoprCzV0w0MmwbsFVZQrso5ixhC/SEwSjFJAonBEsQ4vFsPow/n76suXPcHDYNLLmXYZcNdtxDSI5PTX95q+UrwkPxJMbDAWT3AU2PDp5G0N5IYc3jTgRULa6dYD+gS1uZlDJA+WWx3ouDmx9aUg8R60SSfbxcNDwtE5xb71q4jYkSOCVdv04EkhB62KNRg6IoGKPBRhunlyrua8okckzzuHv2voF6v/xA1q2hRbDdUY5mIhoNk/Uva0PFQR3fXGvEWrtYwKPcMaIAESfRSk2Abjyis/27UcP0Xst1uEMG9DHqdus0l4Lm40xxlwXBiI2pHrQr5WakOxvEdycuMokod0ZvzTsosmL3II=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(47076005)(6666004)(83380400001)(36860700001)(336012)(426003)(16526019)(26005)(82740400003)(40460700003)(107886003)(40480700001)(2906002)(5660300002)(8936002)(86362001)(6916009)(8676002)(4326008)(316002)(54906003)(70586007)(70206006)(41300700001)(36756003)(7636003)(2616005)(356005)(478600001)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:12.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba1a221-8e40-4db5-fcc7-08dbcedf210b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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
---
 bridge/fdb.c      | 14 ++++++++++++--
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d9665bd5..35100e68 100644
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
index 4255364d..df440c33 100644
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


