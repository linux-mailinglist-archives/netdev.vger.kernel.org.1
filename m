Return-Path: <netdev+bounces-13297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DAA73B224
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0BE281929
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF11C01;
	Fri, 23 Jun 2023 07:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955ED17FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:54:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2097.outbound.protection.outlook.com [40.107.96.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A6AC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMBZ7VEaOzBAc3f0LxRQrxsw+lUVqPWrb5xTMfZOD6Z/vNskdCdFFCW17MJvHGzz5sJvnmK3Rl8ujlayP+sn7s5buNIJ18vKRmZGrUHkIDTF72UlXBIomWBZZRWKWWxY+BngM7HSpYlc4tnDLvepookfCVjhMvtnmPX9ELpIrZ+/SUT1RXYI0N1Nen+NOEj4lwYy8IWGuvTIqgR0ZEpBjJ1JyV/p9H9/3umJtqFDHaNBkYWqvo2U+Znh6vqIb8SdCa1dxdieFFMA/+CPyQYAteqEQD0KI7Ii6/ey+jve0PKygv7QDzx0GnYzcRhaY+v6Dx1Y932sJ0mlKj6doXV1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRQTLpJqRrCpPbvIrepA2JqkD645I77VkDJt9L5nPxE=;
 b=jTzWmQTGmOTl6Dn/U+fVOfes5aDsiT5+zsOJfyzuFHUoXRbpovzs2EIavgc8Z59ItQ0EMURTGq9Bjr36MBOHWxzRCGYMnpgCzLW1EUSQUOOhFqqZLMbP01FjhQpTov5yIYQDg2N1r28fbK9TguScmtsvCjpd58KfuMmdFdtwMNbb6+0DLb8CcnlHnCXvGVUWh98F9EZEsWozpI+9M+R4gohv+EBajpOcEgaGvH0ngrXjnVqefxNhzPl6mXKqqIzHV6GQzlYILCdiRm8WYHk9ijx5vQiCIJu1viiYfRaRl4H/t7YnWf9iEdsGPhn1oGUjqZQs6YBS2tYWchGSNlFB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRQTLpJqRrCpPbvIrepA2JqkD645I77VkDJt9L5nPxE=;
 b=i9Sr02T6OXd/vCKcUMDmR+eTOH2X8s4zHTKGW4ibaAYvrX1Egudc5qsTyQiw/xC3IQviNh86EAoHQ9nJp7q41P7MHfoVjdeBKmS+79lPBaNoMbAGpAnXAUAO3wgoLbjHBZDJa+/cKef9SIwlDhqDUIToHhVim/g/FlmG2CVkK8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5788.namprd13.prod.outlook.com (2603:10b6:a03:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 23 Jun
 2023 07:54:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:54:49 +0000
Date: Fri, 23 Jun 2023 09:54:42 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net] sch_netem: fix issues in netem_change() vs
 get_dist_table()
Message-ID: <ZJVPwoC09KWQeJpu@corigine.com>
References: <20230622181503.2327695-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622181503.2327695-1-edumazet@google.com>
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: d44f50a0-d59d-4188-5677-08db73bf1e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YpcAeYZqG/4o44MfBld9BZw/12zzDbl+HvP0Mni0YV8USwhRgrIy6VgJ8t6OEkijy5NMD/gid/gJY4CqI5VeNeGZQBgoKdTCowSFMf5CyAEjTEpxtlHwBRnqIaWp6dM4JxnoP6ZDIVUWbBwp0tPdA7XAK0MK2iCj41kJrVTFq5WEMJskCwoEpmhCm33VBrqNYiXc7wopXV0ZbtQcSalkvd/sgCvawq7Y6AJlgZVmu9cSZjtdlqKCMcPmegUB6eVg+nZn/tx6+HB655TlO08Ax6V2ILTVanXa889g8WODh3mGH9OGtfLCHoZo4YIQzDfQrmmuIZSCjvVqJThDybEh8licqZ7vyFzeLktSQYRdP7eedw1Js1eJbdWyzxUEutYXs4S39kDDqqPezL52pVkfhUZhnKJFfEfoYZDbH2t/kMDBRuqzPhHQ3x+LOUWIk+VNmz5AFnHmN7Y1RBHDNRDJw8EVFoiIiXXdYaZ4StpojjchgSUMDC/ZJd6cwQGEYWHisjAxc/C/hO6kbcHKA3ooOvk9HUuU5nbQloCxWAC0nhXA6bb9E+buo2TGiSfET/AUTTRL48riEjNIw+afu5w4eDZWrBRRS9FPRppLuYy1oU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(346002)(136003)(376002)(451199021)(38100700002)(83380400001)(186003)(478600001)(6506007)(6512007)(2616005)(8936002)(6666004)(86362001)(44832011)(6916009)(6486002)(36756003)(5660300002)(316002)(66556008)(4326008)(2906002)(66476007)(41300700001)(8676002)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQt07brsGe8VD7gzqeIA941NIXZY7egKDRM+y4bGaX4n3PgOSAMRrjqBtF7D?=
 =?us-ascii?Q?QPgJfjsM/Hyy8EB7gEV6lFEZQlw1KQkbw9i4SdzwtCj1tqrlkX1FAR/BVCtT?=
 =?us-ascii?Q?gbjjRBDp3EjcB14V6vaN/OGFHnMjVM2htGndLz2RoktEJDpRChWm79tyMb9m?=
 =?us-ascii?Q?SG03+wEfPzz2/OxNCQHIzHwW6DGbwXctMR9La5fRsZ66MrLh7VJk2e6ekdY4?=
 =?us-ascii?Q?oUrWlEPdHkaHjrJZWBBxHDanm8xNCxjFBhZ8Uwsf7vtQMvDjghvfl+a5XPmI?=
 =?us-ascii?Q?ijaRRK5I6qofbdwjp1F5pT3eP+0UHLqju6Pf0bidx6oDiWsEXViepph+1P74?=
 =?us-ascii?Q?xDugeRrAUBeeiAfd0QHl9z3WE1e/BmHRlVR5EvfAa8AJg1AHHqCag5x/fVtC?=
 =?us-ascii?Q?IKu9jNHgUdyKMnl8Py6NqHbKmADD64DRabva06N32E472WvAmMcp+MnKF+ii?=
 =?us-ascii?Q?ntrU+lWTnbcGImbN/MRfqetJAJLwBJgGskGl/QJsJyFWiY246PGVQB5rYq4/?=
 =?us-ascii?Q?o5izuL83asUNvV5OQsSTKrWD3kSzHmHqw+4j0QWYLfoq7mgsf8LK5idJSrfM?=
 =?us-ascii?Q?evNGp/FgB0zCtizWW6swlBox3uK2f/hJp5KEbzgSuT+cba4YEuTcukp3TNDl?=
 =?us-ascii?Q?pF1RXWMugnAb7K6In5dCdE/dxKw8pb/XLGKNehyfmKzaX9qtHnca2n4Ag4c9?=
 =?us-ascii?Q?XQe5PepiWr4+7yv5x+Mdns59zHe3WpwKQP8JuqhYlKVs57GmGXFMzi6N2xF2?=
 =?us-ascii?Q?x3d6xqPYTj2keiNQFLIm6VHxxI+pwYTh8V1uJ3FIklam8NJJSWjta4I2ExDi?=
 =?us-ascii?Q?lop6eEENlrg58IZnE+lsOl9yEhMygeN3E9B1RCsL9/E0JsRW6GzdUMgkBWGd?=
 =?us-ascii?Q?GJi2l91efKRbPSR0EKZs1LoCi/SoPlmHobs/TUSs2Uup2TzHaWGS1vKSH59c?=
 =?us-ascii?Q?7QYmNC54ZXr+k1/UTaY5AXxwgQBX8rbRKOQeiGMlCPf6UuYoeajr5/2eFPfj?=
 =?us-ascii?Q?zGpzKq0S2Ipt9T2VotszF2zDhXQRoY/58kEe5dXpKA6F58wsTBZmMM/fju7m?=
 =?us-ascii?Q?uAsUdwwEew4Ylwktt2qNEHvfUhJOJ+7Hon5owKqPuc/NWDjOPOnKqe0RPhjm?=
 =?us-ascii?Q?bpKxwtkcS3D56orr8Xn58qr9Q0zTFi4rm6YD7i4DqCJoLSvH1Iihvu0hvYox?=
 =?us-ascii?Q?gMuQd+lDHQBARTb1GX5GCDSyoAcilRlFx5CLL/XVAdRSpamy9AZ+t4Id4TwH?=
 =?us-ascii?Q?MOfcAA9d5Y8qT9R96w3WNDllPW7r3FGlOg3Q1R3nmsYt0OucoB/7u3sk/AMG?=
 =?us-ascii?Q?8QZ09ywD3yRGaM7X0X9/Udd9qiGbR3rDbAbDFU2B2Q+RC6lrnzWoMgc+3FUH?=
 =?us-ascii?Q?VG0L0nqF7T7QDSqcOc3BvM+52Kwm8fH16DaS1fOuz1yK2WdzpdTI+T7HX9cU?=
 =?us-ascii?Q?BOf9TWCXvGwME5QNGYGpAPM7oSMB7JNuwuZIg5J1qPSBAclwZK/0sVJo3SsU?=
 =?us-ascii?Q?dpiyABJRYLmc93vTLA9K1sEkLKOmWANP+YhYmH7usNQy5iSSSJ0HuQLrD4l1?=
 =?us-ascii?Q?NIJHIEFXSwjKqoFU+NokQeSe1TP0q7gIL3did8rTNteU+83Kolq0mADeFus1?=
 =?us-ascii?Q?WMHerC/NwUvUlcwJCz+dfsXphNq6KQ9hePn+VNE54jGRPN0UzLv9jQzlKDa3?=
 =?us-ascii?Q?vjMEYw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44f50a0-d59d-4188-5677-08db73bf1e7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:54:49.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUu3HQtW+GrK4024mIGjC6oVNQOtUjbP6xK5ryGdMXn/EX6O3EnpYETKz6pNyC6qSBIghlQbwH4YuRfELvw+Bxn8MXjW5VXe/ibKx5aUAgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5788
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 06:15:03PM +0000, Eric Dumazet wrote:
> In blamed commit, I missed that get_dist_table() was allocating
> memory using GFP_KERNEL, and acquiring qdisc lock to perform
> the swap of newly allocated table with current one.
> 
> In this patch, get_dist_table() is allocating memory and
> copy user data before we acquire the qdisc lock.
> 
> Then we perform swap operations while being protected by the lock.
> 
> Note that after this patch netem_change() no longer can do partial changes.
> If an error is returned, qdisc conf is left unchanged.
> 
> Fixes: 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Simon Horman <simon.horman@corigine.com>
> ---
>  net/sched/sch_netem.c | 59 ++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>


