Return-Path: <netdev+bounces-111335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E90930952
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344711F20FB6
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB26D1BF3B;
	Sun, 14 Jul 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d82BkitW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2E1CA81
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946421; cv=fail; b=rf72qRJQAN6T68ZxhIteLOW8YT10WX6rt7TzW11Gf+PDPxtvFurCcGzYiUsDcC9Byj+EvEEXngLHNF6uO9b/VrtDuiFWauTRmMLsUMhhMgm80M1oAOIcsqUOt2OS79aVJIaoknvVOgJ/Xi1BDQm33N3+YKfOLtXHmhfZhDy/YX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946421; c=relaxed/simple;
	bh=VbxaOnyINNEciLc5TJSkeYMWGisecKmDMp3TbqKWO8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSh4te+x7njxOIIlAwb5fT8mJj1ZKhx4maDf5T9AfMJq+F6BbRGGz0LB+CmJLnlNIdlgX3mWmiEz+bGye9eNXUB7IUowK0TpS/LTmV/SflcuqiHybtZPMfOvuL9qPjWOUIXrtVcbY8bPE2mTFxdvrr4sKD+rOglHk61BG42z6G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d82BkitW; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWohGQNzBlnXL1qFWimemwgt8+SUXdA4ryUjHYjg01l5EfxCVr0tO7q8CvOLJfFjaW0BPntWVaKYF04TItAeW2+JwNlm5bsAcFzDOyaNlZsK92S47a47qUTu+wrpfVyY4tIYG+UuqiGzi2x95NNKv2wG4K6poda0sRKQgPjFeFIzN95eG2K/zOQxQAY4JzzdLT1AURB10q5QBeaz9yGSCZ5NYYQUBIQ/UxAVMPgn0+mLs5PEyNIey305behjTWj/jpkqZr5Lpzf88CNw4v1H3r8+I2EDz18OJIG+G9TKNrRg7rgfo2/WzPNGtMdLcmnxtK5WfEXsyL52gVaqhfLZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wGnEcxhrIWEP0EaiLQiNScEAli+ZHX6I8cOK5dmDqA=;
 b=ifuNJvv9Z8luBj6eB+7Giih67vlT+IArNrw6Xowu+EaM8BopBCwlGQVIDB8gzVX6VNbqe6yizjqlaDIud9lYUr7VqhrhmivVMXzPCRF7wO2dKNddQ0BeK3hT8rPaq+h7rto+UaH2HNiQt+FmRWduDxX6jz6NlR7x6qGb+c5SedRJngvJrHTQE2xjE59lDCNykfJd56pRgw0PH3KDmecuZAiH8nFUHSkwiCpAGZRhc9/KZJkAjmuoDo44ym3XglUumnHFrLvhot0tPY88pO+inrmVA7AsTaUjN5BYn8ZIVpwJ92eknsWeic+lAhvdMx5m0po/iISRxrE46O9D2/PqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wGnEcxhrIWEP0EaiLQiNScEAli+ZHX6I8cOK5dmDqA=;
 b=d82BkitWOwYblvCIDF+9rSJLbVV9z+LtZ6hco8bK480kh4n/KMpiqJBMfGwnYtzd5m/OnEYI9H/4cnNvNsDgAornzJtthR++qlQvrbWC29gWrxEOnHG+5z8cQWVVn/+pKAHTUODf35Pi06laLL5gkLQU5UXdYnfKJ2T9TvBKVS9WhqnbgRuGUWqxOp+POJBT4vZQT6HorA5QVOpN84keJ0FkjconZ8LObmcqrCEPMV1A9WP/EZGgBhBO2pkmRgzWNQDDSDbS/4TIg93J7cCP2F3bLmCNSGrmZZldLZNSX6lLhXq/eIrZMUDXlgEy/y0BzdNhYZi3Ld6K7LydXdjejA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sun, 14 Jul
 2024 08:40:14 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 08:40:14 +0000
Date: Sun, 14 Jul 2024 11:39:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, andrew@lunn.ch,
	danieller@nvidia.com
Subject: Re: [PATCH ethtool-next] module-eeprom: treat zero arguments like
 any other arguments for hex dump
