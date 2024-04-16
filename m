Return-Path: <netdev+bounces-88474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285928A75C7
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFBF1F21439
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6843147;
	Tue, 16 Apr 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhEb5ctX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03623CF4F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299863; cv=fail; b=XGLG9F4zLlN1Js1/9AihyEuhWte4iQAxX+jbZEfnBiGpIOqlfZko+olmVHUrb0PDjVPjy2n0eTqJC5QGjf3E58meXCKVcOR8rLTNT8GdeA/QBY/ZzuRKiyH1TkDNnA0gM6YXDFcwZMOnDmYXlD2IwwsY2vwxu19RlHFSfTnj2QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299863; c=relaxed/simple;
	bh=rBZgjsLWqwULxlLzb/bE6jRjffLxuv99CjvpwzxkP9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkI+XpMm7jU5ChW7AYeV7bb1jUc40ZvHKXqvwTpd7yYniKkKwMUE8kO1mIVYOTOv7JvNHhcopYidGAMedxKHZCR2fxuqcgUa7KBtkc5exG78b94CnBo4kGgOr7U8X4xuUA+5UoGao0XN6V+Dxm/b7833m2KqYjqs0AOuBm0Cvbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhEb5ctX; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbdkjEW49mgunk1mPJWP8KTMv1BZSpsi8axJc3eAzUboXSa6dYbmoOGqueowKU9MRC6edChQnZav2sByjB2KcSCGg14A9sdxtERMlL85QHHeOvAgYf5afSX69OsWy14cxqR04tAYebNlzs9lUIvZD6ZNiCptBvWrZeNHfyjU/DTm24E4qXNgMGjwolIfSiH8UFrwJXEjqmt5ok5uP1M390KxFOeARIPRay5EtZ5mbntxlhW53Y91RKON+z81tjUzVMvqJmDG2FoIR9Hm4zceHd0/7ivwIWNVOuBey75HP6MVyJoTSrR5hcQxy3burtw5Z5XIaCfkMrT7wHgLLQmBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TwpUbmRIc7/3I17ty1DU8nyu+L4tGyF0aBuD7RsWPk=;
 b=RJyBE3wkbM7iFFEC+TFareVz7gNQjVqgukkrnwuyj8TXRO0dRzHfC0p0qJf1Sf7t9+XQL3VHzfDQdW2TvEYSaMil9eEi1PvSmZFwjWVER9HsbwDv9noeUgAYxa1t2tC540nlEjFrwtZaDPuGULqeUGgYW5r9E84zPeXtbmKp4+GYRcpcQdMh0IgGJ2+LUyxGZjqTFlcIVSPQKKXx2tpIRCbWL5WsEJkSy7eRd6Cpb0XzlBtcQj+rvxD+OPsoqvJ+Gb4ayG+QihDjOMDjxPBm3MvjnZfm/Mcb7sHlclnrhQ3C0Hx7WbFKydpIz6PVqhgdwrWwwBIBRliLstjALkmsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TwpUbmRIc7/3I17ty1DU8nyu+L4tGyF0aBuD7RsWPk=;
 b=DhEb5ctXuctxW6ogzA7JV+jioODlqK7dmJp2QWVBYSt04WvRyU4MD+XVBxz95j4sNmyCoFHsBeKjJLMd4Gs8tJNR7u22hopXK63KVooWonmOMSBnFBJPzQUdDE1fN9BJqT+IoJADFbuuHhC+Y1niJroKY8ye3p7cZc3F0ASpfXryEIrbgMYRcIi9trffsh4XBjPkPSkyB+aFaylvoLXqqGvlFdCGvdJfBfwqQAC9eT1oa/hOAcxSctXlNlMTcjm2U+036+f+z8o/Ho4qoeu60r3IRuMEChY/wtoZ0C5WmG4fcAOQe7oCJhHIQCr0nuyiC94dhbSKDUj0ujA00r+cDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:37:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:37:36 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics support
