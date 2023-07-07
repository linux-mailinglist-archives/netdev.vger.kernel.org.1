Return-Path: <netdev+bounces-16115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF874B6FC
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6F2281780
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C057171DE;
	Fri,  7 Jul 2023 19:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117A5381
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:19:13 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B419131
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688757552; x=1720293552;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Y1PK/KneH1+XzWq2wtl34PddObf8Ex1Lj1+OhFQrSIQ=;
  b=RZYk9qTXKAW6+RHQ4Qmy54p4yvTV5yyxoZeVNyx7rI4VtwGsyoG7DFdn
   J4O1zhIVi9XPM8G8HcogHTYW1h1H3iaD89JGTOBQT6V1Lmvhdz+fo+yG8
   pwO6+itbAB0gJ73WA5YZGEMf0ZxpQJwTnL4QHrKG6MmgUWSckYc5fTrNn
   T6h5g2SvdCfiLMhwlB6SyqTDizuoIZW4BEOataB3pwl2tY9sH69QM/iet
   iyz0dMFgnr0CjKuBOd4zaUE2fGjKb3n9M4/vDrVPDTQU5wWY1jYePcMVv
   j5rFTiZkBRy9s8SR60bW6c9J6QRlGIAGlxaQCHpc/+ZhAyon2CY9FYKwe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="367453395"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="367453395"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 12:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="844216620"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="844216620"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2023 12:19:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 12:19:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 12:19:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 12:19:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 12:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsRZBzmcIonlG8K9eeKcQOq9ESgOfx8BpQldtLmUg9/3wZoI5qWrg1vUGZjqDZflOlYEH41rcoCzKBLoPSE2hboseeGgP40k3w36HZCgRx7IRJgYSURd8aLqKupguOHsHXGtQALWlnsCKie1/7QVHPmHynxJnN75wS3lIMd/lwWm8+VQXA39u3yOWajlRC2SbmodsNo5rLfLf7oRsPZm7msfWqtfGjyCD71GNI/9d5RNWfQu5nVEzCVoLhdlP+FW4waPmlefPl1XnO+Yrs2d31kwBIRiIQ/ia43IteuCQBVkHlVub2OrTnSNvcYEHph6C7LOlV16WRNVNEJpGl8doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNT5hPAYePoQwCwUGyoLvReBqH2ooQqI0cUsOMqcTX8=;
 b=WnUkk7LtHJEm1HBVhqTINA+JV2oDUZCqgrboE35JOgwQFyiAL3TQoY7fwPM05CqySFa5CpaLEclnCMi8XGo3kzZ1KOfDahMVBlEKnHFLT2uyoKVdgEci1pJ+tyCFmuwauCSkLyqkVeJfI/pyHkL4No28LvVfkfdKQJHKqfHSorUCluKtOPFPYUf5tKEbc2vTOE2ptsq2UPnJY5TFA9M9hnm2zz2O9oa0g08gVDsrj3nv8+F4JEKzYXfDTLOlzfE3Xw7ug/u1iclFMbg6CY4gdJ/JvRBFzE/7cd6mXKnsIarOYDG5HpFiLAlNSM2KrheA0XrEm1XhYROBQteKWxZSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26)
 by DM4PR11MB5405.namprd11.prod.outlook.com (2603:10b6:5:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 19:19:07 +0000
Received: from SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3]) by SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:19:07 +0000
Date: Fri, 7 Jul 2023 21:18:53 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH net.git] net: bgmac: postpone turning IRQs off to avoid
 SoC hangs
