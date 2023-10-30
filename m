Return-Path: <netdev+bounces-45273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E87DBCDF
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B1281465
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9618B06;
	Mon, 30 Oct 2023 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+mDWbcc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658A12E64
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:47:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462EC5
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJapJ366NM5gbxePncHaHOw7mbgo6HU+RbMF1FcMargqewP1YE1HYSifZFyiaLJVvfutCo/+NXvC+E0frU+WUUIrWKhMgOxfoC7lOwNUGPFcH/r7Ubz+zTF5GNegutXhqOPs9WAk/IzIMTQhSoFxv9VmeBQzKSWq6r78tnnHQN8ScBSTI8paTT0DxWJCvSdpoaWXH2J5aQKXUl9mAHVa6Mw9Mr16YfC3WN3y+evAyMAcXfXD7UT95Kc6AluZpBZiNvY1yi/B72HbFNr6RcnA2tskuxghsHr9pEsh2w4WClwSHNk8jnQrK7ojaqGEnjixWH5HAq17TdkvwcVNXEGoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn5jOyAT8RTjMdikvgMPmupzfMuP6o1nzJqJoWLCssk=;
 b=IxY3CqhTLB1VIfK0UmEf6WLEFmSVvVggHGOSY+pVda903cmiE5J8Gpumq7cwPIDP9HHLJvcHCoLjj2AAzNTVkt9Pr4/RgOFfzWdRMtWVxLX+hMPVpSf3y6ooTkBd7+ENFJKYkMnwZ/7hkXp5IuZx6sWQOZ35fxam7EFkLlSKWOM7/A8GtBp3AvG5qdk2FB2viDNUqxSsEXJSx4po1W+gfGdjKc4HT+1Kqr6uv7MvtjftJSeHMWccvIZpMGKyj2d5nlFtJOqC03fPAM9QJofsFJsb5TQ2BsX4k4wCLGFxl/8jvEU2bjHc0f5jPGHeTd5B0zcUkjCOXDBt0PLKu8Krng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn5jOyAT8RTjMdikvgMPmupzfMuP6o1nzJqJoWLCssk=;
 b=F+mDWbccso4CRk5oNXnwNp5otuAQ/I7TbDjeLwFkbHQmHsRnYw+WJclRmNHeB77DpqQMBh8A62rAUQFVd3u/Rpfl+SNjkUAtHddLqIZ3K2dlmBg4XgB85Euj7M5FnqQCEIYyASaNmnSbweuDUcwpsfp5mgABC02qyxRZLN4TfDwfKffjyJ7VAekkspPT8T5l9UFtqxhYhhBoz1Ta8auzkxb5+nQuKryofyU9nCdpfuIZCl0IeyKXv8grw3blsWMWwuep1JDzy8GFuT2JLJlxfVtODnDYa3lhnT/6uiDtQxJ9ZK4hz57cl6pWH/A9AwSkp9e47vhaGSAZxA2Qoa0qjA==
Received: from BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42) by
 IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 15:47:28 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::b5) by BL0PR01CA0029.outlook.office365.com
 (2603:10b6:208:71::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Mon, 30 Oct 2023 15:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 15:47:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 08:47:16 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 30 Oct 2023 08:47:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next] bridge: mdb: Add get support
Date: Mon, 30 Oct 2023 17:46:54 +0200
Message-ID: <20231030154654.1202094-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef15262-cdd2-4539-d152-08dbd95f8533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iYMr4D0ixAkoxTmYRUVAyD/U9plqSNvrTaJHE2HLdM91+tY/9jdu5z7rWpEFsKiqamOqD59ZAXKSQ/F6rzXot2GXPlhkm+1rric2x1kYV0ES5oxfRkuLz4o6BiRk1dhJ//6FEAH5VjC3ZnQ+Pf8uQNrczvMsnx9SF2vev9F/VN/7q9KeienxTTya9nZKmzCiJUAaKbEaJsaTy5Cx6tOAbbyvHx8QFCZEylM1VD0IUnHrS/gele60Pfry3E5RSQz/OMhFY99UdZONOPqxzXBd5qXSvAh46/E2ecodUzG8Jqxk1qQh+/oIn0mmeVOfmyTsLKRB0u3Bp7+BZmGc2KZD9/lKd3SDAo0SmECnJsSdsIq+7zCo2T1GLlY7bnvS6cjj0gSP3EFaaFhpQOyuNtF09qn8chQJE5Ru2nb6sNdb8w2SgK08gQewz8+F8PVV/hpSpBv/YKbcB7XI+u2yqcXPrBeQO2ena5cQkGKmcMmrUuj7kmut6a/C/3RG3WSoAu/VG/joJ3q7JW4nHVG5HXUYFvRICeNuMOOxCNTr3EUFkHt1X/Ci32c16qhSu7vovntySrTS+m8rnzbkAh2u5ya9GgBe9G+BrGTAVJfCGOXWsAetJ+A/rrl8EpWajIm8VcAr9rIThm52aO9DSB5xMfQcoyAJD97WcJ8DlJ701d2NOlQ8wXsKJCQlTn3W0Hb7MrB0ZEPKvaVtKhIC6EbUj8gjeQ+Au+XC7qDLDQ8dirSTz4pLTUTE7OIp3gIK5DEN/sET9dLIhBK7S/rkhu9Io8UjAR6rvkDtK+tfNnPTyqauP8k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(336012)(426003)(66574015)(16526019)(26005)(2616005)(107886003)(1076003)(2906002)(36860700001)(47076005)(70586007)(478600001)(6916009)(41300700001)(5660300002)(316002)(54906003)(4326008)(8936002)(8676002)(70206006)(6666004)(36756003)(82740400003)(356005)(7636003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:47:28.0755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef15262-cdd2-4539-d152-08dbd95f8533
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

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
---
 bridge/mdb.c      | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
 man/man8/bridge.8 | 35 +++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 18793458ecca..cdebb085fdce 100644
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
+		if (matches(*argv, "get") == 0)
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


