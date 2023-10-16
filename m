Return-Path: <netdev+bounces-41326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027D7CA924
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685ACB20D7C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D027EE9;
	Mon, 16 Oct 2023 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kL0gYPtD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897427EC6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0FEE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiKbNFf0tZ5teXxDAU4cIe4NSlpWYjAokSIhrssLHTXLP8oZTiWrSC/ZvGgM5nCy3pzdH1wr1E3F9HT0vasoKX99QRKYa4xu5PMmqboK2TpePPUxS49Wi3Cs4/jjZVUfchsEO+z8aBs1sBd6/+bSx3SQ/y8WOTKn8Y0R1IYEUPTYYOWE1MwPDTPoYEgXW1niMvB+lktOd9w9zASw/y5AIXvc9rlY9YNdx9fcGt8MJvP2B+J36rJUVP6q2R5dcR3NLdZh6MserQC3Y3GCdgHc7KLUYBtbPtKjrzrnX+X6ZuM4RjUc0489anrv4virIZRfPZp+8OilXo7OCxx+p5zllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwGvxzFaRNUgq/+3HyNi1CY3UXPyoqzFSQ7rdYIziUQ=;
 b=VcO2WQwvaYW7wye4kcD0lYsd19ht/xnawyJUvyqErg0fX80IvDcwwvKgz7Sm4PVM0nN45iCoPuLr92KM03LXSq3VLwlsfp1JjTZd5aX4vT5+kU9Ql8gRiFVN9XFaiUCTbwO+qxpKHMrt7G7x7anle/MXH6Iu5n+kHkTLV9qheaO3oW0s5rsP7MTkpRQAkdWCIPf8AIkfdAD/qY3LeYGiX7o6KVtR95bi8Jke02uLkx3wgzh6Tm6kUi/INCe9rFrZOCslFaBGWCftUTt70ZoCznoF+xTuSxJrY2gxbsEu2RgYJeuPZAM4U/mhETeFs29oxFs7mWEspxkOtbH8vM5Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwGvxzFaRNUgq/+3HyNi1CY3UXPyoqzFSQ7rdYIziUQ=;
 b=kL0gYPtDaEJJY5JSz/GDuzJnTrJ2H1xCV6QwtlyaBy8BH1O5MibxSzZSYKTxeu80BD5KD8hXLuKQSH53kvdexFctlPnDmI1SKOk7NMq0NSLPxES7stVlzolniqjqNMVpDoQ7YieR6lva+LuRRfWSJ+MUZZuIhQGmeZbP4iINsmVcB2jmPoMmqo6O8SboQD4ogAxVD8HFfq/YVkVkSK01KmaKoQ0OHTPu9YiR72tRnN3JcmfpEeX47ZLGRbOnqlwX5I28lQXzGG2/dZlUuKOkS7LqMfPv7JxuZcA/YOIfVZMnj4nfhNw/G9Fh/17WXURGIrAw87Yz8SzQnxIL1ThOFw==
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 13:14:20 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::e5) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:14:05 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:14:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 10/13] vxlan: mdb: Add MDB get support
Date: Mon, 16 Oct 2023 16:12:56 +0300
Message-ID: <20231016131259.3302298-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: a189580e-3f7a-4f2c-1442-08dbce49cf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7svVp7gldBznHA9w9QzCBcq/nCpMS5DpHiJa9qkJInNY7keWxRVEJO1Lak/dOsgxcYubG6KSqUTYN9Q73brmiev2UVtAMZjMteTeVAAI5DhGJfSxuiA3h81RdTzpjKbrxofotq4GZlm7ZxLk0x4dA/D+DzcUhNnIFH+l7f2ikwuLHuFDOOxt93YZ3+ruZLEWSGBzy/k7bBgc37sZzZXlzNbOLzkuDKbLosCUzmNIKa9dUAhAEltGYwC7AK6yQR/+v9zkB705qVESWfcvjDUdXVBZPENDzn/sPEkJtEheiccF0N521pNLSnIyrGP2pCHEOAGPfjjBs9itKNIBBwigTDJEeeGgbIT2eIMoktzKN39vPP8oQeNitYxyD47jKxtsfFvfj252NNiFrM2QAIe3rNpFgZWJFOUy7LJhgSZPEaYzVRv0s4JOb8EXpjQcY6+tF4H7tjee8YvfN8FQ8DZhUAgbWCfQQEfBHxLzS52KG5N8X9m9yDpT8n4QCPJzBWvnY+fvwvhseHVMB2wdmzH2kC7L07B1IBc7EPtSbjaWfWYE9+QtVauSz8/YZt2awNZFh8va9q1nihsBMMqGhPuwQojZN08eK8f+bNLJhI7IcplT8WDOpMgsqbdiR9kBNEAfo/wV1hOmRL6pSJSmVGeFiqLZdZ2Umd/3elK8TVO8pDfsrznTjfMDrkkLfIRFNVKUCwkDRkToLv2Sd/OzFkTPfHGZ5pzRQe8DsTl8xtSCRwmZfs1gSa1ySSIWA/iGgcUP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(110136005)(478600001)(70586007)(70206006)(6666004)(54906003)(1076003)(16526019)(26005)(107886003)(426003)(2616005)(336012)(316002)(36756003)(8936002)(8676002)(4326008)(2906002)(41300700001)(5660300002)(7636003)(86362001)(47076005)(356005)(36860700001)(82740400003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:20.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a189580e-3f7a-4f2c-1442-08dbce49cf17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement support for MDB get operation by looking up a matching MDB
entry, allocating the skb according to the entry's size and then filling
in the response.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    |   1 +
 drivers/net/vxlan/vxlan_mdb.c     | 150 ++++++++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_private.h |   2 +
 3 files changed, 153 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f7d45e3cfa2..7ed19f2cf6f5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3302,6 +3302,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_mdb_add		= vxlan_mdb_add,
 	.ndo_mdb_del		= vxlan_mdb_del,
 	.ndo_mdb_dump		= vxlan_mdb_dump,
+	.ndo_mdb_get		= vxlan_mdb_get,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
 };
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 19640f7e3a88..e472fd67fc2e 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1306,6 +1306,156 @@ int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
+static const struct nla_policy vxlan_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
+					      sizeof(struct in_addr),
+					      sizeof(struct in6_addr)),
+	[MDBE_ATTR_SRC_VNI] = NLA_POLICY_FULL_RANGE(NLA_U32, &vni_range),
+};
+
+static int vxlan_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
+			       struct vxlan_mdb_entry_key *group,
+			       struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_GET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err;
+
+	memset(group, 0, sizeof(*group));
+	group->vni = vxlan->default_dst.remote_vni;
+
+	if (!tb[MDBA_GET_ENTRY_ATTRS]) {
+		vxlan_mdb_group_set(group, entry, NULL);
+		return 0;
+	}
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_GET_ENTRY_ATTRS],
+			       vxlan_mdbe_attrs_get_pol, extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_SOURCE] &&
+	    !vxlan_mdb_is_valid_source(mdbe_attrs[MDBE_ATTR_SOURCE],
+				       entry->addr.proto, extack))
+		return -EINVAL;
+
+	vxlan_mdb_group_set(group, entry, mdbe_attrs[MDBE_ATTR_SOURCE]);
+
+	if (mdbe_attrs[MDBE_ATTR_SRC_VNI])
+		group->vni =
+			cpu_to_be32(nla_get_u32(mdbe_attrs[MDBE_ATTR_SRC_VNI]));
+
+	return 0;
+}
+
+static struct sk_buff *
+vxlan_mdb_get_reply_alloc(const struct vxlan_dev *vxlan,
+			  const struct vxlan_mdb_entry *mdb_entry)
+{
+	struct vxlan_mdb_remote *remote;
+	size_t nlmsg_size;
+
+	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+		     /* MDBA_MDB */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY */
+		     nla_total_size(0);
+
+	list_for_each_entry(remote, &mdb_entry->remotes, list)
+		nlmsg_size += vxlan_mdb_nlmsg_remote_size(vxlan, mdb_entry,
+							  remote);
+
+	return nlmsg_new(nlmsg_size, GFP_KERNEL);
+}
+
+static int
+vxlan_mdb_get_reply_fill(const struct vxlan_dev *vxlan,
+			 struct sk_buff *skb,
+			 const struct vxlan_mdb_entry *mdb_entry,
+			 u32 portid, u32 seq)
+{
+	struct nlattr *mdb_nest, *mdb_entry_nest;
+	struct vxlan_mdb_remote *remote;
+	struct br_port_msg *bpm;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = nlmsg_put(skb, portid, seq, RTM_NEWMDB, sizeof(*bpm), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	bpm = nlmsg_data(nlh);
+	memset(bpm, 0, sizeof(*bpm));
+	bpm->family  = AF_BRIDGE;
+	bpm->ifindex = vxlan->dev->ifindex;
+	mdb_nest = nla_nest_start_noflag(skb, MDBA_MDB);
+	if (!mdb_nest) {
+		err = -EMSGSIZE;
+		goto cancel;
+	}
+	mdb_entry_nest = nla_nest_start_noflag(skb, MDBA_MDB_ENTRY);
+	if (!mdb_entry_nest) {
+		err = -EMSGSIZE;
+		goto cancel;
+	}
+
+	list_for_each_entry(remote, &mdb_entry->remotes, list) {
+		err = vxlan_mdb_entry_info_fill(vxlan, skb, mdb_entry, remote);
+		if (err)
+			goto cancel;
+	}
+
+	nla_nest_end(skb, mdb_entry_nest);
+	nla_nest_end(skb, mdb_nest);
+	nlmsg_end(skb, nlh);
+
+	return 0;
+
+cancel:
+	nlmsg_cancel(skb, nlh);
+	return err;
+}
+
+int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
+		  u32 seq, struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_mdb_entry *mdb_entry;
+	struct vxlan_mdb_entry_key group;
+	struct sk_buff *skb;
+	int err;
+
+	ASSERT_RTNL();
+
+	err = vxlan_mdb_get_parse(dev, tb, &group, extack);
+	if (err)
+		return err;
+
+	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
+	if (!mdb_entry) {
+		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
+		return -ENOENT;
+	}
+
+	skb = vxlan_mdb_get_reply_alloc(vxlan, mdb_entry);
+	if (!skb)
+		return -ENOMEM;
+
+	err = vxlan_mdb_get_reply_fill(vxlan, skb, mdb_entry, portid, seq);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
+		goto free;
+	}
+
+	return rtnl_unicast(skb, dev_net(dev), portid);
+
+free:
+	kfree_skb(skb);
+	return err;
+}
+
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni)
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 817fa3075842..db679c380955 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -235,6 +235,8 @@ int vxlan_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 		  struct netlink_ext_ack *extack);
 int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 		  struct netlink_ext_ack *extack);
+int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
+		  u32 seq, struct netlink_ext_ack *extack);
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni);
-- 
2.40.1


