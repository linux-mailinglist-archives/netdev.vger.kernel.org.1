Return-Path: <netdev+bounces-41325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0101B7CA923
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249801C20D3C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6C27ECF;
	Mon, 16 Oct 2023 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzDZrqBB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF827738
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2939F5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEPy5uVCYQRvPCoO0SvJmsqbqytKvyGOnMgQozol/Lpjh5/cwBd/QRC+H8DypBzedD8nnLhV0IMlmKWzD9BcdjJ5YNxrt9BssGD6lPjLNY0iW6gy9dbh3EHEtyMjfmpv+qxLLG7Fjes8nsSqBly28hmM+vhlx/EW9UqumTTibymD3bsmNysxtQRBeWeXYNjTO8i5nP25LOmtChn+QuKUJcxV8bLDG4NRlFVGsI41YP91SFvLTwr5d20UYW9b72qQIZnEBDgwNuTwYV+BeNxp41PyDnPrxKEvN3NwbtZH/rj8euSSTmuYzCSk1aUwoYJ6eZRbUc3n1qYmzoij3pc8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAcIptTXNIvJ6cPUQPR8TX9wiLP5p80U0vPHJxi/qtk=;
 b=NYT934duX10ygr9PUM87IXjC5L3yXEwQZ45Y1jzaEZG1OIPPdIL0TQtitHqdHjRCnATel0JTpZRlEr9g7Jk7gLyNkgCdOMLMQmIq9r3PnpoGZu0rqbMmmF4GjgSCbihDPgRB9r/Lo1907054jz9VQZWaG5wV/IBEkTPn+fx+yieypm4Wi/ZcgnMyaimtulW547ddN85ukWxOzVuP00fb20ffnkLT3eaKIlSV/SRl9oCiLiMO8rNwhb8D7EozMJQCPrsSaB6frpa0Mp62nmwNGP0EcVzVQXF9MJT3RnArCXgW/hwleUKCqqd6hx/JY+5b7zP1lKydLZLUu07Gx9z5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAcIptTXNIvJ6cPUQPR8TX9wiLP5p80U0vPHJxi/qtk=;
 b=tzDZrqBB6z2LikaGMC3IEDg7vMBYFN2anhoZF/7twK6H+JfLc/IVMFoCd58tLDgRTqMWLQlSnK1khUM6BDoGbc9ibLqJGzb6NRRqSl+i/dp+/vdSWJoVrMUfnd91hwl8E00I4HR99NCUoqTANiD5nFEiwVsSf6UasReGxXxEUy5Yce8UD5+jfPowqBNrsCddRSvt0Ei4eT8wmU+S8T8kO3S6UvwQwgTsXeNtITihg1rlcLDkCNDlAiMq+DcGsp+nM46QsbcOyeUGEhD6F1nhbwj2UaLCJ+fZwQVjbji9DUdV343ijEl10hRcqMIipwhMdIhk+HhK40TM7Ij42XkH2A==
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:14:22 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::b7) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:14:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:14:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 11/13] rtnetlink: Add MDB get support
Date: Mon, 16 Oct 2023 16:12:57 +0300
Message-ID: <20231016131259.3302298-12-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a8f49b-9a0c-462a-0689-08dbce49cfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yfRJh2NZab+QvgZDmID3+qi08ZXp82wuLWIMM6fmm0avXdOT49XuYzrUScxKVXcgFO7CTgN8cnRJns/mvl4BOx3CRbtXKXU7gVW7l++mpa2XO+BDstGrHB/CAvDsAij5SL9Z4EtwmBtqo8xuLnpf8BsPNeDImJOHGGZ8oPSpREE+hLUm59Qp9LdrHzsybsfmb5Uszc/Qvin82vgS3qGhYzVXJEGSye4LQnhvG3BRfeC9p9VwSJDYw4XNFWwDW9lD7d6Gn22ySmBgea1rPGevZOZOvhjf+I4g9zAZh5WP4NC+7N0hOTuflKs2D8dylfGZG5pmqxXfNiLRdcq0GoDXbQ2ewgWq3RwC4MQyttFSkM/JeEv7ypxQjSGsGK0MEVPs3s3oiMrRKipDSIsKl0hQjvMSjoLJYLOVFnX7MliWLfFPbks5HpJU+s7V1+a/Kd+CUvx36D8c9d2pStaYPrIc9Hr7zrp36pLETNyaJMdGV9MrKTzQnfkffQgqzlkuD2aOhvoYveL/tCH3Mp+d5mKJVRWBCSQMzushIXTmjKFLZKAh1IegGWRlEOEciW1gQmVaECuaCkUWYffAY6rdjD13jOcPcK96umZ80aWb8hwCJHrSL2Znp5YnxythRTesO6g32t5kNz6/pJ6g9cQvLl3xPYRXkO6HTpfs9aqQt+aNwenwgEHYXeZ09OvtbME0AUz9BiwTvKXF35dmvEHjpLTEVTuT12uRPfkaYTh6O2NGx4qX3eWtuZJyZixhpAQcLVOW
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(107886003)(16526019)(1076003)(26005)(2616005)(336012)(82740400003)(426003)(8676002)(8936002)(4326008)(5660300002)(47076005)(83380400001)(7636003)(40480700001)(41300700001)(356005)(478600001)(86362001)(110136005)(2906002)(36860700001)(316002)(6666004)(70206006)(36756003)(54906003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:21.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8f49b-9a0c-462a-0689-08dbce49cfe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that both the bridge and VXLAN drivers implement the MDB get net
device operation, expose the functionality to user space by registering
a handler for RTM_GETMDB messages. Derive the net device from the
ifindex specified in the ancillary header and invoke its MDB get NDO.

Note that unlike other get handlers, the allocation of the skb
containing the response is not performed in the common rtnetlink code as
the size is variable and needs to be determined by the respective
driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eef7f7788996..e4fb242655b4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6221,6 +6221,93 @@ static int rtnl_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int rtnl_validate_mdb_entry_get(const struct nlattr *attr,
+				       struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(attr);
+
+	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid attribute length");
+		return -EINVAL;
+	}
+
+	if (entry->ifindex) {
+		NL_SET_ERR_MSG(extack, "Entry ifindex cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->state) {
+		NL_SET_ERR_MSG(extack, "Entry state cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->flags) {
+		NL_SET_ERR_MSG(extack, "Entry flags cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->vid >= VLAN_VID_MASK) {
+		NL_SET_ERR_MSG(extack, "Invalid entry VLAN id");
+		return -EINVAL;
+	}
+
+	if (entry->addr.proto != htons(ETH_P_IP) &&
+	    entry->addr.proto != htons(ETH_P_IPV6) &&
+	    entry->addr.proto != 0) {
+		NL_SET_ERR_MSG(extack, "Unknown entry protocol");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct nla_policy mdba_get_policy[MDBA_GET_ENTRY_MAX + 1] = {
+	[MDBA_GET_ENTRY] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+						  rtnl_validate_mdb_entry_get,
+						  sizeof(struct br_mdb_entry)),
+	[MDBA_GET_ENTRY_ATTRS] = { .type = NLA_NESTED },
+};
+
+static int rtnl_mdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[MDBA_GET_ENTRY_MAX + 1];
+	struct net *net = sock_net(in_skb->sk);
+	struct br_port_msg *bpm;
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse(nlh, sizeof(struct br_port_msg), tb,
+			  MDBA_GET_ENTRY_MAX, mdba_get_policy, extack);
+	if (err)
+		return err;
+
+	bpm = nlmsg_data(nlh);
+	if (!bpm->ifindex) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		return -EINVAL;
+	}
+
+	dev = __dev_get_by_index(net, bpm->ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Device doesn't exist");
+		return -ENODEV;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, MDBA_GET_ENTRY)) {
+		NL_SET_ERR_MSG(extack, "Missing MDBA_GET_ENTRY attribute");
+		return -EINVAL;
+	}
+
+	if (!dev->netdev_ops->ndo_mdb_get) {
+		NL_SET_ERR_MSG(extack, "Device does not support MDB operations");
+		return -EOPNOTSUPP;
+	}
+
+	return dev->netdev_ops->ndo_mdb_get(dev, tb, NETLINK_CB(in_skb).portid,
+					    nlh->nlmsg_seq, extack);
+}
+
 static int rtnl_validate_mdb_entry(const struct nlattr *attr,
 				   struct netlink_ext_ack *extack)
 {
@@ -6597,7 +6684,7 @@ void __init rtnetlink_init(void)
 		      0);
 	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
 
-	rtnl_register(PF_BRIDGE, RTM_GETMDB, NULL, rtnl_mdb_dump, 0);
+	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
 	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
 	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
 }
-- 
2.40.1


