Return-Path: <netdev+bounces-25669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F64775167
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3506281A47
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3191632;
	Wed,  9 Aug 2023 03:28:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0327EE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:28:13 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E251BF4
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:28:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378NnLRv007556;
	Tue, 8 Aug 2023 20:27:26 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntk86d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V42x4Fegrn9/exvPEtB59RjledzKUpR0cQcG0hTNepQJpGbji5SLGpc5r114Z7hcwECFnv2ZOGgVuSjseHAUmplapQkiIgJLNy/YXQfCZstl5ckUUzsnw3P24fjShVT1QLzUkSROjc40kIEWK4/lmpFvtCc9sodafctwwF86QpBKFnKXnKSwV6aGDzSavjKDLR6mfgE1ChsO3yyrvcJ8yPa6jG4Jw3K237XpgjzgfMQxqill0z54d33OCdtm4Uq6h8gMDtpweCkx9IHS4sPHT6Tf9Cp0dTmYB/40HAYoFZ7Raa8n4nY+3XAu4IwBUlLMXJIn1pFtsisJi8o3Hh2jmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rmN1Ic2yRnM182anwfbg0ORkPPmnCedc7TUuH7UsRg=;
 b=UmJuX9AApJNX8it7/fKKduagxxtfpo4YANS3dwE+gtGf2VYJRmALZT3eNRjbGx+12cPVvhwQzXZwlnKaQWsSCj9xnZWnLn/9XDbyO7/g5odvjkbqG6qJRYiRtEJ1wKmKc7hkCCnFRkyDLdcXzw5piW1uYrj5dcWncifXLA2pHGXWIStVyJabmDI2pG3xKndm22aZMegEpSskHigoRrJ9q0xyvEoTuvBTxVU4IIeweHfAEPO8+fK8YFgKHrQqGDShAhIUH0gXxT66fQ1N8YtHGbx3coFDYRAXfuFDec8Ha8llpWwdLzA9wsPD3AZAgCwcU6gReB54hfdsNHFu7SpvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rmN1Ic2yRnM182anwfbg0ORkPPmnCedc7TUuH7UsRg=;
 b=OPgaNkRbMnTtD076sbg/hZntWWPH0lb/GxWvrD7ahm4gvJS5tVd6r9lZvsiyhxlLk0aJR/4KWuPAp9Y0cuXq+ZlPa2XfK1/XeT1uOL2aLVD2ITv6YSv/o7u4TYQcJkBoPUBiVRPJ++YM08rLFQ+M/HFkWuS8ofR/StYmYyEmzj8=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by CH3PR18MB5571.namprd18.prod.outlook.com (2603:10b6:610:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:27:22 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::1651:954:be30:1186%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:27:22 +0000
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
Subject: RE: [EXT] [PATCH net-next 1/3] octeontx2-af: Remove redundant
 functions mac2u64() and cfg2mac()
Thread-Topic: [EXT] [PATCH net-next 1/3] octeontx2-af: Remove redundant
 functions mac2u64() and cfg2mac()
Thread-Index: AQHZye3Y6MOLpsTvokS8Rub0irr7Qq/hTsUA
Date: Wed, 9 Aug 2023 03:27:22 +0000
Message-ID: 
 <DM6PR18MB260258A8526A64945E3ED4E4CD12A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20230808114504.4036008-1-lizetao1@huawei.com>
 <20230808114504.4036008-2-lizetao1@huawei.com>
In-Reply-To: <20230808114504.4036008-2-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYTRjYzY4YTktMzY2NC0xMWVlLTk2NWItNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XGE0Y2M2OGFiLTM2NjQtMTFlZS05NjViLTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iMzYzOCIgdD0iMTMzMzYwMjUyMzk0OTAx?=
 =?us-ascii?Q?Njc5IiBoPSJsSzZ1YUxybVdudThaUlNhUy9xUWp2V0QxOWs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUN2?=
 =?us-ascii?Q?a0NkbmNjclpBY0pwc0JnY0ZxUXV3bW13R0J3V3BDNFpBQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: d1f8745b-00c9-42a1-4f1a-08db98888b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wHlUtlvM/wztRFZJyj2BNH1uKZrx6XNTFfcl/DLTc2ybD6i6+A/TzVjiMY07VTo9+7HwPd/SdxkNXUwIwx8Bx1GmjT8btiaAzde57xToqWFFt+eoMeRe3BWfD/7pxc3raBY/RBpnJr2v1g5jqP3vYJoujhlezqLDuKSHGwVRvawN/+606zNp6QyknxI2ehuwOZB8riEDuBBlEe9e3opveh8eSFwuTfVc6StUaufYKdMYIPzfyCNmQG+ei3rH2omUFDDy2Qj2hGnSrZXN2ZJ/TclIEhScnd8dcp14vs5I+U5gmGAf9IbcuoKSXfBw4cqJJlJDG06qiJGnSJV1fstumnizbb3eCw7uWQoBFO34GQkj76q1s/p8Up4y0HLdi/grG1+9HjSsY2fXMP0RS0cfuPNEDrxsFno7Oq24dvfsR46T7RoDyIc+g+yXGv8FClSf2UVuXBswofBh+tXObcnEh4mAMYXOgRkfnhWGEFm37sCkGUBriYxPa6tufqNFFkk3k8rciPzYrcZwKbUEmXHL92EoHRMIzHYqNst0Zm/AQOInEz1P68ZW/zXYZ9T0OB4+qFSyfyEj8rdXRE27aeTXvMG/imDQQiNkZeoFzWKiBm1o9fAHAtLcxujaf3OY6eXakRmo57PU+6mMi2rLNdGVNQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(186006)(451199021)(1800799006)(52536014)(921005)(122000001)(478600001)(9686003)(86362001)(7696005)(26005)(66946007)(66476007)(6506007)(64756008)(76116006)(66556008)(53546011)(66446008)(4326008)(110136005)(38100700002)(316002)(71200400001)(41300700001)(2906002)(55016003)(83380400001)(38070700005)(33656002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?55m1fkrf7oaGjPwMycjVXeXYCRg8Xv9ExWgn5/vR/pztDjH4/v+M5UFF5IUN?=
 =?us-ascii?Q?burHZO3Swo6F2SfZP420EKSOLmQpsu3dSXYZOZG91eFdFG+JUzMcQsoxFOql?=
 =?us-ascii?Q?HYZNo8pxnDXK7VJbc8WTbX3bknpjEDy5CHwMhTedVlJ4Xzbu69FSfEtGWGpr?=
 =?us-ascii?Q?2naHRe6pgA0fQ+fYHDwKrZBysoYwyQQf0oP6gAZrDPwph89I37Q2FhA+7zRG?=
 =?us-ascii?Q?2jxvV8XRZM8X5C1TK29Dv41eQYvVKNM9VIp62nlogwqDF6+byAETgeBmx5xS?=
 =?us-ascii?Q?TuJMRyvNA8Ij4sECto0AYS6qtcnhKnlSgFtVboRHhanGYvkViebfHzj8TLBI?=
 =?us-ascii?Q?U0MmQpqw+19xji0ShO5VIMPPgM/Dv2XNzlDvP80cGu/nYP4kHQsIt1BPaNxz?=
 =?us-ascii?Q?00MuBMwKZbq6w6L7DV3ynvQwvmjCVvVFJ7T+dLv88cV8HOoBKDbb7Akw19GE?=
 =?us-ascii?Q?owbHsE8dVMOEkjqpAOE0617BTfToPKDv/9HR5pyQNzKO4mOpfunTAFPWkLpF?=
 =?us-ascii?Q?tSjKEMuOH61j6a7AL9/owCaViIBTOhgJ2+OSSD0iK8QXjKeRevAtASuaJXzY?=
 =?us-ascii?Q?KAf0rOLEmEW4yr4aUql4k+Ja6OjM5oPqp4PzSyZrxnbbEUvjMkKY/BSVjdZt?=
 =?us-ascii?Q?aayQtTYVVrdV6k2kuz5L+mOYJNi65yHKmvzVdu5BG191xW0vhLFGmQiHqhf6?=
 =?us-ascii?Q?fRXZbi3RiqMRnpopkqW4xnZAo+sGjN74KVLq0c2qBnw2VUTJ/cbcM/yAmkqF?=
 =?us-ascii?Q?gDX+aBQjQaC36EwPb6P6js2xgfrVnlXB/c8ERfPmQPvvMiVzUr/wAu7AU8yy?=
 =?us-ascii?Q?p7RJ9CUWll/M+9Zgy4In+ul+T3oLhKqxROJdtmJC8ysm6e9xe+kcaMsVy1o2?=
 =?us-ascii?Q?JikxxstvEI8oIbhfug7IQBSRcMrMFCVKd4pyQA/R5PhZe8SSD69WZdG/gmbI?=
 =?us-ascii?Q?dJGZ4joLug7C2YcMUPIZpwH1d1574yc/InTmaNlYoQeIULxwQQq6Z9pPHv8n?=
 =?us-ascii?Q?JI6ZXymIeQTFZQWmB0tRIM+Y5wWdbBlnKR5F6CF1r6vqg0yQd5rco3+4YKpP?=
 =?us-ascii?Q?0iAUepYO+cAme1Zl2kNkObcNFdGDdB4JUmzYDNee3sNX6Kh5IEzL5VUJTCwI?=
 =?us-ascii?Q?fkH6lAnOmswFMYD3Ya7tu2EZ0h9L4Md8fqR7XlFEuCV4aUmTZeBuHMRdC7+1?=
 =?us-ascii?Q?gzEkpQRzVesPAjptf7L1DLqaNeFwThskOXzLNe6Q3kJapPsbSUHzZ5/A9F3Z?=
 =?us-ascii?Q?/9YBT/mOS9MphYcEtQMaeJ/U4flGYX8fEv9k/UKPfeakyPDpNnT7fDATcWfU?=
 =?us-ascii?Q?jaxu7gIXEcrKE/261O7GXDNtqctnlGPuhNzumDAliCI9uw+1wbT8ZwTAvEQ3?=
 =?us-ascii?Q?/UumgVchnFSFVZml/fJKo2oWOvk9RNIoryKHupeOS2HRZv2I0wEjOkzuYFY9?=
 =?us-ascii?Q?+6iGP6PjGQfuLQmsGFb4izykYVdC8+EMsO0DllqnFzKgoIRToKssUzAQIwiY?=
 =?us-ascii?Q?UDWOn4lJ/S0E7l+noSTMZRb3b4jmyH2SLHL8H+TInSq2z2oVvOzL0tkr1PfK?=
 =?us-ascii?Q?yuKKlJDmoP6N46jdx/c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f8745b-00c9-42a1-4f1a-08db98888b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 03:27:22.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31LSbln/SWi5+OLS4c7PhPav3HcdeXv+rK61xIWU9HVXtLydCNCrW4lMO9l6OMoIb3ucvam6BqxpmHbT0fh6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5571
X-Proofpoint-GUID: nNOHhTcSU8QqTLErEuFvfr9mdkKzCk_v
X-Proofpoint-ORIG-GUID: nNOHhTcSU8QqTLErEuFvfr9mdkKzCk_v
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
> Subject: [EXT] [PATCH net-next 1/3] octeontx2-af: Remove redundant
> functions mac2u64() and cfg2mac()
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> The mac2u64() is used to convert an Ethernet MAC address into a u64 value=
,
> as this is exactly what ether_addr_to_u64() does. Similarly, the cfg2mac(=
) is
> also the case. Use ether_addr_to_u64() and u64_to_ether_addr() instead of
> these two.
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/cgx.c   | 26 +++----------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 592037f4e55b..988383e20bb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -223,24 +223,6 @@ int cgx_get_link_info(void *cgxd, int lmac_id,
>  	return 0;
>  }
>=20
> -static u64 mac2u64 (u8 *mac_addr)
> -{
> -	u64 mac =3D 0;
> -	int index;
> -
> -	for (index =3D ETH_ALEN - 1; index >=3D 0; index--)
> -		mac |=3D ((u64)*mac_addr++) << (8 * index);
> -	return mac;
> -}
> -
> -static void cfg2mac(u64 cfg, u8 *mac_addr) -{
> -	int i, index =3D 0;
> -
> -	for (i =3D ETH_ALEN - 1; i >=3D 0; i--, index++)
> -		mac_addr[i] =3D (cfg >> (8 * index)) & 0xFF;
> -}
> -
>  int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)  {
>  	struct cgx *cgx_dev =3D cgx_get_pdata(cgx_id); @@ -255,7 +237,7 @@
> int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
>  	/* copy 6bytes from macaddr */
>  	/* memcpy(&cfg, mac_addr, 6); */
>=20
> -	cfg =3D mac2u64 (mac_addr);
> +	cfg =3D ether_addr_to_u64(mac_addr);
>=20
>  	id =3D get_sequence_id_of_lmac(cgx_dev, lmac_id);
>=20
> @@ -322,7 +304,7 @@ int cgx_lmac_addr_add(u8 cgx_id, u8 lmac_id, u8
> *mac_addr)
>=20
>  	index =3D id * lmac->mac_to_index_bmap.max + idx;
>=20
> -	cfg =3D mac2u64 (mac_addr);
> +	cfg =3D ether_addr_to_u64(mac_addr);
>  	cfg |=3D CGX_DMAC_CAM_ADDR_ENABLE;
>  	cfg |=3D ((u64)lmac_id << 49);
>  	cgx_write(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index *
> 0x8)), cfg); @@ -405,7 +387,7 @@ int cgx_lmac_addr_update(u8 cgx_id, u8
> lmac_id, u8 *mac_addr, u8 index)
>=20
>  	cfg =3D cgx_read(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index *
> 0x8)));
>  	cfg &=3D ~CGX_RX_DMAC_ADR_MASK;
> -	cfg |=3D mac2u64 (mac_addr);
> +	cfg |=3D ether_addr_to_u64(mac_addr);
>=20
>  	cgx_write(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index *
> 0x8)), cfg);
>  	return 0;
> @@ -441,7 +423,7 @@ int cgx_lmac_addr_del(u8 cgx_id, u8 lmac_id, u8
> index)
>  	/* Read MAC address to check whether it is ucast or mcast */
>  	cfg =3D cgx_read(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index *
> 0x8)));
>=20
> -	cfg2mac(cfg, mac);
> +	u64_to_ether_addr(cfg, mac);
>  	if (is_multicast_ether_addr(mac))
>  		lmac->mcast_filters_count--;
>=20
> --
> 2.34.1
Ack. Thanks for the patch.


