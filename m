Return-Path: <netdev+bounces-110688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C192DC30
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC43E1F25466
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAB14D6E1;
	Wed, 10 Jul 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XWIf/dRa"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013028.outbound.protection.outlook.com [52.101.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8613C3F2;
	Wed, 10 Jul 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652502; cv=fail; b=msozn3xkKtFzl82KdxoweAUnOoFWf9i99I5/82lJcV9qqWykIY4qynstJFx2QP9yYBlOZf/JR/bWRPR1f0s9pTjX33CO4klY9gAGs5kMkOIzr2ESnJnHogK6LtzBO5CMRgLuSgw6Re3+LkJiES6ui09QLtApi1F6rx7B8GmyeAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652502; c=relaxed/simple;
	bh=rmMtvbdL/9te8G4PI+VcMrj6QTqnDmEzyTpOdxn2Nmo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fKprrn+s8YyqrPYpAGxs3bYXWN3ImZm1b399KytxLK7tub0W9yHJ6b/M9Xpm6lRtChQYw3z+mUumyhHXprUulmJu13Y/F3U6h5tnSie50q5/Wq2ux23pJuOZ0FI8YFKLETdYR6JxxbuAtRa46TIU16/4hIiAMolKSvjBdopKX38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XWIf/dRa; arc=fail smtp.client-ip=52.101.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwP1bcCFIuZghxwAUUb09y3FHN3AOFz7mGyKyLzakdws04vV4jmRwPDcozSp7dNr6Kg0SYR0MbGd+kMMuMnf8Ez1xWakPDxamOfc3T5xb2fTwPEmMoXtrg9BWn97Ui+beWbXmp3To3ujVr47/2hPyQOIDLSeD50lVTcfZnanQaVd22NrxdZCBfaoGdjoUXp7ZDHCGbuhiffYzNJLo42V2pdX/zNgIo2VRpUCznGXhFyLpRS13HaJ2JRAeSsvAti4pjWRbYXg2AwFy+RQb0zxFg6+EOUi4pCLX/ywdBB0shEdU78vKdBPP/DjWQodwV6NfgTha+khtFTK3wTxaO6bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk+GJCK6kik4BdwnnzD7CLokkHR91RIg/sSyr6Oq4j0=;
 b=fX1U8LYY70Y9atIKLBm9O5rTm8374TSc6uoPLgBuhjgqNRKqV0ihK8tLdotghRfFLuSXT4hb7zZTXxqmpRIoO+VbK3ssMnglh95kulvtGYEEXkkZgqSGHNn5RxwNXlIzHoNAWP66NGs+xF72XG/XAWNcbcl8n3dUj/YbRpiFSXwn1aJmP6s+zr5I7qnSvU/JocwQ/PI/8hyurt3Ays+U9ZkU71CUKPOGWvNOjjJMhCup48afSPuG6+vKtv04DylydPIibVC87Ov1C3h9LZUQkWd8/VCwuT+WsW1f3SZwGcaUtIaFMAqh/Un0M5Q7sCW2WRdoxDyPIHmSG24Zsx0pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+GJCK6kik4BdwnnzD7CLokkHR91RIg/sSyr6Oq4j0=;
 b=XWIf/dRazsDXCUCeRAwCQLXJqbWNbu/6rNz2I3wlZkO9UdhlT1W2/IxvP3xmX0sEWPtIyfj5/Pyu5HbxXy/MkFqvlQ4Iwo84P/ni0O//tQHYTFhUDOLk9bhVaod9/OGLuT65Zqz/lCdfcwNKwUyeoXcR3PJFiTRB4E7ERsJUkJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Wed, 10 Jul 2024 23:01:34 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Wed, 10 Jul 2024
 23:01:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 0/5] Eliminate CONFIG_NR_CPUS dependency in dpaa-eth and enable COMPILE_TEST in fsl_qbman
