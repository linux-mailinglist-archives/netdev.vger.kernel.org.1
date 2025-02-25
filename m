Return-Path: <netdev+bounces-169514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38AA44477
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67BA1884093
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279F23AD;
	Tue, 25 Feb 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XwZ8C/ve"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023821ABA6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497536; cv=fail; b=vBpq/xLHoxmvQvPqGmC9d0ePfOM30rEhKqwoDGSikrxMfs5bE3VTkbkQZUG+BAnnSWyHPdcdR83P+PGTb2O6yv8Tc4UEwftK+XltkVWFjMXEZLM8SQnXqxchnTnHz8IFkmJbrUuTaEsuqN/eFzeuzpmCKNd3gefXkCVPtIG4X1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497536; c=relaxed/simple;
	bh=KCRUDbuql45W6fDqebR4YHQwF8Uwm62FIKBzyMBh/M4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VdGkJD0Cx5dJI6dFx69s0G77+3bOXOhsFXvjjlCVb67SGuNG9noeYCNzeisf7SKZEb5bZPdqn5/lc2O69368a1njOZYwuD2E2X93vM5j4Os7qn+9ztJSSy8KoV1V02iZzDIHYGI09glYQCzetQAN795rR9HKHxdzEGgsagw9dXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XwZ8C/ve; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkWO2jaiqxCEWL/9lBreZdQsX4j1li/O9n9xKrvsaLg9MZVv1nSpAJ8Nuo5pgO9/B0iklJ/u9CdwejDqKlmXR/1l5llc/aJxDmLmm0ZDAv+LZ/Rzw4U68N6+3pRhn4q4rFQBrgbYoFkao5kz2e0DFUZUdooSJGUcYoaylHGTOdJuupIMbULQOXxHgNTGlGOOTFA4ktvCZ583w9Wwt49VQI9dJ11r8hjSSD6ct1zqZNTdG/SIBa9HXB/tZla79LkHny0iwV5izXONPPyvt2jVhuFropPo1lDUZX6g20ZYsNHXXSuQAzJ+jFqTLYcaEF6tiJP3AryK3p4euVefH5WFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWGlDrtSkzuidCJoFgSMjbp9YnxQTVrtBXTvvp5BVVI=;
 b=EYo2g52ld/vQ5tXFTmgyLVr2PS23V+DxFglZ0F08ByS/rTzNQ3B9r7U88Qf/vgqMJMPCFAaM8++bFVaqPmlRbjxuSoPSEPN22H29xIoLcNA3eL99j1FA+t/C2GalGEwuju55tcjJA/Ye9uoeSpgiYAZIS448d9MspkOvbK5S3mRbLXLFTpkuknEWVyxLnN3KXk00df7ARrwSsEWL0Tj8NTQ9lABvPdZbfoKV/XJCzsPw6IxDOdmqwceGxA45lWu9jvD7caqaWRxC5Rx0cXYAbeBE0+blC+rTGJAELtLitoZ2+EyghvC37bXqr3r2UoliovXZrNLcFOp6wSbN5ARicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWGlDrtSkzuidCJoFgSMjbp9YnxQTVrtBXTvvp5BVVI=;
 b=XwZ8C/vevyBI8ct9suDySeVNUi+VQ4wUqnG+Hwx2tXRngfA77c9Em2TTxxrK5CcpbJsAj/DT203D9lBxUzwl7Ub3yk3z2pnBdmlqueFZY4sNWT+smNbaqd0fbKEyBK6NIlAt6dMFO5pWFThMyYg7gtmgLKNF7CrFBzz82FJUja05Faf41rTVgCmOtk2DkOJDzyVS+XNGnNDPo0yKx7gQX49/p0vfUNIsOpd53wmDSzPOxA176c7msgNLvtAo4mNRdSynvobozbQHb24ftZNhw97tkKph3XmVfjNCz8SfGYt4OJ6uRYYpIH4INKv/UbIveKwWfnRk56cD/tJSkbkQOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:32:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 15:32:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [RFC PATCH net] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
