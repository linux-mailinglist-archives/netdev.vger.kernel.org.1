Return-Path: <netdev+bounces-297511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id smXhHoIdKWq1QwMAu9opvQ
	(envelope-from <netdev+bounces-297511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:17:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA646670D4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:17:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297511-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297511-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED6330FC653
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5A396587;
	Wed, 10 Jun 2026 07:57:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3744394793;
	Wed, 10 Jun 2026 07:57:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078259; cv=fail; b=l/mU9p3gWg/gbQ4gATiaoElz+4UPAbkmpasTXaozlZl47okYpI2htdEdToZXZU+qnO0XvD0BLtnUTEEbtZbqW6aHE/0IErNlQiCug/AkPG5BdIUcJRAYaDDAOyHDLrhkRZRuRqU6spbf6LxZ76vhpqoVURHR0YLZzX5A82baqGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078259; c=relaxed/simple;
	bh=9174zXP4Ue5ld3m/Eqr6dA/Rq5HfugiTLVHSFcCFelA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LULmD/1KXnj8U5j4p70Uwk/3VvLqxRUSN87G4rVLghB3Pg+SRVT4YNqURcEUEkEYB9MnEx5C7UiJ3mJlU8t7G2km3H7jGnwmUaSvRmh97iM+pUqLr+tCuUeuI2AwZJ2fKbqUwfaWBoF1p6Ks6mrt6jljwRNd6ARZa6BmNPkVNe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgBPFAW6xh3utmn2MNGvmAkd19AyKqWVyY0PjaFPZtNYYbXP51zw7PDM/vgNCtV+wDjF60wGJj80AHhO+OjexclnVOrOkfeIKWSydj1/13zYcq8BkXU6dOECRsRp35FeOCpJOfVbXXVlnQm4zcjaE267SAEmHAXXsWHjrrshthZ55TnLWdyJ41YhodLOBAJ/GSYceowWyMXc1+2w3I+1jGjFgurwHACppIA0XBmwIHSyTrdI8+9Fo4FttpdBVvnhigrYJbMXSzDuKA4KzZxaF8pC3ACH4McEeV2bdOkNBkYt+dVzpDDpswbQ/nGGyLvWXzM1oMr9/dPMuxot6SA7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN3s+cFhrTtSdfx8Z6zUCeGP3UEeTJrRel1HPkF2JZc=;
 b=RfHOesLldom55jKzSCa1NzTv0TboP+mvVc9jESha8NbvqIU933VxNBzbxoVqXViO0wVm+dH3ttVi3PeJArZUfwYlt+HmpXpZ9Ufak4SbImbhwCIuuS/FWP8PrC4qNQ/8uEOdLhqR6w2TlWDbqE3XalF/rfbEDtjv+BLA9uRWczYuSnVaeIYsS/WEqQDrntign9foIzyHoqIpOCBBhRmTkrNbnoWqrpsAjhNwTfw+Jr3lywEA7PXM1MSh9D2X124VqTe7gbsrvUKwjs/2enw5b2Pfpc8c51n7ciNEwdciSUO+CeryAQjRbQL6i9B8rqx/mO+ygW0gctZDNIeNryQpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:24:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.014; Wed, 10 Jun 2026 07:24:29 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 1/6] dt-bindings: net: dwmac: Add snps,use-ncsi property