Date: Thu, 11 Jul 2024 02:00:20 +0300
Message-Id: <20240710230025.46487-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::41) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 901dfb6b-5294-4d83-560f-08dca1343dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ciq3V3POKUb5L1Art1C2bPHWWr9HPQ8Is1oLu60h4gpP96Fz/BShPEqxbeR?=
 =?us-ascii?Q?kSHPpHopX1/xDtZJNe4CyktKPLsxOuEd3AlzZfzG56OF7Olrk5rQ4DJJFG6N?=
 =?us-ascii?Q?JB5F+7afsUoCnJwDmGAOUxIrLU/thQfrP3V0jQwWGrtMSNPtl6LMtKB2fFRH?=
 =?us-ascii?Q?d8X4LLh46bfOSiW1OH9QZJUPIwkaX3h6sP0m2mo0UfjhrDWY/+kyDh6I8pu/?=
 =?us-ascii?Q?GEkG9qhNjs8tW+87L8OTaafktzWLaiF5+AGW/e8gqj+8oraVnK6b0DY+wZ/0?=
 =?us-ascii?Q?foapoUdHvs6kgOo7cTRn2MLLXqkw7SV29iRUubeJUwk3uG7Uu0sG4HwchzVF?=
 =?us-ascii?Q?NXx4nyvcpRBn59qYhwH1hTZ95DmHT53R83r25COGhZwu4fgIdH1TKcPbgAmq?=
 =?us-ascii?Q?tv0vdd5kBD+Su/3t3IF9OyqLPyokLrrlSl3zI6AGBccJObE6ys1X/XtLlo4y?=
 =?us-ascii?Q?Fz95RV7vZebjpM0EEvv9W94Qti0z1JixiuMtBHJgfyBGDgpTa6RU0Hff2/oj?=
 =?us-ascii?Q?0YM/MkQ0FCwTSw3PD35+s4tJJZCL/gw3QJ+CbpfwcRomcv9w+po3ctNYpR29?=
 =?us-ascii?Q?sm5avbmunvZiMKlBvB28L61JRDZqHoz0e/VYw8yHE2fXwrTibqCLkFkZwaC0?=
 =?us-ascii?Q?WvO+64TjR7+abTNFa1+eFQ3ISKfq05h0FycqSFzR+UIiqIYxNLzBYgwOjbCP?=
 =?us-ascii?Q?LWuB+YmzUlCyr9wLqCI2kM0ypfp7yqUwnPYIfQoigfVrsfV0i+/liUzsSpVC?=
 =?us-ascii?Q?hhIf+u774BMRg/4lq3U/c0NUT51UY1VcC2IPYwGBJx0LwRWsnYM+AWAaas1O?=
 =?us-ascii?Q?u8t+3XBxZU5/RK0f3ZeAvFO3KjMx5urCSUSBj+oVG6WK8KxVwiEwXLX6/uSt?=
 =?us-ascii?Q?u9AvcN74U9iZbGftQLIvLNmgQ6ZHaHC/e767cGotr6+hOIvIMGSK30zAIsB+?=
 =?us-ascii?Q?kHDzIAWNb8WxA52/dUc0r+gc19C3+sWNkWi7kAvMIrfLAds1woKGv3WGi5Zo?=
 =?us-ascii?Q?AQ/PoYTl6oYx8Ei0rltBmwI5ohrfewMW+nGC6Ri5yJ/M17AfujL1C2MJmgpp?=
 =?us-ascii?Q?hreDFfyahILSWni0nJkqDk0eWUNoqWuxsn1RtQZJJL+E3YTvjICkKas3I7hO?=
 =?us-ascii?Q?lORnlJumh1lBgbEDkPe5TN8I8uU2is+LIWIbMzC5/6zU943DkgE6PpY83G8S?=
 =?us-ascii?Q?H+DUYuTo6EAaJ+rEXhUTXon6AsLBz1cFWP7u6oTSmMPvYRV2pzcKouBsufuq?=
 =?us-ascii?Q?rhnjH5nIjxyLYU478fVEEXool1rdTjV6aei05meSiEranDZ7SjVmfzzMvqvL?=
 =?us-ascii?Q?hRp9mjC+VMWjtu5XIIeu3I4qbTayOdkneSG67XS6ppSgQ8GraKR6FBTQUlxu?=
 =?us-ascii?Q?MUhINk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P6p99Ch5Zp4vFPclauYAfcn3O8qHMxpiRMahPBpoWfplQy8WrDFZIdKgZuGh?=
 =?us-ascii?Q?13eyuPnLIMB5UPBsc6LYbwPwE361vbRgJcrbvzqoRTf+qm/K5bMeNihxRFW1?=
 =?us-ascii?Q?/HUEY4SEaoW+/0jy77e339LhcgtlhbtTeVS9OPjSTFB/xsKrHHZdTplnIs4t?=
 =?us-ascii?Q?9lVeEJGiZFMSGnmYzPm+8Azf4uZDg+z85HgbT90LfhsMaFBCJwIfdIRsTe/3?=
 =?us-ascii?Q?yQaI5O89thOYZg/7zh+5jgeTTS4yqPlI+n5K3B68sLHcLPLNR5C8lx4hSjdv?=
 =?us-ascii?Q?70IsfadD4dJM9lI3natC7zhFUv0ZaLOO/LejhvvaCusE/o50D7H4+lzIBvPK?=
 =?us-ascii?Q?dm3kRPcjDTFt356U9f42kQoOwR0Q3AKkFMmJ7s8/GAMUl9erGvXO2+TyRDLH?=
 =?us-ascii?Q?hmBY1MNl2w0PGHoNlgXTNIOwtKvd2NDJZ0Gl4uNP37Pi71jZFV+NZGUw+7kx?=
 =?us-ascii?Q?td4zluOpO/H64LJMre4FYTKxWqhgHpNtTjeRka+rBh5FsDzgHkywSHb1uuR8?=
 =?us-ascii?Q?bWX6lxq0RSVciN0k/s3ZMQN1A8nUXro13ULwB9GKd+9WxW7VLVMkUP0F2iGw?=
 =?us-ascii?Q?Ylcv2xcwnOp9xqAGqkEosDCS3trYFBp3r2EyOpFLWllGScSydFRogZ4EL3KV?=
 =?us-ascii?Q?41xFKMWRFlwtNoEU+SXxJHUc4Q0ZKr+4CG8KsNAWsa9phFqazXm4nu6NMEn7?=
 =?us-ascii?Q?g00lk2VvCKYfud9FgesZ9a9ejU7b3t/5HC7GA+0u1RVsJmYpBP0CHk3fLv1f?=
 =?us-ascii?Q?NRpNxEwHZuagghDZMCY7LAztLef6C1LGbicOrnNfv28c1EQ0+xQ3aHieFouP?=
 =?us-ascii?Q?IueCWBqxPjrTPAitz2ooXQjA65YmM0HGZ51E8X4ZTiriqt4GFywxdA0pzuot?=
 =?us-ascii?Q?2cV7Or9fuCRef/6n6fqVtdU5//f/4KPK9Y368CQCtsU5xkc+ZGdE01+b3ii+?=
 =?us-ascii?Q?oLUAQwEg7NJAT4i+ESDwfd8QqeEH0XeewUm78KYNHiYYKCXWB9tHIUnSQpdj?=
 =?us-ascii?Q?j7iRl4ATBRItxRTgow5H9I0/yBblrf4snERzP0CbwX/LjlZ4mIMTBbzinnKn?=
 =?us-ascii?Q?cHibupE23Z60ayf1sUQOopbpzASrt6T7g0HwZe9cR5mPbVqaIBgo+KnsqorI?=
 =?us-ascii?Q?z9Vdx98tY4UqaiaC2v6sJkJeYXH3Z8H79l2I7F77eETiTSoBGTqOOSjOoBvV?=
 =?us-ascii?Q?fpckmzUETIBWlg83qZvHlQacsZM5RxtZRcxVgqbpecxmGFG+bEf89DBz+q73?=
 =?us-ascii?Q?HPg9rAT+8OnjGymMDnX4fIJrrm2iB86NTxUjNIw3XaE2amw2vVg4dzev5Ef9?=
 =?us-ascii?Q?0+TtRXXagywVbZ+P6Upv4BhgV/+D5p2g9erk4j0TRQg8mgOkQ/d7TFD2y31V?=
 =?us-ascii?Q?rZbO529ikqp8DOO11UyZ/h5RFSoes3CzYj7cHFZ+XtVR0EXK5Bpzv9D6+Hs/?=
 =?us-ascii?Q?+0aNBQEvaHvH8IUhxX93XWhYA+0VGCc9+6b2gULaIVXZ7be5+qzgWnY5Oxdl?=
 =?us-ascii?Q?5M2gLIiR0YJjdQ8LDQOsqZ3oloe/XBToXr9/zANR/OVIJZKBdjK9jCuL3+yy?=
 =?us-ascii?Q?4b6WvRqd7ZrvsIK4LyE8xBXlCbrsy3mKmi/m6ssNDUPtCoWlHuInjVuYH8Qd?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901dfb6b-5294-4d83-560f-08dca1343dfb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:01:33.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqIttbvSmA6/bAAHOXzAl9GfP60OcO2+02/IYfc7uRkTc7MXRT3cwdgcDlwsAzDDF4TMm0p4TE4KOlGSO2HZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

