Return-Path: <netdev+bounces-140004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374219B4FD9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9938AB22979
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691361D959B;
	Tue, 29 Oct 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BBG+zPBr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BD1D2796;
	Tue, 29 Oct 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220871; cv=fail; b=f5WoEbjU5ieShhUZXu0oARMZ7Esc3AyFI/VaBn/EtiVb11i8scOoZoJStdAVdEmg/dMyUmTYEvqhpGWPDsh6Zg4e0LJx1t0BU7c/ytD7Cxr8hCzsKxavxDwHhq87QODKL/+PQ5R/3omyC88KhU9ZeWzyhIirnSgimQci4hRQ0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220871; c=relaxed/simple;
	bh=rM8S3Rt9A2tri9g7wNjHXB67Mw9y2WM2wTjzgf70mWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mF5XZybe+paTL3yTLH68bfxzPLvFRWlc2/Fz0q5EBEWIC2zlU6V2X28FnhUy0D+xCu+pZzOKdCEtmB0IxTeSMEq+rrwaQuXpn1v5/8stBwmo235UWk9KpMtA+qV0vt7GBOv/zNUUisejWYZ2momQpTaWNmI6OOnUi4uAPwPLh/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BBG+zPBr; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+rmvDSZTkl5YPKbq3JKXI/orKlOu0I0GvVwVz7zRGzYaER9sV9ZuyPhiwfwD4BhxbfeTELl9+ZEqxWV/XMTku4P8Za9hHUeGtXK99ii/N4nkhEaevm9Zt5f/JbgVDeBKbdcCV3qPiAWc0iC2XxkWiOb+b5j9tdblbZC/wV1K+H+rkk1fbZiUG3nas9BKH7XvM4fNMjvK9bUwX+TQ3TNV25SBn/k2XY9kyGSl1TGSdzMAR0jZ4J1b3KTSHYbGsjoviUqKtAz+0sYnT2aAKb8VK1y5tOq7x+kLtfLerXb7zQd/mdNsScg53vrPtG0GrnLRJx9HeIpQyee/+ojFveKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8nfq8HajUkLRJWZ7V5EV8+D7uBd7lwnRW3Eqhybg/U=;
 b=yVgYu5s8JBW9HHLDssRsOGg1NWMHbD2SHm247cxBlWi8GR0dB8D8Tp8T6Akm9/D/YFQ/9bRThO+5nw61STz1T0PZ0QsyUNMc0CgLCfeeaoTenEFevmH5p8t0z8L3QEE58YM7o0B7b27NjajxK+BnGp/29+ultuc+67HnkbcXB4vaHnyV9Am4k3nkpkHjTbS3zRMhdC1aykLVQxVWWqC38UpU9CetrD7a/LBINXhbjI3K4lxDBqn/R6T/YJ5O+0FZcL1CoacqkkhoH1gqvZAM4AswSKMOO1hq8xrC7Cf31xbGBAfx8sjAoTu9g8j3Ds3xDgZ2I3twIMejtQWK39cwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8nfq8HajUkLRJWZ7V5EV8+D7uBd7lwnRW3Eqhybg/U=;
 b=BBG+zPBr2fwDayH6sqNDF/8ulFZfGFy/st8iJfyo6tL0N3Pl8kswVDlFyPjqh9KLz5tR948KsM6b0X2RYgVT7rSRjQi68TOQHPX818M9+nStOJCGpA+UNEDsMkobd+lV8Yn/gSlKv0t8wkWdtRJZHFuygTRazHPZSGWry7BDM0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8372.prod.exchangelabs.com (2603:10b6:a03:542::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.15; Tue, 29 Oct 2024 16:54:24 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:54:24 +0000
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
Subject: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response ACK
Date: Tue, 29 Oct 2024 12:54:13 -0400
Message-Id: <20241029165414.58746-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cb0494-66d2-48aa-f3a1-08dcf83a57b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FvF36TRuD111b1BPkN6kpUvwhuL54LiIyUZ5rc2Y7I4AQG3LK5zUFhMbTGUm?=
 =?us-ascii?Q?5aRSXtd+Qc2W8LNBEJEmfCTKB6uJrrbsC1b1EiLvUGlSqRyZfw8bf/71PN4A?=
 =?us-ascii?Q?9d9VWlk1hLKEGg8o+TNA88YdbqJfxYWiCbsCsWS6Hjvc4FEaBvz0NNk6pZUs?=
 =?us-ascii?Q?7xQy0JKiY00ao1DRQ9nrw1g1ghRmfi9ip5BLCJIX9bziOVkl7vaGII/VWxD5?=
 =?us-ascii?Q?ok6EeIgFzVwNMkgbtIZGBWWi5Z+glmYKyNu1YCztII0lJvBreT6ZObGQAbuE?=
 =?us-ascii?Q?uwNm6NapE1vKWca8OZl2o/HNOKAeUHCLyphQBf8R2jGDuMeR/idhPYmo4qow?=
 =?us-ascii?Q?jjueWPvMDH7gyNs9xiSTj0+WZo+135R3KwyZATuD1ZxsJ3DoslgVdowr4yNT?=
 =?us-ascii?Q?S2Yp4AhTzgMXngbi0NP6ixzXvrtWwN6aqppxBvy3Djh6EX7SBu4wxnifV9u9?=
 =?us-ascii?Q?zUrfY4TBNZpbL+k3rEslPBGPTzbmTb66PtLNw6OQIc3GPQVxJmKSzZPTm4/q?=
 =?us-ascii?Q?u1yPztjngKPkAft+4Hcq7fiBLQ4F88p9LZ5GPtlhIO3hx004zYwYiTE2h5cp?=
 =?us-ascii?Q?It9vAjzNF5BNJY8IQFVTPHxHIv53i801VbnT9BCwrkHlJ890Iiv8MCOQ7ka/?=
 =?us-ascii?Q?3WAsGtdPpXXlEdHXZatoeBUjUblUTpK1s0V/J9/8kSlILacfYCQkvwXyLPHy?=
 =?us-ascii?Q?lN/mC8eI7IzKAGUwestHBkDlwKDVFVNjcnVCSRyT19nQ3QX52uG0LDBdA4QI?=
 =?us-ascii?Q?zEWuh5z/HiCrxz6Y7TgfR6Pb80zIScPfzaJ2GWF28O8V0xOE2EgzABL5+Voz?=
 =?us-ascii?Q?c45whlXOQPJDUnkCVWrlExxO/ljho0jWPk8hEARv1D5Gl82gLFHAaxN0YYq3?=
 =?us-ascii?Q?a4bvGjxbeHM/kzno7yOAuDaio8V7T1ZSpFvOOMN/+W4wsyOlYREHc9QiRXju?=
 =?us-ascii?Q?NkkcBHg6jzC51S1RDBTtqOdodSJh9iCAEtyCFlGfHUlYObrquPLKhRNrgkw4?=
 =?us-ascii?Q?GEfL3+jcapKWolggAT7N+XjSTwFSfv4GlS6Fp0+NBYRs/iK8FAKh8HJZeS1T?=
 =?us-ascii?Q?7toKTQivjjeAZh28YyzyNgRC+hEB9nD2kzinEs2x+xVR9cGsGgTxwKbAtJaD?=
 =?us-ascii?Q?hhppH6IB03oDW/g5a1B61qjZDV1vjqWQiwC2RJ3DMsawpIrPg8YSZ4012eWF?=
 =?us-ascii?Q?TZnOMWTTEEi7EwsniXKt27gGnaicl3pc4ehulk0JPkk5prg8/+Zt0kF9jN11?=
 =?us-ascii?Q?Vr5Rz1zSTL08hMBuBhLIsrcCSFgplYruh5pBszTUY8T53uTBbV74ZABZbFGc?=
 =?us-ascii?Q?5PRsqWQUXv8WQQy/ohhhLHkt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBxvJ4pAM6B9aCHnMrXLKUV0zhDVn86p8zUzmpVpLK9Hwy+vQkgzt1YWrJOh?=
 =?us-ascii?Q?xBI1fhRrSzJ23ykYz0b6A+OPni0RKRGl6L8s8EzMUUqWJcHgMS+9ONrMWUQJ?=
 =?us-ascii?Q?lAcpw6gfOE5a5NwU356a7/m8obGh0JTrShravlkZapxT6C/oZeVWL24+ShM5?=
 =?us-ascii?Q?ceV9dnTo8V5OhnBaetn27CmeDkzehPb2qxz6KIcfnP7We+rxe7iXf8cNZFel?=
 =?us-ascii?Q?/JxmPKXfMPBF8pJJiZy/LT+SFqtBq/l0AS4elDnmWIAGHFGElVjhyghDpUsa?=
 =?us-ascii?Q?awV4ZyftwxiK2ssh61XXbeRzy6jXXDec3gJWNUBZQ6lTgJgE/5h6GGYtp14Z?=
 =?us-ascii?Q?3FjiZD/es7B4LQhfZSSf3fKFqebPuoFfgz1GhSbIGWs3welJRLmDGC9ZDONe?=
 =?us-ascii?Q?Kgar9EuM3XHIU6FdCbAaJyAnugZQKNHzO5ZIBJURYREP4gQgr7dh2aqK6WGe?=
 =?us-ascii?Q?nNt9u8eHsj5nPyVlBxeNxs1Rc0QrbrNOyNVM2nT/h117IgdssNA3f+nuQdi4?=
 =?us-ascii?Q?ukD1bFm20yvYKzMctsmRHHSj+haXPjzyrUKFeXdiXgrU8F82uBGSQdJwfWnJ?=
 =?us-ascii?Q?hdVFYb4++kwODkwP8Zzt0n2MMFvWcQdwNpQFfuPVRdmuE5vaEEwlk31aYWpp?=
 =?us-ascii?Q?vWCLACGaNjVHrlrMPylXkd+yf37QIcBagomPxG4YFQVhnz/bOFv1V8MhGVfP?=
 =?us-ascii?Q?bf23WYgY5T3BcCobqSsf1AIJTefvoLE8pFmKcrvcCXQpt4elFCW6nrpCcTN1?=
 =?us-ascii?Q?Vwwg7iPTeFlNi5tcMzNlgKQ/hMQnttaGZINIeGaDvfXXk2pXdxVfIL01NWF2?=
 =?us-ascii?Q?vwnVwfipPcC9LEF0bBjhAFKAqtPNLDY3MFmZxBmzu99AXiY2qbWg9jPkAH9J?=
 =?us-ascii?Q?2l5zQStKZvlJXnr7Uazm4KsvaYxuEpkWPOUVWKskDZU1jWMN685hWKItxj75?=
 =?us-ascii?Q?DOhQwLpD7lbPQSaMoUUIuqVlZaDTwsbx63smzvG+BGHAXsnL9yA5kW02tkPX?=
 =?us-ascii?Q?j15NlUoaD+0qRTl5IrI+K94kHn2U94cMKVlhtz2jAIWU2agpGruobImmqbkA?=
 =?us-ascii?Q?b99fV20EqMxEgwbPrdJPl2Jo40WJeabqls8qp5JDIjlF4nsiC276jDGCP1fB?=
 =?us-ascii?Q?qzFCVKYWHx62zJrWUVbLgZAJYP5g7y2RlmcTjI0tuJnOYe8tFSAe61tBDyMs?=
 =?us-ascii?Q?6O4d+qUWGlBkcmsWSFmAgK/nS24E7pg5iS037OlUb3n6Ri1PSQ/eor+ippeX?=
 =?us-ascii?Q?HlwIDVvda+NAQ77p/QEMLR9mcUv2r6cDpzu56pfgRtIdD27z8cTNus7feb/y?=
 =?us-ascii?Q?tooZDAvsvhYCtEDEcVagsn9w5txB9JbqnmNCgp+h1K1cUxWYi3+Roq66FtCT?=
 =?us-ascii?Q?C6kZRRF+b04Oc3UB9W0WtqZfZHMNF9xwwKzBFYv/1eBhCLKhXaBLO0LccjZp?=
 =?us-ascii?Q?Dr6TAEbEQcPOWfT0gigtXW4t1FexQe2tVZAQp7/W8to6Ixv6xq6x9v/8Blb5?=
 =?us-ascii?Q?CwSx0hZLrITc96lcHhiPvO+8oVt+sGyr7PV9hH09XO/SmoyXMFIIPE3tabJt?=
 =?us-ascii?Q?4eNwqnaMOHkkSvcVlmAgRamq0b34+EhheWeuuItROLwv6HsAM7lnjJ6Ijr2P?=
 =?us-ascii?Q?3KJjM7wFCXEVgEdVly6p3WBozWAZ/SW1mR99L3kUH1arjxYkCZueQ1+OyTQE?=
 =?us-ascii?Q?t4tLlGi2Y8ABfjNmDo8YVj5cRvg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cb0494-66d2-48aa-f3a1-08dcf83a57b1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:54:24.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Did4/RbyayDuajF507bjQtgVMri8ULMIEJBnEJHXrLUMaxwAoAHHbitEfi0C1To4Jl4VBwrS6fqIq1b1M+U3bmSDEOJIU3n1LGNznmIvSQXkqBaK7DbWf0Xq1pUTL/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8372

From: Adam Young <admiyo@os.amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

In order to read the flag, this patch maps the shared
buffer to virtual memory.

If the flag is not set, still set command completion
bit after processing message.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 35 +++++++++++++++++++++++++++--------
 include/acpi/pcc.h    |  8 ++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..b2a66e8a6cd6 100644
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
@@ -269,6 +271,27 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
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
+	 * after processing message. If the PCC_ACK_FLAG is set, it should also
+	 * ring the doorbell.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 */
+	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+		pcc_send_data(chan, NULL);
+	else
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -306,14 +329,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
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
@@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
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


