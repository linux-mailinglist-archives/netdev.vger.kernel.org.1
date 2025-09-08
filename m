Return-Path: <netdev+bounces-220873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FCB49508
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04727AC1B0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C833101B1;
	Mon,  8 Sep 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nXTm0vRp"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F273101AD;
	Mon,  8 Sep 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348335; cv=fail; b=qcbesxyzkJg6jY8xI7684si8fATzg2kAicUQwUB8AiUkx8jJ4TPRwGfLccloCC5OOZd/UU+DxjJjpyN5TcfGZKq63idLxwALn7Bw0OvnINUzK7qOjTcwwizKHSeM4zfZ8/FU8Dv3B/9YACHpm6AD7R79XS99DKfyE5Ufm9m2duY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348335; c=relaxed/simple;
	bh=bpAnUS1XiM9FZ/+oeLg2ZXbWydzk5SCfebAhHFMkL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsFsP8WsgXv3013Li6gLKeZQARcDMSivhYRPTz4BOoFMUcLB0wBKxC0tYQ3eM6hg/8DW8AR8rfWs7T8q6vx7i8an2WRhf6h8B93HXUuKM3PGU9vYoEzbVoZs8fJul75T+xGyGTBKrxi4u9cSkZEzhiC9Q9KoEW617ixv8DPwJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nXTm0vRp; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0hA4F7M5xDV+7RB1LAUW6TofudZBsCodYf3/+sSO6iL/RHIi0uvSdXxhw4K322ndycPEAorhRb+sxdznYQSVUIHPrHjxZHZpxoyH/D4xHry3OJzDXEGBmN1NhFgEhdqwxYvjwFaKoqeBKgfysbSMWy3bd0xGQpABdA15J4QqBZzpl5XsYjEAtmKoM3xOfp4xkeegOUBVoaYmK+JVNY7dCNnq3laHr7qk9+ryjMhbTJetaCY7jD2QIXG9kk1mOa0JtDLc/6phLloWMH/pWYlpqs5a24QIVjQTA0p69V4QR7WetFJnt6cfvdD1VBCOLDHniqz00z8wBRYrJxAqIyeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3mFz95tVnz9StYAhVP1gBr/02fqeK67j6AKX3bc9OY=;
 b=IOC1hEpMLtCAdriQm6+Z6NFczkcCdcm2FP+DBW0o33D+QBcXuSLXCOM4zBgIcXvCeDe8gHyAPBK7Q2tWnvzthhaeBX3UeSpGLXwSLvvYmKsBwUcdUanr2+5kGgugtnRx/sjjQYNkQEDYtDhX7wGJ9+7KehmGiwG2W+WsN+uJZKnXv0aQmf7qyk5RYnErsf0zmFZBIvBACU6uEGaQBdepAHxLdi+fmjcuCWylfe8k573nCge0E/ExYdRpD9uG9siFmG4HxzmvLW/PgtrurC0aeQBZBV9cOQdS+m+zlP7TZRMBzOTEtwUYju6LvtFiz96Llvprq5NNuXTFop5PDfMiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3mFz95tVnz9StYAhVP1gBr/02fqeK67j6AKX3bc9OY=;
 b=nXTm0vRpzw+mI7+nzMy9uiwtvsFkGxL8V3v1CgUSmkkJ+Xs5LuB+dbr5WCz0duOclnmQyTKYwUu11Wd4/cErod796Hyyk5vEVdGKMdmlMopXV46I6pa0uaLuQCIPPeNS8t4RmAVZCrmD/rnxLSjgQyl6dc1d0H6O90twI/xwGG0zzNpY2SirOa1lnqaqVmoyeQPRtIBD2yHBB1a8KWb5eEgqCOaAsYtYz/zo4DiInZn1RgEB8c0zFgWBAdb+ANgKZVe3/l40fpnQSYcr92t3lMDQ9v1iJiM1mWKDgOj8wsxyCgC+ExHPNW/UI1sd9rAciOvSTonBmEfTfVovgyxsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:49 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:48 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v6 net-next 3/6] net: fec: update MAX_FL based on the current MTU
