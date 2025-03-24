Return-Path: <netdev+bounces-177033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6802A6D6B2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D183B1AAE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402025D8EC;
	Mon, 24 Mar 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="bTgqhcfR"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5925DB0B;
	Mon, 24 Mar 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806553; cv=fail; b=FO0LWV4Mlh/mo3nFO/BNh0osmKftW1Zb6DlVo6Ig12KG5lDylh7YdGJkz9CF1Td4INeFeDUPd/g4W1wzEuUlZhzg46hqYY8zMMjASp+CRM4UVS3gAuerrgAJalJiSVKvq3Qbi/Crpe0CBntI68pqLHx+yMpgDNKVBBwWmivxZ78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806553; c=relaxed/simple;
	bh=B/niDt/JAkAA5J2C1tSpOjwdNoe7CdBG7p+2FB30KOE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D1g/K6u2gKELAB6nEqcG5sMnWp+bY0rOLadIb57Ymp+579DBesUot/JUliOZO/BgEKu0YcrCzsWio72x8Cx6d1wsRlLZb3ywBVPNnzRXx1yf+C3zJ9JrNiYBF8AIrs/pgZxpUMMsJJtCrMLiV5EAAki6URksQshr3TynyUx3CR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=bTgqhcfR; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipuqTsbSSpKTtt33VwlcX0h1E49jcUaNLFKcTNBlGMHtklYQY3nyOrH3CTMGUXLuX2267/OV7aDF6RzCyJPLOeV8bQV0NM2Bqwmv2HW1YJZIhRZOqn1AGAIq6TIiNByIpxJZAjJzKuDmfM/au5jGFus3lo2MkB6jFr6uZP68Un3b52+DMnVfXRztwaP0o9EctLpGmjWVqT0vKInewFE5vYDbo37lX07fH+5tSQ2HSfCM5mx42x+NJoPXbhnQhVZidAmgHPrF3UzvIDSc6cGmKReZMjMDHdPBWMd5yc2Q+teMWi84t5yEnYKBm6S2yMHin3D4d1/USouym1dmrPFFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05w4RKwk6Wt+a2eJKpgGiqRpORIR6gPu6yrGrWKquaY=;
 b=iR/JZ4qPxPZ5cGdjyC5p1OfHFTopMvj/GG2bEG0hkqIm/9tsNhsHvXtKu7FmfDrdmxNXm1F2ecOBdYO6KzbAWjNSjwsz23jY3gBFE9ohG2hPaKEdQHLoWDCz6MlsaEKk/EfkjrixSmOpLdXJMiEp1lbARgkM8tC7RRl/xGtfYoNoCJyIECCRmLaV0rIEElxQiBhPS+FrvQ2DMP13Fn1Z8+NJ3kB+S6u6zezvDFwG48rOQezjtsGXf7kVMYaglxhYOAsLd9p5021bZRTrGOpd5Pm/kvpbiNWfHSxkHfM0kV8aSK+HC9IEwQsuZLm9HC8tNKELUy8kFwRDi70A/VEDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05w4RKwk6Wt+a2eJKpgGiqRpORIR6gPu6yrGrWKquaY=;
 b=bTgqhcfR/f+lwJt0w3Uwa5r01mtlwfWyF4+bCwxB6G9lw0IghANLbsqNbOxfrfzXhnM0HMTO5ba/IF7qL8+YKWHvPG6WAJVwgG9g6xV6P3XZlv96y7PA58ZgzRpqmvwuN+yrdN5SjN8U2pKWBiRhe1bhYorfLW/GzQPQxB/+rNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:55:44 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:55:43 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/2] dt-bindings: net: mscc,vsc7514-switch: allow specifying 'phys' for switch ports
