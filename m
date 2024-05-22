Return-Path: <netdev+bounces-97482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66258CB8DD
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 04:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667311F25891
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201C6AD7;
	Wed, 22 May 2024 02:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD433DF;
	Wed, 22 May 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344045; cv=fail; b=T9kzfLc/mVbJx8k2AXi8HfzksUSmsShAGHujeE0A+2/Tb9mrM6rwubREWQMOcPswrk8I0BJcpqV6G/WALLsOYYUSsva1Kp2dzZtZz6afBMtFyjhoUq69pCzuQ+ywX5l0sK7NHgSqAL7qY7rO5z5UZoaMwpiH2BhNGh8gmYXq5v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344045; c=relaxed/simple;
	bh=Y0R4Kg3pddHZw3126HkIuTpKc5za6BKAqmU+LS//x0I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tTUBtxSJmafmUIW+rpWPqOsUC+U0oKM51FKIWbeAZ7s9rLr0bPfOqL0z6VC7gyzZ26vDHOSiJHgGSgsVpHW0lHABzwbNYc0oHS0tI1XFVs5AHNZhP1l1ujjCBfn5IPv4OkbSDUVekTI7i7dQZZ/QWMFnm9EvK0o1gfSRhi/mYC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M0wjIi014420;
	Tue, 21 May 2024 19:13:38 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y96mng1kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 19:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3hVD39hClgmURP6hC86jjGQLQwiACNTOEXIfOkwe6pR9KvzlybnJZDbu0EAbNKK+az8m6nFAyiVTQFVbyKKyn/0HXgyuHMS/2PXST5/rAL1KvXncJOUxdz0t1qHYFdB2nb663P39Q6UJGbBgSLkgu4fF6Ez9PsK495IvuE918DSh9UTXaPGmCtYHqi+pPWLu+fjIHgvmY4hN7wG+JdKxe7htlhVbbxvx1DSL1Co4U4q8BhMxoJ2q/uqpqq8Dj+cIMMOCJqOfXUhS5vF6dBNfVymRuqJxh/2DIUE9TWwT1mnpa+SjtPpUef2zhtBHRCT6n1nzVjrVkE3Ns/cV6MRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4o9WboDjWsVys1OhY7fZ/3YitobHiGrKq0zjsStjxg=;
 b=CAECVfe0dRbtA5e1qB9CYtj34Re9+sQ/6gvHbbQWX/+J+L3h+mTcwChYRG4B+ZZu4OdvW4Mh6TjPjBC5H+t3wYGkbfYUcYK5RmuPMf0XfEv9HDqo4dhsozu7g62XuKaEyzNsbWpL9z3/eDXgj334QTbXQXSJM+qX57di9HVYYeoj6yL9kqK4sp1YVgUPYWxJrr4epiElIdLJsmVzJsHrnq2fSCln67g8b4Tiluy6d6Bl8lF72UlK5WYPCtH7w+FqjTcviotE9BUopyxeAyejh1wTpU8ThGLSQ4W/MQ0qpnDGaB02ZY/J+du8tSNV7n0FtF+Z+fT5eacJ/Nq5eRlvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 02:13:33 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 02:13:33 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net PATCH] net: fec: free fec queue when fec_enet_mii_init() fails
