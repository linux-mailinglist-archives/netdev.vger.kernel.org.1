Return-Path: <netdev+bounces-239691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83373C6B5B3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 82C3E2A1CC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4536922A;
	Tue, 18 Nov 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CW7rPD8T"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94610368284;
	Tue, 18 Nov 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492772; cv=fail; b=oMcPwCLO4FM2bivlBch1t0UfhHv6Azj/JBQ6+HJ8vuYxN1Np5XM4wf9hjWcSASPxpn+AdjrMS7LhyKqIrBc227qVNsNIyC9c9yhsx7+QDbh1Uak+6/FVgDlbdIYUFaSlIsiDbNgqihI8c4gggd1nhgL58Jj4Qc9WddaxxRxL3CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492772; c=relaxed/simple;
	bh=yY0ymqON3QzhNB38qEXrOyfbegpqlNs7d/GSEZ57fh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIB7s0zg9LQkaeEK3wauHWhYXlS1woCyTZXeDYO+JP2YQ8dpihL+TAFtzb9F8tvbEeTOTnIBYQ+Hloh26MsmbzapvjCNcopdjCubACI4/tpLbRN6uKq8jn5DplGL/LXarcP1Llt+bBJv4i4//gV8Hmeil4LyEgvIsbOlzf881Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CW7rPD8T; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3uKn8lhrU3tsxXYP5gDSwkTWEF65gBkwWFP4jCiaHbVIz6AnJKKyK+SPqAZIflWQvtqCZTzcQtQRuliLnsjeIOmBEBbYqK0RlsajH4pK8I1LLAaj2Nq9WF+TJ4LAIvwfvFEKqBG/Wo5mpd0sg/oXB6a9WsWZy0wc6f6nD6tcgEsFsg0EAUmD24O64ePrRxQTu1ts/Y1QjN4fMO8gy+knguJsyTDyGOqbaz0A/GGf53rTVJBbruHZp9OrQDai87ckTYdEjDO7sacxzvWbKs/EF+r7RPxgNQBVh3VNn6QGe0YRl7GNri/M7t+ApQW6UpOkSsIujZIk0CuUwGeURPcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwwPzrcLMCRiN2tBB53pbaih3/XiM604PNiC35Pn5e8=;
 b=LRLgSQzdXQVua1jAtSsXGk+4koOUU+jGObpExi8zagd1D11U0kA0E17fo7603cSDXUjvzTKb0uuO2jXXk4RRBIw95b9cTbCJl+Q9WTc0XQ1u34q4YdPRmoQk9aSRRxm2XA8tjL14stgJC2/CmrB03pI2CkfsgVWUfuRVRNwJAQeWduRiAUnQ2qyxVIS+MCw/ece5LRNdsE3jBDBe3UB6Fv0ulTSjZg8sOujm4QnyfZg95TNPDNHqsHReP9MCtDx3F1Vn/qo2MP/tkKpyO8T7DPWf1CjGKSNO+hb3JN5ArzVnLOTm7P7VhQoZZwQsPOhqBMk5GfCc7EqedUeP7Yop7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwwPzrcLMCRiN2tBB53pbaih3/XiM604PNiC35Pn5e8=;
 b=CW7rPD8TPtrQAXcz0xwdA4HHVQ25/6THXELmulRj3sOY3T4Tll6MK72kObVu9NMRW+4FpZagkqqvDOZHwu96tfogfZM6XjkY1V8efgorE5YMs0Fmy9q7VgHEZaeCdw+zrTfDXx7N3V/KDA0xzmhVRNO96dc0aLYK1S9VABYg/EfDZwUte5nqV78zpTQrn+TwOlqGj24aBfVG43qPgctCJyAgN0tSliWXxGfU+CqoiuX+4zkbT77xFSYBVLjWOf8X1DeBY2Dw80S37MSaDKXsLltfM1v63oY3VxrSpQtxdtntWTjBF2sDkmC1offJ/4n34PNjPEavwzHcX5qwUds7ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:06:01 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:06:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 12/15] dt-bindings: net: dsa: sja1105: document the PCS nodes
