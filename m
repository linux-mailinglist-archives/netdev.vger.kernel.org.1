Return-Path: <netdev+bounces-92915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479BE8B9502
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2384281E5D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56671CD32;
	Thu,  2 May 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1Ib1bIn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E441CD31
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633463; cv=fail; b=M6WBCDy/qbFhziL6394vRe33n09i8IiR6+R9w2GzVLGO+KW3FLzrW9rDj4qj752gqr47SviOBHi94JD+4ZwEtsYX5vA6xeR12H6BmSEpec3fxLaXsHYU6U5ltRH6whiMuNMoclqIXDkck0FpNzejuJX7kz7gnd+wXLPum5zty8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633463; c=relaxed/simple;
	bh=pyVhiexesUOzLKvkaq8hFwtyu43Wyr+/6KNCjNEHnYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=bVhU8Dr59pbd8eEE6ab/5PzjJJDsjQmyGBttrK6XuBZZ/UOrPKTCjSlGfv4WXlDjV+4hqxnYdbqNunGsiLrWWEAElG/ybUcBTfgb4CHo2TgbvTkiOPJj2I/p9wkbxDjppaLMrbO3fo7wMV3DqdF1JBlagaOji6fW3KsA/0mv1BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1Ib1bIn; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWNJZNC6Vn6ixN+Bk+VDT+muPvoVOHb3vQxt3rJSG1mqt90xKwg4pSjE3iJiyD1q3oK+GVPe/JG4BQaa0usdDJ4ERRRrBXozzUJo9/4hS+sGkPxTk5jBMtRgSacimoAZWoLk455djx+sUgfCyhLzgv0wlTRXmkUZZ6eqy8MAwG4y9VhGRDS+1hpLG9vYN630OqIy+2vffxf8WfVH8XsYIUiRzsF+Rt3/71KI7QWqqRUqo6uJjqerKrUPCuAGzy/JPSwTOiYhR54aCrj/BvuB7fcZhMmes5vpSHu3kSIC+5Vui3ktmXFkuO21XRmveBzvWiLFj8WAqgwwL7nUzC0HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1csVuoZUDPBdukvv0zjIqsdCMphVmMwc4peyavkehk=;
 b=OzDPsWhqEd58VVZGG79TRcJWJb3vX15bjbVXZCdO9xfRqUF57JOTx3lS5V92XRcI230ixbbyfqRZBSQCPaGxmwMD239/olUTwHRYXqujzURuDhPqvXUYhKWYLMQ9L8rNXOhxrTjMFk/lmYYkJDNt6hFrbV1WL2uQ5Rmb9IJ5NUCcrzJLQi1Yw58PFsilooPtqnuIWkNrZpi/gALg7CCiKIVocx4tw3ePcMaMwkvX5wI+fGQB3qkJWrnP7rhfvPZXTkIPaIVGz5a1/rZh55Xc9eA7mDCLVZmIVTD5m1nRhFglAHqq7oVC3YXaHRSkFTrw9lfelFSkcCgqd9mhmMibZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1csVuoZUDPBdukvv0zjIqsdCMphVmMwc4peyavkehk=;
 b=K1Ib1bIngIMctDGIylDMUlpJR6DhUCPc68nJg9V0trBElEvB0cqYJnXVi+lqON+DTqio46fi3F5uGplJr9Xt3Otq2dCHywYwVVgklYsP+XHCYR1v/4XbcthGXXwWfxsamyQmWhNPPn+qxA32asCEk6VFPz1nlyk0JwwjobORrZnT9VXERfzI/zpC7yLIf6P4jeuJwGwRqX16g6TgLTfEU6ZA3cTuo0giFXOGeHCRRMzNe9ou3gqfM7BjTNWAfcrLkJCIUqWpS7gvroQFPUR0xVhE4UJ0W9BXLd228pQqetykNgpYVrW8DIwmDBMHMQHQIMDMNzxLmR5wKV+R0V67ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 2 May
 2024 07:04:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 07:04:16 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
 <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
