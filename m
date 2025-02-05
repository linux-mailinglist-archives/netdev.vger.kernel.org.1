Return-Path: <netdev+bounces-163202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C4A2992D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B35716913D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E01FECA6;
	Wed,  5 Feb 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="W+hqB6Zp"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021110.outbound.protection.outlook.com [40.93.194.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA67193436;
	Wed,  5 Feb 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780378; cv=fail; b=DbPQTezPOtXsgdQrQCMbElbreVKdPShwMaMftkO0R1ZRkOGobsrGlcIRTkEjufNthIcuRIlPvIwV9L//gQsNf4Ng2Ju3lSZKoiO2ILQLnG3EgBFXcIQ5+iIltF9USu7FSJJm60SmckVTa837M0465cpx3s5G2lBejnMu/7wSlH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780378; c=relaxed/simple;
	bh=4R8RDPHr9brwDynSwNdJZDlbXcwLl2xGc2WrC0ChQOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEAORLNMTqeSqw9q3/9c/PHLfr21cRGg73aRGB00kipMOqgLNJYlvmbdI3WI3T/UW9t22toOHGOXFh0PUWUdCDLivCJ4EGIg4PUqFiHeHbS8ZkPSUyCD3rIcQtBNfh78aYswtwwLQIxfiEHqbC6HtgX1deC9hmkNNFHcm814X6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=W+hqB6Zp; arc=fail smtp.client-ip=40.93.194.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZKrPBIg6xnEKqlGXzrFpH0SI3smcPbvGBCEEdXChroeWjREwax5vwDlN+5yAQuey5rzABNB42lJjsVwu8ciUJosA1g7yhhtZkZRBc5SUxHBJwtzend6raZ0KrognlSPKzLEXEC90hby4BWgpiELuv9ELX6ZpK8JT4vPe3X2aGjRxmk5T6cmCHmaYb9XIuLvgWEWMsu32k3dzUIQM4PZCYkPBCp3krvEOMwoYletBGRxGizFhvTDtgZOH06juz5VARVN+sFzfrh7SM71KrvAK0VP1dZjeiqu0avSCkWgpawl8zYhfqzCif7DL+24bUhvt3gwvxIT+RskK93nEAI5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaI0ov/IhY107V58kAK5dPYsWzejRtyC3yy3mdmib9I=;
 b=Pr34DQmBTEx7C7A7cGzYtpRXZwl1GtfQatI4bqOMUpbRLszw1g6Q56DsFYIPcl6VcT8c8OE6Fr8bVbmCAbGH8qnZh/KvtG19j4Nq8qsBue820dwr/seIhCDTj6PVTi8jraILFud6hee8Pj6/txZpCoxxDhraIZTz8sBeaHrpBGUokERtgCtTJmUzqpPZIm6pSAl6HWFROZNarjvdZA8JNgitr4jmT+4Pya+Dn5MRVRzODQk92Bd1hdxxinntGgJIuuWBEqqHlOyiSdxapMlldvTbTwIzdEnHwxUsoDZu7o2sBrjbgYtyUU5k6oOpYyIoVYsV1ly+I8tPP/eqAUe/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaI0ov/IhY107V58kAK5dPYsWzejRtyC3yy3mdmib9I=;
 b=W+hqB6ZpMLYiSuig0WsDMkVZ/tD4XqtQD6rI2BKA+nJnqxSt2K4JrygnbdaUZdk9V9X4lGralx6IpR7WczZUcibDIu6kQjcxAcpcHw9PaNUyXIFel8aOv1AutAnvYVzIq/jzWtbqhDQCzsh5JgIkudzvp9cnjaay3Vo6Uq6O6uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CYYPR01MB8263.prod.exchangelabs.com (2603:10b6:930:c4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 18:32:52 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 18:32:52 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Wed,  5 Feb 2025 13:32:43 -0500
Message-ID: <20250205183244.340197-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CYYPR01MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f68f3c-49ab-4e8b-bdf5-08dd4613800f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lcYoxd3cFUzL27jmkmrYTD8Tvih0bvyzAS+JZxxYxJDjTL8rkCkFNLAHGpLt?=
 =?us-ascii?Q?ge7rUipkfOw98DtfWGJW6KNrHzLHnsKL1FXC2ZZ032GJotTRRwlghzq2TZRZ?=
 =?us-ascii?Q?KcY+CLNVMP7lUucET73j9BuRt7LZdpzT2t637mSSEijtjZGx9Uh4kS0z+Na+?=
 =?us-ascii?Q?+u1BaEOo2nhBEiB7eLWshJ5qlY52yTQKx7DsLrg3LoagpeL7y8evMm4d4swh?=
 =?us-ascii?Q?WaZ44Iv6swP8O/L+46iH0D3rFT2IoCOACr9zkBAg/ZhqZKlFZDvyyWlm21bT?=
 =?us-ascii?Q?2Hy5quUWPThbGQsA6/y+c6j6pBKB0GvLCyA3c53CHO92AvKkoqOMpZ56n49o?=
 =?us-ascii?Q?VjE90b8rABEtkAOvrIHQAUEJc1qFsrCZt8NCcPzwrZe+FMq4NDhDUkHP4nQ6?=
 =?us-ascii?Q?pAhNPSNS/BR6yF1vDNi8++x0fLJ+xw5WaqchM7jsq8M9FF+qx4au61iz4XSB?=
 =?us-ascii?Q?9b2oI/lCApsk+eoURnq/YX2r1oSyFbUWi2j/M/OrX7dh+8IrRNZ79wE8OH1t?=
 =?us-ascii?Q?re3KvRcui9C35r48aiaZywUCFsKSrDe9Iljzqt1+P4U4nhADavA4jM9OIirC?=
 =?us-ascii?Q?1S2QCw66zI845Kde3Iunzu8zC7fnBeQxoXVqwY/FjNA9sqG+bhVyJu4HTFow?=
 =?us-ascii?Q?0mOpMVQpCQylJZsNsfxhiQPIpKjBsbtND6PUAnFfVz1PydvARcoYTk17yaM/?=
 =?us-ascii?Q?g4nYDgJa8OdpDnfd7jyAB/BCMvqmfPoI8hmaaZ+CkE5Nbj7lJrrxElXrTdRe?=
 =?us-ascii?Q?MCXxnJZI+4zPLpTt/lLL80v1LwT57GooawfLkx4D5kCEYd/wWjsD2hedmLBw?=
 =?us-ascii?Q?OTZMVZp2PFxVpOFN3JbIWZdo0r70bQT3C9GP506NX6PdsX9itoQY6UydW1es?=
 =?us-ascii?Q?+Oc/2sGceDcTSCofkHfIOL/aENEvrA4MDlSpLp7JrKRsnGFeSAGxRJa9tAqj?=
 =?us-ascii?Q?QJ7rTMLxRWOjVfIjOpMkvAqD4+OWCYj5MOZprmspqaXnjst0AFl0g4/+TU0V?=
 =?us-ascii?Q?DEoSydmhfGD8txG61tdFrMjCdHxxiulTlCvA5pk4zNTRGzdY2V9kUHd9W8tC?=
 =?us-ascii?Q?s+K23pWIp99Bq4X6HF9RhphP42h7laBupBESwrBS/dLNksby8myAlTpI/L/2?=
 =?us-ascii?Q?6/fy1Ani21GGX2BNFnFo1tnHqTg6EazIzQuMorihLKRsrSlh/6WlRSh2i5Gy?=
 =?us-ascii?Q?kaHREEta7hp3JSC0ZODDnDt/pwGSUzrhYQ44gQF7XXxp35iRsq2sEW/wapQA?=
 =?us-ascii?Q?Kp3ULmdEA7RkX2kYXHjeqbQ4S01JYlS7kBHCXWpeHJQTokpR+cL1VNwjpNKh?=
 =?us-ascii?Q?qgbhKPSBneRcZEsd06xIuFpLIuo/H0YimZjkYpZp4uRtCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTZo8EEwz8lrlTxEeZM9CK2g2jEqpTr/QkBsV/DDVXWcJFlB2x6oZsO0Ej2k?=
 =?us-ascii?Q?3H3c1gXWzbu4Y8f54E0Mi0dzJWRhDmuaCi/Iixx7ACA1Wy5ZIuj2DWtp+Fpe?=
 =?us-ascii?Q?3jAiZ+vTkNDvMgkwSFbi8Xa0RtGTGEIB8nFusRi9BO0gTDurgepUgKhuJgR9?=
 =?us-ascii?Q?eqcA1Wcmxsear3XAi4KrWgDfbjLsV60zKp2h37ExZdrPw21lfaxG3CHOPKU3?=
 =?us-ascii?Q?SGybP4O+XTCz4m0p2zjfMp8IUKhVG789az+K+PBO/SDQiNos8G0XA3uliuKN?=
 =?us-ascii?Q?bY/MkbEs71rEYY9lUn7zCkochob8iVIOAjWfYWRzBloozE856DsZCZarN5KS?=
 =?us-ascii?Q?S8llddBTmX6PS8ZPhkfiC68pyzo4Q0rkDWJFBzKqDET5v5WLG9a9DdXdb8DR?=
 =?us-ascii?Q?ZcF9nagZIrSUnD0FvuthKbGdyOpii7MJyXIO/O9DyVCm96VWsdWDA8Rji0mp?=
 =?us-ascii?Q?f6+Bfo8fKin54EtWBpsYGzA0dYzWBwqo7L7LLYhWJfMqYXp01VjX66dLl98c?=
 =?us-ascii?Q?Wsz/THYJbfGO2zEneMB/Ao7KaanXdJjel4HeT7UAEFpj5RIk8sbZwwTACEVX?=
 =?us-ascii?Q?kBAKETP9pA4Ef5Afp1x0kPIr2h2WGk931hniOb85UBFIUKMSNasNu/+vRU3B?=
 =?us-ascii?Q?dTTztBnzzeVFzGZg/stpU04O47hBWpu5+XEjGTlB9LtnRDNkAwe76JKLpH96?=
 =?us-ascii?Q?Za8ipJyBcta+U5/xxa0OdmaJgEJOUJwGBUc0RGw+jvQVikTqQkUJyg5kNE2f?=
 =?us-ascii?Q?Gbze3OycH0MSg74S9VCgdJpYVjuf+GgyGRHVQ9/J77li9kT/FZ6juX2TuQzq?=
 =?us-ascii?Q?X6v4o4vrWnXMPdVbf+balfjD0LWhCGXxiSEC8WgNR1Zvq6diA30LQBne+Viz?=
 =?us-ascii?Q?E76M5qeXGPYIqtzN8FT3HyId9uS+CefZ9hKHo/o5l/K4I2H1JSH4mF1bPkCm?=
 =?us-ascii?Q?0fUTO2g601cFOhrlbcQSSyWtaPhNGD9NRVlZ/D4oG4llujMtqmqdTGRoTCEU?=
 =?us-ascii?Q?3q+IKwbFmPmjRlJpfOYAcds+YZ881DnZrwiK6yUjcepf5HiA16tfFPEZIzsZ?=
 =?us-ascii?Q?6X0VvaJ4xmqLohrfqKT4ye0QM3Cj2wg9wsKSY9DcW+mRZc/9et1pIgHTe/Iy?=
 =?us-ascii?Q?mv8PQiWrHKVdbO+B/LSyo2Kd7DSufr6FWR7G9I6JQ7PBunM6ZlPO0QRl0rn0?=
 =?us-ascii?Q?eqMFdX63SFZmRPxOR6/OCY52Gw6uL8LQ8nCltv+d/AksIJscsFSG3l0LrsNY?=
 =?us-ascii?Q?jdI5RRA79s5ul6GDzcRXqFx7b1k8+uYX9KvXFSmO9GFmtL0iHNmJxBrWZbFm?=
 =?us-ascii?Q?BI+y49q4ZnGnVKL4Ou47hYnrzU5qVkZamBPc8IplUhip1uowjOGgvHMjRLhe?=
 =?us-ascii?Q?WeYGvC+XC2lURGG+SipJlK5XnwE4NU0w3xE290F0ZnJP0oECdYtODJl/s++A?=
 =?us-ascii?Q?bz5XJRpLL58Vhb+qVOle4SWJ1dyGk8udSalL6MEa7nmtq69iP1natcmVyNK/?=
 =?us-ascii?Q?0KYaPqF3NPB5IlNc3CEcCewn65Y06C5tmnA1zyoSErDFwlhDfz8fSygCgHcP?=
 =?us-ascii?Q?3nb39jI+zYtFlueT2JpAN3h+6o1v4n0CIk7I0YHIjG1ZW7EXGa6HOHrUvhZU?=
 =?us-ascii?Q?PrQcAi9bO1Rq2t7ECP7BVUABy9UdBO+afDSbLRU+o9BhP22IylPasu924MtK?=
 =?us-ascii?Q?hNeVrkXDE+jYLpAFFX95P+oWVmo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f68f3c-49ab-4e8b-bdf5-08dd4613800f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:32:52.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g86lZFQEIHcHfvCoGKF0c60I+9LRdf5s0Dl7J+AnGzP6SSXMixWJjkfAionQA+d8clt6ZInBxP5AAD52vColxqxXQwScCTv9L4IhAXov8lVxaxF+WB04kv9mdNxt0EnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8263

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 312 ++++++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d1086e53a317..16858c43526f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13901,6 +13901,12 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..073eb2a21841 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..2c70d0022a91
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	dev_dstats_tx_add(ndev, len);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	if (ret)
+		return -EINVAL;
+	ret = pcc_mbox_ioremap(box->chan->mchan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	//inbox initialization
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto cleanup_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	//outbox initialization
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto cleanup_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto cleanup_netdev;
+	return  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+cleanup_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


