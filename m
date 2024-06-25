Return-Path: <netdev+bounces-106631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0E91709E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E5C1F22E39
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E117D360;
	Tue, 25 Jun 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u5ieBkyU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468017D351;
	Tue, 25 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341635; cv=fail; b=YqvS9f4Kw6I5IPOIiXIVivliOflTtCyuDwyuA2It/2OEWYxMZJ0Ekrw7xMIYg21ktAxsKmymnkPcDzc9JSYrGlRCDDjiS4jDGaHZxcjx0KWQytNscgY4DzVlB1E6fian3CZZCHRF1CmQ50UruyKo0IAdD9rAyD+a6SgIepvEeOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341635; c=relaxed/simple;
	bh=uBZy/HLLljtVSnU7DWSCCBwgSuM/ONDycaV7sjD/j5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czltDEu80nmuISmhqp0kfHkkKzznDW6WpV6lI03uS3SyAJu47i7t8171BmQSZlUOKN0XNp2mmoKNh4pwF+SHkAI4BIibgJd+CZ/iAQLMQUDjP/BJkEh4CjRGo1t2LAwCpBayH6V61CS6JT+wUjLPM5+2g0xlE48mw13kJ4KX/uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u5ieBkyU; arc=fail smtp.client-ip=40.107.93.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irdF6g6IYoFz8hlegTHpCKquKP3ITqopVHA5Jg/ajGKJdp2kdyuuO9wHMvi8C/skjcjY/jmW1Jn3/YCyRqPKk9GrjS+rhbGa6j1eAssw/InYQ/DoWbI+3COMYboAxQQMeh7AxFIrauBfTADqaSKSCPvM8xNZtP3iHc3KPG+wAclpyKcOYrfPyTDRKg/hmV+1BabCSA3DVxqXnJ/wujvcLefOgTLCrGoj4V1ykxZttqzfwvxxAPz33hy+Aa4ewM4LSr31aT45OQ5Fkja5zF0U/cjrppphKwrfGLxaF71Lc0pkPBELwhmn0OBSWhXEt+LCGPmhTbeaYKTOLjNOOz5YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg5+x1zaFeeWvnSFKzKHwfF07BbZJV/gdBORvR/sML8=;
 b=Vj9RioXzWDh7yeGiKgCobUDENB4o8eXNZfboA5JGVX8oKGvwQfhoFGdzd/TuXb0sqbQSJBPuqg9iuHetNiietq288X4n4whJIvg7CVT2Kw9sFH2AuTiRjQV+UBBspiClmGTY1iuWqQkEIjC5qFYEKLIWQhj8UYAqs1nIblhHrbQtrSoRZZeieIu0AM6i6BYI1ewAFayMsrohHQWLJUEb9/FQLt8+QOKUG+EtHAMr7b7bcSIELAqjhz5Eet8SQRgMQjX6d40WYbuQ7uqm6d42pxPHC3OX1GkjD5RD4CNd7A/T1ncY6xObBBv3NCVprkpi9vF8rFrWQ6WVkD3BdLRKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg5+x1zaFeeWvnSFKzKHwfF07BbZJV/gdBORvR/sML8=;
 b=u5ieBkyUIFG4nCwolHOLEv/GXlJfdoLmO/5HRdu7k4PTjsQQQDVaYdElgA8g4GKvTAJsZoMgItwNJ2RtCS6kVH1t2Nv6vbTyaLbKoaOah/GwicvRUMGJZuxpkxoV3zUCf8+jdDEDyiG+eXsKwFg5GdQdPY+KP17crzenPw7Mim0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH0PR01MB8070.prod.exchangelabs.com (2603:10b6:510:295::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 18:53:49 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:53:49 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 25 Jun 2024 14:53:33 -0400
Message-Id: <20240625185333.23211-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH0PR01MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d11197-d8d9-41f8-6a74-08dc9548268f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|52116012|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y11gS+mWihBh1dH5tLqjsKJCBnH3liNz4SgFsW7t54IfXc1SYkIxVbUs49eC?=
 =?us-ascii?Q?kkimF6Uia9nNjOU8OcR5pghhi/Pv5i//cbQsFOo9W+iXMhORps6FJuRNL21l?=
 =?us-ascii?Q?DXCLL2NERCs8t0JvppRFWU6570LWieMZK7RzT6haojgJdQODjItZ3gjVmupL?=
 =?us-ascii?Q?VMoMPOGtkYDJzW26G18JYm7rYtlFtT3j1FymRie9nTWNEGAInCSNZWqjG/L1?=
 =?us-ascii?Q?qHGdRp+iSqQ1yrJxzdRusfzL9cpwOzrSluSKBSLdCLJydWgDG0ZaLjbnypKF?=
 =?us-ascii?Q?kdC2ItuE5S+aBf1a+01W/PA9ez0eVj4jzCkKpUzpm4mclBBcWnJoEYTO+xWW?=
 =?us-ascii?Q?3eo4CTgzbdN6J5+E5mNwUu82tNhtFSGRvwaVCE9ZB3LiZZbr+OBRu8maXbxf?=
 =?us-ascii?Q?MnHBCJeaVybWyX4I6TWAqpB3HD6OCyvM/BqSQeeLWRtIv6u1b9Df1qYQwbUJ?=
 =?us-ascii?Q?e2RZecpu9LzIdNGahTeMoLpHtaDUStF5025PMeeoG4DfYZ4fV/7vG1BvK9Ie?=
 =?us-ascii?Q?TwT0hT0KUKuS63zlQjFc0h6vqVXWIPm5gVj6N63rA0++nA63OrwRpNVdTs4v?=
 =?us-ascii?Q?EGUGoVHy95QsUjmRMFcXZ2B2gFwG4KaMiYYtC+mcNxxyrTAsku/Y5Qc3ud4T?=
 =?us-ascii?Q?n4jmQuYrog02+HKyTf87KK8If/IDa7rtQCnxwBIeugMMh7N9Oo5Zgzi3g13H?=
 =?us-ascii?Q?PYc2kQMO1Bwl9jw6nXtS5w0DsU/+zRuMstCmIYFYFnVzGrbPt0xhbXbLzCTC?=
 =?us-ascii?Q?Qnu0Pz6bGZSW6tpBh1Mh0Zvhn0YSUed6XVPAP/jim6Xggf3Z3eYPCPMHmN2n?=
 =?us-ascii?Q?Umvlpyk6RfVtLp9xGCKie4CyA9DXD2hq7dWLLkONT+t36Ze5UtZlckhoJHPQ?=
 =?us-ascii?Q?XgB90XOQUyChjwnFBxDqPiFElBVprDPsafuMgRRPmkNRXFIOyzCna6oxHhIL?=
 =?us-ascii?Q?22G0vI02mdjPtkvYt/jyP1STt0PI1dHfcfBVXRbRm/jn0VzrvOX0ECSNPkWp?=
 =?us-ascii?Q?eSFbRycDbR9IzN09MgI93hVcIuLZgEvACp0UuxFJOw2x9MyFEbCm4xtXU3oU?=
 =?us-ascii?Q?9e84cDzbLTsQS/btyRhTKvaQ/vkwtnONKz5KjKTSP3y7u/nmnXcHVUrsEO89?=
 =?us-ascii?Q?Br7fZZ9udmNJ2fNqJByt3wYXf2cjCchvkh5mEt51Zkw7fDIsVf53nDrwBcSd?=
 =?us-ascii?Q?O9KgnVxj15pYzKld2mSQBf4DCuFIzl+Cv9gFcA4y8Yctxkqc9ABDBs99WTf+?=
 =?us-ascii?Q?ulumvcLdGStwz6ndXFjJ4LmSFj+Qh3HgspIp5F0HxJB6R+DIbkwqpyEGB2a3?=
 =?us-ascii?Q?QM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khEAT8+RfVYpRySF6IGvLB1neCiJJPm6ab/Ka/eD9yJG/4vN77Os9G9+u2Ks?=
 =?us-ascii?Q?Hhze/pLvqp8YWAa2MKmFkEBr9R18KhZaVwClTD42D1CQ4CoNaxRExOKXMTYT?=
 =?us-ascii?Q?QQTGhDn6z0Hvpfn4eED033A6CrgzC1KWt0HZHWVDsrJ7SzSmQdvMJgIgqVoF?=
 =?us-ascii?Q?BvBXGBP5S/ipcHMbqj2R/slDP2Bj20K5CpGo8A3QjRulbktickHky1TAiU19?=
 =?us-ascii?Q?7J5wdjbZ0YE/Sz8QBN+aeeBYRsfELPg81VDOOindxZwFIvN815gMkq+BBqyd?=
 =?us-ascii?Q?hORjq1fV2YeJDwWsJVFw9DQYmQJwjQ4w6y4Lx5mvtFHU5dmMtMG8c3RGPPe/?=
 =?us-ascii?Q?g+UeKzbmD5uGiJE+ZSN3KaNny/BHxRBJr3kQuqhX0Vs4noJ9JLa/huoDiqja?=
 =?us-ascii?Q?+nbqIT+XQbed9wpAZ4pwfklQZ28foU4q4E7hN5rUy+p3EZjan9CtY18Ki5Eg?=
 =?us-ascii?Q?hXZ53xZ9HeA8dYX9VM0G99dWsmRp8b5/eyrREGQ/K7cIbUyo9J1g+RPwKl5J?=
 =?us-ascii?Q?2d+H0qZrrQ5jOYnVl7iJTKfqWVDYEP/JiRT6b8sLrdf6AzkRrammhL4mE/GP?=
 =?us-ascii?Q?d4VfQ9EC65f2Tt3uVepM/BPwoY8M0pyG+zJff2+9cYZHoQXswrABNw/bPBQY?=
 =?us-ascii?Q?AUXRDBzJzeuKhd8tqOpzGeF7uyfZDiUrbR2xRNlLVR/5iYjDG4W+QvkDWze0?=
 =?us-ascii?Q?L8QbU9YVdHdgkHtySl4fPMKBiw+vgirXDOkiZyeunIng5LWTWsB9loW1k95p?=
 =?us-ascii?Q?QFligAFc6snEEeK76vd1Pacss6Oq68Oh6wIUwQJPeYs8sXiRAbNUlUi/uch/?=
 =?us-ascii?Q?PwUn25E126oAN5bMfDendYvKJyVRcSdO+uiq2hiE1E9opHLa7cVP8vp1PpjZ?=
 =?us-ascii?Q?IjlDdrQH0LBotz1xWM440iQaofgEDZDbhS1rP7U9BFIiSi/oZaP3otB+Mg3g?=
 =?us-ascii?Q?CwOmAqca1XI9VP9PeE5yqz3JlulYtyY1DuNYEHO7Xnx27CyCjHn/qtVEaB5o?=
 =?us-ascii?Q?YcqjS9FcQR76IJpQN5B4Ek/fSC3mWl2Cgvsx6pPEYqBC3CgWLvneojYCo0LT?=
 =?us-ascii?Q?fUbuBwH3ahPO+KrJv+89vWkR3VepYStupCZGDUzmpvGIrtiEStGX6fSsTdOU?=
 =?us-ascii?Q?WcT2QxqZU22Hzmqd1WEGhJT7jur/zXY9Nl9TqjsIOvKbiu/qsM7p6Ipo1s61?=
 =?us-ascii?Q?rKfHUidGn0jSmFMRKIxXJiJ2f+aogY18Qqa8b8H0G1NO7lAfmGLWwpodso0V?=
 =?us-ascii?Q?9EJC9XrP/RNQ0YZJ8hWTteUQqjiy+9vkoIQrUfNQZAaC5G+hBwAo6eI0JanL?=
 =?us-ascii?Q?WRiu2p1UA+9tNBSHkqmancWEtRubnQevgsu47Kij1GyYivMD1n7lIiZzwoqj?=
 =?us-ascii?Q?DwOsP9LMOMScRA/WyMwx9bl/iB8C8eDJa5WT+GNeVylLQY5Md6OvkktVy7D9?=
 =?us-ascii?Q?jFlcRmTl2cY3F1f9jeAK0Vh3TrSp5ruWWYqAH4qYU5HeipDS1mMn8ENr2myr?=
 =?us-ascii?Q?mScOPiwbU+yBXWZIOyyT0G2isXB2gmvTNQ4loIhwhQeqDk8atzSCZj5dxYMY?=
 =?us-ascii?Q?lkxAhemid4Yf6LJ5hpYtAKtio6Z2boX31daLIAaBHMeYL0DBiWDB/cA2Cg+q?=
 =?us-ascii?Q?ainXCzaHID035x1LPoW8/XWXLyZP0Y+499wSFWdVaxvcIOgqN989kUUNnR2R?=
 =?us-ascii?Q?qwd2UGgILKDq0he6le6GJcRdaKg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d11197-d8d9-41f8-6a74-08dc9548268f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:53:49.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrZjT1vI7XTwbTLfJHxfolBDwG+QCX0Xzkq4oc4QJvqiJvlsuYtAOFykKl2EefiSOTuyYjpr1hSQpkBVmylzbh3cVMmpVSfNEvPCNBjF77Cc9Akw25DWGx0sntGRF+OP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8070

From: Adam Young <admiyo@amperecomputing.com>

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
 drivers/net/mctp/mctp-pcc.c | 343 ++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
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
index 000000000000..9ef4eefabd58
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,343 @@
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
+static struct list_head mctp_pcc_ndevs = LIST_HEAD_INIT(mctp_pcc_ndevs);
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
+static void mctp_pcc_driver_remove(struct acpi_device *adev)
+{
+	struct list_head *ptr;
+	struct list_head *tmp;
+
+	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
+		struct net_device *ndev;
+		struct mctp_pcc_ndev *mctp_pcc_dev;
+
+		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
+		if (mctp_pcc_dev->acpi_device != adev)
+			continue;
+		pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
+		pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
+		ndev = mctp_pcc_dev->mdev.dev;
+		if (ndev)
+			mctp_unregister_netdev(ndev);
+		list_del(ptr);
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
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.34.1


