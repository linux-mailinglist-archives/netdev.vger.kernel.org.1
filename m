Return-Path: <netdev+bounces-123197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45139640A7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714011F214C2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D61662E8;
	Thu, 29 Aug 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DPLXPAyP"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060.outbound.protection.outlook.com [40.107.117.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF022097;
	Thu, 29 Aug 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925350; cv=fail; b=iv8Vqzz3F6egTrvypR9qBBxBzk9+HbNPk51j+B0tH3cQ/p6OoXzkc46lWLgaprfjAZuqTQdvXiLlUCH3RSJYmH48dt4cD6z+Fh4S8OCIYIwKU7zEontkgkpwu34sBzZd13MjZVqROVV65xdFRaBI2J46+VqmG45Pwt87g1uto2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925350; c=relaxed/simple;
	bh=bWjk9wz59TmgD9iPzvbNPIcH5EWnqWaxZooylleLq3w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NzWl+JnVGl1GfIJ0HWSC6AbXNWubH22YYMKvsPbODctCtqSVHbcVtNCfmE2gKzBf7jYeMfbxRspTdz2+JpW3EsCGYaBKREu4cUFJAKwYf/dclzgiqYLdYSaMw1UbbV+s9izltmSQc3dNf5aWKOj3RGyUGQ3Y5cJlp9PS6rX72/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DPLXPAyP; arc=fail smtp.client-ip=40.107.117.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYg0RlJprDkdAdIYHo/78QaXy7VBsoxYFuD+yRmjj9AW3eHKIi/kX/nHxq5tQrWtmG453bLnF75jy13XBZPctkpkiOSsFbHF8qj11+Pf5KvH7IAshYEHoErBFwKS+FeLChCeEs5WQmj4oyq5/3jYq6590uAu/b7Qe2/4Q05dX8mwzNhGVJa1A1e3e4kXzFROJ5nMEe87FlphU6TJd8Iu5U9iHLZ2oldeGfbqX96gyp17hvKl4Hrk0ZioCBQyyz7Ku3jpg+96PVsbpbvCmklxJeAKNYPGrTf3Z9z4Z4BTRhXHK1aUTidg8FCttmEWhPp3/mpojDTZLzwUO3IKg9thSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2gMeajsl+PE8P4Uf5iwm3cg8i4iRH46/k8Jhrwyvwc=;
 b=Y6Xo9Hc12ZYGmd4ECLn4zlgdwqs29ALBt5prs8k+NGR5GCQaF4Qb/xglZmnluCJywX9u9Eo/8gpVCmUWQWovKN9NJy+ZvVYjiIWV9rypaFI9em/xbkmSPgb58cAvqvJmZ0xkLC2sUo+yl3DIMDGMLTw3Cu7qpEuzCTGAiRwHIysPmhqlxJZvZiVU5no8+dPlm4F/QdBBVaG4up0iIJjs7Hcg2KHPBegEZ8hCslnJxbhcmdftHIsiOjZCkECgehCbX+iWz18N6QZHTpPm6WSVzqMNb7fbuk9zvji6EkZHYHNHCOHWIS8tmhqmo6WDklmPiQTjfjCjlK34Pgss3Csx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2gMeajsl+PE8P4Uf5iwm3cg8i4iRH46/k8Jhrwyvwc=;
 b=DPLXPAyPNB2SsE3Sno3vSX7gIqtql43cOTLFxX55EVGi9TSYbwioa8I4k+X0EtOhyL/FySjqo6FK5fJ52X69jdAa7n15/u4psUBtJHydxsbxPFig5gPGQWfB5yWyMeSKbQ/g60uM+GgIYAYB1Er3qYENwlgjGAD+hP8JDrfWcGA5B/hY6gI6Y7362t4WMwgUXmAxh8ud4yHYaa+ObeUy+fWET1u5mVyJU5C1ktTE/hNvH2g+SxxrdshiE9PcFKKK5uNqprJfK2p5ZKsxgAOryVCgskOXfVmsWTbmW/DEUnvIcgSUJHNLt7uCqvvK6tIPJiiRtCuEroBk0CkZRFXCng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SG2PR06MB5035.apcprd06.prod.outlook.com (2603:1096:4:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 09:55:44 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:55:44 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: edumazet@google.com,
	pshelar@ovn.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1 net-next] net: openvswitch: Use ERR_CAST() to return
