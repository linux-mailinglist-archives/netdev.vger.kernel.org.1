Return-Path: <netdev+bounces-125485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF996D57B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ACC28245A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F7194C6F;
	Thu,  5 Sep 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qWRL4YPv"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB01494DB;
	Thu,  5 Sep 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530817; cv=fail; b=Hms9Kr/AiVMHmBDTBqdyvNabH6bIgow42Lis+FTxIcEgDSlgzkUnSl92fd29X5xcFmRUPsIPHJcoscdi5CY4Lbjg0JvMWuvgsdeyF8gmfBWdfpZHnIrvvWXh/ZziE1dEvFafS2vALmxqyYx2k5P+yCUITaXF79o9dxWpnKxNSEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530817; c=relaxed/simple;
	bh=RpT7QZqMI9JPo4hb43ZlRyndxp6sqdvgcJ7VXR6YO2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OwNlaTkqpp5TBKn1gdwhc9Oe0jPlmhwiIwnBpFpaLeP32EsdDRRRKhqAcx0kCmv+8YhAKm8ztM9rf5yaB6H6vUOXcbU2XEXa1Rd5zETQ01Rwewnx00rFRgXjgEfjDMb0kX4wdtvz5W5j6FluzLDtfsCipQMtAcooAvnU5Ow8jS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qWRL4YPv; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIrNViZYjEQtZCi+CYJ7pi+8fNlgFV1p2be1kS7ar5G0yfaHDmPFoxNB9ROs0ya3Nr03IPGQBeVIp0iHid82kT30mNwhVowkhV7JMfxuSxPvJlJsgMqCIDJ1mtrVUgow61Q9AnwL89fz64LzTcvM3gV56lHpfYDPmBJ8RteA7vcXCvbX6Zquye1pjunlNLENjV2A4mZwhdCtRqf+nLPsm3OFfe2CJI1V9YLk3NlhAirEIFX7HGFj/QUq+jqv3YKt5pJ6NXD3m5fAGrGL0Zanws+RW8kET+fNLk0UfU3h+7IP++iPiOTAeoHKyCycsXeSnygYZi9iCba3qvV4VIm14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isYhJVUiR4Z8LwUJq02Phf6gehlQG4cLGId5ZN6eK3I=;
 b=ahXXiECbZBVRV4pKiHsNzwqJcnXwvheCJZNO+reLATxhKEKbab2Qqu11iUmR3Dwf+M9Unquh2VWmKMFxA2IhjKUz/rkDlGNmrKY3Lbgec8ZQ3DPP2wqmq5NL0CDT+T8JJjuAnPcWNolORzTT+IK18+XyroTZyboZgTYeroRyYQWOb/zdNmCvyjeYO3G1xsEfgeFs5jO2HX4vhzgqJ7d7tHoGqEgWhluM6Yfc9PES8EvtuyNbCNKN35TkWLedUxgQOUyEDde2Y1jeujSSKjeGz5GNmfS/EFBGpG/Rh2QXPEALip6feQ6OitGhr54I83qVsYul4t8t9BBvkUlFDIGUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isYhJVUiR4Z8LwUJq02Phf6gehlQG4cLGId5ZN6eK3I=;
 b=qWRL4YPvl0OkTlsTHrtLO3oUskca/L4QnO8PVmSyBpw00mu+ULGpiofdPZomKAeV5m2v7uyoU8fHKrRxNRLrmzjTs2MTbwnjhTd5DjKJvq09A/lwkxQZLpBA+7pjrYiH0n9UbLYO+2BqoGCRlkB5ba0Mn0Ouf7rhX2PrlD3856InMX0F+5urS2VHcnV0ikhCvA4PAnxQU72c2XOTUWs0Sqaa7wkXhcO3Vbj1fEGbDkO7fXN+HV8Y1tYCoVsXgOzWkqfcG+xnTLSmRAZnIcN+4RX4hQgleL0blYX3/6Loq8GAn+rcjYANEoaAlj1BkfjLP8A2w4x9yxbWNLOtQU9vEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by PUZPR06MB5849.apcprd06.prod.outlook.com (2603:1096:301:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 10:06:52 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 10:06:52 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: irusskikh@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH net-next v1] net: atlantic: convert comma to semicolon
