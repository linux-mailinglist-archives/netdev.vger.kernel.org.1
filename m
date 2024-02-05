Return-Path: <netdev+bounces-69068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7863F8497AD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32A21F23A1D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A682168B9;
	Mon,  5 Feb 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="G5SQgi0I"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2143.outbound.protection.outlook.com [40.92.62.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D316436
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128593; cv=fail; b=B8qrdRfBy8LZtE5mUjaHXZoRm7ryW0qwjBLU3WDkRNxle8vZBHVXxm2ThFkFsL7LXtLClIDSQlyjI1rYS6geKEE1+wY4jhOHfa3eEe6rr620dgbVd/rO93bCSiyEYwkE9dyGN7QgttjJ95hrfmJXyZvRoyCqM1tCWJxjVGjBLdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128593; c=relaxed/simple;
	bh=YhVOK0FBHrlMdN0dM8K5LoGLb0ul8FBcBA7TA0oCz4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NYDXOFu+a6Qs4Dx9kPXuVfwvA4H+NVp4aESgYmvrYnCO02TgCDVbWvS+eKgy9eals632iGAPVUp/ybgTcL/z2hOyKcxdL/EvNw4PKk95Hnmo7b4JNlGhiVrx7yQAN4atnTA98xUU0UtreArCu6yLJ1DPZQkTzn35MDBA7qTnaF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=G5SQgi0I; arc=fail smtp.client-ip=40.92.62.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiVn8uZHejFmE3mnONY2L8FpeDgLJnNxuBpwrjaeVSUCldxj2X23oppWAewwClDft6yowgkKIe3LEgvI0KOSaZpMCpT3lXn5IkgtKlm9OB5mLk6ME6JI/1s6PNgTutPmReeYaJljaThGlK5pFE9fHAX46bS/XPU8vyVC4SuBXqiJ79mgx5/Lr/bbz8zazISYsWwk/Z1EFZh+poIxVyy2RHcKuHLeKli3nxsU5OqcHWoypPiBpZgdx9piXpF0K162w3id9SAGWEp16Wbk/cYHBVbJq5cbaB2H6iwqlYdUhMmmyJZuzqD7sUWYVJDZgsykzzHs9Ohgyx18TJy0VWAdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXQAwd3K907An0MiH6B9/bN7nKyjEhHCiMU2+LIVlV4=;
 b=nwQ1kKRgIyE/mUM7ONd6dD4YOza9QsRwGnPjG/d2dlZCkbAT4u43XhXFdngCVDxAjs3sQckBuTUVlZWjfkvXL2OCqNQsp+gPTvHVQoDHFKolki1ayN/ZQMkUp/xRPewYM6F+csZbGKnN0YFvd4rWki+j/htA7kb6zT3l8/o4GxczclR9QX5kl80MzUTQnhJ+B6f+m8BQtH6lnwz5uW9NU2EqtFzllAa3RU1A67TD9c/4DpY56IMuSWswBAFmXSL2n2fuuPrN4mPHcvwgEB14djtTVtOTXI1OVk8YtVvPZmxPnltdSB+6f+Xz9S7MGZhDtlnJrvp7Ak+xc5p7Nw2t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXQAwd3K907An0MiH6B9/bN7nKyjEhHCiMU2+LIVlV4=;
 b=G5SQgi0I1RV5PUZLN6qV7xdCYlBPzONQHKTlgKDf66DkdQCWvJMeq6GTfz840Hwgtjllg+bt1XA3qXc/Vx9FOC16qAt5sH3crgkswQ6l0IlAgOqlmAjh3oO+5S7fE6AFmBlZY+nay0t9b0/agXPlNJBTBbnaBx92ugkQj3XKDMYiEULEonUnnPYLKWHSemwyJn4Lg/zIcwOugCJXTdEWkl71PkSPxJ7byqKU1e3b3OOct9k+O4vmlsdqkbMDVgaQ2Wqvlhyh3l9r/IBslt71+u9BCw6QR/nC3H68yI4Cypz/POVAIa7L9OaUjkbiaQAg09hEAfY6tBrIDF51NZBwrw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB0886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:23:03 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:23:03 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: [net-next v9 1/4] wwan: core: Add WWAN fastboot port type
Date: Mon,  5 Feb 2024 18:22:27 +0800
Message-ID:
 <MEYP282MB26972B38E198B163EE7094DEBB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205102230.89081-1-songjinjian@hotmail.com>
References: <20240205102230.89081-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FuZnCDPRT5b3/E5Z6VBEKOQ2JOLanyKX]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240205102230.89081-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 3875cb0f-6ac9-4bb2-224f-08dc26346f5a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vGjtwDHm3oV/G6IqOHRp6XEb511S8Edn7mk3hDDsrFpDJC+xPjZ97P0G1nHutnkk2hMNtNOE5ms4jIfbVLojIIUl0Quq+CRarfg3xIPwTtCSM2GJVOJQudVW+PLwSCY02dZDmC8wvZ5hJ4ND1MMf7SHZaHVdiUvdn7CghGyRSfNBbMbyUwJ0n72ewpqazWm5WQd6x+wBD274HmWsh+n9B21vYi5E5F9o3kkmTY0wSeLz3lG9iD6LRU6RXgx8d7RveNlCWQuQdWRwnXE4v6xuD/rA2jbJIa1tP+schlGE2pzOyihcmeGWn9Cz/lZX/n0hFoWDR4TVPBgNMuKQiDXUyADgetR8z+mJLLwxOxfyKt+hU69j2Vebp7tTEObq7dYKseQg6cICUhObjajB7lPfIGQrzW2dt5kswwWOCFY5YASrD6fKKUHnzvcOkeLE+7YW7K7CbEyBk8rLayywVSmbl3zgcKXns85Uksaf6wrdGIV+j32+cPwjRbBeAoWGI2FBiZDyT0gEtj3fm2oNKNUCPCr0wDYSnnSPE7vZ/UqN/oQDQHJxF4RXFWWgf4bh9xeB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dbhYPomAm7ias/ztM/56jhBBGgscyXg/FQUCIu6yeYSlwsAx/yYYw0FV5eTG?=
 =?us-ascii?Q?zB3rWljQATm6M4/q37Uh+S9Gx/R9oEED50Lapb6VZ5C4V9Kulf2lUZgXr1TV?=
 =?us-ascii?Q?6IYHVMwXvR5Lxl3SAN1EmjlGcokFCy42P2uaDKvqTI9vM8WpO6qgxHzpNY+a?=
 =?us-ascii?Q?JxdK65FPDhnJRXOHx4UgP40qrj5wCRbLkKg+Lvx93lCSchEvhabei9V2K78u?=
 =?us-ascii?Q?K+jO8tOKypPQuMBQsVF+SvGl/PDg09ntGA3klS1Esxlr2xqJ6LbU6eiHJnYE?=
 =?us-ascii?Q?rgNTNQ+FqvOlqthV48JBXXwKkygKbtma4LeKy6MiNg7M9kfdOBX+dbTt0op9?=
 =?us-ascii?Q?hN9J4jpuKvc14YExhjowaxj0mh4H+QLUtMrWFkj4pFB+DNTjg2rpgl4EEj7/?=
 =?us-ascii?Q?5rbodXbnys05A4IEAvZPUKumYAOG9Ve2Wa8cf8Ouq5DB/lBoI0vbHBsZF31X?=
 =?us-ascii?Q?x8wD3Ky6a2hYum91KxoSp4lwq6xiLBfq1RDWb9fIXujvtyTmSlrl3eMaqwK6?=
 =?us-ascii?Q?UF/OmB0Qhto8Jb8d79zZK5pr+rwz/p71kw2g8raklCr0MJYrZOd7Wf8LhYFd?=
 =?us-ascii?Q?b6u9vzy7otWNVtJfuJWHd/MRLZCiJvtMGTf11kRYlsKc+iKqwKrx+yxpoLCg?=
 =?us-ascii?Q?ZYQwRJJfZO3L8I9Zt4wvDwmCNXPLRquiCUBwDui6H3jQkNllaE+neNWbQZ8c?=
 =?us-ascii?Q?IaHhayb+apm4gvuC/XKtrOtUWVB36kd+GT53ydE0kh3WVwo4wJ6XiXRibMG2?=
 =?us-ascii?Q?WHAVl2KGSFvpRiflJoX1cArZ92K2QVkOK5LMTCqBOScMSGsu85uIEz9CTzI0?=
 =?us-ascii?Q?tZzDIAuQVx8TVBVU/8JV+l114TAsW74JX+0a/xhHTeLUMhJMjulAZ/IU6vmV?=
 =?us-ascii?Q?/D6QnprTze6ANWj5gbrn9tW1kmVXOZMoj1tmiBWsFtu/0CGHTLN6Joh6BIuG?=
 =?us-ascii?Q?nLC6Q1RUgVxXKjTDHCKf1eamBeFiylwkEKfAYpwMK29mAWxMDn+kgxjA5eEf?=
 =?us-ascii?Q?K9ytLnt5VcRRhwc2i0adYgyBf88MXENtUf2QxlLPgb5+IT6cu0D42OcVOmm/?=
 =?us-ascii?Q?Am/advXAAB81+ZgFvnbK0B9Y0g6WPU73vELwfBDSri1aGZxMx2mNVfbIRza/?=
 =?us-ascii?Q?IxnGgFQrnFTOZ9//kvHwimQkz3DMbIfdruSJspuXo83/TlDYDa8Xqm3kQTh8?=
 =?us-ascii?Q?TUVSguF35SR8fxq7RBPrJVN1G1bPjlFmUOH94buLmVIv3kerQ+G8th09r6A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3875cb0f-6ac9-4bb2-224f-08dc26346f5a
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:23:03.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0886

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2-v9:
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


