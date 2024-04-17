Return-Path: <netdev+bounces-88865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDF8A8D13
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58CC1F226B0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC047A7D;
	Wed, 17 Apr 2024 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMKyZ2f5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24042A81
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386370; cv=fail; b=DQW/sbB7XnTmxFvwJCAEy5miqTW/hSNBRKxA61AYNlfCRzJ5NpfacYDZvR/Qbg4TcYqK6oeTVUYtKKnJQrRJ7itlb9Rl0A6y3yE0A1anEeFhccyA/ftNol0o7fzjqEsTFNm56E4Wbz4b/awYy4HRXw8/ztD1Iz/i7/Hv/tAiC2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386370; c=relaxed/simple;
	bh=ec8uEQq5Rtku2IPDfKpRLZ32xJzJWiArIQAraGDVTWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s1STAcHJ+VnyM+DJmhrRsGkO9iej9ZsR9coSAJaDWD3sQX3eolNJU91lV0AYvpWZt0Q7y9YgFBWahSWo/qp+g/1dPDpEBnRLl5L3JHKQy0VrxRUfcnsOy50TV+TDEcuhS9uamMH6qprdlIkGk+RMLwwqABF8uu7IY3/ectg9bRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMKyZ2f5; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWhsr+5yrcb4ne2J8uJk3yRS3jxE+RKBK5fhKHhXNWg4NoJr7xGEVuF3gi4wQFTbljBYjyVY/sWlq1lIkPDUbh7t0zTmumsjYmrsvMGXEN8q94fnr2A/bI8/S6lhPzowGKEBabroCCF0AjlCBAgLk3OLugfo0qjdxqux0HkvIhEQ3ZS5fQJHQ38JyHWACpU4hQHIbGBKDWYKDIwN7B8ospR2LPnWj0X5Sf1upg8aqp+P6Gcx0N69y1dr9r7xC4qakaZc6FtE+l0lgbZPWYtrG2SlU1jQHUbhMYHA1wrOpWnLRO866n5yhbgt+qvnHCCgVy/W+YOfozrF5VAiGuK1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfs9MntLRXbq9W91bfvnyG9wYGqfyZA9CFvG0S/pocA=;
 b=Vn+wvr9+Cr45+nSZFa80Ri5lfHPq2+FgoLSgK34g0rP99VyQfgOkzUIu3RASdvGbxy3YYD/OgAcdmS+Iyj19PSz9uswXsrzwNsNd4PQGqTLyZO8YtWCxOzV9sbvbKxgi2AOFoIEGs37h5qPE5WmPDbJBm31aq17tzmPrLvLhHQ2I/gqwfSnU/RVHOJN7kbFCzcMzsYDMFKy5FNyd0t8awXzlS3W8nIHIrim59TYQKneuzX+UxVknzy/EMEOaAyIKMMzw3xRaNQQHyQnZBg940y1D/9AKSrfK9opVIJOQjnaO2nOaxwtE7dPhiMUprvf/b9mxd3RwI0KPwkJIh9WRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfs9MntLRXbq9W91bfvnyG9wYGqfyZA9CFvG0S/pocA=;
 b=cMKyZ2f5iDs+dsY1DI+ORI6c4Yam9sajTYenIdpswjdv/ALje/QR/S4/jF/GLlCv+111i8UGCSdoiJ+b7Nh1+y/9krYTkbxZHtUeSfRIXN297D0StKQdN4/n5MelXtJ6FOpl0AtAuI0bu5PTdmWLTW7eQTc4eEb8BVC+a2/ipv+nIrB5IrdJWad0EyWSEFRWx7BY8Enkr3owoa4x5b1mJ6EM3f1hbqYoocMVOrNGxvn4Yu7iJGQoO4p3Ykmf2XFP8OL+iVHF4KYPIkwjt7uVCZYtrL8QLSerpY/e1sai1iR6oajW/5V5pmpfzLBd0fwO+LsrDmIncjsOTX25S4tclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 20:39:21 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 20:39:21 +0000
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
	Alexandra Winter <wintera@linux.ibm.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next v2 2/2] netlink: tsinfo: add statistics support
