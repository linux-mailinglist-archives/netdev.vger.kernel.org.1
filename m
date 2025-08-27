Return-Path: <netdev+bounces-217152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C1B37948
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B76A4E333C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF152D29CE;
	Wed, 27 Aug 2025 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hTGGdo0b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2099.outbound.protection.outlook.com [40.107.102.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC742D321F;
	Wed, 27 Aug 2025 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270106; cv=fail; b=lK47dtjNyQzAV89L4LGV0WQpkYK1JgctGAfzT2lTv6RT1AlcstiNyMw0FbHK013MltOoU6FEb5D2QedCYEvhY390FL6gPCM7BIXqElRx5VRHF4M12YWTFjf/i3cdhkKEavbPGx4hp8L4TrlwNmucCgFDh2NTaU25e5l47tXceNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270106; c=relaxed/simple;
	bh=OLGPIOjFYHv6uNgeHXIkKTa2mLDcmgHolykjf2Az2cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEGk714/uubPf30BpUE8srcRY0ZXeyu8/PK4EdKLusYHJWmQQ0Gw4fzqWbsAjxqFGNnTLo0eo3tPpEBIaqmQd4Z+8bbyj9c+N33uCnP2ZSIfa0EGprp/4f7+NuTPUNb+f3zMxaaN+kP4509i33/H3D6+aC4/M2kZ2dWACGWD8MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hTGGdo0b; arc=fail smtp.client-ip=40.107.102.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N66vp/qJ295WsomV167Js6jRXrHley3i3Y9a/AL39qYlG1WuSx1WYKmqeyVhs2BPQJ/QiD9BRlWZNlubuSm8psEsYK3YWosU4keR7lBSg/wwcmnFuCs8g64Xbl5cAomQ9arXd+teTS4NXWaMkweYQ9Tvmke/1ju2E50aUBAjrgSVgXJBDiUoyCAdGB3aSyur6idpBMxvYxJW/WcvXaG3wL8NS2ZPsjsstMayGxcNwxfbHPMxLWBKSzhz7rEbQ38Jnc/h9IAGVIg1wC7ukLaRGBKuAT1a4w4KIl71s7CWO0tDBL7KVmU67RRJKUWgqADTRy4BfiSDXKDAxnmc/NHB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+VK09ATdXQu2L8SN6xXf8/DPTLv7YWcyjMOoNPgTr8=;
 b=AToGsvmQinR0oul2dxI8jhjWfSNx2dD0Lukr3/TNuOLDO/+jEHVm+49iCKJ1g4vpn7YhC6kRCEk8WpGRVD4OUbIcJ38N1VOo8DA5+F6IhUYPgi+/L49VvphMhwsRq9sGp2t+Bt4iZnnnJMK/wom9dy1GnKRs5/Jjvd5LMww4zySEuVrvlz98wo0jvlyRRrHmMHTBSZ9FLlLINYCatDOKVgOnXsbcZkkf89kcjA1Vwenuin6u0nUto+ETueqlcXZ0rYSiPm8DarufLr5pK+x/ILGji3cpxDVMJpqxMiYg6o96pgGzW/mevU6J8Xr5oNLwboBQj9OCfIHqobF3gLZthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+VK09ATdXQu2L8SN6xXf8/DPTLv7YWcyjMOoNPgTr8=;
 b=hTGGdo0bnuBDIWvi9Lyd+ieA/FKjuafENl+EMSCxho4SAeoB7qP2jt9cPjgDDX2603YfIhKil8239DRgysuGfFOa1osWNtx4fMp/l4X3mekX5GYELDeK7c/ywA3RiQstdaASKRI9n3qXm6vGP9efHkY862Q2KOMTo1im0LEfgF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL4PR01MB9150.prod.exchangelabs.com (2603:10b6:208:591::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.15; Wed, 27 Aug 2025 04:48:22 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:48:22 +0000
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
Subject: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 27 Aug 2025 00:48:08 -0400
Message-ID: <20250827044810.152775-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
References: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL4PR01MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 84436e75-75d0-464f-ecd8-08dde524f330
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpy/SuwqTxSjT4/7SkcYe9LGA1cSRuo3AIqA4NMt4JcwYL+AHEyCzLQP5lzG?=
 =?us-ascii?Q?rDsgn8Pv+xbC6WlcvkwHdjaDQNfXfy3uh5g6qze3UjrL31p1NrQn7CZG+dbb?=
 =?us-ascii?Q?xDoojNsX4qrJ8X6f1tbuYBHjjb0bbe8cOcUgLYiTis85K7e1aJUawKhiGlzf?=
 =?us-ascii?Q?W8C7lfN1w1RwkNJgjDJuo0s7iEdEhO/sB9zm2xIVRHkTOmMUCu6ihxUyTkjx?=
 =?us-ascii?Q?x5mB6QCbP8sTJHWLl12EpABO9Bnb7h+k7u36QEI3kDLrPvoJrjnvY/O+jEdB?=
 =?us-ascii?Q?raQEwrJ5rfxw5YSWEVJU8g9cmT/dEMXkZeH/fCeqsunETxI0KuSw/V+QQDUX?=
 =?us-ascii?Q?zhRzwbRVMgp9xlT98XGpn4+duUrhACUuDLtMGnEpB4zy2/6DFInLsDcqbe4H?=
 =?us-ascii?Q?UQIiajh003R1IlDfrZdFHQnEKFEKdmkp/o94RbwNVYw9E2w92NyQZhD0amwq?=
 =?us-ascii?Q?aEiG79X1jE+9uIZxBBdoRlTHaTYx9ZnZYoLJ4F/M7j/6I31i8VdCIu4uMtXz?=
 =?us-ascii?Q?s/piqY/4b3SxAFBV/BxBbbS2WgEtc5uw/GWEtvjZ5jgTawJ6vBl8/Nc1IrxT?=
 =?us-ascii?Q?6gLXtVR6mmwWifRE/D8yPkQzjConzM6bSO5/UCDp3ByK8BFt19HXx8ug7b9f?=
 =?us-ascii?Q?bpoI1BHLI93Iuhk/Nr8IQuY3yjAya+fGiRvaa1xCgn+zmQHuQbDNhoo5drgN?=
 =?us-ascii?Q?kOXS2NtCnu2G7+JcEBHkkuxwjwivnmOVvLLhCzYw7XqWlUbvK0HqeQB71qZA?=
 =?us-ascii?Q?dHsfUzyNUlsWdcGrNPw+bTq868wVse/cKz9d0UexVTPr9wm5vpTXLyZj8RQr?=
 =?us-ascii?Q?BamIhQM3LM7MOeRIu5AexLxdx/U1fwIDVVUMbtxkpKK6h600/TarxPDA42gJ?=
 =?us-ascii?Q?Xnp+WSqmi9GgLIYl4aFKg1TTilzaY+bDjoiat3JH2++h/EtJmgjpCwIDz4KR?=
 =?us-ascii?Q?t+kv1K9n1A68tg2CHQxcDi6WdFThQ3Qj45Ayhd128ck1kbTlqm4NSiPRTkq6?=
 =?us-ascii?Q?6vcLMnsZ8qcqNLOfsroh+LUUudsrfwKqdW7dTQjX//gpjc9VMyphfFB1g97f?=
 =?us-ascii?Q?0I6heRAR7HUJLWwP3uL7fawGJrr73lnb7WlGb4Ezt6aqHH8SpJ+bMS+ehM2s?=
 =?us-ascii?Q?YOTCSAghGxgiKw8SqbiL58ZbvzPl20cMFfwLikgs4rYi5QrVjvkcTrpG6tLc?=
 =?us-ascii?Q?IWIL4U5h+WjtfOwJ64nbl0/Z1CVugxJJP9GtwlKi63EW3FtJHhdYo6lDsgJC?=
 =?us-ascii?Q?Z4HIvDCiu3suKaRBjtwrc3XrTECwvGqB+n0gem5tHLV5ciqWMnOLr4iAt3pH?=
 =?us-ascii?Q?r0wS7P2CtDfLqYPZbehl2/HBtjh3BuvNCfh+tbqri9RPJbTkYXrBSLP5Drtj?=
 =?us-ascii?Q?334vO1SeW7te2Ws7qpassg4dJdytvbUIUFUiuHBLLwndgIpFL8jubFtkzTmB?=
 =?us-ascii?Q?W3BWdamjbcY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0V4fJLAjVihLkWS49m5g3Yjyv1DVeeJO/ztJstwZuIikCOZPYCdh8zj0dpX?=
 =?us-ascii?Q?H93ltQcl220xrxGBEz0jz1O1FX0plh+pDkWzRSPMz7vJ0WRDG0iJZvxz74mb?=
 =?us-ascii?Q?OCS2Ylxq+kJntP7N3PkKIErmiNsjirYHvt0ZMXShgPULbkMHejNqs2Z/GrFy?=
 =?us-ascii?Q?bjA1TgVJSeoch/85GKZgqcZWUWktUI8NTZYAenF+K2kkvSF0g5AAX9SI9roH?=
 =?us-ascii?Q?XOSNRpmjr5qnY24G23vyvlyCugeS9xGW+kKAukcxhJ/2RH6IfhlkjVpiEyIN?=
 =?us-ascii?Q?MK6fEm+2BPIazY/JBHuwRvtNjsSkylSWKmRtsoBRsCB3ymzzQXT1aydRbco5?=
 =?us-ascii?Q?rg9VXZHQbjr63WyM+isWjHHyywqJtz4WoJCsdVk5GDLE6L4kkFh2A1IEZqBY?=
 =?us-ascii?Q?9IauYrMNmfNIitMordlyatT5N3kZsq5mz8FahrPqYsU0vhgwj6qWlngWgX/U?=
 =?us-ascii?Q?cwan0qG1oI8tECQZV005DcQl2xF7cQCuqw6d+iL+ENue16Sv/k2aaN2hqZik?=
 =?us-ascii?Q?8/0CRmlyqMLNapMDubwB7GQjXtGGYl9VQKGTlZ+SJ/RaP2ZYcn1l7qfdsBw+?=
 =?us-ascii?Q?pxVDDrCaZugOhUM2OFjPyNS7LlU7+X0wJpRljFzddN3B2Jzom5WH2RGqSs0u?=
 =?us-ascii?Q?dzOhKsyiPPaW0SVBrsBgQIGCrK/AXhCrVdS2BlLitRsrZqjCviHw98G/YFRM?=
 =?us-ascii?Q?G6yHmUBZrtBh9OgoGEW2lORrfY6ok6MbYFOtCdIdH9+8gs/8GgfNHIvN2V0S?=
 =?us-ascii?Q?RgcDrr+JNcTlvnpObMCfR82mJ3uRwhdy8VbMObH3fkGtPhwQbJr1Ons+vhjY?=
 =?us-ascii?Q?P5I/tAiZUTfKQJGsCW9rkU1H1t5ClQhU/ZB3yfyyDZoz8/xKVCt/RVL7c/0B?=
 =?us-ascii?Q?qJqRj91aumnw9otDrTcfz4IBsUsHIRNMQFa8ISfspWOd9+8gA7i94twxLKxV?=
 =?us-ascii?Q?0hnWOowH7AYLknFxwFHmYXDtZqh5hVdg8nV5NXb9dOqOBsFIaebnbrygSdxf?=
 =?us-ascii?Q?J08rz0bn3a8tNAkDx8WMVc7kg/HA0A54Fg4cAllbhxYYMONi7gIkfpQqAl4F?=
 =?us-ascii?Q?bY1MdWQbeYoMkUdL0atqc+w5hCf3wLdMTQ4FlSq9V+jbXeNYxYbqKrxThAyb?=
 =?us-ascii?Q?oK5VdtYRAMxsGZYKDP3LIxEMbAegCZLF+xamMP9C2yiH0eqiPmSMc5RGVXl0?=
 =?us-ascii?Q?kxUezTVJqRLb+o2/airUz5HRrN/JHwDcx+0JVJdI9/PM22DRNy+CZ9SKpMqr?=
 =?us-ascii?Q?xVQSVOp1PKGMVDbrKi29p51Rwa7R8nxqmpGqclByFc1UX7k9H8tqGHDoYWJa?=
 =?us-ascii?Q?do3Fvp+982QC0Z8oZr8qkfwh8YFeRGsb0sBfzbvx7UoF1oVHklgY6DzDseKx?=
 =?us-ascii?Q?kJGSVulI8har5fBlafnz4hcKLnpeabk8mARoDFh+C7SHFtvMYpLTFhC6w08g?=
 =?us-ascii?Q?ngaAHMQuiaViSsZKNxImKsJMv6nX5rlRBUED5+KnKrIqsmuCchTJUvQaSBmb?=
 =?us-ascii?Q?VfL7g2p7dOAEmsZYnJOfrhRJ6RP3L7tT+L/2yD42z6CIZ1/seHE2g+2a0yaR?=
 =?us-ascii?Q?iskSvUGG70f6yS9AS7RQ0z2oweoyGvoxPwi3EM1D+Clw0eq+qfXOgD+hEse6?=
 =?us-ascii?Q?O5QTAffFTGiSN5+vBt5pqjwIxeYY983BFEmATpiqdcu8itAuxGPjdf3n2bMS?=
 =?us-ascii?Q?FNDtNJqn9OrVQU4u4ihafQNClAc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84436e75-75d0-464f-ecd8-08dde524f330
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:48:22.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wywy+GIVWsve78S9x3x0ViRMmbWHPBBLcY4ndQQA7FlUipOGMlVPH/JvisYkLQdrY5w8wEOFmKB/Aw7ne7MLFtfqdlzw2orD+Wflf4mkI9XRE8RUgAtmkXL+hNmzMXB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9150

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
is also responsible for allocating a struct sk_buff that
is then passed to the mailbox and used to record the
data in the shared buffer. It maintains a list of both
outging and incoming sk_buffs to match the data buffers

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Bringing the interface up and down creates and frees
the channel between the network driver and the mailbox
driver. Freeing the channel also frees any packets that
are cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..de359bddcb2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14660,6 +14660,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..c6578b27c00c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,367 @@
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
+#include <linux/mailbox_client.h>
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
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev =	container_of(c, struct mctp_pcc_ndev, inbox.client);
+	box = &mctp_pcc_ndev->inbox;
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		return NULL;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		return NULL;
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_queue_head(&box->packets, skb);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *curr_skb = NULL;
+	struct pcc_header pcc_header;
+	struct sk_buff *skb = NULL;
+	struct mctp_skb_cb *cb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	spin_lock(&mctp_pcc_ndev->inbox.packets.lock);
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, curr_skb) {
+		skb = curr_skb;
+		if (skb->data != buffer)
+			continue;
+		__skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+		break;
+	}
+	spin_unlock(&mctp_pcc_ndev->inbox.packets.lock);
+
+	if (skb) {
+		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+		skb_reset_mac_header(skb);
+		skb_pull(skb, sizeof(pcc_header));
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+	}
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb = NULL;
+	struct sk_buff *curr_skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&box->packets.lock);
+	skb_queue_walk(&box->packets, curr_skb) {
+		skb = curr_skb;
+		if (skb->data == mssg) {
+			__skb_unlink(skb, &box->packets);
+			break;
+		}
+	}
+	spin_unlock(&box->packets.lock);
+
+	if (skb)
+		dev_consume_skb_any(skb);
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
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
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
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+	int mctp_pcc_mtu;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+
+	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct pcc_header);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+
+	pcc_mbox_free_channel(outbox->chan);
+	pcc_mbox_free_channel(inbox->chan);
+
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+
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
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->client.dev = dev;
+	return 0;
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
+
+	/* inbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
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


