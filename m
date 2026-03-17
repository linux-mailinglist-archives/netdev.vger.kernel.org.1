Return-Path: <netdev+bounces-268762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL6RBznZuWlHOgIAu9opvQ
	(envelope-from <netdev+bounces-268762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:44:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F202B32A0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3569730DEED4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A403E6380;
	Tue, 17 Mar 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eXkqfT5U"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020136.outbound.protection.outlook.com [52.101.61.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220E3E6DE4;
	Tue, 17 Mar 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787407; cv=fail; b=fjaum1IE6OdvJXJVhTmzFp6zumikJJSbwb4sEHDknrP9HCJb8W/W7CtGplxckTU0NABkeOXt1YOLKkoswLFaEATr8s4OhM+/bKUdkTDlwjNgrueHfOBjSTG9unwYwlyVdFJ0+mixWc870+/7C+XFCIl1mARliUnY1Qs0ftQVlms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787407; c=relaxed/simple;
	bh=z6d6GaZoq44zzyb6jpoMbWggB5XOPujMItIvh20hS7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdIlNqQFWzjcohjO0Vdt5Lsp9JYeS0unxyFEbWTHOw4NEFMn9iZJeR8FUgu1iJsdKA4HltdXKco2gQstsxFgviwB5BW67nVF5VUbs+T1axHZA39VpGh+JkqTOIsPtiyzZyo0ANfGM1GoEG9POpaZMxwF0kGIT1bwTr1dxC9hUVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eXkqfT5U; arc=fail smtp.client-ip=52.101.61.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHWhTresaPwYKES7RvkznSKgkXgPAKWGZX8R50OyaPBBBOms27v0obh/IyX4gt1BaYxXaeWmzgM2tSRwf1b9pxuxMGMMOBRlUUjyq+afTuaKKM5RL42pYoxMOpaIgJXF52xlKH8dKUI4T0PDer8QtwqZXQWYcmIuGHvjps/CW9vTl7Ew65BMIUXDhGmnGMV9n6skDurLkptB5zewcrepj6/1ejhCNCI0pjtLKm938567ab+MfyFYEw/6EJOOrI9gfat67Hid6tZGLONhqRv4/zgkKIM2y0O/pa6Ed+TynqH2INz+oOt6TfK7UC6vUDdly/2VcnP1zwIqbovKnppZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTyxWn4kOf4Qla3KzhiLYsydhF4F7WPkb3GxW0kzI5Y=;
 b=e0Hy81/5nSUDHhcK0akXllMq3Jp4irC6AevVBL/ACVJPx11RyZtbXAZy1sYHD1LPOqPUkoPTurw3B+4vImjm9tg1qankzynRT39Diy+P5gWYtO07HBMtVsREs1+NtKA/dZSgytBTYMCD/O4djptoMRjwfyRVuNL0uAtjlMxhosQPMRPqMVOlsOrR8Acy6ob9rNsXWpFhFsML0sHvuAR9tPBMvXZ4mmrriej6uhRM+EU3gUTCXPCgSEOCgwzWAi5ZvBILFvrt6DZatIgnjekAK/iBKU3iEsWxuRcbCR/ewausQGwbtAbypHAlgMqB8uVZbdsLS1+vQmmSlbV16p2cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTyxWn4kOf4Qla3KzhiLYsydhF4F7WPkb3GxW0kzI5Y=;
 b=eXkqfT5Us50Sd7PGMypMs2mQii66/iBbRmBsmFGsItlqYBaK1aQ6ZwKcztQTCUUBQc8oUz1FjDt8OKeyZmhQ0sfOeo4SA0ui2+3pmnUPEOA+jS8eihr0Jyyr4e4zeZAkUR062QX77raOxw9Tgidi80TqlD89lFnBOeE+GQOQJXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL3PR01MB7193.prod.exchangelabs.com (2603:10b6:208:344::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 22:43:21 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 22:43:20 +0000
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
Subject: [net-next v34 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 17 Mar 2026 18:43:08 -0400
Message-ID: <20260317224309.645480-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317224309.645480-1-admiyo@os.amperecomputing.com>
References: <20260317224309.645480-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL3PR01MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf5a61d-6296-4008-8805-08de847696fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|10070799003|1800799024|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	yvXVHNwAni3Gmmk3YyIE7BbdtsitAjW/sKrl4cWM68u0ifj6TUOwwuUcq++ia5j8Cum0RzXFIHR+bDmDh0RqVvTcaQX+OZmEcBWWfRB0mJjBXPL+yiQJvkC/igqadyG3iScJSJr2Gu1VIjH2RQBqYbRSsYGRncGpYFLFbITGldFHx2k/PLlZLH6Rxfy3R3uBl3xuLsQD4UbuPxx8FLhF08zNbbmNaSm+sWEhEyTjJfg8MQuMvHNKcdTDYgvtYmUgxGDiZDqYb+zbnk2vF8XT2mniNKffATwSYOBuOqqY/l3lHhbmMNxlSP8iLFriNFCuZYIWvlbXhPQaS1fkSufMMnb7B26ZhlPXTOV79INZ3q0M50Kzg0XKir43yqBFYur6aRS8EWJmlapJaPJGPPBCPfQUTHonR44Kwhk069W4RVqj8qBlCNPja/RathYOC1Gx/ihIVlCnaUcWZHWSTbEzN3/UMJC0dQeJIsMcxi0XszIhMdWHB4H/xf8JyDeyaR9qjpyDqhdt+WaSTYUgzMUU5bWV35nJpv6twEgrTZckiX5hlHzdRcEvAPELJd7aiS7NIe/K2slN39LZi16dcXSP2WfQ8VtusnaAP0kwtRTMiMY7OKNOMD1EQ1ukSTK+53F+pZst2faeA5Og3dGu5AIV1N35cG3EgWLtjXYiivCCMr2yCEpbhPYaDvSoihsHM1S0Fg6H0lg2VIFx5Nz77X5UEO/91cI7j0Ht7WvEt1od4YU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUZBqvyKOvQhzaVK5higCy2ijvRKqXK+bE1zdVyScqJJmUiyhvMVazwE5i0R?=
 =?us-ascii?Q?NMUWAZCI0R37qUrRYE0eWdkJYIFWY1Vva9/ETKuSjyQdCFzwY6LWmGNiKcnD?=
 =?us-ascii?Q?/5zx+ztv0xG33//Uj+f1kyis1fOBE+mrcFSTJMoixwl7lY7jFPwTzrHhS5H2?=
 =?us-ascii?Q?A5yva+EI8vUH3NiQV34E1YYhDOQmg+v3rxO4uAfs1pyp+cGCx5eRMnxi70Fh?=
 =?us-ascii?Q?tGsq8GCYrq+rlveC9lN+Wa4zMQ3o9ReGYhHquDj2xZqEf9mHUa+JOG9exSfP?=
 =?us-ascii?Q?FzSF4WpdqG1DZWziF8X/vH/Dayo1Q04mSdzgq+3WZS+D4xP+AqgTjcjnikxt?=
 =?us-ascii?Q?/L7MkCS0WC9TipnDXao8FSwytkoB+Z5CiH7G5I85+qNmA7AZaPgwDYCU/ij4?=
 =?us-ascii?Q?kVWN2hOB3cMBRyERV+7hhGdwrxTHz2jkmsC1Og2njgaZGvZFOcdJ6V9+gzEA?=
 =?us-ascii?Q?Sup/or0ff+JWzspDg/yEuRUb7ETtcP/C+KBqVBP0uz7KL1jNvkL0cDmFUGXV?=
 =?us-ascii?Q?bzLAcxzqanOjFvxfx+71Xl3GT3GPO8VT2Wn+fqjesePJYMiewnTnNzGFHi33?=
 =?us-ascii?Q?jlr+bwEQZ8W7TY2SeMiJMbdK8ptEGp0SryRFfldYCE6qWXHW/7Djynmi3BbR?=
 =?us-ascii?Q?JpXEMf+/J2ZUJnjccZ69fbN43PfmSxaB1Qt7kSd6E9h+SMPp7BnZvTbb0Liw?=
 =?us-ascii?Q?mBE6yIhX48WTl+NsnxwCTtWsg+v1vMC9YWEUKldoR60m4eDDZbPdKXcytudy?=
 =?us-ascii?Q?8ASXY7arIW9mfXRB0r6vu68NTc1N0jqElH4RJpS/1HJnF/HXUmnbyzjq9+rl?=
 =?us-ascii?Q?X49EvDDNjNeVNqChh4g8FvC5dhpdJvcGbzKNaNl/jujzFr79bIzoK920HjBc?=
 =?us-ascii?Q?Oklcs1Jr1SF4OSXdYgDdhq2o1E6MisVvGRXE3tKXYLr9YZpmAFwmGItkYiP9?=
 =?us-ascii?Q?KF/ro0gwxceJkCI2dSi/Wu4Z8uKpSOO4ADJXy0ErRbqWoSUVT+HnNEi9R0Qp?=
 =?us-ascii?Q?j0C5fcXEuNbMmTyUTvYHmMlvdcFROroKP+dtEXVz7GmWnKb/ufWPucKe7CXE?=
 =?us-ascii?Q?kahcqGAfbqRT+1qHiI38zobuf0DqEOge2XHqf9yQKrBCs+LEPn39b8ANo09w?=
 =?us-ascii?Q?ccs2fbS2HmOM8t5QCX7zuXMfKZNDsNfxD9CFbctpX+4Ke1sIU+21dj4O0x+3?=
 =?us-ascii?Q?/1eN6q9rRGYI0UePlFZXhTGqlCRJByWqUFrTpVLlPRjKCbf420uOe4ktn34P?=
 =?us-ascii?Q?G8XqGV+TmU+LuhhJi9OCFWuMVeWoJ7/EODgE3dYHf6/kIN/S21Iu3rN9d++o?=
 =?us-ascii?Q?2bxz9JRR9KZespN9dfv9OtWEv+XdpKBRLXdB7dzGGkTrBBGXvLI/l/OTdeCE?=
 =?us-ascii?Q?Jupm6glsIRkwrFUzNqT/JkiSMc9fANk8FXkDgMVUSO2u2mnLaiQTXGCsmgEj?=
 =?us-ascii?Q?s2Ba0ji8w2Zv8DArh/ZUKGE9DZhEcnD+/TeMFEDFQpG8b6l24aX+EmKUvfF6?=
 =?us-ascii?Q?JVRcONAtE/nnK68PKeNfLTYvYsRMC7PKiE/IFGqqQC5ievhmKFEHX2K7Cr88?=
 =?us-ascii?Q?VbnidJG7a13PGpvp5kiyWaeS0fA6npSE/+AAhtDHgnKElimIhLIGlSYHN3Ji?=
 =?us-ascii?Q?V7HwrzNy0bTak70Evc3MV3WfvEZjeRrbPSIl/MoshNDtcSF/3RQ/EBZCs7ps?=
 =?us-ascii?Q?xZSiyUDSlTP9Chw181cKU3+McujfiW50GHLcxeo0cp6OI1si4H7ThYYum0wy?=
 =?us-ascii?Q?9qLBuHjN04lqcoXpOju7brgYH4QR8axyfo4y3iI/S4p9DzGCUCPmu04xPc1r?=
X-MS-Exchange-AntiSpam-MessageData-1:
	A7ReJ8t0nJx+MQ27Ks19JSDOqhTYkMlVHI61mb0alNWPRyR68zxtUFGf
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf5a61d-6296-4008-8805-08de847696fe
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 22:43:20.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1CTNneo9j6ErxWHXYMYyz2GJ/ifSL7WmOj/vuRh1A/3BEH8WIMrjZKpjbq65s8AnJ4Lr4ZJax+/hFG/RFamg0eD+w7p9+VV8r6YVm+CbFATsAckzz0D+OYh3IbGsvFj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7193
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
	TAGGED_FROM(0.00)[bounces-268762-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,amperecomputing.com:email]
X-Rspamd-Queue-Id: 80F202B32A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

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

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

change 1:  size may be negative
change 2: use constant for checking MCTP signature
change 3: put PCC data into the skb
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 366 ++++++++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff6f17458f19..43bc37f859d6 100644
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
index 000000000000..f8d620795349
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,366 @@
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
+/**
+ * mbox_write_to_buffer - copy the contents of the data
+ * pointer to the shared buffer.  Confirms that the command
+ * flag has been set prior to writing.  Data should be a
+ * properly formatted extended data buffer.
+ * pcc_mbox_write_to_buffer
+ * @pchan: channel
+ * @len: Length of the overall buffer passed in, including the
+ *       Entire header. The length value in the shared buffer header
+ *       Will be calculated from len.
+ * @data: Client specific data to be written to the shared buffer.
+ * Return: number of bytes written to the buffer.
+ */
+static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
+	/*
+	 * The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
+
+	if (len > pchan->shmem_size)
+		return 0;
+
+	memcpy_toio(pchan->shmem,  data, len);
+
+	return len;
+}
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
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+
+	if (size <= sizeof(pcc_header)) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
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
+	int len_sent;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	len_sent = mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+	else
+		dev_dstats_tx_add(mctp_pcc_ndev->ndev, len_sent);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
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


