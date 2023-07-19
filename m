Return-Path: <netdev+bounces-19115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F3759C6E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FB61C210BC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76E1FB5B;
	Wed, 19 Jul 2023 17:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DF1FB54
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:34:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B21BFC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI2wMY9R20foedcJJ6666plmkQ/bhPjtzHXf654WFbat+163lQIs0/4XOKDuWUYRnrDE+wHOygtA8QppW2py4QcZ6L9hji2A6AvAh+bVVDdEw0RRYGdDy3E+Zv+S6Nt4ef7CYhSp8uYpt3iD+uxDlUQ8bAktM/JKpnX5tv21E3x6x/N3BZHH8Lwc+ZhIagSyTaQ+NISAwL9XqZWXQm6MMy/zegzJoTmTYRwK9JcLeoMYQWPSef3rm/2nS/tg3S6IABW0254l3I2GkPlX1Dq8c533cu7BXVisTZwovjrPSLp/QxGIwYkR+fuwuF9n5gb1mNlyDAC4nD8WuXvwqKvjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBMynKYxTb65guza9Y9FipcdLO9pI6dunYUQ+X+PrJs=;
 b=l/8yQPOlupGf6ugG65oClDcMDB2FxWXz/zOutX81tIy5QM+xCOrA0upRXkWi0mQylmQ72q8olzXghJMNX3LnR0pd/hnRnNmHp16pxp1qj+xwpqqoT1v24RGEEu318CNyGI3FcYdhZI4AMreGjsKXYL9WDHKf5C0VmqPcfMwZ5KAZC+RFDeSkgkXm7vxhdwpXYa+5u82lzziFQht/WkzigSlZivJBpr7KWNn5oEaLnurnSAC8eoKrD+uFtUFmZNdAqhXbLDINjL8jXf6oCMpTV+Vo3x1+coarMDsLhpk4KYy6Xhade5r7OoOoXhXPPYOYu8ApJPpxAOoBTH5Kx2qP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBMynKYxTb65guza9Y9FipcdLO9pI6dunYUQ+X+PrJs=;
 b=ZwiH4/1XN4WDWpY32ZaiJwiuYIEvydeUe19qqXB5AwGmpzua7n0xgDT9Y36Q+S+80D8ydeVxHM8E2BKIdl7g8+y94ItIG9mzNDnYIIK92nf1C6XTNVRM1x2mZXR76gYbavUXsrvTZnH+PITCfisgrxp5vpFYY9XBNAM2qZrnDBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4138.namprd13.prod.outlook.com (2603:10b6:303:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Wed, 19 Jul
 2023 17:34:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:34:39 +0000
Date: Wed, 19 Jul 2023 18:34:31 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH v3  net-next 1/4] ionic: extract common bits from
 ionic_remove