Date: Thu, 02 May 2024 10:04:11 +0300
Message-ID: <253frv0r8yc.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8331652e-6029-4344-8b79-08dc6a76146d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfnVUrjFTwqStiiWqabRrT1wPgWG6tesn1f8RCgr9H0OT35Y2sEALGRqo+/6?=
 =?us-ascii?Q?ocSJh2stqmT6Cpr+3fGUwdr+YG4pAyNsWTAFB66olclhjUWs0Z3NbKFB410l?=
 =?us-ascii?Q?jcG19/Od1VAohQVdNYiFnEx/pSKASnWa9Nt9Ub1KOnJbX57kTirxZyz4uVUO?=
 =?us-ascii?Q?+CGPOcJolkCesd9fsf419pxUgRvN/a5tTNw5KvejNJ6Ry75fnJ8Xd2ipdHxv?=
 =?us-ascii?Q?DxLlbi6QAyABgGtgqXw8fCijKlcqN0YX9EuPhzbEiQsTFOefGP8ahzbJt579?=
 =?us-ascii?Q?lPnxcVywJY7GFsL7T1q0xcFyu2d227eHpc6ELgdB5gSpSqROfeNsGDRZ7FU4?=
 =?us-ascii?Q?An2FKUMwuMSpa8Jkuk5gogSPOwGrLPiLpuVJHlBFBG+qRiVm6klDmbiE4lam?=
 =?us-ascii?Q?3Gh1FcIRv8YI4jgrYYZBQ0mBD8wFVrg5i6ydSm0ofIyuy/lKkIQ35raRQGJz?=
 =?us-ascii?Q?ICmHwCUJmv8BG6rblz0qWW5qs+JHCnZSSvQeb8zE7w5mDO/LKmt3hIGEjEhy?=
 =?us-ascii?Q?rmhTSNHRGI2OXAQzcrusRQlRC5DnENBDsqzcdFT/5VSDGBlx3EEDRuHyr8z3?=
 =?us-ascii?Q?ZzPS04FrjtWTuhYBjdUvxN/7PTtyJD9k4ZZQJgKmLftaEQeUyTzglxPQxtS1?=
 =?us-ascii?Q?xNvzjf4Lyr5kyWQThk7fIG4JJ5APfSqsOQxL7vOYrR95Y40aLEzOCzYEOC+9?=
 =?us-ascii?Q?eEdv8LhV8RYJn7fjtwLodOGseHonU+T3zDJYPXLpjcZiH8vryK4rzJcKDTFF?=
 =?us-ascii?Q?FBvR5oiT6vpZ8i3gAQ/fRc5nyE6a2z624AdaWL849HYKfL7B+QcKF2gzBfZy?=
 =?us-ascii?Q?fDLvsJizWpH+wIVDd8aeirANDMsyOuamZDHiqPLGKNpCPo9VosB2x91/lYko?=
 =?us-ascii?Q?EFOwMstWTq0UcPZTnw5RGBkwvpWZTWgv986V5CFVLJMFrx2XVIK61cwTGMgs?=
 =?us-ascii?Q?ypkIWVLIE/zpbyM0aOClnW3TvUclqBzBgP16Y69cGSqFMR3WR9qDuEDlPhd0?=
 =?us-ascii?Q?klMnR/0szlt0cbjWsGYlWm1fxQM0d3hIGcGewbgGrBM0EpHifEDhdvrCerK/?=
 =?us-ascii?Q?nA0J6YqE51R4dS/+dchEpyc2dC1mylew55WTmgwqIvtvF6SnSlztih88myj2?=
 =?us-ascii?Q?ikOG9cS/VsXCeKKO/sfalCUvIaqAV14xdMMHZCQ8QlVZg3GrMKxnwjVevXK1?=
 =?us-ascii?Q?SHbJS1fspr6OBllZ+ZrY7qyQJ4o2sQ5p6PqXno+ve0PK4IFWdHcmfyeCYbgp?=
 =?us-ascii?Q?4axT164AbMTbEgstRiItII9KGBnZB/xFYM3hQfktrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fDUcPAe4Kk919qX3/LHlxt6cup6lW58arvsdc1+c4f8SQayjC9EWigSET7p?=
 =?us-ascii?Q?tiGT+1hJgu54Dus2+tUmPxq4jst1B+0PzM+lTOnThvcmpNjoj8vV/gIe6cGj?=
 =?us-ascii?Q?tafGOcYH3yXPoO3MzvSp7WLCV+CpNYL1lpB+w4CFkbIOnTHW4dR/W7xMX5Ja?=
 =?us-ascii?Q?6ZjoujRal12hXVieT2NWPjdq7qFGDBlL1eeP+YlaUk1NrwcYiWGX4l41JQb4?=
 =?us-ascii?Q?PRUGPYllhV9oYjYjIMCF+rZSXCr0FZyGbDDHUZKlUlSCi6NBOLYb/i5vZgJU?=
 =?us-ascii?Q?CdcI8nmZdXCqp/WrMBrcdTWdL6UAkVnjz8NeaASGUYclnjtlpj8yfrodoREG?=
 =?us-ascii?Q?4VQax/eZwTuYZ8o0ek4qfha41RfuYCk6xrpzm1F2JUYwUG/ztE5+PhvWIplm?=
 =?us-ascii?Q?ekFXLSxsakyFZj1zhdSXfe4/gW2iP0iOj4yN5dG49EyjWY8YzvdUuJDXEkJw?=
 =?us-ascii?Q?JVVjmG2rS0YS/X6Ymp8V578LDB++54IZ/VBWHk/lU4UGWM4GqZhJCmP1IdU0?=
 =?us-ascii?Q?6QB5JaXEzXhn37uAdKK8GWK/6BVyuBkPDN7+MxVAzJHbNUyMT49i1apAERN9?=
 =?us-ascii?Q?fQWcNM+/qSOmyz6GqK7fpAH2QIFuZOP5qC8io5kp1+GFA+IHSfYx76wAD5nB?=
 =?us-ascii?Q?pf8zlgrotf9aGDjaczbYH5nLjVJmmXAvVz+60qfYlJHZqoa6k471gKZnsmKd?=
 =?us-ascii?Q?queDusizZLzMFIceLVnyCy66fjfxg7YlSsoRyzIsZ709xvVu0XnyXc8b1lNC?=
 =?us-ascii?Q?Z7lLCqxfWzI58dUninvWXvN2rV9HYEs/M3J8lcz5KwWuFpGSGaUzeFRIZSqe?=
 =?us-ascii?Q?073bAWcPZpkzhNSo0AG4G0feXUcHfccWO99A/OeLXk0Dg7H4IsJmidWfkbZS?=
 =?us-ascii?Q?4FSzotEnGzttrjdYebwkUvY60NedBqQhYV0yy6Nexal+Ra3zanTpXNK3ylB7?=
 =?us-ascii?Q?u0Fd2lsOla8LlfAr66j/MDVCsMDT9xI54oNZxKKKbzV9IrTGJGEiY7pPPItL?=
 =?us-ascii?Q?vP6zJ0I+dP9wgst/Z9SSjn7VtQwuEyrZYMTKd66ITffhSlmi6r2toBfoIgUe?=
 =?us-ascii?Q?WRXfsj8lcNHJQcJcAJJQUF0GLlJlk8IGKde/qsfs0VW/WCEz1XrsjcECMeqG?=
 =?us-ascii?Q?k6Xr+LKoZLBRjAtL3ZfTEklnWlfUoiCh+JeA64m5GIKc8kWRLoUtOrvuupLC?=
 =?us-ascii?Q?ZsP26bsjTRRz3PAk6PP9JSbJyXnuwAb/SBE8tP0mQxYNUjjeoBmf/GKJcXH5?=
 =?us-ascii?Q?0SJJDCDFm0Og/LPmX9qP0YUBtYkxLrzjtcClom4su0icHS8WECOMH0ZZcFGm?=
 =?us-ascii?Q?HhcRhEiG4aSeVjKMakBHkOtuHqchJwNv05m/Z+Jp01M2WYjoarLCxIv0Vhy9?=
 =?us-ascii?Q?/DPKAsw68iqfcU8CHMnhC23p50dCphdIKaoxdqH6s1F/Vw78Z5dEY5LJs7Sv?=
 =?us-ascii?Q?KpyTkE+6HGMsH1OvQ9YukB8eTsFFMO+W1CGyBdd27BAoklo+AHXvmLts49dS?=
 =?us-ascii?Q?9plBnJcT/nYrSq4prIHj/4Iq/83wWNYe7dkjlTptflv9/ioWnSveyW49bmhH?=
 =?us-ascii?Q?tBk2ZiFWJnvDkN5yZYeu+LmyP4zQpHtl9lMdE+Kx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8331652e-6029-4344-8b79-08dc6a76146d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:04:16.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwvdQBIpkHwE37R/wMKD/Tldu7SpFDnY0y1e3q3sVrWRJP8UtsM9Tzk/v7NZsKwvZGJ8ZtDPTAdd4vBcv0nj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533


