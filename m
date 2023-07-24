Return-Path: <netdev+bounces-20319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F575F0DC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82C41C20987
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0D748D;
	Mon, 24 Jul 2023 09:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47193D308
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B44C1E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnrpsPv9/pTr61u9SuzPvlqGdYR4pec6S1TpOSzBDcfV1LwhTWuMvW/yBHy3HBxTjWtUgFlJTrv0znuC6I2varE1eO1efl2c/Mj/yWC21LxMH+zGLu/fr1ij2RuVaEcsS1igsYkmxtQLYDCqL4HLMjWgJ2ZSu/iBwAOXKHI7tVw21CEmI77KiDut35qrg8FRIieInqxwyN26m/1Hcqa9nLOlbs+1wB7QNXyciRyx9mj795a1TBRJ7sLvbF2/sZm50ezocB92vDv1nULCAn/Yz37AKKULNwUWksL+Vqaf/dN3aP9jbH1Elp1KvYKG2y4ryI5oMehK2FeENyBI+RdQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBUXZqRJXAmBgNMsYWTMWNsnJkPQFbIT8w2pC32UAzw=;
 b=fPUvn58qjdC7dZGIMs8p34qgSEWPQaUMIzCojpRLDIqDvfXstgnUceTUWsxSYM1ZAjM9vFrfo6lVtogDjsgvmv+dJsCB3kTvo7G5D7pkpW/uvCPH4ndiiDW9VinoK3Tkk45t7RXPlN4IgKDe4XZvTvtMPspN/AX/5b4f4NE9jUqEroilPjk39qKa0IL983fVYTBz0wc7WG4H0aN0xGT3m9fPggqJoNezBpK+uurhzIiOkL1swF1fTh7w4YaM+oFC2MxzEjWgdj1XcliY3KMg2QvsNdDBJh5gkNipQsEpXV0xAp+/o2YIrr/6gPSv5OuHhLc1pbx1dDTwJd6CitwPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBUXZqRJXAmBgNMsYWTMWNsnJkPQFbIT8w2pC32UAzw=;
 b=MG8JPbxww6VJBBgRocDZBRd5wq4FI4GvymrnnXTmlQHqyZcxR1r5WgLmG5JY5qpzgLUJW2V/MgE9OqYPnJ1ZFHP0w8GmMhxvaQ2MDJ3U5kJTaLNZkDSLyaXmLHGmE5UwzlnKAIRrSWQYW5ic2ddgjg3zWBiAHhRh6k/Ne9opsHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:04 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:04 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 04/12] nfp: don't skip firmware loading when it's pxe firmware in running
