Return-Path: <netdev+bounces-230227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67047BE5807
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E070034847F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20222E612E;
	Thu, 16 Oct 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ktGuzpys"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D892E6100;
	Thu, 16 Oct 2025 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648569; cv=fail; b=Uj9val6zg4KFoXbv4sHFU9UqKam/EN4GSXq8ZG1Ydtbq/wVuRwTpc6KmnZPDDAJeOoGsV3Jfz/aQzw25sQ/FD0L5cBMUL+eta9XPCqspVWISOiOHt50Y7n9gp+c+qW/R8PkHqH3Rf6TR3NGNxfjcf7qDjNzooTw3jYw9tXA/ses=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648569; c=relaxed/simple;
	bh=nuQaR0buCFjIVK7S4s1+7z4Tc7sihJdAhDMKiqzeMVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lITF0koYoQE2Sux6cHQtN4C+QWlmJ15cBQD3xbj6uZ/vtccYsbahwtTGAs9k82kSzleI8QCqwGF7l5J9Z+o+x0Oh0SrWoJnmxt2Q9/h9RyEOwVDarxLEMWVyveYD/zQfXho+MMiKhTa1x9mpnTHYBcKJ3rvYcbbBY3WGa8wZBoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ktGuzpys; arc=fail smtp.client-ip=40.93.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxUv6Q9M4Viw2WgFpc8Kcjblg8cvVZsf1OQi3OjL+JiDFFvOLu9FKQzZcvXUEx6ISBa0FGqNV1I9vXleE9IDC0BeIy97SmLCuW8Eo9gM6ui29O5gLTnI2v0WI/QhwAGJEgc/LkjzN5eH1GhXQHCoZavdUA5M0oMSKRDoRzGcItxDFtxtNHZfWTJ/NIJTousVZCBlKIArnGzl8OhzXmMeAvFnI+YCYH6VrYjFpulnVDGwAfLOIs87xN6DzCVbEKjeEI/7rxNjvJ2QU3KRGHQxbXWi8fWKLE+vPZhhKpwdb9cO0NdM2/oV8Jxdt4PTP6VyIcNXHOCBLtZJoXLKQ8cTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSzn7FZJCnOWKB5F0fd5ql/t+eQo2DrwImXplRPd5QU=;
 b=KeYoTcVOhPEZOONBgqePcPsVQl14lk3VjPe2W/rv1aBwKHUWjGbU9uJ7J8KIVZkNHFCQ255uKfhiwzz87YvrTNEKzhmgGoQsleMkmcy4e+ik5P4eI5RQVCiDj4to1HyaanWL4LiMsf85u1szeOvWbtCy6aLCLIbq4v/85lRbWMn3Hx8ALoEo5v02RsHX0h0N2rzZxTEXQPTG8uM475Y96fGBzhfjTRgd7VQjt8uj7jRsN4S0BhWo8Eg2DhfhyW57z7k3GKBRqh/Lz1fNh/QGHY7Mj/wQYYM2sqlyexJpcSiyVVsIqUvApmlD+VYnbnwtMQ7PYYuXYh2E/t0MYN//Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSzn7FZJCnOWKB5F0fd5ql/t+eQo2DrwImXplRPd5QU=;
 b=ktGuzpys+veybQrxGwK0ccciGHrXESkEykC7AVjT8tPcrXESdyUl38IhmAOUoznFfZkayGYP6QN0+diPL50we7jKQL+0YaomK8QBPFuSLyTdIUeH/lWtFajXbwgG7c+pitYKDwrqohdF8REti8xkzXXtuuEsk+AJ/OZTbsWoOmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV2PR01MB7813.prod.exchangelabs.com (2603:10b6:408:171::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 21:02:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 21:02:45 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
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
Subject: [PATCH  v30 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 16 Oct 2025 17:02:21 -0400
Message-ID: <20251016210225.612639-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0200.namprd15.prod.outlook.com
 (2603:10b6:930:82::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV2PR01MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aa5864-3d4c-44f1-3c00-08de0cf75ac3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zj6Xno6JMJMBitj+uTUTZf4z4pAt54mTRaz86x7zkF5i76iY/8wL9suWGg20?=
 =?us-ascii?Q?JclMuP8/267PxTpvqAeCrTt38yxEnoYdpmeEq1oRc1fHkOeWv5wlrrKzHT8Y?=
 =?us-ascii?Q?3sKd6Sv6JHf4sUkPiBDqdIq6BxnZgH28GnFGSC3col60CYy1QCGGWisD1MMt?=
 =?us-ascii?Q?8Oqib53q7epz8Z30lUHCFts0ZfGs9GBvqv2tK2h3U1HNXWdmyrQ3oPKIYlHB?=
 =?us-ascii?Q?awTqxRi2Pqg7ZjdzcAWYeY+7FN2Il/8uDtvpDaZ+mMjrFvfRDsB7Tg9u84Dm?=
 =?us-ascii?Q?kq9H7C35qGmbguex22aXGYZuj8BTuo8hk4ohJkLjL57qcpDPoY0KpmjrSQJQ?=
 =?us-ascii?Q?PyVLF6IfdBdQCOwMnzB0bsYKIZGkBlo/LVIcblnJJMFr5gp7QvDshp/3wQhy?=
 =?us-ascii?Q?5KULlPMLNliiUwr3YiJ7ha5gLayMRZI8ycNaSuGDPL6TNaN0pMPALXOHlcn5?=
 =?us-ascii?Q?ApuJD2eXdbm41oE7OrzTGOHpldYXP4yGheb36AiXkuM1Xd3jhWGMqE7ra12C?=
 =?us-ascii?Q?kaxZYnE8XkgvH6DX55WuVaHtvvsVJtZ+R0/oTwWT3ZX97hacp5VrVvjagkgY?=
 =?us-ascii?Q?QNcUZNAVHMtrjOwyA2YA73NCHjSov+A37TJS1QfQ9rZDIq613ut9VXb6OvH4?=
 =?us-ascii?Q?56zwRav+2UDlw/E92n3TTiYBvxV9dsIKynWdE7BgtE7/+llkc3XfBwwSsvOe?=
 =?us-ascii?Q?V+Icxj1IdHrNXp+4N3Jd6gwucnpXQvN1IcCE0qfKe+BNpMBdP+BYzB3pcAFE?=
 =?us-ascii?Q?jqdu1qQzFC6DnQNfZSsfS5brk5DfrbyXmePU68SmR2T8K78WTj0xIbObOfJo?=
 =?us-ascii?Q?15LtKxeaA+5NVkJ9Wj2f29f5rDqjyfjcWCrU3f89rDYRGPNhD/3r8o4HcB0R?=
 =?us-ascii?Q?PGEOZd4R+tLLGo/pinz1hLLGsaPBaCnO+FLLhuE3NcnSPP5ZXBMOtl+pzjeP?=
 =?us-ascii?Q?xH5eHh2SnwjNWKMYnIG51+N2+scHx03jccANIXr4WOcCYMhnIOxR/20Xu80b?=
 =?us-ascii?Q?nFWtqbSreYVKlATgPh1EICkgauql5JbDmB2G7zTSsHJZ7rTovlOyEgLdJTVr?=
 =?us-ascii?Q?MRymGIGZPEOllP/J5mMbhTW08DIkjiVj17QId1lE7UBvdGjzp2pWgDtU1JKS?=
 =?us-ascii?Q?a9af0wJte2VPX/c0F2+3qVQ2ONfg80RUqbv5Jiw9gC+KqyFSUfl2SWpLlE+m?=
 =?us-ascii?Q?WMIlNG5ucj31P0Bq2RZM9gk/XPVGOOhQxiBky3c/YuvVUSvvqLbDXXgnedsm?=
 =?us-ascii?Q?668tuFaTdnhD6OMGCHNm9pCBghWs2mS/w86w/UM8WLKuxHr6sNgJOZNM+cNR?=
 =?us-ascii?Q?HZG7QJG2OisqxOFeBJSU/igP+BMlRx1SNnpxA18aocFofnLPWggxtYLhu+xx?=
 =?us-ascii?Q?IQ05PLF0EgtcrE7+iopJSwar+CIXiUMlBhjI5m6+4ubBypWwXHKHs9h7Rlwh?=
 =?us-ascii?Q?GKQPA3ofnT+vWWiQR6G9Judlfn+tkXJRaADi6UR75BBQWwJHB57Jkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2BwDEAaOncPfqG2GVQq0Fk/rYOLogyKMgFrp5jOWfriUXPrGQ/H/VViVlD4?=
 =?us-ascii?Q?zNFV5kZ5uCCw9YHbPPNtf5/rIEBe2Ha1LULC09fFnSxkjfTHqPj6Y6A0Z4zX?=
 =?us-ascii?Q?+u/myBCOXvCezevRwHsT+i9USaz633ZOve0FwCxuuG/E01Xj5glNsgD3pN9W?=
 =?us-ascii?Q?AVJ3ejIn2XeyNpRQOIgHUdoz0uRD0lfe/aT2o8X4/EoEToYv2ICOoBfNvcTZ?=
 =?us-ascii?Q?JpjRh4CMGOXpCWlTwMnKTyV+Xe31oacxgsFD81AoZq58nSb7EtRhlYYowPng?=
 =?us-ascii?Q?UwqiqoY0vGXI+9wMQ+KClFrNYAQWz3Lofi4gydIG6J3tFEZ6Vx9SqvinH1XL?=
 =?us-ascii?Q?Bfatn/BmZpLFSjkbT2Z8Hef2KfVflPKbru/e3f935J0u7f8U+ELubenGJR7f?=
 =?us-ascii?Q?UYMSFerLxi9V7ZRMBnAviuPATfM+zcHvDUNzDpJudN8V9ekUzRfW6PDfxpI2?=
 =?us-ascii?Q?Fdhzvk72rtdxcc8UIvf0Q8yhbI0eBNRQuh2e7wTUAjAls0PvLSvwzfS4xrlr?=
 =?us-ascii?Q?FY3T97qA+2ZPoen8DLwMsj89pgX14r1D1LXYzKL4DLkfdcvmoHaTAvpJQCYs?=
 =?us-ascii?Q?f/jPKMGAu3nG27464o4RyzurYOzsWzGN2ojLZAXIM7VUbmjFrGaV4fykO1Of?=
 =?us-ascii?Q?tomEiNV7sx9AxiNqb1CdeUTw75aLrIJUkxHh2vMmx09Obau8FHaS2YGf+6GB?=
 =?us-ascii?Q?b+LuRujd11Mns+oaSjbJkgK4tB1Do1fR/8fa1Rz2BX2c7VpIrX2LHI2WMuFZ?=
 =?us-ascii?Q?bqTJJ9n+OCcHAZf6XzY7vAgtGE+jAujnfftR8b5rF2T8vohuMFramtuDjw5E?=
 =?us-ascii?Q?YMT3g2lVjOHRvrBu1+xjSjecL9wXUyy+tB8Oz09px3+EHn/UHG140ll2g5VC?=
 =?us-ascii?Q?MVT9SmqJ3GG5jjDez1nhfkwaXX9iP8Ut//w0HsLLJwY8vglE/S3T5SO5/xl5?=
 =?us-ascii?Q?Kmh5K7SWjSxQQVUfbg9HaZpV5EOvvB9jakrqqUCwHbCYaVbA15EPxM00suyp?=
 =?us-ascii?Q?Y6f3JjfCT0golyld4oVFDBbQvogh0PYoC3+y0golW469OG0UgbJYGI/cJkel?=
 =?us-ascii?Q?FteQLX/bYr7wmeoMojlqqRFDRwrbMc0Qp5n7fm9pLLYeszxBVO1R2aYpDwXA?=
 =?us-ascii?Q?khsSFgUfyAaV/pl/Urj9GdrT7oLEkkMgf6thEMOEy3tl41NyElibYgPPrZ4v?=
 =?us-ascii?Q?byYoMqxAjee6saq3XRP9O1FMuiD5+Z5UDUvecninHclajrVIdxNnuyyJ9NIz?=
 =?us-ascii?Q?2NtirYSKvq/cg7KN5fC40Es4FKeyufAoApr+VWwWEPAXUhRBdVnqGq3FyiRt?=
 =?us-ascii?Q?DNq6QnDw2YabvkZs5lmvikhERy9L9vxa32Qc2ognCXLV+yx8gdgrb/tBUkVS?=
 =?us-ascii?Q?VfMqo1x08z3JyP95Uwc+kxmjyLMNiCLfLyhPi++rWRZfryGgV+4cEFR6tBn9?=
 =?us-ascii?Q?3z+PEeiO6/qFCL9CmAPGqwpuJS6/qR79AXZ68dMOKZraJS6/kYt7BoHqao1M?=
 =?us-ascii?Q?cS1SR37CmSvuICbX3fUsG8lZEV7j90/FLEM83mmYLiX6MOypd6YQC4I3DbPY?=
 =?us-ascii?Q?f7/LE0Ksi7MNPoQyeGE7rHiXPouTxsSL0c6srvWXvHBXY0CqynMvoAS3G8Lm?=
 =?us-ascii?Q?q1yrERA+dNG8zqOMfUxuGE71QgtAqqC65hBRDjLj4sP1x5ZDXvqBcdl1oL4n?=
 =?us-ascii?Q?dC2kuTc252uvwHURozS3Ez3mYpw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aa5864-3d4c-44f1-3c00-08de0cf75ac3
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:02:45.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ1kB9z61zV9ynapjG2E2JXt+4ynqqCFc3eVRLEdDY2jF38zsRikCaLwSazowmX2me82AXqJKMjK8P3dvZwFKVaWzeVqN3zr13ENearUIeJ7u9etUk7Nf1Ae9ghsBndH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7813

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SSDT and reference channels specified
in the PCCT. Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox shared functions
management. Unlike the existing Type 2 drivers, the mssg
parameter is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted as a PCC exctended message.

The driver makes use of the pcc mailbox buffer management helpers.
These allow the network driver to use common code for the reading and
wrting from the shared memory buffer to the mailbox driver,
attempting to get a single implementation of the PCC protocol for
Type3/4.

If the mailbox ring buffer is full, the driver stops the
incoming packet queues until a message has been sent,
freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Bringing up an interface creates the channel between the
network driver and the mailbox driver. This enables
communication with the remote endpoint, to include the
receipt of new messages. Bringing down an interface
removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are
cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 319 ++++++++++++++++++++++++++++++++++++
 4 files changed, 338 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..e1497608a05d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14915,6 +14915,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..77cd4091050c 100644
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
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..927a525c1121
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,319 @@
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
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
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
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct pcc_extended_header pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	size = pcc_mbox_query_bytes_available(inbox->chan);
+	if (size == 0)
+		return;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_extended_header *pcc_header;
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
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+
+	if (rc < 0) {
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+	int len_sent;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	len_sent = pcc_mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		pr_info("packet dropped");
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	outbox = container_of(c, struct mctp_pcc_mailbox, client);
+	if (skb)
+		dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
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
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox;
+	int mctp_pcc_mtu;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	mctp_pcc_mtu = pcc_mbox_buffer_size(outbox->index);
+	if (mctp_pcc_mtu == -1)
+		return -1;
+
+	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct pcc_extended_header);
+	mctp_pcc_ndev = netdev_priv(ndev);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
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
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	rc = initialize_MTU(ndev);
+	if (rc)
+		goto free_netdev;
+
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


