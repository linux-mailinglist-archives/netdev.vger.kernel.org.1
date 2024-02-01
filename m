Return-Path: <netdev+bounces-68044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A7845B0F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF1E286ED7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245545F49B;
	Thu,  1 Feb 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="e7eYKMhz"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2159.outbound.protection.outlook.com [40.92.63.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A05F496
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800513; cv=fail; b=T7WzWD/VIcf6R0ksFBe07DXhzcg3I9E/VtPxTMHiEut0noRe+T0WIjoqYlgw5BDCGBwV7FgZfi2GyFRDBPBXLmPImesZjUWFDBeqOhFk+TKvxmm6i5GjEl9KQa0wQjP68+NZDWMySQWpjIARpBkMhOjEOm/m/t+P2uI6oiHjppg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800513; c=relaxed/simple;
	bh=gf9LhBs0ZYm1Mn5O4XujTk6UR1kl2CoA/JT6IteD6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZK426bFueMFExtwUz0B7CJN4Yjp/zgudF0fhuwqRGSSrckOS2Ott+Fo6dtANfOK3ov8Am+zOmadl4b8x7iaevzmzcjkfvZXn0sMxNY2ApcnKkxORsnlH+5DjlXu3Y08GWgzB3SdOqZrglnmLITqFtq8kBr1BltP6IEkhTq/IbdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=e7eYKMhz; arc=fail smtp.client-ip=40.92.63.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA0YZH3uxTtxmlxpGpe/GOXQPDVFjvxNf3r64Tkba69SJWoTvFer8TSBdrlnfwXl6XQju9nNWXKwhDlh3I5/0jfPBabquics7QxB+wmViKYHAp/TrGscx3OZ/eXzb5+BUQKVvL3Uj+hFhD9bB5ISAVGZgLPwaCGemTM8UKCGWFuBXeyTKJSkK6huWbqbnjJOJy/BPEEdBeGX1EkjIPylNy3PFfZsLc03D9zST0x2Q9r2vRe5lsWsdoedyYAGx1/bacmgeU0ho+Cj9ypv8daVfHR3K7HVuH5RcMjwm++qkiORS5kscDS+BWNB0gBJpIOQ6szxPJEoQnEImZn1Tn76kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj4KJk/MfnGI3RhRBDrr5qWs3RycLRSjzB8e+fw+YXw=;
 b=i4IUyiI0GjBnWQxX3LdJ3Ee1RSESuDC3SEpCbSH0mB/mrr1lsxb4xsj1OHYkdokfP8YBmb+HbPzq0I2Kcki/9LBaH15Jd59OH7I411RfXJstgJN6c2B2wdNcQLq76oqA+Zh8tqSAOJ2m1Gv2ybw8yagu8xt/9XQZO01e1SJBP9aB8ZZAmXCig6BlPh/iXpBRgptjjHsrGszIxJzLtReflkJXEePYW8O8eNTEbE8J5MnJxZr3nBjpUnuVxh+aCwc5vPAB2sBP2wjWJDqO5yoRLs294/2bYO22MPFS5WmREt+ZT0N3Phn4mutFGTTtGb1o9nsOlyff5qjOognAM5R75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj4KJk/MfnGI3RhRBDrr5qWs3RycLRSjzB8e+fw+YXw=;
 b=e7eYKMhzSToHHbN/4j+/l8cQwLSy7iH6sLPtMFWEFo6r2eyiPzH8m2sKajZuO3dHif8CsDC0hWcMj/L7kYhtN0jokFuxHGwRXOUpKdib1g7kVzD3LthjzKmP+AgbMFKtHVP18jJwsyJPqpeQNSY3GApUs/O8nBIlP7um++ybqbJSyqeU781sUbtyj2FZRZx9hV0qVHIEeSRBsc/qE7VmttsMmXbmmx7HLc4EooS2Ibtam6MhNS5RKtGjxgC0QhbMxxdeIFvcVLox6HrLRlFIN9Y50ijcUpr8lI7vyADo1EGW1fH+pqSJh1bC67NZWD1CrNyHuQwvxaBs2/sSrqMu3A==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB1224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 15:14:51 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:14:51 +0000
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
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v7 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Thu,  1 Feb 2024 23:13:40 +0800
Message-ID:
 <MEYP282MB269704BFB8AC4893C300EDBCBB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201151340.4963-1-songjinjian@hotmail.com>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3cJAv3wca4LfTC5gk0jkXbYwqznIusXJ]
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240201151340.4963-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB1224:EE_
X-MS-Office365-Filtering-Correlation-Id: d36c9969-b4f1-448b-bdb5-08dc233888d7
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDnmM4WfgbAB22eBPSSfRfjSXkIKqbedHf+KffmgjoLMx/ItZgQwrnayLxg/1NVBoA1smRTUXeX66r/UNK7pG+OKqVFJPR7PiNe4q5Grvrh9wUlWA/a/imkzrht4CtbE7JAk3SjPG65y9ETIRVsaX+4O4ujhK7xIaTNkZB0ZvyaqAuzBpKHyGZp88+v3QnSyRDyyZNp/bATJXBDservfyPOiVAhp9Ps6xN2q5jVgbld6vjyXkZWS4EQJeQYnogY6ajd94cZqfO0QGqgt85bmiN9IQ3TvbwBtdQGbJoMSjgRNuYvIDfVRzzffBM/tZkWyPmJN5Da0k+PClE1GaCI3ajUBfRN3VPF0IAiFxhzYORajXeqi/Ksx/zrSXTH1UR5p7IvjUvrVv77lLt7nDMWjLM04n+VniF3OJMZwSShvNe6TQxicieAJWxfKVmb2+Ass8h7jJVQKHJQfDzWr5ZxNRh5lw/ZfBwOWtRw499VLNZmBhhOUf3Dh5agD4N78PMFY1b9erVuge7wzWziP3b/Yk8LCjd7gmt2x0smiwEsUucsz6liZeMBhPJNQqv+E33p8KWwvwQH3QRIK8RJE/yJx4hjoT64FpmVn5fLhRORa0jsoL5I7KhDxuBXTrl4g7xapZivjDGlqOzR2uLA5TZaCBZ8GoINYJBAyE55V8s33CuWbNoNuYShMtr7IuDj4OlVP8d1AUI0Lub34knrfH04DzSakMfW1nDS47AqKrOFP0SlxF/6jjXENWzOEbC0e4Ho3HyQlaR1WkgMeVi+UD5XsbZc9qFY2V5TOjM/ZnmSVFHmXcqMWX0D0sQ/
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C5/y30wehcCN/JUP8oZwkeOltJouEUtXgE+DC0hc0fsEvhTxOa4TxHZQ7PSZu2Dy5zR1h9IzidZJs23845JNBD9rr0MHKgxgbaCEu7KdtL6/6uKbV1xddksTFkMdKnmS1DqWdW0IgLCm+Wtmn6gLb80TvfxNraGmbPqusBJce9JXHjQPzh+tJgXOj+nqbBIHhOZlEg4AaBRDbNY983Wc4VesOnNbLBvJoYjznu/dXZgyN6PRC6zdvUrU6cAsfHfI4MZb6jektvKDAL2hiZEESLewAj0KeKVoS957YzxvJzOw0yzPUim2Xydt/H706PhvkhhJ+JSjwa5rKLVHwU35mBrjRMhCFS84ieZV+uu+RNHxpGMHo1LH8zWubT4mnseLyDzH0nRL17oxIql8dDWzWZiKJtTV9i+QjUH4VRVxX5dAC+lv0FxGVR8srOzcmsVoGfzXQOv1mWMKvGJKWyK0ThLgehTzwLRkRCcQ+ZHrkSzcOkgi5h02lvHHYR1o2XYagUmpCvVTPh05a70FWvYBIdUlTVgIFjq9DsJ6r3EZ3EtanQgQf1Crgl6puOdY5BOUi2G9H1R8kHVX25S2CPv7nvjAZ1kFjjkTMFQba25Y7wI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aepvV8IiOtOWxMzGwC6hJWfQMK5tpWuG1PcS4NKeIKkD5SchUsy78bXQNIDA?=
 =?us-ascii?Q?P8JcEdyEwjza02+uyu9PZP68cfTXXogf6XSCIndJAZLRgPO4tlIWMbzRmZfT?=
 =?us-ascii?Q?t8md981S3+UqozJy9Pz+mp+yDTqVoJuA80JRv+foOfTqZd44rn0F5P6WzF+i?=
 =?us-ascii?Q?hkeBEhimg7FK6wWhQzlkZwKLJj5RrDfDfC4BAYdy7GxxqAr8BkUKJT/4FjNp?=
 =?us-ascii?Q?vudYlaavwrqpUfMlLu1qtVsSIYyn/XU9SVjB84fp+D1QgXHuG78Eb1DxI/WO?=
 =?us-ascii?Q?Dh6Qv7tkYbWfAJGnqkJjUCaNTgaCw+5JFyJljhyJOn6Y4a6M0SuFdrJ77Phf?=
 =?us-ascii?Q?C34OZrXqClNmjPYCcpnHu9Ts/AfqCR49RrqElypjFf4tlQvDaciiCm0u2Yge?=
 =?us-ascii?Q?X9F8N26RhE70AA2KJKA13Z9Bw86pTRxjtffdtoZDLd37xJp6bDltMZqY+5qD?=
 =?us-ascii?Q?mVGKn2nXIjV6X0rhiI8wLL03jyD48ynnqiUVYlSYGOL+PX0XsMJF0xsDKtwO?=
 =?us-ascii?Q?xNbWLAcvakFYlCJ+6LjbzyTYM4O2yJBzTKfqYOYgiO6KQ14kjmcvtzGowDZT?=
 =?us-ascii?Q?/0s9vOrTpa2pQ6yZmZIvUrti5QBXZdlLOrDHYLfdD3+Wgqc/P1mP/h17c7ge?=
 =?us-ascii?Q?dKhrEtcaFFnn2MHU3j+Q6JiggyiasTa7w49lVdWwA5wEMubXja8xddyajN5e?=
 =?us-ascii?Q?12cGog2j4ioJcnajbBnWDcO2+wFVq7p5T+btPkQtRCTJfeaheATQaTmQt9z5?=
 =?us-ascii?Q?sFUkEUhhwinm7I8RO1tUgWEiyVErMQlMa6YFMsr2hhaYKkyf00RjwbvSRRFr?=
 =?us-ascii?Q?lQqWLlAkWc/yhe5UFrpcRKn/oaGKbk7N2Zk3ho3nB+5BrQpSMsbV9KQU1hIh?=
 =?us-ascii?Q?lgVLhg51oTCD1nHlmSS7f2OpS00tBIrzjKoBIelINOtB0dtoFLc5Ttw2DMLx?=
 =?us-ascii?Q?HaacMBdATYNaB3Nycdy6Fl/vKvjeN+OJLCvBgIPp0u20FyKA3APia/M+AaLL?=
 =?us-ascii?Q?b7I778gojgYb5OtlIdQqnxCOQh39kGS1DwxnZHD09MS6F06lhIPOziafc9ID?=
 =?us-ascii?Q?v70rHNEbU5Zag9rClbwzbLErBHTBjOVRSLPG2jy/2hQiMPY2n2s06ai9KN6F?=
 =?us-ascii?Q?LkvbuQCFUilsMs9Lo0bd3mwZVnA4UoviLjXe/s0xHN4i44gP+nzRSQjdV5nV?=
 =?us-ascii?Q?AkyCi487HhKspxYUf+Xd4IXHahnZCGlBIpiSo6I0yu0YCIxHSZj4G7Hv0F0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c9969-b4f1-448b-bdb5-08dc233888d7
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:14:50.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1224

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.
E.g., flash firmware through fastboot port:
 - "download:%08x": write data to memory with the download size.
 - "flash:%s": write the previously downloaded image to the named partition.
 - "reboot": reboot the device.

