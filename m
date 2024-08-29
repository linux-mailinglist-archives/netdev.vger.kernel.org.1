Return-Path: <netdev+bounces-123141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7864963CC0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB34F1C21AB2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FC158A08;
	Thu, 29 Aug 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QLOhxBiB"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F24C70;
	Thu, 29 Aug 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916359; cv=fail; b=L0olg8MEO3MdA9z8WCax4g/fa9dAxPjC0oX9DWzZDvhNmZsX8LHtVJnwwm+ItSNiMUKgAiAS1SeoIlGBim8ScMRW8dkOnOF9wqcmeT1FqwdTacOfuP8K+w+hwwAnliNGSMwfE5rVYfnx3l7Pv9ePa1/AuLsrQHXEM2SozWQvOd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916359; c=relaxed/simple;
	bh=fcJESnZKBeJu9wzNki99UqwCZ/s792qmEOWIa5/b7VA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iCFNmnBZRyF9GdBNR7zjgP0o5wzFd35X5dU/wznlin/UB1rRQQiR6xm8r7NG8Ot3KuiJH4y6yt/tD5AVsXOykWVpYgmCnHyYZNAvjVXxl3pahumbHtjs3YGSVAyfEWwqolBcK5MbbI0vZ5zL/2S9gRyBTnHrmSR0RBL1SUhqLWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QLOhxBiB; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgY7Kki3iyB6hmZV9Mv6WiV8P4XZfg8ZAkOEYqXl3QqNSJ3nAEKDVRj45GTKCCkrCMuNmeW6mtb4uS6iRpZ5FduyZ2/wmTY8a802eAQm4tWWX7GgH+FeTOgYbHXjNO8x1rwwPfkZsn1uy9yOqaCPyncWyCZstTRjjH9gCyOrKF+K5CZJPjZ8xrnhqS5QUCv8c8+EUpIsDfSG8ZZ5z2w8np3QqoimXI1h7aPAhCIy3UQ0+zchmKy+Av/yyZKzLqIcjwk+QpQ4HENzKeIIhdbR7s/2fL1IDIgaURmq+UlIpuvqZu1/RDQPbm2+/Kg/GvFIE5zCwSVcXNJgKG8ORg38/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ytZC5trjd8Tn8TusQJ1myL2QHSIb1CHvHat/IKGNkA=;
 b=bTLRUPXYEDksyMY2t4EsXN9Ma4abI6qKeZYgvMdG1jU9uYIwR5MLKwaZ14wVz8d89xftZJh5+9VWUR51MmPRFdtxeQ3jGCEB1/TRyJVKcl/2oV7LxFxsqL+thDow+GxINzOKslrEXQ+4QR4xxSzPM4f0+rIOKpo7DjZFkI8hOTp95tMQYqEoRTAJPUN72Ufl0Lc5e5TMKptG3xbrL2comwDnG01QaXqH66gOEZPp0d+iYugps+9Du4us25JpFZlwG1FmSeMyWuqqAiLIlqYP+2kC1SzQEfswxnJ8PPwtsXfX+oW6ugCBQ7IPGScOjJkll46Q+pGAmyfDqel84kwmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ytZC5trjd8Tn8TusQJ1myL2QHSIb1CHvHat/IKGNkA=;
 b=QLOhxBiBuSxyZGoS68+6SGjFG9pcFizXkGxPcjUCiTVBsm21YrGeC9WmRYmImWGtm69vTA6BYXyamryq2gQ2AdlMAQAwFzQ4zMFDIzqY+7nujDOSGc9YJApCAM5XWecSWEc9JQx/O3A+Qld8WJih6KuQm7+a54FR5HQB5aHcu4IyDdIU5IVEXFpiQ1qcv6AvtIWjNw7+gdhQGcXvnMvzLUaM7MxKe2lfg1hulVkdJqt+gvkLRyLRUau5Yad5Y0r/TF/IaHQUQjXs0LH4rFgPUyTjo1F8KIZ6YvY7csQyNLeaQsuAS0HE8TcQTF6mVJLpeon/bFCpkcpzyYgfWAea2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB6168.apcprd06.prod.outlook.com (2603:1096:400:335::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Thu, 29 Aug
 2024 07:25:52 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:25:52 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: louis.peens@corigine.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: kuba@kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1 net-next] nfp: Convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 15:25:38 +0800
