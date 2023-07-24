Return-Path: <netdev+bounces-20334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DD75F188
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C6D1C20ABE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D87479;
	Mon, 24 Jul 2023 09:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51987F9E5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE930E7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlUsm1RDtm4nn6uIYJqHU3++OCzZS/JkCy4mfV6GwiztaLHWHFnVwWm4VBeC7i0G53TsyFaUoHwnnMec/D+3S9CXYaONd6tnQ32nWMZslHtnTKZumf9ef2YQtCxvsXcnD2oL/nsAai7OPUkfjwlQ8gSTcWL3iB+p9u7hl0DMwofckdQv1fBqEa5KOo5lkYvPoLRDSmsA6xzTGOKF5AMhrnRvQ4VjzO0T39jKVDRiUZhwJL19FVgVUJY4QvxsCH4RM1mgjJMqu406CCtifkrYmBoXCCB8MxloR6t21zJDjKItBeeav5hdZj96cFPSTYnvpjFR9Lw/y8jcXbvrxwL4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW5qAoKKOCJX0LvdrXHIuNMF7UNWYwWcedloEMQCH3s=;
 b=est4TQrDS/V6QaZ+NxSsSmppfRHSKqt1t2nk8HUcx6jn+JZQlS5+95GKycaMZeNhRfo1HtmH3Qt5nlDjwdOxV94/ssenNHv4ZFewddl4181xhc92AA46aK+NfJFGc+USJ6+Acn+4T9hniTvIyI0MW7OqUZYQt5SG9bTW5183WWcAcMR5Sb2gX1FHUniX9Y3Na2iCLWCeStLU7wQ7GmMsEXd9xfiUqM+5MNN4JEQlqe4AH3itkar0EE42uu2vxOKpEpSFbsHm0zW+WgahZyd0hab+/wlxKSxfH7u5ZoRcYVg1lsJx3zOYWoo5SMztinZQpVv2MmO3bmSgDslFlwI6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW5qAoKKOCJX0LvdrXHIuNMF7UNWYwWcedloEMQCH3s=;
 b=k5QilAvVMALMvOVsOcFMc+LLLgu+HTiWOXmjOkATORvuVZ5CrqIPBjuSdekb8NN0R8n9ySCHW3r8WezUux6MJ65xi7C4jebGsZIprYdAb7YzUrlvCdytwP2D+cOvRuPXwYq3oVrjHMhCUrP+zSfPLvkBwuacI4Ne92/8GeAPFx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:33 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:33 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 12/12] nfp: use absolute vf id for multi-PF case
