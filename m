Return-Path: <netdev+bounces-68040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A5845B08
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318601F2A894
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA636214C;
	Thu,  1 Feb 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Wvjnarhf"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2162.outbound.protection.outlook.com [40.92.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582876214A
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800462; cv=fail; b=AWTFuJ48eTxQIYc95vFeAaC2fDv2taLw8m2x5xIXh+4PWehURnDiJN1NpaPvaVHHeb1QIwA10zkNWim2sBKRoM0/DOSbh7NbR5RxWMd4WzyfeF8iCUOl6kwz5PWZIBj7aBKwmMGoHXhSG9RJLLyEC2rxgLdVUdKqZTWaLyvq/Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800462; c=relaxed/simple;
	bh=jiXLJ61IFrz6qxGj7RBd0m9XOC1t4VfbVDACRNZq9qM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iOkwuadpcTuwZk4PCEgdaWfIHh6iuYQTodIR5lwIx9CZEXzpGDtEwRPG3srOfb6ENExvePF09AZwk6+tIeMJYiNi423IBKz0r0Vd7uQuddSe+ddjyHUK8W7SqhFGKZvKlCi9OcfN7gsCA3oj6Ii2OmdU5N8xD8/zE2uCioFV4UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Wvjnarhf; arc=fail smtp.client-ip=40.92.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mahvJvrXplzgw9SABodWbHtl60j+xUv559GAozR/EuiDNsAGWICB3WHk+IwuvtWTsueeOKX7DqXxP3zLInlZdHEnOYrj96qe7bnakiuC+16pqZXtP6Y3ukiueHqbDPN8xdEJX8H5kzb4RLEIoQL9NlbKHfRHAB61x656W1KcboGx6FUXqs5bUUjuB3AQe5O12z/bDK8ejf/zCB6eTrDIRnOnjdDcUvTmutiHFetaskqXh2u+FdB/EoigQCsr2Lzih0TyQTfPwswRONoNJz8SRPwl4S0Os4btM+P3z8hG8X4ohCKxQpeIO8qynntfl6JS4Ko+A6nl+FmKPP+5Z+3cAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTG15CxHtsb02CTTiNu/LYaMTpbbFIiSFnTo4I4XEA0=;
 b=O1f7GouyynEnzW2BZNJQzrbd/tFToW9CvGmOuSoC/daLJT4JKc5HdcuplQXgXvjKXwjhLoZ5wJVkpWZqrRB6o05zMvNb2BMXVm+hfAkrC6xVJPflpzfWbO0r2GNNy9mvG/A0SYtXA7NiZbXIhD8vbHLcy+woJZeH2dpuHnCopr6yl6yvbY+LwBl1yYnU1nFboD5Gvk3LO9R99vZ2+CZgniTWmGDm7r+5XIbSoE9Otbf18tqoh9L4kbWZ1RNfwC8KZ2zci1K+EZ3vkNMeCO2b9RQav37jj7QtjlRPe5X7A2JNuPpu5rHfXUHBFZL37pdaJziNTLGK9+WMrzy9YMsKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTG15CxHtsb02CTTiNu/LYaMTpbbFIiSFnTo4I4XEA0=;
 b=WvjnarhfZ7QxajdfJouYR11uw0mGfx8T11HPy6TZgAQqZU7afs51Q02PX1kTSSv82Y6on8NZcIAedttJkTo1EgROxiZHHxLoCJuSPlhVK0RTGyVqxKe28hApgsy4IaJN92fqc8CuWroHfqFozbwkhYyXDeDDgpHY8Amy0bt8/C+JcHmqe2p0uel7KwVY++LCjs5J8hXQH6khJyVmnQ/ub8gdFXEF1AuuLkWMzVQAeW5qXtnzsjFjjmBmi+gfsr/MFfgML+mAzXJAslDYdh9GhaR2CnN3TTrseiqsMa3RXpE1Cexk2oq2fDyliKdiTVafQWByNeKEYD9urdBrsB0Zgw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB1224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 15:14:12 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:14:12 +0000
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
Subject: [net-next v7 0/4] net: wwan: t7xx: Add fastboot interface
Date: Thu,  1 Feb 2024 23:13:36 +0800
Message-ID:
 <MEYP282MB2697FFFF7374E55559648079BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BG7Jg0rwcT+vJ4WU/JZ5O7X560dY+yc0]
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240201151340.4963-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB1224:EE_
X-MS-Office365-Filtering-Correlation-Id: 390ede76-c4a8-427e-0af9-08dc233871ed
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6freGFPHZ3GjGHLcCLCqTPfgKj+K/IenfLeWB05QnXpt9zO5SdQYmGb0rBon/fNgkzZLSVHkl4IwPr40O4on2id8Sd005tJM9ZFvFn38IdSLpoqW9VlEDFY6z4wueNk+L468df3HdGLVoi6kSP5LzNO69CE4yjYkx/K8Gl4fIJNVK8n0kF5CVPUGcQVtJqe5IoprAEcqwilYhuyD3jjVXXILnKWReUy/sHfSTJ30CqSlXLSPSwBYKowbHu/zUikBEzVcgeYnsqMk+/rONRk34Dz9ed6TeWD6SxKne/+G9pfDXDVXObSLs1mzJ9xBBfXZ1P88dcLr9VxVJyZX4XU9b5WxZwV5x8qDx5Lbq/ZJRZ8LUVQXhItjm6aSEcsVKBrtC0WMubznE7rAjACjor13XP49Ffm9Y61/OdZVeOj+EjPgXGUIorzUwS1v+Vo1RZVByzOCJKIOKyikLXtr3QV0aZZyVrqZkqsYsM71ZlrlIEyOs/xq+sULjDWLJ7ixBjSl67iE4pA7T6pYqGhzca+I7q96OmwWGVr0VwJu8isL915xtITY4/RthpUnASyHt4dEHcvQqxCiQmaJ+zIH2C2RaNW89sl3wjeU+ngeJdwmsOGG+J/0zFbbxTVUTTc0U5vLqebQ3SoIi6ig+96g/5wDo8XbR4Wr+B7CGHzzaeooPki5kj9E7FEMc1lBEdMCE453a2wgvlv1T3ul5zJeAOncrZ+00zoVPQ38q2Opqg2nPUKeMLnnLuznAmgyp+KtUtOkVw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ULUzLQLaM5tnxHrFzwh6Zw6srOJFVuUqUujOE0gWixr3LfNvlDf1yGEGGqPhBicVzUI/7cpqckQGdJJEu+03lv1S63G068klfZA7sajp1DgmRCi+UQ4cJxEros6mfG4wM46Bmxjg+Swpj6x8ybsFnCT7ff0VeKXRhKUc4krrIKUkHmsElskowb/CcWk3Am0kULSvR+YTnrgp6jPc00CKDSTHOuDyr0vpAyYMy2tgLuEPIDclsssABsmwSuCmyP9YAeLr1KaeEm+ZT8TijCJlan2hI+d4wGOy5eUMdTSaDdaOUW2DhhJ+vZsgj6yYclVdO7RhZEkzpIJZeL0S/RDHAzJOGvaCwJ4AmlZ6Rr06WT+MdS1IsEKDAYKkyh0/z9rVO1NaX5RXAv9daWRWvm50TuZAsdrZgnrPGrllocnx/oh94UOnSmKLwAICbC9fLUB4X7BtsHR08eJAlk+wnmx49vJFzwA5g3MCVwvARQG+VtSJ6G3O3MJNlIHf3tCn2gJz/EoQoEK6Ig4ZSCAOPhOiZbpxZ5cnn7noaiWKOihUeGS/g7YqM+OC8EXcFUn0q+Xp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2prxwGzuWhxz9wltxb9ruld9hBgXx1FQE0PmfSwRsqqTTKcpwx/l/CQiztxy?=
 =?us-ascii?Q?/u5IDZ8r6sBMDo/o3jvbmOw4CwM9pRNYFs3M7M17aadUDTu5Yvsx9z7Z9T2B?=
 =?us-ascii?Q?fbRq5Ah4lqg2ujfZAevvvsJpMIHJUckSInaF21QqZB8ZVPP2IWgXWTi8/stj?=
 =?us-ascii?Q?kutJ8ti0JaqHvGif0j0zpITbY1SI4AW/KZPGeAZOm0Oh3WjJ3pMZm5/l+Dib?=
 =?us-ascii?Q?NJuvcXtviFgfatqt0SJddeF3cg4mWsYO+aavBlNuwOT3PGyMS67BeCM2/d4b?=
 =?us-ascii?Q?r17+sjJ6/hS8HVGolGjKsF5V5NQ0hROIGWVfh6BuBDeRuUbfE4y+EB/74YqP?=
 =?us-ascii?Q?SWv3nH0xg32FqSGAuKPKbP686lCkiHjmgsdcW/p2F2Y5J7/OKO6dLe/qTGlU?=
 =?us-ascii?Q?DWct9NPZRt6hy1LYd4p1eKRs5UJbEq+zEsyMh7nRco0cTZjKXtu7LHeB1Ysi?=
 =?us-ascii?Q?VGigxuxETqLjC1jXUjwasnDIoxSocWkeEfmp2W3yAuoU4tHqM8ye7t7LERRa?=
 =?us-ascii?Q?C5e+xKrsGuHKhML5CJN0q4g8ycfHJGc9jsPcY9b8ZTiv3mQPyG7UKuxIrkuC?=
 =?us-ascii?Q?aXdPOD9iqnTxf7B2gRVStDLEN3SBzHoxS+P4yXMpiiLhhG6keV6776I58AA6?=
 =?us-ascii?Q?7bzDUR/BzfG7baOkcBT0s4zynkd0BQqGhSuBRoMo8RaoBgUwPLCC6nankVcg?=
 =?us-ascii?Q?C0wkMFPKH51MTh5XRmyl/22SxwBXyKSAlKwztE3Txd2wAQoBKmLXcX75vBWO?=
 =?us-ascii?Q?bCvqV+uiBmQHZYCmYjf2PddbeX+X1EC4Wn/otYZtm/EnWI4PIXoBCkeuU6IZ?=
 =?us-ascii?Q?HOYRx9RvLE9qGl5qXFXnuCSVo9hfU4A4wjEyXm/OzD86ympHtOHAIcyIjHqu?=
 =?us-ascii?Q?gRQBpo3pSI7Sgj6Z4TVPlbEtmQJJy8Ig8deBUmkw/KLODeMUIovkL9hDhs7R?=
 =?us-ascii?Q?tF5fCeqeazjJVHFoM0R7caHZoE8yhTdkatDRescFM4BkjgWQMxuv6SLyYpd+?=
 =?us-ascii?Q?0JWT7JsuAUkxhiI7kIvZxOBLxkc0WpcI3CKFnxiu0DonHDnBE8BRHXE8NkTc?=
 =?us-ascii?Q?K4ERQ3t5kzAHy7eguY932xV3kuwjhShM0ggXWsf73agVq10ohmVDDloHDyS4?=
 =?us-ascii?Q?Kcb4uCgS93oG0+A9kW9Mr/K1BdJj5jJKob85zB9ZEwvekOKD1S3ghTUQ6BHB?=
 =?us-ascii?Q?71Wyqpk1wqhIKoim6NNRBxOn4hvVF40VUKp0180sqpxKRKMCqXVq0OX7TSM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ede76-c4a8-427e-0af9-08dc233871ed
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:14:12.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1224

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

 .../networking/device_drivers/wwan/t7xx.rst   |  42 ++++++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 ++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  10 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 100 ++++++++++++-
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
 16 files changed, 547 insertions(+), 89 deletions(-)

-- 
2.34.1


