Return-Path: <netdev+bounces-25671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51B77516B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067EB1C210F8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333980A;
	Wed,  9 Aug 2023 03:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806C181
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:31:28 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D0E0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:31:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378NolnE010112;
	Tue, 8 Aug 2023 20:31:09 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntk8hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAJYOvKnT2rv9wsf5kLVroq2QoLU6mBVHYZyfzKI9NQL4mAPQ+uMmp/a4ddVlGCRBmuKLD/XbpG1ipzagBefpL4vvPs7lNlZKehkzXY/5zVoPzBMDfHFy8mUn2tm5MsND2inRJQmETd14ogJbYcm9WZvOaeOYIpo8Q5LsGcnEw3Ps2Eh/ZHLR2VogcYHt2I+i+XzpGF11Vboi6i0qWCEmMGQgFE2bRzYNSSy5jHSQQsKsm2SU1cUg5iLH8I3QGFkUkCsbpPU66hELootQc4Pr8GjxQeGmK9ANE0lwN7SBOWDEXE5miE416BVsnZawmEE8iR51DTcAaZ9yD5RXjw3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E72kqWGeNE0nYVvMOkeZz1bf8WJttIM2lnQxfNFSquM=;
 b=EO3e7yw7cdIj0u/ihV4DEphrNa8KT4KCmJR9j/EOZNV1/OEXz5dMqN17nR1vHw0G/+synQuabpmKCgrv7oalDkEK2Dob3sCLvejSTq3IfPVz2KA7QVAJ7pAuA6GITy5PfTBN4ut9/2fkGmWnR2Db/AEKL18u5fQYzwjNZFU+ElVl0kdOBNW41OEIbaNY14OizCZcTINgVLl0r4fhfS9E79pTK8K8ALGXUX6/1TsF6NGBDjMLNH0+1WE4T+3+HXckG1cd1+/r6XuAyHB+CRjT1mHc0VAc3GdaJYatGroeDzP6XnWuG0AiosT+TGFK4zzOt+xrSj6efbhA+0lNRehbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E72kqWGeNE0nYVvMOkeZz1bf8WJttIM2lnQxfNFSquM=;
 b=ZZtfu06XnLPxGT4QWGyeP7IDnIXJp08BOGdUP8YBmmYzlWfJSNZ7q2CqnwRPPUujGi1DIo/KVLzd1K7YTDjOHvR7jiuy1Tq3kFZKze4HwrrBxXvvAXh4MVA72W4jEW0XnyUuqj1zgSBm6XMj+N7o95K3+nY5QvGW1UXU6BnHVy8=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by CH3PR18MB5571.namprd18.prod.outlook.com (2603:10b6:610:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:31:08 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:31:08 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Li Zetao <lizetao1@huawei.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob
 Kollanukkaran <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next 3/3] octeontx2-af: Remove redundant
 functions rvu_npc_exact_mac2u64()
Thread-Topic: [EXT] [PATCH net-next 3/3] octeontx2-af: Remove redundant
 functions rvu_npc_exact_mac2u64()
Thread-Index: AQHZye3ZeGgYRw4NyEuHMX2Zfqx9JK/hT/Ew
Date: Wed, 9 Aug 2023 03:31:07 +0000
Message-ID: 
 <DM6PR18MB2602CE6D00C9A6080BA14893CD12A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20230808114504.4036008-1-lizetao1@huawei.com>
 <20230808114504.4036008-4-lizetao1@huawei.com>
In-Reply-To: <20230808114504.4036008-4-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMmJlMjRlODEtMzY2NS0xMWVlLTk2NWItNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XDJiZTI0ZTgzLTM2NjUtMTFlZS05NjViLTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iMjk1NiIgdD0iMTMzMzYwMjU0NjYxMTA4?=
 =?us-ascii?Q?MTQ0IiBoPSJvd3VXenEzZTZ1YytRdE1jUEEwSHk1dVVmazA9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUN3?=
 =?us-ascii?Q?SVR2dWNjclpBU085QkVDbkEzd3FJNzBFUUtjRGZDb1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQURnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFVQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2602:EE_|CH3PR18MB5571:EE_