Message-ID: <ZKhlHUuIV0ZyNQdO@localhost.localdomain>
References: <20230707065325.11765-1-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230707065325.11765-1-zajec5@gmail.com>
X-ClientProxiedBy: DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) To SN6PR11MB2943.namprd11.prod.outlook.com
 (2603:10b6:805:d3::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2943:EE_|DM4PR11MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5041b717-a075-4351-e980-08db7f1f08c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRhv+ntamcN6J89eDUY8Of1ZbvAfUc0lZM0jdL79K86NcdQZuBjCgi0pSgoNpG9qqVS4Ifkar8ACv9VcQ0gmXOPG16JnByr2LpL6EIKpXboJCbd7JwsDMSombzcLFeMGTe1qzz9LDbgDr/PtanLQhGR5S6zz2kqSXzXll88glqzXspUUmh5qW3umerJmn7N6uYpRGiazb+ZdDsRO6SzCoVNsksTX6j90Z5xSfxHaFkqixdL06jeeZsYnu59Xsg7r32JebHprVC4lUxqPBMIU/EYwDh7jAM81b+0q7BuqobFyvbxh+OZ086P1XMZpbIZzsqU4E8dtDeM8u6Nbnmbdo+JmMaTQEGY4w7tb681ctEBrLNrO1KVfRHKcewEZcixe4ec2wh4tOM41RM1TTmt/z2Kp634AzXl+d9U1i/s/3SQUXt4Qp22kaGT5H4xC2UaFk46I10OxGvV2IvPFAHeKV6zIdiYRZGeSCMxUySatXUGubfkocd3xrrjqRNMe5Rh9hVbpLdXd8aS9D9Vn3leHOreNWx7h35/NBm2U1eE2LesehR/Xa377W1MLaIq/nwqK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(41300700001)(2906002)(316002)(8676002)(8936002)(5660300002)(44832011)(86362001)(6486002)(6512007)(478600001)(6666004)(83380400001)(186003)(6506007)(9686003)(26005)(82960400001)(66476007)(6916009)(38100700002)(4326008)(66556008)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxJaFJ1VGhTWW1zVlAxSTFMYTBhSTVpb2RERERBTk5XdmxacnpxTlltL2Z3?=
 =?utf-8?B?aGxWM3kvL1Q3VlJJSkhtczRGTWhra0E4K1BwaXdZRExGWElrcE40K3UwVUd6?=
 =?utf-8?B?NHZSWE1rYnkwZXFqclVJMkY0Y0EwckxaL2laSXZXcTZaRWZ0L2o1bndoMUE1?=
 =?utf-8?B?dEZxcTU1RlovMVBYL0Joa0dSM0hrLzdMZ1AvR0N3WmxyRXVYWE04NTdjbWpI?=
 =?utf-8?B?bEQxVkdrZEkvUmFORS9kUVpMV3RCNTFVdU9oSDdsUXcwSXRxOStud2xlbEh4?=
 =?utf-8?B?eTNZZlBOVHVDVDlRZkJGMXdLbmd6RDc4T1A1WUpQeDdUeFd4cGx6UEIrK00v?=
 =?utf-8?B?cTFoYm5nS0l2YlNlcGViTDVoWVNCUnBxUWMxVWJXWjd4N3BxSHpRdElDella?=
 =?utf-8?B?Ni9seGIydFRpOEFHT1FadFRwMnNqdU1FeE13Sjl1UzgrQVl2NXE2N1J3ME1B?=
 =?utf-8?B?d243RmlsUmZjdm52YWJrOVpxeEdpS2ZsVXA4ZFpaYVh6Q0dKZUVOVE9ORHUv?=
 =?utf-8?B?RVFvT3pBbjBWcWFicTdXV0RMLzFaMVFyczVoMkxrK2JWVkhFOXNoZzRQS1cx?=
 =?utf-8?B?d1FZQ1A4ZnRneGp3M0JacngxcXFxY2tTYWQyZllOblg1N0pyVXptbmhMTlFS?=
 =?utf-8?B?dHBYL2FnTjN5OFdmNVpSa3JkZk44d0s3YXREOTA5UzI5RTVlay9wYWJVbnhq?=
 =?utf-8?B?bXZuYkhSdHhyc2ExcWovaFZJUFR3aWg4WUhCdlRpVU5YRmNoeHp2WGJZYmJV?=
 =?utf-8?B?VnVVSWFYRWgydjdpVm1jS2NiUTRxZUxxYjIveS9aUU81SndiY0x2d1VMRUVp?=
 =?utf-8?B?eUIyc2dnV0VJalo5ZERkbHZMZ1cwN25RQXhDQUhWVjA1dVNwaVBWMFFZTVdZ?=
 =?utf-8?B?Wm5GTVZqSW4vVXlucGRHMTJ5bEJITlc1ajZpNE1pTWlTZ2grQ1ZoeFhWSm42?=
 =?utf-8?B?bjdOUElYRjVjK3o1UkZKUnU1OXljRi95eTN6ZklCa0wzMWZpU3diMEFBS2w4?=
 =?utf-8?B?TE0ySFFwVHNQckd5YWRSU1NyQmJuRlNrelJZWTVEVWwvUFB0SDU5WXBObDZV?=
 =?utf-8?B?bytBZG9IeHNKaW5oUVlEVmV2TkJYN0RveEtYRkVuY0dCSjBTSUNDY05Ud1dL?=
 =?utf-8?B?L3pDMTd0RlNZMmRzMHNaMmhqMDc0L1JRVjlQeUQ3VUhEQzIzOUlQdjN0TEx6?=
 =?utf-8?B?dktDaThGUTgraEdhR3ExRHdTM05OYWczWmE4WDFVUlg2WGZsQWZlYnJCVUh5?=
 =?utf-8?B?QWJRcXE4TE52WDNHY3lNNm5ERThieVZxczZVTUx4dW04VFdjYW93OEVlaElX?=
 =?utf-8?B?VndUUTk1L0N0WG1jRWZiM2NFaCtoMnkyS0RBaW53MlJMTVlBSUlkbjlySXJU?=
 =?utf-8?B?QTRVdktmYThmTzZQOUI2NDQ4RXNySHNKVEI0anhZeTB0TmJkZ3hJV2N5VVIz?=
 =?utf-8?B?d0phM01kNG5IZVIwVUdRU3IvTVNiY1ErNWpCQzZqZC94YXBCMGxwUXhHV2Fz?=
 =?utf-8?B?TytBblRXYndLcUZxTjJwQVVjUXVrT25wN2ZHNEExZzEramtjMzVLUllySnY5?=
 =?utf-8?B?VXkvMlBSamttSDBSQ3BjSDRWbld2RmtoUFpzVnV2czdoY29BRDY5NUJnY2Fj?=
 =?utf-8?B?d3NXOW1lOG9oS3VFWE9XeUZ3cWpSUnJKN29zZXU4WW0yNzJlVjNNNy9SVVFC?=
 =?utf-8?B?cW9UU3RJMTR1V2xaZFdKdjFBY21ZZXBsZ1NzY05mUGtobHZSY3NxV3YvdDI2?=
 =?utf-8?B?eDlXeGp1VzJLZ2pZMVp5bVpFWkNsRUNza3Y0a01QYXJIaWhsczBkblV0TzBQ?=
 =?utf-8?B?YnE4STVtNFFlSUh4ak8xeWd0bmJKc2diK0NJNzgxWnZMSU9OYXpqQU9uTnlq?=
 =?utf-8?B?YmF6ZE9Wc1NjZGNDUXBLR0Vsa3FoR2NkYjA0TjFyMVFUSlJyTjRVYUpZN0pz?=
 =?utf-8?B?c3oxTXV6bXpyNzVKWEVxQnRidTBKUjNZeWV5RzFVaGNMZW9UcHBMcTVzVEEv?=
 =?utf-8?B?dXQ2TE5JTFI5TGJ6Y0lnd0tGZjROT0Z0KzJzdWoxZGFoQ0F3eDVNV0U1akpI?=
 =?utf-8?B?UWxCNlBuMDNLOGxIOVd2M2ZqYUM1bGVrMXEwbU5LNDJyS1V4d0VRT20vanNv?=
 =?utf-8?B?d0pDWHRmZ2ZjOEpGb054VEV5N3h2WW9hN1dJaGt3NzFOSFo2SytGQ0EvVzAw?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5041b717-a075-4351-e980-08db7f1f08c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:19:07.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgDwH5dlmp7dWNCZfh0ULG/R+Is0DB7cRNPksahSFXAQ62R7EvG8Qd6zXn4pflsi7y7WSKNE3moQyj/fElnzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5405
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 08:53:25AM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Turning IRQs off is done by accessing Ethernet controller registers.
> That can't be done until device's clock is enabled. It results in a SoC
> hang otherwise.
> 
> This bug remained unnoticed for years as most bootloaders keep all
> Ethernet interfaces turned on. It seems to only affect a niche SoC
> family BCM47189. It has two Ethernet controllers but CFE bootloader uses
> only the first one.
> 
> Fixes: 34322615cbaa ("net: bgmac: Mask interrupts during probe")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 1761df8fb7f9..10c7c232cc4e 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1492,8 +1492,6 @@ int bgmac_enet_probe(struct bgmac *bgmac)
>  
>  	bgmac->in_init = true;
>  
> -	bgmac_chip_intrs_off(bgmac);
> -
>  	net_dev->irq = bgmac->irq;
>  	SET_NETDEV_DEV(net_dev, bgmac->dev);
>  	dev_set_drvdata(bgmac->dev, bgmac);
> @@ -1511,6 +1509,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
>  	 */
>  	bgmac_clk_enable(bgmac, 0);
>  
> +	bgmac_chip_intrs_off(bgmac);
> +
>  	/* This seems to be fixing IRQ by assigning OOB #6 to the core */
>  	if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
>  		if (bgmac->feature_flags & BGMAC_FEAT_IRQ_ID_OOB_6)
> -- 
> 2.35.3
> 
>

Looks like a good catch!

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

