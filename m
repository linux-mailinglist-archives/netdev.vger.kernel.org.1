Return-Path: <netdev+bounces-78459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F926875396
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCD42822D1
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865712F370;
	Thu,  7 Mar 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TIxnsdMx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C91E880
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826261; cv=fail; b=AUByRQ3o+cx2R62VnGvnW4mcYt0SRnMg0svHs+nmPEqH1/LCHr9rjS1yWo4KUOSU3N+6UnrdTfI3oo0VrXprWrEMOoxw2aSwjNTBS039QR/0PWHNmNXliQtAFRODcEUlGQRE9kKPDNqYVXmDyZPSXFzFBS56jY8HHcRhTktkDhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826261; c=relaxed/simple;
	bh=+7ETukx3yNzRtRIJpaF4OJyqqEA1kXLSL83aIMUqK7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=IoTjAA2mbYezZmxvuqUUIEHq8mBScLJ4+oFP9RsY1DrzXFcvC4hu43+Er1laRvz3AXA+QcbsNh0QmLClVuPras/O+V2AVIeaJpmiYD9uYBoBoofE7fL6G+w6aEh7BirqPCprKhC9xBaaRtddwbpUt71OXOW2ENNhG75md3t0PNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TIxnsdMx; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSFtaSr/TU+8WVrB8vAdFFbsffufis992Z5LGClp5ISRcoAmNzY+PwQ5l4Ec93r/1u/VzyZvRg7/nyKrvbfVvNBN0CFmMF5cJM62K8TDZ0oduM0OT6dzM1cczx8lhNvBM8Vhu0jMU4f+G0dAglOC16hnj0sVsypufXpOTCYh81/LUxnih4j3TQ21E+HARry9tNdVT3Hwrnk/8WKcDkdnecas5RxMW/ddE6ArOSwvUf0q/cwl2NQ5YvqL1frFjVSh+WYDixjw44f2pIo2YWhzToWc44qJ/HRRB56zovZYOZsIc38+BO6WrdoZnq2DQEp8MKoeZzeT3PdmfAg0IiyEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8U+9+uG8IRu6UlaPIFOtvge584G9DvXxh4DYdQBW0o=;
 b=M5FH5FdeOdmka4by7MBqn92xwiqvCB9u3ielOaKq8mFAR6QcX6TqgjbmcfZhughaCcOMxcds9/fO8iTi5/J78uN70jD3OtlyyBUG/oW+sODP/8nnX52YCzAo/IO9pPc1d/XRThXWLadTFq4hshl5A4zVHFjdiM6jp2vCJAtuzSm0w9X+RkcWjWGclFgjzkHchh5TxAlKfs2SIX6D3tWWMPHmOzuYF392C3q4AcGjHzNjjjRbx4/TRE4aL7yo/ocDH1hRV5fhJJTxQ2Btc7RBiTQaA4jRkbECDeaNIQL+7nmV0HyGEjeYvgjy6ZBSNbOyn9PSJ5ngYSw7v9bTNpW8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8U+9+uG8IRu6UlaPIFOtvge584G9DvXxh4DYdQBW0o=;
 b=TIxnsdMxSPODkAB2Ec4nj+OpG3lXOTfD2mRNfbKZtkUCC5GzQA5PcI9OB0L+nGgUn3ODVS8zGUs7Q3nwDMLM/JnSStrSt+baztb69NtaaST6davJgeL4U38X99n+jQpQKdlu1CtwzStJWpCxClKcJWSbPy1gGbhc5018CL/1+Kw8q7cRWQDsUmvZXrDF8IImm+o80XDxA7nEUMCuIVw1eoOK7IExoFrEXh2Kv3HEoqEOSMWAGaR5al+/6iPGB79ub6hu04NvxeLt9yQj6XcAxZUaXDZPQGRwOBuGxOEMT6DVzHeeCXP8NCqVgiUDcbMILk0l/CVn99ieUmG03mWjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:44:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:44:17 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v23 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <40a01a90-b91f-4526-a404-462de3ffa38a@grimberg.me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-7-aaptel@nvidia.com>
 <40a01a90-b91f-4526-a404-462de3ffa38a@grimberg.me>
