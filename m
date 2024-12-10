Return-Path: <netdev+bounces-150886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87449EBF6D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7660416788C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B3225A22;
	Tue, 10 Dec 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fq8+0O/n"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96D21129F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873762; cv=fail; b=ZPJ8aKQ1i5SvqfWSXY34YvlRa0O+PCepgC5urbr8piwDWijQGrH2sQtPzYILPWX4Izi7nLxbixb8a5E3L67OWOkJLeH67/yjof2o/xmTFptJ7A7RNGgQPhfW1LBYCq8wvcnqcF0uw5L56VO+JO7rng7uCaKUQhXTYzedujELuHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873762; c=relaxed/simple;
	bh=lQNTUJTheCBLHHUOjB03itqG1p9bz0q5U7t6aUI3Vxw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dDlvynKnCKioBRNS+h9R0KMARVCP4TaAWJQZZeTZDwmp06V7EGDorkq1kxeMbs5bvXTEOZ1niHi8tAJZxhSli5eQbdZAhBDtfMtg1PcPKs5CaD2UJRjy69vRQBlZkmwYAynRp0awjOPCwrphm1wP+556B7AwIFW5xc0AYweIvNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fq8+0O/n; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i73YE/n7kut1boSqXFeeD2SW7AFu7CPDtMTzOig+Su6zpQ+JZKjF2d3ktsqgcwoFxVXY8DSxK0wIBVu7eJbaO95jHPs7/RY9Cl42sE1nvGfyeuxqS6TzjXJNOHyZ986PmtK8k7O4Yjhpz36beVXIQMv/K1FJ2UaZB1keiKAnEmv6BUa3Td3Mv0hiqqs2IffyHFNwBzddvy0jx6jlX+1ILhTA0QlCEW/7eoj9Xro1otfU1/zoW3/g+Eq2h+3sJaHHFChmgZg3hvQYP4syhPCEQ4ChqlL0J+1cbp6Kh+AOWN3eD8gYVLURbaAMFY0S3fFagExIvNMuc4bQnT1jq5dJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQNqSrp/AYQh/idFU8IFEvKEOZBmm/dvKgO/dRjvtSQ=;
 b=AMzsraFuifZBlmuaASOb8A84nCIb8jQhCAmkjiQAx4NWs7gNct4cIbNx3n7RIXsjmQ+eaqDnsnHcnk8iXdfx4ahe6uYhS/ptmCA1Si2vGdPwJAxJPKWDVGbqhANkIoYK9LUFl3EHMNnmhpNsWwmKrip9hw6m/tztRlBKDN8ZA61GdJyVakB34Zlcp9QWMgyraGxGJG4IHSAc5BN+G2HjqgqQf4tpUX4kLjzYEeC/6rNK+ShYq1xeNV32aLYNCfd41O9/gl6aroYtcM5GXeFW2PLWuX00tRpIvhilfMgPZnQzdLAQb7e+Pc8mkL/codWQgnf6dv0VuJT2AooFnfvvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQNqSrp/AYQh/idFU8IFEvKEOZBmm/dvKgO/dRjvtSQ=;
 b=fq8+0O/nJMzY3bMgTCjraijedn1Bi+dFZ5kA7tciOI2XZqz+ymc1PUtrDSMuPDnTISt8WpaiL3DSApaAm8pSHXlpUtCBkad6ME2+vlHwKUiklN99D3096frrc7W+uVvNK7COtWUoHJOgFfPenrQpeJSHXVtAkIVe6tM8Axf/7+nntvmVGgGWRIlyh5odQINcd3LJZVUH1570edExBc+T/rTp/D+8HAW0nzdKEF/TfBgEtKC+9U0ts7Qwvg2zzRY0wmDRDA0VApcOlCuCtaiVE7bcXoXT1HL/Pmvr/ei/L2T5o3Ia7epopBYnYGdbnkAHxhWDN9cXNfLUY71m1KWWzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 23:35:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 23:35:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next] selftests: forwarding: add a pvid_change test to bridge_vlan_unaware
