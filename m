Return-Path: <netdev+bounces-20916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE4761E45
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7110C28128F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4224170;
	Tue, 25 Jul 2023 16:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9123BFA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:18:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::713])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C362897
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAZ+pmuEoAAMz3Eciej4w9TCB3Z6FgFH2Xc0iFmg3+vR8//zckTqg7woCL7AdzRqj9ex45sYhDjvRQhilzSdFUzyu9zLTp7UvaaIZvx0OyvtKWGx1v9Q+qFIvhJDfRtPkh7o+ADTcde4LSqaP47+UrRhdEgj02HqQSxsAh0wBjhVAqwxnlKB8gcxAebMJoe3br4wdg1RQbvLr1aw/RvIC7TirjkN5J+wIdcFIYmkXw4RD/WPyh7u3/JAabAiCb6YvWb+m4WboOhyKafXSNzlT8SARFyUhMQyXWpO1uzG/ZQymI9GgsUI5tBj6crZh9bimCLHDLUTsdW/x3MQi/20qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMwc0QpFWwq5Jvg7p1Uaa2/vEkA6uS2NQVn1On0wIMM=;
 b=dyjPv5IOAm2+daELXNX2ihPaFuy4prU0aTha7BeVV/uy6DT58ndIIwpGmdB6HIZI/dEa7WGu7fFGnGsIzIThczHDS3ahhVA59aiIPSUmUyEq0En0qdqKtqT7SLat0c1HozPSFyoFHjH3JDAHOOOnhdewcAfjbxK352p4VhoJSErNY8nvdnpBxNJxFxYTxNZXWEbJvtOq+nrBgkFUStI0wTy9ZA1jeJN5uBuhtaaNlYloDxqzForhoJHVM5RzcC67rgzJ3KbYJDvH9TrjctJuP45T3Fxxm6jzjwaC1vUK3+FeuRcTKgWmIHrmY5CSLjqfqU2z2NaO1qmmSLi26Fhzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMwc0QpFWwq5Jvg7p1Uaa2/vEkA6uS2NQVn1On0wIMM=;
 b=mNc5yB9jtyjIrlN2HTbG/Wt2GLnsko2qNWMQeCteHKZe9xCG38A2TpsfPm1VCDH0XKvRR0agBX6YEfnBrLkcuzwFsKIIBf1DaKPGtRtB65a3AW8pCKr7eM1H4IsiiTahSYe3poKvystQ/JNtcksvwIwnFk9fVHnMqJWelX/c3k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB4437.namprd13.prod.outlook.com (2603:10b6:a03:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 16:18:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 16:18:45 +0000
Date: Tue, 25 Jul 2023 18:18:38 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH net-next v2] net: skbuff: remove unused
 HAVE_HW_TIME_STAMP feature define
