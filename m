Return-Path: <netdev+bounces-60414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F317E81F1C4
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0D1C219F4
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38A47F48;
	Wed, 27 Dec 2023 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kO31uYDQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D147F46
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVebIkU0wBrgHI7ORVu/fgp9TxXOuUXwykdW7iOMylhFZtAZqsdsYGcfn17Ir3R4X291bZxXMJmzS8zPde7f+UCvGDAEP8Pg5dRlRFPd4lmqR7W0xeP+as/sJtZpDqv6YOrzy6EjzjqgUAFdVyhkrFdapclbUiEI/PJ4hkWuHAArv3bo5aJ5LVs7Ic2XZYO17I6kF4FJWU0bukZ5Ur3HaLpq3NJG136MzMgJnpKyh5IJm228oTbNylxdUgZxEYkxbgERV7yfbeTR7wfsG/knAHv5I8xoaVU4CCoNfKkAeh6CZHzzv4gqUwBe8+zijxN1XPc4sCe1Y4zVHCVL2vnppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8MiWSmHpsutfPf0Z2plbxp5sBxApqLa6ngDk8CZvLM=;
 b=TivGAU2xKazQ+IUo2iRwiNl4DTxkkXxSN9bNXMZrB7XS5EHe+Epo73Z438NeOSZZAXFEgNO0Fb9VhNkpslYdfT0hGWLTucblCdo0M8GoYlDqrFK8ivdfGfZyAmS2ZyYbJ5tHL/x+vtLfYO0zqWItSuGzA21FskDAIAjbnyItajKv4j/c1zsnmsn4b9onfn4x7PyZaL65mvrHihm3mkhbX2iDmGnsaNIKJEaM+BHWRWOZQptLBb8q9GLR+wt0LT9Dst7XnShhl+YM+OcCCNyOg3Xz29CNgA5jkFARH5wfHUbxWBvAYpV9fSjZwjo2YspTr21OTvjLflPv16juhUnPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8MiWSmHpsutfPf0Z2plbxp5sBxApqLa6ngDk8CZvLM=;
 b=kO31uYDQCh9ejq4jZGzdTlgP92aBoxHN79MwIngce7aOQe4pN6aOA2n3t7tkYedd4O9hKqynaKyapE9q10d4lnhjDbeS7aoakjEYFy5NR9dyuHGHuxsvREzPwFNAKyxthRYD4V8WZi83iSycMbC0P19411mze0u9nS7aHO4VjpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 20:11:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 20:11:32 +0000
Date: Wed, 27 Dec 2023 22:11:29 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 10/10] selftests: dsa: Replace symlinks by
 wrapper script
