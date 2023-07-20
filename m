Return-Path: <netdev+bounces-19294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5175A316
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57F61C2125C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE519F;
	Thu, 20 Jul 2023 00:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080C7F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:04:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF62122
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFz4hiYdFWzHDtv6OxKmbqf+DIs4lGnCKICS5QDH/Bk/MzY/d+QHIeW5yax25hL+bWAHFk8NIFaIOtL4SDjiFESrAk8QEiCZzot3gaz9wRIBjE8fuPelMDmXwhjr6ZO7rA76rxuMD/oYfPwlnrk0A7OHTpSmsEYy1zdh/bxYxCxf36dnLafInqgvOquyIV7TmR2VViDjt6DehVhiQtt9u9x8Cn27yvNIOTBLkht6B5014dpI/TwyKZBicv2A3cNMIwg+ja7Lfjicse98i3jNqkboPS3wCng7U4fi44vgUAMWbEUJ8Yneg/7W5OC8PDyoGyombOR4lQfm2QF2W9pRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu+6OYSidwesmNod4ZkSYcHeUeZmQrScckXBGKIBvEE=;
 b=OvP5oJ69grcOCxHFNcOQ75GGaTOzDt/GtB59xYemuVd2aJ2D17nV2JFVUqazES0xi8X96MnUtICOP7V0GOpuOwAgyeE7kEgpLLJRrp0STZif8hF/WAgoPQyAqpHCWMXp7JJpqqh/lvzxisVo7f/nVYP73LR3ehwvvhHVI0tkqJBTYLLFttjHcv4/mSfGsJGFit3N6h53G7kjj5Y723bx2pjzkVPxwJ48BiZq5ABIetonU1yjR9sZ6+RMLtEWVc600N00h7U7dlhoeay+fPZSoFU91UpMIdadXg/O8yu3NulO0JLuIWZHfhitVZjbK24j3pPsKNkWXyUxwEDvGjkoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu+6OYSidwesmNod4ZkSYcHeUeZmQrScckXBGKIBvEE=;
 b=wHX8A9S9VBFoLRZfu9sdh7/E39IQPjiUq6c7b4HrlHzxm3XTjPct+Y7DS/kLxA9RaKS9yie2Hlk2KdvWYZgByrhgINYye1HjapwmIna6aT+4KPyGvjDrd+7hrQMVplevcr5MBECPJt+E5Ognx/j3L5uYCFh8izOt9Rz2V2Cyvpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 00:04:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 00:04:04 +0000