Date: Mon, 24 Jul 2023 11:48:21 +0200
Message-Id: <20230724094821.14295-13-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724094821.14295-1-louis.peens@corigine.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: cdde48fb-617e-4353-3760-08db8c2b48c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJuh7+iP+rnc7RF1sCZchk4L+FBsy7bCF7wnL9r4/FDo0j6uKCrWInaLBYHd571tUSCZl9h+JALXssdX9sJindTvbfvUrJT3JRUdoUsE7bEMMQZOEEEDmiqs1jD2Xc97BjuEau69rLCF6XOFbLKEthxpZy/b5OtqpZi8jPMGxa/d6B2ldgs2yNfClfeCnltT2+cCYvxTb7oGVkFTORODpqnRrlKft8z1v7e4gf8y+i0jAbz/Drrhpx+sj315o3SSc7pHQV1AuZeRC/BWzWZHr7K/XeVupEPV+j+eems5L19aIihpTWqXD+RaRY4GW3QI9ktFf7tmiqAHIE9rDAivwlgRHOGsZ7r+x9lWrm9SmWzJ7CXt7jgLBsV6VJAsA5AETVU6KM6tgEfa9ypypBDVxbBg17Z4LxbIt8T9e/69o/jhrhYTMtaT3aYckHxSCFqu7J2kWbXes001jQuOMePKL7FLaCAYPyu/0kmgnsqs6CUtUAxcl9QJCItxH/wcxJXKQ62A67n/Xid3blnPfia3haa9/clIzwmPgMBn+ri0lsdIi0youvt0fse5h2Qcm6Em21g7EvongkSipFsLv2KxCjHCepBelXGkruBtnF4vAQ7T40Q7WqHcVKPZZGe153M+LuO5IfazUw38LONC3RgtiUFDdk2Leu7cdwz3ynRkeBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFlCS1pRQ25CcjVZQUx1YzlvckExeUlHdVlKUW0zNlNtYXM1N1E3a3EzaEhL?=
 =?utf-8?B?RWRJYUR3VFQ5M1hKN1hCS0FQRlNBblRZOU5RZk9FV0xZK2s3UDdTYUEzcmpZ?=
 =?utf-8?B?SFRmNTJxbVpkcVhBOXBGb0xMekRtdi9yQzVTalQ5cEhpZDVXL1o4b09zRHha?=
 =?utf-8?B?VEUyMFZ1Q1l1alJzL2VnczNrWkdDR2RXK3lVTGJvb1o2RTdvbVdqSW9xNlVG?=
 =?utf-8?B?dXhETkNPSytrUnJPSFBLYTdzYXR4MmxuZkgzcUVxaUxxak9pTHZRcEtucTdp?=
 =?utf-8?B?dVFnRllZdkxUOGlvSzE5MU9XTkJ4SDgzSFFCVlkwWmRGSmZ1di9Yb1pVTXc0?=
 =?utf-8?B?QVVLaHNzMDRBMThHdDBib2J0MjJSS2NvNlcvbDkyMmcwR053ZjNlV1ZxTkVE?=
 =?utf-8?B?bWdydU9ENTJlU3U0SjNVL1lUQVZiMWx2dzdEVWtxQUpKQXZHdHlxT1RnV0hy?=
 =?utf-8?B?c05hdzZPcWxDRkxWYWNhTlpYb0hkU1Q2Y1NGcGdKL2VmS0tEb0hpUE5BdmY0?=
 =?utf-8?B?Z05ET1ZDWWJibTkwOWwyeDl6Q3dzR3QzcnV5S2ZwT0hvRjd4bExVS0ZkMjZ6?=
 =?utf-8?B?ZFVoZVgxNDZDbCtINHZWdjBHZ2M2dHptanJ6ejZTa2lUT2toeDJISU9sUkdh?=
 =?utf-8?B?T3JNa0pMcUltZ2o1QXE5L0RoV3ZuTUU2aHBoMzRncXBHMVhUQ1dnbnVsRkZS?=
 =?utf-8?B?MFhLNGdkTkxReGRBU1Z5aU9mMHpTZ0x3T3FuaXVIZU1KK0ZoYzFvSGxVT2xR?=
 =?utf-8?B?elMzMDNnVmVIR09GUTM4S0pCSXU2NkxBUWQ5V0I1TjlUVFpxSkhIRURIbGk3?=
 =?utf-8?B?UjJWNThwYmk3ZzJpOXRZMkFOVHlJbU1BNDlRNWxPVWZHOW9tVHgza0RXWWE1?=
 =?utf-8?B?aTR4a25FdWxPbkpJZ2d0ZEdQUFRsSUtVREQzRUduRmJmUDA3dmNSTUpxTHhq?=
 =?utf-8?B?SkQ2OHBqK0RzU0ZaUGpwaU5nM1R5MjA2Q2JqYzVBWjVaU0NKZlFydGp3MVVC?=
 =?utf-8?B?SXdoSkttT29EQndFM1VIaks4VGNDb01BQno3ZitXTDZ1Nmh3RU12M081YVlJ?=
 =?utf-8?B?VGpGL3lFUWhlbytQY1BPRmFsQ3BaUzRobFRzVnhFZmEzSHE0OGJrMXpmVlJm?=
 =?utf-8?B?eitWR2JvNDRoUUdwRUYvWWl5LzB1TzdWcVdZQzRxdC9KVDB2OWVJWDV1YkIw?=
 =?utf-8?B?S2kwSFpoZHdqV3hGRVl2Qm51KzNaMm81bGVVMkdhT3NvOGlaZ2pDZkZnZi85?=
 =?utf-8?B?cVJ1dnQzK3BjanhETnBNbkRDWm1ENkhlK2FobmtaWXJjbzNkclU0MGFEMDhN?=
 =?utf-8?B?a0ZJRGhDMGFlK0dmZ0xCS3hIbkFnbWpZV00xeENLRlM3MDZESkRZTGd5dk5J?=
 =?utf-8?B?a0x4dG43bHR2Ykk5Rk9OeHNQOElqK3V6NXBBRHVUTi9oM2ZDMXcwd0prSW1k?=
 =?utf-8?B?Z21MS2ZZWDFOMFlYb1RXL3MwKzdWZ2hESjRvNXRjU2xPV0VIbjE3R2ZWQWdF?=
 =?utf-8?B?SXFlNkl4eGNCeDZ5YUlJVWVHYlZiSFJiYXI3NmVXUklTVTg1Qm9DbEErZDY3?=
 =?utf-8?B?ZVBJNmloNnpuWWRHSTg5YVdDaVZtSkpBVHZNNEhOVDhpT3kyOEROWXFlN3JM?=
 =?utf-8?B?QXpkb05ScnQ0ZGk2bkhFMi94T0VqQzl3VEY3M3pDWm5yWitncUk1TEpGNEt5?=
 =?utf-8?B?M3ljMzMxbFhTMkgwVS9iMEpWcXIvOFR5dW53d1UzSzI5L09VRFhCS2t6ZDhZ?=
 =?utf-8?B?djNWV3ZqT1U4cGVaVjBWWW1PK01YUUhMRFQ4aUkxWElBeFZGSWR1eUx2QWRS?=
 =?utf-8?B?TUpiajZlSUg1L1EraEVQTjJRbVR0VVZ4Yk5NNFVDaDVTejdsMlIydUpES2tO?=
 =?utf-8?B?TWswWVNENW1EUVJsTFB3Qyt1NW5WVkJyREoyWDZXNUNOdXZrRGpXUkFxWHlW?=
 =?utf-8?B?cUxsMGpoMUZEcytBNDR4YTMrUjFEcFhUbmw3TkpXak15WS9WUHpHOXM3Y1Bx?=
 =?utf-8?B?VGZINStaV2pDZWFQcGdkSEZmKzlKTldxNXB2c3BVcW1uOWwzVUl0TWtXelk3?=
 =?utf-8?B?OWRsWE0rYlZPZXN5ckVoR0pVL2VPb2lyWk9rQTVzUXhSNVg3STFkbWhwVm1p?=
 =?utf-8?B?Q3Vxb2ptTnNPbXVoU0IwdWVLWC9OMXRPVVNRTlV4UlA5Vmp5WVN1NEl6TjJD?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdde48fb-617e-4353-3760-08db8c2b48c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:33.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZl0dRW3cOxUSZhtTelfHD6sA1/bw5PN54pPQ51C9BblK09GhrIUJsu7D8GK/MbLWPKH8G25V5iKs3tJwlUJXPjroPMNz8w/d/NqEIRBk64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, absolute VF id is required to configure attributes
