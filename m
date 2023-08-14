Return-Path: <netdev+bounces-27410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A506277BDAD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C666A1C20A52
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF87C8C6;
	Mon, 14 Aug 2023 16:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28DC139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:11:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F17133
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLoyKPYHWvwPkBYdPo2kZngq89cHK+LvlidklgNaBowjaEEZcV2Mx/6eBVJscbcOP3SM3B3sTZZZoMN3DFEMoBg6SsjJDSzKuYJZFd6bj8Fb26uNOrf+O7Bfc1XU1kOdOpt+8oDUYLHVCmJ4tvylIJskjiEEAX7KbrdBrd+hBuZXwKZ1LoDhFb6n+uldp3PHO9C+s0gEzdRUzXdxE4a2hzE+dj/m/VHwQjgitYbVRhiAsG2Y3/LfTJkprmvsd8THDx6ElMByvPM83ZPzRuSIap0Y+zrlKHo6tf/ZK1sw8isKk+iPYR+z7hocDnH29Nm9jFB9munywgKUZMs6ud4ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcEfqVchQF8dJ9ijCscfdRRMHYy5cOGmQG53WGHY//k=;
 b=VIIDUSzhDjgX/OTkfA4sAAgiYEprI2t/LrSy1waiSpweMgDLS5Es7g6EfSImLqJ0HU52mdC+bXHc9madCCtxX/9dBKuIRpah2PJev6N+QQqHNf3R2TpeFI8zEEC9MFFgxkeWoxB0rosotaX9RacWINg86UP1FCEuNFIzOSqptwMFDpJN6h+2VZW14fZZPCgjbsjxTFX6RL7yXcBVQaqhiHMEMDn+ZgZXN90FBdSqu6P2duxyJUJEccm7NNxnrE0y8ufWGc6FJvjLq9ov62J8xpd0cPiNSLSuE4i4S1CiuZMxzdRPTR+F8wLZ3K9lg1682AUuAog1iNOS2XA3UbAGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcEfqVchQF8dJ9ijCscfdRRMHYy5cOGmQG53WGHY//k=;
 b=oEWWe11T0EC1utRt4hsWnQ+04eHbLuV/k5nLozNovqQzw6rn3CU9mqcDI2viJDQ/7deZHZGGatfaQj6MK6X+DlRMOoVhTxdHaHvu6Lp7Ww37t79zsAS2f3oIgmfnAgoPzbsv4beLzUdnLYWd0e70QOnJMAgZdxYh1oWIHD1VGPx+6H045iSHCcxxfzbIr22wd/bZXZWCPqS+84+jWk5hRu/FJWlHcGmVPF2FVANzO8mgzoC7uKm4je5KsVG9ILGB4what23hYHBeKsm5OKh7ChALENBJTcAy6Lyy+3809Rj7bV6Fn+SmryBO1VvHneWyQNnE1UZvpRMQ9ngjgpp9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 16:11:54 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:11:54 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