Date: Wed, 11 Dec 2024 01:35:40 +0200
Message-ID: <20241210233541.1401837-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0161.eurprd09.prod.outlook.com
 (2603:10a6:800:120::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b774459-153e-4e94-fce9-08dd19736474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOgEy5Nm4x7hd678qslm5i10q5iqEI9Y6FUq6KBA0GKIQvfwXKOjSnGVKTD0?=
 =?us-ascii?Q?aKQYqfg26X/ylSMB3nusN3ydBq5cNOgyunqG/aFRPNABMlmePcnCixY0GgFI?=
 =?us-ascii?Q?ngSMP3KPPB3rKoeu2GIwc8BubWml21K5L5ybLj3tvCZB0KS20Y+vufcZ8mT9?=
 =?us-ascii?Q?IVyEh0v+EUfhvTZ/c75r1rbdrltzObJsEu75DST0kydqXp4agDLjWYsZzxOs?=
 =?us-ascii?Q?+ueBcyhMKHP8Oarq5IxsjVvg3B2H+oX5cqe050aE82rdVlAbGlvsKaYnOftG?=
 =?us-ascii?Q?nl4Kw+cs8bLaX5k8d+NvQlvf7q13VY9Z6GpU0k/dqyjOy8auUKqa1WOM71Yj?=
 =?us-ascii?Q?aTPOAv5cO9Lpa0ZG84iyMdBgmOj2kviAE8x6wSyZl9cwDmcwd3TjsvF2rN+V?=
 =?us-ascii?Q?XNHEZqJaNaSSV587BEzXivuOuHVwjMchxPbqD07CLEsAwd79u+RiVHNJDBmJ?=
 =?us-ascii?Q?GWHOT648zEdU6FGlfjyJpBcwwxWUe6aQYlMf9tg7SkknOklbfFTDFm6as+pe?=
 =?us-ascii?Q?zvvMuRDcCsckZEE+dmw51Bes6XzrvCV70obD0ZC1YmN99KzdlgAH81SVM8fM?=
 =?us-ascii?Q?mlzeTHtyJAZZdjxzLTsURxBdLphgnGp9CpeWqqfu8zdvKwU9rov2OZmnAUwE?=
 =?us-ascii?Q?VLyBu7kO43XemtiPpCDb3jcgM9WuKh6DZ9rfgPPzwgp/6B8BLk4nh5b+4XI3?=
 =?us-ascii?Q?uP4p82TYsvHv3OvVrzlYhUj+wCApjedkZrPHv7G1Nn8TLfPHwFCLJZtpiZVF?=
 =?us-ascii?Q?tSwdfLQneY73XRMbbBd3k5t5w/DtwRJx+oLs0sWc2gk0eGQMpyOLP71baVdG?=
 =?us-ascii?Q?Ra7ArhTN4dqOaQs9eKJiaps/0G0PpKVOCFo+WMBc3LI53aXeG6IIweTtzYPv?=
 =?us-ascii?Q?Z97m0puXsTr/sTaatXVvjU5QEscv0QvvBaw0JtIqXGQHmLcfBXF/6UiNUko6?=
 =?us-ascii?Q?KOuBUreqxDnQ2zt3iXX7BR2Ref+1d8mVM3sOhmnR3+ZMkyxTTqIis8q51sTK?=
 =?us-ascii?Q?dIFQIv/QlQ7RQzgnoAuytkfW0xWzjWJenGgtEfAqd9mBfOI+QQOVoHsCI/6/?=
 =?us-ascii?Q?a5txkXcHl249Z04yO/faKdRmwq3rtYYraBtL+LRwBx8tve/kGaOF1ID9aE/f?=
 =?us-ascii?Q?j5N1slWR9+blOUV5Eopvf1OWfhcgUItqCfOTMUgA6Erf7mXelQ1U3uVrC1aD?=
 =?us-ascii?Q?TBN5BflnX1D8d7MVpHXoysMS8zx81257e9LB1XI3pecsNOHudYKC6+PZl0dN?=
 =?us-ascii?Q?vEtAFr1wqZXoGPnhKSY85WFoiPxHAItBTzKmgnkaEcwsGbmDtcjB914u25JY?=
 =?us-ascii?Q?UWdyl+CT/XqDaxux9vIjcS/Ef9V/THKPq+AQuYbRjiIei2Jj35yHkW+Iot9Z?=
 =?us-ascii?Q?vOiuKEe8Vk7uQ/jF3mC/OrV02X9a0kVDZzrBl1Gj8GqucPeqpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3HWkPFJhp1XwKLNMbJahyil781IPE/DgLvcVtfHfDlkWJJFIEfH4657o4Wc?=
 =?us-ascii?Q?jBht5mIX+W9zElABsQpv/cn/Hw+Dz7UMlchLuzkZ69Ivlfaot4TH4AzkUmGG?=
 =?us-ascii?Q?KAGHcBH3RF9yl0RE31l7gXwfZPZ9acGOpxC89RImh4gS60HVaZNlsVSyNHWX?=
 =?us-ascii?Q?3vD4x5EA2PeTzW5L8NzReAQ4N0oKiMFzjbs1m4TZe3hrPLDfZRi7X0AEUlEi?=
 =?us-ascii?Q?JGUqBah57TFxY3ieafSG896XImdx2DfFkqHZ4vOQfL8GGxZyrPWrjaQAxkrH?=
 =?us-ascii?Q?0dnotmvg42jKh/Ppd7C1iU5HgXsJeUNTnK8NJLmPRC3+vLPNbrgtYgwZKRUB?=
 =?us-ascii?Q?nUc4SKM4eGDILDNkrNjLhjP6vFHNGpfkyRJVcK5BQ15rJQdEo9q8nDjpKTe3?=
 =?us-ascii?Q?Q5lnzvcsHHjvfbeoaT5xby197T1aEWFIbKZJcpsthHoCCdVTCv4XxjkMr4+U?=
 =?us-ascii?Q?FMbuZZDGq+PqbwmyXY6ecJ8fYWU/d9ufLNMHZvUGjAcU8Sxj8azXxAgIZolZ?=
 =?us-ascii?Q?eh0vPsqFr83Xbegmzjp2EwUEVnrR6qJX/K6winioJSrRPPAk2WJUMQuXZMNP?=
 =?us-ascii?Q?AnAMA63Z7q5e/Tya4oJBdaUoTfpg/BCXtka0TbfRCT+BXFOtpq6xFTDko+hj?=
 =?us-ascii?Q?cBZAfQVEaxHqwkOt27whlPG26Lvs4pzslEYl5i3uGD0JDN8Ynw2S0jSi7C63?=
 =?us-ascii?Q?f7lBoHTBZCnPHOwcFkRtwFmfIsTnkpj+G2VctGc864KakkUtxBambRuIPKVD?=
 =?us-ascii?Q?JkikBjcxCw7b/3FVnjXCmvu8mZzGNvxrbzlVjqOdiZIBPeO3WCRD4j+Drdyd?=
 =?us-ascii?Q?fdtunwVCeivPwpSkALr5BVD8WdAZvou5ebzVWEgJlEwG6ZhZShoQDvBCmubM?=
 =?us-ascii?Q?AcvqMpSAgf1qFMufVHOujFkBFdUzL/JNlAXQFB/c+RFMwHKPhfixyAYQbph4?=
 =?us-ascii?Q?NY1Lov4LuVUHRagCKqrOzXB83+twT0zx/nbHdv657O5dTWLsrg5uHshBAwoc?=
 =?us-ascii?Q?34Z6k2gjfAg63iI02vLV+vKX0Ti3rkQedNRfhFDIVzkjkuGOzxkcesBn5z6T?=
 =?us-ascii?Q?oUzFdqk+vCJuu5g9HeINQr5F/pywQ4jQgsQBZJigdNjXDrKjCiLss0P9ks8R?=
 =?us-ascii?Q?mVP8lDM8Z2QySGCEXerQQc0nAGpsDczrQ56y2w8A8iDnQF4G789eVBJrrOoP?=
 =?us-ascii?Q?295WYQqnHU1mOCcQ2JBF7GZ8Jt881q+5dCJ1rlYHRSB7Y22sWLEiO25iEle1?=
 =?us-ascii?Q?Wyvh0f0e95o/5FmlFoNBfYY9uGf+MqqPGMo/9MLnbq81MbiYCF1o8/haQdHx?=
 =?us-ascii?Q?L1Stynw3iUD5wC7SonUeQk/+Dc6SSWz0W6fYm0Ufdg6bK9GdmocRSwLN1rZY?=
 =?us-ascii?Q?g9lG0DWiLrsXxjmZjIp2jY4nQmTsQJNfURKqZ2BaY0iH8hDxYY+aXr1azPwA?=
 =?us-ascii?Q?CqOaIjkilr0kRLqrXLnyGxDdrJ8AI9WLBa7WN4rfNbBIj+yvk9TXXDoezaHp?=
 =?us-ascii?Q?LuFFr/GXABFFoSWafZif4y2kRDB+8bqFZzboOUb+PYJHmJUAw/hkNNg45GtP?=
 =?us-ascii?Q?AclR7zhlVuDDnrqvku6KFE8AiprDWFpIUu6Hsbub0CW/CfX0Hu7fez/9PC1k?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b774459-153e-4e94-fce9-08dd19736474
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 23:35:55.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0IfmDTbKXP53ZHPRHX96Ggj0/9CUanRUIUdRypPYbU6b7aOZu82MRIrvAyGuQWmTTm1oBwhfNxWHQABPpI/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

Historically, DSA drivers have seen problems with the model in which
bridge VLANs work, particularly with them being offloaded to switchdev
asynchronously relative to when they become active (vlan_filtering=1).

This switchdev API peculiarity was papered over by commit 2ea7a679ca2a
("net: dsa: Don't add vlans when vlan filtering is disabled"), which
introduced other problems, fixed by commit 54a0ed0df496 ("net: dsa:
provide an option for drivers to always receive bridge VLANs") through
an opt-in ds->configure_vlan_while_not_filtering bool (which later
became an opt-out).

The point is that some DSA drivers still skip VLAN configuration while
VLAN-unaware, and there is a desire to get rid of that behavior.

It's hard to deduce from the wording "at least one corner case" what
Andrew saw, but my best guess is that there is a discrepancy of meaning
between bridge pvid and hardware port pvid which caused breakage.

On one side, the Linux bridge with vlan_filtering=0 is completely
VLAN-unaware, and will accept and process a packet the same way
irrespective of the VLAN groups on the ports or the bridge itself
(there may not even be a pvid, and this makes no difference).

On the other hand, DSA switches still do VLAN processing internally,
even with vlan_filtering disabled, but they are expected to classify all
packets to the port pvid. That pvid shouldn't be confused with the
bridge pvid, and there lies the problem.

When a switch port is under a VLAN-unaware bridge, the hardware pvid
must be explicitly managed by the driver to classify all received
packets to it, regardless of bridge VLAN groups. When under a VLAN-aware
bridge, the hardware pvid must be synchronized to the bridge port pvid.
To do this correctly, the pattern is unfortunately a bit complicated,
and involves hooking the pvid change logic into quite a few places
(the ones that change the input variables which determine the value to
use as hardware pvid for a port). See mv88e6xxx_port_commit_pvid(),
sja1105_commit_pvid(), ocelot_port_set_pvid() etc.

The point is that not all drivers used to do that, especially in older
kernels. If a driver is to blindly program a bridge pvid VLAN received
from switchdev while it's VLAN-unaware, this might in turn change the
hardware pvid used by a VLAN-unaware bridge port, which might result in
packet loss depending which other ports have that pvid too (in that same
note, it might also go unnoticed).

To capture that condition, it is sufficient to take a VLAN-unaware
bridge and change the [VLAN-aware] bridge pvid on a single port, to a
VID that isn't present on any other port. This shouldn't have absolutely
any effect on packet classification or forwarding. However, broken
drivers will take the bait, and change their PVID to 3, causing packet
loss.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
---
This has been previously submitted as 1/3 in 2022:
https://patchwork.kernel.org/project/netdevbpf/cover/20220705173114.2004386-1-vladimir.oltean@nxp.com/
but it died a sad death due to the ultimate lack of testing and arrival
at a solution in patch 3/3 for other DSA drivers.

We shouldn't delay the introduction of a selftest which captures a
common corner case / gotcha.

 .../net/forwarding/bridge_vlan_unaware.sh     | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
index 1c8a26046589..2b5700b61ffa 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
 NUM_NETIFS=4
 source lib.sh
 
@@ -77,12 +77,16 @@ cleanup()
 
 ping_ipv4()
 {
-	ping_test $h1 192.0.2.2
+	local msg=$1
+
+	ping_test $h1 192.0.2.2 "$msg"
 }
 
 ping_ipv6()
 {
-	ping6_test $h1 2001:db8:1::2
+	local msg=$1
+
+	ping6_test $h1 2001:db8:1::2 "$msg"
 }
 
 learning()
@@ -95,6 +99,21 @@ flooding()
 	flood_test $swp2 $h1 $h2
 }
 
+pvid_change()
+{
+	# Test that the changing of the VLAN-aware PVID does not affect
+	# VLAN-unaware forwarding
+	bridge vlan add vid 3 dev $swp1 pvid untagged
+
+	ping_ipv4 " with bridge port $swp1 PVID changed"
+	ping_ipv6 " with bridge port $swp1 PVID changed"
+
+	bridge vlan del vid 3 dev $swp1
+
+	ping_ipv4 " with bridge port $swp1 PVID deleted"
+	ping_ipv6 " with bridge port $swp1 PVID deleted"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.43.0