Link: https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v7:
 * add fastboot protocol link and command description to commit info 
v6:
 * reorganize code to avoid dumplication
v4:
 * change function prefix to t7xx_port_fastboot
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
---
 .../networking/device_drivers/wwan/t7xx.rst   |  14 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 116 ++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 4 files changed, 111 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index d13624a52d8b..7257ede90152 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -125,6 +125,20 @@ The driver exposes an AT port by implementing AT WWAN Port.
 The userspace end of the control port is a /dev/wwan0at0 character
 device. Application shall use this interface to issue AT commands.
 
+fastboot port userspace ABI
+---------------------------
+
+/dev/wwan0fastboot0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a fastboot protocol interface by implementing
+fastboot WWAN Port. The userspace end of the fastboot channel pipe is a
+/dev/wwan0fastboot0 character device. Application shall use this interface for
+fastboot protocol communication.
+
+Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
+port, because device needs a cold reset after enter ``FASTBOOT_DL_SWITCHING``
+mode.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index e53a152faee4..8f5e01705af2 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -112,6 +112,9 @@ static const struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "fastboot",
+		.port_type = WWAN_PORT_FASTBOOT,
 	},
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index ddc20ddfa734..1d3372848cb6 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2024, Fibocom Wireless Inc.
  *
  * Authors:
  *  Amir Hanania <amir.hanania@intel.com>
