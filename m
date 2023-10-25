Return-Path: <netdev+bounces-44171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4F7D6BAC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8761281A57
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177427EF3;
	Wed, 25 Oct 2023 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Obgyf/js"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1F28DA1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:31:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACBD54
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLcwrq4acQ1OsaNBy4tXvOyJM+GvYD4HtDmPIHbELUiaIBkePnZCZ6XVjPt6b8yTznqpffQIdU8qZEMCBVPZtPzvbmbBQb7tP/QShQ+d2XW7B0wR3un/35DHUy7QMI92i9S0Put+3kxYX1Zty/vUO4vnOBLIiOJaUt86LJPxuOcLgixr3SsK7eytJOPfY+jHLhE49vnXhSISTHmd1fMcqoeyupRWVUbIVPgK4JlsyS93CQGP2NyhNBjs1Ek+VfpolkIRHTt85ldXGyan9r58xCIcJidEi5cCyXJ/oY3nWK6zcQC9LIpnicpgJEMty3jd/1T43IVCYDA8fS/CHfuzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bozYL123+pU2pL/x16oNnOXL7ux1jvjVhB57zRU4XIw=;
 b=IG4myOxF8undHSFfFiYsVBqx+70iGnOPwdjbntPyqYmGceCy74ld/ryoJZjSr58KQI/cSFeP4V6o7Lad555DPoovOLmEJKYI+k3hFRJFv9312xerzoX0fuwujfef5Az+YQPcgcN9AISU68a3RROHigT5KVc2imI0sgplMUfqnFVkC15DEzWee/qPS8Cp8ft+TlTAWCf6skoCgwHTZIh8JvHxXT3E4eKppYVb+g0+KlJv4aYagf2ysf3VN8HCyZpmHMGZpW8jHm17TqpfhDMRRRIe0BcdYPAq4/reXRUQ2OmnYJNxOcXQKav70zcCQgsLWwAXbysLFhplj+kEhQP5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bozYL123+pU2pL/x16oNnOXL7ux1jvjVhB57zRU4XIw=;
 b=Obgyf/jsgPIWe1PBWGLOTybU/uQX90paO3lU2hN9h5pi/9UsRTV3/G0Hkw6AmKASf4nFTFX4Vnm8nFImzDZYgzXb2Rmehu/oSt+auXgnstLvfwPswsOcLdvDRv0GzSuMBGhQquH2tsYX8V7vUqlmMKKdN5U+XrEc3jYLbUGmrQ+v0nKfQkh6pFte7wN85c2MOo8dx94cLnkvVnbCd6lz+UqwxN90QsZgv7binPLfdPnIAn26IvJ8UdUYfYCb8jpUafvsHpdTLTp1upa4DIXVywZ5DwDhb3UstZ0sr847WFTb3lwXs1VfrKmtP9z7+MsRRemQ4AO/qRvXNIz9ZWT22Q==
Received: from DM6PR04CA0004.namprd04.prod.outlook.com (2603:10b6:5:334::9) by
 PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 12:31:46 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::81) by DM6PR04CA0004.outlook.office365.com
 (2603:10b6:5:334::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:27 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 10/13] vxlan: mdb: Add MDB get support
Date: Wed, 25 Oct 2023 15:30:17 +0300
Message-ID: <20231025123020.788710-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a0e343-31c3-4529-8fc6-08dbd5565a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q1aVLQbpgv+pRue/Ts9PHdXmNQF6vVurRvcn8pgKdD5iM65Hw32JmdFOUuzxpKzRZrNMPTwqvFrkKqsbmy+dxG0/MNp3lyhlzEsBBav/ZVmsjazoU8pIAo1V2MppLeaqMU+2Xb0FKiGrNtVrbaQ8NtxafMVe1ntcYY1CB8Ti1pmZY09j4tI4eZG+AxqdGj7xo7+2uBQKcTLqXa8Pd1B/8yGu38YMDX2gprnr3ZGGsUjk5c/i/Q9bhnlKrYPstKK+iIHetspphRZkA9vnUpJSQ91sRq1R1Rdddm3Le3ZNaxXLIZ7dlSev9ci4Ig8/ko6Vr1TUBYvSLAPRaNfzcWqUtAHFopngA6zvzF5KGtaBRfwAhGZXPwbeYVwUX3S5DdfbVNWhktMs3LvMTcJCXaT5hXOo7nuwjefq+kVGLXrfVO5zgPy1xYCphoCQSjSRtAVKAq0AuBoywdccansNpGFzN8M6qmRwEd8YTWkkFfl3vF04kH+JYDWKeUD0FqyoAla+Osp9Az2+lY7Ij7i+I4mNNfVFHkCOhdMvHpYXjuIuW0/Ov/6QyHLqoLCnO6BYPtWcKP5UsSjHb56rtojfuPNmvILyZKSI4mkNfxDpFwiJ4xv7s7L3aGz0CKbEYxz8YBBoaax8zSr+DFhli0DKOVJE6xDeg4tYd0ymITin+7wTuhISATGoG5xMLSAUEAgR9e0sJWb6Pj0ARSgCou4tNCRoK2TN04Cjyi8F3NKWNzZnRvFIwTsL+VaJ55NzgmZsjJeY
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(40480700001)(16526019)(6666004)(478600001)(107886003)(2616005)(70586007)(70206006)(110136005)(36756003)(54906003)(1076003)(316002)(86362001)(36860700001)(47076005)(426003)(336012)(26005)(82740400003)(356005)(7636003)(8676002)(8936002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:46.3405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a0e343-31c3-4529-8fc6-08dbd5565a78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562

Implement support for MDB get operation by looking up a matching MDB
entry, allocating the skb according to the entry's size and then filling
in the response.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/vxlan/vxlan_core.c    |   1 +
 drivers/net/vxlan/vxlan_mdb.c     | 150 ++++++++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_private.h |   2 +
 3 files changed, 153 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7b526ae16ed0..901c590caf24 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3226,6 +3226,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
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


