Return-Path: <netdev+bounces-44407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72887D7DF6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793B8281E54
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2A18620;
	Thu, 26 Oct 2023 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="ubHwAvhu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5616182C8
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:01:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2094.outbound.protection.outlook.com [40.107.223.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CFDE
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuVY+R7TFE2tToEcL05nSkwT2kGOtav1dQmkvbtBaaL0Dtpvcy0j/ZUZcH2J+nHPnTfeGcgJWL5cYqd7NWxJvCOpsG7jlcRCN21W02Gj+LmC4QIXn0Q9YG1bExoOpsxbcKk+ZzE6YoVS6WNSx0EvNat8jQlL8vOabx0JpXqGZBhH2+39NLHzwr/IJX8fZufiuwO5a9P5va3JqdYnw5jd4w600mw7enFYBgYvtfnPPtJ3N3juRwwtoy9gz+ptpj7k9l4Ysi2N9YIJ/iD8SmgSyrqLc1Zp/xdHCgHXS/3AH+fvKZA/RcG/6Sko4i5VZJX56mQxFdvWMzKrOhd9WBgiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPdeubkGavRQINbPwwbxy/1+QTE6YCZtTxoYD7zTTUk=;
 b=C8VrLSIIZNRQIpFl7ON3ibP70WWO1bygrQVdWk/Kr5kOP27JBHNI3X4TTAVtYsB52ywnjLYlrAjyxFUdurruOJ1R528i1zEtDmb8qVQMWVJHimFXNlTdAt25bpQVFL1qj//EjLsj1eat2hIrA8aeJZjmdXuJrQIIiHW98yBoOQofzg+pPuQRwJtz+igpgJlx/iLj6mPknUAHgrrkflf05msi/j/M+xKqhDD4udLAVTl9mPzYF5x9ErTtAukeJFt5B7L3l7fxoo4Kr+dLaK/0SLDXxiKu1licdKphGuThkkxnMsVK7HVm3PG22NZcrlecAUGOqyIQSJbrKnlwIYo8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPdeubkGavRQINbPwwbxy/1+QTE6YCZtTxoYD7zTTUk=;
 b=ubHwAvhu/j/iD5Y7XdTIsVMijJ20sew4j/A+2yNG9oC2eOFoyno/Wx+4l2zLWIx0jno6H1sKmphHvvsd9KjjH5W9Kla5wbS6OQYkmOVXsfiT+Mpzfd5uhyDtckdtVDBlVc3AO08OKDHAxlzsJqcrvn2RNVVYnswCrYoSQjFUXQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH7PR13MB6461.namprd13.prod.outlook.com (2603:10b6:510:2f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:01:24 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:01:24 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2] nfp: using napi_build_skb() to replace build_skb()
Date: Thu, 26 Oct 2023 10:00:58 +0200
Message-Id: <20231026080058.22810-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH7PR13MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0c98ad-ced0-4947-5731-08dbd5f9bf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YF2FfKJVbIpsqEtntHjHqqJT8/m/AN1DOhbBKZZU5fUx6LWOc+Hc4JqFDbzRkX4G6GWr7y/lP1qnRCzXKLVoNlg+niBjp9MYSwt36Ud0UyQjenFHnAGZZlKIf+BIbZtyz8ztx4iNjJ/cF13iWxRzhsiibhqnOtHuL3H8LPj5ShTgDl8R70NEkhaiQFRaukoAzYsdYx70C0CjZLyjxvLWKkHNr0fexlZxjd8J9XwSyTZvltiqQ2jUx3Kz6qqTKZWyx9SuBUvopAGAKlmZZOyG2Wi9LNuB48IBTT1x+VmJD5KCsRv9akCDGoimFTFeS+D/oHvI/LozCotUjSnsb5svVCvoAnBQ24al+hSr60ne7Uz0/GkCjkzm5IpFEvGwIwNrogfmtflJAHCJQChzcSIGF1fo+d4TJ4oEvucFbUQlXeSh9xzYPkgMPPJfaO8fhy1lqh/NQH8z6peDLh4u1ph68rqDvO3srXmJxQedCy/42J2Zf24pNaVZ85b5PelRFjsVFb4FZsMWbF0y3SofuzLnChLVNYeDsAxqsKGxltfaeYu30m9ATUWwRkbQusNMpm7pc2zK7uZoXisqtxyEputQgx+JMsHW75avKa0PBs44Dcb2IKUla+aqV/coLyCfGc3RK6rse94XVAgWlp8FHwESLAyHPbd023RryNvv+3fFbGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(4326008)(8936002)(8676002)(38350700005)(2906002)(44832011)(5660300002)(52116002)(6512007)(83380400001)(6666004)(107886003)(6506007)(1076003)(36756003)(86362001)(38100700002)(2616005)(26005)(478600001)(316002)(6486002)(66946007)(54906003)(66556008)(66476007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBwGjtYXzoTe9AbUG40TUYZ+hnXtBVR904FVU26YKE+Sb01qYhGNy+f10nMO?=
 =?us-ascii?Q?KxMXf3ntRDJXAuoGuRPboZ5PDfTdDAH43+qo7O1beNketnZD5WhkPNnxBMqq?=
 =?us-ascii?Q?pi9SKGhy7R4HpM6yIhsWamhe4dVEdNMnLfgPjeXYY9YqVFw1Sua4Lp2LlYfc?=
 =?us-ascii?Q?dM6MgLdW4XYlPmZEgnXcW5EuDQx2G2Ae1RbwDsEjQQHwlbX6nNjBA4WV8XAb?=
 =?us-ascii?Q?KP83fdVVgtLGKsgd2fOZTkPpxqn3IWbMwrw8BmbH9vvq1RDwsDhTvVG1HH6e?=
 =?us-ascii?Q?+0HpCrup0hR3Gizn9K5uuT60e3d6dZq0pDcY50mWZUiJ12RlzlHN+AuVFeHS?=
 =?us-ascii?Q?lgr8KaVpJo0kv8fhdyGjiPAUXbM5gkJB16EqVm1VRNbhqLlUccekZ3GNrJ0l?=
 =?us-ascii?Q?M0Csa+PEkvs2K6BsdDCL0J9OFb32OSQahPE+rJjeQuPuqzwRqKTFr5bmnkAL?=
 =?us-ascii?Q?4ubtzXIFpb+iijeYRGdkOCzDjjyWwwka8CAKsC/5En6dcimJbcceR3P+tndG?=
 =?us-ascii?Q?mvo3VO9zavagsj5OJmAq3SyQQ8TYN2p4YN5sWEmOpIy4nV3YFLz9n7/bpIYN?=
 =?us-ascii?Q?IiqbJdn6ocJM4hJgQ3x6RHs7WV0mP538s0pD0Iy6Ph1ob7IvPZedzEt1l9dw?=
 =?us-ascii?Q?9n19Cw9YbHZcMIVOebL4nZrBBwCComdE43Kytntwz/FUi0ldQ8fdqVc063qq?=
 =?us-ascii?Q?Spi3frVAI0WhoA1zIVekw3tqWp4ReEZ2FFtEKY1mhX2i3g2+lOfzgUT7HMrb?=
 =?us-ascii?Q?iGnf1cG3mkdcKrQEek8pqbAHL4Mljb+AJDoeKKAJ3lZQvcYGnyFicFLpWzEC?=
 =?us-ascii?Q?8QdGJR5ulvUEHaLtINdffCv20ZZ/fxExcYExeZjkNRY9fx77GkiJ46rwpUq2?=
 =?us-ascii?Q?eOG9uJ1LquZlQvowyMnPVvbywN3AR2r01doYQy6jZ7gQbV1dx5PAWMLXFS6+?=
 =?us-ascii?Q?FAZMojG3XZWb4a/ymscTrj2f2Jq9+qCwdIAu9vhLwrLMd8Kql147gpkjAypE?=
 =?us-ascii?Q?4rpJnMrtnoKAGLzfL9HsWFn57x1GSd2daUo5kGhkHaa6+ES4nUlAUq3pZ7Lb?=
 =?us-ascii?Q?gwOy9ktMsffXHcVKkkTV9Feg61DNrdB+5sYFn/w3khBfx31lspMd3jzu7IrV?=
 =?us-ascii?Q?D/yRt1X3mmgxws8UCbW5Wn9jRzkkW57VzLcKpJRtV5fpQEQJFhczrScjW62f?=
 =?us-ascii?Q?AFQnBa5AaA0WN1I8vwAs4Bz8QBSrDlohNRDXcyf4RU8bPJtd5zdtAYqBKHbI?=
 =?us-ascii?Q?yBtITfg7ZK1Z7VqWUGnkDitgMKypAxgwZz/6v0E8tXVueYzyTMPI0jwTvcak?=
 =?us-ascii?Q?DBpyH7VTp9wsYssaqn9bXHjri02Oag74/JlWihm/kwxOtUWo8V8onHCkuG+W?=
 =?us-ascii?Q?cwRT6WMusSAK/1CxdMCqm/YZkBU2zEiz9p7w/mX/ZFFttyr3/7sIVY5fF/e0?=
 =?us-ascii?Q?BwHvmVsxJaucPQRytfzlsr/UYnVneUy5yl2dE1SxLlRosfui0leyVkNlBLad?=
 =?us-ascii?Q?BSurHEJwXw5y1f3ZhTfGFHC55yRMI1f2DhCWzud0UKV8nJAGVjgw8sJ4e73x?=
 =?us-ascii?Q?ng7H0T0Ah+bLfZq+ETo/HvZ0n1DnvckzqAlVra10Z7Skw3HmjJMlEbpau7rs?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c98ad-ced0-4947-5731-08dbd5f9bf6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:01:23.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoaRS0DrVLgwm2H4pqXHZv/LOl4nFqSFz18SHCnVjGnRPJ3/4qsFgcGBHEWd9cR7R+RJk16MCv+2Rb40jpmREBnNJ1vEjoOob91Ub9Jj8sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6461

From: Fei Qin <fei.qin@corigine.com>

The napi_build_skb() can reuse the skb in skb cache per CPU or
can allocate skbs in bulk, which helps improve the performance.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
v1->v2:
Dropped the changes for the *_ctrl_* paths, as they were not within
napi context. Thanks Wojciech for pointing this out.

 drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 2 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
index 0cc026b0aefd..17381bfc15d7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -1070,7 +1070,7 @@ static int nfp_nfd3_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 				nfp_repr_inc_rx_stats(netdev, pkt_len);
 		}
 
-		skb = build_skb(rxbuf->frag, true_bufsz);
+		skb = napi_build_skb(rxbuf->frag, true_bufsz);
 		if (unlikely(!skb)) {
 			nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 			continue;
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
index 33b6d74adb4b..8d78c6faefa8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -1189,7 +1189,7 @@ static int nfp_nfdk_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 				nfp_repr_inc_rx_stats(netdev, pkt_len);
 		}
 
-		skb = build_skb(rxbuf->frag, true_bufsz);
+		skb = napi_build_skb(rxbuf->frag, true_bufsz);
 		if (unlikely(!skb)) {
 			nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 			continue;
-- 
2.34.1


