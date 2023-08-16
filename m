Return-Path: <netdev+bounces-28084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80E77E32C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6671C21066
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED511C8E;
	Wed, 16 Aug 2023 14:03:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FBDF60
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:03:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4352715
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvPs1y4yQSmJYvAu9azUAAZ0PGpmqbbQ560Vvtbu/qzKaOppnuffQzhnKGetTOF6mp4thli/Qu7VHnCUV+TYNH7PuTDyVOH1b4arf5kqh4Y8Y69Ja19mdP7RqsukxiG7Yxdehfo5UowPWjy2xUhoaYhNKzPZTPL//fRaTbGqBMLbTBY1WoNQt6O6oU7petTYc7zsZ6nF/Yz677H2CiTnCCbR2poP5qVleMc71AtzTMUzlcxV6BCesJ7oOBIg+D6qxir5leM3iA9AOo2LW4u5WXENNRWNizuPTLNVZVhZvR64VtE/LOB08oR3i6wRMn+SKxaxvNhabEtLSmpa2OZRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou5e7U7B5CgY+8ia80u2otNFZS4Y98tlpqhzLXDotYE=;
 b=j0mVP6/WBZKAwn/VzyldWkg6qwYq0wimRbkcSagw824+ron52t0VFnb0XunRVIzz+f/0JYHsut943ItPgC6oKoeOUl8Ic0stLxxRBi2SLfEzAdQYCeDIS6sYyg/j0FIqk7rmMtqv6yE04mYAdY9sdvAybn+Fk6RSYf97h4uHvqXwfrCHP/YYcTwSeG6Sor0UDQ/VCUmwvGXnVmj0p0asJgs00Sq2bV3ADxVHobZYVgmawMNv38Htn8iVGdvPyNr1NYwk6yviYH57pAkWAE758+4taSLZqgQ4kiAK0pPqH3mNtjWS19C3F8gQYoeu3XqXnKIdE1RfOzxgKws7pLzW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou5e7U7B5CgY+8ia80u2otNFZS4Y98tlpqhzLXDotYE=;
 b=wMAZ57zknwPAYtiKoF7evsKJEcrufZMm/u5Wk1o+mjhaBO0H/ibYaTgmH9RKTwu2ZTJdW+M0/Qn+52E4SKzs1I15j+sv5yxQ6gKtrVF2MThvWgo8+cnGz8gkFwAmQaOgvj9s/n3t8PcfDQAsN8P2sLW1ce8SpRFewgNwVMYyeU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:02:58 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:02:58 +0000
