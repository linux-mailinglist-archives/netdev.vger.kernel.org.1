Return-Path: <netdev+bounces-271712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHAoCO87xGmMxgQAu9opvQ
	(envelope-from <netdev+bounces-271712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:47:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86F32B783
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121FC30C07B3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABF3E8664;
	Wed, 25 Mar 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VT4ffp/N"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020129.outbound.protection.outlook.com [40.93.198.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FB3DD507;
	Wed, 25 Mar 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467789; cv=fail; b=eoRbaoCQUny2j3Rq4hjEOUKAmB+E1e+chz/prOdyG56kGbE26Xw6+kLQv0Xq2x4fneeuwa7zZtYeivAlRetgDPAEwwZqReRZ8anAn/O1gc9smdg3dT/hor5CvopfsI/OepZmLBvChdYG0ulxowzkEyOd5OmqS0q6y/N1M1driYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467789; c=relaxed/simple;
	bh=gl/w7prvBR54y0O2BPwQD/nQcU3LRx+DpbLDdfhsZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kXSKR9Aomcp1h262PbReCORaycrNWLW8IqqPJ7cRPsb6S7Eaf5mCwDyw3HnbPDsZFtrnn6Id9zqs5IfEC0UjEbR0951MLKi/5rUGLisDgI7gYshfM0SMKBGBokPckh/AcF6VSglRUUV27EIGQyOR9EgiTY5/7c3QjAFYt+zqDAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VT4ffp/N; arc=fail smtp.client-ip=40.93.198.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+8xKWfqZ3JminrfyeToBrjHomdIeXwzK6fDUx7JI7pQeIH38/+ew2s4ZXjHBWP9ymeLaaDXIlf5D+vxQWNsDMrS2hARMiAXXQFO/cyU0PA9Vb+VNToNzxRoJ30lnQaacm7ygyjBrgJILdzAalYmpR7PoEOb7jvPWE1cLEEZBy4YPiuWXEbRMJEG6V9pFh/JaqYieoKNLu8MqAteunReQSSYtVY/FbYEyDxgj/xbFMejyPUeqMN+61voyrXs2ZKAWqgym8kOxiMCV79846xl2F/bzx/maBturEBE3p0QQeBBaY2vFZ5cTz2DASLemh7DnQoZgxWsrHyBR209b359Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOtyKd4iEw6zpDAddZxdE1M4daQGufy1QEQugcHUe5Q=;
 b=gIzWogKSBzWLYSyL7oXlcxrJ8L0njp+LafBqrzZK85JgSNxA6MLrqDYvd8MJN1KVoXInxmrdLGy3AE5S+P6Jfb6qlx0uHWIVeizHFS0S4xFiMiHc+KJdq+1PnR723SBHDF8xdXheW42fZ+VPyBgx3VdhEVzmZDHtXBBDhZW+4Y9NcvAtEPkr2rr9GjDsctFBWOY7udgq/llDqE8LvPsjtNGUx942FxBXJksftcSFo65pslKI6UVWaasRymkOd+rOlzSYASb+yADWye3hIh5IvOmtbxKbLVs48pC4GH+mkQbBkmLXDpU79G+VkgUgRFP3nbm72Vj0cob9g8DINAm7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOtyKd4iEw6zpDAddZxdE1M4daQGufy1QEQugcHUe5Q=;
 b=VT4ffp/NpeU5E9COyA6ASOY7dThWXm5zFr29fMzAY47xLzUp/mbbI4ngg+sr9U/vznefBgQ+lKxeOc8oWqO5eAKJX+KV9cgjl2Q1tGC23HsMnRWKOtCgrKbUDV6RgiL0JoXrB1k29gVt9RW0M110pjihvAX1smNJlw8qbAG+N1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 19:43:01 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 19:43:01 +0000
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
Subject: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 25 Mar 2026 15:42:54 -0400
Message-ID: <20260325194256.988853-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0219.namprd15.prod.outlook.com
 (2603:10b6:930:88::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: c58d44b4-0da3-485c-c334-08de8aa6b964
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|18002099003|13003099007|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	YcEc0BUklZtPdWWVt8aoKZDDs4qYOb3UkByc7BDUSBcDc5GkThn0NDxVQykRmh6+b3cUb/I8Vy1C3nKYVNtXM5cFUnId3wHSZvmAh4CjHFV5pP06bnxPZIS5FGrxnkAg7ul+rybKWoipkv9c9ebx0Qz6cDdyNeGddqVNKVvWfazvBVkURqeZWZ09L2fetRL+m2iyuw1b+EuXZLoMBfR33QacecYZaF3pMZj04FkGJV8hUAXMwBZR0y01x6yNs9LxSnSbevZsohqqfj0CPm7OiW1jWLAE0ZblFNKnXcwOwf6BuvnuqDsm3TItl4Cx1Fp8mYMDoZwxvQfl2Of7hq1L3cxqI3D47r0ApvHct0gNNKYK9OBn9Bj8wg8BgsjxQlrQgjRyyJwks99t7m1ZiIxkQaSbONoyPWG6/KXB88XsEtSnorirAttDGBPVpsDLWMSQ1zm+qpXs11ZHVDV1ZiI6G4p/sw1EWNII6XjIRZYn659sK8NRS0p/o8Kz/GqcyJ7orTSCevTcwzMq14PuxoEE3mh+t1SxoJm/ahClS5QBiepLvOc7snYP/IyiGzpjvD0FKEgXweEcTVfYDgmKzX7QZV6otai7Zvs2iD/OvXP03gK1JGMvZFIHuZN/MHUTfBN4ToMHrayaC6WuBFjpMJvLSmLnKWutsTNxzyXu8KaIM3tOL1+gAWNT2RrT06Nv9hkB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(18002099003)(13003099007)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NpuWR5pqluzBGCQ0ApbCaULiViHYqKZU3Wvmz88BTv/fxVwCdVszWbKb/sR?=
 =?us-ascii?Q?o9jk/WdfZhZQ7SnjbW3LCotGjZWoOBzsmIeNPgrWGyKiHEdJfRGmIdCKcxul?=
 =?us-ascii?Q?cAVh9tVInqYyfrL3PH5eecJIV9PTP64Vko8kF5I9HDL1+BvgjgLLZPUV+0+t?=
 =?us-ascii?Q?YiH8Ho57urfQ6HkKR/k648mXP+oWnRUTIlD89Ho4rwvquLH29SjO2Pnh/A9P?=
 =?us-ascii?Q?+FT6FccL0DSW2uJ6hzOhn1uCs+lvZ7mMyBIfvyEJxPFeGHFMnq9koIzHdedh?=
 =?us-ascii?Q?icLBY24cJvHXUjNui4qbioLgEUwDcXEhqxxhHXwD5zIhaGf1sumRJ+4Td7Vb?=
 =?us-ascii?Q?kl1kB1V33/9078p42e0C+DMNSHzNbmvwFgIirksdhjpKp/RrSaqvn4aByE5U?=
 =?us-ascii?Q?L0mx95TVX6gI+0qFEz93A1Q2jnwv8JSye/2LqhhlkC76XxtguBK5+NcyRMWU?=
 =?us-ascii?Q?TCRSQ9jTkXgYdD48W8fVo9iz1DSDgrczDYwy48mbubF92qg94e8KJI88v3Cq?=
 =?us-ascii?Q?8nTCEgnACH8cNHYTlf7J3EdpkW26fom4UYhOV7b7KBoPkWUrd9nls7apPEQx?=
 =?us-ascii?Q?49Jhy/SH5wdGb5wY0vBYcO4qv4lHr2qBs3a62vyAyVMvUIKknXmJ1wWRz0oC?=
 =?us-ascii?Q?wYI51luaiVgm2Kx3+vl7tXg66scC58wSvl93iLwHnyPa2igQCnHoJBfU7tjf?=
 =?us-ascii?Q?R755cQS2A+SSQTN0CLLbVtWbE8fnahw50W0OcfYhsFIlqMWHpPDx2CtP6zk6?=
 =?us-ascii?Q?xudUALDUV1/dh54QNNROSWQxMNjGlx2k5nhBE7eYQcraD7W7IVCvXNY7N9nK?=
 =?us-ascii?Q?ketxtmlcCTlawsH0b2P70YgLrkO0z6qPRAvuW9D40/3SwT+DiOH9ztEfxn+6?=
 =?us-ascii?Q?WP2MWIPvPJOcIB6bm1ltdegpB7owc5Vh3VxgXndH9Hhv1KxJjclp5tDsqq2/?=
 =?us-ascii?Q?xwhYNeGx35DLJrbls9u9NhmLxkOfmONrpTCtWddcLXB3Rc1pv16z4sxeL+PM?=
 =?us-ascii?Q?TCOIRltvOq6iqgbksWGr7dPPgmRJy76JCtJZSr+aRhWnL9n57MzjzUqoeEFR?=
 =?us-ascii?Q?1tmX6Tf+vPiTq9ZIIyrU5p03wZIHnu0gdENOunB8WqBEGoDdRhHHtWz8U5wH?=
 =?us-ascii?Q?cy7YHR+F/KuEwE6Euj1ouK3siRdCJM9nqLX3503SA9hOIrmDMh0Erd2ktlrS?=
 =?us-ascii?Q?Xkvb210UdUbc75/Cre0YrQfoquwkqoyvrLWrfjdym4H53iA7Pl/Z4pl8HgzK?=
 =?us-ascii?Q?82KEp67tpJZOJtkh167jf1dPUefqHhKxUmTb0DSrZmjz0Xua69Vsw6J4weRJ?=
 =?us-ascii?Q?gvRfDoe/lHq/XdHpvTiqR2HEhzDT+KnhQ3Y7ZzvQEYySRk9QlupMCBwMcXN6?=
 =?us-ascii?Q?KpSo2Y/mHdarMIIHOcBG0GpYUX1nbm8FuOvnmAzj4gTRJ70xHLoxJGyMXMdI?=
 =?us-ascii?Q?IzoSaNfS1qhEWu6QImEn20UCUms1nYWMfRlvjG9Y6Y/096s1qHhZnTRlJZnS?=
 =?us-ascii?Q?Ee7gSZDu/8JsDqf8o94b0le4/iU92XKJmhq8PBZ1eIcG5UHZ1xKGIYEWv/nG?=
 =?us-ascii?Q?600/O4PjmniUOiZ8Le1pArE/hXKf7fGQAIi8Yjf8XsyTo91lCfBjY712rRSI?=
 =?us-ascii?Q?ROsWOJ7DVwOl1zcGazIYtBK1OkaeH2HUJ/zzFiqEjO/UFZ0s6KuVeHFkiLRG?=
 =?us-ascii?Q?434otTPsrG+6elGSeA1Rqo+Grz8HnYVeBgce0hrqCs9yyH0jloObU03H7ncE?=
 =?us-ascii?Q?sUkKudm2niF71fW06YEwGEd2R7/yPFT/DX2HA3xFIlVH3kS5xlfnq4nAEsit?=
X-MS-Exchange-AntiSpam-MessageData-1:
	zM1RnBWv0jRXPV1eZQQOuY/tCstO7KhakE9sbFtLGGmSXxgLylFqRJdn
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58d44b4-0da3-485c-c334-08de8aa6b964
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:43:01.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU8t7UJOBjH6k2Ekmxu93GNq88Fnpf5Mh9/wkCpuTUDTRz8/5AQBzuxyIB0VLGSSfp1TPiJpsGeoELmvGXcOVxTEjgnzaLp6fNSy6mcCeolwWJdAMEZ4XFeaDeMFyRCe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271712-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,oracle.com:email,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email,uefi.org:url]
X-Rspamd-Queue-Id: 7E86F32B783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are cached in the
mailbox ringbuffer.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. If the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hardware that does
support PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 334 ++++++++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a09bf30a057d..2e57ca4d61b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15286,6 +15286,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..fe08fd041d9c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
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
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	if (pcc_header.length <= 0)  {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem, size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
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
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+	if (rc < 0) {
+		//Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+	dev_consume_skb_any(skb);
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
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
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
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_mtu;
+
+	mctp_pcc_mtu = MCTP_MIN_MTU;
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return -1;
+
+	mctp_pcc_mtu = pchan->shmem_size;
+	pcc_mbox_free_channel(pchan);
+
+	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
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


