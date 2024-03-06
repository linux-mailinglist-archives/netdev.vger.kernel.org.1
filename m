Return-Path: <netdev+bounces-78167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E968743E3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710EBB2357A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95811CD2D;
	Wed,  6 Mar 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WSfRwRaE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BD1CABD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767791; cv=fail; b=gvu0FABlQRlKv6x8SU+L1zRdKmZdZo5FxGGh4TvCAOSzt0Zi+PaP/EaQ+QIy5RqIZ+2K1x6t3ARQXqasyiT6gieJLTgvwBt2uaHVh61KBBx2BPtLx9ZSHCZa2QmmyUK69vaGTH3p4jzu1f4qmb7J/71+TPrH1XCcjn5BNEkSiWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767791; c=relaxed/simple;
	bh=Vpl2E2ohH6ht9XNT2vM/Bk5x/4/gy5/M3GkHH1L8jqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UV7apUEkTPwQFA9caE+72lvtPHpYSpr47rZPGeAN45Wf8MTyZ8irQ7CTSHE8ZQQsjJbYmkBN3I5DmlryCOXScE45FY9z1GiobNKZSrqBQvS1bsbknmjK9cAcYsL4J+UzsgjOReZWwfb+Yles/DeW6QIoyea7ycvAKg3QVdIYb6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WSfRwRaE; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkf29KA/dszaHsZ/jMBWI+uVg+Hk/16rc5hmXl7DSC0p8K5kmvJRvR2pUt4u1/KHPjS58yN1cYxrbxaZQfMyahpcSci0G9n6n3J/p7+JNMEBDMSN7W4JLxXuazWgZuUv8uO4H4fgqJ9slKLssyrlt2u8TfURiCysixkg13Tg5qzwA7xwMHj1MslPU0JrYQ6OuKXC8kViLHU2KgLI6HEZgsOiurVMRSV3qOH/NdfJ/eupIN2p8xKUaYyOVPssZxB2qZtHKpFR4ptoV9kt4ZeVgU45KHltQgIOLzDpCG3UFpeTHNRIgHPuCpZjp1TxsapS0dqrDy61FGDxNFbYnGUsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKcwjyIl3sydbXW6x4KJDAu6bY7RT7NbF5pIiGxfLrM=;
 b=U0cOuBo6bfGUI04CiKUVPaMH1R47cs0yKWXUxOjCuiWCT1dNVHBM8VVrbkxV9iFhDC0WdEMSIT/YZj5HPB555FH65GXgGun36HkNnNsfcYgsA+D1aaUPj89zaQOAiLfQ/E6h0scW6gdopal4/N8UZyD/SO8P95thiEZNneKU2tce+fSnCHQsEb3jGVZtarsAMsLzoAl/O87qGQsmzKGFkyAMLQyjAfv0+37G3iu3wYRGnhl9tiqBAbfYEi51olSs9DQMZyw5kjn/IPiQOSjAay68aiA/aCyUMy/iP2VD/8Q6u98G5ePEQTgrTOGa2qirkmS/m/jWuSf9uasJc65+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKcwjyIl3sydbXW6x4KJDAu6bY7RT7NbF5pIiGxfLrM=;
 b=WSfRwRaEAaSqsbT90Kie+xd/7e/fAbrB7xKwE9bJfg/F42jOoYe5osUZ2jP1fEppNwMFwX0Pxe1RTQ4yoMdFxvbgAtRYBszhjYGRilpRaKNL7AoMHP6puvNovQdRYzAeTrGYdf1HcbalRkv7gcIHQhBtYdtLcY3uZgYKPt2Sk2k712khPwwqk5hZW+RMxwFWruxlnansEWSvu02aIyQ1JZse1RLlyhj7Jqdf+isYtZUetfKWQeVTmrRQZnrdkIX9B5ru76zc3Wgue5l27ac9LoClS50AtaG+NnJp229tJV8EZNUp1TFRk2pgBww2ZZ/kUopq0rWym8SHQaHaUmFOUA==
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 6 Mar
 2024 23:29:45 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::1) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 23:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:29:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 15:29:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 15:29:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 15:29:24 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v3 iproute2-next] devlink: Add shared memory pool eswitch attribute
