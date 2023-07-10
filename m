Return-Path: <netdev+bounces-16493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A494E74DA16
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2A52812B2
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0912B76;
	Mon, 10 Jul 2023 15:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FE2F2F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:42:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10727B1
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbW6AV8jkhfgVDDdx7VW0QaiVKyWH6SG792zV0IRf7qUoDAwb+j30a+LldoDrJIqzqDCXKo8oR5BcBdw0F80UFH9eU5PCBn/HZ+mu6e+J++yMDqWWFnlVvr5GSWkX3se6ZIDotgMvNODYfuJWW1R0HnryzQS8191NFoRHT4Tv2Iu2BOK9i7XOMovuCjDiySwFkk8qeXG8lD7Y6hFzbWGGIlkaMNfHdzZpqyC2g2pP2O6Jebkks8zUsDxbGIltfoQf3klePcT69vG47AhkVoZsVbDHxf+AFiLyKpGcqySHvLExYPv72S5F0vw6PJYKiqFkHwcZwPikiZS5am+vLkKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/WRwx0uKuTeMGFwCtfZ+QL30TOUUebOoq286GdU1AA=;
 b=Pp/gGKO7BcExAlgXOeYL/uOpClZumSdognOgHNs82bqBGvVAPYnKA/MJD5erkP1EAuruTmetSJrZWJoXhRexyAXI73HIiayNCF0R9dVzxGtXWs/7D9Qb1AAO9siuq/lPzuPpsAvNH8IMA4dELM0aBi6qTWM1AIkv4Z8nCOu7zDeGt1q3MT7itZwS88wUDQ37raovO//D9MvDbegaG674MIEtl63SnfHoHunrgwBHGlkaMCQ1kqMmS05gYSnuJ7PwHfESsC9jKMMBcTA7jktYR7L44l0eaAdbM8hqL0Yl/jwC9wWP2Z9lkUS8Lp7+sSWm/4djC9IeJiszjqiYmB6VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/WRwx0uKuTeMGFwCtfZ+QL30TOUUebOoq286GdU1AA=;
 b=nVIimpip/gc98vsUGcR27N1AhBDoGVfUMPNyjRXKg8C/QflvSfvNv+xrN/pzlZyLEEAfrJ7cD8TBK+UJ8Ov31PHiNq3AE1De1nZ1FAmB0ub/m70wFYs6rEH6q/kx6SLIvX79PUHiE8kwE2JYUQh5822T/umlyH8efr/KyMnDFB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 15:42:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:42:23 +0000
