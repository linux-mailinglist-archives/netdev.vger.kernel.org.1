Return-Path: <netdev+bounces-241008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35E4C7D669
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD7E3A993D
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD62D23A8;
	Sat, 22 Nov 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mpMcsdnV"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823E2C3749;
	Sat, 22 Nov 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840052; cv=fail; b=UmPpYVk51VM2Q8QeH4v8KDRtik6DtJRUkvidbxrIy5uKuK/QL2poki8FVL0Avoce1ZeHtadRyuqkhbNsqvcJ8c5LWdg3+yMMPpyeL9SbunVAD3+o1Aq8B1RJ0WPYsS0vnqhdyX9E4oMA06Z1JccVDr3Xewipy5vKrokPbv6ystY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840052; c=relaxed/simple;
	bh=knUBJviq2iR93f67a+mg9doy1ivKoL+nT03vtLVWrsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSh6E3DNnAlyPKE6+R8/5OVtDSa21HKlGnKXcv49k5On9d/fww0qBeFK2y0UtSWB99crY0g1vgwRBezR2Oucy3aibV8n3zg96qUAlnlK+sgoXGoDYzGAcSURGtetog4Zb2soSccY6sJg1nS42JvcjVvrsFgh262mJ7XYY1NsV0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mpMcsdnV; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsCqefdR2kur+g1MxQI9b4rshLpSTorWFqtiY1+9WXdtD3TdB2e6c2+MLlzCKWiYBv8JXGoMQwwM6Kc0FB+wbGabg0iZTrdLmpOxeb7/zWm8PsmFqITErWlAFRajIOdZjxIx3X/vf77JNAja/bt3gnU4rqZiS/xMT5qvgf53k0KMp1JH4S5R4wo5wFIj3XwLUC1VpGv2NvqyXfM253tyY1snSIkr1+j3efq1K+tdzCuscMAY/YREpuKQ2YJZeBvnmukUb9vpycA/rjtVvBMfVegTPTT/1MnkeQeaxYUeiqhGoRMzIl/lv+6bE2szXH5/PUUyeuiQBJRv6l87QGdfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlR2F1LELL7j3sexgwZSKeMDc4U/MCXA8ZeAhv9CrA4=;
 b=tIFFAi18IYi2QLskawdbBYIalTjv/JdxCsfINXElJhMeAdaNOS8DcBncXbzBj9nbBT/+sMDlMzrt4CTGsubJkNlRiIDOVcJr0zzbybdIFHUDcbQ+Dci1c/pWej77Mg22/xfA5cpWpgfzVXbJgWPLlLvsT/J2eQQ+pcjYCxaHVfajRQHEa5GKZQh1yO+sBaHIpeoVsZB59O/ot5+LnNr9ckaeuwf1WrAxe9AXqH5E/mgIlBZK+5iAAr+TvTjwGPsRPA2TfRUrJ4olPjJeUnKPbiQEeQfP1bmoDuBxHvyMIWWmUAfkYkljK0s6MPfide8ryQAn7eZlSfYDBRuQpFXBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlR2F1LELL7j3sexgwZSKeMDc4U/MCXA8ZeAhv9CrA4=;
 b=mpMcsdnVPMINruP03v6olDO7dD7cxE3ACkU0aWCEH5rdT895QbgeiT6FRBOjB53Tm7eDLw01L/t0if0uLHSdLlUnsyQP1AsHW7malrwlc5mWqY3oiK2p2/jhH4hGehqn+A0SLfAZC5UZ4oNwAeTloIgdnDioIrl10u4KLcjYDUnIVU4nBjpCSiuBF4fdlAB7bzZ2Oywj0k13M3pMMuk0+mcQuAiOoaYU02GjlRtX47/diFIlAuj/VflyEVNjLjNjb1IQ/65zE5Ex0toYlJY1BCUoVmofgYMU3BYGCFV114/G5Ftjd/7pw8XKTkm+K9R64x1lpZ0ca87gMfXWKPdaJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 3/9] dt-bindings: phy-common-props: RX and TX lane polarity inversion
