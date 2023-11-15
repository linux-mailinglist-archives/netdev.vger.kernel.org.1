Return-Path: <netdev+bounces-47974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67B7EC215
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8C51F2676C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48118055;
	Wed, 15 Nov 2023 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ML2omxAs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BF18035
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB5125
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEAaUl4BjDruuY38O191us7g/xr1HuI94pcKCMypAS/cRamfU+q/ndeLz7bpVH+4A5z7s2XIlVJypqtDzOL0P0BuEZ4ZAVGPbFFFn/RS0c6e9kqLllsWVN0YS1BjeGAHD1Vgwb2uA0uLAYwaFSaCMNWtJ23M6lzpTI6CCb2jqd/xLESOLAggNRaFDNt0kXllhM4TrH/Drw22U45T3ndNIK4O4lVNkv8UeZOkf1Ai2EHyyfrH15wD9j4+8oihhurAXTv1+TgCQwp18ZOS/v8SL5BQbYKWStcaQhKkPfY/kcqo43xtSJu6W/7JlYIAmgBdrZ8gdEx4KtxjOQZYeiC4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K8z0Z3UYQn1rssdW6HkX9u1ktVjXidYu2OhLgrCbZM=;
 b=l18qvtenN4Oaov/q1Zs4VOyNRtenbvdCUBCDtP6aFAjXA33Oh51BJiTELW5CMb0k+/7K3hipEmjbazDiCQwDiyz88ri7Ke1EscgoVIajDC/LZVPhpS0iXwuxTMFO/YY61oPzck8vzetSvZFAGdtgvPrCfhZKGEIiDTE8C4Dcod1pfm7QgjWW/peODxUhvdrYNkd5eQ0Bh53mFO8Al2kjM08l9N363vVdhxMa7hj42uR6VlDsycqjQ3z+3ECeygkJ7TV0gvKxrXfDOpfVKCyebCcDXddiRSMw2fif/3nwyrY1pkMIOTMjoFPB033RWBknMahuM4UPM5BTZ/NCO3GqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K8z0Z3UYQn1rssdW6HkX9u1ktVjXidYu2OhLgrCbZM=;
 b=ML2omxAs0xtLajXz0SA3JVAdedB0pYsQIoSUZ+vvT0cMsUeOlE3KDDrLCzAEe6fuWSCv42u5UB4M+Wtjzm3itn+2wJ52nmelgecgaB21y52rBMyJaJIA8v+cK2Tmkeb7yvICYDo6TwYMmZ61t/s2h288ULuHWmnuBi4arROK1GnWWn7fcaoL6x7MNRmWS+5CdJPsvDZCpQjM07oGk1Py24aQ/Sk/3ghmo6svuVUygmBPwihvyxgXkpTzZ+3dzEPaU7lretL1Apami67MB7XKwEKKCAtonWHPNtBSIzSI2kQW3elL9MoSYDKKtXYq3HFNdxeDgpOhiGP4YQcnNuLbzQ==
Received: from CYZPR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:8a::11)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:19:52 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::f0) by CYZPR10CA0005.outlook.office365.com
 (2603:10b6:930:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:39 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:36 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 05/14] devlink: Acquire device lock during reload command
