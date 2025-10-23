Return-Path: <netdev+bounces-231995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6050BFF7A7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DA71A01821
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97492D77E6;
	Thu, 23 Oct 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dWrcrAGl"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C032D6620;
	Thu, 23 Oct 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203795; cv=fail; b=RtRwfCl6lF9mGzSIbBwKQZpP6UatHpD8HuJraGtgv2q9PTah6XdFGp+coAxfHPi+vQrzcgP12b9qbmrSb+GjhIYN+UsclE0T/NHOI2H9QY5k/fBBpUPbzuEBgof2IhuUrFC1FYnSUgAypfW6xbEyrc3SAK/MxAZSU+48yCfyUFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203795; c=relaxed/simple;
	bh=qWe51aLin6ot6guVSVmD6D+ybuwLiwJYL1wEw3jVqhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSQL9qFpegqCFSeChsNEVL7WuILoIquuVtsAJUnns93n4dNOtXNmRVH+BSoD+YTPDMa7tqfM2if2VGJEK4gYoEQ6XH87k+pIrijN4HhHHZNCN3WvCFqOt68dcrc8T9dm61/nIE/84HgjMHBHwL4bSY4htnbz+AyluQUYdv9mYUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dWrcrAGl; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfGiVz36okFRug8Vk/dHymn6t0rGUY1dDZCQZDofXfQmzGZzqwlycQ6U/ypz+uzcexoRnVFbdlq4sAN63kxOQ7S9VEdxGzu9w47tEvnnFAnqTn9h7QJkJl4wPILHrRJ/kIKnMizGM0jZAMfrDR3AeGN4J1YtITkJ+XS0bs9I+fxaHDG9IfuNMpS6uinu92TvahHXObNhgx15QK+lB2UpLUcpfnqM4189710BMrACGgJ5N0h8/dAXgg7a+ZLARlUAW8R2SKVfpBK74Fww7QlWDdAftSgixQ1Vua1ntdJXSa3lSkKJWlk0XtY+4aLDRGfqB3B4MQ4ldSQfjPRG5ynlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxiqVhxrf4biqiifqrwXOZ5fQltK5A7B+XZXNRWG/YU=;
 b=WXZACsFKTk0vceg9AjSBmRAh9er9vEEJQyDWUXyeMb8+BYdJx9t9I+qlvSr9/sXtLH/9q+p5RBDj9IyX+Xl2Wbrqb//yeXXJMbDq77iYwXpSaeqBWb9f4nw0mBjP2//tjdwTB+gyJtJDuquAphaUS/UyOumyMqs+j8cSr//vtbonp5IL+k/bJ7kyFqMYiyyWlhRbxEr6Ny/ktnGxnGa3jRK/pQInFO9divjuwHyBVA4Ozrc7QruwU9+kSAhLSuJiHwKgHnp4UnLygE7xKnJRqEHYPM4VxUiTxMN99Q8MwCRbnk2YupGswcWTT1jswqWfApkULrtaAYbU4iW8ehttcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxiqVhxrf4biqiifqrwXOZ5fQltK5A7B+XZXNRWG/YU=;
 b=dWrcrAGlzIq9XMbthtZXiSa6/oq73QS8Z0q3efPfED5Uvv+Zncj+iEPvbcl82YaAfgFLYUuBnoiZv+nwWjbGcaJ8QWPxYbdaLQmhO5Tn3riDRTKgnbhnsj7ei/AIeycpE9erHmEtqStKc8atnIYrWfvULLw6HKYrn1G36G4Itb5uHDWKpdS2iikkgqTK6TZefgwCUaxNcNP3jSyLKb+cZfLS89wOFEefbyMfIXJzrOyNhNnExEFbIxq60pYeJhmWldLnKyfgUSkWK9xWxXQQVceS9VATu+ii9IQBriSp078fcd3xExN/54Y0kqY2+NvRvCmr67VTqEFQJv2qR75zGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:16:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 4/6] net: enetc: add ptp timer binding support for i.MX94
