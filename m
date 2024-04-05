Return-Path: <netdev+bounces-85105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F38997A5
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78D91F215DE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5487146A73;
	Fri,  5 Apr 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="p34noSm3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E7145B15
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305034; cv=fail; b=GLQjz4Y+uVdCwbLmIk8R2n4fPUBOwz4Woj+XfhdYaLTaZzttpXUM4EgA2sZcBVrQkEbXCj/UKErH4Bw5m/wjf91uEGSMunWyh7HkMPV1QR/1wBa9yvSUQEEkk9rtcHF7t8Kd+xWJ7Cvf9pNxbLMqknnNYft0ELIWtlAF2R8YCOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305034; c=relaxed/simple;
	bh=b+5yacpfrP6rKeFbIaZjklDkRK4FfU/QXr78SHgXO0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvEL3hFiEnDR6Dehnro3cTL02BnFuaEQe34672iwLY9jEECao2X8a8qWi8jXzu18lJIAnbX5gQ81N7NtSeBPuURrn6Re95fgxC/tZdFnK04K+68/nxFlu2q+/ru7bmM0ICYV84FdUyl/zZZtXr3E1qZy/ObcfMfbRn24Y86lhoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=p34noSm3; arc=fail smtp.client-ip=40.107.93.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkxZOo+n7E84m6S9bgVC3mG67NDzrsdZmfVwRhvD06kJsifdgcYAjdbaodRnYnTJLCjv7gyoPFbfDJHNQYetkpu8MrtL2+IPOlRiSyihiaVTlyDvmimbUkiOAC4Q8SprGmXnO8dzWtFk5J+vRcUAEUnh3LuQh1nv8HPi5XYXFj9sDVvbrXQ+Ua1cd/2rtk0TkqUzoKwh0fBHLq4F9CsJqs219nKUsIUX5wnmBqOuzP/hRcrKLIRx0ZVp6vmDpVtHU+5xhN/I4mDouR7uxe2VtOa77k5AEsLVI9/f6SQhIj+TYR6zmfnf9MA7lDSp/lP/9+zbvMaQlyJmTPytH0ZGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHUvb+RyJzN91AarShGLkXOSDuC04m8MpbCJ+S/Bgw4=;
 b=lCL0n7iNGC+Oy5iBCnPw+VSeMCdboODFbPiFmlUAVBpqHDV8+R94v6mY18qiq//cNJj+YPE0202IAttkWRvsrpRzO8hHnupRdRYwGW//trukAKAY2a8d6nw06Nz54u7qV9nAYRxZ5EGajkkSMNC7pZK3gv4K8lktddD1JD6Xy/lXT5I3w5Snndrt/Tv493gU6ghdUCEhQ17jsAnN2COrsQIofPuCRMPtw9wwcmb7Q3/q5eduYvrC/BgUIIqbOjPs8HAEy3G0vJSDDBBgswT2AehIcZERZ2EFLwQxAGWCL5TI435Vpud3moS96ASOJLKE8cxZMFBCkEiQ9jWIKfM8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHUvb+RyJzN91AarShGLkXOSDuC04m8MpbCJ+S/Bgw4=;
 b=p34noSm3x7jSb7xoQJPnx4iiKcP2oKXNJMqdDxcrvnDWFc9YXwwwT6SWdYQQ7kjCu6eTZyVESESCYa6tKNfMt94dp2+m+PekmxlcGfxbJtwKxwTJj/+mdPEKG/sISDfOz/20JfrfqDRCJYZx9lji4kQ5QQii3/Ta4dBwV+JuNkE=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by SN4PR13MB5678.namprd13.prod.outlook.com (2603:10b6:806:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:17:11 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:17:11 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v4 4/4] nfp: use new dim profiles for better latency