@@ -15,6 +16,7 @@
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Eliot Lee <eliot.lee@intel.com>
  *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #include <linux/atomic.h>
@@ -33,7 +35,7 @@
 #include "t7xx_port_proxy.h"
 #include "t7xx_state_monitor.h"
 
-static int t7xx_port_ctrl_start(struct wwan_port *port)
+static int t7xx_port_wwan_start(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
@@ -44,30 +46,60 @@ static int t7xx_port_ctrl_start(struct wwan_port *port)
 	return 0;
 }
 
-static void t7xx_port_ctrl_stop(struct wwan_port *port)
+static void t7xx_port_wwan_stop(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
 	atomic_dec(&port_mtk->usage_cnt);
 }
 
-static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
+static int t7xx_port_fastboot_tx(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct sk_buff *cur = skb, *tx_skb;
+	size_t actual, len, offset = 0;
+	int txq_mtu;
+	int ret;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		tx_skb = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!tx_skb)
+			return -ENOMEM;
+
+		skb_put_data(tx_skb, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port, tx_skb);
+		if (ret) {
+			dev_kfree_skb(tx_skb);
+			dev_err(port->dev, "Write error on fastboot port, %d\n", ret);
+			break;
+		}
+		offset += len;
+		actual -= len;
+	}
+
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 {
-	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
 	const struct t7xx_port_conf *port_conf;
 	struct sk_buff *cur = skb, *cloned;
 	struct t7xx_fsm_ctl *ctl;
 	enum md_state md_state;
 	int cnt = 0, ret;
 
-	if (!port_private->chan_enable)
-		return -EINVAL;
-
-	port_conf = port_private->port_conf;
-	ctl = port_private->t7xx_dev->md->fsm_ctl;
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
 	md_state = t7xx_fsm_get_md_state(ctl);
 	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
-		dev_warn(port_private->dev, "Cannot write to %s port when md_state=%d\n",
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
 			 port_conf->name, md_state);
 		return -ENODEV;
 	}
