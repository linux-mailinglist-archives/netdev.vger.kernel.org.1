Return-Path: <netdev+bounces-63109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581C82B367
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938111F22F51
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1250268;
	Thu, 11 Jan 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQgEoaUS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281E4F8BF
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1m2Jr/wuflj5fq7qf5EnbJFEKaqu1G+dfaVdAuOCuQOQvUVTSGBy5ztFVE+nW7UFuaXHbb9qzLR4wo78SeEJVFJXww0YxGFWdD7FpWAd89AbyXZO8oENn+rmJvQq0Wd31o1cHTVnD/AlHzIdM6uZ7mIc5ajAEMB1NEfZJwNZvL5Ry/OZKiIFw/MSTTK9NKRRrIJeqzmg8M8o0ckR3WCX4TMY4bpcJyveKVJrRj/A2tPHdYcZShYwi0tBdfGJ1EQ81qXB7ZVx3uFiZvgCjscgZ/MftWYvyV4B3JdiziUxhG4KhQHXv662OBhuAOFA0uB5/b6eH09/b1G0nQX5FGHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJQoN/MPnGOFthW0aywOtU042ctg7rKhvk4To8ufNk=;
 b=ac2I3UxqzzR8gGf2d6RGClb5i43onNZaW7vCSDCl7Ty5lRrd+OypJSFkHsbFcamisnFWxU/ByI5PLCpQuRguRlWFRvvF0SFXVfIsxUsoeHlEG9ExuOWf7XuwBbgSGlyc46Jx9UJcP+O3pXAg9UE0KKasK0JnzpWRtOryj4U2GfFk4gpFnRotsHW+wR2Eom37DSc/5Xh+kLIpkj09TWg++fdx3R92/0s9YoLehDes4L0VKH/glg/iQt9SX/+W1GMRy67Cqpb8MnOBBqDClduyCzGgUfkOJL+vsZCLHpKIp/sIUd7+sOXDhMwroSLGsOCosrWtogP9g8VJgK838uMrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJQoN/MPnGOFthW0aywOtU042ctg7rKhvk4To8ufNk=;
 b=rQgEoaUSjay7GahELWwmHDAv2vb2tJI96W1ukVwdcuA1SwwIYdwS29bWcfo66Ni8fdRHhFlS/3sLgjBrJ4GXa+YWAITSvp+PUPMOGbzFoLFp7NArYKiPNimwLlHhjccHKfKfknTUzjgnBlYkks+eLjcmaHiIZ1dBwJXWgmI9xUUgnXIx6ceo2Q1tvRkOviDV6ubdUbD0WEEp5JQiaOq9EwBMkdihLBh7aGNK+LpRwvZrQakqwodEWFcCTNMKLD9/6oKaR06uxErsb2b+E3tRy7z0qtc6pEccItP0o8x7DGENlrk1cvVWJpMrcX0o5rTF/h7XUpgopDkrT2j7bptckw==
