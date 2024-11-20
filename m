Return-Path: <netdev+bounces-146543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A649D4251
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC94D282F22
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12D155CB0;
	Wed, 20 Nov 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eJamJMqS"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388D13AA35;
	Wed, 20 Nov 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129350; cv=fail; b=NCc/0J9HQMJgwbMTXHwBRx5eo7btTeJHsGE/PaWX/45StWK2js4w4a1dg/FbQzNZOX3mojzJtA/NFPLqjBWzngD6yy2NWIEj6mUZoutJ7609fQvZ6MpDjaErREu4e5zL6adCPf5NvTu1GvykZKpYTJU6e2QW3fGBI9ryGtK6PPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129350; c=relaxed/simple;
	bh=UK3oLMWuBCQbqWEgb5F34fL7125t5Rjj8srZuRvi0BU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KSMZStlATj7BG9Fh6SXYjEsiEaUFUAVFvoI67YL47x0WQcjenxqbNSoNKVGX0p15UZ0QEwv8nAzWwSLs5zZcKTup9oLMExPbLvJRr/bMA3JCztw3tc7TkctKJmupCGH832jSm/Id0awpcx54iew5mxpUmv7hoczND2n1ww4pTdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eJamJMqS; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y70IltZdnABZ2k07vnYd8yoCIbzn4MuaZvG9Rgw+WfghLpZJLezPJmr0xSelzP98gq7lFLWKDJ/Dy6F/3xmJJBjRatQCgCOMXavLWLuksPF7aB0/byXorW4zs5sUv1icltI+nshbKEQDO+LpRTdtP8HZDe4qEOGky+8t2RMjJ5kumK8RfX5jWv2+V9/bOaO7kCrX1shggaJrUw9u7L9XJmKTyM8EAah1RbwtBIC4U9YpMO/GxkWPBjNW9vm/Q0xmnune8cxKMzQhkDHhUEGauahvWTmz7Oel+Awvv+iqkqITN/3kBrEn5din0GwHuM0NhoGCxEKjmgnlXnJA0zUCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTbgrBzgvWaIBEBOmfVqyU0s8IR0ifAI/lwXMWtI0ls=;
 b=r1lVlgwIeKYvO29DbG08mgYgoiXS0ZPDhgn486Dys5vUkh4FK9Ns4bzDh/xwrD6+jTnkowgkv3wGvCgEtdmtTqdeIeBjVZVoENPAM+FCMCjauWmQ+aAjunsf0UWOsCh5AHkohSqEVFi/dQmufi8Rcr/+EYXe2lr4xrxaDOgD6xVXJO9MGCe0Rr7SVzh4w232BGB1udA9zdI8TDdTL/aY22QLKZdVJalOoTTKjKlK/+Zrk36iv1kb6m6vaZ0Ph7Gwg+12mSekN5d91l00kv5Lf6+yxMLMGkgmC6LSR87ld64V7HtVP7/XX/wmUPAyX7fQ0RmeYDLlb2yHM0UA+Xl+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTbgrBzgvWaIBEBOmfVqyU0s8IR0ifAI/lwXMWtI0ls=;
 b=eJamJMqSSx8dur5K0DDkj7U33uxePtqQ7DLbFMPT1BnW0TBryJCqRJh8c9xVhsbg/aGZjcFEIiiZxFTd2U1Jsf7C9yGmexJGIERYD9FnKsMuaKXYmIkZOaPh0LJQfZz/jRtvLG5RW1AaQUBoWOO1CLdi5eD23B6zYtB7x6TKTPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.14; Wed, 20 Nov 2024 19:02:21 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8182.013; Wed, 20 Nov 2024
 19:02:21 +0000
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
Subject: [PATCH v8 0/2] MCTP Over PCC Transport
Date: Wed, 20 Nov 2024 14:02:13 -0500
Message-ID: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: e11dc13a-c2b9-4403-b124-08dd0995dc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ikvklA2acCWlkTVcKsuH3ThuPCfI6UQq3SqcApiLVhbZjaQDb0AiBCPQY7oX?=
 =?us-ascii?Q?KthUSN9T8q4RTbdz2LpMbzUNxbJt9G6apmN0Fjd4RYeONS7+xpLRIfn9W9UT?=
 =?us-ascii?Q?/u4gTwht69fQ0kEBcbUbDNW3Jwv8ff/86hoKiAL7nOiHrK975QkzXPojFGJv?=
 =?us-ascii?Q?ooPdSAlPgjqsQY5ltJ9SDOLyy4s662x+us/1UuSNR9n8dRpVD8UFNLJrC/tq?=
 =?us-ascii?Q?ersVHcfJPivAi3CUXOvu1uvANeM6lNaee04jBiazJ3wu/aGXsuid8tfORnrd?=
 =?us-ascii?Q?sVXG2JsO2qSJdVQdxIn2RxM99UhU9RUq36ekdlyMKOzXzvevlYvrsbaYY7Ie?=
 =?us-ascii?Q?ieMLN9uD/bEqtd2TQyzKiwyZpqtVP75Y/Ep0rYk7P8nTQE5Px5CXvVIjKM9q?=
 =?us-ascii?Q?H0I6/g9Aksjwwf3Gf390vy6/BAlSzFhS9j0PjYQcBMM9j/S8NAxM6WkahLQ7?=
 =?us-ascii?Q?MbGulRx1vByEifZlISRSdW2Ba4lXHvUZgiul8rEotocHZ1MfKJ9J+fH3WbnH?=
 =?us-ascii?Q?8U2J3p7B3EEc6/A1H7wQun6Gdzwut9UY3Tky4hv+rRiaLOgNhibw0sAclY4i?=
 =?us-ascii?Q?eEvQOgDsRmiVorRk2CDiriRAo78DE5FK/PXC0KXJlvDtUJVyrE21fZA8sj+g?=
 =?us-ascii?Q?WVocjwXNFaNhHb+dvrmP40zQyWU07aXZcx3NmDWSUHWZCPlX/pz1s1O8Yw5p?=
 =?us-ascii?Q?NtX6KTh8MD/gQgF5BXSn/zwunANa4+66rWnVm/eLxtTlMo1OuTbG1O6mKfmC?=
 =?us-ascii?Q?TJoJMXm1GIG2juYCzO3cFfTC9andDJMA8pZQy01s8DctcgVy7MUOPCLM+aCw?=
 =?us-ascii?Q?GqN2s5B7eJ9ITOSCmdFBJiZRIDMlJyeoogTgzk+11NZQAbaQcOq0pEIvBFzR?=
 =?us-ascii?Q?f4QpBXsSl6u0BGg7BqqEPzGcIhB8guaibeczWQiVaY70vSyb19zz+bU5ZJt1?=
 =?us-ascii?Q?BQDJ1cahbs0FPgJpXzY50Xf82JgD34KnUCjQ/GydmSz2AZBpkNG46qwBLumc?=
 =?us-ascii?Q?Y2BrvUIHahEFFw38YOuQJA1l9vmdEKmEbsQ/4mp5rLfRQ7YY/5QnIPtHYU8l?=
 =?us-ascii?Q?H2H2jbx1hWC50Ll99Buz3FkPiSaS9PdZ5S7WR9nW5sBk2aD4bkjB5g5oMoPY?=
 =?us-ascii?Q?j9sxo6rE+c4NDbNHTDRwmUpT5Y9FqZ9heI2gQZCbHGD6owv2bqX1Noa51Zsp?=
 =?us-ascii?Q?znBlIWNfxyo7KYRcZv5tBJciGWm7kM3lUdtPTwCfuJkKUHF7bpp9cjSB5gLD?=
 =?us-ascii?Q?sCoLpnYFMFbJwxIdTWIdjwHfEkaB9n1JUrIk3n4Abg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?InvL4y7R7iFLfIyIyHe2ZS8HmgzSCGD8gzH/mw6VEDTZ9OMRcC89E9/CO2Xp?=
 =?us-ascii?Q?34DxxQw1tzAhgKOEUyBTdH4Gi9wjtBJzpIvKFjhf5XoRnbXXtvTI+66fWZuW?=
 =?us-ascii?Q?5P00xp089KKpUBHimV0ygEs4L5iQ6EDFobNXd8kAsj09VFtZNLIUvAGrF6r5?=
 =?us-ascii?Q?7zJJIGhFfBw9Jp4aLrPziXHO/fASwdD1F82GKxm//15JZHFKLMOsEaU1hKkd?=
 =?us-ascii?Q?IYrIKk6Jr/Grw6HeMzCKOMllYJW/nhqVtr1/cmGqkco1vYO4B7lp6h4GhRQI?=
 =?us-ascii?Q?rD79IQUpy+FHfKD0b3AAPo7FHBfMiiFTNgnSTFG4TrCZQwVsjUy+DNzTCZcj?=
 =?us-ascii?Q?x0jqYt5ZBQFWMhzf85g+Rz7tDucS3pN8I2R901+2Dohdsmzv9AqPl1UunKw+?=
 =?us-ascii?Q?1UGEJ2GKEbns26dJ7pGl2JbtAM2uCM58S7xw/HRPTg494xyaXxK5KRG+VyGF?=
 =?us-ascii?Q?YYcpSyS6oPizdwxkDPYwUEvEUOEgbCceKQLJLDEiKC4htVpt1+fy29M/pwkx?=
 =?us-ascii?Q?TyxgRbWIacQ+a/WCIwqR3qlwTAahgdOVc9q7r16F6gXvDdYEB0WdgVAuERe7?=
 =?us-ascii?Q?8Aqf8dqEt32VKJ89W/icZxLU/ikUxynNGNoQfUqXKU8tPZT2DhzHb49/o3tz?=
 =?us-ascii?Q?BD7eQS97oZZ104XF7jxfYm1MBelUaiAaEDhXH/vy3vQ6FkPUxlH4nXX6DtLQ?=
 =?us-ascii?Q?hdtcgIIZ12JB0HhUFUQdhnVUfn8ZrzNo8xjypHwjGRUdKc4aaOlS7Ps5hkS8?=
 =?us-ascii?Q?xLM5oOiTUQss6/caeHQ005pY+3Bm9/G7HI3bvqxzs0C/hPHw8eDj4yB9xBGU?=
 =?us-ascii?Q?bZicCn6vKu8PQHq3wlKFCoYP2ZhI9OxLSPKdIfJunF09WGL5Wb9jtU/ibD+1?=
 =?us-ascii?Q?5ThssFHAtCMCMGtt0O8h+/E/Le8lwhMvY0nUCx3o209NmtORArB6e0IuGeV9?=
 =?us-ascii?Q?yPVni8azfdG4rX6iv2/fzucaBmJN+XPWvnuvZvxv5Ya8fRibXfHaBjxUd+vd?=
 =?us-ascii?Q?PUv8XCYRm9Jgy4+JHcmHpHdecafBexlwvgnLi5/Nv/V6PL/pe4x13H9XWiQh?=
 =?us-ascii?Q?Jx4FqYitJ8Y+UoPy9dG8l61crl8qJ8AbAjqMmibzMrxIf4kSCWdSs2Y42Y84?=
 =?us-ascii?Q?ZG/lKtuVEdURylyT5K15SJdiyje+rgmbZ/+spxvzBtRQDFB+YjJMn86MZjSs?=
 =?us-ascii?Q?ObPvkXB/oetLmvrJ2MwezFsJPFdzXE9+HxI1LliloYJGkXvGMUJd63Bl05ni?=
 =?us-ascii?Q?E3wLaGZBCQbnLy7CaE9mLnwSQ41jkF44gVSjOxzUgiu3B5uTR+ueU9nru8RS?=
 =?us-ascii?Q?LJV8mIidLRyVghK3WeJOEJ96I7aIqKyn4jArwUTe+64193baVYTEKQk8L2xT?=
 =?us-ascii?Q?qbqfaOTsXehr3JGue5B8gMPMXJgvM6VxTsRKwp6DdmZ2Ax8dfxbaumcOnBrZ?=
 =?us-ascii?Q?cHbqYVX98llL8EPSFpn/bfUUi+urN+RWkQ9nVgt8D2SNJmZrEyXpOOCX2uou?=
 =?us-ascii?Q?NNoIic5xGG7y8hzS7hzRqvvuElwNYr8Hn+Tqchnbdkxrw37DR7xcqKfjYlUc?=
 =?us-ascii?Q?odCySzoHXxa9ufXu/edRqQUYT31RxXxikKBGlZJ+TuWYU+imJgzJf7+mB/hC?=
 =?us-ascii?Q?9EXYltfliR6YYCWziYudQeOSvxrAFeHHzJUisTegEbjpLDqibNPWlZnQquZD?=
 =?us-ascii?Q?aoX/Q5fSteQhoAuG3MY0/Pfq/pA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11dc13a-c2b9-4403-b124-08dd0995dc87
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:02:21.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hol1xH3nb3xhq3aUprM/CHN2gFpTj0vxGk6j8OFkv/Kc89lx65DR+hDV3vZqpsAa5ldNAdP99xk4ihpPHBu6KT+6V8J5MS0HQncd4MfFwafveqcbM1CujgfZ75yHyooz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788

From: Adam Young <admiyo@os.amperecomputing.com>

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

Previous Version:
https://lore.kernel.org/all/20241029165414.58746-1-admiyo@os.amperecomputing.com/

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
  pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Implement MCTP over PCC Transport

 drivers/mailbox/pcc.c       |  61 ++++++-
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 321 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |   7 +
 5 files changed, 395 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


