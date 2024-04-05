Return-Path: <netdev+bounces-85104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D228997A4
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F890284771
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E8145FE8;
	Fri,  5 Apr 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="J5y3FARU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAD146A81
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305030; cv=fail; b=jgXXqLpi6ks731tlKtuj7QEG8Hkb2DUoVQ+uHsQ0zZFAIc5SpIM4OBRZ6pO3nkgiwMS50zpAZamSrMPYz26e2hnj4DBtA8OluTiK0CM5GlHoSyCz08P7/vJqtRaQxA/2+eaRXzgwkl+biWRu47gOAhXWrqeo1RTwmHkOBKvpGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305030; c=relaxed/simple;
	bh=agzWp3VOVq1Oz/7kzQaEoLFDretFiqXdBYdFnynV63k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTBtXoD+z3j6dqSdEumLxZ47fhkSRTNbLl1QmUpVLxDcdSbBy3UiWiEQYzRXEGh+yWa8O1Omr5ggkJS9m3KE4+DcL1zBlxii27gws52S9MOX58ufT0O0LEPsIr5dc1MtbVzB29L0e27m05pMdNphCfbq54qRKeAO3g41ZksNDWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=J5y3FARU; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJvPKpGDNL6tKtWL4nfmhN5VRN58kt6ahSS9UZlGQ7NQDmN+/Ka8mXR8S2mrdnVDlN3aVcji3Hsr0jcSZzZklc3mz3GklI3RgICipEuCg4FwIg9ZYiWVAoxdRjwY8pG3pL1w4yMfj5+7jqlVqfNOb9o8pFR562CJu0Gj1LWJtHzhFix4NvyajhG4DcfZwq8eUNBON4zzvsD6XkESKuI6mQeV4f1bDoURxGQvpOej+58rfoowJ3nVGIBJog1Y0fUwVsApEbQFPxQS5QgQ3H43JO+XYDMkiDDMSFwuuCAfbCH3F+EdhQrQCzmYtdelMl5Zl7gCMlDYoBqwAoBNJhtx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=JdwkPXUuubAuSa0ySMfiTc6CufsicLIGcUgSRZaUwMkjWjNydJb0FraiL1jBOXrDVeQyk1ze553k+EB51El2UJb3svvRe4RKx0hmsxeIZUKSpw3BGq+evgN5HXkQsqGSuC0FSiDMOtoLXAGvTaXyBjdBqYj/kwtL8qQaTQUiLpEEM1PVgLhD4kBk9SzXZa3lcJrQWfXFaE5yKIudY8ssOLJd17aDVqAC0YBTtjAxEFsTCosyw8iuRa0ZFL3w8b1J2lGRsibIihGgho3wjly+CzbLS58iE320EJoYYhiRCIHu/MD1J9Rl4p1TH9tfAD5VF3t4im12vKhbJ1C710vfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=J5y3FARUpCrEkffCKfWFRnSzaOlRuk5nCeJg+2L1t2FGfl7ZTtNowciSJx9wHthtM1Q49dS3o81Jw4TfrK1luJn9OBGXHFovmfi/iFmCHC8/N44TJ9FSdUsXLHe45cwLiNcHP//J2yOJK8YpQsMgg4zGt9mPvXrtdsYcrdNnFIA=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by SN4PR13MB5678.namprd13.prod.outlook.com (2603:10b6:806:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:17:08 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:17:07 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v4 3/4] dim: introduce a specific dim profile for better latency