Date: Thu,  5 Sep 2024 18:06:19 +0800
Message-Id: <20240905100619.1199590-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0003.jpnprd01.prod.outlook.com (2603:1096:405::15)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|PUZPR06MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: f220818f-d8dc-45b0-8fa2-08dccd9276b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AO3y6bCDyRGXzny6+hoshz+S71tVWWyTKrU6J8p6TZJjljPWlhQ2sBGuJD1?=
 =?us-ascii?Q?uxsiGo3WiphJHIfLq617Rsv5t+nagmJS9eJIYe9NeVNAp2PStyCybHDhwWlP?=
 =?us-ascii?Q?X4JCcyRFRtIRLhd0F6ve2Rx2PpDj3SPxil+r3i4UY/hJTInsGQYtTyWiR74W?=
 =?us-ascii?Q?f8cZBfa83e39NUY1QxR29494lK64sL2FSvtoFYRZC3mglQnENk589H8LTNbX?=
 =?us-ascii?Q?CF97T06Lb6a+G7RLa1O05DCOcYaBkqDGNyBVqw3CZdkjAtTV/hBxWIizbVqI?=
 =?us-ascii?Q?MjrBon3DuYrmj15FkEAil6dAr1LX9vsSfM0G7gOzFs1byxVsVdAOlR+EA8/H?=
 =?us-ascii?Q?+go1T3b9OvPx/R5JIK1CePZnPB8XQjBoMHaJ8AR/rgbxi+6UJG+YHAkd1hET?=
 =?us-ascii?Q?+LFJ97mJk3vItiFC06Osrd2AuRgzzrkUGBv1U6rTMGHMK7s/UPqy5WmlWZPh?=
 =?us-ascii?Q?uMpIpoQ5moWhPJsXS26RBYtZYZriahm+XGXxbAwyOztRmopnsBTnyaLW7esC?=
 =?us-ascii?Q?xN8MXHjgJl2rJtuhSBAGimarurYoS79VCr+jHMCDRaQ2InLNy9HLPl8LMapT?=
 =?us-ascii?Q?5DFIXzXehG5OvlnL+t+xSUKe9Lhp89Rw2EkE3RX90UGipIfEkdm0gehfb5qm?=
 =?us-ascii?Q?UMcJmRiLqXZ+SgFWOumya6sWw3BHsGPHRwaXDRNIyEDEmj0Bm6i1uqOrpCnb?=
 =?us-ascii?Q?D/K1k9VYy013QKMblD3l30+/et9sayQk2HdL9PHbYijofB4rSdyhl38rBiQH?=
 =?us-ascii?Q?b/PUEBEArkyc/uuzyWRADGEFhTaPBMW7RfVll2H8cCAx31CZOINURuwTLj5S?=
 =?us-ascii?Q?8bwLvdXSR9BC72YCQNwxMszXjuOWnXQSnn7wQ3JGXT1H3y3Bbzn583tE+Ur5?=
 =?us-ascii?Q?lH31COaUT6L+wybRtH5HGQtxEh2392QXeqs/kxh7Pj7uSvanZ52+yzJxpw2U?=
 =?us-ascii?Q?Yyt2qIL9P6DLl0es/aMpp65nLu2gQAKYnQ5wnAwcncwPg5pjzVY+GvtuP+8/?=
 =?us-ascii?Q?uKsGboyy92UoGpd5MJo4yrQ4b+tfbOI6fzA6f8wPKSr3tIvpiq1QzD3PaOS6?=
 =?us-ascii?Q?kKNutNkUUIduEZB3wP+RyZcKrcdqzvVuAQAhsj+Bzbl1DLlNoLp4/i76zTbr?=
 =?us-ascii?Q?KygCdSN+3ghpWrueKhpYF5tNO6Ud7w8duZqYIOIxfiVPYhSoPspgQKBlCNkp?=
 =?us-ascii?Q?aZNEQ2cFPzlwUr7VQW75BggyINNEAmL6wk/kKXy9UdA4bEGf6HT8d0qezc8b?=
 =?us-ascii?Q?Qn4cFfEN0y8rWWjPMFt7PU7VRYKeg1bOSRl/xdFUR/B3GFPO6AZp5yH7eho3?=
 =?us-ascii?Q?y2oupmHaDvuvNV1FA5mYLrQTcQkhysk5ohnS+L7+Z36z9JAovy8Cn/Q6z6Dj?=
 =?us-ascii?Q?RoQVOEHFYCOcmSaG4sQaNYw62INblfy4ZbedpBqoEkn98DXzpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaeZpKoR7QHlNjlB0/JbpeElRCh9mr510dGYaT6GOjlJdcSL8218WxTefm2r?=
 =?us-ascii?Q?4R9YqKpe74HWn/Hz7dp4BlrkCZhYMbY7aQZt3EzaonH1B1LeGcPD4k4q81dX?=
 =?us-ascii?Q?Xqp4lJp6ygyKWTWo7E6pDag2dUnY8eTmGiabWCQtRF5M1RzWFF1HzFkL3dY6?=
 =?us-ascii?Q?+D5F0cRRhMJAa2wKMjf+eKNbR91vqUsm2OyqNfFyR0TZ2WoBw3M7m6ewYa8l?=
 =?us-ascii?Q?XabHziYDezysSwFh7UTYmiHeL4dc9QT/h15uWpZZMPfnOAq6nO5+aA5WYaqw?=
 =?us-ascii?Q?thCZ5gACNPp4rXFIHhVUMrK7RuUsJ9RNOhGEhdAaEYNWNLZ8Y4R0RTeQq98C?=
 =?us-ascii?Q?TVUg/JuTlVx+BUZ/h8l1PduGfb8DR461/D1FGfrr0uvTSmDdJ96k64GnQ5GY?=
 =?us-ascii?Q?w42wsplfo2Vgg8VkzHcD0nJe7FcKLznqWUGaTX+5PHiX7FV1PNXxxet9A6Z1?=
 =?us-ascii?Q?wrX4xtcux3a/82YwGgQyy96ug7VUBX+uzMJeoBvb6m2NCJ8OnnAO0Gch/Jmz?=
 =?us-ascii?Q?sjjb3KZ0Nu9t4FakPjBrN4lJ521D0ApMDYk4NQuI/bfdMDLqXWOXOdZAgHeE?=
 =?us-ascii?Q?Wum+DPRRKZyy+IcEOgafgNZfehn+4+YuKwkPN+16ZMc8dJeJMLrNTlvifCxk?=
 =?us-ascii?Q?k7dl+oCp1yF8m3Gw1kfYBvihBWR/Fe1+//NX7o/jcDNEhTosgRZNFCh6A7LT?=
 =?us-ascii?Q?rXMNQ/BM9AzyL1jyCs/AQ7dpgLoYobG2uTM8nwolRq29OwVqGLFEB3ZASiVh?=
 =?us-ascii?Q?UqkK2kxjRN8lQWm+n6ypKU8MaVhSXbCMNHqL0nEdRQ7z0t4SeLJKW3LmId1u?=
 =?us-ascii?Q?kY4RrgCWmzRkEBKEARyVSH+YfumycrUED7D/RAAtQCu0SNWevwFO7BertOub?=
 =?us-ascii?Q?tstCWQgoFj1nPgKKMtC2fNfFrgwo5DkmA+18ibSFmDrmqcDNLcCKbU6z4ElE?=
 =?us-ascii?Q?AKJahDZlQQ86AFHeqCUbz6vnlqXrcOrOoW5pmsgIR/JBryTwBcyAjyJl7bzr?=
 =?us-ascii?Q?LLh6yivJZ26bUFR2h2WYLtjNWHXAsdeHWqlVRGGeK+F5qtoNIqRVs1VNvqYR?=
 =?us-ascii?Q?dQMVl0JR2GVXrX4+eZKQSZEuAWlA654HEHQlzM6WXavk+v0EAnP3McsamiMM?=
 =?us-ascii?Q?xrbAiNWPLGTBpYEHThBRD4Z8UcaVHi9Sc9F0lOG7M4tek/hRRU5y34hxHhIz?=
 =?us-ascii?Q?+FhMhy5OyMFRKSo3T2BXPw5ha1Gtpb5SMFehGeyJAijfi3jSojy+yuJRUA/2?=
 =?us-ascii?Q?c6RLLZmHXKZeWUVXmNHvrgi1YxkjxHiNxEsFYhQz9651MIdNbSSg56578ABF?=
 =?us-ascii?Q?woRgocdkDI4W8JHXSqV90PV1zEW9Vv3YnbjeexXQcigh52yycv+oAt4juPK6?=
 =?us-ascii?Q?NeZokr7GKTZsMpWIemTFG64ozAC2aPmiLQ9uh0MfbaeNGY23kW1vXYyj32ds?=
 =?us-ascii?Q?F165pkK1bUMFsT7N80aGFY32AqaKO3ubQbaDSY39PWDysdLSXqu0TmP6X8l2?=
 =?us-ascii?Q?PfBe/FKXnxyTXzjtz5NQ7XDN9ENcsoxrYTfhd+ADNllxSPeRazl3pVFv+lUC?=
 =?us-ascii?Q?fh891Gt+eHR0vk33gZwrj2PlNSGXxA49+KFjp76F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f220818f-d8dc-45b0-8fa2-08dccd9276b9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:06:52.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOMmDkaxi9b34+OuVBiOyezkMiUaVdioQftiFaNCKWl/0/7OuYdHYdP/irL1I43RjNFriGYrlVWOZBciPuCgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5849

Replace a comma between expression statements by a semicolon.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f7433abd6..f21de0c21 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -557,7 +557,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 				}
 
 				frag_cnt++;
-				next_ = buff_->next,
+				next_ = buff_->next;
 				buff_ = &self->buff_ring[next_];
 				is_rsc_completed =
 					aq_ring_dx_in_range(self->sw_head,
@@ -583,7 +583,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 						err = -EIO;
 						goto err_exit;
 					}
-					next_ = buff_->next,
+					next_ = buff_->next;
 					buff_ = &self->buff_ring[next_];
 
 					buff_->is_cleaned = true;
-- 
2.34.1