Message-Id: <20240829072538.33195-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6868654d-f279-4382-8a90-08dcc7fbd050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N96E0uFGuDNc6w6tlpKS2uh3IzofGN+BQuI6RwOEpFAqPt+iwHLjeCmafKfZ?=
 =?us-ascii?Q?PAatTxyjrE/w/SsuxXQggKtp6mN0qDDJqz/HP8/23g/yKT1o9vJpaI/IOHcs?=
 =?us-ascii?Q?0z9Kk+dFWFE3xpVHaOBBpwXJwK5tehrwP9YK1OWuZwx3eigsDVPJhqAsYXIC?=
 =?us-ascii?Q?nDJUUC7azGqHBRlgY6QlyxApfWq5JaNc8oHHGul48doBDBU1mmjl9WYWI80G?=
 =?us-ascii?Q?ZhWceiwSyF2RsHdcrQoAZy+0hRis5Y0U/3mpq0BJ0KtjfVAI6V8mCqicrJZ6?=
 =?us-ascii?Q?7xXqf1hLfSPsrBL8sEIOdbygW5gcMnPNADQURQdzHckw4ztfr8ivXPG61QMu?=
 =?us-ascii?Q?JG3TLPNWy8t/+6svYAFrvki5pCyjq746ltXAnwanuklpMd4E7aD/bbpkkSBk?=
 =?us-ascii?Q?WaD2jntpQq4heLlSJYPOnmIkKNkZA7txuqKmeZoThR9bmh4g8LrwMDuw0fH9?=
 =?us-ascii?Q?h+nCYZFkaZuIQtt9KdIFqT83w3+0SkG9jAkmlnwqlpejG+M49SjGBni2622D?=
 =?us-ascii?Q?8iXuY62sj5Yeo/e2LwvJ2S2Sryc+749yzXvw/m8PAShp9JRtKRbqLgJop2bR?=
 =?us-ascii?Q?rWrpaT7Erb8YlvwhFi/8qtMtcr0L6Ks80rBbvrgQRV4oPkTe2dmTWKyIEZl6?=
 =?us-ascii?Q?UHlx12XxS0z5w6SOp5ueqxEyrEWHZQxsxzbdoEYnJJk9eGMAcaFyV7o4plJ7?=
 =?us-ascii?Q?G2mKZr1/mElg1DAMP7Vfbav3h9I5apg4Xmtpa45Q4R2SMsjE/D9+PmZXeUBU?=
 =?us-ascii?Q?t22yDnLHKwY9amwMsXv2sEBMCEmsKY8gFJlqgAqoOl6bMpDRi7jS1T73Huvw?=
 =?us-ascii?Q?el1ucpwzO8ksoamw+Fx/d08iSF100T47o/Jsez/MlrFeEGAleGMdRu+AVY7I?=
 =?us-ascii?Q?pnxa9G6HBn+e90yKesjtX8lLOEKTT1dn3jjLHe6f8lpEGbvtdPPqslyFrYAM?=
 =?us-ascii?Q?rFM2l4g8aQx6CwZWKaDYjko4uZPAJu9GnomQicU//EjFVyDnkQpHyUqbOzyV?=
 =?us-ascii?Q?SBk29IZ+GN49luw5bFzQUR+ZhW6cGJG3nSH4aO/Im0ApfKnpQmz6DRi6G2r2?=
 =?us-ascii?Q?Udf+29LkU1Byd97AAgp+fpuLw3vrW6+WTwUIGqulsDHmg5JZ/pg/1SIQk6kI?=
 =?us-ascii?Q?9/cz/F1tgOGEZKs77OzZX9liYfSP/rTg8xKO+ZzPZkVTa4btWdKClH4iCfG6?=
 =?us-ascii?Q?PVvHyGfVEFrpHBvafrmi94VFU9/xgJfkmC50SWiuStnuJLL/DVLx7xLMBq7O?=
 =?us-ascii?Q?+tyHBEx6ygL+nwd4V2EAZm0O+BChGpdvcmlZPk/+0qlWGnRxzEKtgC/Vf4Od?=
 =?us-ascii?Q?utRKx0Tno92tCbQlD82tJgWM09z6/DE7J/0QuSxt4cXjHfFwQspk+FmZpD/u?=
 =?us-ascii?Q?ZZaz+lrsWN7kpzPG6KjArl4/+Za/hEjxh80m50lZbY4hRQuLPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JK9VyeHQelgvLnLG96bi36ewzO2iKxo+K/3EI1N4TMUm7fQYZGBf8D2idD3u?=
 =?us-ascii?Q?xX3pUeJtUtnucg43stoPnuCZEHEpxdVx6fXQgzkUmZheV5M+LyAEo9X6Nt8s?=
 =?us-ascii?Q?335u6jZZE7XifX2sqS64nDLTQliOeVYJhtEDlwz/2E4kziNS7jAN5LZWvum+?=
 =?us-ascii?Q?A5gjKjScw+0HvowaafVCBl25rmlVTNiBxZ/2joYC1YIs4KXmeua8dOo8WDPP?=
 =?us-ascii?Q?gbrKXnSjzT0ey5in6tSfRLVIRz+dtwWvLos6qLzQD0bQIsJWrKv91Cjqj8iN?=
 =?us-ascii?Q?p5AsdpPXc9xe90JDevQEcVneBU3qv9pNL4LZwimLbBXVgCDMSsHfuEx72+DJ?=
 =?us-ascii?Q?S9hcB+cYWfHo3GLUtsZoOUcc4pf4nknXU3U3mfxJNE8NQDdDCbfM9Nekz3og?=
 =?us-ascii?Q?lqOk6ziJltzfxa6U5Xl4kGvCiP911XBp4T2UQqdY+/NQ5cjxd3wJ57jPiGJ7?=
 =?us-ascii?Q?+cu/vdDAYD3VBGXDLb2xSRR+N8AmD6k5nAsYTPdysZkFWD4dwmA9ImnLhQTd?=
 =?us-ascii?Q?ir9GzLZO1A2ElQQVgJwwAqYExPH/oe84X/Ipsr351A/LhpfImTkSuwdPi6EJ?=
 =?us-ascii?Q?gKfk2zS3sjnYY8VgQ7KK6dd/jQnOLAMNxFs+vgDfnmZNPZ3BldLrnCpWqLU7?=
 =?us-ascii?Q?vFrSXLIfg1waSNdNXLfqV++gYEfzQMeaB5wvj81V8nq/YU6BKiBwDrhH1ClM?=
 =?us-ascii?Q?CE7BqPkJJCT7RvAQnlCMdOb2JVnjN8BAH6cO0MdDwo/K3EGQyk8af/gH4a2g?=
 =?us-ascii?Q?lLWLX8iLel4j38Te/WpNNTAZVkacUOGjMauWzg73jgavL6DtSkb+PMsvEjN8?=
 =?us-ascii?Q?9CChJS1BxD+jUcVRQeFXXzUaXezZwQy+bUQNcPq9rxWpC7sEFkkpD5koMD6H?=
 =?us-ascii?Q?As/N/FYc//zq9u0qRgXLBNdCI3WFx4h3tbjAh0bElXSW3kgP0BDIeFGBZUB6?=
 =?us-ascii?Q?pb3pezOc01cWsyDRmdUwG46pqTWe8KxNSns4yWvGQsvJjt0HzFSK/DRViWdv?=
 =?us-ascii?Q?HmToAFHU3ngpVYvPrPSoNLYlxsEupSqfAesvrUlmPUO4SSYZ6sT75dhudzp4?=
 =?us-ascii?Q?wy+CX2lyQnfUPAlQr6ZVPRRYs3kMnhTdS5ZUGf0CJojG1dHK7zju4RhP8vvJ?=
 =?us-ascii?Q?N8ztwC8IA/wKCCa5zJW+I3TtFgZujyITuddNcdj9xDeo1dtM8CVRtTjiNf/9?=
 =?us-ascii?Q?lfNeZIs8tN6I9IubdkvNTHVPI1Ye71XXsMxr4Ny2cHhjRWTnh4saiwj/wZIR?=
 =?us-ascii?Q?K05nB3ehIla1E1Dvae1fw82asae74jNUWfBTZaQ9ng1dftER2+isovJ4RJx9?=
 =?us-ascii?Q?UgdJ825jtdXnKroaiP81+AyelsjMsJ1btneWU7SUwSWNJxLYZr7RdfbAB4Xa?=
 =?us-ascii?Q?uEMxXXl0d4QJoAEjjo9T3+Au9mxlayLAPAc6A8mAhUM9MzNmQ0JoTCruaFPD?=
 =?us-ascii?Q?uJbI4UrrMMYHhdyy31Vc6Yyb5h3B5GwRCDElIm/iu/ehKpTqUMjT7Vr29mbR?=
 =?us-ascii?Q?IwC6uXxHMhPzaPxynw+pf+0n/+Bp0uCbeNkwn1PphnYEuq/SK5TKgWdFQEm5?=
 =?us-ascii?Q?A+QAyKjWUSN2BU2/bX1TOiRkyhmcO2oeaR9vr/rk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6868654d-f279-4382-8a90-08dcc7fbd050
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:25:52.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlGe1vmHNIlJOXUtpOfM7Mg48Ef2PbwCz4krK55wNfvWRKKfQxCNG7e7kMKdqV5MSFD7h3+GQRjBwnsW49/D+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6168

Use ERR_CAST() as it is designed for casting an error pointer to 
another type.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index 7136bc48530b..df0234a338a8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -278,7 +278,7 @@ struct nfp_nsp *nfp_nsp_open(struct nfp_cpp *cpp)
 
 	res = nfp_resource_acquire(cpp, NFP_RESOURCE_NSP);
 	if (IS_ERR(res))
-		return (void *)res;
+		return ERR_CAST(res);
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state) {
-- 
2.17.1


