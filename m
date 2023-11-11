Return-Path: <netdev+bounces-47174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509437E8942
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 05:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B904A1F20F24
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAB3D62;
	Sat, 11 Nov 2023 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="AlzWylRC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15246B3
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 04:41:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824101BD
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh1tHtTO9ghB3QsVcMqPvCOHp7DyXFofLHfOLERdThgF2iCZdAhAOJyBeq1luUTUQI0TDYhS/yv/DS0/nC4rf1f2HJqVoS9CzUBwZAU5rRb/d5/iDsEsMgVqxFnjhwEj+l+CrlM94JpfioPKErRYhuQoTacdpMKP2m1MoKsJtlsvtnnSNMyyZqL8lFMUFcF05l7QjTmx7W0I7laJWauxrGasyy2mAKOsrnjmnTS1DWoBwrceqGiQU2KDcYI2haBSsNRBrYnUd6Kq3PxLEzUQRnJkqkUsfqozEfdPPJhmprbx0ApXMJ5A2Fet25O66bFuCGh8j0TB7V54WvR1uzAVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHEGeT7GDpHpRhqmv/049VsOn5ajv0/l3ElWc3m3ed0=;
 b=DH4V3dgUm/pDg3SUimN13dM/5doN2RNHuzxcX/1oyyJkLuSRIL5Oz1tW6YlWbuD+wLODK2uHQxEaWvlQ4k0TE36a10d2VmXaYkOYpbQRyUXtFAt0jVMBgVYXJDqxBMW/Qm23wZRWwugWOo6mbAMQBLSyVwToZTyAKbuXtQVVmjQyoUKaXUrp864zl8248RBZVUU9O/swEeBBSku7A01sdTHlNZf6aMsLoq8KUy+0vncc+4ldHAMCHGf+drmzto/7PRKlr7Qw5jzZDTrl0OOMQ1aEPxkAqhDMDcFUUm6z8HygyAff4TJ/v6nnOqR3yIlT+E96q9weRJjtGG949Dh6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHEGeT7GDpHpRhqmv/049VsOn5ajv0/l3ElWc3m3ed0=;
 b=AlzWylRCG1j2Ki6hSv1SXtJJYZHgtpLNTNVbszbSSwfKxO5nBl4Efok/ev1dk2UW8xMqGxKNr54PBcMYI1lAsWW7DrldUGfQlDI0yXEgTlq2YOfd9lMyYNDyUjtSpgtNPAQq2xL53nlNXqs408gWazXcK0iEvW1I8wHkGwMqQng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13) by PAWPR05MB10478.eurprd05.prod.outlook.com
 (2603:10a6:102:2e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 04:41:20 +0000
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925]) by AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925%6]) with mapi id 15.20.6954.028; Sat, 11 Nov 2023
 04:41:19 +0000
