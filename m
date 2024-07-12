Return-Path: <netdev+bounces-111007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4D92F40C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5B51C21650
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DFBA41;
	Fri, 12 Jul 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u+SHQHh/"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2D8821;
	Fri, 12 Jul 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751799; cv=fail; b=s0t9dYVsIfrYUMRIuq2stSmKmrWsnc1ocdtbZxw1w8lZccz/5PQbFmVzLfalcZYoH1G/m1s0fy8H3Fp7ymU4HVxSW5P8kpRL1ZFYbzsKfgwQUBw7B5kZl34fXuEmmOm/ePyExvuUsSRaM6OMUZt0UWKed4C03yZYjK0lUyXgKj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751799; c=relaxed/simple;
	bh=i0cUKz04+JzaXTgQZtxqvH1bRU6A/xYyyukuI7FxxOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tA09mtKQarruEpyfhvpPDUGUAZyegfcnhnVz6TZNLFCX1EKO2/fczn56LJstkYhpeiq27HAqZiOPHA0A14aMDiEBXBLneqi1VAMNvGgv7JUOKsfCRW0wVtS++jmMwqDISHJEuCihMVq9AmX80P8L1toZwnrgZ2ZVza8Zfbuliy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u+SHQHh/; arc=fail smtp.client-ip=52.101.61.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2UD/gOEVQEgyx5UJ8qOELS1/c+3PmCvEmJwrIAJJArqjyQXMOPHMdVFOfNbHZc3ItrLzLhmzHsERe4f9yUaySWqsZlK2WWdJOErxEjJBzeLxXFAF6h/6TzQ5h++fxQSly3JqyWSrd4hGbwCxoQ5lPzXQVPU+CvzfrqKJ92i1tqrGof8CT3evu82JeaJHtjMy1NE88nNSsBjbACFyqtLI4ajJ0aNiTuPEdj4wl3XFqnew3se8XoYkQ0LbIN61PzFiG9JdhMUz2FtDp2UB0SI9ivNavtnPBC86JZW+6H7s8QZbUgis9szgf0R/Q/4gD/PMXNGft/IZMoFeH1N+Gax5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyP5BdKCP5pyzHN12YgtgoPNGCDbn1FBSz7nlzjBidM=;
 b=Phh+R51TFLs1iUA5ZZ9ZHftILquBEe5YAZ4x4EoNqqWHjDEpX4VmbQGpRMdGfMtSoaOuIrKINtY7v1IcOQSAWV2EVGtLlrk7kWKEzAnQClFi7PjOGs4EcC5BtYdLKmBjSjxSIr2wv9hm6Pr6s6zotlbGP/k7K6PSy60a4hCXkqxA747hsZCV/Sjs0r1PRm3VOJ0TQTpTXNNLP2wmGTCVCvpPXywREBqsiEGsUs0UqjrmLgZBEJEYLylE7qUuTUuraRbAURJ+ybKFfii+NXBhKQZNazuTaQWykmz5h36GdLBl80F5aq20dpEkm6DYuGtPOgcE2ldi0xAx2B64TRyYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyP5BdKCP5pyzHN12YgtgoPNGCDbn1FBSz7nlzjBidM=;
 b=u+SHQHh/ZiWPeIlbUhXahczQZ/zQ7LaW0DcG7kE+Y5M1ezzBMya8CdyMuCa4GMX2Q5D7mZVoR744dneQfJNSpe7kbCDkFSWIJRiiPeeSOWztFLd/OWdHP5BoZTEziYHSyg5x4AaYT9ScUW5Tk19idCw6zp0cLEAlHHPI94EDr8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB6990.prod.exchangelabs.com (2603:10b6:408:16d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Fri, 12 Jul 2024 02:36:34 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 02:36:34 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v5 1/3] mctp pcc: Check before sending MCTP PCC response ACK