for corresponding VF.

Add helper function to map rtsym with specified offset. With PF's first
VF as base offset, we can access `vf_cfg_mem` as before.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c    | 14 +++++++++++---
 drivers/net/ethernet/netronome/nfp/nfp_main.h    |  4 ++++
 .../net/ethernet/netronome/nfp/nfp_net_main.c    | 10 ++++++----
 .../net/ethernet/netronome/nfp/nfp_net_sriov.c   | 14 ++++++++++----
 .../ethernet/netronome/nfp/nfpcore/nfp_nffw.h    |  4 ++++
 .../ethernet/netronome/nfp/nfpcore/nfp_rtsym.c   | 16 ++++++++++++----
 6 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 70e140e7d93b..139499d891c1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -97,14 +97,22 @@ int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 }
 
 u8 __iomem *
-nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
-		 unsigned int min_size, struct nfp_cpp_area **area)
+nfp_pf_map_rtsym_offset(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+			unsigned int offset, unsigned int min_size,
+			struct nfp_cpp_area **area)
 {
 	char pf_symbol[256];
 
 	snprintf(pf_symbol, sizeof(pf_symbol), sym_fmt, nfp_get_pf_id(pf));
 
-	return nfp_rtsym_map(pf->rtbl, pf_symbol, name, min_size, area);
+	return nfp_rtsym_map_offset(pf->rtbl, pf_symbol, name, offset, min_size, area);
+}
+
+u8 __iomem *
+nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+		 unsigned int min_size, struct nfp_cpp_area **area)
+{
+	return nfp_pf_map_rtsym_offset(pf, name, sym_fmt, 0, min_size, area);
 }
 
 /* Callers should hold the devlink instance lock */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index e7f125a3f884..4f1623917c4e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -179,6 +179,10 @@ int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 			       unsigned int default_val);
 int nfp_net_pf_get_app_id(struct nfp_pf *pf);
 u8 __iomem *
