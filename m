Return-Path: <netdev+bounces-28106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2AE77E3E9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8394281B05
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C815ADD;
	Wed, 16 Aug 2023 14:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9B15ADB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC17E2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhGVP2K7qW19hR9P9IBCJMTYzEgiANA2ttRMIIxcUL19yDYwTSXlmJQwOMF2FigJaL5TQVwvGH7laTBaHPPMr4BclaBOD5nS5IebUv10SjCeSO5wj/oiutJjtqhioYKnUAfsvhmOyIV22yUEBxZLBfJfYhpFFkdMVgIXv33wMVNFpJ94jdghhotwRD+yB/KjmW6ArbeVqupKOr3XlXnvf1UxvHqIVx8Lt4fxp0nkKNgPV4WfOIzVxSQpVkgOJYCPKkhKI4YCcBULQn7yPq2i5kWSH60+uxaECBL2p+WvbcF/fEQZ3j+RXJPycm1P5c+C/kowu5ohi+cfskUH+B5leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sCbGh+9x4dpbOD+eyONtMkfEGH4E1zjjEigSmOSLPM=;
 b=anIFKhHJ1IRIpWnRHaIvQDLAb5XScGx39bPjrL0KnulwsJBdGKF8LKTTv1/YXBAtNbJTU/gD1rvQpWXXBk5AxJFU8OopNt8QO9X1Tq6kZiJPkFOo3bE9+Dq+dj5HX9pYQTYHiv0jmjjIbt5qZpxz4mBhjnnGe4KdIqgWr6fBNPvfAmogVYOStMhLQm4X+xrt+3E3qL6Mic3TmYPTj/XWkkUp0JJRnwBBOdh7y1c7ferKaQ40r9uzVtsAXOzSvqN3z/e1xvKvV4PHieuRnLZWYAXdRRMUTz0/jWOfbIeB1MrJXb22cuaX3GC47HvIPW2WbbPZg4CyUBHAsFZGBX+kIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sCbGh+9x4dpbOD+eyONtMkfEGH4E1zjjEigSmOSLPM=;
 b=Pos9JlGL9x4d5+Zw1ewXCbXf8d7juAX7VAaVfNCxCS2Ezru/3cLhR/1BTS5QCCg4PsS0zGoc0ENRqF5H+fREUPjGRAXGvDDMf7Mrd++RnCq4y+QYiZ+kTq7UgtBnIFB9alsqQ0pR0QI1rxf0fx8SNAcmED/g+wEmxqg94w40s7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 SJ0PR13MB5451.namprd13.prod.outlook.com (2603:10b6:a03:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:40:15 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:14 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 06/13] nfp: introduce keepalive mechanism for multi-PF setup