Date: Wed, 22 May 2024 10:13:17 +0800
Message-Id: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::8) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d7b2cb-477f-4d4c-4f62-08dc7a04c7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LmdVVEH126kszUAsoe84Bcd4Zs1LGrDbIxCxZ1fikKShlNDEVTWWjYmDjWfF?=
 =?us-ascii?Q?593B8gMPmaaovxmYdhPCt3c8Z/yM59AydcK+Q7Qsmgn/x9T4xVlYPU2F+lLq?=
 =?us-ascii?Q?UPPjgVl74hcQVcD+D6GUrKAMJC8+LCiw6dzq5oh0sjDJT2UFk3IluO2WK4Bi?=
 =?us-ascii?Q?jXlw+WK+x4Z8BhONvXOgxG9LUzs8EUhQrjAh7WJmXNYTIe8y0MwizRVofgXw?=
 =?us-ascii?Q?HEMo8z91fIQZZcZWb65vbnlr4qwA2177LCytUkewoCnwqmwZzyl2rbA1U2IE?=
 =?us-ascii?Q?9aq8wjU8SfkfBeAvLE4aPTYjOQza2R8VKag+JmLvLZVmr2kRT3b6WIq7ONAs?=
 =?us-ascii?Q?n0FmO1wOmECyhWtn99da/xNsFIbaqEvU3hOyMKnmqDb+94tVDcLODyVGEIMS?=
 =?us-ascii?Q?GdIHY+YNPZl6wRUJCRAhZ+D/HRDicWNGvmog5Xvd/Q1woRjyB7lFR4SUtwT9?=
 =?us-ascii?Q?HfGXxbub0j0Mt0rm01PtVp0q1AKGMka+lqQ6cDISdJ0hotWqQK9lEi9aGBve?=
 =?us-ascii?Q?FbyVO9E+ZCXaPog/mfNerDbr0GVgAoJ3l/Hh9mUobeyD0X3OXoG9t2DblKj5?=
 =?us-ascii?Q?ssJDSygLvdM/HUVat6tCNUVB2iz3DnOOvBAuRgagIdwqiphmDTJX9HAx3xPd?=
 =?us-ascii?Q?+5BHu/JfGbqi7VHwj2/gwsxGUwidPmWz8MQzfjGkGRAyixIfdMSUE7dG6W2O?=
 =?us-ascii?Q?KTmpJFoVuFbFmElqbkJvlVMZNCWvcRPIvQGWxQ0Tr7cvpWv3UCJKsvefUY7X?=
 =?us-ascii?Q?bWOyiyM4nQuQk2tTJegyD2O2OpGBk+bvDumRipRTmZseOZfG/39iPmxUf/tM?=
 =?us-ascii?Q?5iZt/q7aA62yaeDr/hcauePcBng2cpQTUhQZJk6ptxVEwNrQe1PaA3PNXHzX?=
 =?us-ascii?Q?saZcPpbJ1fuPwn1DSHofgn0XLJa6WAKgP1iOlPyVZTwbFmGMxNPyyQLsfGsP?=
 =?us-ascii?Q?GqR9Ftp9MFd3eyeu3iPhrEQ+SyZr5WmULjXMqeRl9v04KgDR2QyR+Te1qia3?=
 =?us-ascii?Q?EQ2/5hQaOWdOZnt74IdQGCQvRQZdrWnsx/zl2nlkKsR4BXbmGqUTszsOzBhT?=
 =?us-ascii?Q?EVcoiPajiqFVcgU203xI72NM25Hg76J/kE2/R9dEyzBSjS7T1YZbUK1TyFsn?=
 =?us-ascii?Q?1cnI70ek0ZsDYpnjEEr9MsJZ1SGNqi9xgTRMW4VKqE5RsvnrXPiMJxhIh25v?=
 =?us-ascii?Q?U8RCW4pzNIYoJHQnQBFcJ8H25idJGCxiAOPqk8Pz9u+WgXBl91GJs9ctp+M8?=
 =?us-ascii?Q?nmDsgQvvQ3FLcTp2FXnLlKGWOvZcrV0tmmbSCFFiDbyvZyaz6GKVDA/fylpQ?=
 =?us-ascii?Q?pgCEwNcbShh7YoKo/Q9LZGukrTvo8pbLPuvBsV3JtCazSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ey7D60ax1K911XCHjEFALIa2Dzc8pU4XyXubcrJOp8+0LSZRNDXYx7Fnsb6O?=
 =?us-ascii?Q?tAsOfV/LWW+cMh6WUznckQObI0Y8RgGTUx9fX/8yFhICYmYOU31o78faUlFq?=
 =?us-ascii?Q?1n2kx4BYGV0Kr5Y4xDyHx5zbDdwqf2fFHmCiXwZPoTR1At2e2wqrjiu8nT9N?=
 =?us-ascii?Q?7QFLHB+tRMSoge05jSvPEdsr9AAPbrJAld/fCKRx7hSY6GLjQvQbMxtbJaFb?=
 =?us-ascii?Q?43E9zUTRgDY3to6vM33umxon0LQW8YRV/qfFYu7p6V7okKj2iduE0pM0J2yu?=
 =?us-ascii?Q?EqKvA5OlkSlprZc0CTcpAkY30cat4z/yBk/MqMqt2Rp7Md2m62O/T2H4gYKc?=
 =?us-ascii?Q?k6vZgTj/DXac5oKlv2fVHbAkdgFO1TIPehtjdi5QCMoDHfn+PUtW3t/tDMCj?=
 =?us-ascii?Q?pf+Te6mVdIJCK3KtgZdeo/kOWTNSPHEU7fJPMoF1EM840bP+3wol41M4KTbq?=
 =?us-ascii?Q?kBeo+Api4Bcl+nCAEWdoUt3evHdRuFiWdPOzCdjvh7GCjAQGQf9y8oadsIp2?=
 =?us-ascii?Q?7eOVvNfmu/jJaRropFnRapsu5oXTtVTmTmEc+Jdf5g/oR4qWI8S4etKeD3ie?=
 =?us-ascii?Q?wwWJhlMpbyRoq/1YrihcMd9J+Ih4hC7lkp+ZShQSuu/hV0SolzuAoEqi8LIj?=
 =?us-ascii?Q?4b/imUuIDBBsEf0sPm6eNPajiGDs+0tWXhjwUoU+4pldbuWb4shbeSRUCbws?=
 =?us-ascii?Q?y4mfvTVA/zJJHKDEnB/z9jbu0ugRqQCP25JmsqrXQ4MpVQNIeC5OQ0c3hpMc?=
 =?us-ascii?Q?rOrz0bu/m5rXwb33K8CTX/vU2J0VSZ+QOHN7wUf8H0DOYjO6vfaFSjDFf1Bg?=
 =?us-ascii?Q?xddzH7OxHlb8LwalKEUD1lWtd5i1koVIllXAl7xCw8gIHUApWdCxNSC2ionG?=
 =?us-ascii?Q?Nuaz/nWLyspl+cy9u79AZRlZvWB68ZoBGiGmZOXS8BvtEaJkmYpNYG4ThQl+?=
 =?us-ascii?Q?4uhI9KpD/No7dYB/pZXmGpd140PTWO0xVVcN/Cn3c1W7DVD9jgB9Gl8Ngplj?=
 =?us-ascii?Q?M2l/7qR7Kt5Swi61lyqwk4nJKdCKzTyUrAI1Xi9A3gG4/v82swtSKyJ974hA?=
 =?us-ascii?Q?4F0opHn8l66BxT/ZyjJuErA96uBbH4NkME1OezlDEOSGptZp+4XUrmN+8D+t?=
 =?us-ascii?Q?/Y4KagAI1kOCgTvo6NQE828ue8gTBXDjXNfHOQtIlNByTyB0tHuQFHaXKMUU?=
 =?us-ascii?Q?3b151i1uVU5rrCQgUEnj62lEBZJk8K/PKDnbztaTBZH9EOfSgXoYS4XGOjSG?=
 =?us-ascii?Q?3za4uvF4b0r5FxP9qaUL3ps1rPRlZDFx07Cn8pvPuoqXKWrO32vYdxqBIvgt?=
 =?us-ascii?Q?3sdNb9AVhHI4zJwcfD0Mq7u6FHRhvJeAGX9+F4B9yXLK0GqAgY/NwhG2xUX7?=
 =?us-ascii?Q?ASVrDiRk5J9yUqfRjBecJW4zaiFPJ4xSDzakeAN7dm+230NHCWUQlRBV4G/T?=
 =?us-ascii?Q?g0ooHoKC08SfTv99tbQmhBe06jp5uP6JT2eme9JrqrsS28IEFYu305KckXn4?=
 =?us-ascii?Q?XWdAdmTiWIm7a8qBg/YsBLv/LPJ17JZ7ixqE0uoCe0tZBwg63PqYr1HqCtzm?=
 =?us-ascii?Q?y3QZAw+QMfqrMKm5NurCOURGgLJbtTABuc1I68Wm8ndvRlNw+vQKxCGgxa7E?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d7b2cb-477f-4d4c-4f62-08dc7a04c7c8
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 02:13:33.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPNmrZ4vmwvZoTzjNfjd0RvNV8D4DXtfYo182Eu2rlML09tpTMLkFzIQFDzhskAeqQ52cNThBV9iOfFUF457b4/xmCcbLBvF/VlrzHJSgwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-Proofpoint-GUID: 5vFXzgOfKhROar-MKmEbFDGu6fisrPNk
X-Proofpoint-ORIG-GUID: 5vFXzgOfKhROar-MKmEbFDGu6fisrPNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_01,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220015

