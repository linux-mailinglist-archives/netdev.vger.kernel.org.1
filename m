Return-Path: <netdev+bounces-110089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C111892AF08
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BCC1C22015
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF09D12CDBA;
	Tue,  9 Jul 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="dVpPKi3o"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8912C801;
	Tue,  9 Jul 2024 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499051; cv=fail; b=B6Srh8DvMPPKj4VgoFkxTUmRp1To2iJj6xGMxtPnHiHraejNAEyVCSd9QwltTUKf/kyJYcAJdzSi6Bii/e3Oc+1WDRHWMihDEUtDcMTPwWqO9GffYPnxUq31jaNS0SazRMabbc2d0WWUXY21tPRdrucoDTe8RK0X5LxSrAs3ELA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499051; c=relaxed/simple;
	bh=kJn+7gzy9ComQLF2+WpdP8yI8lkPqhHN4/AW9GVE6Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PN8FkEdlvTUA0C7/BL6twlX69tjzohomVwR4xyEXKh2x7BDdJEd4uDwk/+WH816U2qnVJT63fR0Y74HrW7TgclNiKlgtTZEne+E/ZIQJf6pUD8Y9rTOzrP4h4hKt1LRjCNWz3pw8ZLfBGb1VmpRgsILhSZ5FzF932dc3PNDUFyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=dVpPKi3o; arc=fail smtp.client-ip=40.107.215.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7qizMkdPpv799yRm7W+mFS7evQSE/8ZiP6d5Dk7jLXkVmTs15gySOnJHV68M+jROKEazYHOJ06I64IPJ94Xh3scUb2g4SaxeHPWPqU3ivpW/LEEKBpPWKiz8LXICM0xEdCvwG84aFjoDhbch59HhWEFva2HyHthBc++F5x1Cg11Ye0sHlppyYQKMc/SxK8pyNVPhWV/NVRaEWyQ/SjwtZRbVVwfhIsqv7O3cx4bU4LSHNMq/fQG/P2YQ1mUf+E27PK015CbFBvCTaD82Sh32U+MR6DYMfeFvuMLgmBRVpd7L1uxKxVrOCerGu7m0MwrfbZGIFy4wxBK1hzcm3YRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=EwiTKGW5g3W6fgP86XDyWlU1Nhb21IHzqm5DHdeFewnDSxc9HYeZJPTTgg3oMQnLsxKdtrEJDx4kCA8WUp//eBLygW7SAdBUe45JTH4w/kBZ/3cO6dIlxWYQHDuLS3fu4gBbbhveCXjzUcFXtsF/2trm5c9NL9tZi7hMgjgyMYxOVoE4T3T/QAB4LubQGg2HOUbgf87eIGGbaxa5KMiU4VeYE6hxe2uAlOyLsUxb7P+ZxaeGQSo9gx3v7MsnS7Q5HouL903NhqgCzjGlwKhYsHb0+c501GZxnARLx3Y2Wf56r0cl57twZHd1ChreVS/VnxOjdPQzQ3rg5C7DyIyYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=dVpPKi3oiybIbVPOw76WY3J0QjZUttLBtiEDvIHM/g3VA6Kex52aUMpzMWDpifL2B6xQnCN6AbzheztAIQCZJrLB7YO4Rq0+Ir17bCRWbrFwo8VXLcAEhbLZuulDq0qPRJFPcE4kGxTqnbbu3aGEUBDDDU6nuR940+W+mmX5COw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB7365.apcprd02.prod.outlook.com (2603:1096:101:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 04:24:03 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:24:01 +0000
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
	inux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 RESEND 0/2] net: wwan: t7xx: Add t7xx debug port
