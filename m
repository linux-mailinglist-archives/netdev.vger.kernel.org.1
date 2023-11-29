Return-Path: <netdev+bounces-52143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB347FD8BD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9182CB2145A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAF1EA95;
	Wed, 29 Nov 2023 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dxn1smxC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B1E6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 05:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvy/XcPfVPZuPJvOQf95NSI5suNfTBhJiCN3wwQk2Abjg+TrRI1ZTkb6Txe2oM3AusC+Lpdvpxcs2ckhKHLwlKZtXtCqANOpmVpaTHouGdjTI2KmTwxuoGm57Oe/4XpCzZu9nhkPu1GeKruGjkhEaVtuj+NbaS2kmlcaMAtEWXZUGQm+S7qsvcf+7jIZYtuw7ArQf+DFHkl5TwUZoFojIg+EOjRPtrOTXRre1cXXiuJqYqnbaann+g6/pskPKQn/fsmD2d4GNvNS/JSTWQt2PRWcByau+Cwr1XQSsqygMhDNyD2cpOa68YhY6DR9hC5DCt2cXPAVbfvk192MHaZf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUjQ8KNzoLm6ywqDw9A4qSDzx9RG/KGJc7Ch94omCsM=;
 b=ZD65eMBHF7F69jrPRTwGd1iliEgbHl56EhKu0Cia7UzVfIFMIEOTpDV54Gw6pKkV8mTeN2vTksqISU8FAgahbexFDo/yTePWoSy9ludf/mw/qfqruc48XpgklXfwZLxlvmHSKWpPdHB2RpDdGbL35+MWyOSqxLEE3vpjaglUINvIQXKGiRgeXR3mOzHVIUZE1z/JQsDaQkGbenemklM17WqWejcyczHnNh2GriP9MJIRNE5fr56hhKYXf+bsceea8oFe2Vgc5N33AkXRTiQUHWu5Nm5huxxBZxWvPuPkr+7LGVshEtTgjgL5TOCXSPVrXDAc0o69wk03k0OltPWlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUjQ8KNzoLm6ywqDw9A4qSDzx9RG/KGJc7Ch94omCsM=;
 b=Dxn1smxC0NwkIW1TrJkRtG1cykhOeucY0LO+XPBkYOSfh4sI/7/7uPpwkMBovVx4HJ7Z1lhWk3W3aLOYyKUFY57jBq1szNZkEIOuz9l2Q3mjirVVr/M82Sq0YvwAAqG4ZkDbZdzLGbhdaZA3rZPhQsBII9kjgcKg4ixjl8F376Xe3vSa8OVv+/PSIxQSlN6N7zt7SIt81zBcQTqPzDuO3KZ16HQw7qrIU5Bo7Fi9+YpnElpvVjdid9/wU4oDgDGADfL4QTAa/nZ3hQUV7I0KTgD97LEw/VdFqK+xZhOnw2fpqC3GVhM1eQLQaBTwwPb9SYt5P8vwDFGfZMJIYA66Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:55:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 13:55:32 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v20 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <84efdc69-364f-43fc-9c7a-0fbcab47571b@grimberg.me>
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-7-aaptel@nvidia.com>
 <84efdc69-364f-43fc-9c7a-0fbcab47571b@grimberg.me>
