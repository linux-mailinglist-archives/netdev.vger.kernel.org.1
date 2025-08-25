Return-Path: <netdev+bounces-216512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2104B34430
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A23F2A25FB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B392FDC51;
	Mon, 25 Aug 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZZqfuvtu"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7672FD7C7;
	Mon, 25 Aug 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132091; cv=fail; b=AndQSURt/rhukNQObs52dPopCjgU9A4ap5rz6LQzmMjmMNS90wuBdqyd64ubgK/0BhPGii9Ufj1sX451mU52gsuBL0suYOSXzr57t0mw5LSq5Qy3pgM3qa7SNZYEpewkil8QtEMO5+CKoUXEuKGui6XbM5/T6W7fT6M/8GjJGCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132091; c=relaxed/simple;
	bh=FHJWMYgwOHHo+Sqj1OF/tzLVQ9IXXMJhUZBqt58Cuz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oAB0zwGnzFQ+inLL3TcDf2D1gXEXkyu+tmRLeYHfu6l+iRRyIvBhU44gdvfOcbQG7UFHLmYuj21JVcD/s+SUgWpJdi467gJktVkx525nJRNxDUxStRp6jbgVDTJDnXUgQVBsDyT0ic/DPAvi64M40YAHAsKHNVz+Llp84/KOs+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZZqfuvtu; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3feWzlE4U1bC5rGPkaSbjP//IgCaXrSl2bF9Ci47/JvnxxUFgIDrPTgB6aDoY8YJipsy0EMArEbJDs/KnTg2QKc0MVJI3uQJITcwBsD8tvNLuG9JW+Ryvoq2fErCTxOL/I/vuCZf4gVM9dNUxtS4JC+mC0IliQH7QCzr+PvUv0V+jgwIFNmnLatitwiANMA/ZysiDA4VwDtVJaT9p52AG7BzcleYvj5b1WNuiW7OiTQCWXMq4wMJogEnUyMoqVKoPpYFvYwLzC7TEONSD/bZwDVT9z+JmV6DUmOSp1jXMDC2kcuwJl75QDLXZmfxzqYaJYAQ3lYfJzRHDw6Bkr3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GyzzuqWMT/vemFnrJ0Vh0obcA1SaqaT9gbkUDMpJIw=;
 b=hbwGBsrV9KnwjNk6nW2F1wl9VyYWh2pRuF9tJZF//x4kjhoRHhwiEPupeWcQYDsMRldFKwoKN16tiMjvg4HLseNLjvhHNGQ94/Q5uqkCMI8ori/NvyFntTeXSQxgf40q+BeTNCMEE5MPxoKu2SUD9RUG3FM83RYg3YV8MKzMaAirscdv/MpQvNG4rDx25s9i2xmmVvfgYZXtJbl9PClPkqPL4gOD2VM4T2up45sIjj75SROLQea3wr/smWV/cPrvnvP1I+ROC95iFaXFCamvTdt0u4jn5sXl+B786G+RjGahWDs+/LQGh30HUYj4wyPXNVJ2cOj2IktRY6onBkqteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GyzzuqWMT/vemFnrJ0Vh0obcA1SaqaT9gbkUDMpJIw=;
 b=ZZqfuvtus1NFFRsB9R2YSNHMt97qNSDH17H39lVnkZp6W/JBOICCs+GWwx/RKXaMb5sYnEaDbDEFyu4oOpEJMkv7CnFNqe0a8+loeyjek4bBLRsbiGeCHJYVx/zAmAbrYNjPaxPH8CpZRVdRUNdjPy9dTX85jqm5beTNcKsNOtoZh7iif6ysif5aOn44FT1jAOH267GxWxeS6QmZ04zV2F45TYQlyTStGok1xHVdliyLch41Q0z4X+zSeKue5BM8P+RR64ggMnwwHTUTSUadGzeLW1tEHEwIRW/xs4ezGe/TtCXi5jbJGLPyIlEKO1np2rjGRa+UtP9kefhzT6C2WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 14:28:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:28:03 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] net: hns3: use kcalloc() instead of kzalloc()