Message-ID: <ZLgepziaYuIHL+pd@corigine.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717170001.30539-2-shannon.nelson@amd.com>
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaa9da0-9a0a-4099-382b-08db887e6d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HsyotO2PHIgBNKZ/D0Kk0IxGZD9FTAAdXlOZ3bcyldIwbme0h6laoGfdSzTzX8sIDOn4mbP19QPbkSSXFYhmcwgM+YQfYX9Rj9T3EYaZTxt99/u2dtRBPAtXtm2PF/PJUr4RJVL4I6pYHop0sGKO9QwqgN3IM6F5Z+NdvVMdaZMiCtimI6Wf5zpVyCR5HAD0lmz0dQGUeEchXPFD9VPA3vtEYNdbwiCBBBlAIF7cD4ChEVGrrXrMveifaMgzkQ18tmffOMc/NaxyS4GXEYFovI+Q9XFptJ8GJ9/ACzi06EieTTmKchoh4cS1kgUcBYFgwQKqLJd/ZpiKGKi2P3Z+BOnRYFx1paEy5IoT8OdXGso6aRnIOIPYyjkFFkm2BewY5fuSdxxSKYeafSjy7i1OrVlMkNBCbyzedhbL4yIznJoxWW+7w0gKTsa3rj5dd7w8/ahzrqFCCPfNDLYfzC9/oRFWvwk0qMAXvmUfZF/eqkk1C8mZkaEWywBOgsDjuH6l9NIek7czEjE9aOHYeEujmaDWS5UDOaDZc2fQ8EAVMr7PLEqfe9ftrqIumXd32orv1lVev3Cq7n1cfqAa+AvdsmVA4Mx0KSp0FSsjy2bMO7PYuqe9kQzhglqffnsOknAZZXaEGg19GApbEnXfSWCrYJRx7VE/Dq5rKbUpxAxFNN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(136003)(376002)(346002)(366004)(451199021)(36756003)(86362001)(38100700002)(8676002)(6486002)(2906002)(6666004)(478600001)(26005)(6506007)(55236004)(6512007)(6916009)(316002)(41300700001)(66556008)(66946007)(44832011)(5660300002)(4326008)(8936002)(66476007)(2616005)(186003)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOQYbmYPtm10P2o3xJ9rDB01tFfo6OjJ8q+93uX+XG0NOLFf66L7Xh1NLtwY?=
 =?us-ascii?Q?TlJDDq9khhzKVmImb0zf182tAFxpVDtbgfHJIrmQ1+ESKyDVpiDpVOJIy4ck?=
 =?us-ascii?Q?jHBMB/I5Ptc1b/UJu+gGnskF2BA/p/Bm1HnECK4dUAe5cpRBPCkgxRUkpk6O?=
 =?us-ascii?Q?gdQ7uNBoJNygNP8vYJJlXh+ezXOcvp16R3DWiyEbpzBJZH9kdDl13V4yusN4?=
 =?us-ascii?Q?q0oOx3Gyekj1WhO//tEckvOvaX39ecIPUzkJzdOxKFxrr3Cs5jEMayrKANdD?=
 =?us-ascii?Q?FiCMWvNsdiiBJXN3scsGVReKaeqR5Sa9Ika+6rjlBfRJkfTm4WsOt1tjwFdi?=
 =?us-ascii?Q?ZfatchqHfUBFgyCm8KWPOmqbR//PXUg0daJSVXUjjR/VfL5G5R9S+sJXQ6OK?=
 =?us-ascii?Q?zG98TEkwz5zds8fCJHf2b6QNTwcWFQQ8HkOOjLPEW01/FWaAXd6qLedCh7ox?=
 =?us-ascii?Q?GsXVFGgC3VhNRV0wB+dyqjE1qutAd4b1BBrKl/vFRuMAFImCZrvtNDdEsG1Z?=
 =?us-ascii?Q?bPoCnke9vl4sl2+PuswW9CauyYKcS1C4h/VBwI1k7cisbY9VrfVZX66plGtc?=
 =?us-ascii?Q?WVDJ2d77fLF/HP+jT6dsMqfF9agxeEiceolc+YdGilAfSY2BFcTS1vWTpZH5?=
 =?us-ascii?Q?d65rn895jCpmNgg3/ns1Se4Eoq5VGbbb+91H7PMJ0svQCSY5vGMMNql3QaNF?=
 =?us-ascii?Q?fNtKG8rDbyEzSBQCyF6Ui8NyceMkHveYQZ/EpEA8m6vnbXmzkpo76yT2+1EG?=
 =?us-ascii?Q?dbLFMz/zKgeusK+H5iZkAuv56ak9pKtP+y8EhMzhy4MoalAaqOemzM+i6pbW?=
 =?us-ascii?Q?ofifz2uAhMIzuCj5RG4MtWaysiUxLpSOTunAbMY81fDJM8Nsr5byK7lsPuHO?=
 =?us-ascii?Q?x7w2DRKTi9vPOI2xNUtWQpChR8sFgzsn+FW2vyQt0/6WmOvim7pqmikZsSu3?=
 =?us-ascii?Q?lgCBZGXCPGBzqbXZdOVZTfNprtIwfOlPjKxwIYyKiQSNcQf0NDW6h+IVJ+vd?=
 =?us-ascii?Q?lsCu0mI/asH9IDDYD+lC6qDCs6pC4PmATWXH+KTSZI+YaEFmCPcrmldKF+un?=
 =?us-ascii?Q?W7QDWqreM4zguuyN8im48BrzcQ1NtATBN6a3P6bR0s5kWwwygyO/Mrnq9NbO?=
 =?us-ascii?Q?KA3Bb+fP3oIpWwt7cJ0ls47bre81aAp58hJuMUt6vYG8KF5ufS1qSpscjSf3?=
 =?us-ascii?Q?my1yiOPDMrMjVjrnFZa/2PYHmAIvFNRdEy+JenxsokhTk+s9xFaFhqS6FGDK?=
 =?us-ascii?Q?kIjB/DFgTFEu0rc+7AMuGjjWUD/UFpILda5XEua2T1wbGmyKP/z9SmTwzuIn?=
 =?us-ascii?Q?CphyPE90fs5jFJ01rGXg8kZGxW/Phh9dksSoIhP+pU0RYi1zjqRU3azoVyb4?=
 =?us-ascii?Q?/omu9ZUednKTF/D35EZFsKVzzRcQLHQFtFQh99dfUp6YpVpEnGjz8uXFv1eC?=
 =?us-ascii?Q?LNy00C4fL05yO3/tjGnNCbycPM4Mxo+QP+htyE+DCf/qgzenC9UkjLdF9WgI?=
 =?us-ascii?Q?AMAUrEt8cbirere+2ZfdvRXzFYABK6A4nPy+aAWDRlxKP9hwriLrDAlG86/D?=
 =?us-ascii?Q?KoCy4jCIxKHkMKxpeoOG8nQNzbnwBNWx20lHm0rWBYu9jSQOUFqHmp11QbgN?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaa9da0-9a0a-4099-382b-08db887e6d4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:34:38.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8+N4eUBRU/jsLQl093I4tG4tmWGR85X/tHsq4SeELPUiLTMYEMxIJc1RQee5oSSb+E7zmEA8M4u1f4eFxdJlJxRFb1SiaKLrEqosJnyy9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:59:58AM -0700, Shannon Nelson wrote:
