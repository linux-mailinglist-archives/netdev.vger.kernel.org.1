Return-Path: <netdev+bounces-28103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040C877E3E1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E57281AEF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D737134A8;
	Wed, 16 Aug 2023 14:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4D156C8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C326BD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPIAaYEd3O6j0QHIErHlMFVmy/lTBl99vN9rKgG5QKORH2qyTv3+W+CHFD1niis0aBXNkP4tdurcUYUh9lBVa4v3xLXu4vn+IM5+uy0b3umi4yO+dREcqw+PtkNIj2oNE7oCdxMaU7NQsdDiSgJAFW8sDCpKIvgeTgCWu0oxlkR8q5rrx5EXOErIcLGYKnNQoHrra9KkhqXgi/ttyVLIR91Pxvps7kGBHrcdBS0385S2IV0J9BahPVIAc7470gwHJ2TLKDZTns7iyn1Jeha5+4veUW8VOF5Yrq+f6M4nbsQN43lGZzKviUHS9E7RBMiFb2kXV82xpWIZjYhov6Vxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FZVL/j4FDj/1aP7aR7UQG9bAUo5CX//evLuUIhhCyI=;
 b=HWJgtBj36nnW8APwHHm2vDC7O2gVB1AQwmLNDoHmkNSR4KTzeIXWyRmqXnL5mCaXYkvs2xeFCNyg3j1BLIKMpIyqEpmRGXRNgXl2pPN9Tyz1V6UOh6mJs6sdkBnwMKKqsUWjF0qFZHE0rCOnpxZPVb1fcONS197oMbzJJgLdErom58h+x9sQuaDAunw5esc2WAFvdZFb3uTI93WBfL0oDVItq0uE0DYwd9h0HipbBKPFeEIiaa/R/tl6hpeX3OQp3XLXSlso31tl7ihXvn8AS8WJ4DHicNF9kBF/ZGHhhFlJDLkMXmts6qlraz6BaRoNluRyFIShyKm0sOPm8dXk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FZVL/j4FDj/1aP7aR7UQG9bAUo5CX//evLuUIhhCyI=;
 b=A7T3z7it13FmhGR0Ji1010pMntjbxZec3IkAE2nks2+fLVIfeldCrxIozvGYH587Kvt4X/qBBHEiIXrOYTI/UwhS8O/Z0Cl5h+ludlfsjUie8ucOsglkFkGHhTzGih+NkpcrA8RXWC1Vf7EqdfSrXpybT/KRFOZGZ7KZP/blyk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:40:03 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:03 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 03/13] nfp: change application firmware loading flow in multi-PF setup
