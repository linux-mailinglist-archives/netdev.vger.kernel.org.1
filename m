Return-Path: <netdev+bounces-68535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A108E84723A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B8C28AC5B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07FA46B9A;
	Fri,  2 Feb 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="e7aMmCAb"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2182.outbound.protection.outlook.com [40.92.62.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90814532C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885608; cv=fail; b=kua43Q6Is+dGYNlCjiAUgwzMhR1wDO6AKf1moAGcoGRQh8I7bDAELNOXMQw7IjEO5O/ttfr45+I9M7p9KXdDz0+NBisWVZonOZk3514MNkzvwq5u79H3RA/67e5GAYterLtRgQEQUCEOnoA0W5KLp1BLkzbIuirzNV9en4NmxzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885608; c=relaxed/simple;
	bh=tha8v26+Y4/T46gw1httTeCY9sZVACyTYufjXEaeRFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NyfcJetcLc3r1deJT+ztG0RFJ160WI/mlwQ+L4NEc13kH6UNMN4x+Qn70utYFwhxvoT6iiGhsUqfJGODL1iOuTHiAeVyKQmq4QUhnQNbL+8raGjGeT/axKAdhuk28XVTUZqFCVM/000pK6nGEp86MNfPd51AsJwx+An5JJk6BtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=e7aMmCAb; arc=fail smtp.client-ip=40.92.62.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxPYveLDc7ZV13YpDSqhLU54kR61XUKOHHoBgGcGVNM131W06ZTg8PFlcZaj51it66IhcAT/O4YrJQCFpxs2+FtywIqSUOhqBGYXmmCrSzfPbfG2h3aFr5KY7Jp1oCqjxVNR9l2yriyPyUdEX6n6oGrytwWtUbV5SYBbOFxyLk2/dVoeDITFfxH9LJQI8oiC9dZ9A8ivkEt3sI6oMwJl3M/4wwPc6gd/0TJQ5xSy4GMZlXQIEZuHb+vXz8upqNuauemZh3OvGCjv4fobTcSBXiZ5t87VZ7w71oVmxilkIaKOCbRvjrPKVP9+kZHXgE3A6lUP1+dUdko6gdagVDt0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHfTN0v2eELrtwwj+VJsPwAySZAJWB2mB5d+5UMqnes=;
 b=C7N3QIFWgzSkDkXtlxyFs+hxWfWGy3nIzPf1DPdejeFiB/MaZJqyjc9GDEG2X2TlftEUSiUOKLEECHASOeK9kU/Lme0HsbnAwQy6h18Y3TcMRepPQoTElS4BRT9kCoiZqEWKvHX4Ppsfzg49FXFtWsj8EC20YOa2FFYWeB+wZJ4PsHSaVslAE5tT6QiKHpRMEHB3H2bpir8w/8SSA9SSjJKHB9aGtKQ3eyhajwK8Zk9yVO8+ZrN/nM3uawO+pNgH8QXEfV11yo0YkaLR6v4xpFhZaigj1wv6jk8vCRfW3oy4lsa+bTorOJ8BVEKZaMwNqZ4+PfhEZ/rQIZvFh6XYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHfTN0v2eELrtwwj+VJsPwAySZAJWB2mB5d+5UMqnes=;
 b=e7aMmCAbJF+6WjSlD8uRekooEfXfxh9r83NtjXqkHKexYR/SJrUVesfYXyKLenJK3PjJcnjVlQB0pSKX1A8JfbW+yBUkJv4HgD3ihJbzfYtYV3VmBUkzaHPesHhFNqKWvQpN8IspRb2UWHyArE/OQs6opSMHX2oItSDKTn/DCJHxCbQel3C4CXvaAPha4/L1DrgmEfRA6gZAFRhsUWIz1x72H01vlySdcm6KBHuFA9V6tV779d5mPReFwSsNPsDLvrVmEehSy8xrTZqxh1ZxTYk2w+ILuDLE594coRM3xMd4AaFtCSSVN5zsLk3woUx8CGp3Rz4U2BiuhOFh4vOa4g==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3821.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:53:19 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:53:19 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 0/4] net: wwan: t7xx: Add fastboot interface 
