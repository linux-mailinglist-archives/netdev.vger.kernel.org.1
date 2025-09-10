Return-Path: <netdev+bounces-221826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45DB52078
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D693ABC52
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50242D24BD;
	Wed, 10 Sep 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Af0JKQbm"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFA2D5931;
	Wed, 10 Sep 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530366; cv=fail; b=TtPXZ5w2UkEh3qOh1+kGPAIUXdvHMGkEPJXb0EsyeCT/9V8uzPRbKFyWjAgoRG2soelvczcEWyLnr2Z4btpn028/h35EKD2ANozy6G032EqsWr/EE4e6Cqoh5lguuleP+bFG3QghdHDvS6DuXlm24rt6ISFF3zTX8K6mvvYH9CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530366; c=relaxed/simple;
	bh=sMug8WXjmhPoJoybqc4yDBbwkqoRFaRkNyhuZLhW728=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Va3QZMbxKsOLojcpzT1FsUQ3q3ZsyntLIOofdtPeJvIiI8Z5gN5u7AupzCM208yNqRaMjCeInUIKNiBwb/d0qlrNxWxSGPZSHdBcjNj3BemGbHzlwentdojtOGd3KVjoADsB9hGdPrB45TQddZsaa2kBBszUDGA6QK5BgSRctV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Af0JKQbm; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoznoFmSGr4hFk96ecVVlG1hACpoP91IIo819b0wnB5aeSVxxCBlcXxnwY6sha476LmSRfELKASUuCPrToW46N605LNNektwyqA82mq0bfudeYxgzZRBd8hsC2Qfvj2mdvrXgs8HiXdWmW8XUCcCLkj6kyLc7KQrW1qZ9PYH8FOrR3aWvcoromfuoogG80/CWxH8aYNIw3KCM1/vl3dEkBWWTptppxFNLOjCn/3sM4GPMMSdw9qZV0otKbUumtiTOtgwCDK4Uu6YyVdlkBBppH4QMxW+WTq9kvNzN1c4PDLLEkDadVQD7nuYh3wtQxhxo8mrMCYWqpkpIs1WB2xjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XcKgxNVTd37n3LYJ480yupVkoqXAm15G53kY48pD0w=;
 b=xp7E01AYku4vkZsIV/pQvaFcg5BVGMPfdfLQbQXBhRjYoZ6/b3LbgYk19FyQT8Qz+OU42VWIf2FfJyLJsKGgOSCNjUxB9sFWcMREbTL4xqHkdeTlLr8jZdFRqj/6S6qioJb5x56xz8IxpjGZMrere+0RPCvviYoOiLTD9M7F3fABMV48JNie4OSQW1jSuCJTUY/PiQc9Yfz+OcMABmk9tzhrykIyOQzcAmT1TN4qgM/h16jhp+yVGMPzuOlQzuGR+7ypjIZ7zI/SEO2BtOwACS8Hh/r4gy3IjKFWrvYsScACUpBQ8IU1VftUn80WP7MMX7rzHUw2/jezWnSx8fwCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XcKgxNVTd37n3LYJ480yupVkoqXAm15G53kY48pD0w=;
 b=Af0JKQbmoonwRWVktqNBPb43vNJTxib1WDI/kxqcuqp/njmQDw3ljKmTiiOF3KnzhiEtuJwWF0NECf87a8Sbqvay9BmoFTykNS5tOHoQUxyaHRqJ5N/gZ/eKi6yUDd8SxeKkLaUeZsWw9eqIlYYwwhomUIeXa53r2ImS0AA0jLQSQN4Idy+zDAIwyVjBZV95FAM9YqUxRV/PnEHLyVjp+PfOuGDUaLIdert3DHcVXP6SmfLf+ZDHdBtpBepyyer/C1JqZpbmgeAa3GQ6VnzSDVhth/uwEioEN2A0JvpYrbes1ipvodAJwFtRuFHdPUnC5b3tCc3uMWcO03pBJqWEew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:41 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:41 +0000
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
Subject: [PATCH v7 net-next 3/6] net: fec: update MAX_FL based on the current MTU
Date: Wed, 10 Sep 2025 13:52:08 -0500
Message-ID: <20250910185211.721341-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef49cc5-fabb-4959-b34d-08ddf09b37a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l817amNoModO8m/w5jAp5Sjav+vGRr2brsH+JeCDxHf0Vru38CrtKDZ3L6i8?=
 =?us-ascii?Q?lgVe8QLbNThN+MpbUHXkSo1OL0DEWhnwrGRVHzipSuor2lv1gTEf8BwkNTCY?=
 =?us-ascii?Q?XqKzCbPkAJh8K3j//UbI8otlFKqV0MVz4JHcJKuB0+lQCO7WMWfqJkbp8jrD?=
 =?us-ascii?Q?ARit7U2DHXAIWUwUQgUN8nryOeqccP5wZdB/CXdKgVSiXGjAQbj17v2V2Z9U?=
 =?us-ascii?Q?apqGWKs89s/GiUfEcFdd4BLgnSAcmcPymPENayK3cb/6k5hu+MEbRmh6+2Sp?=
 =?us-ascii?Q?5Bkm+pw3HPjy5OAcYhr6VXGjF4FNd/EVOjetlrH8/4KwHbNX5aTwAj4ymrLB?=
 =?us-ascii?Q?/M1vvwKthLSNDEwYDGE376RwJhJGRvx64VyM3kRcHvgagVE92IN7g9DvHQuj?=
 =?us-ascii?Q?M5/P6dqVUTLASRx8HPlPpYDn4cBqhOvihyYzHfiiuE5FhcsPo/nR81fJM7Lt?=
 =?us-ascii?Q?Qw0smHVvV4+DRDnYEMr4Y0/d91hthDCBY5fYqKAbtEsr6+frGGJG1f+j+vJG?=
 =?us-ascii?Q?8HkG6l+AkAXc6fNaBdnbLaTLwxpPfDyiwB0z5G7svTGg6ST2PVI6dFKICPye?=
 =?us-ascii?Q?BLT5pix6VsJL4tEfirAvMey849I+m/Cj4prVfg9+NeJgr99jctOUaAGLkt3K?=
 =?us-ascii?Q?nYP4grZNBr4fZADlrCvxSRJlei05f6YkVe26NMZJu3k6/qOUyVmSXpIyb2+8?=
 =?us-ascii?Q?M62V03ltlH70Cl3pjA/ySpoSet77ds084MDSpIL5/GGmgwh6Z9bBpEAx23dH?=
 =?us-ascii?Q?9olyxvBok9jF7hOjBXFhxVO2Vlsb9pGVieaaMmmxe15p8Dt0gK0HlBRct2nb?=
 =?us-ascii?Q?97YYoiamih7cPVjkPaa/8SGH7jl2GFkUI1TAYx8oynhBYiPB+iPxUQJtgZQj?=
 =?us-ascii?Q?BcpNkE3AcKxGwDIL295zdZi7QEjGPsfI/3+O0AAETUfn872pSKcAuTuTsna5?=
 =?us-ascii?Q?u1OKJ+33DnSb1Oy8p4oNOuMXxn/5ka1386DlzRzf3ATaLlae8Mp3LnsIsvTk?=
 =?us-ascii?Q?U3KZTTqJQHcJA5Tg9jQDpPgXUepJvRXNlYmY/GOeKZuN9WRKOV56JgrqBISV?=
 =?us-ascii?Q?gf1knq2orfEHrXY8DcqPibg3hw8ujsENaZ784gTqC5SxtCq5XNkZQJA5401S?=
 =?us-ascii?Q?yjaGk/tv7YkE/9adLI1I+xEnitM5c9ASlooKrk/O134fb/HYgealxl+HHgoT?=
 =?us-ascii?Q?4JDbG9yLTOeu0rEYy8y/Au40GD0hBHyZi3Q9WS3xwWlGcvZgLslPWhMdv+39?=
 =?us-ascii?Q?OSNhbzMdSLZp3v/UN19EZgF7pzHZqeJ818t9UnUgJIuMvctDkESmhqbB+0f0?=
 =?us-ascii?Q?wd7el9SoxjWZAxE1jyvsC/zMfiXDhnFAiFZh1pf/aa3prLfDsGIXCXFOaQzl?=
 =?us-ascii?Q?a63yb6PFnFaRoMGF3ZUZd0MxhWiHnAtHsATFZsQ2ifOfQO2Y9C1eF5tC7fX0?=
 =?us-ascii?Q?Zm8EdpCA0Z7tJrdG3afhR4GX0RTUFICzX6VnZf0+53e1dqkJFmHUj/mVfwyz?=
 =?us-ascii?Q?iRXqXig7tPkPpOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuaGpoHU+uLobGhN1VX+i3SxD4Q09dMDQuK2X0SxEThItWJDcwTPebdK9dui?=
 =?us-ascii?Q?gm54buWMHNLIohlAWjaSRturUOyp3S9pR0i6YENnuMsKy9p6VFMNHlcpy2OW?=
 =?us-ascii?Q?HexFOx7A8ftUyLySQ1Ad3f+aaiaIditZe8Pbf6vUiarD6bnlVtzxNfKCvlg1?=
 =?us-ascii?Q?wGZdHLjYzVOU3eippUTpoI32G96b2mibL9eZRL4nS9gA2xC7Ys1lZ5nykUQ5?=
 =?us-ascii?Q?XwQYkNuAuL7XppXCNc19n1qYJRp9+rem65oRHrZkJ8nxr4uU6AUqscEtySgW?=
 =?us-ascii?Q?LZXQfQ9oU1cpc9LI6Kp8n+HtvCcW9udACnxFWVbQiMcc1G2Jx2z3jNXZHQIX?=
 =?us-ascii?Q?JLUWKHIWZG16e3KxDoB6FmCqDe/SdV4chEzQ2K3O6CcvBhgCq8ib2yw8HXIg?=
 =?us-ascii?Q?BDJbk1pSEKzbuWBGB8TKcvbdSnV/kMQOggMNHLzPRfcjb3MlAgi/B/x7fNtI?=
 =?us-ascii?Q?Faov2uyezE6Hy/yd5iU3yWYZyyfUJnXXcX8oPCFmwBg07fg3IZjojj5/Mm9a?=
 =?us-ascii?Q?lY1WdsTElDEXNocblENmCRfFILrXJ/kC15KGVe3pSdc2luFx2Hn9XGsLWX/d?=
 =?us-ascii?Q?gr/t2OdXaSYbxqNDmVu0o7Vn3ABYnHg+fiJlvGTwWQNxRNzke2tKccEs/s7X?=
 =?us-ascii?Q?xVHKe0YOpqsomMWDwzNpzAkbQbfE98lkl6Rfk8bCKblgU5AVxW9pExKSA6h0?=
 =?us-ascii?Q?nKYMIYkcJzdXJKZzRk0hRPdxh7LC5Bivhl6zfUHtl9VvOPHkMRG6WIPIC5eo?=
 =?us-ascii?Q?2pmhmY98fEvILQBybKvY0yzbMXQUYyDx2/m6lbFyVj0KVcuzGjHgapKbiifS?=
 =?us-ascii?Q?ibivwStpKx29vN3+J2pZpnoczB4hBoYBt/vp4LBrvbUpTOgEnNdOWlkDhR8T?=
 =?us-ascii?Q?EUWiyMJmrbORb/RWTbo7cAsYlFqubOOr55QQIst1k0LJVQjMU+SKH7IAgUjU?=
 =?us-ascii?Q?cB0mnUXvw1tJcZt57+/qNWhJdpznSRAQYiLqaz0ljO5gWTgMwllsJ1d3d3ex?=
 =?us-ascii?Q?Julg6J6fTeGrs0mK/SOjoy5iQtCyhK4WonrMcazR5m33y739nZrcChL+rPLM?=
 =?us-ascii?Q?kTIMdnR/iiamBYhLUCs3NsxjKKnIAPZm5ZGvECwWQ1kjdGN0qz3yEFxv10cl?=
 =?us-ascii?Q?MLbc/vEJz7nDlsrd+6hy4N1+Tf5qqnPumvUeoGqJZZqpeUMYWfXfzRqT2GiT?=
 =?us-ascii?Q?iRqrS3eOW/O0DCDKR0pf6rAGW0oJeDdHOuxCn9VMOtTWMIDObqx2GrKUWxsh?=
 =?us-ascii?Q?uAd/DI0Gm5lxqb6ixET/LuK8WGlCSkLxS/q06TBaxFkJ/z+n8Ef/SvzxLvLg?=
 =?us-ascii?Q?jRzISZXSYnZj1JNoPLlnu8tN+5caRJwhS0sD9TW8Sp4xnIsJ/uFcJ69eAWAJ?=
 =?us-ascii?Q?k4vf6yC1Osx44coLaLRD00vu69AOTLuAx76LaUz+ND2leHTxYzbihaPPhr5W?=
 =?us-ascii?Q?WZZGktmdeVSAPzd+nwaVKBT9a/UUy8Ytvn6lWUr6rxPaldggRXXNsc6U2cTM?=
 =?us-ascii?Q?08O6Ttgo3oMcCxaBJHfkd/zBhYqLsl8lKx00+tkBTGHJ2iYbdXofYul783dg?=
 =?us-ascii?Q?U21JIJbZz6IpMn4sSyKKl8C/HCRyq1Xi9uhqWYqW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef49cc5-fabb-4959-b34d-08ddf09b37a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:41.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5UNUwZI49+HjlYaU7nPIGPNWTVWqvW0tJcyEFh+5abfCDRaSt4cVMtTMg/KkGVaGtcnJRzfMOXewCBHsTNSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Configure the MAX_FL (Maximum Frame Length) register according to the
current MTU value, which ensures that packets exceeding the configured MTU
trigger an RX error.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5fb9afdafec4..c37ac84ab956 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1149,7 +1149,7 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = FEC_RCR_MII;

 	if (OPT_ARCH_HAS_MAX_FL)
-		rcntl |= fep->max_buf_size << 16;
+		rcntl |= (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16;

 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
--
2.43.0