Date: Tue, 25 Feb 2025 17:31:56 +0200
Message-ID: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::43) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f84b2a8-c701-4e3e-d131-08dd55b19228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ne/YodE9LL4q3RW4dQGKzopB5LbWWaoKpkjTLcap633R9LwQ1ZCRM6x8T24a?=
 =?us-ascii?Q?h6q81CLf2tv1IsP/RSi1dlbbgt1e57U/OMfWhH3h37qVoSTtm6EEOv43utYL?=
 =?us-ascii?Q?Jxq6Kr+eMGNY1Ff18712LlVlvQC93iXpmUSsCAKFzQr1M6TvT5EGyI8HgquQ?=
 =?us-ascii?Q?TOoP3fuaw/4FIIMf5LwTbp9HOesXfDg4bwKeG0A/Q/deKDyn9gV2WK2O20I5?=
 =?us-ascii?Q?RC3kHx1JYSn3lSqsfWQcComej2ywwLDxSpC91iyO5GeiRA2mEBgUvPWpmd1p?=
 =?us-ascii?Q?P1c5ofqKQISHbaiE9sf4z0YpGCzrHqoRsE/YPpvXgUXQEt71FNsISDVmldLx?=
 =?us-ascii?Q?mTh3bNIeIq6ITWIUgoKK/St7lJiomOD4t8+goe59ktUuG/GHKO3xmSfy6on8?=
 =?us-ascii?Q?zY4ZqSaIWscoeJuQZkJrKg/eS2rLO1mv9ufqPhAx+o4mNrNUC9RwYH4MHISZ?=
 =?us-ascii?Q?8dshMXKvzI5IOMs2iVG3XaIMs4M24ZLF9kcwL7pR1VXUFPZx3rWxVtW84UuS?=
 =?us-ascii?Q?hEf5pt/A11FqWwfcUgclarWlgx+UxuHn452n8RkXbQZbj+X6He90aFa9onov?=
 =?us-ascii?Q?y1k/OmhqwRRP87jaTSXRZGUALh9fekPLxOtqTlCgOo5/lf90IieI/KTFPu/m?=
 =?us-ascii?Q?7iQrtdXZEKMO2MAznwoVlmSuYSJwME8xfobD867eRnJ0sYolp1Kpru5ebt5p?=
 =?us-ascii?Q?ITbQ4PmPml3YhzsLfx6YTOIDko0Z1S+tRUYxp4juG7hRVwDYBtJW7ZGB2kvG?=
 =?us-ascii?Q?KyJG/h44Uub7ktmpOr6GJUrE9D4FiwTbLlC/hYJGT2Ua7Se088RIv0IyZpDK?=
 =?us-ascii?Q?hYGlBfGRkQwrbG3Rae1vuxHeO+myqLZekAJ6TTgQKr94zPQ3FvLiVi0LEenx?=
 =?us-ascii?Q?4bkgh5lFfyC+Mr4JEW34QsYKJduLhMpix2gW/Z0/ggSpxurVyDViQCdOLJea?=
 =?us-ascii?Q?d4BCJjNoVOWTAWDs/wKC8MtUbaQfMGiWFdB3UTnu9ezssMuTwuqw9oSN5XH1?=
 =?us-ascii?Q?JTzHR4joU0lmwWmK1DTUJMH66Try7jKlhwPd7VyFP+IdU8Q68on1tjChCRdh?=
 =?us-ascii?Q?Q86xihm5KlEdEhvM/DGk6sUUB3UvJ4AAdGMFUWcfrOqJBrfzTPGntueXvAch?=
 =?us-ascii?Q?FqLdpzESJZo6bIlhLxjeb3atfkmzEkDWQCV7GukMlBzcLHbfGP3PWbofjxM8?=
 =?us-ascii?Q?60ABpxNwFyrzfO0CWNOiC8OlTOVSktiaBAHbFiRTbdw/CtedRSxWA+NELZQU?=
 =?us-ascii?Q?VAXJEAdQFy5g3bjbJUluybL/QmtsE7YkemUl47tJqnoh27as2RZdkFZLu9pU?=
 =?us-ascii?Q?OJcewCgtLdZruquV3tHa8DKuNBa0UJq0LGrPJ3J3Xta+UbqBR7/1JSpXCEJ9?=
 =?us-ascii?Q?p1uBVWB/6ZKHT0RXLQUepxpFFAqeGNxLaz46ETHy4azEDuF9F2WMnvnxHVpv?=
 =?us-ascii?Q?xpYCXOwGSl5Vr5d5HcC0svmyfzZfdv1T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JCo76I7djMV1Mv6g2CPMRyE/Tj//g/iax9iWBHQNwmlllruOmSIv3RBIvlr?=
 =?us-ascii?Q?29Luqdrw0lx8uMuLYL4cAHo6PU1JcG5wCgFEn2+kkZHvVU1oZY0TSUYlYBeJ?=
 =?us-ascii?Q?kfTJX88vB6gdW7ruFiV63x402RAqqCCxqUyYLgI+nc/IJHsjPOulLQvg2Dxl?=
 =?us-ascii?Q?nN8cIeDWaFwMAwONuLoVh67Ib7lcJDvC6PxYPMuU+Oji0TUmgNcIT+wbt7gv?=
 =?us-ascii?Q?f4apqAm0ilxITk6l4486yp2luuvOAeOqoyLUbvIlS6KVVlVC5SCgsJVGmW5n?=
 =?us-ascii?Q?Ej4XYmjzm4ftPPvqljMhQ2Rwxq0+k7s582/vou28/Pwl10URGbR9+xONfHkC?=
 =?us-ascii?Q?NrvwGR8OTK9Y1dj21P+gypad/yYRwzHA1ydOhPmp6CxsGJh/naIGe6EA0Laj?=
 =?us-ascii?Q?ocvlVTglJK2oL8pDfP9beuI8cKOCv248xZ0gx2SXO+SzZQaq95q0uOASre0f?=
 =?us-ascii?Q?Km444RgE7ZKa++1Ac1gU2BdQiC1+aolxsEV2cHeeTEh4jBXos8SdOH4URKEO?=
 =?us-ascii?Q?u9SY4/t8Jka5VTh35fgMONqRPbLt0WkiomgcHjCdF9Xaq7tgy1TZnQ/CtsDA?=
 =?us-ascii?Q?pe/HMHgY7DJbinmPUuVqG4l+MPVlQ0SsF8HVc7WqIBTlTJQYzSKjuPP8d4MF?=
 =?us-ascii?Q?26LZ0UKAnT3CLpuE84NY6DkkbS/a/Gwdd5vAE48mQ3VXEqw4DQFbM2Hs+XjY?=
 =?us-ascii?Q?oyEPVCuRrwVkXdm6dC5y1NxQahJXc6CyLUK+7YXBD6mYRQFP6Gr8uofrBJ9A?=
 =?us-ascii?Q?2yKsk6m0ULT9yu/yp5Add4HB9Zsaj8TPdPvYp4jD181QgHDw6Y8GnBVGFnl+?=
 =?us-ascii?Q?c69qkQ9f3LF4WAWuqSxZO6Yj5XhiUETLyZVAvQYHWftzofFxECYfaAgMA3fX?=
 =?us-ascii?Q?trXl+7nd3y620ede85JDVyebHH/69f09/eJblsvm9RHyikyTkOn9sRQqWiaP?=
 =?us-ascii?Q?HlNEMksDGCSC2vDNZH+yDwWurAJHwLuFlXzyzWu0v7ZLvC+DMuMw3r+o5CmY?=
 =?us-ascii?Q?9VOprvh9BCSS/Fwo3cdUUW/CNnv6VynyMyiWHQGmX9JnOrFPfO8msUEPUTu8?=
 =?us-ascii?Q?Df/o3GJCQQwbupnzozUNT3OtILobv71B7qH0Qe1frFzRc3RpRQxuVeTHWk4H?=
 =?us-ascii?Q?wgMJevdLbWSu06YdRlLA8JrxVjYk7bKF7zA6EU/iTlNjJcUAAwIH6Gzi0ov0?=
 =?us-ascii?Q?jhf7CKbGNDEJOvcJknPQ9bcr/qbPKrfIowO7AisqsogR3z76/vMpbD8W5GVB?=
 =?us-ascii?Q?UMx+FRpCfdWbFC6G3QPfDcWvA0YFruSr9t/YDYjvOZ07nLOz33XraofH8y0O?=
 =?us-ascii?Q?Q8dVKNimZOaeYvXD6f95CB0mN3gD+dlf/F7kjA4BGcA5ol35yHsXsjywi7i4?=
 =?us-ascii?Q?ozff/zEon4Ng4Hq42PXDuV+ioGMdl5ry01fN+KPHBwLqF50pCacexJ0bcgiU?=
 =?us-ascii?Q?MraTvgD67yTT64pl70cAEsELluHFWDHgd8tuCTKn56D3ctfROLyfeHDTXFD+?=
 =?us-ascii?Q?tk9GovlVKUU11SYCqSk8FHnxgT2jbNMMpyyXouvgDH0JxJgfZm7m7vlAu4qZ?=
 =?us-ascii?Q?4XAn9tAVyrqE1zRBxX/3RkOIMkeGa51nbXDhRO0MPx/Kzm5fxgUx4q50BquM?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f84b2a8-c701-4e3e-d131-08dd55b19228
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:32:11.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQwilJGRaT7v2+D96qc8k09a3xvDyxmFQ4FBc2HD7n2xVPUev5J8J0W07/4ySnTmHpWnt3PPRz2yMh3fJscPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8957

