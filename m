Return-Path: <netdev+bounces-44172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521807D6BAF
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A00281BB6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A727EF2;
	Wed, 25 Oct 2023 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/Vmma80"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7128DAD
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:31:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E5E18D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9rnSN5jVDkKbgCoIMHDJhgOIdJlvVOwpAmiBnoR01ZAQO97D/eNhz7vh8VzmMIziOh8ybP6B+Mh8ELAsYYqeBU7vwJYikNsQbod0ERObWlCTCUkE5vYGTynRk0/it3OcizMF5+Sg2x/5Pm59m31hm/Klkxou19fKsnQsfPu3VMDQ8Tac/qBCXN7NMeUexaqQtWCARpiv6TRBx4VDryviolwG3PgADrgjLtKFCTU8PO7dhg4eWahVzAVs7U4OrPjjzwvn8ltl8LC8FaP6NXGTYgzkqYxRHOrI1GYj7ZPGWkIxIO890yNZc563PxK6ppST8gudpjQJ/vsoOb7Ymcz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMc1576cnOAMBc207fObNT5qpR1AE3RoUwTUK2WaTg0=;
 b=kmpbp0TVchS3FoSyRSYretMAwyYjFDSMKCFEk8cSURM5n8kUlCA1ANF7K4pU0jPCO3OnBLnMoc6QpIB3VazLK9pG4An0oZ8fyr2AfM4lUX2W/Ub2Gn2WhtddA9TRsh31ZHkQZmmsB9Ggi3Ip2QB9YTy2ajxi4E02Pj2pzKYDp5nUY3fh4xfSGaKAOHTnUMhRzF5z4fWH9yUPULQB0o70ZwfYMdlZKIDpwXRrzSjlQ5clU1Bor+1sdX25elIV/sKLYjhrV3xGQlcG6Jx6TvlLIT9SitzgbqKDdNWMliCitDanPwXcQxPkEWZMUk4QMqq+dFZsVoFkPTkF5wqHTx/2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMc1576cnOAMBc207fObNT5qpR1AE3RoUwTUK2WaTg0=;
 b=M/Vmma80v/2Pf1MvpjyJxwJc2KMk32/bjxOx7qXqml0Fm4m2mTezSgMJlXcDfjBkO1s6lAqLM4xTXNnzuxqWG5j4o0iNuUcf3URsJz5gyIlFggGZBSgFMMODLIqQPuUdAgUKm8NT+VBFbKSIUJgCIjVvimdPHDe0ShSTzq6JhtXHrl78gKamCzTYjOpy5eljOqf7JHO4SFXugRHGhZK7PjA/W2sESQddfHc/ZWdH6YiCDnYQTOjjO5M7Ro5cx1YoN2CBNbQpDckiqLcWUNFejeTpylDzqLrpfj1ODpnBPkm64x/jwJUW8rKga9MMJ96MGkulxX8W3qQwutoFbAmZRg==
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 12:31:45 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::df) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:23 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 09/13] bridge: mcast: Add MDB get support
Date: Wed, 25 Oct 2023 15:30:16 +0300
Message-ID: <20231025123020.788710-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 793b87da-9c43-4da2-d409-08dbd55659b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pg+B12tTKt5FLVoy2F0QiXEmDVuMU1xWmSpsG7pdJERd7VWXKpBPS6P7yTP91JwmxN7GRIRJugRVyM4NpJz0FeA584+gWPNQ1BufqCBogPKi07i2RebPpADY/+AsA0Q5Vd6A8sCvfzhRFVkWG7Bk/x/KhzjOSU1m1I1A9yT55Fe8tFb8lO9aQ9O/MNdHK0ougxNB0AI9Kh8PrKslX+Dhsy8Xzywyis4l7gzVL4xRYUK7havSyocVc7iCHeBYd2InqR4nsyKnEyvpqjOSJjLaSKH0cy7121XwIrdTTgzN78Ee9OIBzB2nkLUUAlbNDB63K9G6rIQssL4M7mk77nk5dcIs3aAQN9ATkPp3Px1tp+f+3F2+PIVBbPbDjvk9J5PkK61wRgtViAhL8kujF/VJjyp+AEcmW250cspcqyQxnxekRfc8CNWRXOUeR5bRO3dAIKnq5pBDqmkuUg2TL6+0MgLog3apAXUfFpurz+ZuuheDPF/k4bdvyps3xaCNpCuBy6c3bkXoCpXhhiuGrtdHu4OrhyLL0V90NabvG7yyQIsx23+tPR4V3nplpq4UVnGA6G2THrq8erySMZXhB9jN+44SFz+uHSzpWQo3/06KN4NOAcfAv4dfU2vNTBR8sh8QK5YAWQ9iDTWuoytnM6B1S63jT54dQyeRsicraR50HY27nmmNsPnP8qLXhjgcaIqUQirCZQ7JmK4adKxu1EIRrHLTo5wr79FHnDKxSf56/U/PYG7+Q4sr0tNO7/R5fIQa
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(54906003)(82740400003)(110136005)(70586007)(316002)(356005)(26005)(86362001)(36860700001)(7636003)(16526019)(83380400001)(1076003)(336012)(2616005)(6666004)(107886003)(426003)(8936002)(41300700001)(70206006)(2906002)(478600001)(8676002)(47076005)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:45.0749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793b87da-9c43-4da2-d409-08dbd55659b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

