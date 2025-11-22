Return-Path: <netdev+bounces-240969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74BC7CEFD
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1594E3A9E75
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DF2F1FCC;
	Sat, 22 Nov 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mC8ZKL+i"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B01F09AC
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812548; cv=fail; b=fXbNwJw5hQRcEjflS+FrDjpCssVzlTZUu3TZFxDH7eYqO7cf//90a9MQIm7+tQoN+w5wHIybqCyQd/ThC97/4bbv5NDHMBXsNGB64Klnfja23muTyl90djDbwfE9vRzXPQpdQ36gQbZed4rj2FsQYq4aG4qbqbAlCWTvi6ij+Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812548; c=relaxed/simple;
	bh=vpd++1c8U96A3q+HzoVP0r0bkaYWyWkSGlacVo1mo0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LjYRfL6pHmOdvqyxYxxbnMqfiLPC2bCYYw0HznSfKoovnEgqgJLjJdZfD/SI7EaRBsee+18ce6sSmFCPNSSS3d4z05NhMtaAGiGRqmqiV5wJBMUlXOf2o/a0gaRZZ/fDgOKMVs3A67ILyDAcM87Tgqqq8VMGTvmJIS6VPma/WGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mC8ZKL+i; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/JOXCe3MDAwj6egxJmbBjPu13dVb2Cp3Bggour51wK8ap8UqU+Kb+cmnYPtKukc5Vt4LK5wBLrpcBbQ6W/WaVW1E5/PBzOXPEx2t29jbeiaIktdWkI98PJo+KVs02uxGPn6XvdRCrQc2b1iZHA03NcM2BGfb9JIq4GB3y7eoQ5b6BDPHHLqL6tR0ux0TgDulgAvrW4GVDxgYHJRdDKcS9fwbhzqJVkNnP/shJNwiGfqZ8AvLGo420QedG10TRbES4GSjvv6QbL/KjIYS1ADXzCxS5WFGR9qK9i2yUOSp1ys92QVkDq/sDiM3slHuBalfdTWtKW0J52bcl50GRAZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9kFQSe5KkzF8zcgsSN54U31MOqVvKJFUSzehUkHBUs=;
 b=UNm5Vyad9EpR2pk09Lgzil2t3pGKfrwv5lh+muwIpn0CGpROhR0LU1U+sP9NXHbRNpCIMrdfn1f6JpMgjkAG5xo4VHsT+mQ94648rZpKYsXUkwj10Ja1RjB5DDAagPhr8ln5iXluOEVQvMOLYCejLM97zyNaU3wLZiNl1G/xFX9CpClgSnNL25oCeUbw/Llz33OXHcl82+ON3p+QOUd3mczHNZLm/NQwvisVdkR+dD1vFzcWF9Fw94nWiaSJO7dsdUQ4dSSJu0idS5S/tDYx21mzNQKDQuLAdkFpO5s1VVEIkSvSKP939w7nZ+xqcYAsLkzBR4S6pb1QYlIfdaQk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9kFQSe5KkzF8zcgsSN54U31MOqVvKJFUSzehUkHBUs=;
 b=mC8ZKL+iW1KjAd3Cg8rSwgZDTUl0O/M54lyMhsqjo3kg3xcjaXiAoZ+t+shWIN94vTioSaSg8wjLfZJBjGx7pcC/zJTwudUCB8N2uDUF6BbBkG4f9CTCu7OwbpBuO6zSQB0rsrXniNtzUp9XKRabEcQQqo1iyEBqFRc6adXJJEzqV7JR+j+2E+IGknd0qrbzfvVPVWJ04qEltSqtKQU+9emTsighxZMyhO7p1iQl7XhYF76te3KRSpKTxFvzMylVU4paNsiKpYaPEsgHveoI7g0o1UeOrrbwQ4H/giPF8OOgWGQC16otYOkB4okzvJY0m6MY7BAe3kRGZ5m1nq2Png==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11356.eurprd04.prod.outlook.com (2603:10a6:150:298::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:55:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:55:41 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: [PATCH net-next] net: dpaa: fman_memac: complete phylink support with 2500base-x
Date: Sat, 22 Nov 2025 13:55:23 +0200
Message-Id: <20251122115523.150260-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11356:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cca0cf-2431-47b6-3205-08de29be0f2f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|52116014|3122999009;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nW+hQ15Vc/IAz2gF44+Q/k5udV/9kNmU7uvmQ4xedHdN3s+nDqBIkCdUkTu3?=
 =?us-ascii?Q?QqY+6dj+06ic+5JQtMnvZ7+WstdO01604fGJhuwq3hitjGosPH1H+bZ2GPy1?=
 =?us-ascii?Q?DGS3HEJO6LfYgkHJmbh3PPMEFkzq0+lhGV1n0wUj/dGfoHbxseo4ARBnbZKP?=
 =?us-ascii?Q?MZW4BifD7fNRZlBj0AsmiMfjrQED1uj5Z6Phw596oCoqn0LpNIe/sQLnkQpP?=
 =?us-ascii?Q?Aq3QYFzPAoVfR1aETK0exHtnl3mwKAN1NuP/UqHJg6ggr9+zfN5jM7iDF4av?=
 =?us-ascii?Q?NSb4U4opjTTyIEifCt27KUUP6lAsu8csJCmWlCzplqqalUlpAw2pDbZatXs2?=
 =?us-ascii?Q?Aci0C6UIb0EjH+ORyy8BYWyhxI/r1yOUvej117U2Lur1A1gzjlbwbEv5B/Ky?=
 =?us-ascii?Q?FJbj74VMV8OuALclpvfd92fbb0TBXNaPyGZ4MFpZ90BwANuCXJf3Z8spvpGt?=
 =?us-ascii?Q?hwcIX7AEUTGD+5AL7j42qZmLbloAFxdR/ySx/2+hHwC7dh962roqMlwiQP/j?=
 =?us-ascii?Q?thJ5yxPL3lYWtRwM2yKEOc45jgYg/47b8K8CDMK7rQfc9Bde6mKW4nLpycLk?=
 =?us-ascii?Q?2yCoZ+oSthXIhrgRI5j7eYAWbeHCbf7lO+5FAYIP4BHBW6WL0mlts0z8uzEr?=
 =?us-ascii?Q?+lt0MQ6s+8t2Yuwl9xTwJVPnPrpy2MYxGGDBSa/BGls6L1SEZeq4ixJZh+Sm?=
 =?us-ascii?Q?4kNkOvyJ0sYu07hXE7DL7VqD/W1w7yMH+kjoXTXgUazF2HHfFYQ3a436Oyuc?=
 =?us-ascii?Q?Ls6Mg+LkOU1gFlglsGnotphoWLanJbpsG3OGSyaAcG3JyoyaoXneQ2CYOsj7?=
 =?us-ascii?Q?1tQJShkPFX/MOZxllDAY9nws5/cG1GvApZAWLSqtHKnyXfAEnEaA9PxxZbBm?=
 =?us-ascii?Q?d+LrNvu7jBdZQu6Ru4BgrfRHiq3HMpxD8cgEFyeivFLmv+sd0E8JLPAmhQuT?=
 =?us-ascii?Q?DVwgEheeDhiO6Gu0wemKPu9GZB9aq3zjU9J+gjIC/HWdSEuH7NbFNNToEtlO?=
 =?us-ascii?Q?w4nbmmdb/sTRNYquKPIXuZMJc4b4YmNRBkPmlUDLkVUwm52Crs+hmrmEhT18?=
 =?us-ascii?Q?pen1XiE4tJ4pthFXvBFdp+AvDed/h3omq70tYdKXqOScmIbtJM/YMHmcTuo0?=
 =?us-ascii?Q?ZjO3AMivBt7UKNllwFAulIyeia/ZP9ZxmZTjE4PTNuaUfGwSdGltygR2JSU1?=
 =?us-ascii?Q?KGs+3Ga+EyL1hXRTI71ThSr/kovjElXcLoOYe3Lljb7VfKlGH5IUX+0yclfN?=
 =?us-ascii?Q?WZfD4Y+oLs0Lw9mcalIcKsYPsZsRcP1plzqk22EHHT/61FyzBgta70gUHC7r?=
 =?us-ascii?Q?oXEWS9YT5smoP+27nSlo7/BEQr2RvucWG3V9nxA2Ij4TEqsgcs2dOYgOmp8m?=
 =?us-ascii?Q?nhhwPwzTS2623WZsMD2jq34Z+XFOweF3AvIe302rJjSP6g5PN2NSeQkGnfKk?=
 =?us-ascii?Q?5GSo51Q3Hx7GFCXg5kJTbeKl5jIsjIYwjWkrIgkuDgC8CSmCLgQIkA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(52116014)(3122999009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?0FShiM7/xkBsgtK/0inVI/Zxay0uVxJ2lKJl2fpJEdX04POiywrUJAXrrpXa?=
 =?us-ascii?Q?cF2Yxk3zFhtuoPCIE3TO2AbXsolaI3NsvELbxfb2j/j7dENg2DT9D4M5cAqv?=
 =?us-ascii?Q?q2kEJdMaaP+cMYOkodJynmjX/VG8Dyf2TjClE862wTcqpAW/8zVZbdeEoOZf?=
 =?us-ascii?Q?AIlTVtczEBS88l/6QXtAuPCODmF2Y4dIQ0PjupFudK4tO0qoD7gLjpvzECRu?=
 =?us-ascii?Q?mCCu2WXLxcuibw9R4K7l5DyeNkYg2u6l/OsKHM97Qz9h+F981YMgiURjPFKt?=
 =?us-ascii?Q?kOT+ZJefJvPrTryBiwnG36WEduQU/SW0GsiKpvhB5BY/izfCwYQzw/lcP1Hw?=
 =?us-ascii?Q?GCChuMt8SsiCpmWcWi5Cs0bBKaQb7MF12nmsgA4hbj3G8GeMuh1lJusTbF1d?=
 =?us-ascii?Q?A/APWHWaP7UuFtRNFHLfdaB7BjycvXLN51lxpxLO9yiHxHGnbOzRrkoYtqPx?=
 =?us-ascii?Q?hHlW9E4TkHrGAYqNY9uWbYpFIvoBdl87x0pM1AA4KPILU8sF/DFLDEZng6pG?=
 =?us-ascii?Q?5BPcX0ZxzD4ZHjlTpxTFpaiUpHyuw5exnXf6/UziYmFm/h3d0sm+8FtHysmU?=
 =?us-ascii?Q?TnyHMpzDniR3Rb7xHOsZ3zZ2IE5D3LLracJCRCnJL6qW/apgrNLgiO5p8jr6?=
 =?us-ascii?Q?dpLm51rvs9+xCahzJeDdgioRjR1wk+AdjtvmqIUTq7RdvxWhQSVJP81VEAeh?=
 =?us-ascii?Q?r5TIepqsWCNSzKni+mzb1dq3mwrFqecQ0YLv8azpw3PMgX14U9y2enamU8Vb?=
 =?us-ascii?Q?76E/bACbym1tgKXLmiE2X7XbWZV/TeOTlAHNziliz48Q2o+d0/7IHU8DgghH?=
 =?us-ascii?Q?w95zJQgxSpLbT0l0z0pohGMkUxUKBb7lzsQgWCDs5dfbBmt6IQn4DrCeZqOI?=
 =?us-ascii?Q?/YM0JPE0/EBNroqqZeai4hlvZfzFUXRjQOWnEFM+psYB4GeyZwSJ2LgwUFAI?=
 =?us-ascii?Q?ehbpi8OzoaP1e/5KpIPmibmM/ENMJRTXujTh2MERYEQQjml+jBZmicFBeXoI?=
 =?us-ascii?Q?I6/HxFzopE+te5yUui3Q0G5PSylDg9y/H/HS7yxw9d+VZGpHjk0LCjuV8wWd?=
 =?us-ascii?Q?n/0iY+R0LL11w+GcBr5y4QFwZ9gJsmzc/kNr9TO0FA3x3vcPHzlsxPp2dWQE?=
 =?us-ascii?Q?DFiRHSe3Kyi8qNMHK/nSOrYq3/kbfcYq00kkjGnUZy7huuGsxU3K1DudMqAV?=
 =?us-ascii?Q?o15EoiZtkJRH83WfdIHRMBDrgYqPO8r7D4kJwGCnztC7RtpsocLvkU+kqMmL?=
 =?us-ascii?Q?DqNMMbNjHy1tO/GWL644E6ihAOF7y0FzD4+iax4G3ts5MZQBEAvgOPlReLbk?=
 =?us-ascii?Q?+DWxObnVhkJ2fRjlL6aWoQQOefGluoLbpWddME3Pnap75ymeVvjfXe4udSmn?=
 =?us-ascii?Q?huMvTaJynHG1CKmpiTDLOPNhtDUgjG1xOgT/nikVBEDddMnrm90+GtTHGxVt?=
 =?us-ascii?Q?MInBNMeoT1kWudmYJt6Hr9FfRf4HPc/AzMxo5fdyHXQdbVrZSvpnbrBDX2DB?=
 =?us-ascii?Q?66Jb3Y8WYHoghcZHBMgy5YfYZw9f+egoAsiRBTei09lURiXa8gaxgGq7546p?=
 =?us-ascii?Q?8pW6luPY8uQHpQ5OMQDHUYGKeM/XJ5Tf9cWMI8w/kFcs8HTcO0VcLMUKXSTh?=
 =?us-ascii?Q?SEqFE/pu1Y/noe0/t4+NYV4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cca0cf-2431-47b6-3205-08de29be0f2f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:55:41.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wliq5FH6KbOnty0UisI/uDwoGg4m7/qiNbDKsaExlHa9whyOsp0cHHTSztlBbGz3lnlOLXsWa1E5P2NfQbXqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11356

The DPAA phylink conversion in the following commits partially developed
code for handling the 2500base-x host interface mode (called "2.5G
SGMII" in LS1043A/LS1046A reference manuals).

- 0fc83bd79589 ("net: fman: memac: Add serdes support")
- 5d93cfcf7360 ("net: dpaa: Convert to phylink")

In principle, having phy-interface-mode = "2500base-x" and a pcsphy-handle
(unnamed or with pcs-handle-names = "sgmii") in the MAC device tree node
results in PHY_INTERFACE_MODE_2500BASEX being set in phylink_config ::
supported_interfaces, but this isn't sufficient.

Because memac_select_pcs() returns no PCS for PHY_INTERFACE_MODE_2500BASEX,
the Lynx PCS code never engages. There's a chance the PCS driver doesn't
have any configuration to change for 2500base-x fixed-link (based on
bootloader pre-initialization), but there's an even higher chance that
this is not the case, and the PCS remains misconfigured.

More importantly, memac_if_mode() does not handle
PHY_INTERFACE_MODE_2500BASEX, and it should be telling the mEMAC to
configure itself in GMII mode (which is upclocked by the PCS). Currently
it prints a WARN_ON() and returns zero, aka IF_MODE_10G (incorrect).

The additional case statement in memac_prepare() for calling
phy_set_mode_ext() does not make any difference, because there is no
generic PHY driver for the Lynx 10G SerDes from LS1043A/LS1046A. But we
add it nonetheless, for consistency.

Regarding the question "did 2500base-x ever work with the FMan mEMAC
mainline code prior to the phylink conversion?" - the answer is more
nuanced.

For context, the previous phylib-based implementation was unable to
describe the fixed-link speed as 2500, because the software PHY
implementation is limited to 1G. However, improperly describing the link
as an sgmii fixed-link with speed = <1000> would have resulted in a
functional 2.5G speed, because there is no other difference than the
SerDes lane clock net frequency (3.125 GHz for 2500base-x) - all the
other higher-level settings are the same, and the SerDes lane frequency
is currently handled by the RCW.

But this hack cannot be extended towards a phylib PHY such as Aquantia
operating in OCSGMII, because the latter requires phy-mode = "2500base-x",
which the mEMAC driver did not support prior to the phylink conversion.
So I do not really consider this a regression, just completing support
for a missing feature.

The FMan mEMAC driver sets phylink's "default_an_inband" property to
true, making it as if the device tree node had the managed =
"in-band-status" property anyway. This default made sense for SGMII,
where it was added to avoid regressions, but for 2500base-x we learned
only recently how to enable in-band autoneg:
https://lore.kernel.org/netdev/20251122113433.141930-1-vladimir.oltean@nxp.com/

so the driver needs to opt out of this default in-band enabled
behaviour, and only enable in-band based on the device tree property.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Link: https://lore.kernel.org/netdev/aIyx0OLWGw5zKarX@shell.armlinux.org.uk/#t
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 0291093f2e4e..d32ffd6be7b1 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -649,6 +649,7 @@ static u32 memac_if_mode(phy_interface_t interface)
 		return IF_MODE_GMII | IF_MODE_RGMII;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return IF_MODE_GMII;
 	case PHY_INTERFACE_MODE_10GBASER:
@@ -667,6 +668,7 @@ static struct phylink_pcs *memac_select_pcs(struct phylink_config *config,
 	switch (iface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		return memac->sgmii_pcs;
 	case PHY_INTERFACE_MODE_QSGMII:
 		return memac->qsgmii_pcs;
@@ -685,6 +687,7 @@ static int memac_prepare(struct phylink_config *config, unsigned int mode,
 	switch (iface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_10GBASER:
 		return phy_set_mode_ext(memac->serdes, PHY_MODE_ETHERNET,
@@ -1226,6 +1229,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * those configurations modes don't use in-band autonegotiation.
 	 */
 	if (!of_property_present(mac_node, "managed") &&
+	    mac_dev->phy_if != PHY_INTERFACE_MODE_2500BASEX &&
 	    mac_dev->phy_if != PHY_INTERFACE_MODE_MII &&
 	    !phy_interface_mode_is_rgmii(mac_dev->phy_if))
 		mac_dev->phylink_config.default_an_inband = true;
-- 
2.34.1


