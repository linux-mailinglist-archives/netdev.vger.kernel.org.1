Return-Path: <netdev+bounces-155580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF84A03084
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554907A0582
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42A1DF97B;
	Mon,  6 Jan 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NHBCzFrd"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022122.outbound.protection.outlook.com [40.93.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CD15886C;
	Mon,  6 Jan 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191511; cv=fail; b=OoueLKBa+kuebw+LARpJLp/f+Vsj6G+TneZI27DKfmoqwGINtdhCtx03DWM+oZFdjzyOIJlIJ7NKXaHX0KE0X9FOVhtsUqGYl0Hwto53RKfEIfNkbdprcv5n9TZGnG4NfW1C4GqHGm80C/sqobnEEKuR6d+bMTI19PxtHODsZY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191511; c=relaxed/simple;
	bh=SRkbQBKPzGEfMYSAHOscIVhie9KZevzRCvwmaIZY7xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYDJMFblfR8TGNNnxM1GIWPaSCMyTzxDbH0sjUy1QOLe8qlSClsk+vrWdz0YkAumAq+AwQ4kKFqaE4YvjsJE7KnHn75fbPNtIit7Gdq9NUnmX4Zhsf/54hhDuuhdb4rhhvVpUvnfxA8u8cUFkUqU0S9dtSjCtyrT3xKrDYLFJGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NHBCzFrd; arc=fail smtp.client-ip=40.93.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEX46r7FaH/7Ulwt6+RF2hyXZa1tBC7qT5+sQposPHmwgHvNTZMqbHmfqWAg4Tm0H799StY3sl+W/49+pQDN24DRTafadBm7ehXu4QYcqVG3aSnv/M3e9A5LmFlVXA7Trmdw3ZRoyE9WVqOz+j5jAkQ+KnPWPO6ZB9LXJ8TxjUygdq86s6NeTSayn049tBbsskJPeJO0O8dFnV3juloALsIXINxAoNOB85Lsfs4IupECJSSRbSw+qyz3OGzqqaNa3xJrhtsn8SLVvlhvD5dY3B3R3BZl1CrXuia+a6qy6AlkceekC/kJLy7y++l5WdXzYvNiwqo4CpZ+SXcMcBY6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/ut5wlCHDC9gVQwHzzCzORaW6JNU5be9whX64vnwtI=;
 b=PhwM9/WDit24iy0zM/7VHx7rANXE/IZ87g1SdAGY9WeoUuFnOcP7CEL+chs3tYt/hdgPIeuR1bZJddQ9mMCvhbzg3VTPyWIN2HjjU6wyjsgEFP0fqA1vnrn2OYysNfO2veCYeFbs5QvCzKif2bXhlRu+2FUbFSKr6wl+EQyOMUJGGZNaOCcgKR/RrY2FdsYMK7ys2PU26eIRA20N7Nb+p65uufoLNTFEh+Ji4ZZtCj3Lkv6sGiu7JznhkolnyoS8SUOKOJR7ZZTWrGqcULujMxOQieNkpNLh9L7V6981gDVpjEr3XNzMYiNgVGZ92CepKr4lnbBs9mVmeXFhlAfUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ut5wlCHDC9gVQwHzzCzORaW6JNU5be9whX64vnwtI=;
 b=NHBCzFrd2E0Xnf14YGtuUdqKXNdK+/XD0/6XvHH+uiil0SPhJZApQT6g2SFMUswoZhsJtzeYwyxRHtXT9UdoRR9EyfFtc+rR+W0LR/AyHQD3vZzvmKsS9UDi3rlgu6lI9gwqbDCSHHwElIF420H5G8PSvEOv0t0o7JAawsm9bbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV2PR01MB7622.prod.exchangelabs.com (2603:10b6:408:17a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.9; Mon, 6 Jan 2025 19:25:06 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8335.007; Mon, 6 Jan 2025
 19:25:06 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v12 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Mon,  6 Jan 2025 14:24:57 -0500
Message-ID: <20250106192458.42174-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106192458.42174-1-admiyo@os.amperecomputing.com>
References: <20250106192458.42174-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:930:16::20) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV2PR01MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b9e887-c9a9-41f2-34f6-08dd2e87d388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|52116014|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYEBSep9Fm8vf7azEjrWCp12h48jkQhv7kfjjMQSGy23kAEIzaIbIBSJWKUy?=
 =?us-ascii?Q?B/R2sLSMHcGPwjlSNWjQr1QhUUxrNc5aqOR77U0NPj0Vo0w7AOlCjpA7IoPc?=
 =?us-ascii?Q?tBpyKmc0lZhudeCADH8Fjsyh661QkscLFQ24PaXjeLgd939TRsLp7448YDOv?=
 =?us-ascii?Q?AKBNIR0ef8zvO66njEPvhbbtYmCg33lRD7J9xK14HhIwrkTZL+sQZ4GP65GR?=
 =?us-ascii?Q?5fzATWs68/ere1ZkfeLoAEuzY+yfTr9tlsisr5YTkhLUy+eIiKwWTtfh0Kya?=
 =?us-ascii?Q?zqUZHYilUz4w+LQUhmz5avNBbcIABYEROE/HvXKEZbGi7Dc4ZTspaHToJExS?=
 =?us-ascii?Q?VHl/wwdkmabkLq012qI2Qt23sjsIj2FHnFEHhKhivjsDnF8OtdfU8PzpIOca?=
 =?us-ascii?Q?i9+CYs2x6H4VHNRl3uFIcogYyRgz/CMt9yhVzoBJ++WWWBUSM9kZPSYvVOLg?=
 =?us-ascii?Q?b7InV+8q2sx4nIvuQVane3T6+vsz1IVcBOeY1bBK0QfeS/PUeSrWayPRd55R?=
 =?us-ascii?Q?VDJ7iaXtEMshTPTx1+8jGl0252DA6cCnW1YOqpgXs+arbSlBIUeA35XnTlvU?=
 =?us-ascii?Q?hVMteSwqKHvJs21xM9+MrYekUXKZhg6ug5eIwN+jDP8L+MW5eM2wUxE4pvhE?=
 =?us-ascii?Q?EDtVyAXXMpOI1Z739Ench/PsMUPDy4d04R+O9NGvvBfYuj2+9RhadfFiN87i?=
 =?us-ascii?Q?NThfbM6jPufNhKBY3X2OdryQ4mYAntDPORrQB1TLFmMkyqcWN2WVS+3ntkSd?=
 =?us-ascii?Q?wDihWq6l95xi3Ul3nZBiaqcB+hIFRBjuZfBOgT+rHzgAIGp+hUe2AmyPl1j/?=
 =?us-ascii?Q?DqQLtr7bu8O3+eP/xJymV1bau/YtFHifaTJi9cf8np9UNE3BRYA8kS8LJ0qN?=
 =?us-ascii?Q?2f0nOReXoJwtYWdz7kdoDTaBvdTXjKhOYEsZOlggVPud1voetq5i089f6GYs?=
 =?us-ascii?Q?e13qC2QFdyvpXq3tBmhJr49wGOwtz+tDkRzA6NToKZ6SXjQI7u/h/2Tyy1Nm?=
 =?us-ascii?Q?Z1RlK73b6YRG56VV6c7bZl6Da3vNVmOcbbWu6cv5B7yYgiE4fE0eyV7TcEiO?=
 =?us-ascii?Q?aP/JCn+azUmT10qhs4910pU6Oal0hV7Zw4kJaxllTcjF+CKtiyK4qzsb7kj9?=
 =?us-ascii?Q?3TxCzidiD/1rGL6TmU0ZkLyFv6kICT+qQYf/FY5UI1WkaJmeKuMv4vqx65Ir?=
 =?us-ascii?Q?wfOvU8aujiaE6//5OF4Sz7XrAVKhrpwyo9XPLInAcen4N8gAIBmU5pSY8XKh?=
 =?us-ascii?Q?7kdMKGAH5tKdDXRq9wUCNaiHHfO7fPA+xvEneqQuDI4UJdf2aZMWv95GGdMc?=
 =?us-ascii?Q?EiNLmCCZ3c4pNWejeb8ZZzzdtCKx2h48Y6Fa9CbFyJI6iYJSsNG+cw9pVFXZ?=
 =?us-ascii?Q?gViXvdW9kiof7M1AqWbhsmen6AwM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(52116014)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wbsX3Oa1PGj07TmHH6tH+XMTn1lVW5RMBK37cA8RU/3q7bBfvrOg0eOdsxv?=
 =?us-ascii?Q?pj2lQ26JT8s62fwsbxU+nE3BAx+ISJndxSoXcGx7NYeBmhGawzoN7oUUGAb5?=
 =?us-ascii?Q?NKx2bGQeyCTZKhfjsZVaS7Ij1LVTn6kEXICL2dCUhJAp4lOqfk0zHgRtXn7Q?=
 =?us-ascii?Q?dIyrh9NS+cg61K4vbPTEX5xirAjv3gPPlY+iFA063kmc+ZCQ5kybIFgX1z1z?=
 =?us-ascii?Q?AI/kSeJ03QMd8G34mlnzUsQMT05VyoaJqUAhqLNq1hpDXP9AsuXjcGva8UH2?=
 =?us-ascii?Q?0HyJeTFi/cBhwOfL7NC7IKgIGo3FCkgqQT7BgJY0hzQ1/w3D148kXQY2zx5v?=
 =?us-ascii?Q?0n3UoC73Lt9UMwjWqBGlEOHjMqEPJHcyLBjVzgEidTNeHROIWAcoJGoh7BdT?=
 =?us-ascii?Q?jrAw9a0mCR92YzwASkma2ncyB+xAPbsn5A3PhPmLnNHjvupG7PgytP71xVPq?=
 =?us-ascii?Q?ubv4HJa//WSwm87jm71suNDyrJrAYdUgGNZsbazJnGIFUt2noP0jWJpdjfvK?=
 =?us-ascii?Q?w1sTdUsfapHfu0IHPnaT/+XbTUU02bKOwCIz+sIO+pUPuv6Anjf6ItHOZWa9?=
 =?us-ascii?Q?NbjTbgODaDSdjNjIlWX4dCd8ktghTwCFusbrUU1weWzKWrvIyMQFpEK4xmSD?=
 =?us-ascii?Q?+sQ1O7GprAp+iFzZGFcpE/jaRhIycK7ho8LMrgqt6uJPUoO7qKJliQ+lwPrX?=
 =?us-ascii?Q?N0Ij3bBLBui40EFwhphEBBvO8Aq5AKBUo4pBsx067bRRit/tAvahhCV7DgzT?=
 =?us-ascii?Q?u5sR2ZjbG/7k217nf89eMbiYfATWaLUe5iGHINK2QlV4og0oD/RyUdP1eku3?=
 =?us-ascii?Q?PDJWw6Uko54K80DsjMSqwwhfndOmmvatcOmkgmGTI3FodVpqFjYvWf9EiINQ?=
 =?us-ascii?Q?sj+mU6EJmF2s9HSthOrHaY7n120yQGrvSGCwiQNog9WNkLmt1dikxz4IY7Ue?=
 =?us-ascii?Q?H9fwTE+QvU3KAPaBdVzS/UUHCk7gWx93Iby1qII16Quc3qjaMb78bwu1n8Gk?=
 =?us-ascii?Q?hRH7h6uHBSWQFixLMGpxIsjrIrXEjC8eVC0mmulZ4OaQB8kQkKsT/TWUEgtf?=
 =?us-ascii?Q?UyYGWu+uuXiO4suWnid+ooPnOlw7/G2vvKR2RTPuxyDYkffh4sCJ+s7HfnBS?=
 =?us-ascii?Q?feYOTx1K5MKdln3dvgOevPfYhOGWO2mobsIFj0C2wNG71fWEmm2zTSPdLOU5?=
 =?us-ascii?Q?BIJWnpmM5GMjUq3CFwo8CEENuFegK1xjnjdJBkmmDn7Z1yWJWUUMPjh0K2HY?=
 =?us-ascii?Q?6LqGVRFwnM/pFZ2hakmJaZKwFrRvkF7knFTlmAsJ2ya88XPR6tCkwCNjNx3b?=
 =?us-ascii?Q?7lQ29duXgYlOVHmR/A8dFJrcWgXS9C3RvwbHsAxfQHbtRrzwO7wZLU6ADuTN?=
 =?us-ascii?Q?WiOxYYhidN+Yj/CuAT8FUgYh94LO0lMp6YG4pv3HoVjMDMdw0tx122bDAa/S?=
 =?us-ascii?Q?4yFaJiTSjOiOKvqNTv4DTuMYcGibaBWPBZHz/dq7KPzJ1TujcrZNfS/XAem/?=
 =?us-ascii?Q?L5Qi2tN+qWjUb/rXSLV7+2j/s8mt/KhH/aHUKev1ZsGUPlikVQaq2isRGtgb?=
 =?us-ascii?Q?ri57nK0+LgHLqivX159XWX7Byx9nAya8/jT+sF96h/bpq4W8GIHXWh/6Mx2z?=
 =?us-ascii?Q?PW7V+Bohlw5D8mtaVu7baSmQ6vsXOOo88OBTokw0IMWCZ7oOSK3BRaXwj0Xe?=
 =?us-ascii?Q?cg8bGHk5j/pvPvt4Q3kcO4optmg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b9e887-c9a9-41f2-34f6-08dd2e87d388
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 19:25:06.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvPp3x5Uz0xjRSE/8XDN3p8OE0HQS9qROuiPkIeSv6H2EJX00FBrhSK75bigKCs4S981wktuOW8dfvFhHDHTP76nAuq+4MYWNKjxHAO0emQTN/hJPPV8wyRBLluZj/TU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7622

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

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
index 000000000000..fb0e82e10344
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,311 @@
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
+	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;
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
+	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
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
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
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
+	return rc;
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