Date: Wed, 16 Aug 2023 16:39:05 +0200
Message-Id: <20230816143912.34540-7-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|SJ0PR13MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: aebdb5e0-28a0-4252-7a52-08db9e66b393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	45BBWQeRleKKrDMXlISP+vreoDKD6PY2XM2FTL03+NOwbvuYD2Ey834AojaNxVEGRLMb7tG0AHEvR4kuQ7IlZ+QBl+oYfpUrLlX1YXmIzAd8GWtqZ+fZGJQRFqBfEa+++VfG0K+mfV12o7fgfDZsVd1Ca8WewrpDJGgeRvicfQqX5HmKtq7DL6PkS+vq9280iJxcoehYFAX3wK9NqAkJ+UMKD6usKP9VdSZtDh0ZiN3Yqv3IJTZRJzy0yK+yZNXaQ1+k50zeK9/JCd2DZZl5P7yKWE1VugxQ2X+4XDMR2ayID5zyaRvDpufsAaH37TcISnhCY7IuEt5mEgaDYOYj9qkkebwemL5+liNTQwu+Lm8YF2rDjA/CMVfvC86fHFROXdv/68nJ9bDSCi2qb/qUQwZh3p3ffKjqoE+TSRH6Rdxoe7QoogEx7lDN4iTZDYIJWIhQQZpFvW7y3nWeR8sM8pEoYWZBojrwKpf6jZCfrTgf/t6pE7HUJyOtxDHjsclSvqqZiRAIYisF62VWUYCQTcJ397wfJSv2o2EWawTPxNSM7L3VRNKu/+dcuT92MfKnst1UyXvNiX15Bi2YceeCykUPYYfia3eEEIxdUn2p2k4Ts0B7y9oE7ONeL40aKE8JNq/OTwEKGnAAnQ+v3kc15ou/Rlk/nzECVI2pjrsOZBhh/vV8o5vvoBF83wjZi0sH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlwSDZBb0cxOVEvcUtaaVBMKzBPUWpaMUtVMXA1NEg0eGhCdUR5N0JRc3ZV?=
 =?utf-8?B?Y0ZjaURiREZEanBJQjZ0d0E0NjF2bVJ2VjU3cFFLdEJvWUR5TXlRcXhYY3M0?=
 =?utf-8?B?T2tqaDZtZTRhckMxYTk4V0R6d083b3d6ZXVka0k0Sit2cHdOOHVUdnJhVnRN?=
 =?utf-8?B?MjFxZXIxQ0g2aHZLSThZVUxXd2RpUUZlNW1sTis4ZXgrMFIxdnp6TEQ1Yzdn?=
 =?utf-8?B?YjlWQW93OXoxUmQyMEJoTmFjN2Z6c2xqMFlDY2FWMEhESElqekhneUhBSysw?=
 =?utf-8?B?b0oxL1NvVGJqYTlpREVncW42Z1E1b3BNSGRic1diVWhrNVpZREJWang3RnRU?=
 =?utf-8?B?WUpqazRyYnJyd1ZTWEZCMmZlTUthUk1ubk1zckJJR1FwcEtpR1hKRUp6SVUz?=
 =?utf-8?B?dS9lVUV0NWpTVUMzWGkzT0tFbVVDZU9DZitCbFA4ajczN0hpdFMyVkJkVFNm?=
 =?utf-8?B?dFowYk1YZHgrWkJSRHpjT0tYRm9CMTF3RkJpMWMrdHhqdEtSRWdhNlhDd3l2?=
 =?utf-8?B?YkR5NnNHK1BtUzRuaFhXN1Fnd3RTb3ZBOWE3WnJONzRSUlBkMW5mV0dQS0Rj?=
 =?utf-8?B?SXRQaWlBam13K2hnQjFWTHZDWCs5U21Sd0YrWFZqYXFvTWdqNkYzbGhSUmwz?=
 =?utf-8?B?N3FQUEN3TmpmN05mTDdZUTA3NHhVTmk5YjBhOTZnWFdwN2JQeDJnZldsbFA5?=
 =?utf-8?B?dytTak1RUG5mUFlDWFFuNUFjVFB3QW8veWkzbFJvSkRPNno1dnhndUZVWitx?=
 =?utf-8?B?VlI2YjZsN3p1Ykd5UUpRWHJGNE1UWjhYaXFpRDI3NWRzTHR6aDE1Q0FjVHZL?=
 =?utf-8?B?VXMvSlkvWkdseXpITlpLQlRPc3Z1R1hVNVZmUWlqSlNBdVNLcnU0WFhXRjJL?=
 =?utf-8?B?RXlua1NaU1NCZmdUbXQ1UmRUZTVzVkQ3QzR2WkUrKzEvSk9rRzV4ai9WazdZ?=
 =?utf-8?B?Zzd5UjVwMGxNams3VDlmdURVN2IxaFVqZnhWWnNjaE5BMUU1c05OV0lIUmhT?=
 =?utf-8?B?cGNXUGxaYTlKb21obmN1OXdxSGZyN2Q4VG9TM1VQN0Q2VDhDWjNnL0xxYXJs?=
 =?utf-8?B?d0dENkVPVFoxUENrV0hJQlVNK0ZCN2hyVEQzemtyUFVjVVNqeitsWFpIUmxn?=
 =?utf-8?B?WjhPU1dtR3hESTFvOWpqVlJmb2wvMU1MYWtnTHVVNm1PT2FIbjd5V3d6R1ZD?=
 =?utf-8?B?SFZpTHl3bm1uU1pCVEZEVzBvNEErcGNVUnphZE1MeGZPS1F0MEpmdEI3dHpz?=
 =?utf-8?B?a1o2ZDkwanNSR0huaTZwVkptK0VCNmp2a1ZxOWZ0SFV2OEJKTnYwL3NCWGV1?=
 =?utf-8?B?aXZjSjR5QWhEdUFxRzRkbXIrd0x1WEsvN0V3ZCtEVHNlNzQ3MFlxRkdyM1dq?=
 =?utf-8?B?aGNUNTRlcS84UTR2YXhyWWt4aTkwYjRNSEZTS1cvMmUvTmpqOUZIcmdieTZB?=
 =?utf-8?B?eWE4citVb3NsL0hPUFNYMnplNTUzOVNzSWNjVEJFYmFGeEdsbC9sZ0tlWE1t?=
 =?utf-8?B?TmJiWTkyNXU2VkUzVXdBUGJwNVZ2azFYaFZNNml1a3E0ajJMRnNEclJEaWRp?=
 =?utf-8?B?bU8rNUhUM0Z5eU1rUWYrM2RxQ1VFWmorZTJ5VHNYVDZCTUhCTmpxc2hneUJW?=
 =?utf-8?B?WTFXWSsvRWJlVTZMc2xrYmozYklKZzdYY3lENWk3VlF5NkxoTTVMTlFkNEZn?=
 =?utf-8?B?R0JLV2dsK3puMXdCL0E1ajFrdW0rTURtbkxsTW1nbUFJeGR2RHVNc1RieTUy?=
 =?utf-8?B?Y1ZlOXZ6cHlhWnR6T0xEWGNsb0NzNTFqWXg5dnBrRVBZNTRIelVNWDFHcFhJ?=
 =?utf-8?B?ODM2TitBclBZQUEvdmpKTlIrcHdpOGtua0JuSFROZ1p0UUsxaWhpRlFZMXA2?=
 =?utf-8?B?UFNlbDlzYnlNSDdUNW5aQXZreGpxcmJBYWltZGpRd1h3TGJzME1QbmVRbE1q?=
 =?utf-8?B?WEE3QXliQ0dqTFI2MXBkU09keUdHa1NYQlpxcTB6ano2Sy8vQmdzWWtxZzJY?=
 =?utf-8?B?L2QyRUlIT0hHT0ptbEFaNkdCaldQZDhuaHNxSUxiL0N1bUV6dFA2am1GWmxE?=
 =?utf-8?B?d2hyU2tpZHRSN2xGYTJxOVVaRzhsYUVtYUoxclNkdkkzNEJ3VFUvdmF3RWVB?=
 =?utf-8?B?NUUwR0FiY0hiZzRocER3Ni9hb0NJMnFMdFVMV1h3MVlrTmdxNXo4L2pVVXJ6?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebdb5e0-28a0-4252-7a52-08db9e66b393
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:14.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+MmUOSfFoQEf2ijpioSnrnA6YYHr5ReQc7CVEaVGIOnjw//6bfsn76RVRvnhZMSAoCbw1Nt5Mr7+W0Ow14qoDxFjiiVdggBB73NgODEL4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, management firmware is in charge of application
firmware unloading instead of driver by keepalive mechanism.

