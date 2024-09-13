Return-Path: <netdev+bounces-128112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9009780D9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9482B23330
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3B1DB93D;
	Fri, 13 Sep 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/xsxTtl"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0C1DB547;
	Fri, 13 Sep 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233345; cv=fail; b=ZRWMr4xd3dmHcLRtQOwbLYqxYeAL7a0Fk2jKaIjYjYIR6bgW+TePIoQESpcQIIJAlfJfW3+6cz2OO1zWwLuG2scmh+C7FkQmjvuYM7n5T13/sTkhSk/y6kgc3A4LED7QrY8tHUpShZEbKy5ox8ZcveZTRLrlV20ys1rbi1UboMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233345; c=relaxed/simple;
	bh=oE4GIebNruOquM/to4+TKpsHL8xLeuvg0WhH1ivlZvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECY2MgBBWgeEgf8HsQOshwMLyTEjRa1pdNNIQY7BoAlO34C30yX9qi7jjRPjQ+TZBwcSK8viRVPpkJHaBo4UpySAKpCMT0PfkgfwfilNOUaX4iGOn567larvfHtBCzlQkZHuSFjv0zH8GZgmmzwX9kO6LlCxz1W50kVIPafXN9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/xsxTtl; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnwZv2kw422S33rwxfekWJ+EYkPgTM+KLZA2jyK1Ez8vHsl81NAHFUxJetC3E9ryCQlQk5aRHWqUwPVjbAw+lTwy/nhSKFhFMBmIVSQPoQCJ3AUc+LI+AaEtY9loyhtlR1VRkLl7cQbdSeMseXYv3awct3APk/tp/l12vFFZh926j8MOEJQK4K8M43rTbVLfDPp574qZVWyqrWQhR0ShFARdCUpApioqAKU/TzjkMiuzLaoEbq/hE07COSAyw+cBBrHkUYnQbXkxtCXRxqJXZ9968yLFpr4wqO9EhgvhDlDbn9AkKN2aBUR7JWiIVNiQuMVvEam0AhUzMYMM5mlBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwOcq3KLsAa5C2pQ+xwbI7hCpo+OW9TC/dIfZBFRQKE=;
 b=CUaeMymkIopryz7ruQhakn9aW4tQA4/ucDb/fjWuxolLkLTyCAxNTGED6spuYApG4mrmGQ+AJZJjT3lxWmtZWFpR3tvboFsIekxv74J9Yr3mSXeWTPhCl7OMynAhGSVzS7BXUYLgynpc62qp5sX1ugWrvpdejPpXL29OtvCWwYnJKFygA9XVPF1V0tMFPJcx7Xse6pvsQcmNu+htxsWaC1w0CuDXpoPZGPNduBLLHbJ/R0eKVspiAweN/AOybVWWHSLTvJMLDAAhvmcFzeWy8Vfq6/nt/rRdwJI/l8oOtaFeQy10w6u/xM7L77x6KmJTCsF2Shm1gmJMwdWMZUmpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwOcq3KLsAa5C2pQ+xwbI7hCpo+OW9TC/dIfZBFRQKE=;
 b=B/xsxTtlhlpc/KNrVo4kGro5ESCjMWhQzA8vYoJtdWQ3/TAkuPQUCLBdWdUf/xTtogY9KL7WUbAwpO6jnDkH1UIKmZtRO5aeZk8tf72Ymb53oZBYXulPtt2Hh2ygkd8aTkeIIaQ6m2D6NKvvBvth27W9KRFc1xSWhFyDXAXXy3OYS1r0Ck+IK0M2LFYxbiGqUA0eGmDaMz1E6QmBkirqDWXpp8fvXKTmspQ2UNQswe25U6WE3QODbvss9bgLUSBKGK/HIVrkaMiTJoM+tkynIpmS2Y7fk2SqC+w682HrxKoPfa6Wx0y2p7HsCi7KUWZuUIh3/G0gENHJQavNUlzkRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:15:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:15:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: dsa: populate dp->link_dp for cascade ports
