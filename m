Return-Path: <netdev+bounces-16134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBC74B7A8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D071D1C2108F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B817729;
	Fri,  7 Jul 2023 20:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EA17726
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:12:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C072127
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 13:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvomwDeWOgdWxj7XDsfSLs++6l386QoBS4hIgf7zuViknbs3rO/OTUsJ+7eStk3N/+sIqG0aihvf6cR26M6Ve42H8KvWtyJ+P3YWkjRloQ8/16+82voBXcOrhqmQsj/Clc5DLJub4r/Jze2xeKm1in4ePviudr6VSdl8mEQENms07TpCI+VHP+yRldZoNB1yRhOg1P41D681A+wflLMqy13djCgNEz7J41Ydow3xcqga/tbFNLHr+n3IZK8geT1Rx/8MY9MLe3SAFgzLd20+GqxB8hoY72TU4eXV6ulk5DzN59xP53o9z4qTlRygiI96wnwyUZz3TC06ZF2ge49LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBnvPuTcVOfhPyRMf/RWvANGCknSpSMZMqJONk6t2nY=;
 b=k/EJchIKRw0inEA7iGEqo8l18/gpvB0RW6+JxTvECadDTFF4+lcwGahHRzvgM3lnnCtJc+/4T/DuQIljDjycXmqciHdm4gm4jwctfeigAyTJguGPTxLkrCVwR5zFM0wPSwQ1KLsseOEHGFSxd0XFGYayxggHY74lKPf0UpZArX/uhHHs47pWVX6fU7RRYm7NfQ8JSqmAW+Q7UJuudcfRQY5EsQntELHEgZzmg/TRoRdMpdlM48b1zQIYLWIxIII81LrbKfISgDFV0z47xZdk+FlkWCHq53bVD8krCvgMluznC16avJAsAC6fPGT98K28gchK7iSWHL+ekGT5NK8wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBnvPuTcVOfhPyRMf/RWvANGCknSpSMZMqJONk6t2nY=;
 b=s37N7wy/BNInyOhHqbN5Wb4FqMCGpwShBWdklNj9gqqz8loS8ETb4r2uBYBOmWf/PpI5wg8zN6SXxTn1tnRB/XhRL6unwFJBO6jGLJ+PAf1lkfsyx/F2azRyIOns9E35m026I7rqZ0PFyP9yzPCyq1wdsThqa2JBSnJwNIHAEtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:39 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:39 +0000
