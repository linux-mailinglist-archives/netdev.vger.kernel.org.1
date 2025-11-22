Return-Path: <netdev+bounces-240963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1EC7CE22
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A084E5599
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8B2F6197;
	Sat, 22 Nov 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SH6B00rK"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604032EA172
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810612; cv=fail; b=c8H/j+Jnx8nJkJ6HlitdKf+Jv2NzcMcCFEiOP8fY5Toro7zHKVPSi0x6CDfnvkxEuoMSVURI3Oq4UOKcBPEqKaBpJymSXYNlZm92mrHE0rrV93FCmtKOkhnFJtXf0bAaJENb/XoCCB5OPgE5mbhxveTsKgWrFse+9ZPcMqI138c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810612; c=relaxed/simple;
	bh=ikDhdi3ZAa2L5v5b5lcm2t+QVYS9aiatBA4LEPWuSsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrgBEOqp64iezdp8yQT8sGRQkN1vopZECn5c2WnmmI1P/s5jdBX2jIybYsADhE93lgPxLBxY3ZXuGS8T8dsd2fVuvfRo+7F9rq2+0YRymZmzpyWyWvBH1W0DwvdrjkQFiFJ8GDeBoWyT/Q14xqQ0+7t3Rxj/J9X998EVuR7DSkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SH6B00rK; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUJs+opdJYV+u14gr853XILWqaj+ySMKF/EOx7+TKmt+ivEtUXI3do5Ps1qmNIw6hgIKkafG+TuW8lS4P38BEdgpcf6V9FcnSmRcb34pYeRoRRdsZWtxi9iNZQKJHluQe9L4EooZF1wrV+PuD/yicpKZPFfNuXSbxoHq8JRgHaTT6HpdH4XCJeey81WijUOFlajWPyAWJU/bs3PwgYXXFTFAGllyeiE8yvEx7/3+35tVKTdUoH55Hq3F+SGEtakVXgp80jNzvW2fPDMym3y9DDhSfNUGCcJBDSU/qv+XYCjTT+btNupxBBW1hGY5043TMgPDLYkLuQbV5jKVpsanQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HskDznOmDtqMIihykTsj3G9SqB/b55lPZu/ybR92pk=;
 b=iSZq8xO8WYy3WfwUDPaRULdqBstSJ14B/1TGzpt76N4xrIWpBDSkUHCIfiROYLqcw4MxyR7vhsj1TcLF828RaA5BEeFzQTbaZZv9TLZBJTQn+E0+7EoK2jJm9WXecU0xmBowxEQQ6n6WlGPgJUQGBHPeWtVWz0mzplbAnasYsvwXvWLSqQdnpE2D7jaGyMgMDmne4j0xE5oY9V/VeoNp+0zpIDKvsQgjEk6E8wWZIhrUPzgbIfx6EVL0VnP/kmbrNheg6FxGCZ+gUXepH5c/jRNJy/eA9s7Ne4rxmvWsi/F82S7njpRKPw3IkClcH+D+C3Haa0Cg8bI4p6ermL2+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HskDznOmDtqMIihykTsj3G9SqB/b55lPZu/ybR92pk=;
 b=SH6B00rKkd6QmMBqEVhxLy9WRJVS7hdE3vCdRcWeI/Hw+uVZVc7fwfOEEKM7ZLlUhi/Eia4kG5QMook6TuzPRAlMImaGmIhZNh1nDVqR5O90LzC4GLoqvABv+8l/TIsdua7dGmWJoWWwAtXiRvoNHEWYiARC+u8rEn5ptUukCe1CGfXPjibKu+LYS6EJXO+Ph8z7qGAPlxhGEfIeBJuPhAth+KOayWCU89HOb5X35wOXYYXB1lI9HACnutZQCa3kpgl4Z/qaFNBoYAzv3Mk477kNcqskpE6/geE7utK1AMk/LNtd1xzidrQWnzp8jff2OKG20+RAPHpObWlQFnay/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:23:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:23:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] net: dsa: cpu_dp->orig_ethtool_ops might be NULL
