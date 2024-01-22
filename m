Return-Path: <netdev+bounces-64601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEA835DAD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B9D1F25BFA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843C38FAD;
	Mon, 22 Jan 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JUIg//AH"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2182.outbound.protection.outlook.com [40.92.63.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870038F94
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914619; cv=fail; b=gK7LVs1dJLx0tny0Z8Src8JAK33/CT+hreBc6P3khqxleOER0fl/p1pQeMuIv3xr1zoSd8brKqGq4TfVns+dn0HPQeC/AwR/zSncTJDSa9VU21Jmijy6I4wIw+JnFBsI+35NoQ35Dp9bnEKKyaNp5WHfntgY/A/+31JngHlor+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914619; c=relaxed/simple;
	bh=FG8CrWsUY0c8tU+EHWVuFa407oPP9CichIkfeUcSDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUaFl9eyuT1naalzzfWEqsl2CLoMsPyWXVqe1hdym/x5E4HDEqtr3N8AIbp3m8+9RRo62qH0Iimr5Qjc4TKQH6mS3MY4jqCKEtwMqoZyZN+YK9vKkK9kauBVJTQNVXS5cRwcxbYrAFXbRDN3QZc3SO/LgkniaALz6/kyhj2cP3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JUIg//AH; arc=fail smtp.client-ip=40.92.63.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqHgav7n7bA7pOY+tPApuNvdM+b7cTLBLmUUpIoL2bZqPTjzhSqo8G2J2Dg3/SeNGmQDA6bQbxn8k1SQUnpd7TtUg3/HAzamxHZTuet1eSSQaFd0102NxoZMj9uZIdRQu7GiqlOiE0psdVYCwUV3+Fp8eFVucJqbOB9VlQzfHIJESqAhQy+r4ZNJe0I/WqbNbs0tVM79KIE72U0LcXctuiyVVjv+sjnIMl1Wh7eXPUXSlIDoWybLL5mhYDG3eY0/ZN6VOo73ZZuHifi4DYWAWcR0gwZQRaBdR5jDMVr/w7sN4ulmut78FA6hx8jMLoS/x7dqAU2LbYNykXlkZyEpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVMF2JDXbBaUsGUKXz9oqyhCDBc7okLDok0YYpYhQr8=;
 b=lUvyzLN6znP7RPIJEbnOycXxOGMWcHOOOzon6WE1qdadLKtIMazkKNA7yu4nOVzJYIm/md5fJnWQgav45CJsR7bR0egiTsBz74/wSW7pAcQWiaa4vT2s0pMSGfCpXXvROd5uv8luqt+WsiP+CFWJlWiDZ7MdPwn9zoNfLexld0izH7+Pz32wqhKkfuKrqUVTqK5I0Bq6Xm3sptS63eZ1h/SRl4q4olWHeXcr7n31l+9te0LU+c0POtIxPWXP1RT1D0t+yBHaTa8nHvkZ9jXBOkmt0uCtx/P6YHqQPgDuRSoo69YZ08o7aNFaXH+7QsE4vH28f+yTHcRM8O2d7qxtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVMF2JDXbBaUsGUKXz9oqyhCDBc7okLDok0YYpYhQr8=;
 b=JUIg//AHNHO6Dkka/6sT4l6h0m4oujAUWLRRiCpoaN2CnE+oxRY7nT+2/syf+XPN6WaBkNLN4HDkmJkDPbP1d4TbO4EZAMLaO45MlVIXCuvO47D29BVVllkceNcfips82Ga7Zt1pccC84nR3EYp7LJxlH5KsSHMG7h9liMzlLBcy9SycHa0XOntrNTVrZEUrIdis6frn4/q958dBF5EV2UQHKgkPaBXd1VQSpqOWhEZ0bxs/cIyoz5f2NqZJvz+lWR9QloBwoz7sFJ0nAtuZLDa5c0xoMnaMZD4l13JqZn+DPwgiYB87LUnTR4UkJ8ReQbwL+37DSpdyx6h7bhQMwQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4893.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:10:10 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:10 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v5 1/4] wwan: core: Add WWAN fastboot port type
Date: Mon, 22 Jan 2024 17:09:37 +0800
Message-ID:
 <MEYP282MB2697E44EAA6C4D80C3C34455BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122090940.10108-1-songjinjian@hotmail.com>