Breno's previous attempt at enabling COMPILE_TEST for the fsl_qbman
driver (now included here as patch 5/5) triggered compilation warnings
for large CONFIG_NR_CPUS values:
https://lore.kernel.org/all/202406261920.l5pzM1rj-lkp@intel.com/

Patch 1/5 switches two NR_CPUS arrays in the dpaa-eth driver to dynamic
allocation to avoid that warning. There is more NR_CPUS usage in the
fsl-qbman driver, but that looks relatively harmless and I couldn't find
a good reason to change it.

I noticed, while testing, that the driver doesn't actually work properly
with high CONFIG_NR_CPUS values, and patch 2/5 addresses that.

During code analysis, I have identified two places which treat
conditions that can never happen. Patches 4/5 and 5/5 simplify the
probing code - dpaa_fq_setup() - just a little bit.

Finally we have at 5/5 the patch that triggered all of this. There is
an okay from Herbert to take it via netdev, despite it being on soc/qbman:
https://lore.kernel.org/all/Zns%2FeVVBc7pdv0yM@gondor.apana.org.au/

Breno Leitao (1):
  soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST

Vladimir Oltean (4):
  net: dpaa: avoid on-stack arrays of NR_CPUS elements
  net: dpaa: eliminate NR_CPUS dependency in egress_fqs[] and conf_fqs[]
  net: dpaa: stop ignoring TX queues past the number of CPUs
  net: dpaa: no need to make sure all CPUs receive a corresponding Tx
    queue

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 72 +++++++++++--------
 .../net/ethernet/freescale/dpaa/dpaa_eth.h    | 20 ++++--
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 10 ++-
 drivers/soc/fsl/qbman/Kconfig                 |  2 +-
 4 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.34.1