In-Reply-To: <fa07042c-3d13-78cd-3bec-b1e743dc347d@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <fa07042c-3d13-78cd-3bec-b1e743dc347d@grimberg.me>
Date: Mon, 14 Aug 2023 19:11:48 +0300
Message-ID: <2538radwqm3.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 060b7b81-a604-45a4-921d-08db9ce12d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BxPmOdbOURf6Jhv0YlZnvnHlsKOlUM42X9TIUkN8e4jVhQ/X+SaQNAybsLorGyXGIfPs+v0C6nQsebhThVD6ih4lJ33M1XHjhCc0raSPuAEJXxtFG81Hc0stfRUxtRfGqpoJz5f3FZkkplWsy+NmmORMDOeFqHGP3R6gDpOrX0JnCjKYdD/TgeQpHOSSe4QILxxhXPCnwXSOXCqPTTiTzzxr89sIhkVh6EsqmUS6lZOZX1MKkJ9LeDXAw+bvU3rBoNYtbVKKhQRWJriZjI5oZEthq7pCYw3TCg6n3JAo8AGWQfOpIsENPmEbqYYJU7EdnpsNGfKL47HqBorc7kd8pjml1ohhuGvEMDRRMcF8SRKh6tU5md3HWRu/0t42M3jR0bQww7Ybcy2c8HIiCl1UwK8CCmUl8e8Sa0LyzKfmd5jLE6q4dzVUw693Z4Nbdvdkhu5PO/7JH+WPuq+T0sVxeRCQDSRtA3x3bg9nhYcamTrhb/aI33JaD0T5pC6x5bfc8NSsSHrdBqX+ajAap1b9Tj5Jhh4eu6sXvt1x7ABwap+L0B3PKlpx03ln7GUgmVv1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(30864003)(316002)(4326008)(66556008)(5660300002)(8936002)(66946007)(8676002)(7416002)(41300700001)(66476007)(38100700002)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ti3znEkXrNrE0BDnor3m9USL53KV49gzYmoidsrhvvM0Eq6cc6YhR51yXDz?=
 =?us-ascii?Q?ZpnmCWFgXVAUr1aCf5B4M2+ZJ3cnMvFLycFRzM68pz6l9BA0m7WXDYBT1hLK?=
 =?us-ascii?Q?bGs/vn6v7A3sYmNzEmVDVbNMm0y7dopFT8+/FXDBLetY6onUVmGQ7hZeM6nx?=
 =?us-ascii?Q?9zG/42JnYp2zwFkTOqxxeCDQeVGcx0fx7OudgacraxwOw/YR5gmMDO2DUPio?=
 =?us-ascii?Q?QUN9b/ESLLMW/OfnAjNKaYSbZqX3pJSZa+QIu7yDAZXGR999ZAFHhTH7Kynz?=
 =?us-ascii?Q?Ynamb956o5qyw6BykDyK192I9xtDWo9MBMno6uDG9+NgFhC1CPa6qPA8CiWZ?=
 =?us-ascii?Q?UpIAWpiOAMR+6rxUg03WW2Zy9zi5+m92Gnk4mg/wxTdCVxVyoIJmi8gazD7B?=
 =?us-ascii?Q?4m29d0E0nkU5Hlm5wedRMKt2uvAia5ceHp0bWGdVk+/vVogzkG5b6ZsXfFAv?=
 =?us-ascii?Q?x5sfNB4SAO/VYrhyhOHyTbWTWoSPSLD8JCaFd8zVntKZLNV/crhQ4w93A+7d?=
 =?us-ascii?Q?eTPlhpd41vIPym+YwXYVaVdVj9CR0UjViqubeyKp8nqJeoN+jsLIXKHzvf80?=
 =?us-ascii?Q?uj6AgK08lh38bDDln1EOSfD8mDqgp5DIXsOmA5uCaOmUDi6H7A99osHozVNb?=
 =?us-ascii?Q?uMiCVStBi38qApknQUvfM4Ujx7IvmXZMAjAoHL/dSKJqYC9/ow3SnALdNoAM?=
 =?us-ascii?Q?JPwEyaa5sODY1TBC1XzTEzcAO5G+Dt3TKt3O/RnU7/MamlaFRcYIKVJDpPeD?=
 =?us-ascii?Q?sW65M6M3CVpSCEvMr+RtceE5xVUZi/pR9RqF/dGgrOEbCILXNqMfeb2SkS3B?=
 =?us-ascii?Q?NjnQFVOywyeJ2ZWM+cRHe9iDdB7CYFwvD3fYe5tOs8GiuuoC0SAqSTKfhXUx?=
 =?us-ascii?Q?HbL8hYcq7x9aWoGIhvlbSxhA4A1skj0JCkzb4Ah9xJdkz4P3QAngxWg/Vf2a?=
 =?us-ascii?Q?wqZI4tzE5Mo4/ku1J33+33dbY3OaOoo7Zs14vpXwiKFAGOEU3icYcqIrRrmF?=
 =?us-ascii?Q?Qe8Cb0NoU6Tvo7VQ4K+bXJ5O2L3oyarrxpzhQjghbxy67uSh8NNKDy82CQZe?=
 =?us-ascii?Q?Aspz9R1hNsjAR5UN/WvrR9/ug4Izngzyn6A6/4OOliNwvm4PVeBEx+ojXXSK?=
 =?us-ascii?Q?/JZiG7hwYGpvZyBTmCzXrsf0lhIuY9o8H9u/CwE/f7KoFnGJ2+NhLOxvfwwH?=
 =?us-ascii?Q?Eyk+q/sXfb6xuheTaUmlNIzEsHlwMtTSHZXHiRyi8LNeekwTcPvn34shftQs?=
 =?us-ascii?Q?KGs2EhfGX48/5pL3TC/RQ8824tSzNp7Qv8qMAscfGI7XEt+kELjksC3RBQ77?=
 =?us-ascii?Q?F4vPWJJAaobX2JbIbLFtdqC/M5VTZLanyJKVRQ6CUhNVJ1QJHv7LwGLfRCEy?=
 =?us-ascii?Q?x4c+ZReJc3s8wcgaif0CP1khlxAzXd1yAGAfs9R0oWGy+GLhEpywqsw2QKow?=
 =?us-ascii?Q?nfJLuZtPeceD/y/G+E4w+tgbOklXdntZEiBM4OPPmzHK8KGvVYBSCbg5VtFy?=
 =?us-ascii?Q?nVZU+mTO3g5Cu0fDT2lkb5+V8Tl+LFapWRo9mX74k6d3CX2U/iJ4nHyp6yJF?=
 =?us-ascii?Q?BduS1No3/NZB0YjoEdPUn/EpIFJaU6p8pazUOmGU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b7b81-a604-45a4-921d-08db9ce12d0c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:11:54.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBwXzBYi7VtHWiaiWQBRJChOsUs5FfOiEp5YJmYFPwRqcXmZOAq6HPVDj0b8LxCtWuD88oSG4xqmxuY6jjUORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> @@ -187,6 +205,9 @@ struct nvme_tcp_ctrl {
>>       struct delayed_work     connect_work;
>>       struct nvme_tcp_request async_req;
>>       u32                     io_queues[HCTX_MAX_TYPES];
>> +
>> +     struct net_device       *offloading_netdev;
>> +     u32                     offload_io_threshold;
>
> ddp_netdev
> ddp_io_threashold

Sure, will change it.

>> +static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
>> +                                   struct nvme_tcp_queue *queue)
>> +{
>> +     int ret;
>> +
>> +     if (!netdev->netdev_ops->ulp_ddp_ops->limits)
>> +             return false;
>
> Can we expose all of these ops in wrappers ala:
>
> netdev_ulp_ddp_limits(netdev, &limits)
> netdev_ulp_ddp_sk_add(netdev, sk, &nvme_tcp_ddp_ulp_ops)
> netdev_ulp_ddp_sk_del(netdev, sk)
> netdev_ulp_ddp_resync(netdev, skb, seq)
>
> etc...

Sure, we will add simple wrappers in ulp_ddp.h to check for the function
pointers.

>> +static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>> +                                             struct nvme_tcp_queue *queue)
>> +{
>> +     if (!netdev || !queue)
>> +             return false;
>
> Is it reasonable to be called here with !netdev or !queue ?

The check is needed only for the IO queue case but we can move it
earlier in nvme_tcp_start_queue().

>> +
>> +     /* If we cannot query the netdev limitations, do not offload */
>> +     if (!nvme_tcp_ddp_query_limits(netdev, queue))
>> +             return false;
>> +
>> +     /* If netdev supports nvme-tcp ddp offload, we can offload */
>> +     if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
>> +             return true;
>
> This should be coming from the API itself, have the limits query
> api fail if this is off.

We can move the function to the ULP DDP layer.

> btw, what is the active thing? is this driven from ethtool enable?
> what happens if the user disables it while there is a ulp using it?

The active bits are indeed driven by ethtool according to the design
Jakub suggested.
The nvme-tcp connection will have to be reconnected to see the effect of
changing the bit.

>> +
>> +     return false;
>
> This can be folded to the above function.

We won't be able to check for TLS in a common wrapper. We think this
should be kept.

>> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>> +     struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
>> +     int ret;
>> +
>> +     config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
>
> Question, what happens if the pfv changes, is the ddp guaranteed to
> work?

The existing HW supports only NVME_TCP_PFV_1_0.
Once a new version will be used, the device driver should fail the
sk_add().

>> +     config.nvmeotcp.cpda = 0;
>> +     config.nvmeotcp.dgst =
>> +             queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.dgst |=
>> +             queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
>> +     config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
>> +     config.nvmeotcp.io_cpu = queue->io_cpu;
>> +
>> +     /* Socket ops keep a netdev reference. It is put in
>> +      * nvme_tcp_unoffload_socket().  This ref is dropped on
>> +      * NETDEV_GOING_DOWN events to allow the device to go down
>> +      */
>> +     dev_hold(netdev);
>> +     ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev,
>> +                                                   queue->sock->sk,
>> +                                                   &config);
>
> It would be preferred if dev_hold would be taken in sk_add
> and released in sk_del so that the ulp does not need to worry
> acount it.