Message-ID: <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
Date: Fri, 7 Jul 2023 13:12:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io,
 Allen Hubbe <allen.hubbe@amd.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com>
 <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e30d87e-0572-4fad-e026-08db7f26834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9q/AZq7h+QGUydJF/DCO6OW8Jg8na+a5g6G/4lX1By+DOGX8HU/F8mtN+hNDYVlJhec8Ds2Bp4ZrfHzQKWRyo2HxqxC5zerIaBAHZG07awqN2WbpL1jvumopVQ6kOYmgM0lTFB5SogUP9Q4yi6x5lahfPM00wltfJlN7WnOQZFX7+yGM9H4rK+aYKNC28hpAWhmOCb25ns015k1aSrZv86kae7E7Twc/t0lMQRYw+2NTzX9tKB0oJZotTmJJnhQBdu576TRxQsXXl1z8+fHLtOIWiKudV9LTmx7Mqx+ghVmdlySmEwVpZrFhu3fwjDaAU+pZaS1ZhByqwVoxdQjqUXxfa6yt9TD9rlIW9xOm1NSn2+j+lawRrZzC19cf4oUDV8ku7apfOlkWL/lUHY/Yv8UReAoNvSMJQiu3VGSaAIGf1espl4tQId7IOm2SJ9v6lbNuAgbWP9V4w4HD+H/6VKNWg6i9pvMrs8rNE5w06Rc2u/JytNLHZVD3cshlrjxnst8FezoSy06Mt/CvJY/ho4wEGZi2UWatGb3KAgZ+m25y02mP9JuQm2kD8375HxYEqyv729wWmFizBxs/QB/vrOIXx76mrsjhUZf9GqFV9CjYFChlSj14N2f5AWh6YUNf+NSUyhiAV0hC4kkw7MXmsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUY1MVNXb3lDY1VqK0kzNDh6bmpmS08zdi9iQ3ZwM0pnWlFYOTFPY3NKNVBs?=
 =?utf-8?B?MU5RWGZlQkJYdjJHbkVLQWZoWEszbXlHUUVGOU16NEc4aEpna09tQmhTSTc5?=
 =?utf-8?B?dlNNZ1pyUEFSbGxQSFB6M2Z3cHRlVWlwdWZ3T0t6RVVFQ0pQMmo3aUxsb2pu?=
 =?utf-8?B?blROSFdyODZ2LzkzWEp1UExNVHovV0tlSGoxNzY4dkRoNFBTaVFEeHNKdGxo?=
 =?utf-8?B?YUxKUDJ5OWVmTE9KbFNaUmpialZWcjJsMDQxbUsrZlpRbSsvS1NxVlBQeWhi?=
 =?utf-8?B?b1FYUUowUVdkZU13aUhJVmk1eXNjcjJRTmZibDM5dHFVZ3RocnpzZ1JIZEVW?=
 =?utf-8?B?RnA1b0s1MGhXK0tvQi92Y09QU3hNSk51ajRvZ2dHRHRIR0htdEJIbnBPbFJV?=
 =?utf-8?B?SmNaejB4cXNNdytJejdXVkFYOFJxdmZveWl3VzlsQ1hneEl5VFJUU2ZYNEkx?=
 =?utf-8?B?S2ZTL2ZIWW5RbndMWWNncVlrOE84WVpEZnZORDQyVTBpcWJTMDRWQ1dwNFg4?=
 =?utf-8?B?K01hWmxqRzJwU1lrcjdRMFg2YmFCWUQ5ZEw3aG9mUCtpakI3OHRvTmRQSXc3?=
 =?utf-8?B?YnA2SzEzWU5UNUZSN0hPM2ZuQ0ZlT21kZkFXRldZV3NEMDBVRVl2RTBYOEFC?=
 =?utf-8?B?MGNlbkpKalRmUGsrekgzd0pOcFd6SEUzQ1p2T2ZQZ2VGME9idDJCUmoxREV1?=
 =?utf-8?B?eWx0cmJDS1ptOEh6anZYZk51YTI1ZVlRQm5yTVlHTmVPYVUvZ3g4MmZyMEZq?=
 =?utf-8?B?dWRvUU1tSU9nVlZkWnVMOERMWlZXcG1IN0gvUEI4N3JXNnkxa0ZlSWZyQ3dq?=
 =?utf-8?B?Tm01akhaNzRjOVdLd3dSenRCMDhHL1VlRWREVytqbFk2bU9ubFlFOWRVMy9w?=
 =?utf-8?B?eDhKQ1pkYVVPZkg3UFFpV3VuWG5MazN5Ri9tV3pXcE9lVERocStVcGdITk05?=
 =?utf-8?B?anFTN09KRXlaTi9KUjYxTk51L0ZtWlpReWpZWGhqT0dFa3BKVUVwbyttN2VK?=
 =?utf-8?B?YWp3RXRCdnQwZUVBMXZVWGFmSWNYTi8rd3BSRlJIV2YzQmlPNEozcTk2L3lX?=
 =?utf-8?B?RHMwUEhiYm1SZ1hEWmRIQktnUllaRlJ4R21oTWlXS2xpZVhEV3Vta0x2eG0z?=
 =?utf-8?B?RmdRUndrVnN3V2lncUh5UWtYbUdjOXg5WHVXcEF6c05zZEp5eC9pTHJxQ1dl?=
 =?utf-8?B?TElaQVhiQjQrNVU2ays3UGdORnZwcXZubFJValUxTHE1LzczQjZFK3oxcCty?=
 =?utf-8?B?TUdST0xRNVlETDVGSVpObVcwbEpQR3czWkpkN2ZwVVRwSUdqcWZ6RzlFd0JT?=
 =?utf-8?B?L0VaT0xwSGhraTd1UEJUeVRVNzFodGxiY2lhYW14cVVQTmpvS1RMam4vUXZP?=
 =?utf-8?B?ZnREMHYvdS9LK2FEaUM3NnBCMW4xYnlFbTd6YzBiM1c5Z1M0OHhMd1FJQnRy?=
 =?utf-8?B?eE1YWjZTbXY0OEpXamY3dURGdEFKbExSTVRPNkN3djlCWElPVlIzUUNlU2t1?=
 =?utf-8?B?MFRmNzg4UzhIUUViaThIYjk0aC9lODByZ3JYZW9TL0p4RE9mcWVBdEVmR2Vq?=
 =?utf-8?B?ZnRBQ1pQaCsyR1pDY3Zrem56emFGaHpWTDhyV0V1OGkzaXFlMWVBSHNKckRN?=
 =?utf-8?B?eFpwemhLWTBhQ29ZVm9FbTJjd1ZuSkhCeUZoZVkzSmVXbXdhd3ZxY0swRzg2?=
 =?utf-8?B?K0JkRk54bnYvTDRQODlEK0l1NDR3dmkwVFQxWlI0anB1dUdSRlh1MkVody96?=
 =?utf-8?B?MVdMVjJ3VHBBeVlxWFlSUHZlY1RBaUZ4YzlpMlNYTDdNcm1YQ1dMSkt2bXlr?=
 =?utf-8?B?YlJxN0VMU0NPOTQ5NzQ4cUNQWEVZeGJ2eW1NdDNGWFdMcEFDa0VBQ3kvYklr?=
 =?utf-8?B?OUhxQ2ZQZ1NXdTQ3cXlCSkhneTJ5RDNSUVFPbHlYL3BoMTZJZlNhL0czOWcw?=
 =?utf-8?B?SG9tSnl6ZTVxWkxSVW1YMDBaTkx3SWF1RXVZTTJnYkMxdzUyZkIvUStJWG1h?=
 =?utf-8?B?SXZodFMxTi9ibncvMzRzbXBXUEwyemRqdmhic2ZQdFhkbjRPWFp0VUE1OWlL?=
 =?utf-8?B?NDJGV2V6V2g4WDJFditKZGR4V1hoaDFEaCtnTkFxWWhwWnZMdjJCdEdBZEpm?=
 =?utf-8?Q?J59HqqflwVPAEdXU18h8tS0Ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e30d87e-0572-4fad-e026-08db7f26834c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:39.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXRpvM/X+J/EQKoZLg3lsD60+OqaNkQsAGQ3gW/ltVXIXwwc6dbzEiFeyA9+ge6PpcmftyOWr3uaJ5TacQlW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/7/23 12:33 AM, Jason Wang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, Jun 30, 2023 at 8:36 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