Date: Fri, 13 Sep 2024 16:15:06 +0300
Message-Id: <20240913131507.2760966-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: bba1e107-1846-4ed4-35da-08dcd3f6296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVza3UAeedVrh53yz45FNrpYRDGc7kDLuM4RkjFHxpk/39WolJbj7r63tXRf?=
 =?us-ascii?Q?3rG3G6wX3csZBLfagsP1tOZeOxnGVlpEHDer2cjwl2JIlu3wiQXvEg/watME?=
 =?us-ascii?Q?DBfPfbcKSl5R2fm3kE5ckS5am08lYr83G+4B8sWQSr7Gj6FdPrHnCzz/N41t?=
 =?us-ascii?Q?/dGaSz74EfQcf048seHTOr/uSxkrVqar1ivNbpPdr+WzDmePyP9vMuHFzKQK?=
 =?us-ascii?Q?nPOsM5NqOPhPs4FXTfIL8ucnnK3LCpBFr5Er9m6ZOUG43OzO1RcwXw6GBF7Z?=
 =?us-ascii?Q?OOCtbrIsGTk4kw1qZ+KLKh1do7aUAc4+cSIvXTAFgbEucVIOF33LKGNguHRp?=
 =?us-ascii?Q?zDctNNB+kGalzwxoJKXspV58j8CMurOeRAwo1lOcPp1Dp+5P7T4eio9t9WrS?=
 =?us-ascii?Q?HZ++g5OlD89snxse8NorjFAnEEbRr5QRg86vh6OQcuKIhL27KaZmMGCCFsgk?=
 =?us-ascii?Q?x8Ka615kQVD1iqSxPtVyHdcm4mMJ2WCY0rmO4gFbTjUxoQhkcTy/I+YMb1bv?=
 =?us-ascii?Q?JLnX3wWKFNHuvvp/PFXJl3H2b6UGDMF3noTo9NJJdKXxGvj7IRsgp+XmjQaW?=
 =?us-ascii?Q?ENO34P6D3ZdqmVGj4QyLSZlmoQrrowUDi5cNu9s75vPRx3ICx2vWPhtL705m?=
 =?us-ascii?Q?U6GoGDymyr2697Fjfq6lLH7OwSVPfwdfjZbNeJR/WNyoDg1v+m8krT902jcs?=
 =?us-ascii?Q?xK/+kg3fhngMmybDpFc22JZSdLHh01zuuX1xTUbjS3B7ZJz40aJuwvPckZTw?=
 =?us-ascii?Q?gYpOwsSGE/dX0Euhj+zp1GJbCr/osL8ELW4mUtTfxPZW2v8W1B8+D94gsCKZ?=
 =?us-ascii?Q?dUbMnTYTWElMbPLf+kbWw0YA4jKalc0sdxMpUDFiheaprx5HZSqk5LwulkDt?=
 =?us-ascii?Q?zHqPXzb1JCPFalGalwMI4hOzPdSGF5OTVmP8h33e6SqM6vyIZjpxjyOo97cS?=
 =?us-ascii?Q?PoG8IFA+HWhJXPhlSkEcctkrkBuXOD/h4I/Vi5HCIXua2WfzE2B7RZDxZt4a?=
 =?us-ascii?Q?v9n1zYofQJQ+/blyQAFxU4g/CVsmGOg+M8JoI50Z7a4aaI9tIElYpQ8D2clC?=
 =?us-ascii?Q?5abrZTLpwSbEmXAEiCkGAppSo7m40ni10gCXzWMkz5QDnjXD0LaJCzdcf8bs?=
 =?us-ascii?Q?T0HoXlj2ihZAiWE3i/KCIETJs9MvLLl7cpZr7RZhR/+09hcOg2Gx5CuVAp2Y?=
 =?us-ascii?Q?UB0imguhdaIg+febbI9ZFuyuCMUc7ZNO8Q3PHeN7f6LOk8kblWFCt28rosia?=
 =?us-ascii?Q?suOgTwt6o3VsPyv8TAErCE9eGGVSHG9fA5Ak62lU6V+zCyQHsU6D7CW+Og96?=
 =?us-ascii?Q?A1W9NelGiq0qtVo9zUP+WjFCLK+42fAYLKsLOMrj5v4x4VafIcHubWiO+or/?=
 =?us-ascii?Q?aIDeWgHpXvRVCX0+swAVgl5X7RziLPIHP0r95otgqcYarlo1Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LWDoPPMpO7MmBq1kbp9gQPMCDohDIVQovFED5kvgn1U3tP6607qyrBF003u?=
 =?us-ascii?Q?2/gzFLvGqRrEVb4IuFp4teU/sK/U2/wRSaStY3dbqt2t+e7F5EvZaCtQHEEZ?=
 =?us-ascii?Q?NQA2Vm9r4hMCgYFRnvuAV2/AeZx71Ci8GIn1rrcobDxHDC1C8wUbci5Z5XsT?=
 =?us-ascii?Q?WgslKxm1GAYkKgzTVUBQe7iC1aovOhXXOpOiUpT6WMiUFrFA7nsiwHCNgW2z?=
 =?us-ascii?Q?/e5jPESVGr14IlABkDF6jMdI9v7RcTbmcrFv/IS/Zgif3/AH7q/HirgjHomz?=
 =?us-ascii?Q?cCgQwyuS4OwWLkkgu2wJ19zU/8OjnydOI5QeSr4IkADfgGImczn9sQuDK3+N?=
 =?us-ascii?Q?1i3uULVcF2KkOgCE7WtPWR4DlVdOm8iIxjL3CqW9h9HG98eEpQx136xommcG?=
 =?us-ascii?Q?FxIsiKeQv8WLHdxuJHeqW4Co4Hg+3DI2XqNF3UTd6Tdxp5BxlxlbBWZghLMw?=
 =?us-ascii?Q?pDSj8TY3MKHJRNl7/oARfMfaeMor0e0LXBsMTVQb9Jj+PqCn3z1jxsq6inbE?=
 =?us-ascii?Q?+9CHtQ+z2qsWtYzekX3Irbx5VbturvA/0KDzURSyHnyhKLxj+4bI1viCCsUT?=
 =?us-ascii?Q?8r2hqXRWzCUMKp+UiP1dDexzHDH8SfH8xiznNUJNzEOHUsM2L5yyZSNlEjj4?=
 =?us-ascii?Q?i3yHwm3BN7hmzos771wWXDcvFpU6LVNGdx6SSikJib7GOAdtZ7ancUbxmMMf?=
 =?us-ascii?Q?vt3hASuG8r9vex0xss/+u9upOxqIfvGuNHZ3Ss8WrwaFc2kWzeNbL/jQR9aT?=
 =?us-ascii?Q?r8I9ZVwtISwt/Hn1vkLplyRmX07o/+hbu5blfE2wr48CNDi44eC7PJ8IPBnJ?=
 =?us-ascii?Q?yCfrRR/+snwqzzn2xBEHZIcymflMMTDG2W1XZTOy0NuBgD8f9Y3p8QBaUIFf?=
 =?us-ascii?Q?EqYcbKx+fSedGp7yWtJTvIaTNXiYB45yysxIh8OOwQKu9VdVdndss2Zl/f4h?=
 =?us-ascii?Q?8wuVLkIKZCOXjZf8BsVAGiZi6oGn4o9xxZwv4gYOC6Rr/A3uUaQZgMmokadK?=
 =?us-ascii?Q?csgm+QyDY9tpsc2PvR24tOIxqE35bll7uz9J6OteOW0fGSYGibfXzMHwkwnx?=
 =?us-ascii?Q?flFkSnvJWGntnts0cj0lvcgCrSV3Wr2zql6duxBuQ2HHoosRrZSpzf7pGXTQ?=
 =?us-ascii?Q?N65Ob0HCbACYbnWDndu+tapKzzHSQ7bhEHzZaeQvXUknRN6InZqQL6++LbAl?=
 =?us-ascii?Q?Nwe/uQ4cmDPpr6Twvt1ucaJ56++zmWOKLmdrFHoOOsFFzQiTDCnL2uJL/Crt?=
 =?us-ascii?Q?+cHLhEHo6udMaIHHVyzt9/wQB59VbBhCc3A4TNYMAIsRnrUJW40g2Ksa62Jq?=
 =?us-ascii?Q?E2/ttex8/h8hc7lho8RbGh/KOZoSGT73rJ/EBgCZ77QhKiup5zpB5U3/mgtM?=
 =?us-ascii?Q?sXBh1ficA2P2VJYaXXrUDB49zkMsqNpyNIvX4LNhPCAq5FpddfATxJAOUKjQ?=
 =?us-ascii?Q?1nDm9001MPPFskhaOyoMndk28aWGL2ePlIxDRnDYip8Eu1iDEcwY2bhONgb/?=
 =?us-ascii?Q?I41tgPpX3GuNgs8N9rm5TiSUq0beELXUfjCKMBsHh1rnGCEqSQSJenIsnj19?=
 =?us-ascii?Q?VnVObJEfLVViyjzQcZFWpJ+wSBPE+uuoxMjM1xzZFT5I1f7Ow88n6BT2wAvI?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba1e107-1846-4ed4-35da-08dcd3f6296d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:15:39.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LhAbxIwEH+yq0qfvUhpMl3oq2/oSsMoWvW1SiJQJGoG+B7wXLzG/Bqo3z4XC+u1IxuhQP/CeSwSqQKHqyueYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815

