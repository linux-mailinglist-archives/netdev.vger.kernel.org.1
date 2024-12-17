Return-Path: <netdev+bounces-152679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AE9F5616
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A58D1890DC8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D461F8AF0;
	Tue, 17 Dec 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CYmzLw+X"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021115.outbound.protection.outlook.com [52.101.62.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D241F8925;
	Tue, 17 Dec 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459941; cv=fail; b=YNOmcghyl5dRWgr3GjW5Ryuvt2Xs/hGaBo8lJsmgdqPkYdaorhSYYFPKo3VNNv6xQkuxMNrTqKgd7Bc5T6DVzEkxBVIjXzW0Wn3VTte2dngYwLotla7nY9Gm3E3v5qMvNhXwcfd2YdE3830OTXHDD9z3OzfSko9OudgcHz9MfgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459941; c=relaxed/simple;
	bh=xeEzf1LbUs/WMKSlYBaaBcEWfVul+8p6SxNrb3l1Hkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNohY7t4pz5K73vgFdOymYgXyGnaGu2HKBSDliVdURQ/z+cpiuNb1Txi35ZcE1jminw6t97T/aggRBNOQx2ZRXIvlHqj6F2ilBvaJAxUjW8Y6djIQD7ycJAhH5jcpWX9tF9lLYti0lX98HhaTe3uaZiXFfeWfrgNG1YS1IeaMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CYmzLw+X; arc=fail smtp.client-ip=52.101.62.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMrxy18nWeiCo2iZts32mLQ2rDas++9oLpjhE5GRVW4ieXnnLtuNa7+fIzfxX1ooszPPpkBpff3q+dA/BWRVr6xXr3DbW1OIZz4rhbQgCjT8dSC6HIkNewdApOu5tXqb8NJ55lSEkHcJTuCk3q6vYbQLgMXrXb3PkXrkQKwZ8U/fcDBtnh+Um9mQ0ReWBfZS2sTG9VbGTbZzDO51u2CDqAZHRTPbIGVLUrd/dk9o2L/toGdHdSoDP2HC9tmLJxGsyTa5NJdnLoxlHQsl3C+a1Fem7F7X7lmFjUeeMfH3vnZ+fp7EKwNFCxOLvu38Dw7W78+oJoxdLDJSSm05nzNGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2IdcbOC9MiM4vbz4RW+cyJG0bxHn87acmyqH2ODNRs=;
 b=K46P0vPx5mn/9kc7RGpNPF6mJ/6e2i+T7yrbiaE67fGUoVhT6txqUHKyd9ZfVlYpCd/WLOK3VpO9oRKFWYQaXUYpJEMtam4eG8jLo6tjG144jzVPomk1eHAnca2sDKD3rED7uuvq2sNlKneNS1g1336ww6kJxSqTRLuBt257bU7mwM9fDFCOyfIFPkrBdQNyzMVkLhhxvI4WxVp+L+sKZ47/Y8XeRPMpFlQ17uszSbELmR8d2zMY/KAhwUL5j3YlxUFolZhrfXE6Sv1CYRsre0wMsEO8+KTWopenjK6zTGL4BrU1edbHOH/2MjqVMwCERvLq0TEYowaEQtkQi6MVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2IdcbOC9MiM4vbz4RW+cyJG0bxHn87acmyqH2ODNRs=;
 b=CYmzLw+X7Q0MTjcSkZmlIlCSqkDVn8YsMtJ/i62c3wJh9UIMsimGj1LXTqltHvM/WVBhMtCvjiECll7kdHaQUENel9sUi5T1ajEsPjoy4tKi/NA2+hrZXJKTdvoZJ5hbg5FJbQ7ExI/MGQH+t1ohPwMZlDXvTX5QQiMuBFXZpvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH5PR01MB8911.prod.exchangelabs.com (2603:10b6:610:20d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Tue, 17 Dec 2024 18:25:35 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 18:25:35 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 17 Dec 2024 13:25:28 -0500
Message-ID: <20241217182528.108062-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::32) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH5PR01MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 468498cb-9cc8-4960-8a8e-08dd1ec832ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnkCyRoRMPYwAc3pkRL1zxOCKZrmSkkozJ084fJQgkcWXq/QDHaeQiqjpQmb?=
 =?us-ascii?Q?kcr7IaFTzukMvsEvHzwNpiqWNuNA/ZixOtxfH73OjAkuP60iJphDY22ltWIu?=
 =?us-ascii?Q?16oPL49HW314lXEA3r0rkQDICAaXPdEaW1itpxEZ25dRKy1SdwtxVDvnF1Zn?=
 =?us-ascii?Q?MjGTT/Ihz/uGW1e6xnoycycF/vzTxRNiaIcsCWDjYL8GQp2s7gvSATMBSYDg?=
 =?us-ascii?Q?kOoj/mmu7dNL38Xa3BwhHZHz8Yy6UfxcwbOISxWIgc4NIO/JjvM2S4WSNJkT?=
 =?us-ascii?Q?Z0DDlQ+YrdrWYYdgQAU+WHKBjyHNqb6YDscLwm/U6FD/wvgOTWI3lZoCByq9?=
 =?us-ascii?Q?A1eZGO8hRNKf7QE43SSDhkSFj8PBZKGEPuOJ9tVL0u7RvzlsknRGj5oOequZ?=
 =?us-ascii?Q?5QigRqneqF57nAIWwXAtIIRjtOKXs2nvAZR3/ON7n0LZ/UTCBZhK4V9pfRrK?=
 =?us-ascii?Q?V1AOjWey4eailsMsMv3USUs+D8kyamwX7E80i2CS9Ec2lrEEQothoZVeJsW3?=
 =?us-ascii?Q?vR4riH22luTfTjaTn9lGHVYog3EiUHf/o/ppCqDQFT7LNi2hUw6nckYlBbOE?=
 =?us-ascii?Q?2IE9gwgs2qZAbI970ZnyyE9tuU8yrmzNObIu1ZTXcCWgdllM673P52UJYNQT?=
 =?us-ascii?Q?v5XYT+v4r/29ew1GsQEtI+gkdUI74lhcjg6YfAFxZAD01+Qme2jJwoAlRzCA?=
 =?us-ascii?Q?Wf0KmuFFzfQ25CV88ZU01wR5944zmtxaMHajEVPR0MrgT1tChBJRuCaSo1Kx?=
 =?us-ascii?Q?MXOfaWy9QFGz8HZAQ6qRpg7Eldilpz92KaZkLjk1wq2V/R9QnYOWs1WtEGbv?=
 =?us-ascii?Q?FnFy1u6dwjkY9VZ0muWg92gYYB19yPsTbEzH85xskgf5XxIF5CtrImev2CJg?=
 =?us-ascii?Q?deQONzCD1dyTvQss7sI2VpusZWEHkM2QqymI9dEPyPiRGZXISk1yoOMW1mtD?=
 =?us-ascii?Q?1HdXi2TvEJzw4zLHk0m9sUGykl2r1pcqP8y1jS/A/RYGeS2nDwf7xZsNgTTw?=
 =?us-ascii?Q?/T9ApcXuKU5tDa3VaoaW+7n9EUKo8jH8mnPwvrPzkZCy9cabj3eS8gLsY9Jp?=
 =?us-ascii?Q?zfpem/7JJU8h/UFkwd02UkEm7vD3V/K9s1Qdzq5EVoKFJtQvqISklTeWQZuI?=
 =?us-ascii?Q?10eP2zanKv1Vdo4IgZ39/C5bvth35BpRl4e5u0yRlqZxxPfO2CbSXhB4ChIp?=
 =?us-ascii?Q?A3xYPGIYDn5TRI2n2UbaN+Ub6KiRksiyHNuyZIhVJaKqogqVlmHh/bNtcHWm?=
 =?us-ascii?Q?IS/jgPvsyznTyuYKEi6Fe7XpSABtceL/7WRKNTzZS5mZWSJtq9QGH7/lY8Zu?=
 =?us-ascii?Q?OmLq5KnCqdAmfwNwNvlAKQr3OXMES/ECTukXvZFqrC/Ote+ud532vp93ZvMR?=
 =?us-ascii?Q?0XyK+VKPOhgP4XQaqYdzFB5a9gSr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgOnQX3eE8KGFo1Tei8hMKTcGM9RvoDyANwnMWB4pRdvh6mLP2Os1ywvK5RJ?=
 =?us-ascii?Q?rB166SP3K96ytyTGtpQxDRS599nDG6zlyEEp4MQQXGeDNc1nOBqlYmyvIwvV?=
 =?us-ascii?Q?7M7X4X7IsZIxfdx8JmwpNcKKO0CZf6GkLy7I1USqq+45IlaMsuMPHlyM1fn7?=
 =?us-ascii?Q?Pe6JugSHWnKXp2zIFt/eWOeAehyldm8OIt5hOXYI8QSQbJLA++slrRv3lxlS?=
 =?us-ascii?Q?r0G6ZPbKVD4IfdZT+AcquxlN+H26nBhpsv86IQNfS55qVnFOc17UUEILdUiJ?=
 =?us-ascii?Q?JfUy2lYyT7mi5VU8dcV2n6ICnw2R/1y8J1vuy9972oBujJw6nDwG8GJcsuDj?=
 =?us-ascii?Q?Y05ur8p8twx28lKrxtoalvM5buN3WS+YwUwbEm/a6rGC9pdXfAzNEOgk8kOM?=
 =?us-ascii?Q?W+8nzwRkE2QrL50/eubBJ68XBbIfTpeAz6vCMdUF9+YktlDsYRVQ+PhylLZK?=
 =?us-ascii?Q?jmCD+jdoaLc+0vqd+v0pcpCG7MDk77tij0xBf6deNyv6LeDaz9FWb/LH0E19?=
 =?us-ascii?Q?ybcZHCvYmu5OyAPWZ8BL43EDSLE2XA22V4+cGChf31It+YU6qlERXiM3BaHQ?=
 =?us-ascii?Q?innhC6R5JqMre5utrJWuIySiNg1j61rVvZgywGhBLdNfrW9EoL42cSNldbSO?=
 =?us-ascii?Q?MnsLnd66yQrJmqelGeh1a6f8OEL9PsvWnGbSJEpYeAf7ol1HjfzPUFXSnFRi?=
 =?us-ascii?Q?oxFIPAo99J2xtHvoDiBvH26XU08Agc4ixuIykgq/5g/LNP8skSA//eiDQD+a?=
 =?us-ascii?Q?WJm5BtuKf8gyxAJSHGam0jRz4+8PN2caFtfjezAoqAiu8GjgPHMgNuOqiKkf?=
 =?us-ascii?Q?EShDXw0h+o/68sZD2yAVv25zg0ibLuRGg8dW5niW75Yac4RVHjsjIvQowukJ?=
 =?us-ascii?Q?R2ZH8qK7EJjZH5Z729rWckE7AQsastWiGdEOqGMCoKzmhWY3ubiidhetzufY?=
 =?us-ascii?Q?kix0TA4E56ONTdiPYoae52TGvoeSTK4CjveV4VEcvIXTc4l2fPOkHpEvs2bv?=
 =?us-ascii?Q?FxFaiK1UxRCO3/z970aOclwQrpcEsWfHhg/RtXd0QtNKM2kHe3q56GFiSmw3?=
 =?us-ascii?Q?Ce5w9QtzKZ9aw7s8GgIcqWgCAKZYxdKjppcV6DmN4mFTw4Hl3Kv4RMNpHBkk?=
 =?us-ascii?Q?C8nji8QLBwiJ7otMG1xQ4i9ExQ6wMPwHLBULPjT00lT8Ql5zSok3zjpfp0gS?=
 =?us-ascii?Q?9ApAgEKJdMsNxeeI6PH2+KKuqck8JEesyURvQgvAkNqY9hTVuwSZivAik+Xf?=
 =?us-ascii?Q?HaqCLcd8ItCdgVCs9kt0rBuOCJi998dtwRSW8Kj8WYiUuT+XmJLhCQ50BgVa?=
 =?us-ascii?Q?9ZKRpjX01FLzuU02neVJfN43CUpYreekkP3W7VTMIVo8CeokDAOvPCFXEXrl?=
 =?us-ascii?Q?NP7gN8zYnrDHXRIfeKRcjvex8xzd0yfkALSwq7Hh0La58sAeOpVAXYgVr2rm?=
 =?us-ascii?Q?z92QYg2sVW659EClW90BCEmUvXbRAKvUvRZ0wshsazkZMEct++2ALEqt1gDO?=
 =?us-ascii?Q?onadqCvVBQlJCgBVr5FvS3w2n9IghVv2BUm/6Qaotjc2GNPb8r0qU2jHFDbE?=
 =?us-ascii?Q?56ZaEY7O9TG79O3Tx8tjk0wJcuA+L2Sti+48qkmyo+QefUCA6eHD9nZGMvW3?=
 =?us-ascii?Q?4m+x/zUb/G77QDz+sNtfRpOzgjgZPVyyBY6iJ7DOcwdbLqQK60nXvyFXGG+i?=
 =?us-ascii?Q?7U4icv0uJ5aB68Kqdc9kOeZ0xo0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468498cb-9cc8-4960-8a8e-08dd1ec832ea
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 18:25:35.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PaifWD0gGlAorSTc1I0QfyJJtqJOhBrl6lrOG0O2HQsuajqodV33Bg7F7sTlEd3yq3kceanpokXX0vmR4KMZVUnnwQL0WYNANpDxA3T8x1aCe40ZNIC7a9A0hd43Ck8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8911

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 320 ++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..073eb2a21841 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
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
index 000000000000..6a29b164f208
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
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
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__be32 signature;
+	__be32 flags;
+	__be32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct pcpu_dstats *dstats;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+
+	dstats = this_cpu_ptr(mctp_pcc_ndev->mdev.dev->dstats);
+	u64_stats_update_begin(&dstats->syncp);
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		u64_stats_inc(&dstats->rx_drops);
+		u64_stats_inc(&dstats->rx_drops);
+		u64_stats_update_end(&dstats->syncp);
+		return;
+	}
+	if (!skb) {
+		u64_stats_inc(&dstats->rx_drops);
+		u64_stats_update_end(&dstats->syncp);
+		return;
+	}
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, data_len);
+	u64_stats_update_end(&dstats->syncp);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	struct pcpu_dstats *dstats;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	dstats = this_cpu_ptr(ndev->dstats);
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_packets);
+	u64_stats_add(&dstats->tx_bytes, skb->len);
+	u64_stats_update_end(&dstats->syncp);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;
+	mctp_pcc_header->flags = PCC_HEADER_FLAGS;
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void  mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct  mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
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
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	ret = pcc_mbox_ioremap(box->chan->mchan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	//inbox initialization
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto cleanup_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	//outbox initialization
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto cleanup_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = register_netdev(ndev);
+	return rc;
+cleanup_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