Message-ID: <0d644ce7-88e2-4e51-8e04-5a39b80df5b8@amd.com>
Date: Wed, 16 Aug 2023 07:02:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] pds_core: remove redundant pci_clear_master()
To: Yu Liao <liaoyu15@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: liwei391@huawei.com
References: <20230816013802.2985145-1-liaoyu15@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230816013802.2985145-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: e8acbc13-fa3e-4ced-c9c5-08db9e617ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3hPAgIHYDgmgG5fOcXkdiIcsaCLXsxBZqTwH9R+KNRSLT3BZwv7i+C0vYImtfhOJa6981Vy8PtTRWKzv/pAsxGu8kRGxCrW+qtH4ckb95aAqIirbYNHuF0xxlidO4UUbr2VjjWK2ZqpQoAzBWuhJTpLcJSVeNV1v4Lwt7XrIhSPb6MhaGAKzSLf2ewbXtf4D8MZQQx3LpQRLMlD8RqKKopjbNfzBG1dFP9mm/R+za1olTI/enSF1RA4BjQTFn0QxUjdIaowYZ6ZYkOxgphBczzLsdC9G9xii81zyTY3H46PM/IuWTJF/HcN+rxudjb1tgl1mAsd/Sy3JDKMv7D02cTBmMuxOd7QgfzVWaeMzx/KMiNji5YtOKjwRopo+XD+TCT+xG8hiC/0+EEfpYwoz0iwHB8qd7oLFTZv7cJ0IoL1FNY8qss7Sww3vpqZuBOOX7Bh0MR1kmIcpL/ymXnUR0sO79J/YuTlDlR0rYFnwZBvr3Bw9VNseat1r9nNhMwzZnjbpDrEusVrt+4FrG1VwzO0vBhGTK/pnswCvhJw3ru5vqW0ft4wZROfKDdYQOUXenjBImgtoYRJfB0CDilkNrFgx6/fx91LdhCDgN3zYszl8mvnCnGrOP64BZKFxHF0B5305EvuMYcZNQ+t4DygG4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WC95cUhpT0NzM1R1MWJ5WE5LTWc3TUx4eHNERytpbnVRVTRlYmtYSUpZUmIw?=
 =?utf-8?B?T3U1U2ZHNVJjK0FWTFhrOWxsOXhVM2FoZE1xd253K3k1ZndzV0t6UDlPcTRR?=
 =?utf-8?B?UE1GU1F5SDE3NFZIaVZsNElLZkJBem9QNytLMUVkL3pLZGwvL1VFaEdmbzJU?=
 =?utf-8?B?eCtrbnErZFRIMlhkV1NPNG04akR4TjM0enFIVEFhdXYxVThOMER0OXhHVmtP?=
 =?utf-8?B?WTBKVkQ1Ky8xM09oSkdDMmRMb3JSNE9odUowUHd6bi9mZWVPMVJsc1Mrbmhv?=
 =?utf-8?B?bjNaeUJjeGR1SHJQVVZVK25YSDlaVmN5ME1vbEx4MStCcWhTK2VOZktyZWti?=
 =?utf-8?B?QnpWTkgveWxwYlBNL0JyNE5JZzNHK3BQckhqWWx6MjRSWU1WYXBvRGJmSU4w?=
 =?utf-8?B?OHYrRnlxTzR5Tk83Q3VWYkY2aXZvd2dCZm9wTW5rV2lzU0doOTBzQld1M3hP?=
 =?utf-8?B?OWx4ZkpSMlpScXVjaU56NStzME9MZlBwMEVlSFhsdzFFaE1lUUNBVVpXTmZu?=
 =?utf-8?B?VFl5clQxU3FEc0NCY3RTVTYvR0NEajdxOFlPMW9NTDl1U0dXVlFMUHE5Q2Jz?=
 =?utf-8?B?eDludlpvTFVtYXVJaHUzNStXUkQvY0tEdDdTVXU2SUFmaFJWdmpOMmxNZE11?=
 =?utf-8?B?aWZ4dmEybUR3MjRaYUlkWUhjTGMvY3M5SHNwR1RwUUdqUm4zM1ZXdVlMelpX?=
 =?utf-8?B?N3BVUTRxK2lDek4yZGxIc0wzU1BaOVlOZzZ5SmhVSWN3OXFLeWR3NEhJdFJX?=
 =?utf-8?B?NUNkODlzMlphN2JxOEU1WDdKNWU5SDNLODc0dllDOVgxb1NESDNuK2tzMnpB?=
 =?utf-8?B?RkRHK0NPZ29HNUdWK3R5SlFzOFJjUTdIbGduKzZudE8xRHJuVzFBVlYxR0ZV?=
 =?utf-8?B?WGFTT0oxY0NvZXk1RFkzMXdrYUZXamNkWlVwYTVZN2ZOTXhDR0MrZ1NHWlpU?=
 =?utf-8?B?eGx5YmJ1MHdNY2hQSEJ5eFA1bE9MRmRQaENYMklsVjBnYUx6QzliRVRHRnA2?=
 =?utf-8?B?V0ExamZWN294d3VUTFVUVUFRdU8yWTBCYy9QWlVEMU52N25lQ2hYUkdYV01k?=
 =?utf-8?B?S3daWWcyU213MEVNUXNGQmF1SHk1aU9BUE9NTUJ5d2FnZHZnUGU2TEROSVBD?=
 =?utf-8?B?Y1cwRlRZSUNseEdJb2V2UmZvS1hKVU5FcFg4bG5CMXlDVzhrNWxKczFPRzdR?=
 =?utf-8?B?c3pZVldFNlBBaFJZN1loU0Y4UlI5M1Z1cG9FVCtEdlRwSnlTTzc0Ymp5SzJw?=
 =?utf-8?B?L25aWmhLQ0dVYk84UkxpaC92TzR4emxhYzRoTytUSWQ3N0w4WlQ5UGM1bTNi?=
 =?utf-8?B?UmR5eUUwUE5jbHR5UExjQlhNWGZJc3lhcktNZHRkeEV5UURRUGhUV2RDdkNY?=
 =?utf-8?B?OHdlZ1VtSlp1ZTBWTWJ6b3Fyajg2a3FRMk1xYVRNQ3ptQ21vbmxrL3g5NExT?=
 =?utf-8?B?akR5RWpMNlM2THZzakVOM0F0Q2ZBUmhzRXpiNDc0N2FvWCt1dEVraDdNUGs1?=
 =?utf-8?B?am5GV21lK1UxeGtwQk45eTV6b1piYzdISEJVT1JGL0t6UGFGUFJ6d3IrREQ2?=
 =?utf-8?B?eUhaQm5POE15KytiUDFyUkt2QzI2L3FxU3h0WVBEYWU1elh5bStGbnB3YzNz?=
 =?utf-8?B?Q293Y3k3UWRadlQ1MjNJNis4QW92UURLZFNOcmlIUmtRcXc4ME1iRHF0by9y?=
 =?utf-8?B?ck1pc3o0Q1dobk52R2wwNE9qR2JFd1lLL3hUVHBZc2ZObWhXVzlFYUpFQld2?=
 =?utf-8?B?NXlGdEZnbElqdUl2YkpWRlY1VDNVb3Z3aHNtYlRIT3M3K09UcmlpMy92cjBG?=
 =?utf-8?B?a2d0RStuL3hBZEtBclFYcVhXd3pLd0oxTCtRTDFzV3V4ME1KSVdXS1V6Ty9p?=
 =?utf-8?B?QTZlR2tJSUtQNWp1c3pqeGg3NFBQRzV0Yi8xTmoyaGtZZ2p6VDlTY1RubElR?=
 =?utf-8?B?SWtLTW9BeDFKN2NPM2xqUllZWHYrMmFoYThJbnBZVTFkUzdZU1lBeDdtTW56?=
 =?utf-8?B?VmtRZ0x6YldDSHZsQTJhekZUcGFvT0pYZ08rNlpIZlNDZFBERHdKOENJRUlo?=
 =?utf-8?B?NitJN2czZU8vMmd6N1BQWGxRbXZMcEVCK0dPT0lLU3QyQ1FFbk5qYU16SWFq?=
 =?utf-8?Q?F1F3vEcIUTjMerz4wDdRMpZ+4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8acbc13-fa3e-4ced-c9c5-08db9e617ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:02:58.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SY8YfMdtVxg/LiifA1V07kEyEc59Ws3T9Nlwx2BYFT8XhTLbGSb/gLQDb98xvste45j93RgtK3L3B94SryyTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/2023 6:38 PM, Yu Liao wrote:
> 
> pci_disable_device() involves disabling PCI bus-mastering. So remove
> redundant pci_clear_master().
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>   drivers/net/ethernet/amd/pds_core/main.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 672757932246..ffe619cff413 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -374,7 +374,6 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>          return 0;
> 
>   err_out_clear_master:
> -       pci_clear_master(pdev);

Sure, this seems to make sense.  However, if we're removing this call, 
then we should change the name of the goto label to something like 
err_out_disable_device.

sln

>          pci_disable_device(pdev);
>   err_out_free_ida:
>          ida_free(&pdsc_ida, pdsc->uid);
> @@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>                  pci_release_regions(pdev);
>          }
> 
> -       pci_clear_master(pdev);
>          pci_disable_device(pdev);
> 
>          ida_free(&pdsc_ida, pdsc->uid);
> --
> 2.25.1
> 
> 

