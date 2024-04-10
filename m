Return-Path: <netdev+bounces-86525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E6089F196
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71D3B246CB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27E15B0EC;
	Wed, 10 Apr 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qk2JFTly"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D815ADBF
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750376; cv=fail; b=h/ZfQL1I2Tx47ChIKnGVE/N8TsFeGRj/fITqaf0N9g7eawasLaVc1wZ2bCzNB+Fk3Z0yrbNKjrB7QkaJQgsrN/1iiuvo8wzmBI9YWvJc7qA0oAAjxp4R9FVhCi+k2GFGWdXasukRdskqsV8iqSNJZBQQdKrdO5oZgY9/twSnU9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750376; c=relaxed/simple;
	bh=CjOqvziamqSm7tKZwdkIW59P2NGQevJFWRjdCol5Ccg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8ZASuC2Z5cYGcQ+1qpOQVqJv+92quLuDInoRP1wwv0vEmlGoIJ5k3/Vk3/RTC95onuiHAMlH5YtwF4dhy2gCNQXS5cD4hZ+KptRVnd4wP6XE741Ik4irUmy6YJ3OaFB/4IXWmWc+Yks1OWh5qnzB1o8fq2uVqoa1OnNFIzC0Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qk2JFTly; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6yMO5uFg+0ZoxtxIjvzWcpDB1V1vfOHdX1qV3tJ8zp2vqlkj7QlAsMS2FPjVfPA59h6sGsqaAh4b8kEXnIRxGQFJp1O3sQlGAdeJH3FRqO3+1JdDwK9KONQnP0dX7pwu5l+ERQFsotLRLMGBYDRHFiUa0nH+flBh4hn+ZDIw+Wx87kDBl9kB6uaM2mvxpJA2oL+mBSsg1OuaKBfoAOJQpIlr9i7dLmL9MLue4AIiX6m2znPmzEoSK8zSd/c28fYvXwd/+wONsAAWWT+ZqLdWccY879xiT1R99F0VvIVBykRZEbCmjkR7MFfhZtRkeJiC7QdsJEUsZSOfLuLKr7i6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFp2qbDBbobOWPT9jJ6c+39RZni7gmR2Hpf2l6Hwi58=;
 b=n6t+1DmW+DCCvAoHhRr9g/qU4it7++HWxaLsAic4YDu/zAorpoxhM2kL0waZouRFI5CemCLaTFBs6fL0DtJD+HR3LGZpa7zqVTGGoKANBbfZ2dY5qDNH7bOVcQfusSIVHDAWemA68NR2CYQPrJFTwkm9MjDbR0EWQOOpygjXJ0fDNn/qpAD/nqZYuUqjJYWq5ZJLm4A6gRKfchW6ZbmsuhcUUBf8H5U/iEWjl0x7mdY94larmMvsWx86Momi4c8oJ/1zCyjydua3c7ucnSc965BpzZSBKqKLEGNqhO61hHGQbsSNiPDQ7IgkA3ZCV2+cgDAcTKiP1AG2NQxr1KPyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFp2qbDBbobOWPT9jJ6c+39RZni7gmR2Hpf2l6Hwi58=;
 b=qk2JFTlyOi87C+O7JCOTwQqyjZgaW/Q+ysW3FL+J0zk9v7smCMbhUUDD8Qo91TFrum1Id1LuV6xH+jjPRAFhS5qigbRjGamV9oGMuy7SAXqJWN+pxs388Q76UOIq4H2fNSbleOq/6QWUb+4Edb+xhj66MV3PDhPxu65f4mJRBk6qQhq88tkU5FB93G1YHJpTwj5kyrNVVBst3NSWPoAwluijG+C+aTO/TxhX4jbTiJubS7g/5bjBiuLWilrQXCfyznQWxbAKxWAvEXwjKktYd8UJ88hj8WB3RbxzUJASd1M+VA1EaIoA/Menz8s6xIaaOQAFs9+quckkNUrkxr3yWg==
Received: from CH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::26)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:59:31 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1e) by CH5P220CA0005.outlook.office365.com
 (2603:10b6:610:1ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 11:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 11:59:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 04:59:15 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 04:59:14 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 2/2] devlink: Support setting max_io_eqs
Date: Wed, 10 Apr 2024 14:58:08 +0300
Message-ID: <20240410115808.12896-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410115808.12896-1-parav@nvidia.com>
References: <20240410115808.12896-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d99fd9-5289-487f-abcd-08dc5955ae7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7vVi/fSu38d7f1/s7QeutqeCwNof77pc2aknX+OA5YrmkWW/BPB1/OtLHntZ2kWRi0tp6jPsMIhNHdlPHUswMBM+aSqCBde50UWVg4XfZ/DPNjIkdBWCzRK/W0HgHJhh3wgsqKB/byLLC8F8F/0EjmYU+Vt6Y6FRS56sVMCpoH07yhAnJX0D6nDhmpo9JnQC7QG5QuALIXXPqXZIXqBrBAm4ErC1RffbzffMnCQoohHa/Uy0m5HRgR3H1sXI/Cyy76z1iZ7+hk+XLq3GF3MiowxR7eFbIa9OSTmJAM+d0LzG/+cRVPhuQH/cFffS/AyozYY0+a7Nky1k2WWh7o9gyKyxcPsYj/Ypxa1ovmOsHkKGbJgzdeT6Prcqi75dUHTURElLf/+wMKegdPWfP9+283bPWl5bGoGgkvA3vogfsvgGixXweqD4e3J6Nog7E8SXa23vYlutM+QHv/cZyd3KKugZ2Qz7aTQfoHEqksiC1YX7+rvWfK10L4i+deP6SMs0TvflzgdtwGeH7jmqJiBJfHe+l17SMMojYbW8V3jWjWrfLSBe6LWo2Elepry+dVbvoVruAB8uuzFJjdmNmUUn9x21vF8nF1DC4X7xlv4rBcrLAsbk7y/NNbzKg4QyEC7ncRfsSvNUj0068SvHFG3VxwiIqnuKpRcIH2v0RPvE5875cCwlBHn/FV+2Kl89ow2B7ytcoC+N9zuJMqn/QnNjcrb/Hkmf5BbKN0eip6JhnsVDm0DZGioiZgDQvh2NQtg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:59:31.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d99fd9-5289-487f-abcd-08dc5955ae7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