Date: Thu, 29 Aug 2024 17:55:09 +0800
Message-Id: <20240829095509.3151987-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SG2PR06MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9ca7be-ba2f-47cf-c0b0-08dcc810bf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLrT4MNHd03QcyPv3AYWfhBAmlveCYtyAF8eXZ89teentjRkFIyA6wM+K9Sl?=
 =?us-ascii?Q?MeQMfHpz2Dx9FcXhBT+rH7GgidPcJkkA9NThQm1F4v+0z/+P5ZzO3kVoGcH3?=
 =?us-ascii?Q?N33OAlCkxOptUcjglaVG3C4d/tobJ45/OR6fjl3u5Y19CHNoA4Ok8K9TfquD?=
 =?us-ascii?Q?9PD1dKuEe+QorziM6iekoMQoSgW027Ej1ESrkcNPltva2KYKdNF9SDPzxPJQ?=
 =?us-ascii?Q?mlJoKWmH8xk0Fsa9xvjUX8Za2pTotKRjss9H9BDFstMiBhMX2C1x1GqSYWFc?=
 =?us-ascii?Q?sHh3ZcO7yu4SndOlJ3YCSVJ3en0jpYF5D+UJSXjE2KoCOBygSKrwxBoHjCDn?=
 =?us-ascii?Q?pcPX1Gbi9wUn/A6SbbouVykCHSG62LJ239/cdPuVrLD4ZdG84DTsjcJ7x0W0?=
 =?us-ascii?Q?xHQo0WgytSup9yRpjdalYJ+562ewIhdzK0Z8Giw4kNZ4w9W/rCDcROF0vJWm?=
 =?us-ascii?Q?Jj2B7irudyNy+y8waljscB0533S8fkfVqfcQKCqg/fzdoii64WJLarajxyUI?=
 =?us-ascii?Q?u8zVHx8vwmeCjNJ0wgyxSzxkUqo+xMzfYg8Wmumc0EBoJeelcmQohJKyS6ZT?=
 =?us-ascii?Q?Gy4cbWcoKtrXtkQ0CP0O997X9bAsvhY40FhJUzFQbPTre8BhqG+DcVh00WrN?=
 =?us-ascii?Q?YxOotM+ycQ2f/Eh9M3/uJZlUAnhXkQ30pEjlE9+7sEP+v3VYo6xJhVRGTi2z?=
 =?us-ascii?Q?Jcxh+wPYgtbPHY7EJEn/Zm4GlXTmaPchFFejpe519e+2T+y3deV2MrO9vRh7?=
 =?us-ascii?Q?fxYl+VNnuuZO53lVNrPrem6UKFK5vi/pBu2KWs2dlrWJlzNhCfdvIIfEdzb7?=
 =?us-ascii?Q?EazCHdPcmAy62htwd68coKpMOkM2H3AYIL17FiVNZ2/0lTiYNFm9rJoZ5fw9?=
 =?us-ascii?Q?il37s3r3mTEIcRGbxHQ2POXxBXn6sJAPGXiv5FO+eJU3zgMnRS7eWrJU3aUS?=
 =?us-ascii?Q?0MJUQ02yTamgvXiW1PHNFSTcE/TurMQ85ENlVuJiIJYDkIs28MQFhNHZejkT?=
 =?us-ascii?Q?1z5Q2Kvo5t37iaQ3P3189cWOTVb4s7++4GHDi9WqZ26CAow73yyQPB52TcHF?=
 =?us-ascii?Q?fMaWMzjPWoN2yicuoc7xX+/7CUkJ2mlH40meFqhr9N/s5UjivXsbwdY7cerM?=
 =?us-ascii?Q?Bxi84EXveYKSgb1lwLViIbNlOC/4M4PDq3m3iVs1BpPZUZTE4dGg4/YQWDQc?=
 =?us-ascii?Q?k8zvZzyTqMHcJsF5xpNVzus2zrsdm65sBUhj2f5N6MfU6084179kTs3dKBTw?=
 =?us-ascii?Q?jvwQdZyESQzqKhrOOJhw7jRaVNITf7u8Hu6AJL8vfHX5+ulixrTHOMfqHSwA?=
 =?us-ascii?Q?j3X9KEIVltEOm6GTxUCCBSrAL1eW0r0ya2m75Qjr4f+7Fxj6gYiRG+jRSzti?=
 =?us-ascii?Q?JwiO28y7oZ9bfNEVEY+gRHgepJV7Cj7exFklOBxjdYKab/axqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?24LWxa1FccDLEqJX+hdEIMIFuV4xe/mPcXWCZnbMSb7P/Xd8e9dXIe3OjUeT?=
 =?us-ascii?Q?TqF+xeXjE5a0ruVf9b3gT562YWRNHuLrOrB3wsA4+kh9h2wzW9YX6y9IGB2V?=
 =?us-ascii?Q?q4vtUWbJOB9clnfri3m43sdOSf76tAT4jRGv4iSkH1LixrMHOvH3AZEiXzrP?=
 =?us-ascii?Q?HVLt1cFer0UpNMJI4uhbZWwFq+hckVrASd3eVH/HaxFkjyKOD5Ew345oq4Sj?=
 =?us-ascii?Q?LBWbCkpFfYgNn16TrUqckCOGFzIA1FerGq1MKr9EYiYcxotBGIucS7yPnMwr?=
 =?us-ascii?Q?zngK5xcPRicPE2a+wskTHcKRRJsZ7gXEz21wDPo/LJmUJJWQPk2sCoWIYORx?=
 =?us-ascii?Q?LpIlImhrZahVDS9EoB1zSiwjTjC9eSTJlwpapXQrSV3I6wtptiT7USLJqlAu?=
 =?us-ascii?Q?58Co1+TFBxkRyZU/yKGg0+Y5vxh8aWNzI7FjQEhs2TiVjmLzbTkxpSzSA4o4?=
 =?us-ascii?Q?kkZroI+jnWcmeL3MInDlmd26w5Tvcfxacu0VHwWxTzvJsPzOeBsrw41IRjhb?=
 =?us-ascii?Q?wySdmv83nkC1RF0awHOifOlvCyt0zVWK8XO4fb0Xz8o0NFi2IqqpKGj7b3kN?=
 =?us-ascii?Q?HesKHNVVf8gcI+0ACl56Ojcz97rOtug5N2hdQ5sMGBpqV0n4cHgnrEfzjkXB?=
 =?us-ascii?Q?tafib6UScGOOxeP/wPNOCg3E1RpgJzhqnak7Nu7ZFD+PgfXuPNDdrCCe5Z4M?=
 =?us-ascii?Q?+gRjHB7HmSnYAAHaOXMH2BEil3EYoV2xFRWkMuo4sMKU2osI8gX06RwLd8kx?=
 =?us-ascii?Q?gpANCyIc2uYu2HxIpEoo3fRUE7r5je6tMP3ppYB/jFRhC4gYyyDaHnFFw4Y5?=
 =?us-ascii?Q?gp686u28UrtfqOgws0GZGFXjpOr6x4OG708BvEPQqkfnjBXDZ0GjjE04NYO9?=
 =?us-ascii?Q?tXkxvtGkmuD5g+4KEClfe4moaRwBkHczmlcIyCDe2PnSKqExkepPF/rJqwVw?=
 =?us-ascii?Q?IPlBSHqgtSx+fw5yty8m2mHMxLyYN9sIrAvLVWgxdjKI0Ll+fgCmTOm0WYY+?=
 =?us-ascii?Q?EfwVx/HiS5hE2jiKtmcN2j6mO1eyo5aHA3iak6O5Lmd5BD7FO9qsiiUoa5bi?=
 =?us-ascii?Q?f7IJKM3gYhJlb/LlwQQS+gE3UABoYScDfa8z6NUtzYOf5vQzHF77qTHAUMdJ?=
 =?us-ascii?Q?cLOxsvV7qIeRbAEANjGgI8It1AQgoZKxdTpw6CRZKSMOdcDs0W5N72CzG3HP?=
 =?us-ascii?Q?TY7rUkKc0GAFmVU5ttmyQUXgyTXLzlLrgdftg+bLD68xIcm4BkVHJEV98A+R?=
 =?us-ascii?Q?4FOMZh3UC9B2d1SeXP6u6am07xnBvogEXW8ZnlzA8zXsyaYUDzky/BGrwjfc?=
 =?us-ascii?Q?7pp4Ryz8QqX1zOxnvcQV8NP0vm4VTHsIy3+dtgwBjKxpu45xvcMfFkMnMapa?=
 =?us-ascii?Q?sKnKhTywILbd1srdNwlZz+hEWuZ+Om1EwZe1cETO4Rb40j6o67KQGVKKtWar?=
 =?us-ascii?Q?VTiwOVA/5YgYHLC59cU73V+ZPDYpHAVv6Pd+i1JmMuxM8yYLT904pN6ESOPL?=
 =?us-ascii?Q?s5ADiFhWrzbf0P4Jdv9o8U1wOm6n922hiUSX08lt3BO1ue/+QBz2EVfnFaRl?=
 =?us-ascii?Q?n5T9zPTYk2fZuKJ1zYUQ30i2mzqcCM1xRSHIKUV9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9ca7be-ba2f-47cf-c0b0-08dcc810bf97
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:55:44.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsTyCjjldomYoDo1pP+N1Xx+ISYjl+NYd1XadE/8SrdJB76mRChpBUQEEcwZzvCbeghDeqYw0CS17GBHYFn9/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5035

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/openvswitch/flow_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index c92bdc4dfe19..729ef582a3a8 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2491,7 +2491,7 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
-		return (void *)acts;
+		return ERR_CAST(acts);
 
 	memcpy(acts->actions, (*sfa)->actions, (*sfa)->actions_len);
 	acts->actions_len = (*sfa)->actions_len;
-- 
2.34.1


