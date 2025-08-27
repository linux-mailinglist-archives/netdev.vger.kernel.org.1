Return-Path: <netdev+bounces-217176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE7B37AF0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652AE1B67F51
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282343164A7;
	Wed, 27 Aug 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JgHPqnzG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DA3164A0;
	Wed, 27 Aug 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277719; cv=fail; b=iKyX7oo2YRYfJt2Yw3yQUp9uAqT5lGEw+XmMNobL2Gfqo8UxfLCMhGoDVbkLi+os0VpOUfeQRWLKBIR/taySRez1Wb9FVXKlBn5lyEqbjx0LZOKk4Aw9Jma04Jo8dF7EggUPKh3XiKLs/Z/HOTH4wJpM7O3ZeqA4XZFjGw72e5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277719; c=relaxed/simple;
	bh=NifwDm3ZgmpDRdsHog7aeP/xEUGuq+CjpYvG2T43BYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YPiZz8jZOFxztt3qtEWkyCt6Ok6goY8M0FODQu+1I3VuICJ3Un5zlHjw6JDepqZ30FKDsN3IkjKupVlWxuG2NY7SZAWuKJYfw9YHR3jBnD3CtL5OKlzstiTMtHJm4BmWm7oYRlQp7PGX58QespEeUsfFPVUAdEXUHtWMk+na4VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JgHPqnzG; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgtG03h6v3Do57GP1r7QkPSmhylU0++p+901yLwNuRAmxXA+l+b6VYTk/pSKJI5BgNxuoLRSaaJo1quUE5ygRLJVpHsn3m4n0jLAPOmRK52dgql5LeiU1J05WoH/QlmN4Om2y89fHqqutN/1+jlhLg7szG945qND/M6VSV6Y34rAUx7JwtBLTzaNuZbFYaZQ1a4hOP9VonuFzogw2KPIYbwONTrvUoiU82ONzAVwH1YexdgxZzve6pK7jgI8hjd7+PVDyyCsSB7DSHK7EVevxqPidpEJivPsFodKXme/GHpMEZ7zXsRR4DDO3xM53Wwjw8gKr3+b2LH8DYa7EE2hCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGJUU8PiaeNVoaH3ryRsyVkC0XlvZdrJ1ep7SzYPRbU=;
 b=frtrG07QH+rI8AxAKNafhaPDAM/J9Rly2021oRhe5RsLy7QyFsDnpEeNpsdMPMqxul00Iaj+Htr4u6f5lbYL+fG8fsBoYViWys/tZIdA4QbhShil5Vq4H00KoR0cEOLoudiIEJWrDKDOt6Vl+toZ7zoZnk6xudJDajgRqr0hR7xcORf56W29bKrKAO2gy/1FUkE9iUpi5H0ME6VLr086jy9Z8UAW1T/AUFI8of9YiJr5H4lWl8L/OopYys3DGApfj1FVYzuRzJ0LMwmCbm8flnMau+helXjy0AEXR2IdhQLqljYxqcU2P6F+fqv59qaOb3Kz0Z93lrcVAA7EGXiw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGJUU8PiaeNVoaH3ryRsyVkC0XlvZdrJ1ep7SzYPRbU=;
 b=JgHPqnzGSEIKOG9MwKbOKHvcvzSrNC55pX4miFJgZpbyRVM64bEKZLOPO1CI7o8mEiTihCtpHqWkGZNFE6eCvJUh8UA77DGDwVmuz8NXgIa5dob1cYvakNr7Dag1HNLxKKttDGSSjjkutEsTQW/rv70w23s/X/8imolHehFK6psMid43VL3XFRdmNYWpqb3pRPD3i6t5QvMiQLzRrh2FofWzcxwUcVOmREkN9gc4kS+pi9JNVH2h/y1rwmoGTj9GterFonQL4cz6TKZOfPQvAxiU1pPsnUojVey2BWWEC0dlSSACxkYgiZYCQ37ZRFhF+zIKNeQ1scPh5vB1E9Y5jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 06:55:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop back the periodic output signal