Date: Thu, 7 Mar 2024 01:29:22 +0200
Message-ID: <20240306232922.8249-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 599c6eec-07f5-4aa3-f4ed-08dc3e354c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PXODOqDdvxezEi6tR2IDYqZHOqH0HJXeVAAkmloRH8ZqMpcILEzLlv6l3O46S2Yw55Ij9pvgW0DlZ09QvRQfi35qODqn+580qNsbQsxjhTg2lMnZR9ki3W1SxBgElPQhV451MevJ5GEGOnUhEv+PaVrWn0zyKPx3GvqRdLOviNxPHb7R25sOrlZbzhQE0RcQUY+3y/cnOwCC/9EefY8o1GMoQqOUiQr35+FaLe7nlNUB2AgLflYY8fGOnZ2d9kWGGnmuoXI60ukIk9jDAeYYsm7joPlvmGEC9kEzE3Ywq4FoQQwZ8c9YxMvA983Qhtk4jaPJEzeXnXF/FwastKF44aG4dLWSB6RH+MxPiIRhF3EBzgkMk+jAlecWGLTdV2vyZ6gnEjgEL+SkXoVcE+UREpdH5kpIfTyAYMo2bCXxBqlKF7EuxiYJcMyA3Mrfajt8PAiDEnvMzBOzBGMFhBL6kfC22fORHZxJWiTfEGwLzvfijrVOmidaYyT0OVq943V+S+GcYlJ0nqkLfKytLeFn48X/XhNoddtr18HWx2SVctRqRq1pxS5czdP5ZXOYj69GnejZnkm9QoE3oCrE8mhFh26aOGh9qnCRKHEzReH0GcSPtDOCLp4hBLcz4Hwa1h6Yd1lkDH4J7Y91y1dc07LKVLtG6SpgS5ZfNjbCN4j1AeC50rvMt3cugssGuaDpnofVFZI8TGXaxJbMZ47HtSlEHZvxMnW2SipDKFIVEaIbTOmPh/R59dfGfLmEW88xFmOw
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:29:40.9459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599c6eec-07f5-4aa3-f4ed-08dc3e354c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

Add eswitch attribute spool_size for shared memory pool size.

When using switchdev mode, the representor ports handles the slow path
traffic, the traffic that can't be offloaded will be redirected to the
representor port for processing. Memory consumption of the representor
port's rx buffer can grow to several GB when scaling to 1k VFs reps.
For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
consumes 3MB of DMA memory for packet buffer in WQEs, and with four
channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
ports are for slow path traffic, most of these rx DMA memory are idle.

Add spool_size configuration, allowing multiple representor ports
to share a rx memory buffer pool. When enabled, individual representor
doesn't need to allocate its dedicated rx buffer, but just pointing
its rq to the memory pool. This could make the memory being better
utilized. The spool_size represents the number of bytes of the memory
pool. Users can adjust it based on how many reps, total system
memory, or performance expectation.

An example use case:
$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  spool-size 4096000
$ devlink dev eswitch show pci/0000:08:00.0
  pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
  spool-size 4096000

Disable the shared memory pool by setting spool_size to 0.

Signed-off-by: William Tu <witu@nvidia.com>
---
v3:
- change to 1 attributes and rename to spool-size

v2: feedback from Stephen
- add man page, send to iproute2-next
---
 devlink/devlink.c            | 25 +++++++++++++++++++++++--
 include/uapi/linux/devlink.h |  1 +
 man/man8/devlink-dev.8       |  6 ++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e397e8e..5ad789caa934 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -309,6 +309,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
 #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
 #define DL_OPT_PORT_FN_CAPS	BIT(57)
+#define DL_OPT_ESWITCH_SPOOL_SIZE	BIT(58)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -375,6 +376,7 @@ struct dl_opts {
 	const char *linecard_type;
 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
 	struct nla_bitfield32 port_fn_caps;
