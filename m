Return-Path: <netdev+bounces-13268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA173B0E1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F84E1C20EC1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20397E0;
	Fri, 23 Jun 2023 06:48:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE2631
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:48:45 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8276FE52
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 23:48:43 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MJu3Uk025526;
	Thu, 22 Jun 2023 23:48:24 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rcur5hy23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 23:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp22hgPd41vbKLb6Fahs4gLQcdeXWTLamEhal8X86HWJnq8JBJ8f8eUU8hi06GwOcE3owcGjaUBP7X1Hjygg7K+R1gbDGcndwGfZM2sWiWjzAg/I6e0Kv+ZdCJgkARJOOvdFi+8NaewFiYV8/9nQ3UXJjfYyEQY2+iRDtS0xVbSHyIPunmwiLQuBwjC2c6zbwfETwSW/JanQdYqtVyy1Tq28a2TUnddgC6GHXyPpvHSNlBeLP7C2X08Lf4sTKcR01yBsMS4WzUp0tZtWOaR3QiS0qJXHB4NHUwtGE91HXMMMkIQ2kw1uooiJEJ39ayIItkjBo8Al6GqJKWqIUxSdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X45i4wsgKysYbjZ9qkpxKlzhlRID9IcDO9Kw5Pz7WR8=;
 b=nHoSjKDMoGDilhhYiJ0d8cKhwoGnUU8T86NQISsuoWQc9tKndl/xsA8KCNdxx/MfHAr3m0/RoW3+jrlWhTU+kqO+X8cgHDPXY5JGMbjh6mrpRj3q8BBeH1SJ+NBL5BHG3vxBI74+Zb4BwHt87Ags3eFOxZAQn9UqJm9b7DbPAlGtjhsTZbalvA6wOVERVzt2kqUVdsDwRd4Fy8BmF5JmoR1Nda8VcwQILvGpA7pbInLwTjMOLhRHBLXJ4TbAjqsuVxm3gXMjxtmrc7IbMrvl2l6ZjnmVxVzTsED9GbA2etebc1oPddVdiOaLjf88oNJucIMhxTbDZ3/McUP0T4LmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X45i4wsgKysYbjZ9qkpxKlzhlRID9IcDO9Kw5Pz7WR8=;
 b=Ut+nKzHWOgXkbnNBrkatgAT7giqUGCLu5PHc/DALd8DeJQqSL8i9gpPA7X68KpOPYp6+wwfmmOQTTfvtEBL+zKvsoUYfTeTvX96Bg7dUYOrynrgOL18uGqj3+uP7bRc6VumxNdWjtm8VHtbJr+46EqjvyilNoXZIV+Kqcng4490=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by SN4PR18MB4856.namprd18.prod.outlook.com (2603:10b6:806:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 23 Jun
 2023 06:48:22 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 06:48:21 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXT] Re: Setting security path with IPsec packet offload mode
Thread-Topic: [EXT] Re: Setting security path with IPsec packet offload mode
Thread-Index: Admk1UA41QynfqgHToW8V0QW9ig8vwADy5sAAC384TA=
Date: Fri, 23 Jun 2023 06:48:21 +0000
Message-ID: 
 <DM5PR1801MB1883FCE87F49E7A2651B2A70E323A@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: 
 <DM5PR1801MB18831A63ED0689236ED2506FE322A@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <20230622083500.GA234767@unreal>
In-Reply-To: <20230622083500.GA234767@unreal>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctZWYxM2IwOWItMTE5MS0xMWVlLWFlODItNDgy?=
 =?us-ascii?Q?YWUzNzQwYjc2XGFtZS10ZXN0XGVmMTNiMDljLTExOTEtMTFlZS1hZTgyLTQ4?=
 =?us-ascii?Q?MmFlMzc0MGI3NmJvZHkudHh0IiBzej0iMzI3OSIgdD0iMTMzMzE5NzY0OTg1?=
 =?us-ascii?Q?ODE4ODQyIiBoPSJ2TTUzM0tkd1JGYjB6d0hIUmpBdEdTOEV6NVk9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBB?=
 =?us-ascii?Q?QURhcm9TeG5xWFpBUUkwM0hZTi9Pc0ZBalRjZGczODZ3VVpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJn?=
 =?us-ascii?Q?QjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFI?=
 =?us-ascii?Q?VUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFB?=
 =?us-ascii?Q?eUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNn?=
 =?us-ascii?Q?QmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFH?=
 =?us-ascii?Q?MEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dC?=
 =?us-ascii?Q?ZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4?=
 =?us-ascii?Q?QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBB?=
 =?us-ascii?Q?WlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6?=
 =?us-ascii?Q?QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0Fa?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FC?=
 =?us-ascii?Q?ZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lB?=
 =?us-ascii?Q?YVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJr?=
 =?us-ascii?Q?QUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUNRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFR?=
 =?us-ascii?Q?QmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFI?=
 =?us-ascii?Q?TUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdC?=
 =?us-ascii?Q?bEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhR?=
 =?us-ascii?Q?QWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0Jr?=
 =?us-ascii?Q?QUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFi?=
 =?us-ascii?Q?Z0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?us-ascii?Q?WHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBB?=
 =?us-ascii?Q?R0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3?=
 =?us-ascii?Q?Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndB?=
 =?us-ascii?Q?SElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRB?=
 =?us-ascii?Q?QnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFI?=
 =?us-ascii?Q?VUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|SN4PR18MB4856:EE_