Date: Sat, 22 Nov 2025 21:33:35 +0200
Message-Id: <20251122193341.332324-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d7ddb0-8cb8-453b-9c96-08de29fe16d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r37ldvDKZWLf0sGYNv2qoJ7hjiDUVs5oUFpIHHIxrv2zK6fn0UNHb1dBkgUT?=
 =?us-ascii?Q?qSaz3BvvkwSvw/q2J5MJ3kuUCwM3dbMaj41p9Q9gX6gjlwsfeVlMJKBIISNw?=
 =?us-ascii?Q?WP7j+LqUQGMc7bP0IYf+nw/H/ppTlur6qbdQe2kShC6MpULejA6AlFHf7xrt?=
 =?us-ascii?Q?QfTu+LY4lyVjMzFl3hIysYQVTPniR9juUTcuAPN6R0jnPTMnX03B7umBR31K?=
 =?us-ascii?Q?H6VH7+5KiXgy+K1R7U0paINwg6kkI/dj/pc2RQt849tHPfQ52Q+bXrk5URlM?=
 =?us-ascii?Q?oXT5ZdmgV2aaX0ct4/MRx9/q6Cq/e1RCU2bHflsZm37NRmyZO34vHL0KRkWf?=
 =?us-ascii?Q?2EON72d9F1QsfUVvUZbUJkwJA2+t/LC8cpjcmtEangwpnFhgrAfebD8zy6KA?=
 =?us-ascii?Q?hCwzUBY+HCggO8K/w4r0WgQ6N7KORAOcS/xQirybw7pDEawMKhDskuNxlMFj?=
 =?us-ascii?Q?y347E7+OV0E7JyAkcWQf9OGhPH8iCtfRgmF2m42GUQxV9L+De6bh3IDVzfjP?=
 =?us-ascii?Q?kX8oTpA2wXHVZ8dsoXR0luax0qg1hkOELCQ/fpDc7R9hV73OkqlgtSIRII23?=
 =?us-ascii?Q?o9SPsWNBF+2Y6bFfwINViEU7/T/Zd0EQomOIRaDUzI3VHWYdvMVXnqwumtHq?=
 =?us-ascii?Q?Nd8Drh6t1VRDzFm2zCtpRff8SlHAhBL1ZA0AJBImzifac7u+g3cfGxizrmiF?=
 =?us-ascii?Q?xLTD2WCPynKSBc6/7Eouu/tgjH42B+o4xWoxwKwmuK4WaPRwVKEqxGM6L+iW?=
 =?us-ascii?Q?QF76ApasR6N/f+Z9NfYojfQhSJDGbj2zaO5+n/jH0IZwNVQjw8Q7RF3dj1EZ?=
 =?us-ascii?Q?g/nvUjG6sn5OqWwPA+bk72QC6f6TfoS+Mt+RHRNaGiALTOVKL8SMaSAiUQS+?=
 =?us-ascii?Q?xv56jn7nGgUVKL15XzZUMELjFk8iY71/MY/K0tCNoCdBtqgi4O+KM9/9D28W?=
 =?us-ascii?Q?9zBlHM3Q8U6H05RPHaFMcqRCdG0lUzxYn6JumMitQ0gEa08ax21/PVgaG7AF?=
 =?us-ascii?Q?dbvKd99TVqLIl+qxGEv29uEnd89xRAnIZCjmW54Vk83CeOTImEKBGFcPrAJ3?=
 =?us-ascii?Q?nZVDAF4ob6grQMgnhGTzc/uEQsUFiwphm9qRows4YbJwldihnhGqJ8RIZB4P?=
 =?us-ascii?Q?n+5hOvoK27cJ6DcUfr1n7/PAdoGoDPctD81ZoQsZ5FT385psKDNPWcjKcru/?=
 =?us-ascii?Q?Zf38VrsRaw+/hw0p7V7H0t2HVvLjEaXIHcL8uYNIFf3KxQiM0EQvKxhEroaQ?=
 =?us-ascii?Q?FebgEPFJDFAhIHXP7DhyyXIcVko1Si0TUewcs8ERlHDGLH5DwtimJxPOzj6T?=
 =?us-ascii?Q?+x7gAMFctgkLFLvJUfl1PeExO4pUQcaEbIKZd4bVU1S/ylWzFKt4zWGchwQc?=
 =?us-ascii?Q?YjkVCI68fb2Y5rmEt8+ucs+jdyagO32rdmcTSkUT1pROZIQmMmPi+7QpRTUT?=
 =?us-ascii?Q?7dY6SBr5mMEfdmyUll6YSRj0G0mX84acfHRjQh8i6sc4DouDX4fnFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZtSH5lTuuY3uoynOSmVE1+zG58lb+dbYOJ5os81I2Kol6POUjnpBitAF+pa?=
 =?us-ascii?Q?VpEhIdp2LJb+VrTL3RAqVooAO0oUDJlVbFrqI9xio6JxaKCoQ/52T5UCkMgR?=
 =?us-ascii?Q?Sjg+eb67bGmteffHltff9IcuZ9QeOAvJgnQ5OjHeZfczGJYq/QZq50Ym442Q?=
 =?us-ascii?Q?PMXBeJehwkSW/yw8r/dFjQHr9EcxgW1malQFjcCWqKgtkG3l40UXMihLmLFb?=
 =?us-ascii?Q?NOpGvc8xuCVyDOOHHXQSA7Rk7jCOUtPWCyvIoREhfBUgsBj8q8cerzyNrfhD?=
 =?us-ascii?Q?0OZX9nVF7zjI51f+5sCwg+a3HYlWhIlm7akANZzRhLehb0JI9zJXub/q+9B3?=
 =?us-ascii?Q?2fslKoP/z0Phk1DA611NthETpPTf/q67HoiGr0udydA2I19rsl9+hNti5vpP?=
 =?us-ascii?Q?GPA9oLwwDQ1pncyBkvVQF0f0eR5friWvLOAY7OQUWQ3PKAFDSpvwWQ9um9Y5?=
 =?us-ascii?Q?6hDG9TnOJAF9J17ko2rx92xH8WUWD8IbLZ2gxNdDmbX4QmQYApA2g9XFQl6z?=
 =?us-ascii?Q?ruw2UEBlY8NK4BcqcUH/wa5lKweHWK8w9yYUWnjhstze7OIpzk6nTpvtwI01?=
 =?us-ascii?Q?eK+P1tL+Slbddi2oW+d/VsQ6oFVwtbYlOtkaRMGw7669aoukrfYXqRM6ef9G?=
 =?us-ascii?Q?5Fxk7e27yRaBaOkxu7gPfsOH0nZ5S3Vk0Nj4STNhxqfmCTGJDmUj+Nqlj271?=
 =?us-ascii?Q?YQco0EDTpAqN6fAvbqoCagkCD+7AKVf8ubHDtvAp7mqvhocTdpmG8zc0F86h?=
 =?us-ascii?Q?TCJYFE5w+Dbn97Zh3S4QsVHkRXLRgrrQwbD71fqhzLfSTc4+SOhV6B7ktPUe?=
 =?us-ascii?Q?O/TfdIFN0Xk+eqkG/xpDcjGlf19Lprg5keQrNzgNTkFidFc/6V3kNG2c4E51?=
 =?us-ascii?Q?+/7ThZqjbxL5tkrsfWTcqtuiIj5G+YNZbxvoGLp1MV0ZsomGGfzz4DSwqCoy?=
 =?us-ascii?Q?+E6nC/7tNw+qhFAIKZqSzBIUx4lny7VogJQKoMi3U3dHiENJw/ywM9YHSdwL?=
 =?us-ascii?Q?3mpH1o4c9580+qG/5GHhY/5WgehR77kz2GUWbhiCYADd5hkeSLNfB5a/SrWQ?=
 =?us-ascii?Q?sSCwQdXBXtJc6K72mmVi23eQ0s2YQ+KSBHtean0q7KoB0jpuOiC8u2UYfmVB?=
 =?us-ascii?Q?+bnePACxsW47ksqpvH4511q/M9DDP9LG60yvovA3c5PhzxwN1dTSJY6DxtqX?=
 =?us-ascii?Q?Ez+Jt7ZvK54GxxeKllmyAh8wtiOndkHmPz0Wzcu0L4W9PSnzbpjpAqPCOp4F?=
 =?us-ascii?Q?Y+uQed/gNHO5QkKU8j4bcWzjAr9hZLSSbA8lUSfp4BdOJPh1AvkMYKQmHuHy?=
 =?us-ascii?Q?r0kGc5Hjj7CB7iSvg7AzeSGohfuVyrMP+Zcxp6AO87y5BGSYgUvkm1w9jzos?=
 =?us-ascii?Q?A0Buhi7gBHMYmM74OYkx/tbMjRiFlBh0pEswUtNtTH84ZEFyhJuORIahn+RV?=
 =?us-ascii?Q?j2MZ9U5d8qZzd6GAIanKOD7h43v2dz/SjJB8JFooUH8puVUvEYkPgCHw/LeT?=
 =?us-ascii?Q?+EDS3hyXhSh5XU/rt3G4ndspVYMsW+JwB1e1RYW2B1e2J2/Z8T+Y68MdjeuO?=
 =?us-ascii?Q?aoIf4/gPVpDyLAHX35Bbr9FA826d0x3e2Y48fdlaoq6DuTocSdsg8Eou3M6u?=
 =?us-ascii?Q?cYaaZXkpdd2xr5s7U38XTXo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d7ddb0-8cb8-453b-9c96-08de29fe16d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:01.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VWPMIv6S8vFPqZDJzb/UTdadVuRTt5hCJwh4z0y7Fz6c1C2PgOFPT+m3oYkFE+ldakRNVuGm4uIh6NxdiB4uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Differential signaling is a technique for high-speed protocols to be
