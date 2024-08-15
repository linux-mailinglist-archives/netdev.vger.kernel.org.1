Return-Path: <netdev+bounces-118723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF80952928
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE6285481
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1117837E;
	Thu, 15 Aug 2024 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLTco1fD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB391779AB;
	Thu, 15 Aug 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701941; cv=fail; b=myXpvcAEanQCe3/sObmYJPkj4OO6m/pyLeOLUiVWwcTwI3/ab7EwHL59zXL3vRZ3WTNDWdgvLXKWKnc/zPdQm8loOl+XUo99z46k5XljzYHlWw7u2XBp8+eNPstEmtVg23FUCR9JWjEPv2NSH3B8CSIzfichBeca0ZPCUjg1DUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701941; c=relaxed/simple;
	bh=D7gopM1yF9F7YqWRhoBgykH5SZhVboUguv7ncjEFdnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvUhKxJB5aMy+AdD6IMPAyc1ViD2Z5zcE7K1T8hDZvwY2HMJXeOpfa13Fj0XLsl/yZ/yWd7FnrrJN5b8pzAtMo16aCY3QheQbTK8RfLlend/0fIcOLWxm5Z24huTk1IymbubaQsY26Vus4QAkAOXDRDoxf2vmSiuEG84SXIyXog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLTco1fD; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+XHe4Y85gTuLpkx2yF4iRjS962mtYDTdzwoAtuni1Q77QfA+agrjxD5dHcM1b68TgzkEVjZEB1xP1v6dXthtj/QhfNhQsZLuFzsL8her3INtcXZK39PJw0Q01iECewT1jFniIQHTjvlBWtjM4BUVBX/4uke9ppCcddcmrmRyF/n/tBKxTcs0cNsLGjZdY8lhJeKrlfewLEINc0Dcoylmh7HBaRVcm26epLU4nFfBr8BNzSRpbqOrwNupav2YNeyY5s6AnyuPbsgeTo0ZbMB7Gr1888Z99t3Y2f2cUX1DKa0WSaYJ2ByAVSOMLEqj6/WX/l60CVj701Tfhlr++tdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llHXoX1fPgvuZl2HlqnA5A6pDBw9eADR0Le2+xvQOi4=;
 b=PP4Au48ppAFpPYjYRuxXzP7rwU6rTUMO0Ur8FpRIgweFBtqmT3iSmnd6HE2YOluwtZZA2+8vyP6GcCOCaJc77AgD3JuSHI0204kJRbYAqOa3VKD07pwvYoPPzba7Ftc2sMm7B+ZICS9EU3gmnACFq67k4JvjT9ktCkRRehJ4cg766jWBmY7u9SEhkYNwPY7a3SIpTazWI7XmgitESjT+HGyZfFBLIgKO8MKCx5jQLtdQi40ywtSSRlvdqsc7AokE+Kmxs5aqZ8zMRDjK3k4lwH6SPz4cOK3ONI1Ad5CVikl6EU44+uwGKiaNcHF5fvvWIffQ1wE/r3xFZ4jHqigJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llHXoX1fPgvuZl2HlqnA5A6pDBw9eADR0Le2+xvQOi4=;
 b=WLTco1fDDAqZKmMqFA5JZkdKasHOIOfN2DzSzFsA838yWbQisTx0oqHWlqxYFjNTWeJL3tQjzk4/CdQNK5iT+q3ltqEjIcL0O/jRLdPkbYMLcmnRb75bdQ4L9YoR0s9Dy3uaWiWLYWwNpiDCdpGLn/dMw2QoUFiam2cz955lXDJqReum+LfZBNzVPed6PkVBFASMg396o+owUpP+xHv1S3jzjoKGnIvUqoFsIHPTUXexDaF7IiVWnJypyww8OgfD3aR/cBa7ePr6wMnZ6adU6J1EddPVqGCm0qKwazfj3iZKCgSxsw9SbgBtamf/wHeb36Z9POO2Qs8ELoffSolg4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:05:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:05:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode to instead of rmii-refclk-in
