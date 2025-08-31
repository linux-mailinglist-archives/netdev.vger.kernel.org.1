Return-Path: <netdev+bounces-218578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C4B3D53E
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448AE7A9FF6
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E0275AFF;
	Sun, 31 Aug 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rh6zXvd/"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082F274B5C;
	Sun, 31 Aug 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756675008; cv=fail; b=S2iebuRRokH1tnq0FlqdR4677L8oVdy6UJVJFJX/PNCAO7zdYCjCtkMBDQ20pELe7eb+s/QGZXPq9e1eivT2e+2gbMgP/44o6SEXSljseMFf43NAOtjiwEwiQNrQZsRFkgfhFrAIe5XzIYAchRbi0ZR7PdIxlrLLg9b2mj1E948=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756675008; c=relaxed/simple;
	bh=NU0V1R3T9U1CrxIkgjO9vfZMcIhOzn49b1Mk3q5w6W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bq6IqmqDKgc14o3k7Z9QEd7vv4WZTFBLx4jiwUa2ACl0QAdKZdp3xAqstev+hCyHEh7Rq2qQQJMdXhMUVgGzRPjTiewIj1FReCDcHjE087BF6DufYI1JEembGsBYu/gGb3FVKK6gi5isHIx1qju6g0XIgLU1k5TJvyGUzb4FPHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rh6zXvd/; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrM6U3SKkB3xvCTY3LEo3HKz64xrwZCj5oLbgI+uU0EyUgOcxawc9d+oY5mP0fG89IWLZXzQeXvscdEpu3jTELNR+V+RYJzXzMQx3A9nvB0E4H3AoFkZECvQi2j/HHjhyxzK9f+R7Prim7CWooT61OgDMcAU0QOVexUBdmdDdZ2/lsUaOfakO9kywM4V7s2V1cRf8+NZMJAhkWB9OaN0Hzw0zHk7OFcqC49ljb848dDzB6eeorUOJ2Z9PzlOl+cWjdnEOgfLLLRJKXDedPTOBTFitVeh1VL7HTN39PXUWbnP5h1fALDK8CSceFkM4UzIxUo86A8IcObK/3OdOeu/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zMl6VG0IeELyB57BnlfQ7x6JeV6WuAGkQHPfjAlHg4=;
 b=B+oqJLXD72i73lWbtG4h1nrV72WZ524P0xm6lGwPTNyS2i8VtNrDIzSB3KIwJuyqTiXvggouByqQGMPoCLRp0/Wp8q2TCMqQV3vq3SC1HRNSIKDxwrld4oGmwyfNllVAfQ7yIVdtl/khLL7hjg41wugCZ7jlOtYBY6iLYyuP1HsAE+eZGw2OjwT36affuY4ev7MoPXBsXKOFNGBW0Hpst5Agqf80U9fyYFIHF7WmV+rWhP7O8dX+CNoFjn7qOMufUKGB4fXQWplvj1Q9JB3gvvNpO7TCPzFf7cQZDqif2SRVB+35xf4xCeOIxhMmOfbj0lnL7e40MeGVxr+yNGfbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zMl6VG0IeELyB57BnlfQ7x6JeV6WuAGkQHPfjAlHg4=;
 b=Rh6zXvd/QSPZBz/uggam7iBa96ibBzjBFRXegoR58Fk3ZiSVA/vsZkfxR1N5fmLAaSalvdIvlANwiV0RKyoCNEk2agPwr4kAtchS6y9LPYHKCVdlyAaRQDZ+UVs827Bv8OAfVQ6GCwElnTrZ4bxDmYy4elWIN4rm0lesTuwk6LefXjWaQhD3w8pnJKLoUzakuBUj7UoIAxt7AYiae0AzF3uSOxStgiNY4/gab3rumPJ0/z/tE35WegehbEpeHLkCG+hKDbuqkL5gHcV8VXgZP8lj0qMX2euhMjxsJK4H7Ku6ZEU9bXwezc+oc9gV8DYt2ARl8vgAOvel3pY99KCRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:44 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:44 +0000
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
Subject: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support dynamic buffer allocation
Date: Sun, 31 Aug 2025 16:15:56 -0500
Message-ID: <20250831211557.190141-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831211557.190141-1-shenwei.wang@nxp.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad803db-d706-49ab-55f5-08dde8d3afa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPsJuy6v1pRzfZ9/lWglCjUkt6A6LDZclq2YIsER1sOgRzf5erhWotnC+cYI?=
 =?us-ascii?Q?iIg23diaSCG1+TmSR2H2XijGFTKUeqa70cJW6hTF5jnhQjzfeuMdQ69+fj+t?=
 =?us-ascii?Q?0SoD9WpzK8wslpVUdwF9/4YTx/SAihC4wCiN/c9zVE3lrkvIi1rKN0u7cWOm?=
 =?us-ascii?Q?JJaCcPZQdztknqSpInvJpJdFUUs60zDlfWRY9p4sA427R350Rp0/E9L3T6c8?=
 =?us-ascii?Q?ttamP4gQbhm3Mv1jVablzVlf0W3IguWTZ/zrxcRDbtqqoEfDVSBqxUcIRtPU?=
 =?us-ascii?Q?u7M0dmwy9Ea0c2hb+uoHZWkicyODop42B778rvfKbmXkbHxFE5pEH8HGqV3T?=
 =?us-ascii?Q?uxX73qOEgNadgj8Gr0yzv2S9VS6kB7uUkNGAnNU3xRUrWH9iYuVs/U8ldeju?=
 =?us-ascii?Q?MZ/3L1uTc6tmas5b+k75CsEWT5gW35ceCkApA1z5vG+CJC2jUQdZ5AvypC/D?=
 =?us-ascii?Q?kjr4WfK+qNXwBUbNJIIwLrc+D6Abihrgvm/Ks6lkef8n2mBE9jPepxhLSj9k?=
 =?us-ascii?Q?JQM2ANb0+m+i3hoQdIMcZtt6aEd5kjQO16TaPmsH3MKxL40CSP/Wx0vPwoJo?=
 =?us-ascii?Q?FWVEUTw4XStUaDwpLJmtc15n3nTJGB5BY4zbyuVqKutGTRHxcFnKdu4Vh3Gv?=
 =?us-ascii?Q?60WegY1kfa1JTKuNrYFbkrODoEkmo82/yL/r4ulgWwBdMv5qKfw6KmenrxMh?=
 =?us-ascii?Q?lZmoehwalcGHmdjO0D8AhP1fGMExo0gbPyBzWZ/eFB0SY2ipxcrB8E9TUYBp?=
 =?us-ascii?Q?xTinJwSJih059zOhlc6mIbF1aGAccIfPGojhr82DmwZphb3WzebFBMvEahwt?=
 =?us-ascii?Q?jsnf/EFAEEWD0Q5i4hhjrtl4WyVWXvFJsOl1ZF05RaHfTpo1QOvf19rkBhLg?=
 =?us-ascii?Q?VJE5IjhVleECts7pt0iqc3yHaDytdJP28Kf2qcFsnNVtiKTMt0i/XKVQt9KX?=
 =?us-ascii?Q?RHA4wLEgyghdnTs2qi3vahZ9Ildr/K+90I4DHO0eqmGl2mgnK0e1M5BdK7f5?=
 =?us-ascii?Q?oqG8pbi4HpSAkmUig/3y8XtofQVGonlMMOgKQo7PFXV6f1hGmOnhHgFpIKGs?=
 =?us-ascii?Q?RPKHZmTrSEKdH/M4KPvrIupld7JZAI4V4zydbuA2kAPu7+4FpqOEhbhYoY7v?=
 =?us-ascii?Q?RWm7imerTGqONrjLsZqE/EGzJWZpTYfV81+XL3vesnzIDxHxAEeb/nGnu4ud?=
 =?us-ascii?Q?aj5G2daH+laXxMZReEeKH6RHu0leT0ISqUJ+qjcN+A86AFXbJXodCc1in2rY?=
 =?us-ascii?Q?nsOPBshW0wnb4F/ZZCeLL+0wn2hvueFcHCLrt+LEavW5LOFtwf8YpEhAnyYG?=
 =?us-ascii?Q?ER9k33EWpYRww58zQLEw5DQKYriXhoqGh8u+YKQTfHvMv5yOyvJZ0H1xP/te?=
 =?us-ascii?Q?0BLBg5XIR0AaL9RcGNCC2nIF2VM39cVirKxmgPQ0Dr/cu5rfKnXFj0LYUDO+?=
 =?us-ascii?Q?i8TA1UFOe9dgELOIN8V9qadFFc9N3FU0P9/rlGd8kUWDjZBCkP0u95l+5P+q?=
 =?us-ascii?Q?BISBumo9c/QD/L8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwVJkCSzKU3GKDDKrD4QLQfouMIcGH2W9ni/U5esyP6IDbMTVJWOfFOm0iBG?=
 =?us-ascii?Q?4SN9CpxQ98TVUtiOnsgnOwTsOo4IBfomM90mbUgvaDtYJfZSyJkLeQ1Cm138?=
 =?us-ascii?Q?TMClMDrTQzMMMZobzR/kluVNmmmmxkOcGVRN/ktJ5XcgLzLu0t5NSmi1CSMc?=
 =?us-ascii?Q?1pcS2xeRNpcctdb4CIPcRF4DDONG80OvaNI6eW16ySEpbcpOTqWI2E4ZW+AX?=
 =?us-ascii?Q?i7ojoU53q8TelXxGr0rJdMTGn6tFZxE+R5qHZJ6Y4drdBf8LGj84qm7JcTtt?=
 =?us-ascii?Q?8P2HIksJ3SnsUG5OA3V/l4Zfr4gfkJBGYyf1LqzL7PXHuEyrqJ8QAPaAEuRx?=
 =?us-ascii?Q?daIH2U2H8cWZHo0e1Cv/Y9l98oF++xUrnBC4xrE7sedmnCjd51X8lAm7NGSf?=
 =?us-ascii?Q?0Gg3sf1mXD4fmJf57tI2qvW3MYAth5x+98nBOmcwEPapIUCpCzeAw1r2/y8L?=
 =?us-ascii?Q?K7DSVg+np+B445kjgqgx5vODkV4Kc8rCflEf4XSw3rnNYMNDcyf+c4k6wOMm?=
 =?us-ascii?Q?RzKUyPwfbD/Wgacep8XRrOfS4FrlGmKQwp/BwNLPgMM9tkq0Ua/iB223WFSS?=
 =?us-ascii?Q?nlqs5Aw5cJzKd2mZLDB8KrtHwsgTTIr+5E+j2EjZwklTz0DVDo8xsHrW3vfU?=
 =?us-ascii?Q?9WluOzSixFTsQMsoxLrncI+7oVPL9mCTkZPuA5f12NwhCKjEox86kiHGJXAj?=
 =?us-ascii?Q?VRI1c1uyjQX89N2hhPuYhXk/sLo9a8Wu/Cspuck9obWVI8hYwwDC77pZs13+?=
 =?us-ascii?Q?vUKcUtcLlo4T6Mrt/dDIApv6fW59DzEsu4bwWa6lRua8UMDQwFzhUFhjdk+c?=
 =?us-ascii?Q?Ey91aeJX4FZfgwzCZPNPFe/Js/eo4ixyzQV/d4yQuHKTe/6/p6pGJMGSewYb?=
 =?us-ascii?Q?nQAjcFllnWxNUq5M3e9j9F8/bv79uKoD/1TC6+QVBupE+AYmxrwukSzvmSUh?=
 =?us-ascii?Q?5zPQvtwPTlV/oVKKGPpYf2H5FSjV0TVmw3PFHdFufpuFgB7AdVuH3MLDKWv3?=
 =?us-ascii?Q?1L9EZg5FLvADo8RNFeylkt7/YxrxZMHrbO3pEnFFN3EnLKwXl5NfH+ivah/s?=
 =?us-ascii?Q?36rkJjqtNIOn/pkj9AZdNQWUaUdb8rT8XF1097mimBSVIU1U/fOrjuCSU4Rj?=
 =?us-ascii?Q?TqOlD6BPtdtEssnecblLjZ4lBC5U3ifjoQt8igh1Bhjl6JjXT7HLzQHVyOJR?=
 =?us-ascii?Q?Pkh33WKyHgYE6dFiUcxpe5rGKcOUHnmuqBIXYxbK3GbBenfiyv583EzdFhVq?=
 =?us-ascii?Q?qZlve5wACFdv4VlTAaIkowZbQ6wUSIGYhbaOK44cA6vnTdVNYqRQ2+/Pc5Ub?=
 =?us-ascii?Q?kLnlkL7IEme76atYgw0SpLko6bxvRFzsE5r+u1NGybyIud4MYyE1/DLunNt+?=
 =?us-ascii?Q?SGmzM6JgITfBPVQSGuxisJPiFNSUs7llY9bU/9yrr26ZreBT39uJ7rEvV7Is?=
 =?us-ascii?Q?BBPUj76yDqRA77KhovsFZTdrcmgqt+bcyuP9RSK5PRA8+KtzfFogLtmkBNsB?=
 =?us-ascii?Q?E72t+n6Ycsf0CK96+EoylqRzs5hAHQ4OnzY6S2rRi4H0DMnP4aX1wmcmv19o?=
 =?us-ascii?Q?DukCyqeZoeMzNbsBJhlFzhYGbVBTrMpvWDkuugMX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad803db-d706-49ab-55f5-08dde8d3afa6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:44.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51ha8Bt1eBfxFtDvgRGwVHnaESecFFhvf6e9xkz8XvyhG/otDo8V8RT1Fx18Hovb4y6JrGus4h4NGFz/NfKpPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