Date: Wed, 27 Aug 2025 14:33:19 +0800
Message-Id: <20250827063332.1217664-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f18c1d-0824-4561-cec1-08dde536acab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQVTBr46mIcfG6l4OZQrUmFc2D4d6enQASuk61jERmd1i8k2YOiSlesMx6O9?=
 =?us-ascii?Q?kk6JjUBqYKawpTZAhnk8f+0CaD1OANFpxu7uCqMr+3XKtI/9dGHh7MN+S1P0?=
 =?us-ascii?Q?bnfH7b0GBunImj1jfBv0cvzBtQGRJUmVtKIL18ZevXDiqw58LSlVIAXvMxI5?=
 =?us-ascii?Q?TyyeztEnhHa33C9p8TRffVQeHBfpAbXPYwYXyOrL+TFYg1wBv0QGPuSwHtRz?=
 =?us-ascii?Q?hzqYAbvwrHYx8WbNHmp0wnkVTZA2ktZW9Tsfbh9zfVOMjssfrFtrURRChqLu?=
 =?us-ascii?Q?RIKMIk3IHXeUUr/x+droEG6/c5WnIY/9RYwI4AgTuq/c5P7YX5WD+RkS9mCP?=
 =?us-ascii?Q?Y8TEUt8k7VSdhn2KgaShlpSkNYmrwRBYLvbuRCs50kiumQkjz4tp1345gJlH?=
 =?us-ascii?Q?CQFo9g/Aa2gci1AdA7Boh+sbz+h7pvV1XpUPdRy5ZGHnwYvV1aE0gg36ym7E?=
 =?us-ascii?Q?W94Oze2U0Bc+dH7qciEWtK1ZK2OIvA5hBXMyxJsLeF2387TufbruNfn+ovCW?=
 =?us-ascii?Q?uNzHaWVE8BNxlvU6r94EamysFrJBXgRZcW5A/Ue5IxdqPMmO4rA7bcx8e/2a?=
 =?us-ascii?Q?LU/3X1sdPqDtxiXz9kALb9+3UvBolvHpClr8E1Hu3YOTidj24C8xzH++QoNO?=
 =?us-ascii?Q?aAGdVn7f3jFjNEPNiZGHHklIf8mMxGTfLDGy2ULfPkTlQPrVUxw1NRFXsUrP?=
 =?us-ascii?Q?kIgZJSwnO/2GyA0MiPrIXvyYQBpqgWb1X3t2npZtKGIindpVCBvPG3PhtuHL?=
 =?us-ascii?Q?wD6AlAX4gOSSRj8mO1Q0gPMO9orZoJK+IToI/NhobnVvFwK80e4dFAziem1m?=
 =?us-ascii?Q?WETi5srGTaviiidpEXG51Ex2RNc4IwGyN+q1XCLN6UYZ8Cy0v2E7iA7fnWLM?=
 =?us-ascii?Q?TALFGu+7AQAD92jhwQmOpzaDJpB3Skxvy+/Cud6dBjhf9d19LanoaXQLt5oN?=
 =?us-ascii?Q?i2PD3gLCcRYovBDYemBp2TO5m84Irvlht5NwC+l67xkIjLox9XoKz6bOXPr+?=
 =?us-ascii?Q?Jef3IswYY7oDTyLHo+BjupJkwf8t2OVokTc1rR859AL8+HjgWU00wxgDXxHF?=
 =?us-ascii?Q?07j0s5FcRTvpY6TRRhPAeNgtrsYhOOb+ZfzUakTabuRGu21FtuzXQjNhDJ2Q?=
 =?us-ascii?Q?8SGoNLgOAwCoWA7HRBD3gKgeswcn/q+ekqXdXXNrR9o1BRRLWvkkXlWzCrh5?=
 =?us-ascii?Q?lbgX09573ramS9qlUFcI2jtfDe1iAD80tuX+NWeB/wiOinU004sRmB9J356s?=
 =?us-ascii?Q?quiN9ocmfkKPYk8UVyzdNuWguJpIUhjcJ1aqcWiE9CriiaEClTs5ymQe4Ek3?=
 =?us-ascii?Q?RWr9ojNhQDN7ZLjE2XqZiLjgbqyFlAKDUYtg7LcM2ogDKAHM82dPRU4OMvxU?=
 =?us-ascii?Q?Bxg/47tHjdW4PeV2Powqe8S7zfRW+Q+xcNpxv0yi1ZjvhnggQq/cYCzqSYib?=
 =?us-ascii?Q?pTQeg0IOebFbNnjUbtbOiscLDyxDgln7cFWrbCG6mgSS/7l5TpRw4+MQ4QS3?=
 =?us-ascii?Q?oKVZrczTDlsVXew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzNlCkCVw6Phi+7i2LjYlnSUQiyrtQ/Hy344rtIju9BTiVspThUy1jHHQUY7?=
 =?us-ascii?Q?MYh5HWitSRH485nh9wF+ZJ5g3+y5SymU6tC76RtfU3EYhOzCsnSPyJshHPTG?=
 =?us-ascii?Q?TFHJ2vwQfCd4fRewNOcwWkDFUraQPMVcG8Es5KKS4t0CjLjNBNVAr387sT3G?=
 =?us-ascii?Q?qWvq2HSgtJHL9o+mYBeC2zAViudTvFO+z1nz9ubFX3f1ka4JewYVXecrF2LC?=
 =?us-ascii?Q?wMp9ME2mJGrX/a/8nPb+/aLBjIupMQ9B1J+ghjdpHKD1yoGTK7Oy3cP46258?=
 =?us-ascii?Q?GlnoOusGArRkWUkY5fblWkEKkfZln3TGBr64sff67CscSYFhvXjWWhL2TluD?=
 =?us-ascii?Q?EWVc8RM/LF2k9H7+cmv6NhTEdMAmkw4NmQ/feXNZhNYTt7EhJF6teuhcQUNL?=
 =?us-ascii?Q?NqS8/6WS5VLxtTg6bm1yNzMkMM01dtwh3C8fcbBGwScJu2x2PBqlUyBM2SX+?=
 =?us-ascii?Q?7zMno71q/anGPjfxATUq2QqOxLQw562zxiHpbFF8ne00Kg1DJgnyfsD1MWZ9?=
 =?us-ascii?Q?v7sS/s+QTBYkqTdCKmjz7Xi3rZXZ5fGSkEoPMA5xBq3pheRLfGAaLofuykaj?=
 =?us-ascii?Q?i9+g8Vr5ViZyp4dsmUzfKKj6wrE5d0AJ938GTpJIKzLrGRHMGQdHMgJbZAzW?=
 =?us-ascii?Q?ZzdJl/6LNXlzC9R+e3tCYthU1b/BATzGgnnx8MJe3153hvIIQZuhLNgEBPXb?=
 =?us-ascii?Q?mZ3xK1naXI6o+GsnuqG4vHhGY2zjxmc/ngsmMneK6Q9twk/DLU7xD7XqRJh/?=
 =?us-ascii?Q?eO2lIZuzZ04/p1NTOci6bdazN3ygtjEcH/D1n1DmNSrBoUuizROXWN5HdonQ?=
 =?us-ascii?Q?45unwU8fDZqhxYviVE56WEJaNcx4Ed4WQFbwImdu15nPNCFxrNpVrR9lNXRg?=
 =?us-ascii?Q?f6HkO6WrwulsGWyIH9V44yursnWTDJXsoI+owQMsqAZFhCauLgjCYFaXVowm?=
 =?us-ascii?Q?qiMbQXBVXw7pbowq7FE3q8OXKw1xMaZQbH8v3X2m2Y9DhDCiiVayCn/skR4F?=
 =?us-ascii?Q?tb9n0eQgeY8mzLjMVnPKlk1WYwY36Dbd42hdS2mzqcSYrlSlbXUnxNLWMpX+?=
 =?us-ascii?Q?TihuglK2eQXL+liz1GClcFvhOoKDPAvtUHGj1pkcToYru/hSn8P1tcB1Q7O/?=
 =?us-ascii?Q?0+eHZsKZwUkQnvy0TWeobjz5PP74ecebTkGPk7XkspiR2eq2dnJp4E4mh5hb?=
 =?us-ascii?Q?Qb+SkcmA3bKHJVkltMMh4GXN/97rG04LrPtTberk/Ndw/4vFzA0H+aqQI2LD?=
 =?us-ascii?Q?EyEeg5A8zdP7Vm2LfrdLtw+O71Eerx9LMObGIWSvDrhtdsfCzqF8hlBfEbf+?=
 =?us-ascii?Q?rwFIPVQbODhsHzHzOeknhPRqPruoZkTDoGZ4xlc6Lq4+Lz7a7ATXzBRV6CIK?=
 =?us-ascii?Q?gkY8J23QOwRrzbHs4QqLpl44/pNkHSshcaScuMQUgxQL3HDNyQrfpvNRdct3?=
 =?us-ascii?Q?nTZ1O/ezmM23ls6mP9JbGCXFk3dLSejSQpSwJ89XGnRLiLDmQOaproSBxgns?=
 =?us-ascii?Q?J4Q6aFEXJLmBF5RZGmDbwhsl4hvcntc9ugKUwRC2efGMi1XlFdkR+zqzMFCR?=
 =?us-ascii?Q?QNuugeCvipvXlfs49Tq++DeOVzuzUtg35HnBQ6Cr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f18c1d-0824-4561-cec1-08dde536acab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:14.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6ZRDGaanme73aq1jTtFA0aws++Kjlzv4BfvtchN6DdYfXF09ZOy6vgJUv7/JBY/g2o0UmQYDhgQF+KJmiOWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

