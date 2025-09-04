Return-Path: <netdev+bounces-220103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDAB44769
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4300D7BC607
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23A2868A2;
	Thu,  4 Sep 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UU2EhhPY"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87A286880;
	Thu,  4 Sep 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018156; cv=fail; b=Gww1Fnkuh9LT4LTqenWQLBWCPceG/aW/Q0B+d21//mDmYEHhdjdjPZMwzqM4yOj0CSMxSpKH/HhevsqIb7JaRAYbo26Dj3ZxaTI19Xb9hzNzAjRfi6pLuK+qjm7F1Mb5cXVYAgkLzVKrPTfo/P0F6bOFmzkQPcTdApiT6rAUV3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018156; c=relaxed/simple;
	bh=tzz5/bHMGVz9Y16tKVHJTHMnU/gyyGjtKfspJPafO+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqTrADrPZbGMxbEDrgDUwAriclWid5U38iVuTefCK2KG7v1buduzT//P4wvBxB1TGjcc4jQ2u6mJhutWZ0nJem5sz3s5FZy6wxhvFOigh2yxF0Bjm1TjOF5hL4nwrHsb0/bez91ZqjurDsIJY3ZtZJhD1dLndL56Yp4950jvPGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UU2EhhPY; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx80B2VbU1nFXa4Ywz/Q/pCN46T/GhHBDZpqboH+GbP1UVlmUMZSMFe8O8aCWdEDfcQDsxRnbF3qbPuUa0bCTIA7s8g9kbjoFJ2tMcIdDNxmZEeLmdCihkNaJbbKjeCNL/79HAHb0z8cxVGDE7K75Ydr9PyXzp4JYL4Pq7atH3FHkF927wKGpEnur9WWlSDzl+GtFYk+cbQympq6zLJjCtU2Fc4fusz9IeGEOS+0Y5iLx/z2KYeq/ersTlGxiDfKUVB5C022HgBMkNvgAThlewzRu0uyejhQ0tMiwMiL+j2jmUo8UOFDgP2jTX2zSgazKRkXZ1p60gQppgh0t+4Kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAZDSyxxkE5nmF81WtOaplVGC6JdK9tWTeB/pLjJpDQ=;
 b=McUOYeqzZIU/3WFaCdjctmyY16CukIklD+K0v3Eq/Lqbk+5tSwSHoO1sIqYG1ogqVdAteq5MOXW5LiyenXdESV6CjboZtfFuHT0kE2EIqrAh1vmy6eiaiOK0Aoru6wAvqirgBZDCbAtiJSgq+vZaM5hzzWy/huh4kWJwa0Gf+Tdn3VNfVzt5rAxkKtolROBUoh2FIPN8p4mUqjuuvrNOQecYeuPeYfKhWDvzVHVwsywyCe4rw7vWBYZ7VERY6FpdsUSZi5KWwCzzNqU8tJ4azHM6LeewAnQT4CCgOcICPkjo3+SGAIyYthdl9ICNCPRAzQeakIFihr2ZcnEhRnWngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAZDSyxxkE5nmF81WtOaplVGC6JdK9tWTeB/pLjJpDQ=;
 b=UU2EhhPYF0eUVukKYGe3fh+b3kS1uKNWSUCG2RhERYBeLU63YQQAjqaShC7gJqpaeVRZqzd3kkOFuphmjB/mbEqp0LafnbVV0GU15Zl6aU7bio7hNjGDrEJNiNfYMxMTqdQ5Q3PxwakE67oI4wzksHE6Is4ACpWlh6e/WlggoGzYtL2zs60f5neHjHgN0n6DANcfIJeQ24E5alg/R3QZuHxMv4I2nKOyC/jCXNcxi8c02BOgCqNNmEmmKLE02pMLhHRjMewiuv0KZWIVsngNvm9CgBOA5dEZmpc/2AEHuJvEnlfmPjcK8WeRxE4x+d4Sm7ztKLmmfB3Vu9OK12S1Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:35:51 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:35:51 +0000
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
Subject: [PATCH v5 net-next 3/5] net: fec: add rx_frame_size to support configurable RX length
Date: Thu,  4 Sep 2025 15:35:00 -0500
Message-ID: <20250904203502.403058-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904203502.403058-1-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f91217-3966-4c48-8017-08ddebf2a353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrAzXAmRrwGCMSW2mFRsZCGwMzsgueEmSPuUdzdLI60zD+A1qA5/ENzbYJzE?=
 =?us-ascii?Q?yVKbHj2iTaVFrSnfbc3D6qECY7PfRyl7xpaySIzfMybbx51mK3JvkeeoNlAH?=
 =?us-ascii?Q?FvykvaJJlGmjtOEdO7j1oa74rcl79k9D6ijaOkhlNw87u/6PYXPsbbcTihyZ?=
 =?us-ascii?Q?6w1+1jp8fBigIQWYCCdLriAumSL9F5O/lL5Ymg3YJkvng1FKgOcjKKaJDbEy?=
 =?us-ascii?Q?4TPsqfhsMiwS2dhhYfougR7Nc32t311uo90V4W7NN5wAVaxdNi8jNH6KVcVr?=
 =?us-ascii?Q?8AwVcqZmgTehyJglC5FebSjKLhfzAdjCG09vndre8NCaPzymVTYFIKSBHmhy?=
 =?us-ascii?Q?7+szF1Nnxfx0F8WJGLkarzUXkWuxQamOJ83wzeQ/cxJhbTppnKSIud33FyAU?=
 =?us-ascii?Q?UfAyZvx0xjhMgreoguBhM7cTzFmlsfJH5+aMucfyfRzX15KVj2Xq9px+Sk4w?=
 =?us-ascii?Q?z4LGfoHuCqU6Q9TG+YxOOhsNdwPfgFqSu6HCo5JE0Ud5U55b9Fp8XxcppAY1?=
 =?us-ascii?Q?w/oGOZ8a8W8s4pQikYkI9JhinvNeZLAjaWQ0x6G7tgQ1+0/wGbeDzheO9gCO?=
 =?us-ascii?Q?MHgzoeUD9wl/EOPkGezvKLjQ3+/lZCZkCvUZowdzA9M/bN5b7hAxhuKOFXEv?=
 =?us-ascii?Q?UElPrEHOQzKylHD0IUaQ3YbyerG/yQHC0IkSBIBeOdwam5JoJBjQeU5FtZzx?=
 =?us-ascii?Q?z+FCf2xqGeqDKuaBV8mEsF+KgK66EUgXJ3A1edDzqA5KOXpdojGR9Y+NYE1Z?=
 =?us-ascii?Q?sAeUidvyATQu1fwwofCp56rysARGw2zgQrLHFwV85DhrNzh5FLiv8Lxys5vc?=
 =?us-ascii?Q?jw8cww/U1uVdWGcu4/vrA07vWE8ttLqFhMHvRrkXGTpeAHXEDQ0GzYhSUObt?=
 =?us-ascii?Q?JPeUJqXZ4AHYd+iXkp/vbsvNT10U9On4VDaBhu0k8I+qmzIRowgKYqMCjOLe?=
 =?us-ascii?Q?+U+pFY6wasgphi4Pfm0Qlx40xgFiANnQbAU2IMfTbJ3/ZBH2iRLtV6j41fjd?=
 =?us-ascii?Q?mCCvlJReq6y6FIow5eYvIfH7s9Gu0gusmim6rkPbJUalwfQIAX8vHOeL5lBH?=
 =?us-ascii?Q?8wUmwCW27ZgSzVCRIQmnlwiW3dQDTyqFc6OvydGO/MUL5+A1sWAUMFx3ne6b?=
 =?us-ascii?Q?Bxibrnujg6rwsGQjyKWhiD0l/RZpdWIktYQSxhVvw4mTD3wLC64g+VsFlzRM?=
 =?us-ascii?Q?BnSWMlBUdBFlWdXG43NaSapLJSnE6jYDEvZXRpccvOjfxj8I2qJvwSR41lr2?=
 =?us-ascii?Q?3922E+Z8ULtt/P00DUZffelDUx2npekbSn5wc35kDG4tBnNyMwWbKdJRM9OW?=
 =?us-ascii?Q?3/DoLtWpcDoYWzeV2EqV7d+d73sriedaCJcx+iFmhrRU3//pyC1qFUq3r56Z?=
 =?us-ascii?Q?zCbJneqkkMhEI4txOPgr0LC6BmTDy5bg/qPN1i6rHvlfBwZA+O/naQbGPUJF?=
 =?us-ascii?Q?0BSJ/GkcjHspYgKVNt0Wz60gEJJK6fCABiLZAxR72/ey+IGtlHcgMtGNDumi?=
 =?us-ascii?Q?fadiudS00X+N56E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1PRryuyI57csRh3WbUkQ05ybIHqmUyKTu5BvSxyCZU4DxRAKAtNsO+5POHkw?=
 =?us-ascii?Q?CCIbRi10NW/keJibrg7F5/y9Rb+i3C9NOEqYR1jDsyeaOgDDTuNQSv8AFn4q?=
 =?us-ascii?Q?w2p7OQkmBZhh5EaAF5IZt/1MceuVScvIFTlOaCyQl8sPJbbf55us/OLAt4c3?=
 =?us-ascii?Q?ry4JvhUhBf/2AHdBi/FiXkBHuaROXoi0GchJWUFYkBlacNllpzadzqbQN5jh?=
 =?us-ascii?Q?niV9VuqAbdNOQX9GrmAFodXAuHshf6d94NAzESizSndqqG96l6LLauQAcskl?=
 =?us-ascii?Q?LhlxhVj/JmLPzP7qwPyRmXYIdS3AmtoPV1gQHgfva7QdHajBnyOp5agWfK/z?=
 =?us-ascii?Q?1gZrHBjzQx6cNjWKWcPh9g8tagOZfazGP9WmvQ0QqNefaB2WCqvZn3R8OQrR?=
 =?us-ascii?Q?KFpvo3iPLh1tt7tMRhESpQnfnHWrOeXV+RKuvBBQLY7/7MGEdMAlAa+Vr2+Y?=
 =?us-ascii?Q?/KUYpahFU3b2MR8/IvQgJS12d757gtAiAc6HTg9YCVPxGUsIVZBoeXmnppG+?=
 =?us-ascii?Q?o0qZmnmaE4P7ucTq+pdFK+aHmBBWRT6UzZDyTK1hVxFeY7tM89JTJbNKkxZ7?=
 =?us-ascii?Q?YEfROsinp3/OWUQRtmfPFJT+9860ly9C43QOx12uUOZUuj0uNXg3pmHVo0EM?=
 =?us-ascii?Q?jDHpyWfmymfpoguP8svLObwbWyBIHSUz/UEgonSpgAp0YTgy15sRfafEm7Bd?=
 =?us-ascii?Q?2Ye+BVKFhJQYhUF/DwFiNmOkibjM8SGuIc4ew3/dEUsLGJvYZXHMTPf1yD7p?=
 =?us-ascii?Q?l9KiMKSwYy5Wg2GE18x7ig+wdCV4VZLmfMs3yGMyKlfmKHo+CFnWOtz+9kO/?=
 =?us-ascii?Q?+ZNr6J7sDwWO45UKUaNmnKLv0WyFVePTdc8jM4UbW63aMfpalG9JhqH+ltV7?=
 =?us-ascii?Q?+gM4WWOMTHjwClPv2/tTSmsHeCHHb/e8IgI/GNTZA/Hm6eL38E/kSTiGlX0n?=
 =?us-ascii?Q?mG9QJorL2eFtnbtBVZP/I5VHi1A/GU1G+Bgkk/tW7wUw/RtnLThDtCiUEE7E?=
 =?us-ascii?Q?F2PRHvzvBez6AIm/FC63Eyqa4rJAEbDlDhekaO4YJNDAs0Ttnq5whDI/sBqs?=
 =?us-ascii?Q?FT3RNMuJ49Vt0zSGakTjgP1CGZFr2VoUJgWc+DvTjYBsBAKd8gTSDG+U0ya6?=
 =?us-ascii?Q?LOenBYYUOGSbXIpLA62I95H99HssJbuas5uq5X0AOs9nrDk7aGjQFv4pvESR?=
 =?us-ascii?Q?bYZBwjO6wjKFPyxn4G5uJiozZaPr8qppgsKgYVRN8tu2qOBmfrNm1L1Nn/yi?=
 =?us-ascii?Q?KYhkxGgfPcV496NYwkmjcs1+MG+seR/R0HWwMNbK/BXBnpSyiyHvC8MAfY8j?=
 =?us-ascii?Q?WeGRMz7gNCrqs7vMPDqvxvA1AAgSNZ8rVnMIptZytFQphH6hpIkzxuahIm9J?=
 =?us-ascii?Q?eCg2j0LcD/XBf22RqwdJkrgHB9tXEzZfi4hsxw+0GVSeFjUGiyb14IL5dHB9?=
 =?us-ascii?Q?pauEAg1sBcim2lCRWXrN7WMr3ScTQztaeaACFM5puhlbjHC8UDS+2jU+NGVC?=
 =?us-ascii?Q?LTJzKWvezlZ1F1Zsr8NNY59ybkm3ghYaWMOP0PtMagqRYnKFc1ZIJek7TXAf?=
 =?us-ascii?Q?QArsb1kW9qcnmFUOTReszkL+wu4uH3Ih7ElfImVV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f91217-3966-4c48-8017-08ddebf2a353
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:35:51.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4ePWVV585QJ2sq900yMfpnaUHFBVCJnLi7pDOA7glHCBWSJCI+xKyz5VKnWmY/DPmj9ceW8/f3RfA8n7mjNMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

Add a new rx_frame_size member in the fec_enet_private structure to
track the RX buffer size. On the Jumbo frame enabled system, the value
will be recalculated whenever the MTU is updated, allowing the driver
to allocate RX buffer efficiently.

Configure the MAX_FL (Maximum Frame Length) based on the current MTU,
by changing the OPT_FRAME_SIZE macro.

Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
value between max_buf_size and the rx_frame_size to maintain consistent
RX error behavior, regardless of whether Jumbo frames are enabled.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 47317346b2f3..f1032a11aa76 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -621,6 +621,7 @@ struct fec_enet_private {
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
 	unsigned int pagepool_order;
+	unsigned int rx_frame_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f046d32a62fb..cf5118838f9c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
+#define	OPT_FRAME_SIZE	((fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16)
 #else
 #define	OPT_FRAME_SIZE	0
 #endif
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