Date: Tue, 18 Nov 2025 21:05:27 +0200
Message-Id: <20251118190530.580267-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 4946a91e-f4b4-4ad8-1a1a-08de26d5839c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E8vD8awvGpFB8IharH34YmgqDmt6FcqLvu8/4omtZ/idGcp784QLXgu3PgOJ?=
 =?us-ascii?Q?hRO4QHIsjV++6Ibt3wUekZ9fw3cW2Zk/TEyUk50oAdVWV+nkQ3sjheCZ6pFg?=
 =?us-ascii?Q?+ThenzycZCtLhlpn1l7FSTma+Io8OcUWlJMUHQr9IbjX9mEsweFg9dTKs3/0?=
 =?us-ascii?Q?VofWrbsJY4gwE9EMbp4Yw43vF7oqP8lwPqgYZYvX1rhdWEcuESQBGA4g27rp?=
 =?us-ascii?Q?r/K68QmSzLKCN+KCGSm+BgeKXmnbSf1eEY80SVSAHGAyPieAV1DP6DC8fYJB?=
 =?us-ascii?Q?ZGWTz+KWo/k24VWsOLLuOhoYyUNt4uczDB4oJeP0lPRbryMhvcRVR4QazV50?=
 =?us-ascii?Q?HXE2wlPChZXkOD7gJ/SDVTnQF3y8UxwzSUD4S/tEiYuvwzN3+KE+s4YficcG?=
 =?us-ascii?Q?33KtXS3urZGNtNfkcYojCG39ll9+4I6T589AadcE6rnh+1CNAXCciNWIl7HJ?=
 =?us-ascii?Q?MaT0KJBXJP74gj0lif4IYXto5S5rKbjVZg7Cl5IszUan07Qq2d/IK6AWLS78?=
 =?us-ascii?Q?c9PBbA7oHYK+vH3Gr673WFsOx8FOjGruDdKd7LrLxSzoOFk3X07XxE99kZUQ?=
 =?us-ascii?Q?GRnU7xLEvZoAbNI/eSZUrWPsuHxS3KZ+m5oSaVup9Bz7tSu1J151SHXSlBya?=
 =?us-ascii?Q?ELSw2ixtPE7YV5LO7L3i6aZHfgvmWRtjXV+AO8FYrEFjUQ18GJLJnT/5YDTL?=
 =?us-ascii?Q?hoclAVssqtdykUP8k+fKF33BzagEeJZD/kIl67+PN6yUZR+XosDLFCzb/S0I?=
 =?us-ascii?Q?9lZ4rn6L9cbImkMPml9lsIph3qoTSuTLv+cOtYOq9IeXkcNxtxmb9suGQjml?=
 =?us-ascii?Q?4+ksxu0IMcMA75qIanLVQ9oTCBO13jiRHG52s8Xn8XGC2+O/2vR+CRbw6rJr?=
 =?us-ascii?Q?KIyNLXewbhgriuIld1c6vPADiQAz/Z+Tp4p0E3noI6QOjRFHPMegphhJqcgK?=
 =?us-ascii?Q?xoGoZ5dva4aQHqENV2XcWIiG7vdopZcm/pbisJviqug/7MJ38DZb+XGl7wYA?=
 =?us-ascii?Q?GJzC3uWwJantDbxXx7174hLEjuLfoNDXfTEmsacCKPhaLI15GfNMPh0whA7h?=
 =?us-ascii?Q?x8b28b9woEPCo7B5ZYKKjL679EA0uJ42b+UrHjr+x13186Npqt/85Vr90+fT?=
 =?us-ascii?Q?ZdDGO/MbtXj4VavZD/ebxTNO9UhGkWMNWLB0+U9JLf/erS3FNk+M8DFbPaK5?=
 =?us-ascii?Q?ElZDFuYl7kaBHW9zhQPY57MmJ/9Dm7sRJyGkHONXNZcA3uKk3DndjHHJfz5z?=
 =?us-ascii?Q?IYKVW/oJ7uZEwTmqbkN9gwcExJjBaGPUeNDladBbAvYYglpEo3USsp33KbuA?=
 =?us-ascii?Q?RbqU6h/aYJ/mT81wwey5Ji+T1w9sT662tWRQUZpqs8OMua2IY3z4xTclqgrq?=
 =?us-ascii?Q?a8aYx6zVs0aMPQ1mss7HGPR2k5LBi0ShW2JAaghdhuUb/cw6PVRLAYlrdeS5?=
 =?us-ascii?Q?C8clpDevibecdlDxST2o0kzIPdhLiFh0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUL4D72AFTp5rI7Jqpmu5OOzV9AqhbPZud81NNDJRJ4sHWFS4ungThme6lMn?=
 =?us-ascii?Q?vY+ZKsL/1RZdLTw+NOtAVaoc90Fo57idy7au7tfMZFIOVqdNuT22Wa4HqYcB?=
 =?us-ascii?Q?aHzxyDAFC9W4jtbOn3zmPhsSiHdmxYPpM+X7jMX5hJO6Q1Xs+eocws2jmBOt?=
 =?us-ascii?Q?ierCVTXYinaFZO3vaQF3nM8UyRnF9LD8l6vyB0DIYnsSBZCFW4DeWO1C2l5n?=
 =?us-ascii?Q?8slJQ5091j8qe3fAnMtf8WRwYAm6WYFgLPRiyfTiVw3iYyM6y4/+f47Xn3GQ?=
 =?us-ascii?Q?X0Jui9ZCYg4w5qZDGtQv+EHCQNN30gO8F8+vCgSPkMHOA3ZYjvXI8IBq5yQJ?=
 =?us-ascii?Q?3Ko3Shp4szjVpT7XkTiDoLp9JWkGIaZD0hIh900m9Re5r6O9KfnmIY14mnIV?=
 =?us-ascii?Q?XKacI+ijygw47VI4XWkqJSLvm6fW9W4D7dSHZbBbJUXXbuFyMc8JQF4x9rAf?=
 =?us-ascii?Q?RmxIRYZ/18uKmV46MBGjTzloKb4HFeyvzwqFidheitfYxQecv2QgG3+58rg/?=
 =?us-ascii?Q?mknym6/TfJT7Z7fNDq37lXP8eXit6ocy0ssuEInxkcO/PwP3tHbujgoYdE4P?=
 =?us-ascii?Q?c7yZGBzlsr0956Al3vyN4wNQy5Kb5NACO1H6yx0EdAAe0kGC3UeM7ujFky/b?=
 =?us-ascii?Q?fHIeVGBR8skbA3wU/3iFZNdrglynDNxKovzxhicg8cZpXictCBDf4oi5PO8J?=
 =?us-ascii?Q?2PuVeQ0LNN9wP5nxsx9b7KxvdznHQu2icpvJVAMPjCbFL3avVoYfaQBBsygU?=
 =?us-ascii?Q?2J5gKBXXjvrJ3lUn++1ezGNV5hwSMsXtJconfgEnFIiSODvYgdgm98htzHar?=
 =?us-ascii?Q?auVTqd0wdydOC+N4eW/Ll1xkLSr6C7txV4Fl/UuBhAnGTW3cgOIK47OdIoiv?=
 =?us-ascii?Q?xApZ+N1K51eIDkvwNXPpVrnfQ1gW4o9T7LquBf9YuhCwy/58ZBAdcLz/KzF9?=
 =?us-ascii?Q?RuzQexpguP+uRNXOfADINbyRupItwv4WNFP5XZyH3t0tQe87cD4WuMiwvxBq?=
 =?us-ascii?Q?bHkPjwJMwrEYiAffBOYFLylKXydmz+B4+NvvEiw4AVT2evv6nSbsZcRbhyFE?=
 =?us-ascii?Q?vkpgIB1q+dJes4keCk0K4X4C+DdJGVddqQ73WMC/Vm/9h6llquKZ6KRxJDW7?=
 =?us-ascii?Q?v8yPx+K+wOVwj4/c8ROsVV2YUh3Wdt1Q/gkm5+McKJYCQF9d/XPNVDYu/s61?=
 =?us-ascii?Q?inE54X4i1VRQ6c7pFPzaOOE6ZmdhU5PmUkpaBsgbV0Gxx1995Ib4c0BZ0CIW?=
 =?us-ascii?Q?31cG7baS4FA0TPpH3qahEdivxdxtcIMLaPZK+6HSzJJKoxAb5EVTEzHEEROv?=
 =?us-ascii?Q?h9qpTwTkztqaviW1xcKujiK0WNj/qb6/LAWBTTWvZTP2x0DL1Ex+w72V/F23?=
 =?us-ascii?Q?pnMvVzb5/g1Wll0I4AmAlRkd4/C68V0SDDaXx+y4QiA+AUB+AuDH2fngf+9U?=
 =?us-ascii?Q?+B4wTOgwDizZBbmJ4PdKiCKXZEh77VNRbToShrfimUc26umiTKRhDlIgT6qG?=
 =?us-ascii?Q?VROOXsDXtWnQk7NVQRdWj4ptM0TMOshGiJWGjsY6rA9aQfgZxLKi0y5bgtXQ?=
 =?us-ascii?Q?BKpz/memCe09KZN/h7xlMq2j200MyCRDWHXVkH6Zyp3Y94xHdLDnAu7gOX/U?=
 =?us-ascii?Q?65DE81S8y3YOdX511jnk0eI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946a91e-f4b4-4ad8-1a1a-08de26d5839c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:06:01.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzAcs1H44P7YlHAkoM7KBxfDTl/pjFOUU5VDsT9SgjNSUnT/QZzHfq7fGJSvWjvaw9RFgtldRQW2OwV4MiCsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