+	uint32_t eswitch_spool_size;
 };
 
 struct dl {
@@ -630,6 +632,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_ESWITCH_MODE] = MNL_TYPE_U16,
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = MNL_TYPE_U8,
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = MNL_TYPE_U8,
+	[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE] = MNL_TYPE_U32,
 	[DEVLINK_ATTR_DPIPE_TABLES] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_DPIPE_TABLE] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = MNL_TYPE_STRING,
@@ -1672,6 +1675,7 @@ static const struct dl_args_metadata dl_args_required[] = {
 	{DL_OPT_LINECARD,	      "Linecard index expected."},
 	{DL_OPT_LINECARD_TYPE,	      "Linecard type expected."},
 	{DL_OPT_SELFTESTS,            "Test name is expected"},
+	{DL_OPT_ESWITCH_SPOOL_SIZE,   "E-Switch shared memory pool size expected."},
 };
 
 static int dl_args_finding_required_validate(uint64_t o_required,
@@ -1895,6 +1899,13 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_ESWITCH_ENCAP_MODE;
+		} else if (dl_argv_match(dl, "spool-size") &&
+			   (o_all & DL_OPT_ESWITCH_SPOOL_SIZE)) {
+			dl_arg_inc(dl);
+			err = dl_argv_uint32_t(dl, &opts->eswitch_spool_size);
+			if (err)
+				return err;
+			o_found |= DL_OPT_ESWITCH_SPOOL_SIZE;
 		} else if (dl_argv_match(dl, "path") &&
 			   (o_all & DL_OPT_RESOURCE_PATH)) {
 			dl_arg_inc(dl);
@@ -2547,6 +2558,9 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_ESWITCH_ENCAP_MODE)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
 				opts->eswitch_encap_mode);
+	if (opts->present & DL_OPT_ESWITCH_SPOOL_SIZE)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,
+				 opts->eswitch_spool_size);
 	if ((opts->present & DL_OPT_RESOURCE_PATH) && opts->resource_id_valid)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_ID,
 				 opts->resource_id);
@@ -2707,6 +2721,7 @@ static void cmd_dev_help(void)
 	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev } ]\n");
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap-mode { none | basic } ]\n");
+	pr_err("                               [ spool-size { SIZE } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
 	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
@@ -3194,7 +3209,12 @@ static void pr_out_eswitch(struct dl *dl, struct nlattr **tb)
 			     eswitch_encap_mode_name(mnl_attr_get_u8(
 				    tb[DEVLINK_ATTR_ESWITCH_ENCAP_MODE])));
 	}
-
+	if (tb[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]) {
+		check_indent_newline(dl);
+		print_uint(PRINT_ANY, "spool-size", "spool-size %u",
+			   mnl_attr_get_u32(
+				    tb[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]));
+	}
 	pr_out_handle_end(dl);
 }
 
@@ -3239,7 +3259,8 @@ static int cmd_dev_eswitch_set(struct dl *dl)
 	err = dl_argv_parse(dl, DL_OPT_HANDLE,
 			    DL_OPT_ESWITCH_MODE |
 			    DL_OPT_ESWITCH_INLINE_MODE |
-			    DL_OPT_ESWITCH_ENCAP_MODE);
+			    DL_OPT_ESWITCH_ENCAP_MODE |
+			    DL_OPT_ESWITCH_SPOOL_SIZE);
 	if (err)
 		return err;
 
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e77170199815..c750e29a1c5c 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,7 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,	/* u32 */
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index e9d091df48d8..081cc8740f8b 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -34,6 +34,8 @@ devlink-dev \- devlink device configuration
 .BR inline-mode " { " none " | " link " | " network " | " transport " } "
 ] [
 .BR encap-mode " { " none " | " basic " } "
+] [
+.BR spool-size " { SIZE } "
 ]
 
 .ti -8
@@ -151,6 +153,10 @@ Set eswitch encapsulation support
 .I basic
 - Enable encapsulation support
 
+.TP
+.BR spool-size " SIZE"
+Set the rx shared memory pool size in bytes.
+
 .SS devlink dev param set  - set new value to devlink device configuration parameter
 
 .TP
-- 
2.38.1


