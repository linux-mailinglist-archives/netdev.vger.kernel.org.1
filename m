Return-Path: <netdev+bounces-206916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3FFB04CB0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D57D4A7D49
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CD42AA1;
	Tue, 15 Jul 2025 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DHFgwwOc"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021078.outbound.protection.outlook.com [52.101.57.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451F2BAF7;
	Tue, 15 Jul 2025 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538229; cv=fail; b=WgoF2m/e/LemeESZ1XB3R/wbbk3Xw2K/0UWhksIjAK4Ihmy9G8aqk7rcHG38YDQ0Flo3cK6ANQpCZ4m0s7DL5Qrpt4yqekdIl9t8CPbKgzGJspc51Zq3alX8kn11nXDyAL8e0OhT/XMnoCa25+/AuP6kFaQdQkvi1PMQ8UXO10g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538229; c=relaxed/simple;
	bh=NExceU280rxT67ncbDAwzVcltQhccGXRdiNx8D/OGwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cOjf3abZ13UxXe2iLwd6ctE6IPB3iVSV5zEWgcyyEXHLtu9oRY7dE1GkbMs2ZAfd5JsrEJkp4cbXC4ewomak6veD/uoNQsvNPiS+3oZU2KToEx0fnsCiIrvKZ3wvZbu+JUV4afbyhA1khF0Wm6tRI4/F9ay9WwQUuC5VllnUjNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DHFgwwOc; arc=fail smtp.client-ip=52.101.57.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxP+iso2sdVj8q/XDJvT4lpGgGp76MK19rEm4IlaaXluJnrj0dXoXR3tZdt20NGuFvsgMBeDBtLsXnM02ufxKMDVEhpbb3BdIYM81CXgedkNiDKz/LAgJmvs0M+DzBvxS09/RB5BVhI8GYyFEDSxl5DiBIvicgO86k/DI8NljWZVECB8tFYXGFI4oJWeH8JUxdMAHRix4hZ7F+5NFsWo4HVoYLj9DpBD7s9l7KZf7AvhlSGNFsYC8lvVrCHgmXeu7Y2q0IIDar0ReVYpm5PQyshYlTJE8X5Mhz9WCqscfo9a8LPAWrFf5H6Iz/gHoSFpGI5cVW6YLUhpZpojsSKvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvPYRJyGutHucSV48IH6dA329k4nFK56aUeROUio0/s=;
 b=ooYvfV8MxIXE0rV7/7FhTYH34gqUeq2Islwu40WBu+CREWPZMLXB/WHBHcrmb9oiapLbI8ilMXzHxWsv6KpOjeLpzu7XSJ3YBMexebhSvvQXMBjDNldPGt3i9dQ3ukO2i419pfXm0UOEbNzyfu/Jyc4zZZ9qojrsZarkLMDQBmv+9GU5lzsquv2yKhXicsC2/hmBNeQmgn3HTIULNNAHkZLospe6YOhSI9zjwMaSFa7uDLiK0+UZDX7HFH6/9gFRaKPEH12mB1dM2k5zSt++/q1q4E1MWwJBYA4KrM9nx7SqOdx/zl5/ceKdT24HE4U2+wTPA1mkSWEDWEY+5qRMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvPYRJyGutHucSV48IH6dA329k4nFK56aUeROUio0/s=;
 b=DHFgwwOctkpD2I/xDto8XyVEQC0qO7nIao7jnbutrGG+AP5WTmkY6EViArn9CycpuU1CSZMK06RfoN6My4m/cP0o4T6THPFnx/ROvBLQiE2N6pMh6nmxnQQevfCLm3d/ORa/BUrq2Jlpj9Ijh0rp87tEhQTLtdWw3g7QfUCaIDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6239.prod.exchangelabs.com (2603:10b6:a03:29d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 00:10:23 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 00:10:23 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v23 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Mon, 14 Jul 2025 20:10:08 -0400
Message-ID: <20250715001011.90534-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:806:a7::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 874a2b10-5743-4cb7-3354-08ddc333fe84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cE2jTWzwKVSUQsoqZBz4BZ7g2VJFFn9plxgalNXXmHJ3pd8ZBqjrihuLX0Yr?=
 =?us-ascii?Q?2+Mi5bj8FoUos9mKqrnn/UCyQ0zgab1pR92A3TmTFF79mCBj7D9umuJ0aAgk?=
 =?us-ascii?Q?5Uy1bxkSlXWmmLIl+OYCp0nUHyRhBuHs5xHC9fqISfdiuAYHi6Z+gRzP9Qeu?=
 =?us-ascii?Q?WlGneCrWjxm+zdzNAd/aksDJ3lHvWhW/NYn6J4oboK5iG5ky/Lw8s5LWhfQx?=
 =?us-ascii?Q?GO4alec7LGCBgJQ7fSQp8VlfrL92tsnhrHE0Kn/Uv+9G1zdT6KAXfbSrug0i?=
 =?us-ascii?Q?lCIAy/FyBlHSNErLBtS0Njdbm9tLb+jAGd3268iHVKdVCvf6ztvFS3kzfhrG?=
 =?us-ascii?Q?xeAIAsyclYa348N03CDslVeoRC+wydTpLDBeoWm9QqHQAXRboGkQ7qGVZ9M7?=
 =?us-ascii?Q?AKxfPzRSg6nOtgIqeE+y0U6BvfHHOQztdTX99Pjad0/V2oKym+t6Y2/pRXYj?=
 =?us-ascii?Q?wEDf1MJlJZ8fwuVlNQYW2/X/tjeUroY8/G1/jUSnaPLsESNiau2QYcMmHTcw?=
 =?us-ascii?Q?ZRPaEz5ktuAjml5jzFffcR3zYHK/XL1TjLmmqUA61bmq5xTxLyiLTrToaoru?=
 =?us-ascii?Q?/TqL/ISvFNGgxPxA7G2O3M5k578WjshsRuX1DDPgztVRoeC512Mnn7r+niWB?=
 =?us-ascii?Q?nOIMtJ4fL98Ou5JhlHvymf18rnF/JKae0hdwecKKfwmEGt9ip7jaUYj/WMlc?=
 =?us-ascii?Q?mYiigVsM9J0hJOv8pFLOfPrmyIpBUuuZ/GmvmIwsWnp6MhrtMAgw39NiEUao?=
 =?us-ascii?Q?WYJX8Kk6jnR7GUFvTL875rPJOWeYNON2v3bAbuClMObPPMiBzKTYAp5ANyzy?=
 =?us-ascii?Q?5X02tSRFl/ScfRUi6dNX/eM4LDtLWGuR7mc0NKGgBU4d2K1sRjO3uDY2pY97?=
 =?us-ascii?Q?kgsEaUyrnC1ZVYXyZYjvDGYhaY0cjmU7eCuZzEbg9ktoQoWXy+zvAkIy1v1h?=
 =?us-ascii?Q?Z0ln+D5+HjQyIpxKomxQaiEAy7FEIe+qixl5w3T/Tj/vwa5R8YTVU9UtNmAD?=
 =?us-ascii?Q?14heiES0S36w5zwGVusfc7dOZI/G1MpLTPu4jp/qD4nyJwN1Y9alf/b29aHj?=
 =?us-ascii?Q?7HHC0uAfZ+eASff9gh86rTrevmRqvOrUC1gdVNW5P7zDIgmXluEu2jS4OVsB?=
 =?us-ascii?Q?AEE5wZtfQew6R7m3R8m5FJCnZG1QZz6QJJPpDIyHdnotPP1ss9iqI+9wbt+N?=
 =?us-ascii?Q?p9fQJjAxL09+VZhEtON2vK7Q2G/hfiEaNnMTYYvTFbtNcSwZWgmB8TJ/5Csv?=
 =?us-ascii?Q?ZqsFbJcMBcRjgUkgNwD29M0eKc7iM8rOxHx3G5voDJUNAEFtc615Yexx/kkg?=
 =?us-ascii?Q?Aasn4PTVwnlokbXgYfR5eULliLQ2GtDdxPebbqCPBec5sZwPCkWFUA49rMvt?=
 =?us-ascii?Q?1ftgHt4FMjCkmnKXv1PLoOcfWw51NSsd3GuBIChSKz7Iao99ImY0yiN05vYU?=
 =?us-ascii?Q?c2j4FAMY/7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ADU24XxCjucAjiL1nTzFkk+Vq01peZ2baH6gwNIo1esK7tnKIkMdQhUuAtlg?=
 =?us-ascii?Q?m5HOEdOWE4FQ2/iaNxsHeCgfeTzyebCHat2eEGisCvu0tIy2OmzqVb/sPH8H?=
 =?us-ascii?Q?UE/lTwF9xD8TcHF8I8Q+96VPYX/c+pXLftQMHL+a0o+nSwrsFYybonOc+gCC?=
 =?us-ascii?Q?PN1wo7APniTB84xpG6e4dnmW2YpuXT5lr6og7AJLKeGzbUbf7fM+3GpaMSF0?=
 =?us-ascii?Q?TpEQ4Vj64j+avPVnxPBGWWvq3eLq7XtkqCAUfFoB28XgOvSmnNxGvM9qG5rp?=
 =?us-ascii?Q?w8RnhjMaWanF0wViH2/4hPBJg/mPKTvyEmyvGrkYdqvuOna8pz2AeUFfNcUt?=
 =?us-ascii?Q?8JxSNiSLhyWV9CL7WAMjI4Jpc/luuW0g5rDn8O9cBonXlXJo8GK3KySdkUUv?=
 =?us-ascii?Q?jZlIxplC18QYHkFLPjtNFg6tOp6MDHHpMwak4x5ZXU9FEsmNZ6d9gIVNboLf?=
 =?us-ascii?Q?BF8nBZQGF62m6617gNgw97XlfY/T3tF+le8EBH6cT2OC+v+d3gSQ+fa6oWzM?=
 =?us-ascii?Q?iZE4DLWbtb7qgAVA8/jjSEX4js8lwuCL880+2xKfV9VaqFlNqlQtNTyVralm?=
 =?us-ascii?Q?Dev4O6hMx52w7l32jbdnKcvZfEms5mZ6N5qQmpZ+uVshSOGTMeGN3lac3cbH?=
 =?us-ascii?Q?ONxaMgj1RgEJleqxU/QxAyJhvDirxaeslhG9uWRGnQ6ZhojedLQ0eqBdM5D2?=
 =?us-ascii?Q?09U8Hy4dJnEY9XEBj9ffN7rb8nAF4GDMTVxYTAmMnkanT0GU98i2oHojmfbR?=
 =?us-ascii?Q?XvlBhaY1x3K8Gf/FjtnOzWWWt6s9xA4lso2S0qM4ZKcAGFW+rG9FsWMu7FYX?=
 =?us-ascii?Q?nCx4BQnygH6AtRAl53d8VwGK0p300XoZFUxYr+v6M9Niyv7FXOOTvBrc5HhX?=
 =?us-ascii?Q?fPTo/zFkC4OOzLP8h2EGJr37xi8/Q3QiduKwJ1rE65UmrH5NcDgktud69VNB?=
 =?us-ascii?Q?9LOfaIBg+Hk4wHPtwLl+oqBdXpGdYMMpbikzqYWuRqoM/7RbqIzKMEKfCcFW?=
 =?us-ascii?Q?yi68HiFuMDjTTOwKez0hC8DugUeRUe3c6e31gRZ4Rbcxgrlj+K0N5FzGvLFv?=
 =?us-ascii?Q?dcbZjwh/TDdOScJRzN+6r0exj1Bf94dDa/QsehjagXx6EpcFoooC0p/S/1cS?=
 =?us-ascii?Q?px+0zXUWFr2jWlgGSwBxa5jabeudg+ADVyGq+QtWz/WAedseQFbkPZRqtYsk?=
 =?us-ascii?Q?8ne/bwC3Ekmq3IfBxr9fNEqcsICAGZqvUSo9XJ8hOlQ5fHvCGOAsf2yw0jA3?=
 =?us-ascii?Q?782ujW4NaiU+MSvJsyispVaAHFJS4zeMTiIv3tn/3Z30zwBsvACHMq9etyXm?=
 =?us-ascii?Q?O/6JhubSnrE0tn2Xie4RB72Bf43QJWE0wM04PMx/e5z6N/VybKX87Z9UjtUk?=
 =?us-ascii?Q?ZKuvs2M2kO3iM9ZqEzEBR4+3c1wKz7S4RnL/rXu8MZ4VBpNy/G+Vy9/hk8gT?=
 =?us-ascii?Q?9JHNPKJiwUgdempWkDfhmF9ED/OVDpuiAiOD+LqD/7kv2IPBgJGsXjEXgFlB?=
 =?us-ascii?Q?zg2JNc3DE7WRMv29alh7a5bMekOFmZi8mkFS3CUf1QjCmCljLG1I+WhyfJio?=
 =?us-ascii?Q?2/IVMNF8l1ZdrOoCFQLK+uJBJhfXH/0+qIYOOmD+VTfp1vbN26+DzhwUTdr1?=
 =?us-ascii?Q?Rb7z3m+7GuhAEYc1kPe4BKplnKiZrZZ4zEU0CwlUqOKVUptXBVsFIvMZ4m8o?=
 =?us-ascii?Q?VropBnk1k0PJiOh2/XESZzJsXL4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874a2b10-5743-4cb7-3354-08ddc333fe84
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 00:10:23.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYZQ1CarCT961ilvlm33Xj+b6Igizat4dPZ+7cZItNmdDsIqAoxvUOp48KdFic3UcQH62NK7Fw2Qn29biFSpmAyhvopLxPu5SyIMbGgKZ0nmQYjQR0CxPonQPUjELe5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6239

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox buffer
management. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted  as a PCC message.  The driver
is also reponsible for allocating a struct sk_buff that
is then passed to the mailbox and used to record the
data in the shared buffer. It maintains a list of both
outging and incoming sk_buffs to match the data buffers
with the original sk_buffs.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 347 ++++++++++++++++++++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3887d5906786..3939d816657d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14469,6 +14469,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
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
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..045711a21395
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
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
+#include <linux/skbuff.h>
+#include <linux/hrtimer.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#include "../../mailbox/mailbox.h"
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0292 a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	struct sk_buff_head packets;
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
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+		container_of(c, struct mctp_pcc_ndev, inbox.client);
+	struct mctp_pcc_mailbox *box = &mctp_pcc_ndev->inbox;
+	struct sk_buff *skb;
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		return NULL;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		return NULL;
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+
+	skb_queue_head(&box->packets, skb);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcc_header pcc_header;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, skb) {
+		if (skb->data != buffer)
+			continue;
+		skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+		skb_reset_mac_header(skb);
+		skb_pull(skb, sizeof(pcc_header));
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+		return;
+	}
+	pr_warn("Unmatched packet in mctp-pcc inbox packet list");
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb;
+
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	skb_queue_walk(&box->packets, skb) {
+		if (skb->data == mssg) {
+			skb_unlink(skb, &box->packets);
+			dev_consume_skb_any(skb);
+			break;
+		}
+	}
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_header *pcc_header;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
+	pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+	skb_queue_head(&mpnd->outbox.packets, skb);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		skb_unlink(skb, &mpnd->outbox.packets);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
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
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
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
+static void drain_packets(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(list)) {
+		skb = skb_dequeue(list);
+		dev_consume_skb_any(skb);
+	}
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct net_device *ndev = data;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
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
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+
+	box->client.dev = dev;
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
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
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	/* inbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct pcc_header);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
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


