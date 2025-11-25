Return-Path: <netdev+bounces-241495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CBFC84813
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60BA3A2802
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CF82EB845;
	Tue, 25 Nov 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Anv+QVvg"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C58266B6C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066926; cv=fail; b=VVq7lLUXOGP72CehK90Nt7/MdsEHR08Z0X40q+SS8ggkeau3/2PqfJLzvNpCbEbS19LdJWc+GbI5WWZfhMIBUxvY4kppOEMStVj4MgGXnTydilJRxwsNKdr5bbgSK2AnEEdJAtyk1VQgVUv+KogWft58Cv1MSSHEOZnksl7NdcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066926; c=relaxed/simple;
	bh=gwqHqx/hN732Ui825xkL7x0C3faWhtUSQ0DFFnP4nLg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eDpk2l47O+STEY/KaHbDoZqXDcGhEnAgRvGbNtOiycMGrckdRTzO/xGHEJ9mMse6RP9sqQlDeA8VrU6pIef85onQ1jvIjLv2YQQ0HkPsj8nWp8oK9nkYFxXeU7yWCm1/jf2yBN7SmV08sXRITqGvnb9R20karfJ34bnkKrza6KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Anv+QVvg; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O60x9uzXPZ9eo/FLwwAhdLszglQuzgaX49wlyQWpKkj5yY391dMjscL14vI/2LqFItHPqVo0aHaMWhMePzWbSvaDSO4sbYgz1g+3f75WH7xLAI1eEPCw+RGYDqn2ARVAemPOO4DkfLlmKS36343A5RetE0FzBWCDUeaZXOo0yCHJU+SCNDgRCyEA1zF+1JgOG/6IMvDVTGuJeIutsGnKsUdD3n3eZvD8cxCUsACoupaMvkZznVFwnmtpzcB2RMAhSwu58UkLUyZCrogp4ZZv3hOQmZx344cl0Xsb/ybueYGDl6w77WybUlO64GR/JECE2D9OQh062IOG1xHf4hkYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PmuP+LDqLFgH8XMPcrlP0CQGxAQGiYJm8O99eAh61U=;
 b=EszJK1CK9cNyZdNn6Ik5TPOjkZI3iBLmKUIBrLdrPdklQCC2xuJH0SiLGGBz5tk6HzOX7wdjPSm+6M+dQd6nseIoAAD+c0lPmBBwoN1LnbjxmU+mHFXm81dgE2NCEpfdIvhO60ZfrZdas2MiC/JNWmJuf3XFiKzvbygWE/YcJ8YEsd+aMfZMLh1Q6kj5l+m1rntaF9rjwNHNEUbpwyjL5LcDhtMRoPybAYIVpcS3jFJ7HJvROg4kH60P2WOq0enQR7Q90l6BscUkxylVjYZRTnjxmq4+tcMOoy24ZCe5xqXyLnuzE3/L8q1IJ0+/REkwrqHq21w3yZHMjHn2ilPT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PmuP+LDqLFgH8XMPcrlP0CQGxAQGiYJm8O99eAh61U=;
 b=Anv+QVvgXUBYKDNwHcOqAqwsn9XMBJhsanaXXb32Rvuj2hPF+inSJ+v4VkSYAMQyQMFnozgKg+V66V/VtNRPG170aZMQs38n47vZDPaSBOitFsu9FpDPsAAuvK6w7sH0ZMui5r8tjNQjmdcUbj6/rLIkjML6E3BSmSh9+NSE32XuPQivmj18Bf72gsy+YO67Ge+qXntfiL3EY5jAb/rNPRKXWEoQPJ9pwEsfds6NU3m/Bk7Kni5JSQJTt8RRKLlEkl03L0sJ0uOT7fZKt1yKtbhcYYYmUCssz/MndFObeDku7vOqwAW2rrK2QZYV28XvbOoHBF2maGyqmPQpFqSApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:35:20 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:35:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: [PATCH v2 net-next] net: pcs: lynx: accept in-band autoneg for 2500base-x