Date: Mon, 24 Jul 2023 11:48:13 +0200
Message-Id: <20230724094821.14295-5-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 273cbaf0-8905-444d-3872-08db8c2b3783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJFmEOvJGzQXLVA3lY9LWh5YmriAUDFdmu+UtYElFRO29BuuIN9Je3LSaavCP4Inf4uhryu2ewcMAanLlJ5h9dnkTIZr86p0G4LwHo4PaUkHEzNaSwvcvIRztpAqC2VDO1j/MVaCQp6o6jjvemwZeHyQRMzMQLkodlCubfvVudzQd9xtireemd9Ic0AZPvwCwkVLkfsLx2oaZQcdsUYmZ+fdAGQHX9ktlQQCunXE0InnMVFYduOZcpk3IdgMiQmNWmXrfWv/svQK3M/ffgfjC5TOdEwXIzXW/jBg8jbDVII0Fckugt5zlQkp2WB8/Oj9nq1w5ezro8SpMCs90Amidkk4YIeAcPPYNwGhY913hjJB2wDq0jg0uFow6VM7KwTxQlWp9VopJ4jqHbvAh1l1alSuZPWOI5gh1zhQnPF85r5PyNXiA7D6PCuGVvzvmm+gDhfnrDgzXwh4fIOC0EfyoReNDOXPyKFD9cMj46iKODPZBdwtPuDjFTCf94PvnGOus2uoa8D/0D+l4FIF2/5dc1Bl16XRRGYfQDPZJLxyhSgjLXa853INZ4HalXhYEfMjMuxpPzlK0i9HVGloAHgAi2b3rloaQ7mY9o0U0/thkGJzmX7U5wi6TfJvGbUmw+1P+FKX2iaEauZpktbgMFTAsK1rZC6i2V7QLUU0XdwBG2bS1pz0sKq8a6LUlQWt3ZEY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWh6RkhEcXJPMzJoUlZoVmdTUWdkL0RnQnZZVTlMZFBBYjFoL0h6cE5tcmVp?=
 =?utf-8?B?WDJCYmo1bFM3bmtWS0EvTHVYUVRzZlpaa1FPQXlQYzJ6K3VseDJsL3NVWk9G?=
 =?utf-8?B?eUJUb3Q4S1lYcG5oanhGY1dtMlNwVVlnTUZIamw2RVVUYTFVN1F1Qkw4czg1?=
 =?utf-8?B?a09vQ3pabG1vcExOV08vMjF4UURXcGRXS1I4aVB2ZXI2M28wQkRpNkJpbUdZ?=
 =?utf-8?B?UDFWaG9VUEhIWGVlay9tK2lwUWovWVpibjNvaXN5TTFPYUUrd2g1U1NRUGM5?=
 =?utf-8?B?WEVmTDBaS25BMDMyZlFyS2g0dS8zVGs5RzdOM0ZySVdQOGpJWEtTUnlaZUt5?=
 =?utf-8?B?VzJzbnpGeFFyb2VzYkVLeXZJTWlXT2RRUlQwcWpKVDdRMEh1bFJzMUJLYzUw?=
 =?utf-8?B?V2hjVkluUHRBckZ2RlJPckJBUEtyZ3J4alUrclJTSHdnTzFlSkJrRFZvL0ZD?=
 =?utf-8?B?NGhYN3ROSDdaT1podUFzbksxWFFWdHdVRFZhWVNrT1FNZXVuZXhibWV3ckxN?=
 =?utf-8?B?aWRRMEJjZHFmbGxsUC91Q0NwUFV2OU45cEN5MS9mZHA4YmJxdmFRMnJKS0Vm?=
 =?utf-8?B?UXJOcVJKdU1QQWNzaGZ4ZSs0ZDQxc1FWdXZaaXNUUlI5WUx2djJhRkpBMWQ2?=
 =?utf-8?B?TXU1UzFmSk8vV3U1L0MxTFlBQm1UOHVyVTlTaXppWEdybDA2ZTRTSDJsbEFM?=
 =?utf-8?B?VUtDRyttc0dHdkZ5ei9FVFNDaGg5cTdmUjI1UkNDdm1RNUpIZW9BbS9PYURV?=
 =?utf-8?B?OHBXVm10L0dtejVQaUh1MlpJSDhJYVFTQ09mRlp3TnVDUVltL0hOeEpRNFJI?=
 =?utf-8?B?TXlrWUtiZW5WeGYwc1M4NUllMkQ1NHFnU1Q3Z05TSU40SmN2MWdUNHVucHE4?=
 =?utf-8?B?eGlwYXg2ZktUYlVrVytISTk4a29HUmpyQjQwYSs5M05jS09XdVFGaUM2SVZ6?=
 =?utf-8?B?clR5TVNsZVQ4KzZsMnF1R2FEQzFiMTZacDVyblBDWWpZSCthRTV1Z0Nidkta?=
 =?utf-8?B?Y08rbHIyUkZ5bVBjVzgxV0Vib1hrci9nblkzSmE1RUtoY24zbU5udnJlV212?=
 =?utf-8?B?ZTVLWU51enhzUElXclNzMXBHdWhuczcxWVdLR0Vmc2phbllOb1ROSzd2a0xD?=
 =?utf-8?B?NHhZQUZJNDI4b2NPQ3p5OTE4WmxuTFdtRjczd1RSZWNpZklSZ0pXTHpSSG1p?=
 =?utf-8?B?bE5sZU9FNGN4Q01jTTUrczdhWUtPZjFPTHhoMk14UXVGTGJqc1hES0tyMnFj?=
 =?utf-8?B?end2ZUt5MEM0QTIxdjlpRzEzRUtROE1FZEs3SXFwNWZwamxmZ0EyYjY0ME9l?=
 =?utf-8?B?VUkrRXdNT3VBelRkSE1Jd2psZFZhWFRXdjB4cWtGeWZwcWFzUjdLSEg5a1dQ?=
 =?utf-8?B?ZXdrbksxcWJYb0xSYmxpcVcvVTdVUkZTVjlDTHJtTldETHpZWlhldjloOXNt?=
 =?utf-8?B?SjhXTGtSbmN1c2x4cTREY2NRQkRwSFFTOVdFby8vWUJGUUZOSmYxMDJNdlRw?=
 =?utf-8?B?VXFWOG0zdFFZSkZ2a3NMVmZHZkVTbVp2dW5OMWRzdHpubFhEUGVlNFdGUE5z?=
 =?utf-8?B?ZFBmQ1pjbTZRL0lHczg2NFBqZFYwajlrUm45SENzVzR2RENhendnZnZreVhz?=
 =?utf-8?B?ZmNzN3RnMjN6ZFJCM2NHQ3h5OFJrMUNVczEvekMzdmFMSlRSL094S3BuS2gw?=
 =?utf-8?B?MXZQT3dKc3laZ1V5TTdmb2pFRkR3cVZZUFVhOXVQTjhiZ0s3VFRSNFRYTGM4?=
 =?utf-8?B?cnBJbEZ1ZmxaajluVzFxRVhkMmd2enZkTE9GNlJiZEJOaWxkQUhIZDlwcUhq?=
 =?utf-8?B?VHZLL3RwQ1B3dE5zeUVYNmhJcGdaalJDZnFCeFpjODR6dWpyMEoySi94Rnhp?=
 =?utf-8?B?aDhIMC9SWi9FVk5KMmVUeDJaTTB3dGZBamVtVm1VUnUxRXN5bHM4NHo0UGRp?=
 =?utf-8?B?RTZ3NFFhSmwvM2VrWWdsa1IvVzcwdkxzOVozYWlVSzFPL0VWYWE3NDNpSjBS?=
 =?utf-8?B?WXN6YWFzVklwQTQrd0kwbitVQmhac1pseTBFclBFbm55SHpzRHNXY1gxSzE2?=
 =?utf-8?B?dHF5NzV6cU5xTWk5Um0zVTN0RUV3ZkRIbWF1V1Zhd09ueXdSbUgvT01VOXFz?=
 =?utf-8?B?UXo5d1Y1aTk4bVh0b0pYNGEvWkdvKzcreERYQU1IVWFXcHF5ZjJPem1pc1RP?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273cbaf0-8905-444d-3872-08db8c2b3783
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:04.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YAuYFneOU8zKzowE9FwzavDXuQeCu1sa6THZAsduAAq4NdziUbr1V6SujOAVspUjtfabUXoCOX6Rj8XnefdPqTyQup/IzgSPuophhJ5BuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In pxe boot case, the pxe firmware is not unloaded in some systems
when booting completes. Driver needs to detect it so that it has
chance to load the correct firmware.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index c81784a626a6..778f21dfbbd5 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -469,6 +469,28 @@ nfp_get_fw_policy_value(struct pci_dev *pdev, struct nfp_nsp *nsp,
 	return err;
 }
 
+static bool
+nfp_skip_fw_load(struct nfp_pf *pf, struct nfp_nsp *nsp)
+{
+	const struct nfp_mip *mip;
+	bool skip;
+
+	if (!pf->multi_pf.en || nfp_nsp_fw_loaded(nsp) <= 0)
+		return false;
+
+	mip = nfp_mip_open(pf->cpp);
+	if (!mip)
+		return false;
+
+	/* For the case that system boots from pxe, we need
+	 * reload FW if pxe FW is running.
+	 */
+	skip = !!strncmp(nfp_mip_name(mip), "pxe", 3);
+	nfp_mip_close(mip);
+
+	return skip;
+}
+
 /**
  * nfp_fw_load() - Load the firmware image
  * @pdev:       PCI Device structure
@@ -528,8 +550,7 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
-	/* Skip firmware loading in multi-PF setup if firmware is loaded. */
-	if (pf->multi_pf.en && nfp_nsp_fw_loaded(nsp))
+	if (nfp_skip_fw_load(pf, nsp))
 		return 1;
 
 	fw = nfp_net_fw_find(pdev, pf);
-- 
2.34.1