@@ -75,10 +107,10 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
 		cloned->len = skb_headlen(cur);
-		ret = t7xx_port_send_skb(port_private, cloned, 0, 0);
+		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
 			dev_kfree_skb(cloned);
-			dev_err(port_private->dev, "Write error on %s port, %d\n",
+			dev_err(port->dev, "Write error on %s port, %d\n",
 				port_conf->name, ret);
 			return cnt ? cnt + ret : ret;
 		}
@@ -93,14 +125,53 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	return 0;
 }
 
+static int t7xx_port_wwan_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	const struct t7xx_port_conf *port_conf = port_private->port_conf;
+	int ret;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	if (port_conf->port_type != WWAN_PORT_FASTBOOT)
+		ret = t7xx_port_ctrl_tx(port_private, skb);
+	else
+		ret = t7xx_port_fastboot_tx(port_private, skb);
+
+	return ret;
+}
+
 static const struct wwan_port_ops wwan_ops = {
-	.start = t7xx_port_ctrl_start,
-	.stop = t7xx_port_ctrl_stop,
-	.tx = t7xx_port_ctrl_tx,
+	.start = t7xx_port_wwan_start,
+	.stop = t7xx_port_wwan_stop,
+	.tx = t7xx_port_wwan_tx,
 };
 
+static void t7xx_port_wwan_create(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	if (!port->wwan.wwan_port) {
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
+		caps.headroom_len = header_len;
+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
+							&wwan_ops, &caps, port);
+		if (IS_ERR(port->wwan.wwan_port))
+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
+	}
+}
+
 static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		t7xx_port_wwan_create(port);
+
 	port->rx_length_th = RX_QUEUE_MAXLEN;
 	return 0;
 }
@@ -152,21 +223,14 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header), mtu;
-	struct wwan_port_caps caps;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		return;
 
 	if (state != MD_STATE_READY)
 		return;
 
-	if (!port->wwan.wwan_port) {
-		mtu = t7xx_get_port_mtu(port);
-		caps.frag_len = mtu - header_len;
-		caps.headroom_len = header_len;
-		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
-							&wwan_ops, &caps, port);
-		if (IS_ERR(port->wwan.wwan_port))
-			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
-	}
+	t7xx_port_wwan_create(port);
 }
 
 struct port_ops wwan_sub_port_ops = {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index b98ad4a1709b..11906f00c875 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -229,6 +229,7 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
 	struct device *dev;
+	struct t7xx_port *port;
 
 	dev = &md->t7xx_dev->pdev->dev;
 	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
@@ -244,6 +245,9 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
 
+		port = &ctl->md->port_prox->ports[0];
+		port->port_conf->ops->enable_chl(port);
+
 		t7xx_cldma_start(md_ctrl);
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
-- 
2.34.1


