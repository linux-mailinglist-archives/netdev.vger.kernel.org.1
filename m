Return-Path: <netdev+bounces-254733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNXhG4U6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:46:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 240CEAF0A9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBD0313338E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26838A731;
	Thu, 29 Jan 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZXtjU7TF"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E538A729;
	Thu, 29 Jan 2026 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682977; cv=fail; b=pF/A2uqmuQePhtrFM2vN7xVH2XaIphQxpptpRrKlVWXJO6V12FPx6mhDDLBuQ56r5CtwIZbE7PVvFYv9Su/YR6Tpnm0oLIwHIIaigIUJmhBhPB8GTqxz5iHRIplK+hGcyoHoUj4UNgdm+InwZ2WPUTxfvagtjgfSGoPieC++WJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682977; c=relaxed/simple;
	bh=bO4ECTdRYDzlItOxyk3b/3ZTxuXVuZwZ0klCSIDnNBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/4LAAwRxwIJk614453kQj6Iho0U/w3FwwFE326xxisxfMzSKTdFsXtnfp92xlTmjf2oEH9CZe0EhKuTnSv3Q+JX5NrX7fDMkyZgSR5s3fhFBhv50UrJ8hAkcVo12AZo/TsrRjembhuBbcJNhDajguzqaHnlR3cIb85hCd0GChI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZXtjU7TF; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR3ewKWg9UH6WPO9KdcnoAt+YRO6Gx7HtGsRLvtznRcDLiaLXa6C546R7HjqK2hEY2O3mLoLinSR3CjFtMpCY2kUvtxFDJYdYjegq6HJDSiHbNZBXi0UhqhOGIEh2TFpej9Cka42zJ8lbWiljwnuPCc6ARHqjSTn77ehzdBZIUP4G1Kqrm7YpgUHJstGjzLnicC0W2nyHMon9/SBslHU1MOI5wjnCoew86TiiFO8ZVGGYEsA7Qs47UvRCyFruSTswlVNFa2v4uN1jhtebcO1qXeRmTA4uFlCYPRc2pZmHqdHghHsu8suuQ2AEogs1tK+4t5KrbS6pn0K1kuyLEoF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfUjljulUsmMc1+nvcShcTcmd4ciC5MxB8rhZVL4gDc=;
 b=Pi8J/0LLEL0xuwMQmz7uM2V0b3NWAVddsYOBkimStBIez83r9dOyJO6Px1GSKtWpGBnqsTmtx0k+7J+4N/7lyzo6rOtzUQuNMp+x64s03jRBlY71KOTfYsZq8MIC0fCS23T7MsJTxQyJszaEMgn9J0QiFhbmUjbDyFSn1b1At5QDI3COX7p/mVL/zPNpwLRJciseay2kUrB6V5HVn16kU+Q1+cMN34J+NyyN1OsWf+ho28TrpXMR8CDbN0hTNeH4Hz/QI63tID8rEd3X6A193MI8Ek12Wc4KRoYFe+FZCf5l6scOrc8JBgqGTVSAqDLR/R3wemTtgPMgAjEGbATT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfUjljulUsmMc1+nvcShcTcmd4ciC5MxB8rhZVL4gDc=;
 b=ZXtjU7TFNXKLSK1bPoqz2CFPbVpaxSvQi+XbfI3ecGL9swbyYgLc0nIdNTd9G+cUjVDoxOoP4cukIRBds0Yi3RF9xqp/Wj1EDL73smTvJ11rayWOZZxDc77Xan+fHdyyaGy/rfof8Y2rS6t16KNd8/SAj11VjiquAT7ME/zqicJD/oRCGYmxYjhc/xAk6zc8enl9ULbQAcB+NdpqwZbE36fRy7deYbNPRxvViQeXe8TR3WUjEh/DxHqk/eYRSdnG4dSxAsugUEyHHMEBhx1lGkKphzLBPiTJ4SncFUENqJADvI9ecx/ytYfU07aUZL14ac3SVTiCPkiGkzV2NoSZ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:36:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:36:12 +0000
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
Subject: [PATCH v5 net-next 14/15] net: fec: improve fec_enet_tx_queue()
Date: Thu, 29 Jan 2026 18:34:46 +0800
Message-Id: <20260129103447.1893129-15-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c55eff11-9dfa-40f1-b867-08de5f2238ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gd5TXqj64f2RVacjoCaGGpECsEl+dQHBmM5bFBT0k7YfdSPIvyxFXiK9sVR0?=
 =?us-ascii?Q?erGciFmi9AUCM3+uClO4KEisb2JL7rvHnenN1zoqIrHrpFCKNe1Hny336onu?=
 =?us-ascii?Q?jj+Hc3ecIfPlZx+V8clMvU038PLgYfLKkCx8fFUsmecES11KsfnTHx3Za2gK?=
 =?us-ascii?Q?fuW7oyUDRJvGXuxArs1rTw4qxoILAIeDcsQSjul4Fmr7ppsWqR3UNctG5vRq?=
 =?us-ascii?Q?U17//NPftj7PhaNAsP+KcsuB73b3GU8LXa7ZPP4SDeAANPquOkoV58xkDPBS?=
 =?us-ascii?Q?xJAMvwYuwf+tFkJV9+Z/sgmAdSMETIR+SciAcvspM1wR/DoSi9RnqhKjU5Vf?=
 =?us-ascii?Q?bDka+MSgUiXZrxNQ9r8VZI/bY4+GyHh0aQwaeRQ5Vtr7yY5t8SzUm0TGyKQw?=
 =?us-ascii?Q?YSrINYeggdhS4zwoVStxWyQwPJseho1Kl6cvDYeLmHfojggYPTQvRp/i++fY?=
 =?us-ascii?Q?X6NA/yadeBvbxRiUrdOAiXiu2BvCF2stn2mH17UnfcDd02soZe5WISq1gzJG?=
 =?us-ascii?Q?r1Hya8PmNqr4kRwp8YKU7W63V8rEFU57yzYG/VlAFZfpW+rtec8mdCoRGp5K?=
 =?us-ascii?Q?GxYEVz+x6+w/GF14c58ARBAJwusinLTWbOxvxM1zF5Z8wObyD6duii1GH830?=
 =?us-ascii?Q?z7STuWDRMPSiRh5QpxZDbRh7zcJyeaIC0muuT3ZGi4vdTLC7M/Vbo8SaVhwX?=
 =?us-ascii?Q?3uKr4pgVtORBhdtoBoBp1OQUUYXponYebD5FN7KnFPq3hC80RjptV99pVwka?=
 =?us-ascii?Q?4VBRu2MamZraA0yC/txDGnr5nDl5lw2QSqPdcQc/3ZOgiP/1Z/uzPAWEO3kA?=
 =?us-ascii?Q?KBy99n0QJKhnuiXhM8GdqAKkB/9fB8lGDZuVTi8DtWGLgG/kxLZy3f8CUHp9?=
 =?us-ascii?Q?DTuVX0428G92SeyD7u9fdnIeTHBUtcjuSBbrv9qB0yEmZWSgebMTwyAP8yAW?=
 =?us-ascii?Q?VfmEQv3UvzAtV/FeQrlSCgZV4HzK0yiC7TkUCfOwewanllz+V+TDJ/19Mxq7?=
 =?us-ascii?Q?qbl1Ma8SIxGcxKsj0943CNO2XsPCe6yiKHOe79vGmyz8YvAPktC+rRtdNpxx?=
 =?us-ascii?Q?Rk+nAuIc5d16dIF/EMD5WlMxMrNWOV9ZdWzmyIpJSENpwyl8Y7n2ALZpgELa?=
 =?us-ascii?Q?KriVuHf4dJ9LW0AmARWw95u0oP5bClbvmgpDQqH9Yz9FoazOf5XK5nfGvWTW?=
 =?us-ascii?Q?ERNO3wvuiKbjnP2I7y8d1cUL3C9sjuSCHN8NvmKuXClSZwoKbDjIyl0ssqSt?=
 =?us-ascii?Q?DvdBpkmE7EJan1fzC+ZKeQeL2M3a1uv0jp+z0wwObWoinZQXPbk90jkS+9t3?=
 =?us-ascii?Q?MAe5lKIHO7gQywPFC1kcNX4y9t1KETbl9iAtYPQBsKBayq3g1Uaez2PG1lxT?=
 =?us-ascii?Q?Vln6Tu6zPaCSBBuPtW8jLSFTIJE+WG8WYFVRFMBTYIGRddFur2iwOLfjyLhC?=
 =?us-ascii?Q?JR6mhOPN0Pq/N5QwfXedEGb6MOqNgz1J7UuN0neHP89sXDNijIKEpI/a+vUp?=
 =?us-ascii?Q?SR8QeOD9TN5wuorMS7uej7R/vqadz4tO3fd1VbhBuaLr1mpBYuD4Sq3RvCAE?=
 =?us-ascii?Q?wgOeBGqnHERZWlw1ZUd8r4GEXTDq2y2xjT/eSKHWjuB3ed4SxoBKAdydohA4?=
 =?us-ascii?Q?UbgZ5mxC16WOe21Pjgy/dBTEYfAaGo9ceqceYvC7b1bn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0NF3T8NhomrgMs+kTeZsezPmcLpQwNXZqwZfCJPBR3KJI56StDsZ+SAi5Kf?=
 =?us-ascii?Q?0Z8rZiIacnuVF74ODrDoy9OlphOe+b/RkKoom7q5Fu/hbz1I/65sr7Rh5fsT?=
 =?us-ascii?Q?Dk10rJcIP5KDikaJw9w78+bKYddKcSVB1tdsVRc+licvvTwNIS25itda5TH+?=
 =?us-ascii?Q?+V4wnSjMVJpw8zV2mRIgE5X9ehB3c4/iotf8/+326KHEt7GCyDVdHcgoQP4P?=
 =?us-ascii?Q?aaqRw1a7IxSUdqX6+bgz/wdyP3czVQFsPlQ1Hvvn5LLELxOs4Mf1KJmYv2IC?=
 =?us-ascii?Q?j1yudZNG6NRc7t6XXmkPrxo3LZP/uI4Hg6RKIXAyc6yCIB5hMMB31/tFaZzC?=
 =?us-ascii?Q?BEKX8gAwV1dJpIWWpl/4O+sNimVztiV2gpC0fHiORn3w47AlLRKZFryIWdwe?=
 =?us-ascii?Q?voTS4WTbD8+zeJYKu/73vQ82ewoFfVYvJHQuPttgTXf9Lnzu3dBWVlbwfJUh?=
 =?us-ascii?Q?vzLz+3I9JvYfRUpuLPuIPX/7S1F5iNaWvIFCHRTH/egj5qe1cJ98T4tAZe7z?=
 =?us-ascii?Q?lrgkAuPQPYZj++Duxok6uhzcK5xmLQ+vib4hoy4V4xnr1NG9/4DyLTqYoIES?=
 =?us-ascii?Q?eOWenhj6xkJcJUGQGyNGQFcGM8sVZiMQaVjytSPbyDvtSuaX+Cy70GaYYqB4?=
 =?us-ascii?Q?1WdpbOI4+1wk9eSylL7CIBn3kpg707qaiYuaKVhJVfJ1I8B/V3vkTMk5UfLl?=
 =?us-ascii?Q?DRhNDSmV94RIj1MvknNqwosyrVdz8NsB19EHSQfV2MbKALG68AHnB7LzRizR?=
 =?us-ascii?Q?eKyWtS4QaD3PdYTHDn9QqtIkoVAFnL4Jlyz5BRs2XxOBYyp7xFC3xqIKXpBy?=
 =?us-ascii?Q?NZ7XhbK3iWJZuKdokr9H54XkEqlkww6NQQoEpHZ0AD0/fd7k94OxhvMp46kx?=
 =?us-ascii?Q?2/+cWSxh/PBphnltgllET9jHdxqNzFdjBQzagK7/4hCwdApYfyXc6WDci/Z6?=
 =?us-ascii?Q?4H8KqHJuEyqDEpjpkJKbHjDm0QEKejX1F2APioZCwLlpzuHkSEM9UHA7RKhK?=
 =?us-ascii?Q?suroeNPn7Q5DYXiWUdWUPQr6I7ypd29wPBucWaq85cuJVy8klRzAEfTCe9Lo?=
 =?us-ascii?Q?RZcbV7UQtzZ5+mWAohV6MlThhO91ttleP6HKUf9Fa+0JjipBu2t/8ZHxkwuj?=
 =?us-ascii?Q?FokvHnzRtRmyEISzwWIHwEHWCrBpjWTwdowDFeZJQcypsUNJyoS7WDgtzrWr?=
 =?us-ascii?Q?CNrXRpdtAuUD6icwQzxQymS7s+aPFwZ6ZwnnkqOtbdUdnTMi/v745SxdbYS0?=
 =?us-ascii?Q?MTb1e+sHk6+jhEKok/CKUGI0627n3xeYzD1Xh7iNsh1IA0bp2eBVvoaeuSdW?=
 =?us-ascii?Q?VcrIYBatRB+rATMUPqSv83pBfZyBYdH6/ll4Dv9mgp9Qfa8CMxbx7bClp0iz?=
 =?us-ascii?Q?tmuxAMAYxZALyeD0SDKNjii/pd1JfQ8ghPEXD/cZygoCC+ChuxGLFM34z2sg?=
 =?us-ascii?Q?7yH1XkFp3Q6B3b4+7CSJqaoexzuGpixDrwwCKkj3qP7Mc0EnREUbpa0NgOui?=
 =?us-ascii?Q?62dSaOPDUjIcHc7NK5dsXQcfgBy6pieVGyCzkqOu0UGTfu0z44wP1dUeUIdj?=
 =?us-ascii?Q?HADQp10Vk6lmsCnr9e6TT3s4+DifQ/JZGoy+P8jLckkgH29J7edySbnI6ZUQ?=
 =?us-ascii?Q?TDSQUMg7BEt0LckyhCGzbrte6lIyb7899pEQOfIEbmui1R7z2GJ1VBr626Dt?=
 =?us-ascii?Q?fy1o+5cPFOlHdtk99U9YhYFlRjfi5aBrKYy6c8btRbVS0UPrh5z6BZm+VTEo?=
 =?us-ascii?Q?JvpzsDjcXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55eff11-9dfa-40f1-b867-08de5f2238ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:36:12.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLAg/Njy0qI776MKiFt7N5tAC2udSQIqKeKJKNMOmqDCXWYOV6hu62NGKsOy5wkaQspBd3JND3od4JBT64oS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
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
	TAGGED_FROM(0.00)[bounces-254733-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 240CEAF0A9
X-Rspamd-Action: no action

To support AF_XDP zero-copy mode in the subsequent patch, the following
adjustments have been made to fec_tx_queue().

1. Change the parameters of fec_tx_queue().
2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.
3. Remove the variable xdpf and add the variable tx_buf.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3b0c8a9b1587..10a02fde3887 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1475,27 +1475,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static void fec_enet_tx_queue(struct fec_enet_private *fep,
+			      u16 queue, int budget)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
-	struct bufdesc *bdp;
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
+	struct fec_tx_buffer *tx_buf;
 	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
-
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1508,9 +1499,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1519,7 +1511,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1550,19 +1542,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				goto out;
 
-			xdpf = txq->tx_buf[index].buf_p;
 			dma_unmap_single(&fep->pdev->dev,
 					 fec32_to_cpu(bdp->cbd_bufaddr),
 					 frame_len,  DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			xdp_return_frame_rx_napi(xdpf);
+			xdp_return_frame_rx_napi(tx_buf->buf_p);
 			break;
 		case FEC_TXBUF_T_XDP_TX:
 			if (unlikely(!budget))
 				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			page = txq->tx_buf[index].buf_p;
+			page = tx_buf->buf_p;
 			/* The dma_sync_size = 0 as XDP_TX has already synced
 			 * DMA for_device
 			 */
@@ -1599,9 +1590,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1637,7 +1628,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


