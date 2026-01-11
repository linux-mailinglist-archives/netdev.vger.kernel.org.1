Return-Path: <netdev+bounces-248786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FDD0E7FB
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0EA43011F98
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4AB330650;
	Sun, 11 Jan 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KufU9A9l"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92834330660;
	Sun, 11 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124483; cv=fail; b=ryw5ZIVJv/Bg53B8dAe8IU1ZCBNxq3389JIcPBf+3nT1XrxfbuKduiMS7pB4rlKc/MK6XXk9y8RUnjEFOg5vNz0AkZFu8ZCu2d4M4M5I41RvT5o/ftd/7shYc2doJLQh+EAFECGxY82OISmg2yjD5/szQktgOHilrysZZ7FHVGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124483; c=relaxed/simple;
	bh=2qthhdOYOTEggMPS//753u9PqcoERRJJ6p4X/GmiFwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USCPYUwEg2u+E6jedYUeJ9xB9zNxc0JEqvFkCl2T5b+zpzYbBlovORPiQz5M1kWvVtwJ6tL3/JX/vwMfAv71+wIizrMhl40LnvaAnf8KDGj3QiuRDji275x22AC1NHqyQUrSUosCmu/MWGLwhT25TrgiO0QSIzvzD6wWOfO47dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KufU9A9l; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAICRZdBO7DAdqScPh1rZR3zplsOZg4K5NYd1daLIOvD6P28R7DxZMS+dLqfsD6Z2vg0QnB4uF/n2hdNTc2z23nGyXZerPTqYWUsf7YBehsSGEotGOzPVZ8rRqu1oTXKqzLSuPLN93lO3l/4n3aih3BsmTLZlPjTFnd16GWBaHMqTMhtehAD1i3laTWGerxlMql8j2kVRntQYakvKqvju+a4ecedix1j7BkAQ83lVvSd/HLr6xArab0nhKLbRvJnZhkPOJAZdZkYkegUHqymVMfWy6G8dw4CXBkckVC80uVLfsM9p3+gyQ2wID/NWzKkRGF9LcEBYNedyZ/Gd5f/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4ZxFEzhC1Vj/nZ+V/m12Otx9P1EHjahaApxiNz3vGQ=;
 b=NIdbHmAjptPh53mEYttPWfJG9tFOJHERR2BmujIfbn7DUk/ocsZEd9ISlgLVHJZORUSw+p9TgLVz6ZqFw3ciLamvk/saLiEOYoRj89Cnq01edRb+QE5Bz6bA4Ib0HxpG2Ipx8aD8blA9IG8kPeTcWVLwa+3gPgQ8jLMgweyjEaNcTz8BQKvlrEVCMFrGR42kHny7iOtCO4YKh9NPIS/nsAmQBHZWmBA7V0l6DEnoKT7PYMlLeElolsbJG7BhKlCB60RuU8MXF5GIwCGyThv0MglcnAdnoR3LwHpYouVw/CcamvmU27Fm5wGzLjqwTDgQL2q9JItjxcAo4ELlE35K7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4ZxFEzhC1Vj/nZ+V/m12Otx9P1EHjahaApxiNz3vGQ=;
 b=KufU9A9lrOeVhJ5ERoIPnxeWlKEHqixNSK1flL8dg+0NP6BCSea44OGgzrQW4O9cCmARuA0K9biki8sgo7N0khHeQNB6aX01XdxpNoG0ntfaitnkhBsat98YKNFnz4IOMGL2xLQv2JtGgo5Ht9PcQKkF/kww/JX7SbAhNzIGAC0h4vOnQ/vxW1g+OeS2k845zV2nFUCuwZwN3Ye39jcd7G65w4Rid/3X8+ZBdg0RLrRsWtxUU5TS/RBDwE5+P9N2rc+UKO84gyMXkfesVnwQf8NLvyK3l8cd37Eq4AwlhjEOh2oK7T8ICW9lIKlzYB/y1E7L+zP00FK5RghEsL/F6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:04 +0000
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
Subject: [PATCH v3 net-next 04/10] dt-bindings: phy-common-props: RX and TX lane polarity inversion
Date: Sun, 11 Jan 2026 11:39:33 +0200
Message-ID: <20260111093940.975359-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5e526f-0a8b-415c-5402-08de50f589d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9B0jzT1PdoC5KJL4pYvwxdc651IAFFqAzhtUDCB2CA3EfJbiQ6ga9RuZHoz/?=
 =?us-ascii?Q?YYtUqqW2rvUWxXEQ7hSuPUOCocIdG+dzz8s7NXvGxrG0hkiBc2QM+KvYE09i?=
 =?us-ascii?Q?zathnYQhgkKTC32U33LzKVHsVOx4YRMSkuwdpGdE4jbtpZEhMagZyXi+zwGy?=
 =?us-ascii?Q?MrtTzuyeAGbVTLTPMCgPc9z3ao9XJOuy/AH7WQrtwwZS4wgeMUX+bIpBHKDs?=
 =?us-ascii?Q?A6CBZENBNnGuWy9CSidMBrLNwF1T868Z85I2smTsl+r6wf9OONbefadloEb5?=
 =?us-ascii?Q?zFFEW5ikXhymlyWERdbPQrs2Ia2dvhgSGboh/Fl/xoJqODQyWJ5XQ/oOZMKl?=
 =?us-ascii?Q?iKJboygNtKn2TFadNfn2DtzId0wnLgepGftFKnr66ADqzv9Fnh/X5CDqpE6E?=
 =?us-ascii?Q?DU/jmGds/+9UPobBQ5CPeGeJEiXb7wIeqnKRlEhkYTksa9CEyFTzASQpS+d/?=
 =?us-ascii?Q?fLzuNA/uRiXVUtWhRQkeQmplJ46q9z4SeByHU8c4Yv0T7eg3kZhuvGjTLgF0?=
 =?us-ascii?Q?j9YuNMEMd+VSEeBNeL07O3GhD2f8MD/3OB+YmOWx8x00Mjyh32OAf3/Z51Eq?=
 =?us-ascii?Q?dBjSOKIWHV8lqGEt++4DmChEOkgx7B4dMyIr5iMJXE+cyOD/KHaveVuPWgDx?=
 =?us-ascii?Q?a2rzlgejiDhBq2Md79vpwrrdRkrkWY6DwMdMOmN/OfpCwzMAOgPF/G/csWhE?=
 =?us-ascii?Q?4hO/gYqMuSDz+t/D2sIJiQIap5qj9yoK/apdiiOe9rBfCTUshyS3bsTQr+o3?=
 =?us-ascii?Q?3U+9LY8Pd/3HlsZuFNdC0p4xET5sM5HsGTZHO6D2PP2KJqeg5cSG391tPeRZ?=
 =?us-ascii?Q?NDB6oTdZSPZGpXe9lYgTP9VmU4mjcGYGUtHkYKA9lSCiDDEUEk2m13vZ+DWx?=
 =?us-ascii?Q?pGh0CBES0Y+etShBO3jtto5Oa8oNq/SFdhBn8cTdMRPG8igEGn5JbnZl+l+W?=
 =?us-ascii?Q?k7ZRHGapPNLoolaYz7BRqZcE5SLkr9dUbCapdfGjwY947g1cu60C7olGQI+x?=
 =?us-ascii?Q?Zv8kcCvlzh+ZOsVVB9MbCvzsnycDpDCXO6yhFon6wfB6vMMHujLCiZvGqxyT?=
 =?us-ascii?Q?kXzPtM0UjWLvl0ROpSfkBUpkvc0/wtiXiCOeWxnk4ysplZNJOmZ6LGJSUBkQ?=
 =?us-ascii?Q?4rSR+JKZT4JkhQ2jqKlLml+vTdXsRtpwdrDEiLygb/DHMTuBZM0imT3njS7Q?=
 =?us-ascii?Q?J6iebW1eH9c7WlQov1cQC9AKeN2PpcX7xGEQ5LBJNQuITOGkjmAoFaz2SvvV?=
 =?us-ascii?Q?kiF4+YpVuXPp4wNQqMf3lzkJT6cZDevYJyftfV+tNYpJBV67eAOqRUBr4q78?=
 =?us-ascii?Q?p0wOf1Rk8h1AKgd1qKUgDspfFkb1wkaI0A9uF3UYHDzgXYGgPE3MM32ALdB+?=
 =?us-ascii?Q?b44iULCyER75gEOz8qDVTVOSPr6NRRhi/x4HdA7Fl02WH+vc1oq5YTX/Snq7?=
 =?us-ascii?Q?laDHBeGDNRxBmp4pEvmFQjfaVz5S8nD72Y/p96nxO55WCe624rtSXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rMuU8sX/+TYmnPa3FGtPWc93KhmgFnqpoMHlHaM4RI4Q213nnlZmahYRZgB9?=
 =?us-ascii?Q?Tm5YY4q+Jvv6eFeH/aZNiK2qF8n8hDiS5Apc9wMtMYr5e7R/N5W/0AsHAXXo?=
 =?us-ascii?Q?KFOTA7GabJdvL4k/drEK7fSLoozBxFOXLE8jH/WII6qLvSFruNRqXUgfoMDC?=
 =?us-ascii?Q?091SLU8XbQeveKvggacjOTy5EpMpUvN175EzE6cM0wdYQRaCoW2Yrv34YxMQ?=
 =?us-ascii?Q?EnDQ4LDJEZO3yGNbg7AIebU1V5nj8+KNhf5b2jCIRAt3xctghWkqeECGt/qa?=
 =?us-ascii?Q?4qmeFPq5ftmD/roqu2fOiQDsORjklBsCGbzEFpLON2TmXhDhvpOzjWSL+WGY?=
 =?us-ascii?Q?O8sHXPN5Fyp4b29whrfe716rrbUhN8FLD9mj6LLWraKW/tXI1uXuiItWmKdG?=
 =?us-ascii?Q?qZ7m0txGPvUczX0VeD0he+o/Gs6I4RMg8SyiE5cDxryBsyl7sPXrF2rz+feP?=
 =?us-ascii?Q?d8PI+2qTyAOEXJp5JGtsbzJE1bQjtlKdyZ1GHRWwZqhDgFvU8ohgZRqCn6bc?=
 =?us-ascii?Q?LUtNgIhvmquwD5EGLFwqkemu+Genmb0tBqzNVPrZVbmtDUZgvpT0NMiNsqzG?=
 =?us-ascii?Q?gm4XBDofOEb3jgq2yyrImYHbXxLdf6cxxNmwLXZnvbt8Kc/C5FGe4VwKLway?=
 =?us-ascii?Q?/b7hGBiVsWDy/5YYdbrtmkxOf3Z+gtd5Q6ZzeOQ1sz86+Y+R+aLaFm/TfuA3?=
 =?us-ascii?Q?lIOAi64LI1Pxk3JPO6kKvXL608gHFVChyFDMkSdIY+YYuD3ncltZpZ2G32gb?=
 =?us-ascii?Q?F3DxZqqA+Ach/ds+Il/VrNaaEV4bCMJwaKFF/txWH7xbbS+jNR2PRFynEJJz?=
 =?us-ascii?Q?fvo2cDlE56wRatx2T4j5RLZS66KZMFxhJi29e7IGdhCHe7lC7+Cw/34Q4Xd7?=
 =?us-ascii?Q?adZjdygrtBJ1248cmdxKA8fph+VTfMM0NzwvlSthUFRlcuP1TodNPqdJMyVt?=
 =?us-ascii?Q?2IJBbBVfPUljEBxR5OuL/qhusL4jDZtS2tJO3B6rO5h8Dr+Y6dDvnCDgZHSh?=
 =?us-ascii?Q?A1hbU+gWZioG4sugVw81p4sFrsWR5+CIGd+ehgZIILdM0nSrs1HP/A4QhEno?=
 =?us-ascii?Q?cdTM8l+OdEY9vML9+9LdMefGAv1gotGJMSdPM6i4zUZZ4Sq/NSJTR4ibMrEY?=
 =?us-ascii?Q?KElSAyARh/1UDB5zpuW7h8YvexTBiBkWaQbTmohoSfzU/KwdnM2fqFeI447G?=
 =?us-ascii?Q?TCFXH2Bakm7SXHMzf/y7tzZeQahe5rw5A8eNWiYNd2rffAq1Xm54uVMEMgWA?=
 =?us-ascii?Q?gHoMlHHguIDvQAl4nbzme+ko9L537nu79VVq41CiwVKh8IbXw68cTSh2CHDw?=
 =?us-ascii?Q?Xyt0IqHmOGqs5tB/7jge4RoshTU20jbku6MTaxIyN95pxMkAj15ITkmMbTFp?=
 =?us-ascii?Q?oBQEgEYvO4zUd973knKMpXFNyiV1bDpD0AZwm3KTsLWJrscZRce06gMxjrPp?=
 =?us-ascii?Q?dOOLYQbe/1bVMQPx5wgNM0pfCdkXBRJfwXiLWoRCPWGDcd9JjJ2naujRluKH?=
 =?us-ascii?Q?z/wu6bT5xcWxauTHOU5iyLacKJ1dCNrhFQ7Q3Hx3MyeeSeROGDsPaLB1BH61?=
 =?us-ascii?Q?8zM3h/IyRi7hlQS3TY10ImWIFzHCGTZ3dEDXgrmArT/msthbt2/zJlC/BsWm?=
 =?us-ascii?Q?A9dU9Uk4A0n+dwGHPhR6x8ZBBOLhdD0hP0G1OdrPkalocuu6edHqoQDUOK3w?=
 =?us-ascii?Q?1eQbisBcf3X2HUy1d/4QBdSZfgloIs1ukQVnn0jJ1lBc+gs0PZDgetCYIreD?=
 =?us-ascii?Q?XgJp1pyCdj39K9pvX+5L08OciBf9GOUaBZPrt5rc+aMR34LcTL2lgC1whKQl?=
