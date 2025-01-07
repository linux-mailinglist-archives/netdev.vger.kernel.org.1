Return-Path: <netdev+bounces-155983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B4A04832
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DA97A3198
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514841F37B1;
	Tue,  7 Jan 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ACAoQf0v"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180286321;
	Tue,  7 Jan 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270870; cv=fail; b=BVNF3AOi+y7LJ1L/OF4BKqJavKiQcqgosvWuJcKtgx3cjCLmnghJc12mdGPcfiW75+jx73JihfmO4genvftSEpglzq88/Bn3+Ouam+unIYnKwUU2Z7G5VsOSVkv7yzxmCnIxrA5EU2U23gosQ57CCKmRcoZt0lX+++6busOV5NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270870; c=relaxed/simple;
	bh=qChIB6fWn+1PNzVTJLwKfYWfV4bu/FlDItrD310Fcr4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P8KOkGbPMqp+gibZrBQzRTLChIC0kQksHX4KG6cT/Ogb9SJXuKpYPVERKppaM0cv8rQ36PYwrU6P64uWWP7ncBPMbNTcYEWt26SFW9qN1mH8EiJ5GjYv2mbeu6gVm9t9wWFbyANKtd9+LaKhyDazhwugd1es/wWkFEdVqpPG6YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ACAoQf0v; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeS16NA7LaMDpHiS1UkWYS1VKDZG5xX/9luKcC2I64C9RPzinrttg/ZRsAPf62iLlf4W56VhwRDWxVod8Po5zF7Yk0xUaJZH/RFyVBodSjNEbwOMXPG2uGfWL/PYR1bIFGh1a3e/d6+HwzeZcnIRC3ID/YUqx8lhaTblWgvdvWwI6v6Od+K+sila8u8D7vV5KzbpzgoqIJTROi3p/fQuJG1kXGLafp4YTakbRinwuvqXn0lPn2VJyuzhrH9XC/IRItn9K5/0LuNqiG+i0toGVOMwQhB2m7XuNhNEWYSfgkFQGhL4vVTsEcpNMMDQ/1EWOsSMaGvCj9165kASkD6ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq3wc9vBf5NT0FSeCrYm5dibIvmeDaLjhb0P3EKGWQY=;
 b=Ff1Dp4rpTIeh7xef7zNaKhjU4ceCqxd/gsueW9TwECl4zx1MbjHW3K253Qq4u2dUoHALm4631PEhnGQ3T3RfgeaTT30bXUwQm0LnSzeMGJnUg1249cketAvQ/chraj9OKq0MgtTwz6aW/76MMpvwxEoLKX/mdRvcWt5XSzfSt8ohD1k0eyKTKBFYXuDLZH48IeQ4e8FwUHzbC/SuKBX6VNRdFZb3oqosrT1m3adZrsxw/OpXRwTX5ThrM2wNftfwthG3pZw/M3+yWVVwmPnoeVSOn5k8ZJAZedQOlFewQo7vIsKWW3VxS9iBzD6Cc+/2xYo9pWJZVRGvqiaT4juYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq3wc9vBf5NT0FSeCrYm5dibIvmeDaLjhb0P3EKGWQY=;
 b=ACAoQf0v209SArWXDctqbOKyYtdZogpMaaFTyrcfjN6CexMuC7y8/MLqE2VO042i2WKFFfB97VHQZgs3Ruw5g3s/21Yv8+6WkuangETM01F7pRftqAdaGiRzUdJoycOqKGl5MS//OKU7zd5JvMX6b1TKWdKdA8ojIQRsMrdcSrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW6PR01MB8344.prod.exchangelabs.com (2603:10b6:303:23a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.9; Tue, 7 Jan 2025 17:27:39 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8335.011; Tue, 7 Jan 2025
 17:27:39 +0000
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
Subject: [PATCH v13 0/1] MCTP Over PCC Transport
Date: Tue,  7 Jan 2025 12:27:32 -0500
Message-ID: <20250107172733.131901-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW6PR01MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5c7d37-120f-4bb9-2e86-08dd2f40956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j47s1kU9mqyf4jawkNzxBwXd8WbTJVufA+ToR38Z1cL6Im6qlU7o2jAtRWUG?=
 =?us-ascii?Q?UxeoIBeiM+Hsphi0EcC2r1LFpgWWZC3qmi2MCD48U9o5TsnWOPVjq/vHSUV5?=
 =?us-ascii?Q?2pm1pAf6dpkTNO72fYpMV+j3l8CREb+8+vu6y1Olkvx8b5sCtU7Gj42fLcXX?=
 =?us-ascii?Q?Iu6jbvS4or4wdinJUYWLrpXYlQby/4oJXm9kO7hUnEd/Pu8CCF9UAfk7Pw0V?=
 =?us-ascii?Q?Tt6J2tqyLG/V0eHWLI9hj0PTRFIkweGpor3kQi4D9opYJFhjS0HD58WBMpwC?=
 =?us-ascii?Q?wi7WE/BqMDbokyWmzRwDC4l1zPr7W7A7OwIUEvroHlV0mqqqc9i5DXD0JMGM?=
 =?us-ascii?Q?t9KLaBcoktyHgoNz3L+ZSSGgRxYDpsBh6j/sEgJOcUMJjL9PPGa2wJ/2pMXr?=
 =?us-ascii?Q?REo25T8uM2GAVl52HNvL+lVrO/GWE+iyB1KqGkT0ChF5yfviVPY63AKgc5wz?=
 =?us-ascii?Q?ek7+cf8S1fS/eh38xhLLa7RIK08ORf5nka3/gVa//XQM71fOeA5UOw5pORNp?=
 =?us-ascii?Q?mG5nektk7G90qpR3CaFONTnFtCI5lgPB9dSfMhOHNWo071jyfDSQek1mDQSt?=
 =?us-ascii?Q?BKiGzY/ehWNTRanqlyunXH0b+RlqHUWCKf2BFH11q+ShvQS8qJDABSwTRinI?=
 =?us-ascii?Q?t3IrvhqQoaR1n26QWSlUqrKkxbS85Lai6EMnIkVUV0GHuKab77zcCFKyBngA?=
 =?us-ascii?Q?VhpRnbHfRpCFfToPKMUVXMXwbh6InMomkdZJX6xXDtB3j88iPlOhNXwIl1SC?=
 =?us-ascii?Q?sAaN8N5JQ8mkQZHz7K3dFI5Yhe8iTI/uPhzFDLk9Ih6g8Y2As89a0R960c1n?=
 =?us-ascii?Q?SSIpEzs19v/jWEJWaoGO28MZMJJEwELeZAfz/BHiT5s5/wt1CImMkHqCguOT?=
 =?us-ascii?Q?UGzUaX+DtL86D7ogwYqk5N0cv2BzagfIAQwiZ3op7qdaMA6/80hv4yU7RZ1s?=
 =?us-ascii?Q?Fzacp74INTnRZFaQJ9E7/RcyTKuhU6Mw5i+UWALUHqdBZH7RkeVBF9/EdIpt?=
 =?us-ascii?Q?JAS9TD0zKyQxZyQb72xI9iWxsmykh+soVE0dswzmDe9NkkMR8ikGKcPM2qAi?=
 =?us-ascii?Q?JJFV36nACY5z6iXCQO0ggVKm856yl/TEdW8nhROdPt5HjPNA3x0eoE0wyx99?=
 =?us-ascii?Q?qIdNpPmRIs8t9WvwBSxdPAeGXGRAV7kMT6f3kmOBTF0vBcW6AfgbbR4oejFE?=
 =?us-ascii?Q?mfZH9wysEe9rWmsqKJAAREVk2mnTrItzr0aDSpMwtNnU3Wq9KvQlL5Katzyl?=
 =?us-ascii?Q?9bGU8kGuj9oS+PZvMp2A+5ojprpOx2r5mnxx+p5y9ENTPh5LVcTWTG6UfGYm?=
 =?us-ascii?Q?p0/LdzLS+yuvPB0U86rmqqccPGCmW99RYgcsKdpXyfhgWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h83ERnCVyC+Zvej0G1X0xH1JGgGBSmDHqAv2LCmbZiMTkyQ84zPbeD8fn4qg?=
 =?us-ascii?Q?iq2xENmzLKFkc0tU6NYrb208g/oS2kXFK+4EmtqXPM+f0aMfnfxZRaKtdOgZ?=
 =?us-ascii?Q?diTsXr6FFyqj49YFtzFh4EThsQlGmBArz9XM5l0dfy8nThiT8IcVqRbc1SI7?=
 =?us-ascii?Q?50PQ7e8FLfa57y4ra1YWWhUdkhJ8bQQiesJ0Q89o6BQIg6JCp2INtTWASVIz?=
 =?us-ascii?Q?TprFo79Kz5VRhQoPKO8I8dxqkAwYqLmbDNyxChB/GJTgPswoH/C9pJbymMjP?=
 =?us-ascii?Q?zGMGJtWvCWwqG7Ut7TY07MRHUEUBmV0Vs5wIbxq/EtvNOj4XrqVXv/az+JUt?=
 =?us-ascii?Q?QSCMKkj6I7jAHbt+JY7f8NH1itkcuN3/+3p5otAJvvMNjP+2L5HZp01f/et+?=
 =?us-ascii?Q?SX12LUZG8vv0Wi5GILMCQEurXYRFGm37Iy9SyuavjFRLNexax4Tr61UarVMB?=
 =?us-ascii?Q?2LrxXrySDnkn5jyJ2BDOsTvDq4yAfax8lzaD7wujeocWNAGPCb7uXqRoHNQM?=
 =?us-ascii?Q?UJEWTn/YU/Vh93teYpWgyYlqF1UFhiKE2xjnplPglct2PaKUPsQNvX2vpOYS?=
 =?us-ascii?Q?1iwhBjHI3DHGyCPuU7iIRVkjSXvE6ffmjtnSwDVfLu2tcf591QmUSTbInHCF?=
 =?us-ascii?Q?aGoWo2hYe9an9/WLTfSLnVt3ZXjAD5s4w2C4WKSFJy46Yho9KZ8k9746Smi8?=
 =?us-ascii?Q?Ppg5DtjAZUCkaA4GSO8ZL/RgDQxCetJywvKXY9QKwnkpC6YG0R8Y1TrDDAcN?=
 =?us-ascii?Q?oSAwJ1uEodOBm2lKEMXhkMh8rz6RlK3ZdGZr6Cw95t7osoTWV8EjeAehlU6T?=
 =?us-ascii?Q?ly9UbW2MuujbiXGknv32y19gK19i1mqr7RndFEEtOK9+JqWJHrFMDb8q+cLQ?=
 =?us-ascii?Q?v5tWs+xb6cBKy58uRcNmYdG9NjnHwOyMYKitLlHNncGdSxoRuS8ih4LJyQ/A?=
 =?us-ascii?Q?IdBQYcCJ0ESYKqpRdKDP0LbPNS+Lm8tGhru5qM2KOUhv985jmj0fiKJluAI+?=
 =?us-ascii?Q?S8c19aVVlsszkIqKXHfG12ABpaLZehSSzX3IamTvRRfcTpcytHA9/XmzE4cC?=
 =?us-ascii?Q?h2NNUZgQrsYDbOYREwwqajD2yVK3Dsy2XBTpza2qfWKfP5J6JMIyELcKrw6R?=
 =?us-ascii?Q?SpOOZ6AgieKbiV+am/8mFGHBavsZcakAwO4aOOFVIKxQxKwO/v1ixYJwLVm0?=
 =?us-ascii?Q?41tr3nJ+ztcEYNHj4TmdXMm/91kfnX2EMw5gFOhUUZUesmPkL2vXeTBtbfQ8?=
 =?us-ascii?Q?c9OcssvfDE5PrVGuihiF8M5kmfvPmQ0SwCVK6723fecr5Z/xHDP4ZzUJDl4W?=
 =?us-ascii?Q?LqxABgkJIoWNnvqZz58ewxBC/YhfY01qkMiEkI3TP9WTdx7kwKs2eA8STlvi?=
 =?us-ascii?Q?43ZOvgz1zk4AM+22gcgEYa/53R0yr77AalWnRV6Ww94+PtJQCNMfIyvTmku0?=
 =?us-ascii?Q?Q7Q0+60TdFqQ1IYEBtt7GVhZu1FGwwCRB2iurbih1pPTaYTEQm+uca2H/1cM?=
 =?us-ascii?Q?B3HKTZcSDDpC2eZ8LM4UK5J0oz4nnUQ77cd1R/zl9UQ3JPg2TFF6YWVE1oox?=
 =?us-ascii?Q?FKrTU+qqe3Co4tAPLqgoj3IYgauTPy5PyYMYNN3B1aHp57YqjR+i9uIJVVqG?=
 =?us-ascii?Q?WUx8TfJTRGevwLErcveCC/PEjRAtdhlYycMo5JBVW4D1yihCOY2pMYWFLctH?=
 =?us-ascii?Q?wdXH/M1c3kp/OQxDc7BrivIrfzw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5c7d37-120f-4bb9-2e86-08dd2f40956b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:27:39.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2WLsufhEH2UjvdLKlgohLJYGPe2qtjTvzc9yJz/fHck76FlYIUwyhHV3aUAarT9a8FgJzC+6mA6tWIvS/q8bXkO2EckifeYq8UjRAuDKVAS/IkduPNeo2SSviORZYRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8344

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
https://lore.kernel.org/lkml/20250106192458.42174-1-admiyo@os.amperecomputing.com/

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

 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