commit 63e3cc2b87c2 ("arm64: dts: imx93-11x11-evk: add
reset gpios for ethernet PHYs") the rese-gpios attribute
is added, but this pcal6524 is loaded later, which causes
fec driver defer, the following memory leak occurs.

unreferenced object 0xffffff8010350000 (size 8192):
  comm "kworker/u8:3", pid 39, jiffies 4294893562
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 50 06 8a c0 ff ff ff  .........P......
    e0 6f 06 8a c0 ff ff ff 00 50 06 8a c0 ff ff ff  .o.......P......
  backtrace (crc f1b8b79f):
    [<0000000057d2c6ae>] kmemleak_alloc+0x34/0x40
    [<000000003c413e60>] kmalloc_trace+0x2f8/0x460
    [<00000000663f64e6>] fec_probe+0x1364/0x3a04
    [<0000000024d7e427>] platform_probe+0xc4/0x198
    [<00000000293aa124>] really_probe+0x17c/0x4f0
    [<00000000dfd1e0f3>] __driver_probe_device+0x158/0x2c4
    [<000000004ae0034a>] driver_probe_device+0x60/0x18c
    [<00000000fa3ad0e1>] __device_attach_driver+0x168/0x208
    [<00000000394a38d3>] bus_for_each_drv+0x104/0x190
    [<00000000c44e3dea>] __device_attach+0x1f8/0x33c
    [<000000004db69c14>] device_initial_probe+0x14/0x20
    [<00000000f4705309>] bus_probe_device+0x128/0x158
    [<00000000f7115919>] deferred_probe_work_func+0x12c/0x1d8
    [<0000000012315b3b>] process_scheduled_works+0x6c0/0x164c
    [<0000000089b2b6e1>] worker_thread+0x370/0x95c
    [<000000004dbe3d1a>] kthread+0x360/0x420

Fixes: 63e3cc2b87c2 ("arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a72d8a2eb0b3..2b3534d434d8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4524,6 +4524,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_free_queue(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
-- 
2.25.1


