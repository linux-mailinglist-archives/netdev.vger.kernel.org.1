Return-Path: <netdev+bounces-122272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58696096C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461C22854A2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD61A08CA;
	Tue, 27 Aug 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bOTMiYIj"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3461A071C;
	Tue, 27 Aug 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759960; cv=fail; b=nHuRbNLZLFWJcp83Zv78GC0kK2nupbZG4mG3edGsTSvn3KY/ggBt2W4cZwKDjGJ0awTYib5vNLXpCLYZIFP/jwaRgY1fwb95aDgGFchBpYMasRJFGTEX7/nvdqpcGSF2780JBTfYqRFZ8UJjQ4ra97FObjknMP+auz5cNzXKlco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759960; c=relaxed/simple;
	bh=misQeNZaT8uucUkchxQEOu3g3qPoWKbUF9lzNnXInHI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OjouEA2/q4du4NFOsVHzOa3Vz05nK8zjxZG+tRMV9rIvpL6PAFPX/Q6cOKwPmFvrwYwQxJGoS8AbyaLJ6SHfm0EKmCXLM0nGfFm0vf7bIK7flTj472ssyWV3W1neyqinhG5B9gJdRO5rb/wPgboZjGIFXy/au1gLICfW4zSxkuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bOTMiYIj; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmIPh/wlcv/pHA6SSW9RrRoO1NJYcwt+Vr5T9RGmfbm6NCLaLY2lyk3foJV/6QuH0sGPL/3TzfUdqRkoWqm9CypeRyHIjPjq4RBJiJ5B9zPqVwY2N7LGmxCm1t0sxWw6CMjz6yhjM9qkrWKR/Wco2OGFWSyrtiqlWtI/6/nA0nCIPiqMbzbiRevkeO7kw7r0wxKUuYlmD6Y72OR3eyS0CRIs02BWNTzBnw5VK3QWnokozCLI3FAgw5cqTuHHNgiK13kTg54+3cYHIDtvd9sYmFNG9De+1Nee004hXnjRQm7jqJjfJHH0lxCv1E3yEPS4DX4pVKQmNPcCmth9jZe/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEXscr/gpOx0xRv3aKxTCv2UohyKw3LCq+HqJdFl5Hw=;
 b=mh6HUMLyzBJHxDWNgRs7yxwpnP7Rs34Y680pIXKbApbahP3QwlDjiekSOaVohFGPowBBZyD1b4brW8bEfooc2R7pHan7McOk4Ma7We1s6so6/QXVTzqrVDGjyM1n/Og4dx/T+t0mgjYOH507BAbgS1zZs+IeXhkMZwXNstsRoGqI9Fd8oGAxWXd2WMYMbsgosY8L11YWSiI2tKKYQNGvWu1yUsXoAXWGafHRJflxuzpb1TR4PCEU5kMUsi7lWeJFN3ZdHv7uQbDQNlwd1fPL8U9rjjLG6cGrtFNbZu26JBmUnd02wsU1vDO+sidLxxKnOIZftoyqtR/YLGKgqTXxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEXscr/gpOx0xRv3aKxTCv2UohyKw3LCq+HqJdFl5Hw=;
 b=bOTMiYIjSlx3mDxXd037VhxEWQr7qvjKc0ZXtxoIeJxsGbRt85sF/TdZTI+LgorBeiSmMfiStHXV+K4IteNdxhaqaspWrEqVUTCwq0FPrOSdqTCtw7Jt5kWFjc3al6ObBhd+u3QMM/hZZ3K8+hBf7d8ClNVuTCuUHqDDal2KEk+zs3WDFJtL9e8Rhaj21/eUBHbEOuxrQRjnjQ80Zy1Jd4L8fSvmaIWUueUu/iJnjB64oz0bF0r+nHmzxxn+uuMqab9cbQy3FeKXlBjtX5temqZLf1QL+eETm3eAjAI+rKMDQ8gvsEMJxQm08iMk7GVympYNhNoA365V4D+ovR316w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6929.apcprd06.prod.outlook.com (2603:1096:101:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:59:14 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:59:14 +0000
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
Subject: [PATCH v1] ethernet: marvell: Use min macro
Date: Tue, 27 Aug 2024 19:58:48 +0800
Message-Id: <20240827115848.3908369-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a8c9b7-a853-4c16-8e3c-08dcc68fab70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/lLY3bZhyK3uBmE89UFWM5A2iZGHlOtRvUM0WeNLmZiUEqI3tMPXVwohZQA?=
 =?us-ascii?Q?zC/YTIrC84XqxT7kz5DGI9OH8mZiEOD3WApN1JIVFBq41jD1GYmRt6okxmqz?=
 =?us-ascii?Q?QAp04lAURWFf7oGYU9arQcR3Y1/gXlSRf2B/b0OdOgoxwc7KyUQqFEi4OAOB?=
 =?us-ascii?Q?wVJaJHdbJEDZTR3mwTsERh72JaTWFawD8pv+OvYWjjGavnQz9XDk1WCXdK24?=
 =?us-ascii?Q?JYL3DDSBbzMyzQADLXlrp1LoMX3QxC76qwNyRCbxWwKHN9Of+7eE3TAZJv1a?=
 =?us-ascii?Q?6YHflU+X56idYVK4Ehx7Er26GzPxt/izyNNRbmaI093oqauHyvzuvRt0u/N0?=
 =?us-ascii?Q?1SI3l/DDR6ZnbsVGZO02Ftjx5NHhE+WWYPSUZtRFvYQ0lKDTc5ANwGGFGxAB?=
 =?us-ascii?Q?u/frgU01yKR/1Gun5YnWqYWIaLbpdb8chdjEcGy64YHzAFUVTginfvuMLSfi?=
 =?us-ascii?Q?JiKcLB7BeHnBaEhgO2nJC0GYq+y1SOFuWgBUqb9/7zhUkKHX2B5UqrdKl7mm?=
 =?us-ascii?Q?Nug2hNQdWV6RAY0n8ng1mQNNXcfTup7HjYn/iFhr7MkeIFJMZG3nW6CxUR2t?=
 =?us-ascii?Q?Chj1rES9fAsNdPSCooP+8QLqYMU7JIyud8ypo3OdtaCJU1peg7YQm+j4esXV?=
 =?us-ascii?Q?dj+OYIpbNcOwpf89ZmHrXoXX8X7nOslIfbasbF2qOB6W785zyCNKpKxZqVbp?=
 =?us-ascii?Q?JrQHMCi+1kXhzn7uysNIwpRS3nd36Z+oJzwSv7hvXTn59zrSkmtWUcJwQMHr?=
 =?us-ascii?Q?MjbNvj/0WXOd3stiIvYUXD57P488RmhYoCnZ+K7xW2xCnIPr83jF+epMyofH?=
 =?us-ascii?Q?NhQwBq+pPc4NZC3rSDLOfeh32vjScFQE1ZMJ7Alwb8UjYAQKaxX2ATIVInQv?=
 =?us-ascii?Q?DlHIMQuL+wf8Vvw07Iy7AYQnz1KsdQm0u81CpPmYlLSsxuiKmx9iZaD+QArX?=
 =?us-ascii?Q?rIQ0cbheKBnoCzDlQ34mNZV42LR0bzCFWXj0zsUx20/xenlpSPIC4xSYxqYC?=
 =?us-ascii?Q?8TFkIhP/8bbe5jZ4Os22qq7GLuNTFsi7/BNKcZkdpBmQIjiiXTBzxjIHBqCV?=
 =?us-ascii?Q?wwObN3u28BbqhYFR0inA6tNRKDi+J83itdsFiETndrj/luCi5XgZt+prhMCU?=
 =?us-ascii?Q?bWGSCUzVEvIHwUeKHgcFl7Lt9hOspP51Gi7ORe4CXIZl+jbzVKOx+Lbz0/+w?=
 =?us-ascii?Q?gHjxOvLHEX8fMZq5v1fA5gv3ET1J4Yey4t5y9dqWIJNKy6FquOB1tXMro4sf?=
 =?us-ascii?Q?ircuiQb3l1npFOFrobilztEg4uILO1HYji5L1hhSS71o38L+a8Fi44kFSkiI?=
 =?us-ascii?Q?bABfbWnyA563E35lHX1vjXEE5v+YdHmuY7qtSU8wOX8jb39XYld9rK0qfzbD?=
 =?us-ascii?Q?Gk1oGdEV2uwc8cMqdstpPDa2GegzorfbRIn5HGQQq0xWydec7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/eLdJOHVotJfr75FamRPwibT8DFvkGje0sEL+qxGuOvlPoeUcj+uadS3Qvo?=
 =?us-ascii?Q?01QNQKn8+gNYoqb7MGzcIf203koH9KZ0lKqodz36bs2yYpDMK4e0z9KFD6C4?=
 =?us-ascii?Q?GJntJJvL7FvTOAR9nQclrIJaznMVLYuoxQhvZXaqbqnP5RIvEnSMcN4QJFFX?=
 =?us-ascii?Q?qyHVi1QtDXdHpJSlpA+dg7q2p3nWdchakb2Sn6hPazrY9Sdi6zRtaSkYqGpq?=
 =?us-ascii?Q?pDPfel6cQe3CIOsBtC9jR+etsTzwudDPQw005UmrNejXIg7SXmY6/xl96D6O?=
 =?us-ascii?Q?TDrxOKta7+hBSHvvxg5doMY6oSJxCv4MXgPX1EXeYaBLxLCNgT3dy5/5OW+i?=
 =?us-ascii?Q?jwfynutv4tAlK47lgCkPl57/m3H4bYmZLpRvsZcibWci8Uz2mwKgrUr9Vl6T?=
 =?us-ascii?Q?DGmIVUQ2aHYgycCPAPgVw7DcQudALpEvN+P8mHJZALMuaIkywnM9w6ZX8zMD?=
 =?us-ascii?Q?pzFhewcUr/YY34AJmFISos2zen3a+Haz5IRNYcK+FzrR71hPMCceKnOFOMx7?=
 =?us-ascii?Q?Wa4Om9N/qwdTa7b44uH4TsHEcrkJiRua/cLAk8Gd7UguUai/N2rK1eu9jKOA?=
 =?us-ascii?Q?3xB1M+v/8vUS0yJV1wOD3RbhLPEAUFTtvdcNZvA0tUr3Gw4XNaed6uS4ADXO?=
 =?us-ascii?Q?lB8eXH/B8bcjHGlNT4WtYN2MtRRFvsOH7zG01NfWQyQhnMnDYPQiWOScA6aN?=
 =?us-ascii?Q?a9FM6z5B0RnLHiW3PAwD+voIE5H6rylIlF/prKjLzO4LM8+bSbvSykgFtiW0?=
 =?us-ascii?Q?04nKowS9KS2wCzfi0PraThk0W7rAB+cuXa3VUf/oacRh1oB/8jUkF4ifDljs?=
 =?us-ascii?Q?xe54actPFHumFHyIORVC0hel7g1akBiBI9U94Cm3jg/Ia4Rhxr+LcZVg7FeK?=
 =?us-ascii?Q?Xtot4JpWRzMrgP/jf1yxA+coxMCjn/PHNMK8Rhx3lys0DWAlpmfIg0aZc2YO?=
 =?us-ascii?Q?3k8ssG8sSqOgAHabPguhFcIXOaUiapjwH2CpF1mBRB36z59CwEduRMUzEKqy?=
 =?us-ascii?Q?EA6LAvEprxm0Q15Ba4rteY10FB6ZKvuM83JvM0urFegpVonhHGtTF3NShY7m?=
 =?us-ascii?Q?BmBSp98Sm4pTL/5QbZ5pc6A6rgWjpRgm/pQqySl0u9JIhY6DERmhK1J+4VFD?=
 =?us-ascii?Q?jWrfRCWVQx20qxftLibF/yqxbdkZOHqREK4+XuhXAiaKJKNueNox+bibyqfo?=
 =?us-ascii?Q?COZ0/RnKxGpYTbMO7Qm29z4Yqy4IqapvRyroFddyNCesSkLzVhNC1nN0IrFP?=
 =?us-ascii?Q?qrCcOWa4KAlaOmYsbELJT6Fpzq7q4sta01lb3TBrn01nF2tBnpXVxugQTDaN?=
 =?us-ascii?Q?hFvIa9HALsnPWz4Cg4YZ+hVFEYGePCdaEO/gL3iUwUSY1KTC6kf1Wvwxg/Ty?=
 =?us-ascii?Q?NO3+ma+Kr7PVVhZKvxd58pymYbMc/8droaULZfjO+Q6E04pTUbt5ybKCVFGs?=
 =?us-ascii?Q?dRAJ1WmneatHf1tXNLh3ovpv2sMlIOt6vfxAn/XOmxAMvpq7cs1vf12zd72S?=
 =?us-ascii?Q?gg1NlBRw7Nmxg1D5NwltbfLP+4UQkZxQYSsiPzrRUfW90Jeusk9hJLcrIqAY?=
 =?us-ascii?Q?4AW6Q8kvMslCbn73HEPuExJj+6YuvHXKU+qAOwC+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a8c9b7-a853-4c16-8e3c-08dcc68fab70
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:59:14.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsHgYscA+N/zzT4l6vVaA3ap+k/zH4WBbGk13SyRwzCX6bIUFLDVBN9FpkId0W4X5+AHLvsS56e3al21Db4CcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6929

Using the real macro is usually more intuitive and readable,
When the original file is guaranteed to contain the minmax.h header file 
and compile correctly.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d72b2d5f96db..415d2b9e63f9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
 
 	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
 		return -EINVAL;
-	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
-		ring->rx_pending : MVNETA_MAX_RXD;
+	pp->rx_ring_size = min(ring->rx_pending, MVNETA_MAX_RXD);
 
 	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
 				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
-- 
2.34.1