Date: Tue, 25 Nov 2025 12:35:07 +0200
Message-Id: <20251125103507.749654-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1272d5c1-a578-4c10-226b-08de2c0e540b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1H6iSDjFaJWH8kpiuZSfmSCypeI7BAWMyavw3dTrGvsaAnsStUCA1uMGCKZW?=
 =?us-ascii?Q?iDDqqZI5HD4DamPsYzJF2i/bPnNGC+bxswBVBQ45k6hgYK5lisA6N5B7HZ8h?=
 =?us-ascii?Q?O9pf7qf24luOSmGJi8TnPj/PO3B/ppyShV/Tpz3XOQKONo+AqO8zBCzqZcDN?=
 =?us-ascii?Q?SnmJJKW9uZPvyEK7h8GgZO9UrJz3472CVeWHf546/gH7dMiCqYUnYfdQkNtS?=
 =?us-ascii?Q?fwgdsEs6M4QFoVOFYpzJw5LjhMff/xNL6ZdlhRkcewCECi8IVhNujAwGl0WI?=
 =?us-ascii?Q?S6ZfAJVZecuDN8wCOMVxtPbsPyXQRX25itdzzRKnBuYPZ+ANGyouKRPv+UTF?=
 =?us-ascii?Q?laNEGytTJzSA0+2srDhD/w8t1iDtz9H2gZDB1nEka2IcWDnlaOYawpWMda1g?=
 =?us-ascii?Q?ZsoABN+t052BMuwl9pYk7yI9VlHUIcBbU5tF/4SljnstY2oyyVEWnakdmmy9?=
 =?us-ascii?Q?wOFOo146Xw5fk+ivuTF++UhTr1zbFhynNlQboCJnMcz/i+NeaI+N9G2x2Ai/?=
 =?us-ascii?Q?/nzoaLk5AT8bR+/FY6LzLRwK8ZDkPEV9DkwHTF3CNDjJbhdrf/tqyLHMpCZ1?=
 =?us-ascii?Q?mZ0n2SyYao8JhJ3ksWmSXs5EWgl0OrBwHhT4CyHUkxOMPG6CJTI6C6DFgSuE?=
 =?us-ascii?Q?6fF4T+ksCfyO6xYl6E3ZiuEmalS01ds0ysikSiycdjiHkQ8/4VmijFZcGe+c?=
 =?us-ascii?Q?uJibHZe1ZRIDqPqiJGFSjiUr/zYtsSBI9/Qm+5OHuRCva3FNvtxFg3La2V/m?=
 =?us-ascii?Q?bKMs+KO628OJ36c4PtMly0pHblvHucbs/R4cAtW1W5NsdCPNW7biRVPfwksA?=
 =?us-ascii?Q?Pk/BkqPOA4FVoKOgITxiiqtt0SkCTmo1cDM4uU0l7vWdYZjhSR28mOb65seT?=
 =?us-ascii?Q?sbtiKCcScrqdzXZles7GvXKg8rOpQRE/HJ2WrZugLo/Q5mSqqjU4Up9hvky8?=
 =?us-ascii?Q?ro7faBmDN83QAt5VwXeAmX81rlFsKqI9esGa0KDLH1c0XmbdygpyN0nkbZMv?=
 =?us-ascii?Q?Ulz1sSEXrHGN/sqqxuhdIWxfkyLYkpjwYpey1dKo2JL0HodBK+5bN+B6XEQj?=
 =?us-ascii?Q?yOwvQr2nhdlXuM8bVdVqkiZwyHrVkE4fj2YGMNKzbcKu08HP78wkxeUPbL8I?=
 =?us-ascii?Q?/Jq5aEBHn/uhHEdlQg+DOH9wBI4WgcMOBYRuKlT6tcgFduhUhifjbCwjoCt6?=
 =?us-ascii?Q?WdzQSjGiO4L/QpC8ImB8ernEps0KIoKdMD/Zv9O89tVDMl39cis489iFe3s/?=
 =?us-ascii?Q?SH1FBpcsntGOLJy2pY7KR/DVXa4j/0D4D7lgyD3ir43LHZDeW99l+rU6rqUu?=
 =?us-ascii?Q?L6kLmuiSeYDglT4j1yB0/RBVc+2ariYsyBUY0ZOjOPteEC1OTyNjxVZwcT2l?=
 =?us-ascii?Q?d0Q0WWslS/H51ajXpuGgcspDQukOLNWBsp2opWBqPZs1KxqGSKzglUbV0qkO?=
 =?us-ascii?Q?XvFFrHPVJ0XEMABoRxks/n1QJu4gqIKt+OllK8p9gKvfhheZt5iplQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWnkOR42Pu0gdm2pVsJAdeMXrUpoDJT9FDMJQbWaxtcyA7oUP606Y2w4wqUE?=
 =?us-ascii?Q?7KTJiqkbxnG5yUz/AqoK8rcnwbFIk7L5415BlpyjCH3cCbTEx028lZxeaXw/?=
 =?us-ascii?Q?CPDxF3o88d0V3iKRBBxMLLn7d4NVcXB/Vc4Nv1yfoo02UYV/8CyVjoBMIKHP?=
 =?us-ascii?Q?ZWgrdaNeyNaSb2ckrirD0wfZjVblDc6bgdkbUBsJY0rbRPYKa3+n5WdUHOX3?=
 =?us-ascii?Q?5ZCtafaUa5JtFpcArNyNEFVpEtFaZevuDZXFhwSiqCgUGF88hLR9z3EYB/Jk?=
 =?us-ascii?Q?/DfR3s2gGlFFPRIj+lfTnfXJkD3cl7r9JBzupkd0Osp33oz0ojksV21Dds2y?=
 =?us-ascii?Q?VjaJmhwGTOJkxXLio6WI4w1Aj4SyrOdbLOmEI1l4ooIj9/0X1qaut+NPYnVq?=
 =?us-ascii?Q?DIKIBjudSlX6DI5hwVdl+MN90lt4xaapnFfUlV56sSR0haZbP9YbQ1hvcR5J?=
 =?us-ascii?Q?eD2odNMEuBvM7CvFYQtFKp2hqK9ruNyskep0elikj1E4Ns5PPQ3mxF/2+BGf?=
 =?us-ascii?Q?YMD/6hT7R9+T0OMrv6Bo0MPvaZSNuyf4uTE965/OFWzSjcjINqfTeswgRhh5?=
 =?us-ascii?Q?Bvoa1rhEgnXy470WfO3hiV5DWZoS42fjsOcgbkjHetKC0oF8YnyaZ5ROvHj3?=
 =?us-ascii?Q?g4DFj8xpcdrlYGr7O3KxDLE2gz3NZDM/B7o/dX06C+hGAjmahy1m21TslILN?=
 =?us-ascii?Q?fTLyJMs9HOOAQOPE2ZLEiO2O8Oj8gf1xebYbHJlU6QXKhofOGSq+3+Q5Je6c?=
 =?us-ascii?Q?Cghr/L0DUQCqieQsFzzhzfLf0VpkWc9Lc1CYU0m1artx7pglFFdq4n18lhi2?=
 =?us-ascii?Q?45UZ6UUkcrCYIVMssUz6NIRDvEV0Tnao/QNXrRau/pVDecDw1TKVu9RlPStY?=
 =?us-ascii?Q?U+zENPKivGdpfP7n9lBpMoEXUs8wRo9UlIG/jPvqmMUoLRwOv0nVv6ZU2d+f?=
 =?us-ascii?Q?iXxIhrs1s7ImWbCXukud8LgNDU/5YJhRH115IyNrCymnG5vufILTKkDve2Bw?=
 =?us-ascii?Q?HNqYoZLna6igIPgkn8UGDeZI7SQgpRMIbh+NWyoF9/XlPrE7Lr0rMhhVWhqk?=
 =?us-ascii?Q?dFDRT4qHtwFesIGE0fP10X7f2yWK0Ue0rBAvoWZOpBF7T+YaME8KniMRwD5L?=
 =?us-ascii?Q?F9HXd+Ekhe37kgZeQZnFLfNi1NAfk72ieQmyg02B/+7V+gRFoAea3ZfC3Ah8?=
 =?us-ascii?Q?puEk5zdCrCIGc2mBXYBsnBCFLh7glpEYDIUAFsNPHM2GCYkmpAf8y0Hd4bGe?=
 =?us-ascii?Q?l93ULfAMXG0TM6akL6Wfl68588qqhji72EgW3FXu9maG3ZlLiGWGyEyVNnDK?=
 =?us-ascii?Q?zLS6y9aLzGsrGSiwxlFLuCQKVx+zmUu/kxvp4f/JrceIgGuje1EY6zB+fGW0?=
 =?us-ascii?Q?DlpO9XwuTUHPE3z9L7TZHc5ha3qBmwzPJH2b5svi/iAdPOBhMMECbx0o+x/l?=
 =?us-ascii?Q?UPWZf6l48/dP6Pkyxs2XtxS/dqJtXJ4i2eM2eS5815PMeePB8z27DZHV12cQ?=
 =?us-ascii?Q?fn8RwOgb+ar6jyT5JNz/PF/8xyY3wwPA5tksV6ILs8XHETXZBBo0ZFyrGBn1?=
 =?us-ascii?Q?rwHzJ90GReuzyVxmvsdBjZCfjDg3rYqupNhuqAICtJDJbg4kLOnemrlkhTE6?=
 =?us-ascii?Q?7rqWsPgsyd0PY9EfMOlIgEg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1272d5c1-a578-4c10-226b-08de2c0e540b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:35:19.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fOsYmoqOWijG5umAa54x2V1sX4h7btkf59fwbCKFD9B0X+WjcV2mLFneQGmgxt3O2AgQtLxhw17elnf+kgZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811

