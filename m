Return-Path: <netdev+bounces-305279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YUpcGnOZTGqImwEAu9opvQ
	(envelope-from <netdev+bounces-305279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB987717D9A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:15:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=YWgFs1cL;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305279-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305279-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59C0E30325AB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D0388379;
	Tue,  7 Jul 2026 06:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CD385D8B;
	Tue,  7 Jul 2026 06:13:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404793; cv=fail; b=Iz7nirnNnc2kVuS+/l2Nek16j9S23fC9DeSxhMt/+YR0ELIj6IxFNx3cvGdLFMNZJOAMFHbk3vZGNvJrXuC4TQrTFRstdI0HN1j6+XqzqBGRsqo16+EpiPPed7ZKs6RUJvxNWWdF8sXCjYfZwMYghlECtRybpfkYhn4PcJtiIHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404793; c=relaxed/simple;
	bh=wKOGldZHK6fY0DcEDNLgMUmy/pAMNfacTM55Gd+9B28=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u2ni5aHy7S9+BILpuafUqRmG9ruKf+BFvmRODmVFZ/i+UmUrr4WSlFLeHr1yXOjhzCh6IINX0NUxEKPIZUcQErSKKtaMNpvHmVrRqGBM+IwJvdH8HUhP1xrX+J3rOVGGTElrPnib8YNLknj9p8Q9KEIT0DOw1+p3/CZgSQQsN/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YWgFs1cL; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM68Enz29HmnBFo2VOlfvD29BS199f8SOi/zDTCHEygt3lJS42jovg2R2RSzmALWP9w76HaK92YIfXWgHkyx9y+F3LdI7b0dTwEhRncjOu/lLoxLz+lHYK1lA8a38mlxBZM4cN2XDvN/0GnlsET1N/M7RcU4hjSPGD6tiwuXKiQXIaOuavPPSc3DLNZFraB3CUpYh+tiQMF5AXlgAVMnPogs95V5mk/79T2nB5DdLA4dQMHYyAx34S5V3xvOUv/dLZiTuR0cTvxILnfZ9y3CHx0XmV8HAPFTGHgqixJRdjCUliTWiqa4pkpVMi1FPHl9U2cp2Xu3K+jG0xof/e3oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQLADtTUmcxu+IA/5gBv4GO0L7Lw2M+dmIz6saIi914=;
 b=jQmPan5g1VNcE4TUh05aiV5D2MmBECnbRCyjTNAMAug4uRjIla7kIB10DfhlvnpMUAAnGXfOlTCJXCa1N5t6ciEDXoYh/cWWQb4MYii0rnEmNBUgtJDBR7tS7bkiuPubIDC0WP3aA0jwZRrgybtuyOnjOuuYABOKUocqmBm4Z8BNdAdynLWsHcPBjHzQlJ5A2wmkfmclG2Oo8N66LYASE1G6XI86zZ/akNw8LsG/zR2W3HnPDrL4SbWjVgSU6TMa46b/yC8QELEeubVESo5wLlVeN/P4+tNQevUF9PVxtrOLCOLl7i/7YNBSepCDDGwIszVRiTTQGhaUmfHhtKwFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQLADtTUmcxu+IA/5gBv4GO0L7Lw2M+dmIz6saIi914=;
 b=YWgFs1cLmJkS61GUYmoNY2oBrl7E1Ggg7rtMAICr4+t7FRaf7j4JZv2P4Ol0q2tF8JS57kgSDFLNg4FXZVBx8wUDHl4djBtwxz5/5m+akF3e8bcsq6bfEY8xKUcqZzXN7X1F3MhSbWvN4P0DI7bz19ycqcV6rQ/4H185UBjLlPjIUpd6FTg4NZOEW4NsS5/I1240QM5fkb/orqykc75P89uDdfmCH/TpqI9XZe895xFu4RCTGXyp+4vesPnCNuz0rx67UDFvw96v605/iLveEhtMA8Z4/xTQOJ9sZ2v6PEZHvHQQTjehT/vIBwqo8hKfc2d01z0UOxB8PXstffk8iA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB6598.namprd03.prod.outlook.com (2603:10b6:a03:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:13:07 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:13:07 +0000
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
Subject: [PATCH v2 0/4] Add Intel Agilex5 SoCDK TSN Config2 board
Date: Mon,  6 Jul 2026 23:13:01 -0700
Message-ID: <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: e199d9e2-af12-4916-8317-08dedbeed009
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	reH/Luba8cHkeNTpB+o94mqwXFMZXvKMQ6S1/nmS+6IsRjHqW+/CCCIxGfruQLdV3nVPL71+ZyM8kRGqZGcEOrnRRCD9XofBbsE5SsTAmenldobBmRmTEzzzyZe8viMHB38G/Rs15F09EnymJm0FJOxrqkUTbJ91IS5GfAcmFiSWhNb4b499rbJn8iTldyyldnn5BGAS5/lsWNOu/tiFoCHsS+57RoHLp6j2CsEVmGpNta4EBk54yrhKTiheA2HZpi+CcEXc6XrLGF06e85wtL0hOyh11UCmfia916LIixnKs51A0x4l16jF8SyVpvMdluLiyf3L1Fd9neFQsOk+kvpFYqP4H82fRqUtpnr7saL2l6sKUsRaT8odoeAPTm83Vef0KEC4UajGjp9ENz34OepCOnhq5oLrFTTzCKKUa6Ng85iH+fVpQtjXs0/iDEYd5REJVxlCEc8+2L1aKNPP0PQVmlZZ1npVSKck/IVkXru/dfyGGvvaMRreji9UMKzT291Zsmg83LeibFnrJwkhinu8/ns13nepPFubrETpPSD+bT3GtwYFs87P+v1T8KmarFYzA42mCztRgSvFxVHjFxCy3yrC9aK1DYL5Y3b11/YfERpWGeBuLMS/n6Nqxh11CDkdiGnKYGcppJh9A3+eL35on3emIl7rQqNia6lLRGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4p3dQYqQvwwMzYAl+Mv/Z77/dywZxiaUN8qDokLWXUqOY8xy+ZTWDPhYuek?=
 =?us-ascii?Q?qB8+f8P6SUFqb0wGRHUSfio4QAaYNC6b+d2VUW4sgHdFACAN8uPgg1NMGDD7?=
 =?us-ascii?Q?MkGeK7uKtkUpfmIdRPR84Q6m0LZi6uLrz1BS6p+bqJ3254AHGGb4xhfHZS4C?=
 =?us-ascii?Q?pvrlKw8L2Af00Oz4R+nqPNwf/bvAmlCsvVdPEz3YctPzKSYdxhXDX0XUr8ID?=
 =?us-ascii?Q?B0meg3Ve50W4RW61bNzvRzh5hDLuL3tl6wlcbJmx+2/edlHJKBUSr9mRguR7?=
 =?us-ascii?Q?EiJ/aWAuLeXOSO4Yi+SRad9zfgCHFoeLlD77f4FYRNcFULzmMlG2BlrGLLcH?=
 =?us-ascii?Q?BKILvqJOUSVxFgU3FDd0/xWcODA3cPmv5iCvqcys5JPU8JJkYhjROaHK7ycx?=
 =?us-ascii?Q?mIb8WTQeREfiKA1zmuSjA8FOpoKbOGfOvSOhFrfUOJXTBTDDsRsmEvAAe3dM?=
 =?us-ascii?Q?XUpfiHHyWNbvMKXqw6U6kO3YOm2SqQv+zQptZgcoyWVCXFaiJSqgl5EUSZiV?=
 =?us-ascii?Q?Qg/CSD2KeJSkIwkRyOujqhUbw3SA/eWZaPRVEWY/BtkiSDDRJI1qDm2aWylm?=
 =?us-ascii?Q?iNwdCc7PaffB6RyYpqzdcrOn5kTWNv9z7sbRo98bTUM1e8e/zu3vWV9QFOdW?=
 =?us-ascii?Q?Gnt1w8Nm5MdBSmZ6rQB3mOTbThu+6dWC4Rck63f9x2LbhJo8OxXs/PB2kYT4?=
 =?us-ascii?Q?9t78R1yYu2A3MBLPhnkqfmaNEFKKO7lFhRtRJpR1v8iRwMssFRFaTNq8mBch?=
 =?us-ascii?Q?WBQuRpEZWGHUzd3ukfuqhIjFxaDEGqfKL/xdQ0PjCeBi/4T21NJd7Fnhj/q4?=
 =?us-ascii?Q?uhSD26+sTHQ6G+PYwKaIeuoTdspQU1fh48gDgZKHpUNn+DGwIRWQyBC1Q3y4?=
 =?us-ascii?Q?+CdnC2RSu6O+wPjglzzVPqjF1aka/4oVUi7xiMymEzsxujZ1mx/NZfZJGDpd?=
 =?us-ascii?Q?Y5wVjEjNN7wlgyTgwAo2k/ErRldSym2aYTxRJMoJtOG321E94nC7k4Suj+Ub?=
 =?us-ascii?Q?KEU93y5a2CRyfioIvDHB7DDPExOGD78OTzbgJ/BQHSSdsCzZgME45noTjr34?=
 =?us-ascii?Q?/7iEEpDzKnMAmlEFKULHc43fW57lAL59bH79qM7IFONs0bpIANL2e3Pi3O6p?=
 =?us-ascii?Q?9lplr6mrEYtb1apJbPjFLjSktd8hnNdjBTWeTPtVLma9GqsZTj2RO9MQLop2?=
 =?us-ascii?Q?mmw7OqH89WEsfD4BR22DrWDsWGJ8hnn5CsAi0dLlILabqDwawvtXuqs/pZuN?=
 =?us-ascii?Q?pKG2Uu91ZgABAeHXTrCE2LDlZYpBRwt0Uj7TnOONllxwsbY1jS6sAFdSazyD?=
 =?us-ascii?Q?qbfXFGU1QSg7ltgRUVQkG286O73A5hZy6l0QZu01mUJjC7i1wqNoMGinqvfK?=
 =?us-ascii?Q?MZ5s8u2tTNa0JNPA+KCntXL207JjausKkAMJEv+jOAPloNn+ly6AlUhcF4Xs?=
 =?us-ascii?Q?X4uAraP50xGQur+tb+uxdx+AGK18G+IY3kaqajXGGstBBb2lnzfcqOblU1r8?=
 =?us-ascii?Q?wGxY8SOfgR81BFL8gANFPdLeH3UhzOnPVbj1BgW04rEcQHLUHaviS7pSNhWL?=
 =?us-ascii?Q?Aky0OvuEkvOyhAmYd5yho2E8dg9D+T0V6N1PG5coLNOdTVGEPsvgd7pK26ej?=
 =?us-ascii?Q?t/fb3oTraUyc8lEk7YPuS0EELSLZXYrAAYTgOWivMZrWAiUoA2Bk4IEXIzOs?=
 =?us-ascii?Q?E87evnhxWXIjKymta5eF0TcZnPzIX2/3B4cJKIXlfTc4tBPGE5ueermN35sc?=
 =?us-ascii?Q?zL1Yhn1ld9TKNUmzCv7pEUwfI443laAHAQYDHB4dqsE8yjDVPKcfXoiOXVSh?=
X-MS-Exchange-AntiSpam-MessageData-1: B42cgGY41GFxYA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e199d9e2-af12-4916-8317-08dedbeed009
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:13:07.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxX+TFWMiEuIB7wNuCq7689Vh/avjm1y/ckO+zIVSBvNjUtOTNyqYdAAhcMo0nE3eq/tEW16oMiHVeF1/rb3F486H+fB/RoTwQiZOhUCrG6Hk9Hs6BAvRhK5dddUW/NdpWUNSS2hmBWt39tigHWWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6598
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305279-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB987717D9A

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

v2:
 - Replace mac-mode DT property with a board-specific compatible string
   "altr,socfpga-stmmac-agilex5-tsn" to identify gmac1 on the TSN Config2
   board, per Andrew Lunn's feedback.
 - Change phy-mode from "rgmii" to "rgmii-id" on both gmac1 and gmac2,
   since the FPGA GMII-to-RGMII converter provides the TX/RX clock delays
   (acting as MAC-side delays).
 - Add a new patch (3/4) documenting the new MAC compatible string in
   the altr,socfpga-stmmac binding.
 - Fix DTS Makefile indentation (Krzysztof Kozlowski).

---
This series adds DT binding, device tree, and driver support for the
Intel SoCFPGA Agilex5 SoCDK TSN Config2 board.

The board has two Ethernet ports: gmac2 is a standard RGMII port, while
gmac1 is the TSN port. On gmac1, an FPGA GMII-to-RGMII converter sits
between the MAC and the PHY. This converter provides the RGMII TX/RX
clock delays, so phy-mode is set to "rgmii-id". The driver uses the
new "altr,socfpga-stmmac-agilex5-tsn" compatible to detect this setup
and configure the MAC interface selector for GMII while ensuring the
PHY is not asked to add delays a second time.

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