+nfp_pf_map_rtsym_offset(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+			unsigned int offset, unsigned int min_size,
+			struct nfp_cpp_area **area);
+u8 __iomem *
 nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
 		 unsigned int min_size, struct nfp_cpp_area **area);
 int nfp_mbox_cmd(struct nfp_pf *pf, u32 cmd, void *in_data, u64 in_length,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index eb7b0ecd65df..f68fd01dac60 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -473,9 +473,10 @@ static int nfp_net_pci_map_mem(struct nfp_pf *pf)
 		}
 	}
 
-	pf->vf_cfg_mem = nfp_pf_map_rtsym(pf, "net.vfcfg", "_pf%d_net_vf_bar",
-					  NFP_NET_CFG_BAR_SZ * pf->limit_vfs,
-					  &pf->vf_cfg_bar);
+	pf->vf_cfg_mem = nfp_pf_map_rtsym_offset(pf, "net.vfcfg", "_pf%d_net_vf_bar",
+						 NFP_NET_CFG_BAR_SZ * pf->multi_pf.vf_fid,
+						 NFP_NET_CFG_BAR_SZ * pf->limit_vfs,
+						 &pf->vf_cfg_bar);
 	if (IS_ERR(pf->vf_cfg_mem)) {
 		if (PTR_ERR(pf->vf_cfg_mem) != -ENOENT) {
 			err = PTR_ERR(pf->vf_cfg_mem);
@@ -484,7 +485,8 @@ static int nfp_net_pci_map_mem(struct nfp_pf *pf)
 		pf->vf_cfg_mem = NULL;
 	}
 
-	min_size = NFP_NET_VF_CFG_SZ * pf->limit_vfs + NFP_NET_VF_CFG_MB_SZ;
+	min_size = NFP_NET_VF_CFG_SZ * (pf->limit_vfs + pf->multi_pf.vf_fid) +
+		   NFP_NET_VF_CFG_MB_SZ;
 	pf->vfcfg_tbl2 = nfp_pf_map_rtsym(pf, "net.vfcfg_tbl2",
 					  "_pf%d_net_vf_cfg2",
 					  min_size, &pf->vfcfg_tbl2_area);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
index f516ba7a429e..67aea9445aa2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
@@ -72,7 +72,7 @@ int nfp_app_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct nfp_app *app = nfp_app_from_netdev(netdev);
 	unsigned int vf_offset;
-	int err;
+	int err, abs_vf;
 
 	err = nfp_net_sriov_check(app, vf, NFP_NET_VF_CFG_MB_CAP_MAC, "mac", true);
 	if (err)
@@ -85,13 +85,14 @@ int nfp_app_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 		return -EINVAL;
 	}
 
+	abs_vf = vf + app->pf->multi_pf.vf_fid;
 	/* Write MAC to VF entry in VF config symbol */
-	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
+	vf_offset = NFP_NET_VF_CFG_MB_SZ + abs_vf * NFP_NET_VF_CFG_SZ;
 	writel(get_unaligned_be32(mac), app->pf->vfcfg_tbl2 + vf_offset);
 	writew(get_unaligned_be16(mac + 4),
 	       app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_MAC_LO);
 
