Return-Path: <netdev+bounces-153491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99E9F83E4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AE188980E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68271AAA2E;
	Thu, 19 Dec 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qSzBRiW3"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023112.outbound.protection.outlook.com [52.101.44.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D41AA1FF;
	Thu, 19 Dec 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635783; cv=fail; b=JUyw8bkCkzOD1/W57N2WCGUHcpU2mNyvH+uZCXfZyrFkEW57bR3aZ8nQr6tITYmo54wMd0A+QThjFyCLPYseXQGogueBJ+0Jx7LO1wDV4X+oViWwwdKTUmkeqk4Rw8n+2sZ2JC80CT6OMXoxjqmeZd9sVmse+FzxDkP3YzVmTnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635783; c=relaxed/simple;
	bh=trxVEpBV6S5j8anal6eIYnj7avXdmNumbM0psivwygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfDMMP8nDqVX3nUX2HNw29dTMVtCutBuq9s0Abc6ADVIfOhvgsgnhF7IuoPG0wrhfSJJbzx3zHDeDdpdDe200m56u1GJeEGj8ZikJZcPfGzvPxVzpFp55CYPHHfkrByJcVKMC1vCFt1qudU5ixtoscimiv5dCUp52J/PmLje18w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qSzBRiW3; arc=fail smtp.client-ip=52.101.44.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COy6vjqNB/2bavg5ohzJKWuS4cIdyMRNVVxW4EQVDrO9fxr+vUHGlwcfmd+rVzeRGrT0Mda3THl5HlcAOrk9ScIECrH9Wj0HRy8JiDjtJotOtRgyU4Yt7EhNje1OJMJxGwHpXySpDIqItz3XbkxEclJXZoBUHZO0qq/jmQ51a1CXatkN2lNqHUV71k5sma9gOwDb7GJM6mLaMTGaHucwtplQc62D2Eg2RbN3hqeUG+j3kT1lbsh89lMtFkPCOvN0/3ikMKa9B0IfbukUHhJWHFrkfIKjizPfYud6l+7SWGjouNrkAU5u5HVeNQvtLuPZa1xv1P2dolDrhH+ZpWoYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOUJy3eRq3cy5jBeq2SnTH3R/fbWLGKsddOvyKtgvEk=;
 b=N5wT0+R+zve83lvs6P3lf9ybaz0R1gPIVwp1Yd4yelAkI5wwPS26jA6HHMwhxMkUvFxf9co0hfAGg0945tZYRQQygzK9ulg77OIp/05h0h6XbscG+TNaCwfJPFoPsCjneuLLjVVSwtE+3HFWRRi5wbLKU6pSzlUGhecRs2AwMZFnRKcMRdRpFr8+gFqdSSCpRRdoMvF+6NN1ACt/8zBDV1nsGO93sbFJPbSu5Fds9umbN5R1+tyzX5yeoBa7/iKe5dBE5dOmz7zFvm7Vv/E7i1ewKnlxrDITkyLLOExd/rMMM2+LN4DeOLhlaKOvJBVv//f9i+/Bovk07eRDkKTrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOUJy3eRq3cy5jBeq2SnTH3R/fbWLGKsddOvyKtgvEk=;
 b=qSzBRiW3IId61/d5oULgl1CY8tjtI9/yV4s/FgaMR+hrjzmiE6aJIWGdDyzYnMK9oL8G0jmT6Ygdb1WnIM5nprrtyRgaNau4B/NNB30YEZ1GNscQPShcfTdMtxu8YTEdQO+GRGOjex/xEIjCqIhnx19vAipVngrJ/oNJ1YN5Cl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB7527.prod.exchangelabs.com (2603:10b6:a03:3da::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 19:16:17 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8293.000; Thu, 19 Dec 2024
 19:16:17 +0000
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
Subject: [PATCH v10 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 19 Dec 2024 14:16:10 -0500
Message-ID: <20241219191610.257649-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219191610.257649-1-admiyo@os.amperecomputing.com>
References: <20241219191610.257649-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 62059a8e-50dd-4b8c-bda7-08dd20619cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpNAOLkLkeGNOfg/C5H4sT4j71ZAmaBJA29O3T1Ki7sDWUkbUj1v0CKox5sO?=
 =?us-ascii?Q?Knc8d5TJ5URq7na0eZ+nbatGiHH1LVBTxT7PwB6pgLAPqPVq/3MZDWKKLx5e?=
 =?us-ascii?Q?U1qXbGw/Z4OkErAAQTv5TUs7fvSG7RnAtf/X3JnxSqpSAIv2v9IccVDByGY6?=
 =?us-ascii?Q?cMz4I45MmWxewpEzn8iVYEpdDXVauJrXi1DsaSCN30B7c0vovXHRFxyiR8nG?=
 =?us-ascii?Q?2DkrDhBbvSlAMk+OiPxTRIGhZZVz3HFaQWW/xsNTUZZUC6sYfFVlEswfPkU3?=
 =?us-ascii?Q?tjUOK5/Gqlfc67osYOSN/qLUtKgjCwlM369LKsiZuSCptnB1sCzNkS/8OwIF?=
 =?us-ascii?Q?BM+lhKtdQ6QadeTbXtbYw7SoD3tw/37jJJN47zusMbPOQ+AY+UMpgTVY2dM8?=
 =?us-ascii?Q?uEWdCwC6xxzF5qxbha9ELeYQ85HNZ8Nc0YrZKXNJtbE5oeqh/PdbW98IF5+5?=
 =?us-ascii?Q?e3g0qrFxEtdWSCgRzKAvmdREU3IeRuM3gQkN8Ey1DjYAkUjWn0OYPqnTK7Ba?=
 =?us-ascii?Q?7wldNhDUMt+DZyraVnrcdZUeRumTRbvivb2jWwvOcXa4SRU+cGEaVErz2zpM?=
 =?us-ascii?Q?3VEVzEi9vsBybfv3kLYeloroB9jVyU3AhTCiz3DUpOTwpoeuHHzII9J0KOVv?=
 =?us-ascii?Q?M1gQHLNhK4g0QhvRTQm6iE50enjitOLYyWVJRb7DL9WpI+T6crh+FfE/4zbB?=
 =?us-ascii?Q?shXfxLMzGVHs1dB5dqEaJ3So8+B9DM4q/S1ErZZ4IzQ80Dcaosu7zT2XYvBv?=
 =?us-ascii?Q?V0bVBXR031AR3+qEGjGyJeiiIireH7olS9HnjQX1W6b0ELQaPaM807VcG8nM?=
 =?us-ascii?Q?ACFlkzdrYLa7p4x22ACFaXha3fvChjKy04SjEdKps8FLDOJzOwRsY4RJTBRd?=
 =?us-ascii?Q?d8laFakfykFLu0Pof1GSHZrmnzTJ6TRWputdu7739C4DL9qETgyqbsgxaZzK?=
 =?us-ascii?Q?5JGMcyiz/bX6bB6QYbfe36D6Ccz0QVMPcao+VTJV1Qbnybn569rexZCl/ZWl?=
 =?us-ascii?Q?Ffb71zPbjBMXdBHgpoT+LyyLuDPicUBclWK+y/Qrso4S8Ux/46nHrUVvT1bZ?=
 =?us-ascii?Q?nQobiYh6cG88nRQ/vAN7dZe999znt/w5PRi+tpnqvbxwoLOzPGWy/sDddbVz?=
 =?us-ascii?Q?4k078U3hVrBTMRFfDWKuiyff0+SmvWDXGmvFjZqfudg2FXV8QeoprDFgoO6u?=
 =?us-ascii?Q?nAFPD7UkvbSU7fmyjBP9IxVlRrrSM2nLbsD4Z7oaK7i1MXYM0fO9uW18BO9X?=
 =?us-ascii?Q?yskF4UbdCqm8xMY8Y0iyXzpUVj+eTsR62Lgf4U6p6zbEHXX0N0Yayxns2YoU?=
 =?us-ascii?Q?ASzdCXkR+jUswBopDrUu10msbbFdVa+c7Z3P0anvMfFCbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdgv5jiPPBYu4iMyCwwmLxrvmp0CP0z6gCZk81Bm4HWLTa6GPXptpflcJP5K?=
 =?us-ascii?Q?v3emy0nDwqQ6UvNU0MYRBvWtWHrWZAmYUPJXijJTHa29L41XD33OWdkTeL/n?=
 =?us-ascii?Q?LTqS+VXPajldDTyR+6TAzrsHDUkXz89OJsSh2Pl2lhkiWCzexL4264nrOb0q?=
 =?us-ascii?Q?mKsLgofUoq8vFtJXyQ9g9bwO3iWM7pbKlB36Uu0TQj+QOpc01EMhM3h1XcoN?=
 =?us-ascii?Q?KAOFSglfLj7uBh6Xtqj6cW/QScySSzDXazMh+JI6slL5gF3c/OT8Iwt/3MmL?=
 =?us-ascii?Q?O9bFmu18tgO2eb5pY/2Icg6PzUldOMCB6pRyDaXd+mdiJO2RnQitC5aRxe4R?=
 =?us-ascii?Q?OKaCaypaX2SAbmlDTBCJCMlXVI2v+ZpH8X/T6o5zXh6vte4lMzUwCTua5hd7?=
 =?us-ascii?Q?yYyKYgU79DRDATvChdCMzx1rtmP/qa5u2XP9C7lyckgqPAG0X+D8FQ5hKqXm?=
 =?us-ascii?Q?3a3thp4l+DzrT3suCEFS31T8SF9yMsbn7gwYhim5Db6DxTBbHUosNJzhPhaD?=
 =?us-ascii?Q?jZaBf3+JSzEuAxrLtptVX/aCxuSIShDBmztQKydqg2R0CLWwgWjcqaXbzixC?=
 =?us-ascii?Q?L0I4/xsURrKLkSwY82rq3i6UYZ48LSAh94HFR5pnzmztIMf26+ligAdWZU2A?=
 =?us-ascii?Q?ntfiGGMOhNRXNrLG9nu9kBi6pjlWCn9bB1GlLBCJXq6XEWo5aBe62fHfesAx?=
 =?us-ascii?Q?E4EVh05EKpKD0J3r9PQSDAWEZwUcfJDON5gkXDxmJnUQygsvjp3+khsjMIYT?=
 =?us-ascii?Q?yinP2+AMuKaO23vX6fLBUForr/ubNzJ2uDPnnmI8mxKNnHor87lTnzaFGgWG?=
 =?us-ascii?Q?xR/YO+QkfI3y23XWBpFm2WFHccKDgUHLqjJCGeR6yUc78uv91iody9Jb2cZt?=
 =?us-ascii?Q?UcpTiTI8Hz4H/Ai20o5+72LV+Jm43oHrmMLLxDI2gEeEmLiJHhzrK28rmpgM?=
 =?us-ascii?Q?MRKbDOSiFjhDWbVs3bzXzYSucP3lvqq2LXxZubgh36PJxZZyISxlRezmJhvc?=
 =?us-ascii?Q?9VMzaBzvQwVNZiEKg5InXwapllvp+uhvher21u2CSwC26W2Pbn5gdL3D9PQN?=
 =?us-ascii?Q?CbBIyy0742e7CpFEX54YFh73sxgImdP0HxSVEpv64iYuWogiavWGZ37PkhIO?=
 =?us-ascii?Q?SAtaWav5rnX3hAy9LnhYMPimcQxoVmz3DwXEpqpUC5lxgmZQK4Xh6Q6nLPQR?=
 =?us-ascii?Q?FuwQQ3tDce5qcxb4Vuhm9ejB0OgvAYH9O6fcWJ7cLtmGVb6rCvkWXwAqC33U?=
 =?us-ascii?Q?k7izOa5dYxxRAA5w5a8+kV+pF1kTFbWJ2I4UPw9hqkYlDSBMwVuqPrrU5bYI?=
 =?us-ascii?Q?PuXfJn0oywt8G4ZqV0NYz2T/3Q1z53QVggIsU3BB6nl4HgDt4GGBNQKcqfYe?=
 =?us-ascii?Q?FP3loeB26fqAWrXwGzkL9jZTub+WNfxxsr91rNRoKci5zVWDMycv7UF7+qrJ?=
 =?us-ascii?Q?IeI2v6/oivU8EiL8MghwPcgYaK39Ys/ih2icbIAQdkRaCQzih7b7pEM+SP5I?=
 =?us-ascii?Q?x4+avk7W7oIfw7mpP3ubxJ3DWZ3o3ei3uvDdYoGoU2FXBPYavpgI0/yLrnkI?=
 =?us-ascii?Q?wYGBrKNuSxkKmgj/ygVLP1RNUWZkJE/R+9kuOfwsL4PoYRgEbL5n5p1t9+Xn?=
 =?us-ascii?Q?USJHMTAeZ35A7L2L2qp3zMIgij68dDRs8O/X5y4/FpXWidgs85T6+y2EI+t2?=
 =?us-ascii?Q?bQpq9PKL0ojMQCZj8L5s6u4h/w4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62059a8e-50dd-4b8c-bda7-08dd20619cd8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:16:17.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJe5WcvQl0M2EX8gebVjtGgexxQOV2tCZnUHCh6usivdEyzsnmtWo8WNc2Vd+p7ul+k2sQRXSQe7YXKc0yBk1+hkoLPw9xjA+NDaANLNbWCVV82OptUTL5E3giHULBvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7527

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
 drivers/net/mctp/mctp-pcc.c | 307 ++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
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
index 000000000000..b114db230a26
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,307 @@
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
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
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
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	dev_dstats_tx_add(ndev, len);
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
+static void mctp_pcc_setup(struct net_device *ndev)
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
+	struct mctp_pcc_lookup_context *luc = context;
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
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
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


