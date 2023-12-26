Return-Path: <netdev+bounces-60306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BACA81E809
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631621C21F06
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8F4F1FB;
	Tue, 26 Dec 2023 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbQm8AJ/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E14F5FB
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vul2NpilMsA2dgOpBZWVBsNkA6Jg+HP/CxsE/UaG9F21EWWTVCz/gbhm+v+naTYgDgMRc5WxOsglNIN4xvXSi6BmkKmQPoz/pu9SmfmiSfIrh87wIqJwF6EkHjTxF6n0kATTBtYBaMcoihcI2b5QtvH+qShxBFw/2yK+jsUmAPyo6wJZcBnoGD+TDovSpjDXknfPN53+8owaUy/69gN15y66sz9uTtbCbdXPPs8NlftZ++b2gAe/6+G9UyypkjeYwwpus2zNRydW9d05oL8CDMBBHswSiyuwcqukAZ4YM8EK0jReDeaRo5jtbmW8cty8abhvJ9KMqevr0EGf8TMd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUITKycOfPNhqT9LHlE5F/s9sasA3JCGDm7VpbOU4/M=;
 b=d9cwwbKKWCbJpjuif89ScItc86v7Vk0rTEMEYAU5JRdZh2GEdPjKu1zHwrM8xlo865+m0TlzcPDCrV6ZpzxtO3KQJW7MWrxHPJGrWaA3CjhdK91TRF2e4r/DpzSLy2OKvTF8hbTK6LvxJ7lkQ10JSuX5v1PzcUJwy5qTBWUgG61IdKpXiUu5LWWMEaMY38P5D9x6JT7XAjDU14HEHVRoLgVgscwHiZmV2WvM3h9c7Odrae1/YH+JGFmiKbK3kRrJVK8bxIiidJYsnTi+ZiNmlEnUZDR6p/hexU6UDs+YrAmyaFsx5IXECk+WFj8Cx5597FOixVm0Le3FgfIj5XMTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUITKycOfPNhqT9LHlE5F/s9sasA3JCGDm7VpbOU4/M=;
 b=XbQm8AJ/LI/V6KmoMk8VGzspfZFYTkbB8bMkudgtOSXUEEu+VNpf//9U9aS8R9k7edWXjXdn0oj1OuB7ttP9xoEoK/6rAzV8FMfIZrxJS0gOwiDFCxM1Y8/jgwIamiwJOFgvoxBsI8UhAWGWEWlpGFjp0X3YbsQEufTfelsu2IldKh6q+rw+QmXvQiN64VIoMzPMdiLqX9l/xRJO1KyP0cdIWqA+lrBYw9bOLlM1Z8Xk0DmCSNoMeKsHPoRjfq0BWxIIAsjejWcrh9385+4Sl262UWisdAHsevCuTQbbr8riICQCfj8iTsIGipfgXAk1e2kwFQjVTibZkQgmwwkusA==
Received: from MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 15:31:09 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23d:cafe::31) by MN2PR06CA0006.outlook.office365.com
 (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 26 Dec 2023 15:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 15:31:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Dec
 2023 07:30:53 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 26 Dec 2023 07:30:50 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next] bridge: mdb: Add flush support
Date: Tue, 26 Dec 2023 17:30:13 +0200
Message-ID: <20231226153013.3262346-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: e673527a-04c4-4657-7276-08dc0627aec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iwv0Y8nociw9UKhDMJ6dGVrJekqNaHg5Gouic1IjPa7q2jr4e6XYoJxS8TnbEmkgYa4o9wT+bS8ephS0ZklrIb5ZACqcdPmTmAC24Num6sklYOIhywHsGk5MabhMAcQ3LA6ePS5t+GWXv8tkerYDB75byJTtAKRHXECSZaAXpYf7IBbIxGBtN0bJSndhEcYkyNsfdNO4L1bktlo5/P9k/gMHo2DbVqVKosyUnEeYMPcQlsjwKcvddkl/zszz5BGt0/VIqXY/wK2qxyGs0BmERrOQVAwOxEgn5UwWN5TbIsV6IuJk3zObc5nUGmBIIKqucJIOBhSjLOhJEe8yH6qpshnenvOUu84bQTf46bTdXKV7Uj7m8Mgxa3nGWhwYWmU/sx9jxePypHO3hXJ2/NIDRMZlSVGE+1c6hPs4URsTBrtst7UL/sSpEFXrdN9qDH4qzSJ/1JLvQy10bPBS/SeG40UD/1QPZhk56r8hF7GiST8AdIGyxfSNidRnfdDJejh0hamXumL0eeOuZf1gcQECQhgRgCr+LKHEhtKMr/t/DQko1BB7sqS8x7CodHQeb27/+KfVnjnclIE9UwLbn04WHFNSLy/s7RF9dR6h3a9rP1xON4viz2hOyPaYa5sJ7Yd92M50XgeBqudxzkLk/vicg0rGex/KUYWSwYjkGqxJ8oM2E1BlwAkkyYCV72ckKRMFBwp2Og6DR9NyzjfGkS4osDdHo4QWrk/CV1HD2yy8C+GtTLyCIwGAeb3n4y3CRqnoxdOEqnu0OMZXmTPQwYmfAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(2906002)(6916009)(70206006)(70586007)(5660300002)(40460700003)(4326008)(8676002)(8936002)(316002)(54906003)(41300700001)(47076005)(36756003)(478600001)(6666004)(2616005)(107886003)(26005)(86362001)(1076003)(336012)(426003)(83380400001)(16526019)(7636003)(36860700001)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 15:31:08.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e673527a-04c4-4657-7276-08dc0627aec0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707

