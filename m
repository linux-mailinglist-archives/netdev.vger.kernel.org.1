Return-Path: <netdev+bounces-45522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF37DDD62
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9351DB20DD9
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB992184F;
	Wed,  1 Nov 2023 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hs9rp+YD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61902F48
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 07:46:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B292EA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 00:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arFcEF1nQylz4WJ5/tziz13YpTv9Uvkf3vWzJTaV4xTuTM8yWx+MZqNVKV3y1L3sOOmtMb+pIXxj2Kk0H0enNI7X05ol525kY7wmZPpI4Xyu4eIeGBlBnRpF0TppoCMdo7UiUd7tnPjFVkLE+JV+m4n84Sp165bm43N94KXqlrf6FlY/jATqETIk+AmZHGU00R4pXPGo1xEucarKBreyVzlZu+F/2UJnBcDCU3ZTGEn1nD3sUoK1/4lrlFUPjSNqjt7neWwuuN8UwHGeRdIF3Wc99Y/vZNtKx8wR04tv6h7tOSLJRNoede8eQHS5wMgdVDveokZI1TkMl8cyrYuwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeyXaao0dKhQZbfuA6iM7WcDw/iLzyiOoiIQniOGEng=;
 b=PC5AcgsXfDG7pbxESQ4jhikWNWzToQtMk68WdUiTNOsKWb0KrFKY5zeyAOV60QuFa24c9PVhev5lWUMK8IzQJBCCNettvZvnhWsmBWLCuEOte94gWkgL1+qcma6mOXhVjafwUdZPlOa74E9xFgSey99DcbHhZueGo4V+BJcD4WefJPOWuB0c074JmAITBJtRW/TN50YJRfeH/bHREUYvffN8AR+YxSIRkfGtGtLFioWboUZOq31PlYdJEO6PQoF6JF8x6yPU6ig6wvKIf+garYAPTUA16N4aGisDN4l7Ef4RhWgx1vdbMxGp91BxzBakld4xU9g+uOYPYdyDuLz+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeyXaao0dKhQZbfuA6iM7WcDw/iLzyiOoiIQniOGEng=;
 b=hs9rp+YDFCfZB227Hl/C7NsrucFWw2dJWQnW/RYXhZbfMghRVuEW5UFbaoGVoTjoBIgcXVzSdZoLNP+4jz7I6NBL3CZ5ZhT2Zyv5A0eCIcRNLzlEma1yq/uFZ19VNLYMTzwBt5g97OuRz7gcEFRBaEAYCRNAu2F64ltdqKr4fN6LmbU7X0UYLGWAIG4nief3WUKGERXirvFKZ12SU8LwFE7X12f3Gq1RpO5W1R9OEVnyQaAPHbg1DhnCaezGLE8LkEKexbpTf36EzPgXmL70VQIfE0dSynMj6Nu4/6IBpLNIrYyn3NLeBWzRkkQSK1CnOGlEZDl9iwvhwlIiflXTvg==
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 07:45:53 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::5c) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 07:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 07:45:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Nov 2023
 00:45:37 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Nov 2023 00:45:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2] bridge: mdb: Add get support