Message-ID: <20231227201129.rvux4i5pklo5v5ie@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6c85a3-196d-4ff9-240d-08dc071804d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uPuxFCncVAqkLPu1VhOTbvZubuf/TOCPsEfnyGJMG6DCIT5KFqr3p/hgfHYumpnwOegDpB0D9vCcvCrkvHLbqv7E41G2403zSHYx9WONSWJhOsjW7MiA3HqyL6yrNXcKj+QHqrtoCfVXxFlPpCeO9vf42Dx6eIyv7YtsomoUABEh7PBBTR7MnJoCwWIf0iSEb0LQ5zWmTtTbE5tdfNFC5AMDkBKIFXOL7Q4rXmpo7ZZXA0yEXgbC8F7k2P382DVBJuwyi26nRuWDRsNGux71rHVQc+50p5oGbdCg70gfQeR2oJQnYDUb9Ody05CJHih+aK+FffuCSCIPthR03XQHmJ3v20/Vz0PxLuQV/2TqIpY4LIz0bNlVozsx5yUxqwVtRztkZyNNYXSzL7jMSmAtTeLcznKpmvwX4IHUXIV6UAtiYlHw/65E6kSbpRz1IiY0KQ/EuY0kEn13P7L1so4ZTzPEAQuzkWdfnQfDzSvNjK0Io8Ywb5Seiq1nKUvkFhCjDO7TEu8op0U42kEQCe4S8NhaRfvW3ERoPBV/ok+IGG+EU3FQrJo8sgu5hxUx6QnJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6666004)(6506007)(9686003)(6512007)(66556008)(86362001)(6916009)(66476007)(66946007)(41300700001)(54906003)(316002)(6486002)(38100700002)(8936002)(8676002)(33716001)(2906002)(4326008)(44832011)(1076003)(5660300002)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIhfa8IacwH1jN62RtPA9OafSFq+BFALxdy04Rf2Nq7qrpul6+gC5ERgMdsl?=
 =?us-ascii?Q?VnVLt4f9QfrfQSy6zK7OhHtfR1vm0naZ0oEs3nZFuIQcnWQeuBje6JR8T7CJ?=
 =?us-ascii?Q?9owuCH2piULz0FQLUVeXyN1jX65H6/MdKabAQEZKgKTa9I5PMIHW+0Ilif4H?=
 =?us-ascii?Q?W9XvfiemEX3GAATgVMJR2KDbx1mBkK6IqJeHJ8O8bkQVLWO8T8e3GPK2UFFa?=
 =?us-ascii?Q?eumsjjExikxRE9UCT/SJxCPgFT3HvqxLbLqfmT+flvLorqLC8No8mL6p9NQ9?=
 =?us-ascii?Q?dXkz6+IdLXyAl/8J5xRJDSl5dSkslCXVrxN198vRrbIZKBwDE+v+tKyHK2gw?=
 =?us-ascii?Q?i63E82ozimBpWXScLd+UnFcO8DUv9VNz/WdLZRYOhINS3gKTNuhpzaCkKLFR?=
 =?us-ascii?Q?N+jiul7Zh1m2xrEkjiGhcR8mgFlUccsnphCzuBYrzsMpZHfz+EfwCLVa12Kb?=
 =?us-ascii?Q?t9kyr9n/TuRoZ7swQl7MHKFdDwnaZZuMC2qNaiPCagNplwtKWco2IAl+nseZ?=
 =?us-ascii?Q?iyLrAPLiUw3quEv43c5qBLy54xYm6WNaEIsjXr+DhH9vm1zgzjCT63oXrIIa?=
 =?us-ascii?Q?/7Wj89/wtKoNJLgNcR9Clyc/IyIdKK1vQutQ8k01BwM+RB2JFXc2/1h2gD7s?=
 =?us-ascii?Q?Jbo9dn+e4gBXb7g+MTcEYRPH61btfCWJF5NwY+LoyEBIptKHd/UPHGheOcVN?=
 =?us-ascii?Q?tj9yonbc1S33TjaUraAeYg/45v1o6bnF7TiY9mbPl+Anoinz0L1hf1K72xqB?=
 =?us-ascii?Q?UqkNvk0X8uF03EBEDGsbXEYFSpqgvj0/amM4dU9zckBHdizZiwDQNNecuLi1?=
 =?us-ascii?Q?bN+28Z9hE5NspdvFNQ5ZWY3t3wzgU17vZaw+qP56NMQsCvcGAXdegDFmVAkb?=
 =?us-ascii?Q?s5VTWNWuyj/3kqWTrUNysh14BT8rL1Cpz60ByzXsSDqTHX7A8lYfrVN20Z1D?=
 =?us-ascii?Q?azXdLmN6ryC8D5QLYzS4dnRe2QJSvOTiotPkGgd/Me5oS0JHWD8ruA1CMXUi?=
 =?us-ascii?Q?KWmP3H/KfCcmNgIXFskbpXYIJ18TgRBLCYeZ5MLVXxZiksAimIllfk1VaI3/?=
 =?us-ascii?Q?yv+SW18ykS3H9C9BknfQCRuB2bZETnLioDmNHMHVU9Jmuy9aDAFtI7eEaaTV?=
 =?us-ascii?Q?ssvmC3cN1oWyxkcgtg96n7SjhIS4XF25Ey2biJOm9HRvL/Nmb2VYoFPiC5yf?=
 =?us-ascii?Q?s5h6AZoYU2MJZJz4y7uLA267Rn44VXcY9zjSSZQ7eikV/L0/07vFGpIbxZGy?=
 =?us-ascii?Q?RE70vagL5RHllpaFaLncnpX+MBTcIOjpLRRjb4ML78A7mUK0DtwToQzohcNY?=
 =?us-ascii?Q?tDZ98y0HO29vv8GwE6nitzmDSWS4FuXTL+tjuFvGCZCiEcTa39SAEuadbCNP?=
 =?us-ascii?Q?sPfx2XOiFSLLeo7f0AyQPwJeA3NEv6ULG2B00xnACyPqS+mjXkmpAnZB/BuP?=
 =?us-ascii?Q?t1W/xtdKf/tqURLSRB3s7Mu1eBK7v+6B8o4VgSJIzBR9otCiSHkkjhtuVY/m?=
 =?us-ascii?Q?Ps9UYMOwf74l9whh/Ua/M5XHPk4n64QWvm417Oy+Sp5FeqqLDXe1FwXqp0Dy?=
 =?us-ascii?Q?DcvSO4cWB2+MxHJUl6GErkyH0msXA+Wx9d1JHElV65iqo5zRjYhyr5kOCSDB?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6c85a3-196d-4ff9-240d-08dc071804d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 20:11:32.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT1XU0wYibdz2xQcthoduWD+S/x3SJRvYJin4DefOzwlTvvgeGaoAPDpz+DayPKa1z/pJU+p2zjboi2icjiOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493

On Fri, Dec 22, 2023 at 08:58:36AM -0500, Benjamin Poirier wrote:
> diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> new file mode 100755
> index 000000000000..4106c0a102ea
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> @@ -0,0 +1,9 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
> +testname=$(basename "${BASH_SOURCE[0]}")
> +
> +source "$libdir"/forwarding.config
> +cd "$libdir"/../../../net/forwarding/ || exit 1
> +source "./$testname" "$@"

Thanks for working on this. I don't dislike the solution. Just one
question.  Can "run_net_forwarding_test.sh" be one day moved from
tools/testing/selftests/drivers/net/dsa/ without duplicating it,
should anyone else need the same setup?