Date: Mon, 24 Mar 2025 09:55:04 +0100
Message-ID: <20250324085506.55916-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::28) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b40d0f-3582-42d3-9414-08dd6ab1a93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unD0p3zgq+LLkwinN/Ee9BoT6c4O0+JEWpSYeQrF/4y3AB+QbyTNJ0M6oRDN?=
 =?us-ascii?Q?/BiP2BaznYze2lPJVFv2UhTY0CFi9hghLWhMCaXXU0eLXuZtoCJlNA5hz35E?=
 =?us-ascii?Q?9qg6q14rBzTRlus9+AJfc/fa/Cg9R+zVXM9ofxo3ynioqBer32y1sS0bsatn?=
 =?us-ascii?Q?VCGmxAR9uPRbXCxqLzksusg7y5md1cq0lCo5P/W3Ugyd2cYsEvDarY+oSQ57?=
 =?us-ascii?Q?EdNJqgUITFpgsBmN2ge4v3NyK56J0gDrTHKt8iSNBtgGbhOVRtd6OkNrtJfW?=
 =?us-ascii?Q?tsrcFXgPk4hBW9OBpqD0LTCqkPRgBO2jOvlVuhEX/hSIEd6MFxARNdFPnk1M?=
 =?us-ascii?Q?dGZ/RJezzDKD93t2YvyrjwJtJ09/lbSdEXP/y8d1costRzIrJ9CdW+VoMhfD?=
 =?us-ascii?Q?iNrK/U+gPGyMadorlEEwE1U/dNxy07vt9Sghkbp+/meSsZpWiYRzqvi9Xw6v?=
 =?us-ascii?Q?ZE77A7O2/jnX3e8++ZsJVfZSggaz4WFIP01XOcqhtpV3zDd+mxN02t211MEN?=
 =?us-ascii?Q?Yn1XByhSeWKhbfjAYOe53Tb17aYcD4wwGfx+8Zs1RMvAQOd+Na7F97Vbtd09?=
 =?us-ascii?Q?HwBcj3sjm+TuDqJpZfyeSxN5KmjGjrugxgS+2U6PmlCEZbiKbiuC0Q6C+RyL?=
 =?us-ascii?Q?eWOiQQwdCnOIbPeO/HSRMc6LsfAEOdhtNmjdb8z93oAfNRVd4SmwPJhjtZeR?=
 =?us-ascii?Q?vYyZ/qG8S7g6xip5HVrPnLiSfiHigvNf8qcHnIeF1sp65JmLQw1WCir9woNN?=
 =?us-ascii?Q?oGgZ4CjNP/KQmv8Z7AK9iM6OjTDxorNmJNByLl+umT39VimpHyXNX8z4lEQ+?=
 =?us-ascii?Q?oBwuFjQRsqLrPcwvsQh7rGRp2+fxivJGexO49tABEQXxh3ELR8o8SZMK8Tmm?=
 =?us-ascii?Q?6vfH72JeJ8PWtKZDB8krj3j7pMn1j72iE7GscpSy/5AudQD6CGFGRvhtTYBu?=
 =?us-ascii?Q?NizLVH/nD4YxR7cH/Dl2hYz60knS86WIYf6EMvqp5OOVHl2WW0ZppmR/v+GU?=
 =?us-ascii?Q?RJCTcTvVn8IMuA4tauRQ3K/eGjU0gxsGPWZhPL3G5mqVgcuWqU++6qIcC/PW?=
 =?us-ascii?Q?auh3eV7wNAjfUsBs/xBDc6mv95eDQbowUjFOxpgwK33v7ko4En6j6LHy3+U1?=
 =?us-ascii?Q?UsG7Y+1XiS1dyrsd2khx4AbKGHBkyCnIp+h07Iqzid7yzklcc74vmhBTgbbX?=
 =?us-ascii?Q?hUCwRjmU/z1OCHN1fXaBMqUl2i37mkd8EE+JTnKlK1hSGpqZSUcQxZAPPVB8?=
 =?us-ascii?Q?/o0ZSlXpE5vQv0eP8a8zqt94SqtJKCuNf8+h4qQsGdOmgx4JVppMz3rwEWW8?=
 =?us-ascii?Q?Q/Lh2+zePcQrNV4G0UdyfPB77muoMXNPqwnEEMYjKBbmccQcYbhRzipRFbUo?=
 =?us-ascii?Q?5hTGhzhBiz0vkgNujdCB8LEgERD8YZMXnY4fuWGMvKkwDNnLF6eJnI/LiwIO?=
 =?us-ascii?Q?Oo7sK5vHj5xrvplPcbAuSWcRYysbl+mF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NYLQImxdQtPZ/fm7NHdpB0ee5Z9sN2uOOzqS6BJ6Q7naF/3/Q+68i2TNPWw?=
 =?us-ascii?Q?zcSPVjcEJECYDgUwYmG5Rxa9Bc7/QS9Iu6TKlhaPewUFmmZC1a2kTwydyDSi?=
 =?us-ascii?Q?roJh3EXZt/T0mpWl5mX4kLLIjyQbEE1Mj9ZQECo+/eJF77pu/uZDEnCvCZCR?=
 =?us-ascii?Q?V7POnMyPQskUgMGLodtNSdF8OStmMMJDxReZzZorZpY3q8ms39tb3+StB1Tb?=
 =?us-ascii?Q?8w1/ok8yyxiUX+t3u8hgvX1uSs3IKxQ7LTB4jsY2Lt+N2/NLLCVv+G6/iOC4?=
 =?us-ascii?Q?5DZPtyw7I5WIoFNdtBBT4LUquu31peiMpQEAiAVpvdWJAuBQOlExAUcIWXzR?=
 =?us-ascii?Q?rnST7IDCp+n4AAYi+5VLqf47QZo5zp9rN5nmcSDR46XL8V/k3bjcJ26lEe/M?=
 =?us-ascii?Q?If53o6OVyoztKsg/j+/1KyMsOiD8wP3osWOWSZlC9Z+BcHBDVSnk8PRDq984?=
 =?us-ascii?Q?CeG6DUNro/krjKAw9gPvP8tXgLl0tnzNxkHTKfwKVMc02vZgXyitIhjFunts?=
 =?us-ascii?Q?2TtNZ3+i0bB0yzaRiTshayLEDcLT8LJ3Ny8KZKOwMBdXtvA2avLqLLx2muKJ?=
 =?us-ascii?Q?pp3XGUIgVKZYFGBG4A5ECfAt1LJCYmocR08KRpF3TCINdzPcQ/g8CQ+X7ffA?=
 =?us-ascii?Q?KB2g1l5BK0W6+UdOXBiW3PcU8x+dO8AKhJhxxeqqodciFHHvrI5Brtzqadw5?=
 =?us-ascii?Q?FpyK5AS6Bc1yfHWKyaA0GUZRvBpG+NIs/9pbngVkEfSAkatK4Oq+Xf+TE8S0?=
 =?us-ascii?Q?6Nl1JF1sLZ8lAVqqNBdlQc+iDIrPTRUqznn7I8Uo8SjrVRyyO32q3c2tRFkV?=
 =?us-ascii?Q?T/Nlwvub/OPv5TKbWhH4iG7L7OW0Ff2po/bDeR2OBzYR+2mujF/WnNa1bl1k?=
 =?us-ascii?Q?rXXwd9KhuGNsMmBPttbMDwgYPQTMwwzY8xJ5R2kiFaIrMzsCJ7DQRlpLixvJ?=
 =?us-ascii?Q?IdNQ33BPFNeie5BKzCkFg9MGLrNhKSFXE4a74HMVzm88vxRVjRPFr5K9Gk8o?=
 =?us-ascii?Q?3WwX+QrTutS1z+eYAiUPPUnH76tihGGNYQYopMThfPOspJiRIt3UJYqC5YTi?=
 =?us-ascii?Q?5M4mmc080owrP/nLNaxpMBPGkflyUYYVdxmVjMSidk+NQA/ag0+QaC8HGfFx?=
 =?us-ascii?Q?wWhLDAvAdA/q+DTGegxAW/zQKfXIR0/MUdVyvEH4Hz1dyeuB7ELcvhejYMER?=
 =?us-ascii?Q?YEJsKorFMeBOdfQ1YcDv56Uin+p5+cNZuY7mCT7GneKDImVNZ9I0Rsgc/8fP?=
 =?us-ascii?Q?07lddy5KgnYJMcyRGUJ7uXJKiXdKPK75EplL61dN/rpiR6ATlSMm7BaQ+xMa?=
 =?us-ascii?Q?oGpiP8+pVNL5eMxwSYe/8AnGkjk4PjxrYUOB9IJv3IFciHgAcSOaMFMu1agJ?=
 =?us-ascii?Q?Q6u/pIIXx8M1kHG0BhAkJEjoOUCZcLIwFGgm49u3uxsVKLM2HBCRk6OmhqMh?=
 =?us-ascii?Q?VDGtpjBfj4AC6xfaHzZgkhpoEa3FimfhRBcwX+PHmC7PtFavXR48Jho0M61b?=
 =?us-ascii?Q?cJU2cyxteMHtIkJEnUyL1B0J4KK7ZY86coHLxbdpLjOmd7WDcoq3AgHginy2?=
 =?us-ascii?Q?XD4JuyfjJBpClW7lho20gNcYEcEHgqRkSh31pUdsCFPjmvzXRip0q8xUB9xD?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b40d0f-3582-42d3-9414-08dd6ab1a93e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:55:43.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NPPXO7yCK1FQqqTgOMtLtjRXWX6XtiWvnePDx14emivIWKB8MOI/gpCVpmsYn2tQMu/R/fP6KtRUO7yGX1qfB/o3HXrQbgl20TT1rEjxzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708

As part of a larger series [1] to support an mdio-managed version of the
mscc,vsc7514, I found that the current binding does not allow for a
'phys' property for the port nodes.

The driver not only supports this, but requires that information to
work correctly. For reference, see the patch series [2], in particular
commits [3] and [4].

As I'll have to rework and resend [1], but if possible, I'd like to
include these two with acks/reviews when resending. An example showing
this phys property used will be included in that larger series.

[1] https://lore.kernel.org/lkml/20250319123058.452202-1-ravi@prevas.dk/
[2] "ocelot-external-ports", merged as d4671cb96fa31..26271394cf2e9
[3] dfca93ed51a7c ("net: mscc: ocelot: expose serdes configuration function")
[4] 4c05e5ceecbbc ("net: dsa: ocelot: add support for external phys")

Rasmus Villemoes (2):
  Revert "dt-bindings: net: mscc,vsc7514-switch: Simplify DSA and switch
    references"
  dt-bindings: net: mscc,vsc7514-switch: allow specifying 'phys' for
    switch ports

 .../bindings/net/mscc,vsc7514-switch.yaml     | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.49.0


