Return-Path: <netdev+bounces-211681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F274B1B225
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE48F1899A63
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88D23BD04;
	Tue,  5 Aug 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OfhnljxS"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B823B612;
	Tue,  5 Aug 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390496; cv=fail; b=LGGSUlW1jTpEBoLZVFvIeoNQIW4++WjMXQ+rmBbyr76TmCIfaQn2igxxCUCug3MnSdaZsnhEfP+NpGUjarVQEu4ahqtaJg2IZIZWe1b0CawZkhg4c8ZTO91nXTKE6nmA30O36Tog2xkKxAtnkDG8NrINiLqRNpk/lsb0myoeHFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390496; c=relaxed/simple;
	bh=tKOpxaXMwLxxqBAPBBY/ZMvusTM7Z2M3Pys51But+s4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IeBw24NDEX+ZRVoVL7Zl5pP/1Of3N6aYc4fhFbdHManIRZ/p7iO2KZ27Y7CkDf7eVHLz1EC7I1IZ5+IvGJOfs59JeWGRuwy2TRf+wsOVbMGldDPRoMrvdYfb92ernvR0jZjjw3+KmyLg7PnNi9AcYz5vU0xaFw6pf1NGPkHgaH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OfhnljxS; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIauxjUFt9L8Hhr3YMTTyBGzVLT+ytEQivhgskADCnt4JZ++nN81zb2jkgVtGCa9OB1TWDzQLjBCYqMNaQ9LAgNiMniD6GdMRNquHeOdci4ro6AxFUKeY9VH7s7x1af06UhP10WmApodeybYtmqkG87jzYXul/WWPwBjzebifCF2Sx7VwbhJkHNoF+j5mfRcZ2RLre0nSiRst2TAGw9+VtPzUwKy3ejJ2PnALLunX2YRzaKg9PnSWtk72E8a70guObiDJ+NkpLuDOiBpnYiVaKrN/R0QeGCU+QGNihySSq0fWVdxdpey5YtJSVUVOEoPqYe+E6z/NkekBXt9mSCHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShwJ91AQQoqpYt5/rHsnIV9SJHSvVnRWv9GAr2edpVM=;
 b=EcTMFvCohhSaLh6twF/pka20ad2JxBOqp/PNZU0mJfLc4YnqHPwwfz9HfO3Tspkq22tg81ZswHlZF+VujRFzzOeKd+Bn/5jG+cBO4kNPlTxQ3Wz9r+i6DKE9r85s53ISXg2/EXdKkTLLMJb+mpx7JlkiBZm1ll/OVFfp8QqjAi3y/VLkx+gnI6QCzHjCNjQaaweMIYp48/G5XzS9laMnJ1+MRDDEH3BsryBtKjIZqtOjNoW8c/YBIPnlZXYjdkZ6egWgnMgSMLFtS2W+PuRJEoIJ+z6f/OEAbcRA55q4DRwmJzCFpANs4UXnzXA4fOyOLxOl+dEfdB5NEtMNl5kksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=redhat.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShwJ91AQQoqpYt5/rHsnIV9SJHSvVnRWv9GAr2edpVM=;
 b=OfhnljxSA8+RxcIA/BEHec34dzTkD84ekNWPCOz0zMm/JIh9a9y3fklDs823WrGQ346msB8BDNe3ynUELCqOiLY/6aD+b2LXG0jk7fvoiA22F2G7t5BuTVoPkUi+zBzd5MDOGEpIScKAWF/VhZ1g19Pe+S1sHmMHqNYdPWkOuSI=
