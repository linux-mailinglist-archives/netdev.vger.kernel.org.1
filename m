Return-Path: <netdev+bounces-84539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58999897335
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB431C2325E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC9149E11;
	Wed,  3 Apr 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Iw8aALCq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2122.outbound.protection.outlook.com [40.107.101.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443E149DE7
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156317; cv=fail; b=kkl8pgw4yyGN/erePE9JaL7qDGGn4os+mF8M652DZUC2kmRLhgA/TVxmc630do9fzsruUt6EgmGm6oL7IcUuHN4YYts8y+teqNQBxAZtEM0y1MXYtEyepK1m5p/oYGHwQQy7vDiebfhp3nD2so1uEz/6rIw8PZ1812i42rI1rYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156317; c=relaxed/simple;
	bh=b+5yacpfrP6rKeFbIaZjklDkRK4FfU/QXr78SHgXO0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUeAlfwH4m5+J2p2fOPUWtdRzLZX1Z03qFStKHb8uFNpak0/ZL19/XVEh8cjttsj7SWWPe6/0EfLt3twJ29bWZWM2JcOC8OZIuBKZO4s0WlxptgJcqFe5GhlDHZlTjj0yYykEa9mhTMlPPRzq/3Jx2onzJ5riC2y7ng/mWXlCxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=Iw8aALCq; arc=fail smtp.client-ip=40.107.101.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUtXZJjnilLa9x/6nnjsyzKOCVmI2+kQWgJ1ognyu5nj5UrvIXCKy8YgvWGGAIRPv3moI9cOyo/rUohU0ltBxKC7JgnNNJEeYizRD45ZIgXKxVTA5O+EGXYGEGqkQp1+GQ53z6DquA7DWyNlBe9wKRp42CdNgRJoDOThEUdn7afMyYWZV4g21KWlmrBrWzGekBnWppOrgAHgWSLW0t/wXrK5LN/vAwC2iQW2zpW3NceuVtbh94UNtz9pb9uP5EtfIEi3rXzlzLHBO8lIO+bZPDZlvh8Iw9wDhBDIfNqZ942BdFgDlJUDLxNv1dxul2fgAtGG/G8ri4SFYeSTiDZBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHUvb+RyJzN91AarShGLkXOSDuC04m8MpbCJ+S/Bgw4=;
 b=gU8XTK5naIjm/kLeRVmfN/+hXZm75m3b/1om9yMdGu9/DIg/fvBP7n9sH7dIP0ll1gPFy+OV76XHA+1A4mVr/U6x6Da2gwf0SQZDyGw/HM7F5DunD7qqpPQlNRdQtFEhj8a31lJqB1NYnKKAlReLrQ6yN4rgnpDxQWqx7YDSIhv0XzAYvGZua11RCV3VABTHCdR63uWaviJtLbDfoz9nfRQAxzn61FN86FAGGjKClxmYepdMMd9POOnzTYPL/z0W+OQiYHc/ZtqnUmW85zVjq7VID+F524CdYXEWsqYXRs/FszK9D8U2s251aZHVxwqnTEE1O4Ik26dITWp0c7K0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHUvb+RyJzN91AarShGLkXOSDuC04m8MpbCJ+S/Bgw4=;
 b=Iw8aALCq1Q0cj08OhkMd4tBiDEsugdp3LGqDYudufRCa7b64WU6xLAndm73YPLSYG7bD9naXXw/ewMvBHFVimHSp5pEfsezzHrWDbfSQSU0flsw6UG1UTL1GnUy7dJORMBAQSSoQO7ZvbVzHku/OpiEcD6f9ardqr76+8vvbWuI=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by DM6PR13MB4528.namprd13.prod.outlook.com (2603:10b6:5:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:58:32 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:58:32 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v3 4/4] nfp: use new dim profiles for better latency
Date: Wed,  3 Apr 2024 16:57:00 +0200
Message-Id: <20240403145700.26881-5-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403145700.26881-1-louis.peens@corigine.com>
References: <20240403145700.26881-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|DM6PR13MB4528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OVlnPByqrb5JrZeb16vf34G9BpRhHq3srorbvK7pCTMomHwEbjn1le6e5d8SXd3RvLVOG8XQIl+n+C4Fw3fepLLLdJ+lXjWtFUpK6+VdY8q5+PVIO8d8UA99mt+6qPbWKtTGtrzQnFiK0pLtHWrzkXVGZWRcp+ha7Wt7as/4zOkZU3EKhszBMV3xBGHX9QPfqkL4I7hHKmmGesEybKpUKzMnS4BMbLtdb0IzjS2VU0XF9/fIIJmNwXcTh9gz9I0Rw9OnQbxwoXqc3XoPlqs2g+KijboiZIrFta25hTYDEQ7tdmAqTw4b2F71yL1WQy31tfQx520UgEhey2oMQAbVD/EFndsp5PbMyfmAubnzGhSkmJLf/mcAxVzi4UJuuFsAJi+Gdb8Ow+lCFwt66xD5ILL1BzIiziKB0+E+UfxSLB8pluZDpk4M3rIMAcf6puzDF1Epca8svA2+OKWTupQjHf0G9I91fjAinyDzCvbps6LCs/vC/UQyElWh1kuXE6h8nVnk136a5YKfwG4ruIW05fwi10+gUONKoyBk2s+xH4E3Y8xIX7Ka8nr2lAac8fV7+kA6m4doTsPfWW91URo24xV8wtaFWgL5T9Jt/DhVFfk8stOEv/W1KjJohR/L/mo6vbJQi14gp9F6NOGjueMP80FaHyaFQFTl/xcEG2BEiIS1F8HlvOzpw9BJ96rUyF4mAK6iwhxMcbCNKVWqr5FpfJHBLdLymJjInq711K8vA5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjPIbATOfZDgkaXo4quRkFFUkCu5imZc+c2ArYGrHFAu8RkPpUJMjJP6tWWS?=
 =?us-ascii?Q?IgWBv02jjHkDbK5AOWHXar/+lHBvMonTjhmrkzEOMP3MUd07+zQR+elXEcM3?=
 =?us-ascii?Q?UaT8WtZLoVHRU8xtH5HaSJb5jZqzI33JfBMdcTL6ghLdCQEIbbZryHN7wzAV?=
 =?us-ascii?Q?82j4Le9iBh+EJUoyQuYYnTny1fXxc0iIrqLOfHvlEB2NkGzmHDMMvvD12ov6?=
 =?us-ascii?Q?uTY0SLDEy1vecJ3dG6xy9BdjyUMv0G9/5TYFRbLl8fSYBQMv1QHCCGPoEEVS?=
 =?us-ascii?Q?9f0DDA9uaj3JDdiw7aQNDW2zHBXROkw9z+rWvVEhRIXrn3CR0gby/dJQlERL?=
 =?us-ascii?Q?U2UY3kKNlD8Q/YY9JhzCTE2sRiv5UONZp91huSqEJ7ycZ8MZ38QGl+Vdfxwo?=
 =?us-ascii?Q?nw8azDnPnQbRXV5SxFwXGvne7Xo51BR760YYTkzHuOd1P2G/RmPTvPj23dnL?=
 =?us-ascii?Q?WUz9C0Lcf9DhwRyquQOXhBp64x/rOfvdGhetOd3CUNL6a+Jv80BP717g7qG4?=
 =?us-ascii?Q?5BU/lEYll9tHE4c3xsolt4Ziox2R8oUAGvtzTVYN16zKf8oCL4nQWV6MOMGx?=
 =?us-ascii?Q?m1gmoHSSkPQ9o4kI+4ilkVeO5nr95LkZzHpkKqcWUWEVNoBiGlwLV/RmFDGc?=
 =?us-ascii?Q?l6D9OAhMM0LeMOPAaAgrU3OaV47XdMYO39MuMLsuQ0/0nbaHiJlQZrm13oKE?=
 =?us-ascii?Q?dIHWL9UtzGtjCecLb6Pv3W72wJ42mt+Kw2lwLI2FIVowP+vdlTW9kML9V1ed?=
 =?us-ascii?Q?hn80t/swY9p/1um+U/W1w1d3sYxXvwMOq6qwu0TCWhCZlY6RVdilOb1Pf+2p?=
 =?us-ascii?Q?gk3RqmPPeWlEGxalAjhdK3QuRkFemBT8xohSg5spXyEuUFJ6ney3u54vPRCp?=
 =?us-ascii?Q?jRmWUWwP0wS/tpQVE3t0rWhqivii8iTaaz4d8dLs1A6LH86G9pHRT3rO291p?=
 =?us-ascii?Q?jJjzz7qGw+gG7L9Af3dHMJPewm5zhrpgWdZlvAlt0o0YcIJ80cUIzoFHryIW?=
 =?us-ascii?Q?j9PQLmwpZWsTm5yHtCICS7agQJSjlmcc29RpUyhMHwpTyuhquJppXeUxpk6U?=
 =?us-ascii?Q?KvBjkyTr36W+n8FcuGVUocsUDNA6sckta9KsKDRQjfrCgxLL740isct6h9S0?=
 =?us-ascii?Q?NXWNc8zdwigD+FNvmfvfTh8WsUOK16slYOkVtUtl4k8LeRD7Lbbe3toPbyHn?=
 =?us-ascii?Q?zCyxS+uPgWOTeLW6r/yMp7EUbGLSeUjyF+Uq719D7ySUlzJU14cI7BNMNvwD?=
 =?us-ascii?Q?9AtpEAUTY2V9/t44Nc2OPNDC6A3O3NXgCfardS2i14Mg3P+5Uj+8CfNf1gcX?=
 =?us-ascii?Q?mfTFagAFUrVT6YGUo24lqvM+OuIElcnkDI8AtpmHqPYcpet6i16j4PGff/Cu?=
 =?us-ascii?Q?pgwhi+T4C1ZQMkTEhUMQLqeBaK7s+fgUFCrScfz/VpYAr3wbu/x3kpQ9TC5r?=
 =?us-ascii?Q?PRyaVQitiTN71h4dk9Gc09zbjvoyw7yl2/rngYpsSMWKK6DsSkcPLMYghj3y?=
 =?us-ascii?Q?yMsOFppX+GAVEcM3jbhPHdr5ic7AB5/f+aAf3rTrs5+5LnRtUjgF6MkHNmKW?=
 =?us-ascii?Q?mjjrGmNR5SKvJWyzYgBnqbVvqqvv9zKaZ81MV8G1qWmfIIozxktkdBXIivbb?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d90340b-6b70-4d9d-00bf-08dc53ee87a4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:58:32.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnXX6PtrTld0JYyXM0uE9eeSUBLVeGbPp8668VZCR3WEUSDAvCSvDBTO4vmUz6fEDy9BgYp0GJTBAgC9KwRlrLrWQWp8AOR1aTSfMTWxHSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4528

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


