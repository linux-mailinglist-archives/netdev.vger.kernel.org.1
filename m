Return-Path: <netdev+bounces-141459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B89BB01C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD01B24C67
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC341AE01D;
	Mon,  4 Nov 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="JVTkm9mU"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC0189BB3;
	Mon,  4 Nov 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713524; cv=fail; b=P9LRXxMj+J/xt2B5wc2uExIqKuHf0ZUcmNWprVsBARM9pfblom2d7bBSj+atsJxPEQ6QBntOvEdc0H8Z9tC/OUsQqcYHmbyP5qhUkV+U6Z//J9x7zy8D2Ih4aBW3pnD8ZSwrk9Iox08L8va+YlfRALU24EXTKD6AysTvQSL8exI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713524; c=relaxed/simple;
	bh=ANwIFQh1XNwk2S1cnVw6cdFCKkdtgK7BB/BXHeX34iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/h7yUaToAloYUa5m2dXA01o5ZBW7ci/exvVJTm2Ovr7sIPWOLKKoyVd0Lq+DS/2AIgtI+WaIcnmHpdzB4/3sJ/AjciwXL6KVPop3PFTIeYl/8DasFcT1CBHnjPNzfKeh7O5AIZz0QyKAxk9vxsYi+cWSMV/9nw9DX336/B/Z6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=JVTkm9mU; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP6rOYxolem7QrnrNN2W5lvpEA1kKxhdR1csOxH8UpWmTHixFzGXFsy75nyztSSEMMUJleGuzCtvgrPZDsMaH45kBFUOmybdwszVuGucb0Gs45R22tk6Tf6gBo55dG0FCh8aIBfflC/YNUyDJmQLpI+pka1TZ/rzcgJu2hkhNG4I1aF+dDtunSm5A0NEZtPcrP67qziaYsLm4YRFyQSVbLDtcHy+sRAu/OBURLbRE6OWCwhQ2uL3fwl5l3MF3vRoFGqic+0VaBP/sNtaF5R96SCwRT9it+isoE0mJ70+7L2QYjq2TQM1EUZECJj0ZZ09jBmhU6ZqftW6bqBfYifbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CVB7DGPsHwnsQCoXB7SBZjklEmEnihl9vo2LqNcsog=;
 b=vn4H09n8pOdvaWmFV3bnyNs+QVLMb4V4ItkhghMxKkpQ8Wm0We640VYW6enQOFy+eT599QWqGQg9UpEtlsqs+j+rGMMrBHAfqRMoiZ4YfJOs9UpY7PqNbEIQTghVeStDcGtt317YNNzZrctTDGC2BkNsHZfg9STvRBhDB7trtJG5e3qHaa5VPpyWYzNgpYnvG2+KWxvearVwtEZKtZeBGbzzRpGgdJAmPmGdZFHIWk5CwEnc0J90/NXXPzYJdNH2t1RcFuAUhflspQeEpztEmBWb9Z/iNJDG20X30BRM5hWJMRsaeS74y8fyakVfuVErPkigK35OxQ/P8x50YfNkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CVB7DGPsHwnsQCoXB7SBZjklEmEnihl9vo2LqNcsog=;
 b=JVTkm9mUoN1ZdlET3miYA2r3NSboO8nVbV4+xkcDOe2Rzu+1OzfrnDrqbSaYzHTh7dtPuLHVqtO4aXWq6ihnNB67O9cK/61QZRwSSMo2/hiZpBdTTOIUuG9uJyFP+D+c46BHZkEUe/Drl7nxrPImELZQSSZffJwLuxavMhpLVPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by TYZPR02MB5764.apcprd02.prod.outlook.com (2603:1096:400:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 09:45:13 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%5]) with mapi id 15.20.8114.020; Mon, 4 Nov 2024
 09:45:12 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 1/3] wwan: core: Add WWAN ADB and MIPC port type
