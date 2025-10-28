Return-Path: <netdev+bounces-233547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08BC154A2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A680734F8AB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7F33B973;
	Tue, 28 Oct 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPs7CzXf"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D36339B51;
	Tue, 28 Oct 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663501; cv=fail; b=bsmTv6pDCEgPH3VHPN2UEOl/4o09OEq8wLsqrRyVz4CbUec88SKqymci8zJc5lRPDtU59vCEQsxylAvz/NKs+FjH7wxVcIvMoRexJZwv2WLTzVLLxJybwke+vt98m3tBDGidELxRKagGMSo5QL6Z4o5d4Dy5Hzqt1biSHV4NcNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663501; c=relaxed/simple;
	bh=g1zOSvU+6jyMjBM+Q8ZEms1QHxIa99rPZWy/dsUhnWc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QjCqi8l4fbwS6GWWT0pJPN6K7sGyBLwSKvzFCFzWzpCSMNk2nmHr7tR6ue/hWO3MCVL/J9WDhHi8ATY/DnkPjVbq+NSSw0qEoahOWQN09SC50OzPa53F9uCZRGXlqeK4E6PtLyahd+kgXd88GkSa+h+GdQt1jBfsEkLHOnTZ/gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPs7CzXf; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD6+L3RrycVNGcmctoWwsOTVx0iedoGwnYidfIA0291f8KZkpsTUyGdN2bRWjbObVb4w2Bvr1kfOjTK7hmWC2Jit2yXYraZRmRC4Ghqi6OTDVuxqQRhXmP76ndquGSZTZ7xM71v8uhzlmnWKDpzZ8xeJbAX4qlLRJemiqRG4XtR6mTGu2mjZOLgAqZXH8GiwtIkKkvqYmwD9mS2ojiCLFpCle2M/6dLcznRrvQira2DwGeJWPOY0c0/GK1NI8u8ug3uH68LZ/rQO4CJtJUJCQUTh+3vgWO3TNHn+MGlK2GlgjGMiWAB/7SEIE6o8LPgj5yZ+5ay4Q3RpUDCEG5/XoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEd0sWPoC3cUM9sf120w2IAm9lYUyiifBsbm6HE5ZM4=;
 b=jCPKcxXGlOmQJ1JTVeUTbjpADk+4uiOQlhELwaavIF4Mqymrv0455uGDzqXSa6sti0HVUuZaA2uvTeu3t2YIVaMRWdT2Nu+kwyQv06bjaR2X6SV46FghR1AfrcbXUaNIP4ZI5cGcfRDhP+mNErPEnPhR1LiVgyayUYBA4jLFay/BWr9ncmNS2IO8F9D1JFdc6VbQHTy4DTGYWFtwr+abU5kluK42XdwoU0ImBtkUWVioK2e1CxF21nYR58JWvGCzslSyUXBvQ+BDc1NNrxTDiuGKgrdUx5B9uqJezXLMJ90AHxEzkW7UTHfq0mQaZNX7zM14S0lFG51AT8Jjp5qEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEd0sWPoC3cUM9sf120w2IAm9lYUyiifBsbm6HE5ZM4=;
 b=mPs7CzXf4xK+da5yOYXOOOBavDM6YzZZtYwGhU0VN5YcC6puLV4rC7TmEKD2VQ5F+zyeaqI5HqQ9/+mLctrsPXhM3d13Dvmd2wqvP9OLYC+l2TOjOnqiSVYQbQcH2a7I+Bmk4FsbyN6cQbp6ci+ChD9WalcsVLfWzlA8chSiWO1A4po3uuE03MmCbNfUkOBmYrNHCLBYejaVDxvub1qIjrOqGh4+JMvv36XZdUbKaGrzR9NbcDR8GVtKYQEtHSXS1vMgmVP815VDyX/AoUL4HW/41I5QsMkcsZbMnfsAC51kRJZuR/AZeT/FWv1F5pzREH4yg3KAwNFIrxYAFmqD7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:58:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:58:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:57:52 -0400