Received: from CY5PR19CA0100.namprd19.prod.outlook.com (2603:10b6:930:83::12)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:55:00 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::be) by CY5PR19CA0100.outlook.office365.com
 (2603:10b6:930:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Thu, 11 Jan 2024 16:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Thu, 11 Jan 2024 16:55:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 08:54:45 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 08:54:41 -0800
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <xiyou.wangcong@gmail.com>,
	<victor@mojatatu.com>, <pctammela@mojatatu.com>, <mleitner@redhat.com>,
	<vladbu@nvidia.com>, <paulb@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Date: Thu, 11 Jan 2024 17:17:45 +0100
In-Reply-To: <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
Message-ID: <878r4volo0.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 464dfdcb-0335-4dd1-b591-08dc12c60c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3t1FyMIizWqaavM9i/sE+k6s8xxA7rmTEI9VlHbbL2p6RW1Yxl0xQGMF0ML3DyMV+F8nFFkhcEtlBrflcDXIM5TkBSxoo7wX4gWoWISL4zX9F1/4ix0+62vG8nXon0RlUs8icVcN/7VGIwH+qvlIsHknsuAbwiloOjAo5wWCPc8kMluP04hF4DFvHfhwVCvjQlXhmlQs58rmrmF0J5Bw032V3RRCStxvHC1NoedOgGjZ49L12wF1cXw/1qEZ7iWPVOJHfbYYLG773B5+zcJABOZP//1k2tiM0YP6HWdmyOBqeo1UaLHOC6IUO4/MHNWF0oxK50OxUhgRbM51qqlmm6twKJdUDoe3aLnQ0JT8CwTvhoeQU/U/0oWXTBsX6wjF12k62OUFY1wyzXhL9UT/LnO394LFhgCVV1XWxMhsigFdwrrglKFB7CM2Nt/AbDzzOI9HyIHBCFI3X3UqALc9vI/Au+9GPtoVNKjFGsetdUb+srhA154qkhYeITURlvKbXbEyxUGQvsWuyPC+aIi0ECBSVoArv7Vkqb8rXy5kqr7GumIiJbWh3um8TWMGxcky/B/fT6OW+1wAU/y04znzr3XpzIu0pAobcIF/QpgNe/A8xq8xCTou+a4VGy6BXlE4OvO6FXqjFwQcVC+gh1c1JhTSAy8pB4ABsCTWNpNfqEu72nIFFdSduDB8gFi4DRLek/58bRjRO/jBXoXWNkooH0pCqKWV1jjnWvmSfVoW+vC1al1SyLKxFz7bEGKzV1pm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(5660300002)(36860700001)(83380400001)(7416002)(2906002)(53546011)(316002)(54906003)(16526019)(336012)(426003)(4326008)(2616005)(107886003)(26005)(47076005)(8676002)(8936002)(40480700001)(86362001)(356005)(7636003)(82740400003)(40460700003)(70586007)(70206006)(6916009)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:55:00.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464dfdcb-0335-4dd1-b591-08dc12c60c80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, Jan 11, 2024 at 10:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>>
>> On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch.org>=
 wrote:
>> >
>> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
>> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> > > index adf5de1ff773..253b26f2eddd 100644
>> > > --- a/net/sched/cls_api.c
>> > > +++ b/net/sched/cls_api.c
>> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_blo=
ck, struct Qdisc *q,
>> > >                     struct tcf_block_ext_info *ei,
>> > >                     struct netlink_ext_ack *extack)
>> > >  {
>> > > +     struct net_device *dev =3D qdisc_dev(q);
>> > >       struct net *net =3D qdisc_net(q);
>> > >       struct tcf_block *block =3D NULL;
>> > >       int err;
>> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_bl=
ock, struct Qdisc *q,
>> > >       if (err)
>> > >               goto err_block_offload_bind;
>> > >
>> > > +     if (tcf_block_shared(block)) {
>> > > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, GF=
P_KERNEL);
>> > > +             if (err) {
>> > > +                     NL_SET_ERR_MSG(extack, "block dev insert faile=
d");
>> > > +                     goto err_dev_insert;
>> > > +             }
>> > > +     }
>> >
>> > While this patch fixes the original issue, it creates another one:
>> >
>> > # ip link add name swp1 type dummy
>> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5=
 4 3 2 1
>> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min =
200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop blo=
ck 10
>> > RED: set bandwidth to 10Mbit
>> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min =
500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop blo=
ck 10
>> > RED: set bandwidth to 10Mbit
>> > Error: block dev insert failed.
>> >
>>
>>
>> +cc Petr
>> We'll add a testcase on tdc - it doesnt seem we have any for qevents.
>> If you have others that are related let us know.
>> But how does this work? I see no mention of block on red code and i

Look for qe_early_drop and qe_mark in sch_red.c.

>> see no mention of block on the reproducer above.
>
> Context: Yes, i see it on red setup but i dont see any block being setup.

qevents are binding locations for blocks, similar in principle to
clsact's ingress_block / egress_block. So the way to create a block is
the same: just mention the block number for the first time.

What qevents there are depends on the qdisc. They are supposed to
reflect events that are somehow interesting, from the point of view of
an skb within a qdisc. Thus RED has two qevents: early_drop for packets
that were chosen to be, well, dropped early, and mark for packets that
are ECN-marked. So when a packet is, say, early-dropped, the RED qdisc
passes it through the TC block bound at that qevent (if any).

> Also: Is it only Red or other qdiscs could behave this way?

Currently only red supports any qevents at all, but in principle the
mechanism is reusable. With my mlxsw hat on, an obvious next candidate
would be tail_drop on FIFO qdisc.

