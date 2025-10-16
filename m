Return-Path: <netdev+bounces-230226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5594BE5801
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884F219A3889
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC72E54A1;
	Thu, 16 Oct 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="F0WWDzSV"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020088.outbound.protection.outlook.com [40.93.198.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083A2E4241;
	Thu, 16 Oct 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648564; cv=fail; b=h/HbYE84uPbAHujnF1FXqRBEsbkmfgNADgiCa0smDSICi0DrTCM7nDd2EgUbb40OVvmQzDsvol7LrWGqpKoG3wvGCfMQDZZ6Q8e5rdoOGVhpiw7OKUFJzqe8+SN/kyA1jXJTnZBI1zdqnYZYGr2ecLQg2CFHONhGD+tEyKTuPM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648564; c=relaxed/simple;
	bh=n9TdpqXyL/m0/aa0fEfrmyZ9imoQ5KKsmi4uwAKdQI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7pychX9euVTc1axogRsqpwYwqSpjHr/x9WXtLMJvMuj8fmapRZvHovRq1Z87hC5iSZGTZDhluXE2bE0qVGy9XtGDMBPhpc6kWPMUd3UxV0yp0lZ5bHn+suTYC3mQrCf0NnhOQC1KW0E53nBEuxdVMhxENY3fSVH00mz5i1vKu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=F0WWDzSV; arc=fail smtp.client-ip=40.93.198.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCT56ZL7svMtq0IYmfDkIIrV2m+Oa6iuWNOWlZFbONcortYMJdmrE6Je4Re0ymvEQ6d8/Jn81wa+TTQJKc/09i9WNzQWFqASo+BzSdiVIBHdvhKawfpffnThNx1mB2vMRFW+reJly6uEjpbvpmKLvJCFt4wo3sT9/j2nTu3chmo84mKPLwvsVZ3OZ/cEnHm6etnnodWtMsw8L7N9e9GG83hilB6/rJYsMcxeCz9+NsC9/+yYoAqMP09NhQ6Mj073v4jfDaO3YwMHTySGOIX5TJLlaMVwUidYjgbCieVYmycI0GaU+3zIj9lVlTqgAhmmCxEEwFsGAkJsJiDzRztnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X6Qv+hsrnR3JTGUbCGWIyPZUYsnRb4apcYKid5+7XA=;
 b=iIxvfkiQfFvk0v+W7tyYyq8R2TfKu9xVwXqfkv3HA2vcqGlrOH11HWSqxYm0WUzjtpgNMKMSTFA79YwFyE4JFWTjlnEKgyCQy7MOvKTylCdkNsip946HUhx2o8lkzLZaczNk/Ddi+h1e0OUzZGrW7eqsBfbm9miqSg0nFYddVw+blbgu+PIsgkAzjSZUvHYgMRyUegr/Z8SFBUZ+PCgU1WYjPxHq3xN/VZ+WHnj5eJDU16oLUAUyATDo6IzT3Qhe8/fnMmeB3oo64n2LIAtg6d7pKNsXkILkKVyWYDKG2KQg8oc8VImzXb9ejxWESBv9PL9FoGHoJFdgpfu6LFTh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X6Qv+hsrnR3JTGUbCGWIyPZUYsnRb4apcYKid5+7XA=;
 b=F0WWDzSVnRq4zF2AClryWuyGGDTEP6BiJlGpQ3lZZ0RkiRBZMUnOA8gbX0QYl1wKOJlTr7zA/30C27fIlC81Cces8xkmkWHXa9obxis3kL1OizAUxmoFvyiH8LTpKM7PvQAAHgkiOmH8CJrDjC04T6P4AZRWXZEtegnK7nXS0IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV2PR01MB7813.prod.exchangelabs.com (2603:10b6:408:171::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 21:02:41 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 21:02:41 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
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
Subject: [PATCH  v30 2/3] mailbox: pcc: functions for reading and writing PCC extended data
Date: Thu, 16 Oct 2025 17:02:20 -0400
Message-ID: <20251016210225.612639-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:930:8f::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV2PR01MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 44523f82-b3b1-44ee-e518-08de0cf7581d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaM97YuWWS5cy1RJbBrbjLb0Gog7RNpO+iO4w4jIJ1aiqKx3SPGQbWbFE9em?=
 =?us-ascii?Q?8Now4J3ETjNQi1zQOlZtT6GZwGfn4x5PBRco/hz81HVumcUKtJYM4v9I59cL?=
 =?us-ascii?Q?h8qst7Q4oHD2Vpvu2zqEgE+5jM+oVmiwrWGE6KkYDMVo2n3WiH8kLcHPJt9u?=
 =?us-ascii?Q?bW2h4gjXP6+MCVoFwKj+vNxePjVfAkJYotYXEFQPJCzKMAumOseXiZ7T701C?=
 =?us-ascii?Q?taVGvpFFytNalcFP4+9KsS8dU6tKMS9JmtFLBIb7IOL6EM081/DAgHKK9zvL?=
 =?us-ascii?Q?7LebPeq/DZKh5RIbx9WNIsx7pqNGBFwMSABjuKm1YiFU1sKJdwX2h4qB3Vev?=
 =?us-ascii?Q?obfz01f6ukn6QPCWY6xMt6bKnJp+YkRZau+mJyttnps6EXU48MEpKYRmQupb?=
 =?us-ascii?Q?BOAqWD1RSLIh3qgzLli04zgmjhVNVx1Q8sk1bjJRCLpuiK8Lc0pyxCD62Vrw?=
 =?us-ascii?Q?6FkLP+9rtIq+rcHXT/RDB72+vwlZ+FdwXLy6nlIIWhmDh8jyo/l6seCRAlGY?=
 =?us-ascii?Q?Whil0BBQeJVOzoTYu17bIreXzBO/x6Nos5MQRdtm5/TEttRq66da9Kje8Jow?=
 =?us-ascii?Q?7TtdKZToDPXSxgdVTg0Y8Lf2cI9x5TAW+qxMAQn3KfVEMkGijaAGu+o2Ar1w?=
 =?us-ascii?Q?sLv+fmLSZmQL1F/1etAqtHFcZvXVY5wz4M7U8HWN2++aUlG/vFIPQrly7KOu?=
 =?us-ascii?Q?5PjK5lY8FnSvKNNShX79e069OxVw5rvyGN3rbfmm0d1lXSljzMYF38KG5Tqe?=
 =?us-ascii?Q?j76hZeZhuPVzrEbpttkVkoxCGTPf4Z4G+2GPxgP7DPs871FsF4ADnTOJrSQP?=
 =?us-ascii?Q?p53k8cmuKIFAo6OVS1BCf103Pe+ZiqnG8cUa0XW2GfPbDBC97rJgAUjrXhq/?=
 =?us-ascii?Q?4P3qGBPbZv7CwKJUzpwcohLht++NhHNxj+4wnWSZRgKQ7nyJPR0QEWVvYx2M?=
 =?us-ascii?Q?gVh6PIyILlobGM2KXx3q2EG+hBOLN7yXTCnejSHI7X8Ep4uuQwQbs2matV82?=
 =?us-ascii?Q?SD7UxUvQvUxKPk8O3KU8Z7CBXwY1MmPg8d9c3fsQgqbXjKJjdE9JciXi46gR?=
 =?us-ascii?Q?eG3TrYmiU0UCu2nspJQDd8PAPUq2H1DK9H5A6aRLV/41pzMf4MlBH/AgH/cJ?=
 =?us-ascii?Q?VD2KexlVnjqSaC/rbaFnTZwXOLrvMaqbQwfHByUOBuRTUt/GopUue452RepE?=
 =?us-ascii?Q?RD6CHgwOfP+2bhHB1GKFaAkpgxN9giV9WepPxWOU2btgS8//pcrPPKkK+Il8?=
 =?us-ascii?Q?Mqs36pNtKffUxFngw2KlKtUJ/vi8lZuW1XvMa0o34jjokhxfddET9Q0DGv4t?=
 =?us-ascii?Q?M9m/HYspAnl2UU0AlgBTZlyw9MukqqsPn8F1J9FZX4v4ocx6x8Aao0xpdhss?=
 =?us-ascii?Q?0l+jBR9yUjXh0j7J27TcWcrmS55gvzabt4T9lDHBy6cdf3eXVZv3Tp4wG6Bl?=
 =?us-ascii?Q?yzIDc6fcgDr3TYS3/c64QNUeFIwb/V2T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXGiL46Oj7DSJw+EpYs43irytXIMsrevHSu1Q/1GIQdVnk3lm7G4EX2wcKIW?=
 =?us-ascii?Q?+xlAMr2XaFLxysKYBQB7Ax7j5TKXOn8wgVB8SqJmwFQi06td4fCKfcSGywzJ?=
 =?us-ascii?Q?J6MB5dW6sAh71gT2kuAIOdgP+T+MgT+rliHC/tBLodiytPl34hDwPG+fczMM?=
 =?us-ascii?Q?fdgPFoofRGJArMx5LituDH94L/OmKASeCqmUejDWdruzEZQWUg9WUsysU/gs?=
 =?us-ascii?Q?OY7Erf2rQfFbi0Z1g7af2S9DnGPPHGKFUBGpMHkdhyAYICszjWw9LfWYz9eJ?=
 =?us-ascii?Q?x3/+sVCeaOZIGcCMdPsq0JdFXUqhgaplLvZro1nf57fWiTqFbyDA0jitEU1/?=
 =?us-ascii?Q?DcnrPjXl499KQlUjOywmxDEWazS5XLwup5swCPFEZdcru7/Bmpwl18GaHl2d?=
 =?us-ascii?Q?EOEMar9fALFCmnikNidMkXfBH1jsu44sn2QeSthzVl96ks5BMTpMzxqxil2c?=
 =?us-ascii?Q?V9o1aY55nc/oByuWK/wTu7AiZiMnlaHyHG+SK/kORcGGlLsb9dSdvqa3SdTy?=
 =?us-ascii?Q?Gn4jXsTv/JScIEvFhIw8r+nYPot0XHyS0hk+x7dzvrK7xI3RG5Ro9k4X2F+h?=
 =?us-ascii?Q?A2UNnKmblNuLnEp51xUA3w0mzTmAlhh28sUvfPtXJDndeXMUKI+rMWzoZmVg?=
 =?us-ascii?Q?o+g30iC7uUSVDDIwIVykm6GJfkWWb5wOpqo4NIY93GPhYs+jbPVm70Ng5Sru?=
 =?us-ascii?Q?WM24OXqHrG/Q63bIj178yrzncw1OEgn0Dcdkl37DRADu2nptmnL1j0MAfGRh?=
 =?us-ascii?Q?txTkl0qG71TLmmTJjeMBm1rAOMeb5ZOkH0dfOORdykwfVPmstHrtlhrEm12G?=
 =?us-ascii?Q?xxNWmRvsmfQh9Q/KLSQBf7SwQHwjHvIOOnMpauVz+obeIed3Li/hQ/YO3eAO?=
 =?us-ascii?Q?5iHy/PZJsstfDsqcn8QGPZ3aJ68zCHTl88vgT8t56VXEak3Ovyg7JMiSctMO?=
 =?us-ascii?Q?CIZPmmQzB0m8T2x6V31IB2OOJ5y/EjlqhI/Xefaph+LuQ/wIKYRIoPoYqYv/?=
 =?us-ascii?Q?HRK6anpPLaLFfIUIM0cVDttSzk+hOPsxXpMx6o5Am6iBz8M68ZMqauDQMaBh?=
 =?us-ascii?Q?K/2BKE+KYUQgRWGuJdOgv0FpE0IibCKWHO5XFLvQLnv55OMfQruvfChZTaU0?=
 =?us-ascii?Q?aWE0/4R9DubmAFRwke8EF5ENZdT4Fnk8jJbL2JODETxq8LMJV7cSFP+Lejea?=
 =?us-ascii?Q?MTdGvF78DmqJsGAjTXgqoYC39eWQnvIPJF85QKFXTVfQMDg8/Q2Pm2HNdAa0?=
 =?us-ascii?Q?oUyzL9r9q9fMOKYeJ4mDslSdoUuwh2kP6vM5raJb/7XtMnGQ268mglY/PFEn?=
 =?us-ascii?Q?p8lfDUdnpktaSTxLu1LUkrJdvmQFQsNvJAzRoHPWs+9fX6RlBJfwBudF3JtW?=
 =?us-ascii?Q?zBAo+jtLSCr6pKPG1kccv1Fbp+SoTQuwfLfxRha/ex3BUCJmE0fMebisCLnG?=
 =?us-ascii?Q?+FtG4QueJTKKVQYtFfRFy5n/vaoeiKWEKghsfvsEi2tDEguOTl7RmVZBbQRj?=
 =?us-ascii?Q?YBrItPVBJ7njFyhxJ8vj5O4j2Z+gRydYrGbQdMAU9/RC1d8SWAm4DXHmlHdN?=
 =?us-ascii?Q?J+rS5do6upJlJ4kA6zmbfTH3GF16K+eH+wWPEYzORejnhSxun2oMksONivDu?=
 =?us-ascii?Q?ZaGTwVPikJ5NbE8JtqV2CRQx4/AWig5Eq1GRnALw1N375ARh7EpuVWmQuMzb?=
 =?us-ascii?Q?PeBar5aiR3HjtCblizjRUO6uhZY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44523f82-b3b1-44ee-e518-08de0cf7581d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:02:40.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxWutPhg0GXS7yHxvYc8NDRLlolu2RkuAv1tg6iRA8NKPtERJmq1u0jrDVX8zp6DGXX//2qRWAfF5qZ+SR32gki394wjRlVYWFpk0q4NZeY/3KfVjabe+sHUrBYcCV8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7813

Adds functions that aid in compliance with the PCC protocol by
checking the command complete flag status.

Adds a function that exposes the size of the shared buffer without
activating the channel.

Adds a function that allows a client to query the number of bytes
avaialbel to read in order to preallocate buffers for reading.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h    |  38 +++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 978a7b674946..653897d61db5 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static
+struct pcc_chan_info *lookup_channel_info(int subspace_id)
+{
+	struct pcc_chan_info *pchan;
+	struct mbox_chan *chan;
+
+	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
+		return ERR_PTR(-ENOENT);
+
+	pchan = chan_info + subspace_id;
+	chan = pchan->chan.mchan;
+	if (IS_ERR(chan) || chan->cl) {
+		pr_err("Channel not found for idx: %d\n", subspace_id);
+		return ERR_PTR(-EBUSY);
+	}
+	return pchan;
+}
+
+/**
+ * pcc_mbox_buffer_size - PCC clients call this function to
+ *		request the size of the shared buffer in cases
+ *              where requesting the channel would prematurely
+ *              trigger channel activation and message delivery.
+ * @subspace_id: The PCC Subspace index as parsed in the PCC client
+ *		ACPI package. This is used to lookup the array of PCC
+ *		subspaces as parsed by the PCC Mailbox controller.
+ *
+ * Return: The size of the shared buffer.
+ */
+int pcc_mbox_buffer_size(int index)
+{
+	struct pcc_chan_info *pchan = lookup_channel_info(index);
+
+	if (IS_ERR(pchan))
+		return -1;
+	return pchan->chan.shmem_size;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
+
+
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
  *		request a pointer to their PCC subspace, from which they
@@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+/**
+ * pcc_mbox_query_bytes_available
+ *
+ * @pchan pointer to channel associated with buffer
+ * Return: the number of bytes available to read from the shared buffer
+ */
+int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
+{
+	struct pcc_extended_header pcc_header;
+	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
+	int data_len;
+	u64 val;
+
+	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
+	if (val) {
+		pr_info("%s Buffer not enabled for reading", __func__);
+		return -1;
+	}
+	memcpy_fromio(&pcc_header, pchan->shmem,
+		      sizeof(pcc_header));
+	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
+	return data_len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
+
+/**
+ * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
+ *
+ * @pchan - channel associated with the shared buffer
+ * @len - number of bytes to read
+ * @data - pointer to memory in which to write the data from the
+ *         shared buffer
+ *
+ * Return: number of bytes read and written into daa
+ */
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
+	int data_len;
+	u64 val;
+
+	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
+	if (val) {
+		pr_info("%s buffer not enabled for reading", __func__);
+		return -1;
+	}
+	data_len  = pcc_mbox_query_bytes_available(pchan);
+	if (len < data_len)
+		data_len = len;
+	memcpy_fromio(data, pchan->shmem, len);
+	return len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
+
+/**
+ * pcc_mbox_write_to_buffer, copy the contents of the data
+ * pointer to the shared buffer.  Confirms that the command
+ * flag has been set prior to writing.  Data should be a
+ * properly formatted extended data buffer.
+ * pcc_mbox_write_to_buffer
+ * @pchan: channel
+ * @len: Length of the overall buffer passed in, including the
+ *       Entire header. The length value in the shared buffer header
+ *       Will be calculated from len.
+ * @data: Client specific data to be written to the shared buffer.
+ * Return: number of bytes written to the buffer.
+ */
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct pcc_extended_header *pcc_header = data;
+	struct mbox_chan *mbox_chan = pchan->mchan;
+
+	/*
+	 * The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
+
+	if (!pcc_last_tx_done(mbox_chan)) {
+		pr_info("%s pchan->cmd_complete not set.", __func__);
+		return 0;
+	}
+	memcpy_toio(pchan->shmem,  data, len);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
+
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 840bfc95bae3..96a6f85fc1ba 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -19,6 +19,13 @@ struct pcc_mbox_chan {
 	u16 min_turnaround_time;
 };
 
+struct pcc_extended_header {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	u32 command;
+};
+
 /* Generic Communications Channel Shared Memory Region */
 #define PCC_SIGNATURE			0x50434300
 /* Generic Communications Channel Command Field */
@@ -37,6 +44,17 @@ struct pcc_mbox_chan {
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
+extern
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data);
+extern
+int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
+extern
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
+			      void *data);
+extern
+int pcc_mbox_buffer_size(int index);
+
+
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -44,6 +62,26 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
+static inline
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	return 0;
+}
+static inline int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
+{
+	return 0;
+}
+static inline
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	return 0;
+}
+static inline
+int pcc_mbox_buffer_size(int index)
+{
+	return -1;
+}
+
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0


