Return-Path: <netdev+bounces-75577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEF86A949
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645D91C259D4
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C52560C;
	Wed, 28 Feb 2024 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="QhNeyaz/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E1250EC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106753; cv=fail; b=rpBmcsKqd/NZHEzRQ4H66i54ezCPkXMSSRmA8t91+sg9E1ZRhxKbG4xYqnUfqQhF4arMG18jqx/Pl8u0NfK5CdYh/HSLEBkvzLhmxmw7LRN8dvr20IYVjEn9y3bZAv0kH1lhpidWG0Eu9mHzn+Tp9Z8BxbYT8ajSIh5GXwFWIdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106753; c=relaxed/simple;
	bh=kbanQAj+d7+dWGuBr4D3Pe2ZpLShTop/ejE7UP4a7sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3gX7/NPPYp62N3Sz9akWiMuSWAwDseiFL1EVZtk1YVGBAoCW4zcmJ6uiMtlanP8B7P4KBYkNYnP5gYOlAasnVivpXRlNsu8zcgObfIcF4lCVlMkaEDNXIl2GZ97wM5JhtQddIVSaAWuzkTz4lqhT9jiNIpB6dBXpHMWtWUjdnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=QhNeyaz/; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAf81M+LIjvSQLa/JoS5FIAxGA6MgZTijKydLvZAGuq4jhuhuhpNCBS/ehPdOlIXntVLBhNpDExKSRAU/eVWrzRS6GDQ9AviccMVwW1Fiy6Zn1CL4QR01QvPJj9SLC8K3U7MFfQk2nqDbdk4rly91CDDdlaZn/5zzsrRdkijS5jjwnrWqty7+m3LM2n5b2+aAe9L/g5cxTyqc3kEEwXW7tbAPGTuVFDsnWoV3znT+4Y9GPFlnl3srEv9qqgAFjfe8coDL+7hGPjtU8gr7mKdmmhI/Wb7WCZT+TTlupPrhm41xUnZvU7QvvcE537mfxBm1Hv7oyBrYJhNo+lgvR3A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bsIvd6+kZnRPmJ/t0Ezcgh49dt+rJhanpCM3+woxQ4=;
 b=iZWZsmsrPm9P7a2tNWcI4dC6JNUWyfxV1MSIyz56pqctDXe2bj45f9dXWa5qvtH95ekI30/VVFSjPHGAClSxeSIkFUhPL/7b1VEr7hRLljJGcbE3ZMjKYQabeYQ2vTsgUN3iQcUuJwUr3SVtslaZd7Aejf1MpmKfG6Gk2TVnqOs/jsnbWY6eeoHhvbWaf4/qrtn1xjq7brbpf8qfKb4Jor23dLO8yiubdGKbL6vZWLkOnqrzQEfWI0t6dG+056MHfUUzcZ2r/aEGd9/ZbAmm0D05a67WPF4udZG37RthyuGjut8YMxm5H6x3qHMpHMbKtyKLMMgoVWCXJnz3zUq+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bsIvd6+kZnRPmJ/t0Ezcgh49dt+rJhanpCM3+woxQ4=;
 b=QhNeyaz/+SiWP7mjwX2QM4CuivJJK3t7g/rktFW891ikaB6ibc8O1OzPLCTSHYg1lKMCqGaFQgyIvTqh3TICkwi2mQSWczsJzmN69YMXeXwzjRTk9Zcapcxx5IbnSet5g0/Jhe4cGF/s0DFYbOPw8c/wLj1dNDF+Y5rBjTgP7YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BY1PR13MB6213.namprd13.prod.outlook.com (2603:10b6:a03:52f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 07:52:29 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:52:29 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 4/4] nfp: use new dim profiles for better latency