Received: from PA7P264CA0312.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::25)
 by AM7PR02MB6241.eurprd02.prod.outlook.com (2603:10a6:20b:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 10:41:31 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:395:cafe::3f) by PA7P264CA0312.outlook.office365.com
 (2603:10a6:102:395::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Tue,
 5 Aug 2025 10:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Tue, 5 Aug 2025 10:41:30 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 12:41:28 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Wei Fang <wei.fang@nxp.com>
CC: "kernel@axis.com" <kernel@axis.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
In-Reply-To: <PAXPR04MB85106B490CE2569F661F5F538822A@PAXPR04MB8510.eurprd04.prod.outlook.com>
	(Wei Fang's message of "Tue, 5 Aug 2025 09:41:34 +0000")
References: <pnd5xf2m7tc.a.out@axis.com>
	<PAXPR04MB85106B490CE2569F661F5F538822A@PAXPR04MB8510.eurprd04.prod.outlook.com>
User-Agent: a.out
Date: Tue, 5 Aug 2025 12:41:28 +0200
Message-ID: <pndikj2kq3r.a.out@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AM7PR02MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e64f74c-1d7a-496c-f711-08ddd40ca3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tUfTUA6OMt94ZYIW/K1/JzSD9yKBzfsUqGZPjfYmhJIiAKhJQkWJKMJMvDZ7?=
 =?us-ascii?Q?rcSmRaSX6mBbVAJvraDRdZ+3Iv6qvtsGwn3WHYeR4YvTmez2GJW9sCcv4GSU?=
 =?us-ascii?Q?dCZ7uWyDmr8L11mWNwBn+MuVv/ZwykQHgZGqGFs+AtMqIP5sdhIindwNiZ9t?=
 =?us-ascii?Q?d84XEPqXE/5IpwzdeMXsfrQD8qhuDrdjnkjxSqvvJVPvynW3AOtqFKyzG9UR?=
 =?us-ascii?Q?Kp+adHVw2RFQqYsQ9fGArTC565koV0AjJ1xCUs+pjQAyrKTE8e66KD7KP+mZ?=
 =?us-ascii?Q?DiVr7qWQuuBvwkT05m5989srcgU8MrTF7razLeq4voTJXitml7n/GSA6oY71?=
 =?us-ascii?Q?flHPlw0JKRFht1gR4y+doP/7UbZOcSSFG93cImaH32MVmqVfidvZunLIsDbe?=
 =?us-ascii?Q?wtJs0TuRgYFbg3fmi4Ib/EvUSiIMVtbvMSbQU9sBy/iUGMU5NbUiYGoUryv0?=
 =?us-ascii?Q?23lXAnapJijscZgKNOHUzOfFCcRhrRMjXfgvWQpeGyLWUnX4q2sNymOCuF1k?=
 =?us-ascii?Q?pocfAfvQPG1J9QVx1eOVijHRdJmoClr9Sy+YI7GeyFzttBDiYslAL/28SRSD?=
 =?us-ascii?Q?SzVtWIWeIw0hl4gyYxDsR/Smw4J5m8ec+eTtZzrrY1M4IoMsnmR76dp0Akt1?=
 =?us-ascii?Q?5daPPO+N3ufGmx9IPQyUm4T2LOOMwkTFhmeVeEcz8/C/hfHx0KrBeGvvmF13?=
 =?us-ascii?Q?eZf+V7EPsW/2s+TetLc2/sBSdoJm/Z9Dwtut6bACRfR4Fup2yXcZm7OiUogk?=
 =?us-ascii?Q?Xa2ZSAR1nfR7/SfhlpekmsOMGAhzYhf1BW33pKzRbUw55i3jW0PXL7FdTErr?=
 =?us-ascii?Q?o2v7+UnoUmiEuPVx+7Efr4JlWd83UC79bYqG+bNG+Pz8Gl0Y9gxcxCVSk3Or?=
 =?us-ascii?Q?iIiBsq+flyTJZTL07ttMJdGIpsKsjTOK/Ucr7qxpmZCmFEopnGDcVmNclAw0?=
 =?us-ascii?Q?GBEWArsMQ2p10PLEjuM47bMDqoQ6I9KxIC1ruX5OsFocITWdfwLqT+RRetvZ?=
 =?us-ascii?Q?PrDDe3qUD8ByBa5XjMh52x3wnMefZujTRNUhBpXHGGB0YHQbcEJbdinaWtFK?=
 =?us-ascii?Q?m8vu4VKXEeax7S00wwpIDwfAPQAeUsbsxKWVcNq5y62Cc9imahTsCsM8gs6q?=
 =?us-ascii?Q?1uSWCbxs14Mqqo49jxNIfi4X8DP4tG9KdegZGEz2zk2sMG23DH9Ocf5NmlRN?=
 =?us-ascii?Q?cudvWpJlTv5sZzcTEXS4ff/x2a4baNIBtmTz7fOjD5vP5V+uDyeXlYURBAmY?=
 =?us-ascii?Q?XLtDWGeWaGmWGDxJ16gsXlEN2mLHxgYv7X86u8uKC0CMIaTIwYHcgZB9Ep/8?=
 =?us-ascii?Q?pjzQbjPvkunIaJqU30CVzBdWCWCNviH5MhTU0pvyLUNWzcX8opQ4ykMmZJDD?=
 =?us-ascii?Q?mttSUVIRKxN5G+dF+7ZqjOvsbQ+lnsXm2ZUsa+0X6c76N4g4m8OgGv12V5Vm?=
 =?us-ascii?Q?qlScYYf1QDddQY+yOOmsJXsFcpurODF0cpdrFmBn2D0LAxKamQwwhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:41:30.9986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e64f74c-1d7a-496c-f711-08ddd40ca3dd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6241

On Tue, Aug 05, 2025 at 09:41 +0000 Wei Fang <wei.fang@nxp.com> wrote:

>> When `devm_add_action_or_reset()` fails, it is due to a failed memory
>> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
>> anything when error is `-ENOMEM`. Therefore, remove the useless call to
>> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
>> return the value instead.
>>
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>> Changes in v2:
>>
>> * Split the patch to one seperate patch for each sub-system.
>>
>> Link to v1:
>> https://lore.kern/
>> el.org%2Fall%2Fpnd7c0s6ji2.fsf%40axis.com%2F&data=05%7C02%7Cwei.fang%
>> 40nxp.com%7C5c6c1234f2944165bdbe08ddd4032c43%7C686ea1d3bc2b4c6fa9
>> 2cd99c5c301635%7C0%7C0%7C638899832279054100%7CUnknown%7CTWFpb
>> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=7ejNp6ZnP7B9o
>> gBefpQdq1%2BGCH9vqHogvsU%2FcJZbWzo%3D&reserved=0
>>
>>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>> index b3dc1afeefd1..38fb81db48c2 100644
>> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>> @@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
>>
>>       err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
>>       if (err)
>> -             return dev_err_probe(dev, err,
>> -                                  "Add enetc4_pci_remove() action failed\n");
>> +             return err;
>>
>>       /* si is the private data. */
>>       si = pci_get_drvdata(pdev);
>>
>> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
>> --
>> 2.39.5
>
> HI Waqar,
>
> The net-next tree is closed until Aug 11th, please resend this patch when it
> is open. :)

Oh ok, I'll resend it next week then. Thanks for the information!