Message-ID: <82bf6210-6615-5d33-e3c5-808cfa8cba6d@amd.com>
Date: Mon, 10 Jul 2023 08:42:19 -0700
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
 <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
 <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: b7388152-ade2-4b8f-859f-08db815c40d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IEhzTRQkYXyySbzyM8UD2k/aAVznviaT+vgk0eGpAQ0fY+ODfH3VVMdZdu4F3Sy3vpp3plf+cbZefbdUeMeHXsJ9zwr8V1/+QZ9lvloXGHSYKboAfoapEvH41+qiACKWfQ388oc07Kv5Ep0G7pMEtPoxT9yEBH6E6AbrgsyubIDsYnPmqDW3tkwCb1YlWuf+den6rY5dlEt0rY3EGtZfyNnOiQ9vuPJyNT27tDqFAjaljjp3tqZR8gAGDvhqAVKJmOUWkOq5pLicw9oXBc2V3d5pexmNWmcTUDxo8NHM19ngTwyec/8aS0RUbq7V4lsbzqoq4fUjDeOsIauKSuIb2YPQgj4ewESEgOKla891LFI79ziOPgqH39R/BJYbQGmUiAWOpm2SAyAomZowdo0EY4Fg9JV3BJ74gaC3lPTHTf5kL/Nin95xXnJamzAKOxeJgYtpaRfA8Seb0Skv/DyshH4H1kW/okKCiuhg/xVrEaQkpPG7Z7A+wy3EzPBxk/q6+XviPzUODXof6rdifqOTH0iQHuJvgoBD+bq0MDEDtgnRVKpU5PKPVRzCfdkwmTjQc+mAegORF56jiasWx/oapE546MYkgXa23xyAh26KFn5ePiHP8tK+l+Jd9T/0vsXZ/i5SaNHNny3dY7pBDCoFEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(31686004)(4326008)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(36756003)(2906002)(44832011)(26005)(6512007)(53546011)(6506007)(6486002)(186003)(38100700002)(66946007)(66476007)(66556008)(6916009)(316002)(41300700001)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJUVE5Zb01sWnUwQ2pHdStDQ24wOUhkQUs2SWNlajN5RTVzbmZaZC9GcEp0?=
 =?utf-8?B?WlRpeEQxRHFaQ0JGL3FTRFlMenNXUFZ0YWVJTk13THR1UWxwdU9yWVNwbjVj?=
 =?utf-8?B?V0dUVjlRTmNib0J1VDIyL1R1RXZWQ3E2QnMvUS92d0JpWlU5RTdEMW80NVJp?=
 =?utf-8?B?R2l4cG15N3c3MkhacVZ2d3ZVa1c1dGRIZEtQRlRMRGYvMC9WRm1JK2c5TzVF?=
 =?utf-8?B?d3dpcWk0NGlQbHdGOGJVZHU1SG9Jdk5TenlKeHdtSlk1bHl1M2FXbHI4MnJS?=
 =?utf-8?B?enJJR3YvdmI1QXgyKzk4L1V4a1VNek0wKytZajFlczQ5Q01SQ2tXeVhhdnls?=
 =?utf-8?B?MU5mcSt6TjltbFBvU3FVYW5QTmRVODdiTVY1U3JFT3BWaVZLcDhzZXRwMXE1?=
 =?utf-8?B?TkM1U2pYTmpPN2JoMHJ2NXd4TklLTEZhZ1lkUHVIMXNKc0YzV0FMSFZHZFRR?=
 =?utf-8?B?TFBjVGxKUDJ5aVBwU3h5S1VlcG1XdTdWR0wya3FwbmFBTDlpUjFjZEpqRmZU?=
 =?utf-8?B?b05xSUhiOVRUSkFTb3dFbFFPSjRoVnpmRDNnTWF0YjA3UEgrV0cyOXBoOEcy?=
 =?utf-8?B?eG9kMFBqRUZ5ZmRIci9JUmlyNDV0VDVoNWVpVUh5VGJLRjVKQWhITGFPYlpn?=
 =?utf-8?B?WlJRU0duelZWZDA3WXpQa1dzS0JKcFAyU3B3VWdxc0FTMlpReks5cjdEa1RK?=
 =?utf-8?B?Vm8vTFd5UTJRSHk1b0lLQ3ArWStvN0FQS0I1UGxaRExHVGRYYmtSYmlGNEY1?=
 =?utf-8?B?SWlaYVRhZlRJeERIWmRxeEFoM1loRy95Skg4ZFRZa2NIaFp1TFRxR1FLa29o?=
 =?utf-8?B?bE5IN3RqU1hpSWp3UEFzcjF3ejRFakFXRVQ3UmlZajFYT2p3TVhPTjZOa2Zq?=
 =?utf-8?B?aFJLdVlZRVd5WEdTamMwUDlBYjJOQXN0VTJkU3RSNzYzMmZvYVhmb1FMWGQ4?=
 =?utf-8?B?SjYrNXFrRkE3TDFQT0d0TkFhc1JJSnpTL0ZUTFYrV2dZcHBESjFSSFVyUW0r?=
 =?utf-8?B?ZDNLR2FEa0Z3b29PRU00R2MyeDhkR0NQQmNwMTM5ZE5DSTNJZm9mZnZBcW5i?=
 =?utf-8?B?QXcwZ2FOTUVYbWUzekdHQ291R2VITEJFcnVuZDIzZmQzY1ZYczJLSVJDdWlo?=
 =?utf-8?B?a0czWHZ1Z0RtQXBpMEFQZ2M4Q1VlUDdYdnFCNFc5ZEkvclhxOVBKN2tVUHI0?=
 =?utf-8?B?Z2FWbW9QSXNEbnpxQzFtUittWE11OWtmS0RDRWVIVUo5UHFIS3o5NFFWSEdo?=
 =?utf-8?B?RDk2MzR2RUFNajBJblVPTHFxNy8zQXNteHl3Z0t1NXFvUjJBOUdKMEJBUnJP?=
 =?utf-8?B?T1NDR3phZU5LN2dlM0REclRUeFBpZUlMbjNqL2szZzlwWXdUSytwZk5aYzNJ?=
 =?utf-8?B?cFBSY3BER3RWZnNnMzF0UFdXeUdiZnllZmE2MGpQTHlwa3d4TXZ2T0crRUN3?=
 =?utf-8?B?ZWVmc1lIMkQyM3M1d0VuU3k0WjVsNWlYTmdKcnRiRzdUdjlQYy9ZWUdCMjc3?=
 =?utf-8?B?TmEzUjV3eFZHalRUQXBjdGpJaFZQNzRRVHFyUm10OUNEZzgzbzN4dGJQT0Uy?=
 =?utf-8?B?RmIxZXpjVEpoNVRjTzZTTjB4cHJJT1VuT1lHcVoyN1A1dUl5aE9SM3hTanpw?=
 =?utf-8?B?VVFNUVFpZXdnS3Y5Mmlkbzk2REpKbEx0bmIrbDRCaFRDVzAwaGlqbSszUis1?=
 =?utf-8?B?K3pQa2VhUktJYTZ6U20zZENmSnZuT0t6V04xQkRSSVNHTWJsNW9BYWlYekVz?=
 =?utf-8?B?SmpDZVY1ZXl3SzFsbXJIdjlSWHlYSW56aTBkUXJ6aDFIUkRLRXJXU1lISE1F?=
 =?utf-8?B?RVlnR29tdm1jNVlMK0FkRVJILzVsSnBwMHVlSXplb2VXcElXR0tnMEJDNmtV?=
 =?utf-8?B?aUVvWnUxZVY3bXN2ODFERTNFV0htOXYxU3ltUVQxUHByZHBUWDMrbkp3L1Vy?=
 =?utf-8?B?dVo1ZDV5ZnQxd0lhMGgyVWV1L3JYc2FVRkpranlsK3BIQklidU05NjJZSE4x?=
 =?utf-8?B?dEhKM241SUZNbUphS001RGRYV2tOM0RCQTN5RzgxcTQvdjE3ZXRaem52b1lE?=
 =?utf-8?B?V1daSEFjN2xCNFk1MmJ3amcxR3ZpMnM4YSthU1M1ZW9XODVzRWM5K2daYTNB?=
 =?utf-8?Q?ioy0BQ9LObU6OBMeJ4uQ1EZZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7388152-ade2-4b8f-859f-08db815c40d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:42:23.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3frwtlYYXOSyM9r+qCzo50IgTUcebPI2gi8nDyH6l80on8bN4DlcSSx7LvoGEqDu7PtAdgkC7rzyVwexzOPUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/9/23 8:04 PM, Jason Wang wrote:
