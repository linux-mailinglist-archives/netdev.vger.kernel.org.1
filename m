Return-Path: <netdev+bounces-108990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D26926712
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C821C1C210EA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5DA1849CF;
	Wed,  3 Jul 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PnYwcDhG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E51836EC;
	Wed,  3 Jul 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027627; cv=fail; b=ixaE74puiZNxZfxpMcBRx6k6eOLMqEpbf7nNylLdzzX4FPF2szsrtWJZjS8XN5Hl6upleC4IY9xpw/6nUA+N3j43tcpf4ZwVsz9Sy5Qn1AfeuOrMPE7ohhn3d+bovdKfG1tX0q+aWecFKGAMMOOPaaUt4XrXZyAPhgUtKVnm3RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027627; c=relaxed/simple;
	bh=5qzci5Nxa/CHojHloK6nfIZijOnHU5V6PQeafK409r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c2wF4wLfYAJTgbE+ogAX7R81yeVi7DLbxoLSSN3bAI/rK+lP5kd+g/G/7DnmJ0J5IFTGh3/k++2DJjhijOoFgR6EYQ/gymss6es3GCPntnbZ5dQ+dtOMy2XGmsBDmVkMLlJyaJMVvi5UKghdrFAvIitC5R9mSGj3jpfl1UhOZds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PnYwcDhG; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJudWtgvmKH6WhJjl8zKczzU0ve7gbhIXlfAB0esnKSjX4NiMJMieGxMd5HSXQ1PGn0qirlYVT6SHzcLOR/oift6hvDBXwDiYF+iVtlV3cdzcAp0wvIQDDjz9eEcYasps5esoUTmVFo9eIbIDSV8g4N7d/ZCAeRoho9jxlv2MgRK8Ufny+exeGt+hVF6fegvYJmHDACMyfVadSV8tEI3evaTQRc7hao1RBiHX/pBOVVBF5BnUoFeiVV9zxUQHIPOLZ6BHUAKPRqZVcUb+nZeRt7RnHPRmS+yvV2efTrt8EE5YsaukHcwULrKj78JougzSTyAljbmaL7PPPOjKLWiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6wu7MAeRYonsktWKRUZ9yv3gi6rlTZN3mGfpSTbd1g=;
 b=Ko942xqBDT/iIUw+ev0KtdrCH0WRl2LIruyQZmfUCCA1mFcxCbzKi8YFlBs5mdvuBH7Vn7zew77SPBegQSkLdKNZkJsQDNv8dZMOo9woORZr+/PpzEwQfeR/XoEfjWJg3e+eBdcVykzEC74xWeMPpGtnnfH/HK+qf/Ce3fexM2eeOEQXQebnP/ZXfV2jSe+Jwk3vuoJUGGjFNc/criXpOVRqVOiiU97THY1tw0DRDD3W4ubHP5YVrEwX3cRBioHP8MM3pRhhTnUJ1YIFRHlBQi0Y9ogaFJrKR7ZzDad3Lwe2iaSe5eO1UosGFnH4xNDZfI8MweVSAj1HEBJuwzy1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6wu7MAeRYonsktWKRUZ9yv3gi6rlTZN3mGfpSTbd1g=;
 b=PnYwcDhGtQjYlbPpcFDX0iUuZ52I0/8ZwbootQ63fjURQfUdfaZbasreC7q8UZJbqWxQ9NDGUQNbHIhS5HviffapPIh0SWuhIHkUozLOvCt4AkzC2/sGvOLa+7vY9nl4DyZHyngJO71XQUaFy2iP3lE+E9KmXUxQejddFQjvXorVQ+0dZ1qZdLEbRoqF3bq98DjBMFKfWmmBFgkPT6vozY20lHjMnrq3i0xn/LPuUGFY8jmpjSaU6K1ySBbJaW0PxHvzIyy7TIik4T6hab4JZGR65UbqA0pagFapLjnVZCt2vrM5Y1U2BHKeW78OW7FeDjU6cQZtFu02JfM1QXifoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Wed, 3 Jul
 2024 17:26:57 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7719.036; Wed, 3 Jul 2024
 17:26:57 +0000
Date: Wed, 3 Jul 2024 20:26:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] mlxsw: core_linecards: Fix double memory
 deallocation in case of invalid INI file