-	err = nfp_net_sriov_update(app, vf, NFP_NET_VF_CFG_MB_UPD_MAC, "MAC");
+	err = nfp_net_sriov_update(app, abs_vf, NFP_NET_VF_CFG_MB_UPD_MAC, "MAC");
 	if (!err)
 		nfp_info(app->pf->cpp,
 			 "MAC %pM set on VF %d, reload the VF driver to make this change effective.\n",
@@ -145,6 +146,7 @@ int nfp_app_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos,
 	if (vlan_tag && is_proto_sup)
 		vlan_tag |= FIELD_PREP(NFP_NET_VF_CFG_VLAN_PROT, ntohs(vlan_proto));
 
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
 	writel(vlan_tag, app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_VLAN);
 
@@ -169,6 +171,7 @@ int nfp_app_set_vf_rate(struct net_device *netdev, int vf,
 		return -EINVAL;
 	}
 
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
 	ratevalue = FIELD_PREP(NFP_NET_VF_CFG_MAX_RATE,
 			       max_tx_rate ? max_tx_rate :
@@ -195,6 +198,7 @@ int nfp_app_set_vf_spoofchk(struct net_device *netdev, int vf, bool enable)
 		return err;
 
 	/* Write spoof check control bit to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -219,6 +223,7 @@ int nfp_app_set_vf_trust(struct net_device *netdev, int vf, bool enable)
 		return err;
 
 	/* Write trust control bit to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -253,6 +258,7 @@ int nfp_app_set_vf_link_state(struct net_device *netdev, int vf,
 	}
 
 	/* Write link state to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -278,7 +284,7 @@ int nfp_app_get_vf_config(struct net_device *netdev, int vf,
 	if (err)
 		return err;
 
-	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
+	vf_offset = NFP_NET_VF_CFG_MB_SZ + (vf + app->pf->multi_pf.vf_fid) * NFP_NET_VF_CFG_SZ;
 
 	mac_hi = readl(app->pf->vfcfg_tbl2 + vf_offset);
 	mac_lo = readw(app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_MAC_LO);
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
index 49a4d3f56b56..4042352f83b0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
@@ -101,6 +101,10 @@ u64 nfp_rtsym_read_le(struct nfp_rtsym_table *rtbl, const char *name,
 int nfp_rtsym_write_le(struct nfp_rtsym_table *rtbl, const char *name,
 		       u64 value);
 u8 __iomem *
+nfp_rtsym_map_offset(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+		     unsigned int offset, unsigned int min_size,
+		     struct nfp_cpp_area **area);
+u8 __iomem *
 nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 	      unsigned int min_size, struct nfp_cpp_area **area);
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
index 2260c2403a83..97a4417a1c1b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
@@ -520,8 +520,9 @@ int nfp_rtsym_write_le(struct nfp_rtsym_table *rtbl, const char *name,
 }
 
 u8 __iomem *
-nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
-	      unsigned int min_size, struct nfp_cpp_area **area)
+nfp_rtsym_map_offset(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+		     unsigned int offset, unsigned int min_size,
+		     struct nfp_cpp_area **area)
 {
 	const struct nfp_rtsym *sym;
 	u8 __iomem *mem;
@@ -540,12 +541,12 @@ nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 		return (u8 __iomem *)ERR_PTR(err);
 	}
 
-	if (sym->size < min_size) {
+	if (sym->size < min_size + offset) {
 		nfp_err(rtbl->cpp, "rtsym '%s': too small\n", name);
 		return (u8 __iomem *)ERR_PTR(-EINVAL);
 	}
 
-	mem = nfp_cpp_map_area(rtbl->cpp, id, cpp_id, addr, sym->size, area);
+	mem = nfp_cpp_map_area(rtbl->cpp, id, cpp_id, addr + offset, sym->size - offset, area);
 	if (IS_ERR(mem)) {
 		nfp_err(rtbl->cpp, "rtysm '%s': failed to map: %ld\n",
 			name, PTR_ERR(mem));
@@ -554,3 +555,10 @@ nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 
 	return mem;
 }
+
+u8 __iomem *
+nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+	      unsigned int min_size, struct nfp_cpp_area **area)
+{
+	return nfp_rtsym_map_offset(rtbl, name, id, 0, min_size, area);
+}
-- 
2.34.1