Message-ID: <c7b11c42-5ab4-242e-f6ca-e81eea97192e@amd.com>
Date: Wed, 19 Jul 2023 17:04:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 net-next 1/4] ionic: extract common bits from
 ionic_remove
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-2-shannon.nelson@amd.com>
 <ZLgepziaYuIHL+pd@corigine.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <ZLgepziaYuIHL+pd@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b5f263-fd67-43be-7d77-08db88b4d44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nu2w4UGuln4Ku7Tg3C82UrUv03KaFPw8LvWrlFfl1B2MD9dSmUZdBIRQHrEIB+ek6hDN9DKcrovpckINJjjHDp7vH5lR/P9ksMJlyxNTzGCNsNHUAeOsgfPk/t3yYqA4pd4r5V84I1maewTCcWnTXlgGWCUqlh1s45niwOMD7tgqVS3eIxzSyA+4eP/LvP3LGOscImZmAjlXbDxnYMkdumFOSmDqiqwoSO9kt2lEOKAq4SRCED3jFXyGRyJwzetHqjddAcN+ajD12BXkRkWNxL/roo6nA0Q6ZiAEy5gMsjeIGCLDuzCTGJrZ5hp8Ok3NiKb1+yZvONHM6vt+t09/HrRRNw42zgR4zfCEnDSi2ikow6iFAMxx79tm9UbA1I5woEGKP0EzaHHw81uEUHOjosVvWnGC8TqrHgWAlmE1Z5iYZ5qg1yZ6uVwlBTaVAVxnSqSr5yOqR6KnfhtyZmfQNpH6wAtLX1YEqPyKwSSG8+qFuc7SipYrK3wekHLFRX3dh0DuHEEwtBqQKVPnEwhCilTg12UF+4465qnvKkuAuckaHXy2vfN7i+68ti6CWx9wsRZVc+hLK4WSolddMGk46cAezMDR/R+v1Jjr/BmeaxKjt1rG0AXbKFxgiMaeqTCtm1X2/211NlWjtZaxXbN2Mg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(6512007)(6506007)(53546011)(26005)(44832011)(66556008)(38100700002)(36756003)(8676002)(5660300002)(8936002)(86362001)(2906002)(4326008)(316002)(66476007)(66946007)(31696002)(41300700001)(6916009)(6486002)(6666004)(478600001)(2616005)(83380400001)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFBuZG16SFA4NVo3NEFJVWlybHFaUVkxQjd4NHVWSFRZOVpMTUZiTHdnSk1n?=
 =?utf-8?B?a0lnOE9EZjRhZUxUMU10cU1xU0t6Y0toVTdheXZoUDBkeDZzM05TOGtKb05N?=
 =?utf-8?B?Qy9wQ2xYc3l2VFlDTCt2LzM1U1BVQW5zT0xlaG5yYUJVWUd1YkpLSlRRMUlJ?=
 =?utf-8?B?NFVpUzVzUjF1ZlhPdUNscDdIaTVWTWVnN1VXaFpnTCtESFhPUXkzTjlDVUpK?=
 =?utf-8?B?Y1dmM3VZSkJocGhIOVlTTFVGR1Q5RzhwOFJ3Vk1WaWkwU3JnYmFNK3NaaEN2?=
 =?utf-8?B?bnFBZ0x4aDFKK2M2SWdoeWtPbGZJWnBtM0RYTzl5bWVGS3ZGQlhDSDZYTkh6?=
 =?utf-8?B?M0ZLTVNieWZTTXYwQkJzaTExSDk2SjlHVGY3QWliUnZjOUpsVGdzeWF5aFp6?=
 =?utf-8?B?b2JrMFBaVVVqOFFiaksxbTcyMFVaOGtVbVdDN2FOelhUa2tUMi80dlpKY3RP?=
 =?utf-8?B?L21Zb1cwenZTZ2lXMml2VGdYQ3IzVFdnSTVnY3NBbXkzQWttYU9rR1IyM1pT?=
 =?utf-8?B?WHk2dnlaeDJObi9UaFZNWERPMmg2NzVIU3pCKzFJY0Z6MFB1b1o4K0xiRjV6?=
 =?utf-8?B?UVZyTGJHaTJLUDZiRjFqNFBnRTVBS2s5NkFZcURJT09jZlB4Z0hlQjRkbzdR?=
 =?utf-8?B?bkU5MXlhelVxUklUSlUwcjdGSEdnWFB6Si9rczlQSVMwRmxRM2RSZ3p6L0Ja?=
 =?utf-8?B?VG9BVmN4QUxnaldvZSthTGFsZVpFUHNyYXZycGx3MS9ncDlQMjR5ZVVmb1Y2?=
 =?utf-8?B?eWovbThtUUZmNEJReW9RaUE4WHNaRjROVlBWTnJBb0ROVzRsZkloc0dTRG9r?=
 =?utf-8?B?eVFIb1NybXR4SmZSZFJSbSt5RW12ak8xOTVBMWZEdUxKMEdIWm9kUzhVVG05?=
 =?utf-8?B?ckJMQTJ2eXdobEN5blRIbjZPVW8wVzg4c3d1QlliMHJJd2wxbm1hN3hlV3Bj?=
 =?utf-8?B?WmkxaG5wV3JOQm9lVUFZVXk3WlZ0UFFWaXU1bEVXN0NjK0xMQVRPTy9KUS91?=
 =?utf-8?B?U2ZJa3A4ak4vcU9XM1Y5a2N3OGQ4TFpDQVd4MzFBY0puWXFhOGVJOWRDZEVa?=
 =?utf-8?B?SS90TlpmOGlPbGNiUWFLcXJyS3YvbUsxT2hsb1FLNlREVGdJdEIyOEFjQUgv?=
 =?utf-8?B?c3dNOG4zTm93aEZyS1V6NmgyMkJyZUk0cDY3T21JU1RXZ2xwdGxKdEg0M2FI?=
 =?utf-8?B?MGQ5U0FLVGZ0WDJWbGVwb3ZBQzBZaVo0bVBDdUdNOElnVWZ3Ly9ybkRkTHpQ?=
 =?utf-8?B?dWJtWVVBMVFJa2x6d2d1RHlEaXh6Zk1naElvZ1hRZi9kaC96SzlkSVBXUUJz?=
 =?utf-8?B?RDlRaldlVGxMbDB0cUNPWkpZR3pjN3RKVEJoQ1pDckVRQjBEUjF5WHJmMUln?=
 =?utf-8?B?WlVhV2h5NU5xbEhKN3IzNTZCbm0vYWw5MVNIVzJ3akROL3BGYnF0RUU1MHJL?=
 =?utf-8?B?Vzd6QjlKY01Xck1tcWRldG9Ya3J0UkE0MldWWnpDZm15VmREck9DMWY2V092?=
 =?utf-8?B?QTZ3ck1BQVNSRFRUVS9raFNDQkZlRmJFZUl6WE9wRGVib250Z1JRdFRDTDRV?=
 =?utf-8?B?MSt5SDVDQWc5cElOMW0yN1JRMEhiMkp3RCtNWHFabmZDeUZQeUlNdytpdlN6?=
 =?utf-8?B?LzkxUm5HL0I5RDZWUG04VkNMU0Z2WUYxbFZscjR6ZWY5c0l1M2NDRUdCUzlz?=
 =?utf-8?B?eDlKcFdhZllNY0RKTDRZNldvRVd5dTRPSkVGQVVNcHIzUVVQS2ExR3VmaHV3?=
 =?utf-8?B?ZlhYSS9PanNjV01wUll0MjdjNUwraStRT3hpdUgzcTVlYitvZlB2Slhhb1JI?=
 =?utf-8?B?RER4VWwyU1dsWWlrRFVTWGRwRGh2RHlZbjIxWkd1bW53blhyeVp1amtmbm9U?=
 =?utf-8?B?YkxJbE9XdHlHcXJkV1U1NTZhZzAweExLQmhJdkQyWUd6UkJNN0tFZmMrMmxP?=
 =?utf-8?B?OTFNdm90bGI5RUpmZHN4UzNBMDluQ3F5R1lMWHgvSHhya0ZQWmVPVFIrYk9H?=
 =?utf-8?B?VVpBZ0lTWGZLMnZ2Z09iUzVkMkVaTFVwc2xBZ1BxYU5QM1FHa3RHU2xRZEFB?=
 =?utf-8?B?SUxUUFpmMHFXQ1Y2NlZoaFkzdXhuZXlGSStTY2pPMUw2USs5V3FsMTNIdmVv?=
 =?utf-8?Q?lsCycyWdXSjbOE5tIVKbsspVM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5f263-fd67-43be-7d77-08db88b4d44c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:04:04.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8N0xCn76cWCGuQjw1om/3wKCBvvBhCDVY1oa6RT/KXu5RmEf4BgmipOlZIkOLOQU1ep+1Kz7VcYjKdnc+z++g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/19/23 10:34 AM, Simon Horman wrote:
