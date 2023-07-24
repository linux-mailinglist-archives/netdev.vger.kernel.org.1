Return-Path: <netdev+bounces-20481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725875FB4A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CF1281458
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1BDF52;
	Mon, 24 Jul 2023 15:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6BD530
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:56:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2090.outbound.protection.outlook.com [40.107.243.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FE13D;
	Mon, 24 Jul 2023 08:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKsP0eo57RDgXmK5bK1Iy/cjjm9uehGCKm7wjU2KMH/bew6mhgL5j7bCneWzBRTIe7pqFiAhlyA0azTXjqIm2R1+IIZs1dc/xwWH2cNJiMWYOJLMmBSOATig9WxxZMgybbbsE6y4qJUFY5lEH4ZbmPA5L6Zw8ndHQSJ/20DgO66k+4fYztA4AzkpPwpgaAwRQ2VNXORjcb4lNmoPonXMHpYyWG5nf8Og6Uoc0U8wNsv6QOat9xPa8UiH7Bmm+/+ZPLGan0Vp95SrMtryGCkJ6OY9Vg5lJnffnBmVo13x9ZvoLeFhNZyZgBeNQcUAN6TZaMm5/qXVZqzg5dUJYTe7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po/cEeU6eq9zQ0woNgk7LMd6wftjUGRMx/Z6nc+HDPI=;
 b=E/LHNb1gUUY1NpV5H8haDOMwxbwjUQyH2kdCYoP1CrIgNUtjHk5pn5y5rQdacyhjnKNC72y0f8zR4vpg9IYvLVC6bET7q7pSo3K06prtuVa1vv1yoVTqUTQID5rAkLkmhUAeJumVeZ7Mo73EqP+uZkLSxgUuAofR7ZpMVGB80A5Ae3Vb/tE55k85LSVsBFyxucIzHYzONNXQqCpuDr7KPQC0a73RO0MmXZbPz60bjIKQpfhhvUpB0I2hDKtfYK7Vr5FdS8cTQ+pM4dCFsiG6WyaT5dXs7JKt0ml2Crd0jLqzNqD2VRsJTIKsEsQW2XrTrcUs3c+U5ndABJGXHdg+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po/cEeU6eq9zQ0woNgk7LMd6wftjUGRMx/Z6nc+HDPI=;
 b=LV9HUuotM64YjbESe/epvr/CmFn7zuWp98hA99kNl5JTWCDQl/HzMeq+oIJd3iTd1wBzluia8QVNxk0t25aajPWN1JY6tThHJ4xJTf+pZqveJUfy13Q6lTRtNP931KnvUBumcUdj3JMHH8xRaXN2CHgkPB+9zoZYaO/YSrlbxJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5116.namprd13.prod.outlook.com (2603:10b6:610:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:56:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:56:30 +0000
Date: Mon, 24 Jul 2023 17:56:23 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 05/11] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZL6fJ3D/+sVmjLvh@corigine.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-6-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-6-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: af5fa294-4643-4f3c-cadc-08db8c5e8bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApKzg/DSZrxuvKq+/6fgxrYVMkxldSqPukujpqJKA2DkjfCWFTfzWGvQzVKddrO+7VsrHAlgiiitnIKEgz6n2Crn2ZETgZNxNNNpxB3ANcq5g94knXCwkqwDM2/MpfkBbrLBzBxeQ8EuDl4uSG7cOjBiOZj2tcb44GiQ9EB9t69RI/nMWLnWH5Lt1tXYp4cqcTbQtb4PUAUYveCQaL4QHK+cByWHwXdkxT4ztToLC107gv4l/Zjphf9b4k1BJmCt7ku5+3GQHqFwk1+X4rPMiNZHoz7rYTm17FLhVsMCq4uacdrUzPV59yGYS+VWb5WeboE6GR41wsfCpXMiMuoWkTlCpRWlIUDrA/VINMNbxzOhprYLPaIvVwl1bIgzPgcbhPHp/QJKgtjSnYklwHpZXaK71zzYlMZuUNS4e4+Q97th+QkCCEwWjtFcqZ36jm5alhIfaw7/aQ6Iwf9M2jNLJs0s69l1rtkpLY9VR4tVkCFYrrGt4e9TdnfhcRIdZPUWT8l9rOrOppQZ1P8CDl5fbwJVb3gXL23gxQv0L19X+hj0mLMAAqcz5wyfDICCt6oUN97j+aadxbe+n37vZHuWoj7YhAJZ0OruWpbGv6iSDo0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(451199021)(4744005)(8676002)(8936002)(5660300002)(44832011)(7416002)(2906002)(38100700002)(54906003)(186003)(6512007)(6486002)(6666004)(36756003)(2616005)(478600001)(316002)(86362001)(6506007)(41300700001)(6916009)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ygF85CTZ74aYUziyE/efFJPaqHFhLSb+bJDNmoxSD48hxZORjtC6tKZb7kF?=
 =?us-ascii?Q?YDc9vXFyKjzXC7Txnr/YLxAGdQa0iXxsuPGR9fnRkapdY1qdNR+naPjcrHYa?=
 =?us-ascii?Q?T4jF3KAYSmCz0OmAmWUpGzLzrT4x//7Bag35KrKzlsnrrT/n55T3oC0IVB9v?=
 =?us-ascii?Q?8LtRlGja2/6Nf7sLNyOZrU13ZJLU2seV5euxWor6J976g4AH/iKZVxtEV8gl?=
 =?us-ascii?Q?wKe7HnR2SW+U2sBjn16SkG4F8nWf4oPPYNQzNcBuX2lodOnVSJxOjX+rM+1d?=
 =?us-ascii?Q?anbQ+y524weMrdCxcOMQguf1N76uzt6fFMM1/6iiw+YnHLfy98Ai8Wt/97qu?=
 =?us-ascii?Q?76X8GPFeLnSONlC9yvKFp8J/a4PppFZEJ3/VV3kzwd/KuRYOvYJVp8vvNZ9q?=
 =?us-ascii?Q?pKI3iBjoCtYer828/jiZ1M7v+WkEGxcZpZ+3MTvEH7UiuPJRsFdz8O9OVWNF?=
 =?us-ascii?Q?jYlT7aTn8ttC7WlRXmB6dJHR+2RFT/EB6/ZshoWl0CpD1QTAMRp9+U4tersQ?=
 =?us-ascii?Q?LNHGui1PJeHQRIJcgHNLpAUaTZvfvPS1xMUR1BRjx6tm2u/D7DPQaw6oGZYD?=
 =?us-ascii?Q?VYb0up1VP+Js/Mo/pohEcgVEIV0HXL3oZ90Jf8hyE5ShnxGdOOlMBEflmG69?=
 =?us-ascii?Q?WOTArJTdOuQZ6H/kEFb65c017tZ0etrKTGu7llR1jryP3k+BrPxjhuSv0LRE?=
 =?us-ascii?Q?svUmIlavKKKIuaBs/kjrzw7LPPLqV6Ny9Yg0oODph2ijubTBxRTiWGisIN4m?=
 =?us-ascii?Q?RkPp56oQEF7b26y7YSQbDtEcIKHhafTlIegDY16I0wMFe52shMv6q8sSMODg?=
 =?us-ascii?Q?Ixb1jyPZpVrt3Xm37hjKkjDy0wUfpjLNZtjR6TPv2ILN4IjI5xX/BEZeyOr3?=
 =?us-ascii?Q?5HFRv1TLR5N0UzN35LZNQzelKbSllaSuIJpIaf7o78qd9+Pb68VI3eSYR9Rq?=
 =?us-ascii?Q?4gIG7bsCsnvO7CgVrDTPDnEDGtSI0jGsdrYoRv4gqr+RSXP7qVcZwQPVs4lD?=
 =?us-ascii?Q?08TFQm1ohxvDjgxys9TXEPaMudXeMkyXa/qKm0WixIHPM2XYd1W2jL1l6u1k?=
 =?us-ascii?Q?8vKQYGSiuel4Z5g7p/oMdgrPh3rHevvo48bMnGN6Mv73x9u2tuk/QW79Hdzm?=
 =?us-ascii?Q?zP0DUCFUBHNAnY1A5I+HlRfJeh2pdJ1uihSK+dppmDaKCF0rnrgwqHn33FeK?=
 =?us-ascii?Q?eUcn0DdCpacDqw2qQupOEL4m401QPXTteDntYdCiGtcUXzEOku2kxrg79DJe?=
 =?us-ascii?Q?QVXOocpqu6orEEhDOzSurgJdmWfbvCIEMumaoqNioG8UY4p/aBESXcjZvJNe?=
 =?us-ascii?Q?VP6OsXEQ9YuzJNia0aopXKmeM7Vhn1uHOrR/+/CFPOdLbrEgG3uNXT2zn3Rx?=
 =?us-ascii?Q?QdjQHNM3bsek6Mx5I3FlwHMnmNHQ2lpn8U24u5Vx6KYfy8BALd2NDG6XUcVq?=
 =?us-ascii?Q?R8QCJsQXjl3LOlon0fU9NixqDXCL1eZaOPSFeQov9BONyXTVwToGoBiP9lfx?=
 =?us-ascii?Q?eTuo70vcHFGTwcGdp6xgBK342H3UCijKZrpXdEpXm/pNI3jzoCH1uqDcs0B8?=
 =?us-ascii?Q?sc+KyJOiimwIwJmCfO3AlboIOkVUzirS2cIrj1BG0FvakJ6OA761QVSNKGpx?=
 =?us-ascii?Q?JEedMSPS8BIka522+pnlEtBnyxVs+AK4sVbkooan13VZCwM8B7RsOqWZa19J?=
 =?us-ascii?Q?VnL1Lw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5fa294-4643-4f3c-cadc-08db8c5e8bf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:56:30.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rmv3iCcFQ+pEpAgkYNwHCUK3y9THYrOcj0ZT8JjAZ4pP38XGT6dZkt87kyIZL+kwy4XEInyUseJtGFoXhRXGp92+46RjGbFPFeM3SQRmBWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5116
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:18:57AM +0100, Vadim Fedorenko wrote:

...

> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> new file mode 100644
> index 000000000000..3574bebf2c63
> --- /dev/null
> +++ b/drivers/dpll/dpll_core.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (c) 2023 Meta Platforms, Inc. and affiliates
> + *  Copyright (c) 2023 Intel and affiliates
> + */
> +
> +#ifndef __DPLL_CORE_H__
> +#define __DPLL_CORE_H__
> +
> +#include <linux/dpll.h>
> +#include <linux/list.h>
> +#include <linux/refcount.h>
> +#include "dpll_netlink.h"

Hi Vadim,

dpll_netlink.h is used here.
But that file it isn't added until the following patch.

...