Date: Thu, 07 Mar 2024 17:44:13 +0200
Message-ID: <253msraujw2.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb25080-d9e0-4631-4cd2-08dc3ebd7232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DGXixbakc63uTaM8Kvk39WJIixOZZ7TiypNjiIF8VkcE/N5mrb3Gjk7hPynN8Aq7qu0Y/zNQtpMJB7QSDeVP3RBtu4xyjuzae7CA816Fpqu9o9+YbSzlRUlu+U7IvzuMFeW2hVMpTYiQg+3vc952kLzVAggFk7ZoHp989tzcZ8BAT6AGGyTMh2eeCAKs+gZqVGxkbSj5S8cQOMLOTUIhYqufRJAmLoUvbiEhbWlnhaW2j3rMRbvGEHcEzAngdYjerZj7UMImnXRdQNN2CZU+5Ssbg4x5jTFa/oKuKUyDU5kMdLw7ufbISFyBj4tbL9mjoaPOvHTIuZk1v7LOO7Tbg9cDUvvojDRfJOMuogI2a9mr92lPsPEcD/SiyxOJQCu2bq6zffB/M3s/ab7pYvgw4EyVe9EkkHuSZj+NiDxoqfl2TV1uO5c8m67rHQYyVGFLLheRlvwiUzc6Gi3CFJrfCymOvgejhiLQASyFPBCCyueFMRa8PCbtik9/C4/yunYbf0t2hYoAl1wcnr2S0DPeeVCOTvYirH8ZoTa99/U65TdTibEvqEMOLwp5t6pjGwLj4lVThG/3J9aNfMNT0l7Sk4GvDyjSr+oq1uG1tlxcqpq5tj+IfnBnDFBKfP9PKLbdCHPkdPZZSdIu+T6iCn8TjmBh6BzKSqOZSzXdHDvhuAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Flwv67uL6QrcHirLVnkv9c3oCL6J37kb++TvC9ozr4yGTPwIgPv0fE5b4XwL?=
 =?us-ascii?Q?By/VzwZpIO4Gbz4yg92hne2cY8X2014OemvG6WiD5BEr8k2sQ9tWjhBTHN+a?=
 =?us-ascii?Q?5L+GYWZ7Lh4EXfXgL/YNlf4J4T9Y3iUFDvhIbpGf8zkm1uzKQ8WPeZPlmtdb?=
 =?us-ascii?Q?qdcE6wmgKnITM5dNWawr2ScnfO6PqJTK2TKPUopvo+N6CLWJIdANSkkyfWDC?=
 =?us-ascii?Q?XyZ6ZKN0icqrQsi0s9+5lZqneR2b53BS+85W6yUBe82BG7Zx79qOzspXXtr2?=
 =?us-ascii?Q?Fmz4LY1IVZpzNCgbRe6B0byBJqeZJFPTGEK81u1jbK9hwcxqDLt9dTaZIG1v?=
 =?us-ascii?Q?wJoL4e2a7EkSToiWn77fudGNdZWUckWHfPMjCRP6N+SbHMRVk5xmQQAzjkdD?=
 =?us-ascii?Q?wM5toruXEfqzYdjF3gH/LMidnBTUsZ1Lx+TQRZ/uOQOVjZyOjR033fS44ctf?=
 =?us-ascii?Q?lr1OlgZItiePGTReTcZqBnpK5VSEzGno82mSr/D5zUkS0jM58puzEgcjwFeX?=
 =?us-ascii?Q?SUPEzmOdFZPhkXTXBTVjDLKLXTK1RW/H98x1j6KLUky43vLNa0LYhnGU/VXs?=
 =?us-ascii?Q?TJuO2mKappmffe6pBC7dSty/YxP1GrQuWjeeeoz+5YR4ZTLWUEv1FaVn8ggJ?=
 =?us-ascii?Q?OjTI4czrZkrV4dKktSpl/H7x0/tlPaHPzGGiaas9/IiLtGsPHz7q0Y6FldqO?=
 =?us-ascii?Q?3MCP7vBKQZ793A2qRaYMvyIbOR0RfwegLMWaYJrXi2i3o67SIYkfwuhYnIOy?=
 =?us-ascii?Q?CIe1Mu7OIsQzvbgPp/jDoTytmQo4TWJCe/s9p+f+xxFfz9VJa3DHM8OsE8JJ?=
 =?us-ascii?Q?fnSIwYksiBDXufKcTP4DO//A8t+qpcMwdPUBUtH4QIcNWU8opooq2c8Pfddc?=
 =?us-ascii?Q?nx0HZVYYLC5KWKg0VckMdBDOiReAbpjlc54kjANx80IN5SQxbXC65gM9EZAr?=
 =?us-ascii?Q?ZanOIRmwDgTJbQUq+tJv3JzjDIITrg3W5rlOxmzbvWG9nlrhIBukasb4cWeo?=
 =?us-ascii?Q?LMA/h5LIaNCGPgFOeD3lQPTwzZFBZwIa5+FKI/Et/HcYmFIz6FKObo5EPdGy?=
 =?us-ascii?Q?6UxpVy5LsD2XG0/G/GeZBrAHP3fpxYHDOvS684s2/6nPMUMVgiZ+BLbx30vv?=
 =?us-ascii?Q?hjFBG145MawVBS3xgSXehIQUR/u3ZCh+Pf5b2790IIc2sAGDNBDd+sQVAsjW?=
 =?us-ascii?Q?QZ3KDaaDxPYNsL75W1MgJw5MOP1WXw6V72yLYVb23S5nrN7q7i85z2Mg9ObU?=
 =?us-ascii?Q?adk62P7i3oi2yFF9io23BPvXzYBPNAT6Aenmi3hp2de4SKhocVBJjZG+VZlJ?=
 =?us-ascii?Q?mnxY/h1HrGtPJofJit49pbnlRn6lcFww4nEP7GMd0KrQiq6laNbNrhWn4GXz?=
 =?us-ascii?Q?TG+o7QgdleVgHe1R+UoDNXFcRrlfQhcteWsfiJLtY9vGxuYtGS1LEUEeYk0b?=
 =?us-ascii?Q?4KBaiz9W1LPv0OE5p/P0wXDafK/U/PfTGbaqyHcCsWZ+zA4GgUYE58YMBAvR?=
 =?us-ascii?Q?NYtvtVZVTLjTGAAWTTv5DGwdaCoYiwqBUWnYWFxjoesQa+cHdo/cdLYMxM64?=
 =?us-ascii?Q?5Ksk5hINozj1hjVOqWsErP3uPZ8o7ykBVQkeoyo1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb25080-d9e0-4631-4cd2-08dc3ebd7232
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:44:16.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gCkpK4dMLdjZY9fiuMQ2+iGtz3E8MddqnrAB8ib7lG1rh4BTPr1c6vAw4CKYqto82tz2mZXGlRKPcRZKr9Vog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

Sagi Grimberg <sagi@grimberg.me> writes:
>> +static void nvme_tcp_complete_request(struct request *rq,
>> +                                   __le16 status,
>> +                                   union nvme_result result,
>> +                                   __u16 command_id)
>> +{
>> +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +
>> +     if (nvme_tcp_is_ddp_offloaded(req)) {
>> +             req->nvme_status = status;
>
> this can just be called req->status I think.

Since req->status already exists, we have checked whether it can be
safely used instead of adding nvme_status and it seems to be ok.

We will remove nvme_status.

>> +             req->result = result;
> I think it will be cleaner to always capture req->result and req->status
> regardless of ddp offload.

Sure, we will set status and result in the function before the offload
check:

static void nvme_tcp_complete_request(struct request *rq,
                                      __le16 status,
                                      union nvme_result result,
                                      __u16 command_id)
{
        struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);

        req->status = status;
        req->result = result;

        if (nvme_tcp_is_ddp_offloaded(req)) {
                /* complete when teardown is confirmed to be done */
                nvme_tcp_teardown_ddp(req->queue, rq);
                return;
        }

        if (!nvme_try_complete_req(rq, status, result))
                nvme_complete_rq(rq);
}

