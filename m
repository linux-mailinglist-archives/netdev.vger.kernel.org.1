Return-Path: <netdev+bounces-123538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5B96545C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F64B22A81
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA441D1313;
	Fri, 30 Aug 2024 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OcRgIp+z"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86436290F;
	Fri, 30 Aug 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979909; cv=fail; b=h5MxffZgrM25+c/Bhzd+zHXqMF4Q2mSRXTDjaLy2u0l0wMSn5bD4RqNCUa7L8i8Q4HRiUgGdjaDtsmbPNR6lkDx5bH5LtWjKDta03IP9zNV2vZ4rLICWCsYgXIS5dH0ViSYaQ8WKtUWBHL2Ed9yEF939jNvnva+tlxboxUqK1sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979909; c=relaxed/simple;
	bh=lgmZjne//nMvdsbpVYxxAgASyYUjDmSNcczp17Cv0yg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cQg2+g17zX2gDMzpIeELkzMkfSDJN62tmn6QW5sq3zZLqio0JaKwaQcWt7IC40ENl/wyn0p964baQc1YMyLik1C+j3F/0R8+gM3zuZi8M/VwXIlSIl82uma3VC9Y2jGFLxkXLEwhh7QW8zoOJAgDxyX73lItG+hR177Dj16kHVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OcRgIp+z; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf6kOgoSi+pnQydVsNY+3XALd2MvZ2jfeDy8FOafV+NdAiyajBAUfBKp/+IpqFf3WhPi3ro+ilPD3Np7PJlh23Zz3+TW9UtpopnvVdcJNOh8O1OuxNN7lr9CcGxxFZbLHR8mXAVR4kSt2SZnXMn9vKvRY3M3newOOcFIny5nSKcKFc0Cg6YdFEax3hzvzpq7zETMW5TNCcdUpwzPFfQ1OauFoUC56Af+JIpvk07BELrdKY58THUt+GwhzzJeyNl3t1QXyK70CKg28v0SoGpXVi/yG4Vjmf5APC2UZ8EStgJ1bszqKo++h+AMlaJyQPcKUXfGzA9xIbLHroCGwjVyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xogr3StArr1bHW4A6OTM+1Zk6XLLutcRGUvtLMbCEMc=;
 b=oqGrCkxqe0IBse1g9/tzzM/gMipteOqeeDFaThff5XgmxDurpIKdB6oDQpiV6sZAW6AGquFwlAleLKjlY23CCEU0M2x+UP6GiqsArrkuVUAE9Bj4Uk21ctHvu/V33b/eehvsac5D2rjx5o7Pr0yCWU/cLfCRnQ+VVpE6uLw9tQzaC9X+Zcq177PmQC7kuyl1gRsPuoLFoAH2B7195rOImHaKG+gtUixd0FLoARACWJTK2tldPdbQ4mgBrTEh++IO6Xg00U8v2LnPpJVVx43ZPSFgo7O1p5RtR+Un+uClbG8JNvL1/IdNSQquegGswX+CQa918WOQTq7dFXsgxXZhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xogr3StArr1bHW4A6OTM+1Zk6XLLutcRGUvtLMbCEMc=;
 b=OcRgIp+zaJPdSF90ZNMjpY4rc21NW8xuV2KIbxuvRbabjGyOh5jCDGT/EyJ0Gi4ANrUooGxUtMGCEF3SIsLLBzFIPzjaw0qOQ5KZy83/GLTUUmYgZUy20aZsUCwAaJ0rJ1P6k/0/41usndjO6H5Y0TsJ9gOU4A5qKAlEApRoHXTnmq4ugjLTwit6QiOPdrPSunjoUQcgaL14J+CrARgnvs1N6xOJ33Q/7Gn58imYo/bzrYjmA5dzFqbqdsIo3V6NneXWXLNCl27qWu2XVtnQzWitM32K1QvMbzK0ZuFZCEX9NN/FhG2LlmiTQ//Ew4MsBhTKlb3BcOfIo9uNn2IuOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6613.apcprd06.prod.outlook.com (2603:1096:101:169::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 01:05:01 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 01:05:00 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: marcin.s.wojtas@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH net-next v3] net: mvneta: Use min macro
