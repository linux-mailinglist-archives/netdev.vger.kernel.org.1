Return-Path: <netdev+bounces-41324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A417CA922
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BD81C20B6F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5E27EF1;
	Mon, 16 Oct 2023 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6E+DKMj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686C28695
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7495FB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVQCL0rr+G7Q8VA+3MwZYcfP3cIpKyL9xSPO42wfs3922vgz0+RwPwrvWmm57CYQD1FALsTwdWc2l/UUvXpW8xKtIDRhBQr9j8HThQ/2SXwAWRjO7ncIK9eC2TqtEwGKFkLUXjPRVopAPN11vL7D/jnZ1G6pmHma6mRssmXTFqpXA69eZhM0v5vQB0ighBrbQxBRjpEkWdCngGqgNhVtwEvQwpQbv/iJDbzHKH+PkyDt6uM6yO7shim99pKe4sMdUUEbIzge7JhIw4NlFO5UXyEyEyhsaU7gyKh9j6gardkueC4kcmudR+r3RhEYlX85RA4AUKdIv8CqP9FJocWFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WSgNZIgfh1KxIH01jmMzAvHYyylas9H8JzLUVFsdco=;
 b=NK50LDL00q/qmJXog+UEDLYXzXF7Kw0bR9OhX4QVt+rldHds53yQq+nG2jw+1jsXhgJF4XQCh5XUQZi1o/7pwXxD0Vg73O13TGJ8Y9bHckWPvbDrK9MmN5Bo2KAcWH55OZB+fA+YSNge5vksiIfS98fRpm4JhN1xlvKfuQ5Eyo6xJHnxitegDu9rWAID7mVVaHm5RiW2Aikxyfan/Eo8U3PoLTRQGa+uKv6zO0OSV0YPAN82JBhXfZA+ogzhqlAgPsPo43zeW3R9R/WNIj15fsS+rfvX7hDgDPDPtiFPppBF8U7UMEJgjJ9zwj3mtmemA3K31XxFpyh8Tkjqi9FuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WSgNZIgfh1KxIH01jmMzAvHYyylas9H8JzLUVFsdco=;
 b=B6E+DKMjZQ80mmSTfjgDkD2eym1+4si1UeUdwfxE2JkAsZmS9bamKBFMCoQqSXV7m0ertW8LwDNF7vBssE0mcxYZspKOtdvAeAUdaROHyyscHG3U6Mnkwx6NORkVty1mN5rO64P2IYMCJu+FDRu4f2w80ss942cGNZDoJX5SvOfFKQmw9KVfS+lTqRr65go6CcfCWXgrt/SBt9Yz7jrsjtnQrKn/DNblLeAXx6byKT3/qG/YuUoVZH3up4Op4bMo2BMQweeHo05IYWTPJQE5ruU84HXwOvaEvkuIcZmElYBwGu+PzisdumPlsUoUDigFOvqncrXPY4JD8B7/MbhqhA==
Received: from MW4PR04CA0150.namprd04.prod.outlook.com (2603:10b6:303:84::35)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 13:14:15 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::b0) by MW4PR04CA0150.outlook.office365.com
 (2603:10b6:303:84::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:14:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:13:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 09/13] bridge: mcast: Add MDB get support
Date: Mon, 16 Oct 2023 16:12:55 +0300
Message-ID: <20231016131259.3302298-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a726108-d69d-49a7-a8cc-08dbce49cbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxoLa31KL6A0wR3Ls88FXssy670KrEmBQ0eCCH2r5Xiyru1tFCG/ugyO6LV55UCKQAcuDDoj5rGcwF5X95BU9V+iug8kXVwIx7ZmXu6ARuTSqE5kDyRe43GVaXJ5u+ZGtkLnYVMgcDThj/8JMHQZPZvPtAxswc6m8qWbdd1o3973dWv9uWFmGtiIIu/qzqSd8t7nito/Z3N3rJWOTdsxNpmOxcY8i+ibFJHXMgPCrZ1w+l50t9VWTfddj925BoD7pYxpCIryElULI7a15UY1sBASofz6j3icpDcISo/yG70X6scwxE0/eiJXiFqFL0E/F8hhW51vM2ogupHmsCgYKuBR1dEDT8i2UXDcf6C5XxjYi42ezpLHlUMlggcfo4QqqDt1DpsO/iz2meAhOVGtGP61JlGYzfGpizsLn+6AiI87CDwikb/YLjjIb96ki7lmYdLd+0wuoq6i8HFuc1it/eBewVAfmQ73vZuZFcGN3yE0f/ls4WJB1dutaaAH6JS9aAew2Ez9eGPHImCNiR0swK7QnOqs+1f2b/P75z8LU0h2zDOLLQ+D8+3rGhRTMxjM5BLZPC+Oc/G9lfLRZuCyXDFXFLEAMf58hUaniJuptLr7Cgc2yWtpjILEJlR068QAD1Uukh1PlMueUiuECwQ61d/uANx3NZsZGj1QZChN2JK83KKqvf3HAwxI7WXaJppaOYRJH9/a7DbifbrOtrmCQuweW1GxitwpUfQPYvO0fZhxwMS6hIbThbfxTTiiCug6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(36756003)(40480700001)(8676002)(36860700001)(4326008)(8936002)(107886003)(47076005)(2906002)(5660300002)(426003)(26005)(2616005)(1076003)(336012)(16526019)(83380400001)(478600001)(316002)(41300700001)(110136005)(54906003)(70206006)(70586007)(82740400003)(6666004)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:15.0385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a726108-d69d-49a7-a8cc-08dbce49cbe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement support for MDB get operation by looking up a matching MDB
entry, allocating the skb according to the entry's size and then filling
in the response. The operation is performed under the bridge multicast
lock to ensure that the entry does not change between the time the reply
size is determined and when the reply is filled in.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_device.c  |   1 +
 net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |   9 +++
 3 files changed, 164 insertions(+)

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
index 42983f6a0abd..973e27fe3498 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1411,3 +1411,157 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
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
index 3220898424ce..ad49d5008ec2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1018,6 +1018,8 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	       struct netlink_ext_ack *extack);
 int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 		struct netlink_callback *cb);
+int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
+	       struct netlink_ext_ack *extack);
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 			    struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify);
@@ -1428,6 +1430,13 @@ static inline int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
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