Date: Thu, 15 Aug 2024 13:51:24 +0800
Message-Id: <20240815055126.137437-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815055126.137437-1-wei.fang@nxp.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: aca68867-5afa-41fc-524f-08dcbcf04825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crBUB4VIs84JzOb8Zr6hTsWrtYSybEuNbIc+MXhdu9/V0kL9Rmkp1k3KPtuc?=
 =?us-ascii?Q?PgSMKeA4bwgYxpgoKk911ZlyaRDl7XtF5V190Ook0GcOqDVTudnULQugdzL2?=
 =?us-ascii?Q?mfA1sxKbYbdUi9kUC7L4sjsxEqPOqiK8HUeFNwWFnwhNX2p8vv+EEYwMbeXF?=
 =?us-ascii?Q?0gM8bFZeoyUXLwDOYahdqukbhHJCD7b851pzpkIyrxCwPdIV3dVwF5P0Nt9c?=
 =?us-ascii?Q?K7vzl1nTsKjNDR0O522EtW1fNKF6QWSKvpip4MPAXZ5i9VDm3frpqHzpt36j?=
 =?us-ascii?Q?5Ewhd0bD0ndtMZi5KgMCmimbtsis3hhQncG/+LhziFvTPtKYF1mZOiYsOaJD?=
 =?us-ascii?Q?NostwFIadmJPaeN4K87n4a/H9x0oH5Rs8dokBvQbnpxf+VWKyYfSvJ63oEVV?=
 =?us-ascii?Q?ozHCPVPfat+KzYCA9RDr7V8Wg2hiLs9/0I5CDUC3478UhJPJGgRgl/EdIgsF?=
 =?us-ascii?Q?bVSm3BkwieIcGoe1pXdtciAsO0LQshaR09sEdaYZRzYiIj1sRjigItwGf+bD?=
 =?us-ascii?Q?OJ/HtMf8hmRjXYpilL/SkUhdo0/Gt4vf1UqtCJiYxmWbWUIzzSR9QAJ1rqvj?=
 =?us-ascii?Q?x57noSmlWRh8v8c3PNpAkjpsqm0jLhFwI1O3spjk5drcTWc/L+pV2rZB66g1?=
 =?us-ascii?Q?l2smlNK2xoGvf0oZp7Nw5skUeb8rMJCPnK3rQxLhTJZSzMIHTldnkJZjnFxY?=
 =?us-ascii?Q?ZwVlzNJTlEySkokQMiTUqLRf1bq8jT+iPHvEcRK1WQc7CSEsHtYvWcRR74VF?=
 =?us-ascii?Q?KmzxZmCatwViKWeeRU1TDvlgXZuFXmXGJ2vHC6sIvoNiGPb2g8Rs5t/SEeCM?=
 =?us-ascii?Q?jswXtKIuP7sjB7to0np8Ut26NS1eul2tVarB9Em2Js2A5TZDGsLz6dxYMM/O?=
 =?us-ascii?Q?yWQxRUyWG/NO03Sohg9BM3ixtaucaIHUfwpe07BxvqGn04n001zcUiE4HY6j?=
 =?us-ascii?Q?Wh+F/wqjG2xWocsmMyJaUwW4HXkvx1Zylx6+ezXZ938s8gIuxuApcIOYDQrX?=
 =?us-ascii?Q?Fe2y2e08DZWb07RrOrIJvnnvtqnfY+a7C57Cun2KgrsUXSKpMDKZJtkRQUMN?=
 =?us-ascii?Q?puPqNHMDub7N6t0MIL7P/Y5yBYmf/S1OE3sahGZov3m+B8ZVKs/603Mq70wU?=
 =?us-ascii?Q?qEZ/YZD9bZxXa38u8CIMo7zUzIvfrkVhbLxntuhQ6HEH79Wln3X/JgC1UJMU?=
 =?us-ascii?Q?7iVlSxxdZF+sE54sUxtHq/+l0P7i6Cad5yeX3Siy9iP9wcG5ba9VHo1Nf6Z7?=
 =?us-ascii?Q?l2EwByleKaXGTYjTErOaXdqxV2kdyLaWQgFsmvIeHO/soGBhZBMCk74d9EJz?=
 =?us-ascii?Q?3lzs+K0hVYz68DwOJGefz4vYWgqx5kOAnxSbAqMezPd4BTjkoJa6gl5RRhXk?=
 =?us-ascii?Q?vcv1mCR3oz1CqXSg708VoFwOiTs66z9jt9WPA/47WKb/4la0jJnf2nZ9BYXS?=
 =?us-ascii?Q?JQp2GkDL8kk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ei3DTDdYFLpc3S2zZHMkYuaf8z2MpF10x0+9a3UKAaq0dXnok7JTsL/nNQMe?=
 =?us-ascii?Q?Nuw+V2Byb85HUsAunSJUAPgOOUbIR5/amwwOHjnGhJj01gBZVRakOTlgIFDI?=
 =?us-ascii?Q?vydBZlQoytZ8DtwR4FPZ/WZT7yup13NOgbRJzjZ4WT1DbVBP5l5XUYjAKKTo?=
 =?us-ascii?Q?tT/FZtu2Nqpnb0ODoHtunNHEnRiW+8wIu5vDcxO4XZibsaGxfQZMGAOa9k6S?=
 =?us-ascii?Q?tdakddNdSWwySM02O7O+sDN+DVFId9u55jJhQNzD6gN3RR3rOxxzW7dIqV/l?=
 =?us-ascii?Q?6zS8PwbMnAKCdHIVsIK0fh1ewhhNmHJFnlSmR7oPQW1Zf69HaQkHwaqdwSaD?=
 =?us-ascii?Q?w8RQq1nse9vfKnAMxzrpjoHbfypVfEP8Vgmgsd9JEh8erzdOHpOhzB8s/P5a?=
 =?us-ascii?Q?lx3K4KsMECCBRGbHN6cOzitqxbcEcbqSW6NmB5ZId1ZpIMPBZS97Ssd4UWl8?=
 =?us-ascii?Q?8vvUCVoCsFAvjGUgtMIrQqFIKpn+zU4Yj0zpG95xLWNpjQabmoy1JVE6S7OJ?=
 =?us-ascii?Q?7HUVkKLk/HJtQQjpoMfL3Pgzp20eK9ffbQDw0NidNOmH/EfzJ+AbYK3n7Ke/?=
 =?us-ascii?Q?RUwOBJtFF2M1fKr33xPI2utFZUUH8vuvb6sj0/pMvXxoC8uJp++53YYFGY4u?=
 =?us-ascii?Q?jRejAii8n2Z0BguiEnY3zbKgfs2O0UrOk6EtP4ONWCia2FUXcYTysC/0bHAD?=
 =?us-ascii?Q?IsgKsiJQl5F3qP0v5ox+/JopVDTz5iSo23f79w7wzWG9VQcEWXNK+l4B6foA?=
 =?us-ascii?Q?o1DyNM3CyGxE3ytrmdRZCK3/Y6DkJ9XPDMyERw3jDPVWaRGdnVNodgS6GYyo?=
 =?us-ascii?Q?Y47aMYU4lEfF2a2/PGmqn9wY7Gnp5rAr7xK6hwfs40fxlgUbh2PWQCe3oC82?=
 =?us-ascii?Q?pXKNRXJkJJnOf0r5FqfEiHksdOOEhIG4ZsfYvDdP4NPfGgAQjsg1LD0AuFjM?=
 =?us-ascii?Q?xqPGwdo41JS/o2sK2QDACXAsU62dEloIZxwCEjg5rms7N5UbYrdnYgLU4a7h?=
 =?us-ascii?Q?4JpopvveDytDRG7wpUC8mn+5glWJb+Y/OBU/Y+CbA2mmd0ItcT81RJPbpVob?=
 =?us-ascii?Q?zYEe5PUTMvlZr6P3u9hoy5xVSsCl3jJJQVh8l2qu+O21qbro84Jjoh/Sj8Dv?=
 =?us-ascii?Q?YffAlxh2iiWD9LdfnkQPSr/py0d6GibtGc5IW+No5acfFqdaeLWeEPcSm4xJ?=
 =?us-ascii?Q?u9CEhZgpJvmMB0ahs4LeushErPHdgl4akzUR/bhz9j/GvHAUM73mJ4L9bd0V?=
 =?us-ascii?Q?HhqWAf1sxGXQ5kJ5Kt86hF72DxAAESFbS0gM2ULcoA+ps/ikDxUO6X3APiDx?=
 =?us-ascii?Q?KVuXzovaYvEOzKbWo98wWoqfmYGiKQIA/frYaSBmi8yE4cAXVoBmmwgldSus?=
 =?us-ascii?Q?onMdPgulsZyfz/g5mRCKpEyAa0qXe0MmLm8RlHK/KNQImY714+BFN9VqzNZb?=
 =?us-ascii?Q?4ZB2soIFgoT6lyFsMgjzFVYM/6fpsdO23uznhKZ12zvGet/Y2vZjd+aq1HaQ?=
 =?us-ascii?Q?zmGpg31SazIGEe+2cjomNk51KDod1XVyHCdvCRGFNIgPmH0FuNn+Pj6xgT42?=
 =?us-ascii?Q?kxM3KQibEx+oyO9z9SkHD53b/q1iAHUmwDhDaOMa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca68867-5afa-41fc-524f-08dcbcf04825
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:05:37.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SagC8W+rLXDze2ZNhYE37+VEctets82Meyx90obdVJY19lb6wtcQkANMfWZVDIBqggr7LI6EPwJZ4hrYNAaLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