Date: Wed, 17 Apr 2024 13:38:29 -0700
Message-ID: <20240417203836.113377-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417203836.113377-1-rrameshbabu@nvidia.com>
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8f042f-0885-4749-70dc-08dc5f1e75e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JVupTgJjXQcWP6Xvw8PFTz6G8wlyQwRvLWrdcNwecoa1GFCunhqUfCZCbiQhgQjuyK0L8ygayOCNYz/8T5An1nVljHsFbbwyl0aMTZrA9q/H3pYYAnLe40Gm1fB4aq9GuhhwSawPT4c9fAstUZPTFCB2Dd3g+dD6vOfGqmYGLZez6n2cl1IoRGRqjNauJgWFN3OlnFB1H8CZo9bbHp/mzXJphvlYBN2uGK/4JUwVUdPQ+0uFAU6y8DGeouTHZDP8Dy7rp19XNqu4UD92hK2TpN1E2bwbYGvrC3bG/0UyYf4WCgiMyEGWYjOtJl2YdQLVFwPDEIeR4NwEQZB3Up3EebkczlnHRYLjOR+cKHKOYxivWjVVOBaJFftFj0UrXiIXkyL09PThwLj4wHffbsGdk8WlY0dKxS7Bii1ezIQU9K+g+X2Je0isz5knluOZlVETnA5Z1ccaOoblwZi9vCjbP4G4Y5DXS6UweOmZgAfVURHMDrwrgN3m9DmLkIKc4DqJWl+GG0BQXw5KG1u1WUh2IFKSD9D0IUsed1HvhvyPYwr4EJ+QUQaxMXZuBAWPdiVCxFQzPTgpkVlZuwVewlf5ioQGMF1gBGlckbg2M7s2KyvxGouS9ZHqbYOsM5BL44g2Eq01+EAptoJ9zqHhW6H4DhivNRL3EJm6UFCxdQVDYBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6dwtO/eep6Bvt0Ag1aXbNyVglT3jxakmfpLjkS+SyW1MqyvsL8jDfc62tnt?=
 =?us-ascii?Q?YpNPSqRDl0lyLn5jpdWD0Zx75MnH9eRGt2/C45WTswc6QgARm8OH9KXmnunW?=
 =?us-ascii?Q?M4okYcr48A2w19yET2JvIzF2UPitSNSrOWQ1mi90pvy3WqVbpgLDYWFVy1DM?=
 =?us-ascii?Q?nUT45ALKKR2TTAQLPTkqnSv1DRglHDGbpgK2qCzJexCgXCCNMivAwAbTHjpb?=
 =?us-ascii?Q?1ce1OtJU9CL+dsUEby0/WhzcjKOZj5hurOFqxBh3RSqd/4syQCUh77/13YzN?=
 =?us-ascii?Q?Ei7PAHdjxeWDqRfyubup0YnrZVx1NIlfS8qtilcW9RzckkhNpBDaLg0+Tq7c?=
 =?us-ascii?Q?1lP+FuPd8K2d1BcIuAnvXFRNM7kVOz9ljNFVU62AgLP+WWPR+3hd+7K4VQrz?=
 =?us-ascii?Q?N7VKJnDwWyCoO2Ga6tQl3wJnXEXHfwndGt2pVynT/VFUXg3uufV/DckcVn+l?=
 =?us-ascii?Q?2fZZ7upx/XBKlcWlBaD3RO7aujJ+bFObUIABbxrIzZeql+7rQHXfkRKw8haX?=
 =?us-ascii?Q?EK3KHRVJjEG+0kvlIvuvR/tLHi2E+Fa19VCQprvRBMtDIUaPiTNHE2DLP9Yt?=
 =?us-ascii?Q?xSs1kgrq2/jykomn6S0+SlEtcsGYYqxDj763lF/rAyOzepn3G3hHTEq2l+9k?=
 =?us-ascii?Q?rHeonQBXCEY3kjrhRDNYZuKynIcyLlvshpeJccj/2zfvzV+KVOSJoQudrfI/?=
 =?us-ascii?Q?fw/u0cQGr6AOkGFpExgNlMwWGjW0Trtvf97Wj8NsfBVCM2l2bq0KWwp6fOP0?=
 =?us-ascii?Q?UYqTTEupcDuxB1zIX35Qzh3x18JK353sY/iL7i74cZ5qpVj7X12Bq8zQRj7m?=
 =?us-ascii?Q?xvRG0qajeL/9Z39vohFOMF/2UNSRU99GqWQqaea6aE3AlpVtGcEMMLFzAFcZ?=
 =?us-ascii?Q?MAyqvoZEHlJDp7VB4lFuQZBC3HcrHHCD7XRmnKk/cEDn1hhoU+60ZvdHw8qE?=
 =?us-ascii?Q?y62QMxAhRQoqFbW21yY/xn25ch0LgxQGz0aVIPtgGJ/pA38yWNFpTW/4djUv?=
 =?us-ascii?Q?tcauTOSAodCbf7z0EOG1da/zCwievvecuvaXqhcioF3t8BPjpGFfXQ3UAOkM?=
 =?us-ascii?Q?LqTh/3qHN0XxciAZUaEFDnksTDSO4ndUxDhiz4J8p9rjX2VkPOKs1xZ8sjIQ?=
 =?us-ascii?Q?9Qp+ym+u4OZmzRRrwpXghIqXvpLKmYKLX127E5mEOv+e7EqsUuyx4UR17vjn?=
 =?us-ascii?Q?CNIfS1fk1iYtYLk+hCPVJ2bcIAzFo264uSiMDbrEcuqeDYEL5kbKFHry5IEn?=
 =?us-ascii?Q?B787AM/R2FL68BfVfq0W8yJ8QrG0k75SSP7q6KUFF3fZmD/0ZQpxzCyRySBI?=
 =?us-ascii?Q?H/rK/OH3fJPCVo9+6TGSvd4HcPwNmBsjy7eVYyAMWU8m+7f+QvvbfJJkSOEt?=
 =?us-ascii?Q?5x+3FFGqc4x736CUhIFWWaYFyUSYXFWqBDqYumPefImt0WA4UyH3sH3okNhv?=
 =?us-ascii?Q?Ss3mRcEoP1k10mWTKsPkHHjLfaSvSNxlJ2jewq2IYfmxyB0W21Lxuctuqr9x?=
 =?us-ascii?Q?wmw2p9m45UcFxs/S/YcmVGxoZhSNfBzBDhD8HVx2/lxZaPCO3p3XxZUMyty6?=
 =?us-ascii?Q?zZkiIu5o+r+qjzw5QLgHdJJ/nJkqsXBaxSgL2OMYAME8/kRkzgNLVzhSLnow?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f042f-0885-4749-70dc-08dc5f1e75e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 20:39:21.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEjfViGfVAnAg0vbRH43E+222YxmzScas6r9XZ1Ne92STh2n0lc0tJxJRX9Aqlt+ekimiW9lI8QBJi+h3wAWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