Sure, we will move the refcount accounting to the ulp ddp wrapper.

>> +     inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> can also be folded inside an api.

Sure, we will move this to sk_add() and add a parameter for the ops.

>> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>> +
>> +     if (!netdev) {
>> +             dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>> +             return;
>> +     }
>
> Again, is it reasonable to be called here with !netdev?

No it's redundant, we will remove it.

>> +
>> +     clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
>> +
>> +     netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
>> +
>> +     inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
>> +     dev_put(netdev); /* held by offload_socket */
>
> Both can be done by the api instead of the ulp itself.

Sure, we will move it.

>> +}
>> +
>> +static void nvme_tcp_offload_apply_limits(struct nvme_tcp_queue *queue,
>> +                                       struct net_device *netdev)
>> +{
>> +     queue->ctrl->offloading_netdev = netdev;
>> +     queue->ctrl->ctrl.max_segments = queue->ddp_limits.max_ddp_sgl_len;
>> +     queue->ctrl->ctrl.max_hw_sectors =
>> +             queue->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
>
> this is SECTOR_SHIFT?

Yes it is, we will use it.

>> +/* In presence of packet drops or network packet reordering, the device may lose
>> + * synchronization between the TCP stream and the L5P framing, and require a
>> + * resync with the kernel's TCP stack.
>> + *
>> + * - NIC HW identifies a PDU header at some TCP sequence number,
>> + *   and asks NVMe-TCP to confirm it.
>> + * - When NVMe-TCP observes the requested TCP sequence, it will compare
>> + *   it with the PDU header TCP sequence, and report the result to the
>> + *   NIC driver
>> + */
>> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>> +                                  struct sk_buff *skb, unsigned int offset)
>> +{
>> +     u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>> +     u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
>> +     u64 resync_val;
>> +     u32 resync_seq;
>> +
>> +     resync_val = atomic64_read(&queue->resync_req);
>> +     /* Lower 32 bit flags. Check validity of the request */
>> +     if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
>> +             return;
>> +
>> +     /*
>> +      * Obtain and check requested sequence number: is this PDU header
>> +      * before the request?
>> +      */
>> +     resync_seq = resync_val >> 32;
>> +     if (before(pdu_seq, resync_seq))
>> +             return;
>> +
>> +     /*
>> +      * The atomic operation guarantees that we don't miss any NIC driver
>> +      * resync requests submitted after the above checks.
>> +      */
>> +     if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
>> +                          pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
>> +                          atomic64_read(&queue->resync_req))
>> +             netdev->netdev_ops->ulp_ddp_ops->resync(netdev,
>> +                                                     queue->sock->sk,
>> +                                                     pdu_seq);
>
> Who else is doing an atomic on this value? and what happens
> if the cmpxchg fails?