Date: Mon,  8 Sep 2025 11:17:52 -0500
Message-ID: <20250908161755.608704-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 860fffbb-33ba-427e-2e92-08ddeef36428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KGiT6sghUVN+5rW0kFkEr9TcUCjJNIsuNtCkQY8iFu50zu61NCSrs9UmiXw3?=
 =?us-ascii?Q?QHMo+xioFNunVvhQJ0Kcx9UH1uOGg2it+UttbvEWilLAFWVaLGaYf+CpsK/M?=
 =?us-ascii?Q?Ao0HkMmzDHLHHRsrDFOL04Yvp5sEqqJZR5h4uuSMJgz9oBq/vl5qo6+9x7w1?=
 =?us-ascii?Q?fdZJm3+DKvgLl80g8/C4Jy1K7jMcUBF+NBLKbtIGJsrlferZvfYCxPuZhjQ1?=
 =?us-ascii?Q?8JI6dC+VokgKOO4yBCtXPuNjYsXmTUTV6senx9DwiuEu8axv0VaFwOMuvvEy?=
 =?us-ascii?Q?L3p/GgHTg76j/8n2j8x+6iVHJi9mJswEeuGQaMfdLlw5PJk13pZ2LA/K0fJe?=
 =?us-ascii?Q?lZGDy2X0tzhhXB7fbxw4VKf5xXEZl7XenQgQ1fLulFstnvAlD718uwYytgFI?=
 =?us-ascii?Q?cJr8GReVgufi9FCzBbq9uwmvTM7JjHqjkohSWd79Q+P0lobynBkg/E+TvUIl?=
 =?us-ascii?Q?+z8RSCBtc1xhftztmjOMqhA4pqKd/ix6NWFezWS7e8qe7vq3z6IpEdqVXNsC?=
 =?us-ascii?Q?BdjSDJtMuR3I5GDDRAAmY0l7q/UM8qmxQl9D9NcWN6U3nsv96v6Uua1p/Va3?=
 =?us-ascii?Q?LCz23c+nsTNsxiChhIiUpQVaTUZsz3c1dDtiG3Stmo3ckK/hIH07F2RJlsxn?=
 =?us-ascii?Q?Z3vvqBjDKevk5IUDZu12Sc8GMb2viIP0hsH4/ytuqu4sK9gxLP6Dy71n4ypI?=
 =?us-ascii?Q?8s2jtJpVtY9MWdbBv+wYFNlK5g3oC4yh4VB8vZf8dc150bW/n414tC1kk4Md?=
 =?us-ascii?Q?g8v+TP5GvrKdDp8bW4Ri6fCX7Ii/5lDRZ3d/ZA6F8Edkm5DHUD/2PmF3UDlN?=
 =?us-ascii?Q?yWcXsTKtFzESULntF9mcmCtbAPZF+4e/pIgV8IINeb9AuN/6OH4dF3sikAnI?=
 =?us-ascii?Q?I+pKteFCFQ6ncRGsXHM92BAva0idzzqsZl+dl7ThBEVhuiGH3E4XKvdpa1k3?=
 =?us-ascii?Q?cxUn0wxlyZ5i2rm9SnbXboz7RSnJFvEnm66pktQAaaRTWEuCdGAaK3Yq/XIy?=
 =?us-ascii?Q?2Emahmrcp6ehq27z2M44k5dpv4yUwoZxyRhma8BCLAPwKcIndP4chxNf7ct+?=
 =?us-ascii?Q?fx2RAYk/+WKlr4QOFoTb2Mtf8j8lk2sZZAqWhnAHKqJw8YPhIhDzB5iDPhpz?=
 =?us-ascii?Q?Ah9WHsFzyRG8fKysMX2Pm5oLytp527b3+vqcyvC+DwAPS+9Joua6mZc2WFQ2?=
 =?us-ascii?Q?IyeEzML8g2gte72A2QFOPhIC7gi2QX63Dszt62z22UC7UqQXZAL3J0RUY1GD?=
 =?us-ascii?Q?ZPO7LLnPeSkjBA6e9fUGoDw79m22uigJuwHPVitIDZLxSY1o6qGvI1HyIJpH?=
 =?us-ascii?Q?iwacEP1BMzTNyYuvHGUYE7YtwUMOb6EHOxxMNg20TH2EexSyfWTclw4O8nzW?=
 =?us-ascii?Q?fgFikn/jZmEXcptDqCs7iFjPWg4t6cUmhO8/M4j8eIgN1RriOXUMdVE867mb?=
 =?us-ascii?Q?7zvYh1D/STik5tHfftxr9+YFgsQ+n6cvtU5ylKoC+8a2imDNT71U+/UZfW3x?=
 =?us-ascii?Q?Ts8XCA59ed9MUwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEuCVSw014AwqLd7nLmo/9pMhWF7CHy236m2K3aXwvqZv3vTcY6kBcPXaa9U?=
 =?us-ascii?Q?YuxohUXLUZ8ypy4YmYp/CirwtGrKv+QqmQy3zlr9N28AKp2UPZtUXUYIQ8tl?=
 =?us-ascii?Q?Y7nPUx4sKa207PjPYfX134eICVgHMMJX+plcYZOpVdfFk7OXI8k7B7rowWGy?=
 =?us-ascii?Q?pC0VuHzLu1WgXGKLJmVUatjuiELwvoFA6yCq3/l0JynMXzISHLE0WL4vvJP7?=
 =?us-ascii?Q?QxaQqgfIMkSIK5YxTvUbsUa6D+4fqEM+MLTj1IEU7vuAnuuNluwWdOq+dTg0?=
 =?us-ascii?Q?TRgWOkbwcOuS40CXNtrGj0QXtQgW2mo+5k3fyUcs94K46aUbBHIKCdEMu2ua?=
 =?us-ascii?Q?N1cxydrw3oiymY1fDO3bhZH4OLLmPgXUILaEW22+Cdr21BNpLyigziPFv3ix?=
 =?us-ascii?Q?ldJUGtjVWKmx27E5NV2A3ll0iytdeFF+jFqAFxsfEgks+HNaLqYLLcGVzcIg?=
 =?us-ascii?Q?Rn0LNzSg9k/9yd9gt8/MepmnUX0ujdkhNvL29eJkpAeFOwECzMtLehIG6pUU?=
 =?us-ascii?Q?+CJOyIlAglwu9i8UpHjEG+4SBYPPaFdm7c/ZhH94qaNpXnzHY2mc95ktThSu?=
 =?us-ascii?Q?5fTkE4dYGOiuR8KlfOdL0/Wh8S+01g5oDniPpJwOLI5U2k56jVmQ+foWKL7u?=
 =?us-ascii?Q?EROz3sV+pubv2IKrm53LCT8Ss5mfFuHXf4ipleky9vi8KcmRbzLVtEobhJF5?=
 =?us-ascii?Q?G1UMJLPETparxA1hW9AxLnYWayNHRYlSfAg1UhkVIuOyLHvnYLpxIv4aHGKw?=
 =?us-ascii?Q?s+NnTTn0QOjeVexyA7VjlbcHsE7m61Gj0GGv/aVQUkwVD61ZlXYULuoMSHmt?=
 =?us-ascii?Q?2V0K5oPI+WKl89AbjHAN26B4dNuhtG5EVckrHn673+SdJFs99T8E2+XCANCg?=
 =?us-ascii?Q?+RC9cEYOjGwPfegDnGG7PNaNBmdM3GYGdKzO2qT1tZ0DfepqEspSCYPrryZG?=
 =?us-ascii?Q?gNqsHZ2XaS25kPsFzlPu+c8tEsnH7R2byqewz0ufn5wpYFcycZEpB/YHFvNO?=
 =?us-ascii?Q?5byvDzOf+KmO21bRfhT1uqlybVkRVoeqfAooTu5AWsW6mWBFtoOKbDqWkyUI?=
 =?us-ascii?Q?Slg0QSKKfV+bUhyKXrkvogOmCnczuiB4U9Ayl0dFP6+QKkE0yhcaLJQJDtlO?=
 =?us-ascii?Q?h9Tv0kpuQbOHSFjtrVn8QbYc3WaqVeOGrvEHA28C5ODOddSVZ9+5SgTlvPQL?=
 =?us-ascii?Q?juKlzbD3mWyOYY8niJmuXb5hfkuSx9qxJz1CdDnwCUr+oM8UpuRbglMN9Dj/?=
 =?us-ascii?Q?hiMUGj6AOTykWmvEh12PosMq3sTfyeGX/JPY5IJQutFPNKNUZBzQ/IhNp/Ge?=
 =?us-ascii?Q?KSUJlwPIUracJLGbsauM5LiIjmbUJHthCJbXkPzkqpu+7SeS8rR7ufE8iHFf?=
 =?us-ascii?Q?Afs0HBEZHIUewoJVO5mLlMl4j0uP/39975EN9iLFYhbSQY2BuVug5CQbOHb/?=
 =?us-ascii?Q?g/HwqibUOfxrirldC5cud/FHlglabFwoI7CAIOj89mVhJV7qY2D3ZIB3mZEz?=
 =?us-ascii?Q?+tYWHwOKv11KP3CJLugZuqS0U3kGJXfOQLnp6kuN8v/kN6KbIyYPvgJCaacE?=
 =?us-ascii?Q?5dvz6I59j0G+W2x/KiACTjZgTkhA1RSwDcL0glOl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860fffbb-33ba-427e-2e92-08ddeef36428
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:48.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G13vARdepiSvF+9gRT1LU/nFFZN9yEavPyfW94UKY6vUN8EzSzUDVxPWXeTeW1kVxv77RjJcKtrXJl6U+RitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Configure the MAX_FL (Maximum Frame Length) register according to the
current MTU value, which ensures that packets exceeding the configured MTU
trigger an RX error.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 642e19187128..5b71c4cf86bc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1147,9 +1147,8 @@ fec_restart(struct net_device *ndev)
 	u32 ecntl = FEC_ECR_ETHEREN;
 
 #ifdef OPT_ARCH_HAS_MAX_FL
-	rcntl |= fep->max_buf_size << 16;
+	rcntl |= (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16;
 #endif
-
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
-- 
2.43.0