x-ms-office365-filtering-correlation-id: 09c177a7-58d6-4bee-85d5-08db73b5d5b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yQpW+dcYdGRegPV3nBh7ocRxfqOcwWvPiXOR8n6/FEctRELbPIHz3rlcd5dG1bQNkictecWdRRt6XX2I3bCsid1xk5axhubTTpxl/EgM4dDkBeXZ/uESQgydNYoiUixUU1GrqVji+4ZU6Bkm6ofcXVQsL/RPePhKPNDO2O9NLtyCL5BX3NlpEXKKMiGjRHvqZ96LzMiZuUijb1Sw5SeQ60N4hNucpo2gVMDVELRy8CY2nmalzZ4+cxxnQnMuzhIP4hRBYXubx/3bu+TETRVpKIzSZcQWtTKtjwap3JyqLyJcaLFVa0qDYOY6Ct4Y1gqxQMzWDqWrRgBLO6qI0KdbAWHhZKTD5pBXciOy/1IN58Nzn1zEgHYJxp4WJpn3aK64SNIcmx2R+9td0tHv8iQL4+59zYpNdzEjQn3dXqUnI/fMlSJDN/HbZuxRqAgmCOtPzXf4YSLNwu51vll31FuFYHqHascynxOeDIA2Sm5dCGVbv0b+qg+GgyVo0jtZTcsiFfAUILz+EH5ucDIeArb0hMMktZcWhqMTLwSdkHYp26xkEiVU6J/7DEsmvOArzQA8WeX3oKE4iKuJz5dk4ApEA4VLupNYBqAVQAYWqky7ljMo94leweF1ZtpIqLANwquc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(186003)(7696005)(4326008)(478600001)(86362001)(76116006)(38070700005)(83380400001)(66446008)(66946007)(316002)(66556008)(41300700001)(6916009)(64756008)(6506007)(52536014)(66476007)(8676002)(5660300002)(71200400001)(54906003)(8936002)(55236004)(26005)(53546011)(9686003)(55016003)(2906002)(33656002)(122000001)(38100700002)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iuk3GdNZb1QoqBqN3cie3/abupvlsN1J+U+Uy2fJcbYWaMtxe2htq50Es/Rn?=
 =?us-ascii?Q?U60XO6cGQupgtuNe8lEnPosFMWniwJ9Cs+KHeUqACwZ0Tb3oGtEWLwSwlhXd?=
 =?us-ascii?Q?8m49rvRpptG6lGkCXui9ALhzRtXZ/0xi57gaj+CV+r0huyccxxA+cQhj6rR7?=
 =?us-ascii?Q?ChFwKv/SAm0t65VGXVtFhrC971JDiRWgtSliz/Y4Yfgcjz22snzPGKSfwzR8?=
 =?us-ascii?Q?zFNidpyOXEpoI7cAdPhZouylIvbdBXVMnzgh2uKilP7Fq4FD7cfT3iq/kzRR?=
 =?us-ascii?Q?TYNGr4Ovu5F6UGHuh4iFiUqzssfPtPYnBjTGkLsNn8Nhq7toBb6I+TqWZbG1?=
 =?us-ascii?Q?xb72P6Upu0KS3Eupugtoq9AhYCH+Tugd7YQoRNRWfOSUlrchU2v5KXPKswIt?=
 =?us-ascii?Q?SmTj3dllzP55zQ5iH11VkWzfxmJDitE5SHy6FSMcWinSn4xciadg3IsrvBPw?=
 =?us-ascii?Q?C/SPhWmp6J/8gsniDFWdL3jYF21TuV4I6m8BRssoW5Dh4neZayFFePMu4UQA?=
 =?us-ascii?Q?JBG9CyeRcUH/860swWMRz5SJ9jDRQn/6Ki1hSD8PATyc8Gy5BP60t7FMv/R2?=
 =?us-ascii?Q?NzpgWdknGYL+KQTEdipbGIyArq93xLFfOA1lUwexV8/sXIM3yBpIjfakgRjX?=
 =?us-ascii?Q?R6Np6FA+WxxcSVn9IxjtWEaaJjsei6PjQw7g2XwnyVo0twoWVDCHwPuqlsaE?=
 =?us-ascii?Q?s4ol+hnoFODNJTpzbHq7ePanQfkJu+exlBihydfaONvL4ff+uaaOBnjpx0/z?=
 =?us-ascii?Q?u4qKieRbAhB8pM1wZzdaxaKoHa3SGy4BHC/VbgOppy/fktPm7NeZzBx7ziHP?=
 =?us-ascii?Q?5mjpCTU5bkZA5qeO8jttCIHqgX+rSAIft9fcEer2gcIuqmbrxGUzt9c5WA3l?=
 =?us-ascii?Q?Kofpj/ss21h7oO25m0hWDvYnU957q6OQWmiGKoab7q59npkN3HAB5v8Mt1XI?=
 =?us-ascii?Q?zZGxRZx4Xt0jj/CD5r6U8pFt7Cl/V/kaKY4Hup+4m54R6qvwn+1YA51MWLrX?=
 =?us-ascii?Q?ktvXfPoHd4OAQ0Wav+wkTtIWNAPyTukETc4tbekgHw3ruCsF5kD6IDvpC6uF?=
 =?us-ascii?Q?EGhDNCtXUzqPgnN7y8VF9sm9sAG7sWWuz212G+6ncwiSUy21YrlTFB/5m1zz?=
 =?us-ascii?Q?6g7PwfLDv0J3X4yiKPja8yWHnT+jX9QwOI2COPwR3y4B5CNmjKltV6XsF0p6?=
 =?us-ascii?Q?XkEEB9AxxPABP1pru2sed522WxX0fSh5vohltWMH/Dvitpybl+K8sxzlrja0?=
 =?us-ascii?Q?9Lc+NolJZugydgoVH2p7yCJQWVFQZIgkGmb1W0Bwch5jWPc4LkrkwT4zIGWD?=
 =?us-ascii?Q?OzxHg4/cdZhgGBIKcczh0hIHW8dOl1S7Brz36oezawVOIM2sq9NadKhMvxTS?=
 =?us-ascii?Q?eHXRxKt0MCuYuBADRFhimPmMY4c/noe4vR+sWfTuERDcwGo7Lrw5ovsLW6dc?=
 =?us-ascii?Q?zDa34/N9CPhYP8g7KCKGiPScy8cRUuBoAdBYVBg4hBif29nlaYAu24sjS81D?=
 =?us-ascii?Q?1D4ahKhIvQr+cgnwuI6eMU9GHLnmhBi/CwYA6yV7MC0KJywA1cQ+uVcu4xN4?=
 =?us-ascii?Q?ZQsuqMse7ENtzW8rpvUTG8wXa34giQf7QUuMDUz4?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c177a7-58d6-4bee-85d5-08db73b5d5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 06:48:21.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pl7qeaSTdNxYM8hLAAKx31L09IaDfuuZGrw66XwquCk9vEBAenNwraUCaL8g43SZ8SJCQke12N19XmPJ+BwjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4856