Testing in two circumstances:

1. back to back optical SFP+ connection between two LS1028A-QDS ports
   with the SCH-26908 riser card
2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
   https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/

strongly suggests that enabling in-band auto-negotiation is actually
possible when the lane baud rate is 3.125 Gbps.

It was previously thought that this would not be the case, because it
was only tested on 2500base-x links with on-board Aquantia PHYs, where
it was noticed that MII_LPA is always reported as zero, and it was
thought that this is because of the PCS.

Test case #1 above shows it is not, and the configured MII_ADVERTISE on
system A ends up in the MII_LPA on system B, when in 2500base-x mode
(IF_MODE=0).

Test case #2, which uses "SGMII" auto-negotiation (IF_MODE=3) for the
3.125 Gbps lane, is actually a misconfiguration, but it is what led to
the discovery.

There is actually an old bug in the Lynx PCS driver - it expects all
register values to contain their default out-of-reset values, as if the
PCS were initialized by the Reset Configuration Word (RCW) settings.
There are 2 cases in which this is problematic:
- if the bootloader (or previous kexec-enabled Linux) wrote a different
  IF_MODE value
- if dynamically changing the SerDes protocol from 1000base-x to
  2500base-x, e.g. by replacing the optical SFP module.

Specifically in test case #2, an accidental alignment between the
bootloader configuring the PCS to expect SGMII in-band code words, and
the AQR115 PHY actually transmitting SGMII in-band code words when
operating in the "OCSGMII" system interface protocol, led to the PCS
transmitting replicated symbols at 3.125 Gbps baud rate. This could only
have happened if the PCS saw and reacted to the SGMII code words in the
first place.

