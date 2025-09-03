Return-Path: <netdev+bounces-219583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB7B4209A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C11560281
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E930BBA4;
	Wed,  3 Sep 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S7l7Pc4C"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4522303C9E;
	Wed,  3 Sep 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904891; cv=fail; b=rgTs44jStFbi0lmeVV/zr3N3HzT0HxRN4apzWjyzQHE3CK3KJ0T61DgyhS+AU4ZjpzByk6kgaaii+KA6dxWkBe+mlYmFgBAK5Q/MIrbY2MHfgoTSk8yuQim/NGxuMlslJIzzh3uYkdAmDGfyQP611++W06V/K3vr0dVGxX102wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904891; c=relaxed/simple;
	bh=VhUcTaK46blh7CGsuvIqYVS7RSgJfAGwtDinUS26YeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4OYcGmjPn8TCeVP9OYIrPkCPSsXz1q0eP6HurNNFpNw/pb82xvuNfFfMgxxS9vinbsoMLIWUjkwx9rpZz6fDcqJHvNWu+kTjFMW1PMExF1Hj5Njg7jlI3/0szeyogXU7mKHJkxir5vLkh333v9UmfGy9tmuMMuivuQGbd68gps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S7l7Pc4C; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBWp+f5ugHa8Tt7fkX9XzPxMcEQoSOroNIrIXFZMs4HSYgYob/x5hDqhfknTpizY7kdj+i6s52nIwcdc+Ze0PcuIttbnMkbEguUyGII9mfw9E5tAZcJfzFzav9Q6iv2ONG3ZSoubRe1nphc6wol8deCQeJ9AvkFP0LKD2sZiCIT+MYNrM48WifLbQ+oFPWZG7aQpDRrwjftCM7dQJcPyBpAU2WY4MYuxIxcLmGZGTbjXHYFzfY4j8/fQnIsOk4Jtk8EEHpMITHMTBJRaen271QS9LIqCAqioYco7F/g/JKhPFacSdZSvMqTqPXG9F8I4jjXkBvxlngZZzS9Rn8vs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LFyGAXqpoNzEJiGhsaErrvmGFgCzhmDA1NeyoR7X8o=;
 b=vcFaixaZTyWzZuJ42A2U866Q4jmIgcnzGKyORThWUvvMb8Et+Ee5TX7W5ZxJy0HVvTr3/NLiLbrneYmSV3CqEzZSpLrvVCGv9YF+TYczKuUzg4z4GEcndPvwvR7mrEvCWjoqMAgVOxYuI9f1nF86qxJ4O4WJtLXmpWbJZXUvUnlrE1OvfiO1vtl+1rIYHFJDmvtku15ii/UQ9vL6Vsyt0CoIuwXes2iNF7VpGj7O4VHqIYjOgV74QE6ENszZ73tybXmWnBEVoLdY22vQeOdlD8Ki5duXe0Y9r3JkLtIka4Als5OqFlGFipAis4rUz+Vn22IMMMaHqHDLgQxsohANdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LFyGAXqpoNzEJiGhsaErrvmGFgCzhmDA1NeyoR7X8o=;
 b=S7l7Pc4C7PUjZvAxok8wBPF+EORcwMjDEVRbpgSGS2Y7ZHqp2tzGZkzbFd7xzcbPbD2wVkX12CbTiWDfE41N4CerOITDrtTDhdjUvQxu63UQGxdG2o804v4MRcidU8aoM7+SllyuUGrj77YEA9frX9/MrBjGT9JV2VmDy8Tao63zQ8cuT2CIiDe8GmBfAlECjS9d5iSmPx1/mwgt3QutepSTJzfwKppI8419dRm4Pl8WxxbOHtGOijgPp6eiwPiGUcp/KjqKUEoOWrNdAmcOVcrUIqNZJwtkboz9I7SeHBG5qDkpo3fAXHKvvpORfNkiib+38HEEFB6T1waIlrkYdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:07:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:07:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: phy: aquantia: report and configure in-band autoneg capabilities
