Return-Path: <netdev+bounces-206914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1AB04CAC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FD44A7BEB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB010FD;
	Tue, 15 Jul 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s/86gcw8"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023106.outbound.protection.outlook.com [40.107.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540910E3;
	Tue, 15 Jul 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538223; cv=fail; b=ZXwNIOf8qA40dyG+3FF+RVseCOGQEHUHhKZyIS4FbnVbVzrJSip4klp3cXADL25DPtfOYYXKNPVvv/P5kL1GuprXPaHjaunOajfRdPf6UPVwDepl/LJ7THZYRbw1Sw9pO3VgDiWCx+45C8RLHKKp/ludyNbr2mNM78a8kW2IBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538223; c=relaxed/simple;
	bh=SdTauXyFl4rOwPzlhKkGgMSuF+V66Kg3jL15lSsVdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CbLWnDZS9XoqeAlBOLFv0kCKxwyOyshrBk2p5Oy4QaiYVD0tjiFKQCl8Bk8/SHgC+4DhnS+CA+l/unOBMHBUQsr0jif6AmOkwZm9bse6Y01pFFh26L64TW+8Y6u8payMnLiLolLl18AdondyVDv96Li3bAUPsFF5VQg9+pZYZuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s/86gcw8; arc=fail smtp.client-ip=40.107.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGedorybhSeJzGB3M8m+ZztYNBsYkZ3uQQadU2/5I1c/WmDg7IKMDZX1PYkQJZE2dUvahG+AfpEiGx0YwV4S/OrR2ed2rkt8NQjC8oQG0YzQcIJp7XMqQlPT4ifIsgPlRHOkKh0lc0biq4pS+bVfSe3cSs2FCDWH0wo2gBe05UVpxYgu/xBhebtgsqlDRWnnxpw2PbwwPkzJbRvlmwcZ/dVKr9Nz6NZKAYgQ35/f/ClaBQIr/7vAap/XP4/XyypkGkhJZwZ6L0lg1+PS8zjUhC/vqQL2QS8FC14NvtNMK4Ao3h/5/YZZfUVE9WxFs0k2uu8+AI3c5F/+ZHtXhyUtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M7qT1Mi4yd1lg3qWsc1BFvgftx7GnGcGOENzWv0J7s=;
 b=DVZbeI5L5aVX/2kCB2SPiHapW/LSHGj5Gk78n3zCCvMUzm4tRm6Y6DZpSdl4K3X+RQ7SLHx9e31RuH4VLXslI0MbmpywyF64/kGgURYxKIxhmSrHZwEwv7mtgORPGbB+uwklRFZW4+Ey7QNwVWPDKIkroegEjn1cspeBLjteUQ9DRHjYHjX7MhlwAj4x8zn44jYNzqrO/rdiJCbPtvikfQqyO/aLr+ldLlpVxlmZxkd60/gKb8Bf4AWbBRG1PPfzlM0ckgzNTllNdbnWfzWQa6w/dBFx2g7OBrqnpMHobzijVWF8gXGmE7WfeUBWFtaKDm5eGPXZsXH56FyN+uiCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M7qT1Mi4yd1lg3qWsc1BFvgftx7GnGcGOENzWv0J7s=;
 b=s/86gcw8+1Y+Q3+z/wPT19U61r15g8SWE8iWMP7bY8wrk/A8CTc+HBe8QlFfUlII1TCzofLzWdxyF5MDS3q5TRmjILDTOOwVJBFjdnMqAojICDicsZZPT6Xytn1wwHPdIozxO/B/a7F4/rwFOzGef5UEAvLefvXL2oVRYP11Lr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6239.prod.exchangelabs.com (2603:10b6:a03:29d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 00:10:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 00:10:17 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v23 0/2] MCTP Over PCC Transport
