Return-Path: <netdev+bounces-259408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDf7D5mklmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:50:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97F15C2FE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 531E130090A3
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B12D0C9D;
	Thu, 19 Feb 2026 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h1W6QjMY"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A214B950;
	Thu, 19 Feb 2026 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480215; cv=fail; b=Ov7LD+5aPuGqaYlFV88BPq9x56KNT9MJCj+MM56xmzkhEWVLUOrqRRmhR1133VhZuB+hTXYjDm9ZJuv9V4NfMZpCD8zlki/mjNPhIY+j3O2Fb89czErBnLlQXY2KJZWfpsO3w0LdFN5abrpqbouw848H8kunBt0TRFn0ZcSNKpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480215; c=relaxed/simple;
	bh=PmPYTvgkpDQs6lJdojy/8MawkT+TS2u9PzITipqJwvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXKH1pBNow6uhEs2aAXQPC6RS6GNWBHK965F8+jhhSkklsdL6HFXWFgroX7+eJuxZNPq6fGplIPbtlQnrdrRMasVSO6Ft5uhjssRyPwhCm0bFNWTXIkNViYn05BJxafrUbbNv2uCFeQg8vVS8SpcHMTT7qOo7t/iGJAay3zfqdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h1W6QjMY; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOgTJNRbvdwff+Ob91ntSrlVjePT1wtv/R0wVM8MFxxiDOVkcCLUO3cDxn+GBsXrN5iwi8XgxZbz0BEEi122Gw921SJmlRbo1XalufDfrRSmKWoYS2dLG4SKCWImTlp/FafCnl8AnDN5wG6jQlOldvYXgfnv+xoZCOEi0MMHK6EAxLT0sPwg6XjdQ29y7I7fS4LDwyGXDOPZk51H8kHGL0B7PoB/dFFe4Mb84iTlgndCsC+cI89t3etsgpIyjIK+XvGjfao6w2Q/wfNgILUPGR/LHs/HLDjGkHNLRDXdm2tzhzAeozpHFq0e5lOtHrVTGI6d9ISvtoo2F2Qql0nEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx2GADJ2KoVJiEOs+cZl1O/vK/qTZbspQ71fbkTFs8w=;
 b=TUJKiaQL8WyhEFEwf+jTM/5dKQ347+WNsr59hdGUA3EN9JEnj1CsVhfkRt6GK7vZts7mUV2rUJ1oskHZ5q5frjEonzdFcIGn2fXHG/ory0SY3WQ7NUnGoTy7Meq3GbdFhNKORevD/0AgXUDldUbfcaiy1O4qZLlz0CMzTKw5kmGO8fQc+QSRSK9imsfOIg84F1t5T+qMgDglIxa/AH/0zagG0JD3mH90YB9ivZbovj95xsaqefqwCLrmI8uPM/rgVT9wZvsdfBGQunuz+6+bK17sPFIarofNFIeBkz6QoDK3kGmwnvJiRyqksucsYVa7AP8QC6HbzNu2S0SnmciuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx2GADJ2KoVJiEOs+cZl1O/vK/qTZbspQ71fbkTFs8w=;
 b=h1W6QjMYsbwMKVwrZo1Ip70gtsRLsInnQSSErK2jkJiZkjkeTzULi1O6oS1NR6FFzWeaLWIEZN65dC29IIg0FHNEfRRAsWz4ghdsD6rdRlWjMYwV09dGMJtuIZc5FV1fOhBb1UfsuJBt3s+bgcD7+MKNlbJBj0NsEjETJc4kkZI=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 05:50:05 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1a) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:50:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:50:01 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:57 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 8/8] net: xilinx: tsn: Add PTP packet transmission support
