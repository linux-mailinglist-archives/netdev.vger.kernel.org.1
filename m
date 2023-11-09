Return-Path: <netdev+bounces-46756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D75B7E637A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 06:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B16BB20BDB
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 05:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76BD287;
	Thu,  9 Nov 2023 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="NSm6iGpa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DED27D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:59:40 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06342584
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 21:59:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx9w7e8eK7c74bzHevdpoemyeBhvL8gfGkBzc+l/e1UBeWbTE2UhsWDu1QAPtg07BmKzU5MPvP9+rBgmBfvuypdOCPERc1cCt8abbPY9UgfxaPe5AcznWS8z3jnnFII4pZwAR74qmOWlYYHzhb4qbEYGi3ofttiePARyuoGDdlTfZVZ9rJFz7mR2TVDGyk4dnKYAH+m/MuWU8B+9fQeqOPkSxs2n5RdugZc8K7RUO3+gMIfLebqauTlZIptMERW8ecojfYWb2m9QyFnpiWMNygfVTUaP8XA9JcuYQKtWAugWFiibhjAPORA4ZTywkewzj2qQeAsoXIXwV6gl4grMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0VQC91RscsHDjKB13XlOYAsug9a3jNh6iubmwGqsVY=;
 b=ho3ox4W7sYoamzWRUr6UIZ42FPA43xWhxi3vhi+wceeCO9K2y5xL6uUeSkMjWS8CcNSqu1gpHPOqIhWwsBuIdZj6Etd2xwILjTAttIlxV0dhR6bqNaxlCB/yJw2/sh99bnwygIM61VS1JUcFKVdQxPEUSpGa5SzMg4Dk5pPuYeXlCqHg9QYs82Utr8sHeiFOvPIl0xVHhi4q0Z97/vsVSaMQwAb6gHHh3xAubmBnpTDU1dNaT1efNugts31RPVav6g5YIELxUZfzB8+AwzFB/V8LJ1P1kDF76nQl7JGCA86U+z2ENKnjBg7QEeqxe09zxCYN6+FhPKnxsaaKZlg7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0VQC91RscsHDjKB13XlOYAsug9a3jNh6iubmwGqsVY=;
 b=NSm6iGpaoVKkxjyb7F1l8e+wZ0emECsSzNQ1Uks1f4AG0Cyl38q91dOt/7wgskgkPdNK76rSwWxmAhbBftu71y1UbXbdUMnU83krTnPUO8idXClvSGtzF2SVe7nt85IqD4/L62Os7RyM55eqWHBh87pHX4pw11kjdUgGkJqX4iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13) by VE1PR05MB7552.eurprd05.prod.outlook.com
 (2603:10a6:800:1ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 05:59:34 +0000
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925]) by AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 05:59:33 +0000
Date: Thu, 9 Nov 2023 06:59:26 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	ilias.apalodimas@linaro.org, mcroce@microsoft.com, leon@kernel.org, kuba@kernel.org
Subject: [PATCH v4] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <4wba22pa6sxknqfxve42xevswz4wfu637p5gyyeq546tmzudzu@4z3kphfrpm64>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: AM4PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:205:1::36) To AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB10778:EE_|VE1PR05MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dc9ecb-7f65-417a-0dbe-08dbe0e90bdc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PChcSu3MJ62EtKksY83c2liJjo0C7/51ojzOru3pmQdfU6U7QFTqxnvzK9UX9mdF+kdGqXhfgsOzNywHsfah1cTYzy173yRNUBmZlwTKQzosGXRUTM2U/RK0vrvnMcN8SPgeWqCUa8tRXIeHH5hEOPrjnt1rCMjyvGosAHY7afWwgCVE4lBAFKo+LpH2rrJkFM6nuJQBKrXizzOmU9ap4hoh2O+Bcr4lRu0YUlV0dD4sFkqvRcSB1YNwGu6XIA/xKaXjgG5TWcJpTsRh0d8EfAGAQrsp6Z0WdLEfN+FgfIWSBbRCJQ2alaY7IMNHG+AYzLfYsi7hIhoz8iBCMD8rMzV8C//5q/84fy4ahyu1zP6mM9jJxKodWhU+QKInxKWnepQUv6U/OdnI8BKgJaoWWA8YFUNJDLBF6YssrhSMLqnLcQR++xHWSyaO0Gh1UPh/EG60vY0vm0nNXtjFfE7X2FHqQMCXSQGdcTG7G34ccL0B/Fs0xAYQvfkHsrXYrdLd05cV/F8Do/9n0Fuu2nCbfb6DMR9Oyw/c6e9gCDUxwSV2t1VZXCghYV6WxD479oMO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB10778.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(136003)(376002)(39830400003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(6506007)(6486002)(478600001)(86362001)(38100700002)(66476007)(83380400001)(66946007)(6512007)(6666004)(66556008)(26005)(9686003)(5660300002)(44832011)(8936002)(33716001)(4326008)(316002)(6916009)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALdYfqZ8AmGkUrY6L49GNZGWP3kDdnmiyTy6ITJPA10k/6eOQT82C547xnIS?=
 =?us-ascii?Q?tmjcK1/ybbel4kMFZ03PuolVI6O4U9OtilkKRGui3vIj93esn3sr4fmar/Vm?=
 =?us-ascii?Q?ti2Ot9jDnZZY2s6VaQ9UMiidTVEVc51GUl0yYrYD6kWYDkH/+ah9N5bmB419?=
 =?us-ascii?Q?Amo26qpLGT7GXraidnuLyrA6FkwzgjxBtkxbbSBBS9009/+ZtoaKyO0eh4u7?=
 =?us-ascii?Q?z4c5qZKV5l7cJBmeLknFMMlpWvcUqiEh/jx3vOKbAAHG9N1DP5aGebvJUcwM?=
 =?us-ascii?Q?i+Fsr/2pVzMoYZb7REgGI5JvOwRsYB2RsfFAVxcs5D1mf731sJ99qHzs5O7Z?=
 =?us-ascii?Q?3aUzdmrJbWy4PhZ9mgr3TWOvF5hA0jh97Io4u1lma5M9R+7RxOvzxE1uDTsL?=
 =?us-ascii?Q?sLGY7VoOmWYiXfH435PmOeCp2dpZmIPpMTSL69vw3FtNKjQu3n3AyevsSC/5?=
 =?us-ascii?Q?8Oe9F6uS3PZiuMoAb3BzzjI0JLFXf1zLdzcFkIqHuzwnrW1CXBObv6o4MepM?=
 =?us-ascii?Q?lEcQTW0a1L2tPoZjM+9/OSFZ323x6K0kk8K7Y1G/KHONv15sZckxrfqNloyG?=
 =?us-ascii?Q?wg9XWfU+/IQQzXFm99LBQWxYETbg1hjoIGtzGXC69IWqVa3Wh0nUHca9VLqs?=
 =?us-ascii?Q?4ukFpc3TwWoHAlMS5aKo4zyvPQ2nFwfzy4iXjMWRKoStpGCmF3YLv6PQJcBO?=
 =?us-ascii?Q?rYNdT8/1NhkZRBx3OVwZlHhCTcBC4ZnwXzp+1FlD9ft/irxDMHHdw/d9p0+3?=
 =?us-ascii?Q?4SxtbMcir/FNZUGkYgVaXXv5ZahU7YEPIRRUWiWjQByW/6nagnf8GSzRxuK3?=
 =?us-ascii?Q?gXNm+x5oq9qAnx2idit2CXSWNsh4ULzAAq8sU5TNI2mCrfUokqdDvzU7Fiuz?=
 =?us-ascii?Q?Ed4rwA7rcs+IpvrRPFzxmUpHwvJiQmbnA7u4XAS7xkG/Ipx4adrRXF/TYXG0?=
 =?us-ascii?Q?lx+LQ4pgZvwoUwRiSJDYcn99wLpKzh4DfsixOpC1M4/Ela3YAZOInTe/Z5on?=
 =?us-ascii?Q?lD4fQs13j5BAZ866P6Dpa3bIXHdiYwaomyX76W3Yh9LcZZI4Phy/UfKHpbU6?=
 =?us-ascii?Q?/uRw5n6QY0zzV6Q4efJpm8/OdE3gKb3aQPMGSwZzftSCe2CWaWpWv4xaZJ3G?=
 =?us-ascii?Q?y3GnTyQOz9CYMR8SUti6KllI3oEilknpotPKiWNwPdxCRKUK861JhIlEZOeS?=
 =?us-ascii?Q?moAypwaidaQUhXTwXApoTOM+k8zThfjNj8J0q5HPmqnR4Zm0FROpfJg6OkI5?=
 =?us-ascii?Q?avCxqv3QkCRoQ3rRNgYnFO+XYqUmg+PQ4WS1tlaplTvFxfep4ue4FnVL4NPE?=
 =?us-ascii?Q?LxJfj+9YbzZEjudGelwxImIk6scT9n1E1UI0r7IDN852fr8Y+vwBjnyofIkF?=
 =?us-ascii?Q?x3e84q6JKg57WF4EFznq5h2lSULQeXLvu4lhaXqep7oTiflkt4YC1AygYGDL?=
 =?us-ascii?Q?jGqqptq0lxfcwYwfHs0uiwaICEqYdxw5HK9kSn9r67va3uIHSKUlo9UJdDmi?=
 =?us-ascii?Q?UTlJfJPRC5rhLTYr+2NEVlKtZfwAvAW80717XLQZjQEE6/IsCvIkzuLdnfNa?=
 =?us-ascii?Q?RV+SQmcL2uzKm9+4CZjyonLSTBMcqaTzb3AHglSBIaFBh5iLv/HE3AUTQEHi?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc9ecb-7f65-417a-0dbe-08dbe0e90bdc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB10778.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 05:59:33.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXuc5BZHMgbsNMbxkKtrkz6A85ffKW/cUcVq2sci1gK26p7UTGjpmxVv02QuuNnVztTSVMyvqZnUWs4t5SFwy7Q07pp1J7Nx7seRnORvDcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7552

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

Change from v3:
	* Move the page pool check back to mvneta

Change from v2:
	* Fix the fixes tag

Change from v1:
	* Add cover letter
	* Move the page pool check in mvneta to the ethtool stats
	  function

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 8b0f12a0e0f2..bbb5d972657a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
 {
 	if (sset == ETH_SS_STATS) {
 		int i;
+		struct mvneta_port *pp = netdev_priv(netdev);
 
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
+	if (!pp->bm_priv && !pp->is_stopped)
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


