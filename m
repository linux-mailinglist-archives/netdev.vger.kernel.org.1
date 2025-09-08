Return-Path: <netdev+bounces-220869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B260B494F8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B2116C9B5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B992264D9;
	Mon,  8 Sep 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BzQ4dlPl"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93930CD80;
	Mon,  8 Sep 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348317; cv=fail; b=Vc2K7bNlbZs1YECmU88PwsmFLdSND67feH+TaNXTiZ8UoN+5cd+ygWntFKTxM1AW9vqCTNvkYkF/+lDK0Zj6/k6bVYv8Yx9O0MB76WtBwdlIVi5V7pYHlt5ZMFKgwWjsExiaR79zPCT1njHXjvorsNvuCFnB0qHz77TomTrj8dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348317; c=relaxed/simple;
	bh=Rd4y8yfCu6ZGttsqbVoxiCg0CQ2PVhxhQ/yW2jIMZBk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UCrvfA21S12CgBSQPCKPSI6aWQCTXeN/ABD5x9D5WtJ0fN7Zlwb68HGIh57O200C9VCIy3VCbjOWLEUST4fuK/R+puk2UQKSS95BF5kTUhxH5/4mIcdsm/cSeThi84AcGHQrbhVy3IwYR380nK8MxoNFrsjEM9F4LLaVo0+zkFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BzQ4dlPl; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3GkU2I+uo44ohMO7B+ABmVk23semZFhZaIcl071hOSJcQcw2p+Bbxmz1MAyWoaRYKkz0LJun77xjAo7k9bPXMlsb5S/yhnxLVDbNhu7Gf2kDN8DYcVaO03d+2hnMmapSo+ehyM12Wvn17dUjPaC06y6P2bYgnkc1GH4PInXW0IWl8Gzue8MCPyC7VWCoUl1p5gE5HukoACVxckWfjRyHYtXvDiGIHa7J452Z9IP6s8uJZet5q7ywgxSxE0YZYNvdcNYtogNrR5Xgfby+a2ufsV5NOghTLU+OSKizUtmvGgGBOcUmgFDQwow+J1SwJypx7UxWXhqFYUL0LFsmlWc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e96FA9SI6mCI0/NoOimFYKNu3rnlENIu+F70Kkn6EI=;
 b=F4+4z0ManCNWiaINwnghl0hOfOJacJsGbQesTMr5Hno/9umldsJicXQvSKomUr2MpFo6EQhF6ehOLCqZ4hP8ZRAlDCS83wyY+PuggYqk6LxuYsFxmhlwD/Ny2JfOxLS0TYhpVAqvyoLFSk4PBVvxWoXwFSoeaXvqgp2vs/cE0i3AHI3DNNZdJIjq0w/L18RoX2gSaj0cCWw6vws+bbDARDoa7rZztfJaf8p7Aer5TlFgU3c3ZoTq22ymgJk6kYGjYd+NOxgtiaxl0Qz1ZJtHKK+PDeTbhlcC0/hJi3Wr/n7Ln+awDeeVZxdudx9O7rTn1/TAFYDnb4Lf7+eJCitxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e96FA9SI6mCI0/NoOimFYKNu3rnlENIu+F70Kkn6EI=;
 b=BzQ4dlPlXfDiytEy6bZa3OVhL0d0AsZSYWC+6CGXUnXoAKdO+FNL1vrxm3pVTLs3jhshLJHxpzl6DOd315hLarGqIk0FMSm4KOSkCNzuGYOyg2tgRcvGAGO4MnzNxSuT1OfTyO0zh+b8fkRfUVh2ZJqLuEVOn1d4KSdfk6td2j4QC2SGtn8cqiCPTEDv6GgoHnzv1r38BeWGGiHhRSdxS9AnbgI7b0k59pyIoDB403etr+ybCz43CbMHyuWda7SM4poLrAYCpMZRrVJRtf1u4gFJYa5W4ub5J+w9mRVLG3spn+osByx0zXmlEBtnO1/zeoVOvofY0jBW9ZyAv489GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:31 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:31 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v6 net-next 0/6] net: fec: add the Jumbo frame support