Date: Thu, 19 Feb 2026 11:19:11 +0530
Message-ID: <20260219054911.2017362-9-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: de267ba1-0ada-42aa-cbb8-08de6f7abb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ylAt2n02fl2rRsy0rVtwZDtlfhVRRVnnx2p7gjG5AkFjQLbiI9m537pP3yyX?=
 =?us-ascii?Q?WYNpBo7rm6is7iLqG5gAnBQu+Q20ICFHjbeV6oI3vHmZBd4+gI0st8pWlw3p?=
 =?us-ascii?Q?QqdzifoQqnoTQi338eDs7uWqsKHaPFOsxX9lnB5KP/zNEFwOPl+KGzbtxygT?=
 =?us-ascii?Q?QpciAhKp9jyuj3hrnhXOMYhmumeTpbOYn8KLDiWabR7Gv7vw/FfFPirzFxwQ?=
 =?us-ascii?Q?RYKmaSaSVGkOqaf601MyR9m2jDYSaDDoG1Mv+Yqv4JLUyOjBTfUiwVlnHMJd?=
 =?us-ascii?Q?xmmZlahKXCebKAuzY5DCUdRe8SULX6dzR6gmYZU5fZspkz0JrnOK7/h8l5or?=
 =?us-ascii?Q?eIkorpVTeY90DA5R0uDO9MPN3ToDw/xhah9mxk2wqjl3FvgKjBSjzukOUEqR?=
 =?us-ascii?Q?TuP0SZc1mBfu8gW9LcdptiREWt+2o1nDQeCO7xsJsEyjbw97GsnL8eNJ9oYg?=
 =?us-ascii?Q?SVsSVPOR6jJsU0FpiA9Lxubn4mHWhOudEoLzfIoOT6tyL56ANCHT92g+tmba?=
 =?us-ascii?Q?A9McHEeQa5UAXN9x42e8ONJZiWilvZrhrBBW/bD9tTls6oh52nWpstlPnDv7?=
 =?us-ascii?Q?cCaf6L4mzK/z4KWMPNQFFhnasA3SWIZ3cC4gnpppebZf7iIgBToXdHrqEEsO?=
 =?us-ascii?Q?WlPEXisS2Nrw51UbKUn9Mj5Ymt7rwVyxNccH0aQkwgnthU6hcG81rv+SiKS/?=
 =?us-ascii?Q?wcDBjnuJlDpfqwC2p9ol9OlIj2+CytZ+O7fRxxtM5+VQrNJDb7AaP8qSo4Ln?=
 =?us-ascii?Q?TcyejD0c3O9yg490o6R2XJy7j/EnqVytDe1J9tJdElWL40oCulPw/nfuEdA6?=
 =?us-ascii?Q?u8uWbF0sujYW359lySMC/SqnjY0NRGi+mW5wWRLh7eEbGBWB+H3ZYX157Aov?=
 =?us-ascii?Q?3Nk1v8vUPkiT52BGdiISzBJxx0plAmRRZoGVIoY0KgAGK+SIZNrgOaCnhXcT?=
 =?us-ascii?Q?Sw7o+yKVZcojtfCczTqBLtBmmDF/sRPlETtRXglg7sIGclp0KXX/11jwqzqg?=
 =?us-ascii?Q?gPI7vHhMbt1LH+nBeMdQ7zPZKun2K1n514rg7ZdtNW9tAEHDFrQk7j1dclAt?=
 =?us-ascii?Q?ykbdYgzZPwk9xjJvL+iOL5jAmT3WohJpmL8SPqEK995CoH+4jl4h2yJ0R1Yd?=
 =?us-ascii?Q?47qMP1FF2Xw18WQti1mChjYkA7oMg/Xzs+w1ADo7AAug8khWacWylGJus7xR?=
 =?us-ascii?Q?JqN2EzFZsSWTzxsmUGmUjPRwGPYCz9K9Q/9yAI9CqGJEknKgy7Aa3tRr7Wr7?=
 =?us-ascii?Q?XnaTx6PvtWPTjErwwsK43IFCJThrtlRuJhownaU8AVovCoucetrOPwSQhp8k?=
 =?us-ascii?Q?dpjLsWL5y+NSjdaayKEnMnYrqNt5+WRJtKDyblTxIIdFgSn44NTYOSxzdpe0?=
 =?us-ascii?Q?YJkczh4ewbmlEUy95ZwitooGniuyRVcJ6lWrQzqwTOfzjGy4n/2mjY5wWkVe?=
 =?us-ascii?Q?ZfLLx7OL08FuVOdX94zijgj7okHRqTMszn1iRogbUEXNVYXo6xLQXgICqbFe?=
 =?us-ascii?Q?ppmc4fcGGaQGig1O4eM+miANkfAQHKWL8MLJVal62RzA4ASOndwxgjaJOKl+?=
 =?us-ascii?Q?LrtMRtahu1VgX9JrR0nqQKkqN+XDjJ2XU0sxZvQTjJCOnIWKQRra7byKTwgF?=
 =?us-ascii?Q?MgI4FQON967u8D3S4a5LHhvRVCyr6XoMDnFY+jSDNEw3jPY7aMH2qWEIbbOu?=
 =?us-ascii?Q?tbRJUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DW5vuxgBfQkKckZ7iWf7NX/wbitczVvzHVQKIQlMUTSCOtG0TBjxGgQB/IDfDQZJxYEO6Fj7GgL2caK++q+vgULFTA80OhRpHIAquAMiiDo9XPTKiOibVxonNiO7Of+yt+tX+Dac98oHWeEG2473MGP8ZOfuiiePkmUSwypwZERpKQCFihSpkX/xD1evezJxD/fHUoqqXt2brrMm0y7CLAQc1fuhx9d3AkP8YfjIr42LA2erDMqub0fyLRxgj0OzHCILx2TzScDukJNrYqcrAZIKNdyffp4lxVDpGkIlo24vTWehSI4dA5/TK2ut1fTofpJTkb3jDI0uQPbovhu0p5nmzrB4DF+BLuFf8TXbd1/SQuZXBaq0xjQ94rVWKlvKcMG6GEWgTL8tdLMHJ9lIRmzlCTzVcs8EPwPD+e1JwBDiw5sVzMGoAaIXBgSlPT53
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:50:05.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de267ba1-0ada-42aa-cbb8-08de6f7abb7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259408-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EA97F15C2FE
X-Rspamd-Action: no action

