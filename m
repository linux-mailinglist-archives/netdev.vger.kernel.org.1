Return-Path: <netdev+bounces-212501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FBB210C1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593FD3AFE62
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378B2E92A3;
	Mon, 11 Aug 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aeWah+Cn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8D2E2F00;
	Mon, 11 Aug 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926701; cv=fail; b=fyBzs+1GiAic9It+1EYSELQrm4C4HuNQcfUYSITyarDqcxeaSHk1x41y58CVZpbFcoqG5uwFzRQv1NSGEt+ZG3ulF+vL3vWlMhFUNaj23EMxnucOT570Ez7bUjluWh4mTcQZJSjkzyuatVyRxBnyEmmvYo5Uco68BVvlK801P68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926701; c=relaxed/simple;
	bh=FTxMYU2yLVqjLKsPZMFOI4pBc/u6dxw5wz4gUmQ4XuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUNGSn1abkejK1rpWPO1TuZugBG6qldFlR3xwQZoWc7iS4lbPGgTIEWbnfiK59meAH1p3K18czCUf+Vl5h44kdGDdG0ekksDVV9gS0Z+SsKXkuK0K22wGejHniZRHvH40BcdLX6cc/otlY8X2yBlkjQy7bg20RABcdfqYS5he1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aeWah+Cn; arc=fail smtp.client-ip=40.107.220.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5eEsl3CMEf4iFYF02HgqhkkNazzKmqUPm9K4zy83I2iqM8E8rN+fQUw3Jb7ieeU3rS+MIF6EaxrFJ0sd/DzojOifjEBOLQgfeU7soipZsrTn5Nhx003XoIQiC4nrdXRCopq7mOW5P2OzkyjkH0TE8rkSHnAkPYBn4ago7BTH3MIWkFCMWPbRIz0eGQJB9nBXFpLCUtkV4wIWBJ2/q4LWSwy7v6xHdEJSbUQcjzTLfu4bTXDF2Qaz9sYjwhiFQbG2ZkMb4M4Ye1RblrZjvgDzH5M6hMvstCpTjndDDdMFvAeDSP7ULf8zfDqK16yvI2gCBQl9IdFY5jWYUFUBgJJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbL0m/vrzFJZvW/Tab7tysdjWpL22pLmUQ7D2owmkLo=;
 b=ZAHxg1unW8wb0iSxbnDktb0SQnJIUBn6Vhzd+mOzsxeFxqbpfp5GEvotXcVLjqXZ7X+lCDCUDczaRgaiGgtg5sx++BCTYFwqOg/UZoYh2ez/TB/my+omzytzhCIP/zYQYyXt/qfjD8w2TWqYw59aFlEkE8cwkjjDHJiDwKrXo84JSsLPpVKWznLbiOUTL9H+m5EXP/aJepZ3SxPL/Q9zjwrHylXHVptE76dhhZzPMs+guM0pgszA3ytQvimdegdWewelLYwm9kkeklukeRT5dXIkk3MdU6K2r5VNPvleEanDiOp5ItUkREhmnBGPzp6l9JK1S8py5ihZfN+RLJlrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbL0m/vrzFJZvW/Tab7tysdjWpL22pLmUQ7D2owmkLo=;
 b=aeWah+CnNSBo90HNtIh3zTsCaJOp4LN65Ld8ef4O1ED/U/mOMcUpwuD55+eAZlGa3sVuTW9+UGQcVXIhX7BO/XBnjP99QLI8OzGxKQu4Hq4qLqxUwPQceyD5Y3E8/7rzCMLeFtdCoBItN2qWVjfnOoaGGWOxoV5NtHy6F+g+BGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7474.prod.exchangelabs.com (2603:10b6:510:f1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 15:38:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 15:38:17 +0000
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
Subject: [PATCH v24 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Mon, 11 Aug 2025 11:38:02 -0400
Message-ID: <20250811153804.96850-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
References: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 177f6b04-9835-4797-a3ba-08ddd8ed1775
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvYuv+rpsiKuFoZ4p/ii+eP7i/XT33gmqDG81ODioA4AHiLeeYhgvke48umY?=
 =?us-ascii?Q?5lVXvCklqvVhJe47FguW3qJW9MKsNZ7v6vkiVJr4/jD1EMRW/jb8o6SMqqmu?=
 =?us-ascii?Q?5jzTFWERQuUCg9KPCCzcqgU0DjbB8kjHCTy/vgXJgOZO1vom3FZYpEMbI21K?=
 =?us-ascii?Q?BShu+u68pqm/3KZhoSyVzlD+QHUDSOb1JRUrR/7rs3Qk7+Ewlxkz+I3nkT6d?=
 =?us-ascii?Q?7oW7fGaqjRUiRAL2xVMjr8MTXzpGf15sHYsrj6/cMBoLq9q6o5+pAeblB8aP?=
 =?us-ascii?Q?tG5gWFk3hggAxelqC2pWzfepL0gtb5SR2kNGcNrp5LQL6KRzT6bs5enDqIVO?=
 =?us-ascii?Q?6Ey+eXNPhNDPtlY1S87uk2y34wCWu8Ii7QjAxsic5gTYpdh/iMRNvxox2Vg+?=
 =?us-ascii?Q?6yxjb6MFYW+1zAXBwp96/3BOdZqcyNTceVtepSjAZrqxkFiwdI5HRauATm21?=
 =?us-ascii?Q?evd6qmZPusYVsgxrGwZYlQXdJvmIdHLk2Q7O+BVaOVQy1VFIf9m7h1bNvsRe?=
 =?us-ascii?Q?gsvZH1EIBhP8FeRbq/9Yc2yL25T5y9J4z5Goosox6UG7XbAVebmp/lbXsb+n?=
 =?us-ascii?Q?Mnrpg+W9WSfwnNJ8eqTJbXra8JVmzzjG5dX3b8oCanB5hrTh25S12yXrCG9+?=
 =?us-ascii?Q?z1v4RaEmy038FyUKcJsIrAEKEBCWSzPc4vcO/QhJThEHRK5BvCPOFwnV5ESr?=
 =?us-ascii?Q?+2DIh3Gpolf3QCN0WQTU+Vzrnx0ByRzFAesCE9Cu5SlQetKNjn54tMksZGId?=
 =?us-ascii?Q?3jrzWxzqb4TWHAiTImXfCM93D++RnVqEixgTeT/Wc6LNOTcJWIP8WVjHVG/k?=
 =?us-ascii?Q?SOOrgmFpyXYmHAsAogaqIP4Nv1MQEOnTL5kczgi+IsK0c5SEGq9rD5ZG8Hni?=
 =?us-ascii?Q?9tIeJRQdGU2r1cht5xp8NvMGCDm6Lm3K18eVjX3oo/vODLu9r3LvdsDdsc9D?=
 =?us-ascii?Q?hGA5KnM8hf5yVrPxU+sO+pmrKBl0v5O4Yo7DH48k4UGTuBo6vljmyBTPMnJ3?=
 =?us-ascii?Q?nZm58PpiFJ3MLe13su9pL/AOE84H89yz1KVFbCz26nbOwiYHivFm654F1+ps?=
 =?us-ascii?Q?0OzZXtZ/JLlC/Wh6etmcAlpnG6UwuU4YHVYI2PsAfnbOCQYct4IUkp5gNVoc?=
 =?us-ascii?Q?106hwIvjFpHU1TXxo8Jub7s9M++D/xhmxTn9ChRzZzGGCKWeISKMfIZwqqq4?=
 =?us-ascii?Q?KiXO5g77mB3kh1H/k+7FWU9xriVFkxDvSP/TAXjj7Uoud85gHelxeEuJUqh+?=
 =?us-ascii?Q?dur+pSPhv9vx61WlVtRhFK6mPO9d8gEp9jkPHPPRh4VgKCA3hbyLq/OkaR8e?=
 =?us-ascii?Q?w+Nw3R/QpDvhgxPj1+LBJfBcgU/hwOrBYPthy8zyXiKWTh4K/W8OFx7O5ZzR?=
 =?us-ascii?Q?rBZbrfM4PknOteIBTEOlKhTo4CYbNh9ItGCPUxmHdoCvvnl+IGrrV7diuxAY?=
 =?us-ascii?Q?EOY9UKczflw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzlZjch7ypQxuwIMptJfW2mS6R9fhixsFm7iLSrhFWX4ZQSzVOx8LNiWXKhR?=
 =?us-ascii?Q?IbDcjLUDpvF49gpjuUFUHLaKTmSEZuN81zOpdij0CdqrGvPcIj0pYuWRWp4+?=
 =?us-ascii?Q?jFNRVvKnf4lEnuHuiTtWhj1Udx0UI4uLLh2/KxXeZ18Fm99DejplW1zgQO7H?=
 =?us-ascii?Q?BikdWmZE4zKao9/vervqGs7p6myZU0RMNffwY6cXiWjnUzonMO4v3V9da/Yw?=
 =?us-ascii?Q?3GbOwWq8zEnlzvlS6H2qEmjmcAIvhu921mUzBO1egmiU+I0ZyZxOj01DNb0J?=
 =?us-ascii?Q?qTLmaKhvtkXYgms5WKJuO6cW0+BOAr6uFhg7j3eNwfJ8O3hh6zd52jxGvXQq?=
 =?us-ascii?Q?Bu5hHAwx7RcgwQqapRDAlpp6+c5kijbwMNZUWix9wHC3S7VBNjq7M+3MFFgL?=
 =?us-ascii?Q?ruIc9LO9kiNGNS2srg1hVzPWVgSLUpwYlosglUo75Gd0RDHZVOMEklz4A9Qe?=
 =?us-ascii?Q?BqdI4xLi+hFjsZXBj69zoB75ItkjwsKkmr8SDmCMlrtA2nh76L9PQboS/VPE?=
 =?us-ascii?Q?KAHiwZ1ayV3D7uJqKX1ucR/3e7QSDECEt17GlXwWwRYlwRPjE4oRN0//gwLT?=
 =?us-ascii?Q?u6L+UZOZAD8jm+rOBpazuIsV1Qx8esYb99A2iJrSijKKc/0h9tYQ7Bpmqrfd?=
 =?us-ascii?Q?uLCeHyE1CBr6Jf3iAZxEBjVbia7lFzDEvtPCtAG5WmDGrqTRbgYUalf89fVf?=
 =?us-ascii?Q?SVzsicwblxnKRiVrTnrTfRT53cUydQDvrA/SVte9xfG5jUUTBcW4yNtSyiUY?=
 =?us-ascii?Q?62HKTcJa7O6V7F0kL0EYYjoBonF3WQrPhFkVT+6Ekii+QzbRME8og4zi3euw?=
 =?us-ascii?Q?Eloaf4GmmWf51Rp6GxHDyXklcnG368Z8JQnOqNmIKoqffLhL46X7197pFgrV?=
 =?us-ascii?Q?JhkUYwtBO1wRFuNlEXbh9gfj8SzmtvRRReJyHOOW/ApqkVpEVQhtefzlf5wl?=
 =?us-ascii?Q?7XPY87yHIdJ24O3UkOkGGXg8m2JuheN7Z72/hbG57RNoMh+Lgl4nzoioPgwy?=
 =?us-ascii?Q?P4jBVF07cd2JAfMW9HF4Tl7klDXiFb2obLQFo/PbRd6bVgmZpxV31yzrES0e?=
 =?us-ascii?Q?X5BHQHnjTBA3y7kmGwyogUj5xapzy/csDGbf8At1w4LePqVEFg08yARcKmyn?=
 =?us-ascii?Q?HiIyDknwjzl1iZIHHIIYBnrYWzMFfMY0nsVER3gtQlxlfZhipHuLsqZcipti?=
 =?us-ascii?Q?RAofbyb7fi1/U3CJMv1MWw3OfXvzOoYLb8wKRzp2NUdZc8JrlgSHk7RBHzsL?=
 =?us-ascii?Q?5RggEGNGMBN9mrqpPdS+sO2N54u2jvrh6uyEYcfYG6XiOKkG2Y5MuPxX0G9h?=
 =?us-ascii?Q?SEhMZcBrh2DHaJbluFoYP2xDDnohPh2Ud5PrGcruhASiFfIxqQZhWWPSi618?=
 =?us-ascii?Q?y4o7rvh7mIx7wqi4J2a54dOHoDgZ9Y3o/tEw5Zxbz4bgRiJcSnt+VHhqznSL?=
 =?us-ascii?Q?7VyuUbUt5wreLsIueUj6jdvJFLoqbyevT8f8ArpSJkYw8wnkAyXtPo8QJvK7?=
 =?us-ascii?Q?sUQjkRKTat14SK7X/glmX6TbUrFckb26KETprOlujwCAvKX07hpPj2/pYyJb?=
 =?us-ascii?Q?JzCae8ffbIgZG3BKbgFsfA05c9DA1S/LNpqzepdaGMAiF9Rq/9+Y2GNwWGgc?=
 =?us-ascii?Q?zf0X/BRm5Px5FbIC/Pq+N8LXllK0F/mZw02wE7yXfVhK61MBjy8asdm4BWwo?=
 =?us-ascii?Q?Q3nfkpNTe3mAE7NsmLn91zwKYxE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177f6b04-9835-4797-a3ba-08ddd8ed1775
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:38:17.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LwXj7pW+MCyaqQz+R347nubCdDu5Qe5QigpIdkgwHfa7BVxqfYeEBI4bVSAOQalp8J6zHiQIJtVsXz8Xr9t6P7GekRESsAMDwTDgufWdGqDYA5V4df6mzEPGCpKV905
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7474

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
with the original sk_buffs.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 348 ++++++++++++++++++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..71c5d017c15e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14661,6 +14661,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..27af2838da37
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,348 @@
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
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
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
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops,
+				  MCTP_PHYS_BINDING_PCC);
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