Sagi Grimberg <sagi@grimberg.me> writes:
> Well, you cannot rely on the fact that the application will be pinned to a
> specific cpu core. That may be the case by accident, but you must not and
> cannot assume it.

Just to be clear, any CPU can read from the socket and benefit from the
offload but there will be an extra cost if the queue CPU is different
from the offload CPU. We use cfg->io_cpu as a hint.

> Even today, nvme-tcp has an option to run from an unbound wq context,
> where queue->io_cpu is set to WORK_CPU_UNBOUND. What are you going to
> do there?

When the CPU is not bound to a specific core, we will most likely always
have CPU misalignment and the extra cost that goes with it.

But when it is bound, which is still the default common case, we will
benefit from the alignment. To not lose that benefit for the default
most common case, we would like to keep cfg->io_cpu.

Could you clarify what are the advantages of running unbounded queues,
or to handle RX on a different cpu than the current io_cpu?

> nvme-tcp may handle rx side directly from .data_ready() in the future, what
> will the offload do in that case?

It is not clear to us what the benefit of handling rx in .data_ready()
will achieve. From our experiment, ->sk_data_ready() is called either
from queue->io_cpu, or sk->sk_incoming_cpu. Unless you enable aRFS,
sk_incoming_cpu will be constant for the whole connection. Can you
clarify would handling RX from data_ready() provide?

> io_cpu may or may not mean anything. You cannot rely on it, nor dictate it.

We are just interested in optimizing the bounded case, where io_cpu has
meaning.

> > - or we remove cfg->io_cpu, and we offload the socket from
> >    nvme_tcp_io_work() where the io_cpu is implicitly going to be
> >    the current CPU.
> What do you mean offload the socket from nvme_tcp_io_work? I do not
> understand what this means.

We meant setting up the offload from the io thread instead, by calling
nvme_tcp_offload_socket() from nvme_tcp_io_work(), and making sure it's
only called once. Something like this:

+ if (queue->ctrl->ddp_netdev && !nvme_tcp_admin_queue(queue) && !test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
+         int ret;
+
+         ret = nvme_tcp_offload_socket(queue);
+         if (ret) {
+                 printk("XXX offload setup failed\n");
+         }
+ }

