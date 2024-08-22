Return-Path: <netdev+bounces-120781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512A95AAB0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFBB207B5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B018EAB;
	Thu, 22 Aug 2024 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="foYzCD76"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805FD299;
	Thu, 22 Aug 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291501; cv=fail; b=UhmLBi/F3+1vm8e2pVQ/DHbu6oRD+VU7N9iejYz1KibN/enx+UusVTAA1bCLSy4CRf5Sbdz5MwDG3COEQWaMGKMTYFjjJlItrvGDpKmitqHtznU9Z+QYlWug8/y6UMl4aE0HRJ7ci/93ah297mxB0a6wq0nh79IBPEWJeYOXc40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291501; c=relaxed/simple;
	bh=otf0TWa3NZwI4KhBw6pyDxOK6Ubi4Zw4Gs3KGgSDiTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRvJBUFNsoE9evUgqUevVGubGY1NuFsR0QKwMOnoXLEqJvGHyNkyet3uLqcOJDRSaGOlbtjLwjMA45OA6fYgq0xKOXUvhtaViti1LVdmYLErqKbSFttASskgVxofe57BBp7Xk6Lq7VQ2RiWvHUp93gNxqset4qoIQ3MUtwF0q8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=foYzCD76; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY5a7FgZTZDhvylWTDdesLRxJBHqKM88552RGUGLBk4AcvX0oKUzRW5hrwk8IXs/RH1kTXFOEKRIwOFMI7y7dOIgY81Df+331BFn0R2M7yU1mmnk0IhRUiYA9B2/o6TtFgnBY0AH10p4JaA/gWk3/o3heTjgdOs6iSZY5hxbgIrLxIY/SHmGeHwQFMiqcBjN6tdUkoyaK/zMeZeChXoOjN3oRwhgr5Bjd4YXOTLvv/GP18aksi8u1f3ox7juW+RJQGWq4fGfaYtVsZF6KZdL8KIzfnvKrD2LpPTmzBgjvZsCOkj5aqwyx/54DM8a0hG6tTFYktZ04YDJopubUn8OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3vWu3MZ9mvDKYjdLwYsGRRWkBm0DjH+Mn+EQqnvKuM=;
 b=vTSGWrIMqLqMN9lKW233N+o4QvM545/nI7C9FBvVPcSFo49NKjOL/nbuLqsTesj0Sm3Ss54iBvNQ00ITOSoUcSmwYsFoo55RxJaMwaiyIexHdQ918aU6/jfuac1dsB13n2aRJsYMdwZE/CgO92rmHcZ/v+edl6s6BaBcXS6eeoIytZ0Po5yu2SztcVknaqbCK0hUp7qBko2cqvjBvoa67gMmcoFJJD8jPmZw1/03ljJMXC1joBmzG0RJahDBaPZR/+ZKEIcZ4oGQgXFGBnnZGDTDpwMnYzhfgn+Y4cinZJPlfCw8J4E2lFtnAgX8wX5hW8EGc6iJ+rQOH1UWpIyxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3vWu3MZ9mvDKYjdLwYsGRRWkBm0DjH+Mn+EQqnvKuM=;
 b=foYzCD76OS8KkaqGYiP/iUG6qQO1EOb+a/aX56UMzRnmu36sw+9tijbGjsJ3zGHJrqHF1LQMoz+Xd9fnwWW8HPaDbAicuvWqIhJ/OMHUQAPNE383JoIsFuiGG7sc5lfs1vEvNC8qfPP2S4FNMUNjphG8JyjsczU2uEbA3bHhkwq2FMuek2Se3cZuk21RurRv+mfop5DJi/pZgKdTPRZTmlpjYPuif7pIyBb1YGdd3cz3Pb7jxzn4BRWUqEtvpX2gRWtKVdDhnhl6lw9neBSR2qurT1s0K3ZpqMQy92ZdlTIN4Gs0bhQoEdqHo+/bOD9TBedG6y01iOimvWeRo0+BjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 01:51:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:51:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/3] dt-bindings: net: tja11xx: use phy-output-refclk to instead of rmii-refclk-in