The driver thread can set queue->resync_req concurrently in patch
"net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload" in function
nvmeotcp_update_resync().

If the cmpxchg fails it means a new resync request was triggered by the
HW, the old request will be dropped and the new one will be processed by
a later PDU.

>> +}
>> +
>> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>> +{
>> +     struct nvme_tcp_queue *queue = sk->sk_user_data;
>> +
>> +     /*
>> +      * "seq" (TCP seq number) is what the HW assumes is the
>> +      * beginning of a PDU.  The nvme-tcp layer needs to store the
>> +      * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
>> +      * indicate that a request is pending.
>> +      */
>> +     atomic64_set(&queue->resync_req, (((uint64_t)seq << 32) | flags));
>
> Question, is this coming from multiple contexts? what contexts are
> competing here that make it an atomic operation? It is unclear what is
> going on here tbh.

The driver could get a resync request and set queue->resync_req
concurrently while processing HW CQEs as you can see in patch
"net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload" in function
nvmeotcp_update_resync().

The resync flow is:

     nvme-tcp                           mlx5                     hw
        |                                |                        |
        |                                |                      sends CQE with
        |                                |                      resync request
        |                                | <----------------------'                                  
        |                         nvmeotcp_update_resync()
  nvme_tcp_resync_request() <-----------'|
  we store the request

Later, while receiving PDUs we check for pending requests.
If there is one, we send call nvme_tcp_resync_response() which calls
into mlx5 to send the response to the HW.

>> @@ -1831,25 +2055,55 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       struct nvme_tcp_queue *queue = &ctrl->queues[idx];
>> +     struct net_device *netdev;
>>       int ret;
>>
>>       queue->rd_enabled = true;
>>       nvme_tcp_init_recv_ctx(queue);
>>       nvme_tcp_setup_sock_ops(queue);
>>
>> -     if (idx)
>> +     if (idx) {
>>               ret = nvmf_connect_io_queue(nctrl, idx);
>> -     else
>> +             if (ret)
>> +                     goto err;
>> +
>> +             netdev = queue->ctrl->offloading_netdev;
>> +             if (is_netdev_ulp_offload_active(netdev, queue)) {
>
> Seems redundant to pass netdev as an argument here.

Thanks, we will remove it.

>> +                     ret = nvme_tcp_offload_socket(queue);
>> +                     if (ret) {
>> +                             dev_info(nctrl->device,
>> +                                      "failed to setup offload on queue %d ret=%d\n",
>> +                                      idx, ret);
>> +                     }
>> +             }
>> +     } else {
>>               ret = nvmf_connect_admin_queue(nctrl);
>> +             if (ret)
>> +                     goto err;
>>
>> -     if (!ret) {
>> -             set_bit(NVME_TCP_Q_LIVE, &queue->flags);
>> -     } else {
>> -             if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>> -                     __nvme_tcp_stop_queue(queue);
>> -             dev_err(nctrl->device,
>> -                     "failed to connect queue: %d ret=%d\n", idx, ret);
>> +             netdev = get_netdev_for_sock(queue->sock->sk);
>
> Is there any chance that this is a different netdev than what is
> already recorded? doesn't make sense to me.

The idea is that we are first starting the admin queue, which looks up
the netdev associated with the socket and stored in the queue. Later,
when the IO queues are started, we use the recorded netdev.

In cases of bonding or vlan, a netdev can have lower device links, which
get_netdev_for_sock() will look up.

Do you see any gap?

>> +             if (!netdev) {
>> +                     dev_info_ratelimited(ctrl->ctrl.device, "netdev not found\n");
>> +                     ctrl->offloading_netdev = NULL;
>> +                     goto done;
>> +             }
>> +             if (is_netdev_ulp_offload_active(netdev, queue))
>> +                     nvme_tcp_offload_apply_limits(queue, netdev);
>> +             /*
>> +              * release the device as no offload context is
>> +              * established yet.
>> +              */
>> +             dev_put(netdev);
>
> the put is unclear, what does it pair with? the get_netdev_for_sock?

Yes, get_netdev_for_sock() takes a reference, which we don't need at
that point so we put it.

