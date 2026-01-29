Return-Path: <netdev+bounces-254728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DpEHsM7e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:51:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62AAF296
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B9F302D5D3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39DF385517;
	Thu, 29 Jan 2026 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B82POM4o"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DB38945D;
	Thu, 29 Jan 2026 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682953; cv=fail; b=WLHUQB+qovAd+7yzB8JDAOstdKa1N8iT1O+X94fL2rarWltNfslEU4cHI/87yGFD+jO1lF60TF4spfeZPgqL5SVhN+y2sdqz2UZzwMm/ULTpfMxekKfOqrAorweLf2OT4ktWJnt9FAoiwRAI673bFCOhJUlVe9Xa6a7we10SwDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682953; c=relaxed/simple;
	bh=HTCzm6oPl25I2b5Be5EmzJ0mzzOka8JvCcMolakwwjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO2tb6ZoBPPgWoY7G0Lw9HI6CTZ9Fi4CAVGyk03W2mOWkdBq46utgz0tfd+kOhi5GW/8QeWLPz3q1R1aKMWt08QjfoPBhLogdEgEmwUu7fW0YpFIaSDLo0risF7f+zJ8I0zFks1tzoxbuO1th+3HD6HQFlpeZrAz2bE2+aVxvbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B82POM4o; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhEHKCvFNmkN62d3nLr2Bxe2Lflf9k/HdZWsAHeRIaAKfBswrc3wyNfENI7cOSlj56Go0C6HkdPNPN9MAAvlYBpIBwJDc3/fk+SgQLPtSXHCz6yfI2aFMa++CdVB5sVKc3gQiRAFuunl2oajlb9MS7mpzw9lBGJlOaMG95IsosY1MTjESAZVXejbz6Emvm6CZbb4mdSMqI78wfglIh6EVS6urHTjLjtBTm6Nuc6AATObLjxvglW+A6VHFPZYyQnlGcr2apsOnBaVutMPO1icwyfll96krtRTvU0joUPTrQRJXH9ULf5bCbLuMQ3y8/B8/oKpx5/mw09JKmyEAZRCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xaAQ4VbkAFc9L0DQUluGNCwO8mNfu9RrdEyPX9RDqg=;
 b=c9FkqTBx4F+ySmgYiwYCC6WSK28j0QBWppJbvZ2VwUpbIvPtVwHNukOPgDCRqLkTl03BCSUeWIwI/DMtRrNoW8Og0DffgAO3vTmF5rPxyUShHbWcUFImGUFe75BIc6dSy3x8cAbNad1iRj3gWAiwTiurhfdnomUPf4tzxmRswvikz3XjbZcdBtIL/5vO+KJ/rvslhcsf76RTV6xCNQuANYkqZaT6HJ7KmoN0iaEJUZ/P+aCa7CKqiE22z1bnQsTyphq4xy3AmUN6q55Nhx7Xq25eMIPBtTarfwTvnJYZF+U4O4TL7lK9eLak0zydsPwtGa01cfm6N8UgL0f4hvaMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xaAQ4VbkAFc9L0DQUluGNCwO8mNfu9RrdEyPX9RDqg=;
 b=B82POM4o/tD0xl4tlW9IXEU/DTW04x/1EvScTJT0z9/Dxq0CieYb6HFeh0hpHtvI5RuJ6YbRktIdWAQEwLBUPapaEgNpWs1tfIrHI5J71qKE9+mC/4NfqvatPg1/g4Zvax2zcnYWcUbxVo2k1J2GrM4wGbSRdi1qHh7Knox+EGNi9o3fFl51yAEDB5gDNVZ4R9tTTXBATgG8URPqR+1y8jvJ6cq1X0fTxKL4QIc3h7fEclmxdSCohHkH9Zu33eF6+yfiudLmVuXo68M7TH3ChVLdB73KMd+GC7n6rp2XtlBUS9bwUNK/rqOxyc1MGIXitbyXnVslNCOxKAlgwr5zZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:48 +0000
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
Subject: [PATCH v5 net-next 09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Thu, 29 Jan 2026 18:34:41 +0800
Message-Id: <20260129103447.1893129-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51ec646f-9623-45f2-3c36-08de5f222a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayjaxqw0HDQ83UoEuXtLbfTi4vrb2Q5aXxZzOglhCp7BIqMTzL/EE+azynio?=
 =?us-ascii?Q?BV2j0m3YbaoVnmgCnpHM3Y8gQg1UpfiRCrc1lvF8wnn6Sb4SXuzqSv2fc4J0?=
 =?us-ascii?Q?RkArHAKPXdmPWhUfUbARp53qv4rWhUULfEDaDJVbhIhOO7Ao7UdKuvi8KsnU?=
 =?us-ascii?Q?AXNN+B3G1IMLuPu38YMhrXEXfFweBXHhTycqhNSzckTvmuvp7GNyrD9J43mQ?=
 =?us-ascii?Q?7fWPBj9wg2yRg1KtD9xH4526BD+IwLeh/m+i2FBxHYjv0DhEQoNY6RGFs9ob?=
 =?us-ascii?Q?t8UljY7XGPK8rA3c27UrEmdKvyqQCfTK/DuG6CPseLJgKd86r0UuUSth4vq+?=
 =?us-ascii?Q?sKx9Ez5vqOWoQTfbCC1Aii/GQsfklZjnEk8u6tctWtEETIsRtrWUxfXBmVR9?=
 =?us-ascii?Q?DHmjaasJeRKvbscenM+P6ktAmvXmbGBPu8CvqoUaHIY0obSZ6ydfZBpAYMzz?=
 =?us-ascii?Q?WX0ft2X+lXmq89MLD8vPTmt79DeGNaCV0pK6f7HLvjUVmKx/DgBWKJ2O9mac?=
 =?us-ascii?Q?yeV0teAnWmPLXAHUnx2h+3kDdgPSmwJ6YdotRJHtaJ/UK7vfLma6MGoXHkso?=
 =?us-ascii?Q?uGETi3hi0lw+MFVaPMUHgmmSRWGoWTAum8q4LSLuzUBJhaRIRQDQfE7qjN/F?=
 =?us-ascii?Q?NSxDkeYm2KGruBBO+mN3GzD7ueOJf71kljMLtRWEKPSEnCqxxV3V7Ux3vx7K?=
 =?us-ascii?Q?43c/Caf49Dx+EIzZkIOUPVdi8Sfsmz30yjb6FC/NRdNtqI2czwRxbh08kjjs?=
 =?us-ascii?Q?JO1jjkp6vSCN/ZVu/jYfLsYq4YyOA5uOWzNVdzT4s2OaNoNRlxWFZAT6FWgP?=
 =?us-ascii?Q?0Qcp51O8PyyABH1qHk5H5mkobKHf+Jkti4tpUGGpIBHoC1tQQ26Dk8g+tWN4?=
 =?us-ascii?Q?9kAXqecIbgkSninbBnD+TZg/UgrSceoZz1gsZmEOLwives2Q2sYKdl69zkNL?=
 =?us-ascii?Q?g66+eXWThNkrjv8X7ZRAO5AE9Xj9/lS+YcmijPyI7Rng0ZWp/FSXq0DyZEuV?=
 =?us-ascii?Q?w5WYR/x3hY61q+ecsZb1E9Tq2YErBXgs/7R3cP66RA2kIEnC0OpefRcHW1Ng?=
 =?us-ascii?Q?FCmpzuAERlK84FDp1TIRDy3GCnLUSNDahxd4Bvg+/tHDVAa90LhPKjT++CFA?=
 =?us-ascii?Q?XDHlXPvwoI04DMBRNTE6BaRFClX9E5lAVkBi9PZrN+/0gCG30+CN7hrUmSXo?=
 =?us-ascii?Q?Ds2W3NPCpeH0WdD+369XtwkLpxkDaYTPAq8nxSNDBjTbuBqPb9f0uOrL6shd?=
 =?us-ascii?Q?Qe56kanivVrHrajsVHW5uAAOfgrUzns1IkFlIkRq7ZHXSTDOaXCIaLrCxaP7?=
 =?us-ascii?Q?3FvtUaUg2Cqi2xBOC+BksWR9BbHoQBYR9aPsvR1lCt0Ty8dYdukD4BmLK29K?=
 =?us-ascii?Q?Eix8VqX0gbFQA0Mt0v9iB17GJuofxvIikVWNRaVz9U7PIc9DUDwe1tJNwQja?=
 =?us-ascii?Q?uN3rIIQZynxBZknsRNAXveVeoaR/ngNcCO0uPaLMViOal+bQdh4/1C+j+JNP?=
 =?us-ascii?Q?QvMaIwQQwLRfJd+Jr9YEVI/NQdZYYkSeF0jc8c3dUxQQ3Qn+iOwaKc2nfU6V?=
 =?us-ascii?Q?KobXq2NvwmY+lw993qLAueFx0vv61pAwgdTfdLu9JPqXB360PF+c0F6JLH0p?=
 =?us-ascii?Q?p1itMEQr84w5KSUBsLKNVOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?midglViKRduW+OMbsxbHgGPLj7/TRxMYpGSFTXDFkpl0NRt6cpjula5RL+qy?=
 =?us-ascii?Q?dDTRbxoftZ2H1WKFYPvV6X5G1CEuBwXirYwSyvDGGb7aPopvuqs2eaKHqiJX?=
 =?us-ascii?Q?caTAgYYiYlILb/pPsHAdGRXUtkB3qTOwBPDu6aQ1xiVG5iO+ZLe+YiisIKs6?=
 =?us-ascii?Q?WK4MX1z/VkqZfWuAIzqRPjIqf+zLh8IMG7D4XqIRWhuFFrrDWr99cxlNjMWp?=
 =?us-ascii?Q?rWzZoqMk+fhLKPhp0gRQwTXlD+PkPFe7YmCDLa24TsIPdKu4zGnsbUQsfV4V?=
 =?us-ascii?Q?rFYodCHdQuj1z6SjkrAhNQNHx5SaHPB0KG+3Q/m0yQB56Ar++EB2FCWcfmU6?=
 =?us-ascii?Q?UfFq1/ly2k6XwVd7z5YPyuvYV1GQQQt82xJ+PdirjbReCs/q4Ck9T3N05hSy?=
 =?us-ascii?Q?qiG6ZFGYYJcvCdBIaqyAcGUTV2pD8CAWWdca6khQNVdAKgeJg6vihm+kXYml?=
 =?us-ascii?Q?ZRRKdxCf7tjSsRyyUmZzlvyCst275zRZIF1OuIYWF6avlqTlu1gTlAG8eLPB?=
 =?us-ascii?Q?UiWXwjZGqtWq4fHS/0e5Q0cB9ttfmICg1VACReqvDxhjZ7ejrycMY1ZtdocB?=
 =?us-ascii?Q?L29pOgc8PtIV9XnqVWV8h91qTy2OFeRalCNmjljxzOzSkYncjg1HzKWkIv81?=
 =?us-ascii?Q?ijM1rxDBBfMyZMmLQeFZTNpj2D9zvoIRY/XMB8cidqG6VVD93PUBC3R1pdJo?=
 =?us-ascii?Q?YnG4jiirBwKC/cK4kQRJs5/H8bjEiAVNulDowivZSNnFGOOjFjrfbRIS5bm5?=
 =?us-ascii?Q?GWmkcLcZ22bb0YIkXAX1mW562ugLgEYn2FbDiiy1T4bu8h/Af8GsNa1Ob0mq?=
 =?us-ascii?Q?310tfszaEcJKcDCz1qXuZ1munGB/TWIwmB6Ab/81cG/dXGS6UwJ/de51pPMT?=
 =?us-ascii?Q?y/6aDvjRLZk+72jUERlTk4WLg9T1/95v57ETvwSkmpFw0UI+NbBTzPnP0bp7?=
 =?us-ascii?Q?r1QYi3BASJp12r1aEHCChUF2am9ZBrwQl1DMXIHA3rh9vq5PZXvozoXNJNQd?=
 =?us-ascii?Q?FzO1TEWD6xQuTeAbbwsmhW88Qn249u6zs+psRm76yaj3JQ9Lio4kZBibRAM1?=
 =?us-ascii?Q?ThwyLWUzBXxCMKqIMFbdkQ1GjXGx+uhGFtUq6K8SzBUoVLMvq99tlC5gcS+K?=
 =?us-ascii?Q?gxZpfjwzsT3fEnBXoWBtSC6jrhtx+/ql4GZvzTyE+paevcAs/xYzj+EvEG8W?=
 =?us-ascii?Q?DQLrmtC4aMP3p6sgCp2zqi4ZMKDEEeF6Ho7TS9QsnrZFWKMYrM0/ACI1IQ6q?=
 =?us-ascii?Q?mMO9rNP0xtsaQwCQ+JwTIrn1b/umguXieSZsFym6LqepzW7vmky0f7uXyHQV?=
 =?us-ascii?Q?rXMM9/wgmuJSFHCIjIqkr30b1MR84uxjJKj0FBm/7Kt6A5rRdYXDoHPonTfP?=
 =?us-ascii?Q?ABvvAZ9n/6ODDQO/5IY+x4Zf6u20UantXizGMRGJAWYnP7mBKNnvtWNOoGom?=
 =?us-ascii?Q?dBoqF+78NN7NeuON3r7U6BHAEa/HHG032j+sBakv6Fm6HVCWpsyQ/n129p7r?=
 =?us-ascii?Q?2g/wD1tJHRNFUYN4fWmO8rYVdneJ4Dw9pQRTb6FWC8XbgjEyuLqzyhYobF/6?=
 =?us-ascii?Q?XLn9CYg64ogd/likHJvh+NpyNCPonqvT5l+AbJ+AXPH8L5/Ai/dYEsQOM5aj?=
 =?us-ascii?Q?FqO2PruqQqu9IkM2yfeVtvgeJ2kmSsk3JAvoSBrpQmlcqiINiYIPn5gM3+Vo?=
 =?us-ascii?Q?7YXb3S4Xe5gqbOFEri1q0K+Jco+nHAMBKEj/dO8DdB/hSPtvSK9BzN37oLaq?=
 =?us-ascii?Q?wzoMFIDmDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ec646f-9623-45f2-3c36-08de5f222a25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:48.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsqIWqHs/9GGOJZflQj/kdGWXGg12mBjF1Eq0BFo/wza6ynglq5dm9x12qaw2aJ+3NWpCWWb5vS2r77PSUW9WA==
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
	TAGGED_FROM(0.00)[bounces-254728-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: CB62AAF296
X-Rspamd-Action: no action

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2e822acc9782..4ed0dede7d81 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1538,21 +1533,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1