Date: Wed, 16 Aug 2023 16:39:02 +0200
Message-Id: <20230816143912.34540-4-louis.peens@corigine.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ce89ce-cca5-4840-2eb8-08db9e66ad37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VfishdilLOzmuRKdDhTfTkrTs2aKW2QSIP86hSjLYK2XcBzSJ2sX2MYEoioKnxCZKY9HZn008NYnnjhYkSMq5w8MxR24byJSi2UHyo7WTmGNebDSLBQ70pDCe0F8re1xQykw44k0QmUOluwFvC+AyEXx6NK/id8+mhA5L74J6hRKInUbbvPhqdTvI5aApAGSDkSewE1GYqvNaAF571YzrC4yAwvokLjsSF8hKm8vdXjD+ewrvLf8AzwVw1PLOk4TbNvVMMiJsaFXv6cjCjhoiAoPZmGds/PRuOoPVzcLD0/d6vOpVKxmtOqLYosR4c7DyiTZoSuxZs4rJKmhBYYkZ5Fm/PyFjoHML8uQDgxWp2PzGX4nAfD/BYlaZ1Hxs4ku5NJe16eKR5SRYr1VdFs2evQCPLnJrQ0FyCRbl4UiW5pyTyXqTi3BTCtojByMit2qEYrskxmfaPWWNNRBieCr/QBUlvIUUlKGaxAphTj5vmTWTWB8VorXeWC6Zwi3kKZ17dAkUO/5JwdlDkPg/iKacQURSgkM/b0XFa1zzh/7S/1uR6E7btoLLYNMr5p8SLT8NLsy0qO0NMjYS9n1B8ZOG2sSvLeLrviL3XQfti2QHi+9gm+FWtgVy1QQasVcM8s18kHK6vRySLpZT4p1AEQ74+ZskwWNYoanWTvHP0pz1CPdul8kJzpfScILaf4skAi/CUqioCzw6rmCqvUMEw+H7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enMyR3BsVzdQVENSei8wcDdCUGhrOVBzM0owTGl5T0syWXBvRVFncVo5Ynhq?=
 =?utf-8?B?bG9KV1hTWTlpQVovU3BZcDZ0WER2RWkzTGlhZTR2eHY4UmVjbUZBM2N0cGxE?=
 =?utf-8?B?TTRITFdCNDFEdGlMcHJWWEhjUFpab1paYTR0cG5lemcrWUtqV2ErZGxiOFQw?=
 =?utf-8?B?RU91ZzJMdkJUbWs5N1g0N0ZjcjU3RWo4K0dyYzUvUUlHajk3cEFpNjRWOWpW?=
 =?utf-8?B?bXlIRy9aY1FZdlZHM3lsS3NWd0taVmRZRmQrN2pJTm5ET3NhTDIyOENTZVZs?=
 =?utf-8?B?bER2MWdQN1p6V3Y4L2diMjJXUlJGNld2S1pQWHlsbzZTeXYzbmI4OTNNNEZs?=
 =?utf-8?B?V2s1cVFjVUdqNDAxbEFOb3JjVVRVQk5TRmxraStqcXUySmxJblltUTF1VVJK?=
 =?utf-8?B?ZW1mYitDZExncVhZTkU2bS8rVCt5ZmJLZVF2bXBsZnpleTdiS0Yrb1Zxamlz?=
 =?utf-8?B?WUtxeVVTUTRiWHg1NnBSVTNFYkZOd1VVaVphaE5Da1lUZ2JjSUYyZityeHo4?=
 =?utf-8?B?T25UWDFIanVVZ2pQT1c3bkxUeVZTcms3SkdrTVV2VUpLOGZCR3kvcmREemJh?=
 =?utf-8?B?eWtkMHI3WEo4ZmtnaWViNFhwY1pqZEVqeCthZzBLTlAraVYxcm96ZWlZSFd5?=
 =?utf-8?B?TytkRFlDVlBwTExrWnpySW94T2V3RUxOcXI3N0VoMjJsd0VXbDIxR3l0Sjk2?=
 =?utf-8?B?RUdkZ0x0S3FDMU5DUGlqZmJ5dFZxWlhxRDNxTklGSzNvTmtBL2FBLzFlT0JZ?=
 =?utf-8?B?STRiS3dRejVBOCtaaTBWeE9QTUpUVDU5bjRnOEZKT09TNlYvUXREUUpLVGpY?=
 =?utf-8?B?emEvVERIWG5HdHlhQlpDZjNiQ1ZqaTdtcS9mS0hUNzVwQlEwMVU2R3BFQTdv?=
 =?utf-8?B?aXdhMUFlTkxueDBWQ3pKS21RU0RZY2FlcWYzTTdWWld1WVA3MDJINlY0RjVj?=
 =?utf-8?B?NGN5Y1VPVEljSXZRUW0zUnFMUDArN1J1RStqNGNzVGhoM29rSVZQaUg1RXJl?=
 =?utf-8?B?Z1dtOHJmUTByeldXUnJrUys5bTZZZTNQTWJLQnVoZzdwd1ppN2VYV2dHUlFF?=
 =?utf-8?B?ZDJKVDNSVnNIYmdJUnJsTWFWMW9HVndtQ3dDWGI0d3BKZ05BOGM2cmFSMDJD?=
 =?utf-8?B?bFBWcmVDRStub2V2bmZxVXlmdzdUKytqc0FubC9NY1hSNVdtQkx6VEo0dE16?=
 =?utf-8?B?b1MyTGNhblRWNHk3anJiall3Q0t2WVRscnFSSWFkQWpiRFNSUEZnRDJkZlhJ?=
 =?utf-8?B?SkFsbUlEanA4VkhhZEdpRUZCN3VMNkhyelBIQW1HRys3L1JoaEFxbnlWT29Y?=
 =?utf-8?B?UHBtU0hoZWZHT0FxMzNqVi9TcFJPRWJ3RnZJYkgzbUFpU1NCMXFJcENaeDRv?=
 =?utf-8?B?ZW1pSHFSVEhvYXFrOENPcG5tZGp4Qk9GWFY4L2g5V2NlQmRsMmJjUDRmMFQ0?=
 =?utf-8?B?SzZGalBJdThXTCtvcnI4bjJxTGhJVFBsNFhNUHlLS3oyN2ljV1lIY0hPaGRr?=
 =?utf-8?B?ZFpvNjA0ZVFPM2JXNXFkdGNBL1dPUjVHSnpkMFB3bjgzeVJJaHZFeTZOSU5q?=
 =?utf-8?B?SzIyNm9TT1JsNHFXdVVJenhsL25USm5VbGU0aW1WdndjTjV3dStlUHNnWHls?=
 =?utf-8?B?dGFiZDFUNnF2SVJFK3BxSDBMRTZRNXYvNDFGaW1WVFZFQXN1c2VhZTltZVBW?=
 =?utf-8?B?OFl5VmFFbENrMkZudUlwSmF1cUhzclJBS2w5a0tvcWVHNXVxRUVXTkxxQ25O?=
 =?utf-8?B?Zit3dXFDalBicjBqZS82N0poWXVtZWgzL09zbWRYYlpjeFluQVErdDRybm9V?=
 =?utf-8?B?L3hRbkRPbys2YjRxNEV0cTlTRE5wWHo0WkdyRTd2a1ppSTYxTHA3V2tSMEU2?=
 =?utf-8?B?d25NTlhDMWU0K1A2UzRrRGw3VTRCTHRsSllCcDF0eXV5TGtBdTNFY08wU21D?=
 =?utf-8?B?ZittV3Nab2c1ZmVnclZFUjdxOGVmTzM1K3g4c0FOYzBZUmtRTW5NS2hZZHQy?=
 =?utf-8?B?Q2xXMzFBa01DVDhGMDRRdSt6QWtuNXlxeVJ0eEI0Z3hhYUZsTFZqWXJGUkg1?=
 =?utf-8?B?ejROMVJWK1Fxd3FvSi9XVEo0elpmQzVneFVsSzg4VjhVQ1hOUkpTUGlLamxk?=
 =?utf-8?B?Q3RIemp3Mll6dmIrbmJHV0g1SGhmOXYvdzRtS2ZVbnlNRXpCNVRJdUhGb3Fm?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ce89ce-cca5-4840-2eb8-08db9e66ad37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:03.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thy/AmE6yj1snlb/zpTJ1rgg6b2vhqConAb5+3x3QBRg0v+4NluvyulORPUxTS84+ME8+bJz7s0IsA0Ce8AY744JZwu9+vmNH3+71xO1BhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, all PFs share the single application firmware.
