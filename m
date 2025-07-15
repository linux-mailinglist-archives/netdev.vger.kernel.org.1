Return-Path: <netdev+bounces-207111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82851B05CC4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E0C1C242AE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB92E3B1A;
	Tue, 15 Jul 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SRIAaGV/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F4263F52
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586125; cv=fail; b=Bv3506+jB8HMZ1trZ3bwZIafIJIqj6yVDZLLZrVLJ0ucOPWnf0m9+65SEdbp6iSOZrFzpAnY1ANZYWbIXH1cF5cLxtDFQAuxGqfUFctl4iMI4kvK1qRxEdY9IHvEjY3D3Ijoi/136SKvcO2VUn24rholDCLbVgFKuToB57fVAtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586125; c=relaxed/simple;
	bh=rrCO74zJyeGRJhiVzeoidRvXYiuPrNNQ+ZITXNanpaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=By/MRBeBJyv0NAbxB+miCpljx7XPNjRyfVd+GSvcRxZtDXB4YDaf0NVYHWu/r8KtkkF23nAsGv3GPEwLjE/Sseas0FQAW2sQTiQyNKfJkqkYgm4IDUyHAA1u/gASCghiNRxq+hSAL7UrFMQQzum4KL+iveNtTgCCiDTLyETKlmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRIAaGV/; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECN6rCtftRhw9xEfQ9cqh2ALzRh5LQgZoYW7uLw9JfhQHARvNJkDue+Iv+n10Pk9IzF8M2pk9E+DSGFra22KAIadaxemCOxhSgdIvHAG0L3C2XgDwlNHckBHbwoiBXyb8S4CVafp632CqiX144svS/CpGXSbGGGU6T0I4c/jvE+ryYeAP4ZJFKN2XOI0gdoL+0neKHlxVMJK9O9QVEhV2VVnq1bn7DmIrI0nRHiDeNddjuzAoSbE/oMj6A1i4a5wrkn2zUDoM137651TxbKH65HsGjwEJIJ/hHT6gUAiVQnNF0OuEdOvsUjK663zXt0yAJmiSY608xaJvPVwp1KMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlLpGdVYIRN+U4jMtUb39hIVs6XqmD2Iug+NnICEYdA=;
 b=FMbtomL+o38V+ihJH/4/mFJNut+Cxa5WbVB/wFYONdGCYFk+KaAXUE1yuBDCSLXCE8EXvrS1XG9mv49TJtc/Zcv2VhGLKGTPv5vjF9FAq3Qqhk3nTTKxL09xElgHaqoJWwwQJ6wlw4J5vhbza+MHGP6BgLuUS1zEk+YvqplKjsTOrZsvx74F0gePHYFHNDFj4IGBSIm8c4IP8WtrDZ0MApv+ZVXbkeXSBzQoF13X7eQbyt4tSGrxg2ZrjbvQv33BsFEjzgfHJAbo2rIKKms7CHpmAInu6Q1dRyPECS0wMIEawL3tWQE6NKkqzTdkXX2EryqbR0LoYdmeQLFdXEqS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlLpGdVYIRN+U4jMtUb39hIVs6XqmD2Iug+NnICEYdA=;
 b=SRIAaGV/pEoXnphLjkeNzhPXIurrh0qcDqBRqO+U2DtF+9gO2NQliAESYPi010kZ0s3TmS/jOs15OHZHXsVftN8SPf4FdBDOhVBR3rjzRf2dGUu9bXmMEDRtArq9VG7dfF8FkhooHo2JNGItmrK6qs+o2fBLMwyqufE7diU1FV3C3SXnQFFMYFQR9Pc1CdMGtKj7tduUzH+jLW1TYRYcUR0EzUCU7m32arnoNYMY0uHDuyftJWL5C11hFiqFPS7T1vp5M4eTxWpFqXH4QB5xGym5V47jnon7UT6tw0WourkxkHvImC6pKSJCx2Cy4b0WckI5AOAj30oKKEG/RO1/mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:28:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:39 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 07/20] nvme-tcp: RX DDGST offload