more resilient to noise. At the transmit side we have a positive and a
negative signal which are mirror images of each other. At the receiver,
if we subtract the negative signal (say of amplitude -A) from the
positive signal (say +A), we recover the original single-ended signal at
twice its original amplitude. But any noise, like one coming from EMI
from outside sources, is supposed to have an almost equal impact upon
the positive (A + E, E being for "error") and negative signal (-A + E).
So (A + E) - (-A + E) eliminates this noise, and this is what makes
differential signaling useful.

Except that in order to work, there must be strict requirements observed
during PCB design and layout, like the signal traces needing to have the
same length and be physically close to each other, and many others.

Sometimes it is not easy to fulfill all these requirements, a simple
case to understand is when on chip A's pins, the positive pin is on the
left and the negative is on the right, but on the chip B's pins (with
which A tries to communicate), positive is on the right and negative on
the left. The signals would need to cross, using vias and other ugly
stuff that affects signal integrity (introduces impedance
discontinuities which cause reflections, etc).

So sometimes, board designers intentionally connect differential lanes
the wrong way, and expect somebody else to invert that signal to recover
useful data. This is where RX and TX polarity inversion comes in as a
generic concept that applies to any high-speed serial protocol as long
as it uses differential signaling.

I've stopped two attempts to introduce more vendor-specific descriptions
of this only in the past month:
https://lore.kernel.org/linux-phy/20251110110536.2596490-1-horatiu.vultur@microchip.com/
https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/