Date: Thu, 22 Aug 2024 09:37:19 +0800
Message-Id: <20240822013721.203161-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013721.203161-1-wei.fang@nxp.com>
References: <20240822013721.203161-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d09339-418f-46d5-fc5e-08dcc24cf4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zftwlakyJ3Q0PL8G6g/EgljGmHJJDD6TRa5ObEx/9f3NZQjcW0Dt8/94a2ox?=
 =?us-ascii?Q?tlP8miUlNB1FL809ubREqa/NFWFH7DJAFDhmWms7mySqfiXw8RfLXxjsZtb+?=
 =?us-ascii?Q?d13gD3tlaXDyAo/0oQCloNlM1mZWPrssg9SKmOvfUokMPqv7mnG5txU+MfVc?=
 =?us-ascii?Q?DE6OgDqrqGU1EckJjczH9C6uSfCibutfwcqhJL8g1MztWUQ6nV/MEvI1Aw0T?=
 =?us-ascii?Q?65G9UEsK5XpYDTmwOhKFwT0XfwbmeU4PIan5EIVDa7pSxlAMNQklTMw9LmTL?=
 =?us-ascii?Q?QBu55jFHb3fzORfSzYG6P76WtUVneQsQy3ZXJtdPfUwtSHJ8YzvwAvDUXcQe?=
 =?us-ascii?Q?1MsOn6qU7MJxDdmR36k22+P0nRccIHn3Mwj+qHVlQd3los/RqEb68IqIRrQr?=
 =?us-ascii?Q?353+hEsAkew9EbpZcORoW4VHjWFu9cgLsFaH5SiPMaO1CAZiuAQG2KvUz/+E?=
 =?us-ascii?Q?en9P/tdJgdBqcZTXUksPZpkGsbm4lC23LeuydiQ7XeGQs6LEbToFq35idsKz?=
 =?us-ascii?Q?dncR+PmKXf6bzA/VBiAxxYbgfuRPbUs2U48Kwmh4Iq5R9IQaRRAumbZfIDXK?=
 =?us-ascii?Q?/2IejY16/hraCd8fCxwXR/dLDYXoVV7dlRf0qHBruH7zr6dHlkqgDi3IGxjm?=
 =?us-ascii?Q?JP83P9Bh/8dcIkOlPgoT0Z5bp1sGHfVFvlmXVlh7wRH/2mrruCGxndbeP2M3?=
 =?us-ascii?Q?ilamMCTo8yNDJajg7FAM6IWq53eyt/e/1qpSz/x3TDKKBFgbBzpD+sAlddof?=
 =?us-ascii?Q?dyVNJ272wcrzYBv0zXO6jKVkY0oKw9x1xHbulwqSe4RqnZw79bz4upL29SM/?=
 =?us-ascii?Q?xASA8shMfCUrZoQiqOdjesjeiisQXl6caXruzkAhUgodZIOgHjz+yd/Bcyb+?=
 =?us-ascii?Q?MzUvCD6lnhJYTkobFW86rd6rdpjLJ+Y+3UMZuhV1j4cf+a7k5OyoM1beo4+d?=
 =?us-ascii?Q?0f9A/XF681JG7x7+D01v8mug989uW5r7TcilTZswAGFv1Z9YNRNSoktuO8yU?=
 =?us-ascii?Q?a6epv7T9nOP7l/Rb/+LYyWfKhZuKyrSpT5QkjLsll8R6WL8cpbOyr0aSaox7?=
 =?us-ascii?Q?BYBqhR/xm9k+OpnOxg38EikiyAyFV+Vf0qSIVnhirTARk4OyPu/MYpbXJYWh?=
 =?us-ascii?Q?Cn0dDPwEFlw8kPnIpvHIwzCl/NRPaY0ZD9nVb0hsdD8ImJ1Ldb/lGNFa+WrS?=
 =?us-ascii?Q?+Ho0pBQj2xkh9eyS4y5RFsclDw0OvOI1UEYp9b9KsJGrcHDavgy2zpY6J0oS?=
 =?us-ascii?Q?LmAzguRmBHfDr8O/0PfCiviEADto2EzbHWVUSwGy/qBUIfMgSETegzkZS9jG?=
 =?us-ascii?Q?tGThhSlOKcLAXBViGk3g04EbbtuWusgW0FbF2UfmMqsiYjfxTUFdnvzOAeY3?=
 =?us-ascii?Q?4uBC9Mvydrq10pDwujuk4EIspc06Zvf/KsXWYsGKCQKpAsVCPwLDEbKjAsN1?=
 =?us-ascii?Q?mfVvCXJvxpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cDcAja8GdO1jPRR1vx8TizmalPOnxM3UzaHU85peT6Sb+SIIY55r2dNqoePN?=
 =?us-ascii?Q?n1mkWMYDxPH5tXfYgsdJMh4br29zodtAhDnrgrcX1nNU5T2bZdmiLVJ5Lg1w?=
 =?us-ascii?Q?MzSefbl1jeHvKCWsi5D9xx5fswWFxIXsiQSdLgihFGMEQoBRcm8cOPIj/41a?=
 =?us-ascii?Q?kXeqPq8SUlXdHn3j1S59ffs+RhCrCW+wGmwokWgLpe9YZ/PKTIGc0MMx0lLs?=
 =?us-ascii?Q?JvAb85ezojbE1zj8iO7AecP0LA0RgS8CwByiWjQPXlhQQalU2aZi0YjRF0Fs?=
 =?us-ascii?Q?+UtEg5YsatzhYlEQ45uKxpuNGVbjPJLxecMmj2Qd9gsLnijDAwNFrXYJ0qMz?=
 =?us-ascii?Q?StBXD/UyU7QrUC4+jtDcEvL3y8fQqXupO8shtTEuSA4MgkZfPArzn8Vfbd88?=
 =?us-ascii?Q?Ni9JTdC4FVh5Sc4l+/cAxBTIG/r1oCc+bAphUjcAtrQqB+sauPEOdKCQLS4K?=
 =?us-ascii?Q?MXLUzjgoL3U2Zfh8zGTt09ucaU12IcT9TW7TZ+ghl5KFTLjZOjS3Ajid0t2H?=
 =?us-ascii?Q?tpO+9a7G6XhA9wvGtGD2k8uFKwtIHE0BZkh42LycYNr2Qc66u6SQ1BFzPiCl?=
 =?us-ascii?Q?85bW/7BkohKYefmjvyZaNBltKkJBahqxuwlbFUlo2zxXYm7DIoxOmzsme3kk?=
 =?us-ascii?Q?qWqxgE2QPNfgYl7xvlzrxODqSREjZ9ZLop8On4TQ1aG2nlgxAegLFzU3UUwG?=
 =?us-ascii?Q?YGbLTdWI8rXb6DtJdl5KQuV0vJr4zcox4PZMsDUY38pXRc+/+5/YqKj+9ySq?=
 =?us-ascii?Q?lB01DQEz7OQvDDM9N44dbhdJz4WJUocsAaw57kYuEYa/+ffPTQvF4IOSYvzX?=
 =?us-ascii?Q?yE0wu59NpPMvqYFhkh9yJ5G4VWoP6gvYkgULvbk50GkgUfuVWOZ7invJJ+2m?=
 =?us-ascii?Q?QSsFfnQ3TnCtysr9lrIo+Ft2v44ZjTByNSGHjt/z28gcKCTVhvVtdHXD+fZ4?=
 =?us-ascii?Q?ACeGJV/vn7Vo96+6RXgjt3VA3F5IQkNgDQYKlx6+1EHS/ZSMfZ9GbgVhtxqM?=
 =?us-ascii?Q?DEFiUyeYZ4a5SZ8Py2iim+y+M4Dc/3j1vRKlPPyPX78wKlg2zqfJesJ7033v?=
 =?us-ascii?Q?k7k3ujaOugW6xs9i+eSqzMJ7LHgSuxlc/klMLh2dwPbvNiDWhwPljMgv2xAm?=
 =?us-ascii?Q?LkbRe1VByOfoWsgBaYMh2PSl+PI4eYxQlSdZLjyT3swQP5ew+rKx1wY2OmPD?=
 =?us-ascii?Q?fy4RgNc+dsqN59XOPairkQZseWk7a6D1L4TjOWZlILYK4W3+UVX/pS1jiBPr?=
 =?us-ascii?Q?Gt/9mLvbfkXEHETllm21NDHkQDpGISgYWZnRDKBy8LEwqwPgtrPo1rPJLzOU?=
 =?us-ascii?Q?e86oWQQ02wxGgpqPTrr/idVxajOdlMxcxHwBURSgJ6mUWJggxc8ijTTReTmp?=
 =?us-ascii?Q?RkCnhSQoYisFnKY/r6373kERZv6kqWpouoE58D9W0bUaqDZQys18hwKQe6Bn?=
 =?us-ascii?Q?3BN6OoBwSsJEIAEDXlrg1RRgVSDL3IIbvhHi0YGlepG7JmAXA1JUy7DusQqi?=
 =?us-ascii?Q?HRycyyUXJPkJQ2945EtYuix30zo0rILPLaHOpzcIcX5q43efwmTpbfjNm/uy?=
 =?us-ascii?Q?SqVb15yTcQS4sVOxF2Egn6T7J59oQ8VXbfF60zly?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d09339-418f-46d5-fc5e-08dcc24cf4ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:51:36.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0ggclTriahhOCXUs5WSQ9nqxvefNjM26RlVuyz18HeqWEGaRxA2CqAKx7WA/UbgUKkUkrWpuaQEN6ZgTfNezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755