Date: Wed, 1 Nov 2023 09:45:10 +0200
Message-ID: <20231101074510.1471018-1-idosch@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4540cefb-2cf1-4610-2b45-08dbdaae92c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Axafx9/zN+Mw/xnpH170qixvD3sro0yiI+vxGKIhakZyfnMGR+LJs2SqGLVNPC4RllN9mRjumAppSr2LqHeu2wi1ffbzSrQ94jaOfvl1VzLhDRTpq2W65ArWbWykVelofH2rhxHXCABeQQ8SDXeFFjB5qcI5ECrGmVG5jtsiKcKG6E/dPkOG8a9DPchZYWBS0RA8WxT3TbWmBI81h4jCbAEo4c0l+XoL73fydh5oR0IKIYpKi3LAWIKL+LHaYYbTnnBvCEQ5ZXBfmNWRHoFYVw8H39PAFuD5TVN8RpHW18BlEDCxp4iX+n24YuF+Dki4Q8QYA/Ng6BbiReZGSZkL3J0hv4YXOttk5vok3Hdf/pQ/7N5bB6zAQnRWsWKl0xxJXoOns0njyjrk5KU5/EfTtxHNFWwZ4htiXVhDy4LiXLp/zRwVJSPabPgn9DtpzFNdP/st4TPJkP5rKZiw/cKRZp4Wim6RuX64v4PS5VyzJfdrPP1mmvt7CRfxAVOfiGkkKiVOcd0va0HdLTEUR2UGePp69NDy93RcAWyuMdLSmtzgMzKaXvn7XC80PSwZBS5LlQvNGa2tkZN2Q6A2tPc30kv8fV+KDLwxafTLsk+XkPsolTXXH+KodwARnPBCGyJPrrMSUNYijOitDHtOI2mQxe+ZR9tBHeKHAyLCQSfcxkHJfktI/1bQZSiyu1lelCJdfgZGuoLsaZ1MxSy9H6Wr4W2TztxsErZkesizv8vsC4km9yAF+XKe3U+YZQLHd5ZfTx4VtnbO+CgaAPD5ud1YL8VQn/JZ02IlHC5jQ7g2LgY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(26005)(2616005)(16526019)(40460700003)(40480700001)(86362001)(36756003)(356005)(7636003)(82740400003)(66574015)(426003)(336012)(2906002)(5660300002)(83380400001)(478600001)(1076003)(107886003)(36860700001)(47076005)(6666004)(8676002)(316002)(4326008)(8936002)(6916009)(54906003)(41300700001)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 07:45:52.3679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4540cefb-2cf1-4610-2b45-08dbdaae92c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

Implement MDB get functionality, allowing user space to query a single
MDB entry from the kernel instead of dumping all the entries. Example
usage:

 # bridge mdb add dev br0 port swp1 grp 239.1.1.1 vid 10
 # bridge mdb add dev br0 port swp2 grp 239.1.1.1 vid 10
 # bridge mdb add dev br0 port swp2 grp 239.1.1.5 vid 10
 # bridge mdb get dev br0 grp 239.1.1.1 vid 10
 dev br0 port swp1 grp 239.1.1.1 temp vid 10
 dev br0 port swp2 grp 239.1.1.1 temp vid 10
 # bridge -j -p mdb get dev br0 grp 239.1.1.1 vid 10
 [ {
         "index": 10,
         "dev": "br0",
         "port": "swp1",
         "grp": "239.1.1.1",
         "state": "temp",
         "flags": [ ],
         "vid": 10
     },{
         "index": 10,
         "dev": "br0",
         "port": "swp2",
         "grp": "239.1.1.1",
         "state": "temp",
         "flags": [ ],
         "vid": 10
     } ]
 # bridge mdb get dev br0 grp 239.1.1.1 vid 20
 Error: bridge: MDB entry not found.
 # bridge mdb get dev br0 grp 239.1.1.2 vid 10
 Error: bridge: MDB entry not found.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    * Use strcmp() instead of matches().

 bridge/mdb.c      | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
 man/man8/bridge.8 | 35 +++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 18793458ecca..dc8007914a37 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -36,7 +36,8 @@ static void usage(void)
 		"Usage: bridge mdb { add | del | replace } dev DEV port PORT grp GROUP [src SOURCE] [permanent | temp] [vid VID]\n"
 		"              [ filter_mode { include | exclude } ] [ source_list SOURCE_LIST ] [ proto PROTO ] [ dst IPADDR ]\n"
 		"              [ dst_port DST_PORT ] [ vni VNI ] [ src_vni SRC_VNI ] [ via DEV ]\n"
-		"       bridge mdb {show} [ dev DEV ] [ vid VID ]\n");
+		"       bridge mdb {show} [ dev DEV ] [ vid VID ]\n"
+		"       bridge mdb get dev DEV grp GROUP [ src SOURCE ] [ vid VID ] [ src_vni SRC_VNI ]\n");
 	exit(-1);
 }
 
@@ -848,6 +849,100 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 	return 0;
 }
 