Date: Mon,  8 Sep 2025 11:17:49 -0500
Message-ID: <20250908161755.608704-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: c16903d9-2588-4b76-aefd-08ddeef35a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34Gas7c9xY9m/qomgVtbHRESr4L0zPo0DLyaQTJcCQV7NrE+vd+BG0O9cAHA?=
 =?us-ascii?Q?FdSTT+JU6az1b4ht8e57ltFfrHoUU/7ItqwEzP1x/acvyTjm62Ht3Ik4OimK?=
 =?us-ascii?Q?jbbCcq0ePlhPysZk+L5p1bCFtbkh/y5aRFHwQiY5oT+5Jc1p9YbU6UXgHtQQ?=
 =?us-ascii?Q?itWSkBzhc/CX7MZA9wcuYTjjuzRoOmMXpCOex+qkOJVBVuW0ldkPIqsxzS15?=
 =?us-ascii?Q?kBufkZxD+j8aAqBx7Uu24BwFnBi9hChhH4l7GaM2U07aZew7OCx4v4YHems4?=
 =?us-ascii?Q?smUvyYNRxK4GGTPIzyhUcoyod5q2kKIJTjNFLdjy/v/o7ZlIC3WwlNsxMY1F?=
 =?us-ascii?Q?ZgmjI7a9NbWC5vSeh445YoS9QqIGEGGTE9HRoq/6cWn5ZXDjJjCbRhXXSRqd?=
 =?us-ascii?Q?2OrmARcfcjm3ffy2LTBKHwoqonI5kFSW2Qu1u3OTsNecgRHfX3Hu+MTWLKeh?=
 =?us-ascii?Q?qUCWfvoYGEiDEiLCFefp+u63tFkfe9c/hkdWCs9Yi3bKLbsVHp+JOf7wrz+L?=
 =?us-ascii?Q?ENNpxBhtVe1rv126fOaW5wudY/2gIqrj1QibSnaAcoa+UMawYAopmqiSIcZz?=
 =?us-ascii?Q?8a5pML6gO4f+vR0nVAkAvfgRvIDA/uCzpNsrVqSL2SWQ0QKT0DpLy7i8yaUO?=
 =?us-ascii?Q?LgiObLLwQhhR9rzNaES0ET+Gxln24GCJB7sysBQiqYfx7RvH8XCoM84QbuHl?=
 =?us-ascii?Q?kDiSl1CF4H/M/co2wS7gbEF7ZxUXFLkSQJrYJ4HZdo72Nw6HTpSdO6CoUfFj?=
 =?us-ascii?Q?BmF+iR/qUMo4i/7HrnDMQoYCyPXvpQGnpicayJi5hxkO1RIYYCOnZXB3XADq?=
 =?us-ascii?Q?JUo+TwHaYbCe5KVawJUKFxlKu3zb8JzsZJ/uWWZ7VV5d598Sxqb+hpWOSZRF?=
 =?us-ascii?Q?IX0GlLoQfKF9HIdWYskguJI28geC9QZncyqN7Y7NXxoODgO+skxMwX9A3jNf?=
 =?us-ascii?Q?d562LbeWzWrWwrNYodtyggZ22Zwrs6uaPtcfuVxzXtU1R8gzHm1OK90kzqYs?=
 =?us-ascii?Q?tfW/mpnbajU0FwsExW2vBoR9mGCrRZ4C4xdGIGihUulsikMTd9siAIQKCU5Z?=
 =?us-ascii?Q?yJcy+nQ4qE5bAXrmP1h7ZRLScqKxn0KbXDBaW/MDcDr7ODAJ2BgctU/g3K5a?=
 =?us-ascii?Q?rmRZYUPZkNegHW9xVYUeCEjTvBgBBXxuU246r/MWwGyOAJeh4H7dZACN0yYE?=
 =?us-ascii?Q?OUTe1/9gbM0EfQROzhBYvQlA0GmdjUS2ljQir3owrk9sDV3UTcIf7nbhZqJq?=
 =?us-ascii?Q?Wio37cy4jXeqpywBV7Zpcfn2KkY7XflTgFeDxA1rFqXStqjWVMwqAs3027bK?=
 =?us-ascii?Q?Q+jpsfaC+H2pxUHbVPobwAlj9YXQLGRpzXHavILBwbrabtrCkY3uKfHn0h9t?=
 =?us-ascii?Q?3ffc0P1Gyf1gkSDBB4AlpMVcHEvTLnl8RCTmp0bn4FyTieKMNmagVzqaL5ZP?=
 =?us-ascii?Q?olsDwpcGEVRDZkmt10mm4ypK4rDRRRBGLNSPxtpINjTiUz+DVKYmkkeQvrtf?=
 =?us-ascii?Q?Lgot4MmGlQ7QcKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5x2SnhVLCnTYSYhehTpBrJXgMi+I1wPP4JZG++blcCCCuynJJdNoAnd8fGt0?=
 =?us-ascii?Q?IAxasuBDPonK5mB6NI4poWXAps8+UqbPB7ErLtAH5bJD8jodxD5CROvNaMgE?=
 =?us-ascii?Q?12sVYZ+sWwZM3Nse/WGrqhuHTnwyk3gbhYvNjkHYwr6IQMGCwIgwV1EkVFXb?=
 =?us-ascii?Q?auQG+kSBjeYjOB6n85zOmPnm/ViDMiwRoQdUzgruXLTnFOX12iaZJxu84WDd?=
 =?us-ascii?Q?OCe50Y4157MfgP8a7fU5POADOSy0hKcSt30iF1qC8WHqZEhPARed3feQlRcH?=
 =?us-ascii?Q?+XPX/wvZe1+hujKYwr7PwCyFw8Pi51l0FNG/4JT7wkM43oDNp/sBrVUfN16B?=
 =?us-ascii?Q?Dh8RZUjO+TAyutrEzV0uLOqTZDo7Z4RWaQW30s1dUf6f0G9yZ0xCUUuV8yOx?=
 =?us-ascii?Q?3L7Foc2AKX0ypLn4E2bf1/O6/B8Pa2smTOfzyFLfPUwH7gA3J6tlSxzG7OJ3?=
 =?us-ascii?Q?T8J100mbW9db3QdA1jpcQ67+RMCWwh6jh5fmj41+vwy9YMv32XGRUSgCtUCu?=
 =?us-ascii?Q?b+JxYt1Ef5hYr+RIc3OEiMnTrp8gUvZIu+hFaOOUz91Sp3D6/hAlejX0K5FD?=
 =?us-ascii?Q?nstnpIwU/0JhLpl9P4Z/G2VvMTvdNzg7aeV//7Fu8IgQbmfcbpHLG5gtUDOi?=
 =?us-ascii?Q?G6N9ooaxhyP8oZLLoBKGO4+Loeb4VQRs56VpUQctc0pXDkhmjUPNJl5eWBUH?=
 =?us-ascii?Q?ymBZGMaxPjS/PqTlXdvsnJ2373jMLusROYQSYQQ1/o0GWJl9gEZtEhxyAS2s?=
 =?us-ascii?Q?+hgadzmP1OKNWqWWdWfuebxykXWVKfdrn2NkGTWfBBamuMa6/Cf/xPrllsZh?=
 =?us-ascii?Q?Zxkpcl0ncKKOpquYBXg9/ifywyNjeRKepXlB8tPtdQHspLnYNMksFSzBdV8d?=
 =?us-ascii?Q?2oXEVpuYYMsb+sMwxd+CQEOvvG+tZP5BaLI35X0qq6VY+O/kjCavX/VkGkEq?=
 =?us-ascii?Q?3K41ceMMhgqZlfRL7OwUUrG63MHtwr6LaRR0I8a7y49ljA4fKMYBo+zYoKYq?=
 =?us-ascii?Q?fbWnU+wrDy7LP+v+tvAOZ069zdrdo7jt7CaLTIZAXFwMy5jY2mGfw8wIjLfM?=
 =?us-ascii?Q?N70GC7W6CnLiVkMNafQSwoaLAdvXDmOtPg7TWVQ4012r3G2BDNfnVLBElZrF?=
 =?us-ascii?Q?FAvXsnEWBsUh6LPcKpDrgOSR4kgaLXAIn4SxajPSSSpRLuf2W2hRMCXdUHMN?=
 =?us-ascii?Q?g8uUOMXXN4CWvOmeVln4xNbSUnFATXF7jQ/l5x1hdfWsKXrYxcFJrdIZqCSF?=
 =?us-ascii?Q?xZ+1/GltEd4dfLenNqLG9YSO8BB2z/Sm7us8+d0oPZHMJrx8woavz4aViNwz?=
 =?us-ascii?Q?WMOANbedqcgxuuPFlqQ6v4WK6OaGA3ONKZCU33/WiWImp5gRmLMutdJYlAYH?=
 =?us-ascii?Q?jVAt43HnOg6VvVEtEag6UmnDPKjZnzcB/4ac+Al9EImTuh4CRd1NeZOzilNV?=
 =?us-ascii?Q?VHRuhs7KntXlP+5BdpFGIjrqQW8aDVrPvaLojex8PeFocTX5VM24XLJ/thkG?=
 =?us-ascii?Q?mXGsjn+OJuxsx3k1xg1cMb6oiFp5WpqJBENaZATfOXRdPH2KW7uXkrd20KUg?=
 =?us-ascii?Q?5oDyl2/SGJO4xl7rJTqRId6k24Z5Sj2GzreL1Q6V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16903d9-2588-4b76-aefd-08ddeef35a12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:31.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KJ4cvblteSYMb23knDFUVjfmrVef3mDB0h4Q2+SvcJ11Snlwuw0aOx432QLuPkbMsOHL/C7y0M6Eie/m9HVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Changes in v6:
 - address the comments from Frank and Jakub.
 - only allow changing mtu when the adaptor is not running, simplifying
   the configuration logic.

Changes in v5:
 - move the macro FEC_DRV_RESERVE_SPACE to fec.h
 - improve the comments for patch #0004

Changes in v4:
 - configure the MAX_FL according to the MTU value, and correct the
   comments for patch #3.
 - in change_mtu function, revert to original setting when buffer
   allocation fails in patch #4
 - only enable the FIFO cut-through mode when mtu greater than
   (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)

Changes in v3:
 - modify the OPT_FRAME_SIZE definition and drop the condition logic
 - address the review comments from Wei Fang

Changes in v2:
 - split the v1 patch per Andrew's feedback.

Shenwei Wang (6):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  net: fec: update MAX_FL based on the current MTU
  net: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      | 11 +++-
 drivers/net/ethernet/freescale/fec_main.c | 68 ++++++++++++++++++-----
 2 files changed, 63 insertions(+), 16 deletions(-)

--
2.43.0


