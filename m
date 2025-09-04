Return-Path: <netdev+bounces-219804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC73B430C7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF67C1112
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFE223DEA;
	Thu,  4 Sep 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EGZsXSNQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8D13DBA0;
	Thu,  4 Sep 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958756; cv=fail; b=KgT6HsoyhXi1vGx3YhsJJIM8GhS4amlWk4v6ePsJXjc+s6BQOFTcdAKNIEFYQLuo3rV62TW+LNpvDtEzDhhmJQDXUeBeiavjCOmWQpIad4rKhNFJDDDW+RRKYOUGNXVGawp+b24u8bg9Vkk3s66Cw9BZTO/LwvfhTDcKF9kuHUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958756; c=relaxed/simple;
	bh=pPEpN1PKmtnD4f3oT4+YYMvVhIjde685qpGEPDCxhv0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gDectrk8ZvGSD6lmil/QLv4RzNX/gjwTWRaGm3SfePdQEj0SsRPpi25HaWoo16IHPKiWw8SgvmNdpbQlmRTEGeN7wWjpUpU+mnnyWTDW4ukTWjzuYYR4TRxmpLukY9BxJ2JZ7V4gfmsWknS3tyedpadwH6TmDXS/BEQyAZZEGWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EGZsXSNQ; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcOdiBboJ516LNbyJZERiFZW3izuD0PzZtW/0zW4Y8u0gaQj3mYCzVZjnoLgBkf5PMaFXpdjX+t0B6Qmu6Y40rEpw96zHKIXGrcQOo7KCwQEgTwe9oE4Zh+rCRyz9N3e3F97nNe4ke2aZsKobxbYEDQJ0yrpOC1aeg3slolLXKfHgRJSyuv5c6Xnp5HCZUvfsLyPcrvf9oVq3m0DwyKKUeJBO+qm4QIeG/EjmEvGSrYG4V0YgGBb89scDz+eJ7Lz76r6RO5/bE5/aAoi5ZB6MdYSBhfZFvIqS7PBZy3BIXghODfSJY1CvDGPdacwv6hsNhnSPqWofgZLMEwDbHZcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2snzQXItFfLMrfxLMI018hcVBG/QFZ8wFlMUua7dMQ=;
 b=I46GUsv4OFUb/lDq15YUbpJAnQZs7kKvPoupC1FSZynJFy5ysLzdrbZzNx/ezbG+DnCrJyJiQwdX+mXBz8YQnNS63eBJHH209nhH/I3yfCU8FjukxG0tsDc7dQH8BJ7cVqaHfFHjXzUTafKFN5HDe8lsxRLayq5fygou5WjM1G4wLRGrnj6H8+A8/OJUPCvtTczTiV69DHKGsIQetqAP1qJl4RG3Wq0jvB1HFGmYlpZb0H+J0wvs29UM+aBfuNUUhW1/++d1t3Op3S/BhtIm/GtjBgYCjq0e/1AlZ2Aeij2yOCXvpYQl8bxTJ0cedTa4PewkV1aWOjHDE85gqt1H4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2snzQXItFfLMrfxLMI018hcVBG/QFZ8wFlMUua7dMQ=;
 b=EGZsXSNQ5peYiptmD3IN1ed4hCcqEhx6PYE03OZ73jwg7EU1g2FdUZW4rLwY8EiRfkT9auoUTSXA3v3S3MTOZsy+v5urZxAQ9NL0I0LmBIAIyBtOCqSa25dvBPkmGTFSKshOQwz/JLM3oETt8x/SBgYgcdwOK/OeODUg8NHx2AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH7PR01MB7559.prod.exchangelabs.com (2603:10b6:510:1e2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 04:05:50 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 04:05:50 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
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
Subject: [PATCH net-next v28 0/1] MCTP Over PCC Transport
Date: Thu,  4 Sep 2025 00:05:41 -0400
Message-ID: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:930:1e::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH7PR01MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 932c95ed-824d-4b8a-0543-08ddeb68555a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3wezGUBVDkfj4vyjA9HZp9UJhyVZYZacAIQHTqrQgeVgYvABPXxlsck6FgF?=
 =?us-ascii?Q?oqFfBMtTMjV0geGDrrdfsH4XZjYpXLB3APpb3S6nZ/V2PApm3I2B4GXIIfWe?=
 =?us-ascii?Q?ZezbtpU63XI1/Vplvl7UGtN7B70xLkrK47v/QtuHzVRYc41sgpxMoTY9dJAW?=
 =?us-ascii?Q?6GgI/KuM7CCcXTeMBMLWbAN+p40OgPAX8F8gcwUDRJYJumjrrC+cIxHIyY6d?=
 =?us-ascii?Q?mmNbk8xYX/jQgbC6AwvoG/cQpiQIc1Y16KbRJ63y5x5CZbF4LK6XG1OazReF?=
 =?us-ascii?Q?jaohVnoxPeR2Q/krxmdNdyy3jwX5Vfx7+wLuY/ftWoL5UCrNCu/9K+OumIaY?=
 =?us-ascii?Q?ILWcJy8k6vfKtJU9lb06ywXl1rdvUpv4KZ6BJ2yv2CvY8h6ZDlF9FcHb+F3P?=
 =?us-ascii?Q?fpQ7TsPn0G2nIfXbPAjN2y0ip+Zp/UA6DqCxs5m3dvPMcj/9m8isA86naxnV?=
 =?us-ascii?Q?pGmuTIRCuUDtvyhmf8pcM1qwcrBpIg96mOg/BXPi4VSgzSMZ0QNISGLsgLTS?=
 =?us-ascii?Q?e1JbwLI1QsJAAh9AbLKdohxTFzoT3XcBOr/3gKOdIRvflaUdMa2Y3OSsSKAx?=
 =?us-ascii?Q?9uZxDvIZ6gZu7LfVBblBj0C/FlpcwKrI1AYJTLWun/SYcNnrQMjxt5ypUW3Z?=
 =?us-ascii?Q?ZhDEyf3bm8d2+R7+tIStCkGD7nRCq/A03ihkyasQqlNHMDyw/6lDt99BD7ui?=
 =?us-ascii?Q?Qaw0rPIPj4+Eh8uYud7mEuDI/5FY3DWBITIP4EAgUhggH1/GCjyzZMNbuI4A?=
 =?us-ascii?Q?p/fAXTeljsOqrmxXf/Gsxzu0+y3nqmkmdkldE0cUMg92zBM4JsArEvdjD6B8?=
 =?us-ascii?Q?Pz26ib/r/18mw932n99QBU6iLid0Kx0BVbhZxP9/wjWlCGhYpU08PyrbDAsY?=
 =?us-ascii?Q?Hnsyzm5hJztkbCPVquAhx4p/DqzIphwj5+VkH0BWIs250pXFhwLBea900AiP?=
 =?us-ascii?Q?e5SxFF6JKIqZaPo2S0dzcqwLXkC5ae8KFW/vzxYlbWkn7R7HQUXQk9W9Fhur?=
 =?us-ascii?Q?okq0XcFqdRt9yOuNHX8cggQLE4/7V9oVwFqUa1a03J0fylI70oUNRoudMYoZ?=
 =?us-ascii?Q?oyH1T+mw0bbWmFEnzAsVjWuDWuYpK59/4N44vUhS/LZwtjVzNi0wlcXkjolr?=
 =?us-ascii?Q?HGzPdUTws2dao/DSgHmOxo0TYfTQjx1DPkh9j6e/3CjeGb/BbyphgQ7ZvUOe?=
 =?us-ascii?Q?Zb4FoE4BlVtjbzZwUR3dIruIpMYnvSfkX6io6U1e/B2wPmq92CZeOIZM2995?=
 =?us-ascii?Q?xO2KHXqD0dH3H8YWuN4lW3bO5A/tnYxTV/UlrdKt8fY9sRoVGpe76hiPFPZX?=
 =?us-ascii?Q?QZrXHeH+VLv3B8RbagP2Ivn6aYokCkfH2WvuDBkvAHW88QOlLbyeufXloK6e?=
 =?us-ascii?Q?YKTXJ6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31Kd25dDkyvHr8LmRoAm0U8rXoHHs65bbzoFkJJ/fQwvR8xIAUOK7jDIUZKa?=
 =?us-ascii?Q?Gqy+o0xuj7gn3z2F2ckTFwDe9wKDBCwZJ+SKRdTUNt8nLxohGDUaYpOsblWl?=
 =?us-ascii?Q?u5xoQTMZPsoGmu8W5I9cD5X0viZKUU0a/nlO+xebVDC+Lo+nzEDwql4MUBtZ?=
 =?us-ascii?Q?qM8dZwTU9xkwvnX0CPY+upRZR9M3GagT9Tnku+vghzpzJb4WMJnGzYmJET2F?=
 =?us-ascii?Q?h48a2UCkGuNrd2DInE6qjsdu9QS1YrymE8+lSfppjKIf49JqSmCOqXofbAu0?=
 =?us-ascii?Q?xztn9yPIWfXQkKNs1eK7VWxXExdPJ6ojD/1tP1sZ3xnu/BMeC2LclfJ5Jm1Y?=
 =?us-ascii?Q?5LXEH34fdH8dicq6NerDIOGY/grAMo7PI+UTS/U90Y+68dim08eNW8ca0Rfr?=
 =?us-ascii?Q?5qmnqe1s4Bb9vraGkRJjwqKOHvlz/F6obiz1NQgPfVP0wXdjyayLoyd5rIZi?=
 =?us-ascii?Q?zBYUkltDypNeTKTiC95FmRM0Y4UrSHyTd1ceoe5GRqnaJ83Phyf0f3xtaugJ?=
 =?us-ascii?Q?Y1XGRtEY/7wtqBR5QzlrV7GitY+9pIVZVyZKEgBALevc1O8QHk2L9F2ImDDy?=
 =?us-ascii?Q?DDwrLW/BNFuBK39jHEDw/a8AVf9F7c+9cl/Dji/qu/DCV4W9QzUZWYLTgqZu?=
 =?us-ascii?Q?vSwKH44mElSlHUlyfgEF6LfwqxyK6Zl3600xr5WbzKEOEwdnzQRT9BA3W6JR?=
 =?us-ascii?Q?+cCFQG8EgFmVBs4pnokBKvAukLcHfOxsEbW+StNglO8ggBkDHhj30Jq3Atr4?=
 =?us-ascii?Q?GcwzU67w9qjar2aMzKIV9oJvfy4QWTOebK9TUUDgMbCCZEgkl2Fo7ipTbWzl?=
 =?us-ascii?Q?1fusjKLSnTBAbrNej2HhYEia/wTgOH7d5Ymsf3frqrNOW/MI4Q3nd6ewBEn3?=
 =?us-ascii?Q?T6pOQos8XdgqcDFVXJ4LOprevxqmGJJInRDXdEs/BYufLzEQghyajdEaMTi9?=
 =?us-ascii?Q?tBbHzUAheTH+z9QGtdUC3t+FtItzyhIliEeUZEwytuMePnDMEsBhXitrELL9?=
 =?us-ascii?Q?D0+2hIsIi98a8yAvLqINZCq5OCt6Dja7dNuLE19FsG2qUpUV09Pu/ikqSv9Z?=
 =?us-ascii?Q?0IAz7aRTQFqyFXnuJOWJ18s4TA9Kv2F14JXNdZWv/vUdWJqqrvNweee3IJdX?=
 =?us-ascii?Q?vw/JTs0TuDZHr1O+SByPsT1/dX5OdHIFOVdj9WwUM/usIlhcu922CDgcg/jk?=
 =?us-ascii?Q?AQ1tC01gtaresPlJrX4HzNWOL+ZpFivhYphBWRyOMk9c/cBpGW8RTqeSrEQh?=
 =?us-ascii?Q?YSDGVK17LWDth5cv7YJRRQ4VTgAEs4ElRG+Has68tRxAzJitKk47WjG1zGRp?=
 =?us-ascii?Q?VGKpvkmIRE4Be2wFcx1bL/Q1B/w90FJEivAp918nsH9xhnFqxcMaZmP1eRFV?=
 =?us-ascii?Q?iBRuwlpZ1W8eMVKrBeXVbsOeTcCtQf1hHaJTgvPb/iQuVjRT7HilL4MAMP32?=
 =?us-ascii?Q?qgrmwkyId4m8dTFBje8kFvMv1RkkCtJ6oRO41iYDsaGC5xRNFUN7xUOxzfge?=
 =?us-ascii?Q?/NJuVs++20rAs04NXMvDnKd246EUr+VH5WmEmfu8taXfufO67PJ/UkukiSwE?=
 =?us-ascii?Q?65DTglCQ09SLjH+gbNJdFWL361T6f9wWiV07gL4UE94PS1M2SkWuDlppAUYv?=
 =?us-ascii?Q?rxTdZ1R/XN0lBfrB82MUf+TkYFoZ90V4K6Uiqr3Pt9CVwKk/cTvJ8d9FSPtK?=
 =?us-ascii?Q?zidMC0gLV4ENTExn8kl/NqfXDBA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932c95ed-824d-4b8a-0543-08ddeb68555a
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:05:49.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybFfOj8gUnHSWAKHqdBXzqLKye2LCWA96DUluj08WAMiOczeSRwYlJfORDSK/fljJ0XhASGSySo777MIQFSx+DiYt5hObnO326qp0GSOZDt4xoL+Ba5OkQk6DdzoAa90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7559

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
code and missed steps of the PCC protocol. The first patch in this series makes
it possible for mailbox/pcc to manage the writing of the buffer prior to sending
messages.  It also fixes the notification of message transmission completion.

Previous Version:
https://lore.kernel.org/lkml/20250828043331.247636-1-admiyo@os.amperecomputing.com/

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

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
 drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


