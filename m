Return-Path: <netdev+bounces-139309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9E9B1674
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5731C21154
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B01CFEC2;
	Sat, 26 Oct 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="kWfRnlwq"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03E1CDFB8;
	Sat, 26 Oct 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933806; cv=fail; b=LrEQvbaGmK3LYaE/mzoR85oo6HBcHIsV19N2lO8vPfIryjxmqhGHxFSfCNFM82dnD/VV4MM6n2TI87C/QLB6I4ZIqQFP/gQUm3kQLbKzhuleD0OPGDnhLA/aH/3dsDjKFkBL5s7XUK4bo0QnqLD/g42lVKTYzVPmr7VJPqQGvRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933806; c=relaxed/simple;
	bh=YejsV0ZeEzietAVhNJGproKkXG/Ji45sa5qVso9d5FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGzT9xyrbCdVw1Bd/NBeJyUQ7CCYIU73DiFgYsBUDT5f+mpbwoKOf4SO7NQpbHyhnhqu4b1xWnt5sqqZOHa9m9UAjKDGwiJuDPvXH6Tto3u/rcUmrj8lxinmbL9Z3lf7ljzP4lKTxjARosmmOC1B8MA5ovKeXI/FddBYy+ZdDNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=kWfRnlwq; arc=fail smtp.client-ip=40.107.215.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqXfVMXW9fdUaUmiSjIa2CkezU4wPeOVFTjB1BPcypCQoqGLVG6jXyWCsgz++5dfkbam85vQ6AfZB4CCO/JAndBvoAJLwKOW/bKJz0qUuF70K+tPJxLFwsRwgzq2jHuYtdiHYsEzMIDXzSRZ4yFgpKGsTnbPXzhD9tFxc9FzWtNSsIGLzeGj3/W+z6eGT2g0ZoHbdMyJDafSA+GokPO6htmewGQtbyBpW/fyZcwHlwaP+e9+2U9zcNYTZpCdGlJgm+a1eObuqYUCTiVVVpy10O/eEguE1I3/05ifDwKHh/2C3Wm5Pw4HgW0mF2NlZt4OsJWn3uW8RiXcLUb2v9CO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy9BRyDS/YI4u1/9O8lxo91aDjncgEt3P5B9sg3TsrE=;
 b=fDCvfq8zKi4538+IFZgGycMB/DqLY82X9F8/KBBqKGOZ2Kq49YDqufAz8TZbCODd1AdDjOrfOmC2jgj8e0PLeDJYhYOBRonkIWP41IpDL07LazaZHAe0aBUaI9HDuOi7Xx7FlAoXZyhGMMOtU2xEWcsLcigXNm6x8+bm7ROJdjVxjBBUvUCEHW5K08BA4aNsRWWAYoVnDCE9tI5eRCnLy3Y/RwiOe/66oAD+EsSYSYlo3bzq488URCzb6UZVlGOxl5lrlQV+AAch3OXDk6Zhq6ls9ecb2RyWXWBpfc1cbxog3HdiTyKv6LRQqy6YXFsjMkXnxdzVBARCY/GMWxTIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy9BRyDS/YI4u1/9O8lxo91aDjncgEt3P5B9sg3TsrE=;
 b=kWfRnlwqKkgJemJpEYIas3PPO0+uwNcIbYySxJ2ZYVjY3yL78doZ2EeHOYkOQ/dTYZHqoMPHPxO/ah/NWnWb80LSGkH5mRFMRr6sLQyoCl9kAE92nMr92bz40alZlyKRPXlfe6r7qzm1zYBn07M8UtQSBSl/gAyItCigMVlJOcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB5864.apcprd02.prod.outlook.com (2603:1096:101:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Sat, 26 Oct
 2024 09:09:59 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 09:09:58 +0000
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
Subject: [net-next v7 2/2] net: wwan: t7xx: Add debug port
Date: Sat, 26 Oct 2024 17:09:21 +0800
Message-Id: <20241026090921.8008-3-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026090921.8008-1-jinjian.song@fibocom.com>
References: <20241026090921.8008-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbf3138-4db8-49ae-91cb-08dcf59df6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HW/mKyTiTp2KnC2xdaGKy3WjksWBgrDfVK81joSP+uEztlbeD986nfoxmem9?=
 =?us-ascii?Q?gaaMAEm1ze1feS5J5XKBF9QKGLYz4xGtx097Qe6VCVkRK9PxDlrcAezSo8CJ?=
 =?us-ascii?Q?2Stj9gjfKK/XioX50FY44gf8xfPBuwzj05/vVam1dfW9M5FVhFeucra2TkNI?=
 =?us-ascii?Q?KPy0kKt/lThHZELDXdga0R0zlzHTFhUoD/hRTlmx7fbhKbq58bTDmr9Q+qno?=
 =?us-ascii?Q?k8axRbEBhsAvNIY019Z5ytInPlSH8ka+OOjglmxe36YJtaLLNvghuXWU9dt3?=
 =?us-ascii?Q?OYbIoid/dohi/wVZVRhtijdrQn/QlEQ80Q/CtJyO/GmQXtTIh8x90UTBTFyd?=
 =?us-ascii?Q?wuLh6uS9dGrqegJ4zmmPtclcyIwIcigwMruaWr/sHacSiUmRc3UhK25SZq1m?=
 =?us-ascii?Q?cedmzlwTQAMXNZ6YVvRTxYZl2JI+RmflL7qBDp6Eds8y6RsEhM+Ei4H7NuJq?=
 =?us-ascii?Q?kY78oXmzsiv3+TI5vZO8TUcbz47zmOvJABgQPwsXXs2cMX1S1P/ZCyVmfFmv?=
 =?us-ascii?Q?jqwIm7LvNM5uNeFnrffNDuWwfQfvE5GIfC5n0Sbi1hXriFowsnlyO+WW+ERB?=
 =?us-ascii?Q?CQV7YRPuUI4CRgp20JuN+dEd4NKXgmpFtKBHekjQP/6FGY4Chadtws1oM+uV?=
 =?us-ascii?Q?CPnaZDDEKWzN36ntqv2hinODpScam7F0/9qi2j6C1eoG00SRDZCWQGNInp2i?=
 =?us-ascii?Q?P6HEmb6/c2mDP5RwdeVVdjfw9bkvKxJ4uBtVXovRng94ELy44RK2bqtHsuQG?=
 =?us-ascii?Q?krN7ZIC8Khk6f49kcsReMgILUcksdTLUwSCjt46XJgpSbHVHWoHDMQ+hplCT?=
 =?us-ascii?Q?OR8oSR/xVc8ARZk8ThNhBtCiWsce9Cl3xcBQLR3PrLzpM/jtWqya9ltTeRWN?=
 =?us-ascii?Q?ZPk3ppAF34mUqXUUnhNFzH+ViM71/eCZRthsI5SE6OGw6QcaltUz6rvYzOlI?=
 =?us-ascii?Q?NmNHz4Uuy9hk0nxN98WV12T/4Zv5l0LNTZTE7tzV46ZxoZZ6Xfj/gQWWNvNm?=
 =?us-ascii?Q?ProIwyEr+2uWMDql2WhC7si8fipcotufhmxEYt2PoRoy5T/6X/DKYAiJyCre?=
 =?us-ascii?Q?6qanjJm/dhP9NWsMlCl0uw9/OPz7b+fmjv+fDztx17M1EO4z6wFkG/5h4TRG?=
 =?us-ascii?Q?Cf2JISTKqu98SFRvVSKqgiAuqjGd+dHdg3HtoY9munbkGKx2ngmUvpuMlPsd?=
 =?us-ascii?Q?K/jeVBT8/g1AAUzmTCOjBu32D5KeYpdwnzz7f1Eya3RS91uPtC528Wtct9lg?=
 =?us-ascii?Q?dZxisoTikd6CltQfq0fj6xMaSEuK9GtItjMPKvZyyHq1H7vSzYwddTKZzBBZ?=
 =?us-ascii?Q?PZuDMiyxeI6KAeoEI1xlqqVvEZoexoDzD1+jeat31lWhYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iq67ST0x576d39J0z8tE5owNXcdTBML2hU3LfY0fQjloSeGF+mae3iDFvGK?=
 =?us-ascii?Q?xg9VWPBztjSrnqNUupcQQiwkfpRY2fn43tpS4nuYqOYU7xdE137zv9Q0BDg2?=
 =?us-ascii?Q?OCLPbIx9zdpcFVmc6jY8SPIZ6eXWqdUt2daKoUsDDUEc9WVEk9EWl2Y5vy55?=
 =?us-ascii?Q?IdJnyf9TwQvHINnnYKP1IysHzpJ6uSQzcwP5vb1/G6IezphwivebiiJ+UFTO?=
 =?us-ascii?Q?OrN5noYFbAmnb7LfaAo5SorJWlOT88ijNl3a2aBzQ2BWC8HVSnsqIcOXBUNC?=
 =?us-ascii?Q?Ss49m+sIwR91y3T4Kwz8o1PtijHzDePGJZalP7MDmbcwotrd9c1EE0oXw4at?=
 =?us-ascii?Q?eAMmPOFxYb0H/JJ5F4KGpPTFiPynfM3KTyFKnW/6E+EJZMGSUvzMEU7nqa/m?=
 =?us-ascii?Q?wiALdlv+Q10/ynCu6M50TrlTDkcw2D2EbVNJphp1e6tORPdg5zi02mm2oRc2?=
 =?us-ascii?Q?bFPZlXZL/jWTvp8vBXIshJF3Wx6Nl5gmLycC7CY1wEyRXuvkYJqJUL7ctwPo?=
 =?us-ascii?Q?N3SAp4TpktPLV3dpAbd0SReVZE7BOB7sp8ZosMZXQsiD2dmkdQ8xLVgWd0D3?=
 =?us-ascii?Q?zRP7QlKLxQYYTNxwGfjdlnNrMg6CMdRQFOVCj6ILAiXhKEX6VI3YLh2dKGra?=
 =?us-ascii?Q?LrKfWyD+ulD+fwTfM6NA+08dN+9S6Q+iz3lGNo/bxg9kzWJX6CN8VWvuVw/+?=
 =?us-ascii?Q?l0tjrLe4APvZoegguXMEmSJL6kIYSq+ZTLJ2NtEkfjr9mFTF78KKhbwgrIf8?=
 =?us-ascii?Q?idXvVHkx6/dRRbH7GYYXOouNsxQqr4NDSHs70EmxEOeZvHpukTi1hGRGBgM4?=
 =?us-ascii?Q?xCGJ/Q1FbKVkEVN1rMYWlpr55hhqk2mVXHQ1uHgozblv3sUHodWsaKnjzSyL?=
 =?us-ascii?Q?6/pAyjMtmMaXBfJ4TV8Do0GcaLj3VKtGftWVU3hnUyy+zgbFji13Y1j2op/w?=
 =?us-ascii?Q?v4WmgQJsnnDmzuiDFIr2WxAj8tQ3D64W8BCj9vmOyLxirUaHCkpecilwDQFz?=
 =?us-ascii?Q?wIprYJXmGMv0ESsVg2LKmmPRMlY0B6itWFQM2FbsAlHAvgWTdXKvZPt6r4yI?=
 =?us-ascii?Q?bQdrDaExeC9Is7TfPmPPFNWH/0kcoEMG1wANzTpNpP0JTt2lBGtPdQ1Rjzam?=
 =?us-ascii?Q?slUQzVNRnenYV0A06PtrgIXifZEu2hc4fPuiohEs4xdsVkfVr9DsSUcvqw77?=
 =?us-ascii?Q?fiVEo3AdVEYK6YzFaobOMlQcx4sxi2ry67N/KMhxhrxTkC28vcqUkdKrJmss?=
 =?us-ascii?Q?HG25nYn4/RNrCKMGmQjXgggeU1c3Ags4Ot8H5NQsU38Wdbfb7EXP3x/h/Oqx?=
 =?us-ascii?Q?k4PDxQVCXlyt2nwUOkwTKxi/q3tkTYEcZYwKkxLbPoqIZE5RENw2nfiqHuQg?=
 =?us-ascii?Q?1hrZhTvk4vrvS307vkEafwaMP94gPU9/n9aw0q9MvMEPShnBQklym0Xaln2K?=
 =?us-ascii?Q?50iHThxptXDvpQ/ezcLyZN0AjXmgG51gwB992CZyFsTD9//hNmfVsL895XrO?=
 =?us-ascii?Q?c1dufH7giL31KyaRqnj9uGbQbWT0AlhEWyPl3NUyDBarzCS/1YOeCO+s0T4R?=
 =?us-ascii?Q?EbZIO+67T9QaaZiRjYwyee+fcJOgHzR4d0LFRxKmNT7RMgXm9sJXZrexn8Dm?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbf3138-4db8-49ae-91cb-08dcf59df6f4
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 09:09:58.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGFpLP46Spc3G/Dnr+z2mjHObqSvgoFB6613A68BCOMbFvsx9WTSihAakZtIMilX3B4GMsyCA5JU/GU/d78tHq7r7duZxgktN6onuNK9a94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5864

Add support for userspace to switch on the debug port(ADB,MIPC).
 - ADB port: /dev/wwan0adb0
 - MIPC port: /dev/wwan0mipc0

Application can use ADB (Android Debug Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.
E.g., ADB commands:
 - A_OPEN: OPEN(local-id, 0, "destination")
 - A_WRTE: WRITE(local-id, remote-id, "data")
 - A_OKEY: READY(local-id, remote-id, "")
 - A_CLSE: CLOSE(local-id, remote-id, "")

Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md

Application can use MIPC (Modem Information Process Center) port
to debug antenna tuner or noise profiling through this MTK modem
diagnostic interface.

By default, debug ports are not exposed, so using the command
to enable or disable debug ports.

Switch on debug port:
 - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode

Switch off debug port:
 - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v7:
 * Adjust t7xx.rst columns and word spelling in commit message 
v5:
 * modify line length warning in t7xx_proxy_port_debug()
v4:
 * modify commit message t7xx_mode to t7xx_port_mode
v3:
 * add sysfs interface t7xx_port_mode
 * delete spin_lock_init in t7xx_proxy_port_debug()
 * modify document t7xx.rst
v2:
 * add WWAN ADB and MIPC port
---
 .../networking/device_drivers/wwan/t7xx.rst   | 64 +++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 7 files changed, 176 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index f346f5f85f15..6071dee8c186 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -7,12 +7,13 @@
 ============================================
 t7xx driver for MTK PCIe based T700 5G modem
 ============================================
-The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS platforms
-for data exchange over PCIe interface between Host platform & MediaTek's T700 5G modem.
-The driver exposes an interface conforming to the MBIM protocol [1]. Any front end
-application (e.g. Modem Manager) could easily manage the MBIM interface to enable
-data communication towards WWAN. The driver also provides an interface to interact
-with the MediaTek's modem via AT commands.
+The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS
+platforms for data exchange over PCIe interface between Host platform &
+MediaTek's T700 5G modem.
+The driver exposes an interface conforming to the MBIM protocol [1]. Any front
+end application (e.g. Modem Manager) could easily manage the MBIM interface to
+enable data communication towards WWAN. The driver also provides an interface
+to interact with the MediaTek's modem via AT commands.
 
 Basic usage
 ===========
@@ -45,8 +46,8 @@ The driver provides sysfs interfaces to userspace.
 
 t7xx_mode
 ---------
-The sysfs interface provides userspace with access to the device mode, this interface
-supports read and write operations.
+The sysfs interface provides userspace with access to the device mode, this
+interface supports read and write operations.
 
 Device mode:
 
@@ -67,6 +68,28 @@ Write from userspace to set the device mode.
 ::
   $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
 
+t7xx_port_mode
+--------------
+The sysfs interface provides userspace with access to the port mode, this
+interface supports read and write operations.
+
+Port mode:
+
+- ``normal`` represents switching off debug ports
+- ``debug`` represents switching on debug ports
+
+Currently supported debug ports (ADB/MIPC).
+
+Read from userspace to get the current port mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_port_mode
+
+Write from userspace to set the port mode.
+
+::
+  $ echo debug > /sys/bus/pci/devices/${bdf}/t7xx_port_mode
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
@@ -139,6 +162,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
 port, because device needs a cold reset after enter ``fastboot_switching``
 mode.
 
+ADB port userspace ABI
+----------------------
+
+/dev/wwan0adb0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a ADB protocol interface by implementing ADB WWAN Port.
+The userspace end of the ADB channel pipe is a /dev/wwan0adb0 character device.
+Application shall use this interface for ADB protocol communication.
+
+MIPC port userspace ABI
+-----------------------
+
+/dev/wwan0mipc0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a diagnostic interface by implementing MIPC (Modem
+Information Process Center) WWAN Port. The userspace end of the MIPC channel
+pipe is a /dev/wwan0mipc0 character device.
+Application shall use this interface for MTK modem diagnostic communication.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
@@ -164,3 +206,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [5] *fastboot "a mechanism for communicating with bootloaders"*
 
 - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
+
+[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices
+and emulators instances connected to or running on a given host developer
+machine with ADB protocol"*
+
+- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 4f89a353588b..687a5e73508a 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -41,6 +41,7 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
+#include "t7xx_port_proxy.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
@@ -61,7 +62,13 @@ static const char * const t7xx_mode_names[] = {
 	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
 };
 
+static const char * const t7xx_port_mode_names[] = {
+	[T7XX_DEBUG] = "debug",
+	[T7XX_NORMAL] = "normal",
+};
+
 static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
+static_assert(ARRAY_SIZE(t7xx_port_mode_names) == T7XX_PORT_MODE_LAST);
 
 static ssize_t t7xx_mode_store(struct device *dev,
 			       struct device_attribute *attr,
@@ -120,13 +127,61 @@ static ssize_t t7xx_mode_show(struct device *dev,
 
 static DEVICE_ATTR_RW(t7xx_mode);
 
-static struct attribute *t7xx_mode_attr[] = {
+static ssize_t t7xx_port_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	int index = 0;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	index = sysfs_match_string(t7xx_port_mode_names, buf);
+	if (index == T7XX_DEBUG) {
+		t7xx_proxy_port_debug(t7xx_dev, true);
+		WRITE_ONCE(t7xx_dev->port_mode, T7XX_DEBUG);
+	} else if (index == T7XX_NORMAL) {
+		t7xx_proxy_port_debug(t7xx_dev, false);
+		WRITE_ONCE(t7xx_dev->port_mode, T7XX_NORMAL);
+	}
+
+	return count;
+};
+
+static ssize_t t7xx_port_mode_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	enum t7xx_port_mode port_mode = T7XX_NORMAL;
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	port_mode = READ_ONCE(t7xx_dev->port_mode);
+	if (port_mode < T7XX_PORT_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[port_mode]);
+
+	return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[T7XX_NORMAL]);
+}
+
+static DEVICE_ATTR_RW(t7xx_port_mode);
+
+static struct attribute *t7xx_attr[] = {
 	&dev_attr_t7xx_mode.attr,
+	&dev_attr_t7xx_port_mode.attr,
 	NULL
 };
 
-static const struct attribute_group t7xx_mode_attribute_group = {
-	.attrs = t7xx_mode_attr,
+static const struct attribute_group t7xx_attribute_group = {
+	.attrs = t7xx_attr,
 };
 
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
@@ -843,7 +898,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
-				 &t7xx_mode_attribute_group);
+				 &t7xx_attribute_group);
 	if (ret)
 		goto err_md_exit;
 
@@ -859,7 +914,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_group:
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 
 err_md_exit:
 	t7xx_md_exit(t7xx_dev);
@@ -874,7 +929,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	t7xx_dev = pci_get_drvdata(pdev);
 
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index cd8ea17c2644..1d632405c89b 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -53,6 +53,12 @@ enum t7xx_mode {
 	T7XX_MODE_LAST, /* must always be last */
 };
 
+enum t7xx_port_mode {
+	T7XX_NORMAL,
+	T7XX_DEBUG,
+	T7XX_PORT_MODE_LAST, /* must always be last */
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -94,6 +100,7 @@ struct t7xx_pci_dev {
 	struct dentry		*debugfs_dir;
 #endif
 	u32			mode;
+	u32			port_mode;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index f74d3bab810d..9f5d6d288c97 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -42,6 +42,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_ADB_RX = 0x100a,
+	PORT_CH_AP_ADB_TX = 0x100b,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
@@ -100,6 +102,7 @@ struct t7xx_port_conf {
 	struct port_ops		*ops;
 	char			*name;
 	enum wwan_port_type	port_type;
+	bool			debug;
 };
 
 struct t7xx_port {
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 35743e7de0c3..26d3f57732cc 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -39,6 +39,8 @@
 
 #define Q_IDX_CTRL			0
 #define Q_IDX_MBIM			2
+#define Q_IDX_MIPC			2
+#define Q_IDX_ADB			3
 #define Q_IDX_AT_CMD			5
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
@@ -100,7 +102,27 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
-	},
+	}, {
+		.tx_ch = PORT_CH_AP_ADB_TX,
+		.rx_ch = PORT_CH_AP_ADB_RX,
+		.txq_index = Q_IDX_ADB,
+		.rxq_index = Q_IDX_ADB,
+		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "adb",
+		.port_type = WWAN_PORT_ADB,
+		.debug = true,
+	}, {
+		.tx_ch = PORT_CH_MIPC_TX,
+		.rx_ch = PORT_CH_MIPC_RX,
+		.txq_index = Q_IDX_MIPC,
+		.rxq_index = Q_IDX_MIPC,
+		.path_id = CLDMA_ID_MD,
+		.ops = &wwan_sub_port_ops,
+		.name = "mipc",
+		.port_type = WWAN_PORT_MIPC,
+		.debug = true,
+	}
 };
 
 static const struct t7xx_port_conf t7xx_early_port_conf[] = {
@@ -505,13 +527,31 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops && port_conf->ops->init)
+		if (!port_conf->debug && port_conf->ops && port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
+{
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
+			if (show)
+				port_conf->ops->init(port);
+			else
+				port_conf->ops->uninit(port);
+		}
+	}
+}
+
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
 {
 	struct port_proxy *port_prox = md->port_prox;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..a9c19c1253e6 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -98,6 +98,7 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show);
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 4b23ba693f3f..7fc569565ff9 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -169,7 +169,9 @@ static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		t7xx_port_wwan_create(port);
 
 	port->rx_length_th = RX_QUEUE_MAXLEN;
@@ -224,7 +226,9 @@ static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		return;
 
 	if (state != MD_STATE_READY)
-- 
2.34.1