Date: Wed, 29 Nov 2023 15:55:29 +0200
Message-ID: <253msuwirzi.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5768237d-7ad4-4e52-b9e0-08dbf0e2dad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9iGLkWYx5KkO61oXcOxVZzr4O9uhqBXy581kh80wE7T2ZIlOmStSXkzHIAZxPtqjoL0yshlgy1CluocZ7TGylmHzF1xX0u3zlj210bq+PgfweFy0jysszwbWS/JBCmmUL98wBJgEWunXvH9Cm+9Rxlhh8InnS6ELT7m/pg0vy+dPts0hUPs9UPKnKAl9+mAW7wF/5pSt0pDD/RKhpU7rt/Rjmnwz2y6vLPGcA44Zb4p1L7ZvKxlcFD92pF9KEFgJu0DI0rALGs+d1GIQOTDCQ0vEhQrUc42tVQ+zginaZo1UGKidJ4LxgCCA6S0VokXyS7Qx6RG48IpsYVZGG5YjPOKv4jmH/yi3CvHMp3xbgPMOG5XTisN9N3bhG66PWtXuPfICPkIANs0RgFgtGkb+cz5ZggK3Ts0l2Vt4hxMPOW0kbfO/thHUYCCAP5wjqt4eZP4RH8lKGBUGx7vK8xibPQMp+btTwIK27hdV5cy9lw5OuUJXhemyXJfOPW8nt1/B7VM9VfBRK2ub1x9UjWi2mH0TpNYA4HEiXNg1Yc6iUC1zcKyswLUEGW3hTXfusB5neW1Ibnjqfs/WXy4advHug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(107886003)(6666004)(26005)(2616005)(478600001)(36756003)(38100700002)(5660300002)(86362001)(2906002)(83380400001)(41300700001)(6506007)(66556008)(66476007)(316002)(4326008)(7416002)(6486002)(8676002)(66946007)(966005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrg34EqArKi1pCQjVRW4vuyv2VneS+cySiDrXDubiOQ8HMZTp4GTC2Wsp04s?=
 =?us-ascii?Q?bnHUG50p/iXE7SCDKqkLl0DsSXwpKGslYeR8sQHWbEKwKNyVDUC0Bme0erXM?=
 =?us-ascii?Q?H9KOlywywzIPFpUefdCxmqtRWNSoatN48Y+PSxzfI4w9wZn02UHdnO+SMuoA?=
 =?us-ascii?Q?1gQ9ZjNPayuYRp6HQ8BFVhJYjhNYilKvS6pzYi5/Fwfi3TfzuIArkChRJ71m?=
 =?us-ascii?Q?cq7cBEjk0TKCxngsZUykyRp76PbVi+Dn/9EdyqScwLe5FO1dtRZ14oXvjFYN?=
 =?us-ascii?Q?X0h8PKUOy2X3DMEd+2oV+sOKiy3OI4wp1c2wZwhfVRd27ARD0TbWGbsGSsWA?=
 =?us-ascii?Q?faPK4+uEXXcY7Cen7EdswPj7FGSwFalRRHzP3eRrCGeoqgBf4wVWEwb+5dWR?=
 =?us-ascii?Q?HkcSIQhumcUvhcuWwGDw7YwxzhgHZTvSwuCCJ/gmsVtbe9s8MF7gZE4U7L4k?=
 =?us-ascii?Q?zpXIV1TSzZTEADCM8I3j6TcQZOr8BJYTKOieLGJQTe6vikOWI5Dgqy1dsZVX?=
 =?us-ascii?Q?E1ZSMSRqUg68B3tgADrWrdkgZfxQmGPPyVKC6Z8L1GBouyAvFV8paovulaec?=
 =?us-ascii?Q?Cjn/I2lI/C1ycbDFNaxNBPYt8DmSaSlx8g61baimVAjxYTMq5Vnc2Hz6Sqhi?=
 =?us-ascii?Q?DV23Cbj6fdC62/rGZfAVS0hXjtn6M93MEn/6Gb/XotUHJsIYlVrQ5b0qsl41?=
 =?us-ascii?Q?h2G25BJHNRNESDpF9uzevDWj59SCl/+hSsg/nbPOarYhXBjay+S/AH70kwAi?=
 =?us-ascii?Q?xg6famWknLMIGsjON8T+fbX0FybB24Xq5WAm0im7NpdTQ05WDqbHJG+Auh/Q?=
 =?us-ascii?Q?x71dsT5WsBMHhtE8gUQXMnTWlW3HJlhJLFMsWuB31SFdFO4zspH9ojI23W1R?=
 =?us-ascii?Q?wPFjbLNRi7Waecb//dr6o/EKxXJf65IEoh8LQBTsI7Ud1rC0IRSxe36BD9kx?=
 =?us-ascii?Q?oGLb/IUCQc8+2C3bzTf8M4nL9hVWcQpTve9Qa/eo2K+oQIP1IKbqxHp2v1kw?=
 =?us-ascii?Q?twADE6B8L+t89pqPy5u9XmXOE146GYeLL6OsoNhyP2CshRldlZL479Z+yIfc?=
 =?us-ascii?Q?R+KhfnmmfvfBfOQ5qRjZZzg6j/qlfkS0b/MDKe2aTkvCGd/SbsSKN8a1IhuM?=
 =?us-ascii?Q?W1As7pDFKbeG4qEPlbuXoGH2TaTtzbZtByBlmbQaa/mntsVu7Zvqzg+3t+6I?=
 =?us-ascii?Q?c2T36eGUHWV6vJN0e3JbpI8S7vCEuwycaLi4hajVY1heJrGMk/Os1bNT2SIY?=
 =?us-ascii?Q?mfamxPkPm6lDEGcwHP0nZm4o0vESFU1NnEhIehuq7NJ26O0LEL8wTRNUglnG?=
 =?us-ascii?Q?efQ7blXmAI27X7iM5LNmtshqRTk8POC93EcGgaBjksenZDsKxiVt2m8HkzJx?=
 =?us-ascii?Q?Y+l8IQz+WTifXI1awlrJ5Q2p78aTbd9HIOWQUwqFGvvZXYCLFVJUAVW48z5O?=
 =?us-ascii?Q?koYaYEWNkz5yzb4VPtdbKeUKCbk/ZTDvNAeuDZD2CUwQneJy4ZGP2+SF5+Wx?=
 =?us-ascii?Q?KvU5OmWm2p25kFEDUat9ySLvutMLvi9ADsZPrNDdSDyMNNWD1h+z59qG0Fwq?=
 =?us-ascii?Q?SWG9r9epsDZEBSr7wGZ2B1sYa5iQt/3t/ad44/yH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5768237d-7ad4-4e52-b9e0-08dbf0e2dad8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:55:32.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhlwhgAWIDs3YBL9EklabpgTJycoc6j6c82Qrzx0xCg/a4wMwJMFPbq2rqI5ukSbCmdz57EFTZmrBQZrM3naWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775

Sagi Grimberg <sagi@grimberg.me> writes:
>> +static void nvme_tcp_complete_request(struct request *rq,
>> +                                   __le16 status,
>> +                                   union nvme_result result,
>> +                                   __u16 command_id)
>> +{
>> +#ifdef CONFIG_ULP_DDP
>> +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +
>> +     if (req->offloaded) {
>> +             req->ddp_status = status;
>
> unless this is really a ddp_status, don't name it as such. afiact
> it is the nvme status, so lets stay consistent with the naming.
>
> btw, for making the code simpler we can promote the request
> status/result capture out of CONFIG_ULP_DDP to the general logic
> and then I think the code will look slightly simpler.
>
> This will be consistent with what we do in nvme-rdma and PI.

Ok, we will rename satuts to nvme_status and move it and result out of
the ifdef.

>> @@ -1283,6 +1378,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>       else
>>               msg.msg_flags |= MSG_EOR;
>>
>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>> +             nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
>> +
>
> We keep coming back to this. Why isn't setup done at setup time?

Sorry, this is a left-over from previous tests, we will move it as we
agreed last time [1].

1: https://lore.kernel.org/all/ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me/

