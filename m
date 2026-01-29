Return-Path: <netdev+bounces-254732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL3OKmA6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DEAF07E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF42313D514
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF538A70E;
	Thu, 29 Jan 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dt12PRj3"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87F38A708;
	Thu, 29 Jan 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682972; cv=fail; b=IhKCDtuiDmmTdUiqmw69tFF6DEPJaIglVOkodeJecOMnPpMFhs70qDFXLYTgnEYOtI0cse5WZrUpaoFGnuGUgE7xGDEgx9rFx9abkDegfJEEQu+N5wWSjS9W0AG+Vqo3gQx++gccIiZDdSjdsXRgVsbnC69Z43VFAzA84c/DqBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682972; c=relaxed/simple;
	bh=gOp3uNEt4/IeV07PRLjghKx+UiN1uc0wo2NsfXXa+DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eczq0eWVdhN6WIWc6JsOxUlexaxALvRxC2BYZZO2Tpvq7eXfscINgrL4WPS9szkPH/LE7IrpDNuSESQVY6Z5q0dXk3P8UbGM4Us3qF+l9GUaI1GiKtRBkdkgePlofBpySDRhIVZnDSbGN7kiklErP7bjIwuyADUM2StHum8xOSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dt12PRj3; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1pY9uwvjQL1pLpLEB4BsCRxW2MqE4j6hyjWBSJh32aYKuo/NrtugTsHJyTlp9EOntc8TuRWx3Wy76OtF84Pd/kFM7+0xpmq6Do4NZNWgU4nK5ihL70eNZwPLuU6yZTAHEZoWxpDERc/ax35xECtsTPybr4b2lNUi1txCvTjv4rTjx/SRdI3TOkK2MUOuMJVaTpka34dQZ6UrQo4MeWkEsZLAYScZfhdxs/AVNdylgqghkIv9dvXiR5JHQ8tBZuBAm89O/3MQP9qc9MWlGRFfPvsUQ513HmJOdXOZXlF5rs8KoFv2xJOKqJUQtPrM1bzsftV68Xde86V1UnzpFvfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSdyzWveOlSvOQ9ZcLs4VZGzVCTd/i7ICp5vI9OAIAY=;
 b=ABBCwf295q6ueNVzi9la2SQiorv22ONPfaDzPy62gute89GgKfMaYb1k8JmYDeXqy4qF3iKR0YI0/cydVt3ihTuIz2i0rnQXGio4QaFanKdxTECBhFGewAsU69NQszf7u4Tor1m5gV1PiMC5FWxcHhIVP/odS8yvT0tM1fF/8dMdAGL7dznoBCxDocQtpe/9Huinf8Jod9c9zhaQi7oQtDmBewipL6pFnu0nKJTo3J/idOEkA2lQI/04QB5I2S4creWpgy5kL+yu/3kXkyrM5mMfyRE+WteBTfxZKbuj6UtwsEs3jNYsC4VYrUysGZTxpLK1LDIGpT3pzU+h8XWkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSdyzWveOlSvOQ9ZcLs4VZGzVCTd/i7ICp5vI9OAIAY=;
 b=Dt12PRj3epNaQvhQZbxVAIhVIc2ayDvKF1XGgKZYZ98/bjDtWziSY19MVkgjQlNZU6a27vcsvDiofovdz17uJF54Km3jBNYJdAPu/AvfolUPozm6l18X5LBo1SMD0MGg4hFky0yTpUyq+/9fcO4NnKAfU7DK1jIL6jaLbgc7m8woIcJIVpXoGUz7UUAkcbwfdEgXpslWG1ZgAXRafoftyn+cWlqMz74CojeA4uVkxNFLddXuz0DvuaYyejMoZqTOEUNVQkECeUas0YppAWk/wUmXkYGuYsu3Fc+cUCd95gxEPPdbXeTquUPwnofSMON65qKxrhtTdKIxzC+cY3kkGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:36:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:36:07 +0000
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
Subject: [PATCH v5 net-next 13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Thu, 29 Jan 2026 18:34:45 +0800
Message-Id: <20260129103447.1893129-14-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 049f573e-446a-41ae-7777-08de5f2235f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuAOu1KKPSMlwx6vpTpRDWR6zvxTlDWxk6/syM985B7JFh5fGVC8z/qjVUcM?=
 =?us-ascii?Q?HQlmoxTkW0TRUGnKN4NT2KAUoHHeXGKhya6dWzkrQcwDE4jS8q6Gl8MA/I10?=
 =?us-ascii?Q?YTI6EZIWx7shF1lVKoouBJs+GcECQQBwQ+F0gt6odwcGLYhRmZ3clq4NLXMy?=
 =?us-ascii?Q?CnwSQTaEHIavK0kSkKoOkcQ/e3pYesstLmhjPMpdg1VZovCxwD5rfD7O2Tu6?=
 =?us-ascii?Q?E9egpvkVTtXqhUgTfmZYay+2OSGldw+BMmG2ZVk3MgiHZkTwoBZAH55NjcgC?=
 =?us-ascii?Q?kiOVtdpHGLWAZzY+N1+O72WS1c5hh57NE0H1CCzbPhYsFpHb+MNTXNKLy8cc?=
 =?us-ascii?Q?jz+U1CKMrfImmoGXm0MOEf5hzrHlgXOQack0lqvYTldkLzMWH0hTFNqISiED?=
 =?us-ascii?Q?TrqpPhJPgsSCBCkWNt+fPgI1KsSH07Z8Gtsjvr8wzTtPDT1rQy7ASuBJT0X8?=
 =?us-ascii?Q?i45t+bABfmolNasGFwVbNgfJT/iwwBwcBebiSbcF8Vkqijmm+9JbPmrZhmg3?=
 =?us-ascii?Q?v8DmbobclA7K/z9pA4pfEUItiSFXwHZf3IOcSBQVFOf5nUkSUjw32aXl3tMz?=
 =?us-ascii?Q?w0LgV8PRS6wbLuEWTfcgOQjC7vOMdgQUnjz9D6b88rV/W8m89BbYk76YxRQF?=
 =?us-ascii?Q?PkqZOWeKpKE+nkC7ZbSKh5VJnR7aTtFuI/DOdZewhcvry1lQHsLWYIHO7RJJ?=
 =?us-ascii?Q?gq18b2qgyII5eYylviv72ZfgV4SibY+8JZ0x2ORl4mX3fAsymppFwpDf1vvz?=
 =?us-ascii?Q?g2aPsLR3G2TU1SJIqLAinRngQUaWQD+AvJpEjrFka4bqUF+RHVBpOzMuod4N?=
 =?us-ascii?Q?ZSxIHs0ncopy2PG3+z+CvZXeDU9oCBAIS6vicKzvCKJy3DujzA7wE1XXz80x?=
 =?us-ascii?Q?dwyzfCSQe5gM+XhGIXV7IySWYc3PJ73P6yEs4XwzGgfG3UnVnudxC7oIpANB?=
 =?us-ascii?Q?U3UydUgiVjYVEkXLU2hvAauPbr2GVnZ9B4WBcyUQNpJDMt0aZrAb/gp+Jd2z?=
 =?us-ascii?Q?ER4cXZpC7WagdNXtTMV3iNi4dOCKYF16AapZCtqBjBu7jVuC0xvwDBb+MCAO?=
 =?us-ascii?Q?XXReS8blLLZucX0VxCS5G3Z3U3YEwPq1Ds29/UOFSfsrnzkJ41UqGEZExsXg?=
 =?us-ascii?Q?V9G0tVBU5c0vTvqwCNvQX6Yb9Gh3GJ6QJMziGhsPIR1b1MvKN5cLDGaqMTrW?=
 =?us-ascii?Q?vYTvFJXdcsuW9seMZA+IX/fnCx7giQhLu5ky436Du2DOuH/wgcYdOGyKTbxe?=
 =?us-ascii?Q?MJ2LHexw0KXdbBPhGWwD5XmoPzlkxtVJ0l9VyB9oNj0VaWCoALLg6nEcfxxU?=
 =?us-ascii?Q?BbG5F6NxIujVXmpC3Ih56oJpWnWaH4eSS6LHE6q11SpQ8XgTveMO/gffu/MP?=
 =?us-ascii?Q?c150x+pXk9m+gRoYvWqTW0l/9fBYoj0zB+bu2pKCdgJ9YGjWgRk7fRhRg69m?=
 =?us-ascii?Q?IjlN18955TjaCPU9/JmsatpuVfi1lozduL/g8RDkTA/bRtFAFYsFmZopDSvU?=
 =?us-ascii?Q?7HXItzoqxT1ujp9O6i+Izk6GqzNJIf9lrJL5NNKzXS5gPCS1raQ1p1sOulWW?=
 =?us-ascii?Q?Lv9Klbq1PpvzWDZYQRn+fBDWb/vqli5IDWjNUTkONzu0JRiGlelxR9jNRt0H?=
 =?us-ascii?Q?NeKgAUz+hcURm9mLwh7EyfCx4Pef5Ql/Rt3wraIdVvkh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0sw2uezdkEPAzlRcumWZeXcugIB2tAd+pkQh6cIuQxs2wcgiszM5TVQi50G?=
 =?us-ascii?Q?hLtvcXqB/7GT7KMq2nbUCwwwZtquW90YS6qeOWaWRYGnc84WV+3LZfWQ/F3K?=
 =?us-ascii?Q?sBpwhtcQqoRyHuCk07E38x91+Z+jAjCenmTeAGdxPBLbMALTm3JbfeqK/A3Z?=
 =?us-ascii?Q?3Iyp6+92wl+HkEAUk79g9FHMWqPpXB2ZTHFRlpxu1cIOYDfFIg9xdrTrEuDU?=
 =?us-ascii?Q?7BOw/gS9FgXHyWiz00YqyxXLhA2mJK3RvKAHpInSnBOx1PvONTKTC38x5REa?=
 =?us-ascii?Q?7RU2rIemHoH1IA8sj3+kH1QT+zrfVjReWy5gZ3Ey4lbsk/rbex8PHrGGeyLl?=
 =?us-ascii?Q?QdYPRAQeafOmRI8yQbTGTgaDhxRPUYPHgySNQ2/Z1LN/rUZ5rF7ndvMvqATl?=
 =?us-ascii?Q?plYZgePXAzJDluS8EFPgG3Su+h0G+90SE1MCmASUbMW3kgxIe4f6aBlGq4Y8?=
 =?us-ascii?Q?vugWkSTUGgmYKeYubWweX7BsxpTMnRVkb+4wvA0x2JFMTqtk7V/+MpnGOThl?=
 =?us-ascii?Q?lDgjPXio+QxLrZsR97qTil/kPsoODUzIZVEuXodXz4F/StUZJ7GRaPrNm8cv?=
 =?us-ascii?Q?E1/RZ6a9iPR824uyEWYOtm0HSnDwZ1lTcpYmW9L20adw8OU87NDe92YQb10c?=
 =?us-ascii?Q?qbWWEvFhBd0JHtEWQJ6QJUgI6csUID+qG1cCIkHTJNxnZ+k3tOPZRH3ZWIaG?=
 =?us-ascii?Q?4LMUaq4sGuuZh38eDyVTUotrRCGUpp/9UFeg3IKs7mXms3UcpFOnQvMCZFYy?=
 =?us-ascii?Q?hq1xP09ATHBfTeeDpvoOeetms6QqFvLkqJN6FvmC9oVfQWhf+PUd9ZloMLb0?=
 =?us-ascii?Q?P/HmHHWJ8cKPFqSB1XkKAnYbeS7xAJryGrNXRQB5b4S3W2ESjI3rrBBsQEMF?=
 =?us-ascii?Q?wc+EFtOfXTRS/spqcKiv7PjMgJolR6JKoB/wbP7wrnWwi+35PFuRmeqDhn07?=
 =?us-ascii?Q?QH3ys1Mkcs4k3YXfkQ0T0R/rALzUTXHZk3X/hshDTeaeVTOLS0s8KLbT66HU?=
 =?us-ascii?Q?IfM5Idn/Yze652rzcqgeHsqtw3VBjSqhfxVFVl5LIIKRrXbLGknm0oocENxT?=
 =?us-ascii?Q?Busmx2DJ/ELc2Da7NcQYxOdc6LvAK4EBFilz6BrBAlxsyIPy16G57+TQp3Pm?=
 =?us-ascii?Q?HAnP182zycSNFZQ6ew+OrGvyZtsZcBJSMPQhAbkMRQ7ttAkErjd5EzyhZHxe?=
 =?us-ascii?Q?PUjoTeFL2O/uqIXeQ4jMVUQIjmWVOeqoOdk1EjlLFitZmiuWn5rivg4/C4Tl?=
 =?us-ascii?Q?WYReUpX9ddBVCXfLJj8Y5X7krBHdEhabfAaLvFhoDmRMZmyuMg4eNmbxwR2+?=
 =?us-ascii?Q?ncMOfRcuBF3LHh/nt08rfxZovZAKlyWAOa+6JVafIVQVlw3G1wwzffBjgPmF?=
 =?us-ascii?Q?T98r9BS/aSZk0LoKISlQ3pZb24H1H8br5XSkJsz6Um6jOZNuFJMnDYkThX9h?=
 =?us-ascii?Q?B8NYASnT20ZcUbf7g9R8c6ExYeLQmxW/uCGGtZ1pD/K9FXzLO72KqAdLDwEV?=
 =?us-ascii?Q?L2yNAOVoalRqiMLhYLEhiMYIS4TJxTbNstm2eIwRAOWDUOck8Lq/mGjD98V8?=
 =?us-ascii?Q?XS8cnm4lo/Y/lmLvo8A68bHtuNNWZuG0CsATHvFqCjrQzAZxxq0EIwxCjcTQ?=
 =?us-ascii?Q?MhUTgkzVdqLCJYh7Bhp1yuSqX1L2LDIaJH3CFbKjMV2rCGbJTAug+RcRmSuU?=
 =?us-ascii?Q?RXGw2Cm/VSAKoL/NMFGEbLroGCzsE4IejjsjguqtP4FRJCBU4aXiRuC7tlnx?=
 =?us-ascii?Q?OlLtaLZ0WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f573e-446a-41ae-7777-08de5f2235f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:36:07.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYrJSFtbIgaqw/d2XBeOEZScYz4zoIhK8MiI9N0/0BUlG9JKxZ+bF06cx9wBYchsG+Vp/MZfn69TP28kIUPfAg==
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
	TAGGED_FROM(0.00)[bounces-254732-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0A1DEAF07E
X-Rspamd-Action: no action

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode. In addition,
fec_alloc_rxq_buffers_pp() only initializes bdp->bufaddr and does not
initialize other fields of bdp, because these will be initialized in
fec_enet_bd_init().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 90 +++++++++++++++--------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 193af5e2666e..3b0c8a9b1587 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -990,6 +990,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 				bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 			else
 				bdp->cbd_sc = cpu_to_fec16(0);
+
+			if (fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			}
+
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 		}
 
@@ -3436,6 +3443,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3449,16 +3474,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3557,22 +3576,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3591,36 +3606,47 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-
 		rxq->rx_buf[i] = page;
-		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
-
-		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
-		}
-
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
 
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
+	if (err)
+		goto free_buffers;
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err)
-		goto err_alloc;
+		goto free_buffers;
 
 	return 0;
 
- err_alloc:
+free_buffers:
 	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+
+	return err;
 }
 
 static int
-- 
2.34.1