References: <20240122090940.10108-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EniaLaL2SDUJutXpx1bYQfYQv7NiESLT]
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240122090940.10108-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f873f17-8958-4c6f-06a0-08dc1b29ef2f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dbORQjQ+ucrjmAR6k+LXD0mZPkrJHTeHjdFXASa+AHjmzgcD2VoTcrnPs5YE9VdC4FNaXun7o1zE3Mv6810s+LGQGuzwUbN1VT0XccPkPQSxPjsCOZ3+vhHhQwgYgVkQYiVFVSdPJzWnEbSK9iPq0bhqTk/Elx6oWgLOgbsp7tD5ZbMtnz5B2eiYVpVmUUfhC8JNhhYf40onnpzfzduo7ADPuzIixa3otXeixp35uU9JnpP2SYzWytJb9XmQbXRywYbkFs7sQWfHdBx9srcFn8s5TaCIwxGZyFS3B3umxVOH3ilXvrrBXryoxj7VRZTa0yPkHZf9J/QS5cQU26i9oYkq9rFL4w1so92xjnioFCV14ixnLZTkcSIH2GTfCZRbxR5+0ltm0XItbcLfO1oCTF5jP3FNiITsiIti09dKSYOaD+WcoI8OfSjM6HcUZI8Ug+1kqdl7oK0NmNQZNCuIHeEdk/UXBBIKJr07DrHEr20U0beuwrmTGne1MwpsKcras4fM7KrbJ2Vw9gmK4HyNaSYPRGrcid2LDH4cHFFuPfoX0Oj1gCN+hUVtn9acnRtX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIAlXqGQeR/RYpQgZl9W4zBf2R2CtGoDX4MCN+x8UwLtp3GmDB/dOrOSURCi?=
 =?us-ascii?Q?P3AFq+BSY7WKqd8GzrfagTF9lp4t0B8p/i/hbfPX8FzWdbgSRhwkPX9JbYTp?=
 =?us-ascii?Q?KZ3b2nN0LSWIJBNbUtfLKQc9+G+o2B5TIOoRTmmexbc2pbgsgu8zJUsxfPD7?=
 =?us-ascii?Q?0UfDArvK3/aEI6+18EJffjLdgZ5Im0tL+PcONBvqR2y9La6OTbKqbEGyG0O4?=
 =?us-ascii?Q?d/4Mvuly1NHTeBt0HO5fOL05hWNMXG2eeDHJkA3Xl+uJml864rsv86IrGosN?=
 =?us-ascii?Q?NUf8fkljeNNzELuFf5a5alvQtkLSVdl54AJDSxp9wEi79g+zCWJ8Mdkj7rT5?=
 =?us-ascii?Q?hGQsYFCuC+IoxXpbY/15C55nVMrZJYu0yU9w5qh0dVaiP1wx8VDnTPGAV8PW?=
 =?us-ascii?Q?0XXgyh7wa+H6GwnYzY1loAtWDi6z7kSbLiW7tlb9Kgjf2MwEJIUG+aJiYSxc?=
 =?us-ascii?Q?weAxzpwAKp/TpTnKlEqYZsVtmOrN8vNaSyRRN46oaKXQ3YyFU6u0kCtiejXL?=
 =?us-ascii?Q?UwL/tryIeCRN7NSmE0Y9c8PYXxRR2gwsR3PaowhMV4CYqqvrymJwHCrsj9t/?=
 =?us-ascii?Q?rV8pK9YzheYD4s+6tgIDlIcAVk1vB5FzEpc2/ctwAmMdLkCfHyhS5Tl4FyJm?=
 =?us-ascii?Q?XYBR/E/iHF1o06d+kyOhyFjadX8ZdcFZ/+6gkcavyUXDA61nXsdlrYOwczLQ?=
 =?us-ascii?Q?l9OWbBfpMkyUsH9TPSt+OXF0eLTeR8eNad8dZys291HvL0GdgXme+iA1wt0V?=
 =?us-ascii?Q?ICBRBBxr0MYfxvfHD4t0NNibKKFEsNhwImGYB+hj3KHpohdPbYxzBlR9yTbr?=
 =?us-ascii?Q?BUhbe0+YRYOya8lMV9qGzfmlO3Gt4UDblWsJGGUlrr+QqeMKPJjv65VF06VI?=
 =?us-ascii?Q?GKOrEHF9utVxYUTtmXvEbJmdEKXhdeobGurgJVtdVpsIgxAU9dCF6kA/ipo2?=
 =?us-ascii?Q?zAQH6HqMsywpzHlfikptDMJXNZonz63cIyMLJY+9GwMXdA2i++3h9h83aTXm?=
 =?us-ascii?Q?4PN4XESHCBP+mJQFyIeqYhVvZCtDOcOkpuF7A4zuZ2OC5cC8cQYroPU7Ou5z?=
 =?us-ascii?Q?+HYsNKiQt1KAirNZkKBerp/jZuOS2NUq6UhgyzmiWbO4C/aQuwgT962T8h4K?=
 =?us-ascii?Q?xlhvvjLYJ38b1C2N4XVbzJwT1tEey1SPlXfqEX0O/dLxr5VVGRL6Hf/tFxOy?=
 =?us-ascii?Q?Fpwml3zIHhI4fEx3r+6/S1qoMh2LKq/XgyIhnIKuTWn2JghEbFo/e7KHk3E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f873f17-8958-4c6f-06a0-08dc1b29ef2f
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:10.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4893

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * no change
---
 drivers/net/wwan/wwan_core.c | 4 ++++
 include/linux/wwan.h         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 72e01e550a16..2ed20b20e7fc 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -328,6 +328,10 @@ static const struct {
 		.name = "XMMRPC",
 		.devsuf = "xmmrpc",
 	},
+	[WWAN_PORT_FASTBOOT] = {
+		.name = "FASTBOOT",
+		.devsuf = "fastboot",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 01fa15506286..170fdee6339c 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -16,6 +16,7 @@
  * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
+ * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -28,6 +29,7 @@ enum wwan_port_type {
 	WWAN_PORT_QCDM,
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
+	WWAN_PORT_FASTBOOT,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


