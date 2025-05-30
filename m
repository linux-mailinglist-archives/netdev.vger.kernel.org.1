Return-Path: <netdev+bounces-194306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B8AC86F1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9649E270F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D31459F6;
	Fri, 30 May 2025 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="n+oRqRqG"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023080.outbound.protection.outlook.com [52.101.127.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E3182BC;
	Fri, 30 May 2025 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748575042; cv=fail; b=mRXI/qfft6B5BFl0X9DIeKFywE0HOtgTuInTlL4gRCWEeFDC5X2Uq8JD1eAkZxcXkyW3+QfcT+qdtmVfrzcdbt8gic34sC/dfDn1NK6TjaywxRAS2zQLZIHuFlH+3z/1dJKrdEvuXmjpGKWFRWNQnUXaNc0Y8+ROxZTy5Gi+JXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748575042; c=relaxed/simple;
	bh=KJj4hyH8jE1QK47gc1G6ueg3p4HMkikwJX146MPqpn8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jh4gvRqsGTunVKRYDTpKi7XxvDUdCHUEOOj9p0KLt0LN2r4dESLOD5fsUxlYilwi4IfPViNvD+xVwAixJuSgKh3s5QolGAKIP4gIV6Jj8rUGhMr2mTi/ANKTWfInsor8xVGYKS1h0PbJCfk1oWk+hGhOxCTnCR1lqOEfwUGvKes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=n+oRqRqG; arc=fail smtp.client-ip=52.101.127.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWZ0kw3epscQktLB4jCiWDj5FdSbLQcLM0zi+YLLtTAuCJWMhugHrUj0jtklOd5GXJvCquX+1QcDx8ZyklxN2Zg72Zmc3sIo48Qixv5vAHaPecShmqNLjSR3AVdr/7/HBWvSlupHoG336A03waTK8gTotgl/muVtVhID5/LoBX6PO174lMV1XpuL56DQd4MI+IYFJpG4MV36aF5voJ3QaXv9z2nXizuuCT6iNzzvOXeShfuIZnS0grw1GjhYR43SjwaqHBBUte8Tkj/O7hjrQz5u5orETE0iR9FC+xFM3IokSpXppvPKyCI5XsIoCBONhNu1HleqHolU9EED5xG+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L0SB/Q6nHt4RXIwieBxk4aLW40FoCyZDuO8v3unmpw=;
 b=aXm5f48FufQ0/b4J5iE5Bg8ayWZrW7CWbhbG3QjyU39+1NT7r3BX3Hds9WpvQORcnvY/tlF1DcW9mxmBzb90t7pR+4RDjyEzm6iK04VtDU5tve9xe66CaTEPfQbcHBheN6Ya0S+5K4Xr69sASfmzvWXTSYklPVzLG1Wu+0+TjdISHCHHtO2Y/Zz6wwgk4jjScS3ea2QbRP7+HnyNnOCZOkIhdrKxQZ/8HdSNJgzNGRB1lRiOBoULdtvLkJ5y5OSyJAsQ5gDzBZxmfPfScqIUlAXdtqoitdlHp0lr3hn/2Dl5Pt7mwYCc0d3RN8+6E24nHx7WqARLWzVOjw6tk6eKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L0SB/Q6nHt4RXIwieBxk4aLW40FoCyZDuO8v3unmpw=;
 b=n+oRqRqGNWchFN8M3i55+UNX2AQa2MuOorJXjVB3cq8WvptPu3G9eoTGWJqecBLox6jGp58FrEBIFJVJ0iGjNehshTktxkyBYko8K+3nBRTzUh7qgBgrDQDcO5EPrSj7nfH766v+7X/xOynLzKHVULNFUjTy3XJ5geAH4pp1liY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB7229.apcprd02.prod.outlook.com (2603:1096:101:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 03:17:11 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 03:17:11 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sreehari.kancharla@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net v3] net: wwan: t7xx: Fix napi rx poll issue
Date: Fri, 30 May 2025 11:16:48 +0800
Message-Id: <20250530031648.5592-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0082.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::8) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a04ec3-4716-4445-8243-08dd9f28776d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sb/CAgSrkDRXrvK1jDfKci3v7gOJn+jGep4gGAbBPjho4zbATHX9fVzs63iV?=
 =?us-ascii?Q?DkcxSA2/32fvHMrnPyQe0eKHvSc7B6YIvqKfEyV4Bsy7CpCuTJzSpxn//y9l?=
 =?us-ascii?Q?x7FwbW2sVcASuVjxmUnnID3HBCqDEHNB2kF8HCq6v9gZjZHwxf/lc8W+ZPVk?=
 =?us-ascii?Q?GsoxOgKWMWY2EePvWjqub9u9A3JrTqT2vqPPhUZEGnb2e8vgjGITsaX8SgwF?=
 =?us-ascii?Q?Yup4cygwD1cbuw6K+j1Neyrz9MZ9bFqfi3pxBYSL5eB6+XT9vGj4tkLnjkqy?=
 =?us-ascii?Q?NVGCheRy97o4932aeIEWEi3QoS9LRehtF66QArz77HvHW3JAHCn/7PxptERr?=
 =?us-ascii?Q?nbprv3SlxdLQLxkwahreDMDQQB143s/vGajkrpMC5BYKsEA9iDnDGLFdYy+X?=
 =?us-ascii?Q?yqwIg0PY5IMPI938nhDsJF/46OvuEA3Z21cpcX50O4IqWImct5qghmu2ZokS?=
 =?us-ascii?Q?6QQAgyR2YP1hnjT5hxEADwJdh5lUHwNd26BL4tGHxFgGpx4MutUgowJziGoE?=
 =?us-ascii?Q?S5lewm3eKxK2bnnYpq1PY1yUvuHdtJIhqFxfwVm9aew1uIrLCgq+1g+2W2GG?=
 =?us-ascii?Q?Zway4PKsV5OU4zc+jAKEQrRPegUgZeGZkZK82yocvGW4PPalm8KIOwY401EO?=
 =?us-ascii?Q?I0ywPrWxFMQq0O2Z+p30RzkcjKP0lQNBSLeUoykFI4yGMxoPOMo57fkkJB+3?=
 =?us-ascii?Q?20JnQBp5BLEvZVDWMSXbgtoetTWYviZoOiN5K0w4kfDsukZjokuTCXacucX+?=
 =?us-ascii?Q?IQHPzCf5gP8xGsQmIe/+rY8TLH1DRrBIf3T6+q82nYkBfzIcfC8qk9eOWLk/?=
 =?us-ascii?Q?fqmM4EPhLKzLbrw1s7Yu+dW9dpMFpx+8+O0JcdWI83XJW1OlpkwYdQgwbTEA?=
 =?us-ascii?Q?7CpFFBPwqX7lhq67mFUSvrwaAuuiPxGFKZmHETS74I7BrrazNRLJGalMx+rn?=
 =?us-ascii?Q?uNKcLKVeyXE0lRC4/2uNymRvHvCKkzwwREdBpJHAWxiq/c3/VGi8px7X66af?=
 =?us-ascii?Q?LgwwiR6Ij/Z+N9OmTKBi8iOySbi+LhI3HfSPnl2BGPLFKWKev4dqdpKD160+?=
 =?us-ascii?Q?NTgOBiKQoBR0VXOzdYYCNwQv0JOHsl2uwfKtkFkeGqj6WpnRHihC8sRvydB5?=
 =?us-ascii?Q?bSKoy1+Ev01ycd/LZqlGw4YUQVD/DPWyxHXIJHjN/89AB+aF0EWWzBZbUYX1?=
 =?us-ascii?Q?Bqf44nTr2iSBgSM82Wqkwu6coA+mr83oXALjld6hr87DD1EVsl1m+sqobXFN?=
 =?us-ascii?Q?8RMfbjUeAXr2W3gw0fzuLm7PuZFdVfWc2dSC3hrweIbd3UkEtINt49UlwVFJ?=
 =?us-ascii?Q?r5EFxKEjLZetKntsfFULjK8E8LKPpPuqCBD5VV7mca1YnWD4249BJGqQ/JFB?=
 =?us-ascii?Q?VaLMdGXYr5Fx0C++ibeI9JAuxWQedume5kgxrAg+VCEKz7ueG06Y3uAAxAAW?=
 =?us-ascii?Q?y4YXZqlho8oBwSDKr8oX9zDd7JaEz1dWgWm8UwvTvA1YriunOpIbFEAIOxi/?=
 =?us-ascii?Q?RBXJarAhXRlErNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/x9/Ydy/F8LRGJByFRVypZ2x9O0NgSkEge6v319fMMLkpCd3gcfJ+/6JOcWs?=
 =?us-ascii?Q?eq7LNxpfztWfC1UOnAhIx7SDqKNYyajFZs/r2+QzxMCsn/fjzYRmZlaSZ3E/?=
 =?us-ascii?Q?z53e0ipLWFU3QXU8WuyfmpKFAPwu37mYcFUB/werXQbNll4+JxfRZTzZChWc?=
 =?us-ascii?Q?Xkyc+q8SZXPqaC19cwLAwUg4uvvamu16u4/wSMouH7RDBnmLysNubhUWeqlG?=
 =?us-ascii?Q?WpvK0J6XbUqqQ1orGdRlBJO2cAuoQzG4H79J7cZOtlmIPDUjuDJksGZLSoBx?=
 =?us-ascii?Q?dS3/PWc0o428p1atbV4I2W3WoM4e9FxG50CHvZj9EzlGVyTqMn60O07OgJsQ?=
 =?us-ascii?Q?rK/7poOHcm1e1/M/pU6LPW02m0zv4BQaSgnDM8f6S/7p6usgPcS/7dgAtjU2?=
 =?us-ascii?Q?v7RMKdOtjrlBAk6hd31S4dpJ892i39D9gIbjaTjd7+Cxz1XeKHfH1FQSPlIM?=
 =?us-ascii?Q?k0/XfENy/bjqJYoQ1/7nMv5NijSrcISovHYAvbENsCRshlJOAFOo4rrPaY5X?=
 =?us-ascii?Q?pNUNWvQptmDsHr3yWP9aag5AFZcicErlpAkoNeMCZayjioz7TvjFVtWvdPYd?=
 =?us-ascii?Q?UZmJ/Ca6OcjtPJEfXbFoRcoaKq18WIS9sbJV2Oo7T+gi6HXMc6pQ88P7RZZ2?=
 =?us-ascii?Q?wyutHUFRzpyNrae28BpyzGQQ3XwZmv+rGqyJRW754wapbtSqPvlOf7w1ea7f?=
 =?us-ascii?Q?UsfMMpKLB/qgaWVkzeJm+OfGSH6FiNqqLVEu69/AEOtwV12GBya8Wp+JfRcS?=
 =?us-ascii?Q?lJ3lctguJ3ImhLdi4WC77dJMT1QWg70qxSSKdlX2kciqU+Mz6E+LR4THt+N6?=
 =?us-ascii?Q?+eEXOfneV14q4Tx10ju8ahSxqp9hW5QEcOXgWrXC+mvfnqc4ImiOTEIctYJm?=
 =?us-ascii?Q?gmGqeHSiXt0Wf63EhkSmQZ8RjUSiU+oWVwji7OfU4avZqW80j0ihux2j3Cjk?=
 =?us-ascii?Q?sxnH7jQO4YbSWhwPKRb65Eb6BueV5ZRXfqukr6WiImlT34uLfgkTPd+s4Uf8?=
 =?us-ascii?Q?jpXnPpI9I0bE67hzOBez5NjY/SGCrgQgOAeFx1N44316QHdwYAyhwlsRafz+?=
 =?us-ascii?Q?ICeRpgMsD/JKfVBfqTki8N+jTlHUYQxL6GveawJzZmrWM5dA66gbnS+WDp+I?=
 =?us-ascii?Q?8/dKhmivfGoXUC8mI+qnKCBXGelGgyBVzDEaymmE6EmrEq7zSf9kgpPO7UL8?=
 =?us-ascii?Q?alpDzdrFsjLZNgSX0RMA2WDxm0SAvuAePpbGF3+rXS1T+dAnXrHm1QZCp3PQ?=
 =?us-ascii?Q?3DclblEqILcPm8hNxCFzeTmONyvBptc3KIrnoHIc7878HH0z4ZlFo/zQLmF+?=
 =?us-ascii?Q?ulVQVd5NqJmdLkFxZfUnHErAKCAETzVdj3afDI6i1ImEIqbqPWhOOeBVKRHQ?=
 =?us-ascii?Q?LI9dW2aG2bRE98Vnm7jUxJIAUF09fDIDaCOKwUHm4e6UMFqtNPkhsbEgPj+S?=
 =?us-ascii?Q?sYwstXrj8dG94r/iP/BIhleAwCWE70AyIxtAUZpmIx+2W1YXJHHsn0rZrwrZ?=
 =?us-ascii?Q?Y6clPMW28FYZ9BWO5RPzXAQ6OhPSYZ3obBss6H4UzWFJAwxHJo1yKG15of/c?=
 =?us-ascii?Q?u9i3tu9OU1yyglA0uM6rJ/sJf5s+k+1g5O5hEk26OWYDW8/SnIBYM31/rNn3?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a04ec3-4716-4445-8243-08dd9f28776d
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 03:17:11.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBip0CmwKsuyxFYeFEKPd4dR15swEiXzWgBxy71msFLl5v7iChbEEOVBGHshTvN6s8PJwG9jvqmzHV6Y3EYKKx0ydD/+CgVLwaHCNd2Tih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7229

