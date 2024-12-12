Return-Path: <netdev+bounces-151344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF79EE48E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B58C188737A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F4211470;
	Thu, 12 Dec 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="XzK1BXow"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023134.outbound.protection.outlook.com [40.107.44.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C271F2381;
	Thu, 12 Dec 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001000; cv=fail; b=QHEQXPxuGtTFnvojNcNlngL6GJEV2hJkgEXB9ADvVZ4izzCngLLFIBooRpHirXlYCIQ9BH9zw22jdUtoTiM5zzJjpvGq+wVq60PbB+ASV3hrbi56/3O5gwLQkMjpTJxfiZb2/95cB2WcUX3ovRcKNKIUnybzgOOBpedrVX3aPoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001000; c=relaxed/simple;
	bh=tqDilTYRbugHMXJlUvWMvALGTAawvc1OYRp2g8NijMM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cbJ5vatkhYRGw0ro737woBWo914DYI6BekiikCLEYqCZR6TwAivE454H+icK9BY9VsLN2JGcG+r40XqMUG2dZO1yg2gF16UltHu+SJiBaFxnRAY0bvom/tRxhl+VwWgx55LePZjejkHGfm57z4CoPIwjndyBOW5HukX+dTEiDsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=XzK1BXow; arc=fail smtp.client-ip=40.107.44.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTaARfZHrTZ5WDwvSx7DLPzKuZ+MP5XABWsBfv2VNo/FL5HYbgJpxDOZIu3ED/s+W1M6pxQdmLTDyEqh7mv5WeJw4Zvj6VAeCh6ZzvPmHUFrY14jK79B/U9P4wIOJEnb0r6tfOlFyA9QdCi8EThQUBf2vgugkO3+IKlx2pO4ByNnL/MBntfZzZXQuk2BjorUPlwSR/yz06EnGUD4nRSoZEYBQUSsLIzbeIXZXU8CS3U1zE/hD4+oIipQ9ElURCa2jcKVNcGdAAFK2trQMWqTo4SQuctQ3SAuk+yXI21bkUxPAt8quXkI/sy24ABuoMawaNrmKap9C2Egp/TMeNOOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIeV01Z2KJOaxxslmz6iXipE9ilqHcHhEDar7RRhGbg=;
 b=LVZV0zg/VoPkerMGSERZm6L4xDio6duhHISMMbzil63W9UWQcH6/ahdvheAi57qG4ieNxO7v7JOmr+O53mJth1Yte7++k5lEHyTslKymt8Sqish+p5fdHV6y75kuMI1EcI81LAaYFSwpFmoMrGbIGO3WZqKUM5CGEamuYizI/q8byvmkUFgvar0opskhGF4pg9b5WpF0nTLJmdDAgAPF1rjQqtu9GvZ6CZb5DINX4FM2ZVhy+pf58MirH8FEXE4rtB2bIk3GpZ996lGMZ7BkQgv429SvbBPutmZfbFpoKB2MNZ2RneEgJ+Hy9kn63nDaDlRwH+xNupzGmdjI8xgpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIeV01Z2KJOaxxslmz6iXipE9ilqHcHhEDar7RRhGbg=;
 b=XzK1BXowc7daFhdvW+qMY7qtzEWYPP1csx/DKvLb77Zr//yHDVt09GypDIEta55LwMOySB2OzvqeUlbHe2n9ZvzT11XiN1TKIDSWDuxTiQee/WYB8PO93yVa6EwyQIYq3H/7nNRvitKnwBzvNOp2c1idhvsPsiLSbjfwkSU80bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TY0PR02MB7014.apcprd02.prod.outlook.com (2603:1096:405:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 10:56:31 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 10:56:31 +0000
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
Subject: [net-next v1] net: wwan: t7xx: Fix FSM command timeout issue
Date: Thu, 12 Dec 2024 18:55:55 +0800
Message-Id: <20241212105555.10364-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::9) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TY0PR02MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: f97ab6c3-b27a-4914-0b54-08dd1a9ba2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fNgnICCRJXULUt6ujbPRUZk9fszwjPnRgGxDKV0AnMDD9t1IhC4rTcIxs4G?=
 =?us-ascii?Q?iGrgE/s823Clp51kI4o7W7Xbzy5rpJJemhLuyx+RjECyLJ4yJSQsG6VJGhq3?=
 =?us-ascii?Q?3yU1gOE/WDfo4Av3jcOZcIF+8HdQfCaDcZYo0fkiC/0AP2Y/OMH4/MojyIZI?=
 =?us-ascii?Q?r86RQ1PX6srXukBTuF7u/9zOnfi74EQZHpVrpTwqpLCcigwPsihZhQQk+xoe?=
 =?us-ascii?Q?OL8NhxwhjHdLA9EkF0eGr+P2P/JAlB/yJvnqrHbLlVxLFZC16WSJIYmI7tOM?=
 =?us-ascii?Q?NMVHOOXWMvAiRAFCaFgqtNHXeEtPlsOBxYzls/95+ThOQX+sHz2emZILTBLj?=
 =?us-ascii?Q?RI2WVR82PG3cI5ZvJ9prXZvIG8X5U3s/OY1bIWI/W3nkGG3FmOxSaVDwz9OT?=
 =?us-ascii?Q?CT4Vvtq98pdCsijNV1tjR1XTBWtFZAe7sc88ZmnnTDKf0sjrEjlI4sfdja3R?=
 =?us-ascii?Q?cbtoYnBCW7I4ILeBmySo8kfPQhjIPktTMw9Lm6yCVSPombNe1JvvnYRW1dLs?=
 =?us-ascii?Q?oYABZGx+022TSsYbWiPL4lLb6rZ/g4W3vAFKkA5Z5O3003FuVE8Jc1gVm0Lx?=
 =?us-ascii?Q?uWh5FX9FdQbjpJTRcDHkv8VuIEMJ0xyuHeMsQA5ZbocWEeD/WbZOpu5ZH8P3?=
 =?us-ascii?Q?LNP5G1cvzzVr0Cn3MhdeYPkXiXiyTLLK2B8SBjrZSnbyTqzH/SE0cJOGNZpt?=
 =?us-ascii?Q?l7UhHg43Xa3wWlEZvSgRNAts1srREQWC+VrQfhEe3zfQaEOgpAk9GRgc/4Hr?=
 =?us-ascii?Q?Ajb0MIcBI1jh8Y3nMpUcyL2t+oHFVSDS9gRGxEpji2MJLBNM1mBqDC/YKQsa?=
 =?us-ascii?Q?EknRuIjcr6K4QXh+xa+W5GrIY93phg+eSs5+boe6arcBSYiDtIWDqy/5toE9?=
 =?us-ascii?Q?xQqN3C50l3yW004DxHmyqrhFs/8TR+FVoQGL6tl/fUBL4I1QmZm/7hQnSOd7?=
 =?us-ascii?Q?Wd0wEVKWIFQYwgWBuMwF/rN0rRQmyvWGNhAQwHCQ7H8LCTlKRjB9Htu9Dhut?=
 =?us-ascii?Q?R2qlkVmtIxmOH4F58KBbz2Vmtdt5B65D7G5i5GcncZUlqKqYeSi6Sj2p63oM?=
 =?us-ascii?Q?6f43RwFv7+xyozb0XCixAH6pFcrr/PvMYQnlB0eDFWCl7wQpFCUgQk4FAQU0?=
 =?us-ascii?Q?g8uLUzIGETsvFC/a8ymIvC9xUzv6FsossOsfC5xBmhLhoSeeM5BDPMAdpzDl?=
 =?us-ascii?Q?e/Nthfhm/uoyXxsA7lPf2eh5FGktyo9BI+Jy2hLFb/LP08EcxK+eMGRmY/bG?=
 =?us-ascii?Q?GALvjsp3SVcH1mnjbZ2G1XWAHBwKpjyOFfwVuapTsqMIZPA6DPE3xSkMfNpo?=
 =?us-ascii?Q?aIHIVIWj2mFD58wNKOUfJ6bfE6l3x5Zg9TkWlCpQdZ5dQdqmtEG7kturWZy4?=
 =?us-ascii?Q?3m/dODMnGouUzIxk2rHaSB6b0tDdHRlW+CtCEn26hAvfYq2bQJLyKtAb+GWa?=
 =?us-ascii?Q?24G6+VXINfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSZEw7rMO2wNgMj8k45yJJFfTM94OBeXxllLN2IIB6YB2k4yzdNYRFxXQKYW?=
 =?us-ascii?Q?ekEewhqHD5+pOO0qRCEyUDWN0/vn7zMfrqG9IHpD1U8OImJEi9cDCT2o/m+4?=
 =?us-ascii?Q?CUFOXFnzJL3myda0AM0QBtg4sCaQeJBFq+oI/TJw/NAP+I/RPa5PlcuN2TNz?=
 =?us-ascii?Q?Jg0S8xOzkn5QRFCcyqQ6EGDpr05CxLI+FLXC3m3tBYi2GtCgXJR2wpYNrXaC?=
 =?us-ascii?Q?pagi2uVZbM1qcZA7+scPdx4hRzYh8D4lZknC856jKlKSg5+Ftr4nLvuu0QoM?=
 =?us-ascii?Q?huk0QH09SWGAGUFiwie8JPiwKZDAxtc8TQaDBMYyP+uid9WRMBHKDM0w6GUg?=
 =?us-ascii?Q?5DaChTstcaKWb1uqIyH8h5QDDuQxVs76bEkrP7JjLmNJEeyen4z1p3ve3pFV?=
 =?us-ascii?Q?XieV3jKcSsvU9Q29OK0stncRBe/2+SsHN2NFg2TH/6g4zw0wrn4ZcMlkiVBS?=
 =?us-ascii?Q?jTWWx4PiHk0wCDpuGpMZAAER6pB6t3jaeRyqzgOK4IMjpAb4p0h0LEYVKZR1?=
 =?us-ascii?Q?b/sgexudel8RN8qrHVaocRhRkbwD11Vo8qNFhcbBX5DB/a2uts9tfv7qp3Ll?=
 =?us-ascii?Q?bhIG6YGBJsVe9vuEMxK1d6aS2x0Ew2wbQ1XYPXQrsu6Zm957LUaVimLrgM+t?=
 =?us-ascii?Q?2gbIbB/f8AgurklkYNdHT160wzj5jHKlQZC18Z8nQBVFf1ZTZJGoVpB3kPXY?=
 =?us-ascii?Q?5pEbzkGJU2twouivAnJHpHoqgbZcYvvknGMSIPw7vuKaWN3Vbxp+wcJRVDGm?=
 =?us-ascii?Q?4vL+36ilZwodNTKdqyOPqWabbPxW7fh8CZlWX8yrhx3omDdi2cGmxcfvHxCZ?=
 =?us-ascii?Q?TRuExy7G8WjVdGvjaEJvmN7wsqtxRtOlRrGhmi8+jJtIZlBUb7U32tNoYIIO?=
 =?us-ascii?Q?hJlhdXFcKnZrWP60N3QIbmNe2x1yRjeACPw+cEWiFbmBvGVJpH7vZyfS/Rq8?=
 =?us-ascii?Q?JVWx3m2r5cjc8VsZFUx0oQyWijyN7EgdP51vHpDK/YfhUYpL0CvZv/PTo5h7?=
 =?us-ascii?Q?MtG8kHlcjhlVeEw49zwkRxlqA3IDbMM7hbkAvden8xpzakDl4Cq38f1XLL6X?=
 =?us-ascii?Q?v0vCvre9YkVEmpMbwb0aMVf41PDvnygidGJWxaJlscAB3sK+QyrRUtjRr4jh?=
 =?us-ascii?Q?9XJ/+npHZnA+Tadm/mv2OTTZMw3HOZ12PuXj/6guTjgFOaamuQzTlkn79MJu?=
 =?us-ascii?Q?HzHGC4nmYMOqlJhsS6AsMPgBVhGBkWbNPx0dBi+4Sr0dUoADn+A9RzRXanfF?=
 =?us-ascii?Q?dEzgf3npjRT7za2AgzhkyCpihtTlAUCrsyWQ2XdKH5oB8jf6HUJgMN9c8NlM?=
 =?us-ascii?Q?ZVNy0jAP599epfvbKMIbvqGae8Z8Wyikxpt1q8edoWUZ5Om3lxfZK+e7C15H?=
 =?us-ascii?Q?TLuGwTKu1s1kZvXXSPu1fnnJvFYaPEx7526s6FKNCDpkHdV0oxN/0Nct7hh+?=
 =?us-ascii?Q?mhevrM3M3WBi1J8rVcHVCTtjcA7kFI78vTPwghFSZRuhe2BOo4qQO7z2ZMxW?=
 =?us-ascii?Q?2axRubpxEzkBUsH62khj0TjdDR1h1/5QyGnqn//mgfVU4o09Knsa+Z3DQBoX?=
 =?us-ascii?Q?FLmJZcd1jt4+cXMDXqa/7eGjEcbkvige3uV0eYuM4EdB9z51xG3OCKIBrYhV?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ab6c3-b27a-4914-0b54-08dd1a9ba2fb
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:56:31.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 028xaaS3rr3xMmDqBqTmTlJzLrB9ahpJODo5QA4MSKoJofhvhK7V2+i6OD+BNEBP17cFOn85SrnzGxv9ZZgqUvuU5caL1ALkbRer7xHFb3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB7014

When driver processes the internal state change command, it use
asynchronous thread to process the command operation. If the main
thread detects that the task has timed out, the asynchronous thread
will panic when executing te completion notification because the
main thread completion object is released.

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


