Return-Path: <netdev+bounces-85987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D795189D336
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F7F1C21971
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1407EF1F;
	Tue,  9 Apr 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="WTs1uqhW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2092.outbound.protection.outlook.com [40.107.212.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7B7EF03
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647966; cv=fail; b=hJWvHQ4rJz3dsaqmQmk8B0kJAzzwtKczAp8KFT4Ph2Bi5hkMNvALUrJMvCTFV9YR3jNvYoGo4UyEje6jwa+WPVKIzqPcJRiZF4hsc9p5UsrR7CUsy6vMMA7FVoB6Hl3bhKXiiLcDczwAqPcfaQgrG10NIsYBTuvKCmchnC/U81Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647966; c=relaxed/simple;
	bh=LfsYnNYZGUSImQ7kgat5zLJ5v+JxTs22zP8ClwaQCzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WT32z1UFROhMrv7QBzBuHtNIcF+WV4NUVuiFWNcQSe1WWIP9zRoFXqtMvcRlmX0fm4LfaieEuK2v4GKTuvP8dLvdzDO6x9yBO97uTiLzwz2dazPTTGEU2Izl8Vxt718W7Ln1+eDGU38M/9SOJNDN8boChnIQ1QRhOg8Swg2Gbsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=WTs1uqhW; arc=fail smtp.client-ip=40.107.212.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY8dwYsT2c74XDTYv+JwJEl5ljWgdk8AiLuiR8KcBYMUMcu7zXMIDb6HmI4r5O7v0tZ6gsBcwslgM14KOBpVBJt1YCZLgvyTcFWyYxQNCAuU2SViNgYyRxidrFPb0Z7Ir4t44MfvxbD5qzmkE+b+zjrTowN5t/8PEBgkcWkGhX8TKpL+5zVFvdFbtFONsjRR3T91Tto4NjYNbOyZIsWiGASVGJ/aucZCM2ItanpEHVmIoMExDIU3In7I/Kcki2dYGooyUKYIOhVosgSPPCqeUWwYuZslvqadfUf5i7zAzIBqg5UtFbU/UOaVedd3fX2W3jHVaBZMEFGl5Bq4LWEZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmgqBJ4YE0Js8/zqvG4jlsCcbFz4zJb9VtGJWjM8KjU=;
 b=fVzJgxQcNcPwgi2rPa0twH9Ig3oOF0ghskXfk/IVUDejfEHq6/VHlU4UgX+OAK20wiHDRhSP0AYQX/aj11IwaDgbFxMUcdGZWhv/4E4oq8CziwG6+SdgRmKzJjiRF8bip6TOyYk2iQn65IvXIReQ8MDat4Da3OY8/m7n7F9uXCoMngIBsWXai7u/wNKz/0EGzXmlm+wSCODJ5lPN2hmY7N04GMVV6qfhAQpTukeDjkpDZgBoLXd9Wwopz5ezsSWqpjq4OgAYR8Ob0TeAnN1ATSCY8kWrnISXMb6LHG8cQ2I/9umCnW2jBe5VzMpQfscyxJRAgn99PsNduffIy7VJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmgqBJ4YE0Js8/zqvG4jlsCcbFz4zJb9VtGJWjM8KjU=;
 b=WTs1uqhWBLVJtTm41Q2zp06MCwgQzDyV01OcUqtgmXF6vTchaSL/ulnszaA0iF7/EFKFcfti/y1hiBcprK1CbZrE0wdRHL3xp0ES0XhxLQMEd2s1oX8/Ne4BxJRvHabTxQEH01w92EPc9tq1YcYs88a56IJpP52ePfU8FvUTVPQ=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW3PR13MB3930.namprd13.prod.outlook.com (2603:10b6:303:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 07:32:40 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 07:32:40 +0000
Date: Tue, 9 Apr 2024 09:31:32 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 2/4] nfp: update devlink device info output
Message-ID: <ZhTu1HWnduRMdFoo@LouisNoVo>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-3-louis.peens@corigine.com>
 <20240408195815.5e932da3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408195815.5e932da3@kernel.org>
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW3PR13MB3930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p8TefaNOOMVXTSTc2y77Dgr/1emgYGW8yZDfAuPPslA4AF7JDfGTWQmE1+T6/GPPrZjBvpQASGcRduDPbJTwSaQ2pMD8CBZoCKczPT0/qTPWKmkCSEtsuKbsrIIooG06IjmhMrNj2jTgJqWzL4mJXCe4avdBbWlgE8PnE7vva2A6Mw+SO/tro9rf+WrWr5KYjzCm/S4Le/VYGtlQrP9NX3W9j5OpWg9mWzGSlzI77wmCjs8tytkJY11vJ8qXmU6+fbW+If1V2/g2dPNWv3b/bRNnlm4JwpwgUQCZRrHiuzKMYDZldYNz+iP3oHztjjhoNTfMpsPvC3JrdKskoR2zLxyV99Y6s+RmTsTLDXvYdnINO7mcfHDEtmO5Lh+2AcCP7eamQX61wkEkMrAzJggtFWwQXvTxHdtX35pa/Lnbp41r9kOX3tBylPZBIQHkz5WZWipwdTTC7U2hVSy0o6tOvAntrimiW0h8ijeCWDxN5APg5bfCujE6mt4Lx2ym36HAg9b5hOWua4Yt4EHZ1vQ8+64HmrHU089lliqTss58qAx9c/03Ovww6sA/oNfzW6FgrSv54eFOozMGVsmdvFSiuLirhVaMQt+SzeKiMMSVsFTklCBj1zhniGz23TrQo8G542j6EPgw568dyC/GyQqaVnmm0SFk3kLgOuIWyPNA1f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sbm1X4Vf/3MciITRGK/LxHuc/MHIfr23tvoakABuPLT4Q2aepJvt0fGnkCe2?=
 =?us-ascii?Q?TYXeOSE0dY2U8DQ4cxQRt3Ab7ArvGodc9/kVoJbVus0m7bXKrVd+Udd+dfoV?=
 =?us-ascii?Q?oEk9OG6JGW9pYd9HL+4f9nVEUSV4P0WOY60VmzE3yDVaSTXua7HBJQFAZJAL?=
 =?us-ascii?Q?3Ufr9iDXGvEOB5X2F4dJJIhFrZvvhUfXAoNzLD3Ql5BJVTv8OSvqu65cJubh?=
 =?us-ascii?Q?/xKxExbB9iHVmq+5SDnENq2ACZsPVXVHiY+C6OcxBE60IbMq2Kfq9pnG9OO5?=
 =?us-ascii?Q?pIFNWc1NuW2jb/WW6ju/+VY5Qt0/tH79z1PrSGSLL0bnqhu8N27ImpZdfp6X?=
 =?us-ascii?Q?6x8YnQRu4Pjv47JTZ/MfLKqNNgnaOD/bD+spjrBb/NrmTccbdWNKCjK234hJ?=
 =?us-ascii?Q?e3Cj5RRUOsjtiUpRYsBcRjeKSJrKuUpwQ4Vk8sxpS0Gpr+O25Lw0Trpfwt85?=
 =?us-ascii?Q?OCc+WY4lZ9V8AzEWX+tHmq8Wn0bTVGJfKDCwyoaCO6EsekPLjQoCUgCr3Bz1?=
 =?us-ascii?Q?oBh4ECGIKQHZ5L3h90YnAe7oCac4CRIdHDFsSzUstK2W86lWW4+3J/h2ap6u?=
 =?us-ascii?Q?cpBQ0euFEaHcQXNtL7D9ilUza583p7BXr+8UWJAmJCk2dXhUgXZ6FAPn6sMY?=
 =?us-ascii?Q?eUSNrvvDMvCaAZ/WuafuOXwT9Kg5i8T2HgBflunNkzPYEkg5Mn87LYIJ7AhX?=
 =?us-ascii?Q?OZKkAd7ha3pI2ikFKlJJXmA5VY3sDgDgQeDZmnxMxwQYyrejxUMhmPf4muqr?=
 =?us-ascii?Q?e7tau25JEwNndEFWU9WKR2HRH5woDdBxM+VEVH3ruZu1DB7zjywWjpcJcKkb?=
 =?us-ascii?Q?bgNyJbvwH90Jv+iDH+ucysqeyEv2+PRyClimY2Vokc5M3O7OAM291tfH5xUV?=
 =?us-ascii?Q?/3f8Vge3hXX8rE760mGTZX7mHJRJYpaR9aUUpyJfBa8h/wpjjeM3b+Z08UcE?=
 =?us-ascii?Q?vGepBd1ZRB1eeq2TO6hWWNqEWUMPxEI313TD2AGZG6ubBZ3DYgT2AnKwIk3E?=
 =?us-ascii?Q?D6IaiPQLwZhpn90CPa8TDB+t3ib6sYZA1IEBF2ZINgBAi4MoQp0+KsrPLPT+?=
 =?us-ascii?Q?bj94PkhImC0QaUQyMS/YCnMn9fLlcw++3zTfI8rGp1EQYm82nHC8TEwOtKon?=
 =?us-ascii?Q?zkBZ7Btge8dlc5LWbWQvLz5rfDagPNqHtdM3plloTg2vmXYeSH8QeuEI4c01?=
 =?us-ascii?Q?RMxtqJY7PtXkTB1sQJ8qVQdx6mvmzQ4/6rDRN5ej+2besPPJrDZnoYuXUxjO?=
 =?us-ascii?Q?D472pueiP3Rrj23FPQ2QSdVA9VQyHe5/PKMlwxwjYNaXr8zws+TmXo86JsjX?=
 =?us-ascii?Q?YeG8VSYxuQcFLincdhikBGityt17nduPYdlZrNpVpDs0HpTiGVMKbu3ul2B9?=
 =?us-ascii?Q?HBavCSy+VYEnGHeRFpxWA8+k+t16KdA7+0wlOdUQYcocc1SLkMkMRuZcrcCy?=
 =?us-ascii?Q?qW/bPZsEnA0Pjh0GZWKcwEHDJwdMuipxhit+8XQ4adifX0LYoixjJIda5ivt?=
 =?us-ascii?Q?O5MdsTvw+YcuOJcmZzQlvDLwZjhFZMEo9RaWZSIO4/YqfsBxglwXN72y1Waw?=
 =?us-ascii?Q?OYIjX6oluN07X+ucXIHk4jXcJaBUtVBioxFEExlWCMW+ZBdp2CzzcffNq2mC?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff51aa2d-6c6e-4ccc-1d72-08dc58673c4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 07:32:40.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS68+1olosTIig0JD1FtAOgczYFxQlzv5xY6d/vm0vFCwynGHagKZ8shf5hUSdRmUbnKSv4b/D9TLgEmNTdz/Tw016t3JV7+sG5HNu/OcaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3930

On Mon, Apr 08, 2024 at 07:58:15PM -0700, Jakub Kicinski wrote:
> On Fri,  5 Apr 2024 10:15:45 +0200 Louis Peens wrote:
> > +   * - ``board.part_number``
> > +     - fixed
> > +     - Part number of the board design
> 
> Sorry, one more nit. Part number is not "of the board design"
> Part number is a part number, AFAIU it's a customer-facing
> identifier of a product. Let's drop the design or say "of the 
> board and its components"? Since AFAIU part number may also
> change if you replace a component even if you don't have to
> redesign the PCB?

I like "of the board and its components", will update, thanks.