X-MS-Exchange-AntiSpam-MessageData-1: tFnAsfxSgne8a29XpEVht78Abl+3XZajIX4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5e526f-0a8b-415c-5402-08de50f589d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:04.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNW9IBE+McjMok0epY10gI3nazcMMU7/SteW3dQxN2ndosav+Q37o22wJsln3Jiw0Qn7+Huy6CG7F5NUbqFp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Differential signaling is a technique for high-speed protocols to be
more resilient to noise. At the transmit side we have a positive and a
negative signal which are mirror images of each other. At the receiver,
if we subtract the negative signal (say of amplitude -A) from the
positive signal (say +A), we recover the original single-ended signal at
twice its original amplitude. But any noise, like one coming from EMI
from outside sources, is supposed to have an almost equal impact upon
the positive (A + E, E being for "error") and negative signal (-A + E).
So (A + E) - (-A + E) eliminates this noise, and this is what makes
differential signaling useful.

Except that in order to work, there must be strict requirements observed
during PCB design and layout, like the signal traces needing to have the
same length and be physically close to each other, and many others.

Sometimes it is not easy to fulfill all these requirements, a simple
case to understand is when on chip A's pins, the positive pin is on the
left and the negative is on the right, but on the chip B's pins (with
which A tries to communicate), positive is on the right and negative on
the left. The signals would need to cross, using vias and other ugly
stuff that affects signal integrity (introduces impedance
discontinuities which cause reflections, etc).