Date: Wed,  3 Sep 2025 16:07:28 +0300
Message-Id: <20250903130730.2836022-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: c99fefe8-8c68-4391-c3df-08ddeaeae7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NT/6kKfTUW3Ad+FzBUHIsHjN5u2S2h7MGRSRNkFZ+oiGOKulWz75eyamtL0?=
 =?us-ascii?Q?S3EYWfgDUqehdS7X8siDoSnoSoW+CszZjBJGmoEk3JHOcZ999HfYpHdpsJCN?=
 =?us-ascii?Q?796gs8uYcliuM1aiasgblutxZj1E2aKe25jUPAdGQ2+YoMKMazUVxc/K8jad?=
 =?us-ascii?Q?OSf789ExuJbP8PyWQBqqkSNstx8wII9o7UPHca2tXlQ4p8lVLinBCHyuW6vB?=
 =?us-ascii?Q?5jojKzil9EePb5bVWxSOI8n5h8jALMYl3nuH4mgqHSn/BZHPBoH3zfGO3n6e?=
 =?us-ascii?Q?XDXsA/Offwc6f1SaR+7k3f7xQPIjOXLX/t2/tdsaUTwpraEgYbp3sHazzjTN?=
 =?us-ascii?Q?7rXPMSWEMwzh3qhsBLX+4aHfe6iwzXCqa5diY8nwp012EuBQv3b1VjjMA91e?=
 =?us-ascii?Q?gr7/gEptOAa8qlKg8PbqSgvaxfCIpsdvULWVFbYaahftu7v0fDPTdamKJFZN?=
 =?us-ascii?Q?ReRg6mQZFzgoXF61yHxpoESX/5rsGxooz2UWc/GqIx0ZL6bZJ4179/orHGe/?=
 =?us-ascii?Q?64i4dWlgVo8JDPzcZ76kvfwXRyypu4DlgPa8tk6uHCfATGNFOJIBXQp1oP8f?=
 =?us-ascii?Q?8JH3oTrDUYL9+/iFV6WThbwQ2c9NF8SCGVoaeuXx7mFSHosq9KEc575mdzb6?=
 =?us-ascii?Q?ITx2nK8uL9E+9pzfkFu2sNkELsW5VG+GNQ5QU3RKIkdKZcW+jOUQCk3+5LRi?=
 =?us-ascii?Q?G+vZ08lAFxh2c3bsno144090XQjyKWFzQr2BT5h9Ut7k+LRrEjt4fs9DTM1G?=
 =?us-ascii?Q?yGc4dQWpmab9K6tahqUSf+LZILrnoCayihrykee+M1Lb5kdDtYKO7e8G86IT?=
 =?us-ascii?Q?aPwYv3GGsdv2aiGWCFou7HTtq2YNqqTZnVoueUvez49ezNe5WPi2A/H++7Hv?=
 =?us-ascii?Q?qVWTEni3X1Gho8FqWPVRc1fYu0cnKlmoYMy4jm07dM40P6EK0YKUd6G47AN6?=
 =?us-ascii?Q?DcXMAFAEyMvf0j4X/bRTBOkDyC5hxS2iP5UxmsiaXuyc/wz2tNWcEfDtfvlx?=
 =?us-ascii?Q?PHX/iqETr+ok8MU7yeHQFjd6zUB+6uq8JBVpstnYfZhGkh/+1A67SVZMldw4?=
 =?us-ascii?Q?kHTNdaZ5UCGC3Ze1DzUr8f/kZlqJHj5sG1WA121kTBmeX2ci+2lx7ZVpTCyP?=
 =?us-ascii?Q?7dCbrEwxofCoCONe1TmdzUoV8HFfhQhIFO1IE/p65vb6VKeLFfQMlW6BpP7Z?=
 =?us-ascii?Q?rpvu2qiRqz0b4BZMTTETw1XqFhohuCgZMWpjxwZwZn2U9/BcTnxYvHKwtZJc?=
 =?us-ascii?Q?hnrPUEavATH+XbURELA1/QMbbT/Ss8XV9BbkunEG2bRm9v5FyYrXV58EhjtS?=
 =?us-ascii?Q?ADMdgOuUxVCTZiZmVNxBsLf/MlP4/cX7FDaC3MAY7imJvAogDOEB+clWpIoX?=
 =?us-ascii?Q?tpWQs0FJOmKQtV7zkcqD6hGYNvQVp6uh3wlmdjHQYNkNcgJt7TbiMmHXePIr?=
 =?us-ascii?Q?eT3d+l3X/34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LeSyyiGp7kuwU7/ub9KafRLOvN7EMpEgriOX/GwVd5K8A2gfUffsZNODEyd?=
 =?us-ascii?Q?A2pEeVlvl6XAklV1WuaHNoYLyJbOErpE9qvw0bh3RPvg+/d6EIx2+GxLC8xX?=
 =?us-ascii?Q?0Hr4pDbr7svjlLXf9s1+xNgxP5G/raUwRT+hlHasGUgHQYH5D9/XaTkvgQyG?=
 =?us-ascii?Q?jmr+JFDJ2yVnmoXa7MrT3nqa7I47Vdx3pGdB7ZTZ436xUpBEcmyajRrOaRoY?=
 =?us-ascii?Q?gKBL9jkUs+rNknT3Q5Aiu/Pk0GrSEGlGx/Dl3KMiGq0aPxhaEzZj64q1zpwj?=
 =?us-ascii?Q?mzGEByNuGhFXA9blWd2FRX8xe5fml/Lj9l166rDDuLZmkzWhIisu7MvVQQjZ?=
 =?us-ascii?Q?CHEjcXt/MpiBpqjTEpmwmKPdX2Tj40vTe8jcBnaZmzI9VPOT0vK6xdrsyRwD?=
 =?us-ascii?Q?100BrgG0wjtl97fblE4Sx3N5EkjzHcz9XvrK5VUMPzlwoWGWJV9dtGqdyVX5?=
 =?us-ascii?Q?ysUwfET3TTQzkp5d2FyYA6bT3KpjROL8U5sy9fIySNvXeF732vdPr/xlA3xi?=
 =?us-ascii?Q?Q6J5HaJAGKlRF5SVALQdv/xGPYBLyX/AZUBlB+BBhTbJrUvxMZ+G8PJBA9aq?=
 =?us-ascii?Q?6epKGMP/k6GeICHKSWS6UZwbYYWo2mKTs73XPosuLgI7GHARvp0c/jzVhN4I?=
 =?us-ascii?Q?pYr1SZxeiHksqAkUbXNGpcm5CUeNHePE/AISSTidqtlJbe3IfJBqvcXIvbJ7?=
 =?us-ascii?Q?BtkHUpCgi3FjB7nM4kvyu+bhHbAgg6y4w70tLiqs+dCQyhhXu/IyDAHRrht4?=
 =?us-ascii?Q?lufLtVCh6ugfCLD0F6I1/sIybGXqEnIIh5gwuynBVUw2JD2LqBh16jvkELLF?=
 =?us-ascii?Q?T1LJraywB6xyV6fmskfczwNt/hvFVmf90ZDHmrXIVxKg59sxSAn99Pds7N5Q?=
 =?us-ascii?Q?g+i8nKU2nkW9ecBuRUMLRejU6kNgAHNgzQeXAS3oYjFWKynfMnGwLqSQNQm4?=
 =?us-ascii?Q?6p9DBSP6Yv7rS8p1Lkon86YpyyNSb2n3PMNMfegY5uaGdOG4//FlrHxbKgTd?=
 =?us-ascii?Q?vZP8DD7f66d9BZxGfUQ4FJ3DS7M+usOBzGTkKONH9oCTUI8f+5FCEwInU6a5?=
 =?us-ascii?Q?jafueZvK9OWpOoZhJr/1K0yTZ7lhKL71rk6/AAvRBNapISUMPI1dMOmcsl7B?=
 =?us-ascii?Q?IGdCTnk3jvQ5gM6hnz583I3EkQiT5dJsf6RZvaLe7A6JquZO9cDLKyoa7vAX?=
 =?us-ascii?Q?DTNncwUaWRUrFBV3s7uwk4MUOmAjUZwx4667eA9Hc1gptokcKCtUC/1/bPcc?=
 =?us-ascii?Q?uBoJL5G83xrQ5IFtFYvdnSMikRZ62OTwA60SXtKM45mETUoACi7DRsKueYtb?=
 =?us-ascii?Q?dOIy4ZgJvDYEy1cuzjfMelP7rWPHcGsprhx7Pbbcc+dP7pDUQTgeT8pcs5bP?=
 =?us-ascii?Q?SvQ5R7UQy8LSIjTDx94BOtyohMKQAK0ADQZFR1HPty8CSx2AuXOdIUZ4OrJa?=
 =?us-ascii?Q?aLUvYc5BHYSAYb9MRYOd28Ga+8tpCXZAO0TXKq8zhfSb61dEK7DU45UX4YRV?=
 =?us-ascii?Q?2OOQK6kL+0iQ53FSzScviQD2EL5ARTF03b2xtYC693b0y+qVBXJGazCkjzAt?=
 =?us-ascii?Q?Ct1a1Q65ocnXR90p1kTEuATqhyW628PyPBht4n/q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99fefe8-8c68-4391-c3df-08ddeaeae7c5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:07:59.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjypcJFTCPeTo50+2iCPRxNDMjjieFBV+kHgkNth54cSM564OOJzxWA7m4vgvLZ92SnM8FGrOyCx9wJlCE9QxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