X-Proofpoint-ORIG-GUID: 5ZXAiANUnyOpeM9ZnfexmqNiKjACrFIk
X-Proofpoint-GUID: 5ZXAiANUnyOpeM9ZnfexmqNiKjACrFIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Leon,

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, June 22, 2023 2:05 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>;
> herbert@gondor.apana.org.au; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org
> Subject: [EXT] Re: Setting security path with IPsec packet offload mode
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Jun 22, 2023 at 06:58:06AM +0000, Bharat Bhushan wrote:
> > Hi All,
> >
> > Have a query related to security patch (secpath_set()) with packet offl=
oad
> mode on egress side. Working to enable ipsec packet offload while Crypto
> offload is working.
> > For packet offload xfrm_offload(*skb) returns false in driver. While lo=
oking in
> xfrm framework, cannot find where security patch (secpath_set()) is set w=
ith
> packet offload mode on egress side.
>=20
> The idea of packet offload is to take plain text packets and perform all =
needed
> magic in HW without need from driver and stack to make anything.

So driver does not know whether it normal packet and will be transmitted no=
rmally or this will undergo inline ipsec in hardware.

In our case packet transmit requires a different code flow in driver, to pa=
ss some extra details in transmit descriptor like state and policy pointers=
. So is there some way driver can find same and extra state and policy deta=
ils from skb?=20

Thanks
-Bharat

>=20
> We don't set secpath in TX path as such packets exit from XFRM as "plain"=
 ones
> toward HW.
> It is different in RX, we set there, as XFRM core still needs to perform =
some code
> on the arrived packets, before forwarding them to stack.
>=20
> Thanks
>=20
> >
> > For sure I might be missing something here and looking for help to unde=
rstand
> same. Meantime just tried below hack:
> >
> > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c index
> > ff114d68cc43..8499c0e74a5a 100644
> > --- a/net/xfrm/xfrm_output.c
> > +++ b/net/xfrm/xfrm_output.c
> > @@ -718,12 +718,24 @@ int xfrm_output(struct sock *sk, struct sk_buff *=
skb)
> >         }
> >
> >         if (x->xso.type =3D=3D XFRM_DEV_OFFLOAD_PACKET) {
> > +               struct sec_path *sp;
> >                 if (!xfrm_dev_offload_ok(skb, x)) {
> >                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> >                         kfree_skb(skb);
> >                         return -EHOSTUNREACH;
> >                 }
> >
> > +               sp =3D secpath_set(skb);
> > +               if (!sp) {
> > +                       XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > +                       kfree_skb(skb);
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               sp->olen++;
> > +               sp->xvec[sp->len++] =3D x;
> > +               xfrm_state_hold(x);
> > +
> >                 return xfrm_output_resume(sk, skb, 0);
> >         }
> >
> >
> > Thanks in advance,
> > -Bharat
> >