Date: Wed, 10 Jun 2026 15:24:15 +0800
Message-Id: <20260610072420.64699-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610072420.64699-1-minda.chen@starfivetech.com>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: fed644ae-9fb9-4c43-8d34-08dec6c14f67
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|38350700014|921020|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
 8CWdcggqDKcUNuDEd0CB0AyBCacpbh7kPbXax0cdHnddIECv/wvSvixaU7wfQZxUBqHjQzyad4jCfa/k3YrekVdKNJuX0DCuguIzoHm0D6LH82HL9iMuvnmtSHDVb0fj5kpG0t1cngjQ4cQx7zStT2e8vk//8KR7n/r80LKuRY+2Rk5PZpBJuMlE5JK6Hs6h5am3E+Rk1adbLXSULg0vmpeWSgbkpsul4AmLxjmzPDkRs6e73cZy4tFG0uLujOlJicNAjMJcdHfBTUO1Edk/+XTaLsPzmpym31aeoPSyTU2JQl0sxmDUNxHxR0fHsIcFGo2mktTgh6gdhzH/GpiQseC71XHEglxx4E0ixDioFCDt3Djp6yjf/AlSEvOanD8V9PWb1ZtGT7AewLzMhqf+nwd59SNpST+/Nw0jWqnBLoFV4j+KmHeWQLlmP0sFzSC6eyETPNn/wJWrJTgW3/MMoUyEqSQgXWaxNHAIcyHavyLrqveFmWvsstedbu1Z/3SbHcXF6flmgcTnrfhKnZIcMKiLUClkhlzD9Y52iPoh7CZVXUxD/18+EKZZALJcyLn9F0fWZln23wYB+MVeOVap6Q==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?rV2QzISksWkdlZIQb48Yc5JS7PBEqmD/vrJpnuNeq364jPCHs/RZsE+PvXtH?=
 =?us-ascii?Q?y2pcQ+fmlDKc9Opu4xebuftHB2OpsbC6oUkQ5l55RI+psei43X6Y9QanoEIn?=
 =?us-ascii?Q?E9kLrh9wTQWx533pYRXCnDWgHgB9/G2tIadZW042LBpO7a/FEp1hGIqjTInH?=
 =?us-ascii?Q?sSLeBoGnJPWUumMPRK+iT7ZkoR0i1BFqz1lgPr/T3Ov36P59FDFPArfnHy/W?=
 =?us-ascii?Q?wT46ujAED5EsV/O3welXCQ9vMIUwh/1alTcA1z0Szag0aukNCBuUiT9u7Lp6?=
 =?us-ascii?Q?PAlzoRM2SdTFvvmbjzUIUs3VzKgDAkrRwwsV52F0Daa6STXH23DLy7moVWFJ?=
 =?us-ascii?Q?+NgxrGrQMOLy31ZHKo8OFaEzU1pdOYzp8Pwgvz5mUfvgD0lkrBwvdmUp/ZsB?=
 =?us-ascii?Q?HIb+xVQBA0zDLKxm7dq11qnnd/GVVVGzq1gQ+q4ojqphUnCf3OLAcPJWQ0hB?=
 =?us-ascii?Q?ut6vJwoGrFThY8kBwiU7fBMmiOqx8PGj832eAokpkM8Acs4IxE7CNcJafP1N?=
 =?us-ascii?Q?FyzFLKu8idOoX+xGWYy1ClhGY/r0lXsJ/IX5fn77Cn0KSdNMIZj2rBQSao48?=
 =?us-ascii?Q?E9kblViXHWZfy9ElPoqmQNAlFt17DZvumB5pyXx6qbhFC9UTwST3diRoAUno?=
 =?us-ascii?Q?k/NAia1VR2r2r3tXxy2kaU7FTqG/m3dnEtvCkJW9o3cTCY7JHNwqe+AXneZ9?=
 =?us-ascii?Q?+e4RVRGyo8ljx59UFHdpEifDHs1k+bTFuus6wXDpWZVUSV1PrwXtyaGwMBQ+?=
 =?us-ascii?Q?6L8HQP3G7RMxFJ6foNflEJgS6BRGh4NpN8r79GTS7v1eQdSvxIERkKD44WZh?=
 =?us-ascii?Q?V+8nKoe0vMWXO6I0jfWn65TTZt68lnSnOf08nDXplEiSzito/QC3pGHgjz3k?=
 =?us-ascii?Q?C+SLvOO7FdFJpFdUChQ3VjQLy/yWtQsZV1kf0JyckO/hZ/FDek1nktcZd8Pz?=
 =?us-ascii?Q?MsCxJLz/u7cCKzKF7KddSREa+gh9t0LAd8JsE4HX69fYkLbAXyvv3vwi/UI6?=
 =?us-ascii?Q?vDU/N/UFJMjgqP1eoBLi+54XMyy4hUO4Rh/E4RzOto42by4nyBIl4EI60cOw?=
 =?us-ascii?Q?ChxEkRVyllGyFyiHDayOIPfI/SaG4bmgRDWXMZ+NLlBBmDf4/wb+nDd1LHTA?=
 =?us-ascii?Q?cEzwKMFfBAzAd6gOv0mlCqiKYmIXVLE6OswZfDKLP1GAvb2LRxGK04Lvhovn?=
 =?us-ascii?Q?ztuAH+49Pjxzg6+zLyOgU9Xg8M8PTv7EBqD2HFa5h2kOaJDpPSK16cb5Q23f?=
 =?us-ascii?Q?GN9rhEqVLEOCOg2BDHNh4A64r7jtMz34pu6k7YLhmiHPrqEYAkJePcSAU634?=
 =?us-ascii?Q?FTQm0deIErU55K/yboDJuIacXf9sld69Dlu2OKMC1DYypJYg1c79S4zbz7x6?=
 =?us-ascii?Q?cmoQAZbrEpZB2vg6JsiLaHH7ajLxVKqSR3QufomV74hC6j3kJN4ACl3HdrJk?=
 =?us-ascii?Q?wkPTjvYShcCeaJVhUxY3/Rep3KRC0jCJ9u/rxUzOTXUCiKBO114utyziSgs4?=
 =?us-ascii?Q?DJHIv5t2grdQlNjgQNrQQJtWh98kvICEkDPIOWs/rGLNwYSIn5WZ6Yn4AlOD?=
 =?us-ascii?Q?2TW+UDf7no8SaiDFVzrzM8XvPPh1IMtMCfRTL/iv6xBWpS5yQ3l01vLrWY3R?=
 =?us-ascii?Q?vW4A5pfRF96L4xeUSuFcfylmGgltfrmjZ/rhngZiehtSj9hCJxLiis8CJ+kN?=
 =?us-ascii?Q?ukRYvPX5uAVrXq8ZP8J3xni+LCAdtsMgaQaXdrC7/djCEjZKQdRrgxTi3gwM?=
 =?us-ascii?Q?+3q0WLssg9UT9VwKVrZma6ceDxTouc0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed644ae-9fb9-4c43-8d34-08dec6c14f67
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:24:29.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSOy7tDxJn0ygab991dvl+tbcYQxGnrp+AMxApP06HwyZxj7Cb6zMMNcZHsXfyCMM/FYIUrVfB5HEqQuyuUnKSuPTbJufYeAS20m6o2vYVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,synopsys.com,gmail.com,armlinux.org.uk,st.com,foss.st.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:joabreu@synopsys.com,m:mcoquelin.stm32@gmail.com,m:linux@armlinux.org.uk,m:peppe.cavallaro@st.com,m:alexandre.torgue@foss.st.com,m:robh+dt@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:devicetree@vger.kernel.org,m:minda.chen@starfivetech.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:robh@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297511-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFA646670D4

Add snps,use-ncsi dts bindings property for Synopsys designware
ethernet MAC with RMII interface and used as sideband interface
network controller(NCSI).

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..05b1d8428f65 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -545,6 +545,13 @@ properties:
       Enables the TSO feature otherwise it will be managed by MAC HW capability
       register.
 
+  snps,use-ncsi:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Use the NC-SI stack instead of an MDIO PHY. Currently assumes
+      rmii (100bT) but kept as a separate property in case NC-SI grows support
+      for a gigabit link.
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.17.1


