Return-Path: <netdev+bounces-58330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19545815E35
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CB328115B
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FE1FC4;
	Sun, 17 Dec 2023 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5UnWeP3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488B1C20
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkC6TD3ndAnPoI2sw91EyvwKVvvAdJmbySdMRc/DB86q6Erguu/t1VF6XclK5gM2TTk7yajvdJnIUDEODenUgXrzpJniOHcBQ1k1zyRst+RgB7DQpNyeIWkWKyv7oC8bUN7T/45xY7Wi7u6gBC6RXJNAQIDO2byQsxfXIv1EXvr/boPJXAv+oUApNLt8K7OPmj8ezfka7vPvtsK8ppcLWeTQA6vyiTS3jPOCXIyVp2ULGiu5UuUTVpC4j9L+DinGkuQCJM9XdGxn+nnV8iEf1Nh7cs2lUbQ4cDKedBNpILBdwib/hGNh4XIGre2W5zBLv1xMaOTmhaYQXk5PcFeB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQDprmp1z1kzjlqAAycHf9qKiM47uip6JX/iJwcR9UM=;
 b=ZQPGzuVLiEdd4OpGy86ECkXyYD9FAvJVxnnAsLPaPvTB3/M4zPNFxKV0qDjjP7ZJ2xY6kN6cdFItdJ6o1d2kv9P8UfffJSuCEKONx3cqxTgu5pvST9P22OE2AOhrKaPiXEZkcBfWuFbckmA21gYCITJnpBrMNGne9YepNc/fejoVGq3GmA8RLdSVfDSRFic3VzV72NTUw5KOuZsqTwv8Yoq3PGVHySjI7ZI3silTS2qdbi8Je03+t/PGMXvT+hR0ywcXUEt7APVjdjiOvQSz9/qGBo7jIuzh3vOISNXeuPOB5Mp5BFQFzvttnx42YURKYuiCrErxVeAjbjcQFkJDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQDprmp1z1kzjlqAAycHf9qKiM47uip6JX/iJwcR9UM=;
 b=A5UnWeP3czwxYE4F2gPxCRX/jZsKAATMosCjp7DkIeE/YUcOOSJpXqNBG7PCTyc6wo5JGEG9zfmJoqT5t8f4D9gp08ZYdlgI3qC5lBCVOYI0YZT/sIiW8HDXUUZ2OYU0ZoPHwZltUnUhK45GsL1dXbIsyNMpNw2db9rwuXukaRs126Q+jIG4kvhKSAjjbdgOttSaXylfRu1Ervs6i1ifSOoa9EBtUNHQfgOFbXF8amR8Jv6yq/gCFAzC2Jl3IoB/A85GH8ZjtCsYUTpSF8rTlqqCwDmEuz1W2HULJfabvJ1Sdi0NGSoAv8IaG4FB1OYq+NdYGjaUGzFw745V43flFA==
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:43 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::ba) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:36 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:33 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/9] vxlan: mdb: Add MDB bulk deletion support
Date: Sun, 17 Dec 2023 10:32:41 +0200
Message-ID: <20231217083244.4076193-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aeef48-37e2-487e-87eb-08dbfedae100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GYHRGq4bQyOKv++HsVrIZ+XcaFEDHXfr9jWb0ko4uryPdDD/PPq1QuNcPYjix5QY3a4ZTNpcRY+H/hV/IW++hEi+t3dTQPcU+fJrg9XkffUFmBXX+AmpI+f8EyNEX9Vt6NJaeqVkPc6vhnlLNIIA51Pfvs5OTc3bGDggA3ehLCyY5++aW4VMOQFl/ymhu3FV1fCGsyeykNGsMHDut0u9lFuKFQ16ZhWlSaoJWT8Vt0gw/TOYaKCOAHYe/7AlSvbVhzPXlGmj4oQEamxzqLziEAUGKHVTFpsSlbprkKLa+w3Vwt77ryduNt3aGkpaN3fW6uWqK2KHHzH/Dakdp8fAmTu41Z7srYEUgl6hjC6Fm91yXHenl6U3LV16MHyNWWEMgIfFnX6Yf42+ezZeE4pJNiergWkMIjiUSuDUU8pAUyI+cmfBBUWB+i785PDh9PCDcyQdShzY66WsPC2YdgZmax4S8r7taGBJhTq8OMsrF6aSCiCDl5KjvAdHEKm4srgZDb3jOBiIG3OkEzgrvQ/A8ig9AAfWlKhGPWlWb5wGhJI05/o81x29RbCaB17sQblTL4nOrkLqXYwZnAXZW0bBFndUHHIARyEjSQZOUvswosXB//KUOhPWbiGLzn4NsyLUcLDMbP4bUXc04pxrA4ULxZFMTK3p6K6aAdbataMXw4ffsY92ME6gFc9VO8aqTVPnRkVqphra+8xTf29W230zdgJcm6PxJzfPmjTF9NZJu24zvmSY8/xd0DQRFm7Hqm/t
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(336012)(107886003)(2616005)(1076003)(26005)(6666004)(426003)(16526019)(82740400003)(356005)(7636003)(36756003)(86362001)(41300700001)(8936002)(8676002)(4326008)(110136005)(36860700001)(5660300002)(478600001)(2906002)(47076005)(83380400001)(70206006)(70586007)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:43.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aeef48-37e2-487e-87eb-08dbfedae100
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