Implement MDB flush functionality, allowing user space to flush MDB
entries from the kernel according to provided parameters.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 bridge/mdb.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++-
 man/man8/bridge.8 |  67 +++++++++++++++++++++++
 2 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index dc8007914a37..196363a5c829 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -37,7 +37,9 @@ static void usage(void)
 		"              [ filter_mode { include | exclude } ] [ source_list SOURCE_LIST ] [ proto PROTO ] [ dst IPADDR ]\n"
 		"              [ dst_port DST_PORT ] [ vni VNI ] [ src_vni SRC_VNI ] [ via DEV ]\n"
 		"       bridge mdb {show} [ dev DEV ] [ vid VID ]\n"
-		"       bridge mdb get dev DEV grp GROUP [ src SOURCE ] [ vid VID ] [ src_vni SRC_VNI ]\n");
+		"       bridge mdb get dev DEV grp GROUP [ src SOURCE ] [ vid VID ] [ src_vni SRC_VNI ]\n"
+		"       bridge mdb flush dev DEV [ port PORT ] [ vid VID ] [ src_vni SRC_VNI ] [ proto PROTO ]\n"
+		"              [ [no]permanent ] [ dst IPADDR ] [ dst_port DST_PORT ] [ vni VNI ]\n");
 	exit(-1);
 }
 
@@ -943,6 +945,137 @@ static int mdb_get(int argc, char **argv)
 	return ret;
 }
 
