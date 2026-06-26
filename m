Return-Path: <netdev+bounces-302233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IdkTA2SrPmoIKAkAu9opvQ
	(envelope-from <netdev+bounces-302233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:40:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9F6CF2DE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=grBVmmZd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F210312B1D9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43D3FC5CE;
	Fri, 26 Jun 2026 16:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B3FBEC9;
	Fri, 26 Jun 2026 16:32:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491562; cv=fail; b=P7wF080fqK01lZ65rpJ9wOtayfJnfFy+eVy9vp1R7r9/BPs8Uf86IXZ/r1KR90CvyEk5E15QOpH3q3ByjDe00j4UMty6qORT0v7LOjE2Ey33pWbKWXMeVuPsFC6+o+I7esY1HApbIUN3G2Y1J/imAukYBapqumbxqaK/8BDNx/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491562; c=relaxed/simple;
	bh=u1F/8OtB8/pRPvlsg0LFBAJlV9vVwXbwwgRKHFEI1/c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HBxXvNuSyxeTMs5+UtnUWdgXEEX3FDVD+cMTehNXpMgQALlS+W3n0iKKaY5ElWpqY/pbofhpKTRMlEkN/ZEYJkvo5bYuJA+0M1Ya9lnYLzdiWCqo3abkRQJ4yopQnRk15VTgZpy0JmGvtMT6gSjOLo381uNfzsQMJDt5DY2Ahxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grBVmmZd; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBMfONsJakTY81K/plzqsVSD3YfBNFGXXWb8YGQdroObn7GfehmWFXh3Lq3yPDBRVesgijrZR7Tv6vCBo0NPiB/GldAOmePl0THQ4l0xbZiZHVVXR0nQtUGOwl1LQrwgysqut7xG9HuJU52Pd4jAVH5vLXIylVkHM3uGlXAHyTeCcFffFOTbJg1L7EBGG+aNfrCs2Em8BUVGPl7uPe7FdxWuU1ghuNqzHycUpbR8cACq13kjFQ7ln9/JJAHeI64qdpFCdSfy3FFQ5gzeQHTrSLwxRIgWt7LLJH/f06WZqRZAsKQZe0lOIQVVS9cYSvMk6wiqWys3lXq+Xm6UJVfgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSIlHr7kx0dZmD+OMaY5AW9PzTaCou9d/KYZfhPsWkY=;
 b=Z2u8oRHnGexEDAsn77rDSsDlzCjUBqCMa/NU6KK+gL/upU22P+xOt5sqB3Gt6CIjSGvT5vqy5gbZkMje8U0Jn9rfS5reonFbubWwzncVy2R53syUyxJuSWBEQInwd47cyJw6edVrgV6c4a5fWLjbXa85eowlz6++g6xD9B2AG2464mQhX4xAAsCOF/S7O3MiA3Q9+KnsBW4r+QiDIlACMovA7L6cTFulH3PGzvpq4InEK5gYnrdaEWr4FkgfsLa/+KXlTp1yHmXim7TbeS+2R28J7Eq2TAdVWmuS5cCuOvyKgbkV4zYN2gDqR1mzk0u3T57qtnBg8jB9gedNcqZ5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSIlHr7kx0dZmD+OMaY5AW9PzTaCou9d/KYZfhPsWkY=;
 b=grBVmmZdnD3+5zMWNmYAY537xEfeEpT0NuLe/htj0fXF5cSBC2xIXlpYz0j/f11m+zYmJXNxNFGgWDJ55xSbsybW6nh9rWicg+UhX5jJD7tGxFriXNhTE3v1q+Fjf2LgIMyst5jsNK7w6bVqvWDNOlW7/fV8RAxaU6t5xMLxOhRDbHLCudrzqErRMxJgMx8OcyekEUNyNjeV63G0AyHE8R+mTB/XjJ8XhvJz5Jby0CwwW1C9bzWVajus3f9Qs88nCj46P1gmZzpfCcCDeUeApYttCZNNO4k91V2AfsbMysvmkvDDn5XgpNlK/jK6gRW/ukZgp8YcY7TXj52NhOrMaA==
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 16:32:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Fri, 26 Jun 2026
 16:32:34 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	David Thompson <davthompson@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
Date: Fri, 26 Jun 2026 18:32:18 +0200
Message-ID: <20260626163218.3591486-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007544.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cf) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 94070c32-27f7-4e5b-c4e7-08ded3a08700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TTii7PrCONRKgf4EKzWNpPMfkTIeX6WKt8kXL8Vt5D4dnRTGGPTNENA66GStCIcoCJSUTvMVfCr+y8jjwv1/XarwspmbEPkj42EIbq/gpwrYVYjjDcHdCVsstdKBCD7edAKvWmB1JmXRxGb+IM2hXbHmtligX2KI5NSfZN14ft1l6dBk5KItyhkb10JEmdp5oaU4ngLsD/RxiZkjT6diw6zGdRF98+KQkGJIZPXxC98LxX9QgGLGUSa5MUqe3RUcOJmV/zPEglZHIrRG63FhH3sjY4RQowAtS4uDc8dE9AtF0nVeIsUMLNqtT6r969atqr5S4w7i0UGz9OYc35OOC1aSdO21MrftwLOUgybfQWpL9JUzHoMjbSr9uRicoiw+We0bk/Uaqjb1Y9Y3arcW4j9SgHRcjbzW1vVWUXrfbfwPgc3zUA/wc8/WMTOSp+AlabCOpoRnUHYo4Zqt1NlnhSUEE5MCCKFLTITtcQCfjSatDlE5234eav8nmw2idNg3BXmIetKY8vZm7BBYPm6qPco4chaJtlAQQwxTQnK/74ZhxTuuqyaEtgADBzij/6+h5jENf74YXVfaiOpLIw5jPyCX+9v7RyD80KE6tYncryLQM7UFqTsfZgf/ltJnSotlybqM70m9FA7WojkTJa5Cb3/Bv/sbG3egBtfg+xSKm+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i1AJCusVVmZS0wNrf4k908ZNLMQXsEi3Ze5XnKBxp00x2MLl7KsAf2U0/2bk?=
 =?us-ascii?Q?NcM1BaR3Pu0w8eiHu2MmG9yaLHoTI70+owqbk0jPVc6/1E5DHkF3b8abHUrx?=
 =?us-ascii?Q?WyGvLD1JZLB1kJGyF1orkwM1380yqhtCFpqz+DxLJM57wBG8tfcdA+Q67xrh?=
 =?us-ascii?Q?CFbniijK/zHz9bsaLbS4Zcsc8fDkTObhBFCZW16n/mVxYpFjarHHJauWpS+/?=
 =?us-ascii?Q?zRETT1mdsSPRr07Mtb7dQHYuaq0LAtfSyGF5zEAWeD8KYSIN/6ZIj9VkcDD7?=
 =?us-ascii?Q?CGvYqYgAbUm+E/d65N97gZoHDdt5sA5SrMZgUT7VxrIIvgBUXiXy175DYjXk?=
 =?us-ascii?Q?q4W42/nsP3yIHOWa5ZLbBA2Pq6rqVdWu30Zrw5+h9v0B2+rWYigXcJ7XJ9yF?=
 =?us-ascii?Q?qGV5WRfSedIpTif6XQetuxr+Jea42I8Uc8/mqmikkMO0FQJtrahfeZqxMILK?=
 =?us-ascii?Q?+iHZUVC5SgnQYJrE1J99YwqOYL0e44ot+qP2YUS9THbYValU8lWmQEegCD9H?=
 =?us-ascii?Q?EPFJmYiXwpapR5S1e1JyDKBd/bgwenV+JU4iJa8N1hjri0KrqronXME7AWIr?=
 =?us-ascii?Q?MMuNppHfzk/z4CBhBbQHLyH9i8AdlMv/0aHgy8IbUEmXeqr7XB2dasLamhsB?=
 =?us-ascii?Q?Mpr9L2vLgmt53MVapLn03ydsxgV/9euXjFuLpg/Cy61XTGpVdjRJK/6P08fi?=
 =?us-ascii?Q?z4Z3yG/HJNuvweJP9OosoBb5MXRr8Bxoc/SOrDmqou/xep3MdjzdgPPsTtdC?=
 =?us-ascii?Q?9zygKS2TNnAVSBH4pX7gJwRXaFRR2hx+i5nnomTxlDgLjqzB5nW+InYaUVg/?=
 =?us-ascii?Q?3Xv2pi5aX4vcig6FelBTITaLdwZ706ClgdXP9nQb2zRSbdRQDn4Y35C39Bi9?=
 =?us-ascii?Q?uTfsYRe+tX4n9tQmquoo4y4/+FZYhphAhd8+CYHRDTwSfTKb4sIxMOL4lic8?=
 =?us-ascii?Q?vayd0izg/sECPerTeClcGPoArLmu+DIr4vh8pfkeLSS3U2Du41/Ad6B0Rmvu?=
 =?us-ascii?Q?e25yahIg3/7dP7/unMbxgwvYMYvVQwcXX4FjeX/y7yk52ogLH3w5SR+RvFQO?=
 =?us-ascii?Q?VMKoALMBTApbw87mG/FUqNxqW3X7a0ZN/pXIwe9NxMmn/H1cRv0knoGysN+B?=
 =?us-ascii?Q?1vGNBiCAgwKpJP8yHB7vUGmt9HgdKfyspqrrELkHvIz/RDEAm7m8Lr1AAxKt?=
 =?us-ascii?Q?lIbPbjH8ub7YlYtBlho7cWPG2O4n1N2A8ao7YqaNtVF+twOes4EK3TT0SfDU?=
 =?us-ascii?Q?+DhsWCw4Q8AQEYvT1kzHRIUobAzwiQAK6xxrOFtCXb8I/kJtK6c6TllKg4jI?=
 =?us-ascii?Q?gK+oRdA8NAl3B2S2A62hZCOdzv1VV6yiMju18SeUzQuen+gqWFjbuJX34pUJ?=
 =?us-ascii?Q?xlD9o6aW5f1FS55oHP7Zbwo+VEZ5LhqA4rWYhJ2fFaPHf0MW1GROhWpfV6YU?=
 =?us-ascii?Q?e8snRAY5sSluQnfYl7j8yuIbizq/g0pH0oIOxKnoRQE6JuRbuYGVi23+VkqT?=
 =?us-ascii?Q?20ns/TYKjJQxeLIXVWAL+LnTRjMQZk7MZOyR7L97i6gxJ6PY6DI9u1VVRz2B?=
 =?us-ascii?Q?xF4yJ4GrRYM/5tKIRswzx8HZXA/SUPzIqFmIXuHGjXabsOAtSKDvjQWW9GVZ?=
 =?us-ascii?Q?jLdL5HIOP3TAHgg/xtnHaOOTUR+grn2I8xf1FVuyFd9bgAUAiHBfnKvQpXvq?=
 =?us-ascii?Q?9kknxDuJM2EHN2lOGFAya7ZbDFAl35hDTHfTzVREQlb96xqw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94070c32-27f7-4e5b-c4e7-08ded3a08700
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:32:34.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5A91fkm52Nf4VL/ZpYexf9EvNh3cwrqvFQysNM7kcBbcRIeH1QcwxVd3a8MfA51bl7WuEvAr7iiep3E1QwTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Raju.Lakkaraju@microchip.com,m:davthompson@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arighi@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302233-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D9F6CF2DE

lan743x_hardware_init() calls pci11x1x_strap_get_status() during the
PCI11x1x probe sequence. That helper acquires the Ethernet subsystem
hardware lock via lan743x_hs_syslock_acquire(), which relies on
adapter->eth_syslock_spinlock to serialize access.

The spinlock is currently initialized only after the strap status is
read. With CONFIG_DEBUG_SPINLOCK enabled, taking the zeroed initialized
spinlock can trip the spinlock debug check.

Fix by initializing adapter->eth_syslock_spinlock before reading the
strap status so the probe path never attempts to lock an uninitialized
spinlock.

Fixes: 46b777ad9a8c ("net: lan743x: Add support to SGMII 1G and 2.5G")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 1cdce35e14239..e759171bfd766 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3541,8 +3541,8 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		adapter->max_tx_channels = PCI11X1X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = PCI11X1X_USED_TX_CHANNELS;
 		adapter->max_vector_count = PCI11X1X_MAX_VECTOR_COUNT;
-		pci11x1x_strap_get_status(adapter);
 		spin_lock_init(&adapter->eth_syslock_spinlock);
+		pci11x1x_strap_get_status(adapter);
 		mutex_init(&adapter->sgmii_rw_lock);
 		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
 		sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-- 
2.54.0


