Return-Path: <netdev+bounces-257064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJByN+ldhGnS2gMAu9opvQ
	(envelope-from <netdev+bounces-257064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB3F04EE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679F530ACAE4
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F33A63FB;
	Thu,  5 Feb 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kanaiy+P"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E623A4F5F;
	Thu,  5 Feb 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281834; cv=fail; b=VqeRt6l4CYa2TzcB3Bci6XdlX36zsyXUXfsTgIF+zzgPK3pHm+WZ0X6PDqqfI72GXsHZjYXz8tQzDLvIF8ikFvmBEgZaLXqermag7Ilbw0yyW4K3nicP7hdLJAWNNEf1axBatJdw8n8iZIidcca4wF/47NbhbFt2dNbZpKFDKZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281834; c=relaxed/simple;
	bh=xIna95dN3YpziErj9V1rdArJr+lnV1D9GVDDXQRQAgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uh1TTXDeDn7UKzLmtWDln/qhXcyjlQpHdlwc+9ph7wVM/UCvnnNmMAyW91hionyT6afTUbSXfWyU45XDcJ0QCevvzCso/eCgCKaTKfGvIC/Q6ySaRZv90ZgWbQ/qRnz8HGtu9OI98SqkXkjA1ELLRL6FTBV93eug6bqUqSTSme0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kanaiy+P; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhvFoHatGv3D+RzhTyy57rZCBlGQBQliA+pkFwzQKf1dlECUlB7jYTx0Bg7F4VdzxmjfKJKeN1BCOpNfckLL0PPaf7fB9UIuYj5PKqd1TAB/lbu/ZRa16c9CPlltEUFaa+Kat6XmivkOe04PplhYBFQ498YQlUfHYPmyRP2uf4zn7Scv03qPG+1ETvW1zAszEetGDHGUujywgth9kRDl3QM2AKMQr7bzNwXePm6KHOwG+tWE4bIislCS+rix3JfI64tpsOyVEfRXD937yFIsKnyuowAe+l4yD9i3eb+AjFgrHQTYcTUboQyuBYFN8UNrjrvwEKqq+NbjXQyneMXPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Piyv1STeOXR6is7QdYAE6bjpNh6lkDGT+2fPOcfTk=;
 b=ORxXKYGruXYSXj3ztf5wJRAtN6GewocV4CmcN18trxKzKtUnGzbBxLwWmQCA+YJDR0MgPRVt/DZX1DGalX1Vz0xvdyV3bMy4RY3TjHOerXRco8ogsUpF0uFxhr4gt378a5hSvjCLYFLfYUx43TvP0uPKjkM82C9yj/8evjymhs5w9r5p7TgHg7AOpQHK9+ZpG1xJP+ZADibMYZn7j4CJa8nDjKgW38+nrNOQbvUmcAI5/RU4/UD0etvgsdFrm+lcDIdtJizyuMQ7GR69pGu7QM+z+tEzky92Fwmp1KAhNXDVsbBGTJ24vNztwbT6QKDVo7H9tretBcffKOAkr3Pg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4Piyv1STeOXR6is7QdYAE6bjpNh6lkDGT+2fPOcfTk=;
 b=kanaiy+PJi3FKRHOxxzs9cKar2OTCugSKz7SknyfFvDPNx/rViqbmB5kxDze+OGjgQzBwFxb/SFdPM5lPkQmOUlhCgjKO7y8RWwj613n6tf3CvBZo5QpjJTmVojUYAO2igeCPXbMwfgMfQslpyUGSQJTvn/6ltv3m6cO501LrX8GeA0qxF2Mi0XwfvTjFOD5TxfqSetobGum8zv0ABt9CMZC0x3GoWKP5BGLbUgg+7shLKcnnyQ7YpoKxDBs0fjLI1WkoXpYsyVhm1iXyGPxoRFk2kD0P9K0j6X/UCt4uHO7i5kXmxa+L7LOtfnNyflZsl4Au871B8FeYHfWlMYr7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:10 +0000
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
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Thu,  5 Feb 2026 16:57:38 +0800
Message-Id: <20260205085742.2685134-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: fffbdad8-c641-4ccf-7e7e-08de64948c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54Pd1VFpSbqu9LSFQx5ye38u7RFCnyzjiGs0S6r3kWqK4h7RDEwSQACJzDk5?=
 =?us-ascii?Q?+ZjlB/OP4ftgy2UlTuOTnllF3p75j1A4LHVfo1CATItF3YqP1wTrsicROMfA?=
 =?us-ascii?Q?JOzeHUh7FTvRiFch0QXtuXDr+r4IHmacWpYzUmpzkgzepsmEzIdEwk83EWoY?=
 =?us-ascii?Q?Y8P5LBrLwBNX17pxiy6598jZdatFD2/4+9ZPfcoROidy3kaVyhrWULOI4JrC?=
 =?us-ascii?Q?swyEwoHtMnRdJkAuAX+yDEcn7TPr7Kk1iiDDpRHJkPqkp99l1OI/g+//OO+o?=
 =?us-ascii?Q?BO2Y1nIfiIabbzEGWflCmq2jU4K21ciPBlP3kj361eENhjWHJaw/B5KgIcEA?=
 =?us-ascii?Q?N8pE12RzGZETkQI3LdV9IcnctABE2gSL8MpzAUX/CZjg3XqQWXrlOVrEM1kW?=
 =?us-ascii?Q?Ibk3uazuFAkv/xkPzEoxAr/XtSEHKudGJE8GcJytCfUbNayAA2rW3SQVwj8O?=
 =?us-ascii?Q?wR7LIbF3PIMerQCFT3HHO30vAHHnHWOOBrRzJNXfR62SNIeMgHTxT6i5ByKj?=
 =?us-ascii?Q?QAJZpoaiSTaOIzwSIHACjTWC5CazfeHWgczxYhK5ZagMYtIdXp5D6fSgU/jJ?=
 =?us-ascii?Q?Gk9bkqFB/7xGSrf//vDsKQURpxtl2rI0b2iZjExwebFaylDlVmdaZjOPa/kI?=
 =?us-ascii?Q?Fzmh3T6m0LIYXsvdATdk5WVMb0nBCUbWpQlD061Gl/NyAVVluQcc13EvgrZ0?=
 =?us-ascii?Q?cNnB4+36h5BnJy0/tfODc5FF3n5dYk71fHLqD11kysMsZLcnYCq7Y3XYBo85?=
 =?us-ascii?Q?kPWGnNPQ4sernbX9TdWem3FHkCmytzfORkG0GuvX72W+/qa00nBXtgu47NZg?=
 =?us-ascii?Q?DFbKxkWb8U8LBa+QGWiihENyz4Fw9O+ato83YZEoDfUGSp/A9CTw6+25ui2h?=
 =?us-ascii?Q?+p3m3YzAX2ks2XIEnLe4V54lJmredlEwkjrtDqfMaTrqTbYs00sRALVaSgep?=
 =?us-ascii?Q?F5F1zx8KxqOWtDKQFPmqT9G1kDMDECL2bxpLthXV7r96jFg+CYMrPMrR8Wla?=
 =?us-ascii?Q?q/+OtrAn/wIjnsoN/45s/varxCvbLH+Un40IgvuVoI3ggA6ZU9H1XgwRkgBa?=
 =?us-ascii?Q?xq+MgW26xvSuqUy5v5hCZLhP+lN0h8M+d5+umxZnq2AXr9/1UJJEW92H5Ii1?=
 =?us-ascii?Q?ZvrjLmyLdrx4WCVKlC6Ggm9594y1s5Z4IaXL5vGvLW3V8h27aiI6IngReCP6?=
 =?us-ascii?Q?0YRfeUK0W6JSOnOfaBdMRuO3yiF5t2duFY3t1aaR7utxuVNIrrKIx4QcgGZh?=
 =?us-ascii?Q?1v/sxqWvgkToOC0R3BjwZxaHn3XtZSH6Mql+7K3LpfUtWTrU7AY0eCRurLOG?=
 =?us-ascii?Q?NYRB3tHbRwcNOklnn3jSWlaXdzvIlyT5ek0RbETJ9uBb9GnIAjlXpUgToyvu?=
 =?us-ascii?Q?tbm6Keyg0iTWHztmghQCCmoMdnaZ/M6/N+UlZGZ8e6gMuzy45kVzsv3dff0K?=
 =?us-ascii?Q?HgdgDSbsw5EYpUM+uxDgWlOCYObcpgQsaPQcz+c1pRbLo/zku9z8t6IVBnKP?=
 =?us-ascii?Q?5BisVODZz71C0HLMxhui+vIFD5vx4mwPnNLeLBmKw2AMipf1m2nIrrzmRAyk?=
 =?us-ascii?Q?YCtpGW7PiQrzRDVjUasqCUD1QKZuIMqG8e70F6nstjE/eobx7pOxG7KkGRTm?=
 =?us-ascii?Q?WOtKf0w0AiCMpkxfI++2rhucZUz+sJb+kAsdZyIanluq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZILeNCvkKT6u0gLoFFQ/7oqkkEbRw/gxeDmdofryRHZ9ZsyOKRu8G73BMOpZ?=
 =?us-ascii?Q?0g70GjyrPN6cIX9gH52YeYMOzKD30XnT5n4qdB4sVs0YwUxpEefEW7ST/6Zl?=
 =?us-ascii?Q?OCQgjxzK2pyS2x8D2+n3xYcBXG8cjCR1T0CyzpEF8glHv2KvlNGXriBeD0ba?=
 =?us-ascii?Q?gQeuzhODNlxF6uubdem8DYhGO8dxCQPV8qI1DM9HeX6b6xHDnmyOkw54/lVD?=
 =?us-ascii?Q?gR8HWCC/KmIX10vHScbigo48CB1xUG0qlO76YFd90f+W9UtbYJEJA83qqpe9?=
 =?us-ascii?Q?bDIhmbUOZubS7brVepMB03jX3BzVnGJ5AOKKkq3x+JKRFsrAJExH2uU+rdBJ?=
 =?us-ascii?Q?vyv/F1/uzeTToz6uUTiMtaHo9Dd+/60Tvju/uN3QXyTPuo6GgSuexxhZXFke?=
 =?us-ascii?Q?7Dh+KID4sknsDjCEFvSaHD7hX5pszuOf5G2WeUIo3IiTkdDwLzsJwc/9o8tW?=
 =?us-ascii?Q?RrH0P6Ap6ySHMg2pygv3FA3ASIvI82lv4iM09sO8j2IbOqY9Y7Eee5LSM1fF?=
 =?us-ascii?Q?034IlBTPS8q7bCk/RBh3nxiodPRDfH1DKl6lGYkQqmzF/CVS2Q80CYYCoq4D?=
 =?us-ascii?Q?g+aDNqhPXHNFtGKO7J/SMyMhP+RWtrIgcGTEwAAbR4k6iHJYcK95b62iVSgy?=
 =?us-ascii?Q?oFIUgn6j4ExoDA8MXWICtMSxUlRHdMRYHgGV9/uSxi2YE/OQOusFG31GlNfU?=
 =?us-ascii?Q?UJNaXnZlV2kF1MiUW3tnXefzWftZS33RBxQe2jmNMzLY+z0UPaVlmodst+R0?=
 =?us-ascii?Q?ItZ9sIJW+QhK9JF/ZU2TZNx86e/MUhwhbfDHEgLFRovzWTNNvcqSCFtO34QZ?=
 =?us-ascii?Q?UEmvIuF9Nr6ZgMge1uDynZDBFx1SCRrcOPkN3CzDLC+C8a+WJuNLSk0vycWG?=
 =?us-ascii?Q?HB8nl48+C5Dg3DjQ3iEE90mdRHfgELAC2DKqUe+Pl7olLH/7yvE1LHF8Uq/w?=
 =?us-ascii?Q?1vNi+aMTQ6hDjDVRiEEpXF0L1ldz4ZJmKMkSQVa0naO8Ap1WdRiNnyWdpIlG?=
 =?us-ascii?Q?5xXdHSN+TFdMMK/2CewepX4xiOSr8f37QpqecOJ8Ic2hrqVCPjeDwty0DY7o?=
 =?us-ascii?Q?tQsaMuu9S9ZQHJG+ll0h8LcqgYhfV5NEdrb3ehGHJ+x+Egp3w58mW+q0Kkyj?=
 =?us-ascii?Q?yuxY1LeheVVLpg1oU8EBrIQueMeaBC9E5F1+2yRo7zjr5CnTCZjIsgndSmWu?=
 =?us-ascii?Q?RBQ6S9wTMzt768NIPIEaqNA1v6olQsueA8JVcVhyDc5xWzxaJUOPw6VyewQd?=
 =?us-ascii?Q?ZAkRcEerh77lTLoG/BlueKyXMJHMhTCwuZDeYxw4KsyhK2F8c0mCy4VoHXYz?=
 =?us-ascii?Q?BERUCzsNzYoQglcJdYYDJMQuFMV+eT579qtotxW22oBHJCwKJpr7a742ZdiF?=
 =?us-ascii?Q?PaiJ0OqPFCkw8JNUXFD1FB/kFrdelwLnRbu+MlyoGbXxT3FYI+eF1mpeci8F?=
 =?us-ascii?Q?Mn017vujHa5OMDBDfvC9ctNgY/econaUB3JKS91AGfkh/KbjCQXD+Xus3hpF?=
 =?us-ascii?Q?Ihi87eneB/v9NW5elz/6pmN3cWEsUGvcbL7UYUyj9inrDs4pVjQXdRVmkISa?=
 =?us-ascii?Q?xZVSHMzq5b/xPGDplOMA8QNEHEVIPEs2JLJ1/bduOg0kOGD9ySN9poJeMLEM?=
 =?us-ascii?Q?fbEQywbbWPRSBZPrEQb0rTd9QdkfF4UXTW/TA8gIgZEs1WFhhhuvERenvG0I?=
 =?us-ascii?Q?NvV4qlOVPdz1GKEPB7olSP24hh52NNZKyyLlVqHbApOrGJUiDx7Pgvz3wIJw?=
 =?us-ascii?Q?33vE5GkhQQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffbdad8-c641-4ccf-7e7e-08de64948c69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:10.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAHFSddZj6tlDquDESFhSfvrQoJUQCnVd82WIF72IzBvm4Aj19sI3F+cH1oVB9kIcRwN7taNOpgkS+uVjjS05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257064-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 62DB3F04EE
X-Rspamd-Action: no action

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 80fcac0f342f..d7a92ff25cfe 100644
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


