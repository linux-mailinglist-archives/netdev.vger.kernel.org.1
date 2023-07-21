Return-Path: <netdev+bounces-19754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF1175C15E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B077B2821B0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8414F64;
	Fri, 21 Jul 2023 08:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FC8463
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:21:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0B272E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 01:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JunJu1HnKfJPRpiI3By8eTshatBlR+3bpOkiYrdvZY98k36YfOKSAgPSnxKTHUEprZ2iAmS2kJapRbOP+6WDzYTiWuCUdn/X624QspoxW5fMHRXtEWrH3viJZum3wB+AO0vyRfWgkO6/5SlFYJhac8qKubJ7v4/qQaH0pUFRGz4/F3q6NHQQTVEiqFmri1f17Zj/GfIuBgP6C1ffOrkqUV3sqimgEByJWbeQnif089ov2zl/A90oD2S8XEx4hKS9/IRuJrm3vJBVVyLv5CWT+uTP7CGUNdEZpjBdr3qu4+E9xr/GPObve5JoQ23jpdayygdWwfB6HI/P4BTiPzsyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRylgYJufE/wRI/ts29TKS+I0vxoxDo/rvQ4h90MsJk=;
 b=VK78wCE0MDzHDLCqvOLY+97sOa9QyUz2t+c4Z4A2eJipKug9/Zuq6JYO+gH2iYwXN4Mo0fJd13I9wIlGnqOsOGCIOhzyf/k5wUs9Y7gyrPzk37bfHInWjAjZuz3lSXVGgB465MLNofcOQmJOh8ZQTKbyPHAcJPE3e6C2LuxNwt0N8RG7Oz65NpQA+Tdat6Suf4xDyn0D6msh0L5fWSQxuD3eSnYk2WKMvf/zXj7MvF/49EAcKZhOl/0zYwUPSWdT6GZQg4VcgVCFAlRvaQBWLaxsfEWIcRS4DFxzQSuHfHYptbMvCuM57P3SHTMXh+jusCIQRdulAEznwEueLEeefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRylgYJufE/wRI/ts29TKS+I0vxoxDo/rvQ4h90MsJk=;
 b=p6fTP9RM6Xr20PGKLNnjO6cWHjl4cx4c+66ExXlQAdsEqQUi2B8psIUYxnQi7mQU9QSndGdhgpLHnaIdYNBVV2AY/EkXFIx627AolbmzcjEhGvkGPIWQ3pLRQQ+Lu4/zOnCKJ+AfofsfzjRvh8o+VeKIYY0zTZLN7f8zy5oLOtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4014.namprd13.prod.outlook.com (2603:10b6:806:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 08:21:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 08:21:09 +0000
Date: Fri, 21 Jul 2023 09:21:02 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH v4 net-next 0/4] ionic: add FLR support
Message-ID: <ZLo/7vTAx9RPaNlQ@corigine.com>
References: <20230720190816.15577-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720190816.15577-1-shannon.nelson@amd.com>
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4014:EE_
X-MS-Office365-Filtering-Correlation-Id: c118255d-293c-459a-76f7-08db89c36fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TWuLXQmakWgPgfpvF6qLA1N2oXfEetBKxUWlpoQjA03olAKHfB2A1TW/UP/Bokmi2NYi1RbKPA/4bOHCQeEsyKLrrPqLJWafWy7Zne/WFX984uVYSvr2PFod9dObpIMjtLbvHqGnt8zlj6st6U39+oRFKRAT0MGUuOKPdT/2WwtT5cTokxqVh24EaTUk6Bg+rEGGx6iFJO1copl6Edc9YKWQJ42EIMc79oHt5bjM6C0xuVSzQLX66cjB2RRgB7NdggQQ1UIfgAw9LZwm6GEf5pJeD8BUNz0NPkkymbG3VO1HGHpptyQMApNtdLnTbRsQ/F9H1HGr4IRoG1X1CtzIarcp38XsA5b8K7l0sYemyDMVNGAukV71AboNH4EoidKf5UcNye/AU0QX7LhNJpzCYw7wwNillq8VHuQ6x1QVKBdGM3t1XhhmF6zKxvBOmAeKvNgVaJLMW2JL6S06FdHxl/2pk/qVn2Wz+fNshjcUEtLVjwZS0PjLX6GejQNgzXRqzRnV9lvlFpVJsrOKp3U4UYUWUAkVrY34x0uzQFv9DrH+71V3RttIiFWzOrBO9orVZArkGSqRMb9dOX32Od+S5prOS3P48xMdKL9fAgM6nzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39840400004)(366004)(396003)(346002)(451199021)(186003)(478600001)(6666004)(2616005)(83380400001)(55236004)(6506007)(5660300002)(8676002)(8936002)(44832011)(41300700001)(26005)(4744005)(2906002)(86362001)(38100700002)(66476007)(66556008)(66946007)(6486002)(4326008)(6916009)(316002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kf4/qksrqFQcgUzOHiP70kIxbix129e4SeGOfiyyMS9TKnZ0XSjPgy4IkQ6h?=
 =?us-ascii?Q?405Jqgif8XAAx94d+208N7nPv9e/R+l+5LreKPc+P6ia5Mvpbe2ZjAljq+iz?=
 =?us-ascii?Q?56sOu4JojYW7cu8HE4Pgt9JjvRaA6dQKJX0CfCVynPBCmC2s8IeO9CUecG8m?=
 =?us-ascii?Q?Mp2kqJY8/nRJQZiBfxGhM6EBZHqt8GygFNXqdL1Tix3EIbN45xTlSRnRd3Ry?=
 =?us-ascii?Q?OConJqS7juVJAB+IqYI7czc1h5+MT+T/PQiH6wcQMvP6YjJYi5I4BpL1uwfq?=
 =?us-ascii?Q?kujwPPPlwjMZ7bfBktahDsEvLCfjYcVKjceCo2rHGivpWOhETqTBlv6xRldt?=
 =?us-ascii?Q?awIAJyODK/SsYi5FHit997xxWtMjTWNDtXzO2UzCl9tPzbyZ1oWjz5j020wI?=
 =?us-ascii?Q?iDbT5fErpxz9rcTdf2MDudWyMFa0OpayOPnqzaIvt6KU0Trxwda2C+/Oy4Vz?=
 =?us-ascii?Q?IlifvB6K4Hoiue4gOnDfRgqdS3N+eCOkvwV7JCLd6aAGcP7/Yilu9+IUE2aV?=
 =?us-ascii?Q?pC2A5sfLtya3u3n3ja3nrDrQXgX5W7wgPYAChkrKM7E+i/mMveCYHmF5G7Wp?=
 =?us-ascii?Q?b4ShzVzQeJZw3yJ1eAmkpevhyrt0kE6fbIM/5sFQvHkUGP/DOLs2c0l9Umx8?=
 =?us-ascii?Q?/Gswd/xNcSAJqO7h/BKWjAtoNTrpeceOCby7QaqnJHgyr9iDoX+TIrUeVv8q?=
 =?us-ascii?Q?QGOTDjDHicBdQRWEsM1wcogBl+nomLa9COHrvZqFDn7XT9ukkEeFZCYJRj9K?=
 =?us-ascii?Q?MN1TnzWGHI1R5NHWhohTBcm1FGLFivFxMVOB1VlmqgWS8d0whXDavKCVqGRq?=
 =?us-ascii?Q?RdegVcos4EVK45BnbAd0aUojh9wAfC5Juv9wEafrMlsCXnJQ8oR+4yk3W4EW?=
 =?us-ascii?Q?DVWClym2TNG+l4AZ8zyg2DLbJt2EVIU/FTLHoLBYErgkIec/0mUE38w8KmIM?=
 =?us-ascii?Q?av2+Eomk+aJDg/80KLHYPI6ugF8m6Nl3XoCowl/bxlgRWZhP1yVcE/0MjMsO?=
 =?us-ascii?Q?Epq1bth7ITdSwIXx6ZO895fR7y9wH5qXMEsqObW4oI35aR661Eb0DeHiReP5?=
 =?us-ascii?Q?slMw9c56FFyQRRN1EXJCdWi5jntlRiykGVVwIetr7zcYEQFSUogjQ55F+Ary?=
 =?us-ascii?Q?Ds2By+ixd9YWnKRMUwh84rtH2ehZH2kbaFFrd4u+owY86QN/s87QiqH0ydrP?=
 =?us-ascii?Q?ZsQRdhh+XZ1lFPGUS5sq+MDEGQDtikSWZWCOQegQSAo7UxY7PXqL5ktTotBA?=
 =?us-ascii?Q?qKpqp/QPOF56BBzyV3OxhUJmt1sNRmnOuKTLGsFqyzWEkVpY8eKCVx+5Biz5?=
 =?us-ascii?Q?lt/yvrh55t0+HwyKxrUoOwI2g8MZ4A813JQqweHL4mfo11HXH/tpVyy6dpBg?=
 =?us-ascii?Q?wuskhNPsYoyOIv0Kh0U7lL1wWaTRwvWdaJc2zIEmdUQTrWvdYN0nWg3X3L44?=
 =?us-ascii?Q?dZsO9OQ3J85AOLl3l0ShPx2SilIMPLBQspmbm7qAqXvHQFTYTX2P9vREwlVK?=
 =?us-ascii?Q?1w833n+/GcMqPmkbSVJ//V3rX73RkJALGIIyMtK5Wm6VYPrK0smDgw1tmaRm?=
 =?us-ascii?Q?Swtkzdn/mI0WhKSBj0S9gN62z0/9zhrySnU3onWIDOi0U9i5iV+KuY60FY6X?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c118255d-293c-459a-76f7-08db89c36fb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:21:09.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY9+Orkn6zBOTwdP5GgSVqU0PLpEgUecgaCkYOklIUP1kk+Z2GDNa0ErVf7D5pXuHCvYwPpkHt1NNP3zaIV41QHy2aHvzbXgoDWzYyh8UJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 12:08:12PM -0700, Shannon Nelson wrote:
> Add support for handing and recovering from a PCI FLR event.
> This patchset first moves some code around to make it usable
> from multiple paths, then adds the PCI error handler callbacks
> for reset_prepare and reset_done.
> 
> Example test:
>     echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset
> 
> v4:
>  - don't remove ionic_dev_teardown() in ionic_probe() in patch 2/4
>  - remove clear_bit() change from patch 3/4

Thanks for the updates in v4.

Reviewed-by: Simon Horman <simon.horman@corigine.com>