Date: Mon, 25 Aug 2025 22:27:52 +0800
Message-Id: <20250825142753.534509-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 629f2197-a251-4870-6ed1-08dde3e399d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cyHM5I4gWDtwlpD5cIs7ybUL/+rDCQnt13BO/U2i7V8o5GkqhsiHkmXWmIFC?=
 =?us-ascii?Q?n5Ux2ihQ4vzoZOQL0M2dnDOqrFtCtJpgpkQy4s7u6/PT5fCutAW147LDHnLU?=
 =?us-ascii?Q?FoCZrJlosut/Nb6Yt0tFMrqzQTMG1sK4l2n54yU9Xvepqx9bG/rnemgbDJcn?=
 =?us-ascii?Q?x60YjFEnNg2AVqjllmnD+aNrUPkxqXhcITYUeCqGfuBREx5FESwRsgKA+253?=
 =?us-ascii?Q?l9jYbT5OgwrVqRtNgscIZjvjkqX/EWpmH+hVK4ktQYrxNG0sDFoMi8tCCSeM?=
 =?us-ascii?Q?aR2pFj1s1JoSiFc5/T6aa0YTOmxEAdrUrcz5UaiJQHuwUDCUMyr4eduTpv9y?=
 =?us-ascii?Q?/ee5Gr3oNLuxxDxR2q2KjzeptvhIzuZdgqJl+v7ldoL8Hkn4E+t2mEpmFIZO?=
 =?us-ascii?Q?cVKIfSpZWkmdth+er1PqXpAl8u6po5zkigOLedec6W824iegG1/TXqPryjK6?=
 =?us-ascii?Q?g20QzxaAs2DOlnig/KzwGaMEA/8W7vqNqtA8A7LmW5QjP5Slafk+KcYSVSOn?=
 =?us-ascii?Q?icNlVzE/0ppX4C/sWKl+8xbA3Pg8qamriZ5h8Ntm809w2S1EkZwVU6RBmp1q?=
 =?us-ascii?Q?tdptaTTHD8oKfc9NY2pxgSE5YtdPFd5UPLQq+dkwWxAvrrqoFgFOwvVVwoiq?=
 =?us-ascii?Q?3omFlXYaHzWkzBfjkTJUMe1URnZ8f7epsxTv96OEoaOBNgntNlR/8bcEioFM?=
 =?us-ascii?Q?NhAU33j0fDTe7R85/OdgtsTJBaLPVZYcIVShP4LWmaByG7Xn+0Srf4PZD/Jx?=
 =?us-ascii?Q?WUUQnfoHiLD4/LCUDKbC1FMgx8bDNdshF927PBJbPeWxDSAEgYKD1And9BCg?=
 =?us-ascii?Q?yC6t3i3Z35o3IVFqXrE7yAOUSF7rr2ylK1hCxcllYChrx/vPHeJEUogrZ60I?=
 =?us-ascii?Q?HFPgHWi/5HCwxtIvkrPitqs7JwHf3jv5wqnPT4Z/eEJ1UgS0MCuKphIPGgA5?=
 =?us-ascii?Q?NybD3kD5+7gf/gNSNG9B6xpzWfdGYJXBwqzwRYAqOtOGn5A/yvzVX/6sCB4x?=
 =?us-ascii?Q?5S4zXN6Cwa0KqBkP+8jlSRmhk/dbwC92iUsGOJti0eGs1SgBMtZ9nSGXhBxW?=
 =?us-ascii?Q?60pkFpUzXTdBs4k+PneJC66+zgXV6vBs+1+LNTTrvWCAhZVC7U5ONb9rsbi9?=
 =?us-ascii?Q?7P3hDS5O+NXsPb93m4/nXPGcqFQss31jkcW6QR48CGfgZrJGD+jwVZOYXVWg?=
 =?us-ascii?Q?vBEWfCPdNMwZcHS9t9X9yvZciHiGUU0KEyMSyM0zc01Z9PM2OHPbKSk8b0WZ?=
 =?us-ascii?Q?bnRXaNapOWIUd4a9lCTYBOBCIQUpjVDfocXhNhhngbdX9cciwCypDQlZceos?=
 =?us-ascii?Q?aBy7q0+pustb5dn9aoJ88WkKqFv0vSrJvw07Vu13sSsiIrNMU9A0AstZf2JC?=
 =?us-ascii?Q?EVfkqFMyQNCQXBpx4sPV7DwoDnVNJXRu+t+bfKGf48WSmsMi7XGK2TK+rpt0?=
 =?us-ascii?Q?ao2758fCdokGFXDIoypk8nuvmKUm+xZhtQQKi0SZ36rb33H8wVp6ywrMF+Em?=
 =?us-ascii?Q?TCiZwxBZA1dXLmzReL9FDp0340ZEn1pK+yKh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hdcf9EfC9YEqSJ0LyZGkn7p7KE/YwzBeN6uhof9TVoOajmQVfqSUJsQXjY8h?=
 =?us-ascii?Q?63WdIdJl2faTmL86DA5dOINjHQ6Wf46tgYmift4TjAzs5g3NRpsnGemjNrvm?=
 =?us-ascii?Q?LT3QWa6+FGg/TC16DjnFacIFtV5CIAqDBlWd4zepI5DIx52ukOt8Qytze24F?=
 =?us-ascii?Q?slMBriCQGdIVPPLKGbWlsK/NeaiGe59+rZEaet/Manx/6PekvP23MvgG6Nze?=
 =?us-ascii?Q?k7jmYTq1zVGI/IVxfdafMaOaNzM5/4DvO/US7wUqNIYAjou87bObhJQzWEUA?=
 =?us-ascii?Q?eew5uV6mFCZV3xaBpzlcTtH6BFge3+fnDctEuTZhs+C19nVHFNZqnE0n2zD+?=
 =?us-ascii?Q?oLIJql68X9HBPzveXDNloQ2ruhUSKJPwh1tQqBVqDY92zVnWdCMkLvieUru8?=
 =?us-ascii?Q?yHUcnwFVGJ7OmJuxatDQBDdvxDgTyNHakW8PfNHPvUSvYc0k2K7lz7+yFTuz?=
 =?us-ascii?Q?JCJvR6+CKeana7OV1IdlhU09Pxm56xvPJu4BtmWo3kRO5Vmydba3L7JEAvnz?=
 =?us-ascii?Q?BRIjbSwVI4ruFKp4GRB7h5bi8/J/r5rpCAW197D3MTdhzOs0YmFYsehqOw70?=
 =?us-ascii?Q?LBqQ5vMV8+RxbRUYyY0uM52Kqq7VDh76+JyqJfTzIFdmh6jhQryPuln1UHxH?=
 =?us-ascii?Q?Q/vR7JhJM9H9NqeydhVtz4/dNOOHMJTVT8hlL9kO9XotR03rul+83xqnyX3S?=
 =?us-ascii?Q?iVl3sGbiuStwnwJDuxkFrST8vKIet0cCnLKlMIrXSjJFb6w/dN/pmq7ay5JI?=
 =?us-ascii?Q?bpM57d1RdOF5KVDSgc/NbOnd7xKgRjuWUcLUDPOF9j3nV7ZO9GFMvR1E+U53?=
 =?us-ascii?Q?SDgRpLomiBQPjZyypA5wJvYEZq0dpOhzrK863Nzjl290tIIFnRGeGLoHUZuu?=
 =?us-ascii?Q?7955nk6YXAl8GErFKyUbxnBHmce6p9BALKl6t1JpXNoQoNvNutDykWig2xpy?=
 =?us-ascii?Q?eY01qdRYYtbMhRgrhHg4GZJo61VsblQok+my1qi2FPdGPJhKVwnicZFtkjlY?=
 =?us-ascii?Q?XIC1+6SSYWCGBQwfDKcVmvKwblbEer8EYdY+h8ZD8lwWghLGOoEWtEL9DcCZ?=
 =?us-ascii?Q?RXAVkL4PMsdiq0Q4zv58cBDjVnNNgysw4Fr6ShNEGaJBnrTBtkVSRVjOej/A?=
 =?us-ascii?Q?e7EctaNlhzPcJicLIyh+yOVMFMNYCLSJNWP5/TcM+6QXeq7G2MobMgG8jOYT?=
 =?us-ascii?Q?i/jR4x60UHv6iIQL8D8OCeC15Or9qqDxXLi2Rms42jZlVBv2ssdAcdI8xS4j?=
 =?us-ascii?Q?bopD54SFtDpxEUvhPjuq4I46bkwsdf2qWxC0VGkr8rKwYkrhLeSVHKhmCqRP?=
 =?us-ascii?Q?CexwAedAjzwBsVp4/8dHcrnYaCM+xzLGqvLFiZomW8gLwbcxIjGXj7rLv2La?=
 =?us-ascii?Q?2BBFNJW8vmLA9PvffOwq60CVV52hlS92vTZPLXU6034ElhPP34bqlyuUC0I9?=
 =?us-ascii?Q?6c8+S+s0FIUIHdAMW5ZOxTop/Lo+vAwdNU71Bg9K/P/f3r6cy29rd3k8Nxkz?=
 =?us-ascii?Q?5z9apFYE4rXgs7TAMCBxg3mRuG8hdKZcFwe1yEptddRlZBiDC79aD3qh/pht?=
 =?us-ascii?Q?HQGfw6o7hb8NtXSwnVWrFv8mBU9L0UgkETipvNVw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629f2197-a251-4870-6ed1-08dde3e399d1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:28:03.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Iut2+Wio47jAd+c1JnjkJNvbnsctWm31nMccI916AmUtW6T+LFaWXusqhj4RE301g03Z6djLXWmC9/D4NZbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6959

As noted in the kernel documentation [1], open-coded multiplication in
allocator arguments is discouraged because it can lead to integer overflow.

Use devm_kcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 0255c8acb744..4cce4f4ba6b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -843,7 +843,7 @@ static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 
 	entry_dir = hns3_dbg_dentry[hns3_dbg_cmd[cmd].dentry].dentry;
 	max_queue_num = hns3_get_max_available_channels(handle);
-	data = devm_kzalloc(&handle->pdev->dev, max_queue_num * sizeof(*data),
+	data = devm_kcalloc(&handle->pdev->dev, max_queue_num, sizeof(*data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.34.1