Date: Sat, 22 Nov 2025 13:23:09 +0200
Message-Id: <20251122112311.138784-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122112311.138784-1-vladimir.oltean@nxp.com>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a7b9fe-52c0-4059-d760-08de29b98dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+RQMrVvlGp0HEhGjEs5iD/Him4aMvtVBd192oOjcbafP2NUfI4sM/MNJcxw?=
 =?us-ascii?Q?N+0VfbsChT50xMqUmiau0eJUrg9xtrb6XcGJ8KPV0c3ppsPRWA0KKZzFirHK?=
 =?us-ascii?Q?FMIR4+WhVMVYYTZHwa0E5UAVvcjlo/4H/jO/GmkxlPuD/GPyN66EhzrRdXK2?=
 =?us-ascii?Q?pBFtnb5fZbiunoDDsDohfo5kvuJUFOPIahoLQ4fGvmp0WA0jNMmjUMOPDfZI?=
 =?us-ascii?Q?LR7VBtbnGiwjVzzt30ThltLjZ7pkdLWMcfGyLRmJArnr2N7Qb0Xcg2JHmYbU?=
 =?us-ascii?Q?RodOvUYaaZ29TMipQgbyn3iyVpW55FDNJv4jIhmyG2zc7NTKG+bu/b3068gq?=
 =?us-ascii?Q?8cpnGPlR/ucChWvkjtRouUzr7kYipJcwjD5ZNGOA2KMLakSJzJhoaoGRTxWk?=
 =?us-ascii?Q?iTlC8vsjHCFP+950EUpgbX8hh9BZ/UFqalMm9GNOwNJ79JyEKcauk6rJ4MEZ?=
 =?us-ascii?Q?59CErq9ioAFRh6F4KnLv5R3rUPphddLkHkHZqfpAhPq4RgR3XfSfOwKRLakX?=
 =?us-ascii?Q?p7ENprQlrPtMfJrmFUsFfbf3aUyertcBZLj6/Il2BVhJZxYrsGf1UNaPXOEM?=
 =?us-ascii?Q?HYLV9UD3dYhPSOj6juHhqXJWyttor8Xj8/gqgICYmiSnkN2dyoAl0LwC/kAd?=
 =?us-ascii?Q?djMXBLduEoGBS71+BRwkW0l7tAUgy1C3+ZCnjUCaQzSega+DLXRkUYPNZUgm?=
 =?us-ascii?Q?RhBzf6PSNJVOaw9ggwi9fgIenGXPqvjSyxCwmLIPYbmACs6WwhoBEghgKp8x?=
 =?us-ascii?Q?T14t5CfW7pQOu1ZAs/pMe9d067AibCfPWtY4YnkwlzZRoRLM6OWBu/dCYz9e?=
 =?us-ascii?Q?jRVpHljNfa45Qc+qUN6N4rXdjyH1doggecAkfjdYFTuApqo2C0Lpfw4sncKz?=
 =?us-ascii?Q?I5Zilt00aHuwxl7tt/KniWWP7uezv8vKjZDYgOk2qBG9Q93LP+yt7TfeORlQ?=
 =?us-ascii?Q?aWLJRBjJJ0a7ppnbGuMu51ihttJHUyoLwjHo4qJ9ALHPRWUgul22rzW0057d?=
 =?us-ascii?Q?XSKPtWyvZXDPp/wDEUqUiW/k/2W1hS2HLfJNUG/xmgay5QWdH3c3zW+NFvl0?=
 =?us-ascii?Q?geu9lM2Xj6ndUaVmNBvYeeG0A7pHqV6I5i6NdT1wnBt3oyBqDDpiamssfu+A?=
 =?us-ascii?Q?uRnVp0n0Q9gbeVRlR0LKk/QMqKUKLWu0TrWCf7Pu3YXvJ/FAgpX8NAeEFogx?=
 =?us-ascii?Q?YRt0uG/FK6ncpHVT/eXEf1gY70ezKLqpF9M1rd3VjjjS+TV4mUtU09UBvVFe?=
 =?us-ascii?Q?sMBZzNkQGGkyfYSQfHuLtKT+t4DNrQgtfcJV9JaWKnauFU5pPDvpmmJipKO7?=
 =?us-ascii?Q?GeuA3CG8ZHUAzXy8JsAVflYcL2rRacQ5NvXUmLM8a0BoupWNVaOBaAsl9ZVn?=
 =?us-ascii?Q?+9Xoi6tH8pimMfrm1kaTsSm4P+yZmlHl0xOpD2bRi+XrBz6qdulButXTmGhr?=
 =?us-ascii?Q?nfj8uMSsgr6P//C09fsmoOBr5p0I8uN0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ms6w8+RAYUupE+hLmEawIOpS5zDnc5nxI6HEHKhAqt1o+xG75p/EsnyMJLSO?=
 =?us-ascii?Q?NeMtpsUx6XPIxUC2N21ZZnfwDqf2pmNZcH089AQwEKFm1KtaF7/cGoB3X41k?=
 =?us-ascii?Q?0OlaEt5IdWVoTZkgiEZwQG7F+6aCo9ooprwvh/ifE4dseF5aN0K8jdR1J0+5?=
 =?us-ascii?Q?upgU3QOKPIYk7xMKwMSfZaSld+65K3Sh/q4cMn5IFa3hJbH+pzbjQr5OW6hp?=
 =?us-ascii?Q?NyF8BDPeXK/j87vGLtgyYg7BFbBJgXRtoOPdT5OZVdRsfJoKpKiEB7ZYx5sU?=
 =?us-ascii?Q?NlbYxMhSpWNNgYApO7fbJwg9cLKQNXQjw3VfpZG91TiIB0p5SWOirPmKnKYq?=
 =?us-ascii?Q?bnWIsVgCIg+CjnfyRXhL0eOTywLg+SEqJFNKscXbaRox66lS06trp3h4+ZeJ?=
 =?us-ascii?Q?3pDlh8rucvPrvPJKeWiSnoln0U6ndi8tg9GpktTeOhtCcGCyPRAEVafTDZUz?=
 =?us-ascii?Q?PxLcNIxc5woA0Kne39Uzeh8szO89JBqOWtd/gPLjcJ70eYhERUqQ9qjqUK3F?=
 =?us-ascii?Q?BbHz2r/vwrtPiQ11J93KM3cVoZWSfSPgRK/VKuWa5VNmgkFCB/yMDnzlCF6A?=
 =?us-ascii?Q?D8OqrGTborQCAytxhVOHBhncfXHpW/UZ8zhS2FXh7hivxrJWBtYr8XXxiLZ5?=
 =?us-ascii?Q?iNwRFa5NhVlqHySj7zQ3JlwEa44o9/xvlkuQ42hYNJVOogB4MyvxM0tMVfyK?=
 =?us-ascii?Q?Mpf5SxalQhr2+hI+3fLze74xqAwGuHl70aXk+pqYjKovQROApHuk1B9uqCJW?=
 =?us-ascii?Q?WxOzfevHVsiNuFxl3a9l/hA+3vixpeXgvKZpLY9Bey0Ulnx2YCl+aO0S/hl+?=
 =?us-ascii?Q?4ePh5S23djw4UdoJePL09EIF2DfqJOo9F/zZulBDZp5WKq1JbUVYfPGf0B+O?=
 =?us-ascii?Q?G5j6cuCQs+zr0E72o8z51OTHAsnK297223JFIu0ASSsNNKVFn6ddNemrynGE?=
 =?us-ascii?Q?nft+1Oj4gGzv6KGBG5oe0NWCmNFOZpe7pVP0w1toQriBMhV74plaV9wMx+oT?=
 =?us-ascii?Q?+RNgkKVgto10RalQNxSQikJGs+blbXwHDVg059cbqth1rCKHfRdJGt8Jgkbm?=
 =?us-ascii?Q?dHHo0YcfxW+1DJ1fYgwXHIyO11Hzou1t0fjtiNQoimFBgo7bP4NYkuzhSuf4?=
 =?us-ascii?Q?Pu8PntGSYUphtrOVd7cfps2I6SARZcXR7Pw9cdx+HlhfSRYs/+Nsa120Vc4d?=
 =?us-ascii?Q?KfsB/x6197L6g9NmvKlyO5FvV7WNDNQjgHSnB/ru6xWlLL82Jqs7M+pUiKxZ?=
 =?us-ascii?Q?IcHorrofO1WZVbJ8fJIf6N3VMrXyNGp+dliM6uwT/XqAu91p9fivNmgWAuX+?=
 =?us-ascii?Q?qK+uWSYeOf/yE/rqdWZ5HQP5gPSvQVR9VFZZ8sr2RMFsJJvjv/E5tw+2STDn?=
 =?us-ascii?Q?BlWifFMIxZoiKqFjecv8u++U0GtqhZrfYCgcrZ6ar8KZMBYGMEeuPIhVo0i9?=
 =?us-ascii?Q?3jKjU5HIakPCEMPaS/wnS9eWp3FL8Y5vZX3n17xN7zeSPD+7ngebLA65Fv4M?=
 =?us-ascii?Q?vCsPAxm6LkpK4UaKq/jSL958pwB1CCN4t1/O9UsNufJyzUIUC/3Q1x8nlbU2?=
 =?us-ascii?Q?Atu8SuQQWovysP8Yig/fwtvDGZ3XZw85hqYjCHB56WTZm1T05OzMSOABl5d1?=
 =?us-ascii?Q?bJBXqGk+49F+P3jG01cGpIY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a7b9fe-52c0-4059-d760-08de29b98dad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:23:25.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+CP1+yHgi9ZIgD4MUjV7PxKgU19CYFLV1b9cHdtNKqVpOTnqPO5P+Ycu5jtWS2DWUKG1/rdCryVxy82Krmg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354