So sometimes, board designers intentionally connect differential lanes
the wrong way, and expect somebody else to invert that signal to recover
useful data. This is where RX and TX polarity inversion comes in as a
generic concept that applies to any high-speed serial protocol as long
as it uses differential signaling.

I've stopped two attempts to introduce more vendor-specific descriptions
of this only in the past month:
https://lore.kernel.org/linux-phy/20251110110536.2596490-1-horatiu.vultur@microchip.com/
https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/

and in the kernel we already have merged:
- "st,px_rx_pol_inv"
- "st,pcie-tx-pol-inv"
- "st,sata-tx-pol-inv"
- "mediatek,pnswap"
- "airoha,pnswap-rx"
- "airoha,pnswap-tx"

and maybe more. So it is pretty general.

One additional element of complexity is introduced by the fact that for
some protocols, receivers can automatically detect and correct for an
inverted lane polarity (example: the PCIe LTSSM does this in the
Polling.Configuration state; the USB 3.1 Link Layer Test Specification
says that the detection and correction of the lane polarity inversion in
SuperSpeed operation shall be enabled in Polling.RxEQ.). Whereas for
other protocols (SGMII, SATA, 10GBase-R, etc etc), the polarity is all
manual and there is no detection mechanism mandated by their respective
standards.

So why would one even describe rx-polarity and tx-polarity for protocols
like PCIe, if it had to always be PHY_POL_AUTO?

