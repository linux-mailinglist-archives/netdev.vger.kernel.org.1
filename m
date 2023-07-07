Return-Path: <netdev+bounces-16136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0A74B7AD
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99569281897
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E71772D;
	Fri,  7 Jul 2023 20:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7817AA1
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:13:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4576A1FE0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 13:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipYDQ1CQ+Yo6h9eh075c3afOQLwuYr5aMFWK1DJ/ud6tckG0gNqIQ6j569gJQncrXVDeHqN0yq+vVvidSDZWMRzbmJOnqIdGHQbobSPtF9kWjyi5h9pYOrJu/xvNtcnI6MH79lonlz/qEfWE9Cdj1pivZoDI15SCo94AXIoYOPVuUbNablQ1zZAOqGtfQ4VXezWmomEa9K5FGbrMmehb3MwC4D/Q8v/tyMQkXDZsuww4EHBs8IOTsboDphGLLDhvDzhpXen2ZiIcXuwDmAXKKA96+1L5Gx8wbrepbdFQtVUuLW8aatW7cgk1U+dQT4UjDFdrEO6n1Zfte2qWPO9TfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwXm8e+CkPlmVfmD6Yy79Y1Oc94hzdvG82+QQbwYKgQ=;
 b=ImUHn2u2nmLl5UFsPbZ2Ecb8ijVJXZZtBwLaHPY2LhGdLAdlv26NX3NVJaj+NasyRoSqaj5tZPf6S7e3d7m8x6sm6EzBqLf2bqhQk1koMeG4yAHm1OyUF3CTjpZWGy1VD0QB9YWZGjFWbJzIuJOLDFdeFEodQba+5nMvEmn8tPICBbTMnsCyn9Vm2/eHjTe7rTOzUMFKK0pYJSFvkAUqcqCfJPcEvrDeToinKrsbvGQPaGUd2SAsuEkkr5/S5uSxgL2I47H2wJwT+/u3e2VpeLNhrDJu4GN7VTGh+rd5M64h2ai0VoGH8nHTbmvParr0TreGeTs5TUSVr6EaZw+xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwXm8e+CkPlmVfmD6Yy79Y1Oc94hzdvG82+QQbwYKgQ=;
 b=cNZbBXnuIja/zBceq59C22dSZPTsqI2JR5RGsR8S1Pfh7pBpyW/GdBM41tlNukhh3gd6f5LvAOfEajep1s96ABVNI6YSGEYRRCoP46nujAPmeCN2irc9Exrn1ArVE6x71ugb7tevo4ichHb6a2Xjqs5bhD9qww6rdkkpW/PjBHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:57 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:57 +0000
