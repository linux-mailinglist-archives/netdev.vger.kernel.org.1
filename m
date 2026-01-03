Return-Path: <netdev+bounces-246690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F0CF05F2
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77E7305F5E2
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3424E4D4;
	Sat,  3 Jan 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IR6nAHFA"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF24315A;
	Sat,  3 Jan 2026 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474319; cv=fail; b=BSPcRe2ozn6MxAlZXMp8lK3TZgaf7r1blkXe/bSF5WIuE4yTOjAtwc7ZVHAW+JvL47YJ6EBMkrD/nIoUwl5XEVjXn0iE9DzhwWyvLTcPTzGlUTZq0nSZNEX0Ta5crbIlgs4wBAGCmo8TBtu1MYSa3PlAyAoMG44vU+gwClqjK78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474319; c=relaxed/simple;
	bh=Wak6JX6rblJmhKnIs1JTu741xPS78Rc755wZi7YvJyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTHyGpRjWOimzyEM7Gz5xw5SrKTBsP/0TOngAuPakLsyhNMFJ6W8PTJ/RjlQuR1/PHzq1C6575PTA+ObbL1Ybg+zkM7I7AKZeTkUZ8aLecuMrL5Xuk7ZZUcXg6mFVplSc6Pg5k4P50M4z85lWdMi0jlGRKLxDUosbq3fwYfqTFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IR6nAHFA; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhB6EEFdlTe/Aw+RtzEWvmqpNQC8qMk/Gu1onu/H0hrVIMWSDkOBJf2SybOOTZ/O87lauTHY2UBabS37MICXiSnghnnUY6RnlHoPiC+6WBNDi3YIHN1wQfwQPaT3zBhDccuK286n5dB9e/d5rDX4FND513BVg4LZLqT2Ly7hO/m0xS3iQchtvigGxwt/CHXPQeS1GFm9iZHQ3J7hQfOnNghFamIDUHSk/1r+UnCnxlEpfUE+EdLj82b465Zd9C6NIjBsfM/NWHuqQNbGToaa8JIpL4YjjAiDQGRJJzjJEQyg2ahJdjE+B8yeVDrXUJVbbMjG9YyQ7b1yKz6Qip96WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIeAibDOJrouTLtCoeUUaT608IsO1zx4n0xeOWaLLzs=;
 b=T6ekx+519VAjMEYi8mLXLSHFBQboUqZGs+IGlfBdwkEOZQgN9JNuIk5jM75UDKNcoPPOOK/LOd/JINuqNckmKqHSayfAIZHE8PTne6fGwsmmDgmtuXxe9UC9ICo7ZY+XabLWWPuoocX4NIKgfj3nris30acyHCFhPeLMhvAujVqZPStFC3t5iTPDnVbugXBfprHZPMWSft/kRkOFnPChmWuBgkIdAUgol7Xds3Hr/8LRldxbXlTTTklPC3WQgNq6MCPKy4inE031qFS/ysTlCquo6CIu6gyWLJBN92Q8c/ueQDXnXJeoijAYxSXwiXwkqjxRqwMFAQ+5KO6kMbntng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIeAibDOJrouTLtCoeUUaT608IsO1zx4n0xeOWaLLzs=;
 b=IR6nAHFAAqYKvKOqHuO6dIOdgw5Y7luLh860jmOxG6TcgP/wh/F5wYXVp5LvrZKKtNElH6AU6NVtFh8oeJsB2tzAdq1XSbAuT4XRuCZ+3XCITo0H3jOjyN7LGHq5TLJk/uvbYli8cYwnThXSBOmEBfHXYCggcm+NYIykz4xRSzIz/Km1A45OgjUDYqQSSyy5fTwy+vvUIpD5aM5s0xBKNDzHKlZS6dKg70O51B3xP3Tpcnd9XTDMJpUhxeW48rAe3vzhKyh1F99hPrSwI0aNpyzBlqsBzIYj1dUzTU9yMe6Z5+bIDWrALPd0d0mA+qVg9tA/RceB8QSOnHyXqOxqQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:13 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 08/10] dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