Date: Tue, 15 Jul 2025 13:27:36 +0000
Message-Id: <20250715132750.9619-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: cb983af7-43b6-4764-ece8-08ddc3a38296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GGgftNUcwLQCFk6oNwC1nq50YRIcn/aloHV7o1RUZxqsb6Xb9v8ZNzGwbxsr?=
 =?us-ascii?Q?gvqT2f+asoduvVawvwmLSAgD87lthzThhfWXyweEVQt8dwlmQ2ej3xJFRBBe?=
 =?us-ascii?Q?rsTW2Ql9XbGV52RPV3k3kDocNkFibFv/OT447bEVZHLEu1+rtJNiw6Qdl5/M?=
 =?us-ascii?Q?My2XBYZEvuU5/dd7f72dx7Z9xLikFU5ezNikyEBI/nqQxz8mwqxj2yy7LjqR?=
 =?us-ascii?Q?S733SrxyRebKFHQh3yDV8mfGoYZiI0dQgqAoADOBW5R+StkdBbjwx4x2QE5Q?=
 =?us-ascii?Q?+bT6weknPILtc3V8F0vAQKmyj1T8ibXn3A/VyFbEAHY4eFMUDBNoLPYrlrPM?=
 =?us-ascii?Q?XpGgkhjhQLncLpLwg1dL8HVD0hiL1G4Y2V6KcK3NhX/zxlCMY5q+hIkgOXdF?=
 =?us-ascii?Q?nTOiLcFOlMF0xCuING3TWBW3BPabYXrIp6oVXeIn9+MYStHSXhIV158Um83Z?=
 =?us-ascii?Q?vyUpKwTJuppYJPTT9hn46vnIf1HpX3aI+EItgL4GIsgx6Utif1VstD9TzG/1?=
 =?us-ascii?Q?MQxWdrBWWdZqOJBk0dPigWwyjGgkJ5txKdU4qdnsoqdR2sTKuav4eiF7a2Ow?=
 =?us-ascii?Q?I1khc616Cgk6O8XZmD3wWcTZxc88xXgkXKBZVO38dTuJtBkydZhjBx+ZsS1d?=
 =?us-ascii?Q?dBqPmJKbyvEs5YYHGbva9umeuMuC0ylApuuxLViNdi2+pfF9gGehZ/lszwuM?=
 =?us-ascii?Q?p4d7WeEs1J6KTUTdaoQHYbOtUnImNJOUxYpYqFCexA6s9OGnMi05xBqHTVHP?=
 =?us-ascii?Q?acxaUi4iDfCDqaCjBKo2kqNKlyvCOmqXQyAGewTFGConXFqEu/HIQZjyzf9i?=
 =?us-ascii?Q?NUjOCD5wtKpKU7Bg0T4NvlDgfTZq0oMPvBiuc/4VLpd5t4W3BdMGDx3MTJ0x?=
 =?us-ascii?Q?yRn+XYvDx4QO/4vfuXNI45YM14Ld6vh5PCJWd5QE1ipIEFV5vIaNv0CNOVlR?=
 =?us-ascii?Q?v1DceAXY4C872P2XbpFtlHNkEGu7noEg4WcXrmq6K07EZ/cQiiZipCRIQKDF?=
 =?us-ascii?Q?rMj78WA9KG89x405GTgs0uRq6Afi26nDoTAw4ZvTK7fD3y4GETrFOI1jRz5x?=
 =?us-ascii?Q?nCUudi9qR++ylAirRQAAdX9jcEIu+G3PIBGQTdtITqvrigjYwkvnS0nIXRbM?=
 =?us-ascii?Q?xeBeGShf0K8aL0BtDJKof/LMLiFPeVLwAgB9BlfuZRSym97wkGMXYOoW6kpC?=
 =?us-ascii?Q?Gt0vqJxbp+11iUft98+yAqOz2mW4olsPdEPaKPk9ytCq8N/mCkt64l+ZmZs4?=
 =?us-ascii?Q?1SAOV0H1PbVGS3CpemRi5ieXU4n8d4VkcFJCZVEKxLbNwLnmIKHJApuYKLwZ?=
 =?us-ascii?Q?2V5eWlU93uu3OMC42RvgatGb2/jeX7V4HFrs+z2LXCnjdORk8imJ1waVNKQ0?=
 =?us-ascii?Q?kzalPoFchKCXk2wQk+yBrDFOwE501w6Gb2RY0gDkR1L33lXKUZrBSFBtZSxv?=
 =?us-ascii?Q?FstNzqd2/Zs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njfRmRXf106LqxuNkEhTrj2vkYNOmUY+/VyDN3Ej5RceuEbfsJntQAimEJAN?=
 =?us-ascii?Q?XFRAt5aVQ8j4nw6k/VmIQ4DHz/K7TCNfS/D/5VPQOTAsIzz5ciC6AL0/PKYr?=
 =?us-ascii?Q?zI1juOZs5DaCSMNn7VH3t6cqrjrCeVqHttb2E0exU9aZ8Qnfhj7/y10cxXTq?=
 =?us-ascii?Q?dmJyuWFcsfy6w1BU9KXmYCY+Q01q0v7gTN0MuMiV3D5oZ/SjT2+wt4UlfLqe?=
 =?us-ascii?Q?Njkdt6oV0DA/58LRlOBnSgmX8RLidGV3NItxeq0NPwrz23HvBUWh+jfagkpC?=
 =?us-ascii?Q?p91hYKkvqPvbhe5CormL108TKz2s417o8X8uTmlibGIs49Rnn6G6ZV670ZR2?=
 =?us-ascii?Q?icpC1G4AXx3bF6lIixKIYTKur7/ZjLxDMho4BNj2cV89Q1RIn6SV6hddFm91?=
 =?us-ascii?Q?89kUBoTLiOugS5+6mdKTMzfyrmnAYdCZmI3ll5V2XRiBx9d6L461ewAFuvXG?=
 =?us-ascii?Q?4ZJU/vOBdMIH9FjOQ+9b7r9TyqOged53PMqAh2u7Klmv1Wn/gLUQHVtVJ4AP?=
 =?us-ascii?Q?PbhVMfDbb0Nkrzgu2km5JLlG0k6Pe4wLD1GiBBoXUmVqxQ+JNB1XDuXkH9NV?=
 =?us-ascii?Q?SrqGOEXhGvQH6hXnNir1aXxS1q2jxUOHvw9tlIM1Yo/xrYRXb/NWpkLmRLt0?=
 =?us-ascii?Q?w4giEV5JAGhzpd606R3xy7DP4X2zd4FztEz0/sAdx8rvsZvk7Df3mjWgA/T4?=
 =?us-ascii?Q?1SdISIK957qFi5vtDPngzlCO0zm8VfZwtolk30qokIF6HtSwFxVS+ssMD3cQ?=
 =?us-ascii?Q?hovNQ8KvGzYICcSDMyaK9ymv3cNfSEYZitFiJCzJXmudRrzznwH3+RXjVMJ2?=
 =?us-ascii?Q?ZevPk1JU3+tSjgnp5blz5Tq0yX+PQdHVpxX3KNxaOQGTw/ZlBPNx3WxZvXAv?=
 =?us-ascii?Q?SB++dAxwnsvbt02QF5wU2j8gyNE4XodPPS8Ro7bFz6+RV9+tMd04+u5Pd7tj?=
 =?us-ascii?Q?N9EUofQ1XJc9iRvXbTQBTRH/GdMGyx1NXEBKPwHll648xqWsCihRXzwounyo?=
 =?us-ascii?Q?5wNe5JtrT1/XQWGe5TU4D+5QNx/xl3xlauEZkbAcoFniXimgMP0NrKrqu2//?=
 =?us-ascii?Q?mkYbW/zg0EbgLwC5D5z5m9F4lX3IJMXgP9YZ4A3tyx1pWrTKmTeLPjRjL6IE?=
 =?us-ascii?Q?ZkiSkPXOOJfn3FOFxLXYoZW4Ehn4QwUGm16+VcO9cHBaogpN22Mjw+E7kONt?=
 =?us-ascii?Q?NojyOZp6FjYxn/0jGE9GKh4pH/6uMsBglA+1kw/nLKI7t/OwBOnXf6OY91dr?=
 =?us-ascii?Q?N7GFjfe+u6HJibVIUJJpeKKVm0fOT7WeIIIavvu38l8UO+d/3QX9yY0Fs8MT?=
 =?us-ascii?Q?GSFjsKflbidTHHcNpabI5uJqYHVi9meP0cNdJF0SrVbOckXjX/Ts0LgtyaC/?=
 =?us-ascii?Q?sAHO0jItp7kImR9g4d0MFfIR9J0yzpQzR3nilsLYes4nzzoXo4TxlzvogGFW?=
 =?us-ascii?Q?gnOLluctyiO5H35rPClc9JO4xuTjKvIGDlLHoNshcHiJBhz6muO7uFYL/F4T?=
 =?us-ascii?Q?B9HRXQM867aNWLvPwkdRAyhYtDh56KVGednawW7gZ/pwETw3YVfBuPqzb2jU?=
 =?us-ascii?Q?4P7951r7fjUAEZVhjAdv7slF+IkQoYGgGQeUp4Az?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb983af7-43b6-4764-ece8-08ddc3a38296
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:39.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af9NeXreHbCR3TjfU8dSIwKu+jZany715dy/rUncwzARaJVSIITiZLFnWM8asF7cuu2VioRV20GtYEZYkem9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 117 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5ad71185f62f..efea6d782d8a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -152,6 +152,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_OFF_DDP	= 4,
+	NVME_TCP_Q_OFF_DDGST_RX = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -189,6 +190,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -378,6 +380,13 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#define NVME_TCP_CRC_SEED (~0)
+
+static inline __le32 nvme_tcp_ddgst_final(u32 crc)
+{
+	return cpu_to_le32(~crc);
+}
+
 #ifdef CONFIG_ULP_DDP
 
 static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