Per the MII and RMII specifications, for the standard RMII mode,
the REF_CLK is sourced from MAC to PHY or from an external source.
For the standard MII mode, the RX_CLK and TX_CLK are both sourced
by the PHY. But for TJA11xx PHYs, they support reverse mode, that
is, for revRMII mode, the REF_CLK is output, and for revMII mode,
the TX_CLK and RX_CLK are inputs to the PHY.
Previously the "nxp,rmii-refclk-in" was added to indicate that in
RMII mode, if this property present, REF_CLK is input to the PHY,
otherwise it is output. This seems inappropriate now. Firstly, for
the standard RMII mode, REF_CLK is originally input, and there is
no need to add the "nxp,rmii-refclk-in" property to indicate that
REF_CLK is input. Secondly, this property is not generic for TJA
PHYs, because it cannot cover the settings of TX_CLK and RX_CLK in
MII mode. Therefore, add new property "nxp,reverse-mode" to instead
of the "nxp,rmii-refclk-in" property.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index 85bfa45f5122..e8ab2cf8d4d4 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -32,21 +32,14 @@ patternProperties:
         description:
           The ID number for the child PHY. Should be +1 of parent PHY.
 
-      nxp,rmii-refclk-in:
+      nxp,reverse-mode:
         type: boolean
         description: |
-          The REF_CLK is provided for both transmitted and received data
-          in RMII mode. This clock signal is provided by the PHY and is
-          typically derived from an external 25MHz crystal. Alternatively,
-          a 50MHz clock signal generated by an external oscillator can be
-          connected to pin REF_CLK. A third option is to connect a 25MHz
-          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
-          as input or output according to the actual circuit connection.
-          If present, indicates that the REF_CLK will be configured as
-          interface reference clock input when RMII mode enabled.
-          If not present, the REF_CLK will be configured as interface
-          reference clock output when RMII mode enabled.
-          Only supported on TJA1100 and TJA1101.
+          If present, the TJA11xx PHY will operate in "reversed" role mode.
+          If XMII_MODE is set to MII, the device operates in revMII mode
+          (TXCLK and RXCLK are input).
+          If XMII_MODE is set to RMII, the device operates in revRMII mode
+          (REF_CLK is output).
 
     required:
       - reg
@@ -61,7 +54,7 @@ examples:
 
         tja1101_phy0: ethernet-phy@4 {
             reg = <0x4>;
-            nxp,rmii-refclk-in;
+            nxp,reverse-mode;
         };
     };
   - |
-- 
2.34.1