Date: Fri,  5 Apr 2024 10:15:46 +0200
Message-Id: <20240405081547.20676-4-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405081547.20676-1-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|SN4PR13MB5678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	23kCdEU78b2RPmztDvFuKkgPFS3QH9He5CF/YGvl2VAquBOJy7HSc6k9DHP88OGaZHsqlVAoisDbg2+yGGGjOivWve+vIt4zuFJQkqMKqZgdOTDmSa46ecGfHankrhW0TUwhEQKfOBOYtUJcNS9F1RW7Q2Iie+I3sSN4RTZiwK5SESAx0KxW49q+C2nrrB/ebTyEAPWMu5ubO3G+vvLR6LJ2trRbU9CO0IErQwrkkKWzb9mxqDmBRHK1VaDktOr6yiNrKOK+i6LrLL2iusuAKYJ9Gl9zmVgfufvJEccI+Wxlf1VOhRROam0SeoJpRAGcrd9wrZea7PnrOa4yHT7FKLi/AF27Sfq7Uy/d5LR9Lm15KRTbwf5LOCjNAR9qv3y9a7WtxS3ZlKSKf9rn1tMqImxLzi4um9nmY5wtNRPl6cv7BBv0hb/+nOkljtaeoKlTxlsuyvetZjb4qoq0exTLFj5T24VHqbRId6LaAZG6fzrdhygfnN4Q4xLNOfKMS4eiIRh/iq31e5F7FruUHkgoBrT/HGuqVjjL0MxySRx5veo38NpLLkFdspwypz+ZIy8xGzBIy4Nofy8wU5QE3/b0+FZKpgNd2xONYEJLzU3dsLXMJ12kIzclE/8246yhYCupbe2Y8pfkiIf0yZagTagkQBZwqv5lwWP+HRloJRD4ybgPovFX2419BebvI48ZeWUJl/kO3FYMfKMeOZPxa9/AMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6L5lAV80kgEGQtF7Gsp8SSy/mRhja4E3sAGd/1UINW+psz2SJl2+pwXT2CSF?=
 =?us-ascii?Q?qDNZYhTVITqPXbMWlOKhBwq3qOoP4gzTU16OL3X7B7e3oTlUd5C0zHp0nM64?=
 =?us-ascii?Q?ukXhI4gN9Cs9JV60LWj2DJ/nD3HSg/DU7VfpWqgIhtCgOZ7p6sfQvN3WQxeH?=
 =?us-ascii?Q?Jc68FuQ3qVsMFBZZfPn7QyZhixiesmag/8klwMXYXobAnvVwYuj6Qrcn+gcg?=
 =?us-ascii?Q?P62pLyG83Ph4vWnG33WdsQaV4CDNclnJqB/5NbvrZI03v01ngHwcPXRDNiDi?=
 =?us-ascii?Q?bmzJD0gyFCGv4X+2Jfsn1EvZjayFMkpsdO+S87UgoYkaJWp1GRIlo8BPvCbC?=
 =?us-ascii?Q?XivK7Zk5pYo10e/H24Kr9xuoXw2mCrCy+poxqUXW+MKck+Sn6x8FY0lIQQmS?=
 =?us-ascii?Q?TGxs/JiNR6d2fw+T1BQznvIKQQHiR1/5F5UDIlTFNXsxR+vWGQftrdUeXUX5?=
 =?us-ascii?Q?wr76gwNLUHQgNDLNvauAQJE972lWIEe4BEi4MOSMQNgeyy+NGYDB+uWWXzZ/?=
 =?us-ascii?Q?CqnfSm150HbpfMp7MYNA8RyLU+2f5wfVtHkUfw1nD6++dWmxY7knai2RjePm?=
 =?us-ascii?Q?nnK4WpfyRuGywMJEuT6SKg5zWAzZAMBvHoXDLiWhQ8+5INOc9nchB4Gc/sJr?=
 =?us-ascii?Q?iyzMD3hXOIk2fDTpjf49RhxQSfOIR/w60nqjgTpDXFpre3k14HFad+qH9pa6?=
 =?us-ascii?Q?UdRryuJ5SvIxsXrKSo/AE7iHvLgWpCHbSFgy8ns3Qlv7DqfEplConGDWucfD?=
 =?us-ascii?Q?65cKG6Dpdui70C5LRPgUSl6AWOX+xfmkHDDXWbFRotIkfIcCfchSTzBzbjSQ?=
 =?us-ascii?Q?A9U0Ohcvj4LdYgw/x5F7mO8vR5h57pNVUGZjP6Uq6aqrS5KfH3uNDkS29NNH?=
 =?us-ascii?Q?Rz2TlkWGX9tST+PmDxfBovXOXjl0NR1Qigg8WPQZ1+Rc2SvzMyzTYiLWy1ct?=
 =?us-ascii?Q?xKYlKWUJNZINvNdKrr+CzHzk9F8m5FUlkgldvS2X6vkuNa9stI1yWZY03Dy6?=
 =?us-ascii?Q?hw/llYUn5WliPS/cOdlBxamlW2J4kInLRseKgnQLDltwKdwYWpoukpeLhRWK?=
 =?us-ascii?Q?2BMqVvs0SvA9eh+YYCfFlporRLNMGKznuUB/FP0DzNyaW5X+dG8FkX4CD8Zi?=
 =?us-ascii?Q?4WrdDbPBMqq3LqTKF2xarrQDwZEH7FylCoKmWQo4gGmqxbdoGKpe4vmpSzzh?=
 =?us-ascii?Q?lYXSl33q02/31/I7WgpKSbuRUxf4R1A3S8Y0dXizoxBG0KnqBXKpnRhkLY7D?=
 =?us-ascii?Q?UoQsOVUYL7l6lOZuuyw74pcVk0CpUvTHJEhsrACV9z2UUoqzjoBLBJDW0WAY?=
 =?us-ascii?Q?HWCP1bws0N+rQY5k2DXNTb5byw+JwaejuUVNDn2LNkaDsG5Xo8mOv62HfxvQ?=
 =?us-ascii?Q?9x67z2fZjamzLsoKDuUiwOHYc98KimVEnO4OhDnV9sDYGCsffo0N2DTxS09X?=
 =?us-ascii?Q?r/ps9UYZGiTiPmP3BztqM1nmppGDKDCfdWalsBiD/54xOsWle4SQ55BlaKkD?=
 =?us-ascii?Q?Phvoay873sISfRowwrZzT4D+pWO2m3jEX0iCTl58agzh3Nxl04F/YeVUXfJr?=
 =?us-ascii?Q?qD84GdH9fhtgtF++l6uO/yztk/gJm81TZiWHE3Yv3kyLfETJtzrutyN/+4M2?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a838a43-253d-4909-6e40-08dc5548c8fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:17:07.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2dPQyqa3Xpg8YT2LWHtaC+USZ69/OHZhtXus6Ga3jKMOdb/NgGI+zFn2vuS8BtCZAVKoIWk314dsUozNuaRPjxBGTYSYEX3XAZJyF3SZ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5678

