Return-Path: <netdev+bounces-226503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA520BA11B3
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23ED1BC5495
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136D121B9F1;
	Thu, 25 Sep 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZZuCWZk1"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020143.outbound.protection.outlook.com [52.101.201.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373C13635E;
	Thu, 25 Sep 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826839; cv=fail; b=GTFQW2aiBjpbC6wp3SmFJsEOTL0/ZrA1DjO2DplmU48ymud3xHwBnhjJyya2uM7qGeESLq4c97VUeaEtH1BrWAGbqud7clZ1i6M8YX1LoVbYjX1x57sNbtPXdDwXhJySIEn09iLW4pugPnPwNaoDxru7b9V5wnNKZMmDzz2GZRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826839; c=relaxed/simple;
	bh=uMghhwXQnb+EHtYs8UHIErGIot24lEDHq+P2PL+OpYU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rIMzO7//FDkfS+XNb4+CXG22nVG2HhKLLo9qzBga+8XeXYXDA5yhJFyEybyIlhsvp2TL+ZhLc7tSwqrBEfN5asxPAbgSQ4AfyrfLc5ARdjsQ5m6cSif55xiX0NQvdXdyRse38cPQ5R72BJ0OZHApRFKL+w3WeXcCZsI/BtEUP80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZZuCWZk1; arc=fail smtp.client-ip=52.101.201.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLIZCn+9X4IhFlP8QCHVf2ZUB/PML+sM7NPTcgW3JA86tNK/7M4B8Mo0vHH+Jw1/YtoLxeImXxwsYdr3vWjTFIwUgLkyVg5M475zk95gcpUSkKwsokR5gzZOpAD42SKvy1s8GmWW/8u366/lFFiRyfYM+Tg8qyAaIE9ovgHIQRAzoyeVtl2u8MdokmeotCh/0uC1N3NaujKcmINUYuXyXL4VRqoshaZEc5ljWMucn0sz0VdKpDAiqVYJQZpNM5dr/hVe6IZLH9B2805RzGmKk1HoE89HX2Z//ZYfE3Z8nZsjUOeH8ZMDfoq1ptIFpElK3l2lBgbYyWIe3unEjo439A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3mfO97PqRypCty5VlbEVwb34KJ2IGf3RgQnLuhPvWk=;
 b=IphwDDbZSrZaxP36S2CdNzXdzeXTcMYI02IjwOQlX9RuJPuWqyR0lDvkKBpmzJkevRvSzaYk9+hhxXcLZ5OcIVVXooiDm9dVspB63h5oUb3bSsKPlX9X3XUBLhEfoE6OrFtG50nlsu5DHfOxqKHPwpJWOjPOLXVI96Qq/ziOAZYVLu/zOszW2p+Tkb5W+tvSiu9DePBmpFPGWLIZlUQxo9ivA/CpOoF5ZrkamryzwVE2q8Ny69KoZf+l4OFydz8yFpivgSvXzAx9R4z7PpVZNYIL0dPimcQfYaG5Ze9O+HXYwgEQXJniqOFQ0pN3/IP4KqWssWUu1AzHLjqECCkRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3mfO97PqRypCty5VlbEVwb34KJ2IGf3RgQnLuhPvWk=;
 b=ZZuCWZk1cWflXuoIEu4liZzl/XbIFDvBj6MDPLdwpjzsaD//4MMDNQYq6oXbDS1+TrIUVEH7H6Yi2d3FZKJ0Fbh4e11TcNJEAjGd5VmbfyAjt8oWO24EPSvshsDKrPHVTqAvHdz9lH/+65Au/LFMqJngzT3UPIBlzJVzH5FVLHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6160.prod.exchangelabs.com (2603:10b6:a03:2a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 19:00:34 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:00:34 +0000
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
Subject: [PATCH net-next v29 0/3] MCTP Over PCC Transport
Date: Thu, 25 Sep 2025 15:00:23 -0400
Message-ID: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:930:4e::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1197d815-0e9b-40b0-456b-08ddfc65ce40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8XscHK8WAmdVeRz8fgsNYyI50MZUby87SdUTnP3++9Wjq6Qwaa65jR81rOx?=
 =?us-ascii?Q?ynjwaNy2SBJ5W0v3pS8esmMGCoewmTsP9GouZ1YpG8pdBUJFE96OoNnrxvqk?=
 =?us-ascii?Q?oD0ZWnNNHb9XFqBkqvzoFSIKxjmpPSaOyVn3nm/U0N4zPZZ6b/wMJj11Git8?=
 =?us-ascii?Q?mGLxGmrRLvRmMV9O0Z27KKvd9UHygyjAN5Wgcr9WEL8skO8lldikjznkKXF7?=
 =?us-ascii?Q?1yNLgdmzKNw8ZislICqRBa4iJJPJOOwLUIcsEaqnXwRt9N1pvpYbSf4b4Lz5?=
 =?us-ascii?Q?Tqx3LaYulLD8c8JWslKprrC4O8NqfUexFA8TUJz3ifCZ4VSNEmqhEeK+WQtf?=
 =?us-ascii?Q?iHd1iBYCtRZzj2+oTKzRaMifKMo5o5/Za0psGSMrPWWjPbPnhy+UmU91IieM?=
 =?us-ascii?Q?a+9XgrMuy3Ii4C5TDxBUd8FyF4Ga/EWjZpEqSfk+a8kIg7WgtH5EMSfOsChq?=
 =?us-ascii?Q?b2jx53sntr8HCe1uogMEBglpLiQ3TOx9U58mGMBzl2O1LXlaC4/JcxaxpF3H?=
 =?us-ascii?Q?RimPbzD5pQs1wnYRvjwiiLENkJEerm7VqRqNhD0UYPNOTu1qXSSADu+OPHcm?=
 =?us-ascii?Q?WYQz/YvpkDOu1kPJl7fpe+aJp2VA6SJ2yDvXekU7eR14+JrdtNyrQ2d/61XS?=
 =?us-ascii?Q?QzRCwbINUrxH65InDgyJXTKimX+eqcotceFZlkrDi/oqJKONlhzyAkP8hV1N?=
 =?us-ascii?Q?tqeGZLujCq056qb84Je2mpwoglGi17Un0DcH573/tTCPD8I4lHoJOpbsHfoG?=
 =?us-ascii?Q?uytJKMImYijT5XWdi2HQgOn2YAXo9LkL2An3SVDlvS+1EtW43oK07iqk0nw2?=
 =?us-ascii?Q?jvFanbtCWAkjNgOfNyFCn6mrahsPLEr91RZzetYpLdvRQ5PDSG1AyI1cVr/5?=
 =?us-ascii?Q?iY44q8Xe/AL0Lf76VKa85LTOztNif9ZcKB9fz/TxDFFAj1PxCAHxf307eUle?=
 =?us-ascii?Q?GVvSghKSFXYB29FIeIOANypr5GriJmXjRksnURcYNBFDcOmrlkpXJNIMF2Rf?=
 =?us-ascii?Q?1YvffkURpWXba3CTRsh2JmKppP/cPuoLr1XlcRd8wiREQmWLnx03U88T0fcC?=
 =?us-ascii?Q?CNfqidvm4jwUFskbxW/v8tZbsow4jOy7qWHMAzirvGsvDXa6JxEsrxs+ON0N?=
 =?us-ascii?Q?7NcyFSp3HDwzDFM1VK3V5YehJj4aCbhSu3RgidOgMUTLdI6jrXjCYiOJdXbD?=
 =?us-ascii?Q?eF3cWU10RZMgz0//6h1B47yvPTSuGCkXwZdpnTeVIk1EbvTv5OYQ7X5G1r7r?=
 =?us-ascii?Q?yD4tKvZiiQlHzlI/VTyn9dujpdb+w25tyu2m93EmRQ19V61H8zQbZG2DkJHC?=
 =?us-ascii?Q?sZVgYQjsexAkiADhNhid6s2JvXVmhhDRqI/nvOHvuEEhT09ONXs9yDlF0Bem?=
 =?us-ascii?Q?rlUmwga1EmJjXGRu6EbXI0xj2pGzeZ1PlnBnvEoqYDITfwRVXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkt9HUzIsiqHWpCclFWMtyNw/aD7WUjS6pe8mk/i7uusw0RYu7NKpp2jy8Sd?=
 =?us-ascii?Q?FMUV6VrGtYBv0OqCIQuD2NzJST+h6mMt6D0ObOUcR573LfFQv2MsgB8+G3yD?=
 =?us-ascii?Q?fzVniNMq5lBGf83CIPJyPswFuQdqwPiQksdkoUOncYDwVIv9KbMXTo70mnp7?=
 =?us-ascii?Q?B/jTmmsy+vRfR83sdgiQPWpgi9Flvw2C5RhdCZoMG8KmNxMvGmb1WAYWexPN?=
 =?us-ascii?Q?6A/wJLL5RLG9W8iMFMdmHp02rXYV3urcLGYjiM7Vas3bQ+CfTDcrxBW8KRu7?=
 =?us-ascii?Q?UxE0gMWGwihbHwv2nPM8b0iF+i6+GpWHDocHPyQd4Z8E2PLQ8Wlyi+f36Y2k?=
 =?us-ascii?Q?SEs2wJVUrdEnvb3fHY+t+FgapopQuESpn6mpl0JdsxbrAmCenMtXtfucY6fr?=
 =?us-ascii?Q?EaO9Dcl9WNDo4szeZ23/RSkKgl6FIFosHV7QsYHZweIl9xhXHgR9NlPxLeEK?=
 =?us-ascii?Q?ppXwyFnk3Cv5mf2ey4IDYvHHrJF04ClQCIHyOS+8KA6i84fk0OUs7kGfUS/+?=
 =?us-ascii?Q?KhP2+suS5/bzNaD5wSxQqi+f2CnCOWFXxVaerZEcS/U8++x0cpkq0JWOIneb?=
 =?us-ascii?Q?KZhL53ZG8+EXq3M5Bduj/Q6Exzi2XFlZqLTMPVx31KYHw3UZcy3JNCotImXZ?=
 =?us-ascii?Q?uLdn0wYW74LM5yMFSZQszF+17yYPdrmMJuTevJxWLr4HYHwFRDH8tOpfU8cT?=
 =?us-ascii?Q?K8yIxSwzuWT6OQjmCJZ882st0Dc9zuaExfM8YANN8IVDieslg88KoitJvwBF?=
 =?us-ascii?Q?uXq9E+uE4a8V97aNXzjVhWiOQeP2JBQ/rYnNjkz0Sulq0ULCawUF5w6vLGI0?=
 =?us-ascii?Q?uIh5vGGWSFJchdlTjDz0jWK/NFA6x3A39vM0uKc3YbYheEp6L4+/Q+gtWPXj?=
 =?us-ascii?Q?xVBx3mikUSn1K7PcaLp0GAMsC/F3dNePDriwYRygOLxu5QFtN+X5bELW4UUV?=
 =?us-ascii?Q?zlStPib6XOqXOOw1hrUPL68Opq922PoMm6Yx7yIQftCrLjeQ33TstHwv9p1L?=
 =?us-ascii?Q?EvF4HvzDR5O00B9xtzNTsCGnl4sgYn9EuyqCqXk926F2XlnKpDgHfTgWd0we?=
 =?us-ascii?Q?Na5gz3s1IHEL5DXl1HsDcyZbABl10RpKRDogPJpo/Yc6W9zZY+oRwEv3K539?=
 =?us-ascii?Q?6jECcvRoIkfkoxe2WR5Yxri2jotTCujjnpyGVDEEMAJd6mIezL5206OYI4Xm?=
 =?us-ascii?Q?1h4Be71kEzLgYBE1/JCeAlFr0cSDOn5y8sigufFIhpuMSmNkMDr2YAlSX38O?=
 =?us-ascii?Q?NlTIBd+jrB5rz7eF6zq0VlriTugR1LkcRGPRh697mVsuf49J2NuNDLGAdyzL?=
 =?us-ascii?Q?tgpMFMOLRtQVjU1Gngt+xsG7BbRyb63YGlkrQUzZmJUV1gjHbUJ70WtYLLXw?=
 =?us-ascii?Q?lD+1mIbuTfc96ik4ZxYWSNzeaZBNkE2bkU3nuBke9awOJ6ZkYDgE6GgO5HMn?=
 =?us-ascii?Q?PqLid+pzwbd4SHK9hHF2D4FNX10uPtg2Fv8keGeJ5Hgywk9qgJ6AbPOdCM6a?=
 =?us-ascii?Q?dP5qJgYmZd2n4KqSAJUlsACEvZh362n9lrXazW6mhK0r6saS0adIU0Mg1586?=
 =?us-ascii?Q?DQvKhitVLYRe/8JOkIpZGYHxAZRaUidwQpZTmU246JvTVxlE3tiL4Y/b18wM?=
 =?us-ascii?Q?8JkG40yHyvU0fyPZ+pTNxywXdekHPhDrxgtrdysiDAhdyb1jT9KkiPfZlDfH?=
 =?us-ascii?Q?wn15b+VqHYfCtSct/BbdPGH+Bjo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1197d815-0e9b-40b0-456b-08ddfc65ce40
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:00:34.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9l8EPRfvGGZ37Pm/L1xmF5p5RVsPZuCHpckH7Pt70Ma4PD/kt9PA/mesDm1Us/N2pbLNlAajJfZsKB6qMDeSB7wYK4tyWLZjVZZ2F9v+ZuND7oz80Y2HNMq8UpSXDPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6160

