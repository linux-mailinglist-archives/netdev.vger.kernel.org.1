Return-Path: <netdev+bounces-190608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582DAB7C27
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C534C5D09
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD919CD01;
	Thu, 15 May 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="EgaHhw9h"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023141.outbound.protection.outlook.com [40.107.44.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0B17BA3;
	Thu, 15 May 2025 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279090; cv=fail; b=n3LbYaQg2UPhJkJPw8yeTHbDbgFh6WVTW/+XKcyQXKeY467Mjkfh8qOUeZRIpqIEs/RSucA9vQtTuIzOQX4sqNLpTSjDd1/jkiIwp72iNNZ+haXluldN5otrTpa0ayqVV3J0oSsBqxWl1uCUB6ampbkvVoPW/a/J9nKNViYKeYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279090; c=relaxed/simple;
	bh=RqCRMlqWOV7RBASrnVbt/oxZz1ha3/kR54QBeaFzqFU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YKSZhnLv0e68Hp9DGWLkBvoAzLJ5LLbpq0BAoqmIjmYolMY3msgQsBrgA8otPXmYHm3OMYOLyUd4Ipxw8Cptbb7h+ddCkGM69lrhwGEjuOS8ZtBq45ElWICdQuXFujNjbSx38X1t70QF7IIg5RtKwlrXAPLY6URkZbQeeqY0vm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=EgaHhw9h; arc=fail smtp.client-ip=40.107.44.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvYJ7buWk5axVkVzDwzokgCUISAmSACJ2rDZyB9eD4Pjf6a2fFQEOtu+rZFQkTEt4kAm3IOBQEZGXpKVehUl67y/Rn5pkbTo/pOwAaTnjWREuArlO5ZSIYtPCNnawItFXZQX845q5Oun+Vd7zbh0uO5X5HvLRu4BP4lgjnJGwU96W0D7kZ9PL4UPfVqlyIqcNi3MhXrY0Y0YJFboP6sXWinwr8HEOpRFr9jHQX6v+midgtsqC5ydmGqqgNO/QSQiBsaZF3p/34L+c2agQsADlMQUIAU2EQ4nmyuXZR9r9faWXwvdrcauBMwgKRaHKZo1470z3poxqofe43DAqQRtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBMN+GRtJJDYBUKragPrGaRYI5mmdtAgkKFutxwO9ZQ=;
 b=dyBoD6oYMxA88D/4Au9seYZMyfFquJDwf6Mwgi5IUx2/KNkxuWSQsbYoc3aFqgiE6zMMBDOeOnk1k/nfOcn3uX6DVKsQW29tZTfuz1SXR6L7oC6ksl7qWpv7QgGdBJeme05PxOlouhoFOMoJtY3ylw/Q/o5c/fL6wpYpuDMw1LyK8aJV0B9WQ5FxYa8vN4j89rzS+9dNXFDrK3+AosfjIo8aaST2uddaHrca3ozDYgcSf6cvLx0QH/ltNyd+vdYFiVbMzXrY8YOiD8eQlOpIp38UZQwJbSY8U1XVmmy8DOqs6D1EgzOqSgGvoshByi+HDbQqf2rtoq8XUv1m40eM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBMN+GRtJJDYBUKragPrGaRYI5mmdtAgkKFutxwO9ZQ=;
 b=EgaHhw9hkK+AXOBt+yjHjGfZM/rOMxsT6bxmrmuNaKxbR/L9Y1ejrmmVPLGHa2xtf+7gx3P/7dLxrzkkb5O8ZDlWMwq2XJI6wOGjopM8OqzgXlPO+uUZzFeX5Xc/9t7hRDx6joXrQhgklwxkOPuqC5drYMXb5d+sl7K5X+d1LjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by KL1PR02MB6332.apcprd02.prod.outlook.com (2603:1096:820:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 03:18:01 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:18:00 +0000
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
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net v1] net: wwan: t7xx: Fix napi rx poll issue
Date: Thu, 15 May 2025 11:17:42 +0800
Message-Id: <20250515031743.246178-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|KL1PR02MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: ea21e94d-3ffc-469f-3d6f-08dd935f18c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAIq+GGQChM4A+5w8T6HskRORiitjhz22RVMWk1tgEJnFWz9b/alwddi+rg+?=
 =?us-ascii?Q?0MQ3WKh4dGe/5LP/FyflrmWbWQrVEY1o+uG5Esc4mRqKZLGqDmxEIukHzCmN?=
 =?us-ascii?Q?xAkcCmALC0erSoiJDwvMxnkxwyChKVn6sc+XDl2pXiaKAsE+vazc1rpXpokB?=
 =?us-ascii?Q?Anlre2X5V+PWYp1C487kq7hDBym4hYpVvfgFWqbqH7J9mr4jwkJmmwWoiZQt?=
 =?us-ascii?Q?Tu3IdU9TZZAFbP+8Vf4IPMYahnHgkJzsQEKaZ5VXEHRsHXIwuk+tA7FCMisu?=
 =?us-ascii?Q?fQJ/H/R9IZWpG2ZR4feJpy87BFfEQa3ZDDgRD2AZShcQu5W5KRLj+8AUbi0m?=
 =?us-ascii?Q?dSd7/uyTBitJwPnJwuaTL5PhO0Snt5FNI4QKlYSz6mvvUEANOjQeC9W97UCC?=
 =?us-ascii?Q?fgXgGtypWFfd7EWNfauX1o+t4QQGhuAWnL2BYzuHNQw7m8pdzekk+9P3ARXb?=
 =?us-ascii?Q?ugxeM/bKtXQfqCqPhjGhnQel5dmF6dWyXTCr8gC+7bKkIf+vlrlAUvoMEYiJ?=
 =?us-ascii?Q?r082xAlXuNFnrfloSkw7Csv0D2mDBLvRm4OXR5alUllwD/EHybUH7IIZLYKn?=
 =?us-ascii?Q?RFILgbp9eRQUi4FFYmEQOuFlLR1sr9uozzbqUrsR0ZLXWqIScGcTAizPg4uz?=
 =?us-ascii?Q?wMXAEaj/85ZA6cJn9ExoeeviDiK2OOxppYEYhWV2I66aMiBFtQVKYYR0dWxX?=
 =?us-ascii?Q?hR5hm4vdWzfq6nnZsl5urtWe4mmB9ai9/ywO7VxRNGpNf7fdfNveKdJhwBGz?=
 =?us-ascii?Q?kzHjFoE71vdBI7dZvM572PdWV5gVZGC0vFCPuZBnIbp2aimBwTo5HI8Xa+El?=
 =?us-ascii?Q?zjiGC0GED8JvORt2NRvtvx9wt5KXQQXeV4nINbsaxVOeiZN+UoUCPa3XvoSl?=
 =?us-ascii?Q?nyCDQDsYXgihW31mUZZL34oB+1YMafaQ+vZ0b4NWTFvGB4dQVW/NK7jL9PFD?=
 =?us-ascii?Q?XVGBpZY0Ui3hsOJeBBelZRzwPDOnRh0wWZjc7LGxXs7PevZUhd1TCJ6UGvQB?=
 =?us-ascii?Q?6ahWMOk2HDo3dn80bo9y/M4vwjJsvyX4oB4dyak9cbzQF+8C0NVtpPFC7nMr?=
 =?us-ascii?Q?luYB1JH7c/6mZueLVNmhe3KQIyx3YsrMjQSu7GC2STOzWu7WpbYyC4pxEaPR?=
 =?us-ascii?Q?JGID+cAw0gKNQvgVNvhcgCiFBfwftlziTFop72E6MRiLLqZV4em09pLCDYbs?=
 =?us-ascii?Q?36OTFOTdidyGWQl3lKUtIfm91pQnhPMjOolKTqwJuBXsboWeoiyzjDHXljAW?=
 =?us-ascii?Q?KOLoHBtVksI2A6G6Mfjlnr7waEj6nGSvFh7hLD1/+ZLCj4/SUY4JQaWQm6+Q?=
 =?us-ascii?Q?JQWfCcrOLtijFUriB93DbBL4hFUcPugXzpQyP9AOBL46MfbSwv6s8zatQkxQ?=
 =?us-ascii?Q?ZV8IDW8CqTvYWCeUKzhFjY8mWbeJhY7e6nUfgL0c2Ov+/LjUA/FN1/5BFyrH?=
 =?us-ascii?Q?0eBQLkDJnt7cKbzWZvm9fLEH6OUaQ0VSek09fkzzWwCvO0JSN8u0w/fXIaTH?=
 =?us-ascii?Q?Duaz+U+PAuwvK8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdhgG8LxrQHzrnRgAOPGppE2HlqjOgdzKqvUa6sdi5gWUaKTe1+O5XMrrAFY?=
 =?us-ascii?Q?ie1ThFD7dq/C9gNB2X7I3RxjVoQQ05/2wWNAlonqCv4GfTD3XoNvPJ/s8LN+?=
 =?us-ascii?Q?wIDIWx6w1axTqwckv7kRotdvHg0S+IgueFf+8eijASyCS+ku/F/H2Np+fhlE?=
 =?us-ascii?Q?WQRtfucHYFgRWwqFYmdetELQ41zA1GrrVa7uwbxh0MATGSEVg5Frs5V3wayt?=
 =?us-ascii?Q?rUotBxz6xkoSdkmn7AbLBL8GtxBxIDT4trynEdOe2Wtkkb8yToRsomgoqtli?=
 =?us-ascii?Q?TSTiRzKx7giu6PFezvAadBVMEqiSjGMC2yVLZRotj3T6mJ6+JESNwo8ZomaD?=
 =?us-ascii?Q?QHhFnTuPOh75/8nP935mvq0nbNn252pr31ZdRSWhPihAV4Wchwi5MtqbsJEg?=
 =?us-ascii?Q?8bJt/pO5qg42YjV9XkWh6zQZ/lpUkv0E2BuGACEXb+77hXyca/pbcKAbGII3?=
 =?us-ascii?Q?IyhEVqjFEEV2YX9JDp5M/T6fhkWnGSpRUMoeqy2q0bNnsXLm61YMSAyBVCsy?=
 =?us-ascii?Q?ZJjzEhMqPsdxFyAWIPIMOi1G6wxGPCCLdMf8dFUCW9SMO07Aa8Mo8i66OaFa?=
 =?us-ascii?Q?NqYisQMZGDrXjB6sQ1I+/S1HnKEQJ+B02FwnGPBAupqgWdHCK5g83IgnYxPW?=
 =?us-ascii?Q?NJRDnyEMxqZz7Z/p2fH58C8qGtdvEovySYXEwf/xxtpV8XWrdPnWqivLAiNB?=
 =?us-ascii?Q?gtcjEXJBc/EUnFetnnT0SLizCzVSfEOm9cBEvETFl8Kj1Qjbpr+QufiDzn/3?=
 =?us-ascii?Q?M4QEOp9uy5fFgZYp13G8e7KNqxUqvTP9/5HZscauVueIc12505OOqrewebxE?=
 =?us-ascii?Q?RL5o/J+ZwIHks4ZI688mzyQrsfEqVIYyHEQL7RnVjgPSSP5ioFdUrMSGlYlA?=
 =?us-ascii?Q?Lepbqc+meWJLkf2uTzgH3Nip2W2cq8uLxNbl4Fo0mbYN6fmEX1ZMB2VfrKjr?=
 =?us-ascii?Q?8DQ/5M+UJhfFDngy2pfgm4zILvnOszldoKSp3wpdAp2/uDot5L8KLre+s6oo?=
 =?us-ascii?Q?cQEszmaLz5YSnXLPFXDoKhy/+CIAJEWlF3RyMqy96MPUsaO6C1BlmNEWgX0U?=
 =?us-ascii?Q?uCnqqFnTAeD4c/fAoeTYNUTBIXLFwHSyVi6gckgO0HtBd1LNHeFpA4++tfr5?=
 =?us-ascii?Q?7J9NamSLPolIzGh73YGQQ+r+2LB9H7hZvuCta+CzZnpgug876K1PS0VcLucU?=
 =?us-ascii?Q?aeu6p1AqF10aig0td8SnR2FvdrbrvUDRHZTO8dj3ayfpf3DQgkM+0zT8h1FU?=
 =?us-ascii?Q?v4o+fOVDk6kqSNwfAAIiTxHTcOvGebGjEXiSTGOJDIbWvnYgb0+1+10G3RFw?=
 =?us-ascii?Q?BHmTHgM/JAFdzMu2n0wpePC1osSbYPJnjRkVhcM/4C3c4WVDT8JBsNBccBET?=
 =?us-ascii?Q?U9vQLQp4sLhwVsAPjl7kGF8AIlEnR5f6z/Dj2vGXo51j2hc5aucdNytLMvNz?=
 =?us-ascii?Q?c79OaJ8i3ofY9dmdnqwS7poc5gxppZtP9v9GBRepkKpqFAPwzMADNm9L5y0X?=
 =?us-ascii?Q?vOiUeaO0ENAuIqLpQ7kEcoT9b3lTjitk1pLWinZO/KXTRZa/NxGcrJO/8XV1?=
 =?us-ascii?Q?x7WZWN5OovcImzTUcd5Y0vCJTkp4XepeO4ZrSRmgnMb1RHZwjHB4X/ba/Fms?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea21e94d-3ffc-469f-3d6f-08dd935f18c8
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 03:18:00.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl6UwWZxDrKc2vxAEoyHKn9xMXIBQISzBYD8VvdyHeVSSnuodktO+RtqiYZKqZTJbYILe2H9RcPfKcRmMKOtbxr4PXODXks2VWl/2cObyBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6332

When driver handles the napi rx polling requests, the netdev might
have been released by the dellink logic triggered by the disconnect
operation on user plane. However, in the logic of processing skb in
polling, an invalid netdev is still being used, which causes a panic.

BUG: kernel NULL pointer dereference, address: 00000000000000f1
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:dev_gro_receive+0x3a/0x620
[...]
Call Trace:
 <IRQ>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x379/0x3e0
 ? exc_page_fault+0x4f/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? __pfx_t7xx_ccmni_recv_skb+0x10/0x10 [mtk_t7xx (HASH:1400 7)]
 ? dev_gro_receive+0x3a/0x620
 napi_gro_receive+0xad/0x170
 t7xx_ccmni_recv_skb+0x48/0x70 [mtk_t7xx (HASH:1400 7)]
 t7xx_dpmaif_napi_rx_poll+0x590/0x800 [mtk_t7xx (HASH:1400 7)]
 net_rx_action+0x103/0x470
 irq_exit_rcu+0x13a/0x310
 sysvec_apic_timer_interrupt+0x56/0x90
 </IRQ>

Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 91fa082e9cab..2116ff81728b 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
 		return;
 
+	ctlb->ccmni_inst[if_id] = NULL;
 	unregister_netdevice(dev);
 }
 
-- 
2.34.1