Message-ID: <4345f212-c919-d2fe-b47f-919629ef69b0@amd.com>
Date: Fri, 7 Jul 2023 13:12:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 3/4] pds_vdpa: clean and reset vqs entries
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-4-shannon.nelson@amd.com>
 <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: afab2fee-db5c-44dc-ddb7-08db7f268e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNcnD8o7II/KnLKFnMxk158BkhwrI3dxbmY5VouRBU3negJ36pD94m1ZFG/qyH8HshtH+Ec6K77c1TbtxN05JiB1Y1UtQN1QaBRbLirIGIPL/JEwcomIAEqdGPCj/ID8PzyCKLYnviMTeaLmqQtHMUrXs/K/tn9TC6icZVY3dYNGg/w8bU/9T9FV0a6xBsytfkk++bC9/t2qRNJLTGf22I2tmxAddxg896M8SebYDSbV3wkGYGNWO86gMsaF1mARBH7pk43OBYElAfMs4IqGzerT8WNozWREohMdjixTCyJ4OLSsiBrCjVmcppJp2lstro1/u+x7rBiI0EQoax4vzqRdWGnUdmQOPYBnn9LLRFyGg2emoDFp93hHJa3hlvXiQjbNZWhy0+gHAU/STeT8XY9mwZDtoDCAL0C0QVqHgYxf+HK2oH/9CDo1qbfHHBEpp2jrajsVZYSsyBjzicqU+J+jA/kAyQcC1rm3z/v3n37PLWlZwUmmtX27UXb6RVVDo9VN9Q5fWqd8UIE9kFpd96pQnY0K+x7gZLl0LkkaGpIsCf76gac3vRawRk/eNwLAK9XbwLmdgU9YpWuRVcN2YpawXA0KmV/BeA1ul/fUIh6iSIJaKHP00NCjCeeGMVaQYfEC0VbFnjJWAnJcbRKWcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFaS09tZnc2K29FbUhtODdlcFpMemNMd2ExNW96RXErQ2xiUjF5WVF6dHNE?=
 =?utf-8?B?MEFBcDJvYjB5S29yQUg1NC9UcnBYejdpS0t1cmI0d0VyQW5mMW95VHhrRXJ4?=
 =?utf-8?B?bElycWVaZ1VwTVg1SGNKTTFOcXpublNyQXBybzErRjNzcVFGcndGVWFQWFdF?=
 =?utf-8?B?Q2U1SDEzdkE5clFuYnVTaUpsaUNrcXBTTHJPWC9ZOEpHOGgvMkNJWGg1QWc3?=
 =?utf-8?B?aGo0TFBJSmo5cFNmTlBtRzR4RTJlZ0dWUVNlcHRKOHVaQUdGWE5jWkgvNnJZ?=
 =?utf-8?B?ZnRvUktTeGQ5cFc5SUk2dUI1MnZxNmdkV1J1K25mVExzeVlwWFBSWDRzYmQv?=
 =?utf-8?B?SlZBdHlOcVRZMEpEOVlheVo5RjRLU2lCYW5kcWJFUFlQRUpoNVN2eHByQnk1?=
 =?utf-8?B?USswY0ZCSUp2dVhRbENIRUJuby9SRFBFTE5yQWVJaDJnbTl3YnFLaFp0TzBG?=
 =?utf-8?B?U01ZWFFJWkdlRTNWeVN6djlkd3FYMHNCSUlkelM3WWpDYzhRcUdTcXhZSm5F?=
 =?utf-8?B?TUhOYXlRLzljRERlWkJhM3RMRVVTTkFjaTF5ODhDVys4MFh5NitGaVI1QVZy?=
 =?utf-8?B?RWNPU1NtSXlRZmszbEZiY3ozT1FseTNaODR3ZnllZ2FSYm9ON052QXYvUkhV?=
 =?utf-8?B?VkllcjUzbG5IZFF4NnZKcGo2NEs3Z1dFYmlRWExqU0piTkZQODdPcDhjTTFT?=
 =?utf-8?B?MnFuVi9QUEV3UjRZbHJjemZCYXI3MGJNaGF2UlhHOHg4OVdGTmxFaTM4RG94?=
 =?utf-8?B?cjk3cjE0YU5lTVVndDJhdFhveW9yanlhb1BQL2RmOG5lKzdmQ2h6alNGenBy?=
 =?utf-8?B?WmxvTlpJci9PaE93bzNoRmVyWThYa3pPZjdLeklwclRSMVpXYm5VOUd6Qlpx?=
 =?utf-8?B?UFJoWStMUW53eXlQL1NSNTgxdmw0bDVEdmdhdWhYZGVhRWtIc3A0SzhNRE90?=
 =?utf-8?B?aVFZcHZDVzNyM0twSXdlaWJYd005aFdtQnUyUW9XVXJyRkQyZFpjWnFaeFBi?=
 =?utf-8?B?R3hIM3doSWJxOGl3dmdzcE5vMEhnb2VlMW4vcnhpNlplYzBmTzdTeVNCUldo?=
 =?utf-8?B?Kzdka1piR3BrVE4zUDBHclUrWDBkRDBGalRNYnNZKzVJblZFZDBrUmdNcFVr?=
 =?utf-8?B?UTNMU1NYWU80dUwvdDhzcWdvVW8xNlBUeStYWTFDd0ZHSGRVWS9XemRnYzZE?=
 =?utf-8?B?L2V1eDM2ZUdwUWRWY1VqQXJIam5XVjRFWVNvckFGbGNwTnlYNjVWZXdUbjhu?=
 =?utf-8?B?Y3RLY3UvWjJrbDVjTm44bllTYkhwVWN6TzdJL3UydDhzaFVyMWw5U0V4aWJ1?=
 =?utf-8?B?Qnk5RDRqdUplOUtNMVJHVkV4c3VUNXlNQTJlWXgrdk5Qb2hwQ05FRFVHaXVC?=
 =?utf-8?B?QlEzZ1d4amwra0xQY3J0QytVS29mamhENjZGRTMyR2hhdUlXYWhXbVpvcUYx?=
 =?utf-8?B?ZUtieU5SSXM4UDdhTjlJRm5UMmlRRHpKV3FmbXc0WXo0UEE0WisxbUtNUkhS?=
 =?utf-8?B?ZkRTemVTMVNHdk12cW5EeHBQODRCVVRtNkgyMkJhNjV2OUFObFN3VSt6dUZr?=
 =?utf-8?B?MjI3SlpmM1I0czN3bUFnYlB2WVhsbXFzaERaSllOQ2Z1b1VrWG0vQW1FelhH?=
 =?utf-8?B?Wml6MjVPWmhLNE5kWGRWcnc4aTZZRlJXT1F0bjJxbkpCN2ZzWCtSSVRkWXRO?=
 =?utf-8?B?emZsZWthR0dBa05XVVozMU9pK1BuV3lmbVFlNTF3NWV2ckhlclltNUpVZzc0?=
 =?utf-8?B?eHRrVjdaaHFUenFES3hwZzdtOVp0WVdHVlpIT3JESjdKVlVyd1JNOWJIMlRR?=
 =?utf-8?B?Mlhyb2FFcVh0Tlh5VCtPM1VVTHJGZ2UwWnNZNU1NQ1hzWFJrRjlmK1BwOEl2?=
 =?utf-8?B?ei9WL3dMM2J5d3VEZDRsb0FIbjZxVjJnNThsRkZaTW5BYUVkUTJMbnhjUFE0?=
 =?utf-8?B?V0MrZVppcElBNStGS2Q1WGdOK21yVE9HZ3F3dU42c1NtbFNVQ2hpb1Q3NllS?=
 =?utf-8?B?SDNRMjMza1E5RTcwb2U5REwweDhkdGxHSnJTVEdBRTgyNlVlODlmZGNtNDVK?=
 =?utf-8?B?RmVhVEJOY1VCSVc1cDdwUHNFNkRJcE16eVRKbCsxMjNxSHhPZXFwcGpkYm9v?=
 =?utf-8?Q?N8dbBbf4UmEK8iRRuzMjuAHoi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afab2fee-db5c-44dc-ddb7-08db7f268e12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:57.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzKp6N/y2cBLEa6Mk1WVjz93yIeO7Sq7BoPQrzkG8XgtWsAoc3TqXxxB/GP2ZMEkqaXjtIwkl4cExbBGgjoqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/7/23 12:36 AM, Jason Wang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, Jun 30, 2023 at 8:36 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
