Return-Path: <netdev+bounces-254725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIw6N945e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D2CAEFFE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8579F30A8F0A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C063876AD;
	Thu, 29 Jan 2026 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRA89QdV"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6063387592;
	Thu, 29 Jan 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682936; cv=fail; b=fX8w5ubOL+7QNJ7ZLn3cHn+Km4vCFEwhZCHDxSgmR3W/YzK5s3Z73Jk6vC+OSldzMMR/HZUhSm7N2rChuaQ/3S6FIgoAagC6dPvAbjkelv9XoUyoOXFAIn92SfsFRd/uB/fMoWR97G6PWfEWCUBBekw3F+/aSyuBlgaBwPLov4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682936; c=relaxed/simple;
	bh=6iCwmkSU9boaHvt+3HYN5kfhPswdXfZz5KpMvvHSFPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3qpiHeUyLy/6E6CWwAp1p+B4FobT9J41BPOpGEp557RLvu39ISFbvto1xmj56RaOucoJOZ2I0eeiylPwLbhPPdVfxcqRjbQxxx0zHMLSPZnQid0HQtB93anX1mdPn6OzfuluhGN8b790juc7GidA1dRspxrCAeNjMZlRFWEiQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RRA89QdV; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTUMiw+w1YO+BUolxvXvchAy8Ve5c2K+4I5T+WnEFev59sYwnVPbuB1OPkaXvaklg2R5B5OopypD2vyCp33GgenZzCJC6xR9XgTNT/pWM+mGTzaueXVVlLYiadE1WxipOQlyAw0LzUttoDu9w0Cg2WcsODq06dmnxwEoeUFsxrdbKOmh2wUA6ZSWhtddx3mwDLjOqFcGTRWERuLSFXMgTw2uMmvSPEZwPAjFQh+ydDDIhRuNFgkPIs7sdw5gKla/fqH5UjN8ZwFMxWistqjWJMGC7wOb2ATm61Qr2RfmEfwmiF/XPyUaDbrkYWwTLDuA6zkrz6dQsRu+hsaBY3meMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwOG1lDDon5F4/axxKvCVZkf6/PBLv77nHzXEqH0E74=;
 b=NpoqzaToMLuQl7lH9PxK6HHJUn4xENXurTF0kFWCOVBWITuWx1bGjsEu5B8qnnRn/wcHdmQgNVJzDfj2DqLeqK8+7W7ledOmGX/fO5i9XyHbGF6+PMxDG4H7ozOwoSTcyp4xRHCTpm1ILCM+1408n9Y6SYDlv09mmrRmzk0MS3hLwhx1+M4WuuCgWG4i8IKhMi8XUxGhdIFQVATT7Ff7n0+2OuYnoCAJ07r+cC0GmKBxPfHCyPeIxfuRi7cAZJ+iSTaaBq3NHUkWX/K/B1lxLdcDjCczn24IWFblZDHh/UdNJe0dwh09Xk4LpfBOhMrX8A45gPSA+Elux6Jv7e+UIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwOG1lDDon5F4/axxKvCVZkf6/PBLv77nHzXEqH0E74=;
 b=RRA89QdV+t2+C8spSGj5L1GoeXACr2ZW2eoLwXtPO2YQC53BuYT8o7YR7InVBOoVqltUHH+tlzNh3RO1poTIpT2uOj/AkboSkQip6KmDLBuE64O5MgBW+ON2ItJdNXFWP4J7OW3nSGnaoiXfQZWtCfGHoFuMDRO2q2rjkTv3ATHqLHxAemLax6+2JwUMd43Md/DKHGTnOhNeMmRih8b4+yZFhmduHi5yT23SzoAq8vVQcbroGCj7U+hz+mWpq9tPFxAHx3hoKvGuIAks2RDJYuS+tNhQylHlqBYYc+G58ACGlB4o685bTgQxD7AVU7ofDSn5KBvmLk+WeehPwwvXdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Thu, 29 Jan 2026 18:34:38 +0800
