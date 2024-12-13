Return-Path: <netdev+bounces-151627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87879F0507
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 07:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D987F164605
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E218D621;
	Fri, 13 Dec 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="mjSylSkd"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023105.outbound.protection.outlook.com [40.107.44.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA218F2DD;
	Fri, 13 Dec 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072481; cv=fail; b=fksEGA1Jirbx30yhWIkAAMFX7Ri+g76N/RoCCwQtN+091h4sN5IuY2PTeDbLnzqdczeowaea6Rn5XeYrvKuLEtHjaEq4H7/mCwBMZHocIibOJwnici9iBsCNkbK1FXirX0043Mjo22RJ/Pp32QYZ6HCo20W4V3e993DyJf7tJI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072481; c=relaxed/simple;
	bh=i3uuwM8uZtPpEfNjuQI5Eaep744uRXrLXmGLsdjcfRI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zshe3Sd8UL4+WIbeH7c4T3h5437xBPntWMMDu/p3erAKbfdzha6ROEcSzesjTnv3ib553rTrBjWG5rw0VDgBzRUira4U5mDo/sHYoVUzmtE4gsWrp3bwnPJWp1gJX0eKOPsigVQlAjuAMHDoSePjGDhNqMrjBfqvoimNm+ask0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=mjSylSkd; arc=fail smtp.client-ip=40.107.44.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knVRDr/XavlFjasymwmSqOjy9Es/eKjw1qBA0MkLtTAxDrYI6t4gF+8+NTlAp5WWGBoGRGWxFJ2NZbcU6vEJQEpg6RUbnx3odai8JVSfJmx8zHCpX91lQR7DICz5Y/Gfz3ocpW9htWDgP+EqkV6tiv81Y7jHDwlLlbnKZWpB+Qt2Cr2BR0loYbgBm9rdnUcaNL2dbDv8d4vVYv/CV5lKhKPmRYDae9bQmk6tqOC44+RbYHgJS9ZFLFSpyI4FwE/BDMExls3Hg+JoB0RDejf5Q/3izy4I66Tr+9pIm4m0HDQ1wJmVVCT3u1mUM3VBMJa7wij39GY+6GZKuhL+dLjBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+skzNz6Btvb7D8VparQSNjLaWWiBQRZ39toxKxtipw=;
 b=Mey+13i/o3x7TqnIPA6+7P/BvzFUCMkGfRmeFwg+qMiMmOnIs2myAvYOFUXpYoLHotaWxOGWW+1Bs8b4vL71XdTVGQ22yg7Xb8rM9jhwn3owP0SvdQzaiHIfaTa9UeweokqbZ6RlMnvqAi28xFU657mj2/z+YXZmsY6sSjVbh/FyU7wOW3oqxlP7RcbBOYtNUm7q0MTekEZV0qBL7tEhtZY2ewTUikc8E5QItdQ18Win/kzwuzErTQ+S8nGDYBgmwL9YNTxepHwidzl6+iKEpZ+GViktx9itAzNDrMjboA4j7J23asdgVRV0B9lP7cWVvURzry58KjrgRy2mSoXOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+skzNz6Btvb7D8VparQSNjLaWWiBQRZ39toxKxtipw=;
 b=mjSylSkd8A4OuFnHYxQcejuID3si56WGBXO+lQFQhaIqfVALqUAZDMEZxYF71FhZNsFOVsu6MIa9R10TG8ZGuJdLuZ6yD2z1rR/5Z5vd85M8EexxmyDEDQO5ZiMwQDFLX5Vf3yqwmpYYYe73kDlHJuBRhxEtq7eslXkAYOZk3UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB6987.apcprd02.prod.outlook.com (2603:1096:101:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 06:47:52 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 06:47:51 +0000
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
Subject: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
Date: Fri, 13 Dec 2024 14:47:20 +0800
Message-Id: <20241213064720.122615-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccf319b-9ea2-4ede-0e8b-08dd1b421056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v+97HsVOdXWtGUxLaExDXfVDHjsxf8k7reIa+TCdNCff1HBNe4AqcQmiBnf+?=
 =?us-ascii?Q?5QyHJfVYvrOPmJih7zg9EozNOu36vqk9kCAYRpPr8hGuflBWl2+usrFm2aZp?=
 =?us-ascii?Q?urdrkjhrWX0yByNGc8kfeN1fYDWVISo277LRbj8LFuz8RalwEskhW0BI+TzY?=
 =?us-ascii?Q?UVCryptDuyRIPsf7SckaBv9S7sFu885Bc4vqzshpnlnD68Kjf7r5Cp6ywO3D?=
 =?us-ascii?Q?eKYPBsPJzHv2ZlHtdTjnK78vhG0HPXMGi4NJID/M6N73iq2lAsnod+d5JpLN?=
 =?us-ascii?Q?Dh3KeDOViwbGflpU3dUxdPIsM7Rw/jDtP8jgTApC/pK1XCxHjJSw4hBsaIDK?=
 =?us-ascii?Q?SgiT0Dt8t3PLeCO+dXbiDgfd6E9i3FIcTNiZ1ohhZcnRkOYEmRdY3L/s5wAq?=
 =?us-ascii?Q?MM8q9+/NrMyTzAfj3MzF6rTf34DXguq08tJ7Ggo5G41Qq5RwxPgPEKOSzxSA?=
 =?us-ascii?Q?R2Kw0e7Baw8PJyuUBStTSIiJLeOyPhwWaDj7dA9HEsftfpXyqpx/jeyyRM8j?=
 =?us-ascii?Q?SC9j9yRQe9XtakhxTETH+GaI6rFnEDRNJifLAQX1Pyzore8SQjNarTb/d8i2?=
 =?us-ascii?Q?ChLth8Dx7mUv+ElZ8BTc++zUrPOs79L0AOMNiO1NQ+ROEx8/+BMsOS6wxph3?=
 =?us-ascii?Q?gfHVvpqdDSaGte7WE/sIda7xdgYX9hag1i+XlrsoBk/azv5hWk1+7Ds00ey+?=
 =?us-ascii?Q?R++18k2oPmmlFMBi5khiyPQDrFQ9bHaG9Q5uENEKAwWZyABPIqyr2YDd2NW8?=
 =?us-ascii?Q?4s5EiQWWw+vjkxoqF6N2i5AQWzmqUxLRmElmEcqtkMPVxYRublA9Uy5swlKh?=
 =?us-ascii?Q?8/LDN2/skzgQd4qBP/7iDAuTarzGWlZEandziTaEs3cc4j52zJuGGRd46vpF?=
 =?us-ascii?Q?6BL6Oda9PMr1ljE4aefik+/8u8BB6mCnkYrcvf0tXr3VUNK8TdkogOI+/jpz?=
 =?us-ascii?Q?snkwz5eGH1A5fqpNC/Hx9skMhng8nmstCsq5RIZn6vITT7AJa9ryTLfoVfLb?=
 =?us-ascii?Q?oXBkH/GrzrPURxucStaqxCXyo775QQU9JkZ8LDbVyyftgMlm4Ti+Qe27ddq8?=
 =?us-ascii?Q?qVGobGA3kthBuc/kHJBd0SG4JtVru1EfbxGRyvTo9J6hiCXcmlRGPRAcKisl?=
 =?us-ascii?Q?Xy8Cg0HySICeGOV7m2BBaPxGLlzErkUrbbghP/3Jd23atNNThQca67qiwo1t?=
 =?us-ascii?Q?/P0FwyTPheZ7KgyJOL8qmeFTwVCyCrG0P6CTqU13asAQTaKPvZxG/9PJCdCJ?=
 =?us-ascii?Q?hYqEtojSpAFcVE7a0KXa/REvIrmTy4y6CTCcC6jH8WqKdmYiTXgdFjc4DVNZ?=
 =?us-ascii?Q?YUE3oXiKlHPfuZxPBGKDdYGULuZmHvQAO16b47rd2dPkatahblvVPOqOqtw8?=
 =?us-ascii?Q?dkDt2mu67K+1XHU6gjRTgYPzmf+3o8v3YXE52gXNE783CgldNXVoDZ/VGkws?=
 =?us-ascii?Q?VgI2mb6GfMMkYsXQw7cCf+66ILmenabS/WMUbPhcZYUKD0WVhNlTUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?51rQUquBPJx+DqL+hWWRIu3ewcyju21QeZCWuwqY6gs26/E1y0Y/ALA3O5/H?=
 =?us-ascii?Q?oW5ZYvXDYgZaYVVa0Ae1/5kJehUEEoNWdZgC0eW2VhoHH/3sQGHhQjrjDsH5?=
 =?us-ascii?Q?uQ+nsrokSeDrO1A9/lxV/ctj+2xJahi3nGBkQwylWuINTSnOi7jmJPROoFHL?=
 =?us-ascii?Q?K2mx0NAE59OU5YfkBjZNL+ggoR80wFNRBqwv8Y35kfqJQFZ4o12BOwClvjuu?=
 =?us-ascii?Q?gOcK1ucsSp3v8ZF7ih9cGq1+IVmFzciZjE2h32iciNIpoLd4MyC4BVF1orMe?=
 =?us-ascii?Q?+/M5nZilhwGptKGaNTfbwruGr21mBaTaLZt7p51DfITwW91vCzIwA/fpaJWo?=
 =?us-ascii?Q?pilRJD7LH5pX8H5t6f3jW+PBOJbUuKITIl9XRa+UTfrUnnD7B/MWExZisv+7?=
 =?us-ascii?Q?KpGodT5LyAdn5Nur4A/AOvskd5zfiBTNmfNfkR+4UEujkAwRExD2r21Pv+C8?=
 =?us-ascii?Q?pDHmyIXNZs2hmNVA138cDlyM8OzAkHZlQEA8aUWbeQLReOBe5cDqSrcMEesp?=
 =?us-ascii?Q?LmQSvYsGiQUCPzfMiG6RROZAhKhJZMslkSgXeEUnY0HpoaosKlB+RKQ0gH2S?=
 =?us-ascii?Q?sosbkoGlpkSeQH9qSUX0nJO2Pk1QT4qljfTqlWlu4/gFumm8WPCiHJ4aag/k?=
 =?us-ascii?Q?SJ+FsvfdgkPEPCE1xAbRzUgOTeSUp6mC5NiPsghv6DVsi4vJVfIFGnW4iaNu?=
 =?us-ascii?Q?V5GpqdtaDRFjBlGrmkMQ3NmSznQLINP1KpMW2003ED4z9Boe7F2y5r2Sff4T?=
 =?us-ascii?Q?DDkZaJV7HEsHXP89ZR7REj3V7Nk8n2nsXpzGSiX4HkHleKkc6HHoQ0Z+LDHy?=
 =?us-ascii?Q?s6qNgN7R0qk05e0VKkBPE+ySservvh0bu+svTDSCfVaHKLVzOzb2lpIoOipQ?=
 =?us-ascii?Q?L0gM+5xC+z6nFEfjM3rX575rhSLkvAGRAUyy0638AlDrd7C07YXzZlwsPtyP?=
 =?us-ascii?Q?O6py9q5mWg4ZKUUPVqA397z+Z0reVavRcM+LDrjKS8oFaH7DMJZSClI5dAdb?=
 =?us-ascii?Q?azA4eqRI2AmgLdq1yzkff/GBUdjGONERFe02i5SOHJH0WlATSae4xxzCdUeK?=
 =?us-ascii?Q?gm0JxfvGNj2UYg+rI9KqqjYlupujmcPPCmILQBF1s7zG01af7p0tCrJzSCvl?=
 =?us-ascii?Q?/SbhWZxbXYlg1hGbHc3zREurSvD4kYW4WgSFSnsOJi1EiqW1caSy8rBXz3+T?=
 =?us-ascii?Q?KbZJPgA4aZgfA7QzI1Qc08qCXG3mSKa/T4bdUyiWZc8IaIEx8CswZLQROmqH?=
 =?us-ascii?Q?YyPXaRqmV5qQeWKa+tJMc0ohU9mItr+JbayLvTvTt48qiMdHLr1jIAUkQRY/?=
 =?us-ascii?Q?Y2adqyd3txRkbBNgN/mqn/tnPX24ukr7kHdLv//MBOcNsFn0gMH2sLQMpYCN?=
 =?us-ascii?Q?7IiE2QTCo6U1EMBJOhXSIEj2m0Ma+zl8ZFcCPNlb/t20iUHXj9K906N8MKDy?=
 =?us-ascii?Q?FJAFeUDzKkhBapnCP6gH/u2q0h9SUMmrMW2cZy4IqF1y8gJ3GdAAZ8qXUlZx?=
 =?us-ascii?Q?TZaqdu70Zb4e91RCc/HnYbPtXQCoK2wBfW9eBnFRJCFf29fAvM7FGgmWJKrg?=
 =?us-ascii?Q?sxdLFjArX+L5IyinBG4ZI9WPRNs4NPPCy674Bt2+VYA4ZxbyxOZBzltgBqVF?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf319b-9ea2-4ede-0e8b-08dd1b421056
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:47:51.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5RCbCU7Bo8T1jfWO9bsRAHCciuapyjGqgZ1DaNa0XjHnsgqiRaGx0DtNdxZdsS8N8bcBdIHt5TpqNLZXFcbGwEYh+PSRYdVZWFcPhzIT+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6987

When driver processes the internal state change command, it use an
asynchronous thread to process the command operation. If the main
thread detects that the task has timed out, the asynchronous thread
will panic when executing the completion notification because the
main thread completion object has been released.

BUG: unable to handle page fault for address: fffffffffffffff8
PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:complete_all+0x3e/0xa0
[...]
Call Trace:
 <TASK>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x379/0x3e0
 ? exc_page_fault+0x69/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? complete_all+0x3e/0xa0
 fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
 ? __pfx_autoremove_wake_function+0x10/0x10
 kthread+0xd8/0x110
 ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x38/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
[...]
CR2: fffffffffffffff8
---[ end trace 0000000000000000 ]---

After the main thread determines that the task has timed out, mark
the completion invalid, and add judgment in the asynchronous task.

Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")
Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 3931c7a13f5a..57f1a7730fff 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -108,7 +108,8 @@ static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 {
 	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
 		*cmd->ret = result;
-		complete_all(cmd->done);
+		if (cmd->done)
+			complete_all(cmd->done);
 	}
 
 	kfree(cmd);
@@ -503,8 +504,10 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 
 		wait_ret = wait_for_completion_timeout(&done,
 						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
-		if (!wait_ret)
+		if (!wait_ret) {
+			cmd->done = NULL;
 			return -ETIMEDOUT;
+		}
 
 		return ret;
 	}
-- 
2.34.1