Since test #2 is invalid from a protocol perspective (there seems to be
no standard way of negotiating the data rate of 2500 Mbps with SGMII,
and the lower data rates should remain 10/100/1000), in-band auto-negotiation
for 2500base-x effectively means Clause 37 (i.e. IF_MODE=0).

Make 2500base-x be treated like 1000base-x in this regard, by removing
all prior limitations and calling lynx_pcs_config_giga().

This adds a new feature: LINK_INBAND_ENABLE and at the same time fixes
the Lynx PCS's long standing problem that the registers (specifically
IF_MODE, but others could be misconfigured as well) are not written by
the driver to the known valid values for 2500base-x.

Co-developed-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- use phylink_mii_c22_pcs_get_state() instead of
  lynx_pcs_get_state_2500basex()
- remove the lynx_pcs_link_up_2500basex() handling, just like 100base-x
  does nothing in pcs_link_up()

 drivers/net/pcs/pcs-lynx.c | 77 +++-----------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 677f92883976..73e1364ad1ed 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -40,12 +40,12 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_2500BASEX:
 		return LINK_INBAND_DISABLE;
 
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -80,27 +80,6 @@ static void lynx_pcs_get_state_usxgmii(struct mdio_device *pcs,
 	phylink_decode_usxgmii_word(state, lpa);
 }
 
