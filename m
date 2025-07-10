Return-Path: <netdev+bounces-205908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83564B00BE0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B1F4A029C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77552FD592;
	Thu, 10 Jul 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j8diOMzx"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9C21D58B;
	Thu, 10 Jul 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174815; cv=fail; b=U33TUkTYYnKVLmdb2mpl0+sm4T0ou6qCw/ZaIaCsDLpqTVplAQNU67N5PyEWAPJbOCPRIQTryDZ9nVUyXCTBEeIxl+tZtN6Biq7GNFL+6UfhpCbdPW+gsZ2VQsLeDBED3/pnaC0odxbWe+fnFh9AcJucFpBwJgoZcnADlZadYzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174815; c=relaxed/simple;
	bh=vNJPr/644TiqdLszyy0ZXQtjtFmIlPT0Z2/1tTuLGAA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e+biozqMIvkJk+uMZ28kCe4Fv4DEdEDW5FfIWXCSo681S7eHyVXDG7FFUWoqBJz4oMdbx4wIaSbq2mBDGJ+p/L4ssGhpR+fRugfX8Zq9rh/VHxGnOywDgp01IIvcvorEReXVYLqEcGpIYpolCyylN7Th7uEWjfpFIHyzniul4j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=j8diOMzx; arc=fail smtp.client-ip=52.101.56.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUF2FqCdhklCl8PKGLbm6EIg1R+3/VsZt8C0BgXdmiaXHaXy4OJVQHY3nJ9zZLPOyxVUXuILwBeVMDyfuiAtWKQ0tAsIoASUyeogAe80BiLrj1WmSklkq/32ebw7a0L/e8B3BrH4PeFefng7Ul9aztIByb+FP8jUJrlsvly+nv2Gxe6+7PD6oVxsAKdbzMuST2EdK9w7GQJh6S/s9LyMXxGNwF6Eu56JTRQxf/4sN62O2pMUMYnYoG6PRL7UUNrmAHzwsh/1Dh2SYHLqPfmJJab7traqGe3fv1zJ0GxYTF4iFt2VukcmFexkx/F1DVjFMjhFhsTNRjA+MBpZhahC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTiH7Ylq1zsQGfAj5My3vJLwnVwz2jI4xl+J+DcPC2A=;
 b=o3qOWdsSHWm0uFnwyUx6Vu53yd0JfNTY8ZjWGZLnJyJIjmzMA0aSaKBm7kf6vSEj5/7VZFTu0DPw3t2MIHp+WsxzHXTcFDnvP9iio365OlP1hGWA+S1uZqmkGNPl9Py4livLjht64veQSQG4/ZXDX3/SO7xuAZlK3aIMhIukGJYzHV0Cu8BJ2xPVMqg06je+C6sSSyYJM0SmrOgVWPLTeS0j8Re4CkNZpb2WqvtphnwzXYt430piAxsM0AXlu6Gf2or309perwwl/Vmn6ZSFuVF5+wpdTkOtKy290+w2IB5NFWVBJhiQehOzPGawtATIiNCLviCqIxXcxFd++b+UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTiH7Ylq1zsQGfAj5My3vJLwnVwz2jI4xl+J+DcPC2A=;
 b=j8diOMzx6wYJPquxS6UO7+jRuXGfTxdWGTHGlfIJnvVXpKQyNqDSsJtEmlcqTjqbH8yogmpnox0jnpssMSEnprhf/9sdcvGPVL4KTkA/6TEXhOa6+DZSEE0SoIapM7YGWAo68U+w8ULCAGrJcz/HslneLMID9cggvWBcqCabV58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB7188.prod.exchangelabs.com (2603:10b6:610:f4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Thu, 10 Jul 2025 19:13:29 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 19:13:29 +0000
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
Subject: [PATCH net-next v22 0/2] MCTP Over PCC Transport
Date: Thu, 10 Jul 2025 15:12:04 -0400
Message-ID: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0507b691-3e40-457b-61aa-08ddbfe5da72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vasIbEwC9GtdQE4GnEwjOJfPq1PEqEp17pKxWVubRdSOlnk+lVkGp4zr5o9m?=
 =?us-ascii?Q?1CRZzeHZUsS+Gua7D9LShowaZXnaT7qpi/yGCJ3NK9lUZSIpTh3QrhRAilak?=
 =?us-ascii?Q?BhjmDHI+O/g+3FWIZJFmYAoPg+JE7DylgztLVhqWrD8E43SOuFn5zGbS1KYK?=
 =?us-ascii?Q?gi8EvuOh8WfmDu8CtEjwSbjGw/GUrlZjnn00lfRkunYInPGiQwRpKZuO1HXH?=
 =?us-ascii?Q?MCDHh2zMPujkVaywq0DeIPIg9AkcGaN3frBCI4KwMV6pWCBJ2eKk3Mbrzacr?=
 =?us-ascii?Q?XB/hM7RoVX8b0mi9dpBxve5DtCJxlUeFRXmlZ7CTyr59JTtajo4eZUqitpbm?=
 =?us-ascii?Q?fQw/NuEDaZH1P3y0ktIHh5yxHcZwSnbEEBP+58AXhSYkW6xGC+jw9akS0rcJ?=
 =?us-ascii?Q?2xsAxDLm41zPUbau9ek+Hu3BY4Vkz0ePA95yLrfAgPOLdS5WprLjqmPETSLb?=
 =?us-ascii?Q?JbCJP+l1QVqFApVwoM5KdK33Wn/k2msm6VgBFqNtK1si4Ad8ywsk4C/rcl7t?=
 =?us-ascii?Q?lWeUqexgO+bVFtBIYZXhISRt1hqB0AjVXWSsTC1zT/cpmR4KHJh85mI+h9UN?=
 =?us-ascii?Q?E5r/JZiPADFoP5MnkBc7H+CEaMoPfAMICgGeFRynZqAWlXi6EB0TiaSHCK/j?=
 =?us-ascii?Q?IzFSkMrMfYOHnBXYny0lg2wE8xJjTc6Hle+tdbmasZfDPTKQ2f13JCpkOQM2?=
 =?us-ascii?Q?UePbXf0NhpEybHMQjgwLbZfWvH+Ip7TI+KUkoOoyAiDWzd2rHyqvezPT5DlR?=
 =?us-ascii?Q?WKbpVlPZP/RCdiHKaayDaFRZyVy/VqPyANqMVxtm3DzlyT3jgxeyROwRQtjj?=
 =?us-ascii?Q?TUwlyMDLOOn3AkN4Swb2D2cgytXUAoaXpBYIKoS1g7XewcKdH9ZYKaCNAT19?=
 =?us-ascii?Q?rVZMB6+9+55JUvw45Ey9WcnUGchZ4JG0WJLmOJwgbCxB9NLU5gdEizDL8nY9?=
 =?us-ascii?Q?v9/5px/3krqMih712oC4olqB9vb+czZX8lYhN5Ezk2BE1+bhvoMDJTFs4dye?=
 =?us-ascii?Q?kUhvj/UXR4KpGEW2BacCbQHQKAeMyWLO4gH4FaQnxmGd62yCwngQW1Q06WlV?=
 =?us-ascii?Q?D35vpJdPci5MF5O5jBM2Vr64U2NZ7elAN1tQQRvnV/lTPRHlSw34n15dD7Lw?=
 =?us-ascii?Q?KSU2v0fLfdYi/szpsyB3VMFe0IkAWVHiqFavvUA1gP2yUtnK1mRvZS1iO9WZ?=
 =?us-ascii?Q?MH24Iy7ju6Hys4E2MBrz0q6V+f4XnFs43Unp62/STdLJwZ3ogPrgRlGbse61?=
 =?us-ascii?Q?hgnEo7qQ2dnlHfw2Lsmh4nELxycU3gAQCz/sT9X05p12RYuxg5IaN++wUqsb?=
 =?us-ascii?Q?7e0A4Bu50KF/9+keoHzg9wxiD+Q4shkuHFBevLQfdJuFp11H/9z3+XhPejZW?=
 =?us-ascii?Q?01Z9vdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWdz2rI63iF0NYfBQzqYJrW1DmG/NDALZ3dA74juLRcXPKIbCux/DptCaDiJ?=
 =?us-ascii?Q?APtBL86pQ5kpPWuBl5kPYhKNWgxrRMAcl8yNYlYZbdYJ2/fvT7gSzDhA+3Pe?=
 =?us-ascii?Q?3lb3shDyPGMhl1Q78YE5MYzsJeGq5Msy56KnN1bQ6zIHwNowrlPgQIYT4zYK?=
 =?us-ascii?Q?daeJzm6AfzjuDq0IUgF2jAFUqRrtRMkqXzWRgjPV/3GZy5N6srrJFHbwUseU?=
 =?us-ascii?Q?9nusF2kPfQq2oGCKAzmsYYyEeCBGfRm+11NLFTEkksVaCF3/TIAIudDz3xqO?=
 =?us-ascii?Q?gowk6gDSF3QQIHsH9W6B14kW59ooDUMA1sfw8ODXaf8tYvRxqi5ImBlY8njR?=
 =?us-ascii?Q?DoHR7INBvul27vgBEMFE0/hlepTVOGydIVzKigTd4x1DR7eEkEDnI86y/IRm?=
 =?us-ascii?Q?D+3TgxNkNoLYX5lefzFFSUJhQP4kBC0Cs/VXeJrSaKczIk28ZUX8mFehB917?=
 =?us-ascii?Q?dqpS3jkqi6P8zKjQgUacBytGKBZsAzLEjd5xT4AadxE8K58K+LMH+6FUGYmU?=
 =?us-ascii?Q?CjqK8oM6Y7VEfAsVAZsE0rL6GS4Kp/ZubFLNVKzT9kPIJpMTZ2H90FR4OLsm?=
 =?us-ascii?Q?yUBiAHPnqhodH/v4mROO1kSc54bfKn8bfQtcg6uEQ5BKcFa8HcauZbO5NloZ?=
 =?us-ascii?Q?siU65S5UNsyVxgGLuiNQhydK3tEc1sEJnP9JrthKXP++qPqKXljmq1XcHd/p?=
 =?us-ascii?Q?z0XWd/PKXHassTswPhCc2m9QBCo/X16y8r2nyE4qf04e4nrz1OM3Bo3zzyr7?=
 =?us-ascii?Q?eepf1cgw26/bKwHmXkCp8nK2cn5Ii3Mc9GQBnzh+EbzahWkJ7gRKvNTsPVJp?=
 =?us-ascii?Q?qWXRLL1t9zImSVxWosVcvx30P7La21M8/yMbcTZnMjpxtHyxGKMu+1CHHT8v?=
 =?us-ascii?Q?Y19zYfM3nUvwol3wyyV0AlAwuQerswColJL8TNdwryLAiLPS581PtRMNvQlX?=
 =?us-ascii?Q?bZXeerLsWhLPAI6fms1NPD4nRDdBCk0UPEmczxayVWDreG2oKg/bdjNB47xq?=
 =?us-ascii?Q?VGXgCRgVtqe2XczQe7hTfGKc1JBa+GnFtTzcG0UjX+Yx3Q3Djd+Vo0tYWpJK?=
 =?us-ascii?Q?mMFXMDd43UpaDHgSdVR55Y41deHOx6P1xDV8FOMNn0qDc1DfC4uQiy+dSM9o?=
 =?us-ascii?Q?pLDiZC+ERxKjGyUOcuwtEolwOBUeVkV+KtIdq2hGV8ie21QKHwrSI9fBvPjA?=
 =?us-ascii?Q?6zCPz4cQFeX/mg7jGOVEwo6+QLIrbk3pf+Fd5CizcWBWMVtnQ4KVI5w7pveb?=
 =?us-ascii?Q?g1STQs9H2ok1G3jsyO+LCIYxyk7V3OMHh69cIbdT4BwS/LzBcL1LzryPqvr0?=
 =?us-ascii?Q?ZOSKaWTridnTNDPXvY5hw74t5QJjZqOT/YwlYy76VbXaTsJVdXcJLE3lhUlH?=
 =?us-ascii?Q?OxTHrW1yPMCYSoKkQFw8b9K7N2r86dxf5u+ZwLdsHM4tJnj//lQdL8uu7HT9?=
 =?us-ascii?Q?PDenZyBXAyejyIGRQ0D7q9NuS5JzqpnqyRZ0sZz29LYvR1QSUZkLBiIDa9wW?=
 =?us-ascii?Q?N/gL537M6e0nvxdOqM7aR5IgYLxE/W4i0hoC3CIjdPVKKTAWkTtOjIdKrzZd?=
 =?us-ascii?Q?vrfhVewnrMoKMYCrrwFgzTzloaURU47WOiyY6tdwRbV8zi5DyQgugLrE7QBH?=
 =?us-ascii?Q?atiuwOMiaXGsHqcryZor/Ir4dHDnFmNpWX0V2Zcw0g+TCl0ryI9uJ2OY9puv?=
 =?us-ascii?Q?w2I/VWtD2Pd5e3d1tSHN6yflolU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0507b691-3e40-457b-61aa-08ddbfe5da72
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:13:29.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu23HJFPOUi9Fwu4ZVT4nH2l+1GpCUojsW2zJyl7MQHuTSr1bBB19sI4vv+J9XskFs5scFx7mIc2pWiTWqUeXwymbnU9DXy9hv1Yfro8xhwKcDfHoQlUf/pMarzQELcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7188

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
https://lore.kernel.org/lkml/20250429222759.138627-1-admiyo@os.amperecomputing.com/

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

Adam Young (2):
  mailbox/pcc: support mailbox management of the shared buffer
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       |  91 +++++++++-
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 346 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |  19 ++
 6 files changed, 472 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