>> From: Allen Hubbe <allen.hubbe@amd.com>
>>
>> When the vdpa device is reset, also reinitialize it with the mac address
>> that was assigned when the device was added.
>>
>> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
>>   drivers/vdpa/pds/vdpa_dev.h |  1 +
>>   2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
>> index 5071a4d58f8d..e2e99bb0be2b 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.c
>> +++ b/drivers/vdpa/pds/vdpa_dev.c
>> @@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>>                          pdsv->vqs[i].avail_idx = 0;
>>                          pdsv->vqs[i].used_idx = 0;
>>                  }
>> +
>> +               pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
> 
> So this is not necessarily called during reset. So I think we need to
> move it to pds_vdpa_reset()?

pds_vdpa_reset() calls pds_vdpa_set_status() with a status=0, so this is 
already covered.

sln

> 
> The rest looks good.
> 
> Thanks
> 
>>          }
>>
>>          if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
>> @@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          struct device *dma_dev;
>>          struct pci_dev *pdev;
>>          struct device *dev;
>> -       u8 mac[ETH_ALEN];
>>          int err;
>>          int i;
>>
>> @@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>           * or set a random mac if default is 00:..:00
>>           */
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>> -               ether_addr_copy(mac, add_config->net.mac);
>> -               pds_vdpa_cmd_set_mac(pdsv, mac);
>> +               ether_addr_copy(pdsv->mac, add_config->net.mac);
>>          } else {
>>                  struct virtio_net_config __iomem *vc;
>>
>>                  vc = pdsv->vdpa_aux->vd_mdev.device;
>> -               memcpy_fromio(mac, vc->mac, sizeof(mac));
>> -               if (is_zero_ether_addr(mac)) {
>> -                       eth_random_addr(mac);
>> -                       dev_info(dev, "setting random mac %pM\n", mac);
>> -                       pds_vdpa_cmd_set_mac(pdsv, mac);
>> +               memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
>> +               if (is_zero_ether_addr(pdsv->mac)) {
>> +                       eth_random_addr(pdsv->mac);
>> +                       dev_info(dev, "setting random mac %pM\n", pdsv->mac);
>>                  }
>>          }
>> +       pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>>
>>          for (i = 0; i < pdsv->num_vqs; i++) {
>>                  pdsv->vqs[i].qid = i;
>> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
>> index a1bc37de9537..cf02df287fc4 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.h
>> +++ b/drivers/vdpa/pds/vdpa_dev.h
>> @@ -39,6 +39,7 @@ struct pds_vdpa_device {
>>          u64 req_features;               /* features requested by vdpa */
>>          u8 vdpa_index;                  /* rsvd for future subdevice use */
>>          u8 num_vqs;                     /* num vqs in use */
>> +       u8 mac[ETH_ALEN];               /* mac selected when the device was added */
>>          struct vdpa_callback config_cb;
>>          struct notifier_block nb;
>>   };
>> --
>> 2.17.1
>>
> 