Date: Wed, 28 Feb 2024 09:51:40 +0200
Message-Id: <20240228075140.12085-5-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228075140.12085-1-louis.peens@corigine.com>
References: <20240228075140.12085-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BY1PR13MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f44875-00ae-4618-38d9-08dc38323621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oK46TaBaqXcobr+GqrB5FBBUPosaOXhp5zNQyDMRdByrimvE5rSQkHIzHK0OyQx84PCBRl7q+N+GcX4IL+H6qqD88ZJ7h5K+2POGZBRrKUiXkycWAudy8FnEICINGAK3CQpCp/15VPQjIYsM+1Z4vIrE9dlarE2zzNHAntPEcbL59LhQIP3N1uE2YkXCxLBWpr5GZpy+0QZGrUjy1qrRAWKhTHIBlvPUhftQtHxoErc9FGCVL82nmrnNIAxEpJ6A3gMNUO2p1GSA2WW9BrjuzTekfzB5Ou7fVnr/lhL+mfTf+VLZi4tuDXWSwzwhde8s/pJTw5wYIwAkMjFkdmUdnUdkcQbeUK8SvYAyeJ1kLnUd7ZxHQ+hHAtxig/9p0uFxxJ4U8solxlHmbImNScXBnX3JzNjKooJqrP9If8RaMSABZ3/3X2taQB71e3ytQh/uq1s+TM7COQg1aPzmOZkatYpoaQqHzXuX7H3UlNkWAIpIHZcRqk5aEhvoS6wYzWnRRoEAfyvVrLyyk52aT0cYe8KvMkKdNm+MSRl2xj9LkVp+jcszn+RFZ21NcYqSwXM7ODMLI+VjUFZfINthSVWTFw1Yheu3BA41KE/zZtSVHoNlNJ/Nyj+MJPI/d84T5ErpSvNsG+VBnu0SNgL9jV5r9wKFKULESd1RTNMp3mJK1QuKNzLqwdp2GwCa0MB4XNes51IigbTj2wXkj/1B75rzIh1xvOBYM31HSRCXlyzENQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zi/igz4+QlGeuI1xGLxPIIWrzOPdLyF2yKWCdsvtfTdfkl1BTzEbZH6SqFxV?=
 =?us-ascii?Q?hVQwNKKOSIOuWqmj5GcFEmggHhrhWvcw8bICgwSun75ymsWS2mzz7jXFW45w?=
 =?us-ascii?Q?Lqd2Kx229PAJ3VRsWqdwK92LnguR120FOjChO5GFcMu+d9OWGXyyiA1wt99y?=
 =?us-ascii?Q?dyiSAUOIr6RDLbleeAhi7xhJjQRPI/+1GGYALyRGLpBP5n3SpaC2N94cqer5?=
 =?us-ascii?Q?fkuPIuO7KpdjaJi2YlUebB5GejeN1Yi1UcDEzLLICin6iFDL6Jiwm2U/m4tR?=
 =?us-ascii?Q?A7mkwiWF5PbV4RNZaGNAR+/gndpU7E0tYCsLMtYS8S5YcuP9AD2Ix6AOelRW?=
 =?us-ascii?Q?/y2djjs+BmIy5tsypWTwu7Cs4mxv5psTdMQkTaPaYjDHC9gvcz8d9LLZAmkS?=
 =?us-ascii?Q?fpwsxGFZT15aarXtZjzvswRu6ZTwnTFIn0x6nZDXiIGBGzvaNfbY7YH5DIkn?=
 =?us-ascii?Q?+Za7FvxlG343QpZMa87zyQxNwNQBrLLwVAM6RcSkvMAFBOQGUEbXDvUivTMh?=
 =?us-ascii?Q?RqaXp/Bg9nwZl1nqsAkXJjYfpK5K2DHWcL57zmpe54Z+io05U6hEXjWgJH7w?=
 =?us-ascii?Q?CkGBeX+hXVSXw+SWR2KbKkjxbdzsr7aLPlG2zcht95Y7ZjMZfca1Vj0o0uT2?=
 =?us-ascii?Q?d0tcPnT8Rr3SCbqPQggw6+wpJxxxL71mMAI20U+h7emkcc4nf6+fJci8ub2R?=
 =?us-ascii?Q?5dfuWFZOTBtryw3AJSbHOkxSVhxZiB69/Q4EkDoMFjr8ppb9e4gcjHQfplAO?=
 =?us-ascii?Q?MVa0tPjzYGA/3IxarYkMOz4ty2OTZFc6ZzlqMzGFF2TfEH+c7sP7ikaw52Qe?=
 =?us-ascii?Q?iuwC0JYUJ5tFX//xaR00fChA1WZOxKT25+P+rpvgW0CoAKTZUZ+xeIY5OvC5?=
 =?us-ascii?Q?bnOyIzjxrckM225556q2qwVFiNaqy9ah/wqKj3hfifVer6w4u9Gm/Cm9j/0q?=
 =?us-ascii?Q?zEKXWp4f9ruN0CC4/fmG0+EY/E2g1j4ovP84ZNUQvTDam/Tmz0URiBYkQU1I?=
 =?us-ascii?Q?MbVXp4MJUcl9dHy8kqcUXYvZNckg7oFnKdvBfQ0mic3VfiuE1d2jwvtC13Y2?=
 =?us-ascii?Q?6JLMn1naNkkQf4q2HdOjEWYEf3FlGy9KTtuosOsnfhvPn9LoQA8j12QL7eUJ?=
 =?us-ascii?Q?SLe8W2IfNywREGqTsimey8LEwb5bqjCruApo6T8CultL5GUN1HpB5MpCuF4z?=
 =?us-ascii?Q?cqhQixEq8Kfa08CNpi+UvLpfRbXY24Be+iMHXR0hFhaC89EY0VZekmh9ZDZJ?=
 =?us-ascii?Q?D5JK6i5oorNSDDWglDW7T+3XC1Ir/cbRwWXxDwYDN/I21XyZcHs9jD6y77CJ?=
 =?us-ascii?Q?fAyW1IQ5mcXIeLQwNHjoEh7c57I1VFW6gcYJ2RJ2xhkA/KQFpjTxue9UEg7Y?=
 =?us-ascii?Q?7fDc7yHk4gEcTJ807QOkBiWMIeUQ6i8NjupRf4vXAVofJzQU8mKPcbhD8M1D?=
 =?us-ascii?Q?DX+Qz64HDH3JXib+/DCnMof2VLmZ2f9VGwdf/Wj6Kyokypd1HqCAWfGzMf87?=
 =?us-ascii?Q?hxt0I3OrOOh4s3UJTZPnXwIfP0EqzeOQngqNln1ej1v6TGzakhjz0M4ZXXij?=
 =?us-ascii?Q?Z7F3LDMKigjf6Xy9MxIIS7RENDQVu5SU5TX+fxt0wEihFa5I4YJvCkJOXGU+?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f44875-00ae-4618-38d9-08dc38323621
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:52:29.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpcJjx3fEFQObD/BD+2WKl+AgMB99tK5Ke8ce2XMJnSGkTvHeh4tqCukUAcNb73Th0bEtk8OHUWnUmzipMYIKf7vTocp5d2P7XH17E4t93Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6213

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
index f28e769e6fda..064753b25b92 100644
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