> 
> On Sat, Jul 8, 2023 at 4:12 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
>>
>>
>> On 7/7/23 12:33 AM, Jason Wang wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Fri, Jun 30, 2023 at 8:36 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>>>
>>>> From: Allen Hubbe <allen.hubbe@amd.com>
>>>>
>>>> When the vdpa device is reset, also reinitialize it with the mac address
>>>> that was assigned when the device was added.
>>>>
>>>> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
>>>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>>>> ---
>>>>    drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
>>>>    drivers/vdpa/pds/vdpa_dev.h |  1 +
>>>>    2 files changed, 9 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
>>>> index 5071a4d58f8d..e2e99bb0be2b 100644
>>>> --- a/drivers/vdpa/pds/vdpa_dev.c
>>>> +++ b/drivers/vdpa/pds/vdpa_dev.c
>>>> @@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>>>>                           pdsv->vqs[i].avail_idx = 0;
>>>>                           pdsv->vqs[i].used_idx = 0;
>>>>                   }
>>>> +
>>>> +               pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>>>
>>> So this is not necessarily called during reset. So I think we need to
>>> move it to pds_vdpa_reset()?
>>
>> pds_vdpa_reset() calls pds_vdpa_set_status() with a status=0, so this is
>> already covered.
> 
> Yes, but pds_vdpa_set_status() will be called when status is not zero?

Yes, but the set_mac is only done with status==0, whether called by 
reset or called when some other thing calls set_status with status==0.

sln


> 
> Thanks
> 
>>
>> sln
>>
>>>
>>> The rest looks good.
>>>
>>> Thanks
>>>
>>>>           }
>>>>
>>>>           if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
>>>> @@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>>>           struct device *dma_dev;
>>>>           struct pci_dev *pdev;
>>>>           struct device *dev;
>>>> -       u8 mac[ETH_ALEN];
>>>>           int err;
>>>>           int i;
>>>>
>>>> @@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>>>            * or set a random mac if default is 00:..:00
>>>>            */
>>>>           if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>>> -               ether_addr_copy(mac, add_config->net.mac);
>>>> -               pds_vdpa_cmd_set_mac(pdsv, mac);
>>>> +               ether_addr_copy(pdsv->mac, add_config->net.mac);
>>>>           } else {
>>>>                   struct virtio_net_config __iomem *vc;
>>>>
>>>>                   vc = pdsv->vdpa_aux->vd_mdev.device;
>>>> -               memcpy_fromio(mac, vc->mac, sizeof(mac));
>>>> -               if (is_zero_ether_addr(mac)) {
>>>> -                       eth_random_addr(mac);
>>>> -                       dev_info(dev, "setting random mac %pM\n", mac);
>>>> -                       pds_vdpa_cmd_set_mac(pdsv, mac);
>>>> +               memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
>>>> +               if (is_zero_ether_addr(pdsv->mac)) {
>>>> +                       eth_random_addr(pdsv->mac);
>>>> +                       dev_info(dev, "setting random mac %pM\n", pdsv->mac);
>>>>                   }
>>>>           }
>>>> +       pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>>>>
>>>>           for (i = 0; i < pdsv->num_vqs; i++) {
>>>>                   pdsv->vqs[i].qid = i;
>>>> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
>>>> index a1bc37de9537..cf02df287fc4 100644
>>>> --- a/drivers/vdpa/pds/vdpa_dev.h
>>>> +++ b/drivers/vdpa/pds/vdpa_dev.h
>>>> @@ -39,6 +39,7 @@ struct pds_vdpa_device {
>>>>           u64 req_features;               /* features requested by vdpa */
>>>>           u8 vdpa_index;                  /* rsvd for future subdevice use */
>>>>           u8 num_vqs;                     /* num vqs in use */
>>>> +       u8 mac[ETH_ALEN];               /* mac selected when the device was added */
>>>>           struct vdpa_callback config_cb;
>>>>           struct notifier_block nb;
>>>>    };
>>>> --
>>>> 2.17.1
>>>>
>>>
>>
> 