A new NSP resource area is allocated for keepalive use with name
"nfp.beat". Driver sets the magic number when keepalive is needed
and periodically updates the PF's corresponding qword in "nfp.beat".
Management firmware checks these PFs' qwords to learn whether and
which PFs are alive, and will unload the application firmware if
no PF is running. This only works when magic number is correct.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 88 +++++++++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  8 ++
 .../net/ethernet/netronome/nfp/nfpcore/nfp.h  |  4 +
 3 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 778f21dfbbd5..489113c53596 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -469,6 +469,77 @@ nfp_get_fw_policy_value(struct pci_dev *pdev, struct nfp_nsp *nsp,
 	return err;
 }
 
+static void
+nfp_nsp_beat_timer(struct timer_list *t)
+{
+	struct nfp_pf *pf = from_timer(pf, t, multi_pf.beat_timer);
+	u8 __iomem *addr;
+
+	/* Each PF has corresponding qword to beat:
+	 * offset | usage
+	 *   0    | magic number
+	 *   8    | beat qword of pf0
+	 *   16   | beat qword of pf1
+	 */
+	addr = pf->multi_pf.beat_addr + ((pf->multi_pf.id + 1) << 3);
+	writeq(jiffies, addr);
+	/* Beat once per second. */
+	mod_timer(&pf->multi_pf.beat_timer, jiffies + HZ);
+}
+
+/**
+ * nfp_nsp_keepalive_start() - Start keepalive mechanism if needed
+ * @pf:		NFP PF Device structure
+ *
+ * Return 0 if no error, errno otherwise
+ */
+static int
+nfp_nsp_keepalive_start(struct nfp_pf *pf)
+{
+	struct nfp_resource *res;
+	u8 __iomem *base;
+	int err = 0;
+	u64 addr;
+	u32 cpp;
+
+	if (!pf->multi_pf.en)
+		return 0;
+
+	res = nfp_resource_acquire(pf->cpp, NFP_KEEPALIVE);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	cpp = nfp_resource_cpp_id(res);
+	addr = nfp_resource_address(res);
+
+	/* Allocate a fixed area for keepalive. */
+	base = nfp_cpp_map_area(pf->cpp, "keepalive", cpp, addr,
+				nfp_resource_size(res), &pf->multi_pf.beat_area);
+	if (IS_ERR(base)) {
+		nfp_err(pf->cpp, "Failed to map area for keepalive\n");
+		err = PTR_ERR(base);
+		goto res_release;
+	}
+
+	pf->multi_pf.beat_addr = base;
+	timer_setup(&pf->multi_pf.beat_timer, nfp_nsp_beat_timer, 0);
+	mod_timer(&pf->multi_pf.beat_timer, jiffies);
+
+res_release:
+	nfp_resource_release(res);
+	return err;
+}
+
+static void
+nfp_nsp_keepalive_stop(struct nfp_pf *pf)
+{
+	if (!pf->multi_pf.beat_area)
+		return;
+
+	del_timer_sync(&pf->multi_pf.beat_timer);
+	nfp_cpp_area_release_free(pf->multi_pf.beat_area);
+}
+
 static bool
 nfp_skip_fw_load(struct nfp_pf *pf, struct nfp_nsp *nsp)
 {
@@ -550,6 +621,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
+	err = nfp_nsp_keepalive_start(pf);
+	if (err)
+		return err;
+
 	if (nfp_skip_fw_load(pf, nsp))
 		return 1;
 
@@ -620,6 +695,16 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (fw_loaded && ifcs == 1 && !pf->multi_pf.en)
 		pf->unload_fw_on_remove = true;
 
+	/* Only setting magic number when fw is freshly loaded here. NSP
+	 * won't unload fw when heartbeat stops if the magic number is not
+	 * correct. It's used when firmware is preloaded and shouldn't be
+	 * unloaded when driver exits.
+	 */
+	if (err < 0)
+		nfp_nsp_keepalive_stop(pf);
+	else if (fw_loaded && pf->multi_pf.en)
+		writeq(NFP_KEEPALIVE_MAGIC, pf->multi_pf.beat_addr);
+
 	return err < 0 ? err : fw_loaded;
 }
 
