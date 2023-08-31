Return-Path: <netdev+bounces-31624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E392678F156
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63DC1C20B04
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC611CA5;
	Thu, 31 Aug 2023 16:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDD8F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 16:33:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::613])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B45CED
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXyt8iyIMMOo3+13gHnOD/kVWIDyyjIgwUWop8F/Mbqed/cSxWO5VCrLOD36rVw8NY2XsUWFVipvMjwhyKF1xR958KMEdOcvEA3xXmNtue4JPgA0j9MTKIr9OnIqBYr996tRhjjSXy2BV/Q07FtcyAriFfPTp9KXAGLuGw1xneBeMaKWmEfaVTmpwTBWt4+nLQGkir9Qklbx4GzC3cmjfiUKS/2mhMF1RfDMWATvT6rZsCP7vxL8g0Zp795efdJNbCTlWoJCoGi9wwOFa1FtPnOiUoabwT0XOCpKVHxRA46Xa1jcCyj+Ir6Mii2+TCTg2+XQrOCNsUst1SjNYlx3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BznJCkZ3NLulF9di42EjysRnRxr5J9YSCGyOxXcsNo=;
 b=ili0TEbGVkmNrepJdM2VogMat43iiUdm1wgOknWKVeU/CREqaTKNWTtGogxYtLpHQuvoFAas1q6CmTJZenwxbjXmTlqy49HRK6Vg8fhfL1hlOITAINMSnwJsTPUkIcoSTzRNVk+NTbvWqg0H3uDV2w4Cpt2VN+UILP2TpZJhs7qkdmZ/gMIvAmGC0ZUwADm6wQdOsFKzFlA1pUT3Qpuz56Wza6riAGUrkCZ4Vxf5xOl9Mh4UnR/qq6xRy8Kwq4TaOwGWhUgArA/F30sXOr+UKgHnD/kYyNikVwI7CxQHEJ4H2rjSuPI4gAvsHEMBGPtmkVKmMYBAQVrtEvdNJbRMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BznJCkZ3NLulF9di42EjysRnRxr5J9YSCGyOxXcsNo=;
 b=FqDR7+n5RuJw2oF23bBCbMYigI+Y3N7Ksxyw/Ga/ZOkQ+K0FhewULQ0eVPPjkbabd2OHPfuNO2rbzFqvub8Kf7FpQSCsLQvPBKFKguex1QmTDbb34PYkyC37ck2kyx0Wra209iAB5UqxnEztYbp05xoB6N+eth6S6YE1ulAWq68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 16:33:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 16:33:22 +0000