Implement MDB bulk deletion support in the VXLAN driver, allowing MDB
entries to be deleted in bulk according to provided parameters.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    |   1 +
 drivers/net/vxlan/vxlan_mdb.c     | 174 +++++++++++++++++++++++++-----
 drivers/net/vxlan/vxlan_private.h |   2 +
 3 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 764ea02ff911..16106e088c63 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3235,6 +3235,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_fdb_get		= vxlan_fdb_get,
 	.ndo_mdb_add		= vxlan_mdb_add,
 	.ndo_mdb_del		= vxlan_mdb_del,
+	.ndo_mdb_del_bulk	= vxlan_mdb_del_bulk,
 	.ndo_mdb_dump		= vxlan_mdb_dump,
 	.ndo_mdb_get		= vxlan_mdb_get,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index eb4c580b5cee..60eb95a06d55 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -74,6 +74,14 @@ struct vxlan_mdb_config {
 	u8 rt_protocol;
 };
 
+struct vxlan_mdb_flush_desc {
+	union vxlan_addr remote_ip;
+	__be32 src_vni;
+	__be32 remote_vni;
+	__be16 remote_port;
+	u8 rt_protocol;
+};
+
 static const struct rhashtable_params vxlan_mdb_rht_params = {
 	.head_offset = offsetof(struct vxlan_mdb_entry, rhnode),
 	.key_offset = offsetof(struct vxlan_mdb_entry, key),
@@ -1306,6 +1314,145 @@ int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
+static const struct nla_policy
+vxlan_mdbe_attrs_del_bulk_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
+	[MDBE_ATTR_DST] = NLA_POLICY_RANGE(NLA_BINARY,
+					   sizeof(struct in_addr),
+					   sizeof(struct in6_addr)),
+	[MDBE_ATTR_DST_PORT] = { .type = NLA_U16 },
+	[MDBE_ATTR_VNI] = NLA_POLICY_FULL_RANGE(NLA_U32, &vni_range),
+	[MDBE_ATTR_SRC_VNI] = NLA_POLICY_FULL_RANGE(NLA_U32, &vni_range),
+	[MDBE_ATTR_STATE_MASK] = NLA_POLICY_MASK(NLA_U8, MDB_PERMANENT),
+};
+
+static int vxlan_mdb_flush_desc_init(struct vxlan_dev *vxlan,
+				     struct vxlan_mdb_flush_desc *desc,
+				     struct nlattr *tb[],
+				     struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	int err;
+
+	if (entry->ifindex && entry->ifindex != vxlan->dev->ifindex) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid port net device");
+		return -EINVAL;
+	}
+
+	if (entry->vid) {
+		NL_SET_ERR_MSG_MOD(extack, "VID must not be specified");
+		return -EINVAL;
+	}
+
+	if (!tb[MDBA_SET_ENTRY_ATTRS])
+		return 0;
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_SET_ENTRY_ATTRS],
+			       vxlan_mdbe_attrs_del_bulk_pol, extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_STATE_MASK]) {
+		u8 state_mask = nla_get_u8(mdbe_attrs[MDBE_ATTR_STATE_MASK]);
+
+		if ((state_mask & MDB_PERMANENT) && !(entry->state & MDB_PERMANENT)) {
+			NL_SET_ERR_MSG_MOD(extack, "Only permanent MDB entries are supported");
+			return -EINVAL;
+		}
+	}
+
+	if (mdbe_attrs[MDBE_ATTR_RTPROT])
+		desc->rt_protocol = nla_get_u8(mdbe_attrs[MDBE_ATTR_RTPROT]);
+
+	if (mdbe_attrs[MDBE_ATTR_DST])
+		vxlan_nla_get_addr(&desc->remote_ip, mdbe_attrs[MDBE_ATTR_DST]);
+
+	if (mdbe_attrs[MDBE_ATTR_DST_PORT])
+		desc->remote_port =
+			cpu_to_be16(nla_get_u16(mdbe_attrs[MDBE_ATTR_DST_PORT]));
+
+	if (mdbe_attrs[MDBE_ATTR_VNI])
+		desc->remote_vni =
+			cpu_to_be32(nla_get_u32(mdbe_attrs[MDBE_ATTR_VNI]));
+
+	if (mdbe_attrs[MDBE_ATTR_SRC_VNI])
+		desc->src_vni =
+			cpu_to_be32(nla_get_u32(mdbe_attrs[MDBE_ATTR_SRC_VNI]));
+
+	return 0;
+}
+
+static void vxlan_mdb_remotes_flush(struct vxlan_dev *vxlan,
+				    struct vxlan_mdb_entry *mdb_entry,
+				    const struct vxlan_mdb_flush_desc *desc)
+{
+	struct vxlan_mdb_remote *remote, *tmp;
+
+	list_for_each_entry_safe(remote, tmp, &mdb_entry->remotes, list) {
+		struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
+		__be32 remote_vni;
+
+		if (desc->remote_ip.sa.sa_family &&
+		    !vxlan_addr_equal(&desc->remote_ip, &rd->remote_ip))
+			continue;
+
+		/* Encapsulation is performed with source VNI if remote VNI
+		 * is not set.
+		 */
+		remote_vni = rd->remote_vni ? : mdb_entry->key.vni;
+		if (desc->remote_vni && desc->remote_vni != remote_vni)
+			continue;
+
+		if (desc->remote_port && desc->remote_port != rd->remote_port)
+			continue;
+
+		if (desc->rt_protocol &&
+		    desc->rt_protocol != remote->rt_protocol)
+			continue;
+
+		vxlan_mdb_remote_del(vxlan, mdb_entry, remote);
+	}
+}
+
+static void vxlan_mdb_flush(struct vxlan_dev *vxlan,
+			    const struct vxlan_mdb_flush_desc *desc)
+{
+	struct vxlan_mdb_entry *mdb_entry;
+	struct hlist_node *tmp;
+
+	/* The removal of an entry cannot trigger the removal of another entry
+	 * since entries are always added to the head of the list.
+	 */
+	hlist_for_each_entry_safe(mdb_entry, tmp, &vxlan->mdb_list, mdb_node) {
+		if (desc->src_vni && desc->src_vni != mdb_entry->key.vni)
+			continue;
+
+		vxlan_mdb_remotes_flush(vxlan, mdb_entry, desc);
+		/* Entry will only be removed if its remotes list is empty. */
+		vxlan_mdb_entry_put(vxlan, mdb_entry);
+	}
+}
+
+int vxlan_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
+		       struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_mdb_flush_desc desc = {};
+	int err;
+
+	ASSERT_RTNL();
+
+	err = vxlan_mdb_flush_desc_init(vxlan, &desc, tb, extack);
+	if (err)
+		return err;
+
+	vxlan_mdb_flush(vxlan, &desc);
+
+	return 0;
+}
+
 static const struct nla_policy vxlan_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
 					      sizeof(struct in_addr),
