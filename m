Return-Path: <netdev+bounces-252602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC/TDbLbcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9E6F93C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1842301FA97
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F71376BFF;
	Fri, 23 Jan 2026 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RlQExZau"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169EA364E8D;
	Fri, 23 Jan 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134972; cv=fail; b=DBE9Q+JNyOutVBdW8E9bNOiPRhyjiXIKOn5Y/T7oK2oQK/RjYf+yJ8cO98nfCCPHfvbI52bxUvMONBipmJXIHDqnlput40+YknUbTr2C0EOnB2eKkksEon3rsTKP749eMUqpLB0OmAQ6EpRZky4QLb/vh99TuQHZvMdFyzOI1/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134972; c=relaxed/simple;
	bh=hrOXuo72j3c6ITj6huu2FimsWjiiEBCzUo+9DyENXR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5OeE5M/aRxqwIVOnrETxkJtM+mnVyoFkxF26aJmGP+Hb0I7m2NFUEDj2M/FO20iVlXw6eP35MD4w8DA34PMLdMSS19zpYIWqYIStA87nVDXgJ+ydflPsOfnDh8jr7QY/4KUq9/FoyfI86E73TXxJ5tjkECgdZTniKB0SGEY1Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RlQExZau; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR0O3TOiGw2VmOtGdqenGF0P4KxOJCdVc+KQEPwkRh7wuCVW9NLhKsjftJtA4QRtgJsoZUA/SqwFsf7PlDCQR72OrP1RnibkSyNvbi+MCtPTSbvE934hLsayWFBO7R6kz+P9aCK4mJsaJfHwFML6w5VnHcgdx/ZWwQbVdlLKqau1ny3nOesxsh/bP7I8ROND5BA7bPI3fEA3wMJz7qpxAIpyY8R/L2NpbTwNXf52OOOjLANXHlerFORoC6QWGE/HW7fpMpdGymlt3aTi0+BvHjlcrEvdYH4pao8cDhQkaHoN0B8UOOP+nLO9T2titofA+9HXCo8zXFQ9oU4mH1fWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=qiEA7HIG8HuuQ4Yn/b0trj179i83e1s3VuqYQ1I6o9txuRJAFdckKRLi1G4pJj7suwz6oS/BegXfbJoWsFPENtdALan2VGmV2+31+Nj5k4GxZ4HXLtodDLHOuPOucYizdL+l+J3WrzqlU0GVhq0p5jt0PLq10Y6hAV+vHir5mWsYWoK4v1FFiA/IkLyXVmuFJjHaLv90fqeUTsdIjlXetpc2cVlU8e+Ya7afapIdcPvRQr6xWwELoDaevpw0BPqsnPUdBOMx01VOoM4anNI26WXtjR+/tCVoena8JGYY4lPoGeO5S5i7nb+pguMad8TgaP7Bni3HDNDjf7HwAsrvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=RlQExZauoj2HOQu1Hzl+Kku/Ho8Q5g/kIH6q0OsGwwKAWHUfjAgM+wAB+9b/1rqIatDXpx4boDcgU43SDmiWCT0RXIgRCpZ9KSk4o9nWIY5LY3h39ICZWUE5txddKTVoWFbGJKIfyoqxo1q01PKBCuHrwaqO1H7imM1E+2838CeVdJUj2X82zY1ZYZgEl6ukTom1SfAv1LekLu43lSJrLHSwNfMvfidG2jpABG/YVpCC2kjMMOSBsF2hntBAXfMVQVJ3sDdpruAB8awFZ3xttvDRcmP0+HCpyTHkHFhZngfRiZh4zgoRCpyhq0/qmpRlRQ5SpNUc/kx3G8cv6zU5Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:17 +0000
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
Subject: [PATCH v4 net-next 03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Fri, 23 Jan 2026 10:21:31 +0800
Message-Id: <20260123022143.4121797-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f93e093-fc31-427f-a0ec-08de5a263a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kMthG1vB0GwJvI0cjEmeU9+pyjdHEXY8rCpzEcQAzmpeueirHxf7EAPut4Hg?=
 =?us-ascii?Q?0S5OGb+UmFf2JbBNjv8oe7h16t135fYFMyYXAArpllErpb++oTxMDK8X3kR4?=
 =?us-ascii?Q?o7oR2KQnjEx3RZIPLjV9mrz7hugiD1UcGAd6zJPFs+8E//mR0gP/1Hu2BPlJ?=
 =?us-ascii?Q?m8Wvg5kVr/OESi7Tz5QLfcQSua3Tf9PhqTSjwQ26sQCmlB9jqBl5DE4LSkbw?=
 =?us-ascii?Q?VSOZWOxIynDVVjDAkyDGMFgD0K86rSMyxwQtX3uUX7gkm8FKyc/boxHsSBjX?=
 =?us-ascii?Q?y82WdO5r1JFsgD2s6WT1Pa/T0zpMMN4FpCHPjjS+ZmRkkkeLuWR7cPCxSwWR?=
 =?us-ascii?Q?4pkjIoskKZX98XXKw3SUg+9fOzM0Ejgk0uANjjWKkng5mZX++TT2/MiFdaoK?=
 =?us-ascii?Q?kBvrEys9OcGRDsOOAG/RgSvARE9SP+wU+bG5d6AhQrsUj1C459uR7xOLxpqp?=
 =?us-ascii?Q?BsFFCh4AEa7KsLYBgQLS/t5nt2ZDR4NCfvRkvr9nduclP9rI5GAUtbuaAyHy?=
 =?us-ascii?Q?6032YbxhA+16G+I211FIyqIiSAzDnBTe9feTEaErwQyWSNhRJsduh8spZM/p?=
 =?us-ascii?Q?4qDSWEydxKkekVn/1UDZOurY/LZ4sUWzf/nUI18PG88Fxa/+RJSpGzgNwAM2?=
 =?us-ascii?Q?o8oXxjVQr+24InFKefqN13/jgoFZhYRZlSeVJdkvtGpdaCKChJ7KWsmAQ3Oz?=
 =?us-ascii?Q?Y3yDevOoSkoYiLlFfDbFTWrwv0P9jRV7n/iqRdDagLIdI62/6/tHYZPzNRjM?=
 =?us-ascii?Q?i26ZcgcZEbd6k6pkyAyo6IGGp6hEAk1545PLy6NlD7dERczitQ834/rCBONi?=
 =?us-ascii?Q?sJDlu++PVph24zVVb57w+lVHKfIcHSxrVBePdtS3GWIUMpx+pSMPaWHeo1Oj?=
 =?us-ascii?Q?9HYQijwNwVp4QnVAHMUl8ejr8h7YhwUlUOaVP5aR2PadPXlGmjipIYcbNRx5?=
 =?us-ascii?Q?NSpFchcE/P0gldnXRFnqj4ecSNfZLusxV+1QcQiqI6p+A6fl+Fr+EDbDZJBO?=
 =?us-ascii?Q?DxmCHoaqOy70rHfKmEKfC96xu3Dy2GDWfWH1JRLS3XMOeskZo30aREd1px1O?=
 =?us-ascii?Q?kJYdoZ5q913uLYWNAu+UWuU8l3Vz2F2dxwYjKfgdSrBbxDBujD4iWT8JuNW3?=
 =?us-ascii?Q?iGcAmCf4hxKSvDay0xxDrs6W4rAdHdbe0jR7VYq9nvMmnXAZP1tVGugoievk?=
 =?us-ascii?Q?lYspDMzGZNUpYBrX/L5cRIvnUimOpJ+vJSaB+ybC2FqkX2e8YpUyBu8Im08p?=
 =?us-ascii?Q?+h1O5s2vFyInufCXonmEebAYUSgSOHa3R42MdU6TrV0sCgMPiNpEkLbJOnME?=
 =?us-ascii?Q?Gj3QgqHzAZtTn7Bm1jP0VGRXG5bgk5AdUl06zYTav+eKxv3BsOCJtgCaYcc6?=
 =?us-ascii?Q?SqJm/QeWnrTsSOTRTQ1DOiSv55rgX57NjCbzPReQX7RNlFX4yhke9ZyDmRqb?=
 =?us-ascii?Q?2ebrGH297qbW303Mq3kqdAXiftLe0q1i4F+MJkHInJKaMA3Oa3AE7UK2Szo2?=
 =?us-ascii?Q?w65AX68do6JtElwqR5Tm6+QN4dy1JR7FgSc3NX7f8jF7bNBuQjwCwNt4SQgL?=
 =?us-ascii?Q?34i+zQcYnRxqxirkMWHUSLl7z/TEPEel2ZNbj/EUQ8hxwW56DTdanPZIlokj?=
 =?us-ascii?Q?5n4BN/ZPhbyM5jzJqVLAkF06PHBsKsiJiYiC9tDSyhOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UF637dnjrOoOyBHVpPaEw9ReAqsbM8CJztldwYYWMcuyGyvhoSILd/i1tqGN?=
 =?us-ascii?Q?SQfoNhER8a+V+g1xOn/pxWbmgPS4nqhJ88qKyD8YmbC8ogcmc91j6lV3o8+L?=
 =?us-ascii?Q?URZIdjvcxRIggXzgKFH643DM736PpLovlzJGViyPKMXtN9T+KfXDNgJVI56+?=
 =?us-ascii?Q?Jq4aABQmgSiECuTEieEqlV04XzY3Vb7dpZCResY/cXUQRYbhqe191R2ESbv3?=
 =?us-ascii?Q?rXx0ZNF538xbQL9WDLU1s8y7du+4o2VkTGTFpR+hGncUkkMbIL9nF02uqpk3?=
 =?us-ascii?Q?HwUGTLlMrJrZA8RtIIfxN72Xm46lFuBY7W8MCNsc9VXF6QNXUJZ4a5I/IYBJ?=
 =?us-ascii?Q?+d23wwAQ7xyul/9z3UxxR4ZRoISQtvrEPwOvgo+0/JbhUJXi/6ITmQpTGtm/?=
 =?us-ascii?Q?LYHNnOZJFKA0fCTd7PF8YVlqdaB8TWVHSXK+BcfXhFcQtftZizPz/EfqAieF?=
 =?us-ascii?Q?WYUd/D/3wow7462Jic+IHvXm+FMfRlfE/HF2h/5QOpAno6pxfHP3k2JKin8D?=
 =?us-ascii?Q?ezevJRI+rYT+y7MdVZBfsjF0EF2SPNfV34yuRc6fMbmNQGT0jK/4GPMoIy/w?=
 =?us-ascii?Q?U0HRd+S32Qj+Zzv1ug9d3pInEWqoLHquRexFqiyMxmx7ffZZE/t5KeUai3GH?=
 =?us-ascii?Q?8EO2kSj2V1aJw3kJRuJbTlN/7BZrQAe83chh9JHgGY3TWt6z3U0L6M9QysuY?=
 =?us-ascii?Q?KR6vt0Lqjx3GXu0MIkvVwc2SFBlU3VOAbFIHhN5I82tZ9RHDQ2JnWdZTotzE?=
 =?us-ascii?Q?lYT/ENPgq74AX7nHHP37Jm854fbwG3Pb9k20qlDO0YrZaQzeZv8ZpcjnO7bf?=
 =?us-ascii?Q?pVnapqV1x9N/b5nBpyQjhOL0hB0n4Lgi5wvR2+ulYG74WQ7BsX/15bhu+3Tv?=
 =?us-ascii?Q?Q3WZfHk2UwCcUDu0C9f3FFpk2bRWSa0ChU7Nmmmz4vdSeqotGnia8bJHFTjf?=
 =?us-ascii?Q?ed0F/f5+5QRTabXZAnLDxi2KkEvuQH/NT8g2MEGzwRVBC1CjjOEIpuIwncPU?=
 =?us-ascii?Q?8VkXpWz5jXul8fJHexDtuehJmjioyMcesiF7tIuIV7o8uCxd1UooHYRw2v8S?=
 =?us-ascii?Q?yUwdsqxU/KPu6vemWUce5+DUhFxzmb1CcB5LhuMkjJSVULTgvQqMcEIUjloH?=
 =?us-ascii?Q?EXYVnMpCJOduPnFTNW6gGLq+zH5lboHuNsAOWoewbG77GOWjrkMTaNFs1p0i?=
 =?us-ascii?Q?XmryF+JDMrs/g0QbjgkEcfyndM7R7sv5J1kO32lORqxSopgS3B7O4bJhpxj9?=
 =?us-ascii?Q?nOQDjoWuML64xrYDHirHVQeUyEA7QMx+T6i796OBbMg5t4eEpVdbh5F8ns5G?=
 =?us-ascii?Q?/i+1jm/hKCXD3Z7rHFSi330Cuo5aOQu4+SpvMjrwWtS0hARFR8y6lUOvL643?=
 =?us-ascii?Q?ise4QmdBan2P7oxFdR0+RAfUpiPNALvrmz5Dip1t7pFLI0zO0F/9GiF1bDWC?=
 =?us-ascii?Q?RA3mkoEinuOIiA/UaIXuznHLaQc7Fql72EZ9KQTqPu1mlrbDqxAGjvibNjaS?=
 =?us-ascii?Q?GXAqxcRxGIMDmxHsYj7QTkpA3xqFtVWdJD9XtjwEQlqS/L54NHFC4lhkVHSM?=
 =?us-ascii?Q?Y0+JawZm23zBkW2efffXsiwCf8u/8xFGclzL88/X0tY6gk/5pUNE+Crbo+gn?=
 =?us-ascii?Q?DfFG3K31HQ7Yle4i3kh4LghJ4zXwFg68+mB2VjnysC0moGSptD3ZtC5p6Mzi?=
 =?us-ascii?Q?2JJBZmEX1LYTq2JbAAflmQFIFPTawRj8BctAnYWlqBuFsJb7nrcDKg+sc1EL?=
 =?us-ascii?Q?i2uf3VUpMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f93e093-fc31-427f-a0ec-08de5a263a70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:17.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB8XUPl2l5p5UnVPyFKHvLd1zIgeY/zTRkNn4YPAvLcJhTvI2GCFKHIxMqK3FRUr3str6S+IzoLtwDvYY1zp9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252602-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: DEC9E6F93C
X-Rspamd-Action: no action

The FEC of some platforms supports RX FIFO shift-16, it means the actual
frame data starts at bit 16 of the first word read from RX FIFO aligning
the Ethernet payload on a 32-bit boundary. The MAC writes two additional
bytes in front of each frame received into the RX FIFO. Currently, the
fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
code less concise, so rx_shift is added to represent the number of extra
bytes padded in front of the RX frame. Furthermore, when adding separate
RX handling functions for XDP copy mode and zero copy mode in the future,
it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
corresponding variables.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index fd9a93d02f8e..ad7aba1a8536 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -643,6 +643,7 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
+	unsigned int rx_shift;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0fa78ca9bc04..68410cb3ef0a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1799,22 +1799,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
-	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	__fec32 cbd_bufaddr;
-	u32 sub_len = 4;
-
-	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
-	 * FEC_RACC_SHIFT16 is set by default in the probe function.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		data_start += 2;
-		sub_len += 2;
-	}
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1847,9 +1839,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
-		ndev->stats.rx_bytes += pkt_len;
-		if (fep->quirks & FEC_QUIRK_HAS_RACC)
-			ndev->stats.rx_bytes -= 2;
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
@@ -4602,6 +4592,11 @@ fec_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
+	if (fep->quirks & FEC_QUIRK_HAS_RACC)
+		fep->rx_shift = 2;
+	else
+		fep->rx_shift = 0;
+
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
-- 
2.34.1