x-ms-office365-filtering-correlation-id: 5c336172-02cb-4091-f094-08db988911c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Kqf5oOeSYye8lkuVfTdD4pGdE2BGIfhcsMAlV5BuMGO47+gsRbdB+sBqdwMRHaRDahed+QshTqxLbRp723d3OjekyjnBasw+uLPzN9ukOMG/mI3CRx+DQpNv8vt45IDzCunsHadF5SH2Ajn3JCop34ZYj8Q+YpNLJp/NhDLfH3edV4GDH9VHb0KUkADSxim7S6SRBCDWTsjfck/SVsXWK5rRu4O1fgGwmrUEFovLvWM3Yzq5OFxAEefiruRlUJBopwoLjSXbN3HFFx8sFhRAafc/BXFepSgULt4nVGr42deeFGR078jBKFoKl4z54QfLh8dB8BENmEgYdkA9cohUTu9ipLsYV5PPNur82hIrR2UFhG6nsyaylhnWnTND5ZVdVASLVVD9iFz3U1UzG9wI6rTk+7m3u4CSIxkNeLIpBqCjml9c+NjhM/I1GBbgQERy01PVBkAgl3GLnwjZ+JZjWSYC9U4qpmQwSXpb5KmCTM+FPWB2BftH5Ogaz4+Tb3vq0607LxQyXctmh6pPOS5/2m5ddXsWE9FYdauc9KhwSS2wjC9KVbmi564BFdJlDB7KBLSRek4PgTLM+DCY8tZfuVxYI9pfTwDr/EPks0c+Qc2Ism3iGbfVljGkHYDzL1CZS/yYFBXDmPgXk0T2GTBN/A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(186006)(451199021)(1800799006)(52536014)(921005)(122000001)(478600001)(9686003)(86362001)(7696005)(26005)(66946007)(66476007)(6506007)(64756008)(76116006)(66556008)(53546011)(66446008)(4326008)(110136005)(38100700002)(316002)(71200400001)(41300700001)(2906002)(55016003)(83380400001)(38070700005)(33656002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I2un8aXkmWgy67/PCwRWPu+v2FHbfgG/SofGJaa7O0ZhI4jrwm7tkUhcXeZ3?=
 =?us-ascii?Q?EwIrEpwI8FnzS93+jul2riwNdZ+RPXbvUzPNmkZu+RU+1I4bH3NIriHOknL6?=
 =?us-ascii?Q?yzCzo0HrgoaaEJ8iwTihkJVj8tr2aZonNtMtjsyrLjol+eGO9x9DHaDSUbv+?=
 =?us-ascii?Q?rsEbTiQbqM3TstR7o6SRCFH1hiTb+Hh+ojj3L1eNC24oxuHl8WTrLlI4FzFG?=
 =?us-ascii?Q?HMILwMP/t8JBZiI66Ow2rHemDkyZXI0nKZWA3Zq9umVsDyrvVTr0PFog5gGx?=
 =?us-ascii?Q?SbK3GFGFSlKQHZDA0KEtaBSMyjfDUEIN+C+FZItjQpuVmQbMcAj2Yq6t17CL?=
 =?us-ascii?Q?J+sXmA+5jtAbrkA1TDuLZMY+lQyF195zywiDRr2fUK8jamJE0fnoLK6dXJQq?=
 =?us-ascii?Q?Lz0MEnqV5bfqPXObMHthal/ZmCkisIvosDZBInHuyixPtuQTjwhnvaa95G7u?=
 =?us-ascii?Q?9cgN7JE82c/kB50GYQzpvQzO8CWwQI+VIZcdJ2zwZe4fbjRIY2j0NjM5HOjI?=
 =?us-ascii?Q?tY5w1UHL63vekhNGUjE4YMqxpXKROy+aoVA0oECZO9+ACdxRwAyvhMGXmIxx?=
 =?us-ascii?Q?C/XGC5p0uaHGBfmsp4ZmUjILB5lCVpHHaRDsMf/l58LMRbS+5VNJ47v65tYp?=
 =?us-ascii?Q?tYI7jWamWLbV0pu5Ujvp8Vr4BsZaSVFf6+hbB4ZPkhpxXOHgGjiTsWa6f2yE?=
 =?us-ascii?Q?tOlyXSCFD/xb328+X68OOmjTtV333t6EKf0Aa48fMXvPbnuMzVMVaPD+bRxu?=
 =?us-ascii?Q?YbiKrMhNZ+pxKcaecfOtiwfHb/jG27LUcjPeb5T7hAEzrOw0apU49c5Kqjfs?=
 =?us-ascii?Q?gZSLZrPhiLFI/yPnmmm/d/DHld0+QnmuutSibSKwTqLRSQQvnCDMIfeHz9i5?=
 =?us-ascii?Q?kuu1SjlEdU6uptplvDzbLSN72EVBJa6kt7XD2ukjwPFfj1TXhKR2jrx/FexW?=
 =?us-ascii?Q?tbuKXc2jjdRYDsHm5xYJEaozNIGPLQ2wNsLs98T4O0+iqO+TON3GmC82qTcK?=
 =?us-ascii?Q?wOYF0fWfsULM6vKC2sbXMHX6ujZCCwvH9MPkB+7AnIMk5qYfq+yIKAfl/du9?=
 =?us-ascii?Q?ZH5aJBGBxycVCFkHmsknv8G+IG6iEftnZi5d85w2ihGFVfdtX0wUgfSiw3+T?=
 =?us-ascii?Q?EOXKdbUZemRqV39m74YDyAMCgaA3rr9IyUBME+8c0ryfT8OCX5VKtUWuQX5/?=
 =?us-ascii?Q?vymufIX2na5VGNIUfgenTBMLgf8fsRQrB79O9pkjSxMQt0P0+tUI76Lig8p5?=
 =?us-ascii?Q?RlY+4FG6E9pmcBQPQYJJtLV62RXypVcEohQCpJeR4MwIoVJYEivgRUTYZJ5z?=
 =?us-ascii?Q?ZwZ10WAe4f6ZQ8h7J0bT7ZI28pTL/Np4eml+QIr5BfY7CXg88vSqq3HYAGpZ?=
 =?us-ascii?Q?iBuxCO9dGFzRgY4Oqv51+2Tucnn+Up4oYJMX/xSNPyxQPYvP0MIfvPWo34FE?=
 =?us-ascii?Q?iGpTMTAZdbYJ49LD+2hN5UAHDE/Uv9AN7cmotGqfxQje/dTAFaw9JXzxVEEG?=
 =?us-ascii?Q?fmaMHRpQKzVU0kCzNhar5AhArctAL30o30CQHUyA6OFiBkZSeAB0Rkr12kxa?=
 =?us-ascii?Q?pDmIlKlLpjlHrSiHE2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2602.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c336172-02cb-4091-f094-08db988911c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 03:31:07.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrI2Ca06TlY7CObECbW+DOjrh/BkITvsKSkL/is6UwOjMzeW9M5e2IjqpucB2z7Zs+/GIlQrzZ5MTVsfJ4XBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5571
X-Proofpoint-GUID: 1tV16qgqTP6tNtLY3c9LNRXM85fCb0-E
X-Proofpoint-ORIG-GUID: 1tV16qgqTP6tNtLY3c9LNRXM85fCb0-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Li Zetao <lizetao1@huawei.com>
> Sent: Tuesday, August 8, 2023 5:15 PM
> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Linu Cherian
> <lcherian@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
> Jerin Jacob Kollanukkaran <jerinj@marvell.com>; Hariprasad Kelam
> <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Cc: lizetao1@huawei.com; netdev@vger.kernel.org
> Subject: [EXT] [PATCH net-next 3/3] octeontx2-af: Remove redundant
> functions rvu_npc_exact_mac2u64()
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> The rvu_npc_exact_mac2u64() is used to convert an Ethernet MAC address
> into a u64 value, as this is exactly what ether_addr_to_u64() does.
> Use ether_addr_to_u64() to replace the rvu_npc_exact_mac2u64().
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 20 ++-----------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> index 7e20282c12d0..d2661e7fabdb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> @@ -390,22 +390,6 @@ int
> rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
>  	return 0;
>  }
>=20
> -/**
> - *	rvu_npc_exact_mac2u64 - utility function to convert mac address to
> u64.
> - *	@mac_addr: MAC address.
> - *	Return: mdata for exact match table.
> - */
> -static u64 rvu_npc_exact_mac2u64(u8 *mac_addr) -{
> -	u64 mac =3D 0;
> -	int index;
> -
> -	for (index =3D ETH_ALEN - 1; index >=3D 0; index--)
> -		mac |=3D ((u64)*mac_addr++) << (8 * index);
> -
> -	return mac;
> -}
> -
>  /**
>   *	rvu_exact_prepare_mdata - Make mdata for mcam entry
>   *	@mac: MAC address
> @@ -416,7 +400,7 @@ static u64 rvu_npc_exact_mac2u64(u8 *mac_addr)
>   */
>  static u64 rvu_exact_prepare_mdata(u8 *mac, u16 chan, u16 ctype, u64
> mask)  {
> -	u64 ldata =3D rvu_npc_exact_mac2u64(mac);
> +	u64 ldata =3D ether_addr_to_u64(mac);
>=20
>  	/* Please note that mask is 48bit which excludes chan and ctype.
>  	 * Increase mask bits if we need to include them as well.
> @@ -604,7 +588,7 @@ static u64 rvu_exact_prepare_table_entry(struct rvu
> *rvu, bool enable,
>  					 u8 ctype, u16 chan, u8 *mac_addr)
>=20
>  {
> -	u64 ldata =3D rvu_npc_exact_mac2u64(mac_addr);
> +	u64 ldata =3D ether_addr_to_u64(mac_addr);
>=20
>  	/* Enable or disable */
>  	u64 mdata =3D FIELD_PREP(GENMASK_ULL(63, 63), enable ? 1 : 0);
> --
> 2.34.1
Ack. Thanks for the patch.


