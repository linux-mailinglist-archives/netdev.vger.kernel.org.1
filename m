Return-Path: <netdev+bounces-285598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /xRdDMNY/WnWawAAu9opvQ
	(envelope-from <netdev+bounces-285598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:30:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107E4F12E1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB82300EFB6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAC2F4A18;
	Fri,  8 May 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KCp4Z4lG"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC33019C3;
	Fri,  8 May 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211008; cv=fail; b=RHKaHSgnpFLMb4FNumEtUutp+IJbokqvG9ZkQRNWDHanzke+q9eqUXyxxtKkmXd4nSaBCa7nRR4WEVkuHH3w9AvbI3tsJJgHsQ2zMrHAyNzS9Ol1KQB+mPKQlA9o8MJ5jgbqi1DrlmuayY/SL/s4oCY8zqhu1O+ndons9wNozdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211008; c=relaxed/simple;
	bh=kPde7qE52q23+xi7aTMtqMfOpB9vG8TtJOYKGLSPQkE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bi/d9H4Hiq93koNIwGVaZwkgyGkWSez5fM/7DtcZ66NSAv/FpIIm69UOU28jR6SBGXJt7xmUWbCzrZyNArDGBdOMj+NxSblJpGvRR+lLH8NC1GGI+8KtPqkq1VhcC/siReEFcMUg/LjLBf5zahAvoOgmiAk7Bb3Ew3AsrDvlZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KCp4Z4lG; arc=fail smtp.client-ip=52.101.193.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jif8AXXHqXc9+4ZJyHZB7hytIdWttk6pGQs9Oczh01Uhcu0OUa+j3r5aeyIEKSXkSpV5m/Az1obVQdAeAnQvLAEoEPhEewuqIpkMu2h8BaY3T8Zl9Hy6BZpWCRC46m3O9+386H8p/j2Kt8bijdr2ZlQmExuGOw4nr9OcNp+MrB2yBKznAhJygygI3YkDHK9YBqRhJc8L1Ipvo8LqHYE9rtvzt1sQBtex8uLijk0Mk8qdd1WiuhCq2vwOucwI/Kuh069s9Z0CZv61U+4QFJGZ2Zb70oReljeNQCPin5yGbYRtwEMLFCX+TrcR7f+8TtgkBh+suW1+CIMe6WkvIbTboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+qTLOAG10Aiwii0S2pXJCCAkaA5gJCW9RSEA0ZCjVo=;
 b=pEBu2uSVx5k4mY4iW+/nePZXBXZu0v1PIFzeEDms/clQJ+O2wdWnXoM6UXBqaSJgxEdbVo18PrQFNv1NZhVieK2ZycAamYFbCawlblQxOM83nKZM6msIgTDCe69uaBpDn7UQ/0xmVOwkiJsvi9tUn8gBxxI8dtLCjGCylI7YSzKzmaj/DSbJJVBAPHJgcq5CMLqehv0kNgxM3Fbu2ZbPo7klXHZUI6dVTzRIkPjg0fwnXPxkroxdVbgFNkCipEgWc0ggUu0Y1z6wrMEw2Da4JS/VY+4nDWJo5unO/ZyuOXjby1JZgk1dXn9XiAU2z49hE4/t6XfClcpXzvzKbLHR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+qTLOAG10Aiwii0S2pXJCCAkaA5gJCW9RSEA0ZCjVo=;
 b=KCp4Z4lGbNLW6Z8peZHq1nik1/g/GbKgRQ6wiZiqZc5b7xWe88IhEcbLwOBUYei0okcVO1MaThJYuRN+3G0kFoztmel2iNZGl/41PZB++DyStQY+ovrBUTezRIcjbd2xbDcYdRRs5oNcn/m9GEAoNb480gvB2qM+kkLMOxe4Cq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH8PR01MB994339.prod.exchangelabs.com (2603:10b6:510:3a1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 03:30:02 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 03:29:59 +0000
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
Subject: [net-next v40] mctp pcc: Implement MCTP over PCC Transport
Date: Thu,  7 May 2026 23:29:52 -0400
Message-ID: <20260508032953.337036-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH8PR01MB994339:EE_
X-MS-Office365-Filtering-Correlation-Id: 429daa0a-3b54-4ecb-7177-08deacb21528
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|55112099003|56012099003|13003099007|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	C89m8lDBXBTAa+qAxDtdVSab8HBW2AX2MyxAcfe9wafErqnunZae4QlUwKkQJ1p9+OifAz2tCoGKV7OQN3MmFgCTu+qVh36YWU7ej/8u7nbI6IFOiG9KBJaOUJjVFXfjjRq0EcGvjxV+bU5PJGEFupyUoloPN/LPAH3BTEgHyLiP4VqxLVtpM4eK5QoXRXJQihysgy0GXGJQQ9nrCg31qWuFIxkhOmgpa4H7hLyf1Kid921A7nUoyb3RGXo8HZrYotP8qQ67VvPU49tsZpuFkWW1e0PgccoHY+Kg0XgTEi2Qhj+7NdsYQKhxcHNKG3CLgW5PD6MmeE8F97wWVlrAiswuqzf7DC3todmfwx4T8+WuYX97wTK72LB+rEO/dx4SC2OFUAd2Z5dmG3FgjGEPwxFownHkuO+KyEB1MM5WG4yVj3prQ5AyL/qT9cEBT2BF8no1nyO/ij7S/+gR0rtYIrwpWvqYGXeaJfUQuLg7OAkcM6EV5KlJaTboFsZ5r1U5yUXzGYaMZZoevVH1rwyLaqfgXPqRxMjs1plXc+Gx487CvFL4zwtVwZ36nVCK5H+LaaZJxlHoqDttpeRdjrVCUIzMkAwWtKR/us3xhvcQQyCsMjC6P77Ivh4eGicPJTuhoBGfIj5m5hhIjX+Ia798KPKomJgflcvqfm++mkmSoOBVmvNuou7LWKX8f0FdAtr/YgDeGfpv3A2z1oPVJ8jwqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(55112099003)(56012099003)(13003099007)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JthaF1Y2X1Gn14H8piZczRrMs9Y5JP209E3svk5ulXf1rkCR9kJNCF1KKr7Y?=
 =?us-ascii?Q?nR0g0yRSqWwAxjBroYLVg9sk1PSt+ATMm4zJrCH9BkXBY0VlJlJ42GsdELz/?=
 =?us-ascii?Q?f5s5kM1VU8coSq8wh0baSmm2AjGI4CikykAdfq/Hz12Zxm6s30QCdWe295++?=
 =?us-ascii?Q?/iYrKk5+wOe1/ccFnNCj/Wk+T1n9+9i/UyQLQX08Z/PTNGY6+2sISBWL89Qc?=
 =?us-ascii?Q?y2m0wI9l4L/Ofli6aXP9J0eodkfw57Py13aBK1P3N8WHTmbr3HfoV2B/JAmx?=
 =?us-ascii?Q?OtnRc8juqVcT/55osQC+7H0CmR4UUjvNk/qiQbDTFVvEzUd13G3yjXLIXBMR?=
 =?us-ascii?Q?oKHI2lpCitKMB7lItrekcijRLDV0GxCiTp/Jol7IV5MmQNScuXLflboRca7d?=
 =?us-ascii?Q?4fOCrk+WT54tjyfyNzpsror1Hfbtkfnnw97S8BHSySBKex0FU/thP0IOPPru?=
 =?us-ascii?Q?hyF3G+mC0U+6eMtI0S+9xkCTyG7ubu+1kjDiixLLSkalN58f+sWr8kHM2IF3?=
 =?us-ascii?Q?1eu9a30cKCv4vsoR1e8T+rWK1nsGa9lekx4c9H1iern6thtviMtK7rpUdmzt?=
 =?us-ascii?Q?VVHEJ8nc2wahlFuJPtqmy49k0eFPh9RIMiIv9T3KeXan/LA2MdPaOo6dAC8v?=
 =?us-ascii?Q?ewx7kb6+pTOogluGu4d1Ul6yORCgL/d/BUVkybTf3mTymsDqmfnuQPeEUsDy?=
 =?us-ascii?Q?mceJZUWm57BX3DnabU/pEiGT8q+qORKX0dSp+Yl1ZAHbxiyldx8MK9J+YaXB?=
 =?us-ascii?Q?F3ncj69nW9HTEw8uizNu8F5CqEpPYdwCKjqXpy13kNQSt/dpeMEDa4i3tS7m?=
 =?us-ascii?Q?+JQgSOGEoBRYVzvVfEX+Y3Gcen0sathCszznb4HXOyBwKQT3SZ79SXN+MzSh?=
 =?us-ascii?Q?Jc5fs5nVOE0a7JCIygY/aege6K1DHRGJAsVoFH5UdX9lXRpk25lN8M1r2kKT?=
 =?us-ascii?Q?Ijd5yL+gEQ2Ek4bX2tYsA+5xHxxeqHkBx94VrRCXmduELE9bSzEY8UzuZiLE?=
 =?us-ascii?Q?Zj7Hrc4IFk4eoOs8Wt1l43OfeJHn4SI28CYu0lAun0SQbhclAijwNvadaQ6C?=
 =?us-ascii?Q?yGFJCN4LPxXgO+OH7hIjIr5lS54FeA3kG6eaGdh/nuomZtaXpfe/qkX7C/az?=
 =?us-ascii?Q?COT3+8h62iRrmVrlrt2QYyMeZVjEsUAW4vrYu/Xne2TWxd5KpluzSvU7nsHu?=
 =?us-ascii?Q?ON52hVcwHi5rjVbaNbK5W27sPYq8K9FROOuA1DtarEQDEbzhmyqyE496Fmmq?=
 =?us-ascii?Q?YsmEOqiTT2chC6Jg3f7TbyLGh82m1Gcq3+mhNfHjUCtAwUj52aZNhML+app5?=
 =?us-ascii?Q?482PslGxjwZSQJIAtjNGFN3VvkxbJ3oF2GgtKNwABW/NxqGFJW1YI3VJ6ekq?=
 =?us-ascii?Q?A/bABGJ2a9kwE1BZJI6DDKqboy32gZpBiNN0aKspVnFdmfSkSxnohhP5qI8C?=
 =?us-ascii?Q?HvfYL3pP/Bp70xulbKfnS8qm4TkvS493A4V+DGyE4veuptFE2xXu7jg9AVSv?=
 =?us-ascii?Q?bQpdvz1hXho4zBQbTnxOMomvKn8Jgmnt/kbt8Tqfn/kdBkxIPd20GhsR12zA?=
 =?us-ascii?Q?bTgfA5ylkWX9qjNt4SfsogdVLqevpt4pP8UKfHZ89okYQHRWU8HcNPmf8rPy?=
 =?us-ascii?Q?CbxQ6XnquQRN8uhScgvvIASxhOLGwnkCJJxps76Dni6cZ6Tqy4VSbv3B3XiF?=
 =?us-ascii?Q?0RPwTaGXvoWu8nrfmStJlf8Abud+zfLoU1914pUmzJTni9uUN7weMRLlkb0N?=
 =?us-ascii?Q?A/VC+yPRNNefGeFqVjkFZ0LavsVV2xccQx+ETf3+RwSrU4E6weJpcAwEX9qt?=
X-MS-Exchange-AntiSpam-MessageData-1:
	Q8praiSV2TMCmtWhX/2sMp8cPryCW5pSd+zbGmLycVmmL/VsZN06IbMA
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429daa0a-3b54-4ecb-7177-08deacb21528
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 03:29:59.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKsr9io8o5DME4/3QWkvGFVFNY4UArapRxlMn0f0ndbuPoJ/jVXinFSUkFfWdrQbwFkuPZzIS4R5r51NSzkPRVNsAhW+82ZPE5Hr/0oZEc94ZIs9ZJ5+KlwiVeKHjnRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR01MB994339
X-Rspamd-Queue-Id: 8107E4F12E1
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285598-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email,os.amperecomputing.com:mid,os.amperecomputing.com:dkim]
X-Rspamd-Action: no action

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

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---

Previous Version:
https://lore.kernel.org/lkml/20260506214327.276069-1-admiyo@os.amperecomputing.com/

Changes from Previous version

mctp_pcc_client_rx_callback common error handler

MCTP_PCC only builds on little endian systems

WARN_ONCE to ndev_warn_once

remove change_mtu function
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  16 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 413 ++++++++++++++++++++++++++++++++++++
 4 files changed, 435 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b907..252c77b24791 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15403,6 +15403,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <liam@infradead.org>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..e68d23794a80 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
+	depends on 64BIT
+	depends on CPU_LITTLE_ENDIAN
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
index 000000000000..086f7e7712f2
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,413 @@
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
+#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
+#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
+#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
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
+	u32 header_length;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	// This may be run on big endian system, but the data in the buffer is
+	// explicitly little endian.
+	header_length = le32_to_cpu(pcc_header.length);
+
+	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
+		goto error;
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
+		goto error;
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
+		goto error;
+
+	size = header_length + PCC_EXTRA_LEN;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		goto error;
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
+	return;
+error:
+	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+
+	/* Consolidated a fragmented packet into contiguous memory */
+	if (skb_is_nonlinear(skb)) {
+		if (skb_linearize(skb))
+			goto error;
+	}
+
+	if (skb_cow_head(skb, sizeof(*pcc_header)))
+		goto error;
+	/**
+	 * This code could potentially be run on A Big Endian
+	 * System.  The ACPI specification requires that values
+	 * in the shared buffer be little endian.
+	 */
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
+		// Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+error:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
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
+	/* The PCC Mailbox typically does not make use of the mssg pointer
+	 * The mctp-over pcc driver is the only client that uses it.
+	 * This value should always be non-null; it is possible
+	 * that a change in the Mailbox level will break that assumption.
+	 */
+	if (!skb) {
+		netdev_warn_once(mctp_pcc_ndev->ndev,
+				 "%s called with null message.\n", __func__);
+		return;
+	}
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	/*
+	 * If there is a packet in flight during driver cleanup
+	 * It may have been freed already.
+	 */
+	if (!mssg)
+		return;
+	/*
+	 * If the return code is non-zero, we should not report the packet
+	 * as transmitted.  However, we are in IRQ context right now, and we
+	 * cannot safely write transmission statistics.  This packet was already
+	 * reported as transmitted in in mctp_pcc_tx_prepare.
+	 */
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_open(struct net_device *ndev)
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
+	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		return -EINVAL;
+	}
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		pcc_mbox_free_channel(inbox->chan);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mctp_pcc_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	unsigned int count, idx;
+	struct mbox_chan *chan;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	chan = mctp_pcc_ndev->outbox.chan->mchan;
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		skb = chan->active_req;
+		chan->active_req = NULL;
+		if (skb) {
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+		}
+		while (chan->msg_count > 0) {
+			count = chan->msg_count;
+			idx = chan->msg_free;
+			if (idx >= count)
+				idx -= count;
+			else
+				idx += MBOX_TX_QUEUE_LEN - count;
+			skb = chan->msg_data[idx];
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+			chan->msg_count--;
+		}
+	}
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_open,
+	.ndo_stop = mctp_pcc_stop,
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
+	if (ares->type != ACPI_RESOURCE_TYPE_ADDRESS32)
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
+	default:
+		return AE_ERROR;
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
+static int initialize_mtu(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_max_mtu;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return PTR_ERR(pchan);
+	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
+		pcc_mbox_free_channel(pchan);
+		return -EINVAL;
+	}
+	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	pcc_mbox_free_channel(pchan);
+
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_max_mtu;
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
+	/*
+	 * Ensure we have exactly 2 channels: an outbox and an inbox.
+	 */
+	if (context.index != 2)
+		return -EINVAL;
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
+	rc = initialize_mtu(ndev);
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


