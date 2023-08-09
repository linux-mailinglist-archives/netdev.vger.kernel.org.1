Return-Path: <netdev+bounces-25670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414A775169
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE81B281A24
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40192808;
	Wed,  9 Aug 2023 03:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65762C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:30:46 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF677E0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:30:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378NnLS8007556;
	Tue, 8 Aug 2023 20:30:31 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntk8et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeN8NZGjbz8tRHj9WDBwv5UPRDX7Rl1w9uyyTdv0ArYqP3UAcg7n9iGZWzySTDtCVzbbUid4Av7xPJRNGloHC1KI3jdO8K2KZ9zJlhK7rDJArqaYy0cY9YQI0ML1rCVvVdVdcHjmA/FOzzuZv6eOXkn4OF82uxcXDt/yxatlLX2Zz/QF3J0+jhS6DuGZRg0V4oHz1Rz7l0IRoaSeWpB/sNwPwiaWZMg5ePHJgI4XMEs3GWAUZtOb12XaeqbUtvCVOx5QxAv2htSD+8uHMOM71QGtLKbMlDPdl72V9S1ErzmtLNA6XL9U3yw6gOnuQskL4vp+U5JZbPc+a10YQcgSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNvCpXL0xKy0KJFeclZGDfJMVv4jRqz7951dvsDFqU8=;
 b=CQaUVtXgbfkU0v7Ys6J/XKo8gmUZLNom8jJAtAE22VT8FvzkHWMFXgKWYX9EWx8zimHL2qfaPaoA82sfZeE1PrJbfoldtzZwcwrhg0y3lq7zZK6pJ8YmtvKXajDYI0slkPPCshIPOxlGcD/ufPD91Hu2nbqKJ6u6n475HCWUgehJoKapsiKDgeziCAcuqPzdWWSABJegu4aIGUSUXaUiXtC2DC0EBSrFujDKpSI7u3T0SQh4aWjd/CgKQhbd44k+3+6AcSYj62xOMKjQlxe7EskVOUVU+nWMNrbba+0xRx0xjxDWsn4Cih350jdl63fvHtwyCizvRG46JR8BnpWQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNvCpXL0xKy0KJFeclZGDfJMVv4jRqz7951dvsDFqU8=;
 b=MyAC8kg4+zN98rO8sHcZ6OnmQUqUWEr0t7fU2SXhpAxPUrYvyTNzi4ttNiJmAa1uiwG+dBqPPt+0zlwDoYp5DCgsxJ7t4ksOZ/y8JWCqqSQ3qjW62RcND5sHpxCz8iEO1ajJ3zUgTrUeWmof4nDuHlJyPkbchAT/hgdNXGpxVLw=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by CH3PR18MB5571.namprd18.prod.outlook.com (2603:10b6:610:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:30:29 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:30:29 +0000
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
Subject: RE: [EXT] [PATCH net-next 2/3] octeontx2-af: Use u64_to_ether_addr()
 to convert ethernet address
Thread-Topic: [EXT] [PATCH net-next 2/3] octeontx2-af: Use u64_to_ether_addr()
 to convert ethernet address
Thread-Index: AQHZye3Yn10F8mOwek2To1i0HoZx4a/hT6xA
Date: Wed, 9 Aug 2023 03:30:29 +0000
Message-ID: 
 <DM6PR18MB2602EBCCC4F0EC2378C100B4CD12A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20230808114504.4036008-1-lizetao1@huawei.com>
 <20230808114504.4036008-3-lizetao1@huawei.com>
In-Reply-To: <20230808114504.4036008-3-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMTRkMzdkMGItMzY2NS0xMWVlLTk2NWItNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XDE0ZDM3ZDBkLTM2NjUtMTFlZS05NjViLTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iMjE0NSIgdD0iMTMzMzYwMjU0Mjc0Mjc2?=
 =?us-ascii?Q?NDk2IiBoPSJ3MWxWUFRUY3BNcUhiWktZRCtGSzlPamFLQnc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUNR?=
 =?us-ascii?Q?akN6WGNjclpBZHVrRkw1ekVITzgyNlFVdm5NUWM3d1pBQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 0df8c460-cc1d-4f2d-16ae-08db9888fb0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OlZeeeydILCQ0aCck4kqzTEnFEwpzSTDwNf0pEdBGweiKeJb5WrmQRmIVO5cdprKer1rs2r9er5zWtQU8P0OJO9mZXd09aObNM62B7XklyPe2UApuQRHo+ygorrZmwgCOM6GYVJ5ufJK0ng5h/T+OeBvb2jE40FHK20pInUU8KwYBpm/zvF2DKMzNXlQbBhCpblofK5DwTkGF0mmhP5uYYzGALtLEAhtJ1kpE3yM8thjYkbNH3FsAAEXhXwe+YOCs+kEC07s3oFBdjE7TSwstvSmGv0hlJwZFEd17PvMMPLV8kajuNemHHvH8yVhGldsjyzgdL0BJYAsqrkChGa8LrCOf3QNaYFRr2eL606I7q9Xlqd6Ex9aGZy70Nn8KAs1gnjH8iRfybg3YdNOTgynNzvDGNAnYSgqas59QH1lVDErD+I3iIQY52HEfoSvlYS1MUX8mNGnG9waeGSt5bP1yTZyU/rJebPkSJNX5UvuXQmHAdTRFvtoohTUyHSv0I3py++4k3Q2JW2l9/7hiB9DjZyknmAqDZyY9ti3hGcNgCwqcLhFRiRt2y4Tww+RJ33Z53qEnm2NGj6GXlpon+sMstLEeV0mHeN+7/WM39zaAME2g7B85nDzRIbFHyLFnaEGSRhqSpH+I+zNrFawrozBIg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(186006)(451199021)(1800799006)(52536014)(921005)(122000001)(478600001)(9686003)(86362001)(7696005)(26005)(66946007)(66476007)(6506007)(64756008)(76116006)(66556008)(53546011)(66446008)(4326008)(110136005)(38100700002)(316002)(71200400001)(41300700001)(2906002)(55016003)(83380400001)(38070700005)(33656002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fFlBAJqkrcOlNe86ur9+KBtRclUQkwG/LZTUdR/bpPGzHQ4RQv79/Tslry5S?=
 =?us-ascii?Q?Mos9HczI1TJeEPDHRzjVd+Vw4llAD0IjV4+HNe7Yf05qpPiR3W41hZJbLMTn?=
 =?us-ascii?Q?7wcjvJjY3Xz0TyDqFZ/Y1GVd/QQmoG5Jnj9HiCCwACnWjpMolVBXB0qBlfud?=
 =?us-ascii?Q?wxQ1ED/4OnmvkQuq/6RJHlm3mHF/Zzw9szgD6Ipz3L2Cu5eb2A+5WzFBhUfk?=
 =?us-ascii?Q?jogIXNQh6XWL3I1tVAJ0fYHx/p/KG+zbWsRDm208vgJS9n6wYI5S46bjFZlu?=
 =?us-ascii?Q?2VLC1BzX4HjRlFbqk3Bi+n+kyU263kpscN1RnrJHfkgfBoShZBNuCmhNdvUR?=
 =?us-ascii?Q?wYmgXIvJE/vts1ZozuDgqouLG2L/Hsss/DOwEvRgrzXdSD5oZsy9wa2Ye4ZL?=
 =?us-ascii?Q?DjC7nH6vEbfjiBmyRoyMFL2Ear+6ptLw/uz6P2p5veJKxIQy1l6FpOHRRjMp?=
 =?us-ascii?Q?21G+Z01+RkylYb3P0Ygg7TV7ikbEtyFSr3tAO7Kyg6oWy5qGMQfHLmiB1J9e?=
 =?us-ascii?Q?ylbbSuPn8gI5Tya28kqt6EXrFow2UFywWFzxyTYhqXjnnvpgwO1MhIkX+tOX?=
 =?us-ascii?Q?JZCUABW52Z+hTcHVMHE2kcAbuT5UvA+DzVBVNQFFxy9fTOshgMyp7lznxNWk?=
 =?us-ascii?Q?hEHZEEN2WTMLVoZtqY5DBxBnXq0l1r7l/RzE2fxbuOuOBPpeQ8R1LBvEPZXP?=
 =?us-ascii?Q?b1h32j104U8VPs0KBr0nk0yPHHjTd8yiQGI3q8K+kO0a//hxuxs8Hy18vNbn?=
 =?us-ascii?Q?y7nrttLp/pybODK96BA8JqXdboepaWfwwoaSDA33DsFvUwqI9KhLl/dq1My/?=
 =?us-ascii?Q?zkol7D8fRbbVpFysKdhdKH2ksuw7LDn73v8kz1c1awLQ1G0j2yzadhbpJonO?=
 =?us-ascii?Q?sMOQhdG4ySN0TYZV1BVN6ncAUTiHKg42TmuR4qrGHTvW2+J6+Cp+/2wctaKy?=
 =?us-ascii?Q?OciyMyAXdnIbhhuk9y0sY4nEDtlP4Z5MdgNBHnwicFIjuuk2KFzO439p8HU1?=
 =?us-ascii?Q?S1UK5N9AEFF8hJxjrYiSFXmhW692XgNGTGdkHOyNFsfipmd9yem0IOU9/ofR?=
 =?us-ascii?Q?b0mWg6mV8YB3J18uPl+15O+CmN0UFWM/7662VMPyTxBy77s37Rvk43BwDvmt?=
 =?us-ascii?Q?mZaKnR9RRtq94ZSWTlGVrMOTOhzFN9iFkxKwWxGOuPKxE3DVxYjXmPltenBo?=
 =?us-ascii?Q?VqBdllo6KLY7PhRLCwlfYeUBNJfgroOsY+j84ahQLdY0JNWRpeeNYOVzf9T5?=
 =?us-ascii?Q?EWfbL3iE6qP+WmCbDjGr1HT3qgoGK3Tdd5HjnpXvgX7Lcwws3usMeOtDvu7i?=
 =?us-ascii?Q?9EwEg67PqDlGVPdxbyB7FPQOieaumcsj4/h6AqBYYwnlAm8/C4A43Sx5KuEr?=
 =?us-ascii?Q?hTolXanlTmuiQQZ3vFtHLUzRbQ5rQk+wHTPB3Poarhdjo2OL4SBY3C8pPle4?=
 =?us-ascii?Q?4Pw1v+9yT/jNtVFpQVN4Hib2vc9wyveY9wHaS+/gJ77PMp5Vnb82C6pOrabz?=
 =?us-ascii?Q?4nkJemOFC2H340HR3ZSnkA0RJUtTcKbgqP7V76xo0p1iYG6v/5m0aeSNFaMN?=
 =?us-ascii?Q?netgNkjLQEXq5F6ZPG0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df8c460-cc1d-4f2d-16ae-08db9888fb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 03:30:29.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FepsMREfuEItrLOyChlIRabsW2lzc6DQosatrPNxeJpErfD9UsAhX+nHXnR1vDabdPQWSn626tsGnv/BqR+cuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5571
X-Proofpoint-GUID: zmx9yHqpsp-BJ9y_PP-1JYxgiRjDDBVm
X-Proofpoint-ORIG-GUID: zmx9yHqpsp-BJ9y_PP-1JYxgiRjDDBVm
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
> Subject: [EXT] [PATCH net-next 2/3] octeontx2-af: Use u64_to_ether_addr()
> to convert ethernet address
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Use u64_to_ether_addr() to convert a u64 value to an Ethernet MAC
> address, instead of directly calculating, as this is exactly what this fu=
nction
> does.
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 095b2cc4a699..b3f766b970ca 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -686,7 +686,7 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu
> *rvu,  {
>  	int pf =3D rvu_get_pf(req->hdr.pcifunc);
>  	u8 cgx_id, lmac_id;
> -	int rc =3D 0, i;
> +	int rc =3D 0;
>  	u64 cfg;
>=20
>  	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc)) @@ -697,8
> +697,7 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
>  	rsp->hdr.rc =3D rc;
>  	cfg =3D cgx_lmac_addr_get(cgx_id, lmac_id);
>  	/* copy 48 bit mac address to req->mac_addr */
> -	for (i =3D 0; i < ETH_ALEN; i++)
> -		rsp->mac_addr[i] =3D cfg >> (ETH_ALEN - 1 - i) * 8;
> +	u64_to_ether_addr(cfg, rsp->mac_addr);
>  	return 0;
>  }
>=20
> --
> 2.34.1
Ack.=20


