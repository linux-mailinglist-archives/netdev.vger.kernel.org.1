Return-Path: <netdev+bounces-82546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB288E85D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117361C2BC34
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45503130A4D;
	Wed, 27 Mar 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpWLlS8r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22B12A160
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551433; cv=fail; b=m653gD4xrRTMjguH/YlnKV61a4buqKWj7SarCcVC+F0FJXDaZIoQV+wZzJ3T+jc89H0mpAF8gVcYKMPbiOwhYKycxsiLIvmezFgk4MDduzA6nAOOF7B8HOFcJ1oNmqXd4oXiZ2Q2Bm1gwB71rzKvW2eqgcG0XBCePDLG3H0DV1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551433; c=relaxed/simple;
	bh=sZ7kKQgXLr5gN6nI0BwVfHh9ANr4ZvmUdeUqY1DuVT0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHTXphdKz0nLCwX2VsANYWUOMHta8dhgSeHH9R4wZNm0rt0SyBY7JDV7/O3L8OiYGC17V7w0kZYgGVVxQvQz1xM+rInVW1LNKfIq1aCmWczCi7zdv81sbSGUjxCv+V98e9mjArIlZBdarLc3vbDVn1ZGU54Z5rft4/r7V+Y/b3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpWLlS8r; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHuDOhAR+gn7Q9jx+Fr6cSEG6NqU+bnWGFmYXsICR4U2+TtwvjWxinQ9/Fm6pHbB7FyuI1DxPjsQ7A0YPxspZH8Ed+OTdjwyHL4k5kjsJqsZ3SGQIZfWd09V73TAKCckHsH0CcAtqFgsMBefpp1zNrwdGj9Rg+AHDV8yxLMcb0TnkNgeI0q0SQmdZrmyDYbzBOCs8oWZScnwzegQuWfJkTUp60KQ9ZJ8U6siwek6Fril9Hn7S0z/6YL+LgvwgJJuYpmVEQC5T7ZyqQ5jwzYPQWLErMRAErla7i0kZ6+0q7+zubZHdxoTStReX4pT/e1Bx9XWxiK64sRH1K915x2gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8Io+HT0g438eEk52lDbIOksj3uQxYx00Hx3S6ykG8s=;
 b=XNfxhYTZ57HcBotw7ll+GEA10mynUGQydQ9j/a77BgeW3cRzisxlLTCIOaONeAAhoNzoTkpz/0pE/0lT3tEaDzCnrFW3PxwMhkVMUJ3XFvCUuyM3BdF0ufDIpbGzGV7grx4CHISteGqxqim8zZbjRSt3R8UEGYuuqCMAU4rQ7m+WQW10YaEcunYd20qaSTs9hwZh+E3Q55/lp2XaEOyJo4EiTAhjcpCRxGxwWsC09DZwR0z+xnand5QTmT8W0uJRwjfO92icGwZDcMfPBhtukDs0Q1CR9PH4Rprj07SkbDr7kWvDSFztK3h9tyLlKV1JKt7vspMDZTHuEdcU+DUPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Io+HT0g438eEk52lDbIOksj3uQxYx00Hx3S6ykG8s=;
 b=cpWLlS8rCvLtRX3XA+V06ILyV5FtEnyNLdroaySP5t/XrT6Z9SDHXxEGhJGk7dqVqvjclFXsNa0vNoQolBJfuVmjB1oLm4xMtcTrY9N/qfUmX6HkljCEkIu1nYGPbRp4Br21M6rdyNYyb0LXCh8wFoHaYe2hB63lpI8TOk0p2ySrcRew4xFXOZcG+DUy/nzFN1cNL230Y5ejrOoRPw0fZ0CvnOwsNB2fgVaZo/gWvcYF0nNcQKPb8gFFBXQO+BaYoWt+W++biGA2cVYBVSKd2TT4U/Q9Dd2XUOAvg4RWYURUpz1WbkTuVn3XCQLeR5keuCGemmKz3aUTobEmQ/ndMg==
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 14:57:08 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::75) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:57:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 07:56:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 07:56:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 07:56:53 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH RFC v4 iproute2-next] devlink: Add shared memory pool eswitch attribute
Date: Wed, 27 Mar 2024 16:56:45 +0200
Message-ID: <20240327145645.32025-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: c09a6a5e-ca95-4568-716c-08dc4e6e2cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A4bZi2ar5cSEQQURY6oKfnRcyoKd65FtleKssO8BjWbTA0NuquU++Zes1nevk6xso5Cn4l1zP3eCc0KobiuqzATQGRldzTqcZG2uQopKvT8CjBl0EVvpXalMa25sgYGQFP4NX2eNG053XJiT2x5+nwarHrNEi9I3uakb7VcYx08Gd8Z8vc/4uupvju6AJpBeoKEKcPz3WG3vPFC7vimvf6Y5CsFtEcER2LitfVhjWs/VdwV4njCpDqJvQt5fuwfhIhyZJfYtOKcimwUD+HzXnPt8qR3xTPBiawhM/8socumbEez3x/pUPXtFy8K56lfJnB6vQOAt1y1O8g+oqCdasKqthUZyXeAPZFwtgIUt4x9CUla4R0JjaI91XJ9NytlG3JcUMJBv0RetcorEpi2LL9ZrtS74bcvpxAQir6alp/WYK71K4/Ph+rDS+cpaCislR7eDnk+QN36Io5KPUh25bRFxgFNqXoKos+XPaUrfNsmsEkRSJlDkUiYCkBrHUs7L8Wp/j2uKJVzSBzOosQz9c/DAFPF7V8WNGCWzxxNzVLnes8Ao2aQtBz4RD3MLBzLNIDPQ8NEDFE9d92joxKvAha7pfcb6r5vy0axYMDjE4E327gIco79MIkrXSWc0XStQORuGNHjOwlHBYIHGgpLF0+oNSZwl1uJSZLAEiNiIy3miWCCs/kKjRwPtuh35R3ON1wqn11flcEf6IDBzMIiuL5z/3KtsTCeiZmgKq1jC6UIajl7wgtzjkLlHoqI8YSjI
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:57:08.1743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09a6a5e-ca95-4568-716c-08dc4e6e2cbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

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
  spool-size 4194304