The XPCS blocks in NXP SJA1105 and SJA1110 may be described in the
device tree, and they follow the same bindings as the other instances
which are memory-mapped using an APB3 or MCI interface.

Document their compatible string, positioning in the switch's "regs"
subnode, and the pcs-handle to them.

The "type: object" addition in the ethernet-port node is to suppress
a dt_binding_check warning that states "node schemas must have a type
or $ref". This is fine, but I don't completely understand why it started
being required just now (apparently, the presence of "properties" under
the port node affects this).

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../bindings/net/dsa/nxp,sja1105.yaml         | 28 +++++++++++++++++++
 .../bindings/net/pcs/snps,dw-xpcs.yaml        |  8 ++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 607b7fe8d28e..ee1a95d6b032 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -85,11 +85,31 @@ properties:
           - compatible
           - reg
 
+  regs:
+    type: object
+    description:
+      Optional container node for peripherals in the switch address space other
+      than the switching IP itself. This node and its children only need to be
+      described if board-specific properties need to be specified, like SerDes
+      lane polarity inversion. If absent, default descriptions are used.
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 1
+
+    patternProperties:
+      "^ethernet-pcs@[0-9a-f]+$":
+        $ref: /schemas/net/pcs/snps,dw-xpcs.yaml#
+
 patternProperties:
   "^(ethernet-)?ports$":
     additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-9]$":
+        type: object
         allOf:
           - if:
               properties:
@@ -107,6 +127,14 @@ patternProperties:
                 tx-internal-delay-ps:
                   $ref: "#/$defs/internal-delay-ps"
 
+        properties:
+          pcs-handle:
+            $ref: /schemas/types.yaml#/definitions/phandle
+            description:
+              Phandle to a PCS device node from the "regs" container.
+              Can be skipped if the PCS description is missing - in that case,
+              the connection is implicit.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
index e77eec9ac9ee..46e4f611f714 100644
--- a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -25,6 +25,14 @@ description:
 properties:
   compatible:
     oneOf:
+      - description:
+          Synopsys DesignWare XPCS in NXP SJA1105 switch (direct APB3 access
+          via SPI) with custom PMA
+        const: nxp,sja1105-pcs
+      - description:
+          Synopsys DesignWare XPCS in NXP SJA1110 switch (indirect APB3 access
+          via SPI) with custom PMA
+        const: nxp,sja1110-pcs
       - description: Synopsys DesignWare XPCS with none or unknown PMA
         const: snps,dw-xpcs
       - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
-- 
2.34.1


