Return-Path: <netdev+bounces-215756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EEB3022B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC899AE1C4E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5534AB0B;
	Thu, 21 Aug 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FvF62Yy4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18ED343D9F;
	Thu, 21 Aug 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801263; cv=fail; b=IkOpZ68D8dA3pwx/Ix14KgpxDBljVvDuCv1A8FN3K8VrD4Z7UtjGolzaPHLeTwqBbJ4RS5qcPvhukPEwbSwtEyU0T5rQ9T/Cg9OoUZCdagXcK+R0ryxhhlBtmtaRF8BYJnkJtpgndYPsnY7NWPZCMMKnBlzkWbmbcdZ1eBCc9IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801263; c=relaxed/simple;
	bh=PDJl7xCNZl3Qz8s1R+H92wHnU7d8A2wgmrjlLYEqUYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnEZ3rtdcC0SzbZMHMWdb26aaa0MPRA1PL7kBW75etO8Mu6f476a655LalMJlPufvneCKaYyZKEI0DlyuVzUIlJtumCdv26coeBnm3WeZuZFGonP14aMoxcz4HaP3Lu/1JoXa8a5NuaJ79dyefGnN8hK0I2BrrtqQVc9H0YC6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FvF62Yy4; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOVnQcwRUCI72NhA/fy+aLm0JL5yhBhAN2c5t/XjV1fe1284IfS+upxuVsT899buHZAG5L//BzEEkIHSi1+SPaLMNIzvgeL3SapHgcM6mrpyiu5ciGqKtAis2WcRZ9+iG3nVDooUPVNl8BAO8RQRVC5RuvzEtRF4/CCH/9rroIs5dp80iL4nXPVf7RmGzTy5ebQc2wAoLhfhO6n8bf6VF9fQzVEhQ/Yq2RtlM2fRjO5Bd8wV6phJm80bKbB9hUpQRkIAUnVXIC+2KOqyie7vbBBNhvcsFHjcO/fQmCM3fzlIzCJ27TrEXm84oWzmmPj4lribQaYqxkIt204zV1I7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCM60QLJxfyV6/kcoKQwXNjS9rdCKvWDw86KHQCpzgo=;
 b=N1IvZueqng2qhC75B1XL+vr62NxjICadI5q1D4I9E8qCvK9BSijBtJJECpOUj/XjfSvtnBE+d0MlCSQrRsUpzTZBPB1IeEHjUpvHISz3FyExP5T7aZNwJaBFBYQHGY3Dh0KTT+6brpPpIA7LfWHWsOArx2ulVEO8g4pZkpPbhpMNdvkjtcBzPyP3YuW9/Zo3jWSGZRLE4o+1NNpj3vOlWfiBLZVeKNPormW1TNz2IULIgIZejylHj+o6066LOYKoIeYuwdVLmfYk6DKBEOCYNHMSQZzAMmvtJ5VR9RV662h2Gf3CStFIAHtDKZfR2hDi1tPCg1xCaXYgwr78xiLu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCM60QLJxfyV6/kcoKQwXNjS9rdCKvWDw86KHQCpzgo=;
 b=FvF62Yy4Y0U+c0bWh7Ctt8ZOURx8kxPdxi54lGP7EJteD52HmfPjIYaLX0Oa9tWn36A0XD8/99eva67G3z3YNmMsg1o5NvV6w9/15rbK+SL1EtqkxkHYmJG5nhvLHdjnLQgVP13zTFD1tVu+keNLlPXd7lSLK3q1DNuPetD//4D3MRMIXav2qku4mIcNbSwE/wEpb3N7G04ViGMORyz864HggWwM0UG8IttydDaSbR72Iehs86H2oQbDB58xgUfLpvnoC/JIKwwEhMT0kCx28/A8YEyPkKKA9D0fl4HGz+3CprHboUnXdWZQq/pAdulYpipV6WeoA+s5o6MFK57KbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:34:18 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:34:18 +0000
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
Subject: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support dynamic buffer allocation
Date: Thu, 21 Aug 2025 13:33:35 -0500
Message-ID: <20250821183336.1063783-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821183336.1063783-1-shenwei.wang@nxp.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::21) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 724d1542-a36f-4617-4b20-08dde0e156c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKzcOBcg10egGUibHH5Qw/HvpVu5hdgPJG6+EnGtjjCErcWKGHaPrzsrRKbQ?=
 =?us-ascii?Q?JTqIAj5LrOgqZA+IOuI8Ikce/chPOf6V4xQTEiqaBAF3psFkn4pxW+ezbWHD?=
 =?us-ascii?Q?HTdr9z3H1Jfdd6LnFCpH7d3jUnfiGg4UR/kFOWEpNoB8Dv3FFNQq5FikiCsB?=
 =?us-ascii?Q?WzIHa6QNY3WltcZCZ6KFODkf3T61opyc2UPb2tXgfFOjzIQ5s/UhGrdJwLye?=
 =?us-ascii?Q?m3dBDNwh4STzvLQ9Odl49gdMH7Z6nh9zLZdnTq5Ey5twfP34rWy/3m1CFTB5?=
 =?us-ascii?Q?lQs0vOJzZmXhbLKQcdCQv9wiA0rVvWRQp620roE0K5OhSgSdAgrdew40eIfe?=
 =?us-ascii?Q?s5V8tbN1hEEfHlGaHXFYJLMgRi9vs4OFho+42ldoZoGWmZvcooR2v9WlCFM3?=
 =?us-ascii?Q?dt1tDPjR69ilgAi1h7gkHvn3fTKbedcgDMms6w/anh80KQ7Q4V0Tw8RRJViN?=
 =?us-ascii?Q?ADdaunSHsyj9Hwj/0Sl/FrrKPXf1vxozZWtIMXACkxpZfcSkCc3zZLrM3YbU?=
 =?us-ascii?Q?bY1XGQd8LLwD4ohtmhW2S8or9VDn8LsV2ww7ALuMK2IvTJ7+tfsuXa1mOR4d?=
 =?us-ascii?Q?vQGQMqE6c2iACLQGx1MxGjuLYZPvzyTOjPj/USSwvWi+GA1MHJTaXs2kEYEe?=
 =?us-ascii?Q?lvqv7Z0opCD8BaVO4xocGgKpUxcf2pILdLspRuUMHtft9TLpeF8ygHmE/SwG?=
 =?us-ascii?Q?ll9AeqeXnU1ab7RY8dRQBC2+Y8oZXYAdAGNz9vABZ/WBqFvJaZ4sTNI8cRcF?=
 =?us-ascii?Q?063bxwQvBT9849qOpoAvDStwSSyJLiqL+STa0oUWq4NlAtZxfIafHM/XYmXp?=
 =?us-ascii?Q?AQG+pn2LntfvMYsLPspmh6t2aBqTX4/4QpyZRm2iR+KkpPLW5MZSRRzfIwyC?=
 =?us-ascii?Q?OHXhrXLk8hFmfz/nWe32qQS1cLbMYzPT6PLLqCVPGVWB0pMocccsZj1KMas4?=
 =?us-ascii?Q?I629ULx1VYgcoitigviI7e4Kdfh8lCnOlU9MjXAicZ3t6paIUyDnZldjYsSD?=
 =?us-ascii?Q?dZm2kc4hUhvIRhm2ztAhFt3hONWAwI8fTy3HNue8osKcrcW7WscfMDC0Xe9m?=
 =?us-ascii?Q?0UbMRAic49bE+pntAfH68mynWBvPQVTZYc8lLfyA3Ezvkdy6JqxkyjCXJLwB?=
 =?us-ascii?Q?MyP+U8RoR9BkQ4Mk9OQv2fbEfkK7ENZcSESoMC2D+Dyd7Vr5t0HCGCqKGoaI?=
 =?us-ascii?Q?QQa7HrTgAp8Wg+dne/iKWhDjS2PyU2Yc2LSrrk/w9/wCRCVs25PsZPrIFQfJ?=
 =?us-ascii?Q?czZ1kw73PTuLGwNnaiRfLXa1dfsV/B3ZblmQKIJI11yUWv2wGBUg4R0sO3MV?=
 =?us-ascii?Q?G/6d4eDDliwDdadsYlYW2LJ/js+f+0g3oKP68ibkJsQMU7z6d2yxbGtDdHds?=
 =?us-ascii?Q?cbJ/oWMFnEB8gOoaPqLv18rkZqGCaPlZN1way0hR6n01AFJX/zBKtcyNHDTn?=
 =?us-ascii?Q?3FB81OVIhNXzS660Xhv0piyC/ilBr+go1QmJvL9Rtv2FfBIXiZVjNbkaguBJ?=
 =?us-ascii?Q?r73kcFsRwRCT/eE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4P726mDVoQy0gVeLO9c9kuMdk9TTWL7T25FiVcLh1rA3FL3/vxVKVvaWS4ag?=
 =?us-ascii?Q?muM0ABDMSMRXBeqD4Qh0KsTwe8mgtPWHqLIqJrWiFoXBiYbF5ZgWF3wFVu/Z?=
 =?us-ascii?Q?vupvAjo2ztEJ0EgdNw29ZoOA1Z2wWIVzAk4soXHr02Suj/ETy5ygdual3z8N?=
 =?us-ascii?Q?VrAGx17wpPFDQNvWvtXJ759r6Mxuk3krRKPV97xWKwBgPODkqI4GM6ELwLPE?=
 =?us-ascii?Q?QKJ+f1fcDAj8dVPA0/FH/rmtgdku0032LdiOPmWc6pLihmrZAc8pxGP/uw0A?=
 =?us-ascii?Q?ekmTia+oF8R89p3YuF4gqeNaWfZT1Bh6ql52SMwZcHrxZa+LOjHyBzgx3JYU?=
 =?us-ascii?Q?n+nGcLjJN5esfGzljXgyuAIN5AFSsr/KvqH+W4hyNXL+vmF4m7kZJH5K2Mzi?=
 =?us-ascii?Q?KDEdG7iKpw9q8ZunQt8pGoEEIycW97PEThbbRZ8ra8BRSkHASZf/CIs/ORaW?=
 =?us-ascii?Q?2mAIroSmJE20bZKblqEXSWlaawSjf65xJCOzabBnwCvbaj/nvpzQpDJoYLCf?=
 =?us-ascii?Q?FwHbxiFLkac6oydHDISeYmN3674Jl+Q+N91XTqVbAoQiU03uuyrrIzD5vtKE?=
 =?us-ascii?Q?LqxCMGbx0TYEFwqZ2Qb8N/oHjprDk1DRPnpW7O2j4TwOpWyMlT0BrKka7YCo?=
 =?us-ascii?Q?2m+/ng8z3SyeMVzFvflhZt/G5tHuaOiBgfzERLM1ARFpo46I8QywN2G3sJNz?=
 =?us-ascii?Q?2LfuZSrR5iXhGkA+UEeEVv9xUmQ3YaiLkzrZLRUeTcKJKAf8G2dRTZFoNk+Q?=
 =?us-ascii?Q?KZ9XTjus9JLK3jq5EYDRcLiIRBAoTTEgcUfb9t8dFkcE56+GyEnRatmoXFt2?=
 =?us-ascii?Q?52goJfTmIk6BULcMQQl9BtFO3plj2RjOxc3Jojn3ebp8Q2/0q3BgHkbXN5Jh?=
 =?us-ascii?Q?UJtg6npD2nKAwRged10utp53KHMDR1clreXrlEu0qQ2rCL2T+0EO7n+cB9nA?=
 =?us-ascii?Q?BmASE/aKkQMda5K7H0GNxbEOp6W0xjLrTwEdyq3RRjk7gH1uYgEe4cjoGq+x?=
 =?us-ascii?Q?UBSFOUJFurmm6OF/M9V5czr8V0sAOCeU5FAla4GOjgDcQMbiFbnJ2PQj87F9?=
 =?us-ascii?Q?N+j2LchWJOtHwLHMBGEVxNv01L8EZbR/ODYqPzEu7BZp1VRV0DrWkWSasJDq?=
 =?us-ascii?Q?7AWbiSEMclnzH+TnuDxAEq2RaDYM+FKFQCOQykt/2G1LvHXggfgOZIVlsayQ?=
 =?us-ascii?Q?5uxR0g6JtYnfgk1vLCvdXEIbZrMH5yNGDJXBVlKMJMZBS5q5TP4Y9duo898W?=
 =?us-ascii?Q?FRyI5GUrFXphwv+mdV8MtP7IbWaZF3ZdKlrlTGcCJDnZrE4D601nB2sOJOY6?=
 =?us-ascii?Q?3vkGzkwwo8fev+UHUsoT9Zi4BBoNcQpCKhAn3IXvoxHTw4IeP215rf+He/vT?=
 =?us-ascii?Q?4DrUvzzrcQz7dNu8gkicurv8YT21LwrtrY2LKuYGh5mJMqBeNi3HlvhnHvmI?=
 =?us-ascii?Q?gakZys+B6eM7oUHlER0KZpYEUOAEvGkav1kv5PqrcFwfm+GYpTy9xUxv0AkL?=
 =?us-ascii?Q?0oEXPv+rwTiGTkpeDOpTjb1YKacrm2KITeitCJS/BMNrReCIx48hMATqyLLU?=
 =?us-ascii?Q?f/Znxw7JQTofFpf2i+vIWvi+C0fsQQqkvBoA8mnO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d1542-a36f-4617-4b20-08dde0e156c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:34:18.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDiW1PkAmgbQ2wXXdqlml21EuLu93olGrMoeUwCv1b1M5x93MmP8PfJwjh7snvz1YSz5YpDrH7SM76gI7/xB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925

Add a fec_change_mtu() handler to recalculate the pagepool_order based
on the new_mtu value. It will update the rx_frame_size accordingly if
the pagepool_order is changed.

If the interface is running, it stops RX/TX, and recreate the pagepool
with the new configuration.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6d0d97bb077c..aa85a6d0b44f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4023,6 +4023,49 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int order, done;
+	bool running;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
+	if (fep->pagepool_order == order) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	fep->pagepool_order = order;
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
+			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	running = netif_running(ndev);
+	if (!running) {
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
+	fec_enet_free_buffers(ndev);
+
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	/* Create the pagepool according the new mtu */
+	if (fec_enet_alloc_buffers(ndev) < 0)
+		return -ENOMEM;
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4032,6 +4075,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
-- 
2.43.0


