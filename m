Return-Path: <netdev+bounces-252603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMIkEqjbcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA946F92E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D882300DCD7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0F3815D3;
	Fri, 23 Jan 2026 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mzCu33cE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF636346AC1;
	Fri, 23 Jan 2026 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134980; cv=fail; b=brliPZAJqf3vGSRBH5tJmAgmDgFx+zaezC1MRrQO9Q/6W8OMLP72zThs8x199im/o5Azj6BUaoGV3kVCAaaZFsHTJhDMIkM7W0VOV+PYiYIhD9ppuXy5uFPHMtGt6a3TqsniCZj7tnHLi0tdMSpU526A/V3WZ13NUD4k28XxmUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134980; c=relaxed/simple;
	bh=PKnRTuy2nCS0OcVjBuU9b4aY9YxdjxJ7X54semzTMG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EM3I4P/3AbTK5thYIhzJR5caW5MmeIR+EkJhvl7WWsks4sTpP58UJbbBrDgKUTGLsln4E81y3xGSmb819DGviiuEEmIl5r7fe1Ug4ctrmPyAW8enqHWPn6IeCMi9k2IALo1/G3GZse/Gmp8qhycvSCQfTH2q7S9569kJDVgwPMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mzCu33cE; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJpD8MhnaJL828clGO1mtTc5eERwKoEMTWXCLBaI3mD+zzJJFgxys+FvTn888DnYJ8MhpE1eHi2K0gUSW1o+xTPpzjd/meJPOB+GapxyZX5YoqnuckP9cmHsIDpCt+OdK3PAuJajmnsKe+R9fA3rJuGgYTHq5DLfrS1J9TlFKnt+SAA4WJeUJmeUMAjP9H+J4APgcKPAHecalzOYlL8+JLRqOdvLMTXvKztgnGgZ9xApRkDtefCoMfTFWuajU+PXYhW+wkqPCOELcgthwWrUbNJaoNMClHmCPDD+10pX/W8SC1w9os0IHGp6ZKjG0l3sBSOiGM/EJTym1o4kiaQpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbHEHZYT8gvspdSmk5ZMSEj0QwUFHSSXLoZMqEr9J/g=;
 b=B29IH2U0CcJMt3uZkWPaq5eFtDj6meJmvYjafvkugVvTR0guR4JnReYSIkByxXP3t19tQ9+RNB9zKzk1bL3Vz6UbHGSQC9V/Y4fOltCK/pbq8d7/I+WYHFSRUhZrmc1s0T3Jdnnabrmh6kQobiUo7naYyd/7LVV3BEGnlDEnupHRCQDfHrBqsKI7pD4cbsRww5RL7GOqop6VymJ7p4WApCrHTfmWvqcr+d+YPytNWdjfRi1XYCTXp5Wi8b9k1fcTI8FXeM7wPTGW3mBkiw1KWWRKtnnVfsnm4NpRmniT9mqrdTLCU1/FlvQk02qXu1zIFtQ+HOwvZ0R4H3COSgZ1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbHEHZYT8gvspdSmk5ZMSEj0QwUFHSSXLoZMqEr9J/g=;
 b=mzCu33cEug8nhGTBYExycDGj+/nGLVaCNb4AKyfcHnh+kkz0MUxLNGDYEegY+e9OkwUptCexxi7GHMZlKRNz4QEF+K7IAyOFlTICtZ+pSMRsLy8CEUCBrS4b5XY81uyPJ3wfnIveiuG3auYus1l/eQih47W/vOGWPKGNBWi8HNE6eaF2nyWrvNFWQ+6njx2Nv4rJd07IcMTZ8EgkmaUqjpzIxcaR6TF6odpiArho+W7gD06zkq9LK750oxpg2VN4wa0t6KOzD5UjgNlj3wM2QNQIurWiVlq/bAeiz4uXnJ8ahXmCLqXZh0f2fwmVI6m449WwwVbixQ6ZpNg+BCBv5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:26 +0000
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
Subject: [PATCH v4 net-next 05/15] net: fec: improve fec_enet_rx_queue()
Date: Fri, 23 Jan 2026 10:21:33 +0800
Message-Id: <20260123022143.4121797-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 399b6033-54e9-467d-382e-08de5a263ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3htbuLQ5GgK/x/xjal3GVksumz41Bj1rcqcP+JrGHGTW/7ZLClhDI91fIFEN?=
 =?us-ascii?Q?QVmrn7gQug4u17mVTXHOMjDcONmjcLDtbUITEfk6S76Dtb8OsK4coMzIr8Es?=
 =?us-ascii?Q?xuLRSX92ta9t1PSaZalwuMVQqso/hajeOaoVu5xz3jg9AadrR8w6eH2PvsXH?=
 =?us-ascii?Q?ab34tO6cszC0ciTccjgwCoPbXxuX6h0DV+rOI+78+npAQvqNdIaGVy360xbE?=
 =?us-ascii?Q?WcJk17FmT9bRdX0h32bfa1r2Y3nHLySkp1SFqLJw38J7cafZyOZNrJZllHfW?=
 =?us-ascii?Q?RqCxEmQUMNBh/Ze6h0O9bc+Bl+qf4onFphVd/S2TpnweDaCVgqW25fvXV7TO?=
 =?us-ascii?Q?1VLN3h+BigaDJOzzuc9Ev3RWdRmi1H1F9A6LfGbTM8uUpzrb/uX6quBJNvRH?=
 =?us-ascii?Q?i5EgCvO9P3Auen7dMyrle6zdYlspcjtpHlj9Vs4Q7IsD1iCw1d6H0BcidBvo?=
 =?us-ascii?Q?xYdA6pwT5ohPS/wU5jcWwVI5UpON9Z6bNRgOXKX/ZyvRdq++spUWQUgOkE3G?=
 =?us-ascii?Q?XyBPz5kEcX0iDJPr1qLmcTJovRLLUoGeJdHBwyIcYAvpixujZ3cKyMh4LmpR?=
 =?us-ascii?Q?u40QfFk4BaxDYGXcVZGnWZ4jAz7eR4e2qT873140mp2AEf0wLpScLmnMOPq/?=
 =?us-ascii?Q?Tu6O6jGDuAQCNKBt+ocQA11SBPyAUVK0RG+ahPaz4Qds/Nu3/H3E7JuoUwM9?=
 =?us-ascii?Q?17JCbz8Qai2Gwji9XXl8Y+p1Hktm8iYfEHfnBQb4h2BGoTNUJGkbNDhtTDBG?=
 =?us-ascii?Q?rbfpN5JAePfmIfDfGAThDj0v/lXMsWgVw5yy6JJM/UEfjFLnLAd+E4tBwnv4?=
 =?us-ascii?Q?aAjd5+R2Zv0On5HEASxxAf/SepT/y+JC9JyCj3EIQM0vSnud43RBu6qNQtMI?=
 =?us-ascii?Q?wfIjJiL5gZt6Dtcd2kKc/456Fh+4GNsYEcqGtVMgmRlvQ1CaKgWkqvtZVtii?=
 =?us-ascii?Q?vDTX9thnYpm2oVAdKDffLMl2sLcsNCc3zgHmi9ba0CHadxEf8gbRT4mAO2CD?=
 =?us-ascii?Q?5DaNRQyYHRoywOuRdXixV33Fo6S7YfFIjXSXJ34ff7imM8D+wQ5QOoGrdfFo?=
 =?us-ascii?Q?yEhuISwanQu9s1h328RoyN4wy1Ud+UO0JAIglKVc8gvFBmPK1ByuYGuXEgfM?=
 =?us-ascii?Q?GhZZbFnGihtLl9ULpYkm+4JrxiNc356opDob1ZvXQzUqAD5MLtWJf8pEBHFQ?=
 =?us-ascii?Q?2Y/EljRGN5sVB4IIICBjBAT0Oj1hg+wd98aWiAKszJ1xYMH0HW8o4CIeouhY?=
 =?us-ascii?Q?rIjya2Jr9yx7bM1xw20aYbscS0vjA2ALdG2l5iPGhC4xgrbKTquE4izkGfE0?=
 =?us-ascii?Q?5SuWD8NHtAZ1zdJFulR0Ngu4RPbke1AwHylKEi3RURg81sxLvm8rLlQyMjj6?=
 =?us-ascii?Q?8N7akmX2p90/Upw4tXbJZZg78ZfFBZKQbVX3onwgGMw4CMlEkmuj1qj++6ax?=
 =?us-ascii?Q?AVbqEYwpoqKtvXFfK3/GGg71wiOQmvAjWrJ39kPBy2j2TPqGJF50ag4sVBlg?=
 =?us-ascii?Q?naDX50GHit2aIh46fUIviNJQlSYCKyyVpOJd3exIjTfa6wa3vn2qVtgsI5nt?=
 =?us-ascii?Q?UBDFsXZA737KQBlUzZwLAX6qJ81LgKfB2YKJf6Y7ISX+nQty/IRIqCdSQBk0?=
 =?us-ascii?Q?EAujSyMWGbvKXTRvpdmKLkE7OrzGDA8giiAxDlOJRdJZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tD13dp7Re5XddJ3MjKX4hB9OnmpsNokU5y5rUmNcG0yxxboOrcSmKTMdb4K?=
 =?us-ascii?Q?qetsYMaGjMvxd7mCajUV38JtPK6gVTINIkaQJeTmt64OnUzO6z1A2HnrREqi?=
 =?us-ascii?Q?UkGggrsdylJmhm0kC6/fHCfMVL9gFZbyv3YvtKhDDZC/OovdZIQZJSuhRmcR?=
 =?us-ascii?Q?++BDG/CFOH4cBsopzr/EjJG973E/lYeZcoGbL2sUCJSsWXNQD/1MALn+XN6B?=
 =?us-ascii?Q?BadCh7UOHtVlIaaqhjH4kktWFxzDWFrmtrkPcTrwVdzyC5bj8Xvcq+Wkbcnh?=
 =?us-ascii?Q?FtJ3DkgOZuWjW0E3ELGmEohVa7W+g0no9c2OJAgSDMF571Bken5VEi21k6nI?=
 =?us-ascii?Q?UoovGhQ3GHiZh5rd3F0HEJ55ki+vAWDDzJX0hQX7IgmpDK9ay+OS+YIP+07e?=
 =?us-ascii?Q?30HLTAZSrgHK0on0+qwSW4FCSuTK15FnLjAgmJskPT0SGUBntrRpEsmxyPM/?=
 =?us-ascii?Q?1s8/E4PvBSRr/z7DNVes7tYvbnMjq9a/qzGR/9Ak1m/2E2xq/5eSmcRned3d?=
 =?us-ascii?Q?k1oHvs0afmBOpM/+QLlDtC8LFizkz4zFeQmB+ua8aJ2AQVSQlzsfvEMH6e0j?=
 =?us-ascii?Q?1Bt0i/Np0kqApsW3z7u5XHM7HyVhig5v/uudhz71ER8slKMfTiyfMwPAKJ+f?=
 =?us-ascii?Q?33Ql8n5Uh9ozSbEXWIqtOHKNR4h923+X8HXrK0EoXghXw6Uts2zgN4QEovZT?=
 =?us-ascii?Q?aTRqITwdmMxpxN1nkjiIfuaikwbL/rFTuqOqSrTfs8CiN03ntcXPzVIM65x4?=
 =?us-ascii?Q?REGj9b4bYoQB9LkA7mBn2cDwYqJ92amTIYOyFup9D2qNtIFdrG4FFohZLAME?=
 =?us-ascii?Q?p5GkJWaGMB0Buynd512ezMK+Fs5p65LrsHzRpsdCFiy6n0Kv+sE/ZuLkd67g?=
 =?us-ascii?Q?vNJK0QovGbu6lffF6zo4fI2e+yMMPaIuBzOTGpMRP3nmjaIbEbqFel3Wu/w5?=
 =?us-ascii?Q?Lk2f2licIHUwvlsyoDux9g5jf8TGU+JE3SDYotp/jE549EkieAY4SELtFosa?=
 =?us-ascii?Q?A+swJVCYphdhJmSTsJVabDIepmiR4UAQphNQ8AYYgaQ0YbMzaUCN5H7P1fJK?=
 =?us-ascii?Q?1qvxv6LKjZTU4upYoofDQ4OnCkO3c7ilP/yzDIoiQXAkDcZq3gqZ443P5M1z?=
 =?us-ascii?Q?BcfxL3LJzg+0LpZItiW4Czn/uoKRxu2bwLkt/8DHrqDvAVUEmwG0/SbDn7Ck?=
 =?us-ascii?Q?HxBmHRrzZ7qUOjzlceCoeCP1o8EMq+PM86u3yETXIJfFqQNmSXDygvdH6EFA?=
 =?us-ascii?Q?J3mRsHM+6Pua1A3Ik+91yk/3bBFjKXqVZXiQAt1cq/KRUpObvqZLCcIwlZEy?=
 =?us-ascii?Q?of/TEO1HDrYEsMPSXodW6x3jRfNMZZTQQp3rSf24m/ntMyeaFFC1QK02/8BG?=
 =?us-ascii?Q?SFOl1x91wAj7e/y3bCT85Xgfr6GxkEhGRnwoLWk1ApGVu157jXEa0TBGEW1z?=
 =?us-ascii?Q?9dhB+7hDHS2JRZl17q7Rteho2wxq2t13+GmQByiFXJUKnYaC3Q87ClLww4Qh?=
 =?us-ascii?Q?GZcSe86k7yx8N6jSgnXgWC2Tw78kTEQspzJVQk7ddDpk8P1UcmHvvAI9wXUR?=
 =?us-ascii?Q?CYSoZXmNpG/I5k87iZ+zz21IiF5knqvBYF1rJ9EMAO5YZwH9ZSE/Y7IGxjDe?=
 =?us-ascii?Q?iuRbnI+9SAJDZnqVg/8wtggxmnQa+vGVKKD0Tup8x/rraRCskPR3yMU1TVlH?=
 =?us-ascii?Q?WgejPMK3wTXcQpThKe6YMNILeQOjeEGTZtuP6uH+QLMUy9Q4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b6033-54e9-467d-382e-08de5a263ff5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:26.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aTqaMbZ0gUwMqaJ713keyLuS2B1Rax+nwrwsFBLqsb7DG9OigewGcGBIWUrEa0+7EW4G3gNDIak1BAFi+whDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252603-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFA946F92E
X-Rspamd-Action: no action

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7e8ac9d2a5ff..0529dc91c981 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1839,26 +1839,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1867,12 +1866,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1881,7 +1878,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1895,15 +1892,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1979,7 +1974,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1