@@ -666,6 +751,7 @@ static int nfp_nsp_init(struct pci_dev *pdev, struct nfp_pf *pf)
 	}
 
 	pf->multi_pf.en = pdev->multifunction;
+	pf->multi_pf.id = PCI_FUNC(pdev->devfn);
 	dev_info(&pdev->dev, "%s-PF detected\n", pf->multi_pf.en ? "Multi" : "Single");
 
 	err = nfp_nsp_wait(nsp);
@@ -913,6 +999,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 err_net_remove:
 	nfp_net_pci_remove(pf);
 err_fw_unload:
+	nfp_nsp_keepalive_stop(pf);
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
 	if (pf->unload_fw_on_remove)
@@ -952,6 +1039,7 @@ static void __nfp_pci_shutdown(struct pci_dev *pdev, bool unload_fw)
 	nfp_net_pci_remove(pf);
 
 	vfree(pf->dumpspec);
+	nfp_nsp_keepalive_stop(pf);
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
 	if (unload_fw && pf->unload_fw_on_remove)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 72ea3b83d313..c58849a332b0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -86,6 +86,10 @@ struct nfp_dumpspec {
  * @num_shared_bufs:	Number of elements in @shared_bufs
  * @multi_pf:		Used in multi-PF setup
  * @multi_pf.en:	True if it's a NIC with multiple PFs
+ * @multi_pf.id:	PF index
+ * @multi_pf.beat_timer:Timer for beat to keepalive
+ * @multi_pf.beat_area:	Pointer to CPP area for beat to keepalive
+ * @multi_pf.beat_addr:	Pointer to mapped beat address used for keepalive
  *
  * Fields which may change after proble are protected by devlink instance lock.
  */
@@ -146,6 +150,10 @@ struct nfp_pf {
 
 	struct {
 		bool en;
+		u8 id;
+		struct timer_list beat_timer;
+		struct nfp_cpp_area *beat_area;
+		u8 __iomem *beat_addr;
 	} multi_pf;
 };
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
index db94b0bddc92..89a131cffc48 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
@@ -64,6 +64,10 @@ int nfp_nsp_read_sensors(struct nfp_nsp *state, unsigned int sensor_mask,
 /* MAC Statistics Accumulator */
 #define NFP_RESOURCE_MAC_STATISTICS	"mac.stat"
 
+/* Keepalive */
+#define NFP_KEEPALIVE			"nfp.beat"
+#define NFP_KEEPALIVE_MAGIC		0x6e66702e62656174ULL /* ASCII of "nfp.beat" */
+
 int nfp_resource_table_init(struct nfp_cpp *cpp);
 
 struct nfp_resource *
-- 
2.34.1


