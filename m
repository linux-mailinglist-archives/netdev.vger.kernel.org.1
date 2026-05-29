Return-Path: <netdev+bounces-292999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BXPAgowGWq9sQgAu9opvQ
	(envelope-from <netdev+bounces-292999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599435FDDA7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA98D30E178D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137443A4F5F;
	Fri, 29 May 2026 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="d+KZ9/QM"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020117.outbound.protection.outlook.com [52.101.69.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950C352031;
	Fri, 29 May 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035351; cv=fail; b=EoZw0JBERuGWntSE+ZcQxZkjDFPFxYnVqbI14bW046NuAH8trxsDWh8fcZZ1PMkjN/Ueyn3sEAMSe4MBPV4vPvCdIy73qvlOG88wYsbWFSCX30w5k1aq7TwMQX80OhWKpHafEc5xwQx7pIcJqIsd+NWkORUvf84V1O50ayr4QbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035351; c=relaxed/simple;
	bh=CTHi4DuCZRXIBM2puyZJflrq0sEVOEhPPjE48+rhTko=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=FyK7Bk8x5y6ZVAVbVDB36HbTMsd+7hf7h9gE1iXKKbXwJEzCsrgf8sl8wI2XnFPjRy96GGsMxbK8WdKu8T7MuFOBmZe0U3NqIwHgdclq6G9v5/pmcEAJMfqgMfRRxNfMGuPD4q+T2KC9W/kc6F2Yzkzlychj1XjE0m5Hx1SRFGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=d+KZ9/QM; arc=fail smtp.client-ip=52.101.69.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZjRFQ8ikYSzDd4uib5DfTZQq1TjfXUdUUAUTH/tRblqDDf3MXalW8XIyhzxLxxm1qAoIim3SwRl/FVdPWWQCgw+9tdrg9KREtRRxD8BhbfGqF8iZAMr17ahkX6w5mOhxFdXqQOIzAleU1ys39dehfQQCkc1d/Fd13Q7a+RivOTKm7gp1MKXlSDNL20aF2YtDAoWe8wIA84RCJfdqM0q7FvhALoVlNcnwL54KAUVb1GyYkayZU7CF2AcayT7wriiIJi04hYkRA1fd/Pr4YWKDqaXtGBkZz72w9+Otk4NE4HekIhiG/NX7yvQ+JO8tevxKOYrQHS01w0FsZsoDkXZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVoglDxQZYYOhf3tBMmYQIReAOW7LMOzMeArXqLcs34=;
 b=OunrchaxglOlQNKQm5YRZWSEoKij4+nPvMbQqtiVZ4h8Ekq6hcm1nwvG8W1V5Bh6smxUSz6elaZi4Hlk6vRJKfhHykyhw7x78yNtq+d+8evayGBARr6NeuxmNZ6vgztHYQc0qfy4CtZVZlCUWHacV8mrfiFULHn1yOTKhmzIxUOZR1UqIs9ZsGDEPD10qGKd4kq7PWAt2mopc48APoIvP6hSmpz6A/6yNlpnkRePbZXCY5YrsQb1TTsCkXUHS11gzRNoZDy/+D6oT0xGMXyoWQjptVMoK+Is57PZd0rrDMphWleACz+InJl9GmWH5wK6rbZlK+Vlm/p7B87EdLrNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVoglDxQZYYOhf3tBMmYQIReAOW7LMOzMeArXqLcs34=;
 b=d+KZ9/QMcPgaid4NaEdhT6wEXTrK9MHaFq3aBj0Z17yNEEtaahi8sp7RfClGe0iG2BqfTtdOSs6iuWqU+DfCehR7P9LQG7eg2f3MK2OsmlMkIcadIJ5VWlD5P6dYCGdUbDykGgw8Caw5Xz/GOvV9ZRXR+ITA+Pje+dgAphmQiOv8wC267CHQ9E0Gl7I5Akt0KNOratAVUUOtES/HT19Swd+komNyfxr12mkM8/p8NhiiRHK2v9GHzMN3mu9mhQyF69Qn9+zvDBsyF8RHLdoJNmVn3Nh2qRQRwyfzlSSXoMkpgYmiQXs245VZLUgSnhOwrbMyrboJ0/YMINbALvRhpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS5PR06MB9039.eurprd06.prod.outlook.com (2603:10a6:20b:680::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:15:43 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:15:43 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 29 May 2026 06:15:32 +0000
Subject: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-b4-fec-resume-pinctrl-order-v3-1-56bb52b80ebf@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAAMvGWoC/43Nyw6CMBCF4VchXTumDAXEle9hXJQyI024pcVGQ
 3h3CyvdGJf/WXxnEZ6cJS/OySIcBevtOMTIDokwrR7uBLaJLVBiIXMsoFbAZMCRf/QEkx3M7Do
 YXUMOuCFpmLGumUUUJkdsn7t+vcVurZ9H99rPQrqt/7khhRQYucIiw1yhugRtve700Yy92OSAn
 1r5W8OoYZXJqmB1KmX2ra3r+gaTCcg4FgEAAA==
X-Change-ID: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nimrod Andy <B38611@freescale.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780035342; l=2996;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=CTHi4DuCZRXIBM2puyZJflrq0sEVOEhPPjE48+rhTko=;
 b=5lLAf+XMq46w1FSVJl3PZVbr2vW14kDsXG2CKQy62yHy5iXE1sNEt1HYixxlgosw3yxw0WUkS
 9Q6hwHKo9vpAa+jS3hpbfA1DUDHjxb87OnZhZJxcB+Ez8Tjv4tN7JTN
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3PEPF000167ED.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::672) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS5PR06MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ad4db4-f906-4f7b-cac6-08debd49b6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|18002099003|38350700014|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	YmByAltCuYudR/vr3+jTAjOMqclCc8rq+fj8VTVpQi2qL90ZDybbznxAFiX3DApm7cLPfOjtg/nM57LZxYY/Z1ws0xPkI5Qv989Txl6a1bbiBeE28ShcoxZfGhmfu8hFiff7jecR6B5cHGGvyzcSHqZyVFDq5WFtO2wcCi4cGQEEEtBGFBB4I5GjmC+vwEw4rHZJ4X+sThTFror7SExnOj5wvB/AIMEWi1h8ysga7laRP+GRMwY6OJdLrFLkPh+oM1Xozs4wFsK3CIDXKUEAvBGG+ILxFbIfjQCNMwzrCkuu7Tzse0VbuWolfLUicSBx4HLkFp/ZWRiNV6dwNgefduvaBMQRSphCCfLsNwjnPkq1ILK7Lp4d3SQYf41z6ePOi1pSkW8XZIrg7iFrC48xsdKJ/ZvRrn0hMWxSPWULAGf40aoBUWtJNkR3rpXJqR127hulUu7gXiI7J9DIAkJNeiG6AoBz+Dadcca7NAwNSawjHbe/qJ+Iqh3W1tlXT2fZo1h/Dheu4Pz8XIBdPJR8c3In+L+54XbPdP4J4q8UXD3t78MLIxD6DjJSinbBn/SmO+0jC907lPxtzW4zhAouC6AyHN7JnSg90yCg+4eHCsQEUwMFG7eXF3q5MsFLeIMfdXk3HAxr5O/jlnRxa1lRLmQAxf57NmHOYYwWi1bMs55otRR/MGPR+yCCTmncGghrduMpK7+7b5cIH2xqNU1ZzyyXIf/Rsh1RFmpJgB5xGY3C3IC4bK2O1BY40i9sWUqF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(18002099003)(38350700014)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFaWFZrWHBHbnFqU3pvYlNFQjExV0pYMXZGT0h1TEtsa1pLOEhSLzZ4YXc1?=
 =?utf-8?B?Y3ZnRUExanVkTHhxSDBWMEpuZ1U4RnkrZEF5VGhBSW1WbE9Ha0lPRnpiamhE?=
 =?utf-8?B?emczVmErQVBQOGlWaDJTUHh1YkFnUWhjZmZCekdFRWRhWkprWG9oSHhaa0VY?=
 =?utf-8?B?aWswRDhsUnlXeWZGQjJybkh4SXJ4c1BlTy9hODZxYUVPMU9CbVlhTHI5UGgy?=
 =?utf-8?B?RWVLNis3eVZmaWxEa3lrUjN1SGc0UWcvWWRDaWVsTTZhV1M0VHZ5Wm11ekNh?=
 =?utf-8?B?eE4vSW1vSTlVZis4bTF6VTRjRWlvUE5CSlQxSTlPUkQ5ejdzNW9TZTNvaEFV?=
 =?utf-8?B?enVtTVBZczlPb1NRMHVkWlc2OVliUHZIRnlONXVodmdWQ2F5TFpZR21DSGNa?=
 =?utf-8?B?Y2UvczVJSWtkUFZJMWlET3l1akE5VW1Lc1JySnhlTkpicWRualdSS0dlMVh0?=
 =?utf-8?B?a2lSMUZHb3J5QWYwRkloSjZQOU1lSGdMZjNXUHI4UlFSdWgzYkRCekEzb0lo?=
 =?utf-8?B?bkFOOVowWU5Nak8xd1ZPVXBLbjlrTFhwS2hibGlNRkl4bUFZMXdGN0VMbGxk?=
 =?utf-8?B?S0UwWTdORm1UUFFKNThTK2pwQ0IwdFVGNVNpKzNQczJ2TXRLUUlPQkJIdU1j?=
 =?utf-8?B?R1M5ekNDbWRnOURHZlkyaVpvSVFIZG5JQVFqMEF1MitBWlVoS21CcElRR1ZZ?=
 =?utf-8?B?RGk0SnpVYkhwa1pLc3kvSlpiYm5NUWxFZHZZbFBnY1JIazE4NkJBRmtlU2JH?=
 =?utf-8?B?NG9PVTZscVdlanQ5aE5FWEIxbU5ydWFTWHF5bGhKc3o4Mmg2YlRRamZkbFdu?=
 =?utf-8?B?QStZUHBaRnAySHVIYnlRck9Tb0haYnBBK0c1WVBLRnB5NW8zS21KQWZMWkF3?=
 =?utf-8?B?MHI0VjVxNnloZE9rZlpOUFNIN0lJN2xjcXJPS2d0ZzJ1dmxVYXRaYXVXS1A2?=
 =?utf-8?B?YzczOWJvbUJBZUpCVC9tYjh5d01pTWxobEtVb2lTL1hrREgrUDZBTWVwRkRU?=
 =?utf-8?B?RXVBbzdidUpna1hSTk1Xc2ttN01GTVJrY0E1VldST2l6TDlrVXIwUkFucUVo?=
 =?utf-8?B?LzJIelBQUDRxeGNxVU5yV2kwdWRnMVVnY012ZHMzejF6eVAxbENHNlFZMTZG?=
 =?utf-8?B?RWZmV3NidTBJcmpBeHdqc0J0Q2o2ZUlUVVd1aGtXYkVyb1FId1Y5MTZxQVlq?=
 =?utf-8?B?Z01NTkFYNitXQ1NxMTRDNXp4Tnl3MXJwMTJ3YmtBNk5wOUVPWk5odml0Tm5l?=
 =?utf-8?B?Mm5xQk91ZVFyOGk4RW5lNVhaeWR2TzBWSVQrWVpQZS82c29tZ1A1djJ4Tldp?=
 =?utf-8?B?anZScXhDUUZsNk03TDlzdDJZU091bjFoZ3FrTzl3MjF2MzVlOWlyb2UrQ0xG?=
 =?utf-8?B?MmU1UkdBbGgzZDVsSVU3OWxRVnluWlpoRytqUE1xY210Zk9xQ3dBMHNnak4r?=
 =?utf-8?B?Wlpxc0RqWG1ndmpCS2IxLzhYMFBoNHI3QngzZGZEb1hPdXVudi9XdGZZUzMy?=
 =?utf-8?B?emRITlN4YWttR1ByZHlNU1VOQWwvaHErNEdEc0hMTlhROWZvdXZsUG93UmUw?=
 =?utf-8?B?NjJNbUhmYVJsOUI0ckpLMC9QVm1heWJkRS92Y1g1cHh1Yk5KcWQ0eHU1S3Bm?=
 =?utf-8?B?WVFUNmJPMlBWL01GbzFTMnhRV1laODV4SEU3dyt2SzhrbVphWmJZNTNiVC9R?=
 =?utf-8?B?R0RFdG9vQk1BTHJSRWVJT1RFaUZLS0VzMHpMU2FYeVIrNXdRb2ZLUFIwRUgz?=
 =?utf-8?B?Z2paOFpMZDdHTjJDc3BDZExPZTBGVE5wOE5pNlVUNGRXQTVYelpZMXNuei8z?=
 =?utf-8?B?L0NrRDMrTUw4OWJGeFBXMjBxV1B3RUJWWmU3TkU0SGJHYi9QQVc0OXA1MHNn?=
 =?utf-8?B?L3oybWlSN09lb3Jna1ZscSt0RS81RkphOFJ3UzVCSVo4ZEtvQVJmRFFvSWp3?=
 =?utf-8?B?WTI2YXJYRFZLZytGQW5JNGp1QjAyU05HZXhJVEhGVUYzWEgraEtzWUtORGcw?=
 =?utf-8?B?cThpbG1CNmNkQXR2YlFTRzIxamdxN09YOUZkSTlFU2lDNkY3bTRBcUEzU0ZK?=
 =?utf-8?B?MjRoVW1WRXVQRU14TTBzQU10alM4VEQ3cUplL05EQ2xzbC9BMlVFNlpxdk1a?=
 =?utf-8?B?M2E3TU00UlFWSFY2dWJNdnFpcjgvc2dxZ20wWEI0c3lqUjZNdnZ2MkwxRk9l?=
 =?utf-8?B?aE1vL0RITDV2RjFMMzZtNTdHb0pzdThTdEs1RWhlc2NWYTZ2ZVVwci9wbVdy?=
 =?utf-8?B?UzRoei8xZmxidjNvMXdpUWFxYXJsMGdEQ3N6cG1pZGl2VDdyU2RDK0xRbGpD?=
 =?utf-8?B?ZTFhZDBVc1ZNRytJZkdNalVQQ0RmbnB5NG9PVituSlpLSElUZUFLTVAwazRk?=
 =?utf-8?Q?IJRG9JZpqFtRjmoU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ad4db4-f906-4f7b-cac6-08debd49b6a8
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:15:42.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJkOK9k4uKlu+dAPAAstwEnOL273ALjQGSO+QPCx3BesteepbBiKfYmZQclLJr7iCgNFx67ij8xC2LgJ5IRshOVoC5FXcjaMpfJFD7yLhAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB9039
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vaisala.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 599435FDDA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In fec_resume(), fec_enet_clk_enable() is called before
pinctrl_pm_select_default_state() in the non-WoL path, inverting the
ordering used in fec_suspend() which correctly switches to the sleep
pinctrl state before disabling clocks.

For PHYs with the PHY_RST_AFTER_CLK_EN flag (e.g. TI DP83848 or
SMSC LAN87xx), fec_enet_clk_enable() triggers a hardware reset pulse
via the phy-reset GPIO. With the GPIO pin still in sleep pinctrl state
at that point, the GPIO write has no physical effect and the PHY never
receives the required reset after clock enable, leading to unreliable
link establishment after system resume.

Fix by restoring the default pinctrl state before enabling clocks,
making resume the proper mirror of suspend. The call is made
unconditionally: fec_suspend() only switches to the sleep pinctrl state
on the non-WoL path and leaves the pins in the default state when WoL
is enabled, so on a WoL resume the device is already in the default
state and pinctrl_pm_select_default_state() is a no-op.

Fixes: de40ed31b3c5 ("net: fec: add Wake-on-LAN support")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v3:
- Move pinctrl_pm_select_default_state() before fec_enet_clk_enable()
  unconditionally instead of duplicating the clk-enable call in both
  WoL branches; safe because fec_suspend() leaves the pins in the
  default state on the WoL path (per Wei Fang's review).
- Link to v2: https://lore.kernel.org/r/20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com

Changes in v2:
- Remove a stray blank line between the Fixes: tag and Signed-off-by:
  in the commit message; no functional change (per Wei Fang's review).
- Link to v1: https://lore.kernel.org/r/20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f89aa94ce0202d5f28f37362ce70e0943aa14025..6ebde65d7f1b8728a6c5d28f75cc0b0c4d983969 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5594,6 +5594,7 @@ static int fec_resume(struct device *dev)
 		if (fep->rpm_active)
 			pm_runtime_force_resume(dev);
 
+		pinctrl_pm_select_default_state(&fep->pdev->dev);
 		ret = fec_enet_clk_enable(ndev, true);
 		if (ret) {
 			rtnl_unlock();
@@ -5610,8 +5611,6 @@ static int fec_resume(struct device *dev)
 			val &= ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
 			writel(val, fep->hwp + FEC_ECNTRL);
 			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
-		} else {
-			pinctrl_pm_select_default_state(&fep->pdev->dev);
 		}
 		fec_restart(ndev);
 		netif_tx_lock_bh(ndev);

---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