The Global System Configuration registers for each media side link speed
have bit 3 which controls auto-negotiation for the system interface.
Since bits 2:0 of the same register indicate the SerDes protocol for the
same system interface, it makes sense to filter these registers for the
SerDes protocol matching phydev->interface, and to read/write the
auto-negotiation bit.

However, experimentally, USXGMII in-band auto-negotiation is unaffected
by this bit, and instead reacts to bit 3 of register 4.C441 (PHY XS
Transmit Reserved Vendor Provisioning 2).

Both the Global System Configuration as well as the aforementioned
register 4.C441 are documented as PD (Provisioning Defaults), i.e. each
PHY firmware may provision its own values.

I was initially planning to only read these values and not support
changing them (instead just the MAC PCS reconfigures itself, if it can).
But there is one problem: Linux expects that the in-band capability is
configured the same for all speeds where a given SerDes protocol is used.
I was going to add logic that detects mismatched vendor provisioning
(in-band autoneg enabled for speed X, disabled for speed Y) and warn
about it and return 0 (unknown capabilities).

Funnily enough, there is already a known instance where speed 2500 has
"autoneg 1" and the lower speeds have "autoneg 0":
https://lore.kernel.org/netdev/aJH8n0zheqB8tWzb@FUE-ALEWI-WINX/