and in the kernel we already have merged:
- "st,px_rx_pol_inv"
- "st,pcie-tx-pol-inv"
- "st,sata-tx-pol-inv"
- "mediatek,pnswap"
- "airoha,pnswap-rx"
- "airoha,pnswap-tx"

and maybe more. So it is pretty general.

One additional element of complexity is introduced by the fact that for
some protocols, receivers can automatically detect and correct for an
inverted lane polarity (example: the PCIe LTSSM does this in the
Polling.Configuration state; the USB 3.1 Link Layer Test Specification
says that the detection and correction of the lane polarity inversion in
SuperSpeed operation shall be enabled in Polling.RxEQ.). Whereas for
other protocols (SGMII, SATA, 10GBase-R, etc etc), the polarity is all
manual and there is no detection mechanism mandated by their respective
standards.

So why would one even describe rx-polarity and tx-polarity for protocols
like PCIe, if it had to always be PHY_POL_AUTO?

Related question: why would we define the polarity as an array per
protocol? Isn't the physical PCB layout protocol-agnostic, and aren't we
describing the same physical reality from the lens of different protocols?

The answer to both questions is because multi-protocol PHYs exist
(supporting e.g. USB2 and USB3, or SATA and PCIe, or PCIe and Ethernet
over the same lane), one would need to manually set the polarity for
SATA/Ethernet, while leaving it at auto for PCIe/USB 3.0+.

