Return-Path: <netdev+bounces-44173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A27D6BB0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16421C20DE9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198128699;
	Wed, 25 Oct 2023 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCvut/m5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363652868F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:32:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B1D7F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Phk9xIQt06Ve5+aiMa5/8X6Qt1HAmxvMZ/jXdTQCTBkwnWO3zOdozJV16ErIPFhGyZjMbsfO3BIIqsJi3IWtGQ0EqoxYLa9/GjUD2FofziX3lKGWDZ+fYOd5apDzhqo02RWxfXSFGNGkWplXP2kX4u9WouKijqEJ1c5tRRgopDmaOR3r8lEZ/zKTddjbPlAWOF2wSj5zCRiHYSalg5ji9E0uyKsW4pNSS6JMh4KDzzl7h4iNlA1ZyYysz5YitKh4tzsSOHCxcNUo1RLmaxCWVraUPNRzptO1UTt9LO/rBvtsd+JZYYTRcSAVPBhyQzc3y9HQRO7Ct2mJrqvPTs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5kdUNascDBnvl6hfgFAKpKsZ/PM0KlqTbaFTekvizo=;
 b=QnibfPOMQNUSATGtm4PA36L618uI8pFa5KZDGYAu7oSLz0ktb4sUeLjmDeds56rcg7J1yHpHdgw3QMU2Dzv/1144vTisCbJnxI3OL6i3rU2QLIEDd0g3uooZopGx+ln9Mipjmxmgz/Xjte1DpkyYA7f/GgKkr+JGU/MdJ9UNKmSLKcjuUrpkPE1bd1H7akeMBDvaKFDCOAZRVf+YU/WeWKbC7U1tBmj71Oli3/6celTNIqE0Squ9U3/zHZ37taVnBT0wGkTnUAq4pX3iUv/l0zwGXPHWoEl8vGIcWdfNgLgIGWaghaIRpwA6zqr1bGIFGTxT6rJMc7UTtmzqQiUZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5kdUNascDBnvl6hfgFAKpKsZ/PM0KlqTbaFTekvizo=;
 b=QCvut/m5MvI5aYCbJqY0vms6gTk7qB5leQwyZ7W97nsgAtpLiawt6KrvrHRJO+L2/k78AqQZkCvKzmG9q5haThUkZCFvBM39UZqKLcj52rLYoDJKoEYc89HLC3AyYek7JCSJcMzjclzb1Bse4T0bOA1L+XYvn30W7nT5ym5PF0E8o5JOIcKgUd5hHe+zpZXNqQLlH1d1KMpq6YrWpSXN7y5j+4rfTXv8f2/l3X1bYyPy9Cwogx3Yv3c6L8DAOQdL5y1uG+jU78HKoD8SQix4AUOfVInQ3bEGEujmnOJ7zlIJ1BWpvJ4uxsXGck5lsDamzL256Aws46kQS7SF6iRosA==
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Wed, 25 Oct 2023 12:31:48 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::be) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.38 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:30 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:27 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 11/13] rtnetlink: Add MDB get support
Date: Wed, 25 Oct 2023 15:30:18 +0300
Message-ID: <20231025123020.788710-12-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba6a13f-653b-4d97-cf30-08dbd5565b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XVDtcErRRbT5FS1Idurf1ezQJfni65KyDC6VdmNDVRsCH8udRQpWCJKoNrMMxMkKEJ8C3hKRfkJxRfGSY91FFpwRJXD6XW+VLVibT07qAFolc2ybmgc39K3rVIczqn7Kanfx+XUqe8H+HPaoZh2T0yS03x64pJv1pZhPaL98JABUKH2j8PSsxV/nKUQFr9gCusHxAXypd/iXwI9b21sW+Px1Ua3p8HUWG7p+N7zEUUIXcj9sDlVHav8ZfZO8HHGUnvp/ya9QV+USwgLVReC+rtwZN3u+/iFIwBxo5sLncmkLEqjkTMvunND6ccXh33rR2Rj+T9yd/kzUR12N8hxN5yzllR/llXBYEO5iYiNyAz7bXxAM0Fq/53WxvDzzQ9tL0WiGz9AGE6cbyCFYqbT4g0H6KGIaboIJWCItx0/pgFq77WiGyIyDVtS7mZTLx/QDbee8FqR9YEUxdBVvkyLQ3ZWaXYTBu7rzEwDIp1wlSav2uxoRU4FmxDVdGZWG5Nxw2y0bmkWBmZvBj8IfIOXqLiVyH5Cb0lho+g674/H9fC1NZaWOEPmGkn2SnCQVppKB30P8lc0hSyFPYDS6nzYqc/IYX4YiZiYug0sl+b6jHtjVcflOwOCJQ4EEyM84m5ILNa4ZT0g/T2EJ75gLBKB6uphXifSXKXFIj25gFsgfQBE6XZyA5xdbVmg7Nt+MbtAkOvMeLmCnXG+u3LliSGxyeBEdnaSrxKnyP4HVWV5Nsv/pJjiRHunlfeuAvu/BcoRM
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(110136005)(41300700001)(8676002)(8936002)(70586007)(4326008)(316002)(478600001)(70206006)(36860700001)(7636003)(86362001)(356005)(2906002)(47076005)(36756003)(54906003)(40460700003)(5660300002)(40480700001)(2616005)(1076003)(26005)(16526019)(82740400003)(6666004)(336012)(83380400001)(426003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:47.7617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6a13f-653b-4d97-cf30-08dbd5565b53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

Now that both the bridge and VXLAN drivers implement the MDB get net
device operation, expose the functionality to user space by registering
a handler for RTM_GETMDB messages. Derive the net device from the
ifindex specified in the ancillary header and invoke its MDB get NDO.

Note that unlike other get handlers, the allocation of the skb
containing the response is not performed in the common rtnetlink code as
the size is variable and needs to be determined by the respective
driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f2753fd58881..e8431c6c8490 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6219,6 +6219,93 @@ static int rtnl_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
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
@@ -6595,7 +6682,7 @@ void __init rtnetlink_init(void)
 		      0);
 	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
 
-	rtnl_register(PF_BRIDGE, RTM_GETMDB, NULL, rtnl_mdb_dump, 0);
+	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
 	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
 	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
 }
-- 
2.40.1


