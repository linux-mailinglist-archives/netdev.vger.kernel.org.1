Return-Path: <netdev+bounces-184248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69502A93FCA
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF4F1B6197B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32DC2505D2;
	Fri, 18 Apr 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="p58pN/3L"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C024501C;
	Fri, 18 Apr 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014496; cv=fail; b=VaL0MAizTSXQjXvTDSGJMYTFOAF0eBiuPdWFjrTv5BVs4XeGOMgKe1VwE311+l8brkyP56PTNteaHDw1wjtPxdy1mQZj7EXqAXbDnyIMOsIwBufhyMh0Ga08MEKNqt80XmGIRJymPfKeQ/m4mYLVI4Dirfy4CkoNmbqtgYRCvRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014496; c=relaxed/simple;
	bh=K1cqUEZm5vDXwAmf88/Q2onqRGgHY7vEsZH658jGYmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLAOai6SR4lzFR4GAmJmj98jr73D16na376x1Ze7Bm069/8QYm8nshtV1RUL2FH/0KYDLWls0qBz31iAmSbpKOmxgdSsJcjTNKQnQ8XxG5U+uQ3kZJrpq2vXraA/Xy2jGXf03gfH84vVi6rkrZ8bhIWoO5iPGeIh+fwMLK2hKcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=p58pN/3L; arc=fail smtp.client-ip=40.93.199.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6ANiZ0OzotCfbKwWiZkfFu1suqsXniss9she7uJZyqqgmwl9rQ/xPb2l0Bd3bNcR3fPN1zJd/cJ7m+YqpXRr0Di14kgxJlye1e2vxhQVBLxA8oObZ0E2CepHTxTBMFTMnCtzRu7nhz+iTlU7nMtWv07woI0n6jb+8y2budLvp+H43QLGRjmV3rzuQFMUlZ5zssNG2fkClHGhJadecpMFd6/Bki689uACD/+yrGjKR2UN1O1813WcSXiBMYWSTK4aJ76vlbZfRM71jI2fPOvNqdp05EqZVTSXOV4caFiM1mXDgMcL3NlzTVomV17fkqyPSXddDS2etGAVxbnmLIxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24n+1lV1Q9C8P+askK5LlN6Vs5I4g5KvJWcdIGUynZ8=;
 b=cnPZGoNsE0B97w+53hctjQZozNrnY4MNvhZgRvYeUGxmMC4PHN8z79AdxuBM/lTVhuAVbzUiUALzXAHWK675dvfyGhiFq9vrQ1wCOt5Xkfp8kg+XSdjnHOE03FNY9yqWyyu9yr76+zkliGoa6KNy/XjqTHScOxbc+0ilsjT5oEHRq2PRxm/QlVmzm68mIQsfXejvgR16M403V793VnOSFEe7Cn4HjF+C4Z5nZTTF6zLHL+UMWXlSzN1F81YurYYYPeORICGQd7KeMpaoCDcZoIUQ8/2Qi4KmptE7fWfecKMWH0XHRqpH7SHJ9G+eSBLpIoPsRIyPNlX+Y7bDjV6HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24n+1lV1Q9C8P+askK5LlN6Vs5I4g5KvJWcdIGUynZ8=;
 b=p58pN/3LoMu0IzMjcrHTwx+jpMnIPlHdWexHKbzahvDE5xBi14Ddy8gPcyRZHsKlnH3EXiIElOdAhymXNwzU4pkr6sGnR4zdjbIDvLAgKZLMC6b89jLfVgoIQREYM0A6Pv2ejAaQ/faxw9VWrKYysy7OhkwR11ViDxJstoCw3nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9277.prod.exchangelabs.com (2603:10b6:8:27d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 22:14:47 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:14:47 +0000
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
Subject: [PATCH net-next v18 0/1] MCTP Over PCC Transport
Date: Fri, 18 Apr 2025 18:14:32 -0400
Message-ID: <20250418221438.368203-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eedbfda-6681-45e1-c1af-08dd7ec66df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXHMtwDIpXKuAYSr2pQ7vetp0xeU6OPFhaBG7CJ4n3yDkxMCzCd90GoVOeRk?=
 =?us-ascii?Q?M8oKngpwOaN09b/Y/YJw2S9hNyi7ykZawx9RL4qgQnDfc+9JZrwfOT5KeKm1?=
 =?us-ascii?Q?3PvyBYxplNs/jazueSCSoHgZpL8IEvoclwsObQTea0EJ1qm/cRctl76qPHGA?=
 =?us-ascii?Q?G81OP2ZxQlewlBed8x7hDuBRWmcz9aCrnU0YOThMG2RkQoTXb9pyJ+P/XTs7?=
 =?us-ascii?Q?UUrmZAgpJB5qz9JNcNS0Bzko0zrOoaZXOK6eloNZhTxcF8UcZRGuNnFbj5Km?=
 =?us-ascii?Q?h/6boUCyUGJPQPyqfaRLNX1tfYR/C4N/Y+cNp4AmEPeHhBDVZTNOjwm7p4V6?=
 =?us-ascii?Q?fqbNrCQN+iFcLP18kodIfXfzGr5z+6BvRNLaWddnau7XZwDuDOSUYPf2v3ns?=
 =?us-ascii?Q?rr68WWoyw7qZrVGaPtVDFrYkhuvUn6XrePMA9JQCKlj+N85lEzQul6SmzJJF?=
 =?us-ascii?Q?vGSkbVaOhuHuvsyZxpjTQM4wmd8HhI1pWHfiIJbLvvMtHhVgAJIn+M7HrJcH?=
 =?us-ascii?Q?iBpMXfexMs7prS6ZW0wATHL/I00oTaO33uDA4j6+Zixnce5XmkieOtZsuYYx?=
 =?us-ascii?Q?L5hCW3g3pRcbyqaxt9Cdgt4Nbuj6XULuS+lkNJpl6rdi6VD+uXlgjUb/atTR?=
 =?us-ascii?Q?4UpTYR1ZO74SbB7Z6y0HycZj5oZXAVxWb6TSeakCxE1jgmG+flPSFWzscnkR?=
 =?us-ascii?Q?MZe/+E6fD4IVKw7uKXeQiT9//tUNCpMv7UTI9z7bfxXnpB6kLRr1nzRgKRzc?=
 =?us-ascii?Q?K/ktQjcj8MXBAEnDwGb6AiLsNqOXSEFnq8aKcEdVBhvgsfBV/kmJFH0VACKp?=
 =?us-ascii?Q?moHW5w2AqvMxZgDfjM9L3loTc+baRXlS8WunJTBRy7bhcm0OT/GKMMR7q8tl?=
 =?us-ascii?Q?uuJZ0373rklEjl5ARfmf/Yfkq5DUnWsAAiArqM38EIJwHsUxMuev9K3iqNNS?=
 =?us-ascii?Q?pv4q/yAoIYSOpwZ7B1PwhmO+J2H4z0iHO8gWBhJOmArfG8waMGUOS542lIKM?=
 =?us-ascii?Q?M31f9xIBt1rELwtHkaHXFN6Al6320rJxcFjJ1QpGnfa5gKSKeD/e+AwuNFb6?=
 =?us-ascii?Q?rmIYm8r0JE3cbEi4BlaXFkQQafhMKVuSGVz0ixCgiMif543QOPhCpktkrD9K?=
 =?us-ascii?Q?y7SN2fx21uhfKyfcIePddrNl+uOFZ5pBTp941uf6wZBf9m1ZTCecp14CBNi1?=
 =?us-ascii?Q?hBpfemYphsQWBaEv4IHj7n9Y0V6b1XnWAgmq2T3KzKnq4lXgCf4r6HPpw+zO?=
 =?us-ascii?Q?3vQNJd+ovHC46reI23PUee85NC5XYHtWkv/OuuholRLSsoV5IXuhFcbxxjXs?=
 =?us-ascii?Q?srp/nV/PHblrDBzuATJl1cMTz8Zx/CrVuMR6Vwiih+u/OTv4ZiBvXT15m5PL?=
 =?us-ascii?Q?voOq4UE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ToZYs0wF1tlOwjOqVRv5u0BjTLdLkCxSuRjm77so2auoWyK909A+MbBHgDc?=
 =?us-ascii?Q?gAXGNlmNMNKanaPqePq0Z7D9ZmzbrsseYep6R7xQqPIFp7hcoaa2LsY0X/L5?=
 =?us-ascii?Q?4Kfakz0ZYpRKKHORTer9BL+KjI8Xhe+s/AS0kwDTHP06fSEGE7YIevkhuA+b?=
 =?us-ascii?Q?o0uJLw6R/ss4qSwp97qRaWaW1Rir3RZB0oIex+oxHt2GFBNnACgdxLuSW4K5?=
 =?us-ascii?Q?O/39NIptM5i6XN0ZC2xPoz2GeLBNs90l0PXwSUtyukT7CKwyj1xDbY5TP+u+?=
 =?us-ascii?Q?9M8YKfi54dT+BiGgsgTOI7szBK3iIQELn9oSHU+Ms9z2zEGQ822Ab4lNjBF8?=
 =?us-ascii?Q?Zfu5vemfgu+MS2X6fvrj5PIsVwQ2MpyBd9zR5SGIqIAWOQMQy5AG4ndxmqth?=
 =?us-ascii?Q?F4tR1ZFEkbLiv38YBE8yzQsxVqQb7IAG0GF2hfDHd7j22jSSM/QJvq6wkwUc?=
 =?us-ascii?Q?JJhC0+yCcbFOKmlEtKtCbfD9UyUxOTJFAsg7pVjg/yTSaVuOOdRG4XCpKmiA?=
 =?us-ascii?Q?iEvbo+B6lJeMYMboanSUZTuNn2nCag6mW+vf/ctGqHw5q0IK5RJc/rrYQ1ow?=
 =?us-ascii?Q?BtSW43U5ckg1z8F0OTWtwNKRu+O+15TwM5oDN06Ehst1nEfOWFkjxg0IMxiC?=
 =?us-ascii?Q?jSE6ndbpt39GjA0vpa6ZSlNEcdkijIZFRyapacojUL68dhPxWw2gapdgWaSw?=
 =?us-ascii?Q?kwea3fixUkdFlNR2gZoyDWZVdCuYiZ+wY6HGqsBezzcRj2gzKgJDx5x2O6kd?=
 =?us-ascii?Q?+EbEgYqLgiFvI6lnAaO24uUBJeQaH2LXnJ3cFkEpaIl4Q0UUb5mjHooYl8aj?=
 =?us-ascii?Q?6QuLcf0AtNIFYoup9lxrGOgKlfRgZAakMNyn87MWTcyuZY8FcO7Czb47Cdmx?=
 =?us-ascii?Q?nm3rdv3p3ULdEuJf1+LSAs32xmF9u2TlH+ncUDnSzdwjVLYnW6/X020Z7Ilm?=
 =?us-ascii?Q?YTKQid9m68N7IQugWmEZEd0RECkUBZsvHScbyCsNYSQ9+mNuzC7CUQu17qSn?=
 =?us-ascii?Q?TUnIAMtps4wquI53+SwACRssw5EM32GSqe7USX2IPOmNr2syCaS9maeyOR2T?=
 =?us-ascii?Q?5f3roL2H6qUcPDoQiqBGx3U/QdrIMpVlrw/5Q09euDx0KYPWdh+PTw0di37t?=
 =?us-ascii?Q?ANkUcEPjY4ppdiBAmCn6L82/E2at9MfNvZ7zZ+ESzPTMENsKNtS2XPgMwg97?=
 =?us-ascii?Q?SDjSFdmyjOnexstGYNKTK3wHQPHhRHCfjD7MOTqIuJFnzfTtpm8A1lCwRrlK?=
 =?us-ascii?Q?ZDapzNxz3N075ArKjZLaj+gUssNdCUMyqTVpdhtJMFIgV5Z96iDzmgHZ5341?=
 =?us-ascii?Q?P7CXzrx/dNh+2sTwlkSJP+8RUSj3d8SrAyGtKrpPZUgcLt2BzwY65mK1TJ0c?=
 =?us-ascii?Q?aEHOe63x3CqhBjHFvDuKpYQd0sTtDRm18ynfs9YCUDVFBwSNyhZojEmqAhl/?=
 =?us-ascii?Q?sDt+R/2v6tazszzu89D2WiHc+nSk8u6/VWSxbZ2ImQU/pIQZjn99uwNhUEl8?=
 =?us-ascii?Q?cgrUOQ2kSzkT8QPjZE4pX51td0fQSCFsF5sXmsYNwccsIPUqGrSzzEQGtkuK?=
 =?us-ascii?Q?4MLFO1iAR38Gqq95XaZePYT8j/bqSPD+rDaxvkXri0Xff+uFkupezRnq8eeU?=
 =?us-ascii?Q?Xj5HUF3DXxDqEGtLB0YCU27Q8Eq7WkK7sGVRGmXAGvvi8GnsRjTFu8DysVQZ?=
 =?us-ascii?Q?bdQtZx/jT117Wl5RG8se/ZPO9Ao=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eedbfda-6681-45e1-c1af-08dd7ec66df0
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:14:47.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTaRYTimQpdcNBs7lyOxFZGFQ4tQQvt71g+6r8G09Xz3MvV0sfYjWCTnDC0JCa+5Ey/UaOn54aYuAlQ/csUWB7xr7MPT+a2TyBBOyt8w/FU9/FOpNd+D823EW49W9Ugf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9277

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
https://lore.kernel.org/lkml/20250205183244.340197-1-admiyo@os.amperecomputing.com/

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

 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 312 ++++++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