Subject: [PATCH 1/4] hwmon: (lm75): switch to use i3c_xfer from
 i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-lm75-v1-1-9bf88989c49c@nxp.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
In-Reply-To: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-i3c@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761663488; l=2070;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g1zOSvU+6jyMjBM+Q8ZEms1QHxIa99rPZWy/dsUhnWc=;
 b=AMq4EiV0O6eTNmBzcbkKCOc0p++NWiBPPxdBeLvSfRkZ9m9SfO7FLgjihGBIOQWUnHIkwP+ao
 dnXfBJIs5W3Czr6gIAj4jdXHYnojY7t2kuUK7B42uBBNEAckZfHyR2O
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: efc359c2-3e5e-476a-8bf7-08de16326cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1crNVB3RmZQOGxWYmx5Q3dralpTcnlaQzZJR0dPRlJCaXZTbm0vOHNzYUZV?=
 =?utf-8?B?M0paMkw0VHdDb1VWcTM4RjV3ajN1U2JNMTMrL2laQ3ZPejlZLzh6SUN6THBE?=
 =?utf-8?B?K1duNG9UOUlKL2toem9aYW1RTTMxd09hV1lNSHRMS2RpdDZETXdiUDhUMUdw?=
 =?utf-8?B?MTIrNmpPc0IweEJHNTA1SERIWW13QzlVb0hGZlhwViswa1VSandNWDJxZUVF?=
 =?utf-8?B?SjJvTXk0SGN1NWlTQ3ZSN0NqRk1lRjB5UkU1K1p0YW1KZGxqeEFUUk1JMkl4?=
 =?utf-8?B?ZE11UWk1ei9Jb0dGMzhtSFNIVzk0OXRFdVZWL1NZUGxWaGJ3eFFrbkFEVHZP?=
 =?utf-8?B?bUpZcGhCQ1Z5TTlvRUtsbjgxZXlkTVRLSGc2bmJhcm1RUWhlL3VYYUZ2dFBs?=
 =?utf-8?B?MVNmdjVQMnZsMVozM3Frd201WW5Fa3pUVDlIczE1Wm9CaVRFcU9uUE5lZmhQ?=
 =?utf-8?B?dms2UStya1V6YWxVYW5lUW5iNG5na1VkYlQ0UUI0anBDN0h5UStJczNVWC83?=
 =?utf-8?B?SUp4N1hVU2pkaVlhcmVFdWdZbWRoSTdrNVB4RVJyc3RSYkJjTE1rVFJTbVU5?=
 =?utf-8?B?dWh4NktwNGdXelNnVEZWd0EvWmVBUzVZSEl3ZkZYTGFiZUZ1ckh4cVFTYk1X?=
 =?utf-8?B?NG5SQnVaeWhGL08zRHZFVlZVTzIvMUxYR1RCc01ONWI4bnpPNlpweXdranNS?=
 =?utf-8?B?M21KNURwT1hvcDFJNWVUSEtnWnRxY3Ztai84K1dpTUZsRTF5K0l1UlNxL3NG?=
 =?utf-8?B?UnBXb1MrVXBCMHl5MzBFd1RsWFp6UlN0WEdrWGFNVytoQ3puNWxyL2lFVEZI?=
 =?utf-8?B?SmZmeFNGeHZEVWVZNHg4ZnBXcGpuVElEYllmd0czTVMyRXp4OVpMSk0xNXdK?=
 =?utf-8?B?Tys2WlBwSkg4Rnl5dTZqR0RwRDJEZFhweVdUUXNxOXBuL0lYbEMvQ2VndFZL?=
 =?utf-8?B?U1hOUGJwRkVNeXU4WVJmc3g1YkFkNi9sMDlYaW16a3h0cThxOExudkw4aGtq?=
 =?utf-8?B?S0hmRGJLVVBFMzYrWDlFQVdGQTBSZ3ZqL0pxdW5tdmVxSkJsNm9pWG54VGpB?=
 =?utf-8?B?aU1IY1kxRU93Q3hGbm9UQzlGbkVFQ3BFSDlkMnZoZHpnVEk5T3ZUMGFTK1Rp?=
 =?utf-8?B?clRkMmNvZWh0eWlDTFE3K2lsNDRzd3J4SHFoa3ovNG1MdE84VTJkNDNBUEs4?=
 =?utf-8?B?SjFqemNpZDFZdmZjeXVhd0dpK3hMSVJsZ3YvQTltZWxja0t6bWV0MkZxWjl5?=
 =?utf-8?B?Z0hGeWVmbHYxZlU4Wkw0L3lXSlRlK2JTV3owb2JsakgzNU1ncmhPSlk4eFRw?=
 =?utf-8?B?TDYyRWdhWXNqd2p3TWN0Y3IvdTl5bjVzRWd1M1pyK1hBTzNwem1NaDFUYWFQ?=
 =?utf-8?B?djM0VTRsOE9zeHhmOTlqeFlCbCs4WGwzRzVhQ1BVZDMvYVVDMVgvVFNFeFhL?=
 =?utf-8?B?WTRRem9rbEYwbnFoaXBPWHVoWGFKSDFnbFVKeTNsdzd5R25oNDljQkwwRFNK?=
 =?utf-8?B?SGs3OE9iY2lpT0VKeExUYnV4a1Q2NDJOSmhUSStWbm94NUQ3S1FnejU4U05M?=
 =?utf-8?B?UmRoYkNnVEdKZmxPWjlaamhNcjNhV0lBYlVvRkFwaytGV3hiM045dkZ4OThw?=
 =?utf-8?B?aWN4dVpNZ24xUWJldngzL2ZKZlZKWWJCdGVHMlI2RXRSdmtNSzRlU2dON3Bq?=
 =?utf-8?B?NDRwM2hmeVZ1Zy8yYm42cE9DdXMxWFA0NGt4MjRRR0xDWk5kSkFIK0NmZE1x?=
 =?utf-8?B?aXFxY2JDMlFoWCtGM0ZoSFVOcVk1bzZSVG1FOXR5bWs1djNSaGFYaXUwOUVL?=
 =?utf-8?B?ZEwzNDJYeVpRcnY1alhYY3lsSjNJblN2MzgydG5WRTFWMHN3T3hGeG9iaVlT?=
 =?utf-8?B?R1NpcWFmVWI4dnU2ZXgrOU82Z0F4bUhCSTd3dmtjb0hCUFpXWVNTa3lLb0du?=
 =?utf-8?B?LzVEMndGdGdvaGxqTFlSb3hxVTdtTGRteFh6cmdQSzFnamhrVXY4NGtuTzVy?=
 =?utf-8?B?RW45WnR4ZTlpTk5xeFJ5YVNFOVVZZjBja2U2Y2VFZEdmaFcxeTJ4VkJzSUN3?=
 =?utf-8?B?bnhuWm9GNUhzREtqZ1V4MEE0YUJrODRFdlZwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBIVnJaQk5zMTBtbmUzQXRIZlJsYXU4Wm9qd2M2VllqaUc0R090Q05yaE9V?=
 =?utf-8?B?MjdLQVJqRktZZVRuSGZ1dlh4YkJ1NWJWazI2V1FhblpJRHROYU1yeDNuS21a?=
 =?utf-8?B?ZTFXUk9rRkIyenMwaE10RFU0YVZmdmo4ODdkY1VMMEZSNm5LYUpVQ1BiTTgw?=
 =?utf-8?B?QVVia2x3RFVKY01DMlgvM0hxalREMHJSTU91cm9hbUFDcU9GdnlIdGlrOHpm?=
 =?utf-8?B?bitJdDJCK2FvaFhmWFVuUnpUQXg3ZUtEM3hsY2hwd0diOTdWbDQ4L2Y3ZHRH?=
 =?utf-8?B?STF0VnNvTS9kTyt3cmpKSUJUeWcxcXJ3TGFJYkFYWTczeDlUeWV3RWNteUZU?=
 =?utf-8?B?RFJMYTE0U3B1WVA1MGNrN0hNREZubTNLR0ZGMGdwdnREWDl1Z2hja003U2VJ?=
 =?utf-8?B?Q3FzTGU1UXMrNXhMeHVMYm1RM1RWM2NkVWdkaXBBdXZubmhITmdNRE40STBV?=
 =?utf-8?B?R2R0WGNDcm50TXJROFQwd2RPUmNrSHl1RElsSGd1aERhMDR4TUdhb2Z6SklK?=
 =?utf-8?B?VWIyZUpwNFhxcnFDZ1BiVk1vOVluUUJIMFpWeXpBZW9jVnRMSkNlaUVwNEU0?=
 =?utf-8?B?bGNEeXFqT05CWVg3aWM1aENsLzBBTWluVzZadFJvTndBdXdaRXJiWjU1OE1T?=
 =?utf-8?B?Ums0WGxvYXBZYjh4ODYrUlV2SDI5R2I3S2ttOGRWYWVVWGQ0Q3NqWFVVRmZP?=
 =?utf-8?B?cVNvZUFadm1ZRUl1NDQ3WXQrSFhDeTY1eDNHME1wUmxsVFBGMVdURXFVTlpL?=
 =?utf-8?B?TFdKS2xKd0JFYXlIbHlYaFRrZitKODVlcGtPRjRZejdrQTZQUml2SGdlTWZT?=
 =?utf-8?B?UUF0VU1ZUHQ2MitialllTWdKY2t1eTlSY1Zza2pxTjhLdndUR3F3NmZpZVJW?=
 =?utf-8?B?YllQbHZ0d3Z4WFYxc0JMMkF1ekwwNWJxc21HdnROcmVWUGsweFNoMTlNZlBy?=
 =?utf-8?B?K2E5OWFvSmsweTNtWllqMmRiVnJjNTJLNExpMEpjR2tYWmszQmpERW5GYmJN?=
 =?utf-8?B?TVd5R00zbnBwcDFZOE1oR1BDdHhyc2Vzc2htS3l1bGhQcnROeUxIVzJ0TVMw?=
 =?utf-8?B?ak91RWs5VUQwVzVWOWY0TGwrQm9Tc3hMYXpoQWxKbVN3QVBKb2xaWVpYYnl3?=
 =?utf-8?B?L3pzU2dsSFZWMUxuOGdoVjdueUxhL1hSRlROYjJwRXJHVy8wbzJSNGFKTENP?=
 =?utf-8?B?T2U3SkhuUFZZWHZrdnFEamZSZVowZWFWUUJHdmhZdEFHWW03c2VKZFVwc2pU?=
 =?utf-8?B?UFF1UFBlVS8xSVNvUGRoUU9OMjVBK3ptNEhxWm5FSi84dFl5bDM3dEJ2dW5R?=
 =?utf-8?B?NHYwODU2aENSai9WVEFHQzFiMHU0Q0RyOGhWWGM3ZTZUTlYwSXNIRkFFdHdH?=
 =?utf-8?B?NVJWWGExQURYdHcrZFpNSGVTZDUzUHNSVElRbTBGUDNwa01uSVFuNkhtbHk0?=
 =?utf-8?B?Y1ZnZnpVWnFPTHRMZGdaQjdpQkxndHFDQkkxSGg5TTNBSjNKaFVDUWNKQStD?=
 =?utf-8?B?T0tBTW9HemY4WGRuaTFNMmh4ZnZWRmhEQXB0dHorK2JwU2U3NjFJTlNrYjJI?=
 =?utf-8?B?ZzJudU5kbmNiTzUvclpEekpsSnFHYldtM0NNOTBZRnpJUzFPdXRqbzlEcUR2?=
 =?utf-8?B?UTMvdmVMeVo5QTYrMnNVZWlTZVVtR3c5UUdhTHNzbTlCMmRBSmloMUI5aDZp?=
 =?utf-8?B?YkZBdVp3Z3Rrc2IzUlV6Sm5pb0ZTdXBmV0d5V1psK1p0SE45WDhGbDB0WGtP?=
 =?utf-8?B?ZktaRDlkcGZvODFhMDJtOE1YQkwyVXg5ZUZPa0xyWDlFYkg5Y0xCOFlvY2xi?=
 =?utf-8?B?bE9RK0h4UWZJUWF0QTBnaFo0UzZ1c1Ava1VoUS9mQVJoWHc2UENkanF2K1pJ?=
 =?utf-8?B?K05GQ3ZoaDFLdC9rNmNnYStLSW04RElobG5sMDZUWUhmV1hVRVFEUk45bDJ0?=
 =?utf-8?B?RzJ0VGxKN0ZvZGg5NGQvQkovVEZKeTJCTkpZeXlmNG1Dc2pNRGNoVmx3TWhk?=
 =?utf-8?B?MDluR1ZqNit2VjlZOCtuWk1OZGZkOXhRc2g2ZTlxUEdRUlpPOEk3ZFRTSWFU?=
 =?utf-8?B?TzA5U0ExazVLWHpzZDlvY2VXQ0NaK0J1emRTRlN0dnVWaElkLzVxTTZmRHlB?=
 =?utf-8?Q?TE+Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc359c2-3e5e-476a-8bf7-08de16326cbd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:58:16.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6e1+ZgUz1XmSTM2g4g6lkDyHjfyS2tstin0YCoaGl7rVeAqSdW9GaoWeyqOKxRta4ZFMhOWS0JInH5b82R+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10889