Implement support for MDB get operation by looking up a matching MDB
entry, allocating the skb according to the entry's size and then filling
in the response. The operation is performed under the bridge multicast
lock to ensure that the entry does not change between the time the reply
size is determined and when the reply is filled in.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add a comment above spin_lock_bh().

 net/bridge/br_device.c  |   1 +
 net/bridge/br_mdb.c     | 158 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |   9 +++
 3 files changed, 168 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index d624710b384a..8f40de3af154 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -472,6 +472,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_mdb_add		 = br_mdb_add,
 	.ndo_mdb_del		 = br_mdb_del,
 	.ndo_mdb_dump		 = br_mdb_dump,
+	.ndo_mdb_get		 = br_mdb_get,
 	.ndo_bridge_getlink	 = br_getlink,
 	.ndo_bridge_setlink	 = br_setlink,
 	.ndo_bridge_dellink	 = br_dellink,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 42983f6a0abd..8cc526067bc2 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1411,3 +1411,161 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	br_mdb_config_fini(&cfg);
 	return err;
 }
+
+static const struct nla_policy br_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
+					      sizeof(struct in_addr),
+					      sizeof(struct in6_addr)),
+};
+
+static int br_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
+			    struct br_ip *group, struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_GET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	int err;
+
+	if (!tb[MDBA_GET_ENTRY_ATTRS]) {
+		__mdb_entry_to_br_ip(entry, group, NULL);
+		return 0;
+	}
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_GET_ENTRY_ATTRS], br_mdbe_attrs_get_pol,
+			       extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_SOURCE] &&
+	    !is_valid_mdb_source(mdbe_attrs[MDBE_ATTR_SOURCE],
+				 entry->addr.proto, extack))
+		return -EINVAL;
+
+	__mdb_entry_to_br_ip(entry, group, mdbe_attrs);
+
+	return 0;
+}
+
+static struct sk_buff *
+br_mdb_get_reply_alloc(const struct net_bridge_mdb_entry *mp)
+{
+	struct net_bridge_port_group *pg;
+	size_t nlmsg_size;
+
+	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+		     /* MDBA_MDB */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY */
+		     nla_total_size(0);
+
+	if (mp->host_joined)
+		nlmsg_size += rtnl_mdb_nlmsg_pg_size(NULL);
+
+	for (pg = mlock_dereference(mp->ports, mp->br); pg;
+	     pg = mlock_dereference(pg->next, mp->br))
+		nlmsg_size += rtnl_mdb_nlmsg_pg_size(pg);
+
+	return nlmsg_new(nlmsg_size, GFP_ATOMIC);
+}
+
+static int br_mdb_get_reply_fill(struct sk_buff *skb,
+				 struct net_bridge_mdb_entry *mp, u32 portid,
+				 u32 seq)
+{
+	struct nlattr *mdb_nest, *mdb_entry_nest;
+	struct net_bridge_port_group *pg;
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
+	bpm->ifindex = mp->br->dev->ifindex;
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
+	if (mp->host_joined) {
+		err = __mdb_fill_info(skb, mp, NULL);
+		if (err)
+			goto cancel;
+	}
+
+	for (pg = mlock_dereference(mp->ports, mp->br); pg;
+	     pg = mlock_dereference(pg->next, mp->br)) {
+		err = __mdb_fill_info(skb, mp, pg);
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
+int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
+	       struct netlink_ext_ack *extack)
+{
+	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_mdb_entry *mp;
+	struct sk_buff *skb;
+	struct br_ip group;
+	int err;
+
+	err = br_mdb_get_parse(dev, tb, &group, extack);
+	if (err)
+		return err;
+
+	/* Hold the multicast lock to ensure that the MDB entry does not change
+	 * between the time the reply size is determined and when the reply is
+	 * filled in.
+	 */
+	spin_lock_bh(&br->multicast_lock);
+
+	mp = br_mdb_ip_get(br, &group);
+	if (!mp) {
+		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	skb = br_mdb_get_reply_alloc(mp);
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
+		goto free;
+	}
+
+	spin_unlock_bh(&br->multicast_lock);
+
+	return rtnl_unicast(skb, dev_net(dev), portid);
+
+free:
+	kfree_skb(skb);
+unlock:
+	spin_unlock_bh(&br->multicast_lock);
+	return err;
+}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 40bbcd9f63b5..6b7f36769d03 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1022,6 +1022,8 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	       struct netlink_ext_ack *extack);
 int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 		struct netlink_callback *cb);
+int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
+	       struct netlink_ext_ack *extack);
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 			    struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify);
@@ -1432,6 +1434,13 @@ static inline int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int br_mdb_get(struct net_device *dev, struct nlattr *tb[],
+			     u32 portid, u32 seq,
+			     struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int br_mdb_hash_init(struct net_bridge *br)
 {
 	return 0;
-- 
2.40.1


