Return-Path: <netdev+bounces-49337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562577F1C59
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A026B219D0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198130CEF;
	Mon, 20 Nov 2023 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A61uFdlx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BFC4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:27:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqbEI0FS+htSpZoMu2BKM0svlkvZck0ybHQ9bhy7OhrzoSyvKpnsdCczfc20PnHmVzz7QqIxnl7rLco6mCU97c7DfERQ96Il4UaLYXQLUPi9QGaa5l3MMLbNpO5QnaUMqyvvda5W7MN6wnojfVBj5Sa74JakijND5/Xv9wlPSRmT0guXC8yMXZeXfGywB+1rAKBBTu+uGEHW7QwmO1c1aI4OHF8IB2nsg37kKr6F36CddV2q09vp1FZVkMHRv5WdbA3hjtbmNXPhaEp1OzSAgXaMQ1F+gZpudqQ90Ec8dU28b9bEMEB7hqB4O5R1reW4lDI3L1Lw7bgjIyHZEAFK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A7z96jX1u6QSGWlAy6KhhTiykkf9FweneAPKIM198g=;
 b=dYV76s8zwpb7o1XoF5PiMUpMqiWs4rJWA/6UwhsXXUfNuTNkvJbuBOGTaI/VNY3qm6Am4XL0h3IesA5unEtSbAeXWK737M/7XfN10lDM7JDze8+DeBuUNS+SPSgMJKcy8AQzGAKAYL0oImbF/ij+lor91oPAZ8GGhY5RlCqt8cwJAdY6xl0jBQYOKrx2/HXFyab5AJn/KcCWKPjiP1QxX/4rIzQrYex2lqPcYrzCBUb1k2kqK3T3bm20SOYX05UvIaEAsESi71Ede3JqbyBIGkHDPGNjptQFVzpN7DaVU9n42gIHXoJpi0IsDD8URlA5jEv4vh/2DlxxiJh641NCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A7z96jX1u6QSGWlAy6KhhTiykkf9FweneAPKIM198g=;
 b=A61uFdlxtmUw49saBWzEKJ3ntS4+DL+/5tl0ZBFjIzxUCgRu46pJPRxw3BKcYkL5TOP/YMQ9RLJfe3h/mt4T6BkAqTS0H5sA1yLGN7K6fkdrWY8iyDoKBv7ZiTMDI+gJZCqPmy8C4dI6GK5mAg56LjadT99wGOcSoRcGTM97m7zI6BmWUixZppqJyBlMThv3UA2Xudn8dDz49WwjDqYIpqWs9UcM4IA8LNQt+0fjcwkByBPdE3Q4JgzQMASQ9b/l4Gz2VwUHohE02UOO7R1SzDx0/imDh+GmsaNboN1bqQwdZrJoS+HLIUR8aLta4K+k29ULyyE2LdJK+114ojKHZQ==
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:27:53 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::e4) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:40 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:36 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/14] mlxsw: reg: Add Switch FID Flooding Profiles Register
Date: Mon, 20 Nov 2023 19:25:21 +0100
Message-ID: <ca42eb67763bd0c7cf035afc62ef73632f3f61a6.1700503643.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f17bda-cf64-4cb8-2143-08dbe9f668ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XNtQriJdxGTMEyZP+aTAUhe8hZJsulEO1VH639Ldpn/f5wacS9d4LSObBoWwo31oPpWMc3EmfYCd+IGJB9n2DNvKViWUzb9FqwyrYgPJa/VpoYeHRHGTs2NCtEZU5UBogJQyPh327FSkzLPjyUrezR9LgBbOl6U2b/5dINfHMu/YipcouvgQIdLQiMirZvnNj2OsREQGSNQ19wYbC4UcUSX35iIiCOVQqoaeV1D4ZUzxQI4byx3aED92D/No6YJFsyJqDpN9cyfPzbBCRp/klAPXQRIj2CbqiWlKgUlo0tDwiQKFgl5FoPwsyWiQY5jYw9U7WqvowokvrzgcYevOxwIGMghR9u5xUUrUJdXUX8I9va2ncrM1ImJhbaOdUTUF1AHNRiUV2w+yAcMJRHrLBPty601o7LO6jiww0orYz6WI+JK0RusEG0Bz94Bwq/i3xjaiNrnpO+XF3JjwI8u/MuQdhYDZ6oiD4hnIAo+h+czRnLgUR09o1JxJGgCd/vR0csOuuB6uzlyOlajl41yX8twJHyyLwTNclOeO9ebC0mjARslmjXkyT83Uu4kOR5yklLeqZuPFMh3g+Y1J4NsqKTjzGKX6C1VFHbem6WTSIlNPJ+c9wl+zNgSz5N3hWaMUYF7sOMWfZ64fHxUdH5hwJ35IxTOZi/JUb2EyaINCqfkzNR+2l9xH/udQI7BllywnhryAo8ElC7yK3WUL9ELU+uaDlhr8SONIu4t6Gw+UxdQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(8936002)(4326008)(8676002)(316002)(41300700001)(54906003)(70586007)(70206006)(110136005)(6666004)(40480700001)(478600001)(26005)(2616005)(107886003)(83380400001)(16526019)(336012)(426003)(40460700003)(36860700001)(7636003)(356005)(47076005)(82740400003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:52.8988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f17bda-cf64-4cb8-2143-08dbe9f668ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832

The SFFP register populates the fid flooding profile tables used for the
NVE flooding and Compressed-FID Flooding (CFF).

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index e26e9d06bd72..3472f70b2482 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -2168,6 +2168,50 @@ static inline void mlxsw_reg_spvc_pack(char *payload, u16 local_port, bool et1,
 	mlxsw_reg_spvc_et0_set(payload, et0);
 }
 
+/* SFFP - Switch FID Flooding Profiles Register
+ * --------------------------------------------
+ * The SFFP register populates the fid flooding profile tables used for the NVE
+ * flooding and Compressed-FID Flooding (CFF).
+ *
+ * Reserved on Spectrum-1.
+ */
+#define MLXSW_REG_SFFP_ID 0x2029
+#define MLXSW_REG_SFFP_LEN 0x0C
+
+MLXSW_REG_DEFINE(sffp, MLXSW_REG_SFFP_ID, MLXSW_REG_SFFP_LEN);
+
+/* reg_sffp_profile_id
+ * Profile ID a.k.a. SFMR.nve_flood_prf_id or SFMR.cff_prf_id
+ * Range 0..max_cap_nve_flood_prf-1
+ * Access: Index
+ */
+MLXSW_ITEM32(reg, sffp, profile_id, 0x00, 16, 2);
+
+/* reg_sffp_type
+ * The traffic type to reach the flooding table.
+ * Same as SFGC.type
+ * Access: Index
+ */
+MLXSW_ITEM32(reg, sffp, type, 0x00, 0, 4);
+
+/* reg_sffp_flood_offset
+ * Flood offset. Offset to add to SFMR.cff_mid_base to get the final PGT address
+ * for FID flood; or offset to add to SFMR.nve_tunnel_flood_ptr to get KVD
+ * pointer for NVE underlay.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, sffp, flood_offset, 0x04, 0, 3);
+
+static inline void mlxsw_reg_sffp_pack(char *payload, u8 profile_id,
+				       enum mlxsw_reg_sfgc_type type,
+				       u8 flood_offset)
+{
+	MLXSW_REG_ZERO(sffp, payload);
+	mlxsw_reg_sffp_profile_id_set(payload, profile_id);
+	mlxsw_reg_sffp_type_set(payload, type);
+	mlxsw_reg_sffp_flood_offset_set(payload, flood_offset);
+}
+
 /* SPEVET - Switch Port Egress VLAN EtherType
  * ------------------------------------------
  * The switch port egress VLAN EtherType configures which EtherType to push at
@@ -12946,6 +12990,7 @@ static const struct mlxsw_reg_info *mlxsw_reg_infos[] = {
 	MLXSW_REG(spvmlr),
 	MLXSW_REG(spfsr),
 	MLXSW_REG(spvc),
+	MLXSW_REG(sffp),
 	MLXSW_REG(spevet),
 	MLXSW_REG(smpe),
 	MLXSW_REG(smid2),
-- 
2.41.0


