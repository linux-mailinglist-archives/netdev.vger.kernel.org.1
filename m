Return-Path: <netdev+bounces-205909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A7B00BE3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C605C40F1
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ABE2FD863;
	Thu, 10 Jul 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="X+SQB76R"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01902FD5A1;
	Thu, 10 Jul 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174818; cv=fail; b=jgmysADsD0tjHuaEjtdbs54K9j+TgQLpbgvqgoEGowCuWfwoumbjr3yp0k6gUGim1w1pfn7u9mmRksnHJH1MIfncZjk+Fa5D3uSm1E8A/9wXIDc/8oOmEqvdSJFYSIlzOhoytkFdsn61/Ca+Y7AgEYOGAL7kNQxG9doSXyLnvu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174818; c=relaxed/simple;
	bh=2rqSNOxlzDphud4e6wMTHIQSsOZDfGiV/xmoBaiuzz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rqc8Jj3GUal4MyfyeGNzWZ4n3s6lw7XK+QfXmVeJ/KfrgL6OWhZc6HNYC+ePavrT1wxb+eto2FJAvygTsFZnG784ivp3SB83DIkBsG/FRLVCtdGNb7F0NLgZHN0rYdIi2Xh5fcW1ilCysObw8sDBHz5Vgx9jPkLW609nmNJqq/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=X+SQB76R; arc=fail smtp.client-ip=52.101.56.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCDbrR0iIyUoUyxwz/wJS5g9YL60X9t3gyDCxcQd6LDCfMI/5Ed7XsLhNL0slk2GP1DaMg8mUUA8VyioCiGj1HvPlWQelNA4+2l+BdKIdUf7A306UH86RSEeKQTuTIpX/kvL4jL5zPBh5atrjshtNM/9nS+sMq4Ajh62nBwuGRCvSXwROv+cYTc8hDGhBIBAzl8B3t8vp8JxgWPgAdi685bSC7MEMsq5DX78A8daTQBLV8EqPNHl8bOd0jKre8quzEWWJCfbscs0FLVA6nflvPGanM4eg6ko4ZBzKsnXxZY7ZFsm/KX3jhsKYJRoK3At5y3VBrULdsKMlLk5jZKnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a4RyUhALFk+6Za/jBLiiCaQPb3ef5FPSeTU8LUD0BY=;
 b=gpRu4cOjmUXPUOFBIvFppiO5jZ/r78mHJPBqJpDqwI8NRx+L+yc0X2lSywC/MWwxn4qFCWVXz19/KdrpbeNRXTSl/SLoi5hQZv+kHx51c+z3QhRgKywvnBQn0c+C0YUmRgrtH6BpATe8KqlPEh4QpfCzRH3ywE+SwW5TkUd/SqLTbpuWgo41RCBSugeQS2mzRFy8zchIOUtm5GBZfBzIXUXfZSThNfjaff/LOByySeSj76uWxHoC7MWccIGdSIZRjER0joRn7CGgY2Xbjx1ClDkdcPTxiax5UJW4lH5Tar4gNj3aqmZDlBEwjUnnoQsC9esBf4Hq5kwWvR2P2S9pPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a4RyUhALFk+6Za/jBLiiCaQPb3ef5FPSeTU8LUD0BY=;
 b=X+SQB76R88+p8f3JeRGJy/Kxb1hpP/RvFPCv/lN90s+R6jpgJAO7S5S4vZ6facrM9iQTw4pWfHPrQYjSqVV+yMX3oQpgJqoGHd+bTcT4WBEV5H8uZMl6yDVp0vYJ2+KzAdBluJGeR8gg343YiYBlAfjacnVk5yoPziq0N2to8JI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB7188.prod.exchangelabs.com (2603:10b6:610:f4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Thu, 10 Jul 2025 19:13:31 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 19:13:31 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
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
Subject: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management of the shared buffer
Date: Thu, 10 Jul 2025 15:12:05 -0400
Message-ID: <20250710191209.737167-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
References: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:23a::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7914789f-3a5e-4f22-bce9-08ddbfe5db90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhkABLOLmSAhbue8mPaamkzCIC6IbPSEZwTzGiEGreMcy4h+q0QlDCRBS0cJ?=
 =?us-ascii?Q?bhmYL4ic4UMQrZmXGTz8DY0Al69ME+c5A9a42h2DV13Hr5httS36GDWjTnSA?=
 =?us-ascii?Q?cAvwj59F9pZhEJ0wAIqKY/ewHsCuq3G1BrU9ryZYYZ4duGaFP19alB/okvuz?=
 =?us-ascii?Q?Hql/ZLqSrXYZGo6UhEK7RtpEy8BXGPNcpf4QsicD7TSxhiKlR1F7zv/N4adQ?=
 =?us-ascii?Q?BCWj5NdUq/eu4Mkd9hp9N8DJwT/XiSXuYR30j72ED7VIgsYuigeZmNYF2VrN?=
 =?us-ascii?Q?05t/ezLxbcKNW+ZEhRGVXs1z6L47obfStyUnm7hcTHGoimX4KRyoIWBbGKP2?=
 =?us-ascii?Q?Uern88Y0fVGTNQpQKuowxvV0rgAHbT8z7fiYwunmf+AfahySOSYy64UdJh62?=
 =?us-ascii?Q?z7vAwuKbGbCbng3VQBGphKa2fx5PrWxPucX9TaZe5SnxD55ZQxSuUeNmz6Qk?=
 =?us-ascii?Q?GwLoE74roukTRaljfnPMD7Yu31XEQ1vG7VqOWh94qhoACIsv8Owwn8dlrquz?=
 =?us-ascii?Q?arAocSgmwDdXVH4iR1m7Kw+mjTSl0uoi0SMxqJmBrs9bW+4ldTEgYwrq8rVw?=
 =?us-ascii?Q?mV512Yz55dfxxw3ZX9jgCZMb74A8p26XcJamhtvpMRxf8rf0HV4jdgGAX1ht?=
 =?us-ascii?Q?ADgtNQi2xdH/kuSYEezXptP2kFIGk3S8dOxvB1eaNa5TQQNwtx8V/0WVLCdD?=
 =?us-ascii?Q?NjwLPIGGUhWqQsLccB8+Ulic5mnpgrEjV6y7uv2LKsTRScalXBGlmyzdk/kV?=
 =?us-ascii?Q?FgdguslblroBFqV8JijpYdZXz0UqbR0pYw4zTmGzpCKPmSM594SbDQym9LR3?=
 =?us-ascii?Q?WrowPGcWwiYyE+ash8uw7o+MDjIsrjMQ6SKeSWgwK22d8W1rE1P0Lw7W6wwQ?=
 =?us-ascii?Q?FchTvr3O4xk3V7DIsQE1LeIb+hJJBkQZ+slsNtrQGzL9bcjKaot1fMQRoky6?=
 =?us-ascii?Q?WDTOTtZwEzcu3h+Y87QigGnxmSi/gHdD4lxqtVB219QWxs1cR8gzimzibORW?=
 =?us-ascii?Q?5cKUusbz/bM21Q5FSHY2VTtpZ7WRKzBHr97jN2au2j7fCM9I2qwbtBi/JoqB?=
 =?us-ascii?Q?nLMNf20WG8ITYtiSPTwQfwroZ8LNe16+oz4K2U7rsTuELWxlAM92VB/Ighdr?=
 =?us-ascii?Q?0Okj/XdVEEnI+zncBCY/cxVEujnVj+vUngoDw25yEYFt/3emLFlWwqabsH3M?=
 =?us-ascii?Q?IFLXfbYlYJxt0zhCyWFQVuptNL/h5nxkEtY4uyo2EPTSxYy9lElbD3mZMbAT?=
 =?us-ascii?Q?5L88tcvieRFhVqAkwmtyuamdAe8CpzSUecQNTpAtHPvcH++9mpRBD3bSIGGE?=
 =?us-ascii?Q?YXvo3gAYVCeGzMuDVhPzn0Eq+UjViDOV0jPyJlFVnq1z8AE45v7sxlEIjX9V?=
 =?us-ascii?Q?n9FkqYMHTdwA4e2MFxeXccFgGwknNsnuOyExfDZywLvN/dZoSK9j96bDxKmc?=
 =?us-ascii?Q?VfENXefrfYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGxKKzg6QXlZkywdITJyD/i5WYXf0NbF8rwdOJPoBI+Z7YT9Ynvt4N8ywfJW?=
 =?us-ascii?Q?MLP4LKYA+zztNIefsRIBvwKQwvm/KzGnyGDCIsTwJLjdeYwkj8PmUkTg1kKQ?=
 =?us-ascii?Q?ser/GOGI1wtjvH5bkdG3Yz2zklirJE2/3AOqwxqNWXsX/rqAohjSX7ydDiyJ?=
 =?us-ascii?Q?Wg9uFHO5pvIX2XVd2FwvAsm2es6Qij3XVh5ZmRmY7md9iLbd5v0Ta8ige433?=
 =?us-ascii?Q?MWKk/eOMW3zBmEqASRA01LT5refcsocnwtKsiRZooFnG9uEjMWidOoiwN040?=
 =?us-ascii?Q?0ff9WAPfdIkb8RN9f8lPNy6QUs187p8PJjHbE750WGS0Xo6ViGC/4Hn8FP6o?=
 =?us-ascii?Q?w2AEp32uUiGgmL0k2fDOgPLvHT9IKaTZsMSVKX0PUTPLZVkP9RNNqDfq335s?=
 =?us-ascii?Q?UaCG4HZVXhBnqSEPa5vUI3H7oGsN6x3LD4b3iqamuawOAJTZRk+gBd9Fc4uD?=
 =?us-ascii?Q?UMBv1aGyNOwzD000TmFvZboeCjDx5PGGySpF2wZFJkFwy6iiooJWVDLM1Dtz?=
 =?us-ascii?Q?wPVtgLjafBrkomuzUYg/DC0igg6W9LWW9slOpI924wVMh6p6Jyb0cKNdCFw0?=
 =?us-ascii?Q?DV8iCpytEZB0nDGGaGSE03FWIOCVETy8zx/n6lrQNdcLnoTRiXEVkuuBFaS9?=
 =?us-ascii?Q?Eqnn7x9zQQ/1dOebbosRzjBOw+AEJ/5FPbixQgpyBi5P6mRI43fFgsrXEAla?=
 =?us-ascii?Q?f2VFFynpBYYxD4+lVBRdSTqlZPKJwhR+htR6fErKfAH+nRR1NarOyiWPKw8v?=
 =?us-ascii?Q?0JT7IQtAkO8MTwjgkLAozQr5WIEFpJ5RSPtn2zF48KrprPXUmBfjv96UTecS?=
 =?us-ascii?Q?9gnqT80b7pfhDRUcm+k0o++UJFg+2nwGrUbWQxAbTXSe2jeLXiILVt+H3jZZ?=
 =?us-ascii?Q?l7xoAy7irS11TiWscADSS8HI6dOekC7kqAXYw4ZiCZBXwYTYnhgCApUCYJ4Y?=
 =?us-ascii?Q?ImOzODzDfej8rk+p7MbgfW4pfey7PMD2bVenRRSrf5T4k23DLZsCkFfVU2UM?=
 =?us-ascii?Q?0C21VraKdVadJUywblUopwplKShvfgd/pV3nLDrgRVzBEb/hECnxeufz16Rc?=
 =?us-ascii?Q?I4TTQYFTzW8zh8wqXB3nFdqfBAdzZ0VmWYLeB2rccCGqykVlOxFECzviAMra?=
 =?us-ascii?Q?/Nh3+5Kpv7pT98pnUjGD8cqgqm9oVYrbre0O/oRHTGyp1/D7Q946Nic972+u?=
 =?us-ascii?Q?SFPhWCQDeAWWth7HC/Hs85Ejl0zF+jOAbRvZGHijGdpPmLHGY7V3I8Xif6FQ?=
 =?us-ascii?Q?T2lgLdPSpsWlLoTPR65cfLd6Lf52R9tzZIeR0mR+CREe90IwSIOhokTtpX62?=
 =?us-ascii?Q?D3QlxyJnUoCuF+2AJKpld7XEY8td5qtVgTVM+XwCI6pCC8hnbMQxeRiUTrp7?=
 =?us-ascii?Q?EZJCn3R/x17vMczW4pzJN2qxpcQeeNeeKVGVkTLYJmKvM5CFJ+Xv3Xqfr0Mn?=
 =?us-ascii?Q?b80k0UjWacB0nIYeG+mV2Okwg3WmJDVo36JWH7evcoSm2LYwhTnKw6QTj+7y?=
 =?us-ascii?Q?JBHeD5pmfo2sAto6NJu1asbv2JYGywpXR73t3KoTrCRi3KTfXoNVXIQYCSw9?=
 =?us-ascii?Q?fSbrdZoPrP97eBSjL31QYblxuve8594C2H9ueOvMWzdQEHF0WVLG8QO0DaZs?=
 =?us-ascii?Q?vrowDvEgFwTurGFaDQoo5Ba3WNRLigwlN8eElqRyP88S5BB3w/rVTdWZBr7B?=
 =?us-ascii?Q?9b0SpQJivit1OcD6TZKpV09I9cY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7914789f-3a5e-4f22-bce9-08ddbfe5db90
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:13:31.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bub4xdvEZqSUc4tp5tb1pcEQ3wQtbjvY2XPedpgbA8fApg3Rr4T47isUp1okdabiSSNx+1GltBM/nu/cUJ3b8njSIGoQTMpWNA9O5ieHo+ElO71GZoM43BfTPYpt0B7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7188

From: Adam Young <admiyo@os.amperecomputing.com>

Define a new, optional, callback that allows the driver to
specify how the return data buffer is allocated.  If that callback
is set,  mailbox/pcc.c is now responsible for reading from and
writing to the PCC shared buffer.

This also allows for proper checks of the Commnand complete flag
between the PCC sender and receiver.

For Type 4 channels, initialize the command complete flag prior
to accepting messages.

Since the mailbox does not know what memory allocation scheme
to use for response messages, the client now has an optional
callback that allows it to allocate the buffer for a response
message.

When an outbound message is written to the buffer, the mailbox
checks for the flag indicating the client wants an tx complete
notification via IRQ.  Upon reciept of the interrupt It will
pair it with the outgoing message. The expected use is to
free the kernel memory buffer for the previous outgoing message.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 91 +++++++++++++++++++++++++++++++++++++++++--
 include/acpi/pcc.h    | 19 +++++++++
 2 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..2932c26aaf62 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
 		pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
+static void *write_response(struct pcc_chan_info *pchan)
+{
+	struct pcc_header pcc_header;
+	void *buffer;
+	int data_len;
+
+	memcpy_fromio(&pcc_header, pchan->chan.shmem,
+		      sizeof(pcc_header));
+	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
+
+	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
+	if (buffer != NULL)
+		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
+	return buffer;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -317,6 +333,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	void *handle = NULL;
 
 	pchan = chan->con_priv;
 
@@ -340,7 +357,14 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * required to avoid any possible race in updatation of this flag.
 	 */
 	pchan->chan_in_use = false;
-	mbox_chan_received_data(chan, NULL);
+
+	if (pchan->chan.rx_alloc)
+		handle = write_response(pchan);
+
+	if (pchan->chan.irq_ack)
+		mbox_chan_txdone(chan, 0);
+
+	mbox_chan_received_data(chan, handle);
 
 	pcc_chan_acknowledge(pchan);
 
@@ -384,9 +408,22 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	pcc_mchan = &pchan->chan;
 	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
 					   pcc_mchan->shmem_size);
-	if (pcc_mchan->shmem)
-		return pcc_mchan;
+	if (!pcc_mchan->shmem)
+		goto err;
+
+	/* This indicates that the channel is ready to accept messages.
+	 * This needs to happen after the channel has registered
+	 * its callback. There is no access point to do that in
+	 * the mailbox API. That implies that the mailbox client must
+	 * have set the allocate callback function prior to
+	 * sending any messages.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+
+	return pcc_mchan;
 
+err:
 	mbox_free_channel(chan);
 	return ERR_PTR(-ENXIO);
 }
@@ -417,6 +454,27 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
+	struct pcc_header *pcc_header = data;
+	/* The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
+	u64 val;
+
+	pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (!val) {
+		pr_info("%s pchan->cmd_complete not set", __func__);
+		return -1;
+	}
+	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
+	return 0;
+}
+
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
@@ -433,18 +491,44 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
 	int ret;
 	struct pcc_chan_info *pchan = chan->con_priv;
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
+
+	if (pchan->chan.rx_alloc)
+		ret = pcc_write_to_buffer(chan, data);
+	if (ret)
+		return ret;
 
 	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
 	if (ret)
 		return ret;
 
+	pcc_hdr = pchan->chan.shmem;
+	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
+		pchan->chan.irq_ack = true;
+
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+
 	if (!ret && pchan->plat_irq > 0)
 		pchan->chan_in_use = true;
 
 	return ret;
 }
 
+
+static bool pcc_last_tx_done(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	u64 val;
+
+	pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (!val)
+		return false;
+	else
+		return true;
+}
+
+
+
 /**
  * pcc_startup - Called from Mailbox Controller code. Used here
  *		to request the interrupt.
@@ -490,6 +574,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
+	.last_tx_done = pcc_last_tx_done,
 };
 
 /**
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 840bfc95bae3..b5414572912a 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -17,6 +17,25 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+
+	/* Set to true When a message is sent that has the flag
+	 * set that the client requests an Interrupt
+	 * indicating that the transmission is complete.
+	 */
+	bool irq_ack;
+	/* Optional callback that allows the driver
+	 * to allocate the memory used for receiving
+	 * messages.  The return value is the location
+	 * inside the buffer where the mailbox should write the data.
+	 */
+	void *(*rx_alloc)(struct mbox_client *cl,  int size);
+};
+
+struct pcc_header {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	u32 command;
 };
 
 /* Generic Communications Channel Shared Memory Region */
-- 
2.43.0


