Return-Path: <netdev+bounces-217600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8FB3929C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5997A6CED
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1326561D;
	Thu, 28 Aug 2025 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jkKr+jdn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2103.outbound.protection.outlook.com [40.107.102.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B0264F96;
	Thu, 28 Aug 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355628; cv=fail; b=uabFfEu0hkxdYUv2sAV7xHU5KeqA4IJYiQ906slrBVtFY2AC4gFx8cBRYfpKJFvKlHpuhjmpfXKJoXs4TFKA0nKgsWbQSG/Y2P+VNZkn1Qwga8K3LHofnobf9e+5xLDQNgK/9U3eFdQGclThhWqiqdW+jq+zOfSjMPZmwOyLnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355628; c=relaxed/simple;
	bh=LEw8a3DK58zFCPbUaDFINMqkasSGyWTk7+z6hawVbw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiER79bKzX9CcM2qZMx151mGIyAO5WtzzLHkM6Hd8/L29/vG84UW61WoU2sbrhXwsSC4wGKEIfLAGEyADEVrHtmXLbZzxgpKLbTkgdmjWQK9dBQuVmyovAX7YSkTzeLAH9vsDAiYAQwDQiRcD7DpmQhgJqX/jbgMS10Qpfj3So8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jkKr+jdn; arc=fail smtp.client-ip=40.107.102.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOVu064z70myab+7uAKSYJeXrebu6dajmZ0bZFQ9KP3LVnc3JBlF/+CZH5bXH4/JYM4Xpm7u2BLFIbfIDs6cGAkuQm3yNPJ28eAogWuenxXSoce8A3D3OmIhaH4P1GDQP1KP70sc7dUN1ygcTyPaBOWGm2TxNZYHL0rDjUYEYeAIYc/mu24yoeQpgcHKPcpJs2OOrhZNjSJXajPeOFH6YH4CFPfQQxhWcU530STEWoe6aMB/9o3ZXreXv2cswvVzGxzKKPj+8vfZsKgGiLyIpjFK7wOhzT92JQvyX/aNJPDQJuUlDyRjUeUKmt6GBklZfP80EfndFx3nA8uzS8tk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi3f740VZLaZgrq5tiFA5aJgfuglcRchast1ZjfxJ58=;
 b=MEwz8+BOBCA2NJ7xE/dL55vA68RExwbEl3jeRD82Cit4u3k46x0EvOxBY33E71K6Cc7lkUTz9noyeWcivQ53qiAfQCSyR11Rn0Wyzfw2PVMjm5WEZpTTQXu9yzbLk9/d2o8IOWiQsnMOZHEC7J9Y4hrxuo2Kk7rsz29yI+OFGjhN/ujDoY3LZWyF/ibFZh3aaES+d3AyQ4qAbmMCY5didxYK3EkF2ilugq7z7qLpsuaTGGTmX4q0P6fWGJZBDxbFHlqChc+WZEaf5XVTQsvwTP2kemca3CrJZLBTUZJDduSfnD/7I1vUDIWMaFmyA+XxTMi2XQ8fm8bL+ohzMs2CIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi3f740VZLaZgrq5tiFA5aJgfuglcRchast1ZjfxJ58=;
 b=jkKr+jdngyqD8FeegDi5CHqaWJ/FW8+RHu3Y+BfNjstnbBc9EnZ6pExr+InPEGgsRIyOmwhEsITaBIeY5RLzv4QPFIqUxxdocWpiCuODw7KddQ1pkaVTFWfNEP0PA+SrIfOmKA073hfb3XqN5Kc7t+WEr0VZohgKsKV/hWf/ld4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6263.prod.exchangelabs.com (2603:10b6:510:13::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Thu, 28 Aug 2025 04:33:42 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 04:33:42 +0000
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
Subject: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 28 Aug 2025 00:33:29 -0400
Message-ID: <20250828043331.247636-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: e16a3325-54c5-4428-91c0-08dde5ec1174
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsODyBv3KS02QIMZNyvSFhqYAjB2klEXPtHIAQtE89XByz3FNJ2KgqcAKk9A?=
 =?us-ascii?Q?g2PIa57LrjFtaiFOWk4K8NaLMxCIrszIJLsht5LSg5OBbS8r/pmISCpVq4HE?=
 =?us-ascii?Q?EEwgk7UCU8MCJPRHAWII3ujf1X5+CPJAcYpzEoREL5aGcelZbtlV7gd6s5So?=
 =?us-ascii?Q?jiU52L5VcVHXsCoD0CPEEexIetpQJ9orhFG1OyEmYlJBRaS/23MScIYntGLu?=
 =?us-ascii?Q?XmvAYkka/laD3+eKMqglODsTSA2JqXWZ+T9fQFsKM0fkBCso+lqvpywqiP10?=
 =?us-ascii?Q?B7/qu3tV+C+0ZtaLeupccf3w+8QqhK47aC9sP8BBDGpBI1h7Oux0UYDlWH28?=
 =?us-ascii?Q?SPmpwQ6fpS20+YjWlfIrJ7JPn+Zgz3nPbsQM7GiLqOfKqFx8pFT4ozANNmqP?=
 =?us-ascii?Q?aaXaKihaet/F57VGGD8qx6IWX6+zBrBdKuHYEwDtED2WeLvonrh7dtm5rQxD?=
 =?us-ascii?Q?kqonZc8RkpeHWELPTDGlyv9G4z332OYicEig6D/6HWgIUtDnlBbzQNHSC2Au?=
 =?us-ascii?Q?5kSHHck+53/0i4TvsKZIH1jwiEEOh2fuO0ZdpEUnvRjkPxqpNrGS+WjegRob?=
 =?us-ascii?Q?H6xn2zsoEyoDY6Ug3wi17nDax1kYW2Cgak6Q0twk27CwKriKiKNXAvp4uIpz?=
 =?us-ascii?Q?3vkD0QAUJCDwGqSmhAu29f/ekZ7fbdOpWrtP13GAYArFLjPenufWEMsJ/IrG?=
 =?us-ascii?Q?laprDjtodI1mpi2ymfD8NkAipNSmiflKQsvPl0yKVujhhRbOa8xsPihpPbEr?=
 =?us-ascii?Q?3AXxz3DMshYWl+BxPRWfkAZsxOUwMNfWR953sfvqClHYWiNvAjC748h/FZTb?=
 =?us-ascii?Q?/51jItL7rtyg6D0o5+Uy4Whe/6IotqxSxWPmETSTq7nJcKUgoj5ZBqncfrQB?=
 =?us-ascii?Q?nYQE/SpPytSvPf1fiByFd+B/vnj890aPGPUnxEom+M7E5I+UgfJrLeSV8Uh0?=
 =?us-ascii?Q?OGppZs0ZUgH7occlYHzYRFSyCEBFU/adrXf5s91SMCMSTdQB6jMryqFiPizc?=
 =?us-ascii?Q?3pEaOuoAXpkV2g1zmzg5py5avGsJ/Ev5m0VgMZrHz3DwMFn+IejqFr5V/mXU?=
 =?us-ascii?Q?nCU85c+t+sHBNMOYudMFwXTddhuPf16n5etiV2BAJ4kCl83jJJY9Zg/kBVh7?=
 =?us-ascii?Q?L2234kUBu6J1F+4lmvSEHbTRiLgVzcfykjxw8JJzAHX/q8792Fhkb+GdvfLH?=
 =?us-ascii?Q?KSukK7OVetwLc3AmIWG+n51VlA2xykK4I4SfesWB1NVdHCGu93JMMrXNdTLq?=
 =?us-ascii?Q?4jMgR5YbtDQFuqxPtb0iS8Mg7ZTrr2xngGz0swJR3rbCmvgUcJD9e+f0cNx+?=
 =?us-ascii?Q?lP1LVu09sQ0WoIk4iLXNTNBqTFwvzKWCRT2YgY435W1knzHABsCZCcq6Rvad?=
 =?us-ascii?Q?pjabPcOjtKn7XZpjK874PnBlCfo5Hl91byGyyflIlwR/vW7duqtEiMo9o355?=
 =?us-ascii?Q?gVaurv+ss/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAiBwc8Tni/tGXyhZl+Qf/DSjWDDChWTbXCqSMijBpyhbF/iMZ0e2Lqrf57y?=
 =?us-ascii?Q?IU3GQldAXVuHTGtswbNpthaUZpA6jvLI3d8w6g2yZJO+Wphs2s81UlH4AfEl?=
 =?us-ascii?Q?rTZ5oRB4zXwZnTekEjNYItq0cNCIVfurydatWj+nTjcck/PSdlMrqwulwZJI?=
 =?us-ascii?Q?ulThvYCuvcHzUFljUcM4Uj/ztrphhCW+JLVtevgjV5kBYLWK+0+XtJun4Yh0?=
 =?us-ascii?Q?CIQ+h+mkgWOpxQKKexVMHqsGfWHw3hj2EMFrNVEtCCcbQXS/ChDynZceXQC9?=
 =?us-ascii?Q?FlCyK2/AXwq4Cqfk81Iv++ZnS/ICY4iv2W8u1P2VH3APnYjk2zTFbDK+vQ4H?=
 =?us-ascii?Q?5GWF3o23OEzjgE8kMyM7pfq+/dfBLqycpgs2fnN5ZkwP2DxP1hoXp3P7nxAt?=
 =?us-ascii?Q?l4zi89sqHeUpKEKaeQE4+eINGaE/qypeXWZMe8hwjexA7a/SRta3Wm5tll1E?=
 =?us-ascii?Q?HyxpYpqRFx7R/3U22M/wec6/fXUHiqVYNuMYO2exP64DvrIhXU6NCa7Nb9mY?=
 =?us-ascii?Q?GFqx1RVqh3lZt5WMnq+VK0VjsypcyL3AFVDljREnnD2ke1octzwHWEUh4Sir?=
 =?us-ascii?Q?6+posd8he1U5onktivZUG4gwFtLLjsrdU6OWURkLOgKRCYQK5QQsqXrfSJtX?=
 =?us-ascii?Q?QgntJoWFx7GTvqESNXRX2o8Sr/BDiUxgx3Zyvcv4oZiWir/vH+VHn4r6y7fU?=
 =?us-ascii?Q?bOw4TXHI1/mrW3iUJHkUtR2e+s8A8gu1mKdbr/Rlmk4GpWmp1+WetoaQyYAt?=
 =?us-ascii?Q?z1gQ3y6HyMUN+yN17EGh9MocX2fklMliFwXtc+k4PwJ557YsyeJHBv2z2Go7?=
 =?us-ascii?Q?Ccpe1qKmJvGBrM2B1GPlnpneJOhm4uFg+kI89e/8lPg4fzQjPbv+gS6z3ftj?=
 =?us-ascii?Q?9jUcv+3L3T8UGtJIurxWqpWsN9uAZsl3vRjQkk2oO4C26PQEKvtZOFuYs/1m?=
 =?us-ascii?Q?vwJZP6Hj9jBm3wviaj/Nd3wSZ8SirCqkrKvUnyCX1eR7dyIS781KeSXyLZTV?=
 =?us-ascii?Q?dtE63RQTxUrODsgw8IEbF6PcBJubXQ3HJdVW6+ipLpIU9jqu0+5NzODVB/EV?=
 =?us-ascii?Q?Puz8UsDfByHNAtAWHqTX7+fM+/6l0/au4Kbd5JY/OH2o9Gzt2BaOK6fgdT8G?=
 =?us-ascii?Q?OeNVJbNfYt4YNCKymepjPk2kLdyfnlJFxlUEG4yFzs5Sn0IPWxmHHwF9jQVy?=
 =?us-ascii?Q?g/iN/39yUpkqqhn6gmBUb1TzRnMOTda4tws+Na+dU4RPawEmw+cjsWDLF4OJ?=
 =?us-ascii?Q?iZefJGjjk3I1AAk/9h4zk9Mzsj5VTWvweEYnPgO+HHBCKrfmAS8UPI3jz4eU?=
 =?us-ascii?Q?IioyQr26dgd/vGl0DuzB0sgsQawx+rra4NpEXW1h/oQDmXcutDzpJc739Wjz?=
 =?us-ascii?Q?GpmUZmOweMrvo7T/eZ6VWu34JNEsyBiF7SSuOquRuxDk4A9WsChbL09LfZcX?=
 =?us-ascii?Q?NGUCFqNXoIOydCATu/ygg6TCpyYyo1Fm3q5E0ZbDFpXV+Rz3HTOSn7Ovqx7v?=
 =?us-ascii?Q?lMJ6RlYvgxbhBGe/T6/H5Wwe7k4il28QITIkSrzpVTQvHKnTq/lJD09twYK/?=
 =?us-ascii?Q?CdiTOnV10ncOWtOCBfJHzfj1wCp5cqKGevSH+EcPNnFTuDK1kf5hEunJEhqf?=
 =?us-ascii?Q?DZVK7BrSFhloUfnKH9HqhwgAgX0VOEqvDCJIOlsLf9crnTqpQRBNIkdpjVkr?=
 =?us-ascii?Q?rPgse0Ie5QXedyrSP5EEeyTh/fU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a3325-54c5-4428-91c0-08dde5ec1174
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 04:33:42.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfP0FEEGNoP7ck4eMkTU7CRNVhT0rxgQ7jtgXfMwOYrRSUd1wODXzYpwexf6m2aGtVKPUsCg0UVhdesM93KihubtWczNQ9HolEy8r8GdVjv6G77nWI4TMHCNhZe0Utb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6263

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

If the mailbox ring buffer is full, the driver stops the
incoming packet queues until a message has been sent,
freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Adding an interface creates and frees
the channel between the network driver and the mailbox
driver.

Stopping the interface also frees any packets that
are cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 343 ++++++++++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+)
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
index 000000000000..947ac2ed760c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,343 @@
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
+		if (curr_skb->data != buffer)
+			continue;
+		skb = curr_skb;
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
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = NULL;
+	struct sk_buff *curr_skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	outbox = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&outbox->packets.lock);
+	skb_queue_walk(&outbox->packets, curr_skb) {
+		if (curr_skb->data == mssg) {
+			skb = curr_skb;
+			__skb_unlink(skb, &outbox->packets);
+			break;
+		}
+	}
+	spin_unlock(&outbox->packets.lock);
+	if (skb)
+		dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
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
+		netif_stop_queue(ndev);
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
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
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
+	box->client.dev = dev;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
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
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
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
+	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
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
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+
+	/* initialize MTU values */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size
+		- sizeof(struct pcc_header);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
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


