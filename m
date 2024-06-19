Return-Path: <netdev+bounces-105030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEB890F75D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D781F23705
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241F15B111;
	Wed, 19 Jun 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HtrO1/Ls"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39415B0F5;
	Wed, 19 Jun 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827573; cv=fail; b=lAS7xAI2gmK2fZAj48e0RIseF6l1TUmnIaTUEPdSb1ecgsm8d8mhm6bmVI2gm05t2I4jiUVF0vj1Sf9AfD+rOFVLxAWk8h207Fy357wt6I6wYCl7DJ2h4B7ELPj9NkGnNX+yPZwoqTml/PRunL7IurKBIxOkVe1FABMZ1KUkzjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827573; c=relaxed/simple;
	bh=MD3aduFtM8YDfdbOzqMugdXPqpHKeB5bjNVWrdKs+P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZtW4u7mpsch93W9+9fY1RgfuBTGsyeGj8+0lHle8h899NNlSHZfxuO14RMS7Z2YilQZmik0zWPHm5wW9aEoIImZF41hd8gonEo/sDRZWHAU93j9bf1KjCnZ0D+GNUBFQGRImkLndCygOwxkj5bU2ufpaLW/skuXHEhwsiSyC8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HtrO1/Ls; arc=fail smtp.client-ip=40.107.92.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA7YN14xVNfGEl+dZY/xMtW6xqIQvJDsLFbhqxsek15OY4xcIfRElxYGtKoWSNQy0Bm38Bp+MV9tcI6zUnxzoahwUulidFwzElkXTTSVtD8l3Ja6RyoclKeovy6t25ZfOvT7k6d1n/9Sw1sSPbX2EkxUHAc3XdQDoUCT0Ycf1C70cmRJtPYBKQpqibNrdP/olwHcl+BSrsK1HmRJGHXcthP1+rLAip2N23Yah91ORtQDJLADegccK6Kq3snWUom7YZRXGfOTweKci/RGF/+mJmhxWiihqtuzSDoa6/m4xFrd2JnYe2LVVeAulPCNJ4x46PqYNBFzID8iS+XTehZoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8XzXi4rhxKpjCO2ThUnfcbdGwNj9rjEVQ67SP74qPk=;
 b=BjYmyFgVrwAY2j2OvMLPsopfk42sg5ZOptw9XYhWcNXpaklrvwyxhBPi3Q4zksKk2R4k+rvNgIZRz7b9RuNoUqerTpHaXybgWC7avG/S5kdQ7XoGULIHNzdbVm+ItXYQVo94i3Y7P0FcOYM28dGQxXmf6fw49bGOktpZNlVUD6zO1GQC1DEYQ0ocm48U5LsoLLnNejVRLoO1zrZFREHy+TG5ZHvkaNzcbuOCEhnnlyttR6lJn5ZDqGsGhbEErAyLsXMLAlulSQzyjDMP1zcaKIxDLZayYiiCWKuYGZTW9g9gEmHtYqBFu1WZDo9tx4U0Uc0M0yBaMma6JYx7VmzIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8XzXi4rhxKpjCO2ThUnfcbdGwNj9rjEVQ67SP74qPk=;
 b=HtrO1/LsHlE0RMT7WzJO0z5nFA2+y3RwtG3ZbBKIbuFcTzo/6DIhFUcmLsh8f572snuMHKdWYVLz2SSufcV9HIHOPreqVtEH3wQYa0b562pry7Khnub8jN9L3oq7tkJuNJxHfeb56+BD9HKLx7cV9O/YEEDIKka3twdpES1nRzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB7086.prod.exchangelabs.com (2603:10b6:408:14a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 20:06:08 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:06:08 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 19 Jun 2024 16:05:52 -0400
Message-Id: <20240619200552.119080-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619200552.119080-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 12795b17-8dc3-44bf-c9f1-08dc909b424d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|52116011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43RmKor4UlpRqhTnlEoyegpmsStSUdABDfXHiIKL8GjCovMJShaFuQuaTdzX?=
 =?us-ascii?Q?893NvWOUFDKtT5se3VQkCm1mFqWG2qcsvMiBgv/lddPqYYttKETOMrQCkkUM?=
 =?us-ascii?Q?NEhpnPEVl9ZLnGJfNwo+NZP8W5iN8iZLzmyJ/jnD+nA/G5rW5eqFlUpv4QCG?=
 =?us-ascii?Q?HPcGv5+9Q0nAUPP/rusoTInbISdsneJMRxerptsgQMIGmvt6gImGOE/+vXtb?=
 =?us-ascii?Q?N2jBgqPwQajW+QArYShQnRmVUKwxYE8AkNPL8Lfx6LgSMkYo+U7nX4+SLIFo?=
 =?us-ascii?Q?ESuWZsryBhaDGVk1R9vzLXKs4PwMYL6vBiabaidw8eadWO6kqYL3/au//X0+?=
 =?us-ascii?Q?84wExaMlT4Qkt/B6XKd52a55eWZVu+TRZohEue1C2EnxyLwJtY80Ev2xP4+d?=
 =?us-ascii?Q?OlWam3/XK0ETuFUytfwvzMS9ilslzxe5bisZ80/Nr+6jTNWY5xY7d5+UD01/?=
 =?us-ascii?Q?wN4LrFDxkxjw8qv3or5nfnvuC5HxDAQMEb0WEbVbzjfYXBQI0PqdEyUOvQnx?=
 =?us-ascii?Q?EwJlnQ5MzpVSpUXoUO7g6TbH27bhArSUogZA+pwhZdPATZ8kuspg/oZPc7Mx?=
 =?us-ascii?Q?Ka0LSaLyqPnQ+9AFHvR3+8TGSpCx7e62dWepg2b2f1MXFN+jPXkEQqrnbaFB?=
 =?us-ascii?Q?dL4qzC6A/L5l4Z5IizxuQ8kd0aVlODLYeyO7ouOuUZNYRj7cmbUHRiu7izGq?=
 =?us-ascii?Q?L5A5KDdS2XeH7LyzD1ODwnMrzDpwJjuTfY2SL5kP4d8s1HT8wjHVTUGYi8Y0?=
 =?us-ascii?Q?Zwi+gCYNb25obHlDlqmTSwdeR1ziPiL29vJBVKGp9JI3570RJARKwP8iy6Nr?=
 =?us-ascii?Q?TP1v4RNMwbPSTLdQXPWYnjwCc6tAxUc88Kr3Me/CBfYPIsZ9Nb9EZT9aw+ca?=
 =?us-ascii?Q?7QZWt35cAWPBMFNt6FdBMWrurjSKbyzKByIp9WfxriYm3aqYZxi2wTxqox3C?=
 =?us-ascii?Q?JriFcl/HUyR95PeUn+k1/JePsQoK6UW5cHqxjaDuUirlRK8HxXRN8VNo8wNx?=
 =?us-ascii?Q?2JC9PmEjudVVEBonCmTPGZ15Vx/WQJhZ7+YZnHe7mCBHg5r2pcyEjAifUxlY?=
 =?us-ascii?Q?5TqnQBJthslWwS+uoiffHvDcSFpLN3ryUiVTpjtaVnAxEVIsbED0HL249tXa?=
 =?us-ascii?Q?Idvvd6u43sDu3X7qm+WWIpry9dvnRPRZII6T+YHBb3f6UQHwhUGbR6llU3H7?=
 =?us-ascii?Q?M3kwmLrxfZhcJJX4IpnKvm4o2u9bDsdaSXTx69QfpJTOYfoABUMML1opnjcO?=
 =?us-ascii?Q?fl0eWe9oDZjq/Fo2o9JoQ3xHFok4sFRvG4NKxJH41C+sXRPzW/UFZtsnXXoz?=
 =?us-ascii?Q?uS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6sUx2Pu6hbfovtN9TuX5/LOq7oocuQRO+I5Am+NluxRE/YwycOitNZv1+4+?=
 =?us-ascii?Q?BKllLXg93ppl8plnvN8UdUEiIiaPsecMYNQWtO5UgqTuKBEeMDfyelQrQY/d?=
 =?us-ascii?Q?RlQIUMuXWcg3XnOnmytlpvLzmdHTaHiyx9vHCzs+759faSBS7eGyKTpXkuGI?=
 =?us-ascii?Q?YDh4F2pP52Vk+cf+edD0q4XqkuaKRy0NvMNwY9HnKgPVX7kwPvnykMIcoM0W?=
 =?us-ascii?Q?I2zRve71EKm+EozaFQgcdy6S7Ezoojh7lvwjplwQ3D952i6n0rBASK4x8cIJ?=
 =?us-ascii?Q?Ch9oykaryoG7rmHmKM/qytECPPnVFZvHsak0X/p+RSugHUCdCAuPBQ4Fcuxr?=
 =?us-ascii?Q?uoESjpL4rMeLw53GHRc82/KAPR2/tpiCxmmSOxwdKCQpxgwP5YTqAilu+9C/?=
 =?us-ascii?Q?CcCMrAQkWcKWpp/vWcxn2jsQKY7iFEsrW6s7ZCOtZHmAWUPtYC1TFpuFGQ+v?=
 =?us-ascii?Q?Iov0gOhdmYNm694bcdjqqs7GbEmsVsLzbjVJvaNn0LbSLKaMVVrRECUCCXof?=
 =?us-ascii?Q?5yfXUS9DvTu7UICmntU+9MzrPZN+zBXLGCe1vJ2bRAzygs6A+hEZua1RupuM?=
 =?us-ascii?Q?E2zUYLQwfWMxgQy3fS754m2SD6Eao+7tvRQpAD9TlNzQ0oiJ+k/5SXgPwZgo?=
 =?us-ascii?Q?3AXNW58h0WrkFFS72W+LYHkHqUODPWOKN0yL7ehdXXfhs0Na2u6QwcxV1ioz?=
 =?us-ascii?Q?KKMXwcupYL3wMKad8QMq/o0ZdecDA2+DV0cOg3MWMHeiCmSG4v3kig8NH1ZJ?=
 =?us-ascii?Q?67Uo9/aS4C4DRodw4mmztEcpebcdpf+fgO1Lypw7jv6mYNXLzxhUaiFuJyW4?=
 =?us-ascii?Q?vdogKHzAwbNPe5JTNMjBloFbMZUghi+cVexgE0emHJXylQDW0N+Br4Mer/ZT?=
 =?us-ascii?Q?fcR7F2ARSVEZaUYUopEsCSMepwPu+8zzA3cMMnePYjOTVbL2bihGCVRJZpjt?=
 =?us-ascii?Q?wOhKl66b3aq4reml4aN3ahT8d0onQHXZrEctSz572yx5J0zywnamQbDXCf6n?=
 =?us-ascii?Q?XNooVYY2fYN3hbOsQm3o5uXR19GD4+ZknnUSEWLqfN+LsrfNB832CeS58vUL?=
 =?us-ascii?Q?J1aCHu3LoLce7M0ChL2F7ysC6D7rt/p7xqH+1qoLwPdX8p9r51TMaHQ1Jteh?=
 =?us-ascii?Q?4EUjEIVTtudnaj1rq6h+JE19WEvXP3WJZYEJNGK054CrdmS2XF66Z/G74NSl?=
 =?us-ascii?Q?EJ4jUMjxXtHk3PoZfvR7PnMEIuwH1LJbxPoUSsP+/1noW+FmhZ+ZQgpOK/Tt?=
 =?us-ascii?Q?tq22w8WJnaURsXRc1SIjQ/irFmZHq/e5RSvesy2fNcCoBvS3vU2vZ09aocKn?=
 =?us-ascii?Q?dTzqoC9m9U7fx4+yDV7tlzjdZ+bWbggupPGpcTi/o0VOtw0BMJWmOD2btVqQ?=
 =?us-ascii?Q?fU6B1c1876zFPn+44rXi1rt3HqJ5LRp72/DloJVksmR4yaGJ5+XRrdni9i5B?=
 =?us-ascii?Q?rW+no98GazyXfejpuvOBiZ7LBQhoLdeY90Dp6G80tNGW+noTS6GVLGeFpfsl?=
 =?us-ascii?Q?nMtIGXiq6Tm1EjV01Eq1HmI/eFwDaZI8BBXdYi+2aufY6hyLbqSi3i6Xy7FX?=
 =?us-ascii?Q?i8mj5vma4IXcj8Fqa+W3l9l1B0l4XbFsS2byx/9osodG3lvnqJq4ORB9zAJY?=
 =?us-ascii?Q?lnWqP2LOxHwaKXYdl/57y7qB8aa229wteogMrxUDPQ/+NPkiG3Rw3/yQDm3V?=
 =?us-ascii?Q?5Znf1qlbjtan6lcFjTyDUlwqprQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12795b17-8dc3-44bf-c9f1-08dc909b424d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:06:08.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/TVbrfS61PELIYuNjQGlU+M/JeheicXT13E1xL9EQR8Mqi/P8N71FiDfbN0Xan1Vwm28fGf4EujZWCvgP/sWOoKc7UJoYXRI/VtnYHDKtDjSEEXMv8rf8K9D59+ZYU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7086

From: Adam Young <admiyo@amperecomputing.com>

Implementation of DMTF DSP:0292
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC) network driver.

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 373 ++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index ce9d2d2ccf3b..ff4effd8e99c 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -42,6 +42,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP  PCC transport"
+	select ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  commuinucation channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..1ce9c58099cb
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define SPDM_VERSION_OFFSET	1
+#define SPDM_REQ_RESP_OFFSET	2
+#define MCTP_PAYLOAD_LENGTH	256
+#define MCTP_CMD_LENGTH		4
+#define MCTP_PCC_VERSION	0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE		"MCTP"
+#define SIGNATURE_LENGTH	4
+#define MCTP_HEADER_LENGTH	12
+#define MCTP_MIN_MTU		68
+#define PCC_MAGIC		0x50434300
+#define PCC_HEADER_FLAG_REQ_INT	0x1
+#define PCC_HEADER_FLAGS	PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE		0x0c
+#define PCC_ACK_FLAG_MASK	0x1
+
+struct mctp_pcc_hdr {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[4];
+};
+
+struct mctp_pcc_hw_addr {
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct list_head next;
+	/* spinlock to serialize access to pcc buffer and registers*/
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct pcc_mbox_chan *in_chan;
+	struct pcc_mbox_chan *out_chan;
+	struct mbox_client outbox_client;
+	struct mbox_client inbox_client;
+	void __iomem *pcc_comm_inbox_addr;
+	void __iomem *pcc_comm_outbox_addr;
+	struct mctp_pcc_hw_addr hw_addr;
+};
+
+static struct list_head mctp_pcc_ndevs;
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+	u32 flags;
+
+	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->pcc_comm_inbox_addr,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+
+	if (data_len > mctp_pcc_dev->mdev.dev->max_mtu) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
+	if (!skb) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
+	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+
+	flags = mctp_pcc_hdr.flags;
+	mctp_pcc_dev->in_chan->ack_rx = (flags & PCC_ACK_FLAG_MASK) > 0;
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_hdr pcc_header;
+	struct mctp_pcc_ndev *mpnd;
+	void __iomem *buffer;
+	unsigned long flags;
+	int rc;
+
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+	mpnd = netdev_priv(ndev);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->pcc_comm_outbox_addr;
+	pcc_header.signature = PCC_MAGIC | mpnd->hw_addr.outbox_index;
+	pcc_header.flags = PCC_HEADER_FLAGS;
+	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
+	pcc_header.length = skb->len + SIGNATURE_LENGTH;
+	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
+	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
+	mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static void
+mctp_pcc_net_stats(struct net_device *net_dev,
+		   struct rtnl_link_stats64 *stats)
+{
+	struct mctp_pcc_ndev *mpnd;
+
+	mpnd = (struct mctp_pcc_ndev *)netdev_priv(net_dev);
+	stats->rx_errors = 0;
+	stats->rx_packets = mpnd->mdev.dev->stats.rx_packets;
+	stats->tx_packets = mpnd->mdev.dev->stats.tx_packets;
+	stats->rx_dropped = 0;
+	stats->tx_bytes = mpnd->mdev.dev->stats.tx_bytes;
+	stats->rx_bytes = mpnd->mdev.dev->stats.rx_bytes;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+	.ndo_get_stats64 = mctp_pcc_net_stats,
+};
+
+static void  mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->addr_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+}
+
+static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
+				  struct device *dev, int inbox_index,
+				  int outbox_index)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct net_device *ndev;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+	mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
+	INIT_LIST_HEAD(&mctp_pcc_dev->next);
+	spin_lock_init(&mctp_pcc_dev->lock);
+
+	mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
+	mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
+	mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
+	mctp_pcc_dev->out_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
+					 outbox_index);
+	if (IS_ERR(mctp_pcc_dev->out_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->out_chan);
+		goto free_netdev;
+	}
+	mctp_pcc_dev->in_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
+					 inbox_index);
+	if (IS_ERR(mctp_pcc_dev->in_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->in_chan);
+		goto cleanup_out_channel;
+	}
+	mctp_pcc_dev->pcc_comm_inbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
+			     mctp_pcc_dev->in_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->pcc_comm_outbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
+			     mctp_pcc_dev->out_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->acpi_device = acpi_dev;
+	mctp_pcc_dev->inbox_client.dev = dev;
+	mctp_pcc_dev->outbox_client.dev = dev;
+	mctp_pcc_dev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_dev;
+
+	/* There is no clean way to pass the MTU
+	 * to the callback function used for registration,
+	 * so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	rc = register_netdev(ndev);
+	if (rc)
+		goto cleanup_in_channel;
+	list_add_tail(&mctp_pcc_dev->next, &mctp_pcc_ndevs);
+	return 0;
+
+cleanup_in_channel:
+	pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
+cleanup_out_channel:
+	pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
+free_netdev:
+	unregister_netdev(ndev);
+	free_netdev(ndev);
+	return rc;
+}
+
+struct lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct acpi_resource_address32 *addr;
+	struct lookup_context *luc = context;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *adev)
+{
+	int outbox_index;
+	int inbox_index;
+	acpi_handle dev_handle;
+	acpi_status status;
+	struct lookup_context context = {0, 0, 0};
+
+	dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(adev));
+	dev_handle = acpi_device_handle(adev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
+		return -EINVAL;
+	}
+	inbox_index = context.inbox_index;
+	outbox_index = context.outbox_index;
+	return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index,
+				      outbox_index);
+}
+
+/* pass in adev=NULL to remove all devices
+ */
+static void mctp_pcc_driver_remove(struct acpi_device *adev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
+	struct list_head *ptr;
+	struct list_head *tmp;
+
+	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
+		struct net_device *ndev;
+
+		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
+		if (adev && mctp_pcc_dev->acpi_device != adev)
+			continue;
+		pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
+		pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
+		ndev = mctp_pcc_dev->mdev.dev;
+		if (ndev)
+			mctp_unregister_netdev(ndev);
+		list_del(ptr);
+		if (adev)
+			break;
+	}
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001", 0},
+	{ "", 0},
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+		.remove = mctp_pcc_driver_remove,
+	},
+	.owner = THIS_MODULE,
+};
+
+static int __init mctp_pcc_mod_init(void)
+{
+	int rc;
+
+	pr_debug("Initializing MCTP over PCC transport driver\n");
+	INIT_LIST_HEAD(&mctp_pcc_ndevs);
+	rc = acpi_bus_register_driver(&mctp_pcc_driver);
+	if (rc < 0)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
+	return rc;
+}
+
+static __exit void mctp_pcc_mod_exit(void)
+{
+	pr_debug("Removing MCTP over PCC transport driver\n");
+	mctp_pcc_driver_remove(NULL);
+	acpi_bus_unregister_driver(&mctp_pcc_driver);
+}
+
+module_init(mctp_pcc_mod_init);
+module_exit(mctp_pcc_mod_exit);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.34.1