@@ -1575,29 +1722,6 @@ static void vxlan_mdb_check_empty(void *ptr, void *arg)
 	WARN_ON_ONCE(1);
 }
 
-static void vxlan_mdb_remotes_flush(struct vxlan_dev *vxlan,
-				    struct vxlan_mdb_entry *mdb_entry)
-{
-	struct vxlan_mdb_remote *remote, *tmp;
-
-	list_for_each_entry_safe(remote, tmp, &mdb_entry->remotes, list)
-		vxlan_mdb_remote_del(vxlan, mdb_entry, remote);
-}
-
-static void vxlan_mdb_entries_flush(struct vxlan_dev *vxlan)
-{
-	struct vxlan_mdb_entry *mdb_entry;
-	struct hlist_node *tmp;
-
-	/* The removal of an entry cannot trigger the removal of another entry
-	 * since entries are always added to the head of the list.
-	 */
-	hlist_for_each_entry_safe(mdb_entry, tmp, &vxlan->mdb_list, mdb_node) {
-		vxlan_mdb_remotes_flush(vxlan, mdb_entry);
-		vxlan_mdb_entry_put(vxlan, mdb_entry);
-	}
-}
-
 int vxlan_mdb_init(struct vxlan_dev *vxlan)
 {
 	int err;
@@ -1613,7 +1737,9 @@ int vxlan_mdb_init(struct vxlan_dev *vxlan)
 
 void vxlan_mdb_fini(struct vxlan_dev *vxlan)
 {
-	vxlan_mdb_entries_flush(vxlan);
+	struct vxlan_mdb_flush_desc desc = {};
+
+	vxlan_mdb_flush(vxlan, &desc);
 	WARN_ON_ONCE(vxlan->cfg.flags & VXLAN_F_MDB);
 	rhashtable_free_and_destroy(&vxlan->mdb_tbl, vxlan_mdb_check_empty,
 				    NULL);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index db679c380955..b35d96b78843 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -235,6 +235,8 @@ int vxlan_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 		  struct netlink_ext_ack *extack);
 int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 		  struct netlink_ext_ack *extack);
+int vxlan_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
+		       struct netlink_ext_ack *extack);
 int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
 		  u32 seq, struct netlink_ext_ack *extack);
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
-- 
2.40.1