>> Make sure that we initialize the vqs[] entries the same
>> way both for initial setup and after a vq reset.
>>
>> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   drivers/vdpa/pds/vdpa_dev.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
>> index 5e761d625ef3..5e1046c9af3d 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.c
>> +++ b/drivers/vdpa/pds/vdpa_dev.c
>> @@ -429,6 +429,18 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>>          }
>>   }
>>
>> +static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qid)
>> +{
>> +       memset(&pdsv->vqs[qid], 0, sizeof(pdsv->vqs[0]));
>> +       pdsv->vqs[qid].qid = qid;
>> +       pdsv->vqs[qid].pdsv = pdsv;
>> +       pdsv->vqs[qid].ready = false;
>> +       pdsv->vqs[qid].irq = VIRTIO_MSI_NO_VECTOR;
>> +       pdsv->vqs[qid].notify =
>> +               vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
>> +                                       qid, &pdsv->vqs[qid].notify_pa);
> 
> Nit: It looks to me this would not change. So we probably don't need
> this during reset?

We set it again here because we used memset to clean the struct and need 
to put it back.  But we could grap the value before the memset then 
restore it, and do the map_vq_notify call just the first time.  I'll fix 
that up for v2.

sln

> 
> Thanks
> 
>> +}
>> +
>>   static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
>>   {
>>          struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
>> @@ -451,8 +463,7 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
>>                                  dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
>>                                          __func__, i, ERR_PTR(err));
>>                          pds_vdpa_release_irq(pdsv, i);
>> -                       memset(&pdsv->vqs[i], 0, sizeof(pdsv->vqs[0]));
>> -                       pdsv->vqs[i].ready = false;
>> +                       pds_vdpa_init_vqs_entry(pdsv, i);
>>                  }
>>          }
>>
>> @@ -640,13 +651,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          }
>>          pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>>
>> -       for (i = 0; i < pdsv->num_vqs; i++) {
>> -               pdsv->vqs[i].qid = i;
>> -               pdsv->vqs[i].pdsv = pdsv;
>> -               pdsv->vqs[i].irq = VIRTIO_MSI_NO_VECTOR;
>> -               pdsv->vqs[i].notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
>> -                                                             i, &pdsv->vqs[i].notify_pa);
>> -       }
>> +       for (i = 0; i < pdsv->num_vqs; i++)
>> +               pds_vdpa_init_vqs_entry(pdsv, i);
>>
>>          pdsv->vdpa_dev.mdev = &vdpa_aux->vdpa_mdev;
>>
>> --
>> 2.17.1
>>
> 

