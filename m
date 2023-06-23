Return-Path: <netdev+bounces-13270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68673B0FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85A22818CF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B86A31;
	Fri, 23 Jun 2023 07:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F887E0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:01:25 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7A210E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:01:23 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N3nJ16012603;
	Fri, 23 Jun 2023 00:01:09 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rcuqv9pqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jun 2023 00:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM0P9SAEHSP0uQChxLlKZ8zX+vJ8KJJFEptU57Gm99H/JOO2OXZZld3S9lbM1dzbJp/aAQVfPvLXnftV9PXvunH2oGk2DiI74FiNnKIx8kjmuZIDgX0gRyVxFBjI02DH/rDVj3z/1CJtAGUfW2RdWuvTSc2xK0AhFWWE5ZE+Exv+cwevhtJg4kxY4tsotTKyiXxT6MvN58ENZ4R/qhjQwhQ8miiwcO9XR4vF5WiUvt0P5/ZwQhxk7jkRk0X+gw2nT2cJ9mUvFfaSHk7dK2eeR4PgEKmcGKwSL1a9pQGdE0V+j2icQkiBVrvoUg1lu9qSYH9DYeMsgJB0N4g57cAbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0ep182Wux6f9AgxjERSIHhRYwqpYGoO15gIZDxZlvw=;
 b=FctfBv3arCRFQFEkNDrVcv44XK3vyXVWL57b0LW4HnHVi8e/dQ6B02nLs/s+th+N4/CJM2pUYBtyB448sYFCRIfwQra3f/Edi9rR843HKPuM1hy0JSZ5kNEfBSC2KET/IT7fQC7i4cBA6OWtqXdTluYAsO7FCMEnhWHlKonaE+f8zjL18AL8f657OSOV4LiniiUZrtaa8ugw3dkFABvTwWYI+1eCYqvhyJWF1JVNIJyZXVYuTmB9W1oFGoJYWrxsiuIC4FRWpWDRXcouBHNrHO6NdmPNhEnYm2K8T9Bm4PIXHUkeJ9d/m5uYGU8Ue/ZKrUJhEwL/9PTbSXmRgsItIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0ep182Wux6f9AgxjERSIHhRYwqpYGoO15gIZDxZlvw=;
 b=RaA/GGImb3vsbPSrDAozFCnEV04yA6jV0SyqqOD+/tNr+6IXZ4XfBG1wWqZFc86cxJNGLSQS/fG8EA2EvHaL/RQFWdgzTmCudyb42EwxzTCaZgnKGollHdtRGskJqp6v9NchLxOlsARBE02TW/Mx1DegM0XdE9EoMGSDY9ecYMM=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by DM4PR18MB4349.namprd18.prod.outlook.com (2603:10b6:5:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:01:06 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:01:06 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>, Leon Romanovsky <leon@kernel.org>
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
Thread-Index: Admk1UA41QynfqgHToW8V0QW9ig8vwADy5sAAC384TAAAPb7AA==
Date: Fri, 23 Jun 2023 07:01:06 +0000
Message-ID: 
 <DM5PR1801MB1883AE64318EE97C7549471BE323A@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: 
 <DM5PR1801MB18831A63ED0689236ED2506FE322A@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <20230622083500.GA234767@unreal>
 <DM5PR1801MB1883FCE87F49E7A2651B2A70E323A@DM5PR1801MB1883.namprd18.prod.outlook.com>
In-Reply-To: 
 <DM5PR1801MB1883FCE87F49E7A2651B2A70E323A@DM5PR1801MB1883.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctYjU4ZjcxN2YtMTE5My0xMWVlLWFlODItNDgy?=
 =?us-ascii?Q?YWUzNzQwYjc2XGFtZS10ZXN0XGI1OGY3MTgxLTExOTMtMTFlZS1hZTgyLTQ4?=
 =?us-ascii?Q?MmFlMzc0MGI3NmJvZHkudHh0IiBzej0iNDA3MyIgdD0iMTMzMzE5NzcyNjA5?=
 =?us-ascii?Q?NjI2MDk1IiBoPSIvdHV6Y3BHbVROS2ZKMkFhUHp4SEhhNTNEMVU9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBB?=
 =?us-ascii?Q?QUR2dis1M29LWFpBUUgyUUMxZEhyNFhBZlpBTFYwZXZoY1pBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUVnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
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
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|DM4PR18MB4349:EE_
x-ms-office365-filtering-correlation-id: fa4e659a-5c9f-497e-1f4d-08db73b79d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QG5+jBfD3v532Cv59bhZnT/AJ85Cg3MRU9s4I3fi0KK9bWqYhubt0mSfr66S8egAZjRqREBx0m2GA+NZJlRBrnFGmKAIGXmzqLFYHxP6r/4GtkXeYCwhdWASPMKHjB5ysKNwG2zpZ1aZU/XEIezK9iWw19CoM1h28lNKO/vQpIl8/t/c6tuII1D+Z24jHvAgspMHolcuoud/+t2tVTDeDi023D92P8uIWF6SOJqkf8zKEB022wEmgxH3DKefL2m9aAGq6cBk99hftJKWBEYyRe4Inbhu70fwP+d3NHJN5clnZ5MUVop0PdxCRBE10rwc4IiiN7d7iXGBwL0IA+8T0VFD9GEx7GDXd95Ay+r0QUBxNMGIftLDD50zS/CnFietHIdOUVH5vsRtwBTsh9qEJBYX4RKXkMEuZWZEGGE+Nc+iJf+DnBl/GsI6E4DAdv5r+dUYdF3NVOVwUqwj8uHWMHSwKcxzrDGDjv6ndEGS9UFBT1vmuct5VwFOtxE7arPWRNx9e4Ogktazq6er101y70JBHzYoA1FPp0rD0VTdxQrLBhufwEJw3SpJCBExMEP0n+oSXAgITmRMAW7z/du+xAVnQ6ffuK+XZMODy8KixLy6JcFZewwJ5CMM3OZafY5d
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(122000001)(38100700002)(55016003)(86362001)(38070700005)(33656002)(186003)(26005)(6506007)(7696005)(9686003)(71200400001)(53546011)(55236004)(2940100002)(52536014)(5660300002)(15650500001)(4326008)(316002)(41300700001)(8936002)(8676002)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(2906002)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?w/FRWoIQonfwkZALSc8vLu6UX/0D+f7Rl403ifSRJ9PoGZvT8W+ecE7qKFP8?=
 =?us-ascii?Q?+KbZ/eLnGkPDi5K7zH2DFR4CI5W2LSLk2y/71oEOIJNeSAPwNllSkQ/prrHh?=
 =?us-ascii?Q?q8pCb0Z+RGBKvuel5xUwpedMmWOSvr2ECETCGU5Heyf05FyQfzKu5tBDF0d3?=
 =?us-ascii?Q?mn65ZKNFjys+K0CJQtW1DuNSFdyQxbac+HkpSNHMl6zxKHI0fOUrhvbD4h81?=
 =?us-ascii?Q?OCc79maytADsG71mqRzbERrWkIilhakNAeFqY6z41Wl0O/Bd+E+yP24Km64H?=
 =?us-ascii?Q?kAwa1eUI13Wm6DK3OC7sfVja+1FGkiJJpk8HS1McIHFJZ6nd0eRvFBDiDhOq?=
 =?us-ascii?Q?ai8sCWHliprMNlVoN3BhPYEJwGYHwxLEHGsTPfyIiWo4x85pv63DMv5KbYc9?=
 =?us-ascii?Q?wk8OcOgufZvCzjInLdxqQDWv+Ub2P+ooGsPzwWdFSttglub3Cv6BNzEcC3jd?=
 =?us-ascii?Q?PsFq/G2HIdFDd4R3DuDD9eKRNmQDI3/aLl1A4d7zqavLJdatzFJNk2ys5Ffq?=
 =?us-ascii?Q?IYcFNsvp3ZRTdHF0fSy19U0hNpvBqf1A3m7V42z/JoSxAy120KU0tzk4KgI4?=
 =?us-ascii?Q?ndppw/WJgZUf5wZ+Sefr3F6rMc+8cODbHLRMPzNJ8xH83lxqXOlr/8uKnRz8?=
 =?us-ascii?Q?MI+Ng1BHpL5XYDpe1txnD6D3ALzcMc0DO2jhrIJf5b8n/eoVq+/KHJyzdeQB?=
 =?us-ascii?Q?6eGDmgwH0liYK/1ztqsbD9Fehqs5Kd/WXqJ8DNYl4XIcRmKBawHn1F0hIPUJ?=
 =?us-ascii?Q?OapPiYCov9Ul8Fu8YjOGSrmIH3+GdPGB/tnHZNLr+xwTf8IAcI9OQk73UGYK?=
 =?us-ascii?Q?jTiMO5r0Sc6nXVV3tIjC802/pG7t30cMVqGuoFbgCZsKW2km0bU0Izj9d75p?=
 =?us-ascii?Q?r7hYvC8mqPqg0NwdcUZ/orvbQVsbT/Zqz3+kQ8H251tehAho38LknKEm2NYr?=
 =?us-ascii?Q?AyzTgc5N06WOyOZI2da2QgddrUpQrzwc/PLX8hb1cg1wyNicdbzQEvO8PniV?=
 =?us-ascii?Q?noz4HdQxENxFaFgWJH33GE7JK6X7SuAZtgVK31i0YdLVumk0KTRYRS9B8dyl?=
 =?us-ascii?Q?QosbdpnQ2eXOpfxh4UNl2Ve202g0QL70He/mM+dMqgGJ9ANH+HxuoY1FcmCp?=
 =?us-ascii?Q?WUj+gFXzEbI2aPz3H69u6pa4GNXC4l0koaaRTZOPGFts6UET4PiK1+kA0+b8?=
 =?us-ascii?Q?IdyUbOtiFyf1ZWvWr1IZH8ECjyzW/nzHLArKiTiBpuIPHyy1SN8kV5PU8if4?=
 =?us-ascii?Q?O/n1wmvRhFiwpnA88PDw3M+c9DCmO3ozztwVmdB7HOwEKABJDZz/s+fuL0q2?=
 =?us-ascii?Q?tmMR1zYt+gzfYlcwbhSMoTn3uKEwWp1k0SZadQRlQP8qVwJ6I3cmkcXy12A3?=
 =?us-ascii?Q?4D4FnUrQ4tkQaIUswegZluIk5rOb4yg8xK1lSo0b3EmI9nWqpgmA8ykYAuuH?=
 =?us-ascii?Q?ZJD+/h/OyHW5siVE2pMc8MG3mKTY3l5CIWt+3OIwzkvu05p9aQOCYxHwvLsf?=
 =?us-ascii?Q?aSxL8aNH/uvobJCkctIFM85kOfDm5Butppts5ZScIoYWHqV1ztQFI3UN4250?=
 =?us-ascii?Q?brHivgl+szePwi3M9HKUfVeBAXdctoVrLzUKWilN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e659a-5c9f-497e-1f4d-08db73b79d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 07:01:06.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPQ9MagQ97CGzLspLXltZmZuYGrYFLBF3Pxnq/JcUOPvtANYoJAk6PdUqs3ipAbP0wkZNE+MSlooXquJDytRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4349
X-Proofpoint-ORIG-GUID: vmpgcGYPyuOAqikf07QE8amLSyeb8xER
X-Proofpoint-GUID: vmpgcGYPyuOAqikf07QE8amLSyeb8xER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Friday, June 23, 2023 12:18 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>;
> herbert@gondor.apana.org.au; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org
> Subject: RE: [EXT] Re: Setting security path with IPsec packet offload mo=
de
>=20
> Hi Leon,
>=20
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, June 22, 2023 2:05 PM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>;
> > herbert@gondor.apana.org.au; David S. Miller <davem@davemloft.net>;
> > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org
> > Subject: [EXT] Re: Setting security path with IPsec packet offload
> > mode
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > On Thu, Jun 22, 2023 at 06:58:06AM +0000, Bharat Bhushan wrote:
> > > Hi All,
> > >
> > > Have a query related to security patch (secpath_set()) with packet
> > > offload
> > mode on egress side. Working to enable ipsec packet offload while
> > Crypto offload is working.
> > > For packet offload xfrm_offload(*skb) returns false in driver. While
> > > looking in
> > xfrm framework, cannot find where security patch (secpath_set()) is
> > set with packet offload mode on egress side.
> >
> > The idea of packet offload is to take plain text packets and perform
> > all needed magic in HW without need from driver and stack to make anyth=
ing.
>=20
> So driver does not know whether it normal packet and will be transmitted
> normally or this will undergo inline ipsec in hardware.
>=20
> In our case packet transmit requires a different code flow in driver, to =
pass some
> extra details in transmit descriptor like state and policy pointers. So i=
s there some
> way driver can find same and extra state and policy details from skb?

s/extra/extract
I mean extract xfrm state and policy details from skb?

Thanks
-Bharat

>=20
> Thanks
> -Bharat
>=20
> >
> > We don't set secpath in TX path as such packets exit from XFRM as
> > "plain" ones toward HW.
> > It is different in RX, we set there, as XFRM core still needs to
> > perform some code on the arrived packets, before forwarding them to sta=
ck.
> >
> > Thanks
> >
> > >
> > > For sure I might be missing something here and looking for help to
> > > understand
> > same. Meantime just tried below hack:
> > >
> > > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c index
> > > ff114d68cc43..8499c0e74a5a 100644
> > > --- a/net/xfrm/xfrm_output.c
> > > +++ b/net/xfrm/xfrm_output.c
> > > @@ -718,12 +718,24 @@ int xfrm_output(struct sock *sk, struct sk_buff
> *skb)
> > >         }
> > >
> > >         if (x->xso.type =3D=3D XFRM_DEV_OFFLOAD_PACKET) {
> > > +               struct sec_path *sp;
> > >                 if (!xfrm_dev_offload_ok(skb, x)) {
> > >                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > >                         kfree_skb(skb);
> > >                         return -EHOSTUNREACH;
> > >                 }
> > >
> > > +               sp =3D secpath_set(skb);
> > > +               if (!sp) {
> > > +                       XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > > +                       kfree_skb(skb);
> > > +                       return -ENOMEM;
> > > +               }
> > > +
> > > +               sp->olen++;
> > > +               sp->xvec[sp->len++] =3D x;
> > > +               xfrm_state_hold(x);
> > > +
> > >                 return xfrm_output_resume(sk, skb, 0);
> > >         }
> > >
> > >
> > > Thanks in advance,
> > > -Bharat
> > >