Date: Fri,  2 Feb 2024 22:52:45 +0800
Message-ID:
 <MEYP282MB2697B2E0997F8A7455C0E031BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YIV+pm+ePvRhmZFfJ8Fy047wj+Ul9159]
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202145249.5238-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5c03a5-b45e-4ad0-bf3a-08dc23feb14e
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fTa61voF783eI3ZA+3oOgpLovzPC7TXiQ0x34jT6PBdAyQexuhz7kQPujx9C1jm1vXsmuATK2HBV4EdTNSd9iMUyJ9k7JuaquAHU7BLUSrN+mYe0cn0KJ8EMBoWOkH1gC6Nt8bLBfMYO2jCbxLW3x7wFgytRRRjKnPeZ4LB2Lyp8HSezF9GFJ2bpqv8T4e3bPmgopcqBmynZoxj67rLx9UbihiMtJqrLxy1R63zfhu1QQ4BCm9mJQPxJzYkciGFYG8KS0Cku8u+osXQfQHkgQtgrKLB6FY+MQHY68TJCHFXlic+Qy2l35tRp59XXQOwJU3Y/81lnQudO3ij+iL2jjGhbmTzSYceAuNrMnpMRcDMj3NBae/bM+Y2y8rVo+3bqzauz+l0m+JzJw4+MXLmeGPBq574GWIuCByyLXVuulwl0ANFirfVhnBuQOy3CS5EishJd/uuzZfEdWg4W98oruSl1j++xyCnNpkN2ZsrMCg6EmIwj5Zm1h5Jhh0YXf0ipfLtesBU/krMwS9p6oeOjY93+wZkfiqq9hwZa2ke8loHy8gjbNMBVtsuOo5BJKY6z8xo6fE8m+MfT5bUorcwJVs7RJxzrbmq6I7Fx1edRjtMOM8IpC+paSALvUS6zIJpvpSOZYfAN6zmc3ikzwGsEdQTWu2iPS7O4bnyW5wH62UDkZK2fJRm3E2CzyQ/5FlhOSCK+uAedAkFEJfBSGBR9MN1+WrkazOlQg/LvVSZxyVbuAEFa+6AJRWIay7KNhx9BM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yh9IinX3gU/RFunQNuk15m0op7QejZq7L9azGr1srEWVOL25ujM++tJGNz81ZvqCR3tSy+0JzycrZ1AhugS0FEzwnXA0dyL2OW80gItzGW2r31MZDYvBAPIlVTJVJYntC6mk1Jb6pAmos9AOVJNEhnhix4PIhLllO/r0au1VqNEt2vPfirCIdfwQgnecUkPTPiG2LUqv4/WBjZedXB4zt6JDkGOJaH2FdLDRpcK5DGcZcU8wElgFT3yAuvFYKRzreyJ6kefTVoYDbtNEctLaMu79l/fJsrY7tXXJiKl0RXs2wd0wMMklfNSVb37Ym6snNdYcPQ4/K7z5JQTUmM8Fm07jesne8SzE5sJh5c0yt2F5B/bbX5IgSpzaxuIJs6xlKDcjXMCbFjn8pyOoibzFYC+BNvm9usAa6Ho2yk+BSk2RBIPxnA4KWVjKKS2Uf5njgKGYszs6R+rSOmeG3/IHAXqoU7dFNChg9DqfLwcU8UdgY/SmB2i84XD0nm9OFZk8AsqqZiIFPrWnWYXjsRBU46FzKEIyDFqSnH7XKk/kEeS3z16ip2piOz4zRZflK1+K
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b60cMhy5HYE5yO97LY+21//euyk8u60x9H4sCohj57JdidHl8Q8rZK9wZAu0?=
 =?us-ascii?Q?1TusS107yAS3tom9xtoIU2jz2EVUTvE4eEZpwVxfEATF7ZKHKyqHPgMlXovb?=
 =?us-ascii?Q?JsVG5QZx5ydlajJ5Sxh5/gZ+u8HkH+7OnD2tVVDIa7VeB8MvaxdcfhN9L5Xf?=
 =?us-ascii?Q?4qyBSRqdnno4abHOXShFPDIo2b/DGrglNJOBHpff241Bpci2+rswaYHtSRZl?=
 =?us-ascii?Q?mwLR7ZGG6Lve9bO7mEhvO6QpTgeu9kXiEkjCz/A68Ckpvo0bGxgv6zNb6UoJ?=
 =?us-ascii?Q?ioTTeIpWfbQwzx0BspBF5C7osG6n3qlDnYWo0vmyx0mbipdcztXnWSf0u7Mq?=
 =?us-ascii?Q?9dmLaajvKRhAr5sVlHP+SdhT2vLqX27ON8OY6K74i9y05gwpxsQP4uoxZJnT?=
 =?us-ascii?Q?KAWrD1lqWJIy9lYa/J8PdiBK+EnyRgo1pTRgyU0T9WLoKA7vB/CcB7NgKr+s?=
 =?us-ascii?Q?0ogp+YS9ADK7FNXRQTc1M2jLBwqe99z7zmsz9dBDZKbBSVTDnwSM1RCYz1Ak?=
 =?us-ascii?Q?oamNvsQ1A/XrV3L7kxH9b0xlPTJMUjyqJwHlDiKdRtwTKtmzJndI+ci40jrS?=
 =?us-ascii?Q?mTur/ryAJrRqubsSEo9juQirNMq8pVwGMwlfWOQxrnTTetF9Vj2cw6MV4yoX?=
 =?us-ascii?Q?rZtQ+gg+StoKrZ1xCvliwuM9ipkLAAkgTp6ps/TF4lEwC/qefwZ8Ao5tgmr+?=
 =?us-ascii?Q?o6PzRsN/b4x3guxlv+Q2iOrl1TbV6M8iPjjzGf0mGc7ZjgBRGEXFOi2ImLWF?=
 =?us-ascii?Q?YNGKuvd7qv/D/a10mvNCqC27x55Z6CiCBPkfOtARLFWUSuq4F42/z1wNjO/F?=
 =?us-ascii?Q?jam7bnWunxc/Mi7I/9tpH996s1rega5nsOBpkkoWB9SjYeVbnxQmFhVMMPgx?=
 =?us-ascii?Q?sraY7SQn6+ml48tMKONLuLrFE9NpCvKGDh/bUBzvggyfbDrDE5s0j1wMN4xx?=
 =?us-ascii?Q?RET+mAkM5hrowYEwBi3mTr/eI+a5GdV/zPxRghF9pVFZuvY0uNAngdtXEpvY?=
 =?us-ascii?Q?C6Kf9xhEr18ZqgLEorHc872csrX9uZ+Qj7i+JFvLv3B1+Ih52BGwnMBkEip2?=
 =?us-ascii?Q?EinuaFKGewphC6KiyLLJLJbYDTldbAOQguG/nSaZzrFrgqivAzzBo+fatTFx?=
 =?us-ascii?Q?pPHvs2pPaigWiJ3dLw2/r/dl2iQJ0z0XVgzmGNO7mvSt9O0DbthksRScKXzb?=
 =?us-ascii?Q?btWrLsPt8oJFS4nrTvC5aRicUkwIxmgHQBpP78RdzmOOrpBlIhXBLnkzDoE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5c03a5-b45e-4ad0-bf3a-08dc23feb14e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:53:18.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3821

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (4):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Add fastboot WWAN port

 .../networking/device_drivers/wwan/t7xx.rst   |  46 ++++++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 ++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  10 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 103 ++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h             |   4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 108 ++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  10 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 115 +++++++++++----
 drivers/net/wwan/t7xx/t7xx_reg.h              |  24 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    | 136 +++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |   1 +
 drivers/net/wwan/wwan_core.c                  |   4 +
 include/linux/wwan.h                          |   2 +
 16 files changed, 553 insertions(+), 90 deletions(-)

-- 
2.34.1