Message-ID: <ZL/13tcYiiy4j6CW@corigine.com>
References: <20230724162255.14087-1-ps.report@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724162255.14087-1-ps.report@gmx.net>
X-ClientProxiedBy: AS4P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c31005-8a94-4144-f610-08db8d2ad1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zQlrSSYDqcfNi81JyexlsDfMUQUQSH0u6+lhj8X+ZQCHC1o3Diz+qHxS2Dh2Rji2yUFajZ+uFYxpjuB4hbUDL86IZyouzxFF7IIS0KmEJ9rmwa5+DV8+0sEce2x0xIGEkcOajGfowUIwpy8QV9bTD8i8XD4jh3uknVUUi/d7S1ulSTYkdrmKz1mx/dteSWf4ZbaVjIrxE/TeT8G56OLLV84yV5kJaqQy5NXI1lMs/P4sCgNxkZ+keHTN3otv56cG9svBdGxD5FxofsXYgHD4K2BarhxbGG1e4DtWbGFOMZA1l+sjmseu8SbjxDgONxZwLfyPUaiKW7ihtMZeVDUiAiSjeo5qCCeZ0dC+DzDiiClS2azx8n+VsKpu6UIqRWM6E6LMtXZ9ITMDrHAI0xDCflomP2tQE9eqAnD7niwpRCOAZXw5PwX9eB/FIz4QfxmeB4f6VcIRxavnktVSKcKUvpk72GEHYiSWgPbEhikGaiivhoCg5so3uGIPMk8NMo1zGRDF9lMxiE4v6zs9XdQyecsS3bMOh/vgsdvZGTJFVSEr/QkUotAF3B3OnLTEMk573hBt3axxqiJUvG9b78HAZPYotaQCGrCNwiH6lMi+QDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39830400003)(346002)(136003)(451199021)(36756003)(2906002)(2616005)(4744005)(41300700001)(5660300002)(6506007)(44832011)(186003)(8936002)(8676002)(7416002)(6666004)(66476007)(66946007)(66556008)(86362001)(54906003)(6486002)(478600001)(38100700002)(6512007)(316002)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FU0h1uuKUY48RtFyzOhjc6tr3UuYi9QnTlh1QYBpUZajd5Mt6RLLWlply5z4?=
 =?us-ascii?Q?9PyfoYVMYqo3MgSWl+UDc/7hnWrSTtXuaE8x926KSJi4Ou9yn/HQ7Gp+vL43?=
 =?us-ascii?Q?ZIVoDMvZsN9jCE0ZaK2txRWIH+ItZP4u359PxICNK7dV/fb5zTf9tL4U2hru?=
 =?us-ascii?Q?PMxXsX8RuZ4t0MGqlJNbe8Q7V9L/IRJUKld+ltJZOiLVpNN9ubQEsIjYV1Io?=
 =?us-ascii?Q?okn4ZsYMRzz5IjyKrW+/JAlpTfHmdG7ptSQ+hvh6742ZuIv+JvklP+SumRn+?=
 =?us-ascii?Q?vDTfOctwwaDdb5qEkX+m0mQlLSY1ptnFp5udHWfZzt1QZ4OGENZiw1EH4YZj?=
 =?us-ascii?Q?6mW3anrzgUgbNVQAVGwUq8cpv1QaSrX1eUqulxm8GVpF84rxYT7XwxHbVan2?=
 =?us-ascii?Q?Wdlhh+1S1p3orRPo3NqOkjaavr2r9rFW94feiQFsB2Oc7GFT2VThckmT1lRj?=
 =?us-ascii?Q?9Q0nLx499y9YHzSoCs3ZQUGl+fU3/sU0gIbLNvBJgIFqOuhqLbsRfKQUqqYw?=
 =?us-ascii?Q?FHATuVkAfeweG0D4VKMLX0L7k3yjKb5Kf8/w0TCY6PEuzyE9wWN7RacYNiyf?=
 =?us-ascii?Q?nr1l/kot7qOAKkPijl+gVIw5c3B2mhdd8wkpB/DnzGyQi7UxQcTThlEiCFOz?=
 =?us-ascii?Q?p9LNv4Ntm82HNZGxtou4vURTBWtSX8C9yRYreM4DtpV7fkjVVfzlzcRV3vBS?=
 =?us-ascii?Q?+Z53rQUxFqV+KhXTcMLQdVbD7MbnWlkvfTsiUxTzOJOmSJxRs0JMVqB2tDSE?=
 =?us-ascii?Q?y860pS0JdzcUTortz3bpkNF7dKoGzPDb+vHEDk/sw/0wM8a4FK9AIreBdvkn?=
 =?us-ascii?Q?4TeC5vQ8oYx0uNM0jNwbcZaxe9eZ48Oa5I7C80F2y8oJx0mG98CIjvb9myLo?=
 =?us-ascii?Q?5oilhqlByaMWC5LnCyuDGWBPjkL3+A3ceyhvQkK8iAYqFcm5LtqHl6Egkmnc?=
 =?us-ascii?Q?we5Cf4zLzBgw/JfqPiGaFRXJZQneRZ//woPAZ6Xcspf5yBp9b1s3j/T8w+4g?=
 =?us-ascii?Q?PDR82lRv0OEyQTxtiKGsUHq+tOBpvYUv/V2uqlnA3ityRY2dnfST3gRtroaH?=
 =?us-ascii?Q?WRtuV+jfqpynX+VVVj3w8ss4B4A4fYxwUwIx4GD8XExMWKoMG1/i4BbbSTXe?=
 =?us-ascii?Q?ZsiKmK8L7weHcudhE8FlY4TABvmC2bzAT2nAAtNKXCCYgEQriq2QLkxDHb7P?=
 =?us-ascii?Q?QNYF9vQeMgEYkszDBw+So7Y36fDyswuZo4sRHNcVYND/zpDJc+oj8WAB6imE?=
 =?us-ascii?Q?fhY4PtI5PxLsDSfD2e+QFi1BixYCwPixuyZokiyhnhAEmj18ds6gGK0rw0Cn?=
 =?us-ascii?Q?jRsoDxM3GOG0e5R7s6RuE3Bh80Fv4IXMJbeiNkqPujrcfazSv4VaBmDWESy3?=
 =?us-ascii?Q?Q5rLgJ2W9352vGkHgG4rFTTLq74ZR+GaadCEmZLqmDk0T30EI76YzFkxB8jn?=
 =?us-ascii?Q?sH9q2uqag+l58e390zdzSi6m6q66jaAsfj1EUDrQuDMYtbQiXBTwPzTK5CM6?=
 =?us-ascii?Q?DNn718RnXSXIrWdF05NaD3GiGbJtIYb9UmnfKdvodks6Lq3DN7W/Ly7xYyQc?=
 =?us-ascii?Q?X6B+cbiDxMVQuYdCl+8F1RDUYVkn6eOy5hddstABfa2EpkSO9Hi8+x+uWZpo?=
 =?us-ascii?Q?UYPhGUdmqauf416d4+JFsw9uuCZT/Fks1MczLJbr1AcJROu39nwSrwanQ+sx?=
 =?us-ascii?Q?MWG+Jw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c31005-8a94-4144-f610-08db8d2ad1b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:18:45.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK9Jl7D4hYiZXmjPv6ZRb/o/ebKLgWGNOUIH1/5ZM5yHmOH2yuW5gcR4noBrFTyqsn0Ro0sN3k6X1nN6U84uqmQRwCyULtVy7uL/kVsMXLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4437
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:22:55PM +0200, Peter Seiderer wrote:
> Remove unused HAVE_HW_TIME_STAMP feature define (introduced by
> commit ac45f602ee3d ("net: infrastructure for hardware time stamping").
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


