Return-Path: <netdev+bounces-128111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66879780D8
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA59287E35
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF331DB93A;
	Fri, 13 Sep 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvBIeWAK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFA1DB54B;
	Fri, 13 Sep 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233345; cv=fail; b=JBfgdTWxQri38xsG1zh+eHtPUg1VPaZg0dXkBA/fTKvQQkl9j8JkLZDy/hQIO+hibFAgxsLw7FRhjakFVPE83x18+6briGPILU9aeFuFY6svVuuFPLNo/6x+cdx7wl96/6Ywhnovrk+qb97F+czqHH7YXb8CjwuJstWZJwH7FSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233345; c=relaxed/simple;
	bh=6ic6d9dfmb7+QNHTOnBonp71/ao7ZJxf7ZqSMwZmw6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4nwt0X/mnNblo7nyEKFNlthfnpFmZoNIC4IKafH+vKxteh2Sw7nyNReCsSure8RP7XGb5iHH+ggC4ddB5JACAzSPgiM41AYafQRbf19nGsNbRnW1WjlNKkBVjSUqEdAAWAVH8lz0DjaNgV5yE4N5sYfLbcrSq25PWfh29c5PKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fvBIeWAK; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfXIqzswSlccr6nc/rbd7rDtj1csvxVEOGjL6qykJy3h03DwpQmGLfikdGZdPP250yO1UC3R22dtQNgE/1UKIBOc5dY05gMWYClxnzWIEKNilQrdnf2lE08LM/TeiFaQp66Rull13nBaUMBVPmJgkfh0A8ZQ5kRw62B+ZSGA2zvWoKFvWN6FjgAcDEJYOVV76/hO/z9muHurTCta32zUrgfPPBiNbH1Ww6w0KMyK5NMsgIRncQ/XkKjmENsf3kggmS8NZBekgEeaF6TpKASP1hwjT6iUz9/Hyau+1cQGzdF1PYjySfTUVjNJj20bJVvNjx13PjOLo3MdQy6dptWMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lUuomDFyLmNbtceRJ6dWGdAT6VpTQI2dbWJv3mHiBM=;
 b=v0l6xLZ+LObG+tAECOWImpW5feU2h2mR08Uof4CeKVzuoi0WWr72+lJQWTTFzDTLTEl5rQB1EqT9XRBZlYn/iaKimTWSRd+Qo4uYUF/OQ//vhKUtkbqz5XE3QWzKg17JwZmGUYF44jtYxlCHFnwZMILxqmMTrrvL+Iza3w4yPI75+nP8Wssc3VgjQ566WJjwm5VlUE4N913JyCU2it1MNcOo6oiA+oXtI0LOYAhdQrZOzZkv90UoHvZgzlkbasZyQty7R6wGjid4VkArKHZlGDg2ekMy3TVNcbDhbbCjZpU3Pi2sz+V/j8ci3PxmwzcHyZc7GoxOWjtDwtH4InH6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lUuomDFyLmNbtceRJ6dWGdAT6VpTQI2dbWJv3mHiBM=;
 b=fvBIeWAKHHqLg6zkP9FblvtzGmTfQ0gd933Q5iwy1qZJvlz8QTTvWsGAuzir9jOkr8uVA/SPTxsQdK9/0dDYlyM/3zALH8vl+sFjFNv8lfLDVVsbzhIPk9I2jBjvuoJckf209l1z30aYda+wCf4BuQkPu5aj75PRg5fTRT+zF7LbPpFA9OOAUmRQ5vFigS5QXHbT67gvNjegCF4c4Iw17TvsB4Ddt+PpElGog3Kbaxpgh12/lBE5kQY1SDxGpmV4MAeQ3PedXrcfU+UpBSEfAG0ju3fh1L6UY698adwZy1iK+P9lhFwG4pitRVrmM8Wu/U6kIiHJUeowqs8FMDDynQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7519.eurprd04.prod.outlook.com (2603:10a6:102:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:15:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:15:38 +0000
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
Subject: [PATCH net-next 2/4] dt-bindings: net: dsa: the adjacent DSA port must appear first in "link" property
Date: Fri, 13 Sep 2024 16:15:05 +0300
Message-Id: <20240913131507.2760966-3-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb24c48-91ca-43ee-b56a-08dcd3f628ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLkTQfqNxR4iuLvvXjMsnZD637qkm01I+VwBCBDotGA9rSSUrkq1Fqf004Ln?=
 =?us-ascii?Q?Kdij6656y/TOSTURm/kyN8PrYAnynlnExqqF3NFxRvR95ggffzns/EuV8gM7?=
 =?us-ascii?Q?Vcbh5uJa1Igwqej6cQ3t/ez8Pq1ZxBIKWOvQwB01VDOxwrDtgSOcOfEurP2v?=
 =?us-ascii?Q?vtfwmI35Umwd8E1AjhfaCiw1Dr9+KaWXRaq4fO7/XE6G/wwgo3xKJUsC6eq3?=
 =?us-ascii?Q?9JVkzIqZ1pNtnIfSkXbOBsEfq5YC+k9Qj7QdWmY2rBrcnA7dLnzonP9E7URT?=
 =?us-ascii?Q?ElpMmqX1vu1nKb4zaAq47DTaTHLSAq/PgGxYchdhLpZytYnJgKT8YBgyVULx?=
 =?us-ascii?Q?/JFPR9YBxLIAMomAJap1onZtj8xkPDUupNV8pnU0+RoyxFhRZaWTh4uf3NNY?=
 =?us-ascii?Q?fHyepkKpDha3yViqYlEQVOdMKlmmJ2XL1Y+kkwsB5OrN9HGoBTEbOjD96KEj?=
 =?us-ascii?Q?ycy/jWSBkgCvN11wrtTItsrIQEGwaVw8JQMWFk6XLN/nW5jIYyV0aG3qzOyW?=
 =?us-ascii?Q?LVYuZS4MFwTT08wsNixWHf+BgfzYnH31c6R678GLIp7JP1Apb014YGH4nV+E?=
 =?us-ascii?Q?N9+/rC6eUHsrZO7zot4BEYDBUCRoKYxA2MMP9bymakbETMmVaio1wR1MB5JZ?=
 =?us-ascii?Q?gqfr9tJ9Bctk8QqZebMvrcXcDPEb11Vpm9R0X+5ISWQnqs2Ol4AITcanLYKg?=
 =?us-ascii?Q?yAvjUUoeMyOwu/4c2gl8vpsTIdUidNObuiVEVwEinxV6ZCy4cx/i2yjmjPjH?=
 =?us-ascii?Q?BzDUc4h410uzuK4US8y1G7yjAXxNb6wdfHlRUqR24mTbC8Ih2uIF7/t5aRVa?=
 =?us-ascii?Q?VB757r8Tzo2mFhqYcvqQz4j9jZ5ZRr+G+QSXNUiFDvllOhj2I2WLAhDMZFAE?=
 =?us-ascii?Q?qau/zFeQE2wAP0mQKKLYC85Vnw2LtSmwwGrgpPfRM6apo7BYp3OzYw7aVchk?=
 =?us-ascii?Q?/GOSEED8r0HDIWftU6UbSK24O295TqFPM71f20ZInHpmDDSz5g/Cqa4+YZ2z?=
 =?us-ascii?Q?Y6hjcVbEOhmFmgLTTTC6EvtuYHo3/mx/2vi5S1akkkgvW2WxRFxELhP5nanB?=
 =?us-ascii?Q?/LHPfjs6teI6ahh3YCMe7IZ257dWuHSTmVcZKi/bPojtgfXCfJKq4xAsahpd?=
 =?us-ascii?Q?bIsH03cUVVjeHjQckz+abu7Pia0YuWiHTsCkItx3ijQi/fAOgARvsZrAB2Iv?=
 =?us-ascii?Q?HgLvzQ6wSnKrC2TDrQGMo7J2iJ9oCpovwtAU9aHTTQX8OXxiXVDaheVfs6zo?=
 =?us-ascii?Q?ECNRcL75+Ch7oK6z8xhBkxFNP2OgE47tVWGmtUXMfOUP4a0ev7lCjSqZlgWn?=
 =?us-ascii?Q?ufizwpAnAXmAmzRKQOWRqNxhiZYjNLezr90HJYVUgToga4iKGjqIp1XWoXPb?=
 =?us-ascii?Q?7yCOdrT2Vn1T8XBGA27FvBPa8NsoJY0TA1dXv9FVpqfCyBNQvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?On5wRgqgf0yD0vLsmN4hTU02bh+Yjw9E3ReCvApXpbM2cyTu4rfvEop1Y0vH?=
 =?us-ascii?Q?GxvhSOngcNq5g2Bh0wF+GzlNZR+4f0Z4sasMyHDt1Hnz09D5Z1gbs0XaM/R0?=
 =?us-ascii?Q?fKUAA8ZUohZDIwnGfFeFrF4vw27b0eCjT5euPGxhLmp2ZDdaliR0nJBUts+h?=
 =?us-ascii?Q?QpEIF7lruFy3b89DVIjLSCqELJdf5XVtGfqDUT5uzhS4yXfyO7iowBjIZG3K?=
 =?us-ascii?Q?g+UTFRQ55LfmiBx9214Ow6tuoVtUGn+6XMRqnqsYaU3q0S1sPCONl+n+Dqax?=
 =?us-ascii?Q?k4TXe+J4Pd59CxSpCvYSjP3P52MKC+9aPw/CAlTWaf7rcuH8+VHJUFiPfvCE?=
 =?us-ascii?Q?XK7fPEhaHWfGayuXLgRBgFYgoBwx+ITdRTzfEgR0j5wtRYhbMP3H+OMYWj6P?=
 =?us-ascii?Q?XW15zMn7fyfzOEifVx/8rGr3uGaw51l6ka9qLZ6pLezrTNd/phTMW20QUsAd?=
 =?us-ascii?Q?A9C3HzfNWQVll4TlH5liN1elPvznW2/NBI73PMzFuHx8mkuWFQpflGF5VZ29?=
 =?us-ascii?Q?KugEYRPtT/m067DIDMv9jhF4HVJ353ye6R24Lk17D6ajPo/Los6OVwHFMqRU?=
 =?us-ascii?Q?bHsMcvp6WiVIgbPIesFpfyrV2qdkozQgY8ktkViJ4jp5864KwVe6KIrsnGKg?=
 =?us-ascii?Q?mMxylpjYS6tjhe0X+qVAyLMv4ESFEBSesuIwMY3giTf9/mnSOxjwoDdpfETl?=
 =?us-ascii?Q?hxCDQFvDZrgC3HJ/YBjkCpYh99SUjSodf0ELe1AhDv/NOc8oeTa2+ECvkmGY?=
 =?us-ascii?Q?E+i8UqmsfKviLYYBb3DUu+HZtXeHv4YbW9gDuYUdd+ZlAOYp7Kv13A3l9Quu?=
 =?us-ascii?Q?biQt/8bujv1aUEyXuV2fC9/abD0I6Zj8xN0UR0AgYmSrsRdGrv4lWWe/KC+i?=
 =?us-ascii?Q?s9RlIMTr0Txtz31i9Vf1MgriFScA7O2+6o+9W7TsmNFoH0pNCzrDXz3FvXRD?=
 =?us-ascii?Q?/7ti8mO6fltBXvwJYwf1kimUkChsesGxgs8Q4bPtC+Ri+yAQr33/F5Zj27dD?=
 =?us-ascii?Q?9iRcYZVK/8lKxhjM+YeXlIGAu5Fu9Uh9JIs8r1XpaOrN+f955UOoZrm2keLs?=
 =?us-ascii?Q?c3s7u3EzgNrBoP1hbq4XqTuSqtICQoRvG+HgIpW0qwnhZ95DiEXK4kmKVndZ?=
 =?us-ascii?Q?wqXizI/5SZbWZoGlT82xZ6mmkoUMWoxzeEl2qYI16p2Ss+nBP/YRyfYEG5Rf?=
 =?us-ascii?Q?Kll7l9ESlakM3HrBFEC/nMSHFmc8mTIWo+hG3Kc3YG8hIlFa5nqCbBXniMk6?=
 =?us-ascii?Q?Ye9P8CLAldxCxjmJF61nysOf6haw/wL4yRMlYZY3GWsjkSzisuyPoSjm3/5V?=
 =?us-ascii?Q?E9C8SLkB/lbWRdUAkKeL2XItGkFDjDFsP6zxLcEax25AhGu7XNmNwpT+/i5f?=
 =?us-ascii?Q?5BUR9uE50Sa2WOmxdEHjczoBxoUlE+l1iYT55TM5llS8jwdsKaz1pxGzBdBD?=
 =?us-ascii?Q?//mKp3eW+g30mcBDQeFCXg0t7TV4ER0kgAkQcDVV9vqdiTYAz7LMiiAo8k23?=
 =?us-ascii?Q?AVT4NakOnMlswI4lju4Z0MetwWV9uduQpJCeWrFzKcCUYBGlusXLajbDEAyB?=
 =?us-ascii?Q?WAbYxqgYTXdgzd95GEPZ5pnYoQvqVUT4w9HXaEM/9jxS6jvySv5vq7uzi6et?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb24c48-91ca-43ee-b56a-08dcd3f628ed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:15:38.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/BjQFNPL2pbY29u7dgF2H+AFWYCngGU/EcMAe+XnDXdNiM4ARhLVQiCTqoEW9fb/NuQInWoBWrZDF5kCfbZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7519

If we don't add something along these lines, it is absolutely impossible
to know, for trees with 3 or more switches, which links represent direct
connections and which don't.

I've studied existing mainline device trees, and it seems that the rule
has been respected thus far. I've actually tested such a 3-switch setup
with the Turris MOX.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa-port.yaml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
index 480120469953..307c61aadcbc 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
@@ -31,10 +31,11 @@ properties:
 
   link:
     description:
-      Should be a list of phandles to other switch's DSA port. This
-      port is used as the outgoing port towards the phandle ports. The
-      full routing information must be given, not just the one hop
-      routes to neighbouring switches
+      Should be a list of phandles to other switch's DSA port. This port is
+      used as the outgoing port towards the phandle ports. In case of trees
+      with more than 2 switches, the full routing information must be given.
+      The first element of the list must be the directly connected DSA port
+      of the adjacent switch.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       maxItems: 1
-- 
2.34.1