DSA has 2 kinds of drivers:

1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
   their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
2. Those who don't: all others. The above methods should be optional.

For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
These seem good candidates for setting mac_managed_pm = true because
that is essentially its definition, but that does not seem to be the
biggest problem for now, and is not what this change focuses on.

Talking strictly about the 2nd category of drivers here, I have noticed
that these also trigger the

	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
		phydev->state != PHY_UP);

from mdio_bus_phy_resume(), because the PHY state machine is running.

It's running as a result of a previous dsa_user_open() -> ... ->
phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
supposed to have called phy_stop_machine(), but it didn't. So this is
why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
runs.

mdio_bus_phy_suspend() did not call phy_stop_machine() because for
phylink, the phydev->adjust_link function pointer is NULL. This seems a
technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
machine restart on resume"). That commit was written before phylink
existed, and was intended to avoid crashing with consumer drivers which
don't use the PHY state machine - phylink does.

Make the conditions dependent on the PHY device having a
phydev->phy_link_change() implementation equal to the default
phy_link_change() provided by phylib. Otherwise, just check that the
custom phydev->phy_link_change() has been provided and is non-NULL.
Phylink provides phylink_phy_change().

Thus, we will stop the state machine even for phylink-controlled PHYs
when using the MDIO bus PM ops.

Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
I've only spent a few hours debugging this, and I'm unsure which patch
to even blame. I haven't noticed other issues apart from the WARN_ON()
originally added by commit 744d23c71af3 ("net: phy: Warn about incorrect
mdio_bus_phy_resume() state").

 drivers/net/phy/phy_device.c | 38 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7c4e1ad1864c..e2996fe8c498 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -241,6 +241,27 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
 	return wol.wolopts != 0;
 }
 
+static void phy_link_change(struct phy_device *phydev, bool up)
+{
+	struct net_device *netdev = phydev->attached_dev;
+
+	if (up)
+		netif_carrier_on(netdev);
+	else
+		netif_carrier_off(netdev);
+	phydev->adjust_link(netdev);
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
+static bool phy_has_attached_dev(struct phy_device *phydev)
+{
+	if (phydev->phy_link_change == phy_link_change)
+		return phydev->attached_dev && phydev->adjust_link;
+
+	return phydev->phy_link_change;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -307,7 +328,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_has_attached_dev(phydev))
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -361,7 +382,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		}
 	}
 
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_has_attached_dev(phydev))
 		phy_start_machine(phydev);
 
 	return 0;
@@ -1052,19 +1073,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
 }
 EXPORT_SYMBOL(phy_find_first);
 
-static void phy_link_change(struct phy_device *phydev, bool up)
-{
-	struct net_device *netdev = phydev->attached_dev;
-
-	if (up)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
-}
-
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
  * @phydev: target phy_device struct
-- 
2.43.0