Message-ID: <ZpOO3f6qaVWXQ3kY@shredder.mtl.com>
References: <20240712180706.466124-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712180706.466124-1-kuba@kernel.org>
X-ClientProxiedBy: FR4P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: ba56879d-9551-4ff2-6026-08dca3e094aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9tSRKlNpi9YvUUkRxeDDranwfJyAxotJNnrwToBH/8LWrLcdmbcYC/QIO5O?=
 =?us-ascii?Q?XAXL5AGVwgwXhjTuzDA8cbpIwgu36nJNs+SQkimMx6yobJr7agRL1azK53wr?=
 =?us-ascii?Q?dpbHM47eei0jXczw4hSJEItnTXsyXWkMNE29CPQrJnrmYBSOoQRK+YlWBxXI?=
 =?us-ascii?Q?UVaFVeXyn2ZoY/e4C+gr3thgirVfb/YNIl54eN8hB6r8EUoqEZNkE1jW2xeq?=
 =?us-ascii?Q?wne7DXO2h/6k9uks2xJ6WqRW1fb9TbIj/L6hRrrh5g2JIaUZ7AZYE11o1riV?=
 =?us-ascii?Q?sNukoc00w9BZffkdlAFgiPKkJwjLbBP8SCBk7vtS3ewkONYFRy5zMZu5HRfN?=
 =?us-ascii?Q?pgOg4++YNVu513HpkiDdOXV+BhwmttkxWQpqYchGSBoXxWnD1yqBX7aXhzuK?=
 =?us-ascii?Q?gP5K3Jww8S+tXLDUVpNuhfFOBd79O7aWIU4M07ud5x0KRhgIIWCCrogyMPPP?=
 =?us-ascii?Q?ml3dgis5j0NqyAS4asdn17kIjJAzSE7p+gngVn1t4YsVUfCWiu4AW1ybalxX?=
 =?us-ascii?Q?gt/ZT9cZgoSKHos6xQIPQ4B3j46707cJtkZD0uSmfYMS5gPUzTyuyNJex1sx?=
 =?us-ascii?Q?x9WHjg4lh5k2T4LWwtiCShaI1CCUy1rnIqitfplPHUp+ahbncKQvLcltsbax?=
 =?us-ascii?Q?zgdw/aqzZe7MZ3R1GHzbpcj712zSZ1anK5Uw3x3T4WqQxoH2fbZcZw4QCPZO?=
 =?us-ascii?Q?N6ZwRYj3maIFoRp+rOs0tj4Am9KvFms5iFHTxqsGbnN7N0qwZow2dikF4bH+?=
 =?us-ascii?Q?UyQXPkZhkJ1VVKXM7cx5wOghCYkRVxxVzvW+5cc+SCbguZ2CCfFMwyqmJcUq?=
 =?us-ascii?Q?XLIWjREKGSgGvnP3PxyLvxwoNGz30HqdI688PL7a7G7xINiVFxveUk/TQGYl?=
 =?us-ascii?Q?i/Y2oE/1uIB8gF6gijNdGBTSRsepwCE6Cx9UhsYy7mhhjnGU/G1+UwzlMaZj?=
 =?us-ascii?Q?A+4fKJvpZ6HuWka+Q8qKuCc3xlKm3Ac6PNPbPjC4lcqo3ubrFIbyL+0DC++6?=
 =?us-ascii?Q?Zy4xlt67wQ77rTqqyeCuoctaDweIauN6qIHLlpC5x2OJhdsgR3tq9aKxG+bD?=
 =?us-ascii?Q?orRLozOiZ2BgtQKv3VPBlodJJAlfVZvly4YLFRhZeMIb7o/GLYiu8kog0k9x?=
 =?us-ascii?Q?HM2dvl3rQehSMM9gkrd2IXotHsCUpCVhn6KaeRUeXmWEHQTgg5L6yttYCMI0?=
 =?us-ascii?Q?5MI5HE3Ey1hht2cNs/oSjN/qnxPs4VfJ4tO8bc2NFuraYaUjnBVUOZ3BIhNR?=
 =?us-ascii?Q?u0oy7Aokx/KDZvy5757z8jB61c60q1aGAPxAQvEaNOL6x5CD8BHudc8cPHRs?=
 =?us-ascii?Q?i+3xtxCpXuQFLvvKyylegTIu9nph4HVZrop3FP5NX/vlCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VG0ONHCrPtBkUqA17WM0bxyARj/EL7GGZcuDJWAXpIBNG2544y/VR2wzxfz?=
 =?us-ascii?Q?n07xmBWX8mXpSAgG2h6aTd1/FZbFZHgLoEmupg372+lneIR+J47/dsXJeNle?=
 =?us-ascii?Q?7fBUNWvU3Th9G0p5XXVteI7fwGoME9bpEp+bLOlVWXPo+c39vU7y5RDDxbMJ?=
 =?us-ascii?Q?Kh937RG8Y3d0P0KP2fYU/falkFH/KmpBZhMgEKqyDmfkeBYymzn9YGrCDdRi?=
 =?us-ascii?Q?K3HHplFpP+o0pfPEGnWB/7/w29Fb69oqlEz5LJx/dwBCfJZnC6w1y9ubUps+?=
 =?us-ascii?Q?Ha4JECQiOQXJZ5vdCR6+wwl1Qifub3Czwh6PpatkbKTa/dwCMefbmt8xQAvj?=
 =?us-ascii?Q?mzDv0I34nG4mNYbd+xrjy2Ms6GwshIhQp6/laX1clEVKr9HPe28yxeLDTnuD?=
 =?us-ascii?Q?g7q7FqnSSu+0K+veO/YAig30gNvz3ucvAftAhr9dTvRKEXuAGuwf8JO1Qa3B?=
 =?us-ascii?Q?uy2FNUgTUyuFyK66HcX5z8K0WBnTzqOLGeH9VgJiXEVk0FGqoQ5H2Tw50k3I?=
 =?us-ascii?Q?ns+/2R/BnF0SBzRsu17qRdYt1A+sKfOfW1+ECmIZw0usaV/1BJ9dus7lZpGL?=
 =?us-ascii?Q?HntIlZV8h9HWHeleONzAKnPP+Li7fUbWHwrpjJ5Sah3ykJBKISvIlsc3n7UI?=
 =?us-ascii?Q?wPNpup+IS5XwdHxIBndghrioW87fFEAXCqD/YHLQKUN9sYzGdwWfir6OBiQD?=
 =?us-ascii?Q?ToklZpD/WZPgOukH7FU/eJ6oecaT7OEsZyvrSJCvyDd+8nYGDZ7X6S8/hs6X?=
 =?us-ascii?Q?kQh2tlEvJh12+rMGWgnsPeFJhKcXhT+VooN6CFb1fuFEn5eI12meLso50btE?=
 =?us-ascii?Q?Z9laPegR08IP4USs5agLzUURj3mcKm+Y+1Xy8E1iabRG4XLa1sLZ4mCDPigr?=
 =?us-ascii?Q?MlwBxcBbZzSqGIhx/0RZB61pjWpE7oUH2HiClEsuD8dIOkL5W5/2R7wRLc2I?=
 =?us-ascii?Q?kFJCUMzzXgEyprq1hGeiOTpnDdlsqBTghQT6gldnZN7apeQ4UyJYnrZl2/9s?=
 =?us-ascii?Q?eCeQMGlriW8qiGmouMVfftr2rOFRGZ9PpOM3AqxujLOC3vBD0kO+TwLxlKGV?=
 =?us-ascii?Q?uve8lxBO5B9YCrZns7K587N293xOUYsSEdkOfaP6MYQzGHNZS8gdQZnirrDT?=
 =?us-ascii?Q?DMNw8zazJ64OA33Ww5RpYnhH1GGjcy9OcSgx1+47yiGn/rK5ydYap5s6qgL3?=
 =?us-ascii?Q?3z5vn3F7B/pbHm6r6xKGbjvweW8oGptCGbzaozxXo7NJxX5kC4y32Cn47ITK?=
 =?us-ascii?Q?WywG4wmykDWrfN+cmaf6Y36oqphw9r4Az9ppwpXYCEP92GngNsDLP/DZ/QsB?=
 =?us-ascii?Q?04KUaYyt1QemOhki+DY9rHC+oRvDnMCL8ORArjdiADAY9x+umc5qVjjhwwS9?=
 =?us-ascii?Q?SZxiC4i6gNllwucAhJcxMH2MBx+u6QtXlTvLshiAYKOvGvMdz3chKJ+Bh68D?=
 =?us-ascii?Q?J58Sc0idxzHnlyDCkkrtqLqYSmZsq/bv66ZmW79b8Xslg/bE3PYjSeF5sPSG?=
 =?us-ascii?Q?MzPuI6+L5w+rMSCQmpbA+yglVVle5wKBG7truEqxf+xekHkwPGT77G0GbxXs?=
 =?us-ascii?Q?H9mLvMJPfaiK0WvUPGj+1bKA9wR5yh9fHSayQGfd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba56879d-9551-4ff2-6026-08dca3e094aa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 08:40:14.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvHNwpjAwM4flaIYxr43cMt4UZ0u1MD7ogcqLL7UHbI/t7TxIlLIneo7zMavv2+5DTeXXOq+oH/nj99q+e0EZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

On Fri, Jul 12, 2024 at 11:07:06AM -0700, Jakub Kicinski wrote:
> The code does not differentiate between user asking for page 0 and
> page not being set on the CLI at all. This is problematic because
> drivers don't support old type of dumping for newer module types.
> For example trying to hex dump EEPROM of a QSFP-DD on mlx5 gives
> us in kernel logs:
> 
>   mlx5_query_module_eeprom[...]: Module ID not recognized: 0x18
> 
> We can dump all the non-zero pages, and without "hex on" ethtool
> also uses the page-aware API to get the information it will print.
> But hex dumping page 0 is not possible.
> 
> Instead of using zero / non-zero to figure out whether param was
> set - add a bitmap of which params got set on command line.
> The nl_param()'s dest option is not used by any other command,
> so we're free to change the format.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