Date: Thu, 23 Oct 2025 14:54:14 +0800
Message-Id: <20251023065416.30404-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b967cf-7f3d-4c41-4339-08de120416cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwL27HAB65zs7VxUeLMuAf2KmSXT/tc0TSJO5j/oqdVa5jFPz5Lf3zbyLwBl?=
 =?us-ascii?Q?Zr67fLHYvFBApK0C7G9kt2zUHvZiiX/+asDRkQRy6WQBAqivoGskUSAJaeRi?=
 =?us-ascii?Q?flgWItYxzN/c4LHBcomHc+hqJ+Xz11LrNLn5RL+LmR2IEzEVrDtYB9oJ7PXs?=
 =?us-ascii?Q?PlZiTXSGIf2qxKkLOCbRLoNwbteE4BLM8u0+WdyDyDZwWDgpU5ChqSVvmQR1?=
 =?us-ascii?Q?p+j+unlCHdDa5JMUBqoEeVm/kYAMjr5gDy3Co56Nyv4PmTvgzSsMx9OaXpvf?=
 =?us-ascii?Q?Ep0hMf8HeImeBuniwFz1ha4/y99z0HDTW4P01QA03Ugn64WqR21CvEgjIw/N?=
 =?us-ascii?Q?wKchGhYAKY+LARzzbFNb2sHs3KkpTifpAAkJrtBCpw8gsX/jaSYM6J0gCwkS?=
 =?us-ascii?Q?/3cQOXSIM4LQrG1CHIuXuO+gbP9DTdB/tN+9Yux+jBLvyukxmT2s0o7WAMk6?=
 =?us-ascii?Q?eGsz+wkKGIE4CtSqo2r9i4PTC7g3vzyaCQOHzQUcUnI8tftrWIeZn//MNZ8U?=
 =?us-ascii?Q?yrs4OZzz2xqYPnTYNDQeI64+57BHVnoEkax1qZavPY4YE/yXmSoer6PG2MlT?=
 =?us-ascii?Q?eyJaPSBhP/tUjhaH6/XFgzywJbiuoPNMteewJ9fHj1lV7l4v5Xac5H8YLG6g?=
 =?us-ascii?Q?eMc6ZAlkms/F0dHcYAtLrocVkZPNkPGq8id6NUAm1T/uoDySQ1lpVVB8iX37?=
 =?us-ascii?Q?un6TubDlcm1lBSvrzh+0MGbIibPqOeGHxFt0ouZJxWleNMzXL+xG7JUNoSn4?=
 =?us-ascii?Q?grulB0yL4kDdSvqJtfmW5p1KUjiP+CE5saxUUKOcviOgfYHIkbN5Sg32N3pd?=
 =?us-ascii?Q?p0YgMTCtGLDjBzkFP5Xed88l1iXV+dd6Kp/UO3bGCx6mw5zWZT3ekP7JSvFo?=
 =?us-ascii?Q?Zv1gpmjFyWa6oBGvULIY+e5uB1SruyD+56YTa8jNJYqrhIu3Fk88XDJwBopj?=
 =?us-ascii?Q?twYkvyev5lUQdqXM51TTWfqm2P6ruvQyKHH3tfmnEhpzHaZfU2/o4Rd88uHW?=
 =?us-ascii?Q?OVCrwq0qSUG+faTp+UPCUhGtpkRjKaCi13jOpeWeo7ZNllQjAQl9gy2KjiGi?=
 =?us-ascii?Q?gey0usVS3aMbcBzFW7rYy9r9ynilfjZHt0vaqAd2AdCrGJNnwsId8jUzI1yd?=
 =?us-ascii?Q?c+ejFT9e+Tc2wGUCM9rPFehdPNj/vxbxLPWYe1ka/4ehVDZv8jsL5vA+gF/N?=
 =?us-ascii?Q?2NDiTaQ+rh60h9u+lmya5ZewI9ryqYeIs4C3HX5YKW9Gvqikxy1skwtIX+Lc?=
 =?us-ascii?Q?kZXEO09bZCmvH/H6kdH48752oGbRBV9qGIkLKIJy+wTPOs4SxwUSXxPj/hLJ?=
 =?us-ascii?Q?Vmdu2yZ8uvXX7LiEEwWOcfGIYERwYkGCkUC0nsH/GDQwZAMuio3/5i+1e6zJ?=
 =?us-ascii?Q?Bd1hKC23HbzH4g7jy/qnQm1qp+a5pFh0rCHgSrVaB7NpxGQZgipRnspsUZhj?=
 =?us-ascii?Q?FZedS1yQLGlWzKoLaf9OD90wWjwqhJweWxiK84z3UQeVyZ4940G39dGM+XOc?=
 =?us-ascii?Q?+2kSpALLrABzUcK03ohwc2S0mUld5+4lhvDPEArYIlhTXTO5EV+Jqke67Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpjjj7zLT9vvGRxXWTCegIj5eRWBnpk9KgwGrytjeUpfchHyfHe4v6lG/kOD?=
 =?us-ascii?Q?KeGeAANcneItjlbqtA9B+ZB2XbWAe2iPIC+POgRm8lVlvMy9hq7V76dRvdZD?=
 =?us-ascii?Q?OD9x8OEFjQRyStbfo39AbhNOzlFvADnmP+YS2crZyXgOVL52GCIuX4MQk6Jy?=
 =?us-ascii?Q?nefsUdvvEJUuIIJXzEDeXGpxrDUYat8Z0uGWsOrpKlhGiS2V7ef/zQ5m3t1p?=
 =?us-ascii?Q?LBYnfPqEEd2c3YFhx+ztCMOqxT4uxhyEyO5qPfe4aizjNNK5nOsEsmUfU92z?=
 =?us-ascii?Q?10FbmBbmEkTTiJgmddgn+Xo07wpXglB/kGjSdAo+eWe6nWtSoa768BSGuKRW?=
 =?us-ascii?Q?hPy0H8Tj8QoFkQHCrajyBzyCPRMKgTvcHcSTWHtPEHFFExjMD3we2TnGdtzM?=
 =?us-ascii?Q?3vf/ZJqT2U6bDF0mQGKyYbid7rMKBm+Av/SAIMYRMuVAutGYDn8xKgU7I2EQ?=
 =?us-ascii?Q?Fmji5U2N9RSZHsG9jcyulkd1dpLiX4GZDGv34vFeaxEe9WCM/pb1hEHpDC16?=
 =?us-ascii?Q?CuqBI/z+AYRF947O9xSCdpwTG5fW9iaTBe3eVjoo9VPj1ZFPGtr0hqogITpw?=
 =?us-ascii?Q?BswKF5c/7DyCcQvUCHFIhnuK+u6SfDE5abXi+3IqEAlNr/MMyuxuliK2z/M2?=
 =?us-ascii?Q?FcUxi8IvP+yXzcbqEyCjUUyfSwisRXygWzYYst7812Uqk7wPusZ8TM+8iCzL?=
 =?us-ascii?Q?J4gqgGsqd9yU5HJzTNwaIt3vV+iFhmPkAMOIvR68eWxtOmB7RRZCNit4RvM/?=
 =?us-ascii?Q?KUMqSdniBdskBm4ISsyRqyf7tyTIbKi0cccOdh0X6XELIaruuGCSL9Y9f46A?=
 =?us-ascii?Q?R9TZOwuoxchSinw7tqP4udwmmRNZrqa7fkq9kmb02TdvQm1YL13BthQEbaf6?=
 =?us-ascii?Q?npWRysCeoFQqJrH7UmUylEC434By/Kk9TuKfwU0w0E7C+8w1z67gKur3DGRr?=
 =?us-ascii?Q?FWPRtJufifHzC3V4/3clQWaB/0z2HHTMKsEP++TNK7Naq+xWVP2Qbuv7Rr8K?=
 =?us-ascii?Q?hlrp+uWSzZUuj0vqm+PxlV6mRkjlbp62b+KQQUcRI2A/ojY2Xc9sWwtQ47Cf?=
 =?us-ascii?Q?05GXfU4KWVi27FiO+S7/dAZA5I8ASVR2/86E1iJYkzo867hvKf+cUDEvl9JO?=
 =?us-ascii?Q?hKXn6ALjWRYZGToZgqMFjiSvMUa7IxtxBGiyaMaMmn6b6Y7DKcdf3YbVgz1a?=
 =?us-ascii?Q?29VLc3oOjrTz1FUmzD50G35Xbgc/Bv+dmGVGbGs1TOKg4IFDArMe9kusYZ1t?=
 =?us-ascii?Q?H2qXcV7iHPq5FtYXp11If1VwGh81lOP/L5TyJ9x6JAkZfAKWErcFHiJ5YQSj?=
 =?us-ascii?Q?tnZ+f/5RJblftNytwy34+Zzkcx31QBW9gpRRTt+zAdtNlvfiZnB3/THItjkt?=
 =?us-ascii?Q?sIx0bzZPmDTea9Y6Wbtvm8o0Yowko9vaze1pzWmf0+Xf2vi9dLqdSKmbMdtF?=
 =?us-ascii?Q?GxbIxym7CB28QPTc9vNvOu4EzpMH4qLrFeOkM39BthF8+TlINBG2x2RtMPXF?=
 =?us-ascii?Q?c0z8FQqo53f6nB3GSyqBAMU+/EcmT9cnYQzDy0cv5KHl32f0RZGwHmt/5rAZ?=
 =?us-ascii?Q?APiFm9Z6Bo1Gh88SlDqsWIGzLKIIjGj2ZbCMcyAo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b967cf-7f3d-4c41-4339-08de120416cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:30.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trazn53E5M8IZ8YRA/hl2/yVCYd2Op1K32CXXUyaalkUepRImqT3Jgx3YcgdGT22FQR/sSqCbkQmJRnMIBoXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX94 has three PTP timers, and all standalone ENETCs can select