-static void lynx_pcs_get_state_2500basex(struct mdio_device *pcs,
-					 struct phylink_link_state *state)
-{
-	int bmsr;
-
-	bmsr = mdiodev_read(pcs, MII_BMSR);
-	if (bmsr < 0) {
-		state->link = false;
-		return;
-	}
-
-	state->link = !!(bmsr & BMSR_LSTATUS);
-	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
-	if (!state->link)
-		return;
-
-	state->speed = SPEED_2500;
-	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
-	state->duplex = DUPLEX_FULL;
-}
-
 static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
@@ -108,13 +87,11 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		phylink_mii_c22_pcs_get_state(lynx->mdio, neg_mode, state);
 		break;
-	case PHY_INTERFACE_MODE_2500BASEX:
-		lynx_pcs_get_state_2500basex(lynx->mdio, state);
-		break;
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
@@ -152,7 +129,8 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 		mdiodev_write(pcs, LINK_TIMER_HI, link_timer >> 16);
 	}
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if_mode = 0;
 	} else {
 		/* SGMII and QSGMII */
@@ -202,15 +180,9 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		return lynx_pcs_config_giga(lynx->mdio, ifmode, advertising,
 					    neg_mode);
-	case PHY_INTERFACE_MODE_2500BASEX:
-		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-			dev_err(&lynx->mdio->dev,
-				"AN not supported on 3.125GHz SerDes lane\n");
-			return -EOPNOTSUPP;
-		}
-		break;
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
@@ -271,42 +243,6 @@ static void lynx_pcs_link_up_sgmii(struct mdio_device *pcs,
 		       if_mode);
 }
 
-/* 2500Base-X is SerDes protocol 7 on Felix and 6 on ENETC. It is a SerDes lane
- * clocked at 3.125 GHz which encodes symbols with 8b/10b and does not have
- * auto-negotiation of any link parameters. Electrically it is compatible with
- * a single lane of XAUI.
- * The hardware reference manual wants to call this mode SGMII, but it isn't
- * really, since the fundamental features of SGMII:
- * - Downgrading the link speed by duplicating symbols
- * - Auto-negotiation
- * are not there.
- * The speed is configured at 1000 in the IF_MODE because the clock frequency
- * is actually given by a PLL configured in the Reset Configuration Word (RCW).
- * Since there is no difference between fixed speed SGMII w/o AN and 802.3z w/o
- * AN, we call this PHY interface type 2500Base-X. In case a PHY negotiates a
- * lower link speed on line side, the system-side interface remains fixed at
- * 2500 Mbps and we do rate adaptation through pause frames.
- */
-static void lynx_pcs_link_up_2500basex(struct mdio_device *pcs,
-				       unsigned int neg_mode,
-				       int speed, int duplex)
-{
-	u16 if_mode = 0;
-
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-		dev_err(&pcs->dev, "AN not supported for 2500BaseX\n");
-		return;
-	}
-
-	if (duplex == DUPLEX_HALF)
-		if_mode |= IF_MODE_HALF_DUPLEX;
-	if_mode |= IF_MODE_SPEED(SGMII_SPEED_2500);
-
-	mdiodev_modify(pcs, IF_MODE,
-		       IF_MODE_HALF_DUPLEX | IF_MODE_SPEED_MSK,
-		       if_mode);
-}
-
 static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 			     phy_interface_t interface,
 			     int speed, int duplex)
@@ -318,9 +254,6 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_QSGMII:
 		lynx_pcs_link_up_sgmii(lynx->mdio, neg_mode, speed, duplex);
 		break;
-	case PHY_INTERFACE_MODE_2500BASEX:
-		lynx_pcs_link_up_2500basex(lynx->mdio, neg_mode, speed, duplex);
-		break;
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		/* At the moment, only in-band AN is supported for USXGMII
-- 
2.34.1