Date: Fri, 30 Aug 2024 09:04:23 +0800
Message-Id: <20240830010423.3454810-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4986a7-7899-405e-bb2d-08dcc88fc5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSiP8YY5ujvc2wqHiCHv8ow22vy4LTcJRZQo9eAx79kWNrEF/g3ZLw7Fee1b?=
 =?us-ascii?Q?oioUEcH9axkyw9iayZJdW9HszU70wY4iVuxfCRKQnSst61PVbEwZ/cUnYnAh?=
 =?us-ascii?Q?NdiGSOmQv1eoPTxwityN4Ep74T9DZTEHsnZIIfStz63UkLx9CoAGE3JC6thl?=
 =?us-ascii?Q?1MtZ84yQ3IVq7iMCAyRWQfPJtCj3XHX0O5gEclnjooRaQKDCYLds+jb9qOTf?=
 =?us-ascii?Q?vVU+0YMOfJBZ11KwFdynwDiVVhqRRKzwWAlmdDclFhaFZxx/h6LR8aupw+u9?=
 =?us-ascii?Q?EBMIvjPQQSP7pCt9ROfMnU/HQnUXiHD2N6+/qMB5JOljCVI80Ljt3h/VX8sg?=
 =?us-ascii?Q?EhHjqsvHi91hAvTN+8f/ex16vjaR6684mkkYQ+Sbr6B/SAPouOAuFp+ly0LO?=
 =?us-ascii?Q?QEDB7BsFPi86qN2lGqxAfet+dub3TGX85DgwGEAgDyCzbEGiQJfozBNl+meh?=
 =?us-ascii?Q?QY8x5GHAHtVm0Xz0WOGwQAj+2UIpKC8yvZ1a5gi+JHKuResbNm4TWSKN584W?=
 =?us-ascii?Q?REHn/cQZvjFC/ELv/H79N08bWDsRLD83OTrh3JM+NEjAv8KOH5dpNzlr4BAL?=
 =?us-ascii?Q?BvLKyxp6lQM0MeDvdDohUxwNY/WlZOJW5JiJR+R3VHb+gaB/+WMVnTgXb4/t?=
 =?us-ascii?Q?bci8SQKTi0qVllXQJBwtgfoM+IgqdbFg50JyP8CPoq2KL6eYzEncVINqGzm6?=
 =?us-ascii?Q?7LXCDi1RDYuPNTFkB5eFukvosEuWi0RxdAESMXdlGFXWbt43dlCEB8rvzuNd?=
 =?us-ascii?Q?o3Gix4gz6P3UYqIzTPVpab3UD+3L6Jk6FVIaP1pr6D4OhU0SoiIQXA2RWk9G?=
 =?us-ascii?Q?ZAXbGOEUF9YHDut9678Uy6xVUvs814iaA7Mp55ybXPayUxBNL1xPndVm5Fu0?=
 =?us-ascii?Q?kUSd9PTi1qO6qhQyyBsS45BpwAwlCO2tBCMegK7GthDf1lDXCQVl72Dfrtys?=
 =?us-ascii?Q?Bj9IzBQvoJn6lY+8aMiMLcZ6YB1NhxsMIyxw7hIbLPX07FZDYoNYR2Sn3pud?=
 =?us-ascii?Q?8kZtBh70VpeINGuJpxEnuTqFAGm1TEar+rWFKBUyUZRlg/zGvSwHxrarva8U?=
 =?us-ascii?Q?sI1LjMQU4c3Lgrhmw6d56+9QbKvmeUJgvVbY0Dpn6vgd3dhFol08kkBuaz+u?=
 =?us-ascii?Q?Ul4lkNF7W1hk12V+xxw9yUJPkHeAgqmTapyl5x/4nkeNt4b9s3hQDOjqkcl5?=
 =?us-ascii?Q?q4ZixCz/7iMLA20gO6B6025c6AvKWwE1q/OsaMUVtaA3jxkuLkqB9Md1BIzh?=
 =?us-ascii?Q?CBhDCIg/lQtPam3qZUe/CrH+J0A3JXQJ7kCmV9U+WaAz/W9ai5GGBflZPgjh?=
 =?us-ascii?Q?6sR74XIj03uPw/H6cOe7pQH2PDW7sVMdYYtHGudvFkbpmOyZ3Y6dZlrtxhGG?=
 =?us-ascii?Q?xyRJD0H1vklEHdhCTeki0izeg2XJmjV/XRGSD7GqoTMPNC7FNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OO4YsUZUKFUwpkoHPXzV6hedU0A+/J6doxHZEClMK+8pAPNLjjOPBm/SKTTX?=
 =?us-ascii?Q?o522yuc2LQU4sULVinudeQJSGDtpJzW4RXq3SDUUqnon2Q+3NYBn57GUR8kk?=
 =?us-ascii?Q?t7sGt93nRWPVUhF9r+UnnND44e0zA27ITD6B7XYnjU2MdEe4QnLalBgj72JP?=
 =?us-ascii?Q?Lrte5vJyRr5/qCBuLo/+dc15vArsesu9bVxDXtfxhBaUyT984ZpHZVcpFTvT?=
 =?us-ascii?Q?nKebMFtT5KCixI2QpoOQ9vLwry4K2b4pqH0C34C9P6/3LbqGI96xBcJwcFOl?=
 =?us-ascii?Q?r7hiYIhMFyRhWBI6wtO3DHBP/sG4Ie4dk8lfQfU9MQnk2s6IAREnjU7Pzecs?=
 =?us-ascii?Q?T6vfD84/sEY9M10DAhH0H4dlmr4dREeBriZk/AQ8DoS6029a2ULqUPRHviH4?=
 =?us-ascii?Q?2W5lX3RGr2grVoVK7/J3KOmHO5dga2t2gSeObVN9Bg3LRVxaujybE7UyPYyk?=
 =?us-ascii?Q?xyg5xL1yB7xmfiuhT5D7o1y6vc8HWgLECQp3zP0uxkYkqf4+t84WlJbvAcWY?=
 =?us-ascii?Q?3ZXQPqYhAN8wZxnTNSs+IwkAvvbHIWe/9+ioHzXPFdwp6+/3u/UIVmC/IHPv?=
 =?us-ascii?Q?UfrnhoODKozcyrepY3IwFvcBv8+0WuA8m/xJkCw4XCzj4UJUZBfYbuL21yyj?=
 =?us-ascii?Q?pBoKGuLnEPmgJoXh0Sul3RTr1SLvO+Gg9cFp/OqGrF7eCFU0bP6pVviThbrh?=
 =?us-ascii?Q?XNA3Fdv/IExBSBBPreLhsihZ+tg81ompiTv/sqHezYgCuqsvWKCLbbYchfM9?=
 =?us-ascii?Q?ZGiXN20CdvCVolU39jQ3/A5yREQfjP0lrW3XIHJ0flrXh5LgfgznCqF0y+/R?=
 =?us-ascii?Q?fVxaUUzquFajhtGLTl7cygTJLpy4Tax61K/DuO+sfELDkjxy68aevW0xKzKv?=
 =?us-ascii?Q?ULyNmlT3mQFEzcIU2gHfCpw7DJaK+l9cHaNQZUgdM/x5wYb88B/9OvJAB2kE?=
 =?us-ascii?Q?Vf38e1lMoAvVp9gGm12BAppQosTdP/SCUCk5FvQ1uXfFnom2xFjSceQS+YfM?=
 =?us-ascii?Q?SBwAg12seYgY4L+B7CK1/K9C5Tivl5jipH77giFBfALL9t+3gfv+YehGwdrt?=
 =?us-ascii?Q?etWfVJIxR09PegDLtsPYurZWX/PXjk9DnbYO2zNFKVLoaMIQGl5YK81aPPEw?=
 =?us-ascii?Q?QghdAO9xqywjCVaw0+1A6v1xM4sFoku3UxY9dZQr7VZQCCD+fZB3vJdw/WsJ?=
 =?us-ascii?Q?lPVHzYv/AGPtSWuXb5c0d5uJBFWnIrW2xH/jYvcizYy8juDtiQJaTu1nUpyC?=
 =?us-ascii?Q?zYPmvmCm+F7yeXTSHnL4Q/X9XXLbJzAle12zj/AZ3WDJF2JCejdYMH7bDZnv?=
 =?us-ascii?Q?Pe3UyWmmG90Fifgis4EL9vPWgfvyq4fbiIA2B/5Le5oGppiqUsog3hC45cnH?=
 =?us-ascii?Q?nYNlq2RpMJknDgAaIZ4yEUxiZCiIAgvQLAVCry5RURctVy0FzSdFhq1b4f0n?=
 =?us-ascii?Q?WQijfYKSuGrSIGmXSGInbG5bUaT3tF1n9naOBnBIN+55hbj2WYnMKNK9eZp+?=
 =?us-ascii?Q?uqS31k2KSzcR+PO7YVUcg/8QuVutiVXTkx5pUnjUAuz1dWsnPVBc7P/efEV+?=
 =?us-ascii?Q?I9wxg2VTx0OjQlbDa+RlRC7DwMGCo9JN1P5zMGbC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4986a7-7899-405e-bb2d-08dcc88fc5e3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:05:00.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuSK/hOr2emtny/AwPe+Vq5oCj1dNzTiE74gKY4ziOeK+PiwjSpx0f1tXKdFVWH0YfvoIj+zODgslrfLW7pcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6613

Using the real macro is usually more intuitive and readable,
When the original file is guaranteed to contain the minmax.h header file
and compile correctly.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v3:
- Rewrite the subject.

 drivers/net/ethernet/marvell/mvneta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d72b2d5f96db..08d277165f40 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
 
 	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
 		return -EINVAL;
-	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
-		ring->rx_pending : MVNETA_MAX_RXD;
+	pp->rx_ring_size = umin(ring->rx_pending, MVNETA_MAX_RXD);
 
 	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
 				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
-- 
2.34.1


