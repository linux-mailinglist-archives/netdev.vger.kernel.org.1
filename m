Return-Path: <netdev+bounces-58327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D7815E2F
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5980F283B9B
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224591874;
	Sun, 17 Dec 2023 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dj3PrcS7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545623C6
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc47gb3zy97cfCA+udL4f2Uchl1nKqunLLLBwjlb8CsrpzZtBIgHxrV6ttFn2FjdIU/zWsBjozazYKV4JpCWBc+3gcLC2ESwVTwQSwWzgL9JdmJJ4yhNHpWmo9Vs2WKSsusy/RwyVIlpf+Z81k0i8gjfd9GL0yS6cgHkTpwqQAdqeq/LBsmvh6BpnXi9BgLlszbjIKxav5aApGUSVGchGfvMcpLaPeiR/M2NqoiVgYFsI0sYdFpd/MaY8ZxoEGIt98rEKA1miw5NNjzK79slAjhCbwImnel5ZKY1V6xbAPR5D0f1m43wXxrCT+aGkEXyeoMlaAymbY/On5Li/m0SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grIgbEgC0Kw2ibepzV+xhiwMyJwl4unFCYZttEi8WIY=;
 b=oZxXEEAkhMjg7eaiTKP1RGBaWIBTLB3gqMnL522qjCkFoA5S2vRY6UaDoHR+2oaCODuM6zFR/zklfgNBilkcJvnYl6aB2wULdnoEtgE8RYyxndGJqidIasW390t1cnWl39MUfi3kb1W4RaeSwShpC9GEYh/MnNTvkWLJRtHETVOF67wy08TiVm194BOcZFzgS2mYiK52pJT3kgx/fY75sqo1Ys0fjBkJLy9r7HP3byL96FbYFfiN84DsooKCwp0CZH2a8waSwjmqpFQC/5VH/Y1jgFdfaq8Il3v+cyWmd80kf/+WDcTZF5XpH8WFE3/tqL+wW/8iy6ztnFX4IOMyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grIgbEgC0Kw2ibepzV+xhiwMyJwl4unFCYZttEi8WIY=;
 b=dj3PrcS7gnruLkcrDUuREUaeIRSHaqAU4p9oIofTIW5lZY2gLtlCFO+XDYo8A+vVPV9UFTTc+P9ZHjXK+3/sPZ+b3I3C7erQ76kIsHshw4TfjDg759+rZIK+3lVbeIeJOWQGCJQPd13x2naLf8Ud2DAUJKLCpOB1dF7yLRsK40+p+0HdsEhu6CkZGtNUtVHPxyhE7Cm/ZlqqlmMlzlBh+yq5a7Wl9KuLGfVlg4xF0goOaVDkxSXNpNBMoI1ua458+HHuRCijuWK53V1eI1TbuPGejlK4zvb1bRWRjy+ZNn/DBa67I04MiZdNzxOI0TaB8AGaIgzhJm1H18WImmILuw==
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:37 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::6) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:33 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:30 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/9] bridge: mdb: Add MDB bulk deletion support
Date: Sun, 17 Dec 2023 10:32:40 +0200
Message-ID: <20231217083244.4076193-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b776d6b-774f-4b84-9b49-08dbfedadd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YoPvoCehJeSwoHM9yuTIz2BXJaKZKnafXNjCovRvHWF4O5TW/eD5JNR6osViziQVZaVGu+vVClQ08QRY6jCsdo1vlDuvmkanrnEROC0MFHLSJrK3yjub3Rp9Z7C6LyeGtd1RbRbcbf15po2kQGg0oT6JswhlpHroKl+ffAkJYpj1S4n6J32GzxxAEHiiWfjPd+dDoP8K5Deu5NXS9IW2RNn2f2e5MahxY9B7Tiee/TIsIcGUz0GiyPNdl4nSatZ5R+zHfY/Pu1UYG9T7NCQLzOTLOp77J1y2WN8uK/AfaznyILVRM2Ymb7yxyQOxWrPOe29SVf0AiJ+A0c2x9ej88EhwugwIqC8kj2W2oeJNRkcRxCeDOfy5yWMnyHyxrcPNgKftG7xYXAokhNhA3HMo0TFRZq10qkGI9/LOQaozQjT9K2HAoJQOhPXgR3NwKDG2supRR8C/886kbERCaacaJvWvc15bTvhZoDtvYezBzsnMgr4D0I7MC9T52jdtDV+nZMD8btdLklUOZvXn+UkhQBfpDM8bOkXXEAFwBeKnsWAWtqeUISDGI9huRdkC/VnHiDMlpfOLGXE8jMysKTiSUMdDvPBq+TDLzZXaYGPe322VqLCjADesbqWqFjL5kivmW8qqikDounOsCfcaP+Qp8V6lnAy7aPC2OvowT883FjQsaOi5u7CamAsH99V002cubEPPI4NjymP5s9yNhSq0KqUf+JTUvZvQgpGLKY+BPvo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(8936002)(8676002)(4326008)(36860700001)(5660300002)(2906002)(47076005)(6666004)(83380400001)(316002)(110136005)(54906003)(70586007)(70206006)(40480700001)(336012)(426003)(40460700003)(356005)(82740400003)(41300700001)(7636003)(478600001)(1076003)(107886003)(26005)(16526019)(86362001)(2616005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:37.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b776d6b-774f-4b84-9b49-08dbfedadd46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

Implement MDB bulk deletion support in the bridge driver, allowing MDB
entries to be deleted in bulk according to provided parameters.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_device.c  |   1 +
 net/bridge/br_mdb.c     | 133 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |   8 +++
 3 files changed, 142 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8f40de3af154..65cee0ad3c1b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -471,6 +471,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_fdb_get		 = br_fdb_get,
 	.ndo_mdb_add		 = br_mdb_add,
 	.ndo_mdb_del		 = br_mdb_del,
+	.ndo_mdb_del_bulk	 = br_mdb_del_bulk,
 	.ndo_mdb_dump		 = br_mdb_dump,
 	.ndo_mdb_get		 = br_mdb_get,
 	.ndo_bridge_getlink	 = br_getlink,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 8cc526067bc2..bc37e47ad829 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1412,6 +1412,139 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
+struct br_mdb_flush_desc {
+	u32 port_ifindex;
+	u16 vid;
+	u8 rt_protocol;
+	u8 state;
+	u8 state_mask;
+};
+
+static const struct nla_policy br_mdbe_attrs_del_bulk_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
+	[MDBE_ATTR_STATE_MASK] = NLA_POLICY_MASK(NLA_U8, MDB_PERMANENT),
+};
+
+static int br_mdb_flush_desc_init(struct br_mdb_flush_desc *desc,
+				  struct nlattr *tb[],
+				  struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	int err;
+
+	desc->port_ifindex = entry->ifindex;
+	desc->vid = entry->vid;
+	desc->state = entry->state;
+
+	if (!tb[MDBA_SET_ENTRY_ATTRS])
+		return 0;
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_SET_ENTRY_ATTRS],
+			       br_mdbe_attrs_del_bulk_pol, extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_STATE_MASK])
+		desc->state_mask = nla_get_u8(mdbe_attrs[MDBE_ATTR_STATE_MASK]);
+
+	if (mdbe_attrs[MDBE_ATTR_RTPROT])
+		desc->rt_protocol = nla_get_u8(mdbe_attrs[MDBE_ATTR_RTPROT]);
+
+	return 0;
+}
+
+static void br_mdb_flush_host(struct net_bridge *br,
+			      struct net_bridge_mdb_entry *mp,
+			      const struct br_mdb_flush_desc *desc)
+{
+	u8 state;
+
+	if (desc->port_ifindex && desc->port_ifindex != br->dev->ifindex)
+		return;
+
+	if (desc->rt_protocol)
+		return;
+
+	state = br_group_is_l2(&mp->addr) ? MDB_PERMANENT : 0;
+	if (desc->state_mask && (state & desc->state_mask) != desc->state)
+		return;
+
+	br_multicast_host_leave(mp, true);
+	if (!mp->ports && netif_running(br->dev))
+		mod_timer(&mp->timer, jiffies);
+}
+
+static void br_mdb_flush_pgs(struct net_bridge *br,
+			     struct net_bridge_mdb_entry *mp,
+			     const struct br_mdb_flush_desc *desc)
+{
+	struct net_bridge_port_group __rcu **pp;
+	struct net_bridge_port_group *p;
+
+	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;) {
+		u8 state;
+
+		if (desc->port_ifindex &&
+		    desc->port_ifindex != p->key.port->dev->ifindex) {
+			pp = &p->next;
+			continue;
+		}
+
+		if (desc->rt_protocol && desc->rt_protocol != p->rt_protocol) {
+			pp = &p->next;
+			continue;
+		}
+
+		state = p->flags & MDB_PG_FLAGS_PERMANENT ? MDB_PERMANENT : 0;
+		if (desc->state_mask &&
+		    (state & desc->state_mask) != desc->state) {
+			pp = &p->next;
+			continue;
+		}
+
+		br_multicast_del_pg(mp, p, pp);
+	}
+}
+
+static void br_mdb_flush(struct net_bridge *br,
+			 const struct br_mdb_flush_desc *desc)
+{
+	struct net_bridge_mdb_entry *mp;
+
+	spin_lock_bh(&br->multicast_lock);
+
+	/* Safe variant is not needed because entries are removed from the list
+	 * upon group timer expiration or bridge deletion.
+	 */
+	hlist_for_each_entry(mp, &br->mdb_list, mdb_node) {
+		if (desc->vid && desc->vid != mp->addr.vid)
+			continue;
+
+		br_mdb_flush_host(br, mp, desc);
+		br_mdb_flush_pgs(br, mp, desc);
+	}
+
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+int br_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
+		    struct netlink_ext_ack *extack)
+{
+	struct net_bridge *br = netdev_priv(dev);
+	struct br_mdb_flush_desc desc = {};
+	int err;
+
+	err = br_mdb_flush_desc_init(&desc, tb, extack);
+	if (err)
+		return err;
+
+	br_mdb_flush(br, &desc);
+
+	return 0;
+}
+
 static const struct nla_policy br_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
 					      sizeof(struct in_addr),
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 051ea81864ac..b0a92c344722 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1022,6 +1022,8 @@ int br_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 	       struct netlink_ext_ack *extack);
 int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	       struct netlink_ext_ack *extack);
+int br_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
+		    struct netlink_ext_ack *extack);
 int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 		struct netlink_callback *cb);
 int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
@@ -1430,6 +1432,12 @@ static inline int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return -EOPNOTSUPP;
 }
 
+static inline int br_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
+				  struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 			      struct netlink_callback *cb)
 {
-- 
2.40.1


