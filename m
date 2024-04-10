Return-Path: <netdev+bounces-86428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DEE89EC4D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAE1F21BE2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5113D281;
	Wed, 10 Apr 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5WG7b4l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C7C2D6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734788; cv=fail; b=uf78ClZugtvaUBlUghs61EX9GCx1mjgIKi6lc8gsBMtaWJjjskcFno7FoctSWzxSLCGb1duU+KoHmglTFxcjfnCvyjG+FxdvnKGmGQ3lsOWeDgGfZDS5JkIjYydewU3AFEQr53OlWGlUo+L6ES69dLf6IHppi6+XZHDZvdTpf+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734788; c=relaxed/simple;
	bh=qfrxsgTFpn/N4IbEROTf9TIelaonq+FtuJSGzg3pucQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qnn4MxnpdxssMLG08jPDNmES6szWpwopMUlGfyfyzyyjAfE0608lM6B9iDlGM/PKzz33PQSdokvDNcsvgvRmicAD/bZUnn5knFINTaLZ/HSy8+KLK09hvXbBHQyPxiGwJDcvt2z61bTC5X43951J2Tm13cjn4nhZSupCiYMfjXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5WG7b4l; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRbvP8KRTbp0j2k1AIekFlCGviHBbl/ZR1s3ghiJMWAXrj4bkPI+mGbfb32YRtGJZVdhUkZMA2snqbWIJI86kqsxKQSsLA0/5/1FsHrOxLegywjSMRcjPzrvUpd/RwQb5EMG8ArDOsWpeOIX9YV/9/O1hvOf2PPWv3xEJvb3lmvddlwnXuogos+BW0QtOHBEKZgVDVdAWF1fTkLXS6Y61AGjx5JoCtdfmDszhozh+Tqu3PtZt8U34Zh2ihrVqP60gedr/9SBfXXIcve5fr2B/F6BeQ0O6E3Q88GOxcM9giyzW+VbE/IQ55uCrHyIl/wDm04KJrLj9WddRWfrgXM20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQGYTXy6luNZTV6WnmR8tqfYWEV5xqjjb0EC6O6v/w8=;
 b=Nekg9Guq2krfqnCwfbKbxBAtVmWhKFBf7c/N/x8R4TGuvPgFpEEr/8FQBeSOTm2m597lLs9zQtz4s0UgJjZWZWpC0oSVXtzPeiNM/zmheTqtX2b9J2PqonDUKkcsmdB9zB6GEDcJvaIDHe1l44hhZZ+1q/X4UoVNKRO3rdp+S22RgDQWldXKtPiIu4dQJm2OVNICyUHlA0woiOjRHFx0ffQagxysNmPN/zB3iFOZ+HsH2rDbmxLVCjPNbfKZV3bHidfnOoxhZogCnTR//AL3YPy2IiSHckoKqQmfuV/7ngE/E7mxGBBVWFhYMSwnkeKv7gSULb2d4WR26S38VDUJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQGYTXy6luNZTV6WnmR8tqfYWEV5xqjjb0EC6O6v/w8=;
 b=b5WG7b4lVj7Z8BQj5IumpFMF7mx/L5Bwsrqlrp0a7A+09BcljBbO1YpiXun9uhsjeT1uwrRNdoGXcrjOIUVOM3xy9lKP2/egpQ64vJdffgBlQSXUJbzjbOjbs9Goe89Bry+BJOiRLhAQpmtxCy1f09a6qi3f581/XdIbIsNCNo29bO2IuMwfLIdfBNMzj/qZeI2S/NvL03dOTJ8y+M+kkGijjP9kPWjyojygl+9NsG94NMnhiUGBs8aDpnLOMMvKdSQT7db7uTaBrDaRrgDSJ0Mr/RyuNSNZgLvGMV6hHFVjYVNkcFkGyJpOucgXc/M1AXS84Z54pErkqdzgxnJG/A==
Received: from PA7P264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::6)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 07:39:44 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::77) by PA7P264CA0095.outlook.office365.com
 (2603:10a6:102:348::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 10 Apr 2024 07:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 07:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 00:39:21 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 00:39:20 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH 2/2] devlink: Support setting max_io_eqs
Date: Wed, 10 Apr 2024 10:39:03 +0300
Message-ID: <20240410073903.7913-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410073903.7913-1-parav@nvidia.com>
References: <20240410073903.7913-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4390beec-3be7-4950-529c-08dc593162bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3kJDvaVtgBYFDgd0qG1Ls+4hzOD/Zl8j+FZSM+J8qvDnICBFaIv5CMNyIX0+q8z7wv0SJ6QjFmIQoKEKvkmHccEKnXr6yPdslhK43qC1eL+S+L6yuUre/9TZuyabEvbpy2vYwyyVLRqC/NCqXfILYmBcOawadC4bIXDw5c96YP8TzaP3z6XXGNZKBDSPtWV1TExOUzSz9srpjFehY+z9Kp1qYkRRJ/rqzgpgw2U2I5A/OmD6dtNRsWuyhSFOihYvPArOYegRjsZBwpddGzGpYt3DA3fH8xRHVlTXVt8MB9QMHT9gNZgZ5zaCmThA3k3Kq2VDr8cJG911B0MBilx2wjGGLRvBivhFN4sFWDaug4QFAoraUFUoMK9csTRAMF8ZdGGKhCqBGokT5+6VONChYsPcbQjz3EBi4N1PbOiFHoo5/qCaXxWbSf1L/B19Z6wheAi0dI3O1RUV+kbJ5Ff5tkUZHpfUeHhUtGvt8Hta+EMy7nGutA1oy3rJ96xiWZPXMQrJTjWwsJQtKxI4p/u+fmgsZb481nBqTIFgqT/3cMBqE1SF+o8808GhcIbVZs19fbIZNh/LE5DXTP/7OLjsfXtnaTCfTmcRvvQGxPe9mSu52DE/dIhA/xtlSDF2OzBem9TR8CibPw8wPObo42jCCqJbAd7WyhvitIIm0gES2cUDOK2RQbbUdQ7XGBB3524mJcqYl33HNGKxP0uoboMntx+0I3Ku8IJdT+ryPp37Or/OA+GZDLDJUfsarhNzCRul
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:39:42.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4390beec-3be7-4950-529c-08dc593162bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

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
 devlink/devlink.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e39..6b058c85 100644
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
+	pr_err("                      [ max_io_eqs [ value ]\n");
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
 
-- 
2.26.2


