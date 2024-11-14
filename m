Return-Path: <netdev+bounces-144658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3F9C8106
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD3B22FC8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8301EABC1;
	Thu, 14 Nov 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RfEo6jGD"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020093.outbound.protection.outlook.com [52.101.61.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075C1E9063;
	Thu, 14 Nov 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552589; cv=fail; b=Z88KiAtpSxvZxvmKZ3Hg6es3An8ns8ubCUOR8ntYTM1UFqakKwWKxOYoiZrbqs7n08OyYnIYS39PrjfJGz/cgY2h9W4sCdq0V8YQgdQH2V6uG4A2v3bYUUdXMvPTTANE8FQ+BdlDqyDYsoCYiU8Ira76FFIUNBuGHicdie+WBRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552589; c=relaxed/simple;
	bh=HCGvzfPLhlU4WUGrgDX+ktnfdTwDl0zdQsWxKkJzpKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2Sa32qkNMa+WCF5lCjxslOELQGr2vTXo0t6HxdgIBker2EVU3GbUSGqGx3DC4Ifw4r4d+LGTBqrpTfHypMXNjkxQoIJqlN3sgO//zPiDEs3ZgG2wRAGOgxtOGs7OYQ7MERjahMsh+lDYlCmRvQ+nG450GlZ3WwoYw0ZbEaDv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RfEo6jGD; arc=fail smtp.client-ip=52.101.61.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVh4MIqioWRk2AI/liKBbxDWuPHj5nReJlf9jL9Dl3py6QGFcwtwn57WhqoxWZrsJfIYVh/bz2VFW5UX/OQDanGEJmecF4N44hyOLtf1T1z3eEncUetCrDgtbygMg14qzxR79szWQ1y3pbKxlmcAvWeKQ8h4/nPqg62A6Vds/QqOa9Hl2uBgcyI06BWC/Tw2222b+mFcyrLRiv7Xrv9nqgFIPqtFFt5jsb6mvbk1CCT85KHCTg2M+48dn6N/h9wshqXAqOYkZ5wEOpJV2lWK8Ccv5ImUTgUAHXB1ay13nF4H1O/7ZKkQ6+fseimPPNzAJeA8YX0VUq2BmLGUIDVo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azwPJC0CQJCk8F330NDGnloRaXQX7EsBnaD6N8rqEbc=;
 b=xdM12RBODK0kdnd4uhXKWxqF0c5IjCkJ6r+E8jW45cDEdvnJNInDta1ymyczkXC7lE09CXuS+SAc3Rc7DIrb2bHuVqcme+8z90jI7suZ5pvXGCfLWczov/udU9DlX7ZdZHGK4fJyKJPW3dlfpRVQnRd2iishcKDWiy0UEMbvhgjkX7wXGzJTs3TI8HSvBLoMLowUpVj1w/xkW2K58+G4LZYWN+63IgHpSyXxt/bWJDCA8ZJ217n+HfWszpeQNzHc6HBJPGkaA/Ee/n5WrHXmtFmFqRq/Qch9c5LpZnvDaP0HygcXTuWqhesCdzhIu8SblvVzEBoZRmLFFp8i+3AOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azwPJC0CQJCk8F330NDGnloRaXQX7EsBnaD6N8rqEbc=;
 b=RfEo6jGDIAft0E3o6RU++68aXZxCTA1wA9jKzV5fSLJjX3avyfXupFHZd31xarpHWpA7jRXXtL0RCOgdsaMMTLWLmpFte9UsXBGio21UkQGJcfUVDPSS0yE61OnfJmdPVu4+HyFFHBvOJPlKWZ8VVtnhgnm945wyPqjymAKW+DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MN0PR01MB7804.prod.exchangelabs.com (2603:10b6:208:37f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 02:49:44 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 02:49:44 +0000
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
Subject: [PATCH v7 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 13 Nov 2024 21:49:27 -0500
Message-ID: <20241114024928.60004-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
References: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MN0PR01MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: c475706f-eba7-4a58-0bef-08dd0456fea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUaEv3G4CKm/VcuIi8CvoA/VAc4JuINr5aS6umWvy1tlf+rZ+K54zYGHZKR9?=
 =?us-ascii?Q?0XnuKrxHVhrBa/qz/Dfa5ocygZkcdS2dW4mWFyDLBwvfYSWoHFfeeGYaHmXF?=
 =?us-ascii?Q?DEQ8TPgt/b0ie6O1fOQTpdehTyN7AokcrGsWyYWKU3CIEjw1dHSIuNHzWKgI?=
 =?us-ascii?Q?dLENQvzHf7vUZXYJ9gqtf5ff4SoxkyLo+hdnd+Zynn3lwnRlG0RaCLjVu7EN?=
 =?us-ascii?Q?llJY/QgwjaZ93trhvyi37fwgECXO9cgR9r+qF1hqAvaEKM4V3gBLxA9N2Ykj?=
 =?us-ascii?Q?34R1U5SfMS7bUQG4kbEOeuViw+1FqdD4/4pgd+y66QYfYPDRkh96xhZqTgSi?=
 =?us-ascii?Q?LrLvKRhbvzjps3U022nimaRzHthi2MKEeu1u7QbVVHX+EdIaSxo5cmpiDAfb?=
 =?us-ascii?Q?SKu28+aX40x89eAYY981RY9YcJ58bWfHLLtUFHtQMXEZJDDG2UTU1fPiC/bB?=
 =?us-ascii?Q?ViLyGyJUA5Sxw7qeeEH8ZTmzuA1WhxB/EBqIt6Z6hSayzRrVgrEIBaTHNE/v?=
 =?us-ascii?Q?JORILbWaRJjNfK9FY+lBBLQBVpFGB7OBM+PZUi834oFr1SlgEmUq7aNQ/ytn?=
 =?us-ascii?Q?uP/7u7U3twyRatg2e9i8zoj46x60e0Y7Ry0q5ssENSTOWC4qxZc1QPjwMKn7?=
 =?us-ascii?Q?nUai7iiwHt25kMiW9cA2xC0OPode6EF3drAU3oVcr8QSCVNAFHkr0u05KBp3?=
 =?us-ascii?Q?CcYcM1xSYWvIoiMbKWrBHLEtr/8MTRAboSP2WMN2nwodZCb51qzjg43JSFiE?=
 =?us-ascii?Q?4TepjsHwIFVzJDhTjLts77xl0SVNBiFzIlj93qx7Pp+LV/eBzjimQ72QXvdW?=
 =?us-ascii?Q?sQ0WItr+VnhYoNjTGqu28q8uYD01OBsFI01OcUH7TOs8b6A1T9QskVAif8IT?=
 =?us-ascii?Q?hqaN/ijWnO6uDP/PtEucdMye2t0kk59YgqfD8fKn6QD6NRaR1pBlhYlhf5KJ?=
 =?us-ascii?Q?70psakDdLRA/OmIdx9uUKB7tZrJ3713I9Er5I9gIqEEnXv9w1OReu5BGy6cd?=
 =?us-ascii?Q?y1qdctPzdn1NWY+1Y1WI7d6kon9WACKQjNaK8quP3gAvpXxHzWr9/K+aIuWa?=
 =?us-ascii?Q?kgXW/mrNnCiSNqyZE1PbuEWvU3izzSCSBGDfSlCp1nSuWBSejwBsB7f+2r87?=
 =?us-ascii?Q?X/4RdmuEOO+UNBovNvJG6Q+iehoQgLuAiX5aR8BRXxyiT6b/iBXRIoSrOHHO?=
 =?us-ascii?Q?wwPf9NuBGMObYVtdkS6m265Bi9RmesWZQbr5MWeu6csc7pdoueyw8OkGekuT?=
 =?us-ascii?Q?Ne9uqZfUO6I2UOOG5lmH3Uqe/WIucutD1nk+1NRydg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WpiAztdWwNr8J8dQrHlsPjqLXPolXDuAMowsf6GN08hA5q3a80lM2qkyEdZE?=
 =?us-ascii?Q?SH7lsIqrWyITzvSDRbdBnFy5Wxm/DuDMG87fzV4N2qyfF4CI1hBLVH23MwKq?=
 =?us-ascii?Q?tpXw/+c55LeBEbRRlkBUDpnruk7YJDzzo8NRmhwrrc/Bb6HWGxoBKmvX3JBt?=
 =?us-ascii?Q?97i5DuVhuywxE2FpN0I18UuudtrMtWTMz6ui2zdzpZ+VQQ8fjwrL2qH826rK?=
 =?us-ascii?Q?iCJHnQTNtgQDWFOKJDGkuKOFIx5lZ7bVWs+St3cLOpDgMoE1Us78eoGKZqXJ?=
 =?us-ascii?Q?VZsw5qkYfWLNaRPLVpuOrZFVvnr5oNXdBDQnkRUUqRQt7d1I8CqkgCQcGjrL?=
 =?us-ascii?Q?dFryHl+MnBfzDy+MCRpSnUZtSEUCDpL9fnkaFE27+9TE/+tphQPX578Ou8A2?=
 =?us-ascii?Q?h+eE3v9JGN3QQxAp9jVHJOJOAOu7x3MGMVguo1OnjrANs7iwLkzD5Bufk+Rs?=
 =?us-ascii?Q?7BrhajBS/Wftrz7FckK744QVg1gA6mShnMf44bH+b6J6lo78RRsv6f/I+kqq?=
 =?us-ascii?Q?OOX0iOaOTTDiak0cLYtntvNtUMayJKGEbY1iH+hfENfGetUynPNG5VtBOY89?=
 =?us-ascii?Q?6AZ/isx51Tp6p0Ps3ORVSgPD/AufPCOAv4yFFQSXDQut2T53M9tmJ+jZreir?=
 =?us-ascii?Q?pCFvW9hCzpllwoQ137cOuG9FKIPqsLnYfdWkI04w++JcQf2sE1eJPthi3s1Y?=
 =?us-ascii?Q?Bkva6LjditMRAMf0DXrd2vF5I1+em5PNlHLLSpRypfWFcjc7gJFsexwv5hvp?=
 =?us-ascii?Q?Rzsb7ilOwIfWVdQcwL11w3omZAYSxlDWgdicHanxSYAPjpHyV8sF8/0lgkBN?=
 =?us-ascii?Q?eJtYijSKibYv0T/JU1aG9Avt21AEjH9GMkpp8reqQG9n7ckXzPo5N6Os3nTW?=
 =?us-ascii?Q?/2o+gLRUqM5kqWbjJt/afMqMDnxz3hRsq/qI0pFgW7uKhVZC5N1Aia820bGb?=
 =?us-ascii?Q?FbpZblmHxWkvnPpXhN6jsPQCL3jONADvZhTRry/gYqjRSdwtRa+5OQD6pp0a?=
 =?us-ascii?Q?qA9IJ7HTvE7zrORZE2Var/PEEg7I1bhfpAJ0zvJkFM7NsWaMDLldIMRm51ll?=
 =?us-ascii?Q?08Nmv9Yvzek4RZiOwwBFEnFUkQ9LLhCDK+bZ4r8yvK5d73v9T4M9695sj/HW?=
 =?us-ascii?Q?cwTgj5UyNC1SjhAbxa6wcmGlyatifzsSsTTR6FgCsXN6hKz0mSfNfFNBpGWw?=
 =?us-ascii?Q?kgOnMunMnlrl2Js6zFKX7JwHafBtlnua0NNO1wS6nOsHLQkojjJ5jH15a7Ij?=
 =?us-ascii?Q?IknYv0tHwurHwknE/RPrllffAShdG4hlJSiV9O7E5Dt9HsmCSCT6FxP5fZUn?=
 =?us-ascii?Q?rcizktW6SXJjYJ1eQR7d83yscorb3KfVLArFCd3h72YS0enlz9c0KecbgRWS?=
 =?us-ascii?Q?pWYSvfK+AIkYp6jpd+PtUcNkC7UhqKVLj/NQoaIqPL8c7nOSnzWk0ReBOyea?=
 =?us-ascii?Q?mtyLLY6b3lr/ucX6Lk9gpbh86dOqDrsfxJrv+cYqLiUxivYWgcYtwsx0lm/5?=
 =?us-ascii?Q?KcoCefNDsKTI3cVwMU35WzE8a/iEZISJBb2py5QJq+umeauS7kJTRfFGv7Nu?=
 =?us-ascii?Q?LgBYQFhtF9yWVxYmzuZH5PsO/1kXSJ17XxbLYMnU/wuga+rz8i0l0cAO1ns1?=
 =?us-ascii?Q?MenHCp3hgQDxnfYEOI/ar6oPdRxHmanow4JZP3r/eSgoHdp3EMDzWYZR8hpU?=
 =?us-ascii?Q?Cc24EAesYD34JPjBJy1PCqm+mqk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c475706f-eba7-4a58-0bef-08dd0456fea3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 02:49:44.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlWjdZ4c71uJ+CKOsH6nOZvhfv6MScrMcOlutHVGCqt8EYCxirybM4lLeKlNtw4/XweEOaO+FVrVMg38f3rcKPHZYvjq3wnjn+zdfFL9/8PBTnlMoA80kvQmTdE8kqwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7804

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
 drivers/net/mctp/mctp-pcc.c | 324 ++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..7e55db0fb7a0 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
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
index 000000000000..489f42849a24
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implelmentation of MCTP over PCC DMTF Specification 256
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
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+struct mctp_pcc_hw_addr {
+	__be32 parent_id;
+	__be16 inbox_id;
+	__be16 outbox_id;
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
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+
+	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
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
+	memcpy_fromio(skb_buf, mctp_pcc_dev->inbox.chan->shmem, data_len);
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
+	struct mctp_pcc_hdr *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;
+	mctp_pcc_header->flags = PCC_HEADER_FLAGS;
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->outbox.chan->shmem;
+	memcpy_toio(buffer, skb->data, skb->len);
+	mbox_send_message(mpnd->outbox.chan->mchan, NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static void
+mctp_pcc_net_stats(struct net_device *net_dev,
+		   struct rtnl_link_stats64 *stats)
+{
+	stats->rx_errors = 0;
+	stats->rx_packets = net_dev->stats.rx_packets;
+	stats->tx_packets = net_dev->stats.tx_packets;
+	stats->rx_dropped = 0;
+	stats->tx_bytes = net_dev->stats.tx_bytes;
+	stats->rx_bytes = net_dev->stats.rx_bytes;
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
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
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
+	dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS");
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