Date: Sat, 11 Nov 2023 05:41:12 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	ilias.apalodimas@linaro.org, mcroce@microsoft.com, leon@kernel.org, kuba@kernel.org
Subject: [PATCH v5] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <ydvyjmjgpppf2hd7rzb6iu2hi6aiuxoa7sq5qnorknwk5txuca@7fgznkjwynsf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB10778:EE_|PAWPR05MB10478:EE_
X-MS-Office365-Filtering-Correlation-Id: f94ca95a-e759-4fd3-e1c0-08dbe27072ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F87qw71a/f2mm4Njk/QwoOv97bqna9d3fcFdWBtboIWxEmd6ID7AUwqPhAD2yoSizGjK5hq+I0J5adZhHx8SVnyW9cGAKQA9NPNB+MHGrguSlQJ+dzuXcnKu35FkD00hwGOvRhca54KZ7I4Gf5/2ukl8+bswSWDrK+lZgXX83/0cgzjr0kXryQHIyFQvhLNqLKD6z/MZ4M0ssrLLNeowocwVmYSEHBizt+CnOA1IWpqhRxlAqk3vrV3COfAXYg0vPjijsEa9FT3S0uPGZKZmKIGSCZgC4hRj2qmU2kGuwW3qdTLaA4u39oS8i+U5bbZetiP3NILVJSj41uXlDiAS+ExKVt7sFeNzILrOYMjKrlmTwD2bBSwmlQPj/xlv+YD7/JwILwZfivvYnDNKJ3tp2uAXL7/CUZaIwfS6t3Szows+ENN2yXjJ6oDXr9TVHjMnzn4wSUkDwYKYudxemhtxDKZy5Z2Wm98/dAnft5BGgvr6A+D7mb9AqBFZig8inj5iJec+CqOlE4ohbXfDGBWXLSxY+YT5APVsxxFjDQJ8ttW/Dj4G0iTRE32feJJwk4tW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB10778.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39830400003)(346002)(396003)(376002)(136003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(5660300002)(38100700002)(2906002)(86362001)(33716001)(4326008)(83380400001)(8936002)(8676002)(6506007)(6486002)(6512007)(9686003)(316002)(66476007)(66946007)(6916009)(66556008)(44832011)(26005)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/PQYbwUnlD9xzQQwfi1xqCmpzRo3b7dUlKrvx0UY49DZ/CiFk97Ch0A7LfX?=
 =?us-ascii?Q?vX2F8OvwaLWkZp9qykbkncVNN9K6qAAVrChpacbv/w9Lb3m3X1j3DjGf5heA?=
 =?us-ascii?Q?Hj2018yKgg7btSzoINI1voOtK13iVEn/ddKAYgPhwzeeHETkV7KVhsT/Qmtf?=
 =?us-ascii?Q?/a9XM0tOke/WrdxN/1U3WqzLtBQBvyu3Lf/KZe18dIQhSP6MMLMZ5JR5lgYA?=
 =?us-ascii?Q?Lasfz5ZQkruM1CQyuGNWSLW3y3C6y01UkcKDc6hkfmsA/OlJrMWUQ3Ncdcds?=
 =?us-ascii?Q?nc9Ayj0Up4GdRiemXQXtefBVPmdI/Wm+k8RfI12sMmLOOmvGyMhA/rr8G0BF?=
 =?us-ascii?Q?UbSu3JfyjkyTcL3vMxgZ7RbL4VjfNPdQIwLqV/xUE3bKfP8uoCFb2g9q5qv9?=
 =?us-ascii?Q?CWb8dM9XcW9skP0BWrmK5NsM613nU/RSdJsWIg08p00pURK5j1G8fsG+GWIw?=
 =?us-ascii?Q?Q+asCf2RM8Cj5jyZ743e+Gv0rzcSt00Hw8UR4jEm9dHCM7nUigUkZpZW/CsI?=
 =?us-ascii?Q?P2DyIkPSNhzmu5naf69rv+rd8Tb81+QbxX0/qnPGf+axo8aByGAzMIY8tYXN?=
 =?us-ascii?Q?Rz2IoK5esfenfjoCjzkseFfDSea57GEvtnOiBJoV7HGO1S3gDohA4jvGNfwa?=
 =?us-ascii?Q?xbkOib3ZQMhQO1pDGxx7HqDWRFTVOXXlN1QNz4+uPpE7fBmZKhG4XwaouCJU?=
 =?us-ascii?Q?oNwashW1rxEQL4Fe2a5Gg07LKvUUHMWlMojmuPq1bIMbqBhA+tv0kEf8OKni?=
 =?us-ascii?Q?cV6ftIJyb5j6l5PVUcqsOrOGutD9jlJkbaCl7ozzq+SCsDhstb+CQoZF2kQK?=
 =?us-ascii?Q?/+6f2fOy3bSZil1AFeOKkGXB4TALSglcFQwq8SJtJUiqTklcVMgh22jWNao7?=
 =?us-ascii?Q?lg6arMSpgjscFaQqpUFGraR4wonjZdx15RI7fzMzrTgiQ2ZRniCla8wmA4Pe?=
 =?us-ascii?Q?8HLD4iRaBCWk+ImIsXrntXiuqIjfJj7TsuV8TuQ8ufA1hwNF6GbOCCAZKoFF?=
 =?us-ascii?Q?s13Em7QtLmepHNecNJugkz/d18I/kgFrImCGfoFUfAzKUu8ZXGZ5DTyT4qOS?=
 =?us-ascii?Q?1i+7W0xvWoOG1wuthtYxZJ/nkz3r7wZ3Uzx7DTRVXpnhLZP9yb/sfv8KQ4zN?=
 =?us-ascii?Q?lurN8kUdHK8yHLwkHXSW/sLJ3XEYmJiqdJCWOHo3tbFP4PF4gVNbHWuatsqu?=
 =?us-ascii?Q?Np9Q9ZBOV+bkMwQSKXFbQPJEB4pZ588bbh2m3y1Eu7iI5hYCcbazMfsfgfrR?=
 =?us-ascii?Q?qDuQY/ETMafoHc/HB/3BaDnrb4O9rPTg5gpg0+nAljXVAnYUJIyupCpELXFJ?=
 =?us-ascii?Q?0RP/Lg2EjQJ7h2dAUCQEX/iqDHrqitwCXJqdMG+mgwPOi3vGljcFAOBcYXD5?=
 =?us-ascii?Q?nNVx7rx2zForFXWvi61IqfzXkPLUq6hBbFTeDpKuMLewLZutCGKeVVcFhm8P?=
 =?us-ascii?Q?sW+1nfYD6kWCdsiimBeJOI1oHGWtNQhPOmNaIqzC920wrGX3yB4kS7+xnoOA?=
 =?us-ascii?Q?4dSSTRvJaIdLEv7XN0CPjqBSj5Gq9jg/3tPQaS0cF8cwGQNV+YIEFgOMFVIJ?=
 =?us-ascii?Q?7hLh9iRrFFpA4gwiOK2u5BF0rZUacWZ9S/SiPJhpNb3zzxpgsQYqY9B3ZaBc?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f94ca95a-e759-4fd3-e1c0-08dbe27072ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB10778.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 04:41:19.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFsLRI075Qpa2IT7XwfAXHK9H5S+2acIzdIZEfAC25Y48LUq9mYZux0Y7PFHC/n4M1kVu7miw3sWL5af9BbhRXzhbqbLq3YUoy8nXjE6Ja4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10478

Calling page_pool_get_stats in the mvneta driver without checks
leads to kernel crashes.
First the page pool is only available if the bm is not used.
The page pool is also not allocated when the port is stopped.
It can also be not allocated in case of errors.

The current implementation leads to the following crash calling
ethstats on a port that is down or when calling it at the wrong moment:

ble to handle kernel NULL pointer dereference at virtual address 00000070
[00000070] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Hardware name: Marvell Armada 380/385 (Device Tree)
PC is at page_pool_get_stats+0x18/0x1cc
LR is at mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
pc : [<c0b413cc>]    lr : [<bf0a98d8>]    psr: a0000013
sp : f1439d48  ip : f1439dc0  fp : 0000001d
r10: 00000100  r9 : c4816b80  r8 : f0d75150
r7 : bf0b400c  r6 : c238f000  r5 : 00000000  r4 : f1439d68
r3 : c2091040  r2 : ffffffd8  r1 : f1439d68  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 066b004a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Register r2 information: non-paged memory
Register r3 information: slab kmalloc-2k start c2091000 pointer offset 64 size 2048
Register r4 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Register r5 information: NULL pointer
Register r6 information: slab kmalloc-cg-4k start c238f000 pointer offset 0 size 4096
Register r7 information: 15-page vmalloc region starting at 0xbf0a8000 allocated at load_module+0xa30/0x219c
Register r8 information: 1-page vmalloc region starting at 0xf0d75000 allocated at ethtool_get_stats+0x138/0x208
Register r9 information: slab task_struct start c4816b80 pointer offset 0
Register r10 information: non-paged memory
Register r11 information: non-paged memory
Register r12 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Process snmpd (pid: 733, stack limit = 0x38de3a88)
Stack: (0xf1439d48 to 0xf143a000)
9d40:                   000000c0 00000001 c238f000 bf0b400c f0d75150 c4816b80
9d60: 00000100 bf0a98d8 00000000 00000000 00000000 00000000 00000000 00000000
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9dc0: 00000dc0 5335509c 00000035 c238f000 bf0b2214 01067f50 f0d75000 c0b9b9c8
9de0: 0000001d 00000035 c2212094 5335509c c4816b80 c238f000 c5ad6e00 01067f50
9e00: c1b0be80 c4816b80 00014813 c0b9d7f0 00000000 00000000 0000001d 0000001d
9e20: 00000000 00001200 00000000 00000000 c216ed90 c73943b8 00000000 00000000
9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e60: 00000000 c0ad9034 00000000 00000000 00000000 00000000 00000000 00000000
9e80: 00000000 00000000 00000000 5335509c c1b0be80 f1439ee4 00008946 c1b0be80
9ea0: 01067f50 f1439ee3 00000000 00000046 b6d77ae0 c0b383f0 00008946 becc83e8
9ec0: c1b0be80 00000051 0000000b c68ca480 c7172d00 c0ad8ff0 f1439ee3 cf600e40
9ee0: 01600e40 32687465 00000000 00000000 00000000 01067f50 00000000 00000000
9f00: 00000000 5335509c 00008946 00008946 00000000 c68ca480 becc83e8 c05e2de0
9f20: f1439fb0 c03002f0 00000006 5ac3c35a c4816b80 00000006 b6d77ae0 c030caf0
9f40: c4817350 00000014 f1439e1c 0000000c 00000000 00000051 01000000 00000014
9f60: 00003fec f1439edc 00000001 c0372abc b6d77ae0 c0372abc cf600e40 5335509c
9f80: c21e6800 01015c9c 0000000b 00008946 00000036 c03002f0 c4816b80 00000036
9fa0: b6d77ae0 c03000c0 01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
9fe0: b6dbf738 becc838c b6d186d7 b6baa858 40000030 0000000b 00000000 00000000
 page_pool_get_stats from mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
 mvneta_ethtool_get_stats [mvneta] from ethtool_get_stats+0x154/0x208
 ethtool_get_stats from dev_ethtool+0xf48/0x2480
 dev_ethtool from dev_ioctl+0x538/0x63c
 dev_ioctl from sock_ioctl+0x49c/0x53c
 sock_ioctl from sys_ioctl+0x134/0xbd8
 sys_ioctl from ret_fast_syscall+0x0/0x1c
Exception stack(0xf1439fa8 to 0xf1439ff0)
9fa0:                   01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
9fe0: b6dbf738 becc838c b6d186d7 b6baa858
Code: e28dd004 e1a05000 e2514000 0a00006a (e5902070)

This commit adds the proper checks before calling page_pool_get_stats.

Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
---
Change from v4:
	* Remove is_stopped check
	* Variable ordering

Change from v3:
	* Move the page pool check back to mvneta

Change from v2:
	* Fix the fixes tag

Change from v1:
	* Add cover letter
	* Move the page pool check in mvneta to the ethtool stats
	  function

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 8b0f12a0e0f2..c498ef831d61 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4733,14 +4733,17 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
 				       u8 *data)
 {
 	if (sset == ETH_SS_STATS) {
+		struct mvneta_port *pp = netdev_priv(netdev);
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
 			memcpy(data + i * ETH_GSTRING_LEN,
 			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
 
-		data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
-		page_pool_ethtool_stats_get_strings(data);
+		if (!pp->bm_priv) {
+			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
+			page_pool_ethtool_stats_get_strings(data);
+		}
 	}
 }
 
@@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_port *pp, u64 *data)
 	struct page_pool_stats stats = {};
 	int i;
 
-	for (i = 0; i < rxq_number; i++)
-		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
+	for (i = 0; i < rxq_number; i++) {
+		if (pp->rxqs[i].page_pool)
+			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
+	}
 
 	page_pool_ethtool_stats_get(data, &stats);
 }
@@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
 	for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
 		*data++ = pp->ethtool_stats[i];
 
-	mvneta_ethtool_pp_stats(pp, data);
+	if (!pp->bm_priv)
+		mvneta_ethtool_pp_stats(pp, data);
 }
 
 static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
 {
-	if (sset == ETH_SS_STATS)
-		return ARRAY_SIZE(mvneta_statistics) +
-		       page_pool_ethtool_stats_get_count();
+	if (sset == ETH_SS_STATS) {
+		int count = ARRAY_SIZE(mvneta_statistics);
+		struct mvneta_port *pp = netdev_priv(dev);
+
+		if (!pp->bm_priv)
+			count += page_pool_ethtool_stats_get_count();
+
+		return count;
+	}
 
 	return -EOPNOTSUPP;
 }
-- 
2.42.0