Date: Tue,  9 Jul 2024 12:23:39 +0800
Message-Id: <20240709042341.23180-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e5575e-37de-4b86-d005-08dc9fcef52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?le9fhGFcZfRZnr+xEf0lN9QUmg6VBH4dI56gff96CZsnMXYY5CF4wQqz/dGt?=
 =?us-ascii?Q?7ZcYdrOQBr2VD8mtZpxlxUZHBMWyHYEFDAumEwWPsRhGQVC78D/r9Kfs4qA2?=
 =?us-ascii?Q?YIWtmqABvf1Yjj/OXQcBZt08zYWA6vvl8Lj8cCZHNHiOw41wSjS+5Sg6HIzb?=
 =?us-ascii?Q?jN5iIQ+YlMswQRj2n7HeFc7npA0/+ZuAL5MmxIbx7oVsTcwsFtDsqdEdDBPx?=
 =?us-ascii?Q?ern37dz5dF+yuhpCxFnq5NNAgZFrn96rVppe420ssgX3Qg5f7o4Uobwc6h3+?=
 =?us-ascii?Q?m42BliiHZ1oKduh330qVrGG+SBLZwev9R72f2vmX3MtEkBCEX02xjn1/9cOq?=
 =?us-ascii?Q?VzuymmujObytDWD42V8l62sOYkjaTGsWcdw9/7Gpp6GhCDQEPmUVsbrPobRp?=
 =?us-ascii?Q?J6/aQtNLQpqBh1NLlVDUSKKLxYnVU/wWrRVVhNM1FCMIMTL3TXjwChpWlh2S?=
 =?us-ascii?Q?DO/b7/dorImuL+jiNRHV4FsFz0rb1mJdmObboTwB0tC48T4ZPuoMCxk+4r72?=
 =?us-ascii?Q?bEkBDhqY6+rs36dB+Sh1kVYZuQL+gJ0kejbbIFeL8r7XjA2g+HENbdutVPrd?=
 =?us-ascii?Q?dMIgfCcAalZQPoZcb3PwH8LD6gDgZzLI70rl8O/8BGtc2mGop5sEP2ZTxUQ8?=
 =?us-ascii?Q?6tJ208veiYuu7f05tmN20Tj/nloBxeiYhZBZc+3gUJTY5CoqQQDt4ndPVK5p?=
 =?us-ascii?Q?OR3fqS8aZ8B84JKunXwH4WGXu+6lDr8R0YGQ/P+33qkVINb//7s3BLw3TfzQ?=
 =?us-ascii?Q?eTQk4ae4SM9rZ/bjdkm6tv5MGozRkRL5+EWGkrw3dSLkjJtIoIMwNYaVCFwV?=
 =?us-ascii?Q?xNooEfyMIaAoLK2LMYd68wFfmVzHJ3PFz25o12PEQMkuQqjIM9nrXqTbw/bZ?=
 =?us-ascii?Q?ajQ9jAC1a6Ykigt53TWy9kPbxS1ewoyvdRiUL0Vsa0nBVGKKhgRAKvgzVTdd?=
 =?us-ascii?Q?9mU//XqtcZzt6uiWscOGD8Y++hL6IbvzjPFBZBS+Wh749EZDDwKACV9oCYCs?=
 =?us-ascii?Q?PC+k8V8i9A9neV/M6s9LH0LzJGULVwj5JRmB40//86F/YixYAEJeBgID1uWK?=
 =?us-ascii?Q?MZ7Ax/GqCEO6Y3K+vlCnWV4kwGifcX7bbCpbW3I/wJp9bTc8tic60cvaFH3u?=
 =?us-ascii?Q?U5iSJpPIjNRUxHLAU1zU+IuzBode3cX0eZOxePssgL4vwDxU+NxlhQ/zwErN?=
 =?us-ascii?Q?GRRKgZQSrPnzKzYNCyK68uXaQagiaTpYi7yq+Z4GDXnznXfA964IVV08x2iS?=
 =?us-ascii?Q?awJMBuEaRKbZ5cSGgAZlXP8aXqAGeLG6R8FB/xM7NQwcLLH59SMXkkDEPJUz?=
 =?us-ascii?Q?Ree/9+ETKNxGiPoaerXEQySKNFzKSB15kvXkU2WJsFsY7HseqDyWDvVIeWJK?=
 =?us-ascii?Q?Ocp1bK0VeZ/r+XXk0Q2zQjR4aoDahOh6f4VctBLcCx9ix2VM4HuQXf3Jeh3n?=
 =?us-ascii?Q?w95faN/5mlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0t0H79WRg5sJqht/6VQUyEASZtYlTYpGqoHFMET1gapvKGMjDbYoKOcNhe5j?=
 =?us-ascii?Q?Ieyp6L6O3fs/QSlCFGGXNob3q2p1ePiWIoGPiMYpxvKHlJsTBnbQKBM3W6xs?=
 =?us-ascii?Q?JrSSTkL+x1JgWb1BkVF2Y9exUVf853frZtfaTliIH5WIW40lAJGMpFqrm5pQ?=
 =?us-ascii?Q?weUJgP6hIIMduL761i97Ui73LZ6d6tGxrdSS2yZc8ZvY+/RNr70piYB5eyK3?=
 =?us-ascii?Q?OAK/ktT/hXPQcIIQguAWxU9cIQXrqcLDv5U6qnffIN0sRdVY2Wa8wmwjR8d8?=
 =?us-ascii?Q?tRrE8ObnM8RdtvwHZYClwhc7gp0QRWl/37yQpgMCjS7AbgUtXJ/vJe42wFqC?=
 =?us-ascii?Q?3wVTxBeI0k15zUKJwv8GqHzGYpeLzZfozxu2Xzc5QwfYGwPc/i/WQURtfeoG?=
 =?us-ascii?Q?5pQoKSpz+am2OD5A6loPXS8OyrL8S5+D32iiR2RRv7BbFmEBNfwrwNgkaW8J?=
 =?us-ascii?Q?vtIrnrGiENiWa0ucNkDW68/bt7DMv/5Cps7tDDnttSe2bjl9igBYJLyCBe+s?=
 =?us-ascii?Q?VBnqLo79o9zFS05F/r5IUWA36is1g0oXi6FbcJlAHWWl9H/axywby4rXixTY?=
 =?us-ascii?Q?0RjCm8r4NgCyglsMVleG/8PeH3j4CbKGttHuV1/s0CcZiEye6wUz1IJs1vDl?=
 =?us-ascii?Q?TEvIWPZPjGWINnCCJEK0aQork8rMCMxzeiFnZdhppDUOyxBsMYQlrCMZtdsN?=
 =?us-ascii?Q?S2r71eaY87tztnnttzotaVqLZl24mckmXtSSxn7e7ha5Vpl1wdXuaqulkcCo?=
 =?us-ascii?Q?NZkfselc6d9V0msBB2h9uSE8fiZXK9IKOOhPWKVxfwWLkO+2yfbnqR5f2QW7?=
 =?us-ascii?Q?yMkuXwER9ruExiE+CenUxQjDcTbXaOEa/XHMnCHF8CfbqEmRQ8w+DrwxKbVl?=
 =?us-ascii?Q?7PINkHAUHv2z+u0I7/AJcttPhE06NGd73bE4WQbF9F/FE2BQbrz66rCDoR0c?=
 =?us-ascii?Q?2R0obAoij+9cvL24k500TP1lB9HhDEaNlAYXWQ9SMChQP0gCBoiVAxcj17FW?=
 =?us-ascii?Q?dfRQ9fsGzdpvaF0cCxz7NeAbpd9xdLz2YlwRG3gS+YP1B93lcHZ20xtwSvfL?=
 =?us-ascii?Q?LQCofJdXqfCvzCfSsq1IebzXhHto1m6PfPOeXdCbX8L1aQbr/5ylak6cn2Nj?=
 =?us-ascii?Q?TtBN/NwgpOAGA2nGBIh7HK3BMRhOxrWcb8beE1sqGWGOFgLMtSlGHPGUeXt4?=
 =?us-ascii?Q?lwtoQjLlLuQtw3PpktECZcA5fQobrqQpeOIGWJTGuFTD16Ot7Ygk9v2SGQ8t?=
 =?us-ascii?Q?AOZWNeoiuHnEwRpYvy9v+YwTrquqir+tIOpRNPMhbqlQtFXcm3AMFjUXtisb?=
 =?us-ascii?Q?kmtgTkci8dboUUJfLmiZBEHRV9JfKYwFxlTDxkO/W7qO1bCUBhTAD9UO+KCG?=
 =?us-ascii?Q?MjTGMtSDl9vNObGOMFIMyIsUHKObht9OuLV+1SnCdopVxGd2x7fJLV/W1sat?=
 =?us-ascii?Q?3DttJsQHZBkVS844IMQLOCRHsuH7GMsm5/EddCKqMMAcKaU/7qfK/Nqw4FtA?=
 =?us-ascii?Q?/Lb25PGB3pJpiRW/nxpZgNBssb3iKJILO2iAp/yu16CkN+j3hbWF6PH2AHOI?=
 =?us-ascii?Q?muhPE2MQT37XC1IqQl0u4DKfTMr2ybGQCybGxpoDI9RgEBrCyZtBEJcBraY4?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5575e-37de-4b86-d005-08dc9fcef52c
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:24:00.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3n05Dmj7KJ04K7grNXzcjGgJ7XGYCLGNaXyWhiyRkOICy6dZXwTigM1Ibzwbi/qSJjTTZb8h/HheT5dF/ECLgolhVQHirWZPFTuKX97o5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7365

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port.

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (2):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug port

 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 drivers/net/wwan/wwan_core.c                  |  8 +++
 include/linux/wwan.h                          |  4 ++
 9 files changed, 179 insertions(+), 10 deletions(-)

-- 
2.34.1