Date: Thu, 11 Jul 2024 22:36:24 -0400
Message-Id: <20240712023626.1010559-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:930:d2::24) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 251ebe09-bbae-4ca1-eea8-08dca21b7267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkUtJKV+lrCwxflWXgzhn+hlfcN4NEn0rewOmRmyVzVXKzH/278Tn7P02Nyk?=
 =?us-ascii?Q?lSk5SPFFKboTYOXs5FuJmKnP+9me2628RIDKGM2GsJYkyu7Yd2FjeNhhPxlE?=
 =?us-ascii?Q?Nqt6hZ/nQBNjI6XJjaXG3l4ffrBv2APyVneizv/fM4TPz1NYjCuCA4/ISGMZ?=
 =?us-ascii?Q?WGpqMxZfDP3H2cRxWwT1077rcKbEbmhB2Wx2qIOPYyA/b0OuTHOGztBCx1O+?=
 =?us-ascii?Q?asl8h7S/YEz5c2D8VydkIYHcgIszhiX733JkcH4scW7QOD4HzNNGR/c730eu?=
 =?us-ascii?Q?FJcTLkP2amFoY5no4rkjEEbuad8bXE5TGOh/96RJxqUbmIJ7lRdSXH2Yyfb0?=
 =?us-ascii?Q?nZsMM5YM5LGK1BLxcLpMV4y7+NU1yTN2DJLwC1rpCtS+uFlCYkkV4ll8Tuse?=
 =?us-ascii?Q?VV+yijkGFgu/E8Z6URQihU0mct56e5LKuTlh8/nkJFl3Yh1AxZ83LLJSC2Br?=
 =?us-ascii?Q?OalcXfp8V8yNrBTxYHNXUJBo+F8r9IXJZ+zamimHQsyRMLnRwkuhLJFA6k7O?=
 =?us-ascii?Q?gXUWN1gq06vyZLT4VqODEVnXrQJ8TijizH0VfvlXooxPGzNUcdJqjKkDlgWS?=
 =?us-ascii?Q?696f+eX7PY6zhNUf05J6KP8YpVT7MkJQU5FH+JaNlB0uHV7Kl3aWjG2l1HXb?=
 =?us-ascii?Q?5Wxr4drnSzK9HTVkWTZ0yDEw39lTN+sRPQKUT2EcIbD+JYE1WWjeAyeF8w1l?=
 =?us-ascii?Q?u75O4X9LxosZo6QHPl1dh09wnC8Fmwp28Rh9IU6S3l4iR3kQBYJFj/0cjYgd?=
 =?us-ascii?Q?sNubofm6YykK6R5/6D+rdYtqreK1v5FX397f9r8nhPO9GAtsmrRxWg1Nym/f?=
 =?us-ascii?Q?5exTZls4hzrAGhLepzOMOqQEeuJZqcz0m8BreeVEQ6P5L2UkQnRmuJ+6OB/L?=
 =?us-ascii?Q?BbrQM9d+1EkWwSrQ4aCZtFd70x+/H+ArJyqw+i5F8SaQ0inHTzYk1HdSySAl?=
 =?us-ascii?Q?5e6dP87CmBkOjwx6kjobpx11+E+0glXEP82B6Qf2xV3K5gsL2apWyckQBVzA?=
 =?us-ascii?Q?HgLPyy/AcyrC3FxP3FkM1IaH1Dj+31G0U8H7HdmAN+wPcVrndZS62n+N2YdD?=
 =?us-ascii?Q?+/NRrEYcdNVAsAnD9MNmiwjS27GFxNssHkahQuhroS88uKgs7HnbyTmkR0tk?=
 =?us-ascii?Q?QLBMYj3C6DQUFeumL4ItNW/kHenI0yP4bRQXOAqQbHNAiZ/37Ald4azE70w+?=
 =?us-ascii?Q?CX3nM0PgjHS4eJnYDIVGaITzVOA5oXH4WuCTzK86b2IJHwr2wWXxpE6hKGSq?=
 =?us-ascii?Q?7fKhANscsbJxywZvqpt+VkzAAf9LC7QbbWcDMa6v4i8UHKhFLMiDvNaNwWMY?=
 =?us-ascii?Q?3XvKAdhaLVxH7/DAeIIj8sHodLjnyUtzuMLwkCpypyIF9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Vsx4K9v47JqPDgS8sml89LHEDm3Zb0GhfO0wtZOjBB3qbXGmhx8jjIoxqtB?=
 =?us-ascii?Q?q+XaLcsIndclM6iHFilwiirK4lMbsYqhweXFgafxaB4FPhYc+sVFjDteiOnM?=
 =?us-ascii?Q?SerF+fsovcIoxf5eiXDwhOPGaFSJmYbfLuxmgPZs6vs1krt0xCnSkaGqEXN5?=
 =?us-ascii?Q?NpzFakqJzuvOOeVhct2X3IcbObn03s9QMB8kQzBay/Qg0/EKpLcRd09aCtrh?=
 =?us-ascii?Q?YJtgHuP02dhS++zBEqBuIkPlzJNKj0WNBdmPyb7zWxqaBLOtaA1ZEtgIEFJ6?=
 =?us-ascii?Q?3OBgLU4LQnYgjA8URomf+NJB3fzjm6X9LzCm7kYPIfYgOfwNOeKj7S02N5Am?=
 =?us-ascii?Q?fK6UmgeqLP+cp14nRhuR8pesrD7N8I9bC8wEcwIqoys5m8dR2xL6bPxeGjua?=
 =?us-ascii?Q?ath6964JmkPCIAKuSCKqTU97ZbaUXXm4r8yz87dyNYcu/hUHzs/UcG6Bfj1v?=
 =?us-ascii?Q?gElmSSd0VVtYZTn7hJjBg6Am/GTxj7K/pft0PXgE13nqXY0N0Vn/Zwal8R+D?=
 =?us-ascii?Q?6jxQ6qMISbO+mXQsBT5QjpETcvNZV5IqkuUi2FLOPexQJAT6B01ItNpjJmWB?=
 =?us-ascii?Q?iE8JeRJ/uX4WpZRgg5q7ocMAcwTS1uY0G5jFleD9OATi8WqUCJywVQeRdxS8?=
 =?us-ascii?Q?FR8GeTX42ShTxF6KEgFuSslDeP1GieuV0cHJEmKk80YHVrLHgmta89JZA6zT?=
 =?us-ascii?Q?sewfFbWjhxh+vxGhQ4l9EFHjlVzblb3AcBHtN8MrcTIvNTomzbwH+F16uR5J?=
 =?us-ascii?Q?zMgqUhpHuxutQbM6myObYydf2dEopmYJBUynrgAfzD1we1o01VlTOxuAB3Z4?=
 =?us-ascii?Q?R3u3kmUL5Af2ibYQpPvM2+XP3kB9tCLRdckV9q9mn04JaLoqRwK9Fiq7onQ5?=
 =?us-ascii?Q?G7cxBg8RAVj0hBIwWjihK8rCkV/m0Tz5Y0iLdW4I7L+1P+I35sHM4Wwdljfw?=
 =?us-ascii?Q?IhVwqGT4b1mTBO3iwrrNak/0xK0aODrW/pQabJmTuE0DjFm3hMFQpgiQhCMz?=
 =?us-ascii?Q?9SVoEDFFCILun5zkGBcasqE3UK/JFENpaRgfHz102HZmD2olRq1052SWqCuK?=
 =?us-ascii?Q?sYIjblE3Vzq8kxGyNOQ6JN0yXKxB44gm/aDBP5CSGxP7dA2euWeE6PmXGv9a?=
 =?us-ascii?Q?f4WKXNtlOok3uPaL0bPsbssoPcxI/tGKrYWzTjQZ97FRMSNhsoCEyZBmNqod?=
 =?us-ascii?Q?Ysfnh9RiPxKMtCaD0ywsYYiL4xHHdW7XP/L0A9OGe/jFfzHM/UYS5WHoH+A1?=
 =?us-ascii?Q?nk28GUWkf781rQxoiHQPDqKenrflESbUyT0T9GpaPE/9jtWzwnrvt3RwpZPE?=
 =?us-ascii?Q?MHRcLGsZ/izCQmCfLdDbiwz4pQHENCM/Hsbddzs8fsuYstbwMPkKc4MtVjcI?=
 =?us-ascii?Q?wcWUflYTU4wXwfoWMytbBVpfbHQTK7Ay1YsLmMFSDvxM1DuxRCa/SN2Ac5QG?=
 =?us-ascii?Q?XLU4f8VPxrdLGyTJ5Zfe0J0CBfSucFBxc6gSD+ZvGH81VFnwIhiJxqfPuRWy?=
 =?us-ascii?Q?5EkvC1h/Kar7KomppqTgE0olMpXVr1ZibX1QrhaNv8DWS+6iKfAzYuR+o1W+?=
 =?us-ascii?Q?bha80hZZ+plbBfXq2GHJ+ZDFCg/0yfCmOuZ9dBM0pnsG2s8QdLn9NrrlsBqK?=
 =?us-ascii?Q?/b/9drwcUvSqD3+IvDMUB3RUcF7iBJJ564rkIMr88hr/RfGSGb/HLi1oAvwu?=
 =?us-ascii?Q?JtbHX5sNcoGwY0bqaFaxh35OwPo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ebe09-bbae-4ca1-eea8-08dca21b7267
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:36:34.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRpguIS7dKoVvfPa5orVnW8wa5T2tZFIzYUUScI1LyEMM1HwY2RPWsTuaNK4tKUlcw+nlU8wHGskksb0CfrF/6qUC/JkIlhlccNzzUQ8wifQQnEWGE6rujeLcilgyv7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6990

