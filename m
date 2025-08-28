Return-Path: <netdev+bounces-217599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A3B3929A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BA7A43D0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452AD1624D5;
	Thu, 28 Aug 2025 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FheoHXJD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2097.outbound.protection.outlook.com [40.107.101.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11413367;
	Thu, 28 Aug 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355623; cv=fail; b=ueVL+yCRGC6wTnqPly5Bxcw82z0ROa4PCAaQbwfmryrtJuxsgB6LWwBm7UOCFn7eyg7Glj+8p/+bWUM44nAyE4YM523Y5hF0PXSCcqE6xKgSFdomuOI2HcUEv3VExtrlQfs0JNXaN/PR0xPnSeREOgafXdodg7rGh1ySyg23WF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355623; c=relaxed/simple;
	bh=gxcEBVciLvc8p32hJ+O4QAJO5f8s8sWT06ZHRfJ22Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U11BGDK/rs6SuO/KzVz+bDNwil05LoIw8q6TUCcH/1YwjGQLPorO+WcdWwbdGJ2g3SWjT/tfyOtc1J2RoLeI/HiFXXswHjSnaA1xo+eTlBYLtOV6F4oA/fdm5POuW1lBAHcd9Jwp6e370H9nnFmS5BiRkJIGBVE19rLjyo4jiI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FheoHXJD; arc=fail smtp.client-ip=40.107.101.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCEOpil9LJGOxcZ0oCMxN1aGL3uv2jbgC8ibvhLno3GuGAu5L9Z2Tq2P1XaPrd9HyQhTsoQZLpHMcjlBYCn2b7CccQeZ2y/kFQZdAU/QTVWnPQviTydczMFe+zicSAh9Cupj/vD8n7dtCCrZ4++OZcmlYaa2vxQ+nCaw/3uVqr9l5pDlOUZldbCOmlO4oZIpNmEhIdaZsD/BvvSrx+2sUNtSZLCyJs3qCVA8A7xXoQ9oaa/h7BGTM8jtpNcgU0K7eE9Qb8NZq6JNfxwYLjliDGoq68VNDnUkn9vVY0cKuXEGa+pS7YSgwoKWnHIdlJ2XH4heN6LhFhMU52sQggBtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvwWD2KiKjLRwxWB9joUjYx5yn4fKSH0TT5ziwhJxGA=;
 b=wI6QV0r2xRuk1FPdbCagBRLFQ48ZT4Tqm+FqZeB4DzBOPjQbc6YYMxhq1lk3Tv4DXsNiPVvFsniDsgTWvjLmdA1Ch4rQSpm3FBVwEl0wXVQO2sVE8gR+/ShBpuak4ZLaNEmmyrz3pBujqSSw9DCzyWllNHA91YChjfuUKDF3QKtQ2T8n7SiIzWTHd61CBD9hN8P02azxTspUkQdOo7IkCpow/mx7fZr8FRLIKqsV/XQ9gvYimhsjB4hkR1yHK9FJKaQorOb2G7EsFIIiLfXod7LXM7H5YOIwK0S9FIn5h6cFjFP21iTpmzRt2NWbiLD9VxPm7syHaxM6K4jXvUojRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvwWD2KiKjLRwxWB9joUjYx5yn4fKSH0TT5ziwhJxGA=;
 b=FheoHXJDu6MAQj2eDXI1qp+1syMIZwtXuHDsAbgV3EgssF/CooCc/pbZTPb+Js/925gQKlU2wfvLFoxvsEiNcr2fwEIpX4SAvOAVnO2tiUJSYhiVMvCqI2nVGgL1msY7Om8qZ47gUxvusio9yF+iC0+X2Y4WrvQO7t5VpBe36xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6263.prod.exchangelabs.com (2603:10b6:510:13::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Thu, 28 Aug 2025 04:33:37 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 04:33:37 +0000
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
Subject: [PATCH net-next v27 0/1] MCTP Over PCC Transport
Date: Thu, 28 Aug 2025 00:33:28 -0400
Message-ID: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: e343edb3-6a2d-4d57-1c1b-08dde5ec0e44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhanXr4vVXA0a2IUDX8mDOYN7XQAnlMG73yoNsa0u2rDZOsQU4rO2xXbtUGh?=
 =?us-ascii?Q?Ga9X0bYLOsosJaKW2hB1+w/+JlhbVbVtnQ0HSubu3rgOELTE6uayF0xHDmUB?=
 =?us-ascii?Q?REZtm/WM0dOnuStJabJk0ZAHJGAFYaB2XA85tHrEFIL68bSzdYqlEXoQ37cQ?=
 =?us-ascii?Q?IBPBejBwE15Y62ejqzlo8GhiXRT3KIbhLaiH11LQn8HnsP5nUv3aFi5xKkXM?=
 =?us-ascii?Q?wS9xJXZurjOkZNJqKgL8NvcrPlx+McF6IyGD6LuvFLkqiMAq8DMVHN/PNR4A?=
 =?us-ascii?Q?ug+KXNu+To5i40IfXG7nOLPByzSbSK/BzczzCmmYyyCTL05aC4vQarINd8eg?=
 =?us-ascii?Q?bYY0qnJpxPDeZFJ8FuQ0OKamLRYuwtDFUiwi/cawtCycdaapa8UuJHKD0VIl?=
 =?us-ascii?Q?xw9lnlbvumm7rP2AiDoUbvosjYJG3dwElzO34KKnou/X+nqB9Jb02NrsTmE5?=
 =?us-ascii?Q?UU71+uuvEyHdWHlQoUedU7v2lQeC1PhUt7BydPU42Ve/3hccgBRaFLZQL7rg?=
 =?us-ascii?Q?ySTExjMAJbDqbYu4uFSPIX+pGYntgwuGsvDhnaEW838CSagN/2TpCgyGaL+l?=
 =?us-ascii?Q?eeF0+Ml+w1kUA5PXKdHEbOoheXeYUXljN2cah53Mc+EjUZSYxZqzgJNbsr4q?=
 =?us-ascii?Q?2ePG7LlfyVPON/xRdaFh1/aWN08S4rn5vXYBDDVyDveZSw1NnY3V+Rjbg+yL?=
 =?us-ascii?Q?2og5DEL6m5vmOV2BdWIxf1011fxJ15a60PfMelerxsb6vEetxes4oWaT9WXL?=
 =?us-ascii?Q?eT2XMdp9fwizvSczoTvJeLNIxHuCJVSbDN7ojJmQRRqbwnkvVTln6kQBwkSM?=
 =?us-ascii?Q?XEfdY4+wrXbIGcaPZK7tvM+saM7gL/jOOTYrPWoOspCrjN+b+8Z4/65Jafqu?=
 =?us-ascii?Q?/o7/1wHvllv35AlWe2WJFPh8qaYuOv0H94i2I68KfQ/OjvZ+cqXFQ4o1lm/g?=
 =?us-ascii?Q?U/ohlhKS3b+cqVfn4rJ++p8yg+K+PwRSKTH41fD2P4LOaC9KspN5OyNFbeL2?=
 =?us-ascii?Q?gqOOG8f9WdqIDCdXLzg8C6I9zQ6cOxPjnjx2KIPcDB2F6dqNeeUrK5ao+eB+?=
 =?us-ascii?Q?u/PbuqPiPDmzVXfQ4D9gYklOYRlNUVPOrQXAJtbt/2sGkcWbhbK9uEoZhmC+?=
 =?us-ascii?Q?Ir9m6dORTXFTEC7yBrK7nJ6nCKcMsnIM/VdZPO5sNuip24Zm93CbfHpPg9IL?=
 =?us-ascii?Q?cVMkkz2sooWx07dNUjA+5QaN03qFWRBPcdprBKjVHklo4Om1BcyRoCmH7Hwr?=
 =?us-ascii?Q?sNm92jnyRcM4MH1KYZl8ALY4tC6FcOkMlCFKPCIDvM/qpqdfmSE/9oKN1Hqp?=
 =?us-ascii?Q?O3GpzQlHXWYJR0ZHfBq2MP2vIHiTY+lofVF2Iy7LYfUg0PiLBHdWyB+DjAVf?=
 =?us-ascii?Q?aRDM32E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyHLl92GvPvuqAaitEE4ERVXrXsWENzmuerth1Mk8bjQiAatvBUMJQp7HyU2?=
 =?us-ascii?Q?3qgoVnc+vD2dXM4bvwaFDaHlYIctVX0rFW2yOUWfPmc/88ob5utQjoeBSG/r?=
 =?us-ascii?Q?vNdcdLZUvmdNcw1Up7Pr/okFyCkfJYkvFLhzxy7VrNgqwdApcIcvKjxORGTS?=
 =?us-ascii?Q?6wNGAqfTbn5LqmKFVb47+VsEe16u6poV4TfFbEHQf/JnlxM9zzj5C8EW6fSJ?=
 =?us-ascii?Q?iS5tqBSJAB3KNqOIoypmQaerQFUTzTMc5RD6iajtzWC7HWVZbmLaDlYuoYOr?=
 =?us-ascii?Q?UVdFmIDSMXyFymPRuF7MABQoSJn400J6xAxabMxIwARcNQXFiFF3SMe6DeLG?=
 =?us-ascii?Q?1seU4FMJS8fbn5bECjC+ncgyiZsw06hiKS0jrRWSZBELEfJ34+2YgVb5Ya35?=
 =?us-ascii?Q?YzOMtNbkR6J+gecfxUmXeOc7D7VVzfvf3H+J8hvMzh+rrz5X8PK2mOiT0vg5?=
 =?us-ascii?Q?oeZ78fwKpnG1/1qS32chghaZdaqPZKh939iZTKVwIrFXormQJhPOgGVanEXe?=
 =?us-ascii?Q?rdyuY8bfFYHOdtXfHL4Rmwf6iIo9pHszvJgxb291l030g7yqgUgfYvuN8eqR?=
 =?us-ascii?Q?o2OqW/ZsCamjkuaxC7t4F1Rj2Vdn5Wk1hqW7dpQgMT6AZvakY5W0m3s7zAM8?=
 =?us-ascii?Q?R1Hejo/d5QAw7WlXYWniq0fvkzXnzVhHPLTzgSu6nLJuS4A2QA5diXiW2M4P?=
 =?us-ascii?Q?cNUTF3lJqsOO2mbtBD40XkzDhj+UDH2QawgiEqplkN+Gu2PXlEwENg5wIunl?=
 =?us-ascii?Q?vveDvdXNipEEG2y5nlBkxgqVkHXKbPH4r+J57DgSC+kvs72Nu2H8Cr01W2+H?=
 =?us-ascii?Q?bTaEJzYbJLHo6G44AW2QFPLGhj61e6ZGvNxpPCYTit6Rt6IlYekcROc2iRT2?=
 =?us-ascii?Q?eyztS6Lr36gF64oMbUCHiIpbgmyOuO6lFgHyKKxYDP3vtK2sfPmALZRMSrp7?=
 =?us-ascii?Q?DLLdxls0eX0vZm6iW0hpBNuS8JUQYnmMiFbttjuUzV0Fs2k+qw66JOVizqbo?=
 =?us-ascii?Q?/Ir+wrsY9HHku/wOApBN4vFF42MdOrtUjM063aq3qCdA9LTseAt7/GlIeUW8?=
 =?us-ascii?Q?drkKHVEwtQXsfgoA0Co6MmuoAvGESt8U9CHUQXe/S2ETaO6011l0LCpqbPPM?=
 =?us-ascii?Q?A0mia44xEepWLUjnDzE8Feqv6sSK2Ca82t5DNOzlUbcffSCH0rTrIwJHXlIS?=
 =?us-ascii?Q?tzBVmwhHoYfJ45bKx0y+53rpseQv/fwuraB1mLMPuEg+m4xTNihTcxHuXoCV?=
 =?us-ascii?Q?RULP8nMiDEGHc19UutwpLTW268M31lWIL+IR2IbaM0YjQZVYDdm6jbrdRJCt?=
 =?us-ascii?Q?kUxKtyY785j6xrXxL20ipdo+fX/ekqf2x43MoXpgwelMnjB7slOV30Ls46Q7?=
 =?us-ascii?Q?hJq9e5iVGccvjxU7EGjOyP0FJH6ea+bcCd1urZdSLBNKaNdsAGoPz/E5cDuH?=
 =?us-ascii?Q?ydTnwUuB6/leq93hgqGYbpjiPnwme2JtF8BdzHBNkr0HRvk1y+Tpea2Pf/H+?=
 =?us-ascii?Q?unVc4Ep/0FLeJRmTxLLOV/fEgdj+mLU/LhQxi+8IqQBYAwYfv2C0uKOSnxyb?=
 =?us-ascii?Q?VcvYrggHYqBeURqCxrCG01kZCIAwfq/TWhN9XuK6I7AwcCMuBDF8coNdmVf9?=
 =?us-ascii?Q?V9pvSowHWdFFuu8LGSdG+u0uYOoXTew7JWrM0EB/O1znDbieuT6g4CvR/sEU?=
 =?us-ascii?Q?Lva+hlXABsTEkz5voOAPEltn6kI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e343edb3-6a2d-4d57-1c1b-08dde5ec0e44
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 04:33:37.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ba7DcImBgfMQf1MC6hehQzfPl7LwvNvE7iOIO38B/sVc8pabGQfYrIEl7fLiQ4Rw0TxcrCtoB3BhiB5AcIjvRSeEXdh9l76ulIekHefyPJ5yW3L9t6o5uAWQ5L8OqFT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6263

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
https://lore.kernel.org/lkml/20250827044810.152775-1-admiyo@os.amperecomputing.com/

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
 drivers/net/mctp/mctp-pcc.c | 343 ++++++++++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