Switch to use i3c_xfer instead of i3c_priv_xfer because framework will
update to support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Replace i3c_device_do_priv_xfers() with i3c_device_do_xfers(..., I3C_SDR)
to align with the new API.

Prepare for removal of i3c_priv_xfer and i3c_device_do_priv_xfers().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
this patch depend on
https://lore.kernel.org/linux-i3c/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com/T/#t
---
 drivers/hwmon/lm75.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 3c23b6e8e1bf5c86bc305506eae17e2547e146ca..eda93a8c23c936d2b4f1b54cf695a097b1449868 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -621,7 +621,7 @@ static int lm75_i3c_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct i3c_device *i3cdev = context;
 	struct lm75_data *data = i3cdev_get_drvdata(i3cdev);
-	struct i3c_priv_xfer xfers[] = {
+	struct i3c_xfer xfers[] = {
 		{
 			.rnw = false,
 			.len = 1,
@@ -640,7 +640,7 @@ static int lm75_i3c_reg_read(void *context, unsigned int reg, unsigned int *val)
 	if (reg == LM75_REG_CONF && !data->params->config_reg_16bits)
 		xfers[1].len--;
 
-	ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
+	ret = i3c_device_do_xfers(i3cdev, xfers, 2, I3C_SDR);
 	if (ret < 0)
 		return ret;
 
@@ -658,7 +658,7 @@ static int lm75_i3c_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct i3c_device *i3cdev = context;
 	struct lm75_data *data = i3cdev_get_drvdata(i3cdev);
-	struct i3c_priv_xfer xfers[] = {
+	struct i3c_xfer xfers[] = {
 		{
 			.rnw = false,
 			.len = 3,
@@ -680,7 +680,7 @@ static int lm75_i3c_reg_write(void *context, unsigned int reg, unsigned int val)
 		data->val_buf[2] = val & 0xff;
 	}
 
-	return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
+	return i3c_device_do_xfers(i3cdev, xfers, 1, I3C_SDR);
 }
 
 static const struct regmap_bus lm75_i3c_regmap_bus = {

-- 
2.34.1