From: Adam Young <admiyo@os.amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

In order to read the flag, this patch maps the shared
buffer to virtual memory.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 32 ++++++++++++++++++++++++--------
 include/acpi/pcc.h    |  8 ++++++++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..4a588f1b6ec2 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -90,6 +90,7 @@ struct pcc_chan_reg {
  * @cmd_complete: PCC register bundle for the command complete check register
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
+ * @shmem_base_addr: the virtual memory address of the shared buffer
  * @plat_irq: platform interrupt
  * @type: PCC subspace type
  * @plat_irq_flags: platform interrupt flags
@@ -107,6 +108,7 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_complete;
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
+	void __iomem *shmem_base_addr;
 	int plat_irq;
 	u8 type;
 	unsigned int plat_irq_flags;
@@ -269,6 +271,24 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
+{
+	struct pcc_extended_type_hdr pcc_hdr;
+
+	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return;
+	memcpy_fromio(&pcc_hdr, pchan->shmem_base_addr,
+		      sizeof(struct pcc_extended_type_hdr));
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * and ring doorbell after processing message.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 */
+	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+		pcc_send_data(chan, NULL);
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -306,14 +326,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
-	/*
-	 * The PCC slave subspace channel needs to set the command complete bit
-	 * and ring doorbell after processing message.
-	 *
-	 * The PCC master subspace channel clears chan_in_use to free channel.
-	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
-		pcc_send_data(chan, NULL);
+	check_and_ack(pchan, chan);
 	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
@@ -352,6 +365,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (rc)
 		return ERR_PTR(rc);
 
+	pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
+					      pchan->chan.shmem_base_addr,
+					      pchan->chan.shmem_size);
 	return &pchan->chan;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a77..0bcb86dc4de7 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -18,6 +18,13 @@ struct pcc_mbox_chan {
 	u16 min_turnaround_time;
 };
 
+struct pcc_extended_type_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char command[4];
+};
+
 /* Generic Communications Channel Shared Memory Region */
 #define PCC_SIGNATURE			0x50434300
 /* Generic Communications Channel Command Field */
@@ -31,6 +38,7 @@ struct pcc_mbox_chan {
 #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
 
 #define MAX_PCC_SUBSPACES	256
+#define PCC_ACK_FLAG_MASK	0x1
 
 #ifdef CONFIG_PCC
 extern struct pcc_mbox_chan *
-- 
2.34.1