Date: Fri,  5 Apr 2024 10:15:47 +0200
Message-Id: <20240405081547.20676-5-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405081547.20676-1-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|SN4PR13MB5678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5jKfYCz37WlHsHGI+xbKxwFytV8J7+KhQ5hFGV0fqIwGSBZ9p+zGFMyiPLfC0VmlXBimne+eW6A0RRjDUkZo81+368yGi8opShL0lZ/BzxJ2aEioYXrR6QmFlFK2N70g8SRJE6AN1xHlzmHAJ1dS59zzgJt8cgMEU6qsIyeRgH83hDVQ607DaWiH+EVGk8DBrpA79fjz1hFJVo5U64kWUCQj9V3fefCO5enbBR5PgEiiRph7kLJFXQTW/3cw+nOLTs+LuJygy+jFWcKIkoTWnkb/Q/sts90gtj3wBiMcEGvA6rhT7oX5e5wyjXfXjp8bIA70tziOdbr+1ZX/Y9IbnG18pOiGkx6UU8EqrgDumfLEs0eCoPYrYRNIZh9dWdZoU8bSGb5NBVnos6yMhnlb97j6ZpgvB/SibYlidPcW7+8ecXbu7OPXW3G0M3RQLG8wUy5bXmpsFLyM/hC4VE06HCf8oR1rh+pfMMyAUVbAgKAGE+xqTzQ/YQZ4ebzVQZnCgNfcw24p0nsMD/IKY66CYVFAZyNdun4Lw52XOBvjMUuVtcHrAfyuVw8gWn+Q7ZsxCvQ5azy9dOwLefQuUeyhVl7z0kVd95z0dt9+dXStdoEoBzELIsohgpVaaAJStDJnoFoDlRc9nxtx6j40Moat8vc6knWXzgk0zcsQdrQQWfbs3zzeX9BoQF1D8ntLJChi4OZOu4AVZJ2pTZZyPwszib64oBiuOGPe+71+Oc8+HGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4s8PAxJVaQFy2MGw4Dh8wG2DDaXxwp4OAMG5rG1KFUiUuoRjeZBlPe8DyZI?=
 =?us-ascii?Q?LV03Pm8EeRP8mRm5VhxkMPzehXnZOCMNGilOrwEciwukj79ie4xThgBi6+gp?=
 =?us-ascii?Q?0VUnEk0l5imuiOJqjJSVHBzQPpxM43vhnRO4n0GpM4w9BIVWkhVVaOmvqqwd?=
 =?us-ascii?Q?rpdrIhm+N6GrmGoyLSGJ7mqIHjYylT5rfIH7z90qlCwdYMLuQzeQgJVVHpVs?=
 =?us-ascii?Q?jX2yFaTGKBKjJ/znyp8P+eYO5IGqKCg8NWU+ztUK+YgdsCIvWMkP3QY9rbL+?=
 =?us-ascii?Q?Bu48xFco+4VoDkx1Kwl8Dv56QPIxUCRQAcNWJWDIpeXglQ1S11/rb7mS4wqH?=
 =?us-ascii?Q?RSlxsH3RbKDGK4e0wUIJVFALNnrLOYnFRfBYoCl8F5j7CfnksJoX4eKvDtMi?=
 =?us-ascii?Q?vcip00WZ2Vgv+zfyRm07GS+aLssrzQ7oTgCKWAQkHGH+t95QbqlFErDCXAH+?=
 =?us-ascii?Q?MScyQcO9/dsH4wOIgYySeuXkviU3Zz8Ko9gv6wskp1eVo59xYXb7ZJjg2xbE?=
 =?us-ascii?Q?kfIfQdSNYSOW7hFrKrl9V72GebbaTp3QfILVxCsH7ih3PTfaA9c12lN844rN?=
 =?us-ascii?Q?18EV+9mxxp1ORg/UTUQxe5brAykANiwz30XBqKTCvmMN1/N3HKQm5BpaLY6/?=
 =?us-ascii?Q?vWxXga8yv9m+2hvSeSZVzoZuk6g4rlMSPhUpIKyqdZUD7KHHtHteC5rlaHZP?=
 =?us-ascii?Q?l6LgG/o206SD5ckl8k9JaeA0YAHAIIl0ITIlYLEVWjcUWDBVlWGCYPKuHnXd?=
 =?us-ascii?Q?MR49kRDOnFVS06S4TmirE57fchRXYYZhdIoVxBTONvsgTuHAEoPKoGC6gkNQ?=
 =?us-ascii?Q?Mxg8ti/MM+Is9zpzpD/WCQmq5TbL7evMNw97n8I+oRA9Q8gsiZQb6wPnTfmI?=
 =?us-ascii?Q?gMstl6pf5j9q8dXl4jEHqvJpGDy6xea5Wb2jyZTDE9GMjGKQ0Lkx9k5QeJlO?=
 =?us-ascii?Q?zbzdxlZyJTwZAfA/PSzNlbXDrzaJ20kAMG1Wa/w/5UXFmGMGIJuDroFSHYVN?=
 =?us-ascii?Q?vWZaiFgYSBSySdLvCzO4zoiGmo4gSUQvU6dBnEgDRWxkYo7vTeuCQNCXfTcP?=
 =?us-ascii?Q?j14PqFTxTcRE41MxLZH9mda9Pk332dE0i0nGyeqiuqnM27pmJt5xFaDLsSBa?=
 =?us-ascii?Q?GUt7cVfs527gLSjAp4ln2kT+ErqIg1W+vIC5GSSJ0eq9rqwIbANng1gd+tAQ?=
 =?us-ascii?Q?Kou/a/eleCH/Rnw4vuWntZAXr5BfZq6CjbuG0cAmEC6U5RSRvN+4rwfKghYP?=
 =?us-ascii?Q?W7cEgM9/PZtq+dXZkXIHqMQTlelZEQKQJe0zd9h9Y9vPAdXdpUxox10rGesR?=
 =?us-ascii?Q?8+DD+eie0GCWRdnOFGAqUeOPUP+XcPldYIpq+beXSz0uoprVZQ7UwkVBeHpi?=
 =?us-ascii?Q?bpa+4fceRRs0RxKcSGnm3v5O4R0JqjmH01tj47dlwOhChxVTgasL9zioIrRQ?=
 =?us-ascii?Q?1XIa9FQ+f836rGyeVlLJ7EEgU7Lh3XOkuVIes9szQzqGBSBwBn9+jMiOocUZ?=
 =?us-ascii?Q?MlpjHfn+D0ledoJX54B1XsHgC7Qll4Q1VPazhDBqCvHjMx1B8Qfzpi4p9trp?=
 =?us-ascii?Q?mM+bW5ZrV8LlEpsIZl0AoxkACAuX+u+fh23LErc3+CWIssVflQeF7KSsquDo?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0856b4-29f5-4397-1655-08dc5548cabb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:17:11.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3b3tifQRQDKYhqP7Uxbyf7nFesa8qH9mvBlNzTq5s5TKcsZLMVJoSglRGs3QlEyDSP1jxYful3oJgWV6PEFuMjzGca3I+9MunnYIIdN1gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5678

From: Fei Qin <fei.qin@corigine.com>

Latency comparison between EQE profiles and SPECIFIC_0 profiles
for 5 different runs:

                                     Latency (us)
EQE profiles 	    |	132.85  136.32  131.31  131.37  133.51
SPECIFIC_0 profiles |	92.09   92.16   95.58   98.26   89.79

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 997cc4fcffdb..4c2dac1e1be4 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1232,12 +1232,12 @@ static void nfp_net_open_stack(struct nfp_net *nn)
 
 		if (r_vec->rx_ring) {
 			INIT_WORK(&r_vec->rx_dim.work, nfp_net_rx_dim_work);
-			r_vec->rx_dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+			r_vec->rx_dim.mode = DIM_CQ_PERIOD_MODE_SPECIFIC_0;
 		}
 
 		if (r_vec->tx_ring) {
 			INIT_WORK(&r_vec->tx_dim.work, nfp_net_tx_dim_work);
-			r_vec->tx_dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+			r_vec->tx_dim.mode = DIM_CQ_PERIOD_MODE_SPECIFIC_0;
 		}
 
 		napi_enable(&r_vec->napi);
-- 
2.34.1


