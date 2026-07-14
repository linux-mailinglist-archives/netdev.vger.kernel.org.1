Return-Path: <netdev+bounces-307331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id re2IITibVWpuqwAAu9opvQ
	(envelope-from <netdev+bounces-307331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E937504E4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:13:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=ALQO3lid;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307331-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307331-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F0630078E3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18334304972;
	Tue, 14 Jul 2026 02:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AED1DE8BF;
	Tue, 14 Jul 2026 02:13:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995190; cv=fail; b=Ut6cnHslQKqKYemVX2ukrl14tSTHwvcqGgiyJygp2Tv8LNt14EMZ9zpOFTqMf34NVF0aCsh9b9q/TVaJvr6UECwZJ4cLiC6egvkzSI9F9RrPpQt0s+kLOQQAjusE6GNDN1LUOl3rcbXVHMH9fNnkQfg6JOPPn5QBpzjo4jKvbwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995190; c=relaxed/simple;
	bh=E10S+Uk6N3OWd2rFRvwJZceLzYUXZlCyan/KoCdDWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sk8uQj8ZK9H/6eNt/X7svDLN/FhmCIP3F6ejg9xIq5stguxRg9ProPuEHXt74P2t7hYJVgCluTfsRESOtCs8pZEpAnsjhg3tYf1eEo47ys3cXfQjb0pDuhZ4wodshsV/hwyWDpuK8SVhoFyNrkZnB4KUWr7VxC6prPB2vE+DtDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ALQO3lid; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK7Q4jBxbIYDjQpa5sF7ULERvizwNelQUGMfGUgs9Q0dXRip+vJwgt3REFE4hYCPMswU12a+Mlgb5bauAbO3KEQ6UgiYnl4V+bgp018PscWATj1/uu49TBpuQpd/LUB6igJzPqGAtlmCnXVoE8VTQJfYyqEB9JpDLdL9P74r417zoezFuoCv40CzPakKgUeeGTOuXIa1KEvir/P4QajjMEvBvtGSLuzHGEEj8k5HyhlYfOCU8V8qyZqhwAAFLVtC/m3dzX9hyIMrqDz0Ma26/hvhcDrz+FwI/Y2WfLNP34egSh0xM528zzIkw0oQNnwQwemgcmKhvsuObRq5cVFKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R04+mmzqeanaBS7KWKCqGHIzfb7+KuVigxQGHBSU8rg=;
 b=ceVvY92TvzSUSeBPDFva4nAyIdQ6v1zL8uYu9WjPioiZSTEJe9i799mmCvqIK6CkZxIwfob7QJuL9TenEZD0VoNHyTQG2j4xB77NIsnzjlgG5L3sOKFN6mdpGd8lWedsY4IurCBWF/vJB2W6c86HSWbw6FtzqbiW77MVyv0cq8wM5USuL1umG5qW0LJS/GlIu31UHVuyHaei+FGr+QH/Z8VxmiTrVDGEDvRKGjQHbwu/8UU9cf7mQzVFNCfE9cD8H+lu9rrE976dqFsf/XdL/Ad1OB3xyvkIPEO+KXHoopSQSCv3n0OxuNJiMsGlouZ8/ZHBV+8IzkJeY5T7P8Ex2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R04+mmzqeanaBS7KWKCqGHIzfb7+KuVigxQGHBSU8rg=;
 b=ALQO3lidlWydMtdotZJYN56cyaAH1teVYgRyOPM/0NznxLcSO113qHxKmcU4AX2hweZ0bKbi4l0PDfxWsl06PssZU+qQ6uwltKx7DUIXyZxv1QL5WVmkuWbqgRPQY6if5mKbCGdcys3J7vxhBuaflWOlRZNschxJ4XL3LDQCjAHPAU4TwOjWT6NrIiHBixVYYWlKel/Yd/WGGExMsq30NVbB62zkQbGJTltLo0PKWsXPANvboC346szOSo5SLN6ybG5JAEdFGvICV19OrHjGlPAkywXy2uOy1qnpe9wUc9bgUK/y2PPC7yl9f/i0k/uJcMBmFbYf/6fR8YouBiBRaA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:13:05 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:13:05 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add Agilex5 SoCDK TSN Config2 board support
Date: Mon, 13 Jul 2026 19:12:59 -0700
Message-ID: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c4fd61-67c6-41eb-cc03-08dee14d708e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|3023799007|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+6nLMS6yyudrqRYFvC4DelDbTNZ59CqiIYB7SokdsE0rs+/nGbCvfk80uipPjBssvRKmH8KDlC1jzLYj3Rv6/lmYtpVTLnPfVI/hoyummSoAboxSYaA/DirMIFFYlA8XsnQ+fdscPCfGsE1yygsByqzilGi9354I7cTJu+fYi9II4wbLGukt7gVCKjWXhNmCqLE/dqTsZaMDWISfeK9VLi9xNSeWlr1VT09yxwjNSbF85R/uvKDPA1gKiH0bcmQVggR21Fi2YoNTmAL3IxplDkKGHDL/5ss6pWnFe78ck2k7+6Npi1eqapEzERu5qL87OsUveq7S9UQ/uaK4Wha7DK4IcAdayruwEvXN5BlSsmCcFKBr/vyHp8uBVJju9hxms3n5EMTOcX1jTuO70kAQ/ripTFywL7kwT0ZYnpnkCxvQ2KKmlE+6/V/LvcxOx4X3pb7eZclHU17xiFhqvBPmGvFINYUHrHMO3wH0xnybSZLUFOZk5OltQfJDnyIawwG0wdJpRWt5QLa4DhHeyGhnewGAhumM3CFeKVE6kCDKZJQvJ/qJeQLiis3i722eBTvPsPwaR8rj2FUAtPO+S7/f3nqNAKHqU446eURieb3QwRNlyptNQbNC5WfHy3VuwhyaUOObdGprmxTU2XTLxxIAgfoBmLxhJ5H/LAPCfTkKWro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(3023799007)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNeOFJJZ7I34J2jOkfOLUghtVtqogzQ7SX+Q43knDQUuiY4OrgFpZQj+qkhg?=
 =?us-ascii?Q?NeoKP4Se4vtBPjgRAedLmV9xXoBEthnOttCgTugqUniY5F6dbgNBLik7Si+B?=
 =?us-ascii?Q?jplpLRZCOICDtcYaduNd7qBtMx5A+x2/8lDUF1Mv3toX+gLqH43aS18loO4R?=
 =?us-ascii?Q?3YZ3fvYKvXLGtXb2j62+LfnGsq70f18T7DLxLyzpdFSRJKkN0g+jjW2IWS2k?=
 =?us-ascii?Q?8MEnpRt3zVaN7Gi8M3cil1RTHYq65GSnRieAjku5xjPiQXxOp6icklG3V+3a?=
 =?us-ascii?Q?3Y9c62iowBdP0c/b5qFQ8lSdj2J8boU72UXtBHMhVHL8NKWh1ylGRBAlBACH?=
 =?us-ascii?Q?HpCMSlZu/NakmGBod0hSMwZUtyE3hsvwOvkDVh8z+v9PlviW9lyKTuxYtGOp?=
 =?us-ascii?Q?lnEVBd3G8Uez7CbbTW4bZMMKlmGMnfPij/WYeXMlbSm4nCfjMJv7aQEmXoju?=
 =?us-ascii?Q?kHGWr2mO83iP1asDOfwEzrmIZAawlkrZ9NvObdUxoxIAy0ahZJMl02QNji6A?=
 =?us-ascii?Q?8fjDf6FhBVvEUS6UbqTNaCDv/uwYU/H2v5RTtjf+mPVTfEt7bzm4bknSjC9j?=
 =?us-ascii?Q?pTBud+OUi82C1J6v9Jm0pkfOAQVsPB7v+k6SRR0OkfdRuu9oPaKjuOIS/WeY?=
 =?us-ascii?Q?JMKlJfv3484S0/cYxmzICHg7TrWu8ibVnzwQgZBWuYfoWEGdTNfF51OjBm5R?=
 =?us-ascii?Q?MDH5QFPXU9lv7TKeU3x/0OBGAovfg2XYGQp4qyZ5eeLIjJkSt0vARWYv7CY6?=
 =?us-ascii?Q?pc9y9Xg7RvZn/fRuKJvqlqggwtRNWf0YsH32zmRCSiBuHtFNKmkvq6yBNZ7u?=
 =?us-ascii?Q?9KBmaqvaiUd+9nv4R3PrHkRbWY3p3dE+uE2Lkc4ZbeoxWe55FKC81ir4RmD2?=
 =?us-ascii?Q?C+UXgsDs1GFqr6xCmf4sON/b1qHUDdETxI5fXsc8CagYet1orhEdWm4pKPE3?=
 =?us-ascii?Q?QfuZwaUcWMd//GXdJFTPBg3zyMt+9a/LKKJ+FOADl2F8+7KojtPJdkGE7pDR?=
 =?us-ascii?Q?5o0hRM2M+kU+AO0vXi6guLvxmi9ciJrmA2q3H6ekgJIHMJIgVu6LM26GLE6g?=
 =?us-ascii?Q?vQgMvM2qIhVbyor4LddMO3kq3LGOATeRncO58LJQdZtIhyiLa5ME7h18sZWW?=
 =?us-ascii?Q?hkQl8RhAwgiBieL/nYnxyBvpolBm5rBcfVvC2C1YnOMAsyFj73FFaH2G9Q/u?=
 =?us-ascii?Q?8XKl5dICwc9EK979UfOgrWD8snojvZDOtjYAeugB+jQDEoE3vBOPG9aQu2SC?=
 =?us-ascii?Q?rhI4ox34x2mr7489vGD36Tu2rnJXydMSKNim0uKmRTTijNAPbx5RVhs6LtAF?=
 =?us-ascii?Q?w+jno6uOuJFzxoQs4u9+B4guQsmVekT3IjSg+2/Xa8Q5FU+2ODPm+B9rbkNr?=
 =?us-ascii?Q?U4G9JBj846X9IcKgSFpy6qS7sULBTNEth0W5QTsM2kVie57oOkMd4EtLhr1b?=
 =?us-ascii?Q?hM5t8tTcWgXuwyB8ZdGxZU71uoWenz0ghkvqkDtxCgkoZWqmhlu+bUWdGcOG?=
 =?us-ascii?Q?m0h9ydI2CKQMSFPMa1JuFcyWAMrSCtz1i4bo+YidaC/78xCdC3Vu3GcS+5bZ?=
 =?us-ascii?Q?svV2DL+8M5aouIFMXqGZwOu1C6UtN9CUm1dsIij+JYbikoToHIV2hz+8YqPb?=
 =?us-ascii?Q?o7511pVnQY0InrJDJlhVD+5+QGa5c3hBYhFKcpyP4Q/xtALc9TAn0vuDBUZu?=
 =?us-ascii?Q?4lMtxwrnusNYtiRDEPRbeDaprNzwbzAQwFFvOP09VPvuWhj/usHSu9lfL103?=
 =?us-ascii?Q?l3nonj7G7Msetq4n/I6kmKEuRUmBGD0nG0qrapIKk7Bza9GuZMhhiPmIHvNC?=
X-MS-Exchange-AntiSpam-MessageData-1: fpXlbvzlRtV7mw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c4fd61-67c6-41eb-cc03-08dee14d708e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:13:05.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0chtu9SvXl7nhb6Jps5kpL9Lh70Joba8MvkL4RK0QIicwvFhX5TcLNjb/SA+HKeuA+mNNjaFRoo1vnWwdDDmM2uVTHiGm7eWqFAbX5OND4ShTvAmpezWDckmQNJE4bcybHM0WA86QFOIspqDLx0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307331-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6E937504E4

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series adds support for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant, which enables gmac1 as a TSN Ethernet port alongside the
standard gmac2 port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII converter
implemented as FPGA soft IP. This converter provides the RGMII TX/RX clock
delays, requiring the MAC interface selector to be configured for GMII while
the PHY-facing interface is configured as RGMII without delay duplication.

This is handled by introducing a new compatible string
"altr,socfpga-stmmac-agilex5-tsn" detected in the driver probe to configure
the interface modes appropriately.

v3:
  - Add missing Acked-by from Krzysztof Kozlowski on patch 1, inadvertently
    dropped in v2.

v2:
  - Replace mac-mode DT property with compatible string-based detection per
    Andrew Lunn's feedback.
  - Use phy-mode = "rgmii-id" to correctly reflect MAC-side delay handling.
  - Rename compatible string to altr,socfpga-stmmac-agilex5-tsn for
    consistency with existing altr,socfpga-stmmac-* compatibles.
  - Fix Makefile indentation reported by Krzysztof Kozlowski.
  - Add DT binding documentation for new net compatible string (new patch).

Nazim Amirul (4):
  dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
  arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
  dt-bindings: net: altr,socfpga-stmmac: Add
    altr,socfpga-stmmac-agilex5-tsn compatible
  net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA
    converter

 .../devicetree/bindings/arm/altera.yaml       |   1 +
 .../bindings/net/altr,socfpga-stmmac.yaml     |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 131 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  13 +-
 5 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

-- 
2.43.7