For some PTP devices, they have the capability to loop back the periodic
output signal for debugging, such as the ptp_qoriq device. So add the
generic interfaces to set the periodic output signal loopback, rather
than each vendor having a different implementation.

Show how many channels support the periodic output signal loopback:
$ cat /sys/kernel/debug/ptp<N>/n_perout_loopback

Enable the loopback of the periodic output signal of channel X:
$ echo <X> 1 > /sys/kernel/debug/ptp<N>/perout_loopback

Disable the loopback of the periodic output signal of channel X:
$ echo <X> 0 > /sys/kernel/debug/ptp<N>/perout_loopback

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v6 changes:
1. New patch
---
 drivers/ptp/ptp_clock.c          | 66 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 10 +++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 2b0fd62a17ef..0a45c5ebd904 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -237,6 +237,66 @@ static void ptp_aux_kworker(struct kthread_work *work)
 		kthread_queue_delayed_work(ptp->kworker, &ptp->aux_work, delay);
 }
 
+static ssize_t ptp_n_perout_loopback_read(struct file *filep,
+					  char __user *buffer,
+					  size_t count, loff_t *pos)
+{
+	struct ptp_clock *ptp = filep->private_data;
+	char buf[12] = {};
+
+	snprintf(buf, sizeof(buf), "%d\n", ptp->info->n_per_lp);
+
+	return simple_read_from_buffer(buffer, count, pos, buf, strlen(buf));
+}
+
+static const struct file_operations ptp_n_perout_loopback_fops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.read	= ptp_n_perout_loopback_read,
+};
+
+static ssize_t ptp_perout_loopback_write(struct file *filep,
+					 const char __user *buffer,
+					 size_t count, loff_t *ppos)
+{
+	struct ptp_clock *ptp = filep->private_data;
+	struct ptp_clock_info *ops = ptp->info;
+	int len, cnt, enable, err;
+	unsigned int index;
+	char buf[32] = {};
+
+	if (*ppos || !count)
+		return -EINVAL;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(buf, sizeof(buf) - 1,
+				     ppos, buffer, count);
+	if (len < 0)
+		return len;
+
+	buf[len] = '\0';
+	cnt = sscanf(buf, "%u %d", &index, &enable);
+	if (cnt != 2)
+		return -EINVAL;
+
+	if (index >= ops->n_per_lp)
+		return -EINVAL;
+
+	err = ops->perout_loopback(ops, index, enable ? 1 : 0);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static const struct file_operations ptp_perout_loopback_ops = {
+	.owner   = THIS_MODULE,
+	.open    = simple_open,
+	.write	 = ptp_perout_loopback_write,
+};
+
 /* public interface */
 
 struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
@@ -378,6 +438,12 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	/* Debugfs initialization */
 	snprintf(debugfsname, sizeof(debugfsname), "ptp%d", ptp->index);
 	ptp->debugfs_root = debugfs_create_dir(debugfsname, NULL);
+	if (info->n_per_lp > 0 && info->perout_loopback) {
+		debugfs_create_file("n_perout_loopback", 0400, ptp->debugfs_root,
+				    ptp, &ptp_n_perout_loopback_fops);
+		debugfs_create_file("perout_loopback", 0200, ptp->debugfs_root,
+				    ptp, &ptp_perout_loopback_ops);
+	}
 
 	return ptp;
 
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 7dd7951b23d5..884364596dd3 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -67,6 +67,8 @@ struct ptp_system_timestamp {
  * @n_ext_ts:  The number of external time stamp channels.
  * @n_per_out: The number of programmable periodic signals.
  * @n_pins:    The number of programmable pins.
+ * @n_per_lp:  The number of channels that support loopback the periodic
+ *             output signal.
  * @pps:       Indicates whether the clock supports a PPS callback.
  *
  * @supported_perout_flags:  The set of flags the driver supports for the
@@ -175,6 +177,11 @@ struct ptp_system_timestamp {
  *                scheduling time (>=0) or negative value in case further
  *                scheduling is not required.
  *
+ * @perout_loopback: Request driver to enable or disable the periodic output
+ *                   signal loopback.
+ *                   parameter index: index of the periodic output signal channel.
+ *                   parameter on: caller passes one to enable or zero to disable.
+ *
  * Drivers should embed their ptp_clock_info within a private
  * structure, obtaining a reference to it using container_of().
  *
@@ -189,6 +196,7 @@ struct ptp_clock_info {
 	int n_ext_ts;
 	int n_per_out;
 	int n_pins;
+	int n_per_lp;
 	int pps;
 	unsigned int supported_perout_flags;
 	unsigned int supported_extts_flags;
@@ -213,6 +221,8 @@ struct ptp_clock_info {
 	int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,
 		      enum ptp_pin_function func, unsigned int chan);
 	long (*do_aux_work)(struct ptp_clock_info *ptp);
+	int (*perout_loopback)(struct ptp_clock_info *ptp, unsigned int index,
+			       int on);
 };
 
 struct ptp_clock;
-- 
2.34.1