From: Fei Qin <fei.qin@corigine.com>

The current profile is not well-adaptive to NFP NICs in
terms of latency, so introduce a specific profile for better
latency.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 include/linux/dim.h |  2 ++
 lib/dim/net_dim.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..edd6d7bceb28 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -119,11 +119,13 @@ struct dim {
  *
  * @DIM_CQ_PERIOD_MODE_START_FROM_EQE: Start counting from EQE
  * @DIM_CQ_PERIOD_MODE_START_FROM_CQE: Start counting from CQE (implies timer reset)
+ * @DIM_CQ_PERIOD_MODE_SPECIFIC_0: Specific mode to improve latency
  * @DIM_CQ_PERIOD_NUM_MODES: Number of modes
  */
 enum dim_cq_period_mode {
 	DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
 	DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
+	DIM_CQ_PERIOD_MODE_SPECIFIC_0 = 0x2,
 	DIM_CQ_PERIOD_NUM_MODES
 };
 
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7aaac86..2b5dccb6242c 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -33,6 +33,14 @@
 	{.usec = 64, .pkts = 64,}               \
 }
 
+#define NET_DIM_RX_SPECIFIC_0_PROFILES { \
+	{.usec = 0,   .pkts = 1,},   \
+	{.usec = 4,   .pkts = 32,},  \
+	{.usec = 64,  .pkts = 64,},  \
+	{.usec = 128, .pkts = 256,}, \
+	{.usec = 256, .pkts = 256,}  \
+}
+
 #define NET_DIM_TX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
@@ -49,16 +57,26 @@
 	{.usec = 64, .pkts = 32,}   \
 }
 
+#define NET_DIM_TX_SPECIFIC_0_PROFILES { \
+	{.usec = 0,   .pkts = 1,},   \
+	{.usec = 4,   .pkts = 16,},  \
+	{.usec = 32,  .pkts = 64,},  \
+	{.usec = 64,  .pkts = 128,}, \
+	{.usec = 128, .pkts = 128,}  \
+}
+
 static const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
+	NET_DIM_RX_SPECIFIC_0_PROFILES,
 };
 
 static const struct dim_cq_moder
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
+	NET_DIM_TX_SPECIFIC_0_PROFILES,
 };
 
 struct dim_cq_moder
-- 
2.34.1