Devices send event notifications for the IO queues,
such as tx and rx queues, through event queues.

Enable a privileged owner, such as a hypervisor PF, to set the number
of IO event queues for the VF and SF during the provisioning stage.

example:
Get maximum IO event queues of the VF device::

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10

Set maximum IO event queues of the VF device::

  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- addressed comments from Jiri
- updated man page for the new parameter
- corrected print to not have EQs value as optional
- replaced 'value' with 'EQs'
---
 devlink/devlink.c       | 29 ++++++++++++++++++++++++++++-
 man/man8/devlink-port.8 | 12 ++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e39..03d27202 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -309,6 +309,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
 #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
 #define DL_OPT_PORT_FN_CAPS	BIT(57)
+#define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -375,6 +376,7 @@ struct dl_opts {
 	const char *linecard_type;
 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
 	struct nla_bitfield32 port_fn_caps;
+	uint32_t port_fn_max_io_eqs;
 };
 
 struct dl {
@@ -773,6 +775,7 @@ devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
 	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
+	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = MNL_TYPE_U32,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -2298,6 +2301,17 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (ipsec_packet)
 				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_IPSEC_PACKET;
 			o_found |= DL_OPT_PORT_FN_CAPS;
+		} else if (dl_argv_match(dl, "max_io_eqs") &&
+			   (o_all & DL_OPT_PORT_FN_MAX_IO_EQS)) {
+			uint32_t max_io_eqs;
+
+			dl_arg_inc(dl);
+			err = dl_argv_uint32_t(dl, &max_io_eqs);
+			if (err)
+				return err;
+			opts->port_fn_max_io_eqs = max_io_eqs;
+			o_found |= DL_OPT_PORT_FN_MAX_IO_EQS;
+
 		} else {
 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
 			return -EINVAL;
@@ -2428,6 +2442,9 @@ dl_function_attr_put(struct nlmsghdr *nlh, const struct dl_opts *opts)
 	if (opts->present & DL_OPT_PORT_FN_CAPS)
 		mnl_attr_put(nlh, DEVLINK_PORT_FN_ATTR_CAPS,
 			     sizeof(opts->port_fn_caps), &opts->port_fn_caps);
+	if (opts->present & DL_OPT_PORT_FN_MAX_IO_EQS)
+		mnl_attr_put_u32(nlh, DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,
+				opts->port_fn_max_io_eqs);
 
 	mnl_attr_nest_end(nlh, nest);
 }
@@ -4744,6 +4761,7 @@ static void cmd_port_help(void)
 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
 	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
+	pr_err("                      [ max_io_eqs EQS\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
@@ -4878,6 +4896,15 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
 				     "enable" : "disable");
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]) {
+		uint32_t max_io_eqs;
+
+		max_io_eqs = mnl_attr_get_u32(tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]);
+
+		print_uint(PRINT_ANY, "max_io_eqs", " max_io_eqs %u",
+			   max_io_eqs);
+	}
+
 	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
 		pr_out_nested_handle_obj(dl, tb[DEVLINK_PORT_FN_ATTR_DEVLINK],
 					 true, true);
@@ -5086,7 +5113,7 @@ static int cmd_port_function_set(struct dl *dl)
 	}
 	err = dl_argv_parse(dl, DL_OPT_HANDLEP,
 			    DL_OPT_PORT_FUNCTION_HW_ADDR | DL_OPT_PORT_FUNCTION_STATE |
-			    DL_OPT_PORT_FN_CAPS);
+			    DL_OPT_PORT_FN_CAPS | DL_OPT_PORT_FN_MAX_IO_EQS);
 	if (err)
 		return err;
 
diff --git a/man/man8/devlink-port.8 b/man/man8/devlink-port.8
index 70d8837e..6f582260 100644
--- a/man/man8/devlink-port.8
+++ b/man/man8/devlink-port.8
@@ -83,6 +83,9 @@ devlink-port \- devlink port configuration
 .RI "[ "
 .BR ipsec_packet " { " enable " | " disable " }"
 .RI "]"
+.RI "[ "
+.BR max_io_eqs " EQS"
+.RI "]"
 
 .ti -8
 .BR "devlink port function rate "
@@ -238,6 +241,10 @@ crypto operation (Encrypt/Decrypt) offload.
 Set the IPsec packet offload capability of the function. Controls XFRM state
 and policy offload (Encrypt/Decrypt operation and IPsec encapsulation).
 
+.TP
+.BR max_io_eqs " EQS"
+Set the maximum number of IO event queues of the function.
+
 .ti -8
 .SS devlink port del - delete a devlink port
 .PP
@@ -377,6 +384,11 @@ devlink port function set pci/0000:01:00.0/1 ipsec_packet enable
 This will enable the IPsec packet offload functionality of the function.
 .RE
 .PP
+devlink port function set pci/0000:01:00.0/1 max_io_eqs 4
+.RS 4
+This will set the maximum number of IO event queues of the function to 4.
+.RE
+.PP
 devlink port function set pci/0000:01:00.0/1 hw_addr 00:00:00:11:22:33 state active
 .RS 4
 Configure hardware address and also active the function. When a function is
-- 
2.26.2