> Pull out a chunk of code from ionic_remove() that will
> be common in teardown paths.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  .../ethernet/pensando/ionic/ionic_bus_pci.c   | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index ab7d217b98b3..2bc3cab3967d 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -213,6 +213,13 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  	return ret;
>  }
>  
> +static void ionic_clear_pci(struct ionic *ionic)
> +{
> +	ionic_unmap_bars(ionic);
> +	pci_release_regions(ionic->pdev);
> +	pci_disable_device(ionic->pdev);

Hi Shannon,

is it safe to call pci_release_regions() even if a successful call to
pci_request_regions() has not been made?

> +}
> +
>  static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -249,20 +256,20 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	err = pci_request_regions(pdev, IONIC_DRV_NAME);
>  	if (err) {
>  		dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
> -		goto err_out_pci_disable_device;
> +		goto err_out_clear_pci;
>  	}
>  
>  	pcie_print_link_status(pdev);
>  
>  	err = ionic_map_bars(ionic);
>  	if (err)
> -		goto err_out_pci_release_regions;
> +		goto err_out_clear_pci;
>  
>  	/* Configure the device */
>  	err = ionic_setup(ionic);
>  	if (err) {
>  		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
> -		goto err_out_unmap_bars;
> +		goto err_out_clear_pci;
>  	}
>  	pci_set_master(pdev);
>  
> @@ -353,12 +360,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	ionic_reset(ionic);
>  err_out_teardown:
>  	ionic_dev_teardown(ionic);
> -err_out_unmap_bars:
> -	ionic_unmap_bars(ionic);
> -err_out_pci_release_regions:
> -	pci_release_regions(pdev);
> -err_out_pci_disable_device:
> -	pci_disable_device(pdev);
> +err_out_clear_pci:
> +	ionic_clear_pci(ionic);
>  err_out_debugfs_del_dev:
>  	ionic_debugfs_del_dev(ionic);
>  err_out_clear_drvdata:

...

