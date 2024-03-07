Return-Path: <netdev+bounces-78368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF68874CFA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DA11F241A2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDB1272D0;
	Thu,  7 Mar 2024 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Hvh4pUk1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F90125DC
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809657; cv=fail; b=hcH2MeIdaYj15455Mq18WesQA7tEETdVO/pnCmGzMCwewGdeS+IEVaBeFK5n1DHsgloxbWVgRioQfbRLhUSrlVgcy128E5RTHINnHkGZdCwKLozx+FNqiqUiLIplJMESiV0UtoV1jSQkPducaMCGuJAieEQRbeX00SvI6oqqIqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809657; c=relaxed/simple;
	bh=Mn8d7TJTPmIyxmwTSOMJg2nkPmmVYGPiw8oxr4h2SgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dksE7Bu7Ottyv5xjesHqscW+Mh69BTxf0umXBelJFV3h87BEl+oe9YuEvCp4TVVBOjS0tc9rCcw7P4Rny6YoYLhIUJZ1bgNhzmuGs/OiGZcQsu8GqE7BJO0WzRYfjhqtkGEfPuVHVew3xBeAQdO/jsUyVcdNXrMkOb13Vnz2sv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=Hvh4pUk1; arc=fail smtp.client-ip=40.107.93.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQCRn3nAXe/qHTy8svWPZTrH6gwEiBK2Lb5vwZYLEONOfQdaeYa1SB6lU2tbOSZogOhocFOdq15j/MXxn+4sGV3QBS1CV8q8+FMVFsuMGoUtOGih5aR1WLtb5ViJWGfR7MGLiCrE5wcOhOYP/ocrdWU2lPIAF9cxsL+xUsCsWxj9qs41DJm+LU9M8YqKhlZV33r2mqXP5W0+EUO+epJyIx3WGWu3tFRQzCfVn2mR0DhrWxmQPeez01pTmnlk3ngJc/7Fd5h7ZY6aGSNHlwVxco0RsrSvM1UqvLrIREhJux99zq2bdQRqjk0rEjulB3euSJyX7CxFYSdXJmBZ2KS7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMxo/agHPqXn7tguL3/N7ygnFEwLLqaW094lCiXBMX8=;
 b=gCcGOexZx2CVZ4v/uN7p0vMOj+xQ1bx0Qz6GitKICjgIfIu0MT2FnXnp/DU4mTTJd651MPhcrWifwVnzoxpVjah79fgLRKmJZNW4rkbes+x8f290UYD4bHcDnKxJ4v5SPqonCJ45ZTaFYYLv84cKIPPv1sptUW7iCJ05cr0BF0ZFI4eccp6khh6Ajn5eYjz9ateT9CAinjeZA0iTuPjoXmcQ+bv5MWdmtTibJK6Q95ppYnQxhFfjA16qISmIQvOLn7rhr8mSMiv3dI2cT7Fy7SNaorrqRF3+VGOlsgAbgLj4t7J1kRViojgwLo7Jadkbi6JVGiXDzoX1o5l0HbZWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMxo/agHPqXn7tguL3/N7ygnFEwLLqaW094lCiXBMX8=;
 b=Hvh4pUk1vTLRiE68BGacd/AUXUnBwxM16bCxa3tfPAGXid8jzlCfuT41A6g9QH1BJFwhGbO1OoMhrDVwVjrN5GI1YwXSOKZ8GqOiAH69PVsxHiBW4GI+0kAXvXPmt/C+XIWzDh5HCrJmv39pMdNqM0S7M/glpeHWIoUUFLRnBks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS7PR13MB4574.namprd13.prod.outlook.com (2603:10b6:5:3ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 11:07:31 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:07:31 +0000
Date: Thu, 7 Mar 2024 13:06:54 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <Zemfzkv4/FevHHfS@LouisNoVo>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-2-louis.peens@corigine.com>
 <Zd8js1wsTCxSLYxy@nanopsycho>
 <20240228203235.22b5f122@kernel.org>
 <Zel4F74EqG2YMf+w@LouisNoVo>
 <Zel9k5uliEyi9ZTp@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zel9k5uliEyi9ZTp@nanopsycho>
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS7PR13MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 353fb2e5-697c-405a-3c77-08dc3e96c876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0o04XLu5xCu/QQLz6xUNtnnUYdbfnoK16AbIQsKJFpPlC0EIe/rZ8ILDdI/Bla3Z1ZtvG1NTpHZRGUND+HIkS4pNOjk/NXRrJtcsJO91SDHv17lM3oWI3KWhmtAuUfkEEpdY7VMK7e5rCEawff4DuhNjSmVccOAsFd4X4vCySlzpnZonM4ueBXit/BiaU+pxC6zx3T18rPmRWqKvON8mk0tuYGH93Yv9AqKobsQK7aMobAXlSlppDjCjtYCtgPH+hKS6xotN5knSw7zXD/rDIgVxBqBptc7yX269KtuKQhKv9Q0zLho2Se6e+u/vmSWUxRCRgO+DFbfRtgXUMVAoB5YU2gCR7qU7RgOQtTOFh11M2A+jg+uk7SlpQNxtnbBLEJmsghjuKszqahDZx3BElL0vpOApILrePXBcUdkrBoDViirTQWsQ4ky7XVEJpay8wLD9RS9KkJUc076QtSN8yFMCCeQS4+1XRZOrEKfeL+xrVUl0pim7cxJudawQjwNuxEy2Z0Z16O4Rv5bV+eeyxG/2DOiJ8aa5fP26yd8Zy5fzOQJTrmcGJ0bb3V9PjG7udS66NbzpBw5pxdocIrsLihNoBIDD1Y4lBVAsteeQNpjMtTHvuOeHIC0yktjAwnM1G2LEP4OdrHsNMac0/YMn3ZZOjxlqUNlHGiw8etyrDWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2jeadEcMCLeguM1pQNigYvNpGW8FQkZP9nW0IBv5hB8kGcYcGEP0idBkzF0H?=
 =?us-ascii?Q?4WB5DgQ5tdZLr89X8ELz3YNlllKFiamCsKtoi801fqkVtk3iCaKAEUllzIMC?=
 =?us-ascii?Q?H2v0a7vzE/qz6dHh715+FX7e1w3wV0BeNAP0iTZuNQbfndm0joRBk+gSoTcr?=
 =?us-ascii?Q?EVNHrcklMemeM7ZOlpFsqwqIh7utLH8FIInKKsNMEmU5on5WMdSeDFBOv1cT?=
 =?us-ascii?Q?vOXy3yGjuJeWwEecPctehezwikd1vMacguAiTg/QlbT3rEneEBaba1XWmTgG?=
 =?us-ascii?Q?u+vxfXAWSvcUCVQxDG25EIV8kOFgWGwPyXKBBEA1SQBBIAG0pyEj2j3WZtL+?=
 =?us-ascii?Q?R7WIumQeT/n0TkdqwYLuQpHgR0bFa9biQed4FH/eU0ARjSrdtXw4novui3+0?=
 =?us-ascii?Q?WHGZ6s80LYSnNyTBoP9Q8pqtfH+g17Dp1QAyo6KzyYT0VRGK3JEF6m+uUT9U?=
 =?us-ascii?Q?1IOFV17EIoRIfCimVSIy6Ldxt0ppUM1cJ6E5ASaCvobFXmNAj/yg8b/HTP1l?=
 =?us-ascii?Q?kFI/DPQF1CSiz3Bli6w5Ogpuv5OA5X7cve0DZPLdEt0nOjyJm8UY4vB+5z48?=
 =?us-ascii?Q?VAox3L6qVObJFKSFsKofqiyMCUw43vgtfHILcCQp5qftX5DJkm5PuZpfO4jk?=
 =?us-ascii?Q?REuWyD12veSqZKonQBauLoV3OwSeCft58VVt3CJxjhAhQsK4zoXuVncrv6Ii?=
 =?us-ascii?Q?g1T2ExE6V5oFdnhsz9gediwUzWK8j4TYRxM6W108CJe6tctRLapOwC4QLDtC?=
 =?us-ascii?Q?7O7tPsZBGpIXqKZRyShssRXi9g45hVkwzYgAaBsd/2tJm8vqmSFA3W0U3LzM?=
 =?us-ascii?Q?KhCmgN42zAhdTlAM4LsYbSn+nxrViTMkdWFVEB48ty0nH6M4m4HW6ZwZhQpB?=
 =?us-ascii?Q?SSrE3sSyXiZRb5wBV7nTeaujOEWFeFwYFd5V2hdMDmR/1H3XYg41MN46vVjO?=
 =?us-ascii?Q?hhkmOWHM1IaY7UebOojtXXxzCT6RFQA/Q9uN+oZWbWeTNyWmzNMfojWyk2cN?=
 =?us-ascii?Q?fuYOYKxiitPxSifKQTmxqADgLkxb/Ou/WQK7fft3eFYtJqe+GixU9GIeNvfy?=
 =?us-ascii?Q?QlXQomUOvBKnuqNFDY6jnh0/P6one3dkfsAxA0VWIOdlzjvdGsqk9Ymalu6N?=
 =?us-ascii?Q?p2/Wme4hPyMbOI3ytMIB5W3FR7mECD1cMqbZ4rofEayrwFhu9fRUBCiS7N/M?=
 =?us-ascii?Q?sl2wDbdqvYGoCD99j0xUru5z97YVnqRIV+gPFQftDTHcfyHwawfpuZ1HlyVj?=
 =?us-ascii?Q?sDF6O0AAl6+Oi0muOlGQkkIlmYQ/btuhhC/bixF91MmUFgJupO4qUYfU/7Wv?=
 =?us-ascii?Q?tSGx9BZ5YUkxzZgDZZRVsX4tJk/URs+AA+MD4yDO6aMhQA9RHKVPrjj/SPvM?=
 =?us-ascii?Q?7QaltGTfpEM6P28UgfNw3Pl1Xc0J8FMUhAk9sn+/RTOpyeXcCmqE6eio9QeY?=
 =?us-ascii?Q?SW4d1UmGKL6cta3yinLEe5Acum56pDY19BSVUaR4fslFOv4wll8b3Q8B7TiC?=
 =?us-ascii?Q?3gPpzz8/rTumMbYADLIsaMKafnIPPFuHd+WKnQY4hRjtZvybkH3c/xPUBNSK?=
 =?us-ascii?Q?yWkuyjlILi8KwZkOkL2VKohYoENO3Tx72+fsWHwaIgluspcix31kfZJV00WH?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353fb2e5-697c-405a-3c77-08dc3e96c876
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:07:31.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDIhQh3U5rZc8L/uJAxpfzrPEKanzXo9/5s4+uRt3xPzdolU6aG/aApkzsRU0sJkkur/g/5et0nR8DrUY4fNZYN96guIt2i7/6Uu0DAlYhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4574

On Thu, Mar 07, 2024 at 09:40:51AM +0100, Jiri Pirko wrote:
> Thu, Mar 07, 2024 at 09:17:27AM CET, louis.peens@corigine.com wrote:
> >On Wed, Feb 28, 2024 at 08:32:35PM -0800, Jakub Kicinski wrote:
> >> On Wed, 28 Feb 2024 13:14:43 +0100 Jiri Pirko wrote:
> >> > >+/* Part number for entire product */
> >> > >+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"  
> >> > 
> >> > /* Part number, identifier of board design */
> >> > #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"
> >> > 
> >> > Isn't this what you are looking for?
> >> 
> >> My memory is fading but AFAIR when I added the other IDs, back in my
> >> Netronome days, the expectation was that they would be combined
> >> together to form the part number.
> >> 
> >> Not sure why they need a separate one now, maybe they lost the docs,
> >> maybe requirements changed. Would be good to know... :)
> >Hi Jiri, Jakub, sorry for the delay in coming back to this. It did
> >indeed trigger a bit of an internal discussion about which number is
> >where and for what purpose. More detail at the end.
> >> 
> >> > "part_number" without domain (boards/asic/fw) does not look correct to
> >> > me. "Product" sounds very odd.
> >> 
> >> I believe Part Number is what PCI VPD calls it.
> >This is indeed where the decision to use "part_number" is coming from.
> >> 
> >> In addition to Jiri's questions:
> >> 
> >> > +/* Model of the board */
> >> > +#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
> >> 
> >> What's the difference between this and:
> >> 
> >>  board.id
> >>  --------
> >>  
> >>  Unique identifier of the board design.
> >> 
> >> ? One is AMDA the other one is code name?
> >> You gotta provide more guidance how the two differ...
> >Carefully looking at this again revealed that "board.model" is indeed
> >the code name, and it probably shouldn't be a generic field. Or if it is
> >it should named better, and be called something like
> >'DEVLINK_INFO_VERSION_GENERIC_BOARD_CODENAME' instead. I do not know why
> >this was added in the first place, maybe it was a requirement at some
> >point, and I'm hesitant to just remove the user visible field now. But I
> >am happy to keep it local to the driver - it was moved based on Jiri's
> >suggestion - should have provided a better explanation then.
> >
> >"board.id" is not the same thing as "part_number", or at least not closely
> >related anymore. Perhaps it was previously, but I can't find any
> >information on this.
> >
> >"board.id" is the AMDA number, something like AMDA2001-1003, and it gets
> >combined with a few other fields to generate the product_id, exposed as
> >the devlink serial_number field. The AMDA number that is provided in the
> >"board.id" field is still used to identify firmware names from the
> >driver side.
> >
> >"part_number" looks like this: CGX11-A2PSNM. This is a number that is
> >printed on the board, and also a field that can get exposed over BMC by
> >products that supports this.
> >
> >While Fei was preparing the patch there was discussion about using
> >"board.id" instead for the part_number as they do seem quite similar in
> >purpose. The reason why we proposed a new field instead was that the
> >information in "board.id" can still be helpful for identification. If
> >there are some scripts out there that uses the "board.id" field, for
> >example to build up a firmware pathname, replacing it with the
> >"part_number" will break those.
> >
> >V1 of the series did also have the "part_number" in the driver only,
> >Jiri requested moving it to devlink itself.
> >
> >Proposal for V3 - Move both fields back to driver-only, and greatly
> >improve the commit message to explain the difference. Does this sound
> >reasonable?
> 
> Why the "part_number" is specific to you? You say it is a board
> attribute, why don't you have:
> 
> #define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER       "board.part_number"
> ?
I don't know if it is specific to us, that's the thing, maybe it is,
maybe it isn't. What I do know in our case is that "part_number" and
"board.id" is not the same thing, so we would prefer to have both visible.
I cannot comment if that is the case for others, if the concensus is
that others will find this helpful we don't mind adding it to devlink,
as we've done from v1 to v2 - exact naming disussion aside.

Updated proposal after this comment, V3 would then be:
1) Keep "board.model" (the codename) local like it currently exist
in-tree.
2) Do still add "part_number" to devlink, but call it "board.part_number".
Looking at the existing options it probably does fit the closest with
board, it's not "fw", and I don't think it's "asic" either.

Does this sound like the right track?