I don't think it's worth fighting the battle with inconsistent firmware
images built by Aquantia/Marvell, and reporting that to the user, when
we have the ability to modify these fields to values that make sense to
us. We see the same situation with all the aqr*_get_features() functions
which fix up nonsensical supported link modes.

Furthermore, altering the in-band auto-negotiation setting can be
considered a minor change, compared to changing the SerDes protocol in
its entirety, for which we are still not prepared.

Testing was done on:
- AQR107 (Gen2) in USXGMII mode, as found on the NXP LX2160A-RDB.
- AQR112 (Gen3) in USXGMII mode, as found on the NXP SCH-30842 riser
  card, plugged into LS1028A-QDS.
- AQR412C (Gen3) in 10G-QXGMII mode, as found on the NXP SCH-30841 riser
  card, plugged into the LS1028A-QDS.
- AQR115 (Gen4) in SGMII mode, as found on the NXP LS1046A-RDB rev E.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      |  1 +
 drivers/net/phy/aquantia/aquantia_main.c | 77 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 492052cf1e6e..3fc7044bcdc7 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -55,6 +55,7 @@
 #define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII	3
 #define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII	4
 #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G	6
+#define VEND1_GLOBAL_CFG_AUTONEG_ENA		BIT(3)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 309eecbf71f1..a9bd35b3be4b 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -35,6 +35,9 @@
 #define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
+#define MDIO_PHYXS_VEND_PROV2			0xc441
+#define MDIO_PHYXS_VEND_PROV2_USX_AN		BIT(3)
+
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
@@ -1056,6 +1059,52 @@ static int aqr_gen4_config_init(struct phy_device *phydev)
 	return aqr_gen1_wait_processor_intensive_op(phydev);
 }
 
+static unsigned int aqr_gen2_inband_caps(struct phy_device *phydev,
+					 phy_interface_t interface)
+{
+	if (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_USXGMII)
+		return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
+
+	return 0;
+}
+
+static int aqr_gen2_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	struct aqr107_priv *priv = phydev->priv;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII) {
+		u16 set = 0;
+
+		if (modes == LINK_INBAND_ENABLE)
+			set = MDIO_PHYXS_VEND_PROV2_USX_AN;
+
+		return phy_modify_mmd(phydev, MDIO_MMD_PHYXS,
+				      MDIO_PHYXS_VEND_PROV2,
+				      MDIO_PHYXS_VEND_PROV2_USX_AN, set);
+	}
+
+	for (int i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
+		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
+		u16 set = 0;
+		int err;
+
+		if (syscfg->interface != phydev->interface)
+			continue;
+
+		if (modes == LINK_INBAND_ENABLE)
+			set = VEND1_GLOBAL_CFG_AUTONEG_ENA;
+
+		err = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+				     aqr_global_cfg_regs[i].reg,
+				     VEND1_GLOBAL_CFG_AUTONEG_ENA, set);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1134,6 +1183,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
@@ -1159,6 +1210,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
@@ -1184,6 +1237,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
@@ -1209,6 +1264,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
@@ -1217,6 +1274,8 @@ static struct phy_driver aqr_driver[] = {
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
@@ -1241,6 +1300,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
@@ -1260,6 +1321,8 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412C),
@@ -1279,6 +1342,8 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
@@ -1303,6 +1368,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
@@ -1327,6 +1394,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps    = aqr_gen2_inband_caps,
+	.config_inband  = aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR114C),
@@ -1352,6 +1421,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps    = aqr_gen2_inband_caps,
+	.config_inband  = aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR115),
@@ -1377,6 +1448,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
@@ -1402,6 +1475,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
@@ -1426,6 +1501,8 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_set = aqr_phy_led_hw_control_set,
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
+	.inband_caps	= aqr_gen2_inband_caps,
+	.config_inband	= aqr_gen2_config_inband,
 },
 };
 
-- 
2.34.1