Message-ID: <ZoWJzqaRJKjtTlNO@shredder.mtl.com>
References: <20240702103352.15315-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702103352.15315-1-amishin@t-argos.ru>
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbd2186-a4aa-4776-ee8e-08dc9b8556d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJkhRhjG89EHa5ZrA8r9reQFvE2NKlGpr+mkVinkuxlqx2cAS7gPnztgYJ8c?=
 =?us-ascii?Q?N5kEMDlOmw4ltDUAest8wulp3iygEZHvk4q1eo2oVm7b8U5wZw9PyIXCX2Qj?=
 =?us-ascii?Q?tw40oZbizVWWm01LeZQIT3UKajbA+WUpsY9m926IV/W7jARzrYSpb3XC/6MN?=
 =?us-ascii?Q?EujLRepZQkEt3uHt+VjjoQrXRXvfmXiAeBltOFBSo5SDe5J76EKRTnKUucvO?=
 =?us-ascii?Q?7160i7L8RfrXL4sB7jn9GZmZhkigCUSc+lDokuFk+caWgKaIhOI3pzVagLli?=
 =?us-ascii?Q?GbMM56KRj8QVWI3ddJJqyA2NDmSVxzJZVoK3xUvDsWMf054R/Hfq6GlXpwg4?=
 =?us-ascii?Q?Av8sAOYWbuzwiloRyj1+FDB9srpLBu2wrpEimNq/6QLjGB0HokU9fsVc/F8g?=
 =?us-ascii?Q?DYxns5Em335/KRZazBGhujJot+4Hnfwr0ZRp4PHvqiLH6IqCI0L3uQFyWRpW?=
 =?us-ascii?Q?UjwFV9ew8mGjFrLdkF/ZKJdONnqZVlo+w2U41PFMAq8/h7uSk/u9OwJw6v+A?=
 =?us-ascii?Q?T11lNHRB4NerNsyres75rIh6C1BOmA5B3+bu1I7tqP1DbPSnChlqXBkc0u1/?=
 =?us-ascii?Q?HrvK/lS943iEPdnilc/I1aPK80IfuAMQxylYp/sZ7G7vt1zKXnEQdvFXQQLk?=
 =?us-ascii?Q?FH0e2ny5qHgl4OITgayI1YM9hpS0VSvl8yvsu4eN29tyAZbqDnbIZCkI66tu?=
 =?us-ascii?Q?SNNAPlWhNQJtAPTHsdFMt/h3ReDHEtGbxIqkTeCUPC9vUQ1K/pm+Qlfkivme?=
 =?us-ascii?Q?0UjFhmzUss97knhp1murufwtX+7ZNlH4ZS4hfdmHewznvrBuerGsRjolc8Av?=
 =?us-ascii?Q?D9Btoglj74ClAnyEgFIQ5wKsqN49p1aUziPnB+CIViTHUMB6DaoGGXHT1F8F?=
 =?us-ascii?Q?LkVh8vBWppmda//gxeKShgJf/BmBiFRgycpPmA7TdytXmu6LDxP5plK/XYg7?=
 =?us-ascii?Q?U16UfGDBEsyztGBPItFOX4Ttij9neV3KwmZn/j6hv1j9aiml4ganE6gg1TCe?=
 =?us-ascii?Q?dQeIRVCkpFyPagG4BqPgOLhWUJrAiJKoZcW7oZOvFG+h1outYYbry0w6Cymd?=
 =?us-ascii?Q?VHCKoK4TUM28VOsw6R1dUG/zdRpccq3rMAVozSoLYeR8hkpa7xUP8XJR+Ui4?=
 =?us-ascii?Q?jnK3uH+9+BZ4ZcUW6OWKKAFf/1CmeOB0ev9dsKWin8rYbCMxzPGwNWTjmHgH?=
 =?us-ascii?Q?3rMZE2ELXE20oandnqtvnRYVTkXwkG3rnicyylm5VO+ejKkpFfUmtUG1CXkg?=
 =?us-ascii?Q?ZcYBI1M4Ggu3NYtqr5VBMzCyd2e7ZSfN7aKY90m7KTuCtninEGifepPtp83D?=
 =?us-ascii?Q?Rw0C74DXqJsBkN2L0RUT3GGep+rBIwN8cHIYY87wygxbUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZO30ZMUawiqxOcnSExubSQN9JXoAYsbIfEih4AjE44qdOB5XmKnIJydhFQp?=
 =?us-ascii?Q?TEkmcaLgw2luhXuFcRxBg+/ZY3EvBpAQHwO1gVqmUqkBzNLYYTK7U2k9Lygw?=
 =?us-ascii?Q?Orp0YvgHhif1K/cdPoozaDz3ukt1Ngr1L8R71HJJX7uIlzSOjvuZhCwLTFFi?=
 =?us-ascii?Q?bS8KSRsrhvheypnbIjYeTjAhXpgxxPrIxVTzd/J8G+77P0Un8xXV8TY0miKU?=
 =?us-ascii?Q?SyvFMcH9GkShrHyHiYTuRBsgjcRDKHIk+Bfxt3p/bBRmQ1uDAdu8MO14KWi+?=
 =?us-ascii?Q?yrb+WcOC8rVtGVsgKKc4PbS0QP4Xz8Upr6+l/8BgZpcngWqpVKzXQwo1/N71?=
 =?us-ascii?Q?vH7NUgWkkHMc+I+PtIUQ50plQ/yVFeejn4iIckcCkf2SXtT4WJ6ibufjI+n3?=
 =?us-ascii?Q?W/W8/qqKjqMqBERe1yQRHj/GrrAGvSlDS2XRVhn0CvifqJH9i4Rerhnd42jA?=
 =?us-ascii?Q?Urnl0TypB+DQqsLTHksYFrHsdYj0+bFh0xi8xa6Aw7z7ubeBliGr+2gk5EwX?=
 =?us-ascii?Q?5GP54A89S60m46y8kmfMAWMBb7TXhf5O/sOCib4apqVnmsD7QiIAAC2Cq9z4?=
 =?us-ascii?Q?+JNgqqxLpnYLgDeL38b+XYyQSvt0v2xGbaHyCczjTOT6evORQPFIl7I9E3Tx?=
 =?us-ascii?Q?7vNp4Q/7gEj9LZ6ihyiZfziuzFNOHNyN29G+0aeaMSZ3mI6FZW3KjP8BDxtg?=
 =?us-ascii?Q?ghDlvQ8jrh6AU5R0ahGnhiu6SxX6TnMiisU/zqFj9/IZ7AstyVN3O6qGsaLc?=
 =?us-ascii?Q?xg5Z44K/32X8yWVArJ197XUf/JIB3kiQGa3LdwDUaIvqqERo40cu95WcrEep?=
 =?us-ascii?Q?a2zPat+Ht5sxcKk7sprO6fuw4LNQ6B6WOByWvi/67O4Vn1T0ve1UuiCW2kSq?=
 =?us-ascii?Q?hGNnt0fjt+zXiOZftfSHlGMlQcozczyWcYWmDhcPZ3s9NniXeR/FY7UXbLgO?=
 =?us-ascii?Q?MnODF3bStxwJj6btd9Cu5bveD6rjffmxkVExRQ3NvV5NFjXE7t5sMhC//hnv?=
 =?us-ascii?Q?xLoN1m5N4Qnf3oMUMBcaIF+W+VkwF1igkmnUMzIJecDokEJpCb2r4pugtNIZ?=
 =?us-ascii?Q?Ocj5o3V2b0kSAqPU4gaG8jxOVMzVWsQ791pWBxMYzSvRBPPkhZfbZ1fys3pe?=
 =?us-ascii?Q?BkYL44VB4J4kX6jIaeYXcPMNXRJ5ghiQdNzk+YCwoR/6SvtiXBOJ86NIZHL0?=
 =?us-ascii?Q?RWAJjoYhqtjaFmRBW8yykQTR0BPw/MK6r1N5CkkGx/3xMkAls5lwF4alJQY3?=
 =?us-ascii?Q?5cSqZd/uqllKeK9wybsxQSL6wWjh9ffAwDJix3BHNcaLOhwH+foG4veoyzJG?=
 =?us-ascii?Q?KF4rWryW28mpJHlEcW4uqTEGaFXDt1tMSTulNLptanqCdm8OoO7h2Ae3+mLi?=
 =?us-ascii?Q?jPkorA0P/juOpYANF7n1WCQJyHuKxFtEu29Ud5PivXPOWnpVdYwXsUys18Zj?=
 =?us-ascii?Q?e0iLLOH8fHlwirOOL4jGBcIp1vSwJFDlGnySersyvheZ1nNX6teQiI/O76AL?=
 =?us-ascii?Q?Ub8WdOsdSiyGQ470D5TAyOZvSoyVzoH/Pi4ZCWKC8KQlwuo1oMLMaWUhqC2A?=
 =?us-ascii?Q?Z3jNi8fZWgboJUkUe+WkqXmGOJO1W+cEqPMlFvnO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbd2186-a4aa-4776-ee8e-08dc9b8556d1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 17:26:57.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbbBXfcfsaAz/YLlj6JSPVr7rkqBJBLIPBRSBkzz68xLV3Ix1ZVSGYq4SiSGYwgBx15vAxPvXqhanEObP7Am+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334

On Tue, Jul 02, 2024 at 01:33:52PM +0300, Aleksandr Mishin wrote:
> In case of invalid INI file mlxsw_linecard_types_init() deallocates memory
> but doesn't reset pointer to NULL and returns 0. In case of any error
> occured after mlxsw_linecard_types_init() call, mlxsw_linecards_init()
> calls mlxsw_linecard_types_fini() which perform memory deallocation again.

s/perform/performs/

> 
> Add pointer reset to NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b217127e5e4e ("mlxsw: core_linecards: Add line card objects and implement provisioning")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