Date: Mon, 14 Jul 2025 20:10:06 -0400
Message-ID: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9cf90b-357d-449d-bee5-08ddc333fa9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mX8hWltwznu0nnpt42dNav+yJTuX9JnzSS0LCAwuj3BFSlpbmg23hLs643W?=
 =?us-ascii?Q?S/6MK/BbidXJ1b7E2pb/B2NL8aGZhaVOOxaxt8YJAKmkKchkDgsnTnQHpdq3?=
 =?us-ascii?Q?0A8U4ZqpOinGCQ0n4cSQY24eKtzBz8YONk5/IT3OLYuLZ7KItX5d/TTu9go6?=
 =?us-ascii?Q?jsKGy/RYFJeIof+BqKZCjxLP+C8PIj6ERoKosKn0GXe+etUWOAUwp1fRNN92?=
 =?us-ascii?Q?hTND3kVFLUKPOEmm1auC2fdLtU5Z4Krt8Gian93nkZdXt/ZA+4BQ5/MDMSOJ?=
 =?us-ascii?Q?anH5OAw7LvZGq/gBjFHoTZS71Que7IQVpHh6Ceqn0/ygEKJDOSOlKBgrxWGp?=
 =?us-ascii?Q?Seqe18xzX9OKDJKRyttxruSskO7S2EdNLfpuhH0J3pdxL2iGn81FMt/Gp4ch?=
 =?us-ascii?Q?IHRt4ovgP/Itqa+VZ80ooGhVa30h+QpG3dKFoZzkBw9m+SyAftFd7UocP8D+?=
 =?us-ascii?Q?ZDRJ/LEGdTpH/N5Bt0Q8jpQiQ5helkdW+91n42O+m2TfJN6fhV3OGxACnn3J?=
 =?us-ascii?Q?qHs21In7dPG+68SUl660sB4E5dg26zcR+3oK7cWkkZdJnyNumVcz/Ukllvs/?=
 =?us-ascii?Q?lGI7jLNsGeHN6EKl9P6Shpc0R5uC0m82sBApI2pHCEguYchydxGxWY9Ndfsw?=
 =?us-ascii?Q?fBs4bbDNLvc0f/4Hf8zwcn/mWSOsjrX9friDI80uFz3rUy37li47FyXGTRTZ?=
 =?us-ascii?Q?vsweUk2GdNM8JipYYguGst6GMJ4ISSRpyh3B1y/bt9w+b4qiHR7jVwyLHoFI?=
 =?us-ascii?Q?kfeUqyJCmi7y4xSxS3HamrEz63lJqfP55djHAnDj9AFEN/xNgkX9RRvRe+ct?=
 =?us-ascii?Q?JBOMXdydwC7ziyRo1KP3AnSMulIrJmnyTxfYWU1MAZqNoWHVq089TCMMDXAd?=
 =?us-ascii?Q?n9krejN45VAMh/hKGNr+leMQXmd2kKFfedN9y7heqVo+Gl94CuElqu8J1Jrc?=
 =?us-ascii?Q?Ku1NDH7Ng+5G57TIUW/f5GnbYUE85ngwhcCI+3ZO9YG9/FaWcs0masfwdQuO?=
 =?us-ascii?Q?BPziiqha2lLCGcwhZvEjkE9rbCbPfR8zflvt2h3SKcYhrNWgoUn5FsIwL+WD?=
 =?us-ascii?Q?kW83czSti2HAgYvIMa08uqONY+dnek/PxLIEfp8n9GGSExMyH07CxfVa/48G?=
 =?us-ascii?Q?UPaVZap65G1AeBemn7th99vdS/ufGI2nGsYWmvvAGlB2ZuW3tsBJIa2JfK9+?=
 =?us-ascii?Q?WBZ8yQLo/0EBbKIDIEvAU6xMUcnlV14qk59hfGcdasNbVHztPKAaF8d2qNBw?=
 =?us-ascii?Q?a9VlUqSjNziZry2KIaupCxBgQ6kMay7c/wyzdLbAf2SpKaUwlHn0B3E2gyRN?=
 =?us-ascii?Q?SRFLLgPFlUNxE2Q39Y6isVIP3lQzPPg4te80epqbQnqSkWla4Gn/6DIsryLq?=
 =?us-ascii?Q?7jhFxP4cui+JggpAAfvRKMIwGfc48GDOq/Cpw4vJ4rQr3c7+Upp9kUCfMoxA?=
 =?us-ascii?Q?tsn5NUJRvI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBhJgfbrNY5hdCOBHaUZ1+EOFoSA7HY7hKzkhreb5VRaNvth6DAIcvtHQWdl?=
 =?us-ascii?Q?B3lmjG5rjzVvh4yCsA6b+T7u8ctThRSEoma9FPGBmUEAYTtxtfJsCDs1kLlj?=
 =?us-ascii?Q?H649F3XgRN+GkJTzcLARJVf/mN9nRtS7vw4D3BwhgUfdmTKybbtXXJfDHrqa?=
 =?us-ascii?Q?9OdjHu4I8U+fNcwnk6e5UHrcTLqKeN0FaauK5iyzlPplUzbBJV25149EFVwM?=
 =?us-ascii?Q?omCoRRcRuOkDhG6w1nX40eTxXp8GkVuKTqPvVVGWfXnQAN+RgiK9WN/Jl6KX?=
 =?us-ascii?Q?yrtQElNKwzDXFZGikEUZyg6Os3GnyxRYlPda1MAjNO9duJAvZfR4uzeCF3T7?=
 =?us-ascii?Q?Ugu7sRE+AZyyaXDdTnYg43a1OnGfqp6GOmQg2snz87SB0QIbppLnlwB2oqYM?=
 =?us-ascii?Q?gN8VkOWSU1xXnlETwixqTZMICUZchxbPfwuwJOeIdG6asJmHEB0fWlU80IUY?=
 =?us-ascii?Q?e2pgEIm/sQFS68K6FL1EvNx5WbuZvsdlyNcBL8RUGrSzmDdRK7btwyptRVXX?=
 =?us-ascii?Q?5/2ADHKhgwRxwEtGQ4ni/p29iy/J7CDhGB3aUl6nAk9UH/I12PV5ysCof7KX?=
 =?us-ascii?Q?yu1fzd3Ixscgb4Ir37MpQSxTkUXdNb1LxQegTlzNtgb2B5uYVbaRs4mGyRxO?=
 =?us-ascii?Q?8bXHLvzKXlW/hqeuL/scWU7MkBvavCbP9viGeDNl+9Fug+jnzqM0jPxvfhai?=
 =?us-ascii?Q?+tvowvjcOxCQXIMk/P7v7hsv51YQT2w/yJlAgL9toYooejM7xAZuu4hVJc+K?=
 =?us-ascii?Q?ST/MI2kBz4Up/SF7Jff4u2ogh23iTRjCg7qlobb3dxgrYzlA/rrGCnA72xUN?=
 =?us-ascii?Q?9DsKuTl52vk9Bs1NVfJYRi3odfjeco0v1AI+lsoAMim1I6WA/LNw9dRcnPa3?=
 =?us-ascii?Q?nXfF6ueQi8EqMXcSVTa6siA8HzDiF2yPeNjChE/cHmFoXQgKZYuRPmyOqync?=
 =?us-ascii?Q?V5Iv7WU5FkAh7uaInQtyQtyFsdJaICzXqpiRbP7pJ+FS5mKxFAeyWHPA4ppQ?=
 =?us-ascii?Q?oSL1WFW4lG7U/Gzpk8Bom4HkA0V8KT0Q8R1iw9F5i1UZvTXm1XSbSeU5He48?=
 =?us-ascii?Q?IJjhzPv/zR68YHaio1Yfckw6Nz3Y84pglGj7ZhVTZRYYCIp+Y4/fQtT15Vda?=
 =?us-ascii?Q?z/pqF3gFQJGBdfrIBVlaAB0TrS6a7roSv8z2n9eDKO7lUjmLoOGpHwTPJgsL?=
 =?us-ascii?Q?ZgyfxoRj7fAh5BgD+7DcY4Vh4jpWRkBo+DNlvS+KehRD5cJB6JzBlgmwh2/u?=
 =?us-ascii?Q?w/NpzB8MkUKMMf5kJc3rWGVHYIhFUsjnBt4f4uH3G1vsnogUuvMS5B/AJ/6m?=
 =?us-ascii?Q?WykurB9W3eUdqNQqAUvd9+AfQBd0Fk7DmtC+Gx53RIdaIlTvv63mNF7A74U7?=
 =?us-ascii?Q?SpEaf1Go79rE2MfvoZh4VsDCotNW5jSZfP2kiQb8gzo9uArGL1c4H8HyZ0B2?=
 =?us-ascii?Q?Z9iWaoxFhJor3asnd6lv9OcvdGCj7HUo7v2K9y7lDcbGijkUheRRw3whg4DY?=
 =?us-ascii?Q?m8U4LUCqX3xcjbeuSrm3HAYKNrhgvn8VcMrpOgcNX6MhswyJey5bImQbqnGF?=
 =?us-ascii?Q?F3at7V6CPayS4/U3Y3Y4ekEHRIJxnbtzvTAMTVhvFwk/3EqrCPbv+aua8Z0d?=
 =?us-ascii?Q?kUQ+7W9vV/3+TAa/7YbAWfm3JQyzpqAjK3gMHuHPHGUHLOIuXEUanToVsBTd?=
 =?us-ascii?Q?c5L8e57VeiCUF3CKTDsLwqPoAZQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9cf90b-357d-449d-bee5-08ddc333fa9b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 00:10:17.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ooBrGi/oAYeeSzKI+vUL4REal4m09LAqx140Aik+sP/n7vkLJNnE4LpUEr/VAltrU4/364d2I+xcBJyTi5hZwyULehfNR2P5WgHaDXGlpYes5CX1ghwPKoj4k2IjzS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6239