Drivers may need to walk the tree hop by hop, activity which is
currently impossible. This is because dst->rtable offers no guarantee as
to whether we are looking at a dsa_link that represents a direct
connection or not.

Partially address the long-standing TODO that we have, and do introduce
a link_dp member in struct dsa_port. This will actually represent the
adjacent cascade port.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h |  9 +++++----
 net/dsa/dsa.c     | 22 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d7a6c2930277..586efb76f67d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -265,6 +265,7 @@ struct dsa_port {
 
 	const char		*name;
 	struct dsa_port		*cpu_dp;
+	struct dsa_port		*link_dp;
 	u8			mac[ETH_ALEN];
 
 	u8			stp_state;
@@ -332,10 +333,10 @@ dsa_phylink_to_port(struct phylink_config *config)
 	return container_of(config, struct dsa_port, pl_config);
 }
 
-/* TODO: ideally DSA ports would have a single dp->link_dp member,
- * and no dst->rtable nor this struct dsa_link would be needed,
- * but this would require some more complex tree walking,
- * so keep it stupid at the moment and list them all.
+/* TODO: DSA ports do have a dp->link_dp member which represents their direct
+ * connection. However, dsa_routing_port() requires full routing information,
+ * which _could_ be deduced based on just the adjacency, but it requires some
+ * complex tree walking. So keep it stupid at the moment and list them all.
  */
 struct dsa_link {
 	struct dsa_port *dp;
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index a543ddaefdd8..8b4ec00de521 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -285,7 +285,8 @@ static struct dsa_port *dsa_tree_find_port_by_node(struct dsa_switch_tree *dst,
 }
 
 static struct dsa_link *dsa_link_touch(struct dsa_port *dp,
-				       struct dsa_port *link_dp)
+				       struct dsa_port *link_dp,
+				       bool adjacent)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_switch_tree *dst;
@@ -307,9 +308,23 @@ static struct dsa_link *dsa_link_touch(struct dsa_port *dp,
 	INIT_LIST_HEAD(&dl->list);
 	list_add_tail(&dl->list, &dst->rtable);
 
+	if (adjacent)
+		dp->link_dp = link_dp;
+
 	return dl;
 }
 
+/**
+ * dsa_port_setup_routing_table(): Set up tree routing table based on
+ *	information from this cascade port
+ * @dp: cascade port
+ *
+ * Parse the device tree node for the "link" array of phandles to other cascade
+ * ports, creating routing table elements from this source to each destination
+ * list element found. One assumption is being made, which is backed by the
+ * device tree bindings: that the first "link" element is the directly
+ * connected cascade port.
+ */
 static bool dsa_port_setup_routing_table(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
@@ -317,6 +332,7 @@ static bool dsa_port_setup_routing_table(struct dsa_port *dp)
 	struct device_node *dn = dp->dn;
 	struct of_phandle_iterator it;
 	struct dsa_port *link_dp;
+	bool adjacent = true;
 	struct dsa_link *dl;
 	int err;
 
@@ -327,11 +343,13 @@ static bool dsa_port_setup_routing_table(struct dsa_port *dp)
 			return false;
 		}
 
-		dl = dsa_link_touch(dp, link_dp);
+		dl = dsa_link_touch(dp, link_dp, adjacent);
 		if (!dl) {
 			of_node_put(it.node);
 			return false;
 		}
+
+		adjacent = false;
 	}
 
 	return true;
-- 
2.34.1