Date: Mon,  4 Nov 2024 17:44:34 +0800
Message-Id: <20241104094436.466861-2-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104094436.466861-1-jinjian.song@fibocom.com>
References: <20241104094436.466861-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|TYZPR02MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8d4c42-9943-4689-13f8-08dcfcb560ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/zaCN5Vplyu1GS6pbNDgqPbvIkdXkYVSX76iRBnq06HVm5Hm7FFL0wW2y1IH?=
 =?us-ascii?Q?kF6yyZEII69GkQOtYamQI8J7f2LDntU5eMKkI1oI0uMck0/6hhsMaeyOTTcz?=
 =?us-ascii?Q?iovdxMeLc+HYWotw89Wqw81mzuliilx2lz3tORafQMC3/Hb6W6vqnYnKfFeE?=
 =?us-ascii?Q?CDL7aSftmfKQUyMbUOmizYFXQ/92qf39+LIe2JQ5/4ekxUmDX+nAX4nCM0c9?=
 =?us-ascii?Q?MRP0SfHZ1CM2WoxWm2vn33VAjkwCvaZf3MF+InT+eFTbzbqekZlKAtO/bSHs?=
 =?us-ascii?Q?xi8AXbGO4GLD8MUL28uLksw0sKy7hAU7X+6vOOmImHYlD/BzWWFRh/BwOwSm?=
 =?us-ascii?Q?rMbA1H+d2e+nQW2HOxzEf+p6a7I3Fz88ct/Hnv6a75+p06fKJvDKOqxCRz2q?=
 =?us-ascii?Q?0x2PcF6yACtArbZ9Bof4le5X5YX1iFE5w6sRfqE3bJKQ7LJ8sHXP0b2dmlQR?=
 =?us-ascii?Q?dpz4JCdAdZ45oHrdFL+C/9z/L1e5IZSimYL17i+1t0fh/s79p6Cywak/wG9O?=
 =?us-ascii?Q?ZVVEtz7HnGzVM4UGjd5O/CJPmye1qny5IaRBrgRB0CNVx0FHEOjrxfYh74lN?=
 =?us-ascii?Q?qDkz+SZhygDtx7mR8QjlrofaW8ctarsFJxbWrkFR1V+2/HGtpjO4OBYjuJH9?=
 =?us-ascii?Q?ToG3RA0LG5635bTo8XUrEUHR26+hBpmYrC+ul/BWxJjOaKWiO0Te4c2RWLhw?=
 =?us-ascii?Q?2rV6si7FAzOxW5DeHBtsPQVoJVdepBOHEskesHGYZ2wxY9BJip2VlRaV6Ug3?=
 =?us-ascii?Q?h41toLR7oYhiDHk5pXXXHJY3VxoFcfCrId0XPuAuKn1qkQXJrx9daCsR0ecZ?=
 =?us-ascii?Q?SxjwqN0xx4itZajf1avZd2TBKhavfQ3RljMQ/fyT75O4HRY2T4SoAIXsb3q2?=
 =?us-ascii?Q?WaI1t5qh8fd3G9h0zoTRBkvVHX8ELe+ByjA8Gpph94ByY3uu3vjTdrzFrrwr?=
 =?us-ascii?Q?kmhdIg0XK8LZBTE4dY7TO1ZiT2D9OhGKblpIlMLGjPU9JgvL5UmoK8I0ANie?=
 =?us-ascii?Q?kCHmywZEoKviLMt1WfG2xRMo+nzcy7RPNiuSPBtJ2BUjtzN6aWD75Vmv1Uvk?=
 =?us-ascii?Q?drrZqQF9QNuuWSPMOHG++rKqKyuzaWVu+ss4bl2L0MTAkDOymAEi1gmmZaOd?=
 =?us-ascii?Q?4U9DH3lmSbzaXL2x5o5jeh437ruwG/ola5Y2TlBLH5/M/E4gPtPGIzNXlPdl?=
 =?us-ascii?Q?cCGRrLQ2FXENJZ+XoBrQl4zxVnf4e4W6/3HbDyK1RWEHqT4exfXn52k8kyaj?=
 =?us-ascii?Q?eFiqTxg4NZClk8fXQDlF1GSmXLy0/0w7r4Zr/Vcr6n7mubr4bwWC7NcfhQPc?=
 =?us-ascii?Q?80e0O+Id0bXjkU9Ae4N18CuYm9VQHhxoihUq7eSazHbyhWyKjQI/ZJnRjDR4?=
 =?us-ascii?Q?RuKyHMMjVAj4TcEXFn37UAIeosvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLMH44oJ3YGzh7xTv3i7p8yPibrULzZWZ7u8w1usebdfkWHJcdmpD/m17BSF?=
 =?us-ascii?Q?v3xA4gA0fnqAB39bCC8fUXXYrtHe20cw5/KgOf10Za9grwYI6OiC5jRll2BG?=
 =?us-ascii?Q?Yi2T/06rAsgnx8ZeG1H18jtxivbRSu/PzOVeg91cqxZIsamQgfSrzL9R2HxE?=
 =?us-ascii?Q?G7nHs6whcTWmBTI7SzmnuptHCnPTcQkpNeJXHbueWrlVq77jQyAU/kggCWBM?=
 =?us-ascii?Q?hLrK2gF0EeT86LJkWWevyihJP04ZHvlSERgCeIpxNUeKmxlxDd4bNmxJfNOS?=
 =?us-ascii?Q?SZ3wqPlkSJ582JDAy/wQ0AbexI/EHqH6ca2jOP48szCvwg90QOonbjEXiAYI?=
 =?us-ascii?Q?Ucf/om3UNp3PZMho8izDsyCMb7oigKi4IHSvWmEUzU3fMvMSFng/OIoHuGpH?=
 =?us-ascii?Q?E6HtZJ+Hrj4F4gORMpqa5oYU494qTnPgktXzeC0LYe1/D+Huf2lJ/uql7tKG?=
 =?us-ascii?Q?jqds2c7pXbpo7A97YW1EjGSu9nf7tYULI80Cj+I+fWYZXiWOcQWY7JGw0Y7U?=
 =?us-ascii?Q?fIXnmd9sY5DO93WqZtZawGo41u4/oF6Lhgxk4GUOnN2k0uhf9tX4oiIeT7Tx?=
 =?us-ascii?Q?vZMQ2qfhjGCdTUsvXI70JFtObXvYYlGSLGsRnfWDdYv892573zsBC9i7bRBd?=
 =?us-ascii?Q?A3miclqPxx8k0CZWtakwoOkmRr+D9F5oS+w7oqPwc7NokB8Ht/OFmANESCXB?=
 =?us-ascii?Q?nrpQ74PCdBIckCVKlBZGX6mRnvLMCf6jnT/v0u52dibkSis1YdzWHDrENvnX?=
 =?us-ascii?Q?w4sO9eyAo2y5KxKpIck9YJGsxvy4p51Y44x1eXo2EEvqEXOHFfq8to7cPoN2?=
 =?us-ascii?Q?kMSG3CI2rLqc7roRu/Kd347usbkQc60up73fFXnkwmtwzmuI4WpX364CKm4+?=
 =?us-ascii?Q?6YJbDCZ84Q9FiEgI/ZJUv62CBF4FlepQkQEtxF0Rbs4B6A8aAoLUgK1dQPO0?=
 =?us-ascii?Q?L/o2GzEl+zlGs+AgHwMWL0a6fqoy95yy9uAt0Nbj0G3sRBzal7hx4w9W72A9?=
 =?us-ascii?Q?ukEon3p1Io+J99LgNc5P/+XS5n9LfV2lRTTPtG/JNUVl6sz4uAMCcQ5D9Tqg?=
 =?us-ascii?Q?chbD7A8aBGHeD1G66fsPFDZ+Qx0tc9Nkgy0IaYy63oXyNL8GDvq2CVUjgPMn?=
 =?us-ascii?Q?IHCxQ/+yAp2K/nwM067UXhGi9JyVGQqgZotNKH6toTbbqrBdL4tuod0rxtCY?=
 =?us-ascii?Q?m/ddFpi17vGv9/veDBPiUfbsfC9V34fxreID3DMWqRe89YK3tZ79h2oS6VX0?=
 =?us-ascii?Q?Q7rhJ8u6gOp81r7Qnu4jlWKt1TlDt3tMv2c4yAuL4Ibcuv+P73Op0td6jY8Q?=
 =?us-ascii?Q?zeX9qSMVFC3KWA+1SdSfilCQiVOtKGgrxTbROLxadUsNJBEEWvvcgQE85MHp?=
 =?us-ascii?Q?uOM+xNzQCVwv69qb1aHIg2fhQf5sHU5uATCQpFrkWJiPzDMC5Sd+v1PvdIaK?=
 =?us-ascii?Q?13s60YdzXlDfoepsU72tEj8bKPbfjIbsBw1Tns3zs0eKPs675/Z7NaAxgtck?=
 =?us-ascii?Q?BA41XozbQYymXC1neEjqYDW4GSOdl7WbTLOg9M5vVgL89yIvbfHeXJI5npuC?=
 =?us-ascii?Q?+ZWl3jMub5mOmVPP/B5Et3t1FbFSdF49vRwFzNY/j6YFaoRs3TYKRZkLFm8j?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8d4c42-9943-4689-13f8-08dcfcb560ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:45:12.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0k3TlZpNU6g1AtAu5F53RRqTOy9bqGNX/6NHTRs0VTM+pM5ng0zoZJ8m39svQWhy/KRQKh41/u0R+v/rlOFtd8Zl0RmB6B2rfDc1vpsYw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5764

Add new WWAN ports that connect to the device's ADB protocol interface
and MTK MIPC diagnostic interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 8 ++++++++
 include/linux/wwan.h         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..5ffa70d5de85 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -334,6 +334,14 @@ static const struct {
 		.name = "FASTBOOT",
 		.devsuf = "fastboot",
 	},
+	[WWAN_PORT_ADB] = {
+		.name = "ADB",
+		.devsuf = "adb",
+	},
+	[WWAN_PORT_MIPC] = {
+		.name = "MIPC",
+		.devsuf = "mipc",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 170fdee6339c..79c781875c09 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -17,6 +17,8 @@
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
+ * @WWAN_PORT_ADB: ADB protocol control
+ * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -30,6 +32,8 @@ enum wwan_port_type {
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
 	WWAN_PORT_FASTBOOT,
+	WWAN_PORT_ADB,
+	WWAN_PORT_MIPC,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