Related question: why would we define the polarity as an array per
protocol? Isn't the physical PCB layout protocol-agnostic, and aren't we
describing the same physical reality from the lens of different protocols?

The answer to both questions is because multi-protocol PHYs exist
(supporting e.g. USB2 and USB3, or SATA and PCIe, or PCIe and Ethernet
over the same lane), one would need to manually set the polarity for
SATA/Ethernet, while leaving it at auto for PCIe/USB 3.0+.

I also investigated from another angle: what if polarity inversion in
the PHY is one layer, and then the PCIe/USB3 LTSSM polarity detection is
another layer on top? Then rx-polarity = <PHY_POL_AUTO> doesn't make
sense, it can still be rx-polarity = <PHY_POL_NORMAL> or <PHY_POL_INVERT>,
and the link training state machine figures things out on top of that.
This would radically simplify the design, as the elimination of
PHY_POL_AUTO inherently means that the need for a property array per
protocol also goes away.

I don't know how things are in the general case, but at least in the 10G
and 28G Lynx SerDes blocks from NXP Layerscape devices, this isn't the
case, and there's only a single level of RX polarity inversion: in the
SerDes lane. In the case of PCIe, the controller is in charge of driving
the RDAT_INV bit autonomously, and it is read-only to software.

So the existence of this kind of SerDes lane proves the need for
PHY_POL_AUTO to be a third state.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v2->v3: none
v1->v2:
- logical change: the bindings refer to the described block's I/O
  signals, not necessarily device pins. This means that a PCS that needs
  to internall invert a polarity to work around an inverting PMA in
  order to achieve normal polarity at the pin needs to be described as
  PHY_POL_INVERT now.