Each PF is treated equally, and first-come-first-served. So the
first step is to check firmware is loaded or not. And also loading
firmware from disk and flash are treated consistently, both
propagating the failure and setting `fw_loaded` flag. At last,
firmware shouldn't be unloaded in this setup. The following commit
will introduce a keepalive mechanism to let management firmware
manage unloading.

The flow is not changed in non-multi-PF setup.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 39c1327625fa..c81784a626a6 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -528,6 +528,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
+	/* Skip firmware loading in multi-PF setup if firmware is loaded. */
+	if (pf->multi_pf.en && nfp_nsp_fw_loaded(nsp))
+		return 1;
+
 	fw = nfp_net_fw_find(pdev, pf);
 	do_reset = reset == NFP_NSP_DRV_RESET_ALWAYS ||
 		   (fw && reset == NFP_NSP_DRV_RESET_DISK);
@@ -556,16 +560,30 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 		fw_loaded = true;
 	} else if (policy != NFP_NSP_APP_FW_LOAD_DISK &&
 		   nfp_nsp_has_stored_fw_load(nsp)) {
+		err = nfp_nsp_load_stored_fw(nsp);
 
-		/* Don't propagate this error to stick with legacy driver
+		/* For single-PF setup:
+		 * Don't propagate this error to stick with legacy driver
 		 * behavior, failure will be detected later during init.
+		 * Don't flag the fw_loaded in this case since other devices
+		 * may reuse the firmware when configured this way.
+		 *
+		 * For multi-PF setup:
+		 * We only reach here when firmware is freshly loaded from
+		 * flash, so need propagate the error and flow the fw_loaded
+		 * as it does when loading firmware from disk.
 		 */
-		if (!nfp_nsp_load_stored_fw(nsp))
+		if (!err) {
 			dev_info(&pdev->dev, "Finished loading stored FW image\n");
 
-		/* Don't flag the fw_loaded in this case since other devices
-		 * may reuse the firmware when configured this way
-		 */
+			if (pf->multi_pf.en)
+				fw_loaded = true;
+		} else {
+			if (pf->multi_pf.en)
+				dev_err(&pdev->dev, "Stored FW loading failed: %d\n", err);
+			else
+				err = 0;
+		}
 	} else {
 		dev_warn(&pdev->dev, "Didn't load firmware, please update flash or reconfigure card\n");
 	}
@@ -575,9 +593,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 
 	/* We don't want to unload firmware when other devices may still be
 	 * dependent on it, which could be the case if there are multiple
-	 * devices that could load firmware.
+	 * devices that could load firmware or the case multiple PFs are
+	 * running.
 	 */
-	if (fw_loaded && ifcs == 1)
+	if (fw_loaded && ifcs == 1 && !pf->multi_pf.en)
 		pf->unload_fw_on_remove = true;
 
 	return err < 0 ? err : fw_loaded;
-- 
2.34.1