Date: Tue, 16 Apr 2024 13:37:17 -0700
Message-ID: <20240416203723.104062-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416203723.104062-1-rrameshbabu@nvidia.com>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: f679743d-3142-4ef9-050c-08dc5e550d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRklWj/608bwdp6RqCt2gZ7CHgZwjzdi8U+dch5XcVv4LLddio9czy8EFpksNTGEvv+ZEC0lyRpDcxjU+2PtKhnZwDSa9nEGAwRLhQ+WahMfaSdhf3I1/aftge0K1vaDJEAqL6kGR4G9wvlkfQxQxfg7a/wUZJXxFV+23THqSQcaMeO42A5Kk9V5hGsC6QAhFm3tK/R+ZT/zMUdBqHonqBc3pI8MKjfMOY1ONP3lFA9PEwdBYfb+gar+VcS5X4Y0ziL+Sq0SFYyCOeSX/iA6lYS7JgRwP6q0Mfy57qi7C3ZDyG0q3ieP5IdWzNws56zkCZVBZlfsJc55rIVWCmhF5g7OpEqJZhBfMS9v2bQq2D2CXQYBfJySSCPSWSv1fBXPQMPki4c+IkabHJx/PJP9l/cfM2dpM8IVXruFJdJHnIy80zABnKSXHHBnlSsBowfOsRX3CVXwjgG7/nhy/iBzq8fCpJg1IZ1aH9j6ei/o+hdY2LF/sXMYbG5g1axDMHR5l8TtWs+ikZ4R84Rkq/aEFRiAurQ2w/iogBBosv8CRlfqAVKpSM2hnoscI/nD01zHtuKkAoUhWs0nIEYfmHQEiCUPQOFwph1ZhhTlyTJn9w84Hjc7HKclJ3dRDLYuV9+aVe6bHGT/Wfe8C2LBE5gMiyXwCaaKdXVDOv9xSuBHQOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LScyQcoXOgcqbH6pQMH71NHAKnaw4rYQwZLx41fEcU6lZT124gGlUUWpU4Y1?=
 =?us-ascii?Q?/nMf5F6oqDiNejJFrROcPjTIVzOA2/uKT9AOFtXK2dzHqaC+IYhCcKSAeWgF?=
 =?us-ascii?Q?4PXvj6/qUZgal1Z5kMC7duoOTyOE0folXlTxlzsQJaN571zoWlUAAkwt7WfT?=
 =?us-ascii?Q?Vp/Sv0pZcloLm3DqdQlSVyUfyZoOmsjwyvA6mExCdbRxlClfJmsokElgQDUj?=
 =?us-ascii?Q?8L6tMZb8j66x5Cb6XoAVR/HMus0ZAvyck3j6JCup4zPE20NCHiipBQQ/h34U?=
 =?us-ascii?Q?iD6f9Tb7aP/dtwgCsHEQiEQFKCXICsSicbybj48sr4LjPdxi4WXmREjV4rXB?=
 =?us-ascii?Q?+DevRTha+pgWuPzgeVAmQrVULjkoZum/O/5r9HotSPgtwQEfH0c5LWCB3dA/?=
 =?us-ascii?Q?tBasAjGzsG13rOYmFAkCmJfRHgh03dSQiweQ86mt7O1fz54juyEnIo2tWWsS?=
 =?us-ascii?Q?VfsCOGQbfDfaq7ncOLZM6jKeGDmJXrwgHSpSvAOOv7uMJ60OuwWun2GCV6zQ?=
 =?us-ascii?Q?b0ipXYuQ5SOfeMXdCP1hPIFkEKeWLWVyqXwhf6Cq+ea1rhWAajc+f7DP/CU1?=
 =?us-ascii?Q?Bgo7E4dl/86fgG9uIIa3F0vsIbcP48uPjdEqmri7SR3M/cnO0j+DhEkiJw8+?=
 =?us-ascii?Q?+DSaUGkkNZ5ttklmpX7RUJgld2bKxY6gwzti2kSpvKrP6g2EZh0zujrugHkf?=
 =?us-ascii?Q?678Fgq3kQBDkzCijPgZfpgsY9GQCLSkSsGpshvHcRCQYOKgk6vpuvtYlTy0X?=
 =?us-ascii?Q?oSga3iyAkB0LI9hgb8RRKAH1IskQZfbZdowgDkVkb8RCGHh9K+uEM3ptl9wz?=
 =?us-ascii?Q?30Zk2K4UXVJvTxwG82qPwIDH0hUMThwPPDKpz3eGk+DGTzJvdIEWEBXmqbA5?=
 =?us-ascii?Q?b2Dzr54JLh8R+7yR3ajS/hCIAlD4Vfj7Hyq1k+tZktv5OSnNzG2qmuTxhVvh?=
 =?us-ascii?Q?rYYGiQZ6umThwvcW7dBzyKVsq0JxK6W6H12YHLmajttXYKVwVyA7yuojs9hh?=
 =?us-ascii?Q?MFiUBWQ0AXtFvoz1+WgVsnmALInrVAnkvZysox1ZJk922aT+2yeEXDeA8Ysn?=
 =?us-ascii?Q?IYIca/Hg+ewD7baXhAOjbnDYraufc/cLIXgU8etYRmixSQgG6TsjDRU1dxjW?=
 =?us-ascii?Q?1yKkBK2otfTrUauRij/zMJ9P5+SlyVVWdICzokrUXRXPqZzMHYRwyd5pgkoF?=
 =?us-ascii?Q?F2bNd/y+xkwOLcss64vYo8RCHnqKwNS2/X+u8RljrUHr21hhzE15gs7DGsSw?=
 =?us-ascii?Q?7o0UD9k2GowZW9rPeYjM1jCtn2yedw1tidBbGcYj1/bRfxxkXeR03w2D+jDS?=
 =?us-ascii?Q?qrvLwJUirCZjaxLzyNcfLOYjbGDVLp5AWx/Sszn3Q8JAlm4Xi+Bk99EPtWJP?=
 =?us-ascii?Q?hj747+bDoeIxGRyMdTb47qsWn32Zoeko1LgyDfx+Eb4zLD7p7IAVKyWdJAAm?=
 =?us-ascii?Q?PGwFw/DKh6enXIAwUdh3NuVbKvDFJmN0/nE5oKHz51zcHz0iJpBkn9KK8aFX?=
 =?us-ascii?Q?aoU/4FcFlIXc9EhFA5D9JfqyMUoJwJpAIuWQuBAr3TSPNb82gabfvF/4t1gv?=
 =?us-ascii?Q?VZkI/s9LTR99xqlfPAbel5OLoX4IkFNPN+3zfJuabRX3Wp7dKN+ehWZ8rC6o?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f679743d-3142-4ef9-050c-08dc5e550d38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:37:36.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDgPw1CPR/1/1BagzGsYplfp1uPhHKWClZ/ar4J8WMEklDKuNSNlC1BWxKL6IGTNaNqf0edztgTubGvnZF0YRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