In theory this would have been seen by now, but it seems that all
drivers used as DSA conduit interfaces thus far have had ethtool_ops
set, and it's hard to even find modern Ethernet drivers (and not VF
ones) which don't use ethtool.

Here is the unfiltered list of drivers which register any sort of
net_device but don't set its ethtool_ops pointer. I don't think any of
them 'risks' being used as a DSA conduit, maybe except for moxart,
rnpbge and icssm, I'm not sure.

- drivers/net/can/dev/dev.c
- drivers/net/wwan/qcom_bam_dmux.c
- drivers/net/wwan/t7xx/t7xx_netdev.c
- drivers/net/arcnet/arcnet.c
- drivers/net/hamradio/
- drivers/net/slip/slip.c
- drivers/net/ethernet/ezchip/nps_enet.c
- drivers/net/ethernet/moxa/moxart_ether.c
- drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
- drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
- drivers/net/ethernet/huawei/hinic3/hinic3_main.c
- drivers/net/ethernet/i825xx/
- drivers/net/ethernet/ti/icssm/icssm_prueth.c
- drivers/net/ethernet/seeq/
- drivers/net/ethernet/litex/litex_liteeth.c
- drivers/net/ethernet/sunplus/spl2sw_driver.c
- drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
- drivers/net/ipa/
- drivers/net/wireless/microchip/wilc1000/
- drivers/net/wireless/mediatek/mt76/dma.c
- drivers/net/wireless/ath/ath12k/
- drivers/net/wireless/ath/ath11k/
- drivers/net/wireless/ath/ath6kl/
- drivers/net/wireless/ath/ath10k/
- drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
- drivers/net/wireless/virtual/mac80211_hwsim.c
- drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
- drivers/net/wireless/realtek/rtw89/core.c
- drivers/net/wireless/realtek/rtw88/pci.c
- drivers/net/caif/
- drivers/net/plip/
- drivers/net/wan/
- drivers/net/mctp/
- drivers/net/ppp/
- drivers/net/thunderbolt/