> 
> On Mon, Jul 17, 2023 at 09:59:58AM -0700, Shannon Nelson wrote:
>> Pull out a chunk of code from ionic_remove() that will
>> be common in teardown paths.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   .../ethernet/pensando/ionic/ionic_bus_pci.c   | 25 ++++++++++---------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> index ab7d217b98b3..2bc3cab3967d 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> @@ -213,6 +213,13 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
>>        return ret;
>>   }
>>
>> +static void ionic_clear_pci(struct ionic *ionic)
>> +{
>> +     ionic_unmap_bars(ionic);
>> +     pci_release_regions(ionic->pdev);
>> +     pci_disable_device(ionic->pdev);
> 
> Hi Shannon,
> 
> is it safe to call pci_release_regions() even if a successful call to
> pci_request_regions() has not been made?

It complains a bit about freeing non-existent regions, but otherwise is 
safe.  Of course if we're on that path there are other more seriously 
broken things for this device.  I figured the cleaner code is worth an 
extra log complaint in a probably never seen path.

sln

> 
>> +}
>> +
>>   static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   {
>>        struct device *dev = &pdev->dev;
>> @@ -249,20 +256,20 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>        err = pci_request_regions(pdev, IONIC_DRV_NAME);
>>        if (err) {
>>                dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
>> -             goto err_out_pci_disable_device;
>> +             goto err_out_clear_pci;
>>        }
>>
>>        pcie_print_link_status(pdev);
>>
>>        err = ionic_map_bars(ionic);
>>        if (err)
>> -             goto err_out_pci_release_regions;
>> +             goto err_out_clear_pci;
>>
>>        /* Configure the device */
>>        err = ionic_setup(ionic);
>>        if (err) {
>>                dev_err(dev, "Cannot setup device: %d, aborting\n", err);
>> -             goto err_out_unmap_bars;
>> +             goto err_out_clear_pci;
>>        }
>>        pci_set_master(pdev);
>>
>> @@ -353,12 +360,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>        ionic_reset(ionic);
>>   err_out_teardown:
>>        ionic_dev_teardown(ionic);
>> -err_out_unmap_bars:
>> -     ionic_unmap_bars(ionic);
>> -err_out_pci_release_regions:
>> -     pci_release_regions(pdev);
>> -err_out_pci_disable_device:
>> -     pci_disable_device(pdev);
>> +err_out_clear_pci:
>> +     ionic_clear_pci(ionic);
>>   err_out_debugfs_del_dev:
>>        ionic_debugfs_del_dev(ionic);
>>   err_out_clear_drvdata:
> 
> ...