I also investigated from another angle: what if polarity inversion in
the PHY is one layer, and then the PCIe/USB3 LTSSM polarity detection is
another layer on top? Then rx-polarity = <PHY_POL_AUTO> doesn't make
sense, it can still be rx-polarity = <PHY_POL_NORMAL> or <PHY_POL_INVERT>,
and the link training state machine figures things out on top of that.
This would radically simplify the design, as the elimination of
PHY_POL_AUTO inherently means that the need for a property array per
protocol also goes away.

I don't know how things are in the general case, but at least in the 10G
and 28G Lynx SerDes blocks from NXP Layerscape devices, this isn't the
case, and there's only a single level of RX polarity inversion: in the
SerDes lane. In the case of PCIe, the controller is in charge of driving
the RDAT_INV bit autonomously, and it is read-only to software.

So the existence of this kind of SerDes lane proves the need for
PHY_POL_AUTO to be a third state.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../bindings/phy/phy-common-props.yaml        | 45 +++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |  4 ++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 775f4dfe3cc3..538b85559113 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -93,15 +93,60 @@ properties:
       property. Required only if multiple voltages are provided.
     $ref: "#/$defs/protocol-names"
 
+  rx-polarity:
+    description:
+      An array of values indicating whether the differential receiver's
+      polarity is inverted. Each value can be one of
+      PHY_POL_NORMAL (0) which means the negative signal is decoded from the
+      RXN pin, and the positive signal from the the RXP pin;
+      PHY_POL_INVERT (1) which means the negative signal is decoded from the
+      RXP pin, and the positive signal from the RXN pin;
+      PHY_POL_AUTO (2) which means the receiver performs automatic polarity
+      detection and correction, which is a mandatory part of link training for
+      some protocols (PCIe, USB SS).
+
+      The values are defined in <dt-bindings/phy/phy.h>.
+
+      If this property contains multiple values for various protocols, the
+      'rx-polarity-names' property must be provided.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1, 2]
+
+  rx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
+  tx-polarity:
+    description:
+      Like 'rx-polarity', except it applies to differential transmitters,
+      and only the values of PHY_POL_NORMAL and PHY_POL_INVERT are possible.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1]
+
+  tx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
+  rx-polarity-names: [ rx-polarity ]
+  tx-polarity-names: [ tx-polarity ]
 
 additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     phy: phy {
       #phy-cells = <1>;
       tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
       tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";
+      rx-polarity = <PHY_POL_AUTO>, <PHY_POL_NORMAL>;
+      rx-polarity-names = "usb-ss", "default";
+      tx-polarity = <PHY_POL_INVERT>;
     };
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6b901b342348..f8d4094f0880 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -24,4 +24,8 @@
 #define PHY_TYPE_CPHY		11
 #define PHY_TYPE_USXGMII	12
 
+#define PHY_POL_NORMAL		0
+#define PHY_POL_INVERT		1
+#define PHY_POL_AUTO		2
+
 #endif /* _DT_BINDINGS_PHY */
-- 
2.34.1


