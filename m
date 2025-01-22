Return-Path: <netdev+bounces-160348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDEA1955F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAA93ACA4E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6B214802;
	Wed, 22 Jan 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hgHFghNf"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022122.outbound.protection.outlook.com [40.93.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8A2144CB;
	Wed, 22 Jan 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560163; cv=fail; b=u/UdB5OPsDqfPqQL+Zl22RXv6+PxOKyUVrjS+nQLdGOJ8JWOtynoGmw/HV4fFuHu+JIPiSfZOz4sxm2+ZiU7+udT/HqO6ZhIWbis/h048QY/vRp9U+4FWxKI6B9YzcxfiyhqRMSxPB89Y027pVJXXMokQrcQrrqs29SLviOl+Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560163; c=relaxed/simple;
	bh=Q2h2JRqa/Cg1/nEYxwEQiyfXaQ3QT2f0kAuICT+beGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMB7MLOpITxh8ZmDpVx7vupjNFjf6whaa5J/4GorA3Ib99WVR1HetM8idMUeWhp9+kDn+YXMbMK1mC2AMuU6ijsbcklQ1O5M/VOZxVNbDLu01v5iXOWoWtkBEgofyOfQweaqD0cAjOa7tfdtIbHg2DXbCWXn1KVmEILZGR8lHDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hgHFghNf; arc=fail smtp.client-ip=40.93.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YejSbHlg6SZ8lpqWVSp1sPVWf8JkiUECUpDe4NgKSZz51eZpJ3Vr/uiP4OIwD9nNGlK855a5LCy4UVQy0S5YkZsPtv7g29jWGyAvCstKkaA1HaJDhnV3ZTiPFguGzLdeqGeECBpXhPNGWOMdH8LcoQw9jkrIByoEdt8L8fXlG3nNXs4oe+gKjQlCxQExzjcHtA8IFn/akSK/fooTgzoHEP/qo1hAA5BmZAe/1VROXHLfjeCOuSREp7tOqMoh6hk0dEZgSH8U3WZ1PVSBZ4ykqj/UEBHaVY9tIbUoXZrDkZbJcobwIv938Af0cLMPcgoiyOAEL1mJsUemzoLgq0uTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzIK/GZ1VAdcPKTy9KqTf/6335SXHcu6QK2qM7soXrE=;
 b=ST9EnZS548kZOFp7hWcz624DeIbAm0DZP1OvSiqArAXny0F10xunHaivDZfrOLx2/mGa+zcFFS2fAACFD3b5cE+nSXkoiQil2N09EW7QiULCd0H8ZNCTHvQmP8Y4lWE31dw49RWaI93rii9TNvvzH/OmuyIzP3Y6rV9yl1ezv2nwFJAVmLsX7IZ16DEhbev/04uzDVttUqU6ZGKTn3LluQHpsnZzJ9zveqJ3USmEQiqydbAWvKJSMlpwr2ubS6Gk2okpdn+jJvw+RQuhB6Tg/2ifWb7k7Knsc0jgRnhMF7ROInfOKssCMso5QN6aixae9z534QRP9rQJWl2lgDmb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzIK/GZ1VAdcPKTy9KqTf/6335SXHcu6QK2qM7soXrE=;
 b=hgHFghNfrEtiHNgkcwWvS3PUySjEzg8h843qzFPNZbjxbODobAhZGi4Bhxp4WL03HIXAPHwfnI6Ggr/qsHNVpDg4WuOIxM3ii+c0SeUqEFVhfq9rRI+dkWu3Wy+Kew48C1AXkZWIcyuMQy+jJBZmo9sCDdWJNqvt8RN9WeZr6Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA1PR01MB8201.prod.exchangelabs.com (2603:10b6:806:38d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.14; Wed, 22 Jan 2025 15:35:59 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:35:59 +0000
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
Subject: [PATCH v16 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 22 Jan 2025 10:35:48 -0500
Message-ID: <20250122153549.1234888-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
References: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA1PR01MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc7ac9c-dd42-4fb5-a73d-08dd3afa785f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q0mxwOkS5Kn6crQhuCFc3qJkReD642ifJmTVxz9R5zOTWEQWaqkucrrCsTi5?=
 =?us-ascii?Q?Yy9sncVEu6M3mL45+9Z6ep/K4YZ9UG1OUWUJdQYsmGKeEYDCpAJUTzviGeO9?=
 =?us-ascii?Q?mS1N6Na4cKP2AfOGuDD/gQiLSCxkhNMljvUD04sShO4Xt5zx+/CDc+KMsut3?=
 =?us-ascii?Q?e4InqWPXJtqOua8BRpfK8pNxGisPfHgKBvwpCuRLoXlkZ/paVdE8ykdBidGo?=
 =?us-ascii?Q?t538qIFZ5RRe82dVe8o7KX3gGaJVZR9KTyp296hdVrN1sAv+o/pFKaqj1cwO?=
 =?us-ascii?Q?ynnC7Yg0JoF96jNH3GeNRJW2qvy0BkmV+0ew76KYomVPkCfPg+Ga5ogVLiHW?=
 =?us-ascii?Q?KbyMcaFy1Jigpq40exQf8KmCUn7YC6n8wxPW31dfFqwcCIqwJMf++qgTV4EP?=
 =?us-ascii?Q?Qko5vkO7mcYImfufQ0feh6JDJgey+KYQid8GuNfPKeBi1yOZKN7eSat7dbC9?=
 =?us-ascii?Q?ThcWGr6C6A88sbtoZK2+DxqAuuT8cE923Kx/ripn7aTrXF8m1KL0alUDgTGc?=
 =?us-ascii?Q?LtM470a7gZMVZNtJnfUZiUD17LJuy/8IpjQXkAyMmK7+8KCUdCTXjBfr3p5J?=
 =?us-ascii?Q?l8lCXgew1eOpIme2ryW/fhaEdMYxWYergfjUhD4R9bABiimiexqRSO5U0TU5?=
 =?us-ascii?Q?5GyiuyKGfTgG6hcWmvbaTkrx44HuCXCpdPif5+BRMhhMyrdyKKcB4AEKY1M0?=
 =?us-ascii?Q?n1L62G5h595AWb3YqUb6RGwawcsnKUWIo+pp0h7a3KyVmpVfsmVYWLp8eg9x?=
 =?us-ascii?Q?TdaxfKBCMaq9HNEKQ7ulh3CMJmRhjxPX5fyZEyV9MO4F7tOme/BvbHtl8dYq?=
 =?us-ascii?Q?Vl9g+sG6n/z0bHer8g1e6FBgN77HWlryP68wcCzMWU+eNaFC/FpnbU+xv627?=
 =?us-ascii?Q?eLaWeDosM+SaNukugCdJNAlWxV5U1Vu1CmnfGOcuNgtHxbOASBt0V5fW/xoz?=
 =?us-ascii?Q?xoZhzbe6FbXTm2/yxgbVwbKoNkwb+tkBs13JdeAsaElV15XbT/L/XC4v/5u0?=
 =?us-ascii?Q?/mXPfDPkee0T/bIlsvJCkglKqBZ2KyEW8c4cMQZbGOhrqqvUeoP2IUq6JOWO?=
 =?us-ascii?Q?d/5aLuPT/1EE7kx4U+fSroQqLkQN7QWHgrkfFmuCi0u0gIyJL+SWLV9ehz0+?=
 =?us-ascii?Q?VB3PfF38PN2jyU9/NowPFWngw3cD5rHCAAzgtgNAChObG11bExJOI02IjKux?=
 =?us-ascii?Q?7vdNpQ3+YQKlPjTvZwbFcgQuMaM8yZB8D/uDOdPJ5tJzv62WPZFaAMgP8lga?=
 =?us-ascii?Q?YycZ9pC70l/JGYBMdYAnWpGZz3Pf5Bq7KjIXogQb1p4GkzQp1q/5pZ73dLFI?=
 =?us-ascii?Q?D7wnqr2lTwi518bCgVpMSMJzbwSqQ+FG0wPOjeCN5FBSgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rZXGBa4+phSLWgb6GD69PriJJT2prEebGPRwsx6UFZF6OnLG94lqabM5iScy?=
 =?us-ascii?Q?yAXdn6p+t1dNvFMs2JJu3YeCKf7pwD25DmVTdSag+7H4E4i2ChcNFTv2SrqO?=
 =?us-ascii?Q?IW0Q01fpgxMp59mcviRXSdwbOBk/N3CNlEvcrVsZqDXiegPGMIg3fYvVTfRG?=
 =?us-ascii?Q?tIwTJB94x2xbF3nvWFgfpWYMtg+9CKSZ+uhZqeuJXfMn/uVknpOltBf1bzpe?=
 =?us-ascii?Q?s6nNxqewbaPHbMcIV10pi7q/8v20vvzZjReQlXSKzxnpkvfjcCIvQn6fUV2U?=
 =?us-ascii?Q?azgeq/GqarDL8zD7mhF0im/nLABDdkFRyAZ2+WREnp6lAsVcJT4tsobfQGw+?=
 =?us-ascii?Q?Kjb2brw13yBbHaoG1zNVB7aN2ZIn/nW2tQpZyKtBgjzQ6JyYnEbyw8yacGTB?=
 =?us-ascii?Q?OxKYMQjtQV41p3i6plX3+42PIxQhpixFyG/l+yQYlZaAyLNJYBXhVfElGjbw?=
 =?us-ascii?Q?FKAl23VYTIRbdxe0c6mMmSzaXuOJwQv2a6wsPG74HTVS0XTNH1R4fnhBXgi+?=
 =?us-ascii?Q?qT7rmj8sudXSRLIjYPTz37JWI8cfU1QB3O1WspNp3nOqMpY6On2YQGpK2i0M?=
 =?us-ascii?Q?1uLWi5ti/MKXk1VbUX6jitn7E5ec23UB+YE8W61qMl9OxHDK1UVXBVwICvY1?=
 =?us-ascii?Q?ERp3kvhrCBHLfzzwXDecgiyW5JgCqE9mvb/Owuj+kndfZX3GSz9rIlp2jOHk?=
 =?us-ascii?Q?b2WRjpDepZzhzsaZ6e9vv0xhEt9vTPRpYSYOIk9sOIAOWmbnFCzmEAUJshgS?=
 =?us-ascii?Q?6m889Dxdh3E7Wy5K81GgSiYAW8L/e1kaOHvmhAGYfzNgrtxBxF4QUA8PN+dz?=
 =?us-ascii?Q?YaRHTn8ObuexQlaSHiJVBFj1x5JJ7S5WWo7eFh5Otzso8eawm9P5+BTkvwAX?=
 =?us-ascii?Q?uGI+5mFp28FC7ZU6a1YlMFcktoPm6/vn56C/GqeXpeVU2JZh3Z1RnhwK8+fb?=
 =?us-ascii?Q?iUA8EzIB5kvKxBJumdHItGO8vWhmQkzBDmWePUpwf2YotPFJXz+noUeaJ0JH?=
 =?us-ascii?Q?/FOZAh2VESgQWUU4vWLqhLUnswdzO328wO0JbuUoms3WKjQqGCsVn5Ik2EVe?=
 =?us-ascii?Q?fBlhLYbJ9oW9BSPNkVaApyBo4dwgMJxWQkjFVOm1VZH+QMvEtl4o0bKSDfiM?=
 =?us-ascii?Q?0mF7y1JLrL6LYCwMHwQoP0TEIDApAdABPIQS6MA/w+k55vUhTGW83pL2Nc+D?=
 =?us-ascii?Q?RBCKIRX3FtOr5YAB1508P7SVQ+Qo99SLhCPgSjL6KVLfsSmUQWuRN9Qup7LQ?=
 =?us-ascii?Q?qxBSYhyzR8TEojfDjMi2pINZPdznClohoJyBp9wOcaZu+xE89kxKdtKxuxfA?=
 =?us-ascii?Q?LxedN1/8dz6lChb5ltg4CtLqjD0Oc1eMOOYF7I/Eh3Dibe4/P7J0dTB6DESd?=
 =?us-ascii?Q?g9f4kY0TMj9qW5KbeIRVY7qJFKcxJOVTDVij6kTnrZJVJ4Vy3+1D2vxQHD0Q?=
 =?us-ascii?Q?/N9FJKezlD0eHQfHl4OOb7gggUh9Lxc0kXNwawRfKAyX2bQUowYAVcA29qZz?=
 =?us-ascii?Q?V0zDijSHpE3MBTRdoOXSKW60hAvdkOt5920Bge76O2G4BtoNU1KsGuSRzt17?=
 =?us-ascii?Q?2VuLKpiXQNtaaaxlkM21S1o+m9HJ4w/fn5VAWD/8HkaFo5BxtSaxe/FDtlKG?=
 =?us-ascii?Q?cjJ9p9KXy2bffrGN1rOQ/9kTPOzzSZdLG52z22r7f+qenzpkb1NbOy79mAbd?=
 =?us-ascii?Q?KzfUYvmec21FNRcxqHkof4a/bRE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc7ac9c-dd42-4fb5-a73d-08dd3afa785f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:35:59.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3Xjo3cim/9GC+TsFLoo55byZ6IJn709K4Xw8RZvK8gM+5HieXsOfXwfIXQ3tLR1iCXKVq74gKg+n5Z+1skFp4B/jWiRvbCOEyaXcxs2AcCqdMryvQu7svaHUQFWLJB5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8201

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
index 8a05cdb41d70..61bbeadd51f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13787,6 +13787,12 @@ F:	include/net/mctpdevice.h
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


