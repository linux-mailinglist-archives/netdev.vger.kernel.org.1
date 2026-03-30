Return-Path: <netdev+bounces-273287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/ECG25ymkk/gUAu9opvQ
	(envelope-from <netdev+bounces-273287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:57:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C635F8D9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375F73016911
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E13BED14;
	Mon, 30 Mar 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gaTOaJBa"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A93BA241;
	Mon, 30 Mar 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893305; cv=fail; b=ghfLl/4/oZTDmgxHXOWQNdVsTlRe8MWLkqQNSA+Djl6bsEPWj40Qs4yr0jIfln1cPJNrID2eavn8xHrhrLwyNvofhqaYZvEIkcX1b67U8eztYtEiaHsT6abm5++t2A+S3O0WPk1P85+CtqE+nj7mnUH4H9IdrbitBftKaMzohA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893305; c=relaxed/simple;
	bh=I/glHAPYg2rcnW+apVmupaQMCUXf3s3wJhzagywCWx8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hh/UqXi+gwuqY8xCdnLXjctWDl31Scf2JlNyia4AW3u5EyKdjpWeQfgTNYUbDkJev6S9WDrkLdPZpv2IjYhzpdjno2If6XCEzZthSmHruBq3uxkMUmJ8VEOixxwJeO6Y0BJZ6snYhyqQL/AufO1Yt8pdB9FOL99993BFSSCJGP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gaTOaJBa; arc=fail smtp.client-ip=52.101.85.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5HA/ANcRklD1xH/xfTyrxaonTi1EwSoGAAVnCGuIC2bMZTLWgvuNxqqbSvqHF1VUOkhi6X6rNvNf3aYc9Jakl2foBpxxW/vM/L94BzfOyBCR68Vd+MuPnC8kWWViHV+280YbKWWiFlE+cSMlXFgfwQDGSWyS6v7N7mpwQ/JMNMZ8z3GpArwPYNNQaimS7PGOJIpO2PrmgMT9+O6tibdxHv5jkUxcY0edBrg2LQjhulA+n27Zu9xZgs9vUwggQd0v2Mq84mIkIDFzeRhuWatKeSgVk1ubDHIiIgORyzug1XrLUMIGqqb9ng2K+dIFuOASC9hdqM4722fAGVRwV021w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWazcBHuQ+tgr29lfhh/PZKdUzuByswhf0cZmpYEOjw=;
 b=PA4/xirGWKvaC5s5f1pHjs1Sf28pUzvhOwj/G98j06MkqwTpzEBP0+jlMOOUan1vuDwDm/o/lnVrSTklrvaqAh3yf/30MkglVa3OmtFXPG8iXQAIt6YHMmccMutST0FRAIKQ9RHU5/ND99EhJurywhHoQOpMhzMmAY2HZn93SGAGYEkNpvQD1Rl8T3KuGYhNIuLwlDnsUGKGfvIBVbBQ0Roh49/BeW16lXk8Z52J1Nc6AjyvU06XR6aHPkLHn6xTb/w92dHfGVszlcLa8b3+xuw76xnGhaaVlDdsRCIxZB4185Jlecll22srJq5xyRTWsWWHn7B5NJp7Vch57+gLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWazcBHuQ+tgr29lfhh/PZKdUzuByswhf0cZmpYEOjw=;
 b=gaTOaJBaHt+MjCQ2VDE0xdaO15NAWeVHOgAjBNSXzSaJjyUEUl9XI1vWLydQ3YyKhvpg+8ywwZdo1VsfrDOfSkzNFFtIwAwzxcL2MZVPfag2gF9ENA4q/PG6oHVKW0q8wY2jQk3mriX7r1D0NV+i+tSdSbl6STFVnoeoHPS8w1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB7463.prod.exchangelabs.com (2603:10b6:a03:3d9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.24; Mon, 30 Mar 2026 17:55:00 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9745.025; Mon, 30 Mar 2026
 17:55:00 +0000
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
Date: Mon, 30 Mar 2026 13:54:54 -0400
Message-ID: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:930:83::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: f3774e8b-f7dc-4af4-b69c-08de8e857628
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|13003099007|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LNn0wCM/prx/HI6J08oN8QoQWUJ6IvRY6WH9xgGZyk8wRs2WEWSWnlsB2e1KTgqK3NQ+KP5LNV5Sj0D2gn6Co2YGk41j1huY9TMOPN0ASbfgU3xmo2avOCEYMLcsY0sfOUMVXQNEkZezBW56ju1jrhQYbHuqo/5wgMhQnW0i8V05O1PuJaHlb16OvQ58YtquzxUUCglZGo0GmDsXnX7n2l6FSNCSGULdaBkQZ07kw70neIomsS7fah4UyKteaj3k8oQcepHMLwUltHsw5U94BsSBO2EexHQfxsLgOIX/QvkySMzqte6A1eQWzgJTligqm4v8zPmh+BhGL2FhVSE/GvjRBVXBQsa7KZ7fJ68o+bCkmE3IfaTwUMDitDMFl4LDhw6yrXBLRBBGDWUsSBrfUT50LfSaVqISWjn0q73+hVXhCQsjzmsMN+SXciIzdI2PxuigtVvkug7cl+bCIkuzfVOSuz4kCh9bAPsha0Z5UYqaCVnt6gOBEU/p5/rmkkn/0NsOJzxB4q5mzU5o0gDpXhnlALOYvd6yXcc2uDelF0ftB95fqPXSp8Y9qbKF+c81mgSdzVvqZmItLkMuJSAoI7PPLV8eeuVxBCqc8nvS6YLTLaMFSBkDGjLpteknmF6t0b8ePDgLhmLNUtlKE9Z4qnk4hRggUOooNamzwBujfnYd8/LxPHH0sEWV4ZUppNDb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(13003099007)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/NuwQE+5Ii5Mu0gZmph5Hcg/hSKPYzqCbhXNifHV9vs/U1r8XJUefOw9hzk?=
 =?us-ascii?Q?u9ftfShlpv+Bg7oTMzKK5IbAuNVrjA3PopGBowquB8o/R3d17W45il0+QtY4?=
 =?us-ascii?Q?KIUOVbanZFRfei2qNpttScVIE8SVGlAGvB0qo6V/M7MbPtLkDt24xOpw3ZZh?=
 =?us-ascii?Q?ecDzRkUAbKnS3gHWy3mih7NzyDuptGuxDIna5UU2n7ho/w+RS1aaRQSyK8pY?=
 =?us-ascii?Q?Urents5eA7sS4xFA2bojGB7YjPqvYJOac2D3JJsQ7eV346l4Zeg8ZdtGaWJW?=
 =?us-ascii?Q?uTpW22/V3UagGreDuF326dD4DMVGGw5zLzQiHTMMJALDK1yAa+At89nYjXux?=
 =?us-ascii?Q?97ir4i8xNu2TUav+2kcW8FBaRbePzGjblBWf5UFB4ISytyL6+lwIVk9rmqHZ?=
 =?us-ascii?Q?K0SdD3D29dGJ+ngATiqbxERvHgsR6snjpF6nWYKtsKEPWi1Kbyn1J9cFHPap?=
 =?us-ascii?Q?X2gEVQu7g6/heArFNQsP3gvaPaBq7nDM6jk+huMgJ2K51bC/5wYQz2G10axx?=
 =?us-ascii?Q?V0yEu7gzjtdH9sCncNMijuGXjyptJzAxWGlDQaQOdu1yk6AKjynY98xPGzp/?=
 =?us-ascii?Q?gzBCsGQQrvj9zEslS58oNChN0Rsqc9LCKWaygfSHPf+8ub9SEUB0amQ/mxE4?=
 =?us-ascii?Q?G4CoAFuR5h06k7DyxCWAbGHjfUch25o2DjET90Xau7Dsbys79AEAUlr8aEuh?=
 =?us-ascii?Q?yTMzrz8Ge+9IgJD9rSkZFIAG6rL2+5Bu4xE2lLtRX789D13gTdiLa0PHBByt?=
 =?us-ascii?Q?V7yChxUUSHjmHjsY7KZ5JoDEmsxD3N1ZXIPIZQVv6mZPZlw8PizsgOvgq9UM?=
 =?us-ascii?Q?nrquotqOCV/cGIa+aOsqlgEhZ+t83NusvBZtWAG3TQSAprk0VgX9952Fik8y?=
 =?us-ascii?Q?cenqamIpEHd5S4zMsg67B7u6Ex8uRULSYfKzqU3AGvQLpWVEARCmlMIvMJvK?=
 =?us-ascii?Q?B7CEul/bF8WgqZw4gIm0y9ouRtn0+xayD5IGC6eHEl7z2rbNI/0t1NettOos?=
 =?us-ascii?Q?kDWBQ/5jEswd+pToHJ7Xy5A5T1dikEsD9i6fUlaJslns5xQOps+R+zEJak9s?=
 =?us-ascii?Q?JgSjX4x1abXS/p1ZoGCcMFfWzHCGuqiweUuJUkFKG4pFd/Iad3R30F0tc+Qi?=
 =?us-ascii?Q?XffnBbQQtezrNd93QSxO/PYsNW5xnX7N4jauyBCainAWhHImL5q1AXx3J7dG?=
 =?us-ascii?Q?4KGvDvCZlbK54YI3YgYU0ztm/d04d3mLcpW24QiJCnx9ccWLVo4+yn+9IF0c?=
 =?us-ascii?Q?QoIlVCnTl6lL6dJ5W2XHBsHShZ2Umkva6F+leeUcCXUV5/wokWoHJ2LoZbQh?=
 =?us-ascii?Q?JdOZtdPrbxuMdk23IGAzoIa1Duc9p0JW/7DqCy4Tz9DqERnD0o5oLGpiYbHs?=
 =?us-ascii?Q?FW4+vZIhv07NXBgAMfFe27sZSrZZqemqWGzM7rUJTW8nVFBD4CJXVarZE2Hg?=
 =?us-ascii?Q?gIPkKA7Ep7It3VpUVvczEpKgBOeRPKoEmPSnY6/sPr2itk/XuQcNjyVNGMYM?=
 =?us-ascii?Q?goUVkGEAGuls79Xz1373Pcx+EaBRymdnu4G7MWbY8Jd3wwRctrqa1MK4oDvZ?=
 =?us-ascii?Q?b4lgwx3Iwd8rwodF7WTEJ1W2xD8NLGNYAWrAPVFxa2Zz96EhDgv7OwLwQG4A?=
 =?us-ascii?Q?gYy/trZmbGD8B86aC8Bf3ghOiMcxzndQ557HfGzu4tlwIocB54lJ8ySWQtrh?=
 =?us-ascii?Q?iundeEt/hhLVLduk3TSlcaKGvlfNSExJoEtIXjoIU63S4P6zXTg/Lk5OXiA4?=
 =?us-ascii?Q?VdfQOtJ9i1DnUJExECtl3/Viasj88bqT6UMttQ2Ekm84fv5GOx0Rk+9zdy37?=
X-MS-Exchange-AntiSpam-MessageData-1:
	wmME01nGqjZtgARa4KNHwW6H3lc5+oK0SjfCQoUJzoATCjKUX0FvWCMp
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3774e8b-f7dc-4af4-b69c-08de8e857628
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:54:59.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVqnSBBoNioAf0xG7y/tZaynmcTp81mqbas+fErCfiyJatromZ5P/28zAOEeeNoLn1AMjLYNmzmv9QJSHEsJd9PdfYQK1fpVAMaJ/Z4v8uB/EgBc7Rm1xXrTUoYMEJ5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7463
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273287-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[os.amperecomputing.com:dkim,os.amperecomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uefi.org:url,dmtf.org:url,oracle.com:email,amperecomputing.com:email]
X-Rspamd-Queue-Id: 6B3C635F8D9
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

The shared buffer must be at least 68 bytes long as that is the minimum
MTU as defined by the MCTP specification.

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
Stopping the interface will leave any packets that are cached in the
mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
attempts to deliver them and has removed them from the ring buffer.

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
 drivers/net/mctp/Kconfig    |  14 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 345 ++++++++++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..1813a2126cc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15288,6 +15288,11 @@ F:	include/net/mctpdevice.h
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
index cf325ab0b1ef..4503152c70bc 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,20 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
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
index 000000000000..700da39aa406
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,345 @@
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
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr)) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+	// If the reported size is larger than the shared memory, something is wrong
+	// and the best we can do is treat it as corrupted data.
+	if (size > inbox->chan->shmem_size) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
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
+	if (pchan->shmem_size < MCTP_MIN_MTU)
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