Date: Wed, 15 Nov 2023 13:17:14 +0100
Message-ID: <03cf077ca8d3a1a0a755866df1a99031e5badb14.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a860b34-537a-45ac-1300-08dbe5d52b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4f+/dwIKAFC4dDouSqJchN4dPreQ74mvME9N6nSlvomxssEhBmJjZUeVVabGsZAqQXyZk0W3dP6TRxSvWo9mSoaZQyyf5TMrjsRIGH+K1/Jztj0/eYQnwzE8WY63eoIXIK8c0MAVvp3X9JXMg2fp7WgKHslJXKoOYmcLckDWzCc2ph4OoQ1CVhPSFfRDCO4lMoQr6U6Ct550DaNSUuk71QJ7GuBmDT343IKBON5ce7g5r4LjZLRLhv+mikg8O9JkThhOipr1qLghpHK5GpCPVwix2325IsVB/3IWlLS5KbjvlUxxOkJlkdwQZe0fMF3CFsVpLa/oEiHdHhw0TEE8xXMA34HQdrO6yysV/52lYkx92AjM9F7YUDCgxeV4zw1TNit1U57I9EnOI7xTazQj4JGeFhBaoFt0MvqVYbQHWWlNYIgL9f0kh2Rj6GUmva4QH6SF5GDonllb1MIM4GKOO+1v1DbCer6elm36rEWcq7sDP/v+Wk3O686wRen2m0BuBS9f4UVF9xg920CWqCa8pAchhwD57DI9NogQx8xKBgmoQuEFvFZe7PUtttv6KKMLGhQYOcSyEiD4dN6nUT/7xQ0Nst1dQ4Uyoa37Xl5cQdnIMG7rC2xgx80Po19RfJd/oUY9Jq/rI7Sn+4VdzEZRm4jL4pQojUiQ8OU5IWO79gbX9QE22xLPX/HEYJQnFOOQqOPwIZqZu0Zhu7kShVeoJXnJ95u2obhnc0VdZD2H3Pt4zH65I2BP9WoNY7SRz4YT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(8936002)(54906003)(70586007)(316002)(4326008)(8676002)(110136005)(2906002)(41300700001)(86362001)(5660300002)(83380400001)(2616005)(47076005)(7636003)(356005)(82740400003)(107886003)(426003)(336012)(26005)(16526019)(478600001)(36860700001)(70206006)(36756003)(6666004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:51.7918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a860b34-537a-45ac-1300-08dbe5d52b39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

From: Ido Schimmel <idosch@nvidia.com>

Device drivers register with devlink from their probe routines (under
the device lock) by acquiring the devlink instance lock and calling
devl_register().

Drivers that support a devlink reload usually implement the
reload_{down, up}() operations in a similar fashion to their remove and
probe routines, respectively.

However, while the remove and probe routines are invoked with the device
lock held, the reload operations are only invoked with the devlink
instance lock held. It is therefore impossible for drivers to acquire
the device lock from their reload operations, as this would result in
lock inversion.

The motivating use case for invoking the reload operations with the
device lock held is in mlxsw which needs to trigger a PCI reset as part
of the reload. The driver cannot call pci_reset_function() as this
function acquires the device lock. Instead, it needs to call
__pci_reset_function_locked which expects the device lock to be held.

To that end, adjust devlink to always acquire the device lock before the
devlink instance lock when performing a reload.

Do that when reload is explicitly triggered by user space by specifying
the 'DEVLINK_NL_FLAG_NEED_DEV_LOCK' flag in the pre_doit and post_doit
operations of the reload command.

A previous patch already handled the case where reload is invoked as
part of netns dismantle.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  4 ++--
 net/devlink/netlink.c                    | 13 +++++++++++++
 net/devlink/netlink_gen.c                |  4 ++--
 net/devlink/netlink_gen.h                |  5 +++++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 572d83a414d0..43067e1f63aa 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1484,8 +1484,8 @@ operations:
       dont-validate: [ strict ]
       flags: [ admin-perm ]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-dev-lock
+        post: devlink-nl-post-doit-dev-lock
         request:
           attributes:
             - bus-name
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 86f12531bf99..fa9afe3e6d9b 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -138,6 +138,12 @@ int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PORT);
 }
 
+int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
+}
+
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info)
@@ -162,6 +168,13 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, 0);
 }
 
+void
+devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
+			      struct sk_buff *skb, struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 788dfdc498a9..95f9b4350ab7 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -846,9 +846,9 @@ const struct genl_split_ops devlink_nl_ops[73] = {
 	{
 		.cmd		= DEVLINK_CMD_RELOAD,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_dev_lock,
 		.doit		= devlink_nl_reload_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_dev_lock,
 		.policy		= devlink_reload_nl_policy,
 		.maxattr	= DEVLINK_ATTR_RELOAD_LIMITS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 0e9e89c31c31..02f3c0bfae0e 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -22,12 +22,17 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
 int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
 			     struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
+void
+devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
+			      struct sk_buff *skb, struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.41.0


