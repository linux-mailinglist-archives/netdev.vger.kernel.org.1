Return-Path: <netdev+bounces-144656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3A9C8102
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2059B21F71
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D21E3DCF;
	Thu, 14 Nov 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dwAQRYTv"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020097.outbound.protection.outlook.com [52.101.56.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457911F5EA;
	Thu, 14 Nov 2024 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552583; cv=fail; b=Bwf/KMiW32drCULYDxmusx/KWQLeb9dgXhmDsBI7TQ5sPmG7W5mjUEnHb6RQaLZu9FGbY2JXvt0QDG4xmiMMGH3u4d/0Fy/3tW2BAZh0Uonti24JxxNzV5SjuVzOtA7fVf3ar508EyUeg6KwIhcBXuiqij4d0/Igp7KBp779zJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552583; c=relaxed/simple;
	bh=DCf1zc5205ny40LlHAUH5lMakt/sCjW0N21A43W7GG0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JC6RDa4VSnp2qqPdvcMJXslnOGlb3dp6K2Njoe1iPIcJqlm/X5++/HNr1l0peOFDffBRMuvbo1bW+UPeTPbRHdTx1uPcCWzaykx8VTEbVXiUmniLJcnVZuVsnc1iQcaBt3/g58EWYC9EgPqbmdqwLxRB2h/uVS8gAdQohjxDKQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dwAQRYTv; arc=fail smtp.client-ip=52.101.56.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvcug9v3nc5EB4sivB2gpoPIB7h+PUP2sRpkrffrm6Mcqh+xMA8zzIkC6TAjoXYEmrWkuQ6RpEtau11emX4sgMot/bivP2dSj+I7bFioqR5wy1PtRUYAYOwnuLXK8RSdBtFom+1FPNcUi1HXwkgiK3SMWNtxm7hV4u4pdDuuFk3dSSo+xFQBazGUMG24y0UtJhR5IZ9BTrRINDf4a4p/J+fppWLcq2CYnCtLrfGD5V7Mlur9oGorfrYY0nUT7I3KyG8J6oO9E7ajveklMRB5BO3Cr4iKtoGZr8y4I7ZjrVkEMkVGdD4ysquigAeGMBnyAlLoLtHIOjXwL1subMyTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJJ108WK1d8zCT0LMFMtxx01ZbS0FZeJ6JWzpVNxO7M=;
 b=q9gBXDDu6ev8UR2Ge6TphLiRGoPfj6Yntu4SgnyqT1zi4J04yexHuIxq0THj7sDsa0gpZC7Fmll/liiK57uLFE3QgDLJ1ey7PdwcTnOFBRKmZ4Uyy4exZAXsiXNhg95RU1pMkqs9od4pKtB0oMegEnpLywsDh+dVeRT+CuqDozbz5m6HXY2VZD0AJQQ42vRT3ZqzJ6CYqNMYSV1zFpVQ31rUoD2L44nhvQhfGlgK+49KUcubNWpDLV/GlFFu/kvJ/o4CaCd0OfGaXUn86ukTNVruqScZv6EjXzYZwLQJOYZ321o85qBySUGWXQNSgGsj1N5yrCtVRGXrABrP4dAkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJJ108WK1d8zCT0LMFMtxx01ZbS0FZeJ6JWzpVNxO7M=;
 b=dwAQRYTv9NG3QHJ/64/yOegtKyryE24ij2/Mg1OnZvkkE5NQpN2ZMqFkxI6crCas1NPADUKVVr7xUhHn7n2vS1Hu3IBpOLpcPg9WtwdgqYXTUBvfrB4+p1vzkQPwGyM3adOmxw+pNxEwkrjgEhcHijW72ZuLdldY2p6PXYFe3lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MN0PR01MB7804.prod.exchangelabs.com (2603:10b6:208:37f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 02:49:37 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 02:49:37 +0000
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
Subject: [PATCH v7 0/2] MCTP Over PCC Transport
Date: Wed, 13 Nov 2024 21:49:25 -0500
Message-ID: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MN0PR01MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5a0a79-2c74-4285-ef0f-08dd0456fa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+fyOoAHLO3LEfORi8as4i1utfa1dNGSTr4mGcBT/WQmr+QegY+qi+WBXXCoc?=
 =?us-ascii?Q?vCvfiwRngoKrdOvCihTmeBTnji1ZsX64rMnpn2D22gluIdDa1NIAvYcrhtKp?=
 =?us-ascii?Q?iW08cdhSJcj3MCUsGHJmayr3zzMlMmOf2bzA6vLr8jWC7ILHlo+8rVTOdUAE?=
 =?us-ascii?Q?KdikVM+whnxTPxKsC3N4dsqsrY1zm0YuvpxuXdeMGQ0qwGMwYl/LYTv8J6xA?=
 =?us-ascii?Q?3n0pjiI1ikiUNrUMj6LigR0x69qs1OPdBjcBeMwW6FIIQUMwKSWaFM6kpC4q?=
 =?us-ascii?Q?bxiaKWkhKNA+Ik5Z7swuUCFClhqu92l8yapvX3i4CJNKScrvZ+lX63cLAcmN?=
 =?us-ascii?Q?3epK63xqJKBWfu+oOqF6bzO5cLYW6sLOl36sYtXzCglcuzpIVF3UQdHHLI17?=
 =?us-ascii?Q?0/5pv6O2iWngmTu7wD2KfjXD10iug21O84JXmETHD2umx19KfHeW5pwwfEby?=
 =?us-ascii?Q?NzbSzI/5myHJv6kRnGFbc+7vVXBfI9DdunEDbuFu0LOjUT97+J/SZ2eGusRc?=
 =?us-ascii?Q?j9trLPKbJbQ5ihHelH/wHVRdTVMboaRBoJabB+uJVnYQfwY2ACPcYQiC4Vef?=
 =?us-ascii?Q?8f616rhHL/9nud/2pNLqCjr9zTmBPEE+GZ+0ffL1ZeuT03KX6OCsQcp9gEYY?=
 =?us-ascii?Q?nxrG/kaPrciyQNchKB9eBHT0J1bSqOKqI8G4ZXSqYt2ZIkpQbDUyUr2qLBt8?=
 =?us-ascii?Q?ww7yCoTonsIYCzrzsrA0+rz9998kQLZ35avnftGU8a16S+/r3lE6TnefJL76?=
 =?us-ascii?Q?4dBd7WTYVS5w9xk8HP8d7xnUtOp6CdbcWs3VsDrc5HXCnJXF5FbT3kcFPunw?=
 =?us-ascii?Q?CLG1eX6cBAYhoxA67C8vX0YgMhDG5c9OsmSKVZOFvY9CFlIFpzk3MTSS+FKM?=
 =?us-ascii?Q?DrgJizaiLBXjCzW3qjQOij1uX5q8Gn0BvqkOA0yK8RrxSjMgVvLnfqp54y/S?=
 =?us-ascii?Q?v69IgsbOBAU9elnupErlzDmNnfCvyySjJFXEruG23Og5/qT4qsDcQZZum4/g?=
 =?us-ascii?Q?1vaXLsaqco7KsZDhgG4nIiYA/c4uIlYOioBVM1+vMMkpsbpHvhgk+fYa+kXi?=
 =?us-ascii?Q?JfLRyCANjM3hLxmYo1X1b3tOubH+g4FXRsxUsslvJOrEf/Z+Qii+cyqgH7iK?=
 =?us-ascii?Q?v+UC3S58xnncoa8kpLRzojLF9j/4P1Al944UEe8ad9UXunq7EcRiac7DmjHE?=
 =?us-ascii?Q?6j5ce3WGZ88K+CpkRCAMpglTOUBv+qXu73ZiiQqNSiqzi6u1dI2PRUZkgxJG?=
 =?us-ascii?Q?ilvhxbfGPPs1R6ArV9OvPCGGH+DTS8sak+tKEU14AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?otezR8HFUIVq7z2WBI/WjoIQW3c2/pkZLvd6ukLEFgD+zcme+6G0tLhnLsw/?=
 =?us-ascii?Q?Qik5NErtfLJiJyAOfkKxICAMY1/QZ8qE3QozSA9/RpLgc1zdxVgJUcAcOy5t?=
 =?us-ascii?Q?dOXGUySfKlvf7LPAYyNB99lF/OVovqnl6AxW26BRLqbMtPclxL/2jAwiwVmv?=
 =?us-ascii?Q?/N8Wl1kKjc7azTRjfsbI/RspkH/BbtatchlcavwgjNfb5vRWxOaL+5jFy1Ha?=
 =?us-ascii?Q?Y2EGHoybF9+hIjTutd8z+ZuoZuJWWV41Ujq6aPMvJP4yh1Q8NFbXTKGvtgu9?=
 =?us-ascii?Q?Glc3qkY/qYoGPWMUJR7vGjcRkdQKFqKXOYPRO1DfvceOAun4nV14zEPymkyj?=
 =?us-ascii?Q?YFJfuSH/kk6V1puaC/2u+Ifx+MvSApBvo2EjSVr8acoz/dwGv04Eu1ZltpKG?=
 =?us-ascii?Q?JNSunhQpTE67H5ORfERwl2uuplC894q28vCrDAX0paFnt39rL9YDG4swPgeD?=
 =?us-ascii?Q?/+W01dwXZ/WvK7GjEzuYiVmzgVe4aBOBvlWkpC9DxPNaagCqFUdxZ3e1H85O?=
 =?us-ascii?Q?3wUPbUQ9GliprIRGrUPy8bLnkENO00gf5yZJ8XOFMCAP0e0BfdLYe3kBwTku?=
 =?us-ascii?Q?fMF5O8cVMnYY687Ddwyp+0f+nisdubbp1lV9OmgFPN5XG+B64VEH3GuvzhRi?=
 =?us-ascii?Q?mrw0eLnQ4clUCW/JhA2QFeTu73j9WRbNvNB+9+STXu0eFxfOcvUVmoF9lRb8?=
 =?us-ascii?Q?MLAeudPloQL+qmDvgX3kTsSSTLNkwXVH0WpU4LzGCqWFL1EP/VbDcaIyWbwP?=
 =?us-ascii?Q?WFCA8PLoyZbs6keEUhMwGrvy1QH64yciE6nmbaz+6BqTtWEk8z2qHLpBwgPu?=
 =?us-ascii?Q?H5jsCYm/8s/UHqeC+W+YltnBaC7aMRKKi6tcx5zzc4V1Xlrs+UJFVzMAB2To?=
 =?us-ascii?Q?etsu17QHXOoTeIWDeeiNv4mPRp4MazMV1epVPYIv9ixJ0txEcpUvNHYaFPpR?=
 =?us-ascii?Q?8kO8Awj/nYvHJjzwR8yW7sGCwh3ao/ERzlNtG5JtNKbciPsbhlLelXqWtmnx?=
 =?us-ascii?Q?NFiCDCGo+uM17kZRdMkFhEu8Np6hnsyUDiisQ4aFphWOHqksqittdBicDMlQ?=
 =?us-ascii?Q?9mB06mu35O53zZ4QxbUM1YALeLGE+t5z71g5XzDtcGvQwGW2YcGQem03FDex?=
 =?us-ascii?Q?kHckkZGQJQI0xPhNZrf9S505wSWzDJslA5Xt8BC80AK0KO7eN6CEdZ33el+F?=
 =?us-ascii?Q?DkPQu8xDqDr0jLhpJmjPS/dpPyxdE/xi3AKmnJBZoXPpHreDs3qLpmuBpH7T?=
 =?us-ascii?Q?Vh6T6+vFW078BhFxiKdke+J4lRCSxEHFhCVx3A4emrDqdcBDDWcXVy5v5RHe?=
 =?us-ascii?Q?ahTdABGE6cwoJcfHkFyBquHCVvWhi5t+7yqO45YiT5s/iAeIqNFMrTcE8NGD?=
 =?us-ascii?Q?yVhmQw6oioSCvNwCBgwE22HjEkmIQAEDLivQf5gS5/WQL3k8h9oDn7GQhrXU?=
 =?us-ascii?Q?s7goY7J8u7Dy0x2sgRGnKIS3pGFCoUfdORolIYwc9MMl9idbV3Fm1wy6uQpl?=
 =?us-ascii?Q?I0NrT3UIqqjAOrnjTY70OvRV66cwrGNNZCg3BiGXioolmJ4UioaUs+5KuHET?=
 =?us-ascii?Q?Dq4sjsiIzhBRJ3nOc9cUE0AUDBJLiF2tq3T6D3RFNif2QhmqFnCFCtw0rIJV?=
 =?us-ascii?Q?QMGI9wf1VQoYIUkwvOa5d8odUgTpdBHPOclkS1w3StWJQOoSL8FFmCIktka9?=
 =?us-ascii?Q?29D1ht4hIKdvjRMOp6cjJvKrjGo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5a0a79-2c74-4285-ef0f-08dd0456fa2e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 02:49:37.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxNpFz659Sh5PBNAobcmTdVbofa8Ct3bUWAxw7NBNMb9paC64VM1exatgd/YedF2re4Vs4krIXRSVyjN2nLiDu1CBQh1Dqmln+YcbmAV71eVlZJM8/FTeOyiD/oEihIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7804

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
- created helper stucture for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unneccessary null initialization from acpi_device_id

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
  mctp pcc: Check before sending MCTP PCC response ACK
  mctp pcc: Implement MCTP over PCC Transport

 drivers/mailbox/pcc.c       |  62 ++++++-
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 324 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |   7 +
 5 files changed, 399 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


