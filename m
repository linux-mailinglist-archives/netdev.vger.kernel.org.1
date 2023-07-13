Return-Path: <netdev+bounces-17481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08891751C49
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50C81C212BD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC0DDCD;
	Thu, 13 Jul 2023 08:53:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B6DDC4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:53:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27D1B6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvJaVfMUAAdz19sFYEakpNK/VKj2Y7oKt2RHqq5h1KjWufmC8pG43CRqBnB84GCeTZmjMJheuHGWBJ8MjsgYqqjZpgbe05/sTWYLnbo+9sO/1u3MXCohP5KyI8bEBRYPYJ0N0/pUSz8L5W5GouC7c4B3lFKqMI1dJsSxRzMynikdK2/MSbHR1wclXxPAKXSWBsFO6CqbAFODVxVg1UP8AVAJOFsAocd5VeG86Sp4uhpc3/GHzQM6Mu4FoZRfnA79CBsHUQYu1lbxohrM82w/vAk49X0NDk2exj09kgCdNv5WGFU/Qw7omsItmifOrSGy7CY7ETVI+IAbZ2vNfmtHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b46kwjHzYPcufuVwk9VFAKkMmMN5+9iSs57/AuU0aeI=;
 b=f5FvNCnkD9G5Td9BvWpwRymXGKO7NWmRJ4ZqNPwCyme11oBdVOxuYx6rOE8CCbej4np5cGuALoPUcjYXOuw7ylJ8iw0PWvGzhL8CK8cu8ih95TzZJ0E8cjErmCZ65TSvvECh3LEwXQh66NO6uoDFXBBVIeN2MTgLqdo3z98QgXGXQiX3Xzoq3nI6tx4JIEzS1hUflfnuqUse7mThMgu4LfPrsw9VVSw31laQgnZtFKAtr9PvMohOJN5zuIkTCE/hfw1X6OT+lLj5WNP5BaLsbma3kmTCRyHHtABoDAX8hGa1m6SAU/sCVsCXl/Ia6eQnrdEeg1twKolk27iWuD5aRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b46kwjHzYPcufuVwk9VFAKkMmMN5+9iSs57/AuU0aeI=;
 b=TVhErhelXIxvw+TTZQN0T+vPNoCtPt+S/Z7Yc3cVTtr4Vidfza9ASt2eLGQBqMSqFtP4p66qfCIj0JgNz1xoMGQAlP7hytelY3ptTUuBRRayiTtwXfPxVWD10UQJZ++SDajDGQPDCPgj9e1XiLFCoqKD+N+kCfaj+/ZGlaHmxxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB4889.namprd13.prod.outlook.com (2603:10b6:510:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:53:30 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:53:30 +0000
Date: Thu, 13 Jul 2023 09:53:24 +0100
From: Simon Horman <simon.horman@corigine.com>
To: David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ipv6: rpl: Remove redundant skb_dst_drop().
Message-ID: <ZK+7hJM/PhCaS72X@corigine.com>
References: <20230710213511.5364-1-kuniyu@amazon.com>
 <ZK6Q5bp7cYhfl6iN@corigine.com>
 <2fda9e96-cefc-fcee-063c-cdf652a64992@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fda9e96-cefc-fcee-063c-cdf652a64992@kernel.org>
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6682f489-448e-409a-31ca-08db837ea194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pPUGz1/SHx1cAj85ocZBCw2/4LTVw3TaHpfN0z7PFr5XqYREnpTADUYTW9w/kzmaMQMGXu/qBOkWjtjYDs+uJUZA4bCwqLxJaNtkz/5Ni1qBuUOTaZMAJrD4zOYZontCjncV1zN5JvEV/Zbc8xJ0D/v+IE4YqJGWs/+T4/qOCjcKg01b+2u7b7Uea328quV5xgRvn0Gepll2fNl07uGa7SpTaiC+epi4zPd8YX4epUWP/F7FDIlQUv61X6Gm27MFkSuNyfm5PobFQD6JixnIwSh3mEoDA6DR5eHPCQWUrl4BTKW8xaFgrZDLlW5ebZPmS5SzBb268Q8tBs8XMqBSkIKnjqjcFS4E61IUHPwkw1KYQNVgQiFlPWKokYe8E+vtxnnNXWtrAFDCayeKc6OQBte/ik0nFZjOc/Uzwl51WN4Yzry7xYbefwB3MB2GnYZdC5xwY4sJv1iESZSdA2TfCC9PlVSB9VT7sWBNmceE7gjAMEPU6I41Z2S/ZmQhL/STcCnB0uwoJt/Tm4pX5Z/+czVYD/XOSISRofNfcLOqc2kSoVTO+cYNdUk5MP3pLGKzYXo2dP5p4fa3824fohP11EzvO4bRuDg2bpcLgSKq8uM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39840400004)(346002)(376002)(451199021)(6512007)(6916009)(4326008)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(26005)(6506007)(2616005)(53546011)(83380400001)(36756003)(478600001)(54906003)(4744005)(41300700001)(8676002)(8936002)(44832011)(6486002)(6666004)(2906002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GNrc1LNRkF2CQ/pwmPbbjBQ25Y5wuGiHVtF1Rsser5wWK4gGfZq4ZrMg7a0u?=
 =?us-ascii?Q?EEydlsPox1PvNLYmguCaWH8f3opbIMw/gh+yaZ1KYKn5zK1qc9zmpZdq7B+f?=
 =?us-ascii?Q?x6HZVqgbv8nF1S7PTcSTDoMah+thu1EHk2HcSX+F0HbqqZWhUOuK1czw3pOh?=
 =?us-ascii?Q?3CSzE+88J8Mc3oWyZde8O89lAcACy/V4UK0xSNhZRh0xE79PNx7NRkK3qnMr?=
 =?us-ascii?Q?kTOmzsopamjyhpvn7zXYSNX19/rJdd9//aVTYo1MWk2+d40bwRE1vTgkxYlx?=
 =?us-ascii?Q?jKb6erSLMCFipsC56LeCj3vi5bNuD8235MwPHzmuCelxLLdRGq8+thjwcXyP?=
 =?us-ascii?Q?gb5OVCRJuWsz02rz52w87FUfOr0VoWN3I7jZZ5/XIhzT1ecUacyIgDy43B4M?=
 =?us-ascii?Q?lG/zQCHQ76rRBeIzTvi8lbCrKCeycmIL1sgvuIBZAzenK/Hky2fOpLjsvQiU?=
 =?us-ascii?Q?pbO0B6j2Pk9ms70FqgNFsqvyR07l31vnIYV1tTZRfgD4vcKuimP40JhiYirB?=
 =?us-ascii?Q?o7+nhCUrctYD1lVhIIL7ZQayk3AnEFq/JuyoXvzfdQyCOQXEQ+mJ6NLfUJTx?=
 =?us-ascii?Q?lqNJj7VOFtwtPEHfZIkOPqTMwYrT5P21kDyTLqJygNwv+hOkybETeVcR5EJa?=
 =?us-ascii?Q?abA6gGQYOz20z0VR+SW2prKYVefMc4aWSSNxziY+Q9LCciAlLigaVveM0oVx?=
 =?us-ascii?Q?ukVopWYOf2zeMjofDn+zhqGJVcZHZm74y3+iGnLjcGSobpXMvST1/R8QShxk?=
 =?us-ascii?Q?IvZIeC09IYBs1rUCJ3jl4HMtwx+zk2toyVOT2Q8g3MFOetnoDOzj7U52Socv?=
 =?us-ascii?Q?05uRIiMNPLFIMU67SUDoe/DTV5G1409RIS2qUnUI5O1hS3ILPZ8Ubc4mAYY/?=
 =?us-ascii?Q?MbvZppSznwU5VYWipcc++Y8fMGp2eS3W8DoIZ0p3l+HCy3QUqONo4ezH28oj?=
 =?us-ascii?Q?HGx9Od1QpYbYx5LS+yxxSNzdvJE3hqwcP9wD7ufXl3/qAJgGVlt9WswkxPAr?=
 =?us-ascii?Q?GrwPzBx8zjZcoIwzG3rRLW+g6hvXTt2/2QBhnzxSBR1V2hbMHMfaU8E6vHTK?=
 =?us-ascii?Q?bvhXOGtvF/PoOkJTc2DuyIHGdeLA81Gs9SHteETzOxxYBjlkQYYfjH99h6tF?=
 =?us-ascii?Q?MA1qFEVrt3YbyykcPXgyloPWYYKsHfWTQ4P0NgeQdGooWs1bIq9/PEL+PKnv?=
 =?us-ascii?Q?RDILrBaQ0aOA+U+vG0yjpZhraNXeOHvKFpX6Q7dK8Y8SEoRxS0uI1ctX9+Wa?=
 =?us-ascii?Q?vlc580gpeWxBcUZ+4irwzXLGwX6gopdhbJHhYDB1Vn/YHgsqKiCP3viScaPk?=
 =?us-ascii?Q?+2pmLIOHm26TGy7aalmU4sy47A2e0Vn7W9ZiYK1Ke7sSnAXl6PJm+ir2jC6Z?=
 =?us-ascii?Q?w4wZ8EiqDu8HJb3sdtJnS7+RE/l2JB3taoXYXcbfC/vAAMEyvj6wPjPAaUoZ?=
 =?us-ascii?Q?V1nYLyCSVb9hFQynBdWRL6R7HfP+QZdFqyM77/KRUNqkUCsmugTmodNcE5M5?=
 =?us-ascii?Q?8VS5eqi6VnJ9MOYfQkOVU3QikCdcd/dLVxGlH5L6soE5UEVzJLQ3DTMyTiQF?=
 =?us-ascii?Q?0G3Wz8kHnhlP341WDUjS275RZsxPbYh21XX3yddHY4BJSTRgSC76RPrjbWRi?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6682f489-448e-409a-31ca-08db837ea194
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:53:30.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7SCE1Hq9IIL3uyssoG3tl8Xniv+XXloZBL0ivSPtY1kHeFNEaqsbUVz5WcCphL55j5OHmAp7A9jDtF13pSicVHtYF7zDoGatlNBSxjM/fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 08:42:27AM -0600, David Ahern wrote:
> On 7/12/23 5:39 AM, Simon Horman wrote:
> > On Mon, Jul 10, 2023 at 02:35:11PM -0700, Kuniyuki Iwashima wrote:
> >> RPL code has a pattern where skb_dst_drop() is called before
> >> ip6_route_input().
> >>
> >> However, ip6_route_input() calls skb_dst_drop() internally,
> >> so we need not call skb_dst_drop() before ip6_route_input().
> >>
> >> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > 
> 
> I have been ignoring net-next patches since net-next status still shows
> as closed.

Yes, sorry that I may have been a bit hasty there.