Add support for PTP (Precision Time Protocol) packet transmission
and timestamping for Xilinx TSN Ethernet MAC. This implementation
provides hardware-assisted packet timestamping for IEEE 1588 PTP
synchronization.

Key features added:
- PTP TX/RX buffer management with 8 TX and 16 RX buffers
- Hardware timestamp extraction for transmitted and received packets
- Dedicated PTP packet queue and transmission path
- Interrupt-driven timestamp retrieval via work queues
- Support for 2-step PTP mode (HWTSTAMP_TX_ON)
- PTP packet filtering based on ETH_P_1588 ethertype

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  58 +++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_emac.c | 178 ++++++-
 .../ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c | 451 ++++++++++++++++++
 4 files changed, 683 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 0faa5233221b..a39cc7ca1533 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
-xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o xilinx_tsn_switch.o xilinx_tsn_ptp_clock.o
+xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o xilinx_tsn_switch.o xilinx_tsn_ptp_clock.o xilinx_tsn_ptp_xmit.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
index 0cce916825ea..c8339ecef2f6 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -137,6 +137,37 @@
 /* PTP Timer Register Base Offset */
 #define TSN_PTP_TIMER_OFFSET		0x12800
 
+/* PTP register offsets */
+#define PTP_TX_CONTROL_OFFSET		0x00012000
+#define PTP_RX_CONTROL_OFFSET		0x00012004
+
+/* PTP RX buffer configuration */
+#define PTP_RX_BASE_OFFSET		0x00010000
+#define PTP_RX_PACKET_FIELD_MASK	0x00000F00
+#define PTP_RX_PACKET_CLEAR		0x00000001
+
+/* PTP TX buffer configuration */
+#define PTP_TX_BUFFER_OFFSET(index)	(0x00011000 + (index) * 0x100)
+#define PTP_TX_CMD_FIELD_LEN		8
+#define PTP_TX_CMD_1STEP_SHIFT		BIT(16)
+#define PTP_TX_BUFFER_CMD2_FIELD	0x4
+
+/* PTP TX control and status masks */
+#define PTP_TX_FRAME_WAITING_MASK	0x0000ff00
+#define PTP_TX_FRAME_WAITING_SHIFT	8
+#define PTP_TX_PACKET_FIELD_MASK	0x00070000
+#define PTP_TX_PACKET_FIELD_SHIFT	16
+
+/* PTP timestamp and buffer definitions */
+#define PTP_HW_TSTAMP_SIZE		8	/* 64 bit timestamp */
+#define PTP_RX_HWBUF_SIZE		256
+#define PTP_RX_FRAME_SIZE		252
+#define PTP_HW_TSTAMP_OFFSET		(PTP_RX_HWBUF_SIZE - PTP_HW_TSTAMP_SIZE)
+
+/* PTP message type definitions */
+#define PTP_MSG_TYPE_MASK		BIT(3)
+#define PTP_TYPE_SYNC			0x0
+
 /**
  * struct tsn_ptp_timer - PTP timer private data
  * @dev: Device pointer
@@ -175,6 +206,16 @@ struct tsn_ptp_timer {
  * @mii_clk_div: MDIO clock divider value
  * @emac_num: EMAC instance number (1 or 2)
  * @irq: Interrupt number for this EMAC
+ * @ptp_rx_irq: PTP RX interrupt number
+ * @ptp_tx_irq: PTP TX interrupt number
+ * @ptp_txq: PTP TX packet queue for timestamping
+ * @ptp_tx_lock: Spinlock for PTP TX queue
+ * @tx_tstamp_work: Work structure for TX timestamp processing
+ * @ptp_rx_hw_pointer: Hardware pointer for PTP RX packets
+ * @ptp_rx_sw_pointer: Software pointer for PTP RX packets
+ * @ptp_ts_type: PTP timestamp type configuration
+ * @tstamp_config: Hardware timestamp config structure
+ * @current_rx_filter : Current rx filter
  */
 struct tsn_emac {
 	struct net_device *ndev;
@@ -189,6 +230,16 @@ struct tsn_emac {
 	u8 mii_clk_div;
 	int emac_num;
 	int irq;
+	int ptp_rx_irq;
+	int ptp_tx_irq;
+	struct sk_buff_head ptp_txq;
+	spinlock_t ptp_tx_lock;  /* Protect PTP TX queue */
+	struct work_struct tx_tstamp_work;
+	u8 ptp_rx_hw_pointer;
+	u8 ptp_rx_sw_pointer;
+	int ptp_ts_type;
+	struct hwtstamp_config tstamp_config;
+	int current_rx_filter;
 };
 
 /*
@@ -369,4 +420,11 @@ int tsn_switch_init(struct platform_device *pdev);
 void tsn_switch_exit(struct platform_device *pdev);
 int tsn_ptp_timer_init(struct tsn_emac *emac, struct device_node *emac_np);
 void tsn_ptp_timer_exit(struct tsn_emac *emac);
+int tsn_ptp_get_irq_info(struct tsn_emac *emac, struct device_node *emac_np);
+int tsn_ptp_init_and_register_irqs(struct tsn_emac *emac);
+void tsn_ptp_unregister_irqs(struct tsn_emac *emac);
+int tsn_ptp_xmit(struct sk_buff *skb, struct tsn_emac *emac);
+void tsn_ptp_tx_tstamp(struct work_struct *work);
+irqreturn_t tsn_ptp_rx_irq(int irq, void *data);
+irqreturn_t tsn_ptp_tx_irq(int irq, void *data);
 #endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
index b7d7ba0de717..4d0780a29fc9 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_emac.c
@@ -61,16 +61,28 @@ static int emac_open(struct net_device *ndev)
 {
 	struct tsn_emac *emac = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
+	int ret;
+
+	/* Register PTP interrupts */
+	ret = tsn_ptp_init_and_register_irqs(emac);
+	if (ret) {
+		dev_err(emac->common->dev,
+			"EMAC %d: Failed to register PTP interrupts: %d\n",
+			emac->emac_num, ret);
+		return ret;
+	}
 
 	if (emac->phy_node) {
 		phydev = of_phy_connect(emac->ndev, emac->phy_node,
 					tsn_adjust_link_tsn,
 					emac->phy_flags,
 					emac->phy_mode);
-		if (!phydev)
+		if (!phydev) {
 			dev_err(emac->common->dev, "of_phy_connect() failed\n");
-		else
-			phy_start(phydev);
+			tsn_ptp_unregister_irqs(emac);
+			return -ENODEV;
+		}
+		phy_start(phydev);
 	}
 
 	return 0;
@@ -87,9 +99,13 @@ static int emac_open(struct net_device *ndev)
  */
 static int emac_stop(struct net_device *ndev)
 {
+	struct tsn_emac *emac = netdev_priv(ndev);
+
 	if (ndev->phydev)
 		phy_disconnect(ndev->phydev);
 
+	tsn_ptp_unregister_irqs(emac);
+
 	return 0;
 }
 
@@ -120,16 +136,158 @@ static int emac_validate_addr(struct net_device *ndev)
 static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct tsn_emac *emac = netdev_priv(ndev);
+	u16 queue = skb_get_queue_mapping(skb);
+
+	if (queue == emac->common->num_priorities)
+		return tsn_ptp_xmit(skb, emac);
 
 	return tsn_start_xmit_dmaengine(emac->common, skb, ndev);
 }
 