If stats flag is present, report back statistics for tsinfo if the netlink
response body contains statistics information.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Refactored logic based on a suggestion from Jakub Kicinski
          <kuba@kernel.org>.

 netlink/tsinfo.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index c6571ff..4df4141 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <inttypes.h>
 #include <string.h>
 #include <stdio.h>
 
@@ -15,6 +16,60 @@
 
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
+	unsigned int i;
+	__u64 val;
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
+		if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
+			val = mnl_attr_get_u32(tb[stats[i].attr]);
+		} else if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
+			val = mnl_attr_get_u64(tb[stats[i].attr]);
+		} else {
+			fprintf(stderr, "malformed netlink message (statistic)\n");
+			goto err_close_stats;
+		}
+
+		snprintf(fmt, sizeof(fmt), "  %s: %%" PRIu64 "\n", stats[i].name);
+		print_u64(PRINT_ANY, stats[i].name, fmt, val);
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
@@ -99,6 +154,12 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
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
 
@@ -106,6 +167,7 @@ int nl_tsinfo(struct cmd_context *ctx)
 {
 	struct nl_context *nlctx = ctx->nlctx;
 	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	u32 flags;
 	int ret;
 
 	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSINFO_GET, true))
@@ -116,8 +178,9 @@ int nl_tsinfo(struct cmd_context *ctx)
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