+static int mdb_flush(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr	n;
+		struct br_port_msg	bpm;
+		char			buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct br_port_msg)),
+		.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_BULK,
+		.n.nlmsg_type = RTM_DELMDB,
+		.bpm.family = PF_BRIDGE,
+	};
+	char *d = NULL, *p = NULL, *src_vni = NULL, *proto = NULL, *dst = NULL;
+	char *dst_port = NULL, *vni = NULL;
+	struct br_mdb_entry entry = {};
+	unsigned short state_mask = 0;
+	bool set_attrs = false;
+	short vid = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			d = *argv;
+		} else if (strcmp(*argv, "port") == 0) {
+			NEXT_ARG();
+			p = *argv;
+		} else if (strcmp(*argv, "vid") == 0) {
+			NEXT_ARG();
+			vid = atoi(*argv);
+		} else if (strcmp(*argv, "src_vni") == 0) {
+			NEXT_ARG();
+			src_vni = *argv;
+			set_attrs = true;
+		} else if (strcmp(*argv, "proto") == 0) {
+			NEXT_ARG();
+			proto = *argv;
+			set_attrs = true;
+		} else if (strcmp(*argv, "permanent") == 0) {
+			entry.state |= MDB_PERMANENT;
+			state_mask |= MDB_PERMANENT;
+			set_attrs = true;
+		} else if (strcmp(*argv, "nopermanent") == 0) {
+			entry.state &= ~MDB_PERMANENT;
+			state_mask |= MDB_PERMANENT;
+			set_attrs = true;
+		} else if (strcmp(*argv, "dst") == 0) {
+			NEXT_ARG();
+			dst = *argv;
+			set_attrs = true;
+		} else if (strcmp(*argv, "dst_port") == 0) {
+			NEXT_ARG();
+			dst_port = *argv;
+			set_attrs = true;
+		} else if (strcmp(*argv, "vni") == 0) {
+			NEXT_ARG();
+			vni = *argv;
+			set_attrs = true;
+		} else {
+			if (strcmp(*argv, "help") == 0)
+				usage();
+		}
+		argc--; argv++;
+	}
+
+	if (d == NULL) {
+		fprintf(stderr, "Device is a required argument.\n");
+		return -1;
+	}
+
+	req.bpm.ifindex = ll_name_to_index(d);
+	if (!req.bpm.ifindex)
+		return nodev(d);
+
+	if (p) {
+		entry.ifindex = ll_name_to_index(p);
+		if (!entry.ifindex)
+			return nodev(p);
+	}
+
+	entry.vid = vid;
+	addattr_l(&req.n, sizeof(req), MDBA_SET_ENTRY, &entry, sizeof(entry));
+	if (set_attrs) {
+		struct rtattr *nest = addattr_nest(&req.n, sizeof(req),
+						   MDBA_SET_ENTRY_ATTRS);
+
+		nest->rta_type |= NLA_F_NESTED;
+
+		if (proto && mdb_parse_proto(&req.n, sizeof(req), proto)) {
+			fprintf(stderr, "Invalid protocol value \"%s\"\n",
+				proto);
+			return -1;
+		}
+
+		if (dst && mdb_parse_dst(&req.n, sizeof(req), dst)) {
+			fprintf(stderr, "Invalid underlay destination address \"%s\"\n",
+				dst);
+			return -1;
+		}
+
+		if (dst_port && mdb_parse_dst_port(&req.n, sizeof(req),
+						   dst_port)) {
+			fprintf(stderr, "Invalid destination port \"%s\"\n", dst_port);
+			return -1;
+		}
+
+		if (vni && mdb_parse_vni(&req.n, sizeof(req), vni,
+					 MDBE_ATTR_VNI)) {
+			fprintf(stderr, "Invalid destination VNI \"%s\"\n",
+				vni);
+			return -1;
+		}
+
+		if (src_vni && mdb_parse_vni(&req.n, sizeof(req), src_vni,
+					     MDBE_ATTR_SRC_VNI)) {
+			fprintf(stderr, "Invalid source VNI \"%s\"\n", src_vni);
+			return -1;
+		}
+
+		if (state_mask)
+			addattr8(&req.n, sizeof(req), MDBE_ATTR_STATE_MASK,
+				 state_mask);
+
+		addattr_nest_end(&req.n, nest);
+	}
+
+	if (rtnl_talk(&rth, &req.n, NULL) < 0)
+		return -1;
+
+	return 0;
+}
+
 int do_mdb(int argc, char **argv)
 {
 	ll_init_map(&rth);
@@ -962,6 +1095,8 @@ int do_mdb(int argc, char **argv)
 			return mdb_show(argc-1, argv+1);
 		if (strcmp(*argv, "get") == 0)
 			return mdb_get(argc-1, argv+1);
+		if (strcmp(*argv, "flush") == 0)
+			return mdb_flush(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
 			usage();
 	} else
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index a60964bb614c..eeea407320cd 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -187,6 +187,25 @@ bridge \- show / manipulate bridge addresses and devices
 .RB "[ " src_vni
 .IR SRC_VNI " ]"
 
+.ti -8
+.B "bridge mdb flush"
+.BI dev " DEV "
+.RB "[ " port
+.IR PORT " ]"
+.RB "[ " vid
+.IR VID " ]"
+.RB "[ " src_vni
+.IR SRC_VNI " ]"
+.RB "[ " proto
+.IR PROTO " ]"
+.RB "[ " [no]permanent " ]"
+.RB "[ " dst
+.IR IPADDR " ]"
+.RB "[ " dst_port
+.IR DST_PORT " ]"
+.RB "[ " vni
+.IR VNI " ]"
+
 .ti -8
 .BR "bridge vlan" " { " add " | " del " } "
 .B dev
@@ -1172,6 +1191,54 @@ the VLAN ID. Only relevant when the bridge is VLAN-aware.
 the source VNI Network Identifier. Only relevant when the VXLAN device is in
 external mode.
 
+.SS bridge mdb flush - flush multicast group database entries.
+
+This command flushes the matching multicast group database entries.
+
+.TP
+.BI dev " DEV"
+the interface where this group address is associated.
+
+.TP
+.BI port " PORT"
+the target port for the operation. If the bridge device is specified then only
+entries pointing to the bridge itself will be deleted.
+
+.TP
+.BI vid " VID"
+the VLAN ID for the operation. Match entries only with the specified VLAN ID.
+
+.TP
+.BI src_vni " SRC_VNI"
+the source VNI Network Identifier for the operation. Match entries only with
+the specified source VNI.
+
+.TP
+.BI proto " PROTO"
+the routing protocol identifier for the operation. Match entries only with the
+specified routing protocol. Can be a number or a string from the file
+/etc/iproute2/rt_protos.
+
+.TP
+.B [no]permanent
+if specified then only permanent entries will be deleted or respectively if
+"no" is prepended then only non-permanent (temp) entries will be deleted.
+
+.TP
+.BI dst " IPADDR"
+the IP address of the destination VXLAN tunnel endpoint where the multicast
+receivers reside. Match entries only with the specified destination IP.
+
+.TP
+.BI dst_port " DST_PORT"
+the UDP destination port number to use to connect to the remote VXLAN tunnel
+endpoint. Match entries only with the specified destination port number.
+
+.TP
+.BI vni " VNI"
+the VXLAN VNI Network Identifier to use to connect to the remote VXLAN tunnel
+endpoint. Match entries only with the specified destination VNI.
+
 .SH bridge vlan - VLAN filter list
 
 .B vlan
-- 
2.40.1