+static int mdb_get(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr	n;
+		struct br_port_msg	bpm;
+		char			buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct br_port_msg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_GETMDB,
+		.bpm.family = PF_BRIDGE,
+	};
+	char *d = NULL, *grp = NULL, *src = NULL, *src_vni = NULL;
+	struct br_mdb_entry entry = {};
+	struct nlmsghdr *answer;
+	bool get_attrs = false;
+	short vid = 0;
+	int ret = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			d = *argv;
+		} else if (strcmp(*argv, "grp") == 0) {
+			NEXT_ARG();
+			grp = *argv;
+		} else if (strcmp(*argv, "vid") == 0) {
+			NEXT_ARG();
+			vid = atoi(*argv);
+		} else if (strcmp(*argv, "src") == 0) {
+			NEXT_ARG();
+			src = *argv;
+			get_attrs = true;
+		} else if (strcmp(*argv, "src_vni") == 0) {
+			NEXT_ARG();
+			src_vni = *argv;
+			get_attrs = true;
+		} else {
+			if (strcmp(*argv, "help") == 0)
+				usage();
+		}
+		argc--; argv++;
+	}
+
+	if (d == NULL || grp == NULL) {
+		fprintf(stderr, "Device and group address are required arguments.\n");
+		return -1;
+	}
+
+	req.bpm.ifindex = ll_name_to_index(d);
+	if (!req.bpm.ifindex)
+		return nodev(d);
+
+	if (mdb_parse_grp(grp, &entry)) {
+		fprintf(stderr, "Invalid address \"%s\"\n", grp);
+		return -1;
+	}
+
+	entry.vid = vid;
+	addattr_l(&req.n, sizeof(req), MDBA_GET_ENTRY, &entry, sizeof(entry));
+	if (get_attrs) {
+		struct rtattr *nest = addattr_nest(&req.n, sizeof(req),
+						   MDBA_GET_ENTRY_ATTRS);
+
+		nest->rta_type |= NLA_F_NESTED;
+
+		if (src && mdb_parse_src(&req.n, sizeof(req), src)) {
+			fprintf(stderr, "Invalid source address \"%s\"\n", src);
+			return -1;
+		}
+
+		if (src_vni && mdb_parse_vni(&req.n, sizeof(req), src_vni,
+					     MDBE_ATTR_SRC_VNI)) {
+			fprintf(stderr, "Invalid source VNI \"%s\"\n", src_vni);
+			return -1;
+		}
+
+		addattr_nest_end(&req.n, nest);
+	}
+
+	if (rtnl_talk(&rth, &req.n, &answer) < 0)
+		return -2;
+
+	new_json_obj(json);
+
+	if (print_mdbs(answer, stdout) < 0)
+		ret = -1;
+
+	delete_json_obj();
+	free(answer);
+
+	return ret;
+}
+
 int do_mdb(int argc, char **argv)
 {
 	ll_init_map(&rth);
@@ -865,6 +960,8 @@ int do_mdb(int argc, char **argv)
 		    matches(*argv, "lst") == 0 ||
 		    matches(*argv, "list") == 0)
 			return mdb_show(argc-1, argv+1);
+		if (strcmp(*argv, "get") == 0)
+			return mdb_get(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
 			usage();
 	} else
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index 07bb97878554..7c1b22f6435e 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -177,6 +177,16 @@ bridge \- show / manipulate bridge addresses and devices
 .B dev
 .IR DEV " ]"
 
+.ti -8
+.B "bridge mdb get"
+.BI dev " DEV " grp " GROUP "
+.RB "[ " src
+.IR SOURCE " ]"
+.RB "[ " vid
+.IR VID " ]"
+.RB "[ " src_vni
+.IR SRC_VNI " ]"
+
 .ti -8
 .BR "bridge vlan" " { " add " | " del " } "
 .B dev
@@ -1137,6 +1147,31 @@ With the
 .B -statistics
 option, the command displays timer values for mdb and router port entries.
 
+.SS bridge mdb get - get multicast group database entry.
+
+This command retrieves a multicast group database entry based on its key.
+
+.TP
+.BI dev " DEV"
+the interface where this group address is associated.
+
+.TP
+.BI grp " GROUP"
+the multicast group address (IPv4, IPv6 or L2 multicast).
+
+.TP
+.BI src " SOURCE"
+the source IP address. Only relevant when retrieving an (S, G) entry.
+
+.TP
+.BI vid " VID"
+the VLAN ID. Only relevant when the bridge is VLAN-aware.
+
+.TP
+.BI src_vni " SRC_VNI"
+the source VNI Network Identifier. Only relevant when the VXLAN device is in
+external mode.
+
 .SH bridge vlan - VLAN filter list
 
 .B vlan
-- 
2.40.1