This series adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to facilitate communication
between Management controllers and other management controllers, and
between Management controllers and management devices.

PCC is a mechanism for communication between components within the
Platform. It is a composed of shared memory regions, interrupt registers,
and status registers.

The MCTP over PCC driver makes use of two PCC channels. For sending
messages, it uses a Type 3 channel, and for receiving messages it uses
the paired Type 4 channel.  The device and corresponding channels are
specified via ACPI.

MCTP is a general purpose  protocol so it would  be impossible to
enumerate all the use cases, but some of the ones that are most topical
are attestation and RAS support.  There are a handful of protocols built
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session
establishment.

PLDM is more likely to be used for hardware support: temperature, voltage,
or fan sensor control.

At least two companies have devices that can make use of the mechanism.
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of
the ACPI spec:
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has the
ability to ignore an MCTP link that they do not want to enable. This link
would be visible to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. Thus, if the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hard that does support
PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would thus also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

A Previous version of this patch series had a pre-requisite patch that
allows the PCC Mailbox to managed the PCC shared buffer.  That patch has
been merged. This patch series has a fix for a race condition in that
implementation. This code is only executed for type3 and type 4 buffers:
there are currently no other drivers in the Linux kernel that are type 3
or type 4.

Previous Version:
https://lore.kernel.org/lkml/20250904040544.598469-1-admiyo@os.amperecomputing.com/

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

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

Adam Young (3):
  mailbox: add callback function for rx buffer allocation
  mailbox/pcc: use mailbox-api level rx_alloc callback
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                    |   5 +
 drivers/mailbox/pcc.c          |  16 +-
 drivers/net/mctp/Kconfig       |  13 ++
 drivers/net/mctp/Makefile      |   1 +
 drivers/net/mctp/mctp-pcc.c    | 341 +++++++++++++++++++++++++++++++++
 include/acpi/pcc.h             |  22 ---
 include/linux/mailbox_client.h |   7 +
 7 files changed, 377 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