If stats flag is present, report back statistics for tsinfo if the netlink
response body contains statistics information.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 netlink/tsinfo.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index c6571ff..ef5985a 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <inttypes.h>
 #include <string.h>
 #include <stdio.h>
 
@@ -15,6 +16,61 @@
 
 /* TSINFO_GET */
 
+static int tsinfo_show_stats(const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHTOOL_A_TS_STAT_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	static const struct {
+		unsigned int attr;
+		char *name;
+	} stats[] = {
+		{ ETHTOOL_A_TS_STAT_TX_PKTS, "tx_pkts" },
+		{ ETHTOOL_A_TS_STAT_TX_LOST, "tx_lost" },
+		{ ETHTOOL_A_TS_STAT_TX_ERR, "tx_err" },
+	};
+	bool header = false;
+	bool is_u64 = false;
+	unsigned int i;
+	int ret;
+
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	open_json_object("statistics");
+	for (i = 0; i < ARRAY_SIZE(stats); i++) {
+		char fmt[64];
+
+		if (!tb[stats[i].attr])
+			continue;
+
+		if (!header && !is_json_context()) {
+			printf("Statistics:\n");
+			header = true;
+		}
+
+		if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
+			is_u64 = true;
+			if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
+				fprintf(stderr, "malformed netlink message (statistic)\n");
+				goto err_close_stats;
+			}
+		}
+
+		snprintf(fmt, sizeof(fmt), "  %s: %%" PRIu64 "\n", stats[i].name);
+		print_u64(PRINT_ANY, stats[i].name, fmt,
+			  is_u64 ? mnl_attr_get_u64(tb[stats[i].attr]) :
+			  mnl_attr_get_u32(tb[stats[i].attr]));
+	}
+	close_json_object();
+
+	return 0;
+
+err_close_stats:
+	close_json_object();
+	return -1;
+}
+
 static void tsinfo_dump_cb(unsigned int idx, const char *name, bool val,
 			   void *data __maybe_unused)
 {
@@ -99,6 +155,12 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (ret < 0)
 		return err_ret;
 
+	if (tb[ETHTOOL_A_TSINFO_STATS]) {
+		ret = tsinfo_show_stats(tb[ETHTOOL_A_TSINFO_STATS]);
+		if (ret < 0)
+			return err_ret;
+	}
+
 	return MNL_CB_OK;
 }
 
@@ -106,6 +168,7 @@ int nl_tsinfo(struct cmd_context *ctx)
 {
 	struct nl_context *nlctx = ctx->nlctx;
 	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	u32 flags;
 	int ret;
 
 	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSINFO_GET, true))
@@ -116,8 +179,9 @@ int nl_tsinfo(struct cmd_context *ctx)
 		return 1;
 	}
 
+	flags = get_stats_flag(nlctx, ETHTOOL_MSG_TSINFO_GET, ETHTOOL_A_TSINFO_HEADER);
 	ret = nlsock_prep_get_request(nlsk, ETHTOOL_MSG_TSINFO_GET,
-				      ETHTOOL_A_TSINFO_HEADER, 0);
+				      ETHTOOL_A_TSINFO_HEADER, flags);
 	if (ret < 0)
 		return ret;
 	return nlsock_send_get_request(nlsk, tsinfo_reply_cb);
-- 
2.42.0