Message-ID: <69132840-7fcc-484e-9cd0-fa74947bf09e@amd.com>
Date: Thu, 31 Aug 2023 09:33:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio: kdoc for struct virtio_pci_modern_device
To: Paolo Abeni <pabeni@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 netdev@vger.kernel.org
Cc: simon.horman@corigine.com, drivers@pensando.io
References: <20230828213403.45490-1-shannon.nelson@amd.com>
 <d672e49458e257516d66213b83aeaa686fe66ea1.camel@redhat.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <d672e49458e257516d66213b83aeaa686fe66ea1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c7b8f2-1204-4656-bcdf-08dbaa3ffdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x9CpfYwsvWqfUXj1cVXnsBZvtiR6MICcD3GNHqWu8qS28O7/xQ73/7A1Zylzb09+xBnsuKjS6bd6T2HMBOtfq6V7c2Q7AHTQnQE2g0UVUeneS/p3y4F5z5Q03oPiDKsdG8D74dxQ4T34NMUvHHOYxOoMR/ld1LAct/V2BCsk/z7ZbjJrMAgDJ/99uX7pfCrLE4XWFQxUpYHw/t9yyJs6A4FsN+Osl7AoEnFrCzDhRp35LMRNWCuNeZEF2JW3jRN3B3p1bVb/hIrHTT6KOwbQyzDMwrmGM9jyVy/7WAZgjTbSeCqjnhOpQKwns4gaYFDSIwiwbVH5DtgIbey7XpX+I+728vGDaA/42micntRVNqGXs2w8Jgc4sqTvVEhpyupKHt75JI6EhUq4vJ43Od1g5KmKwEgMcuqv6BF6XFLv6cbKMgmCOaJbUaSlxh3Yrl2l8yaS5usqOxI1TlIs5oRmN5nf4w7W6A1xf5j85/7pQXUXK2XzC0VzIETKo+50lO3Klh25THZNi3fdL3Hq2Mg5i9iT7nhesi+hdvooQZ/KD4fT4Y26UjWp2UAujpxtEoyBKSFN4CXRr+zQnMqySfz9QY1V43Rfu+JmQeeqjDPr2VB6hvj0+JUvpgHO0bZl2Y4pGkJkvk7wjS5qwfz8F6Zq4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(451199024)(1800799009)(31686004)(6506007)(6666004)(6512007)(6486002)(36756003)(31696002)(86362001)(38100700002)(2616005)(2906002)(4744005)(26005)(966005)(53546011)(83380400001)(478600001)(66946007)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFUrc0xOeXlRTWI0NWNJREhHdStLT1hlaktGLy9lMVVqb0pqYWlXMnFXUVBV?=
 =?utf-8?B?RHdzSUswYk9Dd1dUMTJCOXFlYVFtdmJwSFoyNWxzaTh2QnYwbUZlYWhQSC9o?=
 =?utf-8?B?QmRXTG9INmN5bWpiYU9aR0FwcXVsM1lCc1JhRGpDMlc0aVNNTWI1cWlqNFIv?=
 =?utf-8?B?dUZxRUpzeDhhRHUxekkwUU03Z2pJUTVmMEpPU1pqMDlTV2E0aGY1VGZxVG5a?=
 =?utf-8?B?bEpWb25uYnhtMnRHYitIZVlnUUFLTHZUT2JhczRFanNyaFN4L3ZGeEt4MFI4?=
 =?utf-8?B?MUZyVVJIdEMzM2JMbjNVZUJTaEpLcW5pdEo1bkQ3a0NsblNzTHRNZWVUN1JJ?=
 =?utf-8?B?UktRK1RpTStSdzVGelFvY2ZBNCs5SlI4dzc4U0RldC82VVViNnV2b1VrMWI3?=
 =?utf-8?B?REdnallGRVZ1MU5UUmJlSFJhTldvYmR6bFlCbHJYS3Mybjg1K2dPYmtRc3Jt?=
 =?utf-8?B?WjU2dnV4dzBXOFI0UytmZFBqTHZQbFRsUCtlclVGN1piWllGZktubXFJRDJZ?=
 =?utf-8?B?TDZPVzNPWncxdVFzOWYxYjBiWXdqNDVQMGx4M3U0U29WMVFRV09YMXF6Slk5?=
 =?utf-8?B?N3ljQ3ZYeFdMdC9uUkI5Mndja0R0d0p2YXZ5czR2Vk5MWndHT1RqUXJ2aFZa?=
 =?utf-8?B?UjZSckxLamR4Q1B2NEVvOTBBN3d6a2lrc2J0NkVoNHl5b2VzbTc4dXpSNmN5?=
 =?utf-8?B?d3F1UWpBOXRCb2hpZmk3MEg0TkloSFNWbXFSV1FwSWxiUnd2aGEyMXRTQ1FB?=
 =?utf-8?B?b0VKMGZmemVaUUltcVFKQ2VYakdHcDFrblVjb2ZSdEZ5ZFNMT3I1UEtzWUI2?=
 =?utf-8?B?Z0JoVlN1M3hVbFlHWGlYNnROeEg2ejAwcFhBQzFOVzJTbHEyK0JkTVpkM2Iv?=
 =?utf-8?B?cnp3L2RlUy8vOWtKWWVROEs4amVTQjNMditIcVE0WEJQRjc1eXd0TGRMOHRa?=
 =?utf-8?B?MU82MVBYTmo5bDlUczFnZGVQRzZhSEQvblNQQlg3b3pEVU94RVBZQXJJNEw4?=
 =?utf-8?B?SHVBdExWQmZvOU9JcmpLN3NWTkd1MDdUeWViWlNwQ0dqelBkRXljUEhNdmRX?=
 =?utf-8?B?bFo3dnhuTDg5NEZiNXlGQXg5ZlB3ZXZRZEZjTjNEcFM1dUZlRXRub3FYajIw?=
 =?utf-8?B?YlA2cVBnRGRWbnhrYk1zYkZaTTlpb1prcGNzMFRLVUpXQTZEdGJRZHE2NUZG?=
 =?utf-8?B?SlAzSXJBQm9sNFdaZmdnQTVjQ215U1lWaDBITlQ4b0MrRTRUSWZXSmlvbVk2?=
 =?utf-8?B?cXkxWFlDTEZEenlXYWlKc0JKUWpWY2l3TkRpalFNT0IvT2U2TWRsSWFDVXg5?=
 =?utf-8?B?MjRTNWpnWDM2bUc1L3d1Mm10aWNLdHBQbnZsbXQvTkttMzJjSC8yb1RZV3lu?=
 =?utf-8?B?QXRheUVoYVFacjFqTkNkSkFhb09qVENhU2kwRURGTDMrOU9GdUhkZTE5UVhl?=
 =?utf-8?B?bEdoSE4vZDN4QXNsekpMU1Q2SUlrT2pYemtDU1M1QTgxOVBWMzkwZ0VIVjNp?=
 =?utf-8?B?eUV5T25jdUM4SGZLVTZhY3FuMXkrMnpyMHd1bWVNc2tVaGQ2OWM2ZlhrV05l?=
 =?utf-8?B?SG9jT1J4TFpUWFRGRVc3OGVmbTM3TU81TzdzNWhHWitIeXdnWlcvMWFsNW54?=
 =?utf-8?B?NWMyNFE0UXM0a2NFSUJjRSsxZGI0UUdqMXFYbVJHQ2FuK0kxWFVqV1Q4Um05?=
 =?utf-8?B?bG9BNXdIVnBJWkc4MDVDWlpkWlg1R0NEcGxWMWdSVmorMWFsNjhrQlA5RXB3?=
 =?utf-8?B?dkIvaGc2NzRhMTVpNVVLL1JiTDFaaEZqeUlWMVAwWkxsUnkyRC9yemFSNkE2?=
 =?utf-8?B?d1NpOWh5UmNPSDBIbFdPL3hvc3RqbDhCblU5SDlrQVdud1E0TmhPYjM0YVZh?=
 =?utf-8?B?THcwOU1GTmxranVkNjB3bEc4ZENFNWhRTElUeVpZTVU1SlZlRE0rekZqQUZz?=
 =?utf-8?B?WlpGcEdJZ2RhRnF3cGJyS2dFcS94SDFRQS9RelcrQU5Zd201K0NCVmZLaVo0?=
 =?utf-8?B?U1dFeU85QnUyN09JS1JRbXh1TWtvbnFKZkpzRC82NnpZRWxnU3ZMOXhYQ2dk?=
 =?utf-8?B?WFZ0MGlTMnBhUE55K05YSVB4NWg2V09VU1ZIV2I5bUlBUWdTTWtGQUtUdWF4?=
 =?utf-8?Q?/lQdmcYxS6brCDYe1HKGjL0Uf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c7b8f2-1204-4656-bcdf-08dbaa3ffdf2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:33:22.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqqnbuvcWtAmLJMiZehOGUquw14SNvZr1dtfVBKO7zC6ABLn0ZEArmpjhkk+KOnreyfCzdpwkd+uuJ0C7UzH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/31/2023 1:39 AM, Paolo Abeni wrote:
> 
> On Mon, 2023-08-28 at 14:34 -0700, Shannon Nelson wrote:
>> Finally following up to Simon's suggestion for some kdoc attention
>> on struct virtio_pci_modern_device.
>>
>> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
>> Cc: Simon Horman <simon.horman@corigine.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> IMHO this is net-next material and net-next is closed, so please repost
> this with a proper tag when net-next reopens in ~2w.

Yeah, I wasn't quite sure on this whether to call it net or net-next. 
I'll followup later.

Cheers,
sln

> 
> Thanks,
> 
> Paolo
> 