Nonetheless, it's good for the framework not to make such assumptions,
and not panic when coming across such kind of host device in the future.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/conduit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index 4ae255cfb23f..f80795b3d046 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -26,7 +26,7 @@ static int dsa_conduit_get_regs_len(struct net_device *dev)
 	int ret = 0;
 	int len;
 
-	if (ops->get_regs_len) {
+	if (ops && ops->get_regs_len) {
 		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
 		netdev_unlock_ops(dev);
@@ -59,7 +59,7 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 	int port = cpu_dp->index;
 	int len;
 
-	if (ops->get_regs_len && ops->get_regs) {
+	if (ops && ops->get_regs_len && ops->get_regs) {
 		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
 		if (len < 0) {
@@ -97,7 +97,7 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 	int port = cpu_dp->index;
 	int count = 0;
 
-	if (ops->get_sset_count && ops->get_ethtool_stats) {
+	if (ops && ops->get_sset_count && ops->get_ethtool_stats) {
 		netdev_lock_ops(dev);
 		count = ops->get_sset_count(dev, ETH_SS_STATS);
 		ops->get_ethtool_stats(dev, stats, data);
@@ -118,11 +118,11 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 	int port = cpu_dp->index;
 	int count = 0;
 
-	if (dev->phydev && !ops->get_ethtool_phy_stats) {
+	if (dev->phydev && (!ops || !ops->get_ethtool_phy_stats)) {
 		count = phy_ethtool_get_sset_count(dev->phydev);
 		if (count >= 0)
 			phy_ethtool_get_stats(dev->phydev, stats, data);
-	} else if (ops->get_sset_count && ops->get_ethtool_phy_stats) {
+	} else if (ops && ops->get_sset_count && ops->get_ethtool_phy_stats) {
 		netdev_lock_ops(dev);
 		count = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
 		ops->get_ethtool_phy_stats(dev, stats, data);
@@ -145,9 +145,9 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 
 	netdev_lock_ops(dev);
 	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
-	    !ops->get_ethtool_phy_stats)
+	    (!ops || !ops->get_ethtool_phy_stats))
 		count = phy_ethtool_get_sset_count(dev->phydev);
-	else if (ops->get_sset_count)
+	else if (ops && ops->get_sset_count)
 		count = ops->get_sset_count(dev, sset);
 	netdev_unlock_ops(dev);
 
-- 
2.34.1


