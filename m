Return-Path: <netdev+bounces-193918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA57AC647A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C7C3ABA7D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F0266B56;
	Wed, 28 May 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="C51BA6xf"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026024678C;
	Wed, 28 May 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420945; cv=fail; b=VkDIp+bJrJS3XTwku7pdonMHAdiT712lV+5lwrsET9hnGok16X8zfm/3vqfkTX+Y9qqPbGPx2RPh2vMWkWHGZZyCvdxaz9p3RU5yvjOW7XanbRtSdsfOhdNaC+KosLpiGREkICDcTOsu9Zm65kgJymkJHVcyLV0f8uhw3rAHs0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420945; c=relaxed/simple;
	bh=TCFTh4KtZ1gvS5e00YUf6X5vNCslAG4EuySuVq5iwlU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FWfoGCQr/AgXeoMb9AxrwRzUwC7Exw4dh6nkVFwQP6GLYZiT/DACVU0VrLIuInJQMlUF6+WVDKxetJZxjMktqSu1AlylNjTkhGf4AItpk6uoxYJXT5JmZavbmP+MDu3fJTCBg7Fd9UopDn568NoWrTL+rtXpwpiBwZTBLoQsZQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=C51BA6xf; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kgsn6kB462Re/keFhokIW4hISDl+2oxabBBh/7EXkuxwVxMNgGCAncVOssgcBQU0w1d7YlZ0X3EuigoYJDHIioLrw/IXsoFzbYV4a+zCCu0ZzXXimC1ZLi4JC1XHuv+pLHEgzAkMwU1YoApukWcwk76axjHfZsPrtBT8D6FK8LCqKXXKYYnkMJ4CEuwCrl+NwjWBt+oIMD361k/RloyZQpMjTkCStgnBs91xcVnSX8eNIHh5QjTxV6GCr6huaJUaNRMM81yUJdR5UWDnsk7Q0RRAORmIkXQLVS5wgRz17SFtthEaFralqFhGkryhirJzOweRbCiZQsvvtPRsNpFw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbnMMLdoVLCQg0WlFmP4cGGGe6/ZGh9T8wNo9YUbNs0=;
 b=jwjk8RMJH0ta2bIUbXq/+SG/OzgMBovOWjekpyh46N/ez3yDTmj+CvOGwu3TSTgZSfcepstDysZMWuf/A9W3lEADK8sg8jkB6aL6+bByCdHeMRJdHBRqEH0WSNYmgtqD/uu7+pd4pkQKBsCwrnZe1aZIVdM1/pid9uPUTjIcIg1X2H0NrFtRu3oe0lhfO7Y8SMwqqm26WiV4+ei1NurxAA1GR5pqN5OefihaOY1tQCWSov0iV7kuBXBLbxtSOwCerYXCuKbZcICWYxOmiGExNdLp22nrNzo4cj2UmpOJja1p/RzpMjlBcj4Xb5fRx4N3mfldbpcvLOT/I/Of3wksUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbnMMLdoVLCQg0WlFmP4cGGGe6/ZGh9T8wNo9YUbNs0=;
 b=C51BA6xfmtDuSyBJS1L0hshSxI6sq8QXe2Z4ToPF2WlKy1L3xfy83PXxQS5O87N3kv1z9tVjpx0tJ2NZ19GSbEEl1cJrebMkaQdiuzosLYldZ/3Rhx5o0k2vor+BvuYFD+/K5WD5x7evdhQVew67gFZNfU8+Q9uu7qo3T9Jq7vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by TY0PR02MB6737.apcprd02.prod.outlook.com (2603:1096:405:19::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 08:28:53 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 08:28:53 +0000
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
Subject: [net v2] net: wwan: t7xx: Fix napi rx poll issue
Date: Wed, 28 May 2025 16:28:27 +0800
Message-Id: <20250528082827.4654-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0077.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::15) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|TY0PR02MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: d946f2b2-ab9d-4610-c71f-08dd9dc1ad6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TucaBgMo1P4g3V9IETBtPqQdmEFvvgvIqxh5KCWkKrV0H+AIEysr0d1bBdAR?=
 =?us-ascii?Q?XHtxbgYPEzjN+Oc9oekxKqebtDhmtMVN34mTsoK/6wWwhTvJy82gzwizOBGr?=
 =?us-ascii?Q?B3pA7EcFq8bVsESmGsrJMkBmY3/SGQ5auIbHEJUUL9xNzYPoMDMFVMJfRSHy?=
 =?us-ascii?Q?0eaeHBq1e/CCXWY7vtOK75mMBpFT8er54+HF3EbD3esMCefmfriWGdxBClNq?=
 =?us-ascii?Q?62hW7kZwVOxjplLOAMqMUNn8Jahr/e2kPikHloi7pkojyWiTYRtNNlKBApO9?=
 =?us-ascii?Q?KL2l+TdA1uyA4l45jGpNHIs1TXp3S9SCK9Nmexjm/hjmWXLPHm0TquQpjtZe?=
 =?us-ascii?Q?vRgqvOSlnottu7wo+Reo5ZsSQ5RVVftAXmNpLa9K66vfoiah5mlQSS0eF+HO?=
 =?us-ascii?Q?tiFhNjsMAdHkspNKC0P/zP+4qiYned5rIdH1WRctIGcJxDLNPKVwFynR/q+v?=
 =?us-ascii?Q?mNkuZGtw4A+Z1FgbYekn8/feQbDd9w7zvWG0kOlq24C34PWi6uxhldhmUYdV?=
 =?us-ascii?Q?m8xrl7hWUarbHxXLKrPgriGPszFTXbp+Vc62MFVZdncnOy4VpWf/zxIGhb8s?=
 =?us-ascii?Q?uCVnNZ0b422oPXDAI1mR/7rq/KI96LSAFKos3dJjP503n0ga/ilS/p4CAhnr?=
 =?us-ascii?Q?28SyQv8f+yWX4Lg0V2bi6aX1TZ834sbQYu0zJV+CSOC9mF2W3GH2dRj+MHF/?=
 =?us-ascii?Q?5UAZB4kCrrhNRcpX+fZj5rL5eN7KSAuZjRT2dmPQNecGjk0cFBRzE0mwki9I?=
 =?us-ascii?Q?CAUQqkDf2WHOjVWJPvAYPpg7dW1h5Zry/mVDcBzLVD3fJgvxlwP4tCd6MKck?=
 =?us-ascii?Q?oQi3N8DpnNXVgB+PK+hJfGRtnzD9qJ0OL3luiiIcz37SIwUQ5evxULDRELqM?=
 =?us-ascii?Q?PeDb9s/kweySefnDBxkd+PogAQ7HwKZTCYfgvDt9aPQ1DJfrcdaPzIcoFT+K?=
 =?us-ascii?Q?DP+zEhwvzWKYuJ2bvaqXp7EuZkpXQSnerRcj3HXA9QKvbi5q3yoMfuBZmsuL?=
 =?us-ascii?Q?jiSWulMJFyuldS9DXKDb+hRX2CUEosGOjgWdqABugXk7/nAGI5kvtJMcQdP4?=
 =?us-ascii?Q?iFrXwi7Ztw3tCayPTqOqrdRYmdjXk6HXvMggBURliNI2vUz6xlycJUSl7KmH?=
 =?us-ascii?Q?hmUcoZpEUdMDddFgK0SIlvIVF3uSXePwj62d2jmtRnOxpCk8Teyj3f4IMKeC?=
 =?us-ascii?Q?wJ6kd7ajKmHypP/gRUuwc4yvyKLkPuormr0oHzegTWmKWMq5WaAZAvnKCJ/q?=
 =?us-ascii?Q?sAbAtCMfxY00tPAc10nMTjTGdeHBAf284+5WqaBU6cEFj2xc+ccEEhRfa93n?=
 =?us-ascii?Q?betQ2ArRV0OQzC2bq7YcKHGfaWKAOLBUR+tJHKOSAZY1PGJpvO9tXWMR3Ilx?=
 =?us-ascii?Q?b453k3lTqW0KBZ9Q6cG/zos2pJMVEBweQ+UQUlA0SplT2zgcYS4Ymr1CL7G4?=
 =?us-ascii?Q?fWDWPlIa3ZF+iLFZwHMj/MvGH8We81zNPjYpmCB8jOSKtNhCQZqj4gBMsfS4?=
 =?us-ascii?Q?i0fuGeqEBznGEjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJJc7yjoFYWlusw9cUN/4E0Jw155DExvnbvUAS3UPUqmUxRP2nq4uAHjxSL1?=
 =?us-ascii?Q?ON3KksIpJpZLoi4sUX1g+Zx62luGHcDugKLBzJJT2ukTDgZrb5/NKUag0Zun?=
 =?us-ascii?Q?FH+74NkAXXFDjhBkq4L8rGbvZp7zqjZPT02aDPiO0RrADuy7bn0aJVjr23SO?=
 =?us-ascii?Q?MRYD7QFAjHexAqSX27Va2OYwjZqlnTBgc7Ou+mQp++dWgMPBaBpZrEDyYYR5?=
 =?us-ascii?Q?cIH/DITam3YvhF6XZULxtb+wMdflQb8PVVdzagWPAiBuUuHlkUvVD2bFOGNS?=
 =?us-ascii?Q?/noC1Fvm4EZYVNijy0pdQNd9vb96iOQAF16Qhst/ZImWrH4MH/NEY0AlxKLz?=
 =?us-ascii?Q?t15m9ibCHKqPtdrrqzgGk+Yhy4z/sIjsn6PRr1nCrnsWEjfjnmx1f0aDUAmv?=
 =?us-ascii?Q?vwjQh2um+H3+Q8C3f5BLUvCHyoBMM8CkSZtbcOppAv2RYPUsYauBNJiivg4h?=
 =?us-ascii?Q?VURz2ZHTNQ83rZTJbsuQTsdSIvdxgd36P9QAEa7J6wMYsAvjhcjT3HWELGSv?=
 =?us-ascii?Q?CtScVpATu0SJkVjA7iCEKC0HJylj0YexvPfV/iPqwq/wvPefC6IVD3GPCqzI?=
 =?us-ascii?Q?wHJgNzW3ERrOuiBSHgs+4A2XCSN75PgcsTe9OJNnJYHD8s7H7wVoDuccte87?=
 =?us-ascii?Q?E47GKgcMIECvnHEjo4YSnYaFVbL4a2NqbUYB9SOa+MNYnhhGUtWqG+B0xd+4?=
 =?us-ascii?Q?XPzHls4fDZGfUSO7KA4ipdatE/GKCjJWXgG9IhAPGujYpZTsiVuD6K/yQere?=
 =?us-ascii?Q?tlEwfOX7TD+LZ38H58k5BetDTJ+7wPZ9CLNOSTS1xBpzZdeP/bQ4h5pIkDVP?=
 =?us-ascii?Q?RbHuzUhI1bHiYtDLIUvYiDsiN/BEiwa4owgGevrxPESrhHajWWjW/xk8Metn?=
 =?us-ascii?Q?cPYyLP0dZtD+U7RweQOJtA9DlKOj3VuzsPaK4I/oGKS54n3ZIqAcmvF3eGLQ?=
 =?us-ascii?Q?5WRt5Ay+eIetYxe58sWbQ6OkL/8tylaKsAptxPa3DBxy3gwuG4y8IoFwaR9d?=
 =?us-ascii?Q?lpuW9EadWDU/fHZPamjDHZEtHw4re6Jy/afSNPKKBJR88l6nQss1o8+NWBlU?=
 =?us-ascii?Q?ZkSGqsh4JwWsaiXobNA+4VnTgaeF9LOVNKvpqAjLxccMMJu7uyrkKvmLjmKz?=
 =?us-ascii?Q?VZf1RS8dao5F0A94WZqPxg9pHHyl/F3tiuqkw7V2SL90me5EltwHYdqs9LFk?=
 =?us-ascii?Q?k+VCdA9hoU1Z5ow7tRfcOirF8SBESO0S4miL3fhi51GfjStj5naEdIhmvVVR?=
 =?us-ascii?Q?eW0lAwDPShCTW6A0aFNAilx02h/BUzfbdwfzWdPAFqThms20Ld6Lp8txv8Js?=
 =?us-ascii?Q?5N+h0DGNPFgj0tHrBC6QlggxYkHMw7WopErimmF9G5pzeR/Vi5F/gtheYsLi?=
 =?us-ascii?Q?qMo/XYbK2s5319XDfqlaNe/Xoj5rmZScsjK4axHmx3oPhpzTvZyngDddRrPt?=
 =?us-ascii?Q?itHMZyBWzuQslEXuqPQa8x1FPPlqJlc0f7vC/3G5kYUzWItnj9wlA4SdglgJ?=
 =?us-ascii?Q?8Zp4ttAx8FFCvppoeldIU/3phxvbFEzUhbN57UmxwglmxuHOF4oyWYDjnWYJ?=
 =?us-ascii?Q?2BAT9eEPPJf49JNFdB2wI8f2C8NSF3C7Cch40IOLDNF0VaGvdTH7ttrBArom?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d946f2b2-ab9d-4610-c71f-08dd9dc1ad6c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:28:52.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZTqAePmsD7jCRaAcugtiVnEnt0P6TaKFtDCK7txjy5M6FlKPJEFYSpeY4qPsqqUjO148yw3EMnJL+MNy2m21QCTnP2KmRPQ48Zlw5BM4Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6737

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
 drivers/net/wwan/t7xx/t7xx_netdev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 91fa082e9cab..48007384c030 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -172,7 +172,7 @@ static void t7xx_ccmni_start(struct t7xx_ccmni_ctrl *ctlb)
 	int i;
 
 	for (i = 0; i < ctlb->nic_dev_num; i++) {
-		ccmni = ctlb->ccmni_inst[i];
+		ccmni = READ_ONCE(ctlb->ccmni_inst[i]);
 		if (!ccmni)
 			continue;
 
@@ -192,7 +192,7 @@ static void t7xx_ccmni_pre_stop(struct t7xx_ccmni_ctrl *ctlb)
 	int i;
 
 	for (i = 0; i < ctlb->nic_dev_num; i++) {
-		ccmni = ctlb->ccmni_inst[i];
+		ccmni = READ_ONCE(ctlb->ccmni_inst[i]);
 		if (!ccmni)
 			continue;
 
@@ -210,7 +210,7 @@ static void t7xx_ccmni_post_stop(struct t7xx_ccmni_ctrl *ctlb)
 		t7xx_ccmni_disable_napi(ctlb);
 
 	for (i = 0; i < ctlb->nic_dev_num; i++) {
-		ccmni = ctlb->ccmni_inst[i];
+		ccmni = READ_ONCE(ctlb->ccmni_inst[i]);
 		if (!ccmni)
 			continue;
 
@@ -302,7 +302,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
 	ccmni->ctlb = ctlb;
 	ccmni->dev = dev;
 	atomic_set(&ccmni->usage, 0);
-	ctlb->ccmni_inst[if_id] = ccmni;
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], ccmni);
 
 	ret = register_netdevice(dev);
 	if (ret)
@@ -321,9 +321,10 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (if_id >= ARRAY_SIZE(ctlb->ccmni_inst))
 		return;
 
-	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
+	if (WARN_ON(READ_ONCE(ctlb->ccmni_inst[if_id]) != ccmni))
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