$ devlink dev eswitch show pci/0000:08:00.0
  pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
  spool-size 4194304

Disable the shared memory pool by setting spool_size to 0.

Signed-off-by: William Tu <witu@nvidia.com>
Change-Id: I362c312cca15700077711919c350c89635db64fc
---
v4: comments from Jiri
- more verbose, remove { as SIZE is not enum

v3:
- change to 1 attributes and rename to spool_size

v2: feedback from Stephen
- add man page, send to iproute2-next
---
 devlink/devlink.c            | 25 +++++++++++++++++++++++--
 include/uapi/linux/devlink.h |  1 +
 man/man8/devlink-dev.8       |  8 ++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e397e8e..a57f2edc2253 100644
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
+	pr_err("                               [ spool-size SIZE ]\n");
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
index aaac24380bf1..8775777ce88b 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,7 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,	/* u32 */
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index e9d091df48d8..2a55fa72d10e 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -34,6 +34,8 @@ devlink-dev \- devlink device configuration
 .BR inline-mode " { " none " | " link " | " network " | " transport " } "
 ] [
 .BR encap-mode " { " none " | " basic " } "
+] [
+.BR spool-size " SIZE "
 ]
 
 .ti -8
@@ -151,6 +153,12 @@ Set eswitch encapsulation support
 .I basic
 - Enable encapsulation support
 
+.TP
+.BR spool-size " SIZE"
+Set the rx shared memory pool size in bytes. This allows multiple representors
+to share the rx memory buffer pool. When SIZE > 0, representors point its rx
+queue to use this memory pool. Disable when set SIZE to 0.
+
 .SS devlink dev param set  - set new value to devlink device configuration parameter
 
 .TP
-- 
2.38.1