Message-Id: <20260129103447.1893129-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 438ebdc1-65fc-44e8-d178-08de5f222138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r1vsZtUlORF/CPpsrfaUd1g+FinqLU6axFEntMbWMHu5NERBT6/rrU+vYib5?=
 =?us-ascii?Q?poBml8f4PdgagCTa2DFB2Mu+DtyxGftUAtKqx2DnomdJllCyap1E9La3yCjC?=
 =?us-ascii?Q?oUDYlxFR9dNjd1xlKuaynOCUihXNh/Q2/FVBOokxtmR992pPShy1fpC8pWju?=
 =?us-ascii?Q?nT5mfut2t9txFZLxHUUBi7S9vA8YAv5JQhMAaw5lAO6XTVeLD6bDa95dyFC8?=
 =?us-ascii?Q?nBujjQQt3FkGYo74/+mJUDdTzYxPZcQI2SXRph9MFqQvid4mM2T9CNLcqbDZ?=
 =?us-ascii?Q?3gts3WOCoxF4nrObmJ6L2zUJ7X4sM8xSBZji3//dXRgLVx1BAamlezlCvcdM?=
 =?us-ascii?Q?fKESlBtAhMOHCD4Av78MMIdvBiP2IvJkheMXW05ov2O8OxpJBTDsFl8Ds4bf?=
 =?us-ascii?Q?TRnFKCfO3M/CS3KSbx7AU32d+3pc6USTr+PRmN7afAm22hGvlkJRMQqY9s2c?=
 =?us-ascii?Q?IyuEcGg0lQjuLf436qI9pRTJaK1J2HX47rxYVIdxhp84YNsh7fF5YXOjfpdl?=
 =?us-ascii?Q?JP4DCh3BHQUS1/SIeJuW+1Is6daapIAbAIbgoeNK/ygM4tF1gA9M0/f/g1dk?=
 =?us-ascii?Q?RlILP7mwNeQYUmLqYonKNjC8qjieLZPnCKHiWGYf//ZJGGyo2pR4kyRzyh3g?=
 =?us-ascii?Q?0CfmcBztPk3rYbIKluIbAzDZiE3Mvy6saf5i4TapeRU/XcAo/kTSubcUQ6uI?=
 =?us-ascii?Q?FePXxRpuren9DwWc3SbxOWJmMsSm3xcqyIs8Kkwsr4Ntt/yDeeznb1+X9wrr?=
 =?us-ascii?Q?NrI0iLwTZ4Wmkn/gY/DmQztmbyJ3MQo+sDmFWLVeE2JnF8D/JgvMnelFKuBb?=
 =?us-ascii?Q?AiO0Rp9V5SQS0Dosrb+7beMqbC3as/4b6rZVfhG0hzRsAcoIeEJLirDyPRZu?=
 =?us-ascii?Q?f8ZSPA79WmfvmcMOHqcMA9eAz7ekVP+lJM/kgSczJ9bNi3mymmqAAGbPgoyu?=
 =?us-ascii?Q?EBI4L5ez8mqazgYS1dOGpGjz03j2tfVEh2vnKr27O52IwPQFp1ZS1C/6WLKm?=
 =?us-ascii?Q?TLHVfCeXsjyFOCNhTEPBPpgG4bmdYGPD7XBP7LgtF1jKJooTQmCd8YS7M5At?=
 =?us-ascii?Q?Z73CwPjjCljNJ0UZqxA896vbjKe07x30hKqYBQ2ThhTu+/TgKoUsYR5VIDT4?=
 =?us-ascii?Q?c4lESgAHSNkB7IlL9GHI9kc+VJ5ckqVEHchQ5XO1z2kNbyaWLJJTYJzTaTmz?=
 =?us-ascii?Q?7JInfMm1TUcd+7jI6trYEog77iH7vCYvLF4M40Vg7A1ZzPSXcDYGf9SaGK+M?=
 =?us-ascii?Q?yyaXLEDDa2/rcO+/OQ87yWuUSPhSCFijX13zCiwW+dz7AhgOTTIRnQkAIBMF?=
 =?us-ascii?Q?9gybch02B3Y/uiiemQCAaQ7cUAq0osuJED6XUUCtalDkNPlt1U8d73ScZ951?=
 =?us-ascii?Q?pdi3lfcEdI8uUtG1RQ7XlLWSPzqZ8/KIyJCEdSj43/0WPGikzpGRMU5fTHQI?=
 =?us-ascii?Q?TC//FM5Vb71DgQjyeU3OtARKC2VC7ZeCdHLIWpFozyLnKlguLHwLVtujfGMH?=
 =?us-ascii?Q?nD2DNJJRFYPtrUvvBB8D2F758rfLT4gTEj9kJKIMC3AcrbOuIO6G/lV80oib?=
 =?us-ascii?Q?4xmSQbqvC1WjgZaoFqpeenuMfsrFhUrBS+Id/G2K+Tc2w+dhF8DTWl/RibG/?=
 =?us-ascii?Q?wR8S3/viRAMZZogfJeQmZec5U/YFfgaLc7D+pkQD5RXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEeez/F12Ru0oA0Poy0ncv6Fr0Y0aQSn1QhIJueK+1rf6GkZ6dWIxtCrmfQq?=
 =?us-ascii?Q?2mcMNBnuS/MZwl8vvYMkkBq98XLEpGY0kuEtwoqieiXkYoaPWCjzJ1q6heas?=
 =?us-ascii?Q?ASaXxCDQFtlcL8n61aNDkP7GhchutENFdx7eI7ZTuE8UVSMIIH4KS7qxyPZC?=
 =?us-ascii?Q?Ia3uTWFoHVySs1haIu4BRBJuIKQFYucpbZozw64YOf4ZxlAkGJ1wzj07Mvcn?=
 =?us-ascii?Q?/WIgGJUx/Z3U7uV2nzzsieG+fH+wOPdxLvtGciBdthTq8QLFQsMAtA59G6dI?=
 =?us-ascii?Q?hX8VqInR683i7mI0RSv0p1LQbow3+Lnn7auxQnCFff0VSpOWZryP6BxO8gFP?=
 =?us-ascii?Q?+ypJsuz1uYDgjLl4GD9rRFVTnFXP4xfoQ0NFIHVchU4DDtjCvTp44rcNj9t/?=
 =?us-ascii?Q?xybB/aOUTYRRQr/Vj2Aa9cZdN6gx+9zu4R4os9cnUFzRFWYEgd7zVbYbgFjK?=
 =?us-ascii?Q?aehYiMnme1sh+ZVpwvFmByEGv4g3IhQFsEdOYgHY+97ckA3UhbuwdMap5KC+?=
 =?us-ascii?Q?zLBLnQYWy8Rgum5tcoaQM5PxbPYMbA+LQzF2X7/DyTIc8lM81w3Rjot/MHuI?=
 =?us-ascii?Q?LwOLn39WHFm+YVJ2dourXBaBMzzo8hYkNMzfhkhTdO7+xoRUTUzUkoUBcbkl?=
 =?us-ascii?Q?9+KqV3Mx9KEd1vlT5tJdz2aSEb0hdJ0osqW1Ji3a3KNb6kv+YoPf/27888dp?=
 =?us-ascii?Q?Fl4tboAqafHvAK5A2YsGXjD0ANh8+SJ4Fb+Zlracv+MrvtR9pnWfBaCx1ujQ?=
 =?us-ascii?Q?a/BV7FcU7TZybYzioZA3jV5Tw8oPag7US4JS8wpvtpZBX0tZuDv0BOW4ju2X?=
 =?us-ascii?Q?b8fUoRLBKogNR8c2KPqr+rykdcDRaPe4WXhptlzMRs1SntQqka07QC9wxAap?=
 =?us-ascii?Q?WnYkplRmM2Uq7HAyRaWIg6m6BhaXkF8WobNMwbn6026SoeR7kYmC99yg1vb+?=
 =?us-ascii?Q?TniHpnk+SVA1QLpiXfsH2ysyM7Zgb72iYAf15PX/dtYsi352FtG4IT0eiZwC?=
 =?us-ascii?Q?qnZza0aldFk6OLw2e9/Fad4MlyQu1dXE9/GzMM/HNKoJj4XBJtHVy2kpADLK?=
 =?us-ascii?Q?42309xBl3zFLe7r8x002Ahcj3smoOLR+s7MK4NKge6xLKeCIrRRBGuMyTcng?=
 =?us-ascii?Q?NB3zxXg7T9kUsf1XCV6Sf5qPfN6SvU0zaGprpaMzvVcfyv3d/Se9Ym8OFjuH?=
 =?us-ascii?Q?cwGDFb2fuNT2uG6Ec2PG42lWOfeDTnmxx75WgZr90NZ+8G3f5xAE9bd+GCOY?=
 =?us-ascii?Q?qPeZ55+NmN5oKnQ12UguAv5YdATBCixgb4N1jKS2rEOgFsi4N+EOEWGqc1hW?=
 =?us-ascii?Q?yqZu9J8JgFZ6sbyUYvQnO5SIJ2Pp95sH0r6Q979nJFxNiQIAYMXpqSrUPjoy?=
 =?us-ascii?Q?wuiPXjbuhzjSiF9B1T4IkVyywJlqjhD3z5ViBrcwCkd6/tOfmD+PyXZiu9iy?=
 =?us-ascii?Q?UPdXKnblZjG/h7eOB4+wTrBh7g8MSch5wFytXe81Ar8DpmxbU74obTqP8kcy?=
 =?us-ascii?Q?nR1A5ie9GYXz9+B/tJZgCpj3zIzTf7N+Gc5iG5ZV1bfxrxx7XwysWyAnXBv/?=
 =?us-ascii?Q?z6wZNIKhsF7aUEAOa6JRh7GdyNWBeMQ+D+j8xq8eaFcaXTnHNt2irx5rNGoJ?=
 =?us-ascii?Q?mALlCcwL/9sNLmYQ8aOSEKj8EPKHwnHlCQx2Xu2lensKMw78KnytId84AkQX?=
 =?us-ascii?Q?Rn7ZRwS6J8SeR/NuZ3gcxBj+XTA8FvHkAwhnbmpLcjfIGAM1gyde9iGWs0wl?=
 =?us-ascii?Q?EDoVebqeJQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438ebdc1-65fc-44e8-d178-08de5f222138
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:32.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh/0hFdUFHmjGnDSDd1PZS7YslDByqbhyga8pP+0JzIkWvbuiW619jQ/Y+xEWtU6OQEKCof/ydMBjUOG+J+6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254725-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 84D2CAEFFE
X-Rspamd-Action: no action

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. Such as the kernel path does not need to call
xdp_init_buff(), XDP path does not support swap_buffer(), because
fec_enet_bpf() returns "-EOPNOTSUPP" for those platforms which need
swap_buffer()), and so on. This prevents XDP from achieving its maximum
performance. Therefore, XDP path packets processing has been separated
from fec_enet_rx_queue() by adding the fec_enet_rx_queue_xdp() function
to optimize XDP path logic and improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 256 ++++++++++++++--------
 1 file changed, 170 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7bc2eac01e6e..8601b0a581ed 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1666,71 +1666,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1843,19 +1778,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1871,8 +1801,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1903,17 +1831,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1962,7 +1879,168 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			} else {
+				napi_gro_receive(&fep->napi, skb);
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1971,11 +2049,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
-- 
2.34.1