From: Linux Bot <linuxbot@amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and corresponding channels are specified via ACPI.

The first patch in the series implements a mechanism to allow the driver
to indicate whether an ACK should be sent back to the caller
after processing the interrupt.  This is an optional feature in
the PCC code, but has been made explicitly required in another driver.
The implementation here maintains the backwards compatibility of that
driver.

MCTP is a general purpose  protocol so  it would  be impossible to enumerate
all the use cases, but some of the ones that are most topical are attestation
and RAS support.  There are a handful of protocols built on top of MCTP, to
include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session establishment.

PLDM is more likely to be used  for hardware support: temperature, voltage, or
fan sensor control.

At least two companies have devices that can make use of the mechanism. One is
Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of the
ACPI spec: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has  the ability
to ignore an MCTP link that they do not want to enable.  This link would be visible
to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations that the
Spec calls registers.  This mechanism exists regardless of the existence of the
driver. Thus, if the user has the ability to map these  physical location to
virtual locations, they have the ability to drive the hardware.  Thus, there
is a security aspect to this mechanism that extends beyond the responsibilities
of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device will never
be enabled.  Thus it is only an issue on hard that does support PCC.  In that case,
it is up to the remote controller to sanitize communication; MCTP will be exposed
as a socket interface, and userland can send any crafted packet it wants.  It would
thus also be incumbent on the hardware manufacturer to allow the end user to disable
MCTP over PCC communication if they did not want to expose it.

Previous implementations of the pcc version of the mailbox protocol assumed the
driver was directly managing the shared memory region.  This lead to duplicated
code and missed stpes of the PCC protocol. The first patch in this series makes
it possible for mailbox/pcc to manage the writing of the buffer prior to sending
messages.  It also fixes the notification of message transmission completion.

Previous Version:
https://lore.kernel.org/lkml/20250710191209.737167-1-admiyo@os.amperecomputing.com/

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Adam Young (2):
  mailbox/pcc: support mailbox management of the shared buffer
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       | 102 ++++++++++-
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 347 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |  29 +++
 6 files changed, 493 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