@@ -433,6 +442,55 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+	struct scatterlist *sg;
+	u32 crc;
+	int i;
+
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload but DDP was skipped
+		 * because it's under the min IO threshold then the
+		 * request won't have an SGL, so we need to make it
+		 * here
+		 */
+		if (nvme_tcp_ddp_alloc_sgl(req, rq))
+			return;
+	}
+
+	crc = NVME_TCP_CRC_SEED;
+	for_each_sg(req->ddp.sg_table.sgl, sg, req->ddp.sg_table.nents, i) {
+		void *vaddr = kmap_local_page(sg_page(sg));
+
+		crc = crc32c(crc, vaddr + sg->offset, sg->length);
+		kunmap_local(vaddr);
+	}
+
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+
+	*ddgst = nvme_tcp_ddgst_final(crc);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -521,6 +579,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -528,6 +590,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
 		       &queue->ctrl->netdev_ddp_tracker,
 		       queue->sock->sk);
@@ -638,6 +701,19 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -762,8 +838,6 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 	return req;
 }
 
-#define NVME_TCP_CRC_SEED (~0)
-
 static inline void nvme_tcp_ddgst_update(u32 *crcp,
 		struct page *page, size_t off, size_t len)
 {
@@ -781,11 +855,6 @@ static inline void nvme_tcp_ddgst_update(u32 *crcp,
 	}
 }
 
-static inline __le32 nvme_tcp_ddgst_final(u32 crc)
-{
-	return cpu_to_le32(~crc);
-}
-
 static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
 {
 	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
@@ -912,6 +981,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1245,6 +1317,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1273,7 +1348,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_crc32c_datagram_iter(skb, *offset,
 				&req->iter, recv_len, &queue->rcv_crc);
 		else
@@ -1315,8 +1391,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1327,9 +1406,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto ddgst_valid;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(rq, &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1340,9 +1434,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+ddgst_valid:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


