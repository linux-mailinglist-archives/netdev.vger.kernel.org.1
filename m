Return-Path: <netdev+bounces-41321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384717CA918
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E0B28169F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247827EEC;
	Mon, 16 Oct 2023 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZnOcmbz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F927731
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E57114
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQEDp3bXuk9AzleWPmTbj50u9gw8djQ4mkWdCTY1dwAhBlbpRlPhiKQ9CNr2fdjU2qVKjNVoeYtbsgHESG1Q3U6pisScEnnGbOgJn8We75AiEcdlG7At038dncMRBM9KQMbQ27JxrAuwi4O3kHZGlK3f5tw8HJ+XNvCdbZLFN70XgkxkM1bLb3uikDY8tihDqiLlA1dAXEwLvSuIaOCu/aKtntEQIdfeIiQaBaNvUG9D/21EJST1RfvfL7DdSIPGp+cIXjJ8SsboetSS4r3V0G1Qku9+5oL58yI65T04zk0T5NBetuw0wA7gnceGCV+5gfM8INsL26ZAobNx4qaLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z01Ln3/2kwAqhN9oOHTp4mbfckYoMDivcI4Z3lRkU34=;
 b=GVJnyCCUNSb11x5FQzgUCaQMr2f50OWTxo6t15qFuUjykybiNIp0sA05n41pT7lFIw1ejgg94S06C+AzrP+zcZmUw1Wvyr0IF6s/uu5kH6V6ycSiyoa/xzQL1H8iG2hChawXH1stzVn3KhLGx1pZrphX1qhvay7CTOFLonQSPFkluZou5CGmzqhrwYPqUmeoclx5ZnqLSf1Q79IjZN//UaAkBhXrCRByrf0XxnAhfPX6pRIh5S4OX2hpLuFCQ9egq0pZQA7AGLRSOOsde++Uj98PaKTGxXD1w39ysF1QWmmpqYZ0sZyWV64ajfkFBUlWAOzVFZb9fW+dwsMjgl7Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z01Ln3/2kwAqhN9oOHTp4mbfckYoMDivcI4Z3lRkU34=;
 b=AZnOcmbzbVWED4VGyKoXs6k3bOF4SNUXbjUdsxA4FauQoRul0doqY19UMcME+N9hI+cznaHvqT3MeHRJJLUFTvqUtKZC9XxH3EpPsUtkhDisC3WhP3GPJaaJwslBQlB1FoOHNUq/gZ+En9ebnjM9KDpRNxFigFXsl+qPT6WMeDEdBR2ZuslvAAhainmA7uVGVqQSduWNhBolzAEiHEKHUf7qPs107jetA5Fx5YpoN6Vq/zTQ4qTTkmGKl0pceFKWC4lgOml+ncT6Tfh/plbwmljSPkawCEga76Ybv1VdyWpPaadql2e6+wk3lC4z8idMmlcGgCTRFEll530Tq/ffUw==
Received: from MN2PR20CA0062.namprd20.prod.outlook.com (2603:10b6:208:235::31)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 13:14:10 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::34) by MN2PR20CA0062.outlook.office365.com
 (2603:10b6:208:235::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:13:52 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:13:49 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 06/13] vxlan: mdb: Factor out a helper for remote entry size calculation