Per the RMII specification, the REF_CLK is sourced from MAC to PHY
or from an external source. But for TJA11xx PHYs, they support to
output a 50MHz RMII reference clock on REF_CLK pin. Previously the
"nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
this property present, REF_CLK is input to the PHY, otherwise it
is output. This seems inappropriate now. Because according to the
RMII specification, the REF_CLK is originally input, so there is
no need to add an additional "nxp,rmii-refclk-in" property to
declare that REF_CLK is input. On the contrary, a vendor-defined
property needs to be added if we want the TJA11xx PHYs to provide
the 50MHz RMII reference clock. Therefore, it is more reasonable
to add "nxp,phy-output-refclk" instead of "nxp,rmii-refclk-in".

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Changed the property name from "nxp,reverse-mode" to
"nxp,phy-output-refclk".
2. Simplified the description of the property.
3. Modified the subject and commit message.
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml   | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index 85bfa45f5122..eb813f7bf274 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -32,21 +32,9 @@ patternProperties:
         description:
           The ID number for the child PHY. Should be +1 of parent PHY.
 
-      nxp,rmii-refclk-in:
+      nxp,phy-output-refclk:
         type: boolean
-        description: |
-          The REF_CLK is provided for both transmitted and received data
-          in RMII mode. This clock signal is provided by the PHY and is
-          typically derived from an external 25MHz crystal. Alternatively,
-          a 50MHz clock signal generated by an external oscillator can be
-          connected to pin REF_CLK. A third option is to connect a 25MHz
-          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
-          as input or output according to the actual circuit connection.
-          If present, indicates that the REF_CLK will be configured as
-          interface reference clock input when RMII mode enabled.
-          If not present, the REF_CLK will be configured as interface
-          reference clock output when RMII mode enabled.
-          Only supported on TJA1100 and TJA1101.
+        description: Enable 50MHz RMII reference clock output on REF_CLK pin.
 
     required:
       - reg
@@ -61,7 +49,7 @@ examples:
 
         tja1101_phy0: ethernet-phy@4 {
             reg = <0x4>;
-            nxp,rmii-refclk-in;
+            nxp,phy-output-refclk;
         };
     };
   - |
-- 
2.34.1