+/**
+ * emac_select_queue - select queue for packet transmission
+ * @ndev:	Pointer to net_device structure
+ * @skb:	socket buffer containing the packet
+ * @sb_dev:	fallback device (not used)
+ *
+ * Return:	Queue index for PTP packets or default queue
+ *
+ * This function selects the appropriate queue for packet transmission.
+ * PTP packets (ETH_P_1588) are directed to a dedicated PTP queue.
+ */
+static u16 emac_select_queue(struct net_device *ndev,
+			     struct sk_buff *skb,
+			     struct net_device *sb_dev)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+	struct tsn_priv *common = emac->common;
+	struct ethhdr *hdr = (struct ethhdr *)skb->data;
+
+	/* PTP over Ethernet (Layer 2) */
+	if (hdr->h_proto == htons(ETH_P_1588))
+		return common->num_priorities;
+	return netdev_pick_tx(ndev, skb, sb_dev);
+}
+
+/**
+ *  emac_set_timestamp_mode - sets up the hardware for the requested mode
+ *  @emac:	Pointer to TSN EMAC structure
+ *  @config:	the hwtstamp configuration requested
+ *
+ * Return:	0 on success, Negative value on errors
+ */
+static int emac_set_timestamp_mode(struct tsn_emac *emac,
+				   struct hwtstamp_config *config)
+{
+	/* reserved for future extensions */
+	if (config->flags)
+		return -EINVAL;
+
+	if (config->tx_type < HWTSTAMP_TX_OFF ||
+	    config->tx_type > HWTSTAMP_TX_ON)
+		return -ERANGE;
+
+	emac->ptp_ts_type = config->tx_type;
+
+	/* On RX always timestamp everything */
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		emac->current_rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		emac->current_rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
+/**
+ * emac_set_ts_config - user entry point for timestamp mode
+ * @emac:	Pointer to TSN EMAC structure
+ * @ifr:	ioctl data
+ *
+ * Set hardware to the requested more. If unsupported return an error
+ * with no changes. Otherwise, store the mode for future reference
+ *
+ * Return:	0 on success, Negative value on errors
+ */
+static int emac_set_ts_config(struct tsn_emac *emac, struct ifreq *ifr)
+{
+	struct hwtstamp_config config;
+	int err;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	err = emac_set_timestamp_mode(emac, &config);
+	if (err)
+		return err;
+
+	/* save these settings for future reference */
+	memcpy(&emac->tstamp_config, &config, sizeof(emac->tstamp_config));
+
+	return copy_to_user(ifr->ifr_data, &config,
+			sizeof(config)) ? -EFAULT : 0;
+}
+
+/**
+ * emac_get_ts_config - return the current timestamp configuration
+ * to the user
+ * @emac:	pointer to TSN EMAC structure
+ * @ifr:	ioctl data
+ *
+ * Return:	0 on success, Negative value on errors
+ */
+static int emac_get_ts_config(struct tsn_emac *emac, struct ifreq *ifr)
+{
+	struct hwtstamp_config *config = &emac->tstamp_config;
+
+	return copy_to_user(ifr->ifr_data, config,
+			    sizeof(*config)) ? -EFAULT : 0;
+}
+
+/**
+ * emac_ioctl - Ioctl MII Interface
+ * @dev:	Pointer to net_device structure
+ * @rq:	ioctl request structure
+ * @cmd:	ioctl command
+ *
+ * Return:	0 on success, Negative value on errors
+ */
+static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct tsn_emac *emac = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+	case SIOCGMIIREG:
+	case SIOCSMIIREG:
+		if (!dev->phydev)
+			return -EOPNOTSUPP;
+		return phy_mii_ioctl(dev->phydev, rq, cmd);
+	case SIOCSHWTSTAMP:
+		return emac_set_ts_config(emac, rq);
+	case SIOCGHWTSTAMP:
+		return emac_get_ts_config(emac, rq);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open		= emac_open,
 	.ndo_stop		= emac_stop,
 	.ndo_start_xmit		= emac_start_xmit,
 	.ndo_set_mac_address	= tsn_ndo_set_mac_address,
 	.ndo_validate_addr	= emac_validate_addr,
+	.ndo_select_queue	= emac_select_queue,
+	.ndo_eth_ioctl		= emac_ioctl,
 };
 
 /**
@@ -171,7 +329,7 @@ static int emac_get_ts_info(struct net_device *ndev,
 			 BIT(HWTSTAMP_TX_ON);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-			   BIT(HWTSTAMP_FILTER_ALL);
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT);
 
 	if (common->phc_index >= 0)
 		info->phc_index = common->phc_index;
@@ -225,7 +383,9 @@ int tsn_emac_init(struct platform_device *pdev)
 			goto err_cleanup_all;
 		}
 
-		ndev = alloc_etherdev(sizeof(*emac));
+		ndev = alloc_etherdev_mqs(sizeof(*emac),
+					  common->num_tx_queues + 1,
+					  common->num_rx_queues);
 		if (!ndev) {
 			ret = -ENOMEM;
 			of_node_put(emac_np);
@@ -279,6 +439,14 @@ int tsn_emac_init(struct platform_device *pdev)
 				goto err_teardown_mdio;
 			}
 		}
+
+		ret = tsn_ptp_get_irq_info(emac, emac_np);
+		if (ret) {
+			dev_err(dev, "Failed to get PTP IRQ info for EMAC %d: %d\n",
+				emac->emac_num, ret);
+			goto err_remove_ptp;
+		}
+
 		ret = register_netdev(ndev);
 		if (ret) {
 			dev_err(dev, "Failed to register net device for MAC %d\n", mac_id);
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c
new file mode 100644
index 000000000000..0a2850ed42ad
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ptp_xmit.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Xilinx FPGA Xilinx TSN PTP transfer protocol module.
+ *
+ */
+
+#include "xilinx_tsn.h"
+
+/**
+ * ptp_iow - write to PTP register
+ * @emac: Pointer to TSN EMAC structure
+ * @off: Register offset
+ * @val: Value to write
+ *
+ * This function writes to PTP control registers.
+ */
+static inline void ptp_iow(struct tsn_emac *emac, off_t off, u32 val)
+{
+	iowrite32(val, emac->regs + off);
+}
+
+/**
+ * ptp_ior - read from PTP register
+ * @emac: Pointer to TSN EMAC structure
+ * @off: Register offset
+ *
+ * Return: Register value
+ *
+ * This function reads from PTP control registers.
+ */
+static inline u32 ptp_ior(struct tsn_emac *emac, u32 off)
+{
+	return ioread32(emac->regs + off);
+}
+
+/**
+ * memcpy_fromio_32 - copy ptp buffer from HW
+ * @emac: Pointer to TSN EMAC structure
+ * @offset: Offset in the PTP buffer
+ * @data: Destination buffer
+ * @len: Length to copy
+ *
+ * This functions copies the data from PTP buffer to destination data buffer
+ */
+static void memcpy_fromio_32(struct tsn_emac *emac,
+			     unsigned long offset, u8 *data, size_t len)
+{
+	while (len >= 4) {
+		*(u32 *)data = ptp_ior(emac, offset);
+		len -= 4;
+		offset += 4;
+		data += 4;
+	}
+
+	if (len > 0) {
+		u32 leftover = ptp_ior(emac, offset);
+		u8 *src = (u8 *)&leftover;
+
+		while (len) {
+			*data++ = *src++;
+			len--;
+		}
+	}
+}
+
+/**
+ * memcpy_toio_32 - copy ptp buffer to HW
+ * @emac: Pointer to TSN EMAC structure
+ * @offset: Offset in the PTP buffer
+ * @data: Source data
+ * @len: Length to copy
+ *
+ * This functions copies the source data to destination ptp buffer
+ */
+static void memcpy_toio_32(struct tsn_emac *emac,
+			   unsigned long offset, u8 *data, size_t len)
+{
+	while (len >= 4) {
+		ptp_iow(emac, offset, *(u32 *)data);
+		len -= 4;
+		offset += 4;
+		data += 4;
+	}
+
+	if (len > 0) {
+		u32 leftover = 0;
+		u8 *dest = (u8 *)&leftover;
+
+		while (len) {
+			*dest++ = *data++;
+			len--;
+		}
+		ptp_iow(emac, offset, leftover);
+	}
+}
+
+/**
+ * tsn_ptp_xmit - xmit skb using PTP HW
+ * @skb: sk_buff pointer that contains data to be Txed.
+ * @emac: Pointer to TSN EMAC structure.
+ *
+ * Return: NETDEV_TX_OK, on success
+ *         NETDEV_TX_BUSY, if any of the descriptors are not free
+ *
+ * This function is called to transmit a PTP skb. The function uses
+ * the free PTP TX buffer entry and sends the frame
+ */
+int tsn_ptp_xmit(struct sk_buff *skb, struct tsn_emac *emac)
+{
+	u16 queue = skb_get_queue_mapping(skb);
+	u8 tx_frame_waiting;
+	u32 cmd1_field = 0;
+	u32 cmd2_field = 0;
+	u8 free_index;
+
+	tx_frame_waiting = (ptp_ior(emac, PTP_TX_CONTROL_OFFSET) &
+			    PTP_TX_FRAME_WAITING_MASK) >>
+			    PTP_TX_FRAME_WAITING_SHIFT;
+
+	/* we reached last frame */
+	if (tx_frame_waiting & (1 << 7)) {
+		netif_stop_subqueue(emac->ndev, queue);
+		emac->ndev->stats.tx_dropped++;
+		netdev_dbg(emac->ndev, "PTP TX buffers full: 0x%x\n", tx_frame_waiting);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* go to next available slot */
+	free_index  = fls(tx_frame_waiting);
+
+	cmd1_field |= skb->len;
+
+	ptp_iow(emac, PTP_TX_BUFFER_OFFSET(free_index), cmd1_field);
+	ptp_iow(emac, PTP_TX_BUFFER_OFFSET(free_index) +
+		PTP_TX_BUFFER_CMD2_FIELD, cmd2_field);
+	memcpy_toio_32(emac,
+		       (PTP_TX_BUFFER_OFFSET(free_index) +
+			PTP_TX_CMD_FIELD_LEN),
+		       skb->data, skb->len);
+
+	/* send the frame */
+	ptp_iow(emac, PTP_TX_CONTROL_OFFSET, (1 << free_index));
+
+	scoped_guard(spinlock_irq, &emac->ptp_tx_lock) {
+		skb->cb[0] = free_index;
+		skb_queue_tail(&emac->ptp_txq, skb);
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	}
+	skb_tx_timestamp(skb);
+
+	return NETDEV_TX_OK;
+}
+
+/**
+ * tsn_set_timestamp - timestamp skb with HW timestamp
+ * @emac: Pointer to TSN EMAC structure
+ * @hwtstamps: Pointer to skb timestamp structure
+ * @offset: offset of the timestamp in the PTP buffer
+ *
+ * Return:	None.
+ *
+ */
+static void tsn_set_timestamp(struct tsn_emac *emac,
+			      struct skb_shared_hwtstamps *hwtstamps,
+			      unsigned int offset)
+{
+	u32 captured_ns;
+	u32 captured_sec;
+
+	captured_ns = ptp_ior(emac, offset + 4);
+	captured_sec = ptp_ior(emac, offset);
+
+	hwtstamps->hwtstamp = ktime_set(captured_sec, captured_ns);
+}
+
+/**
+ * tsn_ptp_recv - receive ptp buffer in skb from HW
+ * @ndev: Pointer to net_device structure.
+ *
+ * This function is called from the ptp rx isr. It allocates skb, and
+ * copies the ptp rx buffer data to it and calls netif_rx for further
+ * processing.
+ *
+ */
+static void tsn_ptp_recv(struct net_device *ndev)
+{
+	struct tsn_emac *emac = netdev_priv(ndev);
+	unsigned long ptp_frame_base_addr = 0;
+	struct sk_buff *skb;
+	u16 msg_len;
+	u8 msg_type;
+	u32 bytes = 0;
+	u32 packets = 0;
+
+	if (!ndev || !netif_running(ndev))
+		return;
+
+	while (((emac->ptp_rx_hw_pointer & 0xf) !=
+		 (emac->ptp_rx_sw_pointer & 0xf))) {
+		skb = netdev_alloc_skb(ndev, PTP_RX_FRAME_SIZE);
+		if (!skb) {
+			ndev->stats.rx_dropped++;
+			emac->ptp_rx_sw_pointer += 1;
+			continue;
+		}
+		emac->ptp_rx_sw_pointer += 1;
+
+		ptp_frame_base_addr = PTP_RX_BASE_OFFSET +
+				   ((emac->ptp_rx_sw_pointer & 0xf) *
+				    PTP_RX_HWBUF_SIZE);
+
+		memcpy_fromio_32(emac, ptp_frame_base_addr, skb->data,
+				 PTP_RX_FRAME_SIZE);
+
+		msg_type  = *(u8 *)(skb->data + ETH_HLEN) & 0xf;
+		msg_len  = *(u16 *)(skb->data + ETH_HLEN + 2);
+
+		skb_put(skb, ntohs(msg_len) + ETH_HLEN);
+
+		bytes += skb->len;
+		packets++;
+
+		skb->protocol = eth_type_trans(skb, ndev);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		/* timestamp only event messages */
+		if (!(msg_type & PTP_MSG_TYPE_MASK)) {
+			tsn_set_timestamp(emac, skb_hwtstamps(skb),
+					  (ptp_frame_base_addr +
+					   PTP_HW_TSTAMP_OFFSET));
+		}
+
+		netif_rx(skb);
+	}
+	ndev->stats.rx_packets += packets;
+	ndev->stats.rx_bytes += bytes;
+}
+
+/**
+ * tsn_ptp_rx_irq - PTP RX ISR handler
+ * @irq: irq number
+ * @data: net_device pointer
+ *
+ * Return:	IRQ_HANDLED for all cases.
+ */
+irqreturn_t tsn_ptp_rx_irq(int irq, void *data)
+{
+	struct tsn_emac *emac = data;
+
+	emac->ptp_rx_hw_pointer = (ptp_ior(emac, PTP_RX_CONTROL_OFFSET)
+					& PTP_RX_PACKET_FIELD_MASK)  >> 8;
+
+	tsn_ptp_recv(emac->ndev);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tsn_ptp_tx_tstamp - timestamp skb on transmit path
+ * @work: Pointer to work_struct structure
+ *
+ * This adds TX timestamp to skb
+ */
+void tsn_ptp_tx_tstamp(struct work_struct *work)
+{
+	struct tsn_emac *emac = container_of(work, struct tsn_emac,
+			tx_tstamp_work);
+	struct net_device *ndev = emac->ndev;
+	struct skb_shared_hwtstamps hwtstamps;
+	struct sk_buff *skb;
+	unsigned long ts_reg_offset;
+	unsigned long flags;
+	u8 tx_packet;
+	u8 index;
+	u32 bytes = 0;
+	u32 packets = 0;
+
+	memset(&hwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+	spin_lock_irqsave(&emac->ptp_tx_lock, flags);
+
+	tx_packet =  (ptp_ior(emac, PTP_TX_CONTROL_OFFSET) &
+				PTP_TX_PACKET_FIELD_MASK) >>
+				PTP_TX_PACKET_FIELD_SHIFT;
+
+	while ((skb = __skb_dequeue(&emac->ptp_txq)) != NULL) {
+		index = skb->cb[0];
+
+		/* dequeued packet yet to be xmited? */
+		if (index > tx_packet) {
+			/* enqueue it back and break */
+			skb_queue_tail(&emac->ptp_txq, skb);
+			break;
+		}
+		/* time stamp reg offset */
+		ts_reg_offset = PTP_TX_BUFFER_OFFSET(index) +
+					PTP_HW_TSTAMP_OFFSET;
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) {
+			tsn_set_timestamp(emac, &hwtstamps, ts_reg_offset);
+			skb_tstamp_tx(skb, &hwtstamps);
+		}
+
+		bytes += skb->len;
+		packets++;
+		dev_kfree_skb_any(skb);
+	}
+	ndev->stats.tx_packets += packets;
+	ndev->stats.tx_bytes += bytes;
+
+	spin_unlock_irqrestore(&emac->ptp_tx_lock, flags);
+}
+
+/**
+ * tsn_ptp_tx_irq - PTP TX irq handler
+ * @irq: irq number
+ * @data: net_device pointer
+ *
+ * Return: IRQ_HANDLED for all cases.
+ *
+ */
+irqreturn_t tsn_ptp_tx_irq(int irq, void *data)
+{
+	struct tsn_emac *emac = data;
+
+	if (!emac || !emac->ndev || !emac->common)
+		return IRQ_HANDLED;
+
+	/* read ctrl register to clear the interrupt */
+	ptp_ior(emac, PTP_TX_CONTROL_OFFSET);
+
+	schedule_work(&emac->tx_tstamp_work);
+	if (__netif_subqueue_stopped(emac->ndev, emac->common->num_priorities))
+		netif_wake_subqueue(emac->ndev, emac->common->num_priorities);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tsn_ptp_get_irq_info - Get PTP interrupt information from device tree
+ * @emac: Pointer to TSN EMAC structure
+ * @emac_np: Device tree node for EMAC
+ *
+ * Return: 0 on success, negative error code on failure
+ *
+ * This function retrieves PTP RX and TX interrupt numbers from device tree.
+ */
+int tsn_ptp_get_irq_info(struct tsn_emac *emac, struct device_node *emac_np)
+{
+	struct device *dev = emac->common->dev;
+
+	emac->ptp_rx_irq = of_irq_get_byname(emac_np, "interrupt_ptp_rx");
+	if (emac->ptp_rx_irq < 0) {
+		dev_err(dev,
+			"EMAC %d: Failed to get mandatory 'interrupt_ptp_rx': %d\n",
+			emac->emac_num, emac->ptp_rx_irq);
+		return emac->ptp_rx_irq;
+	}
+
+	emac->ptp_tx_irq = of_irq_get_byname(emac_np, "interrupt_ptp_tx");
+	if (emac->ptp_tx_irq < 0) {
+		dev_err(dev,
+			"EMAC %d: Failed to get mandatory 'interrupt_ptp_tx': %d\n",
+			emac->emac_num, emac->ptp_tx_irq);
+		return emac->ptp_tx_irq;
+	}
+
+	dev_info(dev, "EMAC %d: PTP IRQs - RX: %d, TX: %d\n",
+		 emac->emac_num, emac->ptp_rx_irq, emac->ptp_tx_irq);
+
+	return 0;
+}
+
+/**
+ * tsn_ptp_init_and_register_irqs - Initialize PTP subsystem and register interrupts
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * Return: 0 on success, negative error code on failure
+ *
+ * This function initializes the PTP packet handling subsystem and registers
+ * interrupt handlers for PTP RX and TX events.
+ */
+int tsn_ptp_init_and_register_irqs(struct tsn_emac *emac)
+{
+	struct device *dev = emac->common->dev;
+	int ret;
+
+	/* Initialize PTP TX queue and lock */
+	skb_queue_head_init(&emac->ptp_txq);
+	spin_lock_init(&emac->ptp_tx_lock);
+	INIT_WORK(&emac->tx_tstamp_work, tsn_ptp_tx_tstamp);
+
+	/* Initialize PTP RX pointers */
+	emac->current_rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+	emac->ptp_ts_type = HWTSTAMP_TX_ON;
+	emac->ptp_rx_hw_pointer = 0;
+	emac->ptp_rx_sw_pointer = 0xff;
+
+	/* Clear PTP RX control register */
+	ptp_iow(emac, PTP_RX_CONTROL_OFFSET, PTP_RX_PACKET_CLEAR);
+
+	/* Register PTP RX interrupt */
+	ret = request_irq(emac->ptp_rx_irq, tsn_ptp_rx_irq, 0,
+			  "tsn_ptp_rx", emac);
+	if (ret) {
+		dev_err(dev, "EMAC %d: Failed to register PTP RX IRQ %d: %d\n",
+			emac->emac_num, emac->ptp_rx_irq, ret);
+		return ret;
+	}
+
+	/* Register PTP TX interrupt */
+	ret = request_irq(emac->ptp_tx_irq, tsn_ptp_tx_irq, 0,
+			  "tsn_ptp_tx", emac);
+	if (ret) {
+		dev_err(dev, "EMAC %d: Failed to register PTP TX IRQ %d: %d\n",
+			emac->emac_num, emac->ptp_tx_irq, ret);
+		free_irq(emac->ptp_rx_irq, emac);
+		return ret;
+	}
+
+	dev_info(dev, "EMAC %d: PTP interrupts registered\n", emac->emac_num);
+	return 0;
+}
+
+/**
+ * tsn_ptp_unregister_irqs - Unregister PTP interrupts
+ * @emac: Pointer to TSN EMAC structure
+ *
+ * This function unregisters PTP RX and TX interrupt handlers and cleans up
+ * PTP TX queue. Called during interface close.
+ */
+void tsn_ptp_unregister_irqs(struct tsn_emac *emac)
+{
+	struct sk_buff *skb;
+
+	if (emac->ptp_tx_irq > 0)
+		free_irq(emac->ptp_tx_irq, emac);
+
+	if (emac->ptp_rx_irq > 0)
+		free_irq(emac->ptp_rx_irq, emac);
+
+	cancel_work_sync(&emac->tx_tstamp_work);
+
+	while ((skb = skb_dequeue(&emac->ptp_txq)) != NULL)
+		dev_kfree_skb_any(skb);
+
+	dev_info(emac->common->dev, "EMAC %d: PTP interrupts unregistered\n",
+		 emac->emac_num);
+}
-- 
2.25.1