Date: Mon, 16 Oct 2023 16:12:52 +0300
Message-ID: <20231016131259.3302298-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: c21756a8-6e49-4b11-59ef-08dbce49c910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fGrB8gLwhIAWxU+XgOi/McB6IU/bLpx77COCHyXhZ1pFRGYmVKkpiuQLSIlgzmmYZAatrgW52gviaZSO7tYhnrSDTX/Af0RcZIaSJscJlxkR59KN5UHYWKu9PZ/26A/i7YDcd0TAhGs1lP5LEbmt3HJTsEvhxOLbGpUDBoceEh9MMGcoQUKT4Nmej/Eveg6iTSiOYVsYBfmDLUIrHVIbSneLqr/L4KfpnUB+E2ZiI+13BdFquwnpeJ3ntWmio9bA0tsMojMVUxC/BGpYmeezs5BulfobwX9ouF92fNxS5ZZKIkpcwh07kwMx+VeaKyu4WPcgifb9vO/+Tnt1OWXYUkNMZcKXjsPaKaVXPWfjB20yp2pLwpetHynu6mrCCZ1q10hsY+cR5S6kIvTvyMeLUsx1Sc5KUFfJzB3raE9RxnwuN1MBNIiJCd+MdSqFYglYPfPu38mTam4KlyuaMKqUJVO9Cg6Mjpzgp0HZZnBbdurQkFpEUfQX5CN/E3VXOEpaMDZtV7Z0YgFrjEaGaQvXs5GHJ6fNG7BX+njcj1OWf12VGgwU8caVgCS4lEPnGUrcdpcIwVoQMUeREH54JJdd0Fye5W62vzx+65DJoBne9qcAxzrzGCr2ihxTEAap9Hq+JWJXCD09At6OwTJw0594SjSvsrQN32szCIweKpEkQdheaoIX2+JvrDiI13HcHKVC/CZ1Zwnbam/RiVwXjFvMyQXYjbyUcZPQSJthkEquZxEqI+8jpeekHMHhaMTTSsGw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(478600001)(6666004)(16526019)(83380400001)(1076003)(2616005)(336012)(426003)(107886003)(26005)(2906002)(54906003)(110136005)(5660300002)(41300700001)(70206006)(8936002)(4326008)(316002)(8676002)(70586007)(86362001)(36860700001)(47076005)(36756003)(82740400003)(356005)(7636003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:10.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21756a8-6e49-4b11-59ef-08dbce49c910
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, netlink notifications are sent for individual remote entries
and not for the entire MDB entry itself.

Subsequent patches are going to add MDB get support which will require
the VXLAN driver to reply with an entire MDB entry.

Therefore, as a preparation, factor out a helper to calculate the size
of an individual remote entry. When determining the size of the reply
this helper will be invoked for each remote entry in the MDB entry.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 0b6043e1473b..19640f7e3a88 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -925,23 +925,20 @@ vxlan_mdb_nlmsg_src_list_size(const struct vxlan_mdb_entry_key *group,
 	return nlmsg_size;
 }
 
-static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
-				   const struct vxlan_mdb_entry *mdb_entry,
-				   const struct vxlan_mdb_remote *remote)
+static size_t
+vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
+			    const struct vxlan_mdb_entry *mdb_entry,
+			    const struct vxlan_mdb_remote *remote)
 {
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
 
-	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
-		     /* MDBA_MDB */
-		     nla_total_size(0) +
-		     /* MDBA_MDB_ENTRY */
-		     nla_total_size(0) +
 		     /* MDBA_MDB_ENTRY_INFO */
-		     nla_total_size(sizeof(struct br_mdb_entry)) +
+	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
 		     /* MDBA_MDB_EATTR_TIMER */
 		     nla_total_size(sizeof(u32));
+
 	/* MDBA_MDB_EATTR_SOURCE */
 	if (vxlan_mdb_is_sg(group))
 		nlmsg_size += nla_total_size(vxlan_addr_size(&group->dst));
@@ -969,6 +966,19 @@ static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
 	return nlmsg_size;
 }
 
+static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
+				   const struct vxlan_mdb_entry *mdb_entry,
+				   const struct vxlan_mdb_remote *remote)
+{
+	return NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+	       /* MDBA_MDB */
+	       nla_total_size(0) +
+	       /* MDBA_MDB_ENTRY */
+	       nla_total_size(0) +
+	       /* Remote entry */
+	       vxlan_mdb_nlmsg_remote_size(vxlan, mdb_entry, remote);
+}
+
 static int vxlan_mdb_nlmsg_fill(const struct vxlan_dev *vxlan,
 				struct sk_buff *skb,
 				const struct vxlan_mdb_entry *mdb_entry,
-- 
2.40.1