Add a fec_change_mtu() handler to recalculate the pagepool_order based
on the new_mtu value. It will update the rx_frame_size accordingly if
the pagepool_order is changed.

If the interface is running, it stops RX/TX, and recreate the pagepool
with the new configuration.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cf5118838f9c..43f342dd9099 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -233,6 +233,9 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define FEC_DRV_RESERVE_SPACE \
+	(XDP_PACKET_HEADROOM + \
+	 SKB_DATA_ALIGN((unsigned int)sizeof(struct skb_shared_info)))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -470,14 +473,14 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = FEC_ENET_XDP_HEADROOM,
-		.max_len = FEC_ENET_RX_FRSIZE,
+		.max_len = fep->rx_frame_size,
 	};
 	int err;
 
@@ -4020,6 +4023,56 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int old_mtu, old_order, old_size, order, done;
+	int ret = 0;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN + FEC_DRV_RESERVE_SPACE);
+	old_order = fep->pagepool_order;
+	old_size = fep->rx_frame_size;
+	old_mtu = READ_ONCE(ndev->mtu);
+	fep->pagepool_order = order;
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
+
+	if (!netif_running(ndev)) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	/* Stop TX/RX and free the buffers */
+	napi_disable(&fep->napi);
+	netif_tx_disable(ndev);
+	read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
+			  10, 1000, false, &fep->napi, 10);
+	fec_stop(ndev);
+
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	if (fep->pagepool_order != old_order) {
+		fec_enet_free_buffers(ndev);
+
+		/* Create the pagepool based on the new mtu.
+		 * Revert to the original settings if buffer
+		 * allocation fails.
+		 */
+		if (fec_enet_alloc_buffers(ndev) < 0) {
+			fep->pagepool_order = old_order;
+			fep->rx_frame_size = old_size;
+			WRITE_ONCE(ndev->mtu, old_mtu);
+			fec_enet_alloc_buffers(ndev);
+			ret = -ENOMEM;
+		}
+	}
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return ret;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4029,6 +4082,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
-- 
2.43.0


