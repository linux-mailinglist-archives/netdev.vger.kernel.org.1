Return-Path: <netdev+bounces-108623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3802924BF2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD11284536
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99663191F63;
	Tue,  2 Jul 2024 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GOS0nROS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2090.outbound.protection.outlook.com [40.107.102.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5117DA2D;
	Tue,  2 Jul 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961147; cv=fail; b=Cd1gzTkleds4qHrgn6tpsagLwIq61NHk4d2seY7L6rka4aq/W6qVSlMg0H1qDkWyVVE76m6fGk2YEEYBpox9XQNwfabP1QOYwWUH2xe0Vw6ODB2gypkudSPhk/KBj7dM+UgUkYA/CKSYdA0OoGESy6ROQrA+Dx1EUxcxXqCxiqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961147; c=relaxed/simple;
	bh=VqaO+3aNLcEk4ZlTAa/+H7UK4o2RsG5pvo03inRVaqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlTC8yqsVnyAPOUX3aCBEQeXu/BT9FaF/9BIb/2wUQHs+4l/UvJTlbeoKWWJ57SAQ/mlJAdJklMa7rLuXFB6/Wu60oiSuO4xTGVP2IJYSXx9qAMS2MO7gyAuSSo8te4WA7sEmjtpUASL5sH2tpKsNFFABSsDqr51YAcq2ZCfBSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GOS0nROS; arc=fail smtp.client-ip=40.107.102.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boOD27vObTx/SJDcC1m0X3aHsnosgosbYuZA0eFsmhdxoI20w7T6ab4y1Rd0jTIk8cOykL8T5RKgamls7xaDr0LBe6ipQoIfCb2m4i0FklvzN+nBRVLDwwwgFqP4zP+ZliwLyNlnLU0ifm/vHUoXk4DFSlWQrSVrT9ia4GRZEfMbrfi1tsV2DuVvs77vyXywc3c1eRFip73unPNKhiLDSQuu60uxyvOc901T+ICjpMDYnATQR9I9kgbVposdlITY0y/p8XOxfKPQGlIHYgiB2N4SEb+l2QmkiVfgiX0nIQjJgXty717L7/11xcwCF5oG/aFD5HABQuHbE8XMoIzD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFjFvxtcylTGxrcIDwmpKI/Yg0okP5bgpD3IZ+cqFao=;
 b=l0vpqd8hk7YMhXiGygrzwGd2kOu3/9el5tMRH9U89lW4x+4EIO4SOjO1ShrDl+2IVdMhMK7knDSqYHyuNNbUdCoUy22ZqlaDaz447upiamOhxmulobd2JgDnZ1kbkNpXQ2PlTaXmK4gq2liyuzIZCkBcRvIDnYhZRtmIFnuSR5rxPWZ3CfSpNaKHRhSEnO/BKfBNZ2EhY6HuG5btPgOuHaJeVG1D0s8bBzLlNJyRaH1M1w2H+yasj6FI2aQ5QYU/PFeTya9apcSnlbJwHj1fnPUNzcn97euB3VZFfbLWvoTMnGh64cZDnR/9J/zxwGsi6qzSGHQpD20rof80vbF+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFjFvxtcylTGxrcIDwmpKI/Yg0okP5bgpD3IZ+cqFao=;
 b=GOS0nROSdQqmsep6W/HOAdvU4NpwuwvK1Tr8MpuWuPC5jyqExTa0QyjCs0ZJIrweQMeEsjSdcho8gE+JJj5a0i6F57q6kPIFOoqZx96HrN93DCpBVMzLoNpvdc3RbPGrxPbnBPThuuTy/hNJRZsXDddTcmx95J/awxG3PYcv67E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 22:59:03 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 22:59:03 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Tue,  2 Jul 2024 18:58:45 -0400
Message-Id: <20240702225845.322234-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: bedc5686-c2ce-4a24-bf33-08dc9aea9143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TfZ+7vt7Rh2kw9Eysuz6yvDmL5WyPM8SsG2H68koj0RdIjh3ArtAqoA9I2sZ?=
 =?us-ascii?Q?ydUUsFCj1QbndUNhqewOYcxOsqDjllRNcz5hEg9v4KgXnKfkJt+egXJzhKzo?=
 =?us-ascii?Q?wJo0P1KfvvHx4a4on/8wsEg+W+Yj3EnO4iOZ0OCzGvyhqnr4YGQ39ISUQERx?=
 =?us-ascii?Q?M3cZDGVZg9ZY0+wdu1Nihd2nWWhAq7Ofed38PXF65Ihxdr3RPy93eA0a675+?=
 =?us-ascii?Q?i4qCU9BlT6QwlrWI8oGgaB5xn7r/zoqsQOGyCGyGMtsMP+nneGCnGdTJn0o+?=
 =?us-ascii?Q?UeP/zjCJbOD/TYTMFbNmladHGKiFu85agHxcISgyaPE/uH94NDV9LsgwMs6N?=
 =?us-ascii?Q?vbtV8zoepeXZGMUCQ+3izAL9qAeVZnru1rx34azreKmbCjePzWUnBK0zgE8P?=
 =?us-ascii?Q?/9HqfA1yevOaWQ9IrX6r6ojnP+cTL5QmT6vo5dhrh8byH39+Fe+xH8OCOJ9b?=
 =?us-ascii?Q?7Td7TCSXKrfrZiWNkXXlk9EcHXrZnMqATj55WpVKtfQ3Ji6/xLjQ3NigtDjB?=
 =?us-ascii?Q?R+57vFZNIKzflqMKPr0c4spv0iGpdp/V6YXoNABYqDm7H7Hb0REeyCcywzcB?=
 =?us-ascii?Q?t0DoE13IubN2QKkZ2IjHs+cUN8ke1VEACra1Al37AnkS9SsbwPeBzRMXZ1r8?=
 =?us-ascii?Q?0LauvoxRIwbzHnPYoKnxSoNFERIqS+FeU8cwitFL29Nw/LXlNZKlY9lLM17w?=
 =?us-ascii?Q?zFy9s/qFiGcCALEtRAJlmBJMElJ9aZP7FU6JtsNcjnpz+07TWqN4yMACdWR2?=
 =?us-ascii?Q?yT/USgrF5Drpt3watO0dJLk9XTuQcnrPACRckyvHmGVmGKk/GUY5thIt8ldq?=
 =?us-ascii?Q?c3nS+7XQF/2Odp73qyySxlffVrZLTChve8xrFf3WDNy4Lkaqp6ovfCUvld2c?=
 =?us-ascii?Q?UGXBpRnST+rJPsufmJ9+emRlcggz8AyI94LiroolRxeNADYdjQQFIu4oU+8x?=
 =?us-ascii?Q?a8JRJzoYYfv1MrQbQf9s9Gad+s47pLE7p1qQ0JxCTYzjx5k3a6pLx0uV2vMb?=
 =?us-ascii?Q?wa+90+mStienSC6wEvyIATPoCuLGuDfiFXsa/jmz9/9RzBCZH26+1zoJtU2D?=
 =?us-ascii?Q?At1uzuHE2nxB33G1aIoko7XLZTvgZd0v9sLzwNuKZ09ns3Umnf42jpnabDmx?=
 =?us-ascii?Q?9Q5AXRQo9JkPfxpFlPQXFZErlclgpykOWKbeVnoKLl+vgH3Ff8lx4jjIG12j?=
 =?us-ascii?Q?tiTmwIBxNdxndwZl/stoKv+kojfHAjMCg7tf+VR/qck7QmY9Hstw99HGtG8V?=
 =?us-ascii?Q?xhK4TPUmuR+qX+sJdfxb0P/eVzCKSWBt4GtM9a0Lxwx00iWJjDvO8RIMNb0k?=
 =?us-ascii?Q?oCbEUe80oG2d4sCIx5GN/1nr84MjS1jrr4ncY9TDSe/Prw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjr15zLw8nLV4llJ41ssUE5NXzphdPdSCmsBzpLLfCJyuVvTQD7jlj05NbjA?=
 =?us-ascii?Q?HcBF0Olqw5Xj46VdxUC3Zvgv644xpMdQGRE4O/+VPWsOf5uE+TBrohI5g7Qp?=
 =?us-ascii?Q?CX4VqpQr7gOdxz0FP9eKdHi9hW7bswlQsxFySeS32J5jTY/wwioe3FTSE6us?=
 =?us-ascii?Q?Lx3TeBTISm6cvGUGEknueJoLTUM7qlX49EGH42qAtQb6PfZYbTsBnXf/hv9b?=
 =?us-ascii?Q?vBytNcz+O3JHzlS7UgAQrCEodUiiumGsYJt3tOB6jO7851mDr0qzl7zPK2OO?=
 =?us-ascii?Q?Dz79EnmRpgYs1SbkBAyc0q8Pha7Z+mShoKok9iO8pGjgwdXyHlJ+G31/cn+H?=
 =?us-ascii?Q?4ci8e+nn5eJMhBM+Z3OYgMgMQYIM+pQcgE2rv5kT0p0H+nGu8OGARnLlNEkv?=
 =?us-ascii?Q?gxgQc4FxpjquwZgvDpb7pn42RTYjz3AWZm9qvYXa9zIH5OnM5NkrKzb7/yCn?=
 =?us-ascii?Q?l8v/fsOPCx72IH/Bj+tUQiEfJaWGta4jTQva3B63MjtPRYxc8eyyk/ssU69n?=
 =?us-ascii?Q?OU8I87aBn7DlXCtjmMkf71TDOm8iRPn3jpVIGozSQFqMK+TpB98j4FbRH54+?=
 =?us-ascii?Q?WNK+EKEHLOXVSdDRhXARrTWjnPeLiMtLhdj4+y5mCkebOU1iUnLN8zA5PI9+?=
 =?us-ascii?Q?M1ta3W1o4ujWgAvs5yLA4ZUC00i4HsqP3jB7Zj/LL/qvCt+4LwMCzQTBsxK3?=
 =?us-ascii?Q?DUM8f6XwElWWXrQgpzxNow6uifhdK2tYomEUlUC7/k4yVlhTtjfJKqpNvm0c?=
 =?us-ascii?Q?xPHKSQT3G0miyn3HKUyoCONXWAeHMSqLRrgFc8WqWscKc8pJ7XErOvKqjtDP?=
 =?us-ascii?Q?JWbK0+7SZ//gSIayDSBFgC8hWFAq7kwMIc+K6S6Lp+KA5uyONCTL6zam0zkW?=
 =?us-ascii?Q?St0ZbPHLSH9EYIAIa4tNooqpHsaqWQzAkdmqPXlxDUIGi1m4Kj0IqmJSCqcV?=
 =?us-ascii?Q?ngyOVG354uyPLPjTUUva42uWsnvzBYb+oQRCNexFlXZL8RYd3csZnC3m8ZX8?=
 =?us-ascii?Q?zmnyc4YgNz3OWDOytMUTNQI9ddK8G+7O1QUaU+ZbBMywQ5Qyg2lkNLXXD/7x?=
 =?us-ascii?Q?P6a9tZkSnOfl+EGocGmAj3pcv+EsqoDjH9IeA21kN3zcwb15oZif1Nh9MK1H?=
 =?us-ascii?Q?BGC2dC3oIZh7DYUdvjZMNTtn6VlauWGdh03Sw4mxy7qcRFv/Q6Ukrfe1DQtJ?=
 =?us-ascii?Q?alfwzgLvPruGtmU/FHvuJHhP6byJwJVtMCZCu7DMp1FNPIQ2T0xTWadwwfDS?=
 =?us-ascii?Q?UbsGWKfDegsCTLVrQ3Egz7Yt/smmi6aUdtsZqjT8TtbObM3ISoaLPsmY2Ht4?=
 =?us-ascii?Q?hV35MvrFUHUaKJhfv3AxvUlu+gJBvDKpYFCjCzI7Xjd3H5G5a6sJorlZUZmg?=
 =?us-ascii?Q?KkEqHmDJ0AYGQT9Te4o5c96uWCSQMlY6Xrn/xgDnFfCGebC1cnNm0/VqMmsp?=
 =?us-ascii?Q?+gkqe/2IWVB/xaYruihtTtwDFJAYqNzshMvfPyRx0ZGvgp6V15yNarxiRefK?=
 =?us-ascii?Q?qsSwU/zjcCF/MWu+77m9oe3402oa7s80nJCWl/XVpRHZa1MwJgTYmVEx9HmD?=
 =?us-ascii?Q?cJgB088YkuOvuck3a0OgYidiUn7dljOE7ijQ5UWB+kVhTUIsQVNS7fY/RlER?=
 =?us-ascii?Q?cregIgZ5VOxe7AEZpERjd/lmDY6k5bpGs0a1Aodmx9MH4qWgQtgTKcs2SHbf?=
 =?us-ascii?Q?vj5tR766YztLc1zq3+V+NKGOsGo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc5686-c2ce-4a24-bf33-08dc9aea9143
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:59:03.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpXnMkmSLGqhFaDXN/GysiVh1Oqq6UYEsXHdfLGG5RxOM4NKjB9CtXyIzysCPuvPHIuI3z1Yh4CgDJyUk3xEnsF3YgAXLGKxnfg88JDGrT0XGIlwX1dZsMPApbqx7jF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6509

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 322 ++++++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
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
index 000000000000..50ebad0e0cbe
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,322 @@
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
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
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
+	struct mctp_pcc_hdr pcc_header;
+	struct mctp_pcc_ndev *mpnd;
+	void __iomem *buffer;
+	unsigned long flags;
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
+	mpnd = netdev_priv(net_dev);
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
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	struct device *dev;
+	int mctp_pcc_mtu;
+	int outbox_index;
+	int inbox_index;
+	char name[32];
+	int rc;
+
+	dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
+		return -EINVAL;
+	}
+	inbox_index = context.inbox_index;
+	outbox_index = context.outbox_index;
+	dev = &acpi_dev->dev;
+
+	snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+	mctp_pcc_dev = netdev_priv(ndev);
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
+static void mctp_pcc_driver_remove(struct acpi_device *adev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->out_chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->in_chan);
+	mctp_unregister_netdev(mctp_pcc_ndev->mdev.dev);
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
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.34.1


