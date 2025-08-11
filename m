Return-Path: <netdev+bounces-212500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A726B2105E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9414C7B287B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31512E8E0A;
	Mon, 11 Aug 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="i1HQOLbR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478C28726F;
	Mon, 11 Aug 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926698; cv=fail; b=CMbdDiomMp9BPqDDfSaqxntDg0zfQQRcM8U0Far1/mkA3y7dJKdiR6zRJNA4DUKbT5IarS9TjpzpEvskOUcpAGf3mQl5z+ddfX+alzJ4elxrOOG46urnaIE8/RHjmF2dsEZS2H+dSswexnU/8+dD/7kPTBMyMvP52TMCS0aQ/rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926698; c=relaxed/simple;
	bh=ndVQGhNbNW4zfNtQVhR/ZAGzj/HrNJc+rbSjUZUNAOg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gdgFNChktHFDZzEymISOzQz3crFnC6Z6cPyXDGKzE7VBkKJ2Bxh1HQToN2MKi3x+2zSFtydzfxMqh2HMsdrbzR9TyZeTSr6Lazm7PUJAy5+qo0NAke/yXPDwICnFOnDCsS70HI7EDkqQqSucBj5IVTBl4xjLpPWC7fgoRQI70/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=i1HQOLbR; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEHE6ZYm1qGydSD600zyH7ZlusLtiQi/Asr5luz4nfkR8klXlK0qKjVEIZ8y+Xvs8tYRnu5sidTE81yQtqg7gxRKohF/DLsOq0aUCEV0OiM3tXZS1Yy+vfOX0nJ9NJZwRk4SEwv64Uk8qj/6RHpycmVCeAdixe/szb/B/aaMyZRqkeCunLW6aSVoJvZvKxSRwKuZzL76vyRVZOFgf59D+Y/UuR1UodeoYCWr0Bfjekk7NuCkRu+aTKmcChS51puoAVweYD2HieegfOQqtQ2hs7C3LvrRkZenRruI0vK7AxOihxtT8aUkog5YMW7Fnjv46HhoImtda3XBUeobnxOYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7PLbEY7WNNXoO9RBEDDC7pJFkE1WjifGNx1U4nHJpg=;
 b=jTxoodh01uH463++QIYlZ79c1d38PeSP4Wf5YKOIlZPrGowxw9K/XSGWqlWTsFNj6XTBzrBopa/b3nkgg+IcRWzHxS/HfyxdAi1krfkYr3K9gJrJWieJMTNjN7RYbv/vNygOx+nngwo8c4knu8AEwIj5ofDEsVg2Mre7SauFwf38qiKIhcVteo47KawDNEG7Es2+7Nt4vXU/J5He4CHE4TWAdiPwxj4SBCAt3JCcP1VUdvuy//30kptURFr2woBYSgUjIme80MrboJZ97iSc1gPcPtYxRI5Ggneqbw3/mQmqhS0Xma15Gu4WTYZPby2c0LdtPu0h9B0hqhYAMqK1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7PLbEY7WNNXoO9RBEDDC7pJFkE1WjifGNx1U4nHJpg=;
 b=i1HQOLbRgXxKw1rSdSUCoezAszN4ihfjQGbrDwpE5t+x+AxpNvDp0Vr74GYG8v9oOaLmq6fF7TIL+AFhxCsCeywTUPeWqKG2gNTWml21mzyAnqWmSennG+QZTV9eSh0c8OV1emrTpfafiaZU0qobUx4hG6f0xW4eV5Ym9al6FLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7474.prod.exchangelabs.com (2603:10b6:510:f1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 15:38:12 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 15:38:12 +0000
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
Subject: [PATCH v24 0/1] MCTP Over PCC Transport
Date: Mon, 11 Aug 2025 11:38:01 -0400
Message-ID: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 432ea7d4-9a8c-485e-c0d2-08ddd8ed1486
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Mlcz/zUjN6YG2wjujV/qnJ3CQlxAIsVHw+kHF7VIPuu8Cppo3JE5zq25WdO?=
 =?us-ascii?Q?0Dka3y0Z8CFlNbEvsv9J28z0h+q5v4VeZOoNwObzLERfnxLlxaVstaMYLvCu?=
 =?us-ascii?Q?AQfMxvM33rOSHWhmfgSXS93u3dELtWZ2iS9fn5xP9zeLmuvAONru12YYnwFu?=
 =?us-ascii?Q?3oBHllP8SRYQr4KAbZT3JFXA8fNpTIEkU5+xkOu3VU8WiFld9NH9SqsWDf5j?=
 =?us-ascii?Q?g5dm0Jn4dIaqrRIpAMYzGzj1zTJHj83tOhhQA8BFBlEjMvnuB1lbjYey5NKX?=
 =?us-ascii?Q?m7EJdsmjqT6bvNAnLomzfC4vev58cjDjW7R+vaohmDOINSfMpp9ykBPYpkn9?=
 =?us-ascii?Q?gnAmzoe+mDOvs35+ZKH/kmUYbn3/8XxVF4mFQh7VfFFkiT2qfzZzvhM1R+Hn?=
 =?us-ascii?Q?P4FgBhdMTBdcBukIBVAB+vAAG0v7M4PRUlJH3KkhqP3HLbtHEVW28WqyyXR6?=
 =?us-ascii?Q?OhSjELKRXC/Y2fIW/1Hhz+TNX02cJBUs7Vz7pufVgOf3lwhlrKhDQxJ8pSNc?=
 =?us-ascii?Q?Bnee/xWV4JZp/Br3+rnoZxZS5z+EKdRC28Kxcb4TVTXeYpAZbEOpUetAPkql?=
 =?us-ascii?Q?zhQvoUPCPDRjLqygOZSn3Mu5jyJ56u5WUPzroThoitYJQRQJTQPzq/RiJMEx?=
 =?us-ascii?Q?q/3YlXDd6piK3irMLYo8s+Q00AHeTx2Jw0uDKE5CY79B2kE/tkPBugz77wIG?=
 =?us-ascii?Q?FeTMECiwS4qRB9pRqIBA1amoMLhlyUNfAPc5y02pSBIZfsL1PAADgbsguKzV?=
 =?us-ascii?Q?sHctItPzdgz6KIswwAz0gc/swcSsVJZJa+tcDVPxQ60jxSvsPfC1nn+Q0MZW?=
 =?us-ascii?Q?/VFO9CxQf8QRNT5Rn5BxwsF5PtE8tlB2n9YPODgHt941vc2ZcHz02XHNqJ6C?=
 =?us-ascii?Q?N91ItzTAAdCByd6DlJAJ+w5uO2LYXXx3AN4AAhVqXxL3zLGnPCN1LZMgwWmD?=
 =?us-ascii?Q?/VgCRjCsrFlluP1y2JywEh9/fUL+O97a+YBHHfZrIxt9XUVhuTDXNezcsAz5?=
 =?us-ascii?Q?x+hU+XhOXqnOI9Bp3ABV3UFJbj/M5FvYoNLbtAFLWs2wpYzhgosDE6faHOYj?=
 =?us-ascii?Q?fJGUrzX8HfpB1TARzYl2zUNx0hyFUDJFdDkPV3aYFEnb+bT8P5soMlE00Z6O?=
 =?us-ascii?Q?YoXmX3gqIWAoApTqs62E2/7nWQ8S3iNw0BUegRD1XtgkWKlDbA/0Ceaa4AwZ?=
 =?us-ascii?Q?1z2kCJz2sWjNSIsVtgws4856l5m2TOczMGAfF87RfCAyQnv6PMz3IzFK2CTc?=
 =?us-ascii?Q?THJbhmZKLR0RF+Z/fy/YSOktJY13y8zeQOA5+CQJSOrx0fJT1acHmSM4kKDq?=
 =?us-ascii?Q?Ry9Q0EBJbINJfJPqHv/aotRMgCUNRBH9doW/JVgl5lJGp6s5ZFtcttVcJixb?=
 =?us-ascii?Q?Aq/YRp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZck/n/bTGShcjiRIfl6sLOfCi/V6b4udiGGZgN4+cpWEVnttYhRCqwvEkVS?=
 =?us-ascii?Q?uJJEzdm1pNDtDeLnIhQG2TY9Mh+oYRxpf/ZTjQL0se7ssPXLu43xCqU3ODNg?=
 =?us-ascii?Q?iJT+pRdP+0LC9JsgnQ+tJ64fZX/5ax1cW1NLZiuANvg/cunzqoI8cFRBq2bB?=
 =?us-ascii?Q?x4v6rK7piB74XaA6FNLGXWd87E2j/PINdkvjk20zon7SQRPwFh39yheo+PcT?=
 =?us-ascii?Q?2A7e0Uv2fWQ34PiWX3Zw/vRFRIEaA7fX1DTeTfaOXqTQDmkQm3iVDFl6e5kr?=
 =?us-ascii?Q?BeWZsawQq+S279nz8BB996sQ3JhyUz27Jy4+K9Ei4dB1K05/0i7UEOVg/zLB?=
 =?us-ascii?Q?KuDXsRTPlahGzQ59iMOYjlEn3qZ4u9kodyXAy8VGpO+kUgabqnFX4Nzwmx05?=
 =?us-ascii?Q?9rXJH0YYca2kKA3kPAeR7iNNbhhJyB91uNN+t+pZ+xPphFjT284SsrCeE38d?=
 =?us-ascii?Q?nwBW2JIXWmILC+QlgErVog1ebqy8gLeNbzINd7KEHJOllFUfJPCrHB6XMJV+?=
 =?us-ascii?Q?zv37vd81/vnTtaOprTLRQXXtZ1TCyXJgDVlrR5YAwvvdPeXR5WJk3F2kjTDB?=
 =?us-ascii?Q?WHik1XATWy7AJMYXCwtXownDdnYl4K4NgvQiD6MqHS3l+KjecNqskCnjaVj3?=
 =?us-ascii?Q?mLIkwuINfOgwDItOmP9wHEcKswIjVefEd10tO/Su2bPphCYMpaEj+VG5o/W9?=
 =?us-ascii?Q?0xWy3a/6ncJsJdRq6a6YT1lbpq1JZI/DYXmg+Rv99Be/a+S1w1uoDtDDqzMd?=
 =?us-ascii?Q?Lr8LTpxduKeKBZMdL+3lnWeyyyGkokUotW/I5jO/8uBSYh6Y4BxLVDmBHjc7?=
 =?us-ascii?Q?A+UpGknVegWhlhiPpEF+XLaL0DkkiBbrCEl80ncZg3wKVnQijspwOwHMJZ0R?=
 =?us-ascii?Q?W7/mlH6egAYM/Zzfw1uwf9wyKWHTffBJ5LsD7ztVKidkCs3XP3LJjVhpSDTM?=
 =?us-ascii?Q?Hw1m+RHydDx1erBVrPKc1c10q/o3if/G8A60vrrIIR3XbsNunI5hh7j+ALZW?=
 =?us-ascii?Q?j63vdVrw/onb532M13bq5x7F8mOHXqZYyGX6kx+pR9xmec6sY5MK5Q/KkwUC?=
 =?us-ascii?Q?DcpJw12KIrk+6XWtlvI7Won5Ibkbna53E5sAKbzWHIKVXYBg/8r5tQS65Gt1?=
 =?us-ascii?Q?766U0xE489ERmbp27qRy1Uo43rt95Ol9jD2ikH14M2Czl/BywCkqH9D3+9cz?=
 =?us-ascii?Q?WUyvSiyGlTrLJIOfIsx3j7ORu6sep53Kj388ENV/qrDEBm8W3txAdujYCD9t?=
 =?us-ascii?Q?oXfz0W4ecEJtVnL5y4IwSEhsWJDdLNy80aW+J72sHNwjvq60Ylj8mDMgkaZU?=
 =?us-ascii?Q?/pPwXuOfE7TCJHT7dEHCvzMgk9JOAJZS7A4UhmJ7xL5VXCryrHv6qHV63oDH?=
 =?us-ascii?Q?F2gvOdsKifyL3v3rcIwrY0U3yF9dLjwaE21IpRPmf/m1FNEPD2ztPBclGaE4?=
 =?us-ascii?Q?Dqi1oHCZvYcqp6TzLugOmLlkJisf6rS3QrmlpoD3rZhB5ygkys0g1GlSLSV+?=
 =?us-ascii?Q?utZXTQEhPHLpHD/CF/YJneR4Kt9/ezPzAPgY/58HxFVVXzHIqXKFmDweD8Cy?=
 =?us-ascii?Q?eYUi43LFFGgM16jfdNbxyU7U3sdwQyiFst4qboB219WsY7HrWW6eRZDfe2dA?=
 =?us-ascii?Q?9lsTeKfFUqIbrMJwouWHuLg7mWfuVY+45v/DSt+mgGSR1IWON02B1UuYFImL?=
 =?us-ascii?Q?66y3Qw1Pn49ax/UWhbTe+dviRdw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432ea7d4-9a8c-485e-c0d2-08ddd8ed1486
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:38:12.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tF1/M1ZMDvFvTx3uUowbZZ6r4/7dwcURsikjkBJxjBx1VaYt5dvr+HGMrjl1hiq48YwP1PvRjIYulN7tPfTEzbGkU4wXELO7Aa4E2+LylECcUd+2kqIxNzQa37S9PkR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7474

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
https://lore.kernel.org/lkml/20250715001011.90534-1-admiyo@os.amperecomputing.com/

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

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

Adam Young (1):
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 348 ++++++++++++++++++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


