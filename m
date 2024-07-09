Return-Path: <netdev+bounces-110091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF9092AF0D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703831C21C70
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169312E1E9;
	Tue,  9 Jul 2024 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="cvc2IFn9"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AF13213A;
	Tue,  9 Jul 2024 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499064; cv=fail; b=c7DGCrYjN7nqu8i/tDU8VCUA6EmgQTKZhD8VI65IqKhljqIp5gF3QkvmvVq04fGg0skhcSfpjPWZ/wTBgeSxOLdDvc4pyRVHOlWY7ZVWbK+U9HAR+MJdK82JJQlCDxASUoeQi/WGet0A/QT0KU0MEZ5E6G2/pDvGmAncoUjfdCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499064; c=relaxed/simple;
	bh=Qah8FHvSq0LnTKCgpkFPjQVpM4D/ftm1mv9WnUc0D8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPSK4+bISuyGmILzjVznVzQGTjzVspRbFRL+ARTzekTM3487cYS1uHaXJqQluaox+ciBVgJHHIuvhGvAtBu6/ocnvmlEK3jq/mlCpFRVu+URZhxjYA0yY6c2Kr9jT5GOORKHAXHK6Nqc9ERjiFqU+8E1YVeXYZ80AnLwJde9HbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=cvc2IFn9; arc=fail smtp.client-ip=40.107.215.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRqD7y+tnssf0Qq5gApl3Y05eYhL26RovjmMKhTWVVtzhhRiikGsGQUg7MaljaRGV+YLYllVsYvAVueVREQ0dGf8TZ7gLs9JUU91mLg5CVQXEoOdGLRjUoUB9/1JascGRCSSPlsJnzd+XRyEdkeOzx5UKCf2neBpP3GoT1to+n307EXQXxgn33fRSVUpehyuN3+TprF24C1LgTeQ6eq5PbvgyikokG7Qhj9jvPfSJTmOAPJsNyb8jWrBfE7s/yiLyMsGuSsLBilsjWphRoSCUCIbe3NE3awkec4y6SLbTYE0mbn9uwd7SWX/Iq20E+lzNIg91SXDj5iS22A3whRudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM4ghNnLfT2Pu1S8Hc1PEiCzZ3UXxq4X+bpBVjXUqYM=;
 b=EtzaSviSq/L7WVnIV8Sb4An9KzmSxWWEv50DEpZ3Ym2LfVAjmV93ilSK57RiAxysya2DGIK0p/GtTK4e03dOe+X30Tgsr9SA+y9WD8mQ/Gp3VcL84Gg4UmdOL1dOQkFO1hXUI3s7gWoGQS+G1cfcQlMPamqOOoB3gup47u88AtbSe/eAwcT9YiiIRSb9g+BF3hfb1doMidTXHv8joG1r3oUXSbCn5A5uCPN9h1XtJlMResm2t6z2AsSUFhMEsWSCqt2geE9L0kttpp09XLtX349k0SqcHOapkJFSUYLjdosouMN9HhHBSCRtjKhSFjZ8Melrq0ezUsuyC3Iufih+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM4ghNnLfT2Pu1S8Hc1PEiCzZ3UXxq4X+bpBVjXUqYM=;
 b=cvc2IFn9YVewCWU9Sbzw4XnT9Ky/JLw0E+PUfl6YG9NEoeEDE0wOH84fGqjJjuU1K2qhTJr2p63jiFIzXzAoYfmesxGYjrp1s1N3UkJy4N5gdfltBD67OeQ/UmeCmigYItdWudWYeEzE65op8NwDbkTXUVmUIdZ0bSTQh7VsEpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB7365.apcprd02.prod.outlook.com (2603:1096:101:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 04:24:18 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:24:18 +0000
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
Subject: [net-next v4 RESEND 2/2] net: wwan: t7xx: Add debug port
Date: Tue,  9 Jul 2024 12:23:41 +0800
Message-Id: <20240709042341.23180-3-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709042341.23180-1-jinjian.song@fibocom.com>
References: <20240709042341.23180-1-jinjian.song@fibocom.com>
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
X-MS-Office365-Filtering-Correlation-Id: 88c0fb10-fbaf-40ef-06f8-08dc9fceff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XO/7KvBh3F6t621CY9yaJA1sdEcJ//HZT/3kmYwH81x5c4EjLddLaIhF/O5?=
 =?us-ascii?Q?5ur06aoeieaFhnwz4v5TV08Thyr9837oX0aF2qwlT0mRbWTPeXOboTrOlORf?=
 =?us-ascii?Q?TWnrT/WVuqEW2aHrLUQ7rKTScilzQryIRQfeFvmh9rnOA3Oi3bGdeTSegG6+?=
 =?us-ascii?Q?XIYck+uSwJJdkWNWSJFM3n02gf5C5EWdhWmtZUwmI4xFUiWUXaH/sgvp/VVA?=
 =?us-ascii?Q?fRcScNdD93WhZwDywX8cICDrlRaOjZNQxTynVEflFboqTgyh+WZ5uIhVnQh+?=
 =?us-ascii?Q?qpUBjkfYI7Kg+69L2uHWJdUkNtV0x1EJBUQoNCPZ0nhHwiLsDq2+W1yf5L3n?=
 =?us-ascii?Q?7LdzUH++q+/EupAaPXZzSw02PZ39Tjz+0LLDJu6AYcDITeZtx1V7jTjjZwKe?=
 =?us-ascii?Q?7Ky1rxvmOVQ8jBJG3LrZsQi5jiAF3GiUd0tAaeYw4kVW+TKZbFcBEmTmwXel?=
 =?us-ascii?Q?iGu5mEmTbT7JToMFhUB1M00gQoTt5NRzUDjg+TqX9k8KBFu/FpvoPddFF5i3?=
 =?us-ascii?Q?iN3JPnFJ4bh3OjbCrLnU9ceAvz2MrhyLstZVhD5CHOehNcnZ8etFiVzApKJF?=
 =?us-ascii?Q?H+ICx8cmsMrH51E9nlUCwoUiJoZXooQoNrUaT0P2M6VXUvAZ3NEHLL7nGboG?=
 =?us-ascii?Q?m182exPe3kmwBlW4KFIgr0IfZjhOP4zeKRfuSBq3Ozr4tCGF/wksUaheIfR9?=
 =?us-ascii?Q?uEW4V/iri+f7SCun11hFhpKb9bKDAS8m0V48NATEUSFGuXKI1o7xRMIwOZ8M?=
 =?us-ascii?Q?FfNlr4ZxevdGbo7ULo2MOga3obKOHLezSZcslXIMwCoerlvTmfsSLL2ZlrM4?=
 =?us-ascii?Q?YgGg56Tk8xauDgv7EQOdxM6gJQh+w/iqhFaSxGfig1U035TYqkoAAP8tjZCe?=
 =?us-ascii?Q?IAnsrnORW8VWp1a90Y+v7RbKznFsD2dCeWAZOJ/C/Kq3Y1FY0Mj6zvgkEMlw?=
 =?us-ascii?Q?NIbeIEBoxA0UzbayFYmIpnEBukw0r2KKBMLNbGWuh8mJtMmQZzPd5+zLscLA?=
 =?us-ascii?Q?+mJVcCP5VpqZrE5+B+IhtVtuUh3XakERcBUQp736CjdT9MwjNbYIYYSK6EuI?=
 =?us-ascii?Q?AgUjtrVuRpk37dSuIoRW0bgeavu2eKNElpihzL5J52pMpf1Nn2OoWGHPc/AQ?=
 =?us-ascii?Q?OpujoOB/yxWaEqf6gSLSkTydTlqIZXp0Ei/lbbwEbHuGKHHYfOT/PiyTCVDS?=
 =?us-ascii?Q?iEprGoMd4RdMuGkLZbxJIa4GqPUkK7XdMrpX6f4iv3bK7uD1rpjZNuvzJVXJ?=
 =?us-ascii?Q?w5QrZfbp264UUhJN7VmKptMcBe3LLpISE/m62lpNTxwCibEDEP1Q//+JUd46?=
 =?us-ascii?Q?lpiqdcbJVZ22PXVu7iG5q0vLGFVarppgSZ17d48ZIGKIikW7yXWgVwcWFLr6?=
 =?us-ascii?Q?JGVIlUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCnXBVY+EOzWWrlXaOGcwPl6PGe9HYHYA+LWAkiw0KigqCpbxpVKTq9/wm1G?=
 =?us-ascii?Q?OVtnnhN717H1Pf3wQ1PxUzw9Dw3qFqjlsI/0zfL3U7+/MgVD3sN3Qrn5LRZi?=
 =?us-ascii?Q?FB7McKeNsMtUV79fR5sXMGvrYcqTR0zO0+wEGDqi3eN1ost89jfaCk3s2lR+?=
 =?us-ascii?Q?0O3WVsZjkkbL+t7e7MmWLPyFqE/HcLVLbH1ImOefT3IoxcrgIxbZCWdDDAJq?=
 =?us-ascii?Q?mhIUiGoNLFWRsxP69L1eCBIQ3XYOAR9ixmWYkfZFOPGGpmpaOh5XNbS3uGPD?=
 =?us-ascii?Q?RC19b2cwns+AFJp7rlnPU6UHVvKrnf6JFhSmMRRbV6stFVbEzQ58M956FRjP?=
 =?us-ascii?Q?xNWr/5Qd+yq/a7v+YlwHIaZ2z0+h6EKZoe/f+2w994uswHIGWSIvRAFNJf7z?=
 =?us-ascii?Q?bR1wtQmDTkhCevJZYIiLHUWT74DJeiFaM6oDUWu4KMMGDg8IFtqbBlFGRw7d?=
 =?us-ascii?Q?DVi+gtw8d2YVF2kUpNCJdnaJ59NGfeIQwvBVWxm3GyX8n8ZpGryxyMSq1WsA?=
 =?us-ascii?Q?366uw8xxlgBlrQ2eyTW65PCZcY99PyPzMjUtKKsrfQqZSZrGOnIojVgWlXt9?=
 =?us-ascii?Q?2LidRP6J+jSso0JJFCYFd0skQLg8teRTGmIDrOekxg0TgMxgK+ifBbwFMxXy?=
 =?us-ascii?Q?2f217dKJnp+knCIuAOuwfiXdxk0xFxll+f69tBdWJD5tBwV8SFd7T6xasldD?=
 =?us-ascii?Q?IQBfugOUPNsUxqcBpBT9dbawyMr9suxxc5klQZfZgwzbt9wO05Bf14raE5hv?=
 =?us-ascii?Q?1OE1OyrX2SUAj3ESk4L0hjnAnjQI51X16WhEZU+mShAdKZKYK8UzfB12+y2w?=
 =?us-ascii?Q?qmj04UzEJOS8fGUrZmwSlGNe6LzwdfYy3FWr/OpSmJyChZKYG9hblzujKCKo?=
 =?us-ascii?Q?Jxv/tZPKzBkAuo2YFNZtBQeclUFWbwkoHFexqVuX95D6WBLBMUAqNn6OxMBN?=
 =?us-ascii?Q?OBWJMUpJM8xw5xwKCWpjdtQ1o7fbunmblsm8/mQPX3aauGW9kpkGnWF/ULxW?=
 =?us-ascii?Q?852UbzHx1sE82HqoPp0MnMC1LIBKggaZSCzzkbSdKaFYvl3Jil9cwU/ItjPY?=
 =?us-ascii?Q?hBhLwoCK2N5kA0wttOUEY/2T5Tbq8OTYVnX2TeI4s4+Jbxw/23G1LIryZq9d?=
 =?us-ascii?Q?vxQK1dDHYW9KUYfsyB111b1qnRfqxHkP4w/FpSs/Wm2RWWV8nF+d7+pdfV2d?=
 =?us-ascii?Q?H6EInBlZtoLmswmmnd++TIedAbaNW76NzxopteaajdVyJU5I3rljRAid/grY?=
 =?us-ascii?Q?UMKzww/xFGBaW8Y2Hf8JuD6u+tYkwwHdUA03Ig5+PJzZpI12mCTrxP7mX92T?=
 =?us-ascii?Q?QteHqsbCUlKmMDErJxqprw0FKVkkL1zjrvhc4jtqyu+7+DdKZvoLcVYiPhoJ?=
 =?us-ascii?Q?OJOxTkoyZkiJrzARBZfmffyX+TAlS27JS5Gek9O5qZDuinTwt+izneEvMfvG?=
 =?us-ascii?Q?gxXJ9T6JH5ZraAyWh+ZskMEjGUWx/+WD+zo43S5efgIGmyzar0+xNH++ga1I?=
 =?us-ascii?Q?nFvsvdYdsSx5z13uBxK1x1wDJ4cnbwIBvG/X/JZqYVuerIgvQYB/RTRM7SpR?=
 =?us-ascii?Q?r+GplnYh9ZlXPZbP4Di3feOH+OB79iblXCfsRSqaza3rmc+a9P+IaCGiwKbU?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c0fb10-fbaf-40ef-06f8-08dc9fceff5e
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:24:18.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM0tLOnF9A/jDHOy1+dsVG/P+J42ypRLZVU08BVYTS1bm6hRWQV5B5sDcV63LznzRNs1gKYCpWiJHFKwOYAod19o03+GkzeegIJLvvMwVfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7365

Add support for userspace to switch on the debug port(ADB,MIPC).
 - ADB port: /dev/wwan0adb0
 - MIPC port: /dev/wwan0mipc0

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.
E.g., ADB commands:
 - A_OPEN: OPEN(local-id, 0, "destination")
 - A_WRTE: WRITE(local-id, remote-id, "data")
 - A_OKEY: READY(local-id, remote-id, "")
 - A_CLSE: CLOSE(local-id, remote-id, "")

Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

By default, debug ports are not exposed, so using the command
to enable or disable debug ports.

Switch on debug port:
 - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_port_mode

Switch off debug port:
 - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_port_mode

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * modify commit message t7xx_mode to t7xx_port_mode
v3:
 * add sysfs interface t7xx_port_mode
 * delete spin_lock_init in t7xx_proxy_port_debug()
 * modify document t7xx.rst
v2:
 * add WWAN ADB and MIPC port
---
 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 7 files changed, 167 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index f346f5f85f15..02c8a47c2328 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -67,6 +67,28 @@ Write from userspace to set the device mode.
 ::
   $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
 
+t7xx_port_mode
+--------------
+The sysfs interface provides userspace with access to the port mode, this interface
+supports read and write operations.
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
@@ -139,6 +161,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
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
@@ -164,3 +205,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [5] *fastboot "a mechanism for communicating with bootloaders"*
 
 - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
+
+[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices and
+emulators instances connected to or running on a given host developer machine with
+ADB protocol"*
+
+- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..b15c470acd3c 100644
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
@@ -109,13 +116,61 @@ static ssize_t t7xx_mode_show(struct device *dev,
 
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
@@ -806,7 +861,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
-				 &t7xx_mode_attribute_group);
+				 &t7xx_attribute_group);
 	if (ret)
 		goto err_md_exit;
 
@@ -822,7 +877,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_group:
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 
 err_md_exit:
 	t7xx_md_exit(t7xx_dev);
@@ -837,7 +892,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	t7xx_dev = pci_get_drvdata(pdev);
 
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..973d0f1f8f9a 100644
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
index 7d6388bf1d7c..4891070ad9b1 100644
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