one of them to bind to as their PHC. The 'ptp-timer' property is used
to represent the PTP device of the Ethernet controller. So users can
add 'ptp-timer' to the ENETC node to specify the PTP timer. The driver
parses this property to bind the two hardware devices.

If the "ptp-timer" property is not present, the first timer of the PCIe
bus where the ENETC is located is used as the default bound PTP timer.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 5978ea096e80..d7aee3c934d3 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -66,6 +66,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -78,10 +79,16 @@
 #define IMX94_ENETC0_BUS_DEVFN		0x100
 #define IMX94_ENETC1_BUS_DEVFN		0x140
 #define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_TIMER2_BUS_DEVFN		0x181
 #define IMX94_ENETC0_LINK		3
 #define IMX94_ENETC1_LINK		4
 #define IMX94_ENETC2_LINK		5
 
+#define NETC_ENETC_ID(a)		(a)
+#define NETC_TIMER_ID(a)		(a)
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -345,6 +352,98 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_get_enetc_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return NETC_ENETC_ID(0);
+	case IMX94_ENETC1_BUS_DEVFN:
+		return NETC_ENETC_ID(1);
+	case IMX94_ENETC2_BUS_DEVFN:
+		return NETC_ENETC_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_get_timer_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse NETC PTP timer ID, the timer0 is on bus 0,
+	 * the timer 1 and timer2 is on bus 1.
+	 */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return NETC_TIMER_ID(0);
+	case IMX94_TIMER1_BUS_DEVFN:
+		return NETC_TIMER_ID(1);
+	case IMX94_TIMER2_BUS_DEVFN:
+		return NETC_TIMER_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
+				  struct device_node *np)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *timer_np;
+	int eid, tid;
+
+	eid = imx94_get_enetc_id(np);
+	if (eid < 0) {
+		dev_err(dev, "Failed to get ENETC ID\n");
+		return eid;
+	}
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np) {
+		/* If 'ptp-timer' is not present, the timer1 is the default
+		 * timer of all standalone ENETCs, which is on the same PCIe
+		 * bus as these ENETCs.
+		 */
+		tid = NETC_TIMER_ID(1);
+		goto end;
+	}
+
+	tid = imx94_get_timer_id(timer_np);
+	of_node_put(timer_np);
+	if (tid < 0) {
+		dev_err(dev, "Failed to get NETC Timer ID\n");
+		return tid;
+	}
+
+end:
+	netc_reg_write(priv->ierb, IERB_ETBCR(eid), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_update_tid(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int netc_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -441,6 +540,7 @@ static const struct netc_devinfo imx95_devinfo = {
 static const struct netc_devinfo imx94_devinfo = {
 	.flags = NETC_HAS_NETCMIX,
 	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
 };
 
 static const struct of_device_id netc_blk_ctrl_match[] = {
-- 
2.34.1