When driver handles the napi rx polling requests, the netdev might
have been released by the dellink logic triggered by the disconnect
operation on user plane. However, in the logic of processing skb in
polling, an invalid netdev is still being used, which causes a panic.

BUG: kernel NULL pointer dereference, address: 00000000000000f1
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:dev_gro_receive+0x3a/0x620
[...]
Call Trace:
 <IRQ>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x379/0x3e0
 ? exc_page_fault+0x4f/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? __pfx_t7xx_ccmni_recv_skb+0x10/0x10 [mtk_t7xx (HASH:1400 7)]
 ? dev_gro_receive+0x3a/0x620
 napi_gro_receive+0xad/0x170
 t7xx_ccmni_recv_skb+0x48/0x70 [mtk_t7xx (HASH:1400 7)]
 t7xx_dpmaif_napi_rx_poll+0x590/0x800 [mtk_t7xx (HASH:1400 7)]
 net_rx_action+0x103/0x470
 irq_exit_rcu+0x13a/0x310
 sysvec_apic_timer_interrupt+0x56/0x90
 </IRQ>

Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v3:
 * Only Use READ_ONCE/WRITE_ONCE when the lock protecting ctlb->ccmni_inst
   is not held.
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 91fa082e9cab..fc0a7cb181df 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -302,7 +302,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
 	ccmni->ctlb = ctlb;
 	ccmni->dev = dev;
 	atomic_set(&ccmni->usage, 0);
-	ctlb->ccmni_inst[if_id] = ccmni;
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], ccmni);
 
 	ret = register_netdevice(dev);
 	if (ret)
@@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
 		return;
 
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], NULL);
 	unregister_netdevice(dev);
 }
 
@@ -419,7 +420,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
-	ccmni = ccmni_ctlb->ccmni_inst[netif_id];
+	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
 	if (!ccmni) {
 		dev_kfree_skb(skb);
 		return;
@@ -441,7 +442,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (netif_running(ccmni->dev) && atomic_read(&ccmni->usage) > 0) {
@@ -453,7 +454,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
 
 static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (atomic_read(&ccmni->usage) > 0) {
@@ -471,7 +472,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
 	if (ctlb->md_sta != MD_STATE_READY)
 		return;
 
-	if (!ctlb->ccmni_inst[0]) {
+	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
 		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
 		return;
 	}
-- 
2.34.1