Date: Sat,  3 Jan 2026 23:04:01 +0200
Message-Id: <20260103210403.438687-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: cf52a6d9-26a0-436b-9213-08de4b0bc92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1PF+cVRMyqEWYAYuiVYDkoEF7F0jPItFGj4xgWLhCo/NsWMP1HqUBfiqW16?=
 =?us-ascii?Q?6/cZvG5CTm8wN4I9ueaKKO+qjJiGQhTkPnHoXbTSS2gAv+rAw6oZ5U0hzDUh?=
 =?us-ascii?Q?T+h5A7YIrWPPCjkW5e5eHGztKV7cDrkEgOpfYa0IskG7YFEnwBIWsx8iWHNa?=
 =?us-ascii?Q?SaxkJ6h1p6Q0Uu36G5NKUKKaWVxcAeBNhTlbi5znHpSfC68ZZSuLBHuu0978?=
 =?us-ascii?Q?xEeCwvRy2dsbNfKtZENoWGRc84+pBLBy0RNwOPckhmArRiCwzwRXNH7Sq3X6?=
 =?us-ascii?Q?Fs27LcAmFjCAql8BWTBjHkPzukOqdIR7HmajtA/oCucmNb7HbzU6/rJeVWqs?=
 =?us-ascii?Q?0sh3YV0M3wT3dFYM7B41GbOl46yyzJmgpkWgl+BvjgTO7c3f7URB0/Ur7K74?=
 =?us-ascii?Q?M4i6BNJffO6RKC+tuq/c9tWxgqfHIOzYAy/Q0pK0MGCqAuZV3YUjeQgbl6EK?=
 =?us-ascii?Q?aeuFwz3tfyl1gPFR/+xeu1dOrFJ04r0NNM4IHbDUfwEUqXbZISQY4GSfpjwR?=
 =?us-ascii?Q?Qk0oENCXYPvhMiRoaihKOS3Gu4YBcuymNOzRUcEviyk1u/dLyKozyMmvAkQl?=
 =?us-ascii?Q?FP4+afxqD/8jx7DTgl60V7k7Qp8DUrruoddrgskY5P/hMvupjTxky1y781A3?=
 =?us-ascii?Q?ho1+BepdkI8Fw1SlyPkC69sGCv6MfTlZ0c/B+Hzp2EIx7YMsDuYAJ0l5J5Nq?=
 =?us-ascii?Q?bfIjk4wNBYEjokogDgBADa3D+PEyENIXuGFXe1WxbAiFk/6UzH9Qet9TEfr9?=
 =?us-ascii?Q?6cPR2GOJDZR4O2n+fjnSnD4G5RDyBQyzbRveaoNBlIvh2bvulDFj5IivvFev?=
 =?us-ascii?Q?ZKqWqGZDh7yd/UoaXM1gA6bOvKSgKk8fxoxA998vFcEwJbK4XUVHiAIsan8z?=
 =?us-ascii?Q?4ixAz+lVAu6Uz8NN2VjkVYGHY1LJFDQpE1Ks95V8PUwpGhSI4DF1wX4ULyyq?=
 =?us-ascii?Q?frOaO6niXXqGZuJUJew9qaUS/hK0ju/78lsUjr4cbJLvtCkwtr6D9w78lKPp?=
 =?us-ascii?Q?U40WMBdLpwKaJDFDSKOoFzKPLHVbPFqqMyjLDMrnYHxFgB/vdw4FyRWg71A8?=
 =?us-ascii?Q?93ciO/kQpe3ZmEPlflSNUVujMjkl6XSmA5u5DmtXv3fUNvCTUN4KECHn6PXI?=
 =?us-ascii?Q?DaOyMa9NsORXh2gCv7bJFkRME5cjJ5txkX1xlbLngono+lJJSyrofhO1C2Jm?=
 =?us-ascii?Q?zqj8dwSUyI6H2RMgyh/SO0zJiuFApDzvGmOKPVwCuF61LBD53T2VPrXJbuIG?=
 =?us-ascii?Q?2zwlb7NdKCTj50bdsXRin0nRarNODgWFfXhSAR92/sUQyHuGD0s0oi6LQlor?=
 =?us-ascii?Q?DoGdaRatsup2feA1oil0y6q+hYExHEzMDsqlxOyWgz9W9eNoPipU50X5kRff?=
 =?us-ascii?Q?mgClrZswXJzNdx99JjvswdqTRYQfGIJ0XNV326SrmpruYrQsEFvuvoIfU/Cu?=
 =?us-ascii?Q?smiLKh9TnlFOjf23w9gn05rdLh8LJQXSsqjNVa2yEHgjFnXSe8lJEDTOFjBo?=
 =?us-ascii?Q?5JZUcWAR835yY/bHz6nBgqeeNSfSeIyczvQL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXitJsmzZqC/2B9q/HV8iPjX1vbZVefFPOCpTbPsxVmZghlZ2zP1PwJx6mit?=
 =?us-ascii?Q?Mo8Rh4XbYuKufcmLpumWZaHzTGmESK5phMAIDowD4V0gtR2uUp607LSqr2ex?=
 =?us-ascii?Q?YnhMZn+P4G/MU8GVd7p8N14QNWely9R6eGbncQPG1/R2Mwg3cI7AL2IxgExf?=
 =?us-ascii?Q?5amJmi3y+1tSlxX+nQ39oRxAms7JT9cv7JBRnFXkIUyccUuAdzHzfqn+aK1q?=
 =?us-ascii?Q?3aNgKlDLnWPSx9FlYNtwvD3jwEBRPcoOK8mYpaQTqYrabNOPUOcNuUGvvkrD?=
 =?us-ascii?Q?DJaajld7tg2mynExUMJnYOIzZi5n9XSXwu+aK2+FfP7jNjxUAuYIfUoo+eu3?=
 =?us-ascii?Q?4MGwBYO0LtQd+bOmM2d8moNz4ukllIsPKi9uLqzHoevtcfIvwo/qiZifXU9v?=
 =?us-ascii?Q?FOCwsQMEqsdE0Sap9Kwq9zp0wb3iFeKKUyY17j5IHm1I8GmSQvAdwYIFE9q/?=
 =?us-ascii?Q?QPDdg8ExclM2SaqNMlyxHe9CgNMq4yPMLx5rbsx/SHwRRWHMktb9Vmk0NbvS?=
 =?us-ascii?Q?GF9j0PdQaV96RdE9S1EuaYKbu4uMp42UoPNEMHh3ARcbnoCeBJZV5W3W1rOr?=
 =?us-ascii?Q?sXRT2+o3dB+LzEzHahQ6ta9zBCbcieRTDuEE7QxlszIUSFk5OlrsYetBFLeA?=
 =?us-ascii?Q?KKc3T/rTYCg4Ag1UiDNLtYSAdjC5bCHdTwaNbNKnsoNrkWQqM/31HkbktxBI?=
 =?us-ascii?Q?/ZNUYJFdxpY2SzLBEQ/4GLajN1EfaOzvcnRoWPEiF1yBbZQIqN9ixLuDa/7H?=
 =?us-ascii?Q?EP2BsF+ehrNAGxZuYY8JLnuQvwwFego1NHj+XOIKVYV1zhjzZ17RdpDA6Q2e?=
 =?us-ascii?Q?Pak+MGmPc9+NDbYeIKAgqdXBEWtyg2skalf9vCbcOW/0FMMn3/gbaZG0aPml?=
 =?us-ascii?Q?6wHuafAixuGQTPElWwcP4KmJo/gv2fkiy6icxBXJvY7bWjkoFnmpftTLLxXK?=
 =?us-ascii?Q?UAvli7w0FUK3n3haikCs4Cnbxd3tHAhzoGen/UnCs3aD5LW8OT0jT3B0opFQ?=
 =?us-ascii?Q?T6BBv0R2T/oYDDcThJPb0oLu8TfWehYW4/vLh2o8h4YXNSB+vq4dX15hc983?=
 =?us-ascii?Q?NMjOVszZqNXIdBsOVu3tBEUoy1YW4JQX2brunG/auVs9XGcpR855zjhLgs0w?=
 =?us-ascii?Q?DJDOmzNQExbKVx4pafS0yH6hfmcci+It0WGgOID3qArtalaNeMqXAY0nQ0Rw?=
 =?us-ascii?Q?zX9P4SJ2sDaYfoMBv8z7ynYVfAnlhqt691Kncn9ngTfvkJv6xfFBdhCL6bI+?=
 =?us-ascii?Q?K5tOeB3a84nxgyGLq1qJU58QVnMl7fOKNOk/i2vTCmeggzxasIIX7QT9n3r6?=
 =?us-ascii?Q?zMminvLuegEDG061H0c15pr6XRQ5Lyycf74OGqo4DCosMs9U584zJ/mMXZhq?=
 =?us-ascii?Q?xVtBNktObVzmQWsSGrdca1uf8/MZWX4CP/uM7QK2Re+jJ2TL/XRcLWPPBtCM?=
 =?us-ascii?Q?MXyMuv1a2p2hCUBO5LHjJ9XWiZywyfzy7nvTVH2x+JbwHjYrCjaAvbP1zqjZ?=
 =?us-ascii?Q?9x3LIbej9tCNDvayO4bMXqGu2ZuWjG+NCx+r/Egj5LcXNg4NrZTVkbmGtVKd?=
 =?us-ascii?Q?BSGiMcR+74fRWra8DCV4KY5BmwTUPMFEZelc7Syg8Oz2cmUs2cJJucLL9IgR?=
 =?us-ascii?Q?WFTCjYusOM5RPybm7niYDRQPIL4W6owxJUXX71LLf3rXM2EbCW+bG+6p/FL8?=
 =?us-ascii?Q?zST7Nr4jnITKk/jhr7QQwJ+X10Q/A6ENowhySCU1zBfRPmGwN/tApcYtBsyU?=
 =?us-ascii?Q?Ny7KhS/uNJm+xBVhuh1nqmk2ZDumgbc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf52a6d9-26a0-436b-9213-08de4b0bc92a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:13.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OIxoQSHfRpF4TA55FFW+khaDAOEE0KXVRrMTZrmJBq3pxYYo/ZGqAgnlAYJruHUMuh7/D2fH6CN/vNLZ1AS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Reference the common PHY properties, and update the example to use them.
Note that a PCS subnode exists, and it seems a better container of the
polarity description than the SGMIISYS node that hosts "mediatek,pnswap".
So use that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 .../devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 1bacc0eeff75..b8478416f8ef 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -39,12 +39,17 @@ properties:
     const: 1
 
   mediatek,pnswap:
-    description: Invert polarity of the SGMII data lanes
+    description:
+      Invert polarity of the SGMII data lanes.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml.
     type: boolean
+    deprecated: true
 
   pcs:
     type: object
     description: MediaTek LynxI HSGMII PCS
+    $ref: /schemas/phy/phy-common-props.yaml#
     properties:
       compatible:
         const: mediatek,mt7988-sgmii
-- 
2.34.1