- clarify that default values are undefined.
- fix a checkpatch issue: duplicated "the the" in rx-polarity description

 .../bindings/phy/phy-common-props.yaml        | 49 +++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |  4 ++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 31bf1382262a..b2c709cc1b0d 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -94,15 +94,64 @@ properties:
       property. Required only if multiple voltages are provided.
     $ref: "#/$defs/protocol-names"
 
+  rx-polarity:
+    description:
+      An array of values indicating whether the differential receiver's
+      polarity is inverted. Each value can be one of
+      PHY_POL_NORMAL (0) which means the negative signal is decoded from the
+      RXN input, and the positive signal from the RXP input;
+      PHY_POL_INVERT (1) which means the negative signal is decoded from the
+      RXP input, and the positive signal from the RXN input;
+      PHY_POL_AUTO (2) which means the receiver performs automatic polarity
+      detection and correction, which is a mandatory part of link training for
+      some protocols (PCIe, USB SS).
+
+      The values are defined in <dt-bindings/phy/phy.h>. If the property is
+      absent, the default value is undefined.
+
+      Note that the RXP and RXN inputs refer to the block that this property is
+      under, and do not necessarily directly translate to external pins.
+
+      If this property contains multiple values for various protocols, the
+      'rx-polarity-names' property must be provided.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1, 2]
+
+  rx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
+  tx-polarity:
+    description:
+      Like 'rx-polarity', except it applies to differential transmitters,
+      and only the values of PHY_POL_NORMAL and PHY_POL_INVERT are possible.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1]
+
+  tx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
+  rx-polarity-names: [ rx-polarity ]
+  tx-polarity-names: [ tx-polarity ]
 
 additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     phy: phy {
       #phy-cells = <1>;
       tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
       tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";
+      rx-polarity = <PHY_POL_AUTO>, <PHY_POL_NORMAL>;
+      rx-polarity-names = "usb-ss", "default";
+      tx-polarity = <PHY_POL_INVERT>;
     };
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6b901b342348..f8d4094f0880 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -24,4 +24,8 @@
 #define PHY_TYPE_CPHY		11
 #define PHY_TYPE_USXGMII	12
 
+#define PHY_POL_NORMAL		0
+#define PHY_POL_INVERT		1
+#define PHY_POL_AUTO		2
+
 #endif /* _DT_BINDINGS_PHY */
-- 
2.43.0


