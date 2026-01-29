Return-Path: <netdev+bounces-254730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOVYHEU6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F810AF057
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4493130B4CE5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470D385ED2;
	Thu, 29 Jan 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AludObIq"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A0389DFE;
	Thu, 29 Jan 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682966; cv=fail; b=emuUcLoi/9eXHjoGEmSPzox9dTuLFpGzclYFRlHzfd21SQ9kzbRDt8khyKdX3MoigEMyUsddS3U2pPW7xlqpCScmjQLDcWjb5galcyVydV5L1xMQNV14L7t4wf15nUmJw8ms07yQkIEoajZx/ZU+SkEhCuqMNmCNKUZZIvOz/TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682966; c=relaxed/simple;
	bh=L72FL+31OANFWFQEwfzw7YZeYitjc0zGhJM2McGfGlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUHe6HGPklfBXagYQE8UA+PTL4YJyeqJkDFY2NbtkPuSLxI43Ahto4SxGB/Tcc5Q8O47/Z0O0sE8bOjzY00fVRu8nZh+SrW6M3PUuSg01j9Rp040HvJgnK2kPyPl5c5A285D8YD6J5x54XaIjzYnciHRLLYqZpLzqRm6I5g48VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AludObIq; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKoqsW2o701tPAppO/K/rqHTZ7/W8OxQfB1as/W9/t+yu0WGjcHI4xep07io4lJA15fLWIrokxU+5bq6/HZIlAayEGn0YD4Ct66S8ICeEKwYjd/kvkg3UQUlclrsqH/R2IBCgF9/3DPhMb6lnafoL1nAtgU/ncMDAZjnEdlIuy+PtDQ0jIB0XvK/FQlAFG/HOAJf6tx8ylJEXR/uMIbrmK+UmtwEj+n9EV5oMhN55XR3CpVtsxO1q2R7mHjbHbSUtn4cA+KLtBHVVuUbgR7j50Goo5iAECQiKWzUwBp402s5W9AGJC450uYAL/3UvcELuHSO36BPdA7gLnjCUWi3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgpHTUilH/KCbufMnIu3Q605t2H8lAYTS3tLtCJcwHo=;
 b=hMVe+GqKiIBPIxke5tmxtc6Z8h4iKlEj7WfpdYmipoHRePZJqejO3OpXoKFjBcNoBWh/FrqijlINGIcxSKf1+ScaqUr6wCYKjRyQySMZK7hgzFTU+Lrs0mn+NhWRH88+gkeHx1g/VIYlUBL0kG1hn5cPVpxqwcfdKls2eP+6d5exJ58M3Cvjiwy/x+fKN8hFtAMQa1q7OkIhck87ot4TjG4+o2o9Aux/vkzrlcuazsV3GMj30IB8xk06uz7xpPgp2p96OtHRpMe7n1Zn93mQPqy40LgiQsNlcsPjGtKCo86oAuQ3kxsgs/igPHR02Osq0vLfun5C6U17B9wFvyzc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgpHTUilH/KCbufMnIu3Q605t2H8lAYTS3tLtCJcwHo=;
 b=AludObIqBDZECnWMf1YRnD1WqytgYkfpc5jHfJ9/JMzDflRkCkYD86HaJaOn+8u6FJs0Y6NagAm+4VuoJaC49ELgracwkjgJMLny452PhN8WyxLFkr1KFe73wKrJzKf5avfN1L6h/k8qfXgFOMMajatrCdJCHzSKYH+17PpaZOWyB30Do1Gef91gNYRdOsa/GMNJxeUqryFkK0Md3mSC/jRXvSlHEuUG1vcnoqd4xsMiOaH/+SVaghjuSdA1P2obzy8KkeCdLueG1r+25dxs87hVas9FB7LD/nDTOS7VGM/hucO6n58yX38zROKf6tv8C3kDRIfszc/OZ0upY8nLDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:57 +0000
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
Subject: [PATCH v5 net-next 11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Thu, 29 Jan 2026 18:34:43 +0800
Message-Id: <20260129103447.1893129-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f227acb2-9e74-4c5c-bf40-08de5f22302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AzLnzD4C5YTGD5x1Xph8ubhXzbGh3Jwq65NrFWco5M4E03H7kXIGXigr99Ei?=
 =?us-ascii?Q?gxp+FzJ+xdZnEvp+SEc4eYY9FhjeVdeMLNfkeAcWl9qZ9qDdSFilrGoEf+YH?=
 =?us-ascii?Q?23/6CnC7SHwYw/Fi1gylecsUaDSQSsCsSPxwHYHBfMr8RBZTpq/hC8XQEbLA?=
 =?us-ascii?Q?YI+SsDmuKrUhYrk0fHL0HPf58UXV7QK5fgBz/6jYTl2khFwxae+mhswIWxUF?=
 =?us-ascii?Q?c2l3NLbUPPTPRVS7gGVT4DZbgGbLCsRo1JutJosy18F3SEFu9OUKrjCLjn6w?=
 =?us-ascii?Q?/Gq8uEM1SML7QccusF6guEoJX+DdO7sQ2Sej9DbHEaOmU/U3SAWuHMoC8ViP?=
 =?us-ascii?Q?6jaoJXdY1qTSoSATmTaRqqJL1jk8sK21SFOi4bwN2MPC18zMasS1qBsvHMOK?=
 =?us-ascii?Q?mjvhPxAgVl1X/k4z44j9SABHvByhsGJRX7mimHK0g/6r3P7c1Q6UjBk1DT52?=
 =?us-ascii?Q?EEevAqEDREPEP+9woGB+vD3Nyzc2W9Zs7ZlhzX03rcoUH2TcSmVBlQvYlA8d?=
 =?us-ascii?Q?zb36dFrVzdZ/w0pF820AwIObn0UhmqJe6k4HVBvlA1pNeYlKC7cDH+Z78D9m?=
 =?us-ascii?Q?LUaMLkr15qcJ9pq6K7v0rBkKffFGILfCCgqdVguVIBfzJkhODx+8zL6dtV6+?=
 =?us-ascii?Q?84ndzBJacUULrFXuZIwyWW+kiJNUMhn12rswd6ZbhXCEhr5xexlr2ZhQVOIh?=
 =?us-ascii?Q?f6gXaeFgJp8x1N2+WjJMPsSq7W3VeEBTPzuTRfZwsFIgM58Jpx9A52CGgcZF?=
 =?us-ascii?Q?zlUnB/LAeeLVsWnx/yAusF+WFUOb8fOGRXgBM0SwVZXlvXDrnnXTWjZvvc2g?=
 =?us-ascii?Q?l5sHt3HhR7VBtqK8KgtUjW9uQy9ZxDLeDtRgkxSsSQl0p9SR7gYqKVl4kzRs?=
 =?us-ascii?Q?8NV5QQAeA3Ex/6b3Gz5ILjjbxKxZVbCeeqq1pufbPEikF5P8lDw+fWY/gtL0?=
 =?us-ascii?Q?huf40MTXF2X9w0Psv4yROYorZCG9JpU0fPgAx7miy8fFOnInO6L/UTpxiDRM?=
 =?us-ascii?Q?95sH3A5mJ9WchK87YgrwNxCNscDwAABdFMjoRwWVxwmsFfgeJuPDHu3GPmYz?=
 =?us-ascii?Q?fWqc6RQx9snexis+d6WAWnb/al3LXvV+cPDwhkQaf/FaU90LxSFOrGl3sxOr?=
 =?us-ascii?Q?g8uOo3TtlD360G2G7OQ+V+RmzmCCPDlsrzBsvBiFtURhIF1u2C6f19S5PH5k?=
 =?us-ascii?Q?K3D7f6Z2SR9OsGGgOmksWDibKF2P2BHs5E+SsqQz1rG7MbceVoLzUdBtSv70?=
 =?us-ascii?Q?DwP+PP7uiJPD6GLUqds+W5n1cXYsShjslhh9WWPNWjO1HNqx58fUEOqzVQLt?=
 =?us-ascii?Q?2V4puH67ksllRrL2uzI48bW/6/H1pVaskWlVw5YZUxi4qzc6j1Z5pA5SMl8N?=
 =?us-ascii?Q?Fk98UEYSH+cW32NwQeTVwJrPgbJ4d3Ok8r2JiwPnRVSdPLdX9RgOUcrAsj73?=
 =?us-ascii?Q?WJbRUf42Gqr8jr++Res84BKTykkMC+YBbMca7l9AzeJlZ40gFuiC2FvaPQ11?=
 =?us-ascii?Q?k1qT4r+xYTGQOwhK1mAmfme2ihjSVfMXVOb6Sm2VhBO/h35Rc+glIl6ph9f1?=
 =?us-ascii?Q?tIRBoP8fN1/EcOGGC6zbtHU3BoEVLOWg7fPBrV1S04pkzueK9NMbWS1qjGqd?=
 =?us-ascii?Q?Y7gJD0cbj8+z3xPlWMHOUq+IwgQLIZcAqjI5gvkMn1ww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xhNECYr8XrUSqezHg08zxjD1BJqbDZeGs5mKsF6QGPSO6+33kaFp0Hup4lpM?=
 =?us-ascii?Q?pJhEwQdGMngGNkEHX66kjLqQermMKemYOFqScj/AjbP1E/wnrucjhGwCKXQo?=
 =?us-ascii?Q?HSeL+zZMLm3fqmKAFgQGgkYZR09+cMRQzXZMOljD3xIpS0Xxt6nV5s79Y2Fy?=
 =?us-ascii?Q?57ZyezCms+LYmtxNfpplQdzsSawtL5vAIncIhN/hmF8ekEoFkcxbncgv7+Al?=
 =?us-ascii?Q?1AavCBK1+2svhK7lwFoog4J3bAX6LBNdwbtmTTcpo2ByhnGCU3R2koYA9SQw?=
 =?us-ascii?Q?4eTq5GuSfcUVPZbZIjjFFiNSed8A78BSwT3YP4ORy2PqQuzxY97TGd8q1h1R?=
 =?us-ascii?Q?YAoE3HXO3DQw8lURFyZFzmnG8I9qK+Z+iRXnYkZtUDavaJ907TDwuVfp4WHt?=
 =?us-ascii?Q?RqfWVmWhJF2FbJzbRiUAxm4M3P9XRpC2naVBrWrEyfaomRmdHIKXuu/TxK4O?=
 =?us-ascii?Q?sslVlbag4CqXrdWITiilQrWY8D6k+pYONLah+AgO6Fv5IxN9PWxg8zsurTNg?=
 =?us-ascii?Q?yiEbYY8jrw5WaZnKJtP94ZN5rdDVmqwY6Rx451vh9QKaAMb6iWD4clEKc+CF?=
 =?us-ascii?Q?BJXkcL3lNApO9HsmgymfiqA09c4kD1dM+1Fte2OuGpQOnyNUH+RHgudkUXvT?=
 =?us-ascii?Q?L9baTHsVTeyNqd9sTCg30CZ03FHjEjHS7ri0fgOlttC5fP5x2jo32KZQKvQz?=
 =?us-ascii?Q?lliUl3tygmSKjsqV08fFtTw/k+QXWuBb44tTjPaVpQHq9yy6/Wz94kFlUocQ?=
 =?us-ascii?Q?VLGXT9SAsZvqeiGhGF81SEwWUe76+EFTP6jE2JBRMGkAOQp4aFK4N3QXDuxV?=
 =?us-ascii?Q?XT+1YXVzk7FpBAER9qMP374UzncURUwepe9DjelpoNn6cIN0RJUv58wJzjl7?=
 =?us-ascii?Q?+FITgVu+Bzz96Z8aI83gMypR8SCapN+x/HCm85UivMRRmqoYP+7A3D9tv49F?=
 =?us-ascii?Q?0BfbotVEE8Yo64IoiY2pTABCh2CkFbVMFzlUyhW+uK4hEZTizQrQfHiX9/Wm?=
 =?us-ascii?Q?appr6h03YIP/cOSk0P+0BNfTwYXaQ2g09ZmavKLNY54D9iqy7mj/YDRb0nI2?=
 =?us-ascii?Q?IMssKHG18760ciLKfAxOqnQUzWj2if56F9s9EPv/cdeEFhD7nCEaKZjgQuN7?=
 =?us-ascii?Q?79OX8lYnfS/fFdpfYBWtN2rnvXmLinbHYzqiEms3nMv9vzyZuDANgSJoBLBy?=
 =?us-ascii?Q?87NeSxSHYm8jJsLP6Mef+mJnaR6DF1HZzkLLp3OLlIPwbEnomh7sQmV1RKnh?=
 =?us-ascii?Q?NLsOkzAhG2KTH9UYXC9Omhbx8UaWf4Yw8cJnvmTzVdr78CiYsVDT6oRvc4jj?=
 =?us-ascii?Q?+53oCT2VljXIaMg0/4dLUaceAvXJ36mEyR3lu331QY136cP0KpZLP800BTtA?=
 =?us-ascii?Q?n/oHtxQ+BIV8Z4KMEG+RiV+SXCnpIn5C3P6abC6REPq2KarWTDZQx/hkCXTx?=
 =?us-ascii?Q?QEbi0sIgYR92qv1sNgp0RnQw+MBdcJnqi3/dn3fCDzmnyrcgiFh3LmblW+wn?=
 =?us-ascii?Q?IiujXZ8T7ehclESUrzqT6U3acy0FwQdpRO/kPV9L2KLEOEhbzbejeNMWFmLW?=
 =?us-ascii?Q?yUgr1xP+zf3UGmWd4YKjm9v/Bf2S33mnckB9O4MZLnyUjDisvjcYNBDOhdkH?=
 =?us-ascii?Q?fwx5FB6zsDKBx3isUSZ+VUYpL+O/JrR0BDKKLKjy5A8aJTmMxyn+/4pSBFSV?=
 =?us-ascii?Q?/DxoBk50ySMMbApGj7kdS5EX5pJxsA4VX7+r0kFdj55JCcYUdHttWvej9lMo?=
 =?us-ascii?Q?Y7UiKtK4wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f227acb2-9e74-4c5c-bf40-08de5f22302d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:57.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciiSSWdbLNuWEY+kJfsAcMPHjbn+nvtTmPvMl5vJ18EJHOl4kD/aMzj3vYegxGXJ998C3YS/kSwPc2//53zAhQ==
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
	TAGGED_FROM(0.00)[bounces-254730-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F810AF057
X-Rspamd-Action: no action

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f460a490c49e..bbea6252b43c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -467,13 +467,13 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 
 static int
 fec_enet_create_page_pool(struct fec_enet_private *fep,
-			  struct fec_enet_priv_rx_q *rxq, int size)
+			  struct fec_enet_priv_rx_q *rxq)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
 		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.pool_size = size,
+		.pool_size = rxq->bd.ring_size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
@@ -3553,7 +3553,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 
-	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
+	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
 		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
 		return err;
-- 
2.34.1


